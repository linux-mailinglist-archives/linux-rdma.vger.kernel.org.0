Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48E7ADBC4B
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Oct 2019 07:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441967AbfJRFA2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Oct 2019 01:00:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52052 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441982AbfJRFA2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 18 Oct 2019 01:00:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EE56410CC1F0;
        Fri, 18 Oct 2019 04:41:17 +0000 (UTC)
Received: from dhcp-128-227.nay.redhat.com (unknown [10.66.128.227])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9CDAB5D9CA;
        Fri, 18 Oct 2019 04:41:16 +0000 (UTC)
From:   Honggang LI <honli@redhat.com>
To:     bvanassche@acm.org
Cc:     linux-rdma@vger.kernel.org, Honggang Li <honli@redhat.com>
Subject: [PATCH] srp_daemon: Use maximum initiator to target IU size
Date:   Fri, 18 Oct 2019 12:41:04 +0800
Message-Id: <20191018044104.21353-1-honli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Fri, 18 Oct 2019 04:41:18 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Honggang Li <honli@redhat.com>

"ib_srp.ko" module with immediate data support use (8 * 1024)
as default immediate data size. When immediate data support enabled
for "ib_srp.ko" client, the default maximum initiator to target IU
size will greater than (8 * 1024). That means it also greater than
the default maximum initiator to target IU size set by old
"ib_srpt.ko" module, which does not support immediate data.

Signed-off-by: Honggang Li <honli@redhat.com>
---
 srp_daemon/srp_daemon.c                | 26 ++++++++++++++++++++++++--
 srp_daemon/srp_daemon.h                |  1 +
 srp_daemon/srp_daemon.sh.in            |  2 +-
 srp_daemon/srp_daemon_port@.service.in |  2 +-
 4 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/srp_daemon/srp_daemon.c b/srp_daemon/srp_daemon.c
index f0bcf923..43caf9d4 100644
--- a/srp_daemon/srp_daemon.c
+++ b/srp_daemon/srp_daemon.c
@@ -217,7 +217,7 @@ static int srpd_sys_read_uint64(const char *dir_name, const char *file_name,
 
 static void usage(const char *argv0)
 {
-	fprintf(stderr, "Usage: %s [-vVcaeon] [-d <umad device> | -i <infiniband device> [-p <port_num>]] [-t <timeout (ms)>] [-r <retries>] [-R <rescan time>] [-f <rules file>\n", argv0);
+	fprintf(stderr, "Usage: %s [-vVcaeonm] [-d <umad device> | -i <infiniband device> [-p <port_num>]] [-t <timeout (ms)>] [-r <retries>] [-R <rescan time>] [-f <rules file>\n", argv0);
 	fprintf(stderr, "-v 			Verbose\n");
 	fprintf(stderr, "-V 			debug Verbose\n");
 	fprintf(stderr, "-c 			prints connection Commands\n");
@@ -235,6 +235,7 @@ static void usage(const char *argv0)
 	fprintf(stderr, "-t <timeout>		Timeout for mad response in milliseconds\n");
 	fprintf(stderr, "-r <retries>		number of send Retries for each mad\n");
 	fprintf(stderr, "-n 			New connection command format - use also initiator extension\n");
+	fprintf(stderr, "-m 			New connection command format - use also maximum initiator to target IU size\n");
 	fprintf(stderr, "--systemd		Enable systemd integration.\n");
 	fprintf(stderr, "\nExample: srp_daemon -e -n -i mthca0 -p 1 -R 60\n");
 }
@@ -556,6 +557,19 @@ static int add_non_exist_target(struct target_details *target)
 		}
 	}
 
+	if (config->print_max_it_iu_size) {
+		len += snprintf(target_config_str+len,
+				sizeof(target_config_str) - len,
+				",max_it_iu_size=%d",
+				be32toh(target->ioc_prof.send_size));
+
+		if (len >= sizeof(target_config_str)) {
+			pr_err("Target config string is too long, ignoring target\n");
+			closedir(dir);
+			return -1;
+		}
+	}
+
 	if (config->execute && config->tl_retry_count) {
 		len += snprintf(target_config_str + len,
 				sizeof(target_config_str) - len,
@@ -1360,6 +1374,10 @@ static void print_config(struct config_t *conf)
 		printf(" Print initiator_ext\n");
 	else
 		printf(" Do not print initiator_ext\n");
+	if (conf->print_max_it_iu_size)
+		printf(" Print maximum initiator to target IU size\n");
+	else
+		printf(" Do not print maximum initiator to target IU size\n");
 	if (conf->recalc_time)
 		printf(" Performs full target rescan every %d seconds\n", conf->recalc_time);
 	else
@@ -1629,7 +1647,7 @@ static const struct option long_opts[] = {
 	{ "systemd",        0, NULL, 'S' },
 	{}
 };
-static const char short_opts[] = "caveod:i:j:p:t:r:R:T:l:Vhnf:";
+static const char short_opts[] = "caveod:i:j:p:t:r:R:T:l:Vhnmf:";
 
 /* Check if the --systemd options was passed in very early so we can setup
  * logging properly.
@@ -1670,6 +1688,7 @@ static int get_config(struct config_t *conf, int argc, char *argv[])
 	conf->retry_timeout 		= 20;
 	conf->add_target_file  		= NULL;
 	conf->print_initiator_ext	= 0;
+	conf->print_max_it_iu_size	= 0;
 	conf->rules_file		= SRP_DEAMON_CONFIG_FILE;
 	conf->rules			= NULL;
 	conf->tl_retry_count		= 0;
@@ -1734,6 +1753,9 @@ static int get_config(struct config_t *conf, int argc, char *argv[])
 		case 'n':
 			++conf->print_initiator_ext;
 			break;
+		case 'm':
+			++conf->print_max_it_iu_size;
+			break;
 		case 't':
 			conf->timeout = atoi(optarg);
 			if (conf->timeout == 0) {
diff --git a/srp_daemon/srp_daemon.h b/srp_daemon/srp_daemon.h
index b753cecd..d4111afc 100644
--- a/srp_daemon/srp_daemon.h
+++ b/srp_daemon/srp_daemon.h
@@ -206,6 +206,7 @@ struct config_t {
 	int		timeout;
 	int		recalc_time;
 	int		print_initiator_ext;
+	int		print_max_it_iu_size;
 	const char     *rules_file;
 	struct rule    *rules;
 	int 		retry_timeout;
diff --git a/srp_daemon/srp_daemon.sh.in b/srp_daemon/srp_daemon.sh.in
index 75e8a31b..dacbc9f5 100755
--- a/srp_daemon/srp_daemon.sh.in
+++ b/srp_daemon/srp_daemon.sh.in
@@ -76,7 +76,7 @@ for d in ${ibdir}_mad/umad*; do
     port="$(<"$d/port")"
     add_target="${ibdir}_srp/srp-${hca_id}-${port}/add_target"
     if [ -e "${add_target}" ]; then
-        ${prog} -e -c -n -i "${hca_id}" -p "${port}" -R "${rescan_interval}" "${params[@]}" >/dev/null 2>&1 &
+        ${prog} -e -c -n -m -i "${hca_id}" -p "${port}" -R "${rescan_interval}" "${params[@]}" >/dev/null 2>&1 &
         pids+=($!)
     fi
 done
diff --git a/srp_daemon/srp_daemon_port@.service.in b/srp_daemon/srp_daemon_port@.service.in
index 3d5a11e8..b91532ca 100644
--- a/srp_daemon/srp_daemon_port@.service.in
+++ b/srp_daemon/srp_daemon_port@.service.in
@@ -23,7 +23,7 @@ BindsTo=srp_daemon.service
 
 [Service]
 Type=simple
-ExecStart=@CMAKE_INSTALL_FULL_SBINDIR@/srp_daemon --systemd -e -c -n -j %I -R 60
+ExecStart=@CMAKE_INSTALL_FULL_SBINDIR@/srp_daemon --systemd -e -c -n -m -j %I -R 60
 MemoryDenyWriteExecute=yes
 PrivateNetwork=yes
 PrivateTmp=yes
-- 
2.21.0

