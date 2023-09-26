Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADE67AF4B2
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Sep 2023 22:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjIZUFV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Sep 2023 16:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235773AbjIZUFU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Sep 2023 16:05:20 -0400
Received: from mail-io1-xd49.google.com (mail-io1-xd49.google.com [IPv6:2607:f8b0:4864:20::d49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75565192
        for <linux-rdma@vger.kernel.org>; Tue, 26 Sep 2023 13:05:13 -0700 (PDT)
Received: by mail-io1-xd49.google.com with SMTP id ca18e2360f4ac-780addd7382so1233898139f.1
        for <linux-rdma@vger.kernel.org>; Tue, 26 Sep 2023 13:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695758712; x=1696363512; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3bPJjIsPmHmwi+Eu0+GyNZUXrMn22SrOLV+oVGGBzwU=;
        b=QdxdKR018VDb7P3I3YlQobzqnoLNRUnnCyIuGMfXhO9cqkO5AeiTcdqria2tHKPDqw
         wo2i8J7WCXOfI8amssYt0W3+RqJXhJ27F8F6YRyBmXzo+o5Tcqao8vUjxqMoJvjYzjnv
         lLX4BP13ETlo2B5wYSw+8IX5XvhhkPZBXnx/nAzM35gjVDFiCq0SWSspZDiifpEpPlxa
         cCfnM7yNy67zdgarNHxXAmptNAZm42yEhLU5QVXf1DNqnaKk8EBQqYedhkiEBJyFtvzH
         QgB25oVoXgBNvKH7Syx7latiVYRf7ARFpU/eqy6j21L/5jxx+q68OK265WvrHn54JYpl
         F2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695758712; x=1696363512;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3bPJjIsPmHmwi+Eu0+GyNZUXrMn22SrOLV+oVGGBzwU=;
        b=qE1K7/44OY5bwmN2ALzfsl4I1sM2d+kkXBhiAc2lBKYfEsIvZl9DQgTu31B5z2is3e
         cVtbtbF72iQsGBTGOcoVKtcSO3R7YxdfkTdCNudeeXbKNtKcVQOA4+3QcQzoZkqaxTAR
         AhS1z1HxVeARtWSP9ybi4ivChUoR2AwWslzK8iKe0TuEbjy6GiVZnM3xDMiaPAvK7OrL
         E5jZCPdlOtXIwyvS1DRo1rLpe3S3GuUcBm1Eg73Y9M+3xumB4xmu/ZY3Qd+au7d2T5zA
         5yEcASZmUhj2XbpthrBepN6dxKZBin0XoyQWfJ8b05Exh+/xTylHh+G+Ej3Hnrt5f3Hi
         PCFg==
X-Gm-Message-State: AOJu0YxuIS8et1uzG9Ea2+Beihmn9uU3o/7UiWrQg5vJnsaP01NpZ2zE
        7LF7qgD/iXmq+6LuySjeKz8UmJUGpw==
X-Google-Smtp-Source: AGHT+IEzIkpre/+4lLTj1Y3n0rLDVitTTn2Hh0vxS4CExp5VXmGekw+m4PiW3pEg4WIhcV6yD7AarCtsHA==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a05:6638:3a0c:b0:43c:e73c:74e7 with SMTP id
 cn12-20020a0566383a0c00b0043ce73c74e7mr39988jab.3.1695758712659; Tue, 26 Sep
 2023 13:05:12 -0700 (PDT)
Date:   Tue, 26 Sep 2023 15:05:03 -0500
In-Reply-To: <20230926200505.2804266-1-jrife@google.com>
Mime-Version: 1.0
References: <20230926200505.2804266-1-jrife@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230926200505.2804266-2-jrife@google.com>
Subject: [PATCH net v6 1/3] net: replace calls to sock->ops->connect() with kernel_connect()
From:   Jordan Rife <jrife@google.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, willemdebruijn.kernel@gmail.com,
        netdev@vger.kernel.org
Cc:     dborkman@kernel.org, horms@verge.net.au, pablo@netfilter.org,
        kadlec@netfilter.org, fw@strlen.de, santosh.shilimkar@oracle.com,
        ast@kernel.org, rdna@fb.com, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, coreteam@netfilter.org,
        netfilter-devel@vger.kernel.org, ja@ssi.bg,
        lvs-devel@vger.kernel.org, kafai@fb.com, daniel@iogearbox.net,
        daan.j.demeyer@gmail.com, Jordan Rife <jrife@google.com>,
        stable@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

commit 0bdf399342c5 ("net: Avoid address overwrite in kernel_connect")
ensured that kernel_connect() will not overwrite the address parameter
in cases where BPF connect hooks perform an address rewrite. This change
replaces direct calls to sock->ops->connect() in net with kernel_connect()
to make these call safe.

Link: https://lore.kernel.org/netdev/20230912013332.2048422-1-jrife@google.com/
Fixes: d74bad4e74ee ("bpf: Hooks for sys_connect")
Cc: stable@vger.kernel.org
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jordan Rife <jrife@google.com>
---
 net/netfilter/ipvs/ip_vs_sync.c | 4 ++--
 net/rds/tcp_connect.c           | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index da5af28ff57b5..6e4ed1e11a3b7 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1505,8 +1505,8 @@ static int make_send_sock(struct netns_ipvs *ipvs, int id,
 	}
 
 	get_mcast_sockaddr(&mcast_addr, &salen, &ipvs->mcfg, id);
-	result = sock->ops->connect(sock, (struct sockaddr *) &mcast_addr,
-				    salen, 0);
+	result = kernel_connect(sock, (struct sockaddr *)&mcast_addr,
+				salen, 0);
 	if (result < 0) {
 		pr_err("Error connecting to the multicast addr\n");
 		goto error;
diff --git a/net/rds/tcp_connect.c b/net/rds/tcp_connect.c
index f0c477c5d1db4..d788c6d28986f 100644
--- a/net/rds/tcp_connect.c
+++ b/net/rds/tcp_connect.c
@@ -173,7 +173,7 @@ int rds_tcp_conn_path_connect(struct rds_conn_path *cp)
 	 * own the socket
 	 */
 	rds_tcp_set_callbacks(sock, cp);
-	ret = sock->ops->connect(sock, addr, addrlen, O_NONBLOCK);
+	ret = kernel_connect(sock, addr, addrlen, O_NONBLOCK);
 
 	rdsdebug("connect to address %pI6c returned %d\n", &conn->c_faddr, ret);
 	if (ret == -EINPROGRESS)
-- 
2.42.0.515.g380fc7ccd1-goog

