Return-Path: <linux-rdma+bounces-16085-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6J3wLiTMeGmNtQEAu9opvQ
	(envelope-from <linux-rdma+bounces-16085-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 15:31:00 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E3895B92
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 15:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C554E30CE670
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 14:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F1635B628;
	Tue, 27 Jan 2026 14:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r6uW1vGD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010046.outbound.protection.outlook.com [52.101.193.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F3C356A38;
	Tue, 27 Jan 2026 14:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769523955; cv=fail; b=AiX+Md7qREmV4vnGHXWfyGLHb/1VuNAzbY+t3Z0f30RiyAw/JJ+VdaY0V+S7PmJHW3pUVLEPqXN90Ci5kxpL7lLGcA04RQy9KpGt5WS+aoQYKREMbdL7AstkSSbRnSNDzEMKxp9IqWi3Jwl2+cT2+TexLap53H00anNfSIS0cnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769523955; c=relaxed/simple;
	bh=NdBE4dT8Hg0aj3sKpoChKVuLJZFfkabdZ2rIADJfhFs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JtR8RetVsHUFpz4KtUf+oXLGMKP0TUtynKK3O0RbtkYMiqhZ5AqCq68W+vLabjx3O6kO+n4vc53EyhhR1+gAFLp+f02InBQd8LOBzja+xHBo6k5LNMGeUDrQsSw/g1wJZARZXdmdEm46sTMXlRbLUjTfJZrFiozahh+pq4FSau4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r6uW1vGD; arc=fail smtp.client-ip=52.101.193.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WBZDzyWm+N5eQftCEXW39X+Hkb59HycDwY23hVdjOUwoWEgKCKZ4/PDYxHW2r2CjSAp1V0gEZmlzmx5Z4ru54eiWMTK5NcEWYWILwHI6xzs9akUJ14/qrnBjLlXkH+iGZEl4u5xjc+4OdT73W3xE4tRglEbxm+kUFUF0TNdTghoO2bzE1wyiaOftWGeaCyb2SUWMz26Svr+1DYLBT2D8hg8w3EewoSbTMIcGMxaQN/DRhf50MyCPaDQS7TXj4llQPWGJCpdXn8QL+4ilYKD/TTjQPic/2StLOYLhh2p2dC5Z65zpASHhsFN0xFloCKRU3nyhMeIksfPlB7SMowRf3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdBE4dT8Hg0aj3sKpoChKVuLJZFfkabdZ2rIADJfhFs=;
 b=QnpiVPRtbkzRElgKpd/Ka9yML0750y5lioQ//neKVI8NLVJ9YpJcGiBojGyvpIU59C/fTEOu5Lc5p8jkBUnqB7uqzVipyNIXf80Fp1az0lxboqe90Auls/OCWpgggV9D8meYO6XFpubZt+raXbRJqA+E+mLtOAuqPd2fCRaAf4oQotfl2xPsHb9xEKtOXwXzLreTQ4/kRorOV/VLtoxAJyqeINUF9Izy8KnCjKB6zbuTJ2rX6XFsd6T5kaP+bGFHgkmoXhv5oSpn17qp+R1a2NnuZ9cpWAbBBJNWHVgbXI3t6/i7U7tWGWtQZdIm8lgsj+xzIwk5I6M4LTvN9Qaw3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdBE4dT8Hg0aj3sKpoChKVuLJZFfkabdZ2rIADJfhFs=;
 b=r6uW1vGDrAVerH9jobY+HI+6Rand09qVBO7gX7a/qFBozJwyBdaBm+VcZotp+CuYF6Oy56p6rYk5nYtcYIO+FYOrPPF1y/je8Xoh0/DzlzM/lQ8AhIJ+kJYcVXrBTCwvBhUAWnjqSZZ7yDQhqelQHgZe+RlX0jYtsA2rEvkI0dL7XiIkwMwTMLFHvIGdrXu7eqf0xe9q89620XqRUT3ZFbJF7/nIxIa56Fw8+qveTgz05JqvRgHnM+gsQp8vvBi2i6i/LgUeoRYMYrTDKq0qJKudBbht+boaowNnTeonVqtXvgS9eOAAA8Cp3B1sZbd74M1AWV2txMHhRL3plsld1g==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by SN7PR12MB6887.namprd12.prod.outlook.com
 (2603:10b6:806:261::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 14:25:51 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::3753:5cf7:1798:aa83]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::3753:5cf7:1798:aa83%6]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 14:25:51 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>, "horms@kernel.org" <horms@kernel.org>
CC: "corbet@lwn.net" <corbet@lwn.net>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "leon@kernel.org"
	<leon@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "pabeni@redhat.com" <pabeni@redhat.com>, Jiri Pirko
	<jiri@nvidia.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Carolina Jubran <cjubran@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "rdunlap@infradead.org"
	<rdunlap@infradead.org>, Saeed Mahameed <saeedm@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, "krzk@kernel.org"
	<krzk@kernel.org>
Subject: Re: [PATCH net-next V6 07/14] devlink: Add parent dev to devlink API
Thread-Topic: [PATCH net-next V6 07/14] devlink: Add parent dev to devlink API
Thread-Index: AQHcje5zYvWoCL9wWEOcdteRYVn6grVmC8GAgAAKDQA=
Date: Tue, 27 Jan 2026 14:25:51 +0000
Message-ID: <3a000e6a2fcdfb6dc8d18e24d6ee1e7f9f89bc0e.camel@nvidia.com>
References: <1769340723-14199-1-git-send-email-tariqt@nvidia.com>
	 <1769340723-14199-8-git-send-email-tariqt@nvidia.com>
	 <aXjCf2iRC5VsRC5A@horms.kernel.org>
In-Reply-To: <aXjCf2iRC5VsRC5A@horms.kernel.org>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|SN7PR12MB6887:EE_
x-ms-office365-filtering-correlation-id: 86f728f1-1163-46b5-eb49-08de5daff8f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?b010YW9IcldqRExCSmJtdDNPRzd6QmpaRy90d3R0TDBYVXUxVWJNUG1WdDhp?=
 =?utf-8?B?U2k3Tzg3TzFROWU4dGJiWE8xbzRwNEtVdWEzZ2k2NUM2eHpPMnJmVlgwOUtp?=
 =?utf-8?B?NlRhV3VqZHBueXVxVXZVSG1vZElGL2g1V1JUUVljWFZEbkdid1pEb2I3anpC?=
 =?utf-8?B?NUZva0FFd2J2eHhyNzIzNDVHclJsaGJkNEVNbVRreW9DajRGYTF1NHloVmRT?=
 =?utf-8?B?RytIQmFFRyttMmFyNkJLRS9qK040K2lXV1RrZnZLUlRuWHdRRzdsVmlaT1JP?=
 =?utf-8?B?R3Blc3N1VlpxRXlLdlJHc2pRdGg1V1lFSjIrWVkrRUpRTXpPd2xidHJMeG1h?=
 =?utf-8?B?NmM4MTJTQVd2U3F5MEd2N1I1dnUvb3YvYUI3QXZTU2dDYXFrajRlUENJckF1?=
 =?utf-8?B?T01iVzRSRDlwWVdibGMvcjByK2RCQnIyK0ZUWnJCanZuZ3lXTVNQL3lSeFM0?=
 =?utf-8?B?V0VuTndRTi9zU0xoMWIvR1dMZkdKSk9KMDFOT2VUOEZqaGF4QlM0d09lekxy?=
 =?utf-8?B?bWFLQXV5YTNDN0IrejVjRUlOTXZiWXdmV204ajUrYUQ5eUJsMmQ5QjA2eDVz?=
 =?utf-8?B?amh3THNBLzgvYVgrQnRpZVB4R1FKWU1UQktPOXFkNXo4Zkg5ckNrcE1mRWtH?=
 =?utf-8?B?R3lHOTU5RDk2c09FTndKSWhFZlNESWgzcTZaSGpKVEhad29zZWxDWm4rcE1K?=
 =?utf-8?B?OGVZOTl1MnoxWHZ0UDAzNnpoODBkQ3hYRTdVcVBFdGo0Wm5NOGUxN1F6TzNm?=
 =?utf-8?B?N3hERDNhWXpVUkRwWGRHT3Z4c0tQMG5idmhWcUdaY3NhcFIwb2pHdGVyS0dh?=
 =?utf-8?B?WGdRTmpwZWtpbE1PVVp5clYraTlmbVFGZVhkSnVLSjJvTkR5SjI1Vmc2Y2wx?=
 =?utf-8?B?RmdFSzlkcHFsTTJidEtuOHBFUmVMTHE1UHY4SGZqaFgyVVRDUXdsZHI4RzYr?=
 =?utf-8?B?bU9LbVNFdzB5R0VIWGNWOC90azI5ZURGYmd4ODJ1OHZqNXRsdnhKMStTQVZ2?=
 =?utf-8?B?NWwrVENsZ1RYc0pra1JWQnlUUDhqOHFuaC91NWQ2V0V6c0N5RjhBa0hiNkRr?=
 =?utf-8?B?WHcyMVg2QlZTcTVHSVVUU1FtZU8zdFF5Ty9udE9Yb2VWYTRXM204Wmg1bWxH?=
 =?utf-8?B?b1BaYVdUdU9jSTBYd01LUTJwb2thM3ZxVlhuVmVaN2N4THVJV25GTDUwdW5r?=
 =?utf-8?B?eG9mSjZKUXJxWk9MRUNUZFk1enJyTGRuekpNa1lJMkpsY2VIbDZGY29WUitU?=
 =?utf-8?B?aC84akI1ZDExalN2NjdXKzQ1MDFJOFdNaDlKcjJnTG5UYll4MnNJZmpyaWRB?=
 =?utf-8?B?VHlTa1JxWVN2Y0gyeHc2OXRYU2d4QU5LdHphb2dkdVZmcCtZQ3laNUxDT2xi?=
 =?utf-8?B?R1hPc2NFUHJLT0FvMHh1UnF2bEI0SGtBRzBSU3p0ZEpNMTkvTGtmNUdidmJW?=
 =?utf-8?B?enBXU2NTMFNKc0lYcFI1b3VqdHNHRXYxYjVCbDFnQzJ1ZVdZQzZ6NGxoSmdy?=
 =?utf-8?B?dWc2bjhUMWpOQytBaDdKOGlRZHZ0ZE5EOGV4LzBqdWllVlFEeWFCOXdGZXZZ?=
 =?utf-8?B?TnRFTW5UeVo4bzViYlBPNWd1YzVPRVR1clhnUTNLN004ZDNmd25vOFZqc0cv?=
 =?utf-8?B?c3dqY1RoV0xvc1huaWo3Z3ZxQ3pUaUVzbTlUUEVVN1FLcjVyMnZ1WE02YU1S?=
 =?utf-8?B?M24zVW9ZUXBBRlBzTjdCL01oVnZ6RSs4TzhVdG90N0hEdElNT0syZE5PQUpp?=
 =?utf-8?B?QmVEUFloUTNFSEl4VmRYaVcxY01XTDAyUWxsc1N0TmlQZ2pRbmRlUXEwOFN5?=
 =?utf-8?B?YW1PVldKY2N0b0dFNWVrcWZndkRxa0R4cUFtM3hUQk5Ea1dpVXFHbkR1OEtL?=
 =?utf-8?B?QVZYb08rRHR0bGlIWkdPd25HQ2VMQ0RFb0hPYTczbmlsTG1iS3RVY0hsd0lW?=
 =?utf-8?B?SEpPbi9xSGdES2pFbW5wcU5OUVNjL1FNWFczNFUzMjk2VzFSalZ0WHBSQnYz?=
 =?utf-8?B?R2IrdEJaalBHb2xaUFJIZkp2TDNIWnpJLzN0ZVMzZ3owdmhMVDVNRG5IWTMv?=
 =?utf-8?B?N21sZDJmMTNYWjA4QnZLWTA0MEJXZzNhc1B4Q0dTSjArb0M5L1hlZVF0T0da?=
 =?utf-8?B?cXVyOHBRK1Jiekl1MEc1enRjK1ZtNE45VFJBUURxUW4wL2ZvVFphVzgrTzJI?=
 =?utf-8?Q?J51VKkNrPzX3I6fsLttv7ko=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OThpY0RMc2xQbFA1ZS9xZHBQL2NnMDhPbGZzeSsrQVpGS0dDUDZBdFdPVE1q?=
 =?utf-8?B?MGFQdWM1ZE5tNG83QjJFRmhxVmJqYTJzM1J4QllHcjl3cWxPb1BDN2NzMGJm?=
 =?utf-8?B?M01QMDJJYlZwRktLUHhNejRjMm5jNHl6aHAzb2VUajhGaUhXMmUvcnB0ODRC?=
 =?utf-8?B?YW9zZkxQVy9PVHFORm5PNzFRVzl2YmlONHR3a2JWYzVVeEJFZzZRdjBmQlYy?=
 =?utf-8?B?R0lmeCtnOGlKSXdpMW1yT3MyU1UxSVNYdkw4M1FOM2I0K1Q0WDlWVUxKRlAv?=
 =?utf-8?B?QllwT2dKemN4N29YTEZPNHNmcDMrTG1Id1BWWVV4cE1ZNDBoNW4yUVQ3cGM1?=
 =?utf-8?B?dFl3N2ZBTlQxT2dsSUpZU0RjMVMzTlRYaFNUK21aOWY2RVRDakJJTENxSExw?=
 =?utf-8?B?bnhxUnVVTTFkRjFIakJEYUFILzc2bi8rNkpYYkJzK2hhSDkxYnBBL2VmYy9Q?=
 =?utf-8?B?cW42Q21jb28xUC9OQTc4Mlo4ZkhydlIzTTlpWG5uY2FzN1JjeWxFSENPNk10?=
 =?utf-8?B?V1RsdHJabmNlckFoeVNnWDFQMmZoVE8ydU91RUdZOERPZ1lvVDErZFRRK0Jp?=
 =?utf-8?B?K1FqbXdhZGJyS0xqaWQ0KzByZjFrMFI4bmdFU0xDTGt0YVI0empEREg5VGJT?=
 =?utf-8?B?TURBUnprTXNSZWRHcFFrMWJaSUZHVDlDK0FjYjVoWmxYeXJWRUV5K3UwbUZC?=
 =?utf-8?B?amNDcmVieFVvYXNkRTNjaXVFSzYxQUNXdWJFbHlJS25Vbm90d1orYnNqbVE1?=
 =?utf-8?B?Ukh1WGpGeERHbEVLanVncVVKeENoQW83OVFlU3NzMzBSSHhuYjM2UXhhR0FS?=
 =?utf-8?B?YWliMDNJME9sTWhCcUI5V3htcCs4cnBScDlGWDhiOWlrUE1mMUJlQ0JKU09V?=
 =?utf-8?B?ZGR6VzB3aXRaTUhNYzdURWVKNWh0NUt3YzdZOGduNmdFWW12RWVDM2NhSXRG?=
 =?utf-8?B?L0VrcENKTlJFZktTOWRCWG44Nmt4Y0wrTWdJYUtiOTdncjBYVFdkTDFwZ2M5?=
 =?utf-8?B?WEpUM3N5TVd1N3lpYzIrN0NUT1lXVS96QktTMko5czQxKzZUUm5GSE1MU2NX?=
 =?utf-8?B?b0ZZRFM4STNrVW9kOHdZQnk0MW80bzlVZk1rSXNoeXU3U1hOK2FnNjFwUS9O?=
 =?utf-8?B?SmZVSXdaZE53dWJsSDR1Z0hhdkpZemxGL2FIOFJWdWNMUlV6THNXcW9tZ2w1?=
 =?utf-8?B?Q0c4Y2NUYWNtUzRSZ2VhUkRXNXZ2MXh5YW1SUEYrV0FRbFhEeXdxbk5sM3Ju?=
 =?utf-8?B?UTZINkJYZkE5c1hIV1ljb2ZYVHFacEpYY2YzZXBXZHNRQTBGQjhiRzRweS9i?=
 =?utf-8?B?bUNzVnF3bTd0S0VwRmxRZmRlcDdIc3VkZlFHT3lIdnJtR1lGTW1UMWduTW1Y?=
 =?utf-8?B?K3NIbHBpUXI5UU04amIxcGFqVEVWNjhudXpQanFlTE40N2VyeXN1Y1FjKysv?=
 =?utf-8?B?bkdTakhiTy9RdnhERGdraG9aVHZFanJJQ3MvdkErUkVsREdyaFBnZFUyTUlo?=
 =?utf-8?B?TlBRbG0rN1Zsam8wRzUzL2VvU2UyMEFtajdmWkd5YXZWakRZalk2bStmSzF3?=
 =?utf-8?B?R1NQRFlyYUNUNGRUZHIwZXVlTjhNcXEyNmRxcGt0SXFZeWdnN2w0UDNQZTRF?=
 =?utf-8?B?cWlZWkRqZUVmVlVHdmExdk41SVVIWlZ5MSswc21YblRyc0REK1pjTExqYmpH?=
 =?utf-8?B?Zk05Y0k5bVpGVkVxTjA2MTk0Q2pSb1B1aXg5MkN3WTJuNXlVRHVhcUhnWmRB?=
 =?utf-8?B?ZTZlUWhvNTZnUFdGeGxWdllKaGduK0p3Q3l6Y0l0bC9KT2tjN1RRZmEyVTdh?=
 =?utf-8?B?b2thQUR6c3RBUXhJd1piRTZIVEF0eUlCYVcrYXBWWWR4SkE5enNNSG9FbjZq?=
 =?utf-8?B?T3pNZzluU2N5R0RhMlhSdjdhNTZvYjhzNDZvbjlsd0RmVFVmTFdxNjdxWlVY?=
 =?utf-8?B?OFZKcGpJK3ZvKzExVnRhRmtmMU1JQXd1YmRBSlhRTUZMdnJOZlVKbDI3UmFK?=
 =?utf-8?B?SmMwQ2VrUEpGNENVY2Ftait1dEhKaUttZWMxdjAydkpaQjBFbEtYY3NiUlRj?=
 =?utf-8?B?OC9jaVdrQUZXVW5KM20yTWN0RzUyZlp1MGM2ajJZSCtXL29neHlVRU1HMnZv?=
 =?utf-8?B?TkxqMkNxSldRUTFDVkpEaXVGQlZoYjAycFBDMWs1SDFXaTZwMHBaK1FHc0Vw?=
 =?utf-8?B?ZTA1Nnc1M1JnOTFndE9mSUtJWmtwZHgwWS9jT0NqeXllZ05MaU51bDZtY25R?=
 =?utf-8?B?azJjMTJPRitYSVVsSWN3YkFIeEVXcVp4QVdVRjJzdkdCQk1iaFRsRmUybDFs?=
 =?utf-8?B?akNuRXVYUHpsVUdWOGNob29MN2lUN3h2eTRMRS8wdEVCMXNsNnNrdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32A0D75F1A7E4C4E9D1D6E839485BCEB@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f728f1-1163-46b5-eb49-08de5daff8f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 14:25:51.0224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bul3Ujxm2knFbTMIQ4GaeIJenkhlEJ6FvF2uJF2Hy/iHNpvlKwjLQkly/UpRr19h4NWpckLwxWBvVn46ewgY3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6887
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16085-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lwn.net,lunn.ch,gmail.com,davemloft.net,kernel.org,vger.kernel.org,google.com,resnulli.us,redhat.com,nvidia.com,infradead.org];
	MIME_TRACE(0.00)[0:+];
	URIBL_MULTI_FAIL(0.00)[nvidia.com:server fail,Nvidia.com:server fail,sea.lore.kernel.org:server fail];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:replyto,nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[cratiu@nvidia.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 25E3895B92
X-Rspamd-Action: no action

T24gVHVlLCAyMDI2LTAxLTI3IGF0IDEzOjQ5ICswMDAwLCBTaW1vbiBIb3JtYW4gd3JvdGU6DQo+
IE9uIFN1biwgSmFuIDI1LCAyMDI2IGF0IDAxOjMxOjU2UE0gKzAyMDAsIFRhcmlxIFRvdWthbiB3
cm90ZToNCj4gPiBGcm9tOiBDb3NtaW4gUmF0aXUgPGNyYXRpdUBudmlkaWEuY29tPg0KPiA+IA0K
PiA+IFVwY29taW5nIGNoYW5nZXMgdG8gdGhlIHJhdGUgY29tbWFuZHMgbmVlZCB0aGUgcGFyZW50
IGRldmxpbmsNCj4gPiBzcGVjaWZpZWQuDQo+ID4gVGhpcyBjaGFuZ2UgYWRkcyBhIG5lc3RlZCAn
cGFyZW50LWRldicgYXR0cmlidXRlIHRvIHRoZSBBUEkgYW5kDQo+ID4gaGVscGVycw0KPiA+IHRv
IG9idGFpbiBhbmQgcHV0IGEgcmVmZXJlbmNlIHRvIHRoZSBwYXJlbnQgZGV2bGluayBpbnN0YW5j
ZSBpbg0KPiA+IGluZm8tPnVzZXJfcHRyWzFdLg0KPiA+IA0KPiA+IFRvIGF2b2lkIGRlYWRsb2Nr
cywgdGhlIHBhcmVudCBkZXZsaW5rIGlzIHVubG9ja2VkIGJlZm9yZSBvYnRhaW5pbmcNCj4gPiB0
aGUNCj4gPiBtYWluIGRldmxpbmsgaW5zdGFuY2UgdGhhdCBpcyB0aGUgdGFyZ2V0IG9mIHRoZSBy
ZXF1ZXN0Lg0KPiA+IEEgcmVmZXJlbmNlIHRvIHRoZSBwYXJlbnQgaXMga2VwdCB1bnRpbCB0aGUg
ZW5kIG9mIHRoZSByZXF1ZXN0IHRvDQo+ID4gYXZvaWQNCj4gPiBpdCBzdWRkZW5seSBkaXNhcHBl
YXJpbmcuDQo+ID4gDQo+ID4gVGhpcyBtZWFucyB0aGF0IHRoaXMgcmVmZXJlbmNlIGlzIG9mIGxp
bWl0ZWQgdXNlIHdpdGhvdXQgYWRkaXRpb25hbA0KPiA+IHByb3RlY3Rpb24uDQo+ID4gDQo+ID4g
U2lnbmVkLW9mZi1ieTogQ29zbWluIFJhdGl1IDxjcmF0aXVAbnZpZGlhLmNvbT4NCj4gPiBSZXZp
ZXdlZC1ieTogQ2Fyb2xpbmEgSnVicmFuIDxjanVicmFuQG52aWRpYS5jb20+DQo+ID4gUmV2aWV3
ZWQtYnk6IEppcmkgUGlya28gPGppcmlAbnZpZGlhLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBU
YXJpcSBUb3VrYW4gPHRhcmlxdEBudmlkaWEuY29tPg0KPiANCj4gLi4uDQo+IA0KPiBIaSBDb3Nt
aW4sIGFsbCwNCj4gDQo+IFRoZSBuZXRsaW5rX2dlbi5bY2hdIGFuZCBzcGVjIGNoYW5nZXMgaW4g
dGhpcyBwYXRjaCBkbyBub3Qgc2VlbQ0KPiBjb25zaXN0ZW50Lg0KPiANCj4gJCB0b29scy9uZXQv
eW5sL3lubC1yZWdlbi5zaCAtZg0KPiAkIGdpdCBkaWZmDQo+IGRpZmYgLS1naXQgYS9uZXQvZGV2
bGluay9uZXRsaW5rX2dlbi5jIGIvbmV0L2RldmxpbmsvbmV0bGlua19nZW4uYw0KPiBpbmRleCA2
YjY5MWJkYmYwMzcuLmY0YzYxYzJiNGYyMiAxMDA2NDQNCj4gLS0tIGEvbmV0L2RldmxpbmsvbmV0
bGlua19nZW4uYw0KPiArKysgYi9uZXQvZGV2bGluay9uZXRsaW5rX2dlbi5jDQo+IEBAIC0zOSwx
MSArMzksNiBAQCBkZXZsaW5rX2F0dHJfcGFyYW1fdHlwZV92YWxpZGF0ZShjb25zdCBzdHJ1Y3QN
Cj4gbmxhdHRyICphdHRyLA0KPiDCoH0NCj4gDQo+IMKgLyogQ29tbW9uIG5lc3RlZCB0eXBlcyAq
Lw0KPiAtY29uc3Qgc3RydWN0IG5sYV9wb2xpY3kNCj4gZGV2bGlua19kbF9wYXJlbnRfZGV2X25s
X3BvbGljeVtERVZMSU5LX0FUVFJfREVWX05BTUUgKyAxXSA9IHsNCj4gLcKgwqDCoMKgwqDCoCBb
REVWTElOS19BVFRSX0JVU19OQU1FXSA9IHsgLnR5cGUgPSBOTEFfTlVMX1NUUklORywgfSwNCj4g
LcKgwqDCoMKgwqDCoCBbREVWTElOS19BVFRSX0RFVl9OQU1FXSA9IHsgLnR5cGUgPSBOTEFfTlVM
X1NUUklORywgfSwNCj4gLX07DQo+IC0NCj4gwqBjb25zdCBzdHJ1Y3QgbmxhX3BvbGljeQ0KPiBk
ZXZsaW5rX2RsX3BvcnRfZnVuY3Rpb25fbmxfcG9saWN5W0RFVkxJTktfUE9SVF9GTl9BVFRSX0NB
UFMgKyAxXSA9IHsNCj4gwqDCoMKgwqDCoMKgwqAgW0RFVkxJTktfUE9SVF9GVU5DVElPTl9BVFRS
X0hXX0FERFJdID0geyAudHlwZSA9IE5MQV9CSU5BUlksDQo+IH0sDQo+IMKgwqDCoMKgwqDCoMKg
IFtERVZMSU5LX1BPUlRfRk5fQVRUUl9TVEFURV0gPSBOTEFfUE9MSUNZX01BWChOTEFfVTgsIDEp
LA0KPiBkaWZmIC0tZ2l0IGEvbmV0L2RldmxpbmsvbmV0bGlua19nZW4uaCBiL25ldC9kZXZsaW5r
L25ldGxpbmtfZ2VuLmgNCj4gaW5kZXggZDRkYjgyYTAwNTIyLi4yODE3ZDUzYTBlYmEgMTAwNjQ0
DQo+IC0tLSBhL25ldC9kZXZsaW5rL25ldGxpbmtfZ2VuLmgNCj4gKysrIGIvbmV0L2Rldmxpbmsv
bmV0bGlua19nZW4uaA0KPiBAQCAtMTMsNyArMTMsNiBAQA0KPiDCoCNpbmNsdWRlIDx1YXBpL2xp
bnV4L2RldmxpbmsuaD4NCj4gDQo+IMKgLyogQ29tbW9uIG5lc3RlZCB0eXBlcyAqLw0KPiAtZXh0
ZXJuIGNvbnN0IHN0cnVjdCBubGFfcG9saWN5DQo+IGRldmxpbmtfZGxfcGFyZW50X2Rldl9ubF9w
b2xpY3lbREVWTElOS19BVFRSX0RFVl9OQU1FICsgMV07DQo+IMKgZXh0ZXJuIGNvbnN0IHN0cnVj
dCBubGFfcG9saWN5DQo+IGRldmxpbmtfZGxfcG9ydF9mdW5jdGlvbl9ubF9wb2xpY3lbREVWTElO
S19QT1JUX0ZOX0FUVFJfQ0FQUyArIDFdOw0KPiDCoGV4dGVybiBjb25zdCBzdHJ1Y3QgbmxhX3Bv
bGljeQ0KPiBkZXZsaW5rX2RsX3JhdGVfdGNfYndzX25sX3BvbGljeVtERVZMSU5LX1JBVEVfVENf
QVRUUl9CVyArIDFdOw0KPiDCoGV4dGVybiBjb25zdCBzdHJ1Y3QgbmxhX3BvbGljeQ0KPiBkZXZs
aW5rX2RsX3NlbGZ0ZXN0X2lkX25sX3BvbGljeVtERVZMSU5LX0FUVFJfU0VMRlRFU1RfSURfRkxB
U0ggKyAxXTsNCj4gQEAgLTMwLDE5ICsyOSwxMiBAQCBpbnQgZGV2bGlua19ubF9wcmVfZG9pdF9k
ZXZfbG9jayhjb25zdCBzdHJ1Y3QNCj4gZ2VubF9zcGxpdF9vcHMgKm9wcywNCj4gwqBpbnQgZGV2
bGlua19ubF9wcmVfZG9pdF9wb3J0X29wdGlvbmFsKGNvbnN0IHN0cnVjdCBnZW5sX3NwbGl0X29w
cw0KPiAqb3BzLA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLA0KPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgZ2VubF9pbmZvICppbmZvKTsNCj4gLWludCBkZXZsaW5r
X25sX3ByZV9kb2l0X3BhcmVudF9kZXZfb3B0aW9uYWwoY29uc3Qgc3RydWN0DQo+IGdlbmxfc3Bs
aXRfb3BzICpvcHMsDQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHNrX2J1
ZmYgKnNrYiwNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgZ2VubF9pbmZv
ICppbmZvKTsNCj4gwqB2b2lkDQo+IMKgZGV2bGlua19ubF9wb3N0X2RvaXQoY29uc3Qgc3RydWN0
IGdlbmxfc3BsaXRfb3BzICpvcHMsIHN0cnVjdA0KPiBza19idWZmICpza2IsDQo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGdlbmxfaW5mbyAqaW5mbyk7
DQo+IMKgdm9pZA0KPiDCoGRldmxpbmtfbmxfcG9zdF9kb2l0X2Rldl9sb2NrKGNvbnN0IHN0cnVj
dCBnZW5sX3NwbGl0X29wcyAqb3BzLA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdCBn
ZW5sX2luZm8NCj4gKmluZm8pOw0KPiAtdm9pZA0KPiAtZGV2bGlua19ubF9wb3N0X2RvaXRfcGFy
ZW50X2Rldl9vcHRpb25hbChjb25zdCBzdHJ1Y3QgZ2VubF9zcGxpdF9vcHMNCj4gKm9wcywNCj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLA0KPiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHN0cnVjdCBnZW5sX2luZm8gKmluZm8pOw0KPiANCj4gwqBpbnQgZGV2bGlu
a19ubF9nZXRfZG9pdChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgZ2VubF9pbmZvDQo+ICpp
bmZvKTsNCj4gwqBpbnQgZGV2bGlua19ubF9nZXRfZHVtcGl0KHN0cnVjdCBza19idWZmICpza2Is
IHN0cnVjdA0KPiBuZXRsaW5rX2NhbGxiYWNrICpjYik7DQo+IDsNCg0KSGkgU2ltb24sDQoNCldl
IGhhZCB0aGlzIGNvbnZlcnNhdGlvbiBkdXJpbmcgdjQsIEkgcmVwbGllZCB0aGVuIFsxXS4NCkJ1
dCB0aGlua2luZyBhYm91dCBpdCBhIGJpdCBtb3JlLCBJIHRoaW5rIGl0J3MgaW5kZWVkIHNsaWdo
dGx5IGNsZWFuZXINCnRvIG1vdmUgdGhlIHBvbGljeSBhbmQgdGhlIG5ldyBwcmUvcG9zdCBkb2l0
IGhhbmRsZXJzIHRvIHRoZSBuZXh0DQpwYXRjaCwgd2hlcmUgdGhleSBhcmUgYWN0dWFsbHkgdXNl
ZC4gVGhlIG9ubHkgYml0IGlzIHRoYXQgdGhlIHBvbGljeSBpcw0KdXNlZCBmcm9tIGRldmxpbmtf
Z2V0X3BhcmVudF9mcm9tX2F0dHJzX2xvY2sgZnJvbSB0aGlzIGZ1bmN0aW9uLCBidXQgaXQNCmFw
cGVhcnMgc2FmZSB0byB1c2UgTlVMTCB0aGVyZSB1bnRpbCBuZXh0IHBhdGNoICh0aGUgdW5kZXJs
eWluZyBwYXJzZQ0KZnVuY3Rpb25zIHRvbGVyYXRlIE5VTEwgcG9saWNpZXMpLg0KDQpTbyBJJ2xs
IGRvIHRoYXQgaW4gdGhlIG5leHQgc3VibWlzc2lvbi4NCg0KWzFdDQpodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9uZXRkZXYvM2VjOTU2ZWExZDBhMWM2ZTU2ODY1YjJkZWQ2ZDgzZWQ3NzNjY2Q0ZC5j
YW1lbEBudmlkaWEuY29tLw0K

