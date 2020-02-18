Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14C7E16240F
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2020 10:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgBRJ7a (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Feb 2020 04:59:30 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41576 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgBRJ73 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Feb 2020 04:59:29 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so23137273wrw.8
        for <linux-rdma@vger.kernel.org>; Tue, 18 Feb 2020 01:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G5enyx4zsrQWMNXotUdl0sx4KsIv/ZjBD1B3NoQx0cY=;
        b=YuQUHMPVEBhzUfCqPlv0P4VOqFVxDMKCiG8llDL8lPiYFpAPf9XHLmWIFo7xCDQa9s
         Om1FKx9KRz3N7uIrmgMMs2gbTyWyCj2nNsXckqpEKBSRZAwZBTR+Ch8n6jU3f4Q1EIs5
         Qpdg8/HqxHm9nNfVVnqDz9f/WYecavILVghR9sT3i6BoVKIz8ghwFNQd254+cAljH3HP
         d32H9NP3QlDazsDBzEyPHx2BFVLYxwb9Pyz+stP6HGpx6kWPHsu1tw3bS9TbAEg9aHXK
         rCGS5lCh8OCqQ9/0VchkyPRkOrg9OKAFJ/TwF/EleAoaakxOsIgk8GxGAyIePOy0jMw0
         RPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G5enyx4zsrQWMNXotUdl0sx4KsIv/ZjBD1B3NoQx0cY=;
        b=ldlgcbXrBTbwM4Ox7BXcy8AHVYpRQStb2G3uBfSlAwUCE0zKhc+SiuOxiVG5jJT4vS
         mHPpbuP5pHqyIJO8PBC3OPghHSIrppbr8/pWPONJTzS/EXQoeyQ8QRi9PkNvlo6L/w4z
         xzETlmk94DJrfYCmY49dGWDvX8ZvSD5HNX0vRkRjodGyLYbcdIM/d2VLGDZ5D5nBYVc3
         KuNxNbjKQWaTq/atS81s7WQ/XkZeglvd8HyqQJDYnwTN9tFfqiXPcWAZSvXCPCMVR/96
         9WwQOhqySz7K/cL0vUfseFlJyDOdQf46ResazqCRCHh+D5TKL0LSwmDmOkIynoiD59Wi
         Ohkw==
X-Gm-Message-State: APjAAAURaQEefkj8Dqr2VrHO6lZUMtbuZ5TO93fkLfENFqElVfp4hRqb
        2EbfaMmxjEpi0VGzumweN7DZG+2/7rQ=
X-Google-Smtp-Source: APXvYqwl766un/ztp/XHKqsg/1nIBDUXfyrg3iz05hTIK3Ru4k2/htDgmedQPAEmtG8LvfAvzPOigQ==
X-Received: by 2002:adf:f10a:: with SMTP id r10mr28253156wro.202.1582019966346;
        Tue, 18 Feb 2020 01:59:26 -0800 (PST)
Received: from kheib-workstation.redhat.com (bzq-109-65-128-51.red.bezeqint.net. [109.65.128.51])
        by smtp.gmail.com with ESMTPSA id c4sm2957992wml.7.2020.02.18.01.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 01:59:25 -0800 (PST)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next v2] RDMA/siw: Fix setting active_{speed, width} attributes
Date:   Tue, 18 Feb 2020 11:59:11 +0200
Message-Id: <20200218095911.26614-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Make sure to set the active_{speed, width} attributes to avoid reporting
the same values regardless of the underlying device.

Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
V2: Change rc to rv.
---
 drivers/infiniband/sw/siw/siw_verbs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 73485d0da907..d5390d498c61 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -165,11 +165,12 @@ int siw_query_port(struct ib_device *base_dev, u8 port,
 		   struct ib_port_attr *attr)
 {
 	struct siw_device *sdev = to_siw_dev(base_dev);
+	int rv;
 
 	memset(attr, 0, sizeof(*attr));
 
-	attr->active_speed = 2;
-	attr->active_width = 2;
+	rv = ib_get_eth_speed(base_dev, port, &attr->active_speed,
+			 &attr->active_width);
 	attr->gid_tbl_len = 1;
 	attr->max_msg_sz = -1;
 	attr->max_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
@@ -192,7 +193,7 @@ int siw_query_port(struct ib_device *base_dev, u8 port,
 	 * attr->subnet_timeout = 0;
 	 * attr->init_type_repy = 0;
 	 */
-	return 0;
+	return rv;
 }
 
 int siw_get_port_immutable(struct ib_device *base_dev, u8 port,
-- 
2.21.1

