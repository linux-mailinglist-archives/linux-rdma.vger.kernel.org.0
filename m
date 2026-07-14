Return-Path: <linux-rdma+bounces-23186-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id azKCD7P3VWpkxAAAu9opvQ
	(envelope-from <linux-rdma+bounces-23186-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 10:47:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DCA7528ED
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 10:47:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=wanadoo.fr header.s=t20230301 header.b=ZPpVjFe6;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23186-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23186-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=wanadoo.fr;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4518F3020BF0
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 08:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9088A43745C;
	Tue, 14 Jul 2026 08:47:42 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-81.smtpout.orange.fr [80.12.242.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8D6426425;
	Tue, 14 Jul 2026 08:47:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784018862; cv=none; b=Z4QIEh7DxOBjY7MwGrHpqvZ5SZVlF+e/eJeY5dksIy4jGwlwVrhbWknZ6vSCi9M7JKGDMfMgPk6Q00afqYPirBj91vb8GBpWbSP2pHTzTL3bvvEqlyqyDOjQNoVaZGxpH5NpS1DJHtJL7hnIg8b4fwLV8lgZVIp495s/i6ApA+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784018862; c=relaxed/simple;
	bh=6qaZdfYOy+9iyb+71Ve4dKx081yx6vTtXmIYF8XxotA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I2DmNRX2cndEHh6mEWHXJthn7ZTDRQbbjR2EYgCwJMt/TjFru5xHxz2l80h6WkDfvNKQh6w9qyAqXkK0KD8qok8J0VXPUW5aLMvGwy3lueFGk0avh1B7auen+udkWh7D18+V8CjN+loT343Tb+Y8ga84ovRryDBO8/hsDvx6WZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ZPpVjFe6; arc=none smtp.client-ip=80.12.242.81
Received: from device-97.home ([IPv6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e])
	by smtp.orange.fr with ESMTPSA
	id jYnhw0xqQOMpTjYnhwjvqt; Tue, 14 Jul 2026 10:47:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1784018858;
	bh=SvCIfrvXBlB6yNdOsBs+WA8UQUHd2lG/ogZfMLbGJf8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ZPpVjFe6V6RXmOwCcRYUaOgpqai/gPommBlgyqtCsPABvqm7cAQcR+p4qZDUydi7N
	 530K8RGGPma2c0WpUh/xIM6ZpDPWM+1of6k+nRJX7jt699G+HbP0k8CMImSq6+tIpu
	 dR9DK+ySUQqd+rOxu5U1c/+jnOnrwJv+WSZSfDPB4i4o4U/PGKBkr1UvV6o5oeKPti
	 3eg5lgH+6s+6t/pdNbeUOnyQQjQMeDsKABHV2Ca1kQ6Y0RA2GxtHkBA5PQ6KaUI/Rh
	 Uo7Wd5Lsk4cRb/BnpYaRJ6T4qEoA48UoTquqNVlBTHxmtAV+/+bWyPIiiEC2o5jKKA
	 W+2mY1szg1SFQ==
X-ME-Helo: device-97.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 14 Jul 2026 10:47:38 +0200
X-ME-IP: 2a01:cb10:785:b00:26fb:aefb:6cd2:db0e
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-rdma@vger.kernel.org
Subject: [PATCH] RDMA/umem: Constify struct dma_buf_attach_ops
Date: Tue, 14 Jul 2026 10:47:32 +0200
Message-ID: <3ca4ace543a02ccfdcce1ba568895c994aad7abb.1784018825.git.christophe.jaillet@wanadoo.fr>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23186-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:kernel-janitors@vger.kernel.org,m:christophe.jaillet@wanadoo.fr,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[christophe.jaillet@wanadoo.fr,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[wanadoo.fr];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,wanadoo.fr];
	DKIM_TRACE(0.00)[wanadoo.fr:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christophe.jaillet@wanadoo.fr,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C5DCA7528ED

'struct dma_buf_attach_ops' are not modified in this driver.

Constifying these structures moves some data to a read-only section, so
increases overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  10300	   1216	      0	  11516	   2cfc	drivers/infiniband/core/umem_dmabuf.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  10428	   1088	      0	  11516	   2cfc	drivers/infiniband/core/umem_dmabuf.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
---
 drivers/infiniband/core/umem_dmabuf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
index ad023c2d84d8..39b5564a4c35 100644
--- a/drivers/infiniband/core/umem_dmabuf.c
+++ b/drivers/infiniband/core/umem_dmabuf.c
@@ -181,7 +181,7 @@ struct ib_umem_dmabuf *ib_umem_dmabuf_get(struct ib_device *device,
 }
 EXPORT_SYMBOL(ib_umem_dmabuf_get);
 
-static struct dma_buf_attach_ops ib_umem_dmabuf_attach_pinned_ops = {
+static const struct dma_buf_attach_ops ib_umem_dmabuf_attach_pinned_ops = {
 	.allow_peer2peer = true,
 };
 
@@ -205,7 +205,7 @@ static void ib_umem_dmabuf_revoke_locked(struct dma_buf_attachment *attach)
 	umem_dmabuf->revoked = 1;
 }
 
-static struct dma_buf_attach_ops ib_umem_dmabuf_attach_pinned_revocable_ops = {
+static const struct dma_buf_attach_ops ib_umem_dmabuf_attach_pinned_revocable_ops = {
 	.allow_peer2peer = true,
 	.invalidate_mappings = ib_umem_dmabuf_revoke_locked,
 };
-- 
2.55.0


