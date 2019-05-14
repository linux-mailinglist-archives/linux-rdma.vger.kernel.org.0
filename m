Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72CF41E5E7
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 02:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfEOALK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 May 2019 20:11:10 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46666 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbfEOALJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 May 2019 20:11:09 -0400
Received: by mail-qk1-f194.google.com with SMTP id a132so396069qkb.13
        for <linux-rdma@vger.kernel.org>; Tue, 14 May 2019 17:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=59b8x1edAQWmwSWxl8VW8jf4z3L4GbINoJZWNaUB12I=;
        b=V+/9i2/mw3Eu3kU8rOS9fZPBwQpujc70mg2+P2uKooDow/TE+2/zDLFLwF4F8i/HBb
         KhgbNa3Uj32K1dsNGz1BX+2ar2Aee9J6iDOv2bY0edU6biK6nA4cL393DV1N3nxHpoSp
         BFNcMlgsOpGN69jMFvNTyKjn0SGMRf9LwG94lRcK4Q0SZreU81R6JDKA7Zxb86fCFRl6
         GwtIMQkqGetlGihTWIDz/kFzlROpFRUrBB6qGJebBWLdTOoF7fhuaP7w5iEfSOe5rwvW
         mGyBQK+0xxGGO1qV+JSsau+COSJH2d+61JS+K25hePU9P10AvCQIWh3AHOCyUguZ7Mk3
         72KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=59b8x1edAQWmwSWxl8VW8jf4z3L4GbINoJZWNaUB12I=;
        b=TUz5U99VcrLYHyjr0ZXlInkZTq3tB5qoBY5RVRe1Ll5JwtHtKCgk10TTRVsXt0H70G
         qgi8e404GhW9kKpBINLVgSQAECGY5OQMDefb5nTHvV2qv250tALtwI+zxYzOB5CjbH75
         0RNqT5hjIwQiV9zYa+ekkc8yjg8p7VLeiaZwO7kbSuSanYNJa1kDp4Wmpn0cfMQBjN0n
         1M8dfeMW3GGdcA+Fp5LTHsSC9wha2/x9bQHMFqi/0yaHLK4V4pppFLHO1Ylqqubz6JmW
         kL0MFlvMyM9gu+NgJ1mPtc6M53lp+QmMTAPEuMQlYqTJhYZT62POpqMyhLvmd66Eytui
         AwDg==
X-Gm-Message-State: APjAAAUvRPcnn+VT8JfCDZbme1v+KIamJd0bvgnJ1BQC6Cbm+2G67jU9
        hGAZtjHPcxjgkHzhJlW+7vwxzMwwEA8=
X-Google-Smtp-Source: APXvYqxoUQHEcobqKKimkmoZNxqY8MYLiQTAQgjy+rGFhWkTCyd5fyarqZZFzgyx90uo8TrZ1ZWQvQ==
X-Received: by 2002:a37:4d81:: with SMTP id a123mr13113771qkb.340.1557879068304;
        Tue, 14 May 2019 17:11:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id n201sm150322qka.10.2019.05.14.17.11.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 17:11:07 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hQhAx-0001OU-H2; Tue, 14 May 2019 20:49:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 19/20] ibdiags: Remove @BUILD_DATE@ from the man pages
Date:   Tue, 14 May 2019 20:49:35 -0300
Message-Id: <20190514234936.5175-20-jgg@ziepe.ca>
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

The man page date should be related to the last edit to the man page.
Extract this from git using:

import sys, os, subprocess, datetime

for I in sys.argv[1:]:
    lns = subprocess.check_output(["git","log","--pretty=format:%ct %cn %s","--follow",I]).splitlines()
    while b"Jason Gunthorpe" in lns[0]:
        del lns[0]
    ts = lns[0].split(b' ')[0]
    date = datetime.datetime.utcfromtimestamp(int(ts)).strftime('%Y-%m-%d')
    subprocess.check_call(["sed","-i","-e","s/@BUILD_DATE@/%s/g"%(date),I])

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 infiniband-diags/man/CMakeLists.txt             | 2 --
 infiniband-diags/man/check_lft_balance.8.in.rst | 2 +-
 infiniband-diags/man/dump_fts.8.in.rst          | 2 +-
 infiniband-diags/man/ibaddr.8.in.rst            | 2 +-
 infiniband-diags/man/ibcacheedit.8.in.rst       | 2 +-
 infiniband-diags/man/ibccconfig.8.in.rst        | 2 +-
 infiniband-diags/man/ibccquery.8.in.rst         | 2 +-
 infiniband-diags/man/ibfindnodesusing.8.in.rst  | 2 +-
 infiniband-diags/man/ibhosts.8.in.rst           | 2 +-
 infiniband-diags/man/ibidsverify.8.in.rst       | 2 +-
 infiniband-diags/man/iblinkinfo.8.in.rst        | 2 +-
 infiniband-diags/man/ibnetdiscover.8.in.rst     | 2 +-
 infiniband-diags/man/ibnodes.8.in.rst           | 2 +-
 infiniband-diags/man/ibping.8.in.rst            | 2 +-
 infiniband-diags/man/ibportstate.8.in.rst       | 2 +-
 infiniband-diags/man/ibqueryerrors.8.in.rst     | 2 +-
 infiniband-diags/man/ibroute.8.in.rst           | 2 +-
 infiniband-diags/man/ibrouters.8.in.rst         | 2 +-
 infiniband-diags/man/ibstat.8.in.rst            | 2 +-
 infiniband-diags/man/ibstatus.8.in.rst          | 2 +-
 infiniband-diags/man/ibswitches.8.in.rst        | 2 +-
 infiniband-diags/man/ibsysstat.8.in.rst         | 2 +-
 infiniband-diags/man/ibtracert.8.in.rst         | 2 +-
 infiniband-diags/man/infiniband-diags.8.in.rst  | 2 +-
 infiniband-diags/man/perfquery.8.in.rst         | 2 +-
 infiniband-diags/man/saquery.8.in.rst           | 2 +-
 infiniband-diags/man/sminfo.8.in.rst            | 2 +-
 infiniband-diags/man/smpdump.8.in.rst           | 2 +-
 infiniband-diags/man/smpquery.8.in.rst          | 2 +-
 infiniband-diags/man/vendstat.8.in.rst          | 2 +-
 30 files changed, 29 insertions(+), 31 deletions(-)

diff --git a/infiniband-diags/man/CMakeLists.txt b/infiniband-diags/man/CMakeLists.txt
index 845fff675f23d4..916a52dcab6cb0 100644
--- a/infiniband-diags/man/CMakeLists.txt
+++ b/infiniband-diags/man/CMakeLists.txt
@@ -1,5 +1,3 @@
-set(BUILD_DATE "2019")
-
 # rst2man has no way to set the include search path
 rdma_create_symlink("${CMAKE_CURRENT_SOURCE_DIR}/common" "${CMAKE_CURRENT_BINARY_DIR}/common")
 
diff --git a/infiniband-diags/man/check_lft_balance.8.in.rst b/infiniband-diags/man/check_lft_balance.8.in.rst
index 2639a20297ffdf..92b7a8a4c470f4 100644
--- a/infiniband-diags/man/check_lft_balance.8.in.rst
+++ b/infiniband-diags/man/check_lft_balance.8.in.rst
@@ -6,7 +6,7 @@ check_lft_balance
 check InfiniBand unicast forwarding tables balance
 --------------------------------------------------
 
-:Date: @BUILD_DATE@
+:Date: 2017-08-21
 :Manual section: 8
 :Manual group: Open IB Diagnostics
 
diff --git a/infiniband-diags/man/dump_fts.8.in.rst b/infiniband-diags/man/dump_fts.8.in.rst
index 9b2df5195d1294..a932bc14380816 100644
--- a/infiniband-diags/man/dump_fts.8.in.rst
+++ b/infiniband-diags/man/dump_fts.8.in.rst
@@ -6,7 +6,7 @@ DUMP_FTS
 dump InfiniBand forwarding tables
 ---------------------------------
 
-:Date: @BUILD_DATE@
+:Date: 2013-03-26
 :Manual section: 8
 :Manual group: OpenIB Diagnostics
 
diff --git a/infiniband-diags/man/ibaddr.8.in.rst b/infiniband-diags/man/ibaddr.8.in.rst
index ac18bbf235161a..be080dea8c69e1 100644
--- a/infiniband-diags/man/ibaddr.8.in.rst
+++ b/infiniband-diags/man/ibaddr.8.in.rst
@@ -6,7 +6,7 @@ IBADDR
 query InfiniBand address(es)
 ----------------------------
 
-:Date: @BUILD_DATE@
+:Date: 2013-10-11
 :Manual section: 8
 :Manual group: OpenIB Diagnostics
 
diff --git a/infiniband-diags/man/ibcacheedit.8.in.rst b/infiniband-diags/man/ibcacheedit.8.in.rst
index 69028cd7d36788..d287142b3c30b4 100644
--- a/infiniband-diags/man/ibcacheedit.8.in.rst
+++ b/infiniband-diags/man/ibcacheedit.8.in.rst
@@ -6,7 +6,7 @@ ibcacheedit
 edit an ibnetdiscover cache
 ---------------------------
 
-:Date: @BUILD_DATE@
+:Date: 2017-08-21
 :Manual section: 8
 :Manual group: Open IB Diagnostics
 
diff --git a/infiniband-diags/man/ibccconfig.8.in.rst b/infiniband-diags/man/ibccconfig.8.in.rst
index e88d8acb33acaf..741d50cb84b63b 100644
--- a/infiniband-diags/man/ibccconfig.8.in.rst
+++ b/infiniband-diags/man/ibccconfig.8.in.rst
@@ -6,7 +6,7 @@ IBCCCONFIG
 configure congestion control settings
 -------------------------------------
 
-:Date: @BUILD_DATE@
+:Date: 2012-05-31
 :Manual section: 8
 :Manual group: OpenIB Diagnostics
 
diff --git a/infiniband-diags/man/ibccquery.8.in.rst b/infiniband-diags/man/ibccquery.8.in.rst
index 773d2f8d115b36..85c051028a969a 100644
--- a/infiniband-diags/man/ibccquery.8.in.rst
+++ b/infiniband-diags/man/ibccquery.8.in.rst
@@ -6,7 +6,7 @@ IBCCQUERY
 query congestion control settings/info
 --------------------------------------
 
-:Date: @BUILD_DATE@
+:Date: 2012-05-31
 :Manual section: 8
 :Manual group: OpenIB Diagnostics
 
diff --git a/infiniband-diags/man/ibfindnodesusing.8.in.rst b/infiniband-diags/man/ibfindnodesusing.8.in.rst
index e3ba0aefcda9af..82c34ce1c0f571 100644
--- a/infiniband-diags/man/ibfindnodesusing.8.in.rst
+++ b/infiniband-diags/man/ibfindnodesusing.8.in.rst
@@ -6,7 +6,7 @@ ibfindnodesusing
 find a list of end nodes which are routed through the specified switch and port
 -------------------------------------------------------------------------------
 
-:Date: @BUILD_DATE@
+:Date: 2017-08-21
 :Manual section: 8
 :Manual group: Open IB Diagnostics
 
diff --git a/infiniband-diags/man/ibhosts.8.in.rst b/infiniband-diags/man/ibhosts.8.in.rst
index 749c35a3b52092..7a7fe61f72039b 100644
--- a/infiniband-diags/man/ibhosts.8.in.rst
+++ b/infiniband-diags/man/ibhosts.8.in.rst
@@ -6,7 +6,7 @@ IBHOSTS
 show InfiniBand host nodes in topology
 --------------------------------------
 
-:Date: @BUILD_DATE@
+:Date: 2016-12-20
 :Manual section: 8
 :Manual group: OpenIB Diagnostics
 
diff --git a/infiniband-diags/man/ibidsverify.8.in.rst b/infiniband-diags/man/ibidsverify.8.in.rst
index ece8ea0bb7360c..834485dab63d95 100644
--- a/infiniband-diags/man/ibidsverify.8.in.rst
+++ b/infiniband-diags/man/ibidsverify.8.in.rst
@@ -6,7 +6,7 @@ ibidsverify
 validate IB identifiers in subnet and report errors
 ---------------------------------------------------
 
-:Date: @BUILD_DATE@
+:Date: 2017-08-21
 :Manual section: 8
 :Manual group: Open IB Diagnostics
 
diff --git a/infiniband-diags/man/iblinkinfo.8.in.rst b/infiniband-diags/man/iblinkinfo.8.in.rst
index ad4a17d562003c..7e6b24010e2610 100644
--- a/infiniband-diags/man/iblinkinfo.8.in.rst
+++ b/infiniband-diags/man/iblinkinfo.8.in.rst
@@ -6,7 +6,7 @@ IBLINKINFO
 report link info for all links in the fabric
 --------------------------------------------
 
-:Date: @BUILD_DATE@
+:Date: 2018-07-09
 :Manual section: 8
 :Manual group: OpenIB Diagnostics
 
diff --git a/infiniband-diags/man/ibnetdiscover.8.in.rst b/infiniband-diags/man/ibnetdiscover.8.in.rst
index 61a5667b665985..28bf9e5599bbec 100644
--- a/infiniband-diags/man/ibnetdiscover.8.in.rst
+++ b/infiniband-diags/man/ibnetdiscover.8.in.rst
@@ -6,7 +6,7 @@ IBNETDISCOVER
 discover InfiniBand topology
 ----------------------------
 
-:Date: @BUILD_DATE@
+:Date: 2013-06-22
 :Manual section: 8
 :Manual group: Open IB Diagnostics
 
diff --git a/infiniband-diags/man/ibnodes.8.in.rst b/infiniband-diags/man/ibnodes.8.in.rst
index d36a03eb99f1df..f6a32d3e9bd6ea 100644
--- a/infiniband-diags/man/ibnodes.8.in.rst
+++ b/infiniband-diags/man/ibnodes.8.in.rst
@@ -6,7 +6,7 @@ IBNODES
 show InfiniBand nodes in topology
 ---------------------------------
 
-:Date: @BUILD_DATE@
+:Date: 2012-05-14
 :Manual section: 8
 :Manual group: OpenIB Diagnostics
 
diff --git a/infiniband-diags/man/ibping.8.in.rst b/infiniband-diags/man/ibping.8.in.rst
index 8dd2e4172313f1..e4d11dbae43b22 100644
--- a/infiniband-diags/man/ibping.8.in.rst
+++ b/infiniband-diags/man/ibping.8.in.rst
@@ -6,7 +6,7 @@ IBPING
 ping an InfiniBand address
 --------------------------
 
-:Date: @BUILD_DATE@
+:Date: 2012-05-14
 :Manual section: 8
 :Manual group: Open IB Diagnostics
 
diff --git a/infiniband-diags/man/ibportstate.8.in.rst b/infiniband-diags/man/ibportstate.8.in.rst
index 750ee4208d1ff8..da1de4c763174e 100644
--- a/infiniband-diags/man/ibportstate.8.in.rst
+++ b/infiniband-diags/man/ibportstate.8.in.rst
@@ -6,7 +6,7 @@ IBPORTSTATE
 handle port (physical) state and link speed of an InfiniBand port
 -----------------------------------------------------------------
 
-:Date: @BUILD_DATE@
+:Date: 2013-03-26
 :Manual section: 8
 :Manual group: Open IB Diagnostics
 
diff --git a/infiniband-diags/man/ibqueryerrors.8.in.rst b/infiniband-diags/man/ibqueryerrors.8.in.rst
index 0a7992b80434bd..6ddfc2c9f06b59 100644
--- a/infiniband-diags/man/ibqueryerrors.8.in.rst
+++ b/infiniband-diags/man/ibqueryerrors.8.in.rst
@@ -6,7 +6,7 @@ IBQUERYERRORS
 query and report IB port counters
 ---------------------------------
 
-:Date: @BUILD_DATE@
+:Date: 2016-09-26
 :Manual section: 8
 :Manual group: OpenIB Diagnostics
 
diff --git a/infiniband-diags/man/ibroute.8.in.rst b/infiniband-diags/man/ibroute.8.in.rst
index 4163b80a5e549c..25b10768526139 100644
--- a/infiniband-diags/man/ibroute.8.in.rst
+++ b/infiniband-diags/man/ibroute.8.in.rst
@@ -6,7 +6,7 @@ ibroute
 query InfiniBand switch forwarding tables
 -----------------------------------------
 
-:Date: @BUILD_DATE@
+:Date: 2017-08-21
 :Manual section: 8
 :Manual group: Open IB Diagnostics
 
diff --git a/infiniband-diags/man/ibrouters.8.in.rst b/infiniband-diags/man/ibrouters.8.in.rst
index 90dbd391eb7eb2..5dc93f5714a84f 100644
--- a/infiniband-diags/man/ibrouters.8.in.rst
+++ b/infiniband-diags/man/ibrouters.8.in.rst
@@ -6,7 +6,7 @@ IBROUTERS
 show InfiniBand router nodes in topology
 ----------------------------------------
 
-:Date: @BUILD_DATE@
+:Date: 2016-12-20
 :Manual section: 8
 :Manual group: OpenIB Diagnostics
 
diff --git a/infiniband-diags/man/ibstat.8.in.rst b/infiniband-diags/man/ibstat.8.in.rst
index baf2d3d942b1b3..a332de18141ee1 100644
--- a/infiniband-diags/man/ibstat.8.in.rst
+++ b/infiniband-diags/man/ibstat.8.in.rst
@@ -6,7 +6,7 @@ ibstat
 query basic status of InfiniBand device(s)
 ------------------------------------------
 
-:Date: @BUILD_DATE@
+:Date: 2017-08-21
 :Manual section: 8
 :Manual group: Open IB Diagnostics
 
diff --git a/infiniband-diags/man/ibstatus.8.in.rst b/infiniband-diags/man/ibstatus.8.in.rst
index e2e5b2d40aa352..e9f25e5eeb8c1a 100644
--- a/infiniband-diags/man/ibstatus.8.in.rst
+++ b/infiniband-diags/man/ibstatus.8.in.rst
@@ -6,7 +6,7 @@ ibstatus
 query basic status of InfiniBand device(s)
 ------------------------------------------
 
-:Date: @BUILD_DATE@
+:Date: 2017-08-21
 :Manual section: 8
 :Manual group: Open IB Diagnostics
 
diff --git a/infiniband-diags/man/ibswitches.8.in.rst b/infiniband-diags/man/ibswitches.8.in.rst
index 2aade835965ec2..15303b84de6404 100644
--- a/infiniband-diags/man/ibswitches.8.in.rst
+++ b/infiniband-diags/man/ibswitches.8.in.rst
@@ -6,7 +6,7 @@ IBSWITCHES
 show InfiniBand switch nodes in topology
 ----------------------------------------
 
-:Date: @BUILD_DATE@
+:Date: 2016-12-20
 :Manual section: 8
 :Manual group: OpenIB Diagnostics
 
diff --git a/infiniband-diags/man/ibsysstat.8.in.rst b/infiniband-diags/man/ibsysstat.8.in.rst
index df0764f3881e4f..9e8bc6004afdae 100644
--- a/infiniband-diags/man/ibsysstat.8.in.rst
+++ b/infiniband-diags/man/ibsysstat.8.in.rst
@@ -6,7 +6,7 @@ ibsysstat
 system status on an InfiniBand address
 --------------------------------------
 
-:Date: @BUILD_DATE@
+:Date: 2017-08-21
 :Manual section: 8
 :Manual group: Open IB Diagnostics
 
diff --git a/infiniband-diags/man/ibtracert.8.in.rst b/infiniband-diags/man/ibtracert.8.in.rst
index 8145926509ebad..9dea1578ae2a8c 100644
--- a/infiniband-diags/man/ibtracert.8.in.rst
+++ b/infiniband-diags/man/ibtracert.8.in.rst
@@ -6,7 +6,7 @@ ibtracert
 trace InfiniBand path
 ---------------------
 
-:Date: @BUILD_DATE@
+:Date: 2018-04-02
 :Manual section: 8
 :Manual group: Open IB Diagnostics
 
diff --git a/infiniband-diags/man/infiniband-diags.8.in.rst b/infiniband-diags/man/infiniband-diags.8.in.rst
index 571d4cccfaa0f6..4d2d7aa997db42 100644
--- a/infiniband-diags/man/infiniband-diags.8.in.rst
+++ b/infiniband-diags/man/infiniband-diags.8.in.rst
@@ -6,7 +6,7 @@ infiniband-diags
 Diagnostics for InfiniBand Fabrics
 ----------------------------------
 
-:Date: @BUILD_DATE@
+:Date: 2017-08-21
 :Manual section: 8
 :Manual group: Open IB Diagnostics
 
diff --git a/infiniband-diags/man/perfquery.8.in.rst b/infiniband-diags/man/perfquery.8.in.rst
index c09c3e1d7deff7..b511a7b4b72912 100644
--- a/infiniband-diags/man/perfquery.8.in.rst
+++ b/infiniband-diags/man/perfquery.8.in.rst
@@ -6,7 +6,7 @@ perfquery
 query InfiniBand port counters on a single port
 -----------------------------------------------
 
-:Date: @BUILD_DATE@
+:Date: 2017-08-21
 :Manual section: 8
 :Manual group: Open IB Diagnostics
 
diff --git a/infiniband-diags/man/saquery.8.in.rst b/infiniband-diags/man/saquery.8.in.rst
index 9647297b539fe6..93043e1397801e 100644
--- a/infiniband-diags/man/saquery.8.in.rst
+++ b/infiniband-diags/man/saquery.8.in.rst
@@ -6,7 +6,7 @@ saquery
 query InfiniBand subnet administration attributes
 -------------------------------------------------
 
-:Date: @BUILD_DATE@
+:Date: 2017-08-21
 :Manual section: 8
 :Manual group: Open IB Diagnostics
 
diff --git a/infiniband-diags/man/sminfo.8.in.rst b/infiniband-diags/man/sminfo.8.in.rst
index 4d715d7f205fb0..6ac8e272bc8cdb 100644
--- a/infiniband-diags/man/sminfo.8.in.rst
+++ b/infiniband-diags/man/sminfo.8.in.rst
@@ -6,7 +6,7 @@ sminfo
 query InfiniBand SMInfo attribute
 ---------------------------------
 
-:Date: @BUILD_DATE@
+:Date: 2017-08-21
 :Manual section: 8
 :Manual group: Open IB Diagnostics
 
diff --git a/infiniband-diags/man/smpdump.8.in.rst b/infiniband-diags/man/smpdump.8.in.rst
index 118288f33b1dae..5c7bcfc6553019 100644
--- a/infiniband-diags/man/smpdump.8.in.rst
+++ b/infiniband-diags/man/smpdump.8.in.rst
@@ -6,7 +6,7 @@ smpdump
 dump InfiniBand subnet management attributes
 --------------------------------------------
 
-:Date: @BUILD_DATE@
+:Date: 2017-08-21
 :Manual section: 8
 :Manual group: Open IB Diagnostics
 
diff --git a/infiniband-diags/man/smpquery.8.in.rst b/infiniband-diags/man/smpquery.8.in.rst
index 8ca98ab378ee67..dcb26fbee9912f 100644
--- a/infiniband-diags/man/smpquery.8.in.rst
+++ b/infiniband-diags/man/smpquery.8.in.rst
@@ -6,7 +6,7 @@ smpquery
 query InfiniBand subnet management attributes
 ---------------------------------------------
 
-:Date: @BUILD_DATE@
+:Date: 2017-08-21
 :Manual section: 8
 :Manual group: Open IB Diagnostics
 
diff --git a/infiniband-diags/man/vendstat.8.in.rst b/infiniband-diags/man/vendstat.8.in.rst
index 7b5e9e6be98d0b..4d2c0a31657065 100644
--- a/infiniband-diags/man/vendstat.8.in.rst
+++ b/infiniband-diags/man/vendstat.8.in.rst
@@ -6,7 +6,7 @@ vendstat
 query InfiniBand vendor specific functions
 ------------------------------------------
 
-:Date: @BUILD_DATE@
+:Date: 2017-08-21
 :Manual section: 8
 :Manual group: Open IB Diagnostics
 
-- 
2.21.0

