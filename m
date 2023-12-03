Return-Path: <linux-rdma+bounces-184-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B86CC80223B
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Dec 2023 10:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAC481C208BE
	for <lists+linux-rdma@lfdr.de>; Sun,  3 Dec 2023 09:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8B479E0;
	Sun,  3 Dec 2023 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dwx4bOk+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [IPv6:2001:41d0:203:375::ae])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3724E7
	for <linux-rdma@vger.kernel.org>; Sun,  3 Dec 2023 01:27:35 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701595652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s0TikuCYyL5y892f4EYxpW1CHdKFinNLwfVUKbsLwRA=;
	b=Dwx4bOk+uBiPNkKBdKWSZrYY+Zj29gAxvL9xjjedz4ZbDr7cnCJKWXg7U64mXabSBL3ceC
	RcW57DZpiD//cDS5KOJoF3Ad4JMsDW9v6jwW2CabAvsbT9MG0ReP21qtyHJGsVvIdwYipT
	RFBjwGULQOc1dU8245nUF/+kk1wIk5k=
From: Guoqing Jiang <guoqing.jiang@linux.dev>
To: bmt@zurich.ibm.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	guoqing.jiang@linux.dev
Subject: [PATCH V2 0/4] Misc changes for siw
Date: Sun,  3 Dec 2023 17:26:51 +0800
Message-Id: <20231203092655.28102-1-guoqing.jiang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

V2 changes:
1. Collect tags from Bernard.
2. Use SIW_QP_STATE_COUNT for siw_qp_state_to_ib_qp_state.
3. Update commite message for the last patch.

Thanks for Bernard's review!

Hi,

The first two patches try to reduce memory usage, the third
one fix test_query_rc_qp failure, and the last one clean up
code a bit.

Please review.

Thanks,
Guoqing

Guoqing Jiang (4):
  RDMA/siw: Move tx_cpu ahead
  RDMA/siw: Reduce memory usage of struct siw_rx_stream
  RDMA/siw: Set qp_state in siw_query_qp
  RDMA/siw: Call orq_get_current if possible

 drivers/infiniband/sw/siw/siw.h       | 10 +++++-----
 drivers/infiniband/sw/siw/siw_verbs.c | 10 ++++++++++
 2 files changed, 15 insertions(+), 5 deletions(-)


base-commit: 50af5d12f7e24b85fc10270d7700f4aa1b20b8e4
-- 
2.35.3


