Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4E6683418
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Aug 2019 16:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733035AbfHFOjJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Aug 2019 10:39:09 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:48826 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732018AbfHFOjJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Aug 2019 10:39:09 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from haimbo@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 6 Aug 2019 17:39:03 +0300
Received: from r-ufm115.mtr.labs.mlnx (r-ufm115.mtr.labs.mlnx [10.209.36.210])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x76Ed2Ow007278;
        Tue, 6 Aug 2019 17:39:02 +0300
Received: from r-ufm115.mtr.labs.mlnx (localhost [127.0.0.1])
        by r-ufm115.mtr.labs.mlnx (8.14.7/8.14.7) with ESMTP id x76Ed3Or020955;
        Tue, 6 Aug 2019 14:39:03 GMT
Received: (from haimbo@localhost)
        by r-ufm115.mtr.labs.mlnx (8.14.7/8.14.7/Submit) id x76Ed2Ij020954;
        Tue, 6 Aug 2019 14:39:02 GMT
From:   Haim Boozaglo <haimbo@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     Vladimir Koushnir <vladimirk@mellanox.com>,
        Haim Boozaglo <haimbo@mellanox.com>
Subject: [PATCH 2/3] libibumad: Redesign resolve_ca_name to support arbitrary number of IB devices
Date:   Tue,  6 Aug 2019 14:38:53 +0000
Message-Id: <1565102334-20903-2-git-send-email-haimbo@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1565102334-20903-1-git-send-email-haimbo@mellanox.com>
References: <1565102334-20903-1-git-send-email-haimbo@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Vladimir Koushnir <vladimirk@mellanox.com>

resolve_ca_name is now based on the new umad_get_ca_namelist API
rather than the old umad_get_cas_names API.

Signed-off-by: Vladimir Koushnir <vladimirk@mellanox.com>
Signed-off-by: Haim Boozaglo <haimbo@mellanox.com>
---
 libibumad/umad.c | 100 +++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 64 insertions(+), 36 deletions(-)

diff --git a/libibumad/umad.c b/libibumad/umad.c
index 9d0303b..0fdf85e 100644
--- a/libibumad/umad.c
+++ b/libibumad/umad.c
@@ -331,42 +331,52 @@ Exit:
 	return ret;
 }
 
-static const char *resolve_ca_name(const char *ca_name, int *best_port)
+static int resolve_ca_name(const char *ca_in, int *best_port,
+			   char ca_name[UMAD_CA_NAME_LEN])
 {
-	static char names[UMAD_MAX_DEVICES][UMAD_CA_NAME_LEN];
+	char *names;
+	char *name_found;
 	int phys_found = -1, port_found = 0, port, port_type;
 	int caidx, n;
 
-	if (ca_name && (!best_port || *best_port))
-		return ca_name;
+	if (ca_in && (!best_port || *best_port)) {
+		strncpy(ca_name, ca_in, UMAD_CA_NAME_LEN);
+		return 0;
+	}
 
-	if (ca_name) {
-		if (resolve_ca_port(ca_name, best_port) < 0)
-			return NULL;
-		return ca_name;
+	if (ca_in) {
+		if (resolve_ca_port(ca_in, best_port) < 0)
+			return -1;
+		strncpy(ca_name, ca_in, UMAD_CA_NAME_LEN);
+		return 0;
 	}
 
 	/* Get the list of CA names */
-	if ((n = umad_get_cas_names((void *)names, UMAD_MAX_DEVICES)) < 0)
-		return NULL;
+	if ((n = umad_get_ca_namelist(&names)) < 0)
+		return -1;
 
 	/* Find the first existing CA with an active port */
 	for (caidx = 0; caidx < n; caidx++) {
-		TRACE("checking ca '%s'", names[caidx]);
+		name_found = &names[caidx * UMAD_CA_NAME_LEN];
+
+		TRACE("checking ca '%s'", name_found);
 
 		port = best_port ? *best_port : 0;
-		if ((port_type = resolve_ca_port(names[caidx], &port)) < 0)
+		if ((port_type = resolve_ca_port(name_found,
+						 &port)) < 0)
 			continue;
 
 		DEBUG("found ca %s with port %d type %d",
-		      names[caidx], port, port_type);
+		      name_found, port, port_type);
 
 		if (port_type > 0) {
 			if (best_port)
 				*best_port = port;
 			DEBUG("found ca %s with active port %d",
-			      names[caidx], port);
-			return (char *)(names + caidx);
+			      name_found, port);
+			strncpy(ca_name, name_found, UMAD_CA_NAME_LEN);
+			umad_free_ca_namelist(names);
+			return 0;
 		}
 
 		if (phys_found == -1) {
@@ -376,17 +386,30 @@ static const char *resolve_ca_name(const char *ca_name, int *best_port)
 	}
 
 	DEBUG("phys found %d on %s port %d",
-	      phys_found, phys_found >= 0 ? names[phys_found] : NULL,
+	      phys_found,
+	      phys_found >= 0 ? &names[phys_found *  UMAD_CA_NAME_LEN] : NULL,
 	      port_found);
+
 	if (phys_found >= 0) {
+		name_found = &names[phys_found * UMAD_CA_NAME_LEN];
+		DEBUG("phys found %d on %s port %d",
+			phys_found,
+			phys_found >= 0 ? name_found : NULL,
+			port_found);
 		if (best_port)
 			*best_port = port_found;
-		return names[phys_found];
+		strncpy(ca_name, name_found, UMAD_CA_NAME_LEN);
+		umad_free_ca_namelist(names);
+		return 0;
 	}
 
+	umad_free_ca_namelist(names);
+
 	if (best_port)
 		*best_port = def_ca_port;
-	return def_ca_name;
+
+	strncpy(ca_name, def_ca_name, UMAD_CA_NAME_LEN);
+	return 0;
 }
 
 static int get_ca(const char *ca_name, umad_ca_t * ca)
@@ -577,16 +600,17 @@ int umad_get_cas_names(char cas[][UMAD_CA_NAME_LEN], int max)
 	return j;
 }
 
-int umad_get_ca_portguids(const char *ca_name, __be64 *portguids, int max)
+int umad_get_ca_portguids(const char *ca_name, __be64 * portguids, int max)
 {
 	umad_ca_t ca;
 	int ports = 0, i;
+	char found_ca_name[UMAD_CA_NAME_LEN];
 
 	TRACE("ca name %s max port guids %d", ca_name, max);
-	if (!(ca_name = resolve_ca_name(ca_name, NULL)))
+	if (resolve_ca_name(ca_name, NULL, found_ca_name) < 0)
 		return -ENODEV;
 
-	if (umad_get_ca(ca_name, &ca) < 0)
+	if (umad_get_ca(found_ca_name, &ca) < 0)
 		return -1;
 
 	if (portguids) {
@@ -596,12 +620,12 @@ int umad_get_ca_portguids(const char *ca_name, __be64 *portguids, int max)
 		}
 
 		for (i = 0; i <= ca.numports; i++)
-			portguids[ports++] = ca.ports[i] ?
-				ca.ports[i]->port_guid : htobe64(0);
+			portguids[ports++] =
+			    ca.ports[i] ? ca.ports[i]->port_guid : 0;
 	}
 
 	release_ca(&ca);
-	DEBUG("%s: %d ports", ca_name, ports);
+	DEBUG("%s: %d ports", found_ca_name, ports);
 
 	return ports;
 }
@@ -609,13 +633,14 @@ int umad_get_ca_portguids(const char *ca_name, __be64 *portguids, int max)
 int umad_get_issm_path(const char *ca_name, int portnum, char path[], int max)
 {
 	int umad_id;
+	char found_ca_name[UMAD_CA_NAME_LEN];
 
 	TRACE("ca %s port %d", ca_name, portnum);
 
-	if (!(ca_name = resolve_ca_name(ca_name, &portnum)))
+	if (resolve_ca_name(ca_name, &portnum, found_ca_name) < 0)
 		return -ENODEV;
 
-	if ((umad_id = dev_to_umad_id(ca_name, portnum)) < 0)
+	if ((umad_id = dev_to_umad_id(found_ca_name, portnum)) < 0)
 		return -EINVAL;
 
 	snprintf(path, max, "%s/issm%u", RDMA_CDEV_DIR, umad_id);
@@ -628,18 +653,19 @@ int umad_open_port(const char *ca_name, int portnum)
 	char dev_file[UMAD_DEV_FILE_SZ];
 	int umad_id, fd;
 	unsigned int abi_version = get_abi_version();
+	char found_ca_name[UMAD_CA_NAME_LEN];
 
 	TRACE("ca %s port %d", ca_name, portnum);
 
 	if (!abi_version)
 		return -EOPNOTSUPP;
 
-	if (!(ca_name = resolve_ca_name(ca_name, &portnum)))
+	if (resolve_ca_name(ca_name, &portnum, found_ca_name) < 0 )
 		return -ENODEV;
 
-	DEBUG("opening %s port %d", ca_name, portnum);
+	DEBUG("opening %s port %d", found_ca_name, portnum);
 
-	if ((umad_id = dev_to_umad_id(ca_name, portnum)) < 0)
+	if ((umad_id = dev_to_umad_id(found_ca_name, portnum)) < 0)
 		return -EINVAL;
 
 	snprintf(dev_file, sizeof(dev_file), "%s/umad%d",
@@ -662,18 +688,19 @@ int umad_open_port(const char *ca_name, int portnum)
 int umad_get_ca(const char *ca_name, umad_ca_t * ca)
 {
 	int r;
+	char found_ca_name[UMAD_CA_NAME_LEN];
 
 	TRACE("ca_name %s", ca_name);
-	if (!(ca_name = resolve_ca_name(ca_name, NULL)))
+	if (resolve_ca_name(ca_name, NULL, found_ca_name) < 0)
 		return -ENODEV;
 
-	if (find_cached_ca(ca_name, ca) > 0)
+	if (find_cached_ca(found_ca_name, ca) > 0)
 		return 0;
 
-	if ((r = get_ca(ca_name, ca)) < 0)
+	if ((r = get_ca(found_ca_name, ca)) < 0)
 		return r;
 
-	DEBUG("opened %s", ca_name);
+	DEBUG("opened %s", found_ca_name);
 	return 0;
 }
 
@@ -695,16 +722,17 @@ int umad_release_ca(umad_ca_t * ca)
 int umad_get_port(const char *ca_name, int portnum, umad_port_t * port)
 {
 	char dir_name[256];
+	char found_ca_name[UMAD_CA_NAME_LEN];
 
 	TRACE("ca_name %s portnum %d", ca_name, portnum);
 
-	if (!(ca_name = resolve_ca_name(ca_name, &portnum)))
+	if (resolve_ca_name(ca_name, &portnum, found_ca_name) < 0)
 		return -ENODEV;
 
 	snprintf(dir_name, sizeof(dir_name), "%s/%s/%s",
-		 SYS_INFINIBAND, ca_name, SYS_CA_PORTS_DIR);
+		 SYS_INFINIBAND, found_ca_name, SYS_CA_PORTS_DIR);
 
-	return get_port(ca_name, dir_name, portnum, port);
+	return get_port(found_ca_name, dir_name, portnum, port);
 }
 
 int umad_release_port(umad_port_t * port)
-- 
1.8.3.1

