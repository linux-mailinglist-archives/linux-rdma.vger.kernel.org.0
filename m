Return-Path: <linux-rdma+bounces-7656-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8212A31132
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Feb 2025 17:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 751DE162749
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Feb 2025 16:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B5E253F01;
	Tue, 11 Feb 2025 16:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ji4LUHJm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C089426BDAB;
	Tue, 11 Feb 2025 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739291076; cv=none; b=hXkL/wq799/HoxCWGphRZa8b1Nzu6DZC+8egXK3exf8FHO1sWKLOaYas5s+M1R9o5Ia4pQFwS37q9C7QgfqPGE6hLHCc5OKefRP6pt36inoPCI8d+yFym7yaYpvEUOTxspMMdeitkzyVEJG5b/78lZaBmOU2nloybCCo++2T1hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739291076; c=relaxed/simple;
	bh=BQjEXfakfzkBt3JGMCIplB9e8ydjAEVl2TJ9i2VoFQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mwsuNz0OlyY28VXWYpls/7yW1LSy477ejhcasNcfR2QtjKi2W4iPYVs0sKpX0FxY5lyyeJjnNoaiixny5XthB4Km5BctytwU9F3VrrBdstqsSMQ71ZLwoH/jDcxnXW44eqtOnAMpKJYTRR/VlfwEYwdiwy20Fo44GjjYrtNVoOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ji4LUHJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC166C4CEDD;
	Tue, 11 Feb 2025 16:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739291076;
	bh=BQjEXfakfzkBt3JGMCIplB9e8ydjAEVl2TJ9i2VoFQw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ji4LUHJmv9s/lTAwPB6U/RNzBesSRnoPTcSoET/89m93TVf8ORyTboAVU7i1LcZ0q
	 hVQcsU/DivV4T9krdCluj+23Kp9jvLsmi8Zmn0MwuzEd5uMp9PMVf0dAETaPCxxjD5
	 xjEZiL1dnFsIh6psS/WIT6WxUXkO7/tYLkuZcGMklP/h1HNtKmMMso9Jt2A6rMbvwH
	 q5mTZpqM3187Gp+zU7inHdBib2qhH0Yak3c/CkLjPbDhSzUwGvYxG0BR1IcyVgMey7
	 d9YXBQ395GqO/EnjeS1EmgoPwaWSRRb8A+0ryXDU22ovowpTCpoD+kU27CEj5ImpiW
	 QojxoIawGSDaA==
Message-ID: <a74484b3-9f69-45ef-a040-a46fbc2607d6@kernel.org>
Date: Tue, 11 Feb 2025 09:24:35 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/10] bnxt: Create an auxiliary device for fwctl_bnxt
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Aron Silverton <aron.silverton@oracle.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>,
 Andy Gospodarek <gospo@broadcom.com>, Christoph Hellwig <hch@infradead.org>,
 Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Leonid Bloch <lbloch@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, "Nelson, Shannon" <shannon.nelson@amd.com>,
 Michael Chan <michael.chan@broadcom.com>
References: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
 <10-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
 <20250206164449.52b2dfef@kernel.org>
 <CACDg6nU_Dkte_GASNRpkvSSCihpg52FBqNr0KR3ud1YRvrRs3w@mail.gmail.com>
 <20250207073648.1f0bad47@kernel.org> <Z6ZsOMLq7tt3ijX_@x130>
 <20250207135111.6e4e10b9@kernel.org> <20250208011647.GH3660748@nvidia.com>
 <20250210170423.62a2f746@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250210170423.62a2f746@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/10/25 6:04 PM, Jakub Kicinski wrote:
> Yes, when RDMA driver is not loaded there should be no access to fwctl.
> When RDMA is disabled on the device via devlink there should be no
> fwctl access.
> 
> To disincentivize "creative workarounds" we have to also agree and
> document that fwctl must not be used to configure TCP/IP functions
> of the device, or host queues used by the netdev stack.

Your request is not about "RDMA only" since there are non-RDMA use cases
at play (e.g., CXL). It seems like what you are really asking for is a
hard exception for "netdev" use cases, right? So a summary along the
lines of:

"Any resources in use by the netdev stack can only be created and
modified by established netdev tools."

