Return-Path: <linux-rdma+bounces-2925-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B30AB8FDCD5
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 04:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B83121F24FBF
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 02:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84D01BC20;
	Thu,  6 Jun 2024 02:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2TYev22"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAC918EA2;
	Thu,  6 Jun 2024 02:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717641351; cv=none; b=Y9T12Bye5wWiCSk0j2GJq/0/hoOOta4Jl+RmrQGKa1MJN2qhNwNjMeThcCOnRhDHgbvgy3TVmZBdUy0L7MDKhHwSIECZOLU780wrDXB2irNLIzJ3SkU3gitADfwXeYMk5oYnCQtSlhg+7aRB2aD4NUX7ZWBlW31OBjzFHpgQcH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717641351; c=relaxed/simple;
	bh=TLhBje2geqY1Z9OLXqxjQbB79fh8qlWI440npB953Qk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KnsdKXaDVFbtcrfzWfT2LlFKVnrn+C8UDNo1mzKt7ftY0ZeeyRCq79wBn0faSHCtqmSahdSPja95floATb/TrETAe9Rcqb10oP7T490IjdNIpaCWUff1d70DET7xu2hKe0nBpibOnd1aZ+RhTNaEPK9oMby/2CV4hYteO61ueCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2TYev22; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F4FC2BD11;
	Thu,  6 Jun 2024 02:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717641351;
	bh=TLhBje2geqY1Z9OLXqxjQbB79fh8qlWI440npB953Qk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O2TYev22UFFhALNZ/yVBS5fy59sjZuUeyqcICF0PQY50U5K42Gu0ckJRCMxpRuhy5
	 YQizc/YjiyJ/8DkUlhuvoXmrCHy9eeq4kzl9kbvlU6ZG9MgDfLKc+TN+wtkd9IcbVW
	 Vg//DDbpBbg2LnMOU+ABYes+5R6S/PDyevKH0KSC/ScfRBYZLJ9FiEsOxS4QYoaAmP
	 wDwW4fMnus4TW4hA8I8AT8LwOGZWytuA2NnILi15RRKL8Icb2sdcQXvD7fh1VceoBv
	 X9XZhvm8FC9Anu9iTuGlPjR/fX3Nu/Aba8uFu4z0BWDl90k0ABnQZKeu11BmGXrYrC
	 vdyZizUtVKsoA==
Message-ID: <d97144db-424f-4efd-bf10-513a0b895eca@kernel.org>
Date: Wed, 5 Jun 2024 20:35:49 -0600
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Introduce fwctl subystem
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Dan Williams <dan.j.williams@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Itay Avraham <itayavr@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
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
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240605135911.GT19897@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/5/24 7:59 AM, Jason Gunthorpe wrote:
> On Tue, Jun 04, 2024 at 04:56:57PM -0700, Dan Williams wrote:
>> Jakub Kicinski wrote:
>> [..]
>>> I don't begrudge anyone building proprietary options, but leave
>>> upstream out of it.
>>
>> So I am of 2 minds here. In general, how is upstream benefited by
>> requiring every vendor command to be wrapped by a Linux command?
> 
> People actually can use upstream :)
> 
> Amazingly there is inherit benefit to people being able to use the
> software we produce.

There is. There is a clear preference for open source kernels and drivers.

Until a feature is standardized and/or commoditized, it does not make
sense to create a uapi for every H/W vendor whim. All of them are
attempting to solve real problems; some of them will stick. We know
which features are valuable when customers use them, ask for them and
other vendors copy them. Until then it is a 1-off by a vendor basically
proposing a solution. Not all ideas are good ideas, and we do not need
the burden of a uapi or the burden of out of tree drivers.

> 
>> 3 years on from that recommendation it seems no vendor has even needed
>> that level of distribution help. I.e. checking a few distro kernels
>> (Fedora, openSUSE) shows no uptake for CONFIG_CXL_MEM_RAW_COMMANDS=y in
>> their debug builds. I can only assume that locally compiled custom
>> kernel binaries are filling the need.
> 
> My strong advice would be to be careful about this. Android-ism where
> nobody runs the upstream kernel is a real thing. For something
> emerging like CXL there is a real risk that the hyperscale folks will
> go off and do their own OOT stuff and in-tree CXL will be something
> usuable but inferior. I've seen this happen enough times..
> 
> If people come and say we need X and the maintainer says no, they
> don't just give up and stop doing X, the go and do X anyhow out of
> tree. This has become especially true now that the center of business
> activity in server-Linux is driven by the hyperscale crowd that don't
> care much about upstream. Linux maintainer's don't actually have the
> power to force the industry to do things, though people do keep
> trying.. Maintainers can only lead, and productive leading is not done
> with a NO.

+1


