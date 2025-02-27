Return-Path: <linux-rdma+bounces-8191-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17824A48B8E
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2025 23:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBED116D38F
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2025 22:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2AA23E337;
	Thu, 27 Feb 2025 22:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFs4eDMr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1A42777FB;
	Thu, 27 Feb 2025 22:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740695249; cv=none; b=Sz3mViM0Exr4HQRyml97KTXiKlZTssc0WM7jVOAyI3V7Wkgmt8ejZ0aeRDAktvtLuO6n+/dfbyXsxC19ghn4p4tPMoNLpZMFdck4zdKqc5lUh3wvMwR19Y9pVOCUGV3web9GWv+JbNXrozy2v+qK+rFBne7Ff1vyHzvo8+YJ05c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740695249; c=relaxed/simple;
	bh=96pSSj+jAeeUv8Kf2rgomEwAi8sdHZX5niFNLuSN/dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrP1YE6CNLgqhDS8Zkg6+Pve+3PLQtor1B5EDinRshFtvi8OSD7CPUmSf70O9nKF/Z+/nRvebGjcwTfG0fl94JRtvE9VDtAVFXWjACWbYhtn1FO6F+kX5GTELzNHPC4Bs6z8FDgcW9JCRgjsEgC55Qst1qKGva5FueU1kECrIZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sFs4eDMr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A3AC4CEDD;
	Thu, 27 Feb 2025 22:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740695248;
	bh=96pSSj+jAeeUv8Kf2rgomEwAi8sdHZX5niFNLuSN/dA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sFs4eDMr34h2DDvmtOqE9WpoSYxpM0wNuqTpid8DU6vBtzUd9yqPhbUjL+OyqFcdH
	 3S8B2yZ3b43Z/fOtECdTgU1jIU+oehc2T1F6Z7TrYEiMWbjIYsHGVsvQxBm0XVHYdH
	 F7ADWh8uml4kA8MRsDSUz0BAEEovpY1HorLEbYg0Xt7nxjmndH6yqPPnKBv0BcTShu
	 MhQoiQTAVF4zZVPnjjETaLio9sYsDi6nAuV5svCl2VDqfpXhMXl8F47NS1po1KkJYb
	 r0ryZWd1/iEd8ddiTuB3bKpQNMsvYQwm+4quyz+dBahSYcHfLCavy4dEo9hr2dDHCN
	 7qklH3IfnvzWA==
Date: Thu, 27 Feb 2025 14:27:27 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3][next] net/mlx5e: Avoid a hundred
 -Wflex-array-member-not-at-end warnings
Message-ID: <Z8Dmz_UPfR-WS8LI@x130>
References: <Z76HzPW1dFTLOSSy@kspp>
 <Z79iP0glNCZOznu4@x130>
 <20250226172519.11767ac9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250226172519.11767ac9@kernel.org>

On 26 Feb 17:25, Jakub Kicinski wrote:
>On Wed, 26 Feb 2025 10:49:35 -0800 Saeed Mahameed wrote:
>> On 26 Feb 13:47, Gustavo A. R. Silva wrote:
>> >-struct mlx5e_umr_wqe {
>> >+struct mlx5e_umr_wqe_hdr {
>> > 	struct mlx5_wqe_ctrl_seg       ctrl;
>> > 	struct mlx5_wqe_umr_ctrl_seg   uctrl;
>> > 	struct mlx5_mkey_seg           mkc;
>> >+};
>> >+
>> >+struct mlx5e_umr_wqe {
>> >+	struct mlx5e_umr_wqe_hdr hdr;
>>
>> You missed or ignored my comment on v0, anyway:
>>
>> Can we have struct mlx5e_umr_wq_hdr defined anonymously within
>> mlx5e_umr_wqe? Let's avoid namespace pollution.
>
>It's also used in struct mlx5e_rq, I don't think it can be anonymous?

Yep, I see now, Thanks!.


