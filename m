Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14434303DD3
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Jan 2021 13:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392152AbhAZMzb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Jan 2021 07:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404060AbhAZMtc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Jan 2021 07:49:32 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A083C0698C3
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jan 2021 04:47:41 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id p15so9656958wrq.8
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jan 2021 04:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N2A/9nno1xl4++74y2P/uvyNiEobVCQkfqRKED5+0vc=;
        b=n3F89KI4RPSPzvDifs9N2HHAnY0itgxPIoXbCCunKRgVhzoMjqvWs5bGwjgSTIaDZl
         4hX+vBEcuS0t/XlD/3y5yAz+0aXk6Y9/c7ZEjVI3RFkVv84bWSvw4n7PJlGM3+0o0Gzi
         VHdM7cZW6wPgOORTOe/9cUM/kRTNMhki7IS4nbJyRVHI7ZuA1eTzU9t/EqSBpgV7AO45
         lv3pbMnvluHwQz87OndGZM0yJBLfMW15HEedQqOEyEoCSgF4wF2HdL0BsMgm/rXIPnR4
         F0eF6nJ/fGen4mTuzxpj1f3Ogt/ytG8ptDlpZoGFdra0/B8wx4GwQrSDGUVuWDYp3s8j
         UMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N2A/9nno1xl4++74y2P/uvyNiEobVCQkfqRKED5+0vc=;
        b=alfaJi9whuQSlvdAFnNwkLGneCA0vDXE+jdJ3bjIiDrV47LNK2GqpbFyzdzYoHJ0PW
         SH5XZz+4bSjHNoUtYnYsk3Q6nupEWipYa5L90fqFXzkwSSvjVWWL2HeQCbAyA/tAYjYP
         JJzCET1w1xKgVVIP+7e3FGKhSkLWz2vrXOxl/TnIs5oTbMZBInga/wImY80/rBtuE81q
         djAYkPCttkq+L4iyoKjVHwYCI4mQtuxS4aJf6Ye79ABuGf7b/GFEVCWRdHNnnjIcEkAQ
         fewp5R1XIHjVMzAMZsPHT/uzhR84hBSKkrXWDV3P8ZZ9UztRtr/vSC/EK4urX3BaoJmY
         cX3A==
X-Gm-Message-State: AOAM530tklZRzDehxC3w7+DRyl+vXmb7g194RkIK9NAUaVEpDJKBtoXb
        d+NDyiNznlLGma5KuQyaexRHcA==
X-Google-Smtp-Source: ABdhPJxiPW8UepCs4kGXIndFfWIti+Ug4whrJpMAhh59PCiWRXk1B6kO5m2J4IXWXVrYGGpAg0AwBg==
X-Received: by 2002:adf:cd83:: with SMTP id q3mr5883334wrj.225.1611665260142;
        Tue, 26 Jan 2021 04:47:40 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id p15sm26942190wrt.15.2021.01.26.04.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:47:39 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 04/20] RDMA/hw/hfi1/mad: Demote half-completed kernel-doc header fix another
Date:   Tue, 26 Jan 2021 12:47:16 +0000
Message-Id: <20210126124732.3320971-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126124732.3320971-1-lee.jones@linaro.org>
References: <20210126124732.3320971-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/hfi1/mad.c:1354: warning: Function parameter or member 'am' not described in '__subn_set_opa_portinfo'
 drivers/infiniband/hw/hfi1/mad.c:1354: warning: Function parameter or member 'data' not described in '__subn_set_opa_portinfo'
 drivers/infiniband/hw/hfi1/mad.c:1354: warning: Function parameter or member 'resp_len' not described in '__subn_set_opa_portinfo'
 drivers/infiniband/hw/hfi1/mad.c:1354: warning: Function parameter or member 'max_len' not described in '__subn_set_opa_portinfo'
 drivers/infiniband/hw/hfi1/mad.c:1354: warning: Function parameter or member 'local_mad' not described in '__subn_set_opa_portinfo'
 drivers/infiniband/hw/hfi1/mad.c:4919: warning: Function parameter or member 'out_mad_size' not described in 'hfi1_process_mad'
 drivers/infiniband/hw/hfi1/mad.c:4919: warning: Function parameter or member 'out_mad_pkey_index' not described in 'hfi1_process_mad'

Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/hfi1/mad.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/mad.c b/drivers/infiniband/hw/hfi1/mad.c
index 3222e3acb79c6..e2f2f7847aedc 100644
--- a/drivers/infiniband/hw/hfi1/mad.c
+++ b/drivers/infiniband/hw/hfi1/mad.c
@@ -1341,7 +1341,7 @@ static int set_port_states(struct hfi1_pportdata *ppd, struct opa_smp *smp,
 	return 0;
 }
 
-/**
+/*
  * subn_set_opa_portinfo - set port information
  * @smp: the incoming SM packet
  * @ibdev: the infiniband device
@@ -4902,6 +4902,8 @@ static int hfi1_process_ib_mad(struct ib_device *ibdev, int mad_flags, u8 port,
  * @in_grh: the global route header for this packet
  * @in_mad: the incoming MAD
  * @out_mad: any outgoing MAD reply
+ * @out_mad_size: size of the outgoing MAD reply
+ * @out_mad_pkey_index: used to apss back the packet key index
  *
  * Returns IB_MAD_RESULT_SUCCESS if this is a MAD that we are not
  * interested in processing.
-- 
2.25.1

