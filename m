Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B51C3DC01D
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 23:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbhG3VKn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Jul 2021 17:10:43 -0400
Received: from mga03.intel.com ([134.134.136.65]:12207 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230483AbhG3VKn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 30 Jul 2021 17:10:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10061"; a="213203323"
X-IronPort-AV: E=Sophos;i="5.84,282,1620716400"; 
   d="scan'208";a="213203323"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 14:10:38 -0700
X-IronPort-AV: E=Sophos;i="5.84,282,1620716400"; 
   d="scan'208";a="499752259"
Received: from sindhude-mobl.amr.corp.intel.com ([10.212.74.5])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 14:10:37 -0700
From:   Sindhu Devale <sindhu.devale@intel.com>
To:     jgg@nvidia.com, dledford@redhat.com, leon@kernel.org,
        tatyana.e.nikolova@intel.com
Cc:     linux-rdma@vger.kernel.org, shiraz.saleem@intel.com,
        mustafa.ismail@intel.com, Sindhu Devale <sindhu.devale@intel.com>
Subject: [PATCH rdma-core 2/2] iwpmd: Remove IP address checking per mapping
Date:   Fri, 30 Jul 2021 16:10:04 -0500
Message-Id: <20210730211004.1946-3-sindhu.devale@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210730211004.1946-1-sindhu.devale@intel.com>
References: <20210730211004.1946-1-sindhu.devale@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>

IP address checking per mapping is redundant, because
the IP address has already been checked in the rdma_bind_addr()
in kernel before the IP address is passed to the iwpmd.

Without removing this logic, the system call getifaddrs()
could take long time and cause mapping requests to timeout.

Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Signed-off-by: Sindhu Devale <sindhu.devale@intel.com>
---
 iwpmd/iwarp_pm_helper.c | 89 +----------------------------------------
 1 file changed, 2 insertions(+), 87 deletions(-)

diff --git a/iwpmd/iwarp_pm_helper.c b/iwpmd/iwarp_pm_helper.c
index b82de5c8..5d75eb32 100644
--- a/iwpmd/iwarp_pm_helper.c
+++ b/iwpmd/iwarp_pm_helper.c
@@ -172,83 +172,6 @@ int send_iwpm_msg(void (*form_msg_type)(iwpm_wire_msg *, iwpm_msg_parms *),
 	return add_iwpm_pending_msg(&send_msg);
 }
 
-/**
- * check_iwpm_ip_addr - Check if the local IP address is valid
- * @local_addr:  local IP address to verify
- *
- * Check if the local IP address is used by the host ethernet interfaces
- */
-static int check_iwpm_ip_addr(struct sockaddr_storage *local_addr)
-{
-	struct ifaddrs ifa;
-	struct ifaddrs *ifap = &ifa;
-	struct ifaddrs **ifa_list = &ifap;
-	struct ifaddrs *ifa_current;
-	int found_addr = 0;
-	int ret = -EINVAL;
-
-	/* get a list of host ethernet interfaces */
-	if ((ret = getifaddrs(ifa_list)) < 0) {
-		syslog(LOG_WARNING, "check_iwpm_ip_addr: Unable to get the list of interfaces (%s).\n",
-				strerror(errno));
-		return ret;
-	}
-	/* go through the list to make sure local IP address is valid */
-	ifa_current = *ifa_list;
-	while (ifa_current != NULL && !found_addr) {
-		if (local_addr->ss_family == ifa_current->ifa_addr->sa_family) {
-			switch (ifa_current->ifa_addr->sa_family) {
-			case AF_INET: {
-				if (!memcmp(&((struct sockaddr_in *)
-					ifa_current->ifa_addr)->sin_addr.s_addr,
-				   	&((struct sockaddr_in *)local_addr)->sin_addr.s_addr,
-					IWARP_PM_IPV4_ADDR)) {
-
-					found_addr = 1;
-				}
-				break;
-			}
-			case AF_INET6: {
-				if (!memcmp(&((struct sockaddr_in6 *)
-					ifa_current->ifa_addr)->sin6_addr.s6_addr,
-				    	&((struct sockaddr_in6 *)local_addr)->sin6_addr.s6_addr,
-					INET6_ADDRSTRLEN))
-
-					found_addr = 1;
-				break;
-			}
-			default:
-				break;
-			}
-		}
-		ifa_current = ifa_current->ifa_next;
-	}
-	if (found_addr)
-		ret = 0;
-
-	freeifaddrs(*ifa_list);
-	return ret;
-}
-
-/**
- * get_iwpm_ip_addr - Get a mapped IP address
- * @local_addr:  local IP address to map
- * @mapped_addr: to store the mapped local IP address
- *
- * Currently, don't map the local IP address
- */
-static int get_iwpm_ip_addr(struct sockaddr_storage *local_addr,
-					struct sockaddr_storage *mapped_addr)
-{
-	int ret = check_iwpm_ip_addr(local_addr);
-	if (!ret)
-		memcpy(mapped_addr, local_addr, sizeof(struct sockaddr_storage));
-	else
-		iwpm_debug(IWARP_PM_ALL_DBG, "get_iwpm_ip_addr: Invalid local IP address.\n");
-
-	return ret;
-}
-
 /**
  * get_iwpm_tcp_port - Get a new TCP port from the host stack
  * @addr_family: should be valid AF_INET or AF_INET6
@@ -358,18 +281,14 @@ iwpm_mapped_port *create_iwpm_mapped_port(struct sockaddr_storage *local_addr, i
 	struct sockaddr_storage mapped_addr;
 	int new_sd;
 
-	/* check the local IP address */
-	if (get_iwpm_ip_addr(local_addr, &mapped_addr))
-		goto create_mapped_port_error;
+	memcpy(&mapped_addr, local_addr, sizeof(mapped_addr));
 	/* get a tcp port from the host net stack */
 	if (flags & IWPM_FLAGS_NO_PORT_MAP) {
-		mapped_addr = *local_addr;
 		new_sd = -1;
 	} else {
 		if (get_iwpm_tcp_port(local_addr->ss_family, 0, &mapped_addr, &new_sd))
 			goto create_mapped_port_error;
 	}
-
 	iwpm_port = get_iwpm_port(client_idx, local_addr, &mapped_addr, new_sd);
 	return iwpm_port;
 
@@ -391,11 +310,7 @@ iwpm_mapped_port *reopen_iwpm_mapped_port(struct sockaddr_storage *local_addr,
 	iwpm_mapped_port *iwpm_port;
 	int new_sd = -1;
 	const char *str_err = "";
-	int ret = check_iwpm_ip_addr(local_addr);
-	if (ret) {
-		str_err = "Invalid local IP address";
-		goto reopen_mapped_port_error;
-	}
+
 	if (local_addr->ss_family != mapped_addr->ss_family) {
 		str_err = "Different local and mapped sockaddr families";
 		goto reopen_mapped_port_error;
-- 
2.32.0

