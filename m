Return-Path: <linux-rdma+bounces-2166-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC25A8B77BA
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 15:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 974BB28165C
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 13:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C74172BAC;
	Tue, 30 Apr 2024 13:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QPIll1BR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926A3172BA5
	for <linux-rdma@vger.kernel.org>; Tue, 30 Apr 2024 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485511; cv=none; b=SZaPkNQuD75uAcHQ4B0NoFhK10IJpcuTjYteTavIu+Q6BkrcnniqP0dCTkrZwf+cV/3P4LiCZa3tGxa+XufBzaphkec9ev6Pu3UZ7wa5FayAW6Z/fQeKm6O1I6CFoNkAOXzqE+d51ClfTuQm5ijAVNlJlMSFMCWuJs8CjYU/9QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485511; c=relaxed/simple;
	bh=Q7DztjgnnS2dKaOJFO8saO6Zu9czk7JFRZs24thNvU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T+TRDZfbxlTPOHPOc1C5S/mODC+1lwRnkCbGVgp51D5FFPy0TSXbH2ph0iTQOcNpa2ZJA4IUgdyiXpGdUnBflfRRxz/qKlfNcziaJSR3OyYqex6ij3QqcN0/AFjxznGjpOZVCJoe/ZD7pk64QUtCa6Ya8QKFinXTQya4vYbqR38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QPIll1BR; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f49907ea-cedc-44b7-9ffc-30c265731f3e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714485507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QvfwCJ+RgLeRC4X/8MiA5B3A6uRx1S5K79NhE6HyKs8=;
	b=QPIll1BRqFjc4AOsZW4wL+aTiBs6j8I7Ts/OtWPrtlxTTehUIku2ajrq0Sc4egVfrSV409
	AGlDTHE+w4ydCkYuVGtQ9pJYBkK5afdmBt3qLrFZUbI4lwb2WW/AJH3Jd3FHuAIASfWlP8
	ek78TYOXqYgggp2ZVI1K5YGsEtzad0U=
Date: Tue, 30 Apr 2024 15:58:23 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 0/4] NFS: Fix another 'check_flush_dependency' splat
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Chuck Lever <cel@kernel.org>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20240429152537.212958-6-cel@kernel.org>
 <efc4f895-3a45-4b44-a47d-532896526458@linux.dev>
 <90F6A893-5315-4E53-B54E-1CF8D7D4AC4D@oracle.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <90F6A893-5315-4E53-B54E-1CF8D7D4AC4D@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 30.04.24 15:42, Chuck Lever III wrote:
>
>> On Apr 30, 2024, at 3:26 AM, Zhu Yanjun <zyjzyj2000@gmail.com> wrote:
>>
>> On 29.04.24 17:25, cel@kernel.org wrote:
>>> From: Chuck Lever <chuck.lever@oracle.com>
>>> Avoid getting work queue splats in the system journal by moving
>>> client-side RPC/RDMA transport tear-down into a background process.
>>> I've done some testing of this series, now looking for review
>>> comments.
>> How to make tests with nfs && rdma? Can you provide some steps or tools?
> We are building NFS tests into kdevops:
>
>     https://github.com/linux-kdevops/kdevops.git
>
> and there is a config option to use soft iWARP instead of TCP.

Thanks a lot. It is interesting. Have you made tests with RXE instead of 
iWARP?

If yes, does nfs work well with RXE? I am just curious with nfs && RXE.

Normally nfs works with TCP. Now nfs will use RDMA instead of TCP.

The popular RDMA implementation is RoCEv2 which is based on UDP protocol.

So I am curious if NFS can work well with RXE (RoCEv2 emulation driver) 
or not.

If the user wants to use nfs in his production hosts, it is possible 
that nfs will work with RoCEv2 (UDP).

Best Regards,

Zhu Yanjun

>
> kdevops includes workflows for fstests, Mora's nfstest, the
> git regression suite, and ltp, all of which we use regularly
> to test the Linux NFS client and server implementations.
>
>
>> I am interested in nfs && rdma.
>>
>> Thanks,
>> Zhu Yanjun
>>
>>> Chuck Lever (4):
>>>    xprtrdma: Remove temp allocation of rpcrdma_rep objects
>>>    xprtrdma: Clean up synopsis of frwr_mr_unmap()
>>>    xprtrdma: Delay releasing connection hardware resources
>>>    xprtrdma: Move MRs to struct rpcrdma_ep
>>>   net/sunrpc/xprtrdma/frwr_ops.c  |  13 ++-
>>>   net/sunrpc/xprtrdma/rpc_rdma.c  |   3 +-
>>>   net/sunrpc/xprtrdma/transport.c |  20 +++-
>>>   net/sunrpc/xprtrdma/verbs.c     | 173 ++++++++++++++++----------------
>>>   net/sunrpc/xprtrdma/xprt_rdma.h |  21 ++--
>>>   5 files changed, 125 insertions(+), 105 deletions(-)
>>> base-commit: e67572cd2204894179d89bd7b984072f19313b03
> --
> Chuck Lever
>
>
-- 
Best Regards,
Yanjun.Zhu


