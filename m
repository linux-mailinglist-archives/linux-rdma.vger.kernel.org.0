Return-Path: <linux-rdma+bounces-3873-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B339319DF
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jul 2024 19:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C8C6282C31
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jul 2024 17:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1396F55888;
	Mon, 15 Jul 2024 17:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhTb/bw3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC60950284;
	Mon, 15 Jul 2024 17:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721066175; cv=none; b=DgxxWw3Id/mS0OgFIOL+iERGVutJfyNTLwX8cLsRTrGeGRWCfa30iVvhGosjQcs0AyAyfejbKNeMGfi1zw2I88cxAN47iHLV7shPP1uXwCo4d5Bm0Kf5O3U4rPNLYvJHLN17gSAaXBSPgiOZtyCy7kizSJA5ePk0sU5EeFt0DQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721066175; c=relaxed/simple;
	bh=m5Qjim97u7Dn1CPZPoGktU573XyhUeUEwVBsOqclmLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vz/sW3xJzCnfJkE5bSI09ov66FP8HQWvkgl9w+6T2BT/xGN+OaFurb4PBpfym3s5Ju1AEf9+dbaGGyG96rkwP2ZNVe11gWXGSoWSqBlmD7sm8EixfA78PEWf8i4woIFOJurqGhMdLYwTuJKj5d/Y+mDUoWa28MndgypBwFHwDfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhTb/bw3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2947BC32782;
	Mon, 15 Jul 2024 17:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721066175;
	bh=m5Qjim97u7Dn1CPZPoGktU573XyhUeUEwVBsOqclmLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HhTb/bw3Q7f1HIg3UPUqtSZjLKaVVqrNH7CsFe8YqkWU4GJkSkQTnKa+rvDmjD8Gz
	 8+VA29cnROmnYfIfJOVjotJ//EKkoRv3f/ObmczNFkwwASGclBxBvFopUQa5StC+HU
	 CgOYRdJYqzemue3V/ev6LBnayb/0wTojbOabInbqjm9O3m8nnRktvbyV4sjeaB7N5F
	 qxYscMRmOllNyKQvdn9g8NGQ+tkwHHMZD7She72F02cABm6MZCBPFIcg4uqTWRy4X3
	 YinKucvwMMn36qNVBklv+DgDxn2cyBv3dCYoe65Z4Z5BexCA/aM6q8MzPSnD0rcjLu
	 wh7MIrRDu1e0Q==
Date: Mon, 15 Jul 2024 10:56:13 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>, linux-rdma@vger.kernel.org,
	Leon Romanovsky <leonro@nvidia.com>, netdev@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Parav Pandit <parav@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: Re: [GIT PULL mlx5-next] Introduce auxiliary bus IRQs sysfs
Message-ID: <ZpVivaPpdiep9Oxr@x130.lan>
References: <20240711213140.256997-1-saeed@kernel.org>
 <20240713155105.233dd84a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240713155105.233dd84a@kernel.org>

On 13 Jul 15:51, Jakub Kicinski wrote:
>On Thu, 11 Jul 2024 14:31:38 -0700 Saeed Mahameed wrote:
>> Following the review of v10 and Greg's request to send this via netdev.
>> This is a pull request that includes the 2 patches of adding IRQs sysfs
>> to aux dev subsystem based on mlx5-next tree (6.10-rc3).
>>
>> v10: https://lore.kernel.org/all/2024071041-frosted-stonework-2c60@gregkh/
>>
>> Please pull and let me know if there's any problem.
>
>Hi Saeed, when I pull this I get:
>
>  net/mlx5: Reimplement write combining test
>  RDMA/mlx5: Add Qcounters req_transport_retries_exceeded/req_rnr_retries_exceeded

Hi Kuba.
I thought Leon already sent one pull request with those, but maybe I was
mistaken, anyway they are needed for RDMA, this is why they are part of
mlx5-next. 

So yes please pull.

>  driver core: auxiliary bus: show auxiliary device IRQs
>  net/mlx5: Expose SFs IRQs
>
>and the subject says mlx5-next, so please confirm if you want me to
>pull this or there's another plan..

I see how this can be confusing, next time I will remove mlx5-next from
inside the brackets :).

Thanks,
Saeed.


