Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC2FD3021B
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 20:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfE3SnE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 14:43:04 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33278 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfE3SnE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 May 2019 14:43:04 -0400
Received: by mail-qt1-f194.google.com with SMTP id 14so8307167qtf.0
        for <linux-rdma@vger.kernel.org>; Thu, 30 May 2019 11:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VBqnOCwAufhv1CAkJNFrNgoB3p+UUmETtTsgShdBDzI=;
        b=ZirqxKHDbcQyX/wT2VcnFrxa+MadSKmLIeFPmm2qePE5jPeAY/tkaSbtoTcSPBLUw1
         XQonZZ052/RP/N5oXy86+rOYc2mKXcVbAy9HK6QsppaNYGas1F5w2UMmkGazwJ6z3UiL
         OiW0BCXPfNlvKpvkIVdU4Qb92nnZ5gd/Xva4mPHOzx0Iv650aNoU21Pzv7wKxI6D5GVc
         cTSE7p1jhfP0K+fwDT397eJl0KfLMh5YA7b+axJ0DknCvs/c9/TqohpHrU3+jhLCXKZE
         69LjcttrxDXLYnTfItzQsUAyLFzkktCWrORihZZXgdks18qJv6JXx6ey8m7K18UQs+jy
         nOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VBqnOCwAufhv1CAkJNFrNgoB3p+UUmETtTsgShdBDzI=;
        b=myf0WOIbWeCblCO5hPGyXD16Jb96snju911EOTyLbHwA+CtXE/Idv3WyKu6kWZHDIj
         wwHsn9LWAYTgcUkRaRmWV+qjbLLcwcyiWS+HM7KkNV5CWuB+XQfi5rYtN1/dfsW956Zp
         i5q48s46Bv7uGmekqT6zHK935uCIgVu30PWxGBRXrJQN3sEu+IfV+ScjW/A0yJzh7+B+
         yPscs87ExPPLJD6cMQKJFuIHm5CF4SDvsxOWIrbHEOQYJ1CaWajeUYOLDikeOVDw2enR
         /hAHO5mSFw0Dg6qRMUqBOBgg9vy8N7pBxVgVxxx4Y2tx1jefjmmM4yRUdqUelhCo6Lb0
         n9fQ==
X-Gm-Message-State: APjAAAXuyQeojoyZtBHW+qn5X49d7jXjawekNM0rhi0dCaCxTn0rotyJ
        GDphTPpv2WfsWqIAzIuSheAUug==
X-Google-Smtp-Source: APXvYqwPw3ZZtX5hJ8gOZ8HYrYQCfzjrvzRdC+YXqEmilsw9jjKKngQZluuntDNPMp/bLHSIhiaPrw==
X-Received: by 2002:ac8:2291:: with SMTP id f17mr4973765qta.51.1559241783221;
        Thu, 30 May 2019 11:43:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id v186sm2093104qkc.36.2019.05.30.11.43.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 11:43:02 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hWQ10-0007jq-6J; Thu, 30 May 2019 15:43:02 -0300
Date:   Thu, 30 May 2019 15:43:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] IB/rdmavt: Use struct_size() helper
Message-ID: <20190530184302.GA29724@ziepe.ca>
References: <20190529151248.GA24080@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529151248.GA24080@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 29, 2019 at 10:12:48AM -0500, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes, in particular in the
> context in which this code is being used.
> 
> So, replace the following form:
> 
> sizeof(struct rvt_sge) * init_attr->cap.max_send_sge + sizeof(struct rvt_swqe)
> 
> with:
> 
> struct_size(swq, sg_list, init_attr->cap.max_send_sge)
> 
> and so on...
> 
> Also, notice that variable size is unnecessary, hence it is removed.
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> ---
>  drivers/infiniband/sw/rdmavt/qp.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied to for-next, thanks

Jason
