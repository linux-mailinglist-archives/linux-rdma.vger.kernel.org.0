Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 267B928151
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2019 17:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731070AbfEWPen (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 May 2019 11:34:43 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43822 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731048AbfEWPen (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 May 2019 11:34:43 -0400
Received: by mail-qt1-f195.google.com with SMTP id g17so1163400qtq.10
        for <linux-rdma@vger.kernel.org>; Thu, 23 May 2019 08:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DCPTNx8CjmJ5EZR4Q7fEVnlEGDk6XaLfhfnTJM/xZQM=;
        b=UscylUyC/LbE+hmwHcoTPty0rCYV8C9l6BH2lAPjaiQ8KCpQHYGVFqbwt9qHDAXr8/
         0k3qTMBhSJf3S42PRZfbrX9UEI/6LGFwoDjvFpmqQlcDDdNyD6dTDJrchuLLNc489jB7
         Y/rZmj+WB81MnhoL6YnHiAQeUu1bwtK84oY4YfOfklhLOiyLAZUJPzOkPy0cRE3mZC87
         G/yVQEsPneUO8B683OG8mQMLHQ79F1URNwp0dMjSHeuCd7ZWZGchFIcBB3L628nY5y71
         wweFi2dQmZAt9lY8+eQpEay8IdpvBecKhqsuVKkK81+YslCO9og21vt7HuyZ/YQvqfFx
         2JDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DCPTNx8CjmJ5EZR4Q7fEVnlEGDk6XaLfhfnTJM/xZQM=;
        b=Mbd6sv1/2gi3YKYf+SBuLw6zvpvlezVVfnnHHhFh27ffumfGFHJMeubOQAMOaci63/
         bwCD1LCnkn032U10jeTKfamgoInjguKurGjOFHAJ6N3AP3XMbU5Oqh+xxwXGKMkq8YQF
         zQOskxUyMiQz+NEbG9eY/E379KmazZAEYp0KCvAbDNhr0uHQuI9LBkymM5VsMSzNidKx
         ukt3wiiUEjbDW3IOJQCh6Bs31OJ/7wj4KyvPest03qwtz5TUgoUE/+d5tYdGT3HwTl1m
         Ngn1dr4quNQe9FP8C4Ogx1+36wYrTor6ArR9qRQMJoFoWjDctdwNSxMgeodTtFA5j+VU
         sbUg==
X-Gm-Message-State: APjAAAUvNMEMrzT/0as3v5Uv23EMQJ2qAa5Cm0lTdrlxKkyc76feCV5b
        aMuOkKoDh7NP5J3d03KdKlZg6b10LPg=
X-Google-Smtp-Source: APXvYqxlKr/De7Ph6kX9Z/iOmfGCPd6u0UkBZ6roajbjLbPCO1l9qWnchzPbSB+6YXzx7C5cfiG9rg==
X-Received: by 2002:ac8:28ac:: with SMTP id i41mr57963862qti.388.1558625682235;
        Thu, 23 May 2019 08:34:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id a51sm17403701qta.85.2019.05.23.08.34.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 08:34:39 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTpjq-0004zf-3t; Thu, 23 May 2019 12:34:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [RFC PATCH 06/11] mm/hmm: Remove duplicate condition test before wait_event_timeout
Date:   Thu, 23 May 2019 12:34:31 -0300
Message-Id: <20190523153436.19102-7-jgg@ziepe.ca>
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
---
 include/linux/hmm.h | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 2a7346384ead13..7f3b751fcab1ce 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -216,17 +216,9 @@ static inline unsigned long hmm_range_page_size(const struct hmm_range *range)
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

