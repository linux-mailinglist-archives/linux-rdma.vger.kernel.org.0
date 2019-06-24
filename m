Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C80051CB2
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2019 23:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfFXVCI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jun 2019 17:02:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46236 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbfFXVCI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Jun 2019 17:02:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so15321826wrw.13
        for <linux-rdma@vger.kernel.org>; Mon, 24 Jun 2019 14:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xvvvfm/iICt6EAx3A7hygYXF1jRJFUeMrawdTwOi4ns=;
        b=oRmOk0Zjj6i+pMHvCNnVsb1wjfONs2JBTQnEE3rglcDcUQoG84gXWTDhq9ll76MAqu
         NbvHm5LXP2Mk44izNVB3slQr8uyWefSSkQB31EfSp+uwq/HLZh/BdNDnY90d603FucOz
         AC8Ce8Oh4o0dEDF5pq+h9XhIOGQHW9OrQOCgPMR6XEU0ePQEDlF6JmUB9j6v51IImlni
         0CRtVjdLLAq8G7uZWcwboxDMUZIuPWUPunZLZVkEDI1o2Eb0mtkYKg08tRTwS/QFWzk2
         3v3z9wVq/LNXCzMnbVfsewXyPw+o1BeCYz8bMIx9Jd6EvXRVTZY/u0AkUUg08yGiPfXO
         xJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xvvvfm/iICt6EAx3A7hygYXF1jRJFUeMrawdTwOi4ns=;
        b=GtHg9L2S4TwsGCOzAoj3+tIp6JFNtWZ4u76NTl3nStMXuK6yOjkhhHOHdi0pKqGnad
         HjU+yCF0pkz4lqmtjLbhArRDmG1xto2F41LtKVfu3tnU7LB7vyfXhum8H0BDCS3QnNtJ
         ZIj6UueNXdsZlJ2n9e9QwoNr4di5Fe9ld6M117yS26W89dnZwgqwXVuErOyR/s2E8xa4
         XQzYIk0uXEW1f1OBHlCNB7kk1CUqRIDzSpWnIfU5bumWucMt4Yxi9nLJ4YOFfsz9tgQj
         Oc0nZyEDb1M7bAiMrEt6A4AzbrjzcTfiGatU6fsAV6cEjFX4K0sIKoiYcIjBfvb2dvP0
         p7hg==
X-Gm-Message-State: APjAAAWx4Y5hF5zmhGst8ZVA6DtR1pJXjBO163N7nNARPwPiCJNL5rga
        JCs4rSOA1qm3fgIPC2KQ1+xULA==
X-Google-Smtp-Source: APXvYqxEB08pD22xw7z431fz4zoGHVSBNwMRdaiB40BUYEvmuPcR/sYQyqDcLZPR3XganfuFLHNJMQ==
X-Received: by 2002:a5d:5283:: with SMTP id c3mr28666603wrv.268.1561410126403;
        Mon, 24 Jun 2019 14:02:06 -0700 (PDT)
Received: from ziepe.ca ([66.187.232.66])
        by smtp.gmail.com with ESMTPSA id j7sm16820277wru.54.2019.06.24.14.02.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jun 2019 14:02:02 -0700 (PDT)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hfW6C-0001MM-Sw; Mon, 24 Jun 2019 18:02:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Philip Yang <Philip.Yang@amd.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH v4 hmm 05/12] mm/hmm: Remove duplicate condition test before wait_event_timeout
Date:   Mon, 24 Jun 2019 18:01:03 -0300
Message-Id: <20190624210110.5098-6-jgg@ziepe.ca>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624210110.5098-1-jgg@ziepe.ca>
References: <20190624210110.5098-1-jgg@ziepe.ca>
MIME-Version: 1.0
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

Further, based on prior patches, we can now simplify the required condition
test:
 - If range is valid memory then so is range->hmm
 - If hmm_release() has run then range->valid is set to false
   at the same time as dead, so no reason to check both.
 - A valid hmm has a valid hmm->mm.

Allowing the return value of wait_event_timeout() (along with its internal
barriers) to compute the result of the function.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Philip Yang <Philip.Yang@amd.com>
---
v3
- Simplify the wait_event_timeout to not check valid
---
 include/linux/hmm.h | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 1d97b6d62c5bcf..26e7c477490c4e 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -209,17 +209,8 @@ static inline unsigned long hmm_range_page_size(const struct hmm_range *range)
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
-			   msecs_to_jiffies(timeout));
-	/* Return current valid status just in case we get lucky */
-	return range->valid;
+	return wait_event_timeout(range->hmm->wq, range->valid,
+				  msecs_to_jiffies(timeout)) != 0;
 }
 
 /*
-- 
2.22.0

