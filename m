Return-Path: <linux-rdma+bounces-4187-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03618945DD2
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Aug 2024 14:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3741284278
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Aug 2024 12:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405011DB44A;
	Fri,  2 Aug 2024 12:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GHksCyin";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mP42Gqd6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD7B1E505;
	Fri,  2 Aug 2024 12:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722602061; cv=fail; b=AE2qBtGcjWuePbTeZRTS6nG9g5ALTTvYbMZAeepcu+RniPSgrIa4XxGD6Ja8E9mJ2rvp5pHQUIZ26elRU2SL2zLzKVT6RQ+nK+z02FdI9sg/1PPOC7vkOuWbhyJ8foBsrrYvrv6PiocH7ay+3NuaRy6Q+QLEzQm7Za5sYoXYY0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722602061; c=relaxed/simple;
	bh=5GPH2qcR7y7+E9s4QL141C9t4jYU8/ojzVlBUqRt7N4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P1/bDkJuoYp5kvAckWUHw0AM2Eg1a1CtUw3jrg5HOZx6MZpIAIxKOGTGTK86QF7exowB0SNCpIqp/0RxBi0f4av8fRgdILmXMLO4tW0KPZX+gALHN18GlbJquhLB9RJZ9/NEvGga0rcvwp5Vt2XNWbkJGQrFrInyPpg9ixu9jeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=GHksCyin; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=mP42Gqd6; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1722602059; x=1754138059;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5GPH2qcR7y7+E9s4QL141C9t4jYU8/ojzVlBUqRt7N4=;
  b=GHksCyinmffM8Tc9o5XHZjgxmGtvogQrpyy9N5KwrSfC1wWnCcQEjVcA
   Hq0WXZX5jhWRQ2aZaO6iTJYKeXnyPHJZnt42aOK8pwtjOfURvlxM8dMeJ
   NVY0jb++EhZ2hvlVRVZB8P1Q2nfWHBWBlaVSzFgT6JgZt7vHgM1pIY8fe
   aN7NJ7ABB+akX0O1kPOr5HH4BQZDwSrjaLcU1VJBsw8YrZ3bZB35BBUmH
   Q6jv+YZ4rJ2j4wFKHA7rofeWmrm7Giz4WJr6m5P1dLHsbxOpaImZesBzj
   Qczkvou+c2OGOk5A9yiVda9+552uaiRqW0M0HZhwgeC0LhSsG38QxtYBH
   w==;
X-CSE-ConnectionGUID: FVivJEj6SBaMQPyw3edEiw==
X-CSE-MsgGUID: AtSbiAtIRu+vLQcGdJ22aQ==
X-IronPort-AV: E=Sophos;i="6.09,257,1716220800"; 
   d="scan'208";a="23296219"
Received: from mail-westcentralusazlp17010007.outbound.protection.outlook.com (HELO CY4PR05CU001.outbound.protection.outlook.com) ([40.93.6.7])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2024 20:34:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PnEEzdHHlWOOm/8H/SdUptBKNCgb/myyIC/O4jVEQXlJoEGlrdVBx9/yeVH0ZaSD8aOUpqGE0tK9QKNMlkDHV1uYVhDkDb3wKEp6YZ2DWRfed+bbFfkslbGiA289Gt6bnSJs/np71N7H90PJ9aBYT/8ukRYWtbwkczPkILdGaBkyCHLfjjqtavlLbCjZWcHr59ubkHcK17wBZgfIQklvOjsusjmCaO4YgUJ5KX+Nm/pYpwfI51Q4wAt46gl8UaSWbNz6cWmcN3l/7AoFSg6zPUWOCKNtk33lPyFmPTbKvFzHBVZKgasYxYxkfBd7mGoaplHZVGAtehzPtnsLEfwpgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1Puj5frYY/2nv4aHCbSVCjhJwxE4aZwT9aFA9qxp3c=;
 b=pxfmXALvIx0zSrXmUBppzLMB6Av+tl1v3AgsE0m+JtQv78CZW/MGocd05MpTcded0ASTxGE6q7Ads/Oy5EvBoT/wzgYDkFjh5spPumXAIlo8rbn4Ej23fnOQ2UeDtrjBYhcZkoNzV1HDPnYhSki05k5uN0ZMI/wfHWX9yx8c/f3q0/6n4WhztcxyFJvpG1UlomrjweP5Aq3O+6oNiHAGx3GyiqYhnqiKxJRcaqa5A880elX2Q8GzuXtUgbuB+RP3/iILXph4EpynZfX1HLLGO9Zl29Huu49VA64Kkgs6h4q7MIskbrfC+YzmGvg8EUITBTlquASs3uLoSuQdexn9Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1Puj5frYY/2nv4aHCbSVCjhJwxE4aZwT9aFA9qxp3c=;
 b=mP42Gqd6DAUYeq470To3XiwyzV/jq6VfrD5xFiOJJ95y8I0Un/jCqB9wCSZ4FY1nmDRDqWJhdHZpEsgaFp5SnqiTZN2m4nPM2jdNV0iotxr7nyEgYIj/I8OLkQpSqktSrCVt6WOvgsTysQ7lMYGfFGGhxgqpRlY7fLKpMK5RVJc=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH4PR04MB9388.namprd04.prod.outlook.com (2603:10b6:610:244::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.24; Fri, 2 Aug 2024 12:34:09 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.7828.023; Fri, 2 Aug 2024
 12:34:09 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Nilay Shroff <nilay@linux.ibm.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: blktests failures with v6.11-rc1 kernel
Thread-Topic: blktests failures with v6.11-rc1 kernel
Thread-Index: AQHa5LuxC+CuFbi0TEaEvvPM0kqq9rIT4jmAgAAE2QA=
Date: Fri, 2 Aug 2024 12:34:09 +0000
Message-ID: <ljqlgkvhkojsmehqddmeo4dng6l3yaav6le2uslsumfxivluwu@m7lkx3j4mkkw>
References: <5yal5unzvisrvfhhvsqrsqgu4tfbjp2fsrnbuyxioaxjgbojsi@o2arvhebzes3>
 <ab363932-ab3d-49b1-853d-7313f02cce9e@linux.ibm.com>
In-Reply-To: <ab363932-ab3d-49b1-853d-7313f02cce9e@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH4PR04MB9388:EE_
x-ms-office365-filtering-correlation-id: 58b3d122-086e-4e79-6fcd-08dcb2ef680a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2lUTfjUxkyyM42VMrAB62bfI4PRgNjkrgFYovOXijrpvI7cy/BBPpeBBJRZz?=
 =?us-ascii?Q?lXHFKcNMrCNQnGIiLg9Kn+Gxrk/aBZtyPR9cQijjI+ol7hOKpMV/W/3t6aAX?=
 =?us-ascii?Q?P2VPmm9jbDUhwUa2mpzcNy1whRntvpAQMqZkyaLuxfAv60qWe2kelfYW49dt?=
 =?us-ascii?Q?z4kOxL0yuZiX8uIKUNtuJ5PazDhBX8KexGMOXIliBI4abTXYhlDlar8ie/xb?=
 =?us-ascii?Q?/603noTu6J9/HV3GUOjsgBDpnMhbibJd7RBdcPseDCl/sYoBmEmrph1GAFkv?=
 =?us-ascii?Q?tCI9/2+85DypquB01J0fkaYW6hdGVl3CXDN0uZo+ORHf2zoNaB7Hdj8zqNQ1?=
 =?us-ascii?Q?iD5gqtsKxKu73MulvImymqQoDU+hg1EuJWdGW66aBNKZwTvgDdwfM5iMs3Q2?=
 =?us-ascii?Q?b5b08QW2DhgBsdzo/MvNXqTtSQVFzl7CCCf84NYtaOiT9NRHfbs5/mrczo/B?=
 =?us-ascii?Q?ZR6YxWMrF8LBXYqDMecXlQldy55KLKf7krTUBcl8uMWVgUh2LWYgji4DPplJ?=
 =?us-ascii?Q?g2LOrqYjWt7ObWLxwpKOGjmMyqN4jGFbW4px//eDliuM2HRY+dybiqzUFo+B?=
 =?us-ascii?Q?O/ZYZlrGOC32zBdQXwRDTICh6FV1SBTmPZHUxFoQ5VZbE+5cknPSqTgFbGU9?=
 =?us-ascii?Q?IPeiAiSM6RJFmbWbQhTGiiLw9fjsqGqLi6WVHWFfO9K5nzwde9cGGvvYUpIS?=
 =?us-ascii?Q?uf6dYg1Th0KRE5jTdKn8SADf9pxsg0GVyODfWTeIOANx2JjijIhD+sLa0Hje?=
 =?us-ascii?Q?c2b+pQ3CnfgUIG3Uk+E4PXDqv6HcttkNRm996SQ/ieqm9IoCl+brmfQMViCW?=
 =?us-ascii?Q?CtMX5F7rDgsxl9CiBFukPJcYQpEUJ1uqMU/0gP2VERg2IciuVI2mvMlyBSDo?=
 =?us-ascii?Q?a0t3aHQq/bOx83tQPdN5fOMNelBOTbRrIBzxP99vXvvVMfaD/VqqMzUPXyDT?=
 =?us-ascii?Q?mueEcjfuVy3vkbm/uIxZbYwHhQr023qrKDIcQhmEEUzuIJCVpNvSDqm+ai2v?=
 =?us-ascii?Q?Er55pVByw2rsJq2m/q4i7AOD46XLjfSGBnDwPuSp4amLaFTIlOXU4xDGhVFa?=
 =?us-ascii?Q?g21UF8vjoHQbzkxXU8TC5KS9OS2P2BTenPgeYS469BabJFyrNb0DdkJ5i4rL?=
 =?us-ascii?Q?sc7Nl/dPStzooQElSQzSJbJO+ipLe1vPwe6jgYqZx4kYsN++7fQqZmZ/3pRS?=
 =?us-ascii?Q?LtQM3rSXO85mbGMXLcLREnKd79lpegHUVr2M4iRUcJS/+SyWgKarOV9GeNZa?=
 =?us-ascii?Q?ruvWqQikN+rCwsPM4ay9jXvU523Zrph/dWyCHFJOnD5Dp19qM9OaP644Wo1R?=
 =?us-ascii?Q?O+5UnjTxg9ts0lTCmU2nbyA03lve1pBcP6nLDxO8jEIDZc/lJV1SLU4NJ8LC?=
 =?us-ascii?Q?VGtItaI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nVb4ZPP8Z3ALDqYmTJImGr838LuphBugQjDack7mrHrjhiZJWT/HzQvmMxWB?=
 =?us-ascii?Q?u6pnetPIc4Z7tbZ6PynWh4j/FE10rwBxVJgj1j7JwRaNMqSvljMaxltFkoCh?=
 =?us-ascii?Q?iW1/RWyIlKb8uo+xiIrJm4/I5qRSZkbn27WXWkwTzaFp0+c+1K2qgby7xq+E?=
 =?us-ascii?Q?RGsWt+gXBQT2mP9dimOTB1xvRICrovv7V5+bkUoVDvtHbw1IXKfVHpMZTRnj?=
 =?us-ascii?Q?HgLuIISGGqCdBMDKDfjSwlpIopCH8Fb1+TXItPEV/8da4ow4pBU2V8YY7Ql0?=
 =?us-ascii?Q?BsNUwVMjfABrxzUSxnF8MjmdwfJad7f/psw2LEH8dQy7KpyqlSKlqPSAp4ES?=
 =?us-ascii?Q?jzt+BobGrHLHLJdHzJSILUcum873WZtyvyVLUKAXEPNrDOrqBKYn6hNzqwZr?=
 =?us-ascii?Q?TDdM+iMWHlGRBZnevbEzuoeDRKTj5vkPNuJsswT1y3MHsEWE+rlCZFEb55SO?=
 =?us-ascii?Q?00XwInec6IEYb6UWwIxa2juUFAaKO9M02/spWOiIOsocoq+zPCzgGZYw8o8j?=
 =?us-ascii?Q?VNexRJpUzkV0l1I68oWxLeJbWu9WF4igXgZ/9/JEzRD5FaY+D9HCS1gxjgJZ?=
 =?us-ascii?Q?/2gg62cFHiPI6Mgg9fkr2E+dmUV611yLDsrcqByDqsKBIOmtBlVTlhiU4fgt?=
 =?us-ascii?Q?3K72Q9bHZd2dfTn4bFeLrxAbauj/dFjf97IBpFAvjww2HNfWAmdv3AF3otuB?=
 =?us-ascii?Q?qUz2ReEqcL+0ptr9clsG+B6qQclLGMEFApZM8laJzeOIE7UKjUKntFMnQn2G?=
 =?us-ascii?Q?9EhVAJua3pn7Tx2/eWT5VPhTD2p3WVue57GywTDi+YHXaUumES6l6BvD/CNi?=
 =?us-ascii?Q?JtKIPycMAT/4jsZzk9deM2Bg+LT69ucRHexAtxpTdCBme+TVMaMMntW45jl5?=
 =?us-ascii?Q?h/+QlvZKciGQ84o3x8lfZj4AYzz3lke8BmRS6KZPPcg9kPW9JXbpA1gmkGeo?=
 =?us-ascii?Q?znncmPlcT15VpKYUPktepGwhZ0eEsRaNB3Tnf6RXTBDZ28wgwCEP89CDBAAs?=
 =?us-ascii?Q?HU3vKaZXyDzwJJgkwvcs+1mkuIIol0Y8xL0r3qI+ukIm1MOupQ3bI1mROZEv?=
 =?us-ascii?Q?o1ogPFwJpuuzdt6wKfde3JU+R6i1lbKT/VrfhonZj3suceSwimelA286B1G+?=
 =?us-ascii?Q?puXr9ok9F8wvqLAc5DEunhdZTtrjt/Do1jmvUH6Wh1cN35GeXTFFEp8jMQ2L?=
 =?us-ascii?Q?dq/l5ibKJ/MG76zZ8uMi56qP256EfmcjptFdn6I9fJerOnDBNxSyLpHPVrFQ?=
 =?us-ascii?Q?RIF8Mg1N61/8YBQX0rUak3ghVP+6PBsWZ+q0DpYnq/fUJBGaOrn77yRm95Cy?=
 =?us-ascii?Q?fI2vBQ9t8Nnsqy8IpYWorBoEGPE2hPEzC+4lcjFLUGYzkiH1j8+814h5nSgt?=
 =?us-ascii?Q?9fmrR38er9dhZGpZmYaXZAa4J2tDomPAX3x/vsJR+8f/qPo3oNLkQKSfO01D?=
 =?us-ascii?Q?fiqLPLK09NxhnSLbFBbg/vAkidEHcH8HyAj1Q1pad4oDxVfxkTc705HPy+iz?=
 =?us-ascii?Q?NYi67IjwLt12QtIxCcfEzmQNN9l/kdlbNrGpivLHRhiKASU96fyt6U1sDxTP?=
 =?us-ascii?Q?yOqlnBQmaSACAryWwu9L35lK4c5f2ucKFeTB0MTHOAR8yPcuSLmAr2t10atG?=
 =?us-ascii?Q?Zp5K7gTmS9xIMpAh5Z0mp+Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20A850B433B02D4E91A419169CBFD41F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8I+UpY+fYZ+KWn1ueBweNpHEcD5V7fsITErFNtEzckeNqmU2naVwDUiDOltTGtbO7V4ssd8LQpcriHzfJK9FQc+9LJnyy1p2G2NdIEvw3VU32lNCUtn0Sy64EMcF+tnDQlNHC2QKV5sqW5vbPMSTkPV1HcV6SGf8H5uBipuvW9VvaWfdUbCBEor1h8MKYT+9je5LGfYAH82IsUHG0iZnoPmO7fu4F6ESXXuH9+heUMVgKMPYi9AgGtIkAPpmtc2m77tkKXvIbVgfRAXLfd2rlAoPXEgebPBteOBKVaIPrXJqZmgrQ6nXLbAMq7fmzey/PoPEHUR8P2JRmsacOWfa3xATAVPpMjI/d/sIQPqCIwRM7nBx/GTyxS9ftDaB4RlJBZ+9bcD1L32AvCRccyvcd825o3oObhAHgBoqH0x3E0mJNpkIFtuge375TDuLEugBKrIkCeeMJQzvJvKXc70yKTx9GFMOZOmwOHxp/vtvxKikk2V+f5vO5+nO5e8YqaRhB/7VnHmPOkiNu3nngzW0SiFFvUMj5hw7sbK1yDw3nnU7tkw/QcP7w48Nbp1QeAJoM8d/50/zf5gisJ7In2cszDtciwKgslHAPRP40ug1/CWuHlkfr2AXTsOzfDWvhaCg
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b3d122-086e-4e79-6fcd-08dcb2ef680a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2024 12:34:09.2155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9elpUcbHS8VXFBMUjWCuY0jQEPE6psnJ4T3ns9BhRbFeLAqWUvc1CvMdpbQgkZmA0Gz/EDm7sy+34mjSt30MV+VPfsZ/WLpa2tFSHfGP18A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR04MB9388

CC+: Yi Zhang,

On Aug 02, 2024 / 17:46, Nilay Shroff wrote:
>=20
>=20
> On 8/2/24 14:39, Shinichiro Kawasaki wrote:
> >=20
> > #3: nvme/052 (CKI failure)
> >=20
> >    The CKI project reported that nvme/052 fails occasionally [4].
> >    This needs further debug effort.
> >=20
> >   nvme/052 (tr=3Dloop) (Test file-ns creation/deletion under one subsys=
tem) [failed]
> >       runtime    ...  22.209s
> >       --- tests/nvme/052.out	2024-07-30 18:38:29.041716566 -0400
> >       +++ /mnt/tests/gitlab.com/redhat/centos-stream/tests/kernel/kerne=
l-tests/-/archive/production/kernel-tests-production.zip/storage/blktests/n=
vme/nvme-loop/blktests/results/nodev_tr_loop/nvme/052.out.bad	2024-07-30 18=
:45:35.438067452 -0400
> >       @@ -1,2 +1,4 @@
> >        Running nvme/052
> >       +cat: /sys/block/nvme1n2/uuid: No such file or directory
> >       +cat: /sys/block/nvme1n2/uuid: No such file or directory
> >        Test complete
> >=20
> >    [4] https://datawarehouse.cki-project.org/kcidb/tests/13669275
>=20
> I just checked the console logs of the nvme/052 and from the logs it's=20
> apparent that all namespaces were created successfully and so it's strang=
e
> to see that the test couldn't access "/sys/block/nvme1n2/uuid".

I agree that it's strange. I think the "No such file or directory" error
happened in _find_nvme_ns(), and it checks existence of the uuid file befor=
e
the cat command. I have no idea why the error happens.

> Do you know
> if there's any chance of simultaneous blktests running on this machine?

The error was observed in CKI project test environment. I'm not sure if suc=
h
simultaneous runs can happen in the environment.

Yi, in case you have any comment, please share.

> =20
> On my test machine, I couldn't reproduce this issue on 6.11-rc1 kernel.

I tried on my two test machines (QEMU and baremetal), and couldn't reproduc=
e
either.=

