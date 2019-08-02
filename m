Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7807F475
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Aug 2019 12:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404550AbfHBKF1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Aug 2019 06:05:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44205 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391239AbfHBJce (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Aug 2019 05:32:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id p17so76439487wrf.11
        for <linux-rdma@vger.kernel.org>; Fri, 02 Aug 2019 02:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rM66R35YJmiSJYAAvI9ET9dGMarw1Nrc/qQCzBSeB0c=;
        b=ipGCxqPoLHBeIP9teAkKLXOV65vgaoxWbi2XAjrPuDSsTISKQVSlKeii2AA/INNWeI
         B8KC/A0ZxVghUFQ8jAEYx6Xr2YzX3CvtAV905QvNEGV4e51QZ/uM9GVtzcvbemIjWxIU
         9Cll7SpCpMsbw3OQxbpVa+3kF/eypf1yNz3VGNzOXULR0KKwEz25A7ljCn8qW9ehPqDz
         EBU11S0pJd0Szfy2vr0ZqSFLojtoC7S1yllierzZ+vYFyuIn9XGehuoGKRIL+eSKDHxO
         6uyWeERWutl8hRh6VsdPI8rbu5IhqJuZ3KQP1jo2OYh29B16+t0MQv+iLUqCM04rziBQ
         DxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rM66R35YJmiSJYAAvI9ET9dGMarw1Nrc/qQCzBSeB0c=;
        b=Yp9ugf4l7tbdZwXwTb09erDnmSMPtsHGGmzuNH9dqk0jHxgYIEGjBrI/lsPUw8MBxZ
         BTw1K7AUbjdVlkS4wHRoapo5c1Qt0b2r6CTaYHwE/Ppvjva5bwrNv9q5MAP/sLyOcvBU
         njmv1ANfQ1uRv0HQrrCRsKgEbZ7xQuqLUphaQr3SgG160aKzOONUjj70c0mHWi0vSbLL
         MT2uMaPRf0aklsb2uEzW1smaFtdyE2HoD+oFMJN5WhncpJmnVygOolnuzhWcbz8+STi5
         27ohAOcncRXYCr8uOk05mLY9I1n0N+/Vh/DRFwEChzGGOJHfJ2QIEfRESR8XV1DUEXod
         bFfA==
X-Gm-Message-State: APjAAAVbXXIhy7ckgwarHxVj8xnsFs6bnvp5l9JLBsuiTfIcc0aF9UV1
        oXVGfCyS85WJtOO3TaLdC4URg+pq
X-Google-Smtp-Source: APXvYqwI/22fIKcPjT4e2S59L+4nIYzIj0aWm57/gI2HGC6DMkVEB6uCFzWg0pqloX74xFtDcENbXw==
X-Received: by 2002:adf:e705:: with SMTP id c5mr98719331wrm.270.1564738351291;
        Fri, 02 Aug 2019 02:32:31 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-109-65-15-211.red.bezeqint.net. [109.65.15.211])
        by smtp.gmail.com with ESMTPSA id w23sm80651404wmi.45.2019.08.02.02.32.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 02:32:30 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Gal Pressman <galpress@amazon.com>,
        Leon Romanovsky <leon@kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        Moni Shoua <monis@mellanox.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Andrew Boyer <aboyer@tobark.org>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next V3 4/4] RDMA/{cxgb3, cxgb4, i40iw}: Remove common code
Date:   Fri,  2 Aug 2019 12:32:10 +0300
Message-Id: <20190802093210.5705-5-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802093210.5705-1-kamalheib1@gmail.com>
References: <20190802093210.5705-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Now that we have a common iWARP query port function we can remove the
common code from the iWARP drivers.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
Acked-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 drivers/infiniband/hw/cxgb3/iwch_provider.c | 25 ---------------------
 drivers/infiniband/hw/cxgb4/provider.c      | 24 --------------------
 drivers/infiniband/hw/i40iw/i40iw_verbs.c   | 11 ---------
 3 files changed, 60 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb3/iwch_provider.c b/drivers/infiniband/hw/cxgb3/iwch_provider.c
index 5848e4727b2e..dcf02ec02810 100644
--- a/drivers/infiniband/hw/cxgb3/iwch_provider.c
+++ b/drivers/infiniband/hw/cxgb3/iwch_provider.c
@@ -991,33 +991,8 @@ static int iwch_query_device(struct ib_device *ibdev, struct ib_device_attr *pro
 static int iwch_query_port(struct ib_device *ibdev,
 			   u8 port, struct ib_port_attr *props)
 {
-	struct iwch_dev *dev;
-	struct net_device *netdev;
-	struct in_device *inetdev;
-
 	pr_debug("%s ibdev %p\n", __func__, ibdev);
 
-	dev = to_iwch_dev(ibdev);
-	netdev = dev->rdev.port_info.lldevs[port-1];
-
-	/* props being zeroed by the caller, avoid zeroing it here */
-	props->max_mtu = IB_MTU_4096;
-	props->active_mtu = ib_mtu_int_to_enum(netdev->mtu);
-
-	if (!netif_carrier_ok(netdev))
-		props->state = IB_PORT_DOWN;
-	else {
-		inetdev = in_dev_get(netdev);
-		if (inetdev) {
-			if (inetdev->ifa_list)
-				props->state = IB_PORT_ACTIVE;
-			else
-				props->state = IB_PORT_INIT;
-			in_dev_put(inetdev);
-		} else
-			props->state = IB_PORT_INIT;
-	}
-
 	props->port_cap_flags =
 	    IB_PORT_CM_SUP |
 	    IB_PORT_SNMP_TUNNEL_SUP |
diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index 5e59c5708729..d373ac0fe2cb 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -305,32 +305,8 @@ static int c4iw_query_device(struct ib_device *ibdev, struct ib_device_attr *pro
 static int c4iw_query_port(struct ib_device *ibdev, u8 port,
 			   struct ib_port_attr *props)
 {
-	struct c4iw_dev *dev;
-	struct net_device *netdev;
-	struct in_device *inetdev;
-
 	pr_debug("ibdev %p\n", ibdev);
 
-	dev = to_c4iw_dev(ibdev);
-	netdev = dev->rdev.lldi.ports[port-1];
-	/* props being zeroed by the caller, avoid zeroing it here */
-	props->max_mtu = IB_MTU_4096;
-	props->active_mtu = ib_mtu_int_to_enum(netdev->mtu);
-
-	if (!netif_carrier_ok(netdev))
-		props->state = IB_PORT_DOWN;
-	else {
-		inetdev = in_dev_get(netdev);
-		if (inetdev) {
-			if (inetdev->ifa_list)
-				props->state = IB_PORT_ACTIVE;
-			else
-				props->state = IB_PORT_INIT;
-			in_dev_put(inetdev);
-		} else
-			props->state = IB_PORT_INIT;
-	}
-
 	props->port_cap_flags =
 	    IB_PORT_CM_SUP |
 	    IB_PORT_SNMP_TUNNEL_SUP |
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index d169a8031375..8056930bbe2c 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -97,18 +97,7 @@ static int i40iw_query_port(struct ib_device *ibdev,
 			    u8 port,
 			    struct ib_port_attr *props)
 {
-	struct i40iw_device *iwdev = to_iwdev(ibdev);
-	struct net_device *netdev = iwdev->netdev;
-
-	/* props being zeroed by the caller, avoid zeroing it here */
-	props->max_mtu = IB_MTU_4096;
-	props->active_mtu = ib_mtu_int_to_enum(netdev->mtu);
-
 	props->lid = 1;
-	if (netif_carrier_ok(iwdev->netdev))
-		props->state = IB_PORT_ACTIVE;
-	else
-		props->state = IB_PORT_DOWN;
 	props->port_cap_flags = IB_PORT_CM_SUP | IB_PORT_REINIT_SUP |
 		IB_PORT_VENDOR_CLASS_SUP | IB_PORT_BOOT_MGMT_SUP;
 	props->gid_tbl_len = 1;
-- 
2.20.1

