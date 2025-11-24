Return-Path: <linux-rdma+bounces-14719-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 894CCC8201F
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 19:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FC0D4E7095
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 18:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB4A2D12EA;
	Mon, 24 Nov 2025 18:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="gYnevwT4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421D0221FDE;
	Mon, 24 Nov 2025 18:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764007344; cv=none; b=DjBdvJPtwBUvNofc45s/QC+kB4cQ1TG1foEfJYysI1G7InI7cr2dRaoqN/P9vmSnfMRhe6baXYP733DGzB6oRhAE49O1qCQhRICPVnt6FygWgaNfHS7li3CMz+495RdO87DKzEaB8CIwGDcdRY+wqRNIWj050LSdEqq1Mtmkx8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764007344; c=relaxed/simple;
	bh=YeV2MwnDP05Zb1IC+tafZYb3zovMsOiDD3PWAJz7MW8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p7HuKYTe8TxhMu1D93UFUJtC1yzS74RDIw5Y+IFHTLrnl8qXXyYlmCnlipcJQ9xz+jEEJB2zGagnFd7UcWrzdc2anF54MwO5m7LbgYgKF+CJerJ0/pGcjnKIIGz7rGJ9UyfvSdcoJpIcvNyW+TTS9o7xIuqNsbNGnf+4gYkzcOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=gYnevwT4; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AOI0tgY1286027;
	Mon, 24 Nov 2025 10:02:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=DKKmiJldAAbjTXbvOn
	004v2LQ7hV4/ttBq48Ok13XXA=; b=gYnevwT4wyTRcNx5Q8BhM/+WykBjG9R9lF
	OiuB1A+VtNwJTmYWYah2hqYepBnsWfnibOsJsZAI7Rur0zmnfl+TEiU3W+tzysea
	tVxApgu6iVZUyNb3m9pkBRKO4/5FJkB3ZiYdrnLRPYjZewpzz8kxhlUUvKAZFhVq
	VWFpZJoA00JPC+YGxZ2nkPHsgAOwy8meS9faxhSfturkvapHMzVRac1YIwA7+x4J
	N7QrQBoO0+n/hl/AytfgDfHY4SaGNZmOKepk072wlJMGEbPJd/wf1Umz9qvXWuak
	BJkpA8pqIj5OrO6OCCARQ8CEqzfEWFSOhqD9IYF2KkWOGW5oMAug==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4amsfdspb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 24 Nov 2025 10:02:15 -0800 (PST)
Received: from devvm16459.vll0.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Mon, 24 Nov 2025 18:02:14 +0000
From: Danielle Costantino <dcostantino@meta.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <gal@nvidia.com>, <tariqt@nvidia.com>,
        <pabeni@redhat.com>, <saeedm@nvidia.com>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Danielle Costantino <dcostantino@meta.com>
Subject: [PATCH net] net/mlx5e: Fix validation logic in rate limiting
Date: Mon, 24 Nov 2025 10:00:43 -0800
Message-ID: <20251124180043.2314428-1-dcostantino@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=eOYeTXp1 c=1 sm=1 tr=0 ts=69249da7 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VabnemYjAAAA:8
 a=f5JQLeoUy42qA3qHo0oA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: KJDih8XK6adOlzt7UgBJZ0W4EgN4Ht03
X-Proofpoint-ORIG-GUID: KJDih8XK6adOlzt7UgBJZ0W4EgN4Ht03
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDE1NiBTYWx0ZWRfX6zLjInB+lbGY
 vxXouyHGbj3iQ1CnK/hq7mfDh7lXxC5m3VJIlA3q4zprC63tzBZqnZcrts9wWU/tgVPRI2o7mAE
 IrzxaxB/qftQS/VjVXo4ubJT2uIJgXK6Ivrg6ZVGjqiRsNsvWZmlA08NLs/xzCj4rxfwvbxY3cC
 styi0kATBO4mQLTVDMcujmnP5eOXwQglyGVcdFNtWPcIEaiaFRfvkaKtRRDb5ignjEJlcavomlW
 cD2URn2gDndYcy2PpyOOqefc30zUPOPSIIfaeMV5duLYqt8wp3biZqleD3mbUU1syYnpbNr+G/Y
 EbNpa8Y/fPFA9DGBCdOa77XISNN/rO8OKzcmuPsG4Bx3TstE/XKTEDgJxpu0Vz5epYtagHai7U0
 Cp3PudJTxp5U7iW5Fw1RnxHQzKJ2eQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_07,2025-11-24_02,2025-10-01_01

The rate limiting validation condition currently checks the output
variable max_bw_value[i] instead of the input value
maxrate->tc_maxrate[i]. This causes the validation to compare an
uninitialized or stale value rather than the actual requested rate.

The condition should check the input rate to properly validate against
the upper limit:

    } else if (maxrate->tc_maxrate[i] <= upper_limit_gbps) {

This aligns with the pattern used in the first branch, which correctly
checks maxrate->tc_maxrate[i] against upper_limit_mbps.

The current implementation can lead to unreliable validation behavior:

- For rates between 25.5 Gbps and 255 Gbps, if max_bw_value[i] is 0
  from initialization, the GBPS path may be taken regardless of whether
  the actual rate is within bounds

- When processing multiple TCs (i > 0), max_bw_value[i] contains the
  value computed for the previous TC, affecting the validation logic

- The overflow check for rates exceeding 255 Gbps may not trigger
  consistently depending on previous array values

This patch ensures the validation correctly examines the requested rate
value for proper bounds checking.

Fixes: 43b27d1bd88a ("net/mlx5e: Fix wraparound in rate limiting for values above 255 Gbps")
Signed-off-by: Danielle Costantino <dcostantino@meta.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
index d88a48210fdc..08b7ca5c3b5e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
@@ -614,7 +614,7 @@ static int mlx5e_dcbnl_ieee_setmaxrate(struct net_device *netdev,
 						  MLX5E_100MB);
 			max_bw_value[i] = max_bw_value[i] ? max_bw_value[i] : 1;
 			max_bw_unit[i]  = MLX5_100_MBPS_UNIT;
-		} else if (max_bw_value[i] <= upper_limit_gbps) {
+		} else if (maxrate->tc_maxrate[i] <= upper_limit_gbps) {
 			max_bw_value[i] = div_u64(maxrate->tc_maxrate[i],
 						  MLX5E_1GB);
 			max_bw_unit[i]  = MLX5_GBPS_UNIT;
--
2.47.1

