Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7114B2E147
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2019 17:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbfE2PjY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 May 2019 11:39:24 -0400
Received: from gateway36.websitewelcome.com ([192.185.184.18]:37353 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725936AbfE2PjY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 29 May 2019 11:39:24 -0400
X-Greylist: delayed 1432 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 May 2019 11:39:23 EDT
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 61182400C7209
        for <linux-rdma@vger.kernel.org>; Wed, 29 May 2019 09:35:58 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id W0IchjGY52PzOW0Ich5X6B; Wed, 29 May 2019 10:15:30 -0500
X-Authority-Reason: nr=8
Received: from [189.250.47.159] (port=47392 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hW0Ib-001KQP-2O; Wed, 29 May 2019 10:15:29 -0500
Date:   Wed, 29 May 2019 10:15:28 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] IB/hfi1: Use struct_size() helper
Message-ID: <20190529151528.GA24148@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.47.159
X-Source-L: No
X-Exim-ID: 1hW0Ib-001KQP-2O
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.47.159]:47392
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 17
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes, in particular in the
context in which this code is being used.

So, replace the following form:

sizeof(struct opa_port_status_rsp) + num_vls * sizeof(struct _vls_pctrs)

with:

struct_size(rsp, vls, num_vls)

and so on...

Also, notice that variable size is unnecessary, hence it is removed.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/infiniband/hw/hfi1/mad.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/mad.c b/drivers/infiniband/hw/hfi1/mad.c
index 4228393e6c4c..184dba3c2828 100644
--- a/drivers/infiniband/hw/hfi1/mad.c
+++ b/drivers/infiniband/hw/hfi1/mad.c
@@ -2744,8 +2744,7 @@ static int pma_get_opa_portstatus(struct opa_pma_mad *pmp,
 	u16 link_width;
 	u16 link_speed;
 
-	response_data_size = sizeof(struct opa_port_status_rsp) +
-				num_vls * sizeof(struct _vls_pctrs);
+	response_data_size = struct_size(rsp, vls, num_vls);
 	if (response_data_size > sizeof(pmp->data)) {
 		pmp->mad_hdr.status |= OPA_PM_STATUS_REQUEST_TOO_LARGE;
 		return reply((struct ib_mad_hdr *)pmp);
@@ -3014,8 +3013,7 @@ static int pma_get_opa_datacounters(struct opa_pma_mad *pmp,
 	}
 
 	/* Sanity check */
-	response_data_size = sizeof(struct opa_port_data_counters_msg) +
-				num_vls * sizeof(struct _vls_dctrs);
+	response_data_size = struct_size(req, port[0].vls, num_vls);
 
 	if (response_data_size > sizeof(pmp->data)) {
 		pmp->mad_hdr.status |= IB_SMP_INVALID_FIELD;
@@ -3232,8 +3230,7 @@ static int pma_get_opa_porterrors(struct opa_pma_mad *pmp,
 		return reply((struct ib_mad_hdr *)pmp);
 	}
 
-	response_data_size = sizeof(struct opa_port_error_counters64_msg) +
-				num_vls * sizeof(struct _vls_ectrs);
+	response_data_size = struct_size(req, port[0].vls, num_vls);
 
 	if (response_data_size > sizeof(pmp->data)) {
 		pmp->mad_hdr.status |= IB_SMP_INVALID_FIELD;
-- 
2.21.0

