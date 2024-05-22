Return-Path: <linux-rdma+bounces-2567-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308A48CBC81
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2024 09:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 620201C2153F
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2024 07:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519887E567;
	Wed, 22 May 2024 07:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TAHrfs3Y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBDD7D3F5
	for <linux-rdma@vger.kernel.org>; Wed, 22 May 2024 07:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716364655; cv=none; b=fAzvwiLHGMhA2c1WWxShpHV9F4LzzbIw8bHukeT+qBBKaK+V/luWB1qqAAQU9vqS3dvnv0K41dcapkHW+gntv/MPB2Ik5Xb249MlxxmZjOdPc9Me06Xm52DMWxC+eAia7RECk/l3lbRIuF2xNTFk3lkNkPmyhUVZSzaSRSSWVWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716364655; c=relaxed/simple;
	bh=VENSe/3fAzfnCYpmQ+vOkNLmF9dyos3VXFyL/qFe9Fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BCRczJzokOckohWrMuDDGan9LQ2fVNPkHcZ3fxo3r8U80FWnO6DOpriWP74uS3fbwJUK0RSXf5/ru+lZTY5KTBeHuFWU1MsGzpvaGEN+ZZjBv5ttBSc/BgmvrLcInhO4cXhMGIDzCaL3iXdSIdK3/HRxJzbisIz51KoHQqA3fI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TAHrfs3Y; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: sagi@grimberg.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716364650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q92zTs2hrsCm+boecXXID3PF9h+RjuwanNGz8edsrSQ=;
	b=TAHrfs3Y8yNuB1TtftU9qd8NmIrlGqNEHAiz55cvRNh2EB+gXX1SJF73QkCHDLcAa/IxJF
	dKU4jx2Xn21qPdexOcz22Qk+JtgpD2az77negdmh1Zl3poZG7xHiJC1N0xdL5IsUe8jJmM
	wtPc8NGA2ADTc4XtB+c+iLPhWV6CcDQ=
X-Envelope-To: jgg@nvidia.com
X-Envelope-To: chuck.lever@oracle.com
X-Envelope-To: linux-nfs@vger.kernel.org
X-Envelope-To: linux-rdma@vger.kernel.org
Message-ID: <573f7e57-7599-4540-9dd7-622f7eedde79@linux.dev>
Date: Wed, 22 May 2024 09:57:27 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Safe to delete rpcrdma.ko loading start-up code
To: Sagi Grimberg <sagi@grimberg.me>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Chuck Lever III <chuck.lever@oracle.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <DE53C92C-D16E-4FA7-9C0B-F83F03B1896F@oracle.com>
 <8cc80bdb-9f17-4f44-b2e6-54b36ac85b63@grimberg.me>
 <20240521124306.GE20229@nvidia.com>
 <5b0b8ffe-75ad-4026-a0e8-8d74992ab7b6@grimberg.me>
 <20240521133727.GF20229@nvidia.com>
 <46c36727-ef93-44ca-9741-df2325d4420c@grimberg.me>
 <20240521152325.GG20229@nvidia.com>
 <e558ee64-48fc-48b9-addd-eab7f9f861ad@grimberg.me>
 <20240521163713.GL20229@nvidia.com>
 <0f9ddfe5-67ff-470b-8901-d513dceb757e@grimberg.me>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <0f9ddfe5-67ff-470b-8901-d513dceb757e@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/5/21 22:30, Sagi Grimberg 写道:
> 
> 
> On 21/05/2024 19:37, Jason Gunthorpe wrote:
>> On Tue, May 21, 2024 at 07:10:53PM +0300, Sagi Grimberg wrote:
>>>
>>> On 21/05/2024 18:23, Jason Gunthorpe wrote:
>>>> On Tue, May 21, 2024 at 05:12:23PM +0300, Sagi Grimberg wrote:
>>>>>>>>> I also see that srp(t) and iser(t) are loaded too.. IIRC these are
>>>>>>>>> loaded by their userspace counterparts as well (or at least they
>>>>>>>>> should).
>>>>>>>> And AFIAK, these don't have a way to autoload at all. autoload
>>>>>>>> requires the kernel to call request_module..
>>>>>>> nvme/nvmet/isert are requested by the kernel.
>>>>>> How? What is the interface to trigger request_module?
>>>>> On the host, writing to the nvme-fabrics misc device a comma-separated
>>>>> connection string
>>>>> contains a transport string, which triggers the corresponding 
>>>>> module to be
>>>>> requested.
>>>> But how did nvme-fabrics even get loaded to write to it's config fs in
>>>> the first place?
>>> Something (/etc/modules-load?) loaded it intentionally.
>>> That something knows about a concrete intention to use nvme though...
>> This mechanism we are talking about is an add-on to /etc/modules-load
>> that only executes if rdma HW is present.
> 
> Still does not mean you want to use all the ulps though...
> 
>>
>> This is why it is a good place to load nvme-fabrics stuff, if you
>> don't have rdma HW then you know you don't need it.
> 
> Do I want to autoload nvme-fabrics if I have a nvme device? do I want
> autoload nvme-tcp if I have an ethernet nic? maybe wlan nic is also a
> sufficient reason?
> 
> I just don't see why the presence of an rdma device dictates that all 
> the ulps
> autoload. Does rxe/siw count as rdma HW?

RXE/SIW can be auto loaded with the command "rdma link ...".
And some kernel modules, for example ib_core.ko, udp_tunnel.ko, 
ip6_udp_tunnel.ko and ib_uverbs.ko, are also auto-loaded when rxe/siw 
kernel modules are loaded.

RXE/SIW are emulation RDMA kernel drivers. They are based on NIC HW. 
Normally all the NICs can support RXE/SIW RDMA drivers because RXE/SIW 
do not require additional NIC features.

To now almost all the NIC HW can support RXE/SIW, even some virtual NICs 
can also support RXE/SIW, for example, bonding, TUN and veth.

Zhu Yanjun

> 
>>
>> Autoloading is the version where you do 'mount -tnfs -o=rdma' and the
>> kernel automatically request_module's nfs and then nfs-rdma based only
>> on the command line options.
>>
>> I'm not sure this is even possible with configfs as the directories
>> you need to write into don't even exist until the module(s) are
>> loaded, right?
> 
> Right. The entry-point of the subsystem needs to be loaded (nvmet is 
> loaded by nvmetcli),
> the individual transports/drivers are auto-selected.


