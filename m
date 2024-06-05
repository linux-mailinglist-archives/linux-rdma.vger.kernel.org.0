Return-Path: <linux-rdma+bounces-2868-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 216B78FC219
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 05:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D253B284BEF
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 03:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038E36BB5C;
	Wed,  5 Jun 2024 03:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGjgZkXP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A371C27;
	Wed,  5 Jun 2024 03:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717556758; cv=none; b=uuw/AIvumJsAAEdRaLX9BLl3vBwfNyDNzBgW1QUtKfANjb6RX6zz07PYQ74vpdke1uDAj/yQ9QzoGhhoCrnV/4teeJB6tbFR+1l21gDJnhL77FCnvAvmzdJdbU1ZfW3ZEmfGv1YAgHmUKC4Vb/7KNggsTIUHJrT1MxxyKY8iY88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717556758; c=relaxed/simple;
	bh=IG7WZS3pJSVB5DKH1hBbC0PbvVmqju2H17fLTu5ShWU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vcc6nFktbJuc4n4lHL5bIuC+9+UfR/hgw+79BCLofSdvWyKLoVBNx6wXIGFcGTr2xMt3Us1EU+jaDo1wumVG7rer7zbcwG1LHJ40vBMOfOXzo8cPVe33ICToSCMNHjDnomzc2nV7q7850qmv/qIN7BOPNQTR2gNKCNvErotlEhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGjgZkXP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2883BC2BBFC;
	Wed,  5 Jun 2024 03:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717556758;
	bh=IG7WZS3pJSVB5DKH1hBbC0PbvVmqju2H17fLTu5ShWU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bGjgZkXP7zppROP8WMjAKBvTpcC8f+/pujcS5qImEU/4e7KppU70Ly8VBRjZeaYf8
	 5ZEcmh66xwy/D2++LtwpukQjNJ7dNCxfC1LTvYIk7nG9+qa4tzU4Z4I89msvtnguPH
	 PPmzL2As3nEPAG+LlDRtQZv6qL9oEtohPFs4wnMzZDAZ+P8rAbRaQFLIncthCASKUG
	 HUxxEDvPpf/r3HMJxeQcNkRplR2hzIIKAAouKhy45B+9FmFi5kpcOy975hc+EYZxyE
	 BDRG6zL/KT1zQ868XOn8JlJ1q4Ze7syhNnL6tTJx/8N9WsFc4d61quaY6FqNqh1QJh
	 akO0g3FvP5DVQ==
Date: Tue, 4 Jun 2024 20:05:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: David Ahern <dsahern@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Jonathan Corbet <corbet@lwn.net>, "Itay Avraham" <itayavr@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, Andy Gospodarek <andrew.gospodarek@broadcom.com>, Aron
 Silverton <aron.silverton@oracle.com>, Christoph Hellwig
 <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>, Leonid Bloch
 <lbloch@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 <linux-cxl@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH 0/8] Introduce fwctl subystem
Message-ID: <20240604200556.398afd07@kernel.org>
In-Reply-To: <665fa9c9e69de_4a4e62941e@dwillia2-xfh.jf.intel.com.notmuch>
References: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
	<20240603114250.5325279c@kernel.org>
	<214d7d82-0916-4c29-9012-04590e77df73@kernel.org>
	<20240604070451.79cfb280@kernel.org>
	<665fa9c9e69de_4a4e62941e@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Jun 2024 16:56:57 -0700 Dan Williams wrote:
> Jakub Kicinski wrote:
> [..]
> > I don't begrudge anyone building proprietary options, but leave
> > upstream out of it.  
> 
> So I am of 2 minds here. In general, how is upstream benefited by
> requiring every vendor command to be wrapped by a Linux command?
> [...]

Thanks for sharing the CXL experience and your perspective.
Also for trying to frame the discussion in a useful way,
although I have little faith that it will help :( Fingers crossed?

> * Integrity: Subsystem has a responsibility to meet kernel-lockdown
>   expectations:
> 
>   Distros and system owners need to be assured that root's ability to
>   modify the running kernel image are mitigated. For CXL there are 2 ways
>   to do this, require Linux wrapper commands for all the low level
>   commands (status quo), or a new trust the device to publish which
>   commands have user data effects in something CXL calls the "Command
>   Effects Log". In that "trust Command Effects" scenario the kernel still
>   has no idea what the command is actually doing, but it can at least
>   assert that the device does not claim that the command changes the
>   contents of system-memory. Now, you might say, "the device can just
>   lie", but that betrays a conceit of the kernel restriction. A device
>   could lie that a Linux wrapped command when passed certain payloads does
>   not in turn proxy to a restricted command. So at some point there is
>   almost always an out-of-tree way to get around the kernel restriction,
>   so the question is are we better off giving a blessed path or force
>   vendors into ugly out-of-tree workarounds?

The integrity thing is a double edge sword, so I don't have much to say
here. If we take a few wrong turns we'll wrap the vendor commands with
crypto and then the vendor can control which commands you get to run ;)
Obviously I'm joking, and not saying that the intent of the current
series! But its about as realistic as "this will only be used for truly
vendor specific things".

> * Introspection / validation: Subsystem community needs to be able to
>   audit behavior after the fact.
> 
>   To me this means even if the kernel is letting a command through based
>   on the stated Command Effect of "Configuration Change after Cold Reset"
>   upstream community has a need to be able to read the vendor
>   specification for that command. I.e. commands might be vendor-specific,
>   but never vendor-private. I see this as similar to the requirement for
>   open source userspace for sophisticated accelerators.

That sounds pretty CXL specific, and IIUC unrealistic.
You assume you have some specification to consult, while this discussion
has been going for over a year now, and I can't get the vendors to share
what those turntables they so desperately need to tweak are.

> * Collaboration: open standards support open driver maintenance.
> 
>   Without standards we end up with awkward situations like Confidential
>   Computing where every vendor races to implement the same functionality
>   in arbitrarily different and vendor specific ways.
> 
>   For CXL devices, and I believe the devices fwctl is targeting, there
>   are a whole class of commands for vendor specific configuration and
>   debug. Commands that the kernel really need not worry about.
> 
>   Some subsystems may want to allow high-performance science experiments
>   like what NVMe allows, but it seems worth asking the question if
>   standardizing device configuration and debug is really the best use of
>   upstream's limited time?

No, but it's not about science experiments, really. It's about
production features. The effort of implementing something properly
upstream is high. I cost time and money to get the right caliber of
people and let them go thru the revisions. I lack confidence that
merging fwctl will not negatively impact motivation for companies to
pay off our accrued technical debt. While all they need is "this simple
little feature". And before competition wins the customer. It's a race
to the bottom.

>   One of the release valves in the CXL space is openly specified
>   commands with opaque payloads, like "Read Vendor Debug Log". That is
>   clear what it does, likely a payload the kernel need never worry
>   about, and the "Command Effects" is empty. However, going forward there
>   is a new class of commands called "Set/Get Feature" that allow a wide
>   range of vendor toggles to be deployed which will need an upstream
>   response for the driver policy to vendor-specific "Features".
>
> So if fwctl, or something like it, can strike a balance of enforcing
> integrity and introspection while encouraging collaboration on the
> aspects that are worth upstream collaboration, I think that is a
> conversation worth having.

I presume you were trying to underscore that the decision is unavoidably
a trade off, which is true. But I don't follow the exact formulation.
Is fwctl helping integrity or collaboration? If we assume use of vendor
tools is unavoidable, then I guess integrity? I really can't see how it
helps collaboration when everyone ships their custom tool set.

Back to the tradeoff. For networking, which is a _very_ mature subsystem
with a ton of standards the need to do "vendor specific things" is
marginal. The downside of the loss of an "upstream advantage" is obvious.
We need to take such decisions on subsystem by subsystem basis.
You should be able to draw the lines differently for CXL than how we
draw them for TCP/IP.

On the technical level the discussion can't go very far, because I'd
like to hear actual user problems. But I can't even get a list of those
infamous thousands of knobs :|

