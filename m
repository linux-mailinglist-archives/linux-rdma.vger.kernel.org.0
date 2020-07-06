Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1F321538C
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2020 09:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgGFHya (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jul 2020 03:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbgGFHya (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jul 2020 03:54:30 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC881C061794
        for <linux-rdma@vger.kernel.org>; Mon,  6 Jul 2020 00:54:29 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f18so40839627wml.3
        for <linux-rdma@vger.kernel.org>; Mon, 06 Jul 2020 00:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=obqxZdmR/t8xL2rXeSpVqMlK6yXRRmMUtovmoH9E5NE=;
        b=kkezu5KkJsC3VHWCPzlu3h8h5g/j/2iCyi+Ofcb90ZNxLXJTLXqK2bmKmRxz6WdFld
         Ueof0tXzlLlai8vvQi2T1jQp7uAMT5v6Ymhj4lCk633o7bOK0A2Y05g7BP0/MYS0mOjI
         PvTAiyok/RsFMmpd6/PPBAb6spTMV97555JrFwgKmD0B9bu1sR1+1bDtF37SPUJ8HBaB
         MP5sI69bzrHgouPSoFkbuhMyYoxkjF3wuLBinP2AfClckfG8y92DVHWwQEYVnFzg5sOW
         xYspJUct/yD4i+TdmUgZKITUj5LahgbjU2noyqD0Z4dYanMN5oNVtDf1NuO7h9duxybf
         vx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=obqxZdmR/t8xL2rXeSpVqMlK6yXRRmMUtovmoH9E5NE=;
        b=ju4csJhes4ItyjnnFJs8UjQokDs5yJGO+UYv/Q9WNR+Lx671o7Ym3MBRO9RoeLLUiJ
         erACAriCCveE+w2F7/1DFVe9f19OhXmnVC6DIE1EQRdyrXPCGMPsdcvhYMEBe3Qt4KN1
         Bw1OUt6tAzJzqxxfoyBlIcXJ9eo6Or7hz9VduxYXS2BHTrsBg5mOTzKDpBSioIKQlJhd
         5mjV2pnV1EHVQozOpG4HVH/AAThToPnWfge0WsSFlgvDCL1T8la/IptMbvSqTjuecfTC
         Xrl0b0S4oKIGehY7faMH1Wu/HJUL+hGz6DUTbYvLIy5Kf3l+XeMLMv6d9N/HfEanmwfo
         UK5g==
X-Gm-Message-State: AOAM533iunmTJ+irfVXtUkh9Dlu4fn5jccAQPr9dpQC50l8IdgwCnp9c
        okIGq6TolHylxBZpTQ0PxWtgyOadrJo=
X-Google-Smtp-Source: ABdhPJzWqSeFWvKooLiJxGsd1c4zBuY0WHxH3MUrIcrn4BeBN0b75n3COTqHjxCEGi2HQ+qSlWBltw==
X-Received: by 2002:a05:600c:2154:: with SMTP id v20mr52034151wml.185.1594022068475;
        Mon, 06 Jul 2020 00:54:28 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id g145sm15028147wmg.23.2020.07.06.00.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 00:54:27 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Kamal Heib <kamalheib1@gmail.com>,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH for-next 1/5] RDMA/siw: Set max_pkeys attribute
Date:   Mon,  6 Jul 2020 10:54:15 +0300
Message-Id: <20200706075419.361484-2-kamalheib1@gmail.com>
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
of partitions supported by the siw device.

Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
Cc: Bernard Metzler <bmt@zurich.ibm.com> 
---
 drivers/infiniband/sw/siw/siw_verbs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 987e2ba05dbc..bef35d566aee 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -151,6 +151,7 @@ int siw_query_device(struct ib_device *base_dev, struct ib_device_attr *attr,
 	attr->max_srq = sdev->attrs.max_srq;
 	attr->max_srq_sge = sdev->attrs.max_srq_sge;
 	attr->max_srq_wr = sdev->attrs.max_srq_wr;
+	attr->max_pkeys = 1;
 	attr->page_size_cap = PAGE_SIZE;
 	attr->vendor_id = SIW_VENDOR_ID;
 	attr->vendor_part_id = sdev->vendor_part_id;
-- 
2.25.4

