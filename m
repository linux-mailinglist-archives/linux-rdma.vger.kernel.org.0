Return-Path: <linux-rdma+bounces-22587-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jThfJHOiQ2r5dwoAu9opvQ
	(envelope-from <linux-rdma+bounces-22587-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 13:03:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 208D86E34DD
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 13:03:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RGNFYGn4;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22587-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22587-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40E5D31C2D54
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 10:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4D94071E3;
	Tue, 30 Jun 2026 10:52:54 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746C4403B1F;
	Tue, 30 Jun 2026 10:52:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816773; cv=none; b=nw43j5tL/ZHpwZVqP/qWf4/udFT5dQfLLCaBo91Y7sW8hrmfncVIc4wcFDRKGEShHFTvsH35Ba1GMBxkNbnAUCjy4cz1dZXI17CAS3UBI27QmNCSin5liYg6qK/RNezS0C0yFb1Mg+VyZK3XvetF0pG7uk3p42W8MNYF2cpn0E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816773; c=relaxed/simple;
	bh=d2PjGOPWCKsDBhAPZ5RLuCJg2M92mnw/3ry5e803xJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NRDAIeQIevT3oywIsuMR2Gj8Z7m3vm4/uLt/mVysBAPJ2YDJOMf/PK6X9FL20wFsbEZ/CyW7HSW9ySp/y2SY5HUu82LlXHb+KGjh8Ep2hmKfb//ewJzDk392D3AvBUbimlrgtWt6miPWHv5u0ur2pmFPWAhoxUzjPhcedeY5mpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGNFYGn4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254991F000E9;
	Tue, 30 Jun 2026 10:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782816764;
	bh=Hwd078SfSbWqZ8yo3wjpm66Fjg9WDFy+fTRvcAm+UkM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RGNFYGn4CtkTg1zqvbtwpm2QX2akkhLXZUldJcQh/wY6BJIcZyWcOuEOJYmNcq5Lj
	 Uj6Bh+yCkzkhs31qbnmwB/PtXdrbvnMqxlvi6wknmB/78qy1R/PukrrJGqmOB69yGp
	 Iedr10mzuTFMWuNNp+qNCDQiG7xROGfltWMA1ONZfMbFYa0qXUFzGxqjRCfwFEP6z7
	 vh4O3pxi/BJb0+UedVdyG6n1f4hyrZzKDVL+WNrdwRrlRNF0r6evBD/7tKTdhNwzMF
	 RJ8vOKlRXWraalDy2C6grQ5T2M1hKnbvVmrkDw6wWipuGgJ8dcKGY7we8g6o5YZhgo
	 Kudt8R1xEuw7w==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Tue, 30 Jun 2026 13:52:33 +0300
Subject: [PATCH 5/5] IB/rdmavt: use kzalloc() to allocate QPN-map pages
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-b4-rdma-v1-5-ab42bcf0de92@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22587-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 208D86E34DD

get_map_page() allocates bitmap pages using get_zeroed_page().

The bitmaps can be allocated with kmalloc() as there's nothing special
about them to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

Replace use of get_zeroed_page() with kzalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/infiniband/sw/rdmavt/qp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index 70e7d08fdce6..c40cce69e945 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -263,7 +263,7 @@ static inline bool wss_exceeds_threshold(struct rvt_wss *wss)
 static void get_map_page(struct rvt_qpn_table *qpt,
 			 struct rvt_qpn_map *map)
 {
-	unsigned long page = get_zeroed_page(GFP_KERNEL);
+	void *page = kzalloc(PAGE_SIZE, GFP_KERNEL);
 
 	/*
 	 * Free the page if someone raced with us installing it.
@@ -271,9 +271,9 @@ static void get_map_page(struct rvt_qpn_table *qpt,
 
 	spin_lock(&qpt->lock);
 	if (map->page)
-		free_page(page);
+		kfree(page);
 	else
-		map->page = (void *)page;
+		map->page = page;
 	spin_unlock(&qpt->lock);
 }
 
@@ -343,7 +343,7 @@ static void free_qpn_table(struct rvt_qpn_table *qpt)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(qpt->map); i++)
-		free_page((unsigned long)qpt->map[i].page);
+		kfree(qpt->map[i].page);
 }
 
 /**

-- 
2.53.0


