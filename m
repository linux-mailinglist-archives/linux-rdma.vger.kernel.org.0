Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70921AB107
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2020 21:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441549AbgDOTIc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Apr 2020 15:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1416892AbgDOS6G (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Apr 2020 14:58:06 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3AFC061A0C
        for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2020 11:58:06 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id v7so18635572qkc.0
        for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2020 11:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pwxC9+YCE0dKI1SXib5gCsO+bJsYTifnKCO/Yfpr19I=;
        b=Lw6/zvCvNmpGL/VppSzCpkBKyZGMo7xcOUfadA+kl6sKWP1xxtrMPVjNkFzT4qP6xH
         gWzEGcBvOndFyfjKhDCPwu/N/kYPT+TAhqwRWGn3lgi8zp+awULf+0UQEVmicTvddRSc
         hkEFQ/6he7rvYt+O4+wxKkEUbUYfwBT4UEGekq96ox6daBfMFX8CrYnrvd7kCJkDLrG6
         6UtPWUtBWK6AvgoebBLImc0Hwej7PQPNbwhboGRIV6Eeqqu5pXp+WsXyntl3Y4u7EV3O
         bdOUNsPZEpAvzkACAEw0jXKBD7THBaTbMxFKHYLhO8LX2wsJtMao4kwJX2bzFkP+RJqS
         dfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pwxC9+YCE0dKI1SXib5gCsO+bJsYTifnKCO/Yfpr19I=;
        b=LAqL5u944E6xNOVk6MNAXnlC30GCkbHDFAwa8wN94fpQWiRG31aq3mE8noApmW1vhM
         Hnt3bspgulOi5SdxoD0/3SapsodOl+6/EF5z4UoHhypUxctFv5vbRJ41TuRy5KEqbazb
         0J7Nrrg//eI37cXqKtUFNHRU8yi6DXgF4W6n6C8juisdqJXoVKw8getamSmaD+yfGZfD
         B2NogPB0JWzYrzeJ4Ds941C3GZaRH9rfbscbtKOmY+L4SVrbnPxlM3+Q4acsRKd/mmpF
         GtX1FPC4q/ZmCkLHqSDMcAFH3pAJOIgo+SrSGEiUzNOXSDbYgtyHhmuspKqiLbEx7zyw
         9vLg==
X-Gm-Message-State: AGi0PubFFVG9iA7NuzB37hJMKyPETui0d8rOTZByNcDVOtcKcgTfSYao
        oFvTQ3KCm3F1k2wSqwfQZaArqg==
X-Google-Smtp-Source: APiQypI9EDT/Nio9eaFtSQtsgl5UkgLx/+beCmhLR2IXwMrKDWnL/EVKPeF9C4NANQ0vgsw6IHKBJA==
X-Received: by 2002:a05:620a:13eb:: with SMTP id h11mr25853153qkl.404.1586977085486;
        Wed, 15 Apr 2020 11:58:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id x65sm13133326qkd.65.2020.04.15.11.58.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Apr 2020 11:58:04 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jOnEa-0006Zv-C7; Wed, 15 Apr 2020 15:58:04 -0300
Date:   Wed, 15 Apr 2020 15:58:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Max Gurtovoy <maxg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/rw: use DIV_ROUND_UP to calculate nr_ops
Message-ID: <20200415185804.GA25254@ziepe.ca>
References: <20200413133905.933343-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413133905.933343-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 13, 2020 at 04:39:05PM +0300, Leon Romanovsky wrote:
> From: Max Gurtovoy <maxg@mellanox.com>
> 
> Don't open-code DIV_ROUND_UP() kernel macro.
> 
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/rw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next thanks

Jason
