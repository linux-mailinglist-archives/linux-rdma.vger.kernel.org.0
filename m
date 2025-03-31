Return-Path: <linux-rdma+bounces-9041-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97547A76D3A
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Mar 2025 21:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39E6116B9DB
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Mar 2025 19:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43ADF21B9CA;
	Mon, 31 Mar 2025 19:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRR+inl/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03447219A7E
	for <linux-rdma@vger.kernel.org>; Mon, 31 Mar 2025 19:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743447867; cv=none; b=fySAJ9N95htWZnSwC8+B/bFyyv+xjcBI2rlSW99QM51+Di38ks9/jw44KaouiPx9HmFRBRE8kl91t/z6au8/wJdjrX5apFnkIsd31AD5pd2k45hmYg8ROQixiz0a1oDpb+oRdsMSOBrfjfXlA/gNBPlQY2Mi/gQ+BL9xm9h3MUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743447867; c=relaxed/simple;
	bh=Fpa9H+EanZX2ziKcUyJ6BIqkjX9uevY7AzICTs54SJs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NWza7qrbYsTSFcRKpZlW76YrjEitbYDOL+bYqtie9SnBXZPNcyO2INQzj/NHPdJ4FW6XHb6JdfxVE4ePk1EIgsa/hnAK1Dx7W3fxHBWbL4H0tQ3hp47qP5MWA145KHxKI8PlFY6rVTFNvgiaw7RoCAPLa4vnn3lm+cHTLa+1TUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRR+inl/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43826C4CEE9;
	Mon, 31 Mar 2025 19:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743447866;
	bh=Fpa9H+EanZX2ziKcUyJ6BIqkjX9uevY7AzICTs54SJs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=XRR+inl/MpC2zmCYCyyUj38xILer3Qn/A4Q6tGJ20fzkrkc5jO/YrM8UgF8qhtw9Q
	 jRuH6jI5gZTljcT8ZA1Vlu31XuvCfMYkm/2N07gO6istsYOL/imLMbo4h61jjcKFii
	 tWbQOCNo+CCtmRmotpY7gaUGTM98MJVOdHfsyD5q6mdKLBa7ZNE1A1t9gng5rTWp5d
	 6EcPJaD3YUxMOeLeRBgvFedKXg7j1MKee1V1oGkRkgKgY7vC7dVazvAIu4DBkRqxSy
	 iT1ZF3jCNkm56JmbC/xcYMvYlHUKbRvnd1BAIxdRQeAgPsJ0iGV1DELN0PdY7scPmM
	 d2z5ClesT2E/w==
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 49FD71200068;
	Mon, 31 Mar 2025 15:04:25 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-10.internal (MEProxy); Mon, 31 Mar 2025 15:04:25 -0400
X-ME-Sender: <xms:OefqZ-bwgaUmep4U4AXPPaTscnelSW9_3Wqd9Va5Gsc88jipCnWrQQ>
    <xme:OefqZxZSwAZvPFD5NKtkGgU_qMHq4dN066OX_-Yyw9HID5nc1faa53DYjBuIZ5Gdw
    ATZu9lGcPU_zj3R234>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukedtjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedfnfgvohhnucftohhmrghnohhvshhkhidfuceolhgvohhnsehkvg
    hrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnhepjeevffelgfelvdfgvedvteelhefh
    vdffheegffekveelieevfeejteeileeuuedvnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheplhgvohhnodhmvghsmhhtphgruhhthhhpvghrshho
    nhgrlhhithihqdduvdeftdehfeelkeegqddvjeejleejjedvkedqlhgvohhnpeepkhgvrh
    hnvghlrdhorhhgsehlvghonhdrnhhupdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjghhgsehnvhhiughirgdrtghomhdprhgtphhtthhope
    hshhgrhigusehnvhhiughirgdrtghomhdprhgtphhtthhopehlihhnuhigqdhrughmrges
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:OefqZ48PS2GnGtbQtDapCOGAvPysS3gEDnuEdQqw2j4cQj6esoBYrQ>
    <xmx:OefqZwqGp3vRh-Hr1iMHOLFQSBJ8gshDx9vRH8WgGqDGTV9cNWzsOw>
    <xmx:OefqZ5rSPKIP53KocfGeW71N0aDQ-TKBlchku9nKgwHTeG1ElmsMYg>
    <xmx:OefqZ-Sj-uulrZXEyyvgG5zyX9CkDrkArluXotDAdyjGW84us8R1eg>
    <xmx:OefqZ5oxxOlyZPsIq8QKrPJ3iIUw83JJP-ltcibPY7ayiLLTh4QEDo8_>
Feedback-ID: i927946fb:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 188EC1C20067; Mon, 31 Mar 2025 15:04:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T6ce1347145fe67da
Date: Mon, 31 Mar 2025 22:04:05 +0300
From: "Leon Romanovsky" <leon@kernel.org>
To: "Jason Gunthorpe" <jgg@nvidia.com>
Cc: "Shay Drory" <shayd@nvidia.com>, linux-rdma@vger.kernel.org
Message-Id: <a066aa6e-ff4d-4043-a963-52ce83aaf111@app.fastmail.com>
In-Reply-To: <20250331174524.GA291154@nvidia.com>
References: 
 <c6cb92379de668be94894f49c2cfa40e73f94d56.1742388096.git.leonro@nvidia.com>
 <20250319172349.GM9311@nvidia.com> <20250326105854.GB4558@unreal>
 <20250331174524.GA291154@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA/core: Silence oversized kvmalloc() warning
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, Mar 31, 2025, at 20:45, Jason Gunthorpe wrote:
> On Wed, Mar 26, 2025 at 12:58:54PM +0200, Leon Romanovsky wrote:
>> On Wed, Mar 19, 2025 at 02:23:49PM -0300, Jason Gunthorpe wrote:
>> > On Wed, Mar 19, 2025 at 02:42:21PM +0200, Leon Romanovsky wrote:
>> > > From: Shay Drory <shayd@nvidia.com>
>> > > 
>> > > syzkaller triggered an oversized kvmalloc() warning.
>> > > Silence it by adding __GFP_NOWARN.
>> > 
>> > I don't think GFP_NOWARN is the right thing..
>> > 
>> > We've hit this before and I think we ended up adding a size limit
>> > check prior to the kvmalloc to prevent the overflow triggered warning.
>> 
>> The size check was needed before this commit was merged:
>> 0708a0afe291 ("mm: Consider __GFP_NOWARN flag for oversized kvmalloc() calls")
>> 
>> From that point, the correct solution is simply provide __GFP_NOWARN flag.
>
> I'm not sure, NOWARN removes all warnings, even normal OOM warnings
> from regually sized allocations which we don't want to remove.

I disagree, this allocation is called from user space. We can safely skip OOM messages and error here will be enough.

Thanks 

>
> Jason

