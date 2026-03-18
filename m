Return-Path: <linux-rdma+bounces-18306-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCBVOFx6ummTWwIAu9opvQ
	(envelope-from <linux-rdma+bounces-18306-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 11:11:40 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9FC2B9AC1
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 11:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D8C530179E0
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 10:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503F23BBA0F;
	Wed, 18 Mar 2026 10:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqCHu+JD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4C13A7F6C;
	Wed, 18 Mar 2026 10:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773828562; cv=none; b=f6jiM7YcvUTcCn1+cLbOHAel+Ve2ifsaAlUHatb+t3zywGXMiQZ3BcX+RdmI7fYSnuIFA5CUdFwTq21NBOV9kKne5JkGv4YKKE7qKo6q2FhRXuEtiex6YVxxLixC7yxIoIWi7Xkd99oYfh3J5UVdD96MxbGMmJeXV7ay0UlODEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773828562; c=relaxed/simple;
	bh=nYnxYvLF3Dihj8EzrVBRYGzBcO8MRUwMzzGujainYzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X3a2+2tDq8RNYow8xjqH78ls7VrHgHvQ/SI5a7NtwdxOQVCa9N4khf+vMyUp0aJvis5YooeGYjbsTHUyWPtGcTtwkSwMmDUdd98SAX5uBs/NY0tH53QMeNXudxOUhthpGtjxp8IXdzYEsARS2Z39Q1ngv/aRhlWojoRRFhKv3so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqCHu+JD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2334EC4AF09;
	Wed, 18 Mar 2026 10:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773828562;
	bh=nYnxYvLF3Dihj8EzrVBRYGzBcO8MRUwMzzGujainYzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HqCHu+JDU8cNUpu7j2tg0fwqLcOff65ylvd0BO7ZVRIXK39odAVEjvXGCnVLUODsA
	 H6N7HZm+Us0TIT8jqdAydqWRkM+bMkM+9HP/Ue/p8qOfKRYnwuawdV3QMS3YFUXyPt
	 6veNmOe8ZCTu6mknv/Xg2r+hEsUG/gjpOqmK+HQf5RWT5BFS4woRx+aLaB+8tYXn4Q
	 SU9YBSKVQbYaiUQGcyBKdFX7lh4pqvFlyAAmsekh1SYF0GHJdKnTH8iEnd5gY5nrS5
	 5FTOD6vTUuvbDVnn8LExgn8Xu9o5Q/xjUksXDwrmJrDo6mbxdSQeu7DoOczpOau8kw
	 q8SHjF1j+juOw==
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 3/4] RDMA/bnxt_re: Replace kcalloc() with kzalloc_objs()
Date: Wed, 18 Mar 2026 12:08:52 +0200
Message-ID: <20260318-bnxt_re-cq-v1-3-381cb1b5e625@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318-bnxt_re-cq-v1-0-381cb1b5e625@nvidia.com>
References: <20260318-bnxt_re-cq-v1-0-381cb1b5e625@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18306-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: 4C9FC2B9AC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Leon Romanovsky <leonro@nvidia.com>

New code should use kzalloc_objs() instead of kcalloc(). Update the driver
accordingly.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index cb53dfdf69bab..1aee4fec137eb 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3486,8 +3486,7 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	cq->qplib_cq.cq_handle = (u64)(unsigned long)(&cq->qplib_cq);
 
 	cq->max_cql = attr->cqe + 1;
-	cq->cql = kcalloc(cq->max_cql, sizeof(struct bnxt_qplib_cqe),
-			  GFP_KERNEL);
+	cq->cql = kzalloc_objs(struct bnxt_qplib_cqe, cq->max_cql);
 	if (!cq->cql)
 		return -ENOMEM;
 
@@ -4413,7 +4412,7 @@ struct ib_mr *bnxt_re_alloc_mr(struct ib_pd *ib_pd, enum ib_mr_type type,
 	mr->ib_mr.lkey = mr->qplib_mr.lkey;
 	mr->ib_mr.rkey = mr->ib_mr.lkey;
 
-	mr->pages = kcalloc(max_num_sg, sizeof(u64), GFP_KERNEL);
+	mr->pages = kzalloc_objs(u64, max_num_sg);
 	if (!mr->pages) {
 		rc = -ENOMEM;
 		goto fail;

-- 
2.53.0


