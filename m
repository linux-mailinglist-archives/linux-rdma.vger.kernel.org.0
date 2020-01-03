Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5E012FF09
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Jan 2020 00:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgACXPO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Jan 2020 18:15:14 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43102 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgACXPO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Jan 2020 18:15:14 -0500
Received: by mail-qk1-f196.google.com with SMTP id t129so35033915qke.10
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jan 2020 15:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qabfElZawubmiTn3lWvfvnUUjTSazMGT9ZGfNt2qQok=;
        b=UMMXD7VoYLskFTV+kWNvLdkuHxvgjfEsZNnaiJJOrXKai/zPMLPz80CiZuacIyjWeA
         M1Hz8Tks6CvU2iIDNhnSBV3SXZeHxOvZnMOHLSsUDR8mX8x/AvBddOCRVYM9bdo67Hsp
         0NXXEOgtOWgdayPJMxC81TNOunMD0yLxsTOxOIcmM6tx3NXphHDeWVqUIJ5SVAD57jHW
         JyBCIOre0W73R6FlglfEod6tbO8WoAQvF/XO6B+EQrr+XCwJIPAZqQBe7o0o5W1UKwCk
         b+Vc9BP3H/4H6DZZcknlo4SQ46IurkmXl086rckOyjv6LoLS++LMAhpLl8AERthGzqWM
         2o8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qabfElZawubmiTn3lWvfvnUUjTSazMGT9ZGfNt2qQok=;
        b=D3eEOq0H2B3LhIAKFNYgWAxNby3SsDcsL/ouYphQUx0waM4nrIqkjCDQ8hjVWxzM0T
         U3k8XKlyf24DP/fzYeuApl6tVeyM6dYt03oafnivFDyca4YiP+/ocNioFHv4stOtNRO/
         WXboiLqD7PDJyvN7AHMQOQrw1ntUXsdXHBPoJ5CcvOwLwIJfcrfgFWHP7Kg5ff5rSI8r
         28RjMLBD7mR3/erx5mfA7GrvmGfyjlxaV6XOWVY3F4bOZdrpHa5q60sM8eOluYg4epkG
         S2l/jFPqdPaeaeC41ytMZaiW5ugzMC8CygsQiWyOP2Z5dezjtTxpLDNrnfO/kLaHrC8D
         WlFA==
X-Gm-Message-State: APjAAAWd0rR9a69IATaawPcD0CHe56dofppF4xYBa6V/B14FRwY7xJay
        M5oxb0Dm20V98obj47QRbwpc/A==
X-Google-Smtp-Source: APXvYqyUAzrTmk2KV9bxZqSiOC6x/KivWMvoIwrE3dEMSA60qZ4EAMru5wh68GlPExGf4+mxf0fTMg==
X-Received: by 2002:a37:8306:: with SMTP id f6mr73493699qkd.372.1578093313362;
        Fri, 03 Jan 2020 15:15:13 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id z8sm19170357qth.16.2020.01.03.15.15.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Jan 2020 15:15:13 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1inW9w-0007Dw-Ik; Fri, 03 Jan 2020 19:15:12 -0400
Date:   Fri, 3 Jan 2020 19:15:12 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     zhengbin <zhengbin13@huawei.com>
Cc:     bmt@zurich.ibm.com, dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 0/5] RDMA: use true,false for bool variable
Message-ID: <20200103231512.GA27516@ziepe.ca>
References: <1577176812-2238-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577176812-2238-1-git-send-email-zhengbin13@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 24, 2019 at 04:40:07PM +0800, zhengbin wrote:
> zhengbin (5):
>   RDMA/siw: use true,false for bool variable
>   IB/hfi1: use true,false for bool variable
>   IB/iser: use true,false for bool variable
>   RDMA/mlx4: use true,false for bool variable
>   RDMA/mlx5: use true,false for bool variable

Applied to for-next, but Leon seems right about the funny
relaxed_ird_negotiation that is never set, is that debugging or
something?

Thanks,
Jason
