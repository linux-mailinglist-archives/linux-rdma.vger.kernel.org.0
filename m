Return-Path: <linux-rdma+bounces-9061-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAB1A7779B
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 11:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23BBE3ADF25
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 09:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E671EE7D3;
	Tue,  1 Apr 2025 09:20:18 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038A01EDA09;
	Tue,  1 Apr 2025 09:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743499218; cv=none; b=A29sm4+cu/hyUsdlZyBh8iMhcBhcyzFB3AtSVo7h3fN1o7JWJwIhYcUlrOb4kBkDQBesUSrUVODpxKh8L+oV7ARlt3e30duPWvBFStFLDd8L7crasixcjaTtroOgTnDlu9icmDjBi55iTXbo22WYZ38DewPqWA/AjfW8dEZ7/hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743499218; c=relaxed/simple;
	bh=3JEv0jTr5FAuLNgIjAX2LYO/gsXptGNYLpoxF+E09mY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NZQSCxM8ogeJL3FgOzW/cSJs3UmTLJJABDJdt2shsVCrGGfs42U+FOmv5so10pIHhiO04tgyOb4pQaghqpoGvyiHwvb+x3ickc09X3CW+/m6iR2E5+PJAPnZ+QkLf7+a98CTrilYo5l6t7YQWybGvpyhDZNox1JFPi79OBXvnJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZRj9F4H20ztRVW;
	Tue,  1 Apr 2025 17:18:41 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id F16AD1800E5;
	Tue,  1 Apr 2025 17:20:06 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 1 Apr 2025 17:20:04 +0800
Message-ID: <962c1dff-b944-499d-8883-2fe760219352@huawei.com>
Date: Tue, 1 Apr 2025 17:19:44 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/13] Ultra Ethernet driver introduction
To: Sean Hefty <shefty@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
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
 <a7f22729-d76d-4e90-8457-6844f18929eb@huawei.com>
 <DM6PR12MB43137DCF20A1428F7E67F82BBDAD2@DM6PR12MB4313.namprd12.prod.outlook.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <DM6PR12MB43137DCF20A1428F7E67F82BBDAD2@DM6PR12MB4313.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/4/1 3:49, Sean Hefty wrote:
>> Through reading this patchset, it seems the semantics of 'job' for UEC is about
>> how to identify a PDC(Packet Delivery Context) instance, which is specified by
>> src fep_address/pdc_id and dst fep_address/pdc_id as there seems to be more
>> than one PDC instance between two nodes, so the 'job' is really about
>> grouping processes from the same 'job' to use the same PDC instance and
>> preventing processes from different 'job' from using the same PDC instance?
> 
> UEC targets HPC and AI workloads, so the concept of a job in this discussion represents a parallel application.  I.e. a group of processes across multiple nodes communicating.

Ok, I guess this patchset only implement a portion of semantics for the 'job'
in UEC, the page mapping, local access, and remote access functions grouping
and separating you mentioned in other thread does not seem to be implemented
yet.

> 
> - Sean

