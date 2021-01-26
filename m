Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBDC303DD2
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Jan 2021 13:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731937AbhAZMz0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Jan 2021 07:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404067AbhAZMtc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Jan 2021 07:49:32 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5B2C0698C5
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jan 2021 04:47:42 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id a9so16322412wrt.5
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jan 2021 04:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5iSr6BVX0vLsZ6XbdKfpACTjI5e2CvJxacmXWu0DW1o=;
        b=f68ZTT5BAx8LNsgLSWm/TjA2tIVW26h6lNl+CnoQEtts8XlWcVHbIzA6GJQeyq3TyT
         puEHbfG0J4EZKkEyTDgAraOOa/BZooJ6LvvY7nZDW6VDOaafEuSJOV1jhSkbqk244pwK
         idPuhasszf5w3/gQfZFkcQ3CmH/4RF02z5w6H9rm1ifn1t58GjQcdZUNSe4cYw8ilDNW
         SzqLU+TmgRluyNbUptpAmsTp00jH/i2Atp3qjH1lQeUMTo+9NR89ZPwAjm+Lw9LEHN3Q
         f8U7Hq2N99WZDlIycYqNcfutBXXYaoMPkzuxtXkl9Sv8he3llLKvltIjw4Yaix9P/x4u
         +LwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5iSr6BVX0vLsZ6XbdKfpACTjI5e2CvJxacmXWu0DW1o=;
        b=nQ5npi5CgqdLGmCU9gT1W/3hnvw0FlE0KIoePeKfXpgl5/n39wqV97nRfbs3K+06AU
         J0k0WmueJDQSv3nlgl498lBpMojEouXc/mrM48gFRJZ9jF3VuxXbvPh8xQj5+FOHTiia
         6UpEI9cJAY0Qqg0SspzkcZm38EaC+qP2dq4b/RBXfnMH25fn4B5ZBdB5XQBX9ToJXmym
         fvepqa53rTpBWoUgU1aJX6zWn1KvMl7UOsE7acORqn5ObOnmMLm7B+EtiBaySDEWQokf
         cGDsUVABxw1vIPosxg2EY/djlO24d9HaVIYHjIPh0GJJFlWMO64HzHdaK3pDbqlbZ6xf
         h1sg==
X-Gm-Message-State: AOAM5319gaR3bEW2kPgm/iL+08hPlzk1pPmkar92jm/tOT9jPx1PSlxd
        3tgmU2Neth8TOpFm9IwtOZv1wQ==
X-Google-Smtp-Source: ABdhPJx6VwGxc6iFcBAt+2Q5SwbgbOSyw8EcYP6v7CxipTnjTDMcohXo8wuR7p0/yZ1LW2zXgB4wiA==
X-Received: by 2002:adf:f403:: with SMTP id g3mr5943028wro.212.1611665261306;
        Tue, 26 Jan 2021 04:47:41 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id p15sm26942190wrt.15.2021.01.26.04.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:47:40 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 05/20] RDMA/hw/hfi1/msix: Add description for 'name' and remove superfluous param 'idx'
Date:   Tue, 26 Jan 2021 12:47:17 +0000
Message-Id: <20210126124732.3320971-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126124732.3320971-1-lee.jones@linaro.org>
References: <20210126124732.3320971-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/hfi1/msix.c:120: warning: Function parameter or member 'name' not described in 'msix_request_irq'
 drivers/infiniband/hw/hfi1/msix.c:120: warning: Excess function parameter 'idx' description in 'msix_request_irq'

Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/hfi1/msix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/msix.c b/drivers/infiniband/hw/hfi1/msix.c
index d61ee853d215c..cf3040bb177f6 100644
--- a/drivers/infiniband/hw/hfi1/msix.c
+++ b/drivers/infiniband/hw/hfi1/msix.c
@@ -103,8 +103,8 @@ int msix_initialize(struct hfi1_devdata *dd)
  * @arg: context information for the IRQ
  * @handler: IRQ handler
  * @thread: IRQ thread handler (could be NULL)
- * @idx: zero base idx if multiple devices are needed
  * @type: affinty IRQ type
+ * @name: IRQ name
  *
  * Allocated an MSIx vector if available, and then create the appropriate
  * meta data needed to keep track of the pci IRQ request.
-- 
2.25.1

