Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEB163F30B
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Dec 2022 15:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiLAOkE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Dec 2022 09:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiLAOj4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Dec 2022 09:39:56 -0500
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com [195.245.230.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6FCA897B
        for <linux-rdma@vger.kernel.org>; Thu,  1 Dec 2022 06:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1669905590; i=@fujitsu.com;
        bh=9QlUY7MsB2ll2U8ok3nNDZF6dr0ghTqjtnnKEIgCBPE=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=IxfHlCiRSjHKaDuobEu5xPsJ3fQAN/EtyHHlThxOXNyJe8DVs8qO434DQNFale835
         Oled0U1T1J4PLgDCP0/gYrMjoPjuxToQcMUVM5xzxgczCoyZUgDJ6LEzIE9v+fXYN8
         SEVtwVjjvIMSoKuDnJDa+hnZvrKti2SMgPrg8ndzm78EywcrOlFcWVHXHYl806yoLK
         L2pyLIKh4YkY55cpSDD9/BAFSH04FUVM0Z6Mrkji6YibIaaJ2qJPd0xymn5AS1JumM
         J36jG0CGGcVlpH4cmPPLH8R6a+0fVPv0Wrxl3nVUoUYHTACA5NJ2JWFtnn1b7hxBjm
         MX8qduqJXNPvw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRWlGSWpSXmKPExsViZ8MxSXfrno5
  kg9W/bSyu/NvDaDHl11Jmi2eHelksvkydxmxx/lg/uwOrx85Zd9k9Nq3qZPPobX7H5vF5k1wA
  SxRrZl5SfkUCa8am5WfZCm6wVbz795G1gfEaaxcjF4eQwBZGiRcTV7BBOMuZJCac/gbl7GOU+
  HhmD3sXIycHm4CaxM7pL1lAbBEBb4kdN04wg9jMAvUSh49uYgSxhQX8Ja5PaQaLswioSDxf0s
  cKYvMKOEqsOQNRIyGgIDHl4XuwGk4BJ4n7PycBxTmAljlKdP6JhCgXlDg58wkLxHgJiYMvXjB
  DtCpKtC35xw5hV0jMmtXGBGGrSVw9t4l5AqPgLCTts5C0L2BkWsVoVpxaVJZapGtorpdUlJme
  UZKbmJmjl1ilm6iXWqpbnlpcomuol1herJdaXKxXXJmbnJOil5dasokRGAEpxewCOxiPLPujd
  4hRkoNJSZS3urMjWYgvKT+lMiOxOCO+qDQntfgQowwHh5IE78mdQDnBotT01Iq0zBxgNMKkJT
  h4lER4edcDpXmLCxJzizPTIVKnGBWlxHnrdgMlBEASGaV5cG2wBHCJUVZKmJeRgYFBiKcgtSg
  3swRV/hWjOAejkjDvtm1AU3gy80rgpr8CWswEtDhSrA1kcUkiQkqqgUmiRrLxU2SF36k+7rql
  Zw8YP2XOmXQgpmHO8qKCzIT7T1WVZpWYib5aExfWsujgSq9/T7iKa+1/SG41efVxgxkj56Yfs
  pd/Xtm7/qakgcnbCZHmi6uTPniL/c5vtOtQ/PntXqMAb5dBbrKqjvPPfoXS+DY7pfKr258vj/
  2v0LzjRKXzlbmSh7Lut5m/1Yk5ZNfP/Pr0AUNdszfBt4p/H2Y9vu5I0qev5jw/TjRL98uIH5R
  WfhPyMmFXBltsYP73oKSJ4Tcr2+Y9zw1nZg/8Ih4+77SPovZDj7+zZ2VaiL1tj5gZ4HF/zfYZ
  16yjBHZu75N6fF7RY46S5MmYD2HrH6zUcy+fHHcl+KUa484b2UosxRmJhlrMRcWJAMVV/a17A
  wAA
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-10.tower-585.messagelabs.com!1669905589!37381!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 26872 invoked from network); 1 Dec 2022 14:39:49 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-10.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 1 Dec 2022 14:39:49 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 9317C1000D7;
        Thu,  1 Dec 2022 14:39:49 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 860851000D5;
        Thu,  1 Dec 2022 14:39:49 +0000 (GMT)
Received: from fcf4c122d5e4.localdomain (10.167.215.54) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Thu, 1 Dec 2022 14:39:46 +0000
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>,
        <rpearsonhpe@gmail.com>
CC:     <leon@kernel.org>, <lizhijian@fujitsu.com>, <y-goto@fujitsu.com>,
        <zyjzyj2000@gmail.com>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH v7 8/8] RDMA/rxe: Enable atomic write capability for rxe device
Date:   Thu, 1 Dec 2022 14:39:28 +0000
Message-ID: <1669905568-62-4-git-send-email-yangx.jy@fujitsu.com>
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

The capability shows that rxe device supports atomic write operation.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_param.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
index 86c7a8bf3cbb..bbc88cd71d95 100644
--- a/drivers/infiniband/sw/rxe/rxe_param.h
+++ b/drivers/infiniband/sw/rxe/rxe_param.h
@@ -51,7 +51,12 @@ enum rxe_device_param {
 					| IB_DEVICE_SRQ_RESIZE
 					| IB_DEVICE_MEM_MGT_EXTENSIONS
 					| IB_DEVICE_MEM_WINDOW
+#ifdef CONFIG_64BIT
+					| IB_DEVICE_MEM_WINDOW_TYPE_2B
+					| IB_DEVICE_ATOMIC_WRITE,
+#else
 					| IB_DEVICE_MEM_WINDOW_TYPE_2B,
+#endif /* CONFIG_64BIT */
 	RXE_MAX_SGE			= 32,
 	RXE_MAX_WQE_SIZE		= sizeof(struct rxe_send_wqe) +
 					  sizeof(struct ib_sge) * RXE_MAX_SGE,
-- 
2.34.1

