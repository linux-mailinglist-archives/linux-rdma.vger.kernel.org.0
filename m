Return-Path: <linux-rdma+bounces-13475-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9A2B83CE5
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 11:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC1B4835D0
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 09:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DE9227B83;
	Thu, 18 Sep 2025 09:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvqix58x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0853E28F1;
	Thu, 18 Sep 2025 09:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187961; cv=none; b=ItbypTMB7J3rO6qAWaUlJeST0x/cmXKIGQK6Gj4BpprvR6oQz0XqdezMbWsV0rU38ibPs0AFWP/DFDTj5EcO22CEIqg2URQes18dZQoLlCJJUc9twgW/TofGmVDfcEqVkoEKlfSpF5ctu+IOMfJxd3G2E3B9JuoeDcR91qRUTDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187961; c=relaxed/simple;
	bh=1e3t9p71KVL74Ux/URLsHxgOMlqcMojhPLPMQA0v01Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JWPD3joHgjOfwrk+uyABeLUK7C8kzuNRkogLNUhK/+FSA4ca88ZCZBqzgSREJhuZN1hHFcTLJk3PGCFpI03gl4CeeZmzKChSuMD02GVA2AqOUogK4nMpR0lwAqFO9LZJ6uYWPOU7iwWg012cK+cPl+HiiJDbZ7a4ZE8KiWf4wuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvqix58x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31152C4CEE7;
	Thu, 18 Sep 2025 09:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758187960;
	bh=1e3t9p71KVL74Ux/URLsHxgOMlqcMojhPLPMQA0v01Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cvqix58xM5PG6q1racvxs+87hpHLItPbKlmUZwMFPbaXs1laOqjcpQndDnfjpBdAS
	 AUSZNz4Amtkd5/VP9niq3ITDyevtdrcPtcL6rChUhDe/rFJJXG9kesXr/StKV0zri0
	 2qKK6+vC3YIFXpnfZ3JSsF0dwwckJCsE53MPZ6MViLVaJRwT4HVTzNMtpE2UbTSExc
	 9VLKZS+GgEoXRb7lkQYDwXOyv/rsrgFO0VWaEwn7KQL+eEN9HKRj+siR6LvuJ/fouH
	 xbh2dXFBVdLKkbbUm94TyjAU7Vt5LinD3H3g4inhwedJudsR7xkrSxfyXEG9WPiIAS
	 O8rxQF46DXUEQ==
From: Leon Romanovsky <leon@kernel.org>
To: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Mark Bloch <mbloch@nvidia.com>, 
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, 
 Akiva Goldberger <agoldberger@nvidia.com>
In-Reply-To: <1758115678-643464-1-git-send-email-tariqt@nvidia.com>
References: <1758115678-643464-1-git-send-email-tariqt@nvidia.com>
Subject: Re: [PATCH mlx5-next] net/mlx5: Add uar access and odp page fault
 counters
Message-Id: <175818795753.1954650.17735055248478987450.b4-ty@kernel.org>
Date: Thu, 18 Sep 2025 05:32:37 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Wed, 17 Sep 2025 16:27:58 +0300, Tariq Toukan wrote:
> Add bar_uar_access, odp_local_triggered_page_fault, and
> odp_remote_triggered_page_fault counters to the query_vnic_env command.
> Additionally, add corresponding capabilities bits to the HCA CAP.
> 
> 

Applied, thanks!

[1/1] net/mlx5: Add uar access and odp page fault counters
      https://git.kernel.org/rdma/rdma/c/a3d076b0567e72

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


