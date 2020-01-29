Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1D314D214
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jan 2020 21:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgA2Uts (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Jan 2020 15:49:48 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:39313 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgA2Uts (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Jan 2020 15:49:48 -0500
Received: by mail-qv1-f68.google.com with SMTP id y8so387226qvk.6
        for <linux-rdma@vger.kernel.org>; Wed, 29 Jan 2020 12:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/WuxeSHPMUMjeirT86dy7cIK9BrCOZjzI0RHtenOVKU=;
        b=kP7kpBwPc6eE8zuPA/GdJocEjnboshBsuI47pT3xBoSKGA0ws+8mk89JRdG/BLIV4m
         cWYUWJwwl2plQDeFsFULMidSokXt6q8leWVb5r98Ix4s7LOOEMPpa2NrIH5jDMOOz4xr
         02h/Vom4oTkiXcdh2JW+p3N7peRyNH1YhxR7WAig69VG6mAtGLgKkCZ1yCs8oVWUoH7K
         KgVWknXzams5W0gKAybesOdW6nZAockHzhFY69OViyQTtr+qV9FQ0PIMp5oA1Dx8ptzY
         c1Z3JabARuxWGwLcQDF5Vm02fUcfD2C2cPudWJhE39QTjHJqDchEhRnZLwKuB0cFKaFT
         uCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/WuxeSHPMUMjeirT86dy7cIK9BrCOZjzI0RHtenOVKU=;
        b=boDUsHTzYFNsmtwCKXhAvomKnvI8pBlCHAWHXj/43YORFF+PDwKZJiKu3Jq1HeN3RM
         1J/O1umILBjSYHXu/wWO4Lx0J42uhJ3RqO2ANeFPl0ZmRTL0zwUL98RGQJ3XRBNi7vev
         Os/yf/rFDguGZNchA+9ytTRoWD/tqGspCu8JcXpl1d+E0OMRn4IrIaczLmAOcGW7AHOk
         A6bjEFgcvGBovBiSrn923fktsTMfhwQYnCX11KNik3DFT8a+bYgDW5uqIabl6SpS61GL
         QCCC0aktaonmwOUvhxqDDiRA67R1l4Sllf5PcE2Ln+hVHH6OgfyRRuGKxoTRvR3nGcwW
         jMmw==
X-Gm-Message-State: APjAAAVvFGWjSTOYntNDAy861iES84737X02zccDiK19wZD2dmJpM8k2
        WGBjn8VD74keknLKh2H2PHfaqetH74A=
X-Google-Smtp-Source: APXvYqxQF9jChaD8VWt1gLD0ATm3wPdHaE+LG6n+xDjsYpZ420pbyOINwqOsGhE6h3Hax7aP3pMq8A==
X-Received: by 2002:ad4:58b3:: with SMTP id ea19mr1052831qvb.80.1580330987851;
        Wed, 29 Jan 2020 12:49:47 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id t37sm1763552qth.0.2020.01.29.12.49.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Jan 2020 12:49:47 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iwuHS-00046J-A8; Wed, 29 Jan 2020 16:49:46 -0400
Date:   Wed, 29 Jan 2020 16:49:46 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>
Subject: Re: [PATCH for-next] RDMA/efa: Mask access flags with the correct
 optional range
Message-ID: <20200129204946.GA15677@ziepe.ca>
References: <20200129071803.40117-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129071803.40117-1-galpress@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 29, 2020 at 09:18:03AM +0200, Gal Pressman wrote:
> The uapi value IB_UVERBS_ACCESS_OPTIONAL_RANGE shouldn't be used inside
> the driver, use IB_ACCESS_OPTIONAL instead.
> 
> Fixes: 86dd738cf20c ("RDMA/efa: Allow passing of optional access flags for MR registration")
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa_verbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
