Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9FF721FD4D
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2020 21:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbgGNT1C (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jul 2020 15:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbgGNT1C (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Jul 2020 15:27:02 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A34C061755
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 12:27:01 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w3so8840932wmi.4
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 12:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UAf5tCfK+uxHhs2awwHQMqRhRy6IzVXba/T+HOqNVUA=;
        b=fAnc4txzbHSrzQk0CRHRkdH1AzGf1VUvc08cXcmVMafnTK3dVurOGWF+RACGg1zd4x
         JrPba38k1iLtK1q9HYGA3RfS20W/YBmZBwsv85Zb7uDxGaKz28TzILEa2Fz/EaGv3K3o
         MB/BIOuPaJJ4mDbMcApXh7A9zimATJd22DHeIDN2yoXEiExyPjsDwYzXK/f4QhADhA5E
         Qgc4mllMFz3udI0sLxa48a5FRE3m6yi7PfqOec7Sb+gA9ofAzvBPaYKAuwQfPOUcOmBK
         cecmg//ykqc2MCATroUuT2/EXCYGWxy/g+wnPpk/vLvTJXs5+Rk27Wati3JS6mp4AXSF
         MO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UAf5tCfK+uxHhs2awwHQMqRhRy6IzVXba/T+HOqNVUA=;
        b=thr/CPurxcQRtyzQLmkKx7QYYF4Nc4oZQcgVBsjnRMiR0NiGxB7fnODJChR0VNJSZH
         Of/r4cf2WnYfEMB/DovXa3fC/CDzlgC0n7WROqV4hWadX+uCz3tQfCuovVL+KFrIteA8
         5ZfZ95a2c2V5iVDBuxULwXQy/dQDkUsSbzIvW7P4dGaGFYKVu5+5kTotT8CCxm/mHosB
         5GiWMyLnLynyDJI1Ql8TlwG9odxxdaaXEjiWPKinSVmE6HA1WM/E/PT7b0ht6rWN6V1m
         /XVIRJjM5QM4JRAsTc2qm+onp0jtHNEbpkooi0hsTpIbH6eWn4bFPLrm3CbT6kXA8BrT
         j6NQ==
X-Gm-Message-State: AOAM531fxj+YsnM6s/8GMzMbbf+RVNYC19oCd7NqS/vhMlEQzIeTVPRI
        /qGns5xv9kXoJL7S64UDVvruTKarnwM=
X-Google-Smtp-Source: ABdhPJzjgkNYPOduXjAImPWMDwICLDUvfi0bVcgE3lCRnP4S1pfTzOOeD52RB0RrGLeHk6HB3KPsWg==
X-Received: by 2002:a7b:c4d7:: with SMTP id g23mr5328060wmk.17.1594751191204;
        Tue, 14 Jul 2020 11:26:31 -0700 (PDT)
Received: from kheib-workstation ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id n14sm30801462wro.81.2020.07.14.11.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 11:26:30 -0700 (PDT)
Date:   Tue, 14 Jul 2020 21:26:27 +0300
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Kalderon <mkalderon@marvell.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: Re: [PATCH for-next 0/7] RDMA: Remove query_pkey from iwarp providers
Message-ID: <20200714182627.GA58593@kheib-workstation>
References: <20200714081038.13131-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714081038.13131-1-kamalheib1@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 14, 2020 at 11:10:31AM +0300, Kamal Heib wrote:
> This patch set does the following:
> 1- Avoid exposing the pkeys sysfs entries for iwarp providers.
> 2- Avoid allocating the pkey cache for iwarp providers.
> 3- Remove the requirement by RDMA core to implement query_pkey
>    by all providers.
> 4- Remove the implementation of query_pkey callback from iwarp providers.
> 
> Kamal Heib (7):
>   RDMA/core: Expose pkeys sysfs files only if pkey_tbl_len is set
>   RDMA/core: Allocate the pkey cache only if the pkey_tbl_len is set
>   RDMA/core: Remove query_pkey from the mandatory ops
>   RDMA/siw: Remove the query_pkey callback
>   RDMA/cxgb4: Remove the query_pkey callback
>   RDMA/i40iw: Remove the query_pkey callback
>   RDMA/qedr: Remove the query_pkey callback
> 
>  drivers/infiniband/core/cache.c           | 45 ++++++++++------
>  drivers/infiniband/core/device.c          |  4 +-
>  drivers/infiniband/core/sysfs.c           | 64 ++++++++++++++++-------
>  drivers/infiniband/hw/cxgb4/provider.c    | 11 ----
>  drivers/infiniband/hw/i40iw/i40iw_verbs.c | 19 -------
>  drivers/infiniband/hw/qedr/main.c         |  3 +-
>  drivers/infiniband/hw/qedr/verbs.c        |  1 -
>  drivers/infiniband/sw/siw/siw_main.c      |  1 -
>  drivers/infiniband/sw/siw/siw_verbs.c     |  9 ----
>  drivers/infiniband/sw/siw/siw_verbs.h     |  1 -
>  10 files changed, 77 insertions(+), 81 deletions(-)
> 
> -- 
> 2.25.4
> 

I found an issue while testing this patch set, I'll post a v1 that
fixes this issue soon.

Nacked-by: Kamal Heib <kamalheib1@gmail.com>
