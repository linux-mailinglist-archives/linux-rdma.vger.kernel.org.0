Return-Path: <linux-rdma+bounces-2046-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D688B04A0
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Apr 2024 10:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB6F11C21C33
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Apr 2024 08:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EF9157E9B;
	Wed, 24 Apr 2024 08:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cEDyct1Q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2106.outbound.protection.outlook.com [40.107.104.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E210C156873;
	Wed, 24 Apr 2024 08:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713948231; cv=fail; b=h+BQOJrwsqtBS5QaWLxeZe7CAyn3Y84GmNwfI21qd1etKdno3foQxFgr8sCMeXSMw4KHHpnQKCek2mHvgd4ih2upNhum2KWd83pW7ni/x7OI/2RT56HFQlImsifp5ZhU9VxDbXtwVFldYWVHHv0X2rm0qaEvB3C5oxyew7+V5xY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713948231; c=relaxed/simple;
	bh=+xlMTOLYJAYJVvB3oDf+acaCETzC+XJ+u7WAlSlb7zw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c2H8/+2EUvcsL1QypAEH1hb0S+bZBmbh8SP4agcJbe9a11AfieAhXpBMsSelj38UwH7FjS5gLYzJpsfsXiRaT8xU6skZ0G+2N3ODzNeAe2Sgn7vWfx+C941cYZFR4NDUSXEW1wgnyspqx/d+oYLs3rtgAxQ+avvt+p9apxl8m3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=cEDyct1Q; arc=fail smtp.client-ip=40.107.104.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYvT91SSPgWp3syXvo32ESg4XfiCeuhFwvCjYZIEPQLjYEgiOp8iMHhO74BRTYqdYKL3mdBFMkJUMo7X9c+JoqQLDm5BjxUldUqZB0Qdr9jv1Z2YdQiHmA92qkfqHQI8H9Ox8pJKCyaQiz+h28fhS8tKIs5h63A4K9D5037SyCPcWxx3/y/mJAWlrG7MD1PKQrPn7yVe5ivZB70HEp6V4ftDKh8t/YzGsksF255VGoLwzrhtXm3iCLuNEaYqsHMS/yZWSLMj9a+01ni2jobbD88pT05DQMAwLud3lrUPW6YkD1cld+lvRwcSQg5tHcBmf7y7RyDx1pRFUBY2idrlow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xlMTOLYJAYJVvB3oDf+acaCETzC+XJ+u7WAlSlb7zw=;
 b=l1qAAnKR+N/gAneWrs/y56VIDk/e7ka3fnzaxT9NwpVyntHIfX93ogXqZoEwzR5BeOw8CsZu/SoHnOmokjHRzvpnKbqYtNPM+SnVT9F2OH3GbyyzF32u0lqYFGeK9iOQAV8qFJCYE6kJ+ZGG3umt8ekOz5kbcgBj0X/OMVkn03wxLO0wDoYrVQ5yeIi1G0eY2d6R9zIx08F5hVk2hc8Rkf54t9q8bLIgSc+rF+x9rCe32Y+LLng5iX7m3ASu3IPChHdXBFYTDjcSajpOLfZlpFvC2Lt+3Y9H6Olp7InzTnMANLugcn9fX1XEtTMn7SCPH19YiH4hfndS/zExQXZsgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xlMTOLYJAYJVvB3oDf+acaCETzC+XJ+u7WAlSlb7zw=;
 b=cEDyct1QZzmeTmrq3gmVodOgEk8eT33SuSgRi5T9S8YmydbhTKxm3oR4+wi/D6BHSrQPcrH3aCh/6y/mq8bDOk6PyZwLZFNmOon9YiZTSO6p/R+YAo9m0jXixcXREKjNt726XNPeBaVFw5CraJOwg6da+HI4T5hYF19d6649RbM=
Received: from PAXPR83MB0557.EURPRD83.prod.outlook.com (2603:10a6:102:244::16)
 by GVXPR83MB0653.EURPRD83.prod.outlook.com (2603:10a6:150:154::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.9; Wed, 24 Apr
 2024 08:43:31 +0000
Received: from PAXPR83MB0557.EURPRD83.prod.outlook.com
 ([fe80::7c93:6a01:4c9f:2572]) by PAXPR83MB0557.EURPRD83.prod.outlook.com
 ([fe80::7c93:6a01:4c9f:2572%6]) with mapi id 15.20.7544.008; Wed, 24 Apr 2024
 08:43:31 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Long Li <longli@microsoft.com>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next 3/6] RDMA/mana_ib: replace duplicate cqe with
 buf_size
Thread-Topic: [PATCH rdma-next 3/6] RDMA/mana_ib: replace duplicate cqe with
 buf_size
Thread-Index: AQHakbDI8J6MWzKSMk+Y87LxHLllZrF2ilMAgACYmoA=
Date: Wed, 24 Apr 2024 08:43:30 +0000
Message-ID:
 <PAXPR83MB0557DD076A61EF095242348CB4102@PAXPR83MB0557.EURPRD83.prod.outlook.com>
References: <1713459125-14914-1-git-send-email-kotaranov@linux.microsoft.com>
 <1713459125-14914-4-git-send-email-kotaranov@linux.microsoft.com>
 <SJ1PR21MB3457AB602DEA2B369E219121CE112@SJ1PR21MB3457.namprd21.prod.outlook.com>
In-Reply-To:
 <SJ1PR21MB3457AB602DEA2B369E219121CE112@SJ1PR21MB3457.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8c56225b-5065-4ac3-a480-0af7c1935eb5;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-04-23T23:32:49Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0557:EE_|GVXPR83MB0653:EE_
x-ms-office365-filtering-correlation-id: 3f6bbd1b-42eb-45dc-f5a6-08dc643a9e89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?cDk2TGNwWlZCR3dSNkMyU1Nybld2YWN1NitXRUR5MjBJUTY3cTdSUG5CQTdC?=
 =?utf-8?B?c0Z2UnB1RkZrTlRtY3VVSGRlWXQ3Qi9FSGJlc240Yi9DMHlnUDdpSEg2Y3hF?=
 =?utf-8?B?QXptZGxvMnJrbWFKZXdtWWlaL29HbWNrR2gzbDR1bXNUS3lOUllLQ1RpUVZD?=
 =?utf-8?B?ZlpOT0JzampCRjVtVU5Da2hENy92VG1YUytFVEpmR1NMRzdZaUpxMHg3RkdP?=
 =?utf-8?B?dVVUSzFHWWFlWmQ0VzM2MnJuTWF1QVlYL0NSTGdmSXIrOVluMTF0YVliRmFX?=
 =?utf-8?B?NE82bkNTQzhXczdwYWc0T0NEVzVCL01xd1FVSDl6ZDRqdDNYS3lEcllhMWlo?=
 =?utf-8?B?emJxc0tUMWpWQmlZNjFsSU9HZ3FEOURRMEJuMCtOVHY2cyswejlzMStzZ2Fy?=
 =?utf-8?B?aTBENzh6VHZmVXlzNW4yVGo4YTFlN1oyRkxVMFNtb21DcS9nUW5icnUyUUlC?=
 =?utf-8?B?YkJvd1JmRDRzN0JpWlBrbkhHY0pReFdDbzN2ejRtbjVtNGt0bXRtYmR3MXQ5?=
 =?utf-8?B?WUJRa0Z5dzlYUXRvY2lBbXVsaXI5dElIZWpTUCtnQjlyY3VNUWhBdFVTSUlR?=
 =?utf-8?B?ZFlLM2gySWVVK0dzaDNsa3Mwdk9sNmpZenZDMTh1WHBsRGllQ2JaalJRN0dX?=
 =?utf-8?B?elFpTFlCYmt2aWdlUkF1N2pFejJVL1JrT3J3bit3UzBZTERnOXN3TyswWTJP?=
 =?utf-8?B?b0NmS294aGFSSGVOend5c3lwS2NoOGRKQ1E4d0pNWjQyall6Z2xCNVN5c0Iw?=
 =?utf-8?B?d0Z1bStiZTNFbDFGWmY0L1lQTTFER0JRQklWeWpNcGtGOUp0UWpvWWVNd3Ir?=
 =?utf-8?B?aklIdDNROGN6eUdEb3EzY3lQS2MwYlh4RS9XdGRJNENnUHlBY3dBRHAwV0Zr?=
 =?utf-8?B?MnRtTjI5NCsreE5VdW5wVi9mbUoyczFra2tZYVc5eDRGaWpjVDJMYUJBWjdv?=
 =?utf-8?B?T3hrUnJRT1NIeEpvdy9QalNaTG9GNUQvNm9aM1hjQVZKdFdWL1RqMlBGZHA4?=
 =?utf-8?B?clFlTUdobHl2R3FEaFNRUHVyUk0zRkJ3RGlMOWNPZitoRU9Wc1lxM0tmQ3Nx?=
 =?utf-8?B?T3ByL1o2ekRqamt0by91OXZwdXZDa0dnQ0pHb1BSZk9QOGJzcXVGajdwWUJn?=
 =?utf-8?B?cVUxYXZURHljRGtpc01vRXpmNEZWOGhMN2dWYmNSZHpuSWpNb0djcnBmWTE5?=
 =?utf-8?B?UUQvVVUrcVlxbWQxRmZXdTJSRmZxZzBiRjNFYkRVL0ZxSll0Ukl2RnVXejQ5?=
 =?utf-8?B?UDcwTEVDU0VvRWFzZFF3ZDcydDhraDdzK0NZakgyVWFUWFVrWERqL0pvbEVR?=
 =?utf-8?B?eDhHM1pjRGhjcXdpbnpZbjI0MytTMWxDUmtzdEVSQkFCK3N4dUdSaFRaeGJN?=
 =?utf-8?B?ZWZwbW9ZZ2tTZUxmcmxXR0dITExxM0cxZ1ZGWUhNMWtVMHFFN1FZenZpMSsv?=
 =?utf-8?B?WEgyREt1NGJIekwwWTZKWXE2VFQwTFhWc202eWtXVDdmOFBFbU9mZCtsMHV3?=
 =?utf-8?B?bzhuRmkrMFRnRGFxaGpNYXNWeUtISG50K1hybmFZd1k0dlF3ZWZISm92bjhP?=
 =?utf-8?B?UVROTmFoMUdMbHp4U3owcFZiTSsxcjJIcXYwR3BxRTdvK0ZsbjUxUW5md3Zs?=
 =?utf-8?B?RnF3WVU0blBkOXlQTmcyZldCQnBQY2VvSmorVGQ2NW45TW9qYjI5M091Miti?=
 =?utf-8?B?MkJQN3dMdzNBaTFsU2Q3NHI0anh3cUF3Z3ZkVXRWQ1IzNXVCYVVGQ2ZndU9o?=
 =?utf-8?B?Z2U3bmpqVXRoY1B4MllSWUQ1TS8yWmFRbTlLZlorbk8zWTBCMDJRTW9PQXlC?=
 =?utf-8?B?RHFZc1RWc1Bkd2dpeHdOZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0557.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?amJuY0kzdFQxTkE0TG1zNWM4d3VGeEtxTHUvVis4MVBVWG5qTEFXU1Q3MGgy?=
 =?utf-8?B?eHBmTllqUnZvaDFra3pwekhBYnNGZEFQbkJZdVRJbFVFM3ZiaU1nZS9rRVZq?=
 =?utf-8?B?bTFrRUVvcGhscFBDbDNQc3lPNnRMN1lqWTNoaFoxK21MaS9rNFNBMDNhNms2?=
 =?utf-8?B?ZUYrTHg4aUlRQ04wNXlxbTJLTUlpblZaSmtDTnhTMU1IRjFETVRsTTZwRWU4?=
 =?utf-8?B?Y1k4ZWcrM29MSTlMSEJnMG9SeldmYU1JWDJYMnZVczdLQ2VPT3RQZ2xyWDN2?=
 =?utf-8?B?V0xXRGJ3REFNZ0YxVzM5OUxJYkI2YStUcVRxZ0lZWDRKN0ZpMUZBLzNaeFpY?=
 =?utf-8?B?Vml0cko4cnJmd05MNUJUNGxzcmF6MjdTN21GOURnWXdWREtHTlh0NUhubUxa?=
 =?utf-8?B?dkRucDFNZE9qY0J2RjRTdzRuOC9TTnI3cXZEelM4Q2pwanBMYzZ5S2NBaDA5?=
 =?utf-8?B?aEc1VW5DRU5PQTQxRWo2NnhlbVdTZks1OTV1TkJTc2l4dy80QlV2bTlqNlZS?=
 =?utf-8?B?MWZoRk1rTlZ6S1kyc1NYdDBrWEpwa0IyVVJ0S1dPTHpDeGN4blRTa0tsUWxQ?=
 =?utf-8?B?VjFIZ3lhTDJyQ3UvL3FaUnZyUkNHWWNQZ2EwVFU2WHVrUUU0YitZUXZaM3pC?=
 =?utf-8?B?bWliUVVGL09HNVN6MG1BMUh4N2lRdm4rNzJSNno4bVl4OFNZVzRtc2hHdlg0?=
 =?utf-8?B?VDMwTzA0NkZrR2M0OWJIT1d6TDVSWmVuZHNWaGZjTjAzaVV2SlZBRlVBTkl1?=
 =?utf-8?B?YXRmRG5UUE5pQTk3ZjlsN29oSkVqUGZNYUNTQ1l6RlUwTkRkMXhCaUk2OE9r?=
 =?utf-8?B?RW5ZbGZZRWdrRm1Pb0JGeGJKTUlWQW5DbjI0UDVRdHNhOU9NdmQyWjJJMU81?=
 =?utf-8?B?VnFKSVZpY2xQVWNDTVQyUThVOTdWSDM1akxNMldPbFlXUC9UVU1wZUpwZWhW?=
 =?utf-8?B?UmhqbStSeTc0YXZTTWtGTUlrTldUQzN4WktZVEFnWWpXU2ExWDVYM0xsekxt?=
 =?utf-8?B?Y0R2aGc1YWRCOWtZSUk1RS9ad3hHa05LdjlPY3FxK3d6ZGlsOTMzTXhibnhr?=
 =?utf-8?B?WDJjL1hmQ2NHRVNoRWZVbHdZMTZuR0N1S1g3OWZaQ2phTHNWM2kwa3AwNnBi?=
 =?utf-8?B?TnpRczRwZC9UckN3WDFGc08va0s5Y1M1eFF4ZTFrcGttZFlzV1JUekpBVm9k?=
 =?utf-8?B?VzBvM3dIRS9ObXpJaTIrdmowZmM2eTdnQ0pTSjRqYWRjSVk1dUVJc1g2TXZI?=
 =?utf-8?B?a2h5QzhVdG5NSndjejRZMXJFMWYybEpTRnNxODJTaEVScU4ybkJyM2dSUWtD?=
 =?utf-8?B?eDlvd29waXRtZWlBN3ZsT1UzMU5oUGZGR2NWanhCWVhoVDh3aHMyVnllaVVM?=
 =?utf-8?B?MFNsZnkybGFOMVZld1pmdUE0Q0pnamRsNlNlTzRyWTlBVTV0YUJVa3EvUkpZ?=
 =?utf-8?B?bHY3MkdNZzQ1LzJPR3lTWUFlSkQ2SzJUcWRMRUpmdHBoT0JaRWgvcmhGVXht?=
 =?utf-8?B?cVQ0WVd1T25nRWdIWTc0cDZZOE5wb01obW1sbUYrMTlXRmpVOExrVHhLLzlK?=
 =?utf-8?B?M0Y2czNYSU1kRzVCM3pYaEpMSHg2RWN2V0pUbWtQeHdVcVpCandEZWgzbTZJ?=
 =?utf-8?B?ODJCYUllVHB0Tlp6VCswNllEZXg2NHdrZldvd2JRMTkzVm9TNjNCd3A2cGxC?=
 =?utf-8?B?Zkd4WFNBcnpRcnpRSnZscVRKVWZFaWt2Q083Q2F6NTc3UjFvS0U5elVrNVJx?=
 =?utf-8?B?MFcxTlhFcGZ0Q3grS3g4c3p2TDlqbjcyZEJNRlJKMSt1UjY1S0xSM1pITDd6?=
 =?utf-8?B?U2I0K203QkNxRnJ2RTI0UXFQT2Q4S3hhMmNOTkJJK2pKRkFuakw1dnBUUGM3?=
 =?utf-8?B?UkVhT2FNWXB4L016MmVmSG5MMEV4azAxNHdzNjlFV1dMVVlEbjE5VnFWVXdm?=
 =?utf-8?B?S1RyaEJXcm9vSEdIRXFHY25IQzhSS3RId3Z1TjJ0Ym44RzR3cVlPblJBQm5a?=
 =?utf-8?B?a1A0WCtMUlVndUVFWG5qNlhzVGUva0JXSE5FWktBYWtwWG5aMkErMXhDNDZ0?=
 =?utf-8?Q?SXWUQW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR83MB0557.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6bbd1b-42eb-45dc-f5a6-08dc643a9e89
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 08:43:30.9997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /4tZNG3v+sd48jHSguplvcKwo/TWRV7SOM1BMOm7l+loXbkSdEG3hb0zIZRbya8eqx9694q2NRgkzAMqNUKccQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR83MB0653

PiBGcm9tOiBMb25nIExpIDxsb25nbGlAbWljcm9zb2Z0LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5
LCAyNCBBcHJpbCAyMDI0IDAxOjM1DQo+IFRvOiBLb25zdGFudGluIFRhcmFub3YgPGtvdGFyYW5v
dkBsaW51eC5taWNyb3NvZnQuY29tPjsgS29uc3RhbnRpbg0KPiBUYXJhbm92IDxrb3RhcmFub3ZA
bWljcm9zb2Z0LmNvbT47IHNoYXJtYWFqYXlAbWljcm9zb2Z0LmNvbTsNCj4gamdnQHppZXBlLmNh
OyBsZW9uQGtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggcmRtYS1uZXh0
IDMvNl0gUkRNQS9tYW5hX2liOiByZXBsYWNlIGR1cGxpY2F0ZSBjcWUNCj4gd2l0aCBidWZfc2l6
ZQ0KPiANCj4gPiBTdWJqZWN0OiBbUEFUQ0ggcmRtYS1uZXh0IDMvNl0gUkRNQS9tYW5hX2liOiBy
ZXBsYWNlIGR1cGxpY2F0ZSBjcWUNCj4gPiB3aXRoIGJ1Zl9zaXplDQo+IA0KPiBJIGRvbid0IHVu
ZGVyc3RhbmQgdGhpcyBjb21taXQgbWVzc2FnZSBvbiAiZHVwbGljYXRlIiBjcWUuIEkgY291bGRu
J3QgZmluZCBhDQo+IGR1cGxpY2F0ZSBvZiBpdCBpbiB0aGUgZXhpc3RpbmcgY29kZS4NCg0KSWYg
d2UgbmVlZCBjcWUsIHdlIGNvdWxkIHVzZSBpdCBhdCBjcS0+aWJjcS5jcWUuIFRoZSBwYXRjaCBk
b2VzIG5vdCBhc3NpZ24gaXQgYXMNCml0IGlzIG5vdCB1c2VkLCBidXQgaWYgeW91IHdhbnQgSSBj
YW4gYWRkICJjcS0+aWJjcS5jcWUgPSBhdHRyLT5jcWU7IiBpbiB2Mi4NCg0KLSBLb25zdGFudGlu
DQo=

