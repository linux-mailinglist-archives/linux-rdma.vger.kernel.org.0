Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 412BB150A5E
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2020 16:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgBCP5H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Feb 2020 10:57:07 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45819 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727747AbgBCP5H (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Feb 2020 10:57:07 -0500
Received: by mail-wr1-f65.google.com with SMTP id a6so18841468wrx.12
        for <linux-rdma@vger.kernel.org>; Mon, 03 Feb 2020 07:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=AXh6HfAHmaTNJ/TDHQC2y4kgMFxbl4zV24ByXVcAWqw=;
        b=KBnCRyckKc8Knblobs9B8qL8QrYG5ycGvwvZswJEMa7t3Lx89i4eqBdNnutTRYy4yI
         LVWbYRq7pJPE9WGLz7XU+hbSalWirXl6J7agLHqeuBiB2ZjDPGDt+9Be5oRzMKMlYT47
         KLTUWhR7WokkigcJg9lwPQu3/yZ3LNmfeszq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AXh6HfAHmaTNJ/TDHQC2y4kgMFxbl4zV24ByXVcAWqw=;
        b=NHDQJOPVTXKI/FIvEMuwi3yo0Wk9Gxw9W0kJ/Nob1vl6+LG6731WLdvLJqSlWG+PW3
         9Ibbajq+SeTGItBx/4hFflrLTEDQI/YCufjNyjHTJBVu19Yb70toAdsYCfIV00jqlt0U
         696cb92Svv4ZuwISY8x27Z124DYXK4ZMdyEWabBz+ia6xW4If7v1OGssWRvu+EO6WbGz
         mVaFIHwvaSudwEgV8c8ZRrxnf17AfL1hTwksRJYsBf0iWuIryPEF37G2czfR55xtPpQ7
         5L92JysTrSQWLPi/HSeOxJVsOval48ekxDuu7bu47Fz3DTcU27U8P7OZphCEEUP9PZAD
         AtKg==
X-Gm-Message-State: APjAAAVn14Y7dMJBSvbNXmwf6GVD+8GoOy8F+xwtgzXfl35Hy8ZZWpdc
        GsmUn3fqVsYH0BMlSj7nl+m+XyzrnEnh5mE2Jhw+qic1E72RKz3XLrO+nwfb6W/8AHJ8dmTvXHd
        NX0yt0lhmPmD8RbxJsGxh3n6E2NX+I/erSwa4MvNnCMJ7/dGpOTttt/ieaMYOFCDsGe+46tITDX
        OORlk=
X-Google-Smtp-Source: APXvYqxqUQxIN2PoPM8zCc+dwnf2gWV0Q8p0ToTv6+nudwuw8I0uE5LgEJmkXZG2NHIeZYsAPIANfg==
X-Received: by 2002:a5d:6284:: with SMTP id k4mr16816302wru.398.1580745425243;
        Mon, 03 Feb 2020 07:57:05 -0800 (PST)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id s22sm23246556wmh.4.2020.02.03.07.57.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Feb 2020 07:57:04 -0800 (PST)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, leon@kernel.org
Subject: [PATCH v4] libibverbs: display gid type in ibv_devinfo
Date:   Mon,  3 Feb 2020 10:56:55 -0500
Message-Id: <1580745415-19744-1-git-send-email-devesh.sharma@broadcom.com>
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
       GID[  0]:        fe80:0000:0000:0000:b226:28ff:fed3:b0f0, IB/RoCE v1
       GID[  1]:        fe80:0000:0000:0000:b226:28ff:fed3:b0f0, RoCE v2
       GID[  2]:        0000:0000:0000:0000:0000:ffff:c0aa:0165, IB/RoCE v1
       GID[  3]:        0000:0000:0000:0000:0000:ffff:c0aa:0165, RoCE v2
$
$

Reviewed-by: Leon Romanovsky <leon@kernel.org>
Reviewed-by: Gal Pressman <galpress@amazon.com>
Reviewed-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 libibverbs/driver.h           |  1 +
 libibverbs/examples/devinfo.c | 22 ++++++++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

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
index bf53eac..5bf1a39 100644
--- a/libibverbs/examples/devinfo.c
+++ b/libibverbs/examples/devinfo.c
@@ -162,8 +162,18 @@ static const char *vl_str(uint8_t vl_num)
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
+	enum ibv_gid_type type;
 	union ibv_gid gid;
 	int rc = 0;
 	int i;
@@ -175,8 +185,15 @@ static int print_all_port_gids(struct ibv_context *ctx, uint8_t port_num, int tb
 			       port_num, i);
 			return rc;
 		}
+
+		rc = ibv_query_gid_type(ctx, port_num, i, &type);
+		if (rc) {
+			rc = 0;
+			type = IBV_GID_TYPE_INVALID;
+		}
+
 		if (!null_gid(&gid))
-			printf("\t\t\tGID[%3d]:\t\t%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x\n",
+			printf("\t\t\tGID[%3d]:\t\t%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x, %s\n",
 			       i,
 			       gid.raw[ 0], gid.raw[ 1],
 			       gid.raw[ 2], gid.raw[ 3],
@@ -185,7 +202,8 @@ static int print_all_port_gids(struct ibv_context *ctx, uint8_t port_num, int tb
 			       gid.raw[ 8], gid.raw[ 9],
 			       gid.raw[10], gid.raw[11],
 			       gid.raw[12], gid.raw[13],
-			       gid.raw[14], gid.raw[15]);
+			       gid.raw[14], gid.raw[15],
+			       gid_type_str(type));
 	}
 	return rc;
 }
-- 
1.8.3.1

