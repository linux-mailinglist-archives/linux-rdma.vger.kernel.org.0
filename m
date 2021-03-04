Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68ECC32CE65
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Mar 2021 09:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236697AbhCDI1J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Mar 2021 03:27:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:50336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236695AbhCDI0n (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 4 Mar 2021 03:26:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 019D964EFC;
        Thu,  4 Mar 2021 08:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614846362;
        bh=X75+5RSnLyotDaJHoI89vGtE5h8+oX1tKzuCJDfBkVM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YOw3+UBOD1S+GjamRV6YpfE38w5j4lldKZRaRbqstXhbarPIL1iQpcERuBB7Vzv1U
         bp/bt/DpX75pgjMkD4DEnLNGS18du2EExYgwXdOYBDDeXD2GyIsuH04HyqMZA1GthM
         oG2RXpf/WnYEPCO/xFPhoQ2m4GVbpQSQPIvwAght8aquVpqo8jChXzjtiBHMSdPR74
         6r+ni6tLxwodked9WinBgFzTB9oB/FTrWlSCYvHDrRHKpM5VqFEqtmYE/KKq8DIxZy
         jBkMAVUYa95K2pyUYPVAu7zlPPBP36naRbewh+kTuxo7NfnyXSUNb/J/q7RyTXUqlZ
         3dsCzkR7BAygA==
Date:   Thu, 4 Mar 2021 10:25:58 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next v2] RDMA/rxe: Fix ib_device reference counting
 (again)
Message-ID: <YECZls7fdfpIkLxi@unreal>
References: <20210303225628.2836-1-rpearson@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210303225628.2836-1-rpearson@hpe.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 03, 2021 at 04:56:29PM -0600, Bob Pearson wrote:
> Three errors occurred in the fix referenced below.
>
> 1) rxe_rcv_mcast_pkt() dropped a reference to ib_device when
> no error occured causing an underflow on the reference counter.
> This code is cleaned up to be clearer and easier to read.
>
> 2) Extending the reference taken by rxe_get_dev_from_net() in
> rxe_udp_encap_recv() until each skb is freed was not matched by
> a reference in the loopback path resulting in underflows.
>
> 3) In rxe_comp.c the function free_pkt() did not clear skb which
> triggered a warning at done: and could possibly at exit: in
> rxe_completer(). The WARN_ONCE() calls are not actually needed.
>
> This patch fixes these errors.
>
> Fixes: 899aba891cab ("RDMA/rxe: Fix FIXME in rxe_udp_encap_recv()")
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
> Version 2:
> v1 of this patch incorrectly added a WARN_ON_ONCE in rxe_completer
> where it could be triggered for normal traffic. This version
> replaced that with a pr_warn located correctly.
>
> v1 of this patch placed a call to kfree_skb in an if statement
> that could trigger style warnings. This version cleans that up.
>
>  drivers/infiniband/sw/rxe/rxe_comp.c |  6 +--
>  drivers/infiniband/sw/rxe/rxe_net.c  | 10 ++++-
>  drivers/infiniband/sw/rxe/rxe_recv.c | 60 +++++++++++++++++-----------
>  3 files changed, 48 insertions(+), 28 deletions(-)

➜  kernel git:(rdma-next) mkt ci
ff130e1dc197 (HEAD -> build) RDMA/rxe: Fix ib_device reference counting (again)
WARNING: 'occured' may be misspelled - perhaps 'occurred'?
#9:
no error occured causing an underflow on the reference counter.
         ^^^^^^^

WARNING: Prefer 'fallthrough;' over fallthrough comment
#182: FILE: drivers/infiniband/sw/rxe/rxe_recv.c:308:
+	/* Fall through to drop packet

WARNING: From:/Signed-off-by: email address mismatch: 'From: Bob Pearson <rpearsonhpe@gmail.com>' != 'Signed-off-by: Bob Pearson <rpearson@hpe.com>'
