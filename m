Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8286514EAA4
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Jan 2020 11:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgAaKdI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 Jan 2020 05:33:08 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51167 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbgAaKdH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 31 Jan 2020 05:33:07 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so7304560wmb.0
        for <linux-rdma@vger.kernel.org>; Fri, 31 Jan 2020 02:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=vzYKhNIVweTe+FtOdo1RHMZJiZw9WeQ2mqqX6TPzq/0=;
        b=EEVHWJTsOhm4RR+hOi+pV+VPij02WJD/7sE8CKCkGdNAd4ThznED68kWvzw8gDAxKS
         PO3rWAFbID6br5bm5+byCQxvMKPAn6RvS4gJ6nn0TiAEgKOvXZnpFcHlTBYFhSItW1fj
         BZhszfxGqnRuOje33mAd7s15O4Eu4u/3Y1Yog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vzYKhNIVweTe+FtOdo1RHMZJiZw9WeQ2mqqX6TPzq/0=;
        b=TvruY0BRAz5Wf0Uw76kotJz5T8FEsd+oHfwe3hqK81CjnFKl0eIQL1u1St+S3uOvtj
         nl2gfwoYIrfFpLfRfa4MdPFT6DxexXv0ZOmsGfJAlX/gnsHcxUvTfGq4/fl9tFDNgIHw
         quhGWddLuA5F0lIcY8PQxHfvxvhPie4yq9BG6oxOJ5iS2Cfx/f4WTrWgvX02Us88PtHX
         WFThUselFsTIF5ICShnDhwB4AtOP4rh4gBGdThL+sR3A02Oz8FkkxfWfrJKPJe3EP3aI
         vcnjfWPEk5QM4DFGc20uEnEVEdIhjGoTw1K+dWF7MtwvObdqieCv2NGrPefMjxLDpWqu
         SiEw==
X-Gm-Message-State: APjAAAVwLxMbKsLTNDH3bGsDMWHzZKGq74mxdg3VNHOcFO1RwTC9m4SG
        9Z/nfL7akMiPNb9Uz/aF+YhHzuTaCuL+r3Rg3DuQEfBiVR9qm8ePmgI84+emiLRQf6popVsrqjZ
        wtCOBDbTmRKxS8jmS+z6XGsUyhDxIoREy8ULwCCufRl758BYmGfIsU69xk489sSyWQqXRY/A2X6
        6IkwI=
X-Google-Smtp-Source: APXvYqzXhQfhfUek6ea6p4KKxxa/gdkH6c/C+6V/yCe7/zGG+Y72urW514E8pi0Pg9l8QruB5nhXXQ==
X-Received: by 2002:a7b:c3c9:: with SMTP id t9mr11117762wmj.18.1580466785101;
        Fri, 31 Jan 2020 02:33:05 -0800 (PST)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r6sm11970647wrq.92.2020.01.31.02.33.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jan 2020 02:33:04 -0800 (PST)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, leon@kernel.org
Subject: [PATCH] rdma-core/libibverbs: display gid type in ibv_devinfo
Date:   Fri, 31 Jan 2020 05:32:53 -0500
Message-Id: <1580466773-24342-1-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

It becomes difficult to make out from the output of ibv_devinfo
if a particular gid index is RoCE v2 or not.

Adding a string to the output of ibv_devinfo -v to display the
gid type at the end of gid.

Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 libibverbs/examples/devinfo.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/libibverbs/examples/devinfo.c b/libibverbs/examples/devinfo.c
index bf53eac..63988ba 100644
--- a/libibverbs/examples/devinfo.c
+++ b/libibverbs/examples/devinfo.c
@@ -162,8 +162,18 @@ static const char *vl_str(uint8_t vl_num)
 	}
 }
 
+static const char *gid_type_str(enum ibv_gid_type type)
+{
+	switch (type) {
+	case 0: return "IB/RoCE v1";
+	case 1: return "RoCE v2";
+	default: return "invalid value";
+	}
+}
+
 static int print_all_port_gids(struct ibv_context *ctx, uint8_t port_num, int tbl_len)
 {
+	enum ibv_gid_type type;
 	union ibv_gid gid;
 	int rc = 0;
 	int i;
@@ -175,8 +185,16 @@ static int print_all_port_gids(struct ibv_context *ctx, uint8_t port_num, int tb
 			       port_num, i);
 			return rc;
 		}
+
+		rc = ibv_query_gid_type(ctx, port_num, i, &type);
+		if (rc) {
+			fprintf(stderr, "Failed to query gid type to port %d, index %d\n",
+				port_num, i);
+			return rc;
+		}
+
 		if (!null_gid(&gid))
-			printf("\t\t\tGID[%3d]:\t\t%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x\n",
+			printf("\t\t\tGID[%3d]:\t\t%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x, %s\n",
 			       i,
 			       gid.raw[ 0], gid.raw[ 1],
 			       gid.raw[ 2], gid.raw[ 3],
@@ -185,7 +203,8 @@ static int print_all_port_gids(struct ibv_context *ctx, uint8_t port_num, int tb
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

