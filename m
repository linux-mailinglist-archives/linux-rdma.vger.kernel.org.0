Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF3270818
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2019 20:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731164AbfGVSDW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jul 2019 14:03:22 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:35255 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731022AbfGVSDV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jul 2019 14:03:21 -0400
Received: by mail-vk1-f196.google.com with SMTP id m17so8080087vkl.2
        for <linux-rdma@vger.kernel.org>; Mon, 22 Jul 2019 11:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PtVsp5R4X3Cifs8oN1ZbP8YBmEIQmGYZPPCIn5eJUBs=;
        b=o4iJARTZECPNsKjjdvIeY8N25C78qD3q8Y2i2b9ikHVpd+96GNPyRYFAgNS23LwRGm
         cM1tc8LCa4mA0xrhZaC2tUMgUVUmXWJg/htmQuBIt7/T+ksvjMDjUGX4IM3CDuW//QMF
         CIsowAOOq8f9Esb4dhD6bOYPRsAfb8vEsRFZYxwNABP6oHposIGxWfs1HbT/V7iLzXh6
         DGUQoMMbwuGx+/6VfR0xlp3TqMKcZF0WxAwhzXIxm6SjviO/hgZj7bPc5cWKAqS3PKZc
         2tL7tkQvqwrwv+bo/168osxFOZ+/j78tbX8gRXnZeJ7TAZVqCSAW9p8c7OHZcFHA/ysC
         cQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PtVsp5R4X3Cifs8oN1ZbP8YBmEIQmGYZPPCIn5eJUBs=;
        b=mOqj0HMDB4PnkXWxPCeMMFqG1LQnXVpy1poB/Rbt374we/P/t5BcJHRPp4FJmttQjO
         FHJjIz6d7Fh/3j5UkrIGCulg7SFI0uypK5w9zqmI1OXkfLuXyYDXiH74c0qIITnXpj/7
         rNc+gxHvu81J9XAlGd9yWuOWvoYlB1TuJtjtMvKmpa0UFlP98E2UR/FActiJybjs8ttu
         Ep4U2vWyBODO5oHyjtQf6xBgh3qheR/fLbXP3J4UI3PSnmBKcQeGOv3UrfA23mbR9onV
         2Lf2LJ2xU3nE2952uK1XmpUglrTHRDv+z1cVg2fjILBOI7NgxLOtmBuIwpkAgOWGglhs
         cl2w==
X-Gm-Message-State: APjAAAWZdlX6UupoK7RBdAN/u4KWwozsoOrf3VD7uPMU1GFNZAF+bGwz
        l9WHIBghIPoxfvlNMdIczvmIEg==
X-Google-Smtp-Source: APXvYqxCSFEBqIlkFHFBXEWyDgRgyQuKpQf6WKCwCAo2wbL1je4NcR/T/ts+A5cZTBKA54NPiUYePg==
X-Received: by 2002:a1f:acc5:: with SMTP id v188mr26410355vke.16.1563818600640;
        Mon, 22 Jul 2019 11:03:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id w187sm11046574vkb.4.2019.07.22.11.03.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jul 2019 11:03:19 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hpced-0006sd-2W; Mon, 22 Jul 2019 15:03:19 -0300
Date:   Mon, 22 Jul 2019 15:03:19 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 0/6] More 5.3 patches
Message-ID: <20190722180319.GA13959@ziepe.ca>
References: <20190715164423.74174.4994.stgit@awfm-01.aw.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715164423.74174.4994.stgit@awfm-01.aw.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 15, 2019 at 12:45:14PM -0400, Mike Marciniszyn wrote:
> The following series contains fixes and a cleanup.
> 
> I noticed that 5.3 rc1 hasn't happened yet? So I'm not quite sure of
> the destination here.
> 
> 5 of the patches are stable, and should be held for the rc or pulled for 5.3.
> 
> Deleting the unused define can wait if necessary.
> 
> 
> John Fleck (1):
>       IB/hfi1: Check for error on call to alloc_rsm_map_table
> 
> Kaike Wan (4):
>       IB/hfi1: Unreserve a flushed OPFN request
>       IB/hfi1: Field not zero-ed when allocating TID flow memory
>       IB/hfi1: Drop all TID RDMA READ RESP packets after r_next_psn

These four look OK for -rc, applied

>       IB/hfi1: Do not update hcrc for a KDETH packet during fault injection

This looks like it is just debugging fixing, it can go to -next

So all 6 applied

Thanks,
Jason
