Return-Path: <linux-rdma+bounces-6666-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6BA9F8A14
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2024 03:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A4F07A3210
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2024 02:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB08D1804A;
	Fri, 20 Dec 2024 02:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ou9MhpTu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155312594BB
	for <linux-rdma@vger.kernel.org>; Fri, 20 Dec 2024 02:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734661565; cv=none; b=SN+NoqoeEPNaNYlZgEOLrynLFJSqMajm21mdWkUt57xkplZw6l+J9ooYsvan1xMgOH+d/Ela8nMT/GdHAOsL4PulHQTIJDZmbYrxlNMFI8gU9m+TJ5ta2vHVW9o9oGSihxIzcP4vz7EtsBZISMn0nbI0FGauBmpKLRmCPiMtj48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734661565; c=relaxed/simple;
	bh=Z11gmbcn+SBf4GhqNkoXeUJVGA12oIavKw69wJOVt70=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pasJrbnNyula3kUXx5wvJ/Sc5yeIAWs/coJBvNmNfEMCMlvKH5urGpoUXLms/jqYHPYyOFUC+Giac7vWtPwcNdYgFy4paVSKAbK7nNxc6hEwvcSndHc3x1n2I6dp2sixpSo8BIgMv9u/YdaJQkCWri1kGbjqtax5sia22M2UOv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ou9MhpTu; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734661558; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=jVjRZL162rNDdIkykLer9M6zfU1jU+Ct7zisCVup9uw=;
	b=Ou9MhpTuLkIJwsSADOYa8FPjKQ5a9mt2YUkDkiqX41CxuJwrGtwvHghQJffN0H5NL9HmBmWcqIpwjogo48SfVtsQ3qLM++JDhtvtvas7XU9VpZmp+k1GqxwlYBjogj7ypZKAXCkO9h3ZbGI6lcNw5On5xpCCn95WETqocdR8LZM=
Received: from 30.221.117.29(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0WLs9TH._1734661557 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 20 Dec 2024 10:25:57 +0800
Message-ID: <880cf690-15f2-7ef8-a90b-d54be9d0084f@linux.alibaba.com>
Date: Fri, 20 Dec 2024 10:25:57 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: Potential use of NULL pointer in erdma/erdma_verbs.c
Content-Language: en-US
From: Cheng Xu <chengyou@linux.alibaba.com>
To: Kees Bakker <kees@ijzerbout.nl>, Boshi Yu <boshiyu@linux.alibaba.com>,
 Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org
References: <6975f57c-8053-4ff1-b1ac-cd985e254ecb@ijzerbout.nl>
 <7a262ba9-e4fa-c53d-7616-d217fbfa0f77@linux.alibaba.com>
In-Reply-To: <7a262ba9-e4fa-c53d-7616-d217fbfa0f77@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/20/24 10:06 AM, Cheng Xu wrote:
> 
> 
> On 12/20/24 3:02 AM, Kees Bakker wrote:
>> Hi,
>>
>> As identified by Coverity Scan (CID 1602609) there is a potential
>> use of a NULL pointer.
>>
>> It was introduced in commit 6534de1fe385
>> Author: Cheng Xu <chengyou@linux.alibaba.com>
>> Date:   Tue Jun 6 13:50:04 2023 +0800
>>
>>     RDMA/erdma: Associate QPs/CQs with doorbells for authorization
>>
>>     For the isolation requirement, each QP/CQ can only issue doorbells from the
>>     allocated mmio space. Configure the relationship between QPs/CQs and
>>     mmio doorbell spaces to hardware in create_qp/create_cq interfaces.
>>
>>     Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
>>     Link: https://lore.kernel.org/r/20230606055005.80729-4-chengyou@linux.alibaba.com
>>     Signed-off-by: Leon Romanovsky <leon@kernel.org>
>>
>> int erdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
>>                     struct ib_udata *udata)
>> {
>>         struct erdma_qp *qp = to_eqp(ibqp);
>>         struct erdma_dev *dev = to_edev(ibqp->device);
>>         struct erdma_ucontext *uctx = rdma_udata_to_drv_context(
>>                 udata, struct erdma_ucontext, ibucontext);
>> [...]
>>         if (uctx) {
>>                 ret = ib_copy_from_udata(&ureq, udata,
>>                                          min(sizeof(ureq), udata->inlen));
>> [...]
>>         } else {
>>                 init_kernel_qp(dev, qp, attrs);
>>         }
>>
>>         qp->attrs.max_send_sge = attrs->cap.max_send_sge;
>>         qp->attrs.max_recv_sge = attrs->cap.max_recv_sge;
>>
>>         if (erdma_device_iwarp(qp->dev))
>>                 qp->attrs.iwarp.state = ERDMA_QPS_IWARP_IDLE;
>>         else
>>                 qp->attrs.rocev2.state = ERDMA_QPS_ROCEV2_RESET;
>>
>>         INIT_DELAYED_WORK(&qp->reflush_dwork, erdma_flush_worker);
>>
>>         ret = create_qp_cmd(uctx, qp);
>> [...]
>> This shows that `uctx` can be NULL. The problem is that `uctx` can be
>> dereferenced in create_qp_cmd(). There is no guard against NULL.
>>
>> Can one of you have a look and say that it OK to potential pass a
>> NULL pointer in `uctx`?
>>
> 
> static int create_qp_cmd(struct erdma_ucontext *uctx, struct erdma_qp *qp)
> {
>         [...]
> 
>         if (rdma_is_kernel_res(&qp->ibqp.res)) {
>             [...]
> 	} else {
>             // uctx used here...
>         }
> 
>         [...]
> }
> 
> When uctx == NULL, rdma_is_kernel_res() will always return false and uctx will not be
                                                             ^^^^^
                                                             true
> dereferenced. So the current implementation is OK.
> 

Sorry for this typo.

Cheng Xu

> Thanks,
> Cheng Xu
> 
> 
>> Kind regards,
>> Kees Bakker

