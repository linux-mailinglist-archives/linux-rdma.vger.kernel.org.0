Return-Path: <linux-rdma+bounces-18558-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FNpNMI+wmmCagQAu9opvQ
	(envelope-from <linux-rdma+bounces-18558-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 08:35:30 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6858A3040DF
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 08:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DF1A301A16D
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 07:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39EA3CF05F;
	Tue, 24 Mar 2026 07:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="sTXgekOO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DyYn+RCb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DD63CA4BB;
	Tue, 24 Mar 2026 07:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774337300; cv=none; b=laVHWz+akV7z1J8apPYeSczUkH2HLNVJ2A6exUJ1nV9gaWFPMJevicIWETY0fTQnn4UPn5bXvm3lg7WKeUjXj+kMyHqpLjxqwhdFe5l0WwYbLZSzq15dhGBkILJwbIo7MH2I59eQyVEHA422OEQOgy4p72n5joUeC7vQF+ArnSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774337300; c=relaxed/simple;
	bh=9935aNNQSQsiXYuLACLVcgBUs03N3gemjcUbf0bEKIE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mAh5Ylid5zfHqqcwgT5mB2lKBMG6IBtcv8BWuoR/asR/UnGNrsPSutQgWdCpVL0jWfAWsFrMd9bVmrJjgghP55RbC4IAsZv4zF3nRR3k5xLyfsGBUNtLi9HZYYolkLk+MHTDDCdXxXjz0B9szzz8lW9/b01kEduPHqyfCfATLew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=sTXgekOO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DyYn+RCb; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 951101D00022;
	Tue, 24 Mar 2026 03:28:10 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 24 Mar 2026 03:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774337290;
	 x=1774423690; bh=WsgImSphwgKtJLr9aZyE1zO9zb0v904xqgk9dOrxycM=; b=
	sTXgekOOBGfVABvr5F49sQHdiUjCFSvxMLwU91L5dJ0hO7vb23QuVRi1yMBKnCtc
	Y0hVMSgKZnKDyU4yARFKRyrewVzvLh4sBA2jqtOQP2+feWJOn8YcNdtnhGtxex86
	XMvEPPvcc/d505kwk/92mEQ9EGRs5f8iHdDRRifLPezwm9PDddjOv41IkfSKfSbL
	c29wM+wG88KWuLs0+7p59drWXDeCh3qr12hMo1TCpZ6Lxjh4dj2J91RanLG1vVBE
	iM6p8f/nAAvpfYDedOSSwPaPQldrNkSA7C1NudxxiFxOzC8VQHbt4nXRc556VjdF
	bDfTS5rbc9xE3ZQc82teYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774337290; x=
	1774423690; bh=WsgImSphwgKtJLr9aZyE1zO9zb0v904xqgk9dOrxycM=; b=D
	yYn+RCbKrus5/2S0ttN1Kky8v1i4berXXoP+4Lz34rbaMcoVNlJFM+OiscqQ9oN7
	7ZmVY7upJM7Czwa5Y/Dkns5aXTTYsL4VURKqFf8qS4nbHl0KWINYyz8p6PVqiamP
	AOo9IDGpOQpgX4dfBmmrMBe/LyXp+x9f1U7pHvYkxllix0oMkh9kT5EXEQekrZQW
	9gGnU2tag8cygNMvSUjvC0kiUWCZQahe0c35m705Yx5uIHaO64Msw70VtEbiyqkJ
	Y0YWLoU+TuO8BrH7GKTAmM1tk//RdRLGhlwEI00vmR1Wc+WjxIZQjrPayS/H9Evt
	aI+h8FogwlObnrYt2imlA==
X-ME-Sender: <xms:CT3CaR3Aqg8B_ehwA-Cd5e4kaJPt0xMdzwyFEsUyTO7iCDZCY_1stA>
    <xme:CT3CaS6umDBVdWlVLVM-zhBzi0JiSljBP110HO0ugemQIr_n406bn-TzUSV36Cgjm
    6XEjPtjlRDrnNsAb2jqgeT8Aalsww_LQGQ0Xf5iO21tC1m7r9mWQjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddtleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopeguvghnnhhishdruggrlhgvshhsrghnughrohestghorhhnvghlih
    hsnhgvthifohhrkhhsrdgtohhmpdhrtghpthhtohepnhhitghkrdguvghsrghulhhnihgv
    rhhsodhlkhhmlhesghhmrghilhdrtghomhdprhgtphhtthhopehjuhhsthhinhhsthhith
    htsehgohhoghhlvgdrtghomhdprhgtphhtthhopehmohhrsghosehgohhoghhlvgdrtgho
    mhdprhgtphhtthhopehmihgthhgrvghlrdhjrdhruhhhlhesihhnthgvlhdrtghomhdprh
    gtphhtthhopehmihhkvgdrmhgrrhgtihhnihhsiiihnhesihhnthgvlhdrtghomhdprhgt
    phhtthhopegrrhhnugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgvohhnsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehmihhnghhosehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:CT3CaX5YYj7C0FiL4IUjJ9UFGuPYJ6-0T5qMPLAKEkvx9sTjY45mVA>
    <xmx:CT3CaWQt75SdCgTGxZJsBCfh5n4BvTWhlNogj_AKLL8sFAXF21LQ9w>
    <xmx:CT3CaW9pzawDXlZiKjpI-cZ38t8RbV4CRA3SM2lktbVMZ2JdrqidRA>
    <xmx:CT3CaXocvNByBARs-rlxlhHySBEoYUBsyh7iiOl_27N1wxu69rcw_w>
    <xmx:Cj3CaYmV2kUdZ_Sl0AEKTVLUOp26bHB4_48Lc_DLXaisxyottZZE_tPp>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 34E5F700069; Tue, 24 Mar 2026 03:28:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AhovTUn8f-P3
Date: Tue, 24 Mar 2026 08:27:45 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dennis Dalessandro" <dennis.dalessandro@cornelisnetworks.com>,
 "Leon Romanovsky" <leon@kernel.org>
Cc: "Arnd Bergmann" <arnd@kernel.org>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Mike Marciniszyn" <mike.marciniszyn@intel.com>,
 "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
 "Doug Ledford" <dledford@redhat.com>,
 "Nick Desaulniers" <nick.desaulniers+lkml@gmail.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 "Marco Crivellari" <marco.crivellari@suse.com>,
 "Ingo Molnar" <mingo@kernel.org>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Message-Id: <4b177986-dc77-4d0a-95a9-329ef62c1c94@app.fastmail.com>
In-Reply-To: <8f060e86-5727-4cf6-ac03-7f7174b5a9fd@cornelisnetworks.com>
References: <20260320151511.3420818-1-arnd@kernel.org>
 <20260320151511.3420818-2-arnd@kernel.org>
 <6b56c476-86fd-4d43-8dee-c7f89d346941@app.fastmail.com>
 <20260323080848.GF814676@unreal>
 <5d5f25fc-e522-4131-ae4b-22db57b92d6e@app.fastmail.com>
 <20260323110144.GG814676@unreal>
 <8f060e86-5727-4cf6-ac03-7f7174b5a9fd@cornelisnetworks.com>
Subject: Re: [PATCH 2/3] RDMA/hfi1, rdmavt: open-code rvt_set_ibdev_name()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-18558-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[kernel.org,ziepe.ca,intel.com,redhat.com,gmail.com,google.com,suse.com,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma,lkml];
	NEURAL_HAM(-0.00)[-0.978];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arndb.de:dkim,messagingengine.com:dkim,app.fastmail.com:mid]
X-Rspamd-Queue-Id: 6858A3040DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026, at 22:47, Dennis Dalessandro wrote:
> On 3/23/26 7:01 AM, Leon Romanovsky wrote:
>> On Mon, Mar 23, 2026 at 09:48:59AM +0100, Arnd Bergmann wrote:
>>> - The use of INFINIBAND_RDMAVT seems unnecessary: right now
>>>    this is only used by hfi1, now shared with hfi2 but later to
>>>    be exclusive to the latter. Since it is unlikely to ever
>>>    be used by another driver again, this may be a good time
>>>    to drop the abstraction again and integrate it all into
>>>    hfi2, with the old version getting dropped along with hfi1.
>> 
>> The best approach is to drop rdmavt as well, since hfi2 is expected to
>> align with the other drivers in drivers/infiniband/hw.
>> 
>> Dennis, is this feasible?
>
> Feasible yes. I'd like to get hfi2 crossed off the list and in the tree 
> first though. Then come back and do that. I'd like to do more than just 
> plop rdmavt inside hfi2 and call it a day. There is a lot of code 
> cleanup/simplification that we can do.

Does rdmavt have its own user-space ABI? If there is anything that
you'd want to change, this might be the one chance to do it, otherwise
I see nothing wrong with integrating it only after hfi1 is gone.

      Arnd

