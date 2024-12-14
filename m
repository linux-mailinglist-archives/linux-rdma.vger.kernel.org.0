Return-Path: <linux-rdma+bounces-6520-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3B19F1DD8
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Dec 2024 10:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D3FF188C2CD
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Dec 2024 09:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B403614F9CF;
	Sat, 14 Dec 2024 09:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o4XRTfAF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C2113BAE3
	for <linux-rdma@vger.kernel.org>; Sat, 14 Dec 2024 09:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734169001; cv=none; b=UR+m0USjjtoy8fl+ifetwNiM/xIfgc+XVQWHReFppiqylBnroBE49V/2QcZSdiDIQWP3o8nIF7G4eAOE0DABZI0wILF2DZeljBwS7qSRFAwr09/pknhUPmIFBtKIIJfL2FQNzapZk95KpbPLNDWH3gONDKDNUKPbDnNVGf5cyVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734169001; c=relaxed/simple;
	bh=i4CWwhN+NcKOcP2B4Nxl+pZ2TvYe56stMwLMNjEAAgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ItKr/BRQCVs0+8HUcMd5Z1ONDHtd6ZD75uqKG9Urk8K6FPULii9MgkoTaMxu2s7v429pY7xS/HHVqS7//SRSX7oBuFr9vQvQ/0WOxxRBY3p/TJMgE5c/GEdzbjdKVREryC7nzI2J/pnuyw+qRGu8s3nmpOw5x8heVMhXvxy4IR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o4XRTfAF; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3678e5fd-8441-4cb3-a5db-a7a0954732c6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734168996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6pmNGRxTDxjiPW7iWhUyGrdFX5BzrcEt0Ubfqr/8RSk=;
	b=o4XRTfAFrZxYGv98m7fdgpKsRPF7X0P5YEO8Tut3W01ACrNXqUk51H8ktXgUwZn4bCW1OF
	PsktxJ2MvVYibrOZqHjQgCKkzGxCUcP0FvifqrfBZ7cDbuyvIE/uO2HfHzGwJb8/e5fPix
	zSOnGjxbu1R64md00uO9T1td+z6CM2U=
Date: Sat, 14 Dec 2024 10:36:31 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: workqueue: WQ_MEM_RECLAIM nvmet-wq:nvmet_rdma_release_queue_work
 [nvmet_rdma] is flushing !WQ_MEM_RECLAIM irdma-cleanup-wq:irdma_flush_worker
 [irdma]
To: Honggang LI <honggangli@163.com>,
 "Ismail, Mustafa" <mustafa.ismail@intel.com>
Cc: linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org
References: <Z1wBEgluXUDrDJmN@fc39>
 <d6067519-26ab-4851-ba58-3ebe254e88d1@linux.dev>
 <0d0ee443-a903-406e-9bec-b02b1391b7d0@linux.dev> <Z1zswha52zdJcEXp@fc39>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <Z1zswha52zdJcEXp@fc39>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/12/14 3:26, Honggang LI 写道:
> On Fri, Dec 13, 2024 at 08:30:01PM +0100, Zhu Yanjun wrote:
>> I delved into this problem. It seems that it is a known problem.
>> Can you apply the following to make tests again?
>>
>> diff --git a/drivers/infiniband/hw/irdma/hw.c
>> b/drivers/infiniband/hw/irdma/hw.c
>> index ad50b77282f8..31501ff9f282 100644
>> --- a/drivers/infiniband/hw/irdma/hw.c
>> +++ b/drivers/infiniband/hw/irdma/hw.c
>> @@ -1872,7 +1872,7 @@ int irdma_rt_init_hw(struct irdma_device *iwdev,
>>                   * free cq bufs
>>                   */
>>                  iwdev->cleanup_wq = alloc_workqueue("irdma-cleanup-wq",
>> -                                       WQ_UNBOUND, WQ_UNBOUND_MAX_ACTIVE);
>> +                                       WQ_UNBOUND|WQ_MEM_RECLAIM,
> 
> After add flag WQ_MEM_RECLAIM, the warning message is gone. However,
> it may raise similar issue fixed by commit 2cc7d150550 again.
> 
> thanks
> 
> commit 2cc7d150550cc981aceedf008f5459193282425c
> Author: Sindhu Devale <sindhu.devale@intel.com>
> Date:   Tue Apr 23 11:27:17 2024 -0700
> 
>      i40e: Do not use WQ_MEM_RECLAIM flag for workqueue

I read the commit log carefully. If I understand the commit log 
correctly, the flag WQ_MEM_RECLAIM is used in i40e while it is
not used in i40iw.
The fix is to remove the flag WQ_MEM_RECLAIM from i40e.

"
     Issue reported by customer during SRIOV testing, call trace:
     When both i40e and the i40iw driver are loaded, a warning
     in check_flush_dependency is being triggered. This seems
     to be because of the i40e driver workqueue is allocated with
     the WQ_MEM_RECLAIM flag, and the i40iw one is not.

     Similar error was encountered on ice too and it was fixed by
     removing the flag. Do the same for i40e too.
"
I do not have E810 device and i40e device and can not read the issue 
reported by customer during SRIOV testing.
Thus, let Intel engineers continue to handle this problem.
@Mustafa Ismail

Zhu Yanjun

> 


