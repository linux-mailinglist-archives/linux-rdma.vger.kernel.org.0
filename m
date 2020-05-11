Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7AEA1CE81C
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 00:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbgEKWbB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 18:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725828AbgEKWbB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 11 May 2020 18:31:01 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D71C061A0C
        for <linux-rdma@vger.kernel.org>; Mon, 11 May 2020 15:31:00 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l11so7065390wru.0
        for <linux-rdma@vger.kernel.org>; Mon, 11 May 2020 15:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MbNyMPyOK/7HvfKud6JivKVW3YxIMLolTKATHbXo070=;
        b=NUlKldlxps9VJ1bup608hsmABTD+jthJuLd2pPMy769Y90tG06ynxQExpTAqyMkzjZ
         8dbiQSJs4DbNJ7yqUsqQisTfWKEDHjwQmFCEfprTD9J1r858eS+nSrcw7De21A+v5jXs
         YzFVG9nnU0I3ALH3KpF7xMjEQbUiAWU0cbnA+PLUcQ6AfwZd4SeKzbK/dbWP3EjrUD5S
         PtjNB8X10l/EEFUU1hwLV/HUZ8bSsaXPtNDtR/ft0f/42rj2Mgh4kp9LHis+yEJ/o8rW
         q0I/FfBarBSDb/pP14eI/GeJ2AmIxmWakiI1YP9yrbGz7SCeHtEA8cy7L45QPrHeHAOr
         Sdwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MbNyMPyOK/7HvfKud6JivKVW3YxIMLolTKATHbXo070=;
        b=SKc6usmKY1lACSVcb2XZklZktXDiWXsATvN+Qe+EHS9R7Hr4rjt+BB6BUNLJ734M08
         0KiWiFduQ+E+1Ijrf34Rof/sa9RqN6/oE8aaHcydaHHSP6RCnJqlT1jgewLbJL385Ah0
         GT6XQzAidMVmh3oR7Qo9wC8Vtd80P/VznwlesTJLf4i3O/6KnTsqm8EIw+1YFafkR/56
         J+lSJf3sN65E7hvv1ppV3uMt7/UYmeIEJCbVxO3238MTJRNkIvPHsu05P5TRmt6iJKS3
         HD09SlYjldnqxx7fiyDWQQFRLcIuoHLsi2D5djBoMiprUwLARhpUfZATJYRSDZLoALgk
         uUfg==
X-Gm-Message-State: AGi0PuYqJDHft2gIVoOA8//MnbuWBmUBWfPvWTEDmBiqKJzJNBBx1ldH
        Wy+sLFtfhkdx57cBRBb+KpnvcvAU
X-Google-Smtp-Source: APiQypIgEI0W+IO5lwGgzB3FdqRPTNlzNezWjj1BDzUEDOrtPYJb7EXHjQl9CPjumpRGz6u1CEGTvg==
X-Received: by 2002:a5d:4b0a:: with SMTP id v10mr14622013wrq.33.1589236229488;
        Mon, 11 May 2020 15:30:29 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.4.4])
        by smtp.gmail.com with ESMTPSA id i74sm19607911wri.49.2020.05.11.15.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 15:30:28 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Bart Van Assche <bvanassche@acm.org>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-rc] RDMA/srpt: Fix disabling device management
Date:   Tue, 12 May 2020 01:29:18 +0300
Message-Id: <20200511222918.62576-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Avoid disabling device management for devices that don't support
Management datagrams (MADs) by checking if the "mad_agent" pointer is
initialized before calling ib_modify_port, also change the error message
to a warning and make it more informative.

Fixes: 09f8a1486dca ("RDMA/srpt: Fix handling of SR-IOV and iWARP ports")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 7ed38d1cb997..7b21792ab6f7 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -625,14 +625,18 @@ static void srpt_unregister_mad_agent(struct srpt_device *sdev)
 		.clr_port_cap_mask = IB_PORT_DEVICE_MGMT_SUP,
 	};
 	struct srpt_port *sport;
+	int ret;
 	int i;
 
 	for (i = 1; i <= sdev->device->phys_port_cnt; i++) {
 		sport = &sdev->port[i - 1];
 		WARN_ON(sport->port != i);
-		if (ib_modify_port(sdev->device, i, 0, &port_modify) < 0)
-			pr_err("disabling MAD processing failed.\n");
 		if (sport->mad_agent) {
+			ret = ib_modify_port(sdev->device, i, 0, &port_modify);
+			if (ret < 0)
+				pr_warn("%s-%d: disabling device management failed (%d). Note: this is expected if SR-IOV is enabled.\n",
+					dev_name(&sport->sdev->device->dev),
+					sport->port, ret);
 			ib_unregister_mad_agent(sport->mad_agent);
 			sport->mad_agent = NULL;
 		}
-- 
2.25.4

