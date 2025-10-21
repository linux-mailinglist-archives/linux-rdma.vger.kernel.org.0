Return-Path: <linux-rdma+bounces-13967-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B88BBF9676
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Oct 2025 01:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 60E7E508A02
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Oct 2025 23:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8AA2C11F7;
	Tue, 21 Oct 2025 23:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUqqQujo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B451C8611;
	Tue, 21 Oct 2025 23:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090481; cv=none; b=X3a5IzkZPmJ4OfJFv0CiSgvrqc3S5zGKeBu3LrRtJ7GCg+opkRb+/EyGPRzKp4afqfSj3shvYccF6P8P8xf7XSJoB6j9yQVDGBcW3doLdPaxNLrO844dB0FRLY36Q9zksCxyKt2a0zSldBKtYEtCBaNz4u1tdXlFm8SRrvJ8fWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090481; c=relaxed/simple;
	bh=+NdS7WesNl88CrHTIVbyWa+8GFooWUYwX7Uts1AzlH0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HlEZVko+0RKPUhSUQPNwQC4c/PZhGakM9lCcdZfY7sNQtSs2hvCcVxm1deeaiNWDw7OuYyyFhWn8PAJ6LuD12sKSMbt4KIwKEEib35MMhwY3y3urfOLmAbeA5HQXpx5HD8SVqzRjFj66QxJYMMudvMvK9JrzkLqzid84uYABdLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUqqQujo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8479C4CEF1;
	Tue, 21 Oct 2025 23:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761090481;
	bh=+NdS7WesNl88CrHTIVbyWa+8GFooWUYwX7Uts1AzlH0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CUqqQujo4WLrcCey0Ur1krzv9etZ8h/7HRI3aePzBl2fPYaAb3fV6vjuaCdzjHzUm
	 97lmz5l58fBcQNruQcrpl1ceM5AW2nBXH9Gp4yE9MOYnloZUGLP99/PKkTG7+xkytz
	 s8WXSyMEjmcokfYIOjBAFctkGw/dNxJ2m9x0kR0wuwqhHnMpwYDZfBcVS6yvl9bIZr
	 g8qBjI/dR+DUWuuz8Judr6b4VlNba0cutYMGo2tbbBmchaGN1ELUc8UBwtPY8GOz3B
	 VUZgiYYgGBvI0VZTQGTZ6XuIGuliqauOZRwdBBKkN9DSMOCk1hQSdJVKWl3tQrMWPM
	 JMT5Gw39i62xA==
Date: Tue, 21 Oct 2025 16:47:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>, Adithya
 Jayachandran <ajayachandra@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: Re: [PATCH mlx5-next] {rdma,net}/mlx5: Query vports mac address
 from device
Message-ID: <20251021164759.2c6a5dc9@kernel.org>
In-Reply-To: <20251016014055.2040934-1-saeed@kernel.org>
References: <20251016014055.2040934-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Oct 2025 18:40:55 -0700 Saeed Mahameed wrote:
> Before this patch during either switchdev or legacy mode enablement we
> cleared the mac address of vports between changes. This change allows us
> to preserve the vports mac address between eswitch mode changes.

Not knowing what exactly a vport is I can't tell whether this preserves
MAC addrs of reprs, the uplink, something else?

