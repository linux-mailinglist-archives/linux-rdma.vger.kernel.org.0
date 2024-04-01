Return-Path: <linux-rdma+bounces-1697-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C987893953
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 11:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66BC8B20D44
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 09:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6903A10799;
	Mon,  1 Apr 2024 09:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KXwr7hlb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282891113
	for <linux-rdma@vger.kernel.org>; Mon,  1 Apr 2024 09:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711963051; cv=none; b=I3IlaX2HhlfW9IuC3WMfzrciq2/Qpqab0JVU4IK0LEbD+oveQL95530yNSdRnQbIoFnoGgkSxM9KTaez0tNPbt34has33TXJi+kc/qDFIMfcJNy64kcQvq1Z/tauYn1Bin+SFqNoXhdlqXVwDy2tYOx0sbJm5U3h5sECDQGiUvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711963051; c=relaxed/simple;
	bh=H0SCC8QBtgj+F8HsispuctSLEwUpv6qiKVtiuMI5uTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QEXcyuVUY40aHNt4Y9MfY4jRJW+AiRySKKiCV4QrzvQ1tcyExk9WAkXwGD7aKWycNC40cbcl62c98Pm4kR/Pg/xdMkBZ3YQpkRIMkXE/72bn5BVsC99btpWXncequ/MgJycDVVM2TYhQG1OlMPbmQzOiza07WZ/bF/ljIs9BGJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KXwr7hlb; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d6fd3cfaceso42952891fa.3
        for <linux-rdma@vger.kernel.org>; Mon, 01 Apr 2024 02:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1711963047; x=1712567847; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W+oe0dBhspAlvWJ7koXsb9VjuWFUtHr27rNhbdcylu0=;
        b=KXwr7hlbIyc6WTmJhjvhGuAypQ8SEX3/nN+sAeLk0HvXm9EbfE6YmG+5j1yqZzui7J
         y2P7DeVgp51l6Vmo5pR5tK+Ra+qe70fMhcBQxIJ5fVY4SlqRbBQ8EQsa0N1LZvvV6uxw
         j22fzA59g3trQw6+/p0cROl0hlMhjghcXb75c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711963047; x=1712567847;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W+oe0dBhspAlvWJ7koXsb9VjuWFUtHr27rNhbdcylu0=;
        b=rEsdoDIsoH5HJ1GxdGOfK8hN2kXD6wRYvLmrdipvup0XFjFwEjvFIVUAjwGxsjDhXU
         bsUFWJCV2JaKX3tgPc0C5ndpxq0/MXBAEgLt7krDxhVLYmT0D5xaQ3mpTZnAaf8Og6G0
         4NUm8UwNhNysQ2jZhdfevZWYe/0rRlpiN2xDbb3adF5A+qt+BSybxTTEHNcNHfTQ7G2E
         1PfPh+Vh9xhGLq89G+u7YDXG0UJyltBlXJ5u7WjndVWkYvP4NgJ8hWyJmsnFIpDsJeJg
         Rh6gJPUXQhIBLjHaS1rtJXJqyfNhTPV6renrcjkD7GkCs8hdVDFmK5Ppk6hQ1rHzhQUz
         o6Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWOJaYqTt++VC41jtCbcpxQ6KXKJhRZNGTxd+xI/Iol4FZXBO8b/djSt7FZDPh7QbgUL9iGNz43RUZj0+3pB/kkP+6ZXxBdubHjfQ==
X-Gm-Message-State: AOJu0YxdwDgknaPSKDoosbMDHm6maRz9qiQ7hLSX69ZnJubwWmg0UmTo
	PQXFt2c736BvTmQlaWhes9QiFkEBC6o+RscSo4UHVdoq2xE3HGbQ7SSi1fvrd0Ei99gt7W2KEcK
	dkvGPrjDkGyAlSVOp86Ae8ZKTJUco4hpk7hvmCz1WkqauUU0b7A==
X-Google-Smtp-Source: AGHT+IFNDGRqdsgXpKkTsrsBXOs0zhB6Vye936XG1Ja/v5Uz4XVNqCIxSj4nHBJcBIY6HhvGG++5DWlSJxvbiJXs/+M=
X-Received: by 2002:a2e:911a:0:b0:2d4:714b:4c5d with SMTP id
 m26-20020a2e911a000000b002d4714b4c5dmr6556468ljg.44.1711963047242; Mon, 01
 Apr 2024 02:17:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401090531.574575-1-parav@nvidia.com> <20240401090531.574575-3-parav@nvidia.com>
In-Reply-To: <20240401090531.574575-3-parav@nvidia.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Mon, 1 Apr 2024 14:47:15 +0530
Message-ID: <CAH-L+nOY0A41GBrKw03a1ZLpkppGOKAfYb8VacQ=VyTUzsWdkQ@mail.gmail.com>
Subject: Re: [net-next 2/2] mlx5/core: Support max_io_eqs for a function
To: Parav Pandit <parav@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net, saeedm@nvidia.com, 
	leon@kernel.org, jiri@resnulli.us, shayd@nvidia.com, danielj@nvidia.com, 
	dchumak@nvidia.com, linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Jiri Pirko <jiri@nvidia.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000535f360615057570"

--000000000000535f360615057570
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 1, 2024 at 2:36=E2=80=AFPM Parav Pandit <parav@nvidia.com> wrot=
e:
>
> Implement get and set for the maximum IO event queues for SF and VF.
> This enables administrator on the hypervisor to control the maximum
> IO event queues which are typically used to derive the maximum and
> default number of net device channels or rdma device completion vectors.
>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  .../mellanox/mlx5/core/esw/devlink_port.c     |  2 +
>  .../net/ethernet/mellanox/mlx5/core/eswitch.h |  7 ++
>  .../mellanox/mlx5/core/eswitch_offloads.c     | 94 +++++++++++++++++++
>  3 files changed, 103 insertions(+)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b=
/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
> index d8e739cbcbce..76d1ed93c773 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
> @@ -98,6 +98,8 @@ static const struct devlink_port_ops mlx5_esw_pf_vf_dl_=
port_ops =3D {
>         .port_fn_ipsec_packet_get =3D mlx5_devlink_port_fn_ipsec_packet_g=
et,
>         .port_fn_ipsec_packet_set =3D mlx5_devlink_port_fn_ipsec_packet_s=
et,
>  #endif /* CONFIG_XFRM_OFFLOAD */
> +       .port_fn_max_io_eqs_get =3D mlx5_devlink_port_fn_max_io_eqs_get,
> +       .port_fn_max_io_eqs_set =3D mlx5_devlink_port_fn_max_io_eqs_set,
>  };
>
>  static void mlx5_esw_offloads_sf_devlink_port_attrs_set(struct mlx5_eswi=
tch *esw,
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/=
net/ethernet/mellanox/mlx5/core/eswitch.h
> index 349e28a6dd8d..50ce1ea20dd4 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> @@ -573,6 +573,13 @@ int mlx5_devlink_port_fn_ipsec_packet_get(struct dev=
link_port *port, bool *is_en
>  int mlx5_devlink_port_fn_ipsec_packet_set(struct devlink_port *port, boo=
l enable,
>                                           struct netlink_ext_ack *extack)=
;
>  #endif /* CONFIG_XFRM_OFFLOAD */
> +int mlx5_devlink_port_fn_max_io_eqs_get(struct devlink_port *port,
> +                                       u32 *max_io_eqs,
> +                                       struct netlink_ext_ack *extack);
> +int mlx5_devlink_port_fn_max_io_eqs_set(struct devlink_port *port,
> +                                       u32 max_io_eqs,
> +                                       struct netlink_ext_ack *extack);
> +
>  void *mlx5_eswitch_get_uplink_priv(struct mlx5_eswitch *esw, u8 rep_type=
);
>
>  int __mlx5_eswitch_set_vport_vlan(struct mlx5_eswitch *esw,
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b=
/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> index baaae628b0a0..9d9a06a25cac 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
> @@ -66,6 +66,8 @@
>
>  #define MLX5_ESW_FT_OFFLOADS_DROP_RULE (1)
>
> +#define MLX5_ESW_MAX_CTRL_EQS 4
> +
>  static struct esw_vport_tbl_namespace mlx5_esw_vport_tbl_mirror_ns =3D {
>         .max_fte =3D MLX5_ESW_VPORT_TBL_SIZE,
>         .max_num_groups =3D MLX5_ESW_VPORT_TBL_NUM_GROUPS,
> @@ -4557,3 +4559,95 @@ int mlx5_devlink_port_fn_ipsec_packet_set(struct d=
evlink_port *port,
>         return err;
>  }
>  #endif /* CONFIG_XFRM_OFFLOAD */
> +
> +int mlx5_devlink_port_fn_max_io_eqs_get(struct devlink_port *port, u32 *=
max_io_eqs,
> +                                       struct netlink_ext_ack *extack)
> +{
> +       struct mlx5_eswitch *esw =3D mlx5_devlink_eswitch_nocheck_get(por=
t->devlink);
> +       struct mlx5_vport *vport =3D mlx5_devlink_port_vport_get(port);
> +       int query_out_sz =3D MLX5_ST_SZ_BYTES(query_hca_cap_out);
> +       u16 vport_num =3D vport->vport;
> +       void *query_ctx;
> +       void *hca_caps;
> +       u32 max_eqs;
> +       int err;
> +
> +       if (!MLX5_CAP_GEN(esw->dev, vhca_resource_manager)) {
> +               NL_SET_ERR_MSG_MOD(extack, "Device doesn't support VHCA m=
anagement");
> +               return -EOPNOTSUPP;
> +       }
> +
> +       query_ctx =3D kzalloc(query_out_sz, GFP_KERNEL);
> +       if (!query_ctx)
> +               return -ENOMEM;
> +
> +       mutex_lock(&esw->state_lock);
> +       err =3D mlx5_vport_get_other_func_cap(esw->dev, vport_num, query_=
ctx,
> +                                           MLX5_CAP_GENERAL);
> +       if (err) {
> +               NL_SET_ERR_MSG_MOD(extack, "Failed getting HCA caps");
> +               goto out;
> +       }
> +
> +       hca_caps =3D MLX5_ADDR_OF(query_hca_cap_out, query_ctx, capabilit=
y);
> +       max_eqs =3D MLX5_GET(cmd_hca_cap, hca_caps, max_num_eqs);
> +       if (max_eqs < MLX5_ESW_MAX_CTRL_EQS)
> +               *max_io_eqs =3D 0;
> +       else
> +               *max_io_eqs =3D max_eqs - MLX5_ESW_MAX_CTRL_EQS;
> +out:
[Kalesh]: Missing " kfree(query_ctx);" here?
> +       mutex_unlock(&esw->state_lock);
> +       return 0;
[Kalesh] "return err;" to propagate the error back to the caller?
> +}
> +
> +int mlx5_devlink_port_fn_max_io_eqs_set(struct devlink_port *port, u32 m=
ax_io_eqs,
> +                                       struct netlink_ext_ack *extack)
> +{
> +       struct mlx5_eswitch *esw =3D mlx5_devlink_eswitch_nocheck_get(por=
t->devlink);
> +       struct mlx5_vport *vport =3D mlx5_devlink_port_vport_get(port);
> +       int query_out_sz =3D MLX5_ST_SZ_BYTES(query_hca_cap_out);
> +       u16 vport_num =3D vport->vport;
> +       u16 max_eqs =3D max_io_eqs + MLX5_ESW_MAX_CTRL_EQS;
> +       void *query_ctx;
> +       void *hca_caps;
> +       int err;
> +
> +       if (!MLX5_CAP_GEN(esw->dev, vhca_resource_manager)) {
> +               NL_SET_ERR_MSG_MOD(extack, "Device doesn't support VHCA m=
anagement");
> +               return -EOPNOTSUPP;
> +       }
> +
> +       if (max_io_eqs + MLX5_ESW_MAX_CTRL_EQS > USHRT_MAX) {
> +               NL_SET_ERR_MSG_MOD(extack, "Supplied value out of range")=
;
> +               return -EINVAL;
> +       }
> +
> +       mutex_lock(&esw->state_lock);
> +
> +       query_ctx =3D kzalloc(query_out_sz, GFP_KERNEL);
> +       if (!query_ctx) {
> +               err =3D -ENOMEM;
> +               goto out;
> +       }
> +
> +       err =3D mlx5_vport_get_other_func_cap(esw->dev, vport_num, query_=
ctx,
> +                                           MLX5_CAP_GENERAL);
> +       if (err) {
> +               NL_SET_ERR_MSG_MOD(extack, "Failed getting HCA caps");
> +               goto out_free;
> +       }
> +
> +       hca_caps =3D MLX5_ADDR_OF(query_hca_cap_out, query_ctx, capabilit=
y);
> +       MLX5_SET(cmd_hca_cap, hca_caps, max_num_eqs, max_eqs);
> +
> +       err =3D mlx5_vport_set_other_func_cap(esw->dev, hca_caps, vport_n=
um,
> +                                           MLX5_SET_HCA_CAP_OP_MOD_GENER=
AL_DEVICE);
> +       if (err)
> +               NL_SET_ERR_MSG_MOD(extack, "Failed setting HCA roce cap")=
;
> +
> +out_free:
> +       kfree(query_ctx);
> +out:
> +       mutex_unlock(&esw->state_lock);
> +       return err;
> +}
> --
> 2.26.2
>
>


--=20
Regards,
Kalesh A P

--000000000000535f360615057570
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBWowggRSoAMCAQICDDfBRQmwNSI92mit0zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODI5NTZaFw0yNTA5MTAwODI5NTZaMIGi
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xHzAdBgNVBAMTFkthbGVzaCBBbmFra3VyIFB1cmF5aWwxMjAw
BgkqhkiG9w0BCQEWI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20uY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxnv1Reaeezfr6NEmg3xZlh4cz9m7QCN13+j4z1scrX+b
JfnV8xITT5yvwdQv3R3p7nzD/t29lTRWK3wjodUd2nImo6vBaH3JbDwleIjIWhDXLNZ4u7WIXYwx
aQ8lYCdKXRsHXgGPY0+zSx9ddpqHZJlHwcvas3oKnQN9WgzZtsM7A8SJefWkNvkcOtef6bL8Ew+3
FBfXmtsPL9I2vita8gkYzunj9Nu2IM+MnsP7V/+Coy/yZDtFJHp30hDnYGzuOhJchDF9/eASvE8T
T1xqJODKM9xn5xXB1qezadfdgUs8k8QAYyP/oVBafF9uqDudL6otcBnziyDBQdFCuAQN7wIDAQAB
o4IB5DCCAeAwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZC
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3Iz
cGVyc29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcC
ARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNV
HR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwLmNybDAuBgNVHREEJzAlgSNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29t
LmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGP
zzAdBgNVHQ4EFgQUI3+tdStI+ABRGSqksMsiCmO9uDAwDQYJKoZIhvcNAQELBQADggEBAGfe1o9b
4wUud0FMjb/FNdc433meL15npjdYWUeioHdlCGB5UvEaMGu71QysfoDOfUNeyO9YKp0h0fm7clvo
cBqeWe4CPv9TQbmLEtXKdEpj5kFZBGmav69mGTlu1A9KDQW3y0CDzCPG2Fdm4s73PnkwvemRk9E2
u9/kcZ8KWVeS+xq+XZ78kGTKQ6Wii3dMK/EHQhnDfidadoN/n+x2ySC8yyDNvy81BocnblQzvbuB
a30CvRuhokNO6Jzh7ZFtjKVMzYas3oo6HXgA+slRszMu4pc+fRPO41FHjeDM76e6P5OnthhnD+NY
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcN
AQkEMSIEIBr+DwGEhf2mEP1sbWVt57pjG5ChuZ7udhINsVTBrdCRMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDQwMTA5MTcyN1owaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCUs/wwTrsT
vDJ5wZXkb+f4U6kulIZoK6OQlX/g5unI5etD9RB3iFPChwUMcHMV2wt9fCPZCWSC76zRlFOzNlj2
GQ8NBGqEcWB/yR4ggw/GTB5B1nUMhMZQEoOng0/vmAkRjnhp+KL63X7Ls9SYCmcrUo0sA99z2qGl
naUM0VQP3UVITWWAGZgViXzdSX/e04OkZBQQjXPVhxPAQoaB105lKyw6xP/JAD9EwgBkpcR6pGHk
vy/gXRDJ8cM8vOprAff4luOgoqIr1l572zfCN4g6zMuOdQ1LA5zgLAdg2tpirMf4APE30NV/Y99/
ln1V7IHfEBGTTRnGQLmvWCYa4A1S
--000000000000535f360615057570--

