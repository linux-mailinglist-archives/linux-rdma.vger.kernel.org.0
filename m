Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11501FCA5A
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2019 16:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfKNP4p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Nov 2019 10:56:45 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:42776 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfKNP4o (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Nov 2019 10:56:44 -0500
Received: by mail-qv1-f65.google.com with SMTP id c9so2524827qvz.9
        for <linux-rdma@vger.kernel.org>; Thu, 14 Nov 2019 07:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FmjmDqRS64QHrlZCOMeU+4l6u7UHDO0ypv0yThm8s0g=;
        b=pA0bQbP6XD4D/BD4h78j49lxIecFR0+WP8kaKGgCrn5erhajDLentaIKcuX1znJ8dE
         RDT65oQYsMsuClwXn7Tgnglb8qK1wt1gyK9vOFuwYoKVMkW1ppI67zCN/XFjzEldy+lx
         bc73mWGywcH+jEESmROF/Cnd8uNKpXBXDH2FdnsQMYFp4WAncfcPD1eIOw0uquvLszst
         bnqe7Ak9QXUpsogNxpvJBPp9OYFg/BZphc2/qWNpZ0YIEpRQDd+sm7+wB8u0SLG3/yyi
         i+Euz1x118gU0dopMUQW7D4tnpuLUtcWLiO807rCmqSa2IUHKr2E+5DsZuGMbrsA9P1Z
         UhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FmjmDqRS64QHrlZCOMeU+4l6u7UHDO0ypv0yThm8s0g=;
        b=P7I6nq9mGa1J7LuOWbtqa98Bwme5odIph/12Li8AoFYREvqxeA3BFeuogHEK7DEsTc
         /oVjig+iarDZRbNLkSMcaZ9PEFKB3Fa/G9loMjyzrqqh3DgxbBp3eh5XpbGkukD4OlYI
         X+you3Z/saY87z8/pJm8h6ilQzJhBE1V80yDME+z2E2nmxS05IUmzfPoVxs1yx7XDzuF
         OrzRseK9QmzhzXl8J9ZuiSvwkaDyry2NVJ7BFyvofF3NuUX03cKNEaLIKApFOnVJrM1X
         4vEhm7TdUaq73bbOAyvs3ufyr+4uaQyhxjerxsFUNdBNzQKHSkTmNNP99+prGUXRIxws
         qhPQ==
X-Gm-Message-State: APjAAAU45z0FQ/JYKJOVgDaJiXc0O6UP2tCJJCbW/6BgF0DebQOqj3Oi
        0BRQOqaVEu+64u2HuyTLSeILMQ==
X-Google-Smtp-Source: APXvYqwCNQYLBVJd3wu3z4s0DeEGcapRYfRmSJR/DPNTnpezPE+Ce2Kg6vzcS+AmV5VJ1JeQDasQxw==
X-Received: by 2002:ad4:4422:: with SMTP id e2mr8654285qvt.91.1573747003835;
        Thu, 14 Nov 2019 07:56:43 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id r80sm2686185qke.121.2019.11.14.07.56.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Nov 2019 07:56:43 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iVHUA-0001AU-OI; Thu, 14 Nov 2019 11:56:42 -0400
Date:   Thu, 14 Nov 2019 11:56:42 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, michal.kalderon@marvell.com
Subject: Re: [PATCH for-next] RDMA/siw: Cleanup unused mmap structures.
Message-ID: <20191114155642.GA4323@ziepe.ca>
References: <20191113153404.7402-1-bmt@zurich.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113153404.7402-1-bmt@zurich.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 13, 2019 at 04:34:04PM +0100, Bernard Metzler wrote:
> Removes obsolete driver specific mmap information after
> generalization of RDMA driver mmap service. Also removes
> useless forward declaration of struct siw_mr.
> 
> Fixes: 11f1a75567c4 ("RDMA/siw: Use the common mmap_xa helpers")
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/sw/siw/siw.h       | 11 -----------
>  drivers/infiniband/sw/siw/siw_verbs.c |  2 --
>  2 files changed, 13 deletions(-)

Applied to for-next, thanks

Jason
