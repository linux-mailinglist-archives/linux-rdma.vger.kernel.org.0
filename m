Return-Path: <linux-rdma+bounces-15547-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37141D1D48E
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 09:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AD4173017C61
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 08:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF96638737F;
	Wed, 14 Jan 2026 08:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B8V4WgH5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1B73803E9
	for <linux-rdma@vger.kernel.org>; Wed, 14 Jan 2026 08:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768380817; cv=none; b=Tuo9croOdCHxhwE5XzjetC9YpCKXFu7Cwiwu41RZor3vSQW0frDNZJZcQw4Bn0duRPbNXB6cNGu097Zv/DlDC7SgoeNJNTY1lP9uKW/sVFAHalANV0r5cxt0Edp+jH85YPt+LZXpvtGY5p8ZU1iTuFvvw9mbPJpM8Grnhn8Oc/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768380817; c=relaxed/simple;
	bh=9ZxldlX5+QwAZglx8tOjhQAHuhmXu8tht81WJZBgDDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W31Pb9EoH72qut/KR7xOwh7tjsGN2pmuW/b+1nzx42gLgZPbROxGHCuO9V/xA9usMzqzwkBdDAqxGKf9MgMui8P+1M9SrKasgI+3FitigYdzmYWJhQ2BFh9XHKeZG8rtESi0dDFKFh6lhVrc/RIqQk++PF+9GwVn5IhafmOjSQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B8V4WgH5; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1dc533ea-25ad-4c41-a7ff-14dfcfd3a261@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768380809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xxIuouJO3MIKgvuqSxN9caUBLjtpXBt94bD24L3zHFA=;
	b=B8V4WgH5FMdeTFkhmyhej7cJLPT2N7WrmM4Y39ZqQtrM/NuPVQq1E7J4CE0oxMNTGEdu/K
	9eClwT/leLZZco2JlMpbG/sAZ9glsp/dZ6XNPhd503d3BarxMDXsQSNufv4Ivw03kZUUxb
	rxMMtyNaJ83D/hLJLIbCjFIBRnuD7Lw=
Date: Wed, 14 Jan 2026 16:53:20 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net/mlx5e: Mask wqe_id when handling rx cqe
Content-Language: en-US
To: Tariq Toukan <ttoukan.linux@gmail.com>, netdev@vger.kernel.org
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Oz Shlomo <ozsh@mellanox.com>, Paul Blakey <paulb@mellanox.com>,
 Khalid Manaa <khalidm@nvidia.com>, Achiad Shochat <achiad@mellanox.com>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Leon Huang Fu <leon.huangfu@shopee.com>
References: <20260112080323.65456-1-leon.hwang@linux.dev>
 <cfa6e78d-82ca-43d2-a8df-48fcb7d6301e@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <cfa6e78d-82ca-43d2-a8df-48fcb7d6301e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 14/1/26 16:23, Tariq Toukan wrote:
> 
> 
> On 12/01/2026 10:03, Leon Hwang wrote:
>> The wqe_id from CQE contains wrap counter bits in addition to the WQE
>> index. Mask it with sz_m1 to prevent out-of-bounds access to the
>> rq->mpwqe.info[] array when wrap counter causes wqe_id to exceed RQ size.
>>
>> Without this fix, the driver crashes with NULL pointer dereference:
>>
>>    BUG: kernel NULL pointer dereference, address: 0000000000000020
>>    RIP: 0010:mlx5e_skb_from_cqe_mpwrq_linear+0xb3/0x280 [mlx5_core]
>>    Call Trace:
>>     <IRQ>
>>     mlx5e_handle_rx_cqe_mpwrq+0xe3/0x290 [mlx5_core]
>>     mlx5e_poll_rx_cq+0x97/0x820 [mlx5_core]
>>     mlx5e_napi_poll+0x110/0x820 [mlx5_core]
>>
> 
> Hi,
> 
> We do not expect out-of-bounds index, fixing it this way is not
> necessarily correct.
> 
> Can you please elaborate on your test case, setup, and how to repro?

Hi,

Thanks for the feedback.

Unfortunately, we cannot reliably reproduce this issue on demand, as it
was triggered on a production server. However, we preserved both the
dmesg output and the coredump.

From analysis of the coredump, the wqe_id value was *4167*, which is
unexpectedly out of bounds for the RQ size and led to the NULL pointer
dereference shown above.

For reference, here is the environment where the issue was observed:

NIC:      Mellanox Technologies MT2892 Family [ConnectX-6 Dx]
Firmware: 22.43.2566 (MT_0000000359)
OFED:     MLNX_OFED 24.10-2.1.8
Kernel:   5.15.0-189.012-shopee (Ubuntu 24.04 based)

Queue configuration:
# ethtool -g enp23s0f0np0
RX: 4096
TX: 4096
# ethtool -l enp23s0f0np0
Combined: 20

Please let me know if additional details would be helpful.

Thanks,
Leon

[...]


