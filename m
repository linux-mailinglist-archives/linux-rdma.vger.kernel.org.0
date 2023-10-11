Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742447C4BE3
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Oct 2023 09:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344707AbjJKHdb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Oct 2023 03:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344466AbjJKHdb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Oct 2023 03:33:31 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C55391;
        Wed, 11 Oct 2023 00:33:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VtvoMBA_1697009602;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VtvoMBA_1697009602)
          by smtp.aliyun-inc.com;
          Wed, 11 Oct 2023 15:33:26 +0800
From:   "D. Wythe" <alibuda@linux.alibaba.com>
To:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        wintera@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        "D. Wythe" <alibuda@linux.alibaba.com>
Subject: [PATCH net 0/5] net/smc: bugfixs for smc-r
Date:   Wed, 11 Oct 2023 15:33:15 +0800
Message-Id: <1697009600-22367-1-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: "D. Wythe" <alibuda@linux.alibaba.com>

This patches contains bugfix following:

1. hung state
2. sock leak
3. potential panic 

We have been testing these patches for some time, but
if you have any questions, please let us know.

Thanks,
D. Wythe

D. Wythe (5):
  net/smc: fix dangling sock under state SMC_APPFINCLOSEWAIT
  net/smc: fix incorrect barrier usage
  net/smc: allow cdc msg send rather than drop it with NULL sndbuf_desc
  net/smc: protect connection state transitions in listen work
  net/smc: put sk reference if close work was canceled

 net/smc/af_smc.c    |  9 +++++++--
 net/smc/smc.h       |  5 +++++
 net/smc/smc_cdc.c   | 11 +++++------
 net/smc/smc_close.c |  5 +++--
 net/smc/smc_core.c  | 21 +++++++++++++--------
 5 files changed, 33 insertions(+), 18 deletions(-)

-- 
1.8.3.1

