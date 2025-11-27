Return-Path: <linux-rdma+bounces-14804-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 630BDC8E35A
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Nov 2025 13:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF1583B0752
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Nov 2025 12:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784A332E743;
	Thu, 27 Nov 2025 12:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbjjwRHk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0EB32B987;
	Thu, 27 Nov 2025 12:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764245418; cv=none; b=Rg9qJNtfPCNwBSzqWas4C6FUZUw7LLe6vu23SowV8QVqVzXqoXW2/HAobtA20hVAHhBEth/Br2NeEtnH86NpFCWXnAjgZTW6iTU9K75v9kKkP+tBOk4MazkSL5D8DedOQk8LpCJsZqBLdmmJnQCiwaK4zZo4w7vu8HswRR7dLAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764245418; c=relaxed/simple;
	bh=Tw8ZxnDtRksKWjLeoEr5RzNFz3CSj5Rza0zXH0X5J5M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=j+FTxr6aruk5RIgMtAMUXa1lyN8GHInYIYWqxyWoD7UQSBwQ45bGIu3mnurWDsdXtbEacmq+GU3VmGEXhJuH2btlGTqDnxlRrTu4rR3LzNKFDOEfdLtdZEDRkva59DOYNJi8Kvaquup8+dzFfCmGUqkdkaTHUYi9AOuqi3OrN1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbjjwRHk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED71C4CEF8;
	Thu, 27 Nov 2025 12:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764245417;
	bh=Tw8ZxnDtRksKWjLeoEr5RzNFz3CSj5Rza0zXH0X5J5M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dbjjwRHkGDr/xSfPV+oueR8C+iPyK0ofE2v34nPYeEkigq+An5mE52EZncusXmWke
	 pKpbHiVfke2kKhb9NkQ4u9KNB6PsFPDhQ8LOAJExIO6/JlIeXoQ8IO/9iUPwKlQs34
	 2aSZqAGy/zbPFJNQq0bkR1F2W2IKrQhmanXcrS28zDqmPw3L/qM2wsbwdvyC3q+qDC
	 2FftQMSslX1pNYY5TqubWnyF/FtiPdT+ZGYL5TmZoeaXRoks8rSrepkqqlPthkjB04
	 RxUPF1AGQBnKD0pf34V35CiL4x0DkRWJVC8AjO8aq6GLHXrYEsQ5GSain6TgDjCJ38
	 DOxaEV6JgmMzg==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Stefan Metzmacher <metze@samba.org>
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>, Zhu Yanjun <yanjun.zhu@linux.dev>, 
 Jason Gunthorpe <jgg@ziepe.ca>, netdev@vger.kernel.org, 
 linux-cifs@vger.kernel.org
In-Reply-To: <20251127105614.2040922-1-metze@samba.org>
References: <20251127105614.2040922-1-metze@samba.org>
Subject: Re: [PATCH v3] RDMA/rxe: reclassify sockets in order to avoid
 false positives from lockdep
Message-Id: <176424541467.1853134.8527838747212328732.b4-ty@kernel.org>
Date: Thu, 27 Nov 2025 07:10:14 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Thu, 27 Nov 2025 11:56:14 +0100, Stefan Metzmacher wrote:
> While developing IPPROTO_SMBDIRECT support for the code
> under fs/smb/common/smbdirect [1], I noticed false positives like this:
> 
> [+0,003927] ============================================
> [+0,000532] WARNING: possible recursive locking detected
> [+0,000611] 6.18.0-rc5-metze-kasan-lockdep.02+ #1 Tainted: G           OE
> [+0,000835] --------------------------------------------
> [+0,000729] ksmbd:r5445/3609 is trying to acquire lock:
> [+0,000709] ffff88800b9570f8 (k-sk_lock-AF_INET){+.+.}-{0:0},
>                               at: inet_shutdown+0x52/0x360
> [+0,000831]
>             but task is already holding lock:
> [+0,000684] ffff88800654af78 (k-sk_lock-AF_INET){+.+.}-{0:0},
>                            at: smbdirect_sk_close+0x122/0x790 [smbdirect]
> [+0,000928]
>             other info that might help us debug this:
> [+0,005552]  Possible unsafe locking scenario:
> 
> [...]

Applied, thanks!

[1/1] RDMA/rxe: reclassify sockets in order to avoid false positives from lockdep
      https://git.kernel.org/rdma/rdma/c/80a85a771deb11

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


