Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7111E365794
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Apr 2021 13:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhDTL37 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Apr 2021 07:29:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230118AbhDTL3z (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Apr 2021 07:29:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC91361354;
        Tue, 20 Apr 2021 11:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618918164;
        bh=bWaQBvj9ziDXvzR9IBmXsCFCg4SVu2/7BkCp1xTmhC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uP5ls1Tseb2gr+E18m6Yd2gYtLJUl2IWH2qFDQZP0MOhACYjD+Ym8KRwKNQJd5fbv
         WNXDylX1s0eF2iZrtuR4xPm3CUaFQMv6vRA/OBsYI2CdqRgRoan+s+Ld4mfrk25NHx
         SrsW34T4cIGPxISwCW7B3GXA1ejO4ppoxTgrFIOfdGLTRPpHpUPs89ohPIbesXGgKy
         g+txmRPh0VWvkFhI7XN0XufDpjSF4zzQp8EAbAW/leslCtNCUcKbixAmF7qXXZ//qV
         TCQ8rzX+uwhkPZ81T5t3T3rQ57UT7i4UFYslYPV8dzDvnOG0gSYGjWmKcVdYQYjJ1n
         39kzQeEbc4GaQ==
Date:   Tue, 20 Apr 2021 14:29:20 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jinpu Wang <jinpu.wang@ionos.com>
Cc:     Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        Jack Wang <xjtuwjp@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: Re: IPoIB child interfaces not working with mlx5
Message-ID: <YH67EMmq+Rcd0hLJ@unreal>
References: <CAMGffE=3YYxv9i7_qQr3-Uv-NGr-7VsnMk8DTjR0YbX1vJBzXQ@mail.gmail.com>
 <YFXAtSsEL3etCO6b@unreal>
 <CAD+HZHUHbuBeoB4cCLc78gsmZAEyEr+fiWtpuTrxyzRBzMBf_g@mail.gmail.com>
 <YFdE9A6oUHLla2Xu@unreal>
 <CAMGffEmwCrcF+J+=6cV1ND=K6rVm0DjdiO9J2bTxkh5c21oCpA@mail.gmail.com>
 <YFg/sb+vnpIhyh1c@unreal>
 <CAMGffEkDtj59RkBut=-=2DQAbcASei0qHEi42C94ijP3WW1sTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMGffEkDtj59RkBut=-=2DQAbcASei0qHEi42C94ijP3WW1sTA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 20, 2021 at 11:14:41AM +0200, Jinpu Wang wrote:
> On Mon, Mar 22, 2021 at 7:56 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Mon, Mar 22, 2021 at 07:08:01AM +0100, Jinpu Wang wrote:
> > > On Sun, Mar 21, 2021 at 2:07 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > >
> > > > On Sat, Mar 20, 2021 at 02:09:50PM +0100, Jack Wang wrote:
> > > > > Leon Romanovsky <leon@kernel.org>于2021年3月20日 周六12:17写道：
> > > > >
> > > > > > On Fri, Mar 19, 2021 at 08:44:29AM +0100, Jinpu Wang wrote:
> > > > > > > Hi Jason and Leon,
> > > > > > >
> > > > > > > We recently switch to use upstream OFED from MLNX-OFED, and we notice
> > > > > > > IPoIB stop working with upstream kernel 5.4.102 with mellanox CX-5
> > > > > > > HCA, it's working fine on CX-2/CX-3. I tested also on 5.11 kernel it
> > > > > > > behaves the same.
> > > > > >
> > > > > > Are you using "enhanced IPoIB" for CX-5 devices? MLX5_CORE_IPOIB?
> > > > > >
> > > > > > Thanks
> > > > >
> > > > >  Yes.
> > > >
> > > > > Is this expected behavor?
> > > >
> > > > Yes, we wanted to make IPoIB behave like any other netdev interfaces and
> > > > if parent interface isn't enabled, no traffic should pass. More on that,
> > > > in our internal implementation of enhanced IPoIB, we are reusing same
> > > > resources for both parent and child, this requires us to wait for "UP"
> > > > event before allowing traffic.
> > > >
> > > > Thanks
> > > Hi Leon,
> > >
> > > Thanks for the clarification, is this behavior documented somewhere?
> > > is it specific to "enhanced IPoIB" for CX-5?
> >
> > It is specific to "enhanced IPoIB" and not to device. I don't know where
> > we can document it.
> >
> > > Will it work differently if without MLX5_CORE_IPOIB enabled?
> >
> > Yes, without MLX5_CORE_IPOIB, the devices will work in "legacy IPoIB",
> > exactly as cx-3. The best thing will be to change IPoIB ULP to behave
> > like netdev, but we were not comfortable to do it back then due to
> > user visible nature of such change.
> >
> Hi Leon,
> 
> More testing reveals new problems with MLX5_CORE_IPOIB.
> w MLX5_CORE_IPOIB, ping wors on both hosts, but iperf3 doens't send any data.

In our regression, iperf3 works.

Let's take it offline.

Thanks
