Return-Path: <linux-rdma+bounces-6602-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5B29F4DF4
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 15:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E80181893A54
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2024 14:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC701F5411;
	Tue, 17 Dec 2024 14:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjPA1ySL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D632AEE0;
	Tue, 17 Dec 2024 14:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734446226; cv=none; b=Z9RPiWsKX5XHuA+wxFSRT3Dz1rNyJyscybSV9MHtEUavn11c1m079ryk9f2X0gs7QGtmbA8LSwmSTtCSGapm9wS/sui5NcYIrvZA7dNooiDDlryHsupVKFPZHeiMKxebt+BuQR//JnORTeOzWXKk1/Rkn09s/q5fFrP+U2fvOys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734446226; c=relaxed/simple;
	bh=jGtWbxTmL7Pwmi5w41bc22tc0yqa05JrUTHvE832sLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTdQQxPpVTQERskNZ6Ok29t9p9lh8uWS4fXLFo9FMaNa3/1TDiZmq6n6/R5L+uIqNdHPTR4pL9XPR5qfpbaeOJkEDj5YJ2rlNF4GBrv/yhsoTxrR4rR3AWMT5y0u8rGkgykbF5Z/aoQKki7XjV0mdexmnxAN/s1rVx9JN7ndP78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjPA1ySL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 163CCC4CED3;
	Tue, 17 Dec 2024 14:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734446224;
	bh=jGtWbxTmL7Pwmi5w41bc22tc0yqa05JrUTHvE832sLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RjPA1ySL0xeIUEYbYSiHLXXPvZKhMbr5Jh9z3Qs9M1CogHM77oXDaxMFbfo4N7LwW
	 MD7DhXs2rZH0wT60W6uby7GDAYFB8m4/OqtS0S03eryWSm4RE+lEa8yFbUp1LogUTH
	 RaYKWdijIcVw3otKKl6J3ITzj7cY4gqhYlBgc4jZGK+7kApHrgbAbJlFjnu3Fa3utz
	 NCMpSew819d4qn2gXXXlqrklYsGvQZQytis5QRQKFr/NZp7uYXR8F+4WVK/+HJSUAe
	 wsyOS7RLExF5oTf9r5N0UpigIahy7qDDTKNlVik2nK17q6bTD64ovtZ8Jhn8HwuMx9
	 0qzdy+2Q7+e7g==
Date: Tue, 17 Dec 2024 16:37:00 +0200
From: Leon Romanovsky <leon@kernel.org>
To: zhenwei pi <pizhenwei@bytedance.com>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, jgg@ziepe.ca, zyjzyj2000@gmail.com,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] RDMA/rxe: Fix mismatched max_msg_sz
Message-ID: <20241217143700.GL1245331@unreal>
References: <20241216121953.765331-1-pizhenwei@bytedance.com>
 <affab92f-9a5b-481a-8816-8d5560721648@linux.dev>
 <9e833b88-4efe-48eb-a605-984f5ab7f49f@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e833b88-4efe-48eb-a605-984f5ab7f49f@bytedance.com>

On Tue, Dec 17, 2024 at 11:37:45AM +0800, zhenwei pi wrote:
> 
> 
> On 12/17/24 00:47, Zhu Yanjun wrote:
> > 在 2024/12/16 13:19, zhenwei pi 写道:
> > > User mode queries max_msg_sz as 0x800000 by command 'ibv_devinfo -v',
> > > however ibv_post_send/ibv_post_recv has a limit of 2^31. Fix this
> > > mismatched information.
> > > 
> > 
> > This is a buf fix. Perhaps Fixes tag is needed?
> > 
> 
> Hi,
> 
> Please amend this on applying patch:
> Fixes: f605f26ea196 ("RDMA/rxe: Protect QP state with qp->state_lock")
> Fixes: 5bf944f24129 ("RDMA/rxe: Add error messages")
> 
> If v2 is needed, please let me know.

There is no need, I added them manually.

Thanks

