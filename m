Return-Path: <linux-rdma+bounces-1042-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C778E859DB1
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Feb 2024 09:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05C361C20399
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Feb 2024 08:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C760621370;
	Mon, 19 Feb 2024 07:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjrlE+Ss"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8352121362;
	Mon, 19 Feb 2024 07:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708329070; cv=none; b=Sw5wQzA+D4pAxLx+hIHvkDHnxI9rInzOsprjiFNpa095TepBkz6h5NFife8Z5XpmCtikGBNO7MpWsTnccDsWylBUHV+L180gZS+cZhJOgQApoW8sHbvjcatyz31dIlSktjQtvJMbMe5TazQI26L6tit4PAMHSiIRVS1yrcor8pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708329070; c=relaxed/simple;
	bh=fA+T8609KxuswGMZQTjV7L0OA2N8nSYotcC+2v27Kno=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oLYJnstiJGhYUMgsd06DRv7E34ShM5Tr7vky79lA3R0UGymZ0CfI+B5p5jpS/6EnNDnnvjQbITlD7jgYXHiHr8A6Z6/DozKRFGQMm6rt0H/6JJtLu9q2yI8xeB3W6AbtUfVshH2A7DILwWmxzsxKdJsIAQufhGPz2B1wra7WIW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjrlE+Ss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990B4C433F1;
	Mon, 19 Feb 2024 07:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708329070;
	bh=fA+T8609KxuswGMZQTjV7L0OA2N8nSYotcC+2v27Kno=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gjrlE+Ssx3BNKrZ8MMisPkU0bG9kzSaWcts+gbj6uRZx13oqpX+KMJZz0kEmx3F2D
	 mAtTIb+N4mWlJg/9sPEyk/xzpub7xJ8pqMxje18y5IiSzIU0FfyyHMOdnWEL/M/E7A
	 tZOn8Ds9I8bMU/Fj0ejQsR9LSaYNAE5fd9l32vCUU8dhh93mC/20Fb1QP221+VblA4
	 nGA4f+uZWort0Hu4VfAstLRlgmRVHWFwwNnV7yrX2QT7u2Tt5T3eiasL/6LFosMG9B
	 Y+R/XOBjdCOn3m78zdutFk44XG4BW9NYjr3j4Dj3s8fcPwmVZXLYRkUcxKDC+QcCHW
	 Kn+Zz96pOEjxA==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc:
 linux-rdma@vger.kernel.org, linuxarm@huawei.com, linux-kernel@vger.kernel.org
In-Reply-To: <20240219061805.668170-1-huangjunxian6@hisilicon.com>
References: <20240219061805.668170-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH for-next] RDMA/hns: Fix mis-modifying default congestion
 control algorithm
Message-Id: <170832906579.134605.15025302107615338247.b4-ty@kernel.org>
Date: Mon, 19 Feb 2024 09:51:05 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d


On Mon, 19 Feb 2024 14:18:05 +0800, Junxian Huang wrote:
> Commit 27c5fd271d8b ("RDMA/hns: The UD mode can only be configured
> with DCQCN") adds a check of congest control alorithm for UD. But
> that patch causes a problem: hr_dev->caps.congest_type is global,
> used by all QPs, so modifying this field to DCQCN for UD QPs causes
> other QPs unable to use any other algorithm except DCQCN.
> 
> Revert the modification in commit 27c5fd271d8b ("RDMA/hns: The UD
> mode can only be configured with DCQCN"). Add a new field cong_type
> to struct hns_roce_qp and configure DCQCN for UD QPs.
> 
> [...]

Applied, thanks!

[1/1] RDMA/hns: Fix mis-modifying default congestion control algorithm
      https://git.kernel.org/rdma/rdma/c/d20a7cf9f714f0

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

