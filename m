Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A073122EF
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Feb 2021 09:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhBGI6p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 7 Feb 2021 03:58:45 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:12444 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhBGI6n (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 7 Feb 2021 03:58:43 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DYNLt3yRxzjJfx;
        Sun,  7 Feb 2021 16:56:54 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Sun, 7 Feb 2021 16:57:57 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH v2 for-next 0/5] RDMA/hns: Fix and refactor CMDQ related code
Date:   Sun, 7 Feb 2021 16:55:38 +0800
Message-ID: <1612688143-28226-1-git-send-email-liweihang@huawei.com>
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

Changes since v1:
* Drop #2 from the v1 series because the compatibility with the firmware
  needs to be considered.
* Link: https://patchwork.kernel.org/project/linux-rdma/cover/1612419786-39173-1-git-send-email-liweihang@huawei.com/

Lang Cheng (5):
  RDMA/hns: Remove unused member and variable of CMDQ
  RDMA/hns: Fixes missing error code of CMDQ
  RDMA/hns: Remove redundant operations on CMDQ
  RDMA/hns: Adjust fields and variables about CMDQ tail/head
  RDMA/hns: Refactor process of posting CMDQ

 drivers/infiniband/hw/hns/hns_roce_common.h |   4 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 125 ++++++++--------------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |   5 --
 3 files changed, 37 insertions(+), 97 deletions(-)

-- 
2.8.1

