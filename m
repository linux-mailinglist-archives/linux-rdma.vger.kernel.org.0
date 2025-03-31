Return-Path: <linux-rdma+bounces-9043-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D58E1A76D7B
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Mar 2025 21:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D476B7A2B47
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Mar 2025 19:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A83219A91;
	Mon, 31 Mar 2025 19:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JdjMKDSD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A528F79C0;
	Mon, 31 Mar 2025 19:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743449380; cv=fail; b=S26lcS6anTbmWEIE5zQNXJXyajm6kQbMDoa63GWI08JQUJD06lpyKRPegoTjCdO/LSIqs1ABznkiYzWX0fpjLsIp9D5uZ1yQWCTSn6RJ0JpB2lNghRyuF3VBISSbqBrXFFSEsBPgS2e7uMFaaSWkKRoDBVvdZOmi1Qu59KoxbzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743449380; c=relaxed/simple;
	bh=ijNBnNQLdLpqgfeExRUWC3dFjCVGoBi8wFiLQR5DSEU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N+Tr/D46sFijKH8/WPucqUyv1O3uGGknvrWM9C0sakOYsNF5Hge6K2pv6ntAZ5BClN53bM801Rrj10AMY83S7QekWBDa5eQaHLoqYueu0F+DYke7YAeJ2RvuMz+rUIBhGFhzV2aIpBleRfb5/NpyGlfBh34TUczhur1UwFeFVus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JdjMKDSD; arc=fail smtp.client-ip=40.107.244.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDzhIMRCi9/nBoWq1Nk7sGI621U3yiRZKBNVHe9LX6VIDcIhgpYR+WZJIysIKNI20A403ber7qFPyD80cylQ1xYUvXuoXfDwMKe2pHo4bEFGP14iosPV8U/Q0mDDsCsgworS+cbTS3T+zK1wmv6iaggtFihGdDgRdw13StmIgfpiRy3Du/gFDnerSSHYzXHpmKfgjTibMEaBwAtQIxXvw3lST+r0rtFbOkoNxoMOCe9nNPvHLkDhbjDh6B4sDo4T8tK433ugrq9QqIir5ZKxwBovbmRU5hmcnTMKXOA9NsGaMeT27nVCEucNLm3Bk+nKMIlym6ZYP8VNqiuyH8K1dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+8Pwd+KIQ5Wg0tRrOMr30gpINPoYLQwIGbfUcLw9+c=;
 b=TfalGpJa+NMhIEG/8AfTAiC+lRl5Kch3P9VBGTnrMZfKztDvpEFRIOLtNjmPVrVUO+NPhr/+Yx0pRWVBea4U8eMtPEaZdINFq0ZnuJgLrdkF8HzzTUdgqjix2Za+FZcHvcCPyO+nft6rdmrEJGQIP9Q/XytNBFVXaAE6QhwY/4YnTjfIwwcx7t4gAirS9lJBwTjy62fEBvAH4Im9pZM1jqLCdVnT0EVcij+HTOcxlsX9uPEcmehrRtEc8etfQTWpmkgjIXva7YlxNSZEgzHclFcVoC8vOCTdFpNvH/YFhECOYWzWbSUhtZ9QQKIOkkPMCimOZqeAlz8sQQgUMRdtwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+8Pwd+KIQ5Wg0tRrOMr30gpINPoYLQwIGbfUcLw9+c=;
 b=JdjMKDSDiD80U39rGyJ0Qnt2KTJGuzIk88hnp1qaBMz9wuv9sFpw2mts99GxY/cuuZIZIZNJETMkSllbSpMUO3DCpV0DU49+k2gAIdr7bPaldDPrc33nVMKUX+64NVQmRh4/qcZiu8IfOGcJsD2+esC4OS6T8N77OI3gdGACkKnYKuOf7BBR0I0GMBqSMUjdJPfwLKm9t7S+tFpo9NpEby6IjVpK+Jik5+wXKvrbbor64pnt2jpUdTCwzw+kiuCiLoh/Rf2xN3Cu2hPxTNpeWsnPlO5tx/ai9JrSycELQwf9pLJJ0xxXcpmC9OEG+X7OCVk8JptXZ1AzTNgWjS/LPg==
Received: from DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17)
 by SJ2PR12MB8720.namprd12.prod.outlook.com (2603:10b6:a03:539::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 19:29:32 +0000
Received: from DM6PR12MB4313.namprd12.prod.outlook.com
 ([fe80::4d58:4bbc:90a5:1f13]) by DM6PR12MB4313.namprd12.prod.outlook.com
 ([fe80::4d58:4bbc:90a5:1f13%3]) with mapi id 15.20.8534.045; Mon, 31 Mar 2025
 19:29:32 +0000
From: Sean Hefty <shefty@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
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
	<davem@redhat.com>, "ian.ziemba@hpe.com" <ian.ziemba@hpe.com>,
	"andrew.tauferner@cornelisnetworks.com"
	<andrew.tauferner@cornelisnetworks.com>, "welch@hpe.com" <welch@hpe.com>,
	"rakhahari.bhunia@keysight.com" <rakhahari.bhunia@keysight.com>,
	"kingshuk.mandal@keysight.com" <kingshuk.mandal@keysight.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Thread-Topic: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Thread-Index:
 AQHbjuwVUw9AWIkXnUa8bbJSM0sPK7N6v4MAgAgXf4CAAAnsgIABEwYAgAAgrcCAAYj9gIAAAVBQgAARqYCAAABpoIABaOyAgAaJkiA=
Date: Mon, 31 Mar 2025 19:29:32 +0000
Message-ID:
 <DM6PR12MB431332A6407547B225849F88BDAD2@DM6PR12MB4313.namprd12.prod.outlook.com>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
 <20250319164802.GA116657@nvidia.com>
 <CALgUMKhB7nZkU0RtJJRtcHFm2YVmahUPCQv2XpTwZw=PaaiNHg@mail.gmail.com>
 <DM6PR12MB4313D576318921D47B3C61B5BDA42@DM6PR12MB4313.namprd12.prod.outlook.com>
 <BN8PR15MB25131FB51A63577B5795614399A72@BN8PR15MB2513.namprd15.prod.outlook.com>
 <DM6PR12MB431329322A0C0CCB7D5F85E6BDA72@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+QTD7ihtQSYI0bl@nvidia.com>
 <DM6PR12MB43137AE666F19784D2832030BDA62@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+Qi+XxYizfhr06P@nvidia.com>
 <DM6PR12MB431345D07D958CF0B784AE0EBDA62@DM6PR12MB4313.namprd12.prod.outlook.com>
 <Z+VSFRFG1gIbGsLQ@nvidia.com>
In-Reply-To: <Z+VSFRFG1gIbGsLQ@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4313:EE_|SJ2PR12MB8720:EE_
x-ms-office365-filtering-correlation-id: 0cf7cb68-ac8e-481e-d094-08dd708a5d1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?bQghOKVYY7O1Yc9OBmvSGMNbf83qUJ5xGVCvhdIsxb9KhSY8C8KG8eq13u/L?=
 =?us-ascii?Q?nbZv76Q8We7s0WnFYhpOpWrfLYykQ0tk/eXSJYmAlE4Ieks3B69UoARDLl4a?=
 =?us-ascii?Q?OfWQT76f1MlIwgwRagDkje3beKHVvmvCCFI1v/ejBzhCXAjVfE2GGpOZfRwz?=
 =?us-ascii?Q?sEUFmYc01kes15YjeS27W574PYw5ctZJ7S/uDPggvNW5dMEDStjzaTMSnwgu?=
 =?us-ascii?Q?zk2J3btjN/WXlMIy4kTrLGCuEACTatC3hWADcK5YJODwycDwixKIq4VvzTLg?=
 =?us-ascii?Q?momK4OQgj0HAtMX8DEluZrVhN1JSCHcIg2YIZ1yht+SRpD4x8van8ShqCs+L?=
 =?us-ascii?Q?tqEY0PPRxixGNaokOoFYWXDR1whnG7R0DrWs+AU/cswIJi39rd+7C3ofyYvo?=
 =?us-ascii?Q?2ou86o4CiD4ZtMQBdNr2mlmQ6aRJaSd5keUEVnuSYE5Z3m1nigPIoEGE4x5g?=
 =?us-ascii?Q?UEoXNmJeoFLnsKArMjKzK34HsGGmlIkMOfoEFvEnhuLBJ+0Mz81wifSlmXkA?=
 =?us-ascii?Q?8EnqY8bqpT6wrcIIfMjxUPgotMtPWEVH+ffpWpTVICjR9DGyDdSbf4D48RjT?=
 =?us-ascii?Q?TeWp2efFq/C2AOSpaY1yx2KWdCVYe2YTKMiw950FxV851fp261RdViaAyp1W?=
 =?us-ascii?Q?iJmw9IJQZEkszsw+UVs5Ox6Pcj08Zl6zvLw1s0hMcaGMBXk/nbE66Hbf7JvR?=
 =?us-ascii?Q?StxZ5rXm1/IQ69wT8f7Q7D9+u6bltO56jzj60Ay4ACg1cW5Vvx1Ca+ftOo8M?=
 =?us-ascii?Q?CWFZHpC8jebvjhxzFzAjn59Jy3iplA56bu1kdEvs3JdLlnDQ+W8ZihZog1Ka?=
 =?us-ascii?Q?HmDbD03xM+5f2Alq0TCtAmY2mjTWC1h2BsG+hVZ8zi9DcEOwSFyaoLYleyOR?=
 =?us-ascii?Q?oYfhQ4cBS8ezjsyYhl6RDCHPvWHnFqSIarw96aJmYbvpjoC5cONI+V9Vm7Px?=
 =?us-ascii?Q?xHiWvQt8S+aUmehkRfpu91/Q/csDR2nrDI4Rlk3HvzimX+upIEP1irYDaizD?=
 =?us-ascii?Q?58cwL9/NEZIiDyh/jd/ZjJb1ejtSLqsv4WYeW/vkTnwQrjYUdYiAxd2ClEs6?=
 =?us-ascii?Q?3uE8STod2j/e5DHN9HlD651vkT+/T5tZ4Gd0avkd29ft8mPc5WDC38m42JJi?=
 =?us-ascii?Q?gewKzW3mpRx7H0RFMgAuJvONW9Ok+1IecXgIQ6O6CPV2rJ63TbRSiyX8bfMZ?=
 =?us-ascii?Q?NA/F9OV+pEKJ3TJD4qNAZyQPPoQJv4g/HPoLMK2nAr0kH/yP2Fd2JB5ZE0mb?=
 =?us-ascii?Q?1PGa5ZhCOd8gr9TDO+bPsfzVov3IuXUyptbSnsCaQ8xqaX3NZGev5FIjyIyU?=
 =?us-ascii?Q?uqw/KgGkARzi1cesvVAydzB3zJvfp4ZJJPj7UY0Rjr+jQeu1nZayPXVyJIuD?=
 =?us-ascii?Q?lcBvOq+MkCtXdHhYI8FuV/zJZZREKwgBMdq+f02r+BG6rmT/iwQFE1X26/TM?=
 =?us-ascii?Q?BfhbDCCe2krsgdHt1/lCrAvIYPHVOZPh?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4313.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4gaiMgdC4xxaASzqfqQ1UB0ynenCBThOwKqhO6/FnZr/HQpMaY4m5oIO6jcy?=
 =?us-ascii?Q?WI9bQBa/aVwlhfQ1twbvkKpr+JuPIF9n7o3+GtWyTZ6yoUITkpKP6hpYqN/T?=
 =?us-ascii?Q?FM/MmBSca/GAI6tNQjiwXKnab0yX1CYywd87uLEg+IhazLZh1/ubFiVBh7NB?=
 =?us-ascii?Q?Ai09teYX6QixParOni0pW9Q63gPUJatCx0pnASya28svw+w0I1EUi89Rfuse?=
 =?us-ascii?Q?ju6XMxfJbV9mcG2iY+/pmxp7Pl4ya8//4yXPln3QhwbmZUw3g7PnPu5DNwRs?=
 =?us-ascii?Q?nAE+FA13MqhrIlvvcYZmyW6f2++P366b8IH4SnqZwVc5C9qgYJa60fmPCwmi?=
 =?us-ascii?Q?6Rr2Dk5C5QTI48lU+JiVl1s76oV12/8f5N7AUZ17n/Z5Vhg1PCCXz5oCTVn1?=
 =?us-ascii?Q?lhreSnkgoQKFZHRNcUyx+3jNYOk63jH83zfVKygISXJSBwhGVTlq0wGsdkCi?=
 =?us-ascii?Q?VupTsJJXiN1UPtIOk3Mhdg6B7VMJ8HURA6uYhInogOsLUC+0R4Q9trvZ/nae?=
 =?us-ascii?Q?NwLLq3su9zGjpO7+W9BryOBn/WEVu8jus4tMKFmgZRg37oIYtOzdq2vS58R1?=
 =?us-ascii?Q?9qdS0sOHz4izo98a2OZ8SpsBTZdpE2NQWuqGPBrzdi/YT9GHQiFT67lAQm7B?=
 =?us-ascii?Q?3aJ6GkCfuk9IYYxfZQKTyphqfm8UhE5t1LoigmmzOYeba0RbzA2XuG78eOak?=
 =?us-ascii?Q?7J0p3HDEbXQEGQTtyQlUToOVfeYQlw+RZ85TB0xnMD6Twi8vrFc5AXooUPlH?=
 =?us-ascii?Q?bhxX3NY4KBX3TO8xEgSr0G1/9nCZQd8mQNf17qXfUPzRkkVdYYCnY9LjIbdA?=
 =?us-ascii?Q?0Xoup291TPSGruvA/YFG6R+02Wny7DpOd6hm128/Y8FnL5EbiNjOLii+7nGX?=
 =?us-ascii?Q?WFgJTidVdLmr8sLnrgrQjfyvl5ba0ElHYfUK+35ga7WCgPOxH3NZDBy03QC7?=
 =?us-ascii?Q?LxJQRNBAXqrQ0r00mcO9p/UMoZKlk9J3bpVTAMvITcOOdIVywxjkywl5Qprr?=
 =?us-ascii?Q?iT1My9YlzY3bCbOdrXd/Tk+fo9ObHDdeHcdZFxPuAVZj2fqOK7bo5iHkEOjv?=
 =?us-ascii?Q?EVGAdf0sepNv2oxOvCR5UARJ9T659qqyVcNYuB5m2IdA2F9MkhnVB0hd3mH5?=
 =?us-ascii?Q?AHd/l1OgG85KTfTOaYA9jc+IJmcnxQ9vitXfzhxAaBCGdqBTc3gWlRrhSprM?=
 =?us-ascii?Q?VsT5KNI4fr/W0z22uIqD7MbOBhSgSsfIfAlpxhVjwTAJO47WwXX8VRovnEtP?=
 =?us-ascii?Q?Zb+EhYXOCRcRFAefosfeZ14zZ+HoJQ1biUPWKc1CWq0pyccq3doyVIQ2Ls7u?=
 =?us-ascii?Q?DqSvkJu8jaTTo7vgDcZKCTbcnONmcfdlE27zQxMifmuueXRhucx4UBxgftgX?=
 =?us-ascii?Q?nbWXwW2jXEI9Sk4wBW4Zs6IpUnZV906vojbL+CL/An0GqLnDTvzcnfvWKrM4?=
 =?us-ascii?Q?6J+qY/vu110dTlKfZx08a5vDgSDWa1Guw14P8SAQldPwmTqLHtMdYTCIkICG?=
 =?us-ascii?Q?SNWysHdfqED9w93NoY3i9yTLMD70P29oE6b2BgsdaD73ucrWcHQTLN7mnxO1?=
 =?us-ascii?Q?XAZSPxVuvYRiNRbTy0I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4313.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf7cb68-ac8e-481e-d094-08dd708a5d1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2025 19:29:32.5815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O+8iclyZ2uk+B7w04MZiXPpM24/qrrnfGVYuZK7VSN7GfSctDNKcvTt6EOfWaVRGrDOnN8he1ILHGqGEwVUylg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8720

> >  I have a proposal to rework/redefine PDs to support a more general
> > model,
>=20
> It would certainly be good to have some text explaining some of the mappi=
ngs
> to different technologies.
>=20
> > which I think will work for NICs that
> > need a PD and ones that don't.  It can support MR -> PD -> Job, but I
> > considered the PD -> job relationship as 1 to many.
>=20
> Yes, and the 1:1 is degenerate.
>=20
> > Sure, It's challenging in that a UET endpoint (QP) may communicate
> > with multiple jobs, and a MR may be accessible by a single job, all
> > jobs, or only a few.
>=20
> I would suggest that the PD is a superset of all jobs and the objects (en=
dpoint,
> mr, etc) get to choose a subset of the PD's jobs during allocation?
>=20
> Or you keep job/pd as 1:1 and allow specifying multiple PDs during object
> allocation.
>=20
> But to be clear, this is largely verbs modeling stuff - however there is =
a certain
> practicality to trying to fit this multi-job ability into a PD because it=
 allow
> reusing alot of existing uAPI kernel code.
>=20
> Especially if people are going to take existing RDMA HW and tweak it to s=
ome
> level of UET (ie support only single job) and still require a HW level PD=
 under
> the covers.

Yes, I'm trying to ensure that the existing RDMA model continues to work bu=
t also support NICs/transports which implement the equivalent security mode=
l at the QP (endpoint) level, reusing the PD for both.

Specifically, I want to *allow* separating the different functions that a s=
ingle PD provides into separate PDs.  The functions being page mapping (reg=
istration), local (lkey) access, and remote (rkey) access.  The RDMA model =
limits a QP to a single PD for all.  To support job-based transports, I pro=
pose allowing a QP to use 1 PD for local access (PD specified at QP creatio=
n) and multiple PDs for remote access.  Each PD used for remote access woul=
d correspond to a different job.

Note: a NIC may limit a QP to being used with a single job and require the =
local and remote PD be the same (i.e. 1 pd per qp).  So, the RDMA model sti=
ll fits.

As an optimization, registration can be a separate function, so that the sa=
me page mapping can be re-used across different jobs as they start and end.=
  This requires some ability to import a MR from one PD into another.  This=
 is probably just an optimization and not required for a job model.

I was still envisioning a job manager allocating device specific resources =
for a job and sharing those with the local processes.  I.e. it shares a set=
 of fd's, with each fd associated with a device, which restricts the job to=
 those devices.  A job may also have device specific resource limits or all=
ocations (limit on number of MRs, specific endpoint addresses, etc.)  A glo=
bal job object could work, but a subsequent user to device flow will need t=
o access and translate the global object.  Either way, there's uABI require=
ment(s).

- Sean

