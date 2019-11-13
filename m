Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43A8DF9F29
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Nov 2019 01:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfKMARd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Nov 2019 19:17:33 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39765 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKMARd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Nov 2019 19:17:33 -0500
Received: by mail-qk1-f193.google.com with SMTP id 15so206216qkh.6
        for <linux-rdma@vger.kernel.org>; Tue, 12 Nov 2019 16:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l9sfFI6vcgdULd6f//Ok5CXLOt/mIwEInCUB6t6X5bE=;
        b=iY4Sonf0BE1vTQIrgRydDzqoIapSp/M4u5zF97j9C93wyE2Q3bhHM1ZRl7d72eqYjs
         xZXlzLZVFv8BUvDpensar/QsHDyXVEpXRnJ/p+nFiNDWwQ+WRZ3K6gsHWrB169ar8+gF
         SY6NEVKxFGtaR2bMLp9ukpvq8RIMG/s4mEqfo18RUg148JjMO1zHVJP25jZ52+2h8MoX
         /W1WuWb+bWsXppB/oS45owu8AO3Lm2YIhv/0fXg5qd4wrweGs7KwehGfb87++FCN412U
         95aqBiDrywVoinJFo75WQgtwu/sq9bQt6z5XfPDYbLkfCjYtOxns/Va1YlisyCqGkMLy
         SeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l9sfFI6vcgdULd6f//Ok5CXLOt/mIwEInCUB6t6X5bE=;
        b=b+h6pEwt9xFYVJ4vz7O80zB5gskd7kxVjcAxUi8rUXmMA5na+/Hl4flG1R5wHWFcXd
         lZiyIYh9AfssNZ61CvJVy8FCfE1SPtKdkU2G9e2mwoemGXN5D7oAzdiDjQ071st7FVys
         T5tLgqiLHFQkUlCPtG7+XnP9oI/CO6kYobr52h2aeqFXtlrWtmXiX7nS1YF9kE4prfAc
         etZh+NpldAtGixh0yzLu5LCUdxIRHkoLJgGuodUd0Q8u0DhxmZidrt2Irpe1dYi3GoxN
         aoAl8nscekMSy0Xqh0ZKnkoIwkt+5u3MUO0nV19F8FJqOSG9WzBBMLvAWgZRqyUK3vyt
         zp8w==
X-Gm-Message-State: APjAAAV2kTbT5h0RgbLAyCdhzDT1NyOZLQwhlp/l9idqihUNlfsZNs7B
        d+76Q0BwyjUrWLocZgJtYK9w3g==
X-Google-Smtp-Source: APXvYqyxA8yswYi2dNgYZ3Hin03W/9tG4it1a34S8DZUsJswxVXPn9SbyKo9470Vl+FDUImXIp6y2Q==
X-Received: by 2002:a37:98e:: with SMTP id 136mr198809qkj.184.1573604252086;
        Tue, 12 Nov 2019 16:17:32 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id l93sm257683qtd.86.2019.11.12.16.17.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Nov 2019 16:17:31 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iUgLi-0007Se-Mk; Tue, 12 Nov 2019 20:17:30 -0400
Date:   Tue, 12 Nov 2019 20:17:30 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Daniel Kranzdorf <dkkranzd@amazon.com>,
        Firas JahJah <firasj@amazon.com>
Subject: Re: [PATCH for-rc] RDMA/efa: Clear the admin command buffer prior to
 its submission
Message-ID: <20191113001730.GA28611@ziepe.ca>
References: <20191112092608.46964-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112092608.46964-1-galpress@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 12, 2019 at 11:26:08AM +0200, Gal Pressman wrote:
> We cannot rely on the entry memcpy as we only copy the actual size of
> the command, the rest of the bytes must be memset to zero.
> 
> Fixes: 0420e542569b ("RDMA/efa: Implement functions that submit and complete admin commands")
> Reviewed-by: Daniel Kranzdorf <dkkranzd@amazon.com>
> Reviewed-by: Firas JahJah <firasj@amazon.com>
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa_com.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

This is quite late in the -rc cycle for such a vauge description. What
is the user visible impact of passing non-zero memory beyond the
command length?

Jason
