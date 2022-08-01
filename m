Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC1C58641E
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Aug 2022 08:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiHAGgm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Aug 2022 02:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiHAGgm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 1 Aug 2022 02:36:42 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E6112756;
        Sun, 31 Jul 2022 23:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1659335799; i=@fujitsu.com;
        bh=0HEuoI9nyvX0J/RT3XG5XKx/mQhjO2QVK+s4Wmq5aeo=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=jz8gICW+Wxq2jpsFo3pnZK4yJYRRsXgnJ//Yj6kLLefqfB+73SddFt0GHRsk5H0Q9
         wrGNGrHD8aiZTI4T56UDXOHBs1fDN428sDh49OnpAH9VdQisuSTkxAoyBYEwGwq1Is
         KuJx2eeKSuLg3Hm8V0/h2QR9jrqnSGz9U2WdHWR/5uoBqZHzQgfZJmLjdwX/5PXZBA
         qxieT2fARF5RGDOnG9jr8VyJFxI5bwgaKnfWrVGvQYuWpz1/kxP3yxp8DjcQGgcoGD
         z232UgHiNKcWMSA9CSUub9g+wXoV86UTvuTFMEWFOgRHFoMOqTNb+9qyWOb3ArZtln
         EnKLHKXi917uA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRWlGSWpSXmKPExsViZ8OxWbes5Hm
  Swc/vkhbTPvxktpg54wSjxZRfS5ktLu+aw2bx7FAvi0Xr0rdMDmwel694e2xa1cnm8XmTnMfW
  z7dZAliiWDPzkvIrElgzZix+xlrwnaOiv4GlgfEqexcjF4eQwEZGifPNlxi7GDmBnMVMEsfXe
  kMk9jNKtF/tYQZJsAloSNxruckIkhARWMso8evqS3aQBLOAm8SmN7PBbGGBCIkN6w+wgdgsAi
  oS61c/AmvmFXCUuPljJQuILSGgIDHl4XuouKDEyZlPWCDmSEgcfPECKM4BVKMkMbM7HqK8QmL
  WrDYmCFtN4uq5TcwTGPlnIemehaR7ASPTKkarpKLM9IyS3MTMHF1DAwNdQ0NTXSBpZKyXWKWb
  qJdaqlueWlyia6iXWF6sl1pcrFdcmZuck6KXl1qyiREY3inFDNU7GP/3/tQ7xCjJwaQkyvu14
  HmSEF9SfkplRmJxRnxRaU5q8SFGGQ4OJQne3/lAOcGi1PTUirTMHGCswaQlOHiURHjfgLTyFh
  ck5hZnpkOkTjEqSonz/i4CSgiAJDJK8+DaYPF9iVFWSpiXkYGBQYinILUoN7MEVf4VozgHo5I
  wbyPIFJ7MvBK46a+AFjMBLc4SfQKyuCQRISXVwDRHuG+JezXHqXCpbQ7vnn5qPrH18qecty6X
  37+877u3or/kldfV/ONNHkLfYhQPrK9+ai6YyOV/SMTzqdZJi/ZF5nYXU4ubV7UEJPCrVfxZM
  7czaB7LVOVjN0Wc2KY8YE2o/VVjFetw69vm7/Z7Pi+ZeHr9A6eiO+7CX78cuhjY9bh/8/yT/U
  H/i79fuZeaIVxy7eqtc3JmhjsYlLcvO1NzIMXUqO7li3Wzbta899z0f+O+U0FnVuktefTB3TH
  FeOoy7+9fldMnFf21Urh3pDdli0vROqvfzjlrlq39xul2qvXQ8sKYKKPjnlbGPu5ZXxMMrRPy
  skLcgldtW/i+ac+Tb4sOPnY1OFH654R2jvIhJZbijERDLeai4kQAPoVEt2oDAAA=
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-17.tower-587.messagelabs.com!1659335798!5601!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22600 invoked from network); 1 Aug 2022 06:36:38 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-17.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 1 Aug 2022 06:36:38 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 0B64814C;
        Mon,  1 Aug 2022 07:36:38 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id F28EC75;
        Mon,  1 Aug 2022 07:36:37 +0100 (BST)
Received: from 0211e8ad6dfa.localdomain (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Mon, 1 Aug 2022 07:36:34 +0100
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Leon Romanovsky" <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <target-devel@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH] RDMA/ib_srpt: unify checking rdma_cm_id condition in srpt_cm_req_recv()
Date:   Mon, 1 Aug 2022 06:43:46 +0000
Message-ID: <1659336226-2-1-git-send-email-lizhijian@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Although rdma_cm_id and ib_cm_id passing to srpt_cm_req_recv() are
exclusive currently, all other checking condition are using rdma_cm_id.
So unify the 'if' condition to make the code more clear.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index c3036aeac89e..21cbe30d526f 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -2218,13 +2218,13 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
 	ch->zw_cqe.done = srpt_zerolength_write_done;
 	INIT_WORK(&ch->release_work, srpt_release_channel_work);
 	ch->sport = sport;
-	if (ib_cm_id) {
-		ch->ib_cm.cm_id = ib_cm_id;
-		ib_cm_id->context = ch;
-	} else {
+	if (rdma_cm_id) {
 		ch->using_rdma_cm = true;
 		ch->rdma_cm.cm_id = rdma_cm_id;
 		rdma_cm_id->context = ch;
+	} else {
+		ch->ib_cm.cm_id = ib_cm_id;
+		ib_cm_id->context = ch;
 	}
 	/*
 	 * ch->rq_size should be at least as large as the initiator queue
-- 
1.8.3.1

