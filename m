Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD4F8F1F95
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2019 21:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfKFUOv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Nov 2019 15:14:51 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:33809 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfKFUOv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Nov 2019 15:14:51 -0500
Received: by mail-qv1-f67.google.com with SMTP id n12so1988270qvt.1
        for <linux-rdma@vger.kernel.org>; Wed, 06 Nov 2019 12:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AuxIY7le967qwQksduh1ZIIMURMgE1ACYHLPHMUtNxQ=;
        b=OL7FYfSanREuKMOnWuO0u5op8KRS3NOS3zGxG4Btw4RFcZHIJfrU2OPlP3um2NUfRn
         YuxC2nfAjYlUpMiZPBgugP72mk5x8yAMgbFoWpfkhdo8Pc+VnSthXgXTerYxgx+QgecL
         FLwcb5oCeFh3r6IlrXTO3s/YbXsFJK1RJ6zRbmtCrq+eNyH0/WEBFROsRtqxK6KYx7Ls
         uv9FCr38m4I2P2hJ+gB9LW3K9GmTEKEdmsTSmDryJePoI/gNt/axCf9z+C5Z0WS5vVIu
         /0qDn9SriM3vRk/rBZNAhLwt3cPEEBbzMG27TBrBoeRmkXdM8mmRk+t8l0rw4qIdBsHG
         /CbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AuxIY7le967qwQksduh1ZIIMURMgE1ACYHLPHMUtNxQ=;
        b=tZbrvdg8FpH+Vb03rqLbc6ByWub7wm516vwKR80u50+NVBiiMjJ+HEWm0gy0u8Qfvv
         0nPFM3BphTGkLlKrkHzo4jF0uCkKPE1RKIcVA+0sUokcWhpD9ZxEZRBGiglf5cPjBtEl
         qO/mrEK3s+HtZqKJvoUxkAhxClUnv5Mp9W8SZm7wQskwHrQ27oZWTSDzVmAHKHd3uR2v
         woF5cKDfMdktLkL5bV9jnD9oqkGmHD4mTNVwPgW9rUcHAYaQceLtS20TbM2cZEKT5NCz
         oV/h1JM0lzC6pEqU91P4K85bM+pb1/dxIUcRGNaN7ClgdOLbVDv7fsmH718AwGzr7878
         sq5g==
X-Gm-Message-State: APjAAAWyODkjJC8oSAjohMipMZ3pcwZkjFHdO/M5Um68DmMKMXXbCfzX
        zaCuIX6D+FZIIhsc2AZIPYBmlA==
X-Google-Smtp-Source: APXvYqzme5E+9OIXnQNQENMcqepalP+y43Hm+yo04oAEZ0WRNCIy1ILXNu0yKmfW3D7hy0iMt564oA==
X-Received: by 2002:a0c:c385:: with SMTP id o5mr4200181qvi.21.1573071289833;
        Wed, 06 Nov 2019 12:14:49 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id u189sm12875144qkd.62.2019.11.06.12.14.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Nov 2019 12:14:49 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iSRhY-0006gF-Iq; Wed, 06 Nov 2019 16:14:48 -0400
Date:   Wed, 6 Nov 2019 16:14:48 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <ralph.campbell@qlogic.com>
Subject: Re: [PATCH rdma-next 00/16] MAD cleanup
Message-ID: <20191106201448.GA25345@ziepe.ca>
References: <20191029062745.7932-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029062745.7932-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 29, 2019 at 08:27:29AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Let's clean MAD code a little bit.
> 
> It is based on
> https://lore.kernel.org/linux-rdma/20191027070621.11711-1-leon@kernel.org

It doesn't seem related to this at all

> Leon Romanovsky (16):
>   RDMA/mad: Delete never implemented functions
>   RDMA/mad: Allocate zeroed MAD buffer
>   RDMA/mlx4: Delete redundant zero memset
>   RDMA/mlx5: Delete redundant zero memset

We don't need a patch for every driver just to change the same
repeating 2 line pattern, I squashed these

>   RDMA/ocrdma: Clean MAD processing logic
>   RDMA/qib: Delete redundant memset for MAD output buffer
>   RDMA/mlx4: Delete unreachable code
>   RDMA/mlx5: Delete unreachable code
>   RDMA/mthca: Delete unreachable code

Same here

>   RDMA/ocrdma: Simplify process_mad function
>   RDMA/qib: Delete unreachable code
>   RDMA/mlx5: Rewrite MAD processing logic to be readable
>   RDMA/qib: Delete extra line

>   RDMA/qib: Delete unused variable in process_cc call

This is actually a bug from an earlier patch that oddly removed
check_cc_key, I put that into its own patch

>   RDMA/hfi1: Delete unreachable code
>   RDMA: Change MAD processing function to remove extra casting and
>     parameter
 
Ira seems concerned, so I didn't apply these until we hear from Dennis

Otherwise the rest were applied with re-organization to for-next

Thanks,
Jason
