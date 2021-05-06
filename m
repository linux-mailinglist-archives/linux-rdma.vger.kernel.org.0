Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E898375D83
	for <lists+linux-rdma@lfdr.de>; Fri,  7 May 2021 01:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbhEFXiX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 19:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbhEFXiW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 May 2021 19:38:22 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73CFC061574
        for <linux-rdma@vger.kernel.org>; Thu,  6 May 2021 16:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-Id:Date:Cc:To:From;
        bh=OXSE4EbkQdJLLrNmd52YoLQxbyDtmOHKK06g1ZuDyKk=; b=1fJ+tIrWjGTw2RXiOtK+i1VJgr
        75TeaQ88PFrS23LJ6gzn7bOsv57ZXp5MgEPW28uJgWth5oLzdVBS9Kl3tqgPViB/C8FxeoePULwsK
        P3V9ow6tVRy790q1tM47geh5dd8sOow1dmf8VgQL1CgV8tJSoqBlCF0xaMbtd8Kv7GWdB/08DepG8
        udgCRos8X5YyN02KAI1FTp4zq7pcf7P+fnPucXsRt6Je62VYkaw7mbLoS8/uwmP5X0g6X89HK7t0q
        d6wax2VrecnUmRFfFS9yV/MY0LwdkHfcvfGP8NWSzS5HP4yEsUhGOuUxGYeF34SUY5Xi7279cyhBy
        +ltCLc80onbgUYj5ElcBW2h5RAUSXeul9Wzhe0vJShx59UTJWABbWhZvR/zcIQjryfVHADAVePkm2
        Gbp9RlIY5K51V7HG9tf3FkQ5wOcPMB4dg8PqP1sD9tvIgprD2XZqIAuwV2aWOchMAbKZp1/Z04NkO
        3MfmTnOmG7uwnTdNio13GzI5;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1lenYY-0004Iy-2f; Thu, 06 May 2021 23:37:22 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, Stefan Metzmacher <metze@samba.org>
Subject: [PATCH 04/31] rdma/siw: let siw_accept() deferr RDMA_MODE until EVENT_ESTABLISHED
Date:   Fri,  7 May 2021 01:36:10 +0200
Message-Id: <4d26a4cfd96bfcb3fe0362a37d595608b09ddd91.1620343860.git.metze@samba.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1620343860.git.metze@samba.org>
References: <cover.1620343860.git.metze@samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

If we receive an TCP FIN before sending the MPA response
we'll get an error and posted IW_CM_EVENT_CLOSE.
But the IWCM layer didn't receive IW_CM_EVENT_ESTABLISHED
yet and doesn't expect IW_CM_EVENT_CLOSE. Instead
it expects IW_CM_EVENT_CONNECT_REPLY.

If we stay in SIW_EPSTATE_RECVD_MPAREQ until we posted
IW_CM_EVENT_ESTABLISHED __siw_cep_terminate_upcall()
will use IW_CM_EVENT_CONNECT_REPLY.

This can be triggered by the following change on the
client:

   --- a/drivers/infiniband/sw/siw/siw_cm.c
   +++ b/drivers/infiniband/sw/siw/siw_cm.c
   @@ -1507,6 +1507,9 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
           if (rv >= 0) {
                   rv = siw_cm_queue_work(cep, SIW_CM_WORK_MPATIMEOUT);
                   if (!rv) {
   +                       rv = -ECONNRESET;
   +                       msleep_interruptible(100);
   +                       goto error;
                           siw_dbg_cep(cep, "[QP %u]: exit\n", qp_id(qp));
                           siw_cep_set_free(cep);
                           return 0;

Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw_cm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index da84686a21fd..145ab6e4e0ed 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -129,8 +129,10 @@ static void siw_rtr_data_ready(struct sock *sk)
 	 * Failed data processing would have already scheduled
 	 * connection drop.
 	 */
-	if (!qp->rx_stream.rx_suspend)
+	if (!qp->rx_stream.rx_suspend) {
 		siw_cm_upcall(cep, IW_CM_EVENT_ESTABLISHED, 0);
+		cep->state = SIW_EPSTATE_RDMA_MODE;
+	}
 out:
 	read_unlock(&sk->sk_callback_lock);
 	if (qp)
@@ -1656,8 +1658,6 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	/* siw_qp_get(qp) already done by QP lookup */
 	cep->qp = qp;
 
-	cep->state = SIW_EPSTATE_RDMA_MODE;
-
 	/* Move socket RX/TX under QP control */
 	rv = siw_qp_modify(qp, &qp_attrs,
 			   SIW_QP_ATTR_STATE | SIW_QP_ATTR_LLP_HANDLE |
@@ -1683,6 +1683,7 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 		rv = siw_cm_upcall(cep, IW_CM_EVENT_ESTABLISHED, 0);
 		if (rv)
 			goto error;
+		cep->state = SIW_EPSTATE_RDMA_MODE;
 	}
 	siw_cep_set_free(cep);
 
-- 
2.25.1

