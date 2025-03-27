Return-Path: <linux-rdma+bounces-9009-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A539DA7312E
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Mar 2025 12:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C81DE3BBD58
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Mar 2025 11:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABFF213E8C;
	Thu, 27 Mar 2025 11:53:44 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A36C212D9E
	for <linux-rdma@vger.kernel.org>; Thu, 27 Mar 2025 11:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743076424; cv=none; b=bR5cICCaltBK/6U90tXnfI0Mb1bp9UIjZVIRfcEoL8f1qH0p7dAUDuBr1B8WEq7sn1b0EYPemPv+vxa2Iebe6s/7f5SuCzjunJI/iT+1/5zIue48gQmX6but/dXeXP6A41+EiV/c+JPNE7M4XbZ5SKGK293IO7EyQFV9iG+4UFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743076424; c=relaxed/simple;
	bh=mM3uz9BywIe6ImH7hQIhnMLZo7uTuDpG72E6ZY85JqI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wls30MOBEeH7z4Gj2s3jdIZscirdGjz5khf2CXLCLfziQRwb4K/59VfU+rEtrbKEsAlQ0eVsiKoZwLz4CXme+ig7+jhAf2rrCEnAUeNsMw2aWkqzWDkCECdxXwJ4MC19GEgNL1BHxqGC8trzMjCdlrd3tIffZyEulgbEt7T/VPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZNhm11KbjzTgZH;
	Thu, 27 Mar 2025 19:49:53 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 8B075140137;
	Thu, 27 Mar 2025 19:53:32 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 27 Mar 2025 19:53:32 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-next 0/2] RDMA/hns: Cleanup and Bugfix
Date: Thu, 27 Mar 2025 19:47:22 +0800
Message-ID: <20250327114724.3454268-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100018.china.huawei.com (7.202.181.17)

These are two simple patches, one for cleanup, the other for a HW
limit fix.

Chengchang Tang (2):
  RDMA/hns: Remove unused parameters
  RDMA/hns: Fix wrong maximum DMA segment size

 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 5 ++---
 drivers/infiniband/hw/hns/hns_roce_main.c  | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

--
2.33.0


