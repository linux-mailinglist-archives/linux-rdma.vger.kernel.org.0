Return-Path: <linux-rdma+bounces-941-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 618E984C320
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Feb 2024 04:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E36228DD46
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Feb 2024 03:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21FEFC08;
	Wed,  7 Feb 2024 03:33:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6B1101CF;
	Wed,  7 Feb 2024 03:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707276802; cv=none; b=fp7pckNcKAvR0vnhzHTJWcP3zeB1MZgDN/EdH6+qre9YeZfMSZ053jS0ozLLIn4hxB586E2K4fD2+1lDIUvVNb0EyuqKO3uzBxN4T11IXp5b2okTjA94nRz735cGc2uYPeRKXbTvzxANKzPbiavvk1RZkRiVM5yEeM4jbENaltM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707276802; c=relaxed/simple;
	bh=DFEuQkmh3iC8Rt5IU5gJZWJ6GZEyZRD+JKcJbIgSEBo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YDuBaPfJBJ/gvy1zWSsY5nbRwm0F95R39uhR1s3EKmUy/2lgTYeOwUNatr2+ceLADvWLZXPcx3SheTwWFPJ79xZqeTiYhSTklOEXSDfM7L72zK8iqxO4hyxpXu7XZG8+kJXwH/sy5cnWsCNuHCc2C+Gr1Aa5YURXT+uChZUJtM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TV5Hr5b19z29lWB;
	Wed,  7 Feb 2024 11:31:20 +0800 (CST)
Received: from kwepemi500006.china.huawei.com (unknown [7.221.188.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 2071B140113;
	Wed,  7 Feb 2024 11:33:17 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 11:33:16 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-next 0/2] RDMA/hns: Support configuring congestion control algorithm with QP granularity
Date: Wed, 7 Feb 2024 11:29:08 +0800
Message-ID: <20240207032910.3959426-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500006.china.huawei.com (7.221.188.68)

Patch #1 reverts a previous bugfix that was intended to add restriction
to congestion control algorithm for UD but mistakenly introduced other
problem.

Patch #2 adds support for configuring congestion control algorithm with
QP granularity. The algorithm restriction for UD is added in this patch.

Junxian Huang (1):
  RDMA/hns: Support configuring congestion control algorithm with QP
    granularity

Luoyouming (1):
  Revert "RDMA/hns: The UD mode can only be configured with DCQCN"

 drivers/infiniband/hw/hns/hns_roce_device.h | 26 +++++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 18 ++----
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  3 +-
 drivers/infiniband/hw/hns/hns_roce_main.c   |  3 +
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 71 +++++++++++++++++++++
 include/uapi/rdma/hns-abi.h                 | 17 +++++
 6 files changed, 118 insertions(+), 20 deletions(-)

--
2.30.0


