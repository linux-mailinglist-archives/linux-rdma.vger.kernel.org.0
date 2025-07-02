Return-Path: <linux-rdma+bounces-11824-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD4DAF0E29
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 10:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D01EA3AC2E3
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 08:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57483199FAB;
	Wed,  2 Jul 2025 08:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LA1RdfcH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173E8163
	for <linux-rdma@vger.kernel.org>; Wed,  2 Jul 2025 08:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751445398; cv=none; b=FVs1KJAdhWF+p+f2YDbwGeOpJ/KiHbZvP6lRfBIhHsN0VCsfxFrE6Z78OHbjrPRWte8z9SLxJhlp9BNaBMyUt6nSHM8/ExoGHSnNypeIisrUV6CKfqojYJvnQhAuyaLMc9rRA4ri8y/enm8ZxbR8pPyV8DRE3pPz9kCnQUTqnsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751445398; c=relaxed/simple;
	bh=H5YpvHC1Do+0pHC4OCb2wWsak0tLbifwdPlhEGxafeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJ7yPgCktB/6uVWW4JqQ2z89gdacEV5MV68KenQUtHBKMnMUtFo0Auq9Mainsz6ZMTl6hSsip2/dhW8n2TDyTy4FN8xafNFW7E/GiFG7SAvN/RpSOM1jHZiUgKpCcKc0M89A1W3OBgkVeUWydE5D5HB16bDtlBnMJ5QKHC4jVdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LA1RdfcH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E209DC4CEED;
	Wed,  2 Jul 2025 08:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751445395;
	bh=H5YpvHC1Do+0pHC4OCb2wWsak0tLbifwdPlhEGxafeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LA1RdfcH89748ingMQ3FGgQ/Skyw/qEBMttTrb2vBtCfRbPO0FNjCT+l5NOdV2edO
	 Qlmzldz5VQ0X6akK40N5A0QfLry5gRvZL1m+XMFgjhuxPvRKq/mlVCwhOI5clYxPnl
	 4x/a8L2YQU4YHaqh8ZaXS7SPBSm1ruZYNYlRO7dl9di1g9JNo8CYE0kBOFMChcV06m
	 F0jFILqTq2/3Oku1T4VfStaQ4Slbbwtt6XeU+L+oBfjDp7sYK5QE/Wb7RZ2FNXjcGp
	 UdPMROp5ZUFZO56AFp3CGlb19950jL3E1QE1vS3j4OxIgewvxaJF3qsB6KtEGRZ1fn
	 R17VmOfxA3m1w==
Date: Wed, 2 Jul 2025 11:36:31 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: jgg@ziepe.ca, Dean Luick <dean.luick@cornelisnetworks.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 05/23] RDMA/core: Add writev to uverbs file
 descriptor
Message-ID: <20250702083631.GI6278@unreal>
References: <175129726945.1859400.4492277779101226937.stgit@awdrv-04.cornelisnetworks.com>
 <175129741281.1859400.9193550583285999392.stgit@awdrv-04.cornelisnetworks.com>
 <20250701123254.GC6278@unreal>
 <32fb1fe6-b21a-4105-ac2c-cbdcd277a59d@cornelisnetworks.com>
 <20250701160415.GG6278@unreal>
 <aed06612-2e0f-41ed-a0f7-e9f3c55ce657@cornelisnetworks.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aed06612-2e0f-41ed-a0f7-e9f3c55ce657@cornelisnetworks.com>

On Tue, Jul 01, 2025 at 01:17:48PM -0400, Dennis Dalessandro wrote:
> On 7/1/25 12:04 PM, Leon Romanovsky wrote:
> > On Tue, Jul 01, 2025 at 09:57:23AM -0400, Dennis Dalessandro wrote:
> >> On 7/1/25 8:32 AM, Leon Romanovsky wrote:
> >>> On Mon, Jun 30, 2025 at 11:30:12AM -0400, Dennis Dalessandro wrote:
> >>>> From: Dean Luick <dean.luick@cornelisnetworks.com>
> >>>>
> >>>> Add a writev pass-through between the uverbs file descriptor and
> >>>> infiniband devices.  Interested devices may subscribe to this
> >>>> functionality.
> >>>
> >>> Aren't we use IOCTL and not write interface now?
> >>> Why do we need this?
> >>
> >> We wanted to keep all the semantics of the user interface the same so it's an
> >> easy migration to the uverbs cdev from the private cdev. The idea is that all
> >> the command and control is still ioctl, but the "data path" is still using the
> >> writev() to pass in the iovecs.
> > 
> > ok, just add this to the commit message.
> > 
> 
> Will do.
> 
> >> By the way I'll get the rdma_core (user space) changes posted soon so you can
> >> see both sides.
> > 
> > BTW, I looked whole series and upto MAD/verbs interface everything looks ok.
> > The latter simply broke me with >3K LOC in single patch.
> 
> Yeah sorry about all that. The advantage to the new chip is we don't need to do
> all of the MAD stuff in the kernel because it's now done in FW. So most of it is
> just carried over from hfi1. The driver just needs to find out about some
> things. Would it help if I point out the major differences? I could take a crack
> and trying to break that up more even.

It will help if you can separate machine generated code vs. real logic.
MAD patches are not the worst part. For example, this one:
https://lore.kernel.org/all/175129743814.1859400.4253022820082459886.stgit@awdrv-04.cornelisnetworks.com/
 3 files changed, 17722 insertions(+)

With a lot of functions like this, with random casting, multiple
parameters without use e.t.c

+static u64 access_sw_pio_drain(const struct cntr_entry *entry,
+			       void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->verbs_dev.n_piodrain;
+}

+static u64 access_sw_ctx0_seq_drop(const struct cntr_entry *entry,
+                                  void *context, int vl, int mode, u64 data)
+{
+       struct hfi2_devdata *dd = context;
+
+       return dd->ctx0_seq_drop;
+}

> 
> -Denny
> 

