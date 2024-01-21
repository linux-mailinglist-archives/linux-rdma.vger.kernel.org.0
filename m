Return-Path: <linux-rdma+bounces-669-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE89A8358C7
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jan 2024 00:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C537B21934
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jan 2024 23:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F09C3613F;
	Sun, 21 Jan 2024 23:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jW0n+iTK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480011E4B3
	for <linux-rdma@vger.kernel.org>; Sun, 21 Jan 2024 23:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705880265; cv=none; b=Pl5w098IVFWXDTS9scOt92pZoFbqxjlxOLsvS/jEct5WXrb9AEdQ+XcX+f475oLk3QyPbi/JKljea69QrfTg5mxIUUIgEx7I00K+4BzrMuFbdLI+K0OCgHnPHSPkv+m7bFXaaNlnYMEu0jYJTyHIJXMsOL2GnysAoRjzEJbLR2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705880265; c=relaxed/simple;
	bh=4YhJsjqcOeaMGCr7onsuoiW00P4m+JCjEM+hR314eLQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=ZTH7eLGoaelS3OEnmmHtaLl3rKI9jbu3sTN0DQsc5dkcOesblLiOKhNtVlKqTytKL07Q3v8AbBmWlCtXt1M4WHCtCChgVt9MFO4eFgpB6NI6/F1NpuZ6prbyGy/0A6/Og/DFEKvvbPgB7Ty9c4CSkoQurZWKbhQMlxLHnMH6BVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jW0n+iTK; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ad08f992-7636-44e6-914b-f467fd7ceb61@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705880261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nP5OXoKc4vFPVZvS6YwlzxXO78ZBU6//ACmMqGRtato=;
	b=jW0n+iTKyfeuDcY+TFiSfv0FsA8tSNJaeS/2r5QBTwiLwCcj87E9GxrWwLhB27qKLElXVb
	NuMKqGL36wiOwAgdHgMJDAX9SXwFn3JnZNAMoh4tut4pGFmhxGpgrLsQXiGgs/Xbr/pu3m
	OKYg5RkPOxbLN8qHtRHm+oM2HsrzaI4=
Date: Mon, 22 Jan 2024 07:37:37 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Questions about RDMA subsystem shared mode for RoCE device with
 MLNX_OFED driver
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: =?UTF-8?B?6ZmI6YC45Yeh?= <neverhook430@gmail.com>,
 linux-rdma@vger.kernel.org
References: <CAAoLqsQ-iHo4YwsHyt6MkBKE20Ze=DF4kkFKkDX9QCDiDC2+oQ@mail.gmail.com>
 <6edfa3cc-6ec1-49d0-817b-59239c1e669c@linux.dev>
In-Reply-To: <6edfa3cc-6ec1-49d0-817b-59239c1e669c@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2024/1/21 16:51, Zhu Yanjun 写道:
> 在 2024/1/19 20:31, 陈逸凡 写道:
>> Questions:
>> 1. Is RDMA shared mode supported for RoCE/iWARP devices? To be more
>> clearly, ibdev ant netdev required to be in the same net namespace or
>> not?
> 
> RoCE/RXE + the following commits can support ibdev in the net namespace.
> 
> https://patchwork.kernel.org/project/linux-rdma/cover/20230508075636.352138-1-yanjun.zhu@intel.com/
> 
> Current implementation of RXE does not support net namespace. We need 
> the above commits to support net namespace.
> 
> IMO, the current implementation of iWARP does not support net namespace, 
> too.

Sorry. I misunderstand what you mean in your mail. Please ignore this mail.

Zhu Yanjun

> 
> Zhu Yanjun
> 
>> 2. If the answer for first question is ‘YES’, but my test failed with
>> MLNX_OFED driver, it does check whether user can access the netdev of
>> the target gid attr, which means they(user and the netdev) should be
>> at the same namespace. Meanwhile the upstream code dose not have the
>> corresponding codes.
>>
>>
>> MLNX_OFED impl，form mlnx-ofa_kernel-23.10，compared to the upstream 
>> codes
>> ---
>> @@ -1722,6 +1739,9 @@ static int ib_resolve_eth_dmac(struct ib_device 
>> *device,
>>   {
>>          int ret = 0;
>>
>> +       if (!rdma_check_gid_user_access(ah_attr->grh.sgid_attr))
>> +               return -ENODEV;
>> +
>>          if (rdma_is_multicast_addr((struct in6_addr 
>> *)ah_attr->grh.dgid.raw)) {
>>                  if (ipv6_addr_v4mapped((struct in6_addr
>> *)ah_attr->grh.dgid.raw)) {
>>                          __be32 addr = 0;
>> ---
>>
>> Its definition:
>> ---
>> /**
>>   * rdma_check_gid_user_access - Check if user process can access
>>   * this GID entry or not.
>>   * @attr: Pointer to GID entry attribute
>>   *
>>   * rdma_check_gid_user_access() returns true if user process can access
>>   * this GID attribute otherwise returns false. This API should be called
>>   * from the userspace process context.
>>   */
>> bool rdma_check_gid_user_access(const struct ib_gid_attr *attr)
>> {
>> bool allow;
>> /*
>>   * For IB and iWarp, there is no netdevice associate with GID entry,
>>   * For RoCE consider the netdevice's net ns to validate against the
>>   * calling process.
>>   */
>> rcu_read_lock();
>> if (!attr->ndev ||
>>      (attr->ndev &&
>>       net_eq(dev_net(attr->ndev), current->nsproxy->net_ns)))
>> allow = true;
>> else
>> allow = false;
>> rcu_read_unlock();
>> return allow;
>> }
>> ---
>>
>> I think rdma_check_gid_user_access should be ignored while RDMA
>> subsystem configured as shared mode, It should works with exclusive
>> mode. Am i missing anything? Please tell me the background about why
>> MLNX_OFED driver perform the check if anyone knows.
>>
>> Thanks!
> 

