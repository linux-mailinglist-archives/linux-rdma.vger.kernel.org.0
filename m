Return-Path: <linux-rdma+bounces-1716-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C83EB8946B9
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 23:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EACC81C21635
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 21:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DCE56473;
	Mon,  1 Apr 2024 21:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u3MjqiD3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F93955C0A
	for <linux-rdma@vger.kernel.org>; Mon,  1 Apr 2024 21:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712008250; cv=none; b=JaU72s7dfLHoa35LshOeXZQpuv0MpRztGzJ7dK62IsQ5OrbAwOBU174Yu1wkTZMMfsFvsoSLnIU8XO/LQvNYxhgBIFM7zNmCH8QsxAgSjDXzLqG4vYWVYOY52q6lm4q98sAjsG/QYILlHf2J1FihbG7WdTLJUkEW3I1qRwtLwGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712008250; c=relaxed/simple;
	bh=6iZBHoWjr0SW3V6W6W27wiyE26vfswz1Bipp3C2ZJ1U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m+58AJDvwF2+vGdLeNE3xthuwqk8sS9dhX3eXkt94PNCyrrL9zsyR1BVtz14IS5llmrT37bGgt5poBr4BUt3dDKOmXgvPhkCH65yRXPp+YJVQuIagJJSN7iG/aUZkkxL+5xvBMD5Qbp3Rycyf8pyKPksQd3FX59cwwYevuns8IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u3MjqiD3; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc4563611cso6982416276.3
        for <linux-rdma@vger.kernel.org>; Mon, 01 Apr 2024 14:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712008248; x=1712613048; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vXRjUgtATZ0E/Y+63Z5tthtMhFwiRvlicbw1JhZ19s0=;
        b=u3MjqiD3cgp+NoDLJCk0nQj5dCYJggnfsnjIhVgpAoN1vhtcD+3ZlnfibfUoxvg911
         KZhW1I97X3JJUQ/AcoRFlH7Z6iIjOdJALdLOg/jHQm7kqCiM9MYafdyxj+b974P8/Esh
         jH86/2ktJ0VAK4MjkEpoy+QeOZY258HejBFJibEHmN+uIDr0nUbJl3i6Denal+td+qEU
         ShJZkBcuvoN+G++MkIcKATCNm0qNYyYH3ki+xTnxLMjukV23N/EVx1TLVgzn+7FyKwbs
         G4U1mvpIkqB147LmGbPYuPnMqwIf1B5ZRr2JcOX+MWQCmYIXWrR3wcLpgfLlWhYZpIIJ
         MFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712008248; x=1712613048;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vXRjUgtATZ0E/Y+63Z5tthtMhFwiRvlicbw1JhZ19s0=;
        b=VhrMOH/Y99c9/2FioI2brBpoPDLg1D94QM71oJsUsDGm+Zhe0ZByLxcuLXl22shIQu
         TK3cJEJULgHN92tcdRmsysarpo+Nf2qqy930tdvIJrtfKKtJRKbJoiBe0qpJD3T9BKLe
         M2I4s/wlqQBjd6GS6eBSIfuTFpQtoNZUCN2z5/jv01psbyAQk1vv7S7aorGlsKhRnAAF
         hkwuTzmrSEq+fDiyWAq4JnU9ZVqiGwkUtaoszJkj4kATSgfueQx/NcjAn3LN5sWnLMWP
         Fvot6pLFzdPmpFlpP5al8bYu7PEMioGN3dawTtuRQIW6UnvHQjjSZoUDLtVCQ0ZDB/uq
         K0wA==
X-Forwarded-Encrypted: i=1; AJvYcCVocdwwaNwFwz7o+nSTV9NtNdKqQhr0+96aVnDX5ebvCwsJM2ryrZ4LPZkotOzEumfE/VGPqlQxLQ/Z8uzLbj6Q7t4TFiuOZXaH/g==
X-Gm-Message-State: AOJu0YzNIuKf6VOhA/cnSrGBYuTbjQo5u8OCJG9pt5vqkY8X9v13SIVG
	IcqKVlmLQznY83iAvz1V6x2j13z/bf6SSaKZDFSmGLfsORCjEMIChJA1ipRwhKiP1PiQ+6lduR4
	cAJHdxpD8Uq8sMGTDrmpcTg==
X-Google-Smtp-Source: AGHT+IFGadfogXIS8kOngK5G9vWIutCMBx8L4gKWUrm8XeH+h8lfoSVo1ljXz4C/IkewoV3oHHDRSuJKCxCHbdkprQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:b337:405b:46e7:9bd9])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:72d:b0:dc8:5e26:f4d7 with
 SMTP id l13-20020a056902072d00b00dc85e26f4d7mr3443884ybt.13.1712008248349;
 Mon, 01 Apr 2024 14:50:48 -0700 (PDT)
Date: Mon,  1 Apr 2024 14:50:37 -0700
In-Reply-To: <20240401215042.1877541-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240401215042.1877541-1-almasrymina@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240401215042.1877541-2-almasrymina@google.com>
Subject: [PATCH net-next v3 1/3] net: make napi_frag_unref reuse skb_page_unref
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
	Dragos Tatulea <dtatulea@nvidia.com>, Maxim Mikityanskiy <maxtram95@gmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Simon Horman <horms@kernel.org>, 
	Yunsheng Lin <linyunsheng@huawei.com>, 
	"=?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?=" <nabijaczleweli@nabijaczleweli.xyz>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, David Howells <dhowells@redhat.com>, 
	Florian Westphal <fw@strlen.de>, Aleksander Lobakin <aleksander.lobakin@intel.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Johannes Berg <johannes.berg@intel.com>, 
	Liang Chen <liangchen.linux@gmail.com>
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
index b7f1ecdaec38..a6b5596dc0cb 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3513,10 +3513,10 @@ int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
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
@@ -3525,13 +3525,7 @@ skb_page_unref(const struct sk_buff *skb, struct page *page, bool napi_safe)
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
2.44.0.478.gd926399ef9-goog


