Return-Path: <linux-rdma+bounces-11258-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DE0AD73A4
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 16:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9C4A7A5A72
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 14:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5161AA1FF;
	Thu, 12 Jun 2025 14:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmXCOEmM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D63F146593;
	Thu, 12 Jun 2025 14:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749738142; cv=none; b=C6O5+aye5QgUj+DooZ9dXoYZ0p4jKwAb1GUjysvec/J+H/wkw2dnouFEe2Gb5V4LD3BYxnhCEmgPLOO6nrUWh5/kkOHmkSbE5HZ50Vemc1gpqtUnsZW496IQf0gkFdyxbSgelB93Lm9kDZ1HPZsWsU8FS8i4QTKJopkvc+8M0PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749738142; c=relaxed/simple;
	bh=TKeuNZ9kN5+bA+xcCfKcZcGurNnPgj25mlIXAv5jxU8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t3N1QF1z38Mz6/cZuiVvGKxNTPMqo1YtrxnZPDok9re3gYbn43ijZW6J8mCtiXk0RodQ9FAJqB5ukh7pBgf/lDRH2xwQolAak8tlkYHYPXYeP40tEV0R9FYNkVjvxKLcJ6eKCMGZnsWy+SjbIPeIug56sS2vaK2tGT+Y14a8sxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmXCOEmM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA48C4CEEA;
	Thu, 12 Jun 2025 14:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749738139;
	bh=TKeuNZ9kN5+bA+xcCfKcZcGurNnPgj25mlIXAv5jxU8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pmXCOEmMDFLNdrTN0LESQ7c+5TfJdSxWZGFysFgsfKKlf1QymLA4rdJsCHGOzcX7B
	 0hkR0yUuu/2NVL3YgUyiuWwvXbzKvAc1Iua92HUQymO3+XmyvYvkFiks9kHWTvLo7V
	 azIhcW3SBwQZBEpYb0nXs4BgBwpuQ/kdTb5u0Kfvc2DK7eTLfe/r5vbbB+0ZGpjxrm
	 ECwDWuSQ2yb6WZXdYiMA5iULsGgoLPcxQn5n8KUhlDBsr2hjCM3DKHy+I/xM4+Yjg+
	 sYEM93CzZqH8ONX7N9wdI5gOwnpYk0PwlJVbnsWfdZVsJYXAoQGyBvFP1kqHprY5zl
	 QTCH/UEVdONEA==
Date: Thu, 12 Jun 2025 07:22:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mark Bloch <mbloch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com, tariqt@nvidia.com,
 Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 7/9] net/mlx5e: Properly access RCU protected
 qdisc_sleeping variable
Message-ID: <20250612072218.6be4547f@kernel.org>
In-Reply-To: <bdfe62f4-8b70-4284-b06d-e50ea6ae2d88@nvidia.com>
References: <20250610151514.1094735-1-mbloch@nvidia.com>
	<20250610151514.1094735-8-mbloch@nvidia.com>
	<20250611144013.300c79ea@kernel.org>
	<bdfe62f4-8b70-4284-b06d-e50ea6ae2d88@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Jun 2025 10:31:45 +0300 Mark Bloch wrote:
> > I don't think this is a functional change? We don't treat silencing
> > compiler warnings as fixes, not for sparse or W=1 warnings.  
> 
> Well Eric's commit: d636fc5dd692c8f4e00ae6e0359c0eceeb5d9bdb
> that added this annotation was because of a syzbot report.

And your point is?

