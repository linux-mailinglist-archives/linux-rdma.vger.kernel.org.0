Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF583D2F0E
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jul 2021 23:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbhGVUnK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Jul 2021 16:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbhGVUnJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Jul 2021 16:43:09 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B404FC061575
        for <linux-rdma@vger.kernel.org>; Thu, 22 Jul 2021 14:23:42 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id o2-20020a9d22020000b0290462f0ab0800so82415ota.11
        for <linux-rdma@vger.kernel.org>; Thu, 22 Jul 2021 14:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v3RIBh5TUYedqT7jW+xGyfalIzfFfS9vUC2W8TmzJQw=;
        b=aI+CtR+ov6qj5xriqNNVfvXWjYI7mDot6UpjpliI6+jp1a/NOiOTBDdqJEACPiHhrH
         ghhT/piuF4p8R5Vj4bxBXyA41N+4vMfaNyiOR01sPjcqCePu+aaRBJ3pZyAfz+8Rb5kX
         KYBwV0SIwr8lqiR2mLSuxpSbxathv9w96Fq4bTHS0y+Au8qry7drqe8SzyF8k/rGuI1w
         siyS6eGfZMCAbLA0Hwqg+s5iIG29FrVBGAHQX0dutr9Cgz55KHiz6uzPDdFhVi5wv7Vd
         3I+mk4Y7ej0lg8P2bt5CTdB7LLEFuXyNvje2KE1cITPAhfA2/huIAA/RlIIafAqsxPx6
         jcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v3RIBh5TUYedqT7jW+xGyfalIzfFfS9vUC2W8TmzJQw=;
        b=t3QeMffvIWO3tNGwM18F6lrMBZjnNbLgouwwLCB291UAGtxa3gU56zz0v3JKFegDmx
         lkel51hAqUnqYvDuZwaYSz8cechnqF8r4sClCcZBYf59X2D20UDHjqfHt5nFii8IDzMp
         gCFZf7c83iCchol8axYz6FB/Z002yJQ8zjWmR/3NEvpS3Gnh7bLuTjnnFsorHyrIGAe1
         Za8TCIRrG20B6PxjBnk7ff2xPAR5zlMNgrSum0EEJtXuEVcLfyezU6uZw8TGB/fouTvz
         sCWUG5fgw77COKnb+isnqSq1gTI9ueKiXNqlQ645QARCgaiPZXDWEUYgYeBwsEDQW7+K
         kLfw==
X-Gm-Message-State: AOAM532Dotdi9yGG5a1iNSjFrK78t/bJghSoHvXcc0k/bX+KAlA/KpfM
        1dEioDPZodsrflC6wYM/vzgSEAmE6nE=
X-Google-Smtp-Source: ABdhPJzze8OHpL3eLWgvjac20e0UYwTJGxfL6Q3t/yVGW0SizWhGULWu5tN/1nqfM6wrbIXDsMQrUQ==
X-Received: by 2002:a05:6830:140d:: with SMTP id v13mr1135969otp.296.1626989022194;
        Thu, 22 Jul 2021 14:23:42 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-d50d-298a-08dc-a5ed.res6.spectrum.com. [2603:8081:140c:1a00:d50d:298a:8dc:a5ed])
        by smtp.gmail.com with ESMTPSA id 68sm5276220otd.74.2021.07.22.14.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 14:23:41 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH v3 6/6] RDMA/rxe: Convert kernel UD post send to use ah_num
Date:   Thu, 22 Jul 2021 16:22:45 -0500
Message-Id: <20210722212244.412157-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210722212244.412157-1-rpearsonhpe@gmail.com>
References: <20210722212244.412157-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Modify ib_post_send for kernel UD sends to put the AH index into the
WQE instead of the address vector.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 7181e21f0c55..ee3f70c8809a 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -558,8 +558,11 @@ static void init_send_wr(struct rxe_qp *qp, struct rxe_send_wr *wr,
 	if (qp_type(qp) == IB_QPT_UD ||
 	    qp_type(qp) == IB_QPT_SMI ||
 	    qp_type(qp) == IB_QPT_GSI) {
+		struct ib_ah *ibah = ud_wr(ibwr)->ah;
+
 		wr->wr.ud.remote_qpn = ud_wr(ibwr)->remote_qpn;
 		wr->wr.ud.remote_qkey = ud_wr(ibwr)->remote_qkey;
+		wr->wr.ud.ah_num = to_rah(ibah)->ah_num;
 		if (qp_type(qp) == IB_QPT_GSI)
 			wr->wr.ud.pkey_index = ud_wr(ibwr)->pkey_index;
 		if (wr->opcode == IB_WR_SEND_WITH_IMM)
@@ -631,12 +634,6 @@ static void init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 		return;
 	}
 
-	if (qp_type(qp) == IB_QPT_UD ||
-	    qp_type(qp) == IB_QPT_SMI ||
-	    qp_type(qp) == IB_QPT_GSI)
-		memcpy(&wqe->wr.wr.ud.av, &to_rah(ud_wr(ibwr)->ah)->av,
-		       sizeof(struct rxe_av));
-
 	if (unlikely(ibwr->send_flags & IB_SEND_INLINE))
 		copy_inline_data_to_wqe(wqe, ibwr);
 	else
-- 
2.30.2

