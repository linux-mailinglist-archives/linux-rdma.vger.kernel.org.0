Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D16ED89299
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Aug 2019 18:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbfHKQ3f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 11 Aug 2019 12:29:35 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:41712 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725848AbfHKQ3e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 11 Aug 2019 12:29:34 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from haimbo@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 11 Aug 2019 19:29:27 +0300
Received: from r-ufm115.mtr.labs.mlnx (r-ufm115.mtr.labs.mlnx [10.209.36.210])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x7BGTR0b008098;
        Sun, 11 Aug 2019 19:29:27 +0300
Received: from r-ufm115.mtr.labs.mlnx (localhost [127.0.0.1])
        by r-ufm115.mtr.labs.mlnx (8.14.7/8.14.7) with ESMTP id x7BGTRi1020239;
        Sun, 11 Aug 2019 16:29:27 GMT
Received: (from haimbo@localhost)
        by r-ufm115.mtr.labs.mlnx (8.14.7/8.14.7/Submit) id x7BGTRHs020238;
        Sun, 11 Aug 2019 16:29:27 GMT
From:   Haim Boozaglo <haimbo@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     Vladimir Koushnir <vladimirk@mellanox.com>,
        Haim Boozaglo <haimbo@mellanox.com>
Subject: [PATCH 1/3] libibumad: Support arbitrary number of IB devices
Date:   Sun, 11 Aug 2019 16:29:20 +0000
Message-Id: <1565540962-20188-2-git-send-email-haimbo@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1565540962-20188-1-git-send-email-haimbo@mellanox.com>
References: <1565540962-20188-1-git-send-email-haimbo@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Vladimir Koushnir <vladimirk@mellanox.com>

Added new function returning a list of available InfiniBand device names.
The returned list is not limited to 32 devices.

Signed-off-by: Vladimir Koushnir <vladimirk@mellanox.com>
Signed-off-by: Haim Boozaglo <haimbo@mellanox.com>
---
 debian/libibumad3.symbols             |  2 ++
 libibumad/CMakeLists.txt              |  2 +-
 libibumad/libibumad.map               |  6 +++++
 libibumad/man/umad_free_ca_namelist.3 | 28 ++++++++++++++++++++++++
 libibumad/man/umad_get_ca_namelist.3  | 34 +++++++++++++++++++++++++++++
 libibumad/umad.c                      | 41 +++++++++++++++++++++++++++++++++++
 libibumad/umad.h                      |  2 ++
 7 files changed, 114 insertions(+), 1 deletion(-)
 create mode 100644 libibumad/man/umad_free_ca_namelist.3
 create mode 100644 libibumad/man/umad_get_ca_namelist.3

diff --git a/debian/libibumad3.symbols b/debian/libibumad3.symbols
index 31a749f..d4b9bde 100644
--- a/debian/libibumad3.symbols
+++ b/debian/libibumad3.symbols
@@ -9,7 +9,9 @@ libibumad.so.3 libibumad3 #MINVER#
  umad_debug@IBUMAD_1.0 1.3.9
  umad_done@IBUMAD_1.0 1.3.9
  umad_dump@IBUMAD_1.0 1.3.9
+ umad_free_ca_namelist@IBUMAD_1.1 3.1.26
  umad_get_ca@IBUMAD_1.0 1.3.9
+ umad_get_ca_namelist@IBUMAD_1.1 3.1.26
  umad_get_ca_portguids@IBUMAD_1.0 1.3.9
  umad_get_cas_names@IBUMAD_1.0 1.3.9
  umad_get_fd@IBUMAD_1.0 1.3.9
diff --git a/libibumad/CMakeLists.txt b/libibumad/CMakeLists.txt
index 1f600a0..9d0a425 100644
--- a/libibumad/CMakeLists.txt
+++ b/libibumad/CMakeLists.txt
@@ -10,7 +10,7 @@ publish_headers(infiniband
 
 rdma_library(ibumad libibumad.map
   # See Documentation/versioning.md
-  3 3.0.${PACKAGE_VERSION}
+  3 3.1.${PACKAGE_VERSION}
   sysfs.c
   umad.c
   umad_str.c
diff --git a/libibumad/libibumad.map b/libibumad/libibumad.map
index 8bf474e..1f66cc3 100644
--- a/libibumad/libibumad.map
+++ b/libibumad/libibumad.map
@@ -39,3 +39,9 @@ IBUMAD_1.0 {
 		umad_attribute_str;
 	local: *;
 };
+
+IBUMAD_1.1 {
+	global:
+		umad_free_ca_namelist;
+		umad_get_ca_namelist;
+} IBUMAD_1.0;
diff --git a/libibumad/man/umad_free_ca_namelist.3 b/libibumad/man/umad_free_ca_namelist.3
new file mode 100644
index 0000000..f15958b
--- /dev/null
+++ b/libibumad/man/umad_free_ca_namelist.3
@@ -0,0 +1,28 @@
+.\" -*- nroff -*-
+.\"
+.TH UMAD_FREE_CA_NAMELIST 3  "May 1, 2018" "OpenIB" "OpenIB Programmer\'s Manual"
+.SH "NAME"
+umad_free_ca_namelist \- free InfiniBand devices name list
+.SH "SYNOPSIS"
+.nf
+.B #include <infiniband/umad.h>
+.sp
+.BI "void umad_free_ca_namelist(char " "*cas" );
+.fi
+.SH "DESCRIPTION"
+.B umad_get_free_namelist()
+frees the InfiniBand devices name list previously allocated with
+.B umad_get_ca_namelist()\fR.
+The argument
+.I cas
+is a character array of InfiniBand devices names
+.SH "RETURN VALUE"
+.B umad_free_ca_namelist()
+returns no value.
+.SH "SEE ALSO"
+.BR umad_get_ca_namelist(3)
+.SH "AUTHORS"
+.TP
+Vladimir Koushnir <vladimirk@mellanox.com>
+.TP
+Hal Rosenstock <hal@mellanox.com>
diff --git a/libibumad/man/umad_get_ca_namelist.3 b/libibumad/man/umad_get_ca_namelist.3
new file mode 100644
index 0000000..5b30209
--- /dev/null
+++ b/libibumad/man/umad_get_ca_namelist.3
@@ -0,0 +1,34 @@
+.\" -*- nroff -*-
+.\"
+.TH UMAD_GET_CA_NAMELIST 3  "May 1, 2018" "OpenIB" "OpenIB Programmer\'s Manual"
+.SH "NAME"
+umad_get_ca_namelist \- get list of available InfiniBand device names
+.SH "SYNOPSIS"
+.nf
+.B #include <infiniband/umad.h>
+.sp
+.BI "int umad_get_ca_namelist(char " "**cas" );
+.fi
+.SH "DESCRIPTION"
+.B umad_get_ca_namelist()
+fills the
+.I cas
+array with arbitrary number of local IB devices (CAs) names.
+The argument
+.I cas
+is a character array that will be allocated by the function to include number of entries, each with
+.B UMAD_CA_NAME_LEN
+characters.
+.SH "RETURN VALUE"
+.B umad_get_ca_namelist()
+returns a non-negative value equal to the number of entries filled,
+or \-1 on errors.
+.SH "SEE ALSO"
+.BR umad_get_ca_portguids (3),
+.BR umad_open_port (3)
+.BR umad_free_ca_namelist(3)
+.SH "AUTHORS"
+.TP
+Vladimir Koushnir <vladimirk@mellanox.com>
+.TP
+Hal Rosenstock <hal@mellanox.com>
diff --git a/libibumad/umad.c b/libibumad/umad.c
index 5f8656e..9d0303b 100644
--- a/libibumad/umad.c
+++ b/libibumad/umad.c
@@ -1123,3 +1123,44 @@ void umad_dump(void *umad)
 	       mad->agent_id, mad->status, mad->timeout_ms);
 	umad_addr_dump(&mad->addr);
 }
+
+int umad_get_ca_namelist(char **cas)
+{
+	struct dirent **namelist;
+	int n, i, j = 0;
+
+	n = scandir(SYS_INFINIBAND, &namelist, NULL, alphasort);
+
+	if (n > 0) {
+		*cas = (char *) calloc(1, n * sizeof(char) * UMAD_CA_NAME_LEN);
+		for (i = 0; i < n; i++) {
+			if (*cas && strcmp(namelist[i]->d_name, ".") &&
+			    strcmp(namelist[i]->d_name, "..")) {
+				if (is_ib_type(namelist[i]->d_name)) {
+					strncpy(*cas + j * UMAD_CA_NAME_LEN,
+						namelist[i]->d_name,
+						UMAD_CA_NAME_LEN);
+					j++;
+				}
+			}
+			free(namelist[i]);
+		}
+		DEBUG("return %d cas", j);
+	} else {
+		/* Is this still needed ? */
+		if ((*cas = calloc(1, UMAD_CA_NAME_LEN * sizeof(char)))) {
+			strncpy(*cas, def_ca_name, UMAD_CA_NAME_LEN);
+			DEBUG("return 1 ca");
+			j = 1;
+		}
+	}
+	if (n >= 0)
+		free(namelist);
+
+	return j;
+}
+
+void umad_free_ca_namelist(char *cas)
+{
+	free(cas);
+}
diff --git a/libibumad/umad.h b/libibumad/umad.h
index 3cc551f..70bc213 100644
--- a/libibumad/umad.h
+++ b/libibumad/umad.h
@@ -208,6 +208,8 @@ int umad_register(int portid, int mgmt_class, int mgmt_version,
 int umad_register_oui(int portid, int mgmt_class, uint8_t rmpp_version,
 		      uint8_t oui[3], long method_mask[16 / sizeof(long)]);
 int umad_unregister(int portid, int agentid);
+int umad_get_ca_namelist(char **cas);
+void umad_free_ca_namelist(char *cas);
 
 enum {
 	UMAD_USER_RMPP = (1 << 0)
-- 
1.8.3.1

