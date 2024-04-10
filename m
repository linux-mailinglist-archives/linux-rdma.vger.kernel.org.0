Return-Path: <linux-rdma+bounces-1889-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 470388A004F
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Apr 2024 21:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A6301C2225A
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Apr 2024 19:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCF21836CD;
	Wed, 10 Apr 2024 19:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b7sA07Ee"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23B4181BBE
	for <linux-rdma@vger.kernel.org>; Wed, 10 Apr 2024 19:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712775917; cv=none; b=m4w7aUKA9H8TRp13ua9B8R+DvmrhJOs/yEKM8FUFAHZ9TtF8LVYwesokw1f7TPWKqXNjFzJwzMvidRltdaCvpa4Y3ApsbX/LlKriq81bG+hVRge6Upt2fU/2qabP4pZHcko3LxuDPbI3eeFe7/Po+be2dS/GbOQ+6GvImt++M5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712775917; c=relaxed/simple;
	bh=QOoQGmXcdK0eBk/iwwBk5xXQK78VoovctkAhh/hHWT0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KYMxHHunBS7SXohTm0jwRAyfjKVBHzlyKGf2uxokNr+UAkz+78aBZHKp9L5Iqi9qfqItuGWYcBUeBwktEuqtPXnTsSViPA4EBTQnI/JQQc7d7ZsODKNQ9slcTgaSO5KfZXwweadPBH2pFiUGFJbpx35Fm4tY9EQxe6q9yYSOQcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b7sA07Ee; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcbfe1a42a4so11865802276.2
        for <linux-rdma@vger.kernel.org>; Wed, 10 Apr 2024 12:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712775913; x=1713380713; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bmcIkQ+MufwZpF2fkWX11wvhEj2JS9qRVJJAgLH2hQk=;
        b=b7sA07Ee7+8ZRWAYDE9VLjAZHJ6uQsBlfVL+USFgDsAQuIYdc8JkUv3dDifjU1A9fu
         XXUEQ+SiyX/RbluRMWkxTX9If5XLx0ZdTXcpRXvSA1hwRAMfbqcOavr3KWMXsYCXa0/W
         xdw/i97aXhwB3rqVPqoDMbZlrklm/nNz/FrIkc1w+blVn+O5KABCchTqlLHz8Z1ZZ4Da
         e9ZZfJFKdBzK0RDG2AEa2Ox5gsoXdYo5ewsLMIpz1ZmJZ0a99FOACQRe5BB9fTTDKqiX
         PhMp0Hne3eiGqfwuHXGGH9ISqaXWdVMRiWjUl1zYCDdtvPdPr+hvvUIGknmfRuPie7Ym
         fK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712775913; x=1713380713;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bmcIkQ+MufwZpF2fkWX11wvhEj2JS9qRVJJAgLH2hQk=;
        b=gj9bJU8WNHEilzoE5znm8HYlOKrJNHv51Awwkg6BhA9d/oACAUXN7uRpbDMV8RbvCF
         JRbGvVXGLww3SQ1kTzphFlgDRVwPFDNkUvg2X9Kse/3DMTgOdsTXjolRujMD4JiLYqcg
         aFVZ3qn41arZICmevASFFHqbePDEhj4H76h81tUMIrb8WdfuCDDPwVdaDwyOGNxFDPTm
         O8gYQODYLnp+LUfGwUYMmg6CkkaRwaUO5kPapufCZjUstHJz4cwC3p88zJ8D5XKyXcHL
         vwss7tdkGNuM3tk+nOl5w4J67hRpkD175dH3fNeX7gVgMctuLgxeSV9OrJssSVXElnWU
         84rg==
X-Forwarded-Encrypted: i=1; AJvYcCXi5lhnq9orBAaBa5Rj0XdN3JCAjN3rZfTLlxqnrX0qfmZvdZEzOPzzpX7/Ic55DE4Or3E3FwgD6oOmAt66GY4jLfek5EOL0Bqmkg==
X-Gm-Message-State: AOJu0Yy3CpEolBbe4ZlD2HtNttxmODgRxgLhXs+QkaApGBppqziDf03y
	k7qBaqVqQhqR/52FYb4hSHbtbCNzhcPY95pB9KvAuRHp+IeRYPBB3Ocu5OByzaxV+H2N/72oyRx
	/Ha2H1Ga1616gMZ5ikn1b3g==
X-Google-Smtp-Source: AGHT+IHkCJYTpJrhUlDF52Cw4Mrc544ezC2wMdsc5mUDQ7V5j2MPNx//RvmAujxOHN6LlvOTWHXW4W3F2ryz2rX5xA==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:21f0:1a3a:493e:cf21])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:2b0d:b0:dc6:5396:c0d4 with
 SMTP id fi13-20020a0569022b0d00b00dc65396c0d4mr1030776ybb.1.1712775912997;
 Wed, 10 Apr 2024 12:05:12 -0700 (PDT)
Date: Wed, 10 Apr 2024 12:05:02 -0700
In-Reply-To: <20240410190505.1225848-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240410190505.1225848-1-almasrymina@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240410190505.1225848-3-almasrymina@google.com>
Subject: [PATCH net-next v6 2/2] net: mirror skb frag ref/unref helpers
From: Mina Almasry <almasrymina@google.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Mirko Lindner <mlindner@marvell.com>, Stephen Hemminger <stephen@networkplumber.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Wei Liu <wei.liu@kernel.org>, Paul Durrant <paul@xen.org>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Ahern <dsahern@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
	John Fastabend <john.fastabend@gmail.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Jacob Keller <jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"

Refactor some of the skb frag ref/unref helpers for improved clarity.

Implement napi_pp_get_page() to be the mirror counterpart of
napi_pp_put_page().

Implement skb_page_ref() to be the mirror of skb_page_unref().

Improve __skb_frag_ref() to become a mirror counterpart of
__skb_frag_unref(). Previously unref could handle pp & non-pp pages,
while the ref could only handle non-pp pages. Now both the ref & unref
helpers can correctly handle both pp & non-pp pages.

Now that __skb_frag_ref() can handle both pp & non-pp pages, remove
skb_pp_frag_ref(), and use __skb_frag_ref() instead.  This lets us
remove pp specific handling from skb_try_coalesce.

Additionally, since __skb_frag_ref() can now handle both pp & non-pp
pages, a latent issue in skb_shift() should now be fixed. Previously
this function would do a non-pp ref & pp unref on potential pp frags
(fragfrom). After this patch, skb_shift() should correctly do a pp
ref/unref on pp frags.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

---

v6:
- Move skb ref helpers to new header file (Jakub).

v5:
- Made changes to inline napi_pp_get_page() (Eric). I had to move
  page_pool_ref_page() from include/net/page_pool/helpers.h to
  include/linux/skbuff.h, so I don't add more includes to skbuff.h,
  which slows down the incremental builds.

v4:
- pass skb->pp_recycle instead of 'false' in __skb_frag_ref in
  chcr_ktls.c & cassini.c.
- Add some details on the changes to skb_shift() in this commit in the
  commit message.

v3:
- Fix build errors reported by patchwork.
- Fix drivers/net/veth.c & tls_device_fallback.c callsite I missed to update.
- Fix page_pool_ref_page(head_page) -> page_pool_ref_page(page)


fix mirror

---
 .../chelsio/inline_crypto/ch_ktls/chcr_ktls.c |  2 +-
 drivers/net/ethernet/sun/cassini.c            |  4 +-
 drivers/net/veth.c                            |  2 +-
 include/linux/skbuff_ref.h                    | 39 ++++++++++++++--
 net/core/skbuff.c                             | 46 ++-----------------
 net/tls/tls_device_fallback.c                 |  2 +-
 6 files changed, 44 insertions(+), 51 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
index e8e460a92e0e..3832c2e8ea5a 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
@@ -1659,7 +1659,7 @@ static void chcr_ktls_copy_record_in_skb(struct sk_buff *nskb,
 	for (i = 0; i < record->num_frags; i++) {
 		skb_shinfo(nskb)->frags[i] = record->frags[i];
 		/* increase the frag ref count */
-		__skb_frag_ref(&skb_shinfo(nskb)->frags[i]);
+		__skb_frag_ref(&skb_shinfo(nskb)->frags[i], nskb->pp_recycle);
 	}
 
 	skb_shinfo(nskb)->nr_frags = record->num_frags;
diff --git a/drivers/net/ethernet/sun/cassini.c b/drivers/net/ethernet/sun/cassini.c
index 8f1f43dbb76d..f058e154a3bc 100644
--- a/drivers/net/ethernet/sun/cassini.c
+++ b/drivers/net/ethernet/sun/cassini.c
@@ -2000,7 +2000,7 @@ static int cas_rx_process_pkt(struct cas *cp, struct cas_rx_comp *rxc,
 		skb->len      += hlen - swivel;
 
 		skb_frag_fill_page_desc(frag, page->buffer, off, hlen - swivel);
-		__skb_frag_ref(frag);
+		__skb_frag_ref(frag, skb->pp_recycle);
 
 		/* any more data? */
 		if ((words[0] & RX_COMP1_SPLIT_PKT) && ((dlen -= hlen) > 0)) {
@@ -2024,7 +2024,7 @@ static int cas_rx_process_pkt(struct cas *cp, struct cas_rx_comp *rxc,
 			frag++;
 
 			skb_frag_fill_page_desc(frag, page->buffer, 0, hlen);
-			__skb_frag_ref(frag);
+			__skb_frag_ref(frag, skb->pp_recycle);
 			RX_USED_ADD(page, hlen + cp->crc_size);
 		}
 
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 426e68a95067..0b0293629329 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -717,7 +717,7 @@ static void veth_xdp_get(struct xdp_buff *xdp)
 		return;
 
 	for (i = 0; i < sinfo->nr_frags; i++)
-		__skb_frag_ref(&sinfo->frags[i]);
+		__skb_frag_ref(&sinfo->frags[i], false);
 }
 
 static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
diff --git a/include/linux/skbuff_ref.h b/include/linux/skbuff_ref.h
index 11f0a4063403..4dcdbe9fbc5f 100644
--- a/include/linux/skbuff_ref.h
+++ b/include/linux/skbuff_ref.h
@@ -8,16 +8,47 @@
 #define _LINUX_SKBUFF_REF_H
 
 #include <linux/skbuff.h>
+#include <net/page_pool/helpers.h>
+
+#ifdef CONFIG_PAGE_POOL
+static inline bool is_pp_page(struct page *page)
+{
+	return (page->pp_magic & ~0x3UL) == PP_SIGNATURE;
+}
+
+static inline bool napi_pp_get_page(struct page *page)
+{
+	page = compound_head(page);
+
+	if (!is_pp_page(page))
+		return false;
+
+	page_pool_ref_page(page);
+	return true;
+}
+#endif
+
+static inline void skb_page_ref(struct page *page, bool recycle)
+{
+#ifdef CONFIG_PAGE_POOL
+	if (recycle && napi_pp_get_page(page))
+		return;
+#endif
+	get_page(page);
+}
 
 /**
  * __skb_frag_ref - take an addition reference on a paged fragment.
  * @frag: the paged fragment
+ * @recycle: skb->pp_recycle param of the parent skb. False if no parent skb.
  *
- * Takes an additional reference on the paged fragment @frag.
+ * Takes an additional reference on the paged fragment @frag. Obtains the
+ * correct reference count depending on whether skb->pp_recycle is set and
+ * whether the frag is a page pool frag.
  */
-static inline void __skb_frag_ref(skb_frag_t *frag)
+static inline void __skb_frag_ref(skb_frag_t *frag, bool recycle)
 {
-	get_page(skb_frag_page(frag));
+	skb_page_ref(skb_frag_page(frag), recycle);
 }
 
 /**
@@ -29,7 +60,7 @@ static inline void __skb_frag_ref(skb_frag_t *frag)
  */
 static inline void skb_frag_ref(struct sk_buff *skb, int f)
 {
-	__skb_frag_ref(&skb_shinfo(skb)->frags[f]);
+	__skb_frag_ref(&skb_shinfo(skb)->frags[f], skb->pp_recycle);
 }
 
 bool napi_pp_put_page(struct page *page);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 38c09a70adc1..3c276f56537b 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -907,11 +907,6 @@ static void skb_clone_fraglist(struct sk_buff *skb)
 		skb_get(list);
 }
 
-static bool is_pp_page(struct page *page)
-{
-	return (page->pp_magic & ~0x3UL) == PP_SIGNATURE;
-}
-
 int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
 		    unsigned int headroom)
 {
@@ -1033,37 +1028,6 @@ static bool skb_pp_recycle(struct sk_buff *skb, void *data)
 	return napi_pp_put_page(virt_to_page(data));
 }
 
-/**
- * skb_pp_frag_ref() - Increase fragment references of a page pool aware skb
- * @skb:	page pool aware skb
- *
- * Increase the fragment reference count (pp_ref_count) of a skb. This is
- * intended to gain fragment references only for page pool aware skbs,
- * i.e. when skb->pp_recycle is true, and not for fragments in a
- * non-pp-recycling skb. It has a fallback to increase references on normal
- * pages, as page pool aware skbs may also have normal page fragments.
- */
-static int skb_pp_frag_ref(struct sk_buff *skb)
-{
-	struct skb_shared_info *shinfo;
-	struct page *head_page;
-	int i;
-
-	if (!skb->pp_recycle)
-		return -EINVAL;
-
-	shinfo = skb_shinfo(skb);
-
-	for (i = 0; i < shinfo->nr_frags; i++) {
-		head_page = compound_head(skb_frag_page(&shinfo->frags[i]));
-		if (likely(is_pp_page(head_page)))
-			page_pool_ref_page(head_page);
-		else
-			page_ref_inc(head_page);
-	}
-	return 0;
-}
-
 static void skb_kfree_head(void *head, unsigned int end_offset)
 {
 	if (end_offset == SKB_SMALL_HEAD_HEADROOM)
@@ -4176,7 +4140,7 @@ int skb_shift(struct sk_buff *tgt, struct sk_buff *skb, int shiftlen)
 			to++;
 
 		} else {
-			__skb_frag_ref(fragfrom);
+			__skb_frag_ref(fragfrom, skb->pp_recycle);
 			skb_frag_page_copy(fragto, fragfrom);
 			skb_frag_off_copy(fragto, fragfrom);
 			skb_frag_size_set(fragto, todo);
@@ -4826,7 +4790,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 			}
 
 			*nskb_frag = (i < 0) ? skb_head_frag_to_page_desc(frag_skb) : *frag;
-			__skb_frag_ref(nskb_frag);
+			__skb_frag_ref(nskb_frag, nskb->pp_recycle);
 			size = skb_frag_size(nskb_frag);
 
 			if (pos < offset) {
@@ -5957,10 +5921,8 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 	/* if the skb is not cloned this does nothing
 	 * since we set nr_frags to 0.
 	 */
-	if (skb_pp_frag_ref(from)) {
-		for (i = 0; i < from_shinfo->nr_frags; i++)
-			__skb_frag_ref(&from_shinfo->frags[i]);
-	}
+	for (i = 0; i < from_shinfo->nr_frags; i++)
+		__skb_frag_ref(&from_shinfo->frags[i], from->pp_recycle);
 
 	to->truesize += delta;
 	to->len += len;
diff --git a/net/tls/tls_device_fallback.c b/net/tls/tls_device_fallback.c
index f9e3d3d90dcf..9237dded4467 100644
--- a/net/tls/tls_device_fallback.c
+++ b/net/tls/tls_device_fallback.c
@@ -278,7 +278,7 @@ static int fill_sg_in(struct scatterlist *sg_in,
 	for (i = 0; remaining > 0; i++) {
 		skb_frag_t *frag = &record->frags[i];
 
-		__skb_frag_ref(frag);
+		__skb_frag_ref(frag, false);
 		sg_set_page(sg_in + i, skb_frag_page(frag),
 			    skb_frag_size(frag), skb_frag_off(frag));
 
-- 
2.44.0.478.gd926399ef9-goog


