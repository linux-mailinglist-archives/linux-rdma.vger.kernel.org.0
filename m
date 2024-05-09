Return-Path: <linux-rdma+bounces-2358-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA998C08B1
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 02:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B041B1C2119F
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 00:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117953D963;
	Thu,  9 May 2024 00:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQuOSUjU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9896199B9;
	Thu,  9 May 2024 00:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715216199; cv=none; b=O19QzWgbkGx8j+obPx3Z1C6QwXpj3w+Cyt+HPTLLrKxiUQ35y92aWe4rlGyMFIZHZ3Df127FFpje7JLGLcO+43dAbc+Pqvgpm3YFxh2NbaXjz0hT3CnV9eXZM8yhQ6tzQOZpeddTBRXPj5VC3tzKDiDum30/TpmZ9NMx5/EnTWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715216199; c=relaxed/simple;
	bh=Rw11crbnuQ6fU3EEzrTuH2bfFNBuwuRmqc1xYSAsUAg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W4y8jLN+zrKbH450+R/avG+gfXicYUES6ExriLbfc6p7Vh16RTYyk26iiIcUpItRkGhjY/+4NBrnCrbRTUVXdoYdwcjv5QO9+9GgwcE6cBAhtOTP1fVuWWiwtjBjlMb86+k3wONfOyhdZaUosn40bRQ5FHD7svL09IQ+aqvK/2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQuOSUjU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C3AC113CC;
	Thu,  9 May 2024 00:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715216199;
	bh=Rw11crbnuQ6fU3EEzrTuH2bfFNBuwuRmqc1xYSAsUAg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BQuOSUjUgz03tQE/6+Ukix4akBBd1J0kU7yO4iOr20hDZv7f+8kAkVhH0OxkGWgD9
	 zjJhpWgwk9exov4OC8uwQS6UijUWPRpknDLuh/PtSlxjyIlgyov78ZAzIUEyL2F5iW
	 jhFe6F05mDiIURchpmP0IXFFjgCOuhA5ITiz5TVlb3P86qZ9bU5SY1AT0J+ne1w6/m
	 Q7q4ftB4jAbkQ3o2SA45gJMEXOv8w6gBv5yyjQmcDNG3P73re5V0tM4c39yLjvrspX
	 RZx39sXMwKkvrR7GcPnieE5P3BOZE4Os08aS7ivCMsZvaQrQKNYSIJ/XCKPGu2nJHI
	 lrDrAxiGxDHXg==
Date: Wed, 8 May 2024 17:56:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>, Zhu Yanjun
 <zyjzyj2000@gmail.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, saeedm@nvidia.com, gal@nvidia.com,
 nalramli@fastly.com, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Leon Romanovsky <leon@kernel.org>, "open
 list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net-next 0/1] mlx5: Add netdev-genl queue stats
Message-ID: <20240508175638.7b391b7b@kernel.org>
In-Reply-To: <ZjwJmKa6orPm9NHF@LQ3V64L9R2>
References: <20240503022549.49852-1-jdamato@fastly.com>
	<c3f4f1a4-303d-4d57-ae83-ed52e5a08f69@linux.dev>
	<ZjUwT_1SA9tF952c@LQ3V64L9R2>
	<20240503145808.4872fbb2@kernel.org>
	<ZjV5BG8JFGRBoKaz@LQ3V64L9R2>
	<20240503173429.10402325@kernel.org>
	<ZjkbpLRyZ9h0U01_@LQ3V64L9R2>
	<8678e62c-f33b-469c-ac6c-68a060273754@gmail.com>
	<ZjwJmKa6orPm9NHF@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 May 2024 16:24:08 -0700 Joe Damato wrote:
> > A possible reason for this difference is the queues included in the sum.
> > Our stats are persistent across configuration changes, so they doesn't reset
> > when number of channels changes for example.
> > 
> > We keep stats entries for al ring indices that ever existed. Our driver
> > loops and sums up the stats for all of them, while the stack loops only up
> > to the current netdev->real_num_rx_queues.
> > 
> > Can this explain the diff here?  
> 
> Yes, that was it. Sorry I didn't realize this case. My lab machine runs a
> script to adjust the queue count shortly after booting.
> 
> I disabled that and re-ran:
> 
>   NETIF=eth0 tools/testing/selftests/drivers/net/stats.py
> 
> and all tests pass.

Stating the obvious, perhaps, but in this case we should add the stats
from inactive queues to the base (which when the NIC is down means all
queues).

