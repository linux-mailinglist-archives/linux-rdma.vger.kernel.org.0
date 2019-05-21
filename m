Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE0DC257F4
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2019 21:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbfEUTBe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 May 2019 15:01:34 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43894 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729300AbfEUTBd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 May 2019 15:01:33 -0400
Received: by mail-qt1-f194.google.com with SMTP id i26so21758349qtr.10
        for <linux-rdma@vger.kernel.org>; Tue, 21 May 2019 12:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yRrcFGEbyx+hPo0HsL1IPBzWkHMm2ChjPx2mXLFfbus=;
        b=Hq1qiXoyKJ+PSsiivsR41/h3O64FbvRv2aON2cvgSwvi5MZxtVGs5FtzZqRzaHJrhh
         KfIQUpBbBZgE5t9m1/kayAne6Nh8PQ36h4rsyDGy2LEGq9YsQ+P/h71FNq54P6k0UT/D
         DzVN+NQYXdT9ZpDPyefEnoTPAuDyIy8GJ39whPztPmNasi3/fxVCZqeN4jzv5zKuxOe5
         sbPzHX3Kl2E0kfxuh0nkWhl3qDEMievBgrgR3b7rHFqFkS5NR5K3TKEdkEYyHe7ewOvx
         BRv/9OzKMRVbrE0Ds1GeKVVwi/ayhrFD18+/V6u1sc7yXCqQKgQq933F1F8Bpb49iXbT
         xXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yRrcFGEbyx+hPo0HsL1IPBzWkHMm2ChjPx2mXLFfbus=;
        b=RMkot6a9qBBA7kOQ1f6zRhlgrviDREK1nQGOVXLFLxgNOnVkTaDOAqxgS65zrNtb+4
         m24sBh28cQvFCxfS0HXzPgIV6s2P0VzV88ia9WcAVAfBSof4HBX5XGfcB4fi/V6Av6D/
         8gExgr5Yo7NV8n/mmv8s+WqiOSulekASYfILQQXbMaU01kIR2nmTkI/E7WxFxfZwy+Lw
         +6h89boJwrYJzViogKXGJrkbICeSP2is+yW88yNJLLi1siR6WmfQl81H4sbdigIVS0ib
         kfqCCM/aPdV5xQUBL1/nshS71xCzATkYjP9TVO3WJNqDros/9FAAPlkdLMKmuR3Kxwxh
         tYIg==
X-Gm-Message-State: APjAAAX3LfipEgNv885G4vZHMNgHPryvTBp6GfmZF9uV56ajoigdiTNZ
        I8B0w/P6gNsl/Ey4I2d7z+0A3bfv200=
X-Google-Smtp-Source: APXvYqyXNhi+cr/HacNOhdstAsKIOXLYWa4eRaT0/RrJT44QF3r7Earq7K9LIt0hbO+iHnsf4ImKQA==
X-Received: by 2002:a0c:fccc:: with SMTP id i12mr65183454qvq.12.1558465292251;
        Tue, 21 May 2019 12:01:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id t2sm10524417qkd.57.2019.05.21.12.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 12:01:29 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTA0u-0007D2-4o; Tue, 21 May 2019 16:01:28 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 4/7] build: Support glibc 2.27 with sparse
Date:   Tue, 21 May 2019 16:01:21 -0300
Message-Id: <20190521190124.27486-5-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521190124.27486-1-jgg@ziepe.ca>
References: <20190521190124.27486-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

A few more things need patching to make sparse be warning free in glibc
headers.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 buildlib/gen-sparse.py                        |   4 +-
 .../sparse-include/27/bits-sysmacros.h.diff   |  24 ++++
 buildlib/sparse-include/27/netinet-in.h.diff  | 121 ++++++++++++++++++
 buildlib/sparse-include/27/stdlib.h.diff      |  23 ++++
 buildlib/sparse-include/27/sys-socket.h.diff  |  11 ++
 5 files changed, 182 insertions(+), 1 deletion(-)
 create mode 100644 buildlib/sparse-include/27/bits-sysmacros.h.diff
 create mode 100644 buildlib/sparse-include/27/netinet-in.h.diff
 create mode 100644 buildlib/sparse-include/27/stdlib.h.diff
 create mode 100644 buildlib/sparse-include/27/sys-socket.h.diff

diff --git a/buildlib/gen-sparse.py b/buildlib/gen-sparse.py
index 84781f4528feef..67e64de3202331 100755
--- a/buildlib/gen-sparse.py
+++ b/buildlib/gen-sparse.py
@@ -7,11 +7,13 @@ import os
 import collections
 
 headers = {
+    "bits/sysmacros.h",
     "endian.h",
     "netinet/in.h",
     "pthread.h",
-    "sys/socket.h",
     "stdatomic.h",
+    "stdlib.h",
+    "sys/socket.h",
     };
 
 def norm_header(fn):
diff --git a/buildlib/sparse-include/27/bits-sysmacros.h.diff b/buildlib/sparse-include/27/bits-sysmacros.h.diff
new file mode 100644
index 00000000000000..4ec58646f621af
--- /dev/null
+++ b/buildlib/sparse-include/27/bits-sysmacros.h.diff
@@ -0,0 +1,24 @@
+--- /usr/include/bits/sysmacros.h	2018-04-16 20:14:20.000000000 +0000
++++ include/bits/sysmacros.h	2019-05-16 19:30:02.096174695 +0000
+@@ -40,8 +40,8 @@
+   __SYSMACROS_DECLARE_MAJOR (DECL_TEMPL)			\
+   {								\
+     unsigned int __major;					\
+-    __major  = ((__dev & (__dev_t) 0x00000000000fff00u) >>  8); \
+-    __major |= ((__dev & (__dev_t) 0xfffff00000000000u) >> 32); \
++    __major  = ((__dev & (__dev_t) 0x00000000000fff00ul) >>  8); \
++    __major |= ((__dev & (__dev_t) 0xfffff00000000000ul) >> 32); \
+     return __major;						\
+   }
+ 
+@@ -52,8 +52,8 @@
+   __SYSMACROS_DECLARE_MINOR (DECL_TEMPL)			\
+   {								\
+     unsigned int __minor;					\
+-    __minor  = ((__dev & (__dev_t) 0x00000000000000ffu) >>  0); \
+-    __minor |= ((__dev & (__dev_t) 0x00000ffffff00000u) >> 12); \
++    __minor  = ((__dev & (__dev_t) 0x00000000000000fful) >>  0); \
++    __minor |= ((__dev & (__dev_t) 0x00000ffffff00000ul) >> 12); \
+     return __minor;						\
+   }
+ 
diff --git a/buildlib/sparse-include/27/netinet-in.h.diff b/buildlib/sparse-include/27/netinet-in.h.diff
new file mode 100644
index 00000000000000..685f23fea71aef
--- /dev/null
+++ b/buildlib/sparse-include/27/netinet-in.h.diff
@@ -0,0 +1,121 @@
+--- /usr/include/netinet/in.h	2018-04-16 20:14:20.000000000 +0000
++++ include/netinet/in.h	2019-05-16 19:22:42.725853784 +0000
+@@ -22,12 +22,12 @@
+ #include <bits/stdint-uintn.h>
+ #include <sys/socket.h>
+ #include <bits/types.h>
+-
++#include <linux/types.h>
+ 
+ __BEGIN_DECLS
+ 
+ /* Internet address.  */
+-typedef uint32_t in_addr_t;
++typedef __be32 in_addr_t;
+ struct in_addr
+   {
+     in_addr_t s_addr;
+@@ -116,7 +116,7 @@
+ #endif /* !__USE_KERNEL_IPV6_DEFS */
+ 
+ /* Type to represent a port.  */
+-typedef uint16_t in_port_t;
++typedef __be16 in_port_t;
+ 
+ /* Standard well-known ports.  */
+ enum
+@@ -175,36 +175,36 @@
+ #define	IN_CLASSB_HOST		(0xffffffff & ~IN_CLASSB_NET)
+ #define	IN_CLASSB_MAX		65536
+ 
+-#define	IN_CLASSC(a)		((((in_addr_t)(a)) & 0xe0000000) == 0xc0000000)
++#define	IN_CLASSC(a)		((((uint32_t)(a)) & 0xe0000000) == 0xc0000000)
+ #define	IN_CLASSC_NET		0xffffff00
+ #define	IN_CLASSC_NSHIFT	8
+ #define	IN_CLASSC_HOST		(0xffffffff & ~IN_CLASSC_NET)
+ 
+-#define	IN_CLASSD(a)		((((in_addr_t)(a)) & 0xf0000000) == 0xe0000000)
++#define	IN_CLASSD(a)		((((uint32_t)(a)) & 0xf0000000) == 0xe0000000)
+ #define	IN_MULTICAST(a)		IN_CLASSD(a)
+ 
+-#define	IN_EXPERIMENTAL(a)	((((in_addr_t)(a)) & 0xe0000000) == 0xe0000000)
+-#define	IN_BADCLASS(a)		((((in_addr_t)(a)) & 0xf0000000) == 0xf0000000)
++#define	IN_EXPERIMENTAL(a)	((((uint32_t)(a)) & 0xe0000000) == 0xe0000000)
++#define	IN_BADCLASS(a)		((((uint32_t)(a)) & 0xf0000000) == 0xf0000000)
+ 
+ /* Address to accept any incoming messages.  */
+-#define	INADDR_ANY		((in_addr_t) 0x00000000)
++#define	INADDR_ANY		((uint32_t) 0x00000000)
+ /* Address to send to all hosts.  */
+-#define	INADDR_BROADCAST	((in_addr_t) 0xffffffff)
++#define	INADDR_BROADCAST	((uint32_t) 0xffffffff)
+ /* Address indicating an error return.  */
+-#define	INADDR_NONE		((in_addr_t) 0xffffffff)
++#define	INADDR_NONE		((uint32_t) 0xffffffff)
+ 
+ /* Network number for local host loopback.  */
+ #define	IN_LOOPBACKNET		127
+ /* Address to loopback in software to local host.  */
+ #ifndef INADDR_LOOPBACK
+-# define INADDR_LOOPBACK	((in_addr_t) 0x7f000001) /* Inet 127.0.0.1.  */
++# define INADDR_LOOPBACK	((uint32_t) 0x7f000001) /* Inet 127.0.0.1.  */
+ #endif
+ 
+ /* Defines for Multicast INADDR.  */
+-#define INADDR_UNSPEC_GROUP	((in_addr_t) 0xe0000000) /* 224.0.0.0 */
+-#define INADDR_ALLHOSTS_GROUP	((in_addr_t) 0xe0000001) /* 224.0.0.1 */
+-#define INADDR_ALLRTRS_GROUP    ((in_addr_t) 0xe0000002) /* 224.0.0.2 */
+-#define INADDR_MAX_LOCAL_GROUP  ((in_addr_t) 0xe00000ff) /* 224.0.0.255 */
++#define INADDR_UNSPEC_GROUP	((uint32_t) 0xe0000000) /* 224.0.0.0 */
++#define INADDR_ALLHOSTS_GROUP	((uint32_t) 0xe0000001) /* 224.0.0.1 */
++#define INADDR_ALLRTRS_GROUP    ((uint32_t) 0xe0000002) /* 224.0.0.2 */
++#define INADDR_MAX_LOCAL_GROUP  ((uint32_t) 0xe00000ff) /* 224.0.0.255 */
+ 
+ #if !__USE_KERNEL_IPV6_DEFS
+ /* IPv6 address */
+@@ -213,8 +213,8 @@
+     union
+       {
+ 	uint8_t	__u6_addr8[16];
+-	uint16_t __u6_addr16[8];
+-	uint32_t __u6_addr32[4];
++	__be16 __u6_addr16[8];
++	__be32 __u6_addr32[4];
+       } __in6_u;
+ #define s6_addr			__in6_u.__u6_addr8
+ #ifdef __USE_MISC
+@@ -253,7 +253,7 @@
+   {
+     __SOCKADDR_COMMON (sin6_);
+     in_port_t sin6_port;	/* Transport layer port # */
+-    uint32_t sin6_flowinfo;	/* IPv6 flow information */
++    __be32 sin6_flowinfo;	/* IPv6 flow information */
+     struct in6_addr sin6_addr;	/* IPv6 address */
+     uint32_t sin6_scope_id;	/* IPv6 scope-id */
+   };
+@@ -371,12 +371,12 @@
+    this was a short-sighted decision since on different systems the types
+    may have different representations but the values are always the same.  */
+ 
+-extern uint32_t ntohl (uint32_t __netlong) __THROW __attribute__ ((__const__));
+-extern uint16_t ntohs (uint16_t __netshort)
++extern uint32_t ntohl (__be32 __netlong) __THROW __attribute__ ((__const__));
++extern uint16_t ntohs (__be16 __netshort)
+      __THROW __attribute__ ((__const__));
+-extern uint32_t htonl (uint32_t __hostlong)
++extern __be32 htonl (uint32_t __hostlong)
+      __THROW __attribute__ ((__const__));
+-extern uint16_t htons (uint16_t __hostshort)
++extern __be16 htons (uint16_t __hostshort)
+      __THROW __attribute__ ((__const__));
+ 
+ #include <endian.h>
+@@ -385,7 +385,7 @@
+ #include <bits/byteswap.h>
+ #include <bits/uintn-identity.h>
+ 
+-#ifdef __OPTIMIZE__
++#ifdef __disabled_OPTIMIZE__
+ /* We can optimize calls to the conversion functions.  Either nothing has
+    to be done or we are using directly the byte-swapping functions which
+    often can be inlined.  */
diff --git a/buildlib/sparse-include/27/stdlib.h.diff b/buildlib/sparse-include/27/stdlib.h.diff
new file mode 100644
index 00000000000000..5ddced15cf71db
--- /dev/null
+++ b/buildlib/sparse-include/27/stdlib.h.diff
@@ -0,0 +1,23 @@
+--- /usr/include/stdlib.h	2018-04-16 20:14:20.000000000 +0000
++++ include/stdlib.h	2019-05-16 19:38:38.071615242 +0000
+@@ -130,6 +130,20 @@
+ 
+ /* Likewise for '_FloatN' and '_FloatNx'.  */
+ 
++/* For whatever reason our sparse does not understand these new compiler types */
++#undef __GLIBC_USE_IEC_60559_TYPES_EXT
++#define __GLIBC_USE_IEC_60559_TYPES_EXT 0
++#undef __HAVE_FLOAT32
++#define __HAVE_FLOAT32 0
++#undef __HAVE_FLOAT32X
++#define __HAVE_FLOAT32X 0
++#undef __HAVE_FLOAT64
++#define __HAVE_FLOAT64 0
++#undef __HAVE_FLOAT64X
++#define __HAVE_FLOAT64X 0
++#undef __HAVE_FLOAT128
++#define __HAVE_FLOAT128 0
++
+ #if __HAVE_FLOAT16 && __GLIBC_USE (IEC_60559_TYPES_EXT)
+ extern _Float16 strtof16 (const char *__restrict __nptr,
+ 			  char **__restrict __endptr)
diff --git a/buildlib/sparse-include/27/sys-socket.h.diff b/buildlib/sparse-include/27/sys-socket.h.diff
new file mode 100644
index 00000000000000..92ee3bfa1e1b64
--- /dev/null
+++ b/buildlib/sparse-include/27/sys-socket.h.diff
@@ -0,0 +1,11 @@
+--- /usr/include/sys/socket.h	2018-04-16 20:14:20.000000000 +0000
++++ include/sys/socket.h	2019-05-16 19:22:42.721853727 +0000
+@@ -54,7 +54,7 @@
+    uses with any of the listed types to be allowed without complaint.
+    G++ 2.7 does not support transparent unions so there we want the
+    old-style declaration, too.  */
+-#if defined __cplusplus || !__GNUC_PREREQ (2, 7) || !defined __USE_GNU
++#if 1
+ # define __SOCKADDR_ARG		struct sockaddr *__restrict
+ # define __CONST_SOCKADDR_ARG	const struct sockaddr *
+ #else
-- 
2.21.0

