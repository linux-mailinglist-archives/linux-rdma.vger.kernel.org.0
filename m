Return-Path: <linux-rdma+bounces-4865-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE84973C84
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 17:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F9F285F9A
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 15:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BB319ABCE;
	Tue, 10 Sep 2024 15:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="IdXrdM64"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2133.outbound.protection.outlook.com [40.107.244.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C265191F82;
	Tue, 10 Sep 2024 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725983011; cv=fail; b=OjPvMntZRXL0OzvRByu3W4nB5wMhv2Jm3tiCvdz4RaoNeesAfc9rCZavhV/v8Bsa1KIIvIP8Sh2yH1laOwtOLqirXPNtDSw8CuJ1Hh2hC6Z3Z59xY/5yA+5Of+GXe3ziQrFk1g6P0z+RiT5ho/ns3SpWkYBeHjI90fBtDza7FH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725983011; c=relaxed/simple;
	bh=O6ekUJ+wJ7pzuOuhlViJXotFdbNWTbp54B6+m5Ymb7c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t9FY6eXggG+VngSgoNwq4b9XX3z/AqlVR82UsCOOVHqzjCJrzy1/4LREdX0mdpXLvN+03UnvWaIN05NGVTuEb+ndJoHj55XdMNBMU154mXGMRvoxEOB/5julO0bdl61p/qXRr/l8LePgK17M7CJ9I9kgRmmosnYa9SX/f7sKoDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=IdXrdM64; arc=fail smtp.client-ip=40.107.244.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvWoC5T7CItnDDcsuc4mW5Jn66cgnhRZYxGNV8RiFMPgUU8gATHIQIEs7MSrFPCOkSWnxQsOxiEqwf3Ia2asadcpLuKzbE3ekn2YbNZYzrmY6CRK/VU960mUjzoQtNxLv4i7R/dxVoofdGFze6YBkAg0t/f9A6Mo3NxjmWnVWF9r8njqUWjvuSTOF8ptmNfZg4FaNW8Ayg9Zdizg/aEdO3Yu0Cc+mMJxNqHsOxpZQ1R+Dq2uvbR3+QOWoE0C77vxCWiT9SRTXlErv0RjmxJAdbdmZJx48Ir2u1odD4SnwYH4UGXmHmSsu/xY7MEkj9U0jgG6zJRiVjkSSbUJQOEP+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmARmxtpFt8Y+IJEY0iObZacIZCPIVljTDubhr3LLMw=;
 b=LLKO1NN/k1HKjpelh6sFxYAMhKi9ARM2VHIlIvS1JCB5ilA6aNebijDtOM5z3844Go/XoSSaFiTkKiFchUNoj5ecVExiej9QN2Ljpth/fx1diIsm8emz96mr+1DmC7rN4YW/tK1LD5fIU4tPzjLyv6klRyPTQyHg3Uq5qkZ+4QiwjfpU1jRHXG+vy+eBIFkMju1c9hrm3LMfsGTUeRfA/EHziAatn3wUDo8WFH/0c7rDGQ7YB03esRjPtk3mLVL18j85oqTA7C/E2u3T4ijVKKJHaPaYXxMg0u9rSanIujir6eftNVvJcJS/00bSctwHwgSeWe5S1GVSXldEz645/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmARmxtpFt8Y+IJEY0iObZacIZCPIVljTDubhr3LLMw=;
 b=IdXrdM64BcLvHwfbmxY8Ljh1nuRg6cURCUHPHCbr/ry5TONFiVLcy7KIf77u2C+MR67abQka7LGnQ5G6j92mSKwfXjjj0JWUy9c5u11HcYb/TZ9RzBRTREho0DZ18gJMxTc1PCPyUnXbPN5OOOydsLPYBN8Sc+KXQ25imuEqH1w8C/8UtnukGQPcFnH6v2LUHrH9w7MChI+mKX2MRC/1SrOqSGnUk4IqOmEf+8olCHUlxxcyHbtnzrZ0YjHp8v9mGz/tfW8ppm9fJs8aSFOtsLEZm+kfkyqGpu0kymDDHY7rYd10yz5B6c21QCV9pgjKP8LnDoYY6u4DkvvBMW/kuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 PH7PR01MB7932.prod.exchangelabs.com (2603:10b6:510:274::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.25; Tue, 10 Sep 2024 15:43:25 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%5]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 15:43:22 +0000
Message-ID: <aff4e2e3-0cb9-4ca3-84f7-2ae1b62715e4@cornelisnetworks.com>
Date: Tue, 10 Sep 2024 10:43:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: How to create/use RPMSG-over-VIRTIO devices in Linux
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, linux-remoteproc@vger.kernel.org,
 OFED mailing list <linux-rdma@vger.kernel.org>,
 "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>
References: <cff37523-d400-4a40-8fd1-b041a9b550b5@cornelisnetworks.com>
 <70cf5f00-c4bf-483a-829e-c34362ba8a70@cornelisnetworks.com>
 <ZuBiLgxv6Axis3F/@p14s>
Content-Language: en-US
From: Doug Miller <doug.miller@cornelisnetworks.com>
In-Reply-To: <ZuBiLgxv6Axis3F/@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH2PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:610:52::14) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|PH7PR01MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: 1daeaba7-11ba-4c0f-e589-08dcd1af4d40
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NzVKbyttOTk5Ym1kQU5tbVg5TkZNSTFLcitvN3ZicThBUFZFMWwyZlZKT29S?=
 =?utf-8?B?SzBFQUNHN0JSWFJaTmJqdUFOdE5maWhhVG0zbDhHc05CTTFMenl2am9ZM2o3?=
 =?utf-8?B?K0dOQWoyU2JIdHJzWEZCNFBhbVpRVDJXV0Nld1QrU0htc01kY0YwZFFWVWxY?=
 =?utf-8?B?cjEvcnZiU1dvN1ZPYkE2bXR4a1VmbXVXalNseDR3SjlKOXZFMkVTRUNNV3A5?=
 =?utf-8?B?d29xdmlIbHlHL045UG5nTE9GVUJnQkNUSWFBTFhNd1MrTUNLcGVvcVN5NjNG?=
 =?utf-8?B?NmhkOFVydlNEd2tER0dDR1lkK0NYU1hRcW50T0NLMWJ0bmhFNE9FRG5uSzdy?=
 =?utf-8?B?R0NMZGlyOGNYeURGWWI1R242Ti9mbE1lQlpBNjlTVXpaVEx6STI2SExuTGJ3?=
 =?utf-8?B?YkhGbE80NVNXcnZndTZ4UVhvdEJ6L2RUeU82QmpkdDFhNHppZGx3d0tpRFdV?=
 =?utf-8?B?bTMybyt2R3hKZWVaUkMvWEVnV0VaVkdDOTRVd2xjMlo0K3J0SkZNYURPZXNa?=
 =?utf-8?B?TUprWXZMNGN1eTdJMDVVMTkrUnRrOGZVako1VE8vQTdkbXZtVTZUSWFBd0hY?=
 =?utf-8?B?MjNaYjcwcU96R0hjbUxXWTFPYkNjdHJZY1RLU1piNlVnYnZnM1c2ZkdlUVFE?=
 =?utf-8?B?U0lqbmlvU1RFQjQwUEFBZlpyTWRXTjZWcEVJanR0SUEyb09kdEFYWmF4bEcv?=
 =?utf-8?B?NUxXb2NCR3cwTXV2L3Jvb3R3R3FwQ3I0K1RwY2J3WnIrdytDUGVIVFoxTXlS?=
 =?utf-8?B?UXo2THZVM1B1aExSQ0lJRlRyelVHNVkwL1ExUHpDWm9HVmg0YmVQRVZkNGFT?=
 =?utf-8?B?MGJFMWJnWkNPVkpLMmx3WkcrMHg0UTBRNGM2UWkyVUpQNGYxbmo2cGZxQUFo?=
 =?utf-8?B?akRuRlZucHJIV2FENGs0czV4N0E1cWJFMFVWMXVKc2I5UUZtT21uRkRFWEQz?=
 =?utf-8?B?cVVkZ2p6RGxnNytYQTBZQUVuem1OM3JwSXpOQnJyMU1EWXIvNlBLSjE1aGww?=
 =?utf-8?B?akZMN2VOVmZUc3BHOE0rT2NZQ1Y5SnNtNlVkVjB4c0hZNGRqaXBrc1dnQXFH?=
 =?utf-8?B?QnhSelZIcHpiZUhZYVlYRGZKckp3MWkwakJKRkZqdFNzUEdqVG0vK3Z4eU1t?=
 =?utf-8?B?bDR4UUlMS2x5c21tYW1IakpIY0YzY3J0bXFobjRFK0hGb1AxMjRBNjJ6RHVC?=
 =?utf-8?B?TUt5TUFCcGdreDU1ekJxeEFudjZjUzZYbHJoQS83OHNQZkRaUVc2UFZucEti?=
 =?utf-8?B?VVQrOVhiNG9WdmtEZ2oySFhsVU5iMENSbnpmM2VITGFzSkFGV3FiZHcwRXVV?=
 =?utf-8?B?MytqQmFhNEcwbWc1MlhjYkdjSG04UHlwNDF4SjlidEp2NnE0UUNDTEdST1Q5?=
 =?utf-8?B?RzhydlZHV1VYT2UzdlJ5Q1NiS1UyK2xGM3Z3b252WVZEWUR3akV1UEhIVFQ0?=
 =?utf-8?B?WktweWFqQTBaYWN5VStERVBnUDh6MVJPb2ZqMFN0a0M5Q1hhemdmOUZSNG1a?=
 =?utf-8?B?czhQcmFMSjM4bVRWRXBIdkZNRVBPWkdzRTFVSFZUdkJEdjQwR0VHRkIvcFdv?=
 =?utf-8?B?bW53UVZBN29qM1JEKy9pY1lML3plc0x2UU94SzhoZjNYS054bTZORTNHQ0h6?=
 =?utf-8?B?V1RlcFBMU2ZISmpxSFNhd3BEQlVzZXpXYVprWU9QM0FzaEFNVGJkaUJJQWxo?=
 =?utf-8?B?Q2FWYzMxTEVIckVXaVdLYzRvelY3UWs4cVFJcHpUeFdHSUc0eXM4c3EyajY5?=
 =?utf-8?B?QW0zVFptNDVOdGIwVGptYmwxMUR6NEpPT0tEbnlzY3E4NHd5QXhjN3dONmVU?=
 =?utf-8?B?eXg1UU4xTEdnVmNEYWI2UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVR0ZWI1MExobXZVS1Uzdk5PQlVkams4ck8wZnFrR21QY2Zja3kyVFZmS0x3?=
 =?utf-8?B?VjdyVW50TUdKa1VyODJlNkpqWlY3bGNFR3RNdVVweXBOejZtd1huMXFOSno4?=
 =?utf-8?B?UTB5L0E2djl2WmorQmRoeWlVQ1FzTHJMLzd1elhyaGhvODcyRzd6VC8wQkFL?=
 =?utf-8?B?dURmNDF1YTZxV0lBVjJVTFpiWnR2bDViZXROMFFYTmR1TStpVTJrQkg4VjF4?=
 =?utf-8?B?UkdpSHFjbkwxTUxWZkZzd2ZXSzFTY2RLWEtmMENHejhZZ3lXZGdlaTBLNWhK?=
 =?utf-8?B?SSthOGZML3hFQUhEakd1L1dmQms3empIeHoyZWUybGsrN2VVRFB3bHFMSHUy?=
 =?utf-8?B?dXJOMEg5UzAxR3E4RkdCb2xsYzhhNGNSREE1VkM1M0pOL1N1Q2ZBTlFKQnZs?=
 =?utf-8?B?d2lxMWNhajAzeENrWVJnZ1Y3UGNkekZ6ekpMSGRlRW81ZXErSWVLbFBOdnhU?=
 =?utf-8?B?WkZZR0R3ZzlJNnJWRCtEbzA4VXFRT0E2VzFkR2Ezc2Y0TFNIcEtqbTltRnhW?=
 =?utf-8?B?cWQxQUh2MkJOZkRNSlY1MTFGWHYzQU4wdVNQU0luK0o4WU9TSkg1eDhxMzdL?=
 =?utf-8?B?WmQzRnRPd2YxQTJxcERCbDV2RTAvTU15QTBKRzlBalJSWUo3MzZGMFFBNjFX?=
 =?utf-8?B?OTRBVDlzS1NrTUEzS0g1ZXlkY0FWNGZhT01uUk9NNGJBWEhBbG91Y3pKaDN3?=
 =?utf-8?B?VUVKaWVWRk5lWDYyVmZBSks1NEY5dU51TkNGYnE0UkRBdWUwN1ZjTHhIaUda?=
 =?utf-8?B?d1NXVHZXVHE3dThOZkQ4R2REQmdSUU9YZnYzQmREdTFwVlg3R0pqR1FwSTlN?=
 =?utf-8?B?K05LaEZ4WlJVRGNmMTZjVFovZlhLWjhMNmo0ZUpFbmVEOUpndHRvL2QyTGZR?=
 =?utf-8?B?U3BaeTZIcmtBYWx4TzJhSTRNZFdiUG5kUksrdVVlUUkxNDl6YWlqeHNmcVdY?=
 =?utf-8?B?NHVjQnFVaWYzNkJIM3R5ZTgveWNNaVM3UlZwZXVzVk04djM4RWtjM0lSMHdq?=
 =?utf-8?B?U2tRSUtXclQ0R3JFNDRVNFNXS3NXREIzVHlxRG5NZG9kdnpMZUZNTmhhcjl4?=
 =?utf-8?B?YXhLaFIvUFZyaWFzZ2lqS3N2UkJKNTl6ZUZHcVc1dlo0cy9DWXM0bXNQTUJw?=
 =?utf-8?B?bHNZamFLU0gzdEpCUjFvOE4yUkhrSUVJQnZES0dGUTNGSjlRWG5pdzJjNmsv?=
 =?utf-8?B?QS9KckNLK0x4enEraDhIL2sra1hITVMranZtRTZ0VHFiT1ZWcHhFblRkZjVR?=
 =?utf-8?B?YVRpamJaQmp0WmphbFVSMFhjeWlTZW1aaHpoeHk1bXNZRDhqMTRSUExYdmVV?=
 =?utf-8?B?Mkc3K3Zyd2tqR1I0UDdYajhmb3V4VHZrV3RseTVNbDFQNW9uS0wwc1JFMkpY?=
 =?utf-8?B?WDJvbXI2c0plNVlVcXZPOVNveUFnK3NhQUtiU2ZEdlpJRDBvYm95WTk5VGl2?=
 =?utf-8?B?YmpnV1FmTzdlcE55bVVWOFlHTlhacXBqYVdCdnoyeUFKamFOd29MMThBZWpY?=
 =?utf-8?B?THdzRTZFZEMrSk5LR21QOXpXaGlleDdHZnZJSXdVR0xGUGcwRHpmdWpaSlhm?=
 =?utf-8?B?VzBpc0xiQjJqZWh1aytDaVpSVFZQSUNla29ZblRHZ2hvZGd6OVhKdFNNU1FO?=
 =?utf-8?B?WWxGemhCWGFlNXVGNEFlYU9CNHBVd1RBSlIwYUtyeHdQU0lVd09FZ3dkaXBx?=
 =?utf-8?B?cHdDaUppV1hubHg4MFppWTBydHY5SjhEM1dHdW01cWVXVDFjMEczYUUwWHRv?=
 =?utf-8?B?c3VJdFR5aXVWODhValBMQ1ZYd2xCYmNVTFNkY0pic2FaY3JwL21vcWRvVFdV?=
 =?utf-8?B?UVUxYVVxOC9yS3AxRW1ScmxyT1JLSVNZMFlLeHh3Qk5oemx4T2hSdTRnUzZP?=
 =?utf-8?B?Kzk3UUcrOGNYU1pJUFN5VVVuTGJDVldLbnZ0cXNjaEJLY1pyMTlaSFo5NmtX?=
 =?utf-8?B?T3JJTlhCNjRJZnBFWVN6OHpiRC9nNmp2eVo3RmlXckxVV0tZWmg0a1dxSkNS?=
 =?utf-8?B?U0J2UWNSNUNGSm1hN2FkTjQyc0Vncy9URWZxWUlDSUt5ZVZrckVuWDBhRkhn?=
 =?utf-8?B?NEVrUVBqaWtTckRGUVZEU0lpaURmbGwxYzR6eE1UblpRelB1UzF3dFBuSE0y?=
 =?utf-8?B?aTF0VDI3WUM0MGpqSmpiNTM4bXZwdnMyYmlnOEZ3WUtzYXh0L1BxS292cDAy?=
 =?utf-8?Q?hwARYqu/3k1yUGtY0+qCse0=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1daeaba7-11ba-4c0f-e589-08dcd1af4d40
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 15:43:22.7387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vr7OO2UXPMtFvvWa0u6qCTxzBDQhUso+4YHxDzytwCyNDrKRFmGL0SDpSMmM3V/X6fQGWIxa1W3poVtOlz8RjrT273dLGwUOPN0NGlmIXgv/pBwR6LoTtao+PUrqJI0y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB7932

On 9/10/2024 10:13 AM, Mathieu Poirier wrote:
> On Tue, Sep 10, 2024 at 08:12:07AM -0500, Doug Miller wrote:
>> On 9/3/2024 10:52 AM, Doug Miller wrote:
>>> I am trying to learn how to create an RPMSG-over-VIRTIO device
>>> (service) in order to perform communication between a host driver and
>>> a guest driver. The RPMSG-over-VIRTIO driver (client) side is fairly
>>> well documented and there is a good example (starting point, at least)
>>> in samples/rpmsg/rpmsg_client_sample.c.
>>>
>>> I see that I can create an endpoint (struct rpmsg_endpoint) using
>>> rpmsg_create_ept(), and from there I can use rpmsg_send() et al. and
>>> the rpmsg_rx_cb_t cb to perform the communications. However, this
>>> requires a struct rpmsg_device and it is not clear just how to get one
>>> that is suitable for this purpose.
>>>
>>> It appears that one or both of rpmsg_create_channel() and
>>> rpmsg_register_device() are needed in order to obtain a device for the
>>> specific host-guest communications channel. At some point, a "root"
>>> device is needed that will use virtio (VIRTIO_ID_RPMSG) such that new
>>> subdevices can be created for each host-guest pair.
>>>
>>> In addition, building a kernel with CONFIG_RPMSG, CONFIG_RPMSG_VIRTIO,
>>> and CONFIG_RPMSG_NS set, and doing a modprobe virtio_rpmsg_bus, seems
>>> to get things setup but that does not result in creation of any "root"
>>> rpmsg-over-virtio device. Presumably, any such device would have to be
>>> setup to use a specific range of addresses and also be tied to
>>> virtio_rpmsg_bus to ensure that virtio is used.
>>>
>>> It is also not clear if/how register_rpmsg_driver() will be required
>>> on the rpmsg driver side, even though the sample code does not use it.
>>>
>>> So, first questions are:
>>>
>>> * Am I looking at the correct interfaces in order to create the host
>>> rpmsg device side?
>>> * What needs to be done to get a "root" rpmsg-over-virtio device
>>> created (if required)?
>>> * How is a rpmsg-over-virtio device created for each host-guest driver
>>> pair, for use with rpmsg_create_ept()?
>>> * Does the guest side (rpmsg driver) require any special handling to
>>> plug-in to the host driver (rpmsg device) side? Aside from using the
>>> correct addresses to match device side.
>> It looks to me as though the virtio_rpmsg_bus module can create a
>> "rpmsg_ctl" device, which could be used to create channels from which
>> endpoints could be created. However, when I load the virtio_rpmsg_bus,
>> rpmsg_ns, and rpmsg_core modules there is no "rpmsg_ctl" device created
>> (this is running in the host OS, before any VMs are created/run).
>>
> At this time the modules stated above are all used when a main processor =
is
> controlling a remote processor, i.e via the remoteproc subsystem.  I do n=
ot know
> of an implementation where VIRTIO_ID_RPMSG is used in the context of a
> host/guest scenario.  As such you will find yourself in uncharted territo=
ry.
>
> At some point there were discussion via the OpenAMP body to standardize t=
he
> remoteproc's subsystem establishment of virtqueues to conform to a host/g=
uest
> scenario but was abandonned.  That would have been a step in the right di=
rection
> for what you are trying to do.
I was looking at some existing rpmsg code, at it appeared to me that
some adapters, like the "qcom", are creating an rpmsg device that
provides specialized methods for talking to the remote processor(s). I
have assumed this is because that hardware does not allow for running
something remotely that can utilize the virtio queues directly, and so
these rpmsg devices provide code to do the communication with their
hardware. What's not clear is whether these devices are using
rpmsg-over-virtio or if they are creating their own rpmsg facility (and
whether they even support guest-host communication).

What I'm also wondering is what needs to be done differently for virtio
when communicating guest-host vs local CPU to remote processor. I was
hoping that RPMSG-over-VIRTIO would be easily adapted to what we need.
If we have to create a new virtio device (that is nearly identical to
rpmsg), that is going to push-out SR-IOV support a great deal, plus
requiring cloning of a lot of existing code for a new purpose.

Our only other alternative is to do something to allow guest-host
communication to use the fabric loopback, which is not at all desirable
and has many issues of its own.

>
>> Is this the correct way to use RPMSG-over-VIRTIO? If so, what actions
>> need to be taken to cause a "rpmsg_ctl" device to be created? What
>> method would be used (in a kernel driver) to get a pointer to the
>> "rpmsg_ctl" device, for use with rpmsg_create_channel()?
>>
>>> Thanks,
>>> Doug
>>>
>> External recipient


External recipient

