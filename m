Return-Path: <linux-rdma+bounces-4402-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E22955B1B
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Aug 2024 08:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F64F1C21079
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Aug 2024 06:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54136D512;
	Sun, 18 Aug 2024 06:10:14 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCEFD268
	for <linux-rdma@vger.kernel.org>; Sun, 18 Aug 2024 06:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723961414; cv=none; b=hiqY2JCwcXXi8iKOpphLPnfeM1o1aHow0IaugdMM4wpmQDIheXMo7C1nuBvACK4yaBBZmrZYVpnIybLDgw0/NaVRyzu2DMfkpRPqHx511vj6vx2UsZOpEkgcFUBghnxrTuvKop+9ZSmHCiptCoTJmHR2SZcbo6gdRpm9umWuaa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723961414; c=relaxed/simple;
	bh=GWptzQ+DLrYf1Wp5yohH63l2h/rZ8UogC7ZLLU9jVN4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nzbbPPY1Fvkonr44M570J+BnUvWwwEYGqQJhTsBeU1JeidV1QH5hrQLx0zCpp+E+KpunuDAlQmgAhm3uHM7sMj249UZD0+g5Dv2uZTt2Zy1lRE5puj1gCeF1AvfTwou6dE1Iztlys9VNvHAO3PJ3er67fUL4Ss3qAtIdy8B7dmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WmlgB4Y6Mz13L8p;
	Sun, 18 Aug 2024 14:09:26 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 51CB41800F2;
	Sun, 18 Aug 2024 14:10:01 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sun, 18 Aug
 2024 14:10:00 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>, <phaddad@nvidia.com>,
	<linux-rdma@vger.kernel.org>
CC: <zhangzekun11@huawei.com>
Subject: [PATCH net-next 0/2] RDMA: Some clean up in header files
Date: Sun, 18 Aug 2024 13:57:00 +0800
Message-ID: <20240818055702.79547-1-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf500003.china.huawei.com (7.202.181.241)

There are some unused declartions in header files. Do some
clean up to remove these unused declarations.

Zhang Zekun (2):
  RDMA/core: Remove unused declaration rdma_resolve_ip_route()
  RDMA/ipoib: Remove unused declarations

 drivers/infiniband/core/core_priv.h  | 3 ---
 drivers/infiniband/ulp/ipoib/ipoib.h | 4 ----
 2 files changed, 7 deletions(-)

-- 
2.17.1


