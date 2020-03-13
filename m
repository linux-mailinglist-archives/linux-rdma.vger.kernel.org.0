Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13DE418472C
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2020 13:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgCMMrK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Mar 2020 08:47:10 -0400
Received: from mga12.intel.com ([192.55.52.136]:46773 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbgCMMrJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 13 Mar 2020 08:47:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 05:47:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,548,1574150400"; 
   d="scan'208";a="444293444"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga006.fm.intel.com with ESMTP; 13 Mar 2020 05:47:08 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 02DCl7UE045180;
        Fri, 13 Mar 2020 05:47:07 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 02DCl5fZ015004;
        Fri, 13 Mar 2020 08:47:05 -0400
Subject: [PATCH] RDMA/core: Insure security pkey modify is not lost
To:     jgg@ziepe.ca, dledford@redhat.com
From:   Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc:     linux-rdma@vger.kernel.org
Date:   Fri, 13 Mar 2020 08:47:05 -0400
Message-ID: <20200313124704.14982.55907.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The following modify sequence (loosely based on ipoib) will
lose a pkey modifcation:

- Modify (pkey index, port)
- Modify (new pkey index, NO port)

After the first modify, the qp_pps list will have saved the pkey and the
unit on the main list.

During the second modify, get_new_pps() will fetch the port from qp_pps
and read the new pkey index from qp_attr->pkey_index.  The state will
still be zero, or IB_PORT_PKEY_NOT_VALID. Because of the invalid state,
the new values will never replace the one in the qp pps list, losing
the new pkey.

This happens because the following if statements will never correct the
state because the first term will be false. If the code had been executed,
it would incorrectly overwrite valid values.

if ((qp_attr_mask & IB_QP_PKEY_INDEX) && (qp_attr_mask & IB_QP_PORT))
	new_pps->main.state = IB_PORT_PKEY_VALID;


if (!(qp_attr_mask & (IB_QP_PKEY_INDEX | IB_QP_PORT)) && qp_pps) {
	new_pps->main.port_num = qp_pps->main.port_num;
	new_pps->main.pkey_index = qp_pps->main.pkey_index;
	if (qp_pps->main.state != IB_PORT_PKEY_NOT_VALID)
		new_pps->main.state = IB_PORT_PKEY_VALID;
}

Fix by joining the two if statements with an or test to see if qp_pps
is non-NULL and in the correct state.

Fixes: 1dd017882e01 ("RDMA/core: Fix protection fault in get_pkey_idx_qp_list")
Reviewed-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
---
 drivers/infiniband/core/security.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/security.c b/drivers/infiniband/core/security.c
index 2d56083..75e7ec0 100644
--- a/drivers/infiniband/core/security.c
+++ b/drivers/infiniband/core/security.c
@@ -349,16 +349,11 @@ static struct ib_ports_pkeys *get_new_pps(const struct ib_qp *qp,
 	else if (qp_pps)
 		new_pps->main.pkey_index = qp_pps->main.pkey_index;
 
-	if ((qp_attr_mask & IB_QP_PKEY_INDEX) && (qp_attr_mask & IB_QP_PORT))
+	if (((qp_attr_mask & IB_QP_PKEY_INDEX) &&
+	     (qp_attr_mask & IB_QP_PORT)) ||
+	    (qp_pps && qp_pps->main.state != IB_PORT_PKEY_NOT_VALID))
 		new_pps->main.state = IB_PORT_PKEY_VALID;
 
-	if (!(qp_attr_mask & (IB_QP_PKEY_INDEX | IB_QP_PORT)) && qp_pps) {
-		new_pps->main.port_num = qp_pps->main.port_num;
-		new_pps->main.pkey_index = qp_pps->main.pkey_index;
-		if (qp_pps->main.state != IB_PORT_PKEY_NOT_VALID)
-			new_pps->main.state = IB_PORT_PKEY_VALID;
-	}
-
 	if (qp_attr_mask & IB_QP_ALT_PATH) {
 		new_pps->alt.port_num = qp_attr->alt_port_num;
 		new_pps->alt.pkey_index = qp_attr->alt_pkey_index;

