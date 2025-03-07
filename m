Return-Path: <linux-rdma+bounces-8476-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21120A56DC3
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 17:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32BCC7A5825
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 16:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B902C23BD15;
	Fri,  7 Mar 2025 16:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VYCfux0x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFD92DF68
	for <linux-rdma@vger.kernel.org>; Fri,  7 Mar 2025 16:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365217; cv=fail; b=ARKS7Myp1rINupg/iLvQ+Abq3w+870Xry7aoXVDmsZercEvxf7Gv/HYgPgdKljVKgg5M1oOR69j4SQ6gJZn3ViDqwY3JKEbcqZWTCjs2vluX6nzx8MlYo5Wg0ORSN9KYGOQMY4KjVNo0CRH4YrNa6W9+pDA9mx/lXbJuFJ1qSyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365217; c=relaxed/simple;
	bh=bGLmo38cdFWf4BDiG35dQt0bRq905LRZkD8VWNQCwRo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=DezM4E+ThJTB/Twm2WVX1vpZfbyKIkRrXqnbjt/ULoASSUjBTc3sw1CDswn7o1HIkoSmEnC/vZY0KRuX0K7V7ruLKw3KmmOBYWzftH/MaUmwimEbZFjQMvXCDhEJQ+LErpP6IZ3fY581yiAwc04HdurnAhxybQ5x31wbOkuaaos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com; spf=pass smtp.mailfrom=zurich.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VYCfux0x; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zurich.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zurich.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5279RiQh012025;
	Fri, 7 Mar 2025 16:33:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bGLmo3
	8cdFWf4BDiG35dQt0bRq905LRZkD8VWNQCwRo=; b=VYCfux0xErx80lMUQARJE6
	Stsa6w7j4R81yDdr8lyS6hcn2P6T+olOLPN73TvnbGv8gZuRJC4v2IDysNSVKubU
	KSFxBKhg5oIF+HpW4MGtB5iykZbpBW9EkZrc+HHOcvJF0V4A/hRMaD2oecDfKt0j
	OTdgr+DPys6z1WfAa3x3uRPGxqOh4eJzw3d/YN5Gk/+Hk24sML9rbrIv9FhqdWgQ
	ztXawvpbuBcekN5veyMLZy85M0g95ZpexGjOLsP4vIYBKlejeGhZq2Hlwv258Gbj
	mHL9drc4kv2Q4JXPkEFLFU8dTcuMIse1YA52qLXjqvBDDglq7eJpWgOMZUbJblyw
	==
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2047.outbound.protection.outlook.com [104.47.57.47])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 457k45d0hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 16:33:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oeIpsxOgnx5gsoLJZa+vmHIrtH6o/ed+oQX7lvkCq3nZooamtc4yX3OBtBBjJR1jwoHlFXYdDES2xPdUFJZxtmIMZhqZ3WRoF/4KLISKxekhTizarhsu+URNgihC2dEEBfHrH4DpSyTeYPHiEg5ffDSVS9AmNA3fMkNOd4tLgFsgnoGQh4fJVp8p8Xxqzhz0o85PAgNtFS5dcGm4FIUGb1qUlOH0SiBIzo1hrXfkskaS3F3ofsIJLIfy4mC96Cpve0zg94KiLyKWbw2v5SwHLbXx9IU7RVKqWjSc77CV7Y166RjsTiCA8PBYdoDx95rCFIifwmI6RN+P2XMd0UvwHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6cMmWi2sXzyNGC5/19oda5QoF0QyeSIDVQudbz6U7s=;
 b=GfuatFaCKxdXcAvR5SO37hOQrKxzhSmsxjeFQ6JI3OLtCtu2GkY0c9zsMXSLZBP8XDMQZ9WnM+I7DqqKztUxUD9wb1TUqBFfHhSJ/9S8x4tK3qSYnVv6QXgRguZMOQhisPxTFFueVFP1jDPH8C0/1Y8qZ6gYzL3V+Kp7waUNSyJOOdh3t9tijnpswnW57wSaUSSHx5y+7ntn/WLF/TSN3dohwBsAqhnVh4CxchtWyDPq5ga/aHeZTxFHeDQFg4JVosE+y+K8ZVfBk6mFFK1NBxhsbGT1fjHEqQ/DOrDkMO3EmhnNIPgwG77FDRbDiNO4OnT3+50sfI6gi0I9KeOLHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zurich.ibm.com; dmarc=pass action=none
 header.from=zurich.ibm.com; dkim=pass header.d=zurich.ibm.com; arc=none
Received: from BN8PR15MB2513.namprd15.prod.outlook.com (2603:10b6:408:cc::30)
 by IA0PPF35312410E.namprd15.prod.outlook.com (2603:10b6:20f:fc04::b13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Fri, 7 Mar
 2025 16:33:28 +0000
Received: from BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::dd5e:86f1:8719:2f16]) by BN8PR15MB2513.namprd15.prod.outlook.com
 ([fe80::dd5e:86f1:8719:2f16%4]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 16:33:28 +0000
From: Bernard Metzler <BMT@zurich.ibm.com>
To: "Dante Van Poucke (UGent-imec)" <Dante.VanPoucke@UGent.be>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: rselect() timeout only happens once on SoftiWARP
Thread-Topic: rselect() timeout only happens once on SoftiWARP
Thread-Index: AQHbj2mgCYeHPEw+kkKhn953Qy+pi7Nn1SgA
Date: Fri, 7 Mar 2025 16:33:27 +0000
Message-ID:
 <BN8PR15MB2513AD4DA58E731B8F89BDAA99D52@BN8PR15MB2513.namprd15.prod.outlook.com>
References:
 <VI1PR09MB37741EAD549654B4B689C55094D52@VI1PR09MB3774.eurprd09.prod.outlook.com>
In-Reply-To:
 <VI1PR09MB37741EAD549654B4B689C55094D52@VI1PR09MB3774.eurprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR15MB2513:EE_|IA0PPF35312410E:EE_
x-ms-office365-filtering-correlation-id: b10a7d7a-48ab-48b4-36d7-08dd5d95ca30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YXNsOXZNRTRkblFLbmVqMGtzdy9xczJEVCs0OFBlbGV2aU5iNWpuaUZic2dm?=
 =?utf-8?B?aDVvcGpJQmF0ZENJT2lTMjNKdGd2ZnoxbVg4MVpaQ2kzaGVpaTUrL1loWUdZ?=
 =?utf-8?B?Qm44OXNKNVIreFJBd2J3dUNXKzFMZ0xCdmlLMTh5eDQxZTUwUGxXYjQxeXV3?=
 =?utf-8?B?c0JrSmhsQWg3MTA1SjlYWDFFUTAvK09NYWRvU3cxcWNRNW9QUFJIa1JCaXQ1?=
 =?utf-8?B?ZEc5Y2ZqeW5aU25aWktNTmEyVERjZlk1c3lPbkRXa2xnb0l2U3VGSU12dURs?=
 =?utf-8?B?N1liMDZPdDdiVGZmTlpZR2lpTk1pdVpEcjBpQmllSnptdFdWNkp5MGIzWER2?=
 =?utf-8?B?VkI4RTFsZHhZZ0V6cHZEK0l1RUgwUi83amVKajZ3d2t5U2dFcGhsY3NoZ0dK?=
 =?utf-8?B?dmxnb3dMWG5YdDRlUnppdHl5T1pMZmtNeTJpU2JQTkRlaWdyMUx5VkUwb09k?=
 =?utf-8?B?K2lTY0xzZVREbXB1VmJ6WXN4MFpEQ1hsVGpGemduKzdHWjE1QnJQOUxMcHc0?=
 =?utf-8?B?Z2pWRkFkSU1UZFdmM1ZDVndkWFBaN0NoY2ZzVkNUQjJjR2wxNExBVWZZUXRn?=
 =?utf-8?B?VUtQQ1JOUW5kOXhudlJpK2xjWTVqdmg0MEo3V2ovcGdZaWx1N2ZJVzRLeXlz?=
 =?utf-8?B?UVlzZDFWRW5mdHdCQ0xiM0s5SWhhYzZXUjNZSS9yWk5Bam4wZDcxZXptamlu?=
 =?utf-8?B?TU84NG9WOExsUGNvTkR3RlF5UkhGaktYM3hSTXZxU2ptWG15NjZCVTMrMWwx?=
 =?utf-8?B?ZGZmekdMckcraGZLcjJ1NnJISjJxbUI5WG1sK2VSUUFMVlI2UWUxS0xiK1pt?=
 =?utf-8?B?WlA1ZW9yeTBsTk41bzJNREFTNXBGcDlLanIzMUhyNUhBSlo2LzhIWHdHWndh?=
 =?utf-8?B?WDExODNxbVFvc3o2ZFVTU0ZXa0NSRmgySWF3K1VyTXZ3WWRaTWdiajdFSk85?=
 =?utf-8?B?R0xsY1loaVF4eVdhbzgxL09uOGxNQUpsSzRudkF4NDZ1SnRsbzJhWmIraGdl?=
 =?utf-8?B?K29lVWJVZXF2elB3SGVhakVHSkp4M001YjFqSWVOVFBtQmFORkxLYTlJZHNN?=
 =?utf-8?B?b1FOcmx4NXdRWEZOa3ZWd3lQSEVSQU5pTUNpTVRHZWJlL1M4ZWwxUHNYdEM1?=
 =?utf-8?B?bkRZendkWFNKeGZiTitSbE93Z2QxdUdGNWE5T2gwRFJhVE1xUVQ5TEhhU3NF?=
 =?utf-8?B?TG0xQTZtU1dSbk54cXZnUnFhMlp3Y1ZZc0RBWmpUZld2WmpySXVETUs1U2FT?=
 =?utf-8?B?ZjFaWnNETjFnSUptVWxZcmJlSnNzTjNZMjBuRGdLbnJhZlFRQVJPZHJXRUNq?=
 =?utf-8?B?TlBsVitnVThjYkJ4Y1UzWXhaOWFxMCtLbXdQYU1uWDkwMHNzUVdHcXg4MHJL?=
 =?utf-8?B?S3liaXpaSnRjenhpYXM5ZGJmQ0tpZG51dFpSYzhDZDM3NXRyUzdkRUhzS2JM?=
 =?utf-8?B?a3Z4am1DNGJnVDdYaCtySXp0RlJyN1dFWmsrYUVTTWFzazVCa2N0Ym9Xa0l3?=
 =?utf-8?B?OHJrczBYQ05mS0pVMHd6dmN2dE44OHFRZXJmZmNjZnB5OFBKZ1ZRODlGRnQ3?=
 =?utf-8?B?UWtqQWJsMWF6K0hrWlZVeXZyZEFqa1BhbVBmVG13LytFVUYrQTVreGpsZm80?=
 =?utf-8?B?VnFydkE2emRRR3l1NkhzZXBRMnVCUnZqRW1iRXRqM2M3YkE4dHhHWkE4QnN6?=
 =?utf-8?B?L2JCQXc4cGpmTzNWK2J6UWpDUFludHpNbURLejhnaXAzQlRIaTBrOHFaZE9Q?=
 =?utf-8?B?c3YwSEdBbjBZVUZGM0ZQVytHYzAvWUUxL2tWbGZIc2JMMG9sdXB5cGdnNmVF?=
 =?utf-8?B?ZDdkbnE2ZjhSS1ByVHJZWDlBRDNHSm0zazZQbEhJU2lXTXlmdFdzR2s0Q1Nl?=
 =?utf-8?B?RFFJR2I2M1lmdStwWlNUZFZnTUgzRjdPSU91YXZ0TzJxUU4vNVRuVXNOTGRL?=
 =?utf-8?Q?51J1GYMpgIdolATKfA3YqiueMxBCnBOs?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB2513.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bmYyNmFBRGppU21mSTNHNEUvb0JmN1hheEFDTjFDdkk5Nm5seDVyczBHQkhi?=
 =?utf-8?B?K25KaUNPNDcwRTRQUmc3aEhZZ0JBa09uYVlZTnNUMy83dDIxaS9IZXVsbXh2?=
 =?utf-8?B?R2JrWE83WHh2cXJkMFZWVkxOQmxxVVVLREM1N0pXTitRU3dKYkdsRXZJQVlJ?=
 =?utf-8?B?LzNuWk90Zk9vOW5pakQrR0FaaTNLNE55a0tmVWh3b2VMZDF5RThKcVJRTFJh?=
 =?utf-8?B?S1UyS29XTSt3OHlrZmx3ZGNzd2xBTTRFWXNFTUhOTkhlcU9LdjIwaG93dmFo?=
 =?utf-8?B?R1EwT2Y1Z0NocDRPM3VPS1p5Mk5BNFpITDNPVUN3cXdNc1FSYUhaaitTN1hZ?=
 =?utf-8?B?M1NzU3RLTzJsdWVwa01sNVF3OVlzTkdDZ3FDVHJyNHpSMEVlcitBMEt5RzhP?=
 =?utf-8?B?RTZFOHV3M2RLRkFmQTBxMElkbjhUQlZ5T092SEMrTUhrNG5UNzZTR3ZPdElP?=
 =?utf-8?B?elJEYmRzRkZKUjhBMTcvUFZ4OEp2U0lwOVM0WTV6dlhvT1prK0hXNkNoSjdl?=
 =?utf-8?B?OGdhNlpKekZQZnJ0V0c0MWNkTExiRmdjb081djdEY0xrUUFlTFNIVllFSnBG?=
 =?utf-8?B?bnhPdS82dkIvN3h1NFlzdjh4NWl1Tlk5d0ZTMHEzODhDQWEwL1BNWmUxMERo?=
 =?utf-8?B?WlBQNWdtSE9qaVBSUkhEc2VBTSthNUxJRmlwb0poblpqT2wyVHJ2ODlEVlpn?=
 =?utf-8?B?TFFsdWY0RExaMUdHRGRLZkVrZjRHNDhNRTloNVA5ZDF5UHdKdFFDbXFRVWUw?=
 =?utf-8?B?MnE4U2txTDBzT2hHNmNGbk80eUxPTWU1MjJyRXgrODVzNjhiNER1KzRpUTdw?=
 =?utf-8?B?VUI3Y2ZxOFJvNW1XRkUrQmVEeGRCTWh5UHd0M1RVK2FrQ0hZUldyRWFBT01w?=
 =?utf-8?B?MlNheUhPRVoxdWdFUmF2Y1lHQXFMcllmdCtPUGN1MnlEQW1wQWx6SHNOeVV3?=
 =?utf-8?B?a0lhY1JQMEJzU0h5UnN4M2srTzBCMzNFalFXVEFXaVhnNE5xcm0zaXoyRG9T?=
 =?utf-8?B?dUtXSVl1SU5pOEVkRFpFZ2JydzZRSld5MEpRa1lwYnV6TXJpcE5ReUxCRG9u?=
 =?utf-8?B?YXphN2doTHlkUnJWR1c3UjN2RlVzbTZMQTNQRmhOa3o2Z2VXUFM5SVlmQmlr?=
 =?utf-8?B?RjFuL2l1UkF4R1FxMmpoam9qZXk2azBFZGRtTFJKOXZJTmtjNXZrUFcwQXp4?=
 =?utf-8?B?Qy9LVEo3QzlHV0RScjBoNzZURERDSDlHcXNDRzFEMmRnVWtnaUQrYkdUZUNt?=
 =?utf-8?B?VDhHRGlnNjZKZTB0cGZST3pIUU5XU3owZ3QrcUhwWEdXcjl0NFFBWTd3K3dB?=
 =?utf-8?B?MlhGZm9OZVNRWjF1ZnR6UTRqRCs1aEhoVExhYmRzeWdWU0ttaUlNRTJyRkRo?=
 =?utf-8?B?RDdwZmM4UHliaFAyM3VidmZlcDcxS244WTZUNmgwd3lOakp1aXNTZEN6dVR0?=
 =?utf-8?B?c1BoQlZmVTZxcFdXZEk4SzB5SFVsR2VKcWlualRBQ1RLZm5JNC9MQmllTzR5?=
 =?utf-8?B?eENDdlV1eDZHWHF3cHFGU3pMYmJ1WVdLQjVsNG4zNkR1anVOUERIcHdrL0hM?=
 =?utf-8?B?Sk5iUkVmN01MbjQ3RUxYVkd0aVRFa2pFeTNzU3pBTmNiams4dGxIbjNGaVpQ?=
 =?utf-8?B?Mi9USkp3eEV0UXBCMnFIbWltSks2eHpKRUwvMnhzZTQxZEFpYks1Q0VHbGV2?=
 =?utf-8?B?N0JKNTJCT20zTkY3TWdPbVVWYXJHZGxFdm94UDBoSk1zVHRWWEs0V1VsSHJh?=
 =?utf-8?B?bktZby9OZkdPckhwdzlnU0RzNGRxMFB2QmZEdmlCbUdNYzJhUytmYUtkVzRl?=
 =?utf-8?B?MjZIaHM5aHZmeDdudHpRc3U5M1FLdWs2dnJXOWZrSExJbFFWMFQ0VXJ4dkZ6?=
 =?utf-8?B?ZlZoOW9xR0ZEbHhQMUpLL24yYWk0RHU2cENXUHZLZk9yM1lQd2svd204Wndk?=
 =?utf-8?B?cGc1b2FjNDhiSTNKL000SGJ5Ui94Vlh2NjBVSHJnQUFJSW53WW5VWmtoN2Fu?=
 =?utf-8?B?Z3hjZWpVL29HaENpdnpXWDZLUi9UTUdKOVZWZldPTUFoYkNwQXQrVDFobEJV?=
 =?utf-8?B?VnFVQ1lTSDlpZTJublE1WXl4cVk0WWg1emVUaUVSTG1BcXpac3lCTlpWMkh0?=
 =?utf-8?B?SlI0VnJHNVhyVzRGUkluMGkxbVlIUmRYZ2U5ai93RXJDekpBNHNEbGs3RkZW?=
 =?utf-8?Q?lOffWfaz7p9ZaXQzkQ2ElCI=3D?=
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Zurich.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB2513.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b10a7d7a-48ab-48b4-36d7-08dd5d95ca30
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 16:33:27.9802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x2UKnPexJS6Y7KJXfSV23cwD+SZIQ/t9YHWh9D2T4mXluJZDGlNHVDrGvKiRgmZuLI/qBcbwpIbH8sjQJBBtNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF35312410E
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: xE3KMosSH0GtK8iMMMFnw1EoPJqY2IcX
X-Proofpoint-GUID: xE3KMosSH0GtK8iMMMFnw1EoPJqY2IcX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_06,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503070122

Hi Dante,=20

please don't use this list for this type of debugging.
Maybe you encountered an MPA timeout and the connection
already closed. Let's take it off this list. I am going
to look into it.

Thanks,
Bernard.

From: Dante Van Poucke (UGent-imec) <Dante.VanPoucke@UGent.be>=20
Sent: Friday, March 7, 2025 3:30 PM
To: linux-rdma@vger.kernel.org
Subject: [EXTERNAL] rselect() timeout only happens once on SoftiWARP

System information Linux Distribution: Ubuntu 20.=E2=80=8A04 LTS Kernel Ver=
sion: 5.=E2=80=8A4.=E2=80=8A0-33-generic InfiniBand Hardware: SoftiWARP mod=
info siw: filename: /lib/modules/5.=E2=80=8A4.=E2=80=8A0-33-generic/kernel/=
drivers/infiniband/sw/siw/siw.=E2=80=8Ako alias: rdma-link-siw license:=E2=
=80=8A

System information
Linux Distribution: =C2=A0 =C2=A0Ubuntu 20.04 LTS
Kernel Version: 5.4.0-33-generic
InfiniBand Hardware: SoftiWARP
modinfo siw:
filename: =C2=A0 =C2=A0 =C2=A0 /lib/modules/5.4.0-33-generic/kernel/drivers=
/infiniband/sw/siw/siw.ko
alias: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rdma-link-siw
license: =C2=A0 =C2=A0 =C2=A0 =C2=A0Dual BSD/GPL
description: =C2=A0 =C2=A0Software iWARP Driver
author: =C2=A0 =C2=A0 =C2=A0 =C2=A0 Bernard Metzler
srcversion: =C2=A0 =C2=A0 5450ABB35545870E9970346
depends: =C2=A0 =C2=A0 =C2=A0 =C2=A0ib_core,libcrc32c
retpoline: =C2=A0 =C2=A0 =C2=A0Y
intree: =C2=A0 =C2=A0 =C2=A0 =C2=A0 Y
name: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 siw
gcc version: gcc (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0

Steps to Reproduce
Compile and run rsever.c and rclient.c. (gcc -o rclient rclient.c -lrdmacm)
Press enter on client side after 10 sec, and again after 10sec...

Expected behaviour (behaviour for server.c and client.c):=C2=A0
Waiting for connection on port 12345...
Client connected. Waiting for data...
Timeout: No data received in 5 seconds.
Timeout: No data received in 5 seconds..
Received: Hello from RDMA client!
Timeout: No data received in 5 seconds.
Timeout: No data received in 5 seconds..
Received: Hello from RDMA client!
Timeout: No data received in 5 seconds.
...
Actual behaviour:
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82 Waiting for connection on por=
t 12345...
Client connected. Waiting for data...
Timeout: No data received in 5 seconds.
Received: Hello from RDMA client!
Received: Hello from RDMA client!
...


