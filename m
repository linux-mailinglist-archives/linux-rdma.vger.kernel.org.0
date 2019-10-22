Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44420E0AD7
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 19:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbfJVRmb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 13:42:31 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41975 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbfJVRmb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Oct 2019 13:42:31 -0400
Received: by mail-qk1-f194.google.com with SMTP id p10so17049097qkg.8
        for <linux-rdma@vger.kernel.org>; Tue, 22 Oct 2019 10:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gkeh9SXr2W/e0d/g6gOQoAJngpnGHvNbt25Adv2nDyA=;
        b=J1ud/+VTA4mBP9KsI/BEYsYsFpq5vdsH2zlZE4wcAGMR+XXOvli7YhMZNgS0cVNsmO
         HrlLhS7gdwodoByMTCBJTDiNkvMDgonB5UXFhypFVHAXJtx0Bkn5uNVTc5jaXVHZxE7v
         7m7cTh95J0auoveA4XtlZu0mS0JYWlMdmZZZXDhEHpF6iRXw2fHRqQt6nxYjkji/CLFz
         /QX9ER8GtWRQz+iaLi55ARSAAMd8hYzhn9WzY+ADNRJywk0l6iQpjZ0PF8oSdud7Ky/f
         jS5kocl49x36ie/wrXwD3a3JwcJSej128enzFNLKINbnGZtj5G2NVNH4qOLylL4ucZSy
         xscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gkeh9SXr2W/e0d/g6gOQoAJngpnGHvNbt25Adv2nDyA=;
        b=nuX3XWMZZwl7o9DsP+H/9jkXhppeTPe0BI7D3RPEBhg+rUTJD6vq+8sTurv6+ktUxF
         9mbEoieOtDBAAih9AgzWrLlpEiiBWmvgHg8Tgrn+k0/tUxPuQS6KZ+/9GdXbr1H8yZf4
         mLk8//GSyd0oaNUa9oExut34ZhRsmepUxarNfS83quWyF5oKeQteA7heZcv+Xmcw9rwl
         XWAVBikPgnYOOSAZZSxtMq29JeFrb7KXjNlD91vlha9I2fG2A30OmmlqVGfkjlSmAotN
         vZY9cZCfp99P1G4wPBWR2H+0j1s2GjS7twUqbw+xZcIrndww2GIapkjThcVP3c1YSJwi
         vQ7A==
X-Gm-Message-State: APjAAAVguoIKHV0/31QsE7kfvF3J7ziMZxguzeaaEnE/BDgIFNkmJ3kd
        f2vpWe7HmXMX1tF3QhR1PSIJdw==
X-Google-Smtp-Source: APXvYqyNGe52mC3C1CtBUXMYilijRoJ4kPAIEvAuvYC+PJQx5sWz3FTJJUaHusEPOLdLQ9bZHbmfXA==
X-Received: by 2002:a37:bf05:: with SMTP id p5mr4099896qkf.111.1571766149903;
        Tue, 22 Oct 2019 10:42:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id x64sm1881486qkd.88.2019.10.22.10.42.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Oct 2019 10:42:29 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iMyAu-0006VF-P2; Tue, 22 Oct 2019 14:42:28 -0300
Date:   Tue, 22 Oct 2019 14:42:28 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Yamin Friedman <yaminf@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        linux-netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH rdma-next v2 0/3] Optimize SGL registration
Message-ID: <20191022174228.GA24923@ziepe.ca>
References: <20191007135933.12483-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007135933.12483-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 07, 2019 at 04:59:30PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Changelog
> v1->v2: https://lore.kernel.org/linux-rdma/20191007115819.9211-1-leon@kernel.org
>  * Used Christoph's comment
>  * Change patch code flow to have one DMA_FROM_DEVICE check
> v0->v1: https://lore.kernel.org/linux-rdma/20191006155955.31445-1-leon@kernel.org
>  * Reorganized patches to have IB/core changes separated from mlx5
>  * Moved SGL check before rdma_rw_force_mr
>  * Added and rephrased original comment.
> 
> -----------------------------------------------------------------------------
> Hi,
> 
> This series from Yamin implements long standing "TODO" existed in rw.c.
> 
> Thanks
> 
> Yamin Friedman (3):
>   net/mlx5: Expose optimal performance scatter entries capability
>   RDMA/rw: Support threshold for registration vs scattering to local
>     pages
>   RDMA/mlx5: Add capability for max sge to get optimized performance

Applied to for-next with various fixes from Christoph and Bart

Thanks,
Jason
