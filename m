Return-Path: <linux-rdma+bounces-7255-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB260A200AB
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jan 2025 23:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2EAC3A5378
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jan 2025 22:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61111DB546;
	Mon, 27 Jan 2025 22:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+yCrWH6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E481D95B3;
	Mon, 27 Jan 2025 22:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738017538; cv=none; b=LWynrdcGq4PUdXaPr5C+sP9Ie21uy7LMvUvvNLE5fNMHTKzoVy0VL9n0ro6UZdozs5t6NgybggO0SwnAzD+iKghi2EERAF6jlRcNkbfGiXhbgPlRmNiK7XEKVbVmacOSqpA87AyteoGrRfTHCuBBgDrXtroeBNyvjIrI4UkiBYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738017538; c=relaxed/simple;
	bh=AdUG2oG1qWlGDUzaatWr141MRlZ6IfJJpmCsLymetus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r6k80vRHc8gfCMP2NoSniJRhAnSZxMGOguyJk6MTv+68bWDEGwjU0a3jKXbDl1BiqIwrZJhqgYEJiBuc1AoZ/bWI9b6juuy2G8CoEh/tryy6GcyEe06QHlmMexKpDHOMnVNduvHf1w2MjmECfF3XUAB9zM/ABpWV0vlRe9JXHNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+yCrWH6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474CEC4CEE3;
	Mon, 27 Jan 2025 22:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738017538;
	bh=AdUG2oG1qWlGDUzaatWr141MRlZ6IfJJpmCsLymetus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N+yCrWH62yygIT+MZf+sWNXNQ+kc9jshsP9MDjPCcCnWSQR/SKjnRBzlYCsQgNKVV
	 K+ja92LfDab3WI8WFWxSTUd2MjIvt1t51k0fcTs691vQe+SKVtZkFDMknGTXtvrcrJ
	 0dci7u7xqC/HLmkH9/AkdGQ1RdtYOxN4doQx9lzygIRJEx3ppT4Ke0lWe7BjMJp6/z
	 slJCegPmwGno2WqLxqtHXgZUme9bTBmjFNm5C3c7Lc4yZ1c76deQxNRCRSbdRNr9IV
	 Hoplmx4sN+e/HQdIi0x1CdYLrBsW3qXc7OMsKKGQsOURuwIB6TNF5HvALWeWZcrZrF
	 H++/uenKNSKkA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-rdma@vger.kernel.org,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] RDMA/rxe: handle ICRC correctly on big endian systems
Date: Mon, 27 Jan 2025 14:38:35 -0800
Message-ID: <20250127223840.67280-2-ebiggers@kernel.org>
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

The usual big endian convention of InfiniBand does not apply to the
ICRC field, whose transmission is specified in terms of the CRC32
polynomial coefficients.  The coefficients are transmitted in
descending order from the x^31 coefficient to the x^0 one.  When the
result is interpreted as a 32-bit integer using the required reverse
mapping between bits and polynomial coefficients, it's a __le32.

The code used __be32, but it did not actually do an endianness
conversion.  So it actually just used the CPU's native endianness,
making it comply with the spec on little endian systems only.

Fix the code to use __le32 and do the needed le32_to_cpu() and
cpu_to_le32() so that it complies with the spec on big endian systems.

Also update the lower-level helper functions to use u32, as they are
working with CPU native values.  This part does not change behavior.

Found through code review.  I don't know whether anyone is actually
using this code on big endian systems.  Probably not.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/infiniband/sw/rxe/rxe_icrc.c | 41 +++++++++++++++-------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_icrc.c b/drivers/infiniband/sw/rxe/rxe_icrc.c
index fdf5f08cd8f17..ee417a0bbbdca 100644
--- a/drivers/infiniband/sw/rxe/rxe_icrc.c
+++ b/drivers/infiniband/sw/rxe/rxe_icrc.c
@@ -38,26 +38,26 @@ int rxe_icrc_init(struct rxe_dev *rxe)
  * @next: starting address of current segment
  * @len: length of current segment
  *
  * Return: the cumulative crc32 checksum
  */
-static __be32 rxe_crc32(struct rxe_dev *rxe, __be32 crc, void *next, size_t len)
+static u32 rxe_crc32(struct rxe_dev *rxe, u32 crc, void *next, size_t len)
 {
-	__be32 icrc;
+	u32 icrc;
 	int err;
 
 	SHASH_DESC_ON_STACK(shash, rxe->tfm);
 
 	shash->tfm = rxe->tfm;
-	*(__be32 *)shash_desc_ctx(shash) = crc;
+	*(u32 *)shash_desc_ctx(shash) = crc;
 	err = crypto_shash_update(shash, next, len);
 	if (unlikely(err)) {
 		rxe_dbg_dev(rxe, "failed crc calculation, err: %d\n", err);
-		return (__force __be32)crc32_le((__force u32)crc, next, len);
+		return crc32_le(crc, next, len);
 	}
 
-	icrc = *(__be32 *)shash_desc_ctx(shash);
+	icrc = *(u32 *)shash_desc_ctx(shash);
 	barrier_data(shash_desc_ctx(shash));
 
 	return icrc;
 }
 
@@ -67,18 +67,18 @@ static __be32 rxe_crc32(struct rxe_dev *rxe, __be32 crc, void *next, size_t len)
  * @skb: packet buffer
  * @pkt: packet information
  *
  * Return: the partial ICRC
  */
-static __be32 rxe_icrc_hdr(struct sk_buff *skb, struct rxe_pkt_info *pkt)
+static u32 rxe_icrc_hdr(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 {
 	unsigned int bth_offset = 0;
 	struct iphdr *ip4h = NULL;
 	struct ipv6hdr *ip6h = NULL;
 	struct udphdr *udph;
 	struct rxe_bth *bth;
-	__be32 crc;
+	u32 crc;
 	int length;
 	int hdr_size = sizeof(struct udphdr) +
 		(skb->protocol == htons(ETH_P_IP) ?
 		sizeof(struct iphdr) : sizeof(struct ipv6hdr));
 	/* pseudo header buffer size is calculate using ipv6 header size since
@@ -89,11 +89,11 @@ static __be32 rxe_icrc_hdr(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 		RXE_BTH_BYTES];
 
 	/* This seed is the result of computing a CRC with a seed of
 	 * 0xfffffff and 8 bytes of 0xff representing a masked LRH.
 	 */
-	crc = (__force __be32)0xdebb20e3;
+	crc = 0xdebb20e3;
 
 	if (skb->protocol == htons(ETH_P_IP)) { /* IPv4 */
 		memcpy(pshdr, ip_hdr(skb), hdr_size);
 		ip4h = (struct iphdr *)pshdr;
 		udph = (struct udphdr *)(ip4h + 1);
@@ -137,23 +137,27 @@ static __be32 rxe_icrc_hdr(struct sk_buff *skb, struct rxe_pkt_info *pkt)
  *
  * Return: 0 if the values match else an error
  */
 int rxe_icrc_check(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 {
-	__be32 *icrcp;
-	__be32 pkt_icrc;
-	__be32 icrc;
-
-	icrcp = (__be32 *)(pkt->hdr + pkt->paylen - RXE_ICRC_SIZE);
-	pkt_icrc = *icrcp;
+	/*
+	 * The usual big endian convention of InfiniBand does not apply to the
+	 * ICRC field, whose transmission is specified in terms of the CRC32
+	 * polynomial coefficients.  The coefficients are transmitted in
+	 * descending order from the x^31 coefficient to the x^0 one.  When the
+	 * result is interpreted as a 32-bit integer using the required reverse
+	 * mapping between bits and polynomial coefficients, it's a __le32.
+	 */
+	__le32 *icrcp = (__le32 *)(pkt->hdr + pkt->paylen - RXE_ICRC_SIZE);
+	u32 icrc;
 
 	icrc = rxe_icrc_hdr(skb, pkt);
 	icrc = rxe_crc32(pkt->rxe, icrc, (u8 *)payload_addr(pkt),
 				payload_size(pkt) + bth_pad(pkt));
 	icrc = ~icrc;
 
-	if (unlikely(icrc != pkt_icrc))
+	if (unlikely(icrc != le32_to_cpu(*icrcp)))
 		return -EINVAL;
 
 	return 0;
 }
 
@@ -162,14 +166,13 @@ int rxe_icrc_check(struct sk_buff *skb, struct rxe_pkt_info *pkt)
  * @skb: packet buffer
  * @pkt: packet information
  */
 void rxe_icrc_generate(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 {
-	__be32 *icrcp;
-	__be32 icrc;
+	__le32 *icrcp = (__le32 *)(pkt->hdr + pkt->paylen - RXE_ICRC_SIZE);
+	u32 icrc;
 
-	icrcp = (__be32 *)(pkt->hdr + pkt->paylen - RXE_ICRC_SIZE);
 	icrc = rxe_icrc_hdr(skb, pkt);
 	icrc = rxe_crc32(pkt->rxe, icrc, (u8 *)payload_addr(pkt),
 				payload_size(pkt) + bth_pad(pkt));
-	*icrcp = ~icrc;
+	*icrcp = cpu_to_le32(~icrc);
 }
-- 
2.48.1


