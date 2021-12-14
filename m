Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC29473F4A
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Dec 2021 10:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhLNJYO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Dec 2021 04:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbhLNJYO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Dec 2021 04:24:14 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CFFC061574;
        Tue, 14 Dec 2021 01:24:13 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id t83so16191308qke.8;
        Tue, 14 Dec 2021 01:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tO3oLVLiYviq2gfBru+LpmUxBMb3sMWLvQFjnMLNDe4=;
        b=mrt6U7/YJQPI3XgxuMtJ0tPxl5B5hhb/XZBDs1/QunciXX+VmE42nZDg6dFktXW2hK
         lxo0urMD4v8HPy9A8OPKfHCNiZZYO6+e1ij18rccZn02AA8DwOxuZVHHOLn+wG75AIA6
         F6ZaOVkGZz1WPNrv+O0Vo2D8VX3t4piGIP8OsNvW9PZuTfg2JLcq+wqBVlutdluegTkB
         vsYfmawt7q93KUArr3AwlP4yY16VjFbtwMviZd+kouqiyfpFyiaqT0yq5R8w9/83fJQi
         PdAqWbL5YU9ZFw5PJIkS3lUTlBJ+dnPa/3p/mFxS4XizXeD52TI/FsYdHf+Dx9ugffrc
         Jixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tO3oLVLiYviq2gfBru+LpmUxBMb3sMWLvQFjnMLNDe4=;
        b=ca56fU3NzArA1H2ZQ2D7C5AhUJePvdalCV4yuMxo8IMNfXnX4Z5RXb9xMK9FJE4QoB
         ZRMYpE09KhqQgXSycwy3h0wOpMshvxJ6mnWoT6A/Lqm1xUkXv+M9WajiOP/eJ1TvsIGl
         aBQJ80Z2ehRHxBZqhOpcPA2GPO/Fbin5DaPpmP9ELcFFfGQevYCWIvieC9/PqXSXGeAv
         fxfuvl2s4x19tL6lNLao3PHYxkRAD2tRC85G8yhFI1m2RmqS5lOcP7SteOIsj0huf65S
         Jdh5P/84ooWxA9xw9IFOUp0UaqCRYGNzN66ySPh24kpMbiqQFxacf8pO6r5JdybfECny
         HNsg==
X-Gm-Message-State: AOAM533kJHNQcRd1bDmNcJzrMZid1eK6m/jgaPtyx0eXPbSxEI0wkrL6
        2MdJCSfZywl1zgOtGcrnTL8=
X-Google-Smtp-Source: ABdhPJxlvgMQR+v2y92s5Ja6LVK1LOA3wJZBFRth6NWIdjOy8uQb+9iCN/Y9nhsyLA9M4xEsl0/jOw==
X-Received: by 2002:ae9:e20b:: with SMTP id c11mr2978128qkc.230.1639473852992;
        Tue, 14 Dec 2021 01:24:12 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x16sm7341359qko.15.2021.12.14.01.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 01:24:12 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     devesh.s.sharma@oracle.com
Cc:     cgel.zte@gmail.com, chi.minghao@zte.com.cn,
        dennis.dalessandro@cornelisnetworks.com, dledford@redhat.com,
        jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, mbloch@nvidia.com,
        selvin.xavier@broadcom.com, trix@redhat.com,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH for-next v4] RDMA/ocrdma: remove unneeded variable
Date:   Tue, 14 Dec 2021 09:23:39 +0000
Message-Id: <20211214092339.438350-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CO6PR10MB5635347074DDA51CF2766B9DDD759@CO6PR10MB5635.namprd10.prod.outlook.com>
References: <CO6PR10MB5635347074DDA51CF2766B9DDD759@CO6PR10MB5635.namprd10.prod.outlook.com>
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
change since v2: [PATCHv2] drivers:ocrdma:remove unneeded variable
             v3: [PATCH v3 ocrdma-next] drivers: ocrdma: remove unneeded
variable
             v4: [PATCH for-next v4] RDMA/ocrdma: remove unneeded
variable
Thanks!
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
index 735123d0e9ec..3bfbf4ec040d 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -1844,12 +1844,10 @@ int ocrdma_modify_srq(struct ib_srq *ibsrq,
 
 int ocrdma_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr
*srq_attr)
 {
-	int status;
 	struct ocrdma_srq *srq;
 
 	srq = get_ocrdma_srq(ibsrq);
-	status = ocrdma_mbx_query_srq(srq, srq_attr);
-	return status;
+	return ocrdma_mbx_query_srq(srq, srq_attr);
 }
 
 int ocrdma_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
@@ -1960,7 +1958,6 @@ static int ocrdma_build_inline_sges(struct
ocrdma_qp *qp,
 static int ocrdma_build_send(struct ocrdma_qp *qp, struct
ocrdma_hdr_wqe *hdr,
 			     const struct ib_send_wr *wr)
 {
-	int status;
 	struct ocrdma_sge *sge;
 	u32 wqe_size = sizeof(*hdr);
 
@@ -1972,8 +1969,7 @@ static int ocrdma_build_send(struct ocrdma_qp *qp,
struct ocrdma_hdr_wqe *hdr,
 		sge = (struct ocrdma_sge *)(hdr + 1);
 	}
 
-	status = ocrdma_build_inline_sges(qp, hdr, sge, wr, wqe_size);
-	return status;
+	return ocrdma_build_inline_sges(qp, hdr, sge, wr, wqe_size);
 }
 
 static int ocrdma_build_write(struct ocrdma_qp *qp, struct
ocrdma_hdr_wqe *hdr,
-- 
2.25.1

