Return-Path: <linux-rdma+bounces-8023-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 152A9A40EC0
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Feb 2025 12:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCF637A2BB8
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Feb 2025 11:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C5A205AA1;
	Sun, 23 Feb 2025 11:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ta1L6lM5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182751FC11B
	for <linux-rdma@vger.kernel.org>; Sun, 23 Feb 2025 11:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740311910; cv=none; b=s3/tGifE8yXjHZqXVyhGBSRxcrZXBCLh2EeT+zFdxOgbJki3vlQy6D9rj1pfCFgapi7vI6eqEZH4R301FNosk2EYblB13e40QH43cKC1KxI+T4gjdaKT8voGyHrwuGZNkatLjFDFDIMO0Iv504/x7iW41vn26fkKU0j75wkOPwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740311910; c=relaxed/simple;
	bh=dWEd3CdMH20j3hk/tsTxz/XzbVR4FbG+knjVoa7y1s4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LJlWIAyAjGoDH3CHjK01sxWnc8iyRO8s5jM6gmvJKtGkrX4Z1G6unRA17hfzWmZlt96bPUPGRz6TVWKS1Id+nhtUD8pEIRv2G9NGderd/Q4x27+D94npgUoz8Wp+ZGPok/stfK1XphgXlvzMkgccnaixk0QYwUKRwYBMi99uaQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ta1L6lM5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129F9C4CEDD;
	Sun, 23 Feb 2025 11:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740311909;
	bh=dWEd3CdMH20j3hk/tsTxz/XzbVR4FbG+knjVoa7y1s4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ta1L6lM5pvnTBHeOLqkiD5JlUSLkEDLmEd5shsKUh0iSsKeUQ2Ik0owibf/ZODAoP
	 32ATaR4oWajVo9iuvLck06p5x/R5Wl2+9OYS1OeImZE5D3yVlz/F/7kAFNkkA/ywWt
	 En6UIgYOFcu46fG21HVEEnXltcdKDwc4iMkx3mDWprP+C2UvkJ7JBcpnn2sSkxoPy8
	 xIMyVNLSkrpSTJ+kWEKereTKi8E60jmj3fyCnJWSa7y98aHuFD3Xid1kxCcW3nP62I
	 BoTi0EqKkRBI6A7EMfAbvVVm5EYUaFLVD1kLoQIn4bzGFY8yV0yIcM3a9iypFLQXzV
	 qu+p1ueQGVHGA==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Selvin Xavier <selvin.xavier@broadcom.com>
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
 kalesh-anakkur.purayil@broadcom.com, 
 Kashyap Desai <kashyap.desai@broadcom.com>
In-Reply-To: <1740237621-29291-1-git-send-email-selvin.xavier@broadcom.com>
References: <1740237621-29291-1-git-send-email-selvin.xavier@broadcom.com>
Subject: Re: [PATCH rdma-rc] RDMA/bnxt_re : Fix the page details for the
 srq created by Kernel consumers
Message-Id: <174031190593.499819.11009821555641202497.b4-ty@kernel.org>
Date: Sun, 23 Feb 2025 06:58:25 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Sat, 22 Feb 2025 07:20:21 -0800, Selvin Xavier wrote:
> While using nvme target with use_srq on, below kernel panic is noticed.
> 
> [  549.698111] bnxt_en 0000:41:00.0 enp65s0np0: FEC autoneg off encoding: Clause 91 RS(544,514)
> [  566.393619] Oops: divide error: 0000 [#1] PREEMPT SMP NOPTI
> ..
> [  566.393799]  <TASK>
> [  566.393807]  ? __die_body+0x1a/0x60
> [  566.393823]  ? die+0x38/0x60
> [  566.393835]  ? do_trap+0xe4/0x110
> [  566.393847]  ? bnxt_qplib_alloc_init_hwq+0x1d4/0x580 [bnxt_re]
> [  566.393867]  ? bnxt_qplib_alloc_init_hwq+0x1d4/0x580 [bnxt_re]
> [  566.393881]  ? do_error_trap+0x7c/0x120
> [  566.393890]  ? bnxt_qplib_alloc_init_hwq+0x1d4/0x580 [bnxt_re]
> [  566.393911]  ? exc_divide_error+0x34/0x50
> [  566.393923]  ? bnxt_qplib_alloc_init_hwq+0x1d4/0x580 [bnxt_re]
> [  566.393939]  ? asm_exc_divide_error+0x16/0x20
> [  566.393966]  ? bnxt_qplib_alloc_init_hwq+0x1d4/0x580 [bnxt_re]
> [  566.393997]  bnxt_qplib_create_srq+0xc9/0x340 [bnxt_re]
> [  566.394040]  bnxt_re_create_srq+0x335/0x3b0 [bnxt_re]
> [  566.394057]  ? srso_return_thunk+0x5/0x5f
> [  566.394068]  ? __init_swait_queue_head+0x4a/0x60
> [  566.394090]  ib_create_srq_user+0xa7/0x150 [ib_core]
> [  566.394147]  nvmet_rdma_queue_connect+0x7d0/0xbe0 [nvmet_rdma]
> [  566.394174]  ? lock_release+0x22c/0x3f0
> [  566.394187]  ? srso_return_thunk+0x5/0x5f
> 
> [...]

Applied, thanks!

[1/1] RDMA/bnxt_re : Fix the page details for the srq created by Kernel consumers
      https://git.kernel.org/rdma/rdma/c/b66535356a4834

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


