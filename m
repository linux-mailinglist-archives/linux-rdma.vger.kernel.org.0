Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E33303DDD
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Jan 2021 13:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403819AbhAZM4A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Jan 2021 07:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404103AbhAZMuG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Jan 2021 07:50:06 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2D5C08EB2F
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jan 2021 04:47:56 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id 6so16315420wri.3
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jan 2021 04:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qncZWHsLqXASAb7WKMbAV3gMhi+sjt/v/oNjYxknz8Y=;
        b=NcIYoCqk3hUpJsDz9SfdkAFaGLumlfnhs1YR/p42LL4vdvcjB2Eylpt+wA4f29kfkP
         CnK8TqZJRq5EhPZC3C08uNaS6L1lQUUyQMNtJY7ZZRD272gVCXsN2syn8JMbHMaBDnKE
         +Zo0/q3WAI9LRKYTb009yKJp9wC/l9NiVdRHZxxuTcE+65GJe7cJ34P92CpIsfsqvDUs
         5yfGbi+jUUpxu2rjM6Mj8QzLrBJG3HGsOPOaqhq5LnjHt07Pz27iTBXBwgFYogkJlPCW
         /h2fFdUF76tANhPTf+RBKYSyJmvt1ha93oyPlHNs8BQK34/6Uz1ZjJmgjDyEiQpm3uz5
         kmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qncZWHsLqXASAb7WKMbAV3gMhi+sjt/v/oNjYxknz8Y=;
        b=rGnRq/NDtvY3A9IckeErp5LvkG4ybD29hFAU40LVHyJm47UncFs+tru2llg7ih8qkA
         aiVdsP9D2ctk4AF31eSeUITR8Q1lz8eV5uauEYIGPD0vdZ61Wif52lpZDTFx2mbh01j5
         aP5W5Zz/wqIFzbGobmVBI0Myl3VqD00nkMBpGYhZJTb+fZglQrVOWSiHrS5r9V6d4XBs
         wiY6kw033MWqDt+wUEZuZUhRJiSHALg4ZIo3kXumVT2th9L+HIyw2vJoFYkCrNZSxWfP
         VvkW2u5D1jXILZNNW8xIIMRCKzpuQ5jXpCeBUwalO/XXHyazABKxPq0QQfzSdiqD99w9
         x19A==
X-Gm-Message-State: AOAM532pvood0dgnuyK2fXf/IzZCFPVPSZ9tkxjxzRoTWr+0a4sr8Bk+
        ezYSWuj4qg90bMJk0Owr8GonLA==
X-Google-Smtp-Source: ABdhPJw2xjb1RdcsnXKRATtfdI88n+CathRcAI2SOo030+I1jUS4DZ75Hx3+2ch6KS6QY4E5AZ7xIg==
X-Received: by 2002:adf:dd45:: with SMTP id u5mr5869894wrm.392.1611665275238;
        Tue, 26 Jan 2021 04:47:55 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id p15sm26942190wrt.15.2021.01.26.04.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:47:54 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 17/20] RDMA/hw/hfi1/ud: Fix a little more doc-rot
Date:   Tue, 26 Jan 2021 12:47:29 +0000
Message-Id: <20210126124732.3320971-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126124732.3320971-1-lee.jones@linaro.org>
References: <20210126124732.3320971-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/hfi1/ud.c:477: warning: Function parameter or member 'ps' not described in 'hfi1_make_ud_req'
 drivers/infiniband/hw/hfi1/ud.c:855: warning: Function parameter or member 'packet' not described in 'hfi1_ud_rcv'
 drivers/infiniband/hw/hfi1/ud.c:855: warning: Excess function parameter 'ibp' description in 'hfi1_ud_rcv'
 drivers/infiniband/hw/hfi1/ud.c:855: warning: Excess function parameter 'hdr' description in 'hfi1_ud_rcv'
 drivers/infiniband/hw/hfi1/ud.c:855: warning: Excess function parameter 'rcv_flags' description in 'hfi1_ud_rcv'
 drivers/infiniband/hw/hfi1/ud.c:855: warning: Excess function parameter 'data' description in 'hfi1_ud_rcv'
 drivers/infiniband/hw/hfi1/ud.c:855: warning: Excess function parameter 'tlen' description in 'hfi1_ud_rcv'
 drivers/infiniband/hw/hfi1/ud.c:855: warning: Excess function parameter 'qp' description in 'hfi1_ud_rcv'

Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/hfi1/ud.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/ud.c b/drivers/infiniband/hw/hfi1/ud.c
index e804af71b629d..6ecb984c85fac 100644
--- a/drivers/infiniband/hw/hfi1/ud.c
+++ b/drivers/infiniband/hw/hfi1/ud.c
@@ -468,6 +468,7 @@ void hfi1_make_ud_req_16B(struct rvt_qp *qp, struct hfi1_pkt_state *ps,
 /**
  * hfi1_make_ud_req - construct a UD request packet
  * @qp: the QP
+ * @ps: the current packet state
  *
  * Assume s_lock is held.
  *
@@ -840,12 +841,7 @@ static int opa_smp_check(struct hfi1_ibport *ibp, u16 pkey, u8 sc5,
 
 /**
  * hfi1_ud_rcv - receive an incoming UD packet
- * @ibp: the port the packet came in on
- * @hdr: the packet header
- * @rcv_flags: flags relevant to rcv processing
- * @data: the packet data
- * @tlen: the packet length
- * @qp: the QP the packet came on
+ * @packet: the packet structure
  *
  * This is called from qp_rcv() to process an incoming UD packet
  * for the given QP.
-- 
2.25.1

