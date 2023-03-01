Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430206A6655
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Mar 2023 04:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjCADKy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Feb 2023 22:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjCADKw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Feb 2023 22:10:52 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2C62E807
        for <linux-rdma@vger.kernel.org>; Tue, 28 Feb 2023 19:10:51 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id o4-20020a9d6d04000000b00694127788f4so2936266otp.6
        for <linux-rdma@vger.kernel.org>; Tue, 28 Feb 2023 19:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9Rky0zcPaMb6clSIcXM2O6QspDzfVXkzCsnmwcSWfY=;
        b=M6gEvzkEof3HANvAtDxerf7fE/1A0+wtCZHA0Cy6fjwv7Wp7Kq3Z8n+zNWTLvP9VXG
         SFW73+epbCSfddoLYfz9gsa7JeuMpCKpWzN/EDwrab8X/3gaLtwI2G2dwX6fOQKa63dJ
         JU9RcCpM0GM/xT5elgkcLEWopwe7CgEcsyVe9mfkJEyZbGYkkQj3/LuAWzBhLElyF2aP
         nOJINt+ge/AfLDjRySUf+HezCkacW0xbwFkkmZlE87C1AoQ9dlZ8awJDi916ACYi292R
         YsTLHNLOI7eI6MFqFejHxR+AoLWBFwuEpy/e/lrTFN4VJNLj9LqVURVQq55H1Wt8Dxqu
         AywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9Rky0zcPaMb6clSIcXM2O6QspDzfVXkzCsnmwcSWfY=;
        b=kyCW8sFMn4mOLKvOqTbRPCiFw+0MxkoxpgSepguVDYRUetEcJiaUFiUg2rsBAK6lNJ
         rbFkN0mZHgEWMVzLLjhRegCXDSwcyC1ly5zAWgRRB3Jxpga4y4MEzi+dmO1kUUnofE7n
         zc1GwZAg2HYIFMpWdzPatZh9agklACVcOs3kPrzuMhlFRaOjRZNuiUPEq2Cia75U+hY2
         DlKNmRegGBJvUEk+zEMRnNhpFDTXUYVDbyslw+bzHx7tmxCabzLCLaDOuGYz0iRsYWG1
         BZZjyQ+vf/gPAbMwewWkZvMRWkehQZQfESiJAbbg6/rnyN3Lls4ap8aEL1QjkNOakyTm
         +9AQ==
X-Gm-Message-State: AO0yUKUQazB/WEXbHLJ6mdqMCjYl/gXtcblPbyeV+GdUbs0bJ4C2fsyz
        hMkeI42r5fU6GEke6EScF18=
X-Google-Smtp-Source: AK7set/Y5gOJC73Ff65uCceR9Ai7Ibabhy4R3piQNQyWAm30XFTdL+SLdl+c6m7dogm0CBaZA0xERA==
X-Received: by 2002:a9d:3e56:0:b0:690:92f1:d10 with SMTP id h22-20020a9d3e56000000b0069092f10d10mr2706204otg.12.1677640251628;
        Tue, 28 Feb 2023 19:10:51 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-759b-a469-60fc-ba97.res6.spectrum.com. [2603:8081:140c:1a00:759b:a469:60fc:ba97])
        by smtp.gmail.com with ESMTPSA id e7-20020a05683013c700b00684152e9ff2sm4484942otq.0.2023.02.28.19.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 19:10:51 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 3/4] RDMA/rxe: Extend dbg log messages to err and info
Date:   Tue, 28 Feb 2023 21:10:38 -0600
Message-Id: <20230301031038.10851-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230301031038.10851-1-rpearsonhpe@gmail.com>
References: <20230301031038.10851-1-rpearsonhpe@gmail.com>
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

