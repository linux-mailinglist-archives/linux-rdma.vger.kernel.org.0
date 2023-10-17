Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A2C7CBA36
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Oct 2023 07:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjJQFhw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Oct 2023 01:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbjJQFhv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Oct 2023 01:37:51 -0400
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A25E6
        for <linux-rdma@vger.kernel.org>; Mon, 16 Oct 2023 22:37:48 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="124414713"
X-IronPort-AV: E=Sophos;i="6.03,231,1694703600"; 
   d="scan'208";a="124414713"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 14:37:46 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 32137E0A42
        for <linux-rdma@vger.kernel.org>; Tue, 17 Oct 2023 14:37:44 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
        by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 65906CFA58
        for <linux-rdma@vger.kernel.org>; Tue, 17 Oct 2023 14:37:43 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
        by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 02BA720050181
        for <linux-rdma@vger.kernel.org>; Tue, 17 Oct 2023 14:37:43 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by edo.cn.fujitsu.com (Postfix) with ESMTP id 6415E1A0071;
        Tue, 17 Oct 2023 13:37:42 +0800 (CST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@ziepe.ca, Li Zhijian <lizhijian@fujitsu.com>,
        Markus Armbruster <armbru@redhat.com>
Subject: [PATCH rdma-core] libibverbs/man/ibv_reg_mr.3: Document errno on failure
Date:   Tue, 17 Oct 2023 13:37:37 +0800
Message-ID: <20231017053738.226069-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27940.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27940.005
X-TMASE-Result: 10--0.895900-10.000000
X-TMASE-MatchedRID: fOhfoy0690R2+9t+1OwlJ0rOO5m0+0gEAajW+EL+laOQx0NjGmV8+L8F
        Hrw7frluf146W0iUu2tPmq9X7CDoZi6wqUtNahOVx7+NomOZVWV9LQinZ4QefOYQ3zcXToXr+gt
        Hj7OwNO2OhzOa6g8KrSD/dKPQdev6FoL2JQ6r3oYvtnrBr8QaJsj5EQ1LTqAHt2mRc3BTIel9Jt
        rLk4j/lUHlK6pBUW2ZrHePAwD+b//5d4tKiVTuuxXBt/mUREyAj/ZFF9Wfm7hNy7ppG0IjcFQqk
        0j7vLVUewMSBDreIdk=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

'errno' is being widely used by applications when ibv_reg_mr returns NULL.
They all believe errno indicates the error on failure, so let's document
it explicitly.

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 libibverbs/man/ibv_reg_mr.3 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libibverbs/man/ibv_reg_mr.3 b/libibverbs/man/ibv_reg_mr.3
index 8f323891..d43799c5 100644
--- a/libibverbs/man/ibv_reg_mr.3
+++ b/libibverbs/man/ibv_reg_mr.3
@@ -103,7 +103,7 @@ deregisters the MR
 .I mr\fR.
 .SH "RETURN VALUE"
 .B ibv_reg_mr() / ibv_reg_mr_iova() / ibv_reg_dmabuf_mr()
-returns a pointer to the registered MR, or NULL if the request fails.
+returns a pointer to the registered MR, or NULL if the request fails (and sets errno to indicate the failure reason).
 The local key (\fBL_Key\fR) field
 .B lkey
 is used as the lkey field of struct ibv_sge when posting buffers with
-- 
2.31.1

