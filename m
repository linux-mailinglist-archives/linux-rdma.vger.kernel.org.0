Return-Path: <linux-rdma+bounces-20369-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJ6CMkKMAWp4dQEAu9opvQ
	(envelope-from <linux-rdma+bounces-20369-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 09:58:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 43303509B1C
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 09:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1AC83304A666
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 07:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1FE3AC0CB;
	Mon, 11 May 2026 07:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d83p24yY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n3DrScuU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3024B3A9625;
	Mon, 11 May 2026 07:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485852; cv=fail; b=W+kIPzC2Hygg8Tkxk2R5C6FbZegnv6KVED2vYSn9sBlnAEuyUB10UOIvC8OSbHiI1s1tFFGJXwD+G9iilwX58VsfWc/7bJaa1PIH90WyII1AVITI9KUIGi8Pm8OWocLtEGI3azNouZ6gVJdpvSClZ2tMyrQSNPSetj3y2dpg/H8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485852; c=relaxed/simple;
	bh=wsKqT+si2AfMaZuhxAyr2WSkVRNMYNYplCI0NxJbBNU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WMqzW6J6+VBjYXwBSnU23sQWaZ+TI8S2k79uk8MYNImFTTShQbNKThBDoTTRLclkFZI8MJ6jeExHDpJSjiuz2sHozp24eTZ1a+LsQPQKSGqcF3LHmKuzkXFeIIwcoa6qjqumZfJjaTFp7mq6SWoWBRRlJEmR6H73pjTlMQzofHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d83p24yY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n3DrScuU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B1DN3B114417;
	Mon, 11 May 2026 07:50:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wsKqT+si2AfMaZuhxAyr2WSkVRNMYNYplCI0NxJbBNU=; b=
	d83p24yYSfaksg9VM1c/ZHyVM9ZxLWZ1c/gYO33wbwQutuSHR3gB2oESf9Rxa+Zt
	W5CPY4HhGY3GZEVkA6yggEKF3QWQ9dkT5rBjjf3/AcBuLcgwe2qkQDp7TN87pXfe
	rj9l3Ypa7eAYIC8kmqCheIKR+hIvPQIiHFg5Yp57OL0lcU9yWvtLLeeGYc2ED2UD
	Rc0ispe+KRzAo4NxUahh4T/I+xdu9Y2nFaBO2683clyaacJ1ZwVlxTl2yLe+vIhk
	iJbOPcFE13h26f+y20MJEjdMVgrzyQzESr68muG3StMiI4ZcHf2St47ez25oBxpV
	v4m5xTrlbazXh9Tvq861RQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e1ugy24v0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 07:50:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64B7kHXb003315;
	Mon, 11 May 2026 07:50:23 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011031.outbound.protection.outlook.com [52.101.62.31])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4e1uc8vw21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 07:50:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aA4A2i0284pEj6COrtShsD16XltAxbkhx6TLYhl4NYHfcLAkHld9vKJYztlIwT0U+p41iDdvciuVmoIbk8gaTN6JxlBHEf+6XBtqAJIUQGjnZzNXB6CDfhmRGVjRPM3hXUNVKB0Zb0qm4GNq8bCKO4nXgHrIzsFHx90jH3Pbhtj1Hv2udKpy2YUAI3IvQ17SxYWVJKYYyGGWS6Z4XSmBZFhfbCjz6UY1UW6vwjNt5JaM9HVkVulZWjoXnoEYvVFyXmtZ7U33pSO17Zkqqii2Dft/1YySWIraKQGnfVhVsGtw01W6uHMAg/0vUtyq34I+SSxGFXUtBCllgtpGXMDQdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsKqT+si2AfMaZuhxAyr2WSkVRNMYNYplCI0NxJbBNU=;
 b=w+DmclRppliqPGwW78HUPZ0bZIcGNGhLIZOANxE2Lpt/G47Ztth2NsBRSPNrhx6FkA5/8NlEW+oFKtdEsZrfr7X6XfWtOm3v4tmr4IH2ZISCF5KKUjqEz0Ac/yuKRudGWq/aGiil0Mzvw0Pe/0C1/9fQv70pqxdVoATWrSlYO/wSvHW6K+6v/LoO8nruPzXL6GNzQaJK8+mXETE/f+2DG3/yR5i4jOWzSZlfYx4obT4Dsv9F8/ZnzW9StAbJVOOstqL023ZxPWw8yKVHwPP/13b0AfKRLtWv7n4VdP7Ocz38n3P5NZfKShEGqqbkf2HoJ9Iop7eRYPZhr0/zP87jYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsKqT+si2AfMaZuhxAyr2WSkVRNMYNYplCI0NxJbBNU=;
 b=n3DrScuUey3MZ9mRRB08Myf+buLkXW9EYaX05aEeNkXAZUCB6uf1rhjrvfHzabQoR+e3bdtk6wH6pcIA4zF0halAWkqoQ7hFjhZX11viSXs0AYl9CREmiii8IoQfr41kfwYmKyB00eDYc8MQAJTc+V27601fFjld1rX8rqg59P8=
Received: from BL0PR10MB2820.namprd10.prod.outlook.com (2603:10b6:208:75::10)
 by SA1PR10MB6414.namprd10.prod.outlook.com (2603:10b6:806:259::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 07:50:19 +0000
Received: from BL0PR10MB2820.namprd10.prod.outlook.com
 ([fe80::e0d8:3402:3fa7:260]) by BL0PR10MB2820.namprd10.prod.outlook.com
 ([fe80::e0d8:3402:3fa7:260%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 07:50:19 +0000
From: Praveen Kannoju <praveen.kannoju@oracle.com>
To: Praveen Kannoju <praveen.kannoju@oracle.com>,
        "yishaih@nvidia.com"
	<yishaih@nvidia.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Anand Khoje <anand.a.khoje@oracle.com>,
        Manjunath Patil
	<manjunath.b.patil@oracle.com>
Subject: RE: [PATCH] IB/mlx4: Fix stale CM id_map entries when RTU is never
 received
Thread-Topic: [PATCH] IB/mlx4: Fix stale CM id_map entries when RTU is never
 received
Thread-Index: AQHc3jjr0HhjpKMY+0mdP4xVBrW4SLYIeQIA
Date: Mon, 11 May 2026 07:50:19 +0000
Message-ID:
 <BL0PR10MB28209127234479EFBBB1ADA18C382@BL0PR10MB2820.namprd10.prod.outlook.com>
References: <20260507154755.452008-1-praveen.kannoju@oracle.com>
In-Reply-To: <20260507154755.452008-1-praveen.kannoju@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Enabled=True;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_SiteId=4e2c6054-71cb-48f1-bd6c-3a9705aca71b;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_SetDate=2026-05-11T07:49:42.0000000Z;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Name=Restricted-Including
 External
 Recipients;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_ContentBits=3;MSIP_Label_94b7886c-3e74-443c-a58e-890de065ec46_Method=Standard
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR10MB2820:EE_|SA1PR10MB6414:EE_
x-ms-office365-filtering-correlation-id: 1b66586c-fcb7-426b-2a79-08deaf31f2b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|38070700021|56012099003;
x-microsoft-antispam-message-info:
 3ZeF3LHlw5ssymTlN2JGUePR67v4xy8icHUZAhQ+4aWkPkAEPgBgU80VaaYlm91/DC1768mvlab8CKp2Up+ZaL0xqmu5IFJtp+vecWs7z8ldFPTaDRmE+Rr4AC14Rj0wcqlQledV9tGIfSXgu8TfbpNLDBC+Te26valYECkgvxU/WWHBkIl/VBiuit/2T00dy9AttJlTk5jmG+FKjIWMVgb8OImKoDXfzBiGkd0iRJ38YiCthkcmHmVA2SAgCqfhoBQpmqsHMfi04TkDwm5mZCrZJKeoLCY3fpd53mHgP7Zdhb9Ur3YOnvSXTIW/jzTsxnGsFkbhQtW2LqFBeZ+o49GrBNadteCwxVl2v64GnfSa4mPxcg9yVYrjvjX3Ss5jdKXoMYhT8QPZ5hlSXwMCGwnvWAbk7yoG9hleExZMwk83C30r6H7EtsEHsAXzD3tIxt9zQKePzann4D4gH6IWWoSWdzdErlwhvabe6w00nOtf7Vf9U8FfmDZtY2UKfyIwOYVLhRR+ax0qeJF4MgyneZA5my8DQg3ElSjP62ZQg+CHPbmmjhgcZ20qpR1z5A91V3PhS9c7yc0G75cCxS17dlhRnFyCJQI/N0xLSlN/39AVpbPo2ZIypAFAyh4jtGW83oCgfACxQczPfugJixm73M6jvHG3sY1NxoNms0YJVqmM4rfZoeCC5weaU0RPUf4te4A9oKVBLfPoydAR2ZYkFSHDrkfvOBR2ckNixyHwxN/o9aPOoyZcHWJpkNvGFT1/
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB2820.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(38070700021)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eHhsOFE5YTNHRjRpUXhibXlRTS9GbkJxUFVHdWxoOTNDOW0zRWJUZVY0TU01?=
 =?utf-8?B?VUFMb0sxU3dDZ21Bdk5jaHhjalZJZDlEaFhHa3M1SEN4RStjY0d6WDFUeUdo?=
 =?utf-8?B?a1pqQ0d1a3JDNEJUL1ZCWExKbUZXczM5YzAwRU9nVmJYKzNNa3pZeEJMcSs4?=
 =?utf-8?B?MkVuZ2h3a1Q0VjAvWEJXMmNpVHA2V3pzWWxTWUEyaXUrVjZKNzNvWVFzcUkv?=
 =?utf-8?B?ckUwVHlpUWN5VGlkR2RaTnUzVVdiVmZwNnpyQ0FrRjhaeUdMUDBDMW1paEIw?=
 =?utf-8?B?N0Raa3VESnhSVStmdVlWenZsbjdjVFppRlVPVGdmRWw1MDN2WWFCTmxIbDZT?=
 =?utf-8?B?cHN4QXFGT2NhUHRPZmRHL0tJMGpXSGdUUWRuVWFNbVYwdGZrRWwxQS9kOVlD?=
 =?utf-8?B?WGdEYTJDb2pMS2VuL2ZicXlGMkdNd1pRY2kxUW1hL1Q2T3F3VHFFZDA2TTVJ?=
 =?utf-8?B?TjNNb2w2U2dPcDBkbHcyWlkrWlFBdnBKVk5sSXlQZk9kM2FlVG54WWw4WS83?=
 =?utf-8?B?dWNDM0lKU2FCdG1CcVpKTEVXQ3BWM256QlZidFNHY3hPUE1VN3FoYlNmWnFp?=
 =?utf-8?B?KzA1aTAwK1J5b2owTEp1U3FneHRHTFh3L1JiYTdQeGRPNjFoaFhQeHBieW9t?=
 =?utf-8?B?dEkzU2d3cUZGQ29NdVp4eW11MzJIbTJYQWFyTWJxODI1YlNSZ2U2T2QyeWZn?=
 =?utf-8?B?NWVPL0dsckY4bXhRWWtvOXVSRW5PMlZ2L05USktOMHJFcERJU1BmdCtjajR5?=
 =?utf-8?B?UkpiZ3pWSGFhdXVWSmd2eGJSc28xVEEzVjdNVW9vZDZHdnRFVGJhYk9ld2Ix?=
 =?utf-8?B?ZDdxLzRIb3FRTHk1UGtCWGJMYkFDQ2thR0xuTzlxMXZ1OHpkdlVhZzJ5N3pE?=
 =?utf-8?B?bWcvUnMzdytVNDlDcDBSaGNDNStyTTRsbEVjYlc2a1VKcGtyZXlQbTJadlNk?=
 =?utf-8?B?SjcrT01HS0FCUVpJamdCK0JkZU5xZENyVDFkWWxLbXZLbnRQeHNtZWQ1SHZm?=
 =?utf-8?B?Z24rQXBaZlU0RjBjcmxYYmhxNmc5M0IwSjNtNHJMaHl1Z25ZanNTLytqTWRT?=
 =?utf-8?B?dTM3Z0JkdTJuSnFBbkZVTjRGdmZBYjJmaW14cUpUaDJSQWVUVzZKNnB2Y0lt?=
 =?utf-8?B?WE8wWjVyQnNmUVAxLzU0c25ScUhXbjZBbWZwNC9pQjNoQ1h4L0Y2SklnSDZr?=
 =?utf-8?B?QzhVN09aaEltd3JaQ0pkOXlGZVFNTjFxUkJxOEdVU1pVT04wOFBCQzJCWEJo?=
 =?utf-8?B?UkJFQ25BNHF4elBuRkhva2ZwcU5jOWc1L0pTZlR3ZkY2bjEvVTFla3lJMVJD?=
 =?utf-8?B?RUpmeEFWb1RMUENabkNMOHdCTHlXZHF0NGk2U1ZRZzd4SmFtcHcvakdxR0c5?=
 =?utf-8?B?dVNvc01ZUVlhTDllWktxTVRnYkk2djJJem9Ma0hpMTk2TitMR0tCU3RKcVg1?=
 =?utf-8?B?UG1YT0dvODkwYzJGRkxWemI5cHhkMzhTamo4UVlQdndPU1ZVWGxzckRDYTRT?=
 =?utf-8?B?czdWY3I2NjI5OVdEanlDL2FQR29yOU53N0NSdXljL3JvTUNaZnpGbWFUcTk2?=
 =?utf-8?B?N0xGZjhUSW95bUV4RFJacDBGMjRETS9SdSthU0Q3Z0c2TU1rTzJLT1BiZXZO?=
 =?utf-8?B?R0kxVk9aNzlFbm9ROERFS3pVbzZ4aXQzRThKdzFaU2twaUYydUZLN1pwejdO?=
 =?utf-8?B?U1BLUEFQYWNwTUhBT0xCaEVlVHFhRnVFdWs5KzI4dzhOWXpCS3ZSa3l2cnRB?=
 =?utf-8?B?YUU2bStPRzIxc293SzJSaXZQV2IzY294UTE5VUV0cVVvL3AyWStrM0lKZG4z?=
 =?utf-8?B?blphdTdiTDdyNzQ5MFdERnNnSmo2S2ZYdmdhR2lNS1ZzOWp5bVhPN1ZLVEQx?=
 =?utf-8?B?UEozK2ExUG9CaDl6ekpnQ1JCSE5MNjVBR3FyMSswU1ZPRm8wdGhsOWNmc1R5?=
 =?utf-8?B?cEhsbnNBOHd1Rm53aWtrRG1rQ1JRNjFlVElDbjJCUW5yV2swSnpTNTZqVUlB?=
 =?utf-8?B?Q3lXVm5GbU8rWWVNY1NNdmNBSi9EZDV0ZW44U1pvTk5Cei93cThZL0dRUFpR?=
 =?utf-8?B?Qk5EVDY5bTMwMmZGQ0hNTFJFQ2xBSndXamJCTUVXNHFSaE5zZ0Q5TGtNa3U5?=
 =?utf-8?B?MGFTZEhFUVg4K1ZqSUNLelU0R0wvb2NvcEJDVDdEYlZKd1hRMHpjQ2lTM1p5?=
 =?utf-8?B?dVQ0NTl4bW5VMkxUM2ZvUGkxQVdaTFRqWndSNm9KczYrRzlzKzMxMklQYWlF?=
 =?utf-8?B?STlTZVI3dWR4MFI1L0ZOaHhwb29iZUpTZnBkOFhDelRnYW9YZitrV3Z0SWJn?=
 =?utf-8?B?OHoycmlSVitDZUtTRC9ZMmNrL1dlbWN2bmRrS1JnbmJuV2d2MXdOUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	XzsMgluAqP/e4/CVOlucskkzRAULHSfVcQ5KvKT3WdVF8u6nK0KEBAzHedKcVHeNjS8QfA46s/zOwn2RlGPECHvggc8TgbVTIb34N3Hru+fBF8Jb0NwM8B726lmLblcNaR5BJNclEE2MPWks8/Fs87houKd1qdxDbIc0ACXlFZaM63NY3OT0si+GHMAzFC+l/q843WMFnSWSHOSy8RcbF3peBamNL21QxxsxbGSbWfB+nQC82RQxePLGFboLO3t9JeG2tG37dB2Naa6zvYWBvG3BKa1OfP2g8+t7wS/LxhXt0Nek0JtM8hFJUiSdGixF+IY9/lmV1fkGGsho1g4DQw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oe2+5dJk0h2bfPtyRnceYF83Y3RyoUXB557nxfGNLZ8V8qv88WjuYgN4dfxY8OLrJe9HfV5W8UvmL6gBVl9Y3AIsCRKD+l0+d6SIJGryGYdA5z4qNS3fsSzW+ENdGoS4PgHq2SYMiVnC129aJ44LgKpB5/E5sBXdFKNDWfgeEOb4OdO3ABj1kvnqCA31RersyNHN1l9BFyR34g25rj5jCktfMIp37NkMxdZ4ekhHtl8bbSGrtjY6AR5ov2IRzs1Rv/Z81hh4yAZXW2uPhAUzu74vm58PyufRMNOHKyAs8KuSZQpr57scsUkM2/L/PUknbJqXz7xviKrsYQT4YrtuHPmLHasGcyjgnux6UVeaaaSLk5C7Q1Tv3wknZNI7vYctnNe28mDn8IxpDt77cZ4EQ9ihJ4A4Hojk2DLkH7hjHpzUMUfso6CGwgUSHWcTuyVQpU40fqFhNBwhWGqgPpRi+jbUka+O+H1m3V8Qrw8Zg61pkZIb2ioWSN/RX32nIuDJDGmwCUmFcuvrgtDF/ogj3SWr2knuqP5W0KrmD2TB5TRttworrdegAhl7ZlocUx5Md7Kle4roiKNFrtGB3jCWYBu3+fAKpGD0TK0XXddNNWk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB2820.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b66586c-fcb7-426b-2a79-08deaf31f2b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 07:50:19.3271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CLyhQI/2NFlZkxMZhg3sUSC1EOBSkfuyS4MdNHSIE81tpquGthr1iSIt1+sZESD2NaspuweBnbALbO6eHZ15j+yn1v5HHup/RvkPh9KT/Zs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6414
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2604200000
 definitions=main-2605110084
X-Proofpoint-GUID: w0Lspoc5D3Shd7MZnHRLeUqVS-wZlel7
X-Proofpoint-ORIG-GUID: w0Lspoc5D3Shd7MZnHRLeUqVS-wZlel7
X-Authority-Analysis: v=2.4 cv=VtMTxe2n c=1 sm=1 tr=0 ts=6a018a40 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22
 a=yPCof4ZbAAAA:8 a=Ikd4Dj_1AAAA:8 a=9jRdOu3wAAAA:8 a=VwQbUJbxAAAA:8
 a=38iKSIqtQWD8EJl3YXoA:9 a=QEXdDO2ut3YA:10 a=ZE6KLimJVUuLrTuGpvhn:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDA4NSBTYWx0ZWRfX7Iyy6JmzIND8
 sDVK7RUPjbIs4ryBdaEGqeJTb70HSqYaDjyHTWEsM+EqW1HbcpM2PU0WvGVGBgFZs57xfkK51QV
 c/yi4ZBfEwX/34QRX1Lx97dNICWtBwppW8pLLxaup0l/b+HSemTZQGDX5ONk0D2TqCgOuQFDsof
 zVpEWoIdiioOPKdwkESKHhwCmhvwX/DLgMVcE2d+74Bb1bmJp7KImuInB78TgelfZyMRftPGWSK
 Tl0OcTBewoSdvZuDAYw1F9c5S8a9vgL8H/pAEMdXD0qoClY+KpmQbVnZZv7bZf9fEKKUBoTSUS7
 tBkHXxvDxXJWkSZn1feX8fTVr0rwVyF3/OgANWfrBlZSmZcbdToOuEk34lrGX06yQ7eLMQR61Bx
 mOSN9n2lNxejqmoHSb9p3dnwh0zeXjhAl5NQ2a9BX5adW5LBM1hzxrnEse+yzJ+/JeQwW+ql02U
 MsHamZMWeWTMJ33+3Uw==
X-Rspamd-Queue-Id: 43303509B1C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20369-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,BL0PR10MB2820.namprd10.prod.outlook.com:mid,ziepe.ca:email,oracle.onmicrosoft.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praveen.kannoju@oracle.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Q29uZmlkZW50aWFsIC0gT3JhY2xlIFJlc3RyaWN0ZWQgXEluY2x1ZGluZyBFeHRlcm5hbCBSZWNp
cGllbnRzDQoNCkdlbnRsZSByZW1pbmRlciBmb3IgcmV2aWV3aW5nIHRoZSBwYXRjaC4NCg0KLQ0K
UHJhdmVlbi4NCg0KDQpDb25maWRlbnRpYWwgLSBPcmFjbGUgUmVzdHJpY3RlZCBcSW5jbHVkaW5n
IEV4dGVybmFsIFJlY2lwaWVudHMNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogUHJhdmVlbiBLdW1hciBLYW5ub2p1IDxwcmF2ZWVuLmthbm5vanVAb3JhY2xlLmNvbT4NCj4g
U2VudDogVGh1cnNkYXksIE1heSA3LCAyMDI2IDk6MTggUE0NCj4gVG86IHlpc2hhaWhAbnZpZGlh
LmNvbTsgamdnQHppZXBlLmNhOyBsZW9uQGtlcm5lbC5vcmc7IGxpbnV4LQ0KPiByZG1hQHZnZXIu
a2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBDYzogQW5hbmQgS2hv
amUgPGFuYW5kLmEua2hvamVAb3JhY2xlLmNvbT47IE1hbmp1bmF0aCBQYXRpbA0KPiA8bWFuanVu
YXRoLmIucGF0aWxAb3JhY2xlLmNvbT47IFByYXZlZW4gS2Fubm9qdQ0KPiA8cHJhdmVlbi5rYW5u
b2p1QG9yYWNsZS5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSF0gSUIvbWx4NDogRml4IHN0YWxlIENN
IGlkX21hcCBlbnRyaWVzIHdoZW4gUlRVIGlzIG5ldmVyDQo+IHJlY2VpdmVkDQo+DQo+IG1seDRf
aWJfbXVsdGlwbGV4X2NtX2hhbmRsZXIoKSBhbGxvY2F0ZXMgYW4gaWRfbWFwX2VudHJ5IGZvciBD
TSB0cmFuc2FjdGlvbnMsDQo+IGJ1dCB0aGUgZW50cnkgaXMgb25seSByZWxlYXNlZCBvbiBEUkVR
IG9yIFJFSiBmbG93cy4NCj4NCj4gSW4gdGhlIGR1cGxpY2F0ZSBSRVAgaGFuZGxpbmcgc2NlbmFy
aW8sIGNtX2R1cF9yZXBfaGFuZGxlcigpIG1heSBnZXQgaW52b2tlZA0KPiB3aGVuIHRoZSByZW1v
dGUgc2lkZSByZWNlaXZlcyBhIFJFUCBmb3Igd2hpY2ggbm8gbWF0Y2hpbmcgY21faWRfcHJpdiBl
eGlzdHMuIEluDQo+IHN1Y2ggY2FzZXMgdGhlIENNIGhhbmRzaGFrZSBuZXZlciByZWFjaGVzIFJU
VSwgYW5kIHRoZSBzZW5kZXIgc2lkZSBtYXkgbmV2ZXINCj4gcmVjZWl2ZSBlaXRoZXIgRFJFUSBv
ciBSRUogY2xlYW51cCBldmVudHMuDQo+DQo+IEFzIGEgcmVzdWx0LCB0aGUgYWxsb2NhdGVkIGlk
X21hcF9lbnRyeSByZW1haW5zIGluZGVmaW5pdGVseSwgcmVzdWx0aW5nIGluIGEgc3RhbGUNCj4g
bWFwcGluZyBsZWFrLg0KPg0KPiBGaXggdGhpcyBieSBzY2hlZHVsaW5nIGRlbGF5ZWQgY2xlYW51
cCBpbW1lZGlhdGVseSBhZnRlciBhbGxvY2F0aW5nIHRoZQ0KPiBpZF9tYXBfZW50cnkuIFRoZSBk
ZWxheWVkIHdvcmsgaXMgY2FuY2VsbGVkIG9uY2UgQ01fUlRVX0FUVFJfSUQgaXMgcmVjZWl2ZWQs
DQo+IGluZGljYXRpbmcgdGhhdCB0aGUgQ00gaGFuZHNoYWtlIGNvbXBsZXRlZCBzdWNjZXNzZnVs
bHkuDQo+DQo+IFRoaXMgZW5zdXJlcyBhYmFuZG9uZWQgbWFwcGluZ3MgYXJlIGV2ZW50dWFsbHkg
cmVjbGFpbWVkIGV2ZW4gd2hlbiBSVFUgaXMNCj4gbmV2ZXIgcmVjZWl2ZWQuDQo+DQo+IFNpZ25l
ZC1vZmYtYnk6IFByYXZlZW4gS3VtYXIgS2Fubm9qdSA8cHJhdmVlbi5rYW5ub2p1QG9yYWNsZS5j
b20+DQo+IC0tLQ0KPiAgZHJpdmVycy9pbmZpbmliYW5kL2h3L21seDQvY20uYyB8IDEwICsrKysr
KysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2luZmluaWJhbmQvaHcvbWx4NC9jbS5jIGIvZHJpdmVycy9pbmZpbmliYW5k
L2h3L21seDQvY20uYw0KPiBpbmRleCA2M2E4NjhhMzgyMmYuLjcwMGE4NDBkNDkxZCAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L21seDQvY20uYw0KPiArKysgYi9kcml2ZXJz
L2luZmluaWJhbmQvaHcvbWx4NC9jbS5jDQo+IEBAIC0yOTksNiArMjk5LDcgQEAgc3RhdGljIHZv
aWQgc2NoZWR1bGVfZGVsYXllZChzdHJ1Y3QgaWJfZGV2aWNlICppYmRldiwNCj4gc3RydWN0IGlk
X21hcF9lbnRyeSAqaWQpICB9DQo+DQo+ICAjZGVmaW5lIFJFSl9SRUFTT04obSkgYmUxNl90b19j
cHUoKChzdHJ1Y3QgY21fZ2VuZXJpY19tc2cgKikobSkpLQ0KPiA+cmVqX3JlYXNvbikNCj4gKyNk
ZWZpbmUgUlRVX1JFQ0VJVkVfVElNRU9VVCAgKDYwICogSFopDQo+ICBpbnQgbWx4NF9pYl9tdWx0
aXBsZXhfY21faGFuZGxlcihzdHJ1Y3QgaWJfZGV2aWNlICppYmRldiwgaW50IHBvcnQsIGludCBz
bGF2ZV9pZCwNCj4gICAgICAgICAgICAgICBzdHJ1Y3QgaWJfbWFkICptYWQpDQo+ICB7DQo+IEBA
IC0zMjEsNiArMzIyLDkgQEAgaW50IG1seDRfaWJfbXVsdGlwbGV4X2NtX2hhbmRsZXIoc3RydWN0
IGliX2RldmljZQ0KPiAqaWJkZXYsIGludCBwb3J0LCBpbnQgc2xhdmVfaWQNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgX19mdW5jX18sIHNsYXZlX2lkLCBzbF9jbV9pZCk7DQo+ICAg
ICAgICAgICAgICAgICAgICAgICByZXR1cm4gUFRSX0VSUihpZCk7DQo+ICAgICAgICAgICAgICAg
fQ0KPiArDQo+ICsgICAgICAgICAgICAgc2NoZWR1bGVfZGVsYXllZF93b3JrKCZpZC0+dGltZW91
dCwNCj4gUlRVX1JFQ0VJVkVfVElNRU9VVCk7DQo+ICsNCj4gICAgICAgfSBlbHNlIGlmIChtYWQt
Pm1hZF9oZHIuYXR0cl9pZCA9PSBDTV9SRUpfQVRUUl9JRCB8fA0KPiAgICAgICAgICAgICAgICAg
IG1hZC0+bWFkX2hkci5hdHRyX2lkID09IENNX1NJRFJfUkVQX0FUVFJfSUQpIHsNCj4gICAgICAg
ICAgICAgICByZXR1cm4gMDsNCj4gQEAgLTMzNSw2ICszMzksOSBAQCBpbnQgbWx4NF9pYl9tdWx0
aXBsZXhfY21faGFuZGxlcihzdHJ1Y3QgaWJfZGV2aWNlDQo+ICppYmRldiwgaW50IHBvcnQsIGlu
dCBzbGF2ZV9pZA0KPiAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiAgICAgICB9DQo+
DQo+ICsgICAgIGlmIChtYWQtPm1hZF9oZHIuYXR0cl9pZCA9PSBDTV9SVFVfQVRUUl9JRCkNCj4g
KyAgICAgICAgICAgICBjYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJmlkLT50aW1lb3V0KTsNCj4g
Kw0KPiAgY29udDoNCj4gICAgICAgc2V0X2xvY2FsX2NvbW1faWQobWFkLCBpZC0+cHZfY21faWQp
Ow0KPg0KPiBAQCAtNDc5LDYgKzQ4Niw5IEBAIGludCBtbHg0X2liX2RlbXV4X2NtX2hhbmRsZXIo
c3RydWN0IGliX2RldmljZSAqaWJkZXYsDQo+IGludCBwb3J0LCBpbnQgKnNsYXZlLA0KPiAgICAg
ICAgICAgbWFkLT5tYWRfaGRyLmF0dHJfaWQgPT0gQ01fUkVKX0FUVFJfSUQpDQo+ICAgICAgICAg
ICAgICAgc2NoZWR1bGVfZGVsYXllZChpYmRldiwgaWQpOw0KPg0KPiArICAgICBpZiAobWFkLT5t
YWRfaGRyLmF0dHJfaWQgPT0gQ01fUlRVX0FUVFJfSUQpDQo+ICsgICAgICAgICAgICAgY2FuY2Vs
X2RlbGF5ZWRfd29ya19zeW5jKCZpZC0+dGltZW91dCk7DQo+ICsNCj4gICAgICAgcmV0dXJuIDA7
DQo+ICB9DQo+DQo+IC0tDQo+IDIuNDMuNw0KDQo=

