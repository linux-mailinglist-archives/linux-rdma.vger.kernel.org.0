Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D00D3432AD
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Mar 2021 14:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhCUNH0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Mar 2021 09:07:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:38948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229846AbhCUNHG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 21 Mar 2021 09:07:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC54261929;
        Sun, 21 Mar 2021 13:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616332025;
        bh=kz67jfuLiKSRfd7GT/AahoV+H8VsZVPqyuSyHJd3AB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l901/mOjz3Z+jZhEsWwaqjEbiujTWSz/4CDBhZt6d9Ryo986ky09VjuynHL+YrlV7
         VSd78nc2Yl6dJF6jbL8arncWE4zOoNoSJurwmtK+DlUT4B5x/Nsn/j9YgxgVav4Gh3
         zBkSrw6oA7L71GG4ar8D12ucLJ4e9JzQ6CqfRFSu0TvKVNWZLUXEPhNjhl03xyUvtL
         6+eiBAYRRdo4JH19x/gtQPMQ3QqtHwxRJAIjWTB9zKSgsQng1N2tQ+ssIPsvbg2FBo
         AR/0o2jtJiTnuA+77bZu6voorlsYspv7DEpXHen4An+3Pxv+umZ17/erQuicVenBRI
         9PiqD7o6cvtaQ==
Date:   Sun, 21 Mar 2021 15:07:00 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jack Wang <xjtuwjp@gmail.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        linux-rdma@vger.kernel.org
Subject: Re: IPoIB child interfaces not working with mlx5
Message-ID: <YFdE9A6oUHLla2Xu@unreal>
References: <CAMGffE=3YYxv9i7_qQr3-Uv-NGr-7VsnMk8DTjR0YbX1vJBzXQ@mail.gmail.com>
 <YFXAtSsEL3etCO6b@unreal>
 <CAD+HZHUHbuBeoB4cCLc78gsmZAEyEr+fiWtpuTrxyzRBzMBf_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD+HZHUHbuBeoB4cCLc78gsmZAEyEr+fiWtpuTrxyzRBzMBf_g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Mar 20, 2021 at 02:09:50PM +0100, Jack Wang wrote:
> Leon Romanovsky <leon@kernel.org>于2021年3月20日 周六12:17写道：
> 
> > On Fri, Mar 19, 2021 at 08:44:29AM +0100, Jinpu Wang wrote:
> > > Hi Jason and Leon,
> > >
> > > We recently switch to use upstream OFED from MLNX-OFED, and we notice
> > > IPoIB stop working with upstream kernel 5.4.102 with mellanox CX-5
> > > HCA, it's working fine on CX-2/CX-3. I tested also on 5.11 kernel it
> > > behaves the same.
> >
> > Are you using "enhanced IPoIB" for CX-5 devices? MLX5_CORE_IPOIB?
> >
> > Thanks
> 
>  Yes.

> Is this expected behavor?

Yes, we wanted to make IPoIB behave like any other netdev interfaces and
if parent interface isn't enabled, no traffic should pass. More on that,
in our internal implementation of enhanced IPoIB, we are reusing same
resources for both parent and child, this requires us to wait for "UP"
event before allowing traffic.

Thanks

> 
> >
> >
