Return-Path: <linux-rdma+bounces-7787-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0752A37BD9
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Feb 2025 08:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C14FE7A249A
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Feb 2025 07:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A46D193084;
	Mon, 17 Feb 2025 07:08:52 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A32183098
	for <linux-rdma@vger.kernel.org>; Mon, 17 Feb 2025 07:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739776132; cv=none; b=XxSd7X9ycZGAcawp98ZP+H89KjZOuZs3bJ4+SbGIIgjuIutgDzTeMwe4he/K3G6Y3ksmbZyq9kqAClv74K2KDxZozO9i6BiDI0lk7Gi0l89nNBQI3peAUkGoijOWS5hMc3kc8pSzkjfYV9j5OOU7EBr2LFSh6VgOr0nG86zzDe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739776132; c=relaxed/simple;
	bh=5ZJpsM/7AqdnPCNn8MBS6VMH9OoVlmhSV+xcW0lk7Ls=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GN+bZuuSfuWf8QqVw8YCXb4krAUfDdIRSx4IcQ4YkDyBgRgYWfqUWSxfDeQsgTEeKSUYh/A2mu6C6YHJ6Obi5Ga57bwGSjjJs3ly4JpUY/x1EcFue0vcpdvBilV2SuG90915G+P6RZYb8jaxvAj+pLGvTYMUR22Wxco5WImJybY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YxDCw6xR8z11VXs;
	Mon, 17 Feb 2025 15:04:12 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 7E3481401F2;
	Mon, 17 Feb 2025 15:08:46 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 17 Feb 2025 15:08:45 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-next 0/4] RDMA/hns: Introduce delay-destruction mechanism
Date: Mon, 17 Feb 2025 15:01:19 +0800
Message-ID: <20250217070123.3171232-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf100018.china.huawei.com (7.202.181.17)

When mailboxes for resource(QP/CQ/SRQ) destruction fail, it's unable
to notify HW about the destruction. In this case, driver will still
free the resources, while HW may still access them, thus leading to
a UAF.

This series introduces delay-destruction mechanism to fix such HW UAF,
including thw HW CTX and doorbells.

Junxian Huang (2):
  RDMA/hns: Change mtr member to pointer in hns QP/CQ/MR/SRQ/EQ struct
  RDMA/hns: Fix HW doorbell UAF by adding delay-destruction mechanism

wenglianfa (2):
  RDMA/hns: Fix HW CTX UAF by adding delay-destruction mechanism
  Revert "RDMA/hns: Do not destroy QP resources in the hw resetting
    phase"

 drivers/infiniband/hw/hns/hns_roce_cq.c       |  34 +++--
 drivers/infiniband/hw/hns/hns_roce_db.c       |  91 ++++++++++----
 drivers/infiniband/hw/hns/hns_roce_device.h   |  73 ++++++++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c    |  97 +++++++--------
 drivers/infiniband/hw/hns/hns_roce_main.c     |  13 ++
 drivers/infiniband/hw/hns/hns_roce_mr.c       | 117 ++++++++++++++----
 drivers/infiniband/hw/hns/hns_roce_qp.c       |  30 +++--
 drivers/infiniband/hw/hns/hns_roce_restrack.c |   4 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c      |  45 ++++---
 9 files changed, 348 insertions(+), 156 deletions(-)

--
2.33.0


