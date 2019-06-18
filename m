Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E534F4AA7B
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2019 20:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730435AbfFRS57 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jun 2019 14:57:59 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34457 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730434AbfFRS57 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Jun 2019 14:57:59 -0400
Received: by mail-qt1-f193.google.com with SMTP id m29so16759976qtu.1
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jun 2019 11:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PttUnfJR2Mh5w8ZNX8UBClI5Uo9DGdQHvLC9b9+U4Hc=;
        b=PXeS3vrprzJCfOdHHqzsyJuksx6Jm56D2ltYr60kDgSXAubt62volsRxeiJYH3eQEA
         qkIDep9gBltu/VFi4HJjTckykz/IF/uFm7scvosf85B+lHsbj0dpRu3aDtM8neaO1TM8
         jn75MRkzxtq6VT6WxVud/XCv4fiC/Hs/QuY23+nW+QuinJo8UTrJFA4I2rX38F3Pxeiw
         eP9rL5iIlAFSNbpVdB19/9eqmpnvMNQsySfc/gSbru2YJ1r1laZ6myv5v4YTCDELSwVm
         yt0NAobLw0i6IyHq1SKxS6BjkonU3m5GhldixnjUWA6n0jM3Ie3wseLt5i4fZPceHLH1
         /ZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PttUnfJR2Mh5w8ZNX8UBClI5Uo9DGdQHvLC9b9+U4Hc=;
        b=Gcs5tphUHYkARGzEI3qgu+el/gCn8XyNBeoVXIeZ3vEO+/DjkL1aO5eUs6mFFRPi96
         QnJTQLLkbkVTYI8siMkurEGP5MX30I+S3ZAj5EAud4CRG+tTkC9kF10aHRhbYex2w3sK
         DnD/PXM31xpWdyrsTwo2zJEiiuTnmTStAzujxKYQNr2Nu02m5+68ia76zbZ89/oVlZhA
         2VZH/nk4phHrogfclERKhJ6rOx1Y4RN81WShlVMSu7XMyPCQv1RJCwMLHBz/cLEIj06A
         lxQy9PhqTBk77lFfQKQn/v6QrEyLBldaPaRG511t8DcbKJ5pbuc4aB399rFD9la3Fdx5
         i6qQ==
X-Gm-Message-State: APjAAAU3DxjMJKNhJ15ecfbEXWOxFgrSJzoFNWa9BrBp5b8bR4r7s+JC
        eVBbBwHrcsZqbKpidjpd4AO6rA==
X-Google-Smtp-Source: APXvYqwnCmKjPrstr3X9a/omza5K8iCghkX9+cWplH9fTwptdxDxjvrYmzpam1j8Twpi6fT6wctRWw==
X-Received: by 2002:aed:21f0:: with SMTP id m45mr87408989qtc.391.1560884277919;
        Tue, 18 Jun 2019 11:57:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id m44sm11840255qtm.54.2019.06.18.11.57.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 11:57:57 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hdJIr-0000A8-2v; Tue, 18 Jun 2019 15:57:57 -0300
Date:   Tue, 18 Jun 2019 15:57:57 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>,
        Philip Yang <Philip.Yang@amd.com>
Subject: Re: [PATCH v3 hmm 08/12] mm/hmm: Remove racy protection against
 double-unregistration
Message-ID: <20190618185757.GP6961@ziepe.ca>
References: <20190614004450.20252-1-jgg@ziepe.ca>
 <20190614004450.20252-9-jgg@ziepe.ca>
 <20190615141612.GH17724@infradead.org>
 <20190618131324.GF6961@ziepe.ca>
 <20190618132722.GA1633@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618132722.GA1633@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 18, 2019 at 06:27:22AM -0700, Christoph Hellwig wrote:
> On Tue, Jun 18, 2019 at 10:13:24AM -0300, Jason Gunthorpe wrote:
> > > I don't even think we even need to bother with the POISON, normal list
> > > debugging will already catch a double unregistration anyway.
> > 
> > mirror->hmm isn't a list so list debugging won't help.
> > 
> > My concern when I wrote this was that one of the in flight patches I
> > can't see might be depending on this double-unregister-is-safe
> > behavior, so I wanted them to crash reliably.
> > 
> > It is a really overly conservative thing to do..
> 
> mirror->list is a list, and if we do a list_del on it during the
> second unregistration it will trip up on the list poisoning.

With the previous loose coupling of the mirror and the range some code
might rance to try to create a range without a mirror, which will now
reliably crash with the poison.

It isn't so much the double unregister that worries me, but racing
unregister with range functions.

Jason
