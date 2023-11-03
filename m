Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3377E00E3
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Nov 2023 11:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347425AbjKCJ6n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Nov 2023 05:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347612AbjKCJ6m (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Nov 2023 05:58:42 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 03 Nov 2023 02:57:06 PDT
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA1A19B1
        for <linux-rdma@vger.kernel.org>; Fri,  3 Nov 2023 02:57:06 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="117881679"
X-IronPort-AV: E=Sophos;i="6.03,273,1694703600"; 
   d="scan'208";a="117881679"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 18:56:00 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 88FBDD7AC6;
        Fri,  3 Nov 2023 18:55:57 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
        by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id BF7FABF4CE;
        Fri,  3 Nov 2023 18:55:56 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
        by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 6480A2005019A;
        Fri,  3 Nov 2023 18:55:56 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by edo.cn.fujitsu.com (Postfix) with ESMTP id 700E21A006F;
        Fri,  3 Nov 2023 17:55:55 +0800 (CST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        matsuda-daisuke@fujitsu.com, bvanassche@acm.org,
        yi.zhang@redhat.com, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH RFC V2 0/6] rxe_map_mr_sg() fix cleanup and refactor
Date:   Fri,  3 Nov 2023 17:55:43 +0800
Message-ID: <20231103095549.490744-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27974.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27974.006
X-TMASE-Result: 10--3.540400-10.000000
X-TMASE-MatchedRID: lbdkQWb+CNZ7FdfjY17l1CrLqyE6Ur/jQAKUX1R86jREaWgrVqDVeMVj
        EEE40kDNsrSRpmPuC6OJkPXW/h6KPtBUMX40Rzs4HWRJEfGP5nlLGPRv0WdxQuCbuVI7hVbLQZy
        mCnqBETtHDz5ZOiZYEjMpKZXrj+gpiCsqewnUZGCeAiCmPx4NwGmRqNBHmBveafSbrzwSjfwqtq
        5d3cxkNcOo5CAUEzXzT4OcF00+rhBS37nkV5dwEM0Ej8BnTZk7fFtZCPptuK9AElnzg3Psefcxh
        EvTWX2jsXTik61d2ZGxRfKw2s3npRlPNqSHOjQGFcUQf3Yp/ridO0/GUi4gFb0fOPzpgdcEKeJ/
        HkAZ8Is=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I don't collect the Reviewed-by to the patch1-2 this time, since i
think we can make it better.

Patch1-2: Fix kernel panic[1] and benifit to make srp work again.
          Almost nothing change from V1.
Patch3-5: cleanups # newly add
Patch6: make RXE support PAGE_SIZE aligned mr # newly add, but not fully tested

My bad arm64 mechine offten hangs when doing blktests even though i use the
default siw driver.

- nvme and ULPs(rtrs, iser) always registers 4K mr still don't supported yet.

[1] https://lore.kernel.org/all/CAHj4cs9XRqE25jyVw9rj9YugffLn5+f=1znaBEnu1usLOciD+g@mail.gmail.com/T/

Li Zhijian (6):
  RDMA/rxe: RDMA/rxe: don't allow registering !PAGE_SIZE mr
  RDMA/rxe: set RXE_PAGE_SIZE_CAP to PAGE_SIZE
  RDMA/rxe: remove unused rxe_mr.page_shift
  RDMA/rxe: Use PAGE_SIZE and PAGE_SHIFT to extract address from
    page_list
  RDMA/rxe: cleanup rxe_mr.{page_size,page_shift}
  RDMA/rxe: Support PAGE_SIZE aligned MR

 drivers/infiniband/sw/rxe/rxe_mr.c    | 80 ++++++++++++++++-----------
 drivers/infiniband/sw/rxe/rxe_param.h |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h |  9 ---
 3 files changed, 48 insertions(+), 43 deletions(-)

-- 
2.41.0

