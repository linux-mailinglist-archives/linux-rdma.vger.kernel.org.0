Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 026EA18CDAB
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2020 13:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgCTMR0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Mar 2020 08:17:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53942 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbgCTMR0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Mar 2020 08:17:26 -0400
Received: by mail-wm1-f65.google.com with SMTP id 25so6259040wmk.3
        for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2020 05:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9Mm/1wSNfZ8uXyCSHWLFqHUu7AbvQmXdPUh//P4RHPc=;
        b=EuCeoyTPoMZfi0ECxiY+ov5mYOnJxbzRq/2KmiZNZCoLs4siHWz/m1Y+vJ5J2DuctW
         ICQsImR48nnjQSxGYiBRFQhwQQbhwj1gfP2Qk1adiU/ATA2pYDDD5+Yn3tfwEm12FFLH
         Zlz6KfFckMr63BPkgoFx3zkKJPcrp/2Y4MZtr9yt1OxvfxcQQN8F5J0xGA/qDNxrrk40
         Ibl0gW6I8ukO+LYFjx0tyBP2qhaDIjv3nGvoKvE7mIgteIuaI1qd54DUzdX4RSrpSlpw
         a3flrDuOWxe9PChUixfw7YbAR1R4lAoUs/4KV/Xo/t8B1UABiLUfURe3Mia3Zz3hrdRx
         uBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9Mm/1wSNfZ8uXyCSHWLFqHUu7AbvQmXdPUh//P4RHPc=;
        b=FFeRqcSqHH27JuWhEQ8t569Ks7r/KvREwZr8G52PVHdgMnwe9sBMxXxslbFmZg3kQk
         Tb5aKrfH12GLa3MZPgmiiLbQddyn5HE67zLZhMLP07VS92WxfdNi8nsSTaw7l+p5mE/4
         LpgUi4N18pNwIl81CmhQMEyZM7Lit0qnBBRlFzurOYzl+SYWe7zXZgwvmFDuvah2QLaJ
         DmDFAUY9+6D1B20kGEuLbaBxeJ2IlHU14Uvz4l5Ql/oNmgS9DaEm+03+ruAAfwN/BHOQ
         EQQ3EX1yxTTgK0q+eurRUHbAImVoSic6iU9wtIHzFtCFV6GUvTq30+9lobEiyRi4kXhb
         JhiQ==
X-Gm-Message-State: ANhLgQ0oflag9q2z9gpng8CuWH7EYJ5gUbZOJLbNIyh/imNOBuQyZlxu
        YfBR/P3MDjvzjTh4VtDQlRNpZg==
X-Google-Smtp-Source: ADFU+vvs711CH6Mf1TkExttVVSrv1NFN6YmXhTEK/JATngvBlW8YfDz9X/0t3ZFUi2Yi3abigx2wJg==
X-Received: by 2002:a1c:4c1a:: with SMTP id z26mr9931588wmf.11.1584706644532;
        Fri, 20 Mar 2020 05:17:24 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4927:3900:64cf:432e:192d:75a2])
        by smtp.gmail.com with ESMTPSA id j39sm8593662wre.11.2020.03.20.05.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 05:17:23 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
Subject: [PATCH v11 15/26] block: reexport bio_map_kern
Date:   Fri, 20 Mar 2020 13:16:46 +0100
Message-Id: <20200320121657.1165-16-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
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

