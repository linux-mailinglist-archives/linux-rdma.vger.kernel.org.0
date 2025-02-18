Return-Path: <linux-rdma+bounces-7816-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BACD6A3AB41
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2025 22:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F20C53A1E82
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2025 21:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151D21CDA0B;
	Tue, 18 Feb 2025 21:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogStWo+H"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D4A1C5F3A;
	Tue, 18 Feb 2025 21:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739914970; cv=none; b=BdTlq+DcrsBFWnCk+mZVGZsxkQkPRo1QZ8vp8nnjDT5RFeaU0z7N6UCtseEU7SSijlMXp1B8aVRPzUZW9mPTJqsM46g+ziNXHLvhTz177P8R2fuMcxFrebKbUYdO8PdVswuJ1J2qTr/CfONHvdI6hbqoFwdrKNlMJBKMkJ8yxZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739914970; c=relaxed/simple;
	bh=qBjhdnTkIhhI7rk/cLE2sEMgtQFCh50rax0V+Mx64sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f0ui0dxYJhKIE9Fe1REfXXKoDfiibhvN/+9FcU90OlV5Mdto5mIYl9GwXm08wBOAZdQoIw5zqc8SD+nuGO6BHV/Nbg6Z4Sr3u7LONPUGCIL1nyKRwObfuFIYyQfAR2HHNHib9eUZkf9dGkAoiloFhymn53YwOJowwRpwoQA/b4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogStWo+H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71619C4CEE2;
	Tue, 18 Feb 2025 21:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739914970;
	bh=qBjhdnTkIhhI7rk/cLE2sEMgtQFCh50rax0V+Mx64sk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ogStWo+H3phmRPB1+2kHPF8SUygxa8cGgXthhVUpYQ9uucp1DS2DBFUTZQcNzFXwC
	 sPA+fvHZjyWnh3GIwqdl6iaqmVB+MWskzlZ5xWpCYULnhHxob+G9lsQ/Ika+CadTGz
	 zcq/h9pTNmS3fW7Bm7HhxZzsvslMWX1HN5Sc5sTnwRw53rCrlSsm+P5zIVD1gPLK/d
	 FJlOw+QH16l1JpQdfTAfl878V8VxA6s9cHkbm7zQ81vqRYxRyligWL9pDN+/I1fGQz
	 gtRtwpjLHPE7N0n0Q1dQs0iTw7PSvVBQAzn4w+rkJ62zNeW7SUmKfxdw0w85Rh0Gx3
	 KSxeTNdv7lGHw==
Message-ID: <532d2530-5c12-43b7-973f-ce43dbc36e67@kernel.org>
Date: Tue, 18 Feb 2025 14:42:48 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/10] bnxt: Create an auxiliary device for fwctl_bnxt
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
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
 <a74484b3-9f69-45ef-a040-a46fbc2607d6@kernel.org>
 <20250218200520.GI4183890@nvidia.com>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250218200520.GI4183890@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/18/25 1:05 PM, Jason Gunthorpe wrote:
> On Tue, Feb 11, 2025 at 09:24:35AM -0700, David Ahern wrote:
> 
>> "Any resources in use by the netdev stack can only be created and
>> modified by established netdev tools."
> 
> That is already a restriction described in the doc, not just netdev,
> but any kernel driver running with any kernel owned resource. You
> can't reach in and change kernel owned objects.
> 

ok, then Jakub's concerns should be met.


