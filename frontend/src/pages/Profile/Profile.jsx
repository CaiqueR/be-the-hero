import React, { useEffect, useState } from "react";
import { Link, useHistory } from "react-router-dom";
import { FiPower, FiTrash2, FiLoader } from "react-icons/fi";

import api from "../../services/api";
import "./Profile.css";
import logoImg from "../../assets/logo.svg";

export function Profile() {
  const [incidents, setIncidents] = useState([]);
  const [isLoading, setIsLoading] = useState(true);

  const history = useHistory();

  const ongId = localStorage.getItem("ongId");
  const ongName = localStorage.getItem("ongName");

  useEffect(() => {
    api.get("profile", { headers: { Authorization: ongId } }).then(response => {
      setIncidents(response.data);
      setIsLoading(false);
    });
  }, [ongId]);

  async function handleDeleteIncident(id) {
    try {
      await api.delete(`incidents/${id}`, {
        headers: { Authorization: ongId }
      });
    } catch (err) {
      alert("Erro ao tentar deletar caso, tente novamente.");
    }

    setIncidents(incidents.filter(incident => incident.id !== id));
  }

  function handleLougout() {
    localStorage.clear();
    history.push("/");
  }

  return (
    <div className="profile-container">
      <header>
        <img src={logoImg} alt="Be The Hero" />
        <span>Bem vinda, {ongName}</span>

        <Link className="button" to="/incidents/new">
          Cadastrar novo caso
        </Link>

        <button type="button" onClick={handleLougout}>
          <FiPower size={18} color="#e02041" />
        </button>
      </header>

      {isLoading ? (
        <FiLoader size={20} className="icon-spin" />
      ) : (
        <>
          <h1>Casos cadastrados</h1>

          <ul>
            {incidents.length > 0 ? (
              incidents.map(incident => (
                <li key={incident.id}>
                  <strong>CASO:</strong>
                  <p>{incident.title}</p>

                  <strong>DESCRIÇÃO:</strong>
                  <p>{incident.description}</p>

                  <strong>VALOR:</strong>
                  <p>
                    {Intl.NumberFormat("pt-BR", {
                      style: "currency",
                      currency: "BRL"
                    }).format(incident.value)}
                  </p>

                  <button
                    type="button"
                    onClick={() => handleDeleteIncident(incident.id)}
                  >
                    <FiTrash2 size={20} color="#a8a8b3" />
                  </button>
                </li>
              ))
            ) : (
              <h4>Não há nenhum caso cadastrado ainda.</h4>
            )}
          </ul>
        </>
      )}
    </div>
  );
}
