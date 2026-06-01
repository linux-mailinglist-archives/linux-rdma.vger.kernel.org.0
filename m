Return-Path: <linux-rdma+bounces-21576-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UP8HEthfHWojZwkAu9opvQ
	(envelope-from <linux-rdma+bounces-21576-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 12:32:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A17AF61D872
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 12:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEB6B3108F46
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jun 2026 10:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CDD395AC2;
	Mon,  1 Jun 2026 10:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NCxIom99"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012023.outbound.protection.outlook.com [52.101.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49423438B4;
	Mon,  1 Jun 2026 10:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780308254; cv=fail; b=JY7YtgJopAVlgG/Sok0ADZ1Q+7pz1mDDWJ8KQD95L77knPRvhJmXgsNfyELZ2mlXkvbfG5qoaR1/p3oA2k16ISJkJQsywkuVB9mXcxhQk79Vcq5vy0fCRU9q1R7xfOLvvC5l5Nzg5xcrjQY8Yn8XIqzdpM2sVMXnUv5OSiGzgRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780308254; c=relaxed/simple;
	bh=1weWD4aHTj/3qk7fKG/6O5SWun0iV3xL6/50O3RoZ6k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZMoncD0WDRHL2Z9jz11Ko9S8NrvZqvRsRH7so17W0UODxUH1YPcmeHeUhgWnz5k0ErO2OyDeEpCjCHq4EvDlcTUsHgwrfg+pGvFv28HM6Fc6qwf/rlEi+Voa0hMMjayKhO+8uhnjeq6uIw4f38l12pxDi9xk7iS0x5cqs69FMPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NCxIom99; arc=fail smtp.client-ip=52.101.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uH+99+w3IZlqcmNJpJBgAHsiHtrLp5rc4/MNYdsyjrPB2NJzUpvBbKxV3ng/A9u8DqQYJgYJq/JJ9iDqicZIc3Jw9Sq77RGYjRFmr9qESyE+5ahfs8LBKzjf4T7LQ1zLVhywZz3BWDXm0IhnBrTCBW0JLdirLAMlK/2nGJpRVlgIeEUfuxLlzGYuq9GW0Z8U8XIo7sF8lKMUfDk+SJR2U+v4RYcJOFjH98bnK1iUY+bryPCy8wzPt1Ll/RlIAe5gY6V6E8noDlyy06me6fkgI4r3XF4/qlJ6sZHtYuT72G5p488okYR5F+K2iAsXhc38XnY7vjyaoGEA9ydP/WT/cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9J3ZW/YwFh+foa2AV0Pfgha1panoCoBX7Phvsz0+qE=;
 b=Xo3+vC7gQNncpSvXbNcbb+ZfEBgoDTYzJV6bAmwdSXTmDroL+lZv8Ckj3fcimTfnCv83HD9GA2tvXN/0/CjKtVfcBBF1w5+o0x32RMyvDVvwXcgwLrKuty/bH2+43ci/w8Pq2ZZZgjSlT6++UFMNSAHPQ3PBrJgHo4T6uaCG0790jiuIA7Vcj4TbprPg3/1nEjjuBhK4ZXzq8t7e6iVToEHV/qv4MWrXUO8BWX1C8S7JmTbKv9moV/o1IphOhRL4wbUg4SrvBj5ofc/AZs+GzNm084FRRxL/92B95Mmm1Pbj2r87wZXFgK75gqe0+SZslQGtOgePyMRN2SoIfqZ0mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9J3ZW/YwFh+foa2AV0Pfgha1panoCoBX7Phvsz0+qE=;
 b=NCxIom99rrPtVXdwPQXEdqUoXR4iMh+9dIIJryv8ADmdg1mmifYYlbXyNPIQFJ/kfdPVOSmAYPmk1Z4aP4uLj4fmSv6l2T40c/HlsuR4EbHjLtZOcYOhIHCqHwVBb95YnDqcOfxo10/xo79HbgbqlxdoilZ1olEsSMyozpBl4cI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA0PR12MB7462.namprd12.prod.outlook.com (2603:10b6:806:24b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 10:04:00 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 10:04:00 +0000
Message-ID: <072c6d92-0481-4f77-b878-e94a9786d16a@amd.com>
Date: Mon, 1 Jun 2026 12:03:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
To: Keith Busch <kbusch@kernel.org>
Cc: Zhiping Zhang <zhipingz@meta.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Bjorn Helgaas <helgaas@kernel.org>,
 kvm@vger.kernel.org, linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Yochai Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
 Linus Torvalds <torvalds@linuxfoundation.org>
References: <20260526144401.1485788-1-zhipingz@meta.com>
 <a8cd01ab-d7aa-465d-bfa3-431f78f33ee1@amd.com>
 <20260527121438.GJ2487554@ziepe.ca>
 <ff247643-73e7-44e2-b3d5-8ac0a8efb871@amd.com>
 <20260527123634.GK2487554@ziepe.ca>
 <a5ff1930-e9fb-43f5-82ab-9875d7a28421@amd.com>
 <CAH3zFs2KALuHXReLZG_uoqvBBWvBzU6rHKakmt6HBV7PZEsD=w@mail.gmail.com>
 <71302a7a-6b9f-40da-af81-b1862dbd637a@amd.com>
 <CAH3zFs036sr93duQKx613pCyOYw4t0_x_TdSza1xBCaEmqijyA@mail.gmail.com>
 <8d9bb0b7-182d-4930-b683-d5d24da6b2ab@amd.com> <ahn3ovmkEq-Y-LKt@kbusch-mbp>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <ahn3ovmkEq-Y-LKt@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA0PR12MB7462:EE_
X-MS-Office365-Filtering-Correlation-Id: fe418be1-7ee4-46cc-d799-08debfc51a55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	9cHBKVoiefc4xNQhaMbqnA9yE0TAxFw2FV3WLC9oCWD7xSpuR7Z3/U64TOWu4yAjev3G90pQbSm8DQIpl5kFKW1xIYAyyM6vBYRg97Abk8CEo5KffDEaP9HhQaRR/Dggj5arcKHMvPA6y4ZAQhQPILijB5gQLkKjPh2sbYwkw2VJuwkH4FKHuQlkaZ7d2f7QFCJdNQL+yXQLYZBRZsR/wMH9Z3Dc5Y9R68Ko23C0kHFLntU2XBqDwigjbmQtq0r4PCpvB2hUO6C9NQw+T9Aw1pOoHIyLGX4Zq/eh8udVGFI8NiORzc0UOHbqlaH4+3eYkOMKl5KksGUjuWdUodlwRCTCP8Fhf837RfurC33u76BjxyhDQEUHvpAsSgkHqTCfC6mvJ1d7n+rrxqvNPISUGovr7jKdiAKKfj0IYXOZFoS34IrK+49q51fYf0H+oP2dfOAoVGFbNBPOKJ7PmRKsoNoBG4njlFUjbTlmZR8x1W/w3ZO7EF+0R+E1b4AVzHz1w3PbogpXLOFBh19rwbJASoPV3zdcfbSTyijH7Ta28Klue5cF8Q1rI49lP0g1ubMrw1tp2dbwL8xYA72MS0D9HZv0vlP1fwjp2KzmDsXw72lYrK97nnnXBLiOC09uHVOHKLTqDJilcNdKser5QDPuzceC2ISPpdd12uU9uqGsEh4QfZF1hR7S1ziZsky+xLyWAOfzZxTjVaNkK+fTKdddvw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REFYLzRFNmRhN1dEamFxbW1rakRwbWtncTROSnh6aS8vckhXU0x6Y1JETnVN?=
 =?utf-8?B?SkRIYkhVU3RBak5Lb0VRdlBDY0RrT3A0cGVRMnRyMVUyQzhDOXh0bVFSK2Q2?=
 =?utf-8?B?ODU1d3hwejZxQ3p3SDFEdWp0aEc2VG5ja2dJS2ljZDJTVE1lcU54eEwwVTZD?=
 =?utf-8?B?c2NaODJyaXBoUE9iZUZYZ3QwOEpGSHpOWCs2UzA3YlpHM3o4eVdCN05UK1Qz?=
 =?utf-8?B?b3h5SHRkcm9xMWRHak05QmdsaUNhNWdocFJwOEZsdEV2RUJhdk4yNkxlajY1?=
 =?utf-8?B?S0hHYnZCeUd6TFFXTXVFTkdMMjRiNTFkcVZSc1BTWEllRFo3Q1dScWNVaE52?=
 =?utf-8?B?b3F0MXJTWEFQSTV6OGZhTjIyVENESzN6MkRaa0FDcXh0SGZTcC9GT1l5TnpZ?=
 =?utf-8?B?R1JJMHR4UTRKNUhKWlMwWW1Fenp3V2dWSWhweW1HR3hBdWFIOHRTdFFvNlF3?=
 =?utf-8?B?MU5uVHNVU0RWOFVpdVUraE1wNzhEOVlDWFZUSkVGTFViTWM1WTllK0xMYThT?=
 =?utf-8?B?Q2ZqeGZhVlJEUW92cjREQzN4bnUxZEp6ZDJtb1VIUFJmQk5QbXk3dWxuQUpr?=
 =?utf-8?B?SElIR3NQd0ZqMEFGR2pMTXdqZE4xK1ZGdXh1RElCdU9MOG5oRkthYm5YVVZH?=
 =?utf-8?B?QUZ6QWQzMW44UmZuT0FqaWF3b1FyeHBDUmRtQldoUkFIQ0dtOXFoMWtITnZC?=
 =?utf-8?B?ZkV4RFZZRGVjTzhGbTN4QXVodGdhQ2xkdTdSdDVsR2pqNU8wWVVGUGNlclph?=
 =?utf-8?B?N1FIdjNZRlZDb08xWkxPOXZHUW9QcStXU3VrbFc3NjdFYzl5Z2RwYWdENjQ0?=
 =?utf-8?B?VFJUMXFKQjJnWVJTZ0V3dGEyYkovbTNwQ0dJR3VsSU16ZHVrc2FrNjJ3T3k4?=
 =?utf-8?B?M3ZIRkhOb3B4b1BWWnAybWt3NThHaC9QbGxxWk1HdEJmZCtsREpxN1lobXdU?=
 =?utf-8?B?S2p1SUw5S3BzVnRQcmNWZmc4dG1Bb1lWWG1HWjNITjR4WEt5eUprVFJNM0Y0?=
 =?utf-8?B?L1dKdzdLaXRvTUhDSlQ1WkxzK1FFcGVHdW1FVFUyOUNQdFMyak9qRW1zTzhQ?=
 =?utf-8?B?cVZxT1dFRVhuOUdCUUorOCtjVHVWL2EvNXJwNGFRRkpxeFJrQmVzK3pnSWFo?=
 =?utf-8?B?RUlUeFp1TE1DY1pCa0x1TXJ5ZVJqVDVHRmpWbmtyUzk2Vm1sL2VWYkd1ZGUz?=
 =?utf-8?B?RnZ6L2dYNEVlbW5vbGFJV2psdkk3aDBxYnd5WFg5Zm9VUFRzdnZzcWFUeVhC?=
 =?utf-8?B?SWtRbXY0a01ENUZOVGJyeCtOZjFSejBYMTVYOVUwcWxGYmgvbTlWZ1F3U25i?=
 =?utf-8?B?VVNmZXR5YVdTdVlDVE5yMlJPaGpFVlFYRzFTMkczUUpXM1htdWFva3ZDWjR2?=
 =?utf-8?B?MlJPbUVOQnNDcmdBd0hYNnJLNnIzS0tiT2ZOTDBVRUhDS2JvMTZwT0Y1SG90?=
 =?utf-8?B?MWVqT2Z6U29mNWhJVmUwV2JVT2loQ1p5a2c2R3FUaUhiWjhyMFdqNGZjbjN2?=
 =?utf-8?B?WFg0SU9JT3lmc1ZwL1lDM2duZTcxU05Xb0dYK3loMmEweElGcnFIeUNBa2xl?=
 =?utf-8?B?UWdCNmJ2dElLNm00dVhZVnJJWTM2UjFpYTVvc1gvYmwyZWpwVlhJMXZjc284?=
 =?utf-8?B?c2NPM3hEU3V0ZTJPS1hldFMvY2tKQVRUYVJ5Q0VqeHFUbVhRdy9yMXEyL21l?=
 =?utf-8?B?QWx1QmFJRHlmaHQzM3NicEs3M3VqQk4za1RLazZZTUxKWGprOHdyUExaM3lq?=
 =?utf-8?B?WjV3ZWNQTEdvVU1TTEhpbm5SRG4xVXhEVnJOMjBVemw2NFg3VEJoaDBQNzBT?=
 =?utf-8?B?Y1U3SFlEUjhiSC93OWh6NDROMmJLSkNMSkdBdHE1cG5Xc0dxYTBseFdYNHor?=
 =?utf-8?B?dTZ2N3NmZlNkdFZoQ0Z6NmUyM05rODhVODAva21IV3drWUZqYUVoWFVWN2l4?=
 =?utf-8?B?VGxKdkNKeHpDQzlsWTRkRFF2RkxzUmFDeTdxdTdtdVlUY1VSWEhCMkZ0VUp1?=
 =?utf-8?B?THlhUUxqVWVJTWZjUDlpRjA0NTFOYnVtc04rK0RTTTlpYTBLMmFyN3pIa09H?=
 =?utf-8?B?N3p4Y29PaVdCSGVCS21qWGQrQWgwTXQ2VjhVWjNBS3pBdFA2R1VjYU5sOTEz?=
 =?utf-8?B?OFJ1TlI3dURvYzhHaDBhcDN0SGZjb0p6RjBzaGU0OFI3V0hMZW1zSEROMmp3?=
 =?utf-8?B?WXJIcmVlUHZ0NHZCTDY4U1JzY0FtN1JRQ25SNndad05IYmFwTFVjWWFUdjdz?=
 =?utf-8?B?R2RoUXh6QUJVdnpXSm1xRXVDcHJqOEZPVm5pall0c0NHOU1oYThzSFJDa1Va?=
 =?utf-8?Q?i4QjpF6ALapwSYPxPw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe418be1-7ee4-46cc-d799-08debfc51a55
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 10:04:00.5826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wKiHQiJ3m1Rra3aWpBqwn46Brmc1VUVzv0A6kSA35/XNHE4PAHmc+BBtQ9XkuXjO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7462
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21576-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.koenig@amd.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:mid,amd.com:dkim]
X-Rspamd-Queue-Id: A17AF61D872
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/29/26 22:31, Keith Busch wrote:
> On Fri, May 29, 2026 at 09:36:00AM +0200, Christian König wrote:
>> On 5/29/26 08:34, Zhiping Zhang wrote:
>> ...
>>> There's no in-tree vendor PF driver
>>
>> Well I have to admit it's a bit on the edge but this sentence is a show stopper.
>>
>> DMA-buf is an in kernel interface for buffer sharing between drivers and any change to it needs an in kernel driver as justification for the added complexity.
>>
>>> - the device is a Meta MTIA
>>> accelerator managed entirely from userspace via VFIO passthrough.
>>
>> When you have a complete open source driver stack which utilizes VFIO passthrough as the interface to communicate with the kernel drivers then we can eventually talk about that.
>>
>> But as far as I can see without upstreaming or at least open sourcing the full stack to utilize this functionality it's a clear NAK to upstreaming this.
> 
> But the existing dmabuf for vfio-pci was accepted upstream without these
> requirements. I see you had concerns about even that, but still Acked
> under the same model that's propsed in this series:
> 
>   https://lore.kernel.org/linux-pci/57b8876f-1399-4e4d-a44b-1177787aa17d@amd.com/

Well that wasn't driver to driver API but just some helpers which we didn't know where else to but.

This here is an addition to the inter driver API which as far as I can see is currently not beneficial to anybody else.

> So with vfio-pci and mlx5 both in-tree dmabuf users, implementing and
> consuming the callback, does this not satisfy the requirement? The
> userspace-driven semantics are inherent to VFIO's design. I don't see
> what additional value open sourcing the user-side provides for the
> kernel-side review process.

Well upstreaming something into Linus tree only makes sense if others can use it.

And as far as I can see without all components available this is not the case.

Regards,
Christian.

