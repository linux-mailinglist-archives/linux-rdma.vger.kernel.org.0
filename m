Return-Path: <linux-rdma+bounces-23283-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hGm+OQGfV2opYAAAu9opvQ
	(envelope-from <linux-rdma+bounces-23283-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 16:53:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF5475F9E4
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 16:53:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=BaIETx6a;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23283-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23283-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3C0F3222721
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 14:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C493B39CD05;
	Wed, 15 Jul 2026 14:35:49 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37053399348
	for <linux-rdma@vger.kernel.org>; Wed, 15 Jul 2026 14:35:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784126149; cv=none; b=j2HbhlyhWNggIcYrBtAVMByZauFvmX5gA1jH+I9OVXjcvcougUTr5+M7wuCBYLy6+/MRVe/Cdm8RL/+UEHAODSBA5Y1sJ5VL8ewkdyPEwu+jF9/87yvMCslMLVvlGzja8aCiV2ioGkG3X9pioPf8W6LDvGVUIPEFYFK4Vm6Et4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784126149; c=relaxed/simple;
	bh=Y54nOIx9mMVxcTwhAtaUtY293lG/py/OCs16JGVD36U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CUrFo2S6URVLOdXUQwxldP0nu98DPHfyR/0ceyj011JVgoXOBwcNUeXmo05gSEqANaG3LrTfFpFENnaFui6XAyZg+eWzzu/WOgmAvaSH3tGpHvyiCdthQq1bIiKzYZE4PNTKK1pZ0uglpiELSN1nQasQ1d/F8MCmrKWWnkICe/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BaIETx6a; arc=none smtp.client-ip=209.85.210.201
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-848474825ffso3144426b3a.0
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jul 2026 07:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784126147; x=1784730947; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=du9357juXhGcu9dn4Att57AwyAuxnwB17QWxTnC6+90=;
        b=BaIETx6aGygg4xeUY0oC1Ghf1vjeompR967szGpsOqlpvd2LVfOFr6p1nfVH0TTB9F
         7bOu5K4Pum9Ge0t5dm0lQh6DndhVcEDLBRHW+YKPANdzHg1OQCp9XcdI4A0Dsn7bdv3v
         QnNg93V6R8Q64zo4USFMOXtN5vwE6b9h7NP1pSGZj+o+lVMoH6f1qiv7NdxJDAS0Wc6n
         QtIXNVEeeKpObXmwc6IwMJBM1d9NnmAzTJNfGG3N05192StvCyXtujQ6Ho4WtcDDLnMm
         maCpExbdXuduNgsUSIDKkfZfw76E3w8pLr/m+EwRqkW49FsA6CM3frjwvUPtTnuosCiz
         l7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784126147; x=1784730947;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=du9357juXhGcu9dn4Att57AwyAuxnwB17QWxTnC6+90=;
        b=bGtTohgcQ0eq4eumRhOLcGEfashsXOL+FYJ7FuEFFAP2ncIVvKvvm6jPzyfDm8pLUR
         ttjb2g1opHHQhauoh8zI9nXqDXQA90mb3pO4mvdJMpH1ASBjqFNDLLFpdvmEjKctJW6f
         LhvEesaoqPKblajrX3q3JKDDyX1ejFP5TgxB6dYeiH9nD1I0Lbz3rqXIDJLHs/TkyRMr
         PrlTEV5YNwNFRkh9SXG0tD0BHEwDHqdeKrbZapyLqXAsXoqTzI0dbUpY2YHPE7t8Dxaw
         hjI2fkHLXJucuq+v9bT8uU1BYTDasNNC/yTzTaM9DnUWrdGGTRerX6hSIe4t99C+3ksP
         tkmA==
X-Forwarded-Encrypted: i=1; AHgh+RraDgY48J364mYUaqzKmNufI5iarVcglnHfhUjpLuGbcjEUJCkSf+v9L8L3K/GEqmO5bmvs1SY+WfmE@vger.kernel.org
X-Gm-Message-State: AOJu0YwcVYichoVBV6A3redbr5bIay2C1AIW2v7F2jn7v/3IkKod2lbK
	6LXI6SmXXo3kL1vbHUXQJgFP+m5s+nZy4CZAfTMTAp9fq2eGHAXZL87D3Sb5MYVmOWRdQRqeV2L
	Fvg==
X-Received: from pfwz12.prod.google.com ([2002:a05:6a00:1d8c:b0:847:ac08:fdf6])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:88c9:0:b0:847:b45b:fef3
 with SMTP id d2e1a72fcca58-8488acd4d8amr16851338b3a.27.1784126147105; Wed, 15
 Jul 2026 07:35:47 -0700 (PDT)
Date: Wed, 15 Jul 2026 14:35:37 +0000
In-Reply-To: <20260715143540.3597616-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260715143540.3597616-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260715143540.3597616-3-praan@google.com>
Subject: [PATCH v3 2/5] nfs: Track number of pinned pages in nfs_page
From: Pranjal Shrivastava <praan@google.com>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Logan Gunthorpe <logang@deltatee.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Shivaji Kant <shivajikant@google.com>, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:cel@kernel.org,m:jlayton@kernel.org,m:linux-kernel@vger.kernel.org,m:hch@lst.de,m:logang@deltatee.com,m:jgg@ziepe.ca,m:linux-pci@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:shivajikant@google.com,m:praan@google.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[praan@google.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-23283-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5CF5475F9E4
X-Rspamd-Action: no action

Track the number of pinned pages in nfs_page to handle unpinning
correctly, ensuring that only primary requests perform the final
unpinning operation, preventing subrequests from incorrectly
performing unpinning on behalf of their parent requests.

Add wb_nr_pinned to struct nfs_page to store the count of pinned pages
owned by the request. Update request creation and cleanup helpers to
initialize and use wb_nr_pinned for primary requests. Use the
nfs_page_array_len() helper to calculate the number of pages spanned
by a request's offset and length.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 fs/nfs/pagelist.c        | 9 +++++++--
 include/linux/nfs_page.h | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index faa8bc1c6526..7d51e10fe97a 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -455,6 +455,8 @@ struct nfs_page *nfs_page_create_from_page(struct nfs_open_context *ctx,
 			      offset_in_page(offset), count);
 	if (!IS_ERR(ret)) {
 		nfs_page_assign_page(ret, page, pinned);
+		if (pinned)
+			ret->wb_nr_pinned = 1;
 		nfs_page_group_init(ret, NULL);
 	}
 	nfs_put_lock_context(l_ctx);
@@ -487,6 +489,9 @@ struct nfs_page *nfs_page_create_from_folio(struct nfs_open_context *ctx,
 	ret = nfs_page_create(l_ctx, offset, folio->index, offset, count);
 	if (!IS_ERR(ret)) {
 		nfs_page_assign_folio(ret, folio, pinned);
+		if (pinned)
+			ret->wb_nr_pinned = nfs_page_array_len(offset_in_page(offset),
+							      count);
 		nfs_page_group_init(ret, NULL);
 	}
 	nfs_put_lock_context(l_ctx);
@@ -565,14 +570,14 @@ static void nfs_clear_request(struct nfs_page *req)
 
 	if (folio != NULL) {
 		if (test_and_clear_bit(PG_PINNED, &req->wb_flags))
-			unpin_user_folio(folio, 1);
+			unpin_user_folio(folio, req->wb_nr_pinned);
 		else
 			folio_put(folio);
 		req->wb_folio = NULL;
 		clear_bit(PG_FOLIO, &req->wb_flags);
 	} else if (page != NULL) {
 		if (test_and_clear_bit(PG_PINNED, &req->wb_flags))
-			unpin_user_page(page);
+			unpin_user_pages(&page, req->wb_nr_pinned);
 		else
 			put_page(page);
 		req->wb_page = NULL;
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index fd7aafe7cb54..080fa3e23580 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -59,6 +59,7 @@ struct nfs_page {
 	struct nfs_page		*wb_this_page;  /* list of reqs for this page */
 	struct nfs_page		*wb_head;       /* head pointer for req list */
 	unsigned short		wb_nio;		/* Number of I/O attempts */
+	unsigned int		wb_nr_pinned;	/* Number of pinned pages */
 };
 
 struct nfs_pgio_mirror;
-- 
2.55.0.229.g6434b31f56-goog


