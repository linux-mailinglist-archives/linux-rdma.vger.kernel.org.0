Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6126013CD22
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jan 2020 20:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgAOTbT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jan 2020 14:31:19 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45873 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgAOTbT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jan 2020 14:31:19 -0500
Received: by mail-qt1-f193.google.com with SMTP id w30so16769104qtd.12
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jan 2020 11:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vs5fXx1YPRmInM+lAByPuWeVhzmRU0igfNAFxCeFiww=;
        b=kZX19/MkLh7Xlfpm3/z6XdTjbOUjoOQo+mNq+YiFXSC0+nIwRCsdIPTP4P0W2e6ge3
         O3ASBYLAWclR7fF51UInI2FNJv/K6lDf1EpjnIHAt3zd1lpt4hruNeAFVC/X0X3rrNdZ
         b94lf1XHm7P/Ny4FU5SJ4+efuFaXwkg4CnLJ7C5jtV2QaaqKv3ehUvwhdIxl0yBobK0Q
         DlwaWp9m3iTgM8lnErmZC6Me8qN/VQ8dFdTYznWvGiAfGG3Dq+7fjpQq3jeM/u+EiSXd
         XHmQUFWrwUPgXfJkDzd5X9hnY5ZmaDX2wglS6w9QQXxElx1KCc2L29BtmPlLWT2hCOqO
         QydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vs5fXx1YPRmInM+lAByPuWeVhzmRU0igfNAFxCeFiww=;
        b=LxJThe8rU7cEbOkP42uXiCjeI+7MdhKeJ4vJOUi/9GpdZNpYT3ifx901MtzhyV0ebo
         pcJ/C3U1+eNzrSl0FEmOn9Kjq5i2ygDOIj+BuHUUTVvDzlH9bvaxMLVcadDNW62ShyYk
         KLcIhmhGx1vsOnoLWxlmqz5MwJxSZNkwaSbFlMO5aZhtH9qRCxVY8TjNYhHDQ0RrcktE
         17/GC9JfBwo/IEjqH5OjOZSLYyZjbBmn6mKgHF+Sq6innLE2iPMMRbp3Go90m1NqQ28j
         SUw9Eu8gIkyeuZxFuEW6Fg6IXzIHtxp/fBGSHoyMUILCn8hp9sEp8kRilvDe5Dlx03cN
         WT/Q==
X-Gm-Message-State: APjAAAWFZqISGGVHVJ2cuna9aJGqBErThx7BOyBzBYNiQumdqfFYZOKM
        sIOIGY/qPDr+WRhC3785COpctg==
X-Google-Smtp-Source: APXvYqzzfT8xl7zmF9JPIgttA0ym2CRQENHTsLyoyIOnXcBhL6pTTyIINNPzeAFhpegnlFG5Z2Ow6Q==
X-Received: by 2002:ac8:478a:: with SMTP id k10mr192723qtq.260.1579116678359;
        Wed, 15 Jan 2020 11:31:18 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id g18sm10150975qtc.83.2020.01.15.11.31.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Jan 2020 11:31:17 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iroNp-0006a6-0b; Wed, 15 Jan 2020 15:31:17 -0400
Date:   Wed, 15 Jan 2020 15:31:16 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Daniel Kranzdorf <dkkranzd@amazon.com>,
        Firas JahJah <firasj@amazon.com>
Subject: Re: [PATCH for-next 1/6] RDMA/efa: Unified getters/setters for
 device structs bitmask access
Message-ID: <20200115193116.GA11226@ziepe.ca>
References: <20200114085706.82229-1-galpress@amazon.com>
 <20200114085706.82229-2-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114085706.82229-2-galpress@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 14, 2020 at 10:57:01AM +0200, Gal Pressman wrote:
> diff --git a/drivers/infiniband/hw/efa/efa_common_defs.h b/drivers/infiniband/hw/efa/efa_common_defs.h
> index c559ec08898e..845ea5ca9388 100644
> +++ b/drivers/infiniband/hw/efa/efa_common_defs.h
> @@ -9,6 +9,12 @@
>  #define EFA_COMMON_SPEC_VERSION_MAJOR        2
>  #define EFA_COMMON_SPEC_VERSION_MINOR        0
>  
> +#define EFA_GET(ptr, type) \
> +	((*(ptr) & type##_MASK) >> type##_SHIFT)
> +
> +#define EFA_SET(ptr, type, value) \
> +	({ *(ptr) |= ((value) << type##_SHIFT) & type##_MASK; })
> +

Why not just GENMASK properly? You don't need MASK and SHIFT, it is
supposed to be written like:

  #define EFA_ADMIN_REG_MR_CMD_MEM_ADDR_PHY_MODE_EN GENMASK(8,7)

  *ptr |= FIELD_PREP(val, EFA_ADMIN_REG_MR_CMD_MEM_ADDR_PHY_MODE_EN)

FIELD_PREP automatically deduces the correct shift.

And it would be much nicer if this had some type safety.

You should review the stuff Leon is prepping here:

https://github.com/jgunthorpe/linux/commit/453e85ed7aa46db22d8be16f9b0c88b17b8968af

Which is basically doing the same sorts of things, but with better
type safety and no need for the various structs

Jason
