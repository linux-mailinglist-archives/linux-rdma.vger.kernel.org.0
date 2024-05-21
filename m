Return-Path: <linux-rdma+bounces-2553-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E678CAA85
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2024 11:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E411283281
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2024 09:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D50856B91;
	Tue, 21 May 2024 09:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Y/DBdI4I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2098.outbound.protection.outlook.com [40.107.21.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6B05339E;
	Tue, 21 May 2024 09:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716282793; cv=fail; b=qdGnnnhSY3s+HPdvnxLeGVFxXH3678zBwlocAuauRRik/Ts9hQeXsHi+u15/C4AJZTWwywWCggCfVWBkpho6baCRTWN6zLyXHREoq04TO3zH7LNFqrsq0GmlscrcBEeCiZ4Y6gaph3uU6PigBT40A/Ua6Ans8bn8wOGeEg3Rtos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716282793; c=relaxed/simple;
	bh=Maev7Aqwo5R1fqEwI4QhXJ0g8kJsj62/yFN8O6ApYbs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BPHBuvyJxP4xawi0/1rAS62opjKXKRYDtLtQp44ZI30IDl48jvZ47VmzLtrqzg/CGmbwejeD0239Iw6qlAPyVvdllPHumaI9FrRt4YZDzxcuDfKnwCvxlcVZ2x5LbCJBjJqA0e7p+bZQGEbbbZ5NWEBG6uFT40aQ04sMaMukyiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Y/DBdI4I; arc=fail smtp.client-ip=40.107.21.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0A+4wfQue6eEdllDJTTc2MgDT4tNECgYP6wU6nnjcmyLR3LsdYvlXoKmcKjjOzJfsUdZTmYyTCddN3aBhB/rJQq/H/aLMZ6bUId7hrFld0kRfZZsK2+/AxNFNpwdHbBl7zcZN+ezNkD25DvWwyOi3v3bsVhSroQqSA3ADqLdlLsIpa/o+NPexj2GfY1s3qV0u3ZgyTj3Hc1/vSwS06XCbxvnOqb0w6areCPCceFRcOmumg6k3h+miwwrpV2MufXAw/B2c0S8syeT243XFheAwlqC/nwSahg9GDFCIrxSuu2OIQzK5/1KMiXXYq/KYyiYJ0rA/OTrmhKWbf88/4R4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Maev7Aqwo5R1fqEwI4QhXJ0g8kJsj62/yFN8O6ApYbs=;
 b=XL5TAOpPNEoXUJD0YlA3VFYEVi7+4yNs1e5SR/xky7NrB2JwVQVmz7TIfOQN+I70ipWhjwEXxn4pKxMI1MwSegydyDM0UoneUzudizjCPa/zjKNWLz+Rbe+YRagcPbLksc/h2MZhw7druAs9CLwwkRv0MIZODYOGVegO99HyfE2s/028iVKxaWUrjTusBgUnjTBA4eV7vjHnw4i4vz4Kb0T566BiO4gszVO8m8q8F4sr1AKrFvUB2MQobY2rTcMu96bRSU7eWnci3FPq3QcavjkkAzvb5ZB0gLuULrXoJm8PWMEwB9/IVD0hRcMWRVPDHeiGAm1cdjSGC+APZrEHTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Maev7Aqwo5R1fqEwI4QhXJ0g8kJsj62/yFN8O6ApYbs=;
 b=Y/DBdI4IwHFPih8MFarMe/egWAMkcYs63XZ3oRm6wwYIShKwTYgzOXcVRKranx1dtcmVdmiY2tkc0CumSdEOVoPVsxHh3Z6ylRv2aY+cAHxCbbqpi2ARHb8lbulRehiwYQkdGPoWmL5xxX0XfYca3HxGJJWIRbLRY/x0eG3A2TA=
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com (2603:10a6:102:246::15)
 by GVXPR83MB0709.EURPRD83.prod.outlook.com (2603:10a6:150:21c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.2; Tue, 21 May
 2024 09:13:08 +0000
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3521:3a54:afa1:339e]) by PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3521:3a54:afa1:339e%4]) with mapi id 15.20.7633.001; Tue, 21 May 2024
 09:13:08 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, Long Li <longli@microsoft.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next v2 2/3] RDMA/mana_ib: Implement uapi to create
 and destroy RC QP
Thread-Topic: [PATCH rdma-next v2 2/3] RDMA/mana_ib: Implement uapi to create
 and destroy RC QP
Thread-Index: AQHaq18YqFjdl5g+fEiQSntAVCPhZg==
Date: Tue, 21 May 2024 09:13:07 +0000
Message-ID:
 <PAXPR83MB0559AF231AC39311553DE877B4EA2@PAXPR83MB0559.EURPRD83.prod.outlook.com>
References: <1716280453-24387-1-git-send-email-kotaranov@linux.microsoft.com>
 <1716280453-24387-3-git-send-email-kotaranov@linux.microsoft.com>
 <5e6917de-53e2-467e-aa95-fa52eda9cd2c@linux.dev>
In-Reply-To: <5e6917de-53e2-467e-aa95-fa52eda9cd2c@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ec16b1a9-ddf9-4178-a6ad-5e743abbe055;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-05-21T09:07:09Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0559:EE_|GVXPR83MB0709:EE_
x-ms-office365-filtering-correlation-id: b4a3eb73-d6dc-4485-0417-08dc79763ac6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?NTNEZTdNQTlTVXNic012K2orT2JiK0NEakpSWTVGbmRJQzQ4Sk9QOWxDNktF?=
 =?utf-8?B?U2dGUnNNTGpRcW9FMkRncFlQNzAzcENUMVpTS0tIcEhxT3JWbUVhdWZKeWZo?=
 =?utf-8?B?VmNxb3lXREVkd0JoK2RWTi9aUCtyNnVsOFpEeGphaGFkbWswVHVWazMxWHI0?=
 =?utf-8?B?Vm14bEplY3YrZTRvS0s5YkVsMXFLSGc0WjJpdk85ZnBCTzZITW4wejdMMVVF?=
 =?utf-8?B?ekVyRHNuanhqRjJxMHVVdXZTWGNQV0diOHcxZEJrRmJXZU5tZVltdTFXZ1Bh?=
 =?utf-8?B?Um9ZUnhkaDRxelJtclMvd1VkV1ZBS3RFSThoSXZrSGRMV0phcE1xS0c0anVp?=
 =?utf-8?B?eGFiVlk3cFIvS2UxVVM1aERwTmVCWlZRdFFYNHN2cEZ2aCt3SWJtRDhIOVJI?=
 =?utf-8?B?b0c0RVMyVEUyVlQwZSt1OFg1bXFZQlBNdEV3TnBMU1NXNTgwaWNxcnFldGs3?=
 =?utf-8?B?NTR6bDBaWmZNSm51c3Z4MnA1N2NueW5JSVBLR0VNeW40VC9kdXJ4c1VWbERr?=
 =?utf-8?B?TFl0SFM1NFhSZ095Wk52bkYyMGtaV3lBV0FjYnZnWFJZa3lGVnc2NE00ZU9O?=
 =?utf-8?B?ZXdvSEFGMllHWFQ2M0F4R3BsVHp4UkFUQjM3TE9JMHd2dFdwVGJDVXlIeko4?=
 =?utf-8?B?YWhBdzBwaStNdXdEc3NHeXY4anJJczl6YW5TdzU0TWd1YisxZzVoQ0NxOHY0?=
 =?utf-8?B?Ynl1M1U5bzRvZjVwZlR0RGdzUGRybjVwTXBjdFFOZVZYYXpHWTZFOUJESlp1?=
 =?utf-8?B?Ny9jeWlIaU1wcUIzSm9aRGpGcWIzY21Bd1ZaZDQvbUZ5NWtLdisvVktTb3A5?=
 =?utf-8?B?cE53OUJSRFhHS1QweWlBbmxpaVVQVno1dCtYVmZaejhuL091Vlg3eEhFVGgw?=
 =?utf-8?B?aEkxTWhES2hhdEFqYmQvbGZla1d5ZU5VZ2trbVBSS21BdGlkRWxEdzVZS2Uv?=
 =?utf-8?B?TllQK1VLQlpZK3lCS1NtWjQzWnFYYURVTnhlUDNybVJTOGx3MDR3NWtMQlZF?=
 =?utf-8?B?SjY2SFJMeVZkR0tCUk04NzkvMm1WL2phc3BFaEJmUmFsNTBJa21seTk2Y0xx?=
 =?utf-8?B?b3htSlEyWmN4cGNUMExGQkw3cUwxZitCaVZkdDVKaVdxWUxMQkNkcUtWTXdS?=
 =?utf-8?B?eXowczZnNW16eVA1bGRlL2JBY1M4cmtiRTBwWkQ3ZDFiQ0syWDJ5Tkt4Z2Zp?=
 =?utf-8?B?YjkyQkZNdVY5OVNoaVUyTkxoK3NDeE82NityZ1ZVcWRpeGFWbkxMUWFzV1E4?=
 =?utf-8?B?bHRhMEdIdHRCV3Z5bmNvcU5qYVJ4WkQzbDB4UGE5ZVpCNWM2eGRzUzlvbFNp?=
 =?utf-8?B?SmhYSTdyR004VVpzbDc2L202QlZocjkwNkhqazFMbllqaFNXbStNQTZiek9l?=
 =?utf-8?B?MkRDaERUdWkzK2pRVHhLV2lGNlgrR2ZxbG5ITXRhcnBTSUtzMjkwOThyd2tO?=
 =?utf-8?B?OXQxTmhWTzJMN0tLejV4Q3F1R3JOVXFaaGlHdkUvbUVQbUZPdGx5NjIwbEZj?=
 =?utf-8?B?YnVSQ1FhYmEyRzNiRmc2anR6cy9oNWFpdVFXUXJKdzhDK1czTlBEN0kzOHhj?=
 =?utf-8?B?bEJlWHhmOWxUS0dSNHdMTUdPS0RYYVJHVHNVdko4NHhJQmVkOUtua0NvUllF?=
 =?utf-8?B?MkNUSTZpMU1zOXI0d1VDeGd5clp6TWVaVTNDVVZjWDN3RUc3UnhtZUFVU3Jz?=
 =?utf-8?B?emt4TERObnF1bW9nWnpvWVYyLzViNDRvRENZb3JydmMvMk5rZVc2ZUl6dTFB?=
 =?utf-8?B?YWdIN1hFUDJwZlkrdUQ1SmFML1JNamw4RmtLOFNjVHlpRGVSeW1Sd2daMjVD?=
 =?utf-8?B?b0hQYW02MGNhSGI3ajYxZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0559.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dTU2WHZIcTdENUt2ZStsVkNJY3F0VWNkK0x5MnYvdGJHZlRwZ0tkUzd4S0R0?=
 =?utf-8?B?QnVOVEwrcTQ3SkNCOXZaTDNZcm9WRTd4YWp6NE5CQk81TXA3UnlSSm91K1k1?=
 =?utf-8?B?TTdrZ0NucWc1MnFVbW02UW4vOGF3L2dOYzYybVBRUmlnb1V2MlprQk1qSXVs?=
 =?utf-8?B?RHhaV3R2NlpIRlNqQVhleFVsZFU1N2lBdm1sSmc0cnViNjNLNURNRTg0bmFm?=
 =?utf-8?B?SnV0WWNTOVg1MGxuNG10dXQzRlpOMmQrbWJVbkhNSE5TTGltTjV4ZU0ybndw?=
 =?utf-8?B?QnZ1TEJZYWpQMTNyMXNEZDhnZGt0M0srNjM4MjQ4VU9nVmllcmZRZ21MbHRY?=
 =?utf-8?B?S2Y4S1FXbVU0UlJFZjlUYWtVVllYb3VVRXV6VUZOK1RBZnd0R25sR0Y3UUZj?=
 =?utf-8?B?dXRSSnF6eFo1TFA2YW5RcFpoRFJzeXh1cUhTU1ZkVHRWU2x6QlNnaGVBdHNJ?=
 =?utf-8?B?SmRtcWxpaDV3MFo3TmVwK1Awanh4RWhYTHpvZS9FcTI3dUVST1pzTzBETkRN?=
 =?utf-8?B?MTc1ZzZ5Q05KaXdNSytkYmZHVE12TXBvNWhrblprWWc0U3hJZlpuUlRsK3I3?=
 =?utf-8?B?TmxnVzQ4Y0JqN3U0bTgvRTgweXZmb2FmQ0pCUVpOVUpxVDJVNGtOUis0SXFl?=
 =?utf-8?B?ajVnUFYwNjZzZmZ1NkdNZzNBb1NpVnRYSlZFcHJ6MitlNGI2T21GdmFGc0Zn?=
 =?utf-8?B?ZFZ5ek44UUxDWW1tV3A5SGZSVXdsN3pjMG1mNlcycnZlVzdDQnlFRzF2S1c4?=
 =?utf-8?B?V3dVellIY2JubTYvQmRXZ2tsdjVHMGZrS3FzOCsxVzNZZCtGTS9NdCt4MGky?=
 =?utf-8?B?eEVvcmhWRUhzRFdPNElBaWlaSDdRU2tXTGZPWllSVWsyYWNDNHRRMHkvRG81?=
 =?utf-8?B?MFduZHNJWDJIWWo1RVVXNGowUjUzY1ZMY0pWTDcrWVZuY2M0S0VleGY5bnJC?=
 =?utf-8?B?dkNGU1NsWHVYcExGMU5ML2ltcWtycXdCSGx0c0RwRXN6SmJQN25mZE9EVUF1?=
 =?utf-8?B?akx3c0dzVzlNR0NZRTBRMlZiOGYxQVVXMDRUZ0tUbXlBVHZJUGZDNkF5RWNj?=
 =?utf-8?B?ZVZtTDFKOFNRa0p4UGxCb0NJMjY0b05oNHhNaWhpUk1VZ0dkaXlDTG8vTFF3?=
 =?utf-8?B?M0duV0RkMjcrVDlISlpRWnh5d3QyeEJTdHFEZEFlbFloMmxPOFJpQ3BNMTRK?=
 =?utf-8?B?aC9oTlNwS3piOVp5dUloYTMyRS9LODlmMzRuMjZkbURmRXd1RXgyNDcyQWhZ?=
 =?utf-8?B?T0JlN1VPOTdvQXYzamlkNkNrQzVIbXJXZE96MFBIRy9uOEw5SGQ5U1psSlJ2?=
 =?utf-8?B?ZWF2ajI2UmxaNEdYMTVlVmxVOVZJdkJjOUhZdTVabTh2L1M2NUNRd25YTFBG?=
 =?utf-8?B?dlFmUEx0aGVOamhnYUowRzVXTkpmaWVOVGdnQm9IUFNKNVhXcjNXWE00ald2?=
 =?utf-8?B?Y2FOYk5TQ1lEckxxandVeDNObGlzbXhlSmhreXlGMUpWTWZ1UHpOcUhsOTN0?=
 =?utf-8?B?NGVQdm1PMGpnMlRkbUVkckVGSnNxRUhBQXdlbzc4aDRsOGRTMjdKVy9vc2Rs?=
 =?utf-8?B?dmRQSnNuenp6eGtheTQ5RE8rQ3FZU0gySlFudlR1bTdTYTFTVXV5RVh6SHNZ?=
 =?utf-8?B?aHhlQVlLZHVBaVV3Qm5TMDFJTUh6UnhvS1ZDemdFY0RhTFdHQnBEbW5aaTJ4?=
 =?utf-8?B?L3BFZFl6L20vRWhNaXh1elpTRW9taHhyZ0tadmNmQlQ2ZXpIa3RQZHVrZ3lW?=
 =?utf-8?B?SSsrTlRtdXpWbExPZXk5ME1kVDBwRWZWUUhxOGJNYUFLNVlvcnFnTnY5NXhU?=
 =?utf-8?B?aUo3WGthVzJZVVU0RURkZ1o0MWViQVhHT3UvVHliVXZqdUlCek5LS2VHQjcz?=
 =?utf-8?B?RWpDOW5lSFZMd1dmZkdhWXhBdUlQcU44Y2JjTVJaMGlnZmlrK3VML3k3Vjg0?=
 =?utf-8?B?eE5DRUh1RWhDZmVpYkI5RkJJSk1lckZURURZNWtMeGZxTjN0VTFvRjlVTDFy?=
 =?utf-8?B?NldjM0xPY0JsUkdLa3VtTmpsTXJSREFtV3RyeDdOamRQSStUZkVCRDJHc1FB?=
 =?utf-8?Q?it29E6?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR83MB0559.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a3eb73-d6dc-4485-0417-08dc79763ac6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 09:13:07.8489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ocLNvrTAQHwaMZwYipJ3dR+ooDiT2oxrmpGVCWC2IkmChT/ubTXAiw8I7MVhA5svADfYeBbYxcsVKqr/DROIqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR83MB0709

PiAgICAqKkM5OV9DT01NRU5UUyoqDQo+ICAgICAgQzk5IHN0eWxlIHNpbmdsZSBsaW5lIGNvbW1l
bnRzICgvLykgc2hvdWxkIG5vdCBiZSB1c2VkLg0KPiAgICAgIFByZWZlciB0aGUgYmxvY2sgY29t
bWVudCBzdHlsZSBpbnN0ZWFkLg0KPiBaaHUgWWFuanVuDQoNClRoYW5rcywgSSB3aWxsIHNlbmQg
dGhpcyB0b21vcnJvdyB0aGVuLg0KDQpTdXJwcmlzaW5nbHksIHRoZSBjaGVja3BhdGNoIHdpdGgg
LS1zdHJpY3QgZG9lcyBub3QgY2F0Y2ggdGhhdCBieSBkZWZhdWx0Lg0KSSByZWFkIHRoZSBzY3Jp
cHQgYW5kIGZvdW5kIHRoYXQgdG8gYWRkIHRoYXQgY2hlY2sgb25lIHNob3VsZCB1c2U6DQotLWln
bm9yZSBDOTlfQ09NTUVOVF9UT0xFUkFOQ0UNCg0KS29uc3RhbnRpbg0K

