Return-Path: <linux-rdma+bounces-2865-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E52A48FBEF4
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 00:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F10C1F237A6
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 22:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D3F14B94E;
	Tue,  4 Jun 2024 22:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gut0Ft8u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018F728DC7;
	Tue,  4 Jun 2024 22:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717540339; cv=none; b=eBRFNxLZFE6mdV9qnUVMz8DnSGvnImyzxytFcWG6EcY8x7DGHQD9cwLhmP+T0LLcpqMIZaDOHxUTq9g6Fr9uNG9GWelPeuGMpyEaj4APrSFvw0dkW8Y3tymrWPMGHagV9p3wheO17Kxt9SH8/Gg1ppNcCIKamMAfWlqSXmBHUZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717540339; c=relaxed/simple;
	bh=QHMdG4wTh/4cAxLzxOS5+p4F6ixCHuPUEV8qdu/4hJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3i0e3AinW1LeahlthfVQyBC2kJ5t9uOKxupLecYCDm4uVlnmy3Y8i3vImTYnaAjI6DR26MSTZ3ochRdyeOVYVoYEOiDtJMfsbTbAX7LQ+VYI/iv6QryTBXlUSVkhtesYSRx0QQuB+opxE3MI4hnBdL2XOi561bkf3XjI6l785I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gut0Ft8u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9647AC2BBFC;
	Tue,  4 Jun 2024 22:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717540338;
	bh=QHMdG4wTh/4cAxLzxOS5+p4F6ixCHuPUEV8qdu/4hJ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gut0Ft8ueLeR2XIJbV66BFcgFaOcIs3ZISZo3gfkRqqHjDfDLPwUcfNlUn7BxIwbN
	 SW5VkKgIW9wP8m0DWmIuQ4wlRHf1aLSh1LJ2BM54QMNi8xY2A39jhAOwM4rykGaWRb
	 0nPLtkbNdQU+EePtXvAB49zRFfkWzncye9vMaLzJO89qJ3KUGg7DqkxZUYkHd7MP0l
	 Fwl6DHqCYhCwI4Ul/CIhDkvLl4bJLnhPbVkvfynjuRiK6u6n6p1lvsuFIBwnHeMlEA
	 Ck6EIp39zbPSbwVUqxlpRv1tF8TE5li5OOloi03w5gmAJOKpajE+NSfr4uKihmgoP9
	 b2xbykeru/l0g==
Date: Tue, 4 Jun 2024 15:32:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, linux-doc@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, Andy Gospodarek <andrew.gospodarek@broadcom.com>, Aron
 Silverton <aron.silverton@oracle.com>, Dan Williams
 <dan.j.williams@intel.com>, Christoph Hellwig <hch@infradead.org>, Jiri
 Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, linux-cxl@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH 0/8] Introduce fwctl subystem
Message-ID: <20240604153216.1977bd90@kernel.org>
In-Reply-To: <Zl-G5SRFztx_77a2@x130>
References: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
	<20240603114250.5325279c@kernel.org>
	<214d7d82-0916-4c29-9012-04590e77df73@kernel.org>
	<20240604070451.79cfb280@kernel.org>
	<Zl-G5SRFztx_77a2@x130>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Jun 2024 14:28:05 -0700 Saeed Mahameed wrote:
> On 04 Jun 07:04, Jakub Kicinski wrote:
> >On Mon, 3 Jun 2024 21:01:58 -0600 David Ahern wrote:  
> >> Seriously, Jakub, how is that in any way related to this patch set?  
> >
> >Whether they admit it or not, DOCA is a major reason nVidia wants
> >this to be standalone rather than part of RDMA.
> 
> No, DOCA isn't on the agenda for this new interface. But what is the point
> in arguing?

I'm not arguing any point, we argued enough. But you failed to disclose
that DOCA is very likely user of this interface. So whoever you're
planning to submit it to should know.

DOCA was top of mind for me because I noticed it has PSP support, and
I wanted to take a look at the implementation.

> Apparently the vendor is not credible enough in your opinion.

You're creating an interface where you depend on a pinky promise from
a black box that the RPC is not a write. I trust you personally not to
write a patch which abuses this interface. But this cannot possibly
extend to all developers, most of who just want to ship features.

> Which is an absolute outrageous grounds for a NAK.
> 
> Anyway I don't see your point in bringing up DOCA here, but obviously once 
> this interface is accepted, all developers are welcome to use it,
> including DOCA developers of course..

Of course.

> That being said, the why we need this is crystal clear in the 
> cover-letter and previous submission discussions, bringing random SDKs
> into this discussion is not objective and counter productive to the
> technical discussion.
> 
> >> You are basically suggesting that if any vendor ever has an out of tree
> >> option for its hardware every patch it sends should be considered a ruse
> >> to enable or simplify proprietary options.
> 
> It's apparent that you're attributing sinister agendas to patchsets when
> you fail to offer valid technical opinions regarding the NAK nature. Let's
> address this outside of this patchset, as this isn't the first occurrence.
> Consistency in evaluating patches is crucial;

Exactly :| Netdev people, including multiple prominent developers from
Mellanox/nVidia have been nacking SDK interfaces in Linux networking
for 20 years. How are we going to look to all the companies which have
been doing IPUs for over a decade if we change the rules for nVidia?

> some, like the fbnic and idpf, seem to go unquestioned, while others
> face scrutiny.

fbnic got a nack for any core changes or uAPI not used by other drivers.
idpf got a nack for pretending to be a standard.

You keep saying that I'm nacking your interface because I have some
hatred and distrust for you or nVidia. I really, really don't.
Any vendor posting this would get exactly the same nack from me.

If by "let's address this outside of this patchset" you mean that we
should have a discussion about maintainer favoritism, and subsystem
capture by vendors - you have my full support!

