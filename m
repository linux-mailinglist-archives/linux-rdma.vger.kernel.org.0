Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BA163F30C
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Dec 2022 15:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbiLAOkE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Dec 2022 09:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbiLAOkB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Dec 2022 09:40:01 -0500
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00381ABA08
        for <linux-rdma@vger.kernel.org>; Thu,  1 Dec 2022 06:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1669905596; i=@fujitsu.com;
        bh=tSWt+WRtlgPCC3kQZfe74/61cw+qJNzqFeDZ1w6llZg=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=FCelKeizaGdkql+cMKcKIVkr6rXYh4dsB6Lr5QwVBpUh6TJd+ELU75nLGAUjEX20g
         z479dKB+d2bGSvN7UTvT6dKTQGQED502kzTuey2XN3+456MSrfI4w4HBS0Q5EccFUU
         IvPmhqeMFoZCVKWDDu6ZwUeM4uwsNtFKsSQFQNNZCYs8ynNnLfdbkBzgsJIlDX/v3p
         wesv4ZlxuTzK1F1tToMcsZq2/YMKhBob7bQw6kA122ft01+rAaj5jN8G+TDjdvDlKP
         U8QJk2XMOSGXDxBVic7vNX+/PmdX9MlarBRwpJ8V1hfq89FMNveFkr5swX5lcPOoDR
         4O2MkTJdxCQ5w==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRWlGSWpSXmKPExsViZ8ORpLtpT0e
  ywbR5hhZX/u1htJjyaymzxbNDvSwWX6ZOY7Y4f6yf3YHVY+esu+wem1Z1snn0Nr9j8/i8SS6A
  JYo1My8pvyKBNWPN2UfsBZs4KmYePs3awDiDvYuRi0NIYCOjxMF5G1kgnCVMEpMPX2XuYuQEc
  vYxSkzZFQ5iswmoSeyc/pIFxBYR8JbYceMEWA2zQL3E4aObGEFsYQFnia1XtgLFOThYBFQkZr
  +QAQnzCjhKnDnymxXElhBQkJjy8D1YK6eAk8T9n5MYQcqFgGo6/0RClAtKnJz5hAViuoTEwRc
  vmCFaFSXalvxjh7ArJGbNamOCsNUkrp7bxDyBUXAWkvZZSNoXMDKtYjQtTi0qSy3SNdJLKspM
  zyjJTczM0Uus0k3USy3VLU8tLtE11EssL9ZLLS7WK67MTc5J0ctLLdnECAz9lGKW2TsYe5b+0
  TvEKMnBpCTKW93ZkSzEl5SfUpmRWJwRX1Sak1p8iFGGg0NJgvfkTqCcYFFqempFWmYOMA5h0h
  IcPEoivLzrgdK8xQWJucWZ6RCpU4zGHNs+79vLzDF19r/9zEIsefl5qVLivHW7gUoFQEozSvP
  gBsHSwyVGWSlhXkYGBgYhnoLUotzMElT5V4ziHIxKwrzbtgFN4cnMK4Hb9wroFCagUyLF2kBO
  KUlESEk1MGlEWvP0JTE03eCtnXenbulzIZGXbjJa2ev2H3Fg/1x6XvekjtrH7UejWPhfvjtjM
  Uuy1sHw6/sVOy/krryflFS99AhvzOcP64K8Y9Z9XDonvLZfw7c1pCKKseAsS8pKo72mdpUTVK
  LqWt7v4fjAJ6rXuezXuou//t6M9D9+JSnp59awpLulFkuuCP3Y2dr8gO3CyRs3T/ma3v4gUCz
  0SveNgWZe5T5TWY3d8iXvzx9qcdjWvK3Ut4SBraXusr3wpxvPNuZ2lK20WZIguVOzf8Pfv+yr
  Vn+Z+/RoW/PTBqa83/ETdL60CcaZlOmqhvEf2XZ65pcH7mVTWKMWLvJm8phkqre6zmFRRMBV3
  f9za5RYijMSDbWYi4oTAeCnvIqKAwAA
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-5.tower-591.messagelabs.com!1669905586!125903!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30982 invoked from network); 1 Dec 2022 14:39:46 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-5.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 1 Dec 2022 14:39:46 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 699171B8;
        Thu,  1 Dec 2022 14:39:46 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 5E5EE1B7;
        Thu,  1 Dec 2022 14:39:46 +0000 (GMT)
Received: from fcf4c122d5e4.localdomain (10.167.215.54) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Thu, 1 Dec 2022 14:39:42 +0000
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>,
        <rpearsonhpe@gmail.com>
CC:     <leon@kernel.org>, <lizhijian@fujitsu.com>, <y-goto@fujitsu.com>,
        <zyjzyj2000@gmail.com>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH v7 7/8] RDMA/rxe: Implement atomic write completion
Date:   Thu, 1 Dec 2022 14:39:27 +0000
Message-ID: <1669905568-62-3-git-send-email-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1669905568-62-1-git-send-email-yangx.jy@fujitsu.com>
References: <1669905568-62-1-git-send-email-yangx.jy@fujitsu.com>
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

Generate an atomic write completion when the atomic write request
has been finished.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 4dca4f8bbb5a..1c525325e271 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -104,6 +104,7 @@ static enum ib_wc_opcode wr_to_wc_opcode(enum ib_wr_opcode opcode)
 	case IB_WR_LOCAL_INV:			return IB_WC_LOCAL_INV;
 	case IB_WR_REG_MR:			return IB_WC_REG_MR;
 	case IB_WR_BIND_MW:			return IB_WC_BIND_MW;
+	case IB_WR_ATOMIC_WRITE:		return IB_WC_ATOMIC_WRITE;
 
 	default:
 		return 0xff;
@@ -269,6 +270,9 @@ static inline enum comp_state check_ack(struct rxe_qp *qp,
 		if ((syn & AETH_TYPE_MASK) != AETH_ACK)
 			return COMPST_ERROR;
 
+		if (wqe->wr.opcode == IB_WR_ATOMIC_WRITE)
+			return COMPST_WRITE_SEND;
+
 		fallthrough;
 		/* (IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE doesn't have an AETH)
 		 */
-- 
2.34.1

