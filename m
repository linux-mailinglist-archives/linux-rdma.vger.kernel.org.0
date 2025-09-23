Return-Path: <linux-rdma+bounces-13582-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A55B93A9E
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 02:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29B73BFBA1
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 00:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A60B1CAA4;
	Tue, 23 Sep 2025 00:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ja8uqtR7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35907BE5E;
	Tue, 23 Sep 2025 00:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758586004; cv=none; b=hGGDq8Crhs0UjKVg9AwDl9Xv8sS2PHpcIlNA0200PoM8EbxFfCVQeKsECrEN7bJ9FT71Zd9OL7IXmgtkaTsRLS+2qgmyGNTD0h79pz5lo+K5gF0Du8LNz9LVxbPRA1eub8sG1kev8EPT/cXL+7BJYxHQ9yBd7v8N2CYc3wlxX4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758586004; c=relaxed/simple;
	bh=9EZM2bQ1+x+9RpmEnYsLQfLA1yzHuL/f+/Q6zAHJuME=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iuyJJPcH/bX4jSZbs/dBB04QLxxRepUeUi0uWxDgxJlbKIBHGj/YAQmZs04V9ONTsa+90cg3G8bekN7pgG2iEb/6ZaH91LwESusivP5XV3tA3XQFjuJBIlWE5gFQBsZaa8UawD4kuxHBwXN1gpE8RIrlT1Go+8DEBrq58f5sdco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ja8uqtR7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D49C4CEF0;
	Tue, 23 Sep 2025 00:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758586003;
	bh=9EZM2bQ1+x+9RpmEnYsLQfLA1yzHuL/f+/Q6zAHJuME=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ja8uqtR7yoLtRy4qlBt58qGUBIrQ4d7Z3MJbvrg+oigryoxB3DyWzqTMj8dQom0JD
	 NMpNT6QMHOz2eFMGWvUDLeybUqlz4WTqRQ5/NZiwH+WqHu3zL5Vvb4L4cI3Ia5R+Ow
	 le6xDqbiz2sNIgD7HyOCVpQMAgH/OwUhMYIhZVr7DIz/uXuMkfcwFx9tiSwyyszk7P
	 6mR5oB/cOh230fN6eLggCxsfSD0CPl4pL2X6B9rfakowFbHJIRKwwa6xBmNZFziIXP
	 ZGZ16+CWJjkjOqhO1FI9MMPduPGF5CtxeUSGr/HUcKaQl8uHDectYqNQBZBn/Mt5AU
	 Wd3HrJmHp4m6g==
Date: Mon, 22 Sep 2025 17:06:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe
 Shemesh <moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [PATCH net-next 3/7] net/mlx5: Improve QoS error messages with
 actual depth values
Message-ID: <20250922170642.2d79e14b@kernel.org>
In-Reply-To: <1758531671-819655-4-git-send-email-tariqt@nvidia.com>
References: <1758531671-819655-1-git-send-email-tariqt@nvidia.com>
	<1758531671-819655-4-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Sep 2025 12:01:07 +0300 Tariq Toukan wrote:
>  		if (new_level > max_level) {
> -			NL_SET_ERR_MSG_MOD(extack,
> -					   "TC arbitration on leafs is not supported beyond max scheduling depth");
> +			NL_SET_ERR_MSG_FMT_MOD(extack,
> +					       "TC arbitration on leafs is not supported beyond max scheduling depth %d",
> +					       max_level);

clang points out that these messages are too long to fit in extack
-- 
pw-bot: cr

