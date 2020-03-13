Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16CE0184889
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2020 14:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgCMNyc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Mar 2020 09:54:32 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:44847 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgCMNyc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Mar 2020 09:54:32 -0400
Received: by mail-qv1-f65.google.com with SMTP id w5so4575385qvp.11
        for <linux-rdma@vger.kernel.org>; Fri, 13 Mar 2020 06:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lyL96NnOtb0YVVwZoDlRpfxuVAC3JQzho6kDpuYDL0k=;
        b=iLC5DeEFJNGT0lCnhiU+n87lLmZBn8OxLOGcGD8vFaIdSF3hWjJKX4wrjKFIEI3M2u
         6m5E8RXzJIk+miR3CRcrvrJJebtvWghd/J5pxltuqehb2b8eZmSk/+yeHzy4CqrnUnZg
         RinI0/jjhZ79Zccm65Dy+Vm9qkd8WVkk2R/UoaKzZ8RpvJcKQUIrsC9uP5jkIyQQHSdg
         Grc9cFbSAehTtxHJ65t5lbong3AL6RVGp1A5pD3N9eGsmgSQZLwoigWCa/y4HPg90OQg
         o+mCKPlV6bckCz+4bNJBHcDU5oUQjBoSdeFymiUUzjaXi5L25d2qRKCVP1e7w8NQ9pV9
         P6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lyL96NnOtb0YVVwZoDlRpfxuVAC3JQzho6kDpuYDL0k=;
        b=Xg8nq8lAMz2WW3TQ5ua5YWOKChFtXMGWvOxZl3gKDHt1GuvyX/Lsx3PxACBe95VorI
         vo+nxMLWjxg3jt2GBO+NIxrSIRYA3bd63PFO66W3vdYWQwlgKclVLBAUbzPlwpHZjkMd
         Yt3aQ6X3AeSQeVD28eJRiOZ6UmFw6ZBmqkK9IZLjrFdt3QKGlbWmIq6pVD5ALHGtu/KJ
         6lgXY4x3hPGHxLe90RWypOU6WSP/leeEZ8YGLb77QP0CXUbiMEUEvu6vSP+KiCC5btUP
         r7D0sifPtxWV0uWKHMSzFpNKkackiGkG5u51tOeVsZZEY6/TKBEh0K+anfEyr+fJWaSJ
         V6Yw==
X-Gm-Message-State: ANhLgQ2iUOZV1P9cm3bGiKJESiOd1hD1xffvrD5tAfsBOxNAXrrEgY9b
        B4MIMBCAWr/MurYm5NWbks5N3g==
X-Google-Smtp-Source: ADFU+vsFHVJ90TzoBAScMYFmks7Bj41s6KmIgsimDahh4CSlwLWdb2yb2rxhN5OoB2U/4Fy7r2hljw==
X-Received: by 2002:a0c:e912:: with SMTP id a18mr12643391qvo.101.1584107671335;
        Fri, 13 Mar 2020 06:54:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 10sm9039686qtt.65.2020.03.13.06.54.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Mar 2020 06:54:30 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jCkli-0006eW-ER; Fri, 13 Mar 2020 10:54:30 -0300
Date:   Fri, 13 Mar 2020 10:54:30 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 11/11] RDMA/cma: Provide ECE reject reason
Message-ID: <20200313135430.GA25517@ziepe.ca>
References: <20200310091438.248429-1-leon@kernel.org>
 <20200310091438.248429-12-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310091438.248429-12-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 10, 2020 at 11:14:38AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> IBTA declares "vendor option not supported" reject reason in REJ
> messages if passive side doesn't want to accept proposed ECE options.
> 
> Due to the fact that ECE is managed by userspace, there is a need to let
> users to provide such rejected reason.
> 
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  drivers/infiniband/core/cma.c    | 14 ++++++++------
>  drivers/infiniband/core/ucma.c   |  7 ++++++-
>  include/rdma/ib_cm.h             |  3 ++-
>  include/rdma/rdma_cm.h           | 13 ++++++++++---
>  include/uapi/rdma/rdma_user_cm.h |  7 ++++++-
>  5 files changed, 32 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index f1f0d51667b7..0b57c15139cf 100644
> +++ b/drivers/infiniband/core/cma.c
> @@ -4191,8 +4191,8 @@ int rdma_notify(struct rdma_cm_id *id, enum ib_event_type event)
>  }
>  EXPORT_SYMBOL(rdma_notify);
>  
> -int rdma_reject(struct rdma_cm_id *id, const void *private_data,
> -		u8 private_data_len)
> +int rdma_reject_ece(struct rdma_cm_id *id, const void *private_data,
> +		    u8 private_data_len, enum rdma_ucm_reject_reason reason)
>  {

Let not call something like this rdma_reject_ece, pass in the
ib_cm_rej_reason directly and update callers

Jason
