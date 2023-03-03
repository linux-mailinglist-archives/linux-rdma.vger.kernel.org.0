Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C3B6AA47C
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Mar 2023 23:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjCCWeU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Mar 2023 17:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbjCCWeE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Mar 2023 17:34:04 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF3260D5A
        for <linux-rdma@vger.kernel.org>; Fri,  3 Mar 2023 14:30:11 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id p13so2720221ilp.11
        for <linux-rdma@vger.kernel.org>; Fri, 03 Mar 2023 14:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677882537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9Rky0zcPaMb6clSIcXM2O6QspDzfVXkzCsnmwcSWfY=;
        b=JfWu2WbQki6ywCdVwkKJw0h9E+c+2IXiprJQ1VPw2K0KaEBPZc/afyJtjO5eTLeiIv
         StLsbBdufT3leI+EbOiAWdH2vkqbWV8olXBdZGik+vcRd8s51LJ9orTQGeaaK18DJDUj
         xl9yq1rFKcmSBK5R02yzMp1lEq3k+1yvh6xX6YtZKJ50GDJRYMc81JpCWSi2iSUgFuNT
         mGo/WjNfv5Rb8DXifPQPGulUQSQvKCbaUUi6aa02wa1R34YNMykjPi7J12EuVDrw/cEM
         8oYIQioSXYqCde2xpbPbXdSI2oHNLyPke9d7DfS1yXtYS2tQ43LmhKMCzx/PBoNPIA4H
         hmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677882537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9Rky0zcPaMb6clSIcXM2O6QspDzfVXkzCsnmwcSWfY=;
        b=j8I4qBX/P4s8cQfl41kkjaGuhSFjMnH0M/pSt/Y40pXXgjaU7iPu5pmuZn/L//YbNK
         cacqQJMyvhUnLJ9dP/dKfkXHydGStCf8AFqyxhtceydCErNQhxWykY6Isq/Zhs7iEirK
         ejyG2biPIm2TpPWc5Pbuib7ZkRh/DrMVtms252L8cC7E9dOd+t6L28UHjgGq1AVf26E6
         fKR+TbTtH7pxCD6csAHF1oWA8I+Xa8C3yp9Qo+KMrw8iyTVvlBLuklI7UxH7jSTtZJwQ
         B87KF5WAXpW9oKWtmHhn2c8qbuSzci83wPwqnC9wOPm00zKPKDzXS/aX5kkIBCtb62lx
         JJFg==
X-Gm-Message-State: AO0yUKW5m9U2XCcUSCgIgOEB3kUYlenWrsdICKuOKZE63H+bqmCdhnU9
        jeTTqhtjmekF96XIZJxx1rgNXXW7klk=
X-Google-Smtp-Source: AK7set/OmQ2p0/RvJWXEDBAemZSevoX7lvl9G3KFmeio1bdmOPyxJQdNVuflbfPSJH8AjVwHiorX4A==
X-Received: by 2002:a05:6870:e387:b0:172:55bf:67dc with SMTP id x7-20020a056870e38700b0017255bf67dcmr1926272oad.59.1677881807165;
        Fri, 03 Mar 2023 14:16:47 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-de65-7c8e-0940-8c68.res6.spectrum.com. [2603:8081:140c:1a00:de65:7c8e:940:8c68])
        by smtp.gmail.com with ESMTPSA id zd34-20020a05687127a200b001730afaeb63sm1480740oab.19.2023.03.03.14.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 14:16:46 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, jhack@hpe.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v4 3/4] RDMA/rxe: Extend dbg log messages to err and info
Date:   Fri,  3 Mar 2023 16:16:23 -0600
Message-Id: <20230303221623.8053-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230303221623.8053-1-rpearsonhpe@gmail.com>
References: <20230303221623.8053-1-rpearsonhpe@gmail.com>
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

