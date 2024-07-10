Return-Path: <linux-rdma+bounces-3793-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5EE92D316
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 15:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B54A21F242F7
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 13:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14272192B94;
	Wed, 10 Jul 2024 13:42:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BEF1DDC5;
	Wed, 10 Jul 2024 13:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720618948; cv=none; b=SDYlMHYemLqOHujlPQXkXmf3vLq8afBITOrsKXUhV+2yycdELVxbLEmLdHxIziNlJFv0KS8bcCnsOZ+GJhDE+5hXc4wQ49OYd/q74Y0GASEAB7b5NJwl76j5lybeM/pGMn7jfHpyJbDSOP4ijWnhY0Tss+IsntlP8acYMuAosk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720618948; c=relaxed/simple;
	bh=MvuMU8T0ANrufEoBpWpD+iDkftf/zrRX3wL5apOQBDU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WFVsB0YDEIzJvSIwLkNFECmnjzgcXjY/+3h4mxCNexBrsk16lzxgiEM7dSHH7MWnP+mKGfkTsGOZi0Woz4u2+lNEW9gaiAR3XYw/xAsR+6TSOz8r7V8WBHsKdQMs5zwl4MQZ0FIxgHhqxTzKx1W/4b1WfdpScexx4Z6EsHckPZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WJzSW56KTzxVxH;
	Wed, 10 Jul 2024 21:37:47 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 05A8E140257;
	Wed, 10 Jul 2024 21:42:23 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 10 Jul 2024 21:42:22 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH v2 for-rc 0/8] RDMA/hns: Bugfixes
Date: Wed, 10 Jul 2024 21:36:57 +0800
Message-ID: <20240710133705.896445-1-huangjunxian6@hisilicon.com>
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

Here are some bugfixes for hns driver.

v1 -> v2:
* Drop patch #2 in v1 because Leon pointed out a problem about mailbox
  mode, and we plan to handle it in another patchset.
* Patch #1: put the atomic length check in set_rc_wqe(), stop processing
  WQEs and return immediately if there is an error.
* Patch #2: use BH workqueue instead of tasklet.

Chengchang Tang (5):
  RDMA/hns: Fix missing pagesize and alignment check in FRMR
  RDMA/hns: Fix shift-out-bounds when max_inline_data is 0
  RDMA/hns: Fix undifined behavior caused by invalid max_sge
  RDMA/hns: Fix insufficient extend DB for VFs.
  RDMA/hns: Fix mbx timing out before CMD execution is completed

Junxian Huang (3):
  RDMA/hns: Check atomic wr length
  RDMA/hns: Fix soft lockup under heavy CEQE load
  RDMA/hns: Fix unmatch exception handling when init eq table fails

 drivers/infiniband/hw/hns/hns_roce_device.h |   7 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 164 +++++++++++++-------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |   6 +
 drivers/infiniband/hw/hns/hns_roce_mr.c     |   5 +
 drivers/infiniband/hw/hns/hns_roce_qp.c     |   4 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c    |   2 +-
 6 files changed, 127 insertions(+), 61 deletions(-)

--
2.33.0


