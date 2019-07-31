Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB88E7B8D6
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 06:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbfGaEj7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 00:39:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:6686 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbfGaEj7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Jul 2019 00:39:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2019 21:39:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,328,1559545200"; 
   d="scan'208";a="162980318"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga007.jf.intel.com with ESMTP; 30 Jul 2019 21:39:58 -0700
Date:   Tue, 30 Jul 2019 21:39:57 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] IB/core: Add mitigation for Spectre V1
Message-ID: <20190731043957.GA1600@agluck-desk2.amr.corp.intel.com>
References: <20190730202407.31046-1-tony.luck@intel.com>
 <95f5cf70-1a1d-f48c-efac-f389360f585e@embeddedor.com>
 <20190731042801.GA2179@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731042801.GA2179@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
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
V2: Mask the index *AFTER* the bounds check. Issue pointed
    out by Gustavo. Fix suggested by Ira.

 drivers/infiniband/core/user_mad.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index 9f8a48016b41..32cea5ed9ce1 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -49,6 +49,7 @@
 #include <linux/sched.h>
 #include <linux/semaphore.h>
 #include <linux/slab.h>
+#include <linux/nospec.h>
 
 #include <linux/uaccess.h>
 
@@ -888,7 +889,12 @@ static int ib_umad_unreg_agent(struct ib_umad_file *file, u32 __user *arg)
 	mutex_lock(&file->port->file_mutex);
 	mutex_lock(&file->mutex);
 
-	if (id >= IB_UMAD_MAX_AGENTS || !__get_agent(file, id)) {
+	if (id >= IB_UMAD_MAX_AGENTS) {
+		ret = -EINVAL;
+		goto out;
+	}
+	id = array_index_nospec(id, IB_UMAD_MAX_AGENTS);
+	if (!__get_agent(file, id)) {
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.20.1

