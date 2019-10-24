Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90D01E2A7A
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 08:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437718AbfJXGjO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 02:39:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:38096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436471AbfJXGjO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Oct 2019 02:39:14 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32A4720679;
        Thu, 24 Oct 2019 06:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571899153;
        bh=Wn7uHqNhE9Kbi5Yw02r5AUgxgu4F1qfjuRC8SuMQicw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bfCtQxbNO69wRu/Pf9fkuGv8R79rXz+dmOtcuFGSEGGB5C176bb47oa2dXBVDKvxR
         Tc4CNjM0UeGBTDhHGfrDIRaV2Zd3St8ghe50IbjUjOqBCU7zwPEscN1/GejEq2Aadf
         7LA590632pIjESJnXJaG1BsWxvL9liI2oewNKu14=
Date:   Thu, 24 Oct 2019 09:39:09 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-next] selftests: rdma: Add rdma tests
Message-ID: <20191024063909.GQ4853@unreal>
References: <20191023173954.29291-1-kamalheib1@gmail.com>
 <20191023174219.GO23952@ziepe.ca>
 <20191023201008.GA30186@kheib-workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023201008.GA30186@kheib-workstation>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 23, 2019 at 11:10:08PM +0300, Kamal Heib wrote:
> On Wed, Oct 23, 2019 at 02:42:19PM -0300, Jason Gunthorpe wrote:
> > On Wed, Oct 23, 2019 at 08:39:54PM +0300, Kamal Heib wrote:
> > > Add a new directory to house the rdma specific tests and add the first
> > > rdma_dev.sh test that checks the renaming and setting of adaptive
> > > moderation using the rdma tool for the available RDMA devices in the
> > > system.
> >
> > What is this actually testing? rdmatool?
> >
>
> This is a very basic test that uses the rdmatool for checking two of the
> RDMA devices functionalities.
>
> > This seems like a very strange kselftest to me.
> >
>
> Basically, you can take a look into other subsystems selftests (e.g.
> net) to see that it not that strange :-).

Yeah, selftests is in-kernel dumpster, everything goes in. It doesn't
mean we should follow this path too. The in-kernel tests are great to
check interfaces and not external tools.

>
> Yes, the first test is very basic, but the idea behind it is to utilize
> the kernel selftests infrastructure to test the rdma subsystem, I plan to
> introduce more tests in the near future, hopefully other folks from the
> community will join me too.

You don't have any version checks, the idea that you can test latest
kernel features with installed "rdmatool" in distro is a little bit over
optimistic.

>
> Thanks,
> Kamal
>
> > Jason
