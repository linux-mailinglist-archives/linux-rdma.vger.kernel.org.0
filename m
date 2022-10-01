Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A162D5F188E
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Oct 2022 04:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiJACAz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Sep 2022 22:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiJACAx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Sep 2022 22:00:53 -0400
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6523315D86E;
        Fri, 30 Sep 2022 19:00:52 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="78596032"
X-IronPort-AV: E=Sophos;i="5.93,359,1654527600"; 
   d="scan'208";a="78596032"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP; 01 Oct 2022 11:00:50 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 31210D63B6;
        Sat,  1 Oct 2022 11:00:49 +0900 (JST)
Received: from kws-ab2.gw.nic.fujitsu.com (kws-ab2.gw.nic.fujitsu.com [192.51.206.12])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 53B72D94B2;
        Sat,  1 Oct 2022 11:00:48 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by kws-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id 564112340581;
        Sat,  1 Oct 2022 11:00:47 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>, linux-kernel@vger.kernel.org,
        Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH for-next] RDMA: return -EOPNOSUPP for ODP unsupported device
Date:   Sat,  1 Oct 2022 10:00:45 +0800
Message-Id: <20221001020045.8324-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27174.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27174.003
X-TMASE-Result: 10--0.947700-10.000000
X-TMASE-MatchedRID: Eg8aHm4JSTUuaxUO4rYWPEXBhxFdFgcQ2FA7wK9mP9cxknp8tpvjbvM+
        9Fw01I7GkLae+Z8yyg3mn3xyPJAJoh2P280ZiGmR5JzEkxvZR/gEa8g1x8eqF54Q+L3BXIWu18a
        7/fBfKbugx1wnIrEXsoAy6p60ZV62JW+71yEen6Zq8/xv2Um1avoLR4+zsDTtDbLQl5n/Oxwgka
        5LfQX3n02jsCRkWrecACuNaOQApNdGvQokYY7CuoNSU2AN4J/FOzfn2eoQfkzz8Wp0LowflBaF5
        J74V83BO2j5pQnMbAGGk+xUaqdMDwHEKwHwYevbwUSxXh+jiUgkww/gwY7hMA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

ib_reg_mr(3) which is used to register a MR with specific access flags
for specific HCA will set errno when something go wrong.
So, here we should return the specific -EOPNOTSUPP when the being
requested ODP access flag is unspported by the HCA(such as RXE).

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 include/rdma/ib_verbs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 975d6e9efbcb..a1f4d53a4bb6 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4334,7 +4334,7 @@ static inline int ib_check_mr_access(struct ib_device *ib_dev,
 
 	if (flags & IB_ACCESS_ON_DEMAND &&
 	    !(ib_dev->attrs.kernel_cap_flags & IBK_ON_DEMAND_PAGING))
-		return -EINVAL;
+		return -EOPNOTSUPP;
 	return 0;
 }
 
-- 
2.31.1

