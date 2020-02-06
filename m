Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C00B153E4B
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Feb 2020 06:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbgBFFoP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Feb 2020 00:44:15 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42189 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgBFFoP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Feb 2020 00:44:15 -0500
Received: by mail-pl1-f193.google.com with SMTP id e8so1862815plt.9
        for <linux-rdma@vger.kernel.org>; Wed, 05 Feb 2020 21:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=N0aTORkCZao+sWkLIR0u6vPGcVcp5aNOiy4ORzx135c=;
        b=RDQskCvP7blwpSxlKZ583pcNA5hnAhG4ODQ36B0k2MezdpCJ8CkwbbH6MM5yluhj+V
         1Jo2XcD908u8T3nWOr5v/7DSIOdePWd916OG7dnXyCfBAMxOr7RoiSatxfpxGqMGvx2o
         xp4JIVQFxuyMPXzINsd9JIzWQZYuKOvdNJnck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N0aTORkCZao+sWkLIR0u6vPGcVcp5aNOiy4ORzx135c=;
        b=VSJ/QuBoB6J08eIj8kUCLW9PwTN1sTARU1rZbcMwZz8gggV1Xx/yi5Ypf2u1B7spfY
         Nojbk3bzB1ezv2ORWKtK4B5jsxouGvoPcFg0vQVzNLndLfkmNn5aLq/6S4OfFt9yX4qG
         YxHzU6vCsIQD7GAfSEJAukGahurh1R7BYKbmwZAaJRhOq0GCrM6gsdFbs2hXfHp7PZId
         +VoOqQ78WpJJhEIaWEPtBaV2sJUkNKL9wo021T7ICffbGbCxUfi/EO6ADK1ppd+KC5p3
         Q3ZGBN0KshdRe7Ai9bCFB4+3TDlMo7ovllKIDsFO9hFJ8GOz6qFpAwp1sMPDlQNEVoGj
         Gh0g==
X-Gm-Message-State: APjAAAX3/MGu4j/ShA8neiovYLnemTDbaGsqVXOKCwQrxWLKSKnBa2iO
        PJmt4irrFZG1osfRiWBBUPIe4iFMEtetOPfQzB3L6Dp/WyeL8DZgjVbYhEr73PRLvTKwd/3Hx7v
        ruW5a9NyqnTCF5198Topi2VK7yCB3lM9zPpwAvb7f8gl0vPnyfEUyGb8QIM5yJjBUB0CjQyhMok
        NSTso=
X-Google-Smtp-Source: APXvYqyhBPfgXq0TProNVbN101nTusO4rp7fRgq3lv5OqBkRvxeEJwQyQM5ksT1yIeGtsglzCuLYfA==
X-Received: by 2002:a17:90b:254:: with SMTP id fz20mr2184365pjb.25.1580967854187;
        Wed, 05 Feb 2020 21:44:14 -0800 (PST)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id o14sm1607541pgm.67.2020.02.05.21.44.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Feb 2020 21:44:13 -0800 (PST)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, leon@kernel.org
Subject: [PATCH v7] libibverbs: display gid type in ibv_devinfo
Date:   Thu,  6 Feb 2020 00:44:02 -0500
Message-Id: <1580967842-11220-1-git-send-email-devesh.sharma@broadcom.com>
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
	phys_state:     LINK_UP (5)
	GID[  0]:       fe80:0000:0000:0000:b226:28ff:fed3:b0f0, IB/RoCE v1
	GID[  1]:       fe80::b226:28ff:fed3:b0f0, RoCE v2
	GID[  2]:       0000:0000:0000:0000:0000:ffff:c0aa:0165, IB/RoCE v1
	GID[  3]:       ::ffff:192.170.1.101, RoCE v2
$
$
$

Reviewed-by: Jason Gunthrope <jgg@ziepe.ca>
Reviewed-by: Leon Romanovsky <leon@kernel.org>
Reviewed-by: Gal Pressman <galpress@amazon.com>
Reviewed-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 libibverbs/examples/devinfo.c | 61 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 49 insertions(+), 12 deletions(-)

diff --git a/libibverbs/examples/devinfo.c b/libibverbs/examples/devinfo.c
index bf53eac..7e2015b 100644
--- a/libibverbs/examples/devinfo.c
+++ b/libibverbs/examples/devinfo.c
@@ -40,6 +40,7 @@
 #include <getopt.h>
 #include <endian.h>
 #include <inttypes.h>
+#include <arpa/inet.h>
 
 #include <infiniband/verbs.h>
 #include <infiniband/driver.h>
@@ -162,12 +163,50 @@ static const char *vl_str(uint8_t vl_num)
 	}
 }
 
-static int print_all_port_gids(struct ibv_context *ctx, uint8_t port_num, int tbl_len)
+#define DEVINFO_INVALID_GID_TYPE	2
+static const char *gid_type_str(enum ibv_gid_type type)
 {
+	switch (type) {
+	case IBV_GID_TYPE_IB_ROCE_V1: return "IB/RoCE v1";
+	case IBV_GID_TYPE_ROCE_V2: return "RoCE v2";
+	default: return "Invalid gid type";
+	}
+}
+
+static void print_formated_gid(union ibv_gid *gid, int i,
+			       enum ibv_gid_type type, int ll)
+{
+	char gid_str[INET6_ADDRSTRLEN] = {};
+	char str[20] = {};
+
+	if (ll == IBV_LINK_LAYER_ETHERNET)
+		sprintf(str, ", %s", gid_type_str(type));
+
+	if (type == IBV_GID_TYPE_IB_ROCE_V1)
+		printf("\t\t\tGID[%3d]:\t\t%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x%s\n",
+		       i, gid->raw[0], gid->raw[1], gid->raw[2],
+		       gid->raw[3], gid->raw[4], gid->raw[5], gid->raw[6],
+		       gid->raw[7], gid->raw[8], gid->raw[9], gid->raw[10],
+		       gid->raw[11], gid->raw[12], gid->raw[13], gid->raw[14],
+		       gid->raw[15], str);
+
+	if (type == IBV_GID_TYPE_ROCE_V2) {
+		inet_ntop(AF_INET6, gid->raw, gid_str, sizeof(gid_str));
+		printf("\t\t\tGID[%3d]:\t\t%s%s\n", i, gid_str, str);
+	}
+}
+
+static int print_all_port_gids(struct ibv_context *ctx,
+			       struct ibv_port_attr *port_attr,
+			       uint8_t port_num)
+{
+	enum ibv_gid_type type;
 	union ibv_gid gid;
+	int tbl_len;
 	int rc = 0;
 	int i;
 
+	tbl_len = port_attr->gid_tbl_len;
 	for (i = 0; i < tbl_len; i++) {
 		rc = ibv_query_gid(ctx, port_num, i, &gid);
 		if (rc) {
@@ -175,17 +214,15 @@ static int print_all_port_gids(struct ibv_context *ctx, uint8_t port_num, int tb
 			       port_num, i);
 			return rc;
 		}
+
+		rc = ibv_query_gid_type(ctx, port_num, i, &type);
+		if (rc) {
+			rc = 0;
+			type = DEVINFO_INVALID_GID_TYPE;
+		}
 		if (!null_gid(&gid))
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
+			print_formated_gid(&gid, i, type,
+					   port_attr->link_layer);
 	}
 	return rc;
 }
@@ -614,7 +651,7 @@ static int print_hca_cap(struct ibv_device *ib_dev, uint8_t ib_port)
 				printf("\t\t\tphys_state:\t\t%s (%d)\n",
 				       port_phy_state_str(port_attr.phys_state), port_attr.phys_state);
 
-			if (print_all_port_gids(ctx, port, port_attr.gid_tbl_len))
+			if (print_all_port_gids(ctx, &port_attr, port))
 				goto cleanup;
 		}
 		printf("\n");
-- 
1.8.3.1

