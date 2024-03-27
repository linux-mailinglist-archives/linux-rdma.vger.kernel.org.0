Return-Path: <linux-rdma+bounces-1626-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F22B88F136
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Mar 2024 22:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD0FE1F2FE8F
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Mar 2024 21:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90292154451;
	Wed, 27 Mar 2024 21:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eceHaqMD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97555153BFF
	for <linux-rdma@vger.kernel.org>; Wed, 27 Mar 2024 21:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711575936; cv=none; b=jgRZFEYW94LpMtCZo9gqz4ubpIRk/EDWfhGJRISiTpnOabNZ6NqI1mHlI1QxA6lIxSQbl6GEKljiue5z5EFINHdd2TWs2nkS9a9LBGqXmIrIhhLi5YYnY0jMqaFvtyaJ/li0znh+8HX7c4Sw3bOj+T/4T5MhOtv94KX/s53lqrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711575936; c=relaxed/simple;
	bh=HcoNxlvdGhGfyulBOvat+dNXCCSpR7y/F/Sfr6c14to=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ViXOy4omyWkTlZtxUpN+8mL6JOK8TnFatrBl2eMgqg9mPLnMzT9wWTMBwgVnCuwtyGza+AaiwRKaTx9QHWIuEbBKdPKtf77Kiven0I807Np/0uojyZR9XumST44Q42WrvI0rmTdAxZnqdVDQjgCcrmVBau6qGDnLQczAhatmfqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eceHaqMD; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dd944567b6cso366036276.2
        for <linux-rdma@vger.kernel.org>; Wed, 27 Mar 2024 14:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711575933; x=1712180733; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Fas+uh+IATqHO1ThFI61gBVEvoGJvlSG5a3mDRu0bA=;
        b=eceHaqMDZb3vbNTjdGFp4zLPKnVbwgeC/Rc7rKqPl1vezU9zqo3QONKaP1+h2u9pfA
         IFg51M6uZU8GuoosMD20S7X6l83VPEL2foHjrXA28se3+YRS2CgPr5xJS47QsSnjFF9S
         OVPGuyI/lpares1OC0+24v5advKeRWab3RH4AwA0AwAH7VX5WYfFAJ5StdV8njD+Ykv5
         itZC7xK01lrQiFZCDgC5NKOHCQqxoQlrImJONRy16CT1f59p6vtthfHIANyZYyzGrhSe
         6Sew/8ES8B9+qWUP+SFWZQxifES2TcYVOkHAQu/qWrXC2uvLTyUUSI9GyV8z5y5XUuYB
         Fbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711575933; x=1712180733;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Fas+uh+IATqHO1ThFI61gBVEvoGJvlSG5a3mDRu0bA=;
        b=OYgY6n13sgJk+Uui0GMprlhnDg4LEIWNoljq8zOCtxYEKEMBrLo//5I3+vBlA8TQwg
         qA5i420Ct3TA1iWIW6SNy8pfzQPvY7CaN2eT3N742mWLzRcE75YB7BSHO4ZWx318CX0F
         jM4K1GS3OEck5X+ou5afRgOaFJT5U1MCXvFi4QH4uLznjC9gjaD6lu5h6jCaerNS7b2q
         ejfndFY8WP1J+3kGrzM1fL9RXCOp5HVt2G6ma5rtuFXWP2xXQhJXDqf3i/oC4a42jUla
         Ux4xk+sWplx4uHBNV3VwXcouL6EVrYUa6H9Rei4f77s2yaKO0NvIEhppWl9mKBcMHOiT
         xj4A==
X-Forwarded-Encrypted: i=1; AJvYcCWGq2FFTxMlvgggsy3fI4aXThbDdGhh3ca8XQrPaDFV2g91nH/XTJ0jslEQQQGdWzKGjdwWJZPZhQX3MZpIJ1nEyLkkQAFvUk0jjQ==
X-Gm-Message-State: AOJu0Yx1zmPfFrJgEILI5enamsSPl11hop7rvM2U4a1eybX1vdnzOveO
	v9SXsDVR0kJLLIqHX3wYzXq96NGL5qtxsNAgOOr3wMSdPtUFUhj0xlBF0Yc9S2apLM/5bO76Ge4
	IsYDE/Z8M/y+eo9pMObq3Sg==
X-Google-Smtp-Source: AGHT+IEbxk1R4CRvllhl4uFMMmoABCiOd+KYKwhp/rGbIhNQO57O71um9bj7xu9u0AunMaECDk0/6mpFbNSCoQSHdw==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:b757:6e7b:2156:cabc])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:2413:b0:dc6:dfd9:d423 with
 SMTP id dr19-20020a056902241300b00dc6dfd9d423mr119003ybb.3.1711575933748;
 Wed, 27 Mar 2024 14:45:33 -0700 (PDT)
Date: Wed, 27 Mar 2024 14:45:21 -0700
In-Reply-To: <20240327214523.2182174-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240327214523.2182174-1-almasrymina@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240327214523.2182174-4-almasrymina@google.com>
Subject: [PATCH net-next v2 3/3] net: remove napi_frag_unref
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

With the changes in the last patches, napi_frag_unref() is now
reduandant. Remove it and use skb_page_unref directly.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>

---
 drivers/net/ethernet/marvell/sky2.c        |  2 +-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c |  2 +-
 include/linux/skbuff.h                     | 14 +++++---------
 net/core/skbuff.c                          |  4 ++--
 net/tls/tls_device.c                       |  2 +-
 net/tls/tls_strp.c                         |  2 +-
 6 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/marvell/sky2.c b/drivers/net/ethernet/marvell/sky2.c
index 07720841a8d7..8e00a5856856 100644
--- a/drivers/net/ethernet/marvell/sky2.c
+++ b/drivers/net/ethernet/marvell/sky2.c
@@ -2501,7 +2501,7 @@ static void skb_put_frags(struct sk_buff *skb, unsigned int hdr_space,
 
 		if (length == 0) {
 			/* don't need this page */
-			__skb_frag_unref(frag, false);
+			__skb_frag_unref(frag, false, false);
 			--skb_shinfo(skb)->nr_frags;
 		} else {
 			size = min(length, (unsigned) PAGE_SIZE);
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index eac49657bd07..4dbf29b46979 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -526,7 +526,7 @@ static int mlx4_en_complete_rx_desc(struct mlx4_en_priv *priv,
 fail:
 	while (nr > 0) {
 		nr--;
-		__skb_frag_unref(skb_shinfo(skb)->frags + nr, false);
+		__skb_frag_unref(skb_shinfo(skb)->frags + nr, false, false);
 	}
 	return 0;
 }
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 058d72a2a250..c3edb4a3450a 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3547,23 +3547,19 @@ skb_page_unref(struct page *page, bool recycle, bool napi_safe)
 	put_page(page);
 }
 
-static inline void
-napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
-{
-	skb_page_unref(skb_frag_page(frag), recycle, napi_safe);
-}
-
 /**
  * __skb_frag_unref - release a reference on a paged fragment.
  * @frag: the paged fragment
  * @recycle: recycle the page if allocated via page_pool
+ * @napi_safe: set to true if running in the same napi context as where the
+ * consumer would run.
  *
  * Releases a reference on the paged fragment @frag
  * or recycles the page via the page_pool API.
  */
-static inline void __skb_frag_unref(skb_frag_t *frag, bool recycle)
+static inline void __skb_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
 {
-	napi_frag_unref(frag, recycle, false);
+	skb_page_unref(skb_frag_page(frag), recycle, napi_safe);
 }
 
 /**
@@ -3578,7 +3574,7 @@ static inline void skb_frag_unref(struct sk_buff *skb, int f)
 	struct skb_shared_info *shinfo = skb_shinfo(skb);
 
 	if (!skb_zcopy_managed(skb))
-		__skb_frag_unref(&shinfo->frags[f], skb->pp_recycle);
+		__skb_frag_unref(&shinfo->frags[f], skb->pp_recycle, false);
 }
 
 /**
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 5c86ecaceb6c..a6dbba56e047 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1109,7 +1109,7 @@ static void skb_release_data(struct sk_buff *skb, enum skb_drop_reason reason,
 	}
 
 	for (i = 0; i < shinfo->nr_frags; i++)
-		napi_frag_unref(&shinfo->frags[i], skb->pp_recycle, napi_safe);
+		__skb_frag_unref(&shinfo->frags[i], skb->pp_recycle, napi_safe);
 
 free_head:
 	if (shinfo->frag_list)
@@ -4200,7 +4200,7 @@ int skb_shift(struct sk_buff *tgt, struct sk_buff *skb, int shiftlen)
 		fragto = &skb_shinfo(tgt)->frags[merge];
 
 		skb_frag_size_add(fragto, skb_frag_size(fragfrom));
-		__skb_frag_unref(fragfrom, skb->pp_recycle);
+		__skb_frag_unref(fragfrom, skb->pp_recycle, false);
 	}
 
 	/* Reposition in the original skb */
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index bf8ed36b1ad6..5dc6381f34fb 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -140,7 +140,7 @@ static void destroy_record(struct tls_record_info *record)
 	int i;
 
 	for (i = 0; i < record->num_frags; i++)
-		__skb_frag_unref(&record->frags[i], false);
+		__skb_frag_unref(&record->frags[i], false, false);
 	kfree(record);
 }
 
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index ca1e0e198ceb..85b41f226978 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -196,7 +196,7 @@ static void tls_strp_flush_anchor_copy(struct tls_strparser *strp)
 	DEBUG_NET_WARN_ON_ONCE(atomic_read(&shinfo->dataref) != 1);
 
 	for (i = 0; i < shinfo->nr_frags; i++)
-		__skb_frag_unref(&shinfo->frags[i], false);
+		__skb_frag_unref(&shinfo->frags[i], false, false);
 	shinfo->nr_frags = 0;
 	if (strp->copy_mode) {
 		kfree_skb_list(shinfo->frag_list);
-- 
2.44.0.396.g6e790dbe36-goog


