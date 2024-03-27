Return-Path: <linux-rdma+bounces-1624-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FDE88F131
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Mar 2024 22:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B9E529E27C
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Mar 2024 21:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60552153BCB;
	Wed, 27 Mar 2024 21:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GrhrOBZR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC25A153822
	for <linux-rdma@vger.kernel.org>; Wed, 27 Mar 2024 21:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711575932; cv=none; b=AkCdNU8NSWmYLbcpOItcfjNaS2lESvtIBvehXhQMOp/5l1WoI+nYByzQUDVWDbEnJoS7hLZgWVXJifs8mXGsmFJchLNs7W6Ex66M11pvmO0iJ/GgkX+MNpbi6JT6+B1Si3yURIRWGcBnegvChTTb8cqugVGxDbE3a1MttlLaswo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711575932; c=relaxed/simple;
	bh=Rak+tbVGAvFieKkSB/eo4ljeZ0A/D+7QGjSJN/aq218=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Km0/W46bD2JdeFY3tqp6kMtVkR+ArP6p/SA3oDA2Fw8Oz30k4DdGggmww3ctPZyc6xac5h53YjLcCgsKrQt7q1B4ti2O3Rp0ga/Wcij2UkifH2ZRlZeUD2yDfdH/HRL3uNlhiCWM0QIWwtlBxStmrtLhRCmWfYZoolexyPzb0Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GrhrOBZR; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc4563611cso425870276.3
        for <linux-rdma@vger.kernel.org>; Wed, 27 Mar 2024 14:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711575929; x=1712180729; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ldINoU5VYJkv9i5GCH5hBaOnA51dgNGBQpx4IgBlUR8=;
        b=GrhrOBZRdAzZjM2pRpFpgQNYPUUO/NpseZ3Yu/cTyKuzS+mk327o61FrScxQ4FgS0o
         RsqqkNr7aaYDslM5vtOCc3LUbGUyUIuVayNS+cqU3qUJtKqkvYPU4WPxcrzN2U5jAsXF
         PtaUKjkI4xS6vR+z8UUI2GBDAAWtC6wu4Q3bir6E+h1YRs2kQEA0dj0paHMAR+1T21NK
         ZtB92L6t+xOT7xdcZgHpcVY15U37y2556KjuF3xG6ng9sdXlL6/Q84uxJwUxggTHmXdD
         b9IwhxHJIApPdtKJCBF8jHuEqak9NZVnBHRJQqbGVXSvksyxiKye8qR8f4+ckdfKZRJg
         TDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711575929; x=1712180729;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ldINoU5VYJkv9i5GCH5hBaOnA51dgNGBQpx4IgBlUR8=;
        b=OsYYF68eiQlo3IomVH9zDE/m09B+T62sIgmrW1uw8wQOmPxI61cUQK1DuYffmf7hye
         74/KAgzzu6Aj4pwr0Zks4q5C2tjb98RTkk+j0Fpo1FiqezkEVH0Gdm9WLM5VjQFvc6b2
         1QAWNTL5eVIzk90fgoi+c2BRJqQvCi7elgYPaWejXR49yfsXNhfA0nM9H8bAZN8MaWur
         yD36DCTG1liAZIL9RyQGQqhseNMuDi3hBTRI5QF+UXoZpiQ7Lbnq/dzKz6f6v32ldOI7
         kkD8kzULwtCsnnzkMr9WLGrl2Sz5wOvGmf1pjTMq0LjOJe8b1XDGSZQuET+JHqHHRRIG
         Zljg==
X-Forwarded-Encrypted: i=1; AJvYcCVDtkYYW+wr8W9YqOPta/e/0iT7sIqUSZMzqPNM6jkuzuwX+NqsY7o7i0DUfaSKId89FbK5qVUFhguUDDNVMTMAfbE13GLlnjIuwg==
X-Gm-Message-State: AOJu0YyXtshb9g4TK9NETIQ+FMcOapNvG9ZiuM4QoFL4au1DRRVhs4Uz
	Np8do36b33NVv+yRKbB2ilaL58/2ijCluYuXMznMpiz1nUeaBPrQiyCH/p/Rv1DfsdsgmscOa9Q
	60o9b6hs+nCUtLmKFvsEN/Q==
X-Google-Smtp-Source: AGHT+IEKtADRvlkxc7YGEqMlczMA9y2zeZF2AgXSBclUgkSzZX00m5c+R1YQNQRHKujGk4eQyKgrO2GZQNQ7f1pkaQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:b757:6e7b:2156:cabc])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:110c:b0:dcc:f01f:65e1 with
 SMTP id o12-20020a056902110c00b00dccf01f65e1mr341668ybu.8.1711575929627; Wed,
 27 Mar 2024 14:45:29 -0700 (PDT)
Date: Wed, 27 Mar 2024 14:45:19 -0700
In-Reply-To: <20240327214523.2182174-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240327214523.2182174-1-almasrymina@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240327214523.2182174-2-almasrymina@google.com>
Subject: [PATCH net-next v2 1/3] net: make napi_frag_unref reuse skb_page_unref
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Mirko Lindner <mlindner@marvell.com>, Stephen Hemminger <stephen@networkplumber.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

The implementations of these 2 functions are almost identical. Remove
the implementation of napi_frag_unref, and make it a call into
skb_page_unref so we don't duplicate the implementation.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 include/linux/skbuff.h | 12 +++---------
 net/ipv4/esp4.c        |  2 +-
 net/ipv6/esp6.c        |  2 +-
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index b945af8a6208..bafa5c9ff59a 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3524,10 +3524,10 @@ int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
 bool napi_pp_put_page(struct page *page, bool napi_safe);
 
 static inline void
-skb_page_unref(const struct sk_buff *skb, struct page *page, bool napi_safe)
+skb_page_unref(struct page *page, bool recycle, bool napi_safe)
 {
 #ifdef CONFIG_PAGE_POOL
-	if (skb->pp_recycle && napi_pp_put_page(page, napi_safe))
+	if (recycle && napi_pp_put_page(page, napi_safe))
 		return;
 #endif
 	put_page(page);
@@ -3536,13 +3536,7 @@ skb_page_unref(const struct sk_buff *skb, struct page *page, bool napi_safe)
 static inline void
 napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
 {
-	struct page *page = skb_frag_page(frag);
-
-#ifdef CONFIG_PAGE_POOL
-	if (recycle && napi_pp_put_page(page, napi_safe))
-		return;
-#endif
-	put_page(page);
+	skb_page_unref(skb_frag_page(frag), recycle, napi_safe);
 }
 
 /**
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index d33d12421814..3d2c252c5570 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -114,7 +114,7 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
 	 */
 	if (req->src != req->dst)
 		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
-			skb_page_unref(skb, sg_page(sg), false);
+			skb_page_unref(sg_page(sg), skb->pp_recycle, false);
 }
 
 #ifdef CONFIG_INET_ESPINTCP
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 7371886d4f9f..4fe4f97f5420 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -131,7 +131,7 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
 	 */
 	if (req->src != req->dst)
 		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
-			skb_page_unref(skb, sg_page(sg), false);
+			skb_page_unref(sg_page(sg), skb->pp_recycle, false);
 }
 
 #ifdef CONFIG_INET6_ESPINTCP
-- 
2.44.0.396.g6e790dbe36-goog


