Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D11C13710A
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jan 2020 16:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgAJPXM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Jan 2020 10:23:12 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:35796 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbgAJPXM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 10 Jan 2020 10:23:12 -0500
Received: by mail-qv1-f68.google.com with SMTP id u10so894704qvi.2
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jan 2020 07:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kq1o8lZAnTu+ZNVrQAO7Mll8aHoMgjZm4So5uavI1i8=;
        b=RRMPfRXlFL9Yy8bmunAl+vGZf8CAp0yOvyfMcXvNOxQe3Qpb+uKEwa2j4cBqLzqdkN
         VaVsx82eB9lNxU6Ow3xFUPB4yu/dywvuA0qMkCbkcFHkshUIKGefE/vUotCeDulvOANt
         HtFWyl+IWWbyed606+HnFXPPWgSwsgT/48peEt75PNVzrzdDfcDiQPi+OU9G2BHACy0t
         m7wThEa45Xmv8IePdOnM0SoRXreq3yzEfk1hhuzKNUJCBG8ljTPx5xpNAh0kkvv5Lm5W
         uY5DZiAKC9agqccBX4ho2WrHy5G+5igIsQeKdfecdP63l9ckVqUdFM/oI0P4dwkXCtNR
         H5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kq1o8lZAnTu+ZNVrQAO7Mll8aHoMgjZm4So5uavI1i8=;
        b=pessQF7COHpPeHskirRXgMAdHEMYSgfe3VN44f1Tm7K9fYc2Eq1SB5uzdxU+78a4Nc
         wVUwPNVIURQJms+LctZymQl4nHR6ar3N+GYAWyjV1QxBQ1YceJfRXnXLVzJap4zDyNiR
         Z/uJzykmqizzS8Z+G3uE/ZxX280qliIylaK8KtuLUEWE++uNO5uJ2gCUFrN2NjUwB1v5
         AvQ1qLNtj57tgoZGRN9A8MLdhCJUgIzEWrGtlFDFiFDLIu0A+nxDYtHPQAcWAakH2eIV
         GLDotDxT8PZxJiOm+PAYyv3SKIUvHKsd2AgONkCUwPk454fI+Xa6bgmoAKWrt8rDhQma
         5P8Q==
X-Gm-Message-State: APjAAAVxqtcmEbgvgQW7yFnkyoI8MSoyWY43G3PDIO1tNwv4fZ8cfjK5
        sGB1WFQLpS5qWwu7cLNw5O7YpQ==
X-Google-Smtp-Source: APXvYqylb7xxqMnCgjjxuGdI/lJ+9HzmCdER0bMdP3huSPJYT8bFzlow22Mk8+Zqmtva2Ab1tO3+HQ==
X-Received: by 2002:a05:6214:14a6:: with SMTP id bo6mr3312745qvb.8.1578669791243;
        Fri, 10 Jan 2020 07:23:11 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id o17sm1115029qtq.93.2020.01.10.07.23.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Jan 2020 07:23:10 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ipw7y-0003gv-22; Fri, 10 Jan 2020 11:23:10 -0400
Date:   Fri, 10 Jan 2020 11:23:10 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     jgq516@gmail.com
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: Re: [PATCH] RDMA/core: remove err in iw_query_port
Message-ID: <20200110152310.GA14152@ziepe.ca>
References: <20200109134043.15568-1-guoqing.jiang@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109134043.15568-1-guoqing.jiang@cloud.ionos.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 09, 2020 at 02:40:43PM +0100, jgq516@gmail.com wrote:
> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> 
> Since we can return device->ops.query_port directly, so no need
> to keep those lines.
> 
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> ---
>  drivers/infiniband/core/device.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

Applied to for-next, thanks

Jason
