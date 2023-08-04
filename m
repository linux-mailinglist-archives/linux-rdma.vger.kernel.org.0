Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD8476F8A2
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Aug 2023 05:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbjHDDyx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Aug 2023 23:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbjHDDyt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Aug 2023 23:54:49 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4EB3C31;
        Thu,  3 Aug 2023 20:54:47 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RHBdx2X1qz1KCCw;
        Fri,  4 Aug 2023 11:53:41 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 11:54:44 +0800
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
Subject: [PATCH -next 6/6] brcm80211: Remove an unnecessary ternary operator
Date:   Fri, 4 Aug 2023 11:53:46 +0800
Message-ID: <20230804035346.2879318-7-ruanjinjie@huawei.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There is a ternary operator, the true or false judgement of which
is unnecessary in C language semantics.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
index 8580a2754789..8328b22829c5 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
@@ -27351,8 +27351,7 @@ static int wlc_phy_cal_rxiq_nphy_rev3(struct brcms_phy *pi,
 
 	for (rx_core = 0; rx_core < pi->pubpi.phy_corenum; rx_core++) {
 
-		skip_rxiqcal =
-			((rxcore_state & (1 << rx_core)) == 0) ? true : false;
+		skip_rxiqcal = (rxcore_state & (1 << rx_core)) == 0;
 
 		wlc_phy_rxcal_physetup_nphy(pi, rx_core);
 
-- 
2.34.1

