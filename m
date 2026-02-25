Return-Path: <linux-rdma+bounces-17174-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ON2zJyYFn2mZYgQAu9opvQ
	(envelope-from <linux-rdma+bounces-17174-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 15:20:22 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5731989E2
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 15:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8A73A3034E3F
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 14:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F8C3D34A2;
	Wed, 25 Feb 2026 14:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsFqQMuu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291973D3339;
	Wed, 25 Feb 2026 14:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772029186; cv=none; b=G2q2029Y5duGr1thJjOhFN9qh98QKV7YIMtCTJf62NhSoq5EJVEYpGZmyHr1GDq9c1t9I+xWehkjFRH2JzBYO9eD0L2bZC9uXUsZxq2XRUsyBsj0fjEW2iKG8jOpbCDQ2MSG86Sje1vZJFIrT/ItW5SrE/yVLrF4u0HwAZA/14M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772029186; c=relaxed/simple;
	bh=etaHYxLt/5JIsH1N3C/KI0HYP9ONG1wpa9k52evPWv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jXQzjQsDjzNaPynJvTZR+N4BKNGpQeV+ItsB8NGZdOp9xYTADIa7Xbz6YSI51TsMOIae3vapwI/OGNb2wiVcURZiHaNAGfD5Ihsru38Xt+SUy0jSBiPGKKEud/c1Gwm5wrKhGntvkiGepyEh2kyxPUZSg08S01mmlYsSx14lWlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsFqQMuu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A46C19421;
	Wed, 25 Feb 2026 14:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772029185;
	bh=etaHYxLt/5JIsH1N3C/KI0HYP9ONG1wpa9k52evPWv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CsFqQMuu1njdIqaJKlOrH3vBfejTcM1HREafUmiaMjAttytgfvysxY6qYMOFimRrU
	 A7Ks+hX5uOqR+gnfRt6RMPCFDrDDATHKbW6A2fkVByQ3xWAs2zSnVEwLQGEg+Qmr1a
	 1yjWe4dsdsats1K7Zhgq2j+Qi720pqAGqwrB4PBzSNs+hrf3FHwzWR+FxZsfXkDK2y
	 /FEvQULAM44xApVtAYtp0uloBVCQX+WHLOCjY4IAERyXzmwCRkjKPresZVGXzQCKEp
	 cuI21LZw8TmZjoakt9U/VyM04vw01MjRro2jpS25Oo9fnE2G01pJew6igsc5lqDb5J
	 SKffmJkg9fh9g==
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
Subject: [PATCH mlx5-next 1/6] net/mlx5: Add TLP emulation device capabilities
Date: Wed, 25 Feb 2026 16:19:31 +0200
Message-ID: <20260225-var-tlp-v1-1-fe14a7ac7731@nvidia.com>
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
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-17174-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1A5731989E2
X-Rspamd-Action: no action

From: Maher Sanalla <msanalla@nvidia.com>=0D
=0D
Introduce the hardware structures and definitions needed for the driver=0D
support of TLP emulation in mlx5_ifc.=0D
=0D
Signed-off-by: Maher Sanalla <msanalla@nvidia.com>=0D
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>=0D
---=0D
 include/linux/mlx5/mlx5_ifc.h | 23 ++++++++++++++++++++++-=0D
 1 file changed, 22 insertions(+), 1 deletion(-)=0D
=0D
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h=
=0D
index 775cb0c56865..a3948b36820d 100644=0D
--- a/include/linux/mlx5/mlx5_ifc.h=0D
+++ b/include/linux/mlx5/mlx5_ifc.h=0D
@@ -1389,6 +1389,26 @@ struct mlx5_ifc_virtio_emulation_cap_bits {=0D
 	u8         reserved_at_1c0[0x640];=0D
 };=0D
 =0D
+struct mlx5_ifc_tlp_dev_emu_capabilities_bits {=0D
+	u8         reserved_at_0[0x20];=0D
+=0D
+	u8         reserved_at_20[0x13];=0D
+	u8         log_tlp_rsp_gw_page_stride[0x5];=0D
+	u8         reserved_at_38[0x8];=0D
+=0D
+	u8         reserved_at_40[0xc0];=0D
+=0D
+	u8         reserved_at_100[0xc];=0D
+	u8         tlp_rsp_gw_num_pages[0x4];=0D
+	u8         reserved_at_110[0x10];=0D
+=0D
+	u8         reserved_at_120[0xa0];=0D
+=0D
+	u8         tlp_rsp_gw_pages_bar_offset[0x40];=0D
+=0D
+	u8         reserved_at_200[0x600];=0D
+};=0D
+=0D
 enum {=0D
 	MLX5_ATOMIC_CAPS_ATOMIC_SIZE_QP_1_BYTE     =3D 0x0,=0D
 	MLX5_ATOMIC_CAPS_ATOMIC_SIZE_QP_2_BYTES    =3D 0x2,=0D
@@ -1961,7 +1981,7 @@ struct mlx5_ifc_cmd_hca_cap_bits {=0D
 	u8         log_max_rqt[0x5];=0D
 	u8         reserved_at_390[0x3];=0D
 	u8         log_max_rqt_size[0x5];=0D
-	u8         reserved_at_398[0x1];=0D
+	u8         tlp_device_emulation_manager[0x1];=0D
 	u8	   vnic_env_cnt_bar_uar_access[0x1];=0D
 	u8	   vnic_env_cnt_odp_page_fault[0x1];=0D
 	u8         log_max_tis_per_sq[0x5];=0D
@@ -3830,6 +3850,7 @@ union mlx5_ifc_hca_cap_union_bits {=0D
 	struct mlx5_ifc_tls_cap_bits tls_cap;=0D
 	struct mlx5_ifc_device_mem_cap_bits device_mem_cap;=0D
 	struct mlx5_ifc_virtio_emulation_cap_bits virtio_emulation_cap;=0D
+	struct mlx5_ifc_tlp_dev_emu_capabilities_bits tlp_dev_emu_capabilities;=0D
 	struct mlx5_ifc_macsec_cap_bits macsec_cap;=0D
 	struct mlx5_ifc_crypto_cap_bits crypto_cap;=0D
 	struct mlx5_ifc_ipsec_cap_bits ipsec_cap;=0D
=0D
-- =0D
2.53.0=0D
=0D

