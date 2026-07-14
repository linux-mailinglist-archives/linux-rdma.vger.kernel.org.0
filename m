Return-Path: <linux-rdma+bounces-23184-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fffKCIzxVWpfwgAAu9opvQ
	(envelope-from <linux-rdma+bounces-23184-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 10:21:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F8C75254F
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 10:21:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=wanadoo.fr header.s=t20230301 header.b="DpSq/w7p";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23184-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23184-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=wanadoo.fr;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 84733301965D
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 08:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8083FA5CB;
	Tue, 14 Jul 2026 08:20:51 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-65.smtpout.orange.fr [80.12.242.65])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1D03FADFA
	for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2026 08:20:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784017245; cv=none; b=FxtfzgSlXQRqJgnyf9QgjzNp7mCm8EQd1mRrZCmxATX9wzllPw5mIiF/bU8VhNBVIuVI92FtV/i/lwzUIaZliP49D2tiJJH7WTZsVxFbZf9PF/FpZN00Xs2BOHnIPK8tksi3VLQjuiXyqnIaxiXDI6pn9duJjfXcvDpaVyC6WWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784017245; c=relaxed/simple;
	bh=XpGwfVzGTr8hfVpHkoISJqYbxLSDQRxHKBbcsKa0Ac4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C/LAtwjiT3vHXECF6M9VjaCRXTKMmKeo3xDc0kHI9ci8pDQpCWxXtAZKNxw6aTHKqc5v1R1V514ZCC7XSMRIJl8K7D51sxQi/K0qOM5XS/X9yoYsEKvih8lVWDr9kxV0lxpZFB7OFSHGNGjMR4iE+CUy7j1tOIHVIMxa08/B9/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=DpSq/w7p; arc=none smtp.client-ip=80.12.242.65
Received: from device-97.home ([10.65.86.67])
	by smtp.orange.fr with ESMTP
	id jYMJwPZcFrxb3jYMJwue9c; Tue, 14 Jul 2026 10:19:19 +0200
Received: from device-97.home ([IPv6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e])
	by smtp.orange.fr with ESMTPSA
	id jYMAw5vkXDzLkjYMAw0U3a; Tue, 14 Jul 2026 10:19:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1784017151;
	bh=GMJi+gTFGDUXh/gZorteniOi+++0sQzYcGVvcoNPxrQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=DpSq/w7pH9YcOc3VZZLFDFh3xoK1JRH0w3xjJ7n5f+RCO61LD7abrFq0xJKkieIsf
	 9F+hgS3Pvs2PBdRKHDQbIiavUQQh9mH+SA/0ep10vuL6Qhxurq/zUVgU6OvnODGx+R
	 qwXJnwfPgEW87sIU8cKHabV0R01tB97MThIDjr9qlYHdG2HUAR5EkNxuk0RmcuBano
	 ivGyJlPcmhIRrCZQO0QEgU/q/GuLeF2DWl3VbCwoRqN8sWfJQLILQx2UpjlURZl9Gs
	 TQNv/1KT6hzlqy7ZGx887PyIZfIUadWw/5BQclHJoE3HIljH49mcG2isPFQifKvD2+
	 5jHSDGLn9mkYQ==
X-ME-Helo: device-97.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 14 Jul 2026 10:19:11 +0200
X-ME-IP: 2a01:cb10:785:b00:26fb:aefb:6cd2:db0e
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-rdma@vger.kernel.org
Subject: [PATCH] RDMA/mlx5: Constify struct ib_frmr_pool_ops and dma_buf_attach_ops
Date: Tue, 14 Jul 2026 10:19:06 +0200
Message-ID: <22f2263c04cc94e242cee712e6e6d82b86ac353d.1784017128.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[wanadoo.fr,quarantine];
	R_DKIM_ALLOW(-0.20)[wanadoo.fr:s=t20230301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,wanadoo.fr];
	FREEMAIL_FROM(0.00)[wanadoo.fr];
	TAGGED_FROM(0.00)[bounces-23184-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@ziepe.ca,m:linux-kernel@vger.kernel.org,m:kernel-janitors@vger.kernel.org,m:christophe.jaillet@wanadoo.fr,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[christophe.jaillet@wanadoo.fr,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christophe.jaillet@wanadoo.fr,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[wanadoo.fr:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 21F8C75254F

'struct ib_frmr_pool_ops' and 'struct dma_buf_attach_ops' are not modified
in this driver.

Constifying these structures moves some data to a read-only section, so
increases overall security, especially when the structure holds some
function pointers.

While at it, change a '1' into a 'true' into the mlx5_ib_dmabuf_attach_ops
structure. The 'allow_peer2peer' field is a bool and other usages of
'struct dma_buf_attach_ops' prefer using true/false.

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  77631	  10392	    320	  88343	  15917	drivers/infiniband/hw/mlx5/mr.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  77759	  10264	    320	  88343	  15917	drivers/infiniband/hw/mlx5/mr.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
---
 drivers/infiniband/hw/mlx5/mr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index e6b74955d95d..00e13028762a 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -339,7 +339,7 @@ static int mlx5r_build_frmr_key(struct ib_device *device,
 	return 0;
 }
 
-static struct ib_frmr_pool_ops mlx5r_frmr_pool_ops = {
+static const struct ib_frmr_pool_ops mlx5r_frmr_pool_ops = {
 	.create_frmrs = mlx5r_create_mkeys,
 	.destroy_frmrs = mlx5r_destroy_mkeys,
 	.build_key = mlx5r_build_frmr_key,
@@ -898,8 +898,8 @@ static void mlx5_ib_dmabuf_invalidate_cb(struct dma_buf_attachment *attach)
 	ib_umem_dmabuf_unmap_pages(umem_dmabuf);
 }
 
-static struct dma_buf_attach_ops mlx5_ib_dmabuf_attach_ops = {
-	.allow_peer2peer = 1,
+static const struct dma_buf_attach_ops mlx5_ib_dmabuf_attach_ops = {
+	.allow_peer2peer = true,
 	.invalidate_mappings = mlx5_ib_dmabuf_invalidate_cb,
 };
 
-- 
2.55.0


