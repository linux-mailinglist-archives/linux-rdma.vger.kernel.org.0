Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4314F184994
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2020 15:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgCMOiV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Mar 2020 10:38:21 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40778 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgCMOiV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Mar 2020 10:38:21 -0400
Received: by mail-qk1-f196.google.com with SMTP id m2so12807665qka.7
        for <linux-rdma@vger.kernel.org>; Fri, 13 Mar 2020 07:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M/Mr9CJjBvdUOO/vTTyUVY8JHXKjFrWh/IcDvQEE71U=;
        b=AWi/VUu6+s71AShzXtMwRVu4YnByM0bbvCTaVhdGYYo7cJvwMx4k5kb67q5UjGm5v2
         bInOJz5ihLCPHDsRRLEVfzeRmLNGZa01HyW8H7ZEatrvUnJ2dLXvNY4bsA+RhOOLJzmN
         qRtu1R8RjI4z/zlHE4DpefFGAY+q4h4/JDKGuVidqL8Q4AMKHJ0oWYWHtPFcm6V+P7wq
         Ea3NbGswe0WJG75B5g2a31J0R+UGqBJkY83TYQrmDXC0xsI4KGxVFY6WVIqD/6rlTnF0
         cxX35Nh9Cs6OKQM3KC/lDlTaXDDgS8/rXX7AWo7sk/8N3rWOtFc6osx0ZAwpRIdc1HLQ
         ToQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M/Mr9CJjBvdUOO/vTTyUVY8JHXKjFrWh/IcDvQEE71U=;
        b=RDQJwflUS5BCaX2uXesyy/1rhlCzQZFRPJUI4Az0jt28KvIBZyhj6LjeZjVq6/5Op8
         z0ZwOwRlPRgO3hGG/IZtvNRv/DeDTAzOW7ylwXGbJMMfiC3pjrbSVAWGXtg41lXco7kB
         Ga+WJwhVLElQOWAoLJCZxTKQuqGy6tiZI6gSlYbWL5DqY9HiSeiO9cp3chP/9YeQlH2W
         nAlyooJNzBxQX1IkQGVZbxyDCblH5OJNemmsWI8rieydqKmPBHrqC/j+RzVabk1T4e/u
         vSLSJ784roUp85cxBlZ1G5fb1DfqDgojwtm9NLEND8FG2e+girRHoIbUpsqQmF60In9N
         dfdw==
X-Gm-Message-State: ANhLgQ13El5yGLy7QgXdNSTeoHN8LPmnIDQ+quHIF9/KFgGniF3QXhBz
        ICyPHHOdPJ5y0Ry+Xrbz6EA+3Q==
X-Google-Smtp-Source: ADFU+vvJEy7VHC0/p8MXYg/BSAgvQyaCRfeIhl5aQPZcg89DzJejulD7Hl55UmzKYMPQ2+sSypsOgw==
X-Received: by 2002:a37:4dc4:: with SMTP id a187mr13566946qkb.436.1584110300336;
        Fri, 13 Mar 2020 07:38:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id c190sm8096972qkb.80.2020.03.13.07.38.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Mar 2020 07:38:19 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jClS5-0002ut-RP; Fri, 13 Mar 2020 11:38:17 -0300
Date:   Fri, 13 Mar 2020 11:38:17 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Fix wrong judgments of udata->outlen
Message-ID: <20200313143817.GA11180@ziepe.ca>
References: <1583845569-47257-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583845569-47257-1-git-send-email-liweihang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 10, 2020 at 09:06:09PM +0800, Weihang Li wrote:
> These judgments were used to keep the compatibility with older versions of
> userspace that don't have the field named "cap_flags" in structure
> hns_roce_ib_create_cq_resp. But it will be wrong to compare outlen with
> the size of resp if another new field were added in resp. oulen should be
> compared with the end offset of cap_flags in resp.
> 
> Fixes: 4f8f0d5e33dd ("RDMA/hns: Package the flow of creating cq")
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
> Related discussions can be found at:
> https://patchwork.kernel.org/patch/11372851/ 
>  drivers/infiniband/hw/hns/hns_roce_cq.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied to for-next, thanks

Jason
