Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30DB1A98A4
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2020 11:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895436AbgDOJXt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Apr 2020 05:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895402AbgDOJXO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Apr 2020 05:23:14 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9679C03C1AA
        for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2020 02:23:10 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id u13so17748189wrp.3
        for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2020 02:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9nBp87L+X8VBvm0OvxCooTkfwd2Mtf1Ivep0a1VQ37I=;
        b=NcW8gdxMks4mTdxBwqUz9N7UFYKJyuIu4c2vJaApKtOMmfdj5ApFuM7aQ7x8Ipse44
         jJVjYzrRgtJqP4dybsMEgJvzpEzREXNir37K/stWgPjsMcwYc4CnXmu5iBRvC5nH3Sqg
         /HKrmNUGCAuk+2+zVt1c7WzzM9EpXSHK7sYslRSrPP9cU04Demu+dEvW6NMil9931Pxu
         BEFvd033POgyzincuzl/eQBFge+efQT8scBAAumZCmsPoSZHzWKp+JwaNkdQjol44Ql+
         ucm8qN1yxskhqKIEDzpruqw+BHyGxRFk1rHIxFa5mRxx4BKvkI6RZi5twIeN0Q7HaiC7
         iCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9nBp87L+X8VBvm0OvxCooTkfwd2Mtf1Ivep0a1VQ37I=;
        b=au1S/JxNSIaiHml7TjrPy5Vt9kU3T3gTmOQLruBPwrnlQtjJ0/TgfUcKO8/RHWNbzF
         BmNesr2PHYUZ2e8FOTTN4bbFeW6qS4zrV3oVpdRW452neI9ASF7c8p+hW42nzdYgTruF
         /UmirN0hdgxrnf34jVpJaQHDNi+mWpU71Oc9Ww0vEhWzW0iZnteEFJQIls+hLc2fvmmY
         XCTMCGKlzLvG2N5+kCiYnHmoxLAD9n2UQLmXM52aZCvsuPS9TudXnm/Y+pV4KsZyufTk
         mBGvyAqy9tLCUIgc92JCo/h75MjSsh/xVaJtKV0K5cfKpWQyzOugeuUQxTf+rf5HZ4sx
         pAdQ==
X-Gm-Message-State: AGi0PuZGFfTnrb+mMPtdrQpG9loIg+BV9wkHXBC0yzf5oUndoq+XiyoJ
        DPGDeQehaVc0fuhTfTdmU49J
X-Google-Smtp-Source: APiQypLiEVx6nPC47p952xNnqvB+BPvf9Zu1Tpx9e2+sBKf8TAKO0GzVndVtuCyMSlJA8JWOLOwxXg==
X-Received: by 2002:adf:fecd:: with SMTP id q13mr20015293wrs.12.1586942589185;
        Wed, 15 Apr 2020 02:23:09 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-231-072.002.204.pools.vodafone-ip.de. [2.204.231.72])
        by smtp.gmail.com with ESMTPSA id v7sm22534615wmg.3.2020.04.15.02.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 02:23:08 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: [PATCH v12 20/25] block/rnbd: server: main functionality
Date:   Wed, 15 Apr 2020 11:20:40 +0200
Message-Id: <20200415092045.4729-21-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
References: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

This is main functionality of rnbd-server module, which handles RTRS
events and rnbd protocol requests, like map (open) or unmap (close)
device.  Also server side is responsible for processing incoming IBTRS
IO requests and forward them to local mapped devices.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-srv.c | 861 ++++++++++++++++++++++++++++++++++
 1 file changed, 861 insertions(+)
 create mode 100644 drivers/block/rnbd/rnbd-srv.c

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
new file mode 100644
index 000000000000..2fc2dafcbd9d
--- /dev/null
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -0,0 +1,861 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * RDMA Network Block Driver
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
+ */
+#undef pr_fmt
+#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
+
+#include <linux/module.h>
+#include <linux/blkdev.h>
+
+#include "rnbd-srv.h"
+#include "rnbd-srv-dev.h"
+
+MODULE_DESCRIPTION("RDMA Network Block Device Server");
+MODULE_LICENSE("GPL");
+
+static u16 port_nr = RTRS_PORT;
+
+module_param_named(port_nr, port_nr, ushort, 0444);
+MODULE_PARM_DESC(port_nr,
+		 "The port number the server is listening on (default: "
+		 __stringify(RTRS_PORT)")");
+
+#define DEFAULT_DEV_SEARCH_PATH "/"
+
+static char dev_search_path[PATH_MAX] = DEFAULT_DEV_SEARCH_PATH;
+
+static int dev_search_path_set(const char *val, const struct kernel_param *kp)
+{
+	const char *p = strrchr(val, '\n') ? : val + strlen(val);
+
+	if (strlen(val) >= sizeof(dev_search_path))
+		return -EINVAL;
+
+	snprintf(dev_search_path, sizeof(dev_search_path), "%.*s",
+		 (int)(p - val), val);
+
+	pr_info("dev_search_path changed to '%s'\n", dev_search_path);
+
+	return 0;
+}
+
+static struct kparam_string dev_search_path_kparam_str = {
+	.maxlen	= sizeof(dev_search_path),
+	.string	= dev_search_path
+};
+
+static const struct kernel_param_ops dev_search_path_ops = {
+	.set	= dev_search_path_set,
+	.get	= param_get_string,
+};
+
+module_param_cb(dev_search_path, &dev_search_path_ops,
+		&dev_search_path_kparam_str, 0444);
+MODULE_PARM_DESC(dev_search_path,
+		 "Sets the dev_search_path. When a device is mapped this path is prepended to the device path from the map device operation.  If %SESSNAME% is specified in a path, then device will be searched in a session namespace. (default: "
+		 DEFAULT_DEV_SEARCH_PATH ")");
+
+static DEFINE_MUTEX(sess_lock);
+static DEFINE_SPINLOCK(dev_lock);
+
+static LIST_HEAD(sess_list);
+static LIST_HEAD(dev_list);
+
+struct rnbd_io_private {
+	struct rtrs_srv_op		*id;
+	struct rnbd_srv_sess_dev	*sess_dev;
+};
+
+static void rnbd_sess_dev_release(struct kref *kref)
+{
+	struct rnbd_srv_sess_dev *sess_dev;
+
+	sess_dev = container_of(kref, struct rnbd_srv_sess_dev, kref);
+	complete(sess_dev->destroy_comp);
+}
+
+static inline void rnbd_put_sess_dev(struct rnbd_srv_sess_dev *sess_dev)
+{
+	kref_put(&sess_dev->kref, rnbd_sess_dev_release);
+}
+
+void rnbd_endio(void *priv, int error)
+{
+	struct rnbd_io_private *rnbd_priv = priv;
+	struct rnbd_srv_sess_dev *sess_dev = rnbd_priv->sess_dev;
+
+	rnbd_put_sess_dev(sess_dev);
+
+	rtrs_srv_resp_rdma(rnbd_priv->id, error);
+
+	kfree(priv);
+}
+
+static struct rnbd_srv_sess_dev *
+rnbd_get_sess_dev(int dev_id, struct rnbd_srv_session *srv_sess)
+{
+	struct rnbd_srv_sess_dev *sess_dev;
+	int ret = 0;
+
+	rcu_read_lock();
+	sess_dev = idr_find(&srv_sess->index_idr, dev_id);
+	if (likely(sess_dev))
+		ret = kref_get_unless_zero(&sess_dev->kref);
+	rcu_read_unlock();
+
+	if (!sess_dev || !ret)
+		return ERR_PTR(-ENXIO);
+
+	return sess_dev;
+}
+
+static int process_rdma(struct rtrs_srv *sess,
+			struct rnbd_srv_session *srv_sess,
+			struct rtrs_srv_op *id, void *data, u32 datalen,
+			const void *usr, size_t usrlen)
+{
+	const struct rnbd_msg_io *msg = usr;
+	struct rnbd_io_private *priv;
+	struct rnbd_srv_sess_dev *sess_dev;
+	u32 dev_id;
+	int err;
+
+	priv = kmalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	dev_id = le32_to_cpu(msg->device_id);
+
+	sess_dev = rnbd_get_sess_dev(dev_id, srv_sess);
+	if (IS_ERR(sess_dev)) {
+		pr_err_ratelimited("Got I/O request on session %s for unknown device id %d\n",
+				   srv_sess->sessname, dev_id);
+		err = -ENOTCONN;
+		goto err;
+	}
+
+	priv->sess_dev = sess_dev;
+	priv->id = id;
+
+	err = rnbd_dev_submit_io(sess_dev->rnbd_dev, le64_to_cpu(msg->sector),
+				  data, datalen, le32_to_cpu(msg->bi_size),
+				  le32_to_cpu(msg->rw),
+				  srv_sess->ver < RNBD_PROTO_VER_MAJOR ||
+				  usrlen < sizeof(*msg) ?
+				  0 : le16_to_cpu(msg->prio), priv);
+	if (unlikely(err)) {
+		rnbd_srv_err(sess_dev, "Submitting I/O to device failed, err: %d\n",
+			      err);
+		goto sess_dev_put;
+	}
+
+	return 0;
+
+sess_dev_put:
+	rnbd_put_sess_dev(sess_dev);
+err:
+	kfree(priv);
+	return err;
+}
+
+static void destroy_device(struct rnbd_srv_dev *dev)
+{
+	WARN_ONCE(!list_empty(&dev->sess_dev_list),
+		  "Device %s is being destroyed but still in use!\n",
+		  dev->id);
+
+	spin_lock(&dev_lock);
+	list_del(&dev->list);
+	spin_unlock(&dev_lock);
+
+	mutex_destroy(&dev->lock);
+	if (dev->dev_kobj.state_in_sysfs)
+		/*
+		 * Destroy kobj only if it was really created.
+		 */
+		rnbd_srv_destroy_dev_sysfs(dev);
+	else
+		kfree(dev);
+}
+
+static void destroy_device_cb(struct kref *kref)
+{
+	struct rnbd_srv_dev *dev;
+
+	dev = container_of(kref, struct rnbd_srv_dev, kref);
+
+	destroy_device(dev);
+}
+
+static void rnbd_put_srv_dev(struct rnbd_srv_dev *dev)
+{
+	kref_put(&dev->kref, destroy_device_cb);
+}
+
+void rnbd_destroy_sess_dev(struct rnbd_srv_sess_dev *sess_dev)
+{
+	DECLARE_COMPLETION_ONSTACK(dc);
+
+	spin_lock(&sess_dev->sess->index_lock);
+	idr_remove(&sess_dev->sess->index_idr, sess_dev->device_id);
+	spin_unlock(&sess_dev->sess->index_lock);
+	synchronize_rcu();
+	sess_dev->destroy_comp = &dc;
+	rnbd_put_sess_dev(sess_dev);
+	wait_for_completion(&dc); /* wait for inflights to drop to zero */
+
+	rnbd_dev_close(sess_dev->rnbd_dev);
+	list_del(&sess_dev->sess_list);
+	mutex_lock(&sess_dev->dev->lock);
+	list_del(&sess_dev->dev_list);
+	if (sess_dev->open_flags & FMODE_WRITE)
+		sess_dev->dev->open_write_cnt--;
+	mutex_unlock(&sess_dev->dev->lock);
+
+	rnbd_put_srv_dev(sess_dev->dev);
+
+	rnbd_srv_info(sess_dev, "Device closed\n");
+	kfree(sess_dev);
+}
+
+static void destroy_sess(struct rnbd_srv_session *srv_sess)
+{
+	struct rnbd_srv_sess_dev *sess_dev, *tmp;
+
+	if (list_empty(&srv_sess->sess_dev_list))
+		goto out;
+
+	mutex_lock(&srv_sess->lock);
+	list_for_each_entry_safe(sess_dev, tmp, &srv_sess->sess_dev_list,
+				 sess_list)
+		rnbd_srv_destroy_dev_session_sysfs(sess_dev);
+	mutex_unlock(&srv_sess->lock);
+
+out:
+	idr_destroy(&srv_sess->index_idr);
+	bioset_exit(&srv_sess->sess_bio_set);
+
+	pr_info("RTRS Session %s disconnected\n", srv_sess->sessname);
+
+	mutex_lock(&sess_lock);
+	list_del(&srv_sess->list);
+	mutex_unlock(&sess_lock);
+
+	mutex_destroy(&srv_sess->lock);
+	kfree(srv_sess);
+}
+
+static int create_sess(struct rtrs_srv *rtrs)
+{
+	struct rnbd_srv_session *srv_sess;
+	char sessname[NAME_MAX];
+	int err;
+
+	err = rtrs_srv_get_sess_name(rtrs, sessname, sizeof(sessname));
+	if (err) {
+		pr_err("rtrs_srv_get_sess_name(%s): %d\n", sessname, err);
+
+		return err;
+	}
+	srv_sess = kzalloc(sizeof(*srv_sess), GFP_KERNEL);
+	if (!srv_sess)
+		return -ENOMEM;
+
+	srv_sess->queue_depth = rtrs_srv_get_queue_depth(rtrs);
+	err = bioset_init(&srv_sess->sess_bio_set, srv_sess->queue_depth,
+			  offsetof(struct rnbd_dev_blk_io, bio),
+			  BIOSET_NEED_BVECS);
+	if (err) {
+		pr_err("Allocating srv_session for session %s failed\n",
+		       sessname);
+		kfree(srv_sess);
+		return err;
+	}
+
+	idr_init(&srv_sess->index_idr);
+	spin_lock_init(&srv_sess->index_lock);
+	INIT_LIST_HEAD(&srv_sess->sess_dev_list);
+	mutex_init(&srv_sess->lock);
+	mutex_lock(&sess_lock);
+	list_add(&srv_sess->list, &sess_list);
+	mutex_unlock(&sess_lock);
+
+	srv_sess->rtrs = rtrs;
+	strlcpy(srv_sess->sessname, sessname, sizeof(srv_sess->sessname));
+
+	rtrs_srv_set_sess_priv(rtrs, srv_sess);
+
+	return 0;
+}
+
+static int rnbd_srv_link_ev(struct rtrs_srv *rtrs,
+			     enum rtrs_srv_link_ev ev, void *priv)
+{
+	struct rnbd_srv_session *srv_sess = priv;
+
+	switch (ev) {
+	case RTRS_SRV_LINK_EV_CONNECTED:
+		return create_sess(rtrs);
+
+	case RTRS_SRV_LINK_EV_DISCONNECTED:
+		if (WARN_ON_ONCE(!srv_sess))
+			return -EINVAL;
+
+		destroy_sess(srv_sess);
+		return 0;
+
+	default:
+		pr_warn("Received unknown RTRS session event %d from session %s\n",
+			ev, srv_sess->sessname);
+		return -EINVAL;
+	}
+}
+
+static int process_msg_close(struct rtrs_srv *rtrs,
+			     struct rnbd_srv_session *srv_sess,
+			     void *data, size_t datalen, const void *usr,
+			     size_t usrlen)
+{
+	const struct rnbd_msg_close *close_msg = usr;
+	struct rnbd_srv_sess_dev *sess_dev;
+
+	sess_dev = rnbd_get_sess_dev(le32_to_cpu(close_msg->device_id),
+				      srv_sess);
+	if (IS_ERR(sess_dev))
+		return 0;
+
+	rnbd_put_sess_dev(sess_dev);
+	mutex_lock(&srv_sess->lock);
+	rnbd_srv_destroy_dev_session_sysfs(sess_dev);
+	mutex_unlock(&srv_sess->lock);
+	return 0;
+}
+
+static int process_msg_open(struct rtrs_srv *rtrs,
+			    struct rnbd_srv_session *srv_sess,
+			    const void *msg, size_t len,
+			    void *data, size_t datalen);
+
+static int process_msg_sess_info(struct rtrs_srv *rtrs,
+				 struct rnbd_srv_session *srv_sess,
+				 const void *msg, size_t len,
+				 void *data, size_t datalen);
+
+static int rnbd_srv_rdma_ev(struct rtrs_srv *rtrs, void *priv,
+			     struct rtrs_srv_op *id, int dir,
+			     void *data, size_t datalen, const void *usr,
+			     size_t usrlen)
+{
+	struct rnbd_srv_session *srv_sess = priv;
+	const struct rnbd_msg_hdr *hdr = usr;
+	int ret = 0;
+	u16 type;
+
+	if (WARN_ON_ONCE(!srv_sess))
+		return -ENODEV;
+
+	type = le16_to_cpu(hdr->type);
+
+	switch (type) {
+	case RNBD_MSG_IO:
+		return process_rdma(rtrs, srv_sess, id, data, datalen, usr,
+				    usrlen);
+	case RNBD_MSG_CLOSE:
+		ret = process_msg_close(rtrs, srv_sess, data, datalen,
+					usr, usrlen);
+		break;
+	case RNBD_MSG_OPEN:
+		ret = process_msg_open(rtrs, srv_sess, usr, usrlen,
+				       data, datalen);
+		break;
+	case RNBD_MSG_SESS_INFO:
+		ret = process_msg_sess_info(rtrs, srv_sess, usr, usrlen,
+					    data, datalen);
+		break;
+	default:
+		pr_warn("Received unexpected message type %d with dir %d from session %s\n",
+			type, dir, srv_sess->sessname);
+		return -EINVAL;
+	}
+
+	rtrs_srv_resp_rdma(id, ret);
+	return 0;
+}
+
+static struct rnbd_srv_sess_dev
+*rnbd_sess_dev_alloc(struct rnbd_srv_session *srv_sess)
+{
+	struct rnbd_srv_sess_dev *sess_dev;
+	int error;
+
+	sess_dev = kzalloc(sizeof(*sess_dev), GFP_KERNEL);
+	if (!sess_dev)
+		return ERR_PTR(-ENOMEM);
+
+	idr_preload(GFP_KERNEL);
+	spin_lock(&srv_sess->index_lock);
+
+	error = idr_alloc(&srv_sess->index_idr, sess_dev, 0, -1, GFP_NOWAIT);
+	if (error < 0) {
+		pr_warn("Allocating idr failed, err: %d\n", error);
+		goto out_unlock;
+	}
+
+	sess_dev->device_id = error;
+	error = 0;
+
+out_unlock:
+	spin_unlock(&srv_sess->index_lock);
+	idr_preload_end();
+	if (error) {
+		kfree(sess_dev);
+		return ERR_PTR(error);
+	}
+
+	return sess_dev;
+}
+
+static struct rnbd_srv_dev *rnbd_srv_init_srv_dev(const char *id)
+{
+	struct rnbd_srv_dev *dev;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return ERR_PTR(-ENOMEM);
+
+	strlcpy(dev->id, id, sizeof(dev->id));
+	kref_init(&dev->kref);
+	INIT_LIST_HEAD(&dev->sess_dev_list);
+	mutex_init(&dev->lock);
+
+	return dev;
+}
+
+static struct rnbd_srv_dev *
+rnbd_srv_find_or_add_srv_dev(struct rnbd_srv_dev *new_dev)
+{
+	struct rnbd_srv_dev *dev;
+
+	spin_lock(&dev_lock);
+	list_for_each_entry(dev, &dev_list, list) {
+		if (!strncmp(dev->id, new_dev->id, sizeof(dev->id))) {
+			if (!kref_get_unless_zero(&dev->kref))
+				/*
+				 * We lost the race, device is almost dead.
+				 *  Continue traversing to find a valid one.
+				 */
+				continue;
+			spin_unlock(&dev_lock);
+			return dev;
+		}
+	}
+	list_add(&new_dev->list, &dev_list);
+	spin_unlock(&dev_lock);
+
+	return new_dev;
+}
+
+static int rnbd_srv_check_update_open_perm(struct rnbd_srv_dev *srv_dev,
+					    struct rnbd_srv_session *srv_sess,
+					    enum rnbd_access_mode access_mode)
+{
+	int ret = -EPERM;
+
+	mutex_lock(&srv_dev->lock);
+
+	switch (access_mode) {
+	case RNBD_ACCESS_RO:
+		ret = 0;
+		break;
+	case RNBD_ACCESS_RW:
+		if (srv_dev->open_write_cnt == 0)  {
+			srv_dev->open_write_cnt++;
+			ret = 0;
+		} else {
+			pr_err("Mapping device '%s' for session %s with RW permissions failed. Device already opened as 'RW' by %d client(s), access mode %s.\n",
+			       srv_dev->id, srv_sess->sessname,
+			       srv_dev->open_write_cnt,
+			       rnbd_access_mode_str(access_mode));
+		}
+		break;
+	case RNBD_ACCESS_MIGRATION:
+		if (srv_dev->open_write_cnt < 2) {
+			srv_dev->open_write_cnt++;
+			ret = 0;
+		} else {
+			pr_err("Mapping device '%s' for session %s with migration permissions failed. Device already opened as 'RW' by %d client(s), access mode %s.\n",
+			       srv_dev->id, srv_sess->sessname,
+			       srv_dev->open_write_cnt,
+			       rnbd_access_mode_str(access_mode));
+		}
+		break;
+	default:
+		pr_err("Received mapping request for device '%s' on session %s with invalid access mode: %d\n",
+		       srv_dev->id, srv_sess->sessname, access_mode);
+		ret = -EINVAL;
+	}
+
+	mutex_unlock(&srv_dev->lock);
+
+	return ret;
+}
+
+static struct rnbd_srv_dev *
+rnbd_srv_get_or_create_srv_dev(struct rnbd_dev *rnbd_dev,
+				struct rnbd_srv_session *srv_sess,
+				enum rnbd_access_mode access_mode)
+{
+	int ret;
+	struct rnbd_srv_dev *new_dev, *dev;
+
+	new_dev = rnbd_srv_init_srv_dev(rnbd_dev->name);
+	if (IS_ERR(new_dev))
+		return new_dev;
+
+	dev = rnbd_srv_find_or_add_srv_dev(new_dev);
+	if (dev != new_dev)
+		kfree(new_dev);
+
+	ret = rnbd_srv_check_update_open_perm(dev, srv_sess, access_mode);
+	if (ret) {
+		rnbd_put_srv_dev(dev);
+		return ERR_PTR(ret);
+	}
+
+	return dev;
+}
+
+static void rnbd_srv_fill_msg_open_rsp(struct rnbd_msg_open_rsp *rsp,
+					struct rnbd_srv_sess_dev *sess_dev)
+{
+	struct rnbd_dev *rnbd_dev = sess_dev->rnbd_dev;
+
+	rsp->hdr.type = cpu_to_le16(RNBD_MSG_OPEN_RSP);
+	rsp->device_id =
+		cpu_to_le32(sess_dev->device_id);
+	rsp->nsectors =
+		cpu_to_le64(get_capacity(rnbd_dev->bdev->bd_disk));
+	rsp->logical_block_size	=
+		cpu_to_le16(bdev_logical_block_size(rnbd_dev->bdev));
+	rsp->physical_block_size =
+		cpu_to_le16(bdev_physical_block_size(rnbd_dev->bdev));
+	rsp->max_segments =
+		cpu_to_le16(rnbd_dev_get_max_segs(rnbd_dev));
+	rsp->max_hw_sectors =
+		cpu_to_le32(rnbd_dev_get_max_hw_sects(rnbd_dev));
+	rsp->max_write_same_sectors =
+		cpu_to_le32(bdev_write_same(rnbd_dev->bdev));
+	rsp->max_discard_sectors =
+		cpu_to_le32(rnbd_dev_get_max_discard_sects(rnbd_dev));
+	rsp->discard_granularity =
+		cpu_to_le32(rnbd_dev_get_discard_granularity(rnbd_dev));
+	rsp->discard_alignment =
+		cpu_to_le32(rnbd_dev_get_discard_alignment(rnbd_dev));
+	rsp->secure_discard =
+		cpu_to_le16(rnbd_dev_get_secure_discard(rnbd_dev));
+	rsp->rotational =
+		!blk_queue_nonrot(bdev_get_queue(rnbd_dev->bdev));
+}
+
+static struct rnbd_srv_sess_dev *
+rnbd_srv_create_set_sess_dev(struct rnbd_srv_session *srv_sess,
+			      const struct rnbd_msg_open *open_msg,
+			      struct rnbd_dev *rnbd_dev, fmode_t open_flags,
+			      struct rnbd_srv_dev *srv_dev)
+{
+	struct rnbd_srv_sess_dev *sdev = rnbd_sess_dev_alloc(srv_sess);
+
+	if (IS_ERR(sdev))
+		return sdev;
+
+	kref_init(&sdev->kref);
+
+	strlcpy(sdev->pathname, open_msg->dev_name, sizeof(sdev->pathname));
+
+	sdev->rnbd_dev		= rnbd_dev;
+	sdev->sess		= srv_sess;
+	sdev->dev		= srv_dev;
+	sdev->open_flags	= open_flags;
+	sdev->access_mode	= open_msg->access_mode;
+
+	return sdev;
+}
+
+static char *rnbd_srv_get_full_path(struct rnbd_srv_session *srv_sess,
+				     const char *dev_name)
+{
+	char *full_path;
+	char *a, *b;
+
+	full_path = kmalloc(PATH_MAX, GFP_KERNEL);
+	if (!full_path)
+		return ERR_PTR(-ENOMEM);
+
+	/*
+	 * Replace %SESSNAME% with a real session name in order to
+	 * create device namespace.
+	 */
+	a = strnstr(dev_search_path, "%SESSNAME%", sizeof(dev_search_path));
+	if (a) {
+		int len = a - dev_search_path;
+
+		len = snprintf(full_path, PATH_MAX, "%.*s/%s/%s", len,
+			       dev_search_path, srv_sess->sessname, dev_name);
+		if (len >= PATH_MAX) {
+			pr_err("Too long path: %s, %s, %s\n",
+			       dev_search_path, srv_sess->sessname, dev_name);
+			kfree(full_path);
+			return ERR_PTR(-EINVAL);
+		}
+	} else {
+		snprintf(full_path, PATH_MAX, "%s/%s",
+			 dev_search_path, dev_name);
+	}
+
+	/* eliminitate duplicated slashes */
+	a = strchr(full_path, '/');
+	b = a;
+	while (*b != '\0') {
+		if (*b == '/' && *a == '/') {
+			b++;
+		} else {
+			a++;
+			*a = *b;
+			b++;
+		}
+	}
+	a++;
+	*a = '\0';
+
+	return full_path;
+}
+
+static int process_msg_sess_info(struct rtrs_srv *rtrs,
+				 struct rnbd_srv_session *srv_sess,
+				 const void *msg, size_t len,
+				 void *data, size_t datalen)
+{
+	const struct rnbd_msg_sess_info *sess_info_msg = msg;
+	struct rnbd_msg_sess_info_rsp *rsp = data;
+
+	srv_sess->ver = min_t(u8, sess_info_msg->ver, RNBD_PROTO_VER_MAJOR);
+	pr_debug("Session %s using protocol version %d (client version: %d, server version: %d)\n",
+		 srv_sess->sessname, srv_sess->ver,
+		 sess_info_msg->ver, RNBD_PROTO_VER_MAJOR);
+
+	rsp->hdr.type = cpu_to_le16(RNBD_MSG_SESS_INFO_RSP);
+	rsp->ver = srv_sess->ver;
+
+	return 0;
+}
+
+/**
+ * find_srv_sess_dev() - a dev is already opened by this name
+ * @srv_sess:	the session to search.
+ * @dev_name:	string containing the name of the device.
+ *
+ * Return struct rnbd_srv_sess_dev if srv_sess already opened the dev_name
+ * NULL if the session didn't open the device yet.
+ */
+static struct rnbd_srv_sess_dev *
+find_srv_sess_dev(struct rnbd_srv_session *srv_sess, const char *dev_name)
+{
+	struct rnbd_srv_sess_dev *sess_dev;
+
+	if (list_empty(&srv_sess->sess_dev_list))
+		return NULL;
+
+	list_for_each_entry(sess_dev, &srv_sess->sess_dev_list, sess_list)
+		if (!strcmp(sess_dev->pathname, dev_name))
+			return sess_dev;
+
+	return NULL;
+}
+
+static int process_msg_open(struct rtrs_srv *rtrs,
+			    struct rnbd_srv_session *srv_sess,
+			    const void *msg, size_t len,
+			    void *data, size_t datalen)
+{
+	int ret;
+	struct rnbd_srv_dev *srv_dev;
+	struct rnbd_srv_sess_dev *srv_sess_dev;
+	const struct rnbd_msg_open *open_msg = msg;
+	fmode_t open_flags;
+	char *full_path;
+	struct rnbd_dev *rnbd_dev;
+	struct rnbd_msg_open_rsp *rsp = data;
+
+	pr_debug("Open message received: session='%s' path='%s' access_mode=%d\n",
+		 srv_sess->sessname, open_msg->dev_name,
+		 open_msg->access_mode);
+	open_flags = FMODE_READ;
+	if (open_msg->access_mode != RNBD_ACCESS_RO)
+		open_flags |= FMODE_WRITE;
+
+	mutex_lock(&srv_sess->lock);
+
+	srv_sess_dev = find_srv_sess_dev(srv_sess, open_msg->dev_name);
+	if (srv_sess_dev)
+		goto fill_response;
+
+	if ((strlen(dev_search_path) + strlen(open_msg->dev_name))
+	    >= PATH_MAX) {
+		pr_err("Opening device for session %s failed, device path too long. '%s/%s' is longer than PATH_MAX (%d)\n",
+		       srv_sess->sessname, dev_search_path, open_msg->dev_name,
+		       PATH_MAX);
+		ret = -EINVAL;
+		goto reject;
+	}
+	if (strstr(open_msg->dev_name, "..")) {
+		pr_err("Opening device for session %s failed, device path %s contains relative path ..\n",
+		       srv_sess->sessname, open_msg->dev_name);
+		ret = -EINVAL;
+		goto reject;
+	}
+	full_path = rnbd_srv_get_full_path(srv_sess, open_msg->dev_name);
+	if (IS_ERR(full_path)) {
+		ret = PTR_ERR(full_path);
+		pr_err("Opening device '%s' for client %s failed, failed to get device full path, err: %d\n",
+		       open_msg->dev_name, srv_sess->sessname, ret);
+		goto reject;
+	}
+
+	rnbd_dev = rnbd_dev_open(full_path, open_flags,
+				 &srv_sess->sess_bio_set);
+	if (IS_ERR(rnbd_dev)) {
+		pr_err("Opening device '%s' on session %s failed, failed to open the block device, err: %ld\n",
+		       full_path, srv_sess->sessname, PTR_ERR(rnbd_dev));
+		ret = PTR_ERR(rnbd_dev);
+		goto free_path;
+	}
+
+	srv_dev = rnbd_srv_get_or_create_srv_dev(rnbd_dev, srv_sess,
+						  open_msg->access_mode);
+	if (IS_ERR(srv_dev)) {
+		pr_err("Opening device '%s' on session %s failed, creating srv_dev failed, err: %ld\n",
+		       full_path, srv_sess->sessname, PTR_ERR(srv_dev));
+		ret = PTR_ERR(srv_dev);
+		goto rnbd_dev_close;
+	}
+
+	srv_sess_dev = rnbd_srv_create_set_sess_dev(srv_sess, open_msg,
+						     rnbd_dev, open_flags,
+						     srv_dev);
+	if (IS_ERR(srv_sess_dev)) {
+		pr_err("Opening device '%s' on session %s failed, creating sess_dev failed, err: %ld\n",
+		       full_path, srv_sess->sessname, PTR_ERR(srv_sess_dev));
+		ret = PTR_ERR(srv_sess_dev);
+		goto srv_dev_put;
+	}
+
+	/* Create the srv_dev sysfs files if they haven't been created yet. The
+	 * reason to delay the creation is not to create the sysfs files before
+	 * we are sure the device can be opened.
+	 */
+	mutex_lock(&srv_dev->lock);
+	if (!srv_dev->dev_kobj.state_in_sysfs) {
+		ret = rnbd_srv_create_dev_sysfs(srv_dev, rnbd_dev->bdev,
+						 rnbd_dev->name);
+		if (ret) {
+			mutex_unlock(&srv_dev->lock);
+			rnbd_srv_err(srv_sess_dev,
+				      "Opening device failed, failed to create device sysfs files, err: %d\n",
+				      ret);
+			goto free_srv_sess_dev;
+		}
+	}
+
+	ret = rnbd_srv_create_dev_session_sysfs(srv_sess_dev);
+	if (ret) {
+		mutex_unlock(&srv_dev->lock);
+		rnbd_srv_err(srv_sess_dev,
+			      "Opening device failed, failed to create dev client sysfs files, err: %d\n",
+			      ret);
+		goto free_srv_sess_dev;
+	}
+
+	list_add(&srv_sess_dev->dev_list, &srv_dev->sess_dev_list);
+	mutex_unlock(&srv_dev->lock);
+
+	list_add(&srv_sess_dev->sess_list, &srv_sess->sess_dev_list);
+
+	rnbd_srv_info(srv_sess_dev, "Opened device '%s'\n", srv_dev->id);
+
+	kfree(full_path);
+
+fill_response:
+	rnbd_srv_fill_msg_open_rsp(rsp, srv_sess_dev);
+	mutex_unlock(&srv_sess->lock);
+	return 0;
+
+free_srv_sess_dev:
+	spin_lock(&srv_sess->index_lock);
+	idr_remove(&srv_sess->index_idr, srv_sess_dev->device_id);
+	spin_unlock(&srv_sess->index_lock);
+	synchronize_rcu();
+	kfree(srv_sess_dev);
+srv_dev_put:
+	if (open_msg->access_mode != RNBD_ACCESS_RO) {
+		mutex_lock(&srv_dev->lock);
+		srv_dev->open_write_cnt--;
+		mutex_unlock(&srv_dev->lock);
+	}
+	rnbd_put_srv_dev(srv_dev);
+rnbd_dev_close:
+	rnbd_dev_close(rnbd_dev);
+free_path:
+	kfree(full_path);
+reject:
+	mutex_unlock(&srv_sess->lock);
+	return ret;
+}
+
+static struct rtrs_srv_ctx *rtrs_ctx;
+
+static struct rtrs_srv_ops rtrs_ops;
+static int __init rnbd_srv_init_module(void)
+{
+	int err;
+
+	BUILD_BUG_ON(sizeof(struct rnbd_msg_hdr) != 4);
+	BUILD_BUG_ON(sizeof(struct rnbd_msg_sess_info) != 36);
+	BUILD_BUG_ON(sizeof(struct rnbd_msg_sess_info_rsp) != 36);
+	BUILD_BUG_ON(sizeof(struct rnbd_msg_open) != 264);
+	BUILD_BUG_ON(sizeof(struct rnbd_msg_close) != 8);
+	BUILD_BUG_ON(sizeof(struct rnbd_msg_open_rsp) != 56);
+	rtrs_ops = (struct rtrs_srv_ops) {
+		.rdma_ev = rnbd_srv_rdma_ev,
+		.link_ev = rnbd_srv_link_ev,
+	};
+	rtrs_ctx = rtrs_srv_open(&rtrs_ops, port_nr);
+	if (IS_ERR(rtrs_ctx)) {
+		err = PTR_ERR(rtrs_ctx);
+		pr_err("rtrs_srv_open(), err: %d\n", err);
+		return err;
+	}
+
+	err = rnbd_srv_create_sysfs_files();
+	if (err) {
+		pr_err("rnbd_srv_create_sysfs_files(), err: %d\n", err);
+		rtrs_srv_close(rtrs_ctx);
+		return err;
+	}
+
+	return 0;
+}
+
+static void __exit rnbd_srv_cleanup_module(void)
+{
+	rtrs_srv_close(rtrs_ctx);
+	WARN_ON(!list_empty(&sess_list));
+	rnbd_srv_destroy_sysfs_files();
+}
+
+module_init(rnbd_srv_init_module);
+module_exit(rnbd_srv_cleanup_module);
-- 
2.20.1

