Return-Path: <linux-rdma+bounces-5473-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A98A9AA0F5
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2024 13:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C537E1C221CC
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2024 11:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909C419ABCE;
	Tue, 22 Oct 2024 11:16:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3551140E38;
	Tue, 22 Oct 2024 11:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729595797; cv=none; b=mOCf4lXVh6juf92E3ZYsKBnR8CBTyTVpU5f5jy1m5w5pGD8+jrx/BELxHY1YMefePp6GhuXMvWiCtccogss9DBVbJwF4y563jBHLyD0bG+shLV4iMOYz+s0nwDaWc2rhU/f9hi1k3a2EoP08KAkCSB9hQebhzS+v+7h4s8xcT6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729595797; c=relaxed/simple;
	bh=RE7QboNpMBgSiw0fo/Slo9j2GqJzmqWLlWEefQOhWhM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VwSUlNxf4GIjwflocwAn8E0SjBPYCRR5cRMf5fSDo7AAGIDxwJg4+JvqeSug23GPqUzwNOJvV3WBGef/yzFCmejlSVbD7mdl8eh6JKrYBSnMqgtsvYNbwfR/L6Y0levL4uvXiRMfuSIYo0HoVXbwS18aSb6PteDng9nVIT+TQeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XXqMF58cgzpWsw;
	Tue, 22 Oct 2024 19:14:33 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id DD96B18007C;
	Tue, 22 Oct 2024 19:16:30 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 22 Oct 2024 19:16:30 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>,
	<tangchengchang@huawei.com>
Subject: [PATCH for-rc 0/5] RDMA/hns: Bugfixes
Date: Tue, 22 Oct 2024 19:10:12 +0800
Message-ID: <20241022111017.946170-1-huangjunxian6@hisilicon.com>
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

Some hns bugfixes.
Patch #5 has been sent once before:
https://lore.kernel.org/lkml/4c202653-1ad7-d885-55b7-07c77a549b09@hisilicon.com/T/#m05883778af8e39438d864e9c0fb9062aa09f362c

Junxian Huang (1):
  RDMA/hns: Use dev_* printings in hem code instead of ibdev_*

Yuyu Li (1):
  RDMA/hns: Modify debugfs name

wenglianfa (3):
  RDMA/hns: Fix an AEQE overflow error caused by untimely update of
    eq_db_ci
  RDMA/hns: Fix flush cqe error when racing with destroy qp
  RDMA/hns: Fix cpu stuck caused by printings during reset

 drivers/infiniband/hw/hns/hns_roce_cq.c      |   4 +-
 drivers/infiniband/hw/hns/hns_roce_debugfs.c |   3 +-
 drivers/infiniband/hw/hns/hns_roce_device.h  |   3 +
 drivers/infiniband/hw/hns/hns_roce_hem.c     |  48 +++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c   | 155 +++++++++++--------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h   |   5 +
 drivers/infiniband/hw/hns/hns_roce_mr.c      |   4 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c      |  68 +++++---
 drivers/infiniband/hw/hns/hns_roce_srq.c     |   4 +-
 9 files changed, 177 insertions(+), 117 deletions(-)

--
2.33.0


