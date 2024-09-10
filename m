Return-Path: <linux-rdma+bounces-4861-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EF8973860
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 15:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 542BD285210
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 13:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520F619259F;
	Tue, 10 Sep 2024 13:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XV1hdi8z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107AB524B4;
	Tue, 10 Sep 2024 13:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725974028; cv=none; b=sB+eLy40rYsFxj5VDArKG6Y6PPep+231noXFf73MvYheNaqlcxQp/btsA7BNBHX5SdnIUbDGdDNWiBtRdUQxW9ogzY5zj9CHv5L0VkWm7k7oQahX5RspkaQF2eFxCf+XnHR56CzM1y1QeUGehMjDej8CmJRGU4sILNuzzUZORhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725974028; c=relaxed/simple;
	bh=2k9f2RMw7CBKwpHtxVRTYzoZN8ExXPO0CJoKPxU1U/c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AA2Hd5vQOJVw4Ry7ZHU0Q6XQOkR4FMpOqP7Hd+HV7r8t0+C9swPDbOqKlRquzfnbOz4eDQ80k/6Wgl9Rno7OX4XGChEO4X3ITbsHFohAhO3J6UsMG86fQU4fr89VcFkDrUuoFCeEeLYwrObcBppSCsfTe8yUjF/J83Fby06XWe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XV1hdi8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC721C4CEC3;
	Tue, 10 Sep 2024 13:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725974027;
	bh=2k9f2RMw7CBKwpHtxVRTYzoZN8ExXPO0CJoKPxU1U/c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XV1hdi8zBYffx/W/YzPV6iOTgIahHr0kNgpWOSYO4mw8+kskiF6colSWJVpKTnoxR
	 colTT1+B9dAqRHuU2TD0cjWdLsCwM4r45Z3C8AtMeBkQNVIcSMlE+5xiYOlfDD/dFf
	 RzB3o9YtJwSgepIgl6HfIeSKj/rTAc0c7xKEhgXqA/2kTAc03j1HHmMq9kVmtO5RSJ
	 hyoSiEQHsv/VjaBV/YsrH5I8DTiSYPIsgp2zVmQ+38YRYgMil6LJi59oJyctMBPLTH
	 eGtS+VXDmEnTEB+iSCSQx+ekOfk09x6WS35WxOPTqeKSTDN24O/HBCgEX78BigaEpB
	 eokbE4J7f/mdw==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240906093444.3571619-1-huangjunxian6@hisilicon.com>
References: <20240906093444.3571619-1-huangjunxian6@hisilicon.com>
Subject: Re: (subset) [PATCH for-next 0/9] RDMA/hns: Bugfixes and one
 improvement
Message-Id: <172597402310.3387045.13638568220298079896.b4-ty@kernel.org>
Date: Tue, 10 Sep 2024 16:13:43 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Fri, 06 Sep 2024 17:34:35 +0800, Junxian Huang wrote:
> This is a series of hns patches. Patch #8 is an improvement for
> hem allocation performance, and the others are some fixes.
> 
> Chengchang Tang (2):
>   RDMA/hns: Fix spin_unlock_irqrestore() called with IRQs enabled
>   RDMA/hns: Fix 1bit-ECC recovery address in non-4K OS
> 
> [...]

Applied, thanks!

[1/9] RDMA/hns: Don't modify rq next block addr in HIP09 QPC
      https://git.kernel.org/rdma/rdma/c/6928d264e328e0
[2/9] RDMA/hns: Fix Use-After-Free of rsv_qp on HIP08
      https://git.kernel.org/rdma/rdma/c/fd8489294dd2be
[4/9] RDMA/hns: Fix the overflow risk of hem_list_calc_ba_range()
      https://git.kernel.org/rdma/rdma/c/d586628b169d14
[5/9] RDMA/hns: Fix spin_unlock_irqrestore() called with IRQs enabled
      https://git.kernel.org/rdma/rdma/c/74d315b5af1802
[6/9] RDMA/hns: Fix VF triggering PF reset in abnormal interrupt handler
      https://git.kernel.org/rdma/rdma/c/4321feefa5501a
[7/9] RDMA/hns: Fix 1bit-ECC recovery address in non-4K OS
      https://git.kernel.org/rdma/rdma/c/ce196f6297c7f3
[8/9] RDMA/hns: Optimize hem allocation performance
      https://git.kernel.org/rdma/rdma/c/fe51f6254d81f5

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


