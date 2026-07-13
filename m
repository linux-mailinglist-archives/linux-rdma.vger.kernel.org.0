Return-Path: <linux-rdma+bounces-23090-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G/yzMbyRVGotngMAu9opvQ
	(envelope-from <linux-rdma+bounces-23090-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 09:20:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D71474800D
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 09:20:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=c9FME1wu;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23090-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23090-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F64B304125F
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 07:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77C438D3ED;
	Mon, 13 Jul 2026 07:17:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32E2389DF0;
	Mon, 13 Jul 2026 07:17:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927058; cv=none; b=CwWJnZRGENSpTKpkQezoPF7otabZep1LQnH7xDiknyQurpUqPbNAK7nu4jG4dMQor872F1lqSE0uXNWZuoLJkQB+/KAYEF2SHChk1/kIYThCo9e7Jw5H28w17VLgXR2twYaRrsBB+Mx+xl2hs3wweuiLsc4vFkTZ4Rx/SPNoXlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927058; c=relaxed/simple;
	bh=d2PjGOPWCKsDBhAPZ5RLuCJg2M92mnw/3ry5e803xJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ixGrtNyV6g0W+hedPCAKy2wIsDCstdF3GrXQdpeb/c+HQlN25X2XshQn+olj2lR0exXgUsj2r5Aqtpbqr7SZrws/vp5whKcXzeD+du5KBBc+sg2NgR7DcksroRQ30iNxh8N2sFu24r9DZj8vwQLflZOD8Qvd8rbjJIKVfhSkBYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9FME1wu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64831F000E9;
	Mon, 13 Jul 2026 07:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783927057;
	bh=Hwd078SfSbWqZ8yo3wjpm66Fjg9WDFy+fTRvcAm+UkM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=c9FME1wuvshe3JefH5fc97yCGfSFLGlyfQzbOqHbZMegRzb6k0zRSqdoNrDOGZ2zb
	 3X2+AdpAPwaU7vPT+62vsFrLJjiYMLudeaBWOkEBsbpYvs0rR1bSH9GzMkF1OAIG5P
	 H6X29dIgl++yuwSSuhWdv+BllCwsbq0v+JtdUSdonTMSP7LmtSgLmBGNCIkKeCcX6i
	 65wvtmHS5YiG/T+pbng49tkH8CimMMrTJ8QK4prOID/vFKcuv0pMP1huakRgLsIDwK
	 ybdD81PM9GOz/IsGRk2VbWGO6DhdFIX2++f+da0P+mi6dBYZHaPfM6/tZ8HT2VO0pm
	 Gg/Zfvl3jAXQQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Mon, 13 Jul 2026 10:17:26 +0300
Subject: [PATCH v2 5/5] IB/rdmavt: use kzalloc() to allocate QPN-map pages
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-b4-rdma-v2-5-65d2a1a5180c@kernel.org>
References: <20260713-b4-rdma-v2-0-65d2a1a5180c@kernel.org>
In-Reply-To: <20260713-b4-rdma-v2-0-65d2a1a5180c@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
 Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-rdma@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23090-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D71474800D

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


