Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462D87BE041
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Oct 2023 15:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377275AbjJINiT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Oct 2023 09:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377271AbjJINiQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Oct 2023 09:38:16 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263C691;
        Mon,  9 Oct 2023 06:38:14 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-327be5fe4beso4151499f8f.3;
        Mon, 09 Oct 2023 06:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696858692; x=1697463492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EzAWHH01VVS9IgkvFldWVDddj9E+l4PxhyRk8MwG584=;
        b=lf07PBTaNjgbPWnwbf+7VxBfz4iQHTwdK8TY/IX7/X0+iSmBUoOAS8xFK8yHVWmYJc
         R0tNyri7s7mMzGA6du5w/E14VzGYRNr1EPO++nF5Gu+yCSlALNFi969WzuFj+U60f7G1
         FMWnCD/w6Ea2zqYsHdgSxefyq3VjzzmmrjEmv5rgGlAoFTnqYugiG/Sa54Ms+4XmY6B7
         AXLZOl9UmWcJ80ha+0SWryR2AdD7A87Oy07EB4odcdsJNcYTqeQdAaBUw2BY+xUp2Ct6
         cU34BWfDpEwXt6nFuvPB0P7uUuhkGC/urPf4YmGyAoS2iuKEM32lMT3g1txZvqn8t/D8
         Fs2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696858692; x=1697463492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EzAWHH01VVS9IgkvFldWVDddj9E+l4PxhyRk8MwG584=;
        b=xK2sr0GbEgenE7xLt1saK5grNhuW16FWyAcgbYa/yOTOfBFSI9I01Vhsaw2I1wdjyj
         eh8XcVg8du9ye4zP09zDLYAVWYOQFY5HLXDlHIoX1ByVWglO7Mt2NilTvDjPtuHUkKkj
         /6W1N7fRJAxKYLP7qcblz+/Q7tvsRHUX7puDH5C7QK3QVgQIyTcCQwd35IRAhH7D/rxP
         RmHI5JS549/096nDtTeX/bCNU02fNoLfjYA3Weq3dq9fD/amGqkGoXo6x86Mi8bmwM4x
         B6l73MTD4bL/cveE8ep0I3Ww6Li/apMFIwIMVihCotryfCfshfJCRAayZYytYy2nhJpk
         u8+g==
X-Gm-Message-State: AOJu0Yw3nU3Ei/UMFFyAJW41HrfMrLPx/H45yMM4XBJVRskJ77ehXRvn
        eHXGBYb8P+/NFCO73l2SK3o=
X-Google-Smtp-Source: AGHT+IHsAsFvK5zcfvpEHNpBjlrUZf2mmc5SciLA+pPQWufHQKhdvJk6OO5q7vOl9k3p/vj4f/tuWw==
X-Received: by 2002:adf:e9d0:0:b0:31f:f432:b541 with SMTP id l16-20020adfe9d0000000b0031ff432b541mr13440190wrn.69.1696858692458;
        Mon, 09 Oct 2023 06:38:12 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id t4-20020a0560001a4400b0032763287473sm9746160wry.75.2023.10.09.06.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 06:38:11 -0700 (PDT)
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
        Alex Elder <elder@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
        Bailey Forrest <bcf@google.com>,
        Junfeng Guo <junfeng.guo@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ziwei Xiao <ziweixiao@google.com>,
        Rushil Gupta <rushilg@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Yuri Karpov <YKarpov@ispras.ru>, Andrew Lunn <andrew@lunn.ch>,
        Zheng Zengkai <zhengzengkai@huawei.com>,
        Dawei Li <set_pte_at@outlook.com>,
        Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
        Benjamin Berg <benjamin.berg@intel.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: [net-next v3 4/5] net: tc35815: rework network interface interrupt logic
Date:   Mon,  9 Oct 2023 15:37:53 +0200
Message-Id: <20231009133754.9834-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231009133754.9834-1-ansuelsmth@gmail.com>
References: <20231009133754.9834-1-ansuelsmth@gmail.com>
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

Rework network interface logic. Before this change, the code flow was:
1. Disable interrupt
2. Try to schedule a NAPI
3. Check if it was possible (NAPI is not already scheduled)
4. emit BUG() if we receive interrupt while a NAPI is scheduled

If some application busy poll or set gro_flush_timeout low enough, it's
possible to reach the BUG() condition. Given that the condition may
happen and it wouldn't be a bug, rework the logic to permit such case
and prevent stall with interrupt never enabled again.

Disable the interrupt only if the NAPI can be scheduled (aka it's not
already scheduled) and drop the printk and BUG() call. With these
change, in the event of a NAPI already scheduled, the interrupt is
simply ignored with nothing done.

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/ethernet/toshiba/tc35815.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/toshiba/tc35815.c b/drivers/net/ethernet/toshiba/tc35815.c
index 14cf6ecf6d0d..6e3758dfbdbd 100644
--- a/drivers/net/ethernet/toshiba/tc35815.c
+++ b/drivers/net/ethernet/toshiba/tc35815.c
@@ -1434,14 +1434,10 @@ static irqreturn_t tc35815_interrupt(int irq, void *dev_id)
 	u32 dmactl = tc_readl(&tr->DMA_Ctl);
 
 	if (!(dmactl & DMA_IntMask)) {
-		/* disable interrupts */
-		tc_writel(dmactl | DMA_IntMask, &tr->DMA_Ctl);
-		if (napi_schedule_prep(&lp->napi))
+		if (napi_schedule_prep(&lp->napi)) {
+			/* disable interrupts */
+			tc_writel(dmactl | DMA_IntMask, &tr->DMA_Ctl);
 			__napi_schedule(&lp->napi);
-		else {
-			printk(KERN_ERR "%s: interrupt taken in poll\n",
-			       dev->name);
-			BUG();
 		}
 		(void)tc_readl(&tr->Int_Src);	/* flush */
 		return IRQ_HANDLED;
-- 
2.40.1

