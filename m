Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA90213CA3
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jul 2020 17:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgGCPe5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Jul 2020 11:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgGCPe5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Jul 2020 11:34:57 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02431C061794
        for <linux-rdma@vger.kernel.org>; Fri,  3 Jul 2020 08:34:57 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b6so33134329wrs.11
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jul 2020 08:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q18ny4pd+jJoQXx48Q/P7hV6NnilQDPJdxj2j+rR6u4=;
        b=CopOW47TvX6BudpniLTjCodp761Bma1uzDBnBp4jViDdVvm2JOsM36NeNEM1wDMoUa
         2VU66czMOOYDlWX1QJ18LiPAZgo8lxq/Q/taj3jxWOVmKnr2fbqbUgbxX5Zlbbw089BG
         IKK73U3tAlYxE//lvu2K6a758B1kBS/GXIhPiFDbYIlxqIkipGYzjjJjXwCsabK2TXUn
         fuQyZtmymT+Omkp8H8gnESyX42YnAKK1PHM2vrBGW4mDlZYJGPcb0xLreU5Jkm3D+xr+
         GFDMq56MgaiZ2skWtwvhJ4NtehQjlou3Dcm3Rq3ezDlMebPeN3AVhWZ9mHPrSFA7vEhK
         jR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q18ny4pd+jJoQXx48Q/P7hV6NnilQDPJdxj2j+rR6u4=;
        b=qzokMf+RhJG7jN5hjrn3oPBInrf+dqs76dJHQTCCTGTBt5lmkl5RHlpjNi8XqU5EU7
         fDyS7VIGHLmJYGd4r+ih3l/4bzMhmmo5w3MhAoTdcHBBcsWvDcyqtUL+Y2CgWhIHHz2R
         i3lHKsJebgBvtpDbvbr0ToGWHrNzlOqc4ikji83VnUZHyP+WRo6lJ/qycTCCU+yBblgh
         DDvgDS6F1RQltwnhGoTiopyTymqFoB4jIJp8NgOIV41TeRFAc5tW6tAaIlmwXRIeNV1b
         oz9TLWfCUPWTc9c8WTR7E3Wr76QbHlbGUp6m1HkFJd6ivLe/hBE5MHSIlIJb00LvIm+Q
         JoFQ==
X-Gm-Message-State: AOAM531veJ8WRAXHQw6iWrmVmJ27ue/LdVVv5ZXCgDYwOM4/x402VYh0
        tlJXPj1LsRI5iSPvKuICwehCleYGLZo=
X-Google-Smtp-Source: ABdhPJy6tdzcrKvYMMNieg8Z8tW8UWTWUyFK3FGqpODuDUDVXpoioQ2ssoMpIYpFTwlNpwMdWM/AAQ==
X-Received: by 2002:adf:db42:: with SMTP id f2mr37091629wrj.298.1593790495511;
        Fri, 03 Jul 2020 08:34:55 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id r1sm14083225wrt.73.2020.07.03.08.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 08:34:55 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Zhu Yanjun <yanjunz@mellanox.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next 2/4] RDMA/rxe: Return void from rxe_init_port_param()
Date:   Fri,  3 Jul 2020 18:34:26 +0300
Message-Id: <20200703153428.173758-3-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200703153428.173758-1-kamalheib1@gmail.com>
References: <20200703153428.173758-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The return value from rxe_init_port_param() is always 0 - change it to
be void.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index c7191b5e04a5..efcb72c92be6 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -111,7 +111,7 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
 }
 
 /* initialize port attributes */
-static int rxe_init_port_param(struct rxe_port *port)
+static void rxe_init_port_param(struct rxe_port *port)
 {
 	port->attr.state		= IB_PORT_DOWN;
 	port->attr.max_mtu		= IB_MTU_4096;
@@ -134,8 +134,6 @@ static int rxe_init_port_param(struct rxe_port *port)
 	port->attr.phys_state		= RXE_PORT_PHYS_STATE;
 	port->mtu_cap			= ib_mtu_enum_to_int(IB_MTU_256);
 	port->subnet_prefix		= cpu_to_be64(RXE_PORT_SUBNET_PREFIX);
-
-	return 0;
 }
 
 /* initialize port state, note IB convention that HCA ports are always
-- 
2.25.4

