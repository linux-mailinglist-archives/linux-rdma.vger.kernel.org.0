Return-Path: <linux-rdma+bounces-4936-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3FD978022
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Sep 2024 14:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEBE0B2295D
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Sep 2024 12:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2881DA0EE;
	Fri, 13 Sep 2024 12:36:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D648B1DA0F8;
	Fri, 13 Sep 2024 12:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726230960; cv=none; b=jtxdYtNFjIg5g9SkpbQxUhlqxbxeBWrc5+BC0tcHEfkqwyaaS7vth+LjxP/MUqmTCfjt/iQQGQ65LUUrY513BdxMABSD+Vbq+nPoIPSojk+zwTumocwQZJfJ/377HZEyaA3Um68BWg1SjsAZsYG7n2tvAiASjO5AAKEfZtFqAe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726230960; c=relaxed/simple;
	bh=bGU6U84CdjgYF5vOZsklYjuyfTcLsK2El8joVoBv7h4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dM0l/kUn+JTfHLqO6kn6eBzfWmpOfEuw8pKWVDTeY8OF8LSj//720R3xpaLwjvMyKOvTzCDlx9772YdWAl1rOdi68JPy1Wk1Aay5oyF0ir/EtdY8iXIBbmSH2nLJpuyzdBHiTGSIDKeCCj4nrn+HeiMaX7fFYl8oJYmvf+mz/a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4X4v0r5WlPz69W2;
	Fri, 13 Sep 2024 20:35:40 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id 3A36A180113;
	Fri, 13 Sep 2024 20:35:49 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 13 Sep 2024 20:35:48 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH v5 for-next 0/2] RDMA: Provide an API for drivers to disassociate mmap pages
Date: Fri, 13 Sep 2024 20:29:53 +0800
Message-ID: <20240913122955.1283597-1-huangjunxian6@hisilicon.com>
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

Provide an API rdma_user_mmap_disassociate() for drivers to disassociate
mmap pages. Use this API in hns to prevent userspace from ringing doorbell
when HW is reset.

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
 drivers/infiniband/core/uverbs_main.c      | 47 ++++++++++++++++++++--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c |  9 +++++
 drivers/infiniband/hw/hns/hns_roce_main.c  |  5 +++
 include/rdma/ib_verbs.h                    |  8 ++++
 5 files changed, 67 insertions(+), 4 deletions(-)

--
2.33.0


