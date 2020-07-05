Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98320214BDE
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2020 12:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgGEKnc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Jul 2020 06:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgGEKnb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 Jul 2020 06:43:31 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED3FC061794
        for <linux-rdma@vger.kernel.org>; Sun,  5 Jul 2020 03:43:31 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o8so36138372wmh.4
        for <linux-rdma@vger.kernel.org>; Sun, 05 Jul 2020 03:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q18ny4pd+jJoQXx48Q/P7hV6NnilQDPJdxj2j+rR6u4=;
        b=V1l2gNkSFUdm071Mv55emVv6SuAKfv2/smjSnROttKeSgMiAVHYTdcyiL8SdPBUrja
         BO47kObBpdkrefl9ZM4Vfyj58xUsOxTzt0uYdDNBhp2Jn/3Q+mlEktDMclhWw91um9kr
         ZU7pxdLg9zqONt4ZEDSdxoquaxERTPKX82QiKBufO0CM/fPTUa/qdRnKNC957caqsZPK
         e0znKWHU/PNslP3xoFttFbopqccAPfC+5/F8anxLuB+4NJ5ldCkO4EjiPFItK98EMamo
         efGeYO8HCe4b8xFmKvWENq9gih64ACVu5SQ3DI3l/j2/sRtcSCOsPsZaJSQak/APP0Gw
         cusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q18ny4pd+jJoQXx48Q/P7hV6NnilQDPJdxj2j+rR6u4=;
        b=aL+Mczn3Lm2LduSvFVoi3NC8ohhhu7mK08OP+jghlbyou6afJYsV1qvFwysX2IDTRo
         /RoqMX/1e4Lu9NZxkcwk1OfuyKtat5bkuVmHm01e+XPSN8011FV0Bm14tNzdWODu+CtQ
         7en7CVWmwmbLQdtbJPJykXOxM8cFiU2Y3lWq6FotrRw4QgObkL7qQq4dSk7vmZz/jFAw
         dD0CGP8IO7rzG5dfT+9i1HZXS5CWQYkbgl4IqyQA+HjayjnpChzh/Hz2Qz+Nj47eqrvs
         nzRe0WxkY4aRP3ubknpxcKhocyHjk9R7+tLd64IF4sbVsfX2odQws1Ua/rQApDNoFVSm
         ij1A==
X-Gm-Message-State: AOAM531eWTc0vwjqQbGWg2yaLLEFOQbF9qAH0Nexne3aLM4oo/1UG7VT
        6hgj3nUolps2GV1V3x2SE8pVeDNe/E0=
X-Google-Smtp-Source: ABdhPJz4bsmlxOliNayMSv4qLMi1kCMdouViKfqa2fW6nETYrt7/RwuSJC4cSDmPf2g8D/FarNsjEA==
X-Received: by 2002:a1c:4444:: with SMTP id r65mr42703827wma.129.1593945810182;
        Sun, 05 Jul 2020 03:43:30 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id 51sm14828083wrc.44.2020.07.05.03.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 03:43:29 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Zhu Yanjun <yanjunz@mellanox.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next v1 2/4] RDMA/rxe: Return void from rxe_init_port_param()
Date:   Sun,  5 Jul 2020 13:43:11 +0300
Message-Id: <20200705104313.283034-3-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200705104313.283034-1-kamalheib1@gmail.com>
References: <20200705104313.283034-1-kamalheib1@gmail.com>
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

