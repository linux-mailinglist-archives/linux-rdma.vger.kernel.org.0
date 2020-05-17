Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADCAF1D6DE5
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2020 00:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgEQWxO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 May 2020 18:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgEQWxO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 17 May 2020 18:53:14 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC22C061A0C
        for <linux-rdma@vger.kernel.org>; Sun, 17 May 2020 15:53:14 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id t25so6710830qtc.0
        for <linux-rdma@vger.kernel.org>; Sun, 17 May 2020 15:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bLMGeFpMzHap5sgOAS1H3b3cAtNrQ3AAfCGbRF9dvJU=;
        b=YNdZugZ57ESrx+WGCQkTlUcz+PnCmyuxRxBcYBdswYSmqPhKUcr5h7TJs4ruurwKjG
         lZHkUGgdd044di7330tjOubSUHvWuR7Z9RpDALf3DN6d20GWIrxcmrtsrbykIrTasbfp
         0cn9fr6WZdNSzsQJwrVkTKCrpZwcPfYeDEJnxML6NCAAAlXVGnQi65bx6TrhUClXALZX
         ziZTRN8hLI86srvsC/DYwbh/AajvQzi370qAvj6PIL8COaJDknRkJiDj+RTBonN1Z25+
         yz37P4BizYo2Zlw/D7FD2FrwfV4zgeUhbSTrdVJWYj9hXz9UN7I8x6BnpzL6AmsXXN9v
         oLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bLMGeFpMzHap5sgOAS1H3b3cAtNrQ3AAfCGbRF9dvJU=;
        b=e8h5AaNnNYXTV/TknJaNeVM2ZSL2TSt9JUhuHAgWxisv5pwO9C4eRGkLAZHiSbl/ui
         I3TGh6KACuaGGJMiSppiB8xq1EQdWi0gEz/OzJJn7V3lOVwqVKrvoqlHM6EpqU6c0pW4
         nsa3YIOY/o3smNEjVkhtMv+MZEiWt+BXrN3PK8haQYb5d2GZWiwLzi8cRxpooqSEdxw2
         bHV+h5lJAIVU0Ny11MJzagcgcaRMbRpoWPI+eORuVimbJ6tr4o9Xg1P2SejTl5C1UKz/
         kFGQN4GYpC7+EI6kD8bzbS3os2vuStw1x29Nv0TixkajkHb2VX4e8od+D3v/DULJv/Rw
         TqLQ==
X-Gm-Message-State: AOAM533OFBhG+Xmklpx8MmatpTTzeibkKCqvo1IhisK7JXKLSQgotj1j
        POwYF800kWyIH5OD4SwxKapZxA==
X-Google-Smtp-Source: ABdhPJzgBzQWSr2D4+U7G5+bpWCHEe1NvZiCfdgtSBEb7tujbik5p4m+nzNhcIrWlB5OaqaYrTvn/g==
X-Received: by 2002:aed:374a:: with SMTP id i68mr13541190qtb.69.1589755993539;
        Sun, 17 May 2020 15:53:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id h134sm6953233qke.6.2020.05.17.15.53.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 May 2020 15:53:13 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jaS9g-00088J-O2; Sun, 17 May 2020 19:53:12 -0300
Date:   Sun, 17 May 2020 19:53:12 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 03/10] IB/uverbs: Extend CQ to get its own
 asynchronous event FD
Message-ID: <20200517225312.GA31145@ziepe.ca>
References: <20200506082444.14502-1-leon@kernel.org>
 <20200506082444.14502-4-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506082444.14502-4-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 06, 2020 at 11:24:37AM +0300, Leon Romanovsky wrote:
> From: Yishai Hadas <yishaih@mellanox.com>
> 
> Extend CQ to get its own asynchronous event FD.
> The event FD is an optional attribute, in case wasn't given the ufile
> event FD will be used.
> 
> Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  drivers/infiniband/core/uverbs.h              | 18 ++++++++++++++++++
>  drivers/infiniband/core/uverbs_std_types_cq.c |  9 ++++++---
>  include/uapi/rdma/ib_user_ioctl_cmds.h        |  1 +
>  3 files changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/core/uverbs.h b/drivers/infiniband/core/uverbs.h
> index 55b47f110183..7241009045a5 100644
> +++ b/drivers/infiniband/core/uverbs.h
> @@ -293,6 +293,24 @@ static inline u32 make_port_cap_flags(const struct ib_port_attr *attr)
>  	return res;
>  }
>  
> +static inline struct ib_uverbs_async_event_file *
> +ib_uverbs_get_async_event(struct uverbs_attr_bundle *attrs,
> +			  u16 id)
> +{
> +	struct ib_uobject *async_ev_file_uobj;
> +	struct ib_uverbs_async_event_file *async_ev_file;
> +
> +	async_ev_file_uobj = uverbs_attr_get_uobject(attrs, id);
> +	if (IS_ERR(async_ev_file_uobj))
> +		async_ev_file = attrs->ufile->default_async_file;

READ_ONCE here too

Jason
