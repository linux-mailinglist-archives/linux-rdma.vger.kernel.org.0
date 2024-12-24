Return-Path: <linux-rdma+bounces-6723-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 539999FBC77
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2024 11:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F7A1881423
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Dec 2024 10:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCD71B3926;
	Tue, 24 Dec 2024 10:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aS6DtxTP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF6A18FDC5;
	Tue, 24 Dec 2024 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735035982; cv=none; b=OsnQazr11GERerk+8ejljome0geQNzP7gpPpsunYatma5oEUyRIE2TuCJZA5VJXOjhVd7Y7YS5ll8Ja6ljX5mH+wEunjsjx4TRrf0FMcXKcsJ486InB3AcGirDiyZ1rvbLix0MECPfn1NKrWAlhLh1hy58AoLwbSJyQiqDg9J9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735035982; c=relaxed/simple;
	bh=+9HwmYfpy+SkmUmJLBtEazT1vkj2csmcutdKmbDY1Pc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jrwT/H3ce9zNB9MwehLEOzBqqIiT4pnnfMSHFh+KrwVmzz0PiZVBsLagRIsPN55YEh/QHP5pjUw1djMq2YDxrB9eDXrzYicOgGqtEr6WSsVobY5V52l/es1TqTkXw4WzJZcbkfchaxZ30CIN9KCPySO3bSvEnn5aksScDqeH1g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aS6DtxTP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C54C4CED7;
	Tue, 24 Dec 2024 10:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735035982;
	bh=+9HwmYfpy+SkmUmJLBtEazT1vkj2csmcutdKmbDY1Pc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aS6DtxTP5RgrahPSCgQP8nZvmytE3uG0skW6aN9zVy3uCEXL7ZDA9H19jhq1wK1Tw
	 chgHf0JwPvZ+LYN4XZ+tM+nwmb0ul2POB2d0UV11Z2R6kVtUue/hMPT2Ru2NFdapCk
	 KtRH4vKWPynbCw96hnkxdpewoY3XuJlC9DJSoh7XltDFbJw4yrWo7Jm5JFwE0uoCh5
	 CxrBwOQH/gPVZmEO+/TuFjN0QdiQfi5mOdiYHWE/GL+PLHGvmnathkXUcM5ySpG2DZ
	 8l2NhxTt+4aje+KhkBCwtEICkL/y2vCKTwf0Cr8W3nbxkBO56MFg+3FbyI1V7Z6JKC
	 puc9gSHdshMiQ==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, selvin.xavier@broadcom.com, chengyou@linux.alibaba.com, 
 kaishen@linux.alibaba.com, mustafa.ismail@intel.com, 
 tatyana.e.nikolova@intel.com, yishaih@nvidia.com, benve@cisco.com, 
 neescoba@cisco.com, bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com, 
 zyjzyj2000@gmail.com, bmt@zurich.ibm.com, 
 Junxian Huang <huangjunxian6@hisilicon.com>
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com, 
 linux-kernel@vger.kernel.org, tangchengchang@huawei.com, liyuyu6@huawei.com
In-Reply-To: <20241122105308.2150505-1-huangjunxian6@hisilicon.com>
References: <20241122105308.2150505-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH RFC 00/12] RDMA: Support link status events dispatching
 in ib_core
Message-Id: <173503597849.417234.3349221778050147261.b4-ty@kernel.org>
Date: Tue, 24 Dec 2024 05:26:18 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Fri, 22 Nov 2024 18:52:56 +0800, Junxian Huang wrote:
> This series is to integrate a common link status event handler in
> ib_core as this functionality is needed by most drivers and
> implemented in very similar patterns. This is not a new issue but
> a restart of the previous work of our colleagues from several years
> ago, please see [1] and [2].
> 
> [1]: https://lore.kernel.org/linux-rdma/1570184954-21384-1-git-send-email-liweihang@hisilicon.com/
> [2]: https://lore.kernel.org/linux-rdma/20200204082408.18728-1-liweihang@huawei.com/
> 
> [...]

Applied, thanks!

[01/12] RDMA/core: Add ib_query_netdev_port() to query netdev port by IB device.
        https://git.kernel.org/rdma/rdma/c/0c039a57b68dfb
[02/12] RDMA/core: Support link status events dispatching
        https://git.kernel.org/rdma/rdma/c/1fb0644c3899b2
[03/12] RDMA/bnxt_re: Remove deliver net device event
        https://git.kernel.org/rdma/rdma/c/6ed44e35108526
[04/12] RDMA/erdma: Remove deliver net device event
        https://git.kernel.org/rdma/rdma/c/0cd5fba400d225
[05/12] RDMA/irdma: Remove deliver net device event
        https://git.kernel.org/rdma/rdma/c/504c1945bc0625
[06/12] RDMA/rxe: Remove deliver net device event
        https://git.kernel.org/rdma/rdma/c/970a1c37dd0476
[07/12] RDMA/siw: Remove deliver net device event
        https://git.kernel.org/rdma/rdma/c/8ec9b334d8c17c
[08/12] RDMA/usnic: Support report_port_event() ops
        https://git.kernel.org/rdma/rdma/c/a9112cb29ee36a
[09/12] RDMA/mlx4: Support report_port_event() ops
        https://git.kernel.org/rdma/rdma/c/0b15bb46e71c44
[10/12] RDMA/pvrdma: Support report_port_event() ops
        https://git.kernel.org/rdma/rdma/c/d9e3c4d7eb50ad
[11/12] RDMA/mlx5: Handle link status event only for LAG device
        https://git.kernel.org/rdma/rdma/c/01b6e181a551d3
[12/12] RDMA/hns: Support fast path for link-down events dispatching
        https://git.kernel.org/rdma/rdma/c/7e83fbdd9ca37f

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


