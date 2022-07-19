Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7835795CA
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jul 2022 11:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbiGSJJ6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Jul 2022 05:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiGSJJz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Jul 2022 05:09:55 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D014A22B2A;
        Tue, 19 Jul 2022 02:09:54 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id s206so12944546pgs.3;
        Tue, 19 Jul 2022 02:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W/78y/lUmu2l8DVd0s65Tb+6bO2lCJDLr8b5N9WnCPk=;
        b=NOSo6s6HcD2X+Amy5Hic29hq4HRISoPTpzjklUaa2ZED+sMLAfoB/IG7Xez49b/oG7
         YLrTTjWh1lIlKHnvd8puPLgBYxTgNBCrVjGra58Fgk93IRtwIWk6Y7qIGt33Gto91PK0
         QubzyXMtaKByHo2lpsPnlz1lH7HL/zjd/NgBC+/uJm7aDl0U3O4WKrSxwe4ukYj4yBKp
         KkW0ykeR8C+4CL0NR7v4Az6mqgi3B+useOwAemxQtm66qf811Eqql/A/Vm0XTsOfrKGy
         GClSIhtEAkpxdYCQq1Nh53YT6kZTfxfG4o701JBs5wk/wn1ZERar/wGNtDli/iTpnzvr
         zYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W/78y/lUmu2l8DVd0s65Tb+6bO2lCJDLr8b5N9WnCPk=;
        b=oGXGw6XBXRWPGrKeEKKneX5OnBhl7gO0lcKK/p6vUro/EOPWJMFwaatBK6UxMDwlpX
         NmB/puSx0XWPHjVOGRn/h8pY5KWuri+pOzyHykHKnGy72aAKsdnjmOzDz6VqEhnEnIW2
         dEYmo8jcGOlPCPoIWXDfJI7hGAB7S/UHlyvGCKhyU9JU0hesO42IPZp6LWgJ6Bcql6N8
         BewdzC7yTUIUtmYwI6H5P9hJUUbclnKqjCT9K/+M80zHnKLBt8kCpXFTL3volfsGaufh
         ptb1BsOP37o5smJQFpAdD5JQ6G4JjbU14/Gt2DRsH4hfNlOT0WUMgZJmQvcRApd2f3Z+
         nGCg==
X-Gm-Message-State: AJIora9YmeMjgT8JOBiAoK9PAbKHCgB4TkfSxQHlbkD8uxeZNMCKDSKH
        huHcwF2J5fuJFe+Zjnjq9CM=
X-Google-Smtp-Source: AGRyM1svyYXJG/tMPLtWCwhV7g2RI+vojfa+oGLxug1EwQnL3Us6e6D6l3J3cW8V3fb3JNwPzbau3A==
X-Received: by 2002:a62:6545:0:b0:52b:6daa:1540 with SMTP id z66-20020a626545000000b0052b6daa1540mr9989127pfb.29.1658221793995;
        Tue, 19 Jul 2022 02:09:53 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902d88500b00163ffbc4f74sm11071359plz.49.2022.07.19.02.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 02:09:53 -0700 (PDT)
From:   zys.zljxml@gmail.com
To:     bharat@chelsio.com, jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yushan Zhou <katrinzhou@tencent.com>
Subject: [PATCH] RDMA/cxgb4: Cleanup unused assignments
Date:   Tue, 19 Jul 2022 17:09:48 +0800
Message-Id: <20220719090948.612921-1-zys.zljxml@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yushan Zhou <katrinzhou@tencent.com>

The variable err is reassigned before the assigned value works.
Cleanup unused assignments reported by Coverity.

Addresses-Coverity: ("UNUSED_VALUE")
Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
---
 drivers/infiniband/hw/cxgb4/cm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index c16017f6e8db..3462fe991f93 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -1590,7 +1590,6 @@ static int process_mpa_reply(struct c4iw_ep *ep, struct sk_buff *skb)
 					insuff_ird = 1;
 			}
 			if (insuff_ird) {
-				err = -ENOMEM;
 				ep->ird = resp_ord;
 				ep->ord = resp_ird;
 			}
@@ -1655,7 +1654,7 @@ static int process_mpa_reply(struct c4iw_ep *ep, struct sk_buff *skb)
 		attrs.ecode = MPA_NOMATCH_RTR;
 		attrs.next_state = C4IW_QP_STATE_TERMINATE;
 		attrs.send_term = 1;
-		err = c4iw_modify_qp(ep->com.qp->rhp, ep->com.qp,
+		c4iw_modify_qp(ep->com.qp->rhp, ep->com.qp,
 				C4IW_QP_ATTR_NEXT_STATE, &attrs, 1);
 		err = -ENOMEM;
 		disconnect = 1;
@@ -1674,7 +1673,7 @@ static int process_mpa_reply(struct c4iw_ep *ep, struct sk_buff *skb)
 		attrs.ecode = MPA_INSUFF_IRD;
 		attrs.next_state = C4IW_QP_STATE_TERMINATE;
 		attrs.send_term = 1;
-		err = c4iw_modify_qp(ep->com.qp->rhp, ep->com.qp,
+		c4iw_modify_qp(ep->com.qp->rhp, ep->com.qp,
 				C4IW_QP_ATTR_NEXT_STATE, &attrs, 1);
 		err = -ENOMEM;
 		disconnect = 1;
-- 
2.27.0

