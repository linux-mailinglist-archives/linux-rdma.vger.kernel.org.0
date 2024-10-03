Return-Path: <linux-rdma+bounces-5196-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A28998F158
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2024 16:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97F241F21D32
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2024 14:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A6419E967;
	Thu,  3 Oct 2024 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h2O1oT/h"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A846C12EBDB
	for <linux-rdma@vger.kernel.org>; Thu,  3 Oct 2024 14:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727965570; cv=fail; b=Ns/hYfdAoNKDAyN3oINM/iympmfidXmKEZd0Znx8V//RSrfG8ibJu/DQ3K/93KihVheAM83jy1Cy+OZNCKrb5z+SoeW5iZLL01D6hdlg8T41kMfPUgjvbrQy1ohkVYGyAn3GuUdeMFdeCi54PQ739NTovp+u9QHNce8GRQn4+Uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727965570; c=relaxed/simple;
	bh=u1dNPoXVIxN0jcvwH46XsXqTHi1cCUCt2Fj/sS6QuxQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uJT5fBwWddMKNvuYFrX1lLTvZMtHWtO5VIioForInMhrswzbXStvCTjLhr8N7OGa5UykbSrYtATViTw1hwefurjvWTtHbPF576rc4mQ7Dtsr3EW/JncBSw7oX5YrFZN5CnPv8lEg39cq0qRNfP8hrtr1Jl3mwyiFXwcZwbFSqxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com; spf=pass smtp.mailfrom=zurich.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h2O1oT/h; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zurich.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 493EG7K1008763;
	Thu, 3 Oct 2024 14:25:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	u1dNPoXVIxN0jcvwH46XsXqTHi1cCUCt2Fj/sS6QuxQ=; b=h2O1oT/hSgfQgmYV
	Sf9WJPLVryWaZ01Iw8KJy/WA1KGtTPkDH/+FQQDoEby0+yVsmvWtfpU1JtQCVQvV
	0d/4q/OEsopUK7j1reMi+V+kUrJX4YinSn7alC+YXD+xk1K7oItgjPNKAZNu9QbL
	nQ5gBT7ZTK1BJQSH4/VQlV+5j57/vUGuVQeWvf58TTa5PF/ynVISeW6PqZn02US1
	ipsYExLTZVQKWJHlzB4G+y/aP9WSVgR1AxIDus39U5uw5LJxmnWFPs2H7cz7mAgS
	QQKqlqeutsQGdYdFYWWuUUDQ2yIcbwo2VXZ+G/1Q22sA7xoFUpxzumFaRiUB1yDL
	Jm/Bow==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 421vvd81he-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 14:25:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJ5tG6rQJsJnQYtKjGh+Cgx7IfcTwtjrS5OtBytRkhn6HgZ3lR90vXGXo6XmGEEb04L5J182lOVvzi51UUnOdpKq3kCktSRHyHvnk8HyMKYk6SWAkcbRmfxMtbWTMmayZ/XtwLJ6bBvxHBmiDOXczALHdCKstCF2iYPsHDJjTmN3vK/OZdcyiOckXOsF9v8dChW9i2nfS4GAgIWpJJ09y1RjUPEDNvXmgBNgUNlNcFc+GMM0u14AVnmhVbVSZFm4GYLfLUeuCJHKOf9CPY9GT9L4X8En8BwDUZPM8dITQgapcNH4sC7FrTHsx9Fg2aWYTcPezbfQlpVKgMr+CnaYrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZQ8vfbXKe6KKMi+TIoq+rrZ1d8lozy6K/pjqPmexIA=;
 b=TPYwcUs+xeKKNc/leJynf2E9zOKz9eyFayw1zqIcHUHR8xd3T4qIudndWN09VkMvds56m3S/SW+hCxFUrspn2cyIPZUAqWSU2Imz7zn+gaU7X6zwhPBiesyLr08VX9nbRQZD7IuSEBjshntDTQDRghrRCM5IBMVU8o7B4UMXJY1GTvsI4pCnn5KN2mXIpynfNoIZJC8nxIPjyscYmrmf0pczBO/D7A4gGsa4XBObCMyvWCCr6P+adkDCfcBGGthHNKbJld5XbZzjDaCjvRsK4gVKd43eEV5i73DxNuUCHUF7q5QGn1twFVN8F09xS1kFqNch4VuwQr06TIB12SnXzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BN8PR15MB2513.namprd15.prod.outlook.com (2603:10b6:408:cc::30)
 by SA1PR15MB4643.namprd15.prod.outlook.com (2603:10b6:806:19e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Thu, 3 Oct
 2024 14:25:56 +0000
Received: from BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::dd5e:86f1:8719:2f16]) by BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::dd5e:86f1:8719:2f16%3]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 14:25:56 +0000
From: Bernard Metzler <BMT@zurich.ibm.com>
To: Showrya M N <showrya@chelsio.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
        "leonro@nvidia.com" <leonro@nvidia.com>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Potnuri Bharat
 Teja <bharat@chelsio.com>
Subject: RE: [PATCH for-rc] RDMA/siw: add sendpage_ok() check to disable
 MSG_SPLICE_PAGES
Thread-Topic: [PATCH for-rc] RDMA/siw: add sendpage_ok() check to disable
 MSG_SPLICE_PAGES
Thread-Index: AQHbFaApEZYiRTTJPkWlAvM24xVoqA==
Date: Thu, 3 Oct 2024 14:25:56 +0000
Message-ID:
 <BN8PR15MB2513C8CC78CBEADA83117A5599712@BN8PR15MB2513.namprd15.prod.outlook.com>
References: <20241003124611.35060-1-showrya@chelsio.com>
In-Reply-To: <20241003124611.35060-1-showrya@chelsio.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR15MB2513:EE_|SA1PR15MB4643:EE_
x-ms-office365-filtering-correlation-id: 1b98d734-a9d8-4d4d-749f-08dce3b74bb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZHFOSS93RnNmcDkvcnlabUpHNkFwVXd6bDl1RnNvYkVDc0RVYmlZdzBZVlhi?=
 =?utf-8?B?UVBLenJNVkhQVTJxVUhuTzhHM2F0UUFwTDIyOU1RaTc0WG5HYjBHamVjN3lM?=
 =?utf-8?B?L3EyVHhtdFc0bC9MYVhFL0RGQ0pUaU1hTU5LN0FzKzhkbmQ4S1BnaG9UMGF3?=
 =?utf-8?B?SGxLR1lCaEgxWjR1UDNPUjVjcWo3c2wxZ1R3NGhjWk5FSHZxQllDclRYVzdR?=
 =?utf-8?B?UFhFRGNyY3ZBOXdBY0xJRzhjS1A5akVXTnBTSlpoSWxNWWZlL21sekhIZjhk?=
 =?utf-8?B?aG1vbmQ3bytqWE1OSjN5VjE3Qklmd3FPZzBtNnU2eTMzR3FPVXVvejBvOFpW?=
 =?utf-8?B?bHhKOGFGZW91UXViYWFHT0ttZG5jM29KV3NKUmQ5cExlZmlLTkNpaFlSODkz?=
 =?utf-8?B?SVdPK2FWMEdPaS95ZXJYSVdDdEkwRG91YlVxME0ydkFLV0cvMm1kaTRwOVhr?=
 =?utf-8?B?ZjBYVFc1QkRIaitld2RuTklrRjBNQ0JRZytUd2tDaUZlajVtUE93TTRYWUt5?=
 =?utf-8?B?VFR5UHpVNWZBSHQzYTdoRHNpanlwNkN0UmprUy84WjF0ZW16Z0FWRU9HTkRT?=
 =?utf-8?B?aWkwWHZXdVVTaDU2Um8rOVNkNTN4bkYydkxubFhaWjB1RG9KYnVUdEF5N0Uy?=
 =?utf-8?B?VmJXYWh3djJyVHlkMUdaYmp5S0lhZXE3UUxBazR1SGVQa2pRTnhBb0E4M3Fk?=
 =?utf-8?B?cGVLOVVGRUxLdGVOYTFjQVhnYnBCYmtDakF2bTdqdTc0aDFQWStLRU8yVmRG?=
 =?utf-8?B?QTA3NFBoNUZvUjYyeDByUWZ3dFl2STVGcGQ0QktuYmNFOHhuYU5IMUZGSnA0?=
 =?utf-8?B?cjYyZmMvRGMrSmRBNEhNbC8zdmlCM2lIaU5jeHRtY2ZzeERHT0pVT3d6NEY2?=
 =?utf-8?B?TnFCVHVmclJSSmloNmRnbG5VU0ZZcjdXdnRIWm1GTjU5ZEpBeW5tUEN5aVRP?=
 =?utf-8?B?ZGF3K1B5S3lYNHFPbVJja3BOalZaeXhvcmtSLzl2QlU1NHljS3ZTK0JnSStE?=
 =?utf-8?B?S2w5a0tpaGErVXRLeDBpakl5RG44bUpMZDAzaE8xaGh5bHlXcFcxUEpwM2dM?=
 =?utf-8?B?NVpGTVBCV3VVajJISUlhcHZTR3RQUW9TOTUvR0hlbkJuRVQzY3dOeWpZdEdq?=
 =?utf-8?B?ekhCVGFzWUkzNmlIbFVmKzFIWTNzZGluZ29YTXpXa1BVa0R3MktTSDRERWtj?=
 =?utf-8?B?Qk5VUUo1ZWRObG8vZytSd0hSV0gxYWZ6Q2ZPSWNNZU02dFJDV2dEelNFNUs1?=
 =?utf-8?B?VXhBcWFHRjFqWS90SEd5SUhmaWhPdzJGOTVENEYwdHFOQ3R6R1l2M0NLZCtP?=
 =?utf-8?B?b1RkZFFpN3VwMUhqdFFRYzl3UFhqWmh6NEU1V1M4Y1hwS1Vxcm1rMTR6QTVN?=
 =?utf-8?B?VHFjV1hIYTNDNThtUW0xMndDdG01U0pVbDlGQjNvaVRLbW5uZ3JXL3ZVRnBV?=
 =?utf-8?B?SmF0NzNJdjFxOGJielBDUllyb3ErS3lWUlVQM1dHVVZLL3lvZ2xlM05BUGU0?=
 =?utf-8?B?M1JUUEtaM0syM2hmbDhFc0hudFpSaXRwN1FzRTZJUlRIQkJZeFhuQXc4RDdC?=
 =?utf-8?B?ME9leDZwanFpMkdxT2I0ZU0vOEIzMGhIMjVNNVpmdElPQkgyb2Z4ZjQwb1NG?=
 =?utf-8?B?N1Q0STRWcGxGVGFYeHNkcjRYRlBvL1BURWRkVnMyNVprM2pyaXZZcFdKWkR2?=
 =?utf-8?B?SC9kZ3haeUJXaktpRWhYVmhYVVF3RDd5Y2d1VWhzdXBwZmxRSlNJZ3JaTlNl?=
 =?utf-8?Q?h/PZUpxF1llc/zJBb8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB2513.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UkV5R3Nkd2NldHBQVlBweXJ6TWJXSmxvNnJPckdoM2tJbFZqOFRDN0VteEts?=
 =?utf-8?B?U0t3N3pLcy9Kc1c5WTZ3VGNSVFBSbndvajN1RGRWbVBsd2FXalRVaHVHN3U0?=
 =?utf-8?B?ZzlYMmk5cWdkSWxwN29JbFhWTTA3QzVMT1MvNDJmV1p3NlhmWGdBQlBEQ2hs?=
 =?utf-8?B?RC9mNHU0cFNrbmp6alc1Ui9YLzZQQXpsalVPbnBoRWgrbDZDK0VicU1WRkdQ?=
 =?utf-8?B?NWFrVmVVYmtBK0RNa0JmajNLK2lkOFRNR09PZzd4Q1ZkSWcvaE1pbEFOdnU1?=
 =?utf-8?B?Rm9JNVNZZ0ZoYVpHcHhwTVEySE5pNlFoKzdWNzVNUm1pOEJvbVR4MS81OFFY?=
 =?utf-8?B?NEo4SmUzVzl0dXhOakE0N1Zyb3VqYTZDVU5xdXdOYUh1TmdsNEdaUWpHbXR6?=
 =?utf-8?B?WjNwdkNJYjI4M05RaHNuQXlOUlVjSUdETm5pY28zaHdjcHdZdVVBdmhTL0g3?=
 =?utf-8?B?eHdtNGRnT2VrUnNiWUhyZjR2d29JVDRiMVREajhZc2JWNUdnaTRjekZsQVdB?=
 =?utf-8?B?bmt3Wmh6ZmlHcDd5UzBQSnkrVW93cHBtV045NDN6Y25EVXJIVzVkYmh0OU0w?=
 =?utf-8?B?cmhMN2ZxclFubGJ1eHQwL0hsc2tweUdteHNDb0YvM3NaZ0xQSVZjYkRCY1R1?=
 =?utf-8?B?Z0xsNjA2eUdmN0xBM3FrV0RRZG5xTWVtTFlQVVVOQkNmZ0lqRC9tc2k3ZlZF?=
 =?utf-8?B?eVNTT0YxN3NTNmN0UzZaTEliR3laSmZPdlljYTByWUZSRkZKV3N6Z0RJQW15?=
 =?utf-8?B?eWp5d2Zqd3phdDJoVDRzYnpnbkhneGtyVGkzME50Zk1pYWpEMXV0VTNOSEda?=
 =?utf-8?B?aWRiSy9XSmZCdUJ1UlVNc0hqdmFOUXk1QWI1d3Y1UHNDUkdGNlo0ZS8wTHE3?=
 =?utf-8?B?d2t2d3BLUVMvREE4TDBzbUFMdzhTSzVUbU1NL3Q1eUU2ODlqa2RwR0Q1MU1M?=
 =?utf-8?B?RExjZWVaOHFxdHk5VDFKVGdjemZtS2tRSXovajNidWNDVmtnZENNbmlZZWpJ?=
 =?utf-8?B?WjQ0akNHcmV4MlBnQk1BSDBCM2dKWDNFeVdFbytRRUZGcXgzbUhzV2xiQUVX?=
 =?utf-8?B?RiswUE1xdVBsVEszSmJDbjdBaXVUL1dsaU1sMzN6eU9CRW02MjlkZ3A0Z1RK?=
 =?utf-8?B?c0tEeFpEMG4xbDQ1Sng3Mm55TEtRdUt6SU4rNTRlSFEzbVF0Q3lPcE5iZzFJ?=
 =?utf-8?B?amhBalpHdEV1RTRCTnZoRnJaSTZvWFpPUkNWMnV0T3MwbDcvdG5jRDc4bWJ3?=
 =?utf-8?B?QWhFbXRSNldRcEZCWVZTZVRpci8yaVpQWDJnQ0pqRHJPb1R0a2pjSmlobHpB?=
 =?utf-8?B?ZXovUHJXQTBxVXJRRGZLd3YrZnlybkU0RkZKZmFNSmgrWU5xeGlzaUdldU5i?=
 =?utf-8?B?SEhDVHVaSitTY01YbWQ0cndrRElnVllnSmJsV0FuTDdMZnpBTS9uZk04STNX?=
 =?utf-8?B?dUR5NXlKSWw4SEF6cWhwdGVyeFdOdm1LbFJMbmFVSGtLQzBRMk9PZUQ4dHkz?=
 =?utf-8?B?THRvVERUMGl3K1l4REhuaEp1T3dEYWZmb2t0L1g2RDl3ZWF2U3pibkpNa3ZR?=
 =?utf-8?B?UXV2WXRQdVVVZ2xFNUhtenlOdDZXNmp2Q2w5L3B2MUZjT2hGVDRNeEhLODNK?=
 =?utf-8?B?aU9lZDROOTNQTUtVWEdBREdqbDQraG52cW5PVncwK2l5SDd1bld0bUdFcm5s?=
 =?utf-8?B?eHRZcDB0OWU4QW9oY25OUXN2c3V1YVRkMFJIa1RtS1JCeTNGZjFwSW9GbFpE?=
 =?utf-8?B?YkliZWEvVEdJeVJGa0FyTC9aa3pvWEY4TVZ0VjIvTlhvQ1VraklRdVlyV1JH?=
 =?utf-8?B?UnlQdHlsMU1uM2FnOUV0bzRkWEtacTBBUWs4d1dUcUlveVdiRmEvMjZ3ZDc5?=
 =?utf-8?B?OFRRTFNRUVMrQkdVbmFSQnBQU0o2MnBua3RBVVZLVnBPbTFxUGZaMXJNTjVV?=
 =?utf-8?B?SmVnbzNmazhzZDdVa3FWQnVlME9VeE5zL3ZVczdMZWhzUjdZemVBK1pieUZX?=
 =?utf-8?B?Z0hwaDZOOGFocStKYXl3aEZBZ1ZleGh3dThNYVVmUmM5REVLeWdCYk5uMEw0?=
 =?utf-8?B?VS9CT1p5dTNnRWRNS1FMS2xvck8xOGZxalhRaE5OVm1QRStCbnRZdExIeGJ3?=
 =?utf-8?B?RTBIRzhWbVZ2U0lCRi9JYWVMRjBNaEJOQUJtYzNSVFhwMU52WmtnRzY5OExP?=
 =?utf-8?Q?MvlwM9er2jNkhjlUAk2/WK8=3D?=
Content-Type: text/plain; charset="utf-8"
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB2513.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b98d734-a9d8-4d4d-749f-08dce3b74bb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 14:25:56.8024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: glXV8IIvQ6IlJR/VZlmlVL91lF/eKQiDKKlsGGTBIYB/DJ8YVW3rDkLOMBEIrLDuJUTyBFAliEyMmD8eAGizFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4643
X-Proofpoint-ORIG-GUID: OXMXxPFzFL9O0yWXwM0rwvBskmgtWlQU
X-Proofpoint-GUID: OXMXxPFzFL9O0yWXwM0rwvBskmgtWlQU
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_06,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0
 clxscore=1011 impostorscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2410030103

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hvd3J5YSBNIE4gPHNo
b3dyeWFAY2hlbHNpby5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDMsIDIwMjQgMjo0
NiBQTQ0KPiBUbzogamdnQG52aWRpYS5jb207IGxlb25yb0BudmlkaWEuY29tOyBCZXJuYXJkIE1l
dHpsZXIgPEJNVEB6dXJpY2guaWJtLmNvbT4NCj4gQ2M6IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwu
b3JnOyBTaG93cnlhIE0gTiA8c2hvd3J5YUBjaGVsc2lvLmNvbT47IFBvdG51cmkNCj4gQmhhcmF0
IFRlamEgPGJoYXJhdEBjaGVsc2lvLmNvbT4NCj4gU3ViamVjdDogW0VYVEVSTkFMXSBbUEFUQ0gg
Zm9yLXJjXSBSRE1BL3NpdzogYWRkIHNlbmRwYWdlX29rKCkgY2hlY2sgdG8NCj4gZGlzYWJsZSBN
U0dfU1BMSUNFX1BBR0VTDQo+IA0KPiBXaGlsZSBydW5uaW5nIElTRVIgb3ZlciBTSVcsIHRoZSBp
bml0aWF0b3IgbWFjaGluZSBlbmNvdW50ZXJzIGEgd2FybmluZw0KPiBmcm9tIHNrYl9zcGxpY2Vf
ZnJvbV9pdGVyKCkgaW5kaWNhdGluZyB0aGF0IGEgc2xhYiBwYWdlIGlzIGJlaW5nIHVzZWQNCj4g
aW4gc2VuZF9wYWdlLiBUbyBhZGRyZXNzIHRoaXMsIGl0IGlzIGJldHRlciB0byBhZGQgYSBzZW5k
cGFnZV9vaygpIGNoZWNrDQo+IHdpdGhpbiB0aGUgZHJpdmVyIGl0c2VsZiwgYW5kIGlmIGl0IHJl
dHVybnMgMCwgdGhlbiBNU0dfU1BMSUNFX1BBR0VTIGZsYWcNCj4gc2hvdWxkIGJlIGRpc2FibGVk
IGJlZm9yZSBlbnRlcmluZyB0aGUgbmV0d29yayBzdGFjay4NCj4gDQo+IEEgc2ltaWxhciBpc3N1
ZSBoYXMgYmVlbiBkaXNjdXNzZWQgZm9yIE5WTWUgaW4gdGhpcyB0aHJlYWQ6DQo+IElOVkFMSUQg
VVJJIFJFTU9WRUQNCj4gM0FfX2xvcmUua2VybmVsLm9yZ19hbGxfMjAyNDA1MzAxNDI0MTcuMTQ2
Njk2LTJEMS0yRG9maXIuZ2FsLQ0KPiA0MHZvbHVtZXouY29tXyZkPUR3SURBZyZjPUJTRGljcUJR
QkRqREk5UmtWeVRjSFEmcj00eW5iNFNqXzRNVWNaWGJodm92RTR0WVMNCj4gYnF4eU93ZFNpTGVk
UDR5TzU1ZyZtPTV6TGtiekZYQ052d2lZd3p5aFNMQzlyNUdRbkl0NFZLYXdkQklpbkpkVkVmaXJF
MUJGcXdTDQo+IDlRR2JoVldPT0tvJnM9d3hNMnNSdXpEb3EzNlcyM19qQTVwTmdlR0RFUGZUbXlQ
aHN2UHFwMF8tRSZlPQ0KPiANCj4gc3RhY2sgdHJhY2U6DQo+IC4uLg0KPiBbIDIxNTcuNTMyOTE3
XSBXQVJOSU5HOiBDUFU6IDAgUElEOiA1MzQyIGF0IG5ldC9jb3JlL3NrYnVmZi5jOjcxNDANCj4g
c2tiX3NwbGljZV9mcm9tX2l0ZXIrMHgxNzMvMHgzMjANCj4gQ2FsbCBUcmFjZToNCj4gWyAyMTU3
LjUzMzA2NF0gQ2FsbCBUcmFjZToNCj4gWyAyMTU3LjUzMzA2OV0gID8gX193YXJuKzB4ODQvMHgx
MzANCj4gWyAyMTU3LjUzMzA3M10gID8gc2tiX3NwbGljZV9mcm9tX2l0ZXIrMHgxNzMvMHgzMjAN
Cj4gWyAyMTU3LjUzMzA3NV0gID8gcmVwb3J0X2J1ZysweGZjLzB4MWUwDQo+IFsgMjE1Ny41MzMw
ODFdICA/IGhhbmRsZV9idWcrMHgzZi8weDcwDQo+IFsgMjE1Ny41MzMwODVdICA/IGV4Y19pbnZh
bGlkX29wKzB4MTcvMHg3MA0KPiBbIDIxNTcuNTMzMDg4XSAgPyBhc21fZXhjX2ludmFsaWRfb3Ar
MHgxYS8weDIwDQo+IFsgMjE1Ny41MzMwOTZdICA/IHNrYl9zcGxpY2VfZnJvbV9pdGVyKzB4MTcz
LzB4MzIwDQo+IFsgMjE1Ny41MzMxMDFdICB0Y3Bfc2VuZG1zZ19sb2NrZWQrMHgzNjgvMHhlNDAN
Cj4gWyAyMTU3LjUzMzExMV0gIHNpd190eF9oZHQrMHg2OTUvMHhhNDAgW3Npd10NCj4gWyAyMTU3
LjUzMzEzNF0gID8gc2NoZWRfYmFsYW5jZV9maW5kX3NyY19ncm91cCsweDQ0LzB4NGYwDQo+IFsg
MjE1Ny41MzMxNDNdICA/IF9fdXBkYXRlX2xvYWRfYXZnX2Nmc19ycSsweDI3Mi8weDMwMA0KPiBb
IDIxNTcuNTMzMTUyXSAgPyBwbGFjZV9lbnRpdHkrMHgxOS8weGYwDQo+IFsgMjE1Ny41MzMxNTdd
ICA/IGVucXVldWVfZW50aXR5KzB4ZGIvMHgzZDANCj4gWyAyMTU3LjUzMzE2Ml0gID8gcGlja19l
ZXZkZisweGUyLzB4MTIwDQo+IFsgMjE1Ny41MzMxNjldICA/IGNoZWNrX3ByZWVtcHRfd2FrZXVw
X2ZhaXIrMHgxNjEvMHgxZjANCj4gWyAyMTU3LjUzMzE3NF0gID8gd2FrZXVwX3ByZWVtcHQrMHg2
MS8weDcwDQo+IFsgMjE1Ny41MzMxNzddICA/IHR0d3VfZG9fYWN0aXZhdGUrMHg1ZC8weDFlMA0K
PiBbIDIxNTcuNTMzMTgzXSAgPyB0cnlfdG9fd2FrZV91cCsweDc4LzB4NjEwDQo+IFsgMjE1Ny41
MzMxODhdICA/IHhhc19sb2FkKzB4ZC8weGIwDQo+IFsgMjE1Ny41MzMxOTNdICA/IHhhX2xvYWQr
MHg4MC8weGIwDQo+IFsgMjE1Ny41MzMyMDBdICBzaXdfcXBfc3FfcHJvY2VzcysweDEwMi8weGIw
MCBbc2l3XQ0KPiBbIDIxNTcuNTMzMjEzXSAgPyBfX3BmeF9zaXdfcnVuX3NxKzB4MTAvMHgxMCBb
c2l3XQ0KPiBbIDIxNTcuNTMzMjI0XSAgc2l3X3NxX3Jlc3VtZSsweDM5LzB4MTEwIFtzaXddDQo+
IFsgMjE1Ny41MzMyMzZdICBzaXdfcnVuX3NxKzB4NzQvMHgxNjAgW3Npd10NCj4gWyAyMTU3LjUz
MzI0Nl0gID8gX19wZnhfYXV0b3JlbW92ZV93YWtlX2Z1bmN0aW9uKzB4MTAvMHgxMA0KPiBbIDIx
NTcuNTMzMjUyXSAga3RocmVhZCsweGQyLzB4MTAwDQo+IFsgMjE1Ny41MzMyNTddICA/IF9fcGZ4
X2t0aHJlYWQrMHgxMC8weDEwDQo+IFsgMjE1Ny41MzMyNjFdICByZXRfZnJvbV9mb3JrKzB4MzQv
MHg0MA0KPiBbIDIxNTcuNTMzMjY2XSAgPyBfX3BmeF9rdGhyZWFkKzB4MTAvMHgxMA0KPiBbIDIx
NTcuNTMzMjY5XSAgcmV0X2Zyb21fZm9ya19hc20rMHgxYS8weDMwDQo+IC4NCj4gWyAyMTU3LjUz
MzMwMV0gaXNlcjogaXNlcl9xcF9ldmVudF9jYWxsYmFjazogcXAgZXZlbnQgUVAgcmVxdWVzdCBl
cnJvciAoMikNCj4gWyAyMTU3LjUzMzMwN10gaXNlcjogaXNlcl9xcF9ldmVudF9jYWxsYmFjazog
cXAgZXZlbnQgc2VuZCBxdWV1ZSBkcmFpbmVkDQo+ICg1KQ0KPiBbIDIxNTcuNTMzMzQ4XSAgY29u
bmVjdGlvbjI2OjA6IGRldGVjdGVkIGNvbm4gZXJyb3IgKDEwMTEpDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBTaG93cnlhIE0gTiA8c2hvd3J5YUBjaGVsc2lvLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTog
UG90bnVyaSBCaGFyYXQgVGVqYSA8YmhhcmF0QGNoZWxzaW8uY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvaW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwX3R4LmMgfCAzICsrKw0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFu
ZC9zdy9zaXcvc2l3X3FwX3R4LmMNCj4gYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19x
cF90eC5jDQo+IGluZGV4IDY0YWQ5ZTA4OTViZC4uZDc3N2QwNjAzN2RiIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19xcF90eC5jDQo+ICsrKyBiL2RyaXZlcnMv
aW5maW5pYmFuZC9zdy9zaXcvc2l3X3FwX3R4LmMNCj4gQEAgLTMzNCw2ICszMzQsOSBAQCBzdGF0
aWMgaW50IHNpd190Y3Bfc2VuZHBhZ2VzKHN0cnVjdCBzb2NrZXQgKnMsIHN0cnVjdA0KPiBwYWdl
ICoqcGFnZSwgaW50IG9mZnNldCwNCj4gIAkJYnZlY19zZXRfcGFnZSgmYnZlYywgcGFnZVtpXSwg
Ynl0ZXMsIG9mZnNldCk7DQo+ICAJCWlvdl9pdGVyX2J2ZWMoJm1zZy5tc2dfaXRlciwgSVRFUl9T
T1VSQ0UsICZidmVjLCAxLCBzaXplKTsNCj4gDQo+ICsJCWlmICghc2VuZHBhZ2Vfb2socGFnZVtp
XSkpDQo+ICsJCQltc2cubXNnX2ZsYWdzICY9IH5NU0dfU1BMSUNFX1BBR0VTOw0KPiArDQoNClRo
YW5rcyEgVGhpcyBsb29rcyBnb29kIHRvIG1lLiBBbHRob3VnaCwgSSB3b3VsZCBzdWdnZXN0IG1v
dmluZw0KdGhpcyBmdXJ0aGVyIHVwIGp1c3QgYmVmb3JlIGJ2ZWNfc2V0X3BhZ2UoKTogV2hpbGUg
aXQNCmlzIG5vdCBkb25nIGFueXRoaW5nIHRvIHRoZSBwYWdlLCBpdCBsb29rcyBtb3JlIGNsZWFu
DQp0byBmaXJzdCBhbHRlciB0aGUgcGFnZXMgZmxhZ3MgYmVmb3JlIGxpbmtpbmcgdGhlIGJ2ZWMg
d2l0aCBpdC4NCg0KVGhhbmtzISBCZXJuYXJkDQoNCj4gIHRyeV9wYWdlX2FnYWluOg0KPiAgCQls
b2NrX3NvY2soc2spOw0KPiAgCQlydiA9IHRjcF9zZW5kbXNnX2xvY2tlZChzaywgJm1zZywgc2l6
ZSk7DQo+IC0tDQo+IDIuMzkuMQ0KDQo=

