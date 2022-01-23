Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44E54974E6
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Jan 2022 20:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiAWTNG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Jan 2022 14:13:06 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60134 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiAWTNF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Jan 2022 14:13:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DC7561044;
        Sun, 23 Jan 2022 19:13:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155EBC340E4;
        Sun, 23 Jan 2022 19:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642965184;
        bh=GJPd6oWq/9UOGgtYOqM5tOECxwhKwp2mxJxFwAAeO2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cYlPo3tkXmU4veIUKk9yFbqjWQnGwSpfYNOF3mExP8FuaeK6uuIeWVdiLMl328sXN
         pRvYceR+bcwg5vYMxfH8vFtOrZxydvRoF0z0BkTq9zhllEn2r377Px2zRhqOMJCHdV
         QZwTibz3nNjoWQxcYjVguWWlxWW2rHpDUeXNmegfAie1B7DaagbqLAuiOAR0Z/peQ5
         FYd2HmOgO0THGdp2ATn2x+YoO7Y+LwTTdhjRG08RGej5nRLlezR0OMmbE2B1yXjo/n
         fROYUoN/6xhpwpyvzzwxXts9SRvVyHPhB7gtaEAEBOXSS9ZQouVpD1eURc5a7LlT19
         +fyWifImbo7KA==
Date:   Sun, 23 Jan 2022 21:13:00 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 18/54] drivers/infiniband: replace cpumask_weight with
 cpumask_empty where appropriate
Message-ID: <Ye2ovL0UwQ2X4w7z@unreal>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
 <20220123183925.1052919-19-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220123183925.1052919-19-yury.norov@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jan 23, 2022 at 10:38:49AM -0800, Yury Norov wrote:
> drivers/infiniband/hw/hfi1/affinity.c code calls cpumask_weight() to check
> if any bit of a given cpumask is set. We can do it more efficiently with
> cpumask_empty() because cpumask_empty() stops traversing the cpumask as
> soon as it finds first set bit, while cpumask_weight() counts all bits
> unconditionally.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  drivers/infiniband/hw/hfi1/affinity.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Except that title needs to be: "RDMA/hfi: ....", the change looks ok.

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
