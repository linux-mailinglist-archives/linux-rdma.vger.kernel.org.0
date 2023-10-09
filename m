Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D7D7BE038
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Oct 2023 15:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377251AbjJINiL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Oct 2023 09:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377246AbjJINiJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Oct 2023 09:38:09 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170839C;
        Mon,  9 Oct 2023 06:38:08 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40651a726acso41855875e9.1;
        Mon, 09 Oct 2023 06:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696858686; x=1697463486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m01pIjBrpccmB+UTqpe3DsPW+GxNRr1hhJrCHjJ41h8=;
        b=avFAsFmbgFveTTnrfgsi+nEck/8J10PL0pfRcwQnG3DVD2kiO/EKenWA3UBdf2hBfx
         vPKxN6jBKvYpcj5aLMag18P7+bpVKzhhaOD1kaESStgIn/zCBkX7xlTWeRzp/WlE7Fux
         sTIIyyROpdWMkH2WaaoW7HyS2uoZnrVst+MT8VJ+B+sctuA6vZGsLzMBkWcDeGQ2rlOx
         1X/11N72qwzjww6x5EtwKHdoqxjwhd2w4QmNTkmrmYsgAHl0cBuUpA+H61oI9Xyp9crN
         h+UD94M6tGqvPzXD5JNspTA1b0AE2uhWQc7hysmN/wl5Nuj04OrGuegGGo38oy1/Bx3g
         16ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696858686; x=1697463486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m01pIjBrpccmB+UTqpe3DsPW+GxNRr1hhJrCHjJ41h8=;
        b=l39lZ+qih8iH0N7zrn9Vr5Udzt4u+O5xVXrixzSHTRWF3c+RUZZ6N2RvW90HVJ/R2o
         XN1gDE+rfoYf2zWHJCbTNy6zuj09iKrj8ADyhG2U3AWn8FoOK2MfqMbkEDX6uZuzelgi
         r4SqMdsfCplqewaXpk1i6Q/qmgXM+sO4WqemzGJ1ey8oF/qaSsNeJ/nITahyrqqgdh9I
         CiIF85yndIhphn5sXgsOddhNZHQmGi3YRn5Il9JDpNo7R0O1ZvFS0/PbvQVPzRVBuDaq
         gEFr+u0wAGn3mQI42PTNZMjX03mHjUDRovxu6CU32VO1Yaa5+/5ZpmaRJkilgraTtwRq
         1+rA==
X-Gm-Message-State: AOJu0YyHQrf0ssQfT0zpdLUnHOwk8FKdOh2tnfcUsY23B7uygyAB2eJf
        6sPiIaTXvGEgQrsKAW2Jogc=
X-Google-Smtp-Source: AGHT+IEMX7bz877y1sqkSBBwiuVDPwmUPP6Boy0DbKerTwIWpVX1/W8TSbdVp2MIATN2+AWYZ0P7bg==
X-Received: by 2002:a05:6000:128a:b0:31a:d9bc:47a2 with SMTP id f10-20020a056000128a00b0031ad9bc47a2mr15005335wrx.53.1696858686330;
        Mon, 09 Oct 2023 06:38:06 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id t4-20020a0560001a4400b0032763287473sm9746160wry.75.2023.10.09.06.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 06:38:06 -0700 (PDT)
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
Subject: [net-next v3 2/5] netdev: make napi_schedule return bool on NAPI successful schedule
Date:   Mon,  9 Oct 2023 15:37:51 +0200
Message-Id: <20231009133754.9834-2-ansuelsmth@gmail.com>
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

Change napi_schedule to return a bool on NAPI successful schedule.
This might be useful for some driver to do additional steps after a
NAPI has been scheduled.

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
Changes v2:
- Add Suggested-by tag
- Add Reviewed-by tag
---
 include/linux/netdevice.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 7e520c14eb8c..2bead8e2a14d 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -490,11 +490,18 @@ bool napi_schedule_prep(struct napi_struct *n);
  *
  * Schedule NAPI poll routine to be called if it is not already
  * running.
+ * Return true if we schedule a NAPI or false if not.
+ * Refer to napi_schedule_prep() for additional reason on why
+ * a NAPI might not be scheduled.
  */
-static inline void napi_schedule(struct napi_struct *n)
+static inline bool napi_schedule(struct napi_struct *n)
 {
-	if (napi_schedule_prep(n))
+	if (napi_schedule_prep(n)) {
 		__napi_schedule(n);
+		return true;
+	}
+
+	return false;
 }
 
 /**
-- 
2.40.1

