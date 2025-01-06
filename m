Return-Path: <linux-rdma+bounces-6839-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB224A02692
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2025 14:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A1943A4620
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2025 13:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C345A1D9595;
	Mon,  6 Jan 2025 13:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCBi7gGk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6292BAEC;
	Mon,  6 Jan 2025 13:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736170169; cv=none; b=F+Eoyikf+P/pwPZwc+hxd808qoujBtNErpTO0VptXoLTbJ+6/L2eJ8RT4pAIDaElSxhVs9W0ARmxJ6R9UqQDZag5T90DX0mpK6zPGo7A4emaRb+XB3U+AQJ1UOsaEHpxohFcI8eL2axlZ98zp7ll6BOqf+Ypou+c3Id4LjkSqzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736170169; c=relaxed/simple;
	bh=3t8M9CcPBLepKQDw/r5V9bbiF56s0CcQJqw8lB4ac8I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A1fH0OiJZtUf2pBRY8ChsecaR1UiRhCBKsx277BIixTdoCqilP18jWIB+xenjREh334dd3ndWyMaw5su0kmwwKXwS8LDyPMEAdutYSCl7CXetBpDKT/9WQWgDiGQ9t5wOlHG+F1d9K1s6uNwUxtDhnl4fWDFPr9eSLlilHgIBCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCBi7gGk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B975C4CEDD;
	Mon,  6 Jan 2025 13:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736170168;
	bh=3t8M9CcPBLepKQDw/r5V9bbiF56s0CcQJqw8lB4ac8I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SCBi7gGk+EvaJbcCroiFnm1QfZ3lpXliaLEAbV2jO89j4NGwveOLUzZ9fFxyp3v2S
	 /TmOAaY7wRbf3iYHWra9ofAV0pdD0TxRbex+7PaCgp4BLAuJPOASCQOIgAaMiMG5mX
	 m7WlhAsjya9fQP+kLsZ8CdI20cpGFgocWJw18Q1ckkG00tMbf4xhXWaG0NJXyZ37xP
	 pgPmFPE/U6o88qcvLylyftpLP4MePUejcqCxDKncDLUMphurvcAbGcWgG9vTZarOih
	 sZeTzyumhM7IFPNDwT9ojmFOO4C8nBd6Bl1grKAaRrNFbueto3B75apdcaj8nGhOiI
	 7B1aQpdrVLI9Q==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>
Cc: haris.iqbal@ionos.com, Jack Wang <jinpu.wang@ionos.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org
In-Reply-To: <20250106004516.16611-1-lizhijian@fujitsu.com>
References: <20250106004516.16611-1-lizhijian@fujitsu.com>
Subject: Re: [PATCH v3] RDMA/rtrs: Add missing deinit() call
Message-Id: <173617016505.510269.15505675662356312678.b4-ty@kernel.org>
Date: Mon, 06 Jan 2025 08:29:25 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 06 Jan 2025 08:45:16 +0800, Li Zhijian wrote:
> A warning is triggered when repeatedly connecting and disconnecting the
> rnbd:
>  list_add corruption. prev->next should be next (ffff88800b13e480), but was ffff88801ecd1338. (prev=ffff88801ecd1340).
>  WARNING: CPU: 1 PID: 36562 at lib/list_debug.c:32 __list_add_valid_or_report+0x7f/0xa0
>  Workqueue: ib_cm cm_work_handler [ib_cm]
>  RIP: 0010:__list_add_valid_or_report+0x7f/0xa0
>   ? __list_add_valid_or_report+0x7f/0xa0
>   ib_register_event_handler+0x65/0x93 [ib_core]
>   rtrs_srv_ib_dev_init+0x29/0x30 [rtrs_server]
>   rtrs_ib_dev_find_or_add+0x124/0x1d0 [rtrs_core]
>   __alloc_path+0x46c/0x680 [rtrs_server]
>   ? rtrs_rdma_connect+0xa6/0x2d0 [rtrs_server]
>   ? rcu_is_watching+0xd/0x40
>   ? __mutex_lock+0x312/0xcf0
>   ? get_or_create_srv+0xad/0x310 [rtrs_server]
>   ? rtrs_rdma_connect+0xa6/0x2d0 [rtrs_server]
>   rtrs_rdma_connect+0x23c/0x2d0 [rtrs_server]
>   ? __lock_release+0x1b1/0x2d0
>   cma_cm_event_handler+0x4a/0x1a0 [rdma_cm]
>   cma_ib_req_handler+0x3a0/0x7e0 [rdma_cm]
>   cm_process_work+0x28/0x1a0 [ib_cm]
>   ? _raw_spin_unlock_irq+0x2f/0x50
>   cm_req_handler+0x618/0xa60 [ib_cm]
>   cm_work_handler+0x71/0x520 [ib_cm]
> 
> [...]

Applied, thanks!

[1/1] RDMA/rtrs: Add missing deinit() call
      https://git.kernel.org/rdma/rdma/c/81468c4058a62e

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


