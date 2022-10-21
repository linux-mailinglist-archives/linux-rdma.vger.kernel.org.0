Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA407607F71
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Oct 2022 22:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiJUUCz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Oct 2022 16:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiJUUCX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Oct 2022 16:02:23 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16DE2625DF
        for <linux-rdma@vger.kernel.org>; Fri, 21 Oct 2022 13:02:12 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1322d768ba7so4912591fac.5
        for <linux-rdma@vger.kernel.org>; Fri, 21 Oct 2022 13:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rlVoip2hDPGQa9+wV269vJ7C/vC9zRk/r8HX4gvpR+w=;
        b=ff4BbOAjcITZQ4ckiWv0ZCnNUiuUiHBKGy7ol70Iy5usZASm+PCcsG7Jp8xNzaFc53
         rng6Jo8l1EqlPOyQz/U60NqU8RJhabDC0Cq25llxBz32tKKGZwtY7HQRuLef92h8fXih
         UWpKW9VWBZN5y4tPUbeCFoYG0NjQ+MV5u1FfJYrckqMpue5jqfo7DPgKjO/wptJTaNWs
         JRsm0CyH8bPDf8iNm2dJV5pmra+N7BMTreUcFXJPfjlUMVein1uwAK1IMAbDaDaHFUBq
         KAz/ijV3xFV49x75AlzEt2BVCzw50uyDB2UY4so5ZI+9XFkm7S1Kn+OOs6nXW6W2Hi8H
         CQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rlVoip2hDPGQa9+wV269vJ7C/vC9zRk/r8HX4gvpR+w=;
        b=CR/k2JDRhf4bQt9jNVJ2Ivl5N5GYDeukKD1mDkSnrG9Iqnisr7SfLJaWbKf2tOIAsq
         xKjOECU/nr504/b5phMTbJkp6Y54uSf+ufpzKbAzglnamgqhib+8BliWRwbATm98bDqT
         H8PXSS7YJlJz2P40U8jeiUS9klgN/bzWavvOsYSZTtA1rghkzbrIP8QUCfg5XzjVs8AX
         TDrMsIee/Six9pkcur07dEJS0SeFYoMUztz6evxtQNHZgZU3/8ETNc0pZ3u4syCWdxsZ
         ssFjgAVHfI3MEWQuXG39kPXvn/Cw1GVp/D8bqd9j6vOxDh3Fw1aGx17b5K+e/O1ulnfL
         VN5A==
X-Gm-Message-State: ACrzQf3YJjAeaKgEs7XbqRRc/Qr0VVP8/USYL6ZIBe+WjPrj+g2YUDzF
        qfw0bsjq5eKXWWrT2nfWr6E=
X-Google-Smtp-Source: AMsMyM7hGYNDneCxj/mO3OQjj6HuZzyLIAuQu9PdiqZFWX5kSoAFOuY/IRR2DL1tZeXbRITei1bgtQ==
X-Received: by 2002:a05:6870:b68c:b0:132:b864:2aa2 with SMTP id cy12-20020a056870b68c00b00132b8642aa2mr30117901oab.130.1666382532322;
        Fri, 21 Oct 2022 13:02:12 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-a860-f1d2-9e17-7593.res6.spectrum.com. [2603:8081:140c:1a00:a860:f1d2:9e17:7593])
        by smtp.googlemail.com with ESMTPSA id s23-20020a056870631700b00132f141ef2dsm10674684oao.56.2022.10.21.13.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 13:02:11 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leon@kernel.org,
        jhack@hpe.com, ian.ziemba@hpe.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, haris.phnx@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 09/18] RDMA/rxe: Simplify reset state handling in rxe_resp.c
Date:   Fri, 21 Oct 2022 15:01:10 -0500
Message-Id: <20221021200118.2163-10-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221021200118.2163-1-rpearsonhpe@gmail.com>
References: <20221021200118.2163-1-rpearsonhpe@gmail.com>
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

Make rxe_responder() more like rxe_completer() and take qp reset
handling out of the state machine.

Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 2a2a50de51b2..dd11dea70bbf 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -40,7 +40,6 @@ enum resp_states {
 	RESPST_ERR_LENGTH,
 	RESPST_ERR_CQ_OVERFLOW,
 	RESPST_ERROR,
-	RESPST_RESET,
 	RESPST_DONE,
 	RESPST_EXIT,
 };
@@ -75,7 +74,6 @@ static char *resp_state_name[] = {
 	[RESPST_ERR_LENGTH]			= "ERR_LENGTH",
 	[RESPST_ERR_CQ_OVERFLOW]		= "ERR_CQ_OVERFLOW",
 	[RESPST_ERROR]				= "ERROR",
-	[RESPST_RESET]				= "RESET",
 	[RESPST_DONE]				= "DONE",
 	[RESPST_EXIT]				= "EXIT",
 };
@@ -1278,8 +1276,9 @@ int rxe_responder(void *arg)
 
 	switch (qp->resp.state) {
 	case QP_STATE_RESET:
-		state = RESPST_RESET;
-		break;
+		rxe_drain_req_pkts(qp, false);
+		qp->resp.wqe = NULL;
+		goto exit;
 
 	default:
 		state = RESPST_GET_REQ;
@@ -1438,11 +1437,6 @@ int rxe_responder(void *arg)
 
 			goto exit;
 
-		case RESPST_RESET:
-			rxe_drain_req_pkts(qp, false);
-			qp->resp.wqe = NULL;
-			goto exit;
-
 		case RESPST_ERROR:
 			qp->resp.goto_error = 0;
 			pr_debug("qp#%d moved to error state\n", qp_num(qp));
-- 
2.34.1

