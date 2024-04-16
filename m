Return-Path: <linux-rdma+bounces-1957-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 624338A68DB
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Apr 2024 12:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D873CB20E70
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Apr 2024 10:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47905127E38;
	Tue, 16 Apr 2024 10:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJHECWn7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CCF1E87F;
	Tue, 16 Apr 2024 10:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264283; cv=none; b=euqT7yZ0M0vOMewqwtkGfvj8YeDbJlOXn575pxY+scZhrbiCrP3r0Er4Lgsku8uC3rGsTHb6MEY9c8H30mhs84U6cat/kHR7D7SksXKZmulDXDcYtOMjTyVto63J/H8OlkYdb2bAniHenOVyY0b67LOzrEGmEcd0Dfwog7csyrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264283; c=relaxed/simple;
	bh=tJ9ut0fQtFbr/3MLrbRhkeYtIXO9k3OC2VNhOofqi3c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mw1a/m6AEWRajndPtvO9FLLINlUKg4RGB8xWampvb+jriaVaqkkDYnQIiiJgmuxKDieRb9pEOc7I2D2KWBZQ/k4RH+xOJzKJIl2aO1CWBPOvEeZufA17JBrs8rqRqF06g6pl7zUpW1GOxvFq4qGI0Vf9RqpXB7zFgazBfA9bWuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJHECWn7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8300C113CE;
	Tue, 16 Apr 2024 10:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713264282;
	bh=tJ9ut0fQtFbr/3MLrbRhkeYtIXO9k3OC2VNhOofqi3c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jJHECWn7lxCVHEA9KUzL5894HwD1awI4fV6JeVu00Nyx1swIwRBdzBH06MKgy9sEx
	 XUcTMut9KXoyYKV47xl6FS2qZkxcOVPft+Jb3vpff0ls50VOc4Vi68Jj0n3DAjBcjB
	 Qz1bmDKjlIZuBur2lELcxQHIhtVxe5YB1eFnIRBEhkAbPPCRUaHzvue1TPCoUFxjA/
	 DLRgy7nRcxu/uU74Vp9wHupS+F0NX+YHxBK8Ii7hdRWDjTQtfXGkxjMnuHll2ngkpC
	 zJ/Q7Ieby3VOeqaEIMs2nmX5jYCoH7U5TloDZKkIY9mqbt1hYc54a6kVRDJt+ybCai
	 bKe1h2PfbXIsQ==
From: Leon Romanovsky <leon@kernel.org>
To: kotaranov@microsoft.com, sharmaajay@microsoft.com, longli@microsoft.com, 
 jgg@ziepe.ca, Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1712911656-17352-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1712911656-17352-1-git-send-email-kotaranov@linux.microsoft.com>
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: Use num_comp_vectors of
 ib_device
Message-Id: <171326427756.736000.6328547118814689839.b4-ty@kernel.org>
Date: Tue, 16 Apr 2024 13:44:37 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev


On Fri, 12 Apr 2024 01:47:36 -0700, Konstantin Taranov wrote:
> Use num_comp_vectors of struct ib_device instead of max_num_queues
> from gdma_context.
> 
> 

Applied, thanks!

[1/1] RDMA/mana_ib: Use num_comp_vectors of ib_device
      https://git.kernel.org/rdma/rdma/c/23f59f4e837bba

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


