Return-Path: <linux-rdma+bounces-13597-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F199AB96456
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 16:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFA967B7157
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 14:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB7A2E336F;
	Tue, 23 Sep 2025 14:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etH7o2xU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760B5231856;
	Tue, 23 Sep 2025 14:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637438; cv=none; b=oVold6AYmtCeqCbDYgDjVwW4/UztEgSX1TaymOLhdFKIRY/pThbRODBe48Ctws3tyc5EYDCiaxXv9mVEMFozCttUQzyvdG9k8AX98ibz0P6ZSUkewhR2fy8iWUMqlFIrzlHHF/73cACUg6lJlBP3msoZoobBBZhtGSnkVUp2UeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637438; c=relaxed/simple;
	bh=hbaGqxBJ2zgUzm2fuktyB0osZtQ6rVCDHh9Dmt0qOnk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DVQoncqs/8DkBwXb4LFvqLTCqRvue+SsyFMpgWMm/XTTwhqRqPtKSzaG4bKXw8KEj+PP0VVQTfNvJ9LciubY9j9mX99Kwr4+AmON+WTJ02bcmr7fGjjLC5vwSUj5waWD8nABqiNniLwx/YyHvvrYhH3K6UXxy2qL8yYNTqYMJhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etH7o2xU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6F6C4CEF5;
	Tue, 23 Sep 2025 14:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758637438;
	bh=hbaGqxBJ2zgUzm2fuktyB0osZtQ6rVCDHh9Dmt0qOnk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=etH7o2xUbS/S4TvCkErAOo/RFaUYd2tAwE3C7erSu+4aCBWrSim3FUvdKfee2XkTf
	 dt+2STi5sBgbcyCPn/wg9l4UTBuWS9FU4SSKwBajO2xtOfGqs+jdINYu2QFN8yd4uh
	 aIPQxjzrcCCWfl7PpGCGft2c0UCDeEqo5OcW0zjUXEO0ex27kxRSjCHGpWYHZD7Tfw
	 4Ce6+vOFMTw+tGmMBZ9/7U9mjnD0zAfUOfMf/yKu3G4AqapWeOKbLUiNOkHmK2rSnT
	 RxgwmKugmJPZ5pXySNrREvt1WnKZ6XG1RdAeqOwqOd3YaWd6MpnlzZZTyeYS03JgKt
	 33XwjMNuw610w==
Date: Tue, 23 Sep 2025 07:23:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, "Mark Bloch"
 <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos
 Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next 2/2] net/mlx5e: Clamp page_pool size to max
Message-ID: <20250923072356.7e6c234f@kernel.org>
In-Reply-To: <1758532715-820422-3-git-send-email-tariqt@nvidia.com>
References: <1758532715-820422-1-git-send-email-tariqt@nvidia.com>
	<1758532715-820422-3-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Sep 2025 12:18:35 +0300 Tariq Toukan wrote:
> When the user configures a large ring size (8K) and a large MTU (9000)
> in HW-GRO mode, the queue will fail to allocate due to the size of the
> page_pool going above the limit.

Please do some testing. A PP cache of 32k is just silly, you should
probably use a smaller limit.

