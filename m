Return-Path: <linux-rdma+bounces-13109-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87336B4541C
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 12:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B211CC0D6B
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 10:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EB52C1580;
	Fri,  5 Sep 2025 10:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iuqVRVy2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Uu/XzWW0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586242C028F;
	Fri,  5 Sep 2025 10:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757066762; cv=fail; b=mm9SsLVZ3/LY0FgQ/mm7JdOUvbxD47NEucFtV4d62en7qS8wlrIJyheHUF4ByvzGAUMGwQ/rGkhCrWeQnU8ovX4qYKLnnXu/f+Qa1GvKs4UkCSQKHeYWlmw1lVfdIcyKXzSbaP1pbWUwGweqs2El67Uqnj47smQ73Ngpu/4pBVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757066762; c=relaxed/simple;
	bh=7GTBtbBd47cQIyfoTp8BCe3mzfRrurbnt2ff8Zz/lQs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oNu0qKNXdOFUwY3TfTqAqfxMyqvk0132inE19eWwuwoSzi7K6SFI7okhnbgp2oyFUo+BMMSbFYEj8jZRKS2Z0lFwqZQPbhK1ehXt62LBiXF3dqOIHD9XNJCyBzLbYp5w+6GImSBIzmIHc5ypjICwZSgIbgpyMlD1xUi5wOBboUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iuqVRVy2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Uu/XzWW0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5859nf6V003994;
	Fri, 5 Sep 2025 10:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=7GTBtbBd47cQIyfoTp8BCe3mzfRrurbnt2ff8Zz/lQs=; b=
	iuqVRVy2KuVjvLuJNkSa5r/4HZG2lfxDxRldOTjxq1gWKtiDWp+NmMMefqvgQFTx
	PClnICK5E5AwcKyK8rFL7tRov7sq/E10edOCXlH2DW+YehpXOODSAoA16xpGKIxk
	iWPAqLmXPWnkUBTTSc6dHTwRpYQQkzNRyjAuvG746fruLwMmXfvQtB5CDgCFkhGn
	QSPeKWaH2y6Gk1Jw6OSduOneumqr/9Ph7f8UN5ReX1+UAjCT1/uXEK5CE37D3wvM
	hckSRf8vP/npydAqtMC6DtcqLtsgbX9BwRTfAgvji0ChdwMFwb/3EYGBlGwWmAiZ
	xXSx3vLSQ181XPO8NwzW5g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ywjq80vp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 10:05:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5859Ja2v019611;
	Fri, 5 Sep 2025 10:05:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrcp0r8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 10:05:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5WEDEYMDYYbVlrJJ9TvSpV7F2ztwPm5CFTOlnDMPc+Zm1f45fOIHcJ40JsjIvtjujFHgzErXEN3fqzChtAp0vOzCiTF+VMslDmsfjVYy2V56EH79TUNOn9lb4qGScMkS1Dgf4t7uNWWhQE9QglCJLS25Tic7JiMHDztg7Anz0ukddtjRAnu94X3zD/MDY+weKagfKrucH56kLtwhQ+sUrxFCNTttjfFkRZMOkiChwxsyzcN2dnqs4pI885VhhG2kXHcXQMwI+Tjsse5wHY3RCeKYofe/pbC2rREfoCF5xHWzU7Lt5XTbDrEW9fBhAYiwWtnal3rO6ser/BEqVdmGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GTBtbBd47cQIyfoTp8BCe3mzfRrurbnt2ff8Zz/lQs=;
 b=EiTUxvN0r+KVfHqm/3yk1kjNdIPG8CSyosdUrFsbPIa/Bb/USyqbs3k78U62vo5yZghbJ7/bXHKNGRlpi1acICnmHaD+AhAVEf2fVVbONnddccjFWjpbFWErmQM1LZTXlGKFkWCCTASNByXxjo7sg7suoeWeW3BS12ksikBv6kG3WCd7OtfSsUe8KmAsBsANCTr7ZvJuoQNxCYKIGUwvlh1fdZagR+jBgLhQKOlmBy+EsUzYWYdaTBdS5CWIuuluQQN0evnw0iWXwQYUzzlMr+ZR9wW6FxaEdhVH/UK4tXF3pBnyYY50XwAd9aOhK2sIQba5GaIVhLXdRKqIXEtP9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GTBtbBd47cQIyfoTp8BCe3mzfRrurbnt2ff8Zz/lQs=;
 b=Uu/XzWW0vUPo4/PfDO8E4gb0OesmhLBe+9mgqACdgVE1OB0n0zoAOQA9R9pJtsTfBQm3ady9GGEdoMUrTXukyFJbkWxZ6vFDfBIgHCXdwU9q23GE5Xx3wlFODLN8I1UfLgZyGHXN28UmQ+O7wvah04synfrk+6Ly8gOPS9xV888=
Received: from CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13)
 by IA1PR10MB7165.namprd10.prod.outlook.com (2603:10b6:208:3fd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 10:05:50 +0000
Received: from CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::b3df:777f:7515:d04f]) by CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::b3df:777f:7515:d04f%3]) with mapi id 15.20.9094.018; Fri, 5 Sep 2025
 10:05:49 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Allison Henderson <allison.henderson@oracle.com>
CC: "horms@kernel.org" <horms@kernel.org>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        OFED mailing list
	<linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3] rds: ib: Remove unused extern definition
Thread-Topic: [PATCH net-next v3] rds: ib: Remove unused extern definition
Thread-Index: AQHcHazClK/zOwHYak2p9OkHJRkForSDn1+AgAC+ioA=
Date: Fri, 5 Sep 2025 10:05:49 +0000
Message-ID: <2AEDD90C-A0B6-4207-9C93-8C618AFB8EB7@oracle.com>
References: <20250904150105.3954918-1-haakon.bugge@oracle.com>
 <4fa2f7bd9f9fd0d908e6a5ffee19bfd7dc6bde1b.camel@oracle.com>
In-Reply-To: <4fa2f7bd9f9fd0d908e6a5ffee19bfd7dc6bde1b.camel@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6826:EE_|IA1PR10MB7165:EE_
x-ms-office365-filtering-correlation-id: c061f1d4-d27c-47ab-2685-08ddec63ca76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?M0djWEdVTkEwZ0pTQTdBMkxOTGZSWFFFOGY2eWF2VExzSHVZaFhIUUVZNkdi?=
 =?utf-8?B?czJJWXcrQUFmaWoxVGZFYko3amJobVN3WU5hNHJGMVJKWmllcE1ETTRHNkZY?=
 =?utf-8?B?TVlkbDVFSk5LcFcrVXV6Y09LakZTTDYvM3o2RjE3WFpWZUlBZFlVVzdOeEVS?=
 =?utf-8?B?RzZOSE9UMVk3U3ZvRCtEb2VvQ1MyUmV4aUJJL3dlbUhnZG1ZZkF3bDk3eFk3?=
 =?utf-8?B?SlFFbFNDR2tmRlVWUUJ4S1YvUXRkUGorQnR2L0lNN3dkbHRDNUFqT1crUGxH?=
 =?utf-8?B?d1dJUVJVbU16eTYrbUVkbHVJZDF2RWxBaTBFZXl4Qmp0SW5xOGp5VFhvbkUx?=
 =?utf-8?B?cXJoRlBlU1ZVRVdVSkRnRTNEbmRZTnNPR2RHaFlqWmFFU25mOEIzTWtsd1BC?=
 =?utf-8?B?TnFIZFRzQzJFRDdsZHc5MkxLR0RidkFQdWlHcitkOHNOUmVXWjJZQnpqVFF3?=
 =?utf-8?B?ODF3WTdPMEF2VXpaU09yZklSUjMrUTBsR0R3U2JsR0dkaFVJTTBhR1RhNmlF?=
 =?utf-8?B?TVU2TmNUSFVnaGxxSVhZSmZyUHI5c24rNjhWSFNQL1Y1S3E1bTVubTh6RjNT?=
 =?utf-8?B?RWlza0ZyMEJQRmIvT2RNV3VqZkEvSm1nZiswK3QxNEdkcGFESGFWYlRjZlBx?=
 =?utf-8?B?KzhGV2ZzU01VSjE2NllMTndzYksvbmI1blpGY0NpTEltZ1Y4YU1RUU1oMjVr?=
 =?utf-8?B?c2lQeGNibVEyWFE5UFdQdnFzZHVqK1B0YWZ2bVhxUVdwLzRCa0oyNW5PalN3?=
 =?utf-8?B?ZFFKWE5NY0drL2l6eGMyOEhlYnRQcTNmY3UvM3V3TzV4cldyNWJYZXVwQ3hh?=
 =?utf-8?B?VnU0YnZlWU5xMFF3TkFjUGJXa2dxOVVkNzgzc0lwQ2p1S1BycTc0YTh0YUpG?=
 =?utf-8?B?MU84dzV1SnJyMGFuZW1UbzJPZnB3Lzd2cDQ1MEZoeUNPUGpOeGQ3VEpiZVJi?=
 =?utf-8?B?Tnlzay9zUkpHb0dsbkRyM1Zsbnl6c0N0aWhaMVdUcWhCNnYyRTY5TDlxbVVp?=
 =?utf-8?B?dHRPSzZkUDVUanY2K0xnUWcwYWRPZ0F6V2JpbUY2ZmY2SUNMeVY4NzJZenBy?=
 =?utf-8?B?SGQ2cEprN3FnM3NqUllCc1ZrWHJuM3prZThnMnF5V1JNZGpUekpGNkhya1dH?=
 =?utf-8?B?dzM0ZW01WnVmaFVsWm9CQUJzTG1WTDBVNExidFh0Sk55MEd1UGpzc1pOc0Ra?=
 =?utf-8?B?UlZjRGdnODUvN3NGdkx4RnppMUgrRXlkUk5ackMvTTZqQndPZEVkb2FST1Yv?=
 =?utf-8?B?SmZvMHFLSU1MVGFMa0RobnZsYUcrb2NDRnNpM2tWaHdPOGU5Q1pIN0JwdEtC?=
 =?utf-8?B?R1JZMmxyZTBPMS9FSm5xeVpBaGI0RDg3U2w2QjlvbDBpYStWc3N1STU0OWFR?=
 =?utf-8?B?cDFnUTFQeGhwWWdKYnFmRGhmVlV0RFZTT1EwZ0dGanB0UjEzZnYvQSsxeWFV?=
 =?utf-8?B?VzhYV21jYWdoS3o2bTU0WDMxMGswQXU4YUpXTU5tRlhtT3g1VFUxeDFSdVJI?=
 =?utf-8?B?ekpaaFRVR1ZyczdQNDV3TlI4Z012V3Q2Z1BFLzNtWkRpSzdrSUhNblduZndt?=
 =?utf-8?B?WitESkQvYWxWZy9jRjhYNndFNWkyeDhiN2F1VVVoSU5EKzNpempEaXYxR0ZJ?=
 =?utf-8?B?UmpCcm0yTVNyWGRnV0N0ZnQ1T3pFTjJSMTBTcnVsdUhBYThnMkQ4Nnlvd1RO?=
 =?utf-8?B?dWp0U0lRV3d3RE5GMjJJbjIvNmJHWXV1Mjc2SDIxR3lvWm1Dd3BmbXhESW45?=
 =?utf-8?B?ZExQa0Z2QWIyaElzdEVoTmlJK3BLZXk5cXFuRXFPUUFva01NNHJjY2NmTnlu?=
 =?utf-8?B?dzBTeW5IcDcwSzRTTW5adE9wNkltTzFuMHgyQmFyZUoxVkgxN21Vb2JRaGN4?=
 =?utf-8?B?cDIyK1VSS2IwNitBMVhFWElReklwbVIzV1ExZHhBM2I5eFNIb3k1Ulg5Q0dL?=
 =?utf-8?B?a0ZrdjE2blpyL0RWdEtkTnNoZGxQM1JsTU0rOFJHQUN2OHFmcHZIMThxeGhV?=
 =?utf-8?B?OGw4R05ObGN3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6826.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dXUya3hVR0ZEcTBnYnRTZ25RQjZxWmJYVGQ2Nk43eDgzaitjcXcvSjJFRXhQ?=
 =?utf-8?B?YXVCNjZIb0UvMytxYWhtRVVpZjhiK3MvZmNHZ1hRVzNpVmRzUk56My9lZmll?=
 =?utf-8?B?Rkd2WEFTVm5XWFBWSWt4R2dRZzJueHI5QXVwYWNuMlYyV1p6RDdvM3ZEM3RP?=
 =?utf-8?B?MWE1cnRmQnZrR2pGdFkvWXlpN05HRzFRRzUrb3Rvb2JpeUlHb25jRGVsTVpM?=
 =?utf-8?B?SW1NL3RFQitacWFGUDZnVVFDampoQ0YrSVNudkdXcUZweER0TEZoZ0RxNnNN?=
 =?utf-8?B?OWZSZUlDbUJNS1REbWUrckpTTE05UFUyNjN2VFM2MzdwRGdRMzJFTC9YZGZD?=
 =?utf-8?B?QU9iMmVmZTVmVndrbnBqRCtYQmI0Z01jZWxRVHlMZlM3VnpGMHl6cmFZd3dQ?=
 =?utf-8?B?RUFZd05kRDhWLzRlTFJ1QVArODJDdndJZ05obDJPYzBqVlh1M2ZsZ2xDUi9G?=
 =?utf-8?B?MFZjV3N5VjBNN2NPS05VcGc4VVl0UDFtM054T3R0OHV4bzN6Rkh4eDE5Um1D?=
 =?utf-8?B?L0ZuQndNUkEvZGsyMXVUSFpZZTI5Rkk5SXJjS1BYNkJKTURHMmtsM3dzdGZL?=
 =?utf-8?B?VHpzYWJ1R2J2Y0p0R2lMQlJmeW8wTExYNThKMGhlMUoyRnc1bUdJVUJPTW4y?=
 =?utf-8?B?enBiQ2pDZFZiNTdTT0ZIK0dxakNrOWlac0dsRDFzTHQzd2pCS2tvWGVVRTQr?=
 =?utf-8?B?L1VrUVh6SVNIcDJJNVRKYVNZb2tnTHdZTjcwYWUrOGthRWFoRTJVbUJENVhS?=
 =?utf-8?B?cTNjNnpXOUExcmoxQkxsRG9hMFNTUUFLSS9aaHM1bDJjQnJuMjROMUZ6TVlE?=
 =?utf-8?B?cE5DdjZsbkJYMTlndFI1Z2Q3RjJRakcwMGhDSXFleUtBSVhkS3h0NThGSms2?=
 =?utf-8?B?OEhoVDdNZFBISHo4N0YvV2JYT2x1RTlBQU03ejhEZkMwUmJ6bzNBbktEcW9r?=
 =?utf-8?B?Q1c0VjJFNkp4RXRPeWc1MmNsQmVZWkJLQnMvM3Jxc3ptTFdRZDI5c2lpdC9q?=
 =?utf-8?B?YTlOVS9xa20zNmZWY1pMK1ZhbW9YRHg1UFY2Q1pVUDBoMFRoMDBtMEpiZUtR?=
 =?utf-8?B?alIvQzdoM0NhcldvYjNPdCs5M0xmdFpKQk9LUjMwOTdrUVZPU3ZTQ29CaVVH?=
 =?utf-8?B?NGp0RmZUUHNtczlRUFJ6d2cySVlmMEloVjNlRG9EVWdzUS9YZm5UdTJVNnp3?=
 =?utf-8?B?VCtiaVh3YU9hQVo4RDVHLzNQcUw1K3cySFByZHRTclU5Y1kvcjhwOEpDeGNp?=
 =?utf-8?B?RWxYQk5vSnBCNjdJMUZvZXZZOVpWR2VmYS9QN0phNjN2K1ZaNXdPNjBIaDRT?=
 =?utf-8?B?VXR1L09BRzNHRXdKRVQvRnhEZ29lSUtSN1pwMndTMExHcWl1aXRTRkpIY1oz?=
 =?utf-8?B?dWRLNWZnTGFHcGdmUkVTRk1tL0JHekNJUGNDU2EvM2I4UnlwaE5Na1NhcEZE?=
 =?utf-8?B?a2dQb2lqRk51c216M1NYYVVSMmtMR0Yvejk0eEYvWU1iOU9SbHRwL29Jb3Vj?=
 =?utf-8?B?NnFxS0hJcHRJWGIyZlFuOGJZdUluaTdzTHJCR2sxNytFTGFCZFI3MlBXVlQr?=
 =?utf-8?B?bFA1Mkt0SlpZOWlNV1hRKzRPRWdEdzBhRndxOGdveEg5Zi9yamJ1elVxLzFx?=
 =?utf-8?B?NWxxM0gzZ1BJallSTGNoUWpEMXhhVUZBRzR5K01rUEludVlKa01za0xobytv?=
 =?utf-8?B?KzNYdlZiS0FNbENUSVp0ZzZWdEFwVHlVdTJBcUhEb0VwVkdtMW9ZUUtWaGVK?=
 =?utf-8?B?OXRtQW55bnQ0dWJrcmgrNzhLZENxcnZuNHNsNytFNnVBUU9MMjRmSzZPSDNT?=
 =?utf-8?B?WFM4YmErM0JWWGJmOEhiWVhzUUpkR1FzaGR4Zzc0TDdqd2lFUjBlTFo3S3B6?=
 =?utf-8?B?TjU4RkUyMlM4Tmh2Z3MwNithVFlXZFI5QXEyOWM1YTBmclV2MUcxQXNka0NO?=
 =?utf-8?B?MDZUbUNUUjZTa2VPWVpFNm1OQWRsVGE3Q2dGMzdYanFtZ0gxUThwRGVQdXV6?=
 =?utf-8?B?SnkxZmJaMUVVMHU2OGFhYmo3K0VrQU5iZFBCRm1ucW5WWFZ2VUJiK2JzWkNh?=
 =?utf-8?B?Z1ZQMXA3UVo1MWR0UlBZMlVKZWU1VWZUWmxGTEJMTU13Z0JTVlhzUjhOVFhX?=
 =?utf-8?B?L1VHY01aRjlReFdxM2RQM3U2RFVRRVRwWFIweE9sVVAvNEtwTWtnOWRiNjF0?=
 =?utf-8?B?WHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <071CD3466AD4184ABFC2C2ED8DAE8EAA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+nEBO9s5rD2F0VI5iXy3129C/CNjkw0M3VPaxHiZrKe8Ean0ZfvPNjNk/7AiI4xqdekNYImAjX/TxQQdffTRMT8y6yHsrzEsNtOT6I+ZsYY2NZEAe78e9Ui6v1yqCAbe1Rpetz+C1QLrSgrzKt0K+DTQItZlrKXSiJPE1jlUOHYjZLUb6UJBMx16fs8M45tLDnhuq2TH4acNOGREkSFnd2J5gzrcZFK6dpVibFfofIdjnl18Ld6P/0wb5YrPtOx8v2OyyJCw67jhRruuIiJDUnsOnamk//um3UbndvZ+Xc/74GiJGLzz2BEX/JHgUVOvAjy9JSKpRa3ySXnttmVO9H5AxQFuZyhioR/fh7HhMT0hN10XHsqwvGNXAeDtZojHtsqD94SIEsjSSUEKwzc7129c0YXeYiiwJCpjNGYJrm2rGc5ADHCbN67Xfy3/q5mtOy2ChVlGW9HI+7z+mj8eebSmlfpb6TB8E4D6OvKT9GpUSIP+i8pVAFerRh3vPD6cfCDcoA+PzEh5WB3SDV5BT6YcFKamV4aZxfhBb8n5UP7lhMD35zwWy8k+YCs2+TsFRflWkHkdFTyH+PQXUtPAVYaROixU2FhadjfZWdrt1cQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6826.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c061f1d4-d27c-47ab-2685-08ddec63ca76
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2025 10:05:49.8962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CSggHW75QAWH0rBO514hZv+5HBL1vRCNQu1fAArkPRzPO7jS7rq3ChAsURkxxi5zeKTpjz1qyjoZU/xqGbWmew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7165
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_02,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509050098
X-Proofpoint-ORIG-GUID: o_2m-laegVQazn-iz-j9Jw_QylJBa0e9
X-Authority-Analysis: v=2.4 cv=CsO/cm4D c=1 sm=1 tr=0 ts=68bab602 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=fgGtKj8EE0Ad4iayoX4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: o_2m-laegVQazn-iz-j9Jw_QylJBa0e9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDA5NCBTYWx0ZWRfX3yohalXZa6CL
 Hq0AzNAqMPQqIdIaMbEjrsQ0E5mwg1SdmwzdZsC1PUc+i2rSp/UAGuJckxycTw+tEzBnYKbA99w
 uv1ibVgRn3AIV9IzvxoRWlz4b5/RnSOJUoHUVsGx00cyflf4zx7Qm789yTXwMrpLaqDZ4wm5AnY
 zTkPZkp38WCWL2kwudVrw//H73lFKCq/T60FYRIUDcPEXkzov9M4MWRix9iDmUUKnKVWayAKfGQ
 c2yAhReZY7KT/8NOD57nhOd9z/A2Kc2kU31+DCXcILWsTtDiNd+9u/rzHqr/vmbYtXoXmOUZhby
 vskyCG3y+w5SejXpUSo6BcuJiVjkrqkFtg8oCfmq9TpufpCGEi9T9asuCmXgZV1txmSWRXDsVYh
 nYeX63qj

DQoNCj4gT24gNSBTZXAgMjAyNSwgYXQgMDA6NDMsIEFsbGlzb24gSGVuZGVyc29uIDxhbGxpc29u
LmhlbmRlcnNvbkBvcmFjbGUuY29tPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgMjAyNS0wOS0wNCBh
dCAxNzowMSArMDIwMCwgSMOla29uIEJ1Z2dlIHdyb3RlOg0KPj4gSW4gdGhlIG9sZCBkYXlzLCBS
RFMgdXNlZCBGTVIgKEZhc3QgTWVtb3J5IFJlZ2lzdHJhdGlvbikgdG8gcmVnaXN0ZXINCj4+IElC
IE1ScyB0byBiZSB1c2VkIGJ5IFJETUEuIEEgbmV3ZXIgYW5kIGJldHRlciB2ZXJicyBiYXNlZA0K
Pj4gcmVnaXN0cmF0aW9uL2RlLXJlZ2lzdHJhdGlvbiBtZXRob2QgY2FsbGVkIEZSV1IgKEZhc3Qg
UmVnaXN0cmF0aW9uDQo+PiBXb3JrIFJlcXVlc3QpIHdhcyBhZGRlZCB0byBSRFMgYnkgY29tbWl0
IDE2NTkxODVmYjRkMCAoIlJEUzogSUI6DQo+PiBTdXBwb3J0IEZhc3RyZWcgTVIgKEZSTVIpIG1l
bW9yeSByZWdpc3RyYXRpb24gbW9kZSIpIGluIDIwMTYuDQo+PiANCj4+IERldGVjdGlvbiBhbmQg
ZW5hYmxlbWVudCBvZiBGUldSIHdhcyBkb25lIGluIGNvbW1pdCAyY2IyOTEyZDY1NjMNCj4+ICgi
UkRTOiBJQjogYWRkIEZhc3RyZWcgTVIgKEZSTVIpIGRldGVjdGlvbiBzdXBwb3J0IikuIEJ1dCBz
YWlkIGNvbW1pdA0KPj4gYWRkZWQgYW4gZXh0ZXJuIGJvb2wgcHJlZmVyX2ZybXIsIHdoaWNoIHdh
cyBub3QgdXNlZCBieSBzYWlkIGNvbW1pdCAtDQo+PiBub3IgdXNlZCBieSBsYXRlciBjb21taXRz
LiBIZW5jZSwgcmVtb3ZlIGl0Lg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBIw6Vrb24gQnVnZ2Ug
PGhhYWtvbi5idWdnZUBvcmFjbGUuY29tPg0KPj4gDQo+PiAtLS0NCj4gSGkgSMOla29uLA0KPiAN
Cj4gSnVzdCBvbmUgbml0IHdpdGggdGhlIGNoYW5nZSBsb2cgaW5kZW50YXRpb24gaGVyZS4gIFZl
cnNpb24gbnVtYmVyaW5nIGlzIHR5cGljYWxseSBsZWZ0LWFsaWduZWQsIHVubGVzcyB5b3UgbWVh
bnQgdG8NCj4gaGF2ZSBhIGhlYWRlciBvZiBzb3J0cyB0byBqdXN0aWZ5IHRoZSBsZXZlbCBpbmRl
bnRhdGlvbi4gIE90aGVyd2lzZSBqdXN0IGJyaW5nIHRoZSB2MiAtPiB2MzogLyB2MSAtPiB2Mjog
bGluZXMgZmx1c2gNCj4gbGVmdC4NCj4gDQo+IENvbnRlbnQtd2lzZSB0aGlzIHBhdGNoIGxvb2tz
IGZpbmUgdG8gbWUuICBXaXRoIHRoZSBpbmRlbnQgbml0IGZpeGVkLCB5b3UgY2FuIGFkZCBteSBy
dmI6DQo+IFJldmlld2VkLWJ5OiBBbGxpc29uIEhlbmRlcnNvbiA8YWxsaXNvbi5oZW5kZXJzb25A
b3JhY2xlLmNvbT4NCkhpIEFsbGlzb24sDQoNCg0KV2lsbCBkby4gQnV0LCBhcyB5b3Uga25vdywg
d2hhdCBjb21lcyBhZnRlciB0aGUgIi0tLSIgbGluZSBnZXRzIHN0cmlwcGVkIG9mZiB3aGVuIHRo
ZSBwYXRjaCBpcyBhcHBsaWVkIGFueXdheS4NCg0KDQpUaHhzLCBIw6Vrb24NCg0KPiANCj4gVGhh
bmsgeW91IQ0KPiANCj4gQWxsaXNvbg0KPiANCj4+IA0KPj4gdjIgLT4gdjM6DQo+PiAgICAgICog
QXMgcGVyIEpha3ViJ3MgcmVxdWVzdCwgcmVtb3ZlZCBDYzogYW5kIEZpeGVzOiB0YWdzDQo+PiAg
ICAgICogU3ViamVjdCB0byBuZXQtbmV4dCAoaW5zdGVhZCBvZiBuZXQpDQo+PiANCj4+IHYxIC0+
IHYyOg0KPj4gICAgICAqIEFkZGVkIGNvbW1pdCBtZXNzYWdlDQo+PiAgICAgICogQWRkZWQgQ2M6
IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4+IC0tLQ0KPj4gbmV0L3Jkcy9pYl9tci5oIHwgMSAt
DQo+PiAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEv
bmV0L3Jkcy9pYl9tci5oIGIvbmV0L3Jkcy9pYl9tci5oDQo+PiBpbmRleCBlYTVlOWFlZTQ5NTll
Li41ODg0ZGU4YzZmNDViIDEwMDY0NA0KPj4gLS0tIGEvbmV0L3Jkcy9pYl9tci5oDQo+PiArKysg
Yi9uZXQvcmRzL2liX21yLmgNCj4+IEBAIC0xMDgsNyArMTA4LDYgQEAgc3RydWN0IHJkc19pYl9t
cl9wb29sIHsNCj4+IH07DQo+PiANCj4+IGV4dGVybiBzdHJ1Y3Qgd29ya3F1ZXVlX3N0cnVjdCAq
cmRzX2liX21yX3dxOw0KPj4gLWV4dGVybiBib29sIHByZWZlcl9mcm1yOw0KPj4gDQo+PiBzdHJ1
Y3QgcmRzX2liX21yX3Bvb2wgKnJkc19pYl9jcmVhdGVfbXJfcG9vbChzdHJ1Y3QgcmRzX2liX2Rl
dmljZSAqcmRzX2RldiwNCj4+ICAgICBpbnQgbnBhZ2VzKTsNCg0K

