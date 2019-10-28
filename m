Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38C58E7358
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 15:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730496AbfJ1OHT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 10:07:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730388AbfJ1OHS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 28 Oct 2019 10:07:18 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBA73205ED;
        Mon, 28 Oct 2019 14:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572271638;
        bh=/RshxhbL9N90hYm2MFXSFdkhq0RwUE+p1VQykN5ANQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IAShDbqg/qPtodl2i9m51kg6gSXTOeoLsM+pMp6wAofPiP6SCCGt7/YDSRd4CZz3u
         85XnL2AVTo9PFTC1+9pQ6scJ7YdjlrAdIvOsD2QeHH2Xurqb+ucojy7qhe+U2avRyu
         hZ2TLWYMJOI1kCyjkWCgz8xwATBmqfsVqBpsdw0U=
Date:   Mon, 28 Oct 2019 16:07:15 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Or Gerlitz <gerlitz.or@gmail.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Michael Guralnik <michaelgur@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v1] IB/mlx5: Test write combining support
Message-ID: <20191028140715.GJ5146@unreal>
References: <20191027062234.10993-1-leon@kernel.org>
 <CAJ3xEMiV-ufcJST70i7J1UOkmx2tV=kc77GiRYKX8Yq4UyXpZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ3xEMiV-ufcJST70i7J1UOkmx2tV=kc77GiRYKX8Yq4UyXpZQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 28, 2019 at 03:38:13PM +0200, Or Gerlitz wrote:
> On Sun, Oct 27, 2019 at 8:29 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > From: Michael Guralnik <michaelgur@mellanox.com>
> >
> > Add a test in mlx5_ib initialization process to test whether
> > write-combining is supported on the machine.
> > The test will run as part of the enable_driver callback to ensure that
> > the test runs after the device is setup and can create and modify the
> > QP needed, but runs before the device is exposed to the users.
> >
> > The test opens UD QP and posts NOP WQEs, the WQE written to the BlueFlame
> > is differnet from the WQE in memory, requesting CQE only on the BlueFlame
>
> nit: different

Thanks, Jason/Doug should I resend?

>
> > WQE. By checking whether we received a completion on one of these WQEs we
> > can know if BlueFlame succeeded and whether write-combining is supported.
> >
> > Change reporting of BlueFlame support to be dependent on write-combining
> > support.
