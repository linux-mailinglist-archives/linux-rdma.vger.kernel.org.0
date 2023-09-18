Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88947A4FBB
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Sep 2023 18:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjIRQvw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Sep 2023 12:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjIRQvv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Sep 2023 12:51:51 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98DD8E;
        Mon, 18 Sep 2023 09:51:45 -0700 (PDT)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rq4tX51HdzVjy5;
        Mon, 18 Sep 2023 21:11:16 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 18 Sep 2023 21:14:11 +0800
From:   Junxian Huang <huangjunxian6@hisilicon.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH RFC for-next 0/3] Add more resource dumping to rdmatool for SRQ
Date:   Mon, 18 Sep 2023 21:11:07 +0800
Message-ID: <20230918131110.3987498-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500006.china.huawei.com (7.221.188.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add more resource dumping to rdmatool for SRQ.

wenglianfa (3):
  RDMA/core: Add dedicated SRQ resource tracker function
  RDMA/core: Add support to dump SRQ resource in RAW format
  RDMA/hns: Support SRQ restrack ops for hns driver

 drivers/infiniband/core/device.c              |  2 +
 drivers/infiniband/core/nldev.c               | 26 +++++++++-
 drivers/infiniband/hw/hns/hns_roce_device.h   |  3 ++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c    | 25 ++++++++++
 drivers/infiniband/hw/hns/hns_roce_main.c     |  2 +
 drivers/infiniband/hw/hns/hns_roce_restrack.c | 49 +++++++++++++++++++
 include/rdma/ib_verbs.h                       |  2 +
 include/uapi/rdma/rdma_netlink.h              |  2 +
 8 files changed, 110 insertions(+), 1 deletion(-)

--
2.30.0

