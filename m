Return-Path: <linux-rdma+bounces-15884-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAl1Nx0PcmksawAAu9opvQ
	(envelope-from <linux-rdma+bounces-15884-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 12:50:53 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9B3663D4
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 12:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5ECB86AB385
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jan 2026 11:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4DC3EF0C1;
	Thu, 22 Jan 2026 11:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Oe7Ou5dq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010060.outbound.protection.outlook.com [40.93.198.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF5735770B;
	Thu, 22 Jan 2026 11:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769080718; cv=fail; b=TdlS3qiXpXuFFtK264inp4Fm24WGeZ2wVxpRORCqviURMcVKb8ouN55Ip6keVqq2mZXWzHVb4mOhvKBF6/nuhb2Jm0OVS0e4QLsSsik3OgQytd/BgiZKs04xVvty4rnr3Ykm6mUk4Fv5nWVM05PXtfXFfRIQGJZZNb2U/DshCVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769080718; c=relaxed/simple;
	bh=Zdbf+2/CKwBSPvAqjMnJSGw84hLZweOMrML1zNWbtN0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lXanm2hjQyH3DYkL9XooBnEjTICT7PVy8MiGijerXtSU0S/xFA6y94ZSOwRu+zDf+T7rSaRQR+VPu1GLfTbEz1z8OtgWJiT69n3JPfYqUWnOWURvW6QTjXpfhqX/UboEfttXLQiGtM9SMW0gpEvkSCN11nPHodA5SHdpFkIiLt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Oe7Ou5dq; arc=fail smtp.client-ip=40.93.198.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/uyxEyQ49qt0TYiQS7alsfu8f4OU4FH4Uqek3cDwjaD/BEHX8ZeZzPcDTN53Q/XvRA56lGguv6zsnvoWV2V8UuIz6jwMf6vxzHU4qfgOHiNXLinz4zCHS7g29YOsqx4YLrhB+YE3ZApUrpWkJuzMBroGDbJOSamhn9q0JwsGPuTtoG2IlBnqKc9116AUajLB1PB/4LKUzuhqydfTOAS0+adrN5mddA8eHzNY6a9rvsh4DnooUI6qHdX+e0z5yFS68ElkOfne/6hfFXb73BvIuzikZbWo1svNAewQjpuDmlsbaOUnXMj3Fj1l9YOU8i2qC7UAEIEGUqUSVfeQrjSxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zdbf+2/CKwBSPvAqjMnJSGw84hLZweOMrML1zNWbtN0=;
 b=YrxSs1s6ebiUZ3notd2zl0TaQYCZ4c7mhSxxw6GqYEW4nji2waSQsDi9mO9miK14y4j+eTPCnHLGQYjsq+owCsnXvmf05iqfAEjcHhJgeWs/8lOvyVFzM75q5eN7kCCMFBDn8c1S13WRfOMz3Jkyo7JFYZPZmbxN0KM6DQbbeRWVR2e+Ci3HhAffqU8O0Gz8lECRwtotN3TvVgGD4zSiEwsiGhIsAvst/YHtfIBlW2ArtAHwdAt4/yglYcx14PcQ/4UlrRj8GJ9GdD9GUqcvP6yBmT84pI5Fuh8aZpJse9KNBqeee+C6Gixpbx9RfhKtb2teSfpwdWL0tkKy5YdEPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zdbf+2/CKwBSPvAqjMnJSGw84hLZweOMrML1zNWbtN0=;
 b=Oe7Ou5dqirgdXg3/scM5vv6L/jHWc8ZQgHhTHlY19DWEq4uBPS00g1H99ByVFS2ZFRAi1xZqDol0S+H/3jEWRL5KZmxv8EdwgRu7EWB1yavbj2Dc8vO6b+5KVFaapDxw7sczcT2ZABEmxrkYo+ceq523uCiTO7x4FyJX6I2bm/+knXOjtdhh60rGZR2hXVX1YsX/MUbr7NX5hfDpCn5D0oX4JyNg+sWrv8yX0Ln/m7faudojwllWm0gcr6/zRp4rjdWS8z5kayq2AzOyUJpKeq3t0FRMYX8365PSLab20i06yJwHcoey5beZyBjVdNLtHfN1TjyBG9ojoYfh9vBO1g==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by MN6PR12MB8471.namprd12.prod.outlook.com
 (2603:10b6:208:473::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 11:18:33 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::3753:5cf7:1798:aa83]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::3753:5cf7:1798:aa83%6]) with mapi id 15.20.9542.010; Thu, 22 Jan 2026
 11:18:33 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>
CC: "corbet@lwn.net" <corbet@lwn.net>, "rdunlap@infradead.org"
	<rdunlap@infradead.org>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "leon@kernel.org" <leon@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "jiri@resnulli.us" <jiri@resnulli.us>, Jiri Pirko
	<jiri@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "horms@kernel.org"
	<horms@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "krzk@kernel.org"
	<krzk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [net-next,V5,06/15] devlink: Decouple rate storage from
 associated devlink object
Thread-Topic: [net-next,V5,06/15] devlink: Decouple rate storage from
 associated devlink object
Thread-Index: AQHci1DOYilWggwopEOnnUywh7mhMLVeCw0A
Date: Thu, 22 Jan 2026 11:18:33 +0000
Message-ID: <91e5ed31316e27d0c60dc392858f3cae02cee43a.camel@nvidia.com>
References: <1768895878-1637182-7-git-send-email-tariqt@nvidia.com>
	 <20260122033957.2579085-1-kuba@kernel.org>
In-Reply-To: <20260122033957.2579085-1-kuba@kernel.org>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|MN6PR12MB8471:EE_
x-ms-office365-filtering-correlation-id: 1816340d-93e1-43ef-c4f5-08de59a7fad1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WFVBbW42VXBLUGNGSFg0WEprR0xHMi9URVRrWGw2eUJnYllTUVF6cnpESHZH?=
 =?utf-8?B?QmpBb3VMZUIzZ1BiZlpiaDhTREROZEpoZ3JHNno2L1RCUGlDTmFMdldzcmVR?=
 =?utf-8?B?WThJTWxRajg3RTZCV2Y0WWNJVDlpWDQwaVV3emU2Q1FTaDQrU2tIRkd2REVn?=
 =?utf-8?B?WTFBZ2U5ZytRYmFSU0Y5V2J4QzFmSjQ4WCtNeWp3ZGU2OExVdmEwRWtVVUdB?=
 =?utf-8?B?K1l4T0tkWkV5NTFKeWtocHBYVGE3YzhpQXVpUWszV2RWZVIrMGs2ZDBmQ3Zw?=
 =?utf-8?B?Z05sVFdBbGxLbTJLY01JbURTeVpxNjN0UDNHbElacnFEWlFmWWVRekFOWlNp?=
 =?utf-8?B?UjRwZEN1Sm9RMmV0QWUrbEZGVGhhZm5JMzR1Y1dmVE9TSmJ3bHAwQS9wOWlz?=
 =?utf-8?B?UDVwMm0xaWJkSmFUR0xid1Z6S1c2d0Q0RmVtZnBUc1FVbUtGN2haUWp0alR6?=
 =?utf-8?B?Vmp2UzRWY1l1c1NoN0hwN0NmYS9ycTFHQ2JvODViY2IvVFZrRXI4dW1mYW9y?=
 =?utf-8?B?NWh1ckt5WlBmM3dNQm1NZ3d2QzNxVFk4elY2S3M4eE9uNUJ5MXorR2svenNQ?=
 =?utf-8?B?SDhueFRaZStsUHVVS3RCVWs5aHhYVFBZSVJjb1ZRQmRQRmtCdXljbDdGaTQ4?=
 =?utf-8?B?ZW0vQ1BnWUZ3dkNyU0hNd3YzL3ZnRWhqNHNGV2RmaTNtcmRYTDMwNW5OS2dX?=
 =?utf-8?B?a1hXR1RJVE5CeUoyWWZIaHpLRnVRaXBwUVR6RGNkUjdkaGxhZVhUTnBEK2N2?=
 =?utf-8?B?a21VYk5PTEhRVkRySm5EbHUvelVKUVNLRUdDMGxqY2hmZ2l5U0V2amtKQVVG?=
 =?utf-8?B?VE9sRnducDRaOXptU1U5R0c0ZGYyT21aSVczUVkzY0d0Qk02a0d1MmRBOU5a?=
 =?utf-8?B?YWova3p4WjA1T0xhZXdNbWM2eHJOdkNkcGE3YklwM1RoL2lIVnI5MEsyR1U1?=
 =?utf-8?B?YlZhWnlJY3BXZG54ekZVejBLcmNKRnpZL2lTbnlDVnJrblNjSjNMYVBGR3J1?=
 =?utf-8?B?b0xYZnUwTmxablJ0M0ZndWhiNHFxbDVLYTIxekl1MUNMTzJaVlpiWVNlZ3Zj?=
 =?utf-8?B?bUYzditLcEhQYkVWOVJUQ0lTYkNlY0hvNXlpRUsvbEVDT2dQRGgzem1DV0pN?=
 =?utf-8?B?cWRkVktTcFNpOEt4UXoxcERBTXphbUFHL2txZDdpeEQ0Skpzb202aE9QVnBB?=
 =?utf-8?B?a052UTJnSXJSMVFXMzF0R000VTdsM2VYcGlFZ3MxK2FUSkJMT1VaalhaQjhB?=
 =?utf-8?B?bno4Y3FrNHZRd2RGMCs4bkFNWXNuZnNROUMzQUhOZVY4WUZyWjBUaHhBV2I5?=
 =?utf-8?B?SlZkcVo0azNVYVptMGtJcGNuZkkwU09hVy9XaGtEK0RJbzJJUDVZMDIrcDNZ?=
 =?utf-8?B?N0VpM3NtWjZyRlFPd1FKcWpkMk5NVGExVUlMNjVVeSt0L25VWjJnTWFIWnJ2?=
 =?utf-8?B?czRpbno3KzVlV25nK2dRd2hqWlBvWlhpclFNMVhDQ3JFZEVJNnpTYWJYU3Zw?=
 =?utf-8?B?T3BoQTFiSmZYRE5ONUxUWXc2RUxmTXFBSWVaWEROa1dkODNoY0lGVVRRNnZL?=
 =?utf-8?B?S2YweW1mVHZrV3pUelJIYXBmZ0NuNDZ0SEdITHBoZkxUUzRnMU9WVkRwSkFB?=
 =?utf-8?B?MG1MM3dzS3Jsa0hmbzdHSXJ3QjBRTERKVDBtbGdYNUJTcHJkdkUxNkc4UnRl?=
 =?utf-8?B?ZEh5OXdvZXM5bDJYSk1RcjJwaWdWMlE5SG9oWENyaHJQVmZPMy9lVnhaK3F3?=
 =?utf-8?B?UGNqYVVsblFUM2pMY0lXdFM5Y201UHZZeVp6UFNOeldIdW5FWmZxaW13V1hC?=
 =?utf-8?B?VlBFeURQS01wanhPSmpROGZiZ0RYRzByUnVsUk9CbU9rUkRZM2tucGVlcGdm?=
 =?utf-8?B?WUptSUtudEZaTUFJM0p6NjUvU1YySlg3czBTNllxN2ZiS3RyUmgvalY0eVE3?=
 =?utf-8?B?dWRyeFkvWjFvbkNoV3ljVE1JRzNsYlpuRGhQY203TStqNE9Ic2Y4M04yeFVN?=
 =?utf-8?B?SWNrSDdNNnE3bkVZVDZWb29MS2FMVVFwc1FqK3A2K0paU0l5cUk0VFFrNWY1?=
 =?utf-8?B?WDQ5ZHdOVUgyZ3BsSm9rVUxDc2VBcXpOYWx3M1hOREhuNHJPVWtwdWZtUGlU?=
 =?utf-8?B?ajFNWTN4QW5TSnZqKzNGbEZnUGtKQlBuellSRzdXbTVvR2hCaGZTODZZdTZY?=
 =?utf-8?Q?smned2JN4l1aPV3Do8FY150=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YldlZEI5VTBvczB0YnlWbE9QN1UrQ1krL1d2dnJteS9WaU1nbzN4SHBOYkVE?=
 =?utf-8?B?ZE1FUTcxL3lMOXhVTVhnajlqaElMOVFXeHYvMzVwU2hYVThpQ0htaS9LQ3Yz?=
 =?utf-8?B?ZmJ2aGVUVzFwVEdjYlB3aEJWSkpzL3duejhTMzFOTXVQYUdpQmJmbEVHeEhs?=
 =?utf-8?B?c1hlRHVYVUpGSDVHYk9YZzdrSVl2RFVxZWhQaG1iZDk3WTF5M2p2THkrKzhz?=
 =?utf-8?B?RVNiRGVOYW5tZHZWRGpGYVRaKy9JME0reDJEdlpUTnRoQ1JmdFB6ZENaUFdF?=
 =?utf-8?B?Rkh6OHpSSFFYZ2N6ZXdEMjdBSFkvL3BMRTBmNS85bWc0akVxckV6VTNGdWhu?=
 =?utf-8?B?YVlTMC9CTlNmNFNISysxc1NCTWk2bFdleGQvSElER2JCVExBMGc0TVlBZzhP?=
 =?utf-8?B?OWQ2Yk5VR3ZFSmZ6Nk91OUFxTzRHaDJVSUttcDM0c1poMDg2KzZwWnJNbkdQ?=
 =?utf-8?B?QUlqZFFyanhnQTdaYlFyUTM2a3A4MjU1YzVqSVl0UU5xSlUyKzR1RWg2UEZT?=
 =?utf-8?B?QXpZWlJYclhxTlFtLy80cVM2RHZQSFhDZ1hCcks3c3RvSzBGOEF0ckF0a21N?=
 =?utf-8?B?cm45eVRVSFIwK0R0UjA3UGZiMzFCVGszMlJYeVoyRzV4Njg2MjZVczA5MTls?=
 =?utf-8?B?UFEreEQwNVl1bW5mbFVHRkQvaEU3MTdEMjlyZFdLZ055TDJ1K2k0RUErbjlH?=
 =?utf-8?B?OTBJcnFiNnpqdk8rV3VUSGtVMWhQVkVISzFVaUh0L3pZYjhNTmMzU21OM1Yx?=
 =?utf-8?B?ZXVMY1NFOFF4Vlc4blNERnVSaS91cU9RaFFlTlZTY0ZRQ3RZQU9VNEt4b2dV?=
 =?utf-8?B?SWJrbWgzYnVKOVFqNERkakhnWVkrZkNzQlFSeXpmUll3Tkp0MjMwN2hUM0V5?=
 =?utf-8?B?YmxMQ1FldnBHYXpjNm5OUDU0QUd4ZGFlbmhIWWdYTDZ6R2l5cTF3c0h2UTh0?=
 =?utf-8?B?bjQ5bytzR05tL2NtcVZ5bDNpcTlBMWo1bVAwamF2cGFPQXU3QzdhNjZObXYx?=
 =?utf-8?B?WHFHTHZlTDhCa1pyWlFkbDR2VWVSclZXKzcvVm9nK2pscDNqUlpUODFPOHZR?=
 =?utf-8?B?UnBReG9JNkZTbGR6REFqUWkzRW5MQTMyU2lJUUg2eU5WSUsyUGUrVy9VRDRl?=
 =?utf-8?B?RDFqY0N0ZlJmVjdWOG1GYUg2SnR4QnN0SHpRK2VnenhkZC9tUTlLUDBXM1VU?=
 =?utf-8?B?ZWQ2SW5oTGlIbk5obFRFclVTTFNGQ0tLSjVCMW4vcy82WXppNGVpTUNaeFdI?=
 =?utf-8?B?MFFqQ2swRlZZd0JBTC9ya2hGTGtVMzYveGlnNzh5VlIxbDZWMVlySHQvUGJ0?=
 =?utf-8?B?NzVoMVZqRHVkQ0xJNWVVRDJDTHFvMllteEtHRDdqWjlFNjFWSGtlZ2dOSk1E?=
 =?utf-8?B?eXBORmJHNUdNVjh1MFpzRzJWTVR1b3Z4RFovVW5mVnA2Wmluc3NEdnpyQVNC?=
 =?utf-8?B?aFQ1SFBWR2VBR1FndnU3eVZkY3BFcW94U05FZlQyK0dVUlVQYWRSVkhiT0M2?=
 =?utf-8?B?eXZrSFF0azFHQkUxZHVOZjVWTjQrVFQ1Q3ZUcDFUdDQ0Zk00NitKQ3hSY01t?=
 =?utf-8?B?SkV2elkvaDU5ZFB6cWF5L2lsVnNvMDlxWklndUZOSnZuNFNFOWozcEhHd3Zl?=
 =?utf-8?B?L1oyeExGQWZBRnJENEdBZFE4b3pLczBKVEgrZGo5SGUxSHFNS0RiSVNKY0E4?=
 =?utf-8?B?SEM4Mld0OWg1b05UWEpqeXNPd2xMUUZwdDdWcXNWM0RGUFRvM2RpRUdibWQr?=
 =?utf-8?B?UjZSY0lQcXdNdW9keHdTYXpNeDM1RGJuRG9SZVJYVWFrSXF4V1Zxc2dsejll?=
 =?utf-8?B?N0RYTmpKd0JqcStRbXJWZm10RVdQdFdOOENaelVjWUowdFRDaEFuUzk5a3Vr?=
 =?utf-8?B?QWRJckdIRG1MeUdZM1VMSXNJSUR1c3ZYQ08yVXIreHlNL1lJYkJqa0ZQa3dt?=
 =?utf-8?B?elNuQzdJdE1LaGY0V05CejhhMmxQZ1R0WXRERmQ4dm1vWWFiU1pSZ3VnTmVC?=
 =?utf-8?B?clZOQnJnTmNuRzNpOXBJRFZNQlNyYVVrU294V0pkR25hUVB2Ty8xZ3lqUHVL?=
 =?utf-8?B?eUZFNlFCMFRJVUlYYUVsT3g4ZU5wRjNiZmcrTnhCVVRGMTVweW1zWnZjRlFR?=
 =?utf-8?B?TEhoekxYR21BcytYWVFUUUdxNlVVSDBsT1BERWc3ckRUcW1aOSt3MmRYYkZk?=
 =?utf-8?B?a1NiWExpa25JNkVEVFNMdXFtWDZOSkZZRDJVSTR5VjBuaDhwS0dvWVhQWDNX?=
 =?utf-8?B?YXdSRVhUd0hoZ1FZZHkwd0dXR0Y0MTVWOFlMT3lKMVNzS09FMy9ZSFlLVzFY?=
 =?utf-8?B?cERMRXJpUno3WTBwV0N2Mjk0QWdkK29zNjgxQXcvT3BGWHdrUnRqUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E5E69CF6A9E9045BCB28CC3281828E3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1816340d-93e1-43ef-c4f5-08de59a7fad1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2026 11:18:33.5292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3OnHxeIdqkrWQCct/KKAIgWwMzcVmj4bUxtkSgnMSxBAitu8pzsA0Ns3iiqBvpPkStLKx49UacpczRgzUNxIMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8471
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15884-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,nvidia.com:mid,nvidia.com:replyto,Nvidia.com:dkim];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lwn.net,infradead.org,lunn.ch,gmail.com,davemloft.net,kernel.org,vger.kernel.org,redhat.com,google.com,resnulli.us,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[cratiu@nvidia.com];
	PRECEDENCE_BULK(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: EF9B3663D4
X-Rspamd-Action: no action

T24gV2VkLCAyMDI2LTAxLTIxIGF0IDE5OjM5IC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gPiBAQCAtMjIwLDYgKzI0OCw5IEBAIGRldmxpbmtfbmxfcmF0ZV9nZXRfZHVtcF9vbmUoc3Ry
dWN0IHNrX2J1ZmYNCj4gPiAqbXNnLCBzdHJ1Y3QgZGV2bGluayAqZGV2bGluaywNCj4gPiDCoAkJ
CWlkeCsrOw0KPiA+IMKgCQkJY29udGludWU7DQo+ID4gwqAJCX0NCj4gPiArCQlpZiAoZGV2bGlu
a19yYXRlLT5kZXZsaW5rICE9IGRldmxpbmspDQo+ID4gKwkJCWNvbnRpbnVlOw0KPiANCj4gV2hl
biB0aGlzIGZpbHRlciBza2lwcyBhIG5vbi1tYXRjaGluZyBlbnRyeSwgaWR4IGlzIG5vdCBpbmNy
ZW1lbnRlZC4NCj4gSG93ZXZlciwgc3RhdGUtPmlkeCBpcyB1c2VkIHRvIHRyYWNrIHBvc2l0aW9u
IGFjcm9zcyBuZXRsaW5rIGR1bXANCj4gcmVzdW1wdGlvbnMgYW5kIGV4cGVjdHMgaWR4IHRvIHJl
ZmxlY3QgdGhlIGFjdHVhbCBwb3NpdGlvbiBpbiB0aGUNCj4gbGlzdC4NCj4gDQo+IE9uY2UgY3Jv
c3MtZGV2aWNlIHJhdGUgbm9kZXMgYXJlIGVuYWJsZWQgKGxhdGVyIGluIHRoaXMgc2VyaWVzKSwg
dGhlDQo+IGxpc3QNCj4gY2FuIGNvbnRhaW4gZW50cmllcyBmcm9tIG11bHRpcGxlIGRldmxpbmtz
LiBJZiB0aGUgZHVtcCByZXF1aXJlcw0KPiBtdWx0aXBsZQ0KPiBuZXRsaW5rIG1lc3NhZ2VzIGFu
ZCBub24tbWF0Y2hpbmcgZW50cmllcyBleGlzdCBiZXR3ZWVuIG1hdGNoaW5nDQo+IG9uZXMsDQo+
IHRoZSBpZHggdHJhY2tpbmcgYmVjb21lcyBpbmNvbnNpc3RlbnQgd2l0aCB0aGUgbGlzdCBwb3Np
dGlvbi4gVGhpcw0KPiBjYW4NCj4gY2F1c2UgZW50cmllcyB0byBiZSByZXBvcnRlZCBtdWx0aXBs
ZSB0aW1lcyBvbiBkdW1wIHJlc3VtcHRpb24uDQo+IA0KPiBTaG91bGQgdGhpcyBjb250aW51ZSBz
dGF0ZW1lbnQgYWxzbyBpbmNyZW1lbnQgaWR4IHRvIG1haW50YWluIGNvcnJlY3QNCj4gcG9zaXRp
b24gdHJhY2tpbmc/DQoNCkFub3RoZXIgdXNlZnVsIGZpbmRpbmcuIEkgc3VzcGVjdCB0aGUgY29k
ZSBtaWdodCB3b3JrIGFzLWlzLCBzaW5jZQ0Kc3RhdGUtPmlkeCB0cmFja3MgInRoZSBuZXh0IHBl
bmRpbmcgaXRlbSBmb3IgJ2RldmxpbmsnIiBmcm9tIHRoZSBsaXN0LA0KYnV0IGl0J3MgcXVpdGUg
aGFyZCB0byByZWFzb24gYWJvdXQgdGhhdCBhbmQgaXQncyBwcm9iYWJseSBiZXR0ZXIgdG8gZG8N
CmFzIHRoZSB0b29sIHN1Z2dlc3RzLCBhbmQgdHJhY2sgdGhlIGxpc3QgcG9zaXRpb24gYXMgbm93
LiBXaWxsIGRvIHNvIGluDQp0aGUgbmV4dCB2ZXJzaW9uLg0KDQpDb3NtaW4uDQo=

