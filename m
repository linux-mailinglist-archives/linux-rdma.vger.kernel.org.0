Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037022EAB04
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Jan 2021 13:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbhAEMl3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Jan 2021 07:41:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:51700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbhAEMl3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 5 Jan 2021 07:41:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8413A229F0;
        Tue,  5 Jan 2021 12:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609850448;
        bh=HC9Rjmfsm3jd7AV8BBYgVuzfbob3rCRaZm49+yu/ObE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lImY4MEnl7Eji0fyfIGTQdmgqV8ZqmsGy+Z+SnKbjebecYYuP7Hyn8sSOCmf310hn
         TY6sxwwVvgvT9Jwwz1WzC5OsyaW8lUktlycxiS9RNE5EikoEnrhP6teTXc1P+ddSY+
         40kO52V0Zv0+y07xfQHzIPb0yj8LYGGRV4lZj94kMyCnWlpj4jSneF6c96ATvcizbj
         DXLblh+qfcNj1Z3LX6lO4VpigMPdmUerzXCShjHKJ11gKuCo0u2O9GXnqqYaVwUCwm
         uevmPq3C+geehd+YLSiJoYolDc/ii+dPZWGAj8vgug1gBIhJYj1UVGTjKfJPVWKxRx
         seOixoqsb+5/Q==
Date:   Tue, 5 Jan 2021 14:40:44 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Leonid Feschuk <lfesch@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next 1/2] RDMA/efa: Move host info set to first
 ucontext allocation
Message-ID: <20210105124044.GS31158@unreal>
References: <20210105104326.67895-1-galpress@amazon.com>
 <20210105104326.67895-2-galpress@amazon.com>
 <20210105112150.GR31158@unreal>
 <4f3de61c-55dc-e6e3-6a14-de5be10e3ecd@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f3de61c-55dc-e6e3-6a14-de5be10e3ecd@amazon.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 05, 2021 at 02:22:23PM +0200, Gal Pressman wrote:
> On 05/01/2021 13:21, Leon Romanovsky wrote:
> > On Tue, Jan 05, 2021 at 12:43:25PM +0200, Gal Pressman wrote:
> >> Downstream patch will require the userspace version which is passed as
> >> part of ucontext allocation. Move the host info set there and make sure
> >> it's only called once (on the first allocation).
> >>
> >> Reviewed-by: Firas JahJah <firasj@amazon.com>
> >> Reviewed-by: Leonid Feschuk <lfesch@amazon.com>
> >> Signed-off-by: Gal Pressman <galpress@amazon.com>
> >> ---
> >>  drivers/infiniband/hw/efa/efa.h       | 7 +++++++
> >>  drivers/infiniband/hw/efa/efa_main.c  | 4 +---
> >>  drivers/infiniband/hw/efa/efa_verbs.c | 3 +++
> >>  3 files changed, 11 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
> >> index e5d9712e98c4..9c9cd5867489 100644
> >> --- a/drivers/infiniband/hw/efa/efa.h
> >> +++ b/drivers/infiniband/hw/efa/efa.h
> >> @@ -45,6 +45,11 @@ struct efa_stats {
> >>       atomic64_t keep_alive_rcvd;
> >>  };
> >>
> >> +enum {
> >> +     EFA_FLAGS_HOST_INFO_SET_BIT,
> >> +     EFA_FLAGS_NUM,
> >> +};
> >> +
> >>  struct efa_dev {
> >>       struct ib_device ibdev;
> >>       struct efa_com_dev edev;
> >> @@ -62,6 +67,7 @@ struct efa_dev {
> >>       struct efa_irq admin_irq;
> >>
> >>       struct efa_stats stats;
> >> +     DECLARE_BITMAP(flags, EFA_FLAGS_NUM);
> >>  };
> >
> > Why do you need such over-engineering?
> > What is wrong with old school "u8 flag"?
>
> The main reason is for the atomic test_and_set_bit() usage, otherwise it would
> be an atomic flag, not u8 flag.

But efa_dev can be opened with different applications and they can have
different user space versions, but you are setting this info for the
first caller only. How will it help for the debug?

Thanks
