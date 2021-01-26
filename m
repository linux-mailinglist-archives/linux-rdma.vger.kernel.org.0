Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06001303DDA
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Jan 2021 13:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404083AbhAZMzt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Jan 2021 07:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403819AbhAZMuG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Jan 2021 07:50:06 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F18C08EB2C
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jan 2021 04:47:55 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id u14so2632514wmq.4
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jan 2021 04:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Be3Y0oHERhBykNWLBE00Jhbr48e+dcSVLp5rjpoZalM=;
        b=nkKmRuPQ9fIGmXOz5PMoJpeLhxuHTI96jpBNkOuLMEn4TTFO222OBWpIESVSPRHtFl
         PTEqnyYjB0yBuuI9+/GsQVw7zWh11U9IUlgc9tvvguKLEbiQpJ62s/Q5NWTBILJIYY6T
         LJBVKCBdC6l2h/epGGvz1OEuLNJgP7RcUjlgowV+4iiseyPL0vkZHwXt6ug/0tr/TZBZ
         OOzacdCTeTi1cCOHKu15kjxFJ+H/MZbXVxNH2D5JsbcTDRrL2iOAtScetqOgGKh4uRgG
         fleiAAnIrMMq2zf7bS/8sThB6hIqGq7OpT9KfldthUBdOkE8rCZUkKGbJdCjFkTpas4N
         Hycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Be3Y0oHERhBykNWLBE00Jhbr48e+dcSVLp5rjpoZalM=;
        b=IRoJqxKGun+hb7DqhXFKQukyWp8TDxI3Yflj938lyilrI62QZen+dZ8n5XGjXAyR8r
         GUQjoOBkYvakhEK/xEzFUixOIxe8w/zuWk9EA+gS5zUbdY8x3n0vl7NpHG+5d/y5SEsY
         nCA4DP4DCprl4UDIF+fkkUoY06OIF6Rij71OnlylnTdkAN6ZD/VKHVXm6V919oMh96T5
         id6NMHivX41HdS3nWh4lM9vAQ8RVLeIvmJmY0OMGIZOIpyQIm2QIePSL8kz3kyZNz7Hg
         tEb101qCuSg/DQ/2lzQkwom3x/PC00AZ9OFQih1x9YyAePBgqYXzo+4GXoBZDF2WAbTe
         Hghg==
X-Gm-Message-State: AOAM532tDdwGPX0ED/bIIa1BzHlPMnnsT+/xJAoSZxU0o/GOeBhjPGJe
        BSJmn/3yn4tBXiKG3GdMCPgo/A==
X-Google-Smtp-Source: ABdhPJy2R6IQ3V4KzwwBbMw7q+XXRTmfbultk90lXNGqksnMEK+Qzto0w37XWK1lRD227zQYOQFc8g==
X-Received: by 2002:a1c:770d:: with SMTP id t13mr4518211wmi.35.1611665274061;
        Tue, 26 Jan 2021 04:47:54 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id p15sm26942190wrt.15.2021.01.26.04.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:47:53 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 16/20] RDMA/hw/hfi1/uc: Fix a little doc-rot
Date:   Tue, 26 Jan 2021 12:47:28 +0000
Message-Id: <20210126124732.3320971-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126124732.3320971-1-lee.jones@linaro.org>
References: <20210126124732.3320971-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/hfi1/uc.c:64: warning: Function parameter or member 'ps' not described in 'hfi1_make_uc_req'
 drivers/infiniband/hw/hfi1/uc.c:306: warning: Function parameter or member 'packet' not described in 'hfi1_uc_rcv'
 drivers/infiniband/hw/hfi1/uc.c:306: warning: Excess function parameter 'ibp' description in 'hfi1_uc_rcv'
 drivers/infiniband/hw/hfi1/uc.c:306: warning: Excess function parameter 'hdr' description in 'hfi1_uc_rcv'
 drivers/infiniband/hw/hfi1/uc.c:306: warning: Excess function parameter 'rcv_flags' description in 'hfi1_uc_rcv'
 drivers/infiniband/hw/hfi1/uc.c:306: warning: Excess function parameter 'data' description in 'hfi1_uc_rcv'
 drivers/infiniband/hw/hfi1/uc.c:306: warning: Excess function parameter 'tlen' description in 'hfi1_uc_rcv'
 drivers/infiniband/hw/hfi1/uc.c:306: warning: Excess function parameter 'qp' description in 'hfi1_uc_rcv'

Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/hfi1/uc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/uc.c b/drivers/infiniband/hw/hfi1/uc.c
index 1fb918399da06..5b0f536b34e0c 100644
--- a/drivers/infiniband/hw/hfi1/uc.c
+++ b/drivers/infiniband/hw/hfi1/uc.c
@@ -55,6 +55,7 @@
 /**
  * hfi1_make_uc_req - construct a request packet (SEND, RDMA write)
  * @qp: a pointer to the QP
+ * @ps: the current packet state
  *
  * Assume s_lock is held.
  *
@@ -291,12 +292,7 @@ int hfi1_make_uc_req(struct rvt_qp *qp, struct hfi1_pkt_state *ps)
 
 /**
  * hfi1_uc_rcv - handle an incoming UC packet
- * @ibp: the port the packet came in on
- * @hdr: the header of the packet
- * @rcv_flags: flags relevant to rcv processing
- * @data: the packet data
- * @tlen: the length of the packet
- * @qp: the QP for this packet.
+ * @packet: the packet structure
  *
  * This is called from qp_rcv() to process an incoming UC packet
  * for the given QP.
-- 
2.25.1

