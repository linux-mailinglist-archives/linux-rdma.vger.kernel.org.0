Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A703A13CD97
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jan 2020 20:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbgAOT6N (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jan 2020 14:58:13 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:36636 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729365AbgAOT6M (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jan 2020 14:58:12 -0500
Received: by mail-qv1-f68.google.com with SMTP id m14so7969723qvl.3
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jan 2020 11:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cCtEol5uz/R2NMsJlZc6CUVGHTrK4IzFRH37n7jvMqA=;
        b=mX50cwo1UDfO/aLmbb2inUlQk5hGyuRlJ+HegrriSKQEXWkdxTWh0AQdwU1l2g1Hsz
         OqtjyfVByESbswe+n6SXTd106xPtOs/s+ypPB0nskpxwDnsSFrlA6zhegnpvhwY+ctOx
         +YQYlHMyLdEQEqb/qldL9DSOtesBGH7cd9M3FN4KxeMVi8665d8gXjs1MThCUVd26+ci
         lqt+4/Yr6yyBwKCDVZTc+fSdsZLh194YcGFtIsQf80IlS/Ure1PJ7QRiSlB0IwBcOckH
         J2yOqEZTFyn4Jy9WT3jQe0SwD9FJBQqmbtbPpUjDYT/DQ4iN7IpuS6czRiLV2gT7QF6g
         U9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cCtEol5uz/R2NMsJlZc6CUVGHTrK4IzFRH37n7jvMqA=;
        b=auLvqyzl9N3c0VHD6N3wDZRr0xx2jm0l6Q46+F+e/bYTZsAvlEp8/fceicyfldzKrm
         7rmMww9q1lqbs0stgwzOG9KRP6RsJG38eUdBr+CZykDVrYRxokznmBrhHJbQImz/0Rl2
         R1CDSQaTdQtgSCoNzt1qbKLlB5MCbf/p889/01Nei08kSU2K72x8mZd+CcKcjXMvT7ev
         9i11hjM0FQ1ycpnUtUD9iHc0qwG4EfGeAUPOPUptVb3UwIMXIrn1aMQsh0aLH2G20vwg
         oecpXCf5toKb3/n4axDZRmGN1QAHyD7Ew2ra+mQDaFcTKBnJeNLB8W/2t1wcr9pf6Cx/
         VLSA==
X-Gm-Message-State: APjAAAVAjD7MoM99M4PlruqBKZ/DM+pJkvrAw5tPIAKwTdbj3ko3T9yE
        0/mbeDRgSAknTcTtXvXBzGJSzg==
X-Google-Smtp-Source: APXvYqx5H/pOZ3BuKUo77jxeCZgg7fZL1gVJC/JhzsHsdRdebuzvGReDgRKpP3Ubq+zhcyhpIB8LgA==
X-Received: by 2002:a0c:e58a:: with SMTP id t10mr23956092qvm.161.1579118290411;
        Wed, 15 Jan 2020 11:58:10 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id k21sm9820094qtp.92.2020.01.15.11.58.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Jan 2020 11:58:10 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ironp-0002Kz-Is; Wed, 15 Jan 2020 15:58:09 -0400
Date:   Wed, 15 Jan 2020 15:58:09 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>
Subject: Re: [PATCH for-next 0/6] EFA updates 2020-01-14
Message-ID: <20200115195809.GB929@ziepe.ca>
References: <20200114085706.82229-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114085706.82229-1-galpress@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 14, 2020 at 10:57:00AM +0200, Gal Pressman wrote:
> This series contains various updates to the device definitions handling
> and documentation, and some cleanups to the recently introduced mmap
> code.
> 
> The last patch is based on a discussion that came up during the recent
> mmap machanism review on list:
> https://lore.kernel.org/linux-rdma/20190920133817.GB7095@ziepe.ca/
> 
> We no longer delay the free_pages_exact call of mmaped DMA pages, as the
> pages won't be freed in case they are still referenced by the vma.
> 
> Regards,
> Gal
> 
> Gal Pressman (6):
>   RDMA/efa: Unified getters/setters for device structs bitmask access
>   RDMA/efa: Properly document the interrupt mask register
>   RDMA/efa: Do not delay freeing of DMA pages

These ones need some work

>   RDMA/efa: Device definitions documentation updates
>   RDMA/efa: Remove {} brackets from single statement if
>   RDMA/efa: Remove unused ucontext parameter from
>     efa_qp_user_mmap_entries_remove

I took these three to for-next, thanks

Jason
