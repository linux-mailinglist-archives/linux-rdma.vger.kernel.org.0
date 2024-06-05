Return-Path: <linux-rdma+bounces-2871-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2542E8FC4A8
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 09:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4F6D1F22138
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 07:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A391581E2;
	Wed,  5 Jun 2024 07:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jESFLapK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RTiQE2E4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A5A6A03F
	for <linux-rdma@vger.kernel.org>; Wed,  5 Jun 2024 07:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717573009; cv=fail; b=Mw5GEXyTUXYNf5h0Ka6V94oiEl1qDS1oTpRrQb7RSI2XRCY8TmkUe/OjR/t8fxseBsalrOMA/L+pZ7ufoosN2Xj1PJpecAujE+UP22Mx9ngS14/CzCKCOK0MsF3piJ0gvLf6BWJ6hUqOb+m1tMpjAJyXzIwTTbsZxWW2zNHZxzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717573009; c=relaxed/simple;
	bh=SxzI6aE2phtvCI6HjnwIiOl9AlFxSERY8cXWTSbDV6E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vsfj2x2Y4PSzAzUPKOGBIz+6VfW+mBNloAPqUUJvoqeUYzOpFLchZr0llo+h2GfirIRLuQzv4aGtTdiv/jU2ceDL2N50hxxKdcRnKcEn73C/iAj6vFqT+5xtk6cqA8fWjwh9IuS6ZLoq91KsxZGzrFy0HiG6fFFyFn9R58znWAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=jESFLapK; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=RTiQE2E4; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1717573007; x=1749109007;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SxzI6aE2phtvCI6HjnwIiOl9AlFxSERY8cXWTSbDV6E=;
  b=jESFLapKSXD7XCRYWfaQZGXOC7sCaTtm7wMxS4f8mlgHTvE4agmtVG3S
   //sd3ppJmjJ4Y8yP5uRqBaKibPLWb7yKX+gE6sl6A5d7uH+8Yr04FQaGI
   kVcOlvZyR6DaOoryTiyqLSFE1Do25phzlFinAyOLlS61qwKGt5hj3D1G5
   77/54J+NffS0zopdYi24IIagaHphIPYTVTvFZW3lWYRk5Z+MMfGx3oiW9
   v7gsstPKvrOg17PWZbPqpZ4MboJtOSfOCF31lYfH4tfsuxkMWLD8Hl8jw
   HX6ezBsAY+AMLO+oLSVU6bIdPWBm0Vqtx/1mUnteRGQUmMH2ob8APPAga
   g==;
X-CSE-ConnectionGUID: nv3ouyAPRZeSKl8yUQ6jbA==
X-CSE-MsgGUID: Gj2nNMaOQSm/ZtAMxH9EHQ==
X-IronPort-AV: E=Sophos;i="6.08,216,1712592000"; 
   d="scan'208";a="19100715"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jun 2024 15:36:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgTyHkqry/Q9AQvtDq9PGB6kl0YxezbARMBr0nLsQm46CCi4VO6JcWaoFf03yP/5vV3f75KtnASpsXn8XeEdEWCiBq2e6WoD77KrnHL9XS7ASA5mRDzsbVwy9NUJfE7lVo9L3klZpf/B3DDww7wNxIQMf58pXIAznKuBUnd1uZVtL7huKs6EDgWcYq4YZMJFvBuKZ77ZmiTzPMt0zFA4i5ajyACE63wc8nXp6cXFCm5JAxaZ/CASixJNDEA5WahqGWlH+dfduEGqlCT/+P+GzB+qZhSKYy97i7+AIxcTHuZgSRrxSEKiLvaORIUoUo2YvQ5xkH22FnExTxQnBNfWRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=az+ukmsl1qV848b3bJ+lvpQZrFbf270x5GWreSeGCVE=;
 b=bzAz+Fh2RZ9tADAIWNEhUz/yfSjHP9rH3jO52emPwaNmwy3sS63gpWsuSE/3oK3HZLub72n1sZPPnDnbUdE68qoQLaOzVhPixMf9vEDc6HE9RC3O9idC/ekrHjZpg87ijULviaowLXVXVjds0O8nP0goE+ioViCZTxRkYXdUxWU/QitZFZA3bxcdCprFDdHWwz9mdLt843vjnpTW10qo6JkdOt6xuWnbYGV5Xiop7VAxmcAkYg5J5nQMrVaQiUYJqhb7u++SgdhApbT+4vUCicm0zYAGDjn8gkiOKsJbeZLg+E08HJZb0cc4uOYCcb8BoVfKom9563UspALP9fHtkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=az+ukmsl1qV848b3bJ+lvpQZrFbf270x5GWreSeGCVE=;
 b=RTiQE2E46B+1ZqWGQ2m+y35DL+fTKo7a8JhQ0SEHxi7+fqqRlY0scfsut/KdVR/RRajmdGkhN3AkLHGcwLS8zzBjTk8PaGYXIZX/PPTJbBJLqG1SMI6IsbaUYZoaIaKuuuP2debZCqPwGbRSualEigon8jc1//8SOuuZYxfLa10=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 IA3PR04MB9302.namprd04.prod.outlook.com (2603:10b6:208:51b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Wed, 5 Jun
 2024 07:36:37 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 07:36:36 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: Zhu Yanjun <yanjun.zhu@linux.dev>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
	<leon@kernel.org>
Subject: Re: [bug report] KASAN slab-use-after-free at blktests srp/002 with
 siw driver
Thread-Topic: [bug report] KASAN slab-use-after-free at blktests srp/002 with
 siw driver
Thread-Index: AQHatlBevjdEqNl9WEGGLP8JyoPSxrG3VfQAgAC1YACAAL46gA==
Date: Wed, 5 Jun 2024 07:36:36 +0000
Message-ID: <jzdak3w4hocia3bxwj5h6x4k5jeujwzqtua54ty4vrdyzje4zq@5bsdgmndfndf>
References: <5prftateosuvgmosryes4lakptbxccwtx7yajoicjhudt7gyvp@w3f6nqdvurir>
 <6bcbe337-c2fe-46ee-8228-a3cff6852c28@linux.dev>
 <a21021bf-6866-466b-a924-2f465fbb2e64@acm.org>
In-Reply-To: <a21021bf-6866-466b-a924-2f465fbb2e64@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|IA3PR04MB9302:EE_
x-ms-office365-filtering-correlation-id: 672d9adf-37c0-4170-3222-08dc85323b4a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?D7k17OSyYMLiIqEXAlkq52W++N/CUQCMVYNG0T0AObH4TAh0Cld9MafljkLX?=
 =?us-ascii?Q?2YoC2isRjlOwGnxRd/CBUSG78kGAq0wv5hvcW/p7ZY9mZ0b1UBbmO/F8idwm?=
 =?us-ascii?Q?+DVBThuKBnq5W1a0eLVGHz1oI2+qTf9vuYSNTRs2cTNTw2eX9sfsHCUxzSRW?=
 =?us-ascii?Q?haMmEhmxFLGqRtTq3wV278DQ41kre7Kesb//sGm3y2wIyrnHgkGTCrDohTL3?=
 =?us-ascii?Q?y+O5XaJNNlHt3DOvqaF61ipmLb4Ge/uqKybc2a5XCxh+BQwmuAbebOTE+/RB?=
 =?us-ascii?Q?7A5GL2HywZ2QoYGol5h+QwLbpi/F9aWRciBL25+NHRx4knWYQUJ7J6N1kGvp?=
 =?us-ascii?Q?9A4D33HU83H6R3SOMNIVEIuT411dMT6Y7KkGLMsbVJVYlo5azT+8zS+TUJRe?=
 =?us-ascii?Q?5HxVJUukobU4qgw2eJjxbCXZRp4KL0P9x2ZmTbFFxmYgiS5njshDY4C+zsWZ?=
 =?us-ascii?Q?GQgA8dyjQJ/7Iy0HZxpaFpIfAweO2X3lKQGRSGuOeDDYA2oC1PYeJNntxR9o?=
 =?us-ascii?Q?fQIQIrdilwgunqgXRYgJ7wGgMlWQ+dt3ZwsVrg4oZAxhl7/LjtGXMVTfCTQE?=
 =?us-ascii?Q?vQ38IrOQOMEN7h8Sta/Qocy/qvFMijGnvUI3KCq2j0OXcRMtotJ2rN/627Q6?=
 =?us-ascii?Q?eLNg2Q1V4k0Pp9AzLVkYYEvbIGs9NStmDbF3yUlAzEi5wM4w4qKTA3emNSXO?=
 =?us-ascii?Q?5Hi0p6JyeqTy+5Wjvxt5wNuQWb7wXyR5gsmZrTKXS9cCOQZJUjKlHZArUbMP?=
 =?us-ascii?Q?o1PC2bDMSjt7ZkhkFn3GmClBiiqgjkAgUbzt5tLthQZnaUwDBtu56ZkMCGnL?=
 =?us-ascii?Q?NVRYYg8z5dLRwt+vLS0/4QLinnA3olLXOqUO9m6YmOjmfN8NjZ4xtvaxA0eY?=
 =?us-ascii?Q?KPNecGxosIZUMMmN/pXnLU87eRRgejmZQukf9z9EDmJ2/sG8aINGlKb7m4a1?=
 =?us-ascii?Q?ZhW99Rb284kj+jrGiQwuUqV23jpMDo6/SFHsyTw01Aecy/79zYwEh1s+eEs8?=
 =?us-ascii?Q?fNbnVUXZPlKbkmlnTFYEkfk7JXLwJPHUMuznzk1bXFtkIEcHMcXZ+SuHIenb?=
 =?us-ascii?Q?xecNfsjyZ5PgjuePCCU89YfpD23oDQhDYL5jPE55MR5BkxkHd3sA0rK0sTDB?=
 =?us-ascii?Q?k9DNfCdYj3htUTAvfW3G8H+YsrWP56LbEsAVmTcDETRFIuIvY+Y5x5hVZDXo?=
 =?us-ascii?Q?RpLNXM/uz6hX+8A4FqMXzQWx/tJ6n6BTPIWNgOYfI3HE/k7Nb+oExDt24IGi?=
 =?us-ascii?Q?fNEyKz0sE7Gb9910cu+3P3ay4Diajkf2Om6Ht+eKa2eGCDDd7Xv00UM31npJ?=
 =?us-ascii?Q?IIqrYItId/D5vMcU+bkuCtZqNTQ2jVknDKhpsTCTzNrTDg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2gi/Oz9nqB7piQCDgrpFjrWOSFWsi2rEfAKuJHW8hFugpcx5Yw1rvawjiqx+?=
 =?us-ascii?Q?bu/3vXzyXqx/2hpJh2SoMBlNvPkadz67ELDg94bsPFUIy1oIO7PyWv92qL2c?=
 =?us-ascii?Q?b6bs4VQd4WYk/g1M3D1gMDzCdLcT+r/zlKrT3qXuIZEDr1QTqvMksjxlLTOh?=
 =?us-ascii?Q?LzEohD2dZR6bAUDNchXEwUQaVTWtFLOeY3oDZKtfLASlUfUU3A1tHN0ocl8K?=
 =?us-ascii?Q?9Z4xKHioAxhZbwKavjXGt5WZTk3iYVIB5J/PF44sHfHLCY+lHsRpo1gTg+fZ?=
 =?us-ascii?Q?xETzYhN2SGlseGVHO2PK3NZbQWLvWLeAJPOk51zOKaVyGqwGMwllQ5e8Uocd?=
 =?us-ascii?Q?Pl5TI81GApX/9JsG5GMGRyziavfCaAZ8iDpCQ79dE87x5PlDrVIS5coQX+lR?=
 =?us-ascii?Q?Wf9qYCXqx92QYPNSeCsPvwSKW7Bk9rUNxUPAJly0gDRF2WtOroZqPP4pWzc7?=
 =?us-ascii?Q?eZOT+J1prS2D8X53FCKaEzdhHJgqhNjG3DZCsD18HiyMgrh2NB2sO6jLadiW?=
 =?us-ascii?Q?HgsWuR0Owjz1O7DNYnXISI7ZLkjxz8E0Q3yuIKPyaI0EykFVckuciTsVz7T/?=
 =?us-ascii?Q?0BaddMPIlm29czC/JGW8IzM51t9wXWHcinb/DtIFmlBOT3CUfp6tIWuLjCfg?=
 =?us-ascii?Q?O3JA5H5GyZ09d2lYy8T29iAsI+bcPFQxngVppJgLV0exaICW8HsalyGUNQfL?=
 =?us-ascii?Q?5LnrrExjxjr7ivIgzRt6xDBpXJGeKUzVN4a89VMvhHd9qYrqUfSQPexQh4Ig?=
 =?us-ascii?Q?6TQI6LaIV1LNx5iMSMpmxf4MFL4VQXe8l/os1SWanDl84p/5ETOu6tV0DcjS?=
 =?us-ascii?Q?x4J/EvahC0kKgTWkRVU25Mdf0SRQY0mfYpZvdrbWoHbO3p4/MBCvp6b6jpAq?=
 =?us-ascii?Q?xOdxTQLb1/HBd1/Oa7z8EArEy6LmI1+42yxfgVRMwyqRlRqOu309T6WcrSTd?=
 =?us-ascii?Q?EJSWkzkp0hV+7uIylCQ4GdLLYKXjxVH/iua8lGDuxg8ENTk6VEwYi9mLdmkQ?=
 =?us-ascii?Q?uSb9/BYAQDNpEPBsSHIzKb76HsjudyEXZ0WZUX8OaZlEVS7rbAV0Nl6ZCVKn?=
 =?us-ascii?Q?bvGHk99JNrv7d5IDR9jrPE28zd9BynYpRVd31CTCYrEKPC8ipYaZnhJqv86y?=
 =?us-ascii?Q?wD6rNITgOJs7JHylHcsdx6Epkhr0HfFNaGn/oZWTrNxOwywikJPz24SjcH7j?=
 =?us-ascii?Q?Snd4qd/RS91ZdYzj48Es+HWd3IOYIDHribGgY5s/+jBmLqSkz2h7TeN9RTG8?=
 =?us-ascii?Q?mzAtxDz3WzTdwyNietfwTl0nEEuALfqAVEGpi9hKHEKgU8ZQpVFesM3BLuKo?=
 =?us-ascii?Q?m1JLZI9rgx0G+YZDCdkp8KpLInTEYuAMXvyCpwSnl/4zBIBIzG33ddBpNUOK?=
 =?us-ascii?Q?HsluJgVTRAGbSzYNwOQmP1mcVZl4Tjey9LyLldVaumpVrtAMPpa23SJXl794?=
 =?us-ascii?Q?Guli4/SFqte1DtBQiCzKqKImi7TRSiINLVmMOQdVJuEEF46so0stCxNQCSA/?=
 =?us-ascii?Q?p8cFXPu81ooEfZsDrtxWOkF3TmvBI/txUbThedIVD4QS+t/9fWR1KkfNaRL8?=
 =?us-ascii?Q?O6KaMrqmNXWnyTrCpJCN7itmRC+AB33FTXHNDCKEj5XhsQLmqgAn/mZIakFw?=
 =?us-ascii?Q?tzafvkqAHdSI5zMiNRGguS0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <747F3F2253BDFC45A22F7BC2B9218BF3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	V+VfJc2EVAtvA1jW2GunliYLI3Rt8y877OAPaDiKvyRjgL92l58nF4HMzfPw08GgaJldCIUsGMKKfHgSNu1RwALQu7gSxcbkxzR1GdewGE+49pg/K9JeZdpY2FvT+EQPhFm6S8v5eN4UmZ6C+HmFwJul3ikGsaPWbnSQHLv6/8yuM45D512CPTcmAPVJJKaKiiIEjzedZcb33Q4zZcPTYxfAQieoUP3m70Qt2hLs7kHMk1OOR5/CutEduW4G0XRDT8gUhxCSxh/9wWtd5MviHGpYY+2S8SKm1LwboGAHPS53T7h+d42jSBdqrezMdG2a55Yi5Wd4nC6OfyDM9Qqt1j0TCc5r8hT2PqF8qIUH4AmHpUibWfRemWv8KtjOtuawDN23OzqgyNLfByzUzggVuIGKHVr+7iMtIj/RVWV0odgehvKDWIdxIIQ9q2n82gzofsdGN8T5Bo60A18K6k++369GsdoAKV0Bx+qH2eufljVuten3EZX3WwhYb7r6n/FoxaIYcJvHdRBzu+vQQYflMheu8ZW5cBxLg3MlGiRcJnsd78+Y/P46dPhB6EkQ7fsZeBEjo2DHygX3Ud4c2zPGY5XI9miIYf/UxcSqHazv1pjJ70Y5opKgIhtVw4yU58zh
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 672d9adf-37c0-4170-3222-08dc85323b4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 07:36:36.8956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7RDPpj+7QJgb3yE5VulZiCFDhw2ZJGdd9s2lrrIatBEQQT3tSQ+Zx/4MY+kJ8cap9vhtpvLCIApJXyyd1bBzLFjNADsvDkXmj2xJXI6tw9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9302

On Jun 04, 2024 / 14:15, Bart Van Assche wrote:
[...]
> From 879ca4e5f9ab8c4ce522b4edc144a3938a2f4afb Mon Sep 17 00:00:00 2001
> From: Bart Van Assche <bvanassche@acm.org>
> Date: Tue, 4 Jun 2024 12:49:44 -0700
> Subject: [PATCH] RDMA/iwcm: Fix a use-after-free related to destroying CM=
 IDs
>=20
> iw_conn_req_handler() associates a new struct rdma_id_private (conn_id) w=
ith
> an existing struct iw_cm_id (cm_id) as follows:
>=20
>         conn_id->cm_id.iw =3D cm_id;
>         cm_id->context =3D conn_id;
>         cm_id->cm_handler =3D cma_iw_handler;
>=20
> rdma_destroy_id() frees both the cm_id and the struct rdma_id_private. Ma=
ke
> sure that cm_work_handler() does not trigger a use-after-free by delaing
> freeing of the struct rdma_id_private until all pending work has finished=
.
>=20
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Thank you Bart, I applied this patch on top of the kernel v6.10-rc2, and th=
e
KASAN suaf disappeared. I repeated the test case 100 times, and did not see=
 the
failure. I also ran whole blktests with my test set up and saw no regressio=
n.

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>=

