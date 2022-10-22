Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB9C6084D6
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Oct 2022 08:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJVGAv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 22 Oct 2022 02:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJVGAu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 22 Oct 2022 02:00:50 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A6E1B76CD;
        Fri, 21 Oct 2022 23:00:49 -0700 (PDT)
X-QQ-mid: bizesmtp75t1666418438tbilfr1b
Received: from localhost.localdomain ( [182.148.15.254])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 22 Oct 2022 14:00:37 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: 83ShfzFP0oCsVNFApbRJ/sBNu+ffLHLYRxSDQXWTKDZF/CVMpg6ZgldqLiH0O
        57lkFHcbwXQIGelSTIH/thyWcJoPp14Xk9JhpHz0K5ohySKHKN1D3zmlsai3DYTsa/e2BOk
        J3wf113PX24Im98AAtmE2lrmSwTkCy88u/wzZ13KVmFXkzbGsd3oUOQDO0OpCnuSHKDI2xg
        qiWr+Bkf41GWNbvgiX42rmc5Z9cflUxyBq3OEX3NoQ18BqxB+t6MZeI8j1yj2wXdIBV6v1I
        F67fTqbLGehKnd3MycTkq+rVSiwzR7sj9tvuSq8wzploEAa3KoEIpgDoPhF0J/o2vO9x5yj
        v3RCgVH+CxkqyQ072Ups1gCodXK6s//YvUGFJwEqgtR0Ne7+3Q=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] infiniband/core: fix repeated words in comments
Date:   Sat, 22 Oct 2022 14:00:30 +0800
Message-Id: <20221022060030.50900-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/infiniband/core/cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 4084d05a4510..2e91d8879326 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -1422,7 +1422,7 @@ int rdma_read_gid_l2_fields(const struct ib_gid_attr *attr,
 			*vlan_id = vlan_dev_vlan_id(ndev);
 		} else {
 			/* If the netdev is upper device and if it's lower
-			 * device is vlan device, consider vlan id of the
+			 * device is vlan device, consider vlan id of
 			 * the lower vlan device for this gid entry.
 			 */
 			netdev_walk_all_lower_dev_rcu(attr->ndev,
-- 
2.36.1

