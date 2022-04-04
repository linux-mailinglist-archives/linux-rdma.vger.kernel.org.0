Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947844F1F2A
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Apr 2022 00:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347085AbiDDW3V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Apr 2022 18:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236801AbiDDW2U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Apr 2022 18:28:20 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE1651E51
        for <linux-rdma@vger.kernel.org>; Mon,  4 Apr 2022 14:51:27 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id q189so11462444oia.9
        for <linux-rdma@vger.kernel.org>; Mon, 04 Apr 2022 14:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1xptPxghO5Wv38XZBgv1n4noPRyDNrIm4QC80PPVwBo=;
        b=K3nQZaAXVv+vQ/X8xsHllyCKVwTsRlheXteE0HwHV76ZKEgbrroHbww5DaKZWwtiEv
         +EVKkF18Ia8eQmwBV3AlQZdOs0ixCzBac5Py52/j71g6BBK4Tv9ZmpSvCPxzmz8gtT5o
         4SMwJN67NcbG6WdMyQYW8zDcjflYdcg5C7+L7cgICVsHquLc9ZNpsP6qPKsmCi2kr9by
         THpawBfNTPGsCmSv/6p13FKmd9ChWDfDgwK0n0WrDxz75FRuGBS7M0yabZdFckXHHtEt
         jsuOSA++EKBZDtvrqeA8WsLrcriGS5IFWTF7or/RtSWZVbMSHBupd4iCVzKh+2EXPBwk
         UA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1xptPxghO5Wv38XZBgv1n4noPRyDNrIm4QC80PPVwBo=;
        b=oFQNkLSs68sg/L1KvqNaK1nGQkZpLAb/LC8ugQ8P3NAboQ9NfZ94T9OSe1I75LbasA
         6x9QJ9V9Xdc5cPRkK5k0E/BuDEPOzwRCvE1gAVRKD+nCC4WZjUNenU4NFf7g5/hCVSxA
         yGDOKo6w/qASx5g7dkloriGkTVA+hbhcguLA/fWixFrmajUejjG53rNnl14oFyjwOrG+
         Mluy0awiPANAzCJtv42ANezMHXvljzZTFFgkDF+SGE57q31MGa40F/Xo9Ixxqnzsz+SZ
         P+dxoS0AaLZKUGDIkoyFdxS+jUTCrS0VI6v/xHjkeXOvPbCvn2ts74xviYtEa/JOT4D+
         nIXg==
X-Gm-Message-State: AOAM532dYztdXFsnkfyG57YLWzkAiu/hbtBn/TQpQWyL8kW+2YepOeEO
        xlKQ86xL6BIMHh8wN2qmNr1nyUWZDvo=
X-Google-Smtp-Source: ABdhPJwzC5fkkOOuLyUftZIYyMQaKwgDULzsTN7AiZoS5SqZ0p9AD53YDyc31kWu8slXeU1gj9+7wQ==
X-Received: by 2002:a05:6808:159a:b0:2da:3ab5:2051 with SMTP id t26-20020a056808159a00b002da3ab52051mr155723oiw.170.1649109086788;
        Mon, 04 Apr 2022 14:51:26 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-349e-d2a8-b899-a3ee.res6.spectrum.com. [2603:8081:140c:1a00:349e:d2a8:b899:a3ee])
        by smtp.googlemail.com with ESMTPSA id e2-20020a0568301f2200b005cdafdea1d9sm5226441oth.50.2022.04.04.14.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 14:51:26 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v13 03/10] RDMA/rxe: Check rxe_get() return value
Date:   Mon,  4 Apr 2022 16:50:53 -0500
Message-Id: <20220404215059.39819-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220404215059.39819-1-rpearsonhpe@gmail.com>
References: <20220404215059.39819-1-rpearsonhpe@gmail.com>
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

In the tasklets (completer, responder, and requester) check the
return value from rxe_get() to detect failures to get a reference.
This only occurs if the qp has had its reference count drop to
zero which indicates that it no longer should be used. This is
in preparation to an upcoming change that will move the qp cleanup
code to rxe_qp_cleanup().

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c | 3 ++-
 drivers/infiniband/sw/rxe/rxe_req.c  | 3 ++-
 drivers/infiniband/sw/rxe/rxe_resp.c | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 138b3e7d3a5f..da3a398053b8 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -562,7 +562,8 @@ int rxe_completer(void *arg)
 	enum comp_state state;
 	int ret = 0;
 
-	rxe_get(qp);
+	if (!rxe_get(qp))
+		return -EAGAIN;
 
 	if (!qp->valid || qp->req.state == QP_STATE_ERROR ||
 	    qp->req.state == QP_STATE_RESET) {
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index ae5fbc79dd5c..27aba921cc66 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -611,7 +611,8 @@ int rxe_requester(void *arg)
 	struct rxe_ah *ah;
 	struct rxe_av *av;
 
-	rxe_get(qp);
+	if (!rxe_get(qp))
+		return -EAGAIN;
 
 next_wqe:
 	if (unlikely(!qp->valid || qp->req.state == QP_STATE_ERROR))
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 16fc7ea1298d..1ed45c192cf5 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -1250,7 +1250,8 @@ int rxe_responder(void *arg)
 	struct rxe_pkt_info *pkt = NULL;
 	int ret = 0;
 
-	rxe_get(qp);
+	if (!rxe_get(qp))
+		return -EAGAIN;
 
 	qp->resp.aeth_syndrome = AETH_ACK_UNLIMITED;
 
-- 
2.32.0

