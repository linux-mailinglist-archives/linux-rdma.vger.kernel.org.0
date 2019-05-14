Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F30AD1E5EB
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 02:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfEOALN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 May 2019 20:11:13 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42919 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfEOALM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 May 2019 20:11:12 -0400
Received: by mail-qk1-f193.google.com with SMTP id d4so414296qkc.9
        for <linux-rdma@vger.kernel.org>; Tue, 14 May 2019 17:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nNqDgtCqZVyfQ2EwawOl6xMn4dWOVkWKcnC+Xx6E71M=;
        b=TVRd076zGXN3z5268XQYt7cj3ohCmHQUXMNAVbzASa8sLpzCW5QYbcTZ3iN7586Yil
         r5hAl1mcMH0ooJ17FsXC/RdTCoQ92UME2GFTs4vWxiwpwXuml1LKT5dHqNDjfqFPxfLV
         gEaxwPG1phBnH+1siXJVaBAlx6aaUxjnhMNkxTrXCf2qRsIj2OKnoNdjBvArcjH9ckKH
         CF2BEDYfECEuPjl9D+SYMCv1QPknRgnnke3Nyy+PNngJqdK6FFEud/SceHQ1JsvnQRhd
         6ez6t7MyBX7IPAkALX4uq2bQ6Toqfy8tzK3Hj506r1+91H1j94kD7ZORVCE8BgcjP+Sp
         sHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nNqDgtCqZVyfQ2EwawOl6xMn4dWOVkWKcnC+Xx6E71M=;
        b=JJkVAuCFtEFswZvA5pDJpm0TyL0IZVMeYH3fCMuQya/YLNhE/856m6U6rxqEcr0zpY
         zr155sDlLpmEBa6SgMYSaKG/tusPkbVC5NDTaMkGBeWEwfu1SZhTZOuTBFi1wci5LPvR
         KyHpvmqQBCI4Wlyw1av+E4xiQXvwLDD0j3JS0DUzzZ2QqmSGD+FmdEciVPRiTaiF85XS
         5gtPYN7jGtSqu4zByHaGAgAGwwTobDKjkibeMCNYTpwkOZD1SyMquJnkzmVytruwY11w
         IRvYxf9BmuruPQi8/IBopq747sKBEplkypMzeJFkw1y5yxFQasJGFoREu2drVi5bJYwp
         WDSg==
X-Gm-Message-State: APjAAAVtAxpaHDQWebdPjR5hWQRLxazJgkBjYxe8xs1DXuaFmFuErBEj
        USfO0kWLcNEWRNp84IotIfzwaqq0RlE=
X-Google-Smtp-Source: APXvYqwK1QHqdm3PoO2yrHjJjOBaXFqsUFYXSBeAR2Pr5bTBxWFSt2ZAB3bp2sc9W4qXhfBsNs0qAA==
X-Received: by 2002:a37:6c84:: with SMTP id h126mr31564946qkc.168.1557879071517;
        Tue, 14 May 2019 17:11:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id o10sm249584qtg.5.2019.05.14.17.11.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 17:11:11 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hQhAx-0001O0-9Y; Tue, 14 May 2019 20:49:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 14/20] ibdiags: Obsolete mad_osd.h
Date:   Tue, 14 May 2019 20:49:30 -0300
Message-Id: <20190514234936.5175-15-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190514234936.5175-1-jgg@ziepe.ca>
References: <20190514234936.5175-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

No need for this public header included in only one place with definitions
that should not even exist in the public namespace.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 ibdiags/libibmad/include/infiniband/mad.h     | 13 ++++-
 ibdiags/libibmad/include/infiniband/mad_osd.h | 50 +------------------
 2 files changed, 13 insertions(+), 50 deletions(-)

diff --git a/ibdiags/libibmad/include/infiniband/mad.h b/ibdiags/libibmad/include/infiniband/mad.h
index c95f1b10d08610..b36544988bfafd 100644
--- a/ibdiags/libibmad/include/infiniband/mad.h
+++ b/ibdiags/libibmad/include/infiniband/mad.h
@@ -35,7 +35,18 @@
 #ifndef _MAD_H_
 #define _MAD_H_
 
-#include <infiniband/mad_osd.h>
+#include <stdint.h>
+#include <string.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <byteswap.h>
+#include <inttypes.h>
+#include <arpa/inet.h>
+
+#define MAD_EXPORT
+#define DEPRECATED __attribute__ ((deprecated))
 
 #ifdef __cplusplus
 #  define BEGIN_C_DECLS extern "C" {
diff --git a/ibdiags/libibmad/include/infiniband/mad_osd.h b/ibdiags/libibmad/include/infiniband/mad_osd.h
index 923be55ef95c93..061001bb8f82a6 100644
--- a/ibdiags/libibmad/include/infiniband/mad_osd.h
+++ b/ibdiags/libibmad/include/infiniband/mad_osd.h
@@ -1,49 +1 @@
-/*
- * Copyright (c) 2004-2009 Voltaire Inc.  All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *      - Redistributions of source code must retain the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer.
- *
- *      - Redistributions in binary form must reproduce the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer in the documentation and/or other materials
- *        provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
- *
- */
-#ifndef _MAD_OSD_H_
-#define _MAD_OSD_H_
-
-#include <stdint.h>
-#include <string.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <sys/types.h>
-#include <unistd.h>
-#include <byteswap.h>
-#include <inttypes.h>
-#include <arpa/inet.h>
-
-#define MAD_EXPORT
-#define DEPRECATED __attribute__ ((deprecated))
-
-#endif				/* _MAD_OSD_H_ */
+#warning "This header is obsolete."
-- 
2.21.0

