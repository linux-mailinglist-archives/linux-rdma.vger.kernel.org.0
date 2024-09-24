Return-Path: <linux-rdma+bounces-5054-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25068983B09
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2024 03:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D680C28399E
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2024 01:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83F08F49;
	Tue, 24 Sep 2024 01:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B85pK1Tx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41A01FDD
	for <linux-rdma@vger.kernel.org>; Tue, 24 Sep 2024 01:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727143127; cv=none; b=LG2gvCFEKhHZ4gKWrSZGFCjiprsoTKczCblAat2Pd+C2x4/yfF6H/WjRCqEqL0CaFEF3U0Pfxwh20XpFAgoLTjePpuJ7b6K7CoqJdoJPZuks8p662tfuezeCi4qC8oD43aTcLiVwdRHh6tfmWiRdIZfN6XmU3agYw/w+usimcZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727143127; c=relaxed/simple;
	bh=Bvvbr82BUOqaocs151EGz+NeKXtCqR/shoO2XUdsvX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JbzUqdEMsC6iDhFaUBgkfLL6dhy3Ef0ldZTBcDpXaPoxBGVsVs5F3RX69GUmTb4/M1wBdQLPENjy7mk23zKRHGTqTo9Cff7M+RxVp4dHwZT8+2qQ41TqOypWbk9gnkzn6bsg79rBlQP38aoGDezgVG0LTpI2tMpB0wz++FgZRAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B85pK1Tx; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <aea6b986-2d25-4ebc-93e8-05da9c6f3ba2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727143123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hEUpKDREzGiwRzUbS3PVtjvTd4SSCyBo8UFMX+xQnhw=;
	b=B85pK1Tx//1KtcoEKGHBaF+Ff0eMVKeAVaFvwjWrOH2Ani+wnnsKHdPJ5zO8nd/CLS0PPc
	7apUw5nGoHwS8EE1Dqqd/aB/Ipu6lMgNMYfDL9ktSfLVV7Hn2So65vDpd/Dx3VD7zuYLMO
	yBAGG6O/yNcNf3iBK7N1c5r85V1ZoqM=
Date: Tue, 24 Sep 2024 09:58:24 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [MAINLINE 0/2] Enable DIM for legacy ULPs and use it in RDS
To: Christoph Hellwig <hch@infradead.org>
Cc: Haakon Bugge <haakon.bugge@oracle.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>,
 Allison Henderson <allison.henderson@oracle.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 OFED mailing list <linux-rdma@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>
References: <20240918083552.77531-1-haakon.bugge@oracle.com>
 <Zuwyf0N_6E6Alx-H@infradead.org>
 <C00EA178-ED20-4D56-B6F2-200AC72F3A39@oracle.com>
 <Zu191hsvJmvBlJ4J@infradead.org>
 <525e9a31-31ee-4acf-a25c-8bf3a617283f@linux.dev>
 <ZvFY_4mCGq2upmFl@infradead.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <ZvFY_4mCGq2upmFl@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/9/23 20:03, Christoph Hellwig 写道:
> On Sat, Sep 21, 2024 at 10:28:48AM +0800, Zhu Yanjun wrote:
>> 在 2024/9/20 21:51, Christoph Hellwig 写道:
>>> On Fri, Sep 20, 2024 at 09:46:06AM +0000, Haakon Bugge wrote:
>>>>> I would much prefer if you could move RDS off that horrible API finally
>>>>> instead of investing more effort into it and making it more complicated.
>>>>
>>>> ib_alloc_cq() and family does not support arming the CQ with the IB_CQ_SOLICITED flag, which RDS uses.
>>>
>>> Then work on supporting it.  RDS and SMC are the only users, so one
>>
>> Some other open source projects are also the users.
> 
> I'm not sure what you mean with "open source projects", but the only
> thing that matters is users in the kernel tree.

The users that I mentioned is not in the kernel tree.

Best Regards,
Zhu Yanjun
> 


