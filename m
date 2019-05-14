Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D28371E5C7
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 01:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfENXtp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 May 2019 19:49:45 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33728 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfENXto (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 May 2019 19:49:44 -0400
Received: by mail-qt1-f195.google.com with SMTP id m32so1264903qtf.0
        for <linux-rdma@vger.kernel.org>; Tue, 14 May 2019 16:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9IViokkzoWRwsO0VggXEtxPjZSpWiYtH5t/zqD8CvWI=;
        b=JnzQP4vIjV2LyfjfnGrmcfrZ05TBVWk0lbnny0uzm2S3hbtxYrtjjUSujQO5+9Nmq6
         qs1xZ7W+XsaSp8ZXlPwEoPhRtV++NJARkOHtzydDDXq7fAHblu/KMGBK0hNpmach8qzO
         ufDRxqGtzsau9IzMph6acGkrsonNBgJD9Phc/QXdwngsHvlcQbv53FyGh1bazVCeSePn
         UhO0Oh5IFLjF9MyWPPGi2BHXoQMQjshDb06MLdD/HY/VciHhaG79ylq0TP2GqrqZWNVp
         CnoXHRSWXnBsbn5fT+Y15fhLdlAnNADUEQWVQp9Y0amTY+4o3KBTwzUPDGLs76hHoOHA
         fsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9IViokkzoWRwsO0VggXEtxPjZSpWiYtH5t/zqD8CvWI=;
        b=azN0V8rAaw99woLndnK0EIAklqidU5X4DEEyuYGbX8YZfyR9Tt9kV5f/78oCqhIqpK
         q8LnTUUbk1grNhGdfIZ0IYIQJ//1c2bS00VLCNZqn2Yh4Y644AuMWpED9ONxp3H1QPiR
         fVy9ja2QfmoVGkLMf3fwp+NQ9IppeVcKEzUhLsKAdQWfCuovfkSQGtp2zsGV6ix0qke1
         2glGlCTupGyaD4A7v2hSrbjRoycERThn97wwMtJRAMLlczAc/4eiYDn4e96xUlSAFhfl
         0s67OLjro/HlIGYiRdpl91JDGxsAqC5vFzQkU/wF5H0BsdFv4T0d9W4NpnaYzo4sGERg
         /sRQ==
X-Gm-Message-State: APjAAAX5wWbFLIQBnAapBnTxZxOvQXCVvQ0AXWBETQCyEP6KI7a0sW8O
        2ypc+TuTInh1iAOb39EJPy8qhaWGHgA=
X-Google-Smtp-Source: APXvYqxb57WkXIm9ylaQ86tkZoUUzbVHi1toMOU4f5Pw60NSJMNhjgAeQysMTB9T8mCwWb+nFjvxgw==
X-Received: by 2002:ac8:38eb:: with SMTP id g40mr33475513qtc.342.1557877782712;
        Tue, 14 May 2019 16:49:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id x47sm246387qth.68.2019.05.14.16.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 16:49:40 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hQhAx-0001Nb-3Z; Tue, 14 May 2019 20:49:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 10/20] ibdiags: Provide the cl_nodenamemap interface
Date:   Tue, 14 May 2019 20:49:26 -0300
Message-Id: <20190514234936.5175-11-jgg@ziepe.ca>
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

Copy the implementation from opensm and match the style to rdma-core.

This version is copied from opensm commit 6d49a7e3c02a
("libvendor/osm_vendor_mlx_sim.c: In osmv_transport_init, fix memory leaks
on error")

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 CMakeLists.txt              |   1 +
 buildlib/config.h.in        |   1 +
 ibdiags/src/CMakeLists.txt  |   3 +-
 ibdiags/src/dump_fts.c      |   2 +-
 ibdiags/src/iblinkinfo.c    |   2 +-
 ibdiags/src/ibnetdiscover.c |   2 +-
 ibdiags/src/ibqueryerrors.c |   2 +-
 ibdiags/src/ibroute.c       |   2 +-
 ibdiags/src/ibtracert.c     |   2 +-
 ibdiags/src/saquery.c       |   2 +-
 ibdiags/src/smpquery.c      |   2 +-
 util/CMakeLists.txt         |   2 +
 util/node_name_map.c        | 222 ++++++++++++++++++++++++++++++++++++
 util/node_name_map.h        |  19 +++
 14 files changed, 254 insertions(+), 10 deletions(-)
 create mode 100644 util/node_name_map.c
 create mode 100644 util/node_name_map.h

diff --git a/CMakeLists.txt b/CMakeLists.txt
index c54cf6606e3c0d..e16b955991558a 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -104,6 +104,7 @@ set(BUILD_ETC ${CMAKE_BINARY_DIR}/etc)
 set(BUILD_PYTHON ${CMAKE_BINARY_DIR}/python)
 
 set(IBDIAG_CONFIG_PATH "${CMAKE_INSTALL_FULL_SYSCONFDIR}/infiniband-diags")
+set(IBDIAG_NODENAME_MAP_PATH "${CMAKE_INSTALL_FULL_SYSCONFDIR}/rdma/ib-node-name-map")
 
 set(CMAKE_INSTALL_INITDDIR "${CMAKE_INSTALL_SYSCONFDIR}/init.d"
   CACHE PATH "Location for init.d files")
diff --git a/buildlib/config.h.in b/buildlib/config.h.in
index b4cb669b7be4bf..2bac241ce1fdf1 100644
--- a/buildlib/config.h.in
+++ b/buildlib/config.h.in
@@ -32,6 +32,7 @@
 #define IBACM_SERVER_PATH "@CMAKE_INSTALL_FULL_RUNDIR@/ibacm.sock"
 
 #define IBDIAG_CONFIG_PATH "@IBDIAG_CONFIG_PATH@"
+#define IBDIAG_NODENAME_MAP_PATH "@IBDIAG_NODENAME_MAP_PATH@"
 
 #define VERBS_PROVIDER_DIR "@VERBS_PROVIDER_DIR@"
 #define VERBS_PROVIDER_SUFFIX "@IBVERBS_PROVIDER_SUFFIX@"
diff --git a/ibdiags/src/CMakeLists.txt b/ibdiags/src/CMakeLists.txt
index c12452f92c7c9c..b28f543f2f0699 100644
--- a/ibdiags/src/CMakeLists.txt
+++ b/ibdiags/src/CMakeLists.txt
@@ -11,8 +11,7 @@ add_library(ibdiags_tools STATIC
 function(ibdiag_programs)
   foreach(I ${ARGN})
     rdma_sbin_executable(${I} "${I}.c")
-    target_link_libraries(${I} PRIVATE ${RT_LIBRARIES} ibumad ibmad ibdiags_tools ibnetdisc osmcomp)
-    target_include_directories(${I} PRIVATE "/usr/include/infiniband")
+    target_link_libraries(${I} PRIVATE ${RT_LIBRARIES} ibumad ibmad ibdiags_tools ibnetdisc)
   endforeach()
 endfunction()
 
diff --git a/ibdiags/src/dump_fts.c b/ibdiags/src/dump_fts.c
index 6aba80827d279c..14a9ae216dc070 100644
--- a/ibdiags/src/dump_fts.c
+++ b/ibdiags/src/dump_fts.c
@@ -43,7 +43,7 @@
 
 #include <infiniband/umad.h>
 #include <infiniband/mad.h>
-#include <complib/cl_nodenamemap.h>
+#include <util/node_name_map.h>
 
 #include <infiniband/ibnetdisc.h>
 
diff --git a/ibdiags/src/iblinkinfo.c b/ibdiags/src/iblinkinfo.c
index 557faad0b6f3bf..afd2f4e882c65b 100644
--- a/ibdiags/src/iblinkinfo.c
+++ b/ibdiags/src/iblinkinfo.c
@@ -44,7 +44,7 @@
 #include <errno.h>
 #include <inttypes.h>
 
-#include <complib/cl_nodenamemap.h>
+#include <util/node_name_map.h>
 #include <infiniband/ibnetdisc.h>
 
 #include "ibdiag_common.h"
diff --git a/ibdiags/src/ibnetdiscover.c b/ibdiags/src/ibnetdiscover.c
index e8c8b19be4e592..88e44f18c9cb02 100644
--- a/ibdiags/src/ibnetdiscover.c
+++ b/ibdiags/src/ibnetdiscover.c
@@ -44,7 +44,7 @@
 
 #include <infiniband/umad.h>
 #include <infiniband/mad.h>
-#include <complib/cl_nodenamemap.h>
+#include <util/node_name_map.h>
 #include <infiniband/ibnetdisc.h>
 
 #include "ibdiag_common.h"
diff --git a/ibdiags/src/ibqueryerrors.c b/ibdiags/src/ibqueryerrors.c
index 332b7ce764e097..48c9f17bb2625f 100644
--- a/ibdiags/src/ibqueryerrors.c
+++ b/ibdiags/src/ibqueryerrors.c
@@ -47,7 +47,7 @@
 #include <errno.h>
 #include <inttypes.h>
 
-#include <complib/cl_nodenamemap.h>
+#include <util/node_name_map.h>
 #include <infiniband/ibnetdisc.h>
 #include <infiniband/mad.h>
 
diff --git a/ibdiags/src/ibroute.c b/ibdiags/src/ibroute.c
index 6a59d63483ad3f..114f476fe7b670 100644
--- a/ibdiags/src/ibroute.c
+++ b/ibdiags/src/ibroute.c
@@ -41,7 +41,7 @@
 
 #include <infiniband/umad.h>
 #include <infiniband/mad.h>
-#include <complib/cl_nodenamemap.h>
+#include <util/node_name_map.h>
 
 #include "ibdiag_common.h"
 
diff --git a/ibdiags/src/ibtracert.c b/ibdiags/src/ibtracert.c
index b7d383a8d48947..c1560107fd9e91 100644
--- a/ibdiags/src/ibtracert.c
+++ b/ibdiags/src/ibtracert.c
@@ -43,7 +43,7 @@
 
 #include <infiniband/umad.h>
 #include <infiniband/mad.h>
-#include <complib/cl_nodenamemap.h>
+#include <util/node_name_map.h>
 
 #include "ibdiag_common.h"
 
diff --git a/ibdiags/src/saquery.c b/ibdiags/src/saquery.c
index 8c0f57ffe9ed4e..37951595c603fd 100644
--- a/ibdiags/src/saquery.c
+++ b/ibdiags/src/saquery.c
@@ -49,7 +49,7 @@
 
 #include <infiniband/umad.h>
 #include <infiniband/mad.h>
-#include <complib/cl_nodenamemap.h>
+#include <util/node_name_map.h>
 
 #include "ibdiag_common.h"
 #include "ibdiag_sa.h"
diff --git a/ibdiags/src/smpquery.c b/ibdiags/src/smpquery.c
index 210bad41fdf88f..36988287442c9f 100644
--- a/ibdiags/src/smpquery.c
+++ b/ibdiags/src/smpquery.c
@@ -43,7 +43,7 @@
 
 #include <infiniband/umad.h>
 #include <infiniband/mad.h>
-#include <complib/cl_nodenamemap.h>
+#include <util/node_name_map.h>
 
 #include "ibdiag_common.h"
 
diff --git a/util/CMakeLists.txt b/util/CMakeLists.txt
index 8b4f5d65c753f5..bb43ad444116d4 100644
--- a/util/CMakeLists.txt
+++ b/util/CMakeLists.txt
@@ -1,12 +1,14 @@
 publish_internal_headers(util
   cl_qmap.h
   compiler.h
+  node_name_map.h
   symver.h
   util.h
   )
 
 set(C_FILES
   cl_map.c
+  node_name_map.c
   util.c)
 
 if (HAVE_COHERENT_DMA)
diff --git a/util/node_name_map.c b/util/node_name_map.c
new file mode 100644
index 00000000000000..cd73bbc97a4809
--- /dev/null
+++ b/util/node_name_map.c
@@ -0,0 +1,222 @@
+/*
+ * Copyright (c) 2008 Voltaire, Inc. All rights reserved.
+ * Copyright (c) 2007 Lawrence Livermore National Lab
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ *
+ */
+
+#include <config.h>
+
+#include <string.h>
+#include <stdlib.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <ctype.h>
+#include <errno.h>
+
+#include <ccan/minmax.h>
+
+#include <util/node_name_map.h>
+#include <util/cl_qmap.h>
+
+#define PARSE_NODE_MAP_BUFLEN  256
+
+typedef struct _name_map_item {
+        cl_map_item_t item;
+        uint64_t guid;
+        char *name;
+} name_map_item_t;
+
+struct nn_map {
+	cl_qmap_t map;
+};
+
+static int map_name(void *cxt, uint64_t guid, char *p)
+{
+	cl_qmap_t *map = cxt;
+	name_map_item_t *item;
+
+	p = strtok(p, "\"#");
+	if (!p)
+		return 0;
+
+	item = malloc(sizeof(*item));
+	if (!item)
+		return -1;
+	item->guid = guid;
+	item->name = strdup(p);
+	cl_qmap_insert(map, item->guid, (cl_map_item_t *) item);
+	return 0;
+}
+
+void close_node_name_map(nn_map_t * map)
+{
+	name_map_item_t *item = NULL;
+
+	if (!map)
+		return;
+
+	item = (name_map_item_t *) cl_qmap_head(&map->map);
+	while (item != (name_map_item_t *) cl_qmap_end(&map->map)) {
+		item = (name_map_item_t *) cl_qmap_remove(&map->map, item->guid);
+		free(item->name);
+		free(item);
+		item = (name_map_item_t *) cl_qmap_head(&map->map);
+	}
+	free(map);
+}
+
+char *remap_node_name(nn_map_t * map, uint64_t target_guid, char *nodedesc)
+{
+	char *rc = NULL;
+	name_map_item_t *item = NULL;
+
+	if (!map)
+		goto done;
+
+	item = (name_map_item_t *) cl_qmap_get(&map->map, target_guid);
+	if (item != (name_map_item_t *) cl_qmap_end(&map->map))
+		rc = strdup(item->name);
+
+done:
+	if (rc == NULL)
+		rc = strdup(clean_nodedesc(nodedesc));
+	return (rc);
+}
+
+char *clean_nodedesc(char *nodedesc)
+{
+	int i = 0;
+
+	nodedesc[63] = '\0';
+	while (nodedesc[i]) {
+		if (!isprint(nodedesc[i]))
+			nodedesc[i] = ' ';
+		i++;
+	}
+
+	return (nodedesc);
+}
+
+static int parse_node_map_wrap(const char *file_name,
+			       int (*create) (void *, uint64_t, char *),
+			       void *cxt,
+			       char *linebuf,
+			       unsigned int linebuflen)
+{
+	char line[PARSE_NODE_MAP_BUFLEN];
+	FILE *f;
+
+	if (!(f = fopen(file_name, "r")))
+		return -1;
+
+	while (fgets(line, sizeof(line), f)) {
+		uint64_t guid;
+		char *p, *e;
+
+		p = line;
+		while (isspace(*p))
+			p++;
+		if (*p == '\0' || *p == '\n' || *p == '#')
+			continue;
+
+		guid = strtoull(p, &e, 0);
+		if (e == p || (!isspace(*e) && *e != '#' && *e != '\0')) {
+			fclose(f);
+			errno = EIO;
+			if (linebuf) {
+				memcpy(linebuf, line,
+				       min_t(size_t, PARSE_NODE_MAP_BUFLEN,
+					     linebuflen));
+				e = strpbrk(linebuf, "\n");
+				if (e)
+					*e = '\0';
+			}
+			return -1;
+		}
+
+		p = e;
+		while (isspace(*p))
+			p++;
+
+		e = strpbrk(p, "\n");
+		if (e)
+			*e = '\0';
+
+		if (create(cxt, guid, p)) {
+			fclose(f);
+			return -1;
+		}
+	}
+
+	fclose(f);
+	return 0;
+}
+
+nn_map_t *open_node_name_map(const char *node_name_map)
+{
+	nn_map_t *map;
+	char linebuf[PARSE_NODE_MAP_BUFLEN + 1];
+
+	if (!node_name_map) {
+		struct stat buf;
+		node_name_map = IBDIAG_NODENAME_MAP_PATH;
+		if (stat(node_name_map, &buf))
+			return NULL;
+	}
+
+	map = malloc(sizeof(*map));
+	if (!map)
+		return NULL;
+	cl_qmap_init(&map->map);
+
+	memset(linebuf, '\0', PARSE_NODE_MAP_BUFLEN + 1);
+	if (parse_node_map_wrap(node_name_map, map_name, map,
+				linebuf, PARSE_NODE_MAP_BUFLEN)) {
+		if (errno == EIO) {
+			fprintf(stderr,
+				"WARNING failed to parse node name map "
+				"\"%s\"\n",
+				node_name_map);
+			fprintf(stderr,
+				"WARNING failed line: \"%s\"\n",
+				linebuf);
+		}
+		else
+			fprintf(stderr,
+				"WARNING failed to open node name map "
+				"\"%s\" (%s)\n",
+				node_name_map, strerror(errno));
+		close_node_name_map(map);
+		return NULL;
+	}
+
+	return map;
+}
diff --git a/util/node_name_map.h b/util/node_name_map.h
new file mode 100644
index 00000000000000..e78d274b116ee3
--- /dev/null
+++ b/util/node_name_map.h
@@ -0,0 +1,19 @@
+/* Copyright (c) 2019 Mellanox Technologies. All rights reserved.
+ *
+ * Connect to opensm's cl_nodenamemap.h if it is available.
+ */
+#ifndef __LIBUTIL_NODE_NAME_MAP_H__
+#define __LIBUTIL_NODE_NAME_MAP_H__
+
+#include <stdint.h>
+
+struct nn_map;
+typedef struct nn_map nn_map_t;
+
+nn_map_t *open_node_name_map(const char *node_name_map);
+void close_node_name_map(nn_map_t *map);
+/* NOTE: parameter "nodedesc" may be modified here. */
+char *remap_node_name(nn_map_t *map, uint64_t target_guid, char *nodedesc);
+char *clean_nodedesc(char *nodedesc);
+
+#endif
-- 
2.21.0

