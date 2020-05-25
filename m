Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C451E0F06
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 15:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390701AbgEYNDn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 09:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390639AbgEYNDn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 May 2020 09:03:43 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BE8C061A0E
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 06:03:42 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id e16so7812380qtg.0
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 06:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l8DtLHa85gJVAwQ0kwg15axaycizXM27g5I12GoSRmo=;
        b=TQHZ1bseJ27nGYaagMlYvaDubSiL2Uit4y2PJfMQznPas6SqYWT9TulWbeGas5mJ9v
         2yytZorNLW6P6j4w5oYubQzVbRge+VdVCBHL7HlqQXXFNNLjq9NYzmLUNfVOEAUNGgLz
         1oWKuiBoq9InlofxCd75JtdreffEadOMEM3MmiJBZWuSzbLkWS8BcmYMeNdidRkFV28t
         KdmyLWruCFvuGTI2xuxUFYhycaGjGvROPZE1pcZBIsQA4tVGgLQvZEytnjQ/+QpS2TSP
         7R+HtJoBYF5Cg93n5Hm35ytWNR0ocSGcr4KG/IIk4vFz2X+VE2T+ZYZKqWE1BuGGx8Hy
         Cbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l8DtLHa85gJVAwQ0kwg15axaycizXM27g5I12GoSRmo=;
        b=uhaX2o37RVX/dgQ4Qx72dWvdU040fjWmyhYkyb037Cpk42r8jTQsU39OAHKXUoRR61
         BR1pEvBHB6N7Szi2BzKmwnCgsP/fC8pOXddImxnoiwIiKgCD6LS9BgCgzlihuKfu0E2u
         1GGdienL6YCJk4OeT+WP8m4cpTO7MI+633zZdELmy/qlqPOVaEWueE/vB93tkPFwnl/2
         AwDtgXOMonq3XzEMjNPLVCZVSf7bpzoHnwvJB2dccVNCmFZqPKmOvS5YxVokSYsB4Co/
         PWqLr9IE+4koqOtUZlwrcpgaE7qh82YuuOTZoeYHjG8LNBv5xYS9RuCWpdajG8ob/7mw
         YbCw==
X-Gm-Message-State: AOAM5301Nmz5InBskKvPsF0VB+WyK1ge0vZ44zLD9CvGo/e2JrkTl/Q2
        Us6D8tSSLXZCR+yka3EYxRNn0Q==
X-Google-Smtp-Source: ABdhPJyZ4IT+0r7ySKwikREH5gDy81VkOMFbpJ1aybPDtbwvirwWq0ysKv73Xy77i+ZrWhpQ00H17A==
X-Received: by 2002:ac8:6e82:: with SMTP id c2mr28826003qtv.155.1590411822178;
        Mon, 25 May 2020 06:03:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id x205sm14649646qka.12.2020.05.25.06.03.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 May 2020 06:03:41 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jdClY-0008JS-Mx; Mon, 25 May 2020 10:03:40 -0300
Date:   Mon, 25 May 2020 10:03:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     wu000273@umn.edu
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kjlu@umn.edu
Subject: Re: [PATCH] RDMA/core: fix missing release in add_port.
Message-ID: <20200525130340.GD744@ziepe.ca>
References: <20200525060656.2478-1-wu000273@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525060656.2478-1-wu000273@umn.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 25, 2020 at 01:06:56AM -0500, wu000273@umn.edu wrote:
> From: Qiushi Wu <wu000273@umn.edu>
> 
> In function add_port(), pointer p is not released in error paths.
> Fix this issue by adding a kfree(p) into the end of error path.
> 
> Signed-off-by: Qiushi Wu <wu000273@umn.edu>
>  drivers/infiniband/core/sysfs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
> index 087682e6969e..04a003378dfc 100644
> +++ b/drivers/infiniband/core/sysfs.c
> @@ -1202,6 +1202,7 @@ static int add_port(struct ib_core_device *coredev, int port_num)
>  
>  err_put:
>  	kobject_put(&p->kobj);
> +	kfree(p);
>  	return ret;
>  }

Er, no, kobject_put does the kfree

There is a bug here, it is calling kfree() after kobject_init_and_add
fails, which is wrong, it should be goto err_put

Jason
