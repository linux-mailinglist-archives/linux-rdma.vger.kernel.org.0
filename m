Return-Path: <linux-rdma+bounces-6007-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C049CF99C
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Nov 2024 23:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CE1C28CDA6
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Nov 2024 22:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E391E22FE;
	Fri, 15 Nov 2024 22:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OH7gF5sh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B81218BC19;
	Fri, 15 Nov 2024 22:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731708544; cv=none; b=Oxbjv2mAO8fMB3KgtTAIscdx5b2/ul/+evDAf9LIAswvv2XlIQav0YI6vwzlI2PppTxUB38t0ruvGteuNDboe6SRQqFPk6oKv+wAvX8OixrX/RJRmOZDdTZj5yQudP5sonjjCkSm/azSNdtK2d0cN6LH34zluXmTa5OrKb8m8Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731708544; c=relaxed/simple;
	bh=LfuEs2j4cRLeHtcUWhflQ2j9TZG5C5ehF9wT5yLf+2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZN/KQqfOtHkkHipir8xx7VR/2xtjVX+ZV4zM7EFQQ8wUj5PqvgfLHPzCLRJyoUWWqMzFR59VN3t2yCJNMUohoJbxaf2nzMWNiyhOkQifnLTcNrOwlX+qgwAzVI0LOXA94BP/m3Q6eGsZakqlooitc2DpdBJR/GjZybnhWDfYtsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OH7gF5sh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC82C4CECF;
	Fri, 15 Nov 2024 22:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731708544;
	bh=LfuEs2j4cRLeHtcUWhflQ2j9TZG5C5ehF9wT5yLf+2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OH7gF5shXm5ejLYHt5H307o6L/qshcEgJSTVU7htv5L7d//FWZ3fBiDoVPRJiToMC
	 gwnzbv8vKKRtoL9n5r1nIEXYHnsVyf1XIbI+tZFo/ACsUOn8OMCr/Go/dcI5gHyA2G
	 ClcA58BI1oDnLeLnqk5/cjB6M/3nFO0X4jdq45W6sRW4gKEUsHcgSf8Umxnhaia0i0
	 oJ/V5HYKSdQ1EIdMi4C+z4Z3rrp3HdGoF1Bez6Vj1HUysoLFsneHtC952WydsoHCAy
	 h95dxVnoOIpa8G4paRHw4MrpSdF7jM/G4JhDQj90+XrZyoDaaNSFcWNuvV55Juody8
	 rMB4JZLvzXZPQ==
Date: Fri, 15 Nov 2024 14:09:02 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Yafang Shao <laoar.shao@gmail.com>,
	ttoukan.linux@gmail.com, gal@nvidia.com, tariqt@nvidia.com,
	leon@kernel.org, netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 net-next] net/mlx5e: Report rx_discards_phy via
 rx_fifo_errors
Message-ID: <ZzfGfji0V2Xy4LAQ@x130>
References: <20241114021711.5691-1-laoar.shao@gmail.com>
 <20241114182750.0678f9ed@kernel.org>
 <CALOAHbCQeoPfQnXK-Zt6+Fc-UuNAn12UwgT_y11gzrmtnWWpUQ@mail.gmail.com>
 <20241114203256.3f0f2de2@kernel.org>
 <CALOAHbBJ2xWKZ5frzR5wKq1D7-mzS62QkWpxB5Q-A7dR-Djhnw@mail.gmail.com>
 <Zzb_7hXRPgYMACb9@x130>
 <20241115112443.197c6c4e@kernel.org>
 <Zzem_raXbyAuSyZO@x130>
 <20241115132519.03f7396c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241115132519.03f7396c@kernel.org>

On 15 Nov 13:25, Jakub Kicinski wrote:
>On Fri, 15 Nov 2024 11:54:38 -0800 Saeed Mahameed wrote:
>> >We can, but honestly I'd just make sure they are counted in rx_dropped
>>
>> rx_dropped: Number of packets received but not processed,
>>   *   e.g. due to lack of resources or unsupported protocol.
>>   *   For hardware interfaces this counter may include packets discarded
>>   *   due to L2 address filtering but should not include packets dropped
>>                                   ^^^^^^^^^^^^^^
>>   *   by the device due to buffer exhaustion which are counted separately in
>>                            ^^^^^^^^^^^^^^^^^
>>   *   @rx_missed_errors (since procfs folds those two counters together).
>>       ^^^^^^^^^^^^^^^^^
>
>I presume you quote this comment to indicate the rx_dropped should
>count packets dropped due to buffer exhaustion? If yes then you don't
>understand the comment. If no then I don't understand why you're
>quoting it.
>

I quoted this because you suggested to use rx_dropped. It's not a good fit.
In your previous reply you said: 
"but honestly I'd just make sure they are counted in rx_dropped"

>> I think we should use rx_fifo_errors for this and update documentation:
>>
>> rx_missed_errors --> host buffers
>> rx_fifo_errors   --> device buffers
>
>In theory I'd love to use fifo errors to mean device buffer drops.
>In practice devices can backpressure due to host slowness, so the

So what? host slowness will always be counted in rx_missed_errors.
if you see both rx_missed_erros and fifo_errors progressing, you can make
the connection.. With CX devices out_of_buffer "missed_errors" can never cause
fifo drops "fifo_errors".

>device drops are hard to categorize. The vendors themselves have
>limited understanding of how their devices will behave under real
>workloads. And once devices are deployed it may be too late to change
>definitions.
>

Forget about vendors, here is my simplified categorization that we could
align with easily among all vendors and users

// delivered to SW but dropped in SW
1) seen by sw dropped by sw. (rx_dropped?)

// couldn't deliver to SW (back-pressure)
2) slow SW: passed pipeline/fifo: but SW lack of descriptors (rx_missed_errors)
3) overflow: pipeline/fifo overflow at any point before SW queue (rx_fifo_errors)
4) expected drops: steering/flow filters, configuration, carrier
    down, etc ).. no counter in rtnl_stats exists for this
  
// couldn't deliver to SW, errors
5) errors, dropped due to packet related errors or HW errors

If all vendors agree, with some repurposing and renaming of the counters
maybe we can achieve the above with minimal backward compatibility breakage.
To solve this once and for all, we need the documentation to reflect strong
and clear definitions even if it renders existing implementation/interpretation 
to be wrong. Otherwise this will never be solved.

>> rx_dropped       --> unsupported portocols, filter drops, link down, etc..

