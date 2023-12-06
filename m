Return-Path: <linux-rdma+bounces-293-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A930807B69
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Dec 2023 23:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F4211F21949
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Dec 2023 22:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF1770997;
	Wed,  6 Dec 2023 22:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qW35m9mQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23E847F7C;
	Wed,  6 Dec 2023 22:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04672C433C7;
	Wed,  6 Dec 2023 22:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701902244;
	bh=SpHMtoBxIkmYrYXlggD/bi1zaqbK4AdCKk/C2BprrYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qW35m9mQvl/FxtFLb4vNeX3KAGURfIyLQFALthVHe3pChiNyjfjfmZezgHouAPoDA
	 K2FLC+/OwqfM2goIgGuqWuXvu22A9VkKt1B3ZxsgDvo/SOww1F6vOF9UuBTYizK+Vu
	 PKV8PqhoJ6SWA5jjs1xYc5nEyhwaZJvBndUVCYC4LrDs2g1oaMs5EPpBCE33e56Wgi
	 j0wPZE4Se3xhKOPPFgLJW15egZLwnEJZWelNxeC9z4FTIM1ymwrOaUWtros2tsy2Wx
	 9DBtKtBX6KcycNiL+sSWGBoP224WPg38w8PR7o+eZLH+QKLt2i+gJWaDLw0QT70Zn5
	 +KFjh9f68sy2Q==
Date: Wed, 6 Dec 2023 14:37:22 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: saeedm@nvidia.com, leon@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] net/mlx5: DR, Use swap() instead of open coding it
Message-ID: <ZXD3orTxU0mxi5jH@x130>
References: <20231117071947.112856-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231117071947.112856-1-jiapeng.chong@linux.alibaba.com>

On 17 Nov 15:19, Jiapeng Chong wrote:
>Swap is a function interface that provides exchange function. To avoid
>code duplication, we can use swap function.
>
>./drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c:1254:50-51: WARNING opportunity for swap().
>
>Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7580
>Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
>---

applied to net-next-mlx5
-Saeed.

