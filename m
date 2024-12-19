Return-Path: <linux-rdma+bounces-6659-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C32B9F83C0
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 20:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7B4C18902E1
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 19:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADFA1A2545;
	Thu, 19 Dec 2024 19:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="hDANIuX0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203A27494
	for <linux-rdma@vger.kernel.org>; Thu, 19 Dec 2024 19:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.140.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734634993; cv=none; b=rrDHp0o0bFb6c/qUn1kBIUKbhGY4NPZe4mv8Qbws1K9qlaccdGfKwUNA07f/N0dZpFYvkVh92jifCxmRNH0QrI80VjFuVM/xABK3DfGxYvO3nvKKyWcFhD+JoQlBCyoi9kP2YvOfc+MgmsectsumyGiqGoe5+UsVKVcIdrogDqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734634993; c=relaxed/simple;
	bh=2n3nD7yNuY/9kCA591uMF/f+9F7sXdRnsngHXQ9WNPk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ooAZ3SUXyh2Mni4pg2PpWIj41JEhW1UhbGw63C5JleX6qrmSrTjMlMRuRrCOUB/H9PLpP7hFHb9+nfbw0GUeeLAaiHD2cq5m329WX1va04h3uJ9ywNbsvCjbH1Lkq5ab/k9PeFWOQ6bQOEAQ/BnOU19Ewg0WXPD+uaRrN4x1qqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; spf=pass smtp.mailfrom=ijzerbout.nl; dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b=hDANIuX0; arc=none smtp.client-ip=136.144.140.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ijzerbout.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1734634986; bh=2n3nD7yNuY/9kCA591uMF/f+9F7sXdRnsngHXQ9WNPk=;
	h=Date:To:Cc:From:Subject:From;
	b=hDANIuX0cNVlqPdFg2ZOZRsePk7iaiQxlDcm5/LndJq7PD9zAgE0wXDVAX/9KJobJ
	 RVdQGyVj2P7biZ95cnu3aRs0fBSQd8LJ0+hFxplINYnYY28IzXW6uV8PsOYVjYdESG
	 ZI5iT5aww46TQpbydJJmn1MGVShmSwk2HOI4sixslX/z9feIf+x/jXi+5XRwxBRJ28
	 FZHFlwD5n1NA/C1Qk7Z36hFoyFmbtSBffrjxwIwZJEJLhhcndRcT+Gc0E8p86tPChy
	 ElOkphrmAltVQ18lipn/vYvTTPrsm5ery3bAjcOjE/+MtA1kmXKqnwWRUtI9XR3dCU
	 9vNqT4zStPAc1aweMHVnUwqVGrjz5dLufoh4hxiaLOiW5T1j1uzQXcrfhWpPlLVDJs
	 WT0gElJhzkqeaBvCYnhmORHx17F9TlaULk9tYUgPV68tf3XaIiyjCSjd19TSRRcML4
	 eQDidfPn1HjP3MYOIHA2xId1FTFt4qJNSkWCzYTQm+EBn6GhMC+47zPFe5fzGwY5Nu
	 M0hSyu3QBoRU28ElTmoNmoFCEM/t2ivl0RqiLYC6NmW4ja6biIyxVXxVJtuneeYGP8
	 MMXbUuzn8ir37Ixivva0MqiOM7M+c6L/ydcDZmfxh9CpmamfECoxT0Pqjhb5ch6XX0
	 3cPfB77//O38aQC5/iPHssNc=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
	by bout3.ijzerbout.nl (Postfix) with ESMTPSA id 6054218E594;
	Thu, 19 Dec 2024 20:03:06 +0100 (CET)
Message-ID: <6975f57c-8053-4ff1-b1ac-cd985e254ecb@ijzerbout.nl>
Date: Thu, 19 Dec 2024 20:02:58 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Boshi Yu <boshiyu@linux.alibaba.com>,
 Cheng Xu <chengyou@linux.alibaba.com>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org
From: Kees Bakker <kees@ijzerbout.nl>
Subject: Potential use of NULL pointer in erdma/erdma_verbs.c
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

As identified by Coverity Scan (CID 1602609) there is a potential
use of a NULL pointer.

It was introduced in commit 6534de1fe385
Author: Cheng Xu <chengyou@linux.alibaba.com>
Date:   Tue Jun 6 13:50:04 2023 +0800

     RDMA/erdma: Associate QPs/CQs with doorbells for authorization

     For the isolation requirement, each QP/CQ can only issue doorbells 
from the
     allocated mmio space. Configure the relationship between QPs/CQs and
     mmio doorbell spaces to hardware in create_qp/create_cq interfaces.

     Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
     Link: 
https://lore.kernel.org/r/20230606055005.80729-4-chengyou@linux.alibaba.com
     Signed-off-by: Leon Romanovsky <leon@kernel.org>

int erdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
                     struct ib_udata *udata)
{
         struct erdma_qp *qp = to_eqp(ibqp);
         struct erdma_dev *dev = to_edev(ibqp->device);
         struct erdma_ucontext *uctx = rdma_udata_to_drv_context(
                 udata, struct erdma_ucontext, ibucontext);
[...]
         if (uctx) {
                 ret = ib_copy_from_udata(&ureq, udata,
                                          min(sizeof(ureq), udata->inlen));
[...]
         } else {
                 init_kernel_qp(dev, qp, attrs);
         }

         qp->attrs.max_send_sge = attrs->cap.max_send_sge;
         qp->attrs.max_recv_sge = attrs->cap.max_recv_sge;

         if (erdma_device_iwarp(qp->dev))
                 qp->attrs.iwarp.state = ERDMA_QPS_IWARP_IDLE;
         else
                 qp->attrs.rocev2.state = ERDMA_QPS_ROCEV2_RESET;

         INIT_DELAYED_WORK(&qp->reflush_dwork, erdma_flush_worker);

         ret = create_qp_cmd(uctx, qp);
[...]
This shows that `uctx` can be NULL. The problem is that `uctx` can be
dereferenced in create_qp_cmd(). There is no guard against NULL.

Can one of you have a look and say that it OK to potential pass a
NULL pointer in `uctx`?

Kind regards,
Kees Bakker


