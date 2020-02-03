Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 919B7150EEF
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2020 18:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgBCRwQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Feb 2020 12:52:16 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45152 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbgBCRwQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Feb 2020 12:52:16 -0500
Received: by mail-wr1-f67.google.com with SMTP id a6so19382166wrx.12
        for <linux-rdma@vger.kernel.org>; Mon, 03 Feb 2020 09:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=GK8mKIskT8awu1lctRwRwffd9JQYah5KsNQCA0p/+EM=;
        b=cie17u8lol0UZo9Y8fUd9e809tceFvemoYZ3KJqYS6079F65+ukxht4nnPkqzomvco
         KqcaHjjCDVi+m9tXRjrbLRURjp02JijAGmEVwX7CZ4wh66OiJ5rhlVSlKNaKo59dDMBf
         ldHOKlJOEaIGCH3wFfUcoUIt4BeLOqhSFjNsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GK8mKIskT8awu1lctRwRwffd9JQYah5KsNQCA0p/+EM=;
        b=m0EdrgV+on3oC5WlkC1JbJtEyS8N/JxKSiOupo6obKj/GqWFuG/8HypmNJ0tk9+zgd
         +O/WZZq+LJfXhK6rcAquz0Rhu/CldKAW8z4VcSM6xCCxM0bFaECZF1JtZc9kdejgu7th
         AIQxaIzWbIpgQbICiIL2pOZVfhUSFxPH4XiDrMCtrBS9UVLhrWRHGo0sI8Qzo1gJ+Pwm
         dZLG8Xr0fITn5pnrQ7xdjkQAJ2tbGK8MXhYGzT+5o75K0ibscf+0myOlk2r0QL+Tw0Kj
         TRh8on94UDOgrtqU/G3l/sVyaVDybJY15keagjGi4G5fei2IQ96b34e1kgY7kyEuOcBg
         jiRg==
X-Gm-Message-State: APjAAAX5P+DLRIh18q+VWEyHNRJBpvaeY9gXOXtUSHfX4ZikwTKtbI1M
        GUc1wozxSERaHHfcp0G5p9gj8dfqQX66mCeUOpmkLnodTqc6enxFTIiWeBj8Ie4a2t7Z6fWN5se
        3MJ9s6jUPzxvivaQL/vvKnZ3iybh1cQaobRsYg2mSSywAYy5xZKxRMNH/94uQm1QYB+7aAYv5Np
        IHktM=
X-Google-Smtp-Source: APXvYqy+XRsmHU3ZkJjiUqPqOstox2hfTY36qxfeV9mTzNR6aWfku28vO5TS4SbnCraSM1keaDXW3Q==
X-Received: by 2002:adf:f288:: with SMTP id k8mr18040719wro.301.1580752334206;
        Mon, 03 Feb 2020 09:52:14 -0800 (PST)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id u8sm185211wmm.15.2020.02.03.09.52.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Feb 2020 09:52:13 -0800 (PST)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, leon@kernel.org
Subject: [PATCH v5] libibverbs: display gid type in ibv_devinfo
Date:   Mon,  3 Feb 2020 12:52:04 -0500
Message-Id: <1580752324-24742-1-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

It becomes difficult to make out from the output of ibv_devinfo
if a particular gid index is RoCE v2 or not.

Adding a string to the output of ibv_devinfo -v to display the
gid type at the end of gid.

The output would look something like below:
$ ibv_devinfo -v -d bnxt_re2
hca_id: bnxt_re2
 transport:             InfiniBand (0)
 fw_ver:                216.0.220.0
 node_guid:             b226:28ff:fed3:b0f0
 sys_image_guid:        b226:28ff:fed3:b0f0
  .
  .
  .
  .
       phys_state:      LINK_UP (5)
       GID[  0]:               fe80::b226:28ff:fed3:b0f0, IB/RoCE v1
       GID[  1]:               fe80::b226:28ff:fed3:b0f0, RoCE v2
       GID[  2]:               ::ffff:192.170.1.101, IB/RoCE v1
       GID[  3]:               ::ffff:192.170.1.101, RoCE v2
$
$

Reviewed-by: Jason Gunthrope <jgg@ziepe.ca>
Reviewed-by: Leon Romanovsky <leon@kernel.org>
Reviewed-by: Gal Pressman <galpress@amazon.com>
Reviewed-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 libibverbs/driver.h           |  1 +
 libibverbs/examples/devinfo.c | 35 ++++++++++++++++++++++++-----------
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/libibverbs/driver.h b/libibverbs/driver.h
index a0e6f89..fc0699d 100644
--- a/libibverbs/driver.h
+++ b/libibverbs/driver.h
@@ -84,6 +84,7 @@ enum verbs_qp_mask {
 enum ibv_gid_type {
 	IBV_GID_TYPE_IB_ROCE_V1,
 	IBV_GID_TYPE_ROCE_V2,
+	IBV_GID_TYPE_INVALID
 };
 
 enum ibv_mr_type {
diff --git a/libibverbs/examples/devinfo.c b/libibverbs/examples/devinfo.c
index bf53eac..568712c 100644
--- a/libibverbs/examples/devinfo.c
+++ b/libibverbs/examples/devinfo.c
@@ -40,6 +40,7 @@
 #include <getopt.h>
 #include <endian.h>
 #include <inttypes.h>
+#include <arpa/inet.h>
 
 #include <infiniband/verbs.h>
 #include <infiniband/driver.h>
@@ -162,8 +163,19 @@ static const char *vl_str(uint8_t vl_num)
 	}
 }
 
+static const char *gid_type_str(enum ibv_gid_type type)
+{
+	switch (type) {
+	case IBV_GID_TYPE_IB_ROCE_V1: return "IB/RoCE v1";
+	case IBV_GID_TYPE_ROCE_V2: return "RoCE v2";
+	default: return "Invalid gid type";
+	}
+}
+
 static int print_all_port_gids(struct ibv_context *ctx, uint8_t port_num, int tbl_len)
 {
+	char gid_str[INET6_ADDRSTRLEN] = {};
+	enum ibv_gid_type type;
 	union ibv_gid gid;
 	int rc = 0;
 	int i;
@@ -175,17 +187,18 @@ static int print_all_port_gids(struct ibv_context *ctx, uint8_t port_num, int tb
 			       port_num, i);
 			return rc;
 		}
-		if (!null_gid(&gid))
-			printf("\t\t\tGID[%3d]:\t\t%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x\n",
-			       i,
-			       gid.raw[ 0], gid.raw[ 1],
-			       gid.raw[ 2], gid.raw[ 3],
-			       gid.raw[ 4], gid.raw[ 5],
-			       gid.raw[ 6], gid.raw[ 7],
-			       gid.raw[ 8], gid.raw[ 9],
-			       gid.raw[10], gid.raw[11],
-			       gid.raw[12], gid.raw[13],
-			       gid.raw[14], gid.raw[15]);
+
+		rc = ibv_query_gid_type(ctx, port_num, i, &type);
+		if (rc) {
+			rc = 0;
+			type = IBV_GID_TYPE_INVALID;
+		}
+
+		if (!null_gid(&gid)) {
+			inet_ntop(AF_INET6, gid.raw, gid_str, sizeof(gid_str));
+			printf("\t\t\tGID[%3d]:\t\t%s, %s\n", i, gid_str,
+			       gid_type_str(type));
+		}
 	}
 	return rc;
 }
-- 
1.8.3.1

