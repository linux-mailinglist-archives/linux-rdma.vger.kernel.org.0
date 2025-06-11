Return-Path: <linux-rdma+bounces-11222-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3262FAD6410
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 01:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A69E217FE0E
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Jun 2025 23:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA812D8DDA;
	Wed, 11 Jun 2025 23:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rh6rYxli"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F080A24A04D;
	Wed, 11 Jun 2025 23:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749686057; cv=none; b=Lj+IebiukqIY4HP3ggbw+9zwrZYq7bAiHOuj5cfN6leGzoBvpKMdosMS8NppdNZxPj9iYEet3QkIWIN9CQkmrDC/gxZzViFHpQ6n+UCVTusUmyQFzQIgkpmM/QZVXM5CJ19vPvzfAl0uTiq0R0+wQsJy5QGYlQZcBXh3hgqcf7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749686057; c=relaxed/simple;
	bh=26gfdBmSWheCaqCXB++m2kn/LihOibkm/qsTpeORxfA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Im5nDD5fTjVoUsvOFE6ul2O8yUMZKw9YTA7aHr98ES1kiVJJE+Ozf8RZN4MhpMRTuhHpYX5eKFxM7p/Ni8HITvBU5ZiYnOlizRNHMW9S3WPN+kNco62vlQdpg99F5jRmweEH2DrRd6xj+t6pkrOTy9r/5AX9h2UKfLPpiWqr6nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rh6rYxli; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4094C4CEE3;
	Wed, 11 Jun 2025 23:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749686056;
	bh=26gfdBmSWheCaqCXB++m2kn/LihOibkm/qsTpeORxfA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rh6rYxliD9fzaxoXSHa2EInXnh2859WCJCuJ0LBSovBptDG6/HuiMz66Q+NV0u8PX
	 iZ7sDYXGP7w1T1cjNEa8OfhvJsplsoH6AnjVEZ/5XrfGC1lWfJyA0PKPlQNafyCoFp
	 TDw6SAx5Tx+/EHnovqZBy3zEPWvfsJ6p/8ycIakZRUXzgV0bd0Uuumh9eNfuI2Ja3d
	 sjCcB/urTdfteIpcD8BZ/TzLzhFIZT5BzvDzY0W92UAuZ8pkfQ1VGd+pyjwdueLLYc
	 8thuFIOB6FFaTtAKMh1ujh1fqtkGpm0/JyU6o3z6RFqaDe2K32r9ONONULUZ63rPnN
	 Xs2/PLxwv8qwQ==
Date: Wed, 11 Jun 2025 16:54:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: donald.hunter@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, vadim.fedorenko@linux.dev,
 jiri@resnulli.us, anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, aleksandr.loktionov@intel.com, corbet@lwn.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 linux-doc@vger.kernel.org, Milena Olech <milena.olech@intel.com>, Jiri
 Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next v5 1/3] dpll: add reference-sync netlink
 attribute
Message-ID: <20250611165415.3c9ed314@kernel.org>
In-Reply-To: <20250610040436.1669826-2-arkadiusz.kubalewski@intel.com>
References: <20250610040436.1669826-1-arkadiusz.kubalewski@intel.com>
	<20250610040436.1669826-2-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 06:04:34 +0200 Arkadiusz Kubalewski wrote:
> +The device may support the Reference SYNC feature, which allows the combination
> +of two inputs into a input pair. In this configuration, clock signals
> +from both inputs are used to synchronize the dpll device. The higher frequency
                                                ^^^^
                                                DPLL ?

> +signal is utilized for the loop bandwidth of the DPLL, while the lower frequency
> +signal is used to syntonize the output signal of the DPLL device. This feature
> +enables the provision of a high-quality loop bandwidth signal from an external
> +source.

Looks like there is a conflict between this series and patches sent
by Tony the day before. You'll have to rebase.
-- 
pw-bot: cr

