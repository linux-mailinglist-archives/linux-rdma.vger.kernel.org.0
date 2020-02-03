Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAB18150188
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2020 06:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgBCFrf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Feb 2020 00:47:35 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39070 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgBCFrf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Feb 2020 00:47:35 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so5387623plp.6
        for <linux-rdma@vger.kernel.org>; Sun, 02 Feb 2020 21:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/ll8Rpx/qKkU5yOL85VmmWmdk90cwP/YP44shvLoACY=;
        b=aRhYnripQO+553QsnUemqbV+3gP0ougiTjiVh6naQyQcc4rvorLIgcz09QztfrbYO8
         /YTqLL0kX9C4F4JFjfu/QjBJWDFkrhtOYZt7E4mPEXOYfuZ06O4oEgjBvnDxoMH6PNnO
         86wSlf5LKSy0rgJGAFW5SHy5oNmq8O7PJzUXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/ll8Rpx/qKkU5yOL85VmmWmdk90cwP/YP44shvLoACY=;
        b=Ys5wbJ7HzAWuo0LQ+G+PFIUW8IiXxjvZUxscLgOPCoNBscdBg0//wW63KY0hVhykMd
         OrFrzC1o7hxZh31lhClQUViR8g90J6vU/csOYCgwgVw0Vt0M+Am5PMA1Z93qqG07McdT
         RjfjQYVgsgmr5amgxkpTFGDioxAYC9SeIm8U3ajct2FqacIDuj20u9K/H2ZMBuTg51g2
         W4TBd2Uid1WZDzZcPBIqgpjlmouxR9KH61QjYIAUG+m+PQ4mye8vFT5QyLBcd9j1q7CF
         fPo+F2BBvpFi12VGl9cCrSvgLL0R8f/HvzhueHz1F6hHtM757KAZB7gYZdnsc1IWmaGW
         n8wA==
X-Gm-Message-State: APjAAAUNx7Wb30DfNMFe948dCk1bPDIFABj2Vq7n0pWCOu6vmRfTTurz
        lIpZgZAsIVhmibnpNmKG5yLA+dDim7U2lCxbrULXF2vdrh6un1Wifrh0sGL8wEXdv6vy+wdoifw
        j0bDX9zjudLsSJG8EE/2Ma3wLwV4rWBxCaiQSVg9WtA/36P7yDjN7jD5wwmPyJthDe6IKyVT2Gx
        aeQpM=
X-Google-Smtp-Source: APXvYqxiLA2OI0xfa8Fiozc1vtpdWsL1cJz2r9sZ6OlvFYx2vCYHLYvZZBju/kpBGHx/6rnWcpkXEQ==
X-Received: by 2002:a17:90a:1951:: with SMTP id 17mr27865691pjh.101.1580708854155;
        Sun, 02 Feb 2020 21:47:34 -0800 (PST)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r7sm19008086pfg.34.2020.02.02.21.47.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Feb 2020 21:47:33 -0800 (PST)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, leon@kernel.org
Subject: [PATCH v3] rdma-core/libibverbs: display gid type in ibv_devinfo
Date:   Mon,  3 Feb 2020 00:47:26 -0500
Message-Id: <1580708846-10851-1-git-send-email-devesh.sharma@broadcom.com>
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
 libibverbs/examples/devinfo.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/libibverbs/examples/devinfo.c b/libibverbs/examples/devinfo.c
index bf53eac..bbaed8c 100644
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
@@ -175,8 +185,15 @@ static int print_all_port_gids(struct ibv_context *ctx, uint8_t port_num, int tb
 			       port_num, i);
 			return rc;
 		}
+
+		rc = ibv_query_gid_type(ctx, port_num, i, &type);
+		if (rc) {
+			rc = 0;
+			type = 0x2;
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

