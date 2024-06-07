Return-Path: <linux-rdma+bounces-2996-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE189007AD
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 16:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8DA71C2087E
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 14:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210BC19DF51;
	Fri,  7 Jun 2024 14:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrExoQ6b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6316199E89;
	Fri,  7 Jun 2024 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717771819; cv=none; b=Bf6s0jNcA66YO9LqhkAwRjSNfHdG1j8+wS9v7VOW+8ebHVJfue8bDj9oPUYj6PDYNEc2LUyShEz8GoXHR8NLFnARQYmYFKU5l42R0KJOcHnDE5cksbPoXEq2pcxif/9Cn5Jh2tVCAG5s6PkKCmYz2/7QtP35Ke+MlHztTYQif+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717771819; c=relaxed/simple;
	bh=4/ubmwuYyQOolVzF2x9lQP58QrY0ho1bemzDRvePUdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ur29Ihy1OCLf3k92NmYMh82CKVJ+HXsRINV5XzdEnZ44Wgr4ncITkkzIEGghlDolmH5eQU1kset8/V7JG5GV7YGYFH55hSw/Oks0g/H/ZNWC4veUKpP5CU5D9XSubCZ2XQGy93V1zwl1ohNOyFD0GECT1u3SuQGbp93+alQeRg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrExoQ6b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72853C2BBFC;
	Fri,  7 Jun 2024 14:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717771819;
	bh=4/ubmwuYyQOolVzF2x9lQP58QrY0ho1bemzDRvePUdA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mrExoQ6bzrW6/fHCA5xUQn8HxQae7gqiUR2glC3uYsd4TWkp7JLlxMFOOl7woEWCu
	 pPygVKgTNl7duJ9xd5UbQUIFp2tIZBmy6zInusou3ik83FZrs75G6pujR5TJ029e7W
	 /d1NIWzrwIad6X2pm2CA0lbz9d0EDpW/zMGmLjjeXhPV9OVD7yToIcTKttNU/suUnL
	 8QWMK60xCDcsRKkgNahu+6B+AjsrNd5EPEzWOfziquVWK/2+0XfkCxs7i/IjXsqrtu
	 f+GvwGKIiwpUCMKqSktVPxbOIQdebTvqAyYRaKh/fZDaIpaPR7snCMFj67W88qdZHa
	 f3dzbH3Bl5siA==
Message-ID: <887d1cb7-e9e9-4b12-aebb-651addc6b01c@kernel.org>
Date: Fri, 7 Jun 2024 08:50:17 -0600
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Introduce fwctl subystem
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Dan Williams <dan.j.williams@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Itay Avraham <itayavr@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Aron Silverton <aron.silverton@oracle.com>,
 Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
 Leonid Bloch <lbloch@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 linux-cxl@vger.kernel.org, patches@lists.linux.dev
References: <20240603114250.5325279c@kernel.org>
 <214d7d82-0916-4c29-9012-04590e77df73@kernel.org>
 <20240604070451.79cfb280@kernel.org>
 <665fa9c9e69de_4a4e62941e@dwillia2-xfh.jf.intel.com.notmuch>
 <20240605135911.GT19897@nvidia.com>
 <d97144db-424f-4efd-bf10-513a0b895eca@kernel.org>
 <20240606071811.34767cce@kernel.org> <20240606144818.GC19897@nvidia.com>
 <20240606080557.00f3163e@kernel.org>
 <4724e6a1-2da1-4275-8807-b7fe6cd9b6c1@kernel.org>
 <ZmKtUkeKiQMUvWhi@nanopsycho.orion>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <ZmKtUkeKiQMUvWhi@nanopsycho.orion>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/7/24 12:48 AM, Jiri Pirko wrote:
>> The switchdev / sonic comparison came to mind as well during this
>> thread. The existence of a kernel way (switchdev) has not stopped sonic
>> (userspace SDK) from gaining traction. In some cases the SDK is required
> 
> Is this discussion technical or policital? I'm asking because it makes
> huge difference. There is no technical reason why sonic does not use
> proper in-kernel solution from what I see
> Yes, they chose technically the wrong way, a shortcut, requiring kernel
> bypass. Honestly for reasons that are beyond my understanding :/
> 
> 
>> for device features that do not have a kernel uapi or vendors refuse to
>> offer a kernel way, so it is the only option.
> 
> Policical reasons.
> 

You meant financial reasons, not political. The dominant player in
switches has zero interest in switchdev, zero interest in open sourcing
their SDK. Nothing has changed on that front in the 9 years of
switchdev's existence and no amount of 'NO' by maintainers is ever going
to pressure said vendor to do that.

Mellanox offers both with the Spectrum line and should have a pretty
good understanding of how many customers deploy with the SDK vs
switchdev. Why is that? There are those who think in logical, simple
designs (switchdev), and those who prefer complex, all userspace designs
with ping-ponging messages across processes (sonic). The latter uses all
kinds of what I call silly rationalizations from userspace allows more
flexibility, to dealing with the the kernel is too rigid, or getting
changes in is too hard, or my favorite - Linux does not scale.

The bottom line is that the SDK model is not going away. Period.

The networking stack has accepted kernel bypass compromises (xdp, xdp
sockets, OVS, a lot of the ebpf hooks, ... just examples) with the
rationale that more is brought into the Linux way. fwctl is a similar
effort - an attempt at bringing more into an open source driver and tooling.


