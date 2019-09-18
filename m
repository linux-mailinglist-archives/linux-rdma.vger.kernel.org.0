Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 078F7B5ABE
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Sep 2019 07:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfIRFSK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Sep 2019 01:18:10 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43034 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfIRFSK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Sep 2019 01:18:10 -0400
Received: by mail-io1-f67.google.com with SMTP id v2so13136107iob.10;
        Tue, 17 Sep 2019 22:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hsEZeGzMmik1nF5cEz0wbkGKUHu+pMKAnWIyuh68h1o=;
        b=CuhATGSNTggc1boGxczlcFdvvJB8SlQmvbqHc3SXKLYzHnH7O5b0FTvQ2dVhAvZtyU
         jNDjI6FPxo1HohLRTErUqeNhipcaXCk3/mMpXRL3XBrcmFxknZbWnpEPfvG7ow0Aon+v
         kE4Clwy4lAEmkzqPqPWzWEYJt7cpw+sUTU6f4pHMXpjpEPMspCwO8xmR3GdilOIPkv0r
         mSIs+uPPIMIvijVWONDT6NAo8CzD1WTzokt5zpZckXLZFn7xq3gSBsW/rKQN7VrcpnWr
         xbvsZwGLvn2Og1oDUdzJqGiggDG+QcCH0hqegKLI+TZMB0cD3ZefLRrAIF8Mpzj0ENYh
         d//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hsEZeGzMmik1nF5cEz0wbkGKUHu+pMKAnWIyuh68h1o=;
        b=hhhWDhLLxCaEIwPIOGVsT3nzmonHe99o23vdVuW72CFXs2Kh75eztyKmgYBal4e5f5
         T/8WchvMvA9gDfM5MAUZKJo6aDCFY06uDXEhWSx2C2+OUAjn1MSB6ZGhJX+psFRTZeIC
         z6IYVu7iNBKzrA1pyWSPikL0pTBLwbL+EL4emR0kiB0g0bgGwHLmp18XH9MN/XINbb2i
         ZX2wwwLavle709cCiJWK1A5iv8fUgrt6gakDzZ0nbkFTHPKGVh/BzUOCZ+WY80jtH4Ep
         +HXcCQOqRjlb0NVjLYpK63iZVJmr7mW0ptKFAacjdGX9MiWaT/UWW/xrwII239sIDdh4
         XrNA==
X-Gm-Message-State: APjAAAXSCOrVHmH2dms6bBhNT8aUuJ29KNXFWUWeV0MdGGObKyYD2e5k
        oFlJUuqn+8zBm8cnv9vk78fQi7BR9Do=
X-Google-Smtp-Source: APXvYqwDYJfv+C6cXnFMDzSVIBdz6YfXIw/z6Or2FY41AC3LLl2ZQkAUoygqnEJ+6j43xYEvqxifcQ==
X-Received: by 2002:a6b:7d02:: with SMTP id c2mr2423948ioq.262.1568783889740;
        Tue, 17 Sep 2019 22:18:09 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id p26sm109882iob.50.2019.09.17.22.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 22:18:08 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA: release allocated skb
Date:   Wed, 18 Sep 2019 00:17:55 -0500
Message-Id: <20190918051756.10238-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In create_cq, the allocated skb buffer needs to be released on error
path.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/infiniband/hw/cxgb4/cq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/cxgb4/cq.c b/drivers/infiniband/hw/cxgb4/cq.c
index b1bb61c65f4f..841a395d9896 100644
--- a/drivers/infiniband/hw/cxgb4/cq.c
+++ b/drivers/infiniband/hw/cxgb4/cq.c
@@ -166,6 +166,7 @@ static int create_cq(struct c4iw_rdev *rdev, struct t4_cq *cq,
 	if (user && !cq->bar2_pa) {
 		pr_warn("%s: cqid %u not in BAR2 range\n",
 			pci_name(rdev->lldi.pdev), cq->cqid);
+		kfree_skb(skb);
 		ret = -EINVAL;
 		goto err4;
 	}
-- 
2.17.1

