Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990E240B520
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Sep 2021 18:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhINQoY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Sep 2021 12:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhINQoN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Sep 2021 12:44:13 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F2AC061574
        for <linux-rdma@vger.kernel.org>; Tue, 14 Sep 2021 09:42:55 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id bi4so19842030oib.9
        for <linux-rdma@vger.kernel.org>; Tue, 14 Sep 2021 09:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cPoJTfPdHp/LeXcgMLIb9FBaUbIGu0QL53pSwedsxQU=;
        b=oHMkbQvpZg8IAefGZY9Q3sdT+VWK6nWrZYz+7ZYfGSY8hjmlx7aNwaf5Tf0FWDDeBN
         SiA6gEyiRLry10xG+v+LDE70qET2YVHSomisp2QhyrxVdzkk4Af83+XX3xR9DnT1eONo
         5NtTbiWAEtwK6q1m8wZNKPftRRtVVa9NW689apXXyKkSp+lfltIpG0RPK/hPYWr8DLr8
         TZB0pNYS1JujxPbKdnntZvuov1/MyxLWMGsyRX0EWvlLSqftythaB9w2NcPMZLlBiX8O
         Z46V/Pl1WFLWX/NNdxNduylaT1lEKBkY0IKz+UNG21frfeR7CcDDGI5zbtdqMEajMf5C
         8H5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cPoJTfPdHp/LeXcgMLIb9FBaUbIGu0QL53pSwedsxQU=;
        b=SPZ0LOwkIkiLTi1aNcDvP9XjE4JS7PSAusX7AJZfXtexkZDzf0I4Wl1VdzBnwVMATK
         t9/3zhywIlqUxmL8wq7UiDtK+E/S3nRidve/0Y7wxgiAxNVn27Jq4FEkpTLQMAIlHsRP
         shcFPASwOT7q+VZRRo5wmg+kUOoU/vz8WddWWZZHlhjT7SIX91E0ofvUD9FVFkEIKJ93
         yqYDtRkfD2MI0wrsaFszmEBr4F+nqpr9QgG6Aww5REaZZGHhf0KrGSsZTkjVYq33YPAI
         rEEUn+xOCe8ehOR34NQzZlEKsgaF7Sa/2rOyQs87XlII2MVUMa5FXUq74k0XuLCH6CSJ
         crog==
X-Gm-Message-State: AOAM53143CprxFsXa/zcvSUwUHyuG3TcPJp2VBKk2I+HGmqoAgFCrlco
        Y85sP+cz7zcusy8KVES0fvo=
X-Google-Smtp-Source: ABdhPJzsg8Bh55/Q3UmUjFeaGDYV3OSGpq15CjIRLFXS+0GJcLAv9wLP85mI4Wh3izXFVDSZGnQ7xg==
X-Received: by 2002:aca:af0d:: with SMTP id y13mr2099598oie.161.1631637775337;
        Tue, 14 Sep 2021 09:42:55 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-61e3-00cf-5364-0046.res6.spectrum.com. [2603:8081:140c:1a00:61e3:cf:5364:46])
        by smtp.gmail.com with ESMTPSA id k1sm2850263otr.43.2021.09.14.09.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 09:42:54 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        bvanassche@acm.org, mie@igel.co.jp, rao.shoaib@oracle.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-rc v4 5/5] RDMA/rxe: Only allow invalidate for appropriate MRs
Date:   Tue, 14 Sep 2021 11:42:07 -0500
Message-Id: <20210914164206.19768-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914164206.19768-1-rpearsonhpe@gmail.com>
References: <20210914164206.19768-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Local and remote invalidate operations are not allowed by IBA for
MRs created by (re)register memory verbs. This patch checks the
MR type in rxe_invalidate_mr().

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 8d658d42abed..53271df10e47 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -605,6 +605,12 @@ int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey)
 		goto err_drop_ref;
 	}
 
+	if (unlikely(mr->type != IB_MR_TYPE_MEM_REG)) {
+		pr_warn("%s: mr->type (%d) is wrong type\n", __func__, mr->type);
+		ret = -EINVAL;
+		goto err_drop_ref;
+	}
+
 	mr->state = RXE_MR_STATE_FREE;
 	ret = 0;
 
-- 
2.30.2

