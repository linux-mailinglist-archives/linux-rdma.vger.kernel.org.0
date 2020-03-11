Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C99D9181D47
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2020 17:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbgCKQMu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Mar 2020 12:12:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38884 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729989AbgCKQMu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Mar 2020 12:12:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id t11so3400233wrw.5
        for <linux-rdma@vger.kernel.org>; Wed, 11 Mar 2020 09:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jch5KwX3KI484eUgjQE3/zYoMuWyAgLdfwiUHwcFCYk=;
        b=CbUBm9CU69kbZsEU6WNt7dia+pwEfETBrA1LDTtOShEBYuOvbqqzQy+ZJt80SKE6jb
         H45GgidSpmdKQ5XX1rkBrr+ooqbnAmDdPQoGs3w/j6uIpYG4xmUopS4JRDNKrCUGYCAl
         HjxpuxBJY6ODreYllrCNC2QX5hJE9j6PvjgciDKVLACxdEhicr9nc1ac1F7kou10oA5B
         2R81J2sfFIL/kV44OGBmarFLGs2dD2KAwCMjyegZVpmOgaiaPoJcEmEuIXTinhQegMJg
         nEOt5qbEyDPEx/IHYOxVoOeyU84+9GgmbMwbvbd7tCUkXGGbgAepxBiUxU/76leeJoSO
         jZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jch5KwX3KI484eUgjQE3/zYoMuWyAgLdfwiUHwcFCYk=;
        b=bWYwVvJ+YVK+GFqa3rpnO8lR4FIlwBWgkmyVQJe4mZFEt28R2fg+pd3lgXQ20k0fvp
         atckL5SJvylgPq+EvNojSWFtGr4kMFuxxXpTs1p2fMboZOY+QkXdcTA9kvD57hPbzW8k
         S8u4NdV9scM+rSbdqDJWtam7pD806h13SA3Oir/Hmww8FU/EjcL/WSN7TsUCDL4IwLGy
         NoFEHT6DL889zsqGih9mmsrBoVy2O6dY7WaeIiQ6fBg0kkMXP8GvDRuo9fOPX9E/DKQn
         3zSFXfokv+TxgNyJSoCyX6oaO3kIbElMjOn5jPHF0VsG7EmI4UHjG6FLHdGznoN2+MnM
         ZKyw==
X-Gm-Message-State: ANhLgQ1FL42hlCPxQhLmGsZGPv8vAMH/P2hSbKkxwzqcNWVDwYM1PQe1
        Fa/7lCn+dU2Uj8SW0EpOLCnjgA==
X-Google-Smtp-Source: ADFU+vu+KaITlXZYrpd1aoLjFYapJGoB1BDyfnK9h7OOW/kPX5t7wXrgLZfkOqL+sgnMJSIHuVPqlg==
X-Received: by 2002:adf:fc81:: with SMTP id g1mr5448786wrr.410.1583943166484;
        Wed, 11 Mar 2020 09:12:46 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4963:f600:4938:8f65:9543:5ec9])
        by smtp.gmail.com with ESMTPSA id v13sm2739332wru.47.2020.03.11.09.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 09:12:45 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
Subject: [PATCH v10 02/26] RDMA/rtrs: public interface header to establish RDMA connections
Date:   Wed, 11 Mar 2020 17:12:16 +0100
Message-Id: <20200311161240.30190-3-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200311161240.30190-1-jinpu.wang@cloud.ionos.com>
References: <20200311161240.30190-1-jinpu.wang@cloud.ionos.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

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
 drivers/infiniband/ulp/rtrs/rtrs.h | 326 +++++++++++++++++++++++++++++
 1 file changed, 326 insertions(+)
 create mode 100644 drivers/infiniband/ulp/rtrs/rtrs.h

diff --git a/drivers/infiniband/ulp/rtrs/rtrs.h b/drivers/infiniband/ulp/rtrs/rtrs.h
new file mode 100644
index 000000000000..395d1112f155
--- /dev/null
+++ b/drivers/infiniband/ulp/rtrs/rtrs.h
@@ -0,0 +1,326 @@
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
+/**
+ * rtrs_clt_open() - Open a session to an RTRS server
+ * @ops: holds the link event callback and the private pointer.
+ * @sessname: name of the session
+ * @paths: Paths to be established defined by their src and dst addresses
+ * @path_cnt: Number of elements in the @paths array
+ * @port: port to be used by the RTRS session
+ * @pdu_sz: Size of extra payload which can be accessed after permit allocation.
+ * @max_inflight_msg: Max. number of parallel inflight messages for the session
+ * @max_segments: Max. number of segments per IO request
+ * @reconnect_delay_sec: time between reconnect tries
+ * @max_reconnect_attempts: Number of times to reconnect on error before giving
+ *			    up, 0 for * disabled, -1 for forever
+ *
+ * Starts session establishment with the rtrs_server. The function can block
+ * up to ~2000ms before it returns.
+ *
+ * Return a valid pointer on success otherwise PTR_ERR.
+ */
+struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
+				 const char *sessname,
+				 const struct rtrs_addr *paths,
+				 size_t path_cnt, u16 port,
+				 size_t pdu_sz, u8 reconnect_delay_sec,
+				 u16 max_segments,
+				 s16 max_reconnect_attempts);
+
+/**
+ * rtrs_clt_close() - Close a session
+ * @sess: Session handle. Session is freed upon return.
+ */
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
+/**
+ * rtrs_clt_get_permit() - allocates permit for future RDMA operation
+ * @sess:	Current session
+ * @con_type:	Type of connection to use with the permit
+ * @wait:	Wait type
+ *
+ * Description:
+ *    Allocates permit for the following RDMA operation.  Permit is used
+ *    to preallocate all resources and to propagate memory pressure
+ *    up earlier.
+ *
+ * Context:
+ *    Can sleep if @wait == RTRS_TAG_WAIT
+ */
+struct rtrs_permit *rtrs_clt_get_permit(struct rtrs_clt *sess,
+				    enum rtrs_clt_con_type con_type,
+				    int wait);
+
+/**
+ * rtrs_clt_put_permit() - puts allocated permit
+ * @sess:	Current session
+ * @permit:	Permit to be freed
+ *
+ * Context:
+ *    Does not matter
+ */
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
+/**
+ * rtrs_clt_request() - Request data transfer to/from server via RDMA.
+ *
+ * @dir:	READ/WRITE
+ * @conf:	callback function to be called as confirmation
+ * @sess:	Session
+ * @permit:	Preallocated permit
+ * @vec:	Message that is sent to server together with the request.
+ *		Sum of len of all @vec elements limited to <= IO_MSG_SIZE.
+ *		Since the msg is copied internally it can be allocated on stack.
+ * @nr:		Number of elements in @vec.
+ * @len:	length of data sent to/from server
+ * @sg:		Pages to be sent/received to/from server.
+ * @sg_cnt:	Number of elements in the @sg
+ *
+ * Return:
+ * 0:		Success
+ * <0:		Error
+ *
+ * On dir=READ rtrs client will request a data transfer from Server to client.
+ * The data that the server will respond with will be stored in @sg when
+ * the user receives an %RTRS_CLT_RDMA_EV_RDMA_REQUEST_WRITE_COMPL event.
+ * On dir=WRITE rtrs client will rdma write data in sg to server side.
+ */
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
+/**
+ * rtrs_clt_query() - queries RTRS session attributes
+ *
+ * Returns:
+ *    0 on success
+ *    -ECOMM		no connection to the server
+ */
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
+/**
+ * rtrs_srv_open() - open RTRS server context
+ * @ops:		callback functions
+ * @port:               port to listen on
+ *
+ * Creates server context with specified callbacks.
+ *
+ * Return a valid pointer on success otherwise PTR_ERR.
+ */
+struct rtrs_srv_ctx *rtrs_srv_open(struct rtrs_srv_ops *ops, unsigned int port);
+
+/**
+ * rtrs_srv_close() - close RTRS server context
+ * @ctx: pointer to server context
+ *
+ * Closes RTRS server context with all client sessions.
+ */
+void rtrs_srv_close(struct rtrs_srv_ctx *ctx);
+
+/**
+ * rtrs_srv_resp_rdma() - Finish an RDMA request
+ *
+ * @id:		Internal RTRS operation identifier
+ * @errno:	Response Code sent to the other side for this operation.
+ *		0 = success, <=0 error
+ *
+ * Finish a RDMA operation. A message is sent to the client and the
+ * corresponding memory areas will be released.
+ */
+bool rtrs_srv_resp_rdma(struct rtrs_srv_op *id, int errno);
+
+/**
+ * rtrs_srv_set_sess_priv() - Set private pointer in rtrs_srv.
+ * @sess:	Session
+ * @priv:	The private pointer that is associated with the session.
+ */
+void rtrs_srv_set_sess_priv(struct rtrs_srv *sess, void *priv);
+
+/**
+ * rtrs_srv_get_sess_name() - Get rtrs_srv peer hostname.
+ * @sess:	Session
+ * @sessname:	Sessname buffer
+ * @len:	Length of sessname buffer
+ */
+int rtrs_srv_get_sess_name(struct rtrs_srv *sess, char *sessname, size_t len);
+
+/**
+ * rtrs_addr_to_sockaddr() - convert path string "src,dst" to sockaddreses
+ * @str		string containing source and destination addr of a path
+ *		separated by comma. I.e. "ip:1.1.1.1,ip:1.1.1.2". If str
+ *		contains only one address it's considered to be destination.
+ * @len		string length
+ * @addr->dst	will be set to the destination sockadddr.
+ * @addr->src	will be set to the source address or to NULL
+ *		if str doesn't contain any sorce address.
+ *
+ * Returns zero if conversion successful. Non-zero otherwise.
+ */
+int rtrs_addr_to_sockaddr(const char *str, size_t len, short port,
+			  struct rtrs_addr *addr);
+
+/**
+ * sockaddr_to_str() - convert sockaddr to a string.
+ * @addr	the sockadddr structure to be converted.
+ * @buf		string containing socket addr.
+ * @len		string length.
+ *
+ * The return value is the number of characters written into buf not
+ * including the trailing '\0'. If len is == 0 the function returns 0..
+ */
+int sockaddr_to_str(const struct sockaddr *addr, char *buf, size_t len);
+#endif
-- 
2.17.1

