Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 924AE13BCBB
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jan 2020 10:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbgAOJtU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jan 2020 04:49:20 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8723 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729497AbgAOJtU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Jan 2020 04:49:20 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 24F57E9ED8377566A0D5;
        Wed, 15 Jan 2020 17:49:19 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Wed, 15 Jan 2020 17:49:12 +0800
From:   Yixian Liu <liuyixian@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v7 for-next 0/2] RDMA/hns: Add the workqueue framework for flush cqe handler
Date:   Wed, 15 Jan 2020 17:49:11 +0800
Message-ID: <1579081753-2839-1-git-send-email-liuyixian@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Earlier Background:
HiP08 RoCE hardware lacks ability(a known hardware problem) to flush
outstanding WQEs if QP state gets into errored mode for some reason.
To overcome this hardware problem and as a workaround, when QP is
detected to be in errored state during various legs like post send,
post receive etc [1], flush needs to be performed from the driver.

These data-path legs might get called concurrently from various context,
like thread and interrupt as well (like NVMe driver). Hence, these need
to be protected with spin-locks for the concurrency. This code exists
within the driver.

Problem:
Earlier The patch[1] sent to solve the hardware limitation explained
in the background section had a bug in the software flushing leg. It
acquired mutex while modifying QP state to errored state and while
conveying it to the hardware using the mailbox. This caused leg to
sleep while holding spin-lock and caused crash.

Suggested Solution:
In this patch, we have proposed to defer the flushing of the QP in
Errored state using the workqueue.

We do understand that this might have an impact on the recovery times
as scheduling of the workqueue handler depends upon the occupancy of
the system. Therefore to roughly mitigate this affect we have tried
to use Concurrency Managed workqueue to give worker thread (and
hence handler) a chance to run over more than one core.


[1] https://patchwork.kernel.org/patch/10534271/


This patch-set consists of:
[Patch 001] Introduce workqueue based WQE Flush Handler
[Patch 002] Call WQE flush handler in post {send|receive|poll}

v7 changes:
1. Delete unnecessary allocation of flush_work and do flush operation
   in flush handle function as needed according to Jason's suggestion.

v6 changes:
1. Holding lock when updating or referencing the flag being_push
   according to Jason's comment, i.e., fix the lock holding in
   hns_roce_v2_modify_qp and hns_roce_v2_poll_one.

v5 changes:
1. Remove WQ_MEM_RECLAIM flag according to Leon's suggestion.
2. Change to ordered workqueue for the requirement of flush work.

v4 changes:
1. Add flag for PI is being pushed according to Jason's suggestion
   to reduce unnecessary works submitted to workqueue.

v3 changes:
1. Fall back to dynamically allocate flush_work.

v2 changes:
1. Remove new created workqueue according to Jason's comment
2. Remove dynamic allocation for flush_work according to Jason's comment
3. Change current irq singlethread workqueue to concurrency management
   workqueue to ensure work unblocked.

Yixian Liu (2):
  RDMA/hns: Add the workqueue framework for flush cqe handler
  RDMA/hns: Delayed flush cqe process with workqueue

 drivers/infiniband/hw/hns/hns_roce_device.h |   4 ++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 103 ++++++++++++++++------------
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  44 ++++++++++++
 3 files changed, 109 insertions(+), 42 deletions(-)

-- 
2.7.4

