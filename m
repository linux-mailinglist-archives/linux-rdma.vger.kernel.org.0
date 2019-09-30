Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91F75C2AB6
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 01:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731890AbfI3XR2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Sep 2019 19:17:28 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:40064 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731840AbfI3XR2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Sep 2019 19:17:28 -0400
Received: by mail-pl1-f177.google.com with SMTP id d22so4499001pll.7
        for <linux-rdma@vger.kernel.org>; Mon, 30 Sep 2019 16:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ykBs8a3TuaMfCRpJEdk54DvGqAFLnU+m5ckDb+h6hQk=;
        b=qGkbr74uxd88RjrtOdJjnTuAQ+eznpWZMkgV51UGi1AnftpB+GFFPBLpx2cpgZVVyj
         BrjCdCikhla42a9edV9BtTh4r+LIf4soTWNkNf20HW7obftZqLM1Aq6Sodpom9ruQVWC
         SoHeHCr8vg3pBNDkslHYYe1y1HfhGmCnm78DPJ9m3FExvT8i+0qR7h1lMH2rtq/uhoS3
         nYUcPlV3xZq/w8JCKO2en9eiGrZxCg1zfjb6YkDT2I4aZsumZ8RQZnjl38FoAv/CMBHc
         ltvB1eeFZbcpbg6c7eT1Ddzv7HlcRsYg8+Xk6zhe/zXMVnjf+/buCVIFjJSjmkgfwcUU
         Tx2g==
X-Gm-Message-State: APjAAAVRuQBN5dLCPy4A7xk6UJNJrRiCgGGEud21V78WiUbwflHJJyX+
        qtYZzm3k7DgoVv88eShCpIlZe2ucxpI=
X-Google-Smtp-Source: APXvYqw2viLEInRgOzAbkBZuPPa+jDl5dmUMpsPlVkL2eknBFxYSUI01+dhKdJZBlV3WSxD9V1tBxg==
X-Received: by 2002:a17:902:b7ca:: with SMTP id v10mr21722308plz.54.1569885446428;
        Mon, 30 Sep 2019 16:17:26 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id l7sm585406pjy.12.2019.09.30.16.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 16:17:25 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Honggang LI <honli@redhat.com>,
        Laurence Oberman <loberman@redhat.com>
Subject: [PATCH 06/15] RDMA/srp: Remove two casts
Date:   Mon, 30 Sep 2019 16:16:58 -0700
Message-Id: <20190930231707.48259-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
In-Reply-To: <20190930231707.48259-1-bvanassche@acm.org>
References: <20190930231707.48259-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch does not change any functionality.

Cc: Honggang LI <honli@redhat.com>
Cc: Laurence Oberman <loberman@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 4 ++--
 drivers/infiniband/ulp/srp/ib_srp.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index b5960351bec0..f015dc4ce22c 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -352,8 +352,8 @@ static int srp_new_rdma_cm_id(struct srp_rdma_ch *ch)
 
 	init_completion(&ch->done);
 	ret = rdma_resolve_addr(new_cm_id, target->rdma_cm.src_specified ?
-				(struct sockaddr *)&target->rdma_cm.src : NULL,
-				(struct sockaddr *)&target->rdma_cm.dst,
+				&target->rdma_cm.src.sa : NULL,
+				&target->rdma_cm.dst.sa,
 				SRP_PATH_REC_TIMEOUT_MS);
 	if (ret) {
 		pr_err("No route available from %pIS to %pIS (%d)\n",
diff --git a/drivers/infiniband/ulp/srp/ib_srp.h b/drivers/infiniband/ulp/srp/ib_srp.h
index b2861cd2087a..af9922550ae1 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.h
+++ b/drivers/infiniband/ulp/srp/ib_srp.h
@@ -245,11 +245,13 @@ struct srp_target_port {
 			union {
 				struct sockaddr_in	ip4;
 				struct sockaddr_in6	ip6;
+				struct sockaddr		sa;
 				struct sockaddr_storage ss;
 			} src;
 			union {
 				struct sockaddr_in	ip4;
 				struct sockaddr_in6	ip6;
+				struct sockaddr		sa;
 				struct sockaddr_storage ss;
 			} dst;
 			bool src_specified;
-- 
2.23.0.444.g18eeb5a265-goog

