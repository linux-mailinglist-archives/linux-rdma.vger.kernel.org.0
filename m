Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 640D416EF36
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2020 20:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730530AbgBYTnI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Feb 2020 14:43:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:47782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728051AbgBYTnI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 Feb 2020 14:43:08 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7EED2084E;
        Tue, 25 Feb 2020 19:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582659787;
        bh=IHrgPP49DSPfY+v9re9shI/JhABPyHCoV+Cg8Gx+DHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sn9MXIxXp6jpFv+R9Koj5yB2bkLlwrZMcU0xlDNU0cUTZ5hUndiPYpGZlPe6z5kqD
         RITANokslE4ygARAaqemNfGGbvDYLmQaZwRBVZwe0INTqjShCYh5Aa4D12CXZYeIv/
         yW15xBvpqKpujtyFVSuWAIbSjgOGv13u+L2epmO8=
Date:   Tue, 25 Feb 2020 21:43:03 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jens Domke <jens.domke@riken.jp>
Cc:     Haim Boozaglo <haimbo@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: "ibstat -l" displays CA device list in an unsorted order
Message-ID: <20200225194303.GA12414@unreal>
References: <2b43584f-f56a-6466-a2da-43d02fad6b64@mellanox.com>
 <20200225074815.GB5347@unreal>
 <a854a50a-cce3-3a36-9fed-1e5ce3a34669@mellanox.com>
 <20200225091815.GE5347@unreal>
 <52f4364b-30c5-5c62-36bb-78341ca8fe6e@riken.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52f4364b-30c5-5c62-36bb-78341ca8fe6e@riken.jp>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 26, 2020 at 02:18:06AM +0900, Jens Domke wrote:
> Dear Leon,
>
> with all due respect, but if you don't want to be part of the solution,
> then please at least stop being part of the problem!

To talk about solution, someone needs actually to convince that the
problem exists and right now we are talking about change in internal
implementation of pretty well explained feature - provide device list.

>
> I (and highly likely many other admins out there who don't follow this
> list) am in full support of Haim's request for sorted output.

I don't see any API or utils in the rdma-core which promised to provide
sorted output.

>
> Not everything can/will be pinned down in a manpage, but if you insist
> then sure someone can submit a amendment to the ibstat documentation
> which demands alphanumeric sorting for the NICs/ports.

The manual is not enough, what about other tools? Should we update them
too? Or do we need to make ibstat special while rest of the tools keep
the list unsorted?

Maybe I'm part of the problem, but any solution will require unified
approach for whole rdma-core, so users like you will get stable and
consistent result from any rdma-core API/tool.

Thanks

>
> Best,
> Jens
>
>
> On 2/25/20 6:18 PM, Leon Romanovsky wrote:
> > On Tue, Feb 25, 2020 at 10:36:05AM +0200, Haim Boozaglo wrote:
> > >
> > >
> > > On 2/25/2020 9:48 AM, Leon Romanovsky wrote:
> > > > On Mon, Feb 24, 2020 at 08:06:56PM +0200, Haim Boozaglo wrote:
> > > > > Hi all,
> > > > >
> > > > > When running "ibstat" or "ibstat -l", the output of CA device list
> > > > > is displayed in an unsorted order.
> > > > >
> > > > > Before pull request #561, ibstat displayed the CA device list sorted in
> > > > > alphabetical order.
> > > > >
> > > > > The problem is that users expect to have the output sorted in alphabetical
> > > > > order and now they get it not as expected (in an unsorted order).
> > > >
> > > > Do we have anything written in official man pages about this expectation?
> > > > I don't think so, there is nothing "to fix".
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > > Best Regards,
> > > > > Haim Boozaglo.
> > >
> > > Ok, but for many years people got used to getting sorted output in
> > > alphabetical order and now they don't get it.
> >
> > Like for many other things, those people will adapt.
> >
> > Thanks
> >
