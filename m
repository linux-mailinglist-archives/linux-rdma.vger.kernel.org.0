Return-Path: <linux-rdma+bounces-19796-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGrxKCmp82m+5gEAu9opvQ
	(envelope-from <linux-rdma+bounces-19796-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 21:10:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4229B4A74A3
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 21:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6EEAE300A64A
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 19:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C445E477E40;
	Thu, 30 Apr 2026 19:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="IRHsw43s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3467B47DD55
	for <linux-rdma@vger.kernel.org>; Thu, 30 Apr 2026 19:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777576228; cv=fail; b=i2xGxG1ZzwChtpKXb2/0iHnoDSmDaG+18CH9QeMAmE14VYOZksuGPjZ0jtWg6a0KFcYwj/LqfBBwngTAT6572BPRIAaMRg9aO6dhR3rUsoseVsgUC3gmHDnV4XpNbcbv1tKLGAaXwAcp/vvDar46STbhrLONWRbXMRuf76oYI1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777576228; c=relaxed/simple;
	bh=GM6WcHtx881RaFrZp0KDrK0gbgvJf43B+18WIhdj130=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GFmse8h5KYUJqqK9ASAQ85zVcXlTLtSKyT155+ySNO6WM02frOgcmF8g3cCb52ailYUSkVOIuNNSpoVlsygL07CcsRm2H2WYTf4C8oVmOn/GJ6sKeoPpb7ELMyDFc71ZH6Xvidkh2zRP2ZWU49XXacida+bg3yGzrCaURCbA6uA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=IRHsw43s; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UG7Ppc2069537;
	Thu, 30 Apr 2026 19:10:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=GM6WcHtx881RaFrZp0KDrK0gbg
	vJf43B+18WIhdj130=; b=IRHsw43s2HWEDqkYGD5QY+2698+68xUJqVOEajaOo5
	XO+UDH9bIzPxlkHJT+ca4oVJNX055ezQzd8s2exkw1RcYltZHe0RQC8RLCo+8P4v
	kdj07/WIiyp35TookIaWOzlBP4QBhrxF+pMOAY/zrhtVBRm55pb/yJKmeBr11D+T
	sTv6zbRrrsYZiCqnRRz8Bcko05vw05/3FtBmOUNftzMiavyyaDcil7IkMhCxKef5
	/NAr+XS7QgqnSWS6I0TYMussy1tOjbdNmIWuvlvnuoZH4GNNmUWzSAD5F5uNzc7p
	PjEeKQzVRfDUm7fXKyN9k2spQ7Wijb/GLkBnd6PDz0SQ==
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4dvaawj4wf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 19:10:13 +0000 (GMT)
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 304E02FCF9;
	Thu, 30 Apr 2026 19:10:12 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 30 Apr 2026 07:09:41 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 30 Apr 2026 07:09:41 -1200
Received: from SN1PR07CU001.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 07:09:41 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UGgW3u4aGOLn66utFN79vr8mOu+DQG8pe8N4XsVNGZWmtnj16FfSfpyE/IbC+rYdPKyyLbyY4dlwF2fX9sd+e0/pHRX7yFwZQUnC2GKi/3ypnhLIZavu5idg9DS2dGKqLYtMSxUxfwhS3tIH0g6lAuBJVgSzXlHT9E3EZRGNTlq+wVj1Wms0EH+HNDPRaFkVRgL8+vQuHoyHl4Wbn9Iuw+aReADdwSAhTTm2xC/sJKmN8itcevWpR92M7ziY2/JlU8728/WfXKHPpaWgUsZ/ES/PC4wh8Cv49/omau/OD0C7FqV46iwV1NlcwKpQmPE8MsySZHjg+Sh43iUzBxpn5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GM6WcHtx881RaFrZp0KDrK0gbgvJf43B+18WIhdj130=;
 b=ER5ZiEY3+d4kclX0bFh/3st7e5+dHfYCVR0uAOj2p+uHhWcxfuruR5UdSZtGzjYvWQvW5Zw0nhK2sIhIBd5+ejdTaBGBV9yawufHjpiOa9AVICF2Fer4v1FkAK+wyoEUdREE6Hxnq8NvmTWZ2Ystpg08uqqtMOGPp2OeqeNm5g5jxOfxdBpv0ee0V9SbOrJKJARHUuUyqnRj9SfHzEYr8D8cgAh8c4wtAS2hkkUaKFuS9EBFWNhT9daJJcGwNnfBY8bxs7ryvsdzl9Pmp/MstVYTt7FZrhRlR2f0DsRUiHYQc3ETtWR3BrHQSE2E+JELrh7QRVTO+zWJgxJApGp+CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB3970.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:225::20)
 by DS0PR84MB3747.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:1a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Thu, 30 Apr
 2026 19:09:40 +0000
Received: from DM4PR84MB3970.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d136:e75e:53c5:73d8]) by DM4PR84MB3970.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d136:e75e:53c5:73d8%4]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 19:09:39 +0000
Message-ID: <d3994658-d679-4205-8b59-a6888bcbc144@hpe.com>
Date: Thu, 30 Apr 2026 13:09:36 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v2 1/5] RDMA/core: Add Completion Counters
 support
To: Michael Margolin <mrgolin@amazon.com>
CC: <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <sleybo@amazon.com>, <matua@amazon.com>, <gal.pressman@linux.dev>,
        "Yonatan
 Nachum" <ynachum@amazon.com>
References: <20260416212327.18191-1-mrgolin@amazon.com>
 <20260416212327.18191-2-mrgolin@amazon.com>
 <2bfaa4cc-8e4f-43ad-a483-36ac1ae3caea@hpe.com>
 <20260430121833.GA30363@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
Content-Language: en-US
From: Doug Ledford <doug.ledford@hpe.com>
Organization: Hewlett Packard Enterprise
In-Reply-To: <20260430121833.GA30363@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------4DT0si0vogzEcG8UO3bcn1z3"
X-ClientProxiedBy: SA9PR13CA0168.namprd13.prod.outlook.com
 (2603:10b6:806:28::23) To DM4PR84MB3970.NAMPRD84.PROD.OUTLOOK.COM
 (2603:10b6:8:225::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR84MB3970:EE_|DS0PR84MB3747:EE_
X-MS-Office365-Filtering-Correlation-Id: 2abf7624-12d1-42b2-b25a-08dea6ec0757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: PkQwzzyhfmLaV8zD8J7ZfPY6fodyczOZZfyazDKPooROvFILarkQVzCKsubXCoU6mQsqb1NK7EpSMJayQWj5JwJBLVsy+CZlIkbxBy3XOrtIQFnJdRfJZ6WIzUsp7Duu0Y+krSlrtZA8XL6cfa1ujKUqtWpKbYy+f1fCtBuram4pxOes1soe4DDiD4oSvpFS2nfVg/9JX3lztpfUX0OQq2hS0/aul1J6pplbfzC5MutvjpPqA1MbJRYVFmEvdzdb9eRWsIQ/aRGeApvCcCOUP2RhtZ+EyHAG8X6q9huvtNpp7FXyLB6sdZmckD+pPS/7qieefBxAUwdLr0MQ7T45jDHNJRvoe51CjlzMVhX7B7eVsdF/OVyBKcFTfaK+dMgHpAzXEs4YGYV3SjMHnfA8aR2wyxShZVi1dExIWptQr2NSvKdsIuWAv4apOE7c39o05iTGbxfdZkEsPGNhyoBT7uwbtI+Fu0KVRHKXAdjcqS4NRBoGaMWlQmozSkN8H1KwHrKWJ/vcMez2qU6J7DnQCXpACYVzyd9ICU5G6WhQp+bOsKBnj/4gjT87VIlO/egO67JuyHGY0dO8w8C8wpnoLLJrzEYcARJUsd8xP0opmO/id9mr1G7dHL+IYstxx4LSA0r7Jj2IjpkrscdVkpFgzVZj8gtpdyBlzqovQhRgcLsYVDn0vop1kZh2px9kUOlO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB3970.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0hSdm1JczNHelV2ZnpEaWtTeW1oZ1JDL0tqZXZRVkR4Nmh3SlZiK1lvQllj?=
 =?utf-8?B?dUtHVW5MSXFBRDl4cDQ3aVg4MVBtbWZ1OWtmQ3dCVGdJdjlVZFlqS3NBLzl6?=
 =?utf-8?B?UVVwelFKN1pqWFErOVVDQ3psdGU3L2hjbjEwQ0NxcVFqZVYrc2ZtVHhzbWFF?=
 =?utf-8?B?bTA1OU04OVdmV25uaHJ4NDQyZWlJaWczc0lkaEZQcUkrcFQzbSswZWNja2pV?=
 =?utf-8?B?cDBZMVM5NFBpOUZKcjZHUmY1bTQyQ1pyRTc1UzJ0TWsyUEhVdmg1ODgvYTdh?=
 =?utf-8?B?UGNLV1N3UnhxNXkyYlJ4SzJ2b0NZV2ZpQkZNYjVlR0xycmhnNEh4bllnM0tW?=
 =?utf-8?B?NmJJbTVtOTNXUE9VUldIa1E4RTFzb2I0bGJWbSt3NGZIWDB0VHJhRU5OQWVC?=
 =?utf-8?B?alIzc3V6V0JNYWYyb01JREVBU2VqZm5aKzlZVEE2REpYSDlkNEo5V1VRTE9U?=
 =?utf-8?B?RHJlVGorelhNRkdrbFUxSERXSlVwWEVZaVBCV2p3WEpOczRRN00zTDJaS0kz?=
 =?utf-8?B?dEJ1N2FoRFVaV2ZPWXVZWk1jU0FkVDEvd0d2bENMMTRPdXkvQytJQzV6M0xW?=
 =?utf-8?B?c25qd0QvZTd5RHh2VG5KTTN0WEpjanVoWUdobWVGSUdHcjZmWVNJR2lIeXYz?=
 =?utf-8?B?cGI3SEZmcG1mcVo1RXRzUCswQlh6cmtqMTgvMkw5MTR5cE5UdWRmak15ZzMv?=
 =?utf-8?B?S3JsaDZsV3FhdlVOU3JNUzZyL1dKQlRZRTNpaDlUWGZLazdLcy83OTZYMzVC?=
 =?utf-8?B?T1VJRFNZd3l5WC93b2VwU2tWWHoyMGJ0RlFsRGdzR053cSt1NmpyVWk2Qml6?=
 =?utf-8?B?aGFrVHlJbzRTSUhwMmRUekNqbWxrZjJPZjJxaFpLbCtPNzB0ZkZ5VTh6RUt4?=
 =?utf-8?B?OFJHTVBkdnZRZDR5L0x6NkRCRTRIQ2JWNWQrU2JUVlVLekpHQnpFQk9TeTAx?=
 =?utf-8?B?QUFwNTYxN21pOHpGeU9aK3JGTUdCWE4yM1dBOTcrN2VkVE5YS1lPVzZWbytN?=
 =?utf-8?B?YW9pY2p4Z0c2SnRXNTZXZGM4ei82RFJiUWs2eFNyTThXZU5GVXJGZVJTOExG?=
 =?utf-8?B?UGs2SVp5cjI4SHRLVGZpakNmdHdpSVhxWXpQcHQrNStHM0xyaFJ2UmFjZmo2?=
 =?utf-8?B?MmJQQXgremxBTnVwSWROcUtLQ0VjaEVVRXJzb3pLZDJONlJ4RDF6WEk5b2Y0?=
 =?utf-8?B?ejJiSVpYL25YTjdLYVdSUkYxTGJjS1FDeURmMUhLTVpZOVlyMURXY0lFY3M0?=
 =?utf-8?B?MDRaQTlVLzdYTlZudDRKekdqSW1kb1BBc1lCNGtVamV0RGEzMjVWZkpnV1Fm?=
 =?utf-8?B?U0FhakRTMnF6dGtVdmJLRG54TFNOQTJmY3ZHdC9hREZIWWIzeGZFUElZVTV0?=
 =?utf-8?B?aHBuV1NJc2VhUlArbmhVa2ZEdFhmUHVZb3dZV0ROcWhUU3ZLcnFFSCtxYk5V?=
 =?utf-8?B?bGFuUzF2bDZtZzI2MkhTL3JKeUczOWQ3SlRITlNvdEpPR2tkeU9TMHRGRkpY?=
 =?utf-8?B?WXZjdXJ2NWw3OTJYaHhFb3BISDdDSUIxdU9CbzNIUlk5ZE0yWkw4akVCajBj?=
 =?utf-8?B?RDNXTUVoTmIwOHFEZGJQVXBicWlHZkNWc2MxRVR3clJ5TmY1KzhiT3RqUHFn?=
 =?utf-8?B?K3RaZFA5NGw0OFM5bjNOalIvazRYSWVieTFNYWdSZXpOQzYwTGhUelVqWm5E?=
 =?utf-8?B?RVNxMCtnWkdOMVVldTl5Vzgwem8zTTI1QTlDNlUzd1dlY0dEZnhUSVU2akFX?=
 =?utf-8?B?aW5VN1I5Y05UdjhUaVB4cDhsMWhJdzBUK1dsTGR5aXAyc2M4cVBmN2pRaHVK?=
 =?utf-8?B?QTRaeHFDUTA1R1Fub3c0eFlGeXJ4M1lVMExCamF3N0NEQkUwdG9NYnB1RHBQ?=
 =?utf-8?B?REE2MEwzMnZXTWFpSzlOVFNVbE1ZdGVidXFXdUVXOVhQMHdNOXp3Wk5IdHRB?=
 =?utf-8?B?Vjd1VEs4WUdJa1hDZW8rTTZxYTdBVThmL1dJSEZlazB5ZXRtbHduYWJFKzZ2?=
 =?utf-8?B?TmhQYjFVTXNWUnd0eVNBekliQmlERytkaDIzY05Xelp3Vk1MdG5GeVFKOU5w?=
 =?utf-8?B?blRwWEk3VWNrQ2R1SHU4WTErcDh6NHBXQU9DV3RZaUV0ZmplOUN6RUFFZE9Y?=
 =?utf-8?B?VHI2all3OVB5VXVydnJ1SVF2T29vTG5lWDZucVVDZy92OU40d2tpd2RVMjZx?=
 =?utf-8?B?SjRYSXZheTc0bDU1Q2RCVkRxWWZ0ZWFTY3oxRzRIYVR3aEpsTGY0K3h3WGtp?=
 =?utf-8?B?cHJvemd6ODJoNE9yVGo3QWtoT05IZnVaMTZ2YURiNURJZnBQanlEaVd2bWdJ?=
 =?utf-8?B?RlhkUGJ5OWZuN1lsUVZPQUZ0VWxRNXVYVG9ZaU9iK3dPaXYzWjQxdz09?=
X-Exchange-RoutingPolicyChecked: rwKne+F9t4dywc4tYBvdbhLQQsr96yvM8jpm+CydCb6NeWk4uFbVVQqdsarENSw2L3/XrXSgbYd9v+Xyyn0pA9ReGgQW6dzMpSoQUo/7O9MtAm6XCnerHAPmYeMIHB5XwZdr0FYftIuoomSEbnWke8dRemUIBQ0/0zwhcsmAMYh+5FsHg9EMC8uX0IIkGeGtB3kAePeii8RjuJSgPnkXWJ1kdy6wbu47a3mChW4Nwt0aA0yMa0jQ1XdghFFxWkpXPfMACv2Br7KmhFfyyN1i/sztxj9lDMjnhrchK6m+kECcw9/tkAuzmYyBY1acby+y40RkIaGK/tFqXKxzvqJvCg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abf7624-12d1-42b2-b25a-08dea6ec0757
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB3970.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 19:09:39.9438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N3oARR3yWGIOg2nBihswOI1or4tI+wlduHgC+s5lCAzGkR3G+KbiH9JjqXbn7YezQVJ7FOA/Bb/c4ftUFTspag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR84MB3747
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: xkrskGxhTAoH1YWIcGR5rWl2iGWhyChg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDE5OCBTYWx0ZWRfX/5pbEUWITLUi
 i3NjmE2G4jahiy/yq9y+A+W1d8YE7JppUWAeXPRPhTlb11SDVlrH1LL+iz0E59YxX6Y70aS6sag
 ScCCxoUa75TsA2x5mvQF5OEgnRYoNlXL8WxKzIAZz8caRaLFIGVsCylU8Yv75mEmxDwVu9KaWnu
 ARsy1b3VXnOpPPEbMRqZk7iPK5z9vX6SkoI4v3xChbc0MnXLPZzFE2LmdjaVOr6WJmIYwYimYCQ
 y9KkoY21uMYkhuOOZJHVhYCZ9RMiJVHAOuI0nHitUT5wNV0dD9LuMIhjzFD9WQyNDF8fcGmmB4s
 LL0GjJ5duzdVQTbxRNpmljJK3oVHb/HhK+plrfIpVv9usnnGR0yCz7KF63xtkjFNtthVXdeoOYF
 NkU6H8T41TMkB7mo4u+k57uLotE5BOlRm319rlVgklRb5khQE+S/RRAzECzWJ1LSCEjCvNyPZyu
 m/2yBe/V0TzcrK9xkPg==
X-Proofpoint-ORIG-GUID: xkrskGxhTAoH1YWIcGR5rWl2iGWhyChg
X-Authority-Analysis: v=2.4 cv=Z9Pc2nRA c=1 sm=1 tr=0 ts=69f3a916 cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=RtSn8ETxjE2H05FtM2s8:22
 a=MvuuwTCpAAAA:8 a=srIgodG4zUmpM4kqPkIA:9 a=QEXdDO2ut3YA:10
 a=Y5pxICiv21gRUBJ7u-EA:9 a=FfaGCDsud1wA:10
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300198
X-Rspamd-Queue-Id: 4229B4A74A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19796-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[hpe.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doug.ledford@hpe.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[11]

--------------4DT0si0vogzEcG8UO3bcn1z3
Content-Type: multipart/mixed; boundary="------------d3sVu85cS9HN9uSUcUgSHnRa";
 protected-headers="v1"
Message-ID: <d3994658-d679-4205-8b59-a6888bcbc144@hpe.com>
Date: Thu, 30 Apr 2026 13:09:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next v2 1/5] RDMA/core: Add Completion Counters
 support
To: Michael Margolin <mrgolin@amazon.com>
Cc: jgg@nvidia.com, leon@kernel.org, linux-rdma@vger.kernel.org,
 sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev,
 Yonatan Nachum <ynachum@amazon.com>
References: <20260416212327.18191-1-mrgolin@amazon.com>
 <20260416212327.18191-2-mrgolin@amazon.com>
 <2bfaa4cc-8e4f-43ad-a483-36ac1ae3caea@hpe.com>
 <20260430121833.GA30363@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
Content-Language: en-US
From: Doug Ledford <doug.ledford@hpe.com>
Organization: Hewlett Packard Enterprise
In-Reply-To: <20260430121833.GA30363@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>

--------------d3sVu85cS9HN9uSUcUgSHnRa
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNC8zMC8yNiA3OjE4IEFNLCBNaWNoYWVsIE1hcmdvbGluIHdyb3RlOg0KPiBPbiBXZWQs
IEFwciAyOSwgMjAyNiBhdCAwNjo1MDo1NFBNIC0wNjAwLCBEb3VnIExlZGZvcmQgd3JvdGU6
DQo+PiBPbiA0LzE2LzI2IDQ6MjMgUE0sIE1pY2hhZWwgTWFyZ29saW4gd3JvdGU6DQo+Pj4g
QWRkIGNvcmUgaW5mcmFzdHJ1Y3R1cmUgZm9yIENvbXBsZXRpb24gQ291bnRlcnMsIGEgbGln
aHQtd2VpZ2h0DQo+Pj4gYWx0ZXJuYXRpdmUgdG8gcG9sbGluZyBDUSBmb3IgdHJhY2tpbmcg
b3BlcmF0aW9uIGNvbXBsZXRpb25zLg0KPj4+DQo+Pj4gRGVmaW5lIHRoZSBVVkVSQlNfT0JK
RUNUX0NPTVBfQ05UUiBpb2N0bCBvYmplY3Qgd2l0aCBjcmVhdGUsIGRlc3Ryb3ksDQo+Pj4g
c2V0LCBpbmMgYW5kIHJlYWQgbWV0aG9kcyBmb3IgYm90aCBzdWNjZXNzIGFuZCBlcnJvciBj
b3VudGVycy4gQWRkIGENCj4+PiBRUCBhdHRhY2ggbWV0aG9kIG9uIHRoZSBRUCBvYmplY3Qg
dG8gYXNzb2NpYXRlIGEgY29tcGxldGlvbiBjb3VudGVyDQo+Pj4gd2l0aCBhIHF1ZXVlIHBh
aXIuDQo+Pj4NCj4+PiBUaGUgY3JlYXRlIGhhbmRsZXIgY29uc3RydWN0cyB1bWVtIGZyb20g
dXNlci1wcm92aWRlZCBWQSBvciBkbWFidWYgZm9yDQo+Pj4gZWFjaCBjb3VudGVyLCBmb2xs
b3dpbmcgdGhlIENRIGJ1ZmZlciBwYXR0ZXJuLg0KPj4NCj4+IERlc2NyaXB0aW9uIGhlcmUg
ZG9lc24ndCBtYXRjaCBpbXBsZW1lbnRhdGlvbi4gIFRoZSB1bWVtIG9yIGRtYWJ1Zg0KPj4g
aXMgb3B0aW9uYWwsIHdoaWxlIHRoaXMgcmVhZHMgdGhhdCB0aGV5IGFyZSB0aGUgb25seSB0
d28gb3B0aW9ucy4NCj4+IElmIG5laXRoZXIgaXMgcGFzc2VkIGluLCB0aGVuIHRoZSBjb3Vu
dGVyIGlzIG9uIHRoZSBoYXJkd2FyZSBhbmQgdGhlDQo+PiByZWFkIG9wZXJhdGlvbiBpcyB1
c2VkIHRvIGdldCB0aGUgdmFsdWUgKGFzIHBlciB0aGUgY29kZSBhbnl3YXkpLg0KPiANCj4g
VGhhbmtzLCBJJ2xsIG1ha2UgdGhhdCBwYXRoIG1vcmUgY2xlYXIgaW4gdGhlIGNvbW1pdCBt
ZXNzYWdlLg0KPj4NCj4+IFdoaWNoIHJhaXNlcyBhIGRpZmZlcmVudCBzY2VuYXJpbyBvdXIg
aGFyZHdhcmUgZW5hYmxlcy4gIFdlIGNhbiBwYXNzDQo+PiBpbiBhIHVtZW0gb24gY3JlYXRl
LCBidXQgdGhhdCBkb2Vzbid0IG1lYW4gdGhlIGNvdW50ZXIgZXhpc3RzIGluDQo+PiB1bWVt
LCBpdCBleGlzdHMgb24gdGhlIGRldmljZSBhbmQgaXQgaXMgY29waWVkIHRvIHVtZW0uICBJ
ZiB5b3UgY29weQ0KPj4gaXQgb24gZXZlcnkgY291bnRlciB1cGRhdGUsIHRoYXQga2lsbHMg
UENJLWUgdXNhZ2UsIHNvIHdlIGhhdmUgYW4NCj4gDQo+IFdoeSB3b3VsZCBpdCBsb2FkIFBD
SWUgbW9yZSB0aGFuIHdyaXRpbmcgQ1FFcyBpbnRvIGEgQ1E/DQoNCllvdSBkb24ndCBuZWNl
c3NhcmlseSBzaWduYWwgZXZlcnkgc2luZ2xlIGNvbXBsZXRpb24sIGJ1dCB1cGRhdGluZyB1
bWVtIA0Kd2l0aCBldmVyeSBzaW5nbGUgY291bnRlciB1cGRhdGUgaGFzIHRoYXQgZWZmZWN0
LiAgSXQncyBqdXN0IHVubmVjZXNzYXJ5IA0KUENJLWUgYmFuZHdpZHRoIGNvbnN1bWVkLiAg
QW5kIGl0IGhhcHBlbnMgdG8gYmUgaW4gYWRkaXRpb24gdG8gYW55IG90aGVyIA0KQ1FFIHVw
ZGF0ZXMsIGV0Yy4gIEZyb20gb3VyIGV4cGVyaWVuY2UsIGl0IGFkZHMgdXAgd2hlbiB5b3Ug
aGF2ZSBsb3RzIG9mIA0KY291bnRlcnMuICBXcml0aW5nIGV2ZXJ5IHVwZGF0ZSBvdXQgZm9y
IDEsMDAwcyBvZiBjb3VudGVycyBkb2Vzbid0IHNjYWxlIA0Kd2VsbC4gIFNvIHdoaWxlIHRo
ZSBBUEkgd29ya3Mgd2VsbCBmb3IgeW91IGFzIGl0IGlzLCBubyBkb3VidCBpZiB3ZSBzaG93
IA0KdXAgaW4gYSBmZXcgbW9udGhzIHdpdGggb3VyIGhhcmR3YXJlIHdhbnRpbmcgdG8gZG8g
c29tZXRoaW5nIHNpbWlsYXIsIHdlIA0Kd2lsbCBiZSB0b2xkICJ5b3Ugc2hvdWxkIHVzZSB0
aGUgb2ZmaWNpYWwgaW50ZXJmYWNlIGZvciB0aGlzIiwgc28gd2UgDQpuZWVkIHRoaXMgaW50
ZXJmYWNlIHRvIGJlIGFjY2VwdGFibGUgdG8gb3VyIHVzZSBwYXR0ZXJucyBhbHNvLg0KDQo+
PiBvcHRpb24gdG8gdXNlIGEgdHJpZ2dlciB0byBvbmx5IHVwZGF0ZSBvbiBhIHBlcmlvZGlj
IGJhc2lzIChidXQgdGhlbg0KPj4gdXNlciBzcGFjZSBhdXRob3JzIHN0YXJ0IHBvbGxpbmcg
b24gdGhlIHVtZW0gbG9jYXRpb24gYW5kIGtpbGxpbmcNCj4+IENQVSBjeWNsZXMsIHNvIHRo
aXMgb3B0aW9uIGlzIG5vdCBwcmVmZXJyZWQpLCBvciB0aGVyZSBpcyBhIHdhaXQNCj4+IG9w
dGlvbiB3aGVyZSB5b3UgY2FuIHNldCB0aGUgdGFyZ2V0IGFuZCB0aGVuIGluIHlvdXIgYXBw
IHVzZSBhIHdhaXQNCj4+IGNhbGwgdG8gd2FpdCBmb3IgdGhlIGNvdW50IHRvIGJlIHJlYWNo
ZWQgKHdlJ3ZlIGZvdW5kIHRoaXMgaXMgYWJvdXQNCj4+IHRoZSBvbmx5IHBlcmZvcm1hbnQg
d2F5IHRvIGltcGxlbWVudCB0aGVzZSBjb3VudGVycykuDQo+Pg0KPj4gQWxzbywgd2UgZG9u
J3QgcmVhbGx5IGF0dGFjaCBjb3VudGVycyB0byBRUHMuICBUaGF0IGlzbid0IHVzdWFsbHkN
Cj4+IHdoYXQgd2UgY2FyZSBhYm91dCBjb3VudGluZy4gIEdpdmVuIHRoYXQgb3VyIEVQcyBh
cmUgbm90IGNvbm5lY3RlZCwNCj4+IGNvdW50ZXJzIG9uIGl0IGFyZSB1c3VhbGx5IG9ubHkg
dXNlZnVsIGZvciByZWN2IG9wZXJhdGlvbnMgd2hlcmUgeW91DQo+PiBjYW4gZ2V0IGFnZ3Jl
Z2F0ZSBkYXRhIGZvciBhIGdpdmVuIEVQLiAgRm9yIHNlbmQsIGl0IGlzIG9mdGVuIHRoYXQN
Cj4+IHdlIHJlYWxseSB3YW50IGNvdW50ZXJzIG9uIGEgcGVyLWZsb3cgYmFzaXMga25vd2lu
ZyB0aGF0IHdlIGhhdmUNCj4+IG1hbnkgZmxvd3MgdGhhdCBnbyB0aHJvdWdoIHRoYXQgb25l
IEVQIChzb29uIHRvIGJlIFFQKS4gIFNvLCBmb3IgdXMsDQo+PiB3ZSBjcmVhdGUgYSBjb3Vu
dGVyLCB0aGVuIGR1cmluZyBvdXIgc2VuZCBvcGVyYXRpb25zLCBpZiB3ZSB3YW50IGENCj4+
IHNwZWNpZmljIHRyYW5zZmVyIHRvIGJlIGluY2x1ZGVkIGluIGEgc3BlY2lmaWMgY291bnRl
ciwgaXQncyBmbGFnZ2VkDQo+PiBpbiB0aGUgY29tbWFuZCB3ZSBzZW5kIHRvIHRoZSBoYXJk
d2FyZSBmb3IgdGhhdCBzZW5kIG9wZXJhdGlvbi4NCj4+IFRoYXQgaW1wbGllcyB0aGF0IGEg
cHJvcGVyIHBsYWNlIHRvIGhhbmcgYSBsaXN0IG9mIGNvdW50ZXJzIGlzDQo+PiBwcm9iYWJs
eSBvZmYgb2YgYW4gQUggaW5zdGVhZCBvZiBhIFFQIGZvciB1cy4NCj4+DQo+PiBJIHRoaW5r
IHdlIGNhbiBleHRlbmQgdGhpcyBBUEkgdG8gc3VpdCBvdXIgbmVlZHMsIHJlbGF4IHNvbWUg
b2YgdGhlDQo+PiBjdXJyZW50IHJlc3RyaWN0aW9ucy9hc3N1bXB0aW9ucywgYW5kIGJlIGdv
b2QuICBCdXQsIGFzIHRoaXMgaXMgYQ0KPj4gdXNlciB2aXNpYmxlIEFQSSwgaWYgaXQncyB0
YWtlbiBhcy1pcywgSSB3b3VsZCBzdWdnZXN0IHRoYXQgdGhlDQo+PiByZG1hLWNvcmUgcG9y
dGlvbiBiZSBtYXJrZWQgYXMgZXhwZXJpbWVudGFsIHVudGlsIHdlJ3ZlIG1hZGUgdGhlDQo+
PiBjaGFuZ2VzIG5lZWRlZCBmb3Igb3VyIGhhcmR3YXJlIGluIG9yZGVyIHRvIGF2b2lkIHVz
ZXIgQVBJIGNodXJuLg0KPj4NCj4+IFRoZXNlIGNoYW5nZXMgY291bGQgYmUgc3VtbWVkIHVw
IGFzOg0KPj4NCj4+IDEpIE1ha2UgcXAgYXR0YWNobWVudCBvcHRpb25hbA0KPiANCj4gVGhl
IGF0dGFjaG1lbnQgaXMgYWxyZWFkeSBhIHNlcGFyYXRlIGNhbGwgdGhhdCBjYW4gYmUgYXZv
aWRlZC4NCg0KWWVzLiBidXQgdGhlIGNvZGUgdGhhdCB0ZWxscyB0aGUgdXNlciB3aGV0aGVy
IG9yIG5vdCBpdCBpcyBzdXBwb3J0ZWQgDQp3aWxsIHJlZnVzZSB0byByZWNvZ25pemUgdGhl
IGZlYXR1cmUgd2l0aG91dCB0aGUgYXR0YWNoX3FwIGZ1bmN0aW9uIA0KcG9pbnRlciBiZWlu
ZyByZWdpc3RlcmVkLiAgU28sIHdoaWxlIGl0IG1heSBiZSBvcHRpb25hbCB0byBhdHRhY2gg
dGhlIA0KcXAsIHRoZSByb3V0aW5lIHRvIGF0dGFjaCBpdCB0byBhIHFwIGlzIG5vdCBvcHRp
b25hbC4gIEkgd2FzIHJlZmVycmluZyANCnRvIHRoYXQuICBJIG1lYW4sIHdlIGNvdWxkIG1h
a2UgYSBzdHViLCBidXQgaXQgd291bGQgbGlrZWx5IGp1c3QgcmV0dXJuIA0KLUVPUE5PVFNV
UFAgb3Igc29tZXN1Y2guICBBbmQsIHRoZSBBUEkgYXMgaXQgc3RhbmRzLCBkb2Vzbid0IGhh
dmUgYW55IA0Kd2F5IHRvIGNvbnN1bWUgYSBjb3VudGVyIHdpdGhvdXQgYXR0YWNoaW5nIGl0
IHRvIGEgUVAuICBJbiBvdXIgY2FzZSwgd2UgDQp3aWxsIGJlIG5lZWRpbmcgdG8gYWRkIGFu
IGV4dGVuc2lvbiB0byB0aGUgYWxyZWFkeSBleHRlbmRlZCBBSCB0aGF0IHdlIA0Kd2lsbCBu
ZWVkIGZvciBVRVQgYW5kIGluIHRoYXQgd2Ugd2lsbCBhdHRhY2ggdGhlIGNvdW50ZXIgaGFu
ZGxlIHRvIA0Kc3BlY2lmaWMgZGF0YSB0cmFuc2ZlciBjb21tYW5kcyBhbmQgdGhhdCdzIGhv
dyBvdXIgY291bnRlcnMgd2lsbCBnZXQgDQp1cGRhdGVkLiAgRm9yIHRoaXMgcGF0Y2hzZXQg
dG8gdHJ1bHkgbWFrZSBhdHRhY2hpbmcgdGhlIGNvdW50ZXIgdG8gYSBxcCANCm9wdGlvbmFs
LCB5b3Ugd291bGQgbmVlZCB0byBhZGQgYW5vdGhlciB3YXkgdG8gY29uc3VtZSBpdC4gU28g
eW91IHNheSANCml0J3Mgb3B0aW9uYWwgaW4gdGhpcyBwYXRjaHNldCwgYnV0IGl0J3MgcmVh
bGx5IG5vdCBhcyBmYXIgYXMgSSBjYW4gdGVsbC4NCg0KPj4gMikgRXh0ZW5kIGNyZWF0ZSB2
ZXJiIHRvIGRpZmZlcmVudGlhdGUgYmV0d2VlbiBvbi1jYXJkIGNvdW50ZXIgd2l0aA0KPj4g
dW1lbSB0YXJnZXQgYW5kIGluLXVtZW0gY291bnRlcg0KPiANCj4gQ2FuIHlvdSBlbGFib3Jh
dGUgb24gdGhlIGV4dGVuc2lvbiB5b3UgaGF2ZSBvbiB5b3VyIG1pbmQ/IFRoaXMgc2VlbXMg
dG8NCj4gbWUgYXMgYSB0b3RhbGx5IGRyaXZlci1kZXZpY2UgbGV2ZWwgaW1wbGVtZW50YXRp
b24gZGV0YWlsLiBFRkEgZm9yDQo+IGluc3RhbmNlIGhhcyBkZXZpY2UgbGV2ZWwgY291bnRl
cnMgdGhhdCBhcmUgYmVpbmcgc3luY2VkIGludG8gdGhlDQo+IHByb3ZpZGVkIG1lbW9yeSBv
biBlYWNoIHVwZGF0ZS4gT3RoZXJzIG1heSBjaG9vc2UgYSBkaWZmZXJlbnQgc3luYw0KPiBz
dHJhdGVneS4NCg0KQWxsb3cgbWUgdG8gYmFja3RyYWNrIGFuZCByZXBocmFzZSBzb21ld2hh
dC4gIE15IG9yaWdpbmFsIGNvbW1lbnQgd2FzIA0KYnJvdWdodCBvdXQgYnkgdGhlIG1hbiBw
YWdlcyB0aGF0IHNheSwgaW4gYSBudXRzaGVsbCwgdGhlIGNvdW50ZXIgDQpyZXNpZGVzIGlu
IHVtZW0gYnV0IHlvdSBjYW4ndCBtb2RpZnkgaXQgZGlyZWN0bHksIHlvdSBtdXN0IHVzZSB0
aGUgDQphY2Nlc3NvciBmdW5jdGlvbnMgdG8gbW9kaWZ5IGl0LiAgVGhpcyBpbXBsaWVzIHRv
IHJlYWRlcnMgdGhhdCB0aGUgDQphY3R1YWwgY291bnRlciBpcyBpbiB1bWVtLiAgSSB0aGlu
ayB0aGF0J3MgaW5hY2N1cmF0ZS4gIEFzIHlvdSBzYXksIHlvdSANCnN5bmMgdGhlIGNvdW50
ZXIgdG8gdW1lbS4gIFRoZSBjb3VudGVyIHJlc2lkZXMgb24gdGhlIGRldmljZS4gIFRoaXMg
aXMgDQpyZWFsbHkgd2h5IHRoZXkgaGF2ZSB0byB1c2UgdGhlIGFjY2Vzc29ycywgb3RoZXJ3
aXNlIGFueSBkaXJlY3QgdXBkYXRlcyANCndvdWxkIGp1c3QgZ2V0IG92ZXJ3cml0dGVuIGxh
dGVyLg0KDQpTbyBhbGxvdyBtZSB0byByZXBocmFzZSBhczogUmVtb3ZlIHRoZSB3b3JkaW5n
IGluIHRoZSBtYW4gcGFnZXMgdGhhdCB0aGUgDQpjb3VudGVyIGlzIGluIHVtZW0gKGFzIGl0
IHJlYWxseSBpc24ndCksIHRoZW4gYWRkIHNvbWUgb3B0aW9uYWwgY3JlYXRlIA0KZmxhZ3Mg
Zm9yIHN5bmMgbWV0aG9kIGFuZCBmcmVxdWVuY3kuIFdpdGggdGhlIGNvdW50ZXJzIHJlYWxs
eSBiZWluZyBvbiANCnRoZSBkZXZpY2UgYW5kIHN5bmNlZCB0byB1bWVtLCBvcHRpb25hbCBz
eW5jIHRyaWdnZXJzIG1ha2VzIHNlbnNlLiANCkRvaW5nIGl0IG9uIGV2ZXJ5IHVwZGF0ZSBj
b3VsZCBiZSB0aGUgZGVmYXVsdCwgYnV0IEkgY2FuIGFsc28gc2VlIGRvaW5nIA0KYSBzeW5j
IG9uOiB0aW1lciBpbnRlcnZhbCwgY291bnQgaW50ZXJ2YWwsIHNwZWNpZmljIHRyaWdnZXIg
ZXZlbnQgb2YgDQphbm90aGVyIHNvcnQsIGV0Yy4gIE9yLCBjb252ZXJzZWx5LCBqdXN0IGJl
IHByZXBhcmVkIGZvciB1cyB0byBicmluZyB0aGUgDQpvcHRpb25hbCBzeW5jIHRyaWdnZXJz
IGFzIGFuIGV4dGVuc2lvbiB0byB0aGUgYmFzZSBBUEkgbGF0ZXIuDQoNCj4+IDMpIEV4dGVu
ZCBjcmVhdGUgdmVyYiB0byBwYXNzIGluIG9wdGlvbmFsIHRyaWdnZXIgb3Igd2FpdCBjYXBh
YmlsaXR5DQo+PiB0byBwZXJmb3JtIGxpbWl0ZWQgdW1lbSB1cGRhdGVzIGJhc2VkIHVwb24g
cGFzc2VkIGluIG9wdGlvbg0KPiANCj4gSSB0aGluayB0aGlzIGNhbiBiZSB2ZW5kb3Igc3Bl
Y2lmaWMgZXh0ZW5zaW9uIHJhdGhlciB0aGFuIGEgY29tbW9uDQo+IGludGVyZmFjZS4gUHJv
dmlkZXJzIHRoYXQgd2FudCB0byBzdXBwb3J0IHRoaXMgbW9kZSBjYW4gZWFzaWx5IGFkZA0K
PiB0aGVpciBvd24gInVwZGF0ZSBmcmVxdWVuY3kiIGF0dHJpYnV0ZSBpbiBjcmVhdGUgaW9j
dGwgb3IgaW50cm9kdWNlDQo+IGEgInN5bmMiIHZlcmIgdGhhdCB3aWxsIGRvIHdoYXQncyBu
ZWVkZWQgZm9yIHRoZSBzZXF1ZW50aWFsIHJlYWQgdG8NCj4gcmV0dXJuIGFuIHVwLXRvLWRh
dGUgdmFsdWUuDQoNCkl0J3MgYWN0dWFsbHkgYSB1c2VmdWwgQVBJIChmcm9tIGV4cGVyaWVu
Y2UpLCBzbyBJIHdvdWxkIHByZWZlciBpdCANCmRpZG4ndCBoYXZlIHRvIGJlIHZlbmRvciBz
cGVjaWZpYywgYWthIHdlIGRvbid0IHdhbnQgcGVvcGxlIGhhdmluZyB0byANCmN1c3RvbSBj
b2RlIHRvIG91ciBoYXJkd2FyZSBmb3Igc29tZXRoaW5nIGdlbmVyYWxseSB1c2VmdWwuICBJ
IHdvdWxkbid0IA0Kc2F5IGl0IHNob3VsZCBiZSByZXF1aXJlZCBmcm9tIGFsbCB2ZW5kb3Jz
LCBidXQgSSdtIHJlbHVjdGFudCB0byBtYWtlIGl0IA0KdmVuZG9yIHNwZWNpZmljIGluc3Rl
YWQgb2YganVzdCBhbiBvcHRpb25hbCBleHRlbnNpb24gdG8gdGhlIGJhc2UgQVBJLiANCkkg
YW0sIGhvd2V2ZXIsIHBlcmZlY3RseSBoYXBweSB0byBwcm92aWRlIHRoZSBleHRlbnNpb24g
dG8gdGhlIGJhc2UgQVBJIA0KYXMgb3Bwb3NlZCB0byByZXF1aXJpbmcgaXQgYmUgcGFydCBv
ZiB0aGUgaW5pdGlhbCBwYXRjaHNldC4NCg0KPj4gNCkgTW9kaWZ5IHJlYWQgb3BlcmF0aW9u
IHNvIHRoYXQgaXQgY2FuIGVpdGhlciByZXR1cm4gdGhlIHZhbHVlDQo+PiBkaXJlY3RseSBv
ciBqdXN0IHRyaWdnZXIgYW4gYXN5bmMgdXBkYXRlIG9mIGEgYnVmZmVyIGJhY2tlZCBjb3Vu
dGVyDQo+PiAoZXNwZWNpYWxseSB1c2VmdWwgaWYgdGhlIHVtZW0gY291bnRlciBpcyBvbiBh
IEdQVSwgaXMgc2V0IGZvciBhDQo+PiB0cmlnZ2VyZWQgdXBkYXRlLCBhbmQgeW91IGp1c3Qg
d2FudCB0byBmb3JjZSBhbiBpbW1lZGlhdGUgYXN5bmMNCj4+IHVwZGF0ZSkNCj4gDQo+IFNl
ZSBteSBzdWdnZXN0aW9uIGFib3ZlLiBJIHRoaW5rIHdoYXQgeW91IGRlc2NyaWJlIGhlcmUg
c2hvdWxkIGJlIGENCj4gc2VwYXJhdGUgY29tbWFuZC4NCg0KV2UgY2FuIGFkZCBhIGZsdXNo
IGNvbW1hbmQuICBTYW1lIGRlYWwgYXMgcmVhZCwgb25seSBpbnN0ZWFkIG9mIA0KcmV0dXJu
aW5nIHRoZSB2YWx1ZSB0byB0aGUgY2FsbGVyLCBpdCBmbHVzaGVzIGl0IHRvIHdoYXRldmVy
IHRoZSANCmRlc3RpbmF0aW9uIGlzIHN1cHBvc2VkIHRvIGJlLiAgT3IsIHRoZSBzZW1hbnRp
Y3Mgb2YgcmVhZCBjb3VsZCBiZSANCm1vZGlmaWVkIHN1Y2ggdGhhdCBhIHJlYWQgYWxzbyB0
cmlnZ2VycyBhIGZsdXNoIGlmIHRoZXJlIGlzIGEga25vd24gdW1lbSANCm9yIGdwdSBtZW0g
dGFyZ2V0IGZvciB0aGUgY291bnRlci4gIEVpdGhlciB3YXksIGFsdGhvdWdoIEkgdGhpbmsg
SSBtaWdodCANCnByZWZlciB0aGUgZmx1c2ggdmFyaWFudC4NCg0KDQotLSANCkRvdWcgTGVk
Zm9yZCA8ZG91Zy5sZWRmb3JkQGhwZS5jb20+DQogICAgIEdQRyBLZXlJRDogQjgyNkEzMzMw
RTU3MkZERA0KICAgICBLZXkgZmluZ2VycHJpbnQgPSBBRTZCIDFCREEgMTIyQiAyM0I0IDI2
NUIgIDEyNzQgQjgyNiBBMzMzIDBFNTcgMkZERA0K

--------------d3sVu85cS9HN9uSUcUgSHnRa--

--------------4DT0si0vogzEcG8UO3bcn1z3
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAmnzqPEFAwAAAAAACgkQuCajMw5XL91h
nw/+P9Y0hPLmtz4YSbyaDlfHDkDVnd8YdRmAicf96RPH7uL8WZ7eGPYgiubCVZ/SQMRJc5mFfZHx
wRRZn8d+Xkk8WWKD/h8042Byeg7WLlWYIxIRXjCAHXhkLFYYMrzyeOpMjrWozrhSw7jwidTL90rq
6HNxFSG27Pt7X4QMHxTdr1WvfmOOIZUUjIfHdqIZFlsLwuoEKlv+LXgH4BNfyTOey/TBNImDi4g1
K6zc9KwsoseS8WVJTRF8g8iXnDyrcDFEG5Ha/Z41dliQxXaT7FVlGu9qmuucky9H0rdIbofZ4z7r
mBcfy5nI4F5VOEuTeR64a9Myh0/UcZO/5GuSelPXFJesMz0JgqjOQ0pwuo7qBHNveBZaKwMlbToY
+oQSO5YbBNeW4k81j6zgSow7OjWM7QSRFBHTtkgKLJNl0eS+mccHCEsfIz2aF+VjtPW4e7DdddcJ
muFRUIsC3NuiMwWrUrJZpg0IWf5uAXOwaW5/GgTEQ26C5jMA264F0NomyHbDLfq224DNowC++D0I
+IEEFAS/n0Jk8cAw0H/aSBSim2MuhMLAXGY5L6VB4tASVZ8UgNbS3he1j5fMgKRP7s5+TPlZGTpa
3Rzxvu6MGrDoVAIsqS5/rO62OF6I++VCzZ6PvEuX2m9jmoNE7CK/ehcbypLMDI2LPN7CJlRZvi3J
0aM=
=vyhj
-----END PGP SIGNATURE-----

--------------4DT0si0vogzEcG8UO3bcn1z3--

