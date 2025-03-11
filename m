Return-Path: <linux-rdma+bounces-8585-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F38E8A5CBC7
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 18:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78CB53B7E8E
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 17:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F3E260A4E;
	Tue, 11 Mar 2025 17:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kar9OWNY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF9526039B;
	Tue, 11 Mar 2025 17:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741713101; cv=fail; b=H4ii+/FY7hzLmTW+r4pHq9iCxuuTgMO6tkRA51GIvXWQSw2E0lw7ZmQxU2oHiKmKzW7xfbugEiKA2c3tesbZq8wems1f3xTU6Lwnb43AG4bPvJ26TVisrtlTe1OX3N71484bsiMZ6/kGEbnMO2xJ6Qugw/jyezJHGBcfXFwd1iI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741713101; c=relaxed/simple;
	bh=v4AbiP7hoLrjTTfUzwmuGl84V/CbURyXVZkFMs11EAE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rlneC3rYjVp96O1QQzsZRrwCv9zMPj7FUnW8EGZ9eBxVhfB9PqmAMRUn5QERRbgDODVmXWbw3XX6ng4cXUOCpAkZp03mw9mSqC/7W05Ap8GXJY3dF5VTcQoB9x332dIj+GGIeHVpw2BloLfuFqZfHKn8ESLuhH7+Zli4rOyO/rI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kar9OWNY; arc=fail smtp.client-ip=40.107.100.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRd0WFo7eGuTQykV/iSposlgOVzED5PVwhntoi88kHEXp/nXme06rFUBJjI1JjhlBDg/QeuImwwltmAVq0R+1BYEGds1PTPld3IDBHYzpXKn2dh+94WMnhnAOHSuYe0jIKRTiGGaMTNhj1Nkq9ZpLkurgsMzxBy5NlquZ92yhfYC03ZIqhI+9Ie6qlFXxNdDGXsoLEVBZif94zh04MDdus4p6sDFvWIyonjHhVnd7qFvBOD3ycmohI4rxLC77NX9aY/Lsp8gtxTSGg5yXusvESUvwnydyIng1sOctGNvvKreMSoqczNo3ewXvwzgzomYHhqRIFBgi07GOhEmC/Z4ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4AbiP7hoLrjTTfUzwmuGl84V/CbURyXVZkFMs11EAE=;
 b=qhurefHoFrdSJc0cE7dI1ODF45uxMyOLVPyRayG+oaKVv3XmNO9PReRhKun7NeQsvvz/KAEhV7EMr5usVeAAmsvNX8RNxSEn4lipnqdXIc0unJsYqnWGrA5iUxmVcKCoi5NMMZ29T3edikpFycW1Ddv3syadVO4aX3358Nxa1ZDAq/TmnvZRlOVeGSC1Ajb8v/ayL1Dm4N/oyQzS3nvkRL5+9cE6Wy0P/fR0C/Bivh3qhtbyRDgOxuBghawIsoHHjeUazPRx7WnLaOGqSf9sboolvkONURM1VJ14iSagKSuC5CD9sgv9nrs5gIvyhuYYWsTh+3qb25lZzHO7LrXjIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4AbiP7hoLrjTTfUzwmuGl84V/CbURyXVZkFMs11EAE=;
 b=kar9OWNYmD37G09DDwGdjVB2TeaFgOgwZ0YwyxW2pb9PXIBK3coSEMdqXQuVEnEjDr2RKQqtems+Atmy31SyU+3YgRqGk17bb97GP4cgDNE3J3CtTqhsHlAJuRBnnobIKoxU1apt8ouh33nZ7WZJyXTDBAd0CB2yEHTgosE8qvA8U+Zl5cd8iJwqkQ4kFCruJ4Ux59tH+u69YTIPrh3l3d/cDobB8alsmf5RX0zPNPG1Nu4PWrv+gzLwMYKVCsTIZp3x3oWxS/hXdf7hp2XcRYifeMLEXYRfuW173v8MkTF6sC7PuE45Xt8xIDVpYelGczvnEgAOLILUH045UalhGg==
Received: from DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17)
 by SN7PR12MB6692.namprd12.prod.outlook.com (2603:10b6:806:270::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 17:11:34 +0000
Received: from DM6PR12MB4313.namprd12.prod.outlook.com
 ([fe80::4d58:4bbc:90a5:1f13]) by DM6PR12MB4313.namprd12.prod.outlook.com
 ([fe80::4d58:4bbc:90a5:1f13%6]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 17:11:34 +0000
From: Sean Hefty <shefty@nvidia.com>
To: Bernard Metzler <BMT@zurich.ibm.com>, Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Nikolay Aleksandrov
	<nikolay@enfabrica.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"shrijeet@enfabrica.net" <shrijeet@enfabrica.net>, "alex.badea@keysight.com"
	<alex.badea@keysight.com>, "eric.davis@broadcom.com"
	<eric.davis@broadcom.com>, "rip.sohan@amd.com" <rip.sohan@amd.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "roland@enfabrica.net"
	<roland@enfabrica.net>, "winston.liu@keysight.com"
	<winston.liu@keysight.com>, "dan.mihailescu@keysight.com"
	<dan.mihailescu@keysight.com>, Kamal Heib <kheib@redhat.com>,
	"parth.v.parikh@keysight.com" <parth.v.parikh@keysight.com>, Dave Miller
	<davem@redhat.com>, "ian.ziemba@hpe.com" <ian.ziemba@hpe.com>,
	"andrew.tauferner@cornelisnetworks.com"
	<andrew.tauferner@cornelisnetworks.com>, "welch@hpe.com" <welch@hpe.com>,
	"rakhahari.bhunia@keysight.com" <rakhahari.bhunia@keysight.com>,
	"kingshuk.mandal@keysight.com" <kingshuk.mandal@keysight.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jason Gunthorpe
	<jgg@nvidia.com>
Subject: RE: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Thread-Topic: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Thread-Index: AQHbjuwVUw9AWIkXnUa8bbJSM0sPK7Nplw8AgACP1ICAA9ylgIAAGkwQ
Date: Tue, 11 Mar 2025 17:11:34 +0000
Message-ID:
 <DM6PR12MB43133BD3605D9C95498A9604BDD12@DM6PR12MB4313.namprd12.prod.outlook.com>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
 <20250308184650.GV1955273@unreal>
 <CY8PR12MB7195F4D67BE6D9A970044572DCD72@CY8PR12MB7195.namprd12.prod.outlook.com>
 <BN8PR15MB25136EC9F3DE1FBEF9B2429199D12@BN8PR15MB2513.namprd15.prod.outlook.com>
In-Reply-To:
 <BN8PR15MB25136EC9F3DE1FBEF9B2429199D12@BN8PR15MB2513.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4313:EE_|SN7PR12MB6692:EE_
x-ms-office365-filtering-correlation-id: f9a7181a-7d27-495c-4a00-08dd60bfc670
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TU9SNXEwOVBSMEEzYytVR3lDQWdhVmxlUW5mMlFxT3BZbTJOUVFBRWV1YlYv?=
 =?utf-8?B?WHZKdDZRdHlETE5MNkxISklrbGdxUzd0RWwra0RuSjRFN1JDK1VUbkdHOUNI?=
 =?utf-8?B?bFl5NnhWRnNYZTNkbWk4cmlBN0NqNHNTVEZXemNsdll2OFR2U0hYb1ZiZUg5?=
 =?utf-8?B?U3Fwa0dzZlJ2bFk3eDhFdGlwZmdrdTNDeGZlR3pCYS9YRUdyRGU2VVNYd2pz?=
 =?utf-8?B?RGNoTEhMbzhaOHBjLzZMZ2o4ZTdJS2xRMVp4SjFpcEtxMlVJbXp6WW9TdXpX?=
 =?utf-8?B?ZXJGL1BBcjVpSzFRSzhoU2dBWUdoMVZCS1Uwb0F2b0hKSkpBdE8wSS9VSDZw?=
 =?utf-8?B?RlQwTFNWRk0raXdKM25ndmVFWDBLNjBtOGFCSjJzNzFzTURLVWlkUVpNQ0hi?=
 =?utf-8?B?eEw4L1o4SE84Q2ZTRjNlUkgwRnU1K3FaMDBsdEdmb2tFYTNIVGFkWVY4MVpQ?=
 =?utf-8?B?TnJNNnRKcUh4a3MzZ3FqV0dzamwzcVZxd1JWNEZRcHZRajg3OWdLQ1k2S293?=
 =?utf-8?B?ckpiSC9lU2phSXlOSHREaTlwK3hoWFpFVUJ4MFN2c0IwTU01S3JVbXlWMWxE?=
 =?utf-8?B?bFBqQUh6ZVVnTzBpNzdSbmFiYnByc2JtYmlFakptaGxCdlVybnVUcnBxSUJ2?=
 =?utf-8?B?SkZFcmhvc1F1aHFTQWxrNFhsUmlYbFc1MVhsZ0FTWHV0d1RkWDd1b2Zwb3pZ?=
 =?utf-8?B?U3hLb0lZRW5GM1d5N3ZtRzMzTWM0Nzd0WE1IM2t3SWZvYXJKOU5GaTBRYXhQ?=
 =?utf-8?B?MkhUK1pmL2VOQmsxQkd0UVFwT3YyUStRREp4TW1LWE5PVStKQ3hqbXNOYk9h?=
 =?utf-8?B?dC9lQlFSekx1V25WNzFvazlDTW5FOEdvMGprcE5YWnhyZzNhTmxrTk5xY3NR?=
 =?utf-8?B?Rml5OGhHanJySllNRUNBdEorSVhPQTlWOUJLWTJ5TmhOUlcrK283UjVhYmt3?=
 =?utf-8?B?ZEFSL2dSZXlyU1NLdXBEeklYU2lIMFhVVkk0OFgzcjB1REF5dEpBZEV0RXBQ?=
 =?utf-8?B?Q2JRQUtJZkJqQkF0Q2tVZVBlbXcyZjJ5TzZtOG5hQ1AxbTgvWTVtYXBYcjlm?=
 =?utf-8?B?RTg3MERpaHViSzFLUGlyOXE4VFQ2MlUyMExISUFlYXppa0pyM2lsblNtVUFv?=
 =?utf-8?B?cE1yS2V5UVdOWnFqRDcyNFJnLys0Q0doMWVxRlZnZGNqdDgwcmkyTmNpN1RG?=
 =?utf-8?B?blhKTXk5QjVUTEY4ZXBqM2lVRVFUNjlZYUkra0lzYWxaV21WTEdZVTJJK25r?=
 =?utf-8?B?SnZiVGY2L0NHQThaUFlyMUEyM1JQWGZ1MllZbDB6d2dmQmxQaWIyZ0hHZ3lG?=
 =?utf-8?B?Skl3LzZVR0dtRDZVTVNnWnVoNkM2MElIbTBqMVNwSzJCWHpNYnFvb3FNNVFl?=
 =?utf-8?B?OEEvNVY0WU94MXRDc2g1SWpHTzltL24xY3NDT0ZhT2U5a3pPSjlwbWswdDhG?=
 =?utf-8?B?cU5kbkd2QTc3bWFCYkM5K0x0a0s3N1ZCK013SHB5TjNYb1h0K1pNcDQ0Yk5r?=
 =?utf-8?B?WEwzc25UeUJxQVY4R1luaTRUN0hJWWxGWHVNOVVKcDYwSCtnMk9sZmU3a0Vs?=
 =?utf-8?B?bjcySVVLK0ZrNnFEb0k4N3lDUWRXZTQ0Y0FVRzdUdkR1anZzQ0lleGxzaG1X?=
 =?utf-8?B?V1pPWjF6ak1HMXJxYkFmMkRhbENDL2lpcXZOYjNNeGFnbnVRQ0tUcm1GVG5M?=
 =?utf-8?B?VkFVK3VWVDBkVHU0MVdlcVp5RVQxUjdjOHo1ZUphbEpDNFNxa0xXbThiSDJF?=
 =?utf-8?B?WTRTN2xJT1hVWXJoWWc5VG91V0hod0NNMGRwanN4QmRja3FoR2dYZGdBcjJV?=
 =?utf-8?B?M2dYdzBDeVRjNVQzWnZBVFZsRXcxaVo3czliY3dnUkUzd0JBZjE4VXIwTS9k?=
 =?utf-8?B?Wk9iS0F0Umw2dHMrN2hxYlVsS0NEQ09iWHJBUWQ4QlFXWXdSb1BlckYxTGNM?=
 =?utf-8?Q?BhMIWRgX7vTmV3QuToJ/ymqN4iUJiZdA?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4313.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a3JJdklhL2ZqR1k5bVc0Q3dySzE4NFlzalJYd3FScFp1TlZIaXM2a09xeXBO?=
 =?utf-8?B?N3lCM3dOUG5VdXlJWk1IT1Y4dTlubklmRVZhT0lwanZrZ1lmN05vNmsyRDFo?=
 =?utf-8?B?TnlDNzE2ZkxNV3RGazlFU2tEcnFWOTI3YmtWWFphNGgyaUIwajdRbHMzZE1J?=
 =?utf-8?B?WmJPU0lvMCttR2hnZlNROXN6NHQ5SFlpZUVjQmJWeVU5QmZRZkt0cEFYbzcv?=
 =?utf-8?B?WkYyTUwxUEZveW5NSERXTXdWdUJLYm1CNVV0akxMeDBleExZM3ozQ2U2c3hu?=
 =?utf-8?B?d3FNTzJVY0ZOQ3VnSm5ka25iRDFkc3RtNUlQM0lXNU9NQmpKbzVReWJGLzFm?=
 =?utf-8?B?ejl1WnRYNUxWWmJUOGxRZFdpZDBVd2F5cXUvbStJTGk2R25obmNHaGZHS3Jv?=
 =?utf-8?B?Q0wrMUZnUWVHZHFnN3U1SzBXak05L2NBZDVOVTJlR1lqVzBBSWZQQ01scXhG?=
 =?utf-8?B?dWpZM1RoYmNPZkZ3VHRwS3BCVklBNitVUEJMRmIrWURLanUzUkswbUxKZXFj?=
 =?utf-8?B?dmRCYWExdmlCWW41MVJVRGVtRXZRQUhqQ1NjUVljWXd3NUdkZWlXSkdZa05x?=
 =?utf-8?B?Yzgyd0dJUGc0eDFlcDVaWVBLYWxCQUYwU3F2MEtZc0tOQlVjeStHUWhKOHpS?=
 =?utf-8?B?MVhjVEt1YU5wdXpmSHpJc0U3akRpTmJlOFNhbTZrMDlseHRNZ1o0SGQvUWZv?=
 =?utf-8?B?WFNCL2NDVW9UMjlFaitqekE5SGh6MzlsSzJRbjJ6Q1dXcjQ1MnR3T1JERnJR?=
 =?utf-8?B?dnM4aHVWTmVwUGlCUUdzS3g0TTVWTE5uZVJ5YmZiRXJuQ3BMdVN2WC8xNkxC?=
 =?utf-8?B?TTJ0U2VIQ1FoTGVwdFNrVFIvWDg5TXFxbGNRbDBxUVNEbXVBRHhwSlBXQmNL?=
 =?utf-8?B?ajZyNi9mVjR6TkRyVmIxd2FSR21qaFRtdkxuODN4Y2svVmZWWm5pNzJ5Nk5j?=
 =?utf-8?B?VktHeEdyMS9YWkEzRnVqVWdhQ1RsY2JsblFCaE12VWhoSm1CYk5kdEk5bTVT?=
 =?utf-8?B?WEhJSndGT0lTQmZRRllaeVZHRHd2dGhmVW1YelRPZk5oMjFhM0ZEK2trdVhY?=
 =?utf-8?B?SWpoZ0RDenArVWVxbDJGZkFXcDhJQzhKSmxGY1BiZUNYS2FIQkgwQ3VZY21S?=
 =?utf-8?B?Z2hkTW1jRVVLRHp3RUliek03NnI0QXhUL0JpZmpkWUUyMWhRRmhOQjI5VjlF?=
 =?utf-8?B?YnFoK1o1Yjhyd2xYZ3RydVJpVnVHc1B3WmtNMlEvSkdFTkFNaStiWTBRSHZ4?=
 =?utf-8?B?OTB0QlNyMFpnZ1UvWlhYNUZRcVdRSVEzNEF0d2RmcGxNU2grNlBScWkyRk03?=
 =?utf-8?B?Q3NGbGY2QnFXaTU2TUwrc0NMMEx1SGQ3Ti9qWUpZOEw3MzRRZ2xnZHBsK2Vy?=
 =?utf-8?B?dWlCL05uaDV2dE9xZTVrdlQ5N1NoMk9ZR1A0QVdSbXgwNGhhK042RnRlcGd6?=
 =?utf-8?B?MUpVNFh5ckFwdEZrRm95QjVhZElzaUJ3Tzk5bUhxV3RqUDRsMWJPVkJPZ1lM?=
 =?utf-8?B?NDJKMmVzTEwvYTVHQnRKUERoSThDQjNaWW43WUtwc0pkZUJLN2RwRVdIc29B?=
 =?utf-8?B?YkN5S1d2VlJUK3NMU1hOUUg1elJ6aEE0ZzBhK0wzV0dSVVUxL3dTamtRNzl6?=
 =?utf-8?B?UCtZSFEvbGs1NlQrUDFFZGlqazRxZnlSaHVYMVNlTWU4OXIrUUdVejlOaHRi?=
 =?utf-8?B?TVdlRlBjRms4cW02dWVNS3pGS08wQlVzYjZ4d3lDUFo2LzlDVHZXcDNhMStX?=
 =?utf-8?B?Ukc5Rko0Y2RyQ08xNzJaNTZuclhkcGZVY0tQVElqQ1lHSDJOREdWdytiS0dO?=
 =?utf-8?B?RmRVcFdsM25qZUthekFweHpkNVhpWFh3N2dBSU5qOHdxcFcyZFVjVlRPQ0NO?=
 =?utf-8?B?L2h6S041WDRYUGpjQWRpbjRNVnJObTN4cHRUbElYUThRRHRHTHk0eGZseU1n?=
 =?utf-8?B?NGR0R3FIeU1oZjZCc1ZtWmhRODNpVXlUdFo0QTNiMklQZEloWjl3Yk9OV3Jz?=
 =?utf-8?B?VkJ0Z05hblRpSCtXVlBGYTNudDhiZGZiZkxkWUk1ODBUMVJRaWJrQUZpa21P?=
 =?utf-8?B?Z1MxOGFaWXZlOXdXamIwYUp0TTZ3RlZQcWdWSjhOdzFUM1o1ZUROQkJZbGdy?=
 =?utf-8?Q?2rsI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a7181a-7d27-495c-4a00-08dd60bfc670
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 17:11:34.0329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7yCXLLeeVRTRxZMPC53iNtCJGNCpGwtNJT/4tcuWAYVOWzINF6xInMYCs/JcxkVlDbiIKgiDiATa1X1uVAyjZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6692

PiBJIGFtIG5vdCBzdXJlIGlmIGEgbmV3IHN1YnN5c3RlbSBpcyB3aGF0IHRoaXMgUkZDIGNhbGxz
IGZvciwgYnV0IHJhdGhlciBhDQo+IGRpc2N1c3Npb24gYWJvdXQgdGhlIHByb3BlciBpbnRlZ3Jh
dGlvbiBvZiBhIG5ldyBSRE1BIHRyYW5zcG9ydCBpbnRvIHRoZQ0KPiBMaW51eCBrZXJuZWwuDQo+
IA0KPiBVbHRyYSBFdGhlcm5ldCBUcmFuc3BvcnQgaXMgcHJvYmFibHkgbm90IGp1c3QgYW5vdGhl
ciB0cmFuc3BvcnQgdXAgZm9yIGVhc3kNCj4gaW50ZWdyYXRpb24gaW50byB0aGUgY3VycmVudCBS
RE1BIHN1YnN5c3RlbS4NCj4gRmlyc3Qgb2YgYWxsLCBpdHMgZGVzaWduIGRvZXMgbm90IGZvbGxv
dyB0aGUgd2VsbC1rbm93biBSRE1BIHZlcmJzIG1vZGVsDQo+IGluaGVyaXRlZCBmcm9tIEluZmlu
aUJhbmQsIHdoaWNoIGhhcyBsYXJnZWx5IHNoYXBlZCB0aGUgY3VycmVudCBzdHJ1Y3R1cmUgb2YN
Cj4gdGhlIFJETUEgc3Vic3lzdGVtLiBXaGlsZSBoYXZpbmcgc2VuZCwgcmVjZWl2ZSBhbmQgY29t
cGxldGlvbiBxdWV1ZXMgKGFuZA0KPiBjb21wbGV0aW9uIGNvdW50ZXJzKSB0byBzdGVlciBtZXNz
YWdlIGV4Y2hhbmdlLCB0aGVyZSBpcyBubyBjb25jZXB0IG9mIGENCj4gcXVldWUgcGFpci4gRW5k
cG9pbnRzIGNhbiBzcGFuIG11bHRpcGxlIHF1ZXVlcywgY2FuIGhhdmUgbXVsdGlwbGUgcGVlcg0K
PiBhZGRyZXNzZXMuDQo+IENvbW11bmljYXRpb24gcmVzb3VyY2VzIHNoYXJpbmcgaXMgY29udHJv
bGxlZCBpbiBhIGRpZmZlcmVudCB3YXkgdGhhbiB3aXRoaW4NCj4gcHJvdGVjdGlvbiBkb21haW5z
LiBDb25uZWN0aW9ucyBhcmUgZXBoZW1lcmFsLCBjcmVhdGVkIGFuZCByZWxlYXNlZCBieSB0aGUN
Cj4gcHJvdmlkZXIgYXMgbmVlZGVkLiBUaGVyZSBhcmUgbW9yZSBkaWZmZXJlbmNlcy4gSW4gYSBu
dXRzaGVsbCwgdGhlIFVFVA0KPiBjb21tdW5pY2F0aW9uIG1vZGVsIGlzIHRyaW1tZWQgZm9yIGV4
dHJlbWUgc2NhbGFiaWxpdHkuIEl0cyBBUEkgc2VtYW50aWNzDQo+IGZvbGxvdyBsaWJmYWJyaWNz
LCBub3QgUkRNQSB2ZXJicy4NCj4gDQo+IEkgdGhpbmsgTmlrIGdhdmUgdXMgYSBmaXJzdCBzdGls
bCBpbmNvbXBsZXRlIGxvb2sgYXQgdGhlIFVFVCBwcm90b2NvbCBlbmdpbmUgdG8NCj4gaGVscCB1
cyB1bmRlcnN0YW5kIHNvbWUgb2YgdGhlIHNwZWNpZmljcy4NCj4gSXQncyBqdXN0IHRoZSBsb3dl
ciBwYXJ0IChwYWNrZXQgZGVsaXZlcnkpLiBUaGUgaW1wbGVtZW50YXRpb24gb2YgdGhlIHVwcGVy
IHBhcnQNCj4gKHJlc291cmNlIG1hbmFnZW1lbnQsIGNvbW11bmljYXRpb24gc2VtYW50aWNzLCBq
b2IgbWFuYWdlbWVudCkgbWF5DQo+IGxhcmdlbHkgZGVwZW5kIG9uIHRoZSBlbnZpcm9ubWVudCB3
ZSBhbGwgY2hvb3NlLg0KPiANCj4gSU1PLCBpbnRlZ3JhdGluZyBVRVQgd2l0aCB0aGUgY3VycmVu
dCBSRE1BIHN1YnN5c3RlbSB3b3VsZCBhc2sgZm9yIGl0cw0KPiBleHRlbnNpb24gdG8gYWxsb3cg
ZXhwb3NpbmcgYWxsIG9mIFVFVHMgaW50ZW5kZWQgZnVuY3Rpb25hbGl0eSwgcHJvYmFibHkNCj4g
c3RhcnRpbmcgd2l0aCBhIG1vcmUgZ2VuZXJpYyBSRE1BIGRldmljZSBtb2RlbCB0aGFuIGN1cnJl
bnQgaWJfZGV2aWNlLg0KPiANCj4gVGhlIGRpZmZlcmVudCBBUEkgc2VtYW50aWNzIG9mIFVFVCBt
YXkgZnVydGhlciBjYWxsIGZvciBlaXRoZXIgZXh0ZW5kaW5nIHZlcmJzDQo+IHRvIGNvdmVyIGl0
IGFzIHdlbGwsIG9yIGV4cG9zaW5nIGEgbmV3IG5vbi12ZXJicyBBUEkgKGxpYmZhYnJpY3MpLCBv
ciBib3RoLg0KDQpSZWFkaW5nIHRocm91Z2ggdGhlIHN1Ym1pc3Npb25zLCB3aGF0IEkgZm91bmQg
bGFja2luZyBpcyBhIGRlc2NyaXB0aW9uIG9mIHNvbWUgaGlnaGVyLWxldmVsIHBsYW4uICBJIGRv
bid0IGVhc2lseSBzZWUgaG93IHRvIHJlbGF0ZSB0aGlzIHNlcmllcyB0byBOSUNzIHRoYXQgbWF5
IGltcGxlbWVudCBVRVQgaW4gSFcuDQoNClNob3VsZCB0aGUgUERTIGJlIHZpZXdlZCBhcyBhIHBh
cnRpYWwgaW1wbGVtZW50YXRpb24gb2YgYSBTVyBVRVQgJ2RldmljZScsIHNpbWlsYXIgdG8gc29m
dCBSb0NFIG9yIGlXYXJwPyAgSWYgc28sIGhhdmluZyBhIGRlc2NyaXB0aW9uIG9mIGEgcHJvcG9z
ZWQgZGV2aWNlIG1vZGVsIHNlZW1zIGxpa2UgYSBuZWNlc3NhcnkgZmlyc3Qgc3RlcC4NCg0KSWYs
IGluc3RlYWQsIHRoZSBQRFMgc2hvdWxkIGJlIHZpZXdlZCBtb3JlIGFsb25nIHRoZSBsaW5lcyBv
ZiBhIHBhcnRpYWwgUkRTLWxpa2UgcGF0aCwgdGhlbiB0aGF0IGNoYW5nZXMgdGhlIHVhcGkuDQoN
Ck9yLCBhbSBJIG5vdCB2aWV3aW5nIHRoaXMgc2VyaWVzIGFzIGludGVuZGVkIGF0IGFsbD8NCg0K
SXQgaXMgYWxtb3N0IGd1YXJhbnRlZWQgdGhhdCB0aGVyZSB3aWxsIGJlIE5JQ3Mgd2hpY2ggd2ls
bCBzdXBwb3J0IGJvdGggUm9DRSBhbmQgVUVULCBhbmQgaXQncyBub3QgZmFyZmV0Y2hlZCB0byB0
aGluayB0aGF0IGFuIGFwcCBtYXkgdXNlIGJvdGggc2ltdWx0YW5lb3VzbHkuICAgSU1PLCBhIGNv
bW1vbiBkZXZpY2UgbW9kZWwgaXMgaWRlYWwsIGFzc3VtaW5nIGV4cG9zaW5nIGEgZGV2aWNlIG1v
ZGVsIGlzIHRoZSBpbnRlbnQuDQoNCkkgYWdyZWUgdGhhdCBkaWZmZXJlbnQgdHJhbnNwb3J0IG1v
ZGVscyBzaG91bGQgbm90IGJlIGZvcmNlZCB0b2dldGhlciB1bm5hdHVyYWxseSwgYnV0IEkgdGhp
bmsgdGhhdCdzIHNvbHZhYmxlLiAgSW4gdGhlIGVuZCwgdGhlIGFwcGxpY2F0aW9uIGRldmVsb3Bl
ciBpcyBleHBvc2VkIHRvIGxpYmZhYnJpYyBuYW1pbmcgYW55d2F5LiAgQmVzaWRlcywgZXZlbiBh
IHJlcHVycG9zZWQgUkRNQSBuYW1lIGlzIHN0aWxsIGJldHRlciB0aGFuIHRoZSBuYW1pbmcgdXNl
ZCB3aXRoaW4gT3Blbk1QSS4gIDopDQoNCi0gU2Vhbg0K

