Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8921E42397F
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Oct 2021 10:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237670AbhJFIPc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Oct 2021 04:15:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237620AbhJFIPa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 Oct 2021 04:15:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E20D60F9D;
        Wed,  6 Oct 2021 08:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633508018;
        bh=eZW0sSP4MNWRu4WboxSZGJRop2Ci7CawOQpLfALDSDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qP9AvHrBUm/qh7j0JC7WUBr1tqf08Ucz920LPMghz8BDVAnh0fQFu0alnBEM3pMw5
         U2S1CvkvRvD7N3TR5pLFJy4vwHsbERTIzMyk/RVOT/TF9R7SwxsezmXbPh2GdUwXjS
         F0mk/Ja86njPbeaM3kKJszRzD7ZkNZAWGli66+E8WJJw0qG8BgTPNDmFjYkZctfdeo
         Tt9gZ4StyAyEBTuA2HVuf4hgCcXPi5G+1gurftBrTBvv51actLVci3JeR2uQK3r1oQ
         K1FDXvsBx6aKghG85hQ2u5IGsJ1g0g1ES5YeMQl1IjdUl/CJt6Nbok5PFX334D4SdP
         tRp0Puw8+a+/w==
Date:   Wed, 6 Oct 2021 11:13:34 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Provider/rxe: Allocate rxe/ib objs by calloc
Message-ID: <YV1armPsHlgi3DgW@unreal>
References: <20210930113527.49659-1-mie@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930113527.49659-1-mie@igel.co.jp>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 30, 2021 at 08:35:27PM +0900, Shunsuke Mie wrote:
> Some rxe/ib objects are allocated by malloc() and initialize manually
> respectively. To prevent a bug caused by memory uninitialization, this
> patch change to use calloc().
> 
> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> ---
>  providers/rxe/rxe.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 

Thanks, applied.
