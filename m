Return-Path: <linux-rdma+bounces-9020-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE8EA749B7
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Mar 2025 13:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA0ED17961E
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Mar 2025 12:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1FB21B191;
	Fri, 28 Mar 2025 12:20:25 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429F91DF257;
	Fri, 28 Mar 2025 12:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743164424; cv=none; b=dvfzANbZU+AkZPw5aE50WYf71BgJuAj945c0JLKkLPK6l6nxTSRdvaDdbqkvuNxHiXmVfzxyMTXI4QWzgWk5L1bb8LqJ37/ayIEvAPfHSxvQKVNnvn/rLSflgvkM+j4efmHLL1ZajZIOzPnC1GQ9BkCEoNmYtynsxP7zSfmStGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743164424; c=relaxed/simple;
	bh=eYglRSuD/Fsc9qEIlDkNFzfNCVQuppwe9NYNRuPRp54=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=il6O0D5P1P4EME0L+WVxK1ozS+wKoTNorEQp6stGpKkvYI3lRkNIs4puk7xa2zoaos7Bn6WkI0wYuryCyg5Vkw6qfi9gm9VVFKniOJco7oX/pATftxYSzMA4otBvqDkTeblEZzjEe2lT3rF8UivC4t6aog+1LHKaXmkldecsst4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZPKLR5svzz1R7bK;
	Fri, 28 Mar 2025 20:18:23 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 153B81400D2;
	Fri, 28 Mar 2025 20:20:12 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 28 Mar 2025 20:20:11 +0800
Message-ID: <a7f22729-d76d-4e90-8457-6844f18929eb@huawei.com>
Date: Fri, 28 Mar 2025 20:20:11 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/13] Ultra Ethernet driver introduction
To: Jason Gunthorpe <jgg@nvidia.com>, Sean Hefty <shefty@nvidia.com>
CC: Bernard Metzler <BMT@zurich.ibm.com>, Roland Dreier
	<roland@enfabrica.net>, Nikolay Aleksandrov <nikolay@enfabrica.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "shrijeet@enfabrica.net"
	<shrijeet@enfabrica.net>, "alex.badea@keysight.com"
	<alex.badea@keysight.com>, "eric.davis@broadcom.com"
	<eric.davis@broadcom.com>, "rip.sohan@amd.com" <rip.sohan@amd.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "winston.liu@keysight.com"
	<winston.liu@keysight.com>, "dan.mihailescu@keysight.com"
	<dan.mihailescu@keysight.com>, Kamal Heib <kheib@redhat.com>,
	"parth.v.parikh@keysight.com" <parth.v.parikh@keysight.com>, Dave Miller
	<davem@redhat.com>, "ian.ziemba@hpe.com" <ian.ziemba@hpe.com>,
	"andrew.tauferner@cornelisnetworks.com"
	<andrew.tauferner@cornelisnetworks.com>, "welch@hpe.com" <welch@hpe.com>,
	"rakhahari.bhunia@keysight.com" <rakhahari.bhunia@keysight.com>,
	"kingshuk.mandal@keysight.com" <kingshuk.mandal@keysight.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
 <20250319164802.GA116657@nvidia.com>
 <CALgUMKhB7nZkU0RtJJRtcHFm2YVmahUPCQv2XpTwZw=PaaiNHg@mail.gmail.com>
 <DM6PR12MB4313D576318921D47B3C61B5BDA42@DM6PR12MB4313.namprd12.prod.outlook.com>
 <BN8PR15MB25131FB51A63577B5795614399A72@BN8PR15MB2513.namprd15.prod.outlook.com>
 <DM6PR12MB431329322A0C0CCB7D5F85E6BDA72@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+QTD7ihtQSYI0bl@nvidia.com>
 <DM6PR12MB43137AE666F19784D2832030BDA62@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+Qi+XxYizfhr06P@nvidia.com>
 <DM6PR12MB431345D07D958CF0B784AE0EBDA62@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+VSFRFG1gIbGsLQ@nvidia.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <Z+VSFRFG1gIbGsLQ@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/3/27 21:26, Jason Gunthorpe wrote:

...

> 
>> which I think will work for NICs that
>> need a PD and ones that don't.  It can support MR -> PD -> Job, but
>> I considered the PD -> job relationship as 1 to many. 
> 
> Yes, and the 1:1 is degenerate.
> 
>> Sure, It's challenging in that a UET endpoint (QP) may communicate
>> with multiple jobs, and a MR may be accessible by a single job, all
>> jobs, or only a few.
> 
> I would suggest that the PD is a superset of all jobs and the objects
> (endpoint, mr, etc) get to choose a subset of the PD's jobs during
> allocation?
> 
> Or you keep job/pd as 1:1 and allow specifying multiple PDs during
> object allocation.
> 
> But to be clear, this is largely verbs modeling stuff - however there
> is a certain practicality to trying to fit this multi-job ability into
> a PD because it allow reusing alot of existing uAPI kernel code.
> 
> Especially if people are going to take existing RDMA HW and tweak it
> to some level of UET (ie support only single job) and still require a
> HW level PD under the covers.

Through reading this patchset, it seems the semantics of 'job' for UEC
is about how to identify a PDC(Packet Delivery Context) instance, which
is specified by src fep_address/pdc_id and dst fep_address/pdc_id as
there seems to be more than one PDC instance between two nodes, so the
'job' is really about grouping processes from the same 'job' to use the
same PDC instance and preventing processes from different 'job' from
using the same PDC instance?

And the interesting part about the PDC seems to be:
1. It is created dynamically when a request packet is sent on the target
   side or received on the initiator side, and destroyed dynamically through
   timeout mechanism.
2. It seems a PDC instance can be shared between different processes from the
   same 'job'.

And SRD seems to be using AH(address handle) to specify a SRD connection between
two nodes, and there is only one SRD context instance between two nodes, so different
process may have their own AH pointing to the same SRD context instance between the
same two nodes?

