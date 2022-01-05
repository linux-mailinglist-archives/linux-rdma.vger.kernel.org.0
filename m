Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE144857EF
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 19:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242737AbiAESHR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 13:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242736AbiAESHR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jan 2022 13:07:17 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D0AC061245
        for <linux-rdma@vger.kernel.org>; Wed,  5 Jan 2022 10:07:16 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id z29so165265109edl.7
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jan 2022 10:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ExNswYIeB618IOORclQ5mVYhgIjcoCxPNG+mEOpRyLc=;
        b=gZN9JLFy7Zw/Px5CRShF1sQ2NO+JuUnMd9U1haDYf5RXVwOmcLHx9+7US9DbD4FBuz
         iFKEjXhIZFnypfVfAS3WdX1P2z24p6uQY9Jc+yMtycfb5ZRvpWMm3mnIpirRrkTKjZ1r
         +zCdJyTsdul6JbbLbQn4Prl2eGme09gSbAkPtFHqKbDX1lWiehfu7Lhlw9ep5ZzxSSuA
         hwpK7eOV56olyrfseE59q8CqJph3aIU+n6G5ynl2Hj/4iq/6LKnS7d6ZfJ3tCt0/OHy4
         tkot2aCXGdT9Att2JZEtSylH7V+CmeOVXeTdOyvou8VD1LOjAwSpBggOvjpvk/DN/IxP
         N3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ExNswYIeB618IOORclQ5mVYhgIjcoCxPNG+mEOpRyLc=;
        b=kqPknzVomEgzxuSuBfPXx6Bc3zgBRbOGcMskNde/2pz92xfQmn6cO0/YFtsBCWZCSt
         Kq8UhN9BNhdJvKwZ/wVGTdjYqUL1h72qmGsfU8zQSGYBL2Ghfbv0CmW/WOXF173/9cqh
         k9kzP6zE2asRK1kWdorXIORvUAxJvQvhSHHWzljndDXpo+21wSDbzhxDZvn6EqKcLM2H
         5jY8fcz+zK1iAdybm74RUTbETVgHfEIRxYQ7BghiBhDjKy76nFTzQk4B9kbJQUfybrFh
         O/Wc1i5hIjuI7TLJ7iNZgJ5ye6oJR23Ql0/T5VQ4xMLB+lg4YTt9IkMUq9i/uDctxs6v
         X0bA==
X-Gm-Message-State: AOAM533dFSKD4Thvs6h5HG4WXnyXEcToJ7TLO43RY5Bc6gvjq3j1g7UT
        Akgr61rBjAjr23zhqOnYdGJ+EcKtQvGK8g==
X-Google-Smtp-Source: ABdhPJwG3uJJ61byY7zxBAOo9cYsueQYTYdirsXKtCc30v0Tm14HRg5eeRuwh2a/Bn3BJwmxpp5DEw==
X-Received: by 2002:a05:6402:27cf:: with SMTP id c15mr48951110ede.390.1641406034668;
        Wed, 05 Jan 2022 10:07:14 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4592:200:545c:cb34:8a20:aae1])
        by smtp.gmail.com with ESMTPSA id eg12sm15970910edb.25.2022.01.05.10.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 10:07:14 -0800 (PST)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        vaishali.thakkar@ionos.com, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com
Subject: [PATCHv3 for-next 5/5] RDMA/rtrs-clt: Rename rtrs_clt to rtrs_clt_sess
Date:   Wed,  5 Jan 2022 19:07:08 +0100
Message-Id: <20220105180708.7774-6-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220105180708.7774-1-jinpu.wang@ionos.com>
References: <20220105180708.7774-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Vaishali Thakkar <vaishali.thakkar@ionos.com>

Structure rtrs_clt is used for sessions. So to
avoid confusions rename it to rtrs_clt_sess.

Transformations are done with the help of
following coccinelle script.

@@
@@
struct
- rtrs_clt
+ rtrs_clt_sess

Signed-off-by: Vaishali Thakkar <vaishali.thakkar@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
Changes since v2:
    - fix the variable name in rtrs_clt_close
---
 drivers/block/rnbd/rnbd-clt.c                |  4 +-
 drivers/block/rnbd/rnbd-clt.h                |  2 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c | 24 +++---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c       | 78 ++++++++++----------
 drivers/infiniband/ulp/rtrs/rtrs-clt.h       | 19 ++---
 drivers/infiniband/ulp/rtrs/rtrs.h           | 21 +++---
 6 files changed, 77 insertions(+), 71 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 2df0657cdf00..70bbbdb81db1 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -433,7 +433,7 @@ static void msg_conf(void *priv, int errno)
 	schedule_work(&iu->work);
 }
 
-static int send_usr_msg(struct rtrs_clt *rtrs, int dir,
+static int send_usr_msg(struct rtrs_clt_sess *rtrs, int dir,
 			struct rnbd_iu *iu, struct kvec *vec,
 			size_t len, struct scatterlist *sg, unsigned int sg_len,
 			void (*conf)(struct work_struct *work),
@@ -1010,7 +1010,7 @@ static int rnbd_client_xfer_request(struct rnbd_clt_dev *dev,
 				     struct request *rq,
 				     struct rnbd_iu *iu)
 {
-	struct rtrs_clt *rtrs = dev->sess->rtrs;
+	struct rtrs_clt_sess *rtrs = dev->sess->rtrs;
 	struct rtrs_permit *permit = iu->permit;
 	struct rnbd_msg_io msg;
 	struct rtrs_clt_req_ops req_ops;
diff --git a/drivers/block/rnbd/rnbd-clt.h b/drivers/block/rnbd/rnbd-clt.h
index 9ef8c4f306f2..0c2cae7f39b9 100644
--- a/drivers/block/rnbd/rnbd-clt.h
+++ b/drivers/block/rnbd/rnbd-clt.h
@@ -75,7 +75,7 @@ struct rnbd_cpu_qlist {
 
 struct rnbd_clt_session {
 	struct list_head        list;
-	struct rtrs_clt        *rtrs;
+	struct rtrs_clt_sess        *rtrs;
 	wait_queue_head_t       rtrs_waitq;
 	bool                    rtrs_ready;
 	struct rnbd_cpu_qlist	__percpu
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
index 834f6d30487c..b4fa473b7888 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c
@@ -50,7 +50,8 @@ static ssize_t max_reconnect_attempts_show(struct device *dev,
 					   struct device_attribute *attr,
 					   char *page)
 {
-	struct rtrs_clt *clt = container_of(dev, struct rtrs_clt, dev);
+	struct rtrs_clt_sess *clt = container_of(dev, struct rtrs_clt_sess,
+						 dev);
 
 	return sysfs_emit(page, "%d\n",
 			  rtrs_clt_get_max_reconnect_attempts(clt));
@@ -63,7 +64,8 @@ static ssize_t max_reconnect_attempts_store(struct device *dev,
 {
 	int value;
 	int ret;
-	struct rtrs_clt *clt  = container_of(dev, struct rtrs_clt, dev);
+	struct rtrs_clt_sess *clt  = container_of(dev, struct rtrs_clt_sess,
+						  dev);
 
 	ret = kstrtoint(buf, 10, &value);
 	if (ret) {
@@ -90,9 +92,9 @@ static ssize_t mpath_policy_show(struct device *dev,
 				 struct device_attribute *attr,
 				 char *page)
 {
-	struct rtrs_clt *clt;
+	struct rtrs_clt_sess *clt;
 
-	clt = container_of(dev, struct rtrs_clt, dev);
+	clt = container_of(dev, struct rtrs_clt_sess, dev);
 
 	switch (clt->mp_policy) {
 	case MP_POLICY_RR:
@@ -114,12 +116,12 @@ static ssize_t mpath_policy_store(struct device *dev,
 				  const char *buf,
 				  size_t count)
 {
-	struct rtrs_clt *clt;
+	struct rtrs_clt_sess *clt;
 	int value;
 	int ret;
 	size_t len = 0;
 
-	clt = container_of(dev, struct rtrs_clt, dev);
+	clt = container_of(dev, struct rtrs_clt_sess, dev);
 
 	ret = kstrtoint(buf, 10, &value);
 	if (!ret && (value == MP_POLICY_RR ||
@@ -169,12 +171,12 @@ static ssize_t add_path_store(struct device *dev,
 		.src = &srcaddr,
 		.dst = &dstaddr
 	};
-	struct rtrs_clt *clt;
+	struct rtrs_clt_sess *clt;
 	const char *nl;
 	size_t len;
 	int err;
 
-	clt = container_of(dev, struct rtrs_clt, dev);
+	clt = container_of(dev, struct rtrs_clt_sess, dev);
 
 	nl = strchr(buf, '\n');
 	if (nl)
@@ -425,7 +427,7 @@ static const struct attribute_group rtrs_clt_path_attr_group = {
 
 int rtrs_clt_create_path_files(struct rtrs_clt_path *clt_path)
 {
-	struct rtrs_clt *clt = clt_path->clt;
+	struct rtrs_clt_sess *clt = clt_path->clt;
 	char str[NAME_MAX];
 	int err;
 	struct rtrs_addr path = {
@@ -497,12 +499,12 @@ static const struct attribute_group rtrs_clt_attr_group = {
 	.attrs = rtrs_clt_attrs,
 };
 
-int rtrs_clt_create_sysfs_root_files(struct rtrs_clt *clt)
+int rtrs_clt_create_sysfs_root_files(struct rtrs_clt_sess *clt)
 {
 	return sysfs_create_group(&clt->dev.kobj, &rtrs_clt_attr_group);
 }
 
-void rtrs_clt_destroy_sysfs_root(struct rtrs_clt *clt)
+void rtrs_clt_destroy_sysfs_root(struct rtrs_clt_sess *clt)
 {
 	sysfs_remove_group(&clt->dev.kobj, &rtrs_clt_attr_group);
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 3215b6659ca6..7c3f98e57889 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -46,7 +46,7 @@ static struct rtrs_rdma_dev_pd dev_pd = {
 static struct workqueue_struct *rtrs_wq;
 static struct class *rtrs_clt_dev_class;
 
-static inline bool rtrs_clt_is_connected(const struct rtrs_clt *clt)
+static inline bool rtrs_clt_is_connected(const struct rtrs_clt_sess *clt)
 {
 	struct rtrs_clt_path *clt_path;
 	bool connected = false;
@@ -60,7 +60,7 @@ static inline bool rtrs_clt_is_connected(const struct rtrs_clt *clt)
 }
 
 static struct rtrs_permit *
-__rtrs_get_permit(struct rtrs_clt *clt, enum rtrs_clt_con_type con_type)
+__rtrs_get_permit(struct rtrs_clt_sess *clt, enum rtrs_clt_con_type con_type)
 {
 	size_t max_depth = clt->queue_depth;
 	struct rtrs_permit *permit;
@@ -87,7 +87,7 @@ __rtrs_get_permit(struct rtrs_clt *clt, enum rtrs_clt_con_type con_type)
 	return permit;
 }
 
-static inline void __rtrs_put_permit(struct rtrs_clt *clt,
+static inline void __rtrs_put_permit(struct rtrs_clt_sess *clt,
 				      struct rtrs_permit *permit)
 {
 	clear_bit_unlock(permit->mem_id, clt->permits_map);
@@ -107,7 +107,7 @@ static inline void __rtrs_put_permit(struct rtrs_clt *clt,
  * Context:
  *    Can sleep if @wait == RTRS_PERMIT_WAIT
  */
-struct rtrs_permit *rtrs_clt_get_permit(struct rtrs_clt *clt,
+struct rtrs_permit *rtrs_clt_get_permit(struct rtrs_clt_sess *clt,
 					  enum rtrs_clt_con_type con_type,
 					  enum wait_type can_wait)
 {
@@ -142,7 +142,8 @@ EXPORT_SYMBOL(rtrs_clt_get_permit);
  * Context:
  *    Does not matter
  */
-void rtrs_clt_put_permit(struct rtrs_clt *clt, struct rtrs_permit *permit)
+void rtrs_clt_put_permit(struct rtrs_clt_sess *clt,
+			 struct rtrs_permit *permit)
 {
 	if (WARN_ON(!test_bit(permit->mem_id, clt->permits_map)))
 		return;
@@ -303,7 +304,7 @@ static void rtrs_rdma_error_recovery(struct rtrs_clt_con *con)
 	if (rtrs_clt_change_state_from_to(clt_path,
 					   RTRS_CLT_CONNECTED,
 					   RTRS_CLT_RECONNECTING)) {
-		struct rtrs_clt *clt = clt_path->clt;
+		struct rtrs_clt_sess *clt = clt_path->clt;
 		unsigned int delay_ms;
 
 		/*
@@ -743,7 +744,7 @@ static int post_recv_path(struct rtrs_clt_path *clt_path)
 struct path_it {
 	int i;
 	struct list_head skip_list;
-	struct rtrs_clt *clt;
+	struct rtrs_clt_sess *clt;
 	struct rtrs_clt_path *(*next_path)(struct path_it *it);
 };
 
@@ -780,7 +781,7 @@ static struct rtrs_clt_path *get_next_path_rr(struct path_it *it)
 {
 	struct rtrs_clt_path __rcu **ppcpu_path;
 	struct rtrs_clt_path *path;
-	struct rtrs_clt *clt;
+	struct rtrs_clt_sess *clt;
 
 	clt = it->clt;
 
@@ -817,7 +818,7 @@ static struct rtrs_clt_path *get_next_path_rr(struct path_it *it)
 static struct rtrs_clt_path *get_next_path_min_inflight(struct path_it *it)
 {
 	struct rtrs_clt_path *min_path = NULL;
-	struct rtrs_clt *clt = it->clt;
+	struct rtrs_clt_sess *clt = it->clt;
 	struct rtrs_clt_path *clt_path;
 	int min_inflight = INT_MAX;
 	int inflight;
@@ -868,7 +869,7 @@ static struct rtrs_clt_path *get_next_path_min_inflight(struct path_it *it)
 static struct rtrs_clt_path *get_next_path_min_latency(struct path_it *it)
 {
 	struct rtrs_clt_path *min_path = NULL;
-	struct rtrs_clt *clt = it->clt;
+	struct rtrs_clt_sess *clt = it->clt;
 	struct rtrs_clt_path *clt_path;
 	ktime_t min_latency = KTIME_MAX;
 	ktime_t latency;
@@ -898,7 +899,7 @@ static struct rtrs_clt_path *get_next_path_min_latency(struct path_it *it)
 	return min_path;
 }
 
-static inline void path_it_init(struct path_it *it, struct rtrs_clt *clt)
+static inline void path_it_init(struct path_it *it, struct rtrs_clt_sess *clt)
 {
 	INIT_LIST_HEAD(&it->skip_list);
 	it->clt = clt;
@@ -1281,7 +1282,7 @@ static int rtrs_clt_read_req(struct rtrs_clt_io_req *req)
  * @clt: clt context
  * @fail_req: a failed io request.
  */
-static int rtrs_clt_failover_req(struct rtrs_clt *clt,
+static int rtrs_clt_failover_req(struct rtrs_clt_sess *clt,
 				 struct rtrs_clt_io_req *fail_req)
 {
 	struct rtrs_clt_path *alive_path;
@@ -1316,7 +1317,7 @@ static int rtrs_clt_failover_req(struct rtrs_clt *clt,
 
 static void fail_all_outstanding_reqs(struct rtrs_clt_path *clt_path)
 {
-	struct rtrs_clt *clt = clt_path->clt;
+	struct rtrs_clt_sess *clt = clt_path->clt;
 	struct rtrs_clt_io_req *req;
 	int i, err;
 
@@ -1405,7 +1406,7 @@ static int alloc_path_reqs(struct rtrs_clt_path *clt_path)
 	return err;
 }
 
-static int alloc_permits(struct rtrs_clt *clt)
+static int alloc_permits(struct rtrs_clt_sess *clt)
 {
 	unsigned int chunk_bits;
 	int err, i;
@@ -1439,7 +1440,7 @@ static int alloc_permits(struct rtrs_clt *clt)
 	return err;
 }
 
-static void free_permits(struct rtrs_clt *clt)
+static void free_permits(struct rtrs_clt_sess *clt)
 {
 	if (clt->permits_map) {
 		size_t sz = clt->queue_depth;
@@ -1510,7 +1511,7 @@ static void rtrs_clt_init_hb(struct rtrs_clt_path *clt_path)
 static void rtrs_clt_reconnect_work(struct work_struct *work);
 static void rtrs_clt_close_work(struct work_struct *work);
 
-static struct rtrs_clt_path *alloc_path(struct rtrs_clt *clt,
+static struct rtrs_clt_path *alloc_path(struct rtrs_clt_sess *clt,
 					const struct rtrs_addr *path,
 					size_t con_num, u32 nr_poll_queues)
 {
@@ -1775,7 +1776,7 @@ static int rtrs_rdma_addr_resolved(struct rtrs_clt_con *con)
 static int rtrs_rdma_route_resolved(struct rtrs_clt_con *con)
 {
 	struct rtrs_clt_path *clt_path = to_clt_path(con->c.path);
-	struct rtrs_clt *clt = clt_path->clt;
+	struct rtrs_clt_sess *clt = clt_path->clt;
 	struct rtrs_msg_conn_req msg;
 	struct rdma_conn_param param;
 
@@ -1810,7 +1811,7 @@ static int rtrs_rdma_conn_established(struct rtrs_clt_con *con,
 				       struct rdma_cm_event *ev)
 {
 	struct rtrs_clt_path *clt_path = to_clt_path(con->c.path);
-	struct rtrs_clt *clt = clt_path->clt;
+	struct rtrs_clt_sess *clt = clt_path->clt;
 	const struct rtrs_msg_conn_rsp *msg;
 	u16 version, queue_depth;
 	int errno;
@@ -2100,7 +2101,7 @@ static int create_cm(struct rtrs_clt_con *con)
 
 static void rtrs_clt_path_up(struct rtrs_clt_path *clt_path)
 {
-	struct rtrs_clt *clt = clt_path->clt;
+	struct rtrs_clt_sess *clt = clt_path->clt;
 	int up;
 
 	/*
@@ -2131,7 +2132,7 @@ static void rtrs_clt_path_up(struct rtrs_clt_path *clt_path)
 
 static void rtrs_clt_path_down(struct rtrs_clt_path *clt_path)
 {
-	struct rtrs_clt *clt = clt_path->clt;
+	struct rtrs_clt_sess *clt = clt_path->clt;
 
 	if (!clt_path->established)
 		return;
@@ -2220,7 +2221,7 @@ static inline bool xchg_paths(struct rtrs_clt_path __rcu **rcu_ppcpu_path,
 
 static void rtrs_clt_remove_path_from_arr(struct rtrs_clt_path *clt_path)
 {
-	struct rtrs_clt *clt = clt_path->clt;
+	struct rtrs_clt_sess *clt = clt_path->clt;
 	struct rtrs_clt_path *next;
 	bool wait_for_grace = false;
 	int cpu;
@@ -2310,7 +2311,7 @@ static void rtrs_clt_remove_path_from_arr(struct rtrs_clt_path *clt_path)
 
 static void rtrs_clt_add_path_to_arr(struct rtrs_clt_path *clt_path)
 {
-	struct rtrs_clt *clt = clt_path->clt;
+	struct rtrs_clt_sess *clt = clt_path->clt;
 
 	mutex_lock(&clt->paths_mutex);
 	clt->paths_num++;
@@ -2636,7 +2637,7 @@ static int init_path(struct rtrs_clt_path *clt_path)
 static void rtrs_clt_reconnect_work(struct work_struct *work)
 {
 	struct rtrs_clt_path *clt_path;
-	struct rtrs_clt *clt;
+	struct rtrs_clt_sess *clt;
 	unsigned int delay_ms;
 	int err;
 
@@ -2678,19 +2679,20 @@ static void rtrs_clt_reconnect_work(struct work_struct *work)
 
 static void rtrs_clt_dev_release(struct device *dev)
 {
-	struct rtrs_clt *clt = container_of(dev, struct rtrs_clt, dev);
+	struct rtrs_clt_sess *clt = container_of(dev, struct rtrs_clt_sess,
+						 dev);
 
 	kfree(clt);
 }
 
-static struct rtrs_clt *alloc_clt(const char *sessname, size_t paths_num,
+static struct rtrs_clt_sess *alloc_clt(const char *sessname, size_t paths_num,
 				  u16 port, size_t pdu_sz, void *priv,
 				  void	(*link_ev)(void *priv,
 						   enum rtrs_clt_link_ev ev),
 				  unsigned int reconnect_delay_sec,
 				  unsigned int max_reconnect_attempts)
 {
-	struct rtrs_clt *clt;
+	struct rtrs_clt_sess *clt;
 	int err;
 
 	if (!paths_num || paths_num > MAX_PATHS_NUM)
@@ -2765,7 +2767,7 @@ static struct rtrs_clt *alloc_clt(const char *sessname, size_t paths_num,
 	return ERR_PTR(err);
 }
 
-static void free_clt(struct rtrs_clt *clt)
+static void free_clt(struct rtrs_clt_sess *clt)
 {
 	free_permits(clt);
 	free_percpu(clt->pcpu_path);
@@ -2793,7 +2795,7 @@ static void free_clt(struct rtrs_clt *clt)
  *
  * Return a valid pointer on success otherwise PTR_ERR.
  */
-struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
+struct rtrs_clt_sess *rtrs_clt_open(struct rtrs_clt_ops *ops,
 				 const char *pathname,
 				 const struct rtrs_addr *paths,
 				 size_t paths_num, u16 port,
@@ -2801,7 +2803,7 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
 				 s16 max_reconnect_attempts, u32 nr_poll_queues)
 {
 	struct rtrs_clt_path *clt_path, *tmp;
-	struct rtrs_clt *clt;
+	struct rtrs_clt_sess *clt;
 	int err, i;
 
 	if (strchr(pathname, '/') || strchr(pathname, '.')) {
@@ -2875,7 +2877,7 @@ EXPORT_SYMBOL(rtrs_clt_open);
  * rtrs_clt_close() - Close a path
  * @clt: Session handle. Session is freed upon return.
  */
-void rtrs_clt_close(struct rtrs_clt *clt)
+void rtrs_clt_close(struct rtrs_clt_sess *clt)
 {
 	struct rtrs_clt_path *clt_path, *tmp;
 
@@ -2950,12 +2952,12 @@ int rtrs_clt_remove_path_from_sysfs(struct rtrs_clt_path *clt_path,
 	return 0;
 }
 
-void rtrs_clt_set_max_reconnect_attempts(struct rtrs_clt *clt, int value)
+void rtrs_clt_set_max_reconnect_attempts(struct rtrs_clt_sess *clt, int value)
 {
 	clt->max_reconnect_attempts = (unsigned int)value;
 }
 
-int rtrs_clt_get_max_reconnect_attempts(const struct rtrs_clt *clt)
+int rtrs_clt_get_max_reconnect_attempts(const struct rtrs_clt_sess *clt)
 {
 	return (int)clt->max_reconnect_attempts;
 }
@@ -2985,9 +2987,9 @@ int rtrs_clt_get_max_reconnect_attempts(const struct rtrs_clt *clt)
  * On dir=WRITE rtrs client will rdma write data in sg to server side.
  */
 int rtrs_clt_request(int dir, struct rtrs_clt_req_ops *ops,
-		     struct rtrs_clt *clt, struct rtrs_permit *permit,
-		      const struct kvec *vec, size_t nr, size_t data_len,
-		      struct scatterlist *sg, unsigned int sg_cnt)
+		     struct rtrs_clt_sess *clt, struct rtrs_permit *permit,
+		     const struct kvec *vec, size_t nr, size_t data_len,
+		     struct scatterlist *sg, unsigned int sg_cnt)
 {
 	struct rtrs_clt_io_req *req;
 	struct rtrs_clt_path *clt_path;
@@ -3045,7 +3047,7 @@ int rtrs_clt_request(int dir, struct rtrs_clt_req_ops *ops,
 }
 EXPORT_SYMBOL(rtrs_clt_request);
 
-int rtrs_clt_rdma_cq_direct(struct rtrs_clt *clt, unsigned int index)
+int rtrs_clt_rdma_cq_direct(struct rtrs_clt_sess *clt, unsigned int index)
 {
 	/* If no path, return -1 for block layer not to try again */
 	int cnt = -1;
@@ -3079,7 +3081,7 @@ EXPORT_SYMBOL(rtrs_clt_rdma_cq_direct);
  *    0 on success
  *    -ECOMM		no connection to the server
  */
-int rtrs_clt_query(struct rtrs_clt *clt, struct rtrs_attrs *attr)
+int rtrs_clt_query(struct rtrs_clt_sess *clt, struct rtrs_attrs *attr)
 {
 	if (!rtrs_clt_is_connected(clt))
 		return -ECOMM;
@@ -3094,7 +3096,7 @@ int rtrs_clt_query(struct rtrs_clt *clt, struct rtrs_attrs *attr)
 }
 EXPORT_SYMBOL(rtrs_clt_query);
 
-int rtrs_clt_create_path_from_sysfs(struct rtrs_clt *clt,
+int rtrs_clt_create_path_from_sysfs(struct rtrs_clt_sess *clt,
 				     struct rtrs_addr *addr)
 {
 	struct rtrs_clt_path *clt_path;
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.h b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
index 899ea6e36462..d1b18a154ae0 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
@@ -126,7 +126,7 @@ struct rtrs_rbuf {
 
 struct rtrs_clt_path {
 	struct rtrs_path	s;
-	struct rtrs_clt	*clt;
+	struct rtrs_clt_sess	*clt;
 	wait_queue_head_t	state_wq;
 	enum rtrs_clt_state	state;
 	atomic_t		connected_cnt;
@@ -153,7 +153,7 @@ struct rtrs_clt_path {
 				*mp_skip_entry;
 };
 
-struct rtrs_clt {
+struct rtrs_clt_sess {
 	struct list_head	paths_list; /* rcu protected list */
 	size_t			paths_num;
 	struct rtrs_clt_path
@@ -191,25 +191,26 @@ static inline struct rtrs_clt_path *to_clt_path(struct rtrs_path *s)
 	return container_of(s, struct rtrs_clt_path, s);
 }
 
-static inline int permit_size(struct rtrs_clt *clt)
+static inline int permit_size(struct rtrs_clt_sess *clt)
 {
 	return sizeof(struct rtrs_permit) + clt->pdu_sz;
 }
 
-static inline struct rtrs_permit *get_permit(struct rtrs_clt *clt, int idx)
+static inline struct rtrs_permit *get_permit(struct rtrs_clt_sess *clt,
+					     int idx)
 {
 	return (struct rtrs_permit *)(clt->permits + permit_size(clt) * idx);
 }
 
 int rtrs_clt_reconnect_from_sysfs(struct rtrs_clt_path *path);
 void rtrs_clt_close_conns(struct rtrs_clt_path *clt_path, bool wait);
-int rtrs_clt_create_path_from_sysfs(struct rtrs_clt *clt,
+int rtrs_clt_create_path_from_sysfs(struct rtrs_clt_sess *clt,
 				     struct rtrs_addr *addr);
 int rtrs_clt_remove_path_from_sysfs(struct rtrs_clt_path *path,
 				     const struct attribute *sysfs_self);
 
-void rtrs_clt_set_max_reconnect_attempts(struct rtrs_clt *clt, int value);
-int rtrs_clt_get_max_reconnect_attempts(const struct rtrs_clt *clt);
+void rtrs_clt_set_max_reconnect_attempts(struct rtrs_clt_sess *clt, int value);
+int rtrs_clt_get_max_reconnect_attempts(const struct rtrs_clt_sess *clt);
 void free_path(struct rtrs_clt_path *clt_path);
 
 /* rtrs-clt-stats.c */
@@ -239,8 +240,8 @@ ssize_t rtrs_clt_reset_all_help(struct rtrs_clt_stats *stats,
 
 /* rtrs-clt-sysfs.c */
 
-int rtrs_clt_create_sysfs_root_files(struct rtrs_clt *clt);
-void rtrs_clt_destroy_sysfs_root(struct rtrs_clt *clt);
+int rtrs_clt_create_sysfs_root_files(struct rtrs_clt_sess *clt);
+void rtrs_clt_destroy_sysfs_root(struct rtrs_clt_sess *clt);
 
 int rtrs_clt_create_path_files(struct rtrs_clt_path *clt_path);
 void rtrs_clt_destroy_path_files(struct rtrs_clt_path *clt_path,
diff --git a/drivers/infiniband/ulp/rtrs/rtrs.h b/drivers/infiniband/ulp/rtrs/rtrs.h
index eeb238f3012e..5e57a7ccc7fb 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs.h
@@ -13,7 +13,7 @@
 #include <linux/scatterlist.h>
 
 struct rtrs_permit;
-struct rtrs_clt;
+struct rtrs_clt_sess;
 struct rtrs_srv_ctx;
 struct rtrs_srv_sess;
 struct rtrs_srv_op;
@@ -52,14 +52,14 @@ struct rtrs_clt_ops {
 	void	(*link_ev)(void *priv, enum rtrs_clt_link_ev ev);
 };
 
-struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
+struct rtrs_clt_sess *rtrs_clt_open(struct rtrs_clt_ops *ops,
 				 const char *pathname,
 				 const struct rtrs_addr *paths,
 				 size_t path_cnt, u16 port,
 				 size_t pdu_sz, u8 reconnect_delay_sec,
 				 s16 max_reconnect_attempts, u32 nr_poll_queues);
 
-void rtrs_clt_close(struct rtrs_clt *clt_path);
+void rtrs_clt_close(struct rtrs_clt_sess *clt);
 
 enum wait_type {
 	RTRS_PERMIT_NOWAIT = 0,
@@ -77,11 +77,12 @@ enum rtrs_clt_con_type {
 	RTRS_IO_CON
 };
 
-struct rtrs_permit *rtrs_clt_get_permit(struct rtrs_clt *sess,
-				    enum rtrs_clt_con_type con_type,
-				    enum wait_type wait);
+struct rtrs_permit *rtrs_clt_get_permit(struct rtrs_clt_sess *sess,
+					enum rtrs_clt_con_type con_type,
+					enum wait_type wait);
 
-void rtrs_clt_put_permit(struct rtrs_clt *sess, struct rtrs_permit *permit);
+void rtrs_clt_put_permit(struct rtrs_clt_sess *sess,
+			 struct rtrs_permit *permit);
 
 /**
  * rtrs_clt_req_ops - it holds the request confirmation callback
@@ -98,10 +99,10 @@ struct rtrs_clt_req_ops {
 };
 
 int rtrs_clt_request(int dir, struct rtrs_clt_req_ops *ops,
-		     struct rtrs_clt *sess, struct rtrs_permit *permit,
+		     struct rtrs_clt_sess *sess, struct rtrs_permit *permit,
 		     const struct kvec *vec, size_t nr, size_t len,
 		     struct scatterlist *sg, unsigned int sg_cnt);
-int rtrs_clt_rdma_cq_direct(struct rtrs_clt *clt, unsigned int index);
+int rtrs_clt_rdma_cq_direct(struct rtrs_clt_sess *clt, unsigned int index);
 
 /**
  * rtrs_attrs - RTRS session attributes
@@ -112,7 +113,7 @@ struct rtrs_attrs {
 	u32		max_segments;
 };
 
-int rtrs_clt_query(struct rtrs_clt *sess, struct rtrs_attrs *attr);
+int rtrs_clt_query(struct rtrs_clt_sess *sess, struct rtrs_attrs *attr);
 
 /*
  * Here goes RTRS server API
-- 
2.25.1

