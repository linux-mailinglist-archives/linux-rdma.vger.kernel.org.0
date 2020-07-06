Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF5C21538D
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2020 09:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgGFHyb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jul 2020 03:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbgGFHyb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jul 2020 03:54:31 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A727C061794
        for <linux-rdma@vger.kernel.org>; Mon,  6 Jul 2020 00:54:31 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r12so39664695wrj.13
        for <linux-rdma@vger.kernel.org>; Mon, 06 Jul 2020 00:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bDiCsTKJYT1dBvgYvF0oPh5E3DjsarKR+VvD0dD7xPY=;
        b=ryq9UCHXxVmVhcCSxrAsRiMkH5TeEONo732oloGdXzutVjAiIL4skL8NwfIUA7To2t
         PoURnbsKFqQK4yDVyxKVKqZMTBK/Zd2lebL6SaCsZpKjDGA3J8aKSMDZv96BB1j1iVVw
         5Apc+W/w2iYCzXJnv/hLxRvJ06hNYRLmQqb5xqcIuUxLlOEZoMzNt5jYetXbFTr9RS6T
         X7sY2LgOGyBqRmuORhMpHMZ5Yy93ffvwm4iQln1VJkoD8hw5T/2S+SdJnZlp/Nxqx/8b
         eG7jFI3Y8F8ISijzzfuX8JYhemqjtUdZV4vEOUnhy6I1UL1kg6UY1cxq9XwDREzAAkVp
         rr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bDiCsTKJYT1dBvgYvF0oPh5E3DjsarKR+VvD0dD7xPY=;
        b=RBFCuo/cyOa4dhOP/HAUz0uRvPBYBKbu9u0N2PgwlL3XpUaRb/yhZ5DLYajAImP3pL
         7ZEEP/xLgus+s30ol3au8U0w62Qzg6LygxY7ODJwQt0D18eL5twc0xpcbJRs/SZQvuuG
         BJ/YqXARUNvSsaH2Z5Hzlru+7T/0rNMSGju6tsm5yOIfyJIVVGVYcfvM02luJtzX+HDM
         Qn93QY3EPqRR7ECD8Z7pWBSj7eyFKRaAtnUiiOSFIPvXu2bn1eawOl0kOCixiONLstvb
         QjUtQTC2s8Gx5tc9EZC2W0vN2Na81fsSBLFdpUWZtxxW1DmNz+2jHL7iqK6oIsZf2j/j
         AY2Q==
X-Gm-Message-State: AOAM530Aa2XxvfY0nBWLhBah3nqumeHRNAw1Y43D+qKik1amnA0CMr4L
        IFI/qMamNshjUCUy3QWHsT1i9iP3BNs=
X-Google-Smtp-Source: ABdhPJyeljPh4NsiGIawG97hd/NnmNEVaB+bKo6iDZR+RgW+JHje0XcGoBDDCVgIjpmZr+oJxorOtA==
X-Received: by 2002:adf:84e2:: with SMTP id 89mr49361415wrg.139.1594022069774;
        Mon, 06 Jul 2020 00:54:29 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id g145sm15028147wmg.23.2020.07.06.00.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 00:54:29 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Kamal Heib <kamalheib1@gmail.com>,
        Gal Pressman <galpress@amazon.com>
Subject: [PATCH for-next 2/5] RDMA/efa: Set max_pkeys attribute
Date:   Mon,  6 Jul 2020 10:54:16 +0300
Message-Id: <20200706075419.361484-3-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200706075419.361484-1-kamalheib1@gmail.com>
References: <20200706075419.361484-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Make sure to set the max_pkeys attribute to indicate the maximum number
of partitions supported by the efa device.

Fixes: 40909f664d27 ("RDMA/efa: Add EFA verbs implementation")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
Cc: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 08313f7c73bc..7dd082441333 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -212,6 +212,7 @@ int efa_query_device(struct ib_device *ibdev,
 	props->max_send_sge = dev_attr->max_sq_sge;
 	props->max_recv_sge = dev_attr->max_rq_sge;
 	props->max_sge_rd = dev_attr->max_wr_rdma_sge;
+	props->max_pkeys = 1;
 
 	if (udata && udata->outlen) {
 		resp.max_sq_sge = dev_attr->max_sq_sge;
-- 
2.25.4

