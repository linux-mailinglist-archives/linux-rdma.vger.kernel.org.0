Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54CF214BF5A
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jan 2020 19:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgA1SPB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Jan 2020 13:15:01 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42810 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgA1SPB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Jan 2020 13:15:01 -0500
Received: by mail-qk1-f196.google.com with SMTP id q15so14306252qke.9
        for <linux-rdma@vger.kernel.org>; Tue, 28 Jan 2020 10:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6NuTNXWO0ym4VaqjgCO7gH9EZbIFKImdzLSG/W/0zDk=;
        b=K6pph56+i5n88BmRCj+yzDDoWQYmvDNUBg9ODCEzbO6GV6R99FEgypZEND6BhFvfqk
         PcYa2ARJsGktP8A00fJfOTJuAGl334cVQrmMofJ9qSfU0ahXHCHRMfKGemCtzpbIBv+5
         GFmYIeZL/RDK7h4PLvqRG+uac3FmiSxLEJtqloq3ks/sZJb9Z7AGrU3AERzkSGDMEdEf
         AS9OCwni8cMsqSpiwfWqXfrEdQJuPsjfZqZbx6nxUPSdIbRL5nk6/07gSeWfZYnFRVm1
         KbDaZRcn2xsk1htHOmobSdzqcxAAmWuEHLhsU8j9VequR6zT7VwDDeU1FzOZUGprb+B1
         FdMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6NuTNXWO0ym4VaqjgCO7gH9EZbIFKImdzLSG/W/0zDk=;
        b=fOFCK44RnL3orem8vDLURxDqRIgwp1hDOngwxjmgFpuEDnN/1ULS/vTdsKLJZ1Ow/C
         UjpodEQZdTz2YZuSYrmkNTX04CJjVvQcvgWMQ/BTqEG9EK8YzKoSmISImRslBOfjNPaS
         Sqr75T/KDMGqfnrPSQpf7BypIGJbcpdg4k0ZQ5FktH/heH/q++S1jhIlApQpH8bxoOmP
         wZDE+66FFxNMNe9fjTWy67cLQpd1fenT1rxO5Ah1kNzjvSvE4ctCA8BUpg+NR+iK97RD
         u0ZtEoXNqUHX4M14X953D4RLNAWyOfm9oWtP646QXXAovjV6Y4u6CPxuuByYBm2dtNYQ
         cAmw==
X-Gm-Message-State: APjAAAWrhzMXhCqBY2PL3glm5mAYCK39TGI6S6jFIqPWrgJuFHOPdpFM
        /yUgbq9Nz3SRfVpCUqsc6/uSVA==
X-Google-Smtp-Source: APXvYqwYP9bkpNcliGTr9vPadFSViAEVlHBXz4/J3D+sWchtFLm9sKkU/GNwM7k8pBCuKv8+WOrAfw==
X-Received: by 2002:a37:27cf:: with SMTP id n198mr23561374qkn.188.1580235300000;
        Tue, 28 Jan 2020 10:15:00 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id l13sm2568655qtf.18.2020.01.28.10.14.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Jan 2020 10:14:59 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iwVO6-0007cu-US; Tue, 28 Jan 2020 14:14:58 -0400
Date:   Tue, 28 Jan 2020 14:14:58 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Gal Pressman <galpress@amazon.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH rdma-rc] RDMA/umem: Fix ib_umem_find_best_pgsz()
Message-ID: <20200128181458.GA29282@ziepe.ca>
References: <20200128135612.174820-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128135612.174820-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 28, 2020 at 03:56:12PM +0200, Leon Romanovsky wrote:
> From: Artemy Kovalyov <artemyko@mellanox.com>
> 
> Except for the last entry, the ending iova alignment sets the maximum
> possible page size as the low bits of the iova must be zero when
> starting the next chunk.
> 
> Fixes: 4a35339958f1 ("RDMA/umem: Add API to find best driver supported page size in an MR")
> Signed-off-by: Artemy Kovalyov <artemyko@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> Tested-by: Gal Pressman <galpress@amazon.com>
> ---
>  drivers/infiniband/core/umem.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Applied to for-next, thanks

Jason
