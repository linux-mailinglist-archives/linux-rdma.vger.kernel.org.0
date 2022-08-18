Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AEA5981B2
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Aug 2022 12:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbiHRKyB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Aug 2022 06:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238659AbiHRKyA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 Aug 2022 06:54:00 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B086A642FB
        for <linux-rdma@vger.kernel.org>; Thu, 18 Aug 2022 03:53:59 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso721098wmb.2
        for <linux-rdma@vger.kernel.org>; Thu, 18 Aug 2022 03:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=OsmktRt7vr5Z0MzfjZFKBnyCNRYzs2uMPc3Rn0B92wY=;
        b=I3zegDH8Ff4UwUn2xOKtiMCKosjRSSW6xet72nuXANbm+lcFunGvg2U6D9bng7IIka
         uoOfeqJsgfFJ54Iguwjfrbe7KO8b+9iMMw0fXSZVQGRXwVH7q4rRPWE7m3DLTJcDS+xd
         wWTwT/9lrrJ4ISLDSmKJ6zdWfxyD5j9zbmrxVU0vETtISDeVj0hjIb5fBhRatLdEZdLq
         RoGFlxbzG9pbd/80fdmRoV9Nm+CETze1ksD22kFANVEPn39CuJazXeEdccoSBRPvMeap
         qG37Q5pHOTYrnA2HM3zfYs+q/jBRmrlhHDOtaSCddAPrRzoO0BTwD4gg50WkI4gWCJsR
         3saw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=OsmktRt7vr5Z0MzfjZFKBnyCNRYzs2uMPc3Rn0B92wY=;
        b=cpXj6wa9g5n/77uzedGf+TCraRhxBTe15S/zc1TflruBwixalOXXTVJ7eJCof6bEwG
         +JIQto21IDDYtV6IMru+/CLsMs3jBvMAmYQfLJshKSkOFH+nP3tq8zkydSIHIEcoWhYa
         HlmLnpx+wRISoGaJA++VRqCENSLluBG2Kt+3E+U/Q6bhhee++SMHLQwgSi0dC+Qm6Cmv
         gAdiMjCKS52Nx1Mg/akSBb/AlJ/XzRCO0KRx9kPAD6gNu5q7APog3tqOJxQ1WB1DtnxH
         o3x9YVg86er5DyLzWglX4t4y65kPPtmNMboKp7bRwTS+8exlvxyDUJ3z8EPYokYjNltz
         +pZw==
X-Gm-Message-State: ACgBeo0CkEQ0lnULVUou09rhpSD6LSDYDyMppeXYFTvUumpEUhDv52Hd
        tW3JTb+UtYF8S7LYG8zaQljFDhQhNlEyaw==
X-Google-Smtp-Source: AA6agR7OLPJTMS8oMV7XHoPoKjSjbt7zhI1Ns37b2fTCdCvKZgvtO9GPtLjyGVxNk7T+tNiHZsAf9g==
X-Received: by 2002:a05:600c:34c1:b0:3a5:e065:9b46 with SMTP id d1-20020a05600c34c100b003a5e0659b46mr1535800wmq.30.1660820038290;
        Thu, 18 Aug 2022 03:53:58 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id n3-20020a05600c3b8300b003a54fffa809sm1920751wms.17.2022.08.18.03.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 03:53:57 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     leon@kernel.org, jgg@ziepe.ca, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, Aleksei Marov <aleksei.marov@ionos.com>
Subject: [PATCH for-next 1/3] RDMA/rtrs-clt: Output sg index when warning on
Date:   Thu, 18 Aug 2022 12:53:53 +0200
Message-Id: <20220818105355.110344-2-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220818105355.110344-1-haris.iqbal@ionos.com>
References: <20220818105355.110344-1-haris.iqbal@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@ionos.com>

Output the sg index, so it's a bit easier for debug.

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Aleksei Marov <aleksei.marov@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index 60fa0b0160f4..ed324b47d93a 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -175,7 +175,7 @@ int rtrs_iu_post_rdma_write_imm(struct rtrs_con *con, struct rtrs_iu *iu,
 	 * length error
 	 */
 	for (i = 0; i < num_sge; i++)
-		if (WARN_ON(sge[i].length == 0))
+		if (WARN_ONCE(sge[i].length == 0, "sg %d is zero length\n", i))
 			return -EINVAL;
 
 	return rtrs_post_send(con->qp, head, &wr.wr, tail);
-- 
2.25.1

