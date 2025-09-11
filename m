Return-Path: <linux-rdma+bounces-13299-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA54B53EE1
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 00:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D47DAA8400
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 22:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B532F49E5;
	Thu, 11 Sep 2025 22:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0O/83sd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470BC2F3C19;
	Thu, 11 Sep 2025 22:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757631553; cv=none; b=eZceGptlH1EUrCOZuVGJPMpahu6tiUlRBcUI0HaHNg55wKdC/rcq+7i2IUYp0pR+eFA+6Z65PMc9jz8n0ROUGcjy7dHOr5DMhedZKgAbWHVsxOlz8rv2uiG+Nj5b695MyINGtll53eIhSIwB8ZsXAFmwM/OARo06lyXuMUYjd+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757631553; c=relaxed/simple;
	bh=P/ML/piOC3qFkZu5wM7mGQNtM9cZCuzt9Lt0I9+ZpXY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BWjTnBQ9RLhDRIJB6UPO4J1skksIrvLmavHlmcn+dDJbsnv87mXkU/gzNPckks6W6vdg2oG6o7NLwQ1EwzS3S4b+PGI2lABOw6fQGdPRMoixAeaLM6myfhRy+KGTBHX6P1ryQ6OnC5XJsWcsjLJ8enefGezF8rbX+PUi96G7YD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0O/83sd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598AFC4CEF0;
	Thu, 11 Sep 2025 22:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757631552;
	bh=P/ML/piOC3qFkZu5wM7mGQNtM9cZCuzt9Lt0I9+ZpXY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D0O/83sdJNJy0/kXf+Fx7ehH6KavrlZDKm98eJfLf2tG5iTy4VfzmqsXEmnKswb/8
	 3BhtocvAA7mQvYviwWDhmCXKDWIaiHKrfYMsDvHSdQPkBmItE6lHMyZZuhTnFqHd2i
	 yYMcLW6edJZj3RDBVHC5AiQtyvqCMOGdMTTnVSyVE5sq6haVyo7ZR6q9fLnwXA009j
	 SG4LZ+pIHocBzoiWMTGdcUsMws4AuVzWoztSXfR8AivmOKSuv8IHfzm5v4KkfV5/n7
	 zxFVkyjeEbtDFxnW9sVvTu2hNYIXEeDppoNpyzrXtCVZ0v4g4qqmdpLAR4kLAEWWFr
	 XUNh+I+pmKZLQ==
Date: Thu, 11 Sep 2025 15:59:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Parav Pandit <parav@nvidia.com>, Adithya
 Jayachandran <ajayachandra@nvidia.com>, Feng Liu <feliu@nvidia.com>,
 William Tu <witu@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: Re: [PATCH mlx5-next 3/4] net/mlx5: E-Switch, Set/Query hca cap via
 vhca id
Message-ID: <20250911155911.502d4d06@kernel.org>
In-Reply-To: <20250815194901.298689-4-saeed@kernel.org>
References: <20250815194901.298689-1-saeed@kernel.org>
	<20250815194901.298689-4-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 12:49:00 -0700 Saeed Mahameed wrote:
> +static inline bool
> +mlx5_esw_vport_vhca_id(struct mlx5_eswitch *esw, u16 vportn, u16 *vhca_id)
> +{
> +	return -EOPNOTSUPP;
> +}

Chris Mason is playing with some AI stuff which noticed this should
probably return false

