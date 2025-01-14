Return-Path: <linux-rdma+bounces-7009-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2017A105C8
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2025 12:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC32D1626D3
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2025 11:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37220234D10;
	Tue, 14 Jan 2025 11:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsMTggFh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF1A234CEA
	for <linux-rdma@vger.kernel.org>; Tue, 14 Jan 2025 11:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736855052; cv=none; b=t3sZDOy3IuuE1e9NaMEIwPSvqsonq8BDmOoal6hLLOkPOwAVnTSyC3kPb/qkVh8W0pvxcFyge440vLrT/s5B2/mIfgSYWa79AuP6SotpTWKu8mEAANWt9AqVWll2FS/OTTiMSOoUF5HtvsPA0xkN2gmg2x6HS75vrkYkWjaprDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736855052; c=relaxed/simple;
	bh=+8d+h5vV43bpiCxou+p25uKwq1eaIa31N3Oxhs/tJIY=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=masEYVLHLO6w3O6yT6fFbi+RrQ86KOnHOCg0PC4cLPENIgtFtDeblTvOWqt6wHDo4ApUUsk3cPjTyhYqv47qstY12JRlj6Jf5v6C81YYp5ozI2wgaCETUZkcIJ/PP+EFJyti1wco3xGIq42NT+KjJsZP3v9CCQzULR050c1hF5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsMTggFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED721C4CEE1;
	Tue, 14 Jan 2025 11:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736855051;
	bh=+8d+h5vV43bpiCxou+p25uKwq1eaIa31N3Oxhs/tJIY=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=FsMTggFhDSTD+63eVQ/iBkjLRVRx0nahO38IS36KW2Vl5MBSyPs8pnIgS8HmQBWV8
	 xt3mTGPK3kuE951PUUZSE/um1XX+Q7kOayFaG4HMXJZ4NC2UeI5AL98R+I4D692bXS
	 4/ZnwmygkWnjAdr7s0iRo9hCtOrQnX3wpo3OzExnBoNTfou8SvTGCmNTNJ5Q7WuQwX
	 NJ4vz+wTSHJOm1cait/BD+lgyolFwDE4i9l+JAxZTPmxnMMb8REPFPWT8xqSsiKnj/
	 OWBVhGks9JR8We17hXad300bF5yGfXX0J3f3stUBRfEt8ZM3wTMc2Bs+mM9AIOPOty
	 2Q9lE9II+e5Qw==
From: Leon Romanovsky <leon@kernel.org>
To: zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org, 
 Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250110160927.55014-1-yanjun.zhu@linux.dev>
References: <20250110160927.55014-1-yanjun.zhu@linux.dev>
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix the warning
 "__rxe_cleanup+0x12c/0x170 [rdma_rxe]"
Message-Id: <173685504799.1202663.15209197429452789715.b4-ty@kernel.org>
Date: Tue, 14 Jan 2025 06:44:07 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Fri, 10 Jan 2025 17:09:27 +0100, Zhu Yanjun wrote:
> The Call Trace is as below:
> "
>   <TASK>
>   ? show_regs.cold+0x1a/0x1f
>   ? __rxe_cleanup+0x12c/0x170 [rdma_rxe]
>   ? __warn+0x84/0xd0
>   ? __rxe_cleanup+0x12c/0x170 [rdma_rxe]
>   ? report_bug+0x105/0x180
>   ? handle_bug+0x46/0x80
>   ? exc_invalid_op+0x19/0x70
>   ? asm_exc_invalid_op+0x1b/0x20
>   ? __rxe_cleanup+0x12c/0x170 [rdma_rxe]
>   ? __rxe_cleanup+0x124/0x170 [rdma_rxe]
>   rxe_destroy_qp.cold+0x24/0x29 [rdma_rxe]
>   ib_destroy_qp_user+0x118/0x190 [ib_core]
>   rdma_destroy_qp.cold+0x43/0x5e [rdma_cm]
>   rtrs_cq_qp_destroy.cold+0x1d/0x2b [rtrs_core]
>   rtrs_srv_close_work.cold+0x1b/0x31 [rtrs_server]
>   process_one_work+0x21d/0x3f0
>   worker_thread+0x4a/0x3c0
>   ? process_one_work+0x3f0/0x3f0
>   kthread+0xf0/0x120
>   ? kthread_complete_and_exit+0x20/0x20
>   ret_from_fork+0x22/0x30
>   </TASK>
> "
> When too many rdma resources are allocated, rxe needs more time to
> handle these rdma resources. Sometimes with the current timeout, rxe
> can not release the rdma resources correctly.
> 
> [...]

Applied, thanks!

[1/1] RDMA/rxe: Fix the warning "__rxe_cleanup+0x12c/0x170 [rdma_rxe]"
      https://git.kernel.org/rdma/rdma/c/edc4ef0e015409

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


