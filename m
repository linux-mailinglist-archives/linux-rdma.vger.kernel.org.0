Return-Path: <linux-rdma+bounces-5130-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BFB9882AA
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Sep 2024 12:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 034AA2837B4
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Sep 2024 10:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98F1189503;
	Fri, 27 Sep 2024 10:39:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD35185956;
	Fri, 27 Sep 2024 10:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727433578; cv=none; b=nofijnp7C6JF83qrjSkddmMdteXdQC8dvKtstcmQaRFc5ABrjMwt0m16/L6NNc9HiZ8EzlPMCQPu7o5T876d+tTHg6nyYFUKMgUvC81waNrVZaLTokrB6hZkI1iC0cJpBLPGhFrEhrYAlUn+2ZWtIZgUgsDSoz+2ycUT8zePrZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727433578; c=relaxed/simple;
	bh=+IQVWCoQkBqzAWdPVto3UtHP1hYCzMDTMNGMIGZJix8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y3xm5hlLABnOvBVH7FdZeyI16cbOV5NlDZ0M6Ftc8jX3Wq2dOZ4so2qjpX/MLRT6MxYPlT7Lsy3UlkqYST2k0SN8T2z6VhBt/v+SybN4zBe1ouVWqUCM7xRinapokycFCbWQy+Cl1CSAv+tWY8z3aeA3wYbNAMHcySCg0CzjIcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XFRlx2k5RzFqq0;
	Fri, 27 Sep 2024 18:39:09 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 14F43140391;
	Fri, 27 Sep 2024 18:39:33 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 27 Sep 2024 18:39:24 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <tangchengchang@huawei.com>,
	<huangjunxian6@hisilicon.com>
Subject: [PATCH v6 for-next 0/2] RDMA: Provide an API for drivers to disassociate mmap pages
Date: Fri, 27 Sep 2024 18:33:21 +0800
Message-ID: <20240927103323.1897094-1-huangjunxian6@hisilicon.com>
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

Provide an API rdma_user_mmap_disassociate() for drivers to disassociate
mmap pages. Use this API in hns to prevent userspace from ringing doorbell
when HW is reset.

v5 -> v6:
* Fix build warning of unused label in patch #1
* inline the call to rdma_user_mmap_disassociate() in patch #2

v4 -> v5:
* Remove 'disassociated' from core.
* Remove lockdep in uverbs_user_mmap_disassociate() since we have
  a new disassociation_lock and don't need to hold hw_destroy_rwsem
  in the newly introduced api.
* Use hr_dev->dis_db to prevent new mmaps once the device is reset.

v3 -> v4:
* Add the newly introduced disassociation_lock to ib_uverbs_mmap()
  and rdma_umap_open() to prevent concurrency with
  rdma_user_mmap_disassociate().
* Change the disassociated flag from atomic_t to bool.

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

 drivers/infiniband/core/uverbs.h           |  2 +
 drivers/infiniband/core/uverbs_main.c      | 43 +++++++++++++++++++++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c |  4 ++
 drivers/infiniband/hw/hns/hns_roce_main.c  |  5 +++
 include/rdma/ib_verbs.h                    |  8 ++++
 5 files changed, 60 insertions(+), 2 deletions(-)

--
2.33.0


