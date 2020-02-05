Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5294152A18
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2020 12:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgBELnN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Feb 2020 06:43:13 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44288 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgBELnN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Feb 2020 06:43:13 -0500
Received: by mail-lf1-f65.google.com with SMTP id v201so1232845lfa.11
        for <linux-rdma@vger.kernel.org>; Wed, 05 Feb 2020 03:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Rg7FTb2EgzwOWtOl0Xh6SbFh/TDgIq/m4oej/j7EPsc=;
        b=xqc4RuXXK6fPykrtEKs2WWshltrhXJ8pi3DtiLilCDNoCowiBWIO11F8QV2xYxhR8b
         T3vNBwC3lWRaITvvrEEqmM0SMQWJPa3dJbYhI51XEx8oF0CkrITqDVx8yRD0aTffPJDn
         sdmmfHSWVSqPoliUVDy85GbYfW6ruojAgBfVZxXigpn3TqbLBDdRhyS8A1HALKtjt7fQ
         sLqgWUx13HP8PvkDbWENV1Q7qLdBeHXkHTTFMm1c3IJcKkbYcDPWZ7K6No8QskYqARcS
         h42YxDkYmUL75rirEZLc3ay0c2OKP0hW8yKGroN5vGefezStmjyzjwY5hJRbwIuMdmnn
         RvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rg7FTb2EgzwOWtOl0Xh6SbFh/TDgIq/m4oej/j7EPsc=;
        b=EHGthaotL7uD01dO5oyQOuGfXBIfwvReSvZQ6YAGe0nvRZE0WiVmyrWHQs9PI8npm4
         6Y9pfysqLPT2f4QMzp+iTQkifpvlA0P3MOzJwNzlGE8YIzwapTcn8MDI9hE4F6HEHuLs
         63tJbd3DLFPJBMtsStXRnGh6CKSnc+3GUEwldBYTwbyEZRCZVYzvucXkvxqJU0HD03AY
         qnoVStuMrPMUwkzEIntMUKxFdtQeBAQn/ED1mDAZ2KtYyHvbsOs87mGCvb3RUX2525GE
         WYW5sTeb7ST9tkO/OnVLWZgyXTLcqcAePx9MJhsZZaq9h7Oup7iP/KOqaUYBX2XsXnCJ
         38xQ==
X-Gm-Message-State: APjAAAVag/5t5qZpBukG6olCCxJhQou4sLgcpTcTWaEQ045avHMpuPde
        2zzhRcZemx3+39jd/74XssKdOg==
X-Google-Smtp-Source: APXvYqyGuiOfyYh+qTRTsP2YJUspzVgxdBbwwERcM0hZgAzWTzfcx473yxjEYxYiSHWiqrCV91FjRA==
X-Received: by 2002:a19:5201:: with SMTP id m1mr17618504lfb.114.1580902991825;
        Wed, 05 Feb 2020 03:43:11 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id u23sm12011076lfg.89.2020.02.05.03.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 03:43:11 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 42BA0100AF6; Wed,  5 Feb 2020 14:43:25 +0300 (+03)
Date:   Wed, 5 Feb 2020 14:43:25 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 10/12] mm/gup: /proc/vmstat: pin_user_pages (FOLL_PIN)
 reporting
Message-ID: <20200205114325.4e2f5aghsusihpap@box>
References: <20200204234117.2974687-1-jhubbard@nvidia.com>
 <20200204234117.2974687-11-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204234117.2974687-11-jhubbard@nvidia.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 04, 2020 at 03:41:15PM -0800, John Hubbard wrote:
> Now that pages are "DMA-pinned" via pin_user_page*(), and unpinned via
> unpin_user_pages*(), we need some visibility into whether all of this is
> working correctly.
> 
> Add two new fields to /proc/vmstat:
> 
>     nr_foll_pin_acquired
>     nr_foll_pin_released
> 
> These are documented in Documentation/core-api/pin_user_pages.rst.
> They represent the number of pages (since boot time) that have been
> pinned ("nr_foll_pin_acquired") and unpinned ("nr_foll_pin_released"),
> via pin_user_pages*() and unpin_user_pages*().
> 
> In the absence of long-running DMA or RDMA operations that hold pages
> pinned, the above two fields will normally be equal to each other.
> 
> Also: update Documentation/core-api/pin_user_pages.rst, to remove an
> earlier (now confirmed untrue) claim about a performance problem with
> /proc/vmstat.
> 
> Also: updated Documentation/core-api/pin_user_pages.rst to rename the
> new /proc/vmstat entries, to the names listed here.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Please, clarify semantics for huge page. An user may want to know if we
count huge page as one pin-acquired or by number of pages.

Otherwise looks good (given Jan concern is addressed).

-- 
 Kirill A. Shutemov
