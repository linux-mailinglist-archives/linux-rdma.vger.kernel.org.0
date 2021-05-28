Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2F739428E
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 14:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbhE1MfN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 08:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235257AbhE1MfM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 08:35:12 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01324C06174A
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 05:33:37 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id k19so2558275qta.2
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 05:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dCwmtT3nAJcd/Sp1I1Kz+m3ClrU0NO8l36foJnmNqH4=;
        b=bMgOqXMmhuJdpkD1fs82u9R6Bxag7whV1pmx9uhNJXypbHElfeqxbyaALqfc+Pa6GS
         YKcJtX0N0MSKqdCOfZfW5yLo/ChdCoj6PbiKmgvZrOuOY+6jqjfXYp3/X1XUeVB49EIA
         S9PZV0qIOUrwdB2S9iqlX9eigbTBVEa8i1CrFjH0iYJqCGSozv/GGLtC6TL4XzUEIx1u
         PRdho5CY4BACwwIuIUtmdSLjUwaV1YdAdhWvYFl0blYzQPOOKo/W1r7YO2ULvB27LaHV
         MV8+JK4nQ6XSx3nEfKYVlNaxVdjkBpqy15HX9psk4rmHgcOXNJBmG8mtd9UdkGfpcAQA
         WS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dCwmtT3nAJcd/Sp1I1Kz+m3ClrU0NO8l36foJnmNqH4=;
        b=bMGY+NPqnJVce9wkllj6RKh6X/UrZI5KIDfJMx29mS3SmCXLkh1UoSGZh/dA/FfQRg
         iUAIqNa8juxAfjYha/P97D3ch7Lw4ZEhXX6GQl9L9KkJaco/QKNzKX/Y0SpqkKjnQG23
         MXExdduP5q0qTmOmsqgkoHu1w0k64OfCUTgm9eG9rRBVwG8mh6OOs0aKCNMJaX+x2WLP
         jTAklzIAIlZMTpmdngr+yFMi8c+F36p1k88BSpL5EEOstk73CE5nL+lgzgj1Se9Vv9xq
         r+nGefj0x3a4igL5w8D1OgtW9DwkfZ9fWxy3fK4rvcI6iIxTJ4gByDNFt+CK+4g8H3vH
         zrqg==
X-Gm-Message-State: AOAM5335LIl8KMJjH96ekeZidh6awvgRayd51XNJqO2lJRo6aK2e140a
        Ta46oawETnbKMcXM49UBqavObg==
X-Google-Smtp-Source: ABdhPJwV+8Zujs8IRRSkIAsKUwAGjuV7oJN16GpjqiO308TPIXAlHan8NQfr/MDgRi+yrVF+4Monhw==
X-Received: by 2002:a05:622a:18e:: with SMTP id s14mr3249722qtw.200.1622205215536;
        Fri, 28 May 2021 05:33:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id p17sm3402867qkg.67.2021.05.28.05.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:33:35 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lmbgE-00Fw7P-5G; Fri, 28 May 2021 09:33:34 -0300
Date:   Fri, 28 May 2021 09:33:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     bvanassche@acm.org, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] RDMA/srp: use DEVICE_ATTR_*() macro
Message-ID: <20210528123334.GI1096940@ziepe.ca>
References: <20210528123039.10668-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528123039.10668-1-yuehaibing@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 28, 2021 at 08:30:39PM +0800, YueHaibing wrote:
> @@ -3040,22 +3040,22 @@ static ssize_t show_allow_ext_sg(struct device *dev,
>  	return sysfs_emit(buf, "%s\n", target->allow_ext_sg ? "true" : "false");
>  }
>  
> -static DEVICE_ATTR(id_ext,	    S_IRUGO, show_id_ext,	   NULL);
> -static DEVICE_ATTR(ioc_guid,	    S_IRUGO, show_ioc_guid,	   NULL);
> -static DEVICE_ATTR(service_id,	    S_IRUGO, show_service_id,	   NULL);
> -static DEVICE_ATTR(pkey,	    S_IRUGO, show_pkey,		   NULL);
> -static DEVICE_ATTR(sgid,	    S_IRUGO, show_sgid,		   NULL);
> -static DEVICE_ATTR(dgid,	    S_IRUGO, show_dgid,		   NULL);
> -static DEVICE_ATTR(orig_dgid,	    S_IRUGO, show_orig_dgid,	   NULL);
> -static DEVICE_ATTR(req_lim,         S_IRUGO, show_req_lim,         NULL);
> -static DEVICE_ATTR(zero_req_lim,    S_IRUGO, show_zero_req_lim,	   NULL);
> -static DEVICE_ATTR(local_ib_port,   S_IRUGO, show_local_ib_port,   NULL);
> -static DEVICE_ATTR(local_ib_device, S_IRUGO, show_local_ib_device, NULL);
> -static DEVICE_ATTR(ch_count,        S_IRUGO, show_ch_count,        NULL);
> -static DEVICE_ATTR(comp_vector,     S_IRUGO, show_comp_vector,     NULL);
> -static DEVICE_ATTR(tl_retry_count,  S_IRUGO, show_tl_retry_count,  NULL);
> -static DEVICE_ATTR(cmd_sg_entries,  S_IRUGO, show_cmd_sg_entries,  NULL);
> -static DEVICE_ATTR(allow_ext_sg,    S_IRUGO, show_allow_ext_sg,    NULL);
> +static DEVICE_ATTR_RO(id_ext);
> +static DEVICE_ATTR_RO(ioc_guid);
> +static DEVICE_ATTR_RO(service_id);
> +static DEVICE_ATTR_RO(pkey);
> +static DEVICE_ATTR_RO(sgid);
> +static DEVICE_ATTR_RO(dgid);
> +static DEVICE_ATTR_RO(orig_dgid);
> +static DEVICE_ATTR_RO(req_lim);
> +static DEVICE_ATTR_RO(zero_req_lim);
> +static DEVICE_ATTR_RO(local_ib_port);
> +static DEVICE_ATTR_RO(local_ib_device);
> +static DEVICE_ATTR_RO(ch_count);
> +static DEVICE_ATTR_RO(comp_vector);
> +static DEVICE_ATTR_RO(tl_retry_count);
> +static DEVICE_ATTR_RO(cmd_sg_entries);
> +static DEVICE_ATTR_RO(allow_ext_sg);

can you also organize this so the ATTR's are placed after their
functions, as is normal?

Thanks,
Jason
