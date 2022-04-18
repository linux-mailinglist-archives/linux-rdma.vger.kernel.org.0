Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B47C505D9A
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Apr 2022 19:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240262AbiDRRpQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Apr 2022 13:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiDRRpO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Apr 2022 13:45:14 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5C83054B
        for <linux-rdma@vger.kernel.org>; Mon, 18 Apr 2022 10:42:34 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-e5c42b6e31so4936505fac.12
        for <linux-rdma@vger.kernel.org>; Mon, 18 Apr 2022 10:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xaj4GRzXLcIyWaaDG7BOyv9UOaIGcQlx8xn7xC0o0CE=;
        b=eGHjG9174vqkY21umAHukRm2s/UxYGsGzMtGQWXtDIaA2+ldDpUBuXP5D9Wy1r83fl
         FAZLoo/r3YDdpCzX5sefEV+57zEV7GfvMTsAL9XzxYi0IX6FPqV/n4C2x/uWS+gtknHn
         OK26JGo70VFgyiqWebyO47uQFFF8zZH4TGAOokEadV8gx8xqZOZjWDL6rqSMbvZAYYlM
         LBWfQsrLMoNxr3B1M+iomi+WsrhwuHanbpud/ZOXHtyDZ5Ir3MuRteCiM2/wbrPWvgJw
         NUrCijSKzzwThhUdFL0chj3CZrK+iTNfvgjF5cVrBUSiMTiCHf09xqeykzqu68EnCAGV
         LKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xaj4GRzXLcIyWaaDG7BOyv9UOaIGcQlx8xn7xC0o0CE=;
        b=GhglA5uT6h6nUgnGHUZ1pI/F4nbjOjSjMNs7y5o1iMAQuXy4AltuGGaFC0gGmG8sLV
         HTz5JZBuHPrX+f48EkihVcU6bJdo47Y4i4smleF3KZVjPiypiYOV4iATC/h5jBg4Pl9a
         9x0XZtm+jKvWdPYy1hzjJKcT7CzZXwWK9ZEKeANiMaOKjDspiUa1pZUQQXHU62oMbWb9
         RU/rCs7ZXT1qjaE44pWSgRgnRnuB1Mjjj3nn5IWsbHFzsOb+wcYPJHOcZzOM4rZ+78hC
         RIa9qFoPkeTL0IEY3cy7gY3mbD5gR0Ed8O4RDYnUFHc/dchCsGr8jYh1PR2oFE7pB1Wb
         NSaQ==
X-Gm-Message-State: AOAM532t7SI3jkMGmGGWYdKTE+f3ft/GoxsBjX+PmC+e28i6IG+chR/N
        VLYt/u5pQZhwYtsnR3ZnACg=
X-Google-Smtp-Source: ABdhPJw32VftmGM2NwKAlBPgpd9328EHkxvqmot5lpWXkuwiUBovUunED4l4OGm12iolCdAofqMdKw==
X-Received: by 2002:a05:6870:15d3:b0:da:c49f:9113 with SMTP id k19-20020a05687015d300b000dac49f9113mr4800112oad.91.1650303753587;
        Mon, 18 Apr 2022 10:42:33 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-003d-6ec6-6342-73eb.res6.spectrum.com. [2603:8081:140c:1a00:3d:6ec6:6342:73eb])
        by smtp.googlemail.com with ESMTPSA id t129-20020a4a5487000000b00329d2493f8esm4499827ooa.41.2022.04.18.10.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:42:33 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2] RDMA/rxe: Fix "Replace mr by rkey in responder resources"
Date:   Mon, 18 Apr 2022 12:41:04 -0500
Message-Id: <20220418174103.3040-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
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

The rping benchmark fails on long runs. The root cause of this
failure has been traced to a failure to compute a nonzero value of mr
in rare situations.

Fix this failure by correctly handling the computation of mr in
read_reply() in rxe_resp.c in the replay flow.

Fixes: 8a1a0be894da ("RDMA/rxe: Replace mr by rkey in responder resources")
Link: https://lore.kernel.org/linux-rdma/1a9a9190-368d-3442-0a62-443b1a6c1209@linux.dev/
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v2
  Renamed commit
  Changed fixes line to correctly ID the bug
  Added a link to the reported mr == NULL issue

 drivers/infiniband/sw/rxe/rxe_resp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index e2653a8721fe..2e627685e804 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -734,8 +734,14 @@ static enum resp_states read_reply(struct rxe_qp *qp,
 	}
 
 	if (res->state == rdatm_res_state_new) {
-		mr = qp->resp.mr;
-		qp->resp.mr = NULL;
+		if (!res->replay) {
+			mr = qp->resp.mr;
+			qp->resp.mr = NULL;
+		} else {
+			mr = rxe_recheck_mr(qp, res->read.rkey);
+			if (!mr)
+				return RESPST_ERR_RKEY_VIOLATION;
+		}
 
 		if (res->read.resid <= mtu)
 			opcode = IB_OPCODE_RC_RDMA_READ_RESPONSE_ONLY;

base-commit: 98c8026331ceabe1df579940b81eec75eb49cdd9
-- 
2.32.0

