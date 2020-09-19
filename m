Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB01270CC5
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Sep 2020 12:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgISKEr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 19 Sep 2020 06:04:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13728 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726245AbgISKEr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 19 Sep 2020 06:04:47 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BF5D51B6F750464FE1E1;
        Sat, 19 Sep 2020 18:04:40 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 18:04:32 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH v3 for-next 0/8] RDMA/hns: Misc Updates
Date:   Sat, 19 Sep 2020 18:03:14 +0800
Message-ID: <1600509802-44382-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Here are some miscellaneous cleanups and fixes for the hns driver,
including refactor, some newly added checks and so on.

Previous discussion:
v2: https://patchwork.kernel.org/cover/11765125/
v1: https://patchwork.kernel.org/cover/11761647/

Changes since v2:
Fix some issuses according to Jason's comments.
- Change 'unlikely' to 'WARN_ON' and remove prints when getting illegal
  opcodes.
- Drop patch #2 from v1 because the newly added check is meaningless for
  sparse.
- Add fixes tag for patch #3 ~ #5.
- Change '1 << PAGE_SHIFT' to 'PAGE_SIZE' in patch #6.

Changes since v1:
- Fix a missing assignment of owner_bit in set_rc_wqe()

Jiaran Zhang (2):
  RDMA/hns: Add check for the validity of sl configuration
  RDMA/hns: Solve the overflow of the calc_pg_sz()

Lang Cheng (1):
  RDMA/hns: Correct typo of hns_roce_create_cq()

Weihang Li (3):
  RDMA/hns: Refactor process about opcode in post_send()
  RDMA/hns: Fix configuration of ack_req_freq in QPC
  RDMA/hns: Fix missing sq_sig_type when querying QP

Wenpeng Liang (1):
  RDMA/hns: Fix the wrong value of rnr_retry when querying qp

Yangyang Li (1):
  RDMA/hns: Add interception for resizing SRQs

 drivers/infiniband/hw/hns/hns_roce_cq.c    |   2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 178 ++++++++++++++++++-----------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |   2 +
 3 files changed, 114 insertions(+), 68 deletions(-)

-- 
2.8.1

