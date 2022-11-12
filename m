Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BE162579E
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Nov 2022 11:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbiKKKHw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Nov 2022 05:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbiKKKHu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Nov 2022 05:07:50 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3C2D133
        for <linux-rdma@vger.kernel.org>; Fri, 11 Nov 2022 02:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668161270; x=1699697270;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WqIHW5rIJGjRnOOBtAA92WovK7kvGIkLccBduRrhFsI=;
  b=LvVUn8wJrWwgSN0gAYHzaqOsKepbbaPzX1SGE2kkfNzN9JmjS12O/dVW
   hnH2JUWnbADRHaKZTcme2MTE6kjv3U6TIowwzByusaBa9ntKpcslaoCw3
   6fkVgVA7Eca0iGUm6mXokZ4q2EfKrFa07xauvPbvcs3rL7RvArIDn/HC7
   KHeUEtZHR+XTn0KsQ+FrRSRqKcqbj73nk3luQalo1718Wm36oYtYQE4De
   Kx72+tMIADoh/uWHP0/CkcY9ZtYsN/NaGKvTMB8tHf2aeigSKwAIv1gYU
   DnSeVwGPvQz9B7sWtYJNr/6j/iabINvwX9HPrHq4s4docTyHjcYKAhiUW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="310283052"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="310283052"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 02:07:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="668770186"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="668770186"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga008.jf.intel.com with ESMTP; 11 Nov 2022 02:07:47 -0800
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH 1/1] RDMA/rxe: Remove reliable datagram support
Date:   Fri, 11 Nov 2022 21:35:37 -0500
Message-Id: <20221112023537.432912-1-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

The rdma_rxe driver does not actually support the reliable datagram
transport but contains a variable with RD opcodes in driver code.
And this variable is never used. So remove it.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_hdr.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_hdr.h b/drivers/infiniband/sw/rxe/rxe_hdr.h
index e432f9e37795..804594b76040 100644
--- a/drivers/infiniband/sw/rxe/rxe_hdr.h
+++ b/drivers/infiniband/sw/rxe/rxe_hdr.h
@@ -742,7 +742,6 @@ enum aeth_syndrome {
 	AETH_NAK_INVALID_REQ	= 0x61,
 	AETH_NAK_REM_ACC_ERR	= 0x62,
 	AETH_NAK_REM_OP_ERR	= 0x63,
-	AETH_NAK_INV_RD_REQ	= 0x64,
 };
 
 static inline u8 __aeth_syn(void *arg)
-- 
2.27.0

