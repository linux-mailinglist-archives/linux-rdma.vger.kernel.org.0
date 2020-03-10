Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0399518050D
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 18:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgCJRlD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 13:41:03 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35550 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgCJRlD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Mar 2020 13:41:03 -0400
Received: by mail-qt1-f194.google.com with SMTP id v15so10309274qto.2
        for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2020 10:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fBVgShqzb2YX8cy69HShX10QDBUI3pZ10dJJEFww0w0=;
        b=UvZrBWUsxRNVYrJ9G6R46esBqiHnlUBudWqwAJNlqhMr2LXMDVEjuE/qjhRz3yiyab
         xJ4fRIAxAF5ImD5CiIghO6QliSfpM6Ny6tRNFEPWSQoCI86KXkAqgBthyPTuS/sXAQdw
         VT4NiwDAVvVUT/i2n4N7SoxxzOIQeAuRKRFnLPQl2eW/AoO9etESwZcE7uHOAKF7dFW5
         NnfZjs0GjIfGjYbK50Qw/y0PEzYmFrz1s5OidQN3Uf4V1/wGCqewlh/V2ifOCn9JpL0u
         frebV1IUO1HoSjN0un8cKH8BCQ5/jXyxIK5303EaxIpfRzobwS8b6MQuLwigmlsbuIHb
         Dl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fBVgShqzb2YX8cy69HShX10QDBUI3pZ10dJJEFww0w0=;
        b=etkvOkviycP5W9YRoWDYS7IPCVwBwtQqbAXFgO3ZLnGTflPcrZDs6b0lIZCh2HoHuK
         n6WEfIsyJdTv93L0r1R0aN556cyl1puexhqLj8Xdg6Oplo7bO15Tvw3WS997I+Tc5VAy
         yMKRTWZBQjADlGJGZklPOEbn88/NS9mYsiGZ/vwNPEjd5ml71moRdAGegoK+az4R2cWN
         mSme1kH1ixXgFV/gwrX38heCNQMiEP/yPsnznbn02k+PVzf8CTNTQVjoCcnuAN7iC7pc
         GJ9tuVlKikLqQmpSKz+sA/hZYQhMNTNvmUXs0OzxP2bJwxDviol97eG1cLjAKCaHlXQN
         iD6A==
X-Gm-Message-State: ANhLgQ12qtatRCxu2aZyjbrqMaGh0HULFKsbhMKsZHX/Fb9pRgtH5SES
        CsNv+hmnPVqIwH4YrSD+mG8o7Q==
X-Google-Smtp-Source: ADFU+vsFavBEEHWaALBc47/QBq+Dj2M4I3VgKyOvxiOsNDKQtm5eMDv7C2jx7pMvs5JMtWKjf5ARxw==
X-Received: by 2002:ac8:6781:: with SMTP id b1mr20277346qtp.355.1583862062042;
        Tue, 10 Mar 2020 10:41:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id x74sm5484104qkb.40.2020.03.10.10.41.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Mar 2020 10:41:01 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jBisH-0007K6-6s; Tue, 10 Mar 2020 14:41:01 -0300
Date:   Tue, 10 Mar 2020 14:41:01 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Erez Shitrit <erezsh@mellanox.com>,
        Alex Vesker <valex@mellanox.com>,
        Ariel Levkovich <lariel@mellanox.com>,
        linux-rdma@vger.kernel.org,
        Yevgeny Kliteynik <kliteyn@mellanox.com>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Remove duplicate definitions of
 SW_ICM macros
Message-ID: <20200310174101.GA28121@ziepe.ca>
References: <20200310075706.238592-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310075706.238592-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 10, 2020 at 09:57:06AM +0200, Leon Romanovsky wrote:
> From: Erez Shitrit <erezsh@mellanox.com>
> 
> Those macros are already defined in include/linux/mlx5/driver.h,
> so delete their duplicate variants.
> 
> Signed-off-by: Ariel Levkovich <lariel@mellanox.com>
> Signed-off-by: Yevgeny Kliteynik <kliteyn@mellanox.com>
> Signed-off-by: Erez Shitrit <erezsh@mellanox.com>
> Reviewed-by: Alex Vesker <valex@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/mlx5_ib.h | 4 ----
>  1 file changed, 4 deletions(-)

That is a long list of signed off by's for a two line patch..

Applied to for-next

Jason
