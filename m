Return-Path: <linux-rdma+bounces-14812-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66022C8FFFA
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Nov 2025 20:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C9F14E2694
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Nov 2025 19:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A28304BA8;
	Thu, 27 Nov 2025 19:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UmBs4cGH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011008.outbound.protection.outlook.com [40.93.194.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40B424886A;
	Thu, 27 Nov 2025 19:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764271103; cv=fail; b=WjRfkbt+Q33lgsSZPo1QgzPttFfPKg/pKKHTnqXKl8TityDNg5eKvC6X4ABZtVUnsDMRUBKOO/iaNL+W1ezgS14JkFOvCmtGKrKlyTRYxc/SIqM01SLOR8cd3Y0PWmsA2cyGiluPJyEcnBZM088YNzlOvtRjZ85UjJCWBNaxVlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764271103; c=relaxed/simple;
	bh=nHS6VABHB5rUlVHhtsJCSYGbob4JMwDURcrzdVBF/VE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dLPyIsGMcG3dsS2W/+TnS+DvD7jf6L12QUMDAo7BbrSINkfj1EZcHdkpWj156oKVfmjFVnWTobvBKnoA7G7eeG7mjAAD8Rd4FGaAZ15tpykXhTi86tRIErxDNF9QaZNLo6hEjZe6PKJI0h/B9a+T27Fe3ER6fAItIx3/GsJC0eQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UmBs4cGH; arc=fail smtp.client-ip=40.93.194.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXR1vOxfPTHnUi6R57a0yOtVcL3y8kQZ5+cWzwu13LwLbHFE3ynjoV1M6ljs5pvIMJ5eg3g2qhMrO4wO/4ju9WvxFPRkBHxun1OkU5TpYjy6aE7w4RXExRO0UAA0P3NUYeSWQNoE463uDML9ak8WHI2xNnakgH1n+RvaRsgeGtW6IODvRaOKU4NYOfByvKBwuE++5RBuJXAE6XFUZn4tjrvGXFacq8HSzVQJgckrSYVsZRvOGvh0dgB3yFZM5F8C0N7KYT+Yr62KFAbBL/JGZW5qsOuDpEchA+4ZCfohty2yG/J+D37lwobKwms4va3CBK8KQr52ZE09cnw+y+oalg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHS6VABHB5rUlVHhtsJCSYGbob4JMwDURcrzdVBF/VE=;
 b=TzkchldP9y6Kpvyv/nP8R/UC+Xo8gkPRAfx0vyDWqKs9Cap8HsfoenzrjC/WLjWPqM7UOvdBVt4CBdnkstj0q2LZo778qNfH+FJOtWX+0M7O2qCaUbQMkaR8jizkcAvxnImUOogeVZmBXAtCbEzpwLwWCnvCPMQV8JWjMCTHy08JRV2yfVZKjyoTKSrsIKsqem/bCv+60KD4KLpipxCDL/EQGn8VQ9NoDPzThBOJUHRTpC8FiRMkRCXfLsHd8LiwrxpBh7c3RzudNpsjmOb3qChY3kvFBdGr7Tj7MnsjBx3LA+PiV5LDQUGzk+pLicHLDpcCZPybimLzmDbI0iN0Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHS6VABHB5rUlVHhtsJCSYGbob4JMwDURcrzdVBF/VE=;
 b=UmBs4cGHNd+z6VVPlbgxZNQeJj0OnjW5ZWg4JKUoTiXIRxGg1UtKpYupjKk9/Sm74AdA14hY5FIPLhh3BMqEGWCUkTD0mJg5IMRmP3zHjzvpmUKS/uxvimIAsIoufGfRiUhEZZhW25vDexyaWNpbUpSG4afeBlETfgii8AVmdAMq9Uao66j0JQ8noCi1SxN2LwEljGAaJc6TU/6/M+OTnTd1sv8oA39t503aB5koH5htwAEMicta14CN2CIlSmriB7ps989eX9X0zpHhg9IyY9ZXf0hL/K41OxgM2JpVzLD1HWaSB1ji3FDwO7VFSYM2/hnMQfTHvduNobPa+ul4tg==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by DM6PR12MB4354.namprd12.prod.outlook.com
 (2603:10b6:5:28f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 19:18:16 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::7b2b:6066:67f8:7db2]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::7b2b:6066:67f8:7db2%7]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 19:18:15 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>, "horms@kernel.org" <horms@kernel.org>
CC: "corbet@lwn.net" <corbet@lwn.net>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "leon@kernel.org"
	<leon@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "pabeni@redhat.com" <pabeni@redhat.com>, Jiri Pirko
	<jiri@nvidia.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Carolina Jubran <cjubran@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "rdunlap@infradead.org"
	<rdunlap@infradead.org>, Saeed Mahameed <saeedm@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [PATCH net-next V4 06/14] devlink: Add parent dev to devlink API
Thread-Topic: [PATCH net-next V4 06/14] devlink: Add parent dev to devlink API
Thread-Index: AQHcXkcn6Ytda4wFr0ylwlUSY56XmrUGqE2AgAAN2oA=
Date: Thu, 27 Nov 2025 19:18:15 +0000
Message-ID: <3ec956ea1d0a1c6e56865b2ded6d83ed773ccd4d.camel@nvidia.com>
References: <1764101173-1312171-1-git-send-email-tariqt@nvidia.com>
	 <1764101173-1312171-7-git-send-email-tariqt@nvidia.com>
	 <20251127152807.GA719673@horms.kernel.org>
In-Reply-To: <20251127152807.GA719673@horms.kernel.org>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|DM6PR12MB4354:EE_
x-ms-office365-filtering-correlation-id: d7d10309-8c42-4b07-f00d-08de2de9b740
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?K2JCOFlhY0hYQ0cxSE51cUVMSGZGQkh0TDZveVloa0l0QXIwVDFtYVN4V20v?=
 =?utf-8?B?bFU5TEt4UmovNnl3cy95b2IxNGpvT0pYc0RKR2hTUTdXRGdjSGk3UXJoYVhn?=
 =?utf-8?B?ZUNLL2hFRFdYaVMyZzQ1NE1qQkpWRUpmcUhsSDVVa2drYkEwZWs1alk0Zkh0?=
 =?utf-8?B?UHdBSmFkTzVBZ3pzU2dJQzl0VC9PeTVxNXN5cXg4S3hhbGR4V2JtcFNGMFJ2?=
 =?utf-8?B?OXZlcWpua1JHZEpFbWVoMW9NUjBkQ1pjRnB2RzJTc0p2M2U3dUZDSlBLd0px?=
 =?utf-8?B?cTl6QkVsSGRNQiszUG43UTZlN0ZBZ054RWJwb1ovc2g4NHROeTNENU5IbHps?=
 =?utf-8?B?cFdKMjUzSzFpQ0J3dFpYRkFoS1FOckFTdlM0dDl2TDJrR0RiV213UTZqaEZU?=
 =?utf-8?B?a0xzTDIvM2Ivd0t3eC9xb3FVbkIxTDlvU0swU1ZaVzdPT0VmL0JMckcxZ1ZT?=
 =?utf-8?B?WTQ2T1lwSVo3ZzJSM1ovcXE0Zk5jMCtLQkMzaGlWNWtrTGJESS91K1grT3hO?=
 =?utf-8?B?UkZzOTdyRm5vS2ZjU2lTMlgzNDIzdGZKamRQWHVvYkZUdFlMLzNnTEt1VURF?=
 =?utf-8?B?OHQ0Tk5SVjZhTnZuc2RZUlZ3cHlPNFFZakpXTW5rWitHRWhVS0hHMFRaMTQ3?=
 =?utf-8?B?K3E4ekd5S3FIZW1kZnBWWmt2Ymx0R1dDU3kwandZaVRranlyU3FQTzgxbU9B?=
 =?utf-8?B?ZjhtREFoMTREdDFCU21LL2QvdGdENXBjeDloczJJak8wM29WQkpsMzNpL0kz?=
 =?utf-8?B?NXpncHVhZGRTYkxPTnVkWEx6TUxSTUVqR2Y2QWlRR3FHUGVvRFFPblQrNjd0?=
 =?utf-8?B?YlFMZHlydDl4WFdtQkZZMDNNT1h2MStsYTlXc1BBanlYVFhDRXBCd2JjR2ZF?=
 =?utf-8?B?aWNmRGhieTVQTE0vU3E5SnZCblNBOWMzMWNnNjdybnYvUklTRmdua0ZCZytS?=
 =?utf-8?B?N2FGbHY5L3NyeldLb2xybTNiaHIvVi8wMXJpbFhLSlhLRWpOdXBseW5EZVND?=
 =?utf-8?B?UVRTRjFYVS9iTlR4c2lwS1IyQ0tEdExsTVZvQjlVb2ZBSWgvVVpTU1RnWER0?=
 =?utf-8?B?K3hmdWJpci9CV2NNZEJBV3lyZVRKMnlFUStvOHBkVGJMWktNN2REMW1vQUZ0?=
 =?utf-8?B?RS9weXlFS1VKajBkODF3Nkc5YlIyb01CL3p5MmpzSDlURmRMR1R1Z0lEZHg4?=
 =?utf-8?B?dTF0bG5Hazdhd2xLWWNtVlB5cEVzeGhaVW5lTUY0aWlKTlRmalV6UTgxYjV6?=
 =?utf-8?B?TlVpWEZ6WnE4eERiQW51T3Z2NlJqa0MzaEFFMXF2Ry9XUG5DOXVXMktFQ09E?=
 =?utf-8?B?NmxKMWx0Q2orN2dPZEplZGEwSUhvejVZbU9kdldhaWNZUURsRXhtY0pDbm9y?=
 =?utf-8?B?T0NVTURIUGRUSmtnUEV1dStXb1NIeUErakdqWEVpalRjaXdydG1QSlJtc2lR?=
 =?utf-8?B?UDlTL3Q1WUdadXZNTUYxbThWdExuSGgydnZ4ZUhzMSswZVNYcy9CazdXWkZC?=
 =?utf-8?B?QnF2UkhrTExDYi94eElnakUyYnZsNTY2cGcrdTl5aXdkK0huT3RuZ3V6THpx?=
 =?utf-8?B?dG1RMzlHZlRDWWdmM3ZnaEhoOVI0R0pOdzNtcDEvV0hpOVBBeEVRTEtLMHl3?=
 =?utf-8?B?WUVBZHZvdXJyZ21PYXJCcDhXOTR6NUNRQjdNeVFtYnloNldMYmoxWTFQakdu?=
 =?utf-8?B?dHpFUmQzcEJYR2tXQk56MTBLaXYrWXY5WlhXS3dCWWlvdG11bW1XTWZJNkpS?=
 =?utf-8?B?VkhTUmlHQW9Vd0FNaGsyUmwxeFlrUk02RmpRMThNeDJTT3doNnBuZUYyL0hX?=
 =?utf-8?B?WmRsYk0zM2tib2cwNEFYRVAzeGNzazgrVS93NlM5UGpEeXBId0p3MDNIT3c1?=
 =?utf-8?B?VnJvbUxjalpFRE1tTi84eDhVUzFtaWMrS1JKZ0c0NkhvQWgyTlkrWjFPdys1?=
 =?utf-8?B?ejhXMThhdlIyY2wzS0xNWTVBL2dRTi9PYzJiVzYrbVVSWHpZNEp2ZTRBeDRF?=
 =?utf-8?B?clRjcFFFNVEyT2g5amIvTTNFQjJBQlc0U1VEOU1reWN1SXJhOWJjSyt2MmY5?=
 =?utf-8?Q?9t7Czs?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QVZSOENIYk5YT1k2YW5McktsWTB0MGhqNE9NeDZ4VXJhb3dZSjc3Zk04WDAw?=
 =?utf-8?B?eFM4M1FZM1YveFhGekRkMjdQTFNyOVB3c0pRZkxENU1RaUZXZzFzbHJGV0dp?=
 =?utf-8?B?KzRIeXZqU2VSSjhEbFpDdUZiNzhsMmNOa3RXRFpXbVZZbnVaME1sbjNrTFhu?=
 =?utf-8?B?bUxNeWM1NFVYSi8xWEFqaHFqb2RJQzBQTVVOaHliTWZxdkpyRXAyQlFsMTZu?=
 =?utf-8?B?b002Y3ZndW1aaStjUE1PZHphOFZpYU5SOHNYL1k1TW5ya1BCb29qamhRTzlq?=
 =?utf-8?B?RWVPZHgzTGlDN0lYcUFxd003WmpkYjZXMDRrczNxTFY1dlZWZjRSczVUWFlK?=
 =?utf-8?B?SmxXK3FKbGN2L1pKQWRBTjNUc3RRdzZNdGJsQjBTeDJMdFhPT096cytVVThj?=
 =?utf-8?B?TXNxVG9xN1dKdmhFRDBwN202bVd2OGxFSlFtNWQzbStvdjlvRkdLTndXWWx3?=
 =?utf-8?B?a1pNcmEwcTlJQkhBNWJWK0FpV1FGM1E1dHpJM0J4SHYvRlRlMWUzNmxwRUdX?=
 =?utf-8?B?eWQ5WFBXUnJNRkFJbGpMOHd3NzlzWGxqUW5reFV6MTU0SmsyWjY0SG1QcDQv?=
 =?utf-8?B?N1g1QzZLM3ZkUHA3OUpBRTJkenkxQ205NlZyMDZ0QTFWRWJHa1BTR00yNkpC?=
 =?utf-8?B?UjZVZEN5RVkzek5MZktLbXhVcXBOMUZ6Y04welpEdzg1YkJxeHZWQnpCQmNw?=
 =?utf-8?B?dlg4TTVKUWJjUkQyelI2alhvdnBiWnllT1d0MzBjSlRVVFA4QUJ5NGhvZkM4?=
 =?utf-8?B?dXFGWmV5aXp3QU5aWU5Cd0RZZDZ4MXU2d3JzcnVKbENCVkF3amlXcFcwZ2ZY?=
 =?utf-8?B?S1RlNjBOMnlVZGhod2VPZFFjL3oxYTBwU05uWWNybUdUYWZUNFE1ZTV3UzNj?=
 =?utf-8?B?QjFsUGVUbGJrQS9qcUxSa2Y0b3JOaTRKYldtRjJSV2diNHkvRjM2LzZWblMy?=
 =?utf-8?B?Wmp3Q1VHYTlMWjhwam1pU3BYMlJWTytTSzhqQnVpZFhDdEswNXc0aDVkZndz?=
 =?utf-8?B?Z2gzNUt6OFFFNDNFTHBRMUIwWGxnL1JoWGJtd2tlcWRxc25SczhRamRNQW1z?=
 =?utf-8?B?VGVLem40Z1pEeTNubElIUkRGRGJoS1RXL0JvOFp4TlJ1N1g3N3RaaExQclh4?=
 =?utf-8?B?RWhOMTFFN0E1NzVZeXFUS2FvVERnOVNzL0tOVVNiZFA2dXJneTVmMGxjOW1G?=
 =?utf-8?B?ZnY5NDhjVTRCcjFsT3Q3ZGY5RFp0bkhMWnpMZ2V1c0VVb2hlUjExcmt3OUZv?=
 =?utf-8?B?aUlaWENTMHdMM0NLS3N2TEpLRDBGd3prQ0dLWFZtQ3dZQjBWZm1nZDN5b2hV?=
 =?utf-8?B?T0tHbGprM2ZLUVIrZzIrS3pNUG1PcmpjWWpXQWxBbXNBK0xxemh1OWpJL1JT?=
 =?utf-8?B?OEliaVh6ekdRV1VwUmNJV3BCL1VQQVBXZGRKb3gvTDlDR1dMVUgzTWozRm9T?=
 =?utf-8?B?RjJacEYxS3RqYlNwR0E2eTVMbFd0amRmYVREKzZ0c2hldk0yWFN2RnUwVlgv?=
 =?utf-8?B?Rm14dEtHcDFVNkllY3RJSVB5aXp3SzhwQ1FnY2ZQZmF2T21wUEJhMzlkbEdi?=
 =?utf-8?B?TEVlNDFDRllGSXFRdHZZdGdSVk1qYTV2K3dIT25OWDdmWmlpQlRzTW1WQUJV?=
 =?utf-8?B?U21rVVZpdHBtMU5oUFZ4ZEdBT2hSMUpST0k0amJYV09aeGhhTWRuKzRRRTZR?=
 =?utf-8?B?UVdEdDZLRmtCU1pQRjJ6b1pjcjZXMytaRE5DZndKRFdWeEVKTGxVc0IyWkRH?=
 =?utf-8?B?RzZiQ0ZtOHdkZll5dHI0Q3VFTXhhSVYreDdiNktKS1FONFd3Vzc5dk5jS2Vy?=
 =?utf-8?B?TkRDVnpqYUczLytjc2pIcHJydFFHQjREcWtaVGtnK2dXdjIybHVyRE85Mnov?=
 =?utf-8?B?M3J6ejdFbTlHYk05N0o4bWdDcFZISTRSNEZmb3QvbElBYnlOSnVWWlNxU0xX?=
 =?utf-8?B?VkdnVmVqVVFHK0UreGdmeVZaTWVIYnZOR2hPc2lNbmlYNEJ2SU1JK24yVFJp?=
 =?utf-8?B?LzhnY1U0OTJqejhKc2h6cGhFSDlLaWZtY2h4UHBsNzBDZWlUSkdsMS9rSE1z?=
 =?utf-8?B?V25XYlExVlozL2ZyM3lCQTc5YTFOUG5PbmQ2bWY5Vmc1TDhxaDgveUIyME9E?=
 =?utf-8?Q?c998QMhXDyyPKDkRS6EQHaDUc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <389903B1F9D1AB46B9BBB7C927A227B0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d10309-8c42-4b07-f00d-08de2de9b740
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2025 19:18:15.7990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: acrUty9Z+IQ3+RPbUe6QwEmYiRou7FXu3Ilcz9A1VpYh9yb8Sp2lOjawommS7pQqVA3kI/9GHkAmjzZqkfWwNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354

T24gVGh1LCAyMDI1LTExLTI3IGF0IDE1OjI4ICswMDAwLCBTaW1vbiBIb3JtYW4gd3JvdGU6DQo+
IE9uIFR1ZSwgTm92IDI1LCAyMDI1IGF0IDEwOjA2OjA1UE0gKzAyMDAsIFRhcmlxIFRvdWthbiB3
cm90ZToNCj4gPiDCoG5ldC9kZXZsaW5rL25ldGxpbmtfZ2VuLmPCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfMKgIDUgKysNCj4gPiDCoG5ldC9kZXZsaW5rL25ldGxpbmtfZ2VuLmjCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDggKysrDQo+IA0KPiBIaSwNCj4gDQo+IEkg
dGhpbmsgdGhhdCB0aGUgdXBkYXRlcyB0byBuZXRsaW5rX2dlbi5bY2hdIGJlbG9uZyBpbg0KPiB0
aGUgZm9sbG93aW5nIHBhdGNoIHJhdGhlciB0aGFuIHRoaXMgb25lLg0KPiANCj4gWW91IGNhbiBv
YnNlcnZlIHRoaXMgdXNpbmcNCj4gDQo+IHRvb2xzL25ldC95bmwveW5sLXJlZ2VuLnNoIC1mICYm
IGdpdCBkaWZmDQoNCkhpLA0KDQpZb3UgYXJlIHJpZ2h0LCBzb21lIG9mIHRoZXNlIGNoYW5nZXMg
YmVsb25nIHRvIHRoZSBuZXh0IHBhdGNoLiBXZSB3aWxsDQpmaXggaW4gdGhlIG5leHQgc3VibWlz
c2lvbi4NCkJ1dCBydW5uaW5nIHlubC1yZWdlbi5zaCByZXN1bHRzIGluIHVuYnVpbGRhYmxlIGNv
ZGUsIGR1ZSB0byBtaXNzaW5nDQpkZXZsaW5rX2RsX3BhcmVudF9kZXZfbmxfcG9saWN5LiBJdCBz
ZWVtcyBpdCBpcyBub3QgYWRkZWQgdW5sZXNzIHRoZQ0KYXR0cmlidXRlIGlzIHJlZmVyZW5jZWQg
aW4gYXQgbGVhc3Qgb25lIGF0dHJpYnV0ZSBzZXQuDQpBZGRpdGlvbmFsbHksIHRoZSBkZXZsaW5r
X25sX3ByZV9kb2l0X3BhcmVudF9kZXZfb3B0aW9uYWwgbmVlZHMgdG8gYmUNCm1hbnVhbGx5IGFk
ZGVkIHRvIG5ldGxpbmstZ2VuLntoLGN9LCBhcyBpdCBpcyBub3QgYXV0b21hdGljYWxseQ0KZ2Vu
ZXJhdGVkLg0KDQpDb3NtaW4uDQo=

