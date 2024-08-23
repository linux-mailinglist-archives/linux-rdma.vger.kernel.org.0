Return-Path: <linux-rdma+bounces-4510-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DA095CA27
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 12:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C39711C245BE
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Aug 2024 10:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF18118735F;
	Fri, 23 Aug 2024 10:11:10 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE591474D7;
	Fri, 23 Aug 2024 10:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724407870; cv=none; b=m7hGuF5Dj5trZAADnE1BZQrTBLY3pE8VteRtpzOLINFZ8HXI+cTyBiB1LUi9I34UK966iGVtqYZoM9Wx8A2lmv4Yrlpi+Zi6gzgHByIRJz1x2L02yrn/UG+D1ntIwU4JmdgDowQKwpdlNXGUH2bd99iDyqpRuLtBTPW3oRf2nic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724407870; c=relaxed/simple;
	bh=4e67htb8uZg27hKA6ahW0cf2wur6npRM7Gu0u+RLOI0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oqoJAERcOrn5SI+7SR2jtZ6KWuyUTPBJ+Bu+LHyuJY/7LVLey/UOUYjZq/XrLAcUrZksv3e4S9YZ4Dzi1PnsabFj5LFeq5YBK9YgQNLtSCxeqzf31/zAn6uUnS5Yb8lg2NfNapzbY0nf1FYgfksxpWoUG8hbRp70mlHXlrSigzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wqwnd31gPz1j6kj;
	Fri, 23 Aug 2024 18:11:01 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 105EA1402E0;
	Fri, 23 Aug 2024 18:11:06 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 23 Aug
 2024 18:11:05 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <dennis.dalessandro@cornelisnetworks.com>, <jgg@ziepe.ca>,
	<leon@kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bvanassche@acm.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 0/4] RDMA: Simplify multiple create*_workqueue() invocations
Date: Fri, 23 Aug 2024 18:18:36 +0800
Message-ID: <20240823101840.515398-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)

This patch series follows the SCSI patches of Bart, simplifies snprintf()
to format a workqueue name code by passing the format string and arguments
to alloc_workqueue().

Jinjie Ruan (4):
  RDMA/qib: Simplify an alloc_ordered_workqueue() invocation
  RDMA/mad: Simplify an alloc_ordered_workqueue() invocation
  RDMA/mlx4: Simplify an alloc_ordered_workqueue() invocation
  RDMA/mad: Simplify an alloc_ordered_workqueue() invocation

 drivers/infiniband/core/mad.c           |  5 ++---
 drivers/infiniband/hw/mlx4/alias_GUID.c |  4 +---
 drivers/infiniband/hw/mlx4/mad.c        | 10 +++-------
 drivers/infiniband/hw/qib/qib_init.c    |  9 +++------
 4 files changed, 9 insertions(+), 19 deletions(-)

-- 
2.34.1


