Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5BE260225
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Sep 2020 19:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbgIGRTv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Sep 2020 13:19:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11243 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729714AbgIGNzN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Sep 2020 09:55:13 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 020042E3525A7C3464EB;
        Mon,  7 Sep 2020 21:38:02 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Sep 2020 21:37:53 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 0/9] RDMA/hns: Misc Updates
Date:   Mon, 7 Sep 2020 21:36:39 +0800
Message-ID: <1599485808-29940-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There arm some cleanups and bugfix for hns driver:
- Patch #1 ~ #5 are cleanups, include refactor, some newly added checks and
  fix for a comment.
- Patch #6 ~ #9 are miscellaneous fixes.

Jiaran Zhang (2):
  RDMA/hns: Add check for the validity of sl configuration
  RDMA/hns: Solve the overflow of the calc_pg_sz()

Lang Cheng (2):
  RDMA/hns: Add type check in get/set hw field
  RDMA/hns: Correct typo of hns_roce_create_cq()

Weihang Li (3):
  RDMA/hns: Refactor process about opcode in post_send()
  RDMA/hns: Fix configuration of ack_req_freq in QPC
  RDMA/hns: Fix missing sq_sig_type when querying QP

Wenpeng Liang (1):
  RDMA/hns: Fix the wrong value of rnr_retry when querying qp

Yangyang Li (1):
  RDMA/hns: Add interception for resizing SRQs

 drivers/infiniband/hw/hns/hns_roce_common.h |  14 ++-
 drivers/infiniband/hw/hns/hns_roce_cq.c     |   2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 180 ++++++++++++++++++----------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |   2 +
 4 files changed, 127 insertions(+), 71 deletions(-)

-- 
2.8.1

