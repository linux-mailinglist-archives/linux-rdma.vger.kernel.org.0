Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93786CC2B5
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2019 20:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfJDSbt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Oct 2019 14:31:49 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33662 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfJDSbt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Oct 2019 14:31:49 -0400
Received: by mail-qt1-f194.google.com with SMTP id r5so9908627qtd.0
        for <linux-rdma@vger.kernel.org>; Fri, 04 Oct 2019 11:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YwWUeVdAN2Noe/5zbI4HPeLHDeGIfHe7iM11ZBDOV9w=;
        b=RhOnM78TzqgN3fAgW9zvatcZom+dPumAmrqSaP0z0lF5c+nQikybaEE87SexbEhAxB
         tAKRZbhY+54YyhIWeFodkK+C4TtC6ltTglvKmUMuDP3xOKnGCfF/e+rjD038No2QgiPF
         p6hWUTXUGxYU2BbXyy/he/c0ILUn4+TWWAW28Vyh3c85QwDFAwpr3ztLWB+OuCk/kt1c
         IltMaxDtEpodMHhkIH9lxfDGGPJvTm3v5ypfF4SkeqbQZDdCnSXLpDx9gJtNqp9zXnGO
         01wG3m5TdXo9MFTtWwDVGIdQiu0yWoyV9fx8/0QhLDxyT8oXaBkdkft5L0II0aqbWSSN
         N1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YwWUeVdAN2Noe/5zbI4HPeLHDeGIfHe7iM11ZBDOV9w=;
        b=IXATST3HMPd1KqpX85L+WnHcm5KoJwSB31nIUPKqd9MtAl1UZuN4U7MMKa/Grai7LL
         0FxT9pD3vgenEUaHVOmaqcZ8UJCkMqBaJaAUC+NzeB9Idr84SBTVBb844V4Iy2ziDwqr
         S/SFx2l13w4714K0+wzBWHnmCH3tRcfAGGM5Fv0hUwDaR8u4pBnYtFE2R1Vv/s2xIzpZ
         npusFyOt6PiGxZ3BBJTRQDYXx3vZyZzyl+oOgHCW9uTZusYUtTYUfMchKjHCLyTMjua3
         ocDw+8N21PlrRLL3F7G3sQX+pf12CCy8gHtEdObR7NJFZTb0sRbalMElr1ghNPufCUf8
         5I+w==
X-Gm-Message-State: APjAAAU5YX0cd2MAcGhwpQiXeAnWSaWUdYsHBIA0YrXhmo3AYp3zfWZ0
        PJCzjo/cfHVGbWYwFU3yhU30WA==
X-Google-Smtp-Source: APXvYqyerMUGSyXslusRJrmglTNW52Fj5irbQz06UjE6dV+6vvni+Wprzy4sM46kMdsv66OX2YKr5g==
X-Received: by 2002:a0c:edc2:: with SMTP id i2mr15215856qvr.229.1570213908429;
        Fri, 04 Oct 2019 11:31:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id z6sm3090346qkf.125.2019.10.04.11.31.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 11:31:47 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iGSMl-0007i0-B4; Fri, 04 Oct 2019 15:31:47 -0300
Date:   Fri, 4 Oct 2019 15:31:47 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Mark Zhang <markz@mellanox.com>
Subject: Re: [PATCH rdma-rc v1] RDMA/nldev: Reshuffle the code to avoid need
 to rebind QP in error path
Message-ID: <20191004183147.GA29543@ziepe.ca>
References: <20191002115627.16740-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002115627.16740-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 02, 2019 at 02:56:27PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Properly unwind QP counter rebinding in case of failure.
> 
> Fixes: b389327df905 ("RDMA/nldev: Allow counter manual mode configration through RDMA netlink")
> Reviewed-by: Mark Zhang <markz@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  Changelog v0->v1: https://lore.kernel.org/linux-rdma/20190916071154.20383-4-leon@kernel.org
>  * Used different goto label.
> ---
>  drivers/infiniband/core/nldev.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Applied to for-next, thanks

Jason
