Return-Path: <linux-rdma+bounces-12772-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB31B282CE
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Aug 2025 17:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16DDCAE79D4
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Aug 2025 15:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC0B2957CD;
	Fri, 15 Aug 2025 15:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DZPV+XX9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C0C1E51EB;
	Fri, 15 Aug 2025 15:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755271132; cv=none; b=B+0cv6eair0OAXFbqPsHM2LpR7svUwupUSSTjN9pZ5D4CnLZpJZ6ZyxyAQL+o4zB/9mv8Tn6Ckxlf7XgUU5+UUbo4I/PW9XazmWAsngPuCSaevyDWRAj2G4eQptA0sLk/YVNMvB5+a9VVotbFanqz2xFcVoGcALpLfo9Xd7VkhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755271132; c=relaxed/simple;
	bh=St+m+XjWR/D4VK4NB5c9bnl2k3LwJ4ySiZP7SeGdbVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OecZoLcDjfLEVdiuEXynp80KVkrNHYqwrzePlHvmcEnQRhijQYNPTn21iVGO31RwBnM/Jihk6GsQkKEQosZZbHbJ50yIrskSJQZJg6OwTZZUM2gPP1qJe+anE2OH9RfBqu+gg7Ai3Jv8gZBg0MXtnaqVoBVs0oA04apxF5RtOa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DZPV+XX9; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755271122; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=XbSjaFfmeqSEDkSADy+S30PSxGVVPnDzKxoBgjjd400=;
	b=DZPV+XX9dTC4xc35Q9W4bu4WdlPipQlwtDL8qSgVbdl+MvSCQCEY9Tq3BbPZNFyVWgZqLFkA4pVTaAWuZKNmwRIDquj8e/y5JnziiVwTPR9W+l26c/QYxx3NvuLOWOOqoo/ChyUv1xcVhjrc68taEPuOw4Jf7ry1R1MSoCPbGu0=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WlpLglp_1755271121 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 15 Aug 2025 23:18:42 +0800
Date: Fri, 15 Aug 2025 23:18:41 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Alexandra Winter <wintera@linux.ibm.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Julian Ruess <julianr@linux.ibm.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Simon Horman <horms@kernel.org>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, Halil Pasic <pasic@linux.ibm.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [RFC net-next 11/17] net/dibs: Move struct device to dibs_dev
Message-ID: <aJ9P0WpHU30zpLLt@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250806154122.3413330-1-wintera@linux.ibm.com>
 <20250806154122.3413330-12-wintera@linux.ibm.com>
 <369a292c-c8c5-4002-a116-f9e1b4a436ba@linux.ibm.com>
 <aJ6TsutbywkTLWxO@linux.alibaba.com>
 <88d261d1-b1fe-447f-a928-02dec6141b0b@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88d261d1-b1fe-447f-a928-02dec6141b0b@linux.ibm.com>

On 2025-08-15 13:59:49, Alexandra Winter wrote:
>
>
>On 15.08.25 03:56, Dust Li wrote:
>> On 2025-08-14 10:51:27, Alexandra Winter wrote:
>>>
>>> On 06.08.25 17:41, Alexandra Winter wrote:
>>> [...]
>>>> Replace smcd->ops->get_dev(smcd) by dibs_get_dev().
>>>>
>>> Looking at the resulting code, I don't really like this concept of a *_get_dev() function,
>>> that does not call get_device().
>>> I plan to replace that by using dibs->dev directly in the next version.
>> May I ask why? Because of the function name ? If so, maybe we can change the name.
>
>Yes the name. Especially, as it is often used as argument for get_device() or put_device().
>Eventually I would like to provide dibs_get_dev()/dibs_put_dev() that actually
>do refcounting.
>And then I thought defining dibs_read_dev() is not helping readability.

I see. I don't like dibs_get_dev() either.
What about dibs_device_to_dev() or dibs_to_dev() ?

If we can't agree on a name we’re all happy with, I agree we can
leave it as is for now.


>> 
>> While I don't have a strong preference either way, I personally favor
>> hiding the members of the dibs_dev structure from the upper layer. In my
>> opinion, it would be better to avoid direct access to dibs members from
>> upper layers and instead provide dedicated interface functions.
>> 
>> For example, I even think we should not expose dibs->ops->xxx directly
>> to the SMC layer. Encapsulating such details would improve modularity
>> and maintainability. Just like what IB subsystem has done before :)
>> 
>> For example:
>> # git grep dibs net/smc
>> [...]
>> net/smc/smc_ism.c:      return dibs->ops->query_remote_gid(dibs, &ism_rgid, vlan_id ? 1 : 0,
>> net/smc/smc_ism.c:      return smcd->dibs->ops->get_fabric_id(smcd->dibs);
>> net/smc/smc_ism.c:      if (!smcd->dibs->ops->add_vlan_id)
>> net/smc/smc_ism.c:      if (smcd->dibs->ops->add_vlan_id(smcd->dibs, vlanid)) {
>> net/smc/smc_ism.c:      if (!smcd->dibs->ops->del_vlan_id)
>> net/smc/smc_ism.c:      if (smcd->dibs->ops->del_vlan_id(smcd->dibs, vlanid))
>> [...]
>> 
>> Best regards,
>> Dust
>
>
>I see your point and I remember you brought that up in your review of
>[RFC net-next 0/7] Provide an ism layer
>already.
>
>I tried to keep this series to a meaningful minimum, which is a tradeoff.
>If possible, I just wanted to move code around and add the dibs layer
>in-between. There are several areas where I would like to see even more
>de-coupling. eg.:
>- handle_irq(): Clients should not run in interrupt context,
>  a receive_data() callback function would be better.
>- The device drivers should not loop through the client array
>- dibs_dev_op.*_dmb() functions reveal unnecessary details of the
>  internal dmb struct to the clients
>- ...
>
>So instead of adding a set of 1:1 caller functions / interface functions
>for dibs_dev_ops and dibs_client_ops now, I would like to propose to work
>on further decoupling devices and clients by adding more abstractions that
>bring benefit. And then replace the remaining calls to ops by 1:1 caller
>functions. Does that make sense? Or does anybody feel strongly that I need
>to provide interface functions now?

Yes, I agree we can do that in the future.

Best regards,
Dust


