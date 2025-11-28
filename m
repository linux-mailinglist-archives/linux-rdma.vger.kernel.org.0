Return-Path: <linux-rdma+bounces-14817-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F656C918AB
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Nov 2025 10:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BED43A7FCA
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Nov 2025 09:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAA8307AC7;
	Fri, 28 Nov 2025 09:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QRNDLUYV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012025.outbound.protection.outlook.com [40.93.195.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD1A1F9F47;
	Fri, 28 Nov 2025 09:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764323833; cv=fail; b=tQpJ2QWYEDEPmSffRhNEeU0ldxz6OssoxPulqsyuMrmXjyBDWzZxo2oJcwkE8MJ1T5PncE33T4AXBmVwwQ36OmMprDfa+Cl/DvD3ne1zNA7uH6oaGDaOFwd+12iwSSgEjermaPvrridGXj/FjKmB6fKMagw8QPfILbryum75rlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764323833; c=relaxed/simple;
	bh=3ZCPNokXB0xoqGmjI05CwR8SFSKhqegBoYG5Rc9GCuw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B5Z4g7znmioqEZMMD7YerSG4wHQua+Het9BcmeDcf0sYhPl7Z+o2MdpsAmVumn30rpP7N454/tufEcu+5OJuiSO4X91nPL21LJq3QVcq9U5PGwwcMZ9l7eVzjJf6/iQuwaJKZ0wBlRquYk/pjgkb4EioBgbigAg+N153v5K5stA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QRNDLUYV; arc=fail smtp.client-ip=40.93.195.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ed2roLlVIf4T5zvROAj9XIrJqtmyFpCGjRV+8ncwB6pHQAy9Y1Jlac5Mx97kadJMHHMosCOOISgSTHupLp0UPNbk9mMVCavqQlNsusdpBbsBUDy/liRB80bovQF+nF19fEooyv6kNfKXCAboHmyKVUCCuUjcMULPJEDps7Atw5VBVgGfpsRVuT3CxxZ/Wn/Qifz2b8oKMesim2A4U4YtFJ2LwkQSpBvT0z8eqgc0h1hfsldy3CqHYTYj3aNb4WMGDZIRbuFVUeeQc3L6WSFlwFQnKNw+bcGSILBafUnXRK5H1JYDN8Yr4XGCaCBlOKvZE2Li8Kr7ZWZ9Q3EtqTuP0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ZCPNokXB0xoqGmjI05CwR8SFSKhqegBoYG5Rc9GCuw=;
 b=cHamJNp7tKLHgz0R7c6eY5RDOffNE7J/loC47sREvSgklk8Xzix/mw10of1hSrgeAtA7pB2KearGHx36c521ooOVw+zUKnnZVcm3B5GBBFph/vNXhkw60go/LwHN3vyTt4nE63jynnPjgRDNdXtIianf4mmay5E8fQDZwqGoARtLuk17YcPubezW+U7cXRmOvLE81ELkq17/6qd/7FnGta8h+kVyN6/rvqx8STnl6Uq1u4OlbmfkezTkhQD3Qx+5pTUqi0Riu8FQ93sYeE9Z9CHFhAsw7qn5K/FNIGBe9ChTxULrjTEX8uxgDFIqcr6TbnUN89IPYc65vSQR3xCaoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZCPNokXB0xoqGmjI05CwR8SFSKhqegBoYG5Rc9GCuw=;
 b=QRNDLUYVNI924Yb0H/7KnORTvnuSybzJkXrcWipUG6uMsbntGld0efO6w32QCwQEK9KCW0QOO+Lqp8gFzMUMTXO1GNTW1vXw8q/MSiDxzqTCPZgscTBc9VCYJU5thUn7VIBtFJnXkR14LaTjN/3/VFduZsBepz8NutmOl5lH03XLcnTLmm7JIXLzyMHF9r5hGE4a8EDxWqnlpqrDwqocKUeyUTZ0I1rSu3ZO5xq1OKzJTXlSnI7GaQZtktMbDazEERbrokT5UTsw0dwDM4jJ6t0j4v/E93s7Gane1q/vy6Ox20LNvm7fUaMXMqVJRhwCRDcL99zt/rfAoRN5NkXdqQ==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by DS7PR12MB6287.namprd12.prod.outlook.com
 (2603:10b6:8:94::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Fri, 28 Nov
 2025 09:57:08 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::7b2b:6066:67f8:7db2]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::7b2b:6066:67f8:7db2%7]) with mapi id 15.20.9366.009; Fri, 28 Nov 2025
 09:57:08 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>
CC: "corbet@lwn.net" <corbet@lwn.net>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "leon@kernel.org"
	<leon@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "pabeni@redhat.com" <pabeni@redhat.com>, Jiri Pirko
	<jiri@nvidia.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Carolina Jubran <cjubran@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	"rdunlap@infradead.org" <rdunlap@infradead.org>, Saeed Mahameed
	<saeedm@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Gal
 Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [PATCH net-next V4 08/14] devlink: Allow rate node parents from
 other devlinks
Thread-Topic: [PATCH net-next V4 08/14] devlink: Allow rate node parents from
 other devlinks
Thread-Index: AQHcXkcrzPDr7jevyUqKXVsvxYqs0rUHfQUAgABhHAA=
Date: Fri, 28 Nov 2025 09:57:07 +0000
Message-ID: <020f1f6fb31320f963b308ed333918756dba0d42.camel@nvidia.com>
References: <1764101173-1312171-1-git-send-email-tariqt@nvidia.com>
	 <1764101173-1312171-9-git-send-email-tariqt@nvidia.com>
	 <20251127200928.65ce7349@kernel.org>
In-Reply-To: <20251127200928.65ce7349@kernel.org>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|DS7PR12MB6287:EE_
x-ms-office365-filtering-correlation-id: f354e6ab-46d7-4271-a9b2-08de2e647dc4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eW5hVmRUR1J0c3d2VEtRTHQwOXI4aFRFa2ZlRzh0aG1oU2V4YWIzcDZlcWVz?=
 =?utf-8?B?L1p6K0RsMGhCbmlSWU5iamFRejZPTlljczIvYnRHUFNveDk3Z1ZwNlhqakpk?=
 =?utf-8?B?amtjYktnbS9VdXFwWnJTTFZMbHZrTXVFL0pQeldpYzRxL1ozZ09pd2xZeWo2?=
 =?utf-8?B?QllaSFNtWktrbzloa0poT3FlbDN6TEJ0RTJPZUY5M3RZVTNzK2pSWVJiUEE5?=
 =?utf-8?B?d0w5aFBWWUlINi85WTdBb09SM3QxcDZucEdVOWFObVBZdFo5N1ZQYlhkTVp5?=
 =?utf-8?B?WE84dHRsemlHbE5xVGZzSTRtUDZ2Q0NhaHFaanJKdnpTZmVDWXBmd3dCd1pD?=
 =?utf-8?B?cUZwR0RnbnNsdFVLY0llWCs1UTVwNTRUY1JPMzhNZHFRNmorNmkzMDBsdEcy?=
 =?utf-8?B?T2l1MU5aUHhYR2pnT3BJQktNN0RpelpJMW56RDQySGxlaXQ3YXFlOTUydHFl?=
 =?utf-8?B?WmJjN1lVWHFyOUNtWjNzMlE0OEd1Z3pkVVFGcWpiZXZPSTRDbzc5UWVieldI?=
 =?utf-8?B?d0h6QThZNE0za3ZNazRGUkJqWGxVemtoWi84K25md0lENmxlQ28yekV4Yk5X?=
 =?utf-8?B?cGxsWmRQQ1hUamxyY0ZzZ2hPbGgvUFVQOEdoR1pVV3hDdkFQZmo3U3gwcFo0?=
 =?utf-8?B?L1lpK21wZldwcWtmeWdvQW5XTGtSZUF0aXpYRzlxTFVHRVBxUjVhQTZMK1lW?=
 =?utf-8?B?VlRJUEcwdmowaWtaS3NndjQyb21nVDE1SWF4R1d1ZWhRRWVydVh0U0s5OGQr?=
 =?utf-8?B?bTIrcHlIOUsycnVJZ05QcUJxeWp1cUpyaEgrNDZmQTdqWW9NUVN4SXV3djFO?=
 =?utf-8?B?Z3hpTzJkUXY2K01MMjBLZ0xpeFQxRHVRWldrVm0xZG54Yy9SSXBkZHVTVGJX?=
 =?utf-8?B?ZlA2QUU5L0dMT0NNeVN5dG5PY0FGMEdmVm44dFJSdUczUTlMbTE1T0JPUHFD?=
 =?utf-8?B?YyttWUtYKzVWeFhnYmdVU3BpeUh0dG4xY1FmSTF1b0syNDVMT2VJc0hoQVFp?=
 =?utf-8?B?NEN2Z204N3hGN2VBV05tbmJSWkhtS3lNeUkvWm1lOEtsNnBpZmV5dnNGR2VT?=
 =?utf-8?B?M2REeTEvbzJtV0VoZDhqVnd3SDN1UnNvZFZrSVFMa0tmcDl5ZHFBc0NQclcw?=
 =?utf-8?B?WHJYRzBsUXJaaXVsd1owK1h0c2RMZkxkTEJrUE0wUnE4ZEMvMThHZ3RXSGR0?=
 =?utf-8?B?VVZEM2dEMjZRR0tmNE4rNWtQdUVaZHl4TlZ6UGlyVTFkcnMxZHdIeDMxRjJW?=
 =?utf-8?B?dllDSTZkMzhVU1NTNFk1bzdIeWo2a3FKNUlCMGJUd28ydnhHcjJ3S3ZmTmRl?=
 =?utf-8?B?ZFNOWFFWODZqL0pyR2RXZVlLcUJYTnlUelY2UmN0ZmUzZFBjSFc2c3VEaTNT?=
 =?utf-8?B?ZmpmZjBWR2RzM0tuOWYyTXc0S1hibEY4ajBRa092NFBzSGhRSzJWZHB5S2lp?=
 =?utf-8?B?TW14V2tUa28rc1duZjJGN2NXKyt4Ty9CL2ZKWG05SW5DdW1QWFd5NHFQd2pV?=
 =?utf-8?B?ZG1YQktqUENWTVF4ZXJJU2RtK3crY0JJU2F1cG84WFhqbGxTL2R2U2ROVzZ0?=
 =?utf-8?B?MGc5WmFKdHFkdGZBRlFhSHBnb2VyUStPVXhhZk1zcUo3TjVmR2ZRa2VWQTNp?=
 =?utf-8?B?aGpxdWZUcU1IT3Z5ay8zQ3pMNWxOTTN6MTRiSzd2dUlLTVFPM3FRU0xpTGVW?=
 =?utf-8?B?MmtLbi8yOFVPNkU2bmduOVhlU2xWVmZoL1UxS2ZadW1jTlFsOWVWb01acTEx?=
 =?utf-8?B?TGJvdDFmdUFIbVpqR2lPdXhCSEJwaCtIRmMraDdHenJHaGwyS2NhQzMxOXJa?=
 =?utf-8?B?dVJnVmgxUk5MMnZjVmdnSFpjMlZydkliWkh5UTZRNUJBUXBkRmZCTlArcENl?=
 =?utf-8?B?K1NsRGp5Z1VVR2N3K1FENkJPTmFSeEJlaHByeVl5cVF4SmdaMzkyeHNkSmp1?=
 =?utf-8?B?aUZ6c2dJYUdRVzJKWEd6YUxPTVJTbDZYT2xPSHRTTmFSazVnZk5sQ05STmRw?=
 =?utf-8?B?UGpjbTRySE5rWmtla2F1c2VSWnpFQ0RxWlE4T3l2Y2cxY0hCVVYrSjVuNTJR?=
 =?utf-8?Q?cAVdpb?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T2hEVXpob2pSZEF3QTdCMjNkTGZGb3FJbklpUkZMMHI4RkZRM0V4ckZuQmdY?=
 =?utf-8?B?QVdScjZJMmpyUXJ2VjZoMGE5dVdLcnF0b04yU1YrNnVlN0d0VXo0cThCOEJa?=
 =?utf-8?B?KzFGeU5DYWxJRlk0TzJENGVzYmJWMVJQWTF4S2JxODE1S0xZK0ZOVHd1T0k0?=
 =?utf-8?B?MVM3RzlHRUxuK2gxSG5lbzA2dUhrTVBrVWl4WXpEYTNUZ0VuQ3lVWitoTmxo?=
 =?utf-8?B?WThEN0F1Z2plUy9GazVKc2Z1alU0L3djODB0ak00NXhpWUtOTVRFWTFlTmFL?=
 =?utf-8?B?R3VrY2QyYnpvVG5uZjNsWGFSeTQxRGZTVFVJZ0RNZnhYY2JoemNjbDlTNGFS?=
 =?utf-8?B?b0hDSGFNL3RvV3hIM0Y3bklCQUVnT2s3azgrNUhZYytWcmhQWThlZzg1djdK?=
 =?utf-8?B?eHd1NDdLMktTUVJFQUtnZGtOZllyVlN4cWh5N01YQ1NpTlNWY2tROGdhRWFY?=
 =?utf-8?B?UEJ6NmN3ditoNUg5ZjdYaEN4SCs5V1hwcWtFbjdVTzduQWcxalBIMW8xdEVX?=
 =?utf-8?B?aHo5K1VKdFR6RXRrcHhCcjBqUDdSc2ZUWWN0UzY5N05najhQeXZLT2piZUsx?=
 =?utf-8?B?c3FTTGNkdTdQeFVsZEpnWDF1VjhXKzUvSkJLNUtaTjNNZ2gwM3VhdXdZVTlz?=
 =?utf-8?B?cHhSRXoxNmUvLzN4VGIybXJTWjBTRDBXUndxODVmTEo5VkxCMjRQSExMZHVV?=
 =?utf-8?B?djJNTHpRSHNvSzVNeG4xeGd4YVJ2ZnVEQ3JmN0hCb2dUQUp5UFFBL2pZcnNB?=
 =?utf-8?B?UmxIOHlCYXN5eUNvYnlDL2xNTjQycHVtWGo4R1hKQ0hCVzI0MHF4S0RWYklF?=
 =?utf-8?B?b1hXWWJ1RWZIWkJUTDk5a0xBRU45dU5uWElNcVQ0YWNaSHRMTzZEUFFFcXNZ?=
 =?utf-8?B?aFBmYTVWRWNuQ3RCTW4wdWpaTVVVbFZIOUV4RmNCSFFpbFdpZ1RuOU9sNmkv?=
 =?utf-8?B?UmkwMEljSWhKSWEwbkFwKzZ5MnViVDNKVHR5OHJFQU5TNDdhTlZPRmJHN0lY?=
 =?utf-8?B?bVhLSC9rNVZnejVUQ0tkcnBkL1g3bWhhSEVoT2hxVzdRN3cwUElVZ1dIeXh1?=
 =?utf-8?B?NHpBMUxQbzNFVldseG5RUEJCZzYwYW9uSDBFNXNkTUREZmhTd1hvTFpmc1hV?=
 =?utf-8?B?NXZFK0lFbVlGUGpxV3BmcUZZeUdRSzAwVFdSaVYxeUhWQ0ZRS20rbFVpclZG?=
 =?utf-8?B?N2w5a2EyZFVSU1pJbU9rbU5oZUhoQkd6UDNqS1E0eUU2SzlsNk4wODY2Q3Rk?=
 =?utf-8?B?Yy92RVAyTjlKNWJWditPcy9vSklEUHFNTFEvQXNoNnZ1M0cxVmFZQjhkb1BW?=
 =?utf-8?B?VWhoQk5mVEg4VFBoMFBwNDRUVE0va2tEbVdxcUo1c0N0OWpXS0pqc1dXN2dJ?=
 =?utf-8?B?Rld4RVhCSUZ0V3pPN1Z4bUhTZUpNUGRSTS9VREo1UTU1ajUvdVB2R3d5RzEz?=
 =?utf-8?B?N01Yc2N2TWZoS0lsaDdhdDFsOTd4NmVLWlVjVzd1K2N0VFRLWStYSzBFRHVw?=
 =?utf-8?B?TkxRcG9UZ2hVL2E4aTBKTU9NaDVidzlVZlBjaStmTlErS1NtVVN0dlpiblpt?=
 =?utf-8?B?c3FUWjZhdm1FalBsNVJlR1RrYWVxQ3VlRnRjMEY2YmlXZUQ3ZFFHZ1RtbzZL?=
 =?utf-8?B?ZnpOdmY5dmNqTTNEK003WllPalltL2l2QkJVYm5UaXl0MGVESjRCbHRYcmVv?=
 =?utf-8?B?VXg5aCtTSzBEK1FQWWxPbFlyODZUNVhJT1Vjd2FSZ2VKOTJDT0t1d0hnelQ5?=
 =?utf-8?B?UnlkcHlibmRUUkl6Z3JjYldkNi9Ra3dVZVJzSDFMWWhXalhKRERmNndqQW5O?=
 =?utf-8?B?ZTlOUVJIak9HYU9EajYyT3Q1ZGhadDd1bFJncTdueDdFZVFQdmtYRU90NFJE?=
 =?utf-8?B?TGNiUlpvWit2cXhId1RyUzdtVnprMkk3b3hSdUg0dXpGL084SVhXdmhMSnhE?=
 =?utf-8?B?TVloTDVzVi8wOTJ4YkVFQUNtNlY3QzVyMXY4SUtGeis3QjA3ekRaYlcvODcz?=
 =?utf-8?B?VlI0cHVPU2luWkpoR0lRSktvczh4VUNCSjg1dUFqM3pDK2xONENmT1IxOTBG?=
 =?utf-8?B?Wk83TTZqaklRVUNtalpjOU95dFg5S3dVYUYyaXdac2VGTGtBTTNlSzhwc0lZ?=
 =?utf-8?Q?7AKlUoocKdd7Lh3H6HOx8TYJP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2FB36DD49A261441A3EEF38C97BF7DBE@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f354e6ab-46d7-4271-a9b2-08de2e647dc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2025 09:57:07.4239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9xJfnBxIBciNyLIeQCar335V9Rq1YsGlPvdAKYCIVD+C7DaB0zrKPgjcNqeDzJ3oqbDdvQABycw8Ia/EUYVlMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6287

T24gVGh1LCAyMDI1LTExLTI3IGF0IDIwOjA5IC0wODAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gVHVlLCAyNSBOb3YgMjAyNSAyMjowNjowNyArMDIwMCBUYXJpcSBUb3VrYW4gd3JvdGU6
DQo+ID4gQEAgLTY0Niw2ICs3MDYsMTMgQEAgaW50IGRldmxpbmtfbmxfcmF0ZV9zZXRfZG9pdChz
dHJ1Y3Qgc2tfYnVmZg0KPiA+ICpza2IsIHN0cnVjdCBnZW5sX2luZm8gKmluZm8pDQo+ID4gwqAJ
CWdvdG8gdW5sb2NrOw0KPiA+IMKgCX0NCj4gPiDCoA0KPiA+ICsJaWYgKGluZm8tPnVzZXJfcHRy
WzFdICYmIGluZm8tPnVzZXJfcHRyWzFdICE9IGRldmxpbmsgJiYNCj4gPiArCcKgwqDCoCAhb3Bz
LT5zdXBwb3J0ZWRfY3Jvc3NfZGV2aWNlX3JhdGVfbm9kZXMpIHsNCj4gPiArCQlOTF9TRVRfRVJS
X01TRyhpbmZvLT5leHRhY2ssDQo+ID4gKwkJCcKgwqDCoMKgwqDCoCAiQ3Jvc3MtZGV2aWNlIHJh
dGUgcGFyZW50cyBhcmVuJ3QNCj4gPiBzdXBwb3J0ZWQiKTsNCj4gPiArCQlyZXR1cm4gLUVPUE5P
VFNVUFA7DQo+IA0KPiBlcnIgPSAuLi4NCj4gZ290byB1bmxvY2sNCg0KTmljZSBjYXRjaC4gV2ls
bCBmaXguDQoNCkNvc21pbi4NCg==

