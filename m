Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23A94753E7
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Dec 2021 08:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbhLOHxK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Dec 2021 02:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbhLOHxK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Dec 2021 02:53:10 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0BCC061574;
        Tue, 14 Dec 2021 23:53:09 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id d2so19209901qki.12;
        Tue, 14 Dec 2021 23:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e4GoGhGMbxrdA++ZWH+ek8XaYXmmb722DkOkuUVJm+g=;
        b=YzI62Cg+qqzhSz3+o2jiwg9bzdOYgFPKnF2Up/A2SqcmVY7DWtk9o/fh0l5ViDWEQD
         Q4Yo92eS66cm1x/K982FFBT06nSoeDFVdrc8gVan6VuafM93nDnNLyHjgpuyHcgLuOCk
         Np25/PW3VCRcMviR97tkvIpgWAOSntlvtNRoZaABKNJ+vgpXWRJTp3y7Wv+d5rh9uaw2
         DUiRBF6SKcYtq2w5eOXZ8m60WcTeZBl6zOdq2pqyVJSHPDO+76XAd//oODK07a++Pr/S
         IokSCXLnvSF6PuVNnufPu0VjO8Dt1VkTb/rdW5k4o8tj1J0FCQ1KSQDuxm4G9LSdN1me
         tujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e4GoGhGMbxrdA++ZWH+ek8XaYXmmb722DkOkuUVJm+g=;
        b=JRTZ5/pvRoyHB6tbW0nK9PIgRnXFTfKP4pBQj34HVkcK2ddmbPOA55yDCPpVgYNOJM
         i3WoaIrX9RnrhOf4hdCb0uphFklr36YX+mNXxKU1ssS945EV/ptWZDcCR8lFv+K0BDBf
         bvT76gnR8KaYmWy4mut/f6dRIqTZnJmHxRov33aPF8LznvlNnZ89+VSYWVhft6lxGKHV
         2WOhLnIb+ounxCt6gpIO3vzwQJ6hQ2qUvvg5R24sd7lmbGDyaXJmM6gsfICFsONvFDXa
         rivG4hSYuQnYR/gX+EIWBYRAtZ6TmxPkOBHV95W0NdrighE50G9burVWKoYB9IugT1z2
         sIOQ==
X-Gm-Message-State: AOAM5301shJQTW/tAxQ+BPHsAktK+79BfRYs9qMOz6Rp17yFTK9gpJgX
        KMw1nhdaGEfTAz8FapDT7dBhqTn10u4=
X-Google-Smtp-Source: ABdhPJwJ8PwXedRowaLQRsE848JaULPvyTsNAaDLeKFGUZK0PzrLYDlRmjK/llz0cRrBfsNBFky4+g==
X-Received: by 2002:ae9:eb45:: with SMTP id b66mr7402397qkg.695.1639554788607;
        Tue, 14 Dec 2021 23:53:08 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id t35sm1011675qtc.83.2021.12.14.23.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 23:53:08 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     devesh.s.sharma@oracle.com
Cc:     cgel.zte@gmail.com, chi.minghao@zte.com.cn, dledford@redhat.com,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, zealci@zte.com.cn, zyjzyj2000@gmail.com
Subject: [PATCH for-next v2] RDMA/rxe: remove redundant err variable
Date:   Wed, 15 Dec 2021 07:52:58 +0000
Message-Id: <20211215075258.442930-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CO6PR10MB56353FD77836D5605CDDB8DEDD769@CO6PR10MB5635.namprd10.prod.outlook.com>
References: <CO6PR10MB56353FD77836D5605CDDB8DEDD769@CO6PR10MB5635.namprd10.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value directly instead of taking this
in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/infiniband/sw/rxe/rxe_net.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c
b/drivers/infiniband/sw/rxe/rxe_net.c
index 2cb810cb890a..f557150bd59a 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -22,24 +22,20 @@ static struct rxe_recv_sockets recv_sockets;
 
 int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid)
 {
-	int err;
 	unsigned char ll_addr[ETH_ALEN];
 
 	ipv6_eth_mc_map((struct in6_addr *)mgid->raw, ll_addr);
-	err = dev_mc_add(rxe->ndev, ll_addr);
 
-	return err;
+	return dev_mc_add(rxe->ndev, ll_addr);
 }
 
 int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid)
 {
-	int err;
 	unsigned char ll_addr[ETH_ALEN];
 
 	ipv6_eth_mc_map((struct in6_addr *)mgid->raw, ll_addr);
-	err = dev_mc_del(rxe->ndev, ll_addr);
 
-	return err;
+	return dev_mc_del(rxe->ndev, ll_addr);
 }
 
 static struct dst_entry *rxe_find_route4(struct net_device *ndev,
-- 
2.25.1

