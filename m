Return-Path: <linux-rdma+bounces-13021-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D86DB3ED2F
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Sep 2025 19:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46A3B189F185
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Sep 2025 17:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5CC34574C;
	Mon,  1 Sep 2025 17:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N33Y/byO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB863451CC;
	Mon,  1 Sep 2025 17:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756746516; cv=none; b=DZz4xzqKLTKWB7NmpOdFlBBwLg/5bvwREoP96uIlbPHxK2lsHG05lDHZSGo8lEHbMPpo/4uCz8HA0jYkv39/tsNSGB4fk51j3+l7LLrUZ40VsqE2ctH/gIIVAHIOCE1ZhUuvym7SilEcOc/k/n6JRU64DCqTH9aIZi3iMEH/gVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756746516; c=relaxed/simple;
	bh=UxkIIFKap9sAvvGQ8hTKOIfE/eeyxdYvnFXmy8j2qAI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=StevVaN018IAy3vphzR87nHUX+Z1v5ZQnUSS53ZE6f3XWVXD5VejHSSNMPYoqNZlk8kK7HTTD5cz+TYRlW4eIzEtJz4aukL1mwbmyM3qNIB87JSg+RiESUm5KO7t6wM09t9BQtHYgqB/p0m6SIRPN36pqLox8Bqy4xeOozIhGoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N33Y/byO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D912C4CEF0;
	Mon,  1 Sep 2025 17:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756746516;
	bh=UxkIIFKap9sAvvGQ8hTKOIfE/eeyxdYvnFXmy8j2qAI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N33Y/byOWpwsRs43YhOi3Sxws2GaMUo8HT1N0W5XHsQ+mqDpcNSoXX7/HI1Yidfe+
	 nsrB4CwoCqEMwQo53QnRkabAJF8wsB/Z8kmO9g51UNGO79LSmUN4rGPgt6AXIbaluu
	 M8XXWIE04hv+ec3mHJnyCCfCZq7DDkQCih1/XiJfAAXOcHVFS514HpnfjRQQYX89CM
	 SZCdrPnMWDni51N3HqyUeikgCEn1AbvIxa34kSsmjtGgVN5BzOPL1SSZrq03t69qA7
	 wCFQVJBfQ6NkNmB0ZIRvmMr+rGvgOaKwO+4gYGrwaROKSXfYztnmAoLdfmVpJ7uzdn
	 MLP31TsqnvAcA==
Date: Mon, 1 Sep 2025 10:08:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, brett.creeley@amd.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 corbet@lwn.net, leon@kernel.org, andrew+netdev@lunn.ch, sln@onemain.com,
 allen.hubbe@amd.com, nikhil.agarwal@amd.com, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/14] Introduce AMD Pensando RDMA driver
Message-ID: <20250901100834.130dd527@kernel.org>
In-Reply-To: <d829c4ee-f16c-6cfa-afdc-05f4b981ac02@amd.com>
References: <20250814053900.1452408-1-abhijit.gangurde@amd.com>
	<20250826155226.GB2134666@nvidia.com>
	<d829c4ee-f16c-6cfa-afdc-05f4b981ac02@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Sep 2025 11:57:21 +0530 Abhijit Gangurde wrote:
> Jakub, thank you for looking over the Ethernet side 
> earlier(https://lore.kernel.org/linux-rdma/20250625144433.351c7be4@kernel.org/#t). 
> Are you good with them being merged via the RDMA tree? For context, the 
> ethernet patches are getting applied on net-next, and there are no 
> further ethernet patches planned for this release.

Go ahead.

