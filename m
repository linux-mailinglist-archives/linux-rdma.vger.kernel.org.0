Return-Path: <linux-rdma+bounces-5975-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AA59C86D0
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2024 11:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CD24B2A879
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2024 09:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8A21F8922;
	Thu, 14 Nov 2024 09:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lz5KzGNg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C4C1F7540;
	Thu, 14 Nov 2024 09:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578193; cv=none; b=AZAZ8OGcdZCwB5jmkDQmDrxHtF9dggYvxgDKn4qSL7TPMVwU75qbj+DcFEk4T4dTrolZHoZ863QjQlMcSTRh826pxBnu2IGayNjotGNnLbHGiVNUENzKdt6r1Mnpbhj3jbVoF/3aPEnv8LF41dY+MJTmJAL4IKs2EAM+TJSpj38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578193; c=relaxed/simple;
	bh=tRe9JEVSjXzf8eyCMsq+7kWaVlqoKITvYF4W3kKTBmw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AxVG5pnlZIs9bCSd6kf7dqFSDilpH3vcQi3djVRgohxB8KoFJEMnScyOnNeZ8aQPr+Vbip2LVnNAhbl/OBzdkTnADiNcmoKJTZXMy2vuDM9EdRp/0t0URHSQVtsdhb1dRV/bFKyk4pKofVI9/veieYmhA/sGQG+gREp6/XWIKn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lz5KzGNg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF29CC4CECD;
	Thu, 14 Nov 2024 09:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731578193;
	bh=tRe9JEVSjXzf8eyCMsq+7kWaVlqoKITvYF4W3kKTBmw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Lz5KzGNgcTLPvMkijidhb3w2FLvsqYtEq6JDxqA/tBTbZp5G0z5bfjhOaa8FiLSVD
	 jUQevTsGxZawRCMk9HghXSGltIBmPBOYG2l7JC4e49Wk0F3DXKcey0H0XZlvK9/a8x
	 o2peVyFHjUfdO73GFd5eC4B9iUXftIiIqVlPJvKPHnmCL9Fr+tvbtXUElHAlOjTySq
	 ojmx46Soa9kylORnkpMbBzuRyp8lpVA9axgnCLW+jQOGpTJ8k5vWPvDgnPUwHnjMnt
	 4oNZb0f7re+r+r6NNhDMlXYj18x6taV/uwhar31sh2quSD8c0hEF07cXyswgkN2sIl
	 GS0xFDnvqyH8A==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com, 
 linux-kernel@vger.kernel.org, tangchengchang@huawei.com
In-Reply-To: <20241112055553.3681129-1-huangjunxian6@hisilicon.com>
References: <20241112055553.3681129-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH v3 for-next] RDMA/hns: Fix different dgids mapping to
 the same dip_idx
Message-Id: <173157818968.149949.6747918344361006095.b4-ty@kernel.org>
Date: Thu, 14 Nov 2024 04:56:29 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 12 Nov 2024 13:55:53 +0800, Junxian Huang wrote:
> DIP algorithm requires a one-to-one mapping between dgid and dip_idx.
> Currently a queue 'spare_idx' is used to store QPN of QPs that use
> DIP algorithm. For a new dgid, use a QPN from spare_idx as dip_idx.
> This method lacks a mechanism for deduplicating QPN, which may result
> in different dgids sharing the same dip_idx and break the one-to-one
> mapping requirement.
> 
> [...]

Applied, thanks!

[1/1] RDMA/hns: Fix different dgids mapping to the same dip_idx
      https://git.kernel.org/rdma/rdma/c/faa62440a5772b

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


