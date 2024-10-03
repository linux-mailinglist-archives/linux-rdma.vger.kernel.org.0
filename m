Return-Path: <linux-rdma+bounces-5187-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6DD98E7B8
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2024 02:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B8081F23420
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2024 00:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453A8881E;
	Thu,  3 Oct 2024 00:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVSqa+wP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4135C8CE;
	Thu,  3 Oct 2024 00:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727915034; cv=none; b=nOomwgFr1HxnqjVK1ASXkIGs3wMnv0xh6p9ZZslrh8cEB3iADrYmX1SjD/99Z+vVLMJPYrW8/JYMF/L5zbAaYq4yNU+qUuqfNXLXa4Y4HMMK91gCD3dRY/hQR9oMEfMYzofXmXE7KVK4xYheSNyhqoAHb7Gwni9rfwI/W121yOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727915034; c=relaxed/simple;
	bh=QSkjVkA6fnzVOHYnLzqA0MO/M2AZ02minYhosjq/Yaw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CX3DjQNrgpeiWFnCFxqTMHwPgtF7OkM4eXKoeI5Yb8wFTvjxUq6g1nEfOILS+I1pdNw8v7PRV6RtS2pdLY0jU9dQzIu1fWb1mGpPFHWeC1cULAcbq7+JqD0vGqww1u03Xsy4wU6uYcmRQcAZ7hyS0oZQZ3Omz498O5Gak9dZVXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVSqa+wP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793DEC4CEC2;
	Thu,  3 Oct 2024 00:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727915033;
	bh=QSkjVkA6fnzVOHYnLzqA0MO/M2AZ02minYhosjq/Yaw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PVSqa+wPY0cgowDiA3OojeA6j9o7k8YmcQYhoosev7nBuo1VIp+Xo8DZ8l0L82TRL
	 toWWHQSuNNRq3G6QonC74P2yPyaHKWcHoShxCwsWBszRS1oXad9v69RqNawpRNWx2V
	 ACe9Lbt7RCjYmrK09hheMPvCx2ZQp5m8QyRVl74ZnQ2h8/kaxzB2RfE4wogAMLlJtr
	 5zF1d8UBMIfrhBlEfSmlQR1KtJxw27VikK5uvCBhcT7bDjIMbq/3Cf9Mtd9ZDJpuzA
	 cHPXXkcydMsRTq9JbtNq9E0np1KLvesskc9azLJ9n//R/qf91IbR9QHXuMGENb8yiw
	 B8Oy+PERAUKDQ==
Date: Wed, 2 Oct 2024 17:23:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 shuah@kernel.org, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com
Subject: Re: [PATCH] selftests: rds: Remove include.sh when make clean
Message-ID: <20241002172352.56ace707@kernel.org>
In-Reply-To: <20240927044923.12814-1-zhangjiao2@cmss.chinamobile.com>
References: <20240927044923.12814-1-zhangjiao2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Sep 2024 12:49:23 +0800 zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> Remove include.sh when make clean

I don't understand why. At the very least you need to improve the
commit message.

