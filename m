Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A29B6185E2
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Nov 2022 18:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiKCRLu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Nov 2022 13:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbiKCRKt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Nov 2022 13:10:49 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8C42DC9
        for <linux-rdma@vger.kernel.org>; Thu,  3 Nov 2022 10:10:48 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id a7-20020a056830008700b0066c82848060so1187288oto.4
        for <linux-rdma@vger.kernel.org>; Thu, 03 Nov 2022 10:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqJLki4XKPQ8vhzosGcdUtUe/+siVxVWCZGpW6KdDkg=;
        b=G0uHUy1xM3Apkm0UJfcmaeQpV+KyjWxeMeKILD7YVzrdnmGg4fdrM0ySX+CiFfSZ90
         Q3m5FwLcxf7EKS51SKPb4mM6DWrZfK7leLm/HtXNl3K3zllyBLMG2Wd88QWJ+5qhwAyZ
         3u35r29MkWaNdvSDHCA+vThGeLw5PkAUUcpHkY3H9W/Q+eaMIcJUI3YQEHkT9PqDXMal
         OvKHexwvMM5XZ9Y4JdUSjzC32/hBA9xFXrWnwRI08fHfEsf4bF+MBTDfH/KwxYLDAE0/
         CUNsmQwsl+sIOOHKQG6m8XjjdjXvsawsRZHFYZ4ifZiIUTel3pbHsFT9OegmZufSTHpI
         Z6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqJLki4XKPQ8vhzosGcdUtUe/+siVxVWCZGpW6KdDkg=;
        b=ErweWNSsJiHbdPOm3kfqPB1vxCpRyl3lK1xQe7MbmABWr6Y/RNTL6at3s0waxrCu7l
         3OnbAXJZUPKgb56B3yftDB33ZlhC/8p8Ak59/iY5XUMvI2FjdleAaNQQ8a9t26GoXcGs
         Fa+cx6O/HZfFBaWXV4zPy3/pieJvBDj/qg8dhd+S/pTsktNtaXozCSLpwCqwryIIs6fc
         5BmJscBjnjJE5RDDwofvvpZgGjErIt14btVnzuzAXmWcQW6AWBNrxf40XhBlktCfCdy3
         xvv6xUCuNGT/Qi5i4aLtKD+UWeA9mqE3SqRJTTLtkHcGdqftV86UixmdK+un4AJvDkqB
         OWDg==
X-Gm-Message-State: ACrzQf2VCOUnsTuqyfZK+RNhZTO8FDyB1hsLoscD5G7TSzVWuNnKkvGN
        W/PImqRHySbslk1HmL8A/ARQU/ZT4C4=
X-Google-Smtp-Source: AMsMyM7hnHTYkXmgFRvEyA1Dcqt2hakK8Z56r7j52/WVi+olJhXbi69CCKvtU0EcsHZdDm3j/G8h5A==
X-Received: by 2002:a05:6830:2906:b0:655:d5b5:cb53 with SMTP id z6-20020a056830290600b00655d5b5cb53mr14399706otu.261.1667495447824;
        Thu, 03 Nov 2022 10:10:47 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-b254-769c-82c0-77a4.res6.spectrum.com. [2603:8081:140c:1a00:b254:769c:82c0:77a4])
        by smtp.googlemail.com with ESMTPSA id m1-20020a056870a10100b0012b298699dbsm624304oae.1.2022.11.03.10.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:10:47 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     leon@kernel.org, jgg@nvidia.com, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 13/16] RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_task.c
Date:   Thu,  3 Nov 2022 12:10:11 -0500
Message-Id: <20221103171013.20659-14-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103171013.20659-1-rpearsonhpe@gmail.com>
References: <20221103171013.20659-1-rpearsonhpe@gmail.com>
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

Replace calls to pr_xxx() in rxe_task.c with rxe_dbg_xxx().

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_task.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index 0208d833a41b..60b90e33a884 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -29,6 +29,7 @@ static void do_task(struct tasklet_struct *t)
 	int cont;
 	int ret;
 	struct rxe_task *task = from_tasklet(task, t, tasklet);
+	struct rxe_qp *qp = (struct rxe_qp *)task->arg;
 	unsigned int iterations = RXE_MAX_ITERATIONS;
 
 	spin_lock_bh(&task->lock);
@@ -47,7 +48,7 @@ static void do_task(struct tasklet_struct *t)
 
 	default:
 		spin_unlock_bh(&task->lock);
-		pr_warn("%s failed with bad state %d\n", __func__, task->state);
+		rxe_dbg_qp(qp, "failed with bad state %d\n", task->state);
 		return;
 	}
 
@@ -81,8 +82,8 @@ static void do_task(struct tasklet_struct *t)
 			break;
 
 		default:
-			pr_warn("%s failed with bad state %d\n", __func__,
-				task->state);
+			rxe_dbg_qp(qp, "failed with bad state %d\n",
+					task->state);
 		}
 		spin_unlock_bh(&task->lock);
 	} while (cont);
-- 
2.34.1

