Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02003E917B
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Aug 2021 14:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhHKMdx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Aug 2021 08:33:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:43750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhHKMdw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 11 Aug 2021 08:33:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 976B760FE6;
        Wed, 11 Aug 2021 12:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628685209;
        bh=WrrtTzWS6ytK2LSjg1r0kgi2+JYBKELWE5CJX5IvZSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L8Gzzs68USWYTWgGOFNWeF0L1Xy9p4uwMSY5B3/S7krSnS5FR65ndLPFK+b8NlpIC
         IbieZImoA0Tbj0Mjj3eb+zrwupgPgCJKwFkJ6PJ/OpT/jrg0wGkJxvSZovXb7Lzezy
         YhZuKo84VCitpeDMbzxRjmGY+3oU4aqks54TnZRVmYsjdFNB/LA1m+C070lHfLB1Vk
         OWOagFXE/ZWjy7PoERTM9rp5CR2XtBeYHcxvWJkPSMg0H89Ao7I7ekHv5IzubBZAef
         +pg+9a0PfweOU10abE9/vmQLHToqH+lUBkr3Ooo5MkXW3D1wJoqXOrjrTtJavxVgmA
         HJKTN1w6RIKYw==
Date:   Wed, 11 Aug 2021 15:33:25 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/core/sa_query: Remove unused function
Message-ID: <YRPDlTHjagRUqtOS@unreal>
References: <1628684831-26981-1-git-send-email-haakon.bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1628684831-26981-1-git-send-email-haakon.bugge@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 11, 2021 at 02:27:11PM +0200, Håkon Bugge wrote:
> ib_sa_service_rec_query() was introduced in kernel v2.6.13 by commit
> cbae32c56314 ("[PATCH] IB: Add Service Record support to SA client")
> in 2005. It was not used then and have never been used since.
> 
> Removing it.
> 
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> ---
>  drivers/infiniband/core/sa_query.c | 101 -------------------------------------
>  include/rdma/ib_sa.h               |  10 ----
>  2 files changed, 111 deletions(-)

You shouldn't stop there and remove ib_sa_service_rec_callback,
ib_sa_service_rec_release, ib_sa_service_query and probably
ib_sa_service_rec.

Thanks
