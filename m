Return-Path: <linux-rdma+bounces-1848-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9B389C5D6
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 16:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26654283145
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 14:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DD67F499;
	Mon,  8 Apr 2024 14:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M67WO3MO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB667F47E;
	Mon,  8 Apr 2024 14:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584860; cv=none; b=HH6glVVfF0dTCSfTwjEVvuw0O2Xy5qGMTrfl0HVauhTVeH3H+0dIMJYlaMwtqlby+kA4nY0Z/yJy8+zihICR2OntpuJjomLmE30VDa/vRIcdtPc5POYvwtInHUqHXpC6xO3punFUq1rD7UPwnZAqrALVkVneeWN1KOcQLmA7R3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584860; c=relaxed/simple;
	bh=LRkUGtbdysI7/tiFWsFk0skJui/QKklnMkcGgNPr+6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9X+5MIZ/vvDOTZIm12zn1Mn8ReQuioOztoUpYRL/BccLxn5UtfjmyrzLVvQOWWCsTFFHd8x8gEhcegaEuBDeXGJvne/KRyHwtOObo6U1/AxJFGtZruV7DAOf2dqma3+z9ISub/NrMKLcG3p0+/NhyhXSOygMPX3BIQXxrfSceo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M67WO3MO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60730C433B2;
	Mon,  8 Apr 2024 14:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712584859;
	bh=LRkUGtbdysI7/tiFWsFk0skJui/QKklnMkcGgNPr+6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M67WO3MO0MT2zVXUR1oJb50r0ESEjtLzRA4KqexN2iQUrs4lX9EEjjnwoQ7T3iuo9
	 967pWN9c0uup1rjOl3TRrWLV1XxCDsgMtSIQoJmqgjOM1e4ni91pUN1SAAiLjTgb6h
	 7wbrxE2MWafJ7nJ9AwsXSG2hXE2FqmB4ptdM+o7eExNvxndFJ9k3v9kz48y2IK0vpk
	 ucl5sZsBQT/03NK3C6EDV2OfsSeoCTM+S6QhJ85J/7tAAEBEGARNw/ksf2m4STgAXL
	 ZVnuEB5CpYwLdFDPG1UcoV/KpKeMQKC/HjhGBKZYYbqzT24R2BNL6T85ZMrtktJZ2j
	 N2fgUWgIlu68Q==
Date: Mon, 8 Apr 2024 17:00:55 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@microsoft.com>
Cc: Konstantin Taranov <kotaranov@linux.microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>,
	Long Li <longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next v4 0/4] Define and use mana queues for CQs and
 WQs
Message-ID: <20240408140055.GH8764@unreal>
References: <1712567646-5247-1-git-send-email-kotaranov@linux.microsoft.com>
 <20240408112533.GF8764@unreal>
 <PAXPR83MB05570E9EE9853B2E6F66703DB4002@PAXPR83MB0557.EURPRD83.prod.outlook.com>
 <20240408130024.GG8764@unreal>
 <PAXPR83MB05573802DE8859318A7B1435B4002@PAXPR83MB0557.EURPRD83.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR83MB05573802DE8859318A7B1435B4002@PAXPR83MB0557.EURPRD83.prod.outlook.com>

On Mon, Apr 08, 2024 at 01:47:45PM +0000, Konstantin Taranov wrote:
> > From: Leon Romanovsky <leon@kernel.org>
> > On Mon, Apr 08, 2024 at 12:50:12PM +0000, Konstantin Taranov wrote:
> > > > From: Leon Romanovsky <leon@kernel.org> On Mon, Apr 08, 2024 at
> > > > 02:14:02AM -0700, Konstantin Taranov wrote:
> > > > > From: Konstantin Taranov <kotaranov@microsoft.com>
> > > > >
> > > > > This patch series aims to reduce code duplication by introducing a
> > > > > notion of mana ib queues and corresponding helpers to create and
> > > > > destroy them.
> > > > >
> > > > > v3->v4:
> > > > > * Removed debug prints in patches, as asked by Leon
> > > > >
> > > > > v2->v3:
> > > > > * [in 4/4] Do not define an additional struct for a raw qp
> > > > >
> > > > > v1->v2:
> > > > > * [in 1/4] Added a comment about the ignored return value
> > > > > * [in 2/4] Replaced RDMA:mana_ib to RDMA/mana_ib in the subject
> > > > > * [in 4/4] Renamed mana_ib_raw_qp to mana_ib_raw_sq
> > > > >
> > > > > Konstantin Taranov (4):
> > > > >   RDMA/mana_ib: Introduce helpers to create and destroy mana queues
> > > > >   RDMA/mana_ib: Use struct mana_ib_queue for CQs
> > > > >   RDMA/mana_ib: Use struct mana_ib_queue for WQs
> > > > >   RDMA/mana_ib: Use struct mana_ib_queue for RAW QPs
> > > > >
> > > > >  drivers/infiniband/hw/mana/cq.c      | 52 +++-------------
> > > > >  drivers/infiniband/hw/mana/main.c    | 39 ++++++++++++
> > > > >  drivers/infiniband/hw/mana/mana_ib.h | 26 ++++----
> > > > >  drivers/infiniband/hw/mana/qp.c      | 93 +++++++++-------------------
> > > > >  drivers/infiniband/hw/mana/wq.c      | 33 ++--------
> > > > >  5 files changed, 96 insertions(+), 147 deletions(-)
> > > >
> > > > It doesn't apply.
> > > >
> > >
> > > I guess there was some mis-synchronisation between us.
> > > I see that you have already applied the patch 6 days ago:
> > > https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.
> > >
> > kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Frdma%2Frdma.git%2
> > Flog%
> > >
> > 2F&data=05%7C02%7Ckotaranov%40microsoft.com%7C09ea6de381194295c
> > 4ae08dc
> > >
> > 57cbe121%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C63848178
> > 04102717
> > >
> > 33%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMz
> > IiLCJBTiI
> > >
> > 6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=jwGGhmatHqdN4bW
> > Xc%2FtyXtubD
> > > ZxxCXpnyL26S5lEKd0%3D&reserved=0
> > >
> > > I am sorry for sending a newer version after the patch has been applied.
> > > I have not checked this before sending.
> > > I can take care of useless debug prints in a future cleanup patch.
> > 
> > Please rebase your series, and resend.
> 
> Sorry for a confusion. I mean you have already applied this patch series (v3) 6 days ago.
> See commits:
> 46f5be7cd4bceb3a503c544b3dab7b75fe4bb96b
> 60a7ac0b8bec5df9764b7460ffee91fc981e8a31
> 688bac28e3dc9eb795ae8ea5aa40cb637e289faa
> f10242b3da908dc9d4bfa040e6511a5b86522499
> 
> As a result, I cannot rebase. I could send a completely new patch that removes some debug prints.

Yes, sorry for not being clear. Please send a cleanup patch.

Thanks

