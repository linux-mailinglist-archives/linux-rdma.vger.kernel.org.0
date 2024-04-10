Return-Path: <linux-rdma+bounces-1888-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B518A004A
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Apr 2024 21:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49B631C22974
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Apr 2024 19:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32B3181CE3;
	Wed, 10 Apr 2024 19:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PVjYyAk6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C811F18132D
	for <linux-rdma@vger.kernel.org>; Wed, 10 Apr 2024 19:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712775913; cv=none; b=TiW9DKXc+4YBrVrf3kxKHyvFM5sDJAwcktqYZtTzMMCaudlp/4zjjmxt3UNnq2CD2B2JoE3bIrEcU//Ka0JR1PttmozllNMTnvMQ8NBk0w/sGFmkLHUj6XQJFC3EK3Rebr+YSuaSiTx3O4KxJDn/fhU7H9xn83Z5gzylwl+YZF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712775913; c=relaxed/simple;
	bh=QDCl4WcLdseIaPiDbfAkSfJlsOce2p8xYiRqYQl+B04=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OXUyiOfvfcEhEzaZV4l8VSWtwwQKeP8Nrv3ly1cgA0u3AZtxshdgvudDWI+t8XuMsCze1p1ZcqiwoeILzvEfKTfj2hyXjXxsTN7LJOiYQsuES926K+N3y6uA+cDA55GCsDCNwlfnqud9MUAl0gAE7F4eE2pKqYdqxA6nA24EYJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PVjYyAk6; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcd94cc48a1so11416248276.3
        for <linux-rdma@vger.kernel.org>; Wed, 10 Apr 2024 12:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712775911; x=1713380711; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oxaQI4auo1SjFFAAP72+VqUzLxxPiXgE3B3SX2nH8O4=;
        b=PVjYyAk6vStsIcGW8m+a5kM7iA0y8QkQxnE8TnWaoepZMtZLX80HfPmyFhzFhncMwn
         6kFU1LIfQnxv/v2vq4k+W9xVBwGj8/RgarXDM9l14EjnykMME72t30LgAYx2X4TS52YG
         O2uRXtGQJZda+cuXP3H/N36EOnYHz9UpSw8oI34+4IPkrgAOhUl62s+mOvzk3SjobsUr
         /iUfl3nJHXKwDjpz5MrC5IVxowfRgSnKzoMzncvydG636KApyEgsUP659tERIAkOZN09
         XzOF71ZJpHZrvfhGGD23AZU9934Yb9we9HCfw/5TVPIRi0eJ2EXFnzP4NGSf9R+V/IZ2
         LmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712775911; x=1713380711;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oxaQI4auo1SjFFAAP72+VqUzLxxPiXgE3B3SX2nH8O4=;
        b=O/j9h69yoHTvdT7zId6QO3LWYgd66mdAwUkobKjSHZHZmAerta1DF4NakfqlOfnqF3
         Vu6RXuv6WaY8aD1BSIDtUOJ9IccK+gd3MBhE5qvc0EJ24IzJ2rl91sWpU8Bf2Wq0Aru1
         jrKN9BYDDQahtsN+ifFyofmDar837t8BYKGqpMMvjnrj46QQ9I8oxmY8J7mPDqZjg7PY
         XamjNo0T852eDo+G2gaD4nDzIT3QU4zAOTOAwUJRqFC6dRYRj9+3lQBCC/OhwJnc83/o
         qaSyCHaYYO/Mpeoj9s/x6TRwFn1Wt3Em+Y8dtjHfE9HqjhgOY9sP6sABmXg0GujUkcv2
         OY0w==
X-Forwarded-Encrypted: i=1; AJvYcCXlpp2ocpxKq3tcXBf+pHs36A4ZOpNPPEYJU/S74v/UbC8N8hI8lQ+ewTgF7rnD43K1qGYJnMo57ANvWvAltbcqlK46y18mrhmbzw==
X-Gm-Message-State: AOJu0YwGwBts6eWGpujLeEd+zr/BT+wNUMm7G67VUFFihHGdsLowCe81
	oYYz3yZRSuKLdQ2FUkwib4vKPYWoPpa+eX3DZwMY6fkNtbfFU/4mTm+o6bVSEhkbyIUoQPN4slE
	QlMhM2dQd/TvcjyxQchrr1A==
X-Google-Smtp-Source: AGHT+IHDXLFV56GTt2sohd89Bkiz0FKjkUs+yNVKoCTMFX+exHs4kNqNtac9ZUFpb0/Lyy0z1ITW5cLI+k9O6cGmDQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:21f0:1a3a:493e:cf21])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:1081:b0:dc7:8e30:e2e3 with
 SMTP id v1-20020a056902108100b00dc78e30e2e3mr1011516ybu.2.1712775910843; Wed,
 10 Apr 2024 12:05:10 -0700 (PDT)
Date: Wed, 10 Apr 2024 12:05:01 -0700
In-Reply-To: <20240410190505.1225848-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240410190505.1225848-1-almasrymina@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240410190505.1225848-2-almasrymina@google.com>
Subject: [PATCH net-next v6 1/2] net: move skb ref helpers to new header
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
	John Fastabend <john.fastabend@gmail.com>, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Add a new header, linux/skbuff_ref.h, which contains all the skb_*_ref()
helpers. Many of the consumers of skbuff.h do not actually use any of
the skb ref helpers, and we can speed up compilation a bit by minimizing
this header file.

Additionally in the later patch in the series we add page_pool support
to skb_frag_ref(), which requires some page_pool dependencies. We can
now add these dependencies to skbuff_ref.h instead of a very ubiquitous
skbuff.h

Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 .../chelsio/inline_crypto/ch_ktls/chcr_ktls.c |  1 +
 drivers/net/ethernet/marvell/sky2.c           |  1 +
 drivers/net/ethernet/mellanox/mlx4/en_rx.c    |  1 +
 drivers/net/ethernet/sun/cassini.c            |  1 +
 drivers/net/veth.c                            |  1 +
 drivers/net/xen-netback/netback.c             |  1 +
 include/linux/skbuff.h                        | 63 ----------------
 include/linux/skbuff_ref.h                    | 75 +++++++++++++++++++
 net/core/gro.c                                |  1 +
 net/core/skbuff.c                             |  1 +
 net/ipv4/esp4.c                               |  1 +
 net/ipv4/tcp_output.c                         |  1 +
 net/ipv6/esp6.c                               |  1 +
 net/tls/tls_device.c                          |  1 +
 net/tls/tls_device_fallback.c                 |  1 +
 net/tls/tls_strp.c                            |  1 +
 16 files changed, 89 insertions(+), 63 deletions(-)
 create mode 100644 include/linux/skbuff_ref.h

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
index 6482728794dd..e8e460a92e0e 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
@@ -10,6 +10,7 @@
 #include <net/ipv6.h>
 #include <linux/netdevice.h>
 #include <crypto/aes.h>
+#include <linux/skbuff_ref.h>
 #include "chcr_ktls.h"
 
 static LIST_HEAD(uld_ctx_list);
diff --git a/drivers/net/ethernet/marvell/sky2.c b/drivers/net/ethernet/marvell/sky2.c
index 07720841a8d7..f3f7f4cc27b3 100644
--- a/drivers/net/ethernet/marvell/sky2.c
+++ b/drivers/net/ethernet/marvell/sky2.c
@@ -34,6 +34,7 @@
 #include <linux/mii.h>
 #include <linux/of_net.h>
 #include <linux/dmi.h>
+#include <linux/skbuff_ref.h>
 
 #include <asm/irq.h>
 
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index eac49657bd07..8328df8645d5 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -42,6 +42,7 @@
 #include <linux/if_vlan.h>
 #include <linux/vmalloc.h>
 #include <linux/irq.h>
+#include <linux/skbuff_ref.h>
 
 #include <net/ip.h>
 #if IS_ENABLED(CONFIG_IPV6)
diff --git a/drivers/net/ethernet/sun/cassini.c b/drivers/net/ethernet/sun/cassini.c
index bfb903506367..8f1f43dbb76d 100644
--- a/drivers/net/ethernet/sun/cassini.c
+++ b/drivers/net/ethernet/sun/cassini.c
@@ -73,6 +73,7 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/skbuff.h>
+#include <linux/skbuff_ref.h>
 #include <linux/ethtool.h>
 #include <linux/crc32.h>
 #include <linux/random.h>
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index bcdfbf61eb66..426e68a95067 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -26,6 +26,7 @@
 #include <linux/ptr_ring.h>
 #include <linux/bpf_trace.h>
 #include <linux/net_tstamp.h>
+#include <linux/skbuff_ref.h>
 #include <net/page_pool/helpers.h>
 
 #define DRV_NAME	"veth"
diff --git a/drivers/net/xen-netback/netback.c b/drivers/net/xen-netback/netback.c
index ef76850d9bcd..48254fc07d64 100644
--- a/drivers/net/xen-netback/netback.c
+++ b/drivers/net/xen-netback/netback.c
@@ -38,6 +38,7 @@
 #include <linux/if_vlan.h>
 #include <linux/udp.h>
 #include <linux/highmem.h>
+#include <linux/skbuff_ref.h>
 
 #include <net/tcp.h>
 
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 7135a3e94afd..4072a7ee3859 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3492,73 +3492,10 @@ static inline struct page *skb_frag_page(const skb_frag_t *frag)
 	return netmem_to_page(frag->netmem);
 }
 
-/**
- * __skb_frag_ref - take an addition reference on a paged fragment.
- * @frag: the paged fragment
- *
- * Takes an additional reference on the paged fragment @frag.
- */
-static inline void __skb_frag_ref(skb_frag_t *frag)
-{
-	get_page(skb_frag_page(frag));
-}
-
-/**
- * skb_frag_ref - take an addition reference on a paged fragment of an skb.
- * @skb: the buffer
- * @f: the fragment offset.
- *
- * Takes an additional reference on the @f'th paged fragment of @skb.
- */
-static inline void skb_frag_ref(struct sk_buff *skb, int f)
-{
-	__skb_frag_ref(&skb_shinfo(skb)->frags[f]);
-}
-
 int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
 		    unsigned int headroom);
 int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
 			 struct bpf_prog *prog);
-bool napi_pp_put_page(struct page *page);
-
-static inline void
-skb_page_unref(struct page *page, bool recycle)
-{
-#ifdef CONFIG_PAGE_POOL
-	if (recycle && napi_pp_put_page(page))
-		return;
-#endif
-	put_page(page);
-}
-
-/**
- * __skb_frag_unref - release a reference on a paged fragment.
- * @frag: the paged fragment
- * @recycle: recycle the page if allocated via page_pool
- *
- * Releases a reference on the paged fragment @frag
- * or recycles the page via the page_pool API.
- */
-static inline void __skb_frag_unref(skb_frag_t *frag, bool recycle)
-{
-	skb_page_unref(skb_frag_page(frag), recycle);
-}
-
-/**
- * skb_frag_unref - release a reference on a paged fragment of an skb.
- * @skb: the buffer
- * @f: the fragment offset
- *
- * Releases a reference on the @f'th paged fragment of @skb.
- */
-static inline void skb_frag_unref(struct sk_buff *skb, int f)
-{
-	struct skb_shared_info *shinfo = skb_shinfo(skb);
-
-	if (!skb_zcopy_managed(skb))
-		__skb_frag_unref(&shinfo->frags[f], skb->pp_recycle);
-}
-
 /**
  * skb_frag_address - gets the address of the data contained in a paged fragment
  * @frag: the paged fragment buffer
diff --git a/include/linux/skbuff_ref.h b/include/linux/skbuff_ref.h
new file mode 100644
index 000000000000..11f0a4063403
--- /dev/null
+++ b/include/linux/skbuff_ref.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *	Skb ref helpers.
+ *
+ */
+
+#ifndef _LINUX_SKBUFF_REF_H
+#define _LINUX_SKBUFF_REF_H
+
+#include <linux/skbuff.h>
+
+/**
+ * __skb_frag_ref - take an addition reference on a paged fragment.
+ * @frag: the paged fragment
+ *
+ * Takes an additional reference on the paged fragment @frag.
+ */
+static inline void __skb_frag_ref(skb_frag_t *frag)
+{
+	get_page(skb_frag_page(frag));
+}
+
+/**
+ * skb_frag_ref - take an addition reference on a paged fragment of an skb.
+ * @skb: the buffer
+ * @f: the fragment offset.
+ *
+ * Takes an additional reference on the @f'th paged fragment of @skb.
+ */
+static inline void skb_frag_ref(struct sk_buff *skb, int f)
+{
+	__skb_frag_ref(&skb_shinfo(skb)->frags[f]);
+}
+
+bool napi_pp_put_page(struct page *page);
+
+static inline void
+skb_page_unref(struct page *page, bool recycle)
+{
+#ifdef CONFIG_PAGE_POOL
+	if (recycle && napi_pp_put_page(page))
+		return;
+#endif
+	put_page(page);
+}
+
+/**
+ * __skb_frag_unref - release a reference on a paged fragment.
+ * @frag: the paged fragment
+ * @recycle: recycle the page if allocated via page_pool
+ *
+ * Releases a reference on the paged fragment @frag
+ * or recycles the page via the page_pool API.
+ */
+static inline void __skb_frag_unref(skb_frag_t *frag, bool recycle)
+{
+	skb_page_unref(skb_frag_page(frag), recycle);
+}
+
+/**
+ * skb_frag_unref - release a reference on a paged fragment of an skb.
+ * @skb: the buffer
+ * @f: the fragment offset
+ *
+ * Releases a reference on the @f'th paged fragment of @skb.
+ */
+static inline void skb_frag_unref(struct sk_buff *skb, int f)
+{
+	struct skb_shared_info *shinfo = skb_shinfo(skb);
+
+	if (!skb_zcopy_managed(skb))
+		__skb_frag_unref(&shinfo->frags[f], skb->pp_recycle);
+}
+
+#endif	/* _LINUX_SKBUFF_REF_H */
diff --git a/net/core/gro.c b/net/core/gro.c
index 83f35d99a682..2459ab697f7f 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -3,6 +3,7 @@
 #include <net/dst_metadata.h>
 #include <net/busy_poll.h>
 #include <trace/events/net.h>
+#include <linux/skbuff_ref.h>
 
 #define MAX_GRO_SKBS 8
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 888874ef8566..38c09a70adc1 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -51,6 +51,7 @@
 #endif
 #include <linux/string.h>
 #include <linux/skbuff.h>
+#include <linux/skbuff_ref.h>
 #include <linux/splice.h>
 #include <linux/cache.h>
 #include <linux/rtnetlink.h>
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 40330253f076..dff04580318f 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -20,6 +20,7 @@
 #include <net/udp.h>
 #include <net/tcp.h>
 #include <net/espintcp.h>
+#include <linux/skbuff_ref.h>
 
 #include <linux/highmem.h>
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 9282fafc0e61..61119d42b0fd 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -44,6 +44,7 @@
 #include <linux/gfp.h>
 #include <linux/module.h>
 #include <linux/static_key.h>
+#include <linux/skbuff_ref.h>
 
 #include <trace/events/tcp.h>
 
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index fb431d0a3475..6bc0a84c8d05 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -36,6 +36,7 @@
 #include <net/tcp.h>
 #include <net/espintcp.h>
 #include <net/inet6_hashtables.h>
+#include <linux/skbuff_ref.h>
 
 #include <linux/highmem.h>
 
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index bf8ed36b1ad6..ab6e694f7bc2 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -37,6 +37,7 @@
 #include <net/inet_connection_sock.h>
 #include <net/tcp.h>
 #include <net/tls.h>
+#include <linux/skbuff_ref.h>
 
 #include "tls.h"
 #include "trace.h"
diff --git a/net/tls/tls_device_fallback.c b/net/tls/tls_device_fallback.c
index 4e7228f275fa..f9e3d3d90dcf 100644
--- a/net/tls/tls_device_fallback.c
+++ b/net/tls/tls_device_fallback.c
@@ -33,6 +33,7 @@
 #include <crypto/aead.h>
 #include <crypto/scatterwalk.h>
 #include <net/ip6_checksum.h>
+#include <linux/skbuff_ref.h>
 
 #include "tls.h"
 
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index ca1e0e198ceb..58c4b06f4f0c 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2016 Tom Herbert <tom@herbertland.com> */
 
 #include <linux/skbuff.h>
+#include <linux/skbuff_ref.h>
 #include <linux/workqueue.h>
 #include <net/strparser.h>
 #include <net/tcp.h>
-- 
2.44.0.478.gd926399ef9-goog


