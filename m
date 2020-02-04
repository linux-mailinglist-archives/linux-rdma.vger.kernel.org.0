Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6D5A151826
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2020 10:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgBDJrg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Feb 2020 04:47:36 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45732 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgBDJrg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Feb 2020 04:47:36 -0500
Received: by mail-wr1-f68.google.com with SMTP id a6so22064990wrx.12
        for <linux-rdma@vger.kernel.org>; Tue, 04 Feb 2020 01:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=OZwi2lR3crDl7ZXCqe2y48/Fi94XidZrk34mtYMhlbk=;
        b=UzGPpAKqTZaScM14QjHZDcTyUNxrPT2mbZRPRh3+W8wstZMuADeVHsO1bo18KrU+19
         ozRTqg2fZaOu89StftN3AZxxntwaUtryy6BRFp+YVTyiJEw7gYCZ1d6mKpD5FeNUoA60
         N5lNGNJ7qFMmPnlg9lmkBFAzbEEa+1y/V/Vqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OZwi2lR3crDl7ZXCqe2y48/Fi94XidZrk34mtYMhlbk=;
        b=bauR9Xc8hKtJ5Wu8aFnlGIU2Wn5r6RFFbAH5AIeMaGIi/q2D4zepK9a+4aiSEgH5IY
         Rsu0sFCl4PqEumgAiBrfS9PFxLhJjHB+IJXwYnaYOjKwpK4OKWupfb8F8+7XFVrvQb8T
         ARpl54OO3JvGNT+OvcECyCkBEEA92VGftIONQMBj0FVDxnhM+ViDJSVoW3VRbogejCsX
         okR+eTYrNO42xZ6fTetKeCboPyeyVGAXOUY2NeNEep+2eAZW13BuFk8I4bLhKZR7T9Kk
         gLGk4k/wigM7jIdgYByBKLOit7IzjdNfwnM/mFw4hpa5iVCLjbwB8S3KBwTs6I0n2RF5
         BJ+Q==
X-Gm-Message-State: APjAAAXm53wtCM9be0iLZregk/9fbB3vCRer5UIQUThnaJckFhCQ36+f
        cfQabtdaNy+34EnyFXKzqlMzISXa/hGlous4ldlDwtsfnIaqberNE8JEbDMWbZFozFiPpcW/cuu
        7zKAUf52gV/1sVG9qVVTQrL6sXYJiZIq8MA9riI7Mq7qW+PI5SRx4Rwe1fc1I/vfTlvMJLE63qw
        fUMy8=
X-Google-Smtp-Source: APXvYqwiuDxlddU5hz2Q4OJl+u4KjBcBf7A6izUFUePywrNGjrh+DzLyqDGbpU8LI+Cyjl304toTqA==
X-Received: by 2002:adf:eb51:: with SMTP id u17mr22789647wrn.29.1580809654108;
        Tue, 04 Feb 2020 01:47:34 -0800 (PST)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id e17sm16372264wrn.62.2020.02.04.01.47.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Feb 2020 01:47:33 -0800 (PST)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, leon@kernel.org
Subject: [PATCH v6] libibverbs: display gid type in ibv_devinfo
Date:   Tue,  4 Feb 2020 04:47:24 -0500
Message-Id: <1580809644-5979-1-git-send-email-devesh.sharma@broadcom.com>
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
	GID[  1]:       fe80:0000:0000:0000:b226:28ff:fed3:b0f0, RoCE v2
	GID[  1]:       fe80::b226:28ff:fed3:b0f0
	GID[  2]:       0000:0000:0000:0000:0000:ffff:c0aa:0165, IB/RoCE v1
	GID[  3]:       0000:0000:0000:0000:0000:ffff:c0aa:0165, RoCE v2
	GID[  3]:       ::ffff:192.170.1.101
$
$
$

Reviewed-by: Jason Gunthrope <jgg@ziepe.ca>
Reviewed-by: Leon Romanovsky <leon@kernel.org>
Reviewed-by: Gal Pressman <galpress@amazon.com>
Reviewed-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 libibverbs/examples/devinfo.c | 60 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 48 insertions(+), 12 deletions(-)

diff --git a/libibverbs/examples/devinfo.c b/libibverbs/examples/devinfo.c
index bf53eac..83acc22 100644
--- a/libibverbs/examples/devinfo.c
+++ b/libibverbs/examples/devinfo.c
@@ -40,6 +40,7 @@
 #include <getopt.h>
 #include <endian.h>
 #include <inttypes.h>
+#include <arpa/inet.h>
 
 #include <infiniband/verbs.h>
 #include <infiniband/driver.h>
@@ -162,12 +163,49 @@ static const char *vl_str(uint8_t vl_num)
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
+	if (ll == IBV_LINK_LAYER_ETHERNET) {
+		sprintf(str, ", %s", gid_type_str(type));
+		printf("\t\t\tGID[%3d]:\t\t%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x%s\n",
+		       i, gid->raw[0], gid->raw[1], gid->raw[2],
+		       gid->raw[3], gid->raw[4], gid->raw[5], gid->raw[6],
+		       gid->raw[7], gid->raw[8], gid->raw[9], gid->raw[10],
+		       gid->raw[11], gid->raw[12], gid->raw[13], gid->raw[14],
+		       gid->raw[15], str);
+	}
+
+	if (type == IBV_GID_TYPE_ROCE_V2) {
+		inet_ntop(AF_INET6, gid->raw, gid_str, sizeof(gid_str));
+		printf("\t\t\tGID[%3d]:\t\t%s\n", i, gid_str);
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
@@ -175,17 +213,15 @@ static int print_all_port_gids(struct ibv_context *ctx, uint8_t port_num, int tb
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
@@ -614,7 +650,7 @@ static int print_hca_cap(struct ibv_device *ib_dev, uint8_t ib_port)
 				printf("\t\t\tphys_state:\t\t%s (%d)\n",
 				       port_phy_state_str(port_attr.phys_state), port_attr.phys_state);
 
-			if (print_all_port_gids(ctx, port, port_attr.gid_tbl_len))
+			if (print_all_port_gids(ctx, &port_attr, port))
 				goto cleanup;
 		}
 		printf("\n");
-- 
1.8.3.1

