Return-Path: <linux-rdma+bounces-3821-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA2692E4B1
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 12:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38D78B224D1
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 10:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CAE158DC4;
	Thu, 11 Jul 2024 10:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3fdyKOB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D8015957E
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jul 2024 10:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720693700; cv=none; b=nr9/HUhA06tX7KyxTSa6lnJ8FI6ErWQm54dn5OmV5aiUYQIqFxlwmpjimOsIFiCCus+4kRTZJEsYngs2E4Hsmms8wHXup2iyyO7Ttx0bQvNGqgdlDSHUgC1V2uIpKRDIytJLrE0hEFOH4GTzUSo9FhbU4Khk/gXZedSjyiSuKLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720693700; c=relaxed/simple;
	bh=f7k4H7BzExTVjF+IQoJpjl4abq/93f0orBwFSy+Wmw8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=a/KdfGV0GY7TAJ1suCooMXEfY6MyD/7HNA0/pvLMKh5/BIDEHWQt7oYVDczWwO5+1SPh0i9hOQdBWTqD2VMoxdqBDJcxdMVytar4ZIFNnXeRSfTTcYodr6w5agkLloiw6xgHvON5yFb39EAH9aNkvCH5WSrfHEdfw/FMeEYj91c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3fdyKOB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34B1C116B1;
	Thu, 11 Jul 2024 10:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720693700;
	bh=f7k4H7BzExTVjF+IQoJpjl4abq/93f0orBwFSy+Wmw8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=M3fdyKOBgPWicPGhZV9ncOhw5UzXwwEf3orWQ5HUbkDvpkVMoQjUlxwFTtB8ktmi7
	 Y4ArfPx++zDgnkSH5Pdroo0QyR14ZG66RgZ/1xpFpQSeE9xBSN8eMI+DWSt89P1V/C
	 xSpBrIYkJFQXhAnr8/qWNn+v+PQYU2/4kMwFatDPISWyRs7yRXHgFiuZijP2SZ8KiJ
	 YWZwdtpKHVQXPuE8vflWrq8rUgR5jqhQtB59/UaO/yC5ThBdL7aYSfNLxsUeUL+mjT
	 3UZ6+D0haqQ4vBwsSKrJ7Fw5pGerYC1Nn0aF1wGdSW4vs7qC7epFnzrli/JvgUPt/s
	 vWNwx/XfrG3IA==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Jack Wang <jinpu.wang@ionos.com>
Cc: selvin.xavier@broadcom.com, jgg@ziepe.ca, haris.iqbal@ionos.com
In-Reply-To: <20240710122102.37569-1-jinpu.wang@ionos.com>
References: <20240710122102.37569-1-jinpu.wang@ionos.com>
Subject: Re: [PATCHv2] bnxt_re: Fix imm_data endianness
Message-Id: <172069369656.1730644.1627828094830356512.b4-ty@kernel.org>
Date: Thu, 11 Jul 2024 13:28:16 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-13183


On Wed, 10 Jul 2024 14:21:02 +0200, Jack Wang wrote:
> When map a device between servers with MLX and BCM RoCE nics, RTRS
> server complain about unknown imm type, and can't map the device,
> 
> After more debug, it seems bnxt_re wrongly handle the
> imm_data, this patch fixed the compat issue with MLX for us.
> 
> In off list discussion, Selvin confirm HW is working in little endian format
> and all data needs to be converted to LE while providing.
> 
> [...]

Applied, thanks!

[1/1] bnxt_re: Fix imm_data endianness
      https://git.kernel.org/rdma/rdma/c/dae3cbdcde7062

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


