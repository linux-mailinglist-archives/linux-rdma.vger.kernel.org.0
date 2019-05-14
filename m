Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30C571E5C0
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 01:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfENXtl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 May 2019 19:49:41 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33334 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfENXtl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 May 2019 19:49:41 -0400
Received: by mail-qk1-f193.google.com with SMTP id k189so424445qkc.0
        for <linux-rdma@vger.kernel.org>; Tue, 14 May 2019 16:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QbtdrFqkxPgdgaXBQcuFFa/5Tuj+fTnf34Xq/VloPvE=;
        b=ZA6pR3GDDOoi8TGBm+OQ9lMnqHXtc+pqi63JEP2vQvuqvoh3U11W3/wGQgjCB3AoIZ
         e4eyRlgu2O1J1RZAbI61yMOjrgic3lQ6mA/PM8EnDXOyl5hZVwTufQU6LLpSf5f3iNe2
         /Bcv/lLcYR3aASbZSdQTjE/H0pf7Tm474NNdWazx/mE8x6VbnS3QM94V85Rqpa+lHPeO
         BdqYFi30AdN5ScbrX+TuHvkwHTtr+F8v7jMOukSzA5sDyLBJyBStlEhQsfDGdeAmTOGV
         v+LhKE+vk9++foFMCiEW80rgA1JZyM3OfuRLiNTUxvilXigrlOvRBg7QkOU5t6n9Ivxb
         XphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QbtdrFqkxPgdgaXBQcuFFa/5Tuj+fTnf34Xq/VloPvE=;
        b=rLCJJtCjuVAn6meQzVcCjwESlgGWc15T1l+We9fP8fNSNLx6t8oFFodeTjv1Bpqyxk
         1iv7/AEau1/h6MzQn5rbELD30QJBo2lTtX0j2c/6jsm0cq17qgpJdwyqp1ioonkQOdrC
         xCpHxI6iOTQXSY+pOKWj3s2GP5MCEaggnNR906KBPktSSFBrxYh5dPrgt4JkkwZoqtRC
         SFRlx0nvOcaGlWTo3YZSzlMd6jqeetM1aoC9NHMn9qW9VD05WVy+7ZOoTspFZzQJVn9a
         fFCvZG9V9awB0dkfSFBzOSNAzyaQIlsNrtu5gAkNwLueHizauX8FRtvczL5ieYy++ses
         x8Lg==
X-Gm-Message-State: APjAAAUiQQ3f6K/Si6rvvi8HmK4EJPlJgxZVpmRLzTLfCk789YuRzMFn
        iNI9FtbryI/zgM1RPDzmpTJuNZFabjA=
X-Google-Smtp-Source: APXvYqyt+EDQaw8fmnxVTl9o4aYttjmtcILZgGFqNgaBfpiH56jcG2OOlTUoZKysMx7tMuT2MxxP5Q==
X-Received: by 2002:a37:9b88:: with SMTP id d130mr28810709qke.278.1557877780203;
        Tue, 14 May 2019 16:49:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id j29sm143302qki.39.2019.05.14.16.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 16:49:39 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hQhAw-0001Mp-Mk; Tue, 14 May 2019 20:49:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 02/20] ibdiags: Add required definitions to rdma-core config.h
Date:   Tue, 14 May 2019 20:49:18 -0300
Message-Id: <20190514234936.5175-3-jgg@ziepe.ca>
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

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 CMakeLists.txt              | 2 ++
 buildlib/config.h.in        | 4 ++++
 ibdiags/src/ibdiag_common.c | 5 ++---
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 31100e267f2150..5cb3c32c318821 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -97,6 +97,8 @@ set(BUILD_STATIC_LIB ${CMAKE_BINARY_DIR}/lib/statics)
 set(BUILD_ETC ${CMAKE_BINARY_DIR}/etc)
 set(BUILD_PYTHON ${CMAKE_BINARY_DIR}/python)
 
+set(IBDIAG_CONFIG_PATH "${CMAKE_INSTALL_FULL_SYSCONFDIR}/infiniband-diags")
+
 set(CMAKE_INSTALL_INITDDIR "${CMAKE_INSTALL_SYSCONFDIR}/init.d"
   CACHE PATH "Location for init.d files")
 set(CMAKE_INSTALL_SYSTEMD_SERVICEDIR "${CMAKE_INSTALL_PREFIX}/lib/systemd/system"
diff --git a/buildlib/config.h.in b/buildlib/config.h.in
index 0754d249423476..b4cb669b7be4bf 100644
--- a/buildlib/config.h.in
+++ b/buildlib/config.h.in
@@ -7,6 +7,8 @@
 #define HAVE_ISBLANK 1
 #define HAVE_BUILTIN_CLZL 1
 
+#define PACKAGE_VERSION "@PACKAGE_VERSION@"
+
 // FIXME: Remove this, The cmake version hard-requires new style CLOEXEC support
 #define STREAM_CLOEXEC "e"
 
@@ -29,6 +31,8 @@
 #define IBACM_IBACME_SERVER_PATH "@CMAKE_INSTALL_FULL_RUNDIR@/" IBACM_SERVER_BASE
 #define IBACM_SERVER_PATH "@CMAKE_INSTALL_FULL_RUNDIR@/ibacm.sock"
 
+#define IBDIAG_CONFIG_PATH "@IBDIAG_CONFIG_PATH@"
+
 #define VERBS_PROVIDER_DIR "@VERBS_PROVIDER_DIR@"
 #define VERBS_PROVIDER_SUFFIX "@IBVERBS_PROVIDER_SUFFIX@"
 #define IBVERBS_PABI_VERSION @IBVERBS_PABI_VERSION@
diff --git a/ibdiags/src/ibdiag_common.c b/ibdiags/src/ibdiag_common.c
index 293b9afce0a021..a5056ad244c7c3 100644
--- a/ibdiags/src/ibdiag_common.c
+++ b/ibdiags/src/ibdiag_common.c
@@ -58,7 +58,6 @@
 #include <infiniband/umad.h>
 #include <infiniband/mad.h>
 #include <ibdiag_common.h>
-#include <ibdiag_version.h>
 
 int ibverbose;
 enum MAD_DEST ibd_dest_type = IB_DEST_LID;
@@ -84,8 +83,8 @@ static const struct ibdiag_opt *opts_map[256];
 
 static const char *get_build_version(void)
 {
-	return "BUILD VERSION: " IBDIAG_VERSION " Build date: " __DATE__ " "
-	    __TIME__;
+	return "BUILD VERSION: " PACKAGE_VERSION " Build date: " __DATE__
+	       " " __TIME__;
 }
 
 static void pretty_print(int start, int width, const char *str)
-- 
2.21.0

