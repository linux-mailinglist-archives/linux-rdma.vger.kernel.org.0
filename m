Return-Path: <linux-rdma+bounces-13904-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF77CBE4A7A
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 18:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1C2F5E3A1F
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 16:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D121DF970;
	Thu, 16 Oct 2025 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pod40FA3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kgmZjMTo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7052E62D0;
	Thu, 16 Oct 2025 16:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633010; cv=fail; b=s+b9zbDLsFFco07/W6TlN21bvTnn814wyfbZ0LrCMy0RZ3EBqYeOQxapn0VoGTMM3fVugwkOYtHdpQJjSFqJuHYZL4qq3dXgIeRWHjV9M3M2x63ir8v4s+sQ5s0/BJtYBQapc2aa2DVKkZ1E2fxAVA4gXKwonsQkFK42ylrTRbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633010; c=relaxed/simple;
	bh=weUEm/g4dnwFjyAz8IExx9rk71YKtslvBzEO6vq5NP0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BlAoWy8KvV0bs4kaPbNtKg3WLDfL+RbaA4ABXUEkBjccGzD54Y8w/cKPJC0nApuvFUlu5z/WIoNOA1A7xErWhfHTlfVRNkLgfEpvsz3dnB43GrvVRgS8heQ4+ScCbFuQY6FQM/5xwa1GUd/L3RlYylRuHG5VGXt9Hf5lkZRRKLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pod40FA3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kgmZjMTo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GEVKgk032028;
	Thu, 16 Oct 2025 16:43:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=weUEm/g4dnwFjyAz8IExx9rk71YKtslvBzEO6vq5NP0=; b=
	pod40FA3CsMoGEblVZBpvMd+7nSKVsf3PHTZKQnoYi3J0vtTX5GYpZgotSDkLe+f
	dJN/xKEWVe7V0O3GhYUPuYjUU+QGAA6pBcmrn6ZAUwVaIVweEfZ2yUxi07WReWP3
	DFbAnwkTcz8l/LKV5GcoSiH6ILyZzUdYKhAzSiC3YP5T0MOJSsNN9PyOKfQDE4vu
	ah9eccOKmNPk2QRfB/X60aoAH5fT9+gWxeNAzrnE9780nX3O5LSsVd5NCh4OZFdA
	Lmy+8M+ImpQ19YyCqwJ2EomtgEyYmhPUov8JD3mV95w5ulVy32I5OnepaU8aCggA
	567WRlbzYMSNvWYpcEWkMA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49ra1qge3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 16:43:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59GFNTWg017989;
	Thu, 16 Oct 2025 16:43:19 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011037.outbound.protection.outlook.com [40.93.194.37])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpbq1c6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 16:43:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bgc5a9yfBPTYAt9knRsHrq/egOx5PbZil/d2rTHJoN/95Ne8259/V85OKdQpqA8RpnYSBTk2AEyEgbcFaVp2uUpSUkyRTpTyXVA/77dJ1WOhJB9zTyrMLV0Ois/Q+ARkJEhN2CE0q5ZnEXRO5ok0IuF4mtMmBbjhTCd0l6l/j0VeMMzbvze8+pulK4JzCUwNsnT7YmR86nMzpL5HpxtJEZylXubQtanocPTW7qIW29Da5mqcG3FgOgimk3N+e+Tb+Lx7GNohNaJWdwKJZ6MPmmRG1dDGv/ifvl9nX7Vy2bcMFLV8L6ovzT+v8zNGKXG+mioQXaq0iUJJPUuLtakvMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=weUEm/g4dnwFjyAz8IExx9rk71YKtslvBzEO6vq5NP0=;
 b=bE9feK30bXNKJixcaQrmT/tMtpTsbXG9LPzgZMzrf8tEtKzRVG1zYywsub1ZtgrwbzIkM/3Ar9CalZm93IXqSy+fajdL7RA3VBsENnfaEQF4KM+seCRWqqyIaJJqmGmv55jyfQHhn91aaA7JuM8ptvGuJzJguADk52jUWPq7pWTh3ejWgXFt5qMUFMaP5bV1Ig7ygDqwODk6i3QQrLL20jlzofps6T6N4vgZGVs8Kvu9vHPkBO7Ulr6FViZotL5A8OvTuU0I80ipTyOKd8Wg7mENTrD3UJ7kGOB3TLTLd2q67uHWndhLTXW96RaveF6qdtaFa6y4yB9+sD3BbAV+cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=weUEm/g4dnwFjyAz8IExx9rk71YKtslvBzEO6vq5NP0=;
 b=kgmZjMToC+KT8SJD5Exr7TMAZ2J7TFVuJunaJH+6BO54DDgxuc75j8M+xJx541laUZfBwOqEjDMukNEvo+eRPO4zwHLUAhOMHd9ljcn5G0qazWDaYgfDfcfXLlPkxpkw00jP4Jcr1gybAL9muKvfbz4eq8wgqOJ1YnPcYnEgi/4=
Received: from DM4PR10MB6839.namprd10.prod.outlook.com (2603:10b6:8:105::10)
 by SJ5PPF7113AF9D1.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7a7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 16:43:16 +0000
Received: from DM4PR10MB6839.namprd10.prod.outlook.com
 ([fe80::dc16:2669:e9f9:4c9e]) by DM4PR10MB6839.namprd10.prod.outlook.com
 ([fe80::dc16:2669:e9f9:4c9e%5]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 16:43:16 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Sean Hefty <shefty@nvidia.com>, Jacob Moroni <jmoroni@google.com>,
        Leon
 Romanovsky <leon@kernel.org>,
        Vlad Dumitrescu <vdumitrescu@nvidia.com>,
        Or
 Har-Toov <ohartoov@nvidia.com>,
        Manjunath Patil
	<manjunath.b.patil@oracle.com>,
        OFED mailing list
	<linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/cm: Rate limit destroy CM ID timeout error
 message
Thread-Topic: [PATCH for-next] RDMA/cm: Rate limit destroy CM ID timeout error
 message
Thread-Index:
 AQHcI8zHdy1KL4KXCkyexoudDHS8M7SV4d4AgAAFLICADfC2AIAcdSOAgAL71ACAAFcGAIAAHVyAgAAC/wCAAVplAIAADUCAgAAIjgA=
Date: Thu, 16 Oct 2025 16:43:16 +0000
Message-ID: <6244F8C9-2067-4A8A-8DCD-02A4A2D117F6@oracle.com>
References: <20250912100525.531102-1-haakon.bugge@oracle.com>
 <20250916141812.GP882933@ziepe.ca>
 <CAHYDg1Rd=meRaF=AJAXJ+5_hDaJckaZs7DJUtXAY_D2z_a6wsw@mail.gmail.com>
 <D2E28412-CC9F-497E-BF81-2DB4A8BC1C5E@oracle.com>
 <ABD64250-0CA0-4F4F-94D3-9AA4497E3518@oracle.com>
 <07DE3BC6-827E-4311-B68B-695074000CA3@oracle.com>
 <20251015164928.GJ3938986@ziepe.ca>
 <CH8PR12MB97419E98111F553FCC117E36BDE8A@CH8PR12MB9741.namprd12.prod.outlook.com>
 <20251015184516.GK3938986@ziepe.ca>
 <49A8CE60-DC8E-43F7-9620-D4D5F8EB2A08@oracle.com>
 <20251016161229.GM3938986@ziepe.ca>
In-Reply-To: <20251016161229.GM3938986@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR10MB6839:EE_|SJ5PPF7113AF9D1:EE_
x-ms-office365-filtering-correlation-id: b8a1a1e6-8070-4c44-3f21-08de0cd31b0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?anJuQ01zd0Q5WWNPdXJoRk96SUFxTm5vTHoxTHI5UnYrV3JBSnR1UGpudDBo?=
 =?utf-8?B?WnRQNkx5K29NQVdMQTZrd1VEaERYT2toWG5KTlFQTGxYM2VJL1c3UUkwVXh1?=
 =?utf-8?B?NVdoWVEweHZQVUhnNW0vQytnQ0FSRldpYzVwZWVoajVxSXcrTW9tc3V1QU5m?=
 =?utf-8?B?NmlqRENNLy9QanZlWWdSbVJ4anRsMHFXdUxSRVBtbEhTc3piNXhtV1M4aWNt?=
 =?utf-8?B?VmdHZ3E0UnNHVFJsbVpMcVc1VTh0MWVmcmxtOVRpYTQ4V3h1M01Ca0NwZUJh?=
 =?utf-8?B?bUJLMlN3MkpxeVhNT2ZhWEFLNTI4N3NaK0YwNUhBSi9GZjBkM3FvMTE1azBR?=
 =?utf-8?B?TGJyY0pJQk9zRTdLRTB2b1NIZGJTTXR1NjRDWHEzSUFWYVdIdk00OG81dW8v?=
 =?utf-8?B?U3NKanpKb0dsZ0YzeDVMVDRBYmNoWGVUOEh5Nk80dEM3cERVdFFUN3VvMi9x?=
 =?utf-8?B?U2RCOGNOV2VHbk9pYys5TjJYOW5XdmdGV2IySStCS2tEZlZXWlBtNUZxak8x?=
 =?utf-8?B?KzNpRVRqWUV5aEhBWS9BOU45Q2JBUUhrNEJYeDA5WDk5Q2FzRlpzbVlXb0wy?=
 =?utf-8?B?RGxmK2pSZEl2TzNlM3dsVmRlNGxnc0NPTFp0NVdPclBrOVlsYVBPWTNGVVFQ?=
 =?utf-8?B?YTdvcWdObEUzaTQ4Y1BOUFRQZFUzeEJwV0xNVkhOUk95WUVrR2ZGZnlSWjd2?=
 =?utf-8?B?dUpIcVAvME1ORnRCWDFFK0NlQjI2dS96NTFWeVROdVVtenJYeExHME44UGtl?=
 =?utf-8?B?VTA4dE9LV0dCRE1FQnpXNUlFdEtoMlJoRmR5enN2dnRYZzFLM0tpZCtKdlp6?=
 =?utf-8?B?VFBOYUV3a1FQcTgxVGU5cS9lajZ6UFZKRnR5N0p4bWY5Zk8xcG1KS3JjSlpu?=
 =?utf-8?B?U2ZSZ2dMaUpDRlFtbHA2QURaeGxMTUNLWXdRTnJPZGlaZS9qcTJLSjE5R2gy?=
 =?utf-8?B?bSsrQ3RBRkRoRG5SSlREQ3VQSmN1aXdKZUI4UFRSUDF2cjlNbjNoT0xpb3BN?=
 =?utf-8?B?eEJDSm10U2VpSS95QTlLSnlpVnZSck1ja2E4RXdyV2pNZjZYSWFzQS96T2Mz?=
 =?utf-8?B?UFhwMWlxdGFoM1M2MWhiNk9YSmFSR2svdExEQmV4RWdqMVdBMCt4Wjc0ZnMr?=
 =?utf-8?B?WGw2b0tKb3ZLQkptZ1NGRHdIckJWME1YNWdidDdUQmlYQzJUN1BGUzA5MXZa?=
 =?utf-8?B?VUN0a1B3aHpiTzJqMmMyc3VkNU9TRmVScHFPM2RWNVJYWnQ5RVpPajMzaWFP?=
 =?utf-8?B?cHRFS0I4MXZIVkdrT1RxREg0ZkpvSEVLR3BVM1hEQUlZa2hiU3c0aElDMzly?=
 =?utf-8?B?REJBL1lsKzlTL25OS1hVWjBWRmhKZDRwcGFRVUwrQ0FZMUNiTTFjWWRocDAw?=
 =?utf-8?B?MkdsUGhYQmdSSWlJUno5RXVaMzVmUHRHaVd1QTAzZE9HNHYxRExxSHlIY0Ji?=
 =?utf-8?B?Q3FLWFRLeklTeXNYOTlVcXoyd0FGSUxraXhEUURMMWg0OENPa2VGVU9zWVJt?=
 =?utf-8?B?RjlIU05pamJ5eHdEWFYzb0NpTzJzendGMlVEclR0Vzg4V3ZZM2xkck8zR2ZI?=
 =?utf-8?B?ckNWWGwvMXNSNEJUUU14cHhLRnVkZXJBNlV5UEdwVWNkMVpnTzFNaWJVeVkx?=
 =?utf-8?B?Wllvalpzd0FIL3hHSTRPV291cWRkUmc0aEpKTUNIR3RBcVV1end1c2V2L1l2?=
 =?utf-8?B?akh3eHBXYm5ZQ0ZXbVdVWFhiM29SNmdXSGpmeWZhT3BEQWZ3dExkWUdTZE41?=
 =?utf-8?B?bTZPZ0VVTlZsUitKVFBkekZJYkFiVUx0RDIyYVhIUDlHOXVyNkdCUWZYWmlH?=
 =?utf-8?B?RlNXZzFZTG4zYWpNNlZWTTMzVXVHYVRBQkprWjRFM3BkTkdsTzV3UVVlZnB0?=
 =?utf-8?B?WlRjZW5ISWNvWUdOT0VDa2djU3A1NzNhY280OHMya0hqVGNUNDNqNjZiQ0RU?=
 =?utf-8?B?MVhsdFhCYmNtdTEyRW1KN1lUY2xaZStNRE83VlBWRkR5Z28zSm50Sngwb2E5?=
 =?utf-8?B?TzBCY1FRbDBXTjZhbURScFl3ejRzazcwVDBwVGY5T3hDWHN4R2EyQWI1YjBi?=
 =?utf-8?Q?KkUDM9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6839.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K0hBazNFaHl1UXo0VkNaaTdOSkdJWU5ZblpydTNUSDNGWEkvSjdjMVRNS2xu?=
 =?utf-8?B?YmxMdkxiM3dBZG5DNVRCRGNVRjZ3dVljcWVoSllhQnNuTWJQcFV1OFpjNEc0?=
 =?utf-8?B?QjVoZnppVEs1bmM0cmIzMHpNaHVyellFRjF2aHF5ZDgwVXlrSHltUEhZN01h?=
 =?utf-8?B?UUxBNElxdEpRd0t1bVBHL0xTK3VaQ21aSzQrMDlQY2VmSzZoS3BxbDE4V2Ez?=
 =?utf-8?B?S0VlVUxOU2twWUR1eHlQMlB6QUdBc3d1bnRWZ2VWNHQvc0xrRDBmbERJclIy?=
 =?utf-8?B?MEFsTEZ5ZlUzOUZzcEtKdFowM0c2SXJ2OG9UZnpJWDZZdGowd1NWMGNHUVJE?=
 =?utf-8?B?OG41VkRSeE5tb0NvVWRoaWpMdEFxbTA5d25KNlVIV0lrWm5ZN2dzZ1JrZGIz?=
 =?utf-8?B?dlFLc2VVOW9aYUdZV1R5ZXNNVFpWeXZDekJTTHk5bDFFdit4YzdUaVgwTm1Q?=
 =?utf-8?B?NHhmZXNrOTV4SkFBa3dCckhWTjNsYTM0RFU0aFptVnpGc3dveUZOWTVQT1Uz?=
 =?utf-8?B?UHZmcVNMYk5WTjdTcm50Yms2YkUwdGtLZkdiN25XbjJxQ1dMUUVBdENxQi82?=
 =?utf-8?B?TE1WYlpiYmRkb0g3dFh5TlFvdUpVSERLMnV5RzFiOURaSVBKQ1hHVkVXaW9T?=
 =?utf-8?B?RUYvTWVuS1lSNVVFR1dWVnFTNWhzR2RRQkprUklLSHA1R3JYZDlnRGYyM1BT?=
 =?utf-8?B?RWpXQXZMRTJEYU1GWWkvVUI5TmlnbDY0Lytma1NvWjBteUJDVVF2L3JsSkx2?=
 =?utf-8?B?WXNISEJwWHM4NklEV1BoLzVTdExIR3BhaEVMUC92LzZJNDNOdW51djd1MmtT?=
 =?utf-8?B?anE3MFhCMTg1T0piYjVEVnVSM2FEODBuRVVlc0d1NTM4UXVwZjBRL2MrLzNs?=
 =?utf-8?B?bW9wQjVjVi8wTTlncmFHa3krZUFsbm9XYUs0SitpWmwyeTZoZ2FXS0Q3V2t1?=
 =?utf-8?B?eHdZOEVXU3RNS0Y1QWQwNDFzN0NvR1RBVUdnRjRzQnRVQklGMkg5dlRlZ3Fw?=
 =?utf-8?B?L1JBclVmbjZkNjNqYkdERWRXRlBtMldUand5am96bzFPMEpMNWFEc1JrNkhs?=
 =?utf-8?B?UGNqYUpDQTR5Z0pueHJHSmZhVDE0MzN4UUpvWmJZdFIxeHBiUDlaM3BNcVo0?=
 =?utf-8?B?bysyQ2Q1SHIzVHF5SDVZT1lleWZ3Umx2T3BCSGNoSFNHR3BCSVdZL2ZwdlNh?=
 =?utf-8?B?aFdReEdEMmVYTmtRd2NoQnFueGNpR2xOaVBTbTFGemo2TGt4L3pLbW85M29v?=
 =?utf-8?B?T0tJTGhMK1dvNGY4UUtBUDRNRllyWC9id1VENEdEQkxHK0RQM1E1VGNETHZa?=
 =?utf-8?B?OUsxNDk2UFhNOU5ScjNmQ3I5MzB0Yjk0V3lsMDFCcWNaK2w2UEZrTEtPa3ZS?=
 =?utf-8?B?UzdwN0NjWmh3YlJYaVhCN3lZeG5PZk0xS25GYzVsTHZDK2JhVXJodU50VEFC?=
 =?utf-8?B?eTQ2SFFXczZpZXduRnVoajlrcFZaUUtwSDliWEU2UjkrNldYK1kzOE1xU044?=
 =?utf-8?B?Y3B2VVRGZXhSSTRpZDhGeldaNVZqNDFnSk5sZkhKSzFTdlltVUhXaVB0UzJL?=
 =?utf-8?B?VEpIbk9zUTh4bmxMbWpVNlJZR21jdWY4ZjhoTlU4eW41aUpUK1RQaDJidG83?=
 =?utf-8?B?U0hqU1JkRHpkZTVWdVIxM0ZTQVhHc2ZpRHBxOXZRK0c2N3BnQjYyd0o1K0J0?=
 =?utf-8?B?dy9yazdQb29PNkY0OFRwSCt3T2FGOEtxdGZFODg1TEw5MHV0OGM3TEd1VXpM?=
 =?utf-8?B?YTFLR1BMUDFRaVRBNFJCTVNSeUlPOU5JUytEaWdaYURJVmt6alFkdElIUUdY?=
 =?utf-8?B?RXBtRC9wODdvV3AyVTlmOE1HUzdybjg4NDZZWDVRQ1BScEJDTXl1Mlo1SWhF?=
 =?utf-8?B?eGFOOHZvbFpvdCs3REdoSFpta1hzUnc3Qy91dHBLUkRWdFlVNythc0FZY3V4?=
 =?utf-8?B?WlZRVEoxV3I2ODRoaS9Xd0xYTWRvMkpqdmtHYmkyTG10R0xtcXFQazVYeFc1?=
 =?utf-8?B?OFI5ZGJZNkNPeEh2VVlmU3JYTzBaNndqdDhCbWl3SkxvazRZeEhuN0J6ZDV3?=
 =?utf-8?B?aHlRVnZrVGpGcG9wbHZJWlZHMmtnaU1ZUmJURklRbnphMUVZTTY2eWNjVXBp?=
 =?utf-8?B?ZStVVmxvNllQeEhoeTE0ZkgxVEM1WThLV2lyQjRBMG9WbWp0U2V3eTZIRjFo?=
 =?utf-8?B?Qnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF04111681D88046B331BCE6BC67B21E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2Lf1PM+bZCZPX/xHObKXXiNxCJ4yabsODzjc06rFMo7xqZcqz9iU8/3o+9B5vbe5xwfsuj69HBntY0I6SVlmCXZtnB/t/05vYW2/e6DOnuRHbqczb2Tb7bUtQVdbpQl72ytOkHAsOCOmBTci6t0OGenPnL/zlNsOVAOk9n0+FGC2XWwLdfoloy2JKDC/3+kJDA7NtIAQtXg3XfGx4l+35lVBD4QcPupGVMC7xKvmi1wpXOELk9iIsyd8AG4WGnnLFhmUN2SXTwrxoS6J+UkabhhKLlvRwJQFtq1G2ibtF4QiW0xeMorSNXF+pLSbvc7SqR7Evpbk/4sRBoUbxpLcKjKiKBd2fBRGJdV/mCsT3oSX7FMIMPv4tL77h9xLNQdyfXb3gTNbIcG8fHYmJcH7x9VhNVI2LGuwvMxXM/3Pv27rYYZHXaDkZeI3kaCY0iU1djWcf4B0r3VDlRQpsjW8MDLUuw/nsLzJpNnS98JBD7gpyrAy3Rk8Umj4DGJ948LB2aT9GQlxF5GEV5MwfXEgmwlzOAjEsqwAZvg+0rYwiGRj1DjHx8UZ6s0rgC8GoiIQLK5FLk0ww6wzhHjCQullFJcs6f/bFXtDcEa48ENi6/Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6839.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a1a1e6-8070-4c44-3f21-08de0cd31b0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 16:43:16.4244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sCYK9U2KHExElAd8W2I67VSEXpgCQOtcEr2xrwmK8KvyFbxB3HGelw01vBmJUZf//8lAzwy/wcyYa8Ply4tJsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF7113AF9D1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510160120
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDA1MSBTYWx0ZWRfX9B29dAoE/Wob
 m5fyohiGqaAUlrnQRaYtoyhJHjyVZdVT/bUVa+G5c+TY8+s0P3YDpSGG9UbhuSFfa6t3VYAyJse
 oWfxoswJX8NWFQ7Mehk8LnAkAJpUXbCya0bfqWXpvF1lFtwfXy3XC/tOXBH0XNxJcCAUzujAUXc
 hLG9iFly9JHEk6cZT/MQOiPAHWO/TmyIqRkY0my1gqtkV5CrI2B/OVGvzEnHKByB73W+33VNoG1
 hXUSpAdVVwrN+X5PGPC9pL5xnGo2uvcz11JJzKhcpJGNfehnuUpWkGAPfSd71cLifoVVKdv30jM
 7jw3iTNTzPjcSxf2YO/Je6bMFBeWIJvtFaPfQwQ9A2v8PppeGKDV6jIhDant7WZXHSOTKPZry8G
 3y7mxV7uBBlcFezpAhKAnRKe0JYf2g==
X-Proofpoint-GUID: Mu6IiKAZf6x_Q8G4199GIMYZ5ajiEy6K
X-Proofpoint-ORIG-GUID: Mu6IiKAZf6x_Q8G4199GIMYZ5ajiEy6K
X-Authority-Analysis: v=2.4 cv=GL0F0+NK c=1 sm=1 tr=0 ts=68f120a8 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=9jRdOu3wAAAA:8 a=Fgao2eDxHejP_IYBXB0A:9
 a=QEXdDO2ut3YA:10 a=ZE6KLimJVUuLrTuGpvhn:22 a=cPQSjfK2_nFv0Q5t_7PE:22

DQoNCj4gT24gMTYgT2N0IDIwMjUsIGF0IDE4OjEyLCBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVw
ZS5jYT4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIE9jdCAxNiwgMjAyNSBhdCAwMzoyNToxNVBNICsw
MDAwLCBIYWFrb24gQnVnZ2Ugd3JvdGU6DQo+PiANCj4+IA0KPj4+IE9uIDE1IE9jdCAyMDI1LCBh
dCAyMDo0NSwgSmFzb24gR3VudGhvcnBlIDxqZ2dAemllcGUuY2E+IHdyb3RlOg0KPj4+IA0KPj4+
IE9uIFdlZCwgT2N0IDE1LCAyMDI1IGF0IDA2OjM0OjMzUE0gKzAwMDAsIFNlYW4gSGVmdHkgd3Jv
dGU6DQo+Pj4+Pj4gV2l0aCB0aGlzIGhhY2ssIHJ1bm5pbmcgY210aW1lIHdpdGggMTAuMDAwIGNv
bm5lY3Rpb25zIGluIGxvb3BiYWNrLA0KPj4+Pj4+IHRoZSAiY21fZGVzdHJveV9pZF93YWl0X3Rp
bWVvdXQ6IGNtX2lkPTAwMDAwMDAwN2NlNDRhY2UgdGltZWQgb3V0Lg0KPj4+Pj4+IHN0YXRlIDYg
LT4gMCwgcmVmY250PTEiIG1lc3NhZ2VzIGFyZSBpbmRlZWQgcHJvZHVjZWQuIEhhZCB0byBraWxs
DQo+Pj4+Pj4gY210aW1lIGJlY2F1c2UgaXQgd2FzIGhhbmdpbmcsIGFuZCB0aGVuIGl0IGdvdCBk
ZWZ1bmN0IHdpdGggdGhlDQo+Pj4+Pj4gZm9sbG93aW5nIHN0YWNrOg0KPj4+Pj4gDQo+Pj4+PiBT
ZWVtcyBsaWtlIGEgYnVnLCBpdCBzaG91bGQgbm90IGhhbmcgZm9yZXZlciBpZiBhIE1BRCBpcyBs
b3N0Li4NCj4+Pj4gDQo+Pj4+IFRoZSBoYWNrIHNraXBwZWQgY2FsbGluZyBpYl9wb3N0X3NlbmQu
ICBCdXQgdGhlIHJlc3VsdCBvZiB0aGF0IGlzIGENCj4+Pj4gY29tcGxldGlvbiBpcyBuZXZlciB3
cml0dGVuIHRvIHRoZSBDUS4NCj4+IA0KPj4gDQo+PiBXaGljaCBpcyBleGFjdGx5IHRoZSBiZWhh
dmlvdXIgSSBzZWUgd2hlbiB0aGUgVkYgZ2V0cyAid2hhY2tlZCIuIFRoaXMgaXMgZnJvbSBhIHN5
c3RlbSB3aXRob3V0IHRoZSByZXByb2R1Y2VyIGhhY2suIExvb2tpbmcgYXQgdGhlIG5ldGRldiBk
ZXRlY3RlZCBUWCB0aW1lb3V0Og0KPj4gDQo+PiBtbHg1X2NvcmUgMDAwMDphZjowMC4yIGVuczRm
MjogVFggdGltZW91dCBkZXRlY3RlZA0KPj4gbWx4NV9jb3JlIDAwMDA6YWY6MDAuMiBlbnM0ZjI6
IFRYIHRpbWVvdXQgb24gcXVldWU6IDAsIFNROiAweGUzMWVlLCBDUTogMHg0ODQsIFNRIENvbnM6
IDB4MCBTUSBQcm9kOiAweDcsIHVzZWNzIHNpbmNlIGxhc3QgdHJhbnM6IDE4NDM5MDAwDQo+PiBt
bHg1X2NvcmUgMDAwMDphZjowMC4yIGVuczRmMjogRVEgMHg3OiBDb25zID0gMHgzZGVkNDdhLCBp
cnFuID0gMHgxOTcNCj4+IA0KPj4gKEkgZ2V0IHRvbnMgb2YgdGhlIGxpa2UpDQo+PiANCj4+IFRo
ZXJlIGFyZSB0d28gcG9pbnRzIGhlcmUuIEFsbCBvZiB0aGVtIGhhcyAiU1EgQ29uczogMHgwIiwg
d2hpY2ggdG8gbWUgaW1wbGllcyB0aGF0IG5vIFRYIENRRSBoYXMgZXZlciBiZWVuIHBvbGxlZCBm
b3IgYW55IG9mIHRoZW0uDQo+IA0KPj4gVGhlIG90aGVyIHBvaW50IGlzIHRoYXQgd2UgZG8gX25v
dF8gc2VlICJSZWNvdmVyZWQgJWQgZXFlcyBvbiBFUQ0KPj4gMHgleCIgKHdoaWNoIGlzIGJlY2F1
c2UgbWx4NV9lcV9wb2xsX2lycV9kaXNhYmxlZCgpIGFsd2F5cyByZXR1cm5zDQo+PiB6ZXJvKSwg
d2hpY2ggbWVhbnMgdGhhdCBlaXRoZXIgYSkgbm8gQ1FFIGhhcyBiZWVuIGdlbmVyYXRlZCBieSB0
aGUNCj4+IEhDQSBvciBiKSBhIENRRSBoYXMgYmVlbiBnZW5lcmF0ZWQgYnV0IG5vIGNvcnJlc3Bv
bmRpbmcgRVFFIGhhcyBiZWVuDQo+PiB3cml0dGVuIHRvIHRoZSBFUS4NCj4gDQo+IExvc3QgaW50
ZXJydXB0cy9jcWUgYXJlIGFuIG9ibm94aW91c2x5IGNvbW1vbiBidWcgaW4gdmlydHVhbGl6YXRp
b24NCj4gZW52aXJvbm1lbnRzLiBCZSBzdXJlIHlvdSBhcmUgcnVubmluZyBsYXRlc3QgTklDIGZp
cm13YXJlLiBCZSBzdXJlIHlvdQ0KPiBoYXZlIGFsbCB0aGUgcWVtdS9rdm0gZml4ZXMuDQoNClNv
cnJ5LCBtYXkgYmUgSSBkaWQgbm90IG1lbnRpb24gaXQsIGJ1dCBJIHJ1biBCTSB3aXRoIGEgYnVu
Y2ggb2YgVkZzIGluc3RhbnRpYXRlZC4NCg0KPiBCdXQgeWVzLCBpZiB5b3UgaGl0IHRoZXNlIGJ1
Z3MgdGhlbiB0aGUgUVAgZ2V0cyBlZmZlY3RpdmVseSBzdHVjaw0KPiBmb3JldmVyLg0KPiANCj4g
V2UgZG9uJ3QgaGF2ZSBhIHN0dWNrIFFQIHdhdGNoZG9nIGZvciB0aGUgR01QIFFQLCBJSVJDLiBQ
ZXJoYXBzIHdlDQo+IHNob3VsZCwgYnV0IEknZCBhbHNvIGFyZ3VlIGlmIHlvdSBhcmUgbG9vc2lu
ZyBpbnRlcnJ1cHRzIGZvciBHTVAgUVBzDQo+IHRoZW4geW91ciBWTSBwbGF0Zm9ybSBpcyBzbyBi
cm9rZW4gaXQgd29uJ3Qgc3VjY2VlZCB0byBydW4gbm9ybWFsIFJETUENCj4gYXBwbGljYXRpb25z
IDpcDQoNCk1vc3QgcHJvYmFibHkuIEJ1dCB0aGUgaW50ZW50IG9mIG1seDVlX3R4X3JlcG9ydGVy
X3RpbWVvdXRfcmVjb3ZlcigpIGlzIHRvIHJlY292ZXIsIGJ1dCBpdCBkb2VzIG5vdCBtYW51YWxs
eSBwb2xsIHRoZSBDUS4gV2hhdCBJIG1lYW4sIGlmIHRoZXJlIGFyZSBubyBFUUVzIHRvIHJlY292
ZXIsIGJ1dCB0aGUgQ1EgaXMgbm9uLWVtcHR5LCBzaG91bGQgdGhleSBzb21laG93IGJlIGhhbmRs
ZWQ/DQoNCj4gQXQgdGhlIGVuZCBvZiB0aGUgZGF5IHlvdSBtdXN0IG5vdCBoYXZlIHRoZXNlICJU
WCB0aW1lb3V0IiB0eXBlDQo+IGVycm9ycywgdGhleSBhcmUgdmVyeSB2ZXJ5IHNlcmlvdXMuIFdo
YXRldmVyIGJ1Z3MgY2F1c2UgdGhlbSBtdXN0IGJlDQo+IHNxdWFzaGVkLg0KSSBjYW4gYWdyZWUg
dG8gdGhhdCA6LSkgQnV0LCBsaWZlIGlzIG5vdCBwZXJmZWN0Lg0KDQo+IA0KPj4+PiBUaGUgc3Rh
dGUgbWFjaGluZSBvcg0KPj4+PiByZWZlcmVuY2UgY291bnRpbmcgaXMgbGlrZWx5IHdhaXRpbmcg
Zm9yIHRoZSBjb21wbGV0aW9uLCBzbyBpdCBrbm93cw0KPj4+PiB0aGF0IEhXIGlzIGRvbmUgdHJ5
aW5nIHRvIGFjY2VzcyB0aGUgYnVmZmVyLg0KPj4+IA0KPj4+IFRoYXQgZG9lcyBtYWtlIHNlbnNl
LCBpdCBoYXMgdG8gaW1tZWRpYXRlbHkgdHJpZ2dlciB0aGUgY29tcGxldGlvbiB0bw0KPj4+IGJl
IGFjY3VyYXRlLiBBIGJldHRlciB0ZXN0IHdvdWxkIGJlIHRvIHRydW5jYXRlIHRoZSBtYWQgb3Ig
c29tZXRoaW5nDQo+Pj4gc28gaXQgY2FuJ3QgYmUgcngnZA0KPj4gDQo+PiBBcyBhcmd1ZWQgYWJv
dmUsIEkgdGhpbmsgbXkgcmVwcm9kdWNlciBoYWNrIGlzIHNvdW5kIGFuZCB0byB0aGUgcG9pbnQu
DQo+IA0KPiBOb3QgcXVpdGUsIHlvdSBhcmUganVzdCBsb29zaW5nIENRRXMuIFdlIHNob3VsZCBu
ZXZlciBsb29zZSBhIENRRS4NCj4gDQo+IFllcyBwZXJoYXBzIHlvdXIgUVAgY2FuIGJlY29tZSBw
ZXJtYW5lbnRseSBzdHVjaywgYW5kIHRoYXQncyBiYWQuIEJ1dA0KPiB0aGUgZml4IGlzIHRvIGRl
dGVjdCB0aGUgc3R1Y2sgUVAsIHB1c2ggaXQgdGhyb3VnaCB0byBlcnJvciBhbmQgZHJhaW4NCj4g
aXQgZ2VuZXJhdGluZyBhbGwgdGhlIGVyciBDUXMgd2l0aG91dCBhbnkgbG9zcy4NCg0KSW4gbXkg
b3BpbmlvbiwgaXQgaXMgbm90IGEgUVAgdGhhdCBpcyBzdHVjay4gSXQgaXMgdGhlIFZGLiBJIGhh
ZCBhbiBleGFtcGxlIGFib3ZlIHdoZXJlIEkgcmFuIGludG8gdGhpcyBpc3N1ZSAodXNpbmcgUkRT
KSwgYnV0IGNyZWF0aW5nIGEgY29ubmVjdGlvbiBmcm9tIHVzZXItc3BhY2UgdXNpbmcgaWJfc2Vu
ZF9idywgdGhlIG5ld2x5IGNyZWF0ZWQgY21faWQgYWxzbyBnb3Qgc3R1Y2ssIHByZXN1bWFibGUg
ZHVlIHRvIHRoZSBsYWNrIG9mIENRRSwgRVFFLCBvciBpbnRlcnJ1cHQuDQoNCj4gVG8gYmV0dGVy
IG1vZGVsIHdoYXQgeW91IGFyZSBzZWVpbmcgeW91IHdhbnQgdG8gZG8gc29tZXRoaW5nIGxpa2UN
Cj4gcmFuZG9tbHkgZHJvcCB0aGUgR01QIFFQIGRvb3JiZWxsIHJpbmcsIHRoYXQgd2lsbCBjYXVz
ZSB0aGUgUVAgdG8gZ2V0DQo+IHN0dWNrIHNpbWlsYXIgdG8gYSBsb3N0IGludGVycnVwdC9ldGMu
DQoNCg0KV2VsbCwgSSBzdGFydGVkIG9mZiB0aGlzIHRocmVhZCB0aGlua2luZyBhIGNtX2RlcmVm
X2lkKCkgd2FzIG1pc3Npbmcgc29tZXdoZXJlLCBidXQgbm93IEkgYW0gbW9yZSBpbmNsaW5lZCB0
byB0aGluayBhcyB5b3UgZG8sIHRoaXMgaXMgYW4gdW5yZWNvdmVyYWJsZSBzaXR1YXRpb24sIGFu
ZCBJIHNob3VsZCB3b3JrIHdpdGggTlZJRElBIHRvIGZpeCBpdC4NCg0KDQpUaHhzLCBIw6Vrb24N
Cg0KDQo=

