Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F53A14974B
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Jan 2020 19:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgAYSuv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 25 Jan 2020 13:50:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:43592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbgAYSuv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 25 Jan 2020 13:50:51 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 424E3206F0;
        Sat, 25 Jan 2020 18:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579978250;
        bh=FrP3Lg8qYlzk8jQ23wIdfLUibCeo50zRFrZ8A5yWh48=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XxNmGpd/RE8k2DpCywmnI7M75RcVHKJWJr0f5nAw9kEclZldDFqgb+hhQWhhDEMyd
         t79y+CVoUoIh1vIhlfhqiu/JENJUIZ6ArQbt3/fNS1HRZc+EmiyeLLga2xozI3ydXC
         HItTgLgjm9bBk5jgYMFObrjJGp9GdKJjGoUAddPc=
Date:   Sat, 25 Jan 2020 20:50:45 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-next 1/7] RDMA/bnxt_re: Refactor queue pair creation
 code
Message-ID: <20200125185045.GB2993@unreal>
References: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com>
 <1579845165-18002-2-git-send-email-devesh.sharma@broadcom.com>
 <20200124112347.GA35595@unreal>
 <CANjDDBjJygjcbbwDFtwVS--GF5YtYAiZL78_jiqHf+TMkQ7j+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANjDDBjJygjcbbwDFtwVS--GF5YtYAiZL78_jiqHf+TMkQ7j+g@mail.gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jan 25, 2020 at 10:33:41PM +0530, Devesh Sharma wrote:
> On Fri, Jan 24, 2020 at 4:53 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Fri, Jan 24, 2020 at 12:52:39AM -0500, Devesh Sharma wrote:
> > > Restructuring the bnxt_re_create_qp function. Listing below
> > > the major changes:
> > >  --Monolithic central part of create_qp where attributes are
> > >    initialized is now enclosed in one function and this new
> > >    function has few more sub-functions.
> > >  --Top level qp limit checking code moved to a function.
> > >  --GSI QP creation and GSI Shadow qp creation code is handled
> > >    in a sub function.
> > >
> > > Signed-off-by: Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
> > > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > > Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
> > > ---
> > >  drivers/infiniband/hw/bnxt_re/bnxt_re.h  |  13 +-
> > >  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 635 ++++++++++++++++++++-----------
> > >  drivers/infiniband/hw/bnxt_re/main.c     |   3 +-
> > >  3 files changed, 434 insertions(+), 217 deletions(-)
> > >
> >
> > Please remove dev_err/dev_dbg/dev_* prints from the driver code.
> Sure I can do that, are you suggesting to add one more patch in this series?
> I guess it should be okay to follow the hw/efa way to  have debug msgs still on.

It is ok to use ibdev_* prints, it is not ok to use dev_* prints.

Thanks

> >
> >
> > Thanks
