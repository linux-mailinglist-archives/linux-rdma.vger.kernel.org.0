Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC8271FCE
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 21:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391643AbfGWTBt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 15:01:49 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43244 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391637AbfGWTBt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 23 Jul 2019 15:01:49 -0400
Received: by mail-qt1-f194.google.com with SMTP id w17so42911119qto.10
        for <linux-rdma@vger.kernel.org>; Tue, 23 Jul 2019 12:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OvdZj+SFpT7mCy/KQvKHVvn4GvaIji9zUtBkBbbjCSs=;
        b=imBnxzPv54U7Up1jZ2at3rW06MtuoAI2w85upWBA19kP+7mXUnoPx6oU9Bo6/i6pvC
         kYzt3XrNrDoSR9i8003HD5vGa0cCPv0K9ACti8xPbLc488fDEcbN0bBm9wsxVq8JRg8J
         Svgf3Fw32qzS4h3Jq05bCIeW8x2RhOc2wFuYD3k0vqtsXSA34vlKHWOzrH9XC8jss4CU
         FR13CCQ13W455wfCV39IENKYp6tWrLvCfv4jOyMqgSwyLkAEwd7uDWkzzk3ZyKDXBeVr
         29IK7AV4B16USZtFHL+lm03sfZ0zez8rpr9rRorLIxbBmwG3z0k6z320ppg1JT3BuIE1
         H+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OvdZj+SFpT7mCy/KQvKHVvn4GvaIji9zUtBkBbbjCSs=;
        b=KjGfPgqmsmw+s44ZUHjhTq6KGj4AZE3xjpwZBu/XT2oib7ddFpi+/qfHPoYf4DVk2M
         TaLnRCuhYY36wXfswzSgyAsKKuyxuNsHv52RJdijfKVnHoJovz/bW0Q5as/I5bpi7+Da
         /yEaUM8xdJ70Sb2gNkBuHN3hz8O1lQ+4F23j81jx7mCGMEGO/J9tGuvb9bvdbQtFf9+d
         ITnm6LAeelGlZvJxWrWHZBMqu3yd0eVbLN0/2vYxtQs2m0aBUR6wYR0cy4JCS/M9CWiA
         fuRFCOwJu6PtPlHVOVbRURaCleNTrHXgT9pdcfye6jKbEfdTzmLMeYKbEX+rLqnlhYu0
         vVvg==
X-Gm-Message-State: APjAAAVHzh6zWbEDjDw7gBeZFWVIOTGldZbWUXqgKClaAiNBUv4Q/hMk
        ASOXDlTsKCk1KZoST2RpgCl8Wy81iYgOAQ==
X-Google-Smtp-Source: APXvYqxIK9R8wA1h3CpJmfcx+dpoPxJd1HnXlFeEh0geajAgwW6wNgMNESNZLJxIbETJtVH91cgnoQ==
X-Received: by 2002:ac8:23c5:: with SMTP id r5mr55818442qtr.319.1563908507851;
        Tue, 23 Jul 2019 12:01:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id p23sm20579571qke.44.2019.07.23.12.01.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 12:01:41 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hq02e-00043r-8D; Tue, 23 Jul 2019 16:01:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH rdma-core 01/19] rdmacm: Fix missing libraries on centos6 build
Date:   Tue, 23 Jul 2019 16:01:19 -0300
Message-Id: <20190723190137.15370-2-jgg@ziepe.ca>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190723190137.15370-1-jgg@ziepe.ca>
References: <20190723190137.15370-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Build fails with:

CMakeFiles/rdmacm.dir/rsocket.c.o: In function `rs_time_us':
/home/jgg/oss/rdma-core/librdmacm/rsocket.c:449: undefined reference to `clock_gettime'

Need to have -lrt on this old glibc.

Fixes: 38c49232b67a ("rsockets: Replace gettimeofday with clock_gettime")
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 librdmacm/CMakeLists.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/librdmacm/CMakeLists.txt b/librdmacm/CMakeLists.txt
index 4f74d4b0ac3b79..b306841ea2134e 100644
--- a/librdmacm/CMakeLists.txt
+++ b/librdmacm/CMakeLists.txt
@@ -21,6 +21,7 @@ target_link_libraries(rdmacm LINK_PUBLIC ibverbs)
 target_link_libraries(rdmacm LINK_PRIVATE
   ${NL_LIBRARIES}
   ${CMAKE_THREAD_LIBS_INIT}
+  ${RT_LIBRARIES}
   )
 
 # The preload library is a bit special, it needs to be open coded
-- 
2.22.0

