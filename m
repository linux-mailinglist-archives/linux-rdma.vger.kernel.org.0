Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07FF82DB3DA
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Dec 2020 19:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731677AbgLOSgt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Dec 2020 13:36:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36602 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730981AbgLOSgo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 15 Dec 2020 13:36:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608057317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=r5Ua4K+Dl4WllndwRBRRza/dPsX4LUO4Xube6WLkAV4=;
        b=HRvwmX+8Y81VK0fZPcrYGyzJK4qe1HzEVIN2eKaLsqi7WlW0VPuAltgDGdPMkMFw5N+NZ3
        7dy80+CKb6bLZCOK+mg01hE1kxgi+2FzmTgq5XbVmQBIzC6vi91GSKLkPEwnPsltMwMLVr
        ecZJf/bVgvWPFIsSuvf43d+m2uh0l6g=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-nnWe8ny9N1q5anBzrX0zeA-1; Tue, 15 Dec 2020 13:35:15 -0500
X-MC-Unique: nnWe8ny9N1q5anBzrX0zeA-1
Received: by mail-qk1-f197.google.com with SMTP id n190so15886474qkf.18
        for <linux-rdma@vger.kernel.org>; Tue, 15 Dec 2020 10:35:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r5Ua4K+Dl4WllndwRBRRza/dPsX4LUO4Xube6WLkAV4=;
        b=DRUhgjrB5fAyo2IN63kxp+YPmfQtmVa1LCcePRHktZB/3Jh3GBvd+IWghgiZF/kjQz
         +7+DbLyj3VWPRQ9bHGnmxmhXV3zJpNqUH++Zx6304kvHaBXnUjJfoWSxxKoQPGbPzgp4
         Aynx5XG8Z+trRq5ixYEmbyzSoN2HGDAtqz3Ut1LTmmnPDWm/s4bgFP3vpzx6UcI1SuPX
         6FXkBCdWjdBNwosr5yK4dm0D4PH3gWIOJFZpo35zFpeXRXx8l6WLA3TeCUtjbjp2GmKW
         JGUuzyAZAVsWSeoKK02RQDpn+MkwL26H/4QNp2evQGMK+/yH42jMjvV6AID7sDpnNtCW
         0RKw==
X-Gm-Message-State: AOAM532icgXGgLEifWnaiAoXFxDKEhij8vJNGKXiZ0w2opyBLck/UVud
        HE6MmDr4Aew3jsxpuP1IU+XzL/8/r88iYZxQKKh5ujSxBUvsr4se2V6SqB5XrQqZEL/YDxxC/VT
        zNulg+Pes+zEo1PwHs2m/yw==
X-Received: by 2002:ac8:1282:: with SMTP id y2mr37404263qti.283.1608057314763;
        Tue, 15 Dec 2020 10:35:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzODCFZoEuN9HB288V4BnrbsFQcDXsYbbD0gwq0gP+q+tY0nHu32XRnRCz5Xrr5a8X5/pyb+A==
X-Received: by 2002:ac8:1282:: with SMTP id y2mr37404250qti.283.1608057314580;
        Tue, 15 Dec 2020 10:35:14 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id p15sm17116316qke.11.2020.12.15.10.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 10:35:13 -0800 (PST)
From:   trix@redhat.com
To:     mike.marciniszyn@cornelisnetworks.com,
        dennis.dalessandro@cornelisnetworks.com, dledford@redhat.com,
        jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] IB/hfi1: remove h from printk format specifier
Date:   Tue, 15 Dec 2020 10:35:09 -0800
Message-Id: <20201215183509.2072517-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Tom Rix <trix@redhat.com>

See Documentation/core-api/printk-formats.rst.
h should no longer be used in the format specifier for printk.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/infiniband/hw/hfi1/sdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index a307d4c8b15a..27ec2851160a 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -1740,7 +1740,7 @@ static inline u16 sdma_gethead(struct sdma_engine *sde)
 			sane = (hwhead == swhead);
 
 		if (unlikely(!sane)) {
-			dd_dev_err(dd, "SDMA(%u) bad head (%s) hwhd=%hu swhd=%hu swtl=%hu cnt=%hu\n",
+			dd_dev_err(dd, "SDMA(%u) bad head (%s) hwhd=%u swhd=%u swtl=%u cnt=%u\n",
 				   sde->this_idx,
 				   use_dmahead ? "dma" : "kreg",
 				   hwhead, swhead, swtail, cnt);
-- 
2.27.0

