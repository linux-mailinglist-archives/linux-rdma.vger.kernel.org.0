Return-Path: <linux-rdma+bounces-7257-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 456E2A200AF
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jan 2025 23:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D17D43A54EF
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jan 2025 22:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA7D1DC9B3;
	Mon, 27 Jan 2025 22:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aM12lIaF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EC41DC99A;
	Mon, 27 Jan 2025 22:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738017539; cv=none; b=LA3z9e+gNSdrg99QWOIiL26PSAxh8Ek02wtivSxl9prtnLYm7eOJhQn8nGECGnYpYAK92RI01FpibpdIpQK1++PZrahjmjWnovUet9ryM17G/fluSFv3w78oUYTFnh/TEtQuxp8acHjIwHvSKE3RXQc8J+jC6BDOwF+Suclujec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738017539; c=relaxed/simple;
	bh=RcffRuLM1HcK81UB5AITUqZeaIYml6UqCkQoXQ0R/Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KRRinbfgiBHHVc+4fvQFpnQJd5CRDbUxjdPCAOPJbZ/YGkQXtAIh+mACratFL5xd6iiCvvcdr+WilwbOdGXkLNaQ3PJDiUWUNfJJTnLehsWxwQt1dklo8RW4uJ5CwmdHaXY2jfJPQOTL79HcgiOjAT5Ft5gP5iZtK0jgFLVo48w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aM12lIaF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A519AC4CEE2;
	Mon, 27 Jan 2025 22:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738017538;
	bh=RcffRuLM1HcK81UB5AITUqZeaIYml6UqCkQoXQ0R/Lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aM12lIaF7g51vEvycs/hO5JriSdeKel+inG/QqQYM/lxBGeIegY3iff2e8ahI3TA0
	 X9NbDFYayxRL7Dmp9eIxqxBiWSeW1yKsBATj9ixhY+5XTUwNyPZ/St5sczLBiRpYGg
	 7IgOqh4yj+H1IxSCv+wvHMATRWB40gsTcGn0Lgx1n7QoDlEyvAv0W30W5Xfp2uUeQ0
	 B6E9+VXcpM6nAje+ejOaNsDc/3NoMzqKy/at4NfZsfBdc0n2gMqUZ0hJUiF4pBrA7h
	 hn6a+8Y0GbK7X4mYwytyAn3e3pQEKTkVnikK/ZDdTYTevZxWJirQy7iz0PZ/JC+8q5
	 xjQrFtWLRAK+A==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-rdma@vger.kernel.org,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] RDMA/rxe: consolidate code for calculating ICRC of packets
Date: Mon, 27 Jan 2025 14:38:36 -0800
Message-ID: <20250127223840.67280-3-ebiggers@kernel.org>
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

Since rxe_icrc_hdr() is always immediately followed by updating the CRC
with the packet's payload, just rename it to rxe_icrc() and make it
include the payload in the CRC, so it now handles the entire packet.

This is a refactor with no change in behavior.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/infiniband/sw/rxe/rxe_icrc.c | 36 ++++++++++++----------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_icrc.c b/drivers/infiniband/sw/rxe/rxe_icrc.c
index ee417a0bbbdca..c7b0b4673b959 100644
--- a/drivers/infiniband/sw/rxe/rxe_icrc.c
+++ b/drivers/infiniband/sw/rxe/rxe_icrc.c
@@ -60,26 +60,24 @@ static u32 rxe_crc32(struct rxe_dev *rxe, u32 crc, void *next, size_t len)
 
 	return icrc;
 }
 
 /**
- * rxe_icrc_hdr() - Compute the partial ICRC for the network and transport
- *		  headers of a packet.
+ * rxe_icrc() - Compute the ICRC of a packet
  * @skb: packet buffer
  * @pkt: packet information
  *
- * Return: the partial ICRC
+ * Return: the ICRC
  */
-static u32 rxe_icrc_hdr(struct sk_buff *skb, struct rxe_pkt_info *pkt)
+static u32 rxe_icrc(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 {
 	unsigned int bth_offset = 0;
 	struct iphdr *ip4h = NULL;
 	struct ipv6hdr *ip6h = NULL;
 	struct udphdr *udph;
 	struct rxe_bth *bth;
 	u32 crc;
-	int length;
 	int hdr_size = sizeof(struct udphdr) +
 		(skb->protocol == htons(ETH_P_IP) ?
 		sizeof(struct iphdr) : sizeof(struct ipv6hdr));
 	/* pseudo header buffer size is calculate using ipv6 header size since
 	 * it is bigger than ipv4
@@ -118,17 +116,23 @@ static u32 rxe_icrc_hdr(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 	bth = (struct rxe_bth *)&pshdr[bth_offset];
 
 	/* exclude bth.resv8a */
 	bth->qpn |= cpu_to_be32(~BTH_QPN_MASK);
 
-	length = hdr_size + RXE_BTH_BYTES;
-	crc = rxe_crc32(pkt->rxe, crc, pshdr, length);
+	/* Update the CRC with the first part of the headers. */
+	crc = rxe_crc32(pkt->rxe, crc, pshdr, hdr_size + RXE_BTH_BYTES);
 
-	/* And finish to compute the CRC on the remainder of the headers. */
+	/* Update the CRC with the remainder of the headers. */
 	crc = rxe_crc32(pkt->rxe, crc, pkt->hdr + RXE_BTH_BYTES,
 			rxe_opcode[pkt->opcode].length - RXE_BTH_BYTES);
-	return crc;
+
+	/* Update the CRC with the payload. */
+	crc = rxe_crc32(pkt->rxe, crc, payload_addr(pkt),
+			payload_size(pkt) + bth_pad(pkt));
+
+	/* Invert the CRC and return it. */
+	return ~crc;
 }
 
 /**
  * rxe_icrc_check() - Compute ICRC for a packet and compare to the ICRC
  *		      delivered in the packet.
@@ -146,18 +150,12 @@ int rxe_icrc_check(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 	 * descending order from the x^31 coefficient to the x^0 one.  When the
 	 * result is interpreted as a 32-bit integer using the required reverse
 	 * mapping between bits and polynomial coefficients, it's a __le32.
 	 */
 	__le32 *icrcp = (__le32 *)(pkt->hdr + pkt->paylen - RXE_ICRC_SIZE);
-	u32 icrc;
 
-	icrc = rxe_icrc_hdr(skb, pkt);
-	icrc = rxe_crc32(pkt->rxe, icrc, (u8 *)payload_addr(pkt),
-				payload_size(pkt) + bth_pad(pkt));
-	icrc = ~icrc;
-
-	if (unlikely(icrc != le32_to_cpu(*icrcp)))
+	if (unlikely(rxe_icrc(skb, pkt) != le32_to_cpu(*icrcp)))
 		return -EINVAL;
 
 	return 0;
 }
 
@@ -167,12 +165,8 @@ int rxe_icrc_check(struct sk_buff *skb, struct rxe_pkt_info *pkt)
  * @pkt: packet information
  */
 void rxe_icrc_generate(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 {
 	__le32 *icrcp = (__le32 *)(pkt->hdr + pkt->paylen - RXE_ICRC_SIZE);
-	u32 icrc;
 
-	icrc = rxe_icrc_hdr(skb, pkt);
-	icrc = rxe_crc32(pkt->rxe, icrc, (u8 *)payload_addr(pkt),
-				payload_size(pkt) + bth_pad(pkt));
-	*icrcp = cpu_to_le32(~icrc);
+	*icrcp = cpu_to_le32(rxe_icrc(skb, pkt));
 }
-- 
2.48.1


