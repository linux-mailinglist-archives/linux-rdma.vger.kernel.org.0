Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A2463F2FC
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Dec 2022 15:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbiLAOhn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Dec 2022 09:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbiLAOhi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Dec 2022 09:37:38 -0500
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEA2DF96
        for <linux-rdma@vger.kernel.org>; Thu,  1 Dec 2022 06:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1669905452; i=@fujitsu.com;
        bh=FfLlPCCG9w8FAOO3CSSsEHATU1lxOB5eD9PRDzEV79Y=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=LCXZDZVnChrJ0S9KVEWEkZGyE5h56rtwZafNW84Rvi2gIBIox4DKaxbDTsPpOHwod
         8MFvjxH2bHA2dNd8hVP8RX6bLs3Knz7pE1jN5tI7D4DRXQF1/VIHp5+KcZYdmcYAFH
         d1DtW0ehVN9c/OdEpO20rclMFhIAz2zWuy8yTNJhmmEzGrcFMg3PHa1TzOqFboBvBq
         gpzPjHps7aW83YV2Wqm7Uh9xMmjpbxU7/Kg52QKR2QdI+JkZuOtqGAXtnjHloNMx2+
         JOifeKY5oyjwqEXpq4Sa+M9ZllKnjfuJeaF+SDhSTGkpkyxN99/qhpBzRUCKrHFjUk
         +aAC4FTm6rghg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRWlGSWpSXmKPExsViZ8OxWVd7T0e
  ywe8NmhZX/u1htJjyaymzxbNDvSwWX6ZOY7Y4f6yf3YHVY+esu+wem1Z1snn0Nr9j8/i8SS6A
  JYo1My8pvyKBNWPPzWesBb84K85Pes/cwHiOo4uRi0NIYCOjxIKmnSwQzhImidbeY+wQzj5Gi
  RmXuoAynBxsAmoSO6e/BLNFBLwldtw4wQxiMwvUSxw+uokRxBYW8JKYcOMvE4jNIqAicWX1XT
  YQm1fAUWLxualg9RICChJTHr4Hsjk4OAWcJJZczwEJCwGVvF/cCVUuKHFy5hMWiPESEgdfvIB
  qVZRoW/KPHcKukJg1q40JwlaTuHpuE/MERsFZSNpnIWlfwMi0itG0OLWoLLVI11gvqSgzPaMk
  NzEzRy+xSjdRL7VUtzy1uETXSC+xvFgvtbhYr7gyNzknRS8vtWQTIzD8U4pVlXcwfln6R+8Qo
  yQHk5Iob3VnR7IQX1J+SmVGYnFGfFFpTmrxIUYZDg4lCd6TO4FygkWp6akVaZk5wFiESUtw8C
  iJ8PKuB0rzFhck5hZnpkOkTjHqckyd/W8/sxBLXn5eqpQ4b88uoCIBkKKM0jy4EbC0cIlRVkq
  Yl5GBgUGIpyC1KDezBFX+FaM4B6OSMO+2bUBTeDLzSuA2vQI6ggnoiEixNpAjShIRUlINTHmT
  ueKLXs4uOqO33dPvhW3YZp32O8s5haZHeF/+pp315cKlQxseXRaf+cTtVs+7mVoTigWafQMaE
  rfNC1JluVT9536oV7bSu5jZ8QEKThVJD90lPjoWM0zNWNziwFsT9rz8oL5k2aqGW2flr/rFvn
  k25+ZBI8N2hQMvvny8GJzjqHOuWtPOOi1HIHTp/ImOj70qFk19/bvzrrImS77Kua+1X97r6Dq
  d4WFR/fbp5K+ysLTb0T9fFxd+Ent3hv1mLf/D94Zs4iUlHiUOPXfOGS+T7d/0QKs6c+NJX9eC
  CV/nbbrv21OtPP22oNqybUUr1hz6b5RYtnhL+lTO594c4bZq++1/vXqhubTWJWGelhJLcUaio
  RZzUXEiAOcardyGAwAA
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-3.tower-565.messagelabs.com!1669905451!231628!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 13967 invoked from network); 1 Dec 2022 14:37:31 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-3.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 1 Dec 2022 14:37:31 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 5CC6615A;
        Thu,  1 Dec 2022 14:37:31 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 500C3153;
        Thu,  1 Dec 2022 14:37:31 +0000 (GMT)
Received: from fcf4c122d5e4.localdomain (10.167.215.54) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Thu, 1 Dec 2022 14:37:28 +0000
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>,
        <rpearsonhpe@gmail.com>
CC:     <leon@kernel.org>, <lizhijian@fujitsu.com>, <y-goto@fujitsu.com>,
        <zyjzyj2000@gmail.com>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH v7 1/8] RDMA: Extend RDMA user ABI to support atomic write
Date:   Thu, 1 Dec 2022 14:37:05 +0000
Message-ID: <1669905432-14-2-git-send-email-yangx.jy@fujitsu.com>
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

1) Define new atomic write request/completion in userspace.
2) Define new atomic write capability in userspace.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 include/uapi/rdma/ib_user_verbs.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
index 43672cb1fd57..237814815544 100644
--- a/include/uapi/rdma/ib_user_verbs.h
+++ b/include/uapi/rdma/ib_user_verbs.h
@@ -466,6 +466,7 @@ enum ib_uverbs_wc_opcode {
 	IB_UVERBS_WC_BIND_MW = 5,
 	IB_UVERBS_WC_LOCAL_INV = 6,
 	IB_UVERBS_WC_TSO = 7,
+	IB_UVERBS_WC_ATOMIC_WRITE = 9,
 };
 
 struct ib_uverbs_wc {
@@ -784,6 +785,7 @@ enum ib_uverbs_wr_opcode {
 	IB_UVERBS_WR_RDMA_READ_WITH_INV = 11,
 	IB_UVERBS_WR_MASKED_ATOMIC_CMP_AND_SWP = 12,
 	IB_UVERBS_WR_MASKED_ATOMIC_FETCH_AND_ADD = 13,
+	IB_UVERBS_WR_ATOMIC_WRITE = 15,
 	/* Review enum ib_wr_opcode before modifying this */
 };
 
@@ -1331,6 +1333,8 @@ enum ib_uverbs_device_cap_flags {
 	/* Deprecated. Please use IB_UVERBS_RAW_PACKET_CAP_SCATTER_FCS. */
 	IB_UVERBS_DEVICE_RAW_SCATTER_FCS = 1ULL << 34,
 	IB_UVERBS_DEVICE_PCI_WRITE_END_PADDING = 1ULL << 36,
+	/* Atomic write attributes */
+	IB_UVERBS_DEVICE_ATOMIC_WRITE = 1ULL << 40,
 };
 
 enum ib_uverbs_raw_packet_caps {
-- 
2.34.1

