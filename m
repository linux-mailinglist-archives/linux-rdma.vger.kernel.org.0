Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6D446E079
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Dec 2021 02:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237537AbhLIBzp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Dec 2021 20:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbhLIBzo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Dec 2021 20:55:44 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63729C061746;
        Wed,  8 Dec 2021 17:52:12 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso3660439pjb.0;
        Wed, 08 Dec 2021 17:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7GbdjZpxKTr+cBu8MjLxoryaXfwCf7opXnqUnViTzNc=;
        b=F83septNLKOqgSu+uZdyZjycU+/4KrErD+Ww20pcA8eGWEw1MccyDneFYqExumLgBx
         8wjpjBOG5V8xXZOQQ1uNfTWL9eu0TibC5RDyd6iNakufUC9kXX+O8g3jc0wlU0iEAxJh
         LhZaESTCQrVU0Q0/R6MI5zE+gLhWzvQuAAsjkFVCp6DAPSsZBkscbWh23IGVuHNuVoJ2
         uuZ9aU/TvY3mkGbihTQpLhQBzPlDPTTnYx4fIgB/VW1HlJaLll432RMzj9tdHAhVDSj/
         Iuq00QXAp5A0nfOaZOLvpdTL2Lrp5OXQ5wBgIXwX83xpo+d6f7zgupLKqlvzH7IEYUcO
         Tk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7GbdjZpxKTr+cBu8MjLxoryaXfwCf7opXnqUnViTzNc=;
        b=ox6nIF8BCa10Rs+k6cqvitmMIjlphWW/dhjN1k24gtgWj0FMn2mz2RCzF1GaR9wNRx
         AO64pjK8eQiGoQ0SK8Ae+KGWIDi9MkY/tg4d02PZIW6qTucAIKJMQGycZvX0AHqWnUE3
         yltrOIsAfkM3C7kYWxQAVvS1Pg9s+X3JLMWd2KjZFHliQ6YrdzSpZyxdTgLXQUNQLtMy
         QTJAX13wA+I0xgXQ+i6oMsvLgTkDYqijBYJIYrCiSqbaJ/rxfrs9d4hJeITlTU+nczPC
         4SdiFtyCKH/uJZeXF7W6PzllGjAar4h9Na8m9UWIc+nTPDcqNCZ/Y/98Fl/rhow9RmYF
         mHGw==
X-Gm-Message-State: AOAM5336P59EA8NEoKiytGLNTcljYUTQgMWPagHtvUVz1++ua5ysywQJ
        ZcdE1Zav9L4N0RcBAvYA6Tg=
X-Google-Smtp-Source: ABdhPJw9US6Lq22zRt6rKpWC7bvPIbUiQSmSt99MlTevUlZAnPNwEmh+ahebunj4RfGhrfGp1k8Kvg==
X-Received: by 2002:a17:90a:17ef:: with SMTP id q102mr11752563pja.116.1639014732013;
        Wed, 08 Dec 2021 17:52:12 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id o124sm4605622pfb.177.2021.12.08.17.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 17:52:11 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     selvin.xavier@broadcom.com
Cc:     dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        dennis.dalessandro@cornelisnetworks.com, galpress@amazon.com,
        chi.minghao@zte.com.cn, trix@redhat.com, mbloch@nvidia.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cm>
Subject: [PATCH] drivers:ocrdma:remove unneeded variable
Date:   Thu,  9 Dec 2021 01:52:06 +0000
Message-Id: <20211209015206.409528-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: chiminghao <chi.minghao@zte.com.cn>

return value form directly instead of
taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cm>
Signed-off-by: chiminghao <chi.minghao@zte.com.cn>
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

