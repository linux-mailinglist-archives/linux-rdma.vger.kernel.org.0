Return-Path: <linux-rdma+bounces-5291-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D87EF993E11
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 06:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 111B61C24180
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 04:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC0377102;
	Tue,  8 Oct 2024 04:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VXM68Tvb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cg3AEJ0j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0752B9BB
	for <linux-rdma@vger.kernel.org>; Tue,  8 Oct 2024 04:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728362219; cv=fail; b=ni3hfcawD81H2aVYKzH++I56L404NZ6OybWv0/tC1gAaR8KKD3wcsZxJndF8opIYqXFi7OHb7+FN2ICkPDc7oDemi0JU3yaMVMAXvSb4rPPhJVrsurEUw7DL2+5K73wtCK+RPChPEm9gvzhNIjIG+xop4k5RDWdPlIqAxK4nOdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728362219; c=relaxed/simple;
	bh=dmNL/Rz1Fbhl4lx0xiqaf6JGr6fJFSpHdSekq2sI64A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jR+YkNKqN9UCIe0BILvK7XMyyvsK8oQNbDYn3CxnyqN5lQtIWNZlK1aqrqykV5RE93jxT3Uf3TLIkfqXBKMWMgpaGPP4tlUvG0uWgx8uIzIypiUg+GRin+Hf4TIpD76V8txH7NIYfZPu5hM6gbT5PWcmQoXWItJoCysxpvAnAr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=VXM68Tvb; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=cg3AEJ0j; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1728362217; x=1759898217;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dmNL/Rz1Fbhl4lx0xiqaf6JGr6fJFSpHdSekq2sI64A=;
  b=VXM68TvbGsHaXzKOJLS3yhmKdkrWpzGoBS5N0g9iNii4anULv1nhtBU8
   snerHDPJqdr2C7nDX0XXBuiDdOrmTjJJSmWgalmsviISLX7VIqNb6m741
   N3cRALu1TEcfYZ92erA2OnBlWrRX/aRm/Se8mSMCEMNuuwj858QKsRQrH
   22a73ZcIxDpb6CPMZWuNPWDo4ByNmM1YaqyjAfzTPZfK2E1yaiK6AnqSy
   Ewmvs00m/2EptRidQMJOzFAKzMgduhw+cFuzeaivLoWFmxNc3Ad+NSVhs
   dX+8XRfsu7/45BG0hNaIdTwIthL7u/0z8QvmkRf2jACcZ95GoETMXeRrg
   Q==;
X-CSE-ConnectionGUID: 1elch0vDS8GGhrQEDKLj6w==
X-CSE-MsgGUID: JITbQsT8SOaruuAQcofn1g==
X-IronPort-AV: E=Sophos;i="6.11,185,1725292800"; 
   d="scan'208";a="28466555"
Received: from mail-westcentralusazlp17010006.outbound.protection.outlook.com (HELO CY4PR05CU001.outbound.protection.outlook.com) ([40.93.6.6])
  by ob1.hgst.iphmx.com with ESMTP; 08 Oct 2024 12:36:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OsEzr6E0eFCyZRVfI6ZnxCUgX7YXSprFyGuI6PtGdCwcqw1+mpWV9pFkHQod0dY9+xrQ1rvYhIaaE9I4Mgk0Cxgp4p1l5vXIHnLICuYtOTfa5LDf/bjdFHEr4CDdthQl8R6j9ku0A8w2lDIIn/h+MraZwRTGNYp0JwNhz6FuZToCimh9R6FqmNIIfHqL6W20PCnP+hmoq4KHZi3RJ/NhKwpdmDupgddg1koLM8PGPI6Vnv1ufFF92OMWXskQKCcmXvdOx/xHM3UAHndyv7eVWywnmLPRAu8e8R2WL1OFT/+on4BCAX+fIH83Q8ute4SR/5R5OXo6TmRrrTQK+toGtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKcn0PSNIuggJBk5mBUzSIVPw79kuVbv54mkVWbU3Q4=;
 b=gNvKGJ6otYRafA0ho1SJvhuwbjPC/wbx31YQx6IFq5XmCX4MoFvWfN1KJoFgGZLdTLFjAOMOmT5lYfjTUoGnj33P6bnFaYxXzB6czjGvMW1ATEgeVsID1fyrmPs2N5JLkdrdtCtWxH9i7+eN/s6b4NtIVwzEzkvCnialELBV4kdpDV4HT4ouGQTGvHEhfNIAUhJO1WQvMSKYaQ9BKPU/G7uKxmedVfghXgBIyM1BSZAM6RmUxLMjCSH51wYc3uWLKtH7Crf8d9GYQoB7b4642brXQ6n3t8YHtj+XGONfvlpUo429aEhyEIhhg9jPEy5r7Il6Fvf03E5kLPN/+gBADA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKcn0PSNIuggJBk5mBUzSIVPw79kuVbv54mkVWbU3Q4=;
 b=cg3AEJ0jBlzEzPUNECpARt4FEWQHX7lWu9HFdQCcXd2J9hp85Cx0uAtdhj+61xkJEckAHv9IDiopdtONaJIi+tq8x/+gSdixifKgqe8OYUsKsy3NLoclfqRVWXdBqsEeGOuJha9XQ1NwlSJ59fIH5At/bZd/Fiuu8VFyc6LS3r4=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH4PR04MB9460.namprd04.prod.outlook.com (2603:10b6:610:23c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 04:36:45 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 04:36:45 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Zhu Yanjun
	<yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2] RDMA/srpt: Make slab cache names unique
Thread-Topic: [PATCH v2] RDMA/srpt: Make slab cache names unique
Thread-Index: AQHbGPjNgifOfQis+0SePaY6X55b8rJ8RWkA
Date: Tue, 8 Oct 2024 04:36:45 +0000
Message-ID: <q4vt32gemvjiklr5p32u2n7scehalu64vpg4wrggrqke6wgsvr@kzvwfsjmpmsb>
References: <20241007203726.3076222-1-bvanassche@acm.org>
In-Reply-To: <20241007203726.3076222-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH4PR04MB9460:EE_
x-ms-office365-filtering-correlation-id: edab2076-5441-49d1-5d81-08dce752d0db
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|27256017;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?CMN/HnDDEG6yOhCKTWHfHUW06Zp7X5tsoFqVlwVaD9aJI9mKo9fSLI6yvSsk?=
 =?us-ascii?Q?1Bb1Uffz1haE+ye8Yer477TALhRcrDkQq0+dINiU2vvibXSQW3XEFpET5G7c?=
 =?us-ascii?Q?lswhI1B88pfqPC30bk/v1E+SHQw3lvwbRqpzLw4ZWQzeG6v1hoZFua/tpDU0?=
 =?us-ascii?Q?RiSA2ruMlFCi5AidnhPQzwbv+V3F+5U1yMY8qeFqieLhKdmIs7s2wKHN1vYB?=
 =?us-ascii?Q?o3r9skZh81DZlrTkglL+UAzKEdOrj2+zmo6WCBOPT9gY8pCTdSACuovzJZ+x?=
 =?us-ascii?Q?68XmJJkDpXjFoVy2b8kFGprHiuiUh3Sm+/skj/B/oIkxuxtOcOf2m9XUH71T?=
 =?us-ascii?Q?0y4yrdrJD1Q37bRqznLJDcy8y13HEDsqzZ+sPo3cKA7/JZDF0rd8pfq8jI9S?=
 =?us-ascii?Q?+q1EAW1HM+L50vnYX7M1I+ntH2r7Ul/CT+r8I2twSe0bVPLyTepit+ssy6tT?=
 =?us-ascii?Q?pS0ey04PxxT6pTVIVXedm1yi3k8O4qISH0RmHfvkIQx6VNA7w7B9Hj0dKyrC?=
 =?us-ascii?Q?c/TX0iybEFTzIh0QSsfcgs8DjhKEq6Ujd06T+WVqLhm9JpEYICFn0P8MccAN?=
 =?us-ascii?Q?hvMLJCaeq5eL1Ov8YAeHhuQuJTmShZ7nN2q8UBHp8HkdIlqng54/NaJ5CJgq?=
 =?us-ascii?Q?U4xl9NgtLv+8BDxChAtdsvSkq6KUf6B6NbW7A+X6811m961muj10ds7tTVUL?=
 =?us-ascii?Q?jmo3ZHyMYMAUQnW0aTTw2qLtnL7gA/KLEEb983D1nrxDHH2wEOPyjNv7IRb9?=
 =?us-ascii?Q?MdWETIY01An6RhVAUC2M70oYgInHMPBgg9MLMjSj5rh9S85B8zwHpkbKqoPg?=
 =?us-ascii?Q?1NX0pz/q+PqRXfH9IEwybPxFfYtq+rTh1CFOdTkanpb6Joi581Se6gU372RX?=
 =?us-ascii?Q?yKwdLhrCQcd35AjoSK37IRiZBfQSd2VfmtM3Fm0mmfUbohmke3lunYjMKQc7?=
 =?us-ascii?Q?mGiXpwhOv/FDi5eDsplWTBJq37+pOefnDDEcPXt8uNLkv0LJayLSnno8rMtk?=
 =?us-ascii?Q?gF4KMvktkLOAubKcNKQgbQeQDwqF2CsKuwdoxM65zp9F6nb+yQgDhi4GX9CB?=
 =?us-ascii?Q?+OpRuh8L1KOD4SaJxkJOKcSJxtqGLfFEZOFOYZrK4D3xO7LMneZ9zcH5LcTM?=
 =?us-ascii?Q?chW+dHaymlLyEtRuvSkCFxM9ghkODF2YPxV8Qts1CeTdFB1Lqw/cUZ6ASCHY?=
 =?us-ascii?Q?QKYVsJtdeNyojm2EZFtLEIP11e2/Wf42NTAIIPoVFZNUjcBH+3eMzM2XWxD0?=
 =?us-ascii?Q?XMQR39BO4rzoL/lirwcqvXGmylQC3ABJl5Bac5xRKE3jsolk9tABWRTrs4dZ?=
 =?us-ascii?Q?2MpzIVLDHU6O4uWy1HgzVJiZ78pYOFnarGurRJamXNDJlC4TdZ7Y690X/ae2?=
 =?us-ascii?Q?vnZFats=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(27256017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kWr+r78sgFGEGrSuzo2wTGnkT2yi6jKhAtwV5AYP3panwMYXiOtF/E38mGOX?=
 =?us-ascii?Q?tRKfYLfkUU2H/L2rV0HOuQ40CThha92ckn9qJTlKKEHTLOOJ4T0fgF/QLCVn?=
 =?us-ascii?Q?hDzEbnEiqXh5NhiDae5boSd/eUHeHRwouhQmEiSUvqkGfCeNsXw3/jj62/LU?=
 =?us-ascii?Q?Q63TAovrRpUqEmGnDjJlT7FZaX6/SSJHeT29ezp8rYFsbu9gBNOKo+YTVKqz?=
 =?us-ascii?Q?rRpG1Bg5a7M98Ww2lirrLbc2P+tmQnRux4DexSl5GpH6J1FMKHnXqkigD0yv?=
 =?us-ascii?Q?HmoQplCSuA/p8neenclxjMfYu4pcpNxfFgXH/wM/XQGx1b9E2IQIAgy2sNiU?=
 =?us-ascii?Q?Xm6kQK13DThkHVc1ckMGafbDTVucKJgBjt0uvYDQ5pVQhzswFFW1jfiuQoN9?=
 =?us-ascii?Q?1CnXx6KiUZgnpUhF8btyfdYK9kZQjBUcS8RotIVTne5/wqC87H97XQrNN7r0?=
 =?us-ascii?Q?H8+RnjF01+EG8cm6N0hN8htgcx+rFtKfvTJOPP5dE7gRpL7bzAsJkEJeQ9LX?=
 =?us-ascii?Q?aAgXJPKAtGGN3j7Qln5bK/bAr9ENc8xxm7y6QIRsIAOuEuUvVWB6/0zh/NFT?=
 =?us-ascii?Q?v8rACGxKiBXnXrIhJuzzROkbDY+Tk5wgT/tG/F8ogw7uhFH6BGtBaeIxu7wr?=
 =?us-ascii?Q?P+OkfmM3AowRhepUCbcboNZrHmcVFQBl1DB3EAX781e3UoYC8g76oEpahy0G?=
 =?us-ascii?Q?bIgDxGYCZUckB8OGqPYBdB0ZPAAp1l/jDPu9QQW5WhZwRsZ4wFP4bvOERv0u?=
 =?us-ascii?Q?gowMbzA6ox2HZge5lrcVKb40f49rsOtcAbTEDD06f53DsqI8mOVw5QGTLS1l?=
 =?us-ascii?Q?TAACJRz3YOjqSnMwhI6AsnC0lEn1EL7yJR34GH8uLwAHuew00aKbec99hn98?=
 =?us-ascii?Q?EeHoR158GXSdGAFBsIFeHc2L6PvzBAw7w10nhRUxidPu213Cddk1ksJdhAjc?=
 =?us-ascii?Q?cyfDtim4xQnDTKe3aOaX2rtJCix7tIqkWoF7GZYUHk7tta2ISt7G22Ve4H34?=
 =?us-ascii?Q?0u56b9a075WTrSVxGK/yU2ufay3Tu3dJAcgLVguecreupbBs5ZiYpGFRf1AW?=
 =?us-ascii?Q?8UeqhrLPKHL5b3TY3Bbh1Gjfeb+3CKis6VerupYj5pgmHj8wQT7S0L1407KR?=
 =?us-ascii?Q?hDGLbJEcJ0qHQv5s5EnxeUnNw/Xn/w1N28VHPxJLnvdjynrNNiURzPO1Snlx?=
 =?us-ascii?Q?1ognhW8YU5Kanx2gIKuo67uaHcfSJdNTGr69mcUfTBrwwDr90oipcWwRD0Dj?=
 =?us-ascii?Q?6xZPfvnx5F6VpmqGfq7OTvcSMgEE519a5/KwNG+hCtBUTA0GLrU5b4Cq4NOx?=
 =?us-ascii?Q?Cn3pHSdx/nBHCXYLaCVbRvHgcDfqu0sLJ3KbJOyxcylCXBD6HTyQhzOsk1ca?=
 =?us-ascii?Q?R7GRggyxaeNcyxNA5+ArjnZgtuUi3JPiVTdT+fGIHV2S5zZhya/is0nh+Prx?=
 =?us-ascii?Q?m9hzyI/YWOiu854zu4V4zZU/Hpkjln/pv0+PdTaqUR9f70mCoOxf5e9LBlHH?=
 =?us-ascii?Q?kK8EQMcE/jlSxgC1qNwyIRCP8QLy+5f4FZ8d6vSPpP4NSwiqkzdUu6DvhXXh?=
 =?us-ascii?Q?otp/QXaTDm3Qs3b3ikiQD0vFW6pB95vFoCkcieKvYOukfTywMhM/Y/zNFHAT?=
 =?us-ascii?Q?M3p1KbcL3xM6sO745FgvEVk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <920C7470861D2741AF3D52F67B5147FC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YSnPDSTyQt0B3K4WNL9vvvf0zIM9aFZ9yhN+5Xwf8+xvLGK7c7cSomPKf5aPu7bPQHwGPP76I96/JPUlV+JAKBWOcibYMyyeyt11wqm/eYcYd3xSxSZnlJgz1aclPJVlRwvJ44uykaYvBDjwjK2xg1fOOSuNcHuFO+/sMAsV+eJyUMY1WrRr4X5Sg4aNtlyOprRB24093q/SuTNGlZjrxwGhRMECBUBBeHTAnzYTmZ/uU4EfMMXhZ99nAIudaHR/x0+NiN9W5IPilelQGZu0sQIoQRlQBt2VAT9N1+oas31rbXTO6qFL3GB3iWQOA1UlKFa7+fcdXIkneshzVhWKLAXDLuZE2TwHLF1b6zBv8SdVcADuZfQxLurVuGbbnHDAIyLoRkMZCMRAZA3vMiyaZ7XVfU1cfwfS3j9zizCfVgUYqJCjV78e4Oj7AkwcWwkHkDIV99h/glm0rUlq2wkaVJf8yr8n4k3RA7II+7MdAZw12fqx+75QD6krnpwhq+NG8sVvK5OWx9YjWcD3j1eoZbCcEJYxLKsAdppLLT2g7YKFKzSqYx5yFg2NWH8Oxkf+GGsSDZlDpCqCzc/f1QaV0WKaZPGHbzYZohcG77aZUN7OqX5S71fyWQLYVzu/40vb
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edab2076-5441-49d1-5d81-08dce752d0db
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 04:36:45.7078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XUVKkkuQoezJWSlGxAzeM88/ItrFw3OKocAKc1uL3oYsqQnmnO6ouEIbU9gL7nE9qPVrhLzgPIwQ29iX+tACyJgyDVVNC+uOSHJx4qvv//s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR04MB9460

On Oct 07, 2024 / 13:37, Bart Van Assche wrote:
> Since commit 4c39529663b9 ("slab: Warn on duplicate cache names when
> DEBUG_VM=3Dy"), slab complains about duplicate cache names. Hence this
> patch. The approach is as follows:
> - Maintain an xarray with the slab size as index and a reference count
>   and a kmem_cache pointer as contents. Use srpt-${slab_size} as kmem
>   cache name.
> - Use 512-byte alignment for all slabs instead of only for some of the
>   slabs.
> - Increment the reference count instead of calling kmem_cache_create().
> - Decrement the reference count instead of calling kmem_cache_destroy().
>=20
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Closes: https://lore.kernel.org/linux-block/xpe6bea7rakpyoyfvspvin2dsozjm=
jtjktpph7rep3h25tv7fb@ooz4cu5z6bq6/
> Cc: Zhu Yanjun <yanjun.zhu@linux.dev>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Fixes: 5dabcd0456d7 ("RDMA/srpt: Add support for immediate data")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Thank you for the fix work. I tested this v2 patch also and confirmed that =
it
avoids the failures. I observed no regression. Looks good.

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>=

