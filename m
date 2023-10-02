Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FF57B56BC
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Oct 2023 17:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237914AbjJBPKx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Oct 2023 11:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238000AbjJBPKu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Oct 2023 11:10:50 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F3E101;
        Mon,  2 Oct 2023 08:10:46 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-406609df1a6so27712595e9.3;
        Mon, 02 Oct 2023 08:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696259445; x=1696864245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6gyQNJ2XnyFpWZfsSOVQ7NTvT9jbamCtiO1RkGRSocs=;
        b=XnyeWFthWXTSam4+atm+D83C2M/AzlPk+tLjIWfQfx4QLv3obgmIrtDzk+MZ+CeN1q
         TXKmfqUKInmzJQOZMqx9sFEb+CcY5Si9qicB8ubXo9Kp5RlP+M+x3W16RK0bj1SnoYGV
         qiwgtd0xKVxBdbe7fUoXcAcrz/R4mIv9Mp9i2o2wDBLgLgIDtj6noqoFQqs+qff6Jlft
         balwX4hrk1r1Abnifj18pKtnKlZjz1eSXVjBK7rRgBqICDWps2zt0gCDVm0LmQ5KYmXZ
         u6g13onr3BuMc4hO4f3Jo2SUOYPH1BMM9kS2TpDeG/Inz9JJBb3rDvhbxhZjh98wAiZz
         GOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696259445; x=1696864245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6gyQNJ2XnyFpWZfsSOVQ7NTvT9jbamCtiO1RkGRSocs=;
        b=PNK/LszHaQF7HPhpgkhSqAQ5HmhDTc1gEZ7/ffa0Wzvpmqg00YkHcbDmxBGfpBG/UE
         1a1/pTXph0xm8dMXQ4H0ONCZ5ni1ORldKqyZaqRQirn3+RqKxq0sv2wSUfmeXGVwBFSb
         ujCkwp4KT/+qlmoD2uaIt9ayZt3vpF10TPojhOBgkhEVV/SNkLXIfYH39BEAmMUwzuLR
         91IXNMQNIQmgcbfYu38lQ5tzcCmGOr6xqgEsskzpMHXTaxxPdUJcpjBfGxj2JzTmV76t
         5VznNo+uRO+mEsUGt8OCL7pPDu8qpHeHJNjKBDmleXGWeKkq3kP4YJ86yfhoCseRPVYs
         yqRw==
X-Gm-Message-State: AOJu0Ywu8n/i/OnrRZXiE3puan5SzsGfpEZWZcKXGofKrzxuLbuGzMth
        6r1M8hPaVAKaoIQrP+T6VfM=
X-Google-Smtp-Source: AGHT+IHc5YiZnwUBsMAS0VclvrmwyD0ekRYikQ7eali40Cd+T9SQe91Rx4Z4tqTKa7Zvq69Zs0IYGQ==
X-Received: by 2002:a7b:c397:0:b0:3fe:3004:1ffd with SMTP id s23-20020a7bc397000000b003fe30041ffdmr10304452wmj.4.1696259444747;
        Mon, 02 Oct 2023 08:10:44 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id t15-20020a1c770f000000b00406408dc788sm7421565wmi.44.2023.10.02.08.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 08:10:44 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Chris Snook <chris.snook@gmail.com>,
        Raju Rangoju <rajur@chelsio.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Shailend Chand <shailend@google.com>,
        Douglas Miller <dougmill@linux.ibm.com>,
        Nick Child <nnac123@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Haren Myneni <haren@linux.ibm.com>,
        Rick Lindsley <ricklind@linux.ibm.com>,
        Dany Madden <danymadden@us.ibm.com>,
        Thomas Falcon <tlfalcon@linux.ibm.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
        Intel Corporation <linuxwwan@intel.com>,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>,
        Liu Haijun <haijun.liu@mediatek.com>,
        M Chetan Kumar <m.chetan.kumar@linux.intel.com>,
        Ricardo Martinez <ricardo.martinez@linux.intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Yuanjun Gong <ruc_gongyuanjun@163.com>,
        Wei Fang <wei.fang@nxp.com>, Alex Elder <elder@linaro.org>,
        Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
        Bailey Forrest <bcf@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Junfeng Guo <junfeng.guo@intel.com>,
        Ziwei Xiao <ziweixiao@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rushil Gupta <rushilg@google.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Yuri Karpov <YKarpov@ispras.ru>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Zheng Zengkai <zhengzengkai@huawei.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Lee Jones <lee@kernel.org>, Dawei Li <set_pte_at@outlook.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Benjamin Berg <benjamin.berg@intel.com>,
        Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: [net-next PATCH 4/4] netdev: use napi_schedule bool instead of napi_schedule_prep/__napi_schedule
Date:   Mon,  2 Oct 2023 17:10:23 +0200
Message-Id: <20231002151023.4054-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231002151023.4054-1-ansuelsmth@gmail.com>
References: <20231002151023.4054-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Replace if condition of napi_schedule_prep/__napi_schedule and use bool
from napi_schedule directly where possible.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/ethernet/atheros/atlx/atl1.c     | 4 +---
 drivers/net/ethernet/toshiba/tc35815.c       | 4 +---
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c | 4 +---
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/atheros/atlx/atl1.c b/drivers/net/ethernet/atheros/atlx/atl1.c
index 02aa6fd8ebc2..a9014d7932db 100644
--- a/drivers/net/ethernet/atheros/atlx/atl1.c
+++ b/drivers/net/ethernet/atheros/atlx/atl1.c
@@ -2446,7 +2446,7 @@ static int atl1_rings_clean(struct napi_struct *napi, int budget)
 
 static inline int atl1_sched_rings_clean(struct atl1_adapter* adapter)
 {
-	if (!napi_schedule_prep(&adapter->napi))
+	if (!napi_schedule(&adapter->napi))
 		/* It is possible in case even the RX/TX ints are disabled via IMR
 		 * register the ISR bits are set anyway (but do not produce IRQ).
 		 * To handle such situation the napi functions used to check is
@@ -2454,8 +2454,6 @@ static inline int atl1_sched_rings_clean(struct atl1_adapter* adapter)
 		 */
 		return 0;
 
-	__napi_schedule(&adapter->napi);
-
 	/*
 	 * Disable RX/TX ints via IMR register if it is
 	 * allowed. NAPI handler must reenable them in same
diff --git a/drivers/net/ethernet/toshiba/tc35815.c b/drivers/net/ethernet/toshiba/tc35815.c
index 14cf6ecf6d0d..a8b8a0e13f9a 100644
--- a/drivers/net/ethernet/toshiba/tc35815.c
+++ b/drivers/net/ethernet/toshiba/tc35815.c
@@ -1436,9 +1436,7 @@ static irqreturn_t tc35815_interrupt(int irq, void *dev_id)
 	if (!(dmactl & DMA_IntMask)) {
 		/* disable interrupts */
 		tc_writel(dmactl | DMA_IntMask, &tr->DMA_Ctl);
-		if (napi_schedule_prep(&lp->napi))
-			__napi_schedule(&lp->napi);
-		else {
+		if (!napi_schedule(&lp->napi)) {
 			printk(KERN_ERR "%s: interrupt taken in poll\n",
 			       dev->name);
 			BUG();
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 23b5a0adcbd6..146bc7bd14fb 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1660,9 +1660,7 @@ irqreturn_t iwl_pcie_irq_rx_msix_handler(int irq, void *dev_id)
 	IWL_DEBUG_ISR(trans, "[%d] Got interrupt\n", entry->entry);
 
 	local_bh_disable();
-	if (napi_schedule_prep(&rxq->napi))
-		__napi_schedule(&rxq->napi);
-	else
+	if (!napi_schedule(&rxq->napi))
 		iwl_pcie_clear_irq(trans, entry->entry);
 	local_bh_enable();
 
-- 
2.40.1

