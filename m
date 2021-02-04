Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAABB30EC74
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Feb 2021 07:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbhBDG0F (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Feb 2021 01:26:05 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12120 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbhBDG0E (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Feb 2021 01:26:04 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DWT5t6nfmz163R8;
        Thu,  4 Feb 2021 14:24:02 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Thu, 4 Feb 2021 14:25:19 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH for-next 0/6] RDMA/hns: Fix and refactor CMDQ related code
Date:   Thu, 4 Feb 2021 14:23:00 +0800
Message-ID: <1612419786-39173-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Remove some dead code in process of CMDQ transmission, and fix an issue
about missing error code.

Lang Cheng (6):
  RDMA/hns: Remove unused member and variable of CMDQ
  RDMA/hns: Remove unsupported CMDQ mode
  RDMA/hns: Fixes missing error code of CMDQ
  RDMA/hns: Remove redundant operations on CMDQ
  RDMA/hns: Adjust fields and variables about CMDQ tail/head
  RDMA/hns: Refactor process of posting CMDQ

 drivers/infiniband/hw/hns/hns_roce_common.h |   4 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 142 ++++++++--------------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |   7 --
 3 files changed, 42 insertions(+), 111 deletions(-)

-- 
2.8.1

