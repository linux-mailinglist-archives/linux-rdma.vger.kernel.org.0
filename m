Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BA83984BF
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jun 2021 10:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbhFBI77 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Jun 2021 04:59:59 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3385 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbhFBI76 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Jun 2021 04:59:58 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Fw2s24LDFz65J6;
        Wed,  2 Jun 2021 16:54:30 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 16:58:09 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 2 Jun 2021 16:58:09 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>
Subject: [PATCH RESEND v2 for-next 0/7] RDMA/hns: Use new interfaces to write/read fields 
Date:   Wed, 2 Jun 2021 16:57:38 +0800
Message-ID: <1622624265-44796-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema753-chm.china.huawei.com (10.1.198.195)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

hr_reg_*() is simpler than roce_set_*(), and the field/bit can be generated
automatically and accurately.

Changes since v1:
* Add a patch to fix gcc warnings about PREP_FIELD().
* Fix a typo in #5.
* Link: https://patchwork.kernel.org/project/linux-rdma/cover/1622281154-49867-1-git-send-email-liweihang@huawei.com/

Lang Cheng (3):
  RDMA/hns: Fix potential compile warnings on hr_reg_write()
  RDMA/hns: Use new interface to modify QP context
  RDMA/hns: Use new interface to get CQE fields

Xi Wang (1):
  RDMA/hns: Clean SRQC structure definition

Yixing Liu (3):
  RDMA/hns: Use new interface to write CQ context.
  RDMA/hns: Use new interface to write FRMR fields
  RDMA/hns: Use new interface to write DB related fields

 drivers/infiniband/hw/hns/hns_roce_common.h |    6 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 1065 +++++++++------------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  862 +++++++---------------
 3 files changed, 644 insertions(+), 1289 deletions(-)

-- 
2.7.4

