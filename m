Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3536FC2AB3
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 01:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbfI3XRY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Sep 2019 19:17:24 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38125 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729057AbfI3XRY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Sep 2019 19:17:24 -0400
Received: by mail-pl1-f196.google.com with SMTP id w8so4039159plq.5
        for <linux-rdma@vger.kernel.org>; Mon, 30 Sep 2019 16:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jaWZU2wf7vKjpO8vNoRcYWOSkiD/1uNaWrL8xtDVNMM=;
        b=O+OHxO+oZZQGXnO9qzy2rdQYAsg6dt6yUTdsfMmIBzUgiDQ1kG9Qf/0b+kPEWWsunw
         p4Yvp/nhAaMzP7Z617lWHfM32V67nyqUK77Yo5c/QbTB8YRm7SJ4S4QcO7275Bn/T+e8
         p/j35vSPyPTZ7b06AmZfWy1hG/kbHne0PwOaJrKh5jfomEpompoeSrzP1Kanrw+/GeCg
         XwkU6I/j1MeVNSq+h9N0Td+AyopWC2m7nLAJK7uPihWb0MD2z/d0HNWAW89/talhsnMl
         PQJ+whXDtgZgPYbgzlGTHVD0FN6/cEhHW4bPE9lDBFVoXAhcsh/NRFiZM9B5WetXhVoD
         0zvA==
X-Gm-Message-State: APjAAAW4ZxhNjh5AmQ99CcGDjDl280XKfDoXA7ZMo21YS51twGbAQ4By
        AFckkI4k+lZhWjdMN6i41SU=
X-Google-Smtp-Source: APXvYqwtHPVerkFurN9QtSWN2DIankIfA8Ee2Grm0PdzvSawhCtL1SAyS9TQuPfS7dWrskH24mpSuw==
X-Received: by 2002:a17:902:8e86:: with SMTP id bg6mr12411916plb.212.1569885442565;
        Mon, 30 Sep 2019 16:17:22 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id l7sm585406pjy.12.2019.09.30.16.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 16:17:21 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH 03/15] RDMA/siw: Simplify several debug messages
Date:   Mon, 30 Sep 2019 16:16:55 -0700
Message-Id: <20190930231707.48259-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
In-Reply-To: <20190930231707.48259-1-bvanassche@acm.org>
References: <20190930231707.48259-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Do not print the remote address if it is not used. Use %pISp instead
of %pI4 %d.

Cc: Bernard Metzler <bmt@zurich.ibm.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/sw/siw/siw_cm.c | 36 ++++++------------------------
 1 file changed, 7 insertions(+), 29 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 8c1931a57f4a..5a75deb9870b 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1373,22 +1373,8 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 		rv = -EINVAL;
 		goto error;
 	}
-	if (v4)
-		siw_dbg_qp(qp,
-			   "pd_len %d, laddr %pI4 %d, raddr %pI4 %d\n",
-			   pd_len,
-			   &((struct sockaddr_in *)(laddr))->sin_addr,
-			   ntohs(((struct sockaddr_in *)(laddr))->sin_port),
-			   &((struct sockaddr_in *)(raddr))->sin_addr,
-			   ntohs(((struct sockaddr_in *)(raddr))->sin_port));
-	else
-		siw_dbg_qp(qp,
-			   "pd_len %d, laddr %pI6 %d, raddr %pI6 %d\n",
-			   pd_len,
-			   &((struct sockaddr_in6 *)(laddr))->sin6_addr,
-			   ntohs(((struct sockaddr_in6 *)(laddr))->sin6_port),
-			   &((struct sockaddr_in6 *)(raddr))->sin6_addr,
-			   ntohs(((struct sockaddr_in6 *)(raddr))->sin6_port));
+	siw_dbg_qp(qp, "pd_len %d, laddr %pISp, raddr %pISp\n", pd_len, laddr,
+		   raddr);
 
 	rv = sock_create(v4 ? AF_INET : AF_INET6, SOCK_STREAM, IPPROTO_TCP, &s);
 	if (rv < 0)
@@ -1935,7 +1921,7 @@ static void siw_drop_listeners(struct iw_cm_id *id)
 /*
  * siw_create_listen - Create resources for a listener's IWCM ID @id
  *
- * Listens on the socket addresses id->local_addr and id->remote_addr.
+ * Listens on the socket address id->local_addr.
  *
  * If the listener's @id provides a specific local IP address, at most one
  * listening socket is created and associated with @id.
@@ -1959,7 +1945,7 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 	 */
 	if (id->local_addr.ss_family == AF_INET) {
 		struct in_device *in_dev = in_dev_get(dev);
-		struct sockaddr_in s_laddr, *s_raddr;
+		struct sockaddr_in s_laddr;
 		const struct in_ifaddr *ifa;
 
 		if (!in_dev) {
@@ -1967,12 +1953,8 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 			goto out;
 		}
 		memcpy(&s_laddr, &id->local_addr, sizeof(s_laddr));
-		s_raddr = (struct sockaddr_in *)&id->remote_addr;
 
-		siw_dbg(id->device,
-			"laddr %pI4:%d, raddr %pI4:%d\n",
-			&s_laddr.sin_addr, ntohs(s_laddr.sin_port),
-			&s_raddr->sin_addr, ntohs(s_raddr->sin_port));
+		siw_dbg(id->device, "laddr %pISp\n", &s_laddr);
 
 		rtnl_lock();
 		in_dev_for_each_ifa_rtnl(ifa, in_dev) {
@@ -1992,17 +1974,13 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 	} else if (id->local_addr.ss_family == AF_INET6) {
 		struct inet6_dev *in6_dev = in6_dev_get(dev);
 		struct inet6_ifaddr *ifp;
-		struct sockaddr_in6 *s_laddr = &to_sockaddr_in6(id->local_addr),
-			*s_raddr = &to_sockaddr_in6(id->remote_addr);
+		struct sockaddr_in6 *s_laddr = &to_sockaddr_in6(id->local_addr);
 
 		if (!in6_dev) {
 			rv = -ENODEV;
 			goto out;
 		}
-		siw_dbg(id->device,
-			"laddr %pI6:%d, raddr %pI6:%d\n",
-			&s_laddr->sin6_addr, ntohs(s_laddr->sin6_port),
-			&s_raddr->sin6_addr, ntohs(s_raddr->sin6_port));
+		siw_dbg(id->device, "laddr %pISp\n", &s_laddr);
 
 		rtnl_lock();
 		list_for_each_entry(ifp, &in6_dev->addr_list, if_list) {
-- 
2.23.0.444.g18eeb5a265-goog

