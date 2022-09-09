Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD875B2C1F
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Sep 2022 04:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiIICaC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Sep 2022 22:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiIICaB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Sep 2022 22:30:01 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB34D3135A;
        Thu,  8 Sep 2022 19:30:00 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x1so503857plv.5;
        Thu, 08 Sep 2022 19:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=moNG8kswXbdKQJB3vW/4tDOWs8Xhj1MAbDe3Hb6PlTY=;
        b=DXfPCBdcW1G/kjAPKtaOom2rR+NU837/Q4ySM7Kwk4rarWQP1Lwxis95jlGQ4u4mwa
         FXWFvomxoPyQaEHueUMKTSRN1WQ7j8+Q8/LB2VaAFnUSUOZ47oXoSo/KIZ1OURcpl2tk
         D2F7vxWAe1u6gbY936Jehb8u/2u0w/KQourXuRu9gSFh810fw97MmLHUZClW3laqLhI0
         ei1YJewmQiG9lKHUtyXMUnOLz/2YfrGqGC/OK7IRgZkLNSa/khVoy4gAsxzGmbHEri6N
         CMKivFF9Fd5GWsASf1DX1Pl6XmybzYjXFWNZiJqR+yj1EwE4sGJre5a0UCyqIdIDgETm
         Cvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=moNG8kswXbdKQJB3vW/4tDOWs8Xhj1MAbDe3Hb6PlTY=;
        b=SnbrDzBMCkDOPYCYXPnuqhOqampAifVWHS6blEqnWXbBgYX+h+YibGzm8jlWlLwDKN
         seCjL8uQcQCm/H/X+cENLuvAFWqyi5VJOVQCq2G1bQz12rQQgHSFHsMidGRKJRW5pwjI
         4roFWPBZh5xEQHz0Hp6hghHtzm3JNEoVz3v+tCVtvZGXrHPNKfCO2HokfOskXPctTXz3
         FsjUf/aPl2eNyCmitOX8D8g9DIeSOa8WUK7Y0cy/JZUJ5M920cg1WEChbDlvh8dSZGLM
         6bA74uYSp9PDgIySgZWjgH3E9U8A5RAlJZPr7DaXSgkFLVBWh+JOsGcECa2EuuFI5DOs
         qPyw==
X-Gm-Message-State: ACgBeo2pieyXL8X7PRPxH0k7EeciLxVpeefRSqt9VcGusHx31+ii6FVE
        2hyshL9/0tDMX7JRzCbGLdn8bXJ7tRK8rz83p1g=
X-Google-Smtp-Source: AA6agR4yHdfyXzeoQEJ8k4CJWkE7zOLRliuw6BpjSaaL//I5Jn5qHDH7A+UBNKOsqCF45CQ4pLbwKw==
X-Received: by 2002:a17:90b:1b08:b0:1f5:b65:9654 with SMTP id nu8-20020a17090b1b0800b001f50b659654mr7295690pjb.77.1662690600174;
        Thu, 08 Sep 2022 19:30:00 -0700 (PDT)
Received: from hbh25y.. ([129.227.150.140])
        by smtp.gmail.com with ESMTPSA id 190-20020a6204c7000000b0053e2b61b714sm325383pfe.114.2022.09.08.19.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 19:29:59 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     bvanassche@acm.org, jgg@ziepe.ca, leon@kernel.org,
        gustavoars@kernel.org
Cc:     linux-rdma@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] infiniband: ulp: srpt: Use flex array destination for memcpy()
Date:   Fri,  9 Sep 2022 10:29:43 +0800
Message-Id: <20220909022943.8896-1-hbh25y@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In preparation for FORTIFY_SOURCE performing run-time destination buffer
bounds checking for memcpy(), specify the destination output buffer
explicitly, instead of asking memcpy() to write past the end of what looked
like a fixed-size object.

Notice that srp_rsp[] is a pointer to a structure that contains
flexible-array member data[]:

struct srp_rsp {
	...
	__be32	sense_data_len;
	__be32	resp_data_len;
	u8	data[];
};

link: https://github.com/KSPP/linux/issues/201
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 21cbe30d526f..8c29e14150d3 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -1421,7 +1421,7 @@ static int srpt_build_cmd_rsp(struct srpt_rdma_ch *ch,
 
 		srp_rsp->flags |= SRP_RSP_FLAG_SNSVALID;
 		srp_rsp->sense_data_len = cpu_to_be32(sense_data_len);
-		memcpy(srp_rsp + 1, sense_data, sense_data_len);
+		memcpy(srp_rsp->data, sense_data, sense_data_len);
 	}
 
 	return sizeof(*srp_rsp) + sense_data_len;
-- 
2.34.1

