Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571F31D2EAB
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2020 13:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgENLrg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 May 2020 07:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgENLrg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 May 2020 07:47:36 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FBEC061A0C
        for <linux-rdma@vger.kernel.org>; Thu, 14 May 2020 04:47:36 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id z72so22599788wmc.2
        for <linux-rdma@vger.kernel.org>; Thu, 14 May 2020 04:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Md/d9xv6u5osfLoKMSki97Zad3KhwieYdlVS16xKpag=;
        b=HPW+lcG3eLOxHVqq1ICqIiyl6NPDHEyQApNYaHSbc3vfvgLEh8KouHzPbCkpsSsK0S
         1H3nUjqtUppKwxSbmjEq08H85ZY/+O7t20STrHzVd53ihrS0Jo0/JLuX8Rak+lhAYbVb
         0wvpUZCd/lstt3FaVy+EqSjahYARddFyG+rpGP9fLkImLN3SfjbKQ/25UsPiP8shhnL7
         E+UnxXRglzwpNK/VNdgT5MFNFG6YI+D3OmcGJ0YZSiDJgcUayuhNIWV6fSBjUnRdjq8L
         mXezMix6iEmVO2xNt0leyLS7iXsyPr5mfWpfPvpmtrOAyjnQJozjIjKzRsizHonmWIqJ
         UoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Md/d9xv6u5osfLoKMSki97Zad3KhwieYdlVS16xKpag=;
        b=DQ6MfcnJwfu1bI2kOXDWfKMR/vfnDmueWqH3PsMS89Ck2vvs4xpGr9iDNIr04xnBJg
         woRiF2I4a8ArnI+yYCtyzEh61R1gf7KdfYlGc9zUfso4hayYlfS/xnDg47JqeyJWqYTc
         TqZDahBeyP/U9TwlJ97Ctku2Ybrc1BHoEWRE5Itd2tTfYHu2mVGY5HaaAde99uUehEmE
         KlSCPI4jITtikDzCyPC0kOfu4vAiPkFwFElD/nQLuTm64dfejWapaqFaLBj0ZqDhRKTH
         RQFxVRl9TO2wqZCMIWU//d9R+zC3i7YujOML/QDLQA6l/FdTtP9ztOV/WurkbetEIaQz
         N2nw==
X-Gm-Message-State: AOAM530Uqxg/jY1dfsLlumoMcBNi1Q0zPENjgC0w7OuYMGu5EeWpaNrg
        PgQD7w+PT/ZKPspFuDQoZneSjct3
X-Google-Smtp-Source: ABdhPJxioDJqq1OAQ7hSxtfaw8DOE6q3mwojbPQ4MLdgVspAj6+A+HySyuI6GHBVO18Dyb93lDwy/A==
X-Received: by 2002:a1c:2e46:: with SMTP id u67mr82206wmu.156.1589456854677;
        Thu, 14 May 2020 04:47:34 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.4.4])
        by smtp.gmail.com with ESMTPSA id 60sm3764757wrp.92.2020.05.14.04.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 04:47:33 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-rc v2] RDMA/srpt: Fix disabling device management
Date:   Thu, 14 May 2020 14:47:20 +0300
Message-Id: <20200514114720.141139-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Avoid disabling device management for devices that don't support
Management datagrams (MADs) by checking if the "mad_agent" pointer is
initialized before calling ib_modify_port, also fix the error flow in
srpt_refresh_port() to disable device management if
ib_register_mad_agent() fail.

Fixes: 09f8a1486dca ("RDMA/srpt: Fix handling of SR-IOV and iWARP ports")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 7ed38d1cb997..7dfc0138b973 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -607,6 +607,11 @@ static int srpt_refresh_port(struct srpt_port *sport)
 			       dev_name(&sport->sdev->device->dev), sport->port,
 			       PTR_ERR(sport->mad_agent));
 			sport->mad_agent = NULL;
+			memset(&port_modify, 0, sizeof(port_modify));
+			port_modify.clr_port_cap_mask = IB_PORT_DEVICE_MGMT_SUP;
+			ib_modify_port(sport->sdev->device, sport->port, 0,
+				       &port_modify);
+
 		}
 	}
 
@@ -630,9 +635,8 @@ static void srpt_unregister_mad_agent(struct srpt_device *sdev)
 	for (i = 1; i <= sdev->device->phys_port_cnt; i++) {
 		sport = &sdev->port[i - 1];
 		WARN_ON(sport->port != i);
-		if (ib_modify_port(sdev->device, i, 0, &port_modify) < 0)
-			pr_err("disabling MAD processing failed.\n");
 		if (sport->mad_agent) {
+			ib_modify_port(sdev->device, i, 0, &port_modify);
 			ib_unregister_mad_agent(sport->mad_agent);
 			sport->mad_agent = NULL;
 		}
-- 
2.25.4

