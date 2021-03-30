Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90A9334E251
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Mar 2021 09:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhC3Hii (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Mar 2021 03:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbhC3HiN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Mar 2021 03:38:13 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2987C0613DB
        for <linux-rdma@vger.kernel.org>; Tue, 30 Mar 2021 00:38:12 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id dm8so17038068edb.2
        for <linux-rdma@vger.kernel.org>; Tue, 30 Mar 2021 00:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HlhC7loombWUFcEvGFDGgJ7hOzitEbTOI0PS0y/ZFaI=;
        b=XHaz4Gyv8KbHqFAcglA9AFnEx1Z3EgtdQzpLKybsVZS1Xd5WArR2I38f9egVuDNBLh
         Ml83jFEpUk17no8TgBpqn4IL1aRC8kfosiYk6pVqUFymT+lgqiCrU+rwCbgSCGikgBYF
         cbOKJfgFdguJTISFoWbDkf3QDH+Xt+n7zzgt2PQJILDR8ER261T9Y10m5M53Yt6ZPHtL
         k5Kwj86GwZM4ZG+/ApHhFBMTeWpJt0bbPk2C67xDpJczyiGFoX1QJ9MFHud2zv7MkDU1
         0jYl/FetlHcP6FUHlJQZUCmToyCE32JASPoJmOv/5MxCXwShAns4rWeRqOp9FtCnROkM
         P/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HlhC7loombWUFcEvGFDGgJ7hOzitEbTOI0PS0y/ZFaI=;
        b=kwdX7+mXjEFJC3TFzkq7OSsyybVeI3IK5PGoEnd8UZR8ux/OJ+6tdHXZGG8vNL4yLj
         JfRgijQquk5kU6qJOI6szfmB3IFnRgBQBkcb23c4/RWZ1VkGNnaeQUik7+50S6eUku4c
         jsndsB0dfjIse0lIOqgPbGo2tEi1q3CNdJVElZsiEDlm4AFdeZT2EIb0aMagCu92nhw1
         lbFrFQDkChRnxOsaAMsbV53r1MdfR/wdBsWdwMYl3a90A6g7Mz7ESEWq5bjMXaOwk7CO
         5JnqQ6Kx+GTuIF4C7ODER0JL1mq+fVNsus8Zks9QYYh2/mh25/z2gDioC2Vl494cR1/z
         HhKw==
X-Gm-Message-State: AOAM532lb9cqsPoreMHQPGal7yqlp1OYuCXQh47rHasAPJHuaJsJgGhe
        9Uu9HDSilMS8pKa5+S9xabXsPA==
X-Google-Smtp-Source: ABdhPJxHf5viVO7L99gU/rJfilt4wroNAMV8CdUQu/TkAVE9VUfroLk5/hxDSgRuQcsMBicEpBB/Bw==
X-Received: by 2002:aa7:d687:: with SMTP id d7mr31615910edr.118.1617089891482;
        Tue, 30 Mar 2021 00:38:11 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id a3sm9556180ejv.40.2021.03.30.00.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 00:38:11 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-rdma@vger.kernel.org, Gioh Kim <gi-oh.kim@ionos.com>
Subject: [PATCHv2 for-next 18/24] block/rnbd-clt: Support polling mode for IO latency optimization
Date:   Tue, 30 Mar 2021 09:37:46 +0200
Message-Id: <20210330073752.1465613-19-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
References: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

RNBD can make double-queues for irq-mode and poll-mode.
For example, on 4-CPU system 8 request-queues are created,
4 for irq-mode and 4 for poll-mode.
If the IO has HIPRI flag, the block-layer will call .poll function
of RNBD. Then IO is sent to the poll-mode queue.
Add optional nr_poll_queues argument for map_devices interface.

To support polling of RNBD, RTRS client creates connections
for both of irq-mode and direct-poll-mode.

For example, on 4-CPU system it could've create 5 connections:
con[0] => user message (softirq cq)
con[1:4] => softirq cq

After this patch, it can create 9 connections:
con[0] => user message (softirq cq)
con[1:4] => softirq cq
con[5:8] => DIRECT-POLL cq

Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: Leon Romanovsky <leonro@nvidia.com>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/block/rnbd/rnbd-clt-sysfs.c    | 56 +++++++++++++----
 drivers/block/rnbd/rnbd-clt.c          | 85 +++++++++++++++++++++++---
 drivers/block/rnbd/rnbd-clt.h          |  5 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 62 +++++++++++++++----
 drivers/infiniband/ulp/rtrs/rtrs-pri.h |  1 +
 drivers/infiniband/ulp/rtrs/rtrs.h     |  3 +-
 6 files changed, 178 insertions(+), 34 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
index 885074f2f734..9ea4da7f894a 100644
--- a/drivers/block/rnbd/rnbd-clt-sysfs.c
+++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
@@ -34,6 +34,7 @@ enum {
 	RNBD_OPT_DEV_PATH	= 1 << 2,
 	RNBD_OPT_ACCESS_MODE	= 1 << 3,
 	RNBD_OPT_SESSNAME	= 1 << 6,
+	RNBD_OPT_NR_POLL_QUEUES	= 1 << 7,
 };
 
 static const unsigned int rnbd_opt_mandatory[] = {
@@ -42,12 +43,13 @@ static const unsigned int rnbd_opt_mandatory[] = {
 };
 
 static const match_table_t rnbd_opt_tokens = {
-	{RNBD_OPT_PATH,		"path=%s"	},
-	{RNBD_OPT_DEV_PATH,	"device_path=%s"},
-	{RNBD_OPT_DEST_PORT,	"dest_port=%d"  },
-	{RNBD_OPT_ACCESS_MODE,	"access_mode=%s"},
-	{RNBD_OPT_SESSNAME,	"sessname=%s"	},
-	{RNBD_OPT_ERR,		NULL		},
+	{RNBD_OPT_PATH,			"path=%s"		},
+	{RNBD_OPT_DEV_PATH,		"device_path=%s"	},
+	{RNBD_OPT_DEST_PORT,		"dest_port=%d"  	},
+	{RNBD_OPT_ACCESS_MODE,		"access_mode=%s"	},
+	{RNBD_OPT_SESSNAME,		"sessname=%s"		},
+	{RNBD_OPT_NR_POLL_QUEUES,	"nr_poll_queues=%d"	},
+	{RNBD_OPT_ERR,			NULL			},
 };
 
 struct rnbd_map_options {
@@ -57,6 +59,7 @@ struct rnbd_map_options {
 	char *pathname;
 	u16 *dest_port;
 	enum rnbd_access_mode *access_mode;
+	u32 *nr_poll_queues;
 };
 
 static int rnbd_clt_parse_map_options(const char *buf, size_t max_path_cnt,
@@ -68,7 +71,7 @@ static int rnbd_clt_parse_map_options(const char *buf, size_t max_path_cnt,
 	int opt_mask = 0;
 	int token;
 	int ret = -EINVAL;
-	int i, dest_port;
+	int i, dest_port, nr_poll_queues;
 	int p_cnt = 0;
 
 	options = kstrdup(buf, GFP_KERNEL);
@@ -178,6 +181,19 @@ static int rnbd_clt_parse_map_options(const char *buf, size_t max_path_cnt,
 			kfree(p);
 			break;
 
+		case RNBD_OPT_NR_POLL_QUEUES:
+			if (match_int(args, &nr_poll_queues) || nr_poll_queues < -1 ||
+			    nr_poll_queues > (int)nr_cpu_ids) {
+				pr_err("bad nr_poll_queues parameter '%d'\n",
+				       nr_poll_queues);
+				ret = -EINVAL;
+				goto out;
+			}
+			if (nr_poll_queues == -1)
+				nr_poll_queues = nr_cpu_ids;
+			*opt->nr_poll_queues = nr_poll_queues;
+			break;
+
 		default:
 			pr_err("map_device: Unknown parameter or missing value '%s'\n",
 			       p);
@@ -227,6 +243,20 @@ static ssize_t state_show(struct kobject *kobj,
 
 static struct kobj_attribute rnbd_clt_state_attr = __ATTR_RO(state);
 
+static ssize_t nr_poll_queues_show(struct kobject *kobj,
+				   struct kobj_attribute *attr, char *page)
+{
+	struct rnbd_clt_dev *dev;
+
+	dev = container_of(kobj, struct rnbd_clt_dev, kobj);
+
+	return snprintf(page, PAGE_SIZE, "%d\n",
+			dev->nr_poll_queues);
+}
+
+static struct kobj_attribute rnbd_clt_nr_poll_queues =
+	__ATTR_RO(nr_poll_queues);
+
 static ssize_t mapping_path_show(struct kobject *kobj,
 				 struct kobj_attribute *attr, char *page)
 {
@@ -421,6 +451,7 @@ static struct attribute *rnbd_dev_attrs[] = {
 	&rnbd_clt_state_attr.attr,
 	&rnbd_clt_session_attr.attr,
 	&rnbd_clt_access_mode.attr,
+	&rnbd_clt_nr_poll_queues.attr,
 	NULL,
 };
 
@@ -469,7 +500,7 @@ static ssize_t rnbd_clt_map_device_show(struct kobject *kobj,
 					 char *page)
 {
 	return scnprintf(page, PAGE_SIZE,
-			 "Usage: echo \"[dest_port=server port number] sessname=<name of the rtrs session> path=<[srcaddr@]dstaddr> [path=<[srcaddr@]dstaddr>] device_path=<full path on remote side> [access_mode=<ro|rw|migration>]\" > %s\n\naddr ::= [ ip:<ipv4> | ip:<ipv6> | gid:<gid> ]\n",
+			 "Usage: echo \"[dest_port=server port number] sessname=<name of the rtrs session> path=<[srcaddr@]dstaddr> [path=<[srcaddr@]dstaddr>] device_path=<full path on remote side> [access_mode=<ro|rw|migration>] [nr_poll_queues=<number of queues>]\" > %s\n\naddr ::= [ ip:<ipv4> | ip:<ipv6> | gid:<gid> ]\n",
 			 attr->attr.name);
 }
 
@@ -541,6 +572,7 @@ static ssize_t rnbd_clt_map_device_store(struct kobject *kobj,
 	char sessname[NAME_MAX];
 	enum rnbd_access_mode access_mode = RNBD_ACCESS_RW;
 	u16 port_nr = RTRS_PORT;
+	u32 nr_poll_queues = 0;
 
 	struct sockaddr_storage *addrs;
 	struct rtrs_addr paths[6];
@@ -552,6 +584,7 @@ static ssize_t rnbd_clt_map_device_store(struct kobject *kobj,
 	opt.pathname = pathname;
 	opt.dest_port = &port_nr;
 	opt.access_mode = &access_mode;
+	opt.nr_poll_queues = &nr_poll_queues;
 	addrs = kcalloc(ARRAY_SIZE(paths) * 2, sizeof(*addrs), GFP_KERNEL);
 	if (!addrs)
 		return -ENOMEM;
@@ -565,12 +598,13 @@ static ssize_t rnbd_clt_map_device_store(struct kobject *kobj,
 	if (ret)
 		goto out;
 
-	pr_info("Mapping device %s on session %s, (access_mode: %s)\n",
+	pr_info("Mapping device %s on session %s, (access_mode: %s, nr_poll_queues: %d)\n",
 		pathname, sessname,
-		rnbd_access_mode_str(access_mode));
+		rnbd_access_mode_str(access_mode),
+		nr_poll_queues);
 
 	dev = rnbd_clt_map_device(sessname, paths, path_cnt, port_nr, pathname,
-				  access_mode);
+				  access_mode, nr_poll_queues);
 	if (IS_ERR(dev)) {
 		ret = PTR_ERR(dev);
 		goto out;
diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 6f955a937f40..998cadd73d47 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1171,9 +1171,54 @@ static blk_status_t rnbd_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return ret;
 }
 
+static int rnbd_rdma_poll(struct blk_mq_hw_ctx *hctx)
+{
+	struct rnbd_queue *q = hctx->driver_data;
+	struct rnbd_clt_dev *dev = q->dev;
+	int cnt;
+
+	cnt = rtrs_clt_rdma_cq_direct(dev->sess->rtrs, hctx->queue_num);
+	return cnt;
+}
+
+static int rnbd_rdma_map_queues(struct blk_mq_tag_set *set)
+{
+	struct rnbd_clt_session *sess = set->driver_data;
+
+	/* shared read/write queues */
+	set->map[HCTX_TYPE_DEFAULT].nr_queues = num_online_cpus();
+	set->map[HCTX_TYPE_DEFAULT].queue_offset = 0;
+	set->map[HCTX_TYPE_READ].nr_queues = num_online_cpus();
+	set->map[HCTX_TYPE_READ].queue_offset = 0;
+	blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
+	blk_mq_map_queues(&set->map[HCTX_TYPE_READ]);
+
+	if (sess->nr_poll_queues) {
+		/* dedicated queue for poll */
+		set->map[HCTX_TYPE_POLL].nr_queues = sess->nr_poll_queues;
+		set->map[HCTX_TYPE_POLL].queue_offset = set->map[HCTX_TYPE_READ].queue_offset +
+			set->map[HCTX_TYPE_READ].nr_queues;
+		blk_mq_map_queues(&set->map[HCTX_TYPE_POLL]);
+		pr_info("[session=%s] mapped %d/%d/%d default/read/poll queues.\n",
+			sess->sessname,
+			set->map[HCTX_TYPE_DEFAULT].nr_queues,
+			set->map[HCTX_TYPE_READ].nr_queues,
+			set->map[HCTX_TYPE_POLL].nr_queues);
+	} else {
+		pr_info("[session=%s] mapped %d/%d default/read queues.\n",
+			sess->sessname,
+			set->map[HCTX_TYPE_DEFAULT].nr_queues,
+			set->map[HCTX_TYPE_READ].nr_queues);
+	}
+
+	return 0;
+}
+
 static struct blk_mq_ops rnbd_mq_ops = {
 	.queue_rq	= rnbd_queue_rq,
 	.complete	= rnbd_softirq_done_fn,
+	.map_queues     = rnbd_rdma_map_queues,
+	.poll           = rnbd_rdma_poll,
 };
 
 static int setup_mq_tags(struct rnbd_clt_session *sess)
@@ -1187,7 +1232,15 @@ static int setup_mq_tags(struct rnbd_clt_session *sess)
 	tag_set->flags		= BLK_MQ_F_SHOULD_MERGE |
 				  BLK_MQ_F_TAG_QUEUE_SHARED;
 	tag_set->cmd_size	= sizeof(struct rnbd_iu) + RNBD_RDMA_SGL_SIZE;
-	tag_set->nr_hw_queues	= num_online_cpus();
+
+	/* for HCTX_TYPE_DEFAULT, HCTX_TYPE_READ, HCTX_TYPE_POLL */
+	tag_set->nr_maps        = sess->nr_poll_queues ? HCTX_MAX_TYPES : 2;
+	/*
+	 * HCTX_TYPE_DEFAULT and HCTX_TYPE_READ share one set of queues
+	 * others are for HCTX_TYPE_POLL
+	 */
+	tag_set->nr_hw_queues	= num_online_cpus() + sess->nr_poll_queues;
+	tag_set->driver_data    = sess;
 
 	return blk_mq_alloc_tag_set(tag_set);
 }
@@ -1195,7 +1248,7 @@ static int setup_mq_tags(struct rnbd_clt_session *sess)
 static struct rnbd_clt_session *
 find_and_get_or_create_sess(const char *sessname,
 			    const struct rtrs_addr *paths,
-			    size_t path_cnt, u16 port_nr)
+			    size_t path_cnt, u16 port_nr, u32 nr_poll_queues)
 {
 	struct rnbd_clt_session *sess;
 	struct rtrs_attrs attrs;
@@ -1204,6 +1257,17 @@ find_and_get_or_create_sess(const char *sessname,
 	struct rtrs_clt_ops rtrs_ops;
 
 	sess = find_or_create_sess(sessname, &first);
+	if (sess == ERR_PTR(-ENOMEM))
+		return ERR_PTR(-ENOMEM);
+	else if ((nr_poll_queues && !first) ||  (!nr_poll_queues && sess->nr_poll_queues)) {
+		/*
+		 * A device MUST have its own session to use the polling-mode.
+		 * It must fail to map new device with the same session.
+		 */
+		err = -EINVAL;
+		goto put_sess;
+	}
+
 	if (!first)
 		return sess;
 
@@ -1225,7 +1289,7 @@ find_and_get_or_create_sess(const char *sessname,
 				   0, /* Do not use pdu of rtrs */
 				   RECONNECT_DELAY, BMAX_SEGMENTS,
 				   BLK_MAX_SEGMENT_SIZE,
-				   MAX_RECONNECTS);
+				   MAX_RECONNECTS, nr_poll_queues);
 	if (IS_ERR(sess->rtrs)) {
 		err = PTR_ERR(sess->rtrs);
 		goto wake_up_and_put;
@@ -1233,6 +1297,7 @@ find_and_get_or_create_sess(const char *sessname,
 	rtrs_clt_query(sess->rtrs, &attrs);
 	sess->max_io_size = attrs.max_io_size;
 	sess->queue_depth = attrs.queue_depth;
+	sess->nr_poll_queues = nr_poll_queues;
 
 	err = setup_mq_tags(sess);
 	if (err)
@@ -1376,7 +1441,8 @@ static int rnbd_client_setup_device(struct rnbd_clt_dev *dev)
 
 static struct rnbd_clt_dev *init_dev(struct rnbd_clt_session *sess,
 				      enum rnbd_access_mode access_mode,
-				      const char *pathname)
+				      const char *pathname,
+				      u32 nr_poll_queues)
 {
 	struct rnbd_clt_dev *dev;
 	int ret;
@@ -1385,7 +1451,8 @@ static struct rnbd_clt_dev *init_dev(struct rnbd_clt_session *sess,
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
 
-	dev->hw_queues = kcalloc(nr_cpu_ids, sizeof(*dev->hw_queues),
+	dev->hw_queues = kcalloc(nr_cpu_ids /* softirq */ + nr_poll_queues /* poll */,
+				 sizeof(*dev->hw_queues),
 				 GFP_KERNEL);
 	if (!dev->hw_queues) {
 		ret = -ENOMEM;
@@ -1411,6 +1478,7 @@ static struct rnbd_clt_dev *init_dev(struct rnbd_clt_session *sess,
 	dev->clt_device_id	= ret;
 	dev->sess		= sess;
 	dev->access_mode	= access_mode;
+	dev->nr_poll_queues	= nr_poll_queues;
 	mutex_init(&dev->lock);
 	refcount_set(&dev->refcount, 1);
 	dev->dev_state = DEV_STATE_INIT;
@@ -1497,7 +1565,8 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 					   struct rtrs_addr *paths,
 					   size_t path_cnt, u16 port_nr,
 					   const char *pathname,
-					   enum rnbd_access_mode access_mode)
+					   enum rnbd_access_mode access_mode,
+					   u32 nr_poll_queues)
 {
 	struct rnbd_clt_session *sess;
 	struct rnbd_clt_dev *dev;
@@ -1506,11 +1575,11 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 	if (unlikely(exists_devpath(pathname, sessname)))
 		return ERR_PTR(-EEXIST);
 
-	sess = find_and_get_or_create_sess(sessname, paths, path_cnt, port_nr);
+	sess = find_and_get_or_create_sess(sessname, paths, path_cnt, port_nr, nr_poll_queues);
 	if (IS_ERR(sess))
 		return ERR_CAST(sess);
 
-	dev = init_dev(sess, access_mode, pathname);
+	dev = init_dev(sess, access_mode, pathname, nr_poll_queues);
 	if (IS_ERR(dev)) {
 		pr_err("map_device: failed to map device '%s' from session %s, can't initialize device, err: %ld\n",
 		       pathname, sess->sessname, PTR_ERR(dev));
diff --git a/drivers/block/rnbd/rnbd-clt.h b/drivers/block/rnbd/rnbd-clt.h
index d2a709f5d7ed..685468ccb178 100644
--- a/drivers/block/rnbd/rnbd-clt.h
+++ b/drivers/block/rnbd/rnbd-clt.h
@@ -90,6 +90,7 @@ struct rnbd_clt_session {
 	int			queue_depth;
 	u32			max_io_size;
 	struct blk_mq_tag_set	tag_set;
+	u32			nr_poll_queues;
 	struct mutex		lock; /* protects state and devs_list */
 	struct list_head        devs_list; /* list of struct rnbd_clt_dev */
 	refcount_t		refcount;
@@ -126,6 +127,7 @@ struct rnbd_clt_dev {
 	enum rnbd_clt_dev_state	dev_state;
 	char			*pathname;
 	enum rnbd_access_mode	access_mode;
+	u32			nr_poll_queues;
 	bool			read_only;
 	bool			rotational;
 	bool			wc;
@@ -156,7 +158,8 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 					   struct rtrs_addr *paths,
 					   size_t path_cnt, u16 port_nr,
 					   const char *pathname,
-					   enum rnbd_access_mode access_mode);
+					   enum rnbd_access_mode access_mode,
+					   u32 nr_poll_queues);
 int rnbd_clt_unmap_device(struct rnbd_clt_dev *dev, bool force,
 			   const struct attribute *sysfs_self);
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 7efd49bdc78c..cf9dbcbc11e7 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -174,7 +174,7 @@ struct rtrs_clt_con *rtrs_permit_to_clt_con(struct rtrs_clt_sess *sess,
 	int id = 0;
 
 	if (likely(permit->con_type == RTRS_IO_CON))
-		id = (permit->cpu_id % (sess->s.con_num - 1)) + 1;
+		id = (permit->cpu_id % (sess->s.irq_con_num - 1)) + 1;
 
 	return to_clt_con(sess->s.con[id]);
 }
@@ -1400,23 +1400,29 @@ static void rtrs_clt_close_work(struct work_struct *work);
 static struct rtrs_clt_sess *alloc_sess(struct rtrs_clt *clt,
 					 const struct rtrs_addr *path,
 					 size_t con_num, u16 max_segments,
-					 size_t max_segment_size)
+					 size_t max_segment_size, u32 nr_poll_queues)
 {
 	struct rtrs_clt_sess *sess;
 	int err = -ENOMEM;
 	int cpu;
+	size_t total_con;
 
 	sess = kzalloc(sizeof(*sess), GFP_KERNEL);
 	if (!sess)
 		goto err;
 
-	/* Extra connection for user messages */
-	con_num += 1;
-
-	sess->s.con = kcalloc(con_num, sizeof(*sess->s.con), GFP_KERNEL);
+	/*
+	 * irqmode and poll
+	 * +1: Extra connection for user messages
+	 */
+	total_con = con_num + nr_poll_queues + 1;
+	sess->s.con = kcalloc(total_con, sizeof(*sess->s.con), GFP_KERNEL);
 	if (!sess->s.con)
 		goto err_free_sess;
 
+	sess->s.con_num = total_con;
+	sess->s.irq_con_num = con_num + 1;
+
 	sess->stats = kzalloc(sizeof(*sess->stats), GFP_KERNEL);
 	if (!sess->stats)
 		goto err_free_con;
@@ -1435,7 +1441,6 @@ static struct rtrs_clt_sess *alloc_sess(struct rtrs_clt *clt,
 		memcpy(&sess->s.src_addr, path->src,
 		       rdma_addr_size((struct sockaddr *)path->src));
 	strlcpy(sess->s.sessname, clt->sessname, sizeof(sess->s.sessname));
-	sess->s.con_num = con_num;
 	sess->clt = clt;
 	sess->max_pages_per_mr = max_segments * max_segment_size >> 12;
 	init_waitqueue_head(&sess->state_wq);
@@ -1576,9 +1581,14 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
 	}
 	cq_size = max_send_wr + max_recv_wr;
 	cq_vector = con->cpu % sess->s.dev->ib_dev->num_comp_vectors;
-	err = rtrs_cq_qp_create(&sess->s, &con->c, sess->max_send_sge,
-				 cq_vector, cq_size, max_send_wr,
-				 max_recv_wr, IB_POLL_SOFTIRQ);
+	if (con->c.cid >= sess->s.irq_con_num)
+		err = rtrs_cq_qp_create(&sess->s, &con->c, sess->max_send_sge,
+					cq_vector, cq_size, max_send_wr,
+					max_recv_wr, IB_POLL_DIRECT);
+	else
+		err = rtrs_cq_qp_create(&sess->s, &con->c, sess->max_send_sge,
+					cq_vector, cq_size, max_send_wr,
+					max_recv_wr, IB_POLL_SOFTIRQ);
 	/*
 	 * In case of error we do not bother to clean previous allocations,
 	 * since destroy_con_cq_qp() must be called.
@@ -2631,6 +2641,7 @@ static void free_clt(struct rtrs_clt *clt)
  * @max_segment_size: Max. size of one segment
  * @max_reconnect_attempts: Number of times to reconnect on error before giving
  *			    up, 0 for * disabled, -1 for forever
+ * @nr_poll_queues: number of polling mode connection using IB_POLL_DIRECT flag
  *
  * Starts session establishment with the rtrs_server. The function can block
  * up to ~2000ms before it returns.
@@ -2644,7 +2655,7 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
 				 size_t pdu_sz, u8 reconnect_delay_sec,
 				 u16 max_segments,
 				 size_t max_segment_size,
-				 s16 max_reconnect_attempts)
+			         s16 max_reconnect_attempts, u32 nr_poll_queues)
 {
 	struct rtrs_clt_sess *sess, *tmp;
 	struct rtrs_clt *clt;
@@ -2662,7 +2673,7 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
 		struct rtrs_clt_sess *sess;
 
 		sess = alloc_sess(clt, &paths[i], nr_cpu_ids,
-				  max_segments, max_segment_size);
+				  max_segments, max_segment_size, nr_poll_queues);
 		if (IS_ERR(sess)) {
 			err = PTR_ERR(sess);
 			goto close_all_sess;
@@ -2887,6 +2898,31 @@ int rtrs_clt_request(int dir, struct rtrs_clt_req_ops *ops,
 }
 EXPORT_SYMBOL(rtrs_clt_request);
 
+int rtrs_clt_rdma_cq_direct(struct rtrs_clt *clt, unsigned int index)
+{
+	int cnt;
+	struct rtrs_con *con;
+	struct rtrs_clt_sess *sess;
+	struct path_it it;
+
+	rcu_read_lock();
+	for (path_it_init(&it, clt);
+	     (sess = it.next_path(&it)) && it.i < it.clt->paths_num; it.i++) {
+		if (unlikely(READ_ONCE(sess->state) != RTRS_CLT_CONNECTED))
+			continue;
+
+		con = sess->s.con[index + 1];
+		cnt = ib_process_cq_direct(con->cq, -1);
+		if (likely(cnt))
+			break;
+	}
+	path_it_deinit(&it);
+	rcu_read_unlock();
+
+	return cnt;
+}
+EXPORT_SYMBOL(rtrs_clt_rdma_cq_direct);
+
 /**
  * rtrs_clt_query() - queries RTRS session attributes
  *@clt: session pointer
@@ -2916,7 +2952,7 @@ int rtrs_clt_create_path_from_sysfs(struct rtrs_clt *clt,
 	int err;
 
 	sess = alloc_sess(clt, addr, nr_cpu_ids, clt->max_segments,
-			  clt->max_segment_size);
+			  clt->max_segment_size, 0);
 	if (IS_ERR(sess))
 		return PTR_ERR(sess);
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
index 8caad0a2322b..00eb45053339 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-pri.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
@@ -101,6 +101,7 @@ struct rtrs_sess {
 	uuid_t			uuid;
 	struct rtrs_con	**con;
 	unsigned int		con_num;
+	unsigned int		irq_con_num;
 	unsigned int		recon_cnt;
 	struct rtrs_ib_dev	*dev;
 	int			dev_ref;
diff --git a/drivers/infiniband/ulp/rtrs/rtrs.h b/drivers/infiniband/ulp/rtrs/rtrs.h
index 2db1b5eb3ab0..eb050738cda1 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs.h
@@ -59,7 +59,7 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
 				 size_t pdu_sz, u8 reconnect_delay_sec,
 				 u16 max_segments,
 				 size_t max_segment_size,
-				 s16 max_reconnect_attempts);
+			         s16 max_reconnect_attempts, u32 nr_poll_queues);
 
 void rtrs_clt_close(struct rtrs_clt *sess);
 
@@ -103,6 +103,7 @@ int rtrs_clt_request(int dir, struct rtrs_clt_req_ops *ops,
 		     struct rtrs_clt *sess, struct rtrs_permit *permit,
 		     const struct kvec *vec, size_t nr, size_t len,
 		     struct scatterlist *sg, unsigned int sg_cnt);
+int rtrs_clt_rdma_cq_direct(struct rtrs_clt *clt, unsigned int index);
 
 /**
  * rtrs_attrs - RTRS session attributes
-- 
2.25.1

