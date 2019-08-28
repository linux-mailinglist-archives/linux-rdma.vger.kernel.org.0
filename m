Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE609F9AE
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2019 07:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbfH1FDN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Aug 2019 01:03:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:54836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbfH1FDN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 28 Aug 2019 01:03:13 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFAA222CED;
        Wed, 28 Aug 2019 05:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566968592;
        bh=jIPhW8p2KWRwWHDGJYfhRvSFwSxoOjSnq18Cq/HmMdM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TluJK/moZB5OvaZHPEVs4iCilrhW5cqixl1V3ftDNh5lOb38OsHXwCBif4vZ50rJa
         Kj3juZMM0QmHFLoCt/E0BoE0Wk1bcDW91QJtTGMKfzTGv7/yxyZl0k6Nlu7KXX/PRK
         gnRFPHQEgqETzpEEYEGdWIDtnFQ0zeN2F1A5DCuM=
Date:   Wed, 28 Aug 2019 08:02:48 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, jgg@ziepe.ca,
        dledford@redhat.com
Subject: Re: [PATCH v3] RDMA/siw: Fix IPv6 addr_list locking
Message-ID: <20190828050248.GC4725@mtr-leonro.mtl.com>
References: <20190827220720.19581-1-bmt@zurich.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827220720.19581-1-bmt@zurich.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 28, 2019 at 12:07:20AM +0200, Bernard Metzler wrote:
> Walking the address list of an inet6_dev requires
> appropriate locking. Since the called function
> siw_listen_address() may sleep, we have to use
> rtnl_lock() instead of read_lock_bh().
>
> Also introduces:
> - sanity checks if we got a device from
>   in_dev_get() or in6_dev_get().
> - skipping IPv6 addresses flagged IFA_F_TENTATIVE
>   or IFA_F_DEPRECATED
>
> Reported-by: Bart Van Assche <bvanassche@acm.org>
> Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---

Bernand,

Can you please post changelog along your patches?

Thanks
