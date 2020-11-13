Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD51D2B12F7
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Nov 2020 01:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgKMACH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Nov 2020 19:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgKMACH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Nov 2020 19:02:07 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B359C0613D1
        for <linux-rdma@vger.kernel.org>; Thu, 12 Nov 2020 16:02:07 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id 199so7324963qkg.9
        for <linux-rdma@vger.kernel.org>; Thu, 12 Nov 2020 16:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JpORj5SRIF6kbUi6eMJyhwjTKhIggfnZZH4GCFeLuxU=;
        b=E7lwuiW4jGXC+G/5DJvAta9blQ/xE5ncv/4oNOnhGnOLVWV+XeLXM7XtzX7UdqbnYf
         2GN491Lq/hJE9p3K6qQvM9fTjw+l40xhXOJC7SxFyqOz5iIpTQgc3lGAzbHUgySXKMNy
         E4hXe7NlPvXVuJoOAE+3fxJRjYXQ11hpC7n8DV6r4lSSlh8+5cAugWJnlgSM02u0mbpi
         rR3apAS0TIxp2ewloK84IR4ScFTAGatz3XWHAE6eo02VTrZUflU4bWJAjm4j/cIPt18n
         9bttSomPHhTQCOVEdNw6Pw4WCX2n9sBRh9WJZ1QhZ3aoiRPx4nfArTJQnCXcp54HAm8z
         4Oww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JpORj5SRIF6kbUi6eMJyhwjTKhIggfnZZH4GCFeLuxU=;
        b=WKFBn+VsMpa734B9+WR23TDX/7tLGSi2Icx2NKNddeh4q/npOyaDxPaPJib8pKDp/5
         E2vg2RSEYce6IJmlibAotSXhXEgGQFAdTkptaf9wLlEXNlC1O+OnWAEajM6yWJJP4h8T
         jtdL8h65wIy3ZQCTgRgmJOAB7njBZ6TOGKn4045Ex+nT+Jp62PzVkiCvMQWd5DYwALTu
         jH7HUQXP+zXsqdtBcAQ4x1bhV3/ZU8w938vgZzwFm5VzxAn53p7dLa+X7DtFhu3UXvMr
         KGVIRgrWmJZGKeZHB54Pd6oNd/j9A44G4f3MJoibAR2C7uaEGeCASGhrqf1az/DX0RX0
         dw4Q==
X-Gm-Message-State: AOAM532dm3h609OnvrFD6IPLnbIg5wMy0qgsty1cktZYMiLLc3d7h6CJ
        Axshq6D4UR+obNdafdnuizCw8w==
X-Google-Smtp-Source: ABdhPJyfszv1c2zCo3KbwW6r9etDRhTimKjTtnJy/p2IorUmc5Zz9O1VugG6KcMkJKl1DGWDkClkcA==
X-Received: by 2002:a37:5088:: with SMTP id e130mr2462816qkb.34.1605225726390;
        Thu, 12 Nov 2020 16:02:06 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id z6sm5393509qti.88.2020.11.12.16.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 16:02:05 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kdMXV-004Bqk-8p; Thu, 12 Nov 2020 20:02:05 -0400
Date:   Thu, 12 Nov 2020 20:02:05 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, dledford@redhat.com,
        Jann Horn <jannh@google.com>, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-mm@kvack.org
Subject: Re: [PATCH for-rc v2] IB/hfi1: Move cached value of mm into handler
Message-ID: <20201113000205.GX244516@ziepe.ca>
References: <20201112025837.24440.6767.stgit@awfm-01.aw.intel.com>
 <20201112171439.GT3976735@iweiny-DESK2.sc.intel.com>
 <b45c2303-a78e-a3b6-fcd2-371886caf788@cornelisnetworks.com>
 <ba7df075-ab50-3344-aacb-656ae10b517a@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba7df075-ab50-3344-aacb-656ae10b517a@cornelisnetworks.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 12, 2020 at 05:08:22PM -0500, Dennis Dalessandro wrote:
> On 11/12/2020 5:06 PM, Dennis Dalessandro wrote:
> > On 11/12/2020 12:14 PM, Ira Weiny wrote:
> > > On Wed, Nov 11, 2020 at 09:58:37PM -0500, Dennis Dalessandro wrote:
> > > > Two earlier bug fixes have created a security problem in the hfi1
> > > > driver. One fix aimed to solve an issue where current->mm was not valid
> > > > when closing the hfi1 cdev. It attempted to do this by saving a cached
> > > > value of the current->mm pointer at file open time. This is a problem if
> > > > another process with access to the FD calls in via write() or ioctl() to
> > > > pin pages via the hfi driver. The other fix tried to solve a use after
> > > > free by taking a reference on the mm. This was just wrong because its
> > > > possible for a race condition between one process with an mm that opened
> > > > the cdev if it was accessing via an IOCTL, and another process
> > > > attempting to close the cdev with a different current->mm.
> > > 
> > > Again I'm still not seeing the race here.  It is entirely possible
> > > that the fix
> > > I was trying to do way back was mistaken too...  ;-)  I would just
> > > delete the
> > > last 2 sentences...  and/or reference the commit of those fixes and help
> > > explain this more.
> > 
> > I was attempting to refer to [1], the email that started all of this.
> 
> That link should be:
> [1] https://marc.info/?l=linux-rdma&m=159891753806720&w=2

And consistently use lore.kernel.org links please :\

Jason
