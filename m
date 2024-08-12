Return-Path: <linux-rdma+bounces-4334-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FB394ED94
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 15:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 024E51F21155
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 13:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BDF17BB0F;
	Mon, 12 Aug 2024 13:02:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C996A17A92F;
	Mon, 12 Aug 2024 13:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723467742; cv=none; b=cL5iF4oS5Lt1LUAFaRL5MiXNrfN02ecOE/EpTZempXaxmcaBcH0dtE0QHxoXfLFfG/TE+CnA1cdtXRpthIjd8qw5D+m2n8qhtF0974Xfo1whkWfvFPSJ2LMte2fBWNQ5XdTc+VCA2tR4UfeSv0vDI3vm2x+HOr8FgtKC4tLLmOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723467742; c=relaxed/simple;
	bh=ovOTOcrFs5Fq9toEWR2MaGWSwDmtkvG8imSKp9ayon0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sFwsJviIEwtW2gH64calU9Rq+upB8ACrp9yvrW/1VS0J8odLZ//TOCMuR54z396UiWQNq4CItEmAKXHqUJ3nQEGn2lXbo3fQUvhHFd4cv+d3N5k+FSUcYCZm3Mh+i6bodLciA5KfmQSl4lLe0xkSqM66wY2QxPo3/D/bx4skXqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WjF0l256Dz1j6Yt;
	Mon, 12 Aug 2024 20:57:27 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id A2A511A016C;
	Mon, 12 Aug 2024 21:02:16 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 12 Aug 2024 21:02:16 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH v2 for-next 0/3] RDMA: Provide an API for drivers to disassociate mmap pages
Date: Mon, 12 Aug 2024 20:56:37 +0800
Message-ID: <20240812125640.1003948-1-huangjunxian6@hisilicon.com>
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

Provide an API rdma_user_mmap_disassociate() for drivers to disassociate
mmap pages. Use this API in hns to prevent userspace from ringing doorbell
when HW is reset.

v1 -> v2:
* Keep uverbs_user_mmap_disassociate() in uverbs_main.c. The new api
  rdma_user_mmap_disassociate() is also moved to this file.
* Add "#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)" to hns's
  rdma_user_mmap_disassociate() call.

Chengchang Tang (3):
  RDMA/core: Provide rdma_user_mmap_disassociate() to disassociate mmap
    pages
  RDMA/hns: Link all uctx to uctx_list on a device
  RDMA/hns: Disassociate mmap pages for all uctx when HW is being reset

 drivers/infiniband/core/uverbs_main.c       | 21 +++++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_device.h |  4 ++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 17 +++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_main.c   | 13 +++++++++++++
 include/rdma/ib_verbs.h                     |  1 +
 5 files changed, 56 insertions(+)

--
2.33.0


