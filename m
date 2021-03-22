Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB653343A1D
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Mar 2021 07:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhCVG5K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Mar 2021 02:57:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:58952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230012AbhCVG4x (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Mar 2021 02:56:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FF916196E;
        Mon, 22 Mar 2021 06:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616396212;
        bh=M4YWSkMbVEYcLSt7CmkeC61qidku7uct3u6/Plp6H38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hwWc0JMcT3USXEUq2ObKjAbz1AxXhf8ySFfUhBXCgZoGWwo7ulyzNVdGliGhgsnYl
         tpwRo3dCFTFMcNmDGQXAi3zRR0tplDTWhThWTxOTzQqLdU+CyECb8EzRHpvAHuOVFm
         arIi4vx9ch5Jbvy3G5Ro5lGjwB92gafXd3rMrwBRcKMTOBRlBdiAqjyXgzo+DTaYrF
         sNGiYuxM4OQ+kIunYZpYdWDl0600kKTmE1vZCVkRNbKgsxVtbhW3Y4m5CTcqdrwfeM
         ex88csnVFsGNPR9teffSFJm3qTZqRcxDJkCqdzZSeUGO4/CKwPrORLUnX72VCIkY/i
         OEToKfGal4y2g==
Date:   Mon, 22 Mar 2021 08:56:49 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Jack Wang <xjtuwjp@gmail.com>, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: Re: IPoIB child interfaces not working with mlx5
Message-ID: <YFg/sb+vnpIhyh1c@unreal>
References: <CAMGffE=3YYxv9i7_qQr3-Uv-NGr-7VsnMk8DTjR0YbX1vJBzXQ@mail.gmail.com>
 <YFXAtSsEL3etCO6b@unreal>
 <CAD+HZHUHbuBeoB4cCLc78gsmZAEyEr+fiWtpuTrxyzRBzMBf_g@mail.gmail.com>
 <YFdE9A6oUHLla2Xu@unreal>
 <CAMGffEmwCrcF+J+=6cV1ND=K6rVm0DjdiO9J2bTxkh5c21oCpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMGffEmwCrcF+J+=6cV1ND=K6rVm0DjdiO9J2bTxkh5c21oCpA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 22, 2021 at 07:08:01AM +0100, Jinpu Wang wrote:
> On Sun, Mar 21, 2021 at 2:07 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Sat, Mar 20, 2021 at 02:09:50PM +0100, Jack Wang wrote:
> > > Leon Romanovsky <leon@kernel.org>于2021年3月20日 周六12:17写道：
> > >
> > > > On Fri, Mar 19, 2021 at 08:44:29AM +0100, Jinpu Wang wrote:
> > > > > Hi Jason and Leon,
> > > > >
> > > > > We recently switch to use upstream OFED from MLNX-OFED, and we notice
> > > > > IPoIB stop working with upstream kernel 5.4.102 with mellanox CX-5
> > > > > HCA, it's working fine on CX-2/CX-3. I tested also on 5.11 kernel it
> > > > > behaves the same.
> > > >
> > > > Are you using "enhanced IPoIB" for CX-5 devices? MLX5_CORE_IPOIB?
> > > >
> > > > Thanks
> > >
> > >  Yes.
> >
> > > Is this expected behavor?
> >
> > Yes, we wanted to make IPoIB behave like any other netdev interfaces and
> > if parent interface isn't enabled, no traffic should pass. More on that,
> > in our internal implementation of enhanced IPoIB, we are reusing same
> > resources for both parent and child, this requires us to wait for "UP"
> > event before allowing traffic.
> >
> > Thanks
> Hi Leon,
> 
> Thanks for the clarification, is this behavior documented somewhere?
> is it specific to "enhanced IPoIB" for CX-5?

It is specific to "enhanced IPoIB" and not to device. I don't know where
we can document it.

> Will it work differently if without MLX5_CORE_IPOIB enabled?

Yes, without MLX5_CORE_IPOIB, the devices will work in "legacy IPoIB",
exactly as cx-3. The best thing will be to change IPoIB ULP to behave
like netdev, but we were not comfortable to do it back then due to
user visible nature of such change.

> 
> I think it would be helpful to add a message if possible to remind
> admin to enable parent if only child if configured.

Care to send patch?

Thanks

> 
> Thanks!
> 
> >
> > >
> > > >
> > > >
