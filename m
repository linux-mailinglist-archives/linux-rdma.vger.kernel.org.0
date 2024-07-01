Return-Path: <linux-rdma+bounces-3582-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C98E291DE3D
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 13:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 076001C219B8
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 11:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F20143745;
	Mon,  1 Jul 2024 11:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRw2IfHm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AAE1422CE
	for <linux-rdma@vger.kernel.org>; Mon,  1 Jul 2024 11:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719834071; cv=none; b=pRAZk4UqI9JpvI1FcXCLBJoEkBR0m2xG+ZvWcvkHw7whWoJkzXi+s/Lu0i3tVzb3ce1td/QY7Yt8NvTaU4B2BFv3PdFbjS+qR09y0gF9y/6ah5DDGIl5iJyBIzD/0VsKgkGL2BpiRzuEbvPhrEMReKNQz744SjVXePPp7l/MHeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719834071; c=relaxed/simple;
	bh=rnmS8LbL1/uwiFNNLmdtTkjoYXORE3Mc6bLwemgMYs4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZTptV5l1+3BHiyF4nJPVWPfjUC9m1Y1H7k4TKJ5D4p509lu/KcB1qy5hsR5HSLkvhuuE1DG9ynO2FPfE1uGvcbruATsoaZa6VefQxV6u6sc71q+jOfdVPeZejMrxd3eUAhOP15n0up0u4hvattAiwgOastRSTt0gww1mVdU2mHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRw2IfHm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DFD4C116B1;
	Mon,  1 Jul 2024 11:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719834070;
	bh=rnmS8LbL1/uwiFNNLmdtTkjoYXORE3Mc6bLwemgMYs4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NRw2IfHmHFO5CUwrO2lrtiQCHxmqIG/ruvlyWLxaztMI4eBteJnCX7C9gGxM6azJ7
	 6izrwo4C801jjSTu3DWSfjHe6esuMPvJCY5samBykhOxDAIZkh5VuZsQdGxu2g2JTS
	 919gJFLEcYt3V9VZj4VnxVDXjCEVBA7I/00jIc14ml8zxdCpRz9uaPmPbGNyNKV6jM
	 wmQkbbk+4Y6RxPpVNjuwOuLCkOqVRpDUr7PMe1eUSubHpEcfk8mwouD8vaScz4zRRb
	 FvcK9dU1SFqPQ8MLnZe6D3wM1+QnKp1I+UCjbYJIuMAA9DQb2cJ27vdye9p1hNdc80
	 Fz1bsS+HpnpNg==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Selvin Xavier <selvin.xavier@broadcom.com>
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com
In-Reply-To: <1719456065-27394-1-git-send-email-selvin.xavier@broadcom.com>
References: <1719456065-27394-1-git-send-email-selvin.xavier@broadcom.com>
Subject: Re: [PATCH for-next 0/3] RDMA/bnxt_re: DB moderation on GenP7
Message-Id: <171983406693.320332.17045307921376743601.b4-ty@kernel.org>
Date: Mon, 01 Jul 2024 14:41:06 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-13183


On Wed, 26 Jun 2024 19:41:02 -0700, Selvin Xavier wrote:
> The series enables DB moderation support for latest adapters. Query
> the FIFO information from the FW to use based on the adapter revision
> before initializing this feature.
> 
> Please review and apply.
> 
> Thanks,
> Selvin
> 
> [...]

Applied, thanks!

[1/3] RDMA/bnxt_re: Update the correct DB FIFO depth and mask for GenP7
      https://git.kernel.org/rdma/rdma/c/8e6e5ac7c468cf
[2/3] RDMA/bnxt_re: Enable DB moderation for genP7 adapters
      https://git.kernel.org/rdma/rdma/c/f2f4dc9124019d
[3/3] RDMA/bnxt_re: Disable doorbell moderation if hardware register read fails
      https://git.kernel.org/rdma/rdma/c/24943dcdc156cf

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


