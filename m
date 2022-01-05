Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50DBA484FCD
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 10:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiAEJLI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 04:11:08 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48366 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbiAEJLH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jan 2022 04:11:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AC03615BD;
        Wed,  5 Jan 2022 09:11:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38CE2C36AE9;
        Wed,  5 Jan 2022 09:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641373866;
        bh=kM9mTfGjeMKoTg9FtqFA5zlpHmibKdR5+3waD/BYsEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gXZJj1cPkGjXLqZ6aViXF/gvv8w3cCPfI/q3vgA8ebmVDjmCoFcGNRUHKrOznSAu9
         DAPuPZAQyT+JXfiz6qM4C4oOH8tSeAH0FxwYHScPRQD5Epml74RCRazE/K0osDBGs7
         aouRtb9MzdVrs3hYRGOVe2KKbpcMnxtVMv8jNjXwYgnFzk0oZNgLgyRnafTe83apq9
         DUAkvP3cCLedbRfJ4SSRWEclZ8436ZhkWpIZrqEsplPuVRNmOKfEPx+yuyQud7GXXK
         N/LRreuzVNcwXhtjSzT5BLX4NxrX0KYMnuugo6wR9bDwg8tUQEzIqV/3h7oXrcifo6
         vLtlVY91FHsYg==
Date:   Wed, 5 Jan 2022 11:11:01 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/rxe: Delete deprecated module parameters
 interface
Message-ID: <YdVgpRUsI9CIwTLw@unreal>
References: <c8376d7517aebe7cc851f0baaeef7b13707cf767.1641372460.git.leonro@nvidia.com>
 <CAD=hENesikgUsZ8-DLxNJMR7Wg17WcfXxnvArpa9o6B6bw9Phw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=hENesikgUsZ8-DLxNJMR7Wg17WcfXxnvArpa9o6B6bw9Phw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 05, 2022 at 04:55:23PM +0800, Zhu Yanjun wrote:
> On Wed, Jan 5, 2022 at 4:50 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > From: Leon Romanovsky <leonro@nvidia.com>
> >
> > Starting from the commit 66920e1b2586 ("rdma_rxe: Use netlink messages
> > to add/delete links") from the 2019, the RXE modules parameters are marked
> > as deprecated in favour of rdmatool. So remove the kernel code too.
> 
> Do you mean that rxe_cfg tool can not be used again?

That tool was removed from the rdma-core a long time ago.

Thanks
