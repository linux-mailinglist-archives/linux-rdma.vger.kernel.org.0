Return-Path: <linux-rdma+bounces-18256-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SE8tMcViuWlsCwIAu9opvQ
	(envelope-from <linux-rdma+bounces-18256-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 15:18:45 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 222DE2ABA71
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 15:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73834316FA5A
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 14:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E213E1223;
	Tue, 17 Mar 2026 14:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SAnq/y89"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021096.outbound.protection.outlook.com [52.101.65.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB202DB78C;
	Tue, 17 Mar 2026 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773756429; cv=fail; b=D2zB66Tyn52DV1nz9KI5UhD4UiHRh9VhYkSuG+IIsq6dSFz3BFqRASPhm9eXO1/z1RK79MdrYlj+cR/OTnZsuYYuEzX8hEA0emmPNW4PB9ogmzSkpHmYEWllapEEfuuKHijz0p+iEHG6q2hpwYnMxrjx8VjqjjKgtgGLgDuicGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773756429; c=relaxed/simple;
	bh=krvuVzrQhwa+J+Pog9bNZvd+FCbttS9VKq99/WQkUEs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IDfnPnumEgju4/eqSh2DDYT+rxzbOTvKtb1gtE0n5PFKFHcoiIQ2PQqaegPYFWJXXwmT0AiY1UqlesqyboD/dCYxitlceomzG2c+YLE+9YF27LnirMlAGtqzJcXza35QDQVh5yeOFa9UP1DbfBxi5nRirKR9NLqyVNKcOfLRcIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=SAnq/y89; arc=fail smtp.client-ip=52.101.65.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S/4FLYwKIF8+3uSzyIX+rkPpBIdSMQY4G3CgehTXSoB7HP2cbojQ21GbQWcadr2Rf0itn9dLvfPOoDd+vH6peT20uRGc3zKitbCE8FghLLRytKREPRAebOHVIfSv9CyvalKGc9wafC0iaDhqaShgJmFJRE10FlIco5a31wGOhvif9D7pXyQkusNSQHnHlvDBku8bQUqS4Cnuq8OEqhp+qbJ/9K62T9atBysrmzy6XlBMX5NaZqTRdo6WoKG9k+k6pgKaEAw2aEhKNl7Uj4tjZ0D7XNz5gtOMZL0tvwWo1XqTaSLq8oBGbfU8hL9AnbHpePwtXsToJku0TahHxdvIRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krvuVzrQhwa+J+Pog9bNZvd+FCbttS9VKq99/WQkUEs=;
 b=W5wmJ+TNtJMbaGAYPy+Ii8rJu1jPLZcai41pD4fRl9W2/G+rP5Xz/NpMQOpJOQU6oLvhGvupOK8HYNrm+tKskz64aTHbO7EVbZUCIpckoEjJq9ZI5X+eCSQUJIR0a0kSbNG2WORtwlm2wfxhTUF1PHXmwNsITpUyphtVwNlJug6/yHsNhiXXfr4mwMQ2GT+I8aSsrqF9M6cmSXQcN6mPa0iwiXOGG/4Fn2Ev8WPsUKwmpV++dfT+rkauACmdJIOgxgHipHSBzwV0VrmY0lfyz1JKVrhIOqClgTC8mcaUkXADaae98fkkGuVKfbN25gasHw8bi31W1f4ejGPcGRvMPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krvuVzrQhwa+J+Pog9bNZvd+FCbttS9VKq99/WQkUEs=;
 b=SAnq/y89iGkwp1Z1iaL3bbCp4+hqsz0Snw3PUV3QgVrFgNAR4H64bbpBQ13XdjuFiNcT0tPWsyq6zLgLsW3rrzCAnz+SS9vN2r/XlkGjS1JwDB5U8qAA3u8PzDHIJZeIvWwKdfxjaRrPNCYejCE/h5371I2NyAgXhujg/mQXZDE=
Received: from DU8PR83MB0975.EURPRD83.prod.outlook.com (2603:10a6:10:5cb::5)
 by DU5PR83MB0596.EURPRD83.prod.outlook.com (2603:10a6:10:522::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.5; Tue, 17 Mar
 2026 14:07:03 +0000
Received: from DU8PR83MB0975.EURPRD83.prod.outlook.com
 ([fe80::b11f:dc15:ff12:53e]) by DU8PR83MB0975.EURPRD83.prod.outlook.com
 ([fe80::b11f:dc15:ff12:53e%3]) with mapi id 15.20.9745.007; Tue, 17 Mar 2026
 14:07:02 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>
CC: Shiraz Saleem <shirazsaleem@microsoft.com>, Long Li
	<longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: memory windows
Thread-Topic: [PATCH rdma-next 1/1] RDMA/mana_ib: memory windows
Thread-Index: AQHcthdUMReq03a46EuMdmHHy7SRuQ==
Date: Tue, 17 Mar 2026 14:07:02 +0000
Message-ID:
 <DU8PR83MB097550C2AC6EBCF620A2FDABB441A@DU8PR83MB0975.EURPRD83.prod.outlook.com>
References: <20260306105758.508579-1-kotaranov@linux.microsoft.com>
 <20260316161430.GF61385@unreal>
In-Reply-To: <20260316161430.GF61385@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=bde045ba-8b0d-4afb-9ed5-1a987b80adcf;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-17T14:06:11Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU8PR83MB0975:EE_|DU5PR83MB0596:EE_
x-ms-office365-filtering-correlation-id: 7cfd1df6-0c62-4c74-55fe-08de842e76be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 3J79nz/2CnlS7lzUCASAzFoFZ4FUZdVbcSoAePTJXgI5l/9zk0WIp2dirQeBLSDlLhfeYZWUo+5SPd7sAesPueDiis72nedBEpTAzG99EDIVmGZrZuSkT6OCRtDwOm68NU+rxIGJlgJbEhmqZpKBNq6CHWVndVFRCMBa1ED6ESOe75ak49wYPRT5DdocW8V7CesAEifgFkYE6Wt0xxUKufUM65DX0RTXMItTaekcmYQouD8vJe2SOUGAHm+21MNXuG0V0Bq6rgX0qgkmnHuNrGmDPuCLu7lwVIm+AZXdEBBT/wOFmikClVUM8gqLsvwBgEVqabQmEKVZu6s6Omz52XRFRYGhMClmU8ifksrd9uM+ABoUaZuaFdCw73uK8XR2eZ+HCA4CZhzRInsBWt1dWwkYjr0iMYztiYFiFh2KMRaK0pHnmFoLvCWA8/wjp/t+gVvomh9ZkTMZ3NwTgQPrDbAUOO3epLSR++xAAM0IQ2Nt3tXPVrs3alTmVjtXIAUcLlgGNAMoWlSD86Tu14roRTiMpdhZgw5ee/dcTKDfRfRDD4ccn48bECYzGzNTJcWIAoMG5WWi8upbIxPHzl530TdEx4ktKfVIkemPv/77cPlSqxtANmcTKpPdCA0OZ3b0hsHT3itKfeVGOSPpgaP4u5/Wpbeiovog42ywqq2GudGXM7crtK+/XgkXQf35QPMipDDdSog76mmXR/c8oeX3zCxClgtkr8MV6aOX7gOlYF4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU8PR83MB0975.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WVdXRjBrMVhEWUZodk9VdExPcHpyVVU0OWQzcFVIS3llS1lFc0JGa0UzU05M?=
 =?utf-8?B?VlppMGZqMFZoY1l4bEZENVVpSmI0am1QSEhOSUdIQVZKT2dFSXczdmxuei9s?=
 =?utf-8?B?RDAvMUhyS2MyRGNCaE96OFlYMWFGNnJJQVgxLzdGM3hvWEo0R0pxTjJYM2kz?=
 =?utf-8?B?Q1RuNzgxMm1aQWhDY3diYW1aRmlSa1hwNWQ5WTM0bFE3S1cwQkJRNHVGaHNJ?=
 =?utf-8?B?c1A1STFWRHlWN1dCUlJVcE80NG04SmM1dmtlVG9QeDQ5MFhvRzlub25vekhZ?=
 =?utf-8?B?c0RxdVozTlcrTFdGWS9UZGZzRytQK090SFpmVXhhRk4rR2FVWHVSYi9PMGdq?=
 =?utf-8?B?MWtMem1EQi9KLzhEblJqQlk5N1puZ0VRcjJNSHFES2RyN0NrTHF4NG85RGFF?=
 =?utf-8?B?MGhKZGZ3T2lnbkVxS2d0MWVJQ3J5V1FkM0I0QUxjUW0xWnppK2JaOTY1K0NK?=
 =?utf-8?B?RnlQcVVuS3Q1TVpKeko5eDJ6Q1dwbjVCNlh2NDRPR1lRa0F2aHlicGM1WEdR?=
 =?utf-8?B?TVo2aXhQL2JHSE9MSEZPTnpqRldzK1Jxb2VCSUFrNUFSUFpQWUF1Z0dTejg4?=
 =?utf-8?B?U2plUFUyMmczaSswZk1NRjIzSG0rVU81VXhaZmNXSi9hRVkrWElNeDZxL1JN?=
 =?utf-8?B?d0dHOVBTY0JOdFpqUVlpeSthNGxXWGtoczJzd0dockJJeHNWOWR3YlVuNU5F?=
 =?utf-8?B?VGdPZkYyVXZrN21vUnVzT2hSZkdHWVBhSXR5VmhIWjc3SWpERHFkei9GUHNy?=
 =?utf-8?B?YWF0dE5WQ3RucVpERHVoUXdSRzR0YXFLb1lvMTkvbzVVTXlzS3FZaXRUUEhR?=
 =?utf-8?B?K2FuVXdOY3d5ekxmRmRCRXVjVG1WUHdLTlZEVFF5UkpvM3RGbXZWQ2E1dnI4?=
 =?utf-8?B?dlJ4KzN2eXl1bWhJby91Zyt0R2JySHc1TUVjS1ZPdnphMEZ5aGZ1ZG5tOFZO?=
 =?utf-8?B?Z2JUcHdnSUx0MjRNV0ZoSTBEbTVSeTJZUCtpbnJsSHQ1ZGwyYk9BV1pVVTRs?=
 =?utf-8?B?U2JNeWkxdFc3R0RZT2lOOFgybUpGbXZSSk8rY3VleVNsUXgzaVdJN2t0Z28z?=
 =?utf-8?B?Vm1mMlFlaVloa0FCQkFYcDBhN3RRWW55cXBHdlhOVitTM1JTSEZpQm91VzJW?=
 =?utf-8?B?c0pIRCtmeHNKdFhIMzZNT0FvTjN4ZDQ0b0FJV1NiaHBOWUVibjVuSm1yWDd0?=
 =?utf-8?B?U2NyekpHTis4TktQdVhHME9QWWUvNVdwdDFBVjlqQ0xwbzRRejkySkpBbE00?=
 =?utf-8?B?QmhlNm82MjNIQmpYd2RVOUZKYldQRE03MWNUa0ZvcnEvUUkzNG1JRmJlcGVy?=
 =?utf-8?B?d2FxS1V0cUhkMmUwcjY3V0dTcEduR0xzdGo3WjVjbGhXT2FELzdlVTVQczV6?=
 =?utf-8?B?QUFSLzIvMDRjUWQzU3UrRE1abEZqNGUzenJZTm1Ba2tmWi80eDRSTHBMVDdw?=
 =?utf-8?B?WjMyYU9sUlYwL0JTVC9EYlE0YVJTRFI3M2RBMVpXNnFQa3BXUlhJM215Q3FZ?=
 =?utf-8?B?UTBpRDQ5WFZuSUJzay9sSFdYNmhlWlk3WjdVdzczVXl4T2dXbjMrem9uS1VY?=
 =?utf-8?B?TVJXRmNTWDJmTGl2OG9qRnFPZ29aM201MUVWYTRHZjh2SzhoM1RxU0VNbngz?=
 =?utf-8?B?UC8vNTFHTk1JbUhMOGxhNmZRTWlob25YUzMvUUoxeFBLMG9INDliVXhFbkhG?=
 =?utf-8?B?QWhFUkU0aTJGZHlNcGtncWNmNFpGT0lURkF3ZVA1NEZHNlR4dzBvSzdpVHhD?=
 =?utf-8?B?Q05HaldSZ3RiNGhNRFpvb1d3VVVwa1k3OXVFRTUwUEt2SXc2K1RIWnNySGhG?=
 =?utf-8?B?TzQyL2d1UDlZa1M5dVdvZy9zVWN2Sm1rbS9rTkVnZnhhRFBBTHVzTTJVN0Zw?=
 =?utf-8?B?aTFQTCtLTi8xOHhtb2pyb3R2a0pRVDM0VXZJWXFxdld4VkI1ajJPUkwzOGtt?=
 =?utf-8?B?aDRId0EyZ29lWlFqMG5mcm1vVzF3ZExJVXY2ckFWRDY3cGphTkVPQ0ZVbTRz?=
 =?utf-8?B?aUF2eTlmYXU4c1VCOEx5NWtjVHgxZitCdlpCU25GOVdxeTMvV1VScmQ2OXNq?=
 =?utf-8?B?akpDMmpvWktYMUlaZFNKTXZ5ZHNTajhzTnhoY25sQnVZTkZLUm1aOCthTkhO?=
 =?utf-8?B?Q1Y3OWlaT0JyeFdNZ3lzVDVyZXpJTVB5ZW1PZXJqY3A1UHpPTVRhYkxWTU9z?=
 =?utf-8?Q?j2hf31hx40jy+k22f8csLS5xhvW49Ko/eKC+n8aJeyC/?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU8PR83MB0975.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cfd1df6-0c62-4c74-55fe-08de842e76be
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 14:07:02.8164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ez3wjRrM+1Hdo4uEZNybxsNbDCUzeBEgPzz6zVpFJCG21MygRsc/G8FIEghS6BMUGQR5iLP2w45IfipQ/+DDlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR83MB0596
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18256-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kotaranov@microsoft.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[DU8PR83MB0975.EURPRD83.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 222DE2ABA71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Pg0KPiBPbiBGcmksIE1hciAwNiwgMjAyNiBhdCAwMjo1Nzo1OEFNIC0wODAwLCBLb25zdGFudGlu
IFRhcmFub3Ygd3JvdGU6DQo+ID4gRnJvbTogS29uc3RhbnRpbiBUYXJhbm92IDxrb3RhcmFub3ZA
bWljcm9zb2Z0LmNvbT4NCj4gPg0KPiA+IEltcGxlbWVudCAuYWxsb2NfbXcoKSBhbmQgLmRlYWxs
b2NfbXcoKSBmb3IgbWFuYSBkZXZpY2UuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBLb25zdGFu
dGluIFRhcmFub3YgPGtvdGFyYW5vdkBtaWNyb3NvZnQuY29tPg0KPiA+IC0tLQ0KPiA+IEFzIEkg
c2VlIHRoYXQgSmFzb24ncyByZG1hX3VhcGkgaXMgbm90IGluIHRoZSBuZXh0IHlldC4gSSB3aWxs
IG1ha2UgYQ0KPiA+IHBhdGNoIGFkZGluZyBoaXMgaGVscGVycyAoZS5nLiwgaWJfaXNfdWRhdGFf
aW5fZW1wdHkoKSBmb3IgbXcpIHdpdGgNCj4gPiBhbGwgb3RoZXIgYXBpIGNhbGxzLg0KPiA+ICBk
cml2ZXJzL2luZmluaWJhbmQvaHcvbWFuYS9kZXZpY2UuYyAgfCAgMyArKw0KPiA+IGRyaXZlcnMv
aW5maW5pYmFuZC9ody9tYW5hL21hbmFfaWIuaCB8ICA4ICsrKysNCj4gPiAgZHJpdmVycy9pbmZp
bmliYW5kL2h3L21hbmEvbXIuYyAgICAgIHwgNTcNCj4gKysrKysrKysrKysrKysrKysrKysrKysr
KysrLQ0KPiA+ICBpbmNsdWRlL25ldC9tYW5hL2dkbWEuaCAgICAgICAgICAgICAgfCAgNSArKysN
Cj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCA3MiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
DQo+IDwuLi4+DQo+DQo+ID4gKyAgIGVyciA9IG1hbmFfZ2Rfc2VuZF9yZXF1ZXN0KGdjLCBzaXpl
b2YocmVxKSwgJnJlcSwgc2l6ZW9mKHJlc3ApLA0KPiAmcmVzcCk7DQo+ID4gKyAgIGlmIChlcnIg
fHwgcmVzcC5oZHIuc3RhdHVzKSB7DQo+ID4gKyAgICAgICAgICAgaWYgKCFlcnIpDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICBlcnIgPSAtRVBST1RPOw0KPiA+ICsNCj4gPiArICAgICAgICAgICBy
ZXR1cm4gZXJyOw0KPiA+ICsgICB9DQo+DQo+IFdlIGFscmVhZHkgaGFkIHRoaXMgZGlzY3Vzc2lv
biBhYm91dCB0aGlzIHNwZWNpZmljIHBhdHRlcm4uDQo+IGh0dHBzOi8vbG9yZS5rLw0KPiBlcm5l
bC5vcmclMkZsaW51eC0NCj4gcmRtYSUyRjIwMjYwMTI3MTQxOTI5LkdWMTM5NjclNDB1bnJlYWwl
MkYmZGF0YT0wNSU3QzAyJTdDa290YXINCj4gYW5vdiU0MG1pY3Jvc29mdC5jb20lN0MyNTczMWZl
ZGYzMzU0M2QzMGExMDA4ZGU4Mzc3MWUxOSU3QzcyZjk4OA0KPiBiZjg2ZjE0MWFmOTFhYjJkN2Nk
MDExZGI0NyU3QzElN0MwJTdDNjM5MDkyNzQ0ODE4ODk4OTYwJTdDVW5rDQo+IG5vd24lN0NUV0Zw
Ykdac2IzZDhleUpGYlhCMGVVMWhjR2tpT25SeWRXVXNJbFlpT2lJd0xqQXVNREF3TQ0KPiBDSXNJ
bEFpT2lKWGFXNHpNaUlzSWtGT0lqb2lUV0ZwYkNJc0lsZFVJam95ZlElM0QlM0QlN0MwJTdDJTdD
JTdDJg0KPiBzZGF0YT1MakclMkI2ZlhtZkFSVDVqSnJsViUyRmF3WEIyUXB3RzlHekhqJTJCZlRt
azB2dWYwJTNEJnJlc2UNCj4gcnZlZD0wDQo+DQo+IFBsZWFzZSBmaXggaXQgZmlyc3QuDQoNClNv
cnJ5LCBJIG1pc3NlZCBpdC4gVGhhbmtzISBJIHdpbGwgc2VuZCBpdCBzb29uLg0KDQotIEtvbnN0
YW50aW4NCg0KPg0KPiBUaGFua3MNCg==

