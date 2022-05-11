Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFBC52299B
	for <lists+linux-rdma@lfdr.de>; Wed, 11 May 2022 04:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239660AbiEKCXm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 May 2022 22:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236215AbiEKCXi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 May 2022 22:23:38 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30FE215C1B5;
        Tue, 10 May 2022 19:23:37 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3A17x7wq21Y2L4QGYB9PbD5Qpzkn2cJEfYwER7XOP?=
 =?us-ascii?q?LsXnJ0DMg12MPxmEWXDuAaKuONGP2LttwOti18x4AvpCDydM2QQE+nZ1PZygU8?=
 =?us-ascii?q?JKaX7x1DatR0xu6d5SFFAQ+hyknQoGowPscEzmM9n9BDpC79SMmjfvQH+KlYAL?=
 =?us-ascii?q?5EnsZqTFMGX5JZS1Ly7ZRbr5A2bBVMivV0T/Ai5S31GyNh1aYBlkpB5er83uDi?=
 =?us-ascii?q?hhdVAQw5TTSbdgT1LPXeuJ84Jg3fcldJFOgKmVY83LTegrN8F251juxExYFAdX?=
 =?us-ascii?q?jnKv5c1ERX/jZOg3mZnh+AvDk20Yd4HdplPtT2Pk0MC+7jx2NnsJxyddMvJqYR?=
 =?us-ascii?q?xorP7HXhaIWVBww/yRWZPcaoeOdfSPj2SCU5wicG5f2+N18HUMkLI9Cor4vKW5?=
 =?us-ascii?q?L/P0cbjsKa3irg+Ow3aL+SeR2gMknBNfkMZlZuXx6yzzdS/E8TvjrR6TM+M8dx?=
 =?us-ascii?q?js1j+hQEvvEIckUczxiaFLHeRInElUYB7osneqwiz/0elVlRPi9zUYsyzGLilU?=
 =?us-ascii?q?vj/62a5yIEuFmjP59xi6wzl8qNUyjav3CCOGi9A=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AKmn0IK7wHUSVs7PKhAPXwPTXdLJyesId70hD?=
 =?us-ascii?q?6qkRc20wTiX8ra2TdZsguyMc9wx6ZJhNo7G90cq7MBbhHPxOkOos1N6ZNWGIhI?=
 =?us-ascii?q?LCFvAB0WKN+V3dMhy73utc+IMlSKJmFeD3ZGIQse/KpCW+DPYsqePqzJyV?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124142434"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 May 2022 10:23:32 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 7B4064D1716F;
        Wed, 11 May 2022 10:23:27 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 11 May 2022 10:23:27 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 11 May 2022 10:23:27 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Wed, 11 May 2022 10:23:25 +0800
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        <linux-rdma@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v2 0/2] RDMA/rxe: Fix no completion event issue
Date:   Wed, 11 May 2022 10:30:28 +0800
Message-ID: <20220511023030.229212-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 7B4064D1716F.AB924
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
  RDMA/rxe: Generate error completion for error requester state

 drivers/infiniband/sw/rxe/rxe_req.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

-- 
2.31.1



