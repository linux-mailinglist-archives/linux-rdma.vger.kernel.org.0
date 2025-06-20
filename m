Return-Path: <linux-rdma+bounces-11507-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B32D8AE25FB
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Jun 2025 01:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C8FE5A35DC
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Jun 2025 23:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542F023ED58;
	Fri, 20 Jun 2025 23:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TmkIkxdY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U3vWfiLd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A6723956A;
	Fri, 20 Jun 2025 23:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750461396; cv=fail; b=J4SbmYGgELaNp613Wb+H4QJSq/VSipzE9avEYXDf6MQg5t325JsKAEaNVVHp3efcm64DXsy+jv4qkeeTBvZTC1Qs/0xL9mUOkpIZ5U/eTyWIz0OHPXMnzwU1L1b/rWgEDSvBIL3ZozjOk5mHmv10hYEzJ0lKOlmYa5Rfnn0kiRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750461396; c=relaxed/simple;
	bh=8crLWpCoVxCcmseb3GK6hxhBuO08aUz3mooLfaiqqyQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qe0SeN+LmsjSHCmVs4LAUE9QB3OLBEI7MHKlT2JF4p70VN09VDc/RkOgiNuZyKmVpS//9p2rTWcMkO9uZbar1VyRdPN8dkV5XwASJ33hsRrL3ubLRshspc+RcbkytcuHSrSaGT3BHEYcKU8uPsKQxySvfvXfM5pIt0PhHxIeZsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TmkIkxdY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U3vWfiLd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55KEBvsT019977;
	Fri, 20 Jun 2025 23:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=8crLWpCoVxCcmseb3GK6hxhBuO08aUz3mooLfaiqqyQ=; b=
	TmkIkxdYC8H4c75drMcdY+sKNVNFqVBOH44+r1P0smH8CNboTlEwyzIBsyX9JzZj
	+bZrNnn5o1AzGHKiJcJCARHwz8Dyix0lPSWbc6Hfbmyj8BLHCzIXokEdjs6uawAg
	H810WehubyI3vUfUHDYBBnUpRDrBxAwTWB4XQDe8YrpaHk5u6K8OSxJjCpf77A5x
	bu8bQi/ll+75wIE5zd2ZB/iBSozJAtuCQCYRTe8AXVXOuXOTqVJHuPLXquHH8P3x
	oEW7f9ZYYv3eWwETchG991KVXzhagpAWAIXqdyY0nhyKS3wRvALbjib9aT+dkUxc
	LMsgJYAR638vYk6iss6baQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 479hvnby78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Jun 2025 23:16:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55KLj7x8038233;
	Fri, 20 Jun 2025 23:16:26 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012021.outbound.protection.outlook.com [40.93.195.21])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yhddppm-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Jun 2025 23:16:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KTyc/QsG0+B/rKALoEqAlv0MRWmiuj1HL1WzsBTZgRUthuboJ7OssNyqYgIAlzIy/II6h1GfSxvhwpqnPRW4PNX+JlaMoFyMxXTDEs0BQ3M65nw1AnnCusRlRJ5Aj4GaCEd6PSh/66j7wY1lJRkyVNjiz241PU9weYkrWKdlrNpQxbM+NNNgztJx4mAoeq9HsQV1ftlPkfizc4oRsw4diCRNERc7Yj5ZPaO8RfuPsq5zgOc+QPIq0vSDvAntjTKOYtccRiwW6Sjz0h4JIELKgkzWfgXDGuax+jAbzPHtmLraS1q4wGcs8eXjqGBYmWuaLlWYlqdJDPW7C5rIEeqgdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8crLWpCoVxCcmseb3GK6hxhBuO08aUz3mooLfaiqqyQ=;
 b=TyYFoYA0Yjea8gOB2G+b/LjjaMXdPXG4WiPpUFK0GVWOe3nPI2xGVEgtQBlYJkwUka5aO6WugpQtFDIle8GJVPrNAEGi0yfp3JGo4SXTAFl87zpjUpPiOZxufsqQ2f665Iij1Ol8w+bSn7DnjhzyhazPSQ0GMn/Y++8VG1oIzS/5IMylBN0HWfLl7Q6QKCOycEazAptw7rHw9QUcNNzjIRyL+YH3ib9/eXuN55WZ93pWbGGfbaYMAz/RQvN4ZThjv5onoxCsJqRp1rUv8LeYK1GIzkVTkf+nKSgyMcr1b5nTXYKSL90LsLN20/h7iHYbiSm7Ym5O2czpIDyFJZfeoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8crLWpCoVxCcmseb3GK6hxhBuO08aUz3mooLfaiqqyQ=;
 b=U3vWfiLdoMtpdInJosGAj43VbGpn0OWpaaOkzQZ3UhJMgR2xvgnbHaY/njuPbuMqxPmlsAM2RnBLX+MJLOwC8zRK+AkTQozboL4/ePPRceif0tTLzj1TgOR8kXqsPnXZPQP5I8pIegHlq0brOz3Ai0YS/XX+8nsMOIvRirPUuYY=
Received: from DM4PR10MB7404.namprd10.prod.outlook.com (2603:10b6:8:180::7) by
 PH7PR10MB7035.namprd10.prod.outlook.com (2603:10b6:510:275::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.35; Fri, 20 Jun
 2025 23:16:23 +0000
Received: from DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::2485:7d35:b52d:33df]) by DM4PR10MB7404.namprd10.prod.outlook.com
 ([fe80::2485:7d35:b52d:33df%5]) with mapi id 15.20.8857.022; Fri, 20 Jun 2025
 23:16:23 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "horms@kernel.org" <horms@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] rds: Correct spelling
Thread-Topic: [PATCH net-next 2/2] rds: Correct spelling
Thread-Index: AQHb4SJJyLrWLCNdtkaq0oLw4sNjubQMsGcA
Date: Fri, 20 Jun 2025 23:16:23 +0000
Message-ID: <1297f09ac58c5ddcd3878cdb837833a2f6b9d604.camel@oracle.com>
References: <20250619-rds-minor-v1-0-86d2ee3a98b9@kernel.org>
	 <20250619-rds-minor-v1-2-86d2ee3a98b9@kernel.org>
In-Reply-To: <20250619-rds-minor-v1-2-86d2ee3a98b9@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
autocrypt: addr=allison.henderson@oracle.com; prefer-encrypt=mutual;
 keydata=mQGNBGMrSUYBDADDX1fFY5pimVrKxscCUjLNV6CzjMQ/LS7sN2gzkSBgYKblSsCpzcbO/
 qa0m77Dkf7CRSYJcJHm+euPWh7a9M/XLHe8JDksGkfOfvGAc5kkQJP+JHUlblt4hYSnNmiBgBOO3l
 O6vwjWfv99bw8t9BkK1H7WwedHr0zI0B1kFoKZCqZ/xs+ZLPFTss9xSCUGPJ6Io6Yrv1b7xxwZAw0
 bw9AA1JMt6NS2mudWRAE4ycGHEsQ3orKie+CGUWNv5b9cJVYAsuo5rlgoOU1eHYzU+h1k7GsX3Xv8
 HgLNKfDj7FCIwymKeir6vBQ9/Mkm2PNmaLX/JKe5vwqoMRCh+rbbIqAs8QHzQPsuAvBVvVUaUn2XD
 /d42XjNEDRFPCqgVE9VTh2p1Ge9ovQFc/zpytAoif9Y3QGtErhdjzwGhmZqbAXu1EHc9hzrHhUF8D
 I5Y4v3i5pKjV0hvpUe0OzIvHcLzLOROjCHMA89z95q1hcxJ7LnBd8wbhwN39r114P4PQiixAUAEQE
 AAbQwQWxsaXNvbiBIZW5kZXJzb24gPGFsbGlzb24uaGVuZGVyc29uQG9yYWNsZS5jb20+iQHOBBMB
 CgA4AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEElfnzzkkP0cwschd6yD6kYDBH6bMFAme1o
 KoACgkQyD6kYDBH6bO6PQv/S0JX125/DVO+mI3GXj00Bsbb5XD+tPUwo7qtMfSg5X80mG6GKao9hL
 ZP22dNlYdQJidNRoVew3pYLKLFcsm1qbiLHBbNVSynGaJuLDbC5sqfsGDmSBrLznefRW+XcKfyvCC
 sG2/fomT4Dnc+8n2XkDYN40ptOTy5/HyVHZzC9aocoXKVGegPwhnz70la3oZfzCKR3tY2Pt368xyx
 jbUOCHx41RHNGBKDyqmzcOKKxK2y8S69k1X+Cx/z+647qaTgEZjGCNvVfQj+DpIef/w6x+y3DoACY
 CfI3lEyFKX6yOy/enjqRXnqz7IXXjVJrLlDvIAApEm0yT25dTIjOegvr0H6y3wJqz10jbjmIKkHRX
 oltd2lIXs2VL419qFAgYIItuBFQ3XpKKMvnO45Nbey1zXF8upDw0s9r9rNDykG7Am2LDUi7CQtKeq
 p9Hjoueq8wWOsPDIzZ5LeRanH/UNYEzYt+MilFukg9btNGoxDCo9rwipAHMx6VGgNER6bVDER
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR10MB7404:EE_|PH7PR10MB7035:EE_
x-ms-office365-filtering-correlation-id: ee42056a-fb1c-4bb8-f715-08ddb050792f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NU0rVGZWSmlnM0VBaTRhUzZZWks2dXBGUVROZFV0OUpsTEVDZ211b3EvK1lG?=
 =?utf-8?B?U0xiWktWVzhCcmxUb016SDA3MHRWcVNqZUhQZU5JVDdSOGtGQk1BYWhyZ1hV?=
 =?utf-8?B?eVlvS2lkNE8xVURMOU5nT25LSElrQUJ6blBjMVhtS3dEcEhQaGhKK292M2JD?=
 =?utf-8?B?YVJ0S2tuTmNMcUNuUENoWEZrS1RBWUJRMFUwU1N3VXVNU3g4V0dXbGtFVS9V?=
 =?utf-8?B?VitEOFUxSC9nTm9xQWYrbmdCU2MwOVNGZ2JZYmJ3NWVKWEY5aDJqU0ZvNUxi?=
 =?utf-8?B?M1ErcjJGMFZSUzNMYmYxN3FsVXZSWVV6bWJud09ZTG9wMFd3eWlqZk5ma1Bp?=
 =?utf-8?B?cE5aNkxzWXhFb1FuNVV6LzYrMGJqVXNPTXF6UFZMWWpXc1ZxcE5nVGw5TVdY?=
 =?utf-8?B?T1lIODhzSFVRdDhVUkFNSUtBY3dKRkxjbk9JcHFXSkphV0tvY1QxLy9RYVBa?=
 =?utf-8?B?aENQQUZKTmFxOGNVNE5wRytQYnMzMUY4bGRPZzlyZjhIRzhKOU5SVURlN29w?=
 =?utf-8?B?b0tpV09GaUVaSHRXV0JYaG9GQ2lTT1V0K2FUSWVkOE1oMDBKUHVZMmo0RmdV?=
 =?utf-8?B?bS9CVE05U3RCUHZrcmFEeEFCNTlpcFEwaUdNVDNnWFJsYmQrWC9TaUdYU3J6?=
 =?utf-8?B?dGtNZTgvOXdHL1pRclBpb0dCMDFiNGJYM0pyTkhTM1BGWDlWT05UWW5xOWlW?=
 =?utf-8?B?eFh2Q0RHRXd6VjkvUU1WZkcya2d1WXBObnBVSVBvZ2pTZkJ0U3ZSZ3VheUJq?=
 =?utf-8?B?SHN6WE95a1lNWW50ZEdlVG9jNFU1MlRoejJ2N3FnbjhHYmVBYkR4VjBiT3l3?=
 =?utf-8?B?S01vMGYvSTNDOUVJd1l5eTAvNExseU9vYTQyVkE1UlhVUXBLaCs4cU5JMlpv?=
 =?utf-8?B?RlVuM2laTlEzbmM3Q1Y5ZU1KS0hJaGk2eVBQRWZRY0Z3NmRkK3UvOEtDemF0?=
 =?utf-8?B?ZGJNcXprSlZWaXBGbk9tWFRUZ2RUa1Zjam5GUUtZbXRuNzhGSFpwczNHQ0Nr?=
 =?utf-8?B?OXdkU1NRTVZXUE53WEZ6NFFCS2k2dVh6ckNaUUtsbkt5MVdpRmllUUhjWUMy?=
 =?utf-8?B?MzZkRFRWc1EzaUZWeHVyajNobk9SbkhETEFncm9BN2pzSFROV0czbjBicGpu?=
 =?utf-8?B?ZVZZTmpqcFJPWnJ6Y0hJWGkyY3JZWmxrVHFxMjIvSlBTdkgzVzhUOGpHMmc5?=
 =?utf-8?B?d1FVUTVNT3pNQWRsaTAxcHhIUTZxQVcyWVNkVm41cTBEMFowM05BK3dFSnJn?=
 =?utf-8?B?ZXp3Skw4TFh0NjIrN294NHQzWVRWdnFXWGlXZWdUbWFpSGFSM3hKaWNZNm5a?=
 =?utf-8?B?ZGpSbEdycWdBdzRYS0FqNHo2Wm5oMXFwK1pKRlZ1VmFiY2NIRGtIUFBrdjIx?=
 =?utf-8?B?L2oxRXJ4TG8rQWdhSElXMVBHd0NLRHZnTThsakhCTUUxcHRnTUwxbUI5c21z?=
 =?utf-8?B?YythRTdzSldsaUxXMGtSd0pwTmhOV3VIaW1CdVJBcFY0V2lCRS9DU1ovVW1a?=
 =?utf-8?B?Z25Oc21hcVZLcnMyREpiaWt6K0IwWnpkZHJpdUZHaVFKTjhqUmlhWFFRejc5?=
 =?utf-8?B?RE1VSGhGNjd5VERYbExodTU0Tld5YldGeng3WDNZVGVYb2NTMyt4ZWJnSnFv?=
 =?utf-8?B?RjU3RHczWUtSOWFVS3lUZG1IQ2piOGRPRHRsbzR2RisvNTNIUUtSeGNiWHd5?=
 =?utf-8?B?bVlTUGpiUEJUY1RyTngwQmcyOVZZKzdHWmo3aElCdnJHc0VPZmhyMENOTWNQ?=
 =?utf-8?B?UU1JRkltcEN3K1hnR1JGdWkxU0N5U3lhTGpyT1hVa1ZieUhGRFlUL09IUWh5?=
 =?utf-8?B?eCtHZmE3cEVFYWlwVVdTa1RxU2xldDZiNnhxZnNhNUliTWQ4QUtHNWZweDg1?=
 =?utf-8?B?YW43N2hhdzlYZ2lVck5UWGFnZFFGZGxCUit0OTlEN2Y5QnV5blVNcExBSzRk?=
 =?utf-8?B?MEhocE5JdmttT3Q2VjBhZDBDWC9EZmFZTWRQNWZQcTNadThORGNqdDBiWHEx?=
 =?utf-8?Q?9IaxJ+9ZGbGaAdQwSmcFH/QGhpcMdw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7404.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z0ZnaE8xdUg2R09LMnhSK0dYK0lISElhMWVTMEIweTVOd3lWZUMzS1h0ZHk2?=
 =?utf-8?B?WW4vZXhmZTA1REg4VUZaQ2pFMXZYd0pxY0VqcUhUOVJvRlorb3Q0OHNGcVly?=
 =?utf-8?B?S212QU9LWnVScUNlc1N3WmQrbVhVZjlKdlUySGJHMWNjMW94WHZGN1Qvb2Q2?=
 =?utf-8?B?ZkdPK0FhTWsrSE1DRk45bEU1SmdlcDlwQ1J0MndiR2RrMDlYSVM1bDNFRWNv?=
 =?utf-8?B?Vk01dGtpT0w3RTNxRTV1a2NxdWIzN3ViOHg3VkRRcDc5UzFxdFhZZDQzekNu?=
 =?utf-8?B?R3dwSEE3YzVLaWYxN29TODdnUWhsTVkwZWwwYTBHZklLNXlndFZQMmc3cmcz?=
 =?utf-8?B?eS9lempabG5XUGhlcHVWRXNXODl6TktqdFkrSW8ySFpCeUtSZUxGRFRzTk9G?=
 =?utf-8?B?U0t5d2NrbEFZRFI2Qkh5cURqSlFERlBPcjNQeWdlYUcwKzBUa2pJT1RCTGcx?=
 =?utf-8?B?TjZhTlVmRWJNcno2QTRROERXTWw1SGk5K3NHSGROMVM1c0pzMTNJaWQvM0ly?=
 =?utf-8?B?b2xTQ3dMQ3NrT1hYczNNUWRxbXIyMUREeEFhQzdjOERuS2tJUUxITEpmL2pp?=
 =?utf-8?B?dGxVaEIyM3VkY2lodkJiZElnNExqMHF3aUFyb1k4TzRabXJyQWVUbnZYSzhO?=
 =?utf-8?B?cTBlQ2NaUGFoYzdiNWxEbWdpMGNia0dvdm96K01JRnZBR3dST2tBZ1N5azdJ?=
 =?utf-8?B?SU50WEtDaDlHU1FMYWU0YWRLdi9EenBGajUvZVNmOWd3VGdYd3NhRlVNaGVW?=
 =?utf-8?B?eStJY2dRQmtwdnkrbGVlQ2x2SHV5dDVneWJ4dHhKc2M2LysrMkY4cllQTFhS?=
 =?utf-8?B?dytIUFJTNllRRHNmUFBKb3lZUW1MODVDUkp1eEV4cHExazQxc3EzU3JDd0R3?=
 =?utf-8?B?cnM4OGxZbzRFcVJMYWNNUEhSRUpaek53eGtITnF0eHN6WjZwWjFIQUlQR25Y?=
 =?utf-8?B?WFRRS3RjSmlaZFh3Nk9sODB5RUtHSHZVRmVQODdBSENmQS9nTmw3K0trdWta?=
 =?utf-8?B?SWVURVlXS0piS2d5NUpYSmNtL1lSZVFLc0o5UGFRdUcrd20yTk1pOEVpejJa?=
 =?utf-8?B?RWYwR1A0WmFGaUt0bStQZFBBanFuR1BrNUwzcTNidkF0VURaM1dJRktpaXBF?=
 =?utf-8?B?VkpIcEVXM1R0dm1TZ3lnc3FJNjZuRk54MnZ4NlB4ZlhWT3NuMFdza2JpcEwz?=
 =?utf-8?B?OGdnYW12STd0Y1dXeFJiTy9EQ0E0R0NwQTJITy9KcjFoUGlSelJvMjlWMk83?=
 =?utf-8?B?eDAxc3NvWTFWVUNsYWdoMEdCMndGU3g3VWRJS1BnSEZoRXB6S0pwTkhWWlYy?=
 =?utf-8?B?Rm5MejhYZGg1OEMvdUs3bXFoZ3ZOZFdnYnZCKzZPaVVJN21KdHZLRHpIdFB5?=
 =?utf-8?B?Nzc0V3QwR1dHTjV1c2kyZHFXYWY3MDQyN2F1S2NtMjc0QXlwWjVpTFByNDFV?=
 =?utf-8?B?SHFjNmYyZWZjSVRCb1dXUVB0ekxQSWYzNmJMVVFqVHYzajREYjd5ZTg3dHFM?=
 =?utf-8?B?STlSV1IyYUdnVU5VUUJBS2MzdDgxYkZhQkFWZFpqaDhLZlFSZW0rSENtMHZv?=
 =?utf-8?B?OWVidXhrTTlsOStqZnpPbTllU2RrUkVlaEtRVnZnQXdvWUhYYW9nZ2YrYnZE?=
 =?utf-8?B?NGczd0VZOHRiZXpWSTcrNkF1YWFLNmZkczlyTkppaVRyRVp2VnBDeG90NytJ?=
 =?utf-8?B?aEZBSkpOM3FLclBIOGIxMlRETTI4aUtGcEEwVnBkaEUyTy9NMTM3anY1ODFC?=
 =?utf-8?B?aVRDNXRaMmJTbHUyMzNoSldtNEJLclBSVXdNbys4K3NIMmRKVGRHRlhXeGJ2?=
 =?utf-8?B?U1NpTThCb1hwd2FybEhoNmFIZUE5b0pjS21ETDlRdFhINVduL0N2ZlZOS01K?=
 =?utf-8?B?TXVHQ2VZOGlRRVNDK1k4RFh4WURBMkRMallSTExiOVRQcDdJd0FwditRcVBi?=
 =?utf-8?B?bEUvdmliMFh4NVNhc1RIVDhtZDJOSWN4NXJOR0c2M3JZNEZSbnB2OS9qanlt?=
 =?utf-8?B?UUhMNDFoaVU1aE1yclZCSTk1RHM2dERzUFJ1alZWeDlWZDNoaVBYNWp2S2Ji?=
 =?utf-8?B?N0tqTFlQcndITGpuMHl6ZHIwck92M1prQS9JWTljTnlNd0RPR3RNbEg3Z002?=
 =?utf-8?B?NVp6S1VJVVYxRUdQUzdPNXdERWdHQ1pNcnBIVXIwZjQ0cW9Od0ZuNGZEMkkw?=
 =?utf-8?B?dnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A83AE0770D63704FAF62E7B2950AF67B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iEJKVOzmvJhvQwpgHnzaX+MzDNrFl9kTuB639WVkQQqPYDbDW193X72H2Jdvz473Ct4tv3vgK4TZsgjIy6p+nsG19Ftf7OtHJt2Dug0MMkY3Vhs0ylueGmAGmcR7QYj1vJy0aRZ+zLC8/yuL7kC/BIOZJ0iEI5b/WubnyBhNC3dx3RxBWXxSFnDD3Ox5CE+CLTg4AXmmgCkpJVHapy1ntEvbTTXMoEi+zMwBansLRFRvV6+uy7q0kM5NCaV4xjKkMFzhDp71HIfMFaIqpSX3J71IvKmIcDxZHwSguyRmv75yh7EL15HOETlhn/+MX9wG1T9bNMPNEvM4wNUFFqVzAk5OMcR6HCMc/HzSb/k0JZ+jxJY18J7/6upKlgo4Y5hhxiswxeuUjUPq68BXyr1wrFIlQ1bQjygFdk/m6D+Vf4Ii1Bd0fa+IE4QPSwWan9N/gqq7Lhv+sLMvNP9mwIXHT9n9Q60TzkuY7zMfOURaAzqY3RXwlJ6dgtZ0dxjB4ZDUJVQerGpp6fdat9TqkOG2rN5KWxoscbsFWrGD8ybIOZz6UdUg5/bBywDHgXaLh2yPyfoz3dMshXrI36vcDWkmj6X0d2LURGXMW/q8b72O3IA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7404.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee42056a-fb1c-4bb8-f715-08ddb050792f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 23:16:23.3206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rJ5ieiVyir3MVILNfuOhNUBQccYJoogA3/bzFpP5gUqsaZ57tQ3d8I5ZaUlIBqNFR7LdUBOT54t7lkh/HlK9hlWxLPuhRuDWPpydbEfLWyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7035
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_08,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506200159
X-Authority-Analysis: v=2.4 cv=XeSJzJ55 c=1 sm=1 tr=0 ts=6855ebca b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=Pfb9ePgfd0iL-9figNUA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206
X-Proofpoint-ORIG-GUID: uaqT2KxZ7KnlfaOk-U3bi_xXQpAZVFt6
X-Proofpoint-GUID: uaqT2KxZ7KnlfaOk-U3bi_xXQpAZVFt6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDE2MCBTYWx0ZWRfX/LewuTlYT51l alzrNpUGYV3bpBUKX6Cw47nzy2I1kSAXq+awK5YCoRJpc7pu5XCGuKJLa9k0t+B/nit2EvhkQI8 M4m6IrXiButD2fvV8q9mmu+bui3qeNaKkEm/KlAFwiHjH8mGFwYa6gWvR05gMkE1H8AeCuA9TLG
 pKECztZ0okERUBVilPuGAet9386Ew0+fB5PXzxLxpN4RhqBBy/gpfxpzFueNa9G9pW2D0hDy7ts uBn3kehPn60E/Kma77y0S0qzOhbcIaiLE03waOv+1LsocZa3sVv0XfQ4fg6aUPwDkd/sNezjytX 0TsiEZXypfcWz6l4/f4mL24nBP2uQwt1cUi7il1Ra7Av1YJn/Ru7hLnSZO3zv1yMT5boSb8zN9Q
 Fcn1GzQ7ni8cKl5vG1AgX1WcD0atR6QQEu60/72tdc6du7LNZy1+sW3bofhUjvNIlapRTUIp

T24gVGh1LCAyMDI1LTA2LTE5IGF0IDE0OjU4ICswMTAwLCBTaW1vbiBIb3JtYW4gd3JvdGU6DQo+
IENvcnJlY3Qgc3BlbGxpbmcgYXMgZmxhZ2dlZCBieSBjb2Rlc3BlbGwuDQo+IFdpdGggdGhlc2Ug
Y2hhbmdlcyBpbiBwbGFjZSBjb2Rlc3BlbGwgb25seSBmbGFncyBmYWxzZSBwb3NpdGl2ZXMNCj4g
aW4gbmV0L3Jkcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2Vy
bmVsLm9yZz4NCg0KVGhpcyBsb29rcyBvayB0byBtZS4gIFRoYW5rcyBmb3IgdGhlIGNsZWFudXAh
DQpSZXZpZXdlZC1ieTogQWxsaXNvbiBIZW5kZXJzb24gPGFsbGlzb24uaGVuZGVyc29uQG9yYWNs
ZS5jb20+DQoNCj4gLS0tDQo+ICBuZXQvcmRzL2FmX3Jkcy5jIHwgMiArLQ0KPiAgbmV0L3Jkcy9z
ZW5kLmMgICB8IDIgKy0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL25ldC9yZHMvYWZfcmRzLmMgYi9uZXQvcmRz
L2FmX3Jkcy5jDQo+IGluZGV4IDg0MzVhMjA5NjhlZi4uMDg2YTEzMTcwZTA5IDEwMDY0NA0KPiAt
LS0gYS9uZXQvcmRzL2FmX3Jkcy5jDQo+ICsrKyBiL25ldC9yZHMvYWZfcmRzLmMNCj4gQEAgLTU5
OCw3ICs1OTgsNyBAQCBzdGF0aWMgaW50IHJkc19jb25uZWN0KHN0cnVjdCBzb2NrZXQgKnNvY2ss
IHN0cnVjdCBzb2NrYWRkciAqdWFkZHIsDQo+ICAJCX0NCj4gIA0KPiAgCQlpZiAoYWRkcl90eXBl
ICYgSVBWNl9BRERSX0xJTktMT0NBTCkgew0KPiAtCQkJLyogSWYgc29ja2V0IGlzIGFybGVhZHkg
Ym91bmQgdG8gYSBsaW5rIGxvY2FsIGFkZHJlc3MsDQo+ICsJCQkvKiBJZiBzb2NrZXQgaXMgYWxy
ZWFkeSBib3VuZCB0byBhIGxpbmsgbG9jYWwgYWRkcmVzcywNCj4gIAkJCSAqIHRoZSBwZWVyIGFk
ZHJlc3MgbXVzdCBiZSBvbiB0aGUgc2FtZSBsaW5rLg0KPiAgCQkJICovDQo+ICAJCQlpZiAoc2lu
Ni0+c2luNl9zY29wZV9pZCA9PSAwIHx8DQo+IGRpZmYgLS1naXQgYS9uZXQvcmRzL3NlbmQuYyBi
L25ldC9yZHMvc2VuZC5jDQo+IGluZGV4IDA5YTI4MDExMDY1NC4uNDJkOTkxYmM4NTQzIDEwMDY0
NA0KPiAtLS0gYS9uZXQvcmRzL3NlbmQuYw0KPiArKysgYi9uZXQvcmRzL3NlbmQuYw0KPiBAQCAt
MjMyLDcgKzIzMiw3IEBAIGludCByZHNfc2VuZF94bWl0KHN0cnVjdCByZHNfY29ubl9wYXRoICpj
cCkNCj4gIAkJICogSWYgbm90IGFscmVhZHkgd29ya2luZyBvbiBvbmUsIGdyYWIgdGhlIG5leHQg
bWVzc2FnZS4NCj4gIAkJICoNCj4gIAkJICogY3BfeG1pdF9ybSBob2xkcyBhIHJlZiB3aGlsZSB3
ZSdyZSBzZW5kaW5nIHRoaXMgbWVzc2FnZSBkb3duDQo+IC0JCSAqIHRoZSBjb25uY3Rpb24uICBX
ZSBjYW4gdXNlIHRoaXMgcmVmIHdoaWxlIGhvbGRpbmcgdGhlDQo+ICsJCSAqIHRoZSBjb25uZWN0
aW9uLiAgV2UgY2FuIHVzZSB0aGlzIHJlZiB3aGlsZSBob2xkaW5nIHRoZQ0KPiAgCQkgKiBzZW5k
X3NlbS4uIHJkc19zZW5kX3Jlc2V0KCkgaXMgc2VyaWFsaXplZCB3aXRoIGl0Lg0KPiAgCQkgKi8N
Cj4gIAkJaWYgKCFybSkgew0KPiANCg0K

