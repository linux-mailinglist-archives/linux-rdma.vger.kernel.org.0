Return-Path: <linux-rdma+bounces-881-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49605848C87
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Feb 2024 10:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3065B1C21064
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Feb 2024 09:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5376218B09;
	Sun,  4 Feb 2024 09:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXye3HoS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A55518AF4;
	Sun,  4 Feb 2024 09:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707039639; cv=none; b=NIJlIK/D4CFpeELuGek1yWjlOivrEwCrYxinxAL6Poq+qbO8WDb+dyAbbZWdaWlDqrcXEjgzec3MTsIqZ9p/Likwtqtq1VE3vmlVMEDuSZgIGTjOBHdJ3grt01LtlSeFq2QDrRjXWsNO5AN4WY49/I0DM7SzCNKEkCugRyxglwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707039639; c=relaxed/simple;
	bh=XVIPutM0BEFc5X+MBnaqKSTwT2JVwJjxPuPtgQ6Fq48=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YiNeKXqmh6N/39wd/7W7v2rM6K31bRUo/oLEuSvLwA2g9SOODvr141bTLGgtNOQaaQP7HynvvYZy1JXSMNjsQcuUXW2F/E9cdPI0SrTCmFQ7drrdbAWC0ZsLVhzqD1ohpKGEUf3++zmYID2/8pBJl85HvUMrkGJ8TiPhJnxfRTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXye3HoS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1944C433C7;
	Sun,  4 Feb 2024 09:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707039638;
	bh=XVIPutM0BEFc5X+MBnaqKSTwT2JVwJjxPuPtgQ6Fq48=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DXye3HoSL69zkNpyHSgEAFuaKoF+ra1gvhhstkhp77WppF2LrH0k7iqZ98Iz7MhPW
	 caLq5x0b2FX7x1Ck89Mc0qN8/sR01pF26VDtqN9ACbL37eIjfvIhQd6EKI42ToehtZ
	 FJc6NfAg02t/DpLwjuqxPNQXSiGY1vl7NEAgkdbIh8lZX3hY0jEn1gMEOxhluR2Jpk
	 pO1yEttu54BjijangXbE15WSbA8vrWwau0LxfLpfD5Qw7w+4TkzECHX7kZ6BwRchbp
	 e1bs86VlAZ1B/F8rG3WG8XUQAj9y2c/mp6L+TMP4oAV10Qi34R6EZ4tr/QOMFpAyJ5
	 rQSR90Zm+rCEw==
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 Patrick Kelsey <pat.kelsey@cornelisnetworks.com>,
 Brendan Cunningham <bcunningham@cornelisnetworks.com>,
 Daniel Vacek <neelx@redhat.com>
Cc: stable@vger.kernel.org, Mats Kronberg <kronberg@nsc.liu.se>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240201081009.1109442-1-neelx@redhat.com>
References: <20240126152125.869509-1-neelx@redhat.com>
 <20240201081009.1109442-1-neelx@redhat.com>
Subject:
 Re: [PATCH v2] IB/hfi1: Fix sdma.h tx->num_descs off-by-one error (take two)
Message-Id: <170703963443.16261.7348326025275862840.b4-ty@kernel.org>
Date: Sun, 04 Feb 2024 11:40:34 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d


On Thu, 01 Feb 2024 09:10:08 +0100, Daniel Vacek wrote:
> Unfortunately the commit `fd8958efe877` introduced another error
> causing the `descs` array to overflow. This reults in further crashes
> easily reproducible by `sendmsg` system call.
> 
> [ 1080.836473] general protection fault, probably for non-canonical address 0x400300015528b00a: 0000 [#1] PREEMPT SMP PTI
> [ 1080.869326] RIP: 0010:hfi1_ipoib_build_ib_tx_headers.constprop.0+0xe1/0x2b0 [hfi1]
> --
> [ 1080.974535] Call Trace:
> [ 1080.976990]  <TASK>
> [ 1081.021929]  hfi1_ipoib_send_dma_common+0x7a/0x2e0 [hfi1]
> [ 1081.027364]  hfi1_ipoib_send_dma_list+0x62/0x270 [hfi1]
> [ 1081.032633]  hfi1_ipoib_send+0x112/0x300 [hfi1]
> [ 1081.042001]  ipoib_start_xmit+0x2a9/0x2d0 [ib_ipoib]
> [ 1081.046978]  dev_hard_start_xmit+0xc4/0x210
> --
> [ 1081.148347]  __sys_sendmsg+0x59/0xa0
> 
> [...]

Applied, thanks!

[1/1] IB/hfi1: Fix sdma.h tx->num_descs off-by-one error (take two)
      https://git.kernel.org/rdma/rdma/c/be39e8dcb411fb

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

