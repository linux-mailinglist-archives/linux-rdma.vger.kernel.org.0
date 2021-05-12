Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26F937B484
	for <lists+linux-rdma@lfdr.de>; Wed, 12 May 2021 05:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhELD3M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 23:29:12 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:39727 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbhELD3M (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 May 2021 23:29:12 -0400
Received: by mail-pf1-f172.google.com with SMTP id c17so17557427pfn.6
        for <linux-rdma@vger.kernel.org>; Tue, 11 May 2021 20:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NeoVKuu1izPRDjzl6yrfqlvFWiO09o+X/S+BeQbM/x0=;
        b=LTplK823Hh1mAgDTcBkumq7uTtdpkWOIyVWfhUrCsO40QjFlB9HiTFLYMHHR8aekFM
         aTFQRumu69j8xcPArbFgobC+9ZqstTXLvYM8+IGHqVoViPXtxBCPKcr5lJwHl/k/EBh0
         917S1gf3qziEfGhvI5Yrpe/ZonXwLm+P9uqG02ImfVcHC70jnMFtufy5iwafN4XGPmcc
         5sHFC5ecwk7RUvvWKFO4F1O/OaGlRlCYye5Rq7XEZ2AEG5+/RNiP3ZcUhqvHlEnspKqg
         8/fHuwp3a+r/kFDZDpP7hTZ4CwyVBl18HvXvnkrnQip9alrMt4AliThqz9ZeLy6TvsS6
         h35Q==
X-Gm-Message-State: AOAM531JQtOMSIdEpEpcM2ppoMJmKwKKLvSnRt8I+7FaK8i32flQYzW/
        eenl4ShzJrxfEsQNN0GFBGE=
X-Google-Smtp-Source: ABdhPJylkitJz9sPpl+f/UAmSGNhi1GEyUudwxNw6TfSmXpt+xSGvpV6QGiZZ/6gBtkKkP9uGa21cg==
X-Received: by 2002:a62:4e10:0:b029:2cb:cf3b:d195 with SMTP id c16-20020a624e100000b02902cbcf3bd195mr4465125pfb.74.1620790084797;
        Tue, 11 May 2021 20:28:04 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:76b9:3c77:17e3:3073])
        by smtp.gmail.com with ESMTPSA id q194sm15008703pfc.62.2021.05.11.20.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 20:28:04 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Subject: [PATCH 4/5] RDMA/srp: Fix a recently introduced memory leak
Date:   Tue, 11 May 2021 20:27:51 -0700
Message-Id: <20210512032752.16611-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512032752.16611-1-bvanassche@acm.org>
References: <20210512032752.16611-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Only allocate an mr_list if it will be used and if it will be freed.

Cc: Max Gurtovoy <maxg@mellanox.com>
Cc: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Fixes: f273ad4f8d90 ("RDMA/srp: Remove support for FMR memory registration")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 0f66bf015db6..52db42af421b 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -1009,12 +1009,13 @@ static int srp_alloc_req_data(struct srp_rdma_ch *ch)
 
 	for (i = 0; i < target->req_ring_size; ++i) {
 		req = &ch->req_ring[i];
-		mr_list = kmalloc_array(target->mr_per_cmd, sizeof(void *),
-					GFP_KERNEL);
-		if (!mr_list)
-			goto out;
-		if (srp_dev->use_fast_reg)
+		if (srp_dev->use_fast_reg) {
+			mr_list = kmalloc_array(target->mr_per_cmd,
+						sizeof(void *), GFP_KERNEL);
+			if (!mr_list)
+				goto out;
 			req->fr_list = mr_list;
+		}
 		req->indirect_desc = kmalloc(target->indirect_size, GFP_KERNEL);
 		if (!req->indirect_desc)
 			goto out;
