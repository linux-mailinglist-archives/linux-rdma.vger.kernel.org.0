Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE667BAE4
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 09:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfGaHqR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 03:46:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbfGaHqR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Jul 2019 03:46:17 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A763320693;
        Wed, 31 Jul 2019 07:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564559176;
        bh=pe1up4zFQ4sGOHOOMudEM1F81DWL69LUHXzX/+zDaJk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qR59RJkUC8ciHnZ+pG1wj2hy+JnuXgqLXZ1gtyLKivDNjRjzwbu3pcs+FxRi3xYiS
         VN//IN6/cqmAKWysvuG8Orvc/XsD9gX3igy8p4h8Gi6UOa3CCCWMZhNPPpf8djOj22
         0RJIEwAWCEL0E51cauF6wN372UmU9pRas/6h4wIw=
Date:   Wed, 31 Jul 2019 10:46:12 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc] RDMA/restrack: Track driver QP types in resource
 tracker
Message-ID: <20190731074612.GM4878@mtr-leonro.mtl.com>
References: <20190730110137.37826-1-galpress@amazon.com>
 <20190730133817.GC4878@mtr-leonro.mtl.com>
 <24f4f7e3-dada-5185-3988-2e821b321bc1@amazon.com>
 <20190730151936.GE4878@mtr-leonro.mtl.com>
 <1a7f11e2-ae90-3173-b24a-aae11731cad1@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a7f11e2-ae90-3173-b24a-aae11731cad1@amazon.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 31, 2019 at 10:05:31AM +0300, Gal Pressman wrote:
> On 30/07/2019 18:19, Leon Romanovsky wrote:
> > On Tue, Jul 30, 2019 at 04:49:52PM +0300, Gal Pressman wrote:
> >> On 30/07/2019 16:38, Leon Romanovsky wrote:
> >>> On Tue, Jul 30, 2019 at 02:01:37PM +0300, Gal Pressman wrote:
> >>>> The check for QP type different than XRC has wrongly excluded driver QP
> >>>> types from the resource tracker.
> >>>>
> >>>> Fixes: 78a0cd648a80 ("RDMA/core: Add resource tracking for create and destroy QPs")
> >>>
> >>> It is a little bit over to say "wrongly". At that time, we did it on purpose
> >>> because it was unclear how to represent such QP types to users and we didn't
> >>> have vendor specific hooks introduced by Steve later on.
> >>
> >> It's very confusing to see a test running and zero QPs in "rdma res".
> >> I'm fine with removing the "wrongly" :), but I still think this should be
> >> targeted to for-rc as a bug fix.
> >
> > Yes, please remove "wrongly" and change Fixes line to be
> > "Fixes: 40909f664d27 ("RDMA/efa: Add EFA verbs implementation")",
> > because before addition of EFA driver all other drivers had QPs.
>
> How are DC QPs being counted?

They were not counted on purpose. We didn't imagine acceptance of
non-RDMA driver which doesn't support any standard QPs and doesn't
work with kernel verbs.

Thanks
