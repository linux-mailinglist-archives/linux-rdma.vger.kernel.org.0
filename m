Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7BA03E14BD
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Aug 2021 14:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241390AbhHEMad (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Aug 2021 08:30:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241386AbhHEMad (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Aug 2021 08:30:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC46961050;
        Thu,  5 Aug 2021 12:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628166619;
        bh=oHpRbH759WgNKrrgklJx6/f8NSNkMtCqiEdRLlBlBxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=umGMcWlwMH2Ah/swXE9UPY5eK/oTl3ZpCnmugc8YqSQ2gG06lCHwB2Lg5GHlgW/gF
         lyzzLZWd4bKH10xLE3Brnykrle2hlZcbfrg+pRfBiCJqIsnd+Q0NooNcCXXgx/aX2l
         DpBjOw/zzsinmFb+OcleIjSY0FlbMIdlb++J5oJ0DPaQQHkDrG10z/ML/fyFgyFJJJ
         KAhsa/l3a/QPF888jT3jzvl1a5CyjjKG9QzQF9kbT/EdrJpEEbumAUOWsWef3+Dh8m
         tFKDsrfF+8mRf8h2g5ujQSjjPfTVw0AE4b2nHP3JdyG4S71MbznTzI/56YvBIiMguE
         m6OZZGo0huDIw==
Date:   Thu, 5 Aug 2021 15:30:15 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     YueHaibing <yuehaibing@huawei.com>, liangwenpeng@huawei.com,
        liweihang@huawei.com, dledford@redhat.com, chenglang@huawei.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] RDMA/hns: Fix return in hns_roce_rereg_user_mr()
Message-ID: <YQvZ14oSAYEuSTA3@unreal>
References: <20210804125939.20516-1-yuehaibing@huawei.com>
 <YQqb0U43eQUGK641@unreal>
 <f0921aa3-a95d-f7e4-a13b-db15d4a5f259@huawei.com>
 <YQtdswHgMXhC7Mf5@unreal>
 <974d3309-3617-6413-5a8d-c92b1b2f8dfe@huawei.com>
 <YQvEbUp9cE5G535E@unreal>
 <20210805122311.GJ543798@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805122311.GJ543798@ziepe.ca>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 05, 2021 at 09:23:11AM -0300, Jason Gunthorpe wrote:
> On Thu, Aug 05, 2021 at 01:58:53PM +0300, Leon Romanovsky wrote:
> 
> > > IMO, if ibv_rereg_mr failed, the mr is in undefined state, user
> > > needs to call ibv_dereg_mr in order to release it, so there no
> > > need to recover the original state.
> > 
> > The thing is that it undefined state in the kernel.  What will be if
> > user will change access_flags and try to use that "broken" MR
> > anyway? Will you catch it?
> 
> rereg is not atomic, if the rereg fails in the middle the mr should be
> left in some safe state.

It is not the case in the hns flow, they leave such MR in limbo state.

> 
> Jason
