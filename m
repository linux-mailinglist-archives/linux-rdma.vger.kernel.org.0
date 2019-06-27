Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3720E58501
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2019 16:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfF0O6e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jun 2019 10:58:34 -0400
Received: from dynamic-37-142-13-130.hotnet.net.il ([37.142.13.130]:28250 "EHLO
        git-send-mailer.rdmz.labs.mlnx" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726370AbfF0O6e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Jun 2019 10:58:34 -0400
X-Greylist: delayed 538 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Jun 2019 10:58:34 EDT
From:   Ali Alnubani <alialnu@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     sean.hefty@intel.com
Subject: [PATCH] rsockets: fix variable initialization
Date:   Thu, 27 Jun 2019 17:49:18 +0300
Message-Id: <20190627144918.4453-1-alialnu@mellanox.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is to fix the error:
  ```
  [117/380] Building C object librdmacm/CMakeFiles/rdmacm.dir/rsocket.c.o
  FAILED: librdmacm/CMakeFiles/rdmacm.dir/rsocket.c.o
  /usr/bin/cc  -D_FILE_OFFSET_BITS=64 -Drdmacm_EXPORTS -Werror -m32
  -std=gnu11 -Wall -Wextra -Wno-sign-compare -Wno-unused-parameter
  -Wmissing-prototypes -Wmissing-declarations -Wwrite-strings -Wformat=2
  -Wformat-nonliteral -Wredundant-decls -Wnested-externs -Wshadow
  -Wno-missing-field-initializers -Wstrict-prototypes
  -Wold-style-definition -Wredundant-decls -O2 -g  -fPIC -Iinclude -MMD
  -MT librdmacm/CMakeFiles/rdmacm.dir/rsocket.c.o -MF
  "librdmacm/CMakeFiles/rdmacm.dir/rsocket.c.o.d" -o
  librdmacm/CMakeFiles/rdmacm.dir/rsocket.c.o   -c ../librdmacm/rsocket.c
  ../librdmacm/rsocket.c: In function ‘rs_get_comp’:
  ../librdmacm/rsocket.c:2148:15: error: ‘start_time’ may be used
  uninitialized in this function [-Werror=maybe-uninitialized]
     poll_time = (uint32_t) (rs_time_us() - start_time);
                 ^
  ../librdmacm/rsocket.c: In function ‘ds_get_comp’:
  ../librdmacm/rsocket.c:2307:15: error: ‘start_time’ may be used
  uninitialized in this function [-Werror=maybe-uninitialized]
     poll_time = (uint32_t) (rs_time_us() - start_time);
                 ^
  ../librdmacm/rsocket.c: In function ‘rpoll’:
  ../librdmacm/rsocket.c:3321:15: error: ‘start_time’ may be used
  uninitialized in this function [-Werror=maybe-uninitialized]
     poll_time = (uint32_t) (rs_time_us() - start_time);
                 ^
  cc1: all warnings being treated as errors
  [122/380] Building C object providers/efa/CMakeFiles/efa.dir/verbs.c.o
  ninja: build stopped: subcommand failed.
  ```
Which reproduces on RHEL7.5 with 4.8.5 20150623 (Red Hat 4.8.5-28)
and 32-bit libraries.

Build steps to reproduce:
  ```
  mkdir build32 && cd build32 && CFLAGS="-Werror -m32" cmake -GNinja \
  -DENABLE_RESOLVE_NEIGH=0 -DIOCTL_MODE=both -DNO_PYVERBS=1 && \
  ninja-build
  ```

meson version: 0.47.2
ninja-build version: 1.7.2

Fixes: 38c49232b67a ("rsockets: Replace gettimeofday with clock_gettime")
Cc: sean.hefty@intel.com

Signed-off-by: Ali Alnubani <alialnu@mellanox.com>
---
 librdmacm/rsocket.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/librdmacm/rsocket.c b/librdmacm/rsocket.c
index 58de2856..aa912c1a 100644
--- a/librdmacm/rsocket.c
+++ b/librdmacm/rsocket.c
@@ -2133,7 +2133,7 @@ static int rs_process_cq(struct rsocket *rs, int nonblock, int (*test)(struct rs
 
 static int rs_get_comp(struct rsocket *rs, int nonblock, int (*test)(struct rsocket *rs))
 {
-	uint64_t start_time;
+	uint64_t start_time = 0;
 	uint32_t poll_time = 0;
 	int ret;
 
@@ -2292,7 +2292,7 @@ static int ds_process_cqs(struct rsocket *rs, int nonblock, int (*test)(struct r
 
 static int ds_get_comp(struct rsocket *rs, int nonblock, int (*test)(struct rsocket *rs))
 {
-	uint64_t start_time;
+	uint64_t start_time = 0;
 	uint32_t poll_time = 0;
 	int ret;
 
@@ -3306,7 +3306,7 @@ static int rs_poll_events(struct pollfd *rfds, struct pollfd *fds, nfds_t nfds)
 int rpoll(struct pollfd *fds, nfds_t nfds, int timeout)
 {
 	struct pollfd *rfds;
-	uint64_t start_time;
+	uint64_t start_time = 0;
 	uint32_t poll_time = 0;
 	int pollsleep, ret;
 
-- 
2.22.0

