Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B393A21538E
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2020 09:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbgGFHyd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jul 2020 03:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbgGFHyc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jul 2020 03:54:32 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4C4C061794
        for <linux-rdma@vger.kernel.org>; Mon,  6 Jul 2020 00:54:32 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r12so39664761wrj.13
        for <linux-rdma@vger.kernel.org>; Mon, 06 Jul 2020 00:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UrUOSYUSIjSV0j+I0GgzPG+VjdWB+FhZMQ6SV5deoPo=;
        b=IUe3TFA59C36cVENHn59cr+SAmgPOsQ9khgIFsduFRsDFof5HibM7FeHFEcL2SJaE1
         T6Rk4n1P3pQDIEwhrxabATrAuPjNsZ5p50z2r9ZkMgd+FW9wM5GpJZfHBMKGxWXtae3C
         LDA8uUT39aUpugLJZCxu5UXMXGBt04hDAe7HqgRLOggV7DNMqjkNC/8RbQ8EYl+W4Tou
         62k7bRGlbR1DpbPvDE4nG9pBjGQw5V7JQTp0+MTqlTmtnwGBwcjGwYmVzTfcz9k/HbxW
         GfAdI5TUlSONhHiYCZ7e3FLBWJAVTMSwuqTXNpdnMYcgMN2SiRt7RgHahguonuix7Nxe
         19Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UrUOSYUSIjSV0j+I0GgzPG+VjdWB+FhZMQ6SV5deoPo=;
        b=M+Q7OhwWTUpnggRwcv4A5JCJS9x30ET0Gh4eF9RaYVafpyyH3/w/lIBcUGAm7HzWXs
         8s3TAJncvexpAfLG3ECXK+XR8pkhQK8SqOlTA1kBSuyXioLP5MDEHIs8ZwPB5LB86s7t
         3NlzFgWkR2+kdm0pTmzW6TbIEYRUI9a2elvzSb0MMrzJK/oxMRuRLPqBYT4gXfwUHHFj
         c4GiWu0tFAKEh3SjoG8SDnWZl5kAOXaYJp+nyRV2WsMtS43dwDO8TnRAMCqNxMeXUM3Y
         3bz4R5F1BPmd0lXUr3XxECI2fSAHDAfLsAkOU1eI+V9XoVQH5VdZ3Yx2lTLpbwaI3FUX
         tq9Q==
X-Gm-Message-State: AOAM531fpuinhrB0FJa+NDqAQ4/+Vt+7i4ps0GE+FqBr47BIQAoMZscg
        yWKx0ppekCDVa9RAP+KeQ2wZ6PDax8s=
X-Google-Smtp-Source: ABdhPJzDwYoht7SVWaxEcop9RSJSOVa0h0/PgrJtH0XaLXE0DvxP8busictM5aeLMq35ISLIFuYVmA==
X-Received: by 2002:adf:edc6:: with SMTP id v6mr47791315wro.413.1594022071128;
        Mon, 06 Jul 2020 00:54:31 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id g145sm15028147wmg.23.2020.07.06.00.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 00:54:30 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Kamal Heib <kamalheib1@gmail.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>
Subject: [PATCH for-next 3/5] RDMA/cxgb4: Set max_pkeys attribute
Date:   Mon,  6 Jul 2020 10:54:17 +0300
Message-Id: <20200706075419.361484-4-kamalheib1@gmail.com>
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
of partitions supported by the cxgb4 device.

Fixes: cfdda9d76436 ("RDMA/cxgb4: Add driver for Chelsio T4 RNIC")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
Cc: Potnuri Bharat Teja <bharat@chelsio.com>
---
 drivers/infiniband/hw/cxgb4/provider.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index 1d3ff59e4060..275b77234a22 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -298,6 +298,7 @@ static int c4iw_query_device(struct ib_device *ibdev, struct ib_device_attr *pro
 	props->local_ca_ack_delay = 0;
 	props->max_fast_reg_page_list_len =
 		t4_max_fr_depth(dev->rdev.lldi.ulptx_memwrite_dsgl && use_dsgl);
+	props->max_pkeys = 1;
 
 	return 0;
 }
-- 
2.25.4

