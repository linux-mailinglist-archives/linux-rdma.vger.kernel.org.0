Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064F14336AC
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Oct 2021 15:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhJSNJ4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Oct 2021 09:09:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhJSNJz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 Oct 2021 09:09:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5157C61372;
        Tue, 19 Oct 2021 13:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634648863;
        bh=xIBTPWQR5ZPFkk+4gY/S2gqrKW83K9myDIP0ThTqbHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mPU1KKl3HTTNfnM3/gYk71rHsHlIGR0ppywxb8GDCzFqc5WWti1/3V/k1PCgN0GZE
         pYMNV44u79A5rKG9QP6TQ+5RrcXEPNxiVvZJJN/xxnH8vrDTtFoYib7NYHAleTLCux
         T7uE1Iuu2cp1Kh/JhZvIo7+2UAty1cxto9ndLO4eZPY7yk+Vo7G1UtHdsmcsLflrst
         zQsF6MlA1N2zpEnVTnh0oUJym0HRYWF2mt4sNxKClSTNagTG2iVCfru0N25C/ZBlXq
         1Wrr8W0naUOUzJ3IpTV6QMvtMr714PUOsix4JY69pDZJ/6fibRBGSBgMdV4PjhdBUV
         LZ7dM2TG83cOA==
Date:   Tue, 19 Oct 2021 16:07:38 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 0/6] RDMA/rxe: Fix potential races
Message-ID: <YW7DGrG04eJwbf7d@unreal>
References: <20211010235931.24042-1-rpearsonhpe@gmail.com>
 <YWUskJBU5ZHrIhhS@unreal>
 <bfb21e28-2f92-e372-871e-32c5f72338f4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfb21e28-2f92-e372-871e-32c5f72338f4@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 12, 2021 at 03:19:46PM -0500, Bob Pearson wrote:
> On 10/12/21 1:34 AM, Leon Romanovsky wrote:
> > On Sun, Oct 10, 2021 at 06:59:25PM -0500, Bob Pearson wrote:
> >> There are possible race conditions related to attempting to access
> >> rxe pool objects at the same time as the pools or elements are being
> >> freed. This series of patches addresses these races.
> > 
> > Can we get rid of this pool?
> > 
> > Thanks
> > 
> >>
> >> Bob Pearson (6):
> >>   RDMA/rxe: Make rxe_alloc() take pool lock
> >>   RDMA/rxe: Copy setup parameters into rxe_pool
> >>   RDMA/rxe: Save object pointer in pool element
> >>   RDMA/rxe: Combine rxe_add_index with rxe_alloc
> >>   RDMA/rxe: Combine rxe_add_key with rxe_alloc
> >>   RDMA/rxe: Fix potential race condition in rxe_pool
> >>
> >>  drivers/infiniband/sw/rxe/rxe_mcast.c |   5 +-
> >>  drivers/infiniband/sw/rxe/rxe_mr.c    |   1 -
> >>  drivers/infiniband/sw/rxe/rxe_mw.c    |   5 +-
> >>  drivers/infiniband/sw/rxe/rxe_pool.c  | 235 +++++++++++++-------------
> >>  drivers/infiniband/sw/rxe/rxe_pool.h  |  67 +++-----
> >>  drivers/infiniband/sw/rxe/rxe_verbs.c |  10 --
> >>  6 files changed, 140 insertions(+), 183 deletions(-)
> >>
> >> -- 
> >> 2.30.2
> >>
> 
> Not sure which 'this' you mean? This set of patches is motivated by someone at HPE
> running into seg faults caused very infrequently by rdma packets causing seg faults
> when trying to copy data to or from an MR. This can only happen (other than just dumb
> bug which doesn't seem to be the case) by a late packet arriving after the MR is
> de-registered. The root cause of that is the way rxe currently defers cleaning up
> objects with krefs and potential races between cleanup and new packets looking up
> rkeys. I found a lot of potential race conditions and tried to close them off. There
> are another couple of patches coming as well.

I have no doubts that this series fixes RXE, but my request was more general.
Is there way/path to remove everything declared in rxe_pool.c|h?

Thanks
