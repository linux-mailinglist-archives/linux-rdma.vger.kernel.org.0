Return-Path: <linux-rdma+bounces-14088-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AADC12D91
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 05:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9544E4E1604
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 04:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F7F28002B;
	Tue, 28 Oct 2025 04:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UT9oHdg0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2751D7E41
	for <linux-rdma@vger.kernel.org>; Tue, 28 Oct 2025 04:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761625187; cv=none; b=Rvp0pZeckd5V0SWifocCyrr1vM3Wl2p1SomDIPiQd04BanRAqSK199H+W37oO7etQWwezi+3VXlmUya5LZQdv+Cyghi13UVe//T0S48BM6a413BAs6PSDHNNZHKbU3rqDNLoQb8Sb788gz5xEsWOFjSZ9v2o/WraFj8BZSI7pbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761625187; c=relaxed/simple;
	bh=iRSlXKzB8RoOzgsX3K3wwNDlFXFB3aEVSYf1rq4v1rM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I5xCY0kN/lJJMCleFLnpr9NX+YZFFMg6VLdCWFvXmgd+UMqmZRH9dISxuuv3ykHvKf11ggcQrMFRHooAeRS4dJq8lzdaMv81sHFmt0dCO1c93ordlsBJEuuI8J9gOjtAZUIHS10wEzoTwDBDhSQXRkB/beCUIl0oGIPJa6ol2LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UT9oHdg0; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e95be1dc-3171-4178-a8e5-a392ef838a45@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761625183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uf0zzkBNHtySTkPwzFFQG1LHbYw+hWVsJabH2dbVfYQ=;
	b=UT9oHdg0+OIaGWtbpET/QZs/5qAgyWMqcoQwy0y4KumhSgQkUXjW0yLsSMymdZNZBvlRzl
	jhCGKTpuEMts0LLzi4EzCHc+llGD8qz4e3wn2Mp206GAZNXB65sif9oemsLsz999t0hWn8
	sc8EXReYhL8jgIMNg/vsuQb4ydQHBz0=
Date: Mon, 27 Oct 2025 21:19:37 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: fix null deref on srq->rq.queue after resize
 failure
To: Yi Liu <asatsuyu.liu@gmail.com>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <CANQ=Xi1JW2zFuYzNCw9Ft7WhseiHk4w1prYKmBc-Hbn1N32XNQ@mail.gmail.com>
 <20251027133053.GK12554@unreal>
 <eb232c55-1307-473e-8620-4e277f28be4a@linux.dev>
 <CANQ=Xi3KzyGiFvoD_sgsq3x8e6B-npN87vD3vAT4gZZo37sUJw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <CANQ=Xi3KzyGiFvoD_sgsq3x8e6B-npN87vD3vAT4gZZo37sUJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/10/27 19:31, Yi Liu 写道:
> Thanks for your kind help. I think the format issue comes from the
> Gmail Web Client. I did not send the email by "git send-email".

No worries ^_^. Let us wait for the further feedback.

Yanjun.Zhu

> 
> Yanjun.Zhu <yanjun.zhu@linux.dev> 于2025年10月28日周二 00:56写道：
>>
>>
>> On 10/27/25 6:30 AM, Leon Romanovsky wrote:
>>>> err_free:
>>>> - rxe_queue_cleanup(q);
>>>> - srq->rq.queue = NULL;
>>>> return err;
>>>> }
>>> This patch is badly formatted and doesn't apply.
>>
>>
>> Sorry. I will send a new patch very soon.
>>
>> Yanjun.Zhu
>>
>>
>>>
>>> Applying: RDMA/rxe: fix null deref on srq->rq.queue after resize failure
>>> Patch failed at 0001 RDMA/rxe: fix null deref on srq->rq.queue after resize failure
>>> error: git diff header lacks filename information when removing 1 leading pathname component (line 6)
>>> hint: Use 'git am --show-current-patch=diff' to see the failed patch
>>> hint: When you have resolved this problem, run "git am --continue".
>>> hint: If you prefer to skip this patch, run "git am --skip" instead.
>>> hint: To restore the original branch and stop patching, run "git am --abort".
>>> hint: Disable this message with "git config set advice.mergeConflict false"
>>> Press any key to continue...
>>>
>>>
>>>> --
>>>> 2.34.1


