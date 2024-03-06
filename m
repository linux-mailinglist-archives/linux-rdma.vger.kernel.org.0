Return-Path: <linux-rdma+bounces-1304-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD108744D8
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Mar 2024 01:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76673B21605
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Mar 2024 00:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2EA2C862;
	Wed,  6 Mar 2024 23:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V2uPKRGe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBA21D539
	for <linux-rdma@vger.kernel.org>; Wed,  6 Mar 2024 23:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709769573; cv=none; b=fVkmA8PRODTQnHAs7qj3OiufgrW9Ly/kdxfQ0EqejZijavWkO4KnF9YBMrmAJqDtrihq1Tn/nyQb3KSRi2bSSP/LGmCmbh+0OPJuY8PK0hUSY6Q7Hr7wlGjnz0g1Mf28tSC9/G6mOw26G20P6uvvBBHdsTU4IE2EEes8oNLis8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709769573; c=relaxed/simple;
	bh=/0/Xh5s59K8DQ+aUwf9pWpNrpaQktzi3v3x1ACLmFCU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D78Xq8f5NhCTRszLJ0psxT5UAgg/iK2++RZz+vY63boimmdtm9D0pgBBRNTkI+r91yCjxDLvKuE+iPWNLw7WwSwzuLARU7NbJAY1bSck1z/Jo37FxpyWKfIiDgp42PIwWtgpXdpAJAT4F8XC4gs5z078eIXUTsBpZQaXg1MlUdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V2uPKRGe; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6087ffdac8cso5643977b3.2
        for <linux-rdma@vger.kernel.org>; Wed, 06 Mar 2024 15:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709769570; x=1710374370; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gmMk3gOmMaNgwAKEEtV++O/iVrn9YTvaRrJG2G+aWtQ=;
        b=V2uPKRGe32CNLXDva6wx/8s/QdsCdRKki8R2vumic/qNbQfn11IISYFPZf2M/uc9l+
         MlavsBNw6jXj5Smd7CXi8Hod7ndKxyLvLJfvKQUDJAs4XmwDCKPUXFAVBWcvSbYxeGck
         HfeT34/Dm0WDiQSFZte2pVm77QMYHEbYLX8aAg3wpP41emyyu9KGu3gKav7CSfYIrLpN
         oeZqAKz60Zm+6gV+sK50RR3AVawKoFrnpatVvXNE+SbwKMXeGMXuJQbA0LXsCIp7Jqa8
         0uAe+e0ckZ0ITHvrHJmCK608Bc48mIUJ7OwaeMIJfG1EAs3sffdXTMVx/Yths02qrj35
         kHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709769570; x=1710374370;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gmMk3gOmMaNgwAKEEtV++O/iVrn9YTvaRrJG2G+aWtQ=;
        b=iOpPXp6/ws9HES5/MWK3dKhDxJmlvN0LjC20rRMAgUuroPkGmR/D5IlTIN/KFpd8xN
         /+cpj7zcjqh6PPJj3Tvhfke0FVjMQRdVlfFfJ0o5ewLgNXQFLCc6E1+tILHCX8aopjOy
         uv5UpxPf8xKl2k7LN7CbEYHvxwoh92umfKH5wcHUJZtFplC+tO8/2FnJ1sJHUqEoOFTn
         wHjCkGYYsn1XB9v71c8bR8GXcr6eCNC7Cr8UTa8BgCAdaSME93VfE0Bk5fJ34DXl6iX9
         BYlqGAsVQC9IF4CqKouXtokekciwzJNKNC1+4EIdKs1KOhacYGLtXEmsuhHQk9Yeu6J/
         nC7w==
X-Forwarded-Encrypted: i=1; AJvYcCUU3AV8I00VTCBSksG7EMiDp+toeHSeb7qKGcOPzwisA2sEt5+r8GH5lBVz7UKdB83XirFVPJRlNJRhN3Sv9R23JM5IqZjbqwD/8Q==
X-Gm-Message-State: AOJu0YzQk+dM3aIlLZQ+uR/t8Hf4cQAmG+R3+EURVsseEUcXeBd3uQtj
	qVUXZbWFj17tPDk4qQ5RGTJsRqhemPfB5F3T8kyLIe6tySm7HbTU8c0PRHZM5rzOybzMEyO7LGZ
	+Fr1LmQYuGnlUZtf/2nu5WA==
X-Google-Smtp-Source: AGHT+IFzF/vYim59RDsixU6T89U85ltGO0VLxE6ZaLQPThtsVBOH3MLy+N4YXZ9E8nPWEe6eLy/SXdBKVmWZSItZsQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:daeb:5bc6:353c:6d72])
 (user=almasrymina job=sendgmr) by 2002:a81:7945:0:b0:609:22ea:f95e with SMTP
 id u66-20020a817945000000b0060922eaf95emr4425822ywc.4.1709769570458; Wed, 06
 Mar 2024 15:59:30 -0800 (PST)
Date: Wed,  6 Mar 2024 15:59:20 -0800
In-Reply-To: <20240306235922.282781-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306235922.282781-1-almasrymina@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306235922.282781-3-almasrymina@google.com>
Subject: [RFC PATCH net-next v1 2/2] net: remove napi_frag_[un]ref
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Mirko Lindner <mlindner@marvell.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Boris Pismenny <borisp@nvidia.com>, 
	John Fastabend <john.fastabend@gmail.com>, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

With the changes in the last patch, napi_frag_[un]ref() helpers become
reduandant. Remove them, and use __skb_frag_[un]ref() directly.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 drivers/net/ethernet/marvell/sky2.c        |  2 +-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c |  2 +-
 include/linux/skbuff.h                     | 45 +++++++++-------------
 net/core/skbuff.c                          |  4 +-
 net/tls/tls_device.c                       |  2 +-
 net/tls/tls_strp.c                         |  2 +-
 6 files changed, 24 insertions(+), 33 deletions(-)

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
index 51316b0e20bc..9cd04c315592 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3479,17 +3479,6 @@ static inline struct page *skb_frag_page(const skb_frag_t *frag)
 
 bool napi_pp_get_page(struct page *page);
 
-static inline void napi_frag_ref(skb_frag_t *frag, bool recycle)
-{
-#ifdef CONFIG_PAGE_POOL
-	struct page *page = skb_frag_page(frag);
-
-	if (recycle && napi_pp_get_page(page))
-		return;
-#endif
-	get_page(page);
-}
-
 /**
  * __skb_frag_ref - take an addition reference on a paged fragment.
  * @frag: the paged fragment
@@ -3501,7 +3490,13 @@ static inline void napi_frag_ref(skb_frag_t *frag, bool recycle)
  */
 static inline void __skb_frag_ref(skb_frag_t *frag, bool recycle)
 {
-	napi_frag_ref(frag, recycle);
+#ifdef CONFIG_PAGE_POOL
+	struct page *page = skb_frag_page(frag);
+
+	if (recycle && napi_pp_get_page(page))
+		return;
+#endif
+	get_page(page);
 }
 
 /**
@@ -3522,29 +3517,25 @@ int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
 			 struct bpf_prog *prog);
 bool napi_pp_put_page(struct page *page, bool napi_safe);
 
-static inline void
-napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
-{
-	struct page *page = skb_frag_page(frag);
-
-#ifdef CONFIG_PAGE_POOL
-	if (recycle && napi_pp_put_page(page, napi_safe))
-		return;
-#endif
-	put_page(page);
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
+	struct page *page = skb_frag_page(frag);
+
+#ifdef CONFIG_PAGE_POOL
+	if (recycle && napi_pp_put_page(page, napi_safe))
+		return;
+#endif
+	put_page(page);
 }
 
 /**
@@ -3559,7 +3550,7 @@ static inline void skb_frag_unref(struct sk_buff *skb, int f)
 	struct skb_shared_info *shinfo = skb_shinfo(skb);
 
 	if (!skb_zcopy_managed(skb))
-		__skb_frag_unref(&shinfo->frags[f], skb->pp_recycle);
+		__skb_frag_unref(&shinfo->frags[f], skb->pp_recycle, false);
 }
 
 /**
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6d234faa9d9e..ed7f7e960b78 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1114,7 +1114,7 @@ static void skb_release_data(struct sk_buff *skb, enum skb_drop_reason reason,
 	}
 
 	for (i = 0; i < shinfo->nr_frags; i++)
-		napi_frag_unref(&shinfo->frags[i], skb->pp_recycle, napi_safe);
+		__skb_frag_unref(&shinfo->frags[i], skb->pp_recycle, napi_safe);
 
 free_head:
 	if (shinfo->frag_list)
@@ -4205,7 +4205,7 @@ int skb_shift(struct sk_buff *tgt, struct sk_buff *skb, int shiftlen)
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
2.44.0.278.ge034bb2e1d-goog


