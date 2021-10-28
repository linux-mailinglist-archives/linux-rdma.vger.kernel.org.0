Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC0543E159
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Oct 2021 14:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhJ1M4g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Oct 2021 08:56:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24392 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229946AbhJ1M4g (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 28 Oct 2021 08:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635425649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nsuLDpGBzJHkbrvFCq+yO99keCfZ1AV8nen4iUBcVQg=;
        b=ariPDsugn1BoYfYoyp+R04QS0T0IAkjV15x5+SUrPMs0+jaDQnVQ7SaeQt+aYInLm64L8C
        Xg4gltx59Glk5vCmkHqFCDBcTUEfBMGZjlhbGeUT5ETQO289GOOHCENJu4Jv7hpS1HGgmF
        Toy6qiMX6yTPNVD+BiHM/h9Smi0lMCs=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-XXGYPQcPPya-p5VAN2qGFQ-1; Thu, 28 Oct 2021 08:54:07 -0400
X-MC-Unique: XXGYPQcPPya-p5VAN2qGFQ-1
Received: by mail-lj1-f197.google.com with SMTP id p19-20020a2e8053000000b002119ff434a2so1593283ljg.11
        for <linux-rdma@vger.kernel.org>; Thu, 28 Oct 2021 05:54:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nsuLDpGBzJHkbrvFCq+yO99keCfZ1AV8nen4iUBcVQg=;
        b=4M8MqH8rOneHRmC09JhDYHs3AG4Z5RnDoeMP9RcEZ2EOdG2IMDltga0hJPrzq4KlJz
         436llhE/mMuMkJ3iDD2SMgPTbD0PGI+74QQrhEL9k1EfWUvJ4t/rIsH673yA9JyVRsSF
         5ozSrBt7WTsaD8blmCBSImLoKDgIbdMvames8onvgQXhxVJKnERcvXpvoN0FAgfsAOE3
         QgDgamWxJ/PkfZ2/6yCGiSUK3uc1RXjYgmSIJLBEVzRmUDWYBy/I+UQ8bioAODxdLbbE
         eCvLsn8MaeC4ljg+7Vlmhg79bV98pbjNdSrhgZ1Weh+m5xhVacz4JpUhfAmLv/SH5y/T
         p85w==
X-Gm-Message-State: AOAM5303sA5mZnqa+FM5CngrOF1eudXAnX00ChBY1lHb5Xn1t0y0+Nh3
        STLUT7yAA7d3F/sWTGn0PivaOW/DByWNrexjSsZU20YciemvFbFOY7oD4XMU2Sfx1SvmDEc5E6i
        78rW5VVbDMN26qbYFbM8CzrHK0LwY+S70oiGGsQ==
X-Received: by 2002:ac2:59cc:: with SMTP id x12mr3989828lfn.501.1635425646390;
        Thu, 28 Oct 2021 05:54:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDe9vqrDyW8kGWajxZZDdIM1u+BLZQ4vXjWaWTjNpYmvgJThsjTJbUq3YJSE5mO+K/BY/zM2Y21GBVBLjKLv4=
X-Received: by 2002:ac2:59cc:: with SMTP id x12mr3989814lfn.501.1635425646157;
 Thu, 28 Oct 2021 05:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20211028124426.26694.48584.stgit@awfm-01.cornelisnetworks.com> <20211028124606.26694.71567.stgit@awfm-01.cornelisnetworks.com>
In-Reply-To: <20211028124606.26694.71567.stgit@awfm-01.cornelisnetworks.com>
From:   Doug Ledford <dledford@redhat.com>
Date:   Thu, 28 Oct 2021 08:53:25 -0400
Message-ID: <CAGbH50to=YUHUsaVZAvw_+_AWNnNVaJtEmMFco417jqVGNg5_Q@mail.gmail.com>
Subject: Re: [PATCH for-next 2/3] IB/qib: Rebranding of qib driver to Cornelis Networks
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Scott Breyer <scott.breyer@cornelisnetworks.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Do you guys actually still support the qib driver and/or hardware?
That's old 40gig stuff. Is it still in use?

On Thu, Oct 28, 2021 at 8:46 AM Dennis Dalessandro
<dennis.dalessandro@cornelisnetworks.com> wrote:
>
> From: Scott Breyer <scott.breyer@cornelisnetworks.com>
>
> Changes instances of Intel to Cornelis in identifying strings
>
> Signed-off-by: Scott Breyer <scott.breyer@cornelisnetworks.com>
> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> ---
>  drivers/infiniband/hw/qib/qib_driver.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/hw/qib/qib_driver.c b/drivers/infiniband/hw/qib/qib_driver.c
> index 84fc4dc..bf3fa12 100644
> --- a/drivers/infiniband/hw/qib/qib_driver.c
> +++ b/drivers/infiniband/hw/qib/qib_driver.c
> @@ -1,4 +1,5 @@
>  /*
> + * Copyright (c) 2021 Cornelis Networks. All rights reserved.
>   * Copyright (c) 2013 Intel Corporation. All rights reserved.
>   * Copyright (c) 2006, 2007, 2008, 2009 QLogic Corporation. All rights reserved.
>   * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
> @@ -62,8 +63,8 @@
>                  "Attempt pre-IBTA 1.2 DDR speed negotiation");
>
>  MODULE_LICENSE("Dual BSD/GPL");
> -MODULE_AUTHOR("Intel <ibsupport@intel.com>");
> -MODULE_DESCRIPTION("Intel IB driver");
> +MODULE_AUTHOR("Cornelis <support@cornelisnetworks.com>");
> +MODULE_DESCRIPTION("Cornelis IB driver");
>
>  /*
>   * QIB_PIO_MAXIBHDR is the max IB header size allowed for in our
>


-- 
Doug Ledford <dledford@redhat.com>
GPG KeyID: B826A3330E572FDD
Key fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

