Return-Path: <linux-rdma+bounces-8245-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A1AA4B853
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 08:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C49816A655
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 07:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16C51E9B25;
	Mon,  3 Mar 2025 07:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hQZcxHSK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503F21E8327
	for <linux-rdma@vger.kernel.org>; Mon,  3 Mar 2025 07:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740986877; cv=none; b=putovJ0TToHLvkOT1SuzUqFm4tTFz2w9wfJXD4bZxby1N8JvveyGW86L02Y0Sc6pxcmmfbuDk8GU7PHVeLay/DWXCoB0A+LBhW7gKk3qUiV95gVMYk4iOWRztpFYz8AeSQIVWzjNuHrgKmAW+NsxDie/YHU8r5GvEq6aKGHMNIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740986877; c=relaxed/simple;
	bh=6cbzXu5TS0Lmf8vH8HMuPDygk7pRj6xr/pBs17lrS34=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lFAO8rpnrT/RwYrjJF57azVD/uHoeW58VoXGJESXSrCPWKhXJVp3cu5wqK77bsZo3P4mnBff8IehEXuwUpvLmfm8K2OjNF8huBPtQOA9TP9PrnYdA6t66IMQxXR4EC5B0SUC2B57FBID3HRQ0eZ5hPvUfeR2smrAjRBjdHSGN5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hQZcxHSK; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <afc3067b-afca-4ece-9655-ace0d82b6468@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740986872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C4d5LGoQtwsoDWxzohPzKRQaNJ/Oj2osqp+x/cduhF8=;
	b=hQZcxHSKgYJEtE+r1DX74fMwAnnR0QTyvkVLn/g8Nc0SZIdc3QcyfqZiVFsfgWmX8qGf+O
	4DNn0qUoso0muyaC3qgFwrxU1smowyfy3Qmqyf3TnWux24M9c8WGZ0f2GVTN3GhDzublsD
	OeeUxNx4RToblUGdJEXTbByZlxC8DPw=
Date: Mon, 3 Mar 2025 08:27:28 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-rc 1/1] RDMA/rxe: Fix the failure of
 ibv_query_device() and ibv_query_device_ex() tests
To: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
 "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>, "jgg@ziepe.ca"
 <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20250302215444.3742072-1-yanjun.zhu@linux.dev>
 <OS3PR01MB98654DABDD313E46C2727774E5C92@OS3PR01MB9865.jpnprd01.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <OS3PR01MB98654DABDD313E46C2727774E5C92@OS3PR01MB9865.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/3/3 5:21, Daisuke Matsuda (Fujitsu) 写道:
> On Mon, March 3, 2025 6:55 AM Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
>>
>> In rdma-core, the following failures appear.
>>
>> "
>> $ ./build/bin/run_tests.py -k device
>> ssssssss....FF........s
>> ======================================================================
>> FAIL: test_query_device (tests.test_device.DeviceTest.test_query_device)
>> Test ibv_query_device()
>> ----------------------------------------------------------------------
>> Traceback (most recent call last):
>>     File "/home/ubuntu/rdma-core/tests/test_device.py", line 63, in
>>     test_query_device
>>       self.verify_device_attr(attr, dev)
>>     File "/home/ubuntu/rdma-core/tests/test_device.py", line 200, in
>>     verify_device_attr
>>       assert attr.sys_image_guid != 0
>>              ^^^^^^^^^^^^^^^^^^^^^^^^
>> AssertionError
>>
>> ======================================================================
>> FAIL: test_query_device_ex (tests.test_device.DeviceTest.test_query_device_ex)
>> Test ibv_query_device_ex()
>> ----------------------------------------------------------------------
>> Traceback (most recent call last):
>>     File "/home/ubuntu/rdma-core/tests/test_device.py", line 222, in
>>     test_query_device_ex
>>       self.verify_device_attr(attr_ex.orig_attr, dev)
>>     File "/home/ubuntu/rdma-core/tests/test_device.py", line 200, in
>>     verify_device_attr
>>       assert attr.sys_image_guid != 0
>>              ^^^^^^^^^^^^^^^^^^^^^^^^
>> AssertionError
>> "
>>
>> The root cause is: before a net device is set with rxe, this net device
>> is used to generate a sys_image_guid.
> 
> I have tested this patch, and the problem I reported last week is now gone.
> The fix looks good. Thanks!

Thanks a lot.

Zhu Yanjun

> 
> Tested-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> Reviewed-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> 
>>
>> Fixes: 2ac5415022d1 ("RDMA/rxe: Remove the direct link to net_device")
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>>   drivers/infiniband/sw/rxe/rxe.c | 25 ++++++-------------------
>>   1 file changed, 6 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
>> index 1ba4a0c8726a..e27478fe9456 100644
>> --- a/drivers/infiniband/sw/rxe/rxe.c
>> +++ b/drivers/infiniband/sw/rxe/rxe.c
>> @@ -38,10 +38,8 @@ void rxe_dealloc(struct ib_device *ib_dev)
>>   }
>>
>>   /* initialize rxe device parameters */
>> -static void rxe_init_device_param(struct rxe_dev *rxe)
>> +static void rxe_init_device_param(struct rxe_dev *rxe, struct net_device *ndev)
>>   {
>> -	struct net_device *ndev;
>> -
>>   	rxe->max_inline_data			= RXE_MAX_INLINE_DATA;
>>
>>   	rxe->attr.vendor_id			= RXE_VENDOR_ID;
>> @@ -74,15 +72,9 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
>>   	rxe->attr.max_pkeys			= RXE_MAX_PKEYS;
>>   	rxe->attr.local_ca_ack_delay		= RXE_LOCAL_CA_ACK_DELAY;
>>
>> -	ndev = rxe_ib_device_get_netdev(&rxe->ib_dev);
>> -	if (!ndev)
>> -		return;
>> -
>>   	addrconf_addr_eui48((unsigned char *)&rxe->attr.sys_image_guid,
>>   			ndev->dev_addr);
>>
>> -	dev_put(ndev);
>> -
>>   	rxe->max_ucontext			= RXE_MAX_UCONTEXT;
>>   }
>>
>> @@ -115,18 +107,13 @@ static void rxe_init_port_param(struct rxe_port *port)
>>   /* initialize port state, note IB convention that HCA ports are always
>>    * numbered from 1
>>    */
>> -static void rxe_init_ports(struct rxe_dev *rxe)
>> +static void rxe_init_ports(struct rxe_dev *rxe, struct net_device *ndev)
>>   {
>>   	struct rxe_port *port = &rxe->port;
>> -	struct net_device *ndev;
>>
>>   	rxe_init_port_param(port);
>> -	ndev = rxe_ib_device_get_netdev(&rxe->ib_dev);
>> -	if (!ndev)
>> -		return;
>>   	addrconf_addr_eui48((unsigned char *)&port->port_guid,
>>   			    ndev->dev_addr);
>> -	dev_put(ndev);
>>   	spin_lock_init(&port->port_lock);
>>   }
>>
>> @@ -144,12 +131,12 @@ static void rxe_init_pools(struct rxe_dev *rxe)
>>   }
>>
>>   /* initialize rxe device state */
>> -static void rxe_init(struct rxe_dev *rxe)
>> +static void rxe_init(struct rxe_dev *rxe, struct net_device *ndev)
>>   {
>>   	/* init default device parameters */
>> -	rxe_init_device_param(rxe);
>> +	rxe_init_device_param(rxe, ndev);
>>
>> -	rxe_init_ports(rxe);
>> +	rxe_init_ports(rxe, ndev);
>>   	rxe_init_pools(rxe);
>>
>>   	/* init pending mmap list */
>> @@ -184,7 +171,7 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
>>   int rxe_add(struct rxe_dev *rxe, unsigned int mtu, const char *ibdev_name,
>>   			struct net_device *ndev)
>>   {
>> -	rxe_init(rxe);
>> +	rxe_init(rxe, ndev);
>>   	rxe_set_mtu(rxe, mtu);
>>
>>   	return rxe_register_device(rxe, ibdev_name, ndev);
>> --
>> 2.34.1
>>
> 


