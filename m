Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B447F1E0A
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Nov 2023 21:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjKTUfK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Nov 2023 15:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjKTUfJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Nov 2023 15:35:09 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA84CD
        for <linux-rdma@vger.kernel.org>; Mon, 20 Nov 2023 12:35:05 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32dff08bbdbso3746194f8f.2
        for <linux-rdma@vger.kernel.org>; Mon, 20 Nov 2023 12:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1700512503; x=1701117303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mcp3dLQQTP38Z2yPH0qP/O6KAs0emFU7a4oJCNHLsls=;
        b=Y0H/nkIsD7m6rKes6ZseE6PP2aiKGyMMt9X9hcls52OQQbNsniqvp+L1GE2LGEwWpJ
         t0ahE0/U28HUPpn+nyg2GDB4tjVp4iRP+XcKDmelvm4bvbaAN+8ufB17q6gVXZAGFLll
         XlfJ9dviHCq9bmZrIiN0t1jK1hdzkpjRXvH0GiYxUIN4cWQPvvBWKLUTvZCHiW/YYj9D
         9eOZ46YunrmsCNCwXRhkR0mNhk7GLWAVTWkNbmOOTar4CvMq69a3c3H6JBxOjOCb/dzL
         lbgj4tr8m/1QlUe7+4EI0Pr5satB2wEoLJsnZ4qVD07Udd7Wvh5k5pXmAlSYAYweQVvc
         pBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700512503; x=1701117303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mcp3dLQQTP38Z2yPH0qP/O6KAs0emFU7a4oJCNHLsls=;
        b=vX1R1Mh7fAiWpbS+sCf2qgy1qOsDHOhxf/Ttz3pQ9ipE8gPJlHvIe94u3TY5CwloI8
         1jBChgcUXG9HCq81rv0/368xCaGUXzkXhVIk1YVSt4+974spauobogE30mgdUUbk+w97
         KdmNbZrqMhQl5dP51Wg9yjP8/khJJILq9arNbZ8xItNvTyCvq1NdidzIU+sOS1U0M5Er
         r8A6XBXrJZ6wzOlvO1yUPw10HBAYPBPSk8ZyWDPe7sHy5E7u6c+u4WVvIbf27fzCRu5e
         CUw6+ZT+AmPMZrZd/mMB/qjzFzilj98a9XNDUVv6owL1Z9DWcNzu8XnVXF97P4EMcHde
         UdvA==
X-Gm-Message-State: AOJu0YwgiwFeh8IAbQPajd1td9qjvPlW9RhQw/pyzFZMVpGhCr5vE2vW
        NCCMHjCVBzDXCiCFiE589LA0UekeqOXwUYJLYng=
X-Google-Smtp-Source: AGHT+IGVSJrLaZP0svvtRzNUfy+vUmG4BdwMKvfeCrt9h0f3nY37qUXpO9OVzCbnpJJ6NKOYGVDhsA==
X-Received: by 2002:a5d:42cc:0:b0:32d:8872:aac8 with SMTP id t12-20020a5d42cc000000b0032d8872aac8mr5686497wrr.31.1700512503289;
        Mon, 20 Nov 2023 12:35:03 -0800 (PST)
Received: from lb02065.fkb.profitbricks.net ([2001:9e8:140b:5d00:621d:e8e7:5d04:1c60])
        by smtp.gmail.com with ESMTPSA id x11-20020adfffcb000000b003316b8607cesm11258241wrs.1.2023.11.20.12.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 12:35:02 -0800 (PST)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     leon@kernel.org, jgg@ziepe.ca
Subject: [PATCH 1/2] ipoib: Fix error code return in ipoib_mcast_join
Date:   Mon, 20 Nov 2023 21:35:00 +0100
Message-Id: <20231120203501.321587-2-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120203501.321587-1-jinpu.wang@ionos.com>
References: <20231120203501.321587-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Return the error code in case of ib_sa_join_multicast fail.

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
index 5b3154503bf4..9e6967a40042 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -546,6 +546,7 @@ static int ipoib_mcast_join(struct net_device *dev, struct ipoib_mcast *mcast)
 		spin_unlock_irq(&priv->lock);
 		complete(&mcast->done);
 		spin_lock_irq(&priv->lock);
+		return ret;
 	}
 	return 0;
 }
-- 
2.34.1

