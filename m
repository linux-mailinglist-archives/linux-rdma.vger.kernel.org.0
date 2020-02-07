Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87067155847
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2020 14:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgBGNSz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Feb 2020 08:18:55 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34961 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBGNSy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Feb 2020 08:18:54 -0500
Received: by mail-lf1-f65.google.com with SMTP id z18so1511639lfe.2
        for <linux-rdma@vger.kernel.org>; Fri, 07 Feb 2020 05:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uTjOaImg+ksV7BdfhHPQ/FTPKTcFmsjOHyFGzGRJy2I=;
        b=px3p3e5+GsuY8I3lV6XSDycZ8agIVbKmPPwgLu3Lh8i8iQeajhpVMp4YENKqYEfWvR
         l7szyDwa/fIPpLw33kK69S5Pf6ihs+yEsGacbdzkz4PviNn2h37DeQCHeB+f9y/P9dlX
         9SdncWbfYLBcpEzPV9AYMAXIr1i7rBt3+hltAJJR9dLGiuI7doNoTQ90XAKteTE1YZaP
         a387s5QH+qimgQKymmW0q31yZKfC7F/xrtJemao9N0ck6ye7buDsUfpVivFekLFmvpU1
         jE51d1bi32F/J79szF6TeskC/TaCYG1Bq+VncIzgSLIpksUBxV5+49GAruiGknYNG36G
         Yd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uTjOaImg+ksV7BdfhHPQ/FTPKTcFmsjOHyFGzGRJy2I=;
        b=mBPaIJoh3BnHxw0ESK5NR8gdayIoVUPC83NTgxPm8lEyAno73hHJW293UfkO6rZM45
         WCl+uMon7r6LFveBRU2SQkBYolmPiY0pI+gB9tqoZ7ynKut9rnuHyr7JLpC0eD0DgZOz
         X72MmN18TZgr+Ho5+9AI/AVeT1tLyzGzxrk4rPX2nfHDPcQz1TMsjIpbG6vK+7gsud8A
         TBG4sG1czQhETvpXc8sJHDDx66LTarK00bpe4Z8EotGlOpnJ1bms1dz9yplujUTbn80N
         Ye4bB6A6KRMrHfTzXh9yXTreLJl0WYwop4umpy0s9vmeTMg3/U4np4Ukp6VjQkKuW2eu
         VaCw==
X-Gm-Message-State: APjAAAWFfyBxkJzX99vMDy02iW5XX9qj2KLRPywkQUaHpOPy1Eu2sWn7
        qkX00k8FGtZkU621q3S+PZtLFg==
X-Google-Smtp-Source: APXvYqxjvYht2BAnt/sn52oyart+TOO9Z4BGc1YhTQrInCsed0Qr9BHzni7Ywm8GZcbncIGhJ4MD0g==
X-Received: by 2002:ac2:47ec:: with SMTP id b12mr4552216lfp.162.1581081532420;
        Fri, 07 Feb 2020 05:18:52 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id 4sm1056760lfj.75.2020.02.07.05.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 05:18:51 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 5174D100B12; Fri,  7 Feb 2020 16:19:08 +0300 (+03)
Date:   Fri, 7 Feb 2020 16:19:08 +0300
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
Subject: Re: [PATCH v5 10/12] mm/gup: /proc/vmstat: pin_user_pages (FOLL_PIN)
 reporting
Message-ID: <20200207131908.hplpt3gvvek56zm7@box>
References: <20200207033735.308000-1-jhubbard@nvidia.com>
 <20200207033735.308000-11-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207033735.308000-11-jhubbard@nvidia.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 06, 2020 at 07:37:33PM -0800, John Hubbard wrote:
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

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
-- 
 Kirill A. Shutemov
