Return-Path: <linux-rdma+bounces-12810-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE19AB2ACD9
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Aug 2025 17:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21DAC1B22B25
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Aug 2025 15:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E9525B67D;
	Mon, 18 Aug 2025 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWgCzQZs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F54325BF13;
	Mon, 18 Aug 2025 15:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755531112; cv=none; b=aV8E1imxO/bNxZaEgEQcQFVK6RkyYJe0Pm62pupPpbdSUakP4HQzGBOOXoEFx8RAMLIQIm2ZaSlPNE1/jkcS4GwrRbZmZ5ulCarF4DwVnEx+6BQYJ36jJxqo8lkoH/DLmQcmcR8Zrm/zbPr7t9+7af9FGxQ0y6+6LkJi31tqkzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755531112; c=relaxed/simple;
	bh=BwedT9hx5Lfn+vXgok0i3S4q6cuqvNa1FVkqAbi1paU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uKkTxsJSOiSDEcIA0uhnc91vOl0ilk4K/HOfcuMxihjTKtvtwdlM7ZZ5anXcJPVDmdUeIdJpO8eVqjTVYiHXZhGz8O2Sogndta+mHGfsoXEf+8yJYjk0hjPUhiMhxPhi5CPWMqBZiW6nwC+N5fHr7GjdU9O6i783VvQgEts4L6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWgCzQZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62CD7C4CEF1;
	Mon, 18 Aug 2025 15:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755531111;
	bh=BwedT9hx5Lfn+vXgok0i3S4q6cuqvNa1FVkqAbi1paU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cWgCzQZsehTYp3XVWorx3iO1H1nmaDZehzYmhM4gR3AjIIB56KjqUzAuaI6S659s/
	 npO+ouOSCRDirrszGc04a0S3+TpO7DpgcPbBAe8rygdL0Fj2/RaDMeQ/vD0hSDU/DO
	 sWTUS+/KVasnWpvR+tw2CbhSroVsjA/9NizNxiUG5o26Iz5LiEF5nA+2pJ56WRJtgs
	 bvGBAP8s+lfySqLGdbvpDWhxDuFl0mak0jiodQK3kP5uNb2U1UdMkY1NvEJTTZo/Gv
	 VPLWqngwfk+WHWTyW/9xGJKMajr1XZtOiEWIHOnnFbHYHwNC59+wD7OxcG5d6g+ZwV
	 9ih0dp97HBl4A==
Date: Mon, 18 Aug 2025 08:31:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] eth: mlx4: Fix IS_ERR() vs NULL check bug in
 mlx4_en_create_rx_ring
Message-ID: <20250818083150.6a1c05f5@kernel.org>
In-Reply-To: <20250817163830.10819-1-linmq006@gmail.com>
References: <20250805025057.3659898-1-linmq006@gmail.com>
	<20250817163830.10819-1-linmq006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Aug 2025 00:38:30 +0800 Miaoqian Lin wrote:
> Replace NULL check with IS_ERR() check after calling page_pool_create()
> since this function returns error pointers (ERR_PTR).
> Using NULL check could lead to invalid pointer dereference.

The v2 patch is white-space corrupted. The v1 was fine, so maybe try to
send it the way you send the v1?
Please do *not* try to send the new version of the patch in reply to
the thread of v1. The link to v1 you put in the changelog is enough.
-- 
pw-bot: cr

