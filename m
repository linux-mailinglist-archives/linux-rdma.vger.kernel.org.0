Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A6D1CDBDD
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 15:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbgEKNxL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 09:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730179AbgEKNxK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 11 May 2020 09:53:10 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2C2C061A0C
        for <linux-rdma@vger.kernel.org>; Mon, 11 May 2020 06:53:08 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l18so11053698wrn.6
        for <linux-rdma@vger.kernel.org>; Mon, 11 May 2020 06:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IeH18tv77fAQvFr1Jks8T1IR/i3hK0ZYok4Cp+keg68=;
        b=AUJLz8dqFj5yoyR6K7x1Kdha2PgQdedfWc2YqZCThwI9IxPjLQ7efl17LqWuY+Bjom
         wYRq5I+wgFC9V0vkfg7K9KMPGSYUf+PJKVVNo/3tKZJ+uM6qxRe81cSuFfZuw+TwdRrp
         6wt06uLgMC7Unj/ErwvE5SkNH2yOyVzsc07dSyr7gE0vZMr6+TG4pZOcUjFTq9UGs8dl
         wldegMRu1pO+xGQ89Vn7lAUaXbqraA7T81z8i0xFplMKf9R5F/8Bq57Uq7qkS1qEw2be
         k/MZdh/POnHxOOvHeqLbenZ8h7sKAHEG/s5YMHNZK346BEqIb4zY/aX4h1Dj3c+itDE0
         Pw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IeH18tv77fAQvFr1Jks8T1IR/i3hK0ZYok4Cp+keg68=;
        b=P/sj9HzGiQ52vhS4Er6mYCHss50hBW+5zqGZmW/xhwYzkPNZ2JHT+0xZwiLd1omD+Q
         lq5UW6jxxieCa43n0I9GEllRQngsWgO+Qc6+0CZ43bI/BQSumg6E9IRq3r6VJ2N+Nq1p
         wn8+9WkzMSisRDH/eYIHLLTkDpA7qYxG/iMhG9JqWx16fsMJLnOGGTY7fbzhCvpxEPi+
         HhkCswoTduY2ppeT/FvComgR5nOmmCG7IMQzM6yAyx0HILQt3PXMtkGNbT4hKsAup7HL
         BLH/LmTh+V65//in8QSBcSK9UpU/2ZVciXQV+srYn9+LsoTF7iH9OzQAj2fIDCw+CSvK
         fydg==
X-Gm-Message-State: AGi0PuYLFhfRaBLBfnyjfBcwB6OVOsvIc5JH5eXVMQ6T0HXK03uicU78
        wJ3m/KNY+BV4tbwnLhAIPLyX
X-Google-Smtp-Source: APiQypJrdKidiQxGnROJMmz3j0qoG2hPJkaKwtrGwjZRoGFc4nGOcS8RcOfHBXEgi0Macq74/lbcYg==
X-Received: by 2002:a5d:4447:: with SMTP id x7mr19088599wrr.299.1589205187486;
        Mon, 11 May 2020 06:53:07 -0700 (PDT)
Received: from dkxps.local (dslb-002-204-227-207.002.204.pools.vodafone-ip.de. [2.204.227.207])
        by smtp.gmail.com with ESMTPSA id v205sm9220018wmg.11.2020.05.11.06.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 06:53:07 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: [PATCH v15 02/25] RDMA/rtrs: public interface header to establish RDMA connections
Date:   Mon, 11 May 2020 15:51:08 +0200
Message-Id: <20200511135131.27580-3-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511135131.27580-1-danil.kipnis@cloud.ionos.com>
References: <20200511135131.27580-1-danil.kipnis@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

Introduce public header which provides set of API functions to
establish RDMA connections from client to server machine using
RTRS protocol, which manages RDMA connections for each session,
does multipathing and load balancing.

Main functions for client (active) side:

 rtrs_clt_open() - Creates set of RDMA connections incapsulated
                    in IBTRS session and returns pointer on RTRS
		    session object.
 rtrs_clt_close() - Closes RDMA connections associated with RTRS
                     session.
 rtrs_clt_request() - Requests zero-copy RDMA transfer to/from
                       server.

Main functions for server (passive) side:

 rtrs_srv_open() - Starts listening for RTRS clients on specified
                    port and invokes RTRS callbacks for incoming
		    RDMA requests or link events.
 rtrs_srv_close() - Closes RTRS server context.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs.h | 195 +++++++++++++++++++++++++++++
 1 file changed, 195 insertions(+)
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs.h

diff --git a/drivers/infiniband/ulp/rtrs/rtrs.h b/drivers/infiniband/ulp/rtrs/rtrs.h
new file mode 100644
index 000000000000..9879d40467b6
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/rtrs.h
@@ -0,0 +1,195 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * RDMA Transport Layer
+ *
+ * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
+ * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
+ * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
+ */
+#ifndef RTRS_H
+#define RTRS_H
+
+#include <linux/socket.h>
+#include <linux/scatterlist.h>
+
+struct rtrs_permit;
+struct rtrs_clt;
+struct rtrs_srv_ctx;
+struct rtrs_srv;
+struct rtrs_srv_op;
+
+/*
+ * RDMA transport (RTRS) client API
+ */
+
+/**
+ * enum rtrs_clt_link_ev - Events about connectivity state of a client
+ * @RTRS_CLT_LINK_EV_RECONNECTED	Client was reconnected.
+ * @RTRS_CLT_LINK_EV_DISCONNECTED	Client was disconnected.
+ */
+enum rtrs_clt_link_ev {
+	RTRS_CLT_LINK_EV_RECONNECTED,
+	RTRS_CLT_LINK_EV_DISCONNECTED,
+};
+
+/**
+ * Source and destination address of a path to be established
+ */
+struct rtrs_addr {
+	struct sockaddr_storage *src;
+	struct sockaddr_storage *dst;
+};
+
+/**
+ * rtrs_clt_ops - it holds the link event callback and private pointer.
+ * @priv: User supplied private data.
+ * @link_ev: Event notification callback function for connection state changes
+ *	@priv: User supplied data that was passed to rtrs_clt_open()
+ *	@ev: Occurred event
+ */
+struct rtrs_clt_ops {
+	void	*priv;
+	void	(*link_ev)(void *priv, enum rtrs_clt_link_ev ev);
+};
+
+struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
+				 const char *sessname,
+				 const struct rtrs_addr *paths,
+				 size_t path_cnt, u16 port,
+				 size_t pdu_sz, u8 reconnect_delay_sec,
+				 u16 max_segments,
+				 s16 max_reconnect_attempts);
+
+void rtrs_clt_close(struct rtrs_clt *sess);
+
+/**
+ * rtrs_permit_to_pdu() - converts rtrs_permit to opaque pdu pointer
+ * @permit: RTRS permit pointer, it associates the memory allocation for future
+ *          RDMA operation.
+ */
+void *rtrs_permit_to_pdu(struct rtrs_permit *permit);
+
+enum {
+	RTRS_PERMIT_NOWAIT = 0,
+	RTRS_PERMIT_WAIT   = 1,
+};
+
+/**
+ * enum rtrs_clt_con_type() type of ib connection to use with a given
+ * rtrs_permit
+ * @ADMIN_CON - use connection reserved for "service" messages
+ * @IO_CON - use a connection reserved for IO
+ */
+enum rtrs_clt_con_type {
+	RTRS_ADMIN_CON,
+	RTRS_IO_CON
+};
+
+struct rtrs_permit *rtrs_clt_get_permit(struct rtrs_clt *sess,
+				    enum rtrs_clt_con_type con_type,
+				    int wait);
+
+void rtrs_clt_put_permit(struct rtrs_clt *sess, struct rtrs_permit *permit);
+
+/**
+ * rtrs_clt_req_ops - it holds the request confirmation callback
+ * and a private pointer.
+ * @priv: User supplied private data.
+ * @conf_fn:	callback function to be called as confirmation
+ *	@priv:	User provided data, passed back with corresponding
+ *		@(conf) confirmation.
+ *	@errno: error number.
+ */
+struct rtrs_clt_req_ops {
+	void	*priv;
+	void	(*conf_fn)(void *priv, int errno);
+};
+
+int rtrs_clt_request(int dir, struct rtrs_clt_req_ops *ops,
+		     struct rtrs_clt *sess, struct rtrs_permit *permit,
+		     const struct kvec *vec, size_t nr, size_t len,
+		     struct scatterlist *sg, unsigned int sg_cnt);
+
+/**
+ * rtrs_attrs - RTRS session attributes
+ */
+struct rtrs_attrs {
+	u32		queue_depth;
+	u32		max_io_size;
+	u8		sessname[NAME_MAX];
+	struct kobject	*sess_kobj;
+};
+
+int rtrs_clt_query(struct rtrs_clt *sess, struct rtrs_attrs *attr);
+
+/*
+ * Here goes RTRS server API
+ */
+
+/**
+ * enum rtrs_srv_link_ev - Server link events
+ * @RTRS_SRV_LINK_EV_CONNECTED:	Connection from client established
+ * @RTRS_SRV_LINK_EV_DISCONNECTED:	Connection was disconnected, all
+ *					connection RTRS resources were freed.
+ */
+enum rtrs_srv_link_ev {
+	RTRS_SRV_LINK_EV_CONNECTED,
+	RTRS_SRV_LINK_EV_DISCONNECTED,
+};
+
+struct rtrs_srv_ops {
+	/**
+	 * rdma_ev():		Event notification for RDMA operations
+	 *			If the callback returns a value != 0, an error
+	 *			message for the data transfer will be sent to
+	 *			the client.
+
+	 *	@sess:		Session
+	 *	@priv:		Private data set by rtrs_srv_set_sess_priv()
+	 *	@id:		internal RTRS operation id
+	 *	@dir:		READ/WRITE
+	 *	@data:		Pointer to (bidirectional) rdma memory area:
+	 *			- in case of %RTRS_SRV_RDMA_EV_RECV contains
+	 *			data sent by the client
+	 *			- in case of %RTRS_SRV_RDMA_EV_WRITE_REQ points
+	 *			to the memory area where the response is to be
+	 *			written to
+	 *	@datalen:	Size of the memory area in @data
+	 *	@usr:		The extra user message sent by the client (%vec)
+	 *	@usrlen:	Size of the user message
+	 */
+	int (*rdma_ev)(struct rtrs_srv *sess, void *priv,
+		       struct rtrs_srv_op *id, int dir,
+		       void *data, size_t datalen, const void *usr,
+		       size_t usrlen);
+	/**
+	 * link_ev():		Events about connectivity state changes
+	 *			If the callback returns != 0 and the event
+	 *			%RTRS_SRV_LINK_EV_CONNECTED the corresponding
+	 *			session will be destroyed.
+	 *	@sess:		Session
+	 *	@ev:		event
+	 *	@priv:		Private data from user if previously set with
+	 *			rtrs_srv_set_sess_priv()
+	 */
+	int (*link_ev)(struct rtrs_srv *sess, enum rtrs_srv_link_ev ev,
+		       void *priv);
+};
+
+struct rtrs_srv_ctx *rtrs_srv_open(struct rtrs_srv_ops *ops, u16 port);
+
+void rtrs_srv_close(struct rtrs_srv_ctx *ctx);
+
+bool rtrs_srv_resp_rdma(struct rtrs_srv_op *id, int errno);
+
+void rtrs_srv_set_sess_priv(struct rtrs_srv *sess, void *priv);
+
+int rtrs_srv_get_sess_name(struct rtrs_srv *sess, char *sessname, size_t len);
+
+int rtrs_srv_get_queue_depth(struct rtrs_srv *sess);
+
+int rtrs_addr_to_sockaddr(const char *str, size_t len, u16 port,
+			  struct rtrs_addr *addr);
+
+int sockaddr_to_str(const struct sockaddr *addr, char *buf, size_t len);
+#endif
-- 
2.20.1

