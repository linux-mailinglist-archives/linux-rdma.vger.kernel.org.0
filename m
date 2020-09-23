Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C0727500E
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Sep 2020 06:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgIWEp7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Sep 2020 00:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgIWEp7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Sep 2020 00:45:59 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1C0C061755
        for <linux-rdma@vger.kernel.org>; Tue, 22 Sep 2020 21:45:58 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id g4so19420339wrs.5
        for <linux-rdma@vger.kernel.org>; Tue, 22 Sep 2020 21:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=amr5X6DemUw9kv+aIFDrSNxIhb4QcJ7UZRTeKtCZZpk=;
        b=vwy8IjK509/GWqOmPelspZZYleo8ep9GVjV6PIs9pp5CqCu32S9pP0XwagUhw6xKLj
         RKbYmORYnL7jccfRgPeNOwRusmcBhRCVovT+Z1y0ir9bXjLvIXAPAkDd0+PpWm7a3R0y
         mkaCCPnYL/D/Xqlp0AlbG9o5eMdRYoTNT9yLhkOuwECNhSDDrHt8fXDeDuOw+pbK19Tr
         dKS+bggL9t/vZIHwdY+Xz59zaUnZUxsWluEeZpdaDp0dFySA23MEquCeoxb59rFMWQ3m
         cy0J9/8KYQRKAlVMEaNFmToqrYgOBMJqXKinf79Ox6DIrDXNxu2O39kNvpzMwnfKoced
         VCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=amr5X6DemUw9kv+aIFDrSNxIhb4QcJ7UZRTeKtCZZpk=;
        b=f04FqciFD9PEbbPqfxSwL/8HAQxhNdo5KkyUMvGfblZXFFCZvW90AJLxLIB/WwYh4i
         Y6StSD55RrEksvlSzUk3eAflpatQkvQzspw0FJsgsTHjU1LS26EeGv7nn4EqWGiJAJHm
         rDt+1REtQUhbKeniEYkxNWvt+xgeNCPzXDNrQk8krQzYgvuYmJTxbQpS94gzpoUTNDbz
         PmlAmqBpogFCQUWY5m39ilwe0yPPBwExnzdbOU4+f82FwBpp9udzYHXDOU1+N7ss1pCt
         DmTxG0nnD7a6Og/1HlZWJ2EZRbtqs2t5Mr2zLoGSRxtHBpIPpqZ96FsgydCTp+FMKyEl
         K0VQ==
X-Gm-Message-State: AOAM5323LMk8aJbGl+4iIB1rd3gfikELFiDjEFZk+sTHO6dNLlCjIzbX
        M3lr0kMhuLEhQE9SAW2qaNhidlXpO2i8Ig==
X-Google-Smtp-Source: ABdhPJzBT3PcNLYxmdPqE/mN0NGCabqI5PNo3GsiaHnzK+lKVPWLZltQ5kYTrRGH3hxHqo9SOPMf5A==
X-Received: by 2002:adf:fa52:: with SMTP id y18mr8963113wrr.264.1600836357427;
        Tue, 22 Sep 2020 21:45:57 -0700 (PDT)
Received: from gmail.com ([5.102.224.127])
        by smtp.gmail.com with ESMTPSA id 10sm6679616wmi.37.2020.09.22.21.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 21:45:56 -0700 (PDT)
Date:   Wed, 23 Sep 2020 07:45:53 +0300
From:   Dan Aloni <dan@kernelim.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: RDMA/addr: NULL dereference in process_one_req
Message-ID: <20200923044553.GA26248@gmail.com>
References: <20200922151348.GA4103095@gmail.com>
 <20200922170951.GE3699@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922170951.GE3699@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 22, 2020 at 02:09:51PM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 22, 2020 at 06:13:48PM +0300, Dan Aloni wrote:
> > The Oops below [1], is quite rare, and occurs after awhile when kernel
> > code repeatedly tries to resolve addresses. According to my analysis the
> > work item is executed twice, and in the second time a NULL value of
> > `req->callback` triggers this Oops.
> 
> Hum I think the race is rdma_addr_cancel(), process_one_req() and 
> netevent_callback() running concurrently
> 
> It is very narrow but it looks like netevent_callback() could cause
> the work to become running such that rdma_addr_cancel() has already
> done the list_del_init() which causes the cancel_delayed_work() to be
> skipped, and the work re-run before rdma_addr_cancel() hits its
> cancel_work_sync()

Thanks for the quick response! This 3-CPU race has really been a head
scratcher.

> Please try this:
> 
> From fac94acc7a6fb4d78ddd06c51674110937442d15 Mon Sep 17 00:00:00 2001
> From: Jason Gunthorpe <jgg@nvidia.com>
> Date: Tue, 22 Sep 2020 13:54:17 -0300
> Subject: [PATCH] RDMA/addr: Fix race with
>  netevent_callback()/rdma_addr_cancel()

Looks good - I've ran this for 11 hours now and it's stable. I think it
solved the problem.

-- 
Dan Aloni
