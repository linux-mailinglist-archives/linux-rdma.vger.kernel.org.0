Return-Path: <linux-rdma+bounces-1622-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7938C88EF6C
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Mar 2024 20:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 233171F2B812
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Mar 2024 19:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDE6150983;
	Wed, 27 Mar 2024 19:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dCOmU7aA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4398142A83
	for <linux-rdma@vger.kernel.org>; Wed, 27 Mar 2024 19:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711568461; cv=none; b=Sv/+i1gREBB5csBf7QX6VQP6ed2dVZgApGggEgz5l5YqAgUw9YCkVZrTlLeFyDs2lFpo7UOT4a+pEXph+3iTXcLap4w10U8DHNd3qIx0m6daV8IOzHSPvQUzKthb6lBH5s9fB39n7fV7nhGMhIkdDMrenEEmnYIMfb/oS2tIaVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711568461; c=relaxed/simple;
	bh=MwOg+4HUcIj4cbcMWcHMrcAadYmSk8YZ+6mD+iPaE74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z315v8ZAbqwxOwmk9c1BshG1ymIe06B3xJBP9ZJ5HlC1Z4JwWwEmo+0+DXPNuVIGzX8mEvI8Cz9sRKhmrxV9H/z+iGhhT792nr74ni2DQMb5klEG/JLMx83xeHrU69ShENtmYqDS8VX+ZJLX3yjLZ5eaNSWjCvfylFHyAA5vfyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dCOmU7aA; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a9011ab4-6947-4ad4-8d1f-653e129c38b9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711568457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pYUCN+QyBF5g0mO969O8/lN/aFYNeMANeYvMkow3/g4=;
	b=dCOmU7aAK07TstdxBEFqDdTSnvJw6duXDkxM9JQD25kEJMoSr9VFtb47FmVTdwynIxZQrH
	d5+nH3DgdXfCwhHGKE+/bOBtstoNiW6Pi74vco/HYr+LylutIRHrEMFmbWCHYBPGJkicLa
	/TX1Bk1C8CDQRBuNA5XLVngh6Ya46LU=
Date: Wed, 27 Mar 2024 20:40:54 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/rxe: Make pr_fmt work
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org
References: <20240323083139.5484-1-yanjun.zhu@linux.dev>
 <20240327130804.GH8419@ziepe.ca>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240327130804.GH8419@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2024/3/27 14:08, Jason Gunthorpe 写道:
> On Sat, Mar 23, 2024 at 09:31:39AM +0100, Yanjun.Zhu wrote:
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> If the definition of pr_fmt is before the header file. The pr_fmt
>> will be overwritten by the header file. So move the definition of
>> pr_fmt to the below of the header file.
> what header file?

include/linux/printk.h

Because this driver will finally call printk function to output the 
logs, the header file include/linux/printk.h needs be included.

In include/linux/printk.h, pr_fmt is defined.

I made a simple checks. In about 130 header files, this pr_fmt is defined.

Zhu Yanjun

>
> Jason

