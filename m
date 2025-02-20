Return-Path: <linux-rdma+bounces-7923-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5E8A3E6F8
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 22:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E67C117F184
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 21:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F441F03FB;
	Thu, 20 Feb 2025 21:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hb7z5bA5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5259D1EEA46;
	Thu, 20 Feb 2025 21:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740088176; cv=none; b=lPTl2kY7KbH64E1SzwXU257OKAgGaTC5nUaw2+bEzeWUHFdZW2vDrEb0K5AvBXzoFpxIWK8gXrtDmsI1Qa0TwrJOSdlESa5RVOApRc8VqojfP5NdHOh4b5bqp/ojJ+KcyecKvYi/5zIznTWPyByYpdBqo53eefaFTxGXRARGgYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740088176; c=relaxed/simple;
	bh=wdsZPzPbhv+wvfcf6LeIHs2yOw0f+pNC+OzrpwgTSns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBYeoFsoTvuax+HZrhf0DxizdgzvAr0hSpZA+I3HULZTuixn3YEdQO16TUyOqD6oIjPOvinpz0NgCpwJ2K7/KsAg501FtZ3qOdKezK261AzpIQYFzQQp/KzoH7sPyLa3uSkTQhntPxqWbJYqA3jCmwL/y2bUBZNop8PqyFxbnkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hb7z5bA5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15D7C4CED1;
	Thu, 20 Feb 2025 21:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740088174;
	bh=wdsZPzPbhv+wvfcf6LeIHs2yOw0f+pNC+OzrpwgTSns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hb7z5bA5oG53Dbi1NbSzar3pK9cMMCVFmfQUW98lw5W3DhgJqtKn7qpPqwMuBHJpa
	 jI6e65vSaf1FsK6D0PpHgxN0YCW2Mkzs/vLqhDpZDydddmSO9k7f1m1zKMzyNs6gMQ
	 1+F8AbTWdOancoku6Rxm7oun3vnk6cMMSDGotUCjYsykyVdTG7xRJ2PeyJXojnA+9F
	 IBT05GUJPp/5Pzfp1yLHUL9+CRHi82AT7akipSd8P/5NcBrSbbmnAhfC0Ggrmi8b3w
	 a2RGZd3BMss7bKgYYZvG1w8wIL91+GCu2FSU9jbSTaspdmagtmJ8GqdX8wLLtyO6vc
	 lklG6b8xlNPBw==
Date: Thu, 20 Feb 2025 13:49:33 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] net/mlx5e: Avoid a hundred
 -Wflex-array-member-not-at-end warnings
Message-ID: <Z7ejbRN6kGluzVR3@x130>
References: <Z6GCJY8G9EzASrwQ@kspp>
 <4e556977-c7b9-4d37-b874-4f3d60d54429@embeddedor.com>
 <20250220102658.39df9b36@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250220102658.39df9b36@kernel.org>

On 20 Feb 10:26, Jakub Kicinski wrote:
>On Thu, 6 Feb 2025 15:07:07 +1030 Gustavo A. R. Silva wrote:>
>> Here is another alternative for this.  And similarly to the struct_group_tagged()
>> change above, no struct members should be added before or after `struct
>> mlx5e_umr_wqe_hdr hdr;` in `struct mlx5e_umr_wqe`:
>
>Gustavo, could you submit this officially?
>

Can we have struct mlx5e_umr_wq_hdr defined anonymously within
mlx5e_umr_wqe? Let's avoid namespace pollution.

