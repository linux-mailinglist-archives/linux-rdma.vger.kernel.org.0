Return-Path: <linux-rdma+bounces-5763-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400C09BCC7B
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2024 13:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03E0E28343F
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2024 12:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5A41D54E3;
	Tue,  5 Nov 2024 12:15:10 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D241D5167;
	Tue,  5 Nov 2024 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730808910; cv=none; b=Vpe8tBeMfl0pZV9YXv/u1wT7WsCAVUDR272WhBdYFvMl+ak0sq4C89qwNAdw626WE5G7m3HH7adOkQpvpE2gCsxggjKDwON3FNS7+WZFnUSR9M7XjihopCmLCytqxjpUz1mzGwnq+QrZukOzIZG0QG8FAB0EXgUR5PqJMztGwS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730808910; c=relaxed/simple;
	bh=pDW7+q/M2KLWHnpLZGd0Dog3P7nMkD7jthLQp9H5YOk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PbJZAJ1zA5aoE4Md4VqMSwDLbCjuMrp3ImXAL8p+UkGN8FdHuYRKb7XdUCHuIKaMJj63hs5WIN9kSgNj4+3Pav/+YYGzU8Sc+tUqM7hTyK5t5Jmzw9h/ha6+9VVLPdDlG8CQfF8XiL/CDFeY9Y36eZwZGun4D9W+hy2q8FLNuI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XjRzx0KbWz10PgV;
	Tue,  5 Nov 2024 20:12:45 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 10CAF1400CF;
	Tue,  5 Nov 2024 20:15:04 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 5 Nov 2024 20:15:03 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <dennis.dalessandro@cornelisnetworks.com>, <jgg@ziepe.ca>,
	<leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <tangchengchang@huawei.com>,
	<huangjunxian6@hisilicon.com>
Subject: [PATCH for-next 0/2] Small optimization for ib_map_mr_sg() and ib_map_mr_sg_pi()
Date: Tue, 5 Nov 2024 20:08:39 +0800
Message-ID: <20241105120841.860068-1-huangjunxian6@hisilicon.com>
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

ib_map_mr_sg() and ib_map_mr_sg_pi() allow ULPs to specify NULL as
the sg_offset/data_sg_offset/meta_sg_offset arguments. Drivers who
need to derefernce these arguments have to add NULL pointer checks
to avoid crashing the kernel.

This can be optimized by adding dummy sg_offset pointer to these
two APIs. When the sg_offset arguments are NULL, pass the pointer
of dummy to drivers. Drivers can always get a valid pointer, so no
need to add NULL pointer checks.

Junxian Huang (2):
  RDMA/core: Add dummy sg_offset pointer for ib_map_mr_sg() and
    ib_map_mr_sg_pi()
  RDMA: Delete NULL pointer checks for sg_offset in .map_mr_sg ops

 drivers/infiniband/core/verbs.c         | 12 +++++++++---
 drivers/infiniband/hw/mlx5/mr.c         | 18 ++++++------------
 drivers/infiniband/sw/rdmavt/trace_mr.h |  2 +-
 3 files changed, 16 insertions(+), 16 deletions(-)

--
2.33.0


