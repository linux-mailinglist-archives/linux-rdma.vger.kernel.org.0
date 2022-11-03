Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E376185D8
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Nov 2022 18:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbiKCRLk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Nov 2022 13:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbiKCRKq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Nov 2022 13:10:46 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408152603
        for <linux-rdma@vger.kernel.org>; Thu,  3 Nov 2022 10:10:34 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-13b23e29e36so2875049fac.8
        for <linux-rdma@vger.kernel.org>; Thu, 03 Nov 2022 10:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBxL8rRf1Oe69RztCHnf7jWSF5OcOMzzJW15fjKRDqA=;
        b=PKa+TP/vGacx1P8YU4ymklCJ8sfR9e+GNL6dyBIoZS4BmzXwtkRCuh6qapsShrBbc2
         p5gI8qBnOl7X/w8GvxZWAQ5qPjOCb6iw7BvYcURm8AazARNsh/2avfpvBgTOL3sNANbf
         uRg6poQjrRNEmb0mS8Q1cSf+3loxjbQCXA6d0Wo0QsZC1WN5YQy7LH4dz//obqGAxGhF
         QAPc3PhgoQdSSt4tMA13yPcZmJg3OhT7U0kpmch81FO4eRNMX63jDkRDwow2FOHUPFrU
         3sYXqYqlL3dFiPI49Df62dqBFQEJbo2QGqLC54CN7M33W0gRJR7VBQrcH0jjiNhoUwm+
         Do+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBxL8rRf1Oe69RztCHnf7jWSF5OcOMzzJW15fjKRDqA=;
        b=8ET3QWWEk6fLXmZyfw3LEv05ooRdvzZAz1eTZRjxvFhADY2xEkro+SOSa8lLw4Rw8t
         4u9vEtSN/yBvOz8g1lHAQtSQlJlJQg7OmRtAO6NxG+L3KTTP2WTR3M66Fnmbs5UO7vgY
         OHnzEbQU4IAarqld5O8pQsWqcAykMXZmucj3GxcPWzfvCwRVKa+GkpWI8vPBmyJpIZf7
         6hQPoXZu85pVfTPge/0nXvRP3zKTig2XEFMZyhna0f/Joltg4r72FHzwBcWvOLgN8iNf
         3ydPWKedHjFF9yX5n+FSeVdLFlZuguNcgRHinhnQ1J/ejWB7N6htXl/u7L9bgxrjo3qq
         3K/w==
X-Gm-Message-State: ACrzQf1+JCjVXblpR9DjL17BEOiypTM940mFQNrUntUhq6XjSZN6TIBB
        qtEJhl4O8pC3c3bPGZyNydk=
X-Google-Smtp-Source: AMsMyM7hok80c6pb/1sBbJeVk7IRObeRrCQGxC02jdS3X7UYuh0l4M7VufYhPNPM0HWFkp26jsHJ7A==
X-Received: by 2002:a05:6870:9722:b0:13b:8822:bf8f with SMTP id n34-20020a056870972200b0013b8822bf8fmr17735398oaq.195.1667495433447;
        Thu, 03 Nov 2022 10:10:33 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-b254-769c-82c0-77a4.res6.spectrum.com. [2603:8081:140c:1a00:b254:769c:82c0:77a4])
        by smtp.googlemail.com with ESMTPSA id m1-20020a056870a10100b0012b298699dbsm624304oae.1.2022.11.03.10.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:10:32 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     leon@kernel.org, jgg@nvidia.com, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 01/16] RDMA/rxe: Add ibdev_dbg macros for rxe
Date:   Thu,  3 Nov 2022 12:09:59 -0500
Message-Id: <20221103171013.20659-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103171013.20659-1-rpearsonhpe@gmail.com>
References: <20221103171013.20659-1-rpearsonhpe@gmail.com>
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

Add macros borrowed from siw to call dynamic debug macro ibdev_dbg.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v2:
  Replaced uc->ibpd by uc->ibuc in rxe_dbg_uc().
  Replaced obj by (obj) in the macros.
Reported-by: Jason Gunthorp <jgg@nvidia.com>

 drivers/infiniband/sw/rxe/rxe.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
index 30fbdf3bc76a..ab334900fcc3 100644
--- a/drivers/infiniband/sw/rxe/rxe.h
+++ b/drivers/infiniband/sw/rxe/rxe.h
@@ -38,6 +38,25 @@
 
 #define RXE_ROCE_V2_SPORT		(0xc000)
 
+#define rxe_dbg(rxe, fmt, ...) ibdev_dbg(&(rxe)->ib_dev,		\
+		"%s: " fmt, __func__, ##__VA_ARGS__)
+#define rxe_dbg_uc(uc, fmt, ...) ibdev_dbg((uc)->ibuc.device,		\
+		"uc#%d %s: " fmt, (uc)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_dbg_pd(pd, fmt, ...) ibdev_dbg((pd)->ibpd.device,		\
+		"pd#%d %s: " fmt, (pd)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_dbg_ah(ah, fmt, ...) ibdev_dbg((ah)->ibah.device,		\
+		"ah#%d %s: " fmt, (ah)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_dbg_srq(srq, fmt, ...) ibdev_dbg((srq)->ibsrq.device,	\
+		"srq#%d %s: " fmt, (srq)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_dbg_qp(qp, fmt, ...) ibdev_dbg((qp)->ibqp.device,		\
+		"qp#%d %s: " fmt, (qp)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_dbg_cq(cq, fmt, ...) ibdev_dbg((cq)->ibcq.device,		\
+		"cq#%d %s: " fmt, (cq)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_dbg_mr(mr, fmt, ...) ibdev_dbg((mr)->ibmr.device,		\
+		"mr#%d %s:  " fmt, (mr)->elem.index, __func__, ##__VA_ARGS__)
+#define rxe_dbg_mw(mw, fmt, ...) ibdev_dbg((mw)->ibmw.device,		\
+		"mw#%d %s:  " fmt, (mw)->elem.index, __func__, ##__VA_ARGS__)
+
 void rxe_set_mtu(struct rxe_dev *rxe, unsigned int dev_mtu);
 
 int rxe_add(struct rxe_dev *rxe, unsigned int mtu, const char *ibdev_name);
-- 
2.34.1

