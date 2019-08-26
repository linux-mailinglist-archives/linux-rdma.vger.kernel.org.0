Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4029CF71
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2019 14:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731850AbfHZMU6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Aug 2019 08:20:58 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45187 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730287AbfHZMU6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Aug 2019 08:20:58 -0400
Received: by mail-qt1-f194.google.com with SMTP id k13so17541250qtm.12
        for <linux-rdma@vger.kernel.org>; Mon, 26 Aug 2019 05:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IInbJuct5ufzKNiytsnk+jMIYv1V6eVTEaTj38ohm3M=;
        b=fnMzsCTram2mN7X12asMshdyTXllFMcSBIdA21KFh1RFEex2/5FeKlO+9rtE32Hfem
         jNFRntwunRTt9MR1Ovw/7sG8gRUDu02VVxJVeHApVsYUYSL3ColhOVAIONzU/OwgzIsI
         Cf+dbVDkOq6orHb9v/8o9ozQW9LemkmRD/qs4cgkUG9GO8bMKSsQ5fVmxRZ8QKmTd/UN
         cMzUj24siEC0zPzjoKcmIhXTIs2pUPmj3ydsCJXBTyle1aaPAglspzS3pqQgQ9jGMdgs
         V8/0FEQAaqOhMwcD4fjLClL9PYtQeZh0epvkMiiCdtfvZJMAYEZM7IJ41fzr+ZyQcPqf
         fuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IInbJuct5ufzKNiytsnk+jMIYv1V6eVTEaTj38ohm3M=;
        b=Nfk6wZ9aM6HJNQZ6IGw6/MD4RIvwPUSSOGgjxmQB57VVZPz4bRXHYZVSAS9GFU0Wro
         dqTKf6qwAWz2HSojbBiVC/+ulCyDeUvIaSG4G328eOfPc2sySl/WeOYbzj3z8yW0munH
         fEq6xcl4Auj+nVN+hHQfsvJNLaKMDUs2yKW1A+Y3ycbR7WaM8Xxp+cts1tKU5PR2FtQo
         3UO0LoPHwhUBdP/lI+OuTEUr4RLr6LOZcEjeAigyk0jsIixOECgBWXBElzdwvZ6AKRAw
         4hTkgK/TLIee10+qAodWdPb3XSHkYEbH9qE8FG8EFsiGRRxVbM3Of+g3A8HmyhPjGyjZ
         8/bw==
X-Gm-Message-State: APjAAAWhRkpTYU2YCgF7lh5XxzCYG6wniKYLs5mVWlgfIRb3d+fh8/2Q
        8JhFxNbQlpNQ5JkICrMQDYAGLg==
X-Google-Smtp-Source: APXvYqz+8moKXNMjENzuAiUz9yUTyRo1T98w+98Tx3SfRXc69ey23f/HpA4QXKYMoXk3ry4w8yOQ3g==
X-Received: by 2002:ac8:73c7:: with SMTP id v7mr14706237qtp.9.1566822056913;
        Mon, 26 Aug 2019 05:20:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-216-168.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.216.168])
        by smtp.gmail.com with ESMTPSA id q6sm6213402qke.109.2019.08.26.05.20.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Aug 2019 05:20:56 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i2DzT-0007A1-Sv; Mon, 26 Aug 2019 09:20:55 -0300
Date:   Mon, 26 Aug 2019 09:20:55 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     leon@kernel.org, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] IB/mlx5: Convert to use vm_map_pages_zero()
Message-ID: <20190826122055.GA27349@ziepe.ca>
References: <1566713247-23873-1-git-send-email-jrdr.linux@gmail.com>
 <20190825194354.GC21239@ziepe.ca>
 <CAFqt6za5uUSKLMn0E25M1tYG853tpdE-kcoUYHdmby5s4d0JKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6za5uUSKLMn0E25M1tYG853tpdE-kcoUYHdmby5s4d0JKg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 26, 2019 at 01:32:09AM +0530, Souptick Joarder wrote:
> On Mon, Aug 26, 2019 at 1:13 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Sun, Aug 25, 2019 at 11:37:27AM +0530, Souptick Joarder wrote:
> > > First, length passed to mmap is checked explicitly against
> > > PAGE_SIZE.
> > >
> > > Second, if vma->vm_pgoff is passed as non zero, it would return
> > > error. It appears like driver is expecting vma->vm_pgoff to
> > > be passed as 0 always.
> >
> > ? pg_off is not zero
> 
> Sorry, I mean, driver has a check against non zero to return error -EOPNOTSUPP
> which means in true scenario driver is expecting vma->vm_pgoff should be passed
> as 0.

get_index is masking vm_pgoff, it is not 0

Jason
