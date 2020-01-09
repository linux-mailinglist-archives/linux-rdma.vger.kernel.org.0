Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACC0D135D65
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jan 2020 17:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732817AbgAIQAZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Jan 2020 11:00:25 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42415 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732812AbgAIQAY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Jan 2020 11:00:24 -0500
Received: by mail-qt1-f194.google.com with SMTP id j5so6234733qtq.9
        for <linux-rdma@vger.kernel.org>; Thu, 09 Jan 2020 08:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OaEt+p8c5E5h683JWpHMf2yCQzkuw0gp1DpJEBVRgAU=;
        b=groYf4qvDwUcEXNz8Oq2ZmeL1bWtKXTreNXy92kkoTVhg7ATX78oqQcJFJfPO+AxPr
         tPt/fimuZJhPLmUfAx4mQWVzbHABomBPjpxwzltqCczAr3HgRRgl7SgbKwxgasGpSafS
         Vp7SBM9rGXMv1/2yoKVRLnLcekHEWshlTlsN/5kOMXHiccmhvbTGgkDzK90qL99h+Xes
         DFxqHV4K0/A8ooCIPasaeEJ/yhCGRMMHa5Nc2lMmH9jf4kpjRBMYjJUQImoybUiJUof/
         +iSpE/1pAeqU2I7QgCJcJGNtoEdUpT4wPFK9a4Cq1Zdw9+Ru23MP5QxzvlOOYfbSkXmn
         HGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OaEt+p8c5E5h683JWpHMf2yCQzkuw0gp1DpJEBVRgAU=;
        b=MN0rXeULh2NrVY0mUxbDnzT3XM+jB7n+V/tAhLMdep21PVN1738P1q8QrThHbrhRtz
         07twRIow0IQjO2Q7G/eAR5g97tKE+CGbuA9VUrNc6UGASpr4jgBdmw1LanhQjQxpg/BZ
         TWAbAAGNkX5ng8kSRMBo+AYIfEGcXHp0LPFapzfPcwT+cwAsjzKOMhC33dQdfdOTqTEw
         PucYGkk6FR5dWN4YPN2ReXnqO6+Q2kCHyD2NRzMGHeaE2bDd5YKeZ9wKpBSF4qkaVNde
         M4AuRjM7KVKQnn8EJHrLjPKMuONEFKrcuV5pEYbZs+nt4OqRkVRB2QiG/iYju0wthWOq
         Kfvw==
X-Gm-Message-State: APjAAAU/u+jGOJHXXgDZH4wXuYtQWPFTXJD3jfcVdkW/rl3+AdrBTFOJ
        RhqJnRIAIwvtoJ18Xcwc6tYjFg==
X-Google-Smtp-Source: APXvYqyiV5zk3f2Y0y9wNm4SSPCSNwLTXH6FgkyQLkIdEFHnzBQsiIXMDPBc/n50blulCbedc1x4HQ==
X-Received: by 2002:ac8:554b:: with SMTP id o11mr8569055qtr.36.1578585623451;
        Thu, 09 Jan 2020 08:00:23 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id c6sm3149609qka.111.2020.01.09.08.00.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Jan 2020 08:00:22 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ipaEQ-0007Y4-AJ; Thu, 09 Jan 2020 12:00:22 -0400
Date:   Thu, 9 Jan 2020 12:00:22 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Moni Shoua <monis@mellanox.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/core: Fix build failure without hugepages
Message-ID: <20200109160022.GA28974@ziepe.ca>
References: <20200109084740.2872079-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109084740.2872079-1-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 09, 2020 at 09:47:30AM +0100, Arnd Bergmann wrote:
> HPAGE_SHIFT is only defined on architectures that support hugepages:
> 
> drivers/infiniband/core/umem_odp.c: In function 'ib_umem_odp_get':
> drivers/infiniband/core/umem_odp.c:245:26: error: 'HPAGE_SHIFT' undeclared (first use in this function); did you mean 'PAGE_SHIFT'?
> 
> Enclose this in an #ifdef.
> 
> Fixes: 9ff1b6466a29 ("IB/core: Fix ODP with IB_ACCESS_HUGETLB handling")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/infiniband/core/umem_odp.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason
