Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6F1C83417
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Aug 2019 16:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731314AbfHFOjJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Aug 2019 10:39:09 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:48827 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733035AbfHFOjJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Aug 2019 10:39:09 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from haimbo@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 6 Aug 2019 17:39:04 +0300
Received: from r-ufm115.mtr.labs.mlnx (r-ufm115.mtr.labs.mlnx [10.209.36.210])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x76Ed4jK007286;
        Tue, 6 Aug 2019 17:39:04 +0300
Received: from r-ufm115.mtr.labs.mlnx (localhost [127.0.0.1])
        by r-ufm115.mtr.labs.mlnx (8.14.7/8.14.7) with ESMTP id x76Ed44E020959;
        Tue, 6 Aug 2019 14:39:04 GMT
Received: (from haimbo@localhost)
        by r-ufm115.mtr.labs.mlnx (8.14.7/8.14.7/Submit) id x76Ed4D0020958;
        Tue, 6 Aug 2019 14:39:04 GMT
From:   Haim Boozaglo <haimbo@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     Vladimir Koushnir <vladimirk@mellanox.com>,
        Haim Boozaglo <haimbo@mellanox.com>
Subject: [PATCH 3/3] ibdiags: Support arbitrary number of IB devices in ibstat
Date:   Tue,  6 Aug 2019 14:38:54 +0000
Message-Id: <1565102334-20903-3-git-send-email-haimbo@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1565102334-20903-1-git-send-email-haimbo@mellanox.com>
References: <1565102334-20903-1-git-send-email-haimbo@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Vladimir Koushnir <vladimirk@mellanox.com>

Allow showing more than 32 IB devices on the server.
umad_get_ca_namelist API is used for this purpose.

Signed-off-by: Vladimir Koushnir <vladimirk@mellanox.com>
Signed-off-by: Haim Boozaglo <haimbo@mellanox.com>
---
 infiniband-diags/ibstat.c | 47 ++++++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/infiniband-diags/ibstat.c b/infiniband-diags/ibstat.c
index 4601f2a..9c87ff8 100644
--- a/infiniband-diags/ibstat.c
+++ b/infiniband-diags/ibstat.c
@@ -232,23 +232,22 @@ static int ca_stat(char *ca_name, int portnum, int no_ports)
 	return 0;
 }
 
-static int ports_list(char names[][UMAD_CA_NAME_LEN], int n)
+static int ports_list(char *names, int n)
 {
 	__be64 guids[64];
-	int found, ports, i;
+	int ports, i, j;
 
-	for (i = 0, found = 0; i < n && found < 64; i++) {
+	for (i = 0; i < n ; i++) {
 		if ((ports =
-		     umad_get_ca_portguids(names[i], guids + found,
-					   64 - found)) < 0)
+		     umad_get_ca_portguids(&names[i * UMAD_CA_NAME_LEN],
+					   &guids[0], 64)) < 0)
 			return -1;
-		found += ports;
-	}
 
-	for (i = 0; i < found; i++)
-		if (guids[i])
-			printf("0x%016" PRIx64 "\n", be64toh(guids[i]));
-	return found;
+		for (j = 0; j < ports; j++)
+			if (guids[j])
+				printf("0x%016" PRIx64 "\n", be64toh(guids[j]));
+	}
+	return 0;
 }
 
 static int list_only, short_format, list_ports;
@@ -273,9 +272,10 @@ static int process_opt(void *context, int ch)
 
 int main(int argc, char *argv[])
 {
-	char names[UMAD_MAX_DEVICES][UMAD_CA_NAME_LEN];
+	char *names;
 	int dev_port = -1;
 	int n, i;
+	char *nptr;
 
 	const struct ibdiag_opt opts[] = {
 		{"list_of_cas", 'l', 0, NULL, "list all IB devices"},
@@ -302,33 +302,38 @@ int main(int argc, char *argv[])
 	if (umad_init() < 0)
 		IBPANIC("can't init UMAD library");
 
-	if ((n = umad_get_cas_names(names, UMAD_MAX_DEVICES)) < 0)
+	if ((n = umad_get_ca_namelist(&names)) < 0)
 		IBPANIC("can't list IB device names");
 
 	if (argc) {
 		for (i = 0; i < n; i++)
-			if (!strncmp(names[i], argv[0], sizeof names[i]))
+			if (!strncmp(&names[i * UMAD_CA_NAME_LEN],
+				     argv[0], UMAD_CA_NAME_LEN))
 				break;
 		if (i >= n)
 			IBPANIC("'%s' IB device can't be found", argv[0]);
-
-		strncpy(names[0], argv[0], sizeof(names[0])-1);
-		names[0][sizeof(names[0])-1] = '\0';
+		if (i != 0) {
+			strncpy(&names[0],
+				&names[i * UMAD_CA_NAME_LEN],
+				UMAD_CA_NAME_LEN);
+		}
 		n = 1;
 	}
 
 	if (list_ports) {
 		if (ports_list(names, n) < 0)
 			IBPANIC("can't list ports");
+		umad_free_ca_namelist(names);
 		return 0;
 	}
 
 	for (i = 0; i < n; i++) {
+		nptr = &names[i * UMAD_CA_NAME_LEN];
 		if (list_only)
-			printf("%s\n", names[i]);
-		else if (ca_stat(names[i], dev_port, short_format) < 0)
-			IBPANIC("stat of IB device '%s' failed", names[i]);
+			printf("%s\n", nptr);
+		else if (ca_stat(nptr, dev_port, short_format) < 0)
+			IBPANIC("stat of IB device '%s' failed", nptr);
 	}
-
+	umad_free_ca_namelist(names);
 	return 0;
 }
-- 
1.8.3.1

