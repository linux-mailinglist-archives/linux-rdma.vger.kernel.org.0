Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13054675E2
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2019 22:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfGLUY3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Jul 2019 16:24:29 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33174 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfGLUY3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Jul 2019 16:24:29 -0400
Received: by mail-qk1-f193.google.com with SMTP id r6so7433307qkc.0;
        Fri, 12 Jul 2019 13:24:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5AnwL9QMhOvEkju5sgdju6SDmCAcrRdWohbiNJ53Gz8=;
        b=YjMXGHWIS7wN9mB3TganGrcaA/Km/VKF4Hjvp4iu3CvR+c9eBNgNXobjzlz9JGRRrv
         5uhPSWYQGuoXjIIH4gR8wb0W8/pJ8ZYC2qDNpJjPWEw4ElseOQXmtlyMjFMo9aCuxqb9
         lDuXroZRasdYjNgcLnu0thP4gyMx0IyHnkTxjwdAjWXN4G+wy5//nDGsKJzX4t/JnI7r
         U39rJkLcSsgT6xjIN1cuGFinRwNgzQ/ixiGdnN37B8tIdqmVW0GIWp7AEKzkFFtQjzc/
         fH7p/sUFRVqK360anIpLyQgHwLjQt0NZrJacbpUgNvUVRo3d3U6NOKRqpk+cAwRRmxTR
         yQMA==
X-Gm-Message-State: APjAAAXhzGQOMMrL6NTtClnTD7eJDXCJyT3H3YH65aWCc5Q2NEXZQ0xG
        xN5qZ+HSWCi2eWpu7jgHZ0Q4dXNdHOGLQR86s0yPA2mE
X-Google-Smtp-Source: APXvYqyMaZHfK8W0Y+cZkQ8qPgpqVV/Kl0pC/cAZz3DeuvjrVg4FwV8mCqImWkc0fANtTclL7NvITtJY4Xx3o+0txh4=
X-Received: by 2002:a37:5f45:: with SMTP id t66mr7933814qkb.286.1562963068694;
 Fri, 12 Jul 2019 13:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190712085212.3901785-1-arnd@arndb.de> <OF05C1A780.433E36D1-ON00258435.003381DA-00258435.003F847E@notes.na.collabserv.com>
 <20190712120328.GB27512@ziepe.ca> <OF36428621.B839DE8B-ON00258435.00461748-00258435.0047E413@notes.na.collabserv.com>
 <CAK8P3a3ZqY_qLSN1gw12EvzLS49RAnmG4nT9=N+Qj9XngQd0CA@mail.gmail.com> <20190712151423.GG27512@ziepe.ca>
In-Reply-To: <20190712151423.GG27512@ziepe.ca>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 12 Jul 2019 22:24:11 +0200
Message-ID: <CAK8P3a0=48ULbgBhx97RncS_em+ymEnDZuVbA29+NF2QQ0KU4Q@mail.gmail.com>
Subject: Re: Re: [PATCH] rdma/siw: avoid smp_store_mb() on a u64
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Bernard Metzler <BMT@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 12, 2019 at 5:14 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Fri, Jul 12, 2019 at 03:22:35PM +0200, Arnd Bergmann wrote:
> > On Fri, Jul 12, 2019 at 3:05 PM Bernard Metzler <BMT@zurich.ibm.com> wrote:
>
> Since this is coming up so late in the merge window, I'm inclined to
> take the simple path while Bernard makes a complete solution
> here. What do you think Arnd?

I don't see a problem either way, since it's a new driver, so both
disabling it on 32-bit and applying a fix that might cause something
to break is not going to make it worse for anyone compared to the
linux-5.2 release.

      Arnd
