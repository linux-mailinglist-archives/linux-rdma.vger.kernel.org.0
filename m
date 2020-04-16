Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73AA71AD067
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2020 21:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgDPTeM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Apr 2020 15:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725894AbgDPTeL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Apr 2020 15:34:11 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEFEC061A0C
        for <linux-rdma@vger.kernel.org>; Thu, 16 Apr 2020 12:34:10 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id f13so17356910qti.5
        for <linux-rdma@vger.kernel.org>; Thu, 16 Apr 2020 12:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3bdfmLSGDBDiQGqrSZoq13wA4pyt1/GANxHaalzYyRA=;
        b=BF6Q5YiCB/KwYoP4ltCmnyMRaty/XCpafM7y4GSCKHposRRY066ln/pMQdTeZnd7K0
         qJflBGNj4ycdMKIYJGi0PyjuG5djAqU4Opvz42rwKkscoskeH5vrkA7lbPqHH49YbxEC
         FflMq6LF4uJ75KrW1WZI/GU1QeQWnLUeq79yVPRKgOgrYh/clk9lPfXWJJTfVaPqJt3e
         v2B6/aaDIrMcdjqTzr2XLqcVAS4K9dbIRbi8Bi+3txy/ZYJ1S8AFCDWTEg6vlyE8UaIo
         2zqbA1IMAW7+VINDa1Lwew9ecghTg65wEj7k6r5WQ3cNEeA6BTc5e+NbJ1BQa40VRCxZ
         7jvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3bdfmLSGDBDiQGqrSZoq13wA4pyt1/GANxHaalzYyRA=;
        b=sKlt/V+zX5e2r+tdbyir2cd9lrcBMyvJZzhnVvDjN/+jyIgD6FfzTXtR2uM2XK7EmR
         kp0IltepsR/MxX8SNRXz8g+2OR+2pcbK2+2l8+aC3aVLgofvN8WjmdTFi+dOKV95/BfV
         9ZddfGUWikrCTeNLCbLU2uvFaEYz3UikYN/0UYDokSl9HQ7eO6g38Jr2rNgB2SDVQIre
         vu+3jSt61DbGEv8uZOzWlrh7FgV2Eoal9gLS8ofiVq2JTWfeBBo2u6w0YipzcA9NHHv2
         cGawvWW7vCsn4kFdQMV6Puxs9AnpE7A+MIXyee5b7f7Bib5HumXjPTH8ScuWqDUHtuBD
         OxdA==
X-Gm-Message-State: AGi0PuYZ8QZWa5QWfajUcbHsvAoby953wqVKHfE4ycp2Sammi0bdSZxr
        +eEyqyAuMjKGMVyYcC9vtuge3g==
X-Google-Smtp-Source: APiQypJrBj0f4So+zI4nlqamLDD1r/iDmqZRVzo1SO2coTne2pEUcJVgxYd7ywwWl/9HNzV+G68zJg==
X-Received: by 2002:ac8:7102:: with SMTP id z2mr27611503qto.278.1587065649829;
        Thu, 16 Apr 2020 12:34:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id q32sm9270490qta.13.2020.04.16.12.34.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Apr 2020 12:34:09 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jPAH2-0007n6-IV; Thu, 16 Apr 2020 16:34:08 -0300
Date:   Thu, 16 Apr 2020 16:34:08 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Xiong, Jianxin" <jianxin.xiong@intel.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [RFC PATCH 0/3] RDMA: Add dma-buf support
Message-ID: <20200416193408.GB5100@ziepe.ca>
References: <1587056973-101760-1-git-send-email-jianxin.xiong@intel.com>
 <20200416175454.GT5100@ziepe.ca>
 <MW3PR11MB45554BB257360F7CDD96175EE5D80@MW3PR11MB4555.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW3PR11MB45554BB257360F7CDD96175EE5D80@MW3PR11MB4555.namprd11.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 16, 2020 at 07:08:15PM +0000, Xiong, Jianxin wrote:
> > > This patch set adds dma-buf importer role to the RDMA driver and thus
> > > provides a non-proprietary approach for supporting RDMA to/from
> > > buffers allocated from device local memory (e.g. GPU VRAM).
> > 
> > How exactly does this allow access to GPU VRAM?
> > 
> > dma_buf_attach() cannot return non-struct page memory in the sgt,
> > and I'm not sure the API has enough information to do use the
> > p2pdma stuff to even establish a p2p mapping.
> > 
> > We've already been over this in another thread.. There is a way to
> > improve things to get there, but I don't understand how this patch
> > series is claming to be able to work with VRAM - if it is that
> > means there is a bug in a GPU driver that should be squashed.
> > 
> 
> Right, the GPU driver needs to cooperate to get the thing to work as
> expected. The "p2p" flag and related GPU driver changes proposed in
> other threads would ensure VRAM is really used.  Alternatively, a
> GPU driver can have a working mode that assumes p2p mapping
> capability of the client. Either way, the patches to the RDMA driver
> would be mostly identical except for adding the use of the "p2p"
> flag.

I think the other thread has explained this would not be "mostly
identical" but here is significant work to rip out the scatter list
from the umem.

So, I'm back to my original ask, can you justify adding this if it
cannot do VRAM? What is the use case?

Jason
