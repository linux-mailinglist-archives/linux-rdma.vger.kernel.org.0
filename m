Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B310AEA42
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2019 14:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391547AbfIJMYV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Sep 2019 08:24:21 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44154 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727265AbfIJMYU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Sep 2019 08:24:20 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6B0473CD9B150677DA5F;
        Tue, 10 Sep 2019 20:24:19 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Tue, 10 Sep 2019 20:24:08 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH rdma-core 0/5] Support UD on hip08
Date:   Tue, 10 Sep 2019 20:20:47 +0800
Message-ID: <1568118052-33380-1-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patchset enables hip08 to support Unreliable Datagram.

PR: https://github.com/linux-rdma/rdma-core/pull/575

Lijun Ou (2):
  libhns: Add support of handling AH for hip08
  libhns: Add UD support for hip08 in user mode

Weihang Li (1):
  libhns: Support configuring loopback mode by user

Yixian Liu (2):
  libhns: Bugfix for wqe idx calc of post verbs
  libhns: Refactor for post send

 kernel-headers/rdma/hns-abi.h    |   7 +
 providers/hns/hns_roce_u.c       |  17 ++
 providers/hns/hns_roce_u.h       |  39 +++
 providers/hns/hns_roce_u_abi.h   |   3 +-
 providers/hns/hns_roce_u_hw_v1.c |  27 +-
 providers/hns/hns_roce_u_hw_v2.c | 554 ++++++++++++++++++++-------------------
 providers/hns/hns_roce_u_hw_v2.h |  91 +++++++
 providers/hns/hns_roce_u_verbs.c |  58 ++++
 8 files changed, 510 insertions(+), 286 deletions(-)

-- 
2.8.1

