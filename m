Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693272FA902
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jan 2021 19:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406465AbhARSj2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 13:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436769AbhARS3h (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jan 2021 13:29:37 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586D9C061573
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 10:28:56 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id w79so19518362qkb.5
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 10:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V6OfwHc1CUnuze+sIKYDwiSSMcP1Mnt94yrNdzONXMc=;
        b=I70gxMCGa6VXFTdCUVqIrxDoriChErMWEhWVmnDCztvFEV9K/n3ElBkgmgrtpg1BjL
         JCXkgxdsL9K9xEv/0cEKuSXqiuiK5Zk061N68H4RaQ/56J+SpmBKSe2uRjtgWjwu3Ec2
         NX5qA1+NkpWXw70tjWcvipfP7S9DA4dn6/H9GgFqdazctTtrzJX/fPCeqUHTo0gTwJrl
         82xJGfkL9mF0QqRezQdtrPfNLCQiTjrXcwyRcZ80pnlFank7cK6kcJoxYmfKzIbst7lK
         bXFmYGu0MlcKlzYwaIe7d3MvE0MsWb4ucMN22I1k2+G6PbJMn+J79JLr8bQ/Z26005lm
         dhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V6OfwHc1CUnuze+sIKYDwiSSMcP1Mnt94yrNdzONXMc=;
        b=cx/AvOYRDdGImPs4VGngHO2YM81o3auF+H67vgYXHZwI1G9Nj/bKJL681zwWULKCFJ
         EDA2gZCdrsQATiYisgx5WGtWzgpslaVMVvnwKu7ryTgtQ9VnTnP0hvRUI4gqvK2IobZh
         XF/kjOuUn08EiZ5sVngbQfZy4Rw7daFJ7PLpC2cp5aCTJEJ3adU4bBRA+LNpeJSEDgDP
         LE1x5jb7XJqN3AMEpactmLhBBY1xqoEK/7/hjA4BkE6Ma2WYDZOVzP7snGbcN/mAQa4E
         4DvhnJf64l7flsrU8B+h7ec1VxhEBiMQPDGTbibRNHTeTP4npnmeo3VTPHSpvyORHHBp
         2e4w==
X-Gm-Message-State: AOAM532YLMmwxbylqBSZ2BMcRR83pzmqD3aF2igehexggUXtYRJdn9y5
        KSTLpxphEsifvibyvxsNlK8gVPxVyTUp0Q==
X-Google-Smtp-Source: ABdhPJyoVuq3nY/icnfkE0mrabkzzFBuuTfwE9NxFbO6a8QayKjQV5IZB1bxXI2yG/S0i+cPYI2Vfw==
X-Received: by 2002:a37:6846:: with SMTP id d67mr840329qkc.219.1610994535549;
        Mon, 18 Jan 2021 10:28:55 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id u5sm11368459qka.86.2021.01.18.10.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 10:28:54 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l1ZGo-0031bp-7D; Mon, 18 Jan 2021 14:28:54 -0400
Date:   Mon, 18 Jan 2021 14:28:54 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Douglas Gilbert <dgilbert@interlog.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        target-devel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        jejb@linux.vnet.ibm.com, bostroesser@gmail.com, ddiss@suse.de,
        bvanassche@acm.org
Subject: Re: [PATCH v6 1/4] sgl_alloc_order: remove 4 GiB limit, sgl_free()
 warning
Message-ID: <20210118182854.GJ4605@ziepe.ca>
References: <20210118163006.61659-1-dgilbert@interlog.com>
 <20210118163006.61659-2-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118163006.61659-2-dgilbert@interlog.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 18, 2021 at 11:30:03AM -0500, Douglas Gilbert wrote:

> After several flawed attempts to detect overflow, take the fastest
> route by stating as a pre-condition that the 'order' function argument
> cannot exceed 16 (2^16 * 4k = 256 MiB).

That doesn't help, the point of the overflow check is similar to
overflow checks in kcalloc: to prevent the routine from allocating
less memory than the caller might assume.

For instance ipr_store_update_fw() uses request_firmware() (which is
controlled by userspace) to drive the length argument to
sgl_alloc_order(). If userpace gives too large a value this will
corrupt kernel memory.

So this math:

  	nent = round_up(length, PAGE_SIZE << order) >> (PAGE_SHIFT + order);

Needs to be checked, add a precondition to order does not help. I
already proposed a straightforward algorithm you can use.

Jason
