Return-Path: <linux-rdma+bounces-3857-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE359308D6
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jul 2024 09:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 776BD1F216CE
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jul 2024 07:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBF5168DE;
	Sun, 14 Jul 2024 07:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b="n6jA7Lcq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from cluster-d.mailcontrol.com (cluster-d.mailcontrol.com [85.115.60.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272FE134C6
	for <linux-rdma@vger.kernel.org>; Sun, 14 Jul 2024 07:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.115.60.190
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720941058; cv=fail; b=L9tGaHC2O9ic1Ats6eqSk6crKu7jf2LYnNBTXE4GbWISdWGCVguQnZsFvNFbXp3vQHrUqmc4Jq3Dw+x4VubiaIxxtxO0WhUHPbnczbau8BGBjXubGj33YHtNMcpvWpd+Cml/KoFQAFAZ7QBJbsYx/YUFotVrMs52PZozdcogcZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720941058; c=relaxed/simple;
	bh=+3ZmhcrNsx0TDkYXhgWmMxqD+XDSHyw61VFo9khD+eY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aaht3mfXkjhzQp26R4AoeDsrTwRUUyvADOyW4y8CZBbsP7zVqU4+IdlRXC1tzo+M2x9ewudVve56q9zEX+gbqRwwOnazN+1y/h4a5wDGtkk/0iZdlm73ff3KMk3wNSGDbT9R5OiOiM5HEq/G/UdBdvIdsoQI1XYdG0eiYzc6f1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai; spf=pass smtp.mailfrom=habana.ai; dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b=n6jA7Lcq; arc=fail smtp.client-ip=85.115.60.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=habana.ai
Received: from rly15d.srv.mailcontrol.com (localhost [127.0.0.1])
	by rly15d.srv.mailcontrol.com (MailControl) with ESMTP id 46E66NZp400517;
	Sun, 14 Jul 2024 07:06:23 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly15d.srv.mailcontrol.com (MailControl) id 46E65hKk392748;
	Sun, 14 Jul 2024 07:05:43 +0100
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp17011030.outbound.protection.outlook.com [40.93.65.30])
	by rly15d-eth0.srv.mailcontrol.com (envelope-sender oshpigelman@habana.ai) (MIMEDefang) with ESMTP id 46E65flR392479
	(TLS bits=256 verify=OK); Sun, 14 Jul 2024 07:05:43 +0100 (BST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=anzMvdW+QK1WP9nyGbonmKUVbTSd7u1yNdlTsrc0gmYE6T4zKkONoKbUsU1LWE8RHX+X9dySHaOu1j2Uy+KgAVUIoCYIzzNqLXdo0u/8Ogtzgf9wKhKDNpnLtkKsxt7rRKn6IJ8ujR093jT+vsSh5ATmuz+vq3dQ8QUzQ0VtM82x+IS9AvSoMaVLfFs/D3uNfUJYDGmomoUbbKosBiyOhxAn65giBapQAtJLWLyD0QXl9qUMtJrjs8BMqPa1Cuu2/+4atp5FnG8nq5CsDvH0kHo0T9NHDDisINnyqgyDxgS6RtsUwF+0JJN+Cm0oAMp2NLJSNXxLdIyVKcLBGHAS8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3ZmhcrNsx0TDkYXhgWmMxqD+XDSHyw61VFo9khD+eY=;
 b=NjV+eZMHHEbbI7Tz8BrHErz3Mz1WrBPASSj0sCEH5oyhcUJXKxyHWgn+y1JBHFolGIrqq6QzjonflXJjK/kqB1L4o/XQ4CCd3/JxN1khG0NZJPPvDNvrYClFfC+hmRNMRFKF/UwbpLzr1Lfm5fzGIdcDANA5YYjTtNL+9hK1PNApHIUTyTJ/Wno/rCGCQTmGmKzvU4ylrTfw1PJAf8fCwrHI/J+Gq8KTzFUo4H71hpwpLq9YPJNXZ8MdUX+0DpAB195EHg1+iu2rt29DXjouz4UI57/MrAHeeqbZ82WDUqw0fXXyc8rWjPRcfSUXLx0dCW3I6lKCNomMbtZJrZ9kzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=habana.ai;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3ZmhcrNsx0TDkYXhgWmMxqD+XDSHyw61VFo9khD+eY=;
 b=n6jA7Lcqc0n337wcuj/vM+5RXzaUZjIO2Ao6U/t2BRUa2wtqoSJh3CWaIuIvln+Kp9QGY7DPVuafADTfTLwUfDULeB5w/m8a3cDov8pGywmRUEtERaGhz4ybhvDczTIxMeDYqFbHqdHHs/txahogulF0kR2Ue8TuXBpzFk1HN4l7z2x0xbG5V1G++e9i5b/kw6jZgj4MS5mDIFJyK6QfVQa22HIQ+0nJ0YExoDlDKcIoygGiFGXCiB6vPH0D6wy9NEiJL8cz61L3/ycjSCvY7Dns6IgmzO44z/bbwZZkVhFGWaiP2BsunOfXtJUi03jK9KxgeT/YutuEw9ay7PI8PA==
Received: from PAWPR02MB9149.eurprd02.prod.outlook.com (2603:10a6:102:33d::18)
 by PAWPR02MB10321.eurprd02.prod.outlook.com (2603:10a6:102:365::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.25; Sun, 14 Jul
 2024 06:05:35 +0000
Received: from PAWPR02MB9149.eurprd02.prod.outlook.com
 ([fe80::90a0:a4f0:72e9:58b9]) by PAWPR02MB9149.eurprd02.prod.outlook.com
 ([fe80::90a0:a4f0:72e9:58b9%3]) with mapi id 15.20.7762.025; Sun, 14 Jul 2024
 06:05:35 +0000
From: Omer Shpigelman <oshpigelman@habana.ai>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
CC: "ogabbay@kernel.org" <ogabbay@kernel.org>,
        Zvika Yehudai
	<zyehudai@habana.ai>,
        "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>,
        David Meriin <dmeriin@habana.ai>
Subject: Re: [PATCH 12/15] RDMA/hbl: direct verbs support
Thread-Topic: [PATCH 12/15] RDMA/hbl: direct verbs support
Thread-Index: 
 AQHavWrPBqHPlb7SS0KqSAV7MpL0ALHmf8YAgASMFACAAAyngIAABPYAgAghhYCAAq3bAA==
Date: Sun, 14 Jul 2024 06:05:35 +0000
Message-ID: <20997d5c-dcb7-4336-ae29-bccc081677b1@habana.ai>
References: <20240613082208.1439968-1-oshpigelman@habana.ai>
 <20240613082208.1439968-13-oshpigelman@habana.ai>
 <eebde0ac-9da1-4c52-b52f-a775e2c0d358@habana.ai>
 <20240707075742.GA6695@unreal>
 <e27efbb9-fdf5-4447-87ef-71e0fc34bbb4@habana.ai>
 <20240707090044.GF6695@unreal> <20240712131047.GC14050@ziepe.ca>
In-Reply-To: <20240712131047.GC14050@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=habana.ai;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR02MB9149:EE_|PAWPR02MB10321:EE_
x-ms-office365-filtering-correlation-id: 15808c7a-03b0-469e-6dfd-08dca3caf9e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?KzExRjgyYzZpbzZxbTZtT3JudThyQjNxTFhuWDY4QkN2Lzd5Sk12MEtkN1c4?=
 =?utf-8?B?cFR5UWppZmVNVzFickNPNnNGQWlEWEgrMEpydjZNaU1PdHR6Ni9uTFNhVlNI?=
 =?utf-8?B?RVZXcHB0UklZNEZUZHdPUlRWVS9LOG5CajFiWURoRjEzK2FVTjFJdEJOclo0?=
 =?utf-8?B?Q3AwdUZnbW8xM2ZHNUhXazR6UEVjeGFMQVh2N2h0OXhOemdNNlhUa0hNblYx?=
 =?utf-8?B?aVNpZXI3OEpXbDY1V2wyRzVhcU05S2JlZWVGMUorRnVMenZINXc5SFN2cUw4?=
 =?utf-8?B?WDltM1VUcDFkbVFlZWR5MmRNYUtKMm5RMm1zYllyL3IyMURMODAxalZtWVRq?=
 =?utf-8?B?azIvbG9pS21zSzQyd0d3OGpTRHRLd0I4VWIwMzIvNUQ5OWRkejNzUitXSWw4?=
 =?utf-8?B?TitXWkhPcWVFMFA3S0RkcHdSWTR4aDJFVXc1ZjROUWF1SlRzVHhnNEovS25B?=
 =?utf-8?B?dzhWZ1V3SHNvcW5sM282bFFSRjFPeG52cERRZUlLR3h3aTY5QWFoK0Q1eTVp?=
 =?utf-8?B?ajd6SVp4bklTYi9aMVQ3YkZQR3hYUlhDU1dKUDlwejYydEtIaG42RUlxZWxX?=
 =?utf-8?B?RVpiNC9LUGRjRkY5MHN3angzdHBSRmxKMFhUdFVNK2RxTHZjK2JjYlZobG5R?=
 =?utf-8?B?bWQxaFR2NUtjUWlsZWNwTkcyWlBKTlNyT3pSK2Z0QitLeDFubEczSlpZYkRv?=
 =?utf-8?B?cy96WlhTUTVUTUVWK2g2V3V0bEhkT0hzSENGKytIbkFFaENMK2tRODNYTUdH?=
 =?utf-8?B?dmMzK1dqSk4yMzMzeUNDM2V6OUt1bzhYVjFjczJrQmYyc015c2dxVitIcStB?=
 =?utf-8?B?UnFIdWNyTTZ3V2tVMTVmRG5Pa0hzS3pWdEJpemR4R296Wm1PNmJTTFZPeDcw?=
 =?utf-8?B?TDU0K2VqYWVFZnpDM0tHRHhBaWRsU1NvZStTaWl6YkdibThCSDdNMStQYmk2?=
 =?utf-8?B?RDN4RW1LTHJkUkRxRUVXZG1jTjFtdlorbkVDSyttNTVNbHdKN2l2THA0enFP?=
 =?utf-8?B?MDh6dUlqdW04dlFQc0RocXZlZTRFOTJwNGdORk43bGt0QUdVN3p6SGduWnpR?=
 =?utf-8?B?eHN3U2M2U2diOHlLenhsT3dhUUZDdnJ0QmZrbGxvVTRmM2pOQlIyemM4dEth?=
 =?utf-8?B?NlRIOFRHaVFNZGh2Z3Z5N0dibElnLy9Ea2o5VHJ4QlFtM3FEV215M1Ivelhj?=
 =?utf-8?B?c3pvcm1GYStVajBiL3hCYk1TSlJlVVE5d3o1N3c0dFdvRmJvMUxGT3crUGk1?=
 =?utf-8?B?ODVmQmZMTUI2WVNOTXdPM3lnTUYvOGtCb0dPY2Zoak5mUUhacGtGRC9kQXFu?=
 =?utf-8?B?Sjg4MjdYbHlSdHozS2VySUI0b1l2OW4wSUdYU2NVNGdIMWpCanpjbDlsRzd2?=
 =?utf-8?B?Zk5xbHgzM2ROWFFZKzNSWW9yblovNUx3VVQyWW1hZlAveXVKOXU4aFBBNVM1?=
 =?utf-8?B?VWxldm9IdlRZWXl2Y0xyUmNpc0ZMa3VjUWdxNi9rVDBOSjd0NldHS1NQSm5w?=
 =?utf-8?B?b3VqWkRvT3lGdk5uaUJvWTlXSDZUblV5YitTZGNVcWcvb0NOdmxiak8xOWQx?=
 =?utf-8?B?eVc0ZXEza0p6Vmp3S3lPWnRGQXY4Y2M3N2JnbDl3WUNRaE5odmVRVDBSWjRU?=
 =?utf-8?B?SWFrUVp6blFiRWhyUHBNQ0VQRjNRREVNZ3JrcS82N3VFQ0JOTHp4aXBkemxa?=
 =?utf-8?B?d2xLdWRyYmFuUE8veXNCbUVsYTlrTVFlY0VISzEyWjFGMWp3ZW1pZ3BHZzE1?=
 =?utf-8?B?OWZtbGFEODc0YnRta0l1OWo1V0lNZDN3NG1xd3huQnRCU0ZlMEh6bHFXc2FX?=
 =?utf-8?B?WEZNV0pWUWhlUTdSQnFuQkZzUjk0NHA5eXR5MmNDRFFPYjFFa1grcFQzcWxi?=
 =?utf-8?B?SzQ3cXV5K2trblFDeUFKWjRqREdFNWE4NC9tR053cUU5Y2c9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR02MB9149.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MjlhM2RLYTNNcWhPVEYyMDZHWVVLRXczOEtCcjZQejdyaDgza2U1NGlEeGk3?=
 =?utf-8?B?YVFxdXlIOURsSGVhTkJqMmpMR1l0NWE5SlJaNXQ4c1lJTmE1TWs5aFRGMHVD?=
 =?utf-8?B?bFBVKzBxN0dvWlAxUFQvV0pQM1JxUnVsR3JCSmpLcFB1TGtRUlpqV0Y2cTJv?=
 =?utf-8?B?VmFjSm5aSTJ4aVpzbWliNTh2U1ZvWXFUZm5WZkJxVkZST0tpQ0pZbi9kUkN3?=
 =?utf-8?B?Q3owVnNhbm9WN0tsbWJ4aTlrZVBXc3Eva3dVZWFLRjVRY3hvVVJBTm1GVFkz?=
 =?utf-8?B?RjNGbVVXVnR5S3VhQWhMK2FESW1BeWRmblplNTJWOGl2dXFFYTBTdUVzNWVw?=
 =?utf-8?B?SzEvKyt6VmlIc3ptYnZRemx5REU4dThaWFJWdEY1VXJSN01FdndVOWEySjF0?=
 =?utf-8?B?YVc2WHlzOXJBMisvL0hleWlsYmg5T0tSS2psbEFnNVJHL0JwOENQZ1VXR2Iz?=
 =?utf-8?B?bU9NY3N3QzE2US9sNFNlaGZxNmN1RmkyaGdLZnZUeU51aFVHNG9kR0pGUVgz?=
 =?utf-8?B?VW9IZHpFV2lHTlFKa3hUYytyWTFibzFyWGVoa3lsbEdyZFZSUnJMNXpmQlVh?=
 =?utf-8?B?a0toUGkxSmZkcmtMNHM5TlpLQ1YwcDJONzRRT29YMW1zdlhWVnJqSEIwbWVS?=
 =?utf-8?B?MXFsQzFCcEo1dGQrM3pSWjBjUlFDcjJBNGRITmxKL3VSRmZyTEhrS3dTaVhD?=
 =?utf-8?B?Z1lxb1cweXlHVnFDa0VlcHNaZktSUmF5RjZRZThmLzMzVmFaOTBNamNOK1My?=
 =?utf-8?B?d3FMVnFqeTFVS1BZRlU5aUVUOHpYdXFTcDk4Wmg5R3hJdUExUTVmTE5xK3F5?=
 =?utf-8?B?Qi9ubnVMdFpjTC9uWkVHc0FjZGxyMkV1eHFvallhOXF2WkFjVldJNXdUUUFa?=
 =?utf-8?B?K2lJTHl4SGw3MHVkMVh2V2ZJS1hPTDZWMmNZcHRIUHRsZFA4ZHBneERVY1dj?=
 =?utf-8?B?WkNTNmhqK1pjbE1iQ015NU52TFFpQTRManMzZDVJRUU5aVVwRzYrRTJTMHQw?=
 =?utf-8?B?bkhZUVVKNVJBWHc0WThlK3NSK3d3SGE0a0FpdzYrc0thOVNqRDlBd1M0VWlL?=
 =?utf-8?B?QUpFL0JJT2pMbTYyVm5iOUVTN3VuM2czbURVNWRKVE9rMWJGVk8wZmZDUURU?=
 =?utf-8?B?WndxMVhKaFIvU3F4akRRQnBZbE1lTXk2Y2wyQUZ2amZOTVVXc2piZ1JYRDl4?=
 =?utf-8?B?blNjeW9VdzBSOWpOTXlNQlZsZkpyU2RFVmdvb1BqNUhBQ3VVVGxQNngyZWZk?=
 =?utf-8?B?bzA4N0FDTS92cUxWWWh0S1ptcHFEZFFrZnpXSTRxcjZOd2t3cVdKNWgySDY3?=
 =?utf-8?B?UitKbUROSTh1S1F1WGMxVkE0QWc2cEk4YW9TWGtVS3dnWFd4aDA2M0dhS1RE?=
 =?utf-8?B?SVYvSWxqTDhwZHhML2g0blBTVTRzcU1mMG80RDJFc2NoSi9LWnllYVNvTWho?=
 =?utf-8?B?SlpkQ01ieHZNQkZkSTBlL05GV0wvRmMrYzUyREt1TlpUY3l6bWdjcjIxb2F0?=
 =?utf-8?B?azRiZ0V6RW5jWjJ6OGFsLzg2MmNTTDlPWkJ6dGhZS0N1anlnN1dkY0lQdlov?=
 =?utf-8?B?bitqRC93ajFrRHpXeXhoSVRqVDdjM24xL3FudjlRYWdqYVdYOHVjNnJVSGtE?=
 =?utf-8?B?NE5kSXlGU1lQOUZMaHhGQ3dEclRyZDNqTXJFTEphYzNLdzlXVFF6SXhWcWlF?=
 =?utf-8?B?OU1WR1lsTkovKzJYMDlUa1gva3EzOVpaZ3J6eDZJTHRObDE4ajEvMnRsTkxY?=
 =?utf-8?B?MXJUNll2MnVjeXQvMGEvcjcrRW5jek1aOEJ5OXZvaW8rTllOWCtwckZ0Vk5u?=
 =?utf-8?B?cGtFOWtvMjlGaGUyNDR6azE1Mmh4OHBIYllPSktGaUtKY01FSG9FQmt0bWZm?=
 =?utf-8?B?Tm9ubVNacktSeVFwcEZPVjhoQkxaLzZHdU5UVjZzWmpqdHl2L1RLMlFvMGQ4?=
 =?utf-8?B?VE8xWm1iV2hiY3FIbU5VTzJJbEpmaG9GZU1jcFFhT3RMU1RlSzg5K05IN3pI?=
 =?utf-8?B?U2c4aWw1WHhSekQ2Y1B1M1lOOVdTZElxTlYrWDhTdTJMQ1l3MHVyUVNFdm81?=
 =?utf-8?B?OHdTV2ZuZ0lHVVhvZUlkWFZ0RWU0MjNVWWJ4YzlSWGc0UFdwUmxSdUZsbzJ4?=
 =?utf-8?Q?5TC9ti98GbCIvay0kZKn4uFEV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A9DD480EAB3124F9A4076BA04CC0774@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GapGWDYJ8PRtgMMEKWCJh3c7vcmbSu3lKOtnc8HBVljqkTP+0aq7/tRjslxsqgrjiXrAXVYnLhyCIEomlD3Gb6+pnHGZlxEEEoIY1gLT/PgVuGsGhKHe6auZjzkvAcdGWyLxitGD9uIXReU4qJddWFRjiPK0cdXxuCLa5sTr3hOgKVn/JVMjQceWHin6U6NkMAn18IGQRlLW+OUkp3hEKxvyiV/7IVCMrJprAKU6h3JOvmgt0Wr7PnudlH/Keh5mqNMgez7BeW9xa3Zd+J4KwGO3xEJ/c0gXoqB18N7HJbzvAoQoHp7pL7uZomxMzRHphD3YpcpVunVYQnr9p5Azi/fk9C4CG42iSr2hg2271RedtO2K28ARRLDoUoSmSH2OHPDA9BrgW6K8HCJ2syWH3eKvZA2cXDahhxzERFwFQ8X7Dvx9E3GdwkJfVfptg72TaNZ2ji80+40NvKzjRitjmVAwdoaeeCOlGHyLQltuXNrEQPal6KNknWVY8Jjh3yJfOPJFlqtcZg2urvU2mNQay/Xk2eTEmHMEh2xKpqWFFw5UI85aGGFN1XHjBIWaopAeRT8B7UF2vyN+1z0zruPldl596XkpR038g2MrxvDHpLbP+bgDkDlAdpOWFf9sFjUc
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR02MB9149.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15808c7a-03b0-469e-6dfd-08dca3caf9e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2024 06:05:35.0751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eK4lboqbk1Oknfml+kn+uu7VUtSfDqvf8DyI0mTmJIr6OLw79B/Zan0z2xQak0/O7r9DC4AvXPpx1hA4eORblw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR02MB10321
X-MailControlDKIMCheck: cGFzcyBoYWJhbmEuYWkgW3Bhc3Nd
X-MailControl-OutInfo: MTcyMDkzNzE4NjpGUEtleTEucHJpdjot5CdCx7SeDGTogFdqNTnvV3P85l45avSKKirnInHXMoQq2RCrC8v0inH6d6adNtjeWT4tQ1QV8JlsC4DdojHwbAQPcK/fthwT1wnbwC9ONlJxLUkctJKfSjo1xFbP20brewuqEPV/EBqqO9lcXZAzkwFy4ZdnmR5Ww2IZdHs3HWJqzlMqvp69vEclrN/Powk9e1fNldRwHoAr60yjGnqLjCRVruBU7OJsRYFep0g2LwR1M77xd/UZDn1CiU3V5TxAy0L+LzMdEzfZCq8L5zfQCKlYjRQG4tsxcdDxU0FVMLd7RaA1zTukLXQzwSRioI/mO9BFloD5doHCD/DG2bq6
X-Scanned-By: MailControl 44278.2145 (www.mailcontrol.com) on 10.68.1.125

T24gNy8xMi8yNCAxNjoxMCwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPiBbWW91IGRvbid0IG9m
dGVuIGdldCBlbWFpbCBmcm9tIGpnZ0B6aWVwZS5jYS4gTGVhcm4gd2h5IHRoaXMgaXMgaW1wb3J0
YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+
IA0KPiBPbiBTdW4sIEp1bCAwNywgMjAyNCBhdCAxMjowMDo0NFBNICswMzAwLCBMZW9uIFJvbWFu
b3Zza3kgd3JvdGU6DQo+IA0KPj4+Pj4NCj4+Pj4+IEknZCBsaWtlIHRvIGFzayBpZiBpdCB3aWxs
IGJlIHBvc3NpYmxlIHRvIGFkZCBhIERWIGZvciBkdW1waW5nIGEgUVAuIFRoZQ0KPj4+Pj4gc3Rh
bmRhcmQgd2F5IHRvIGR1bXAgYSBRUCBpcyB3aXRoIHJkbWEgcmVzb3VyY2UgdG9vbCBidXQgaXQg
bWlnaHQgbm90IGJlDQo+Pj4+PiBhdmFpbGFibGUgZm9yIHVzIG9uIGFsbCBlbnZpcm9ubWVudHMu
IEhlbmNlIGl0IHdpbGwgYmUgYmVzdCBmb3IgdXMgdG8gYWRkDQo+Pj4+PiBhIGRpcmVjdCB1QVBJ
IGZvciBleHBvc2luZyB0aGlzIGluZm8sIHNpbWlsYXJseSB0byBvdXIgcXVlcnkgcG9ydCBEVi4N
Cj4+Pj4+IFdpbGwgdGhhdCBiZSBhY2NlcHRhYmxlPyBvciBtYXliZSBpcyB0aGVyZSBhbnkgb3Ro
ZXIgd2F5IHdlIGNhbiBhY2hpZXZlDQo+Pj4+PiB0aGlzIGFiaWxpdHk/DQo+Pj4+DQo+Pj4+IEkg
ZG9uJ3Qga25vdywgbmV3IHJkbWEtY29yZSBsaWJyYXJ5IHdpdGggbmV3IEFQSSB3aWxsIGJlIGF2
YWlsYWJsZSwNCj4+Pj4gYnV0IHN0ZG5hbG9uZSB0b29sIHdoaWNoIGNhbiBiZSBzdGF0aWNhbGx5
IGxpbmtlZCB3b24ndC4gSG93IGlzIGl0IHBvc3NpYmxlPw0KPj4+Pg0KPj4+DQo+Pj4gSWYgaXBy
b3V0ZTIgcGFja2FnZSB3YXMgbWFudWFsbHkgcmVtb3ZlZCBmcm9tIHNvbWUgcmVhc29uLg0KPj4N
Cj4+IElmIGl0IGlzIHVzZXIncyBkZWNpc2lvbiB0byByZW1vdmUgaXQsIGl0IGlzIHVzZXIncyBy
ZXNwb25zaWJpbGl0eSB0bw0KPj4gZGVhbCB3aXRoIGNvbnNlcXVlbmNlcy4NCj4gDQo+IFllcywg
cGxlYXNlIGRvbid0IGJyaW5nIGJhY2twb3J0aW5nIGNyYXp5bmVzcyB0byB1cHN0cmVhbS4gVXBz
dHJlYW0gaXMNCj4gc3VwcG9zZWQgdG8gYmUgYSB0ZWNobmljYWxseSBjbGVhbiBzZWxmIGNvbnRh
aW5lZCBzb2x1dGlvbi4NCj4gDQo+IElmIHlvdSBuZWVkIHNvZnR3YXJlIHRvIGJlIGRlcGxveWVk
IGluIHVzZXJzcGFjZSBpbiBiYWNrcG9ydA0KPiBlbnZpcm9ubWVudHMgdGhlbiB0YWtlIGNhcmUg
dG8gZ2V0IHRoYXQgc29mdHdhcmUgZGVwbG95ZWQsIGRvbid0IG1ha2UNCj4gaGFja3MgaW4gdXBz
dHJlYW0gdG8gYXZvaWQgZGVwbG95bWVudCB3b3JrLg0KPiANCj4gSmFzb24NCg0KWWVhaCwgbWFr
ZXMgc2Vuc2UuIEl0IHdhcyBhIGxvbmcgc2hvdCBidXQgc3RpbGwgd2FudGVkIHRvIGNoZWNrIGZv
ciB0aGlzDQpvcHRpb24uDQoNClRoYW5rcw0K

