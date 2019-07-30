Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1097C7B44C
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2019 22:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfG3UYK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jul 2019 16:24:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:36452 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbfG3UYK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Jul 2019 16:24:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2019 13:24:09 -0700
X-IronPort-AV: E=Sophos;i="5.64,327,1559545200"; 
   d="scan'208";a="166061281"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2019 13:24:08 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Tony Luck <tony.luck@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] IB/core: Add mitigation for Spectre V1
Date:   Tue, 30 Jul 2019 13:24:07 -0700
Message-Id: <20190730202407.31046-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Some processors may mispredict an array bounds check and
speculatively access memory that they should not. With
a user supplied array index we like to play things safe
by masking the value with the array size before it is
used as an index.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---

[I don't have h/w, so just compile tested]

 drivers/infiniband/core/user_mad.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index 9f8a48016b41..fdce254e4f65 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -49,6 +49,7 @@
 #include <linux/sched.h>
 #include <linux/semaphore.h>
 #include <linux/slab.h>
+#include <linux/nospec.h>
 
 #include <linux/uaccess.h>
 
@@ -888,6 +889,7 @@ static int ib_umad_unreg_agent(struct ib_umad_file *file, u32 __user *arg)
 	mutex_lock(&file->port->file_mutex);
 	mutex_lock(&file->mutex);
 
+	id = array_index_nospec(id, IB_UMAD_MAX_AGENTS);
 	if (id >= IB_UMAD_MAX_AGENTS || !__get_agent(file, id)) {
 		ret = -EINVAL;
 		goto out;
-- 
2.20.1

