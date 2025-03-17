Return-Path: <linux-rdma+bounces-8756-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD99A65D7D
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 20:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 256347AFC04
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 18:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A0718C337;
	Mon, 17 Mar 2025 19:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeQzc7BL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261144A06;
	Mon, 17 Mar 2025 19:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742238045; cv=none; b=SAD5kw4qFNg3wpemlB7rk6TuR4pQHqMnrHXkFJS1KSgzVagguLR6cgKH3aZnt+coV/vteTxU9hxsuERt8wBRsG74dIU0BbiRgBmuajyYCPQSWbpcX9PkjamnwaBl1KZAXwW+jhdoTMODH5VaUUSO081yGS9qWqNR92OP3PdfzXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742238045; c=relaxed/simple;
	bh=Wo2wfzfhNxnL2ZL+LVpIzigSCTl/akQguM98mUvOi+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XETxLc3b+Kn6AoeA4/toqH4x1hIf/yHNti7CbepAK/QI6sMnSv07pzGBBaJw9Ie+DJnQksNXEJNlOQZ4OIf5t3xD6ViSWUe8Hgkv3hHvdiiSiLad5vpsCXnTnQdgwCTmaAxd6IOCfblViVd2d+u/UOxyjiry0817hRI8UYTQa0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeQzc7BL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DEB7C4CEE3;
	Mon, 17 Mar 2025 19:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742238045;
	bh=Wo2wfzfhNxnL2ZL+LVpIzigSCTl/akQguM98mUvOi+w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JeQzc7BLWlfhPaSn+zaHHp4mLtyYzC9KuIFsri9MX1nfgbXdPM3nSzXRttXIA8032
	 sCK6mCC9ByNS1KiQ/wKMc7quXIdPZEYCM6FBTvy9uAsnCTlhSzjHJvL7yHie8JVK/0
	 rdKpesJMYs5F1rT7Y+Mu2sMrSQUaUPe7pRuewODruuLLAIUV37CCMp8TknbB2WGfA8
	 87IlqnO4OeULooRQa5tYXp/TTJ5zrsi9NPs6qgyDMHA+tSqGUT/K1R4jjOWanPZfxq
	 o9YwEtVrmJLtGhaFN6M/iALR++tYhEWfAR8hvbH9fBIrSqvgBVsxRjj6/oCrFrGI8e
	 QSvP3OzliqCXg==
Message-ID: <1eae139c-f678-4b28-a466-5c47967b5d13@kernel.org>
Date: Mon, 17 Mar 2025 13:00:43 -0600
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] Introduce fwctl subystem
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>
Cc: "Nelson, Shannon" <shannon.nelson@amd.com>,
 Leon Romanovsky <leon@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Jakub Kicinski <kuba@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Aron Silverton <aron.silverton@oracle.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>,
 Christoph Hellwig <hch@infradead.org>, Itay Avraham <itayavr@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Leonid Bloch <lbloch@nvidia.com>,
 linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
 "Sinyuk, Konstantin" <konstantin.sinyuk@intel.com>
References: <20250304140036.GK133783@nvidia.com>
 <20250304164203.38418211@kernel.org> <20250305133254.GV133783@nvidia.com>
 <mxw4ngjokr3vumdy5fp2wzxpocjkitputelmpaqo7ungxnhnxp@j4yn5tdz3ief>
 <bcafcf60-47a8-4faf-bea3-19cf0cbc4e08@kernel.org>
 <20250305182853.GO1955273@unreal>
 <dc72c6fe-4998-4dba-9442-73ded86470f5@kernel.org>
 <20250313124847.GM1322339@unreal>
 <54781c0c-a1e7-4e97-acf1-1fc5a2ee548c@amd.com>
 <d0e95c47-c812-4aa8-812f-f5d7f6abbbb1@intel.com>
 <20250317123333.GB9311@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250317123333.GB9311@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/25 1:33 PM, Jason Gunthorpe wrote:
> On Fri, Mar 14, 2025 at 11:09:47AM -0700, Jacob Keller wrote:
> 
>> I'd throw my hat in for drivers/core as well, I think it makes the most
>> sense and is the most subsystem neutral name. Hopefully any issue with
>> tooling can be solved relatively easily.
> 
> Given Greg's point about core dump files sometimes being in .gitignore
> maybe "shared_core", or something along that path is a better name?
> 

Not seeing the conflict on drivers/core:

$ find . -name .gitignore | xargs grep core
./tools/testing/selftests/powerpc/ptrace/.gitignore:core-pkey
./tools/testing/selftests/cgroup/.gitignore:test_core
./tools/testing/selftests/mincore/.gitignore:mincore_selftest
./arch/mips/crypto/.gitignore:poly1305-core.S
./arch/arm/crypto/.gitignore:aesbs-core.S
./arch/arm/crypto/.gitignore:sha256-core.S
./arch/arm/crypto/.gitignore:sha512-core.S
./arch/arm/crypto/.gitignore:poly1305-core.S
./arch/arm64/crypto/.gitignore:sha256-core.S
./arch/arm64/crypto/.gitignore:sha512-core.S
./arch/arm64/crypto/.gitignore:poly1305-core.S


