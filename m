Return-Path: <linux-rdma+bounces-3858-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CD99308EB
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jul 2024 09:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C291F281ED1
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jul 2024 07:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002A71758D;
	Sun, 14 Jul 2024 07:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7BWa5he"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95BB10958;
	Sun, 14 Jul 2024 07:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720943412; cv=none; b=VC9jgMHODT7DhRwxuGa899liGaS+cE9gUSU3DN/P6l/HW5BWqXFJ6BAStAwDMQ+NnG3brUQyxrLnGlO3EqpP3sEXF/hHRCHhzJT2oUVDFwqFwYnder3WVdia7TUSRdWQc6MYJKipqhowHBb186YjqzMKPwiJ6XR6K5CbZU+rmKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720943412; c=relaxed/simple;
	bh=MQSzyGFevqjq2PCHO0abOcJvVZs6qhNS8Fj3CiCcRV8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O4gR8lTH+UCwzdgTxXPECOGdBREeiZITuV7PKH4ld8OrkfTDhdstIE3hszc3kbB9g/jAI2YCB6eRjgEz1v5SIkmzzs3ncEoCY5nEncqp22uDPasUCcR52IAEICKY/dzuLXj7BOV6y94BIF1Mmc6iENeloFHpUwFzkRSYjSozSDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7BWa5he; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72412C116B1;
	Sun, 14 Jul 2024 07:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720943412;
	bh=MQSzyGFevqjq2PCHO0abOcJvVZs6qhNS8Fj3CiCcRV8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=W7BWa5heDGdoER1uEw/oUvVfyPulRKzKJ78r8oUqhDjH8FXwqgmdTqn3FB690BINI
	 z1z/U1kelxtILRoNNcW8eVtydQPBd7NYoUs8xMztqVU4woNE1dFF6P2GX3oZvoaWtD
	 Cn4c47VlMOGThoA/JIflw8Vkx9pOtH/z7WcUDfTTBUELPM1NEzdtw2tO57GEY6zhpz
	 z5ihiyx0sEdMNqDH97S4vkRpo6aBkLbvmjKfBmP3DEu8LbHpWyJ3r0db4vTKwNE3UH
	 22/QJadA85apccdtzwqd2MMwtiTb0d9AwQWocDpmj91go1WGiFeJAvV4yMC1SRXlKZ
	 7B9LoeuDd90Fw==
From: Leon Romanovsky <leon@kernel.org>
To: kotaranov@microsoft.com, pabeni@redhat.com, haiyangz@microsoft.com, 
 kys@microsoft.com, edumazet@google.com, kuba@kernel.org, 
 davem@davemloft.net, decui@microsoft.com, wei.liu@kernel.org, 
 sharmaajay@microsoft.com, longli@microsoft.com, jgg@ziepe.ca, 
 Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org
In-Reply-To: <1720705077-322-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1720705077-322-1-git-send-email-kotaranov@linux.microsoft.com>
Subject: Re: [PATCH rdma-next v3 1/1] RDMA/mana_ib: Set correct device into
 ib
Message-Id: <172094340802.10365.12136288683961207968.b4-ty@kernel.org>
Date: Sun, 14 Jul 2024 10:50:08 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-13183


On Thu, 11 Jul 2024 06:37:57 -0700, Konstantin Taranov wrote:
> Add mana_get_primary_netdev_rcu helper to get a primary
> netdevice for a given port. When mana is used with
> netvsc, the VF netdev is controlled by an upper netvsc
> device. In a baremetal case, the VF netdev is the
> primary device.
> 
> Use the mana_get_primary_netdev_rcu() helper in the mana_ib
> to get the correct device for querying network states.
> 
> [...]

Applied, thanks!

[1/1] RDMA/mana_ib: Set correct device into ib
      https://git.kernel.org/rdma/rdma/c/1df03a4b44146c

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


