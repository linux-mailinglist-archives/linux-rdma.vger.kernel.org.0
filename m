Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D62875D5FA
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jul 2023 22:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjGUUvN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jul 2023 16:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjGUUvM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Jul 2023 16:51:12 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1A030ED
        for <linux-rdma@vger.kernel.org>; Fri, 21 Jul 2023 13:51:11 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3a3fbfb616dso1540874b6e.3
        for <linux-rdma@vger.kernel.org>; Fri, 21 Jul 2023 13:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689972670; x=1690577470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7gNvQz3sS+3ucrtBSdSo4m5tG8c2ZAqY/c8seuYI3I=;
        b=d9OSBN5vetV6sxipO6w5WcSpVWaX9qzw/HadXZAqmWx5Xm18XyOUsmfULcAhUvvptZ
         L6Grw4jWUTfpQamQOWHbxHcTrauDDgebINt3ZIyHazElcpfqjMtN5L63uLQW7ETMHmsx
         G6mjBpYJlPhUYUF2v+0GQMgwgNtxKGHa07Vkumfua+NYiMu1zWDa1RZDOUjBKW5rqeEp
         MexisZTGnvYaaa1wMSH1YBUbP+ApAHLKL3wW2/zRZtkYfaIoB4s5vs3ZyjzOjPJ8ZOLb
         6UpkQFUpS8uMeI49ue51MR+GF7meR8KqZzvJFX0ULv/ODi2k7qU0wKazQgqohnJ0msIN
         EMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689972670; x=1690577470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7gNvQz3sS+3ucrtBSdSo4m5tG8c2ZAqY/c8seuYI3I=;
        b=eti+Ks0F8o3q+BSQmnb0l3mSypJPo7PhquBhcw4HWweQvDDOCDGLGvgnd8/SB8V1JG
         UzxA7Jq7gMvpvs6d2yTUWLMSrDXC37nOUeKy0GqRInVlGuYb1tEbGyZMP8/XhvUOHaqR
         PpJkAYX3rLuQSJdXVFqUrZsbe+Rokd/lf+C/AfjBdQZRdtSFaVUimyjY1WkIrC5+22wM
         M5TsvLl4sRhGQixb4zW/FqwEWzfY16To1vTYxV34eJrRywqE8G0EKtq/MLyRhS9RKHZR
         vG0LFKJlsDFxganBssJ8XdmXaZF3FQ9xH+a2+UbNPzYieH97toMJP+XyGAHpatE2guO3
         7Myw==
X-Gm-Message-State: ABy/qLZHJzkpMWoCzBTSuDj+XNvm500x6YyogK5+tx+xfqPFojDKKhPN
        xirkdyjhllNjRrYXltPNpJ0=
X-Google-Smtp-Source: APBJJlHQ3XzkvISKXVO66yMSwkVOfCvsG7B+1Z1aoI6MFvNlERRRNU7gsOgDa+eLThFHGQ0mjibfSg==
X-Received: by 2002:a05:6808:18a:b0:3a4:1c0b:85d0 with SMTP id w10-20020a056808018a00b003a41c0b85d0mr3085656oic.55.1689972670372;
        Fri, 21 Jul 2023 13:51:10 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-3742-d596-b265-a511.res6.spectrum.com. [2603:8081:140c:1a00:3742:d596:b265:a511])
        by smtp.gmail.com with ESMTPSA id o188-20020acaf0c5000000b003a375c11aa5sm1909551oih.30.2023.07.21.13.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 13:51:09 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 5/9] RDMA/rxe: Optimize rxe_init_packet in rxe_net.c
Date:   Fri, 21 Jul 2023 15:50:18 -0500
Message-Id: <20230721205021.5394-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230721205021.5394-1-rpearsonhpe@gmail.com>
References: <20230721205021.5394-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch replaces code that looks up the ndev from the ib_device
and port number of a rxe device with the saved value of the ndev
used when the rxe device was created. Since the rxe driver does
not support multi port operation or path migration, the ndev is
constant for the life of the rxe device. The ndev lookup code in
rxe_init_packet has a significant performance impact under heavy
load and can consume a noticeable fraction of the overall cpu time.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_net.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 10e4a752ff7c..c1b2eaf82334 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -508,14 +508,9 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 {
 	unsigned int hdr_len;
 	struct sk_buff *skb = NULL;
-	struct net_device *ndev;
-	const struct ib_gid_attr *attr;
+	struct net_device *ndev = rxe->ndev;
 	const int port_num = 1;
 
-	attr = rdma_get_gid_attr(&rxe->ib_dev, port_num, av->grh.sgid_index);
-	if (IS_ERR(attr))
-		return NULL;
-
 	if (av->network_type == RXE_NETWORK_TYPE_IPV4)
 		hdr_len = ETH_HLEN + sizeof(struct udphdr) +
 			sizeof(struct iphdr);
@@ -523,25 +518,14 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 		hdr_len = ETH_HLEN + sizeof(struct udphdr) +
 			sizeof(struct ipv6hdr);
 
-	rcu_read_lock();
-	ndev = rdma_read_gid_attr_ndev_rcu(attr);
-	if (IS_ERR(ndev)) {
-		rcu_read_unlock();
-		goto out;
-	}
-	skb = alloc_skb(paylen + hdr_len + LL_RESERVED_SPACE(ndev),
-			GFP_ATOMIC);
-
-	if (unlikely(!skb)) {
-		rcu_read_unlock();
+	skb = alloc_skb(paylen + hdr_len + LL_RESERVED_SPACE(ndev), GFP_ATOMIC);
+	if (unlikely(!skb))
 		goto out;
-	}
 
 	skb_reserve(skb, hdr_len + LL_RESERVED_SPACE(ndev));
 
 	/* FIXME: hold reference to this netdev until life of this skb. */
-	skb->dev	= ndev;
-	rcu_read_unlock();
+	skb->dev = ndev;
 
 	if (av->network_type == RXE_NETWORK_TYPE_IPV4)
 		skb->protocol = htons(ETH_P_IP);
@@ -554,7 +538,6 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 	pkt->mask	|= RXE_GRH_MASK;
 
 out:
-	rdma_put_gid_attr(attr);
 	return skb;
 }
 
-- 
2.39.2

