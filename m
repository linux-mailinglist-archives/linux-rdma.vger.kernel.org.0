Return-Path: <linux-rdma+bounces-4775-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FD196DA01
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Sep 2024 15:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10BC428414A
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Sep 2024 13:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5402119D890;
	Thu,  5 Sep 2024 13:17:50 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B90C198852;
	Thu,  5 Sep 2024 13:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725542270; cv=none; b=twr8vyEw7wFlqr4dc2SiqajDKF9EGyLXFXh7JVqZipPd2HyvXWiSEWMrGrCEQmcFBXwnH69CK9jdsk+RkWd7hqumK1r//b2MlSe9OC6KJX4Bcm3I6xqP2rTG7/JUt9toMlC2DfAPvZr1rs5PsplMaey+h3iLfmd9m2b1u/Hqz7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725542270; c=relaxed/simple;
	bh=xrBauJ+EIuOq0bIM147AOzQOxhqmj6x3z2xeo+jRPF4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pAjW0GUBMTBYblrWJ0+GUn+vvI5S+wJlC0wxWcLMr0KsnMkdMd6J5Bb0iATQpI1H4WUDawd+ATlvdR13Hu8U3BU0AjwYqmiWWYptd7TzPWIJ1JDwHC1pZPrwqcyY5FEA+wb4X2dElUO/PK6PzoE6KGO3aEPYRCfnJ8hiybSY484=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4X00F40BcCz1HJ8N;
	Thu,  5 Sep 2024 21:14:16 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id AFCEE1A016C;
	Thu,  5 Sep 2024 21:17:44 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 5 Sep 2024 21:17:44 +0800
From: Junxian Huang <huangjunxian6@hisilicon.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH v4 for-next 0/2] RDMA: Provide an API for drivers to disassociate mmap pages
Date: Thu, 5 Sep 2024 21:11:53 +0800
Message-ID: <20240905131155.1441478-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100018.china.huawei.com (7.202.181.17)

Provide an API rdma_user_mmap_disassociate() for drivers to disassociate
mmap pages. Use this API in hns to prevent userspace from ringing doorbell
when HW is reset.

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

 drivers/infiniband/core/uverbs.h           |  3 ++
 drivers/infiniband/core/uverbs_main.c      | 55 ++++++++++++++++++++--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c |  9 ++++
 include/rdma/ib_verbs.h                    |  8 ++++
 4 files changed, 71 insertions(+), 4 deletions(-)

--
2.33.0


