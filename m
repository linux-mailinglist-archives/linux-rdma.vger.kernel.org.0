Return-Path: <linux-rdma+bounces-7996-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FEFA40408
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Feb 2025 01:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD5B919C20AE
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Feb 2025 00:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C4435949;
	Sat, 22 Feb 2025 00:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbIP3G9O"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F82022331;
	Sat, 22 Feb 2025 00:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740183669; cv=none; b=Z0W31Sz6BYkA35liBL65Uu0HiIww0bbIHPy2qBffrCxpyJZSpKrigflZkBI0e7tzo2iqAwy53FxQ44j3hZOoj/+Jy+Acs0U/sTFHMcyauGa2oCbHCTKU0R8QCP5DbxtA5KKca61tjBZex69ucYeYEBiLuc+b+3836VM1wsR6KSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740183669; c=relaxed/simple;
	bh=w5Us4co0IXc6Eag9FCitU+k7PuUF/LaAJBwnhy4KrFg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UvS/z38/8LByvGHbca4JC15NKuPqsncTF4//JlJsncBNXPX2tH5bCGxABB4p8nuHNYp+W2DUVUb0HjmGvKQs6M/knhadUKu8jS24Z6TSU0mKvXSpDKW4PnFbbP56br7VmEZafNDuZBZvPSs5LlhZoXDLYvtP5vrR0kuoZ2ob3Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbIP3G9O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BDCC4CED6;
	Sat, 22 Feb 2025 00:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740183669;
	bh=w5Us4co0IXc6Eag9FCitU+k7PuUF/LaAJBwnhy4KrFg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EbIP3G9O9yne8m8kctpmELSYvahL8VNQjPBG/auPmdUcMfnRVXrBClf9Lx9JhZ2Rh
	 Vm1x++1/CvmPW//TgHcaaV4fsS/VfaaZutcmIVscrbHXs084fycNBRUcRc4KWm0ezB
	 6izPJgz78/KUSfvfzRLqJAqeGyL9k1Bxqh0gwpbKryd+PfyWG1l4399o3ip7RybjIW
	 ilKEynnkEeRtuFLyb4RTXmWxeawXmP/7aiUcceAM9FB2FJuJMP1Vv1J5KlTsH/IF2m
	 yjopxA+OSZ+rB52Zyxi9oLqU8GguJencwzPQtT0QpAviuhcBFr5wy5CQRA5Gjqn5Rv
	 3+IQkZ4SwhKlA==
Date: Fri, 21 Feb 2025 16:21:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
 "D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>,
 Wen Gu <guwen@linux.alibaba.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef
 Kadlecsik <kadlec@netfilter.org>, David Ahern <dsahern@kernel.org>,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCH net-next 0/3] Converge on using secs_to_jiffies() part
 two
Message-ID: <20250221162107.409ae333@kernel.org>
In-Reply-To: <20250219-netdev-secs-to-jiffies-part-2-v1-0-c484cc63611b@linux.microsoft.com>
References: <20250219-netdev-secs-to-jiffies-part-2-v1-0-c484cc63611b@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 20:30:35 +0000 Easwar Hariharan wrote:
> The conversion is made with Coccinelle with the secs_to_jiffies() script
> in scripts/coccinelle/misc. Attention is paid to what the best change
> can be rather than restricting to what the tool provides.
> 
> The non-netdev patches that include the update to secs_to_jiffies.cocci to address
> expressions are here: https://lore.kernel.org/all/20250203-converge-secs-to-jiffies-part-two-v2-0-d7058a01fd0e@linux.microsoft.com

Can the secs_to_jiffies cocci check script finally run in report mode?

I think that needs to be fixed first, before we start "cleaning up"
existing code under net.
-- 
pw-bot: defer

