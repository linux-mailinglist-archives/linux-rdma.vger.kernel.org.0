Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 723CC37C71
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 20:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfFFSot (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jun 2019 14:44:49 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43615 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfFFSos (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jun 2019 14:44:48 -0400
Received: by mail-qk1-f196.google.com with SMTP id m14so2118858qka.10
        for <linux-rdma@vger.kernel.org>; Thu, 06 Jun 2019 11:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i7+8VVGKVPXEVnSFQY2/eN+heRnF32oClEuR9RZcz4c=;
        b=awv3zzYYkAzknK7/NkCAiHR5B250y04djNp+WoYpexe7Uej2IPZ5cqDxrJR0439HDp
         Ip+tkYncoM6synNyttQstYPfXOCfvqJ+MFaPA020vji6f3V+ijeewe00T5WLlGVbBkip
         ta/ZcbdijmmX7p+PqFRh9FOoQWxBygNZCZjmbhPstNfn/mX4xsgnW1BaTUSYo/a8jPup
         YkMIRPOwMicKl54A6Y5BoXPtSil+jxKqN6rTDrLm8CETdgRy4WQzp8exudHeoEcxgA4t
         JqZxvdcH0B1B5+3aq+YyPAmAifoH1FgyXvEu+EF0wwHDyoaCdNCX+I1ObXgN34um9W9p
         meJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i7+8VVGKVPXEVnSFQY2/eN+heRnF32oClEuR9RZcz4c=;
        b=PvKgrUqf73mLiCl4FFku1KgrbIf7YkUtwI+t2MwBtcbbNLDKvccW4A5PGxGUG6Z224
         FrrMsm4zg0qiJVrIqVN+wA4TASgAmvoh2C2f6S+I+Q6lMAyFLy3SLeH5H0o/iva9US74
         JTycDhIgNNSdXAOpk4YkL+ls/FcGQXCGKG7ignssxLVr6Xr1l8W83Yl1A8tSi1nEhOSg
         AcFNyMyZW/Up7FDdu/qj7NRJevZr7QZ6rLfXegQgZdors/83BnljnprWERsdqyHTwfw4
         4Vje26h+yyMmkp7SrDHl1zflgUExQfyu41wi0o4DW17ZmpdWjBO3XU1g/zJtyN7sMfP5
         qKSQ==
X-Gm-Message-State: APjAAAWsmqbWnPGfkgKLe6y5VuvhDwo6Ri9d6/d3GZgbyPpoGTtjkAae
        8oaeZXKb/Fz9lBD7QV5oNzJ4vA==
X-Google-Smtp-Source: APXvYqzcNAbWl+BqHtgTaqiaVwnoaAOHy/kM0yjt/wGvoT6pCtDHNXa8FJTB1/3g0VUWQOgRUAVd7Q==
X-Received: by 2002:a05:620a:1ee:: with SMTP id x14mr39905952qkn.70.1559846687875;
        Thu, 06 Jun 2019 11:44:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id f6sm1303617qkk.79.2019.06.06.11.44.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 11:44:46 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hYxNV-0008IT-Km; Thu, 06 Jun 2019 15:44:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH v2 hmm 05/11] mm/hmm: Remove duplicate condition test before wait_event_timeout
Date:   Thu,  6 Jun 2019 15:44:32 -0300
Message-Id: <20190606184438.31646-6-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606184438.31646-1-jgg@ziepe.ca>
References: <20190606184438.31646-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

The wait_event_timeout macro already tests the condition as its first
action, so there is no reason to open code another version of this, all
that does is skip the might_sleep() debugging in common cases, which is
not helpful.

Further, based on prior patches, we can no simplify the required condition
test:
 - If range is valid memory then so is range->hmm
 - If hmm_release() has run then range->valid is set to false
   at the same time as dead, so no reason to check both.
 - A valid hmm has a valid hmm->mm.

Also, add the READ_ONCE for range->valid as there is no lock held here.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
---
 include/linux/hmm.h | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 4ee3acabe5ed22..2ab35b40992b24 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -218,17 +218,9 @@ static inline unsigned long hmm_range_page_size(const struct hmm_range *range)
 static inline bool hmm_range_wait_until_valid(struct hmm_range *range,
 					      unsigned long timeout)
 {
-	/* Check if mm is dead ? */
-	if (range->hmm == NULL || range->hmm->dead || range->hmm->mm == NULL) {
-		range->valid = false;
-		return false;
-	}
-	if (range->valid)
-		return true;
-	wait_event_timeout(range->hmm->wq, range->valid || range->hmm->dead,
+	wait_event_timeout(range->hmm->wq, range->valid,
 			   msecs_to_jiffies(timeout));
-	/* Return current valid status just in case we get lucky */
-	return range->valid;
+	return READ_ONCE(range->valid);
 }
 
 /*
-- 
2.21.0

