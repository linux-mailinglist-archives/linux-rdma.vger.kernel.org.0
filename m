Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F385150727
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2020 14:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbgBCN0R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Feb 2020 08:26:17 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32861 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbgBCN0R (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Feb 2020 08:26:17 -0500
Received: by mail-lj1-f193.google.com with SMTP id y6so14641523lji.0
        for <linux-rdma@vger.kernel.org>; Mon, 03 Feb 2020 05:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/c8JqFBoF+Wyv0y7vjPLE9bVpeDasBR2S69E+7r2TtY=;
        b=Qvgtk33ftlbcsS5ozma4SkqBFwKXe/etS4q98w1ik72KUgLvZCb5LF6bX9en+6X9bo
         RZkuxEhczs1LHPUxff5YONZLAinu2abSX1x8hd1YrVMhXhSPB6YnCGS2IgB7n4ZvycwY
         4guibrya0uJJxVpAXyYDoHuuVBQYz+s5yLsNWj8sly+tVIODbFFekbsty1PMf0QzYhud
         yGJvBqTV33CGmK5iIJ6dNPJY9ofEyM3bweM9PnVwm793arTmLHxyQ5c99wp2YWiXJHjo
         fRwKRyBoSNe9NapKkTYXp8GqbEXUwRw4pFOvGuL+bWN/i5mbQ7e2xKkp1bS2QFcw0bFF
         p4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/c8JqFBoF+Wyv0y7vjPLE9bVpeDasBR2S69E+7r2TtY=;
        b=kpYhleu1J6vaR2DLiDODh28EPpVwHQ5sto0RA2Rp+P/P0TL6AesHy7vwYPk6/Kq5Rf
         rlOGLYWFHX3oHeBPHr6YBsjhgh3WEPGjv4rT9BvoX5AJ6n991FFUhEEJEEpg9bBM+ivO
         6Ch4bsqxWa/qRSskGWwYBQl0gSJMiswTP56xmPg/Yl2SqV+A5OPD4QGSXfoZViGTqVR+
         dz9JmNnbhA0j37ODfDQ0tCOB0Cuvqf7Mjg5581INQqKpvvaAw5kJIkAsI9p+6Uz9MDgP
         0dRW8zc8PD6lZsdnTUcomSwS/s4VfxEkR7YYOJ+m4UkiYH7UGv/80B5kbunCVSJ18DyF
         yCTQ==
X-Gm-Message-State: APjAAAXaSnn/2WOIodCOntkDZbB5dNYRyZ63tnu/6VCmZ68KB2zVZfy3
        evXfLsuMgIQFI0iAZiI97AEuxQ==
X-Google-Smtp-Source: APXvYqyAwd06U5sHJ6RJuXAzdAU4K5P7qW3PVQBSvKIMhVgDvbt0mabo67VXojbyegXmFIr9BORhmw==
X-Received: by 2002:a05:651c:1bb:: with SMTP id c27mr14397156ljn.277.1580736374697;
        Mon, 03 Feb 2020 05:26:14 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id m24sm11753539ljb.81.2020.02.03.05.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 05:26:13 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id A788C100DC8; Mon,  3 Feb 2020 16:26:26 +0300 (+03)
Date:   Mon, 3 Feb 2020 16:26:26 +0300
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
Subject: Re: [PATCH v3 06/12] mm/gup: require FOLL_GET for
 get_user_pages_fast()
Message-ID: <20200203132626.ckkozepykxmqxf6a@box>
References: <20200201034029.4063170-1-jhubbard@nvidia.com>
 <20200201034029.4063170-7-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200201034029.4063170-7-jhubbard@nvidia.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 31, 2020 at 07:40:23PM -0800, John Hubbard wrote:
> Internal to mm/gup.c, require that get_user_pages_fast()
> and __get_user_pages_fast() identify themselves, by setting
> FOLL_GET. This is required in order to be able to make decisions
> based on "FOLL_PIN, or FOLL_GET, or both or neither are set", in
> upcoming patches.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
