Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CD47EAFF2
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Nov 2023 13:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjKNMiW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Nov 2023 07:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbjKNMiV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Nov 2023 07:38:21 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B34F134;
        Tue, 14 Nov 2023 04:38:18 -0800 (PST)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SV5MH3NgDzPpGB;
        Tue, 14 Nov 2023 20:34:03 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 14 Nov 2023 20:38:15 +0800
From:   Junxian Huang <huangjunxian6@hisilicon.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-next 0/3] Support SW stats with debugfs
Date:   Tue, 14 Nov 2023 20:34:46 +0800
Message-ID: <20231114123449.1106162-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500006.china.huawei.com (7.221.188.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patchset introduces hns debugfs and supports SW stats with it.

Junxian Huang (3):
  RDMA/hns: Fix inappropriate err code for unsupported operations
  RDMA/hns: Add debugfs to hns RoCE
  RDMA/hns: Support SW stats with debugfs

 drivers/infiniband/hw/hns/Makefile           |   3 +-
 drivers/infiniband/hw/hns/hns_roce_ah.c      |   6 +-
 drivers/infiniband/hw/hns/hns_roce_cmd.c     |  19 +++-
 drivers/infiniband/hw/hns/hns_roce_cq.c      |  17 ++-
 drivers/infiniband/hw/hns/hns_roce_debugfs.c | 110 +++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_debugfs.h |  33 ++++++
 drivers/infiniband/hw/hns/hns_roce_device.h  |  26 +++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c   |  49 ++++++---
 drivers/infiniband/hw/hns/hns_roce_main.c    |  48 ++++++--
 drivers/infiniband/hw/hns/hns_roce_mr.c      |  26 +++--
 drivers/infiniband/hw/hns/hns_roce_pd.c      |  12 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c      |   8 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c     |   6 +-
 13 files changed, 319 insertions(+), 44 deletions(-)
 create mode 100644 drivers/infiniband/hw/hns/hns_roce_debugfs.c
 create mode 100644 drivers/infiniband/hw/hns/hns_roce_debugfs.h

--
2.30.0

