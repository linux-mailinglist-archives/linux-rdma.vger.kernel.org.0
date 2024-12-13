Return-Path: <linux-rdma+bounces-6508-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 124C49F0C10
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Dec 2024 13:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3035616928F
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Dec 2024 12:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E9B364D6;
	Fri, 13 Dec 2024 12:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qMNehO+M"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F100B1BBBDC
	for <linux-rdma@vger.kernel.org>; Fri, 13 Dec 2024 12:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734092237; cv=fail; b=fO6r4+wewTuWFBUMJyJ/teUmU15p6jd7bFlaBXCd9C2Z4JMxJisVf1/60pqOjG/1/Wbt2jgPQDoSRTG583Sf2od4oOpLu1WjDnTz13yT+VtxVkzhcLctLWzVDRa0mF0W8HPfzLqovD3H0ZXc5hS81bEMNBp5oghGnNW2qndbhTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734092237; c=relaxed/simple;
	bh=dlnmR6A54IDmeF0gknMwnc3YkrJ1lsNbg8X127V+ZE8=;
	h=From:To:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=W/dMqo8ME9ZD8Pw+TZsHTI8BmfxufPKRzLq/srMq8Fv8fILi63w+7JXTExNfXmtBHaF1R4qIbY8iLTMcEe0NXVvPuyoMt2pPR/xsB1nQwNaKbM7bqE67glHpHutNi/m7Bg6zqEatCDFtNNHemhKbT5uLFj43q7RpGDMcAqewKUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com; spf=pass smtp.mailfrom=zurich.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qMNehO+M; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zurich.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD3s89g005879;
	Fri, 13 Dec 2024 12:16:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dlnmR6
	A54IDmeF0gknMwnc3YkrJ1lsNbg8X127V+ZE8=; b=qMNehO+Mb6eW5QVZAZm3uk
	jS3hrlZE6tGHB0/GALSzLBKf6/JVbKdd3sGFYyc62Mt5ACfyG9uN/kCaAdHen5GI
	tIzKse7VLa+/8r/6F1PuRmBGlGrWXtvMXRxQAjcLIhTt0aGj1TBMxJBetDAv+s0u
	0lshQJ7ZyL+amZsEpwZkpp2j2Bi3Yt/7mwGeQVmLFdHf7LOgiExo5E7nNd4TOm5A
	V8gaLoritVeiMdPr446x3IqT8Y0AYHooMWkCtH2TCyazTA2atpe6BbsE0YmsK71b
	d45TXTxsmMhGue9OpcBUYuHfjyCTFPHUuklSFxDU/5vTBaByx0Jv5GlMlhAXBr8w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43gddma3qu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 12:16:49 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BDCGm1C011012;
	Fri, 13 Dec 2024 12:16:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43gddma3qr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 12:16:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Op07nWAd640YFd0f9YhAK7ovRw9cjRYaKW1e7ySnmsQKiOI5e3oqx9tu3nHWmBI3TZ0kV3A+f9cg9D7F/N2hFV1hkcIwOf7dVu7z7QDdaoW8NBetUH9CLzwfOSqhs01QSwlMM/RgAyrWUPn+yNS6yEl+kzzg47iJBZ5Dx4xXAdJhyl2HIFIpTQM61eHo2ykuZzyfPLL0YXjkUxa40ldl/3En/SnJkMP1FNgkuZAS63TNUmp+vE5sUhIKQ06YVskczzOZa0dlB520wLr7BgAg6EM4NqJn4qEOO9ibLRpNTECh2QTEEsYgK2veAz4SMIlKSMSJZIrsqH7vwKOLLWAdbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dlnmR6A54IDmeF0gknMwnc3YkrJ1lsNbg8X127V+ZE8=;
 b=Lh+62Bk9Mv40ojsv9OkXE5W4xbFQDNHZkSQR7tEc8Cj/kIfYqhYaE0zi8ocDOXTehCFcEeuBoJZJkRL4NPoFUDL8D1giyq58Uzt4S1RAEQG3dg/oNIoKHrl6LFEWQQzijF6z2Xr4wFx8XkuGVvEy3DFS5IeqL74xhTMD9odP+JLIQz6R7a5hPmlsTcVizAAuVXJJDaYYruUkmYdRtFKLanoMd3aCsq7Y3Hx6yn6NtjCMI6y5UWaFTpbW+vXkAaFX/R/DZOpuDK+uTg2Ku3B+bKQjm210WnnnThuiSojuF2BJb+oyP7ZLPaPNR2YQASCgALNPOnEbd+qEjnhGgePuAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BN8PR15MB2513.namprd15.prod.outlook.com (2603:10b6:408:cc::30)
 by DS0PR15MB6259.namprd15.prod.outlook.com (2603:10b6:8:165::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 12:16:46 +0000
Received: from BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::dd5e:86f1:8719:2f16]) by BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::dd5e:86f1:8719:2f16%4]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 12:16:46 +0000
From: Bernard Metzler <BMT@zurich.ibm.com>
To: Bernard Metzler <BMT@zurich.ibm.com>, Honggang LI <honggangli@163.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Thread-Topic: [EXTERNAL] RE:  workqueue: WQ_MEM_RECLAIM
 nvmet-wq:nvmet_rdma_release_queue_work [nvmet_rdma] is flushing
 !WQ_MEM_RECLAIM irdma-cleanup-wq:irdma_flush_worker [irdma]
Thread-Index: AQHbTVjgpTes98b9Fk23GI2826ubVg==
Date: Fri, 13 Dec 2024 12:16:46 +0000
Message-ID:
 <BN8PR15MB251390315F7BBCCE0041846199382@BN8PR15MB2513.namprd15.prod.outlook.com>
References: <Z1wBEgluXUDrDJmN@fc39>
 <BN8PR15MB2513DD09FA9926D11DA8C53E99382@BN8PR15MB2513.namprd15.prod.outlook.com>
In-Reply-To:
 <BN8PR15MB2513DD09FA9926D11DA8C53E99382@BN8PR15MB2513.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR15MB2513:EE_|DS0PR15MB6259:EE_
x-ms-office365-filtering-correlation-id: 815ef4e0-6924-413f-4b87-08dd1b700345
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Qnl2VmNYZTFHalJKUXBnU2tKaTBMM1RPT3BVMDRVb2dKamdEVmFRMWc4TjUx?=
 =?utf-8?B?RjVHWVZDZjJBZFpVL3dXTmdldjZobEY1U2RLK0ZPc01KdS9OL1cxZ0Ryajg2?=
 =?utf-8?B?bkhjRFgzQnBZRlQ1NFhHcVRvYVdoODlHMlkxQTlNRElzbWpYOCtkcnNiaVR1?=
 =?utf-8?B?bTlZNWVrZDRLWDlaazhFWVBtejF5d2NaRWI4Y0g4Z1R3SjRkS2xvWEJtTG1x?=
 =?utf-8?B?Ry9EOUs5MlpNaGFJc3pRR3pnQ1puSVljOEhhYUp2L1JJZStTZEh4am5JZkhP?=
 =?utf-8?B?dEVwcFJ5STRZVEN6WmRnU01oRmVhK2lGRDRYVk9lTmdZZXQxbXQvQ1JmUG1Y?=
 =?utf-8?B?ZFpCMjRNaG5WUFp5SWVURE10bU1jazFIbFk4d2pCcnVSVTRvUWJjVzBKWXEw?=
 =?utf-8?B?ck5TZGs3dktXaW9ySGo1VGpBY2lEb21XbUxCdnJyVEIvWTh4alpUVnQ1S3Jx?=
 =?utf-8?B?NzZhZzkyY0NGYzJYcHpKbGZhdXVhT0YzRFNIWXd1eElOMVJsTmVQYkVOT2k3?=
 =?utf-8?B?YSsxYW0yZ25jTnMwSXN6dkM5ZHRxYXFTV29PNjR3d3hCZU1TQ1V1SEY1RlhZ?=
 =?utf-8?B?blkwbVBhejVWdDJVYkxvR2ZUK0xUVzRKQjQxaTUrME1EU3pqcjlnMHZkbGdq?=
 =?utf-8?B?aFFtemhvYjh1cnVRb2NBYmRNTzhZWGoyaXlRN281SUN1d2hSZERqa2gxcjRB?=
 =?utf-8?B?YUVuelRUN3haMU9FR2k0ZXU3SWMzSC9rSWVXN1VYQTk0cmJQWGhISGh0YmpO?=
 =?utf-8?B?a0pKOUY0Tmp0WWt5dEkzWGRuNTc0SDlHZDdBc1B0YTVzUXRrdEhOMFJOREdj?=
 =?utf-8?B?T0VkcGtqNitxVmhvbnM4VThjR25ua0cvVWxhUGFoVUlLcnFGbGJudDRCRGE5?=
 =?utf-8?B?TFpWQVF2RjY5NmxkVDU5eFlKKys4cklWTVFRVDF4NDhGUXA2NytUNDV1NmtK?=
 =?utf-8?B?TkxTYkprS2prVSs3ZENvY0xYdGg1Y1c3enZkREMxTGJrQnNJblkyOTRTMVBG?=
 =?utf-8?B?MkxxbktuTVh1NDE4VGJlV1pvbExveTB5bDYzWFpVOTVXbjE5bjhBNEZDOXRh?=
 =?utf-8?B?U3NUQmZMTnhKOW9hVTQ3VGl1ZUVkQU5QTFhtTTZtUG5MTFE2V2I2MVlIQjhM?=
 =?utf-8?B?ZSttSlFLMHY3UC9UdTkrWkJFd3E0YUJoK0ZFS2VWby9wVngvYUtBZVFUVDlR?=
 =?utf-8?B?bHg2dDlyWTNyenNFd0ZTMUVyY01FdFVUVkVINUUrTTYvQTB4U2NPVlphanVl?=
 =?utf-8?B?V0Q0OVFFMERvcjFUWjJZWTFrSm5vTlY3VUkzZDkxclRCWmF6bTRUcGlvbXdC?=
 =?utf-8?B?NDlzMUFCbU5rZ2d5SDFEd1VmK1NxVXZFRzNYSHNScFBuT3c2R1BGQmhTT2xh?=
 =?utf-8?B?amp5c1VwemJyM2U2U3BYTUswMGdrVkdYU1RPeHBSZWNUWWdTbWpycktRa05i?=
 =?utf-8?B?UmNXMjdDTTY3S05ZN1c3Ukxwb05DaFc3Mk1YYmpSWWw4SG84NmlvRlJPWlJH?=
 =?utf-8?B?aXpaRnM0dHdMOUlhUlJSRXU2cm94VzVNMUJQNGhHVG9xN21qNHhxaFVRTjRJ?=
 =?utf-8?B?S1V6bGM0U3BSWjA5QW5KWWxmSGJlT2xPc2xKRnhORk4rOGtjbU4wbXVSN1BB?=
 =?utf-8?B?TVk3eEtHYVc4Z2dRZ0wrTTlJT0prTEcxR0Z2UERkVEdFSkRsenJLbjFjeW1u?=
 =?utf-8?B?T1J1Q2JYZStFelhubUJ5WERrS1BhZW41bDd5bFd3Q0U0K3dlTlREdlc1R3Ri?=
 =?utf-8?B?KzE0MlJiV012WnlsRmZWc0dBbnJxbk5ZbUJucFJqcmdXeXNWc0JuQjZ4aXVD?=
 =?utf-8?B?b3RkTGpxQWJzd0JVWlhoelFrVTVyY3dmZDFKaXVKU2E1a05kUmNIK2p1UFZ1?=
 =?utf-8?B?V1lYbEVEdTFoZkVsVXpOejZNdXlVVnQxY0plQWhROW9KeVE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB2513.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bGtNbXRsaHlvTW95MHQ2bVlTVlZlc0Q3aGtNWTFHMUVodDVXUXVMMGQ4Smx5?=
 =?utf-8?B?RUNTYjJxd1Y1R202a24rSzhnZ0JkT1ArcHFiVmY4SXJwR3JLeW5KYUhBOFZH?=
 =?utf-8?B?UmFaV3NoTzVnUEgwcEh3Z21YemtWeHZJdXVETVV6OGw5S3VwTDZQbmhRc2pv?=
 =?utf-8?B?eXhCeExlbDU3OVhuL2tpQU9ORWp0VktSZHRoTWRNbi9IUjQ2RVdsdTFwLzc5?=
 =?utf-8?B?VUl1WFZVMmtDWE9waU5DZDk5elh4RHc0TzRsU0dDaHA2WE5oRnltQy95aGJa?=
 =?utf-8?B?N1dSSnhIR0ZSa1A0ci80dUxRLzBSR2VCL0RCVStYYlZvV0NpUWJZcmlNbmJT?=
 =?utf-8?B?cXBXZThTNTRvdUxXSi8vYmNUU3Y3Y01hZVVtZHVKVkJwRWFLbFc0bm1kTlVw?=
 =?utf-8?B?WnBCU0tzOUZING1DV1pMRHZjbERMdlJFKzdNckR4cVMzb2M4UlA3V1RLQXVk?=
 =?utf-8?B?M1prRStKR202R0lyZVZ6MGkrdmFCaU9NVzJPRkZWaDdKL1lod3lKSit6NjQv?=
 =?utf-8?B?ekVhL1N2eEdhZzZBeGhNbXNOUVNpS2tsYW53N2ROVDlEMFEwN09xYVZGbng4?=
 =?utf-8?B?YUErRUVzZ09xU3VFdmtiYmMxT1I4cERnMWJRcStianNzWjVtdkN6SVgwL1Jo?=
 =?utf-8?B?amR6OGRqbmxyTFhTa3NzUis2NnpRdDB6cUlvTHIxT0szTU9zOWJ5RjVzZk1q?=
 =?utf-8?B?NFl0R2lpbUdtemsxRzFxc1puMUVWa2lUcUU4STNIWXlhcmV6SE1VODRoSXdN?=
 =?utf-8?B?NjdaRlBoL00rVWtETTZyRkRHNTdHWEYyUnRpRFFUaDJjdUQ2WCt1QUUxR1ZD?=
 =?utf-8?B?am1XdmUzSTUyaGdvWEY2VXVkdkdlQUMxdjhCUWFxdThFNlVwc29aQXJrcWQ4?=
 =?utf-8?B?QVFTTzV3RE1OS3dCN0VPbmhFTUN0QnZUMWszbGxkb205S1pnSGNkYmlVQzNR?=
 =?utf-8?B?WFNQMkdXbktXMWVPOEJFOE1GWjRGZWNJZm13OHNaK0tQOGZvVmQ2aWRRQ3dJ?=
 =?utf-8?B?WXBlT1I4ZlcwajhnUXJrQUpYOHNuUnpzT29STEkyWlJacVMxbGpOUEZxWmlP?=
 =?utf-8?B?MDhLSFhvbkxoRnFSRWRkeXhia3BPVDVCSTFjUTdTTkJsUjRNQ0s5dVNpakhF?=
 =?utf-8?B?N0ZWd2gwYXlQUFp5anR5MlhhTlhGS3JwVEVKRGxNZldWbms5WGFtUkRKMkww?=
 =?utf-8?B?dW9vc1B4VUpQWkQ3ZTdRTWxUa3g5QU1oaGZVT24xelkvTTN5RHpyd3lxQ2JW?=
 =?utf-8?B?b1BIZ0k0WHRWUlZ6R0Q5SzBKTHN1Y1o4VjVFSEQ2enFGTStPOVlYcFdJM2JO?=
 =?utf-8?B?dVh5UUI3T05mR0F0eG5NUnpOOXFoSFJXcWEzbm81cmpmQ0J4c1ZENm00QmRq?=
 =?utf-8?B?RVdITFIzdk43QTR5em1HRk0xem5LSXl6Y0tmb3Y2dzNHZktUczJjMVB3dGRV?=
 =?utf-8?B?eGVkVVhsODBTb2dVODh0cWo0emtsaTQyaThpdDZocit0SmdxemtnRXZTOHFF?=
 =?utf-8?B?S2JFNFdnaFlJTkhZajF3aC9kYzJ6MmVaUHZYaUJLWnBSdXhhWS9KUi9nbXND?=
 =?utf-8?B?bFFSZHA5OEtUOHBpSXBocW9YQlNuckdwaUlMN0lpVVVnL2R6RG1rYXVoSi9z?=
 =?utf-8?B?WWg5Qko5b3JUQjRWQnFNVTBCNENpZ3N1SG4vamJnaTJrcVAxMjNDY3FEM0V4?=
 =?utf-8?B?ZW9Qcm11elF6bUx2MUZjQ3FneDNyTmFYVitLcmM2MmYyZ1JHclB6R1gxQm1L?=
 =?utf-8?B?Y25Fei9WMVo5LzVBUVVadnp2WlVONWJoRmVvY1k1Zmh2enpKMjdUc3dnV3NP?=
 =?utf-8?B?NTk5dnk3RTFEZFc5MXc5WWdFSi9odlFVYmpjcU9Ha2VtMVM5dVdSQTY3RWhq?=
 =?utf-8?B?MEtmWDcyVXAxUVpBMUVoRHlYOFRBU2xoQ1Uzd05pK0M5ZXlFNWJ2VmlZbGIw?=
 =?utf-8?B?ZXV4cGFlTnJ3UGhzd3lpRDdUQ25hQmpIbHlwRmtoL2hUSnhTRFErbTZON0Fr?=
 =?utf-8?B?MXBmZHVRZjVsTFQ4bG5rQWpRaTlYVHdNMDhtdEc1Vkw5Si9ZcVdPTC9RQi9I?=
 =?utf-8?B?MC96V056R24yUnBmdkp0dG1sVk5KN1lKMTUyRklBeUZ2d2ZFN05Gc1dlNmFN?=
 =?utf-8?Q?RaXAZSlcvl5+1yWfKjbShmkTM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 815ef4e0-6924-413f-4b87-08dd1b700345
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 12:16:46.1408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JJGacqOROkbH/l3klZqr6r6OWRlCZgyZ+Hl6FR8SAmRD4J6pMFvvbMvw+iNHqdU5AN+hG/Jga2IyTkQhA7YVNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB6259
X-Proofpoint-ORIG-GUID: hhUIXl77gUFZH9O-xhkcYlC-mMu_Sjj1
X-Proofpoint-GUID: LXZRCuFimyarz67EOysAKc8YGvPDCG2A
Subject: RE:  workqueue: WQ_MEM_RECLAIM nvmet-wq:nvmet_rdma_release_queue_work
 [nvmet_rdma] is flushing !WQ_MEM_RECLAIM
 irdma-cleanup-wq:irdma_flush_worker [irdma]
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0 malwarescore=0
 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130084

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmVybmFyZCBNZXR6bGVy
IDxCTVRAenVyaWNoLmlibS5jb20+DQo+IFNlbnQ6IEZyaWRheSwgRGVjZW1iZXIgMTMsIDIwMjQg
MTowMSBQTQ0KPiBUbzogSG9uZ2dhbmcgTEkgPGhvbmdnYW5nbGlAMTYzLmNvbT47IGxpbnV4LW52
bWVAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmcNCj4g
U3ViamVjdDogW0VYVEVSTkFMXSBSRTogd29ya3F1ZXVlOiBXUV9NRU1fUkVDTEFJTSBudm1ldC0N
Cj4gd3E6bnZtZXRfcmRtYV9yZWxlYXNlX3F1ZXVlX3dvcmsgW252bWV0X3JkbWFdIGlzIGZsdXNo
aW5nICFXUV9NRU1fUkVDTEFJTQ0KPiBpcmRtYS1jbGVhbnVwLXdxOmlyZG1hX2ZsdXNoX3dvcmtl
ciBbaXJkbWFdDQo+IA0KPiBSWEU/IFRoZXJlIGFyZSBpcmRtYSBjYWxscyBvbiB0aGUgc3RhY2s/
DQo+IA0KPiBIbW1tLg0KDQpTb3JyeSBmb3IgdGhlIG5vaXNlLiBZZXMgaXRzIHRhcmdldCBzaWRl
Lg0KPiANCj4gDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTog
SG9uZ2dhbmcgTEkgPGhvbmdnYW5nbGlAMTYzLmNvbT4NCj4gPiBTZW50OiBGcmlkYXksIERlY2Vt
YmVyIDEzLCAyMDI0IDEwOjQxIEFNDQo+ID4gVG86IGxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFk
Lm9yZzsgbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBTdWJqZWN0OiBbRVhURVJOQUxd
IHdvcmtxdWV1ZTogV1FfTUVNX1JFQ0xBSU0gbnZtZXQtDQo+ID4gd3E6bnZtZXRfcmRtYV9yZWxl
YXNlX3F1ZXVlX3dvcmsgW252bWV0X3JkbWFdIGlzIGZsdXNoaW5nICFXUV9NRU1fUkVDTEFJTQ0K
PiA+IGlyZG1hLWNsZWFudXAtd3E6aXJkbWFfZmx1c2hfd29ya2VyIFtpcmRtYV0NCj4gPg0KPiA+
IEl0IGlzIDEwMCUgcmVwcm9kdWNpYmxlLiBUaGUgTlZNRW9SRE1BIGNsaWVudCBzaWRlIGlzIHJ1
bm5pbmcgUlhFLg0KPiA+IFRvIHJlcHJvZHVjZSBpdCwgdGhlIGNsaW5ldCBzaWRlIHJlcGVhdCB0
byBjb25uZWN0IGFuZCBkaXNjb25uZWN0DQo+ID4gdG8gdGhlIE5WTUVvUkRNQSB0YXJnZXQuDQo+
ID4NCj4gPiBbIDY4NS43NTczNTddIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0t
LQ0KPiA+IFsgNjg1Ljc1ODcyNV0gd29ya3F1ZXVlOiBXUV9NRU1fUkVDTEFJTSBudm1ldC0NCj4g
PiB3cTpudm1ldF9yZG1hX3JlbGVhc2VfcXVldWVfd29yayBbbnZtZXRfcmRtYV0gaXMgZmx1c2hp
bmcgIVdRX01FTV9SRUNMQUlNDQo+ID4gaXJkbWEtY2xlYW51cC13cTppcmRtYV9mbHVzaF93b3Jr
ZXIgW2lyZG1hXQ0KPiA+IFsgNjg1Ljc1ODgwOV0gV0FSTklORzogQ1BVOiAxNiBQSUQ6IDE4OTcg
YXQga2VybmVsL3dvcmtxdWV1ZS5jOjI5NjYNCj4gPiBjaGVja19mbHVzaF9kZXBlbmRlbmN5KzB4
MTFmLzB4MTQwDQo+ID4gWyA2ODUuNzYyODgwXSBNb2R1bGVzIGxpbmtlZCBpbjogbnZtZXRfcmRt
YSBudm1ldCBudm1lX2tleXJpbmcgdGNtX2xvb3ANCj4gPiB0YXJnZXRfY29yZV91c2VyIHVpbyB0
YXJnZXRfY29yZV9wc2NzaSB0YXJnZXRfY29yZV9maWxlDQo+IHRhcmdldF9jb3JlX2libG9jaw0K
PiA+IHJwY3JkbWEgcXJ0ciByZG1hX3VjbSBpYl9zcnB0IGliX2lzZXJ0IGlzY3NpX3RhcmdldF9t
b2QgdGFyZ2V0X2NvcmVfbW9kDQo+ID4gcmZraWxsIGliX2lzZXIgbGliaXNjc2kgc2NzaV90cmFu
c3BvcnRfaXNjc2kgcmRtYV9jbSBpd19jbSBpYl9jbQ0KPiA+IGludGVsX3JhcGxfbXNyIGludGVs
X3JhcGxfY29tbW9uIHNiX2VkYWMgeDg2X3BrZ190ZW1wX3RoZXJtYWwNCj4gPiBpbnRlbF9wb3dl
cmNsYW1wIGNvcmV0ZW1wIHN1bnJwYyBrdm1faW50ZWwga3ZtIGlycWJ5cGFzcyBiaW5mbXRfbWlz
YyByYXBsDQo+ID4gaW50ZWxfY3N0YXRlIGlyZG1hIGlwbWlfc3NpZiBpNDBlIGlUQ09fd2R0IGlu
dGVsX3BtY19ieHQNCj4gPiBpVENPX3ZlbmRvcl9zdXBwb3J0IGliX3V2ZXJicyBhY3BpX2lwbWkg
aW50ZWxfdW5jb3JlIGpveWRldiBpcG1pX3NpDQo+IHBjc3Brcg0KPiA+IG14bV93bWkgaWJfY29y
ZSBtZWlfbWUgaXBtaV9kZXZpbnRmIGkyY19pODAxIG1laSBpMmNfc21idXMgbHBjX2ljaA0KPiBp
b2F0ZG1hDQo+ID4gaXBtaV9tc2doYW5kbGVyIGxvb3AgZG1fbXVsdGlwYXRoIG5mbmV0bGluayB6
cmFtIGljZSBjcmN0MTBkaWZfcGNsbXVsDQo+ID4gY3JjMzJfcGNsbXVsIGNyYzMyY19pbnRlbCBw
b2x5dmFsX2NsbXVsbmkgcG9seXZhbF9nZW5lcmljIG52bWUgaXNjaQ0KPiA+IG52bWVfY29yZSBn
aGFzaF9jbG11bG5pX2ludGVsIHNoYTUxMl9zc3NlMyBpZ2Igc2hhMjU2X3Nzc2UzIGxpYnNhcw0K
PiA+IHNoYTFfc3NzZTMgbnZtZV9hdXRoIG1nYWcyMDAgc2NzaV90cmFuc3BvcnRfc2FzIGRjYSBn
bnNzIGkyY19hbGdvX2JpdCB3bWkNCj4gPiBzY3NpX2RoX3JkYWMgc2NzaV9kaF9lbWMgc2NzaV9k
aF9hbHVhIGlwNl90YWJsZXMgaXBfdGFibGVzIGZ1c2UNCj4gPiBbIDY4NS43NzM4OTFdIENQVTog
MTYgUElEOiAxODk3IENvbW06IGt3b3JrZXIvMTY6MiBLZHVtcDogbG9hZGVkIFRhaW50ZWQ6DQo+
IEcNCj4gPiBTIDYuOC40LTMwMC5wYXRjaGVkLmZjNDAueDg2XzY0ICMxDQo+ID4gWyA2ODUuNzc1
MjY3XSBIYXJkd2FyZSBuYW1lOiBTdWdvbiBJNjIwLUcxMC9YOURSMy1GLCBCSU9TIDMuMGIgMDcv
MjIvMjAxNA0KPiA+IFsgNjg1Ljc3NjYyN10gV29ya3F1ZXVlOiBudm1ldC13cSBudm1ldF9yZG1h
X3JlbGVhc2VfcXVldWVfd29yaw0KPiA+IFtudm1ldF9yZG1hXQ0KPiA+IFsgNjg1Ljc3Nzk5M10g
UklQOiAwMDEwOmNoZWNrX2ZsdXNoX2RlcGVuZGVuY3krMHgxMWYvMHgxNDANCj4gPiBbIDY4NS43
NzkzMzFdIENvZGU6IDhiIDQ1IDE4IDQ4IDhkIGIyIGIwIDAwIDAwIDAwIDQ5IDg5IGU4IDQ4IDhk
IDhiIGIwIDAwDQo+ID4gMDAgMDAgNDggYzcgYzcgMjggZmUgYjEgYjIgYzYgMDUgNGYgOTcgNTkg
MDIgMDEgNDggODkgYzIgZTggYTEgOTEgZmQgZmYNCj4gPiA8MGY+IDBiIGU5IGZjIGZlIGZmIGZm
IDgwIDNkIDNhIDk3IDU5IDAyIDAwIDc1IDkzIGU5IDJhIGZmIGZmIGZmIDY2DQo+ID4gWyA2ODUu
NzgyMDUwXSBSU1A6IDAwMTg6ZmZmZmIzMTM0ODc5M2NjOCBFRkxBR1M6IDAwMDEwMDgyDQo+ID4g
WyA2ODUuNzgzMzk4XSBSQVg6IDAwMDAwMDAwMDAwMDAwMDAgUkJYOiBmZmZmOTZjNzA1NzU0ODAw
IFJDWDoNCj4gPiAwMDAwMDAwMDAwMDAwMDI3DQo+ID4gWyA2ODUuNzg0NzQ0XSBSRFg6IGZmZmY5
NmNlNWZjYTE4YzggUlNJOiAwMDAwMDAwMDAwMDAwMDAxIFJESToNCj4gPiBmZmZmOTZjZTVmY2Ex
OGMwDQo+ID4gWyA2ODUuNzg2MDc3XSBSQlA6IGZmZmZmZmZmYzBkMjE3ZjAgUjA4OiAwMDAwMDAw
MDAwMDAwMDAwIFIwOToNCj4gPiBmZmZmYjMxMzQ4NzkzYjM4DQo+ID4gWyA2ODUuNzg3MzkwXSBS
MTA6IGZmZmZmZmZmYjM1MTY4MDggUjExOiAwMDAwMDAwMDAwMDAwMDAzIFIxMjoNCj4gPiBmZmZm
OTZjNzBkMmFhOGMwDQo+ID4gWyA2ODUuNzg4Njg4XSBSMTM6IGZmZmY5NmM3MDQzYzZhODAgUjE0
OiAwMDAwMDAwMDAwMDAwMDAxIFIxNToNCj4gPiBmZmZmOTZjNzA0MTQ3NDAwDQo+ID4gWyA2ODUu
Nzg5OTcwXSBGUzogMDAwMDAwMDAwMDAwMDAwMCgwMDAwKSBHUzpmZmZmOTZjZTVmYzgwMDAwKDAw
MDApDQo+ID4ga25sR1M6MDAwMDAwMDAwMDAwMDAwMA0KPiA+IFsgNjg1Ljc5MTIzOV0gQ1M6IDAw
MTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzDQo+ID4gWyA2ODUuNzky
NDk1XSBDUjI6IDAwMDA3ZjgyMDcxNTEwMDAgQ1IzOiAwMDAwMDAwZDE1NDIyMDA2IENSNDoNCj4g
PiAwMDAwMDAwMDAwMTcwNmYwDQo+ID4gWyA2ODUuNzkzNzQ1XSBDYWxsIFRyYWNlOg0KPiA+IFsg
Njg1Ljc5NDk3M10gPFRBU0s+DQo+ID4gWyA2ODUuNzk2MTc5XSA/IGNoZWNrX2ZsdXNoX2RlcGVu
ZGVuY3krMHgxMWYvMHgxNDANCj4gPiBbIDY4NS43OTczODJdID8gX193YXJuKzB4ODEvMHgxMzAN
Cj4gPiBbIDY4NS43OTg1NjNdID8gY2hlY2tfZmx1c2hfZGVwZW5kZW5jeSsweDExZi8weDE0MA0K
PiA+IFsgNjg1Ljc5OTczMl0gPyByZXBvcnRfYnVnKzB4MTZmLzB4MWEwDQo+ID4gWyA2ODUuODAw
ODgyXSA/IGhhbmRsZV9idWcrMHgzYy8weDgwDQo+ID4gWyA2ODUuODAyMDAzXSA/IGV4Y19pbnZh
bGlkX29wKzB4MTcvMHg3MA0KPiA+IFsgNjg1LjgwMzEwN10gPyBhc21fZXhjX2ludmFsaWRfb3Ar
MHgxYS8weDIwDQo+ID4gWyA2ODUuODA0MjAwXSA/IF9fcGZ4X2lyZG1hX2ZsdXNoX3dvcmtlcisw
eDEwLzB4MTAgW2lyZG1hXQ0KPiA+IFsgNjg1LjgwNTMxNV0gPyBjaGVja19mbHVzaF9kZXBlbmRl
bmN5KzB4MTFmLzB4MTQwDQo+ID4gWyA2ODUuODA2MzczXSA/IGNoZWNrX2ZsdXNoX2RlcGVuZGVu
Y3krMHgxMWYvMHgxNDANCj4gPiBbIDY4NS44MDc0MDddIF9fZmx1c2hfd29yay5pc3JhLjArMHgx
MGQvMHgyOTANCj4gPiBbIDY4NS44MDg0MjBdIF9fY2FuY2VsX3dvcmtfdGltZXIrMHgxMDMvMHgx
YTANCj4gPiBbIDY4NS44MDk0MThdIGlyZG1hX2Rlc3Ryb3lfcXArMHhkNC8weDE4MCBbaXJkbWFd
DQo+ID4gWyA2ODUuODEwNDM3XSBpYl9kZXN0cm95X3FwX3VzZXIrMHg5My8weDFhMCBbaWJfY29y
ZV0NCj4gPiBbIDY4NS44MTE0NzRdIG52bWV0X3JkbWFfZnJlZV9xdWV1ZSsweDM1LzB4YzAgW252
bWV0X3JkbWFdDQo+ID4gWyA2ODUuODEyNDM3XSBudm1ldF9yZG1hX3JlbGVhc2VfcXVldWVfd29y
aysweDFkLzB4NTAgW252bWV0X3JkbWFdDQo+ID4gWyA2ODUuODEzMzg1XSBwcm9jZXNzX29uZV93
b3JrKzB4MTcwLzB4MzMwDQo+ID4gWyA2ODUuODE0MzAwXSB3b3JrZXJfdGhyZWFkKzB4MjgwLzB4
M2QwDQo+ID4gWyA2ODUuODE1MjAxXSA/IF9fcGZ4X3dvcmtlcl90aHJlYWQrMHgxMC8weDEwDQo+
ID4gWyA2ODUuODE2MDkwXSBrdGhyZWFkKzB4ZTgvMHgxMjANCj4gPiBbIDY4NS44MTY5NTZdID8g
X19wZnhfa3RocmVhZCsweDEwLzB4MTANCj4gPiBbIDY4NS44MTc4MDFdIHJldF9mcm9tX2Zvcmsr
MHgzNC8weDUwDQo+ID4gWyA2ODUuODE4NjMzXSA/IF9fcGZ4X2t0aHJlYWQrMHgxMC8weDEwDQo+
ID4gWyA2ODUuODE5NDM5XSByZXRfZnJvbV9mb3JrX2FzbSsweDFiLzB4MzANCj4gPiBbIDY4NS44
MjAyMzJdIDwvVEFTSz4NCj4gPiBbIDY4NS44MjA5OTRdIEtlcm5lbCBwYW5pYyAtIG5vdCBzeW5j
aW5nOiBrZXJuZWw6IHBhbmljX29uX3dhcm4gc2V0IC4uLg0KPiA+IFsgNjg1LjgyMTc0OV0gQ1BV
OiAxNiBQSUQ6IDE4OTcgQ29tbToga3dvcmtlci8xNjoyIEtkdW1wOiBsb2FkZWQgVGFpbnRlZDoN
Cj4gRw0KPiA+IFMgNi44LjQtMzAwLnBhdGNoZWQuZmM0MC54ODZfNjQgIzENCj4gPiBbIDY4NS44
MjI1MTNdIEhhcmR3YXJlIG5hbWU6IFN1Z29uIEk2MjAtRzEwL1g5RFIzLUYsIEJJT1MgMy4wYiAw
Ny8yMi8yMDE0DQo+ID4gWyA2ODUuODIzMjU5XSBXb3JrcXVldWU6IG52bWV0LXdxIG52bWV0X3Jk
bWFfcmVsZWFzZV9xdWV1ZV93b3JrDQo+ID4gW252bWV0X3JkbWFdDQo+ID4gWyA2ODUuODI0MDAy
XSBDYWxsIFRyYWNlOg0KPiA+IFsgNjg1LjgyNDcwNl0gPFRBU0s+DQo+ID4gWyA2ODUuODI1Mzg2
XSBkdW1wX3N0YWNrX2x2bCsweDRkLzB4NzANCj4gPiBbIDY4NS44MjYwNjBdIHBhbmljKzB4MzNl
LzB4MzcwDQo+ID4gWyA2ODUuODI2NzI0XSA/IGNoZWNrX2ZsdXNoX2RlcGVuZGVuY3krMHgxMWYv
MHgxNDANCj4gPiBbIDY4NS44MjczODNdIGNoZWNrX3BhbmljX29uX3dhcm4rMHg0NC8weDYwDQo+
ID4gWyA2ODUuODI4MDIxXSBfX3dhcm4rMHg4ZC8weDEzMA0KPiA+IFsgNjg1LjgyODYyOV0gPyBj
aGVja19mbHVzaF9kZXBlbmRlbmN5KzB4MTFmLzB4MTQwDQo+ID4gWyA2ODUuODI5MjI5XSByZXBv
cnRfYnVnKzB4MTZmLzB4MWEwDQo+ID4gWyA2ODUuODI5ODE5XSBoYW5kbGVfYnVnKzB4M2MvMHg4
MA0KPiA+IFsgNjg1LjgzMDM5Nl0gZXhjX2ludmFsaWRfb3ArMHgxNy8weDcwDQo+ID4gWyA2ODUu
ODMwOTcyXSBhc21fZXhjX2ludmFsaWRfb3ArMHgxYS8weDIwDQo+ID4gWyA2ODUuODMxNTQ4XSBS
SVA6IDAwMTA6Y2hlY2tfZmx1c2hfZGVwZW5kZW5jeSsweDExZi8weDE0MA0KPiA+IFsgNjg1Ljgz
MjEyOV0gQ29kZTogOGIgNDUgMTggNDggOGQgYjIgYjAgMDAgMDAgMDAgNDkgODkgZTggNDggOGQg
OGIgYjAgMDANCj4gPiAwMCAwMCA0OCBjNyBjNyAyOCBmZSBiMSBiMiBjNiAwNSA0ZiA5NyA1OSAw
MiAwMSA0OCA4OSBjMiBlOCBhMSA5MSBmZCBmZg0KPiA+IDwwZj4gMGIgZTkgZmMgZmUgZmYgZmYg
ODAgM2QgM2EgOTcgNTkgMDIgMDAgNzUgOTMgZTkgMmEgZmYgZmYgZmYgNjYNCj4gPiBbIDY4NS44
MzMzNDFdIFJTUDogMDAxODpmZmZmYjMxMzQ4NzkzY2M4IEVGTEFHUzogMDAwMTAwODINCj4gPiBb
IDY4NS44MzM5NTRdIFJBWDogMDAwMDAwMDAwMDAwMDAwMCBSQlg6IGZmZmY5NmM3MDU3NTQ4MDAg
UkNYOg0KPiA+IDAwMDAwMDAwMDAwMDAwMjcNCj4gPiBbIDY4NS44MzQ1NjldIFJEWDogZmZmZjk2
Y2U1ZmNhMThjOCBSU0k6IDAwMDAwMDAwMDAwMDAwMDEgUkRJOg0KPiA+IGZmZmY5NmNlNWZjYTE4
YzANCj4gPiBbIDY4NS44MzUxOTZdIFJCUDogZmZmZmZmZmZjMGQyMTdmMCBSMDg6IDAwMDAwMDAw
MDAwMDAwMDAgUjA5Og0KPiA+IGZmZmZiMzEzNDg3OTNiMzgNCj4gPiBbIDY4NS44MzU4MjNdIFIx
MDogZmZmZmZmZmZiMzUxNjgwOCBSMTE6IDAwMDAwMDAwMDAwMDAwMDMgUjEyOg0KPiA+IGZmZmY5
NmM3MGQyYWE4YzANCj4gPiBbIDY4NS44MzY0NTBdIFIxMzogZmZmZjk2YzcwNDNjNmE4MCBSMTQ6
IDAwMDAwMDAwMDAwMDAwMDEgUjE1Og0KPiA+IGZmZmY5NmM3MDQxNDc0MDANCj4gPiBbIDY4NS44
MzcwNzldID8gX19wZnhfaXJkbWFfZmx1c2hfd29ya2VyKzB4MTAvMHgxMCBbaXJkbWFdDQo+ID4g
WyA2ODUuODM3NzU1XSA/IGNoZWNrX2ZsdXNoX2RlcGVuZGVuY3krMHgxMWYvMHgxNDANCj4gPiBb
IDY4NS44MzgzOTRdIF9fZmx1c2hfd29yay5pc3JhLjArMHgxMGQvMHgyOTANCj4gPiBbIDY4NS44
MzkwMzddIF9fY2FuY2VsX3dvcmtfdGltZXIrMHgxMDMvMHgxYTANCj4gPiBbIDY4NS44Mzk2Nzld
IGlyZG1hX2Rlc3Ryb3lfcXArMHhkNC8weDE4MCBbaXJkbWFdDQo+ID4gWyA2ODUuODQwMzU0XSBp
Yl9kZXN0cm95X3FwX3VzZXIrMHg5My8weDFhMCBbaWJfY29yZV0NCj4gPiBbIDY4NS44NDEwNDld
IG52bWV0X3JkbWFfZnJlZV9xdWV1ZSsweDM1LzB4YzAgW252bWV0X3JkbWFdDQo+ID4gWyA2ODUu
ODQxNzA3XSBudm1ldF9yZG1hX3JlbGVhc2VfcXVldWVfd29yaysweDFkLzB4NTAgW252bWV0X3Jk
bWFdDQo+ID4gWyA2ODUuODQyMzY3XSBwcm9jZXNzX29uZV93b3JrKzB4MTcwLzB4MzMwDQo+ID4g
WyA2ODUuODQzMDIwXSB3b3JrZXJfdGhyZWFkKzB4MjgwLzB4M2QwDQo+ID4gWyA2ODUuODQzNjcw
XSA/IF9fcGZ4X3dvcmtlcl90aHJlYWQrMHgxMC8weDEwDQo+ID4gWyA2ODUuODQ0MzE2XSBrdGhy
ZWFkKzB4ZTgvMHgxMjANCj4gPiBbIDY4NS44NDQ5NTVdID8gX19wZnhfa3RocmVhZCsweDEwLzB4
MTANCj4gPiBbIDY4NS44NDU1OTBdIHJldF9mcm9tX2ZvcmsrMHgzNC8weDUwDQo+ID4gWyA2ODUu
ODQ2MjIzXSA/IF9fcGZ4X2t0aHJlYWQrMHgxMC8weDEwDQo+ID4gWyA2ODUuODQ2ODUzXSByZXRf
ZnJvbV9mb3JrX2FzbSsweDFiLzB4MzANCj4gPiBbIDY4NS44NDc0ODVdIDwvVEFTSz4NCj4gPg0K
DQo=

