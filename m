Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C36296A6F
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Oct 2020 09:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374559AbgJWHn6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Oct 2020 03:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374512AbgJWHn6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Oct 2020 03:43:58 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E62EC0613CE
        for <linux-rdma@vger.kernel.org>; Fri, 23 Oct 2020 00:43:57 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id z5so1042724ejw.7
        for <linux-rdma@vger.kernel.org>; Fri, 23 Oct 2020 00:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HLm1LwNkrOc6cVasvNsJwbj1HCjyxWUB6ZkgiTWnMZs=;
        b=b8Df8JcMnqytudqMACQBZ059VzDEPsZSJPc/GQ916/OvvTdjZH7aDdLtkD1bmLBXxp
         eMaf4ounRtpfNfqGzmDxsU3dmXU0439f8LScvMI/GNBwHcCtxxNUKR8M53XOjTAcpNEa
         TUZrlHJp31+SP9c5IUJQzHXO7+7gwCAFVbSD1/6GfBsHjm8XvfX8L8Y0bAl68PE+N4wT
         sdFSGN4jA+VUTEvQbwNAhmJetBJobqlAfbrcNlTieyzLnhBOi9s/EGds+LkeOe+FIQO5
         sl/AyfuBV0KDaFNorR2anCHIk9RQHS7ugIKEpmuS6AvCMjs2BWT6p66t/uc0lgCySxjW
         lZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HLm1LwNkrOc6cVasvNsJwbj1HCjyxWUB6ZkgiTWnMZs=;
        b=NJD5J2xyNqJtIxfbMwLW4H8C4YKzQMFUmW8RWV1g4hTDC2QN8uMfgFD75mvbs0Hh+S
         wS6rFlaX4pG1jWLr80j0HVbmNK7u6zn5e5Wr2M4fWGKBla9AhMrKrqCB7F5mCtDwUWB3
         tq7ksAIugWG5QGtx1JkDhxShNE7olD4mogkYk4zkezXinoSfRSTmnQZQawjhZhizlzJC
         7NKos8HphmeyTvVN7ObwcNSJL/Acfy+qSTo/tvfOul4/PE4qnMuEBhpmEuHSp8Wq9R/K
         N3PTfZ7mejb7lMunNXDLSSexVGmBkriSdFSdQHmZvdPDjZhLy6AgY5IClLzd79iF6Xop
         C1+w==
X-Gm-Message-State: AOAM5325bwwofQoqWXHJcWAGB+CKav70Im5Vf6/GNGHWgu5blxtlRwFQ
        S4MsaVBgOvrO54sFAM1eFvNFOwksPOapcw==
X-Google-Smtp-Source: ABdhPJyyAgK7hcgsh1u/i6bLyadCV07Hh2rmrGbwbG7+PvC+4f81y8iwZKCRQEjdivhJSIKm/hvu0A==
X-Received: by 2002:a17:906:3c03:: with SMTP id h3mr742063ejg.78.1603439035801;
        Fri, 23 Oct 2020 00:43:55 -0700 (PDT)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49b9:3000:d18a:ee7b:bff9:e374])
        by smtp.gmail.com with ESMTPSA id op24sm337928ejb.56.2020.10.23.00.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 00:43:55 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com
Subject: [PATCHv2 for-next 01/12] RDMA/rtrs-clt: remove destroy_con_cq_qp in case route resolving failed
Date:   Fri, 23 Oct 2020 09:43:42 +0200
Message-Id: <20201023074353.21946-2-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201023074353.21946-1-jinpu.wang@cloud.ionos.com>
References: <20201023074353.21946-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Danil Kipnis <danil.kipnis@cloud.ionos.com>

We call destroy_con_cq_qp(con) in rtrs_rdma_addr_resolved() in case route
couldn't be resolved and then again in create_cm() because nothing happens.

Don't call destroy_con_cq_qp from rtrs_rdma_addr_resolved, create_cm()
does the clean up already.

Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 776e89231c52..9980bb4a6f78 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1640,10 +1640,8 @@ static int rtrs_rdma_addr_resolved(struct rtrs_clt_con *con)
 		return err;
 	}
 	err = rdma_resolve_route(con->c.cm_id, RTRS_CONNECT_TIMEOUT_MS);
-	if (err) {
+	if (err)
 		rtrs_err(s, "Resolving route failed, err: %d\n", err);
-		destroy_con_cq_qp(con);
-	}
 
 	return err;
 }
-- 
2.25.1

