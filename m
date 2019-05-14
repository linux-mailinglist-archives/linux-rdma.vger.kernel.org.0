Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 376FF1E5EC
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 02:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfEOALM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 May 2019 20:11:12 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35364 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbfEOALM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 May 2019 20:11:12 -0400
Received: by mail-qk1-f194.google.com with SMTP id c15so442776qkl.2
        for <linux-rdma@vger.kernel.org>; Tue, 14 May 2019 17:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mpw6hVHHI13fPbqmbD4sv5vRdfLgyvm4tO2Bz6bVSkY=;
        b=am6ckc3JPbNQS4AAG2WBu3FTsWj6WbKB9nrASFymxfYjuOCxFqc1JcKTnQqOk7ewey
         0rADydJCf8OQLewhO5CrK3z/jl1Vo8bHeteyzMWw3ddmcmV/kLWpxfLf5KA0MEA2+4xp
         KUl2XoGNaLGOu2kMoDWBDG2PKfSvsvvIiKlio7e+fMG2NbP0V5ZXB0pAqCoI3CyhzA6v
         O226TGSjbGtITcG9P/rYG0qrj9H1Yq+6/c1zewWSkcMdbUb/kKUEChsGoMHdWfIgHSUi
         qrqsGYGa4n7+emxPUSJn1cTHeKnp13Et0B1TgDQ6Fv5Qcjg7o0OsuLtjQbGGjQg8LDtY
         Fw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mpw6hVHHI13fPbqmbD4sv5vRdfLgyvm4tO2Bz6bVSkY=;
        b=quygbUGiTuP8yiQKPi509d7c9Q/XDFr8LuRbMMpGSzCEeXDD1M0HlNukMJK2rtkTWo
         0nkjsUyO71sZuuhVwSguMol1PNKqH1IZICKrmshbGT7VxH/6wpgQcOwIWEaM9tGJzbMe
         bGD1GltgAETedtBN5s/LgI5b4ESdoT5UYfavqukquKNGBKxhu3uagnhRQkhPy7vDBhSa
         TfSHwSbqz3nPb4IsEhKRnMrbk2bA/jFwRFMYxTzRkY3fYesO6BxrswBhe8D40Mvd+98z
         VkFOSvby+Jt9tnCpxI8pqHLxPRs4KY3fCsmaDy0mnEup5WG5fkJQ6UzMBwj+mdRJ0U+h
         BH4w==
X-Gm-Message-State: APjAAAX8AGYwhu00E0Y1uUE0Eej1/R3ktcuE9PvUOkpPCgQ96qQRP5/w
        1+4qwKYYiZEPODj4IWRfdV/oLJWYw+A=
X-Google-Smtp-Source: APXvYqyRoPUkijhPYGRmBbRqp4qyoaL7XWjj8X8Ibn42YIvaZdj3J44V+bMsL0kI3ptbv+GqoB4ong==
X-Received: by 2002:a37:609:: with SMTP id 9mr30338041qkg.217.1557879070788;
        Tue, 14 May 2019 17:11:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id n66sm177065qke.6.2019.05.14.17.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 17:11:10 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hQhAx-0001OC-Ce; Tue, 14 May 2019 20:49:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 16/20] libibnetdiscover: Flatten libibnetdiscover into one directory
Date:   Tue, 14 May 2019 20:49:32 -0300
Message-Id: <20190514234936.5175-17-jgg@ziepe.ca>
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

As is the standard for rdma-core

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 CMakeLists.txt                                              | 4 ++--
 {ibdiags/libibnetdisc/src => libibnetdisc}/CMakeLists.txt   | 6 +++---
 {ibdiags/libibnetdisc/src => libibnetdisc}/chassis.c        | 0
 {ibdiags/libibnetdisc/src => libibnetdisc}/chassis.h        | 0
 {ibdiags/libibnetdisc/src => libibnetdisc}/ibnetdisc.c      | 0
 .../include/infiniband => libibnetdisc}/ibnetdisc.h         | 0
 .../libibnetdisc/src => libibnetdisc}/ibnetdisc_cache.c     | 0
 .../include/infiniband => libibnetdisc}/ibnetdisc_osd.h     | 0
 {ibdiags/libibnetdisc/src => libibnetdisc}/internal.h       | 0
 {ibdiags/libibnetdisc/src => libibnetdisc}/libibnetdisc.map | 0
 {ibdiags/libibnetdisc => libibnetdisc}/man/CMakeLists.txt   | 0
 .../man/ibnd_discover_fabric.3                              | 0
 .../libibnetdisc => libibnetdisc}/man/ibnd_find_node_guid.3 | 0
 .../libibnetdisc => libibnetdisc}/man/ibnd_iter_nodes.3     | 0
 {ibdiags/libibnetdisc/src => libibnetdisc}/query_smp.c      | 0
 .../libibnetdisc/test => libibnetdisc/tests}/testleaks.c    | 0
 16 files changed, 5 insertions(+), 5 deletions(-)
 rename {ibdiags/libibnetdisc/src => libibnetdisc}/CMakeLists.txt (75%)
 rename {ibdiags/libibnetdisc/src => libibnetdisc}/chassis.c (100%)
 rename {ibdiags/libibnetdisc/src => libibnetdisc}/chassis.h (100%)
 rename {ibdiags/libibnetdisc/src => libibnetdisc}/ibnetdisc.c (100%)
 rename {ibdiags/libibnetdisc/include/infiniband => libibnetdisc}/ibnetdisc.h (100%)
 rename {ibdiags/libibnetdisc/src => libibnetdisc}/ibnetdisc_cache.c (100%)
 rename {ibdiags/libibnetdisc/include/infiniband => libibnetdisc}/ibnetdisc_osd.h (100%)
 rename {ibdiags/libibnetdisc/src => libibnetdisc}/internal.h (100%)
 rename {ibdiags/libibnetdisc/src => libibnetdisc}/libibnetdisc.map (100%)
 rename {ibdiags/libibnetdisc => libibnetdisc}/man/CMakeLists.txt (100%)
 rename {ibdiags/libibnetdisc => libibnetdisc}/man/ibnd_discover_fabric.3 (100%)
 rename {ibdiags/libibnetdisc => libibnetdisc}/man/ibnd_find_node_guid.3 (100%)
 rename {ibdiags/libibnetdisc => libibnetdisc}/man/ibnd_iter_nodes.3 (100%)
 rename {ibdiags/libibnetdisc/src => libibnetdisc}/query_smp.c (100%)
 rename {ibdiags/libibnetdisc/test => libibnetdisc/tests}/testleaks.c (100%)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index a5c1dc7f1e2421..7b048a0fa164c1 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -618,8 +618,8 @@ add_subdirectory(providers/rxe)
 add_subdirectory(providers/rxe/man)
 
 add_subdirectory(libibmad)
-add_subdirectory(ibdiags/libibnetdisc/src)
-add_subdirectory(ibdiags/libibnetdisc/man)
+add_subdirectory(libibnetdisc)
+add_subdirectory(libibnetdisc/man)
 add_subdirectory(ibdiags/src)
 add_subdirectory(ibdiags/scripts)
 add_subdirectory(ibdiags/man)
diff --git a/ibdiags/libibnetdisc/src/CMakeLists.txt b/libibnetdisc/CMakeLists.txt
similarity index 75%
rename from ibdiags/libibnetdisc/src/CMakeLists.txt
rename to libibnetdisc/CMakeLists.txt
index ad8c09dc9722f6..e908bc2d6a29f9 100644
--- a/ibdiags/libibnetdisc/src/CMakeLists.txt
+++ b/libibnetdisc/CMakeLists.txt
@@ -1,6 +1,6 @@
 publish_headers(infiniband
-  ../include/infiniband/ibnetdisc.h
-  ../include/infiniband/ibnetdisc_osd.h
+  ibnetdisc.h
+  ibnetdisc_osd.h
   )
 
 rdma_library(ibnetdisc libibnetdisc.map
@@ -17,7 +17,7 @@ target_link_libraries(ibnetdisc LINK_PRIVATE
   )
 rdma_pkg_config("ibnetdisc" "libibumad libibmad" "")
 
-rdma_test_executable(testleaks ../test/testleaks.c)
+rdma_test_executable(testleaks tests/testleaks.c)
 target_link_libraries(testleaks LINK_PRIVATE
   ibmad
   ibnetdisc
diff --git a/ibdiags/libibnetdisc/src/chassis.c b/libibnetdisc/chassis.c
similarity index 100%
rename from ibdiags/libibnetdisc/src/chassis.c
rename to libibnetdisc/chassis.c
diff --git a/ibdiags/libibnetdisc/src/chassis.h b/libibnetdisc/chassis.h
similarity index 100%
rename from ibdiags/libibnetdisc/src/chassis.h
rename to libibnetdisc/chassis.h
diff --git a/ibdiags/libibnetdisc/src/ibnetdisc.c b/libibnetdisc/ibnetdisc.c
similarity index 100%
rename from ibdiags/libibnetdisc/src/ibnetdisc.c
rename to libibnetdisc/ibnetdisc.c
diff --git a/ibdiags/libibnetdisc/include/infiniband/ibnetdisc.h b/libibnetdisc/ibnetdisc.h
similarity index 100%
rename from ibdiags/libibnetdisc/include/infiniband/ibnetdisc.h
rename to libibnetdisc/ibnetdisc.h
diff --git a/ibdiags/libibnetdisc/src/ibnetdisc_cache.c b/libibnetdisc/ibnetdisc_cache.c
similarity index 100%
rename from ibdiags/libibnetdisc/src/ibnetdisc_cache.c
rename to libibnetdisc/ibnetdisc_cache.c
diff --git a/ibdiags/libibnetdisc/include/infiniband/ibnetdisc_osd.h b/libibnetdisc/ibnetdisc_osd.h
similarity index 100%
rename from ibdiags/libibnetdisc/include/infiniband/ibnetdisc_osd.h
rename to libibnetdisc/ibnetdisc_osd.h
diff --git a/ibdiags/libibnetdisc/src/internal.h b/libibnetdisc/internal.h
similarity index 100%
rename from ibdiags/libibnetdisc/src/internal.h
rename to libibnetdisc/internal.h
diff --git a/ibdiags/libibnetdisc/src/libibnetdisc.map b/libibnetdisc/libibnetdisc.map
similarity index 100%
rename from ibdiags/libibnetdisc/src/libibnetdisc.map
rename to libibnetdisc/libibnetdisc.map
diff --git a/ibdiags/libibnetdisc/man/CMakeLists.txt b/libibnetdisc/man/CMakeLists.txt
similarity index 100%
rename from ibdiags/libibnetdisc/man/CMakeLists.txt
rename to libibnetdisc/man/CMakeLists.txt
diff --git a/ibdiags/libibnetdisc/man/ibnd_discover_fabric.3 b/libibnetdisc/man/ibnd_discover_fabric.3
similarity index 100%
rename from ibdiags/libibnetdisc/man/ibnd_discover_fabric.3
rename to libibnetdisc/man/ibnd_discover_fabric.3
diff --git a/ibdiags/libibnetdisc/man/ibnd_find_node_guid.3 b/libibnetdisc/man/ibnd_find_node_guid.3
similarity index 100%
rename from ibdiags/libibnetdisc/man/ibnd_find_node_guid.3
rename to libibnetdisc/man/ibnd_find_node_guid.3
diff --git a/ibdiags/libibnetdisc/man/ibnd_iter_nodes.3 b/libibnetdisc/man/ibnd_iter_nodes.3
similarity index 100%
rename from ibdiags/libibnetdisc/man/ibnd_iter_nodes.3
rename to libibnetdisc/man/ibnd_iter_nodes.3
diff --git a/ibdiags/libibnetdisc/src/query_smp.c b/libibnetdisc/query_smp.c
similarity index 100%
rename from ibdiags/libibnetdisc/src/query_smp.c
rename to libibnetdisc/query_smp.c
diff --git a/ibdiags/libibnetdisc/test/testleaks.c b/libibnetdisc/tests/testleaks.c
similarity index 100%
rename from ibdiags/libibnetdisc/test/testleaks.c
rename to libibnetdisc/tests/testleaks.c
-- 
2.21.0

