Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC083356649
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Apr 2021 10:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237821AbhDGISp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Apr 2021 04:18:45 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:15932 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbhDGISo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Apr 2021 04:18:44 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FFcgM3TfJzjYY3;
        Wed,  7 Apr 2021 16:16:47 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Wed, 7 Apr 2021 16:18:26 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>
Subject: [PATCH v2 for-next 0/7] RDMA/core: Correct some coding-style issues
Date:   Wed, 7 Apr 2021 16:15:46 +0800
Message-ID: <1617783353-48249-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Do some cleanups according to the coding-style of kernel.

Changes since v1:
- Remove a BUG_ON in #3 and put the changes into a new patch.
- Drop the parts about spaces around xx_for_each_xx() from #4 because some
  clang formatter prefer current style.
- Link: https://patchwork.kernel.org/project/linux-rdma/cover/1617697184-48683-1-git-send-email-liweihang@huawei.com/

Weihang Li (1):
  RDMA/core: Remove redundant BUG_ON

Wenpeng Liang (6):
  RDMA/core: Print the function name by __func__ instead of an fixed
    string
  RDMA/core: Remove the redundant return statements
  RDMA/core: Add necessary spaces
  RDMA/core: Remove redundant spaces
  RDMA/core: Correct format of braces
  RDMA/core: Correct format of block comments

 drivers/infiniband/core/cache.c      |  3 ++-
 drivers/infiniband/core/cm.c         | 39 ++++++++++++++++----------------
 drivers/infiniband/core/cm_msgs.h    |  4 ++--
 drivers/infiniband/core/cma.c        | 21 ++++++++++--------
 drivers/infiniband/core/iwcm.c       |  1 -
 drivers/infiniband/core/iwpm_msg.c   |  3 ++-
 drivers/infiniband/core/mad.c        | 43 ++++++++++++++++--------------------
 drivers/infiniband/core/mad_rmpp.c   | 10 ++++-----
 drivers/infiniband/core/sysfs.c      | 13 +++++------
 drivers/infiniband/core/ucma.c       |  8 +++----
 drivers/infiniband/core/umem.c       |  4 ++--
 drivers/infiniband/core/user_mad.c   | 30 +++++++++++--------------
 drivers/infiniband/core/uverbs_cmd.c | 22 +++++++++---------
 drivers/infiniband/core/verbs.c      |  3 ++-
 14 files changed, 98 insertions(+), 106 deletions(-)

-- 
2.8.1

