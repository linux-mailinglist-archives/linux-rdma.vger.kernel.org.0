Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32B0679D4A
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jan 2023 16:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbjAXPVD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Jan 2023 10:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbjAXPVC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Jan 2023 10:21:02 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA1F9016;
        Tue, 24 Jan 2023 07:21:01 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so11202133wms.2;
        Tue, 24 Jan 2023 07:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tSLanuDzqCW+eUvvpWt1HPWdPcVU7kF2EEorDOUKdRo=;
        b=PBatQWyIpE/59It9hSvEdvGeE0J9Y75XC/jgtgMHGSwEk3ZbEjNTXgW36NdnpwyHrg
         QzswVvnySfKWWJe6dqDqh9MzFYYD9MXVGP3xscZs84KSuo4fgd9Hu2ICcjThl9JOZd8k
         CsMVpBxn6M0zWakJKv0DzcDxVI4va/YpBRPFKOuu1/8xjdK7HZs0edOluK935wOJoOag
         zCprjN0lRwfnxW2D1X1gJIyHfreGMaVyMwWUfwRIDAfh3w9+1twSOJK4rQlv9Vkor6JR
         eXXH9dXYR1Z5/X+aRsANtZhtpS2vzw9uBHf/OVvuR72c4zRCD3m2Xfz+U0jKlZfrl/kQ
         299w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tSLanuDzqCW+eUvvpWt1HPWdPcVU7kF2EEorDOUKdRo=;
        b=sjvuouo8gH8DkEYcZ4kq3bRdYpME8DcFb3xbVMb5XJiJLA784nR4qpPqebVoDZR0TM
         O8KAIZ/Ok1bb0NkgWiUtrMgrlNAm93uqqFQUfQ0htjXF5OLFvO3jAAZ9ThIV5m7OVVgo
         fMqBAhlbdrxiKXZbyynY5G7JQ+8AbiA3MXq4ip2wpQakMcjOrf7ZAqgK49EufjY4IXzv
         1l0IpvOJQ54i3l4PEgt5VnTxxM0xp5gCsm1I/tlTOUbcxP91ubQM9ubXGFLPAPAWypQY
         H7tTh/tZm8ZcfYZ+skvcdMSLR7oJ15chDmgBzII9/4XhdjVK62TgpD7r0lhEhHKQlnc/
         gvTg==
X-Gm-Message-State: AFqh2kpl0ya/3izuETZlcoMpo+XjtHLC4rGO8v1JFbUpe++sVvnrV/oY
        8WYJdl5xZfe+QMFfyDGd0LXO0Jtfh5KUUQ==
X-Google-Smtp-Source: AMrXdXu0DPcXGPtwApwpyWqrvPM4rjZOGby+zXj2sAtlWwLaCV2jWLWtRxjTibQMP8F1o7T1ODmznQ==
X-Received: by 2002:a05:600c:3d10:b0:3d9:ee3d:2f54 with SMTP id bh16-20020a05600c3d1000b003d9ee3d2f54mr36218520wmb.13.1674573661398;
        Tue, 24 Jan 2023 07:21:01 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c26d500b003d9b87296a9sm12927456wmv.25.2023.01.24.07.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 07:21:00 -0800 (PST)
Date:   Tue, 24 Jan 2023 18:20:54 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Long Li <longli@microsoft.com>
Cc:     Ajay Sharma <sharmaajay@microsoft.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Dexuan Cui <decui@microsoft.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] RDMA/mana_ib: Prevent array underflow in
 mana_ib_create_qp_raw()
Message-ID: <Y8/3Vn8qx00kE9Kk@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The "port" comes from the user and if it is zero then the:

	ndev = mc->ports[port - 1];

assignment does an out of bounds read.  I have changed the if
statement to fix this and to mirror how it is done in
mana_ib_create_qp_rss().

Fixes: 0266a177631d ("RDMA/mana_ib: Add a driver for Microsoft Azure Network Adapter")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/infiniband/hw/mana/qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
index ea15ec77e321..54b61930a7fd 100644
--- a/drivers/infiniband/hw/mana/qp.c
+++ b/drivers/infiniband/hw/mana/qp.c
@@ -289,7 +289,7 @@ static int mana_ib_create_qp_raw(struct ib_qp *ibqp, struct ib_pd *ibpd,
 
 	/* IB ports start with 1, MANA Ethernet ports start with 0 */
 	port = ucmd.port;
-	if (ucmd.port > mc->num_ports)
+	if (port < 1 || port > mc->num_ports)
 		return -EINVAL;
 
 	if (attr->cap.max_send_wr > MAX_SEND_BUFFERS_PER_QUEUE) {
-- 
2.35.1

