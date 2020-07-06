Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4329F215465
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2020 11:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbgGFJLc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jul 2020 05:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbgGFJLc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jul 2020 05:11:32 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3BAC061794
        for <linux-rdma@vger.kernel.org>; Mon,  6 Jul 2020 02:11:32 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f139so41081323wmf.5
        for <linux-rdma@vger.kernel.org>; Mon, 06 Jul 2020 02:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=obqxZdmR/t8xL2rXeSpVqMlK6yXRRmMUtovmoH9E5NE=;
        b=BALBendonLK00zZovnxUtMYuqeQ9RA61KofSMerJzDQrVCUAFQUNqFPnu4lm+r4rnG
         pRjVHPki7kjngosLNQn0ui8Xe9rHHAX11A2fNx4gNI8z0n94jjfO41urrq631XC/Ucoz
         dYApRkU3LrOzdeAi0V2m2cjN18KhumKVy7u0awFQy5ngB4CrMp+zZOJmn/zvVyPTCqpT
         J5jdxx9CnSFJE0zGmXcP8BXWJgeCBY1lLBdxWXi8GdBq07uDmMP4Ojrb9WcncyiHFk3O
         zoNStIGVInqiwIyDhYebSc81FoBhMUirVRywlGetLCO6vFsnXE+pUngQnVmX/2QOgreA
         HHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=obqxZdmR/t8xL2rXeSpVqMlK6yXRRmMUtovmoH9E5NE=;
        b=KXCIyEY+yQ7kILQrGoRGnatPRU74ZS0yyv/RJqNN3q1zubQMsDAyd76qRxBWqM+Lca
         QzZF9oOOqmhBrIfLzu0sZF4PgptOK58UzvdujrB5yaQL2dDnsgp+8lqSj8MCQ5gSiyBL
         5CEvDK2bBEE0Nm1ozrpwguKpvexaOCR1/FFcESzBXxeZoEAmvnUGFv59Gxai6kNVWYST
         oHDfwyHM5Vbd9SD6VDISXzofuS8JGa5w3VYxfNKPV8EO9S2ydgG9LymX8E1ufK9xGusp
         b7PC+ZRmvELBKVJlYddZTJJYtlFH1BJP85FkGzfeX06npUl038tPiyoziTelvVLgBFsC
         35iQ==
X-Gm-Message-State: AOAM530WU05DO7YaMq5MsAudE0SrG9bOgYdTe1JawEi0SOK1a1EEsvKD
        757heNdXRdwqOYbYzSrNAl4DvRzAttQ=
X-Google-Smtp-Source: ABdhPJxJ7skzPo6n+/9ImhKQORLz0kksARyPeVMsx/v2+T7LogGXxlNj55NgJRH1x6yiJuZp9G40aQ==
X-Received: by 2002:a05:600c:c1:: with SMTP id u1mr49343752wmm.48.1594026690547;
        Mon, 06 Jul 2020 02:11:30 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id j4sm18826867wrp.51.2020.07.06.02.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 02:11:30 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Kamal Heib <kamalheib1@gmail.com>,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH for-rc v1 1/4] RDMA/siw: Set max_pkeys attribute
Date:   Mon,  6 Jul 2020 12:11:16 +0300
Message-Id: <20200706091119.367697-2-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200706091119.367697-1-kamalheib1@gmail.com>
References: <20200706091119.367697-1-kamalheib1@gmail.com>
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

