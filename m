Return-Path: <linux-rdma+bounces-3326-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D1090F0D4
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 16:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 621591F27728
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 14:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8061C1DA4C;
	Wed, 19 Jun 2024 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X68VFpeo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312331EA6F;
	Wed, 19 Jun 2024 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807781; cv=none; b=BZV07+gPDfoX7xJf2hYr1jRS1DALnW7IFhDcv4onWb7NSlDBy25FWqHnVzPh68kJgAKfACH/slITdNVWSn5GDB54FYzcXkeCuAb00nIlxSSkzR5iY7PUwBz6c8liNxBRQUwBKCxXgjTXjVub9nLPV+YgJhGScQj0H8zcKs0Lqb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807781; c=relaxed/simple;
	bh=bFBs88j6/FfxqMPUWR0eu9qIf6QcyLZBSdZq42JetGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QphwYj0VweF1iNS0I+2KUPqbfvwhbCrE6FjvRYnpUI1/57NrgpCoCbfGmOq5+KJmX8e16x7+QKd0MgzqJS0yBBz3Nu6eZRSn3gK/s/gldstuZoNNCynbOBZdefKKhHHg9j1d1BmdBuym4qI3NBFQZtrtPT40nbX1pl1XtNz3mnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X68VFpeo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031C3C2BBFC;
	Wed, 19 Jun 2024 14:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718807780;
	bh=bFBs88j6/FfxqMPUWR0eu9qIf6QcyLZBSdZq42JetGQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X68VFpeof3xbyemn/bu2+GrJJ/FU1pqNFkDTRbruK6hX0qUwq0rqCT3LFB2rR874G
	 EsqFvQHTgEuwNx9I6v5VwMLkqm9O4CwrJA3IiGhIknXVf7klXQ8qTK1N1rmWLMlXpZ
	 4eRBjqWR5P2dx/+repYnT6wQw3mfE+d0UHUgivXl1mno+Ai7TQ8gmqbby+DS48381H
	 7wmUsOzwkdJSS37spKUNves4ObAzEUTUDNbf6eycL/24ALZ4KFTpbZWwBxIa4OlA1N
	 lnU/ApYIhvD6OHS7iXN+utKo6avHbQBxGuYh7li2svfWyoC4/oOZHgqpfvJUu4haNj
	 Pv8CpKSBh3/Iw==
Date: Wed, 19 Jun 2024 07:36:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] net/mlx5: Lag, Remove NULL check before dev_{put, hold}
Message-ID: <20240619073618.67ac1ca9@kernel.org>
In-Reply-To: <20240619035357.45567-1-jiapeng.chong@linux.alibaba.com>
References: <20240619035357.45567-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Jun 2024 11:53:57 +0800 Jiapeng Chong wrote:
> The call netdev_{put, hold} of dev_{put, hold} will check NULL

s/of/or/

if you're touching this why not convert to netdev_hold() at the same
time?
-- 
pw-bot: au

