Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F9063F2FD
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Dec 2022 15:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbiLAOhp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Dec 2022 09:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbiLAOhm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Dec 2022 09:37:42 -0500
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583A1193C6
        for <linux-rdma@vger.kernel.org>; Thu,  1 Dec 2022 06:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1669905455; i=@fujitsu.com;
        bh=VO14fUgyPPJQRq4eUvVY9zLoFkqhS3vwzH23JgLcFIM=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=O9wi/sMDZgM5/A8SfI25g3/8c4xysIZsvcMRtEPLEUgGXwK1Fvgp3K2WWP1wosoCv
         EsBYHegBAMUsBrDNUAQy8iaQ7DMZniycenHBV292PFwuXRbIhmjSy3mHPC0C3JG62f
         /YxRHFvsWxCYtuiTWqU/vCfgHK0wHdSdLjPG03shSszaWmvNE4JAs4+G0de1+AhUNP
         q1F+nYqm9tTcS+jPMdqWoqS0KFHM8zhouORa/OnlO333g+bur6dVoc30BmsQbfLlut
         8aDStj3lBiuROzLISfP1Q0zmZGWFqlt0UDm9LQ659mBqY193flPqEKXfFOOKNkNLC3
         m/muTNG6uAQ8Q==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRWlGSWpSXmKPExsViZ8MxSVd/T0e
  ywZJ/rBZX/u1htJjyaymzxbNDvSwWX6ZOY7Y4f6yf3YHVY+esu+wem1Z1snn0Nr9j8/i8SS6A
  JYo1My8pvyKBNWPWgtWsBa0CFTdmXWBuYDzB28XIySEksIVR4m1vRBcjF5C9nEni7rsDbBDOP
  kaJmd/PMIJUsQmoSeyc/pIFxBYR8JbYceMEM4jNLFAvcfjoJrAaYQEfiZsH1rKB2CwCKhIrpl
  8Gs3kFHCWmP13KCmJLCChITHn4HqiXg4NTwEliyfUciCMcJd4v7oQqF5Q4OfMJC8R4CYmDL14
  wQ7QqSrQt+ccOYVdIzJrVxgRhq0lcPbeJeQKj4Cwk7bOQtC9gZFrFaFqcWlSWWqRrqpdUlJme
  UZKbmJmjl1ilm6iXWqpbnlpcomuol1herJdaXKxXXJmbnJOil5dasokRGPwpxYxlOxi7l/3RO
  8QoycGkJMpb3dmRLMSXlJ9SmZFYnBFfVJqTWnyIUYaDQ0mC9+ROoJxgUWp6akVaZg4wEmHSEh
  w8SiK8vOuB0rzFBYm5xZnpEKlTjIpS4rw9u4ASAiCJjNI8uDZY9F9ilJUS5mVkYGAQ4ilILcr
  NLEGVf8UozsGoJMy7bRvQFJ7MvBK46a+AFjMBLY4UawNZXJKIkJJqYDI0q5nNmtitcXJJ+NVM
  rmePQiz4HkowJB0VU7p+7e7PC/IGAvHCstPm+a+YuvfAb/OCGw/vfRHT7rE4llw1c0+Sxsd3j
  cI7mBX2pnKwdAvwbWVJPps0RTLZQlKJM69pApPuheuT7os+NHsapnNh0cdDD3P75J9w/OG32r
  BTqD/v5+OlvNZn58UcVOhV5ry4crZ95OIPzwWFNU4IH1Ddk523SuDXPOZL3T+L6gv3yF8WnBv
  xbvd+zXMVtu/0JtpzvRfpWipj5vSbY97Bo6Vvb5eWztSzYMgP8DmVzTmj9MEM/k//z+TNOM4q
  m1jWE75qn/GcA9KLnDZfY3w0897Sw//5K3lvelbKqEzOjRUU41ViKc5INNRiLipOBABq9UPoe
  QMAAA==
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-4.tower-591.messagelabs.com!1669905454!16804!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 29237 invoked from network); 1 Dec 2022 14:37:35 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-4.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 1 Dec 2022 14:37:35 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id A906E1000D5;
        Thu,  1 Dec 2022 14:37:34 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 9C0061000C1;
        Thu,  1 Dec 2022 14:37:34 +0000 (GMT)
Received: from fcf4c122d5e4.localdomain (10.167.215.54) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Thu, 1 Dec 2022 14:37:31 +0000
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>,
        <rpearsonhpe@gmail.com>
CC:     <leon@kernel.org>, <lizhijian@fujitsu.com>, <y-goto@fujitsu.com>,
        <zyjzyj2000@gmail.com>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH v7 2/8] RDMA: Extend RDMA kernel ABI to support atomic write
Date:   Thu, 1 Dec 2022 14:37:06 +0000
Message-ID: <1669905432-14-3-git-send-email-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1669905432-14-1-git-send-email-yangx.jy@fujitsu.com>
References: <1669905432-14-1-git-send-email-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.215.54]
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

1) Define new atomic write request/completion in kernel.
2) Define new atomic write capability in kernel.
3) Define new atomic write opcode for RC service in packet.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 include/rdma/ib_pack.h  | 2 ++
 include/rdma/ib_verbs.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/include/rdma/ib_pack.h b/include/rdma/ib_pack.h
index a9162f25beaf..f932d164af63 100644
--- a/include/rdma/ib_pack.h
+++ b/include/rdma/ib_pack.h
@@ -84,6 +84,7 @@ enum {
 	/* opcode 0x15 is reserved */
 	IB_OPCODE_SEND_LAST_WITH_INVALIDATE         = 0x16,
 	IB_OPCODE_SEND_ONLY_WITH_INVALIDATE         = 0x17,
+	IB_OPCODE_ATOMIC_WRITE                      = 0x1D,
 
 	/* real constants follow -- see comment about above IB_OPCODE()
 	   macro for more details */
@@ -112,6 +113,7 @@ enum {
 	IB_OPCODE(RC, FETCH_ADD),
 	IB_OPCODE(RC, SEND_LAST_WITH_INVALIDATE),
 	IB_OPCODE(RC, SEND_ONLY_WITH_INVALIDATE),
+	IB_OPCODE(RC, ATOMIC_WRITE),
 
 	/* UC */
 	IB_OPCODE(UC, SEND_FIRST),
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 77dd9148815b..df6bb26ba0be 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -270,6 +270,7 @@ enum ib_device_cap_flags {
 	/* The device supports padding incoming writes to cacheline. */
 	IB_DEVICE_PCI_WRITE_END_PADDING =
 		IB_UVERBS_DEVICE_PCI_WRITE_END_PADDING,
+	IB_DEVICE_ATOMIC_WRITE = IB_UVERBS_DEVICE_ATOMIC_WRITE,
 };
 
 enum ib_kernel_cap_flags {
@@ -982,6 +983,7 @@ enum ib_wc_opcode {
 	IB_WC_BIND_MW = IB_UVERBS_WC_BIND_MW,
 	IB_WC_LOCAL_INV = IB_UVERBS_WC_LOCAL_INV,
 	IB_WC_LSO = IB_UVERBS_WC_TSO,
+	IB_WC_ATOMIC_WRITE = IB_UVERBS_WC_ATOMIC_WRITE,
 	IB_WC_REG_MR,
 	IB_WC_MASKED_COMP_SWAP,
 	IB_WC_MASKED_FETCH_ADD,
@@ -1325,6 +1327,7 @@ enum ib_wr_opcode {
 		IB_UVERBS_WR_MASKED_ATOMIC_CMP_AND_SWP,
 	IB_WR_MASKED_ATOMIC_FETCH_AND_ADD =
 		IB_UVERBS_WR_MASKED_ATOMIC_FETCH_AND_ADD,
+	IB_WR_ATOMIC_WRITE = IB_UVERBS_WR_ATOMIC_WRITE,
 
 	/* These are kernel only and can not be issued by userspace */
 	IB_WR_REG_MR = 0x20,
-- 
2.34.1

