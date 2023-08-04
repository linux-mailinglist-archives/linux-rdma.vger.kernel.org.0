Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6BD76F89F
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Aug 2023 05:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbjHDDyu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Aug 2023 23:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbjHDDys (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Aug 2023 23:54:48 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACE7422B;
        Thu,  3 Aug 2023 20:54:46 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RHBb94gk1zNmj2;
        Fri,  4 Aug 2023 11:51:17 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 11:54:43 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <sgoutham@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <jesse.brandeburg@intel.com>, <anthony.l.nguyen@intel.com>,
        <tariqt@nvidia.com>, <s.shtylyov@omp.ru>, <aspriel@gmail.com>,
        <franky.lin@broadcom.com>, <hante.meuleman@broadcom.com>,
        <kvalo@kernel.org>, <richardcochran@gmail.com>,
        <yoshihiro.shimoda.uh@renesas.com>, <ruanjinjie@huawei.com>,
        <u.kleine-koenig@pengutronix.de>, <mkl@pengutronix.de>,
        <lee@kernel.org>, <set_pte_at@outlook.com>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <intel-wired-lan@lists.osuosl.org>, <linux-rdma@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list.pdl@broadcom.com>,
        <SHA-cyfmac-dev-list@infineon.com>
Subject: [PATCH -next 5/6] net: fjes: Remove an unnecessary ternary operator
Date:   Fri, 4 Aug 2023 11:53:45 +0800
Message-ID: <20230804035346.2879318-6-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804035346.2879318-1-ruanjinjie@huawei.com>
References: <20230804035346.2879318-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is a ternary operator, the true or false judgement of which
is unnecessary in C language semantics.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/net/fjes/fjes_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/fjes/fjes_main.c b/drivers/net/fjes/fjes_main.c
index 2513be6d4e11..a0d915d1dbed 100644
--- a/drivers/net/fjes/fjes_main.c
+++ b/drivers/net/fjes/fjes_main.c
@@ -612,7 +612,7 @@ fjes_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
 	eth = (struct ethhdr *)skb->data;
 	my_epid = hw->my_epid;
 
-	vlan = (vlan_get_tag(skb, &vlan_id) == 0) ? true : false;
+	vlan = vlan_get_tag(skb, &vlan_id) == 0;
 
 	data = skb->data;
 	len = skb->len;
-- 
2.34.1

