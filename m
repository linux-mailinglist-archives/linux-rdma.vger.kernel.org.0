Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D73321C01
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Feb 2021 17:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhBVP7g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Feb 2021 10:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhBVP7a (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Feb 2021 10:59:30 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B80C061786
        for <linux-rdma@vger.kernel.org>; Mon, 22 Feb 2021 07:58:47 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id w1so2730995qto.2
        for <linux-rdma@vger.kernel.org>; Mon, 22 Feb 2021 07:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n07VaxTY0kbB+VdtG9ROy4sSSmPU2dRQLBzVM0ZBz7E=;
        b=Yqh1ikPAu5/XDu3ob7bxG4ON5Ojvl2kXbVvCYH8A3EXSyCxNXlgTurFsl7mfTra0X4
         O8wd/nDs2txIH9cGahzAJmgTOApJ4luniDPCNv1PaqGgw2vf6VZ33bO1/YpHbaqowXzK
         EiBfnce60ipXhW9OI8r/P3xjfbuLK6MpavM+F5k4Fr4ynqNo19p62ZykbRtWyyytjb6N
         96T0vEmI9qBNlae3pTyJkDyZt20F7aF57Pb5TJWwSujuToukmDfa3joBNW9PM8oVy3kG
         kPRW5BM+QC00dNZfyDkUMMYyT+spJAOUYvMdkp2P98MaoDFZ67Pp/+DLr0OIleZbNC+p
         Xzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n07VaxTY0kbB+VdtG9ROy4sSSmPU2dRQLBzVM0ZBz7E=;
        b=H2jjgqwAzO5lGFzo0nH09MG06DmbF3G11RitsxnYG0y6M57jonUuOlF/kiqBe9zafW
         0zODBRLHjuL8EN3z3HjfuclPV/UHy3ob2iXJ1GTr2x0dHhLyAgAmXDrdnCCVmJituK01
         b/xw0HIY8M5aLE5wf3ARFBT6aGoGl45Zjmi4DGyeKYki00KYnPbcScJxytUJrL8Rt+yO
         SLQguYGPLK6ssl7p/AdXjzf8zIe2xWd/eDT/kdokcZEyu02BfjsDkwJNbD5irMgN4CLH
         d+tPQvPg6kvok43AoX/mNZux6LiPr4jzoQ6DN4Uq3e419G/xwnukrF4MApiLp05fMdi/
         fXPw==
X-Gm-Message-State: AOAM531YsobFWFcwnbEuNQJYhIBEN3biaDAu6B1Dbjhwosp6K9j8RIve
        CnJs2rfyhIlUAWkqZvrZmmdmCQ==
X-Google-Smtp-Source: ABdhPJyby2lV/pkUjOuAGtzhFcBs3hQo43DMUoohhVtah90nJbhZYkzBQWWSi40FRSmcZMEGzEaHjA==
X-Received: by 2002:a05:622a:143:: with SMTP id v3mr20662916qtw.363.1614009526850;
        Mon, 22 Feb 2021 07:58:46 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id x12sm12175675qkj.20.2021.02.22.07.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 07:58:46 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lEDbh-00ERHh-Or; Mon, 22 Feb 2021 11:58:45 -0400
Date:   Mon, 22 Feb 2021 11:58:45 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Julian Braha <julianbraha@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: infiniband: sw: rxe: fix kconfig dependency on
 CRYPTO
Message-ID: <20210222155845.GI2643399@ziepe.ca>
References: <21525878.NYvzQUHefP@ubuntu-mate-laptop>
 <YDICM3SwwGZfE+Sg@unreal>
 <CAD=hENeCXGtKrXxLof=DEZjxpKyYBFS80pAX20nnJBuP_s-GBA@mail.gmail.com>
 <YDOq060TvAwLgknl@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDOq060TvAwLgknl@unreal>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 22, 2021 at 03:00:03PM +0200, Leon Romanovsky wrote:
> On Mon, Feb 22, 2021 at 10:39:20AM +0800, Zhu Yanjun wrote:
> > On Sun, Feb 21, 2021 at 2:49 PM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Fri, Feb 19, 2021 at 06:32:26PM -0500, Julian Braha wrote:
> > > > commit 6e61907779ba99af785f5b2397a84077c289888a
> > > > Author: Julian Braha <julianbraha@gmail.com>
> > > > Date:   Fri Feb 19 18:20:57 2021 -0500
> > > >
> > > >     drivers: infiniband: sw: rxe: fix kconfig dependency on CRYPTO
> > > >
> > > >     When RDMA_RXE is enabled and CRYPTO is disabled,
> > > >     Kbuild gives the following warning:
> > > >
> > > >     WARNING: unmet direct dependencies detected for CRYPTO_CRC32
> > > >       Depends on [n]: CRYPTO [=n]
> > > >       Selected by [y]:
> > > >       - RDMA_RXE [=y] && (INFINIBAND_USER_ACCESS [=y] || !INFINIBAND_USER_ACCESS [=y]) && INET [=y] && PCI [=y] && INFINIBAND [=y] && INFINIBAND_VIRT_DMA [=y]
> > > >
> > > >     This is because RDMA_RXE selects CRYPTO_CRC32,
> > > >     without depending on or selecting CRYPTO, despite that config option
> > > >     being subordinate to CRYPTO.
> > > >
> > > >     Signed-off-by: Julian Braha <julianbraha@gmail.com>
> > >
> > > Please use git sent-email to send patches and please fix crypto Kconfig
> > > to enable CRYPTO if CRYPTO_* selected.
> > >
> > > It is a little bit awkward to request all users of CRYPTO_* to request
> > > select CRYPTO too.
> >
> > The same issue and similar patch is in this link:
> >
> > https://patchwork.kernel.org/project/linux-rdma/patch/20200915101559.33292-1-fazilyildiran@gmail.com/#23615747
> 
> So what prevents us from fixing CRYPTO Kconfig?

Yes, I would like to see someone deal with this properly, either every
place doing select CRYPTO_XX needs fixing or something needs to be
done in the crypto layer.

I have no idea about kconfig to give advice, I've added Arnd since he
always seems to know :)

Thanks,
Jason
