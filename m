Return-Path: <linux-rdma+bounces-1924-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 420568A2AF6
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Apr 2024 11:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0D12281968
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Apr 2024 09:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFAD535AF;
	Fri, 12 Apr 2024 09:20:52 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B2E4D5AA;
	Fri, 12 Apr 2024 09:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712913652; cv=none; b=G3/byrUk3BhmI8svnVpLYtTbJTX3gM0dp2OgBghdkLfSkZms7Rss+jK8GOXm8V0Bihd//uq0HRYyLS6UPnpRoi1g1tajZpED5g4rrEOrgSTng7qwsdiQgOu8al99kTfQLOLdqa1SlsaYGKFicwzPuQRFJAKoPZifOS+TZ43DLf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712913652; c=relaxed/simple;
	bh=D+KmjrU/hqLeHxIk8mdn7W4QFm7pQwS3YMj6bTQTA54=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I+Z6SkE7C6HFJ1lu6Ot5Mn9dc6Qh/RlD8QCakxj3IsBwNbqMz80nsng/GUKrCAe/Pwf3oxmYmooEtg+iFRLRYviEvnWa+4smvovO8gaPrlkEQz+z+NF0X5BD5gDWA0kIZBM0wC4z3txnkFE6agqHK8zC9unc+tkVngpzczUotYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4VG9vj0QMKz1RBW7;
	Fri, 12 Apr 2024 17:17:53 +0800 (CST)
Received: from kwepemi500006.china.huawei.com (unknown [7.221.188.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 01DBF1403D3;
	Fri, 12 Apr 2024 17:20:47 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 17:20:46 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-next 00/10] RDMA/hns: Bugfixes and cleanups
Date: Fri, 12 Apr 2024 17:16:06 +0800
Message-ID: <20240412091616.370789-1-huangjunxian6@hisilicon.com>
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
 kwepemi500006.china.huawei.com (7.221.188.68)

Here are some bugfixes and cleanups.

Chengchang Tang (7):
  RDMA/hns: Remove unused parameters and variables
  RDMA/hns: Add max_ah and cq moderation capacities in query_device()
  RDMA/hns: Fix deadlock on SRQ async events.
  RDMA/hns: Fix UAF for cq async event
  RDMA/hns: Fix GMV table pagesize
  RDMA/hns: Use complete parentheses in macros
  RDMA/hns: Modify the print level of CQE error

Yangyang Li (1):
  RDMA/hns: Use macro instead of magic number

wenglianfa (2):
  RDMA/hns: Fix mismatch exception rollback
  RDMA/hns: Add mutex_destroy()

 drivers/infiniband/hw/hns/hns_roce_alloc.c  |  3 +-
 drivers/infiniband/hw/hns/hns_roce_cq.c     | 25 ++++----
 drivers/infiniband/hw/hns/hns_roce_device.h |  8 ++-
 drivers/infiniband/hw/hns/hns_roce_hem.c    | 17 +++--
 drivers/infiniband/hw/hns/hns_roce_hem.h    | 12 ++--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 69 +++++++++++----------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 15 ++++-
 drivers/infiniband/hw/hns/hns_roce_main.c   | 32 +++++++++-
 drivers/infiniband/hw/hns/hns_roce_mr.c     |  4 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 16 +++--
 drivers/infiniband/hw/hns/hns_roce_srq.c    | 12 ++--
 11 files changed, 133 insertions(+), 80 deletions(-)

--
2.30.0


