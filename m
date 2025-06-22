Return-Path: <linux-rdma+bounces-11516-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD908AE3015
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Jun 2025 15:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F6E03B2CFD
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Jun 2025 13:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418201B423B;
	Sun, 22 Jun 2025 13:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jOj6/kEI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A507618BC3D;
	Sun, 22 Jun 2025 13:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750598993; cv=fail; b=orfcokc9/I/XD4sTBg/FgpeSQTAqXMbeD5+H3NcOwKDeOBvnbY51fxsnIR7ulGyz1eO4cU4Ap5yHTf0IdwvSc/WGF4PiBpAZRHAefeGXm4qfYjkw992HsTnFgGyMTKyN6tG3CyxLXOTRrIZFoBrw1GSmQURMbBasFj/l9T6TAUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750598993; c=relaxed/simple;
	bh=iA/BEd5V8Vbk+tOicI+LXVq1pQln7h9o9wMMWUD+J+w=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=Xdfd6BEGJmsapX7p6iUNMSj3Jw9ok7VL0l6rdcn4HrE/cnIyZoqezCq3AV4M6yzTYJDbYMeBuHauzUMWhhL87Wps+qPENUxfUr18Tzj1AKA626mZn/digwriqp3qAlknDc5Rszt3jfiOnbGAJ8MXFI+mv5XE5efzq5t1TRfWj6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com; spf=pass smtp.mailfrom=zurich.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jOj6/kEI; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zurich.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55M2RrOk028803;
	Sun, 22 Jun 2025 13:29:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iA/BEd
	5V8Vbk+tOicI+LXVq1pQln7h9o9wMMWUD+J+w=; b=jOj6/kEINyTrpIilssp7fC
	DmfwkothRzy3fSauKrVhynD1wssyJkxlqjUm+dQf971N5rrL4aXD4Mhdu80pRtZM
	kFjK+lNIXZJpfWT3gzabsNVdGjPsASIxmw6T5b+FkXkukTRu2vDHH60hXY9I78DW
	w4oDSyj7r3mCqksLo/Vejov26234UWIKGU7+0l0EnOM9Epx5qi8D7qbYiuagUkd7
	eUJdJJiLsF8NQr2MCyuNYTRLZxYoauANUo5Rxcx0cN0J1FYv2JUZj5/22NLkSn1r
	A4pSvAEzD9wpxBv2lLgP2zjoH/u6INr+K9a1FG9ATRctDvjiySLc0lbJ9yLGkE4g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dj5td464-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Jun 2025 13:29:21 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55MDTLjf019990;
	Sun, 22 Jun 2025 13:29:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dj5td462-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Jun 2025 13:29:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s15ECHM+vn1DMuAvN+qr4mYqZ6SYhZFiPbPh6HZo0Ds7c4rUd8gnc5TY9Q2jaMMRIpPD8pbDfjugkh9AqOgB1izQ+l5J7qGen0tklwMemF+GGd69JTfH/QuZKrqKrbDlpA0QlfhdxMnsm5MYKaxlSfe5u0CrYu8Uozk1eD3H8GcCvGx/J3fXYH4hMfieqiB27usOWP4B4UymGizR+h1tKeHI6YVGqulQJ7T+GZaGiTFOPpHJwgmNzXGN5xZG6E7x3zbuDdu52+rN0/sFKMO27zVZJu2a/lUIHtqX2GyT2Bg9BExLDq2ycGm9iUHtj2Eb4cCEC8PTCM1ehWi108nw0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iA/BEd5V8Vbk+tOicI+LXVq1pQln7h9o9wMMWUD+J+w=;
 b=Cc/Wz0YzNiR0YwGAjZE0bjfxjT7aK6gzRzndL8Ru2gTzbmA7VO2x1kb2XR8FccRI51B1UiPpkRKFKFq4C6RCUPhGGnmOewqQY4W4+tMG7a53YaflOoodv3Vk4yxtj8qvx2qcsKKOEZR0rLqc4MgDvIHPxahd414Mgpgc14oU20kos6ObjCFXGTgE7oRKU7YLOlLf/Pw8USuAnGCyUeipprWrgIX4lAvRVO9UVLWwb5Sa3FgLNsANIQXfiRtiqVwqYkT0lqsmml/MLcdMX0Jo/JrfeA71Yn7tr6pXPH88LAdLRR+nxy4NRd87vLnsnJt7H5NN24yN0jolvr0MP/FECw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BN8PR15MB2513.namprd15.prod.outlook.com (2603:10b6:408:cc::30)
 by PH7PR15MB6461.namprd15.prod.outlook.com (2603:10b6:510:301::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Sun, 22 Jun
 2025 13:29:18 +0000
Received: from BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::4349:d5ca:1d09:1e40]) by BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::4349:d5ca:1d09:1e40%6]) with mapi id 15.20.8857.025; Sun, 22 Jun 2025
 13:29:17 +0000
From: Bernard Metzler <BMT@zurich.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>, Zhu Yanjun <yanjun.zhu@linux.dev>,
        Arnd
 Bergmann <arnd@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky
	<leon@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
CC: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling
	<morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Potnuri Bharat
 Teja <bharat@chelsio.com>,
        Showrya M N <showrya@chelsio.com>, Eric Biggers
	<ebiggers@google.com>,
        "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Thread-Topic: [EXTERNAL] Re: [PATCH] RDMA/siw: work around clang stack size
 warning
Thread-Index: AQHb4mLNIIgg25HEV0OZDibUP4fcvrQNTDqAgAHhGiA=
Date: Sun, 22 Jun 2025 13:29:17 +0000
Message-ID:
 <BN8PR15MB25132E1DD3438A333004FF39997EA@BN8PR15MB2513.namprd15.prod.outlook.com>
References: <20250620114332.4072051-1-arnd@kernel.org>
 <2d04fee6-5d95-4c50-b2b1-ee67f42932e2@linux.dev>
 <ca2eaa50-c3ed-491d-ab38-65a7c1dc2820@app.fastmail.com>
In-Reply-To: <ca2eaa50-c3ed-491d-ab38-65a7c1dc2820@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR15MB2513:EE_|PH7PR15MB6461:EE_
x-ms-office365-filtering-correlation-id: e567f517-82fd-4e7a-4b52-08ddb190c9ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YVJqL1NUb1lIL0lzRGg5OGxLeitxS3dybWwvb3MxUFNGMVB4SEhrYWgzZVVX?=
 =?utf-8?B?V2Z6Yk1yN0QzSFlzOFdVYkVQWkZRWnRCSWlOT25HVjk2bFV3OURTZXBmbUtl?=
 =?utf-8?B?aVo5NS9pSG5XMmJGZnNtRFZzVW5KOWV3NjNSZWV4aklhZG9QUWhMME9hdys2?=
 =?utf-8?B?UlA3WWV3cG0xOUNhY0pBaVRkN2Q3MkRDVit3TjEwaFNzS09EMk8vdyt6RE44?=
 =?utf-8?B?U2pwRXJXTmRhanBTOVRxck16MGUvL1IrT25tMTh0TmwycmlmdGdVWnh3VFM3?=
 =?utf-8?B?QW4rMUJEemxvSjN3M1VrbW5GWTQvYUVnV25yRnNDOUwra0dEY0NuaCtnV0lm?=
 =?utf-8?B?OHpMckptT25UWExaMGNRT2MvUjlhVEhCeFJnMUtvUng5WWlQTElaUEh3TzY1?=
 =?utf-8?B?MzF4OUhtRHlCZ0ZpOE5CM3Z4SE16Zk03K3RGUjNQVU83RllVdm1CWHhuYXBz?=
 =?utf-8?B?cHJGYVVEZjBPVkhtV0todDl6NGRyM0N3Y2NlTlFJc3d5L2dXSE1oSEdvMEZ6?=
 =?utf-8?B?S3lBalBKclA5c3J6MHZqM3paV3p4aFB3dmNWbzNYOC8yck9YUjZCbHRKMEJV?=
 =?utf-8?B?Y1VzbXVQclRwM1k3UExRVXF1ak9PL1hNSGdIbTFNd1ZNMkh3NmZVa2xVeENF?=
 =?utf-8?B?NEw1OCs1L1kycmlLbHBHdzdpZmdRTThod0lxVUpReU9MTHhPWGt2QlBnUmc4?=
 =?utf-8?B?bytaZEN1Wmk2THJ2YXFSc1V4RW5LbGswWFgzdG95OGw2SW5Tb3Ivd0RyYkRl?=
 =?utf-8?B?d0RBM05kVGpxcTh0Ryt2SU05cU5ZemlEaW12VmI0L3F1YzJUQnFScVQ4RVZG?=
 =?utf-8?B?REVUeFlneFlDbTRaOGswQ0p0NENsbDc2dUFObE51QVBQK0Rrc0hKVlRlczNS?=
 =?utf-8?B?a1Q5VGl6T1RHUUhmT0xhQm44Rk1VQlRqN0wySVJpbmU4WG1kU3dmYVJJU2Qy?=
 =?utf-8?B?aC9KdFF4Q25BM2kzd2EreE80YXlTV0dsQ3l6WXhxMUdmY1NRdFQzOGRHTjI0?=
 =?utf-8?B?Nnk4VXYrdkt4SnF6NHRSWjZUVGN0ampzUDdKTldCNlRGUzhXaTlyZXR4M3Np?=
 =?utf-8?B?dWliN0dkMDFFeDhRazg0cFY1ZVlCYVAyZnVnWUVUdGQvU3c2WHk0dGhqZnRa?=
 =?utf-8?B?TmdKVkJNZlpId1FvUGFOaG9BV3FFNGVGenBwcmtxVUJuTEVORC9WZGowalpv?=
 =?utf-8?B?UVJ6eGh1QjRkb0s2T3VPMWFTbk82UGhSYUJpNUVTSDlCbkFjeEp4elFhMzY4?=
 =?utf-8?B?NkluM0RsMlVYcmJmNkp5aGZyUmlZSXlhTkkwTSt1ZytCRUVXTERSTkR6VnF6?=
 =?utf-8?B?a2RxUTE1K0hqckZQZGtmRHc4eDRMY3VVdkIrVmhwQWVLeVlCbzdMM1ZjSHl4?=
 =?utf-8?B?Tm5WZHRreGt6RHU3aVhJMGVBcmZhTXd4Tjh0UENFT0dXZ295MmEyY1FJd0ow?=
 =?utf-8?B?eHc4V0o4c1hVSFcwcm4xRkJLcTYwSHpPTUNvZkgyZGNrLzlhRDNBdmw1azVa?=
 =?utf-8?B?TzNJRE1wRWR5cWVtYmFhcjE5R0xEcUx6S0tHbThHL2xVZUd6RjdCeTc3UERG?=
 =?utf-8?B?VDJScUNZZS9MU2dwZkJrb3R1RGpJV3VYKytOWURiZVBZaXNKbVN3YlRSVlUz?=
 =?utf-8?B?eWRCdFFWU3FTeTdrWmxCS1ZFR1FVMElkNDFMWlpFMm5KZGZFRDI4V2MzVFZV?=
 =?utf-8?B?VytYcERpVTNlYzFZdytOckVGRjJFYWVuQUwzR1ZYWTlVNkQxNVRxem9scnF2?=
 =?utf-8?B?bjFyZ25rRjRVdVcrRm1oUEJyRk05YXdZbFZuamcvMWFqK1VxaFVjRmgvdFFi?=
 =?utf-8?B?U3ViQUJBQVJoUDI3RjR0OSthRS91d3hIbmtndU9DN0c3QkhRUVl1dnE4NGNt?=
 =?utf-8?B?RnJqcTEvZUtRWVBpUDVkMkFnNzlrUDkrOWxDNGw2YzErUnJjNEdzcUpGQS9u?=
 =?utf-8?B?N1ZEV0R2MTNyUTViRXVSRHpKWFEvM1RsaDN6WXVoWlVjMXhPZkkyYzdzQjhB?=
 =?utf-8?Q?oDoLAEQCn/G1zJI+CztV0LHnkKyY8M=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB2513.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dURGbFFkbUFtRVMwQ1ptbDN1WlZDY0RTUnI2cE9tRVRHWXhES0IyWlBpakZ5?=
 =?utf-8?B?c2FvSnNJOU1BeEVkc2ZWNU42SzVTUUZkRTRoTGJDakFTMldNR29kZTRWZEZV?=
 =?utf-8?B?YlJTZ0lxQ3NRWEcyT25BTnQrdDNEL1JnbDNUU0x4NWFBRklvV3QvWlV1WFQ4?=
 =?utf-8?B?Sy8zaVU4bmlWamVneTM3eWllYVg1ZEd5L0hZMVJhekRmSlJCdFV2cEhnWUU4?=
 =?utf-8?B?RElGTUplUksxcFZBMTJjb1J4dkl3OHFOeER1OXpXd2FnVlJWRU9OZkNzSEVi?=
 =?utf-8?B?K2s5QXB0eXdndDNyNUkrb1c0TlA4RXJQbmIxT3VLMUJUWkZ0b0t2cFpDYzRX?=
 =?utf-8?B?NmlnMGJBQXZCdUp5NDNJb1I1dmZwWjBtRGIzTHB1dWRFenhPOXJVdDhwanFx?=
 =?utf-8?B?L1JXc1pSKzUzc2ZBcHRzRXdPSlRGaytWZTdEMEVTSVRIR0RsVVByTC9ON1d2?=
 =?utf-8?B?cHl2T01LNVlTMTJZUXZqTlR5YTIrTUtYRUsyZTFoelpKSGtiNnIxei8vUUo5?=
 =?utf-8?B?cVFHbmc2Y0xJeXdQZk5MeEUwdTZvSEtYU1JlcGZwSzV6aWNMak9iRlp2YkJu?=
 =?utf-8?B?OG9GU1B2K25QaEphWEc1QmY3Sjc3VGdLbWRpNm5jeGtXZnRUV2pHTWVxWTZh?=
 =?utf-8?B?Zzc1U0x4U0o1RkVwYTBzSXJWcVpBWlZNSWowZzZtNUkrZ0RYTUlHbHZuZ1Jm?=
 =?utf-8?B?MGgzdGNmVXp6ZjdQRERzOGxONC9xRkVtYzJ3b0c1MkV1bXZaUmU2aFZ6L1NI?=
 =?utf-8?B?WXM0U1A2REQ0Q1dBOW05TktPc01aS3hOcVl4Si9FRFhpV3FKaHNHZjcwMVFT?=
 =?utf-8?B?cWZwZTFQQmMweTBhY3YzendQMFZVWWlKTURLWHUyUjVkcmtFTzNiMEJVb3Nn?=
 =?utf-8?B?Q2htdDJ5S3F5bVR3QmE2cFg1b2o2bmFCNTkvYVRXc2UxTEQzVHhQN2orTzVD?=
 =?utf-8?B?emlzUGhiNElyWklBSUxoUkFVVHliQmlUS0hwK1k1VHRpQmxGQmd1ZkEvdERt?=
 =?utf-8?B?NmZyeGdHZ1NZZms5QXpDbG05ZlhSd3lYdm9vUW5BWXhGdVZKakhCQWR4TnA3?=
 =?utf-8?B?YXV6VFhwTjNsWW9FeWdUQkVwWWxKYW5uMUx3OWJad0EwODlDWERkTExwVm56?=
 =?utf-8?B?TllGb2U4SUJwUU52SnpMTFF2NGlBaHpYbnJEVG5BbUNzUkwwb2FXZjVrSDI1?=
 =?utf-8?B?ZS9HRXFOaS9vQkVwUllVRTQ0MGhXQ2MxOS9rNWJiOXZUalhrRStNUmgzM3pS?=
 =?utf-8?B?aHJSRFVWY1NsdytIZkE4b2o4NlBFZXFxaDNGbU1yMzNna0w3STRMUy84QmQ1?=
 =?utf-8?B?Si9zVStwL0JxRmJ6engyeitqMnBCQVJnTkhsNGJGRWNWSWlzTGV4akgwbUY1?=
 =?utf-8?B?L3lCVTBoTEpOanFWaG1yTnRMSDRmOEZCYmZMRENaT0VmOWo2MVBpRTA3NnNX?=
 =?utf-8?B?VXZyMGJoZDZ3Tm5IVEJSSWdDUHJNb1Vya2R0V2w0cm41ai94akY5OGdTSElO?=
 =?utf-8?B?Si9kRmtpeDdxRU1qU0FyNUZSVjdTeENrTlZkallKN0kzbzMzdVhyWG42aTVw?=
 =?utf-8?B?VW5aWFgwbDhxZTloYVRqb3VUdDZOMHNNM3VTUUNJR2twL045ak9BT2kzUjJ6?=
 =?utf-8?B?QnUwN2YrRFZRbmpOdWVwSXc4UHV4MnJ0VnhYOXAwZmZORWxqSlNYQ3NpbkNu?=
 =?utf-8?B?VlJ0b2ZzQy9wdWwxM25mMTNxZVpER3JyMy9QOW4rNkVSVE9XT0xGa0pqNDdq?=
 =?utf-8?B?UzhXeFBzWlU4WW9Hb1RuS0NnN2RCMjhKd2ZHRStEY0ZZL01ZcnhuR0hiWTBF?=
 =?utf-8?B?RENoSkZZUmZBZHNHWFA3d3lTZGM1d1Z4MHc1M0pwdEZkTUJ4RGFGTWpXNytD?=
 =?utf-8?B?S3hhZXdkTzhNVWYvSmVKUmMrbFlWd2kyUjN3TXFPKzF1QWVaMUJsa2Nib3hB?=
 =?utf-8?B?b0hhZGNGRXhTcDFlRlNkTGVmcys2V1VrVURUSTlNdUF0ZXhoRjlDNmdYOWdm?=
 =?utf-8?B?MS8zU2IwOFljTUViTyt2Q3Q2YmJXaTc0Q2k4dnZGcUNoaTVMZncxR2ZzSmQ1?=
 =?utf-8?B?dlRHdlFiQ1lCb3BWT01wK1B1anIwa2VTVGdIQzduN21FcmQzcDNXbUZ3OHVJ?=
 =?utf-8?B?L3J1WXFldCtuNEZZSGs0aW5oVWlwY01zZ3NmU0tadWN6dkRqTW5qMVJINWhK?=
 =?utf-8?Q?8BkvsUsQ7aRW9iQ0mYWS1tA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB2513.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e567f517-82fd-4e7a-4b52-08ddb190c9ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2025 13:29:17.5371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5PNez3T7sHCsEf1nLtiqlx/f4M8FJ4zQnBcuXVoDnYix1I5+nBwGB20rLhvcOWLf3FkhQraCgxHt5zTyCdVVLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB6461
X-Proofpoint-ORIG-GUID: Lgy73FO3aOg6JQT-x3WK0RamVLc8CAAM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIyMDA4MyBTYWx0ZWRfX3zPLUI46TsAG k3nLpOSKYOArP248MRKXqtKgF8VKFhEjQy/bmswaKZ6x5lVPpt3BYXxgxol3m+nXx8uHr2dPDRV dybAhtJ4PjJ4v4S4WPTa64ZFXU7oTs6pM6GJ69ASE7SEVpv/uyndaLcIvxr3Na2BaR/k+S115Ff
 rjluEZX44NSOro868r5yf5gMZMqbXlSybtdsMxF4ZRfm94vNoCuMkgwUjCbe/NgWprUuYniceXX aeizjiB+pPva1T3yfoGyxhwLzKvpXxXeLe3xJtGIZCItcjUSAtT1QTQGOA4JiCbEydcLQSGVGcH eN6CDHmTYCAElMIRuVaua67bjkn1ZImGfW5Km2FIdvutO2/ZdCopBwPTcDwlGHuSGH7zugFmfor
 pArLUDfWbsb1HcNdX8XrydvYzfTHkL6EEuV7zKyNuS0ZAtC14u73W2ioEh61HsJcsdLL2coU
X-Authority-Analysis: v=2.4 cv=MshS63ae c=1 sm=1 tr=0 ts=68580532 cx=c_pps a=2PF/rzsYy3Hr2OqMyPqH5A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=9jRdOu3wAAAA:8 a=pGLkceISAAAA:8 a=1XWaLZrsAAAA:8 a=AGRr4plBAAAA:8 a=8lx4r4GN9HiypPXeoIUA:9 a=QEXdDO2ut3YA:10 a=ZE6KLimJVUuLrTuGpvhn:22 a=bOnWt3ThIoLzEnqt84vq:22
X-Proofpoint-GUID: wmpK-p7_6UOd9POI9U8S6KVZKoZV4hRD
Subject: RE: [PATCH] RDMA/siw: work around clang stack size warning
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-22_04,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1011 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506220083

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJuZCBCZXJnbWFubiA8
YXJuZEBhcm5kYi5kZT4NCj4gU2VudDogU2F0dXJkYXksIEp1bmUgMjEsIDIwMjUgMTA6NDMgQU0N
Cj4gVG86IFpodSBZYW5qdW4gPHlhbmp1bi56aHVAbGludXguZGV2PjsgQXJuZCBCZXJnbWFubiA8
YXJuZEBrZXJuZWwub3JnPjsNCj4gQmVybmFyZCBNZXR6bGVyIDxCTVRAenVyaWNoLmlibS5jb20+
OyBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVwZS5jYT47IExlb24NCj4gUm9tYW5vdnNreSA8bGVv
bkBrZXJuZWwub3JnPjsgTmF0aGFuIENoYW5jZWxsb3IgPG5hdGhhbkBrZXJuZWwub3JnPg0KPiBD
YzogTmljayBEZXNhdWxuaWVycyA8bmljay5kZXNhdWxuaWVycytsa21sQGdtYWlsLmNvbT47IEJp
bGwgV2VuZGxpbmcNCj4gPG1vcmJvQGdvb2dsZS5jb20+OyBKdXN0aW4gU3RpdHQgPGp1c3RpbnN0
aXR0QGdvb2dsZS5jb20+OyBQb3RudXJpIEJoYXJhdA0KPiBUZWphIDxiaGFyYXRAY2hlbHNpby5j
b20+OyBTaG93cnlhIE0gTiA8c2hvd3J5YUBjaGVsc2lvLmNvbT47IEVyaWMgQmlnZ2Vycw0KPiA8
ZWJpZ2dlcnNAZ29vZ2xlLmNvbT47IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnOyBsaW51eC0N
Cj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGx2bUBsaXN0cy5saW51eC5kZXYNCj4gU3ViamVj
dDogW0VYVEVSTkFMXSBSZTogW1BBVENIXSBSRE1BL3Npdzogd29yayBhcm91bmQgY2xhbmcgc3Rh
Y2sgc2l6ZQ0KPiB3YXJuaW5nDQo+IA0KPiBPbiBTYXQsIEp1biAyMSwgMjAyNSwgYXQgMDY6MTIs
IFpodSBZYW5qdW4gd3JvdGU6DQo+ID4g5ZyoIDIwMjUvNi8yMCA0OjQzLCBBcm5kIEJlcmdtYW5u
IOWGmemBkzoNCj4gPg0KPiA+IEJlY2F1c2UgdGhlIGFycmF5IG9mIGt2ZWMgc3RydWN0dXJlcyBp
biBzaXdfdHhfaGR0IGNvbnN1bWVzIHRoZSBtYWpvcml0eQ0KPiA+IG9mIHRoZSBzdGFjayBzcGFj
ZSwgd291bGQgaXQgYmUgcG9zc2libGUgdG8gdXNlIGttYWxsb2Mgb3IgYSBzaW1pbGFyDQo+ID4g
ZHluYW1pYyBtZW1vcnkgYWxsb2NhdGlvbiBmdW5jdGlvbiBpbnN0ZWFkIG9mIGFsbG9jYXRpbmcg
dGhpcyBtZW1vcnkgb24NCj4gPiB0aGUgc3RhY2s/DQo+ID4NCj4gPiBXb3VsZCB1c2luZyBrbWFs
bG9jIChvciBhbiBlcXVpdmFsZW50KSBhbHNvIGVmZmVjdGl2ZWx5IHJlc29sdmUgdGhlDQo+ID4g
c3RhY2sgdXNhZ2UgaXNzdWU/DQo+IA0KPiBZZXMsIG1vdmluZyB0aGUgYWxsb2NhdGlvbiBzb21l
d2hlcmUgZWxzZSAoa21hbGxvYywgc3RhdGljIHZhcmlhYmxlLA0KPiBwZXIgc2l3X3NnZSwgcGVy
IHNpd193cWUpIHdvdWxkIGF2b2lkIHRoZSBoaWdoIHN0YWNrIHVzYWdlIGVmZmVjdGl2ZWx5LA0K
PiBpdCdzIGEgdHJhZGVvZmYgYW5kIEkgcGlja2VkIHRoZSBzb2x1dGlvbiB0aGF0IG1hZGUgdGhl
IG1vc3Qgc2Vuc2UNCj4gdG8gbWUsIGJ1dCB0aGVyZSBpcyBhIGdvb2QgY2hhbmNlIGFub3RoZXIg
YWx0ZXJuYXRpdmUgaXMgYmV0dGVyIGhlcmUuDQo+IA0KPiBUaGUgbWFpbiBkaWZmZXJlbmNlcyBh
cmU6DQo+IA0KPiAtIGttYWxsb2MoKSBhZGRzIHJ1bnRpbWUgb3ZlcmhlYWQgdGhhdCBtYXkgYmUg
ZXhwZW5zaXZlIGluIGENCj4gICBmYXN0IHBhdGgNCg0KDQpkb2luZyBrbWFsbG9jIGluIHRoZSBm
YXN0IGRhdGEgc2VuZCBwYXRoIGlzIHdoYXQgSSBjbGVhcmx5IHdhbnRlZA0KdG8gYXZvaWQuIFRo
ZSBjdXJyZW50IGNvZGUgaXMgYSBwZXJmb3JtYW5jZSBvcHRpbWl6YXRpb24gd2hpY2ggdHJpZXMN
CnNlbmRpbmcgdGhlIGNvbXBsZXRlIGl3YXJwIHBhY2tldCBpbiBvbmUga2VybmVsX3NlbmRtc2co
KSBjYWxsLg0KQSBwYWNrZXQgbWF5IGNvbXByaXNlIG11bHRpcGxlIHBhZ2VzIHJlZmVyZW5jaW5n
IHVzZXIgZGF0YSBvZg0KbXVsdGlwbGUgU0dFJ3MgdG8gYmUgc2VuZCBwbHVzIGEgcGFja2V0IGhl
YWRlciBhbmQgYSB0cmFpbGVyIENSQy4NClRoZSBhcnJheSBzaXplIHJlZmxlY3RzIHRoZSBtYXhp
bXVtIG51bWJlciBvZiBwYWNrZXQgZnJhZ21lbnRzDQpwb3NzaWJsZS4NCg0KSW4gdGhlIGxvbmcg
cnVuLCBJIHNoYWxsIHJlZmFjdG9yIHRoYXQgY29kZSB0byBhdm9pZCB0aGUgaXNzdWUuDQpJIGFw
cHJlY2lhdGUgQXJuZCdzIGZpeCBmb3Igbm93LiBJJ2xsIHRlc3QgYW5kIGNvbWUgYmFjayBzb29u
Lg0KDQpNYW55IHRoYW5rcywNCkJlcm5hcmQNCj4gDQo+IC0ga21hbGxvYygpIGNhbiBmYWlsLCB3
aGljaCBhZGRzIGNvbXBsZXhpdHkgZnJvbSBlcnJvciBoYW5kbGluZy4NCj4gICBOb3RlIHRoYXQg
c21hbGwgYWxsb2NhdGlvbnMgd2l0aCBHRlBfS0VSTkVMIGRvIG5vdCBmYWlsIGJ1dCBpbnN0ZWFk
DQo+ICAgd2FpdCBmb3IgbWVtb3J5IHRvIGJlY29tZSBhdmFpbGFibGUNCj4gDQo+IC0gSWYga21h
bGxvYygpIHJ1bnMgaW50byBhIGxvdy1tZW1vcnkgc2l0dWF0aW9uLCBpdCBjYW4gZ28gdGhyb3Vn
aA0KPiAgIHdyaXRlYmFjaywgd2hpY2ggaW4gdHVybiBjYW4gdXNlIG1vcmUgc3RhY2sgc3BhY2Ug
dGhhbiB0aGUNCj4gICBvbi1zdGFjayBhbGxvY2F0aW9uIGl0IHdhcyByZXBsYWNpbmcNCj4gDQo+
IC0gc3RhdGljIGFsbG9jYXRpb25zIGJsb2F0IHRoZSBrZXJuZWwgaW1hZ2UgYW5kIHJlcXVpcmUg
bG9ja2luZyB0aGF0DQo+ICAgbWF5IGJlIGV4cGVuc2l2ZQ0KPiANCj4gLSBwZXItb2JqZWN0IHBy
ZWFsbG9jYXRpb25zIGNhbiBiZSB3YXN0ZWZ1bCBpZiBhIGxvdCBvZiBvYmplY3RzDQo+ICAgYXJl
IGNyZWF0ZWQsIGFuZCBjYW4gc3RpbGwgcmVxdWlyZSBsb2NraW5nIGlmIHRoZSBvYmplY3QgaXMg
dXNlZA0KPiAgIGZyb20gbXVsdGlwbGUgdGhyZWFkcw0KPiANCj4gQXMgSSB3cm90ZSwgSSBtYWlu
bHkgcGlja2VkIHRoZSAnbm9pbmxpbmVfZm9yX3N0YWNrJyBhcHByb2FjaA0KPiBoZXJlIHNpbmNl
IHRoYXQgaXMgaG93IHRoZSBjb2RlIGlzIGtub3duIHRvIHdvcmsgd2l0aCBnY2MsIHNvDQo+IHRo
ZXJlIGlzIGxpdHRsZSByaXNrIG9mIG15IHBhdGNoIGNhdXNpbmcgcHJvYmxlbXMuDQo+IA0KPiBN
b3ZpbmcgdGhlIGJvdGggdGhlIGt2ZWMgYXJyYXkgYW5kIHRoZSBwYWdlIGFycmF5IGludG8NCj4g
dGhlIHNpd193cWUgaXMgbGlrZWx5IGJldHRlciBoZXJlLCBJJ20gbm90IGZhbWlsaWFyIGVub3Vn
aA0KPiB3aXRoIHRoZSBkcml2ZXIgdG8gdGVsbCB3aGV0aGVyIHRoYXQgaXMgYW4gb3ZlcmFsbCBp
bXByb3ZlbWVudC4NCj4gDQo+IEEgcmVsYXRlZCBjaGFuZ2UgSSB3b3VsZCBsaWtlIHRvIHNlZSBp
cyB0byByZW1vdmUgdGhlDQo+IGttYXBfbG9jYWxfcGFnZSgpIGluIHRoaXMgZHJpdmVyIGFuZCBp
bnN0ZWFkIG1ha2UgaXQNCj4gZGVwZW5kIG9uIDY0QklUIG9yICFDT05GSUdfSElHSE1FTSwgdG8g
c2xvd2x5IGNoaXAgYXdheQ0KPiBhdCB0aGUgY29kZSB0aGF0IGlzIGhpZ2htZW0gYXdhcmUgdGhy
b3VnaG91dCB0aGUga2VybmVsLg0KPiBJJ20gbm90IHN1cmUgaWYgdGhhdCB0aGF0IHdvdWxkIGFs
c28gaGVscCBkcm9wIHRoZSBhcnJheQ0KPiBoZXJlLg0KPiANCj4gICAgICBBcm5kDQo=

