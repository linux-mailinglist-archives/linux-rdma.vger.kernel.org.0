Return-Path: <linux-rdma+bounces-12861-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A273EB30916
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Aug 2025 00:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A7CC189334E
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Aug 2025 22:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389CC2EB85D;
	Thu, 21 Aug 2025 22:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hknPbCfX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A182E0916;
	Thu, 21 Aug 2025 22:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755814788; cv=none; b=JaD9WkQVPorhInljMgCZk9kbgY1RTjRDxnkz3WzX4hY/AgnGS9iWK0lw+lay73KjRVuwlP617FUWp8dgg5S7ltC45o6OBBzmmwRTiUJ4eTKLmjEcWBk3JfouxrmGjdB5Qsq7tWIJo0krQVqOojFlm4RZwPZ6GwgIkvAmU38CFbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755814788; c=relaxed/simple;
	bh=Nm1FMegGLNQRIXI0vtNevW2aICX6z6yh/GAyh9ECG8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3uZNXVPVyMkUDt0ez/JnC+G8Mgv/azJoCf4/FW4hWzmOqSc5VDk23al+hhG9YE11+qh2fYQEwLZrWA973yz2/4Ol3U5IZ+vFYSwym57ftY2/t2iKOp3iKPP3W9VsRJRBkqxA6n0EflwCtJm9NuMrwn/RmPdHa5Bu21uAj6EFiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hknPbCfX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE77C4CEEB;
	Thu, 21 Aug 2025 22:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755814788;
	bh=Nm1FMegGLNQRIXI0vtNevW2aICX6z6yh/GAyh9ECG8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hknPbCfXCtW7amhR9pvu51poNN/1lNjejvvIDUhhyFVmqRIDNJj+bDo+FC97B4Onc
	 HaIMT7ciTMtuILoGmbPe3b67hFd0gfa7R9XAN717zXvAEWfx6raIh8shK4ld8Vk+37
	 Eu7U24ikBzFqxMzUxF16qt4DfpZQ2XWkeW+n5FGuJD2pLD+YT6jvm2ztQMwADudwCo
	 WAKOo+4ByggBBlB+efraBb98lpxDRamnZCgYWm5L+NFaHbiNS4iK/jp+hCIjdwqIS6
	 U27ApDvBM/QgYWWByE9q56LIiq+16GRxfta8EvdkIl3c5vNb/4Jrx9nrjMFcSPciUB
	 ialSIrLMNzNaQ==
Date: Thu, 21 Aug 2025 15:19:47 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Parav Pandit <parav@nvidia.com>
Subject: Re: [GIT PULL][mlx5-next 0/4] Cached vhca id and adjacent function
 vports
Message-ID: <aKebg86MTNxhegvZ@x130>
References: <20250815194901.298689-1-saeed@kernel.org>
 <c263ea0a-adb3-4c91-81b8-cb5b283c5806@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c263ea0a-adb3-4c91-81b8-cb5b283c5806@redhat.com>

On 21 Aug 10:37, Paolo Abeni wrote:
>On 8/15/25 9:48 PM, Saeed Mahameed wrote:
>> From: Saeed Mahameed <saeedm@nvidia.com>
>>
>> Hi Jakub, Jason,
>>
>> This pull request introduces a preparation patchset for caching vhca_id
>> and needed HW bits for the upcoming netdev/eswitch series to support
>> adjacent function vports.
>>
>> For more information please see tag log below.
>
>This has a conflict vs net-next, could you please double check the
>conflict resolution?

Looks good, Thank you Paolo.
>
>Thanks,
>
>Paolo
>

