Return-Path: <linux-rdma+bounces-11927-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6DDAFB203
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 13:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FE823BCF0A
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 11:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E1129993D;
	Mon,  7 Jul 2025 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdNyu/G4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E7F1C4A0A;
	Mon,  7 Jul 2025 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751886606; cv=none; b=Juk+NTrrYNLXyVLtmuZ/XvmaLrzS34T4dwmwfBu2BH/AyNJI3nf8c14FSQTuPW3FV0OZSODd8OpNInTnNSJ1TVFLv+GqfeI0xxV5BbUNRXsvVjaK2FbTzu78AwGDhxhSGF1uIUIaMvmo1CQ13AZXAjvnsMDCAO0aL+6oU2ViZnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751886606; c=relaxed/simple;
	bh=6NkjZqKYniIeaQn0uWH2weXQwxs3q4a8p1oEqABtbZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mn72Sw8SJKoeOCvPCPRd4MwR/wgKW8Crs28wJ55EGOkt32otblHGIUG3JQMn+9yC1G4IOmCHOzya2O+NLQFxLgEn0OhA8BtEc9ywM3XObBwG4XhhwLlJ60Wd+7jkAu/iOTYgSLtXy1ioXDehu9QCdNQl/L42UHD8jue/Xfl83gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdNyu/G4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E30C4CEE3;
	Mon,  7 Jul 2025 11:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751886606;
	bh=6NkjZqKYniIeaQn0uWH2weXQwxs3q4a8p1oEqABtbZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pdNyu/G4BepIjMd37+SyMbb5bq3W3RoJgd0iadLJv7vW8v30uHASA97l8HtPCXQnr
	 ZO3jfnDz3j2G9/kiKD9I0xlE5ShcVBR4Cmiq69PidnwlPCBbfWHvoKLhAjenKQdrps
	 1GCFUn/anNyAqz0QikySOys+zPf9sNvh7//uqZsZBFsSzn1frxY8uu2snRY1et5HjP
	 rK2EVCI60bWdFDhX2J0ybrWNzDKeubkCmm4/6KLk95z/jv46214iSk+rkWbdiM0uHw
	 AV/MrX4Zbs6oNNKbDnFyWoLntzsIjjtKR96Vh1gCxQW3HAuT997aRTxBMpY2qFdJPm
	 HtRv5lITaHAXg==
Date: Mon, 7 Jul 2025 12:10:01 +0100
From: Simon Horman <horms@kernel.org>
To: Mark Bloch <mbloch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, saeedm@nvidia.com,
	gal@nvidia.com, leonro@nvidia.com, tariqt@nvidia.com,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Moshe Shemesh <moshe@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: Re: [PATCH net-next v3 10/10] net/mlx5: Add HWS as secondary
 steering mode
Message-ID: <20250707111001.GL89747@horms.kernel.org>
References: <20250703185431.445571-1-mbloch@nvidia.com>
 <20250703185431.445571-11-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703185431.445571-11-mbloch@nvidia.com>

On Thu, Jul 03, 2025 at 09:54:31PM +0300, Mark Bloch wrote:
> From: Moshe Shemesh <moshe@nvidia.com>
> 
> Add HW Steering (HWS) as a secondary option for device steering mode. If
> the device does not support SW Steering (SWS), HW Steering will be used
> as the default, provided it is supported. FW Steering will now be
> selected as the default only if both HWS and SWS are unavailable.
> 
> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


