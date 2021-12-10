Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E89146F898
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Dec 2021 02:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhLJBga (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Dec 2021 20:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhLJBga (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Dec 2021 20:36:30 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363D1C061746;
        Thu,  9 Dec 2021 17:32:56 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso6362107pjb.0;
        Thu, 09 Dec 2021 17:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5RHfxZQHw+AdOCOtGDwVgCeqNnneg9aRHNwz/Fzj1wg=;
        b=luZfHAUUvVW9mswdpUzRn7G5S4P7l06u+V5i2APzF0wXPbO8vaI5y/qRlPEIdwnsDe
         sdPXDnkfYNSIuLdO3tCocqPxF14Tg31ze2TeZfD7DnNLKYUU3sTb0LurhTNUnf3HZOiL
         2p10xWYewyNDoGkIINt3laIvyHFXZrDmXDLzAGlJhMoWC0B6R0NqQAOUSFxk5wHqAT2J
         mUf6Od4Vh2CqEcEHDiBgV+K13m8fmARPCjPv2+vYPSzg2XmiGyM8ZJ9Oxlorj51uBH1t
         M7vhPCQZCVbfdnH3ak159Esxj07oVGi1DaXUTgj/pMvZmNF6dYGyt1Prg4k4Lh9/PR8A
         i+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5RHfxZQHw+AdOCOtGDwVgCeqNnneg9aRHNwz/Fzj1wg=;
        b=jSc4Kn1Pu5VyW/OoW3uliULHFn6/QKZ7maoMm0CC99ONXhGCka8QyWbVtxDtH82asO
         GNSAEiz1mtdEKRH9tFtu0VOyK8FYSDA0xDlu0exDXhca/EIaKO0U41P5oOxfjODMlpWl
         UamtgsgB7rUPJo3B3Zw4Ae78TpjkSXJdvL2bhuQtdZU5m4MU0DPGcjA7j4HCSTxDF3+g
         cM9xK2uYAyPMfuBeFdaKTFsMG4qA4vXljwUL8/CVZiWeS2nfpUm8k0+W9yu9g+0oCeZU
         jY90BVI0AqjJgQk0fXugl8T3JdzfvBPihPkGo2hUsfquz/BGojscKkXHcWIriuCxKXin
         iCKw==
X-Gm-Message-State: AOAM533dYdFnyBwXy9c4RsBbhZ4ESWTXTbxoLVSuGoE7735YVXuYaLOs
        5Ua0s6jOqY6gK0t05gDYHlY=
X-Google-Smtp-Source: ABdhPJxaCntVMzov0NFSeV797YDHcQ8NJ3/U0+rVV4sTttoDptbzBT4ywCuOpKvcrsA6FsyROTWtpA==
X-Received: by 2002:a17:902:ec04:b0:143:b9b8:827e with SMTP id l4-20020a170902ec0400b00143b9b8827emr70884804pld.54.1639099975795;
        Thu, 09 Dec 2021 17:32:55 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y28sm875656pfa.208.2021.12.09.17.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 17:32:54 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     trix@redhat.com
Cc:     cgel.zte@gmail.com, chi.minghao@zte.com.cn,
        dennis.dalessandro@cornelisnetworks.com, dledford@redhat.com,
        galpress@amazon.com, jgg@ziepe.ca, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        mbloch@nvidia.com, selvin.xavier@broadcom.com, zealci@zte.com.cm
Subject: [PATCHv2] drivers:ocrdma:remove unneeded variable
Date:   Fri, 10 Dec 2021 01:32:47 +0000
Message-Id: <20211210013247.423430-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <260ff018-bf5b-07da-6988-c65c04f5bcb5@redhat.com>
References: <260ff018-bf5b-07da-6988-c65c04f5bcb5@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return status directly from function called.

Reported-by: Zeal Robot <zealci@zte.com.cm>
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

