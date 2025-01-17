Return-Path: <linux-rdma+bounces-7070-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68685A14FBE
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Jan 2025 13:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FC437A031B
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Jan 2025 12:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAEB1FF61A;
	Fri, 17 Jan 2025 12:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVutlGSJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49D61FF5F7;
	Fri, 17 Jan 2025 12:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737118621; cv=none; b=iqNMk2yTlPNtgjPDBfinsDjFL1C/lphJTGnexApCXv5UYC90sNpAs4kzGc6kvDRVeeTDi9JGOUi4UASk0dNAeYc5ZIZzsRlm6H0gfCxhiMP7lOyqf0idYmW424KAGYIhqi6wB0/N8t95O7r6/SEPTJSe8coSIdf9To+5Pr3Iohc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737118621; c=relaxed/simple;
	bh=Ng8c8u9mGMsnr89/0ZbFiDettIc2FYU96JTg/Manq1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Za7vAWZwi2mrFblfmS9IMQVCHqHUnHivyWunTi1Dw1oqWc4mVCdYGn8ysOp76Lzgt6tjdCJNSzD9QfZHFRnUBKYxAtRHRoEPnVOBaNtI57daZ/HI+2OdTdf6RtqkdETm9mdOuheAA6lUG5bRMDGW5yJpG5X4tQKKRhKENIQmZYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVutlGSJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282D4C4CEE6;
	Fri, 17 Jan 2025 12:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737118621;
	bh=Ng8c8u9mGMsnr89/0ZbFiDettIc2FYU96JTg/Manq1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XVutlGSJ02ENDzZnXyyURYUHhTJxQLMOtOOuiDwvDS0K0dlxiovJL/S0RQTZ2llrr
	 fFGN7zqU1hdnUzACq//OSqhRPCMWULLSsQLqRtX16McWrllt+BQFEZMNyBKiByZupr
	 oZHiqAXt2XI9hjPXr7aQIL1tOA5UP758bx9NFGSeDXGMp1T0G1CVDFwuqaDDl1yM/W
	 nkVzRU29GQ17TAkp8TAqkSCpOe3fdtVOZQ2CQjhsro6Cvd0e9Ydsgn7Lt1yqXHjL/J
	 y2DoKHoS05M7UGrq9KG+jwD6S3IyL50HYeNfFE7E3zK8NkS+boaHHSM7DkTNJnlici
	 Eo4oon6spCaXg==
From: Maxime Ripard <mripard@kernel.org>
To: Maarten Lankhorst <dev@lankhorst.se>,
	Friedrich Vock <friedrich.vock@gmx.de>,
	Tejun Heo <tj@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Maxime Ripard <mripard@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] cgroup/rdma: Drop bogus PAGE_COUNTER select
Date: Fri, 17 Jan 2025 13:56:57 +0100
Message-ID: <173711861436.353110.4495844008892869326.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <b4d462f038a2f895f30ae759928397c8183f6f7e.1737020925.git.geert+renesas@glider.be>
References: <b4d462f038a2f895f30ae759928397c8183f6f7e.1737020925.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 16 Jan 2025 10:56:35 +0100, Geert Uytterhoeven wrote:
> When adding the Device memory controller (DMEM), "select PAGE_COUNTER"
> was added to CGROUP_RDMA, presumably instead of CGROUP_DMEM.
> While commit e33b51499a0a6bca ("cgroup/dmem: Select PAGE_COUNTER") added
> the missing select to CGROUP_DMEM, the bogus select is still there.
> Remove it.
> 
> 
> [...]

Applied to misc/kernel.git (drm-misc-next-fixes).

Thanks!
Maxime

