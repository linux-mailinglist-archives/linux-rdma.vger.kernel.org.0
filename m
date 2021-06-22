Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54583B03FB
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 14:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhFVMQZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 08:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbhFVMQY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Jun 2021 08:16:24 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431E6C061756
        for <linux-rdma@vger.kernel.org>; Tue, 22 Jun 2021 05:14:08 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id l2so13072451qtq.10
        for <linux-rdma@vger.kernel.org>; Tue, 22 Jun 2021 05:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LT13jFHeh4LTP9zE1+qKjJtIwv0pd0oBJbwT/TZVyeA=;
        b=DVQUvpScWMPfa8jzOm5GJInZHiXCte3+7wziG++Cbt2SXo6S0kC7qZ5S2R19Ku6N+A
         +vcesmQHxhqQ+ddNmTWS3xBsTMne9dSIRGwCC3dwN6DCWpPomjcFHHQZYfPfiz/U/fEN
         BcsFGVCk1nuYt6OvtcPkLFwavtC2bLEKzsVU0amWt0xsa55b68zHXTNFL1KkUDzWmotu
         KG8+rBgFVndL+pzoViTAulSH2ukV7ozmJvV+rEBk3tEt2BUB0neZ+u78kUkjzPj/SZdO
         /KrnU8ojE8AnXCeGbewGbvTKu7mNHlbniKbHuoKMydoFIv4PWU5cJ6qKHZhm45zyssZM
         wL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LT13jFHeh4LTP9zE1+qKjJtIwv0pd0oBJbwT/TZVyeA=;
        b=L0afXzSZAPtM06Y8Rp0kPvhtGaBfKUp7DL/2Ryc7a6DHSmfmAyDONCCK3/+iw4tr81
         1LGWjSRfV3VrATJT8LuGmmSdMoap4Debbgo8fJqlEfwQpQQlHjoB/xi4N1J/LoD1RKBl
         Y6lmoOCt8blXZ9Ltzy+YAMfq+MOX6pKtePkyWeRxLyk0B8YQghKMB0+N5IWCHXKfaOyO
         fHTdpGVvstwWAFVv3/MAsA/CQI3eV/NDvgwm+BpJh6OFAUx8epmIadnyBJ7pTcB9ASql
         MnHh/sofiWmuw5g5EuKe/B2+LdjBvdf4kvrQsViwOZL8yPEmpuNe64cck+YlJ3LpmLBM
         g8lw==
X-Gm-Message-State: AOAM530j82BiCj8rb1QNtBE/GHjOMPD7eKCMdpNEbSlSf+fuU2BnDvca
        k4RWHZB5VfuIFEhup63425sfeA==
X-Google-Smtp-Source: ABdhPJzB/T8OeZHW0Fa+lqmMV3l7eddmIs4AfvJ743S6J97Z+4JDNhhYB8uDnrjQ0zz/SUkxhHUkoA==
X-Received: by 2002:ac8:464c:: with SMTP id f12mr3175896qto.303.1624364047367;
        Tue, 22 Jun 2021 05:14:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id c16sm1395182qtd.46.2021.06.22.05.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 05:14:07 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lvfI6-00A9az-EY; Tue, 22 Jun 2021 09:14:06 -0300
Date:   Tue, 22 Jun 2021 09:14:06 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     ira.weiny@intel.com
Cc:     Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Kamal Heib <kheib@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] RDMA/i40iw: Remove use of kmap()
Message-ID: <20210622121406.GM1096940@ziepe.ca>
References: <20210622061422.2633501-1-ira.weiny@intel.com>
 <20210622061422.2633501-3-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622061422.2633501-3-ira.weiny@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 21, 2021 at 11:14:20PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> kmap() is being deprecated and will break uses of device dax after PKS
> protection is introduced.[1]
> 
> The kmap() used in the i40iw CM driver is thread local.  Therefore
> kmap_local_page() sufficient to use and may provide performance benefits
> as well.  kmap_local_page() will work with device dax and pgmap
> protected pages.
> 
> Use kmap_local_page() instead of kmap().
> 
> [1] https://lore.kernel.org/lkml/20201009195033.3208459-59-ira.weiny@intel.com/
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/infiniband/hw/i40iw/i40iw_cm.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

This needs to be resent against irdma instead

Jason
