Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF942E224
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2019 18:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfE2QTl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 May 2019 12:19:41 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34543 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfE2QTk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 May 2019 12:19:40 -0400
Received: by mail-qt1-f193.google.com with SMTP id h1so3342333qtp.1
        for <linux-rdma@vger.kernel.org>; Wed, 29 May 2019 09:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L7vMeldHDyAMzoHyx2Ftlo0ZEGBo2FK2HQWRdrQKlBA=;
        b=XeGFGm5aBogwnD0nuIakZkYfUVR8DETFLRCwJnAno7f28g91HWqU6UHrg9UTPmiq2f
         gWRdsAAtfFV6WSaJMhVbOB7R+zWt7cH71RVl2nkSbkL/uCnt9IweDhmv8JgkzmKB1jvA
         hLLnHZGT3GXfejTvPu3aqOdfNpYhoqUkxNjWYTn4oSD2fc3qV5dD1LhXxd+Sge8vz6of
         WNzco+Zr/9gij9sF/MelB5EnfNhYEKRaEllsjoE38a/3gq1Az8DzKzTIk8hpty8aZ2pH
         jJ0jZNyioB3kgCc9/udbX7bwyEVLM9Vp3BuBDxvA5nIvjko1RxZQg5PnaRHybaVpJxTo
         9UKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L7vMeldHDyAMzoHyx2Ftlo0ZEGBo2FK2HQWRdrQKlBA=;
        b=JKv+CFtNFwRXl8DvOxbfzvpdEMKpjsgGsyq+xXoaafE6ONSW3FMOJP0jRdjVPUELu/
         Ie5eg4rpCRivxpoDw7o3MBMftoZI+tu/2jU6BTrAIRw7d40Ap3si0Z0dnt5tUhBpCitP
         +NEBP7WS7zpM83M3ogwZeUfKjtgAzcRfqNvQK6sXLqALXmaUxwVYYgLcrAdz/fABI9iN
         S6fzdaz/Iiqc7uiWDZP89ne7ErD9s3ENCx9Po3ekES2/Pe4dEy0eRkwRDTh3vcXDRjTP
         5DpHOK9GC/bz5GDGknj4NvCGxljsHZ5iOvq35WS9C45Zs5f0xcc3CLdacyi7yTQWaD+P
         NW3Q==
X-Gm-Message-State: APjAAAUF5faYtQYWRs5MSlmCgS2iBRMzfP9og7e+CIEQXupHzFPYD6q8
        XNmbDwrvEBctliMTu8+U9r7QDw==
X-Google-Smtp-Source: APXvYqyHH1VbqrnOxRakTcnI5Oz6yWNV47MHUAgSrMD/CNqqD3aBRYiiH8FSc19HxivvTw4WB2Kw4A==
X-Received: by 2002:ac8:fa3:: with SMTP id b32mr100180896qtk.89.1559146779588;
        Wed, 29 May 2019 09:19:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id j33sm1665833qtc.10.2019.05.29.09.19.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 09:19:38 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hW1Ig-0003qt-7V; Wed, 29 May 2019 13:19:38 -0300
Date:   Wed, 29 May 2019 13:19:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Firas JahJah <firasj@amazon.com>
Subject: Re: [PATCH for-rc 4/6] RDMA/efa: Use API to get contiguous memory
 blocks aligned to device supported page size
Message-ID: <20190529161938.GA14765@ziepe.ca>
References: <20190528124618.77918-1-galpress@amazon.com>
 <20190528124618.77918-5-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528124618.77918-5-galpress@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 28, 2019 at 03:46:16PM +0300, Gal Pressman wrote:
> @@ -1500,13 +1443,17 @@ struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 start, u64 length,
>  	params.iova = virt_addr;
>  	params.mr_length_in_bytes = length;
>  	params.permissions = access_flags & 0x1;
> -	max_page_shift = fls64(dev->dev_attr.page_size_cap);
>  
> -	efa_cont_pages(mr->umem, start, max_page_shift, &npages,
> -		       &params.page_shift, &params.page_num);
> +	pg_sz = ib_umem_find_best_pgsz(mr->umem,
> +				       dev->dev_attr.page_size_cap,
> +				       virt_addr);

I think this needs to check pg_sz is not zero..

Jason
