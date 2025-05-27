Return-Path: <linux-rdma+bounces-10773-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFA9AC5DEB
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 01:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F5C74A122E
	for <lists+linux-rdma@lfdr.de>; Tue, 27 May 2025 23:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A1E219E8F;
	Tue, 27 May 2025 23:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TcQcgvd9";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="DuiiTstM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D65B1862;
	Tue, 27 May 2025 23:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748390164; cv=fail; b=Mfbv4NpLKzWcUtmYk6ko6657AFfRsLm786xe4yfd+d0TCqoqzcceGzWgcdQ+8HvWrxHyyfRycb8q+TOhjpoGYJN63uQwsrBfj0zu1hEzL1W+GagVAYYoEHQs0fy1XPGfVmsYQ5BiMzI8hX+uUWTdlXXDI8zEMHSVya91l8DxDUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748390164; c=relaxed/simple;
	bh=Ub+BkJ9T9Zf7zpDBUYMoqC7jabWDO2H0B1EeZL7vqKY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xx6p6uSTt5cT8aaZiywqwlbkP1QorzQ1n2DzhWfwWJfjiGD0ZoORBJJdKev19hqolic5ABD0CrDhZ2Bxwhn4xhIikUaGfBaVeSfF+by4JUY3NRmr5NCmeJOPRgy5ONXy7JoCvU6do7wdNfVjGi8SD8gIFpvvUdEX4CQ5L7qwtVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TcQcgvd9; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=DuiiTstM; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1748390161; x=1779926161;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Ub+BkJ9T9Zf7zpDBUYMoqC7jabWDO2H0B1EeZL7vqKY=;
  b=TcQcgvd9fHfAJGb3j7rixbhdtoNIj3geGI/CFJKvFMA30cEI5zhsBlj/
   tett/3tibs2vFCPDhfaSN1aBEAuGU0QkNpKWJJRyZq6lmt9mgPM/SBp9M
   cFxiqjICwF7yDoWx06ZCYUaz8zMdZYX9i0forntEOUTLvyUNF4n5u9teW
   LgGxVeOQ5HMxamt/THR9yyskgxsa7RXhL5+s6CGjZLewpreW5lMP9b1wA
   GX5cGbKQ/m+HB3/+fF5BVPWdIecumBcMXIptkAseBX17wII9jfAsxrai1
   6mHmmoOrrZW4RS59rScFUon3sqBemy57CnRMSU07rpM+aF+tISCxUZW2t
   A==;
X-CSE-ConnectionGUID: 7MXDBErbShCf0cw9gz+Mgw==
X-CSE-MsgGUID: 3GyvsJEARIK+wNrXK+A7WQ==
X-IronPort-AV: E=Sophos;i="6.15,319,1739808000"; 
   d="scan'208";a="89216429"
Received: from mail-northcentralusazon11013057.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.57])
  by ob1.hgst.iphmx.com with ESMTP; 28 May 2025 07:55:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/0O9LTUN9eDyhztMb00kWK7DfFXsXrVhzVubv5tBENlAAcJcHAd/Tn+eCFIwbg0PFSA4mhFdoYcdy+MRdMCtTKv2opI2fjpRDGTQAP/s0qWQbAyKzKNNHtm17wGqSAKNGQ2clZcmGS/S0wTRcRQXdiEYYPMpnLXyKUwnGufJhYTrCQVBEgHiKH387hhvP7b7Tat2LpPlIUcCYnsh5XdVy01qlqJIx0/EP9ejXFeIcRQ5zcu0GyZez6PkcwOOq5XiBnX2VGBIzRd3Tc1VkCrS2REYj+nW5q/5T8fdZh0sF4KcNvRzKcMzCDAAIMTyAmu3msEV+3esP9+8rKTdGJdtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNH1wjOtzkESEBOpTIct5puOyb5q9nApXkYQKSYxUz4=;
 b=KTKEmqmtYyyRGXleLj1Lp9SZehJu6vaTS4C9su1Dw+nBASmUdhx9gGDKrKM7OE8/xZGhMix+B46/wVbbBokbTg3kiRWpTTVTHVGNoOTawN0q2SeewsuT0F/zVEdLBgFGlebKgdUozCiGUtufDJrmQAdx3dFaVRHBzUrePgobro8hIIRwhUf5geHf+eLet7TjeS04y4PVXR/2rQCfaeEcFhV8078VDudSJtEvD+2k+f4kMuRuq9ORab82SYO6zgzVkPnGq9uOmr9l2x2pM6xFms0VEcCwoiIKw6g9ARsj7VXKYLoIfZZlNnjv/JL66qK9tfaSfW+vKO12gHPyqRjg3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNH1wjOtzkESEBOpTIct5puOyb5q9nApXkYQKSYxUz4=;
 b=DuiiTstMbGxlsMrHxAFyyKm5Qo43TWeqizM1wdWOL4cKRd0PpSXL7joR8oFR0fEDP9MisM2MzaR2MyD8SmgWHQe50sN88BQ12z9t6wdkBEZggmucxMASXCjUxYcwViLePxAdhzzer3LJqg5DzrxxvdOnSCe18FetaiUGUakfqSI=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by CO1PR04MB8233.namprd04.prod.outlook.com (2603:10b6:303:160::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Tue, 27 May
 2025 23:55:51 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8769.025; Tue, 27 May 2025
 23:55:51 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: Re: [ANNOUNCE] blktests repoistory move
Thread-Topic: [ANNOUNCE] blktests repoistory move
Thread-Index: AQHbypSA/Tc20EMek0i3PG4ZJvL8ALPnMJeA
Date: Tue, 27 May 2025 23:55:51 +0000
Message-ID: <ulhlylk7ybzhudqvxar44fs7vvaq3paicfkvr63knxheu5lsuv@n7m6g45xzzub>
References: <rl6mkqchfjfzylyrfie7d52gxetnvh6r2wpgwi3pflbl3v3duf@cjielnfb5rht>
In-Reply-To: <rl6mkqchfjfzylyrfie7d52gxetnvh6r2wpgwi3pflbl3v3duf@cjielnfb5rht>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|CO1PR04MB8233:EE_
x-ms-office365-filtering-correlation-id: 6e36350d-67f2-4847-ee88-08dd9d7a0309
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?YEvGNrjIrKCaVzbReHBsBDoDAfL/+DEvtPPNPjEGL8bTjXgwfPVy3ZF6bUVF?=
 =?us-ascii?Q?Eh3dTCWo78Mg8rs0+HRY06WE++unm/mV2IP9a+jy5aYxb5gQwslZSHbekhEn?=
 =?us-ascii?Q?mHzKCoB/Nzp/IXpk1mmi03WvtuyE5u76rho3I1LIyBB6nRHZv2ClAzl110DS?=
 =?us-ascii?Q?x10L6CFo1WBL1KQHcVAom97nejm+Zf5NRfxjq3BSY+fiyR9Qjr8vTF6BJFf7?=
 =?us-ascii?Q?KH28rbFvNr9XdcHAf60ocQZ7iQv69w6jFnXw2Ae+k3m7PnI54H9d+eOaPfBX?=
 =?us-ascii?Q?ipJ06BcA4jjWGvOzgFZN/1U1iPpc20ivBaaZ9a3GD4ollP3HHvIyo4u9RnV8?=
 =?us-ascii?Q?YZMh27eQiy/7e8pso8kGCYAfAHYiinQ09AlXwf9oAmOxCsgAEu5UPLnoLnbu?=
 =?us-ascii?Q?zJa3yYCQJ2DMrx4nk5S7AVbZAuKzqO8l3LkGcmM3EGuMgassaI/uyvDmCwJN?=
 =?us-ascii?Q?Tw9zE4jE0eqj5SBYqVswO/mrK+ij7K48zuCTf6TvXXrBEsuEQPIte2s/55sm?=
 =?us-ascii?Q?YfE8imxBQtChaiklsm6s+vub9GoaQvA/VxiVDevP1ZZMqmYvtEBhwsafQX9w?=
 =?us-ascii?Q?O4PLGlzoOvhXcGtxMPxs9kabWW/MOr4G+NGH+lG82ZoZYu7CU3rn7m9qlXDZ?=
 =?us-ascii?Q?s5tFHODjRAR1ew5txse8SUBT1YTXsfyf/u+HwBQNEVEfeUlInJzs23RyV0pF?=
 =?us-ascii?Q?0onRY8SjJIS8OfE/NWuaNWmdw8VPEe4bqc8pU6K9ecZpRDEUV3xKt8S+e/Xk?=
 =?us-ascii?Q?c2ISaSQ33XMeO7QxG/XMLdJKarfszXVJxusDWrIuUvMvyQNY8NCsu1zOOVGn?=
 =?us-ascii?Q?gTN5Z0Aq/EMHQJgopWyf7zcw2a/OfYiatfnVUOAy8auxysPkwCrUE4ILdsfq?=
 =?us-ascii?Q?Zz4Qr0DV0oTZy2walWglqRsQusmQkvsj5f93tlswPTijR0oaFwKgAbjCk70W?=
 =?us-ascii?Q?j+DNNNRiyYERNAY90F6JtwRs5ZkeMW8DSL9WwpQkaMX51cSFYCICYIHhXLQY?=
 =?us-ascii?Q?7pTgBVyTEX7gWODoi32VcJXb84f1YjSRcgpoIXcyFAKS8D932Owm48I3EHE2?=
 =?us-ascii?Q?4oLFgS6GHje9iHjxJmn8dQd5LGWCGGv8lQ3xI/eCm9kkowKGuRKOBFjwxO1H?=
 =?us-ascii?Q?4vpYs/XKShrVUqNdufhMT3kIpVSWcG+pyIvtG9z2YQx+JkHArebO0SWLV8ef?=
 =?us-ascii?Q?8s26LFjtkaBY8oXQtDSzU7owbVDP9I1GIrLJi6WVPG+Z8KF7ha0nxiRUeczM?=
 =?us-ascii?Q?xnvXYHkB1Onv/UArZAXZ0DjY62nKXSDZtAo66j5nfygq1q/iFhvi5ADKlAcj?=
 =?us-ascii?Q?AT+F7xXDXYfthAZzSWB0/3TfNoAEA8bVMQXvh7XzwPqJFSd7YHy/wvEk0AI1?=
 =?us-ascii?Q?uUrsay0hNDIlP2gp/m4E5T1ir96pQ/NlK3yCgkJXzEp+j0uuP3heeigxuXPG?=
 =?us-ascii?Q?AgyqCjjlCyLzH8in8Kwca63HGbLD4fwu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?z4JumYosPglUrpP7W5VQJJYVl057TMugnGyKfcPooFBB6ddrN+q0oukjbck8?=
 =?us-ascii?Q?ROzzbzZAOaIsWDIhRON4EQ1+/djyuqtq/D/02FaD6n5S6effya6KQ90XevY7?=
 =?us-ascii?Q?PaUnYdONntn6NMdJ4xN2GmUG1NmKN7j/GSvJMkb7ZsNA3WRlHghrL1W9k1uc?=
 =?us-ascii?Q?pFo4msV3xMr7V9mLrJ5xzRvHnQrCVMhcRGlHQoScjmCUre6Sy/vRm4bujZ/x?=
 =?us-ascii?Q?KKqpAU/s+6Dw9YGJe3Wgu/3+On0Ib8artUt+uuMgwSsl/Qn6UsEzuPV0FJzp?=
 =?us-ascii?Q?wCnhT52vguxZY4fBffODoRIwdtrzbggw4H9hqDl1rBqc35ZFpKQ5rjsO3HIw?=
 =?us-ascii?Q?Yo44H1rahwV/pc2Z/dsK0FM8mCR5C/x3nYr51p8RH31S2yxjkIg5S+k0HnT6?=
 =?us-ascii?Q?5fTWIefOV8SLLwlcXvNnS8EoBnTtSmBbkAy6jHW+We7OeCnHP3Ksd7LEkxKM?=
 =?us-ascii?Q?QlLjT22Xy0TF2gXvgrvLEc1Jrptvxrx2MwXLT7IG3sg+p3g9/YMFIYUUCTro?=
 =?us-ascii?Q?k1YkO8v1ZRX8Lz4NLxyat9p7Gpr/iBte97tRH6ofwVqSMCyD34gSq2S7PH5A?=
 =?us-ascii?Q?uVKWsdKXt7ld28M9d/PMXCqeshYaKeez6spo+FeoU5KI/1ZZai37ANyGarFJ?=
 =?us-ascii?Q?0ah2dvIOXZwtBeobbIOvwKKtf7l1fpzvGsCWND7FgzKfPFqfbKMnte42wQTr?=
 =?us-ascii?Q?BJ/PbGUB+YkZNpSISbQdqWtnJ04n+hSBSejHvqbXALMyQBnR3GZ4uAZN9ETW?=
 =?us-ascii?Q?wKevdVp7W3f37rvtF7XNZYGqnGqvUYsqycsPdELmbounXTfXkahrIyh/Jew8?=
 =?us-ascii?Q?QQBEi7m8cHYwM/zBs41wRT530SGzliYwcs+pw9R2J6mC0ZCmNC/vU51qZ06t?=
 =?us-ascii?Q?xE4Jw5mImt1qSo9ljuo+lVbajAo2QgWkkrW23q0DWpgC8pj7FYvko95ID6Mm?=
 =?us-ascii?Q?Yv/O6pfb3IGRgFUDJJ0g2Y4iMuV+FLZVHlP3WuSEGerHJQWtnZySwQ+X2soR?=
 =?us-ascii?Q?hLFmYykJ9Lp5K6V/cxmUZp+B0M08jX7Y3BwNZDzze3NVxHOyTrwpeeMsNetm?=
 =?us-ascii?Q?xVxJ4a5iSGQi6Yk9jzk5LE99mSu70sVG41y/1VdieOMF41l3OOsdpmX8gnqg?=
 =?us-ascii?Q?IZMVtMyTtsjNUMyeCVGGGcxLYWUvP0lMJBVwSZEh4lSoQJXxRTZAk8Siinnz?=
 =?us-ascii?Q?Xen13YZy56AMsMkwDviM2QbxhRQao5vaHJaVa6eQOS4OIK68XVbZnoFzMhoY?=
 =?us-ascii?Q?Vp7sqDRZwP5ZlO+cwtYrCfjc2hm9ePM80rxXktwzgEuJYS8PT0kr7FzCYrre?=
 =?us-ascii?Q?jVCFrPCawGGi9LfOnT0Z2ApjxNP7pg9UCj9A7p+IFqQ5gBijlvwnrPCHDv3b?=
 =?us-ascii?Q?217hxU3fUT0g8r4NQqHVibwfGhR94/TE4FybtQmWAfUKpwm36P2EPMhJKRyZ?=
 =?us-ascii?Q?8UOSTjsyDrVTvky1MImFH/8q9i5UDhlvegdTL8r/OYrb6aNKcPs//XRwdXFC?=
 =?us-ascii?Q?ylK/9/+H5u4dZJsB/I8KYQPZsqExazq6NHx3MKjqsuJEg770J5Xn2c6tNFmh?=
 =?us-ascii?Q?RhtYyOv8/rDSeEP4kGxqDLtWjApOG9NnihGeGXUaBWjNjCQ/sUYu2d6O1MuG?=
 =?us-ascii?Q?edvedUnelP51RqouMiuFMbg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <477B58D50B706642960861EEC0CA77AF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Mk/K1IjSSxHL9+5pqWSv/YEHutMN1Aa5g4eSgZ87ZBWwFnpQrG+N+sIf6rzaQRjjk2qT14ueCNrWDJJXKo5gaBat+B3+QkIRxd+hLm3USSn0uOslArZNvvL7FROzkBY+cnZJcK+42ZXzT7yhO2iNxaOCsBiRFGVo8/NlbMIsec0I7dwv6gwmF9tde0BiE7aRakcvPuzepgFzNDVgwbfhtEdqyo1Z9l1rDjARGTl7d/hvg6B+BbvXwHvnBK77yZyWPaLu+pI+9F/1A4D+zcTg80+PNrIosxMEdH+zouocE+1ZN1DgwIFFnou03qN5vwEeMLJ8fXhOMss8ly092sTAbLLbmFQZnbM9LUmhcNg0NPS7z0Zvacu0SXX1Uxu7qXseTrBgLF3xbNpMVkCoBTgyzmdp4nfbPn1Yx0DzDjdH9ekUfVw/iWybZ65MgWYdCbKEgv95savw4ZQftBWPkFVjMYwWKSh7REw8HLlFRx4eaRsBvQJ39zzZmH+uI29EFerToP9sdJb3KFMwAkMt02kaONfUrMk7l/RM9+/pGwZeV2A93MXUR9JC78+/PDgYJR09sUlCqmeXKVG5cdgQiQ0WBA8uaFuxKF9MH2DE9XdwD73fgCx19Xtg7V46PNic4V5g
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e36350d-67f2-4847-ee88-08dd9d7a0309
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 23:55:51.8492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: imzBChHws64o7ttwZnRKDd8YXnPuvOK/7zna4L1S2uPKTND+3ctG5fm2uJON64W9DntZ4xxMNPSvplPB3Rldf4BE6dWnOZoOzfoYOrcvBeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR04MB8233

On May 21, 2025 / 21:08, Shinichiro Kawasaki wrote:
> Hello all,
>=20
> FYI, as a preparation to set up blktests CI, we are going to move the blk=
tests
> repository,
>=20
>  from: https://github.com/osandov/blktests
>  to:   https://github.com/linux-blktests/blktests
>=20
> The move is planned early next week, around May/27.
>=20
> The move will be served by the GitHub repository transfer feature [1], so=
 no
> impact is expected for blktests users. Old repository addresses should be=
 usable
> after the move since they are redirected to the new repository. Just to a=
void
> confusion, it is recommended to update the remote URLs in your local clon=
es
> after the move.
>=20
> [1] https://docs.github.com/en/repositories/creating-and-managing-reposit=
ories/transferring-a-repository

FYI, the move has been completed around an hour ago.=

