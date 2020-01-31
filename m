Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F89A14F1BF
	for <lists+linux-rdma@lfdr.de>; Fri, 31 Jan 2020 19:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbgAaSAc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 31 Jan 2020 13:00:32 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36325 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgAaSAc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 31 Jan 2020 13:00:32 -0500
Received: by mail-pg1-f196.google.com with SMTP id k3so3866134pgc.3
        for <linux-rdma@vger.kernel.org>; Fri, 31 Jan 2020 10:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=fneNemG3ESnYMTqrLkg8cJV4G3CYCJHRbcxOlqMQLhs=;
        b=d0ovGnUq23kFhkzVhhrvud7pArZ+baVphE4OyWZgB6YtOxSx4ZNf074gcJlywJA/UV
         CZJEYUgVBQRUB//RZ8kHSgHd3o2eBIfzUedXBvZVQT6wDg2dXoQBrridYOofjUxude07
         TheOiALRL/9H+m5Iugo60kwMoXy4FvcvZ7MnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fneNemG3ESnYMTqrLkg8cJV4G3CYCJHRbcxOlqMQLhs=;
        b=UX8RqMhJCycm0DPaWwsMer01MWJl80F1+ogNq+EEvNTyt1m38wY2OkZoLIlMcWbARY
         ZjBOMel4uHf+tjtwMDi8j/ZoV6y0xUPFheuQ8IDHnS13iRMJsd6ESHEpYzeKM+XVuiQE
         +ddn091sMncB3o+sx9uXTLxK8fQ0hEQowGBMt9VII+1u7rTFhlBSUWHglsBIV8ASa7/p
         lVFk7XCPUidkBglNmA2DDCNdMxNIL5jeldk3FYlpjUbk568DP3hc3EyYKx+H8R/qseMX
         vMVnfRgwDN22q065iDrOkqdP2v/FgsYCF+FmGajiylvU470YMC9nDkNllsWWNAbIzdWx
         s0mQ==
X-Gm-Message-State: APjAAAWSycrdZy7oSsvzVI0AmvTWBtdCTo9X09Ku4DNpT2FTtv3aST6h
        sAbeZr2yxNHyeyjaYrODT+OmzzMgegZc5nHApvtSjhIVD4OriYOg/QNE/v8Vz15IOeJ87Eb4rp7
        +uOqpwvxA7ziKECJ/sLPSTu0ve6ZMmfKMQ2H619csjngf/3KXOKKL51sOk/VoiNklnijPZSWj3Q
        Iq7pM=
X-Google-Smtp-Source: APXvYqyxQnr7Kv0joIh24pX3EXPnL1YySHPdKf2+7+ahHaueo8NWHiSQXvSsXm/B9/1jtgKa4YVgVg==
X-Received: by 2002:a65:5ccc:: with SMTP id b12mr11430765pgt.124.1580493630050;
        Fri, 31 Jan 2020 10:00:30 -0800 (PST)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id w26sm11023735pfj.119.2020.01.31.10.00.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jan 2020 10:00:29 -0800 (PST)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, leon@kernel.org
Subject: [PATCH v2] rdma-core/libibverbs: display gid type in ibv_devinfo
Date:   Fri, 31 Jan 2020 13:00:21 -0500
Message-Id: <1580493621-31006-1-git-send-email-devesh.sharma@broadcom.com>
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
 libibverbs/examples/devinfo.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/libibverbs/examples/devinfo.c b/libibverbs/examples/devinfo.c
index bf53eac..4094ea0 100644
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
@@ -175,8 +185,17 @@ static int print_all_port_gids(struct ibv_context *ctx, uint8_t port_num, int tb
 			       port_num, i);
 			return rc;
 		}
+
+		rc = ibv_query_gid_type(ctx, port_num, i, &type);
+		if (rc) {
+			rc = 0;
+			type = 0x2;
+			fprintf(stderr, "Failed to query gid type to port %d, index %d\n",
+				port_num, i);
+		}
+
 		if (!null_gid(&gid))
-			printf("\t\t\tGID[%3d]:\t\t%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x\n",
+			printf("\t\t\tGID[%3d]:\t\t%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x:%02x%02x, %s\n",
 			       i,
 			       gid.raw[ 0], gid.raw[ 1],
 			       gid.raw[ 2], gid.raw[ 3],
@@ -185,7 +204,8 @@ static int print_all_port_gids(struct ibv_context *ctx, uint8_t port_num, int tb
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

