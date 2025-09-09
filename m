Return-Path: <linux-rdma+bounces-13181-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D61B4A4ED
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 10:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2777F164046
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 08:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350A023C4E0;
	Tue,  9 Sep 2025 08:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POOEaJgs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EE51EFF8D;
	Tue,  9 Sep 2025 08:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405837; cv=none; b=ftVlZ6RezxdLwj4iiTALE6MuzK/IWJjFNv0b0vBAscvgo7U10DdiLmkd+FdgvNeNitH1ldqnckFexF19PRWyzfcFGThoFTHhzyvIHtAM3o0jHA7VSFWoXEzAiqZLPb/TR4OxNQP8Etgq/NNK6+27WFJYGDHAGMkoljIXpvXzHlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405837; c=relaxed/simple;
	bh=aUipS3kMgeo7GLk2uFdvRr6hRbolwvX3LCt7v+k4h+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIp7pSO/edxPbZ+Dg3fSKEi9ZfQWNvkqSdmK+BPeXYqfx+ozgVNCP4VzTyb4EHFE4nCXsWnEd6J0EUvuidpmhEGvUatPsWNxwwX6qlbYdoBm+yZxq3y+qiFml6hQxSQDDLaX+s3tINzXz+NXc93X55H4oOOVF7mdPEy1R/ntg7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POOEaJgs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE6DC4CEF4;
	Tue,  9 Sep 2025 08:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757405835;
	bh=aUipS3kMgeo7GLk2uFdvRr6hRbolwvX3LCt7v+k4h+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=POOEaJgsduUADvA5q1LlQQLKbkl92ygv1THhB7+JNKBZlYnoEugikR5Fgn40tXVdD
	 0tZL6ojACJRfRPly2PTQVNsMS5BOcGwSRdXARY3dV9S80JzYBl74E6ndAizOTDwQXe
	 ZXsBNRAkW3f/E7A0PfnUrLHj/M7u2hImU9ORA8iJrt2FdagQMGY+b5GFlcfR8cMN6I
	 a6UPIU4MGU8mWMCFFKnz0NeCSzBz0geQ3nKU6Jj+53OFpNJ1QPW66aUjS9xKF40v7X
	 UQAQpza+sXc6gkgFw/+o6E60QljvmnoiFxFbhx6kKIGuo5S2WqgKZaHiFzQ9kFdc9g
	 fYdqunULu1rOQ==
Date: Tue, 9 Sep 2025 11:17:09 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	michael.chan@broadcom.com
Subject: Re: [PATCH rdma-next 00/10] RDMA/bnxt_re: Add receive flow steering
 support
Message-ID: <20250909081709.GB341237@unreal>
References: <20250822040801.776196-1-kalesh-anakkur.purayil@broadcom.com>
 <175734586236.468086.14323497345307202416.b4-ty@kernel.org>
 <CAH-L+nPP+UU_0NQTh_WTNrrJ5t9GraES0x2r=FyvDMW_Wk2tEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH-L+nPP+UU_0NQTh_WTNrrJ5t9GraES0x2r=FyvDMW_Wk2tEg@mail.gmail.com>

On Mon, Sep 08, 2025 at 09:24:39PM +0530, Kalesh Anakkur Purayil wrote:
> Hi Leon,
> 
> It looks like you have merged V1 of the series. I had already pushed a V2
> of the series which fixes an issue in Patch#10.
> 
> I can push the changes made in Patch#10 as a follow up patch. Please let me
> know.

No need, I fixed it locally.

Thanks

> 
> On Mon, Sep 8, 2025 at 9:07 PM Leon Romanovsky <leon@kernel.org> wrote:
> 
> >
> > On Fri, 22 Aug 2025 09:37:51 +0530, Kalesh AP wrote:
> > > The RDMA stack allows for applications to create IB_QPT_RAW_PACKET
> > > QPs, which receive plain Ethernet packets. This patch adds
> > ib_create_flow()
> > > and ib_destroy_flow() support in the bnxt_re driver. For now, only the
> > > sniffer rule is supported to receive all port traffic. This is to support
> > > tcpdump over the RDMA devices to capture the packets.
> > >
> > > Patch#1 is Ethernet driver change to reserve more stats context to RDMA
> > device.
> > > Patch#2, #3 and #4 are code refactoring changes in preparation for
> > subsequent patches.
> > > Patch#5 adds support for unique GID.
> > > Patch#6 adds support for mirror vnic.
> > > Patch#7 adds support for flow create/destroy.
> > > Patch#8 enables the feature by initializing FW with roce_mirror support.
> > > Patch#9 is to improve the timeout value for the commands by using
> > firmware provided message timeout value.
> > > Patch#10 is another related cleanup patch to remove unnecessary checks.
> > >
> > > [...]
> >
> > Applied, thanks!
> >
> > [01/10] bnxt_en: Enhance stats context reservation logic
> >         https://git.kernel.org/rdma/rdma/c/47bd8cafcbf007
> > [02/10] RDMA/bnxt_re: Add data structures for RoCE mirror support
> >         https://git.kernel.org/rdma/rdma/c/a99b2425cc6091
> > [03/10] RDMA/bnxt_re: Refactor hw context memory allocation
> >         https://git.kernel.org/rdma/rdma/c/877d90abaa9eae
> > [04/10] RDMA/bnxt_re: Refactor stats context memory allocation
> >         https://git.kernel.org/rdma/rdma/c/bebe1a1bb1cff3
> > [05/10] RDMA/bnxt_re: Add support for unique GID
> >         https://git.kernel.org/rdma/rdma/c/b8f4e7f1a275ba
> > [06/10] RDMA/bnxt_re: Add support for mirror vnic
> >         https://git.kernel.org/rdma/rdma/c/c23c893e3a02a5
> > [07/10] RDMA/bnxt_re: Add support for flow create/destroy
> >         https://git.kernel.org/rdma/rdma/c/525b4368864c7e
> > [08/10] RDMA/bnxt_re: Initialize fw with roce_mirror support
> >         https://git.kernel.org/rdma/rdma/c/d1dde88622b99c
> > [09/10] RDMA/bnxt_re: Use firmware provided message timeout value
> >         https://git.kernel.org/rdma/rdma/c/d7fc2e1a321cf7
> > [10/10] RDMA/bnxt_re: Remove unnecessary condition checks
> >         https://git.kernel.org/rdma/rdma/c/dfc78ee86d8f50
> >
> > Best regards,
> > --
> > Leon Romanovsky <leon@kernel.org>
> >
> >
> >
> 
> -- 
> Regards,
> Kalesh AP



