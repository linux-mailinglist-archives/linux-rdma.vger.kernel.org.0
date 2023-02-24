Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B556A155E
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Feb 2023 04:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjBXD3l (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Feb 2023 22:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjBXD3l (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Feb 2023 22:29:41 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B115193C
        for <linux-rdma@vger.kernel.org>; Thu, 23 Feb 2023 19:29:39 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id c2-20020a9d6842000000b0068bc93e7e34so3157329oto.4
        for <linux-rdma@vger.kernel.org>; Thu, 23 Feb 2023 19:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9Rky0zcPaMb6clSIcXM2O6QspDzfVXkzCsnmwcSWfY=;
        b=UvWtFFrr1NUdQcyM8a1kQKOwKTelOzGZYIY50s56OsyquCEiwTTefAzbkcA5artwEh
         jEXegCwqIFjkxBb/nXiJMQAuprq9qK+OKv23fJzb9hswl2PIvi2qP4ak6Xyv7nBC+HEt
         rJbl20l/orvBCXsZRkCltiZWLL3k3P9XoLZYojEnOW71xOjwjNpfRCo5FuO1PzVT9qVm
         1aBbOi0j7rUbfRJxqERgbEWeneYRuDHym96T+Gx493YhCJJoNZh6iYZ98rIav/5f54jU
         Kas6pu3rQjOqOX1H4WIE8eYAK2ZzF6QOANjxaCdSo1XaG/M870Y37I1C74LSUo9m7Jsd
         2xkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9Rky0zcPaMb6clSIcXM2O6QspDzfVXkzCsnmwcSWfY=;
        b=rGIlkFqSKg1uiMdKpeXPKxVM+DUn1PrNCpOpWPYHxfKnuoeOR5MknLQWjLY6h0IjEm
         U9Jh+PHGMkYFSaJL830tcgbSaqjtF2j1EZtpfReZRTl+kaZ+yb6UcXNP1PyykV0Sr2r8
         lTr9fDqfM4pD/klvyjhyR3OG4GYLKyJaryL2CaNJAbNhFkNe9R+o7kytewYq2hxm49ft
         FsLIBnz6lItvqwDFFYJ9mcgHy3+bqNBgGDAGJ7O17NphEVQZ3ABQdbQT458b/HVvAvrm
         iPBmvRGspf3Q0sipFVs1Bl02NmfWJvBNz2bG5Ym00p0av0/aqVkw/UVAP+9/yVwLfTSj
         66Xw==
X-Gm-Message-State: AO0yUKW6jxKBW3HKG4E/b84jRmdakTpylD0MTEdjsxFd7p/mBZ3pQ/l4
        dm2yEwuhI0NXwQOuNS3gbbI=
X-Google-Smtp-Source: AK7set8LyK7MrbV4D5BVqg3ZkO9S+wkeJP6Zqd7hY24i67yiibQUOQfe2iaVVIoQQcJAhDMxd4B0YA==
X-Received: by 2002:a05:6830:438d:b0:68b:ae34:838d with SMTP id s13-20020a056830438d00b0068bae34838dmr9041852otv.3.1677209379062;
        Thu, 23 Feb 2023 19:29:39 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-07e1-19cc-c957-ef10.res6.spectrum.com. [2603:8081:140c:1a00:7e1:19cc:c957:ef10])
        by smtp.gmail.com with ESMTPSA id l15-20020a9d550f000000b0068d3f341dd9sm2587561oth.62.2023.02.23.19.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 19:29:38 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 3/4] RDMA/rxe: Extend dbg log messages to err and info
Date:   Thu, 23 Feb 2023 21:29:17 -0600
Message-Id: <20230224032916.151490-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230224032916.151490-1-rpearsonhpe@gmail.com>
References: <20230224032916.151490-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Extend the dbg log messages (e.g. rxe_dbg_xxx) to include
err and info types. rxe.c is modified to use these new log
messages as examples.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c |  8 ++++---
 drivers/infiniband/sw/rxe/rxe.h | 42 +++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index d57ba7a5964b..7a7e713de52d 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -160,6 +160,8 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
 
 	port->attr.active_mtu = mtu;
 	port->mtu_cap = ib_mtu_enum_to_int(mtu);
+
+	rxe_info_dev(rxe, "Set mtu to %d", port->mtu_cap);
 }
 
 /* called by ifc layer to create new rxe device.
@@ -179,7 +181,7 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
 	int err = 0;
 
 	if (is_vlan_dev(ndev)) {
-		pr_err("rxe creation allowed on top of a real device only\n");
+		rxe_err("rxe creation allowed on top of a real device only");
 		err = -EPERM;
 		goto err;
 	}
@@ -187,14 +189,14 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
 	rxe = rxe_get_dev_from_net(ndev);
 	if (rxe) {
 		ib_device_put(&rxe->ib_dev);
-		rxe_dbg_dev(rxe, "already configured on %s\n", ndev->name);
+		rxe_err_dev(rxe, "already configured on %s", ndev->name);
 		err = -EEXIST;
 		goto err;
 	}
 
 	err = rxe_net_add(ibdev_name, ndev);
 	if (err) {
-		pr_debug("failed to add %s\n", ndev->name);
+		rxe_err("failed to add %s\n", ndev->name);
 		goto err;
 	}
 err:
diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
index 0757acc38103..bd8a8ea4ea8f 100644
--- a/drivers/infiniband/sw/rxe/rxe.h
+++ b/drivers/infiniband/sw/rxe/rxe.h
@@ -58,6 +58,48 @@
 #define rxe_dbg_mw(mw, fmt, ...) ibdev_dbg((mw)->ibmw.device,		\
 		"mw#%d %s:  " fmt, (mw)->elem.index, __func__, ##__VA_ARGS__)
 
+#define rxe_err(fmt, ...) pr_err_ratelimited("%s: " fmt "\n", __func__, \
+					##__VA_ARGS__)
+#define rxe_err_dev(rxe, fmt, ...) ibdev_err_ratelimited(&(rxe)->ib_dev, \
+		"%s: " fmt, __func__, ##__VA_ARGS__)
+#define rxe_err_uc(uc, fmt, ...) ibdev_err_ratelimited((uc)->ibuc.device, \
+		"uc#%d %s: " fmt, (uc)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_err_pd(pd, fmt, ...) ibdev_err_ratelimited((pd)->ibpd.device, \
+		"pd#%d %s: " fmt, (pd)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_err_ah(ah, fmt, ...) ibdev_err_ratelimited((ah)->ibah.device, \
+		"ah#%d %s: " fmt, (ah)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_err_srq(srq, fmt, ...) ibdev_err_ratelimited((srq)->ibsrq.device, \
+		"srq#%d %s: " fmt, (srq)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_err_qp(qp, fmt, ...) ibdev_err_ratelimited((qp)->ibqp.device, \
+		"qp#%d %s: " fmt, (qp)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_err_cq(cq, fmt, ...) ibdev_err_ratelimited((cq)->ibcq.device, \
+		"cq#%d %s: " fmt, (cq)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_err_mr(mr, fmt, ...) ibdev_err_ratelimited((mr)->ibmr.device, \
+		"mr#%d %s:  " fmt, (mr)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_err_mw(mw, fmt, ...) ibdev_err_ratelimited((mw)->ibmw.device, \
+		"mw#%d %s:  " fmt, (mw)->elem.index, __func__, ##__VA_ARGS__)
+
+#define rxe_info(fmt, ...) pr_info_ratelimited("%s: " fmt "\n", __func__, \
+					##__VA_ARGS__)
+#define rxe_info_dev(rxe, fmt, ...) ibdev_info_ratelimited(&(rxe)->ib_dev, \
+		"%s: " fmt, __func__, ##__VA_ARGS__)
+#define rxe_info_uc(uc, fmt, ...) ibdev_info_ratelimited((uc)->ibuc.device, \
+		"uc#%d %s: " fmt, (uc)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_info_pd(pd, fmt, ...) ibdev_info_ratelimited((pd)->ibpd.device, \
+		"pd#%d %s: " fmt, (pd)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_info_ah(ah, fmt, ...) ibdev_info_ratelimited((ah)->ibah.device, \
+		"ah#%d %s: " fmt, (ah)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_info_srq(srq, fmt, ...) ibdev_info_ratelimited((srq)->ibsrq.device, \
+		"srq#%d %s: " fmt, (srq)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_info_qp(qp, fmt, ...) ibdev_info_ratelimited((qp)->ibqp.device, \
+		"qp#%d %s: " fmt, (qp)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_info_cq(cq, fmt, ...) ibdev_info_ratelimited((cq)->ibcq.device, \
+		"cq#%d %s: " fmt, (cq)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_info_mr(mr, fmt, ...) ibdev_info_ratelimited((mr)->ibmr.device, \
+		"mr#%d %s:  " fmt, (mr)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_info_mw(mw, fmt, ...) ibdev_info_ratelimited((mw)->ibmw.device, \
+		"mw#%d %s:  " fmt, (mw)->elem.index, __func__, ##__VA_ARGS__)
+
 /* responder states */
 enum resp_states {
 	RESPST_NONE,
-- 
2.37.2

