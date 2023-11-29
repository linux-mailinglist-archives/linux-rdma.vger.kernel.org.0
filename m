Return-Path: <linux-rdma+bounces-127-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DAB7FCD78
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Nov 2023 04:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DC881C20A81
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Nov 2023 03:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12B1523D;
	Wed, 29 Nov 2023 03:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A/X40f/O"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0B51AD
	for <linux-rdma@vger.kernel.org>; Tue, 28 Nov 2023 19:25:01 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701228300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J9Ozm7DPrsE3luK3/lo3v/CromQpLb5Eg4/mogLhpmA=;
	b=A/X40f/OmqVz+CVUvO5pc1WMRZh3QpBWzC/z/5WHExjy7wzsSCRybM7rXMEvNa53H+oxgM
	OlJkYY5nuOwxqseAhvK6sB0U45WSXsmQupzHJYC5bNkKkUw2nz6av+oZ6Zdlg1zWkBiJfw
	FxEcqtj+YVLpsrUUtyEztCie1dNyCYQ=
From: Guoqing Jiang <guoqing.jiang@linux.dev>
To: bmt@zurich.ibm.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	guoqing.jiang@linux.dev
Subject: [PATCH 2/4] RDMA/siw: Reduce memory usage of struct siw_rx_stream
Date: Wed, 29 Nov 2023 11:24:16 +0800
Message-Id: <20231129032418.26705-3-guoqing.jiang@linux.dev>
In-Reply-To: <20231129032418.26705-1-guoqing.jiang@linux.dev>
References: <20231129032418.26705-1-guoqing.jiang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

We can reduce the memory of the struct by move some of it's
member.

Before,

	/* size: 144, cachelines: 3, members: 17 */
	/* sum members: 124, holes: 3, sum holes: 12 */
	/* sum bitfield members: 7 bits (0 bytes) */
	/* padding: 7 */
	/* bit_padding: 1 bits */

After

	/* size: 128, cachelines: 2, members: 17 */
	/* padding: 3 */
	/* bit_padding: 1 bits */

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/infiniband/sw/siw/siw.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index d14bb965af75..2edba2a864bb 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -288,10 +288,11 @@ struct siw_rx_stream {
 	int skb_offset; /* offset in skb */
 	int skb_copied; /* processed bytes in skb */
 
+	enum siw_rx_state state;
+
 	union iwarp_hdr hdr;
 	struct mpa_trailer trailer;
-
-	enum siw_rx_state state;
+	struct shash_desc *mpa_crc_hd;
 
 	/*
 	 * For each FPDU, main RX loop runs through 3 stages:
@@ -313,7 +314,6 @@ struct siw_rx_stream {
 	u64 ddp_to;
 	u32 inval_stag; /* Stag to be invalidated */
 
-	struct shash_desc *mpa_crc_hd;
 	u8 rx_suspend : 1;
 	u8 pad : 2; /* # of pad bytes expected */
 	u8 rdmap_op : 4; /* opcode of current frame */
-- 
2.35.3


