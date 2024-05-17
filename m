Return-Path: <linux-rdma+bounces-2533-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEAB8C8CB5
	for <lists+linux-rdma@lfdr.de>; Fri, 17 May 2024 21:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC94B28219E
	for <lists+linux-rdma@lfdr.de>; Fri, 17 May 2024 19:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA93140360;
	Fri, 17 May 2024 19:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSeHff7m"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C6013FD8A;
	Fri, 17 May 2024 19:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715973566; cv=none; b=LuL/s9zXMXUFmiGYDQTbHbrbRRIxhkntHcV5kCsUKiekWtxFGKxrKkkXalNy6OpCTXVOvWjV7qzWHZEirstVDW9NDGdiE/mgtXeZy9Wa5t0Oex/A00oWY9c38uXij8qXv7/uOPwJYKvufTfG017Q8/NprH1AouNAdVf3bLLDH/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715973566; c=relaxed/simple;
	bh=T6YELuiicdLvckmQnj8UC8/6cyxQGgj79Vf8F4Zu4aE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F1Mm3yfx+lojvX/vzjBRm3uyqgHE5hbc3oH5ZA/vtQGdMi+QUm2ZbDvkComrkwysUR7tGWuPUqiRA1CYjMJ9gAoQTZGs9tJIiTGlt25125r+XuAidZZDh/3EU4V/+9TOFOvmpAJz/37Vy6TM2mWt6Fgjqh+mvOOmUbJt1Yjvyu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSeHff7m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215D2C2BD10;
	Fri, 17 May 2024 19:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715973565;
	bh=T6YELuiicdLvckmQnj8UC8/6cyxQGgj79Vf8F4Zu4aE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bSeHff7mpcC6ybRuhygT9Z9AYote5OC1gTKczM+RQC1RoRF3QjxKh6Oh5Z4i6c9Vt
	 iwK54mFTiBJVw6k6c8kQc/isTY/zb+gMEkCMiFZqlShJE3IeD9wdbQbBWpUeN5SlzX
	 i8nR5tKI5SDH64OBPW20XFmLoEqN+IhpKMKi2BFMdlg44O3sVUWBok6TuzbAqeTzjq
	 ZjT0VgeIZW0oB4hzBF0hKyRiJ6sv/dFJk+wer2I37yWOHOdFTHNEuh1uTBv12r4gD5
	 7V7vKEJ/XMtr7Vzmd6ztqaSOe3kR5f3UKVOaIRs+nbbToX5xdSAp2kg5SuJUKRceT3
	 mAh/+RaZ3CR1g==
Date: Fri, 17 May 2024 12:19:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 wintera@linux.ibm.com, guwen@linux.alibaba.com, davem@davemloft.net,
 netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org, tonylu@linux.alibaba.com, pabeni@redhat.com,
 edumazet@google.com
Subject: Re: [PATCH net-next v2 0/3] Introduce IPPROTO_SMC
Message-ID: <20240517121924.6bd24a78@kernel.org>
In-Reply-To: <1715755306-22347-1-git-send-email-alibuda@linux.alibaba.com>
References: <1715755306-22347-1-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 May 2024 14:41:43 +0800 D. Wythe wrote:
> This patch allows to create smc socket via AF_INET,
> similar to the following code,
> 
> /* create v4 smc sock */
> v4 = socket(AF_INET, SOCK_STREAM, IPPROTO_SMC);
> 
> /* create v6 smc sock */
> v6 = socket(AF_INET6, SOCK_STREAM, IPPROTO_SMC);

## Form letter - net-next-closed

The merge window for v6.10 has begun and we have already posted our pull
request. Therefore net-next is closed for new drivers, features, code
refactoring and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after May 26th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


