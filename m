Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E0A7BC48D
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Oct 2023 06:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbjJGECJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 7 Oct 2023 00:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343517AbjJGECG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 7 Oct 2023 00:02:06 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C68BD;
        Fri,  6 Oct 2023 21:02:05 -0700 (PDT)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S2WjW61Z5zNn9c;
        Sat,  7 Oct 2023 11:58:07 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 7 Oct 2023 12:02:01 +0800
From:   Junxian Huang <huangjunxian6@hisilicon.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>, <dsahern@gmail.com>,
        <stephen@networkplumber.org>
CC:     <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <huangjunxian6@hisilicon.com>
Subject: [PATCH iproute2-next 0/2] rdma: Support dumping SRQ resource in raw format
Date:   Sat, 7 Oct 2023 11:58:53 +0800
Message-ID: <20231007035855.2273364-1-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

This patchset adds support to dump SRQ resource in raw format with
rdmatool. The corresponding kernel commit is aebf8145e11a
("RDMA/core: Add support to dump SRQ resource in RAW format")

Junxian Huang (1):
  rdma: Update uapi headers

wenglianfa (1):
  rdma: Add support to dump SRQ resource in raw format

 rdma/include/uapi/rdma/rdma_netlink.h |  2 ++
 rdma/res-srq.c                        | 17 ++++++++++++++++-
 rdma/res.h                            |  2 ++
 3 files changed, 20 insertions(+), 1 deletion(-)

--
2.30.0

