Return-Path: <linux-rdma+bounces-6650-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1119F7AB7
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 12:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74608161ED0
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 11:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2547022370D;
	Thu, 19 Dec 2024 11:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYyZzCtM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01BB22256E;
	Thu, 19 Dec 2024 11:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734609156; cv=none; b=BA2TbaVrwyuMWkbG2VRZanNZY11aqUf6dpQ9kWhQhNdijKdM6FxC7VrLE0D4mLjB7n+2ipIaVfZ/xlEdXDrCrIF6m9J3RruFT2TOBuhW+VwtzB9umUsmedclsmHhKTURgMWzgtKQRhSzo/RQd2voNC8dUudQMUm/gOCozGv4GNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734609156; c=relaxed/simple;
	bh=sTD4PsBLwOO1dGxws9V3qLk47riPghcxmGJALvc/YZM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sUA7FrPyatDiwb12EV8oplVCM3QHxYfxWGXWfhKnL0dVrC1nskvAikRdhSnr1/C5KHrygN5ZEyCYvSjvsSy0kWF/USZH6KIBlvXbA2xh50u0EFcAo3ggacRuoPwTfC9eo8z0lLRhOONs3K4xdEZr9EXuc0foV0O8f1ozWfz0Pjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYyZzCtM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29ADC4CED0;
	Thu, 19 Dec 2024 11:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734609156;
	bh=sTD4PsBLwOO1dGxws9V3qLk47riPghcxmGJALvc/YZM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RYyZzCtMkKjOEY+BsyABrv7D8CaLRUt8+nEj72Y+N6x2HiZlecfJDp7FYmJf7jhMO
	 WLdmcO7VXeDBawYP8BQouHoq3wEqfPXz4yKSpQ2piJ4Umr2WAlp8tmZWSd1z6E2Hwa
	 NjYMz3jwRBV2IxHFCxW+zPw8UDUcRbt6v58/PBeLK3ImhyutfDE/WGqihVPP6ye1SE
	 O4rh3I8khNuTrcaeD/AoWa6ginDsIW0CTeGZPBrmi/SQsPnDgoQg1U1tccu9R5JQ8R
	 NkWTHiQbfcreo+QCvzMAr3gFKOBP9l1+O/cPqiUR752csEGM1pLmNFjSBzmDrZBM6u
	 I2SxbeThd4YIQ==
From: Leon Romanovsky <leon@kernel.org>
To: bvanassche@acm.org, jgg@ziepe.ca, Ma Ke <make_ruc2021@163.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20241217075538.2909996-1-make_ruc2021@163.com>
References: <20241217075538.2909996-1-make_ruc2021@163.com>
Subject: Re: [PATCH] RDMA/srp: Fix error handling in srp_add_port
Message-Id: <173460915277.348463.15529824823119564908.b4-ty@kernel.org>
Date: Thu, 19 Dec 2024 06:52:32 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 17 Dec 2024 15:55:38 +0800, Ma Ke wrote:
> The reference count of the device incremented in device_initialize() is
> not decremented when device_add() fails. Add a put_device() call before
> returning from the function to decrement reference count for cleanup.
> Or it could cause memory leak.
> 
> As comment of device_add() says, if device_add() succeeds, you should
> call device_del() when you want to get rid of it. If device_add() has
> not succeeded, use only put_device() to drop the reference count.
> 
> [...]

Applied, thanks!

[1/1] RDMA/srp: Fix error handling in srp_add_port
      https://git.kernel.org/rdma/rdma/c/a3cbf68c696111

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


