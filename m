Return-Path: <linux-rdma+bounces-5603-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB939B589C
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Oct 2024 01:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A181F215FE
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Oct 2024 00:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885BB171CD;
	Wed, 30 Oct 2024 00:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZ3W39tZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4E311CAF;
	Wed, 30 Oct 2024 00:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730248162; cv=none; b=CybzGzjiHBTLbXBDTpMEamzgK922tlzG+AHZ6KzchLO6KEvUOCvaKFGr23TGG7NX9ggJhdzhz4w3dKonD8USVG3fI/6pSQsuTU9Ocklh93ewzX3JeVsdmyy6yMju6EJk284/4cCsKT4wpFWShh0bx3XROedPOCqLZG9YuL9FUhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730248162; c=relaxed/simple;
	bh=1pq/pDL/Y5H4W0YB257TIBJQI2fBtFz8VjZsvNmGvNk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WfMXEzecPpQnKImma3jLs6ceu3s0P/zr4osL48qAHKvqu1yXsikZhtm7h/YhpmgeWS/vz6pHw/W7BNVEEyLcGedvvs6ttyTPuQP2o5DpP5T0g8raqM3/e3eq1Ndt88VnqZN+fXAtNgp7A7uHXBQ/KNO8XKcd3P8jxs0xVoc6Oc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZ3W39tZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0DDC4CEE3;
	Wed, 30 Oct 2024 00:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730248162;
	bh=1pq/pDL/Y5H4W0YB257TIBJQI2fBtFz8VjZsvNmGvNk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bZ3W39tZViMdn/Nwn5Stpkgu235jsEKj6+KJv0jqX2e7Go6bkxM2RJIAvJYL3NK2P
	 FwuU/W+Opt6iuyH/HIivOwVi5dN8rFZp6x2o+lpI+aPY2/QMaDkrz5V6aVipI8NKkV
	 qnnVj7dvucq23Kdd+mpPh3nKFQFdlee00ZYc/0Wj1MPeMV+gQNyyQ/83TrvBLqRCNi
	 6pbBUvcTTAmILsQw+X44VemMUtgaHhROMQsHzmCOIEaoH+UF/4EGaaXPZ/lEzqtQO/
	 qOf66AZRteSWPAnmrKVvsSzPVLw2NkXnES/aUIIv2mZVNgv3/jYaPiOLvBvv9x4LIG
	 xV6UbHZOBmiow==
Date: Tue, 29 Oct 2024 17:29:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mlx5: simplify EQ interrupt polling logic
Message-ID: <20241029172920.21cee16a@kernel.org>
In-Reply-To: <20241023205113.255866-1-csander@purestorage.com>
References: <20241023205113.255866-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Oct 2024 14:51:12 -0600 Caleb Sander Mateos wrote:
> Use a while loop in mlx5_eq_comp_int() and mlx5_eq_async_int() to
> clarify the EQE polling logic. This consolidates the next_eqe_sw() calls
> for the first and subequent iterations. It also avoids a goto. Turn the
> num_eqes < MLX5_EQ_POLLING_BUDGET check into a break condition.

Applied, thanks!

