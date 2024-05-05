Return-Path: <linux-rdma+bounces-2267-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6BE8BC051
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2024 14:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 328541F2146A
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2024 12:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95B218622;
	Sun,  5 May 2024 12:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLSEKPTx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851F31803D;
	Sun,  5 May 2024 12:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714911226; cv=none; b=iEIL6ISL4zQ+htptaXo3fo/7uMz2JonoQsCCN8cZ/dxoC9ED7uDBXJAkx10JejX4lF/BCZ6IV6u9dJHlph9suWt+YncneCaBUG6EiHIrUq9FPKSbQaAn47nOohawfwezMCn/iElrUjkP+7yqnL2Se1lvQghbbgA1URY4z2o3sQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714911226; c=relaxed/simple;
	bh=hJpY86AyHtVkkFtw1zFI3XC2dz7W9a3/ELeMztaohCw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nxxBcdfFVCwjwvitfbDe6dX790eYj98AFRvgUt8LzhSla2rRsLfzWy0KbPPMUCclUd5q90BUWtACKLx10cbaF+DzTIAD7/0rofxdlzSmZm7trE4+k8wrALP2xXZgUptbmy8896Xslows1ZxCOrz0gfZDwLnXVDPNqfje6dOju7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLSEKPTx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85810C113CC;
	Sun,  5 May 2024 12:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714911226;
	bh=hJpY86AyHtVkkFtw1zFI3XC2dz7W9a3/ELeMztaohCw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gLSEKPTxicJ8mXorBejAdGX74ORKAtvY/kIC2ld2p6+aP2aZYWJcbBgTOpPTmj5IC
	 dDr+X5gYotLrqEKUImfELKTK+qFuiHSQQbX0D6bc65XJ4YEOTAP8xa5tlQSFfAB/jx
	 Obtz4M/IBmvcLtuF9DhQ4MHah/l/22GNOnfN7e1V5SE/8QiSjJaPWV4Vhtxygnj8Mg
	 DxQzv9DAQM0k/a708ourQDOldukYaEWU10utZ+5dHtAZgRpgljXqmvkIeEnsXgirtK
	 BwjElezbz8eV7YxYqioVPDAW17jXT0Ewi1qEamlkPJqAEknBq+2eTmANro6HL/yM/Y
	 9JPrec03C0aXw==
From: Leon Romanovsky <leon@kernel.org>
To: Jules Irenge <jbi.octave@gmail.com>
Cc: jgg@ziepe.ca, wenglianfa@huawei.com, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org, lishifeng@sangfor.com.cn, 
 gustavoars@kernel.org
In-Reply-To: <ZjF1Eedxwhn4JSkz@octinomon.home>
References: <ZjF1Eedxwhn4JSkz@octinomon.home>
Subject: Re: [PATCH v2] RDMA/core: Remove NULL check before dev_{put, hold}
Message-Id: <171491122159.97333.18239115209845838657.b4-ty@kernel.org>
Date: Sun, 05 May 2024 15:13:41 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev


On Tue, 30 Apr 2024 23:47:45 +0100, Jules Irenge wrote:
> Coccinelle reports a warning
> 
> WARNING: NULL check before dev_{put, hold} functions is not needed
> 
> The reason is the call netdev_{put, hold} of dev_{put,hold} will check NULL
> There is no need to check before using dev_{put, hold}
> 
> [...]

Applied, thanks!

[1/1] RDMA/core: Remove NULL check before dev_{put, hold}
      https://git.kernel.org/rdma/rdma/c/48d80b484491f1

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


