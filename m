Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290A6615332
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Nov 2022 21:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiKAUYk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Nov 2022 16:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiKAUYH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Nov 2022 16:24:07 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F911EEC4
        for <linux-rdma@vger.kernel.org>; Tue,  1 Nov 2022 13:24:01 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id v8-20020a4ab688000000b00486ac81143fso2217195ooo.1
        for <linux-rdma@vger.kernel.org>; Tue, 01 Nov 2022 13:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoJjhKZrbgkuVHlvtoanzHI8drWJoSVBL5ZAF5DXUUE=;
        b=mON0BaqggleDcSx7LO0ANLbCHUNXUMmLa8kdwjnH3IKKIoJxFWSElCkLke525MxAXN
         IjYrE3EHmGDy3onk+8A82I0uMWt3BpXUuSqWUmmy97ywkLfpJ5j1qniDbnCs6f/w+/30
         Wdlun5EM+b6ItgnzLQdxti3rhp709CUt2rgTpZn5DPokrpmjhGOjgoST8Kt8f1Vxnxe3
         fYxA8IRgkf0yhVgbT7Vi5romgbpNC7px3dwfCUA84RZlyPuSLcApdxqVfbixM1mY3qWF
         Il1kDKxYh3PNvtXpKuv9bsSLtnJ9vtNzKxhcoTDDVeZTOre1FQPeBmyVOmW00XQ4hoMd
         HS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eoJjhKZrbgkuVHlvtoanzHI8drWJoSVBL5ZAF5DXUUE=;
        b=y/OTuIDv5yI08liBEJ7Emg3XgG7ZsMx6JhnP23oQ1EOm0t3r8IQ1h4qjlHdL3YZWhp
         L4+n9I8/RsGhIA3ZIoRf0lGNdDuepBWG4WVbFOxrH1Ru/2F7u8/50srPhc48ti4OPCTh
         b+Bf5ASqaYjyuFYgkRr/5bDJFZjxNVhbxHD9h8ZvXabtVw0exbRlZaolRAkZjzbzqlfy
         +7/O/o/heEzrsiR5/ECx9bZjqHxkQBNd0a5QErUSJZ9F+uOZ4purY6oa4Cn++6+STq6N
         t1ZCENZg0AU0YtH3FPJTQhW9eHQIzQyPrawml/s2z7gIy8yQ/TPEqxAKlp+NXOUvombV
         fwpg==
X-Gm-Message-State: ACrzQf0GKOL7ekad2hxhNh+Q3lRZw7DsMZyGUP2HtVqaz0s3EOJ26i92
        Db1FWlRQCJ9RsIFD3OlUFGc=
X-Google-Smtp-Source: AMsMyM6wMU69gsgrif/pC0DJWKwKLlDO0buE2mfdoh/8J5oelDGuYkBPipapFKIlf0cvtl0ItdA6pA==
X-Received: by 2002:a4a:c20e:0:b0:476:59ad:b02b with SMTP id z14-20020a4ac20e000000b0047659adb02bmr8754830oop.65.1667334241222;
        Tue, 01 Nov 2022 13:24:01 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-e052-4710-92ba-8142.res6.spectrum.com. [2603:8081:140c:1a00:e052:4710:92ba:8142])
        by smtp.googlemail.com with ESMTPSA id d22-20020a056830045600b0066210467fb1sm4337493otc.41.2022.11.01.13.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:24:00 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     leon@kernel.org, jgg@nvidia.com, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 13/16] RDMA/rxe: Replace pr_xxx by rxe_dbg_qp in rxe_task.c
Date:   Tue,  1 Nov 2022 15:22:38 -0500
Message-Id: <20221101202238.32836-14-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221101202238.32836-1-rpearsonhpe@gmail.com>
References: <20221101202238.32836-1-rpearsonhpe@gmail.com>
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

Replace calls to pr_err/warn() in rxe_task.c with rxe_dbg_qp().

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

