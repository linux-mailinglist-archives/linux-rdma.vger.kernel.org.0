Return-Path: <linux-rdma+bounces-13071-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 367CFB427DB
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 19:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0276207511
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 17:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D795030DD12;
	Wed,  3 Sep 2025 17:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K5Ewrt6p";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="M+BMENrd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36AA29DB99;
	Wed,  3 Sep 2025 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756920143; cv=fail; b=VpYMvtqb6ak4srWsrI4Nr/pN4fK6Q+pznJpFUO1S+ajo2KepwqJrL1uTgH+r1NnT8yM4WV0tKTSDwYkiKtburJXxj2fcGgQDvpIqMvISkLnsO/q6nOUSlDrNXK28IBcxIo70Cg3FL0WhBEHSEx5JUnImUKxt2jtnFGPjB/9I1LU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756920143; c=relaxed/simple;
	bh=mstOVjR3gpEP/Srfk2H/p1Ef8aCUCudP270KF88A9YE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u5RftO8xpzUB+7eDTUMrivFFc1K0S7QubWtpAp70Kh5orwxVOhDIlvaEUsNaI2Si6el+ReSmbmMTbW4cqySLwWvYGLptRTfGtZZxs26A/xqzvdRWj+HOmO2O6f3ZUukuWjckeemTILDRqsWHwY450CO0zT6sfJ9AKW/WQ+y2jVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K5Ewrt6p; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=M+BMENrd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583H4cwM001264;
	Wed, 3 Sep 2025 17:22:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=mstOVjR3gpEP/Srfk2H/p1Ef8aCUCudP270KF88A9YE=; b=
	K5Ewrt6p3LdICbuqKgurW1AToKFnD5gTqayN7AeUNHc/D68o4t6qXZdSAZJ5/yWH
	TanMyf2ioFUOlJR8Zv3I9wQ86jeylPk3WCUGMFjojG+ynbbp4juE7Tsuok5BIfg8
	PnTb6FL+vGXsXLHh3HKWXssVIvc/f4oz0JboW5A0loj6xUgIxjoDuX68wV+/UCkH
	kcOzvmoy2qfAi7i+dod6kdL/omN14it7RDXsY5oeezeGDBNIrMS5xtIRCZ0+4L74
	5bP2HGNi1NDbSyq4FOfLej5r7m5pe+H1dAUWyG1Ia+M51OfXyEn2EGq0qgOK8qUZ
	wzckIbVobGW5DJPTeJLoGQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48xsrm00ty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 17:22:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 583H8h8Y036112;
	Wed, 3 Sep 2025 17:22:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrakb6n-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 17:22:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owDtYlOL2SUH+iDNPr3k696LWRwTVwMm0FD9Gqtmv8GG/hUOE/WKSVBXWEwqWxvBDZDeKHk5sed41qO8JmeQC3v4rxKCTUg0vHrEsKajApwBvmfloL/sIa3b7h3TNR2QN7VIF16ER0vlsc8IsUkVSppLEwkygQU6xOWfn5i2w5uQhlaUBX+DkUi98lOh4oo7Sm3ZvJRwwhJVsd1YpbFOIEfAT4xJ6YZQ14gNEFiNto+pjbw5J2hsZsWHTWiAPtGjQxfiESmzRkbcaSSRp5Je4cxRNAawhmlE2YLFOG1rU7sf8urmL6kEhI//s7Bkwwnpu3yFxoax3WT7tuak5HGq7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mstOVjR3gpEP/Srfk2H/p1Ef8aCUCudP270KF88A9YE=;
 b=oUfVSgkiZXCO2u7D6087HDclj6DS0rOwY8uHIRBJg80BN2qklKkttM51qIR+w8/cOMHl7nBz75bIeXadahkpOPo4aI9Gli/I2okUJLJIHeR7SJzZbLAL8wsYSoXSuWjNwhTbIo1vAsOZp5S2ZUzwzZkBj4Z9CghddQZT5lgJ/nhs0kQvQAoQQcIm6WHQB4yEnmYrtDva6c8ugoja7MQ1VngHI/FtaymP+JTXy0XG7YbYc8bY+DJ2jFLLmzSjYv6LBaaiXZ6mF0ucHk3Gx0OHElJqTWovaWoCtjsXdRrSBcBVT63F1Nryxjc8KvNDezLnKkQvnrVudy/yhv8x7VeTMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mstOVjR3gpEP/Srfk2H/p1Ef8aCUCudP270KF88A9YE=;
 b=M+BMENrdmceCKtGOPoIKRzHn29YSzSNjQJ0In5dLBgKMW2Lvj3UhbVgR+yrxYFp582Z4Lc573T+7z8BTsHvidwmxsNt1TSIkxUkHCxZPUct9RVxy0viizey0PW3DDMUdz9k4MDy18P4JWZtoFLie+IU+Hz2T09BfLKZ0aEzCTos=
Received: from CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13)
 by CYYPR10MB7627.namprd10.prod.outlook.com (2603:10b6:930:be::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 17:22:09 +0000
Received: from CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::b3df:777f:7515:d04f]) by CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::b3df:777f:7515:d04f%3]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 17:22:09 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Allison Henderson <allison.henderson@oracle.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        OFED mailing list
	<linux-rdma@vger.kernel.org>,
        "rds-devel@oss.oracle.com"
	<rds-devel@oss.oracle.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 2/2] rds: ib: Remove unused extern definition
Thread-Topic: [PATCH net 2/2] rds: ib: Remove unused extern definition
Thread-Index: AQHcHPBAKx16lQseiUKv300PntFYdbSBqFuAgAADk4CAAAGygIAABwGA
Date: Wed, 3 Sep 2025 17:22:09 +0000
Message-ID: <85C2FF53-8E36-433E-9B5B-AC389DCEA42D@oracle.com>
References: <20250903163140.3864215-1-haakon.bugge@oracle.com>
 <20250903163140.3864215-2-haakon.bugge@oracle.com>
 <2025090340-rejoicing-kleenex-c29d@gregkh>
 <1D680271-B2DF-4CAB-A91D-4577CA6861E8@oracle.com>
 <2025090314-corporate-yanking-e1b1@gregkh>
In-Reply-To: <2025090314-corporate-yanking-e1b1@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6826:EE_|CYYPR10MB7627:EE_
x-ms-office365-filtering-correlation-id: 7f18f5d5-be7e-4398-ebb4-08ddeb0e6a19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WHNIOG1FdGkyQ2phTzRydDFyT2ZEazhrRU1SWjRzeVJkbDJFSFlzV0dmeG1r?=
 =?utf-8?B?eUVIcllzc1BndmhBU2xhb2JOcHNKY2I4cXhCcW5zTHBlVWxUdm1FYTFIdmsz?=
 =?utf-8?B?Z0xWU29hUmtILys0Wm9zN2tZVVVtZjl3Y1BMSEJHenJLOUJmalBzV2c0emxk?=
 =?utf-8?B?Vnk1aTdTVEFnY2VYWjB0U0hyNW1QMW9WR0hJRnpnOVgrL2w5ODV4NVJmaU9C?=
 =?utf-8?B?ak5FV1dWTm5USDFuTEhUaGVtRGFaT0gxbnJ4bC9uSlZmblZJOGpLSUJLWDJ0?=
 =?utf-8?B?cTlLdm9sZ2o5akNGUmRzdnh4bVVvWkYrdDhsQmxLNStxdmgzSUhyRG93eWhC?=
 =?utf-8?B?RXpSdzNoS2tPWjROMDl5SThIaUsrRmgrVmZWTHdjamJFQXdzc251TGk5ZFVz?=
 =?utf-8?B?SmUvS3JCemdtZXhDTnpRSFdSK1dyRE9XR2pRNVhLQm44bU5vMVVaaTA2Wktq?=
 =?utf-8?B?MUt5NzBmTWwxMmRURnpBcFhFTktLRG1NSDJmSW8wdkljUVpwS1loVHROVHNG?=
 =?utf-8?B?bVpyNmF1eC9Gakh2VjJOS2xqaEoyWXNmSzE0YWNvdEJOYlRpYUxVNE5uZkw4?=
 =?utf-8?B?THduUFRiekh4azhQSklmaCs3Y005OVBzcnkwZldPSy9GcGNtVDM2Nm1qNXkx?=
 =?utf-8?B?eFJwTUdhYzB4ZTgybElGVW5RdnZWNFNNS2FTZG1VSnB6a2FPODRuVXBuWWpS?=
 =?utf-8?B?SGFXRlNBcDE5VHlldnBSbnBDRUpld2pjdExyR2lRS2xsYVdJTnpqUVRsaTcw?=
 =?utf-8?B?Z3M4TGZqemN2TDloUk15d1NlNlFnNzNjTXk2UVVydkYvREZYM2dWWkxFczhG?=
 =?utf-8?B?SENsL1lrdHpnc2REYjlySzA3RFpiNjNwQ05UNTFQU1NoUXdwNUFLa2c3anRC?=
 =?utf-8?B?VWlVWHBuTVZMK3Q5MW96a3g3cGVGSTVuV0Y4THVIdEdTYk5vMVc4TjJvYlh1?=
 =?utf-8?B?aTlXbFRuNVh5RlpneGlYT2oxRGtXT1pOR1hSZXFlY1hIUDNUNUhoK2NvUTh2?=
 =?utf-8?B?UHZqaFVvOHZBbkl4K2lJanAwYVMyZzZlcThWQUdkQWl6Z25LQXJMekJqbEl5?=
 =?utf-8?B?MWZHSzVOMHFUSWkzVlR6MjhwZDdMUlJkVXJaMDd3b04ya1NuRlcxOUlXbkJu?=
 =?utf-8?B?TzhweWhtNkpiTlhIcnNlRzFTZmFBTE1sSS9hMXg2bnZFbzlTdXZNTmgvcWF0?=
 =?utf-8?B?a0dEZFlWQ1FSV0pJY0JXUy9UckRST1BRaHVkVEVFNUNUVGxjeG1yM2pYd2tN?=
 =?utf-8?B?c2xqSzN2MTJVQkNsK1RoWVAzU1YrUU01a2tTQkxLUzhpcitYOGFDUUtoQU42?=
 =?utf-8?B?Znd0cnhZaDhCRHV1WG5IT2llZnV4M3NqMHBrV1hLSTkrRmRsWlJEZkg0U1ZM?=
 =?utf-8?B?Zk9lbmp0T1QyODR4N2FKbUtsd1VrV3JMNTJMOStURm9KbGpVdk5BUHNMWjZL?=
 =?utf-8?B?OTZhak8rdmpJS1paL0U5RG45QzNXSFI2bFVNWEtMRjRPZDlwTG9SMjdGMlZl?=
 =?utf-8?B?ZVg3MzR2dEtlazY3MklDeVJVdTRqenUyajI5cldXRkRtKzdLRk9ZaW8wZVVN?=
 =?utf-8?B?bEtDSytibXkrakJPN0R4Zk1CTnhBRXVlM0xhMUFtOHFaWWxrVCt1RmNKYzFE?=
 =?utf-8?B?LzlPV0R6cjRIb1N6RzRFOW1sSTU0Z01YOVl2aEczMHFRL2NPdkFML3F1d2J6?=
 =?utf-8?B?YjFZTGViaHhJZ2pzL1N0NXA1U3BiUFVNVWJINlY3dkZtRktVVXJOT3JlamVT?=
 =?utf-8?B?MzNjYVFEZ3RZSzZ3Y1ovR2l1Q0pJckZjbmM2QzJTQjNOd0JzM1hPRDE3bHJn?=
 =?utf-8?B?WXozQ0VwRGtSZ0RFYXhkWkF5TXVBREdoR05uaHJ5SGFOMkNKWXdaWmpnWmp3?=
 =?utf-8?B?R3Q4dS9SdU1vSUtCeDdPb3p2VFJ6dTBmOURIVUIrSG1ySkNrT1g1SWJyWEJx?=
 =?utf-8?B?VHQzME40RFkxdURpOHBlMUR5SFE2WnRIaHZ0cklXVG5KWDZuV3BCRVFJM3dW?=
 =?utf-8?B?dlQ1WmpIRWVBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6826.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y2dLdmRiazdYb0NhbXpvWnVLRlpMcmNCcEdSeXFEMTBZa2plSzZ1UldSV0Zx?=
 =?utf-8?B?UHVzcWREMjVXSjJLeGN4bnRRSnlpbGNjaFQwUENETWNjL0lzVTN2eW9ianUr?=
 =?utf-8?B?ekszbVpHcWVTaGMya3hoNmVBOGVlM2ZMb1N1ZktaOHhwMzhPZGZxTllaSlE2?=
 =?utf-8?B?WHdkOFRUSStIV2ozUWNhMERYYVRzN29yTDFIcWorU0ZkZjM4WnAra0NDdDQz?=
 =?utf-8?B?cEFIbmlzR0FXYXNUaDNtN2pmdWptQU1WZWFKQ085T1Y1aFErVVRWemttdWtX?=
 =?utf-8?B?Vk40RC9wU1pHd1JLRmFzc3NGNHJubVVtMmNvQlVRQjJJSERwOGJvT2g1ekRv?=
 =?utf-8?B?ck50R0paMEU5dXRnUFFsR1UvOE0vNnRnY1lyN0M4R1k2YVRsTUxLVVRudnRY?=
 =?utf-8?B?TUtNSXFXOGkwQkdDS2JlWmwyUitMdUcrVlJubWtXUnJaVDk1b3pxd2Mwc2F6?=
 =?utf-8?B?U1duOFlXREN5d0tQZjF2R1craVZTVkhqLzh6K09MdHBqNVhkSTNGQVdiYTBt?=
 =?utf-8?B?SHRHMWxQa0RjY09kRGs1aW43cFBUUk1ZT2sxMmlvczhWT0o2aDIzZXcra3pv?=
 =?utf-8?B?STlDUEZiUVg3WW90Y3ZGYzdZcUtFS3ErYTRWYVdxNlBiOWFKMUxITkV6eUZn?=
 =?utf-8?B?N0psMlVscnl3WGpMTk5hRFp4dk55NHhZRFBuWEdpZTdWcEF4d0FQTFUvQWRF?=
 =?utf-8?B?KzNwOENFdFEzUE9HZElMZDVhSVhocFFEQ054bTUwc09vMFBIOGVXQWxxTE1Z?=
 =?utf-8?B?VDhJNkd3b2ViQXZnaTl6L0lrbUVhN0FkeDFMQ2h0NjJIVzl2Y2Nwc3AxYytS?=
 =?utf-8?B?eXZ5MmZCYkM4SW5zNW5oemZLYytIb3ZLSEFJZlRmVk5peWhpNUVIWEFUWmZY?=
 =?utf-8?B?TGVJTDdoL1UyNnFqSXBaQy82aFNGandkTXFLNHVlY2xnRmNMUUZHc1A5TTE3?=
 =?utf-8?B?cHJkREpDWTBFQzhHMStRdEtkSlcybWVhdElLb1d5QTBQUGVxRE1VaGdkSnhH?=
 =?utf-8?B?S2t1N285TFdHTHB6a0dCWDErVFo5OVM1NGZpLzhWRWtsTkV3am5zSnRrREJk?=
 =?utf-8?B?S2g0MXR4WjY2SDNicGcxTXNmblVKZFpIemRDM3pick5IV01pZFF0WWpKbWhi?=
 =?utf-8?B?SWEwa1RrMWc1QmNROG90WE90VUFmTTNVNmZ3SzZJRVpDTFovTitKMkdVSnA5?=
 =?utf-8?B?Qndqd2RpL0xzamk1eW9TenNNdFIxT0FvOUtkTGpsSjZtbmxjRCsxbjJGV3pi?=
 =?utf-8?B?UGRCaDgvNG45WmpmejZaSkNQZDFXR2ljbDZlTzM1V1VtMDZVNjk0dFRhV2hq?=
 =?utf-8?B?dVQyZlhoWUZneEtyZUk4MUVDZm5SWlBuWnZxdkgvNkZBdHo2NHErc29pTnAv?=
 =?utf-8?B?cUJHTnEwRHRhVzBORTJaYXI0TDB3QVVNU3dBczBVZittRFV1OCtWTHpmTE50?=
 =?utf-8?B?bnNwSVVUdlBtM0NrOG5NNkswOGV4dWowYzhPOGE4eFNXNVh0WXBySHJib1lj?=
 =?utf-8?B?V1N1K0hlWTAvelNneWZTdTF1dDlrRXkrVkxQQ0hUTXZmbnkrckVWakhsQkRv?=
 =?utf-8?B?Nm02Q0FuNkZrS2FUVjdETnFaa29CZ2hES0FnaHlEKzlwdFFhQ1pjUU0xUEpU?=
 =?utf-8?B?dk81M0R4TElSVE1RNVRuSytzQ1VlNmxGcnUzVWFDMHhXdDVlK3FOL0o5cGNG?=
 =?utf-8?B?MU11dThrampHNHhyZWxyN1RaMmErdXQwd0l3SlhIbE9SSGhjS2RkNll4MGpL?=
 =?utf-8?B?ZDFjcjNqd0lVYkdaL1YwSGY3eU04RVo1cFJJcTlrSUxCRWZkTkVzV1FySWhE?=
 =?utf-8?B?aHZCeW1RWlVYZG0xaEhFWUtqY2hTdk9EL1J4RmpvNmdQSHRQUy9sOURTeGFZ?=
 =?utf-8?B?VGYxeHBkWUU4VHREcjJ0VmxrTUVWNnovUVdvY0dQRmlPbVFubk5NK3JlcTZi?=
 =?utf-8?B?Y091N05BbW5HdlVQTFlpcnhjcW5ORi8yTFJKZS93RXhDVW9LMEdBQ3U0N1dI?=
 =?utf-8?B?WnFETnpWanUxT1UvSG5hN2ZFSHNwT1RKQjVZRTRqK3YrRjkyRkgxWXVPQVAw?=
 =?utf-8?B?c2Q3SlFwckJqT3REQmd4V0dMT3o3c09MYnltYVpLbThGaXFkcFhHYWMwRWNH?=
 =?utf-8?B?UThFSDZ0U1Z6NTFSK2U3cmMwczJaQXlZWTFsZEh1cjYwbE5XOUVnRFdHRWtG?=
 =?utf-8?B?cGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA29B3E8EC50EF4F905D03FFC4B50C17@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+T4Kz0YS6CW72VIJNnbfGsOw12C9V8CPSMrozwXB2sSfU2IgN0+CeQclRdov17OeNsY9MNH11gUj75GTUddWaNMMtj7SgTJD1Hj09sCoKTi4zidWRlgCjlx49z8gf6jLg2cpxynXiiYwrWERTz4vorpJhgrBB74Wap4WUV4Kz1jbvTsdFNLWAYZnlDux8dBTLER0i9VbqWm3MzSU7Edqt6uJkb1mYcss/iwzktVhePLtPE1uQpKWpKlOPxFpW9HTulekOVI6qdRO+MdchIXjilpMcDHNUzYjqeK0KVwFmcSZaKwEtA7QFOCtdOXGrlMgj2oLU93/95u/iRcxhiSnYAIBOIKRSoWeRjOlHmisCUHWbD91Z8mMdu/PYtzip+Hy9I2wLBWSOnWO12NEes9VfdVjcCossI/dey+T/2run1hPS9RejoZ6vaAbovLK3QaGK/l12x7PEwNgNDRi9dbBNZMGVDp9T3d4Y/7AZtRVOFGNk0OVa0pjQN/vqlFr+UOli/6grui53l2ILVHaaxSNIIIOwF+d00zPderJiAKr28L5qag5HrfdX664P9dkjVu9eVRMUGcp2PC+KBGGsECjXjskoLF2ZguUFK8kZgJgfU4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6826.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f18f5d5-be7e-4398-ebb4-08ddeb0e6a19
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 17:22:09.8236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: czhhw+zkN7ovTcEoeVRXJIgVPf1W609+y7wVNyXgGcBHCIXS56hgWEaQLqoAzX8rEqaUtXIyL5t0tKzO83cN0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7627
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509030174
X-Proofpoint-ORIG-GUID: Q7WLs99RLE3a4Ommdjac6mdtCciWtX8n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDE3MiBTYWx0ZWRfX2s8R3UBl2rLf
 hC8Xt2qEMsurRvPaBqDIpWK8FCwug+csBz/vACn29RQ5NOmR5Tx0WwEPmsYJOUPmvWnlktuwemF
 CZm7gEL3xxgYH+kDl/eVOjvN+sg7y/ALYcdCp6iDjPRcbQOufeQ/SiauLqbqg8peILWgN/FStSQ
 nwyn0Z4Mb5DJpvGE8N5963li1BkWnwCinehn6pkDnYeZbBQLhBESB+H3G8XBQTBmvTn/1595V/a
 Zh77edPNhddwlJ9nKaH8O8KwvkxcUWOBv6O0GQ93fE5TE7q3hXIEoGSfKx/R981NZjfWXVR87x4
 PBJluyvJNMU9VINgUVUdcxfpgMhQPicgA1JeZaeylt8Rabc3hEq1tn1jsoiYY0zM4EwtV2HkxSJ
 xR4udfBo
X-Proofpoint-GUID: Q7WLs99RLE3a4Ommdjac6mdtCciWtX8n
X-Authority-Analysis: v=2.4 cv=V5Z90fni c=1 sm=1 tr=0 ts=68b87946 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10
 a=ag1SF4gXAAAA:8 a=yPCof4ZbAAAA:8 a=O2ZHXc703G6dV_GiliAA:9 a=QEXdDO2ut3YA:10
 a=Yupwre4RP9_Eg_Bd0iYG:22

DQoNCj4gT24gMyBTZXAgMjAyNSwgYXQgMTg6NTYsIEdyZWcgS0ggPGdyZWdraEBsaW51eGZvdW5k
YXRpb24ub3JnPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgU2VwIDAzLCAyMDI1IGF0IDA0OjUxOjAx
UE0gKzAwMDAsIEhhYWtvbiBCdWdnZSB3cm90ZToNCj4+IA0KPj4gDQo+Pj4gT24gMyBTZXAgMjAy
NSwgYXQgMTg6MzgsIEdyZWcgS0ggPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPiB3cm90ZToN
Cj4+PiANCj4+PiBPbiBXZWQsIFNlcCAwMywgMjAyNSBhdCAwNjozMTozN1BNICswMjAwLCBIw6Vr
b24gQnVnZ2Ugd3JvdGU6DQo+Pj4+IEZpeGVzOiAyY2IyOTEyZDY1NjMgKCJSRFM6IElCOiBhZGQg
RmFzdHJlZyBNUiAoRlJNUikgZGV0ZWN0aW9uIHN1cHBvcnQiKQ0KPj4+PiBTaWduZWQtb2ZmLWJ5
OiBIw6Vrb24gQnVnZ2UgPGhhYWtvbi5idWdnZUBvcmFjbGUuY29tPg0KPj4+PiAtLS0NCj4+Pj4g
bmV0L3Jkcy9pYl9tci5oIHwgMSAtDQo+Pj4+IDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0p
DQo+Pj4gDQo+Pj4gSSBrbm93IEkgY2FuJ3QgdGFrZSBwYXRjaGVzIHdpdGhvdXQgYW55IGNoYW5n
ZWxvZyB0ZXh0LCBidXQgbWF5YmUgb3RoZXINCj4+PiBtYWludGFpbmVyIGFyZSBtb3JlIGxheCA6
KQ0KPj4gDQo+PiBZb3UgbWVhbiB0aGUgZW1wdHkgY29tbWl0IG1lc3NhZ2U/IERpZCBwYXNzIGNo
ZWNrcGF0Y2gucGwgLS1zdHJpY3QgdGhvdWdoLg0KPiANCj4gY2hlY2twYXRjaCBpcyBhIGhpbnQu
ICBXaGF0IHdvdWxkIHlvdSB3YW50IHRvIHNlZSBpZiB5b3Ugd2VyZSBhIHJldmlld2VyPw0KDQpO
UC4gTGV0IG1lIHNlbmQgYSB2MiB3aXRoIGEgY29tbWl0IG1lc3NhZ2UgdGhhdCBhbHNvIGV4cGxh
aW5zIHRoZSBoaXN0b3J5IGhlcmUuDQoNCg0KVGh4cywgSMOla29uDQoNCg0K

