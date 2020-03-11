Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B238181D5E
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2020 17:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbgCKQNH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Mar 2020 12:13:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45408 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730223AbgCKQNG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Mar 2020 12:13:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id m9so3352102wro.12
        for <linux-rdma@vger.kernel.org>; Wed, 11 Mar 2020 09:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9Mm/1wSNfZ8uXyCSHWLFqHUu7AbvQmXdPUh//P4RHPc=;
        b=NKegFWB9CXDmFdPt8uL52ueGKEe4WEMywDCPfZ4OkgW02TZOWPaotOuifKyV+02/k/
         dRDYHTvCHek5fTFDUZ6+A6gZbTUI7wsZQoVVfI1SpsYvF2IspOox4NrUIQ37JEj7d5yX
         gX3geQEhym6h0FFCBBwxaT4aKlDifZby/6Hrer91pq0PfS69Rps3Bumi9vfeKUlTl6F0
         15KqRyOAQSH6ZtAbE993ugBHRqvFmrXIdHMbr/mTNMVkfzRg6GAHmmYrIzBQTIoU5L4u
         9pwT30Mv0i2Ni4aVo3BBb3T+5/CIfDHxFcxMUWGENyGmtkogJBJMpdxxN6RD0LBSc49v
         wj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9Mm/1wSNfZ8uXyCSHWLFqHUu7AbvQmXdPUh//P4RHPc=;
        b=pmeVZwsBnolWIgLF4heeE4VOUhff2juwVHfX/m5utxnNWxwHtoLhOoPEwW47DUIn/6
         h4/eTaaP5caEOUH72xvyMlXdwuCzeDFNQHvhMJald28Hajqh+tX0F3+tYC4cVQGcIuWN
         mFA33RGRUJS5p0hRrLlyslLDyQm7b3xDhk1IJmjANMxqspP5Br07oOwiCVQnviafZF2P
         BpeAhi3Gx2mUzE2SLb9JpMwbQIN1jf/0aJlM+LmnMBqvAHYg4sobGlsw6iUfteBKOx16
         KVfr1Er5l6lw60jHOVV6004CswpEb8uG9pV1cB2mKa61ygLkOT1H9uhxpZyZ8Nge22GU
         JAtg==
X-Gm-Message-State: ANhLgQ2suhP3ag6nTvCfeOAywQnB+6TnNBOatTgWjl7efG56Fl3zYhEG
        3Izs/p5WZaN4oYIU0WVbNrVzWw==
X-Google-Smtp-Source: ADFU+vv5mswBQHMyfBD6N+WGHTkJHGAfD9At3hbpZU4WyinePeyUqhw8/Cw9ff6DUBzWW1VxfioeGQ==
X-Received: by 2002:adf:f148:: with SMTP id y8mr5173025wro.322.1583943185700;
        Wed, 11 Mar 2020 09:13:05 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4963:f600:4938:8f65:9543:5ec9])
        by smtp.gmail.com with ESMTPSA id v13sm2739332wru.47.2020.03.11.09.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 09:13:05 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
Subject: [PATCH v10 15/26] block: reexport bio_map_kern
Date:   Wed, 11 Mar 2020 17:12:29 +0100
Message-Id: <20200311161240.30190-16-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200311161240.30190-1-jinpu.wang@cloud.ionos.com>
References: <20200311161240.30190-1-jinpu.wang@cloud.ionos.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

To avoid duplicate code in rnbd-srv, we need to reexport
bio_map_kern.

This reverts commit 00ec4f3039a9e36cbccd1aea82d06c77c440a51c.

Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 block/bio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bio.c b/block/bio.c
index 94d697217887..9190d68adad7 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1564,6 +1564,7 @@ struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
 	bio->bi_end_io = bio_map_kern_endio;
 	return bio;
 }
+EXPORT_SYMBOL(bio_map_kern);
 
 static void bio_copy_kern_endio(struct bio *bio)
 {
-- 
2.17.1

