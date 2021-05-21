Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C7B38CF22
	for <lists+linux-rdma@lfdr.de>; Fri, 21 May 2021 22:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhEUUgZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 May 2021 16:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhEUUgY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 May 2021 16:36:24 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051D9C061574
        for <linux-rdma@vger.kernel.org>; Fri, 21 May 2021 13:34:59 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id s19so20818692oic.7
        for <linux-rdma@vger.kernel.org>; Fri, 21 May 2021 13:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:references:to:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=3UQAywlgXHaVkRjpEPPAFtNgPyK/P0UxLlGM1ZBqBhs=;
        b=jdreAls30lJzrbWtdraMhmKTSb7+IufHv7YA2oS8RfPJAYYN1XKUzvrpmDef9jw1hH
         BzFDHab355kK1jduXncmS0M/TTQDO9imZIFkbRodiHW10c7d6SpejO861Eg3XJguyJSH
         0UNOSWJSG7tL/eoMiYRvy9wWPA0q7nw7DjzrFQIMihMJQBKKn3ExQ3wTMdLyzo5SK5C7
         6OOVWbrxvvdzIXnZv2KUloYyA6iI0C78+2vUircNqC4inGLSU3FgkSO2o93ty1U6ZULD
         UFaPAMRhPhcOXseBY8uMYxaj6fzGbbs/M3tl/DjdmeU568BHdCjl+S0trJwyuJWHgRmW
         2Kag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:to:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3UQAywlgXHaVkRjpEPPAFtNgPyK/P0UxLlGM1ZBqBhs=;
        b=BrY5RnM+wuRkt4daTRSAAH8QF4QoQ8h5EVqwYpIt/KE55U9frzMTYxsAbbwFJlqJ+u
         P/3C59p5VtxTd2HVLPu7mE1d+BD8Dz4tmiY+8OjJX5Muy4tykDNf9loEFYDAHUzoBTO5
         BE5HrZuRBHY7Xe0kma5K2ZEP+ddnZtzzjIocSMX9moe1Ev7lYwngqVrO1tSdSqbi2+2b
         HqFn1Jy2bsaMQHw0Jeg3xSZZyOBVFsMQN91sRSsmZaHmgMiWGsyJK6e+YyWOLphC6XjK
         Fj5tCZwfHTEMfxTmGqy0rX4NlXdhuZ3UObIaUe0z1RysEjgmJ46caK5c+w/UcStXwaVN
         Id9Q==
X-Gm-Message-State: AOAM531ZV6/mqwhxoxeXcQ3UNJRE5WES+j/vWOpYVyNOXPLbljdkrmV+
        nN3QGulrzOKQeSojl4ImBJWdDvlz52Ddag==
X-Google-Smtp-Source: ABdhPJzWxVnCH99ybGA19dC0ynMFlxsYYtQZ5fUwdugIfHW4RHeS5d74FOp8qQs+JrR4MrwVQ66Ufw==
X-Received: by 2002:aca:d68a:: with SMTP id n132mr3319990oig.105.1621629298983;
        Fri, 21 May 2021 13:34:58 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:7300:72eb:72bd:e6db? (2603-8081-140c-1a00-7300-72eb-72bd-e6db.res6.spectrum.com. [2603:8081:140c:1a00:7300:72eb:72bd:e6db])
        by smtp.gmail.com with ESMTPSA id y7sm1310936oix.36.2021.05.21.13.34.58
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 13:34:58 -0700 (PDT)
Subject: Fwd: [PATCH] Providers/rxe: Implement memory windows
References: <20210521202044.659671-1-rpearsonhpe@gmail.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Forwarded-Message-Id: <20210521202044.659671-1-rpearsonhpe@gmail.com>
Message-ID: <0f282b2a-74d3-af15-9afe-8c2ff300784f@gmail.com>
Date:   Fri, 21 May 2021 15:34:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210521202044.659671-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Oops can't spell today.


-------- Forwarded Message --------
Subject: [PATCH] Providers/rxe: Implement memory windows
Date: Fri, 21 May 2021 15:20:45 -0500
From: Bob Pearson <rpearsonhpe@gmail.com>
To: jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.gmail.com
CC: Bob Pearson <rpearson@hpe.com>

From: Bob Pearson <rpearson@hpe.com>

For Zhu to test kernel driver. As of today this applies to
rdma-core cleanly. This is already pushed to my githib tree waiting
for the kernel patches to go in. Once that happens I can send a PR
to rdma-core at github.

Bob

Add ibv_alloc_mw verb
Add ibc_dealloc_verb
Add ibc_bind_mw verb for type1 MWs
Add code to support bind MW WRs for type2 MWs

Depends on kernel driver changes and changes to
kernel-headers/rdma/rdma_user_rxe.h.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 providers/rxe/rxe.c | 127 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 125 insertions(+), 2 deletions(-)

diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
index a68656ae..09b21195 100644
--- a/providers/rxe/rxe.c
+++ b/providers/rxe/rxe.c
@@ -128,6 +128,95 @@ static int rxe_dealloc_pd(struct ibv_pd *pd)
 	return ret;
 }
 
+static struct ibv_mw *rxe_alloc_mw(struct ibv_pd *ibpd, enum ibv_mw_type type)
+{
+	int ret;
+	struct ibv_mw *ibmw;
+	struct ibv_alloc_mw cmd = {};
+	struct ib_uverbs_alloc_mw_resp resp = {};
+
+	ibmw = calloc(1, sizeof(*ibmw));
+	if (!ibmw)
+		return NULL;
+
+	ret = ibv_cmd_alloc_mw(ibpd, type, ibmw, &cmd, sizeof(cmd),
+						&resp, sizeof(resp));
+	if (ret) {
+		free(ibmw);
+		return NULL;
+	}
+
+	return ibmw;
+}
+
+static int rxe_dealloc_mw(struct ibv_mw *ibmw)
+{
+	int ret;
+
+	ret = ibv_cmd_dealloc_mw(ibmw);
+	if (ret)
+		return ret;
+
+	free(ibmw);
+	return 0;
+}
+
+static int next_rkey(int rkey)
+{
+	return (rkey & 0xffffff00) | ((rkey + 1) & 0x000000ff);
+}
+
+static int rxe_post_send(struct ibv_qp *ibqp, struct ibv_send_wr *wr_list,
+			 struct ibv_send_wr **bad_wr);
+
+static int rxe_bind_mw(struct ibv_qp *ibqp, struct ibv_mw *ibmw,
+			struct ibv_mw_bind *mw_bind)
+{
+	int ret;
+	struct ibv_mw_bind_info	*bind_info = &mw_bind->bind_info;
+	struct ibv_send_wr ibwr;
+	struct ibv_send_wr *bad_wr;
+
+	if (!bind_info->mr && (bind_info->addr || bind_info->length)) {
+		ret = EINVAL;
+		goto err;
+	}
+
+	if (bind_info->mw_access_flags & IBV_ACCESS_ZERO_BASED) {
+		ret = EINVAL;
+		goto err;
+	}
+
+	if (bind_info->mr) {
+		if (ibmw->pd != bind_info->mr->pd) {
+			ret = EPERM;
+			goto err;
+		}
+	}
+
+	memset(&ibwr, 0, sizeof(ibwr));
+
+	ibwr.opcode		= IBV_WR_BIND_MW;
+	ibwr.next		= NULL;
+	ibwr.wr_id		= mw_bind->wr_id;
+	ibwr.send_flags		= mw_bind->send_flags;
+	ibwr.bind_mw.bind_info	= mw_bind->bind_info;
+	ibwr.bind_mw.mw		= ibmw;
+	ibwr.bind_mw.rkey	= next_rkey(ibmw->rkey);
+
+	ret = rxe_post_send(ibqp, &ibwr, &bad_wr);
+	if (ret)
+		goto err;
+
+	/* user has to undo this if he gets an error wc */
+	ibmw->rkey = ibwr.bind_mw.rkey;
+
+	return 0;
+err:
+	errno = ret;
+	return errno;
+}
+
 static struct ibv_mr *rxe_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
 				 uint64_t hca_va, int access)
 {
@@ -1275,9 +1364,10 @@ static int rxe_destroy_qp(struct ibv_qp *ibqp)
 }
 
 /* basic sanity checks for send work request */
-static int validate_send_wr(struct rxe_wq *sq, struct ibv_send_wr *ibwr,
+static int validate_send_wr(struct rxe_qp *qp, struct ibv_send_wr *ibwr,
 			    unsigned int length)
 {
+	struct rxe_wq *sq = &qp->sq;
 	enum ibv_wr_opcode opcode = ibwr->opcode;
 
 	if (ibwr->num_sge > sq->max_sge)
@@ -1291,11 +1381,26 @@ static int validate_send_wr(struct rxe_wq *sq, struct ibv_send_wr *ibwr,
 	if ((ibwr->send_flags & IBV_SEND_INLINE) && (length > sq->max_inline))
 		return -EINVAL;
 
+	if (ibwr->opcode == IBV_WR_BIND_MW) {
+		if (length)
+			return -EINVAL;
+		if (ibwr->num_sge)
+			return -EINVAL;
+		if (ibwr->imm_data)
+			return -EINVAL;
+		if ((qp_type(qp) != IBV_QPT_RC) &&
+		    (qp_type(qp) != IBV_QPT_UC))
+			return -EINVAL;
+	}
+
 	return 0;
 }
 
 static void convert_send_wr(struct rxe_send_wr *kwr, struct ibv_send_wr *uwr)
 {
+	struct ibv_mw *ibmw;
+	struct ibv_mr *ibmr;
+
 	memset(kwr, 0, sizeof(*kwr));
 
 	kwr->wr_id		= uwr->wr_id;
@@ -1326,6 +1431,18 @@ static void convert_send_wr(struct rxe_send_wr *kwr, struct ibv_send_wr *uwr)
 		kwr->wr.atomic.rkey		= uwr->wr.atomic.rkey;
 		break;
 
+	case IBV_WR_BIND_MW:
+		ibmr = uwr->bind_mw.bind_info.mr;
+		ibmw = uwr->bind_mw.mw;
+
+		kwr->wr.mw.addr = uwr->bind_mw.bind_info.addr;
+		kwr->wr.mw.length = uwr->bind_mw.bind_info.length;
+		kwr->wr.mw.mr_lkey = ibmr->lkey;
+		kwr->wr.mw.mw_rkey = ibmw->rkey;
+		kwr->wr.mw.rkey = uwr->bind_mw.rkey;
+		kwr->wr.mw.access = uwr->bind_mw.bind_info.mw_access_flags;
+		break;
+
 	default:
 		break;
 	}
@@ -1348,6 +1465,8 @@ static int init_send_wqe(struct rxe_qp *qp, struct rxe_wq *sq,
 	if (ibwr->send_flags & IBV_SEND_INLINE) {
 		uint8_t *inline_data = wqe->dma.inline_data;
 
+		wqe->dma.resid = 0;
+
 		for (i = 0; i < num_sge; i++) {
 			memcpy(inline_data,
 			       (uint8_t *)(long)ibwr->sg_list[i].addr,
@@ -1363,6 +1482,7 @@ static int init_send_wqe(struct rxe_qp *qp, struct rxe_wq *sq,
 		wqe->iova	= ibwr->wr.atomic.remote_addr;
 	else
 		wqe->iova	= ibwr->wr.rdma.remote_addr;
+
 	wqe->dma.length		= length;
 	wqe->dma.resid		= length;
 	wqe->dma.num_sge	= num_sge;
@@ -1385,7 +1505,7 @@ static int post_one_send(struct rxe_qp *qp, struct rxe_wq *sq,
 	for (i = 0; i < ibwr->num_sge; i++)
 		length += ibwr->sg_list[i].length;
 
-	err = validate_send_wr(sq, ibwr, length);
+	err = validate_send_wr(qp, ibwr, length);
 	if (err) {
 		printf("validate send failed\n");
 		return err;
@@ -1579,6 +1699,9 @@ static const struct verbs_context_ops rxe_ctx_ops = {
 	.dealloc_pd = rxe_dealloc_pd,
 	.reg_mr = rxe_reg_mr,
 	.dereg_mr = rxe_dereg_mr,
+	.alloc_mw = rxe_alloc_mw,
+	.dealloc_mw = rxe_dealloc_mw,
+	.bind_mw = rxe_bind_mw,
 	.create_cq = rxe_create_cq,
 	.create_cq_ex = rxe_create_cq_ex,
 	.poll_cq = rxe_poll_cq,
-- 
2.27.0

