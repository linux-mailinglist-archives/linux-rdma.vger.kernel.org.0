Return-Path: <linux-rdma+bounces-11864-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA30AAF72A0
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 13:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D10F51885EFB
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 11:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBFA2E424E;
	Thu,  3 Jul 2025 11:39:17 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEDE2571BC
	for <linux-rdma@vger.kernel.org>; Thu,  3 Jul 2025 11:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751542757; cv=none; b=rP4RcOhQhJoLIVkRvwAXADkzUvmp7Qjx0cyPIP6xPJdCiZ40ZP2vdz9OKEmJ+9SVPwJTCiz0Bl4Vp5fO1fKkpL260joJMZyl8zp6/8HKDAoLZFNAHEfGXaJTQbATWHjh5WM1S2D7tuyatNamwz7oW+0gIDmoCQAzszaqzT9b/dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751542757; c=relaxed/simple;
	bh=ZukxSc8kDnngko5triXJpikxvFdSZB4fVLkzCTcwusU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LDbjqWRmmTdvppbLgvL55/gc8jzEIgs+1tsjpSKspjAdB+wAupBwjeWS+JsaEG/NJiB+23ciWK76W2qJfsZKVfi5r6NrXT8N2FVN//n4SMLAFpBxJvudpwuTQ3r7MrQLnm2CNIgeJqh5II29d6uDGGYMrEv4xH3oQ2RHIATSsrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bXvrG6npTz2SStf;
	Thu,  3 Jul 2025 19:37:18 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F19C140158;
	Thu,  3 Jul 2025 19:39:06 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 3 Jul 2025 19:39:06 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<huangjunxian6@hisilicon.com>, <tangchengchang@huawei.com>
Subject: [PATCH for-rc 0/6] RDMA/hns: Bugfixes and improvements
Date: Thu, 3 Jul 2025 19:38:59 +0800
Message-ID: <20250703113905.3597124-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100018.china.huawei.com (7.202.181.17)

Here are some recent bugfixes and improvements for hns.

Junxian Huang (4):
  RDMA/hns: Get message length of ack_req from FW
  RDMA/hns: Fix accessing uninitialized resources
  RDMA/hns: Drop GFP_NOWARN
  RDMA/hns: Fix -Wframe-larger-than issue

wenglianfa (2):
  RDMA/hns: Fix double destruction of rsv_qp
  RDMA/hns: Fix HW configurations not cleared in error flow

 drivers/infiniband/hw/hns/hns_roce_device.h |  1 +
 drivers/infiniband/hw/hns/hns_roce_hem.c    | 18 ++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 81 +++++++++++++++------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  8 +-
 drivers/infiniband/hw/hns/hns_roce_main.c   | 22 ++----
 5 files changed, 77 insertions(+), 53 deletions(-)

--
2.33.0


