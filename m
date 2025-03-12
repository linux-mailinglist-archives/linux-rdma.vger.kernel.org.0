Return-Path: <linux-rdma+bounces-8626-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34632A5E552
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 21:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 581037A550F
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 20:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D6F1EDA33;
	Wed, 12 Mar 2025 20:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ln6Jkbr/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1BC1BD9DD;
	Wed, 12 Mar 2025 20:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741811390; cv=none; b=rVLaiyfagx2qRiJBpRMdHcNmH0ofalHyNf4iDTM+Q9Ea46C4LjQfDe396Vqc6hjZqDFb68sDlLk73UZXaiZJVd0oCvZEBTNf8LsGqjHGWcA4+W6Bl4y3OEo4txis6+5H0guorQMO9UFOi8NYYkczJ8cz5AbvKHxQ113GJPk75jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741811390; c=relaxed/simple;
	bh=onXuN2LGH83bYRtcbmLC5glTTauAdzMOlEZg3+qCzbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o9G+KCPZ4wGCVSLOwTx7RS5cBALCBqTSYGbc2R7kVySTWT3EpyMVh8KN3MLpmMwhXVO5Ym3j+oJ0dz4ijxcWhs9F1IYD2kZDNeKHPF+DViQ5iH8ofR3s24TPKPwyk+2TBVGle6garz4e8m8iX07iZ2f02OcrYRkncXs7b8IMG/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ln6Jkbr/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30BEC4CEDD;
	Wed, 12 Mar 2025 20:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741811390;
	bh=onXuN2LGH83bYRtcbmLC5glTTauAdzMOlEZg3+qCzbQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ln6Jkbr/J2TFMaMxmBw30DE+/ElwjX/AqnW0iFyzeHNmPb2XQx/WyHn40iYQUAHEM
	 ZnuzgDXL3BdXl7wlh2QROJDK6o8cpGi6syZ0cORySPeYR41RHu3uUviRevCp8XcUJF
	 YG+FbZT7Wl3JDbxfw1R5oLHFdUPkczlvw1BcAtZjsE/CqfDP8tC9kdhhneQLIPmWig
	 ko4MPt5qYrNuocuPOLZ/NBvUGuNCIxKiHXWCZw1JCpUxdwnlH0bL59fvQ7yzqGtoZ4
	 0VDOlbCSf0z9ScS9huzv/ZHbp4WmjW4xnwP7hXLslXEoPJaNk5wW0sc+oYRAHWvbiw
	 yOeHfmJjjscfg==
Date: Wed, 12 Mar 2025 21:29:42 +0100
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: patchwork-bot+netdevbpf@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 leon@kernel.org, saeedm@nvidia.com, gal@nvidia.com, mbloch@nvidia.com,
 moshe@nvidia.com, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, leonro@nvidia.com, ychemla@nvidia.com, Tariq
 Toukan <tariqt@nvidia.com>
Subject: Re: [pull-request] mlx5-next updates 2025-03-10
Message-ID: <20250312212942.56d778e7@kernel.org>
In-Reply-To: <9960fce1-991e-4aa3-b2a9-b3b212a03631@gmail.com>
References: <1741608293-41436-1-git-send-email-tariqt@nvidia.com>
	<174168972325.3890771.16087738431627229920.git-patchwork-notify@kernel.org>
	<9960fce1-991e-4aa3-b2a9-b3b212a03631@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Mar 2025 22:50:24 +0200 Tariq Toukan wrote:
> > This pull request was applied to bpf/bpf-next.git (net)  
> 
> Seems to be mistakenly applied to bpf-next instead of net-next.

The bot gets confused. You should probably throw the date into the tag
to make its job a little easier. In any case, the tag pulls 6 commits
for me now.. (I may have missed repost, I'm quite behind on the ML
traffic)

