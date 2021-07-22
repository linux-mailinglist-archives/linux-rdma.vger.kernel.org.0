Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6294A3D2509
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jul 2021 16:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbhGVNU7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Jul 2021 09:20:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232138AbhGVNU7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Jul 2021 09:20:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E10D161244;
        Thu, 22 Jul 2021 14:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626962494;
        bh=eiDxxd//gnTbTNSR24XDd8/FL9m8NuhTNJPdqWZj7iY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OhpD7MPGE8Mux2cJOYR9tnhkNrpjHxjAj+cIha8er718rnErTvOM0XsI56POTzNOL
         DI5sqzSpg2gh+s4k/pZOhzLQPpZ7SLuyOozq3HzHyWrVtrcR+M/UwEqH9VznuPLg+t
         StoU0Z9/mRBVdH+PY/99jB6APmLuE4L4cgfx3pYy2lepHzFHlZOp289t3TusVLfD4b
         t+sLRvKikaRXCy6Zn+qm9TJOkye7xzVuHPRobYI9Du7Tlj04zSQGHzkWoFd4pw//xv
         l2l1f8QUy47qNwhjIJfuFLVjIrr6YPWSA3x9UW0PaWhzOMJcOcYcnJnUTx8WpiPSzG
         DS/dMEnb+MPxA==
Date:   Thu, 22 Jul 2021 17:01:30 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dakshaja Uppalapati <dakshaja@chelsio.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, bharat@chelsio.com
Subject: Re: [PATCH for-rc] iw_cxgb4: Fix refcount underflow while destroying
 cqs.
Message-ID: <YPl6Oh5Gm0uQPiiZ@unreal>
References: <1626866515-17895-1-git-send-email-dakshaja@chelsio.com>
 <YPkhhDkvYY2JVM+6@unreal>
 <20210722120607.GE1117491@nvidia.com>
 <YPlrQ1Uu+OXxRJBF@unreal>
 <20210722130231.GI1117491@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722130231.GI1117491@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 22, 2021 at 10:02:31AM -0300, Jason Gunthorpe wrote:
> On Thu, Jul 22, 2021 at 03:57:39PM +0300, Leon Romanovsky wrote:
> 
> > We are talking about two different issues that this refcount_read patch pointed.
> > You are focused on wrong usage of completion, I saw useless compare of
> > refcount_t with 0 that can't be.
> 
> It can be zero. Anything that does refcount_dec_and_test() can make
> the refcount be zero.

It can be, but it is not the case at least for iwpm.

Thanks
