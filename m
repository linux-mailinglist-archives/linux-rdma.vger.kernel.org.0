Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7601BA5BD
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2020 16:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgD0OLN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Apr 2020 10:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbgD0OLM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Apr 2020 10:11:12 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FB5C03C1A7
        for <linux-rdma@vger.kernel.org>; Mon, 27 Apr 2020 07:11:11 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id d15so19110607wrx.3
        for <linux-rdma@vger.kernel.org>; Mon, 27 Apr 2020 07:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IeH18tv77fAQvFr1Jks8T1IR/i3hK0ZYok4Cp+keg68=;
        b=hcug7QBHvocQBQedm/0mp33cODS1NkMd6+X+Shb50plcWHSsFRyIfqvK9AXnJaCo4m
         1N277zr367vnEQJgzxVsQ/2OKj6UDLyxPfpu0t2Q7iYN53LVpLNJJ9Mb3QQCjAqVe/cE
         GUMQ3nqszhygT/+MIeRVScbua+HoeE9E3vXUj6y+9St9LEB739tYTpWBn53t/iPFAV3A
         vp3IxwivI2p+2ex9hidR0hYS70EYa2ktV+E04SvmHcY7CjiOOGVLryWmNzD7hTa57qEH
         IcWHIyRkkX/I2fgcc5HUbQGkpMLHRuVaWR2a29/RHgmIsLlvdYc3bOIV2LAWLRP68qq9
         O20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IeH18tv77fAQvFr1Jks8T1IR/i3hK0ZYok4Cp+keg68=;
        b=eVdMZ9fPNxzdJ0ZFEfGRSEUwxwf2W8RcDmuSOKDVXKgD8dKol82LSzGhLwBcGRqTXE
         gJPdD7pxgYErExUeDwufgg/Go8lme6tilZzxf2f6fxf+7QvWNs9E5sp4wjBksDqlbw3R
         8LMQAQZGV1ie15O4O924FpPEZpmMcV9stNamd5cS8FiY/hRlqlSmqpWbGrRgeSfBcZbJ
         VlFduhuU8H3iGZUIX3jXc6q9yRdRnqCyb3l9YC0ulwJ+EiTF4fUQw8PIOFmSwmFe3gKe
         9jIlrTT7RVRm0pdd/jFnR3SNV9g/UI81BPezEnmNrI+wpDZA9GAKrZa21YT8yhhLAshX
         6bsw==
X-Gm-Message-State: AGi0PuZjbztfpHW12MSCRbpBnH9jWSqoiPmZVZJkJYY+eSQ3kPURT/vp
        yi7/ydkMV8JfiqRiqYjfDCny
X-Google-Smtp-Source: APiQypIiBQHU8rkDWBo0ud6Jee078IBuublNxwoQ+f+4gEUySzHkX+bVfQ5U5ujKFd+Q2IqqHMKalA==
X-Received: by 2002:a5d:664f:: with SMTP id f15mr26414769wrw.72.1587996670066;
        Mon, 27 Apr 2020 07:11:10 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-227-207.002.204.pools.vodafone-ip.de. [2.204.227.207])
        by smtp.gmail.com with ESMTPSA id o3sm21499756wru.68.2020.04.27.07.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 07:11:09 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: [PATCH v13 02/25] RDMA/rtrs: public interface header to establish RDMA connections
Date:   Mon, 27 Apr 2020 16:09:57 +0200
Message-Id: <20200427141020.655-3-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200427141020.655-1-danil.kipnis@cloud.ionos.com>
References: <20200427141020.655-1-danil.kipnis@cloud.ionos.com>
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

