Return-Path: <linux-rdma+bounces-8224-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C03FAA4ADC8
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Mar 2025 21:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 460517A73AC
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Mar 2025 20:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEB91E7C2B;
	Sat,  1 Mar 2025 20:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kOovh6DV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06D11C3BE9
	for <linux-rdma@vger.kernel.org>; Sat,  1 Mar 2025 20:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740860097; cv=none; b=rOmrbcorVlXsXd+nreTacHLzDKWUosoQlyGuUvQ3G2C9xWSL2sPP8FVUtHuh9s9x6hR1jYusygAivkjsG5zt8pAkD+azQhjVNXRI7zD4yFziFvS1OJojmwK4D3LfhpDQEE2Eo7hCDU4Q+IN+rPwKea10hxCx+EII+RC1/2GvEWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740860097; c=relaxed/simple;
	bh=7xahV4LWgnSHwCd0aqv4V2lS5kdQ4MfIDM2TwvZ/ngE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cWx9khnw2zDj++ZXLpM4/VPaHkTQM4mlZZK6DnlsDE5/xlLkRgsLDnkI7lMRFbsHjgmhzxzOrpVuk1zlG0ESkSNO4Qkx+cQdKzi8eED0watVq12m7jkRmAxa83LP06uD9yvB/59b7XgvYw92hUvabZSFBT44/XBsAolZKzOTL/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kOovh6DV; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f398dcfa-ec77-4b37-b10f-4dc216098f64@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740860092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YaeBOHu1NmfoayGiRJmdTD8BPIutMfYNjb6kgD3joSU=;
	b=kOovh6DVc+9qXt3uZaqjYAzL0ReySziWlxIwLWcZ11Tkev+D5RbMYimrz3SJgG+lu8GX2O
	rdIM5dm5rswwfu1yWCzX9M0ckweyRCcfF0PWW/JOUIktMs7P5+NxvW1EuprY/nqN5pg7z9
	l0ESr001g82GLkhUH4TwShxqCvPQb74=
Date: Sat, 1 Mar 2025 21:14:46 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [bug report] RDMA/rxe: Failure of ibv_query_device() and
 ibv_query_device_ex() tests in rdma-core
To: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
 "'zyjzyj2000@gmail.com'" <zyjzyj2000@gmail.com>
Cc: "'linux-rdma@vger.kernel.org'" <linux-rdma@vger.kernel.org>,
 "'jgg@ziepe.ca'" <jgg@ziepe.ca>, "'leon@kernel.org'" <leon@kernel.org>
References: <OS3PR01MB98657565E6FAB0184E7B72B8E5C22@OS3PR01MB9865.jpnprd01.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <OS3PR01MB98657565E6FAB0184E7B72B8E5C22@OS3PR01MB9865.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/2/26 11:32, Daisuke Matsuda (Fujitsu) 写道:
> Currently, two testcases in rdma-core fail with the latest kernel, leaving the console log below.
> =====
> $ ./build/bin/run_tests.py -k device
> ssssssss....FF........s
> ======================================================================
> FAIL: test_query_device (tests.test_device.DeviceTest.test_query_device)
> Test ibv_query_device()
> ----------------------------------------------------------------------
> Traceback (most recent call last):
>    File "/home/ubuntu/rdma-core/tests/test_device.py", line 63, in test_query_device
>      self.verify_device_attr(attr, dev)
>    File "/home/ubuntu/rdma-core/tests/test_device.py", line 200, in verify_device_attr
>      assert attr.sys_image_guid != 0
>             ^^^^^^^^^^^^^^^^^^^^^^^^
> AssertionError
> 
> ======================================================================
> FAIL: test_query_device_ex (tests.test_device.DeviceTest.test_query_device_ex)
> Test ibv_query_device_ex()
> ----------------------------------------------------------------------
> Traceback (most recent call last):
>    File "/home/ubuntu/rdma-core/tests/test_device.py", line 222, in test_query_device_ex
>      self.verify_device_attr(attr_ex.orig_attr, dev)
>    File "/home/ubuntu/rdma-core/tests/test_device.py", line 200, in verify_device_attr
>      assert attr.sys_image_guid != 0
>             ^^^^^^^^^^^^^^^^^^^^^^^^
> AssertionError
> 
> ----------------------------------------------------------------------
> Ran 23 tests in 0.007s
> 
> FAILED (failures=2, skipped=9)
> =====
> 
> It seems sys_image_guid is set here:
> https://github.com/torvalds/linux/blob/2ac5415022d16d63d912a39a06f32f1f51140261/drivers/infiniband/sw/rxe/rxe.c#L82
> 
> I tried rolling back to commit 57a7138d0627, just before this patch was applied, and found the error resolved.
> [PATCH 1/1] RDMA/rxe: Remove the direct link to net_device
> https://lore.kernel.org/all/20241220222325.2487767-1-yanjun.zhu@linux.dev/

Thanks. The following commits are to fix this problem in upstream and 
for-next.

Because the patchset 
https://patchwork.kernel.org/project/linux-rdma/cover/20250119172831.3123110-1-yanjun.zhu@linux.dev/ 
exists in for-next, but this patchset does not exist in upstream.

Thus, 
https://patchwork.kernel.org/project/linux-rdma/patch/20250301193530.904720-1-yanjun.zhu@linux.dev/ 
is for for-next.

https://patchwork.kernel.org/project/linux-rdma/patch/20250301193351.901749-1-yanjun.zhu@linux.dev/ 
is for upstream.

Thanks,
Zhu Yanjun

> 
> I think the root cause lies in ndev patches applied in the past two months,
> but I am not very sure if it is good idea to revert them. I would like opinions
> from Zhu and other developers.
> 
> Thanks,
> Daisuke Matsuda
> 


