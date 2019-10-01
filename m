Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46228C3768
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 16:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388949AbfJAOaZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Oct 2019 10:30:25 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43555 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388968AbfJAOaZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Oct 2019 10:30:25 -0400
Received: by mail-qt1-f195.google.com with SMTP id c3so21813693qtv.10
        for <linux-rdma@vger.kernel.org>; Tue, 01 Oct 2019 07:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lKU+XOT3gvb6h5+oQXWPA7AFzYImQa90evIR/woZXRQ=;
        b=mA2RMBysraQ1lOhHQQpdPHAuqN6sa8B2N3P7V+jka4DLI05aYT+z7VaZ+EdPGihAln
         1ZfIhzrJH8zBuNs79kNWgm8UnXVn0A7B52C/++yv0q5qitGV+h6wymNwng6u5PBiPo8e
         zsYcTZRpOJ2wGhF6t6LVHVEKVqvbV38JU6xt5f5VYUh4xuS7dkcbfrH6xtebNzWy8t/a
         SCZK0sm1ppjmKFitojBjStu6m+hD/Ys+81TTPRzpegDnWLymuX8pxTFyf6kfRXJJDjqD
         5wMw57995u4PxsWVo4zdV/LK1Q1Djldi39KA3ZwxeMRJOSJNNK/w36ApOaMAx9nI95be
         AaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lKU+XOT3gvb6h5+oQXWPA7AFzYImQa90evIR/woZXRQ=;
        b=ZTm7UzDTsacNUc667lzJhLOJWi4JuSMvuOco66RPwoTPLT3WUoA6Wb/eh3ak3FPEO8
         QFqfrMlMgcEeN+1UHtmkUPsDrS8B99cHhSQbLlkgE7eIkqRBq+M9cW4LFZj3LLhGKRGI
         DLg2Y+2QfbW3ooVPHAudKRR+hi2dEfRZelWaHEfvW0bywnxc6s983ML7Fuzp61H/6jZO
         ZP/J7ApG3VSsN5aUVhcA4n1gMHcIkhRq82MmIRNgQd+fMdxmhluWFLwWJAA9sbbgaJoX
         +r32xHRaDF0Nv5WyDc45pONOiRjIh8qq9XNwxM1KRS9ikiguqXcLjVWnK17fSpEldo88
         H73A==
X-Gm-Message-State: APjAAAVNybOV01aRepitiCiCHMGEbS6BeIInbz4f5WPbdHBUoTqz5Lgc
        g/1dle97nDgQBRs3fBsNiZ1miw==
X-Google-Smtp-Source: APXvYqzdcxqf/SOEZfpFJOz4NMOJcWX14BwFrWciYbzBMgChFJ8ohk0MTWfeEX8NJ0YziJ6zAJu73Q==
X-Received: by 2002:ac8:1a2e:: with SMTP id v43mr30795098qtj.204.1569940224601;
        Tue, 01 Oct 2019 07:30:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id w45sm10044914qtb.47.2019.10.01.07.30.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Oct 2019 07:30:24 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iFJAV-0002z3-Mf; Tue, 01 Oct 2019 11:30:23 -0300
Date:   Tue, 1 Oct 2019 11:30:23 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, dledford@redhat.com,
        leonro@mellanox.com, sagi@grimberg.me
Subject: Re: [PATCH 1/1] IB/iser: remove redundant macro definitions
Message-ID: <20191001143023.GC11407@ziepe.ca>
References: <1569359148-12312-1-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569359148-12312-1-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 25, 2019 at 12:05:48AM +0300, Max Gurtovoy wrote:
> Use the general linux definition for 4K and retrieve the rest from it.
> 
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/infiniband/ulp/iser/iscsi_iser.c  | 2 +-
>  drivers/infiniband/ulp/iser/iscsi_iser.h  | 8 ++------
>  drivers/infiniband/ulp/iser/iser_memory.c | 4 ++--
>  drivers/infiniband/ulp/iser/iser_verbs.c  | 4 ++--
>  4 files changed, 7 insertions(+), 11 deletions(-)

Applied to for-next, thanks

> --- a/drivers/infiniband/ulp/iser/iscsi_iser.h
> +++ b/drivers/infiniband/ulp/iser/iscsi_iser.h
> @@ -96,15 +96,11 @@
>  #define iser_err(fmt, arg...) \
>  	pr_err(PFX "%s: " fmt, __func__ , ## arg)
>  
> -#define SHIFT_4K	12
> -#define SIZE_4K	(1ULL << SHIFT_4K)
> -#define MASK_4K	(~(SIZE_4K-1))
> -
>  /* Default support is 512KB I/O size */
>  #define ISER_DEF_MAX_SECTORS		1024
> -#define ISCSI_ISER_DEF_SG_TABLESIZE	((ISER_DEF_MAX_SECTORS * 512) >> SHIFT_4K)
> +#define ISCSI_ISER_DEF_SG_TABLESIZE ((ISER_DEF_MAX_SECTORS * 512) >> ilog2(SZ_4K))
>  /* Maximum support is 8MB I/O size */
> -#define ISCSI_ISER_MAX_SG_TABLESIZE	((16384 * 512) >> SHIFT_4K)
> +#define ISCSI_ISER_MAX_SG_TABLESIZE	((16384 * 512) >> ilog2(SZ_4K))

This had some conflicts and needed some fixing:

 #define ISER_DEF_MAX_SECTORS           1024
 #define ISCSI_ISER_DEF_SG_TABLESIZE                                            \
-       ((ISER_DEF_MAX_SECTORS * SECTOR_SIZE) >> SHIFT_4K)
+       ((ISER_DEF_MAX_SECTORS * SECTOR_SIZE) >> ilog2(SZ_4K))
 /* Maximum support is 16MB I/O size */
-#define ISCSI_ISER_MAX_SG_TABLESIZE    ((32768 * SECTOR_SIZE) >> SHIFT_4K)
+#define ISCSI_ISER_MAX_SG_TABLESIZE ((32768 * SECTOR_SIZE) >> ilog2(SZ_4K))

Jason
