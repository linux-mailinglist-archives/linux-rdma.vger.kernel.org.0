Return-Path: <linux-rdma+bounces-7902-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD004A3E3CE
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 19:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55336421166
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 18:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4DD21504A;
	Thu, 20 Feb 2025 18:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaCTGeyk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2492214A6D;
	Thu, 20 Feb 2025 18:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740076020; cv=none; b=sUNWPk1fKWcpAANlE6iSIRQ9RjuoXZHm0xvXDFIDLO17zyp9HuAaRuL2YVjtvQUxCTFAOkMxR/YfLGY+Z1m9+QcSfxz3SvJO/gGT91uLOUKOhiThHGHSt7Xem/lieP+y3yvp3NtxPVN4KMIZN72rnTlhIjuRMG2kMNjXk1tLI7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740076020; c=relaxed/simple;
	bh=MDpUN+ILUkf6q7MIgyqLffmjcwXooDNec6CFvbQctEk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L+Xmh33WfPw5HJS5su5gxlH70Ik0fKfOsaMskzUt4Y8Go5E7wgKNNwfp4Lg+LPiEwnBrFqXJPXA3c6D9VzAxmUm5grUUS86mubsOEZUVBhpbgOo0lSFQ6x58eDBaHh5uTU5yYFt1dp3LSLBI/l266pNvEZWJPMFh6BiajHwI5hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaCTGeyk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C3BC4CED1;
	Thu, 20 Feb 2025 18:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740076020;
	bh=MDpUN+ILUkf6q7MIgyqLffmjcwXooDNec6CFvbQctEk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IaCTGeykfKSdNOKF9xNut9D6u10fPZUMRvm6woFNSpreycJaZtXLjWtt8qtdaoXVO
	 0CifusNXWDdYUeeKbiC2Xvu6bVJEP9IBHQsZJ8yMyaLgCtbZ0KDdoGaNiacmRY/Ukg
	 sIr7KkKfpx0ZF6nS1GivPadWf+1guHlWqzwRIEJyJ412hDhH/20KKRJL5pRqguPLqQ
	 UfSHWL2n6lNtb6sfHfz021Td6GaVF4U1jQEMc3gEMQKhAY4LXJlGTW9cgaWc7cBHTG
	 rOPCYQdwrgFsCnuMVPrXC4ta8r4txy51Z785W1OyWzr0H64BNJjzpxx4t8XaddwCKk
	 IRIWCz1NtpvZg==
Date: Thu, 20 Feb 2025 10:26:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
 <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] net/mlx5e: Avoid a hundred
 -Wflex-array-member-not-at-end warnings
Message-ID: <20250220102658.39df9b36@kernel.org>
In-Reply-To: <4e556977-c7b9-4d37-b874-4f3d60d54429@embeddedor.com>
References: <Z6GCJY8G9EzASrwQ@kspp>
	<4e556977-c7b9-4d37-b874-4f3d60d54429@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Feb 2025 15:07:07 +1030 Gustavo A. R. Silva wrote:> 
> Here is another alternative for this.  And similarly to the struct_group_tagged()
> change above, no struct members should be added before or after `struct
> mlx5e_umr_wqe_hdr hdr;` in `struct mlx5e_umr_wqe`:

Gustavo, could you submit this officially?

