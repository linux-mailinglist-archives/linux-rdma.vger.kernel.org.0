Return-Path: <linux-rdma+bounces-1041-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE57859CCA
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Feb 2024 08:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E17EB21BF6
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Feb 2024 07:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A064420B21;
	Mon, 19 Feb 2024 07:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlN8+aqb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F9520B04;
	Mon, 19 Feb 2024 07:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708327491; cv=none; b=tHqX41NNKzU9HT3ABz+QgrMYqb7cxk5mbI8yio4TffOvZ//sEesnK8zYfAHd4b0enOlZWTU07VDch4Cp2xf7Kd7gQ6IwNEfVYhoCL6bo1fV014JPUi5JEjxxLGSDDzpePiS4nK7G9Ch0ixjLMX9CCUZHWtwsVDw61XJdXvaesSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708327491; c=relaxed/simple;
	bh=pANYziPkYN/b41sQKhnbiBZpozUbx6Wr+HoOttPlSj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZ+YsYWsg8tff/bnQ/+m7x4DS5v0mpm74hCGeQRwjTUuwFoNTJa70PJgEGzD9ljb+CkSF3PCDRAetJXiwbqegfXmP8/VKsg+hY7/5Xwwr8KZcUNi7LBipweQl0BrynXbxbFeYMowYK9LqonNEBvsbuv68XKtzmhPmwg1UofS89A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlN8+aqb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427D2C433F1;
	Mon, 19 Feb 2024 07:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708327490;
	bh=pANYziPkYN/b41sQKhnbiBZpozUbx6Wr+HoOttPlSj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rlN8+aqbEZYGeDZsH7bDpcuaZpeBdWXwBLzEp7k8FF7bvJSF7Z/9yjvmw+gRSx3y7
	 Bo/KuI279uE9yt6ymu9PougfSn4NE15jJr7KmEpPz3cGoTR0v4iQS3Ao13gTjLg7Ds
	 ubc3naEDqfbSIKI09IFHIYQ2N2KMtZjjbd2XgzZLyify2/k7DjUF3m0HJwOiqtrNZI
	 cOej7DEGKNIFiQ+q/UYM48HcmA5AZvikWZUmWYso+9WFs+0wqIdl/pDVStC3bwBDGb
	 szBpYboaRNHkMz5h0ucrNjimK/mzgAfkeKBLCts773kLK4fkTLsR+3U9B4nPmerAVw
	 8N8E8+NabSonA==
Date: Mon, 19 Feb 2024 09:24:45 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Bernard Metzler <bmt@zurich.ibm.com>
Cc: jgg@ziepe.ca, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	syzbot+e7c51d3be3a5ddfa0d7a@syzkaller.appspotmail.com
Subject: Re: [PATCH] RDMA/siw: Fix handling netdev going down event
Message-ID: <20240219072445.GA14258@unreal>
References: <20240215115524.126477-1-bmt@zurich.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215115524.126477-1-bmt@zurich.ibm.com>

On Thu, Feb 15, 2024 at 12:55:24PM +0100, Bernard Metzler wrote:
> siw uses the NETDEV_GOING_DOWN event to schedule work which
> gracefully clears all related siw devices connections. This
> fix avoids re-initiating and re-scheduling this work if still
> pending from a previous invocation.
> 
> Fixes: bdcf26bf9b3a ("rdma/siw: network and RDMA core interface")
> Reported-by: syzbot+e7c51d3be3a5ddfa0d7a@syzkaller.appspotmail.com
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/sw/siw/siw_main.c | 56 ++++++++++++++--------------
>  1 file changed, 28 insertions(+), 28 deletions(-)

It doesn't apply. I still think that you should simply delete this NETDEV_GOING_DOWN event.

Thanks

Grabbing thread from lore.kernel.org/all/20240215115524.126477-1-bmt%40zurich.ibm.com/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 1 messages in the thread
Checking attestation on all messages, may take a moment...
---
  [PATCH] RDMA/siw: Fix handling netdev going down event
    + Link: https://lore.kernel.org/r/20240215115524.126477-1-bmt@zurich.ibm.com
    + Signed-off-by: Leon Romanovsky <leon@kernel.org>
  ---
  NOTE: install dkimpy for DKIM signature verification
---
Total patches: 1
---
Applying: RDMA/siw: Fix handling netdev going down event
Patch failed at 0001 RDMA/siw: Fix handling netdev going down event
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
error: patch failed: drivers/infiniband/sw/siw/siw_main.c:276
error: drivers/infiniband/sw/siw/siw_main.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch

Thanks

