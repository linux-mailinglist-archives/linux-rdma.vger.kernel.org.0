Return-Path: <linux-rdma+bounces-434-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B384B815F13
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Dec 2023 13:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F989282EB4
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Dec 2023 12:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B75A42AB4;
	Sun, 17 Dec 2023 12:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUqZMohV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509503399B;
	Sun, 17 Dec 2023 12:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94430C433C7;
	Sun, 17 Dec 2023 12:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702817438;
	bh=piYVlV3TNLVWsK5uBqrNzt1SsTLgbXbksN2rzDkzB/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IUqZMohV7DIF/lmUYf9AsNdILN3arRDYUCXUNGL7zcA3gJMb0y79i1PclLAcJ1twX
	 C+MLMN89mPUVV4N0tzZQyK0xO0pgsU94qRYqeM0EuXMRVkY9t7vV4csasYq6ItwDL0
	 WJlFTU/5oSqnhAERF2dIVz4PKgMoP0mQ2JqbjZSfhD3IkF4skUqfWxXA/Q8xALQXWG
	 TipJpriioZeUPRUJMnG6W69lv3hGD888Dr3aDp60+BmHhIjGc90GQ6yuA3QvleKdhK
	 90k9ieWtXZpEYP/dhnpdP5RyUwio4lywfPCBFF0BYXGWYK4Y1kEdpiyRApewYRJfNw
	 uONrszevNqv+g==
Date: Sun, 17 Dec 2023 14:50:33 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Daniel Vacek <neelx@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] IB/ipoib fixes
Message-ID: <20231217125033.GA4886@unreal>
References: <20231211130426.1500427-1-neelx@redhat.com>
 <170236977177.265346.10129245400198931968.b4-ty@kernel.org>
 <CACjP9X-Ez80KXtquy-g1wqPwRr-orW8uBy=rvowh2hvJT1s_Nw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACjP9X-Ez80KXtquy-g1wqPwRr-orW8uBy=rvowh2hvJT1s_Nw@mail.gmail.com>

On Wed, Dec 13, 2023 at 01:18:26PM +0100, Daniel Vacek wrote:
> On Tue, Dec 12, 2023 at 9:29 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> >
> > On Mon, 11 Dec 2023 14:04:23 +0100, Daniel Vacek wrote:
> > > The first patch (hopefully) fixes a real issue while the second is an
> > > unrelated cleanup. But it shares a context so sending as a series.
> > >
> > > Daniel Vacek (2):
> > >   IB/ipoib: Fix mcast list locking
> > >   IB/ipoib: Clean up redundant netif_addr_lock
> > >
> > > [...]
> >
> > Applied, thanks!
> 
> Thank you.
> 
> One small detail - I was asked by Yuya to change the "Reported-by" as follows:
> 
> ---
> Reported-by: Yuya Fujita <fujita.yuya-00@fujitsu.com>
> ---
> 
> Would that be possible? And if yes, could you amend the commit
> yourself or do you want me to send a v3?

Unfortunately, it is already too late as we promoted my wip branch to be
official rdma/for-next.

Thanks

> 
> --nX
> 
> 
> > [1/1] IB/ipoib: Fix mcast list locking
> >       https://git.kernel.org/rdma/rdma/c/4f973e211b3b1c
> >
> > Best regards,
> > --
> > Leon Romanovsky <leon@kernel.org>
> >
> 

