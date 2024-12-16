Return-Path: <linux-rdma+bounces-6539-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA269F308B
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Dec 2024 13:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0E4118856A4
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Dec 2024 12:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143FD204F94;
	Mon, 16 Dec 2024 12:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UCu/tb6/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A14204F75
	for <linux-rdma@vger.kernel.org>; Mon, 16 Dec 2024 12:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734352285; cv=fail; b=bMVfIWGqIDiA7kDKRZtRnLseSq24nQ+/OC6Z/51x9G3WtfiUrWwj+oP3MYUlja2f4T5t/+MpG7Q0915a5SPH6sOSewI9jcD1FlLK6lptKhoi1FAI+jRrwZo1O8kFCphp+xPrVXS/zLjC7qiZ9h2Cjngy2Rh2+CGoTC5hqAr6v/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734352285; c=relaxed/simple;
	bh=91ZGsGNKZC1vdpTGpsMVa3ayg4q7Etx0/jISJsCWpNU=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=ti8ap2dGByeD6WRw+MUXCEE5DDhpEUzheTBeuDPQdAkXqwmGvbTVeaNOUaURsHtDvNiehjcjlVtuvznlW4EK8Vx4KTYfe09gR640F/YT5RMVd1GDzAeS+nBXG9Yqxlq8sebJX5ZajjzgrqpNO+1cX/yxpBXxvZFrWTe8Dbo+A7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com; spf=pass smtp.mailfrom=zurich.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UCu/tb6/; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zurich.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG85d77027035
	for <linux-rdma@vger.kernel.org>; Mon, 16 Dec 2024 12:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0/zfiS
	mot70hmtt59muAtPHUmTNVj+geivTFVrX3ZaY=; b=UCu/tb6/BkMbRFPv1XhrtY
	8iWu7hXW1pAl0uzd9WO6WmspkaIEQTw8ClHRNZWVFaccII1mKqt6z7isOyQJxIFQ
	/G1dCdCWZDIXhHlB+2KU6QuUtcWM7hS85sdxVMwOhWAipj1AKKSUiI8Wfg9Fk39I
	crv1jSMznLLGuV0hlAc/kXMXgFlVTGfxTFkRQpJUKqR9CM/XbgpxOUKyb3U/X02s
	NEp5h8uSaZ047eSLiiQg8YePPdwyBmTrXhtQIHC2D+k8RJlRLYM+2ifr4424w0v8
	QmV7gUdpNantXN9Rb23/ntV9RE5J+nyF2uBtnGvgbgzwnUltpp9GOa3F+JiA8EqQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jgd295mg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Mon, 16 Dec 2024 12:31:21 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BGCVLTq003758
	for <linux-rdma@vger.kernel.org>; Mon, 16 Dec 2024 12:31:21 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jgd295m7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 12:31:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q3Jk2idjdtt15qaLLaFYDyjg2aC4nu37IboBV4WF/IGqcRjPgTFuAlKQjwaVuqbyoASIHCmtFT5IwUpDjc0DfFnlLGTnhDSt0ek8eA4sB6QhzIAG4uuDedTyPHXMBtfaRSNVZCp6fXkR6R76wpsEN9HJpuvkUEgfMWs8AN5X9ec5JFIDVRnxBmF/FbFnEVKTMWI+/PDPFPhWIoau4tutTOATmXuZBHZNfuKnr6I27U8/KkQ/Jdu6bN6SpJvy1w/cBbi5piYq6dy49pAhrgJlpq17Su4yMBZ7aM4EmwTMdDK4yIVU3ozpNg0hYpRTp82dNSXdtuREV137wJ51b2z2KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IU7QUZ6crz0WEHePUXqUsHm3dlXpsVpc6EjARoDMIx4=;
 b=bVfGYxnPezjOsxvW6oMg+UTwWSk7nk2VznfVI6QHEaOj/dx/zxEg7cFub4gkz/+FMIEm3dSjclE1RuP/yF3DpbdZi3+/+KIDo7q4NZmbMAgkXg8djxruPUrw3LPKeco4MGVpdmKzw49ea4IOyX+3nHTMW0/Vn78pzdNq9ZUg90OJVH4L4lEr4fws1rEIqowtjWRImaaoDC0F5pFUVX8fekGsxuMSwyTlIoKxcsMPgOTx7nxnaaXVST3yjV0QQlB42elHyy0KfHwDTrdX45xhM9YQBlzN/MZ2aXDc4MHgXv6TmVDIY5Q8yGzufjo3oXZTQ1e6aO7wQV6QAQnddvQxyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BN8PR15MB2513.namprd15.prod.outlook.com (2603:10b6:408:cc::30)
 by PH7PR15MB5128.namprd15.prod.outlook.com (2603:10b6:510:131::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 12:31:18 +0000
Received: from BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::dd5e:86f1:8719:2f16]) by BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::dd5e:86f1:8719:2f16%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 12:31:18 +0000
From: Bernard Metzler <BMT@zurich.ibm.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>,
        "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
CC: "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH RESEND v2] RDMA/siw: Remove direct link to
 net_device
Thread-Index: AQHbTKktmj5cCfPnAUuHj3BGqh2N47LlsJ6AgAHmKYCAATucUA==
Date: Mon, 16 Dec 2024 12:31:18 +0000
Message-ID:
 <BN8PR15MB25132F4B52A7334CBF3AF26E993B2@BN8PR15MB2513.namprd15.prod.outlook.com>
References: <20241212151848.564872-1-bmt@zurich.ibm.com>
 <163b6d77-3e26-4789-8e87-50b989701c9c@linux.dev>
 <b2a32a23-19b9-4344-9bd8-cc83d657bbeb@linux.dev>
In-Reply-To: <b2a32a23-19b9-4344-9bd8-cc83d657bbeb@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR15MB2513:EE_|PH7PR15MB5128:EE_
x-ms-office365-filtering-correlation-id: 08bf9a3a-dd4c-4727-bd19-08dd1dcd8a76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d0tONk9sSUwzMW4xQlk0ekxadFZzRjVjR3g1bnFyZUJLb3J3TUFTVWtpaFd3?=
 =?utf-8?B?VkpTeGtSS1Q2WC9lb2lDUjEyUmRaanJtMXBTLzN1OW5pU1F0cTk5eWtNUWE0?=
 =?utf-8?B?ei9KOEdIcGtYQ09YajM4TWJCZXpsTUpBUHlqYXE3eGRMTVZFNkVJWUY2U09U?=
 =?utf-8?B?YVh2b3hTSzlDTFhMdS9WUm1aK3dUemhEZ0FBM2ZDc1VWTWFjU0hxRDFpZ2Mw?=
 =?utf-8?B?SHdlcUUzNVlLZ0g4WTRwK2ROMlhHTjlPcXRRSk5JQU9NRXUwUmdCTWl2RmlB?=
 =?utf-8?B?N2ExZFg4YU1FSFBocGhkNlRFMkpLaVlJa3Y2NEhsQlhIN21sMHdpSjNxWXlp?=
 =?utf-8?B?bEMranJRMTlubnFDSG5PRlpRL2FZME1HaVpFWmc2OUFOTm9FUStheUkxeTNC?=
 =?utf-8?B?WFJ2OU0rdnRVZmg0Y29iSGZneVNPRGlDbHNoWENLV2h0QUdBZFdZMkVsRytH?=
 =?utf-8?B?YStqcXVMSnRldUliclBtZFV3T2FrbU5qMmJ3VjZZMUlvNDJwZSs2cm9WaWNn?=
 =?utf-8?B?aHI1S0ZWRDFaVUlGWjYxNUU2NjRabVhiV0dSTjVaUUdhYVU4UDlGL1VMc0g0?=
 =?utf-8?B?RVp1L0UwVUtsVnVZOEIrV0NrcHRKZ29jaVdsNUZFdk1lNjRIZGU3V3M3SWlF?=
 =?utf-8?B?b2FFRXlaQnlJQ2lDTFIwWmlFTy83bEVWY2dudndFbk8wTDJLZUpqNjJQWGFw?=
 =?utf-8?B?SSt4cVBnSkRlcHNqNGt2amNZZko0RlNCcTA2dDZtZ2gzVkplc2ZrdnhqNHFX?=
 =?utf-8?B?a2I3VzhLdk04ZXNLNFJMSDg2VzJmTENpSmFQTnE0djVMQjhTUUlnK1RRK1RG?=
 =?utf-8?B?ZjJjSTJqR0R0TW1OVlNkaDhXK3JrbHlTZE5wbWFENWNISVJ5Rm0wUkVhTUFL?=
 =?utf-8?B?VGZYem1CRUVSVWdqdjlPdzNtb0YxOGZLQS95bnlRaEpNczdFZ0FBUlhXZU1I?=
 =?utf-8?B?NVBSczIwZW1TUkcvanJKMUQyUHB5elFuWG41amVLeHplYmpLQU9uMGM2RXhU?=
 =?utf-8?B?RGJubER4UDRJSW5RM3JySEpuRXl6cUJWdVB1allBOVlqUmtHc0RiUVRQMVpy?=
 =?utf-8?B?UU1adnhpcmRGdjd1dzhnK0R1akVNQ0l2VXhQbkpoVFdzTncvcUwxcEpqVDJp?=
 =?utf-8?B?STFUaEd5blhORHY4MnJxc1hzVUU3aVg1eW1xUThGWGNEMklJODkwRU94ZmZV?=
 =?utf-8?B?WGFiZlJwVS9iUHU5WHRYQzVRN092SmdoUXgwYWJHaUljZEtaNTFNa0RGZUFZ?=
 =?utf-8?B?U0xvejVvRGlmM0NjbEhocFFjbmY2NUR4ejF0YmlKZVphUHVuY255aGh0eVBK?=
 =?utf-8?B?cG9OUk5RL3N3amxLUXd0NGpiempUVStYTFl2THM5eUh2N2lPU0xyOWtQWFg5?=
 =?utf-8?B?SzJnTjl5OHJ2cmVRWUlFeVkrUmFlZXBVYS80dnkxcm9DZDBGemc1V0NxbVRy?=
 =?utf-8?B?MGFzNUtXb2VOT2x5dUxoMS9kOFhrK0poTC85elVObFAyeHdPMDIwSVNiTGRD?=
 =?utf-8?B?Z0pWNTFqdW05N3ZFTktpZVBlVVEvQ1g4UmZpQ1Y0WmYvUGZoSkJzaHNLdDJH?=
 =?utf-8?B?MjZSN2l2cmJkR2trUlp0ekJNRTYxWmhkbXVzdVRXZjU0L2l4MTFlbnExMFBW?=
 =?utf-8?B?aGw3SUNWUTJEa0tkbWNON2xVM21iMHVRclhoVnJwYVVKN1VRUWFvUmpKYkRF?=
 =?utf-8?B?eDZnc0RNRmZOTTcyYmtHLzZkakVnN3F2TmtVZENISnV0VkVxbE5pZGxjT0x1?=
 =?utf-8?B?L2hFandoaDlHMkFtVkN0U0VneXFZbFpMQUJHMUc2dGlqMmhuYXhpeStBT0ph?=
 =?utf-8?B?bGxiZlFwYzVhQWpQN0FuYXgvOFI2Z2dtdzJaYlpKVUVoLzVNMVpNTTNoM3ho?=
 =?utf-8?Q?cmhMwYRrA/tFK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB2513.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MlY4TW5hTlFqaXRDVCs5OXc3TStzc1VuZ0hld3IvejVobjhjZ2hVZUN4KzhI?=
 =?utf-8?B?dEpkSWt1d0hwOEUzOFlhMlQvQjY4ZFhuWTZYMVc2Sk9EU3luMEkxeFhpN1Fr?=
 =?utf-8?B?R0prc21ZYVRzWHdiTGdvalkvd3dsdWVsUGdaVnpESjNOdWxiMi9VUEhqQ2Y0?=
 =?utf-8?B?akRkcVJWdnNtbldNS0xBUkcwVkRWZlB1RWRUTWZndnp5K1ZkY1JzazBkZXQv?=
 =?utf-8?B?cjhSUmdQNjIxN3U2amUyY3hiWExnZGxsOTVlWm5HZGRROTZOdkJNRnhoekxW?=
 =?utf-8?B?MzlnTTEyY2t0RE9RRWhGWHE4cUdKb0d2MG9PVTZPc0ZJUWMxamN5YzJIZUlG?=
 =?utf-8?B?ZHNOZDc0aVZ0WENRSHpxSXpyNFJUNUpLZGhkUHZWOEFZQUZzZTQ1VW9WZzcy?=
 =?utf-8?B?Y042bG82b2RUVTNIcENVVE4vK051cGRMRjJRdFdUSk5MOHUzMGV6RjZMN3p6?=
 =?utf-8?B?UkNqaXpjU1NZL3FRREhGRVlvc211ZVorWnZ5cjg5MFgxZGk3Q0pwYm05emp2?=
 =?utf-8?B?ZG92MDE1b1BSTkVrczAzUUYvUWdoYW1mcTFEd1FpOVNZSlg3Uk9tbDM2YUNB?=
 =?utf-8?B?N2NkQ3dJTEdZbzRwSW4vYjJDTzZkYysvOERwdGZZNEk4aDdHNHZuWE9xRyt1?=
 =?utf-8?B?TWFtelhLbXRpR1FMMjVnNkM0QzAweEFMNE42eSszVFNUbWR5SWdkaTJrdEFK?=
 =?utf-8?B?akR1SVVlT1B0YlZiUmdvMHB6Vm4wYUozNTN5ZEVaTndBdDRwZmdyeHNFNE1L?=
 =?utf-8?B?anh0WkttUjk3S3FKajZNTGYrSkVWTTd2REI4cHBoaXFxaGNBcGE4SXRkbkw2?=
 =?utf-8?B?a09DNkEyemx1NWhINGxXNVhXMFFzRForWmZ6a2MrQjdFdDBzeW5ZVExzZmh2?=
 =?utf-8?B?OWo3WThLUFB5TnQxNjkwcFNVZWVPRHhRekpVTVVodnU0WkIzaW9TR25LbHI5?=
 =?utf-8?B?RTBKOU9uTmxqTmxMdm1ZWC8zZWl2TjJHNmFSMmNoSzlWZU5jYy9iK1JVaWtr?=
 =?utf-8?B?cStvMVcvelBsdGpkMXJqWGVpNmtPVGhsc3d4bHE1aDdSS3lOUnhWcHZzMVpp?=
 =?utf-8?B?eklLZlJuaTB3a01zZVB2NENOTXVCYzM3SFZkYnRjbE9oNmdxNXhDbXE2SDFp?=
 =?utf-8?B?b29IL2xmdGx5c1NldkVXaDhqOUt3cEhpZ2hPQm1vSzNaY2grRWhPOTVFdkI4?=
 =?utf-8?B?SHUxN0h2U3d4NTNya1l2N3I0VU1NUnk4NXE1MkxhSzVmRDZJQXE0ejJuYnpr?=
 =?utf-8?B?dHBGY05ISTgreTEvK1FTdzUxR0UxK1I5QmpnYWt6SzlwNUxqc1lZTWZrSjc0?=
 =?utf-8?B?SnNZYkdjV1RYUmh3QzdGZ1RJZWg2NnduNTBUZ21FMGZRNzJXUWJYd0dEMGNq?=
 =?utf-8?B?THdpd3pmckZvdmppRFRpeFJ4UlNnVVdKdnVTRERIOWdqdjNoakF1VGF2WXNK?=
 =?utf-8?B?NEg5aWFVL045OEpyL3NsYVZsYTZUY2dPOWNPL0JaZ3BrVWtyZS90azlRUWhF?=
 =?utf-8?B?UnBrOWlUQXA0d1R1QUcrYy9qWjU0R3FIbGpDY1NUWlVUbzhIdVR0ZEVlbUhG?=
 =?utf-8?B?OHNYeHpkSmFaSWlGUDdKUS9xcTNOQjY1cmtLUG9zbUo4dDJtMTgxZElKQVZk?=
 =?utf-8?B?R3hkRVFTbmZ3S2c4ais4Sms5YnUrUytmZHNZeVNhUGRxem54STkxZTlPSGtH?=
 =?utf-8?B?OXBEYkZwTHFZMHJPNEZlSlZqT25wTWlHanVpdE11cFRlQU1QTGxpOCt6V3JH?=
 =?utf-8?B?NFRTUUR4Mjl6bDlZbTNTdlZ6bnR2cEx6Y3UySWxTWEZneTBPSGxyZkJ4c0tP?=
 =?utf-8?B?a3crUVhkLzI1SzUrMFFXdkl5ajVzVEdwVjU3c0xNOWtVNFF1V1ZHekFIKzNr?=
 =?utf-8?B?SnoyOFV3Tkg5cm1LcjVaRnUvMFpnSmZlU2pDdEoyZGtpOVlkT3MzZUs2Vjdr?=
 =?utf-8?B?WkkxYWhyR2JsbGNRNGxSYnFJUnFvcml5ejh3eTFVa2tPb0xQZERYbk1KVWNO?=
 =?utf-8?B?MkxERy8rbWVYaCtXcDE2d2N2dHl5dnFvZ0NxYzZwWVdBeDkxMzhETEFhWVBQ?=
 =?utf-8?B?SHlSNzVLck5BSkxqOVpBU3dZc2RwNElqdjRyckc2bUFWN0NjWk9Bc3FiSXky?=
 =?utf-8?B?Ty9pUE1aK2R6cGFuOXlwUTJZekN0ZkFmaTg4UUIzSjZacU5mTGpTL2tablVD?=
 =?utf-8?Q?fkWgdIK/V+grhOxntSXSfvY=3D?=
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB2513.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08bf9a3a-dd4c-4727-bd19-08dd1dcd8a76
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2024 12:31:18.4758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EB3E0hndq2X+oh21E3G/vAumsSd1/ZCNjJ7VBm5qMCPWz+LOT10lGW9qwBy9KYChVQXZtblgmzWag+VcJAP0QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5128
X-Proofpoint-ORIG-GUID: ZJIXnE-wC4ticP-pYz5p8KUW6FMhcCRA
X-Proofpoint-GUID: ZJIXnE-wC4ticP-pYz5p8KUW6FMhcCRA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH RESEND v2] RDMA/siw: Remove direct link to net_device
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 priorityscore=1501 malwarescore=0 impostorscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=2
 engine=8.19.0-2411120000 definitions=main-2412160105



> -----Original Message-----
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> Sent: Sunday, December 15, 2024 6:38 PM
> To: Bernard Metzler <BMT@zurich.ibm.com>; linux-rdma@vger.kernel.org
> Cc: jgg@ziepe.ca; leon@kernel.org; linux-kernel@vger.kernel.org;
> netdev@vger.kernel.org; syzkaller-bugs@googlegroups.com;
> zyjzyj2000@gmail.com; syzbot+4b87489410b4efd181bf@syzkaller.appspotmail.c=
om
> Subject: [EXTERNAL] Re: [PATCH RESEND v2] RDMA/siw: Remove direct link to
> net_device
>=20
>=20
>=20
> =E5=9C=A8 2024/12/14 13:37, Zhu Yanjun =E5=86=99=E9=81=93:
> > =E5=9C=A8 2024/12/12 16:18, Bernard Metzler =E5=86=99=E9=81=93:
> >> Do not manage a per device direct link to net_device. Rely
> >> on associated ib_devices net_device management, not doubling
> >> the effort locally. A badly managed local link to net_device
> >> was causing a 'KASAN: slab-use-after-free' exception during
> >> siw_query_port() call.
> >>
> >> Fixes: bdcf26bf9b3a ("rdma/siw: network and RDMA core interface")
> >> Reported-by: syzbot+4b87489410b4efd181bf@syzkaller.appspotmail.com
> >> Link: https%=20
> 3A__syzkaller.appspot.com_bug-3Fextid-
> 3D4b87489410b4efd181bf&d=3DDwIDaQ&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3D4ynb4Sj_=
4MUcZXbh
> vovE4tYSbqxyOwdSiLedP4yO55g&m=3DSr4DcK0Wb4iQYxeAGdwnJVj231gGpXbdjE0vjQXbp=
MgNG
> MrUQnjp4I9ZuzuThnlu&s=3DJMDawq7uiJd4vTvguvjXj0pC2okvGwSJ-mB05JlZJX4&e=3D
> >> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> >> ---
> >> =C2=A0 drivers/infiniband/sw/siw/siw.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 7 +++---
> >> =C2=A0 drivers/infiniband/sw/siw/siw_cm.c=C2=A0=C2=A0=C2=A0 | 31 +++++=
++++++++++++++-----
> >> =C2=A0 drivers/infiniband/sw/siw/siw_main.c=C2=A0 | 15 +-----------
> >> =C2=A0 drivers/infiniband/sw/siw/siw_verbs.c | 35 ++++++++++++++++++--=
-------
> >> =C2=A0 4 files changed, 53 insertions(+), 35 deletions(-)
> >>
> >> diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/
> >> siw/siw.h
> >> index 86d4d6a2170e..ea5eee50dc39 100644
> >> --- a/drivers/infiniband/sw/siw/siw.h
> >> +++ b/drivers/infiniband/sw/siw/siw.h
> >> @@ -46,6 +46,9 @@
> >> =C2=A0=C2=A0 */
> >> =C2=A0 #define SIW_IRQ_MAXBURST_SQ_ACTIVE 4
> >> +/* There is always only a port 1 per siw device */
> >> +#define SIW_PORT 1
> >> +
> >> =C2=A0 struct siw_dev_cap {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int max_qp;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int max_qp_wr;
> >> @@ -69,16 +72,12 @@ struct siw_pd {
> >> =C2=A0 struct siw_device {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ib_device base_dev;
> >> -=C2=A0=C2=A0=C2=A0 struct net_device *netdev;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct siw_dev_cap attrs;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 vendor_part_id;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int numa_node;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char raw_gid[ETH_ALEN];
> >> -=C2=A0=C2=A0=C2=A0 /* physical port state (only one port per device) =
*/
> >> -=C2=A0=C2=A0=C2=A0 enum ib_port_state state;
> >> -
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spinlock_t lock;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct xarray qp_xa;
> >> diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/
> >> sw/siw/siw_cm.c
> >> index 86323918a570..b157bd01e70b 100644
> >> --- a/drivers/infiniband/sw/siw/siw_cm.c
> >> +++ b/drivers/infiniband/sw/siw/siw_cm.c
> >> @@ -1759,6 +1759,7 @@ int siw_create_listen(struct iw_cm_id *id, int
> >> backlog)
> >> =C2=A0 {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct socket *s;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct siw_cep *cep =3D NULL;
> >> +=C2=A0=C2=A0=C2=A0 struct net_device *ndev =3D NULL;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct siw_device *sdev =3D to_siw_dev(=
id->device);
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int addr_family =3D id->local_addr.ss_f=
amily;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int rv =3D 0;
> >> @@ -1779,9 +1780,15 @@ int siw_create_listen(struct iw_cm_id *id, int
> >> backlog)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sockaddr=
_in *laddr =3D &to_sockaddr_in(id->local_addr);
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* For wildcard=
 addr, limit binding to current device only */
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ipv4_is_zeronet(laddr-=
>sin_addr.s_addr))
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s-=
>sk->sk_bound_dev_if =3D sdev->netdev->ifindex;
> >> -
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ipv4_is_zeronet(laddr-=
>sin_addr.s_addr)) {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nd=
ev =3D ib_device_get_netdev(id->device, SIW_PORT);
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (ndev) {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 s->sk->sk_bound_dev_if =3D ndev->ifindex;
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } =
else {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 rv =3D -ENODEV;
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto error;
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv =3D s->ops->=
bind(s, (struct sockaddr *)laddr,
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(struct sockaddr_in));
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> >> @@ -1797,9 +1804,15 @@ int siw_create_listen(struct iw_cm_id *id, int
> >> backlog)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* For wildcard=
 addr, limit binding to current device only */
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ipv6_addr_any(&laddr->=
sin6_addr))
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s-=
>sk->sk_bound_dev_if =3D sdev->netdev->ifindex;
> >> -
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ipv6_addr_any(&laddr->=
sin6_addr)) {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nd=
ev =3D ib_device_get_netdev(id->device, SIW_PORT);
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (ndev) {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 s->sk->sk_bound_dev_if =3D ndev->ifindex;
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } =
else {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 rv =3D -ENODEV;
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto error;
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv =3D s->ops->=
bind(s, (struct sockaddr *)laddr,
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(struct sockaddr_in6));
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >> @@ -1861,6 +1874,9 @@ int siw_create_listen(struct iw_cm_id *id, int
> >> backlog)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_add_tail(&cep->listenq, (struct li=
st_head *)id-
> >> >provider_data);
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cep->state =3D SIW_EPSTATE_LISTENING;
> >> +=C2=A0=C2=A0=C2=A0 if (ndev)
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_put(ndev);
> >> +
> >
> > <...>
> >
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 siw_dbg(id->device, "Listen at laddr %p=
ISp\n", &id->local_addr);
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> >> @@ -1880,6 +1896,9 @@ int siw_create_listen(struct iw_cm_id *id, int
> >> backlog)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sock_release(s);
> >> +=C2=A0=C2=A0=C2=A0 if (ndev)
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_put(ndev);
> >> +
> >
> > dev_put will invoke netdev_put. In netdev_put, dev is checked.
> > Thus, no need to check ndev before dev_put function?
>=20

Thanks for the review.

Sending this to RDMA only for now. Since kernel 5.10,
this NULL check has been introduced. siw is in Linux
since 5.4. Shall I care about back porting,
or just follow Zhu's recommendation with a corrected
resend?

Thanks,
Bernard.


> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>=20
> Zhu Yanjun
>=20
> >
> > static inline void netdev_put(struct net_device *dev,
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 netdevice_tracker *tracker)
> > {
> >  =C2=A0=C2=A0=C2=A0 if (dev) {
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 netdev_tracker_free(dev, tr=
acker);
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __dev_put(dev);
> >  =C2=A0=C2=A0=C2=A0 }
> > }
> >
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return rv;
> >> =C2=A0 }
> >> diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/
> >> infiniband/sw/siw/siw_main.c
> >> index 17abef48abcd..14d3103aee6f 100644
> >> --- a/drivers/infiniband/sw/siw/siw_main.c
> >> +++ b/drivers/infiniband/sw/siw/siw_main.c
> >> @@ -287,7 +287,6 @@ static struct siw_device *siw_device_create(struct
> >> net_device *netdev)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 base_dev =3D &sdev->base_dev;
> >> -=C2=A0=C2=A0=C2=A0 sdev->netdev =3D netdev;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (netdev->addr_len) {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(sdev->ra=
w_gid, netdev->dev_addr,
> >> @@ -381,12 +380,10 @@ static int siw_netdev_event(struct
> >> notifier_block *nb, unsigned long event,
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (event) {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case NETDEV_UP:
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sdev->state =3D IB_PORT_AC=
TIVE;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 siw_port_event(=
sdev, 1, IB_EVENT_PORT_ACTIVE);
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case NETDEV_DOWN:
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sdev->state =3D IB_PORT_DO=
WN;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 siw_port_event(=
sdev, 1, IB_EVENT_PORT_ERR);
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> >> @@ -407,12 +404,8 @@ static int siw_netdev_event(struct notifier_block
> >> *nb, unsigned long event,
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 siw_port_event(=
sdev, 1, IB_EVENT_LID_CHANGE);
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> >> -=C2=A0=C2=A0=C2=A0=C2=A0 * Todo: Below netdev events are currently no=
t handled.
> >> +=C2=A0=C2=A0=C2=A0=C2=A0 * All other events are not handled
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> >> -=C2=A0=C2=A0=C2=A0 case NETDEV_CHANGEMTU:
> >> -=C2=A0=C2=A0=C2=A0 case NETDEV_CHANGE:
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> >> -
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >> @@ -442,12 +435,6 @@ static int siw_newlink(const char *basedev_name,
> >> struct net_device *netdev)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sdev =3D siw_device_create(netdev);
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (sdev) {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_dbg(&netdev=
->dev, "siw: new device\n");
> >> -
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (netif_running(netdev) =
&& netif_carrier_ok(netdev))
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sd=
ev->state =3D IB_PORT_ACTIVE;
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sd=
ev->state =3D IB_PORT_DOWN;
> >> -
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ib_mark_name_as=
signed_by_user(&sdev->base_dev);
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv =3D siw_devi=
ce_register(sdev, basedev_name);
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (rv)
> >> diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/
> >> infiniband/sw/siw/siw_verbs.c
> >> index 986666c19378..7ca0297d68a4 100644
> >> --- a/drivers/infiniband/sw/siw/siw_verbs.c
> >> +++ b/drivers/infiniband/sw/siw/siw_verbs.c
> >> @@ -171,21 +171,29 @@ int siw_query_device(struct ib_device *base_dev,
> >> struct ib_device_attr *attr,
> >> =C2=A0 int siw_query_port(struct ib_device *base_dev, u32 port,
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 struct ib_port_attr *attr)
> >> =C2=A0 {
> >> -=C2=A0=C2=A0=C2=A0 struct siw_device *sdev =3D to_siw_dev(base_dev);
> >> +=C2=A0=C2=A0=C2=A0 struct net_device *ndev;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int rv;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(attr, 0, sizeof(*attr));
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv =3D ib_get_eth_speed(base_dev, port,=
 &attr->active_speed,
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 &attr->active_width);
> >> +=C2=A0=C2=A0=C2=A0 if (rv)
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return rv;
> >> +
> >> +=C2=A0=C2=A0=C2=A0 ndev =3D ib_device_get_netdev(base_dev, SIW_PORT);
> >> +=C2=A0=C2=A0=C2=A0 if (!ndev)
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENODEV;
> >> +
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attr->gid_tbl_len =3D 1;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attr->max_msg_sz =3D -1;
> >> -=C2=A0=C2=A0=C2=A0 attr->max_mtu =3D ib_mtu_int_to_enum(sdev->netdev-=
>mtu);
> >> -=C2=A0=C2=A0=C2=A0 attr->active_mtu =3D ib_mtu_int_to_enum(sdev->netd=
ev->mtu);
> >> -=C2=A0=C2=A0=C2=A0 attr->phys_state =3D sdev->state =3D=3D IB_PORT_AC=
TIVE ?
> >> +=C2=A0=C2=A0=C2=A0 attr->max_mtu =3D ib_mtu_int_to_enum(ndev->max_mtu=
);
> >> +=C2=A0=C2=A0=C2=A0 attr->active_mtu =3D ib_mtu_int_to_enum(READ_ONCE(=
ndev->mtu));
> >> +=C2=A0=C2=A0=C2=A0 attr->phys_state =3D (netif_running(ndev) && netif=
_carrier_ok(ndev))
> ?
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IB_PORT_PHYS_ST=
ATE_LINK_UP : IB_PORT_PHYS_STATE_DISABLED;
> >> +=C2=A0=C2=A0=C2=A0 attr->state =3D attr->phys_state =3D=3D IB_PORT_PH=
YS_STATE_LINK_UP ?
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IB_PORT_ACTIVE : IB_PORT_D=
OWN;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attr->port_cap_flags =3D IB_PORT_CM_SUP=
 | IB_PORT_DEVICE_MGMT_SUP;
> >> -=C2=A0=C2=A0=C2=A0 attr->state =3D sdev->state;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * All zero
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
> >> @@ -199,6 +207,7 @@ int siw_query_port(struct ib_device *base_dev, u32
> >> port,
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * attr->subnet_timeout =3D 0;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * attr->init_type_repy =3D 0;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> >> +=C2=A0=C2=A0=C2=A0 dev_put(ndev);
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return rv;
> >> =C2=A0 }
> >> @@ -505,21 +514,24 @@ int siw_query_qp(struct ib_qp *base_qp, struct
> >> ib_qp_attr *qp_attr,
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int qp_at=
tr_mask, struct ib_qp_init_attr *qp_init_attr)
> >> =C2=A0 {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct siw_qp *qp;
> >> -=C2=A0=C2=A0=C2=A0 struct siw_device *sdev;
> >> +=C2=A0=C2=A0=C2=A0 struct net_device *ndev;
> >> -=C2=A0=C2=A0=C2=A0 if (base_qp && qp_attr && qp_init_attr) {
> >> +=C2=A0=C2=A0=C2=A0 if (base_qp && qp_attr && qp_init_attr)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qp =3D to_siw_q=
p(base_qp);
> >> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sdev =3D to_siw_dev(base_q=
p->device);
> >> -=C2=A0=C2=A0=C2=A0 } else {
> >> +=C2=A0=C2=A0=C2=A0 else
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> >> -=C2=A0=C2=A0=C2=A0 }
> >> +
> >> +=C2=A0=C2=A0=C2=A0 ndev =3D ib_device_get_netdev(base_qp->device, SIW=
_PORT);
> >> +=C2=A0=C2=A0=C2=A0 if (!ndev)
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENODEV;
> >> +
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qp_attr->qp_state =3D siw_qp_state_to_i=
b_qp_state[qp->attrs.state];
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qp_attr->cap.max_inline_data =3D SIW_MA=
X_INLINE;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qp_attr->cap.max_send_wr =3D qp->attrs.=
sq_size;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qp_attr->cap.max_send_sge =3D qp->attrs=
.sq_max_sges;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qp_attr->cap.max_recv_wr =3D qp->attrs.=
rq_size;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qp_attr->cap.max_recv_sge =3D qp->attrs=
.rq_max_sges;
> >> -=C2=A0=C2=A0=C2=A0 qp_attr->path_mtu =3D ib_mtu_int_to_enum(sdev->net=
dev->mtu);
> >> +=C2=A0=C2=A0=C2=A0 qp_attr->path_mtu =3D ib_mtu_int_to_enum(READ_ONCE=
(ndev->mtu));
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qp_attr->max_rd_atomic =3D qp->attrs.ir=
q_size;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qp_attr->max_dest_rd_atomic =3D qp->att=
rs.orq_size;
> >> @@ -534,6 +546,7 @@ int siw_query_qp(struct ib_qp *base_qp, struct
> >> ib_qp_attr *qp_attr,
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qp_init_attr->cap =3D qp_attr->cap;
> >> +=C2=A0=C2=A0=C2=A0 dev_put(ndev);
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> >> =C2=A0 }
> >
>=20
> --
> Best Regards,
> Yanjun.Zhu


