Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 421141E5CD
	for <lists+linux-rdma@lfdr.de>; Wed, 15 May 2019 01:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfENXts (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 May 2019 19:49:48 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42917 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfENXtm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 May 2019 19:49:42 -0400
Received: by mail-qk1-f196.google.com with SMTP id d4so387211qkc.9
        for <linux-rdma@vger.kernel.org>; Tue, 14 May 2019 16:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4LfgYjUQkwm95KvesbuLbSnqHwKw7X0yUQzuMBDUY74=;
        b=BUXLfR8EkEPUfWmNvvy4e/VR3Sv+B+2B0xcxfAGtP+mn4rinrZjxiOwbdaUG/y6YAi
         CFyuKEdpn4Nra3G4ZNhidEGMtJmKZqbbWZCQLCanbadsd1qsny5H/mbK5szVNA71OnIQ
         EENhnCfUpxldD0DOTaneIDe3U6tE13qDRAlBysyRvDka5rJ0nuECKkZ8ORbpHvd0w/11
         g/o+jdZz+aJunmGwyii+R6Wush1amij6CrAOkGxcUP36MO4fCtrrcNlGAkwkMjFLPJbC
         oYiKdf/TOrGm7fadB4oK9vSFxpCTdQG5jLCzNa8tmZLFeQUbNzb+F4rLITQJB/swbM5i
         cxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4LfgYjUQkwm95KvesbuLbSnqHwKw7X0yUQzuMBDUY74=;
        b=ad2bhtW69IDfzdVVRkv3sV3DA3ZlMcnbarZ/uCOpXYXUIJeKWpBiyZc0yp4ZwJMF/5
         S+uKlNBNpCsROWupmkaDYsqjK1zlitsAf5uien0fErJ67WAaiAG7XyTaG1J0xaePPQ3/
         0j+AZJMiwlSy+2pIZf71OKSB8EtWWxbAOmMkgD8dQiY39Gl8xpG2xMQ/+uWJVFWnjlXd
         ndrPE8T0lgN40U6ePqb76HfOsOuHGSTvesUKKAyYvAC+iavD3/sNK7fb2Zi2Wuau9vge
         JBNDgxIy4bRPfHwVFCi+1j10drjNPLJgPGkRb10hpfJ1KsHMKW1Qim0Q1sw4Y5M21nOC
         ODCg==
X-Gm-Message-State: APjAAAUgHzOhGl9nnhcjf+YWybUf5CqPyauSfpLkgl7a9z4jrPxMY+R8
        yz3NeaIQOg2j9xQblP7mM1s3k1uMSmU=
X-Google-Smtp-Source: APXvYqy5dPKcV/IaRQriliu1l117q9t8tUl4aIl8n1spx+LSCgGfNpvFq25E3pcZsUkZT/2P9Sbmyw==
X-Received: by 2002:a37:9b88:: with SMTP id d130mr28810702qke.278.1557877780085;
        Tue, 14 May 2019 16:49:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id r47sm403558qtc.14.2019.05.14.16.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 16:49:40 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hQhAx-0001NP-0H; Tue, 14 May 2019 20:49:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 08/20] ibdiags: Copy the cl_qmap implementation from opensm
Date:   Tue, 14 May 2019 20:49:24 -0300
Message-Id: <20190514234936.5175-9-jgg@ziepe.ca>
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

ibdiags stuff is using this, so provide it internally as we can't depend
on opensm. This version is copied from opensm commit
6d49a7e3c02a ("libvendor/osm_vendor_mlx_sim.c: In osmv_transport_init, fix
memory leaks on error") and then stripped down.

This eliminates complib dependencies from libibnetdisc.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 ibdiags/libibnetdisc/src/CMakeLists.txt |   1 -
 ibdiags/libibnetdisc/src/ibnetdisc.c    |   1 -
 ibdiags/libibnetdisc/src/internal.h     |   2 +-
 ibdiags/libibnetdisc/test/testleaks.c   |   1 -
 util/CMakeLists.txt                     |   2 +
 util/cl_map.c                           | 700 +++++++++++++++++
 util/cl_qmap.h                          | 970 ++++++++++++++++++++++++
 7 files changed, 1673 insertions(+), 4 deletions(-)
 create mode 100644 util/cl_map.c
 create mode 100644 util/cl_qmap.h

diff --git a/ibdiags/libibnetdisc/src/CMakeLists.txt b/ibdiags/libibnetdisc/src/CMakeLists.txt
index a71516ecc1eb60..c93c9be8cc6cd6 100644
--- a/ibdiags/libibnetdisc/src/CMakeLists.txt
+++ b/ibdiags/libibnetdisc/src/CMakeLists.txt
@@ -14,7 +14,6 @@ rdma_library(ibnetdisc libibnetdisc.map
 target_link_libraries(ibnetdisc LINK_PRIVATE
   ibmad
   ibumad
-  osmcomp
   )
 # FIXME for osmcomp
 target_include_directories(ibnetdisc PRIVATE "/usr/include/infiniband")
diff --git a/ibdiags/libibnetdisc/src/ibnetdisc.c b/ibdiags/libibnetdisc/src/ibnetdisc.c
index 0c60b4419a9c8e..7425545b78f532 100644
--- a/ibdiags/libibnetdisc/src/ibnetdisc.c
+++ b/ibdiags/libibnetdisc/src/ibnetdisc.c
@@ -46,7 +46,6 @@
 #include <infiniband/mad.h>
 
 #include <infiniband/ibnetdisc.h>
-#include <complib/cl_nodenamemap.h>
 
 #include "internal.h"
 #include "chassis.h"
diff --git a/ibdiags/libibnetdisc/src/internal.h b/ibdiags/libibnetdisc/src/internal.h
index a40f48ea373718..7b5d4e85fd191f 100644
--- a/ibdiags/libibnetdisc/src/internal.h
+++ b/ibdiags/libibnetdisc/src/internal.h
@@ -39,7 +39,7 @@
 #define _INTERNAL_H_
 
 #include <infiniband/ibnetdisc.h>
-#include <complib/cl_qmap.h>
+#include <util/cl_qmap.h>
 
 #define	IBND_DEBUG(fmt, ...) \
 	if (ibdebug) { \
diff --git a/ibdiags/libibnetdisc/test/testleaks.c b/ibdiags/libibnetdisc/test/testleaks.c
index 0723b109854de8..f1e1985d279156 100644
--- a/ibdiags/libibnetdisc/test/testleaks.c
+++ b/ibdiags/libibnetdisc/test/testleaks.c
@@ -44,7 +44,6 @@
 #include <errno.h>
 #include <inttypes.h>
 
-#include <infiniband/complib/cl_nodenamemap.h>
 #include <infiniband/ibnetdisc.h>
 
 static const char *argv0 = "iblinkinfotest";
diff --git a/util/CMakeLists.txt b/util/CMakeLists.txt
index 4e9c4f16f30fa9..8b4f5d65c753f5 100644
--- a/util/CMakeLists.txt
+++ b/util/CMakeLists.txt
@@ -1,10 +1,12 @@
 publish_internal_headers(util
+  cl_qmap.h
   compiler.h
   symver.h
   util.h
   )
 
 set(C_FILES
+  cl_map.c
   util.c)
 
 if (HAVE_COHERENT_DMA)
diff --git a/util/cl_map.c b/util/cl_map.c
new file mode 100644
index 00000000000000..f48efec73197e1
--- /dev/null
+++ b/util/cl_map.c
@@ -0,0 +1,700 @@
+/*
+ * Copyright (c) 2004-2009 Voltaire, Inc. All rights reserved.
+ * Copyright (c) 2002-2005 Mellanox Technologies LTD. All rights reserved.
+ * Copyright (c) 1996-2003 Intel Corporation. All rights reserved.
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
+/*
+ * Abstract:
+ *	Implementation of quick map, a binary tree where the caller always
+ *	provides all necessary storage.
+ *
+ */
+
+/*****************************************************************************
+*
+* Map
+*
+* Map is an associative array.  By providing a key, the caller can retrieve
+* an object from the map.  All objects in the map have an associated key,
+* as specified by the caller when the object was inserted into the map.
+* In addition to random access, the caller can traverse the map much like
+* a linked list, either forwards from the first object or backwards from
+* the last object.  The objects in the map are always traversed in
+* order since the nodes are stored sorted.
+*
+* This implementation of Map uses a red black tree verified against
+* Cormen-Leiserson-Rivest text, McGraw-Hill Edition, fourteenth
+* printing, 1994.
+*
+*****************************************************************************/
+
+#include <util/cl_qmap.h>
+#include <string.h>
+
+static inline void __cl_primitive_insert(cl_list_item_t *const p_list_item,
+					 cl_list_item_t *const p_new_item)
+{
+        /* CL_ASSERT that a non-null pointer is provided. */
+        assert(p_list_item);
+        /* CL_ASSERT that a non-null pointer is provided. */
+	assert(p_new_item);
+
+	p_new_item->p_next = p_list_item;
+        p_new_item->p_prev = p_list_item->p_prev;
+        p_list_item->p_prev = p_new_item;
+        p_new_item->p_prev->p_next = p_new_item;
+}
+
+static inline void __cl_primitive_remove(cl_list_item_t *const p_list_item)
+{
+        /* CL_ASSERT that a non-null pointer is provided. */
+        assert(p_list_item);
+
+        /* set the back pointer */
+        p_list_item->p_next->p_prev = p_list_item->p_prev;
+        /* set the next pointer */
+        p_list_item->p_prev->p_next = p_list_item->p_next;
+
+        /* if we're debugging, spruce up the pointers to help find bugs */
+#if defined( _DEBUG_ )
+        if (p_list_item != p_list_item->p_next) {
+                p_list_item->p_next = NULL;
+                p_list_item->p_prev = NULL;
+        }
+#endif                          /* defined( _DEBUG_ ) */
+}
+
+/******************************************************************************
+ IMPLEMENTATION OF QUICK MAP
+******************************************************************************/
+
+/*
+ * Get the root.
+ */
+static inline cl_map_item_t *__cl_map_root(const cl_qmap_t * const p_map)
+{
+	assert(p_map);
+	return (p_map->root.p_left);
+}
+
+/*
+ * Returns whether a given item is on the left of its parent.
+ */
+static bool __cl_map_is_left_child(const cl_map_item_t * const p_item)
+{
+	assert(p_item);
+	assert(p_item->p_up);
+	assert(p_item->p_up != p_item);
+
+	return (p_item->p_up->p_left == p_item);
+}
+
+/*
+ * Retrieve the pointer to the parent's pointer to an item.
+ */
+static cl_map_item_t **__cl_map_get_parent_ptr_to_item(cl_map_item_t *
+						       const p_item)
+{
+	assert(p_item);
+	assert(p_item->p_up);
+	assert(p_item->p_up != p_item);
+
+	if (__cl_map_is_left_child(p_item))
+		return (&p_item->p_up->p_left);
+
+	assert(p_item->p_up->p_right == p_item);
+	return (&p_item->p_up->p_right);
+}
+
+/*
+ * Rotate a node to the left.  This rotation affects the least number of links
+ * between nodes and brings the level of C up by one while increasing the depth
+ * of A one.  Note that the links to/from W, X, Y, and Z are not affected.
+ *
+ *	    R				      R
+ *	    |				      |
+ *	    A				      C
+ *	  /   \			        /   \
+ *	W       C			  A       Z
+ *	       / \			 / \
+ *	      B   Z			W   B
+ *	     / \			   / \
+ *	    X   Y			  X   Y
+ */
+static void __cl_map_rot_left(cl_qmap_t * const p_map,
+			      cl_map_item_t * const p_item)
+{
+	cl_map_item_t **pp_root;
+
+	assert(p_map);
+	assert(p_item);
+	assert(p_item->p_right != &p_map->nil);
+
+	pp_root = __cl_map_get_parent_ptr_to_item(p_item);
+
+	/* Point R to C instead of A. */
+	*pp_root = p_item->p_right;
+	/* Set C's parent to R. */
+	(*pp_root)->p_up = p_item->p_up;
+
+	/* Set A's right to B */
+	p_item->p_right = (*pp_root)->p_left;
+	/*
+	 * Set B's parent to A.  We trap for B being NIL since the
+	 * caller may depend on NIL not changing.
+	 */
+	if ((*pp_root)->p_left != &p_map->nil)
+		(*pp_root)->p_left->p_up = p_item;
+
+	/* Set C's left to A. */
+	(*pp_root)->p_left = p_item;
+	/* Set A's parent to C. */
+	p_item->p_up = *pp_root;
+}
+
+/*
+ * Rotate a node to the right.  This rotation affects the least number of links
+ * between nodes and brings the level of A up by one while increasing the depth
+ * of C one.  Note that the links to/from W, X, Y, and Z are not affected.
+ *
+ *	        R				     R
+ *	        |				     |
+ *	        C				     A
+ *	      /   \				   /   \
+ *	    A       Z			 W       C
+ *	   / \    				        / \
+ *	  W   B   				       B   Z
+ *	     / \				      / \
+ *	    X   Y				     X   Y
+ */
+static void __cl_map_rot_right(cl_qmap_t * const p_map,
+			       cl_map_item_t * const p_item)
+{
+	cl_map_item_t **pp_root;
+
+	assert(p_map);
+	assert(p_item);
+	assert(p_item->p_left != &p_map->nil);
+
+	/* Point R to A instead of C. */
+	pp_root = __cl_map_get_parent_ptr_to_item(p_item);
+	(*pp_root) = p_item->p_left;
+	/* Set A's parent to R. */
+	(*pp_root)->p_up = p_item->p_up;
+
+	/* Set C's left to B */
+	p_item->p_left = (*pp_root)->p_right;
+	/*
+	 * Set B's parent to C.  We trap for B being NIL since the
+	 * caller may depend on NIL not changing.
+	 */
+	if ((*pp_root)->p_right != &p_map->nil)
+		(*pp_root)->p_right->p_up = p_item;
+
+	/* Set A's right to C. */
+	(*pp_root)->p_right = p_item;
+	/* Set C's parent to A. */
+	p_item->p_up = *pp_root;
+}
+
+void cl_qmap_init(cl_qmap_t * const p_map)
+{
+	assert(p_map);
+
+	memset(p_map, 0, sizeof(cl_qmap_t));
+
+	/* special setup for the root node */
+	p_map->root.p_up = &p_map->root;
+	p_map->root.p_left = &p_map->nil;
+	p_map->root.p_right = &p_map->nil;
+	p_map->root.color = CL_MAP_BLACK;
+
+	/* Setup the node used as terminator for all leaves. */
+	p_map->nil.p_up = &p_map->nil;
+	p_map->nil.p_left = &p_map->nil;
+	p_map->nil.p_right = &p_map->nil;
+	p_map->nil.color = CL_MAP_BLACK;
+
+	cl_qmap_remove_all(p_map);
+}
+
+cl_map_item_t *cl_qmap_get(const cl_qmap_t * const p_map,
+			   const uint64_t key)
+{
+	cl_map_item_t *p_item;
+
+	assert(p_map);
+
+	p_item = __cl_map_root(p_map);
+
+	while (p_item != &p_map->nil) {
+		if (key == p_item->key)
+			break;	/* just right */
+
+		if (key < p_item->key)
+			p_item = p_item->p_left;	/* too small */
+		else
+			p_item = p_item->p_right;	/* too big */
+	}
+
+	return (p_item);
+}
+
+cl_map_item_t *cl_qmap_get_next(const cl_qmap_t * const p_map,
+				const uint64_t key)
+{
+	cl_map_item_t *p_item;
+	cl_map_item_t *p_item_found;
+
+	assert(p_map);
+
+	p_item = __cl_map_root(p_map);
+	p_item_found = (cl_map_item_t *) & p_map->nil;
+
+	while (p_item != &p_map->nil) {
+		if (key < p_item->key) {
+			p_item_found = p_item;
+			p_item = p_item->p_left;
+		} else {
+			p_item = p_item->p_right;
+		}
+	}
+
+	return (p_item_found);
+}
+
+void cl_qmap_apply_func(const cl_qmap_t * const p_map,
+			cl_pfn_qmap_apply_t pfn_func,
+			const void *const context)
+{
+	cl_map_item_t *p_map_item;
+
+	/* Note that context can have any arbitrary value. */
+	assert(p_map);
+	assert(pfn_func);
+
+	p_map_item = cl_qmap_head(p_map);
+	while (p_map_item != cl_qmap_end(p_map)) {
+		pfn_func(p_map_item, (void *)context);
+		p_map_item = cl_qmap_next(p_map_item);
+	}
+}
+
+/*
+ * Balance a tree starting at a given item back to the root.
+ */
+static void __cl_map_ins_bal(cl_qmap_t * const p_map,
+			     cl_map_item_t * p_item)
+{
+	cl_map_item_t *p_grand_uncle;
+
+	assert(p_map);
+	assert(p_item);
+	assert(p_item != &p_map->root);
+
+	while (p_item->p_up->color == CL_MAP_RED) {
+		if (__cl_map_is_left_child(p_item->p_up)) {
+			p_grand_uncle = p_item->p_up->p_up->p_right;
+			assert(p_grand_uncle);
+			if (p_grand_uncle->color == CL_MAP_RED) {
+				p_grand_uncle->color = CL_MAP_BLACK;
+				p_item->p_up->color = CL_MAP_BLACK;
+				p_item->p_up->p_up->color = CL_MAP_RED;
+				p_item = p_item->p_up->p_up;
+				continue;
+			}
+
+			if (!__cl_map_is_left_child(p_item)) {
+				p_item = p_item->p_up;
+				__cl_map_rot_left(p_map, p_item);
+			}
+			p_item->p_up->color = CL_MAP_BLACK;
+			p_item->p_up->p_up->color = CL_MAP_RED;
+			__cl_map_rot_right(p_map, p_item->p_up->p_up);
+		} else {
+			p_grand_uncle = p_item->p_up->p_up->p_left;
+			assert(p_grand_uncle);
+			if (p_grand_uncle->color == CL_MAP_RED) {
+				p_grand_uncle->color = CL_MAP_BLACK;
+				p_item->p_up->color = CL_MAP_BLACK;
+				p_item->p_up->p_up->color = CL_MAP_RED;
+				p_item = p_item->p_up->p_up;
+				continue;
+			}
+
+			if (__cl_map_is_left_child(p_item)) {
+				p_item = p_item->p_up;
+				__cl_map_rot_right(p_map, p_item);
+			}
+			p_item->p_up->color = CL_MAP_BLACK;
+			p_item->p_up->p_up->color = CL_MAP_RED;
+			__cl_map_rot_left(p_map, p_item->p_up->p_up);
+		}
+	}
+}
+
+cl_map_item_t *cl_qmap_insert(cl_qmap_t * const p_map,
+			      const uint64_t key,
+			      cl_map_item_t * const p_item)
+{
+	cl_map_item_t *p_insert_at, *p_comp_item;
+
+	assert(p_map);
+	assert(p_item);
+	assert(p_map->root.p_up == &p_map->root);
+	assert(p_map->root.color != CL_MAP_RED);
+	assert(p_map->nil.color != CL_MAP_RED);
+
+	p_item->p_left = &p_map->nil;
+	p_item->p_right = &p_map->nil;
+	p_item->key = key;
+	p_item->color = CL_MAP_RED;
+
+	/* Find the insertion location. */
+	p_insert_at = &p_map->root;
+	p_comp_item = __cl_map_root(p_map);
+
+	while (p_comp_item != &p_map->nil) {
+		p_insert_at = p_comp_item;
+
+		if (key == p_insert_at->key)
+			return (p_insert_at);
+
+		/* Traverse the tree until the correct insertion point is found. */
+		if (key < p_insert_at->key)
+			p_comp_item = p_insert_at->p_left;
+		else
+			p_comp_item = p_insert_at->p_right;
+	}
+
+	assert(p_insert_at != &p_map->nil);
+	assert(p_comp_item == &p_map->nil);
+	/* Insert the item. */
+	if (p_insert_at == &p_map->root) {
+		p_insert_at->p_left = p_item;
+		/*
+		 * Primitive insert places the new item in front of
+		 * the existing item.
+		 */
+		__cl_primitive_insert(&p_map->nil.pool_item.list_item,
+				      &p_item->pool_item.list_item);
+	} else if (key < p_insert_at->key) {
+		p_insert_at->p_left = p_item;
+		/*
+		 * Primitive insert places the new item in front of
+		 * the existing item.
+		 */
+		__cl_primitive_insert(&p_insert_at->pool_item.list_item,
+				      &p_item->pool_item.list_item);
+	} else {
+		p_insert_at->p_right = p_item;
+		/*
+		 * Primitive insert places the new item in front of
+		 * the existing item.
+		 */
+		__cl_primitive_insert(p_insert_at->pool_item.list_item.p_next,
+				      &p_item->pool_item.list_item);
+	}
+	/* Increase the count. */
+	p_map->count++;
+
+	p_item->p_up = p_insert_at;
+
+	/*
+	 * We have added depth to this section of the tree.
+	 * Rebalance as necessary as we retrace our path through the tree
+	 * and update colors.
+	 */
+	__cl_map_ins_bal(p_map, p_item);
+
+	__cl_map_root(p_map)->color = CL_MAP_BLACK;
+
+	/*
+	 * Note that it is not necessary to re-color the nil node black because all
+	 * red color assignments are made via the p_up pointer, and nil is never
+	 * set as the value of a p_up pointer.
+	 */
+
+#ifdef _DEBUG_
+	/* Set the pointer to the map in the map item for consistency checking. */
+	p_item->p_map = p_map;
+#endif
+
+	return (p_item);
+}
+
+static void __cl_map_del_bal(cl_qmap_t * const p_map,
+			     cl_map_item_t * p_item)
+{
+	cl_map_item_t *p_uncle;
+
+	while ((p_item->color != CL_MAP_RED) && (p_item->p_up != &p_map->root)) {
+		if (__cl_map_is_left_child(p_item)) {
+			p_uncle = p_item->p_up->p_right;
+
+			if (p_uncle->color == CL_MAP_RED) {
+				p_uncle->color = CL_MAP_BLACK;
+				p_item->p_up->color = CL_MAP_RED;
+				__cl_map_rot_left(p_map, p_item->p_up);
+				p_uncle = p_item->p_up->p_right;
+			}
+
+			if (p_uncle->p_right->color != CL_MAP_RED) {
+				if (p_uncle->p_left->color != CL_MAP_RED) {
+					p_uncle->color = CL_MAP_RED;
+					p_item = p_item->p_up;
+					continue;
+				}
+
+				p_uncle->p_left->color = CL_MAP_BLACK;
+				p_uncle->color = CL_MAP_RED;
+				__cl_map_rot_right(p_map, p_uncle);
+				p_uncle = p_item->p_up->p_right;
+			}
+			p_uncle->color = p_item->p_up->color;
+			p_item->p_up->color = CL_MAP_BLACK;
+			p_uncle->p_right->color = CL_MAP_BLACK;
+			__cl_map_rot_left(p_map, p_item->p_up);
+			break;
+		} else {
+			p_uncle = p_item->p_up->p_left;
+
+			if (p_uncle->color == CL_MAP_RED) {
+				p_uncle->color = CL_MAP_BLACK;
+				p_item->p_up->color = CL_MAP_RED;
+				__cl_map_rot_right(p_map, p_item->p_up);
+				p_uncle = p_item->p_up->p_left;
+			}
+
+			if (p_uncle->p_left->color != CL_MAP_RED) {
+				if (p_uncle->p_right->color != CL_MAP_RED) {
+					p_uncle->color = CL_MAP_RED;
+					p_item = p_item->p_up;
+					continue;
+				}
+
+				p_uncle->p_right->color = CL_MAP_BLACK;
+				p_uncle->color = CL_MAP_RED;
+				__cl_map_rot_left(p_map, p_uncle);
+				p_uncle = p_item->p_up->p_left;
+			}
+			p_uncle->color = p_item->p_up->color;
+			p_item->p_up->color = CL_MAP_BLACK;
+			p_uncle->p_left->color = CL_MAP_BLACK;
+			__cl_map_rot_right(p_map, p_item->p_up);
+			break;
+		}
+	}
+	p_item->color = CL_MAP_BLACK;
+}
+
+void cl_qmap_remove_item(cl_qmap_t * const p_map,
+			 cl_map_item_t * const p_item)
+{
+	cl_map_item_t *p_child, *p_del_item;
+
+	assert(p_map);
+	assert(p_item);
+
+	if (p_item == cl_qmap_end(p_map))
+		return;
+
+	if ((p_item->p_right == &p_map->nil) || (p_item->p_left == &p_map->nil)) {
+		/* The item being removed has children on at most on side. */
+		p_del_item = p_item;
+	} else {
+		/*
+		 * The item being removed has children on both side.
+		 * We select the item that will replace it.  After removing
+		 * the substitute item and rebalancing, the tree will have the
+		 * correct topology.  Exchanging the substitute for the item
+		 * will finalize the removal.
+		 */
+		p_del_item = cl_qmap_next(p_item);
+		assert(p_del_item != &p_map->nil);
+	}
+
+	/* Remove the item from the list. */
+	__cl_primitive_remove(&p_item->pool_item.list_item);
+	/* Decrement the item count. */
+	p_map->count--;
+
+	/* Get the pointer to the new root's child, if any. */
+	if (p_del_item->p_left != &p_map->nil)
+		p_child = p_del_item->p_left;
+	else
+		p_child = p_del_item->p_right;
+
+	/*
+	 * This assignment may modify the parent pointer of the nil node.
+	 * This is inconsequential.
+	 */
+	p_child->p_up = p_del_item->p_up;
+	(*__cl_map_get_parent_ptr_to_item(p_del_item)) = p_child;
+
+	if (p_del_item->color != CL_MAP_RED)
+		__cl_map_del_bal(p_map, p_child);
+
+	/*
+	 * Note that the splicing done below does not need to occur before
+	 * the tree is balanced, since the actual topology changes are made by the
+	 * preceding code.  The topology is preserved by the color assignment made
+	 * below (reader should be reminded that p_del_item == p_item in some cases).
+	 */
+	if (p_del_item != p_item) {
+		/*
+		 * Finalize the removal of the specified item by exchanging it with
+		 * the substitute which we removed above.
+		 */
+		p_del_item->p_up = p_item->p_up;
+		p_del_item->p_left = p_item->p_left;
+		p_del_item->p_right = p_item->p_right;
+		(*__cl_map_get_parent_ptr_to_item(p_item)) = p_del_item;
+		p_item->p_right->p_up = p_del_item;
+		p_item->p_left->p_up = p_del_item;
+		p_del_item->color = p_item->color;
+	}
+
+	assert(p_map->nil.color != CL_MAP_RED);
+
+#ifdef _DEBUG_
+	/* Clear the pointer to the map since the item has been removed. */
+	p_item->p_map = NULL;
+#endif
+}
+
+cl_map_item_t *cl_qmap_remove(cl_qmap_t * const p_map, const uint64_t key)
+{
+	cl_map_item_t *p_item;
+
+	assert(p_map);
+
+	/* Seek the node with the specified key */
+	p_item = cl_qmap_get(p_map, key);
+
+	cl_qmap_remove_item(p_map, p_item);
+
+	return (p_item);
+}
+
+void cl_qmap_merge(cl_qmap_t * const p_dest_map,
+		   cl_qmap_t * const p_src_map)
+{
+	cl_map_item_t *p_item, *p_item2, *p_next;
+
+	assert(p_dest_map);
+	assert(p_src_map);
+
+	p_item = cl_qmap_head(p_src_map);
+
+	while (p_item != cl_qmap_end(p_src_map)) {
+		p_next = cl_qmap_next(p_item);
+
+		/* Remove the item from its current map. */
+		cl_qmap_remove_item(p_src_map, p_item);
+		/* Insert the item into the destination map. */
+		p_item2 =
+		    cl_qmap_insert(p_dest_map, cl_qmap_key(p_item), p_item);
+		/* Check that the item was successfully inserted. */
+		if (p_item2 != p_item) {
+			/* Put the item in back in the source map. */
+			p_item2 =
+			    cl_qmap_insert(p_src_map, cl_qmap_key(p_item),
+					   p_item);
+			assert(p_item2 == p_item);
+		}
+		p_item = p_next;
+	}
+}
+
+static void __cl_qmap_delta_move(cl_qmap_t * const p_dest,
+				 cl_qmap_t * const p_src,
+				 cl_map_item_t ** const pp_item)
+{
+	cl_map_item_t __attribute__((__unused__)) *p_temp;
+	cl_map_item_t *p_next;
+
+	/*
+	 * Get the next item so that we can ensure that pp_item points to
+	 * a valid item upon return from the function.
+	 */
+	p_next = cl_qmap_next(*pp_item);
+	/* Move the old item from its current map the the old map. */
+	cl_qmap_remove_item(p_src, *pp_item);
+	p_temp = cl_qmap_insert(p_dest, cl_qmap_key(*pp_item), *pp_item);
+	/* We should never have duplicates. */
+	assert(p_temp == *pp_item);
+	/* Point pp_item to a valid item in the source map. */
+	(*pp_item) = p_next;
+}
+
+void cl_qmap_delta(cl_qmap_t * const p_map1,
+		   cl_qmap_t * const p_map2,
+		   cl_qmap_t * const p_new, cl_qmap_t * const p_old)
+{
+	cl_map_item_t *p_item1, *p_item2;
+	uint64_t key1, key2;
+
+	assert(p_map1);
+	assert(p_map2);
+	assert(p_new);
+	assert(p_old);
+	assert(cl_is_qmap_empty(p_new));
+	assert(cl_is_qmap_empty(p_old));
+
+	p_item1 = cl_qmap_head(p_map1);
+	p_item2 = cl_qmap_head(p_map2);
+
+	while (p_item1 != cl_qmap_end(p_map1) && p_item2 != cl_qmap_end(p_map2)) {
+		key1 = cl_qmap_key(p_item1);
+		key2 = cl_qmap_key(p_item2);
+		if (key1 < key2) {
+			/* We found an old item. */
+			__cl_qmap_delta_move(p_old, p_map1, &p_item1);
+		} else if (key1 > key2) {
+			/* We found a new item. */
+			__cl_qmap_delta_move(p_new, p_map2, &p_item2);
+		} else {
+			/* Move both forward since they have the same key. */
+			p_item1 = cl_qmap_next(p_item1);
+			p_item2 = cl_qmap_next(p_item2);
+		}
+	}
+
+	/* Process the remainder if the end of either source map was reached. */
+	while (p_item2 != cl_qmap_end(p_map2))
+		__cl_qmap_delta_move(p_new, p_map2, &p_item2);
+
+	while (p_item1 != cl_qmap_end(p_map1))
+		__cl_qmap_delta_move(p_old, p_map1, &p_item1);
+}
diff --git a/util/cl_qmap.h b/util/cl_qmap.h
new file mode 100644
index 00000000000000..1a800f2c8fecd6
--- /dev/null
+++ b/util/cl_qmap.h
@@ -0,0 +1,970 @@
+/*
+ * Copyright (c) 2004, 2005 Voltaire, Inc. All rights reserved.
+ * Copyright (c) 2002-2005 Mellanox Technologies LTD. All rights reserved.
+ * Copyright (c) 1996-2003 Intel Corporation. All rights reserved.
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
+/*
+ * Abstract:
+ *	Declaration of quick map, a binary tree where the caller always provides
+ *	all necessary storage.
+ */
+
+#ifndef _CL_QMAP_H_
+#define _CL_QMAP_H_
+
+#include <stdbool.h>
+#include <assert.h>
+#include <inttypes.h>
+#include <stdio.h>
+
+typedef struct _cl_list_item {
+        struct _cl_list_item *p_next;
+        struct _cl_list_item *p_prev;
+} cl_list_item_t;
+
+typedef struct _cl_pool_item {
+        cl_list_item_t list_item;
+} cl_pool_item_t;
+
+/****h* Component Library/Quick Map
+* NAME
+*	Quick Map
+*
+* DESCRIPTION
+*	Quick map implements a binary tree that stores user provided cl_map_item_t
+*	structures.  Each item stored in a quick map has a unique 64-bit key
+*	(duplicates are not allowed).  Quick map provides the ability to
+*	efficiently search for an item given a key.
+*
+*	Quick map does not allocate any memory, and can therefore not fail
+*	any operations due to insufficient memory.  Quick map can thus be useful
+*	in minimizing the error paths in code.
+*
+*	Quick map is not thread safe, and users must provide serialization when
+*	adding and removing items from the map.
+*
+*	The quick map functions operate on a cl_qmap_t structure which should be
+*	treated as opaque and should be manipulated only through the provided
+*	functions.
+*
+* SEE ALSO
+*	Structures:
+*		cl_qmap_t, cl_map_item_t, cl_map_obj_t
+*
+*	Callbacks:
+*		cl_pfn_qmap_apply_t
+*
+*	Item Manipulation:
+*		cl_qmap_set_obj, cl_qmap_obj, cl_qmap_key
+*
+*	Initialization:
+*		cl_qmap_init
+*
+*	Iteration:
+*		cl_qmap_end, cl_qmap_head, cl_qmap_tail, cl_qmap_next, cl_qmap_prev
+*
+*	Manipulation:
+*		cl_qmap_insert, cl_qmap_get, cl_qmap_remove_item, cl_qmap_remove,
+*		cl_qmap_remove_all, cl_qmap_merge, cl_qmap_delta, cl_qmap_get_next
+*
+*	Search:
+*		cl_qmap_apply_func
+*
+*	Attributes:
+*		cl_qmap_count, cl_is_qmap_empty,
+*********/
+/****i* Component Library: Quick Map/cl_map_color_t
+* NAME
+*	cl_map_color_t
+*
+* DESCRIPTION
+*	The cl_map_color_t enumerated type is used to note the color of
+*	nodes in a map.
+*
+* SYNOPSIS
+*/
+typedef enum _cl_map_color {
+	CL_MAP_RED,
+	CL_MAP_BLACK
+} cl_map_color_t;
+/*
+* VALUES
+*	CL_MAP_RED
+*		The node in the map is red.
+*
+*	CL_MAP_BLACK
+*		The node in the map is black.
+*
+* SEE ALSO
+*	Quick Map, cl_map_item_t
+*********/
+
+/****s* Component Library: Quick Map/cl_map_item_t
+* NAME
+*	cl_map_item_t
+*
+* DESCRIPTION
+*	The cl_map_item_t structure is used by maps to store objects.
+*
+*	The cl_map_item_t structure should be treated as opaque and should
+*	be manipulated only through the provided functions.
+*
+* SYNOPSIS
+*/
+typedef struct _cl_map_item {
+	/* Must be first to allow casting. */
+	cl_pool_item_t pool_item;
+	struct _cl_map_item *p_left;
+	struct _cl_map_item *p_right;
+	struct _cl_map_item *p_up;
+	cl_map_color_t color;
+	uint64_t key;
+#ifdef _DEBUG_
+	struct _cl_qmap *p_map;
+#endif
+} cl_map_item_t;
+/*
+* FIELDS
+*	pool_item
+*		Used to store the item in a doubly linked list, allowing more
+*		efficient map traversal.
+*
+*	p_left
+*		Pointer to the map item that is a child to the left of the node.
+*
+*	p_right
+*		Pointer to the map item that is a child to the right of the node.
+*
+*	p_up
+*		Pointer to the map item that is the parent of the node.
+*
+*	color
+*		Indicates whether a node is red or black in the map.
+*
+*	key
+*		Value that uniquely represents a node in a map.  This value is
+*		set by calling cl_qmap_insert and can be retrieved by calling
+*		cl_qmap_key.
+*
+* NOTES
+*	None of the fields of this structure should be manipulated by users, as
+*	they are crititcal to the proper operation of the map in which they
+*	are stored.
+*
+*	To allow storing items in either a quick list, a quick pool, or a quick
+*	map, the map implementation guarantees that the map item can be safely
+*	cast to a pool item used for storing an object in a quick pool, or cast
+*	to a list item used for storing an object in a quick list.  This removes
+*	the need to embed a map item, a list item, and a pool item in objects
+*	that need to be stored in a quick list, a quick pool, and a quick map.
+*
+* SEE ALSO
+*	Quick Map, cl_qmap_insert, cl_qmap_key, cl_pool_item_t, cl_list_item_t
+*********/
+
+/****s* Component Library: Quick Map/cl_map_obj_t
+* NAME
+*	cl_map_obj_t
+*
+* DESCRIPTION
+*	The cl_map_obj_t structure is used to store objects in maps.
+*
+*	The cl_map_obj_t structure should be treated as opaque and should
+*	be manipulated only through the provided functions.
+*
+* SYNOPSIS
+*/
+typedef struct _cl_map_obj {
+	cl_map_item_t item;
+	const void *p_object;
+} cl_map_obj_t;
+/*
+* FIELDS
+*	item
+*		Map item used by internally by the map to store an object.
+*
+*	p_object
+*		User defined context. Users should not access this field directly.
+*		Use cl_qmap_set_obj and cl_qmap_obj to set and retrieve the value
+*		of this field.
+*
+* NOTES
+*	None of the fields of this structure should be manipulated by users, as
+*	they are crititcal to the proper operation of the map in which they
+*	are stored.
+*
+*	Use cl_qmap_set_obj and cl_qmap_obj to set and retrieve the object
+*	stored in a map item, respectively.
+*
+* SEE ALSO
+*	Quick Map, cl_qmap_set_obj, cl_qmap_obj, cl_map_item_t
+*********/
+
+/****s* Component Library: Quick Map/cl_qmap_t
+* NAME
+*	cl_qmap_t
+*
+* DESCRIPTION
+*	Quick map structure.
+*
+*	The cl_qmap_t structure should be treated as opaque and should
+*	be manipulated only through the provided functions.
+*
+* SYNOPSIS
+*/
+typedef struct _cl_qmap {
+	cl_map_item_t root;
+	cl_map_item_t nil;
+	size_t count;
+} cl_qmap_t;
+/*
+* PARAMETERS
+*	root
+*		Map item that serves as root of the map.  The root is set up to
+*		always have itself as parent.  The left pointer is set to point
+*		to the item at the root.
+*
+*	nil
+*		Map item that serves as terminator for all leaves, as well as
+*		providing the list item used as quick list for storing map items
+*		in a list for faster traversal.
+*
+*	state
+*		State of the map, used to verify that operations are permitted.
+*
+*	count
+*		Number of items in the map.
+*
+* SEE ALSO
+*	Quick Map
+*********/
+
+/****d* Component Library: Quick Map/cl_pfn_qmap_apply_t
+* NAME
+*	cl_pfn_qmap_apply_t
+*
+* DESCRIPTION
+*	The cl_pfn_qmap_apply_t function type defines the prototype for
+*	functions used to iterate items in a quick map.
+*
+* SYNOPSIS
+*/
+typedef void
+ (*cl_pfn_qmap_apply_t) (cl_map_item_t * const p_map_item, void *context);
+/*
+* PARAMETERS
+*	p_map_item
+*		[in] Pointer to a cl_map_item_t structure.
+*
+*	context
+*		[in] Value passed to the callback function.
+*
+* RETURN VALUE
+*	This function does not return a value.
+*
+* NOTES
+*	This function type is provided as function prototype reference for the
+*	function provided by users as a parameter to the cl_qmap_apply_func
+*	function.
+*
+* SEE ALSO
+*	Quick Map, cl_qmap_apply_func
+*********/
+
+/****f* Component Library: Quick Map/cl_qmap_count
+* NAME
+*	cl_qmap_count
+*
+* DESCRIPTION
+*	The cl_qmap_count function returns the number of items stored
+*	in a quick map.
+*
+* SYNOPSIS
+*/
+static inline uint32_t cl_qmap_count(const cl_qmap_t * const p_map)
+{
+	assert(p_map);
+	return ((uint32_t) p_map->count);
+}
+
+/*
+* PARAMETERS
+*	p_map
+*		[in] Pointer to a cl_qmap_t structure whose item count to return.
+*
+* RETURN VALUE
+*	Returns the number of items stored in the map.
+*
+* SEE ALSO
+*	Quick Map, cl_is_qmap_empty
+*********/
+
+/****f* Component Library: Quick Map/cl_is_qmap_empty
+* NAME
+*	cl_is_qmap_empty
+*
+* DESCRIPTION
+*	The cl_is_qmap_empty function returns whether a quick map is empty.
+*
+* SYNOPSIS
+*/
+static inline bool cl_is_qmap_empty(const cl_qmap_t * const p_map)
+{
+	assert(p_map);
+
+	return (p_map->count == 0);
+}
+
+/*
+* PARAMETERS
+*	p_map
+*		[in] Pointer to a cl_qmap_t structure to test for emptiness.
+*
+* RETURN VALUES
+*	TRUE if the quick map is empty.
+*
+*	FALSE otherwise.
+*
+* SEE ALSO
+*	Quick Map, cl_qmap_count, cl_qmap_remove_all
+*********/
+
+/****f* Component Library: Quick Map/cl_qmap_set_obj
+* NAME
+*	cl_qmap_set_obj
+*
+* DESCRIPTION
+*	The cl_qmap_set_obj function sets the object stored in a map object.
+*
+* SYNOPSIS
+*/
+static inline void
+cl_qmap_set_obj(cl_map_obj_t * const p_map_obj,
+		const void *const p_object)
+{
+	assert(p_map_obj);
+	p_map_obj->p_object = p_object;
+}
+
+/*
+* PARAMETERS
+*	p_map_obj
+*		[in] Pointer to a map object stucture whose object pointer
+*		is to be set.
+*
+*	p_object
+*		[in] User defined context.
+*
+* RETURN VALUE
+*	This function does not return a value.
+*
+* SEE ALSO
+*	Quick Map, cl_qmap_obj
+*********/
+
+/****f* Component Library: Quick Map/cl_qmap_obj
+* NAME
+*	cl_qmap_obj
+*
+* DESCRIPTION
+*	The cl_qmap_obj function returns the object stored in a map object.
+*
+* SYNOPSIS
+*/
+static inline void *cl_qmap_obj(const cl_map_obj_t * const p_map_obj)
+{
+	assert(p_map_obj);
+	return ((void *)p_map_obj->p_object);
+}
+
+/*
+* PARAMETERS
+*	p_map_obj
+*		[in] Pointer to a map object stucture whose object pointer to return.
+*
+* RETURN VALUE
+*	Returns the value of the object pointer stored in the map object.
+*
+* SEE ALSO
+*	Quick Map, cl_qmap_set_obj
+*********/
+
+/****f* Component Library: Quick Map/cl_qmap_key
+* NAME
+*	cl_qmap_key
+*
+* DESCRIPTION
+*	The cl_qmap_key function retrieves the key value of a map item.
+*
+* SYNOPSIS
+*/
+static inline uint64_t cl_qmap_key(const cl_map_item_t * const p_item)
+{
+	assert(p_item);
+	return (p_item->key);
+}
+
+/*
+* PARAMETERS
+*	p_item
+*		[in] Pointer to a map item whose key value to return.
+*
+* RETURN VALUE
+*	Returns the 64-bit key value for the specified map item.
+*
+* NOTES
+*	The key value is set in a call to cl_qmap_insert.
+*
+* SEE ALSO
+*	Quick Map, cl_qmap_insert
+*********/
+
+/****f* Component Library: Quick Map/cl_qmap_init
+* NAME
+*	cl_qmap_init
+*
+* DESCRIPTION
+*	The cl_qmap_init function initialized a quick map for use.
+*
+* SYNOPSIS
+*/
+void cl_qmap_init(cl_qmap_t * const p_map);
+/*
+* PARAMETERS
+*	p_map
+*		[in] Pointer to a cl_qmap_t structure to initialize.
+*
+* RETURN VALUES
+*	This function does not return a value.
+*
+* NOTES
+*	Allows calling quick map manipulation functions.
+*
+* SEE ALSO
+*	Quick Map, cl_qmap_insert, cl_qmap_remove
+*********/
+
+/****f* Component Library: Quick Map/cl_qmap_end
+* NAME
+*	cl_qmap_end
+*
+* DESCRIPTION
+*	The cl_qmap_end function returns the end of a quick map.
+*
+* SYNOPSIS
+*/
+static inline const cl_map_item_t *cl_qmap_end(const cl_qmap_t * const p_map)
+{
+	assert(p_map);
+	/* Nil is the end of the map. */
+	return (&p_map->nil);
+}
+
+/*
+* PARAMETERS
+*	p_map
+*		[in] Pointer to a cl_qmap_t structure whose end to return.
+*
+* RETURN VALUE
+*	Pointer to the end of the map.
+*
+* NOTES
+*	cl_qmap_end is useful for determining the validity of map items returned
+*	by cl_qmap_head, cl_qmap_tail, cl_qmap_next, or cl_qmap_prev.  If the
+*	map item pointer returned by any of these functions compares to the end,
+*	the end of the map was encoutered.
+*	When using cl_qmap_head or cl_qmap_tail, this condition indicates that
+*	the map is empty.
+*
+* SEE ALSO
+*	Quick Map, cl_qmap_head, cl_qmap_tail, cl_qmap_next, cl_qmap_prev
+*********/
+
+/****f* Component Library: Quick Map/cl_qmap_head
+* NAME
+*	cl_qmap_head
+*
+* DESCRIPTION
+*	The cl_qmap_head function returns the map item with the lowest key
+*	value stored in a quick map.
+*
+* SYNOPSIS
+*/
+static inline cl_map_item_t *cl_qmap_head(const cl_qmap_t * const p_map)
+{
+	assert(p_map);
+	return ((cl_map_item_t *) p_map->nil.pool_item.list_item.p_next);
+}
+
+/*
+* PARAMETERS
+*	p_map
+*		[in] Pointer to a cl_qmap_t structure whose item with the lowest
+*		key is returned.
+*
+* RETURN VALUES
+*	Pointer to the map item with the lowest key in the quick map.
+*
+*	Pointer to the map end if the quick map was empty.
+*
+* NOTES
+*	cl_qmap_head does not remove the item from the map.
+*
+* SEE ALSO
+*	Quick Map, cl_qmap_tail, cl_qmap_next, cl_qmap_prev, cl_qmap_end,
+*	cl_qmap_item_t
+*********/
+
+/****f* Component Library: Quick Map/cl_qmap_tail
+* NAME
+*	cl_qmap_tail
+*
+* DESCRIPTION
+*	The cl_qmap_tail function returns the map item with the highest key
+*	value stored in a quick map.
+*
+* SYNOPSIS
+*/
+static inline cl_map_item_t *cl_qmap_tail(const cl_qmap_t * const p_map)
+{
+	assert(p_map);
+	return ((cl_map_item_t *) p_map->nil.pool_item.list_item.p_prev);
+}
+
+/*
+* PARAMETERS
+*	p_map
+*		[in] Pointer to a cl_qmap_t structure whose item with the
+*		highest key is returned.
+*
+* RETURN VALUES
+*	Pointer to the map item with the highest key in the quick map.
+*
+*	Pointer to the map end if the quick map was empty.
+*
+* NOTES
+*	cl_qmap_end does not remove the item from the map.
+*
+* SEE ALSO
+*	Quick Map, cl_qmap_head, cl_qmap_next, cl_qmap_prev, cl_qmap_end,
+*	cl_qmap_item_t
+*********/
+
+/****f* Component Library: Quick Map/cl_qmap_next
+* NAME
+*	cl_qmap_next
+*
+* DESCRIPTION
+*	The cl_qmap_next function returns the map item with the next higher
+*	key value than a specified map item.
+*
+* SYNOPSIS
+*/
+static inline cl_map_item_t *cl_qmap_next(const cl_map_item_t * const p_item)
+{
+	assert(p_item);
+	return ((cl_map_item_t *) p_item->pool_item.list_item.p_next);
+}
+
+/*
+* PARAMETERS
+*	p_item
+*		[in] Pointer to a map item whose successor to return.
+*
+* RETURN VALUES
+*	Pointer to the map item with the next higher key value in a quick map.
+*
+*	Pointer to the map end if the specified item was the last item in
+*	the quick map.
+*
+* SEE ALSO
+*	Quick Map, cl_qmap_head, cl_qmap_tail, cl_qmap_prev, cl_qmap_end,
+*	cl_map_item_t
+*********/
+
+/****f* Component Library: Quick Map/cl_qmap_prev
+* NAME
+*	cl_qmap_prev
+*
+* DESCRIPTION
+*	The cl_qmap_prev function returns the map item with the next lower
+*	key value than a precified map item.
+*
+* SYNOPSIS
+*/
+static inline cl_map_item_t *cl_qmap_prev(const cl_map_item_t * const p_item)
+{
+	assert(p_item);
+	return ((cl_map_item_t *) p_item->pool_item.list_item.p_prev);
+}
+
+/*
+* PARAMETERS
+*	p_item
+*		[in] Pointer to a map item whose predecessor to return.
+*
+* RETURN VALUES
+*	Pointer to the map item with the next lower key value in a quick map.
+*
+*	Pointer to the map end if the specifid item was the first item in
+*	the quick map.
+*
+* SEE ALSO
+*	Quick Map, cl_qmap_head, cl_qmap_tail, cl_qmap_next, cl_qmap_end,
+*	cl_map_item_t
+*********/
+
+/****f* Component Library: Quick Map/cl_qmap_insert
+* NAME
+*	cl_qmap_insert
+*
+* DESCRIPTION
+*	The cl_qmap_insert function inserts a map item into a quick map.
+*  NOTE: Only if such a key does not alerady exist in the map !!!!
+*
+* SYNOPSIS
+*/
+cl_map_item_t *cl_qmap_insert(cl_qmap_t * const p_map,
+			      const uint64_t key,
+			      cl_map_item_t * const p_item);
+/*
+* PARAMETERS
+*	p_map
+*		[in] Pointer to a cl_qmap_t structure into which to add the item.
+*
+*	key
+*		[in] Value to assign to the item.
+*
+*	p_item
+*		[in] Pointer to a cl_map_item_t stucture to insert into the quick map.
+*
+* RETURN VALUE
+*	Pointer to the item in the map with the specified key.  If insertion
+*	was successful, this is the pointer to the item.  If an item with the
+*	specified key already exists in the map, the pointer to that item is
+*	returned - but the new key is NOT inserted...
+*
+* NOTES
+*	Insertion operations may cause the quick map to rebalance.
+*
+* SEE ALSO
+*	Quick Map, cl_qmap_remove, cl_map_item_t
+*********/
+
+/****f* Component Library: Quick Map/cl_qmap_get
+* NAME
+*	cl_qmap_get
+*
+* DESCRIPTION
+*	The cl_qmap_get function returns the map item associated with a key.
+*
+* SYNOPSIS
+*/
+cl_map_item_t *cl_qmap_get(const cl_qmap_t * const p_map,
+			   const uint64_t key);
+/*
+* PARAMETERS
+*	p_map
+*		[in] Pointer to a cl_qmap_t structure from which to retrieve the
+*		item with the specified key.
+*
+*	key
+*		[in] Key value used to search for the desired map item.
+*
+* RETURN VALUES
+*	Pointer to the map item with the desired key value.
+*
+*	Pointer to the map end if there was no item with the desired key value
+*	stored in the quick map.
+*
+* NOTES
+*	cl_qmap_get does not remove the item from the quick map.
+*
+* SEE ALSO
+*	Quick Map, cl_qmap_get_next, cl_qmap_remove
+*********/
+
+/****f* Component Library: Quick Map/cl_qmap_get_next
+* NAME
+*	cl_qmap_get_next
+*
+* DESCRIPTION
+*	The cl_qmap_get_next function returns the first map item associated with a
+*	key > the key specified.
+*
+* SYNOPSIS
+*/
+cl_map_item_t *cl_qmap_get_next(const cl_qmap_t * const p_map,
+				const uint64_t key);
+/*
+* PARAMETERS
+*	p_map
+*		[in] Pointer to a cl_qmap_t structure from which to retrieve the
+*		first item with a key > the specified key.
+*
+*	key
+*		[in] Key value used to search for the desired map item.
+*
+* RETURN VALUES
+*	Pointer to the first map item with a key > the desired key value.
+*
+*	Pointer to the map end if there was no item with a key > the desired key
+*	value stored in the quick map.
+*
+* NOTES
+*	cl_qmap_get_next does not remove the item from the quick map.
+*
+* SEE ALSO
+*	Quick Map, cl_qmap_get, cl_qmap_remove
+*********/
+
+/****f* Component Library: Quick Map/cl_qmap_remove_item
+* NAME
+*	cl_qmap_remove_item
+*
+* DESCRIPTION
+*	The cl_qmap_remove_item function removes the specified map item
+*	from a quick map.
+*
+* SYNOPSIS
+*/
+void
+cl_qmap_remove_item(cl_qmap_t * const p_map,
+		    cl_map_item_t * const p_item);
+/*
+* PARAMETERS
+*	p_map
+*		[in] Pointer to a cl_qmap_t structure from which to
+*		remove item.
+*
+*	p_item
+*		[in] Pointer to a map item to remove from its quick map.
+*
+* RETURN VALUES
+*	This function does not return a value.
+*
+*	In a debug build, cl_qmap_remove_item asserts that the item being removed
+*	is in the specified map.
+*
+* NOTES
+*	Removes the map item pointed to by p_item from its quick map.
+*
+* SEE ALSO
+*	Quick Map, cl_qmap_remove, cl_qmap_remove_all, cl_qmap_insert
+*********/
+
+/****f* Component Library: Quick Map/cl_qmap_remove
+* NAME
+*	cl_qmap_remove
+*
+* DESCRIPTION
+*	The cl_qmap_remove function removes the map item with the specified key
+*	from a quick map.
+*
+* SYNOPSIS
+*/
+cl_map_item_t *cl_qmap_remove(cl_qmap_t * const p_map,
+			      const uint64_t key);
+/*
+* PARAMETERS
+*	p_map
+*		[in] Pointer to a cl_qmap_t structure from which to remove the item
+*		with the specified key.
+*
+*	key
+*		[in] Key value used to search for the map item to remove.
+*
+* RETURN VALUES
+*	Pointer to the removed map item if it was found.
+*
+*	Pointer to the map end if no item with the specified key exists in the
+*	quick map.
+*
+* SEE ALSO
+*	Quick Map, cl_qmap_remove_item, cl_qmap_remove_all, cl_qmap_insert
+*********/
+
+/****f* Component Library: Quick Map/cl_qmap_remove_all
+* NAME
+*	cl_qmap_remove_all
+*
+* DESCRIPTION
+*	The cl_qmap_remove_all function removes all items in a quick map,
+*	leaving it empty.
+*
+* SYNOPSIS
+*/
+static inline void cl_qmap_remove_all(cl_qmap_t * const p_map)
+{
+	assert(p_map);
+
+	p_map->root.p_left = &p_map->nil;
+	p_map->nil.pool_item.list_item.p_next = &p_map->nil.pool_item.list_item;
+	p_map->nil.pool_item.list_item.p_prev = &p_map->nil.pool_item.list_item;
+	p_map->count = 0;
+}
+
+/*
+* PARAMETERS
+*	p_map
+*		[in] Pointer to a cl_qmap_t structure to empty.
+*
+* RETURN VALUES
+*	This function does not return a value.
+*
+* SEE ALSO
+*	Quick Map, cl_qmap_remove, cl_qmap_remove_item
+*********/
+
+/****f* Component Library: Quick Map/cl_qmap_merge
+* NAME
+*	cl_qmap_merge
+*
+* DESCRIPTION
+*	The cl_qmap_merge function moves all items from one map to another,
+*	excluding duplicates.
+*
+* SYNOPSIS
+*/
+void
+cl_qmap_merge(cl_qmap_t * const p_dest_map,
+	      cl_qmap_t * const p_src_map);
+/*
+* PARAMETERS
+*	p_dest_map
+*		[out] Pointer to a cl_qmap_t structure to which items should be added.
+*
+*	p_src_map
+*		[in/out] Pointer to a cl_qmap_t structure whose items to add
+*		to p_dest_map.
+*
+* RETURN VALUES
+*	This function does not return a value.
+*
+* NOTES
+*	Items are evaluated based on their keys only.
+*
+*	Upon return from cl_qmap_merge, the quick map referenced by p_src_map
+*	contains all duplicate items.
+*
+* SEE ALSO
+*	Quick Map, cl_qmap_delta
+*********/
+
+/****f* Component Library: Quick Map/cl_qmap_delta
+* NAME
+*	cl_qmap_delta
+*
+* DESCRIPTION
+*	The cl_qmap_delta function computes the differences between two maps.
+*
+* SYNOPSIS
+*/
+void
+cl_qmap_delta(cl_qmap_t * const p_map1,
+	      cl_qmap_t * const p_map2,
+	      cl_qmap_t * const p_new, cl_qmap_t * const p_old);
+/*
+* PARAMETERS
+*	p_map1
+*		[in/out] Pointer to the first of two cl_qmap_t structures whose
+*		differences to compute.
+*
+*	p_map2
+*		[in/out] Pointer to the second of two cl_qmap_t structures whose
+*		differences to compute.
+*
+*	p_new
+*		[out] Pointer to an empty cl_qmap_t structure that contains the
+*		items unique to p_map2 upon return from the function.
+*
+*	p_old
+*		[out] Pointer to an empty cl_qmap_t structure that contains the
+*		items unique to p_map1 upon return from the function.
+*
+* RETURN VALUES
+*	This function does not return a value.
+*
+* NOTES
+*	Items are evaluated based on their keys.  Items that exist in both
+*	p_map1 and p_map2 remain in their respective maps.  Items that
+*	exist only p_map1 are moved to p_old.  Likewise, items that exist only
+*	in p_map2 are moved to p_new.  This function can be useful in evaluating
+*	changes between two maps.
+*
+*	Both maps pointed to by p_new and p_old must be empty on input.  This
+*	requirement removes the possibility of failures.
+*
+* SEE ALSO
+*	Quick Map, cl_qmap_merge
+*********/
+
+/****f* Component Library: Quick Map/cl_qmap_apply_func
+* NAME
+*	cl_qmap_apply_func
+*
+* DESCRIPTION
+*	The cl_qmap_apply_func function executes a specified function
+*	for every item stored in a quick map.
+*
+* SYNOPSIS
+*/
+void
+cl_qmap_apply_func(const cl_qmap_t * const p_map,
+		   cl_pfn_qmap_apply_t pfn_func,
+		   const void *const context);
+/*
+* PARAMETERS
+*	p_map
+*		[in] Pointer to a cl_qmap_t structure.
+*
+*	pfn_func
+*		[in] Function invoked for every item in the quick map.
+*		See the cl_pfn_qmap_apply_t function type declaration for
+*		details about the callback function.
+*
+*	context
+*		[in] Value to pass to the callback functions to provide context.
+*
+* RETURN VALUE
+*	This function does not return a value.
+*
+* NOTES
+*	The function provided must not perform any map operations, as these
+*	would corrupt the quick map.
+*
+* SEE ALSO
+*	Quick Map, cl_pfn_qmap_apply_t
+*********/
+
+#endif				/* _CL_QMAP_H_ */
-- 
2.21.0

