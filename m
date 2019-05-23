Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1E828154
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2019 17:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbfEWPep (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 May 2019 11:34:45 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44773 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731089AbfEWPeo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 May 2019 11:34:44 -0400
Received: by mail-qt1-f196.google.com with SMTP id f24so7200660qtk.11
        for <linux-rdma@vger.kernel.org>; Thu, 23 May 2019 08:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sVSVMj7qtVOG+pR++xGbUKEq7rSWx5vQVniXU7xAdVY=;
        b=DZpq16KCBGWseTw+Emu3YXxJ4qAUUBYOgC5S+OOEj/qjUePnCbs18YftNrqI5k72oF
         PF78BOqbqq6gsqFCloyWSHUujhEA6iLhbwmuZW+tDHMvYXyKsgXqWsFKUjift9trNwPn
         rqocr9xDbYrprtIAWRiT7tiljZiU9eyK5kUSizlvzHsiN4QQ+GhHFIt7Cl39+kytFtcP
         YEmfFYaselG4ky3Uaic1er6GJoWtkTtMUKSq5/K7iPHbfWN6p8Dto2g7QzWwkTANGhkB
         ROp6hnDt0PpHQofzdaPfaC8krT25q9BBGFxfk+c0x0zYuBd4O1EiwzV88vfNmYBJAYQz
         bG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sVSVMj7qtVOG+pR++xGbUKEq7rSWx5vQVniXU7xAdVY=;
        b=IzDSbY+AO3mr21xH5iZ/FY2rT6bMOLse+i9rN7YvKrSlMEXBoUCLh8cseIgParyT4p
         sAepVgCGJNmVc9cQ/XN2g7vP6d6fv7sGheniroGMN0olwhX6rukeo8FT1x2vzO5O1goK
         CkkWTQqcZJKxOWxzgHHtt8bVl68KrSs/FrRIGd/Vc02pRjMuag1KhQwUSrnAlk0NfVa/
         +xlzRRZwhQewg9xvfNmoaC7fEzFoGNsLejPz46RC0BbpSGCnxL7ME5kwLiihdEdsBDAC
         4l+xsbjVUrY1zw0Ul2L8saJuF/F9noP+bzgsc0FUvBc9MzOtcOXZFa4tS2xXLpWSjVhT
         2DAA==
X-Gm-Message-State: APjAAAV7qatsBwjMTGptqZQGEE4p7aJUKIB2ULeOEWzOYYL8vp+QGBlF
        PE9/G5E69XJj5Y8u59ylpka8lJYDuts=
X-Google-Smtp-Source: APXvYqwlZgmvtDLezrwrAV3Bsq4rJxczbRVrNsIiCVDFfpxHEZgg1uH2yntWWMscbHuucZ+UF0vtYg==
X-Received: by 2002:ac8:18b8:: with SMTP id s53mr76217130qtj.232.1558625683755;
        Thu, 23 May 2019 08:34:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id h17sm12879104qkk.13.2019.05.23.08.34.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 08:34:39 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTpjq-000509-Bh; Thu, 23 May 2019 12:34:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [RFC PATCH 11/11] mm/hmm: Do not use list*_rcu() for hmm->ranges
Date:   Thu, 23 May 2019 12:34:36 -0300
Message-Id: <20190523153436.19102-12-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523153436.19102-1-jgg@ziepe.ca>
References: <20190523153436.19102-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

This list is always read and written while holding hmm->lock so there is
no need for the confusing _rcu annotations.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 mm/hmm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 02752d3ef2ed92..b4aafa90a109a5 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -912,7 +912,7 @@ int hmm_range_register(struct hmm_range *range,
 	/* Initialize range to track CPU page table update */
 	mutex_lock(&range->hmm->lock);
 
-	list_add_rcu(&range->list, &range->hmm->ranges);
+	list_add(&range->list, &range->hmm->ranges);
 
 	/*
 	 * If there are any concurrent notifiers we have to wait for them for
@@ -940,7 +940,7 @@ void hmm_range_unregister(struct hmm_range *range)
 		return;
 
 	mutex_lock(&range->hmm->lock);
-	list_del_rcu(&range->list);
+	list_del(&range->list);
 	mutex_unlock(&range->hmm->lock);
 
 	/* Drop reference taken by hmm_range_register() */
-- 
2.21.0

