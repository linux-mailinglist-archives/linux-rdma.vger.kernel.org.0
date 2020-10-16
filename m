Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9E9290A6E
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Oct 2020 19:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390450AbgJPRRk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Oct 2020 13:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732539AbgJPRRk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Oct 2020 13:17:40 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4163DC061755
        for <linux-rdma@vger.kernel.org>; Fri, 16 Oct 2020 10:17:40 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id m22so3078226ots.4
        for <linux-rdma@vger.kernel.org>; Fri, 16 Oct 2020 10:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=09AKsKcRV3x3j2Df7q5jbuR60C+IiuMK1F3SVXHqKnE=;
        b=a58A7tF9H3dMjh4fj+2kLiuoeJHNGHSVPhxMfzXFsINo0dXnYlBwajVWZ3yKLob0c5
         4aQWkpOpZNIAmGRMZtWU+2OAOdmMEUShs0b1tjnoATTFDgwC38Fi3sGAm0yJB8MmV3EA
         eLvgXIJSyrW9S6lutJi0ZLjjL+ifvp3r2gSYnTnVoz9mt1n8mR2QjItVaAEzis27gTFG
         id3Cnx27ukrKJuXqmVnyNUFSMs3LFcn2LhGQp3X7Uyu7gWIIF7Xdsr3URoLjNd0NTZcU
         OBnywVhwfknclJFkTlYEZC0BAnxDj0lnanzil5qwI2Oi8pQgvMKEnj5hTVm48Bc/WqNY
         RyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=09AKsKcRV3x3j2Df7q5jbuR60C+IiuMK1F3SVXHqKnE=;
        b=EFnPjPUzFddrAanFaLfdqxAbiqxgK8N8eu2GreDZ7YS6TpUFMlFaeZYx82YHsCsxTb
         TIXutz3SCgp2URZDFYQBi4GGb+yF+4Bmeld9Sg7zKFUhjSIgzi0Mc99sWoXsVhDXS9ET
         zgS6vgi0PmawZY0xd97Cer96mfU0FpRCH+TrK/uMzLIrOuUbP+tBO94vB/3t2UQ1fe/q
         cJHJhpiQvo73AmYXMqgciqqsoFgWIJAEfgfjdOzp7g34Q8cciJlUNLeq1874T7jgZPq3
         8GhlptXftMhVTjsIQyFqdIPRoy/MmIf+Oyggar05Io6jU386uY+Bqr3GL1c6NTj/J4xa
         FguA==
X-Gm-Message-State: AOAM5308GEmovibKV49XhOOrUGXRhIW6MwpCIhpoXe+DBu0ApQzycvs+
        QTWpRpwv5RO1dwg34jJBmio=
X-Google-Smtp-Source: ABdhPJyBjIoIpASn19B1PR2Sf37fz1Vtwc3x2AyeYjZPzvQ10wOwqHI/Tc/yqG4LA5FAAI59QDaFBA==
X-Received: by 2002:a05:6830:94:: with SMTP id a20mr3212650oto.366.1602868659608;
        Fri, 16 Oct 2020 10:17:39 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-12c8-a8c9-534e-6722.res6.spectrum.com. [2603:8081:140c:1a00:12c8:a8c9:534e:6722])
        by smtp.gmail.com with ESMTPSA id u140sm1171675oie.41.2020.10.16.10.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 10:17:39 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH RFC] rdma_rxe: Stop passing AV from user space
Date:   Fri, 16 Oct 2020 12:01:48 -0500
Message-Id: <20201016170147.11016-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch shows it is possible to replace the current
method used by rdma_rxe to handle UD transport where
user space creates and then passes an rxe_av *av to the
kernel driver as part of each rxe_send_wqe.

Here user space passes the handle created by the call to
ibv_create_ah in the send wqe. The kernel driver uses that
handle to get a pointer to the 'real' rxe_av that was
created in the kernel by the create ah verb.

To do this requires executing code in the driver that mimics
what is done in rdma_core to convert handles to objects.
This is not ideal but gets the job done. It would probably be
better for rdma_core to provide a service that can do this
for software drivers that have to do this.

The alternative (used by the MW code) is to create a driver
private index and pass that back from the create verb to
user space and then have user space use that in the send wqe.

I would like to avoid replicating work already being done by
rdma core by using the handle that already exists. I don't
know the relative performance of the lookup in rdma_core and
the red black tree used by rxe currently.

There is a matching change to provider/rxe.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---

diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
index ffe11b03724c..faa70c4f14bb 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -425,6 +425,7 @@ struct ib_uobject *rdma_lookup_get_uobject(const struct uverbs_api_object *obj,
 	uverbs_uobject_put(uobj);
 	return ERR_PTR(ret);
 }
+EXPORT_SYMBOL(rdma_lookup_get_uobject);
 
 static struct ib_uobject *
 alloc_begin_idr_uobject(const struct uverbs_api_object *obj,
@@ -726,6 +727,7 @@ void rdma_lookup_put_uobject(struct ib_uobject *uobj,
 	/* Pairs with the kref obtained by type->lookup_get */
 	uverbs_uobject_put(uobj);
 }
+EXPORT_SYMBOL(rdma_lookup_put_uobject);
 
 void setup_ufile_idr_uobject(struct ib_uverbs_file *ufile)
 {
diff --git a/drivers/infiniband/sw/rxe/rxe_av.c b/drivers/infiniband/sw/rxe/rxe_av.c
index 38021e2c8688..db83e1cde38e 100644
--- a/drivers/infiniband/sw/rxe/rxe_av.c
+++ b/drivers/infiniband/sw/rxe/rxe_av.c
@@ -6,6 +6,8 @@
 
 #include "rxe.h"
 #include "rxe_loc.h"
+#include "../../core/uverbs.h"
+#include "../../core/rdma_core.h"
 
 void rxe_init_av(struct rdma_ah_attr *attr, struct rxe_av *av)
 {
@@ -72,13 +74,50 @@ void rxe_av_fill_ip_info(struct rxe_av *av, struct rdma_ah_attr *attr)
 	av->network_type = rdma_gid_attr_network_type(sgid_attr);
 }
 
+static struct ib_ah *get_ah_from_handle(struct rxe_qp *qp, u32 handle)
+{
+	struct ib_uverbs_file *ufile;
+	struct uverbs_api *uapi;
+	const struct uverbs_api_object *type;
+	struct ib_uobject *uobj;
+
+	ufile = qp->ibqp.uobject->uevent.uobject.ufile;
+	uapi = ufile->device->uapi;
+	type = uapi_get_object(uapi, UVERBS_OBJECT_AH);
+	if (IS_ERR(type))
+		return NULL;
+	uobj = rdma_lookup_get_uobject(type, ufile, (s64)handle,
+				       UVERBS_LOOKUP_READ, NULL);
+	if (IS_ERR(uobj)) {
+		pr_warn("unable to lookup ah handle\n");
+		return NULL;
+	}
+
+	rdma_lookup_put_uobject(uobj, UVERBS_LOOKUP_READ);
+	return uobj->object;
+}
+
 struct rxe_av *rxe_get_av(struct rxe_pkt_info *pkt)
 {
-	if (!pkt || !pkt->qp)
+	struct rxe_qp *qp = pkt->qp;
+	struct rxe_send_wqe *wqe = pkt->wqe;
+	u32 handle;
+	struct ib_ah *ibah;
+	struct rxe_ah *ah;
+
+	if (!pkt || !qp)
 		return NULL;
 
-	if (qp_type(pkt->qp) == IB_QPT_RC || qp_type(pkt->qp) == IB_QPT_UC)
-		return &pkt->qp->pri_av;
+	if (qp_type(qp) == IB_QPT_RC || qp_type(qp) == IB_QPT_UC)
+		return &qp->pri_av;
+
+	if (qp->is_user) {
+		handle = wqe->wr.wr.ud.ah_handle;
+		ibah = get_ah_from_handle(qp, handle);
+	} else {
+		ibah = wqe->wr.wr.ud.ah;
+	}
 
-	return (pkt->wqe) ? &pkt->wqe->av : NULL;
+	ah = to_rah(ibah);
+	return &ah->av;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index d4917646641a..2a887dca9a28 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -380,12 +380,16 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 
 	/* init skb */
 	av = rxe_get_av(pkt);
+	if (!av) {
+		pr_warn("unable to get av\n");
+		return NULL;
+	}
 	skb = rxe_init_packet(rxe, av, paylen, pkt);
 	if (unlikely(!skb))
 		return NULL;
 
 	/* init bth */
-	solicited = (ibwr->send_flags & IB_SEND_SOLICITED) &&
+	solicited = (ibwr->send_flags & IB_SEND_SOLICITED) &&
 			(pkt->mask & RXE_END_MASK) &&
 			((pkt->mask & (RXE_SEND_MASK)) ||
 			(pkt->mask & (RXE_WRITE_MASK | RXE_IMMDT_MASK)) ==
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 0a7d7c55d8d6..4d4ded90f793 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -506,6 +506,7 @@ static void init_send_wr(struct rxe_qp *qp, struct rxe_send_wr *wr,
 	if (qp_type(qp) == IB_QPT_UD ||
 	    qp_type(qp) == IB_QPT_SMI ||
 	    qp_type(qp) == IB_QPT_GSI) {
+		wr->wr.ud.ah = ud_wr(ibwr)->ah;
 		wr->wr.ud.remote_qpn = ud_wr(ibwr)->remote_qpn;
 		wr->wr.ud.remote_qkey = ud_wr(ibwr)->remote_qkey;
 		if (qp_type(qp) == IB_QPT_GSI)
@@ -562,11 +563,6 @@ static int init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 
 	init_send_wr(qp, &wqe->wr, ibwr);
 
-	if (qp_type(qp) == IB_QPT_UD ||
-	    qp_type(qp) == IB_QPT_SMI ||
-	    qp_type(qp) == IB_QPT_GSI)
-		memcpy(&wqe->av, &to_rah(ud_wr(ibwr)->ah)->av, sizeof(wqe->av));
-
 	if (unlikely(ibwr->send_flags & IB_SEND_INLINE)) {
 		p = wqe->dma.inline_data;
 
diff --git a/include/uapi/rdma/rdma_user_rxe.h b/include/uapi/rdma/rdma_user_rxe.h
index d8f2e0e46dab..d57271451052 100644
--- a/include/uapi/rdma/rdma_user_rxe.h
+++ b/include/uapi/rdma/rdma_user_rxe.h
@@ -89,6 +89,10 @@ struct rxe_send_wr {
 			__u32	reserved;
 		} atomic;
 		struct {
+			union {
+				__aligned_u64 ah_handle;
+				struct ib_ah *ah;
+			};
 			__u32	remote_qpn;
 			__u32	remote_qkey;
 			__u16	pkey_index;
@@ -132,7 +136,6 @@ struct rxe_dma_info {
 
 struct rxe_send_wqe {
 	struct rxe_send_wr	wr;
-	struct rxe_av		av;
 	__u32			status;
 	__u32			state;
 	__aligned_u64		iova;
-- 
2.25.1

