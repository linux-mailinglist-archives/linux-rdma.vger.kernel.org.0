Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74E33DC01C
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 23:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbhG3VKm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Jul 2021 17:10:42 -0400
Received: from mga03.intel.com ([134.134.136.65]:12207 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230483AbhG3VKm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 30 Jul 2021 17:10:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10061"; a="213203322"
X-IronPort-AV: E=Sophos;i="5.84,282,1620716400"; 
   d="scan'208";a="213203322"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 14:10:37 -0700
X-IronPort-AV: E=Sophos;i="5.84,282,1620716400"; 
   d="scan'208";a="499752255"
Received: from sindhude-mobl.amr.corp.intel.com ([10.212.74.5])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 14:10:36 -0700
From:   Sindhu Devale <sindhu.devale@intel.com>
To:     jgg@nvidia.com, dledford@redhat.com, leon@kernel.org,
        tatyana.e.nikolova@intel.com
Cc:     linux-rdma@vger.kernel.org, shiraz.saleem@intel.com,
        mustafa.ismail@intel.com, Earl Ruby <eruby@vmware.com>,
        Sindhu Devale <sindhu.devale@intel.com>
Subject: [PATCH rdma-core 1/2] iwpmd: Start the service if IPv4 or IPv6 is available
Date:   Fri, 30 Jul 2021 16:10:03 -0500
Message-Id: <20210730211004.1946-2-sindhu.devale@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210730211004.1946-1-sindhu.devale@intel.com>
References: <20210730211004.1946-1-sindhu.devale@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>

Currently the iwpmd fails to start if IPv6 isn't enabled.

systemd: Starting iWarp Port Mapper...
iwpmd[118194]: create_iwpm_socket_v6: Unable to create socket.
Address family not supported by protocol.
iwpmd[118194]: main: Couldn't start iWarp Port Mapper
systemd: iwpmd.service: main process exited, code=exited,
status=1/FAILURE

This isn't necessary because iwpmd can use IPv4 for all its functions.

This fix allows iwpmd to start if either IPv6 or IPv4 is
available.

Change-Id: I158e7cfad06c9efdb01b4a38465d015b2a302bb2
Reported-by: Earl Ruby <eruby@vmware.com>
Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Signed-off-by: Sindhu Devale <sindhu.devale@intel.com>
---
 iwpmd/iwarp_pm_common.c |  2 +-
 iwpmd/iwarp_pm_server.c | 82 +++++++++++++++++++++++------------------
 2 files changed, 48 insertions(+), 36 deletions(-)

diff --git a/iwpmd/iwarp_pm_common.c b/iwpmd/iwarp_pm_common.c
index 67309cbe..da8a70e3 100644
--- a/iwpmd/iwarp_pm_common.c
+++ b/iwpmd/iwarp_pm_common.c
@@ -264,7 +264,7 @@ create_nl_socket_exit:
  */
 void destroy_iwpm_socket(int pm_sock)
 {
-	if (pm_sock > 0)
+	if (pm_sock >= 0)
 		close(pm_sock);
 	pm_sock = -1;
 }
diff --git a/iwpmd/iwarp_pm_server.c b/iwpmd/iwarp_pm_server.c
index b3f23b7a..366fb33f 100644
--- a/iwpmd/iwarp_pm_server.c
+++ b/iwpmd/iwarp_pm_server.c
@@ -1416,10 +1416,14 @@ static int iwarp_port_mapper(void)
 			/* initialize the file sets for select */
 			FD_ZERO(&select_fdset);
 			/* add the UDP and Netlink sockets to the file set */
-			FD_SET(pmv4_sock, &select_fdset);
-			FD_SET(pmv4_client_sock, &select_fdset);
-			FD_SET(pmv6_sock, &select_fdset);
-			FD_SET(pmv6_client_sock, &select_fdset);
+			if (pmv4_sock >= 0) {
+				FD_SET(pmv4_sock, &select_fdset);
+				FD_SET(pmv4_client_sock, &select_fdset);
+			}
+			if (pmv6_sock >= 0) {
+				FD_SET(pmv6_sock, &select_fdset);
+				FD_SET(pmv6_client_sock, &select_fdset);
+			}
 			FD_SET(netlink_sock, &select_fdset);
 
 			/* set the timeout for select */
@@ -1438,25 +1442,25 @@ static int iwarp_port_mapper(void)
 			goto iwarp_port_mapper_exit;
 		}
 
-		if (FD_ISSET(pmv4_sock, &select_fdset)) {
-			ret = process_iwpm_msg(pmv4_sock);
-		}
+		if (pmv4_sock >= 0) {
+			if (FD_ISSET(pmv4_sock, &select_fdset))
+				ret = process_iwpm_msg(pmv4_sock);
 
-		if (FD_ISSET(pmv6_sock, &select_fdset)) {
-			ret = process_iwpm_msg(pmv6_sock);
+			if (FD_ISSET(pmv4_client_sock, &select_fdset))
+				ret = process_iwpm_msg(pmv4_client_sock);
 		}
 
-		if (FD_ISSET(pmv4_client_sock, &select_fdset)) {
-			ret = process_iwpm_msg(pmv4_client_sock);
-		}
+		if (pmv6_sock >= 0) {
+			if (FD_ISSET(pmv6_sock, &select_fdset))
+				ret = process_iwpm_msg(pmv6_sock);
 
-		if (FD_ISSET(pmv6_client_sock, &select_fdset)) {
-			ret = process_iwpm_msg(pmv6_client_sock);
+			if (FD_ISSET(pmv6_client_sock, &select_fdset))
+				ret = process_iwpm_msg(pmv6_client_sock);
 		}
 
-		if (FD_ISSET(netlink_sock, &select_fdset)) {
+		if (FD_ISSET(netlink_sock, &select_fdset))
 			ret = process_iwpm_netlink_msg(netlink_sock);
-		}
+
 	} while (1);
 
 iwarp_port_mapper_exit:
@@ -1516,26 +1520,38 @@ int main(int argc, char *argv[])
 		fclose(fp);
 	}
 	memset(client_list, 0, sizeof(client_list));
+	pmv4_client_sock = -1;
+	pmv6_sock = -1;
+	pmv6_client_sock = pmv6_sock;
 
 	pmv4_sock = create_iwpm_socket_v4(IWARP_PM_PORT);
-	if (pmv4_sock < 0)
-		goto error_exit_v4;
-
-	pmv4_client_sock = create_iwpm_socket_v4(0);
-	if (pmv4_client_sock < 0)
-		goto error_exit_v4_client;
+	if (pmv4_sock < 0 && pmv4_sock != -EAFNOSUPPORT)
+		goto error_exit_sock;
 
 	pmv6_sock = create_iwpm_socket_v6(IWARP_PM_PORT);
-	if (pmv6_sock < 0)
-		goto error_exit_v6;
+	if (pmv6_sock < 0 && pmv6_sock != -EAFNOSUPPORT)
+		goto error_exit_sock;
+
+	/* If neither IPv4 nor IPv6 is supported, exit */
+	if (pmv4_sock < 0 && pmv6_sock < 0)
+		goto error_exit_sock;
 
-	pmv6_client_sock = create_iwpm_socket_v6(0);
-	if (pmv6_client_sock < 0)
-		goto error_exit_v6_client;
+	if (pmv4_sock >= 0) {
+		pmv4_client_sock = create_iwpm_socket_v4(0);
+
+		if (pmv4_client_sock < 0)
+			goto error_exit_sock;
+	}
+	if (pmv6_sock >= 0) {
+		pmv6_client_sock = create_iwpm_socket_v6(0);
+
+		if (pmv6_client_sock < 0)
+			goto error_exit_sock;
+	}
 
 	netlink_sock = create_netlink_socket();
 	if (netlink_sock < 0)
-		goto error_exit_nl;
+		goto error_exit_sock;
 
 	signal(SIGHUP, iwpm_signal_handler);
 	signal(SIGTERM, iwpm_signal_handler);
@@ -1566,15 +1582,11 @@ int main(int argc, char *argv[])
 
 error_exit:
 	destroy_iwpm_socket(netlink_sock);
-error_exit_nl:
-	destroy_iwpm_socket(pmv6_client_sock);
-error_exit_v6_client:
-	destroy_iwpm_socket(pmv6_sock);
-error_exit_v6:
+error_exit_sock:
 	destroy_iwpm_socket(pmv4_client_sock);
-error_exit_v4_client:
+	destroy_iwpm_socket(pmv6_client_sock);
 	destroy_iwpm_socket(pmv4_sock);
-error_exit_v4:
+	destroy_iwpm_socket(pmv6_sock);
 	syslog(LOG_WARNING, "main: Couldn't start iWarp Port Mapper.\n");
 	return ret;
 }
-- 
2.32.0

