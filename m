Return-Path: <linux-rdma+bounces-22584-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YswbJmWgQ2rEdgoAu9opvQ
	(envelope-from <linux-rdma+bounces-22584-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 12:54:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5E36E32CF
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 12:54:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Y+HU1MCE;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22584-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22584-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C6D63035FF3
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 10:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69670404891;
	Tue, 30 Jun 2026 10:52:47 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D363A8724;
	Tue, 30 Jun 2026 10:52:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816766; cv=none; b=jgk14wNCnUWg2Xt1pk+oQUrZCGDxJoBTg+b1qohgr7U3qfwLt1G20gyH3HdfFVe0UYv685HMF7qTnNLhAn6T3XC6Wzzd7xVFt/549LOIjldOvDAVumJuWnbB1C1kHxrlCT+JN8s6RK0dJQ8GAv+0g9NLEA/mnwIRRBzEjtEz5tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816766; c=relaxed/simple;
	bh=S5WDjUlgtbBIhVPEQY8QOs2RJfuNxo6aUxcl9Ilcxa4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uZf/G/0foNqncKzTPxAxFBH4J+v5Jhp6DMZYT8o7zQCM/W9WeTPnC8soOxX4S0OElgGgQ4zvUWnsZA25qXBRasRLkQ4m0XI6DJvRjX7+E56ON0OL7rAjDGU6AN9m3FpuE5/aC/wFfOs3GrJTegs+GXKrtgMO/h+eCrrtXBL40CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+HU1MCE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCBB41F00A3D;
	Tue, 30 Jun 2026 10:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782816758;
	bh=9y4x9Z9LfAleq5MGRjUEHqlQfJrq4x0loQabN6bGIV4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Y+HU1MCE4pGfbvjbc9ZSs/nVI7sjDU6dz1seknt/Us0d3sLTr9zJdowDj5hBIttmN
	 guYqW4UWVgRhsGgr246USmDBhEpu+61v09ZrBf3HpO3RwdLQHBcCFlT4TRJTWN8qJo
	 rOMZtZj1Hrjd/8VUZdhpiVx53YN6SfAjoWoMNQuTFzxcxEVxLfJlu8g6oxN1eWJY0z
	 fTEUV1ZAkWf5tI/DEGaMWWHNp4KfV5Oapd/VV5CTRo8V/I9jtQ3aJ3Bwb4sJuTFUBE
	 sGR0jYPCObvA4sMpSAjxDUvwZ6knEHIaOWcH/yl6RNcytcbvCeupTEm3QFhXZEoSsM
	 aLNCXdRUf688Q==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Tue, 30 Jun 2026 13:52:30 +0300
Subject: [PATCH 2/5] RDMA/mlx5: replace __get_free_page() with kmalloc()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-b4-rdma-v1-2-ab42bcf0de92@kernel.org>
References: <20260630-b4-rdma-v1-0-ab42bcf0de92@kernel.org>
In-Reply-To: <20260630-b4-rdma-v1-0-ab42bcf0de92@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
 Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-rdma@vger.kernel.org
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22584-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:dennis.dalessandro@cornelisnetworks.com,m:rppt@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[rppt@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E5E36E32CF

mlx5_ib_mr_wqe_pfault_handler() allocates a scratch buffer for
parsing work queue entries during page fault handling.

This buffer can be allocated with kmalloc() as there's nothing special
about it to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

Replace use of __get_free_page() with kmalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/infiniband/hw/mlx5/odp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 1badec9bf527..90706ff7102a 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -38,6 +38,7 @@
 #include <linux/hmm-dma.h>
 #include <linux/pci-p2pdma.h>
 
+#include <linux/slab.h>
 #include "mlx5_ib.h"
 #include "cmd.h"
 #include "umr.h"
@@ -1414,7 +1415,7 @@ static void mlx5_ib_mr_wqe_pfault_handler(struct mlx5_ib_dev *dev,
 		goto resolve_page_fault;
 	}
 
-	wqe_start = (void *)__get_free_page(GFP_KERNEL);
+	wqe_start = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!wqe_start) {
 		mlx5_ib_err(dev, "Error allocating memory for IO page fault handling.\n");
 		goto resolve_page_fault;
@@ -1475,7 +1476,7 @@ static void mlx5_ib_mr_wqe_pfault_handler(struct mlx5_ib_dev *dev,
 		    pfault->wqe.wq_num, resume_with_error,
 		    pfault->type);
 	mlx5_core_res_put(res);
-	free_page((unsigned long)wqe_start);
+	kfree(wqe_start);
 }
 
 static void mlx5_ib_mr_rdma_pfault_handler(struct mlx5_ib_dev *dev,

-- 
2.53.0


