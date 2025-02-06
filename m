Return-Path: <linux-rdma+bounces-7476-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A019FA2A36A
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Feb 2025 09:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C576161E7E
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Feb 2025 08:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D4422577D;
	Thu,  6 Feb 2025 08:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBsEy3GG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64972225419;
	Thu,  6 Feb 2025 08:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738831320; cv=none; b=k5T+YqxEbHBvIplQ7ZbpMzOY22uZkE6tx9fa/J4g4yY1TstmcVZ0HcC5xHLTE0YeaoS9apTmltN3iUnSPpEXxFS9lowdf1xVSPQpFJTTAvDYa7j9Cy+43hhsR5DL+8w4UkK/6Y8yoQqrTadFX3dyhozNcB1442Zx9mgPthFs4FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738831320; c=relaxed/simple;
	bh=RiJBfUsw7mp20XJjiZnxl3Q/Njadoq6t+e8HhaT6gOc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NfhuXa8z2xmQOmvOETDjW6L9V5bcPOF7hP7jltyln5GWug/qTwuYBh8LpaHbY+VpdcukQIetrxl/cJO0abmrwagT7i3zgHbtIt/rUQSk4eYxdjjevxsSJurignxOgI6ex4wLst7qREgZuB+LChKgi0DdzcoA3UIZtF+x3Mfn4XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBsEy3GG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB37EC4CEDD;
	Thu,  6 Feb 2025 08:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738831319;
	bh=RiJBfUsw7mp20XJjiZnxl3Q/Njadoq6t+e8HhaT6gOc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dBsEy3GGhbSBMYQEryBrXOa0Eee9rv6RrJkUqnJLcyLU1O5Ulmd9K73WWD4SCUwK3
	 IyCfDMcXtoPsnUp75jNX4rzz3+UOD6Qfca1enzcTHJh9chWNtIBuvYjm7UmTepDr8W
	 aAaBGNYEBko8OFAOUbu2jrQ/a7it0hSKXsXseqx67QArR+Kwusnjw+WowSkWo9DQji
	 nAkYcBN4v7boYj9K6qsKSQYQ6/B8x42SnkXpHGlCrq0MvIsDYVWIjkBwUsgb7Jm0bN
	 Um022lgCruX5mnlvvZBTyzqAHGW/gagdTwl9vBXjUA9jH9yPNIXPnBvWAkvH2cGTH2
	 yBt0NJMn68bCQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 Maher Sanalla <msanalla@nvidia.com>
In-Reply-To: <cover.1738586601.git.leon@kernel.org>
References: <cover.1738586601.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next v1 0/3] Print link status when it is changed
Message-Id: <173883131613.836691.6835376998242287770.b4-ty@kernel.org>
Date: Thu, 06 Feb 2025 03:41:56 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 03 Feb 2025 14:48:03 +0200, Leon Romanovsky wrote:
> Changelog:
> v1:
>  * Changed print to include port number
>  * Don't print anything on change state from NOP
> v0: https://lore.kernel.org/all/cover.1737290406.git.leon@kernel.org
> -----------------------------------------------------------------------
> 
> [...]

Applied, thanks!

[1/3] IB/cache: Add log messages for IB device state changes
      https://git.kernel.org/rdma/rdma/c/5459f6523c1f1a
[2/3] RDMA/core: Use ib_port_state_to_str() for IB state sysfs
      https://git.kernel.org/rdma/rdma/c/1fd119c6db838d
[3/3] IB/hfi1: Remove state transition log message and opa_lstate_name()
      https://git.kernel.org/rdma/rdma/c/d9d9434a3fee5c

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


