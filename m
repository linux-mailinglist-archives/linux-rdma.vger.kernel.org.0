Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71381C2AB8
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 01:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731893AbfI3XRa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Sep 2019 19:17:30 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43884 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731914AbfI3XRa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Sep 2019 19:17:30 -0400
Received: by mail-pf1-f195.google.com with SMTP id a2so6478139pfo.10
        for <linux-rdma@vger.kernel.org>; Mon, 30 Sep 2019 16:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FUxp3rgyLhBSgFTM4FI1qwScxaiOfWHDKvnwbYfupyo=;
        b=Pqp0XvWhoXrvqex9W2NrDzkO4WQnR6iNkasXpUG9RZMzsFbC2vUyjZOIHT39B57eLF
         QSRJUb2PzrlDb5lBEvoadWfpWTfc1Tq/9HcNSPxstDONSc/Gp+YaMpShuTQXukjNC8N8
         V16sT7UOs42R0jsBSS2bNhAVIXUHRGsSJNkJj6aqnMP2clSsPVXsuwFcxuO+V8ZT7IpO
         RUVMxwoL+itQE7Vy9moindcxJsnOFFlIChXw4ME6Pd8DSSiYQRWOyxwsbQTIMtmSuRIO
         8Ltqq31RxZf7xMCslo2bS1uwH1sT2PTiUoWxzNYhdQYm3YwRj7EPKQ11xqZ8xiHBsEyS
         +KrA==
X-Gm-Message-State: APjAAAU6513vf2wOY6HHCodsrsHC69LmiEuYQ0K7fEut0kVC10XM0tyG
        CWuD3Bb2lqmLjmtbxfUWfIg=
X-Google-Smtp-Source: APXvYqxj3s/9k2zGfkixN6pb3Hxwf1zSc0xacbQpHLstynMhv1H63B8MtSek1tfISbmh1/YhuCoKig==
X-Received: by 2002:a63:dc13:: with SMTP id s19mr26607109pgg.272.1569885449492;
        Mon, 30 Sep 2019 16:17:29 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id l7sm585406pjy.12.2019.09.30.16.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 16:17:28 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Honggang LI <honli@redhat.com>,
        Laurence Oberman <loberman@redhat.com>
Subject: [PATCH 08/15] RDMA/srp: Make route resolving error messages more informative
Date:   Mon, 30 Sep 2019 16:17:00 -0700
Message-Id: <20190930231707.48259-9-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
In-Reply-To: <20190930231707.48259-1-bvanassche@acm.org>
References: <20190930231707.48259-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The IPv6 scope ID is essential when setting up an iWARP connection
between IPv6 link-local addresses. Report the scope ID in error messages.

Cc: Honggang LI <honli@redhat.com>
Cc: Laurence Oberman <loberman@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index d77e7dd3e745..6fddd14b6bd9 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -356,7 +356,7 @@ static int srp_new_rdma_cm_id(struct srp_rdma_ch *ch)
 				&target->rdma_cm.dst.sa,
 				SRP_PATH_REC_TIMEOUT_MS);
 	if (ret) {
-		pr_err("No route available from %pIS to %pIS (%d)\n",
+		pr_err("No route available from %pISpsc to %pISpsc (%d)\n",
 		       &target->rdma_cm.src, &target->rdma_cm.dst, ret);
 		goto out;
 	}
@@ -366,7 +366,7 @@ static int srp_new_rdma_cm_id(struct srp_rdma_ch *ch)
 
 	ret = ch->status;
 	if (ret) {
-		pr_err("Resolving address %pIS failed (%d)\n",
+		pr_err("Resolving address %pISpsc failed (%d)\n",
 		       &target->rdma_cm.dst, ret);
 		goto out;
 	}
-- 
2.23.0.444.g18eeb5a265-goog

