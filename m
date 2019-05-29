Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31D572DEF7
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2019 15:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfE2N4E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 May 2019 09:56:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42562 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfE2N4E (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 May 2019 09:56:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id l2so1852537wrb.9
        for <linux-rdma@vger.kernel.org>; Wed, 29 May 2019 06:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iqnihbvFakWoZgWt4FsG78UCGX2QlZKqMQBEFmmroko=;
        b=n0uIye5I9bMJVOPm0fdWFPPD05lI1lGUE26c4D9xvthjqvsN3Uns5cTRb5KCVNBkW0
         ylNIFSYxQ6twDKrmpxGoJzf2WphB/OxU/DOwcEG/Gs/HgkDzEONwNo75RXJBYEvSxjsR
         UcSRiJBbJf1ITIKU3H0+JREYL4+UbiMCs6nAMgQ6uG0CFCHIVRkxaxji+TGh3yiYEp/5
         7MR7nW1zFSwHXSMzEVAU58mZLeQN13lf3Z3wnS4GEuCM+NKLRnB1ZUsdSzfq7pEsUGDk
         EU//TchZgQD828wFU2jiZztxjzEoxQe+eJZNFqf7apmWFHN5fra/AEvbeZ2wuJ1zZ6U0
         1h3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iqnihbvFakWoZgWt4FsG78UCGX2QlZKqMQBEFmmroko=;
        b=qfhPhDL2SBlgssM26HCzAljVPXPWEx9Jw1Q9/BCd3pDv8+t0/WQqy9W+qqzNRXoWYN
         swpeTqDCuRv5VDB3iy3tcINX2rFUTFJPKObR7yVQFtjFlSxD1GTTpsH5eXXNM3lNGWv4
         AxYn0T6QYA4ZjIUwNc37yaKXRi1r+FAVHwlcds0sBWM8x9pR6/dsTjjFfeOC8wD01qkc
         jupcpkqZNvWl3lQx3XV8cUXu0O5kVN9GZBQrFiTrMQiDOTF1+3PipURY16NWurvact6U
         WXGawS6wbDRNTjoYps6x5Yx3zGoZLQ9Je+i1ZOEWArY1p0QnLPPyhDl1c4QMRKurMfzf
         3GLA==
X-Gm-Message-State: APjAAAX5Dk/ZB8h3q/Wb8Hxq+oluo4iBLCexUaQNyGbZLVu8lSZRYIOh
        tVyXwboL4qBVUw/mnNX9Q9ksVRBH2w4=
X-Google-Smtp-Source: APXvYqyqsZy1Hv00/rVWfJr89/ETcFm4e91vaSCQKsPAxVza0TBHA67og6VVy98h+xT4jaisyyCYiw==
X-Received: by 2002:a5d:6248:: with SMTP id m8mr4008505wrv.141.1559138162411;
        Wed, 29 May 2019 06:56:02 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-181-8-139.red.bezeqint.net. [79.181.8.139])
        by smtp.gmail.com with ESMTPSA id s62sm9740401wmf.24.2019.05.29.06.56.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 06:56:01 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH] RDMA/ipoib: implement ethtool .get_link() callback
Date:   Wed, 29 May 2019 16:55:45 +0300
Message-Id: <20190529135545.25371-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add support for reporting link state for ipoib net devices.

$ ip l set dev mlx4_ib0 up
$ ethtool mlx4_ib0 | grep Link
	Link detected: yes
$ ip l set dev mlx4_ib0 down
$ ethtool mlx4_ib0 | grep Link
	Link detected: no

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c b/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
index 83429925dfc6..58016532bf86 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
@@ -222,6 +222,7 @@ static const struct ethtool_ops ipoib_ethtool_ops = {
 	.get_strings		= ipoib_get_strings,
 	.get_ethtool_stats	= ipoib_get_ethtool_stats,
 	.get_sset_count		= ipoib_get_sset_count,
+	.get_link		= ethtool_op_get_link,
 };
 
 void ipoib_set_ethtool_ops(struct net_device *dev)
-- 
2.20.1

