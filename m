Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB6E751497
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jul 2023 01:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjGLXlt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jul 2023 19:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjGLXls (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jul 2023 19:41:48 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4294119
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jul 2023 16:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689205305; x=1720741305;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NDM1GLLqipqCvLCWqCXsY7OpVFXGUb0MCKIdfC40eLU=;
  b=jPUfszAQrZOEqwFzc6OmmyO16c7Ex1HWsQ3ap7/QMj8ayIcTYaUAO9ZC
   KyxG4SJUCnDdKA45zeyzc/eN4ioMmSWFFxScGSKJafzBgZ9/NIkSVjCxI
   hdwlhLN6ijrznRetvaUrk+NNBrAaHCxZ6EHY9CAKBTxHHogjiquG0E+qn
   gow97UBRNxgPlFsZV/OG0T19cQkkmjGSnyRsac2LD7vUOW89nKHxybfda
   Uaxa1C7tvbN+Jyhmtlz2a3IVl4EDKv2C1GiV8N5ux2w5eyFYCL3CrMq9G
   IRgf6fWXbzhflvObsacCYux2LTnNqzsQQvXjhtDMDPyy/KreK+MXjM5md
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="349886951"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="349886951"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 16:41:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="699040857"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="699040857"
Received: from ssaleem-mobl1.amr.corp.intel.com ([10.92.33.5])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 16:41:45 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     phaddad@nvidia.com, jgg@nvidia.com, leon@kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-rc] RDMA/core: Update CMA destination address on rdma_resolve_addr
Date:   Wed, 12 Jul 2023 18:41:33 -0500
Message-Id: <20230712234133.1343-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

8d037973d48c ("RDMA/core: Refactor rdma_bind_addr") intoduces as regression
on irdma devices on certain tests which uses rdma CM, such as cmtime.

No connections can be established with the MAD QP experiences a fatal
error on the active side.

The cma destination address is not updated with the dst_addr when ULP
on active side calls rdma_bind_addr followed by rdma_resolve_addr.
The id_priv state is 'bound' in resolve_prepare_src and update is skipped.

This leaves the dgid passed into irdma driver to create an Address Handle
(AH) for the MAD QP at 0. The create AH descriptor as well as the ARP cache
entry is invalid and HW throws an asynchronous events as result.

[ 1207.656888] resolve_prepare_src caller: ucma_resolve_addr+0xff/0x170 [rdma_ucm] daddr=200.0.4.28 id_priv->state=7
[....]
[ 1207.680362] ice 0000:07:00.1 rocep7s0f1: caller: irdma_create_ah+0x3e/0x70 [irdma] ah_id=0 arp_idx=0 dest_ip=0.0.0.0
destMAC=00:00:64:ca:b7:52 ipvalid=1 raw=0000:0000:0000:0000:0000:ffff:0000:0000
[ 1207.682077] ice 0000:07:00.1 rocep7s0f1: abnormal ae_id = 0x401 bool qp=1 qp_id = 1, ae_src=5
[ 1207.691657] infiniband rocep7s0f1: Fatal error (1) on MAD QP (1)

Fix this by updating the CMA destination address when the ULP calls
a resolve address with the CM state already bound.

Fixes: 8d037973d48c ("RDMA/core: Refactor rdma_bind_addr")
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/core/cma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 1ee87c3..9891c7d 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -4062,6 +4062,8 @@ static int resolve_prepare_src(struct rdma_id_private *id_priv,
 					   RDMA_CM_ADDR_QUERY)))
 			return -EINVAL;
 
+	} else {
+		memcpy(cma_dst_addr(id_priv), dst_addr, rdma_addr_size(dst_addr));
 	}
 
 	if (cma_family(id_priv) != dst_addr->sa_family) {
-- 
1.8.3.1

