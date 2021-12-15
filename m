Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD71047524E
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Dec 2021 06:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhLOFyl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Dec 2021 00:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbhLOFyl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Dec 2021 00:54:41 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03F0C061574;
        Tue, 14 Dec 2021 21:54:40 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id d2so19003451qki.12;
        Tue, 14 Dec 2021 21:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ns5GZijDDkvEqzTEF/tM6NXihTz99Me+1gVWWGykbaU=;
        b=ANzdSoS3CEw7Z4a4SrAL+osqZ6CT/bB4wis+Fm7htyRQY2jg28eddDnaEhLpSEbJLg
         dZyff25pXN8u3hRDoKgndlJetOpPqsR+n/CUkpieNzbUBLf9dzIrEG7ORXmOQr/PVU2a
         0pjyLZRqGTK/+6WMUuq7MHZ+CMqcQrbRV+hqhl7beshgp+t7xjaEPRuPKFuCfNQkiJli
         B0x9Sl+MV2T6UWX2JS5jp2A+seM44wUW10jbADAahYwiaAYdz0nNRyZotO2hYL/sGx9y
         Om6VVayXtGuvUH0dXUtgkOhaCNZX1EiNpYcMG60dhEJ06dEV6OxZBv6b0hKZUP64OStV
         T91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ns5GZijDDkvEqzTEF/tM6NXihTz99Me+1gVWWGykbaU=;
        b=6dRKypZyEY4k0TGeBIMqlxLY7tjsuMjI4v/SHZS0i75FqmTdaF4zqqS/RPHEaQd6AM
         TkhVftG5a8X9WY7fur1fidsAUyuuUo27DEEFWsLjolmTlzV+t4PLbkzUVaUp0LFzt5Mo
         vuvxjyTM5YjgmPA7qw170GaMSuf7ZW7vAUwqvqIu8EhBTU5sTylWvGVuHY6NJITsRKFz
         bzPTPDpaD+0a7MrefoA+VckzxWbZDvz1RB5tg5qxZZxdsmabP6EDnGfNKRnmL4tpUWSt
         IzKOLhzVOojmrJjqK1ttRNmLGbCXbIkaiRTByc3/lE7FyNEitNsO14jCj9vBPSv+t2D1
         c8eA==
X-Gm-Message-State: AOAM532ZrZY8uA5oG0q6yRhwi0tYRYY24bgwCGrTxgNyiqj5uHSM46Nk
        T4QBmi+02ZWpSEQr9iiCeTAHajd+IPE=
X-Google-Smtp-Source: ABdhPJzKzQP7Gb0UbghtWKjuK+K+TzKt4ir7r9Z8x2fWyjfNnJX8XtnYeT4dKZxttSWFdt2FyLwbIg==
X-Received: by 2002:a05:620a:13ea:: with SMTP id h10mr7513026qkl.30.1639547679945;
        Tue, 14 Dec 2021 21:54:39 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d5sm790246qte.27.2021.12.14.21.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 21:54:39 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     jgg@nvidia.com
Cc:     cgel.zte@gmail.com, chi.minghao@zte.com.cn,
        dennis.dalessandro@cornelisnetworks.com,
        devesh.s.sharma@oracle.com, dledford@redhat.com, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        mbloch@nvidia.com, selvin.xavier@broadcom.com, trix@redhat.com,
        zealci@zte.com.cn
Subject: [PATCH for-next v5] RDMA/ocrdma: remove unneeded variable
Date:   Wed, 15 Dec 2021 05:54:21 +0000
Message-Id: <20211215055421.441375-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214235015.GA969883@nvidia.com>
References: <20211214235015.GA969883@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return status directly from function called.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index 735123d0e9ec..3bfbf4ec040d 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -1844,12 +1844,10 @@ int ocrdma_modify_srq(struct ib_srq *ibsrq,
 
 int ocrdma_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *srq_attr)
 {
-	int status;
 	struct ocrdma_srq *srq;
 
 	srq = get_ocrdma_srq(ibsrq);
-	status = ocrdma_mbx_query_srq(srq, srq_attr);
-	return status;
+	return ocrdma_mbx_query_srq(srq, srq_attr);
 }
 
 int ocrdma_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
@@ -1960,7 +1958,6 @@ static int ocrdma_build_inline_sges(struct ocrdma_qp *qp,
 static int ocrdma_build_send(struct ocrdma_qp *qp, struct ocrdma_hdr_wqe *hdr,
 			     const struct ib_send_wr *wr)
 {
-	int status;
 	struct ocrdma_sge *sge;
 	u32 wqe_size = sizeof(*hdr);
 
@@ -1972,8 +1969,7 @@ static int ocrdma_build_send(struct ocrdma_qp *qp, struct ocrdma_hdr_wqe *hdr,
 		sge = (struct ocrdma_sge *)(hdr + 1);
 	}
 
-	status = ocrdma_build_inline_sges(qp, hdr, sge, wr, wqe_size);
-	return status;
+	return ocrdma_build_inline_sges(qp, hdr, sge, wr, wqe_size);
 }
 
 static int ocrdma_build_write(struct ocrdma_qp *qp, struct ocrdma_hdr_wqe *hdr,
-- 
2.25.1

