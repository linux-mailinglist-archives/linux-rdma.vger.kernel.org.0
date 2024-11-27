Return-Path: <linux-rdma+bounces-6124-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F181C9DA825
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Nov 2024 13:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F82AB21940
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Nov 2024 12:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7B51FCD0A;
	Wed, 27 Nov 2024 12:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SKskP5r7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E552F1FCCF7
	for <linux-rdma@vger.kernel.org>; Wed, 27 Nov 2024 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732712275; cv=fail; b=n4x2xTzIGy3Q/WOP/PfTnxUWVTerlPv046e6vYwVTFFXtyq1FcVMRcgXdfR1ANTFPk/y3/sRNU0pEtCxaKQ3TP1ticCYajKbTNrES8Q656pte6Gkkn77hRfB78ajaRZemmwm1Bd1RlgQwQq3qzWmxkZ0mVzPi7zob9sXm77g+HY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732712275; c=relaxed/simple;
	bh=aWgv15Tew/AEz4UupuCKhkEKSRuBPx26CdPpKQ0MrEU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NlBdtHVfDyKeQJtYjjMJTU0OcytKbj3xkVeaSvb8+ELfwN2Qam3722nrrnOi8lKlCj0feJkG7l1oY65NeTkR9yHVwiwxd3FOEtTOCjHfy3E/HlPr63czEUVK9VmE5rAuRqYSCpo9HWa4xdy+k4gQPGZ0sBDmLLk7ZgeBs1T2htI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com; spf=pass smtp.mailfrom=zurich.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SKskP5r7; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zurich.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR1hNC8011930
	for <linux-rdma@vger.kernel.org>; Wed, 27 Nov 2024 12:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tCjZu8
	X5PsKKP8Z/o9oPEzNRTOks7WV5PGDYZdhB7JY=; b=SKskP5r7aUTGsHVGHoSVZc
	01OxLpfl+vhnEDcgFCt1c3sd9yihYKHvyrMfP4zvLbn4QrdTBawoC1a+ed7rn/hI
	FrhSS66yQM6Uxae5ml6hsJs8lsepvNdh34Yd+W6hXMK27H0wrokf3rkzdfk07AD9
	wR7kv0f5jKxTPMIL7RUDZKTrdOHz7TdvV5MhkDDTO5cimGq32EU6Rxt8vjB9y4eH
	ph8WifZIx60zZwW85ce6CLzTfslMP9ZbVJXoazMm1NohHEz4/uCoMmshz3CsAjUy
	LbLXu0/1iFJ8mnyFsdDj2XFNqhAmbIp/42QcK+DNTVMuM3JiqBJCUZVKImXloh3w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386k3by6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 12:57:49 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4ARCueCA025320;
	Wed, 27 Nov 2024 12:57:48 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2044.outbound.protection.outlook.com [104.47.57.44])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386k3by0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 12:57:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVFTPOAQ5+Ha3tslOGcdWsdxY/IMJSsAm+O3hkskewQpFsqKYQHyy4Mu5G8FzDgpKJ2WWcWLuMrBt2qOS1GJOFurnAuxPX7MSpL7b3NO4vfsuCj/TzjgK0/3pMVWJ57OnxsKXn7vaSSNPQ1BH47DT+lo6OddhhffJLjlUitI4Aj0eLv7rLrCttGKXepmqCKQK52JcPK0sKPbih2mQQulPTxLhGFf2skxxIHJYwEwrAm42lBjUprYGjdUo4asOZRxK09fBcsLHDjo/NDBY2uQJSGVPErA91FNrYC8Rlbl+3fG8fup/coIJdO3FFqoEPh5z58aio2JMtE57rMqMGYQsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ukxdlwbNsn2ddY8DRJKZQOx0PHjUrP0rAv+TdKpRo8=;
 b=aBuyTEcW0F11tM87Yl5DEHZ3Y3qj7hBCMh0bmo/Px5LFHZ0wLChuxtcfwa5e2y1ImnxlDLuQbuaWOUnM35Jc7cxmcLgoRkjWzxLAzy7xPsBeacGJUWtOtW33Qg3bYxAVm5dE+vse4EKRLHUzC2ToKFzOgv8k3+Cn2b4SKkEoVRcJZJZMojt/OPU/xiNYVk5lFCfg8LeOmFl4D7uToKE4dGDoLmHJ8zWLxAi0hnwpK3iNNIt4UGwjwrDLovTnNtFL5ZeeAKg6N4JGNeN/kvFCJqE/3N39/6ZtdbVROMPU9HyftRumSW26Nty2J8uC+6pz1cWz5H5KQr3WON/5P6COLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BN8PR15MB2513.namprd15.prod.outlook.com (2603:10b6:408:cc::30)
 by CH3PR15MB6119.namprd15.prod.outlook.com (2603:10b6:610:157::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Wed, 27 Nov
 2024 12:57:45 +0000
Received: from BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::dd5e:86f1:8719:2f16]) by BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::dd5e:86f1:8719:2f16%5]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 12:57:45 +0000
From: Bernard Metzler <BMT@zurich.ibm.com>
To: "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
CC: "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
Subject: RE: [syzbot] [rdma?] KASAN: slab-use-after-free Read in
 siw_query_port (2)
Thread-Topic: [syzbot] [rdma?] KASAN: slab-use-after-free Read in
 siw_query_port (2)
Thread-Index: AQHbQMvzIMPE0MitcUmfaD6cme436Q==
Date: Wed, 27 Nov 2024 12:57:45 +0000
Message-ID:
 <BN8PR15MB251331ECA48AD10C366BFCF199282@BN8PR15MB2513.namprd15.prod.outlook.com>
References: <6746eaef.050a0220.21d33d.0021.GAE@google.com>
In-Reply-To: <6746eaef.050a0220.21d33d.0021.GAE@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR15MB2513:EE_|CH3PR15MB6119:EE_
x-ms-office365-filtering-correlation-id: 8cf9ba83-1ad4-486a-dfec-08dd0ee31648
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZDFJYVUwcTloOEtSVDRkQlZ4aUVpTG5jUXFrZEozNDFZWGlkZFFWOWlNNkYx?=
 =?utf-8?B?UHI3THNudFFFM2poSEMzazJ1ZkgraXdPSDM2SFZlaGZ6a2tvOG4xWEdqWEVu?=
 =?utf-8?B?Ykp1MmZ5QTZKL3B5eEFjNWNoQytsUGhSczQySjNpZzJpVHVoeXcvNDZhdTNl?=
 =?utf-8?B?NXB2ZUgxa01pcjl1QWJuUTIrcVJwb25SaHJGTVh4MWE1K1k5bUpzSmZDN0ts?=
 =?utf-8?B?eFdWNTJwU1pkYzI2U2dpcm1TMitrK3pBNkZZUjFFZkZ3MlFBMVRvbU5aK3NP?=
 =?utf-8?B?T045WXNXMjZXbkVQcmQyNHd1RXlCTHpvU2hndEFwN2pUZ2w4bUpJWjJuVUdU?=
 =?utf-8?B?VHlUYVRHWXZBLytKU2N1ZVp1cU5MZHhvZU1vV3grR0NjQmpCeVNTTzQ2bDlG?=
 =?utf-8?B?S3ArUFN2Nkt1ZHRhMzBHdU1iRjl0aFBYOFF4VlhHMERKeldyTnJOa3VHTHlk?=
 =?utf-8?B?cTY2RTYxWXhGMmRJY3lsYjBOalR2aHBPWWRFTXU0VHZUKy83cmR2RFFHMXVx?=
 =?utf-8?B?T0JnaVA2cFhpQnU5TXFZU2F6cTAwekJ1VG9ITVczRTBzK2dtQUgxNnUyWDFL?=
 =?utf-8?B?S2xPdENpZGhsc0R1eGFvcWxYMkJXR0ozelREd2IrYlM5ODBoYUxkRlNtRzRy?=
 =?utf-8?B?QlR4VURVRkFFbkw4WGRmYVNuVjdYZ052UnJGcUdoZlhDK1lXUnplU2NXVW1S?=
 =?utf-8?B?UElzR21vbHpyREl1SVRqV01HRVExQ0FaSEFvK3dIcE5FSFE1bUpwczAvbDFj?=
 =?utf-8?B?R0xuSUJlQS9WdWkrenpJeHpGNGpZQXV2YXExaTJQTy9SMVdpMlovS3RzcmlK?=
 =?utf-8?B?THJrVmpFT1hPYkRUcmdVOVVIV2lCWUxMemVhM1hxM1VyRnJuNllZZGxMRkF0?=
 =?utf-8?B?RzQyL0RIN0xhNGltbnhONkVFZW1HUU9YK3dzODQ4UHViNm5RNktaSFlNQksw?=
 =?utf-8?B?OWVIT3RESVF2eUd1aDAvdDlCVDJyNkNzbjFZZTV4bTh5UDlLZDVub0gvZ2xt?=
 =?utf-8?B?WWNVbisxb3hGd1JvcjgvQTdic2VjTHZjL1h0UVBLL3Y5WFlKNkVSTEI1UCs2?=
 =?utf-8?B?K3dHVjdoZUxaRGQyRjFjcTc3UHRPSzRReTJsSFBpWTVONTd6OVZiSFQxd2xo?=
 =?utf-8?B?TFlxWVJKcEtRLzNUU2Q3bk1QNytwOHBQRVdWRUFhbnR1SlFrOXNGRnBxK0ZQ?=
 =?utf-8?B?S3pLWXZGdElaMWkyQVkyU0gvK2tHMlB5NEVXQnBYaUlRVmoxUXAySW0rM3R6?=
 =?utf-8?B?SHdVQ3VFYVVtSzdoTjRrMDJLVEk2T2o1K3Njc1ZnaU9VV1RaVzFZV2pMY2hs?=
 =?utf-8?B?OStpZEEzcU1haUY1K1ZwZTZVYURtNzdPcjZobTRMbGpFL1RhOG9rM1VsZGxP?=
 =?utf-8?B?K2Nzd1VPQ09iU0ovSEhMNFZ2VXAvM0NEMlFVQnhwOWFUTGFiM3BGWmY3c2tz?=
 =?utf-8?B?dDFqQ1dPZEhtMnVSbkNaWW5BTXVpaUdZRTFmUTNOWmJIWG5HYVhaU0hTL1Zr?=
 =?utf-8?B?emZqWUtBNjBHNzV0OFIwcDExVDNWajBVeXBHQUo1bi9MbFJsY2NuQncxaysr?=
 =?utf-8?B?dkNMRkxVV2xMQ1JKd0pjdjc4L25OcituZHBOS3FOclZkTHNCQ2daVHJ4Z3l4?=
 =?utf-8?B?d3RoUlpXT0R1V2NBY21uSVZMWkZDVGxvSVNSTDY4REx2MGtkQnZhazhsR01D?=
 =?utf-8?B?SmhaS1orTFdNeEM1V3ZWQWtuZ1NWcVdwSFBMeC8rYVlLTFVpd2d0MDNPa3BU?=
 =?utf-8?B?UXA3MkJGNm5Ub1FQMjh4VTU2Y0ErZHB0V3ZHSXIzeittOWFvVjV5RmovSGFY?=
 =?utf-8?Q?qHoFzYd+U8HNuS91tiTWapH7w3Dbv32VNfSsE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB2513.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?THA1dWVmVUxFbVJXbkdJUG90T3NxMm4yeG1CcDhiNkhwU0taZ29VVzRUUkJw?=
 =?utf-8?B?V2plN1YvUHAwbG5yOE42dUJqSGxVY0o4N0tKTDRjYko1TldGMTk4am1RQnZk?=
 =?utf-8?B?aTJ2cWN3d1VUQ1QxUDRrQ3VXbGk4M1FPNG9RMHlCWUFjVmNSL09tOWpXcmtE?=
 =?utf-8?B?ajJwaUl5dm95dFZ6S0V0OUdValptbkk3a2pOOHBxSXJqQkdmTlRZcm44N05m?=
 =?utf-8?B?WW5LYnBrSWh6YThyZjE4Vmt6eDhMelFRNWUvejBYWUplSXFobGlWT1hPK0Vu?=
 =?utf-8?B?bXpaaVhycEx4OHZkQWdtUjBHeWVmeHR0RlN1VDNyMk1lMnlWL2w5SnU4ZjhF?=
 =?utf-8?B?cXJJNk5SMi94dytIeUQxN09Xd1Q4eXdQL2ptQVBBREgrS1c0SFdTQTN3QTV0?=
 =?utf-8?B?bGJWRUdraHJRSlpIYnRDYnp5UFl3akp1cGRJL3FnT0g0WDdiQ3JBdjExbUlD?=
 =?utf-8?B?WUc1bFVtM3VQR0dsaDNYMG5YZEovTjlabnFtc3ZiWmRUdWMyS1B1c29xaXUz?=
 =?utf-8?B?TnhSUTNGendGUWtjZjR3cWlYS3M2ZWxzbGt4MTFIMSt5eHIyNGcvVk44NFhu?=
 =?utf-8?B?R3haUzNBSVQrdmRFdk9WRytHNW1PcG5OMGs4NUhtRWN0TVplREhjOTFvSEVD?=
 =?utf-8?B?Yk1CMmUvVU9KT0tBY05MZ3lLaEdiV2d4QzdjZzFZMGl1Qzk5elZsTWN5VUZy?=
 =?utf-8?B?MTJIU0hzUmZJZDJkRVE3bXRWSFMxemMrdjU1bnF0MHpjR2svWDU4WnFNWDI5?=
 =?utf-8?B?MEh2QytMN3FhSlR1ekRveCsyYm5UT2JoWCs5aktoWVJZamdwYWlJbHRsQXE1?=
 =?utf-8?B?Zi83TFBsVmpQclgwR1g4cjVkNTFQMnRPVTYyOUVWd2RncmhtZGRtZmpWZFVw?=
 =?utf-8?B?SzEvRVBnM2tRSzFtZW9nVXVRL1Z4MnFOSitxYldLYVFDSWppenE4b1F6RGRT?=
 =?utf-8?B?ckZCQzI0UnVNUFVTYm0wVnBORGJEY3hySmNHYno2WE1DWEN3aWJwa3d3ZUl4?=
 =?utf-8?B?aUJ3R21vcmF0VE92REdhV2E3bys0MmdOcTc0YVg1dFY5cVFVR1d0M2VQdG54?=
 =?utf-8?B?eTQ4ekV2c1dUMWRWUHZ3ZHEwVkMwMW5sS3lob2hMUFdtK3AwMTF5bHBQcWp4?=
 =?utf-8?B?dWJEUEtIS1FsMGlBNHZJSkpyMUhBNjdjbUJERUdXY0ZWa2Q2OC8xTk5XMTl3?=
 =?utf-8?B?WE9PZ1JaT3ROOHZFMEM3dWovUE8vOEczUU1EZFN4WVNpQ2VpanhzTmZ6V0hq?=
 =?utf-8?B?aDJER0JNdzBJYmtnQVBEekNkK016d0dWRTl2VnA2L015cy9aOEU4aWpWTDNW?=
 =?utf-8?B?K3JiczlCOWdVK0NJdFJ3QnkvZHRFYmJCZkxJSExvaTFXYVpFVit2V0dxM1pv?=
 =?utf-8?B?SDJoZEgrZ0VYY2ZEaGhuQ2loSGNMN2t5Kyt2MWMrbzl3Q0RScFZMVXR3QnhG?=
 =?utf-8?B?YnRaUDhqZGhYZ09Kc0FLZkt2aXFodTJrMlJXWGU3aENOblM2QnJUU1oyRUdO?=
 =?utf-8?B?akRFajNjcnVBTWgycSs1d1FBc3FuWUxjR2NUWVJYanFpVHFLMmJsMk5zeXhw?=
 =?utf-8?B?a0hoWnpnWnRham9yNDR0VnRlYlhrNGgzdW5UVUdWZERzT2IzVWFydGdtOFB1?=
 =?utf-8?B?c0E3bnVoREJGUjYwOU5NMWtQbGJYOTJlSGhsTGI1ejF0bFdyNXY5SlFMcHgr?=
 =?utf-8?B?ZEtvencvOWtlZXNLNVg5b3VHM2RBcWI1UWtNMVhLRWFuL1pGZ1ZvNjhsUnlq?=
 =?utf-8?B?MVdncGZSUE5rM3NYUWhkVy9BSExxWURQL3Q0aHhzUlZGaXR0eUtRbWxCTFhz?=
 =?utf-8?B?VGk0ajg0djFxd3pwRml0ZXJWMlJIN0JMWEczTk80SXQvTkxSa2VpT0QyZ3I4?=
 =?utf-8?B?OFRLU1NvTHVDdU5BQ2E3QXpjMngrTHpGM2psZ3UwbWVCVXNmMG02dlgzbUNn?=
 =?utf-8?B?dEdRdHlwNkN0cmpTRGthcGI4L25Cb1hqSnZDZmhTMlR0cXFnaUc1UVl5NURI?=
 =?utf-8?B?dzRkZFJoWkNaWFVnVWcvbzZwWE1zdGVBaGxuMVhLY3JpN0d5MXJnQmM1emtT?=
 =?utf-8?B?RHBCRWhLcVpVaW9xZTlZdExRb0xpVURxbWhZYUlITjF4djFZOXk4Ty9VdGxK?=
 =?utf-8?B?cTZLdWZ3MHByU2c5Q0VaUDk3aUNkMm9sd3l5aFVKVkdldEp0RzZObzMreVJi?=
 =?utf-8?B?bWc9PQ==?=
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB2513.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf9ba83-1ad4-486a-dfec-08dd0ee31648
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2024 12:57:45.0557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vhk39J+7j+b9jtmF/VLY4eqoCbb2dCAKNZcBf2djzrPvI37utkrNmRJ2PX9sHSKQ4mA5rIwH/l7glisU9w+NtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB6119
X-Proofpoint-ORIG-GUID: z8NZqATzFbSJ0BY8o52uM8SKZj-VzapP
X-Proofpoint-GUID: 39G_XyqqZu8AsYLQCUCsfU6ShmNJcK5r
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411270103



> -----Original Message-----
> From: syzbot <syzbot+67a887427af54ecb7c93@syzkaller.appspotmail.com>
> Sent: Wednesday, November 27, 2024 10:49 AM
> To: Bernard Metzler <BMT@zurich.ibm.com>; jgg@ziepe.ca; leon@kernel.org;
> linux-kernel@vger.kernel.org; linux-rdma@vger.kernel.org;
> netdev@vger.kernel.org; syzkaller-bugs@googlegroups.com
> Subject: [EXTERNAL] [syzbot] [rdma?] KASAN: slab-use-after-free Read in
> siw_query_port (2)
>=20
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    5d066766c5f1 net/l2tp: fix warning in l2tp_exit_net found
> ..
> git tree:       net
> console output: https%=20
> 3A__syzkaller.appspot.com_x_log.txt-3Fx-
> 3D168e8dc0580000&d=3DDwIBaQ&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3D4ynb4Sj_4MUcZX=
bhvovE4t
> YSbqxyOwdSiLedP4yO55g&m=3Dm3O6vMc9WMuoczjDeT5i4qksFSps2rP3_ATMJw2E343vFsI=
yyHx
> 17mPmc2wtJaU4&s=3D6au3yUVQofLXZAr8nH0sfWV1MtQx2Z16Nk9rsXOeVFs&e=3D
> kernel config:  https%=20
> 3A__syzkaller.appspot.com_x_.config-3Fx-
> 3D83e9a7f9e94ea674&d=3DDwIBaQ&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3D4ynb4Sj_4MUc=
ZXbhvovE
> 4tYSbqxyOwdSiLedP4yO55g&m=3Dm3O6vMc9WMuoczjDeT5i4qksFSps2rP3_ATMJw2E343vF=
sIyy
> Hx17mPmc2wtJaU4&s=3Dn9aCEUutAWKdDNujKIupw82TQQSlr_TZcMgisng0Xus&e=3D
> dashboard link: https%=20
> 3A__syzkaller.appspot.com_bug-3Fextid-
> 3D67a887427af54ecb7c93&d=3DDwIBaQ&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3D4ynb4Sj_=
4MUcZXbh
> vovE4tYSbqxyOwdSiLedP4yO55g&m=3Dm3O6vMc9WMuoczjDeT5i4qksFSps2rP3_ATMJw2E3=
43vF
> sIyyHx17mPmc2wtJaU4&s=3D7f-Omz7ps-pKM3jhyCcKlwMASxX_kB_Sd_pAF-Jvpxg&e=3D
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for
> Debian) 2.40
> syz repro:      https%=20
> 3A__syzkaller.appspot.com_x_repro.syz-3Fx-
> 3D11355530580000&d=3DDwIBaQ&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3D4ynb4Sj_4MUcZX=
bhvovE4t
> YSbqxyOwdSiLedP4yO55g&m=3Dm3O6vMc9WMuoczjDeT5i4qksFSps2rP3_ATMJw2E343vFsI=
yyHx
> 17mPmc2wtJaU4&s=3DfZra1eeMYqeDiaYg5CltF9l2fz28wKtU-yI_jEtubGg&e=3D
>=20
> Downloadable assets:
> disk image: https%=20
> 3A__storage.googleapis.com_syzbot-2Dassets_ba9b7c97759c_disk-
> 2D5d066766.raw.xz&d=3DDwIBaQ&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3D4ynb4Sj_4MUcZ=
XbhvovE4
> tYSbqxyOwdSiLedP4yO55g&m=3Dm3O6vMc9WMuoczjDeT5i4qksFSps2rP3_ATMJw2E343vFs=
IyyH
> x17mPmc2wtJaU4&s=3D4ypBicdKG1ksPIkOu2OLcppS8J0vPN08wFzXHtyvNEE&e=3D
> vmlinux: https%=20
> 3A__storage.googleapis.com_syzbot-2Dassets_92a30584a5ad_vmlinux-
> 2D5d066766.xz&d=3DDwIBaQ&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3D4ynb4Sj_4MUcZXbhv=
ovE4tYSb
> qxyOwdSiLedP4yO55g&m=3Dm3O6vMc9WMuoczjDeT5i4qksFSps2rP3_ATMJw2E343vFsIyyH=
x17m
> Pmc2wtJaU4&s=3DYyIgS6-_sljSEl3L1KN4bsGRpSJUuXDDkf1lrONXgNE&e=3D
> kernel image: https%=20
> 3A__storage.googleapis.com_syzbot-2Dassets_88d717deaf07_bzImage-
> 2D5d066766.xz&d=3DDwIBaQ&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3D4ynb4Sj_4MUcZXbhv=
ovE4tYSb
> qxyOwdSiLedP4yO55g&m=3Dm3O6vMc9WMuoczjDeT5i4qksFSps2rP3_ATMJw2E343vFsIyyH=
x17m
> Pmc2wtJaU4&s=3DhNlNLIJQasRBAom2wakJesBp-oiI9FnXezvbtTzPW34&e=3D
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the
> commit:
> Reported-by: syzbot+67a887427af54ecb7c93@syzkaller.appspotmail.com
>=20
> xfrm0 speed is unknown, defaulting to 1000
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in siw_query_port+0x348/0x440
> drivers/infiniband/sw/siw/siw_verbs.c:183
> Read of size 4 at addr ffff88802ff88038 by task kworker/0:5/5883
>=20
> CPU: 0 UID: 0 PID: 5883 Comm: kworker/0:5 Not tainted 6.12.0-syzkaller-
> 05491-g5d066766c5f1 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 09/13/2024
> Workqueue: infiniband ib_cache_event_task
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:488
>  kasan_report+0x143/0x180 mm/kasan/report.c:601
>  siw_query_port+0x348/0x440 drivers/infiniband/sw/siw/siw_verbs.c:183
>  ib_cache_update+0x1a9/0xb80 drivers/infiniband/core/cache.c:1494
>  ib_cache_event_task+0xf3/0x1e0 drivers/infiniband/core/cache.c:1568
>  process_one_work kernel/workqueue.c:3229 [inline]
>  process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
>  worker_thread+0x870/0xd30 kernel/workqueue.c:3391
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
>=20

Here siw is getting a use-after-free when accessing the netdev in
query_port() verb, since the netdev got free'd already. I was
assuming the rdma core would serialize device deallocation
and driver access accordingly. Seems not to be the case?

Looking at somewhat similar rxe driver, I see a mutex protecting
netdev access in rxe_query_port() - 'rxe->usdev_lock'. That
mutex is used only right there and I don't see how it is useful.
@Zhu, was it intended to serialize netdev access?

Many thanks,
Bernard.

> Allocated by task 10564:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
>  __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
>  kasan_kmalloc include/linux/kasan.h:257 [inline]
>  __do_kmalloc_node mm/slub.c:4264 [inline]
>  __kmalloc_node_noprof+0x22a/0x440 mm/slub.c:4270
>  __kvmalloc_node_noprof+0x72/0x190 mm/util.c:658
>  alloc_netdev_mqs+0xa4/0x1080 net/core/dev.c:11203
>  rtnl_create_link+0x2f9/0xc20 net/core/rtnetlink.c:3595
>  rtnl_newlink_create+0x210/0xa30 net/core/rtnetlink.c:3770
>  __rtnl_newlink net/core/rtnetlink.c:3897 [inline]
>  rtnl_newlink+0x17dd/0x24f0 net/core/rtnetlink.c:4007
>  rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6917
>  netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2542
>  netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
>  netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1347
>  netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1891
>  sock_sendmsg_nosec net/socket.c:711 [inline]
>  __sock_sendmsg+0x221/0x270 net/socket.c:726
>  __sys_sendto+0x363/0x4c0 net/socket.c:2197
>  __do_sys_sendto net/socket.c:2204 [inline]
>  __se_sys_sendto net/socket.c:2200 [inline]
>  __x64_sys_sendto+0xde/0x100 net/socket.c:2200
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> Freed by task 35:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
>  poison_slab_object mm/kasan/common.c:247 [inline]
>  __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
>  kasan_slab_free include/linux/kasan.h:230 [inline]
>  slab_free_hook mm/slub.c:2342 [inline]
>  slab_free mm/slub.c:4579 [inline]
>  kfree+0x1a0/0x440 mm/slub.c:4727
>  device_release+0x99/0x1c0
>  kobject_cleanup lib/kobject.c:689 [inline]
>  kobject_release lib/kobject.c:720 [inline]
>  kref_put include/linux/kref.h:65 [inline]
>  kobject_put+0x22f/0x480 lib/kobject.c:737
>  netdev_run_todo+0xe79/0x1000 net/core/dev.c:10918
>  cleanup_net+0x762/0xcc0 net/core/net_namespace.c:628
>  process_one_work kernel/workqueue.c:3229 [inline]
>  process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
>  worker_thread+0x870/0xd30 kernel/workqueue.c:3391
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>=20
> The buggy address belongs to the object at ffff88802ff88000
>  which belongs to the cache kmalloc-cg-4k of size 4096
> The buggy address is located 56 bytes inside of
>  freed 4096-byte region [ffff88802ff88000, ffff88802ff89000)
>=20
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2ff88
> head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> memcg:ffff888031975541
> flags: 0xfff00000000040(head|node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> page_type: f5(slab)
> raw: 00fff00000000040 ffff88801b04f500 ffffea0001f8f800 dead000000000002
> raw: 0000000000000000 0000000000040004 00000001f5000000 ffff888031975541
> head: 00fff00000000040 ffff88801b04f500 ffffea0001f8f800 dead000000000002
> head: 0000000000000000 0000000000040004 00000001f5000000 ffff888031975541
> head: 00fff00000000003 ffffea0000bfe201 ffffffffffffffff 0000000000000000
> head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 3, migratetype Unmovable, gfp_mask
> 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOM=
EM
> ALLOC), pid 7294, tgid 7294 (udevd), ts 104300491113, free_ts 104288279948
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
>  prep_new_page mm/page_alloc.c:1564 [inline]
>  get_page_from_freelist+0x3649/0x3790 mm/page_alloc.c:3474
>  __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
>  alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
>  alloc_slab_page+0x6a/0x140 mm/slub.c:2412
>  allocate_slab+0x5a/0x2f0 mm/slub.c:2578
>  new_slab mm/slub.c:2631 [inline]
>  ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3818
>  __slab_alloc+0x58/0xa0 mm/slub.c:3908
>  __slab_alloc_node mm/slub.c:3961 [inline]
>  slab_alloc_node mm/slub.c:4122 [inline]
>  __do_kmalloc_node mm/slub.c:4263 [inline]
>  __kmalloc_node_noprof+0x286/0x440 mm/slub.c:4270
>  __kvmalloc_node_noprof+0x72/0x190 mm/util.c:658
>  seq_buf_alloc fs/seq_file.c:38 [inline]
>  seq_read_iter+0x20c/0xd70 fs/seq_file.c:210
>  new_sync_read fs/read_write.c:484 [inline]
>  vfs_read+0x991/0xb70 fs/read_write.c:565
>  ksys_read+0x18f/0x2b0 fs/read_write.c:708
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> page last free pid 7342 tgid 7342 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1127 [inline]
>  free_unref_page+0xdf9/0x1140 mm/page_alloc.c:2657
>  discard_slab mm/slub.c:2677 [inline]
>  __put_partials+0xeb/0x130 mm/slub.c:3145
>  put_cpu_partial+0x17c/0x250 mm/slub.c:3220
>  __slab_free+0x2ea/0x3d0 mm/slub.c:4449
>  qlink_free mm/kasan/quarantine.c:163 [inline]
>  qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
>  kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
>  __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
>  kasan_slab_alloc include/linux/kasan.h:247 [inline]
>  slab_post_alloc_hook mm/slub.c:4085 [inline]
>  slab_alloc_node mm/slub.c:4134 [inline]
>  kmem_cache_alloc_lru_noprof+0x139/0x2b0 mm/slub.c:4153
>  sock_alloc_inode+0x28/0xc0 net/socket.c:307
>  alloc_inode+0x65/0x1a0 fs/inode.c:336
>  sock_alloc net/socket.c:615 [inline]
>  __sock_create+0x127/0xa30 net/socket.c:1522
>  sock_create net/socket.c:1616 [inline]
>  __sys_socket_create net/socket.c:1653 [inline]
>  __sys_socket+0x150/0x3c0 net/socket.c:1700
>  __do_sys_socket net/socket.c:1714 [inline]
>  __se_sys_socket net/socket.c:1712 [inline]
>  __x64_sys_socket+0x7a/0x90 net/socket.c:1712
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> Memory state around the buggy address:
>  ffff88802ff87f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff88802ff87f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >ffff88802ff88000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                         ^
>  ffff88802ff88080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff88802ff88100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>=20
> ---
> This report is generated by a bot. It may contain errors.
> See https%=20
> 3A__goo.gl_tpsmEJ&d=3DDwIBaQ&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3D4ynb4Sj_4MUcZ=
XbhvovE4
> tYSbqxyOwdSiLedP4yO55g&m=3Dm3O6vMc9WMuoczjDeT5i4qksFSps2rP3_ATMJw2E343vFs=
IyyH
> x17mPmc2wtJaU4&s=3DIN3iayLHmzULE2aCAPu4KTVSnPNVh7pCMpPelU3ttrw&e=3D  for =
more
> information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>=20
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ%=20
> 23status&d=3DDwIBaQ&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3D4ynb4Sj_4MUcZXbhvovE4t=
YSbqxyOw
> dSiLedP4yO55g&m=3Dm3O6vMc9WMuoczjDeT5i4qksFSps2rP3_ATMJw2E343vFsIyyHx17mP=
mc2w
> tJaU4&s=3D8ZTBWQFsMGIjFpf_f8tEpszCYanWYyZkGLEEV4YofhU&e=3D  for how to
> communicate with syzbot.
>=20
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>=20
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>=20
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>=20
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>=20
> If you want to undo deduplication, reply with:
> #syz undup

