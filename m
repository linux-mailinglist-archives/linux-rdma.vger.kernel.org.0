Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E31461FFDC
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2019 08:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfEPGwI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 May 2019 02:52:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbfEPGwI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 May 2019 02:52:08 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 461B32082E;
        Thu, 16 May 2019 06:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557989527;
        bh=uiEWkScWR/1gI8Yt/W7max4IqhJbp5SwqYp/bLX63HI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xnAE/1KOJaPbULl6Cdt6WQeigBrc2Ifpm6xtdkcvhIObHPPNZfrTA5bHVmVZ4qNnd
         dTysC3xPCGVTKr3+P2T1N7935hJhcLO0P8/wmhBt5n5YzMk3GxL1W+R4NVdIYETc2k
         zgH9kt0UN+PtiLBci2sWp0xuWNBMSh9TibiXAF8I=
Date:   Thu, 16 May 2019 09:52:04 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [RFC PATCH rdma-next v2] RDMA/srp: Rename SRP sysfs name after
 IB device rename trigger
Message-ID: <20190516065204.GU5225@mtr-leonro.mtl.com>
References: <20190515170638.11913-1-leon@kernel.org>
 <97b980a9-6a2a-234e-c12c-b7ee5fd4262e@acm.org>
 <20190515183342.GQ5225@mtr-leonro.mtl.com>
 <054e8b16-ca7b-674f-96a9-b1f8cc78884f@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <054e8b16-ca7b-674f-96a9-b1f8cc78884f@acm.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 15, 2019 at 08:43:33PM +0200, Bart Van Assche wrote:
> On 5/15/19 8:33 PM, Leon Romanovsky wrote:
> > On Wed, May 15, 2019 at 07:32:35PM +0200, Bart Van Assche wrote:
> >> On 5/15/19 7:06 PM, Leon Romanovsky wrote:
> >>> +	list_for_each_entry_safe(host, tmp_host, &srp_dev->dev_list, list) {
> >>> +		char name[IB_DEVICE_NAME_MAX * 2] = {};
> >>                           ^^^^^^^^^^^^^^^^^^^^^^
> >> I think this should be IB_DEVICE_NAME_MAX + 8 instead of ... * 2. Please
> >> also consider to leave out the initialization of the char array since
> >> snprintf() overwrites the array whether or not it has been initialized.
> >
> > Any reason why shoud we care for this micro optimizations?
>
> Good kernel developers care about writing code that is not confusing to
> the reader. IB_DEVICE_NAME_MAX * 2 is confusing because the generated
> string is not built of two device names. The "= {}" part is confusing
> because immediately after that initialization the entire string gets
> overwritten. This makes the reader wonder: what does that initialization
> do there?
>
> >>> +		snprintf(name, IB_DEVICE_NAME_MAX * 2, "srp-%s-%d",
> >>                                ^^^^^^^^^^^^^^^^^^^^^^
> >> Please change this into sizeof(name) such that the size expression only
> >> occurs once.
> >
> > The same as sizeof it is calculated once at the stage of defines
> > expansion.
>
> I think that snprintf(buf, sizeof(buf), ...) is much more common in the
> kernel than snprintf(buf, size_expression, ...).

No problem, you think that it is important, I'll change.

Thanks for the review.

>
> Thanks,
>
> Bart.
>
