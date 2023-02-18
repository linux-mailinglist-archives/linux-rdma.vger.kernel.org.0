Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7E169BB7F
	for <lists+linux-rdma@lfdr.de>; Sat, 18 Feb 2023 19:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjBRS5J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 18 Feb 2023 13:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjBRS5J (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 18 Feb 2023 13:57:09 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D737514481
        for <linux-rdma@vger.kernel.org>; Sat, 18 Feb 2023 10:57:07 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id w9-20020a17090a028900b00236679bc70cso1970628pja.4
        for <linux-rdma@vger.kernel.org>; Sat, 18 Feb 2023 10:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=khZrsJSUbGfXiIFHZOzdW4XxaJRpRDKuFefHfpZk7VQ=;
        b=U6L3h3+huPvbAl1pYzB7644CU3KslDuSDX/rnUVdVSE8EO/jCl8KSq+HcTUmNsUE+l
         MWVVQtZ3n5ZeIMx6Q3sC7M3riG3dy2sD18l8bUQ1a0sb5qb7hU3bBz+hKrcrS0eE2KKL
         vOPUl845OwdVRpTXc9K7AP2A5q5DeYBvq2lts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=khZrsJSUbGfXiIFHZOzdW4XxaJRpRDKuFefHfpZk7VQ=;
        b=GUYOSxbtLJEJBJyuZu+wkeu7JOQlKAQdmIlFGUiay/2r0X/maa8M4vnJ4YavzoV4eL
         PD8j1t9UoosV7A0uz8tXmKPN05dgU9k0N/W/gREdstp8BqHrEgqNs7jLiBwJS2/dtcxd
         sCIftmsbpTcRgGzSASMqsY7Fm2Hc0TVMkCrgsSbjCptHbM20EK7ghLoBtfJohmU4ULhR
         ueDMQM7O51dNs3b6rZDU5hdESEaMXcH/B3mVuu1NEFeXPfHQaHIpVephIfhzsV2aITkW
         Z2f/4ef97565bfY2hVP5p1SJdRW9ulzZD70ZfeKdRhTgRZRO7hUDXE8nReKWTQ3ujaqN
         YVxQ==
X-Gm-Message-State: AO0yUKUbkEVMe+ZDwc6RMjSeaJqahLTB4YCJJSLh5HEwGbfFn+pWfyp4
        rx3zTPI+z/2RwP3H1u7Rxw6Zfw==
X-Google-Smtp-Source: AK7set95Ml42LR0aoYZ5jPoLyq1v3GWS3Edju77aaI6PR7qVPaby8Nb58nQ1Fv3u+8cYbCr1oIxDJg==
X-Received: by 2002:a17:90b:314b:b0:234:68d:b8ea with SMTP id ip11-20020a17090b314b00b00234068db8eamr1256773pjb.39.1676746627369;
        Sat, 18 Feb 2023 10:57:07 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t13-20020a63b70d000000b004fd0feae70fsm2858542pgf.92.2023.02.18.10.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 10:57:06 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Kees Cook <keescook@chromium.org>, Zhang Yi <yizhan@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] IB/rdmavt: Fix target union member for rvt_post_one_wr()
Date:   Sat, 18 Feb 2023 10:57:05 -0800
Message-Id: <20230218185701.never.779-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1516; h=from:subject:message-id; bh=/HzWdAZi2mss32NkJTT96+rWSz+FBTRF7/tT4SPTBks=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBj8R+ARt1rH8yQPogZEw9kSqe4GVamEa1N1HdO1wYS 1JDcxkeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY/EfgAAKCRCJcvTf3G3AJoPNEA Cjcju+UTd4rwsspQF9f1FONGLufsnWQl92vAKO2OOksXhZcW1WDdhCoDrJdWXaHw5wgQOSIMpspIUd ZksDF5Jp3W6IfXPM/bN7slCBF3BUViF38ztE+3jKL4kSKQ887pa29Yc1J8diepEAOGqgIA39dZkCiU nOeB/ZMcnDEoX/I60yQ3OmdNdnsTAmfu6J8lpO9pKBh4MVjwcYI9S0IB8NPEUdW0MzO02N7qE7nV+V 0er2MeeJHAcXxIUZ991WMIpd47H+gc24LT2LdagmoJYsoegbKgnC1kZuguQtVtb0Isjy59nfuTn4ou os2K04AXXrCdSrQ6YthE0hn51kH/Gww1NR7dcuqNfFudn9XlaxEg+rmLvdwFMfcGgsxf2E9t0sWqty LiUUfGP7N/hEGIOXz5r6/oAUztcDqTDGuSftulNTwrMsl8diNNfwiLmDSD5x0yL5oeyjY1sQXkjMIV KuLbgKnHjFC8SibUkJjZkPiMIVnJ7rONXhholiK8QNj6iUlzwTa1wMlJjF92Lk8YMSmI0fsmQASd77 fKwzOGpFK65V7IkbD+GR5eRkkpSimTgBAS11oYySch5Rjp1RdDr9m88F3LHIAhzOYkb4rRK5skmHVc Kh78SYU1rT0z7iUppS95kwWZapnmpmA7Nog+eysw8adTM+dGGrJdQ7W682QQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The "cplen" result used by the memcpy() into struct rvt_swqe "wqe" may
be sized to 80 for struct rvt_ud_wr (which is member "ud_wr", not "wr"
which is only 40 bytes in size). Change the destination union member so
the compiler can use the correct bounds check.

struct rvt_swqe {
        union {
                struct ib_send_wr wr;   /* don't use wr.sg_list */
                struct rvt_ud_wr ud_wr;
		...
	};
	...
};

Silences false positive memcpy() run-time warning:

  memcpy: detected field-spanning write (size 80) of single field "&wqe->wr" at drivers/infiniband/sw/rdmavt/qp.c:2043 (size 40)

Reported-by: Zhang Yi <yizhan@redhat.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216561
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/infiniband/sw/rdmavt/qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index 3acab569fbb9..3f707e1fa517 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -2040,7 +2040,7 @@ static int rvt_post_one_wr(struct rvt_qp *qp,
 	wqe = rvt_get_swqe_ptr(qp, qp->s_head);
 
 	/* cplen has length from above */
-	memcpy(&wqe->wr, wr, cplen);
+	memcpy(&wqe->ud_wr, wr, cplen);
 
 	wqe->length = 0;
 	j = 0;
-- 
2.34.1

