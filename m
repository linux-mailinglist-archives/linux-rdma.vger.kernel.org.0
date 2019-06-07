Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB2038BAA
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 15:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbfFGNbJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 09:31:09 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45883 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbfFGNbJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 09:31:09 -0400
Received: by mail-qk1-f196.google.com with SMTP id s22so1209844qkj.12
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 06:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zyyI11Z3twoMqyf467AVpMwpHxurGKneH7RYfifhIWc=;
        b=XgOcttxFtSt4H5m5uTCUVVYtTNFhZHmzuEIcILLOVnJTu+kol297oc8jfVHnMOgYN9
         KVEhxjN9bHA5zi86oSYRpPBOLol1xW6VGzKyzKOv70gX/o8vASgRfjhKpeATGGiqi8p2
         XV9oIhpp7n0dBZ+VcT3Ff1tVvGN74BzHYOdaSZZrBG0ZxI7UWy4T5qOcP/C4WH3Ycm4Y
         lP9tn3aHO6VWRdFJP59ZySBW8Q29pZmHb8PDxgcfNSvjw/TLR1TF/3PqNNu/lSeFsfDM
         CdiCDVyFP6EYfwN3gNesdEq1ky1h+HmPF/DKvbPP6G+zZ68XUx8LDhlgAyCmkYu0Z+ko
         Ll/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zyyI11Z3twoMqyf467AVpMwpHxurGKneH7RYfifhIWc=;
        b=dBreLeJ6kBx87JrsKXH/ma0YiZTRZVY9ouDWJ33v8AZMlrkAM7/6srBfaeubhgEEBb
         /+w4a+C9n7xjb8Nzh2Aa0ZaJU3m/hgPvQuAD9oOYirA28yYUj8JW8UBXAgJ1+9t8NpeY
         dGx52A6KvbG9K5HpdLA6HBgV8AGVsXQ1x9ynPeoOOPHN/iyqnJIy5PH7imu8JLcyPQAu
         XXe0w5RtqQWKM9VluZNkEKnFOWlb3ymt4K0sc3v9OkH18w08U1cC2ukXd/qBOgoZRWbI
         XQir8D7q9Wl1L1wcsRxyxLst8jHlKQMBJftHFfowaFZg0+J7MSVu9IDT/D0Mz1U/VWIk
         80Ig==
X-Gm-Message-State: APjAAAXBkOnkUzCw0OOC8puWxDzC1q4tmqFfmlOSttaCLqp8B18z/Z9E
        NFynOvRtGbEe90rEPNcdXLTX1Q==
X-Google-Smtp-Source: APXvYqxiNRSOLULUOOVL1v/Vkw7sprKOSUyk24LlCfBwSCfz+nugTDkDj+dcDkV3fQgXrssqVlWltA==
X-Received: by 2002:a37:5d44:: with SMTP id r65mr36792567qkb.73.1559914268352;
        Fri, 07 Jun 2019 06:31:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id z12sm920156qkf.20.2019.06.07.06.31.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 06:31:07 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hZExX-0007wK-Fu; Fri, 07 Jun 2019 10:31:07 -0300
Date:   Fri, 7 Jun 2019 10:31:07 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 hmm 05/11] mm/hmm: Remove duplicate condition test before
 wait_event_timeout
Message-ID: <20190607133107.GF14802@ziepe.ca>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-6-jgg@ziepe.ca>
 <86962e22-88b1-c1bf-d704-d5a5053fa100@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86962e22-88b1-c1bf-d704-d5a5053fa100@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

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
