Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFB91ADD4B
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2020 14:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbgDQMZp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Apr 2020 08:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728943AbgDQMZp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 17 Apr 2020 08:25:45 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF4EC061A0C
        for <linux-rdma@vger.kernel.org>; Fri, 17 Apr 2020 05:25:45 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id s18so756753qvn.1
        for <linux-rdma@vger.kernel.org>; Fri, 17 Apr 2020 05:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b3iFtRhJs5VqWIfspmC5p02IfQnZ1OBoJDiilSZitow=;
        b=Z9Ljm0d8QguBsl++bS9kVtdhIXM4iGBa3wZPoDF+/p5QDbbf+Ecx1WOeV/KWVqEAXj
         ABy5J6+w2bDlgPY3w06H5Xmi/cS0kRvv5T8Ra6TZWtYIBGQu5I4Rx4AHl3+T2gROjJUI
         0J0m16+FNgCJ90BwzGrj3pRV6Zus7SXB4Rjqp3UWJLn4YHfKIy4u4rXgTAeGs3KE6EUt
         wQD9z1iG0OEn/tMOLZCt4+Kkayd7XfuvCsNuXdb4ntlg7V35JxLrywkpo+GJvWBjweCZ
         Ep0gCRUjFRU+1N/O3lHk6ytDkXA+SH1mGrPuTDCuKZHiafjG1shCNAuJ0aW6sHAig3B0
         xd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b3iFtRhJs5VqWIfspmC5p02IfQnZ1OBoJDiilSZitow=;
        b=tC7x+9qP+P/cxJMyylCKG1lel05QxjROcnGZPzuM8MqgqO1T2oK1FbAT5Zb6KIKKbL
         ORZ/GOb373Gtj3D+nt49Ddl2bTN1uR9k2NsYwJF5IZslgk7J6MO0p3C4gJSp8m4cAtHQ
         v98apRQbpcfe9VU30U1G4455afRUQbf7Po045SqCK7JpKHAhgeWxv2jzVU9khJTFA5eR
         +lpbez9th5AbZlYCTZtvH2PM13ZAtyShc9sktsmO6duFEy+14Ev0p3F6Brqfd6SgQccV
         NLggnUlUAWiesp73Ey0JYx06hya82879p/HoSwsgOIZyEtHTCTBpt64Ie1YGSQV/Ow+N
         HWwA==
X-Gm-Message-State: AGi0PuY1S9s0kyrKxzztDUhHFrwk4c3iSMiREk3fl9x3eqxWv57dZRQk
        Fr+/QcCxMPtg6d9O+WcrTNZWbQ==
X-Google-Smtp-Source: APiQypKRejHQkO6SPjqQHCzSrXkoqY5ngsJkDP3GjBxzcNqfAerdMXzQrgdeW6YJO40tzYBCUCmAeQ==
X-Received: by 2002:ad4:4c4d:: with SMTP id cs13mr2347165qvb.207.1587126344506;
        Fri, 17 Apr 2020 05:25:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id k2sm17252465qte.16.2020.04.17.05.25.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Apr 2020 05:25:43 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jPQ3y-0006eb-6h; Fri, 17 Apr 2020 09:25:42 -0300
Date:   Fri, 17 Apr 2020 09:25:42 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Carpenter <dan.carpenter@oracle.com>, g@ziepe.ca
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        selvin.xavier@broadcom.com, devesh.sharma@broadcom.com,
        dledford@redhat.com, leon@kernel.org, colin.king@canonical.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/ocrdma: Fix an off-by-one issue in 'ocrdma_add_stat'
Message-ID: <20200417122542.GC5100@ziepe.ca>
References: <20200328073040.24429-1-christophe.jaillet@wanadoo.fr>
 <20200414183441.GA28870@ziepe.ca>
 <20200416130847.GP1163@kadam>
 <20200416184754.GZ5100@ziepe.ca>
 <20200417112624.GS1163@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417112624.GS1163@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 17, 2020 at 02:26:24PM +0300, Dan Carpenter wrote:
> On Thu, Apr 16, 2020 at 03:47:54PM -0300, Jason Gunthorpe wrote:
> > On Thu, Apr 16, 2020 at 04:08:47PM +0300, Dan Carpenter wrote:
> > > On Tue, Apr 14, 2020 at 03:34:41PM -0300, Jason Gunthorpe wrote:
> > > > The memcpy is still kind of silly right? What about this:
> > > > 
> > > > static int ocrdma_add_stat(char *start, char *pcur, char *name, u64 count)
> > > > {
> > > > 	size_t len = (start + OCRDMA_MAX_DBGFS_MEM) - pcur;
> > > > 	int cpy_len;
> > > > 
> > > > 	cpy_len = snprintf(pcur, len, "%s: %llu\n", name, count);
> > > > 	if (cpy_len >= len || cpy_len < 0) {
> > > 
> > > The kernel version of snprintf() doesn't and will never return
> > > negatives.  It would cause a huge security headache if it started
> > > returning negatives.
> > 
> > Begs the question why it returns an int then :)
> 
> People should use "int" as their default type.  "int i;".  It means
> "This is a normal number.  Nothing special about it.  It's not too high.
> It's not defined by hardware requirements."  Other types call attention
> to themselves, but int is the humble datatype.

No, I strongly disagree with this, it is one of my pet peeves to see
'int' being used for data which is known to be only ever be positive
just to save typing 'unsigned'.

Not only is it confusing, but allowing signed values has caused tricky
security bugs, unfortuntely.

Jason
