Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3F90126CA8
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2019 20:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfLSTF1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Dec 2019 14:05:27 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:39378 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728832AbfLSTF0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Dec 2019 14:05:26 -0500
Received: by mail-qv1-f65.google.com with SMTP id y8so2655274qvk.6
        for <linux-rdma@vger.kernel.org>; Thu, 19 Dec 2019 11:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VcLf0PpAPAd1IHJ13fsnv6shotyecohWMRh7Z3bTqKQ=;
        b=d/mBc3LicY9SCzrvkMADKbZdgapJ1lDCPbcScqZUW6R1w7Uu00huC9IxYuaTC/0dsB
         Pt5ypF/Ub5vhWCrb62lASt9sE0M/J+awas7SJuWCgLGGi95+R6gXF70xVpa1IAVg+Hv/
         SrYsFVR0WNUXhPpE3TLFfVAMbQtqfbbDInlgDB2YAD829fFAWCQ9vHn7kyFeLi19LDbC
         Lbv38XbuXjvkmjLInvfiJRk7eh0d46Fz9ZCCCZulEITwUkAYkgfZMbaXjN8wgKpDHcy+
         hhx2MaruVUo6a7IS1WgYRIGb0fNT+xxFb9t6QjSwDf6qYT1PU2GwpGGv7A0P7cpBgDc5
         WczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VcLf0PpAPAd1IHJ13fsnv6shotyecohWMRh7Z3bTqKQ=;
        b=PO7vDifqXeWBiixdQN3PNJyVQm8y9trBwcTnTqKGT3A531TrDi/yRsJZKGp62KthTd
         5MDIuMBuXQhtKHv8MYPgRI/1HLhQKdOi7Dr1SFGy18JvP68kyFRUbKpuBMuYWRAGqRW1
         JZ0u5nQwp8pWHbMyu4XyNpy68Nu8lOfRkHonGU8UerjpiQdc9wr8/vOb/YMO2SIVhFbJ
         /Ch/5F5TgM4ZFpAAUAKTS+LtOiESXKW7B2D3fd9SnqwivkTLoir8YAN4vvjQuNJNOJNy
         cNdjL/OGdEF5X/gs1TdeEuo1ED6KqeRWz0WdUWtxTUuz25hJAsgcJqkQi6EkvXzCp5me
         Vf9Q==
X-Gm-Message-State: APjAAAVVm/EaOXFBArD/oNXfNvv2BMMCv5FtT8DRAx2rWiny3+nh5vuE
        vncurdma1EhYtLxTREbsEJ9EMg==
X-Google-Smtp-Source: APXvYqxyzHRQCJaD5fn7y0ZIwbKOF8w9ZNfqkuULkeRsPueILiH9lTyLIAlj6FGDEbfb+Fs94S4hZw==
X-Received: by 2002:a0c:961a:: with SMTP id 26mr9130243qvx.241.1576782325397;
        Thu, 19 Dec 2019 11:05:25 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id d143sm2007517qke.123.2019.12.19.11.05.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Dec 2019 11:05:24 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ii16y-00088z-DO; Thu, 19 Dec 2019 15:05:24 -0400
Date:   Thu, 19 Dec 2019 15:05:24 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Aviad Yehezkel <aviadye@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-rc 2/3] IB/core: Fix ODP get user pages flow
Message-ID: <20191219190524.GK17227@ziepe.ca>
References: <20191219134646.413164-1-leon@kernel.org>
 <20191219134646.413164-3-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219134646.413164-3-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 19, 2019 at 03:46:45PM +0200, Leon Romanovsky wrote:
> From: Yishai Hadas <yishaih@mellanox.com>
> 
> When calling get_user_pages_remote() need to work with granularity of
> PAGE_SIZE.
> 
> Fix the calculation of how many entries can be read in one call to
> consider that.
> 
> Fixes: 403cd12e2cf7 ("IB/umem: Add contiguous ODP support")
> Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
> Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/umem_odp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
