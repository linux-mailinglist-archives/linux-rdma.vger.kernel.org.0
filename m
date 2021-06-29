Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D053B6E57
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jun 2021 08:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhF2GnA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Jun 2021 02:43:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:37656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231958AbhF2Gm7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Jun 2021 02:42:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8983261CC7;
        Tue, 29 Jun 2021 06:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624948833;
        bh=uiM4ZLlUWZ7h4sImIXL++IvKwJZNxgmEDXyACS1QTvs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j6zrxtJXNmcJ0vPKYlN/1Pzt7zNEI2j40Jkd3N/MyETUJ6fx6rpLOVJ2FrzVz/WGM
         CCXlSV7ex+o2UyH+HaEkFDYM6/B5a66SO7X/E4KuUo8PztoNnCc+QEE0J2Vd9PoFyc
         AJyZodXD8XqUNmvakICvix3VewBfBAFnJ80eDaYG5g08jvXpAy3cMQjFZzW/vfExmB
         5JTS1GDI0AivZ/qubH9PWOPAhto2D71jMUgZ7PSlCSdTCxi7mVo6SI9e3NNBC4EkLs
         dUoDBA0XFhu9IE5871dUnmiBMTLI3ZPOx9oH78JdnRZWCKmyPZ9KeS10O24XvvpjD/
         CL9MjO2pvR7yA==
Date:   Tue, 29 Jun 2021 09:40:29 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Pavel Skripkin <paskripkin@gmail.com>,
        Shay Drory <shayd@nvidia.com>
Subject: Re: [PATCH rdma-rc v2] RDMA/core: Simplify addition of restrack
 object
Message-ID: <YNrAXW/94SJkOO0g@unreal>
References: <e2eed941f912b2068e371fd37f43b8cf5082a0e6.1623129597.git.leonro@nvidia.com>
 <20210624174841.GA2906108@nvidia.com>
 <YNgxxTQ4NW0yGHq1@unreal>
 <20210627231528.GA4459@nvidia.com>
 <YNlcpfdsdJdwMp5l@unreal>
 <20210628113813.GA21676@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628113813.GA21676@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 28, 2021 at 08:38:13AM -0300, Jason Gunthorpe wrote:
> On Mon, Jun 28, 2021 at 08:22:45AM +0300, Leon Romanovsky wrote:
> > > The previous code didn't call restrack_del. restrack_del undoes the
> > > restrack_set_name stuff, not just add - so it does not leave things
> > > back the way it found them
> > 
> > The previous code didn't call to restrack_add and this is why it didn't
> > call to restrack_del later. In old and new code, we are still calling to
> > acquire and release dev (cma_acquire_dev_by_src_ip/cma_release_dev) and
> > this is where the CM_ID is actually attached.
> 
> Which is my point, you can't call restrack_del anyplace except the
> final destroy. It cannot be used for error unwinding in these kinds of
> functions

ok, let's remove the controversial hunks.

> 
> Jason
