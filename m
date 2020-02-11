Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C54EA1598B2
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Feb 2020 19:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgBKSdY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Feb 2020 13:33:24 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43541 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbgBKSdX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Feb 2020 13:33:23 -0500
Received: by mail-qk1-f194.google.com with SMTP id p7so6120800qkh.10
        for <linux-rdma@vger.kernel.org>; Tue, 11 Feb 2020 10:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yIiBZZRP3GFtb/gGB6eUs7NkWc9A+FfQqnw3+mQCK+M=;
        b=c2ZUh8wug1t5bpsmCWWUMMJBe65jCK/kF7K4dAjt8vLpIKyd8k1ZM8abSUgCLKhdDV
         cgnyKRMqYA6QJ4KLx8mzRQwVTwRZ1mcgV9i4xvyLqoRrTHqEYA3M5pPQJMs62dC/LmAN
         s0uv1x/RkflZ27YovYNlCltrIbeUm8k6B04D3nDhXCDqukPGGj9rNdKLIu+R7/Gl9E57
         5PDjKDvQymaxX9EBEaxR47avwr+8x7/o6sS8hdCDqrzhpqwaYs3XXfeV7PKfEYoKTTI9
         cvzivuk9BimmFyNfni6IbEoFKOBRj5S/A0kC1Pu0cmZfpFHjmfou2BxMZOjhzX6iFdEx
         gwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yIiBZZRP3GFtb/gGB6eUs7NkWc9A+FfQqnw3+mQCK+M=;
        b=YOwFYywBP+Y9BXpF2arSkzivnSFoO38vToZeBL4LTVwsDKKYAr3r8hlsZNZ0Tk0qo9
         8Zw1H853C3ju9Qx9iIg8sL/OZIQx5xtr7gMluKJID5vPXBIIxPxu1WyhLjQ70rIG93GA
         iwc+I2a8I1znTGTXAX0sgQWNPh9KTmJx3bwafrjg7On+oMhH2JP5hc2IJDjeVpAG+eUK
         7PcSwayzFF6hWS8SZGcOcT5EQCTphS9ZDcfouJoWAxnpuBpeSoBGxxAhUGuo9gyzMObM
         Yz1lnfxkdj/5QGo29NJ6+sluYUQSxwhV88y+TzVJJyp0knbBahYq1/U+P+tg/cFBorR0
         Tt3A==
X-Gm-Message-State: APjAAAU6SZk529V3qeqgL5zSX98FSMeI2+DOZ0RwzkH8AXbl7qodbrwL
        IYFLjkoEsX3FfT0bThzC3hQrTQ==
X-Google-Smtp-Source: APXvYqxm9uo7u4na9qntBirCV7mkCCszW/KcNApvqQsHTGm1LOvfPOHKGS6A1pHq0hZ0XXUYF3Wk5g==
X-Received: by 2002:a05:620a:b19:: with SMTP id t25mr7681403qkg.82.1581446002978;
        Tue, 11 Feb 2020 10:33:22 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id m54sm2627512qtf.67.2020.02.11.10.33.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Feb 2020 10:33:22 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j1aLa-0003mI-5u; Tue, 11 Feb 2020 14:33:22 -0400
Date:   Tue, 11 Feb 2020 14:33:22 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: Re: [PATCH for-rc] RDMA/siw: Fix setting active_mtu attribute
Message-ID: <20200211183322.GA14491@ziepe.ca>
References: <20200205081354.30438-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205081354.30438-1-kamalheib1@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 05, 2020 at 10:13:54AM +0200, Kamal Heib wrote:
> Make sure to set the active_mtu attribute to avoid report the following
> invalid value:
> 
> $ ibv_devinfo -d siw0 | grep active_mtu
> 			active_mtu:		invalid MTU (0)
> 
> Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> Reviewed-by: Gal Pressman <galpress@amazon.com>
> Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/sw/siw/siw_verbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This isn't really rc worthy as it has always been broken

Applied to for-next, thanks

Jason
