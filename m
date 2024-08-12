Return-Path: <linux-rdma+bounces-4312-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2472E94E528
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 04:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 498A11C21527
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2024 02:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F2113634E;
	Mon, 12 Aug 2024 02:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gIE8vPE3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7B24D599;
	Mon, 12 Aug 2024 02:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723430651; cv=none; b=tpnmTunjHrC6/2GCIt+uDrLCHzNXmrRXiBQ8Bdo4yIOl9qxcrClyX29F7UKIxeaAkEbon338JocUOwXscUYVTP8v+PpxIzpQXLw+Ee2a9Yem0blBeCb4tlZvVCm5mBHVtSkhx/c1bfoyOE0knJD/bzHI/ZTlsU7wfyJEjUcwVCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723430651; c=relaxed/simple;
	bh=ACZFsYo8syf+R8AmrU5+F1O8fFiv0E2yyV4CN44cIU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvXWTOGZvaJWqQQY5cJb5aVSQFkzDMIKTVxiQ7zl7pqDaovvaVH+58r7YsrLj2dHPnZs4jZdXnLwVJG1gP486rCReUIbzxIu+vSFRiU6MQfVUW/CU6NplUg4+NBdnQgumqOCUGwQCfJ7ZHMXQ7ipXnLdh9fa8YaMGS997RbAzjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gIE8vPE3; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723430639; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=SgW8GC4AxuQezDKCiAAVu55uNzM08b4p3a6ZeyjbEuA=;
	b=gIE8vPE32uih5RG8SCJNHusG6R8BpAsuRTf1VFDgJyCp6djQH/8ZG51CJnn2BH+TeR4+J0z9fnQLFEdyUye1gko7FM8kohzev/KfxoexZz7rV5Z056RvUSzyiWVGmX9eHUBWzsm7Hr5WlmDVvViVYeNTpQi/5aaBv0IK0SI7pKo=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WCWyCpb_1723430638)
          by smtp.aliyun-inc.com;
          Mon, 12 Aug 2024 10:43:59 +0800
Date: Mon, 12 Aug 2024 10:43:58 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: "liujian (CE)" <liujian56@huawei.com>, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org
Cc: jgg@ziepe.ca, leon@kernel.org, zyjzyj2000@gmail.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next 2/4] net/smc: use ib_device_get_netdev() helper
 to get netdev info
Message-ID: <20240812024358.GD103152@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20240809083148.1989912-1-liujian56@huawei.com>
 <20240809083148.1989912-3-liujian56@huawei.com>
 <20240809145917.GB103152@linux.alibaba.com>
 <28f3582f-0394-458f-81d1-aeb872edcafa@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28f3582f-0394-458f-81d1-aeb872edcafa@huawei.com>

On 2024-08-12 10:07:42, liujian (CE) wrote:
>
>
>在 2024/8/9 22:59, Dust Li 写道:
>> On 2024-08-09 16:31:46, Liu Jian wrote:
>> > Currently, in the SMC protocol, network devices are obtained by calling
>> > ib_device_ops.get_netdev(). But for some drivers, this callback function
>> > is not implemented separately. Therefore, here I modified to use
>> > ib_device_get_netdev() to get net_device.
>> > 
>> > For rdma devices that do not implement ib_device_ops.get_netdev(), one of
>> > the issues addressed is as follows:
>> > before:
>> > smcr device
>> > Net-Dev         IB-Dev   IB-P  IB-State  Type        Crit  #Links  PNET-ID
>> >                 rxee        1    ACTIVE  0               No       0
>> > 
>> > after:
>> > smcr device
>> > Net-Dev         IB-Dev   IB-P  IB-State  Type        Crit  #Links  PNET-ID
>> > enp1s0f1        rxee        1    ACTIVE  0               No       0
>> > 
>> > Signed-off-by: Liu Jian <liujian56@huawei.com>
>> > ---
>> > net/smc/smc_ib.c   | 8 +++-----
>> > net/smc/smc_pnet.c | 6 +-----
>> > 2 files changed, 4 insertions(+), 10 deletions(-)
>> > 
>> > diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
>> > index 9297dc20bfe2..382351ac9434 100644
>> > --- a/net/smc/smc_ib.c
>> > +++ b/net/smc/smc_ib.c
>> > @@ -899,9 +899,7 @@ static void smc_copy_netdev_ifindex(struct smc_ib_device *smcibdev, int port)
>> > 	struct ib_device *ibdev = smcibdev->ibdev;
>> > 	struct net_device *ndev;
>> > 
>> > -	if (!ibdev->ops.get_netdev)
>> > -		return;
>> > -	ndev = ibdev->ops.get_netdev(ibdev, port + 1);
>> > +	ndev = ib_device_get_netdev(ibdev, port + 1);
>> > 	if (ndev) {
>> > 		smcibdev->ndev_ifidx[port] = ndev->ifindex;
>> > 		dev_put(ndev);
>> > @@ -921,9 +919,9 @@ void smc_ib_ndev_change(struct net_device *ndev, unsigned long event)
>> > 		port_cnt = smcibdev->ibdev->phys_port_cnt;
>> > 		for (i = 0; i < min_t(size_t, port_cnt, SMC_MAX_PORTS); i++) {
>> > 			libdev = smcibdev->ibdev;
>> > -			if (!libdev->ops.get_netdev)
>> > +			lndev = ib_device_get_netdev(libdev, i + 1);
>> > +			if (!lndev)
>> > 				continue;
>> > -			lndev = libdev->ops.get_netdev(libdev, i + 1);
>> > 			dev_put(lndev);
>> > 			if (lndev != ndev)
>> > 				continue;
>> > diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
>> > index 2adb92b8c469..a55a697a48de 100644
>> > --- a/net/smc/smc_pnet.c
>> > +++ b/net/smc/smc_pnet.c
>> > @@ -1055,11 +1055,7 @@ static void smc_pnet_find_rdma_dev(struct net_device *netdev,
>> > 			continue;
>> > 
>> > 		for (i = 1; i <= SMC_MAX_PORTS; i++) {
>> > -			if (!rdma_is_port_valid(ibdev->ibdev, i))
>> > -				continue;
>> 
>> Why remove this check ?
>> 
>Hi, Dust,
>The same check is already in ib_device_get_netdev().

Oh I see, thanks !

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

>> Best regard,
>> Dust
>> 
>> 
>> > -			if (!ibdev->ibdev->ops.get_netdev)
>> > -				continue;
>> > -			ndev = ibdev->ibdev->ops.get_netdev(ibdev->ibdev, i);
>> > +			ndev = ib_device_get_netdev(ibdev->ibdev, i);
>> > 			if (!ndev)
>> > 				continue;
>> > 			dev_put(ndev);
>> > -- 
>> > 2.34.1
>> > 

