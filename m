Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 848F01E5C5
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 01:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfENXto (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 May 2019 19:49:44 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33725 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfENXtn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 May 2019 19:49:43 -0400
Received: by mail-qt1-f195.google.com with SMTP id m32so1264873qtf.0
        for <linux-rdma@vger.kernel.org>; Tue, 14 May 2019 16:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lzSIqDVC7ycp73isxoAWHpxWlD5Mj5pY3gG903i5ZCI=;
        b=Q8l/4PPKGXWhFgNYvrbbqplFRUwaHlgCng4NZnjaYYLAmozW506pYNws4nGB+S4WDK
         onDMqcZQ+W+EI1GXT4BnPt2BUj240btfELnaLcJbz6iSD7JHLWVOKG9Tbsa+UW8mkfxa
         z2/Jc43kkAHqhJ9F39cDCd3T5gdEokUk8Jb8j7mRwRZYY3jFZ/nabi114+04i1HUz+vo
         aULUAX9S63Mtc5/hJLk9LXxZYG483My/WE0RzKJwL0v0OhVXPnCO4r+df4f5sBM/7u3N
         x6nOrxHrVcNeUGMoASg6TqmmzkjmMPcZpln9VQfxzJ8OE+ti2L1nSPmE6nQsqpNahlnh
         NEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lzSIqDVC7ycp73isxoAWHpxWlD5Mj5pY3gG903i5ZCI=;
        b=CR9Fu4o56tP6CQRtI8ytd/kvvXXok8tgnPA+J3M3ykpgJzjO5tuVFicO+/gejsGaJZ
         RxcJ7wS4uW2dsOJExL/UElBsbzkwsEnvFT4q+zCetdXyjPVR2OvErBbnp7gUDQlqWRya
         IHdPLnKNkgWY+IZntmXH7jx7PmX2XvLPQdV9PMiVFGJi/+Y5w2hQm+Ayj+kxjdeKErYK
         v0RfotgmRdxf3LP5+4wk46H5uZRQi8QMKx7QmLAQKsbpBy0v+qcnlGKfnOOO5UDgvQqr
         O8oB2rQ9LMHVb5Bip98J6A6oqTkqep8zJNp/r8IkqhWLOhsCamM8Af7Bb12Z7d2C87WS
         5Euw==
X-Gm-Message-State: APjAAAVkyLDAGvJuKi9SzCz2p8aHrbMrjWfDCpIODwPQkGGiH9ZNqqMg
        fwqQCJFltZLOeb1UlAbsCFVfmhF2mh8=
X-Google-Smtp-Source: APXvYqw/ZSDn+HrKp0z78eaIcpwlnMzeQSkMtq5PE6fOUONesdQU8qsa0QVWBDw4u9mBsF/HJvnWfg==
X-Received: by 2002:a0c:d4c9:: with SMTP id y9mr15576084qvh.80.1557877781900;
        Tue, 14 May 2019 16:49:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id d85sm87045qkc.64.2019.05.14.16.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 16:49:40 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hQhAx-0001O6-Af; Tue, 14 May 2019 20:49:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 15/20] libibmad: Flatten libibmad into one directory
Date:   Tue, 14 May 2019 20:49:31 -0300
Message-Id: <20190514234936.5175-16-jgg@ziepe.ca>
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
 CMakeLists.txt                                              | 2 +-
 {ibdiags/libibmad/src => libibmad}/CMakeLists.txt           | 4 ++--
 {ibdiags/libibmad/src => libibmad}/bm.c                     | 0
 {ibdiags/libibmad/src => libibmad}/cc.c                     | 0
 {ibdiags/libibmad/src => libibmad}/dump.c                   | 0
 {ibdiags/libibmad/src => libibmad}/fields.c                 | 0
 {ibdiags/libibmad/src => libibmad}/gs.c                     | 0
 {ibdiags/libibmad/src => libibmad}/iba_types.h              | 0
 {ibdiags/libibmad/src => libibmad}/libibmad.map             | 0
 {ibdiags/libibmad/src => libibmad}/mad.c                    | 0
 {ibdiags/libibmad/include/infiniband => libibmad}/mad.h     | 0
 {ibdiags/libibmad/src => libibmad}/mad_internal.h           | 0
 {ibdiags/libibmad/include/infiniband => libibmad}/mad_osd.h | 0
 {ibdiags/libibmad/src => libibmad}/portid.c                 | 0
 {ibdiags/libibmad/src => libibmad}/register.c               | 0
 {ibdiags/libibmad/src => libibmad}/resolve.c                | 0
 {ibdiags/libibmad/src => libibmad}/rpc.c                    | 0
 {ibdiags/libibmad/src => libibmad}/sa.c                     | 0
 {ibdiags/libibmad/src => libibmad}/serv.c                   | 0
 {ibdiags/libibmad/src => libibmad}/smp.c                    | 0
 {ibdiags/libibmad/src => libibmad}/vendor.c                 | 0
 21 files changed, 3 insertions(+), 3 deletions(-)
 rename {ibdiags/libibmad/src => libibmad}/CMakeLists.txt (86%)
 rename {ibdiags/libibmad/src => libibmad}/bm.c (100%)
 rename {ibdiags/libibmad/src => libibmad}/cc.c (100%)
 rename {ibdiags/libibmad/src => libibmad}/dump.c (100%)
 rename {ibdiags/libibmad/src => libibmad}/fields.c (100%)
 rename {ibdiags/libibmad/src => libibmad}/gs.c (100%)
 rename {ibdiags/libibmad/src => libibmad}/iba_types.h (100%)
 rename {ibdiags/libibmad/src => libibmad}/libibmad.map (100%)
 rename {ibdiags/libibmad/src => libibmad}/mad.c (100%)
 rename {ibdiags/libibmad/include/infiniband => libibmad}/mad.h (100%)
 rename {ibdiags/libibmad/src => libibmad}/mad_internal.h (100%)
 rename {ibdiags/libibmad/include/infiniband => libibmad}/mad_osd.h (100%)
 rename {ibdiags/libibmad/src => libibmad}/portid.c (100%)
 rename {ibdiags/libibmad/src => libibmad}/register.c (100%)
 rename {ibdiags/libibmad/src => libibmad}/resolve.c (100%)
 rename {ibdiags/libibmad/src => libibmad}/rpc.c (100%)
 rename {ibdiags/libibmad/src => libibmad}/sa.c (100%)
 rename {ibdiags/libibmad/src => libibmad}/serv.c (100%)
 rename {ibdiags/libibmad/src => libibmad}/smp.c (100%)
 rename {ibdiags/libibmad/src => libibmad}/vendor.c (100%)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index fd9355787291c0..a5c1dc7f1e2421 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -617,7 +617,7 @@ add_subdirectory(providers/ipathverbs)
 add_subdirectory(providers/rxe)
 add_subdirectory(providers/rxe/man)
 
-add_subdirectory(ibdiags/libibmad/src)
+add_subdirectory(libibmad)
 add_subdirectory(ibdiags/libibnetdisc/src)
 add_subdirectory(ibdiags/libibnetdisc/man)
 add_subdirectory(ibdiags/src)
diff --git a/ibdiags/libibmad/src/CMakeLists.txt b/libibmad/CMakeLists.txt
similarity index 86%
rename from ibdiags/libibmad/src/CMakeLists.txt
rename to libibmad/CMakeLists.txt
index 81fa4a366fc3c7..43d560a43d0a2e 100644
--- a/ibdiags/libibmad/src/CMakeLists.txt
+++ b/libibmad/CMakeLists.txt
@@ -1,6 +1,6 @@
 publish_headers(infiniband
-  ../include/infiniband/mad.h
-  ../include/infiniband/mad_osd.h
+  mad.h
+  mad_osd.h
   )
 
 publish_internal_headers(util
diff --git a/ibdiags/libibmad/src/bm.c b/libibmad/bm.c
similarity index 100%
rename from ibdiags/libibmad/src/bm.c
rename to libibmad/bm.c
diff --git a/ibdiags/libibmad/src/cc.c b/libibmad/cc.c
similarity index 100%
rename from ibdiags/libibmad/src/cc.c
rename to libibmad/cc.c
diff --git a/ibdiags/libibmad/src/dump.c b/libibmad/dump.c
similarity index 100%
rename from ibdiags/libibmad/src/dump.c
rename to libibmad/dump.c
diff --git a/ibdiags/libibmad/src/fields.c b/libibmad/fields.c
similarity index 100%
rename from ibdiags/libibmad/src/fields.c
rename to libibmad/fields.c
diff --git a/ibdiags/libibmad/src/gs.c b/libibmad/gs.c
similarity index 100%
rename from ibdiags/libibmad/src/gs.c
rename to libibmad/gs.c
diff --git a/ibdiags/libibmad/src/iba_types.h b/libibmad/iba_types.h
similarity index 100%
rename from ibdiags/libibmad/src/iba_types.h
rename to libibmad/iba_types.h
diff --git a/ibdiags/libibmad/src/libibmad.map b/libibmad/libibmad.map
similarity index 100%
rename from ibdiags/libibmad/src/libibmad.map
rename to libibmad/libibmad.map
diff --git a/ibdiags/libibmad/src/mad.c b/libibmad/mad.c
similarity index 100%
rename from ibdiags/libibmad/src/mad.c
rename to libibmad/mad.c
diff --git a/ibdiags/libibmad/include/infiniband/mad.h b/libibmad/mad.h
similarity index 100%
rename from ibdiags/libibmad/include/infiniband/mad.h
rename to libibmad/mad.h
diff --git a/ibdiags/libibmad/src/mad_internal.h b/libibmad/mad_internal.h
similarity index 100%
rename from ibdiags/libibmad/src/mad_internal.h
rename to libibmad/mad_internal.h
diff --git a/ibdiags/libibmad/include/infiniband/mad_osd.h b/libibmad/mad_osd.h
similarity index 100%
rename from ibdiags/libibmad/include/infiniband/mad_osd.h
rename to libibmad/mad_osd.h
diff --git a/ibdiags/libibmad/src/portid.c b/libibmad/portid.c
similarity index 100%
rename from ibdiags/libibmad/src/portid.c
rename to libibmad/portid.c
diff --git a/ibdiags/libibmad/src/register.c b/libibmad/register.c
similarity index 100%
rename from ibdiags/libibmad/src/register.c
rename to libibmad/register.c
diff --git a/ibdiags/libibmad/src/resolve.c b/libibmad/resolve.c
similarity index 100%
rename from ibdiags/libibmad/src/resolve.c
rename to libibmad/resolve.c
diff --git a/ibdiags/libibmad/src/rpc.c b/libibmad/rpc.c
similarity index 100%
rename from ibdiags/libibmad/src/rpc.c
rename to libibmad/rpc.c
diff --git a/ibdiags/libibmad/src/sa.c b/libibmad/sa.c
similarity index 100%
rename from ibdiags/libibmad/src/sa.c
rename to libibmad/sa.c
diff --git a/ibdiags/libibmad/src/serv.c b/libibmad/serv.c
similarity index 100%
rename from ibdiags/libibmad/src/serv.c
rename to libibmad/serv.c
diff --git a/ibdiags/libibmad/src/smp.c b/libibmad/smp.c
similarity index 100%
rename from ibdiags/libibmad/src/smp.c
rename to libibmad/smp.c
diff --git a/ibdiags/libibmad/src/vendor.c b/libibmad/vendor.c
similarity index 100%
rename from ibdiags/libibmad/src/vendor.c
rename to libibmad/vendor.c
-- 
2.21.0

