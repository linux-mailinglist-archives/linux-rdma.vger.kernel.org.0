Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24111BF588
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2020 12:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgD3Kbp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Apr 2020 06:31:45 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54180 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726127AbgD3Kbp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Apr 2020 06:31:45 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 20F807087F72418D922B;
        Thu, 30 Apr 2020 18:31:44 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Thu, 30 Apr 2020 18:31:37 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 0/3] RDMA/hns: Misc cleanups
Date:   Thu, 30 Apr 2020 18:31:28 +0800
Message-ID: <1588242691-12913-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Some tiny cleanups for hns driver.

Weihang Li (2):
  RDMA/hns: Fix comments with non-English symbols
  RDMA/hns: Adjust lp_pktn_ini dynamically

Wenpeng Liang (1):
  RDMA/hns: Remove redundant assignment of caps

 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 8 ++------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 7 +++----
 2 files changed, 5 insertions(+), 10 deletions(-)

-- 
2.8.1

