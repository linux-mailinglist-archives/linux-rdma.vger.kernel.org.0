Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4BC301FB
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 20:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfE3Sdm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 14:33:42 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42299 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfE3Sdm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 May 2019 14:33:42 -0400
Received: by mail-qk1-f193.google.com with SMTP id b18so4534173qkc.9
        for <linux-rdma@vger.kernel.org>; Thu, 30 May 2019 11:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WW/ZHqd2nGWEaj6rzAGwGk7KVfdFPIeE0AoIQ6a+V90=;
        b=egprgTv4cMB6Hhz7C7vSaBIjo76xJPEpanUu36pPQMOwcyZ6grYsULLHQOJhWRliSS
         nYe6EO2PIzVpB36tefs3qWkwssi9mTv8XjWAjRbrCuOxfQWQnSzcO2yL8SUpu+XFJwM/
         jdXTtUx3oIXyrbXSs3twb3lMx/cikOPxodJz7fDcYLBzZGYKGuNU5kYjrheD4dbCKIOa
         K9MVW97hBK6UJSR4TA/3CnPu7vdWYBC3zuAtOR6rYoixONN6bd2+CD/kbXhu58IAZISH
         X9gLQaV9JF1jvw4QVL4b3D3pUCqY5GepBQWbxiD3dUXtKk4SLFSSmSJG/p8MFeZlS+tc
         dEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WW/ZHqd2nGWEaj6rzAGwGk7KVfdFPIeE0AoIQ6a+V90=;
        b=nIOj9lJTrt2pE22km2SWFeRo08gmbMCZwcDZ7ic4bOS53cO+016mQKO/lU9PTPDNq6
         8BxO+ufL0aRHfV8WkxKFIChZEnZjZhAgNSPwk5lBR4J9SypxLxulJv0P2xPCMX3H8tt1
         VScoBX8lbQ1Q1fT9ckdeGFTC/gCMDFkzmo0Mi8henSQzGWEq/7OWBZZNqY1LGqLL+vKM
         qFBmXju1la6EiErK1YNfrFRJtEGL4PPWi5zIfjY2u8jc7P/6GfwgMixjZrBGzHhsi7wB
         etOFxNLA8t5bIyaxrT/IIRdruDXBCXksUnM1Brv9leAZ16XAPX6ooPSpGEG3qU6Rpief
         BQIw==
X-Gm-Message-State: APjAAAVv0CEfrmA3Yx5ldPSX++OvyfeTxeu4FS/dpq4kx2QafKHBHq3I
        McEYzJhYzwfPbEaOp1lZfnuSgQ==
X-Google-Smtp-Source: APXvYqwnX95URDlWMKa7FMSxRid/McEUa9or6bg1GYaFFbWgkhdz4KRQ+aqAt20CBJdZ1SICMPN38A==
X-Received: by 2002:a37:c45:: with SMTP id 66mr4710027qkm.31.1559241221867;
        Thu, 30 May 2019 11:33:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id 19sm2264427qtq.12.2019.05.30.11.33.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 11:33:41 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hWPrw-0006er-ML; Thu, 30 May 2019 15:33:40 -0300
Date:   Thu, 30 May 2019 15:33:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Firas JahJah <firasj@amazon.com>
Subject: Re: [PATCH for-rc 4/6] RDMA/efa: Use API to get contiguous memory
 blocks aligned to device supported page size
Message-ID: <20190530183340.GF13475@ziepe.ca>
References: <20190528124618.77918-1-galpress@amazon.com>
 <20190528124618.77918-5-galpress@amazon.com>
 <20190529161938.GA14765@ziepe.ca>
 <9DD61F30A802C4429A01CA4200E302A7A5B07AB2@fmsmsx124.amr.corp.intel.com>
 <0bb01352-1300-b624-d8f6-055e8df8dbd3@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bb01352-1300-b624-d8f6-055e8df8dbd3@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 29, 2019 at 10:35:58PM +0300, Gal Pressman wrote:
> On 29/05/2019 20:20, Saleem, Shiraz wrote:
> >> Subject: Re: [PATCH for-rc 4/6] RDMA/efa: Use API to get contiguous memory
> >> blocks aligned to device supported page size
> >>
> >> On Tue, May 28, 2019 at 03:46:16PM +0300, Gal Pressman wrote:
> >>> @@ -1500,13 +1443,17 @@ struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64
> >> start, u64 length,
> >>>  	params.iova = virt_addr;
> >>>  	params.mr_length_in_bytes = length;
> >>>  	params.permissions = access_flags & 0x1;
> >>> -	max_page_shift = fls64(dev->dev_attr.page_size_cap);
> >>>
> >>> -	efa_cont_pages(mr->umem, start, max_page_shift, &npages,
> >>> -		       &params.page_shift, &params.page_num);
> >>> +	pg_sz = ib_umem_find_best_pgsz(mr->umem,
> >>> +				       dev->dev_attr.page_size_cap,
> >>> +				       virt_addr);
> >>
> >> I think this needs to check pg_sz is not zero..
> >>
> > 
> > What is the smallest page size this driver supports?
> 
> The page size capability is queried from the device, the smallest page size is
> currently 4k.
> 
> Isn't PAGE_SIZE always supported? 

No, PAGE_SIZE is only supported if the device supports PAGE_SIZE or
smaller blocks.

> What did drivers do before ib_umem_find_best_pgsz() existed in case
> they didn't support PAGE_SIZE?

Most malfunctioned.

> I doubt there is/will be a real use-case where it matters for EFA,
> but I can add the check to be on the safe side.

Please, I want the reference implementations of this API to be correct
for reference by others.

Jason
