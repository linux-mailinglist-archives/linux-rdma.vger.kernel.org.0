Return-Path: <linux-rdma+bounces-5851-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2D19C1767
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2024 09:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 331711F231E1
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2024 08:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662771CFEB0;
	Fri,  8 Nov 2024 08:04:12 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864E6194120;
	Fri,  8 Nov 2024 08:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731053052; cv=none; b=ORThOXBS21er0FfvhTsC4wu0Q6i/0oV6/2FNv4+WosdAs3WFd9W6UKU2GOf3TjQRgo0d3k2JQayqzXIoM60VIfBbLvfTPfHK+Xmgneub4jDL8qLSwA7BmqLjie3TKTD+cIbWo+Gvs3P/osTepzHjZnh11Ogyyio7285zisdeTXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731053052; c=relaxed/simple;
	bh=ktjCdGExNDPX/Vn9J57X5oRsvtOdRRkBihB/Ec1j6TA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h5o5A4xliYzXQqFVHiKGq1W4tA+UNKCyE0isMxvFIwnSQ+8vtUGtOljeq7GwQREpTpE+LK0slY6CJzXiUT0cOkZta4ew3nkmpKNqnD5F8RwVS68y6mqGPNGw1yPk/Okjltk5cLA5+BujPhQM9yA65nNxbWtrJw1j+O7wpjwoziQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XlBHf353yz1SDr6;
	Fri,  8 Nov 2024 16:02:22 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B24C1A016C;
	Fri,  8 Nov 2024 16:04:06 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 Nov 2024 16:04:05 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
	<tangchengchang@huawei.com>
Subject: [PATCH for-rc 0/2] RDMA/hns: Bugfixes
Date: Fri, 8 Nov 2024 15:57:41 +0800
Message-ID: <20241108075743.2652258-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf100018.china.huawei.com (7.202.181.17)

Two hns bugfixes.

Junxian Huang (2):
  RDMA/hns: Fix out-of-order issue of requester when setting FENCE
  RDMA/hns: Fix NULL pointer derefernce in hns_roce_map_mr_sg()

 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 1 +
 drivers/infiniband/hw/hns/hns_roce_mr.c    | 7 ++++---
 3 files changed, 6 insertions(+), 4 deletions(-)

--
2.33.0


