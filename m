Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB999450D9
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2019 02:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfFNAo6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jun 2019 20:44:58 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42021 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfFNAo6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Jun 2019 20:44:58 -0400
Received: by mail-qt1-f195.google.com with SMTP id s15so581333qtk.9
        for <linux-rdma@vger.kernel.org>; Thu, 13 Jun 2019 17:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4TWMeUG5gYhJoHE/SGg4kXx8gam66v1Nu5XHiuhyFtI=;
        b=Z24AVcLXtS9fjUgk7s4+KXtzjE1aMT2PBcEb07xw67SglUSd3OzuNg62oNcMTOdCCO
         tuaeQKOzQsp5HbqBLHd8K7YGNauURpRUKgNdhJfNe96/SZel8ZB2rP2x8NzbogFeDlIr
         +yZSWZUazmveTBDnu7n84ZdABGyatv0J9NLBsDYYL9OXjABLlvao0fEL2KwxuHwW8PZp
         /+vezcHxEC4oBD4j7w/eFErEFwQXwCtbfqwi4hyrQWWNYY2o77J7tHghIjFCTg3ZdCds
         UZ2dBkr9KXBNBNjxQciAe4xHvlePPQaKw/4isjgNYaLJ9hRnWkLaIVZIqWtqd6dVzykM
         qQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4TWMeUG5gYhJoHE/SGg4kXx8gam66v1Nu5XHiuhyFtI=;
        b=Ui5jKWdcoOix290Sgao/BPaz3kmwU+5ITCrPdwnV770RBqvfwuujqvjtRA4YRfGkVL
         3NylIUf3vK2RLPRzR0xgrRqWhdJ++9KmQikmBJN5yL5g0rs0r23CESWHQFoPiS5sbKaV
         UiaLlUy9nHaPqUfE9bdd6x3WlAkCnFXTo3me+d0pJiFwISt87MN7po91zma6z44T6E0o
         sg/feawHVL5V/yMy7XLuXqfT4sV+J2jAmOzKyyUY/6Q0F4i1xFuFtgdAmvSPDlMmWJ/Q
         qi7wp4swSwYiX/b6ySW0hc/WtAQLQp4A+RGSrvdEF/Iy/OJnBto3wRExKTKOMh1VUnnE
         TMfQ==
X-Gm-Message-State: APjAAAWeMTlLt8aHYCSCLl9R6Z3xt7EZhFWHTJ0y+FxDA7ottNIQk1Fm
        Nx1EgCftKgIK7ngvke1UpCaXZg==
X-Google-Smtp-Source: APXvYqwqGlFwoXSFqE9WKQZMugVvrqSYWsVu7EvQI2b+rocz25JrwetUsVc8pOMWgciELT4SKnPuKA==
X-Received: by 2002:ac8:3014:: with SMTP id f20mr78276048qte.69.1560473097168;
        Thu, 13 Jun 2019 17:44:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id g53sm678695qtk.65.2019.06.13.17.44.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 17:44:54 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hbaKr-0005Jw-Px; Thu, 13 Jun 2019 21:44:53 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v3 hmm 05/12] mm/hmm: Remove duplicate condition test before wait_event_timeout
Date:   Thu, 13 Jun 2019 21:44:43 -0300
Message-Id: <20190614004450.20252-6-jgg@ziepe.ca>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190614004450.20252-1-jgg@ziepe.ca>
References: <20190614004450.20252-1-jgg@ziepe.ca>
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
2.21.0

