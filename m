Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 650D216ABE5
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2020 17:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgBXQpv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Feb 2020 11:45:51 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:46506 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727426AbgBXQpv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Feb 2020 11:45:51 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 24 Feb 2020 18:45:45 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx [10.209.102.136])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 01OGji9M013647;
        Mon, 24 Feb 2020 18:45:44 +0200
From:   Max Gurtovoy <maxg@mellanox.com>
To:     linux-nvme@lists.infradead.org, sagi@grimberg.me,
        linux-rdma@vger.kernel.org, kbusch@kernel.org, hch@lst.de,
        martin.petersen@oracle.com
Cc:     vladimirk@mellanox.com, idanb@mellanox.com, maxg@mellanox.com,
        israelr@mellanox.com, axboe@kernel.dk, shlomin@mellanox.com
Subject: [PATCH] nvme-cli/fabrics: Add pi_enable param to connect cmd
Date:   Mon, 24 Feb 2020 18:45:25 +0200
Message-Id: <20200224164544.219438-2-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200224164544.219438-1-maxg@mellanox.com>
References: <20200224164544.219438-1-maxg@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Israel Rukshin <israelr@mellanox.com>

Added 'pi_enable' to 'connect' command so users can enable metadata support.

usage examples:
nvme connect --pi_enable --transport=rdma --traddr=10.0.1.1 --nqn=test-nvme
nvme connect -p -t rdma -a 10.0.1.1 -n test_nvme

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
 fabrics.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fabrics.c b/fabrics.c
index 8982ae4..b22ea14 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -72,6 +72,7 @@ static struct config {
 	int  disable_sqflow;
 	int  hdr_digest;
 	int  data_digest;
+	int  pi_enable;
 	bool persistent;
 	bool quiet;
 } cfg = { NULL };
@@ -756,7 +757,9 @@ static int build_options(char *argstr, int max_len, bool discover)
 	    add_bool_argument(&argstr, &max_len, "disable_sqflow",
 				cfg.disable_sqflow) ||
 	    add_bool_argument(&argstr, &max_len, "hdr_digest", cfg.hdr_digest) ||
-	    add_bool_argument(&argstr, &max_len, "data_digest", cfg.data_digest))
+	    add_bool_argument(&argstr, &max_len, "data_digest",
+				cfg.data_digest) ||
+	    add_bool_argument(&argstr, &max_len, "pi_enable", cfg.pi_enable))
 		return -EINVAL;
 
 	return 0;
@@ -885,6 +888,13 @@ retry:
 		p += len;
 	}
 
+	if (cfg.pi_enable) {
+		len = sprintf(p, ",pi_enable");
+		if (len < 0)
+			return -EINVAL;
+		p += len;
+	}
+
 	switch (e->trtype) {
 	case NVMF_TRTYPE_RDMA:
 	case NVMF_TRTYPE_TCP:
@@ -1171,6 +1181,7 @@ int discover(const char *desc, int argc, char **argv, bool connect)
 		OPT_INT("tos",             'T', &cfg.tos,             "type of service"),
 		OPT_FLAG("hdr_digest",     'g', &cfg.hdr_digest,      "enable transport protocol header digest (TCP transport)"),
 		OPT_FLAG("data_digest",    'G', &cfg.data_digest,     "enable transport protocol data digest (TCP transport)"),
+		OPT_FLAG("pi_enable",      'p', &cfg.pi_enable,       "enable metadata (T10-PI) support (default false)"),
 		OPT_INT("nr-io-queues",    'i', &cfg.nr_io_queues,    "number of io queues to use (default is core count)"),
 		OPT_INT("nr-write-queues", 'W', &cfg.nr_write_queues, "number of write queues to use (default 0)"),
 		OPT_INT("nr-poll-queues",  'P', &cfg.nr_poll_queues,  "number of poll queues to use (default 0)"),
@@ -1231,6 +1242,7 @@ int connect(const char *desc, int argc, char **argv)
 		OPT_FLAG("disable-sqflow",    'd', &cfg.disable_sqflow,    "disable controller sq flow control (default false)"),
 		OPT_FLAG("hdr-digest",        'g', &cfg.hdr_digest,        "enable transport protocol header digest (TCP transport)"),
 		OPT_FLAG("data-digest",       'G', &cfg.data_digest,       "enable transport protocol data digest (TCP transport)"),
+		OPT_FLAG("pi_enable",         'p', &cfg.pi_enable,         "enable metadata (T10-PI) support (default false)"),
 		OPT_END()
 	};
 
-- 
1.8.3.1

