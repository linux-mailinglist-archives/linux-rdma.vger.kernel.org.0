Return-Path: <linux-rdma+bounces-2955-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA58F8FF409
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 19:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3F131C26DBC
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 17:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2D8199231;
	Thu,  6 Jun 2024 17:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5LQ5cX0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CB1198E90;
	Thu,  6 Jun 2024 17:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717696042; cv=none; b=KrnCktDFa7dJOFQ5UB22IU7JsD1K7NCnZex6M83CZFsx264vkiM3lpF55OuJcMLTanEJaRocUPa2dTw74uqmDsTuOsZMQgLB9f6SfDW8SIf7FC+psp3cqccltIkRlFMGuoH3ZMASN1bVt3gskvDTnCV6PP9U1E3iONpU/WhqcB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717696042; c=relaxed/simple;
	bh=hfRZV1GKUUFYuwYuST74M+6PHE6LaJ1YGYc1o0TEW2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jGKpgcNU+YoVHNU0CAZJUHTfDenPD5Y33EOFV7irE1c2u/Nq88HWb9Dh1zyaLX0gh40vP9Vm4RrVawstARUs2VbxI96sMv7fBDwkQJ4VXEfMna8DNCLZBzKXz2xGpWnQeqTeJsOdZsuC5ibian1W42gmKv1ZA/1O9PUdR6V4pm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5LQ5cX0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555D9C32782;
	Thu,  6 Jun 2024 17:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717696042;
	bh=hfRZV1GKUUFYuwYuST74M+6PHE6LaJ1YGYc1o0TEW2E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H5LQ5cX0c64o31YkJ2tv9Dul2Yas8mv36ohOJOtlST1cjpDHmRlSpy1ws53TZ4M9p
	 MnBwq2XIItr/IyVskD3g1zxhWPcgayepAAzicBBunKon/urIU586WlqSahOAOLjauQ
	 gamzxRWUhLpWF4pjLc9E56azauVoSG82DAV+BPqOf5ag29srAastGf4+5Z0NcnNCYC
	 dU7oIZkGqfLFlTzlxHm9UyZ6BCkuVl4q+oEKfvE4kWHuRGM0cazUClzSK76GO17+Xa
	 +XcMmrCMPrx4wG0v/iVtD2YFTqqAIzXKEv75MNnmc2QG9+ynCUng/D/H3j/1iuW4yM
	 vaUZLrMqNmHGg==
Message-ID: <4724e6a1-2da1-4275-8807-b7fe6cd9b6c1@kernel.org>
Date: Thu, 6 Jun 2024 11:47:20 -0600
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Introduce fwctl subystem
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Jonathan Corbet
 <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, linux-doc@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Aron Silverton <aron.silverton@oracle.com>,
 Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
 Leonid Bloch <lbloch@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 linux-cxl@vger.kernel.org, patches@lists.linux.dev
References: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
 <20240603114250.5325279c@kernel.org>
 <214d7d82-0916-4c29-9012-04590e77df73@kernel.org>
 <20240604070451.79cfb280@kernel.org>
 <665fa9c9e69de_4a4e62941e@dwillia2-xfh.jf.intel.com.notmuch>
 <20240605135911.GT19897@nvidia.com>
 <d97144db-424f-4efd-bf10-513a0b895eca@kernel.org>
 <20240606071811.34767cce@kernel.org> <20240606144818.GC19897@nvidia.com>
 <20240606080557.00f3163e@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240606080557.00f3163e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/6/24 9:05 AM, Jakub Kicinski wrote:
> On Thu, 6 Jun 2024 11:48:18 -0300 Jason Gunthorpe wrote:
>>> An argument can be made that given somewhat mixed switchdev experience
>>> we should just stay out of the way and let that happen. But just make
>>> that argument then, instead of pretending the use of this API will be
>>> limited to custom very vendor specific things.  
>>
>> Huh?
> 
> I'm sorry, David as been working in netdev for a long time.

And I will continue working on Linux networking stack (netdev) while I
also work with the IB S/W stack, fwctl, and any other part of Linux
relevant to my job. I am not going to pick a silo (and should not be
required to).

> I have a tendency to address the person I'm replying to,
> assuming their level of understanding of the problem space.
> Which makes it harder to understand for bystanders.
> 
>> At least mlx5 already has a very robust userspace competition to
>> switchdev using RDMA APIs, available in DPDK. This is long since been
>> done and is widely deployed.
> 
> Yeah, we had this discussion multiple times

The switchdev / sonic comparison came to mind as well during this
thread. The existence of a kernel way (switchdev) has not stopped sonic
(userspace SDK) from gaining traction. In some cases the SDK is required
for device features that do not have a kernel uapi or vendors refuse to
offer a kernel way, so it is the only option.

The bottom line to me is that these hardline, dogmatic approaches -
resisting the recognition of reality - is only harming users. There is a
middle ground, open source drivers and tools that offer more flexibility.

