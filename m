Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 546871637F3
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 01:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgBSAEO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Feb 2020 19:04:14 -0500
Received: from mail-qv1-f50.google.com ([209.85.219.50]:46671 "EHLO
        mail-qv1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgBSAEO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Feb 2020 19:04:14 -0500
Received: by mail-qv1-f50.google.com with SMTP id y2so9996305qvu.13
        for <linux-rdma@vger.kernel.org>; Tue, 18 Feb 2020 16:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XoIOioa/hRbwO8qDwC+h5ZuuDKQ3QdCo5q3X6KMRuHk=;
        b=GN2GB/ByRcZiHGXeHtYtJ2WPgBu1GG/tHvn36oPd6DuotE0HIRqa3pn5I/gmBTO72Y
         fioSKfwcEW8E3PHutwj3S1rUnEFmazVRtZ4LvA+ZHlWZXsQl7cmQSz0AQEczI//nozJP
         eLfZC38IjEQTRpeN1p0bhuOWo0ja9pC37A9Y9eH1yy1QD0QRIABcCSVkTHdGDP/R0jHJ
         Mi5OlcM6PW1Ownr79OxsqhX0fKV8wlQB6fnQsr5pIq1fYwYdH+WTY55BKv3fnBsyQ+hn
         9RqVa2Hh67rLh62Qb5+p3vLuIW7W+RXhCMrGpX9aLHKl5WF/VyClz4m6iSjrHPQ+CHa4
         +XYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XoIOioa/hRbwO8qDwC+h5ZuuDKQ3QdCo5q3X6KMRuHk=;
        b=jUGbsteyp/aSMk4O48ErNfG1KFNl4kmmvgbXGQPDvNkOA2cOVfOZICZfe9tEOJr79+
         v1GMZhPVFSnJitI+2TXtyimO0hEw3lN8cY/gPZdoSKAYtN3nvmPQ9hX5Wf4MPv+RzaS1
         gQrwJd4HEQM59j9VrQvmuKu4D3yXRWRiZ4RHAC5oEM4VRam0PUvPNbGcz/5tz1keJKae
         gVH9G7xHQDNmOkSX6pkT7QiBG9S2gC0aqonxws/6JYF+/epTIlKO1X3yrXbzcHNVEaht
         hyBeo+WSETRZevdFUOQ2as1dMx78OZHPvp3KokbLNL6Vd9/4jGJ+m/cK1gyFQz5iS5pz
         3smw==
X-Gm-Message-State: APjAAAUWdGRio8Cuw0sL4zcU6a6Xx4LUfVbEmZOTAz6VI5LXHyphTZb7
        kolId5Bk9cG+biXQVMKC21JNMQ==
X-Google-Smtp-Source: APXvYqzCSWCHI8Ivob1wyDpLjcwM8T+AQ98UoH7rO/Sj2DWuXoRI57a+pq6g6TJMouRI5/aUTp313g==
X-Received: by 2002:a0c:f98e:: with SMTP id t14mr18666998qvn.74.1582070652790;
        Tue, 18 Feb 2020 16:04:12 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id w60sm56793qte.39.2020.02.18.16.04.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Feb 2020 16:04:12 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j4CqZ-0002gm-QB; Tue, 18 Feb 2020 20:04:11 -0400
Date:   Tue, 18 Feb 2020 20:04:11 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Andrew Boyer <aboyer@pensando.io>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: May we create roce_ud_header_unpack()?
Message-ID: <20200219000411.GJ31668@ziepe.ca>
References: <ABA12A9D-D4F4-405C-BEAA-BDBF33D50488@pensando.io>
 <20200218205817.GI31668@ziepe.ca>
 <86758DBC-E3E6-4E96-B2E0-10ACE4F5228C@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86758DBC-E3E6-4E96-B2E0-10ACE4F5228C@pensando.io>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 18, 2020 at 05:40:09PM -0500, Andrew Boyer wrote:
> 
> 
> > On Feb 18, 2020, at 3:58 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > 
> > On Tue, Feb 18, 2020 at 03:53:45PM -0500, Andrew Boyer wrote:
> >> There is an ib_ud_header_unpack() in core/ud_header.c, but it has no consumers.
> >> 
> >> Would I be allowed to add a roce version alongside it?
> > 
> > Why? Personally I loath these accessors
> > 
> > I have been thinking of dropping all of them in favour of the stuff in
> > include/rdma/iba.h, which has really been a good improvement to the cm
> > 
> >> May I do that now or must it wait until a consumer is ready to be checked in?
> > 
> > New stuff always needs in-tree users.
> > 
> > You can send a patch to delete ib_ud_header_unpack() though
> > 
> > Jason
> 
> OK.
> 
> It was being used for query_ah and query_qp, but I can design that out, no problem.
> 
> Are we still permitted to use ib_ud_header_pack() or should we avoid that too?

You'd be better to just use the IBA macro stuff and add defines for
the new structs you need. The codegen is a lot better than this
pack/unpack

Jason
