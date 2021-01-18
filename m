Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D542FAB69
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jan 2021 21:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394210AbhARU00 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 15:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437911AbhARUZO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jan 2021 15:25:14 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F289C061757
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 12:24:33 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id p14so19877708qke.6
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jan 2021 12:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fMGAcyIUDonqC5vZX69em4dMaV0h+aNyMhhqjLVgSNo=;
        b=X30e563Uk9Cma5YsX+T0s86EdcxvWZwgWtXA/TZZOF1Jd5jusebodDLu6075LgiI0j
         kOC62o8jQ3Zp2PAVFQjlANcfZL50+khhiGW2aI03D6Nf/7SAJm54aH0AXQ/X6FcScWDk
         g3s9YJa7RIs+cWeibt9s7OK05D7xN9d9QM7WEhW9nEPeYdMlR+KMrxKCLWM+zD69aL6d
         SHVjlWo8U3xyPJu95ZFHVQ1PUawj/szSOji3jeRN9YmZ4zGEe1WAxupTcFtLtie9OJ47
         ASdmoeVRDNULjbmtRJdDyc3pWJRh3ZF+2H3bJA5m9S/4RgKCuS27o2WM65Igz/9p/i/f
         r/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fMGAcyIUDonqC5vZX69em4dMaV0h+aNyMhhqjLVgSNo=;
        b=TECQDjUqiwvH2dQM1YXPze41VMVOvp3wiRvXWWHdD4n763HXXYEPCzs08nMW0H20DU
         GuZtsF8R5qY7a+o/7i/pWsOtMEXOL/7sgkGKkml5pcv1+fnQucLStn3j3i3EG7HuGC2Y
         pUoqml7NRtzX5RcD8ldFuIaGsgzdual2xRycYqXBHFK5ZpLuSqa4vNF+slTGTONa6i5c
         Wu36yAhbN6F/MtOa3cztN6GasMYb1PLFa+YEXgRk8z0d7eEGQVfMcLNGEoTzcaYRZQHw
         cUHmUWCAILzCpMsY+LWA/mTaW6dC9ZWB9e25x51jbT6be+8z8QC+HL3uVWbhWomEFqBt
         DB4g==
X-Gm-Message-State: AOAM531EBsOqAMkzolFqNPinxRRG4CxRvUYiOIc7fA6UPTZhE1KGPnoR
        1eCKO7+rMSYW9zh9Iif65rzUCg==
X-Google-Smtp-Source: ABdhPJxc2E3L8aTmtUgQMfQq+Vt6ZEqRDoOS7jM0GndhlpxFniYLv2gxPPWM2uS+0jTBvknhSEn3ww==
X-Received: by 2002:a05:620a:14a:: with SMTP id e10mr1271604qkn.103.1611001472585;
        Mon, 18 Jan 2021 12:24:32 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id k19sm11091498qkh.6.2021.01.18.12.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 12:24:32 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l1b4h-003Hn6-Hd; Mon, 18 Jan 2021 16:24:31 -0400
Date:   Mon, 18 Jan 2021 16:24:31 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Douglas Gilbert <dgilbert@interlog.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        target-devel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        jejb@linux.vnet.ibm.com, bostroesser@gmail.com, ddiss@suse.de,
        bvanassche@acm.org
Subject: Re: [PATCH v6 1/4] sgl_alloc_order: remove 4 GiB limit, sgl_free()
 warning
Message-ID: <20210118202431.GO4605@ziepe.ca>
References: <20210118163006.61659-1-dgilbert@interlog.com>
 <20210118163006.61659-2-dgilbert@interlog.com>
 <20210118182854.GJ4605@ziepe.ca>
 <59707b66-0b6c-b397-82fe-5ad6a6f99ba1@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59707b66-0b6c-b397-82fe-5ad6a6f99ba1@interlog.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 18, 2021 at 03:08:51PM -0500, Douglas Gilbert wrote:
> On 2021-01-18 1:28 p.m., Jason Gunthorpe wrote:
> > On Mon, Jan 18, 2021 at 11:30:03AM -0500, Douglas Gilbert wrote:
> > 
> > > After several flawed attempts to detect overflow, take the fastest
> > > route by stating as a pre-condition that the 'order' function argument
> > > cannot exceed 16 (2^16 * 4k = 256 MiB).
> > 
> > That doesn't help, the point of the overflow check is similar to
> > overflow checks in kcalloc: to prevent the routine from allocating
> > less memory than the caller might assume.
> > 
> > For instance ipr_store_update_fw() uses request_firmware() (which is
> > controlled by userspace) to drive the length argument to
> > sgl_alloc_order(). If userpace gives too large a value this will
> > corrupt kernel memory.
> > 
> > So this math:
> > 
> >    	nent = round_up(length, PAGE_SIZE << order) >> (PAGE_SHIFT + order);
> 
> But that check itself overflows if order is too large (e.g. 65).

I don't reall care about order. It is always controlled by the kernel
and it is fine to just require it be low enough to not
overflow. length is the data under userspace control so math on it
must be checked for overflow.

> Also note there is another pre-condition statement in that function's
> definition, namely that length cannot be 0.

I don't see callers checking for that either, if it is true length 0
can't be allowed it should be blocked in the function

Jason
