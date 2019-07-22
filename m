Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15A406F9E7
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2019 09:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfGVHGX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jul 2019 03:06:23 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53012 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfGVHGX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jul 2019 03:06:23 -0400
Received: by mail-wm1-f67.google.com with SMTP id s3so33981085wms.2
        for <linux-rdma@vger.kernel.org>; Mon, 22 Jul 2019 00:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8eDi4pElNgxuidboKBe2fs6EPmhwWqTYdPnDkUOsWIE=;
        b=qP4dWzkHb8O9raRXALFTeD2f1667cT5Mluf7J8ldTfLrubRkYrWu5uLplqgc4DAKtS
         sB8su4HE+FwptIc1KSuT/1KXabR7kEyv+OUzBNoVjKO7WcXwo+f7/ZFAkw52qCYNmZPE
         lsjB6EPjuwWCU9VFf0Dw6FMI5+1rIy/jjzpeyKDp/z798dO2cqwWZMoQgkowDpcQqHYM
         RbnqNSzY7ZOll+uHXySoEs2Wj4tFJze6q/DLISHOVNaRwQt1W6e6caPimlrbokNOITuW
         hu5A1LGq+mUV6iLyUO7aWPAWBBTZ7GHCWswL8UENNp0HSqtxoGBVMxqFDuNbvEFN9vc+
         JYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8eDi4pElNgxuidboKBe2fs6EPmhwWqTYdPnDkUOsWIE=;
        b=e+0LqNl2afn+hdZG9duledmIgoWXozn3GjOFjQ8jWzAtQtbDT+9odXgdG9cRGW7Djw
         CM2YJ1HxuavF6JwjHDhJl7JChBodh2gs+aFXScAFwm9m7qhBYVm9WxGjt7UT17UkEDgN
         UWJkUhEHn9c3DNc/Awr39qbr5TcQU6ONuHKF0jBDdDc7jA9dD2+OgIX0JZYDkX7t5aT5
         6VKi+YBPkQ0ggr3m9gChHrh2HlJW0nkNDjdL5osrUQFnxqZ5bZdJUr/RtzrAf5oDoMhx
         mvMq+fPl2+OPNIX8wUz9SLK0c8Iy+e8m1mlnvbz/c5/jKx7JVztVCGTbGj89P0oFpTgW
         JnJw==
X-Gm-Message-State: APjAAAX29DTCDxOgf+MVV0a70YqJF1nsQUFJT6cwJp9omXfJl7y8PGg1
        UrrDg91ZKENSd0M8pO+z9CwDqzJD
X-Google-Smtp-Source: APXvYqxITTEbfTiDfS49plpotwrYUUJha0PJwhXnrveDOvSXRBCQ2pueU+nYknWktqGWsJ5m20VP+A==
X-Received: by 2002:a1c:a942:: with SMTP id s63mr61256446wme.76.1563779180760;
        Mon, 22 Jul 2019 00:06:20 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-178-23-200.red.bezeqint.net. [79.178.23.200])
        by smtp.gmail.com with ESMTPSA id y18sm37360991wmi.23.2019.07.22.00.06.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 00:06:20 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next 2/3] RDMA/cxgb4: Report phys_state in query_port
Date:   Mon, 22 Jul 2019 10:05:49 +0300
Message-Id: <20190722070550.25395-3-kamalheib1@gmail.com>
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
 drivers/infiniband/hw/cxgb4/provider.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index 5e59c5708729..d38c242a1693 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -317,18 +317,24 @@ static int c4iw_query_port(struct ib_device *ibdev, u8 port,
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

