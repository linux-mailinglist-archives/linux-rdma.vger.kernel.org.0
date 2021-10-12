Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA18C429DCA
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Oct 2021 08:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbhJLGhC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Oct 2021 02:37:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:58492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232340AbhJLGhB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 Oct 2021 02:37:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D181560E94;
        Tue, 12 Oct 2021 06:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634020500;
        bh=6tfLVaefD1roogNKAU4dyj9lb08CMuOf4tQ5HnLLmBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h0znyG/AbTjoqtgVka6QLkUO8S4+dIlGvPo66TWyADZjqnChse84Q2AdaNfOZcqPQ
         9t1vRww9x2QL/isj23cOc/AF92feFeLLyp9TCwDwzQ7shmQ2xhpNEBfh0Obl5qc5Gx
         yOuUhtS4kmgfqnsP1B+w7pWtCT/UBWQlE19RkyrwcT/eEmORXbcvJ/C72Pyl50gTZi
         kXDA8/Ras0geYeTUJr0BAFqD3btt9M9ytkpVvl+RlGx9XxtJuKKLT84383e4tVbYAi
         wHM6vM5Sy0t+IlVOizoDXqdbatk2+qSuLT+u++Up65iEdIblzZzlJhmqpXq26KOPi7
         /UPjkHReUT+9Q==
Date:   Tue, 12 Oct 2021 09:34:56 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 0/6] RDMA/rxe: Fix potential races
Message-ID: <YWUskJBU5ZHrIhhS@unreal>
References: <20211010235931.24042-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211010235931.24042-1-rpearsonhpe@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 10, 2021 at 06:59:25PM -0500, Bob Pearson wrote:
> There are possible race conditions related to attempting to access
> rxe pool objects at the same time as the pools or elements are being
> freed. This series of patches addresses these races.

Can we get rid of this pool?

Thanks

> 
> Bob Pearson (6):
>   RDMA/rxe: Make rxe_alloc() take pool lock
>   RDMA/rxe: Copy setup parameters into rxe_pool
>   RDMA/rxe: Save object pointer in pool element
>   RDMA/rxe: Combine rxe_add_index with rxe_alloc
>   RDMA/rxe: Combine rxe_add_key with rxe_alloc
>   RDMA/rxe: Fix potential race condition in rxe_pool
> 
>  drivers/infiniband/sw/rxe/rxe_mcast.c |   5 +-
>  drivers/infiniband/sw/rxe/rxe_mr.c    |   1 -
>  drivers/infiniband/sw/rxe/rxe_mw.c    |   5 +-
>  drivers/infiniband/sw/rxe/rxe_pool.c  | 235 +++++++++++++-------------
>  drivers/infiniband/sw/rxe/rxe_pool.h  |  67 +++-----
>  drivers/infiniband/sw/rxe/rxe_verbs.c |  10 --
>  6 files changed, 140 insertions(+), 183 deletions(-)
> 
> -- 
> 2.30.2
> 
