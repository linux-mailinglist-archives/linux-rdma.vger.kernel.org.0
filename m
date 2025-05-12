Return-Path: <linux-rdma+bounces-10299-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55871AB3559
	for <lists+linux-rdma@lfdr.de>; Mon, 12 May 2025 12:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3012417FEAC
	for <lists+linux-rdma@lfdr.de>; Mon, 12 May 2025 10:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471DA267B7B;
	Mon, 12 May 2025 10:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tt0/Cb5I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0113D2673B6;
	Mon, 12 May 2025 10:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747047189; cv=none; b=hnJDoatuLSisCQQSDFKDfhzq2jppPdVrx6r7pHqoX3fZBSyc1uREKvDiLdMj50cYlFe5KUj3m+UCYw/tC1AyVxnudP6NbDzfSrAraNW7eKyFerK8UgzI8Yd9SpRqhblwMTEgaqdkSr2SjI2kj3t3XQs725Im45Wnlbhgs+xgukE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747047189; c=relaxed/simple;
	bh=l50UXFpJ7NDZICnG7L/4G5N8u652qSxXiRop3K6n6cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpYE5epONN2CCX+JRYPxezkxcJgd9WcAr3YqfH4zXfs59kOQir6Fs6FQUy6MRjzOhh0aCXpAacu4jgSDtGWv9YUjaOhvdNWFQdPKW4S8K0j68Um4rfccpJoP02ansc3FcQ6Py97fj61UgO+0EzFFr3Q6fbyGN5zPOyyLStOlQx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tt0/Cb5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100DCC4CEE7;
	Mon, 12 May 2025 10:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747047188;
	bh=l50UXFpJ7NDZICnG7L/4G5N8u652qSxXiRop3K6n6cY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tt0/Cb5IxStAAp/+kXhdH0/g4xhOHDjzNLBTTRlfZ+DZQ+bFU1SdGE1lz5CDT7hjm
	 fDsmaDpBUxp4AaUTN0lufTynxNjezKeuYE9jTluuqEEHDeE1R9wKIlci/0cLE9F8KG
	 +Aj4stuiUBoJ05M2CnEwhPeRIXJZ5c+1PGCD93hbkxAZGrMKUXcTo9ujwlZyQKoje/
	 hQB7xSnYyQwlBLHPuofdqLmeeonteCIVwefcbYxT1EIHw19nGUGCZF3FmkWp6+7wiN
	 G1WWhbQJ4J05ZWlrlWI/ZfVkRMlxV+6Khu4WOKOoWbhEBZIEQpD63i2d07F2AvQGtc
	 BJxYv0tWBRrmw==
Date: Mon, 12 May 2025 13:53:04 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/cm: Remove redundant WARN_ON in cm_free_priv_msg
Message-ID: <20250512105304.GC22843@unreal>
References: <20250509081840.40628-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509081840.40628-1-lizhijian@fujitsu.com>

On Fri, May 09, 2025 at 04:18:40PM +0800, Li Zhijian wrote:
> Sometimes, the blktests triggered this WARN_ON():
>  ------------[ cut here ]------------
>  WARNING: CPU: 3 PID: 1330889 at cm.c:353 cm_free_priv_msg+0xaa/0xc0 [ib_cm]
> ...
>  CPU: 3 UID: 0 PID: 1330889 Comm: kworker/u16:1 Tainted: G        W  OE      6.13.0-rc3+ #3
>  Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>  Workqueue: ib_mad1 timeout_sends [ib_core]
>  RIP: 0010:cm_free_priv_msg+0xaa/0xc0 [ib_cm]
> ...
>  Call Trace:
>   <TASK>
>   ? cm_free_priv_msg+0xaa/0xc0 [ib_cm]
>   ? __warn.cold+0x93/0xfa
>   ? cm_free_priv_msg+0xaa/0xc0 [ib_cm]
>   ? report_bug+0xff/0x140
>   ? handle_bug+0x58/0x90
>   ? exc_invalid_op+0x17/0x70
>   ? asm_exc_invalid_op+0x1a/0x20
>   ? cm_free_priv_msg+0xaa/0xc0 [ib_cm]
>   cm_process_send_error+0x64/0x1f0 [ib_cm]
>   timeout_sends+0x1e5/0x2d0 [ib_core]
>   process_one_work+0x156/0x310
>   worker_thread+0x252/0x390
>   ? __pfx_worker_thread+0x10/0x10
>   kthread+0xd2/0x100
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x34/0x50
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
>  ---[ end trace 0000000000000000 ]---
> 
> In cm_process_send_error(), cm_free_priv_msg() will be called
> when (msg != cm_id_priv->msg) is true. And all other calling to
> cm_free_priv_msg() cases, msg is always the same as cm_id_priv->msg.
> 
> So it's safe to remove this WARN_ON

This patch should fix the issue.
https://lore.kernel.org/all/0c364c29142f72b7875fdeba51f3c9bd6ca863ee.1745839788.git.leon@kernel.org/
7590649ee7af ("IB/cm: Drop lockdep assert and WARN when freeing old msg")

Thanks

