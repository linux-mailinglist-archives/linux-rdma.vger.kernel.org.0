Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50FB86F9E6
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2019 09:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfGVHGV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jul 2019 03:06:21 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33446 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbfGVHGV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jul 2019 03:06:21 -0400
Received: by mail-wm1-f65.google.com with SMTP id h19so28058002wme.0
        for <linux-rdma@vger.kernel.org>; Mon, 22 Jul 2019 00:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rNVQ+8E+RF952aYbTi91B8fuGaq22pT7KlcSHGXxod0=;
        b=rZYdMWFxztubokF8BzMoYfgLk6pHPZIKKrRrAi36t+8KeZlum9pDomGiUotlQupDex
         3p8Ov0RhJj3XvdYKrJvO2WekNA02gSirSfaEhs47e3PHJ4jBnoPqaEwPOAn7t6nRdgdt
         p4Lqha0OsFLse2ojdmO+KLwyJDyxvP3JpS7qBexu3XhdzIUvRXYgwsG4KNUf8ZkHKFbl
         gW2RV+wsZLL1QOC5YzktK/gRVXgOxbwGyQmMVswvW0eHHYSo9m+VX0qIDJNG4kRoh3+r
         +aOlj1HK+zyOdD2ozF1m2gGNT6YhJhQKhWuvevhsb4MdycN1wGpSkZg5gN5Q1JjJxYqq
         fswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rNVQ+8E+RF952aYbTi91B8fuGaq22pT7KlcSHGXxod0=;
        b=o0zlzM6aw2+g3JB/ic3G0GFqUxKaEAbauYvgGGH6VbgmH09eGVsDNLvSOS4FibicHu
         IccaPUh7iw7ua/DrQ0W+ZAZeUUDiikPtHrGRX1fSj0Vgp76cWLsLXq3yuZeGJwR5Xfq0
         ExsB25Gz31DiQOMrcl7Z4jyVrTGg3zB4capoQFHbP61RvNocs62tU0G59erEdaJfUYL8
         XJxSNeSdBCikir5hYAXe5kU3io2WQN//gF5Q7e02cB8IviQckUvKlAZxW/rJcxvVhhi5
         eb8J2tI72UF1WGbeGcWWCuIHM9hWCU7TRF+9sWkulLmuVyxKSME3vmGClzprB21AJELQ
         xJ4Q==
X-Gm-Message-State: APjAAAURs9Iog/Tk8td0P+WXxJ24oHFQ+utZ3n5CiO7rzlnsH13JY+Qw
        wBJ7bcyHIb0RIf+5TswWri7QBMP4
X-Google-Smtp-Source: APXvYqyVG3+Z1ngPEboLyXnkPiMTuPNh975OLC8YD52FJrHLNPFOnhOu59aeWjYUoTGMDQPfPeHCwA==
X-Received: by 2002:a1c:be05:: with SMTP id o5mr62967570wmf.52.1563779179285;
        Mon, 22 Jul 2019 00:06:19 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-178-23-200.red.bezeqint.net. [79.178.23.200])
        by smtp.gmail.com with ESMTPSA id y18sm37360991wmi.23.2019.07.22.00.06.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 00:06:18 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next 1/3] RDMA/cxgb3: Report phys_state in query_port
Date:   Mon, 22 Jul 2019 10:05:48 +0300
Message-Id: <20190722070550.25395-2-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722070550.25395-1-kamalheib1@gmail.com>
References: <20190722070550.25395-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add support for reporting physical state when calling query_port() via
the sysfs interface.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/cxgb3/iwch_provider.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb3/iwch_provider.c b/drivers/infiniband/hw/cxgb3/iwch_provider.c
index e775c1a1a450..7b0b7bfc570a 100644
--- a/drivers/infiniband/hw/cxgb3/iwch_provider.c
+++ b/drivers/infiniband/hw/cxgb3/iwch_provider.c
@@ -1004,18 +1004,24 @@ static int iwch_query_port(struct ib_device *ibdev,
 	props->max_mtu = IB_MTU_4096;
 	props->active_mtu = ib_mtu_int_to_enum(netdev->mtu);
 
-	if (!netif_carrier_ok(netdev))
+	if (!netif_carrier_ok(netdev)) {
 		props->state = IB_PORT_DOWN;
-	else {
+		props->phys_state = 3;
+	} else {
 		inetdev = in_dev_get(netdev);
 		if (inetdev) {
-			if (inetdev->ifa_list)
+			if (inetdev->ifa_list) {
 				props->state = IB_PORT_ACTIVE;
-			else
+				props->phys_state = 5;
+			} else {
 				props->state = IB_PORT_INIT;
+				props->phys_state = 4;
+			}
 			in_dev_put(inetdev);
-		} else
+		} else {
 			props->state = IB_PORT_INIT;
+			props->phys_state = 4;
+		}
 	}
 
 	props->port_cap_flags =
-- 
2.20.1

