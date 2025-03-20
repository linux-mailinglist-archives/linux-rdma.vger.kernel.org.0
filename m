Return-Path: <linux-rdma+bounces-8860-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBF9A6A48F
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Mar 2025 12:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657913BD84A
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Mar 2025 11:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2644A21CA10;
	Thu, 20 Mar 2025 11:13:09 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F1821C9EE;
	Thu, 20 Mar 2025 11:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742469189; cv=none; b=JdvFRPh6SUI0to1jHm0gTZGmzRurl/0qK+C88YTCFyRe6K420UO/fccz2NSuSb7Bimb2pXrCPvQlfaXD6HqIpa+XkE0bain+2BkQgP3HsEWLRiAOGPlUV5b261tmNCqaKhQ88EdgHzG3oHlHQAYl6T0KNlKoF8ywXREdLXL7VTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742469189; c=relaxed/simple;
	bh=VmlerhMtRQKB8S8Gb3WmVadG8dq5nBAyHNvyZcexTUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ik33ZcBsSJ+9I6Y5P1IbpvLmE2nyM3S/czFQl8EiNg0wFR90hUJfLQnjeFEBDbb8h8FK/exkFvM819Trmj6eOvyfPQKy8/qOVFXjXWWjehF21HwSPikqml8lfAgyRbHPof5aNaKcelYDlzEojrFi8gpn0VSbLaU/+kjpmZU+2KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ZJN9T4wPVz1f1Km;
	Thu, 20 Mar 2025 19:08:29 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 15F82140135;
	Thu, 20 Mar 2025 19:13:02 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Mar 2025 19:13:01 +0800
Message-ID: <e798b650-dd61-4176-a7d6-b04c2e9ddd80@huawei.com>
Date: Thu, 20 Mar 2025 19:13:01 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/13] Ultra Ethernet driver introduction
To: Jason Gunthorpe <jgg@nvidia.com>, Nikolay Aleksandrov
	<nikolay@enfabrica.net>
CC: <netdev@vger.kernel.org>, <shrijeet@enfabrica.net>,
	<alex.badea@keysight.com>, <eric.davis@broadcom.com>, <rip.sohan@amd.com>,
	<dsahern@kernel.org>, <bmt@zurich.ibm.com>, <roland@enfabrica.net>,
	<winston.liu@keysight.com>, <dan.mihailescu@keysight.com>,
	<kheib@redhat.com>, <parth.v.parikh@keysight.com>, <davem@redhat.com>,
	<ian.ziemba@hpe.com>, <andrew.tauferner@cornelisnetworks.com>,
	<welch@hpe.com>, <rakhahari.bhunia@keysight.com>,
	<kingshuk.mandal@keysight.com>, <linux-rdma@vger.kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, huchunzhi <huchunzhi@huawei.com>,
	<jerry.lilijun@huawei.com>, <zhangkun09@huawei.com>,
	<wang.chihyung@huawei.com>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
 <20250319164802.GA116657@nvidia.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20250319164802.GA116657@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/3/20 0:48, Jason Gunthorpe wrote:
> On Fri, Mar 07, 2025 at 01:01:50AM +0200, Nikolay Aleksandrov wrote:
>> Hi all,
>> This patch-set introduces minimal Ultra Ethernet driver infrastructure and
>> the lowest Ultra Ethernet sublayer - the Packet Delivery Sublayer (PDS),
>> which underpins the entire communication model of the Ultra Ethernet
>> Transport[1] (UET). Ultra Ethernet is a new RDMA transport designed for
>> efficient AI and HPC communication.
> 
> I was away while this discussion happened so I've gone through and
> read the threads, looked at the patches and I don't think I've changed
> my view since I talked to Enfabrica privately on this topic almost a
> year ago.
> 
> I do not agree with creating a new subsystem (or whatever you are
> calling drivers/ultraeth) for a single RDMA protocol and see nothing
> new here to change my mind. I would likely NAK the direction I see in
> this RFC, as I have other past attempts to build RDMA HW interfaces
> outside of the RDMA subystem.
> 
> Since none of that past discussion seems to have been acknowledged or
> rebutted in this series I will repeat the main points:
> 
> 1) I'm aware of something like 5-7 new protocols that are competing
>    for the same market as Ultra Ethernet. We can't give everyone and
>    their dog a new subsystem (or whatever) and all the maintainability
>    negatives that come with that. As a matter of maintainability we
>    need to see consolidation here, not fragmentation!
> 
>    Yes, UE is a consortium driven standard, which is unique and a big
>    positive, but I don't believe anyone can say for certain what
>    direction the industry is going to go in. Many consortium standards
>    have failed to get adoption in the past even with a large number of
>    member companies.
> 
>    Nor can we know what concepts in UE are going to be copied into
>    other competing RDMA transports. See my other remarks on job key
>    for an example. Prematurely siloing stuff in drivers/ultraeth is
>    very much the wrong technical direction for maintainability.
> 
>    That said, I think UE should be in the kernel and have a fair
>    chance to compete for market share. Just in a maintainable and
>    appropriate way while the industry evolves.
> 
> 2) Due to the above, I'm pretty confident we will see RDMA NICs
>    supporting a lot of different protocols. In fact they already do.
> 
>    From a kernel maintainability perspective we really want one RDMA
>    driver leveraging as much common infrastructure between the
>    protocols as possible. We do not want to see a single HW driver
>    further split up needlessly to other subsystems, that would be a
>    big maintainability downside.
> 
>    To put a clear point on this, mlx5 has been gaining new protocols
>    and fitting into the existing driver model for a number of years
>    now. In fact there is speculation that UE could be implemented in
>    mlx5 RDMA with minimal kernel changes. There would be no reason to
>    try to mess up the driver to also interact with this stuff in
>    drivers/ultraeth as seems to be proposed here.
> 
>    I think other HW will be similar. UE isn't so radically different
>    that every HW path will need to diverge from classical RDMA. Nor is
>    is so dissimilar to other competing proposals. We don't want
>    artificial differences we want to create things that can be re-used
>    when appropriate.
> 
>    Leon's response to Bart is correct, we already have similar
>    examples of almost everything UE does. Bart is also correct that
>    verbs would be a PITA, but RDMA userspace has moved beyond verbs
>    limitations years ago now. Alot of mlx5 stuff is not using verbs
>    today, for instance. EFA and other examples use extensive stuff
>    beyond verbs.

Regarding to reuse the existing rdma subsystem for a new protocol:
Currently EFA seems to be layering a RDM layer on top of the SRD
transport layer, see [1], and RDM layer is implemented by software in
the libfabric while SRD seems to be implemented by hardware, which
provides 'Scalable Reliable Datagram' service through the QP type
of EFA_QP_DRIVER_TYPE_SRD.

I am not sure if layers like SRD and RDM are clean layering from
protocol design perspective.
But if the hardware implement both SRD and RDM layer in hardware,
then there might be two types of object need managing, SRD object
might be shared between different applications, and RDM object
need to be created based on a SRD object.

As the existing rdma subsystem doesn't seems to support the above
use case yet and as we are discussing a possible new subsystem or
updating existing subsystem to support new protocol here, it would
be good to discuss if it is possible to support the above case or
another new subsystem is needed for that use case too.

1. https://github.com/ofiwg/libfabric/blob/main/prov/efa/docs/efa_rdm_protocol_v4.md

