Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5856B1E5BF
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 01:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfENXtl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 May 2019 19:49:41 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43966 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfENXtl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 May 2019 19:49:41 -0400
Received: by mail-qk1-f196.google.com with SMTP id z6so383244qkl.10
        for <linux-rdma@vger.kernel.org>; Tue, 14 May 2019 16:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PZJmAdsM1j5J4rhFf5Uox4/M+tr7rrZWd0zdOvzMLr4=;
        b=LldYz+n4FWNWmVal7J4wtcTlqKju6D1oHSXdVkwi9k+47W0l4i8mKFdACqw5mD67MV
         87SooOoi6jyCTyPFH/V5W79s2OmtWe3HV/zwZYbmUopJl2Dj7dFjMlRrYDOeUggJOmyl
         TuvoEBQJTnJJb+8UyJaU3zIgNHokatTs3QZ1iPyp1fRRzHNpFGVlncmlfN0WkvmdLiHv
         avB+ecqHETFH+IFJRMiVromzVdZREpVPwHYUuFucfhppKtyzDIRXVkCP70DQAgT/sMnU
         WXFO4Y5HoANw9iSFQgCRvx959ooB4FS5hLsgrwhMTFEGuml5xZUngs3q8O2IRv884V9U
         Tvyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PZJmAdsM1j5J4rhFf5Uox4/M+tr7rrZWd0zdOvzMLr4=;
        b=kPBhKvusuacXkrIZyw1z08BdEX6Xpqnm2ecnXQfwHv7LyfHx0P9XCfMD2iifkRaD1N
         6Z2HGgyTbiJnTpaqBXjeoRs6qv1uvRPFSbjnkkYIwINBKzMCLU56cdTBMxixIElGLKCL
         hUKHgdxjDCLJdpFT6FOyWT3cxWoypKNUJURLgyCx/e/ewhDelmk+viFefxMq2V0+C8DQ
         eWJxZy+zdFWVY5nsnK2d3o0MaoVHFvT2iqgP0prY1khvB8Ff9fLf8E/5oyn6Hi4sOzwW
         ANdB5NNpfh6Qvm0g2wqzMTHUvDlHv91BVSAdo+LyoG+cO7rfJTqy1ySAMq0b7rrcrO4l
         D2Rg==
X-Gm-Message-State: APjAAAUYboJlQRwgFu4OIpDLOeVckL7ZjXnf8VqQQMHfiN0skC6ogR1c
        sh+jHq/sAn1HcjLT5qzs8gReyvM6X0Q=
X-Google-Smtp-Source: APXvYqxDi3LJnRdTtc1q4QiMdBQJr7vDqV9Wz4vDgRb7qSsZDH4QMW5XTo8euYeQoM3eOnojrVcgUQ==
X-Received: by 2002:a05:620a:15ac:: with SMTP id f12mr20511995qkk.311.1557877779995;
        Tue, 14 May 2019 16:49:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id v126sm115925qkh.86.2019.05.14.16.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 16:49:39 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hQhAw-0001N1-Q9; Tue, 14 May 2019 20:49:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 04/20] ibdiags: Remove config.h and HAVE_CONFIG_H
Date:   Tue, 14 May 2019 20:49:20 -0300
Message-Id: <20190514234936.5175-5-jgg@ziepe.ca>
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

Only files that actually need config.h should include it.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 ibdiags/libibmad/src/bm.c                  | 4 ----
 ibdiags/libibmad/src/cc.c                  | 4 ----
 ibdiags/libibmad/src/dump.c                | 4 ----
 ibdiags/libibmad/src/fields.c              | 4 ----
 ibdiags/libibmad/src/gs.c                  | 4 ----
 ibdiags/libibmad/src/mad.c                 | 4 ----
 ibdiags/libibmad/src/portid.c              | 4 ----
 ibdiags/libibmad/src/register.c            | 4 ----
 ibdiags/libibmad/src/resolve.c             | 4 ----
 ibdiags/libibmad/src/rpc.c                 | 4 ----
 ibdiags/libibmad/src/sa.c                  | 4 ----
 ibdiags/libibmad/src/serv.c                | 4 ----
 ibdiags/libibmad/src/smp.c                 | 4 ----
 ibdiags/libibmad/src/vendor.c              | 4 ----
 ibdiags/libibnetdisc/src/chassis.c         | 4 ----
 ibdiags/libibnetdisc/src/ibnetdisc.c       | 4 ----
 ibdiags/libibnetdisc/src/ibnetdisc_cache.c | 4 ----
 ibdiags/libibnetdisc/src/query_smp.c       | 4 ----
 ibdiags/libibnetdisc/test/testleaks.c      | 4 ----
 ibdiags/src/dump_fts.c                     | 4 ----
 ibdiags/src/ibaddr.c                       | 4 ----
 ibdiags/src/ibcacheedit.c                  | 4 ----
 ibdiags/src/ibccconfig.c                   | 4 ----
 ibdiags/src/ibccquery.c                    | 4 ----
 ibdiags/src/iblinkinfo.c                   | 4 ----
 ibdiags/src/ibnetdiscover.c                | 4 ----
 ibdiags/src/ibping.c                       | 4 ----
 ibdiags/src/ibportstate.c                  | 4 ----
 ibdiags/src/ibqueryerrors.c                | 4 +---
 ibdiags/src/ibroute.c                      | 4 ----
 ibdiags/src/ibstat.c                       | 4 ----
 ibdiags/src/ibsysstat.c                    | 4 ----
 ibdiags/src/ibtracert.c                    | 4 ----
 ibdiags/src/mcm_rereg_test.c               | 4 ----
 ibdiags/src/perfquery.c                    | 4 ----
 ibdiags/src/saquery.c                      | 4 ----
 ibdiags/src/sminfo.c                       | 4 ----
 ibdiags/src/smpdump.c                      | 4 ----
 ibdiags/src/smpquery.c                     | 4 ----
 ibdiags/src/vendstat.c                     | 4 ----
 40 files changed, 1 insertion(+), 159 deletions(-)

diff --git a/ibdiags/libibmad/src/bm.c b/ibdiags/libibmad/src/bm.c
index 8b3d342284ce00..921dbb85f788db 100644
--- a/ibdiags/libibmad/src/bm.c
+++ b/ibdiags/libibmad/src/bm.c
@@ -31,10 +31,6 @@
  *
  */
 
-#if HAVE_CONFIG_H
-#  include <config.h>
-#endif				/* HAVE_CONFIG_H */
-
 #include <string.h>
 
 #include <infiniband/mad.h>
diff --git a/ibdiags/libibmad/src/cc.c b/ibdiags/libibmad/src/cc.c
index cae174e702d74b..5cc2ebb6d07a22 100644
--- a/ibdiags/libibmad/src/cc.c
+++ b/ibdiags/libibmad/src/cc.c
@@ -31,10 +31,6 @@
  *
  */
 
-#if HAVE_CONFIG_H
-#  include <config.h>
-#endif				/* HAVE_CONFIG_H */
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/ibdiags/libibmad/src/dump.c b/ibdiags/libibmad/src/dump.c
index d1a69115f06313..1d3c37510f42f6 100644
--- a/ibdiags/libibmad/src/dump.c
+++ b/ibdiags/libibmad/src/dump.c
@@ -34,10 +34,6 @@
  *
  */
 
-#if HAVE_CONFIG_H
-#  include <config.h>
-#endif				/* HAVE_CONFIG_H */
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/ibdiags/libibmad/src/fields.c b/ibdiags/libibmad/src/fields.c
index 45eafd94921060..233eb1609f69e5 100644
--- a/ibdiags/libibmad/src/fields.c
+++ b/ibdiags/libibmad/src/fields.c
@@ -33,10 +33,6 @@
  *
  */
 
-#if HAVE_CONFIG_H
-#  include <config.h>
-#endif				/* HAVE_CONFIG_H */
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/ibdiags/libibmad/src/gs.c b/ibdiags/libibmad/src/gs.c
index 90db7e25e7320d..7f9c12960303e0 100644
--- a/ibdiags/libibmad/src/gs.c
+++ b/ibdiags/libibmad/src/gs.c
@@ -32,10 +32,6 @@
  *
  */
 
-#if HAVE_CONFIG_H
-#  include <config.h>
-#endif				/* HAVE_CONFIG_H */
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/ibdiags/libibmad/src/mad.c b/ibdiags/libibmad/src/mad.c
index 2ca317efc9296d..d22226429d808b 100644
--- a/ibdiags/libibmad/src/mad.c
+++ b/ibdiags/libibmad/src/mad.c
@@ -33,10 +33,6 @@
  *
  */
 
-#if HAVE_CONFIG_H
-#  include <config.h>
-#endif				/* HAVE_CONFIG_H */
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/ibdiags/libibmad/src/portid.c b/ibdiags/libibmad/src/portid.c
index 40754fe2e4f7f7..ea02ca9ae50af0 100644
--- a/ibdiags/libibmad/src/portid.c
+++ b/ibdiags/libibmad/src/portid.c
@@ -31,10 +31,6 @@
  *
  */
 
-#if HAVE_CONFIG_H
-#  include <config.h>
-#endif				/* HAVE_CONFIG_H */
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/ibdiags/libibmad/src/register.c b/ibdiags/libibmad/src/register.c
index d046264bdc69a9..854e46241e96a2 100644
--- a/ibdiags/libibmad/src/register.c
+++ b/ibdiags/libibmad/src/register.c
@@ -31,10 +31,6 @@
  *
  */
 
-#if HAVE_CONFIG_H
-#  include <config.h>
-#endif				/* HAVE_CONFIG_H */
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/ibdiags/libibmad/src/resolve.c b/ibdiags/libibmad/src/resolve.c
index 542aa16167c872..2c397eb1ad22fb 100644
--- a/ibdiags/libibmad/src/resolve.c
+++ b/ibdiags/libibmad/src/resolve.c
@@ -32,10 +32,6 @@
  *
  */
 
-#if HAVE_CONFIG_H
-#  include <config.h>
-#endif				/* HAVE_CONFIG_H */
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/ibdiags/libibmad/src/rpc.c b/ibdiags/libibmad/src/rpc.c
index a05d71ffe12d5b..9e3d88e336238e 100644
--- a/ibdiags/libibmad/src/rpc.c
+++ b/ibdiags/libibmad/src/rpc.c
@@ -33,10 +33,6 @@
  *
  */
 
-#if HAVE_CONFIG_H
-#  include <config.h>
-#endif				/* HAVE_CONFIG_H */
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/ibdiags/libibmad/src/sa.c b/ibdiags/libibmad/src/sa.c
index 09bf58824ae530..9dfec937143ca6 100644
--- a/ibdiags/libibmad/src/sa.c
+++ b/ibdiags/libibmad/src/sa.c
@@ -31,10 +31,6 @@
  *
  */
 
-#if HAVE_CONFIG_H
-#  include <config.h>
-#endif				/* HAVE_CONFIG_H */
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/ibdiags/libibmad/src/serv.c b/ibdiags/libibmad/src/serv.c
index 74dbc8b519b385..040bb62b6ac12c 100644
--- a/ibdiags/libibmad/src/serv.c
+++ b/ibdiags/libibmad/src/serv.c
@@ -31,10 +31,6 @@
  *
  */
 
-#if HAVE_CONFIG_H
-#  include <config.h>
-#endif				/* HAVE_CONFIG_H */
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/ibdiags/libibmad/src/smp.c b/ibdiags/libibmad/src/smp.c
index 14c74ed55277cc..07d0ad208a6c2b 100644
--- a/ibdiags/libibmad/src/smp.c
+++ b/ibdiags/libibmad/src/smp.c
@@ -32,10 +32,6 @@
  *
  */
 
-#if HAVE_CONFIG_H
-#  include <config.h>
-#endif				/* HAVE_CONFIG_H */
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/ibdiags/libibmad/src/vendor.c b/ibdiags/libibmad/src/vendor.c
index 939cc2a7b3b125..f96ba2468d003f 100644
--- a/ibdiags/libibmad/src/vendor.c
+++ b/ibdiags/libibmad/src/vendor.c
@@ -32,10 +32,6 @@
  *
  */
 
-#if HAVE_CONFIG_H
-#  include <config.h>
-#endif				/* HAVE_CONFIG_H */
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/ibdiags/libibnetdisc/src/chassis.c b/ibdiags/libibnetdisc/src/chassis.c
index c1eef73664a377..a3ec1d82807c8d 100644
--- a/ibdiags/libibnetdisc/src/chassis.c
+++ b/ibdiags/libibnetdisc/src/chassis.c
@@ -38,10 +38,6 @@
 /*               FABRIC SCANNER SPECIFIC DATA             */
 /*========================================================*/
 
-#if HAVE_CONFIG_H
-#include <config.h>
-#endif				/* HAVE_CONFIG_H */
-
 #include <stdlib.h>
 #include <inttypes.h>
 
diff --git a/ibdiags/libibnetdisc/src/ibnetdisc.c b/ibdiags/libibnetdisc/src/ibnetdisc.c
index c4206eb6b65bd4..0c60b4419a9c8e 100644
--- a/ibdiags/libibnetdisc/src/ibnetdisc.c
+++ b/ibdiags/libibnetdisc/src/ibnetdisc.c
@@ -34,10 +34,6 @@
  *
  */
 
-#if HAVE_CONFIG_H
-#include <config.h>
-#endif				/* HAVE_CONFIG_H */
-
 #define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/ibdiags/libibnetdisc/src/ibnetdisc_cache.c b/ibdiags/libibnetdisc/src/ibnetdisc_cache.c
index 384a27c99501d7..605582fca6cccc 100644
--- a/ibdiags/libibnetdisc/src/ibnetdisc_cache.c
+++ b/ibdiags/libibnetdisc/src/ibnetdisc_cache.c
@@ -33,10 +33,6 @@
  *
  */
 
-#if HAVE_CONFIG_H
-#include <config.h>
-#endif				/* HAVE_CONFIG_H */
-
 #define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/ibdiags/libibnetdisc/src/query_smp.c b/ibdiags/libibnetdisc/src/query_smp.c
index 26a5909524f777..47693bcf697cfa 100644
--- a/ibdiags/libibnetdisc/src/query_smp.c
+++ b/ibdiags/libibnetdisc/src/query_smp.c
@@ -32,10 +32,6 @@
  *
  */
 
-#if HAVE_CONFIG_H
-#  include <config.h>
-#endif				/* HAVE_CONFIG_H */
-
 #include <errno.h>
 #include <infiniband/ibnetdisc.h>
 #include <infiniband/umad.h>
diff --git a/ibdiags/libibnetdisc/test/testleaks.c b/ibdiags/libibnetdisc/test/testleaks.c
index 508c5ae2e84112..0723b109854de8 100644
--- a/ibdiags/libibnetdisc/test/testleaks.c
+++ b/ibdiags/libibnetdisc/test/testleaks.c
@@ -33,10 +33,6 @@
  *
  */
 
-#if HAVE_CONFIG_H
-#  include <config.h>
-#endif				/* HAVE_CONFIG_H */
-
 #define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/ibdiags/src/dump_fts.c b/ibdiags/src/dump_fts.c
index 8a5b3e20da6b45..6aba80827d279c 100644
--- a/ibdiags/src/dump_fts.c
+++ b/ibdiags/src/dump_fts.c
@@ -33,10 +33,6 @@
  *
  */
 
-#if HAVE_CONFIG_H
-#  include <config.h>
-#endif				/* HAVE_CONFIG_H */
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
diff --git a/ibdiags/src/ibaddr.c b/ibdiags/src/ibaddr.c
index 4c2b67c7428d6f..19d2ec31a43206 100644
--- a/ibdiags/src/ibaddr.c
+++ b/ibdiags/src/ibaddr.c
@@ -32,10 +32,6 @@
  *
  */
 
-#if HAVE_CONFIG_H
-#  include <config.h>
-#endif				/* HAVE_CONFIG_H */
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
diff --git a/ibdiags/src/ibcacheedit.c b/ibdiags/src/ibcacheedit.c
index 03e4a7efeaeae5..4b8dbcb00d1d11 100644
--- a/ibdiags/src/ibcacheedit.c
+++ b/ibdiags/src/ibcacheedit.c
@@ -31,10 +31,6 @@
  *
  */
 
-#if HAVE_CONFIG_H
-#  include <config.h>
-#endif				/* HAVE_CONFIG_H */
-
 #define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/ibdiags/src/ibccconfig.c b/ibdiags/src/ibccconfig.c
index 296d3f791419d7..7a02ee7f81794a 100644
--- a/ibdiags/src/ibccconfig.c
+++ b/ibdiags/src/ibccconfig.c
@@ -33,10 +33,6 @@
  *
  */
 
-#if HAVE_CONFIG_H
-#  include <config.h>
-#endif				/* HAVE_CONFIG_H */
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
diff --git a/ibdiags/src/ibccquery.c b/ibdiags/src/ibccquery.c
index 390ea71d55b0df..e9e8b4969f6cc9 100644
--- a/ibdiags/src/ibccquery.c
+++ b/ibdiags/src/ibccquery.c
@@ -33,10 +33,6 @@
  *
  */
 
-#if HAVE_CONFIG_H
-#  include <config.h>
-#endif				/* HAVE_CONFIG_H */
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
diff --git a/ibdiags/src/iblinkinfo.c b/ibdiags/src/iblinkinfo.c
index 7060959993b0e9..557faad0b6f3bf 100644
--- a/ibdiags/src/iblinkinfo.c
+++ b/ibdiags/src/iblinkinfo.c
@@ -34,10 +34,6 @@
  *
  */
 
-#if HAVE_CONFIG_H
-#  include <config.h>
-#endif				/* HAVE_CONFIG_H */
-
 #define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/ibdiags/src/ibnetdiscover.c b/ibdiags/src/ibnetdiscover.c
index ba2e04a15783c8..e8c8b19be4e592 100644
--- a/ibdiags/src/ibnetdiscover.c
+++ b/ibdiags/src/ibnetdiscover.c
@@ -34,10 +34,6 @@
  *
  */
 
-#if HAVE_CONFIG_H
-#include <config.h>
-#endif				/* HAVE_CONFIG_H */
-
 #define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/ibdiags/src/ibping.c b/ibdiags/src/ibping.c
index 9a236fe8233f85..0d10da0b34da87 100644
--- a/ibdiags/src/ibping.c
+++ b/ibdiags/src/ibping.c
@@ -31,10 +31,6 @@
  *
  */
 
-#if HAVE_CONFIG_H
-#  include <config.h>
-#endif				/* HAVE_CONFIG_H */
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
diff --git a/ibdiags/src/ibportstate.c b/ibdiags/src/ibportstate.c
index 60afcb45a3ee07..d57554d7067711 100644
--- a/ibdiags/src/ibportstate.c
+++ b/ibdiags/src/ibportstate.c
@@ -33,10 +33,6 @@
  *
  */
 
-#if HAVE_CONFIG_H
-#  include <config.h>
-#endif				/* HAVE_CONFIG_H */
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
diff --git a/ibdiags/src/ibqueryerrors.c b/ibdiags/src/ibqueryerrors.c
index dcda64da529a51..332b7ce764e097 100644
--- a/ibdiags/src/ibqueryerrors.c
+++ b/ibdiags/src/ibqueryerrors.c
@@ -35,9 +35,7 @@
  *
  */
 
-#if HAVE_CONFIG_H
-#  include <config.h>
-#endif				/* HAVE_CONFIG_H */
+#include <config.h>
 
 #define _GNU_SOURCE
 #include <stdio.h>
diff --git a/ibdiags/src/ibroute.c b/ibdiags/src/ibroute.c
index 8108362e3a45cd..6a59d63483ad3f 100644
--- a/ibdiags/src/ibroute.c
+++ b/ibdiags/src/ibroute.c
@@ -32,10 +32,6 @@
  *
  */
 
-#if HAVE_CONFIG_H
-#  include <config.h>
-#endif				/* HAVE_CONFIG_H */
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
diff --git a/ibdiags/src/ibstat.c b/ibdiags/src/ibstat.c
index 61c6611a05043e..4601f2ad57d36c 100644
--- a/ibdiags/src/ibstat.c
+++ b/ibdiags/src/ibstat.c
@@ -34,10 +34,6 @@
 
 #define _GNU_SOURCE
 
-#if HAVE_CONFIG_H
-#  include <config.h>
-#endif				/* HAVE_CONFIG_H */
-
 #include <inttypes.h>
 #include <string.h>
 #include <stdio.h>
diff --git a/ibdiags/src/ibsysstat.c b/ibdiags/src/ibsysstat.c
index 4d8267e2eba4ed..6ff7ca0c44ae47 100644
--- a/ibdiags/src/ibsysstat.c
+++ b/ibdiags/src/ibsysstat.c
@@ -31,10 +31,6 @@
  *
  */
 
-#if HAVE_CONFIG_H
-#  include <config.h>
-#endif				/* HAVE_CONFIG_H */
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
diff --git a/ibdiags/src/ibtracert.c b/ibdiags/src/ibtracert.c
index 7bdb1e0034e8ea..b7d383a8d48947 100644
--- a/ibdiags/src/ibtracert.c
+++ b/ibdiags/src/ibtracert.c
@@ -33,10 +33,6 @@
  *
  */
 
-#if HAVE_CONFIG_H
-#  include <config.h>
-#endif				/* HAVE_CONFIG_H */
-
 #define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/ibdiags/src/mcm_rereg_test.c b/ibdiags/src/mcm_rereg_test.c
index f521f22277cece..66c066b40e40cc 100644
--- a/ibdiags/src/mcm_rereg_test.c
+++ b/ibdiags/src/mcm_rereg_test.c
@@ -31,10 +31,6 @@
  *
  */
 
-#if HAVE_CONFIG_H
-#  include <config.h>
-#endif				/* HAVE_CONFIG_H */
-
 #include <stdio.h>
 #include <string.h>
 #include <errno.h>
diff --git a/ibdiags/src/perfquery.c b/ibdiags/src/perfquery.c
index 6bb29e6f82c335..b921e3d402854c 100644
--- a/ibdiags/src/perfquery.c
+++ b/ibdiags/src/perfquery.c
@@ -34,10 +34,6 @@
  *
  */
 
-#if HAVE_CONFIG_H
-#  include <config.h>
-#endif				/* HAVE_CONFIG_H */
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
diff --git a/ibdiags/src/saquery.c b/ibdiags/src/saquery.c
index 379b9436c794d5..f50430818c7863 100644
--- a/ibdiags/src/saquery.c
+++ b/ibdiags/src/saquery.c
@@ -38,10 +38,6 @@
  *
  */
 
-#if HAVE_CONFIG_H
-#  include <config.h>
-#endif				/* HAVE_CONFIG_H */
-
 #include <unistd.h>
 #include <stdio.h>
 #include <arpa/inet.h>
diff --git a/ibdiags/src/sminfo.c b/ibdiags/src/sminfo.c
index 494c95be239e91..7193a999aee5cf 100644
--- a/ibdiags/src/sminfo.c
+++ b/ibdiags/src/sminfo.c
@@ -32,10 +32,6 @@
  *
  */
 
-#if HAVE_CONFIG_H
-#  include <config.h>
-#endif				/* HAVE_CONFIG_H */
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
diff --git a/ibdiags/src/smpdump.c b/ibdiags/src/smpdump.c
index ece87bf2bb49e6..b5bb87ba30ed48 100644
--- a/ibdiags/src/smpdump.c
+++ b/ibdiags/src/smpdump.c
@@ -33,10 +33,6 @@
 
 #define _GNU_SOURCE
 
-#if HAVE_CONFIG_H
-#  include <config.h>
-#endif				/* HAVE_CONFIG_H */
-
 #include <inttypes.h>
 #include <string.h>
 #include <errno.h>
diff --git a/ibdiags/src/smpquery.c b/ibdiags/src/smpquery.c
index 6d54e65fd49181..210bad41fdf88f 100644
--- a/ibdiags/src/smpquery.c
+++ b/ibdiags/src/smpquery.c
@@ -32,10 +32,6 @@
  *
  */
 
-#if HAVE_CONFIG_H
-#  include <config.h>
-#endif				/* HAVE_CONFIG_H */
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
diff --git a/ibdiags/src/vendstat.c b/ibdiags/src/vendstat.c
index 49036d4f127f30..2f7d7bd877b23d 100644
--- a/ibdiags/src/vendstat.c
+++ b/ibdiags/src/vendstat.c
@@ -32,10 +32,6 @@
  *
  */
 
-#if HAVE_CONFIG_H
-#  include <config.h>
-#endif				/* HAVE_CONFIG_H */
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
-- 
2.21.0

