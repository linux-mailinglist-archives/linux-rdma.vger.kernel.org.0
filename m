Return-Path: <linux-rdma+bounces-4603-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D58962003
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 08:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15BC28671A
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 06:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A01D1581E0;
	Wed, 28 Aug 2024 06:51:56 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC6714A4F3;
	Wed, 28 Aug 2024 06:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724827916; cv=none; b=ALw3+RDbk8NSqLCVuZ4RBQS1kj4Xua77/eGS209ow6Sd87/yaCNesFFjLg80rNxF2toJWyK8uhKAJ2Sh/O/FaaX9URhLFA3GxdiWfBc1W6gUSu2A/fxDrCvxr5/OcmdDbnLLDlItyeWlxdJj3vfYXRdcLs4r3LzOTNtmfg4OmWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724827916; c=relaxed/simple;
	bh=ptZn+KeKnA0csnoUOAy3NJii1aO97et+171B7YIpl4Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h0K2LD6HQe+aoWuel8o22zNgLN2jI+4maf3pEKP3cJCHLdoUoxqlaQD1DKnPh/Wh46KmScccood3Pq9Ck2virvYf2brNeoJETZJd7emGtf9jZFoISXq3eHdTFSoZGfoBLR2XNWTMmXzBa3hFj+jUGf/QRUDgmDqPm1K+z3Nu8cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wtw5X15YCzpTsR;
	Wed, 28 Aug 2024 14:50:08 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id E2E04180AE6;
	Wed, 28 Aug 2024 14:51:49 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 28 Aug 2024 14:51:49 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH v3 for-next 0/2] RDMA: Provide an API for drivers to disassociate mmap pages
Date: Wed, 28 Aug 2024 14:46:03 +0800
Message-ID: <20240828064605.887519-1-huangjunxian6@hisilicon.com>
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
 kwepemf100018.china.huawei.com (7.202.181.17)

Provide an API rdma_user_mmap_disassociate() for drivers to disassociate
mmap pages. Use this API in hns to prevent userspace from ringing doorbell
when HW is reset.

v2 -> v3:
* Walk all ufiles of a device in rdma_user_mmap_disassociate() as Jason
  commented, so drivers don't need to maintain their own list of ucontexts.
* Add a disassociation_lock in uverbs_user_mmap_disassociate() as Jason
  commented to avoid racing between different threads.
* Add a disassociated flag indicating whether mmaps have been disabled
  to prevent new mmap after the disassociation.

v1 -> v2:
* Keep uverbs_user_mmap_disassociate() in uverbs_main.c. The new api
  rdma_user_mmap_disassociate() is also moved to this file.
* Add "#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)" to hns's
  rdma_user_mmap_disassociate() call.

Chengchang Tang (2):
  RDMA/core: Provide rdma_user_mmap_disassociate() to disassociate mmap
    pages
  RDMA/hns: Disassociate mmap pages for all uctx when HW is being reset

 drivers/infiniband/core/uverbs.h           |  3 ++
 drivers/infiniband/core/uverbs_main.c      | 45 +++++++++++++++++++++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c |  9 +++++
 include/rdma/ib_verbs.h                    |  8 ++++
 4 files changed, 63 insertions(+), 2 deletions(-)

--
2.33.0


