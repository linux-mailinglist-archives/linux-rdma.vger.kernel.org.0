Return-Path: <linux-rdma+bounces-5253-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C978991E33
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Oct 2024 13:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C82CAB216F1
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Oct 2024 11:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20419170A3F;
	Sun,  6 Oct 2024 11:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AF/d+U82"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16D0EC5;
	Sun,  6 Oct 2024 11:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728215355; cv=none; b=as5rvGP1XTCksUmolCZleKOLTJ3m4GmuXC3+TevSF9llG6uedMG9Zyd1Oe+DHU+MKBfgsM5461QVwRg+IAxTH8/jSRBCDQE5TdZ7h5YiKDJfkXVVkzjKxL2xN+S1udZ3JcLvvf5MfFI6dVBXZQKKaQXc48zIZHr7eS0P+ykl9QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728215355; c=relaxed/simple;
	bh=v6SW59OPf4bvpxmuyWCE2we6FDjoWhx+L3PQNr/qC3s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=smjd8fmJL2Nq0YO7YzdtHn1TyGg2tJiacpjn0MEOpC5M2hzOlU7t0IZML9/2igSl1kvs38BUsD+AJeXz2qdLkRtAh4cazYPo8Yid4Z+FlX96UXC64homUjW3QWsdFRP7Ob/G8UoowGTZKuyJlaSlB2qRB5lGEC6Ru4GhrZYUJmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AF/d+U82; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD6AC4CEC5;
	Sun,  6 Oct 2024 11:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728215355;
	bh=v6SW59OPf4bvpxmuyWCE2we6FDjoWhx+L3PQNr/qC3s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AF/d+U82gx76P42/xScTP5Kj1FchPiuIZRGnb6k4xqM/RR4zd39A4/JxwxL365deq
	 3zncpYwZnM9aKlwdd3Pdnxrf5GnpS37xW8vBREN6KsZl3CpXw1qSFRtNkH5L9tZ6G4
	 Hmh5/eG1+X8+WHtUjySwqT6Ug9kiALHH/qrl4W07Cz7/VF5U8RfPBWLGIwm5LYiHmR
	 8134d0QS+UuSe5fui8ENNIDxWU2cX8Do749rRXwWpYUZezjtFp7o3ZB1okftz6+cj6
	 adh19JujgepnciJbEkYKsjCQh4Ym8D/w5hkxSzgd7yEh73FDQBWoQ0A9DaRItMS352
	 wkPZm4JE5i7Jw==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com, 
 linux-kernel@vger.kernel.org, tangchengchang@huawei.com
In-Reply-To: <20240927103323.1897094-1-huangjunxian6@hisilicon.com>
References: <20240927103323.1897094-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH v6 for-next 0/2] RDMA: Provide an API for drivers to
 disassociate mmap pages
Message-Id: <172821535029.66120.2694855650347768865.b4-ty@kernel.org>
Date: Sun, 06 Oct 2024 14:49:10 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Fri, 27 Sep 2024 18:33:21 +0800, Junxian Huang wrote:
> Provide an API rdma_user_mmap_disassociate() for drivers to disassociate
> mmap pages. Use this API in hns to prevent userspace from ringing doorbell
> when HW is reset.
> 
> v5 -> v6:
> * Fix build warning of unused label in patch #1
> * inline the call to rdma_user_mmap_disassociate() in patch #2
> 
> [...]

Applied, thanks!

[1/2] RDMA/core: Provide rdma_user_mmap_disassociate() to disassociate mmap pages
      https://git.kernel.org/rdma/rdma/c/4fea8bfc11b2fc
[2/2] RDMA/hns: Disassociate mmap pages for all uctx when HW is being reset
      https://git.kernel.org/rdma/rdma/c/23ab1cdca331e1

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


