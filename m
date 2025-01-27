Return-Path: <linux-rdma+bounces-7258-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C147BA200B0
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jan 2025 23:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 788313A50FD
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jan 2025 22:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022441DC9A2;
	Mon, 27 Jan 2025 22:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4E8sbm1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16F81DC9AD;
	Mon, 27 Jan 2025 22:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738017539; cv=none; b=VYbPhgPEYagDUQv2Fa/eG3uMfd+dmB8aKPXvtc1esRyZ+BcBsrdViZavZO1k5qiEQzyVDFOcynxx63NK1cNjeDiLhPqpseg0MdgQv0I+4SmgHnpwlZb++zuJkXQmid63kB7AjkeWQcO5euoHmagA28qtgpFQoRoREERiO70losQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738017539; c=relaxed/simple;
	bh=zZV+2pn+ZuAYgEabFNvBWhziQ9Ptxfsx63rwYN2kkGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mO6Ya/OwFWyJ7BerDRbj7pAohJGQ/wIj4WSh4qAOoUwH75b4xZo1/PPBDTnmcp0onhgTXxDA1oRUfsqhdVge5ws0xg5OOUA7XMii3CtX2ZQXgTRMBvnQvs7rAzCq/6F8Fhn+BgouB+8lKzRT+oxp2VXqFMmqeAJUtl3c86SC5lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4E8sbm1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2B8C4CEE0;
	Mon, 27 Jan 2025 22:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738017539;
	bh=zZV+2pn+ZuAYgEabFNvBWhziQ9Ptxfsx63rwYN2kkGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n4E8sbm1krbJvndI4bZk45jfdwolfLT41Vw7u4tcnM/+KO3RzD6PNJF/9b4jAD/hz
	 nUuq2E2hk9hppDHA3tnRbQf+HDoc841Wm8KCsn4z/+JC/c1kzLvGoozuiS7cD+lg3F
	 DI23jZ0SPu5zWFpwoIT+9173/tdVigIeJzt/tibwJAA/8FdIbuGE8gX21ppL6xLgu3
	 5ZJt7jiO9N6vkfSX9o50se23eUks5tKFyaAtA2BaAb5hXSJsjW57TUEsCPN9H4uylJ
	 Sl579IcUgS2sEawqSfQYLm5aXq3OFA8hbNe4VeWKVVwbnYYZGMwnHJuI8dJrg4adU1
	 8BwZeJMrOJyaQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-rdma@vger.kernel.org,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] RDMA/rxe: switch to using the crc32 library
Date: Mon, 27 Jan 2025 14:38:37 -0800
Message-ID: <20250127223840.67280-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250127223840.67280-1-ebiggers@kernel.org>
References: <20250127223840.67280-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Now that the crc32() library function takes advantage of
architecture-specific optimizations, it is unnecessary to go through the
crypto API.  Just use crc32().  This is much simpler, and it improves
performance due to eliminating the crypto API overhead.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/infiniband/sw/rxe/Kconfig     |  3 +-
 drivers/infiniband/sw/rxe/rxe.c       |  3 --
 drivers/infiniband/sw/rxe/rxe.h       |  1 -
 drivers/infiniband/sw/rxe/rxe_icrc.c  | 61 ++-------------------------
 drivers/infiniband/sw/rxe/rxe_loc.h   |  1 -
 drivers/infiniband/sw/rxe/rxe_req.c   |  1 -
 drivers/infiniband/sw/rxe/rxe_verbs.c |  4 --
 drivers/infiniband/sw/rxe/rxe_verbs.h |  1 -
 8 files changed, 5 insertions(+), 70 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/Kconfig b/drivers/infiniband/sw/rxe/Kconfig
index 06b8dc5093f77..c180e7ebcfc5b 100644
--- a/drivers/infiniband/sw/rxe/Kconfig
+++ b/drivers/infiniband/sw/rxe/Kconfig
@@ -2,12 +2,11 @@
 config RDMA_RXE
 	tristate "Software RDMA over Ethernet (RoCE) driver"
 	depends on INET && PCI && INFINIBAND
 	depends on INFINIBAND_VIRT_DMA
 	select NET_UDP_TUNNEL
-	select CRYPTO
-	select CRYPTO_CRC32
+	select CRC32
 	help
 	This driver implements the InfiniBand RDMA transport over
 	the Linux network stack. It enables a system with a
 	standard Ethernet adapter to interoperate with a RoCE
 	adapter or with another system running the RXE driver.
diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 1ba4a0c8726ae..f8ac79ef70143 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -29,13 +29,10 @@ void rxe_dealloc(struct ib_device *ib_dev)
 	rxe_pool_cleanup(&rxe->mr_pool);
 	rxe_pool_cleanup(&rxe->mw_pool);
 
 	WARN_ON(!RB_EMPTY_ROOT(&rxe->mcg_tree));
 
-	if (rxe->tfm)
-		crypto_free_shash(rxe->tfm);
-
 	mutex_destroy(&rxe->usdev_lock);
 }
 
 /* initialize rxe device parameters */
 static void rxe_init_device_param(struct rxe_dev *rxe)
diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
index fe7f970667325..8db65731499d0 100644
--- a/drivers/infiniband/sw/rxe/rxe.h
+++ b/drivers/infiniband/sw/rxe/rxe.h
@@ -19,11 +19,10 @@
 #include <rdma/ib_pack.h>
 #include <rdma/ib_smi.h>
 #include <rdma/ib_umem.h>
 #include <rdma/ib_cache.h>
 #include <rdma/ib_addr.h>
-#include <crypto/hash.h>
 
 #include "rxe_net.h"
 #include "rxe_opcode.h"
 #include "rxe_hdr.h"
 #include "rxe_param.h"
diff --git a/drivers/infiniband/sw/rxe/rxe_icrc.c b/drivers/infiniband/sw/rxe/rxe_icrc.c
index c7b0b4673b959..63d03f0f71e38 100644
--- a/drivers/infiniband/sw/rxe/rxe_icrc.c
+++ b/drivers/infiniband/sw/rxe/rxe_icrc.c
@@ -7,62 +7,10 @@
 #include <linux/crc32.h>
 
 #include "rxe.h"
 #include "rxe_loc.h"
 
-/**
- * rxe_icrc_init() - Initialize crypto function for computing crc32
- * @rxe: rdma_rxe device object
- *
- * Return: 0 on success else an error
- */
-int rxe_icrc_init(struct rxe_dev *rxe)
-{
-	struct crypto_shash *tfm;
-
-	tfm = crypto_alloc_shash("crc32", 0, 0);
-	if (IS_ERR(tfm)) {
-		rxe_dbg_dev(rxe, "failed to init crc32 algorithm err: %ld\n",
-			       PTR_ERR(tfm));
-		return PTR_ERR(tfm);
-	}
-
-	rxe->tfm = tfm;
-
-	return 0;
-}
-
-/**
- * rxe_crc32() - Compute cumulative crc32 for a contiguous segment
- * @rxe: rdma_rxe device object
- * @crc: starting crc32 value from previous segments
- * @next: starting address of current segment
- * @len: length of current segment
- *
- * Return: the cumulative crc32 checksum
- */
-static u32 rxe_crc32(struct rxe_dev *rxe, u32 crc, void *next, size_t len)
-{
-	u32 icrc;
-	int err;
-
-	SHASH_DESC_ON_STACK(shash, rxe->tfm);
-
-	shash->tfm = rxe->tfm;
-	*(u32 *)shash_desc_ctx(shash) = crc;
-	err = crypto_shash_update(shash, next, len);
-	if (unlikely(err)) {
-		rxe_dbg_dev(rxe, "failed crc calculation, err: %d\n", err);
-		return crc32_le(crc, next, len);
-	}
-
-	icrc = *(u32 *)shash_desc_ctx(shash);
-	barrier_data(shash_desc_ctx(shash));
-
-	return icrc;
-}
-
 /**
  * rxe_icrc() - Compute the ICRC of a packet
  * @skb: packet buffer
  * @pkt: packet information
  *
@@ -117,19 +65,18 @@ static u32 rxe_icrc(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 
 	/* exclude bth.resv8a */
 	bth->qpn |= cpu_to_be32(~BTH_QPN_MASK);
 
 	/* Update the CRC with the first part of the headers. */
-	crc = rxe_crc32(pkt->rxe, crc, pshdr, hdr_size + RXE_BTH_BYTES);
+	crc = crc32(crc, pshdr, hdr_size + RXE_BTH_BYTES);
 
 	/* Update the CRC with the remainder of the headers. */
-	crc = rxe_crc32(pkt->rxe, crc, pkt->hdr + RXE_BTH_BYTES,
-			rxe_opcode[pkt->opcode].length - RXE_BTH_BYTES);
+	crc = crc32(crc, pkt->hdr + RXE_BTH_BYTES,
+		    rxe_opcode[pkt->opcode].length - RXE_BTH_BYTES);
 
 	/* Update the CRC with the payload. */
-	crc = rxe_crc32(pkt->rxe, crc, payload_addr(pkt),
-			payload_size(pkt) + bth_pad(pkt));
+	crc = crc32(crc, payload_addr(pkt), payload_size(pkt) + bth_pad(pkt));
 
 	/* Invert the CRC and return it. */
 	return ~crc;
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index ded46119151bb..c57ab8975c5d1 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -166,11 +166,10 @@ int rxe_completer(struct rxe_qp *qp);
 int rxe_requester(struct rxe_qp *qp);
 int rxe_sender(struct rxe_qp *qp);
 int rxe_receiver(struct rxe_qp *qp);
 
 /* rxe_icrc.c */
-int rxe_icrc_init(struct rxe_dev *rxe);
 int rxe_icrc_check(struct sk_buff *skb, struct rxe_pkt_info *pkt);
 void rxe_icrc_generate(struct sk_buff *skb, struct rxe_pkt_info *pkt);
 
 void rxe_resp_queue_pkt(struct rxe_qp *qp, struct sk_buff *skb);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 87a02f0deb000..9d0392df8a92f 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -3,11 +3,10 @@
  * Copyright (c) 2016 Mellanox Technologies Ltd. All rights reserved.
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
  */
 
 #include <linux/skbuff.h>
-#include <crypto/hash.h>
 
 #include "rxe.h"
 #include "rxe_loc.h"
 #include "rxe_queue.h"
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 6152a0fdfc8ca..c05379f8b4f57 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1531,14 +1531,10 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name,
 	ib_set_device_ops(dev, &rxe_dev_ops);
 	err = ib_device_set_netdev(&rxe->ib_dev, ndev, 1);
 	if (err)
 		return err;
 
-	err = rxe_icrc_init(rxe);
-	if (err)
-		return err;
-
 	err = ib_register_device(dev, ibdev_name, NULL);
 	if (err)
 		rxe_dbg_dev(rxe, "failed with error %d\n", err);
 
 	/*
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index 6573ceec0ef58..6e31134a5fa5b 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -400,11 +400,10 @@ struct rxe_dev {
 	u64			mmap_offset;
 
 	atomic64_t		stats_counters[RXE_NUM_OF_COUNTERS];
 
 	struct rxe_port		port;
-	struct crypto_shash	*tfm;
 };
 
 static inline struct net_device *rxe_ib_device_get_netdev(struct ib_device *dev)
 {
 	return ib_device_get_netdev(dev, RXE_PORT);
-- 
2.48.1


