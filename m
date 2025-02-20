Return-Path: <linux-rdma+bounces-7924-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2855AA3E70D
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 22:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F30ED42168B
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 21:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF682139D4;
	Thu, 20 Feb 2025 21:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmfn4CVj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EA51EA7ED;
	Thu, 20 Feb 2025 21:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740088571; cv=none; b=n60VWWHpJ0GygNUjCsmeLBVxQA/qOVX14kbytgV2azz6w3rWVSOPStVSIKrci537KRB9/SzrvMTEPA4C+2NB0UuJ0w0D/j6Qlw2qL/08nAmm68vwGTX7M4R21qRzo9TA/cZEheu7pTs0aWvIWx7516ZzFiGAGVDohRUuXSRfxfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740088571; c=relaxed/simple;
	bh=J6I5r0STduBfU8F1WmLQkOLLHdgnErWb1KwbT9Um+Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5HOVwRaiG2lc8Wq+8DeXzB5BrfWSijehuUyyrXL8e7jq5WqYPoZpm/JJjFohhX0g4ZEnlJOaBJi3gtGUbdzqPiNAOIv3NuKdDgAWCwy4U0kMl0wUpvyso2Qr2Gv1w2dt3/bXpgnYnwXY83nYYeW2aamMuDZ+gGrkDdgDP7TKto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmfn4CVj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AEE0C4CED1;
	Thu, 20 Feb 2025 21:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740088571;
	bh=J6I5r0STduBfU8F1WmLQkOLLHdgnErWb1KwbT9Um+Pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bmfn4CVjOM+RmRUVKT6DCtIV6SVE+1YONeWWcilHDLvN5NvLoGsE4zQ1Q8j6h1lvs
	 RHrLsO1cOrBUq0c3nbgp0CFvk5ZqZCw+YMVsUpZtTkNHLpV2SoYgB8E6BqfoSBA2ge
	 wcsB5ftevcvydQBrSuP0B2OP04VHXiEjMXIRjXMqjaklCqmvnAVpoaRBZ9Sx4Gk4LK
	 K5bWzHtVN2MycvhYPcN/5aNQ4n9hKL4qEUMgCECkGlhA6n2oiGzGvTua099kTtq0IR
	 F4o9mZ/8ARjQ1gez2F/imjnTDYzOgzN/E+5exzkFslwY8ygoZsnbE6GSuolavmlqkV
	 vFco0mDMBawAQ==
Date: Thu, 20 Feb 2025 13:56:10 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, Itamar Gozlan <igozlan@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/mlx5: Use secs_to_jiffies() instead of
 msecs_to_jiffies()
Message-ID: <Z7ek-uGw3IXH7bRM@x130>
References: <20250219205012.28249-2-thorsten.blum@linux.dev>
 <48456fc0-7832-4df1-8177-4346f74d3ccc@intel.com>
 <20250220071327.GL53094@unreal>
 <9694B455-87B0-4A70-93C0-93FE77E3CD17@linux.dev>
 <20250220120754.GQ53094@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250220120754.GQ53094@unreal>

On 20 Feb 14:07, Leon Romanovsky wrote:
>On Thu, Feb 20, 2025 at 12:08:07PM +0100, Thorsten Blum wrote:
>> On 20. Feb 2025, at 08:13, Leon Romanovsky wrote:
>> > On Wed, Feb 19, 2025 at 03:45:02PM -0800, Jacob Keller wrote:
>> >> On 2/19/2025 12:49 PM, Thorsten Blum wrote:
>> >>> Use secs_to_jiffies() and simplify the code.
>> >>>
>> >>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> >>
>> >> nit: this is a cleanup which should have the net-next prefix applied,
>> >> since this doesn't fix any user visible behavior.
>> >>
>> >> Otherwise, seems like an ok change.
>> >
>> > IMHO, completely useless change for old code. I can see a value in new
>> > secs_to_jiffies() function for new code, but not for old code. I want
>> > to believe that people who write kernel patches aware that 1000 msec
>> > equal to 1 sec.
>>
>> Using secs_to_jiffies() is shorter and requires less cognitive load to
>> read imo. Plus, it now fits within the preferred 80 columns limit.

>Unfortunately, I see this change as a churn and not an improvement.

All patches with any justified improvement are welcome, as long as they are
not automated or bot generated spam.

This patch is reasonable, you need to add [PATCH net-next] prefix in
the title for this patch to get into the pipeline.

Feel free to add:
Reviewed-by: <saeed@kernel.org>

>
>>
>> This "old code" was added in d74ee6e197a2c ("net/mlx5: HWS, set timeout
>> on polling for completion") in January 2025.
>
>I got same conversion patches for RDMA.
>https://lore.kernel.org/all/20250219-rdma-secs-to-jiffies-v1-0-b506746561a9@linux.microsoft.com
>
>Thanks
>
>>
>> Thanks,
>> Thorsten
>>
>

