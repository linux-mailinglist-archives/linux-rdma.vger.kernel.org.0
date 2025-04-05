Return-Path: <linux-rdma+bounces-9163-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EC6A7C72E
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Apr 2025 03:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9325817C61F
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Apr 2025 01:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131B3747F;
	Sat,  5 Apr 2025 01:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RecXUKya"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2041.outbound.protection.outlook.com [40.107.95.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248A42E62BD;
	Sat,  5 Apr 2025 01:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743815259; cv=fail; b=Pp+OEcFRgiQDAcQiegciYblSGi7gFf/YosDLAMK5LH5QS+WgtOUidz3FNfg0PDz1vy0LyRkIzAmHmuF/Em/Jq19GRH8+ki5K3l75zgQ1fDqItcwMB9Uw51is9gODgp8yiZmnY0Xc1KXO5YVH0UmHHPaLl3PI8jeEgD1WSBgFJJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743815259; c=relaxed/simple;
	bh=eewU6Eqa0phRdS7pyjBInQD72nllFcu0cLBVY7Wgd3k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PE/apFF5MUqO0HHX9UmsboIcepRdfCwrOr8OoTrvKzSog1GkKbHZUV4IfQSNaez2DpHsktAIA5O0ccxEzGdDAKswIALViiFUu9jsrwuAQ3W09LVhTfAzcQlVLBX96YDpYPr10vwwtgvbeIiX0iqSscR3TDlNdB6zhJUqf0c5Ipc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RecXUKya; arc=fail smtp.client-ip=40.107.95.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E77UxC45wQG2D9eY3Hke0uDRHS3L2ZRPBYYxFKW+j1M+lA/8ohAOpKwgEMbhUoP+greS3p2hA6bcNIiDfR1Vdy4Tz3c5S6sNpkppZOLDk+fk9wQIAn0Zm8Q/tDeYNeyE1lGew1lCi+PC0tLy3jm4UrrtzExdcgihxS3TDyH9eR18kso+O7OTKL1h2MbZTEk1Ev1l/iWewquRRFaH/Z5rEqSjqWnYCkpd2u/G3RCjdU9eOKbG+gQyP0OE1Ri87kFXJqJI+U6TAofhldI75ODpSbU6nWJwJN+QPO08kveLb0tAZtTy/hy5WFwUPVMsnZ2p8gs+/quNmmo02O+3v6RmuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eewU6Eqa0phRdS7pyjBInQD72nllFcu0cLBVY7Wgd3k=;
 b=I380eDvDz3kyVFjaPfDc0nWWhECpdGzsu5ZIXRrmsYZbw5GkVFMWVTttIm6h7ZWd4IzwPX8mKsscFh9dIFNWaN/IbonaOKXoVT34In3u24M3x1vN2a2U4Bzq9Oo73Hru68OP55OgoMAfXTdU0cIZK4NO8/2dkeuYHtBf8U+Kye0q9366aA2IHBsCZTUlyLv69kAyHfI+d4Sbnfzikx4TTyyc72sjJRH9P3IKqnXJ/jnUbfPz6bn9bhMFbnS/ppuGCE+DqQsS8zkN0VlZxAN38U5uwNqrnbL1S1DfTlEvFTHUcKS0l4V7L5z1TV55hqNhI+j7lmdah0Igcd+zY1hU8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eewU6Eqa0phRdS7pyjBInQD72nllFcu0cLBVY7Wgd3k=;
 b=RecXUKyaqyBpCUiQslRCc60aoDK5CFV1hALNkXEKZcdo68NAzxA4XXCLXTPbmMgmFn0ITyaenLEm19bkQ6nwPQpkrqc0AjWffOjDktfimA2NBl7akhWWrZaxIbyOcUiEF//dIab4SXZZun0KTT0RQ+haaHHD5jOD05Dp8/QHmeWpgVBZyjgUlosstlaCtQiNaLizxJSBwOQ0bT6U09o/3v3Zc02tZLC+mPKyh8+WzQap0IhnG+XKviOstpc1M+vdGIGV6JFwjVgnf0bbXtj1jHmsTBqGFhuYeZR/d/1UkBCOhpP+HjEbQHLpm/uINEZQVbe5TeIsQVJsmbHnqSNAUg==
Received: from DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17)
 by IA0PR12MB8228.namprd12.prod.outlook.com (2603:10b6:208:402::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Sat, 5 Apr
 2025 01:07:33 +0000
Received: from DM6PR12MB4313.namprd12.prod.outlook.com
 ([fe80::4d58:4bbc:90a5:1f13]) by DM6PR12MB4313.namprd12.prod.outlook.com
 ([fe80::4d58:4bbc:90a5:1f13%3]) with mapi id 15.20.8606.027; Sat, 5 Apr 2025
 01:07:33 +0000
From: Sean Hefty <shefty@nvidia.com>
To: "Ziemba, Ian" <ian.ziemba@hpe.com>, Jason Gunthorpe <jgg@nvidia.com>
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
	<davem@redhat.com>, "andrew.tauferner@cornelisnetworks.com"
	<andrew.tauferner@cornelisnetworks.com>, "welch@hpe.com" <welch@hpe.com>,
	"rakhahari.bhunia@keysight.com" <rakhahari.bhunia@keysight.com>,
	"kingshuk.mandal@keysight.com" <kingshuk.mandal@keysight.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Thread-Topic: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Thread-Index:
 AQHbjuwVUw9AWIkXnUa8bbJSM0sPK7N6v4MAgAgXf4CAAAnsgIABEwYAgAAgrcCAAYj9gIAAAVBQgAARqYCAAABpoIABaOyAgAaJkiCAAUvLgIAAK6TwgABCwQCABHrAgIAAgVrA
Date: Sat, 5 Apr 2025 01:07:32 +0000
Message-ID:
 <DM6PR12MB4313B2D54F3CA0F84336EB71BDA82@DM6PR12MB4313.namprd12.prod.outlook.com>
References:
 <BN8PR15MB25131FB51A63577B5795614399A72@BN8PR15MB2513.namprd15.prod.outlook.com>
 <DM6PR12MB431329322A0C0CCB7D5F85E6BDA72@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+QTD7ihtQSYI0bl@nvidia.com>
 <DM6PR12MB43137AE666F19784D2832030BDA62@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+Qi+XxYizfhr06P@nvidia.com>
 <DM6PR12MB431345D07D958CF0B784AE0EBDA62@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+VSFRFG1gIbGsLQ@nvidia.com>
 <DM6PR12MB431332A6407547B225849F88BDAD2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <20250401130413.GB291154@nvidia.com>
 <DM6PR12MB43130D3131B760AF2A0C569ABDAC2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <20250401193920.GD325917@nvidia.com>
 <56088224-14ce-4289-bd98-1c47d09c0f76@hpe.com>
In-Reply-To: <56088224-14ce-4289-bd98-1c47d09c0f76@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4313:EE_|IA0PR12MB8228:EE_
x-ms-office365-filtering-correlation-id: 59e6f943-be21-4604-05d3-08dd73de3edb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ank2TnVUYjJwYmlPYWFXbXE0dThvbkhFaGY1OC95c1JqUDBqcEZHZFFnSVEw?=
 =?utf-8?B?VllCRkdRUHlHQ1Ztc1EzSmZxK3ljN2FETHFnU2RZMXZFSnZTVXVLYS9oNUlX?=
 =?utf-8?B?ODhkRDhpdEFFVTJUT1ArRzZGOXpaSTBFQkRzNUlsSG9JOHNUNHkrRWZWYnF5?=
 =?utf-8?B?MjFLZlhNWG41QTc2NC91cVJsOE5EcVFMejRnakRPaUJ2VUNMdzgxa0lkOU1o?=
 =?utf-8?B?WHNYSkJKdWxRQ2NEdEVlUjE4c29kV2tIMW5hVzFrWkgzbEJ0S3EyV0RoaVQv?=
 =?utf-8?B?U2gwM3hoR3hXMGlKTy9IQ2tYTytEYS9ibFBScEllTSs2RnR2TzRNcE9neWVw?=
 =?utf-8?B?Y3Njc1lxd1RXaVRFVDB5Q2UvTFp0dktCdDlIemVSZDJHTTY0OThISFZqV2Zq?=
 =?utf-8?B?dmNjU3R3NXU5TUZxTW1mQkhBQ1dGbXlCWWlBVStad3R3Y1FuRzBBQWFJcklv?=
 =?utf-8?B?TE84M2kyeHllcmxRM1VoeCtMcUg2R3FMQ0tTcUdMMTN3dlJyMlBjUmhkdnpX?=
 =?utf-8?B?NVQ0cURnNkZpS3BkQXQrcDlubnU1akdaQjlKTnltT2FkZkRDa3lDV051a25D?=
 =?utf-8?B?Uk9EK3ZFRGtRbUs4UitXblk4ai9TOFBLWVhRYkRqcWg3eHdsRG1VSEJGb2pY?=
 =?utf-8?B?SlBTd2tVTGYwVWZlS2NuTEl4azJjcVVMU0JpTU1sUmpyMXE2SGhrS2QzL1M5?=
 =?utf-8?B?d3hSRzdVZExLK2VJMEFYdkFDQVRjYUNnSURSUjhzbUxWMXdUVFdTU3B6a08y?=
 =?utf-8?B?OEF1b2lhdWpKenV6TFRCb0haemhjRkF1TWJoaE5VZXpkUWwxUFJFTDRFVzlo?=
 =?utf-8?B?Qld5eWFHQno5K2lreFBLRGRWQnVJakpUK0JhZnVlV0NBbVFnSnJ3djUwdXJt?=
 =?utf-8?B?em41WVFrRVNKNHFIb2xPeUdKdWNaYlcwbEJFTVVkM1hJM0Uxb0dxUDNnMGdF?=
 =?utf-8?B?d2ZkNS8vOCsvNW45UzVUZmhrNFdGT1Vjck5ENnV2N25ObEhheFRqcjlYUVJq?=
 =?utf-8?B?aXZqQXdFemhjNmFubkMyUmRFRGFLWUpGcnB1dmRIRlBoVmRWQjEvZDdBbVpw?=
 =?utf-8?B?QmREMTN1eW8zNXZ4ZmU0Uzl2dzZFaGhWeVI5SmROOFpTSVpDb2x2ZDJOWFR1?=
 =?utf-8?B?WmJQSVJOSkxhWGpJeGtVMmI0SXRSdU0xcEp0eGg4dGhYOHEyYjJLL2ZzNS9D?=
 =?utf-8?B?T1QwQjVZV1NVaktXWkhhS01vNkJlc3Zka2srbVBtbFVxVDAxTEppSlZ5U1Y0?=
 =?utf-8?B?L0xhWkowVGh6aXk1R1J1M1h3S09DRkxlVWh5NmtSZUdTT3FYTkFJejg3Tk0r?=
 =?utf-8?B?Y1phT2t6cHZIT3JUa1BsWmlZbmZZL0EwZUlRMWl6SkNCY1B5ay90NkJFK1lr?=
 =?utf-8?B?eVVmRWlNMzlPc0JrS0ZCdFNvQVU5Snp6aXo1L3pHSlhHUzIrb2RRREIyd3VS?=
 =?utf-8?B?VERyRGtmNEFvNUlwME9wdTRKZWljcjAzZE1NWklRR3pGM1ZWSlNFZFByU1VC?=
 =?utf-8?B?cmxGenlVbWIyNm9lZ1QyNTNaNHFpTDVWY2pRUUVKRklxc2dZQXdXQnF5a0Jt?=
 =?utf-8?B?ZlRqakVOQ0tQelY1eXhIbXVGTzcrUnowK0ZGMUN6b1hkTEFNS3lCekIweHQ5?=
 =?utf-8?B?bVJoSkZheVpGZkpsd2dQeFhtV01UNnhWM2xEQXdKNmRualZjei8xcVB4Nmts?=
 =?utf-8?B?anF4Wk1ZdlJJZHBQN0RYT3dWbDN5cElxSzE4MTM5TW5lWk03WnROaU42NnJC?=
 =?utf-8?B?YVQ0WjlMa014REVBYnhCMDU0d3VndnVKTlY3U1E4SUVoV2pROWI4KzBSbkJO?=
 =?utf-8?B?QUJ2WENPa3I3NjUxMmhya2owY1J1WHlGVWw3T0VaVU84L0N1TnhieWFkZ3NI?=
 =?utf-8?B?eEVHdko0czhES2k3aFgxS1JJVHVMSGV5ZHNBRlVTb1ArWThOelM4UVFKbG10?=
 =?utf-8?Q?MLLhV3vuqsh0T0aShB+l+5quWsxR8+9Q?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4313.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UGkzL0dvS1VKbFhWV3lZNGNyb1lDK2x1MmZ1eGlWWE9qeFNWNGE1T3JPMTJT?=
 =?utf-8?B?WnVnQnd5R2Y1MytjS285d2Q3Mi96NTNpQ0NxYlRSQVAyTm5UUHA0RlR4VVNQ?=
 =?utf-8?B?YlVYQUU5WWltWDVISFJ4OFUvK29BWTVYenA3QzNjbkFia3RRdUFoeWVKZm5T?=
 =?utf-8?B?dGRGNllRNXFXL0tPalh1d0JjdG9tSXlodW5QazREOXdpU1ZHVEJaNkN3U3lX?=
 =?utf-8?B?MmNrbkttM3BFVTBIeE1wYzhvVFQ5bXdGUlZRdERzRndPZ1FzVFN2R1o3UFcr?=
 =?utf-8?B?SUl2bTMxcTFmUzBBWVFKSFJsK2dad0xmUlhWaE1aRjkvMVh6VEI1M1pKRzUw?=
 =?utf-8?B?RkdqeVdNZVgzTjIyTkhYS1dVclJQZDBKMVhaNzUxdXVPTnZmQWpkbEpSUzBo?=
 =?utf-8?B?RlBLcGhKQ3JmZGp0TFpRSDZnOXNock1IU3cvTUcvRCtRa040c05RbjV4a0da?=
 =?utf-8?B?TUpLbThwTWpXdjVjd3NEc2RmTGsvSlpFYU15ME5rSUM0clFBdFFLN0lVRHlU?=
 =?utf-8?B?QTVxVDVmSUUwZHJ2cVFCUHVxV01FUTB0RExrTkIxWnE3UTJUQzB5ZkprNVhr?=
 =?utf-8?B?emNLR2NPY20vT25xRFpVZEhGbVpWeFhnNFFuT1RlTEJhSzhMQm5ZWmx5dSs0?=
 =?utf-8?B?cHBnTzNMTWRiS1FaYzQ4NUk0WDUybWhxUWgyYlVMTWZVaDJJS2RsYnFxYU4x?=
 =?utf-8?B?bERDejdyblRDaTlRbjBibmkvNFc4QzhJN2RUd2IyRGk0ZHdBRFIzZGYwQUdi?=
 =?utf-8?B?Vm0veUFxd2JIc1h3dlBYVzQ0WTBod3VvMFdsbDhrSmFBcEJIRmxWc20xUnFx?=
 =?utf-8?B?NlZnSTFvdFlGYVBUb2Z4SUlnaC92a3NrV1JXUXJSbWtXSlJSdTJReHd4cGZl?=
 =?utf-8?B?Nnp0My9mUjdNSDhLaFo5WFRoQ3BBVUZRT3RKZUNSVy84NVlDZHIvYldXeVh5?=
 =?utf-8?B?OVVPM2pmQ2dyMmpxTnNYcjM5V3FycEtGbDlPUEhaRFlhekdOVkdSNEh2cnBF?=
 =?utf-8?B?eHVFUFlaR3lUNjMydlZ2V1MwbmxtNVdUaldmeStwVkkwMHBwU2ZHdWhFc3Qx?=
 =?utf-8?B?N2h0TUtpUG92aU1BZ3U4VmJ3MzJyWWM2cHQ5SVFaR0kvdFRMTThZZzV6dk8r?=
 =?utf-8?B?OExqVmd1dVlHVFdBcnJKK3pLakpyUDdGYXM1RFd2KzRqNlBETFYrcG82V2gx?=
 =?utf-8?B?NER3VExLS04zN2xKWHlVb1FZR2htMmJpU3BBNEtLTi9ub3VJZ2tVTGxSQkk2?=
 =?utf-8?B?bVZoNWMvcG40MTBnV3lrL01LYUx5ZDJ0YWRBeTNiSUZybmNYTVpIQlB0QkNZ?=
 =?utf-8?B?Rkk4dUE1SzdhZC92YVVlcHFHM0lqR1ZOVTRzZ1lRWk9vMTVOVU1VS2h5Tkhr?=
 =?utf-8?B?V1JDaWp2bjdoL1lmV3RGaGs4Y0l3amc3RHRBK1Z1WUhNVWVzc1JSeWpQY082?=
 =?utf-8?B?SGhYUFcyb3dhWE5sUFlYaFNuQnE5Qkd5c3FodGZkOWIxZmdvVnB3WkNwaitY?=
 =?utf-8?B?VHpzUDJEU0V2TW5DOVZ3VHVZaGVhcEhwVVlZMnZsaGdHS1M2ZzluU0dIUmVS?=
 =?utf-8?B?S0JOMFJ4SkE2cWdiRjkzWTBKZjR5VjdHY09YQTZkZXlEcDJFNUF4UXhuY0FD?=
 =?utf-8?B?Y2NkKzhRYU9wVlZLNHFoQlluRHNaTEoxYk83Q3RCTzVNa3k3MUxyYzJab1Vs?=
 =?utf-8?B?b2JkM3cvWUs4emtEKzZsUU9Kb01VVjUxR1djZVFYL2c4ZEhOL0srQnEyTHph?=
 =?utf-8?B?TVJSNFY5SkxQZ1BidlduUHNZVTZPQytETjN4cWJ5TkpDaUNGQkFIWVl0SllI?=
 =?utf-8?B?aGVTN1p5ZXRaazRUYjdLSlZoOXJlR1FYQVd1TlJ1dDgrMkM3dU5ZeG5qQVdy?=
 =?utf-8?B?UGZPNHI3dGpuZE1GY3BvZHhOMFFXcWM2bTlQOGM3NkViWmt1MW53b1RkbFFl?=
 =?utf-8?B?VUo5S0hlMisydnJHZ1NTVmdKTHlQWUZzMmNyRFBFd3BIem42eDBQQW5FRWxj?=
 =?utf-8?B?SXp0NnV6K0tXVUw3V25yb2FtL295TEhuY3RvQ3BhUzlOMUNrRVlqMEZVTU0z?=
 =?utf-8?B?WlU1MHJaV3pjL1NvdS9qeFJxTTc0eStKSG9RZ2lFeWlaWjgxUjh4WEorN3JZ?=
 =?utf-8?B?N295d1pkYTV6T3lVM0VZUVdHR3pkSGZkRk1GVnBHajAyN1ZkamYvTkd6L1RS?=
 =?utf-8?B?aUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4313.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e6f943-be21-4604-05d3-08dd73de3edb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2025 01:07:33.0879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: to+1hSLU8nmgk8nZKr6qq++9DPjlVG3ZuLz0/5kOldlyfLjrjDzhVF7TfFC4G0SjnSBM7KI7LHSbjpdfhS4vvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8228

PiBPbiA0LzEvMjAyNSAyOjM5IFBNLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+ID4+IEkgZG9u
J3Qga25vdyB0aGF0IEkgY2FuIHRhbGsgYWJvdXQgdGhlIFVFQyBzcGVjLA0KPiA+DQo+ID4gUmln
aHQsIGl0IGlzIHRvbyBlYXJseSB0byB0YWxrIGFib3V0IFVFQyBhbmQgTGludXggdW50aWwgcGVv
cGxlIGNhbg0KPiA+IGZyZWVseSB0YWxrIGFib3V0IHdoYXQgaXQgYWN0dWFsbHkgbmVlZHMuDQo+
IA0KPiBXaGlsZSB0aGUgVUUgc3BlY3MgYXJlIG5vdCB5ZXQgb3V0LCBjb25jZXB0cyBjYW4gYmUg
ZGlzY3Vzc2VkLiBJIHJlY29nbml6ZSB0aGlzDQo+IG1heSBiZSBhbm5veWluZyB3aXRob3V0IHNw
ZWNzLg0KPiANCj4gVGhlIGZvbGxvd2luZyBpcyBteSB1bmRlcnN0YW5kaW5nIG9mIHRoZSBVRSBq
b2IgbW9kZWwuDQo+IA0KPiBBIGpvYiBJRCBpZGVudGlmaWVzICJ3aG8gYW0gSS4iIFRoZXJlIGFy
ZSB0d28gZGlmZmVyZW50IG9wZXJhdGlvbmFsDQo+IG1vZGVzOg0KPiANCj4gMS4gUmVsYXRpdmUg
QWRkcmVzc2luZw0KPiANCj4gICAgVGhlIGVuZHBvaW50IGFkZHJlc3MgaXMgb25seSB2YWxpZCB3
aXRoaW4gdGhlIHNjb3BlIG9mIHRoZSBqb2IgSUQuDQo+ICAgIEVuZHBvaW50cyBjYW4gb25seSB0
cmFuc21pdCBhbmQgcmVjZWl2ZSBvbiB0aGUgYXNzb2NpYXRlZCBqb2IgSUQuDQo+ICAgIFBhcmFs
bGVsIGFwcGxpY2F0aW9ucyB3aWxsIHVzZSB0aGlzIHRvIHJlc3RyaWN0IGNvbW11bmljYXRpb24g
dG8NCj4gICAgb25seSBwcm9jZXNzZXMgd2l0aGluIHRoZSBqb2IuDQo+IA0KPiAgICBQcm9jZXNz
ZXMgbXVzdCBiZSBncmFudGVkIGFjY2VzcyB0byB0aGUgam9iIElELiBJbiBhZGRpdGlvbiwNCj4g
ICAgbXVsdGlwbGUgcHJvY2Vzc2VzIG1heSBzaGFyZSBhIGpvYiBJRC4gU29tZSBtZWNoYW5pc20g
aXMgcmVxdWlyZWQgdG8NCj4gICAgcmVzdHJpY3Qgd2hhdCBqb2IgSURzIGFuIGVuZHBvaW50IGNh
biBiZSBjb25maWd1cmVkIGFnYWluc3QuIEhhdmluZw0KPiAgICBhIGRldmljZS1sZXZlbCBSRE1B
IGpvYiBvYmplY3QgYW5kIGEgcGF0aCB0byBhc3NvY2lhdGUgdGhlIGpvYg0KPiAgICBvYmplY3Qg
d2l0aCBhbiBlbmRwb2ludCBzZWVtcyByZWFzb25hYmxlLg0KPiANCj4gMi4gQWJzb2x1dGUgQWRk
cmVzc2luZw0KPiANCj4gICAgVGhlIHRhcmdldCBlbmRwb2ludCBhZGRyZXNzIGlzIG91dHNpZGUg
dGhlIHNjb3BlIG9mIHRoZSBqb2IgSUQuIFRoaXMNCj4gICAgYmVoYXZpb3IgYWxsb3dzIGFuIGVu
ZHBvaW50IHRvIHJlY2VpdmUgb24gYWxsIGpvYiBJRHMgYW5kIHRyYW5zbWl0DQo+ICAgIG9uIG9u
bHkgYXV0aG9yaXplZCBqb2IgSURzLiBUaGlzIG1vZGUgZW5hYmxlcyBzZXJ2ZXIgZW5kcG9pbnRz
IHRvDQo+ICAgIHN1cHBvcnQgbXVsdGlwbGUgY2xpZW50cyB3aXRoIGRpZmZlcmVudCBqb2IgSURz
Lg0KPiANCj4gICAgU2luY2UgdGhpcyBtb2RlIGltcGFjdHMgdGhlIGpvYiBJRHMgdHJhbnNtaXR0
ZWQgaW4gcGFja2V0cywNCj4gICAgcHJvY2Vzc2VzIG11c3QgYmUgZ3JhbnRlZCBhY2Nlc3MuIEEg
ZGV2aWNlLWxldmVsIFJETUEgam9iIG9iamVjdA0KPiAgICBzZWVtcyByZWFzb25hYmxlIGZvciB0
aGlzIGFzIHdlbGwuDQo+IA0KPiAgICBBbiBvcHRpb25hbCBtZWNoYW5pc20gdG8gcmVzdHJpY3Qg
YSByZWNlaXZlIGJ1ZmZlciBhbmQgTVIgdG8gYQ0KPiAgICBzcGVjaWZpYyBqb2IgSUQgaXMgbmVl
ZGVkLiBUaGlzIGVuYWJsZXMgYSBzZXJ2ZXIgZW5kcG9pbnQgdG8gaGF2ZQ0KPiAgICBwZXIgY2xp
ZW50IGpvYiBJRCByZXNvdXJjZXMuIEpvYiBJRCB2ZXJpZmljYXRpb24gaXMgdW5uZWNlc3NhcnkN
Cj4gICAgc2luY2UgdGhlIGpvYiBJRCBhc3NvY2lhdGVkIHdpdGggYSByZWNlaXZlIGJ1ZmZlciBv
ciBNUiBkb2VzIG5vdA0KPiAgICBpbXBhY3QgdGhlIHBhY2tldCBqb2IgSUQuDQo+IA0KPiBVRSBp
cyBnb2luZyB0byBuZWVkIHNvbWUgb2JqZWN0IHRvIHJlc3RyaWN0IHJlZ2lzdGVyZWQgdXNlci1z
cGFjZSBtZW1vcnkuDQo+IEhhdmluZyB0aGUgUEQgYXMgdGhlIG9iamVjdCBzdXBwb3J0aW5nIGxv
Y2FsIG1lbW9yeSByZWdpc3RyYXRpb24gaXNvbGF0aW9uDQo+IHNlZW1zIG9rLiBUaGUgVUUgb2Jq
ZWN0IHJlbGF0aW9uc2hpcCBjb3VsZCBsb29rIGxpa2Ugam9iICA8LSAxIC0tLSAwLi4qIC0+DQo+
IGVuZHBvaW50ICA8LSAwLi4qIC0tLSAxIC0+ICBQRC4NCg0KVGhlcmUncyBhbHNvIHRoZSBNUiBy
ZWxhdGlvbnNoaXA6DQoNCkpvYiA8LSAxIC0tLSAwLi5uIC0+IE1SIDwtIDAuLm4gLS0tIDEgLT4g
UEQNCg0KVGhlcmUncyBkaXNjdXNzaW9uIG9uIGRlZmluaW5nIHRoaXMgcmVsYXRpb25zaGlwOg0K
DQpKb2IgPC0gMC4ubiAtLS0gMSAtPiBQRA0KDQpJIGNhbid0IHRoaW5rIG9mIGEgdGVjaG5pY2Fs
IHJlYXNvbiB3aHkgdGhhdCdzIG5lZWRlZC4gIFdpdGhvdXQgaXQsIHRoZSBKb2IgYmFzaWNhbGx5
IGFjdHMgaW4gdGhlIHNhbWUgcm9sZSBhcyBhIHNlY29uZCBQRCwgd2hpY2ggZmVlbHMgb2ZmLiAg
UGx1cywgc29tZSBOSUMgaW1wbGVtZW50YXRpb25zIG1heSBuZWVkIHN1Y2ggYSByZXN0cmljdGlv
bi4NCg0KLSBTZWFuDQo=

