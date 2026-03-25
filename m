Return-Path: <linux-rdma+bounces-18642-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Gg1CE4oxGmZwgQAu9opvQ
	(envelope-from <linux-rdma+bounces-18642-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 19:24:14 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A8B32A86A
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 19:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E1EB30B6A12
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 18:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2CF315D46;
	Wed, 25 Mar 2026 18:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvuDILxU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A0B317165;
	Wed, 25 Mar 2026 18:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774462571; cv=none; b=kWEc/jDRjG70ohJytrrlfLqF1vNMGr9VFTac8Va02OVtKcvJvSsgBUvm3ouKiyg6TJR5ohCq5OtWbuvO8F4w24oVtQ8aoUnODMsraggn88Yg76+nZKVNE/0YHcF9fY35WArkYfF9hKklE7ry6Wv7kG+w9wNLOK13m+lc6sw0e60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774462571; c=relaxed/simple;
	bh=m7UsOZXePmE6LnIgg7LgNL52WkOjyPU2mtfY4oXXk6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dIAUEixx26eoCrQi8N8PHBolhhx7PMbP7f8oAorIGXtU+CG/e1/OPVujgGFnY4fromEtHHtyUgGlvTeG0c5n+0pCQraHtdrHmA+9/tX/1n8FsH3f1YcNIUCnmikiCphxNl30K/hDv3H8KBt4zxYycXwRWB0gt/o/nk0kwrMlHGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvuDILxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68C4C4CEF7;
	Wed, 25 Mar 2026 18:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774462570;
	bh=m7UsOZXePmE6LnIgg7LgNL52WkOjyPU2mtfY4oXXk6Q=;
	h=From:To:Cc:Subject:Date:From;
	b=rvuDILxU7ssQVP8f5HrIbQ0zB96QPDKdqJPLyg+FBKwdbpwS/Z1TBWx12vCddkzq+
	 ZCsdyKAOacAAYUcANodcwu9rrhN8gH8h9el3qjFjO3e5hJaD89W9M+mUO+a6W0djRz
	 EZqTTkiqE+REXiCfIDmAhREYhsD26bPi/umiRQOJR03gSOKoomOMRkBbu3/RLI/tq6
	 3n5DsT1+IccXuSaupvAB7a6EL9M6/bcrRks6aHsyb0ZVf8lzlybuEjW3bSTcLcPEzp
	 jB3fCrMetgcrXnKSbZO7BL5FsmB/UqLVZ1cgsJKwgMgL4aKNay+DeO/dbw/iHcF7im
	 At6riJtOCnFyQ==
From: Leon Romanovsky <leon@kernel.org>
To: Yishai Hadas <yishaih@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH rdma-next] RDMA/mlx4: Restrict external umem for CQ when copy_to_user() is used
Date: Wed, 25 Mar 2026 20:16:03 +0200
Message-ID: <20260325-fix-mlx4-external-umem-v1-1-1c7c0e779329@nvidia.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260325-fix-mlx4-external-umem-9e8214de61f0
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18642-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 92A8B32A86A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Leon Romanovsky <leonro@nvidia.com>=0D
=0D
When the mlx4 firmware reports the MLX4_DEV_CAP_FLAG2_SW_CQ_INIT capability=
,=0D
libmlx4 from the rdma-core package expects the driver to initialize memory=
=0D
at the address provided in the buf_addr parameter of ucmd.=0D
=0D
This behavior cannot be supported by any external umem implementation, so=0D
restrict it accordingly.=0D
=0D
Fixes: f45f195af521 ("RDMA/mlx4: Introduce a modern CQ creation interface")=
=0D
Reported-by: Jiri Pirko <jiri@nvidia.com>=0D
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>=0D
---=0D
 drivers/infiniband/hw/mlx4/cq.c | 4 ++++=0D
 1 file changed, 4 insertions(+)=0D
=0D
diff --git a/drivers/infiniband/hw/mlx4/cq.c b/drivers/infiniband/hw/mlx4/c=
q.c=0D
index b391883aa4004..6fef3f1724eb9 100644=0D
--- a/drivers/infiniband/hw/mlx4/cq.c=0D
+++ b/drivers/infiniband/hw/mlx4/cq.c=0D
@@ -173,6 +173,10 @@ int mlx4_ib_create_user_cq(struct ib_cq *ibcq,=0D
 		goto err_cq;=0D
 	}=0D
 =0D
+	if (ibcq->umem &&=0D
+	    (dev->dev->caps.flags2 & MLX4_DEV_CAP_FLAG2_SW_CQ_INIT))=0D
+		return -EOPNOTSUPP;=0D
+=0D
 	buf_addr =3D (void *)(unsigned long)ucmd.buf_addr;=0D
 =0D
 	if (!ibcq->umem)=0D
=0D
---=0D
base-commit: 05eec2a60c7909acfbe5b6c5fbb64790d5a3ff1c=0D
change-id: 20260325-fix-mlx4-external-umem-9e8214de61f0=0D
=0D
Best regards,=0D
--  =0D
Leon Romanovsky <leonro@nvidia.com>=0D
=0D

