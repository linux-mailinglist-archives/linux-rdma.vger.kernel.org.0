Return-Path: <linux-rdma+bounces-6664-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D48BA9F89FC
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2024 03:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2D6E1891C29
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2024 02:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2385BF9EC;
	Fri, 20 Dec 2024 02:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="u2elE5dR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C63725949F
	for <linux-rdma@vger.kernel.org>; Fri, 20 Dec 2024 02:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734660407; cv=none; b=h8QWL9DqjsBt6/nHjUr0vjmrR1RunYSkq136rpvR8M1SuKiiZdODzkfborYzFTl8mHp6qeIgxj/UcyCyW7fh5Rg/uaz2Faz0RLmJZGlbkAsk1CcyeB8fh+JcWL//UVie9DPu48hkd36qv+KvOQ0wLeRLN1G8QDa2nqRl/Jv7Nzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734660407; c=relaxed/simple;
	bh=1WvdgUyDYbakffc0CrZSpWH3jc0sIYEHMwGGyGJWFOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TzfRUQjODZgMQvw97k5xUaPFhStw/p890qgAzIh0RvUZgRfhjPLTbDknYOynO4+V4qDCxJVNebuK1ss8n4hVRJIMGR1GCdY/zmHaVhWwTalm9s1uhtSnttRZJhV8llc6l1yypXwUdJSiDMJJWEAIpyQDyeRVhhv/4IRZBgqbsbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=u2elE5dR; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734660397; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RY+nrHVXkSGWPpqBERG3FiRLxNzXI1+Bw6BfVYzHCv8=;
	b=u2elE5dRlhkuQufB9oyYUksALZRz9yvr2UorFGe5k7H61ry3Sm+t2spR8ydPgu9lZqAhbqk62o1YEC7gDIAXIdyClVyXE2iXZnixOj3CAU3eVlTpm0BOyQAPU/smtrR9WPoxNxkURC643pCgkDZ8o6pnFvhUTVXh+01yNTSUsUg=
Received: from 30.221.117.29(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0WLs6NsI_1734660395 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 20 Dec 2024 10:06:36 +0800
Message-ID: <7a262ba9-e4fa-c53d-7616-d217fbfa0f77@linux.alibaba.com>
Date: Fri, 20 Dec 2024 10:06:35 +0800
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
To: Kees Bakker <kees@ijzerbout.nl>, Boshi Yu <boshiyu@linux.alibaba.com>,
 Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org
References: <6975f57c-8053-4ff1-b1ac-cd985e254ecb@ijzerbout.nl>
From: Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <6975f57c-8053-4ff1-b1ac-cd985e254ecb@ijzerbout.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/20/24 3:02 AM, Kees Bakker wrote:
> Hi,
> 
> As identified by Coverity Scan (CID 1602609) there is a potential
> use of a NULL pointer.
> 
> It was introduced in commit 6534de1fe385
> Author: Cheng Xu <chengyou@linux.alibaba.com>
> Date:   Tue Jun 6 13:50:04 2023 +0800
> 
>     RDMA/erdma: Associate QPs/CQs with doorbells for authorization
> 
>     For the isolation requirement, each QP/CQ can only issue doorbells from the
>     allocated mmio space. Configure the relationship between QPs/CQs and
>     mmio doorbell spaces to hardware in create_qp/create_cq interfaces.
> 
>     Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
>     Link: https://lore.kernel.org/r/20230606055005.80729-4-chengyou@linux.alibaba.com
>     Signed-off-by: Leon Romanovsky <leon@kernel.org>
> 
> int erdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
>                     struct ib_udata *udata)
> {
>         struct erdma_qp *qp = to_eqp(ibqp);
>         struct erdma_dev *dev = to_edev(ibqp->device);
>         struct erdma_ucontext *uctx = rdma_udata_to_drv_context(
>                 udata, struct erdma_ucontext, ibucontext);
> [...]
>         if (uctx) {
>                 ret = ib_copy_from_udata(&ureq, udata,
>                                          min(sizeof(ureq), udata->inlen));
> [...]
>         } else {
>                 init_kernel_qp(dev, qp, attrs);
>         }
> 
>         qp->attrs.max_send_sge = attrs->cap.max_send_sge;
>         qp->attrs.max_recv_sge = attrs->cap.max_recv_sge;
> 
>         if (erdma_device_iwarp(qp->dev))
>                 qp->attrs.iwarp.state = ERDMA_QPS_IWARP_IDLE;
>         else
>                 qp->attrs.rocev2.state = ERDMA_QPS_ROCEV2_RESET;
> 
>         INIT_DELAYED_WORK(&qp->reflush_dwork, erdma_flush_worker);
> 
>         ret = create_qp_cmd(uctx, qp);
> [...]
> This shows that `uctx` can be NULL. The problem is that `uctx` can be
> dereferenced in create_qp_cmd(). There is no guard against NULL.
> 
> Can one of you have a look and say that it OK to potential pass a
> NULL pointer in `uctx`?
> 

static int create_qp_cmd(struct erdma_ucontext *uctx, struct erdma_qp *qp)
{
        [...]

        if (rdma_is_kernel_res(&qp->ibqp.res)) {
            [...]
	} else {
            // uctx used here...
        }

        [...]
}

When uctx == NULL, rdma_is_kernel_res() will always return false and uctx will not be
dereferenced. So the current implementation is OK.

Thanks,
Cheng Xu


> Kind regards,
> Kees Bakker

