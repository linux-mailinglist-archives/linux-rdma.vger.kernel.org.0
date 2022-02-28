Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABFB4C71FE
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Feb 2022 17:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbiB1QzF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Feb 2022 11:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238046AbiB1QzD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Feb 2022 11:55:03 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FB127B29;
        Mon, 28 Feb 2022 08:54:24 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id w3so18463613edu.8;
        Mon, 28 Feb 2022 08:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C5YgVD22pchSFr4n2QRFausc1ftChAmgohwP8Wg5Uus=;
        b=A/mk/cfu3W4LvbXsuH6OPqnixZcNLGsp8U+j1ppeX3CDyeeLa2XWuhr6hjGduM1c5w
         ZhQc5XHsPXylQSYkVQU1+HG79BlfZc+9ol2776y8YGlVlTN/NH7q5QCUSlZ2v5W+lJDs
         OiQciIn5M5RbGYS14MbyDtCj9+O1JoVJVW/2isYYMWom3fopfilIUMED8qxdVMRYTr2I
         v0gdbOjShBRyZDVnm8AQhLS6NqG/fj18CL71AcF3qdrdWuj8UGwW0jdkOSlZq1PCnz5g
         hPXsumBTHKfcV0VeFdjXFeSr7P3CbmOtQY8mI8gCWncanuQ2klpe8eDRWYwydT79gvVd
         sWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C5YgVD22pchSFr4n2QRFausc1ftChAmgohwP8Wg5Uus=;
        b=rO/0GXinbyGnK9bCcvsInGFK7yhvmh2OTfobC4bpBALcswrZ1jEjo9zpLEL+Ggej2B
         CuYPUgIWkV2W/XZ6e68zirEwgF3kdytHKpclp7jJA8Jbw/EU37liyygymUaSwtfy6JTJ
         ocnxQogcPdGhF45T6252QWBUQREXIjGA+DlZe3m/LGNkzzLSK79enr8j6SH/VTJ4o5Ah
         nOpxVc9zSnkkljywYgqhFC6y/FqsyzQC0eJNyDEe8Xa3X0X9q6/faT3MFyWXRXtHP1m7
         uCRfrNcVzhNDooJ0p91AIiZgl3Dz94CT/mgWI8Kqm0RpfzD04mDigYef6UteXEZ6di4Z
         yp6g==
X-Gm-Message-State: AOAM5310MdDvqvlnglDwb+muTcZMYizjn/7+baacUIibr+Jv8tk8Fkyf
        pgEnCCF7erFCk1V3UcS5mjOikJkdatloWw==
X-Google-Smtp-Source: ABdhPJyWnlNroDlH6W2v/Ul8UrWRwLdlx3x+BhRQ+L+RMVNfehHAWa76uj/X4qVGS/Y11f3x+2qZBg==
X-Received: by 2002:a05:6402:4491:b0:413:162a:fc85 with SMTP id er17-20020a056402449100b00413162afc85mr20419425edb.115.1646067262926;
        Mon, 28 Feb 2022 08:54:22 -0800 (PST)
Received: from nlaptop.localdomain (ptr-dtfv0poj8u7zblqwbt6.18120a2.ip6.access.telenet.be. [2a02:1811:cc83:eef0:f2b6:6987:9238:41ca])
        by smtp.gmail.com with ESMTPSA id ju22-20020a17090798b600b006ce70fa8e4fsm4495828ejc.187.2022.02.28.08.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 08:54:22 -0800 (PST)
From:   Niels Dossche <dossche.niels@gmail.com>
To:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Niels Dossche <dossche.niels@gmail.com>
Subject: [PATCH] IB/rdmavt: add lock to call to rvt_error_qp to prevent a race condition
Date:   Mon, 28 Feb 2022 17:53:30 +0100
Message-Id: <20220228165330.41546-1-dossche.niels@gmail.com>
X-Mailer: git-send-email 2.35.1
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

The documentation of the function rvt_error_qp says both r_lock and
s_lock need to be held when calling that function.
It also asserts using lockdep that both of those locks are held.
However, the commit I referenced in Fixes accidentally makes the call
to rvt_error_qp in rvt_ruc_loopback no longer covered by r_lock.
This results in the lockdep assertion failing and also possibly in a
race condition.

Fixes: d757c60eca9b ("IB/rdmavt: Fix concurrency panics in QP post_send and modify to error")
Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
---
 drivers/infiniband/sw/rdmavt/qp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index ae50b56e8913..8ef112f883a7 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -3190,7 +3190,11 @@ void rvt_ruc_loopback(struct rvt_qp *sqp)
 	spin_lock_irqsave(&sqp->s_lock, flags);
 	rvt_send_complete(sqp, wqe, send_status);
 	if (sqp->ibqp.qp_type == IB_QPT_RC) {
-		int lastwqe = rvt_error_qp(sqp, IB_WC_WR_FLUSH_ERR);
+		int lastwqe;
+
+		spin_lock(&sqp->r_lock);
+		lastwqe = rvt_error_qp(sqp, IB_WC_WR_FLUSH_ERR);
+		spin_unlock(&sqp->r_lock);
 
 		sqp->s_flags &= ~RVT_S_BUSY;
 		spin_unlock_irqrestore(&sqp->s_lock, flags);
-- 
2.35.1

