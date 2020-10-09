Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067EF288A4B
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Oct 2020 16:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732208AbgJIOHu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Oct 2020 10:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgJIOHu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Oct 2020 10:07:50 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79390C0613D2
        for <linux-rdma@vger.kernel.org>; Fri,  9 Oct 2020 07:07:48 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id r8so7955552qtp.13
        for <linux-rdma@vger.kernel.org>; Fri, 09 Oct 2020 07:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tR6FqZHNMyUIeF6ew7UDxxvOygfJoua42byZ5vbjB5U=;
        b=ZF+KhtdVKY9lkdJCPjoxyyz2T8J3ornmBApt5soIFfvonZAToP2nk99JcX1H7+rzPA
         9AflIsoYvFuhMIzIhVqiyK4WQxDB0ha3tkiK6CFJLgFGKXXykc904O8ADf7e0Ns62UXH
         mvcgbABid5FqIj/qzUpWuJQhhdotaOayJhIkG3IRsr7t1Ibd14K5Kfc8Afj13x3rkDnU
         1zX2ZIu9cPBZ+8Yie4iBZ6iAhCmUpI9KTRYFDFLruxM2KuZXAEenTCssjhwqznL3kyAU
         pCRrwvNbYMylGZKH+dWPao7vVDZHQ21l/4a62Xe9Jj09WZtv1LvNhd0snEel8dKLIZ0J
         4mMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tR6FqZHNMyUIeF6ew7UDxxvOygfJoua42byZ5vbjB5U=;
        b=ef/V84mZPfOHYEQpQrgY6C6TndO9fx3P7GKTN0tk4vPT5Ma1Wwo6xh65qklwhbVKTU
         DdW2cSaJwWwlr/SQ4h5Le/xYEIQZ+NQeBwB/8ybrP23903IoleUnTckDbnbPrdBBgHIX
         g32dgoALM0krZWwYuUhTNAoUnkN05t2lpJW9r3svsDMRz8edUaH6Bs0qm6jqJ8+CIWqg
         /C421J1wxAtz2SqYpMyGkcVeA5s33vP6u/crn030iLR3DmpC5lE+yPfYW0vZ/tGOB4Gq
         UN7qslku95tMl2GaDyuDDE6Rwct0HMLyAFm5NW/vXQt8BNRGVejNR99Jtugey3mGHaFq
         vGmQ==
X-Gm-Message-State: AOAM532ndI1K29obahPla7AAYS0RZmLmKG5fvOFOnVdfaeVzxYk0dQgD
        Gttc1ubz/iCSMM01RToX9BxaqQ==
X-Google-Smtp-Source: ABdhPJxtg0S54bIaK6djoDW6+y8M1PX7NiRwIerPaYKZwKuG580xRVE34m0e7DHC6HaDbmXCXYshgQ==
X-Received: by 2002:ac8:37b3:: with SMTP id d48mr13936412qtc.70.1602252467699;
        Fri, 09 Oct 2020 07:07:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id k3sm6088378qtj.84.2020.10.09.07.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 07:07:46 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kQt3i-001zT3-BN; Fri, 09 Oct 2020 11:07:46 -0300
Date:   Fri, 9 Oct 2020 11:07:46 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Joe Perches <joe@perches.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        Adit Ranadive <aditr@vmware.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/4] RDMA: Convert sysfs device * show functions to use
 sysfs_emit()
Message-ID: <20201009140746.GQ5177@ziepe.ca>
References: <cover.1602122879.git.joe@perches.com>
 <7f406fa8e3aa2552c022bec680f621e38d1fe414.1602122879.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f406fa8e3aa2552c022bec680f621e38d1fe414.1602122879.git.joe@perches.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 07, 2020 at 07:36:24PM -0700, Joe Perches wrote:
> Done with cocci script:
.. 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/infiniband/core/sysfs.c               | 47 +++++++++++--------
>  drivers/infiniband/core/ucma.c                |  2 +-
>  drivers/infiniband/core/user_mad.c            |  4 +-
>  drivers/infiniband/core/uverbs_main.c         |  4 +-
>  drivers/infiniband/hw/bnxt_re/main.c          |  4 +-
>  drivers/infiniband/hw/cxgb4/provider.c        | 10 ++--
>  drivers/infiniband/hw/hfi1/sysfs.c            | 16 +++----
>  drivers/infiniband/hw/i40iw/i40iw_verbs.c     |  6 +--
>  drivers/infiniband/hw/mlx4/main.c             |  8 ++--
>  drivers/infiniband/hw/mlx4/sysfs.c            | 30 ++++++------
>  drivers/infiniband/hw/mlx5/main.c             | 13 ++---
>  drivers/infiniband/hw/mthca/mthca_provider.c  | 14 +++---
>  drivers/infiniband/hw/ocrdma/ocrdma_main.c    |  4 +-
>  drivers/infiniband/hw/qedr/main.c             | 10 ++--
>  drivers/infiniband/hw/qib/qib_sysfs.c         | 30 ++++++------
>  drivers/infiniband/hw/usnic/usnic_ib_sysfs.c  | 16 +++----
>  .../infiniband/hw/vmw_pvrdma/pvrdma_main.c    |  6 +--
>  drivers/infiniband/sw/rxe/rxe_verbs.c         |  2 +-
>  drivers/infiniband/ulp/ipoib/ipoib_cm.c       |  4 +-
>  drivers/infiniband/ulp/ipoib/ipoib_main.c     |  7 +--
>  drivers/infiniband/ulp/ipoib/ipoib_vlan.c     |  2 +-
>  drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c  | 17 ++++---
>  drivers/infiniband/ulp/srp/ib_srp.c           | 41 ++++++++--------
>  23 files changed, 156 insertions(+), 141 deletions(-)

I didn't notice cocci getting any thing wrong here

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Will have to wait till rc1 though

Jason
