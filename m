Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B3A6AE915
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Mar 2023 18:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjCGRUv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Mar 2023 12:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjCGRU3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Mar 2023 12:20:29 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968949885D;
        Tue,  7 Mar 2023 09:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678209350; x=1709745350;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=9MNP27OkAjl3jxgBz3lw6r+bSQsZ0Oli1yJ8N573650=;
  b=dYbPWmTN7El0qn4S9Dbnvo/h6y2phGrgfoW47ixoIpbwIVgj5TmXqEx4
   900UPZLD36JO8A+XgBbqm+egdNm75+fMLbw9FQmT2+k1Hc22uLdeOQnep
   AhnXOvV6cTWcAMO+b8Ul9Aeu+HrqDo6ZqDvgNsJDIwDMLgjNrJdzsqgx+
   sDWkUPeAST7INdTOrTZ9O4Vy5x0VNGjIHKshDGw5JZGLW7/UyM9G6FNZE
   0IiDqbwUGzSw2w5ulbecgeKi8gtAGb7bOg6BHR3wpU0/DyhO0DW8kVnn1
   YXYIj7uOBRewJV2u6XdgMJolzG4SZQPRAoF/sTd47LKZc/kzEKnfy4v0I
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="335933992"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="335933992"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 09:15:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="740788884"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="740788884"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.194.83])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 09:15:33 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Tue, 07 Mar 2023 09:15:31 -0800
Subject: [PATCH] rdma/qib: Remove deprecated kmap() call
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-kmap-qib-v1-1-e5a6fde167e0@intel.com>
X-B4-Tracking: v=1; b=H4sIADJxB2QC/x2MQQqDQAxFryJZN+BkUEuvUrrIaNSgndoZFEG8u
 8Hl+7z/DsiSVDK8igOSbJr1Fw3co4B25DgIamcMVJIvyTU4fXnBvwakhqvak3f9swLTA2fBkDi
 2ox3iOs82Lkl63e/++3OeFzEcYblvAAAA
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-ada30
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678209331; l=2276;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=9MNP27OkAjl3jxgBz3lw6r+bSQsZ0Oli1yJ8N573650=;
 b=5CE9oyeRnpd2lsobXE/e6ZLHnnJ9s5mGi2JYSu3s2zdQXFo5QH8kP7CdtU71ZjYsbct0OtE8n
 vdtu9XdtpY/Au6wkyOrFD83HN8iZnAJDTbHQGoybTazgk3kSgqveQk9
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

kmap() has been deprecated in favor of the kmap_local_page() call.
kmap_local_page() is thread local.

In the sdma coalesce case the page allocated is potentially free'ed in a
different context through qib_sdma_get_complete() ->
qib_user_sdma_make_progress().  The use of kmap_local_page() is
inappropriate in this call path.  However, the page is allocated using
GFP_KERNEL and will never be from highmem.

Remove the use of kmap calls and use page_address() in this case.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/infiniband/hw/qib/qib_user_sdma.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_user_sdma.c b/drivers/infiniband/hw/qib/qib_user_sdma.c
index 9fe03d6ffac1..336eb15a721f 100644
--- a/drivers/infiniband/hw/qib/qib_user_sdma.c
+++ b/drivers/infiniband/hw/qib/qib_user_sdma.c
@@ -320,7 +320,6 @@ static int qib_user_sdma_page_to_frags(const struct qib_devdata *dd,
 			unpin_user_page(page);
 		} else {
 			/* coalesce case */
-			kunmap(page);
 			__free_page(page);
 		}
 		ret = -ENOMEM;
@@ -572,7 +571,7 @@ static int qib_user_sdma_coalesce(const struct qib_devdata *dd,
 		goto done;
 	}
 
-	mpage = kmap(page);
+	mpage = page_address(page);
 	mpage_save = mpage;
 	for (i = 0; i < niov; i++) {
 		int cfur;
@@ -581,7 +580,7 @@ static int qib_user_sdma_coalesce(const struct qib_devdata *dd,
 				      iov[i].iov_base, iov[i].iov_len);
 		if (cfur) {
 			ret = -EFAULT;
-			goto free_unmap;
+			goto page_free;
 		}
 
 		mpage += iov[i].iov_len;
@@ -592,8 +591,7 @@ static int qib_user_sdma_coalesce(const struct qib_devdata *dd,
 			page, 0, 0, len, mpage_save);
 	goto done;
 
-free_unmap:
-	kunmap(page);
+page_free:
 	__free_page(page);
 done:
 	return ret;
@@ -627,9 +625,6 @@ static void qib_user_sdma_free_pkt_frag(struct device *dev,
 				       pkt->addr[i].dma_length,
 				       DMA_TO_DEVICE);
 
-		if (pkt->addr[i].kvaddr)
-			kunmap(pkt->addr[i].page);
-
 		if (pkt->addr[i].put_page)
 			unpin_user_page(pkt->addr[i].page);
 		else

---
base-commit: 8ca09d5fa3549d142c2080a72a4c70ce389163cd
change-id: 20230217-kmap-qib-27a563231f85

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>

