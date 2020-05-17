Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C91E1D6E18
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2020 01:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgEQXjf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 May 2020 19:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbgEQXjf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 17 May 2020 19:39:35 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E6AC05BD09
        for <linux-rdma@vger.kernel.org>; Sun, 17 May 2020 16:39:35 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id o19so6702742qtr.10
        for <linux-rdma@vger.kernel.org>; Sun, 17 May 2020 16:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uyEuxRNFXxTHy3jGi0sWbeje0rtWktiI61ku1YR5XQM=;
        b=XjhPGZRo0hy8lSmN30iv1FoYoHjLrpvvcHo2ygtee9JGSbbc23mYomHH8Z86s2tlCX
         gnqc2lLavwzbflQSUEgeR0JQ6AsJHCUplyGvNtfeCAEUoNY009++TEHuN2WdzM5d+FO9
         g7ahM11TlktabGO9d5LIGR3Rob5zJaeP4GICBIBjYyDxvVdMrkk0yheOmhFnAgWVy0x3
         iVRXrugQ4lAyw+MIKA3ccFfqbZI61v5/idR6NHYVq0uAcJ5ZGTd7PfCjj9+SK6zeJpBd
         rpeTm1mqNIgKMC3U+Mu/KfxUhILzYwZEgY2/4u76ovdTYjffdFJVBEo6KZThyEmnuSLD
         DqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uyEuxRNFXxTHy3jGi0sWbeje0rtWktiI61ku1YR5XQM=;
        b=nPH17ag1Btw5BooL5irZO9+fR28j5u7Az3PmimecsxmRzZVsbZtPV4ePCUPqMge8Mo
         GnQTdvmPW144w3oFYamwoONJ3Z97cxmpOwbQd/vtBEwZAioczXKLG7YRtYfQ+RrrLG28
         VWWeq+mIRBxM346/znm49omvup8KPYYqDovnF4mS0uPNR/4TdAira8F8IAUg3H+87Mw1
         Sfh0QBuLteMZGDi+3DPjS2xWNNbqzlyt1qUMl7M1T2C6r3EUpzN7YCxYaUfvmTdouUHY
         wxKu4YrpCkoMnWwBg/vNYdL5ptMuVuB6WtMSxOw5/qcdVSVTKKAWjLecSvBga+AN4Juv
         5gYQ==
X-Gm-Message-State: AOAM531rokPP65PM6w+o0lYZBaGO+wxJMKSpCFFY9Pta5jrw1HgOBmuJ
        sZRdFMrqbqfuPiQS4dA9ewwa39mFqss=
X-Google-Smtp-Source: ABdhPJywRpZiu8hlsjiCj7AHdvyj1Pqr2ufHjq9Exhw35hVjtBlDgjnAeGfjnWQZjfBVBC7HAqbrAg==
X-Received: by 2002:ac8:518f:: with SMTP id c15mr13340000qtn.142.1589758774534;
        Sun, 17 May 2020 16:39:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id j45sm8412885qtk.14.2020.05.17.16.39.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 May 2020 16:39:34 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jaSsX-0005YA-Ll; Sun, 17 May 2020 20:39:33 -0300
Date:   Sun, 17 May 2020 20:39:33 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     bvanassche@acm.org, dledford@redhat.com,
        linux-rdma@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/srpt: Add a newline when printing parameter
 'srpt_service_guid' by sysfs
Message-ID: <20200517233933.GA21233@ziepe.ca>
References: <1589182629-27743-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589182629-27743-1-git-send-email-wangxiongfeng2@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 11, 2020 at 03:37:09PM +0800, Xiongfeng Wang wrote:
> When I cat module parameter 'srpt_service_guid', it displays as follows.
> It is better to add a newline for easy reading.
> 
> [root@hulk-202 ~]# cat /sys/module/ib_srpt/parameters/srpt_service_guid
> 0x0205cdfffe8346b9[root@hulk-202 ~]#
> 
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
