Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C6B303DD8
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Jan 2021 13:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404067AbhAZMzp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Jan 2021 07:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404098AbhAZMuD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Jan 2021 07:50:03 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22D8C08EB28
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jan 2021 04:47:52 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id m13so1882638wro.12
        for <linux-rdma@vger.kernel.org>; Tue, 26 Jan 2021 04:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KhBTgPPE+CNVhO1Y8qQbvF45hvKHKoqMW4XtGytDEOs=;
        b=cfwbVsKfOtrkKii2UrrmoX+t6KB5CDu+uAzLKYjRtQcEBbqL435TuCTuR0tDsfQf9q
         OFNFb0dcFT3Nj31cZ8dYKPkBktH/cvmzq6XTK3BiGAd8uBbbSEh3rDiPsC9RKyv3l7SQ
         4BnPjpapNAstilkpKahZfuvrj+bZMUjaPcRCkUNreZ5oTxQ0UzzMWjznb74RPohoGxt6
         UdQNhKDgFdIawrA1MX1txF++KP6FucsTnQWvnOlFlBHGngQh8+HkSz9iLGSdMWNmGnqN
         q2aJkdp12tgk1lcR3iiLAouxmIsPkyGtXMMFJHQyxwih8pL1cZ4WP2tZ1lshlUmsrYlK
         KjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KhBTgPPE+CNVhO1Y8qQbvF45hvKHKoqMW4XtGytDEOs=;
        b=dGUh3e6c+DzeeV/6oTt2zM2Za+bGmEMSHPyXbSYwTIcAF4J9FKXdzAT35200eo9tCN
         xbuUs389evQCActC+o6hpSq/2guDTetPY2+dUpBiQtHWe8oudjFdDhFywFUDFcm9qreb
         k5+uNWnqos8wtppvtmqmkkcSJSHS6ru52LdLdJCb2EFTrtXSOe8AjRUCVpdiRrDK3MIr
         KnjadsvKl82c479Y3BUaa7SDVEt4EDlZ0aH+daY4W3Y9uPXEu5vWuszR8PgQ0lVHsFNl
         5NvIdwInFfbeW8+va5tO3btCrUBmLxAYp+M5V1IOvxO3BcK29cV4fZkgnyikdgXMGsUE
         TVuQ==
X-Gm-Message-State: AOAM533XwbLSIZL3n3wKHStrpT0cnEKbaSOzaoF/3BS7esfgOLOyExuw
        Wt5oyRsG9xcseB3O8ZY/gs0r4Q==
X-Google-Smtp-Source: ABdhPJwxtpN3OCMIXfq63j1dD0WyBcmrYv3dGBVioIP73N0G/bUoqDHuRDPVnuAEsTGDpRWGjGQASQ==
X-Received: by 2002:a5d:4243:: with SMTP id s3mr5900388wrr.31.1611665271660;
        Tue, 26 Jan 2021 04:47:51 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id p15sm26942190wrt.15.2021.01.26.04.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:47:51 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 14/20] RDMA/hw/hfi1/sdma: Fix misnaming of 'sdma_send_txlist()'s 'count_out' param
Date:   Tue, 26 Jan 2021 12:47:26 +0000
Message-Id: <20210126124732.3320971-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126124732.3320971-1-lee.jones@linaro.org>
References: <20210126124732.3320971-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/hfi1/sdma.c:2476: warning: Function parameter or member 'count_out' not described in 'sdma_send_txlist'
 drivers/infiniband/hw/hfi1/sdma.c:2476: warning: Excess function parameter 'count' description in 'sdma_send_txlist'

Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/hfi1/sdma.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/sdma.c b/drivers/infiniband/hw/hfi1/sdma.c
index 27ec2851160ae..46b5290b2839d 100644
--- a/drivers/infiniband/hw/hfi1/sdma.c
+++ b/drivers/infiniband/hw/hfi1/sdma.c
@@ -2448,11 +2448,11 @@ int sdma_send_txreq(struct sdma_engine *sde,
  * @sde: sdma engine to use
  * @wait: SE wait structure to use when full (may be NULL)
  * @tx_list: list of sdma_txreqs to submit
- * @count: pointer to a u16 which, after return will contain the total number of
- *         sdma_txreqs removed from the tx_list. This will include sdma_txreqs
- *         whose SDMA descriptors are submitted to the ring and the sdma_txreqs
- *         which are added to SDMA engine flush list if the SDMA engine state is
- *         not running.
+ * @count_out: pointer to a u16 which, after return will contain the total number of
+ *             sdma_txreqs removed from the tx_list. This will include sdma_txreqs
+ *             whose SDMA descriptors are submitted to the ring and the sdma_txreqs
+ *             which are added to SDMA engine flush list if the SDMA engine state is
+ *             not running.
  *
  * The call submits the list into the ring.
  *
-- 
2.25.1

