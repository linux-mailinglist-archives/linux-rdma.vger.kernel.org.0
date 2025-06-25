Return-Path: <linux-rdma+bounces-11625-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9F2AE7FC7
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 12:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7C93188961B
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 10:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EECF2BE7CF;
	Wed, 25 Jun 2025 10:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eX4swQ60"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14A38F5B;
	Wed, 25 Jun 2025 10:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750848091; cv=none; b=gP2W1Qn7DuQwX5eAl5yiEjXsyLLEAznaUHU54b9Cv1wE/gh616HOjSDdK5xwvBNXtimIcsCIYwFnGMVaZUrSvkAtyPJWT7BiS2fZANNAYBZWCe/XiUzEFSsenodDP8blRDtoRxQubDj/OwmgUXd+R7HlBbHPNgFwdDz9VtFk2E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750848091; c=relaxed/simple;
	bh=+UjD+xQMi3Zr0g5BskmtCRzN1FRC5oh6iDOLpP1sTRc=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=s1VNfm4o8ieEU/sl6CZYZJfIJB69o8NqlZ97E8rWEwCMrEkcb5tngy2CZAUx/C9WQ+tVFu7woock9lVEUeKx/DzPqcaTdbxZxbBp5eWxFlfPTcKedDUINyM4KqzsP4UGws7MHvOCLne26mImn94GHbq0Hlj+q8vUEYpjo2TWMug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eX4swQ60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133F0C4CEEA;
	Wed, 25 Jun 2025 10:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750848090;
	bh=+UjD+xQMi3Zr0g5BskmtCRzN1FRC5oh6iDOLpP1sTRc=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=eX4swQ60/KqJiOIGaf6Oen8h6fTQTJb21thBk4FvrvM3W+yyczKUZ+D0CFo5fZQU4
	 ADqOy8Q5HUqHGqvMF+5kuKtFYf5fdmBXwqQe4ecLVDSoB6gOlODdIe/PSGPxVyIeT2
	 LKSFU1PyMl6eh6ukVrDTy4fOHYiZ/94FmrABL5DVIHn7AAzx6A2V1UsjSQD5zMAwt4
	 J/X8wTe4VSPc6P2FivmCNICaz3SFddRMVKU9vg/RcISJCQmR8R7AFd4nc/0NMS6BUR
	 nZ2sAnzqimckAGdMY88kPmtysOIr60IUoofdLHDkviXohjmsS3XoRgsjwbWc8NtiYx
	 Wub7RkVx6a/yg==
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yury Norov <yury.norov@gmail.com>
In-Reply-To: <20250604193947.11834-1-yury.norov@gmail.com>
References: <20250604193947.11834-1-yury.norov@gmail.com>
Subject: Re: [PATCH 0/7] RDMA: hfi1: cpumasks usage fixes
Message-Id: <175084808735.620355.8086859623065174627.b4-ty@kernel.org>
Date: Wed, 25 Jun 2025 06:41:27 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Wed, 04 Jun 2025 15:39:36 -0400, Yury Norov wrote:
> The driver uses cpumasks API in a non-optimal way; partially because of
> absence of proper functions. Fix this and nearby logic.
> 
> Yury Norov [NVIDIA] (7):
>   cpumask: add cpumask_clear_cpus()
>   RDMA: hfi1: fix possible divide-by-zero in find_hw_thread_mask()
>   RDMA: hfi1: simplify find_hw_thread_mask()
>   RDMA: hfi1: simplify init_real_cpu_mask()
>   RDMA: hfi1: use rounddown in find_hw_thread_mask()
>   RDMA: hfi1: simplify hfi1_get_proc_affinity()
>   RDMI: hfi1: drop cpumask_empty() call in hfi1/affinity.c
> 
> [...]

Applied, thanks!

[1/7] cpumask: add cpumask_clear_cpus()
      https://git.kernel.org/rdma/rdma/c/c15d5e70db9627
[2/7] RDMA: hfi1: fix possible divide-by-zero in find_hw_thread_mask()
      https://git.kernel.org/rdma/rdma/c/37b3cba54b404a
[3/7] RDMA: hfi1: simplify find_hw_thread_mask()
      https://git.kernel.org/rdma/rdma/c/f2c2afbba77c11
[4/7] RDMA: hfi1: simplify init_real_cpu_mask()
      https://git.kernel.org/rdma/rdma/c/9c965445a636b7
[5/7] RDMA: hfi1: use rounddown in find_hw_thread_mask()
      https://git.kernel.org/rdma/rdma/c/9370795029d41a
[6/7] RDMA: hfi1: simplify hfi1_get_proc_affinity()
      https://git.kernel.org/rdma/rdma/c/7c2c2f3a205b2b
[7/7] RDMI: hfi1: drop cpumask_empty() call in hfi1/affinity.c
      https://git.kernel.org/rdma/rdma/c/185e34e8f249cb

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


