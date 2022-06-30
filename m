Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F68562298
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jun 2022 21:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbiF3TFU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jun 2022 15:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236818AbiF3TFT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Jun 2022 15:05:19 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EB137A29
        for <linux-rdma@vger.kernel.org>; Thu, 30 Jun 2022 12:05:17 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-101b4f9e825so505890fac.5
        for <linux-rdma@vger.kernel.org>; Thu, 30 Jun 2022 12:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fPzDkaS+L/Ev2tFB61N27jlt6NfPFid4f2EAXcBDn2E=;
        b=ELTTZuLpnz7JdNf0hEUSLe5fVyi95b5IcjaVZs+dDNcMKByGbpqK3tTUWNU1xl2FWY
         v/ZfgRIKC2HsAivbOhQo59VCNQcF0H7UDJbSv3iHZKvZYLfO9RkA/HAjjqDtnIEvQyQK
         tmH3sRD47tM8Fi1lrx/2ST4VHBFT2nmUXonaEsloL0mPJG9zb2i405hFZnNYPhtCSkTr
         R3WovGQ78qRs+EbTLjYlfjr7AxGf0J5nHrxPjNJMiCC6NbrFY1ViX8VqNWtoGtreILcD
         fcaWLPbyAu43ZG8qOzH7oGkV3nEGBhzFaMAhkh3X7oTAM0gyYqCRM+F86QSGf5f7w5gc
         Pg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fPzDkaS+L/Ev2tFB61N27jlt6NfPFid4f2EAXcBDn2E=;
        b=luXdW6NlGgO/6rtg9FKAYC3Eil0OocBTfThVPVbnsc6d+fYeGQkeCvStT0gW9J6lCW
         ZjUxe/QY0wkfWV/2Cln0kjtzTNQekgeOr0aFY1g+DQ8GjaolkiU6lWTrKu0N1QjbUK60
         vgfLQwQjL0SZW2g7Tq20iDvgO6CeqBX1AoPwT0+9hiEMzAvp+mwYRZfESGnoruG4P/Uy
         ScBX8e3KfH57gz8JRMGxFBdGuFtpcsd53N8cKSLLwTQHdXZii+n1LjqM3D7QvHVeDv7u
         nuu7Ey2hD5jJgCJZf+C57YoIlNIZASJHfmVA11dQDA2D13XOENhHF5Vtu1BNYPf+p4V7
         FaVA==
X-Gm-Message-State: AJIora9wJj/ia6byd0NZ11SV+W7Jg8MilGyydgA/NkR5lE6+UMjOJdxa
        6iid0uks6Wi49Z81U+IClwVflPnNPrjCPQ==
X-Google-Smtp-Source: AGRyM1v1tY7hcIt0rtxvjKNYHZiEms6w69ar2wJs4HfQj8gDGEauFE+n5UEZsQQPMhDESupGCU0jCQ==
X-Received: by 2002:a05:6871:4705:b0:108:7537:d1ad with SMTP id py5-20020a056871470500b001087537d1admr6281319oab.5.1656615917672;
        Thu, 30 Jun 2022 12:05:17 -0700 (PDT)
Received: from u-22.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id o4-20020a9d4104000000b0060bfb4e4033sm11756442ote.9.2022.06.30.12.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 12:05:16 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 9/9] RDMA/rxe: Replace __rxe_do_task by rxe_run_task
Date:   Thu, 30 Jun 2022 14:04:26 -0500
Message-Id: <20220630190425.2251-10-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220630190425.2251-1-rpearsonhpe@gmail.com>
References: <20220630190425.2251-1-rpearsonhpe@gmail.com>
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

In rxe_req.c replace calls to __rxe_do_task() by calls to
rxe_run_task(.., 0). Using __rxe_do_task is an error because
the completer tasklet is not designed to be re-entrant and
__rxe_do_task() should only be called when it is clear that
no one else could be calling the completer tasklet as is the
case in rxe_qp.c where this call is used in safe environments.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 008ae51c7560..58b9f170b18b 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -723,7 +723,7 @@ int rxe_requester(void *arg)
 						       qp->req.wqe_index);
 			wqe->state = wqe_state_done;
 			wqe->status = IB_WC_SUCCESS;
-			__rxe_do_task(&qp->comp.task);
+			rxe_run_task(&qp->comp.task, 0);
 			goto done;
 		}
 		payload = mtu;
@@ -804,7 +804,7 @@ int rxe_requester(void *arg)
 	goto out;
 err:
 	wqe->state = wqe_state_error;
-	__rxe_do_task(&qp->comp.task);
+	rxe_run_task(&qp->comp.task, 0);
 exit:
 	ret = -EAGAIN;
 out:
-- 
2.34.1

