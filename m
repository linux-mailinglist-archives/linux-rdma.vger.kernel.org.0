Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8953D2483
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jul 2021 15:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhGVMn2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Jul 2021 08:43:28 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:37727 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbhGVMn2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Jul 2021 08:43:28 -0400
Received: from localhost (potato2.blr.asicdesigners.com [10.193.80.129])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 16MDNxw4014101;
        Thu, 22 Jul 2021 06:24:00 -0700
Date:   Thu, 22 Jul 2021 18:53:59 +0530
From:   Dakshaja Uppalapati <dakshaja@chelsio.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        bharat@chelsio.com, dakshaja@chelsio.com
Subject: Re: [PATCH for-rc] iw_cxgb4: Fix refcount underflow while destroying
 cqs.
Message-ID: <20210722132358.GA26076@chelsio.com>
References: <1626866515-17895-1-git-send-email-dakshaja@chelsio.com>
 <YPkhhDkvYY2JVM+6@unreal>
 <20210722120607.GE1117491@nvidia.com>
 <YPlrQ1Uu+OXxRJBF@unreal>
 <20210722130231.GI1117491@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722130231.GI1117491@nvidia.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thursday, July 07/22/21, 2021 at 10:02:31 -0300, Jason Gunthorpe wrote:
> On Thu, Jul 22, 2021 at 03:57:39PM +0300, Leon Romanovsky wrote:
> 
> > We are talking about two different issues that this refcount_read patch pointed.
> > You are focused on wrong usage of completion, I saw useless compare of
> > refcount_t with 0 that can't be.
> 
> It can be zero. Anything that does refcount_dec_and_test() can make
> the refcount be zero.
> 
> The issue here is that refcount_dec() cannot make the refcount zero as
> it is improper use of the API.

Hi Jason

I didn't understood properly. Can you please tell that the current 
patch for cxgb4 is still wrong?

Thanks
Dakshaja


