Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 208F05FC86
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2019 19:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfGDRdB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Jul 2019 13:33:01 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42644 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfGDRdB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Jul 2019 13:33:01 -0400
Received: by mail-qt1-f195.google.com with SMTP id h18so1262185qtm.9
        for <linux-rdma@vger.kernel.org>; Thu, 04 Jul 2019 10:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HfB+y0EWrCq939lZC6BVLYGGGfM6gRDqvaoBS4XsKwo=;
        b=UHj96iPBfRHbijycrCaAz+z+lVUHGBtVTkRhk3kRZb3tATdGCCzkPz/3dplhO+T4o7
         hrP7z2NcziQ5BVcOxojy53+idHJ6DcTy3XvyRKv/ivyvedHWHyqT0iiJxsXhVH5sTSYo
         rZyU3L4I+8ZZQGvyQrF86cao575gWlkJw0WW+I60eRo+3qsTEtRTgLGLWK9Ds0eIFO4N
         xAM4ywH1NUpszlGsLiYruPydkvyMkB0sL+hVt4ubGMUFraoBu9od440jQpL42ViwXtfg
         dR6c+gYRGaCBuF/KNLV/FELP2mu56pPJX+SKNwqLAAtzmpfQLjcLBhNGdNHqL9hMoaQ1
         PlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HfB+y0EWrCq939lZC6BVLYGGGfM6gRDqvaoBS4XsKwo=;
        b=E+exILrum1GNnEEJ3noQUYp8gxSZamW6M2+q0/Ot0nIuy+3hTYlJtWohKYT0XvJlIM
         8TzjPdnCIp1SDRakzRRKRcp2aP5fdaFC+Ai79nxqCEiVdF+peyZ7Zyl5EUHXo/CKCo+h
         dd7J2tm2zXO44YbakOUKFGHSTwefkXMtNHxAfor90Y9NcmdRYJcDMu7RtyckzTZwqJC1
         ZUZaFxOG1uCsh4VGYyCe2iU0swTKV8QzsnaU6MtKm0rTxyZTF3NMPXT08cXijeG7YGwL
         FhWy4VUuOEtxx7cb7owyNQCoUTbzchmsxIA3HXAIU3D1M5FsUqwT3EGciVAkZ/qsDEh9
         FiLQ==
X-Gm-Message-State: APjAAAWKwR9ovqYoliHOvbqx5brnlqXUNkSrJrxBh254k2BRSaKuvfLe
        QK3Eg9yOXpHRqQzMK0QcCdzZ4PRESxzjcg==
X-Google-Smtp-Source: APXvYqx1HKB9iRrDoppYwAzTMDatazWUWNm2Q63N/7lpnVVQ7SSrn2H8eCvwPnp8+PPY/VG0+7Mtmg==
X-Received: by 2002:ac8:19ac:: with SMTP id u41mr35665954qtj.46.1562261580297;
        Thu, 04 Jul 2019 10:33:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id c5sm2630832qkb.41.2019.07.04.10.32.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jul 2019 10:32:59 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hj5bP-0005QV-Eo; Thu, 04 Jul 2019 14:32:59 -0300
Date:   Thu, 4 Jul 2019 14:32:59 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Daniel Kranzdorf <dkkranzd@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Entropy in admin commands id
Message-ID: <20190704173259.GA20837@ziepe.ca>
References: <20190630145302.13603-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190630145302.13603-1-galpress@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jun 30, 2019 at 05:53:02PM +0300, Gal Pressman wrote:
> From: Daniel Kranzdorf <dkkranzd@amazon.com>
> 
> Make admin commands id easier to distinguish by using relevant bits from
> the producer counter.
> This allows us to differentiate admin commands with the same producer
> index (happens after admin queue overlap), which is helpful when
> debugging.
> 
> Signed-off-by: Daniel Kranzdorf <dkkranzd@amazon.com>
> Reviewed-by: Firas JahJah <firasj@amazon.com>
> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa_com.c | 44 +++++++++++++++--------------
>  1 file changed, 23 insertions(+), 21 deletions(-)

Applied to for-next, thanks

Jason
