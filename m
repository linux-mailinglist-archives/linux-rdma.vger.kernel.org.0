Return-Path: <linux-rdma+bounces-14071-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFEBC0F7B2
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Oct 2025 17:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C2DB18975CA
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Oct 2025 16:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F67314A74;
	Mon, 27 Oct 2025 16:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HqUXBuu3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A669313526
	for <linux-rdma@vger.kernel.org>; Mon, 27 Oct 2025 16:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761584186; cv=none; b=r2JcUvz9MfQ/cPlbMXjVIZqfqnAUbQuu5x9NIPBv8XGEJRwbeeoiyw7WWZCk/3qYOPWZcHTBwlWusH9MmdWiYPf+5sJa590FpuOFJ7m0KjL3rdFU4eUzJD+mTq14qf4yB1ulrxlZOi5/iQfFwNCgo3LLgbHqMVNQAWM626R0YB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761584186; c=relaxed/simple;
	bh=Ie7c6DF4fl3lZ29qfialoRUzhUM/Lp+31J96nETq4ec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dDY5Jn6RpPNZlZNYufr62LW3IO4mMcILYEbq1rXdZVkq60vnAnMJOEAAubVtvXxfwgyfmWu3o8BeoKi17+lrAB0nLpoGgF7+Cf8DaECJzNF7n0eYE8Qc37JU9N1f/Ieu+jfbtA5CXnTpTaECfWBiYINHjYcR11Y94YU10FfaiuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HqUXBuu3; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <eb232c55-1307-473e-8620-4e277f28be4a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761584182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ie7c6DF4fl3lZ29qfialoRUzhUM/Lp+31J96nETq4ec=;
	b=HqUXBuu3zgTZ1IZ5TxX4R1r0SfC3UoVTwxth5TVDYF+I5qTNVHY6QuzRIbRqYtgLLHKMH+
	v8Zmn/GarmGPpso+wYzw9F47oSduk9sRepwvEsjI7C4DF3J9JS/oo3COpiSpZZ/BYbGmR1
	CUrcsoo2FUOn1FAuKLwW63P9xSmY+2Q=
Date: Mon, 27 Oct 2025 09:56:18 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: fix null deref on srq->rq.queue after resize
 failure
To: Leon Romanovsky <leon@kernel.org>, Yi Liu <asatsuyu.liu@gmail.com>
Cc: linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <CANQ=Xi1JW2zFuYzNCw9Ft7WhseiHk4w1prYKmBc-Hbn1N32XNQ@mail.gmail.com>
 <20251027133053.GK12554@unreal>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20251027133053.GK12554@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 10/27/25 6:30 AM, Leon Romanovsky wrote:
>> err_free:
>> - rxe_queue_cleanup(q);
>> - srq->rq.queue = NULL;
>> return err;
>> }
> This patch is badly formatted and doesn't apply.


Sorry. I will send a new patch very soon.

Yanjun.Zhu


>
> Applying: RDMA/rxe: fix null deref on srq->rq.queue after resize failure
> Patch failed at 0001 RDMA/rxe: fix null deref on srq->rq.queue after resize failure
> error: git diff header lacks filename information when removing 1 leading pathname component (line 6)
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abort".
> hint: Disable this message with "git config set advice.mergeConflict false"
> Press any key to continue...
>
>
>> --
>> 2.34.1

