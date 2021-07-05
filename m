Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7E93BC1BF
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jul 2021 18:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhGEQnM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Jul 2021 12:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhGEQnM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 5 Jul 2021 12:43:12 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F781C061574
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jul 2021 09:40:35 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id v10so12599518qto.1
        for <linux-rdma@vger.kernel.org>; Mon, 05 Jul 2021 09:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v8W5OCvh0R5EqmZsg4dv+m2qyL7opMLwoZzcmRvAyaM=;
        b=CNdk6C4fzSlUOzIbgorZGHO3D2zkg0c7BfSp7EA/k7ImR47m6pyjhcwNKh5RxMED8J
         a9gx3boDmWqr+7eWAt1Ngwve1OXPjnqR2L5QvEM3Be7ts49Nc7yFpHIatPi5c3waPLY0
         kwn7uGEW0Hcftol0buI1X66GwF6yZ/3swB+gzAGjo1az7WCfeHweMX5AwJkS/AKA3/kq
         mIAT9wz+58NyVvFb1zsNompDz7VHjoAdBbDjnpaiy8dT3q6Y+Kj3na2ZS/GV4OFwZ5lo
         Tl3mwgiLbFBOwBAb1cuKf28ww+bM6CxchKhki8dfTDWW2Q5QW5OSRJ81bYBj0NVkzgq+
         4kAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v8W5OCvh0R5EqmZsg4dv+m2qyL7opMLwoZzcmRvAyaM=;
        b=YZYajraQwqgb2C2h3wcO8DePy5/d2MG+PPsojIsjXsxNlSeLfIpBUgXFpbknS/uGG1
         bN8SUNLNCCF2CSI4YAOzrfI8d48Cf5MMvgRyH/SP1x8rDExfyLS0YQDlkzePmW99bjUJ
         D0IjyyFzGB+ocgQRu+aUVpg9kBZfuCHAJclzyHQFO55m0o+l5cg3+pL5izBeaebGnlh8
         qaD92Za1+jr7ptjS2Z9m3ilnm9VFNqbBTHVxzaFv2V8DhjWcvLt2MGiNaCd06oR5thnf
         SYs3ytyCT5ODHPaTOs9CyE3Aae4w8mAJRBaG+4bsll/PZeVaWCRzCEhGuAQ8T9sRXDtk
         3B1w==
X-Gm-Message-State: AOAM533S+SHcEJ/uX3x7MkOhHEHss211M3pMsFun8LtrSnIyMG6gnuHZ
        9o4BResFFQ5+gpjbw1Ss12YxNQ==
X-Google-Smtp-Source: ABdhPJxLVpMQIgf8JTQJv0s8ycAGIrtK4aOgzbONIKppGLph8rOItcmqdlsbG2VdGdmoqMiBZKYsNg==
X-Received: by 2002:ac8:5452:: with SMTP id d18mr2718765qtq.72.1625503234095;
        Mon, 05 Jul 2021 09:40:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id p187sm5539712qkd.57.2021.07.05.09.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 09:40:33 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1m0Re5-003rx4-4c; Mon, 05 Jul 2021 13:40:33 -0300
Date:   Mon, 5 Jul 2021 13:40:33 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc or next 0/2] Two small fixups
Message-ID: <20210705164033.GI4604@ziepe.ca>
References: <20210701154318.93459.18982.stgit@awfm-01.cornelisnetworks.com>
 <41f90b65-8f76-9559-8ea9-54e7a22f5627@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41f90b65-8f76-9559-8ea9-54e7a22f5627@cornelisnetworks.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 01, 2021 at 11:50:51AM -0400, Dennis Dalessandro wrote:
> On 7/1/21 11:46 AM, Dennis Dalessandro wrote:
> > Hi Jason,
> >
> > These two small patches aren't realy fixing serious bugs. Maybe you want to
> > wait for 5.15 content, but they are small and have fixes lines. Maybe OK
> > for the RC, so wanted to get them out.
> >
> >
> > Mike Marciniszyn (2):
> >       IB/hfi1: Indicate DMA wait when txq is queued for wakeup
> >       IB/hfi1: Adjust pkey entry in index 0
> >
> >
> >  drivers/infiniband/hw/hfi1/init.c     |    7 +------
> >  drivers/infiniband/hw/hfi1/ipoib_tx.c |    3 +++
> >  2 files changed, 4 insertions(+), 6 deletions(-)
> >
> ^^^^^^^^^^^^^^^^^^^^ No clue how that got added. Looking into that right now.
> 

Oh yes, and it corrupted the diffs along the way too.

Using index info to reconstruct a base tree...
error: patch failed: drivers/infiniband/hw/hfi1/ipoib_tx.c:644
error: drivers/infiniband/hw/hfi1/ipoib_tx.c: patch does not apply
error: Did you hand edit your patch?
It does not apply to blobs recorded in its index.

Discourage your IT department from mangling outgoing emails... Looks
like your site is using O365 - you may want to bypass your on prem
SMTP and submit directly to smtp.office365.com:587

This may help:

https://github.com/jgunthorpe/cloud_mdir_sync

Particularly the "outbound mail through smtp" section

Jason
