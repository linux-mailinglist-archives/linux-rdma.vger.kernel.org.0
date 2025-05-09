Return-Path: <linux-rdma+bounces-10176-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39ABCAB07D2
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 04:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D19267BCEB0
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 02:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B819242D8C;
	Fri,  9 May 2025 02:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMEfJhQP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22577E0E8;
	Fri,  9 May 2025 02:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746757077; cv=none; b=T9f3PmfrZXK7zr/f/Et9hXfH2FK9Gn8Y0P0kF1asleYMHd4rExuYHK9md2rL/ZoSc4E6RboeLcOyjuqH/4RJiszURxsL3ejPYA5yLe+b6Im1V4P2z8pQVOnP3qnRpCw+MuIo7BPQvpLJmL2lN5DSUDHEjAHBKmnbzTjb3YlZAvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746757077; c=relaxed/simple;
	bh=wGEzWR6WTZcRw7fY06oJ8MlbhCBOdgHesLcRLWkuAG4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s8TORnvA5LkCwC80htv8Cq73bZO8mGUVvZqGZmEY3fpQmCow/I69YKS3zOjwtL81qapL7Nu2r6H5xR3Hr23Zrfwlkr2n0dNwqkg3MvjlQZNN+ne7oIf7dbTIMGYZeyewVEChJavRnNL/SuUKfD5D7cllJgY9SYzCwNTJ4FLQg9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMEfJhQP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A114C4CEE7;
	Fri,  9 May 2025 02:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746757076;
	bh=wGEzWR6WTZcRw7fY06oJ8MlbhCBOdgHesLcRLWkuAG4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mMEfJhQPbLgGN0mbI+rYp1xnbX+2+3AGNeLtrxufB0TJEaD1f9xDZmNaArwa9W7bs
	 N9hT354TQ9vIh6ncMAdqwt+Ccf4AKW22zOaQjcUOSuv8yuXiyp4AvLswofG7f1ta/S
	 IvZV86XZUT64wMqloQIpcYNxqxCPNToH4dkG3zUfYXcs/zMCfmoUuoq5TogckM81O8
	 UWMWj9hYX1pIhus/BLK1ocmqBwHwOXc5yWPi2LWNswIJQ6iodtTdrgX3Dyyt0BShHm
	 iaZTvpvhdOsAxbgx75boB9lj1yvfnFLjrkxrFNQr4jFOic+2a9Gq8UP3Ae7arO7/7/
	 i7qJke4RZ71Qw==
Date: Thu, 8 May 2025 19:17:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, pabeni@redhat.com, haiyangz@microsoft.com,
 kys@microsoft.com, edumazet@google.com, davem@davemloft.net,
 decui@microsoft.com, wei.liu@kernel.org, longli@microsoft.com,
 jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH rdma-next v3 1/4] net: mana: Probe rdma device in mana
 driver
Message-ID: <20250508191754.21e9ad31@kernel.org>
In-Reply-To: <1746557541-3617-2-git-send-email-kotaranov@linux.microsoft.com>
References: <1746557541-3617-1-git-send-email-kotaranov@linux.microsoft.com>
	<1746557541-3617-2-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 May 2025 11:52:18 -0700 Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> Initialize gdma device for rdma inside mana module.
> For each gdma device, initialize an auxiliary ib device.

Acked-by: Jakub Kicinski <kuba@kernel.org>

