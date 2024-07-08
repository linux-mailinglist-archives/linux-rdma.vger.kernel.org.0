Return-Path: <linux-rdma+bounces-3716-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF69092A0A1
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 13:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ED212855E6
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 11:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF110770EF;
	Mon,  8 Jul 2024 11:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IFFfzjCF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7C51CA96;
	Mon,  8 Jul 2024 11:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720436505; cv=fail; b=HmLc8Fc6ftDZVbhiBwWfxjNTqREWzkrV63TalfwEMf/VvTB1L79sLB/0Na4RFQ38fctc4u1qxJ4CVVKX/xDttF37wBc4vM+gCV10+W7DTwIbIsQnUrX43buvyLsJ+6vLU6/1OHmzbNJarGgsXKyggql7CbPIZxijruu+5j12Bfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720436505; c=relaxed/simple;
	bh=VJMeF8Xn70zxQQmbeTpO4Q0qNQgWMojyKaK8ZU61yfE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nt4qGa/gM+45AiJAzLOAk2SnGi87xkKTDKZOC3SgU4LKIy+tp1Lini69oXengt00FtilqWLzxN7JMnimNmco/QxBjblZBGA+L1+VXwTMFmUhMpt/kSfYWSrZAe/7ujq4s/pUjyQnR4/Xw5JoIJpwHk5iqyju1A9M8ep/h7I5SMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IFFfzjCF; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyNPt3ARS7F9/VdG7yd0AZhA188yT07EEdxo1VeQM80mMHvTKd2Uhqi7CEJzKWTxb2F2zcgEzsiPsWfl7VE7AM7Fblvnt40QAUb1MWorC5xmPrkK7XRlQa9PrCSgBAKbY672OaW7YkG8jvpUv5/yM0tuc7/p2jgYcc/Hi+Hiq7oovCkLmgr6i7NEFgDxqD4cZqr+7CWfFsbBCol5n4R6jZZt35JaGA0H7vlMpC3HbDZTM4xJjSXkN0sphfQhwCOnWcCIS6RITQoxYhwPSp6kIgfE0vGzMkH5grdf57LLpXSnqYe+97Qo+O5ijKsVjO0Rwonqh9tD4XqDMDEPPA/YIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJMeF8Xn70zxQQmbeTpO4Q0qNQgWMojyKaK8ZU61yfE=;
 b=SGpIcINCFup8QG2iHZFacafIkKGbxSCgIvt0cEAhrhMm8gnTydlAtqZH1hOxY7cgBOpnn1eSnAKj8kVK/qO5TUA+0KQv2+wbjstMgZKVgFB/Mltd+YR8t9qyRdGVdEdYFkhZJOXfqPQP/odU5Qlg0p6CP/OE559jXr4Wdb0350exjqlq9sdM2oQ/AyDKWJmq5z/1zYQRLTvRFiflQuJ5V2I6GsZe5X4gczMqeja1k0DPqMsqHe3eUlIq7169FRqzPKF4Nqw39buR86MJ5ZNqqsbeIxMOj+rOSMQY6kZBAevjhyjcYKhIKlgrAlRO77/zcBIMpI+xxo5XsnVpvTJVzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJMeF8Xn70zxQQmbeTpO4Q0qNQgWMojyKaK8ZU61yfE=;
 b=IFFfzjCFB1BCJ90N4PO8/oje58L7UEJ3fTronBVfumT1opkDWZk1aqLLzyIQ56MzCAQZjZgx16hg2phFB06oYo8Uj+aQBNN4IH8oEgwClcvjPE4cu6G9EzjQkytGWXk3DItaAU6hLS8/FgEH3ZzyvAfB3bFNd8TtPu7C3kS/cZrDm+3BHwZn4P3ynERrbIugX23ujXbEs6Kg1ozPu7TbLufSc0OofBI9C/gJIpOYDLenhOb6RTZylGyXVunrDdpAxZemtc3/sYQCKNHXlsFXBKRknUozxridVa3IQqublHobZCCCTwN0Q6MZXiLJyVZE2YDr7lg8Yg+2wrDYIOgqtA==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by MW6PR12MB8757.namprd12.prod.outlook.com (2603:10b6:303:239::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 11:01:40 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::17f8:a49a:ebba:71f1]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::17f8:a49a:ebba:71f1%3]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 11:01:39 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "eperezma@redhat.com" <eperezma@redhat.com>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, Tariq
 Toukan <tariqt@nvidia.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
	<mst@redhat.com>, "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>, Saeed
 Mahameed <saeedm@nvidia.com>, "leon@kernel.org" <leon@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH vhost 20/23] vdpa/mlx5: Pre-create hardware VQs at vdpa
 .dev_add time
Thread-Topic: [PATCH vhost 20/23] vdpa/mlx5: Pre-create hardware VQs at vdpa
 .dev_add time
Thread-Index: AQHawMhZfAWsnj0CYEOKT7TiC0tv/7HPQEaAgAqUMoCAC26hAIAHh78A
Date: Mon, 8 Jul 2024 11:01:39 +0000
Message-ID: <c6dc541919a0cc78521364dbf4db32293cf1071e.camel@nvidia.com>
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com>
	 <20240617-stage-vdpa-vq-precreate-v1-20-8c0483f0ca2a@nvidia.com>
	 <CAJaqyWd3yiPUMaGEmzgHF-8u+HcqjUxBNB3=Xg6Lon-zYNVCow@mail.gmail.com>
	 <308f90bb505d12e899e3f4515c4abc93c39cfbd5.camel@nvidia.com>
	 <CAJaqyWeHDD0drkAZQqEP_ZfbUPscOmM7T8zXRie5Q14nfAV0sg@mail.gmail.com>
In-Reply-To:
 <CAJaqyWeHDD0drkAZQqEP_ZfbUPscOmM7T8zXRie5Q14nfAV0sg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3 (3.52.3-1.fc40) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|MW6PR12MB8757:EE_
x-ms-office365-filtering-correlation-id: 49928ebc-e08c-423e-d267-08dc9f3d57d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U0xldjlkbnJjSXJmOFVnVVYrY0Fud2FGT2lPN2xTSE1IMkRTOW13Wm9zMmFu?=
 =?utf-8?B?Z3VSbFNuNWMzdmZkdDZSb1ZzZDdiQ1RkR0Z0eFYrL3pCWFRtMEMyZ0dTMWpJ?=
 =?utf-8?B?UDhHQ0tlV3l0eThET2dFaDVrc1VEZUFINHpaTjhpYjFOT2UrNWZkN2QrbFdK?=
 =?utf-8?B?TVpydno4MFZBbVRsN2M0bThScS9mWDBOaVFnY1N5MDAvWTRZczMrWXdNTDA5?=
 =?utf-8?B?bWFvcThDSjRycitKdnJSTGM2eVVVZXFFeUdhblRnRUdYdXJMc1RpcGxFdUhz?=
 =?utf-8?B?eTR3TlA3R3VLNHBhRG4yRlZteW9icjZPTTFVUyt6RFIyMU9jTmpIT3BNdE54?=
 =?utf-8?B?L1B1NE91dUFvbmlQcHRGWFVTN0RLOGJQTlBHOHZBNVM1MXcwaUFYNXFwY2Jl?=
 =?utf-8?B?bFZQTE5XbCtPWndlYVlXNEVtcjFpWHlEWDB3c3lFeXVhREVpU1pzb0JyeG0x?=
 =?utf-8?B?UkVyQXpwb0lzdVJ6VW5meFRIZXR3cFhVUVRvSVlyUDlHeWorQjUvVUpiSkFl?=
 =?utf-8?B?aldEK2lzVEJIN3VtL1BoOEoxajBuTVptMUYrMytwV21qOUMrSjVnSURGb3ds?=
 =?utf-8?B?UGNMUFlTejREVmVRR2FOVmk4UktZdVI3ZUY4azZjbmxqbUVCZHhZcFFXR1Vw?=
 =?utf-8?B?OGhpaUhodkgzL3ZPencyT3duVE13RHdOdmloYzBTOXNxbkZEaTNpQzFlUjFS?=
 =?utf-8?B?M3h0TUkxTVVhT3pSN3NYMlFyTWEzdFNvTWJiK2FZTHlpVkpTUDZVcEQ2ZFJD?=
 =?utf-8?B?b3BLa0paa0MzZ2hsdW04eWNHZUgzQm5weXFIOWhlenYzVXBVekZOWFpES2Rl?=
 =?utf-8?B?N1k4dHlORy9xdzlDQXVZSmQvcFlQRlZLRGxuend4YmMrUDAwWmZsUmI2K1BH?=
 =?utf-8?B?YmhXQmRDQVVxTG5ZVWdtMW9yQ29lbVU2clU4cjhTaDVCVU9Xd0VMZkZpb0JZ?=
 =?utf-8?B?S0tRcnlNR2Y5dEZSeFMzaEt3cDFEZkR6ajc2c2VqNXVwRVNmcUtJeTYvM0xu?=
 =?utf-8?B?T0lFOEZwT2VYQnVMWVJaVkRQdVd6T3pKWXlMVUUrNDVQUld6RWJVNzE3N3pu?=
 =?utf-8?B?dGtadEd2elNaS20rRm95NnFITUE5OEtNbjRuNVphQjVXWkZQNW1aK0VybEdS?=
 =?utf-8?B?SjNMQ3FvN2s3MGtwKzRNZElqbVhkUk53Mi9NZkdNQVN2U0UzbW5DVGpkTURW?=
 =?utf-8?B?U3VnbGhtOGt6d2NJWkF6ZVU3OGVjd1cyVVM5eGJ0VGQ5dFdGRTFJTU5UQlpR?=
 =?utf-8?B?L2V5OHlzZ2REamRtQTRwREtJVjA3RTk1cVQ4TlNKTWhyVkI0WkpQMHNodk1W?=
 =?utf-8?B?UDBieUx3MjhmejNrZzdMZXhsc3Via01qdjJpMGpjWmgvR3l2US9sVXVSeE95?=
 =?utf-8?B?WWxMMlp1anJZeHgzcis4aTYrenh1aTJ1eG9nOEhsZGQrWFV4YWZ3c3JjSzhK?=
 =?utf-8?B?S1h6REdBTi9sMW9YWndxVHpMRCsvZlpST1ovSHdMZTI5dWYyeVhZV3NmWDcx?=
 =?utf-8?B?ZUNmdXE1akxCMWR3dHNWVVgweFl3a2lZaXBuWFl4Z21kb3RmekZXNXBFbzVD?=
 =?utf-8?B?ZjgyNjZLUGRVS0MvNTduU09jOWRpRDIwQngrd3oxcGtkT0NSK29ocWFQVThw?=
 =?utf-8?B?RWNNdFRtYnFHL3JZSWV0R1NyOE90eUEzY1VTWVc0WmFKb0dRaTNRbGF0SFU1?=
 =?utf-8?B?YWFJM3Y5cXJNc1c0Wm5pakNVQXdvWTZZeXozWjRid1IyNjk2SHU4UWNoNHJD?=
 =?utf-8?B?WHNoaEVlSVBmZCtVVmI0dHRyV2VZVDZETXlVOXFTdlB3N1lRclZtbFg3MU52?=
 =?utf-8?B?SmhUV0lqdzlUYnNFbXM5RlVTK3A4U2xHNXNaaitxa2hKOW94YTJiOHUvRDlP?=
 =?utf-8?B?YjRGWnlPUTZreTA1YXQ3QUVMKzA4OGMzOFg1WFNUR1U0dHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WVZ5VVFxLyt4Mm91K2M1UXdhanY3cUVsbzN2b1VBWDJtMks4THkxOTVnUEtt?=
 =?utf-8?B?QjQ4RnQ0TXg5R0s0aU5LVjgxWitGc1NqNHVmN09PWlVkYkJlM0ZKL3k4RmFk?=
 =?utf-8?B?U05Idlpja01YQ2JPN2R0clBUTVpEbE8raFRhVVBmeXFSQUJnenBzK3JYMG1a?=
 =?utf-8?B?SFBVWUFodVZYTTZzUEoza0liZnF2UTJrWDZnTThOZFhQaVhkS1JrTUhRZktr?=
 =?utf-8?B?ZytUVjB3cXdZdmlkZHJscFhTNFNIdUdseGxhR091L2d5Ukl2eWxlUUJ4QmJl?=
 =?utf-8?B?YU9JWjBDN0NueEE2THEvYVllNzhYSG9wZzRMclNOaWJjMzZyZDZsSVJUMTdK?=
 =?utf-8?B?TFZYRjN4OVJURnlWa2psK24wM1d4aHRZbWR0RlA3QjhzTDVFVC90YkQ3RzRy?=
 =?utf-8?B?YU5KUTE2VjZPdlk4Mk02akhMazExK2kwQzRWeHl2N0J6Sm5hYmJpUXVhYkJt?=
 =?utf-8?B?T2ZIRFNpYW8rczIzbVZvaEg1WEtrTHN1NGxacWZnYU1ydGNWNncwTVJtU0tQ?=
 =?utf-8?B?RUxheE5ra0xNUDhTclF2Tm9UODFOR3lqRTRnMHp0eElPNGw3Ym9jMDhabzlD?=
 =?utf-8?B?Z1B5Z2hTNXlsSHFIcExTRnNzRnVGUXJCckpEU3hBdUFtS1J3VGJUditSUHZX?=
 =?utf-8?B?VlBsSXZnUHF6V1FOdC8yL1JnYm9HUmN6elNZOCtHQ2tGQmt3U0haTzI1cGc3?=
 =?utf-8?B?Rm1XOXdGbStvVHFrdmlDQXJGcUVqcnFEd0MydDlxN1lBdC9pUitKSk5wWDU1?=
 =?utf-8?B?VzJwQS9qKzFzcnBJeExraUNER3lDam96R2hic212d2oyMlMzNkhPVUZLWXY0?=
 =?utf-8?B?RFhUL3BLdnYwdDFkdlVOVDdKQUpJaldCRkZtdGZBZkZFVWNNdGV3QXhPT2Vj?=
 =?utf-8?B?cFlhNUVYNXFrc29ySVEyYjhqampmcnE0UGp4R3Y1K3NtSDRVM3BXREFRU2tY?=
 =?utf-8?B?Q3VSTDJzbU9OUmljSzRoM3lCSGNneEFQQnA1aG9zeTZ5TC9hZGhTSkJvU2JF?=
 =?utf-8?B?UEMwOU85UVVzU2JJejR6Z3ltbXVIRHgvQjcxOGVULzEzQTZMVzk3TUtpelZR?=
 =?utf-8?B?Qlg1b0oxTmNsZ09WeWRuMTFrandsbGFZT0t0R1ZCeDFSMER1Ymg1Rm4vaWJk?=
 =?utf-8?B?TytKWTFhQ0cyNHpiTXhmVlY1NW45ZU5vZ2F0bS9UOEx4c0JEMXhzNnVMK1lP?=
 =?utf-8?B?MTNudnhEZUdscEQwcTBGcjhvS2tIMldBdzVWRlZVR3g3NmplRm9xd2NYZ25W?=
 =?utf-8?B?TXlmYnVkenFWVVU0ZEIwajVSRHlleWdxOWk2Y2lDUjlZR0NCbkFVRzlYOFE2?=
 =?utf-8?B?SFNNRmw4Wmw4V3I0U1FiZGxsVHErQ0JOcjZYWkRURVdYRTd2VDBlY0hCRnRP?=
 =?utf-8?B?NTVZbEgrcGs3SjNuV0lScWx3SWh1RlFwSjVYbjlncGVZemljWVpxeG9qS2M2?=
 =?utf-8?B?N29QMWcxcW10SC9CQnh2Z0NBb3NkVXByVGU4K0Rsd1BJZTc4OTNkU2M1U2Va?=
 =?utf-8?B?Qm9jblFlUk1XN2JnQW1BU3dJc2taNlV2V1JVOTBpbWtNaG1KYzhhdElWblpt?=
 =?utf-8?B?azc0UmYvQVh3YnN2TGVITHZiajdUZTkwSlpVbnVxQlFLRXhualliRFNnTEpS?=
 =?utf-8?B?YkJrZTNvbThHYm9DMWlBN2lWZzV5L3JKKzFEWmJYdHhXd013NGpoVkJWNFBI?=
 =?utf-8?B?eEJiVlIxOXlsTWNrWS9NR0xrMWJHUEZYd2pSd2g2YyswSU5pYVpSVTYyNWtx?=
 =?utf-8?B?L0lpNWlZdTdWUDJVbzZ3NzF0TWc4NkZzTEcyTGxGR0NCU1JSQkZKNk9xOTFN?=
 =?utf-8?B?S0pKV1dQTTFaL0NPM0lqZU9HUWN0RkZ0aldTQzd1UnZsYTgzQkVoNmtrRmxP?=
 =?utf-8?B?WEJXc2dvNXNQZy96b05FZ2NZeWJNZ08rRWU0ZXlnK3orME9WamV2WkhWaExF?=
 =?utf-8?B?MGYvQjJJaHExd2JqOC9NQ2JHRWgreHZldEtoOUJjbTZnZ0NWck5VMzhwbzNN?=
 =?utf-8?B?Wlh1YStmd0M0L0tEeDNSRjJhTXo4TXVzVDlEVE1iSGhMblFjNWJ4Q3pBdzdB?=
 =?utf-8?B?NkltUUJWaFZKQTJ6SmtaZlB5SGlPcmQrVmdPclIybXgyaitTYnU5Q1VvOURm?=
 =?utf-8?B?VGNlbERqd2hlRDArUCsxblYrT3c1RFI1MVdwOE9UeEMrTEF2ekNnT3lpaVA5?=
 =?utf-8?Q?bMCAw0tQVaeZ4HynyxaBrYeH3MG18uWJETFycj5gTKIJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <623F0AD567D4E74193BD52B43F883A6B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49928ebc-e08c-423e-d267-08dc9f3d57d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 11:01:39.5354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9BE6yp2cJHD/GaeJ1/rcHxKwsI83p5Yj1Kvf4qCGDAJ5EpseOp5ptSHRZhoJr0p721mYIQbioMmP81n2dTPRvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8757

T24gV2VkLCAyMDI0LTA3LTAzIGF0IDE4OjAxICswMjAwLCBFdWdlbmlvIFBlcmV6IE1hcnRpbiB3
cm90ZToNCj4gT24gV2VkLCBKdW4gMjYsIDIwMjQgYXQgMTE6MjfigK9BTSBEcmFnb3MgVGF0dWxl
YSA8ZHRhdHVsZWFAbnZpZGlhLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gV2VkLCAyMDI0LTA2
LTE5IGF0IDE3OjU0ICswMjAwLCBFdWdlbmlvIFBlcmV6IE1hcnRpbiB3cm90ZToNCj4gPiA+IE9u
IE1vbiwgSnVuIDE3LCAyMDI0IGF0IDU6MDnigK9QTSBEcmFnb3MgVGF0dWxlYSA8ZHRhdHVsZWFA
bnZpZGlhLmNvbT4gd3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4gPiBDdXJyZW50bHksIGhhcmR3YXJl
IFZRcyBhcmUgY3JlYXRlZCByaWdodCB3aGVuIHRoZSB2ZHBhIGRldmljZSBnZXRzIGludG8NCj4g
PiA+ID4gRFJJVkVSX09LIHN0YXRlLiBUaGF0IGlzIGVhc2llciBiZWNhdXNlIG1vc3Qgb2YgdGhl
IFZRIHN0YXRlIGlzIGtub3duIGJ5DQo+ID4gPiA+IHRoZW4uDQo+ID4gPiA+IA0KPiA+ID4gPiBU
aGlzIHBhdGNoIHN3aXRjaGVzIHRvIGNyZWF0aW5nIGFsbCBWUXMgYW5kIHRoZWlyIGFzc29jaWF0
ZWQgcmVzb3VyY2VzDQo+ID4gPiA+IGF0IGRldmljZSBjcmVhdGlvbiB0aW1lLiBUaGUgbW90aXZh
dGlvbiBpcyB0byByZWR1Y2UgdGhlIHZkcGEgZGV2aWNlDQo+ID4gPiA+IGxpdmUgbWlncmF0aW9u
IGRvd250aW1lIGJ5IG1vdmluZyB0aGUgZXhwZW5zaXZlIG9wZXJhdGlvbiBvZiBjcmVhdGluZw0K
PiA+ID4gPiBhbGwgdGhlIGhhcmR3YXJlIFZRcyBhbmQgdGhlaXIgYXNzb2NpYXRlZCByZXNvdXJj
ZXMgb3V0IG9mIGRvd250aW1lIG9uDQo+ID4gPiA+IHRoZSBkZXN0aW5hdGlvbiBWTS4NCj4gPiA+
ID4gDQo+ID4gPiA+IFRoZSBWUXMgYXJlIG5vdyBjcmVhdGVkIGluIGEgYmxhbmsgc3RhdGUuIFRo
ZSBWUSBjb25maWd1cmF0aW9uIHdpbGwNCj4gPiA+ID4gaGFwcGVuIGxhdGVyLCBvbiBEUklWRVJf
T0suIFRoZW4gdGhlIGNvbmZpZ3VyYXRpb24gd2lsbCBiZSBhcHBsaWVkIHdoZW4NCj4gPiA+ID4g
dGhlIFZRcyBhcmUgbW92ZWQgdG8gdGhlIFJlYWR5IHN0YXRlLg0KPiA+ID4gPiANCj4gPiA+ID4g
V2hlbiAuc2V0X3ZxX3JlYWR5KCkgaXMgY2FsbGVkIG9uIGEgVlEgYmVmb3JlIERSSVZFUl9PSywg
c3BlY2lhbCBjYXJlIGlzDQo+ID4gPiA+IG5lZWRlZDogbm93IHRoYXQgdGhlIFZRIGlzIGFscmVh
ZHkgY3JlYXRlZCBhIHJlc3VtZV92cSgpIHdpbGwgYmUNCj4gPiA+ID4gdHJpZ2dlcmVkIHRvbyBl
YXJseSB3aGVuIG5vIG1yIGhhcyBiZWVuIGNvbmZpZ3VyZWQgeWV0LiBTa2lwIGNhbGxpbmcNCj4g
PiA+ID4gcmVzdW1lX3ZxKCkgaW4gdGhpcyBjYXNlLCBsZXQgaXQgYmUgaGFuZGxlZCBkdXJpbmcg
RFJJVkVSX09LLg0KPiA+ID4gPiANCj4gPiA+ID4gRm9yIHZpcnRpby12ZHBhLCB0aGUgZGV2aWNl
IGNvbmZpZ3VyYXRpb24gaXMgZG9uZSBlYXJsaWVyIGR1cmluZw0KPiA+ID4gPiAudmRwYV9kZXZf
YWRkKCkgYnkgdmRwYV9yZWdpc3Rlcl9kZXZpY2UoKS4gQXZvaWQgY2FsbGluZw0KPiA+ID4gPiBz
ZXR1cF92cV9yZXNvdXJjZXMoKSBhIHNlY29uZCB0aW1lIGluIHRoYXQgY2FzZS4NCj4gPiA+ID4g
DQo+ID4gPiANCj4gPiA+IEkgZ3Vlc3MgdGhpcyBoYXBwZW5zIGlmIHZpcnRpb192ZHBhIGlzIGFs
cmVhZHkgbG9hZGVkLCBidXQgSSBjYW5ub3QNCj4gPiA+IHNlZSBob3cgdGhpcyBpcyBkaWZmZXJl
bnQgaGVyZS4gQXBhcnQgZnJvbSB0aGUgSU9UTEIsIHdoYXQgZWxzZSBkb2VzDQo+ID4gPiBpdCBj
aGFuZ2UgZnJvbSB0aGUgbWx4NV92ZHBhIFBPVj8NCj4gPiA+IA0KPiA+IEkgZG9uJ3QgdW5kZXJz
dGFuZCB5b3VyIHF1ZXN0aW9uLCBjb3VsZCB5b3UgcmVwaHJhc2Ugb3IgcHJvdmlkZSBtb3JlIGNv
bnRleHQNCj4gPiBwbGVhc2U/DQo+ID4gDQo+IA0KPiBNeSBtYWluIHBvaW50IGlzIHRoYXQgdGhl
IHZkcGEgcGFyZW50IGRyaXZlciBzaG91bGQgbm90IGJlIGFibGUgdG8NCj4gdGVsbCB0aGUgZGlm
ZmVyZW5jZSBiZXR3ZWVuIHZob3N0X3ZkcGEgYW5kIHZpcnRpb192ZHBhLiBUaGUgb25seQ0KPiBk
aWZmZXJlbmNlIEkgY2FuIHRoaW5rIG9mIGlzIGJlY2F1c2Ugb2YgdGhlIHZob3N0IElPVExCIGhh
bmRsaW5nLg0KPiANCj4gRG8geW91IGFsc28gb2JzZXJ2ZSB0aGlzIGJlaGF2aW9yIGlmIHlvdSBh
ZGQgdGhlIGRldmljZSB3aXRoICJ2ZHBhDQo+IGFkZCIgd2l0aG91dCB0aGUgdmlydGlvX3ZkcGEg
bW9kdWxlIGxvYWRlZCwgYW5kIHRoZW4gbW9kcHJvYmUNCj4gdmlydGlvX3ZkcGE/DQo+IA0KQWFo
LCBub3cgSSB1bmRlcnN0YW5kIHdoYXQgeW91IG1lYW4uIEluZGVlZCBpbiBteSB0ZXN0cyBJIHdh
cyBsb2FkaW5nIHRoZQ0KdmlydGlvX3ZkcGEgbW9kdWxlIGJlZm9yZSBhZGRpbmcgdGhlIGRldmlj
ZS4gV2hlbiBkb2luZyBpdCB0aGUgb3RoZXIgd2F5IGFyb3VuZA0KdGhlIGRldmljZSBkb2Vzbid0
IGdldCBjb25maWd1cmVkIGR1cmluZyBwcm9iZS4NCiANCg0KPiBBdCBsZWFzdCB0aGUgY29tbWVu
dCBzaG91bGQgYmUgc29tZXRoaW5nIGluIHRoZSBsaW5lIG9mICJJZiB3ZSBoYXZlDQo+IGFsbCB0
aGUgaW5mb3JtYXRpb24gdG8gaW5pdGlhbGl6ZSB0aGUgZGV2aWNlLCBwcmUtd2FybSBpdCBoZXJl
IiBvcg0KPiBzaW1pbGFyLg0KTWFrZXMgc2Vuc2UuIEkgd2lsbCBzZW5kIGEgdjMgd2l0aCB0aGUg
Y29tbWl0ICsgY29tbWVudCBtZXNzYWdlIHVwZGF0ZS4NCg0KPiANCj4gPiBUaGFua3MsDQo+ID4g
RHJhZ29zDQo+ID4gDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IERyYWdvcyBUYXR1bGVhIDxkdGF0
dWxlYUBudmlkaWEuY29tPg0KPiA+ID4gPiBSZXZpZXdlZC1ieTogQ29zbWluIFJhdGl1IDxjcmF0
aXVAbnZpZGlhLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBkcml2ZXJzL3ZkcGEvbWx4NS9u
ZXQvbWx4NV92bmV0LmMgfCAzNyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
DQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMo
LSkNCj4gPiA+ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQv
bWx4NV92bmV0LmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMNCj4gPiA+ID4g
aW5kZXggMjQ5YjVhZmJlMzRhLi5iMjgzNmZkM2QxZGQgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2Ry
aXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL3Zk
cGEvbWx4NS9uZXQvbWx4NV92bmV0LmMNCj4gPiA+ID4gQEAgLTI0NDQsNyArMjQ0NCw3IEBAIHN0
YXRpYyB2b2lkIG1seDVfdmRwYV9zZXRfdnFfcmVhZHkoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2
LCB1MTYgaWR4LCBib29sIHJlYWR5DQo+ID4gPiA+ICAgICAgICAgbXZxID0gJm5kZXYtPnZxc1tp
ZHhdOw0KPiA+ID4gPiAgICAgICAgIGlmICghcmVhZHkpIHsNCj4gPiA+ID4gICAgICAgICAgICAg
ICAgIHN1c3BlbmRfdnEobmRldiwgbXZxKTsNCj4gPiA+ID4gLSAgICAgICB9IGVsc2Ugew0KPiA+
ID4gPiArICAgICAgIH0gZWxzZSBpZiAobXZkZXYtPnN0YXR1cyAmIFZJUlRJT19DT05GSUdfU19E
UklWRVJfT0spIHsNCj4gPiA+ID4gICAgICAgICAgICAgICAgIGlmIChyZXN1bWVfdnEobmRldiwg
bXZxKSkNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgcmVhZHkgPSBmYWxzZTsNCj4g
PiA+ID4gICAgICAgICB9DQo+ID4gPiA+IEBAIC0zMDc4LDEwICszMDc4LDE4IEBAIHN0YXRpYyB2
b2lkIG1seDVfdmRwYV9zZXRfc3RhdHVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTggc3Rh
dHVzKQ0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyX3Nl
dHVwOw0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICB9DQo+ID4gPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgIHJlZ2lzdGVyX2xpbmtfbm90aWZpZXIobmRldik7DQo+ID4gPiA+IC0g
ICAgICAgICAgICAgICAgICAgICAgIGVyciA9IHNldHVwX3ZxX3Jlc291cmNlcyhuZGV2LCB0cnVl
KTsNCj4gPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgaWYgKGVycikgew0KPiA+ID4gPiAt
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1seDVfdmRwYV93YXJuKG12ZGV2LCAiZmFp
bGVkIHRvIHNldHVwIGRyaXZlclxuIik7DQo+ID4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgZ290byBlcnJfZHJpdmVyOw0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
ICBpZiAobmRldi0+c2V0dXApIHsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBlcnIgPSByZXN1bWVfdnFzKG5kZXYpOw0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGlmIChlcnIpIHsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIG1seDVfdmRwYV93YXJuKG12ZGV2LCAiZmFpbGVkIHRvIHJlc3VtZSBW
UXNcbiIpOw0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Z290byBlcnJfZHJpdmVyOw0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IH0NCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgfSBlbHNlIHsNCj4gPiA+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlcnIgPSBzZXR1cF92cV9yZXNvdXJjZXMobmRl
diwgdHJ1ZSk7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGVy
cikgew0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWx4
NV92ZHBhX3dhcm4obXZkZXYsICJmYWlsZWQgdG8gc2V0dXAgZHJpdmVyXG4iKTsNCj4gPiA+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyX2RyaXZlcjsN
Cj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9DQo+ID4gPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgIH0NCj4gPiA+ID4gICAgICAgICAgICAgICAgIH0gZWxzZSB7DQo+
ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIG1seDVfdmRwYV93YXJuKG12ZGV2LCAiZGlk
IG5vdCBleHBlY3QgRFJJVkVSX09LIHRvIGJlIGNsZWFyZWRcbiIpOw0KPiA+ID4gPiBAQCAtMzE0
Miw2ICszMTUwLDcgQEAgc3RhdGljIGludCBtbHg1X3ZkcGFfY29tcGF0X3Jlc2V0KHN0cnVjdCB2
ZHBhX2RldmljZSAqdmRldiwgdTMyIGZsYWdzKQ0KPiA+ID4gPiAgICAgICAgICAgICAgICAgaWYg
KG1seDVfdmRwYV9jcmVhdGVfZG1hX21yKG12ZGV2KSkNCj4gPiA+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgbWx4NV92ZHBhX3dhcm4obXZkZXYsICJjcmVhdGUgTVIgZmFpbGVkXG4iKTsNCj4g
PiA+ID4gICAgICAgICB9DQo+ID4gPiA+ICsgICAgICAgc2V0dXBfdnFfcmVzb3VyY2VzKG5kZXYs
IGZhbHNlKTsNCj4gPiA+ID4gICAgICAgICB1cF93cml0ZSgmbmRldi0+cmVzbG9jayk7DQo+ID4g
PiA+IA0KPiA+ID4gPiAgICAgICAgIHJldHVybiAwOw0KPiA+ID4gPiBAQCAtMzgzNiw4ICszODQ1
LDIxIEBAIHN0YXRpYyBpbnQgbWx4NV92ZHBhX2Rldl9hZGQoc3RydWN0IHZkcGFfbWdtdF9kZXYg
KnZfbWRldiwgY29uc3QgY2hhciAqbmFtZSwNCj4gPiA+ID4gICAgICAgICAgICAgICAgIGdvdG8g
ZXJyX3JlZzsNCj4gPiA+ID4gDQo+ID4gPiA+ICAgICAgICAgbWd0ZGV2LT5uZGV2ID0gbmRldjsN
Cj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgIC8qIEZvciB2aXJ0aW8tdmRwYSwgdGhlIGRldmlj
ZSB3YXMgc2V0IHVwIGR1cmluZyBkZXZpY2UgcmVnaXN0ZXIuICovDQo+ID4gPiA+ICsgICAgICAg
aWYgKG5kZXYtPnNldHVwKQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4g
PiA+ICsNCj4gPiA+ID4gKyAgICAgICBkb3duX3dyaXRlKCZuZGV2LT5yZXNsb2NrKTsNCj4gPiA+
ID4gKyAgICAgICBlcnIgPSBzZXR1cF92cV9yZXNvdXJjZXMobmRldiwgZmFsc2UpOw0KPiA+ID4g
PiArICAgICAgIHVwX3dyaXRlKCZuZGV2LT5yZXNsb2NrKTsNCj4gPiA+ID4gKyAgICAgICBpZiAo
ZXJyKQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgZ290byBlcnJfc2V0dXBfdnFfcmVzOw0KPiA+
ID4gPiArDQo+ID4gPiA+ICAgICAgICAgcmV0dXJuIDA7DQo+ID4gPiA+IA0KPiA+ID4gPiArZXJy
X3NldHVwX3ZxX3JlczoNCj4gPiA+ID4gKyAgICAgICBfdmRwYV91bnJlZ2lzdGVyX2RldmljZSgm
bXZkZXYtPnZkZXYpOw0KPiA+ID4gPiAgZXJyX3JlZzoNCj4gPiA+ID4gICAgICAgICBkZXN0cm95
X3dvcmtxdWV1ZShtdmRldi0+d3EpOw0KPiA+ID4gPiAgZXJyX3JlczI6DQo+ID4gPiA+IEBAIC0z
ODYzLDYgKzM4ODUsMTEgQEAgc3RhdGljIHZvaWQgbWx4NV92ZHBhX2Rldl9kZWwoc3RydWN0IHZk
cGFfbWdtdF9kZXYgKnZfbWRldiwgc3RydWN0IHZkcGFfZGV2aWNlICoNCj4gPiA+ID4gDQo+ID4g
PiA+ICAgICAgICAgdW5yZWdpc3Rlcl9saW5rX25vdGlmaWVyKG5kZXYpOw0KPiA+ID4gPiAgICAg
ICAgIF92ZHBhX3VucmVnaXN0ZXJfZGV2aWNlKGRldik7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAg
ICAgICBkb3duX3dyaXRlKCZuZGV2LT5yZXNsb2NrKTsNCj4gPiA+ID4gKyAgICAgICB0ZWFyZG93
bl92cV9yZXNvdXJjZXMobmRldik7DQo+ID4gPiA+ICsgICAgICAgdXBfd3JpdGUoJm5kZXYtPnJl
c2xvY2spOw0KPiA+ID4gPiArDQo+ID4gPiA+ICAgICAgICAgd3EgPSBtdmRldi0+d3E7DQo+ID4g
PiA+ICAgICAgICAgbXZkZXYtPndxID0gTlVMTDsNCj4gPiA+ID4gICAgICAgICBkZXN0cm95X3dv
cmtxdWV1ZSh3cSk7DQo+ID4gPiA+IA0KPiA+ID4gPiAtLQ0KPiA+ID4gPiAyLjQ1LjENCj4gPiA+
ID4gDQo+ID4gPiANCj4gPiANCj4gDQoNCg==

