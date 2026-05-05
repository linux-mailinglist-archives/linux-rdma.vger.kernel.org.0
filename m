Return-Path: <linux-rdma+bounces-19990-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UB5CBDyh+WnR+QIAu9opvQ
	(envelope-from <linux-rdma+bounces-19990-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 09:50:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2424C83E0
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 09:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39C5A307EF56
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 07:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E7F3E929C;
	Tue,  5 May 2026 07:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="cl+La32j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1623D5677
	for <linux-rdma@vger.kernel.org>; Tue,  5 May 2026 07:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777967235; cv=none; b=Mko6a5iqt8Bu7cS07TqPQnsgtumZG9ePDa+z/NV9bH6SzNrVykbto7mY9/EZRq8Ku3MHsygJHnQHAI2zm5SPMcygELUN1pRiIGhDREcuej/1t/urjwRyk34zYYYJkBctqE9PC7AaWe32JEca26PWHV6zf6qOiMiflTxKzN6MUL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777967235; c=relaxed/simple;
	bh=jHJ+dSXBjqGkDbwNmqoTz4ErnG0ao3qSSWKzWCbyiUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tQoPdCHJpUYPKwX35yLDvC2WBW6ZBNN4TwuOXHt/nmVgB4AGvJsYcLjkJuySvp2Oi3blAgO2EcWYrek2fnkBQeOHMqf8RGvK39ujXgrhWYZ7jC6XL99DMR7Wv7x3Rhs62MSg3DpOh2h+t3DvdEQmeWzP2HHmXri87lzb2Gzn6RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=cl+La32j; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43fe3e22e33so2730755f8f.0
        for <linux-rdma@vger.kernel.org>; Tue, 05 May 2026 00:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1777967230; x=1778572030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcHMma6IpCs5+MUqGzW2FmMV5Un3jStGMQxdTnoWqEQ=;
        b=cl+La32jv8N0AkVHPCypoLCO641ecHzV0l//jUNY8cQ4jhtXoTe58wBRXlc75lwXIl
         pJE0SfMEc9YBfc61rxko578chK80nb8BlOt3P3hONH1/fmWH0+kvULncuU8rDMmzvaFX
         jI2B9ZNRz+zPwPaILayNlPfAAtPJMEbh6IpIozxHWzbw32n+K1KT109urOiUYiqra+Zz
         ABlAMs2srxN0pQgYTnzRDGvTDbn+vHz0dtfcd3QPexfu84DSFISt1c24p3ZuJjHBrEvq
         nnZSKGQSfk2NuJdIkW7xecyBPfpsMl540H9eNsfoIakxOiFdICrVU8OcaCfH8Slh7cCa
         4uzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777967230; x=1778572030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LcHMma6IpCs5+MUqGzW2FmMV5Un3jStGMQxdTnoWqEQ=;
        b=PhrY/eS90wuJdNz0za7y5TckzU55GrZzsXdgdFP9ti1xmHNDEfM+qqjWCU4X8dYegn
         wdXnID3ffjnUbDroi/+9SKJURucyA9fzrxXEisl9wKoI5rVhmXq1HwKlL6yuaSba4cKw
         pHxfUfTBkr7E7izTMnC3u7/uEWXatqkmyHh1h88Sjv71Hky5nE1NKD+nALPi4rlUMe2G
         yNbDM9uANT8dTz/nIww6bEPnpbzV5PzRnAid6GyLI/0lhNudpWm5UbCdefH0J0NHIm2q
         Q7Skj1+XCfcCewXPUqZCVwXoZC1er7oTKdmrXZ0WIPQQfcxoK8Rx9q+qRer+nW26A/lr
         8dvA==
X-Forwarded-Encrypted: i=1; AFNElJ8XNfw6l+j8TO3l5fBmj9eYm+teWxZD4+aFDCIOHCmm+pD7lYWYQIly0JdHeAiuxYS1YHugOI9A0eLa@vger.kernel.org
X-Gm-Message-State: AOJu0YzTc5atXwtxGu7rDal474bgv9xYM0OyGT85HgYx2YqC6kx4jKmT
	xLMTNLCqXABH4izCYlnHq9AxBC5vCw3rgM+QX5zdtZN7pj2Yv4Gc9LwQKXbmI3bg4S8=
X-Gm-Gg: AeBDieshjMMA4COd3TfMCDc4J0O5flY3k5aLldyaYgY8QvU0lgsejoMbD+SicB+UKON
	HxFuc1lCLVgnFI377tMNTRwREVH+XNAPRQPa/9jK5FYXQIk4CWHf9VLlNmCFBw5n9oqyWvpwKUi
	s16mH047t83/w5kJU/1+CNBfuWbnE0k+aP22m4GF84vGozwQe/B7Sug07o0OU/j81IhJoZ+ioKc
	ZoMB9rTk+6jKVAUCIzAYx17Iebk7xoAMzEvPivUklzLbaWgLnXu8ju22+VAP0K1Vkp4K9mD1vNL
	jM2jaMA+e3vHz1cUK5qXubqD12xIUmDv0M0199GKlY5NYt5A/kFZctm/TkdDLseVYoCs8tzXItT
	FmRiyWRuje7R1gvUSyMkj/xuuFSFvy9PUt6iKggs0Xi4HFhgij5x/g24EiAOCQY1ks5bp4GQ3gO
	405ipHUatjJaK9TMZZJldcik2r3RfC+xQKlotCHyokcTDGauuT1UiW2+IYolRReqir2FfhUJbZx
	xLOo5B4SQeSsDsrqVw/v4x9i93m+uy1X3D0mgNKx4jnT9xkR+Y+2KAl
X-Received: by 2002:a05:600d:8451:b0:48a:55d8:7882 with SMTP id 5b1f17b1804b1-48d187d91f2mr22280455e9.9.1777967229640;
        Tue, 05 May 2026 00:47:09 -0700 (PDT)
Received: from lb03189.fkb.profitbricks.net ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48d186d97c4sm10617125e9.35.2026.05.05.00.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:47:09 -0700 (PDT)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	axboe@kernel.dk,
	bvanassche@acm.org,
	hch@lst.de,
	jgg@ziepe.ca,
	leon@kernel.org,
	jinpu.wang@ionos.com,
	Md Haris Iqbal <haris.iqbal@ionos.com>,
	Jia Li <jia.li@ionos.com>
Subject: [PATCH 01/13] RDMA/rmr: add public and private headers
Date: Tue,  5 May 2026 09:46:13 +0200
Message-ID: <20260505074644.195453-2-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505074644.195453-1-haris.iqbal@ionos.com>
References: <20260505074644.195453-1-haris.iqbal@ionos.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5C2424C83E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ionos.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ionos.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ionos.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19990-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haris.iqbal@ionos.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[]

Reliable Multicast over RTRS (RMR) is an RDMA ULP that provides
active-active block-level replication on top of the RTRS transport.
It guarantees delivery of an I/O to a group of storage nodes and
handles resynchronization of data between storage nodes without
involving the compute client.

Add the public interface header (rmr.h) used by upper-layer
consumers, plus the private headers shared between the client and
server modules:

  rmr-proto.h	wire protocol definitions
  rmr-pool.h	pool data structures
  rmr-map.h	dirty-map data structures
  rmr-req.h	server-side request lifecycle helpers
  rmr-clt.h	client-side structs and function declarations
  rmr-srv.h	server-side structs and function declarations,
		including the IO store interface (struct
		rmr_srv_store_ops) implemented by an upper-layer
		consumer

No code is compiled by this patch on its own; the modules are
wired into the build in a later patch in this series.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jia Li <jia.li@ionos.com>
---
 drivers/infiniband/ulp/rmr/rmr-clt.h   | 291 ++++++++++++++++++
 drivers/infiniband/ulp/rmr/rmr-map.h   | 246 +++++++++++++++
 drivers/infiniband/ulp/rmr/rmr-pool.h  | 400 +++++++++++++++++++++++++
 drivers/infiniband/ulp/rmr/rmr-proto.h | 273 +++++++++++++++++
 drivers/infiniband/ulp/rmr/rmr-req.h   |  65 ++++
 drivers/infiniband/ulp/rmr/rmr-srv.h   | 219 ++++++++++++++
 drivers/infiniband/ulp/rmr/rmr.h       | 229 ++++++++++++++
 7 files changed, 1723 insertions(+)
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-clt.h
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-map.h
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-pool.h
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-proto.h
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-req.h
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-srv.h
 create mode 100644 drivers/infiniband/ulp/rmr/rmr.h

diff --git a/drivers/infiniband/ulp/rmr/rmr-clt.h b/drivers/infiniband/ulp/rmr/rmr-clt.h
new file mode 100644
index 000000000000..c50651efe4a3
--- /dev/null
+++ b/drivers/infiniband/ulp/rmr/rmr-clt.h
@@ -0,0 +1,291 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Reliable multicast over RTRS (RMR)
+ *
+ * Copyright (c) 2026 IONOS SE
+ */
+
+#ifndef RMR_CLT_H
+#define RMR_CLT_H
+
+#include <rtrs-clt.h>
+#include "rmr-pool.h"
+
+#define RECONNECT_DELAY 30
+#define MAX_RECONNECTS -1
+#define RTRS_LINK_NAME "rtrs"
+
+#define RMR_MAP_CLEAN_DELAY_MS	  5000
+#define RMR_RECOVER_INTERVAL_MS	  3000
+
+enum rmr_clt_sess_state {
+	RMR_CLT_SESS_DISCONNECTED = 1,
+	RMR_CLT_SESS_CONNECTED,
+};
+
+struct rmr_clt_sess {
+	char		  	sessname[NAME_MAX];
+	struct kobject    	kobj;
+	struct mutex      	lock;
+	struct rtrs_clt_sess	*rtrs;
+	bool rtrs_ready;
+	/* server this session is connected to */
+	int		  	queue_depth;
+	u32               	max_io_size;
+	u32 max_segments;
+	struct list_head pool_sess_list;
+	struct list_head g_list;
+	struct kref kref;
+	enum rmr_clt_sess_state state;
+};
+
+/*
+ * NB: If you change here, make sure the changes are in sync with
+ *     pool_sess state machine routine i.e. pool_sess_change_state().
+ */
+enum rmr_clt_pool_sess_state {
+	RMR_CLT_POOL_SESS_CREATED = 1, // No IO, No dirty map addition, Yes cmd msgs
+	RMR_CLT_POOL_SESS_NORMAL, // Yes IO, No dirty map addition, Yes cmd msgs
+	RMR_CLT_POOL_SESS_FAILED, // No IO, Yes dirty map addition, No cmd msgs
+	RMR_CLT_POOL_SESS_RECONNECTING, // No IO, Yes, dirty map addition, Yes cmd msgs
+					// But not with an updated map
+
+	RMR_CLT_POOL_SESS_REMOVING // No IO, No dirty map addition, Yes cmd msgs
+				   // Getting removed from pool
+};
+
+struct rmr_clt_pool_sess {
+	char		sessname[NAME_MAX];
+	struct		rmr_pool *pool;
+	struct		kobject kobj;
+	u8		member_id; /* refers to the pool id on the */
+	struct		kobject sess_kobj;
+	struct		list_head entry; /* for pool->sess_list */
+	struct		list_head clt_sess_entry; /* for clt_sess->pool_sess_list */
+	struct		rmr_clt_sess *clt_sess;
+	atomic_t	state; /* rmr_clt_pool_sess_state */
+	u8		ver; /* protocol version */
+	u8		pool_id; /* refers to the pool id on the */
+	bool		maintenance_mode; /* If the pool is in maintenance mode or not */
+	bool		was_last_authoritative; /* last NORMAL sess before it went FAILED;
+					       * carries complete dirty maps for all members */
+};
+
+struct rmr_clt_stats {
+	struct kobject	kobj_stats;
+	atomic_t read_retries;
+};
+
+/*
+ * State descriptions:
+ * RMR_CLT_POOL_STATE_JOINED: An rmr_clt_pool which has one or more legs (rmr_clt_pool_sess)
+ *			      added to it. This means the pool has joined into pools from
+ *			      storage nodes
+ *
+ * RMR_CLT_POOL_STATE_IN_USE: An rmr_clt_pool which is in use by an upper layer client. This
+ *			      is usually done by calling rmr_clt_open
+ *
+ * Note: When adding a new state,
+ * remember to add an entry in the function rmr_get_clt_pool_state_name()
+ */
+enum rmr_clt_pool_state {
+	RMR_CLT_POOL_STATE_JOINED = 0,
+	RMR_CLT_POOL_STATE_IN_USE,
+	// RMR_CLT_POOL_STATE_DEGRADED,			uncomment and use
+	// RMR_CLT_POOL_STATE_DIRTY,
+	RMR_CLT_POOL_STATE_MAX,
+};
+
+struct rmr_clt_pool {
+	struct rmr_pool		*pool;
+	refcount_t		refcount;
+	unsigned long		state;
+	struct mutex		clt_pool_lock;
+
+	size_t		     	queue_depth;
+
+	struct rmr_clt_stats 	stats;
+	struct kobject       	stats_kobj;
+
+	void		     	*priv; /* provided by user */
+	rmr_clt_ev_fn	     	*link_ev; /* deliver events to user */
+
+	atomic_t                io_freeze;
+	wait_queue_head_t       map_update_wq;
+	struct mutex		io_freeze_lock;
+
+	struct workqueue_struct	*recover_wq;
+	struct delayed_work	recover_dwork;
+
+	/* use sessions round robbin to read */
+	struct rmr_clt_pool_sess __rcu *__percpu *pcpu_sess;
+};
+
+struct rmr_iu_comp {
+        wait_queue_head_t wait;
+        int errno;
+};
+
+/**
+ * rmr_iu - reserves resources needed to do an I/O op on pool
+ */
+struct rmr_iu {
+	struct rmr_pool		*pool;
+	unsigned int		mem_id;
+	struct list_head	sess_list;       /* list of per-session tags */
+	u8			num_sessions;
+	refcount_t		ref;             /* lifetime refcount */
+	struct rmr_msg_io	msg;
+	int			errno;
+	atomic_t		succeeded;
+	refcount_t		refcount;
+	rmr_conf_fn		*conf;
+	void			*priv;
+	/* for retry of failed reads */
+	struct work_struct	work;
+	struct scatterlist	*sg;
+	unsigned int		sg_cnt;
+};
+
+struct rmr_clt_sess_iu {
+	void *buf; /* for session messages */
+	struct rtrs_permit      *permit;
+	struct rmr_clt_pool_sess *pool_sess;
+	int			errno;
+	union {
+		/* for session messages only */
+		struct scatterlist	sg;
+		/* for tag->sess_list of io messages*/
+		struct list_head	entry;
+	};
+
+	/* for session messages only */
+	struct work_struct	work;
+
+	/* for io requests */
+	struct rmr_iu		*rmr_iu;
+	unsigned int		mem_id;
+
+	/* for command messages */
+	struct rmr_clt_cmd_unit	*rmr_cmd_unit;
+
+	/* for session messages only */
+	struct rmr_iu_comp	comp;
+	atomic_t		refcount;
+};
+
+struct rmr_clt_iu_comp {
+	wait_queue_head_t wait;
+	int errno;
+};
+
+struct rmr_clt_cmd_unit {
+	struct rmr_pool		*pool;
+	struct rmr_clt_pool	*clt_pool;
+
+	struct list_head	sess_list;
+	int			num_sessions;
+
+	int			failed_state;
+	int			errno;
+	atomic_t		succeeded;
+	refcount_t		refcount;
+
+	rmr_conf_fn		*conf;
+	void			*priv;
+};
+
+/* rmr-clt.c */
+struct rmr_pool *rmr_clt_create_pool(const char *name);
+void rmr_put_clt_pool(struct rmr_clt_pool *clt_pool);
+
+void rmr_clt_change_pool_state(struct rmr_clt_pool *rmr_clt_pool,
+			       enum rmr_clt_pool_state new_state, bool set);
+int rmr_clt_remove_pool_from_sysfs(struct rmr_pool *pool,
+				   const struct attribute *sysfs_self);
+struct rmr_clt_sess *find_and_get_or_create_clt_sess(char *sessname,
+						     struct rtrs_addr *paths,
+						     size_t path_cnt);
+struct rmr_clt_pool_sess *rmr_clt_add_pool_sess(struct rmr_pool *pool,
+						struct rmr_clt_sess *clt_sess, bool create);
+void rmr_clt_sess_put(struct rmr_clt_sess *sess);
+void rmr_clt_del_pool_sess(struct rmr_clt_pool_sess *sess);
+void rmr_clt_destroy_pool_sess(struct rmr_clt_pool_sess *sess, bool delete);
+
+const char *rmr_clt_sess_state_str(enum rmr_clt_pool_sess_state state);
+void resend_join_pool(struct rmr_clt_sess *sess);
+int rmr_clt_reconnect_sess(struct rmr_clt_sess *sess,
+			   const struct rtrs_addr *paths,
+			   size_t path_cnt);
+int rmr_clt_start_last_io_update(struct rmr_pool *pool);
+int rmr_clt_set_pool_sess_mm(struct rmr_clt_pool_sess *pool_sess);
+int rmr_clt_enable_sess(struct rmr_clt_pool_sess *sess);
+
+int rmr_clt_send_map_update(struct rmr_pool *pool, struct rmr_iu *iu);
+
+int rmr_clt_pool_send_all(struct rmr_pool *pool, struct rmr_msg_pool_cmd *msg);
+int rmr_clt_send_cmd_with_data(struct rmr_pool *pool, struct rmr_clt_pool_sess *pool_sess,
+			       struct rmr_msg_pool_cmd *msg,
+			       void *buf, unsigned int buflen);
+int rmr_clt_map_add_id(struct rmr_pool *pool, int stg_id, rmr_id_t id);
+void rmr_clt_init_cmd(struct rmr_pool *pool, struct rmr_msg_pool_cmd *msg);
+int rmr_clt_pool_send_cmd(struct rmr_clt_pool_sess *sess, struct rmr_msg_pool_cmd *msg, bool wait);
+int rmr_clt_del_stor_from_pool(struct rmr_clt_pool_sess *pool_sess, bool delete);
+bool rmr_clt_sess_is_sync(struct rmr_clt_pool_sess *sess);
+int send_msg_leave_pool(struct rmr_clt_pool_sess *pool_sess, bool delete, bool wait);
+void rmr_clt_free_pool_sess(struct rmr_clt_pool_sess *pool_sess);
+int rmr_clt_send_map(struct rmr_pool *map_src_pool, struct rmr_pool *clt_pool,
+		     const struct rmr_msg_map_send_cmd *map_send_cmd, rmr_map_filter filter);
+int rmr_clt_test_map(struct rmr_pool *src_pool, struct rmr_pool *dst_pool);
+int rmr_clt_send_cmd_with_data_all(struct rmr_pool *pool, struct rmr_msg_pool_cmd *msg,
+				   void *buf, unsigned int buflen);
+int rmr_clt_pool_send_md_all(struct rmr_pool *src_pool, struct rmr_pool *clt_pool);
+int rmr_clt_pool_send_cmd_all(struct rmr_pool *pool, enum rmr_msg_cmd_type cmd_type);
+void recover_work(struct work_struct *work);
+
+int rmr_clt_pool_member_synced(struct rmr_pool *pool, u8 member_id);
+
+bool pool_sess_change_state(struct rmr_clt_pool_sess *pool_sess,
+			    enum rmr_clt_pool_sess_state newstate);
+
+void rmr_clt_pool_io_freeze(struct rmr_clt_pool *clt_pool);
+void rmr_clt_pool_io_unfreeze(struct rmr_clt_pool *clt_pool);
+void rmr_clt_pool_io_wait_complete(struct rmr_clt_pool *clt_pool);
+int rmr_clt_pool_try_enable(struct rmr_pool *pool);
+int send_msg_enable_pool(struct rmr_clt_pool_sess *pool_sess, bool enable);
+
+void rmr_get_iu(struct rmr_iu *iu);
+void rmr_put_iu(struct rmr_iu *iu);
+void rmr_msg_put_iu(struct rmr_clt_pool_sess *pool_sess,
+		    struct rmr_clt_sess_iu *sess_iu);
+void wake_up_iu_comp(struct rmr_clt_sess_iu *sess_iu);
+void msg_conf(void *priv, int errno);
+
+/* rmr-map-mgmt.c */
+void send_map_check(struct rmr_clt_pool_sess *pool_sess);
+void send_store_check(struct rmr_clt_pool_sess *pool_sess);
+int send_map_get_version(struct rmr_clt_pool_sess *pool_sess, u64 *ver);
+int send_discard(struct rmr_clt_pool_sess *pool_sess, u8 cmd_type, u8 member_id);
+int rmr_clt_handle_map_check_rsp(struct rmr_clt_pool_sess *pool_sess,
+				 struct rmr_msg_pool_cmd_rsp *rsp);
+int rmr_clt_handle_store_check_rsp(struct rmr_clt_pool_sess *pool_sess,
+				   struct rmr_msg_pool_cmd_rsp *rsp);
+int rmr_clt_read_map(struct rmr_pool *pool);
+int rmr_clt_spread_map(struct rmr_pool *pool, struct rmr_clt_pool_sess *pool_sess_chosen,
+		       bool enable, bool skip_normal);
+int rmr_clt_unset_pool_sess_mm(struct rmr_clt_pool_sess *pool_sess);
+void sched_map_add(struct work_struct *work);
+void msg_pool_cmd_map_content_conf(struct work_struct *work);
+
+/* rmr-clt-sysfs.c */
+int rmr_clt_create_sysfs_files(void);
+void rmr_clt_destroy_sysfs_files(void);
+void rmr_clt_destroy_pool_sysfs_files(struct rmr_pool *pool,
+				      const struct attribute *sysfs_self);
+int rmr_clt_create_clt_sess_sysfs_files(struct rmr_clt_sess *clt_sess);
+void rmr_clt_destroy_clt_sess_sysfs_files(struct rmr_clt_sess *clt_sess);
+
+int rmr_clt_reset_read_retries(struct rmr_clt_stats *stats, bool enable);
+ssize_t rmr_clt_stats_read_retries_to_str(struct rmr_clt_stats *stats, char *page);
+
+#endif /* RMR_CLT_H */
diff --git a/drivers/infiniband/ulp/rmr/rmr-map.h b/drivers/infiniband/ulp/rmr/rmr-map.h
new file mode 100644
index 000000000000..76ef6506421f
--- /dev/null
+++ b/drivers/infiniband/ulp/rmr/rmr-map.h
@@ -0,0 +1,246 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Reliable multicast over RTRS (RMR)
+ *
+ * Copyright (c) 2026 IONOS SE
+ */
+
+#ifndef RMR_MAP_H
+#define RMR_MAP_H
+
+#include <linux/types.h>
+#include <linux/xarray.h>
+
+#include "rmr.h"
+
+/**
+ * The dirty map buffer is used to track dirty chunks through bits.
+ * The position of the bit denotes the chunk number it tracks.
+ *
+ * Bitmap structure
+ * ----------------
+ * The dirty bitmap is stored in a 2 level tree-like structure.
+ * The main unit of storage are memory pages; They act as nodes of this structure.
+ * The first level pages (FLP) stores the address of the second level pages.
+ * There can be a total of 256 first level pages.
+ * The second level pages (SLP, also the leaf nodes/pages) stores the bitmap.
+ *
+ * The first level pages have to store the address of the second level pages.
+ * An address being 8B (default/max) long, the addresses of a maximum of 512 pages can
+ * be stored in a first level page. This then decides the maximum leaf pages a pool can
+ * have, which, for our example, is [(# pages of FLP) * (PAGE_SIZE / address_size)],
+ * (256*512)=131072.
+ * With the above info, the available space for bitmap is 131072*4KB(PAGE_SIZE)=512MB.
+ *
+ * A chunk is the smallest unit of data which is tracked for being dirty. A chunk is
+ * called dirty/unsynced, even if a single byte in it is dirty/unsynced.
+ * To track a chunk, a single byte (1B) is used. The least significant bit is used to signify
+ * if the chunk is dirty (set) or not. Other bits can be used for other purposes (for example,
+ * filters). The maximum number of chunks RMR can manage are then, (512MB)/1B=536870912.
+ * This number is fixed, as one can see from the calculations, and hence the maximum size of
+ * metadata RMR can allocate and use is fixed.
+
+ * The user configurable part is the chunk size. Its range is 128KB-1MB, and it has to be a
+ * power of 2.
+ * The chunk size decides the maximum mapped size for an RMR pool.
+ * For example, for chunk size 1MB, and taking the maximum number of chunks RMR can allocate
+ * and handle (536870912, see above), the maximum mapped size would be (536870912*1MB)=512TB.
+ * The table showing the relation between chunk size and maximum mapped size is as follows,
+ * Chunk size	Maximum mapped size
+ * 128KB	64TB
+ * 256KB	128TB
+ * 512KB	256TB
+ * 1MB		512TB
+ *
+ * Calculating chunk number
+ * ------------------------
+ * Some key points
+ * 1) The Linux kernel has a fixed size for sector, which is 512 (or 9 bitshift)
+ * 2) The mapped_size provided and stores in the rmr_pool structure is in sectors.
+ * 3) The chunk_size provided and stored in the rmr_pool structure is in bytes.
+ * 4) The code calculates and stores chunk_size_shift in the rmr_pool structure to do fast
+ *    calculation.
+ * 5) The IO offset give to RMR (through function rmr_clt_request) is in bytes.
+ *
+ * --
+ * With the above points, lets have a sample scenario with mapped_size 1GB and chunk_size 128KB
+ * The numbers would then be,
+ *
+ * no_of_chunks = (mapped_size / chunk_size)
+ * no_of_chunks = 8192
+ *
+ * chunk_size = 131072
+ * chunk_size_shift = 17
+ *
+ * dirty_map buffer size (in BYTES) = (no_of_chunks / bits in a byte)
+ * dirty_map buffer size (in BYTES) = 1024
+ *
+ * --
+ * Lets do a sample calculation of chunk_no from offset and length of an IO
+ *
+ * For offset 30801920 and length 4096
+ *
+ * chunk_no = (offset >> chunk_size_shift)
+ * chunk_no = 235
+ *
+ */
+
+#define RMR_KEY_SHIFT 32
+
+// Each chunk requires 1B of metadata
+#define PER_CHUNK_MD		1
+#define PER_CHUNK_MD_LOG2	ilog2(PER_CHUNK_MD)
+
+#define GET_CHUNK_NUMBER(offset, shift)			(offset >> shift)
+#define GET_FOLLOWING_CHUNKS(offset_len, shift, start)	(((offset_len - 1) >> shift) - start + 1)
+
+#define CHUNK_TO_OFFSET(chunk_no, shift)       (chunk_no << shift)
+
+// The element type stored in FLP
+typedef unsigned long	el_flp;
+
+enum {
+	CHUNK_DIRTY_BIT = 0,
+	CHUNK_FILTER_BIT,
+};
+
+enum {
+	MAX_NO_OF_FLP = 256,
+	NO_OF_SLP_PER_FLP = (PAGE_SIZE >> ilog2(sizeof(void *))),
+	NO_OF_SLP_PER_FLP_LOG2 = ilog2(NO_OF_SLP_PER_FLP),
+	MAX_NO_OF_SLP = (MAX_NO_OF_FLP * NO_OF_SLP_PER_FLP),
+
+	NO_OF_CHUNKS_PER_PAGE = (PAGE_SIZE >> PER_CHUNK_MD_LOG2),
+	// Chunks data is stored only in SLP
+	MAX_NO_OF_CHUNKS = (MAX_NO_OF_SLP * NO_OF_CHUNKS_PER_PAGE),
+
+	CHUNKS_PER_SLP = (PAGE_SIZE >> PER_CHUNK_MD_LOG2),
+	CHUNKS_PER_SLP_LOG2 = ilog2(CHUNKS_PER_SLP),
+	CHUNKS_PER_FLP = (CHUNKS_PER_SLP * NO_OF_SLP_PER_FLP),
+	CHUNKS_PER_FLP_LOG2 = ilog2(CHUNKS_PER_FLP),
+};
+
+typedef enum {
+	MAP_NO_FILTER = 0,
+	MAP_ENTRY_UNSYNCED
+} rmr_map_filter;
+
+enum rmr_map_state {
+	RMR_MAP_STATE_NO_CHECK = 0,
+	RMR_MAP_STATE_CHECKING,
+	// do we have some other useful states ?
+};
+
+struct rmr_dirty_id_map {
+	u8 member_id;
+	struct xarray rmr_id_map;
+	unsigned long ts;
+	atomic_t check_state;
+
+	/*
+	 * The usage of this is restricted to form a linked lised
+	 * during mass deletion. Since this is in an RCU list (maps
+	 * in rmr_pool), we cannot use this or change any data until
+	 * the RCU period completes. So we use this next variable
+	 * during mass deletion so we can have a list and don't have
+	 * to wait and restart the search on every individual deletion
+	 * of a map. Refer destroy_clt_pool().
+	 */
+	struct rmr_dirty_id_map *next;
+
+	u64		no_of_chunks;
+	u64		no_of_flp;
+	u64		no_of_slp_in_last_flp;
+	u64		no_of_chunk_in_last_slp;
+	u64		total_slp;
+	u8		*bitmap_filter;
+	void		*dirty_bitmap[MAX_NO_OF_FLP];
+};
+
+struct rmr_map_entry {
+	atomic_t sync_cnt;
+	struct llist_head wait_list;
+};
+
+/*
+ * The header of the bitmap buffer.
+ */
+struct rmr_map_cbuf_hdr {
+	u64		version;
+	u8		member_id;
+
+	u64		no_of_chunks;
+	u64		no_of_flp;
+	u64		no_of_slp_in_last_flp;
+	u64		no_of_chunk_in_last_slp;
+	u64		total_slp;
+} __packed;
+
+static inline unsigned long rmr_id_to_key(rmr_id_t id)
+{
+	unsigned long res;
+
+	// highest bits for id.a, the rest are for id.b;
+	res = ((id.a << RMR_KEY_SHIFT) | id.b);
+	return res;
+}
+
+static inline u64 key_to_a(unsigned long key)
+{
+	return key >> RMR_KEY_SHIFT;
+}
+
+static inline u64 key_to_b(unsigned long key)
+{
+	return key & ((1ULL << RMR_KEY_SHIFT) - 1);
+}
+
+void rmr_map_update_page_params(struct rmr_dirty_id_map *map);
+struct rmr_dirty_id_map *rmr_map_create(struct rmr_pool *pool, u8 member_id);
+void rmr_map_destroy(struct rmr_dirty_id_map *map);
+void rmr_map_calc_chunk(struct rmr_pool *pool, size_t offset, size_t length, rmr_id_t *id);
+void rmr_map_set_dirty(struct rmr_dirty_id_map *map, rmr_id_t id, u8 filter);
+void rmr_map_set_dirty_all(struct rmr_dirty_id_map *map, u8 filter);
+struct rmr_map_entry *rmr_map_unset_dirty(struct rmr_dirty_id_map *map, rmr_id_t id, u8 filter);
+bool rmr_map_check_dirty(struct rmr_dirty_id_map *map, rmr_id_t id);
+struct rmr_map_entry *rmr_map_get_dirty_entry(struct rmr_dirty_id_map *map, rmr_id_t id);
+void rmr_map_clear_filter_all(struct rmr_dirty_id_map *map, u8 filter);
+void rmr_map_unset_dirty_all(struct rmr_dirty_id_map *map);
+bool rmr_map_empty(struct rmr_dirty_id_map *map);
+
+void rmr_map_bitwise_or_buf(void *dst_buf, void *src_buf, u32 buf_size);
+int rmr_map_create_entries(struct rmr_dirty_id_map *map);
+
+void rmr_map_hexdump_bitmap_buf(u8 member_id, void *buf, u32 buf_size);
+void rmr_map_slps_to_buf(struct rmr_dirty_id_map *map, u64 slp_idx, u64 no_of_slp, u8 *buf);
+u64 rmr_map_buf_to_slps(struct rmr_dirty_id_map *map, u8 *buf, u32 buf_size, u64 slp_idx,
+			bool test);
+void rmr_map_dump_bitmap(struct rmr_dirty_id_map *map);
+int rmr_map_summary_format(struct rmr_pool *pool, char *buf, size_t buf_size);
+void rmr_map_bidump_bitmap_buf(void *buf, u8 member_id, u32 buf_size);
+
+static inline void map_entry_get_sync(struct rmr_map_entry *entry)
+{
+	atomic_inc(&entry->sync_cnt);
+	pr_debug("after get ref for entry %p, sync cnt %d\n",
+		 entry, atomic_read(&entry->sync_cnt));
+}
+
+static inline int map_entry_put_sync(struct rmr_map_entry *entry)
+{
+	pr_debug("before dec_and_test for entry %p, sync cnt %d\n",
+		 entry, atomic_read(&entry->sync_cnt));
+	return atomic_dec_and_test(&entry->sync_cnt);
+}
+
+static inline void rmr_maplist_destroy(struct rmr_dirty_id_map *maplist)
+{
+	struct rmr_dirty_id_map *mp;
+
+	while (maplist != NULL) {
+		mp = maplist;
+		maplist = maplist->next;
+		rmr_map_destroy(mp);
+	}
+}
+#endif /* RMR_MAP_H */
diff --git a/drivers/infiniband/ulp/rmr/rmr-pool.h b/drivers/infiniband/ulp/rmr/rmr-pool.h
new file mode 100644
index 000000000000..3cb7d3ae84b9
--- /dev/null
+++ b/drivers/infiniband/ulp/rmr/rmr-pool.h
@@ -0,0 +1,400 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Reliable multicast over RTRS (RMR)
+ *
+ * Copyright (c) 2026 IONOS SE
+ */
+
+#ifndef RMR_POOL_H
+#define RMR_POOL_H
+
+#include <linux/limits.h>	/* for NAME_MAX */
+#include <linux/refcount.h>
+#include <linux/slab.h>
+#include <linux/jhash.h>	/* for jhash() */
+#include <linux/kernel.h>	/* for round_up */
+#include "rmr.h"
+#include "rmr-map.h"
+
+#define RMR_POOL_MD_MAGIC 0xDEADBEEF
+#define XA_TRUE  ((void *)1UL)
+#define XA_FALSE ((void *)2UL)
+
+extern struct kmem_cache *rmr_map_entry_cachep;
+/*
+ * enum srv_sync_thread_state
+ */
+enum srv_sync_thread_state {
+	SYNC_THREAD_REQ_STOP,	/* 0 */
+	SYNC_THREAD_STOPPED,
+	SYNC_THREAD_RUNNING,
+	SYNC_THREAD_WAIT,
+};
+
+enum srv_map_update_state {
+	MAP_UPDATE_STATE_DISABLED,
+	MAP_UPDATE_STATE_READY,
+	MAP_UPDATE_STATE_DONE,
+};
+
+/* The srv pool specific structure */
+struct rmr_srv_md {
+	u64			map_ver;
+	u64			mapped_size;		/* server store size in sectors */
+	u8			member_id;
+	u8			srv_pool_state;		/* server pool state */
+	u8			store_state;		/* state of io_store */
+	u8			map_update_state;
+	bool			discard_entries;
+};
+
+/* Shared by each pool */
+struct rmr_pool_md {
+	char			poolname[NAME_MAX];
+	u64			magic;
+	u32			group_id;
+	u32			chunk_size;		/* rmr client */
+	u64			mapped_size;		/* client view of store size */
+	u32			queue_depth;
+	u64			map_ver;
+	struct rmr_srv_md	srv_md[RMR_POOL_MAX_SESS];
+} __packed;
+
+struct rmr_pool {
+	char			poolname[NAME_MAX];
+	u32			group_id;	/* jhash() on poolname */
+	struct kobject		kobj;
+	struct kobject		sessions_kobj;
+	struct list_head	entry;		/* for global pool_list */
+
+	struct list_head	sess_list;	/* list of sessions */
+	struct mutex		sess_lock;	/* protect list of sessions */
+	struct srcu_struct	sess_list_srcu;
+
+	void			*priv;
+	u64			mapped_size;
+	u32 			chunk_size;
+	u8			chunk_size_shift;
+	u64			no_of_chunks;
+
+	struct percpu_ref       ids_inflight_ref;
+	struct completion       complete_done;
+	struct completion       confirm_done;
+
+	struct completion	discard_done; /* for sync client pool */
+	/* Set when waiting for response of discard request */
+	atomic_t		discard_waiting;
+
+	u8                      maps_cnt;
+	struct mutex		maps_lock;
+	struct rmr_dirty_id_map __rcu
+				*maps[RMR_POOL_MAX_SESS];
+	/* All member ids of the storage nodes */
+	struct xarray		stg_members;
+	u64			map_ver;
+	atomic_t		normal_count; /* number of pool sessions currently in NORMAL state */
+	struct srcu_struct	map_srcu;
+
+	struct rmr_pool_md	pool_md;
+
+	bool is_clt;
+	bool sync;
+};
+
+/**
+ * rmr_pool_find_md - find the index of the srv_md with the provided key in the pool_md
+ *
+ * @pool_md: the pool_md to search
+ * @key: the member_id of the server pool to search for
+ * @empty_slot: the empty slot is required by caller or not
+ *
+ * Description:
+ *	Find the index of the srv_md with the matched key. If there is no such a key and the empty
+ *	slot is not required, return -1.
+ *
+ * Return:
+ *	>= 0, the index of the key in the pool_md. Return the index of an empty slot when the key
+ *	is not found and the empty_slot flag is true
+ *	-1 if the key is not found and empty_slot is false, or the pool_md doesn't exist
+ */
+static inline int rmr_pool_find_md(struct rmr_pool_md *pool_md, u8 key, bool empty_slot)
+{
+	int i;
+	int empty_i = -1;
+
+	if (!pool_md)
+		return -1;
+
+	for (i = 0; i < RMR_POOL_MAX_SESS; i++) {
+		if (!pool_md->srv_md[i].member_id)
+			empty_i = i;
+
+		if (pool_md->srv_md[i].member_id == key)
+			return i;
+	}
+
+	if (empty_slot)
+		return empty_i;
+	return -1;
+}
+
+/**
+ * rmr_pool_md_check_discard - check the discard_entries flag of the srv_md
+ *
+ * @pool: the pool to check pool_md
+ * @member_id: the member_id of the srv_md to check
+ *
+ * Description:
+ *	Check if the pool has received the discards from the server pool with the provided
+ *	member_id.
+ *
+ * Return:
+ *	1 (true) if the pool has received the discards,
+ *	0 (false) if the pool has not received the discards,
+ *	<0 if the pool has no info of the server pool
+ */
+static inline int rmr_pool_md_check_discard(struct rmr_pool *pool, u8 member_id)
+{
+	int md_i = rmr_pool_find_md(&pool->pool_md, member_id, false);
+
+	if (md_i < 0) {
+		pr_err("Failed to find md for member_id %u\n", member_id);
+		return -EINVAL;
+	}
+
+	/* If the flag is set, this pool has received the discards. */
+	return pool->pool_md.srv_md[md_i].discard_entries;
+}
+
+#define RMR_MAP_FORMAT_VER 1
+/*
+ * Get the first most significant bit of map_ver. If it is one, then the store of that storage node
+ * is being replaced.
+ */
+#define RMR_STORE_IS_REPLACE(map_ver) (map_ver >> 63 & 1ULL)
+#define RMR_STORE_GET_VER(map_ver) (map_ver & ~(1ULL << 63))
+#define RMR_STORE_SET_REPLACE(map_ver) (map_ver |= 1ULL << 63)
+#define RMR_STORE_UNSET_REPLACE(map_ver) (map_ver &= ~(1ULL << 63))
+#define RTRS_IO_LIMIT	   102400
+//#define RTRS_IO_LIMIT 40 //for tests only
+
+/*
+ * TODO:
+ * We currently do not have mapped_size while creating dirty maps,
+ * which means we cannot calculate no_of_chunks, hence cannot allocate bitmap
+ * So, as a workaround, we allocate max size bitmap,
+ * and to reduce that allocation, we cap max mapped_size.
+ *
+ * 1GB max mapped size for now.
+ * (Size mentioned in number of sectors, just like nr_sects)
+ */
+#define RMR_MAX_MAPPED_SIZE    2097152
+
+/* The header structure of rmr pool metadata will not over this limit. */
+#define RMR_MD_SIZE		PAGE_SIZE
+#define RMR_MD_SIZE_SECTORS	(PAGE_SIZE / SECTOR_SIZE)
+#define RMR_MAP_BUF_HDR_SIZE    PAGE_SIZE
+#define RMR_SRV_MD_SIZE		(sizeof(struct rmr_srv_md) * RMR_POOL_MAX_SESS)
+#define RMR_CLT_MD_SIZE		(sizeof(struct rmr_pool_md) - RMR_SRV_MD_SIZE)
+#define RMR_SECTOR_SIZE		512
+#define RMR_INT_ROUND_UP(x, y)	(((x) + (y) - 1) / (y))
+#define RMR_ROUND_UP(x)		round_up(x, RMR_SECTOR_SIZE)
+
+#define RMR_SRV_MAX_QDEPTH	512
+
+/* last_io region starts right after the pool_md header page */
+#define RMR_LAST_IO_OFFSET	RMR_MD_SIZE
+
+static inline u64 rmr_last_io_len(u32 queue_depth)
+{
+	return RMR_ROUND_UP((u64)queue_depth * sizeof(rmr_id_t));
+}
+
+static inline u64 rmr_bitmap_offset(u32 queue_depth)
+{
+	return RMR_LAST_IO_OFFSET + rmr_last_io_len(queue_depth);
+}
+
+static inline u64 rmr_per_map_bitmap_size(u64 no_of_chunks)
+{
+	return DIV_ROUND_UP(no_of_chunks, CHUNKS_PER_SLP) * PAGE_SIZE;
+}
+
+static inline u64 rmr_bitmap_len(u64 no_of_chunks)
+{
+	return RMR_POOL_MAX_SESS * rmr_per_map_bitmap_size(no_of_chunks);
+}
+
+struct rmr_map_buf_hdr {
+	u64 version;
+	u64 member_id;
+
+	/*
+	 * dst_slp_idx: SLP index in the local dirty map buffer,
+	 * from where to write the recved dirty map buffer
+	 */
+	u64 dst_slp_idx;
+	u32 buf_size;
+
+	/*
+	 * slp_idx: Only used for MAP_READ,
+	 * to let client know where to ask from in the next iteration
+	 */
+	u64 map_idx;
+	u64 slp_idx;
+} __packed;
+
+extern struct list_head pool_list;
+extern struct mutex pool_mutex;
+
+const char *rmr_get_cmd_name(enum rmr_msg_cmd_type cmd);
+
+struct rmr_pool *rmr_create_pool(const char *poolname, void *priv);
+void free_pool(struct rmr_pool *pool);
+
+struct rmr_pool *rmr_find_pool_by_group_id(u32 group_id);
+struct rmr_pool *rmr_find_pool(const char *poolname);
+int rmr_pool_maps_to_buf(struct rmr_pool *pool, u8 *map_idx, u64 *slp_idx,
+			 void *buf, size_t buflen, rmr_map_filter filter);
+int rmr_pool_save_map(struct rmr_pool *pool, void *buf, size_t buflen,
+		      bool test_only);
+
+static inline void rmr_pool_update_no_of_chunk(struct rmr_pool *pool)
+{
+	u64 calc_no_of_chunks = 0, old_no_of_chunks = pool->no_of_chunks;
+
+	/*
+	 * In include/linux/types.h
+	 *
+	 * "Linux always considers sectors to be 512 (SECTOR_SHIFT==9) bytes long independently
+	 * of the devices real block size."
+	 *
+	 * mapped_size is saved in sectors.
+	 */
+	if (pool->mapped_size) {
+		calc_no_of_chunks = (pool->mapped_size >> (pool->chunk_size_shift - 9));
+
+		if (pool->chunk_size &&
+		    (pool->mapped_size << 9) % pool->chunk_size)
+			calc_no_of_chunks += 1;
+	}
+
+	if (calc_no_of_chunks != pool->no_of_chunks) {
+		pool->no_of_chunks = calc_no_of_chunks;
+		pr_info("%s: For %s, no_of_chunks old (%llu), updated %llu\n",
+			__func__, pool->poolname, old_no_of_chunks, pool->no_of_chunks);
+	}
+}
+
+/*
+ * rmr_pool_maps_append - Append a map to the dense maps array
+ * @pool: pool
+ * @map: map to add
+ *
+ * Context: Caller must hold maps_lock.
+ */
+static inline void rmr_pool_maps_append(struct rmr_pool *pool,
+					struct rmr_dirty_id_map *map)
+{
+	rcu_assign_pointer(pool->maps[pool->maps_cnt], map);
+	pool->maps_cnt++;
+}
+
+/*
+ * rmr_pool_maps_swap_remove - Remove map at index @i using swap-with-last
+ * @pool: pool
+ * @i: index of the map in the map array to remove
+ * @map: the map being removed
+ *
+ * Description:
+ *      Maintains the dense invariant: pool->maps[0:maps_cnt] has no NULL gaps.
+ *
+ * Context: Caller must hold maps_lock.
+ */
+static inline void rmr_pool_maps_swap_remove(struct rmr_pool *pool, u8 i,
+					     struct rmr_dirty_id_map *map)
+{
+	u8 last = pool->maps_cnt - 1;
+
+	if (i != last)
+		rcu_assign_pointer(pool->maps[i], rcu_dereference_protected(pool->maps[last],
+					lockdep_is_held(&pool->maps_lock)));
+
+	rcu_assign_pointer(pool->maps[last], NULL);
+	pool->maps_cnt--;
+}
+
+static inline struct rmr_dirty_id_map *rmr_pool_find_map(struct rmr_pool *pool, u8 member_id)
+{
+	int i;
+	struct rmr_dirty_id_map *map;
+	struct rmr_dirty_id_map *res = NULL;
+
+	rcu_read_lock();
+	for (i = 0; i < pool->maps_cnt; i++) {
+		map = rcu_dereference(pool->maps[i]);
+
+		if (WARN_ON(!map) || map->member_id != member_id)
+			continue;
+
+		res = map;
+		break;
+	}
+	rcu_read_unlock();
+
+	return res;
+}
+
+static inline int rmr_pool_remove_map(struct rmr_pool *pool, u8 member_id)
+{
+	int i;
+	struct rmr_dirty_id_map *mp;
+	struct rmr_dirty_id_map *map = NULL;
+
+	pr_info("%s: pool %s is removing map for member_id %d\n",
+		__func__, pool->poolname, member_id);
+
+	mutex_lock(&pool->maps_lock);
+	for (i = 0; i < pool->maps_cnt; i++) {
+		mp = rcu_dereference_protected(pool->maps[i],
+				lockdep_is_held(&pool->maps_lock));
+		if (WARN_ON(!mp))
+			continue;
+		if (mp->member_id == member_id) {
+			map = mp;
+			break;
+		}
+	}
+
+	if (!map) {
+		mutex_unlock(&pool->maps_lock);
+		pr_err("%s: pool %s cannot find map for member_id %d\n",
+		       __func__, pool->poolname, member_id);
+		return -EINVAL;
+	}
+
+	/* Dirty map entries are also removed since the map no longer exists. */
+	rmr_map_unset_dirty_all(map);
+
+	rmr_pool_maps_swap_remove(pool, i, map);
+	synchronize_srcu(&pool->map_srcu);
+
+	mutex_unlock(&pool->maps_lock);
+
+	/* Free up the memory */
+	rmr_map_destroy(map);
+
+	return 0;
+}
+
+
+bool rmr_pool_change_state(struct rmr_pool *pool, enum rmr_pool_state new_state);
+
+void rmr_pool_confirm_inflight_ref(struct percpu_ref *ref);
+
+static inline u32 rmr_pool_hash(const char *poolname)
+{
+	return jhash(poolname, strlen(poolname), 0);
+}
+
+#endif /* RMR_POOL_H */
diff --git a/drivers/infiniband/ulp/rmr/rmr-proto.h b/drivers/infiniband/ulp/rmr/rmr-proto.h
new file mode 100644
index 000000000000..02c20ed76bef
--- /dev/null
+++ b/drivers/infiniband/ulp/rmr/rmr-proto.h
@@ -0,0 +1,273 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Reliable multicast over RTRS (RMR)
+ *
+ * Copyright (c) 2026 IONOS SE
+ */
+
+#ifndef RMR_PROTO_H
+#define RMR_PROTO_H
+
+#define RMR_PROTO_VER_MAJOR 0
+#define RMR_PROTO_VER_MINOR 1
+
+#define RMR_PROTO_VER_STRING __stringify(RMR_PROTO_VER_MAJOR) "." \
+			       __stringify(RMR_PROTO_VER_MINOR)
+
+#ifndef RMR_VER_STRING
+#define RMR_VER_STRING __stringify(RMR_PROTO_VER_MAJOR) "." \
+			 __stringify(RMR_PROTO_VER_MINOR)
+#endif
+
+/* TODO: should be configurable */
+#define RTRS_PORT 1234
+
+#define RMR_POOL_MAX_SESS 4
+
+/**
+ * enum rmr_msg_types - RMR message types
+ * @RMR_MSG_JOIN_POOL:      Join pool message from client to server
+ * @RMR_MSG_JOIN_POOL_RSP:  Join pool messge response from server to client
+ * @RMR_MSG_LEAVE_POOL:     Leave pool message from client to server
+ * @RMR_MSG_IO:             IO(read/write) request on an object
+ */
+enum rmr_msg_type {
+	RMR_MSG_CMD,
+	RMR_MSG_CMD_RSP,
+	RMR_MSG_IO,
+	RMR_MSG_MD,
+	RMR_MSG_MAP_CLEAR,
+	RMR_MSG_MAP_ADD,
+};
+
+/**
+ * struct rmr_msg_hdr - header of RMR messages
+ * @type:	Message type, valid values see: enum rmr_msg_types
+ */
+struct rmr_msg_hdr {
+	__le32		group_id; /* poolname jhash() */
+	__le16		type;
+	__le16		__padding;
+};
+
+/**
+ * struct rmr_msg_io - message for object I/O read/write
+ * @hdr:	message header
+ * @id_a:	first 64bit of the object id
+ * @id_b:	second 64bit of the object id
+ * @offset:	offset from where to read/write
+ * @flags:	bitmask, valid values are defined in enum rmr_io_flags
+ * @length:	number of bytes for I/O read/write
+ * @pool_id:	pool id to which the object belongs
+ */
+struct rmr_msg_io {
+	struct rmr_msg_hdr hdr;
+	__le64		id_a;
+	__le64		id_b;
+
+	__le32		offset;
+	__le32		length;
+	__le32		flags;
+	__le16          prio;
+
+	__le32		mem_id;
+	__le64		map_ver;
+	u8		failed_id[RMR_POOL_MAX_SESS];
+	u8		failed_cnt;
+
+	u8		member_id;
+	u8		sync;
+	u8		__padding[19]; //padding is not correct now i think
+};
+
+struct rmr_pool_member_info {
+	u8	no_of_stor;
+
+	struct per_mem_info {
+		u8	member_id;
+		u8	c_dirty;
+	} p_mem_info[RMR_POOL_MAX_SESS];
+};
+
+/**
+ * enum rmr_msg_cmd_types - RMR command types
+ * @RMR_CMD_MAP_READY: Get ready to receive map
+ * @RMR_CMD_MAP_SEND:  Send map to certain node
+ * @RMR_CMD_MAP_DONE:  Confirm map receipt
+ *
+ * When adding a command,
+ * make sure to add it to the function rmr_get_cmd_name.
+ */
+enum rmr_msg_cmd_type {
+	RMR_CMD_MAP_READY,	// 0
+	RMR_CMD_MAP_SEND,
+	RMR_CMD_SEND_MAP_BUF,
+	RMR_CMD_MAP_BUF_DONE,
+	RMR_CMD_MAP_DONE,
+	RMR_CMD_MAP_DISABLE,
+	RMR_CMD_READ_MAP_BUF,
+	RMR_CMD_MAP_CHECK,
+	RMR_CMD_LAST_IO_TO_MAP,
+	RMR_CMD_STORE_CHECK,
+	RMR_CMD_MAP_TEST,
+	/* sends the metadata of non-sync rmr-client to server */
+	RMR_CMD_SEND_MD_BUF,
+	/*sends the message of discards to the node */
+	RMR_CMD_SEND_DISCARD,
+	/* sends the message of md_update to the node; the node sends its srv_md back. */
+	RMR_CMD_MD_SEND,
+
+	RMR_CMD_MAP_GET_VER,	// 14
+	RMR_CMD_MAP_SET_VER,
+	RMR_CMD_DISCARD_CLEAR_FLAG,
+
+	/*
+	 * Add map related commands above this
+	 */
+	RMR_MAP_CMD_MAX,
+
+	RMR_CMD_POOL_INFO,	// 18
+	RMR_CMD_JOIN_POOL,
+
+	RMR_CMD_REJOIN_POOL,
+
+	RMR_CMD_LEAVE_POOL,
+	RMR_CMD_ENABLE_POOL,	// 22
+
+	RMR_CMD_USER,
+
+	/*
+	 * Add pool related commands above this
+	 */
+	RMR_POOL_CMD_MAX,
+};
+
+struct rmr_msg_map_send_cmd {
+	u8	receiver_member_id;
+};
+
+struct rmr_msg_map_buf_cmd {
+	u64	version;
+	u8	map_idx;
+	u64	slp_idx;
+};
+
+struct rmr_msg_map_buf_done_cmd {
+	u64	map_version;
+};
+
+struct rmr_msg_map_done_cmd {
+	u8	enable;
+};
+
+struct rmr_msg_send_md_buf_cmd {
+	u8	sync;	/* if the pool is sync or not */
+	u8	sender_id;
+	u8	receiver_id;
+	u64	flags;
+};
+
+struct rmr_msg_send_discard_cmd {
+	u8	member_id;	/* the storage node that discards all data */
+};
+
+struct rmr_msg_md_send_cmd {
+	u64	src_mapped_size; /* the pool mapped size on the sending side */
+	u8	sender_id;
+	u8	leader_id;
+	u8	read_full_md;	/* 1 = return full pool_md; 0 = own entry only */
+};
+
+struct rmr_msg_pool_info_cmd {
+	u8	member_id;
+	u8	operation;	/* add/remove */
+	u8	mode;		/* For add -> create/assemble. For remove -> delete/disassemble */
+	u8	dirty;		/* Valid only when operation=ADD and mode=CREATE */
+};
+
+enum rmr_pool_info_op {
+	RMR_POOL_INFO_OP_ADD = 0,
+	RMR_POOL_INFO_OP_REMOVE,
+};
+
+enum rmr_pool_info_mode {
+	RMR_POOL_INFO_MODE_CREATE = 0,
+	RMR_POOL_INFO_MODE_ASSEMBLE,
+	RMR_POOL_INFO_MODE_DELETE,
+	RMR_POOL_INFO_MODE_DISASSEMBLE,
+};
+
+struct rmr_msg_set_map_ver_cmd {
+	u8	map_ver; /* the map version to set */
+};
+
+struct rmr_msg_join_pool_cmd {
+	u64	queue_depth;
+	u32	chunk_size;
+	struct rmr_pool_member_info	mem_info;
+	u8	dirty;
+	u8	create;
+	u8	rejoin;
+};
+
+struct rmr_msg_leave_pool_cmd {
+	u8	member_id;
+	u8	delete;
+};
+
+struct rmr_msg_enable_pool_cmd {
+	u32	enable;
+};
+
+struct rmr_msg_user_cmd {
+	size_t usr_len;
+};
+
+struct rmr_msg_join_pool_cmd_rsp {
+	u64	mapped_size;
+	u32	chunk_size;
+};
+
+struct rmr_msg_pool_cmd {
+	struct rmr_msg_hdr	hdr;
+	u8			ver;
+	u8			cmd_type;
+	u8			sync;
+	u8			rsvd[1];
+	s8			pool_name[NAME_MAX];
+	union {
+		struct rmr_msg_map_send_cmd	map_send_cmd;
+		struct rmr_msg_map_buf_cmd	map_buf_cmd;
+		struct rmr_msg_map_buf_done_cmd	map_buf_done_cmd;
+		struct rmr_msg_map_done_cmd	map_done_cmd;
+
+		struct rmr_msg_send_md_buf_cmd	send_md_buf_cmd;
+		struct rmr_msg_send_discard_cmd send_discard_cmd;
+		struct rmr_msg_md_send_cmd	md_send_cmd;
+
+		struct rmr_msg_pool_info_cmd	pool_info_cmd;
+
+		struct rmr_msg_set_map_ver_cmd  set_map_ver_cmd;
+
+		struct rmr_msg_join_pool_cmd	join_pool_cmd;
+
+		struct rmr_msg_leave_pool_cmd	leave_pool_cmd;
+		struct rmr_msg_enable_pool_cmd	enable_pool_cmd;
+
+		struct rmr_msg_user_cmd		user_cmd;
+	};
+};
+
+struct rmr_msg_pool_cmd_rsp {
+	struct rmr_msg_hdr	hdr;
+	enum rmr_msg_cmd_type	cmd_type;
+	u8			err;
+	u8			ver;
+	u8			member_id;
+	union {
+		struct rmr_msg_join_pool_cmd_rsp	join_pool_cmd_rsp;
+		u64					value;
+	};
+};
+
+#endif /* RMR_PROTO_H */
diff --git a/drivers/infiniband/ulp/rmr/rmr-req.h b/drivers/infiniband/ulp/rmr/rmr-req.h
new file mode 100644
index 000000000000..8f15b36fe480
--- /dev/null
+++ b/drivers/infiniband/ulp/rmr/rmr-req.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Reliable multicast over RTRS (RMR)
+ *
+ * Copyright (c) 2026 IONOS SE
+ */
+
+#ifndef RMR_REQ_H
+#define RMR_REQ_H
+
+#include "rmr-pool.h"
+
+struct rmr_srv_req {
+	struct rmr_srv_pool *srv_pool;
+	rmr_id_t id;
+
+	u32 offset;
+	u32 length;
+	u32 flags;
+	u16 prio;
+
+	u32 mem_id;
+	struct rtrs_srv_op *rtrs_op;
+	struct rmr_srv_io_store *store;
+	void *data;
+	u32 datalen; //TODO: what is the difference between lenghth?
+	void (*endreq)(struct rmr_srv_req *, int err);
+	struct work_struct work;
+	int err;
+	u8 failed_cnt;
+	u8 failed_srv_id[RMR_POOL_MAX_SESS];
+	u64 map_ver;
+	void *priv;
+	struct llist_node node;
+	bool from_sync;
+	struct scatterlist sg;
+	struct rmr_iu *iu;
+	struct rmr_srv_req *parent;
+	bool sync;
+	struct rcu_head rcu;
+};
+
+struct rmr_srv_req *rmr_srv_req_create(const struct rmr_msg_io *msg,
+				       struct rmr_srv_pool *srv_pool,
+				       struct rtrs_srv_op *rtrs_op,
+				       void *data, u32 datalen,
+				       void (*endreq)(struct rmr_srv_req *, int));
+struct rmr_srv_req *rmr_srv_md_req_create(struct rmr_srv_pool *srv_pool,
+					  struct rtrs_srv_op *rtrs_op, void *data,
+					  u32 offset, u32 len, unsigned long flags,
+					  void (*endreq)(struct rmr_srv_req *, int));
+void rmr_req_submit(struct rmr_srv_req *req);
+void rmr_md_req_submit(struct rmr_srv_req *req);
+void rmr_srv_req_resp(struct rmr_srv_req *req, int err);
+void rmr_srv_md_req_resp(struct rmr_srv_req *req, int err);
+int rmr_srv_sync_chunk_id(struct rmr_srv_pool *srv_pool, struct rmr_map_entry *entry,
+			  rmr_id_t id, bool from_sync);
+
+void rmr_process_wait_list(struct rmr_map_entry *entry, int err);
+
+struct rmr_map_entry_info {
+	rmr_id_t id;
+	u8 srv_id;
+};
+#endif /* RMR_REQ_H */
diff --git a/drivers/infiniband/ulp/rmr/rmr-srv.h b/drivers/infiniband/ulp/rmr/rmr-srv.h
new file mode 100644
index 000000000000..a84586aa78bd
--- /dev/null
+++ b/drivers/infiniband/ulp/rmr/rmr-srv.h
@@ -0,0 +1,219 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Reliable multicast over RTRS (RMR)
+ *
+ * Copyright (c) 2026 IONOS SE
+ */
+
+#ifndef RMR_SRV_H
+#define RMR_SRV_H
+
+/* rmr-srv-sysfs.c */
+
+#include <linux/types.h>
+#include <linux/idr.h>
+#include <linux/kref.h>
+#include <linux/limits.h>
+#include <linux/kthread.h>
+
+#include "rmr-pool.h"
+
+/*
+ * IO store interface implemented by an upper-layer consumer of rmr-server.
+ * All consumer-specific types are passed as void * so RMR remains
+ * independent of any particular client.
+ */
+struct rmr_srv_store_ops {
+	int (*submit_req)(void *device, void *data, u32 offset, u32 length,
+			  unsigned long flags, u16 prio, void *priv);
+	int (*submit_md_req)(void *device, void *data, u32 offset, u32 length,
+			     unsigned long flags, void *priv);
+	int (*submit_cmd)(void *device, const void *usr_buf, int usr_len,
+			  void *data, int datalen);
+	bool (*io_allowed)(void *store_priv);
+	int (*get_params)(void *device);
+};
+
+#define DEFAULT_SYNC_QUEUE_DEPTH 32
+#define RMR_SRV_CHECK_MAPS_INTERVAL_MS 3000
+#define RMR_SRV_MD_SYNC_INTERVAL_MS 500
+#define RMR_SRV_DISCARD_TIMEOUT_MS 500
+
+/* Bit indices for srv_pool->md_dirty — used with set_bit / test_and_clear_bit */
+enum rmr_srv_md_dirty_bit {
+	MD_DIRTY_POOL,		/* pool_md fields changed */
+	MD_DIRTY_MAPS,		/* map bitmap changed */
+	MD_DIRTY_LAST_IO,	/* last_io updated */
+};
+
+extern struct kmem_cache *rmr_req_cachep;
+extern struct kmem_cache *rmr_map_entry_cachep;
+
+enum rmr_srv_register_disk_mode {
+	RMR_SRV_DISK_CREATE,	/* Fresh store, new pool */
+	RMR_SRV_DISK_ADD,	/* Rejoin an existing pool */
+	RMR_SRV_DISK_REPLACE,	/* Replace an existing store */
+};
+
+/*
+ * When adding state, remember to add an entry in the function rmr_get_srv_pool_state_name()
+ */
+enum rmr_srv_pool_state {
+	RMR_SRV_POOL_STATE_EMPTY,
+	RMR_SRV_POOL_STATE_REGISTERED,
+	RMR_SRV_POOL_STATE_CREATED,
+	RMR_SRV_POOL_STATE_NORMAL,
+	RMR_SRV_POOL_STATE_NO_IO,
+};
+
+struct rmr_srv_pool {
+	u8			member_id;
+	refcount_t		refcount;
+	atomic_t		state;
+	bool			maintenance_mode;
+
+	struct rmr_pool		*pool;
+
+	/* Sync thread */
+	struct task_struct	*th_tsk;
+	atomic_t		thread_state;
+	atomic_t		in_flight_sync_reqs;
+
+	struct rmr_srv_io_store	*io_store;
+	struct mutex		srv_pool_lock;
+	atomic_t		store_state;
+
+	bool			marked_create;
+	bool			marked_delete;
+
+	unsigned long           md_dirty;  /* bitmask of dirty regions */
+	unsigned long           map_update_state;
+	/* The internal client pool assigned to this server pool. */
+	struct rmr_pool         *clt;
+	size_t			queue_depth;
+	rmr_id_t		*last_io;
+	/*
+	 *  Each storage node keeps a command array with the length of queue depth to track the IOs
+	 *  in the last round. Use an array of chunk indexes as a copy of srv_pool->last_io so that
+	 *  it can be written back to/read from backing store as needed.
+	 */
+	rmr_id_t		*last_io_idx;
+
+	u32			max_sync_io_size;
+	struct workqueue_struct *clean_wq;
+	struct delayed_work	clean_dwork;
+
+	struct workqueue_struct *md_sync_wq;
+	struct delayed_work	md_sync_dwork;
+	struct delayed_work	last_io_sync_dwork;
+};
+
+/**
+ * rmr_srv_mark_pool_md_dirty() - Set MD_DIRTY_POOL and schedule delayed sync
+ * @srv_pool:	Server pool with changed pool_md fields
+ */
+static inline void rmr_srv_mark_pool_md_dirty(struct rmr_srv_pool *srv_pool)
+{
+	set_bit(MD_DIRTY_POOL, &srv_pool->md_dirty);
+	mod_delayed_work(srv_pool->md_sync_wq, &srv_pool->md_sync_dwork,
+			 msecs_to_jiffies(RMR_SRV_MD_SYNC_INTERVAL_MS));
+}
+
+struct rmr_srv_sess {
+	struct list_head pool_sess_list;
+	struct rtrs_srv_sess *rtrs;
+	struct kobject		kobj;
+	char			sessname[NAME_MAX];
+	struct mutex		lock;
+	u8			ver;
+	struct xarray		pools;
+	struct list_head g_list_entry;
+};
+
+struct rmr_srv_pool_sess {
+	struct list_head pool_entry; /* for pool->sess_list */
+	struct list_head srv_sess_entry;
+	struct rmr_srv_pool *srv_pool;
+	struct kobject kobj;
+	char sessname[NAME_MAX];
+	struct rmr_srv_sess *srv_sess;
+	bool sync;
+};
+
+struct rmr_srv_io_store {
+	struct rmr_srv_store_ops *ops;
+	void *priv;
+};
+
+struct rmr_cmd_work_info {
+	struct work_struct		cmd_work;
+	struct rmr_pool			*pool;
+	struct rmr_srv_sess *sess;
+	struct rtrs_srv_sess		*rtrs;
+	const struct rmr_msg_pool_cmd	*cmd_msg;
+	struct rmr_msg_pool_cmd_rsp	*rsp;
+	struct rtrs_srv_op		*rtrs_op;
+	void				*data;
+	size_t				datalen;
+};
+
+void rmr_put_srv_pool(struct rmr_srv_pool *srv_pool);
+struct rmr_srv_pool *rmr_create_srv_pool(char *poolname, u32 member_id);
+void rmr_srv_pool_update_params(struct rmr_pool *pool);
+int rmr_srv_read_md(struct rmr_pool *pool, struct rtrs_srv_op *rtrs_op, u32 offset, u32 len,
+		    struct rmr_pool_md *pool_md_page);
+int rmr_srv_send_md_update(struct rmr_pool *pool);
+int rmr_srv_check_params(struct rmr_srv_pool *srv_pool);
+void rmr_srv_mark_maps_dirty(struct rmr_srv_pool *srv_pool);
+
+/* rmr-srv-md.c */
+struct rmr_srv_req;	/* forward decl for endreq prototype */
+
+bool rmr_get_srv_pool(struct rmr_srv_pool *srv_pool);
+void rmr_srv_endreq(struct rmr_srv_req *req, int err);
+
+int process_md_io(struct rmr_pool *pool, struct rtrs_srv_op *rtrs_op,
+		  u32 offset, u32 len, unsigned long flags, void *buf);
+void rmr_srv_md_maps_sync(struct rmr_pool *pool);
+void rmr_srv_flush_pool_md(struct rmr_srv_pool *srv_pool);
+void rmr_srv_md_sync(struct work_struct *work);
+int rmr_srv_md_process_buf(struct rmr_pool *pool, void *buf, bool sync);
+int rmr_srv_refresh_md(struct rmr_srv_pool *srv_pool);
+
+/* rmr-srv-sysfs.c */
+
+int rmr_srv_create_sysfs_files(void);
+void rmr_srv_destroy_sysfs_files(void);
+void rmr_srv_destroy_pool_sysfs_files(struct rmr_pool *pool,
+				      const struct attribute *sysfs_self);
+int rmr_srv_sysfs_add_sess(struct rmr_pool *pool,
+			   struct rmr_srv_pool_sess *pool_sess);
+void rmr_srv_sysfs_del_sess(struct rmr_srv_pool_sess *pool_sess);
+
+void rmr_srv_free_sync_permits(struct rmr_pool *pool);
+void rmr_srv_destroy_pool(struct rmr_pool *pool);
+int rmr_srv_remove_clt_pool(struct rmr_srv_pool *srv_pool);
+
+void rmr_srv_stop_sync_and_go_offline(struct rmr_pool *pool);
+
+int rmr_srv_get_sync_permit(struct rmr_srv_pool *srv_pool);
+void rmr_srv_put_sync_permit(struct rmr_srv_pool *srv_pool);
+
+int rmr_srv_sync_thread_start(struct rmr_srv_pool *srv_pool);
+int rmr_srv_sync_thread_stop(struct rmr_srv_pool *srv_pool);
+
+void rmr_srv_sync_req_failed(struct rmr_srv_pool *srv_pool);
+
+int rmr_srv_query(struct rmr_pool *pool, u64 mapped_size, struct rmr_attrs *attr);
+/* register/unregister rmr-srv */
+struct rmr_pool *rmr_srv_register(char *poolname, struct rmr_srv_store_ops *ops, void *priv,
+				  u64 mapped_size, enum rmr_srv_register_disk_mode mode);
+void rmr_srv_unregister(char *poolname, bool delete);
+
+int rmr_srv_pool_cmd_with_rsp(struct rmr_pool *pool, rmr_conf_fn *conf, void *priv,
+			     const struct kvec *usr_vec, size_t nr, void *buf, int buf_len,
+			     size_t size);
+int rmr_srv_discard_id(struct rmr_pool *pool, u64 offset, u64 length, u8 member_id, bool sync);
+void rmr_srv_replace_store(struct rmr_pool *pool);
+
+#endif /* RMR_SRV_H */
diff --git a/drivers/infiniband/ulp/rmr/rmr.h b/drivers/infiniband/ulp/rmr/rmr.h
new file mode 100644
index 000000000000..72d591ccc047
--- /dev/null
+++ b/drivers/infiniband/ulp/rmr/rmr.h
@@ -0,0 +1,229 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Reliable multicast over RTRS (RMR)
+ *
+ * Copyright (c) 2026 IONOS SE
+ */
+
+#ifndef RMR_H
+#define RMR_H
+
+#include <linux/scatterlist.h>
+#include <linux/kobject.h>
+#include <rtrs.h>
+
+#include "rmr-proto.h"
+struct rmr_pool;
+
+typedef void (rmr_conf_fn)(void *priv, int errno);
+enum rmr_wait_type {
+	NO_WAIT = RTRS_PERMIT_NOWAIT,
+	WAIT = RTRS_PERMIT_WAIT
+};
+
+/*
+ * Here goes RMR client API
+ */
+
+/**
+ * inverse operation. decrements refcount
+ * and free if it reaches 0.
+ */
+void rmr_clt_put_pool(struct rmr_pool *pool);
+
+/**
+ * enum rmr_clt_link_ev - Events about connectivity state of a client
+ * @RMR_CLT_LINK_EV_RECONNECTED	Client was reconnected.
+ * @RMR_CLT_LINK_EV_DISCONNECTED	Client was disconnected.
+ */
+enum rmr_clt_link_ev {
+	RMR_CLT_LINK_EV_RECONNECTED,
+	RMR_CLT_LINK_EV_DISCONNECTED,
+};
+
+typedef void (rmr_clt_ev_fn)(void *priv, enum rmr_clt_link_ev ev);
+/**
+ * rmr_clt_open() - Opens a pool from the RMR client
+ * @priv:	User supplied private data.
+ * @link_ev:	Event notification for connection state changes
+ * @priv:	user supplied data that was passed to rmr_clt_open()
+ * @ev:		Occurred event
+ * @poolname:	name of the pool
+ *
+ * Only one user can open a pool at the same time.
+ * However administrative operations are possible.
+ *
+ * Return a valid pointer on success otherwise PTR_ERR.
+ */
+struct rmr_pool *rmr_clt_open(void *priv, rmr_clt_ev_fn *link_ev, const char *poolname);
+
+/**
+   returns the priv data that had been provided with open()
+*/
+void *rmr_clt_get_priv(struct rmr_pool *pool);
+
+/**
+ * rmr_clt_close() - Closes a pool
+ * @pool: Pool handler, is freed on return
+ */
+void rmr_clt_close(struct rmr_pool *pool);
+
+#define RMR_OP_BITS 8
+#define RMR_OP_MASK ((1 << RMR_OP_BITS) - 1)
+
+/**
+ * enum rmr_io_flags - RMR request types from rq_flag_bits
+ * @RMR_OP_READ:		read object
+ * @RMR_OP_WRITE:		write object
+ * @RMR_OP_DISCARD:		remove object
+ * @RMR_OP_SYNCREQ:		sync request
+ * @RMR_OP_WRITE_ZEROES:	write zeroes
+ * @RMR_OP_FLUSH:		flush object
+ * @RMR_OP_MD_READ:		read metadata of rmr
+ * @RMR_OP_MD_WRITE:		write metadata of rmr
+ */
+enum rmr_io_flags {
+	/* Operations */
+	RMR_OP_READ = 0,
+	RMR_OP_WRITE = 1,
+	RMR_OP_DISCARD = 2,
+	RMR_OP_SYNCREQ = 3,
+	RMR_OP_WRITE_ZEROES = 4,
+	RMR_OP_FLUSH = 5,
+	/* Add metadata related operations below this. */
+	RMR_OP_MD_READ = 6,
+	RMR_OP_MD_WRITE = 7,
+
+	/* Flags */
+	RMR_F_SYNC = 1 <<(RMR_OP_BITS + 0), // 0x100, 0b0100000000
+	RMR_F_FUA = 1 <<(RMR_OP_BITS + 1),  // 0x200, 0b1000000000
+};
+
+static inline u32 rmr_op(u32 flag)
+{
+	return flag & RMR_OP_MASK;
+}
+
+static inline u32 rmr_flags(u32 flag)
+{
+	return flag & ~RMR_OP_MASK;
+}
+
+/**
+ * Something to keep the 128 bit block_id (a.k.a object_id)
+ */
+typedef struct {
+	u64 a;
+	u64 b;
+} rmr_id_t;
+
+struct rmr_iu;
+
+/**
+ * rmr_clt_get_iu() - allocates iu for future RDMA operation
+ * @pool:	Current pool
+ * @id:		Id of the object/block
+ * @flag:       READ/WRITE/REMOVE
+ * @wait:       WAIT/NO_WAIT
+ *
+ * Description:
+ *    Allocates iu for the following RDMA operation.  Iu is used
+ *    to preallocate all resources and to propagate memory pressure
+ *    up earlier.
+ *
+ */
+struct rmr_iu *rmr_clt_get_iu(struct rmr_pool *pool,
+			      enum rmr_io_flags flag,
+			      enum rmr_wait_type wait);
+
+/**
+ * rmr_clt_put_iu() - puts allocated iu
+ * @pool:	Current pool
+ * @id:		Id of the object/block
+ * @flag:       READ/WRITE/REMOVE
+ * @iu:		Iu to be freed
+ *
+ * Context:
+ *    Does not matter
+ */
+void rmr_clt_put_iu(struct rmr_pool *pool, struct rmr_iu *iu);
+
+/**
+ * rmr_clt_request() - Request data transfer to/from server via RDMA.
+ *
+ *
+ * @pool:	The Pool
+ * @iu:		Iu allocated by pevious rmr_clt_get_iu call.
+ * @offset:	offset inside the object to read/write:
+ * @length:	length of data starting from offset
+ * @flag:	READ/WRITE/REMOVE
+ * @prio:	priority of IO
+ * @priv:	User provided data, passed back with corresponding
+ *		@(conf) confirmation.
+ * @conf:	callback function to be called as confirmation
+ * @sg:		Pages to be sent/received to/from server.
+ * @sg_cnt:	Number of elements in the @sg
+ *
+ * Return:
+ * 0:		Success
+ * -EAGAIN:	Currently there are no resources to execute the request.
+ *              Retry again later.
+ * <0:		Error
+ *
+ * On flag=READ rtrs client will request a data transfer from Server to client.
+ * The data that the server will respond with will be stored in @sg when
+ * the user confirmation function is called.
+ * On flag=WRITE rtrs client will rdma write data in sg to server side.
+ */
+int rmr_clt_request(struct rmr_pool *pool, struct rmr_iu *iu,
+		    size_t offset, size_t length, enum rmr_io_flags flag, unsigned short prio,
+		    void *priv, rmr_conf_fn *conf, struct scatterlist *sg, unsigned int sg_cnt);
+
+int rmr_clt_cmd_with_rsp(struct rmr_pool *pool, rmr_conf_fn *conf, void *priv,
+			 const struct kvec *usr_vec, size_t nr, void *buf, int buf_len,
+			 size_t size);
+
+
+/**
+ * rmr_attrs - RMR pool attributes
+ */
+struct rmr_attrs {
+	u32	queue_depth;
+	u32	max_io_size;
+	u32	chunk_size;
+	u32 	max_segments;
+	u64	rmr_md_size; /* in sectors */
+	u8	sync;
+	struct kobject *pool_kobj;
+};
+
+/**
+ * rmr_clt_query() - queries RMR pool attributes
+ *
+ * Returns:
+ *    0 on success
+ *    -EINVAL		no session in the pool
+ */
+int rmr_clt_query(struct rmr_pool *pool, struct rmr_attrs *attr);
+
+typedef enum {
+	RMR_MAP_ADD,
+	RMR_MAP_REMOVE,
+} rmr_map_cmd;
+
+#define RMR_STORE_ID_BITS   32
+#define RMR_STORE_ID_OFFSET (64 - RMR_STORE_ID_BITS)
+
+#define RMR_CHUNK_BITS	 32
+#define RMR_CHUNK_OFFSET 0
+
+enum rmr_pool_state {
+	RMR_POOL_STATE_CREATED = 0,
+	RMR_POOL_STATE_JOINED,
+	RMR_POOL_STATE_ONLINE,
+	/* maybe we will use this later */
+	RMR_POOL_STATE_DEGRADED,
+	RMR_POOL_STATE_SYNCING,
+};
+
+#endif
-- 
2.43.0


