Return-Path: <linux-rdma+bounces-15507-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7AAD193B9
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 14:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15F49303D69E
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 13:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B692355804;
	Tue, 13 Jan 2026 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGMPDQa2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6030C255F5E
	for <linux-rdma@vger.kernel.org>; Tue, 13 Jan 2026 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768312370; cv=none; b=BDf4LOKvjGQ9cWom5vMEv7Nr+X8+5nvhrpgcQ94Ijiay+tvvLgilI1++FnTpBircs+NV5B07nZdyJ+FKVMqCduy+4W+kk2VP26d8ACZ+Zd+vtDr3zRGU5Lia0GK6pzk6MdZbjYNVjQfTVPGBuJ+I9jUhoQAHUMsZzv0ODxK5CQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768312370; c=relaxed/simple;
	bh=amD6bKmr5imZSyqsDaVSMICh6TPusyBFS2pCGFEtks0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OOebT5PsLAkaaRR47Zu0DGgoHAsVMUPFHFGXpLBsgrC0j+2/Y6GtvZlUUAsio/wOvvWQKl01XGBL/jqi9GlRjdHhC7SgL6NLhIcgrNd5bAP3YIuqSwXM68hHPaY45b8eAlrSGKVIe8D85xLAfckfsUVpw7t82KiZObbOVw3dmVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGMPDQa2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90EECC19422;
	Tue, 13 Jan 2026 13:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768312370;
	bh=amD6bKmr5imZSyqsDaVSMICh6TPusyBFS2pCGFEtks0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=EGMPDQa2dVGgP8yEJQk4CHGvqiDLxsH6vZbFCsfF3JdiYebXsLOJyeKMU2Paa649s
	 8d3uc36xVVMFn28R0UA7SyUYw30gOWBDKq57+lcF5y7MrURXyBEVpBO5+/zyBQ2kdm
	 8DtEfsm1tMitTH8B43JLJex0ytcLXPS8vHN6+pFa2xvjHe+zr5qgEjL6EDcSB09NQL
	 Gott1Eb1cfojQlrr0QjP5ok8cgHHAbHZmKvtp7bomxDa2IKKuz/WvgIOUorjWlqMkx
	 NLbE1WsHIMpSi58vwt8vlvXz5aapbnIZfZAIz5/Bhl1sk5UW666MBJfYtaLeGL6S1T
	 +I2dgpzP+bjxA==
From: Leon Romanovsky <leon@kernel.org>
To: tatyana.e.nikolova@intel.com, krzysztof.czurylo@intel.com, 
 Jacob Moroni <jmoroni@google.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org
In-Reply-To: <20260105180550.2907858-1-jmoroni@google.com>
References: <20260105180550.2907858-1-jmoroni@google.com>
Subject: Re: [PATCH rdma-next] RDMA/irdma: Remove fixed 1 ms delay during
 AH wait loop
Message-Id: <176831236571.425757.8391349966019630446.b4-ty@kernel.org>
Date: Tue, 13 Jan 2026 08:52:45 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Mon, 05 Jan 2026 18:05:50 +0000, Jacob Moroni wrote:
> The AH CQP command wait loop executes in an atomic context and was
> using a fixed 1 ms delay. Since many AH create commands can complete
> much faster than 1 ms, use poll_timeout_us_atomic with a 1 us delay.
> 
> Also, use the timeout value indicated during the capability exchange
> rather than a hard-coded value.
> 
> [...]

Applied, thanks!

[1/1] RDMA/irdma: Remove fixed 1 ms delay during AH wait loop
      https://git.kernel.org/rdma/rdma/c/5c3f795d17dc57

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


