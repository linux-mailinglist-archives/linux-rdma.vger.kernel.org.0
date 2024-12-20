Return-Path: <linux-rdma+bounces-6675-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D72B09F8C8D
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2024 07:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B996D169A52
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2024 06:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9DB1A4E77;
	Fri, 20 Dec 2024 06:19:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150C519C578;
	Fri, 20 Dec 2024 06:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734675569; cv=none; b=l0VylKU8XdbWmanFE4/1NNT6CMj2Yu9M3A/snM5XL+Ncq5zxJpuDpijbHQQIUQYvSuu93sDUdR1+rfjH2o83YKcBj7C8yo2JMzBWMPeejaBq3LiLash76nRkaQuO2rZv5nXNRuqTetP+PF3N363vSWmre8fQ1+oC3MEa3PPFLYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734675569; c=relaxed/simple;
	bh=TdeGCyixQEtdmOHI8u9MafcRtTwQVVmwxsoMwSLtM5I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OQpKHSfuVyQ3luiioSTULEindJ+QF/nF2wMnt4gs49jbRG9E/sFoocRJXVtct1C8t3hr+h2Rj6p2dXJJcWEFvDi3zjEKd0+OhkZaxk0Oon3TgwyTBIg2XL3D2kcVZBs6YuDlbukAUhfYw5FkJbp2JNXgUc9psjo3FlAKXSvAgK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YDxXR5pfXz21nqT;
	Fri, 20 Dec 2024 13:57:43 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 2C3A4140202;
	Fri, 20 Dec 2024 13:59:38 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 20 Dec 2024 13:59:37 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
	<tangchengchang@huawei.com>
Subject: [PATCH for-rc 0/4] RDMA/hns: Bugfixes
Date: Fri, 20 Dec 2024 13:52:45 +0800
Message-ID: <20241220055249.146943-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf100018.china.huawei.com (7.202.181.17)

Here are some recent bugfixes for hns.

Chengchang Tang (3):
  RDMA/hns: Fix accessing invalid dip_ctx during destroying QP
  RDMA/hns: Fix warning storm caused by invalid input in IO path
  RDMA/hns: Fix missing flush CQE for DWQE

wenglianfa (1):
  RDMA/hns: Fix mapping error of zero-hop WQE buffer

 drivers/infiniband/hw/hns/hns_roce_hem.c   | 43 +++++++++++++++-------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 11 +++++-
 drivers/infiniband/hw/hns/hns_roce_mr.c    |  5 ---
 3 files changed, 38 insertions(+), 21 deletions(-)

--
2.33.0


