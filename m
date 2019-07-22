Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6781E70165
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2019 15:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbfGVNn3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jul 2019 09:43:29 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33249 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbfGVNn2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jul 2019 09:43:28 -0400
Received: by mail-qt1-f195.google.com with SMTP id r6so34317067qtt.0
        for <linux-rdma@vger.kernel.org>; Mon, 22 Jul 2019 06:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4om09KH+mMYfOMyEWorCm4gkfaLmWEp4Zz577o5tnzw=;
        b=Z4nhMuCHkx2C2QiN6R46o8qWmF/irlKFq8YIXRV1P2eYFtZ2G5CNYtmzrJwrfKX+I8
         PejV6iyd1X4MDfNzmG1dae191MLS00W7l7SakVvI653hUIJQ5KFI0zhLNojnfvzyRRBM
         +0MHskj8UtfKV24WnnHtBZE93JzGNgdUyq2DqlTZH+tQFEG6HkDjMRgUF77q5kCgg5iL
         OOxcml59iKO+jDcV1s/koz257W/WdEIoLEc3dt/8qnVPW62gqdQuq6S6vJhvErhphQTV
         uL5YczA2pVXNv9nG73TxfyohK2IXCoAML6IB85o3DNqL7JBYEJFGBWBfrtDtZ8ZDjAMK
         cxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4om09KH+mMYfOMyEWorCm4gkfaLmWEp4Zz577o5tnzw=;
        b=oz5TtxgwCAZxJnlg8j8S3ZCR+VofUVevtUkoCdpoGsa/tqBtOqaJiHzaneo1nHf9JU
         zylftD/2T4teLDMTa0cZyksitMnXVyQ2LMY3zDzrroImtV3C1b+6ZFhz7HgKMHn71GIz
         PyWFAtM4ErnUn/OQGTr/BJbj4bC5YVqjiIzt695byGiDkagSMrI0UN8wFMM5Kiah4v0c
         h8M4CzUR9XnEttyWff/s9sibqUSuXG2ol40GMHIATl4ZlKdXDfLR5LtyAuxJnhdoAxbZ
         1c6KChFX0nzNuo4cCWsjZOPeDOxrg5iJgSBFTLgsdnOcO5VfLBmlVVQmXI/lmLFbZ2Ou
         JLnQ==
X-Gm-Message-State: APjAAAUATKI6KMD9RM8csVfD2AQ6omIapPfVnYXUss1uHe9p8gulHwcL
        ytIVx8xr2oBOL54tD0VDti0u7Q==
X-Google-Smtp-Source: APXvYqwj8EXGuhgBbbkA8ickI3gkT/Mr/IhMPtQRhHEMq6721SlIOUIiwe2SSeI0B8IJmf3kwu4wxA==
X-Received: by 2002:a0c:acef:: with SMTP id n44mr51933193qvc.39.1563803007925;
        Mon, 22 Jul 2019 06:43:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id w16sm16786562qki.36.2019.07.22.06.43.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jul 2019 06:43:27 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hpYb9-0003Xb-3n; Mon, 22 Jul 2019 10:43:27 -0300
Date:   Mon, 22 Jul 2019 10:43:27 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: Re: [PATCH for-next 0/3] {cxgb3, cxgb4, i40iw} Report phys_state
Message-ID: <20190722134327.GC7607@ziepe.ca>
References: <20190722070550.25395-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722070550.25395-1-kamalheib1@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 22, 2019 at 10:05:47AM +0300, Kamal Heib wrote:
> This series includes three patches that add the support for reporting
> physical state for the cxgb3, cxgb4, and i40iw drivers via sysfs.
> 
> Kamal Heib (3):
>   RDMA/cxgb3: Report phys_state in query_port
>   RDMA/cxgb4: Report phys_state in query_port
>   RDMA/i40iw: Report phys_state in query_port
> 
>  drivers/infiniband/hw/cxgb3/iwch_provider.c | 16 +++++++++++-----
>  drivers/infiniband/hw/cxgb4/provider.c      | 16 +++++++++++-----
>  drivers/infiniband/hw/i40iw/i40iw_verbs.c   |  7 +++++--
>  3 files changed, 27 insertions(+), 12 deletions(-)

Lets not have this generic iwapr code open coded please.

The core code already knows what the netdev is for the iWarp device.

Jason 
