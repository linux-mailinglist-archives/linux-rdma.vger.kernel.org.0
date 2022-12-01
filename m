Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7568F63F2FF
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Dec 2022 15:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbiLAOhv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Dec 2022 09:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbiLAOhr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Dec 2022 09:37:47 -0500
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614D6934EC
        for <linux-rdma@vger.kernel.org>; Thu,  1 Dec 2022 06:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1669905459; i=@fujitsu.com;
        bh=ZK8Efl9z678rw148ueqLeEgrY9S2f6x3CIBXj07afh4=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=Yd2Vr1ve+b5DNhumiz29BPVFIceEz7zavrJBIpEOm2BOjXWCGf6+8f1zbvV8XKZsu
         SY/YiO0GCE0+vHqMUUV7jtFzUI1j8KNf2Q3TM8HeoyXz9+RBRPV4QeLCnc5qrRyQBW
         7jv3q1gIMPRtRpawFyL3BR00XwDpZeAPiS1/nrcr09dBZj5yNBSsJCTPIfotN1tU37
         mEd8SDSABi6YY7Az4QXTcQEl1PkJ3C+CwxbOxR+D0PhU1cQxTl+j9eMYm7LoVjK2E/
         eSgp9InwKrfPgfEXPf4Yx5npy8mRhuqpd2Kn1QOwSzBPYWfYT5InH2IEgIPuE1/beT
         A+QBuAfeHN7QQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRWlGSWpSXmKPExsViZ8ORqGu0pyP
  Z4MdidYsr//YwWkz5tZTZ4tmhXhaLL1OnMVucP9bP7sDqsXPWXXaPTas62Tx6m9+xeXzeJBfA
  EsWamZeUX5HAmvFtznXWgjssFReuzWJuYOxj6WLk4hAS2MIo8XXPAlYIZzmTxPWf95khnH2ME
  lsPPQEq4+RgE1CT2Dn9JZgtIuAtsePGCWYQm1mgXuLw0U2MILawgK9Ew6p+MJtFQEVi/+Y9YD
  W8Ao4Ss+edYgKxJQQUJKY8fA8U5+DgFHCSWHI9ByQsBFTyfnEnG0S5oMTJmRBrmQUkJA6+eME
  M0aoo0bbkHzuEXSExa1Yb1Eg1iavnNjFPYBSchaR9FpL2BYxMqxjNilOLylKLdI0M9JKKMtMz
  SnITM3P0Eqt0E/VSS3XLU4tLdA31EsuL9VKLi/WKK3OTc1L08lJLNjECIyClmHHKDsaeZX/0D
  jFKcjApifJWd3YkC/El5adUZiQWZ8QXleakFh9ilOHgUJLgPbkTKCdYlJqeWpGWmQOMRpi0BA
  ePkggv73qgNG9xQWJucWY6ROoUo6KUOG/PLqCEAEgiozQPrg2WAC4xykoJ8zIyMDAI8RSkFuV
  mlqDKv2IU52BUEubdtg1oCk9mXgnc9FdAi5mAFkeKtYEsLklESEk1MIVc7q69Leq71Tev/pWO
  8J6Z/BtfCJxg/SIrvUyrd+m9b5KXkgOaz3nejbJwNVip7yMoxOG9UWHGbLGjchVatlP1ImTYb
  85cfU/g4Q51H8cS7V3Mu2/4vWBaF3vQ7KlBrpr3Hfl3nswvvv2I4n5YL3bndw33spOf55h0sy
  /1N7j6c4WLkWlmYLlqmYdZzpEXnyfqVy+Z/9lm+z85qYwTG/fJzozLd7n0xl67Vi9mItfUzsi
  U3PMp724cPOnrlOnQrPhuhlXElebaFQ6PZ0n3dpqYnvGaXWSwtWlBxapF0y04069fSuLPO/zO
  4Or2yJ0qKz4/3rZywueVn2fqm5mXBKbwVN/tCpjWXjjZrPRrthJLcUaioRZzUXEiACk0+eJ7A
  wAA
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-7.tower-591.messagelabs.com!1669905458!126544!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24822 invoked from network); 1 Dec 2022 14:37:38 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-7.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 1 Dec 2022 14:37:38 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 3B4C81001A4;
        Thu,  1 Dec 2022 14:37:38 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 2F5D71001A3;
        Thu,  1 Dec 2022 14:37:38 +0000 (GMT)
Received: from fcf4c122d5e4.localdomain (10.167.215.54) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Thu, 1 Dec 2022 14:37:34 +0000
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>,
        <rpearsonhpe@gmail.com>
CC:     <leon@kernel.org>, <lizhijian@fujitsu.com>, <y-goto@fujitsu.com>,
        <zyjzyj2000@gmail.com>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH v7 3/8] RDMA/rxe: Extend rxe user ABI to support atomic write
Date:   Thu, 1 Dec 2022 14:37:07 +0000
Message-ID: <1669905432-14-4-git-send-email-yangx.jy@fujitsu.com>
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

Define an atomic_wr array to store 8-byte value.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 include/uapi/rdma/rdma_user_rxe.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
index 73f679dfd2df..d20d1ecf046f 100644
--- a/include/uapi/rdma/rdma_user_rxe.h
+++ b/include/uapi/rdma/rdma_user_rxe.h
@@ -146,6 +146,7 @@ struct rxe_dma_info {
 	__u32			reserved;
 	union {
 		__DECLARE_FLEX_ARRAY(__u8, inline_data);
+		__DECLARE_FLEX_ARRAY(__u8, atomic_wr);
 		__DECLARE_FLEX_ARRAY(struct rxe_sge, sge);
 	};
 };
-- 
2.34.1

