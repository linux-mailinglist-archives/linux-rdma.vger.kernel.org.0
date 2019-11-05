Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5537EFBA4
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2019 11:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388318AbfKEKng (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Nov 2019 05:43:36 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5707 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387905AbfKEKng (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 5 Nov 2019 05:43:36 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 08A08C4B30B7CD1C77F7;
        Tue,  5 Nov 2019 18:43:34 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Tue, 5 Nov 2019 18:43:28 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH for-next 0/9] RDMA/hns: Cleanups for hip08
Date:   Tue, 5 Nov 2019 18:39:45 +0800
Message-ID: <1572950394-42910-1-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

These series just make cleanups without changing code logic.

[patch 1/9 ~ 3/9] remove unused variables and structures.
[patch 4/9 ~ 5/9] modify field and function names.
[patch 6/9 ~ 7/9] remove dead codes to simplify functions.
[patch 8/9] replaces non-standard return value with linux error codes.
[patch 9/9] does some fixes on printings.

Lang Cheng (3):
  {topost} RDMA/hns: Remove unnecessary structure hns_roce_sqp
  {topost} RDMA/hns: Simplify doorbell initialization code
  {topost} RDMA/hns: Modify hns_roce_hw_v2_get_cfg to simplify the code

Wenpeng Liang (1):
  {topost} RDMA/hns: Modify appropriate printings

Yixian Liu (4):
  {topost} RDMA/hns: Delete unnecessary variable max_post
  {topost} RDMA/hns: Delete unnecessary uar from hns_roce_cq
  {topost} RDMA/hns: Modify fields of struct hns_roce_srq
  {topost} RDMA/hns: Fix non-standard error codes

Yixing Liu (1):
  {topost} RDMA/hns: Replace not intuitive function/macro names

 drivers/infiniband/hw/hns/hns_roce_alloc.c  |  4 +-
 drivers/infiniband/hw/hns/hns_roce_cmd.h    | 14 +++----
 drivers/infiniband/hw/hns/hns_roce_cq.c     | 51 +++++++++++-----------
 drivers/infiniband/hw/hns/hns_roce_device.h | 22 +++-------
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c  | 12 +++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 37 ++++++----------
 drivers/infiniband/hw/hns/hns_roce_main.c   |  4 +-
 drivers/infiniband/hw/hns/hns_roce_mr.c     | 65 +++++++++++++++--------------
 drivers/infiniband/hw/hns/hns_roce_pd.c     |  2 +-
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 18 ++++----
 drivers/infiniband/hw/hns/hns_roce_srq.c    | 58 ++++++++++++-------------
 11 files changed, 132 insertions(+), 155 deletions(-)

-- 
2.8.1

