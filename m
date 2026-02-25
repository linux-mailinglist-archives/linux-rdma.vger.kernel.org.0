Return-Path: <linux-rdma+bounces-17175-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Az5DywFn2mZYgQAu9opvQ
	(envelope-from <linux-rdma+bounces-17175-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 15:20:28 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 032DE1989F0
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 15:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E439E3038016
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 14:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F883D333D;
	Wed, 25 Feb 2026 14:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z28al3w+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DCA194C96;
	Wed, 25 Feb 2026 14:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772029189; cv=none; b=mrcp0wshDfvI04/Jbf2qSohgSYxsQ0XQvOT6X2ICi4/SrsQ/0MbFt+becAmuv6YBzr2LUBxDM9p5KiU4jTz3F/uQZ3sc9H+e1l5+yLkusYo+cCdQFYdebLxapm8IbqHF97xw3YRemC5PhoHHeaFxGklKF8anxwrN2SGuk72uAYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772029189; c=relaxed/simple;
	bh=LjkNyi4+8af+Iol0lcnNqKS0v5jJtDVE376oijPOWrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xv0xtYVrc4VSM8FXY5jI9JpGJwwQQnqYfPiH+ve2/cTK9MeRoDovaR62ZFx+RM70M5iqi06VsjpwQm786R3Ytwh/Uvj8KcyBiEBiBNuob93Y/cPEQmVpurtNfk7hm542HqzglJc4YDDR5I5vni+orpp41Vde9pQk8EEQxh3+bHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z28al3w+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF7FC116D0;
	Wed, 25 Feb 2026 14:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772029189;
	bh=LjkNyi4+8af+Iol0lcnNqKS0v5jJtDVE376oijPOWrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z28al3w+yk1NqXv1mwU0z1g2He27OuimviiVNuR6oGDZIGnHRYJ1VG3JI7arcondh
	 qxcEANDgPMWfy7QqGvqeKeqo45FEW/Wdo/RdUXqZOlM80OyhhTNAtNlYhlsyxP/X3e
	 /gBgN7YGQ6OfcS0+74cAXxB9bbgzYooUT8LD+gDn9yb01GYsjBfyQJ+lQv1CZ86J6e
	 ex1iqlnbkfO1n3ZEyq+Bz5CIJthTCzyuUOatAWZNHhoGE6itstqD/KL27q2TaisSEA
	 enDQ7cdeZuNTpMKmdQDCB+omC41frde6TccD2VBXS/H92Gnove0clKmUOZCaDCfyCg
	 czZzqp+jHkGcQ==
From: Leon Romanovsky <leon@kernel.org>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maher Sanalla <msanalla@nvidia.com>
Subject: [PATCH mlx5-next 2/6] net/mlx5: Expose TLP emulation capabilities
Date: Wed, 25 Feb 2026 16:19:32 +0200
Message-ID: <20260225-var-tlp-v1-2-fe14a7ac7731@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225-var-tlp-v1-0-fe14a7ac7731@nvidia.com>
References: <20260225-var-tlp-v1-0-fe14a7ac7731@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-47773
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_MATCH_TO(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17175-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 032DE1989F0
X-Rspamd-Action: no action

From: Maher Sanalla <msanalla@nvidia.com>=0D
=0D
Expose and query TLP device emulation caps on driver load.=0D
=0D
Signed-off-by: Maher Sanalla <msanalla@nvidia.com>=0D
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>=0D
---=0D
 drivers/net/ethernet/mellanox/mlx5/core/fw.c   | 6 ++++++=0D
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 1 +=0D
 include/linux/mlx5/device.h                    | 9 +++++++++=0D
 3 files changed, 16 insertions(+)=0D
=0D
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw.c b/drivers/net/eth=
ernet/mellanox/mlx5/core/fw.c=0D
index eeb4437975f2..55249f405841 100644=0D
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw.c=0D
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw.c=0D
@@ -255,6 +255,12 @@ int mlx5_query_hca_caps(struct mlx5_core_dev *dev)=0D
 			return err;=0D
 	}=0D
 =0D
+	if (MLX5_CAP_GEN(dev, tlp_device_emulation_manager)) {=0D
+		err =3D mlx5_core_get_caps_mode(dev, MLX5_CAP_TLP_EMULATION, HCA_CAP_OPM=
OD_GET_CUR);=0D
+		if (err)=0D
+			return err;=0D
+	}=0D
+=0D
 	if (MLX5_CAP_GEN(dev, ipsec_offload)) {=0D
 		err =3D mlx5_core_get_caps_mode(dev, MLX5_CAP_IPSEC, HCA_CAP_OPMOD_GET_C=
UR);=0D
 		if (err)=0D
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/e=
thernet/mellanox/mlx5/core/main.c=0D
index fdc3ba20912e..b0bc4a7d4a93 100644=0D
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c=0D
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c=0D
@@ -1772,6 +1772,7 @@ static const int types[] =3D {=0D
 	MLX5_CAP_CRYPTO,=0D
 	MLX5_CAP_SHAMPO,=0D
 	MLX5_CAP_ADV_RDMA,=0D
+	MLX5_CAP_TLP_EMULATION,=0D
 };=0D
 =0D
 static void mlx5_hca_caps_free(struct mlx5_core_dev *dev)=0D
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h=0D
index b37fe39cef27..25c6b42140b2 100644=0D
--- a/include/linux/mlx5/device.h=0D
+++ b/include/linux/mlx5/device.h=0D
@@ -1259,6 +1259,7 @@ enum mlx5_cap_type {=0D
 	MLX5_CAP_PORT_SELECTION =3D 0x25,=0D
 	MLX5_CAP_ADV_VIRTUALIZATION =3D 0x26,=0D
 	MLX5_CAP_ADV_RDMA =3D 0x28,=0D
+	MLX5_CAP_TLP_EMULATION =3D 0x2a,=0D
 	/* NUM OF CAP Types */=0D
 	MLX5_CAP_NUM=0D
 };=0D
@@ -1481,6 +1482,14 @@ enum mlx5_qcam_feature_groups {=0D
 	MLX5_GET64(virtio_emulation_cap, \=0D
 		(mdev)->caps.hca[MLX5_CAP_VDPA_EMULATION]->cur, cap)=0D
 =0D
+#define MLX5_CAP_DEV_TLP_EMULATION(mdev, cap)\=0D
+	MLX5_GET(tlp_dev_emu_capabilities, \=0D
+		(mdev)->caps.hca[MLX5_CAP_TLP_EMULATION]->cur, cap)=0D
+=0D
+#define MLX5_CAP64_DEV_TLP_EMULATION(mdev, cap)\=0D
+	MLX5_GET64(tlp_dev_emu_capabilities, \=0D
+		(mdev)->caps.hca[MLX5_CAP_TLP_EMULATION]->cur, cap)=0D
+=0D
 #define MLX5_CAP_IPSEC(mdev, cap)\=0D
 	MLX5_GET(ipsec_cap, (mdev)->caps.hca[MLX5_CAP_IPSEC]->cur, cap)=0D
 =0D
=0D
-- =0D
2.53.0=0D
=0D

