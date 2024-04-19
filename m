Return-Path: <linux-rdma+bounces-1986-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B067C8AAB3E
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Apr 2024 11:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45FEF1F22070
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Apr 2024 09:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2708E74C09;
	Fri, 19 Apr 2024 09:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MuTT5Hy0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2102.outbound.protection.outlook.com [40.107.15.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4A3745C3;
	Fri, 19 Apr 2024 09:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713518059; cv=fail; b=NbVDebSRmOcyzbPftd2rvULG0PAN9opwWCptkU2zGSUTowbrEE8Eimu+yWcKR4nOpghFGL21rnV7EkTFBVGBvmSBAUKQjGyVm2L2xkgijXDVbCQt4j/ZaLBLYPYAxENrL5JS25yD970NB2bU0cm2MrqxD4pENStHA9eKHCvHbH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713518059; c=relaxed/simple;
	bh=2idZeL03YmK50X5cxI8wk39b6Y4EsB38eEmoVasnZnE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=erUNjJEqxVP5vv09So+uNPm7VsAl+ZLhFslE0tWrwpvKZ9aRqzpebsLRVy/Tc0Jt8rhoCFnxoSyZgqpjeejj2BU0H1F+WkVCv4jJowg3p+sIKmHN1bPAHr8q/u0kWVJt96iKSp4EpUEWZ/fVtxb4vvF1SnjSWk+kS4mNn/lyRs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=MuTT5Hy0; arc=fail smtp.client-ip=40.107.15.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H64VJ3xP4XptZk3V+asvDyyV877/HbiWSxUHW3FImK4Fg/XXzY8EkkclO2aKKwfJED2ZXTyz9KRkDB2Dewq8u71kAL45mt/5J/fxcUrk3KP5g0NBqin6m64fHb1gh/MIX2BuQ1CfHYC3Ets1T8JfX+Uv6pVyWqzIHrEDAGc0fcJZzCC37seFyuJcEUNuQGaKCaV97tluNa9uj+8AioDAuodBI0iKgmjt0k+oXZUsNigbPLDW9NT09XaO+x8Fj2HnFd7ubN6GRLcehVT+udyS5yYBV4HDlybmtnY06W1EWul6arQ7WnIdC9S0Bv7tNwjkvCro4MqyBONNEVZpXXVv9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2idZeL03YmK50X5cxI8wk39b6Y4EsB38eEmoVasnZnE=;
 b=ZqMBo4e4mLPiAeEzgE2KROYDcj/+P/ASonu/KwWKd5lzBNayogNzfR3uZVbvvXgjzMv+tATelkTU9TpWVUPup7EV6F+KHJ8zJzJqg4sIN72R3o1DS/QckppR9pMZfvVjxr5JP/3VoeZ7D3dPrXO5rgUrXCDWU/YIAXhYo8KOaUTOXho4MPUZ9orxZ3feuCLRHN4dT/DhJeFxyU8nWgvCcBcq7wXHPf/r/UW8cNRO7op9oM0LX59C/3pAImkYyGbZhY21F4/fazV+/MErwjYmu00wG+VQ1sVFFprXGKCOmARqKpCkLiyl5MP4BHfX6HtYPlvmRhQyhCpFv69J79yL8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2idZeL03YmK50X5cxI8wk39b6Y4EsB38eEmoVasnZnE=;
 b=MuTT5Hy0iSqNk9NFx34j3a+s+OxGmBJaIJ3OTXkJydYwyT5lNXtXZMyG9hoEywv7kOA2RvM3d4i0RbgB+ytx8/G4PoxFS0ELxKYq3kTvBiNsBMQwl1CIF2xBpgh03DVY55frRFP/jUBYXJtuMpX7Xm/AV/ILhktAjYiTdwvQzZo=
Received: from PAXPR83MB0557.EURPRD83.prod.outlook.com (2603:10a6:102:244::16)
 by GVXPR83MB0670.EURPRD83.prod.outlook.com (2603:10a6:150:1e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.14; Fri, 19 Apr
 2024 09:14:14 +0000
Received: from PAXPR83MB0557.EURPRD83.prod.outlook.com
 ([fe80::7c93:6a01:4c9f:2572]) by PAXPR83MB0557.EURPRD83.prod.outlook.com
 ([fe80::7c93:6a01:4c9f:2572%6]) with mapi id 15.20.7519.014; Fri, 19 Apr 2024
 09:14:14 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>
CC: "sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, Long Li
	<longli@microsoft.com>, "leon@kernel.org" <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next 2/2] RDMA/mana_ib: Implement get_dma_mr
Thread-Topic: [PATCH rdma-next 2/2] RDMA/mana_ib: Implement get_dma_mr
Thread-Index: AQHakjnyZ9nG0OkYXESoxLIov9A7xA==
Date: Fri, 19 Apr 2024 09:14:14 +0000
Message-ID:
 <PAXPR83MB055789D898814B9F73B15C3BB40D2@PAXPR83MB0557.EURPRD83.prod.outlook.com>
References: <1713363659-30156-1-git-send-email-kotaranov@linux.microsoft.com>
 <1713363659-30156-3-git-send-email-kotaranov@linux.microsoft.com>
 <20240417145106.GV223006@ziepe.ca>
In-Reply-To: <20240417145106.GV223006@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=52dda4cd-f964-4e07-9659-7c9f96721016;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-04-19T09:02:52Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0557:EE_|GVXPR83MB0670:EE_
x-ms-office365-filtering-correlation-id: 1f16c1f2-9d2d-40bb-4803-08dc60511560
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?eDlML1Z2MGxwY2pvU3l3UWFMdFp3RlRPb3BCZjhrUzZUWi85QUxPalNwMFMx?=
 =?utf-8?B?andFT085cUdoVU1rNUpycWhiV2VidFNqSlc2SldaeDg0UHFVT1dwTVpoTGZ6?=
 =?utf-8?B?T3A2NUxaNEc5dzBMSTh1MTRtQXpkdElRdUJmd2pGZWFrWkQ1czZSRE1sN1lk?=
 =?utf-8?B?Z0NSOGRDS0dTSWxvWGd4S3QvK1UzM1dIa2tiNXJBR3h0MUF0eVovcmdJaHRO?=
 =?utf-8?B?YkpheitQbHdFYnJxN2FEVk1wMGdnblFrajV4d1U5dWduTGZqMlplSnc3c0FQ?=
 =?utf-8?B?R1BraXAxLzQ1dmhqeTdVb2FjRTRGU0xUSUFYcEN2RHpzUnhKZUorQTIxQTdr?=
 =?utf-8?B?bjdiWGszOHlIMHRGanVOSFBuZkJtQWxZNGhHdzl3TkdYL1ljUnBjN3BXejls?=
 =?utf-8?B?K1o2cXZ6WkE5WC9pSkxEQ1RXNm9IbS9NbWpzc1kxWFNWVHBvTElMQTRIN0dJ?=
 =?utf-8?B?QzBNMkcyd1p2TGFWM1o2WEplUi84bVZ3bEZxZWtkSzljdU02M3Nzb2VKSkxB?=
 =?utf-8?B?SE13bDJzekVLU0JNeFFDaUFxL2hmV1dzQ3MwU2pUMFYvT0lMR2FRa1laNUlU?=
 =?utf-8?B?Y2F3K1VnOStvcE1odWdmbnUySS9COEk0YXNRQWkvMzNKVlp3aWxVQWNWb2xm?=
 =?utf-8?B?aFpDNk4wOE9xdjJuZVgxc1FFeGM5TFdSeWdOS0MzaEdkdjVwMkxjNWFmVHpG?=
 =?utf-8?B?WWJUSnM1b0N5elNwMXFRYjREbUJiNHc5VUZyQzB2ZHFObU1OWUZJcEhrd2kr?=
 =?utf-8?B?Y0hTNjZlcjd2cElYdlZVSi8zUzc2MkMwOXZwSmFBNFFJZnUrai9sbk1MN3kv?=
 =?utf-8?B?VUlsVGhWRThWWk5JcE9EY1h1UCtRc2ozQmtrQ2MzN1JUdStUeUJ0enUxOTdz?=
 =?utf-8?B?QnRXL2JRU1F6cEVMNC9VNHdGcUxiK0NMamRsc1JHc0IvNFpnUDhDUlUrYzVn?=
 =?utf-8?B?WmpQUWF0cXdCRlRXSk9VSnpJWnA1d09FVEtESG1lU01EdWt5eGxOYjZiUzlr?=
 =?utf-8?B?UDRmcFUzdi9Bbnh6ZXYxYTZ6WHZBT2p0WGxqVkFZTTE3eW00REQ3d1ltT09s?=
 =?utf-8?B?NXpnV2s3ellTQkJvYUF3TzJ5MWNWQjRkOWtPeHMzLzVMdkFRVkpVQk5rbTZN?=
 =?utf-8?B?d0k5bitWeGVhMEdzOVJneU1wd3VPSi9ZVGlvaU9UU1hIWnp1NmNXQWszTVlv?=
 =?utf-8?B?ZzB0TCtabVE4d3kwZFpmZFhXbkFsWDNhRm93NzRhdkNKcEtnelhyWTBhQksz?=
 =?utf-8?B?SUZJWkRGZFBsVlVYRDE1S1dIdldqZE5GWVlkRDNpRjM2UmxoYTlDN3dHZGRH?=
 =?utf-8?B?UVNxYjI2dFhRNnFoYllkaXMxVFRQUmRlTGQ2VlZDWnhCbU0rR0lVRHl2eHF5?=
 =?utf-8?B?MVFQZmFTbkpOWTNadEZYUWJ6QjF0dVdSSkgxSWVsZVdabnAzVDJZRTNETnEy?=
 =?utf-8?B?NFFUNG0yS1hIMWhZOGlNSUxzYmFqeHpBUmN2Vm05aHN0Wk9mWTl1OGYvSWY1?=
 =?utf-8?B?ams1dGw5aEJLYU96aWxGYldtZlIrcUMrNDJza0Z2V0pBT1d2aERRclJjQ0Zv?=
 =?utf-8?B?OEJ1MWtNS3VUZ1h2WWw5RkQ2Nm1sa2pGZjBxdWlOZEhVS3VTU1lQTEdBZ1FK?=
 =?utf-8?B?TzMyWmFwNGR6djVjTnpXUG9oOVJNZXJqQ0R3MHh3ZVY4QlNxOEEwMy93Y05m?=
 =?utf-8?B?SEE3M1FnRlZIZG9Ca1JVMmZyNW9FZHdIOFdpQytHTkkvWTRlYnRLVEpjUEYr?=
 =?utf-8?B?eGNoa3pFQkQ3OE1JQXRGbzlJK21OUHVKWEJ2Yjl1NzIxUjdQd3RxSmJ5N1RB?=
 =?utf-8?B?WVR2Sk1yT3pJdmxDdm9QQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0557.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WVZUTGJ5dVpLYld5SG1iQTdoSnZTTjBZdlpmOTJvNGZrZ1orMkkyUzU1cVhG?=
 =?utf-8?B?dzNzU2RNeTNpUlh5RVZDYU9kZGpUczUwSTN5bzBxREM2UXdRWnlid2VxQmVQ?=
 =?utf-8?B?dHRrdk1MS0FHK21jbGtXcVZJbUhHT3VRQWN1Y2svRWtrK0xWTlRER0JUUkpr?=
 =?utf-8?B?cjh1ZFhxYmROZkErVHdrditwS3l4cG9KREVtZ0ZGUXM1WW04TVBYSFdqd2RB?=
 =?utf-8?B?djZEN1lzaU83bm5CS2lsZ0J4OUNFc1JqNzUyWDVrbXU3SVlTRGNjQm04MzFo?=
 =?utf-8?B?YkJzZzVSMEdBRGlJUU03TGZOcHFQcUtxS0xVeEI5eXJZUnFLbmJUZktKeHVm?=
 =?utf-8?B?UEJFcG5kZnRuZG5EU0FOU2ZiMGlUQjZPbWZGc0NobnRKVW9nVC8xVFRYeVZo?=
 =?utf-8?B?ODFvcnY0S0RQc1M2MVhXQy84Qi8wR3lNUnJ3SEhlRVBqR21pY0VLWVRmTFZl?=
 =?utf-8?B?a2Z2azJYNnhNNzErenVxdllnSEhZd0kyS01IeTFqYUczTHdyWDZGZHpaWm5Z?=
 =?utf-8?B?cCtBVjNMb2grVElYSXc2K1U1NlIzdzdrWGFpcm83b3duc0R3TzB4THpUMHN5?=
 =?utf-8?B?TkhiRmNreXBrQjhRREw5MGt1RWpLbWJrcDdmakVuL08vTlBRYjIwektRaW5y?=
 =?utf-8?B?bnprMURGZVFjaUJLNTZmN1Y0OU5tRGdSUWFRdmNaMEN6RGhxMnFPUm1oU2pl?=
 =?utf-8?B?MVNxdk9LWm1HdmlJU0xNZXFoY0I0djc5b0J5THovcUFtWklLd1VxWGlKbUxz?=
 =?utf-8?B?MXdUUWIwR1pEVldmZTZFTG5jRTA4K3ZhbVJJV0xNK2MrMlJJN2YySkowV3Rx?=
 =?utf-8?B?T2ZzQ0szQTJ4amJoK1ZMY1NTREhyK1RpclNReVd3VnBYWnY0bUhKbGY2VmQ3?=
 =?utf-8?B?VWtWbmUvR1o2VHBDcGhmTkVRVzFYVU5Xc1Z0dUVwZUF3UE1veTBmR3MwdTFX?=
 =?utf-8?B?RDJSQjJ6TUpDaUd2QzQ2Z1JuZUFwV2FreWcvU1p4UWp3b0hUZXNOYnpkeXQ1?=
 =?utf-8?B?SCtzSHZOT3RWUVF3Z0FvZmh2QUkrUXgrbEJ0WE1QbVFPdkczdTJ3WTQxSDRE?=
 =?utf-8?B?UkFQLzYrRE9FNlFnK0Y1UldlZStvQ2ZEWjAzdG9LcEVJTE16Uk8ydjhNUkV1?=
 =?utf-8?B?Ti8yTXZxcXRnbldQcHhuV244VDVhU1hUdVB4QjhqUndkdkxPdnNnV0dSOEZx?=
 =?utf-8?B?dDVaYVhQeHBNVzZkd3IrNE1STU1aZWpCRERmVXQ5ZVV5WFpUeFl3U2VwaW14?=
 =?utf-8?B?V2IrYVh3WmljNU4vV252bGpiYlo5RlJ3dFhCc1JqWjBPWmM2NVJBbkEyZUpt?=
 =?utf-8?B?QmZLaEVtV3BXaUJpSUd1RFoxNzRmbTh6ODF3dk9TK2w3ZUt4TEloK2F4enVH?=
 =?utf-8?B?OERobjFDSWZBV0ZFVTZwNGlzRXFRNkZFeWY3UXU0TUV2UTdqZVNCdkZ5ZXBr?=
 =?utf-8?B?U2U4ZFVWMkFCc3VIMHc2OFE2KzkrVVJ4V29NTWRkaS9XSDNsUkhTczExaFFR?=
 =?utf-8?B?Lysrc0VJZUU4U1NGeTJOWVFuQWpYK28xMWF5aDhBbUx3bGJSaklOS2ViU2lH?=
 =?utf-8?B?UVdYR2hoVUFIWitNaFRTd1BNMzRncFJDSjlNVkFaYkd5UlQ5T1RpSWp5ektS?=
 =?utf-8?B?SlNPclVOa2JQSVNvV3FzSzBsUGcvRGV2V1lpZVhYd09tOEJQSVMrQVh6SjlG?=
 =?utf-8?B?UldNcCsxZE5EUVFMMzdFSnBKZU1MaEhicmM4YlhScC9SVUYrNE8rYjFHVnRH?=
 =?utf-8?B?Z0xYeXZGNGRqT0k3dVVuKzFHNENjOGFZM2dmMU1Idlo4azI4QVI4M2RYSkNI?=
 =?utf-8?B?ZTZIdHhUY0JyZWNJaUl0dFR4MzFOMzgwYlZtN2NtQUlWYUdVYk5FWUZZbksw?=
 =?utf-8?B?VGplTmpmdnA2Tk9Ta0p4cGRvVXNhNzhKVnprT284QmtOSWR2cGFLV1F4b0xy?=
 =?utf-8?B?dkpCbC9jczhHc3R3T1pVZmJnczhWWmVRekNEbHM4QWU1MWRjL3IyY1hYU0R1?=
 =?utf-8?B?NExxOFpnYml3TEFLMkJZUnBGREpsamFDS3gxcjN5ZXlxb2cvSU5TUEhSNWlJ?=
 =?utf-8?Q?Z0MKLc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f16c1f2-9d2d-40bb-4803-08dc60511560
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 09:14:14.6643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AbfKhb7aL+s2YXbPrdmmGCwgQ1mirfU4cbrLCvQEVv7iRo2je//uqhx+L6OgjXAg5o8PXn/3Yst8nDzzlwHsOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR83MB0670

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVwZS5jYT4NCj4gT24gV2VkLCBBcHIgMTcs
IDIwMjQgYXQgMDc6MjA6NTlBTSAtMDcwMCwgS29uc3RhbnRpbiBUYXJhbm92IHdyb3RlOg0KPiA+
IEZyb206IEtvbnN0YW50aW4gVGFyYW5vdiA8a290YXJhbm92QG1pY3Jvc29mdC5jb20+DQo+ID4N
Cj4gPiBJbXBsZW1lbnQgYWxsb2NhdGlvbiBvZiBETUEtbWFwcGVkIG1lbW9yeSByZWdpb25zLg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogS29uc3RhbnRpbiBUYXJhbm92IDxrb3RhcmFub3ZAbWlj
cm9zb2Z0LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9pbmZpbmliYW5kL2h3L21hbmEvZGV2
aWNlLmMgfCAgMSArDQo+ID4gIGRyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL21yLmMgICAgIHwg
MzYNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgaW5jbHVkZS9uZXQvbWFu
YS9nZG1hLmggICAgICAgICAgICAgfCAgNSArKysrDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgNDIg
aW5zZXJ0aW9ucygrKQ0KPiANCj4gV2hhdCBpcyB0aGUgcG9pbnQgb2YgZG9pbmcgdGhpcyB3aXRo
b3V0IHN1cHBvcnRpbmcgZW5vdWdoIHZlcmJzIHRvIGFsbG93IGENCj4ga2VybmVsIFVMUD8NCj4g
DQoNClRydWUsIHRoZSBwcm9wb3NlZCBjb2RlIGlzIHVzZWxlc3MgYXQgdGhpcyBzdGF0ZS4NCk5l
dmVydGhlbGVzcywgbWFuYV9pYiB0ZWFtIGFpbXMgdG8gc2VuZCBrZXJuZWwgVUxQIHBhdGNoZXMg
YWZ0ZXIgd2UgYXJlIGRvbmUNCndpdGggdXZlcmJzIHBhdGhlcyAoaS5lLiwgdWRhdGEgaXMgbm90
IG51bGwpLiBBcyB0aGlzIGNoYW5nZSBkb2VzIG5vdCBjb25mbGljdCB3aXRoIHRoZQ0KY3VycmVu
dCBlZmZvcnQsIEkgZGVjaWRlZCB0byBzZW5kIHRoaXMgcGF0Y2ggbm93LiBJIGNhbiBleHRlbmQg
dGhlIHNlcmllcyB0byBtYWtlDQppdCBtb3JlIHVzZWZ1bC4NCg0KSmFzb24sIGNvdWxkICB5b3Ug
c3VnZ2VzdCBhIG1pbmltYWwgbGlzdCBvZiBpYl9kZXZpY2Vfb3BzIG1ldGhvZHMsIHRoYXQgaW5j
bHVkZXMNCmdldF9kbWFfbXIsIHdoaWNoIGNhbiBiZSBhcHByb3ZlZD8NCg0KVGhhbmtzLA0KS29u
c3RhbnRpbg0KDQo+IEphc29uDQo=

