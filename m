Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3814F8910
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Apr 2022 00:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiDGVGu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Apr 2022 17:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiDGVGr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Apr 2022 17:06:47 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014D3174E85
        for <linux-rdma@vger.kernel.org>; Thu,  7 Apr 2022 14:04:47 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id c24-20020a9d6c98000000b005e6b7c0a8a8so1291302otr.2
        for <linux-rdma@vger.kernel.org>; Thu, 07 Apr 2022 14:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:references
         :content-language:to:from:in-reply-to:content-transfer-encoding;
        bh=6NE/C2aW2ne1VR+5Rb2OByvmON/dLpSvGH9GBg1SJgE=;
        b=k/9D8w3jCvhoz8XU6xnRJ8HEPLtyD+8cgO+2OeHDmIit7whZAESjvT05KFzJLjuSsg
         zoQ4Q9ri6Rg8N9Sk+pieqgQ3yiU8cE/MqFtdPoAeHhUkB+RoryddFfL2BsSH5ptY1Vr3
         UI5L226hWWBfy4w0ZYjMMPW+Y/FX4wCazWQJNcq2e457dc17ioM7/dbwbFmMNqpYGDRI
         FglqfnCTVRsrnkxv/aTDQ2gDj5gJT6c8ScW2Li2ozvG5mxnhzfUQyX2oy5F8eXH5LvnN
         UyQHEnYrFXkXuxgBKEa0tgyRqYoEBtvpz1g993ocKY4NzAjaakCroTJRefNRkiOWMjK/
         Q2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :references:content-language:to:from:in-reply-to
         :content-transfer-encoding;
        bh=6NE/C2aW2ne1VR+5Rb2OByvmON/dLpSvGH9GBg1SJgE=;
        b=cBKgzecRTKbuRuA6SVYxzRy1yzs86BuGi8ZfE/j1scUMxXjz1gKv3Pq1OsezyK8Lc0
         DFat0wBAFDPijmHXAi6p02bXq24pGcnBCLRWsUh1WSqMSZ3SHl6FRgnKi9N6oEjXumWk
         I+uFiQhOAIBeY0cW1FjoWEFBJy7NnWBE/9/DxqZKVcq+J9ky8mkfDy9wmR0oHTmkmt4g
         5OsE9JTCcFgTFYz6NPcaD0BFXPQPBuRydMU+8H5LibIL2Eg4ase+kMhRQaoOWVv3DldP
         396Q4uhTAJvIE8JpT8IRy6D2Rq4mPAhd8qOsrUYSra2qWvRbbankbnETOUpc/UbGjqju
         nrjA==
X-Gm-Message-State: AOAM530mOP+u+0Wx7+VUqbLV/2nb709PrExRFRrLJec2gzh4nAFteuo1
        26St6F3qGohcA5SKzBwdnvJMkKL4RTw=
X-Google-Smtp-Source: ABdhPJwD5/ynFBybWINTdwLzIRaOfRiFVZGFFv4ZTRFjVbhLPnoJ7ZhsNrqGpRSuG4of7qOsc/XhpA==
X-Received: by 2002:a05:6830:1518:b0:5ce:6e6:5c55 with SMTP id k24-20020a056830151800b005ce06e65c55mr5297950otp.292.1649365486116;
        Thu, 07 Apr 2022 14:04:46 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:203d:1c92:96e5:569a? (2603-8081-140c-1a00-203d-1c92-96e5-569a.res6.spectrum.com. [2603:8081:140c:1a00:203d:1c92:96e5:569a])
        by smtp.gmail.com with ESMTPSA id w1-20020a056808090100b002da82caced5sm7846319oih.3.2022.04.07.14.04.45
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 14:04:45 -0700 (PDT)
Message-ID: <cce0f07d-25fc-5880-69e7-001d951750b7@gmail.com>
Date:   Thu, 7 Apr 2022 16:04:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Fwd: [PATCH for-next] RDMA/rxe: Remove reliable datagram support
References: <20220407190522.19326-1-rpearsonhpe@gmail.com>
Content-Language: en-US
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220407190522.19326-1-rpearsonhpe@gmail.com>
X-Forwarded-Message-Id: <20220407190522.19326-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org




-------- Forwarded Message --------
Subject: [PATCH for-next] RDMA/rxe: Remove reliable datagram support
Date: Thu,  7 Apr 2022 14:05:23 -0500
From: Bob Pearson <rpearsonhpe@gmail.com>
To: jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kerne.org
CC: Bob Pearson <rpearsonhpe@gmail.com>

The rdma_rxe driver does not actually support the reliable datagram transport
but contains two references to RD opcodes in driver code.
This commit removes these references to RD transport opcodes which
are never used.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_req.c  | 3 +--
 drivers/infiniband/sw/rxe/rxe_resp.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 52c1d8ff6e5b..5f7348b11268 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -413,8 +413,7 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 
 	if (pkt->mask & RXE_ATMETH_MASK) {
 		atmeth_set_va(pkt, wqe->iova);
-		if (opcode == IB_OPCODE_RC_COMPARE_SWAP ||
-		    opcode == IB_OPCODE_RD_COMPARE_SWAP) {
+		if (opcode == IB_OPCODE_RC_COMPARE_SWAP) {
 			atmeth_set_swap_add(pkt, ibwr->wr.atomic.swap);
 			atmeth_set_comp(pkt, ibwr->wr.atomic.compare_add);
 		} else {
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 9dc38f7c990b..e2653a8721fe 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -576,8 +576,7 @@ static enum resp_states process_atomic(struct rxe_qp *qp,
 
 	qp->resp.atomic_orig = *vaddr;
 
-	if (pkt->opcode == IB_OPCODE_RC_COMPARE_SWAP ||
-	    pkt->opcode == IB_OPCODE_RD_COMPARE_SWAP) {
+	if (pkt->opcode == IB_OPCODE_RC_COMPARE_SWAP) {
 		if (*vaddr == atmeth_comp(pkt))
 			*vaddr = atmeth_swap_add(pkt);
 	} else {
-- 
2.32.0

