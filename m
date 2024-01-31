Return-Path: <linux-rdma+bounces-832-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47636843F78
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 13:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5292B221F2
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 12:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1E278679;
	Wed, 31 Jan 2024 12:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKxN131F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC2555C14
	for <linux-rdma@vger.kernel.org>; Wed, 31 Jan 2024 12:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706704514; cv=none; b=nwMEn5USO6IVUELFqJTndvA8WkN6kUPcGc6VVfi7o0TBxnpnbGppRNkhNOksbQIni6jWhh8D2zQhKpk0ClIHA1aE3mLd2lhxFxaa7YNpr5NANNeIvM31HXtET3HbDp2S6x4UrIWMIISiItQLdzTZxEPKl5ioEiZRul2WQx1xMP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706704514; c=relaxed/simple;
	bh=O2qHpUyNIJ47edFwvnzbrHFWpzEBb07xg04Ui/Smgh8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jc1Lx5L/s1JWWP9JTn+/Xv95Zlh1AoZ1brbPsWFpHk0k4paAzrNrVYlsJttYDeZz+sBeOvWbO5VIbs3F3DZ5YcUimGmDozJ5jV9x9VfG3DGm7zx/MKgVJRz9EhmhOaZ4Gf+asdPznB2f7o0pPQumy6o0XdQmJZlBipRS8LDEO7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKxN131F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E3BC433F1;
	Wed, 31 Jan 2024 12:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706704514;
	bh=O2qHpUyNIJ47edFwvnzbrHFWpzEBb07xg04Ui/Smgh8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MKxN131FJBcwomN9ySEk/Q/+zZ0URA9UWRCR4iuUTJNJANef2EWfelyLZaQGRrQcM
	 TROiDZOWOb9s38L5k6JVPRgA6LwE5l2n59NK8M9pVQ0EqO34KOEAdKj2559Ggw/L1R
	 RTSqn+wN2OUyPXnEGojMo5ppfRJk7H5vV70fuxpuJ8ovWDnq/PRBp6OlE+URF+GqcC
	 NWKSyN3dyoK7CiDxHsNThT5XPToZJ5X4q3Gn3jtZytPY9u4akkNnQnIoPfy5KRGrSy
	 RVn1qcR6/7Z5Kdl96XcbIrKzQCRE6CwEhHgeTxjXqpEVK+34Jo6uasfEjTCZBPMadj
	 ELsXSXEwHDn8Q==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 ynachum@amazon.com
Cc: sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev,
 Michael Margolin <mrgolin@amazon.com>, Yonatan Goldhirsh <ygold@amazon.com>
In-Reply-To: <20240131093403.18624-1-ynachum@amazon.com>
References: <20240131093403.18624-1-ynachum@amazon.com>
Subject: Re: [PATCH for-rc v2] RDMA/efa: Limit EQs to available MSI-X vectors
Message-Id: <170670450968.408371.13972993090884380321.b4-ty@kernel.org>
Date: Wed, 31 Jan 2024 14:35:09 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d


On Wed, 31 Jan 2024 09:34:03 +0000, ynachum@amazon.com wrote:
> When creating EQs we take into consideration the max number of EQs the
> device reported it can support and the number of available CPUs. There
> are situations where the number of EQs the device reported it can
> support and the PCI configuration of MSI-X is different, take it in
> account as well when creating EQs.
> Also request at least 1 MSI-X vector for the management queue and allow
> the kernel to return a number of vectors in a range between 1 and the
> max supported MSI-X vectors according to the PCI config.
> 
> [...]

Applied, thanks!

[1/1] RDMA/efa: Limit EQs to available MSI-X vectors
      https://git.kernel.org/rdma/rdma/c/809c9c3bd6997e

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

