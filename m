Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCCD607179
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Oct 2022 09:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiJUHxX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Oct 2022 03:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJUHxW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Oct 2022 03:53:22 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63979248CA5;
        Fri, 21 Oct 2022 00:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1666338799; i=@fujitsu.com;
        bh=szLPaMCwWt2GPt2jeJIVDwTUnrQYN4R0TZFNJZtF4F0=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=Jadakq0kgQ70LzVsgo3OvNlv6DPt3X4StCr9zmJbLjox7xyldFOO8jZ4zM7mzy328
         wFEG61t+voVKPJ18ubn7566Q9hcvxk7lFhzdKBCWvppVrZDfKSkqQGszAEUpWl2cbN
         0sLOlI7XvxTrGOzb5jBmkkug0+i33BSeapDml/IMFv+mDGDgT/tRLDJmqC2zzAs5Y3
         gjQed4k4oJlmC1Xr5zWSqy7P1FYWyObNUFlxBS06MgqjYvhhzfVOxZGX2vNl1ZwhgJ
         ewWqQZ9fgd0W8aleJuC6V94LUoA/mKv/p0qSK6M/flnYDZ5USgEm96szAmGESPDRVo
         M4bQJ9ATlN/Nw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRWlGSWpSXmKPExsViZ8OxWfe9f1C
  yQe9zQYuZM04wWkz5tZTZ4vKuOWwWzw71slicP9bP7sDqsXPWXXaPTas62Tw+b5Lz2Pr5NksA
  SxRrZl5SfkUCa0bvgnb2gk2cFU+mLWNvYPzM3sXIySEksJFRYvOCuC5GLiB7CZPE645uZgjnA
  KPE3BmfmUGq2AQ0JO613GQEsUUEYiT+HfsFZjMLuElsejMbbJKwgIfEiUsHwOIsAqoSK6fsBb
  I5OHgFHCU+TUgHCUsIKEhMefgebCSngJPEvzVHWSCOcJT4duoGE4jNKyAocXLmExaI8RISB1+
  8YAYZIyGgJDGzOx5iTIXErFltTBC2msTVc5uYJzAKzkLSPQtJ9wJGplWMpsWpRWWpRbrGeklF
  mekZJbmJmTl6iVW6iXqppbrlqcUlukZ6ieXFeqnFxXrFlbnJOSl6eaklmxiBoZ9SrKq8g/HL0
  j96hxglOZiURHmFFIKShfiS8lMqMxKLM+KLSnNSiw8xynBwKEnwzvUBygkWpaanVqRl5gDjEC
  YtwcGjJMLb6wWU5i0uSMwtzkyHSJ1iVJQS513iB5QQAElklObBtcFi/xKjrJQwLyMDA4MQT0F
  qUW5mCar8K0ZxDkYlYd58kPE8mXklcNNfAS1mAlpsusUPZHFJIkJKqoHpiQHz0x1X93PG1Tpq
  7ZL9l1Mh+Wrnwou8jbcFKhfdCgiYv+zahLrn376wdaxN0j+5KPFRqV/kvOfz3j5LfaPjvm+7y
  83pnQUz3zXmPLrJxLR2xf3rTFML3q7S3PZmxovwN10GH2ftZH+9/rKG9UFjOb/ezsMK0fm+Lx
  uYTl3/+lJz5U1JhSv2SrUij5e73f70sDlQ3VB0W79dQ/ItLa45m9wXHrb/+Tr04jt+jvoSnkM
  Fj+rfb5y7aJpxxbcNAvc7wk5nP2wrdPGReCgqsuyG7696qcL7zI96JzY73/8hdytlov2HOTck
  Y5sWTmlT2T5P4S4Th+9k3VMn3zP4LZpwId5l1TJOoV2Xn157m/5xS70SS3FGoqEWc1FxIgByl
  4TQeAMAAA==
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-2.tower-548.messagelabs.com!1666338799!83842!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30517 invoked from network); 21 Oct 2022 07:53:19 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-2.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 21 Oct 2022 07:53:19 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id F3E2F154;
        Fri, 21 Oct 2022 08:53:18 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id E5470152;
        Fri, 21 Oct 2022 08:53:18 +0100 (BST)
Received: from 988193f0f739.localdomain (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 21 Oct 2022 08:53:16 +0100
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     <zyjzyj2000@gmail.com>, <jgg@ziepe.ca>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [for-next PATCH v2 1/2] RDMA/rxe: Remove unnecessary mr testing
Date:   Fri, 21 Oct 2022 07:52:44 +0000
Message-ID: <1666338764-2-2-git-send-email-lizhijian@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1666338764-2-1-git-send-email-lizhijian@fujitsu.com>
References: <1666338764-2-1-git-send-email-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Before the testing, we already passed it to rxe_mr_copy() where mr could
be dereferenced. so this checking is not exactly correct.

I tried to figure out the details how/when mr could be NULL, but failed
at last. Add a WARN_ON(!mr) to that path to tell us more when it
happends.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index ed5a09e86417..218c14fb07c6 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -778,6 +778,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	if (res->state == rdatm_res_state_new) {
 		if (!res->replay) {
 			mr = qp->resp.mr;
+			WARN_ON(!mr);
 			qp->resp.mr = NULL;
 		} else {
 			mr = rxe_recheck_mr(qp, res->read.rkey);
@@ -811,8 +812,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 
 	rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
 		    payload, RXE_FROM_MR_OBJ);
-	if (mr)
-		rxe_put(mr);
+	rxe_put(mr);
 
 	if (bth_pad(&ack_pkt)) {
 		u8 *pad = payload_addr(&ack_pkt) + payload;
-- 
2.31.1

