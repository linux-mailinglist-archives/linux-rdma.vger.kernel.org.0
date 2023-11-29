Return-Path: <linux-rdma+bounces-125-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 994387FCD76
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Nov 2023 04:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E18E72833C4
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Nov 2023 03:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4290853BF;
	Wed, 29 Nov 2023 03:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XlO1uiEX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E96519AD
	for <linux-rdma@vger.kernel.org>; Tue, 28 Nov 2023 19:24:42 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701228280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oXdVgmpZ1NTCUKVYv/QN7S6BoGc1lD1Eo91azgDYguM=;
	b=XlO1uiEX58BoOS36WyNqh2q6+Ea1bciQNJMpg87oJ5vbq3AEg+MIqptzVkl2ohhu96nLkJ
	R91YMf1jTzo80PUhdNEHoX+yl8sDSj4Bv+Y9znKk+cIageHAjHp4ZYksY5UKQ2wZ9esId0
	K02uRwTNpQubf4UFEbJ57fLl84ChJkw=
From: Guoqing Jiang <guoqing.jiang@linux.dev>
To: bmt@zurich.ibm.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	guoqing.jiang@linux.dev
Subject: [PATCH 0/4] Misc changes for siw
Date: Wed, 29 Nov 2023 11:24:14 +0800
Message-Id: <20231129032418.26705-1-guoqing.jiang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

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


