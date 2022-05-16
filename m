Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC21527B77
	for <lists+linux-rdma@lfdr.de>; Mon, 16 May 2022 03:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239119AbiEPBq5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 May 2022 21:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239107AbiEPBq4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 May 2022 21:46:56 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6C7B389B;
        Sun, 15 May 2022 18:46:51 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AY1UVBahwIWT95TrbS51G7n3NX1619BIKZh0ujC4?=
 =?us-ascii?q?5NGQNrF6WrkVWzDBNXDuDMq2DMDemc9h1OYi/phwAu5+Em4BkT1Nl/3w8FHgiR?=
 =?us-ascii?q?ejtX4rAdhiqV8+xwmwvdGo+toNGLICowPkcFhcwnT/wdOixxZVA/fvQHOCkUra?=
 =?us-ascii?q?dYnkZqTJME0/NtzoywobVvaY42bBVMyvV0T/Di5W31G2NglaYAUpIg063ky6Di?=
 =?us-ascii?q?dyp0N8uUvPSUtgQ1LPWvyF94JvyvshdJVOgKmVfNrbSq+ouUNiEEm3lExcFUrt?=
 =?us-ascii?q?Jk57wdAsEX7zTIROTzHFRXsBOgDAb/mprjPl9b6FaNC+7iB3Q9zx14NFMp5yxS?=
 =?us-ascii?q?wYgOIXCheYcTwJFVSp5OMWq/ZeeeyTl7JTPkRSun3zEhq8G4FsNFYYY9+B4EGZ?=
 =?us-ascii?q?T3fgZLi0dKBmHhui/yrv9Qe5p7uwyJc/pIYVZqHF95TXYC+s2B5zOXc3i5dZR3?=
 =?us-ascii?q?zA2wMpTEvnTT80DYDFrYVLLZBgnElMWDo8u2eSlnH/ydxVGp1+P46k6+W7eyEp?=
 =?us-ascii?q?2yreFGN7UfMGaAN9Zm0+wuG3L5SL6DwscOdjZziCKmlquieDnjyL2QI9UH7TQy?=
 =?us-ascii?q?xLAqDV/3URKUFtPCwT9+qL/1yaDtxtkAxR80kITQWIarSRHluXAYiA=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A1YA7Q6565j8rJVOCUQPXwPTXdLJyesId70hD?=
 =?us-ascii?q?6qkRc20wTiX8ra2TdZsguyMc9wx6ZJhNo7G90cq7MBbhHPxOkOos1N6ZNWGIhI?=
 =?us-ascii?q?LCFvAB0WKN+V3dMhy73utc+IMlSKJmFeD3ZGIQse/KpCW+DPYsqePqzJyV?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124250461"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 16 May 2022 09:46:50 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id CFF234D68A22;
        Mon, 16 May 2022 09:46:44 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 16 May 2022 09:46:45 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 16 May 2022 09:46:46 +0800
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Haakon Bugge" <haakon.bugge@oracle.com>,
        Cheng Xu <chengyou@linux.alibaba.com>,
        <linux-rdma@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v3 0/2] RDMA/rxe: Fix no completion event issue
Date:   Mon, 16 May 2022 09:53:27 +0800
Message-ID: <20220516015329.445474-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: CFF234D68A22.AFB2E
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Since RXE always posts RDMA_WRITE successfully, it's observed that
no more completion occurs after a few incorrect posts. Actually, it
will block the polling. we can easily reproduce it by the below pattern.

a. post correct RDMA_WRITE
b. poll completion event
while true {
  c. post incorrect RDMA_WRITE(wrong rkey for example)
  d. poll completion event <<<< block after 2 incorrect RDMA_WRITE posts
}


Li Zhijian (2):
  RDMA/rxe: Update wqe_index for each wqe error completion
  RDMA/rxe: Generate error completion for error requester QP state

 drivers/infiniband/sw/rxe/rxe_req.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

-- 
2.31.1



