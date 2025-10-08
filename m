Return-Path: <linux-rdma+bounces-13804-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 91234BC61BD
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Oct 2025 19:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9ED454EDB2E
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Oct 2025 16:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6816D2BE65F;
	Wed,  8 Oct 2025 16:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="K73B6Mu2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D122EBB9E
	for <linux-rdma@vger.kernel.org>; Wed,  8 Oct 2025 16:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759942775; cv=none; b=E25ZdWMALEhoYxo6L+1IdpC1rdfMmSMb8CEF+RLOfwLrQELnrKU0NyGWE5BOMKLiFW3m8Zxx+ScKZUQsNGhI323cd8zUCruumsGCSzXbhTVt/RP4PWwdexrY1ildNFcWMLQCTSXcg35DZFETlhiTX0NL68HKdcBA22MhJI5ynDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759942775; c=relaxed/simple;
	bh=CMSX9Q6VRZ0aCU/NHbl/09cIrtSknz2eckwu79Q+5/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HErl26XGZuI8IuoqaBLxI4fJskZCWVZNPjTljKD6ox0m6zxZU1tTDnde7nlAKAPTxi8BZtCITqsrpueXxzOqqrIqoeNBxKEVh/IUPmH8WdDBqH2WbNZqtKwTl1BGL6pj/NJrU4sG+93yLs23u/TH1TDJm1HgupzVJmKH6z6oiqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=K73B6Mu2; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Date:Cc:To:From;
	bh=OPvsxRyQERp4q2b5hanoRHx1Z6/0t6DGui5IAOc642E=; b=K73B6Mu2xJS1LzLMTVONAf16nH
	l57y+jKWoRdCPSd7+B7fRpC+CS1ibjMQDuvsL+Esmrj7e8t7+YryAYiMKoNHrs6d2nlImBn/v93zo
	T+TT/njgbJEK5JgHqpA69krSiTFwzXIcvsFTA3nvURHv7DytV3/5fA7/WRgBwC7Zby49P4bk78m93
	5mwk8JSj/6cQm9/4zJcLd555s3c6TvjpF+L+pnXvtBRRr17J9uw+LBobkWXAL4yl4HAtWnNGSRJdu
	iCNZjR5TBM3NjJA3iqDYrlt2kw9e28tOnx0wHTBkpYBIFR8UOKs7Q9jgPao9PwDgB/jkRbvLi6q/8
	/h0dPiDemlxxDfmifHbIkjszFIiP4xAwhaAAv3f3+fkzE+B17UfR+G0Ll5EO9xLzfX+x6+KdrjPcR
	ElRqbzYFQ817EvHccvjZvBIAvzgBlKWi3DbDkQLgHs0JGqZAaF4eAVmdbKKPX0I2ItuOkpjA9jspt
	8xdewYD9yYl9GYPh5OmSrnEJ;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1v6XVZ-008AZu-2b;
	Wed, 08 Oct 2025 16:59:21 +0000
From: Stefan Metzmacher <metze@samba.org>
To: linux-rdma@vger.kernel.org
Cc: metze@samba.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Subject: [PATCH] RDMA/core: let rdma_connect_locked() call lockdep_assert_held(&id_priv->handler_mutex)
Date: Wed,  8 Oct 2025 18:59:13 +0200
Message-ID: <20251008165913.444276-1-metze@samba.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rdma_accept() also has this, so this is now more consistent and may
prevent bugs in future.

Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
---
 drivers/infiniband/core/cma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 5b2d3ae3f9fc..95e89f5c147c 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -4475,6 +4475,8 @@ int rdma_connect_locked(struct rdma_cm_id *id,
 		container_of(id, struct rdma_id_private, id);
 	int ret;
 
+	lockdep_assert_held(&id_priv->handler_mutex);
+
 	if (!cma_comp_exch(id_priv, RDMA_CM_ROUTE_RESOLVED, RDMA_CM_CONNECT))
 		return -EINVAL;
 
-- 
2.43.0


