Return-Path: <linux-rdma+bounces-18599-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEIMOr67w2kKtwQAu9opvQ
	(envelope-from <linux-rdma+bounces-18599-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 11:41:02 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EAA323285
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 11:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB3F630AD4B6
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 10:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14703AEF25;
	Wed, 25 Mar 2026 10:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="HzpYjWDO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023112.outbound.protection.outlook.com [52.101.72.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C193A63F1;
	Wed, 25 Mar 2026 10:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774434589; cv=fail; b=ZzWOPtGTJI45E7nx42hOVgHQWilIQ3BR8iFqqDv1dEMe5sqpNnHpZ5P5UQwZfTYcKJNLcQOka5c+worwGFTdpjsTLDWfdaqHYoqQAvz0bLfkHLE9nFRe/S6gl3emssIVBGMW12Q+0v3L2OdG+Cr2YDcXqRBIyPXrSQJvEaJ/dIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774434589; c=relaxed/simple;
	bh=BVmgAQiov/0h5T9FDnAPq7NhjiEBpQ03w/1rUP5YRLA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pvef2/HedJB4G6T+gs7tlIxmZyFSAubY9VHKfBu1ZyMN0SIg7aMVZ8FF8qv3mxao06mkdctaAi/GejMKQa0Q463sTWYC/SgYYCnb3KXni2W/butrm2LrBFlriZ73DUFg/lW4PF0uKAYNxZ81q45D65h/duotH0CsZQT8Wbe4WbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=HzpYjWDO; arc=fail smtp.client-ip=52.101.72.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iPuI2wjmitseKS6mvPA2d3D95DISrMcrY1Mt7CN61sovBEQfjx7dmJKmpApl4wFBjnzO7uVjWkNVHJ7+2PZiLHOnrf/7SUHWHmvuMzBX7Vyd/Kp/g2jVFWtOE9oDQz6MpF33sj59dPftSRHUjqTGGXIMEOg6KSXZiDCOoDAPhedtr5fcRMDqreEW9JQOB5JppLiBuXTQvCEpgRsOy+NYtIl2bYoiaeD3ZnqN7ZljJ8597146KTC6ib6IEDebdrlJni/Qb3anMABTd5Bsd8zJPs9PXsEaoo2VYa8ysM+BdWsdRSuGGU9+i5ZXgXa5wxYYjk78lUYxMEhTXs67uXhVLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVmgAQiov/0h5T9FDnAPq7NhjiEBpQ03w/1rUP5YRLA=;
 b=X60i9Po5p7EFN98uR4sgo0H0HP4zRr/mEHZ+C/xo4B/fmFuKeHcVyb/ZTs2fuognX7PzUEucAebp4FjVKa7NXz/z3UfTqnWe1oA/7NWfDoNqCT8G7RhMo9tvNS78LQ7EvJP37AT1sq5JIvgOnT4h8HWxfVGKSTtwoMMnxatnKKIzjGSUKuU1DIO7CaB6/sVWHRFBoqBYTxu5FMUqFd5jcgPAaTWZDJ7LyLcBgi1/rY2e6/HqGXm70uFvVGwnr20bTUBbNJG1ychNSff5i3cqwI8iYRbysvowXWHH6RpBBYYMz329DGtDPuH7oqAk0PoiWUec1wUCW8CPHf+o9sKWrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVmgAQiov/0h5T9FDnAPq7NhjiEBpQ03w/1rUP5YRLA=;
 b=HzpYjWDOfgiBUJ4+kH75dhIAv4jRBF3D68vf7FkCuFDVtuS9LgVvIyJ2+9iAYZL3kkWXPrOanuLjMhBi6qUwUpGRyQZDualBOI/CfQvKN6eL8tFW9pzE6thN3RZQRguz78F7ttPjJYlJoXQrpXGOGv8Z1Fsh8oQUJrkV8JNTp3c=
Received: from DU8PR83MB0975.EURPRD83.prod.outlook.com (2603:10a6:10:5cb::5)
 by DU7PR83MB0830.EURPRD83.prod.outlook.com (2603:10a6:10:5b2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Wed, 25 Mar
 2026 10:29:43 +0000
Received: from DU8PR83MB0975.EURPRD83.prod.outlook.com
 ([fe80::b11f:dc15:ff12:53e]) by DU8PR83MB0975.EURPRD83.prod.outlook.com
 ([fe80::b11f:dc15:ff12:53e%3]) with mapi id 15.20.9769.004; Wed, 25 Mar 2026
 10:29:43 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>
CC: Shiraz Saleem <shirazsaleem@microsoft.com>, Long Li
	<longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH rdma-next v3 1/1] RDMA/mana: Provide a
 modern CQ creation interface
Thread-Topic: [EXTERNAL] Re: [PATCH rdma-next v3 1/1] RDMA/mana: Provide a
 modern CQ creation interface
Thread-Index: AQHctwBYLBI/fGAS9Ua5kO0oZlAdOLW6mqCAgAR6BgA=
Date: Wed, 25 Mar 2026 10:29:43 +0000
Message-ID:
 <DU8PR83MB09759D66331C87AFA522C37DB449A@DU8PR83MB0975.EURPRD83.prod.outlook.com>
References: <20260318175455.1419129-1-kotaranov@linux.microsoft.com>
 <20260322140101.GA814676@unreal>
In-Reply-To: <20260322140101.GA814676@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=110791d6-484b-445c-b8ef-9ed28cb8f877;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-25T10:22:47Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU8PR83MB0975:EE_|DU7PR83MB0830:EE_
x-ms-office365-filtering-correlation-id: 4bd86fb2-9a06-4e8f-1612-08de8a596dd8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 O5zmvpxWmkgHgqKmESkmt88RjS4n+3KtCyupICvuIy4tb2d+wnbs7pklLE+bYGvAzB8Xs3IWo/0KnDlDQ60DkGizOdCWDWbIheVGMsG9PlSZk2QU72uTMx0NtSNsbcyx3pZNuUrGA8wQ/L6ne52cSR5KBipby+4hh6rqrbZCj3PoKS3O/aletaSHxMTJkk5SNG1njDtjKmN4gcCZt+DBxGPWL2kqq7QpLloaV++pQQIDXNNLV53e9C3I6fEUsak/tqK/yVZqiybRaBqZsx3LOqPKFi6mM60lYi/fbezVXqOBP0qYp4C63SltMrKrWhrO9LYgWvcUUKdMXCH9tm0+5ebGYZuqe1qF1mgR4SdvlJj33zdnv+IjjBelPAQP8wJEjbZ07Ygl+vl5Z5S5tm2r0iNnk3/S2vs8fAWIylEW7elQKNuy9duFZFuuZbzTE9X7KAthN2Dyll6TrFmEeJxGL8UVVgXHUznpddIoELSmH792J0TeYAuJOat6yRIcj3k0g422NtTfjebb7BUAZvB+5mqaFF50TfLvqucjLzTwquD4ca7KdanYGMZBr57Uxa7tntv2mdN5sKiqs3685ngSdX07XQz2TDyPc0NYJcGHwZnNK62TxHNNTs+Y/xTdhnRzN207/tSs7L9k4Fsn2YuA1Rk362I+ha5DrLVFZ/CIwiw+zU/B3jPE8VbR7ltRDycAhSv7Ui/FFEM+slLPQH+PgdZJPHZqpYZUcnU0Rr7QMoaxKP6GcmERnrCp/+jdvj43ppZ/E4IemIH2F/UMnKumbOsuUps/6zOT0GwOzYR7CJ0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU8PR83MB0975.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WDV1cUZ2OEhhWFdTM2c4eEVaUjZ4WHJhc0t0eUFMZkd5bGovdndjdlBYbVd2?=
 =?utf-8?B?WTJUT05aYTg2bG1MV1lDd3pzR2xVZWVxZlo3TXVyRlUzcUwrWGZRbnUyY3FP?=
 =?utf-8?B?aW1xVUdYS0IyQ2FRVXBYVThNcnhENkl0aW1ITzlObEFWanpOY0lTYU8xeEJz?=
 =?utf-8?B?eXZMUVJBTHV3T1JFQzdWb2NIdnIzMkFjOWVkYWs3YUxPYjg1Mld2cmZRTjZS?=
 =?utf-8?B?VUtSdEc5R0R2U3FwZlZCM00vYlFKL3RRZzJBRWkremNSeXltNGFyRjNLSWl6?=
 =?utf-8?B?TUtZa3A1eXQwOGFBY3pwc2dSL3c1TW9KNDZzdDc0c1RnOTdBbXdGQWpMNDlz?=
 =?utf-8?B?VjBrUGlaZEZyQ2Nzb0tOR3ltMUNYNjlTWlRhRnFmZ3Y0U2UyY3Qwb0lvR21C?=
 =?utf-8?B?NTNKVTBVcUoveDlJdFdLQjN5c1V3ZWUrWXRWTnY4enBTQWV6TXpWOThxb0Ex?=
 =?utf-8?B?cE1aRkJoMVlRcDN3cFJPdzdJY2FOREZML3dTWFhDaVFaN3pER3lKREtjdFZJ?=
 =?utf-8?B?UUQveGVXWGZzbEVVM0xkQkNma1hDVzlLSGozQ3NiYjh4MnNMVStPb1lhVFIr?=
 =?utf-8?B?OE1sTGVRdE9YK0IweTZuRzUwZFpaV3ZmUXpIWXdtYVoxOXFXb1V2a1V4a1Vq?=
 =?utf-8?B?Vy9URmQxOFVkdG4vN00wNW1SanRIcitMVjlnZFdaY0VZVERLOVBIMFczY1hU?=
 =?utf-8?B?bkp2MHNlSWJhMm9UWm5uK2NiaHdjYmRjTktRVjRFUlViSGYwdzVRbnNsVUl2?=
 =?utf-8?B?VVovaXJDcmRjbTlRK21lWFBCM0JpZnU1M0FnUGdkdzV6TE1Sc1dqWjZjSUhs?=
 =?utf-8?B?MTFhSERxQzQzY2tvakJiTUVIRzRoMmpDZ2llZWs5eVV0N2lXTnlHSjNENDJk?=
 =?utf-8?B?dHc2OFBZSU1Mblkrb0VQUXZCTVF3OWZKMXZzVmtMSld5U1YwMjZZTmhyRXpX?=
 =?utf-8?B?emhldU95ZXNwanJoc3ZaaDcwa0k0V250cnZBY2s2MHg2cVFuL3EybU1tUWh5?=
 =?utf-8?B?VXU3NEx3d0srVFpTbVFrd3RjL1hlTW04QUszeTYzaFd2bzllREF2aUlSZW1r?=
 =?utf-8?B?anNHbVFJdlpzQXVuTm9iZWo2by9xVkJtSnQ2Zld5aFRWR2loQWhrelZ0UHJP?=
 =?utf-8?B?cExVZ25SaTZ0a2lRYVpjQ1gramxEMzYzbFhFUzdPMHZZUnhaMWg4UDVkNUJH?=
 =?utf-8?B?RWM4Rmw0Nk1saGJMVHVJMTJlRDhFeERPVGpaOXFNWHBTaU1BdFd2ZXhxM0Rk?=
 =?utf-8?B?ekVlWVpUcGIyV3c0UE5LY1BURWszaldEMFBsSWJESGJpWk5aUmloaU5kTXZw?=
 =?utf-8?B?d1AxNFoycHIvQmh3bWtjM1BTbXBYRzRRNHFlVThkOEJ4bzcrR01vMDJVbXVo?=
 =?utf-8?B?eGFhQUUrcHJzWjhPRUcwbC8xVCtPN2VYaVR6THJ4NXBmNExpYVUrbTZ2Mysv?=
 =?utf-8?B?UzdHb1hPWDU1TmVpRkZja2dESkp4TEhzdEdJbjlqRjZ1OTdQR1huS0tQejJ0?=
 =?utf-8?B?d1M2bm9hRHdIeEQyRUpURkFWWlJvMnJmTVI2OEQ1NkkxYVlGRTU1dUV5aDNx?=
 =?utf-8?B?UDBGcitEQ3A5YlJjVFRYN0tZWVIrUlRzTXhrbWhGL2Jrd3dRSzBEN0F4SVI0?=
 =?utf-8?B?MGhKM2F1NHE5L25jVlhSaGVEZ0xPbE44MCtMSmhQSEJVL2xCYUhlaVFvY2VW?=
 =?utf-8?B?bHA5bGJYSCtvelkyWVh3REh2VVlSUzM5RDBOMEVmODJ0ZUI1elBxVVZLY1ps?=
 =?utf-8?B?d0UzNVVVMldadkdybCttbTZkUjdKekJ6VTF5K0NJSm15cFIyRUo0R2IvbEVT?=
 =?utf-8?B?M2JYK2o3NVQ0N0pqRjhuUGlQSmdZcm5zVG9GQW0xNG1LYVNVWDF6TEUyQ1FM?=
 =?utf-8?B?VWZQVVQ4bS8zcFR6clFxWTJiYVVHeXdFeFNrc3hEZ25XR1pUeGdTLzJnMjJZ?=
 =?utf-8?B?WStjZ1Q2R0dCSVFkZmFyVnpWR0ZsR2NlSkxsMUJoc0NFMzdwYmlHUXFqbmlN?=
 =?utf-8?B?UjdiQ0txQ210cEZMeWJoZ1JnQm1lYmx6VHJjTkFwSHNHU2VmZGlYdFpGVW03?=
 =?utf-8?B?aUdHTFRSMWlIbnYvdWVnQnc2RTRYK0MrNnU0b3p2STNGbSs4ODdDR1ljY1Bo?=
 =?utf-8?B?VHlsTDhyKzVLbzgzMktlV3p3T08zaThDb3M5dnVyTjRsTHI1OS82Yzl0bkVC?=
 =?utf-8?B?UEQ3NVFSNnJOREZFTW1jY3laQ2FvaWw3d2hJUE92ZTEramJJTC9DSXAvelYz?=
 =?utf-8?B?N2VXbFpsZUduempQSS9YOTVRUCtnPT0=?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd86fb2-9a06-4e8f-1612-08de8a596dd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 10:29:43.1782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cts104/CwUv/0p3QsroTFT+XLQ6hDsHtOHwot5B2jqoqPWEKoKwHwqudJpmIlMndGyIoaNWoxi7Z/lT6FObudg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR83MB0830
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18599-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,DU8PR83MB0975.EURPRD83.prod.outlook.com:mid,ziepe.ca:email]
X-Rspamd-Queue-Id: 47EAA323285
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGVvbiBSb21hbm92c2t5
IDxsZW9uQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFN1bmRheSwgMjIgTWFyY2ggMjAyNiAxNTowMQ0K
PiBUbzogS29uc3RhbnRpbiBUYXJhbm92IDxrb3RhcmFub3ZAbGludXgubWljcm9zb2Z0LmNvbT4N
Cj4gQ2M6IEtvbnN0YW50aW4gVGFyYW5vdiA8a290YXJhbm92QG1pY3Jvc29mdC5jb20+OyBTaGly
YXogU2FsZWVtDQo+IDxzaGlyYXpzYWxlZW1AbWljcm9zb2Z0LmNvbT47IExvbmcgTGkgPGxvbmds
aUBtaWNyb3NvZnQuY29tPjsNCj4gamdnQHppZXBlLmNhOyBsaW51eC1yZG1hQHZnZXIua2VybmVs
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbRVhURVJOQUxd
IFJlOiBbUEFUQ0ggcmRtYS1uZXh0IHYzIDEvMV0gUkRNQS9tYW5hOiBQcm92aWRlIGENCj4gbW9k
ZXJuIENRIGNyZWF0aW9uIGludGVyZmFjZQ0KPiANCj4gT24gV2VkLCBNYXIgMTgsIDIwMjYgYXQg
MTA6NTQ6NTVBTSAtMDcwMCwgS29uc3RhbnRpbiBUYXJhbm92IHdyb3RlOg0KPiA+IEZyb206IEtv
bnN0YW50aW4gVGFyYW5vdiA8a290YXJhbm92QG1pY3Jvc29mdC5jb20+DQo+ID4NCj4gPiBUaGUg
dXZlcmJzIENRIGNyZWF0aW9uIFVBUEkgYWxsb3dzIHVzZXJzIHRvIHN1cHBseSB0aGVpciBvd24g
dW1lbSBmb3IgYQ0KPiBDUS4NCj4gPiBDcmVhdGUgY3EtPnVtZW0gaWYgaXQgd2FzIG5vdCBjcmVh
dGVkIGFuZCB1c2UgaXQgdG8gY3JlYXRlIGEgbWFuYSBxdWV1ZS4NCj4gPiBUaGUgY3JlYXRlZCB1
bWVtIGlzIG93bmVkIGJ5IElCL2NvcmUgYW5kIHdpbGwgYmUgZGVhbGxvY2F0ZWQgYnkgSUIvY29y
ZS4NCj4gPg0KPiA+IFRvIHN1cHBvcnQgUkRNQSBvYmplY3RzIHRoYXQgb3duIHVtZW0sIGludHJv
ZHVjZQ0KPiA+IG1hbmFfaWJfY3JlYXRlX3F1ZXVlX3dpdGhfdW1lbSgpIHRvIHVzZSB0aGUgdW1l
bSBwcm92aWRlZCBieSB0aGUNCj4gPiBjYWxsZXIgYW5kIGRvIG5vdCBkZS1hbGxvY2F0ZSB1bWVt
IGlmIGl0IHdhcyBhbGxvY3RlZCBieSB0aGUgY2FsbGVyLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogS29uc3RhbnRpbiBUYXJhbm92IDxrb3RhcmFub3ZAbWljcm9zb2Z0LmNvbT4NCj4gPiAtLS0N
Cj4gPiB2MzogTWFrZSB1bWVtIGFsbG9jYXRpb24gZXhwbGljaXQgZm9yIGNxLT51bWVtIGFuZCB1
c2UgYSBuZXcgaGVscGVyIHRvDQo+IGNyZWF0ZSBtYW5hIHF1ZXVlIGZyb20gaXQuDQo+ID4gICAg
IFJlbW92ZSB0aGUgdW5pdmVyc2FsIGhlbHBlciB0aGF0IHdhcyBhZGRlZCBpbiB2Mg0KPiA+IHYy
OiBSZXdvcmsgb2YgTGVvbidzIGNvbW1pdC4gSW50cm9kdWNlIHVuaXZlc2FsIGhlbHBlciB0aGF0
IHJldHVybmVkDQo+IG93bmVyc2hpcCBvZiB1bWVtIHRvIGNhbGxlci4NCj4gPiAgICAgQWRkZWQg
cmVtb3ZlZCB1MzIgb3ZlcmxvdyBjaGVjayBmb3Iga2VybmVsIGNxLg0KPiA+ICBkcml2ZXJzL2lu
ZmluaWJhbmQvaHcvbWFuYS9jcS5jICAgICAgfCAxMzEgKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tDQo+ID4gIGRyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL2RldmljZS5jICB8ICAgMSArDQo+
ID4gIGRyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL21haW4uYyAgICB8ICAyNyArKystLS0NCj4g
PiAgZHJpdmVycy9pbmZpbmliYW5kL2h3L21hbmEvbWFuYV9pYi5oIHwgICA1ICstDQo+ID4gIDQg
ZmlsZXMgY2hhbmdlZCwgMTA2IGluc2VydGlvbnMoKyksIDU4IGRlbGV0aW9ucygtKQ0KPiANCj4g
PC4uLj4NCj4gDQo+ID4gK2ludCBtYW5hX2liX2NyZWF0ZV9xdWV1ZV9mcm9tX3VtZW0oc3RydWN0
IG1hbmFfaWJfZGV2ICptZGV2LA0KPiBzdHJ1Y3QgaWJfdW1lbSAqdW1lbSwNCj4gPiArCQkJCSAg
IHN0cnVjdCBtYW5hX2liX3F1ZXVlICpxdWV1ZSkNCj4gPiArew0KPiA+ICsJcXVldWUtPnVtZW0g
PSBOVUxMOw0KPiANCj4gVHdvIHRoaW5ncy4gRmlyc3QsIEknbSB3YWl0aW5nIGZvciBKYXNvbiB0
byBjb252ZXJnZSBvbiB0aGlzDQo+IGliX2NvcHlfKigpIHdvcmsuIFNlY29uZCwgSSBzdGlsbCBi
ZWxpZXZlIGRyaXZlcnMgc2hvdWxkIG5vdCBjYWNoZSB1bWVtLg0KDQpUaGFua3MgZm9yIHJldmll
d2luZyENClRoZSBoZWxwZXIgbWFuYV9pYl9jcmVhdGVfcXVldWVfZnJvbV91bWVtKCkgZG9lcyBu
b3QgY2FjaGUgdW1lbS4NCkluIGdlbmVyYWwsIGZvciBvdGhlciBvYmplY3QsIG1hbmFfaWIgbmVl
ZHMgdG8gY2FjaGUgdW1lbSAoZS5nLiwgZm9yIFFQcykuDQpJbiBvdXIgSFcgZGVzaWduIFFQcyBo
YXZlIHNldmVyYWwgcXVldWVzIGFuZCB3ZSBuZWVkIHRvIHBpbiB0aGVtLiBTbyB0aGF0DQpxdWV1
ZS0+dW1lbSBqdXN0IGluZGljYXRlcyB0aGF0IHNvbWUgcXVldWVzIHN0aWxsIGhhdmUgdGhlaXIg
b3duIHVtZW0uDQpJIGFtIGhhcHB5IHRvIGVtcGxveSBtYW5hX2liX2NyZWF0ZV9xdWV1ZV9mcm9t
X3VtZW0oKSBpbiBvdGhlciBwbGFjZXMNCndoZXJlIGl0IGlzIHdpbGwgYmUgcG9zc2libGUgYW5k
IHJlbW92ZSBxdWV1ZS0+dW1lbSBjb21wbGV0ZWx5LCBvbmNlIGl0IGlzDQpwb3NzaWJsZS4NCg0K
VGhhbmtzDQoNCj4gDQo+IFRoYW5rcw0K

