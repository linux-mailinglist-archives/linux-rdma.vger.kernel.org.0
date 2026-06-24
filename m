Return-Path: <linux-rdma+bounces-22439-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LFK2IYhlO2oDXQgAu9opvQ
	(envelope-from <linux-rdma+bounces-22439-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2026 07:05:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E771A6BB53A
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2026 07:05:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=wdc.com header.s=dkim.wdc.com header.b="r1s1jM/s";
	dkim=pass header.d=sharedspace.onmicrosoft.com header.s=selector2-sharedspace-onmicrosoft-com header.b=g8Px27gF;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22439-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22439-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=wdc.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8269E3042E76
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2026 05:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A978B3806CE;
	Wed, 24 Jun 2026 05:04:44 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D59B3559D6;
	Wed, 24 Jun 2026 05:04:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782277484; cv=fail; b=dAq9tkvOhH9fiZUPzkTJPuIep5Z+kNkBXxx6ESMvQAXxKyyFcT4j9SxToLqHIqcCfzznoH3GCk1EUjuhSQzLyJqryD76d4Tz0mSwmIu4a7MSs2TWUabKpdDvFlgklurihMCV3hneE8OREX0pnGH9D5D6LUv7B5THAEdOMCTe18I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782277484; c=relaxed/simple;
	bh=8nKRzQTvh2z9Lq/wMGSfW1pyVYaN0XVLdHMIVEQNfWE=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=ZU3RY2oIdgvHO7HGOhk6pYB+OabOFBchhq1hGtfW8MU7Sd05L40hlZOevfMIpW9YP4R5znOPZHqGS/p9FjBxE7a4+pG65wUwSQK4MTTrexeSoBNcDSSqQ2BhmjtvrJq+FW2F1lNVq5VfGvMgByB8z0KmPGxXp+fRuvHjIFBBI64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=r1s1jM/s; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=g8Px27gF; arc=fail smtp.client-ip=216.71.153.144
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1782277481; x=1813813481;
  h=date:from:to:subject:message-id:mime-version;
  bh=8nKRzQTvh2z9Lq/wMGSfW1pyVYaN0XVLdHMIVEQNfWE=;
  b=r1s1jM/sEn2S08Tl1E0TMizOA9B/4FFZiFPsgvGDg3sJrsPBlZCcjOwn
   wMWxQ3fARSp7IrbN9+F9qMZdWFxEQvDrKc9hZL1Ab+hGyiMCZgTeTrHXI
   GvWHszX/xePTE3RImfPDdHQS5ulN71Y5lrDlGyEkWQ64ShuX0MdFn7fTn
   m8Mu/fny4zwaIyXOy+Ud2sDOCf2usRMdCncsgPjg+UZomedppzslkJgQS
   cQkv62y7QrOg+g2r2p5OHGj82spAkv8/EvzuYGn461HiKC4zc7MW2JdGo
   BKB2HHOEPEl12gFyVrGnk+MDTnB6UzRNq4FZ/1n6H5HRw5twHGGhN9/p1
   g==;
X-CSE-ConnectionGUID: r7SZhYNGTXuoM4nVPd/I8Q==
X-CSE-MsgGUID: SZM9jNzGTKOHnOoX0Y+dZw==
X-IronPort-AV: E=Sophos;i="6.24,221,1774281600"; 
   d="scan'208";a="148760208"
Received: from mail-southcentralusazon11011012.outbound.protection.outlook.com (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.12])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jun 2026 13:04:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jq4GJThgpwUbUqMG+zBwYqJ3gTMbv+cv7xzHMJUpCA648uIoaDejGAwBvTFEv88PL5EHeNK/AfnM+4B5u/A+EuHsfUd2PpppLeipIIVxDm2HQPUvRhBMDf9r5MdghD5u95KlhwSfgYv+QLXykyyR0ZpndCdThD4Hz7bONnmhAw8XlNWWXilIrBifmKRHQ8OEgd8DbN6/4Xr4Ob+UXWKjdN6tadkD9/DymtFZrcCn/xB7tLv9uu0j0MQkui/w3ROjT6lm3GiXeaRAj5o3/JtfqSp7GoNYl5zreoQQZ22XZ/545TybnVO5kcflZo9OWhGdeU2R5P28AmHjwxQS2Rq4Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOZCGUeqc0xXj4nWysTf8om45wBUHgMa6DTQFbXC/cY=;
 b=PIYtA2AEaHX3iFMGLA03PrABjk5eNtmJBpgqzuRhAdJnUMTJWRkI9coMibIU6BjRwEtqqpXq1cDziqPtQiPrC2ng7x0ku2Ve778kYGmq4o0+q8fLQEOgmI1mEPp7dNXY1KqeIMp0inWp40vqEpG6JvlSwkE7XiQAhj0pKCb20Iu8zgabBhzpOuwAW6dLjko1v3VdggmdLvXmkNPmGb1jOGh4Ba3HeM9qZY7k9h4L6ZEik6OmNxLZXYBq/osr24LGcw3Lz8P/8ZxOGYkiLByZX2qGNDdoz8DxEAiwa9HrkEMamUCyEWbiiAMAl07P9fC8W/1Vw0mOxvZrA6H7Xi12XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOZCGUeqc0xXj4nWysTf8om45wBUHgMa6DTQFbXC/cY=;
 b=g8Px27gFCsNkhPLSma/LAxwyWXx1sRO4EcmBUv0lVR0omQJRKi/07zsVaGdP/igfqliG6hfXu03qXV4qti1ptu+8BtJdCvbV5W7ZrQQHIC5McEvB859MQVhLCQMKwGqjZmDblIMGPwcc0jQSmQTK8S21jXIymzMZXVdkH0Ml6xg=
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by IA5PR04MB993568.namprd04.prod.outlook.com
 (2603:10b6:208:607::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 05:04:33 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%6]) with mapi id 15.21.0159.007; Wed, 24 Jun 2026
 05:04:33 +0000
Date: Wed, 24 Jun 2026 14:04:26 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
	nbd@other.debian.org, linux-rdma@vger.kernel.org
Subject: blktests failures with v7.1 kernel
Message-ID: <ajtk1CaN1pBreS4O@shinmob>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: TYCPR01CA0157.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::10) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|IA5PR04MB993568:EE_
X-MS-Office365-Filtering-Correlation-Id: 2740ba0f-c39b-4a08-ae45-08ded1ae1441
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|19092799006|376014|366016|56012099006|6133799003|18002099003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	0XpYou+wXJ2irzNsZLBA1THjc0iyU9gRK6ipZHTUctyhiDJMxtGC0aKwgRKvts3etIiYJW6TGrFJkF4lyxV5EFNHy7vsNpM1XgE/AUtdShIxyrwzVBke4HOl6L6S+ijv1tiAa6L/9BOpRP+JtaZmTk4JWDiOo8ZQH1M9pdw9na8LaNqx3zIBXhydbpTvU0SvAQtnLHhvH/OuwmKyjQjI96Io1gW3yMkhXQM01fklJpq+wajuatupCR6Ax6lIu1Ksl/+BVnKFNy078YxN5K/55ax757sGUs7w3/NXq463XpWzASmvFlt4xubZNqzreUwDlP6rX7Hv/MFt5CCT//N9muhA9Iv8YrZGkqsnfvMe4huaMSMhYOvpuveYh3FtIMBkC9EiE0V5JlC2q+oAnJihC2hmQPpdfTF9eg19bRh2svDw/h5pZrlThh6dtAXt61g+0KUj4KkmyEvW4w1F3DsP0kILDFWISXp37uQ5aNdz6khiSoo1dUlFPuXkYC4dL4bWjKBySibe3KoYvFiKx3wqMFJf2E3UiKpCykiuqaJAlaV77dzsyORQqWYgJ+pRfLcxtTVvQL1Pmp83RabJm9dZaZoLtTGKPRKBiDaxOBBy2gnDBa8rS5B0UYnbaUgWjgWkW9y+WhtjvL+DiP90tt9B/ndaB1AsL6LyrhGmepZL2uY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(19092799006)(376014)(366016)(56012099006)(6133799003)(18002099003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DhA4GENg0slXIwCUC1l/t0eNvjd8QQDtZuhlkDpkP4CmcyXWHoGOBwuFtrC+?=
 =?us-ascii?Q?L1K5VSRvaI9hu/Q1da+tpd2cYuCgHAEkM17RNXGjnHqS0uSZpUAobOM3q0Ir?=
 =?us-ascii?Q?TMU59d+WZQQu4xnc3/K479ONIONt3J5j0X0533qeZwqM/bqo24wziBNDY8Zd?=
 =?us-ascii?Q?NyQQRBNOJmOA2dnbVusGukf2zHkicO8IbFh//1Bnx0CsvuzvzSB/cGsbsveU?=
 =?us-ascii?Q?4XZAb4iGtgk1Y8bUhgC9n7nSrEQyR/yJPu22GfhGfr35xEP4/FYych5xTGGn?=
 =?us-ascii?Q?mEI/wcvMPmo33FCmzHfzgWmj/5rhq+KYpqo5kjDKRxLvgrNIoQ3l/1wGs/ln?=
 =?us-ascii?Q?YpJEihlB31LmwR10oc/BQHqhz99hbEqodmCWZGWMuxV8POpztdWBwhyAV+WX?=
 =?us-ascii?Q?0MIlOtFbaiSGYt2bWvBniaYxVr/+45krTbzjQrFdyuxM0m4JTb2+dcVLUAhO?=
 =?us-ascii?Q?9PuL3GX/gjDr+krHTTWO8ODnGVwgO5B+/BqyZOtf14pumutuQQN5Z9cSX/G1?=
 =?us-ascii?Q?jJBV3TG/K9t808SvFy52kyf8JUWqOv++KfwYpSW1NVDfR3VogwOiWdTLiE2Q?=
 =?us-ascii?Q?DKZigIUjA6AJ9sRvOyJ0Rhk6qLIWIIImMg0owagqlZdcy6ai6IF9TFIjEzQ8?=
 =?us-ascii?Q?BqvZ+WmrTgCRk2ecMY4QrZkLLYtSvw98NebLg7J5SqG/UCPuJKpzelLGcN9E?=
 =?us-ascii?Q?VR+e+3Q9PXiDOy/ppHkP/UA23hdA+YCUvagR9EEdqRF7XKUUiAg2a6PE0tE+?=
 =?us-ascii?Q?cved8Sul/X9m+U4tce5w6e0kZaIZSx6+EyMWm1Fw2p+zGrneCy5h0pjqeiHY?=
 =?us-ascii?Q?TMugBrfyiEQZiLEkYsCh3oLMLRLBgQcNXTSgAzZTs4YxKorM62ELfVj0L2tq?=
 =?us-ascii?Q?/ZIAKesTQ9B2zzWh75mTs60RafNdDscRerjbUtyq0oCF3OshgHz1Zxh0nNva?=
 =?us-ascii?Q?L+ACboVXEmrbLgHh7X8CZvh1wpFgInDNZIrU8rww5IRnqF0CQC/29cWIR7iQ?=
 =?us-ascii?Q?CohJJbP2Stfpjsnk8V8e/+AOKMnmcdX9drrnKnYeR2fRXcfUpi9ukbX5h+0X?=
 =?us-ascii?Q?GkfCP19CzLjE0bXcRp00Imk+QCfmE6u+yrVRzO/CibZU9rQ2CMGpUJqqS6cO?=
 =?us-ascii?Q?gBGTugMBxU4GDQvCvQro060q0fFPTRk6ML3E4Vh1PIH8ERg0bgOo32QWNK5h?=
 =?us-ascii?Q?W4nySUuV/8egqSXmobO6DeeDOYKrEtCOye5ui68BSLtrPwN9vHWq25vBENV4?=
 =?us-ascii?Q?TLL0U3ZyGHacosp8J2SENZ/LvtoBRzoAEI+xSeKG8lLsf0QCQ/dfZ7nfybvW?=
 =?us-ascii?Q?2eOAWU+UMKbi7BIB5KbB5wbbirm6LutEoI3kMYL6NxXIzxahndfk3x0dv5yZ?=
 =?us-ascii?Q?b0K+ZFT5m6iz8BI+r9ICh/lhGb25NUbBtJJcA5ADmSUaHX6Yv2UEOMz5PcNX?=
 =?us-ascii?Q?jZm+8CmxvE88Uj9wfy6YjZBGhGPXuVaky+xNjfUtqt2WEWQuUdDu06u31ZV0?=
 =?us-ascii?Q?PhIcDCi5E0eeFBwEk7zzW2T9rMk+wMJUvm/HGIgzAZTZibpBoafjV3IQ8Z/L?=
 =?us-ascii?Q?wR1Go4AHSN/XUHF4d/vmhQFNVBEJNvd++FZylFHfpTvPuIgLf1C/cgqIsqyJ?=
 =?us-ascii?Q?W4U64fZEQvXDhXbRNsaK0+d5wDJzg96fTv5rRHyo23Pk56nHSDWSIDCAcSLh?=
 =?us-ascii?Q?dbkjiu4jGrhralcQlpBquYkbqSJgA1PNBftZ3JdZ/0UKp6xI/SOZXXg+kzZW?=
 =?us-ascii?Q?7drEs2Dgr2ypuV+wu1J8vUOYPK8UYYk=3D?=
X-Exchange-RoutingPolicyChecked:
	TfmHQFJmYUnyFYpbw1yw4iYOSIpk/VY/pUzzPJ6xfEmtP6ATIg+02x47SKEBObrLs4mNShJ+yKyNe/YrZFVf7U7QZ5y9R/zwmUqLOIaiUZeRzgOnIixpu9nhnIobojVVbusHNWDmZ4BSAUM40Aj5qne52tyqik5mwe/4d4zz90QaLNlooT04fVfUOtplkg3018CE/mx/vDGMMqxxbJousq/AdbOxi/48hhMfX5qgT2g8f0+lGw3p/jJv7KWc2FnZ8md88jbEXe3yFVBb4ZoJ6/n/JeO/aZkHYrLcJ6JYhZI6O+kM7vsA41AtyDTHO4pgE60n6l6ysWxadkfr67BveA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oWgSn7otFtZlJ3gMiWbNY2DGwF1GM4sJByzYa6foQJc2Qgdh0XEgKcd71k2VM50xyAGwzeOUhXZPiOISJDWJU86x117kB+7tYFcJORPdcI+l14tfvAO96/zuNmLL7W3GNtRn+p8+cfGxNGYc/fvPHOdfy3i/pPQ3UgKCkUiKUWyy6yiKSdrgUQqItLEIIFzb6INW2XSYsZpUX+kRZVOQGCnjZaAeqhnXWHIcXvDFvzX3JToikW6VMNwoxUUftd6xoRKhKtnXF5vdEW8XXm1nfw037iC2icH7DiwvIXWSxg4a2YrZhl29Xa7WAtKcGnM1EuppU2Anx0wwRCRJWYRxUAJpwV59f6++bqZXtQ4otDkG1Pv737tpxapzF6fegBf8iwZwPmuOA0lGdxZ2iffxSHnJEk1WZzndMxM9PLdAe6tVudwqY3h9N5JMicrEE2Dz963ieT+t5FjgG1EIkgVrYJ/IQ0yhWR6c1x8PpEz1G1M1KgxYbpdKndd5Djcu50y06QntIPUyXVJgDOfIFxoE5+1Y5RJvpoNdxZkUHWLqJ64ij/xWa5dHcp55XcK4U8UdT1PCuf1MNz81PNhqcn0ao3YomY/MMaU63EYOEAjD8WWB/K8ln/Ad9OXKPYWWGZPq
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2740ba0f-c39b-4a08-ae45-08ded1ae1441
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 05:04:32.9670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oVnlHlbShnFxZkvfP4VZVYurJ45X90VAob63IbLkWzDBy8WELGTIcES484G2SX84LjB3sAO8Uu+BfNIqHdXBspQrzgMEfRo/uSQ9fxdz5WY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR04MB993568
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22439-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-block@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:linux-scsi@vger.kernel.org,m:nbd@other.debian.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[shinichiro.kawasaki@wdc.com,linux-rdma@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shinichiro.kawasaki@wdc.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sharedspace.onmicrosoft.com:dkim,wdc.com:dkim,wdc.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,shinmob:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E771A6BB53A

Hi all,

I ran the latest blktests (git hash: 5a62429536b1) with the v7.1 kernel. I
observed 9 failures listed below. Comparing with the previous report for the
v7.1-rc1 kernel [1], 2 failures are avoided (nvme/045, scsi/002) and 3 failures
are new (block/005, nvme/062, nvme/063). As always, your help with fixes will be
appreciated.

[1] https://lore.kernel.org/linux-block/afB5syZbUrppgsDQ@shinmob/


List of failures
================
#1: block/005 (new)
#2: nvme/005 (tcp transport)
#3: nvme/058 (fc transport)(kmemleak)
#4: nvme/060 (rdma transport)
#5: nvme/061 (rdma transport, siw driver)(kmemleak)
#6: nvme/061 (fc transport)
#7: nvme/062 (tcp transport)(new)
#8: nvme/063 (tcp transport)(new)
#9: nbd/002


Failure description
===================

#1: block/005 (new)

    I found the test case block/005 failed under some conditions due to
    concurrent writes to a sysfs IO scheduler attribute. The failure was
    discussed and a fix patch candidate is available [2].

    [2] https://lore.kernel.org/linux-block/20260623013238.642052-1-shinichiro.kawasaki@wdc.com/

#2: nvme/005 (tcp transport)

    The test case nvme/005 fails for tcp transport due to the lockdep WARN
    related to the three locks q->q_usage_counter, q->elevator_lock and
    set->srcu. Refer to [1] for the details of the failure. There are two causes
    of the WARN and two fixes are required. One fix by Chaitanya is already in
    the kernel v7.1. The other fix is queued for v7.2-rc1 [3].

    [3] https://lore.kernel.org/linux-nvme/20260604023208.388157-1-shinichiro.kawasaki@wdc.com/

#3: nvme/058 (fc transport)(kmemleak)

    When the kernel enables CONFIG_DEBUG_KMEMLEAK, the test case sometimes
    causes kmemleak. With v7.1-rc1 kernel, this test case had caused a hang, but
    the hang is no longer observed with v7.1 kernel, so the kmemleak is easier
    to recreate now. The memory leak report with v7.1 kernel looks similar to
    those I reported for v7.0-rc1 kernel [4].

    [4] https://lore.kernel.org/linux-block/aZ_-cH8euZLySxdD@shinmob/

#4: nvme/060 (rdma transport)

    When the test case is repeated for rdma transport around 50 times, the test
    case fails. There are two failure symptoms and both do not look like kernel-
    side problems. I posted blktests side fix candidate patches [5].

    [5] https://lore.kernel.org/linux-nvme/20260619013329.558580-1-shinichiro.kawasaki@wdc.com/

#5: nvme/061 (rdma transport, siw driver)(kmemleak)

    When the test case nvme/061 is repeated twice for the rdma transport and the
    siw driver on the kernel with CONFIG_DEBUG_KMEMLEAK enabled, it causes
    kmemleak that is detected at the beginning of the 2nd run. Refer to the
    nvme/061 failure report for v6.19 kernel [6].

    [6] https://lore.kernel.org/linux-block/aY7ZBfMjVIhe_wh3@shinmob/

#6: nvme/061 (fc transport)

    When the test case nvme/061 is repeated around 50 times for the fc
    transport, the test process fails after Oops and KASAN null-ptr-deref.
    Refer to the report for the v7.0-rc1 kernel [4].

#7: nvme/062 (tcp transport)(new)

    The test case nvme/062 fails for tcp transport due to the lockdep WARN
    related to the three locks fs_reclaim, set->srcu and sk_lock-AF_INET-NVME.
    q->elevator_lock and q->q_usage_counter are also recorded in the lockdep
    splat [7].

    I ran nvme/062 on v7.1-rc1 kernel, and I observed it failed with lockdep
    WARN. In the past, I did not observe the failure of this test case because
    lockdep had been disabled due to the lockdep WARN at nvme/005. Now that
    nvme/005 no longer reports a lockdep WARN, I see it at nvme/062 instead.

    When I applied the fix patch for lockdep WARN at nvme/005 [3], the symptoms
    of the lockdep WARN changed [8]. With the patch, the three locks
    kernfs_rwsem, sparse_irq_lock and kernfs_supers_rwsem caused the WARN. The
    fix patch candidate for block/005 [2] did not affect the failure of
    nvme/062.

#8: nvme/063 (tcp transport)(new)

    The test case nvme/063 fails for tcp transport due to the lockdep WARN
    related to the three locks set->srcu, q->q_usage_counter(io) and
    q->elevator_lock [9].

    I had reported the failure of this test case on v7.1-rc1 kernel together
    with nvme/005, assuming the failures of nvme/005 and nvme/063 would have a
    single cause. But even applying the fix for nvme/005 [3], I still observe
    the failure of nvme/063. Therefore, this nvme/063 failure is a different
    problem from the nvme/005 failure. The fix patch candidate for block/005 [2]
    did not affect the failure of nvme/063 either.

#9: nbd/002

    The test case nbd/002 fails due to the lockdep WARN related to
    sk_lock-AF_INET6, cmd->lock and nsock->txlock. The lockdep WARN of this test
    case has been reported since v6.18-rc1 kernel [10]. Eric Dumazet posted a
    fix patch and it is queued for v7.2-rc1 [11]. I confirmed the patch avoids
    the failure. Thanks!

    [10] https://lore.kernel.org/linux-block/ynmi72x5wt5ooljjafebhcarit3pvu6axkslqenikb2p5txe57@ldytqa2t4i2x/
    [11] https://lore.kernel.org/linux-block/20260613042619.1108126-1-edumazet@google.com/


[7] nvme/062 dmesg on v7.1 kernel

[  271.544567] [   T1351] run blktests nvme/062 at 2026-06-24 10:47:29
[  271.810359] [   T1746] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  271.848916] [   T1749] nvmet: Allow non-TLS connections while TLS1.3 is enabled
[  271.869077] [   T1752] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[  272.059895] [    T358] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  272.067526] [   T1759] nvme nvme5: creating 4 I/O queues.
[  272.073127] [   T1759] nvme nvme5: mapped 4/0/0 default/read/poll queues.
[  272.085957] [   T1759] nvme nvme5: new ctrl: NQN "blktests-subsystem-1", addr 127.0.0.1:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  272.648494] [   T1813] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-1"

[  272.847561] [   T1822] ======================================================
[  272.848150] [   T1822] WARNING: possible circular locking dependency detected
[  272.848775] [   T1822] 7.1.0 #5 Not tainted
[  272.849107] [   T1822] ------------------------------------------------------
[  272.849704] [   T1822] tlshd/1822 is trying to acquire lock:
[  272.850161] [   T1822] ffffffff9b8ccda0 (fs_reclaim){+.+.}-{0:0}, at: __kmalloc_cache_noprof+0x58/0x720
[  272.850908] [   T1822] 
                          but task is already holding lock:
[  272.851497] [   T1822] ffff8881220ad058 (sk_lock-AF_INET-NVME){+.+.}-{0:0}, at: do_tcp_setsockopt+0x499/0x26a0
[  272.852360] [   T1822] 
                          which lock already depends on the new lock.

[  272.853170] [   T1822] 
                          the existing dependency chain (in reverse order) is:
[  272.853857] [   T1822] 
                          -> #4 (sk_lock-AF_INET-NVME){+.+.}-{0:0}:
[  272.854483] [   T1822]        lock_sock_nested+0x32/0xf0
[  272.854883] [   T1822]        tcp_sendmsg+0x1c/0x50
[  272.855250] [   T1822]        sock_sendmsg+0x305/0x3c0
[  272.855588] [   T1822]        nvme_tcp_try_send_cmd_pdu+0x630/0xcf0 [nvme_tcp]
[  272.856098] [   T1822]        nvme_tcp_try_send+0x1ef/0xa60 [nvme_tcp]
[  272.856608] [   T1822]        nvme_tcp_queue_rq+0xfa3/0x19e0 [nvme_tcp]
[  272.857676] [   T1822]        blk_mq_dispatch_rq_list+0x3e0/0x2420
[  272.858698] [   T1822]        __blk_mq_sched_dispatch_requests+0x20a/0x15d0
[  272.859747] [   T1822]        blk_mq_sched_dispatch_requests+0xab/0x150
[  272.860785] [   T1822]        blk_mq_run_work_fn+0x135/0x2e0
[  272.861720] [   T1822]        process_one_work+0x8b6/0x1650
[  272.862619] [   T1822]        worker_thread+0x5fd/0xfe0
[  272.863473] [   T1822]        kthread+0x36a/0x460
[  272.864299] [   T1822]        ret_from_fork+0x655/0x9d0
[  272.865117] [   T1822]        ret_from_fork_asm+0x1a/0x30
[  272.865963] [   T1822] 
                          -> #3 (set->srcu){.+.+}-{0:0}:
[  272.867350] [   T1822]        __synchronize_srcu+0xe1/0x2f0
[  272.868170] [   T1822]        elevator_switch+0x2bd/0x670
[  272.868993] [   T1822]        elevator_change+0x2e7/0x500
[  272.869805] [   T1822]        elevator_set_none+0xaa/0xf0
[  272.870623] [   T1822]        blk_unregister_queue+0x15e/0x2e0
[  272.871459] [   T1822]        __del_gendisk+0x28f/0xaa0
[  272.872280] [   T1822]        del_gendisk+0x11a/0x1c0
[  272.873074] [   T1822]        nvme_ns_remove+0x331/0x940 [nvme_core]
[  272.873989] [   T1822]        nvme_remove_namespaces+0x289/0x3f0 [nvme_core]
[  272.874941] [   T1822]        nvme_do_delete_ctrl+0xf6/0x160 [nvme_core]
[  272.875811] [   T1822]        nvme_delete_ctrl_sync.cold+0x8/0xd [nvme_core]
[  272.876761] [   T1822]        nvme_sysfs_delete+0xba/0xe0 [nvme_core]
[  272.877636] [   T1822]        kernfs_fop_write_iter+0x3d6/0x5e0
[  272.878441] [   T1822]        vfs_write+0x4b3/0xf70
[  272.879157] [   T1822]        ksys_write+0x112/0x250
[  272.879908] [   T1822]        do_syscall_64+0xdf/0x790
[  272.880698] [   T1822]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  272.881499] [   T1822] 
                          -> #2 (&q->elevator_lock){+.+.}-{4:4}:
[  272.882720] [   T1822]        __mutex_lock+0x1ae/0x2650
[  272.883397] [   T1822]        elevator_change+0x197/0x500
[  272.884139] [   T1822]        elv_iosched_store+0x38f/0x430
[  272.884926] [   T1822]        queue_attr_store+0x25f/0x3e0
[  272.885685] [   T1822]        kernfs_fop_write_iter+0x3d6/0x5e0
[  272.886433] [   T1822]        vfs_write+0x4b3/0xf70
[  272.887112] [   T1822]        ksys_write+0x112/0x250
[  272.887838] [   T1822]        do_syscall_64+0xdf/0x790
[  272.888534] [   T1822]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  272.889303] [   T1822] 
                          -> #1 (&q->q_usage_counter(io)){++++}-{0:0}:
[  272.890567] [   T1822]        blk_alloc_queue+0x605/0x7a0
[  272.891320] [   T1822]        blk_mq_alloc_queue+0x168/0x270
[  272.892058] [   T1822]        scsi_alloc_sdev+0x86c/0xcd0
[  272.892808] [   T1822]        scsi_probe_and_add_lun+0x601/0xc50
[  272.893568] [   T1822]        __scsi_add_device+0x233/0x280
[  272.894309] [   T1822]        ata_scsi_scan_host+0x137/0x3a0
[  272.895032] [   T1822]        async_run_entry_fn+0x93/0x550
[  272.895766] [   T1822]        process_one_work+0x8b6/0x1650
[  272.896503] [   T1822]        worker_thread+0x5fd/0xfe0
[  272.897199] [   T1822]        kthread+0x36a/0x460
[  272.897824] [   T1822]        ret_from_fork+0x655/0x9d0
[  272.898528] [   T1822]        ret_from_fork_asm+0x1a/0x30
[  272.899251] [   T1822] 
                          -> #0 (fs_reclaim){+.+.}-{0:0}:
[  272.900443] [   T1822]        __lock_acquire+0xe06/0x22e0
[  272.901136] [   T1822]        lock_acquire+0x1a5/0x330
[  272.901839] [   T1822]        fs_reclaim_acquire+0xd5/0x120
[  272.902588] [   T1822]        __kmalloc_cache_noprof+0x58/0x720
[  272.903333] [   T1822]        __request_module+0x253/0x610
[  272.904050] [   T1822]        tcp_set_ulp+0x395/0x5e0
[  272.904769] [   T1822]        do_tcp_setsockopt+0x4a9/0x26a0
[  272.905492] [   T1822]        do_sock_setsockopt+0x163/0x3b0
[  272.906235] [   T1822]        __sys_setsockopt+0xe0/0x150
[  272.906965] [   T1822]        __x64_sys_setsockopt+0xb9/0x180
[  272.907734] [   T1822]        do_syscall_64+0xdf/0x790
[  272.908368] [   T1822]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  272.909049] [   T1822] 
                          other info that might help us debug this:

[  272.910750] [   T1822] Chain exists of:
                            fs_reclaim --> set->srcu --> sk_lock-AF_INET-NVME

[  272.912667] [   T1822]  Possible unsafe locking scenario:

[  272.913915] [   T1822]        CPU0                    CPU1
[  272.914569] [   T1822]        ----                    ----
[  272.915244] [   T1822]   lock(sk_lock-AF_INET-NVME);
[  272.915921] [   T1822]                                lock(set->srcu);
[  272.916742] [   T1822]                                lock(sk_lock-AF_INET-NVME);
[  272.917634] [   T1822]   lock(fs_reclaim);
[  272.918266] [   T1822] 
                           *** DEADLOCK ***

[  272.919861] [   T1822] 1 lock held by tlshd/1822:
[  272.920527] [   T1822]  #0: ffff8881220ad058 (sk_lock-AF_INET-NVME){+.+.}-{0:0}, at: do_tcp_setsockopt+0x499/0x26a0
[  272.921589] [   T1822] 
                          stack backtrace:
[  272.922693] [   T1822] CPU: 2 UID: 0 PID: 1822 Comm: tlshd Not tainted 7.1.0 #5 PREEMPT(full) 
[  272.922696] [   T1822] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-10.fc44 06/10/2025
[  272.922698] [   T1822] Call Trace:
[  272.922701] [   T1822]  <TASK>
[  272.922703] [   T1822]  dump_stack_lvl+0x6a/0x90
[  272.922708] [   T1822]  print_circular_bug.cold+0x189/0x1eb
[  272.922713] [   T1822]  check_noncircular+0x173/0x1a0
[  272.922717] [   T1822]  __lock_acquire+0xe06/0x22e0
[  272.922720] [   T1822]  lock_acquire+0x1a5/0x330
[  272.922722] [   T1822]  ? __kmalloc_cache_noprof+0x58/0x720
[  272.922724] [   T1822]  ? do_raw_spin_lock+0x12d/0x280
[  272.922727] [   T1822]  ? __request_module+0x253/0x610
[  272.922728] [   T1822]  fs_reclaim_acquire+0xd5/0x120
[  272.922731] [   T1822]  ? __kmalloc_cache_noprof+0x58/0x720
[  272.922733] [   T1822]  __kmalloc_cache_noprof+0x58/0x720
[  272.922735] [   T1822]  ? lockdep_hardirqs_on+0x8c/0x130
[  272.922738] [   T1822]  ? rcu_is_watching+0x11/0xb0
[  272.922742] [   T1822]  ? tcp_set_ulp+0x395/0x5e0
[  272.922744] [   T1822]  __request_module+0x253/0x610
[  272.922747] [   T1822]  ? __pfx___request_module+0x10/0x10
[  272.922750] [   T1822]  ? lock_acquire+0x1a5/0x330
[  272.922751] [   T1822]  ? rcu_is_watching+0x11/0xb0
[  272.922753] [   T1822]  ? cap_capable+0x1b7/0x3b0
[  272.922756] [   T1822]  ? lock_acquire+0x1b5/0x330
[  272.922757] [   T1822]  ? find_held_lock+0x2b/0x80
[  272.922761] [   T1822]  ? tcp_set_ulp+0x374/0x5e0
[  272.922763] [   T1822]  tcp_set_ulp+0x395/0x5e0
[  272.922766] [   T1822]  do_tcp_setsockopt+0x4a9/0x26a0
[  272.922769] [   T1822]  ? __pfx_do_tcp_setsockopt+0x10/0x10
[  272.922771] [   T1822]  ? __lock_acquire+0x3d2/0x22e0
[  272.922772] [   T1822]  ? lock_acquire+0x1a5/0x330
[  272.922774] [   T1822]  ? folio_add_file_rmap_ptes+0x7b6/0xa90
[  272.922779] [   T1822]  ? do_raw_spin_lock+0x12d/0x280
[  272.922780] [   T1822]  ? percpu_counter_add_batch+0x89/0x280
[  272.922785] [   T1822]  ? __pfx_selinux_netlbl_socket_setsockopt+0x10/0x10
[  272.922788] [   T1822]  ? find_held_lock+0x2b/0x80
[  272.922792] [   T1822]  do_sock_setsockopt+0x163/0x3b0
[  272.922795] [   T1822]  ? __pfx_do_sock_setsockopt+0x10/0x10
[  272.922798] [   T1822]  __sys_setsockopt+0xe0/0x150
[  272.922802] [   T1822]  __x64_sys_setsockopt+0xb9/0x180
[  272.922804] [   T1822]  ? rcu_read_unlock+0x17/0x60
[  272.922807] [   T1822]  ? lock_release+0x1b5/0x340
[  272.922809] [   T1822]  do_syscall_64+0xdf/0x790
[  272.922811] [   T1822]  ? rcu_read_unlock+0x1c/0x60
[  272.922813] [   T1822]  ? do_fault+0x8fc/0x13c0
[  272.922815] [   T1822]  ? rcu_read_unlock+0x17/0x60
[  272.922817] [   T1822]  ? lock_release+0x1b5/0x340
[  272.922819] [   T1822]  ? __handle_mm_fault+0x10ef/0x1d60
[  272.922822] [   T1822]  ? __lock_acquire+0x3d2/0x22e0
[  272.922824] [   T1822]  ? __pfx___css_rstat_updated+0x10/0x10
[  272.922829] [   T1822]  ? lock_acquire+0x1a5/0x330
[  272.922831] [   T1822]  ? count_memcg_events_mm.constprop.0+0x22/0x130
[  272.922833] [   T1822]  ? rcu_is_watching+0x11/0xb0
[  272.922835] [   T1822]  ? count_memcg_events+0x107/0x4e0
[  272.922839] [   T1822]  ? find_held_lock+0x2b/0x80
[  272.922841] [   T1822]  ? rcu_read_unlock+0x17/0x60
[  272.922843] [   T1822]  ? lock_release+0x1b5/0x340
[  272.922845] [   T1822]  ? find_held_lock+0x2b/0x80
[  272.922847] [   T1822]  ? exc_page_fault+0x94/0x140
[  272.922849] [   T1822]  ? lock_release+0x1b5/0x340
[  272.922851] [   T1822]  ? rcu_is_watching+0x11/0xb0
[  272.922857] [   T1822]  ? trace_hardirqs_on+0x14/0x1b0
[  272.922860] [   T1822]  ? preempt_count_add+0x7f/0x190
[  272.922864] [   T1822]  ? do_syscall_64+0x5d/0x790
[  272.922865] [   T1822]  ? do_syscall_64+0x8d/0x790
[  272.922867] [   T1822]  ? irqentry_exit+0xfc/0x790
[  272.922869] [   T1822]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  272.922871] [   T1822] RIP: 0033:0x7fa53a2da75e
[  272.922875] [   T1822] Code: 55 48 63 c9 48 63 ff 45 89 c9 48 89 e5 48 83 ec 08 6a 2c e8 54 69 f7 ff c9 c3 66 90 f3 0f 1e fa 49 89 ca b8 36 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 0a c3 66 0f 1f 84 00 00 00 00 00 48 8b 15 61
[  272.922877] [   T1822] RSP: 002b:00007ffc6461e8e8 EFLAGS: 00000206 ORIG_RAX: 0000000000000036
[  272.922880] [   T1822] RAX: ffffffffffffffda RBX: 000055d6e364a750 RCX: 00007fa53a2da75e
[  272.922881] [   T1822] RDX: 000000000000001f RSI: 0000000000000006 RDI: 0000000000000005
[  272.922882] [   T1822] RBP: 00007ffc6461e930 R08: 0000000000000004 R09: 0000000000000070
[  272.922883] [   T1822] R10: 000055d6b7b7be2a R11: 0000000000000206 R12: 000055d6e3657c30
[  272.922884] [   T1822] R13: 00007ffc6461e904 R14: 00007ffc6461e990 R15: 000055d6e364a7c0
[  272.922889] [   T1822]  </TASK>
[  273.088107] [    T296] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349, TLS.
[  273.100521] [   T1820] nvme nvme5: creating 4 I/O queues.
[  273.143469] [   T1820] nvme nvme5: mapped 4/0/0 default/read/poll queues.
[  273.147971] [   T1820] nvme nvme5: new ctrl: NQN "blktests-subsystem-1", addr 127.0.0.1:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  273.463094] [   T1890] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-1"
[  273.581465] [   T1903] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  273.611642] [   T1909] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[  273.697895] [   T1916] nvme_tcp: queue 0: failed to receive icresp, error -104
[  273.800385] [    T358] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349, TLS.
[  273.810247] [   T1926] nvme nvme5: creating 4 I/O queues.
[  273.844828] [   T1926] nvme nvme5: mapped 4/0/0 default/read/poll queues.
[  273.850998] [   T1926] nvme nvme5: new ctrl: NQN "blktests-subsystem-1", addr 127.0.0.1:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  274.163114] [   T1985] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-1"


[8] nvme/062 dmesg on v7.1 kernel + nvme-tcp lockdep fix patch

[  327.536320] [   T1023] run blktests nvme/062 at 2026-06-24 12:43:52
[  327.852000] [   T1119] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  327.896673] [   T1122] nvmet: Allow non-TLS connections while TLS1.3 is enabled
[  327.913286] [   T1125] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[  328.118861] [    T350] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[  328.129891] [   T1132] nvme nvme5: creating 4 I/O queues.
[  328.141710] [   T1132] nvme nvme5: mapped 4/0/0 default/read/poll queues.
[  328.149625] [   T1132] nvme nvme5: new ctrl: NQN "blktests-subsystem-1", addr 127.0.0.1:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  329.072473] [   T1185] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-1"
[  329.463408] [    T167] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349, TLS.
[  329.481208] [   T1192] nvme nvme5: creating 4 I/O queues.
[  329.562530] [   T1192] nvme nvme5: mapped 4/0/0 default/read/poll queues.
[  329.580181] [   T1192] nvme nvme5: new ctrl: NQN "blktests-subsystem-1", addr 127.0.0.1:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  330.583680] [   T1261] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-1"
[  330.852275] [   T1274] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  330.914316] [   T1280] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[  331.109290] [   T1287] nvme_tcp: queue 0: failed to receive icresp, error -104

[  331.117766] [   T1287] ======================================================
[  331.118639] [   T1287] WARNING: possible circular locking dependency detected
[  331.119510] [   T1287] 7.1.0+ #407 Not tainted
[  331.120120] [   T1287] ------------------------------------------------------
[  331.120993] [   T1287] nvme/1287 is trying to acquire lock:
[  331.121627] [   T1287] ffff888100923180 (&root->kernfs_rwsem){++++}-{4:4}, at: kernfs_remove_by_name_ns+0x53/0x160
[  331.122934] [   T1287] 
                          but task is already holding lock:
[  331.123841] [   T1287] ffff8881009232a0 (&root->kernfs_supers_rwsem){++++}-{4:4}, at: kernfs_remove_by_name_ns+0x4b/0x160
[  331.125143] [   T1287] 
                          which lock already depends on the new lock.

[  331.126388] [   T1287] 
                          the existing dependency chain (in reverse order) is:
[  331.127475] [   T1287] 
                          -> #9 (&root->kernfs_supers_rwsem){++++}-{4:4}:
[  331.128528] [   T1287]        down_read+0xa6/0x4c0
[  331.129147] [   T1287]        kernfs_remove_by_name_ns+0x4b/0x160
[  331.129900] [   T1287]        remove_files+0x8d/0x1b0
[  331.130474] [   T1287]        sysfs_remove_group+0x78/0x170
[  331.131164] [   T1287]        sysfs_remove_groups+0x63/0xd0
[  331.132307] [   T1287]        __kobject_del+0x7d/0x1e0
[  331.133391] [   T1287]        kobject_del+0x34/0x60
[  331.134437] [   T1287]        free_desc+0x184/0x1a0
[  331.135485] [   T1287]        irq_free_descs+0x4d/0x70
[  331.136554] [   T1287]        msi_domain_free_locked.part.0+0x492/0x690
[  331.137838] [   T1287]        msi_domain_free_irqs_all_locked+0xe9/0x140
[  331.139056] [   T1287]        pci_free_msi_irqs+0x12/0x90
[  331.140124] [   T1287]        pci_disable_msix+0xab/0xf0
[  331.141173] [   T1287]        pci_free_irq_vectors+0x12/0xe0
[  331.142299] [   T1287]        nvme_setup_io_queues+0x5d6/0x16c0 [nvme]
[  331.143485] [   T1287]        nvme_probe.cold+0x30f/0x65a [nvme]
[  331.144607] [   T1287]        local_pci_probe+0xdf/0x190
[  331.145620] [   T1287]        pci_call_probe+0x160/0x6d0
[  331.146635] [   T1287]        pci_device_probe+0x179/0x2f0
[  331.147660] [   T1287]        really_probe+0x1ed/0x900
[  331.148641] [   T1287]        __driver_probe_device+0x1d2/0x420
[  331.149699] [   T1287]        driver_probe_device+0x4a/0x120
[  331.150719] [   T1287]        __driver_attach_async_helper+0x10b/0x280
[  331.151827] [   T1287]        async_run_entry_fn+0x93/0x550
[  331.152796] [   T1287]        process_one_work+0x8b2/0x1640
[  331.153764] [   T1287]        worker_thread+0x5fd/0xfe0
[  331.154708] [   T1287]        kthread+0x367/0x460
[  331.155581] [   T1287]        ret_from_fork+0x655/0x9d0
[  331.156502] [   T1287]        ret_from_fork_asm+0x1a/0x30
[  331.157434] [   T1287] 
                          -> #8 (sparse_irq_lock){+.+.}-{4:4}:
[  331.158932] [   T1287]        __mutex_lock+0x1ae/0x2640
[  331.159820] [   T1287]        cpuhp_bringup_ap+0x52/0x950
[  331.160725] [   T1287]        cpuhp_invoke_callback+0x2d1/0x12e0
[  331.161725] [   T1287]        __cpuhp_invoke_callback_range+0xb6/0x1e0
[  331.162771] [   T1287]        _cpu_up+0x2eb/0x6d0
[  331.163604] [   T1287]        cpu_up+0x111/0x190
[  331.164436] [   T1287]        cpuhp_bringup_mask+0xd3/0x110
[  331.165358] [   T1287]        smp_init+0x27/0xe0
[  331.166183] [   T1287]        kernel_init_freeable+0x442/0x710
[  331.167120] [   T1287]        kernel_init+0x18/0x150
[  331.167951] [   T1287]        ret_from_fork+0x655/0x9d0
[  331.168804] [   T1287]        ret_from_fork_asm+0x1a/0x30
[  331.169665] [   T1287] 
                          -> #7 (cpu_hotplug_lock){++++}-{0:0}:
[  331.171064] [   T1287]        cpus_read_lock+0x3c/0xe0
[  331.171902] [   T1287]        static_key_disable+0x12/0x30
[  331.172773] [   T1287]        inet_hash+0xf3/0xd00
[  331.173571] [   T1287]        inet_csk_listen_start+0x350/0x440
[  331.174508] [   T1287]        __inet_listen_sk+0x191/0x650
[  331.175390] [   T1287]        inet_listen+0x9a/0xe0
[  331.176203] [   T1287]        __sys_listen+0x85/0x100
[  331.177018] [   T1287]        __x64_sys_listen+0x4e/0x90
[  331.177860] [   T1287]        do_syscall_64+0xdf/0x790
[  331.178686] [   T1287]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  331.179686] [   T1287] 
                          -> #6 (sk_lock-AF_INET){+.+.}-{0:0}:
[  331.181060] [   T1287]        lock_sock_nested+0x32/0xf0
[  331.181906] [   T1287]        tls_sw_sendmsg+0x1b4/0x23b0 [tls]
[  331.182832] [   T1287]        sock_sendmsg+0x305/0x3c0
[  331.183661] [   T1287]        nvmet_tcp_try_recv_pdu+0x150d/0x1d10 [nvmet_tcp]
[  331.184742] [   T1287]        nvmet_tcp_io_work+0x122/0x2420 [nvmet_tcp]
[  331.185769] [   T1287]        process_one_work+0x8b2/0x1640
[  331.186665] [   T1287]        worker_thread+0x5fd/0xfe0
[  331.187515] [   T1287]        kthread+0x367/0x460
[  331.188312] [   T1287]        ret_from_fork+0x655/0x9d0
[  331.189171] [   T1287]        ret_from_fork_asm+0x1a/0x30
[  331.190030] [   T1287] 
                          -> #5 (&ctx->tx_lock){+.+.}-{4:4}:
[  331.191388] [   T1287]        __mutex_lock+0x1ae/0x2640
[  331.192245] [   T1287]        tls_sw_sendmsg+0x130/0x23b0 [tls]
[  331.193187] [   T1287]        sock_sendmsg+0x305/0x3c0
[  331.194015] [   T1287]        nvme_tcp_try_send_cmd_pdu+0x630/0xcf0 [nvme_tcp]
[  331.195097] [   T1287]        nvme_tcp_try_send+0x1ef/0xa60 [nvme_tcp]
[  331.196106] [   T1287]        nvme_tcp_queue_rq+0xfa3/0x19e0 [nvme_tcp]
[  331.197123] [   T1287]        blk_mq_dispatch_rq_list+0x3e0/0x2420
[  331.198088] [   T1287]        __blk_mq_sched_dispatch_requests+0x20a/0x15d0
[  331.199145] [   T1287]        blk_mq_sched_dispatch_requests+0xa7/0x140
[  331.200166] [   T1287]        blk_mq_run_work_fn+0x135/0x2e0
[  331.201075] [   T1287]        process_one_work+0x8b2/0x1640
[  331.201962] [   T1287]        worker_thread+0x5fd/0xfe0
[  331.202808] [   T1287]        kthread+0x367/0x460
[  331.203593] [   T1287]        ret_from_fork+0x655/0x9d0
[  331.204458] [   T1287]        ret_from_fork_asm+0x1a/0x30
[  331.205336] [   T1287] 
                          -> #4 (set->srcu){.+.+}-{0:0}:
[  331.206663] [   T1287]        __synchronize_srcu+0xe1/0x2f0
[  331.207558] [   T1287]        elevator_switch+0x2bd/0x670
[  331.208462] [   T1287]        elevator_change+0x2e7/0x500
[  331.209346] [   T1287]        elevator_set_none+0xaa/0xf0
[  331.210226] [   T1287]        blk_unregister_queue+0x15e/0x2e0
[  331.211157] [   T1287]        __del_gendisk+0x28b/0xaa0
[  331.212007] [   T1287]        del_gendisk+0x11a/0x1c0
[  331.212834] [   T1287]        nvme_ns_remove+0x331/0x940 [nvme_core]
[  331.213828] [   T1287]        nvme_remove_namespaces+0x289/0x3f0 [nvme_core]
[  331.214896] [   T1287]        nvme_do_delete_ctrl+0xf6/0x160 [nvme_core]
[  331.215931] [   T1287]        nvme_delete_ctrl_sync.cold+0x8/0xd [nvme_core]
[  331.217003] [   T1287]        nvme_sysfs_delete+0xb7/0xe0 [nvme_core]
[  331.218011] [   T1287]        kernfs_fop_write_iter+0x3d6/0x5e0
[  331.218942] [   T1287]        vfs_write+0x4b3/0xf70
[  331.219759] [   T1287]        ksys_write+0x112/0x250
[  331.220594] [   T1287]        do_syscall_64+0xdf/0x790
[  331.221456] [   T1287]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  331.222474] [   T1287] 
                          -> #3 (&q->elevator_lock){+.+.}-{4:4}:
[  331.223909] [   T1287]        __mutex_lock+0x1ae/0x2640
[  331.224764] [   T1287]        elevator_change+0x197/0x500
[  331.225653] [   T1287]        elv_iosched_store+0x38f/0x430
[  331.226557] [   T1287]        queue_attr_store+0x25f/0x3e0
[  331.227458] [   T1287]        kernfs_fop_write_iter+0x3d6/0x5e0
[  331.228406] [   T1287]        vfs_write+0x4b3/0xf70
[  331.229232] [   T1287]        ksys_write+0x112/0x250
[  331.230068] [   T1287]        do_syscall_64+0xdf/0x790
[  331.230905] [   T1287]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  331.231904] [   T1287] 
                          -> #2 (&q->q_usage_counter(io)){++++}-{0:0}:
[  331.233380] [   T1287]        blk_alloc_queue+0x605/0x7a0
[  331.234276] [   T1287]        blk_mq_alloc_queue+0x168/0x270
[  331.235196] [   T1287]        scsi_alloc_sdev+0x86c/0xcd0
[  331.236087] [   T1287]        scsi_probe_and_add_lun+0x601/0xc50
[  331.237034] [   T1287]        __scsi_add_device+0x233/0x280
[  331.237926] [   T1287]        ata_scsi_scan_host+0x137/0x3a0
[  331.238826] [   T1287]        async_run_entry_fn+0x93/0x550
[  331.239717] [   T1287]        process_one_work+0x8b2/0x1640
[  331.240618] [   T1287]        worker_thread+0x5fd/0xfe0
[  331.241485] [   T1287]        kthread+0x367/0x460
[  331.242291] [   T1287]        ret_from_fork+0x655/0x9d0
[  331.243165] [   T1287]        ret_from_fork_asm+0x1a/0x30
[  331.244029] [   T1287] 
                          -> #1 (fs_reclaim){+.+.}-{0:0}:
[  331.245366] [   T1287]        fs_reclaim_acquire+0xd5/0x120
[  331.246266] [   T1287]        kmem_cache_alloc_lru_noprof+0x52/0x6c0
[  331.247257] [   T1287]        alloc_inode+0x9d/0x1e0
[  331.248093] [   T1287]        iget_locked+0x19d/0x630
[  331.248923] [   T1287]        kernfs_get_inode+0x42/0x440
[  331.249791] [   T1287]        kernfs_get_tree+0x5d0/0xbd0
[  331.250662] [   T1287]        sysfs_get_tree+0x3f/0x140
[  331.251523] [   T1287]        vfs_get_tree+0x87/0x2f0
[  331.252367] [   T1287]        fc_mount+0x16/0x220
[  331.253172] [   T1287]        path_mount+0x854/0x1d10
[  331.253998] [   T1287]        __x64_sys_mount+0x208/0x270
[  331.254860] [   T1287]        do_syscall_64+0xdf/0x790
[  331.255696] [   T1287]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  331.256706] [   T1287] 
                          -> #0 (&root->kernfs_rwsem){++++}-{4:4}:
[  331.258135] [   T1287]        __lock_acquire+0xe06/0x22e0
[  331.259001] [   T1287]        lock_acquire+0x1a5/0x330
[  331.259836] [   T1287]        down_write+0x8c/0x1f0
[  331.260639] [   T1287]        kernfs_remove_by_name_ns+0x53/0x160
[  331.261596] [   T1287]        sysfs_unmerge_group+0xd5/0x160
[  331.262508] [   T1287]        dev_pm_qos_hide_latency_tolerance+0x1f/0x60
[  331.263555] [   T1287]        nvme_uninit_ctrl+0x8f/0x110 [nvme_core]
[  331.264573] [   T1287]        nvme_tcp_create_ctrl+0x887/0xc20 [nvme_tcp]
[  331.265625] [   T1287]        nvmf_dev_write+0x40b/0x830 [nvme_fabrics]
[  331.266651] [   T1287]        vfs_write+0x1cc/0xf70
[  331.267472] [   T1287]        ksys_write+0x112/0x250
[  331.268308] [   T1287]        do_syscall_64+0xdf/0x790
[  331.269164] [   T1287]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  331.270178] [   T1287] 
                          other info that might help us debug this:

[  331.272111] [   T1287] Chain exists of:
                            &root->kernfs_rwsem --> sparse_irq_lock --> &root->kernfs_supers_rwsem

[  331.274536] [   T1287]  Possible unsafe locking scenario:

[  331.275924] [   T1287]        CPU0                    CPU1
[  331.276806] [   T1287]        ----                    ----
[  331.277684] [   T1287]   rlock(&root->kernfs_supers_rwsem);
[  331.278585] [   T1287]                                lock(sparse_irq_lock);
[  331.279668] [   T1287]                                lock(&root->kernfs_supers_rwsem);
[  331.280853] [   T1287]   lock(&root->kernfs_rwsem);
[  331.281672] [   T1287] 
                           *** DEADLOCK ***

[  331.283370] [   T1287] 3 locks held by nvme/1287:
[  331.284208] [   T1287]  #0: ffffffffc19e8260 (nvmf_dev_mutex){+.+.}-{4:4}, at: nvmf_dev_write+0x82/0x830 [nvme_fabrics]
[  331.285743] [   T1287]  #1: ffffffff87d02ce0 (dev_pm_qos_sysfs_mtx){+.+.}-{4:4}, at: dev_pm_qos_hide_latency_tolerance+0x17/0x60
[  331.287381] [   T1287]  #2: ffff8881009232a0 (&root->kernfs_supers_rwsem){++++}-{4:4}, at: kernfs_remove_by_name_ns+0x4b/0x160
[  331.288984] [   T1287] 
                          stack backtrace:
[  331.290235] [   T1287] CPU: 3 UID: 0 PID: 1287 Comm: nvme Not tainted 7.1.0+ #407 PREEMPT(full) 
[  331.290239] [   T1287] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-10.fc44 06/10/2025
[  331.290243] [   T1287] Call Trace:
[  331.290245] [   T1287]  <TASK>
[  331.290246] [   T1287]  dump_stack_lvl+0x6a/0x90
[  331.290253] [   T1287]  print_circular_bug.cold+0x189/0x1eb
[  331.290257] [   T1287]  check_noncircular+0x173/0x1a0
[  331.290261] [   T1287]  __lock_acquire+0xe06/0x22e0
[  331.290265] [   T1287]  lock_acquire+0x1a5/0x330
[  331.290267] [   T1287]  ? kernfs_remove_by_name_ns+0x53/0x160
[  331.290270] [   T1287]  ? __pfx___might_resched+0x10/0x10
[  331.290274] [   T1287]  down_write+0x8c/0x1f0
[  331.290276] [   T1287]  ? kernfs_remove_by_name_ns+0x53/0x160
[  331.290279] [   T1287]  ? __pfx_down_write+0x10/0x10
[  331.290280] [   T1287]  ? kernfs_root+0xac/0x1b0
[  331.290282] [   T1287]  ? lock_release+0x1b5/0x340
[  331.290285] [   T1287]  kernfs_remove_by_name_ns+0x53/0x160
[  331.290288] [   T1287]  sysfs_unmerge_group+0xd5/0x160
[  331.290291] [   T1287]  dev_pm_qos_hide_latency_tolerance+0x1f/0x60
[  331.290294] [   T1287]  nvme_uninit_ctrl+0x8f/0x110 [nvme_core]
[  331.290312] [   T1287]  nvme_tcp_create_ctrl+0x887/0xc20 [nvme_tcp]
[  331.290317] [   T1287]  ? nvmf_dev_write+0x2ff/0x830 [nvme_fabrics]
[  331.290324] [   T1287]  nvmf_dev_write+0x40b/0x830 [nvme_fabrics]
[  331.290329] [   T1287]  vfs_write+0x1cc/0xf70
[  331.290333] [   T1287]  ? __pfx_vfs_write+0x10/0x10
[  331.290338] [   T1287]  ksys_write+0x112/0x250
[  331.290341] [   T1287]  ? __pfx_ksys_write+0x10/0x10
[  331.290343] [   T1287]  ? kasan_quarantine_put+0x12e/0x260
[  331.290346] [   T1287]  ? kasan_quarantine_put+0x12e/0x260
[  331.290348] [   T1287]  do_syscall_64+0xdf/0x790
[  331.290352] [   T1287]  ? do_sys_openat2+0xfd/0x170
[  331.290354] [   T1287]  ? __pfx_do_sys_openat2+0x10/0x10
[  331.290356] [   T1287]  ? lock_is_held_type+0xf6/0x1b0
[  331.290359] [   T1287]  ? rcu_is_watching+0x11/0xb0
[  331.290362] [   T1287]  ? trace_hardirqs_on+0x14/0x1b0
[  331.290364] [   T1287]  ? lockdep_hardirqs_on+0x8c/0x130
[  331.290366] [   T1287]  ? __call_rcu_common.constprop.0+0x4af/0x1190
[  331.290370] [   T1287]  ? __x64_sys_openat+0x10a/0x210
[  331.290372] [   T1287]  ? __pfx___call_rcu_common.constprop.0+0x10/0x10
[  331.290375] [   T1287]  ? __pfx___x64_sys_openat+0x10/0x10
[  331.290378] [   T1287]  ? rcu_is_watching+0x11/0xb0
[  331.290380] [   T1287]  ? do_syscall_64+0x1ec/0x790
[  331.290382] [   T1287]  ? trace_hardirqs_on_prepare+0x14c/0x1a0
[  331.290384] [   T1287]  ? lockdep_hardirqs_on+0x8c/0x130
[  331.290386] [   T1287]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  331.290388] [   T1287]  ? do_syscall_64+0x20a/0x790
[  331.290391] [   T1287]  ? fput_close_sync+0xda/0x1b0
[  331.290393] [   T1287]  ? __pfx_fput_close_sync+0x10/0x10
[  331.290395] [   T1287]  ? do_raw_spin_unlock+0x55/0x230
[  331.290398] [   T1287]  ? rcu_is_watching+0x11/0xb0
[  331.290401] [   T1287]  ? do_syscall_64+0x1ec/0x790
[  331.290403] [   T1287]  ? trace_hardirqs_on_prepare+0x14c/0x1a0
[  331.290405] [   T1287]  ? lockdep_hardirqs_on+0x8c/0x130
[  331.290407] [   T1287]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  331.290409] [   T1287]  ? do_syscall_64+0x20a/0x790
[  331.290410] [   T1287]  ? count_memcg_events_mm.constprop.0+0x22/0x130
[  331.290414] [   T1287]  ? rcu_is_watching+0x11/0xb0
[  331.290417] [   T1287]  ? count_memcg_events+0x107/0x4e0
[  331.290419] [   T1287]  ? find_held_lock+0x2b/0x80
[  331.290422] [   T1287]  ? rcu_read_unlock+0x17/0x60
[  331.290425] [   T1287]  ? lock_release+0x1b5/0x340
[  331.290427] [   T1287]  ? find_held_lock+0x2b/0x80
[  331.290430] [   T1287]  ? exc_page_fault+0x94/0x140
[  331.290432] [   T1287]  ? lock_release+0x1b5/0x340
[  331.290435] [   T1287]  ? rcu_is_watching+0x11/0xb0
[  331.290438] [   T1287]  ? trace_hardirqs_on+0x14/0x1b0
[  331.290439] [   T1287]  ? preempt_count_add+0x7f/0x190
[  331.290442] [   T1287]  ? do_syscall_64+0x5d/0x790
[  331.290444] [   T1287]  ? do_syscall_64+0x8d/0x790
[  331.290446] [   T1287]  ? irqentry_exit+0xfc/0x790
[  331.290449] [   T1287]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  331.290451] [   T1287] RIP: 0033:0x7f407046277e
[  331.290456] [   T1287] Code: 4d 89 d8 e8 d4 bc 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
[  331.290458] [   T1287] RSP: 002b:00007ffc375d7ae0 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[  331.290463] [   T1287] RAX: ffffffffffffffda RBX: 000000003c2f7680 RCX: 00007f407046277e
[  331.290464] [   T1287] RDX: 00000000000000cf RSI: 000000003c2f7680 RDI: 0000000000000003
[  331.290466] [   T1287] RBP: 00007ffc375d7af0 R08: 0000000000000000 R09: 0000000000000000
[  331.290467] [   T1287] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000003
[  331.290468] [   T1287] R13: 000000003c2f5540 R14: 00007f4070638818 R15: 0000000000000001
[  331.290472] [   T1287]  </TASK>
[  331.336870] [      C0] clocksource: Watchdog remote CPU 3 read timed out
[  331.494199] [    T373] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349, TLS.
[  331.504462] [   T1298] nvme nvme5: creating 4 I/O queues.
[  331.546425] [   T1298] nvme nvme5: mapped 4/0/0 default/read/poll queues.
[  331.552151] [   T1298] nvme nvme5: new ctrl: NQN "blktests-subsystem-1", addr 127.0.0.1:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  332.171342] [   T1363] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-1"


[9] nvme/063 dmesg on v7.1 kernel

[  353.490641] [   T1285] run blktests nvme/063 at 2026-06-24 10:54:40
[  353.790326] [   T1754] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  353.823845] [   T1757] nvmet: Allow non-TLS connections while TLS1.3 is enabled
[  353.835314] [   T1760] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[  354.034947] [    T458] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349 with DH-HMAC-CHAP.
[  354.053192] [    T358] nvme nvme5: qid 0: authenticated with hash hmac(sha256) dhgroup ffdhe2048
[  354.055130] [   T1770] nvme nvme5: qid 0: authenticated
[  354.163171] [     T11] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349, TLS.
[  354.173339] [   T1770] nvme nvme5: creating 4 I/O queues.
[  354.234059] [   T1770] nvme nvme5: mapped 4/0/0 default/read/poll queues.
[  354.244089] [   T1770] nvme nvme5: new ctrl: NQN "blktests-subsystem-1", addr 127.0.0.1:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  354.714629] [   T1846] nvme nvme5: resetting controller
[  354.730193] [    T295] nvmet: Created nvm controller 2 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349 with DH-HMAC-CHAP.
[  354.738053] [     T49] nvme nvme5: qid 0: authenticated with hash hmac(sha256) dhgroup ffdhe2048
[  354.739399] [    T361] nvme nvme5: qid 0: authenticated
[  354.770783] [    T295] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349, TLS.
[  354.776061] [    T361] nvme nvme5: creating 4 I/O queues.
[  354.848673] [    T361] nvme nvme5: mapped 4/0/0 default/read/poll queues.
[  354.933728] [   T1861] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-1"

[  354.954040] [   T1861] ======================================================
[  354.956228] [   T1861] WARNING: possible circular locking dependency detected
[  354.958462] [   T1861] 7.1.0 #5 Not tainted
[  354.959747] [   T1861] ------------------------------------------------------
[  354.961969] [   T1861] nvme/1861 is trying to acquire lock:
[  354.963758] [   T1861] ffff88812a332518 (set->srcu){.+.+}-{0:0}, at: __synchronize_srcu+0xc1/0x2f0
[  354.966758] [   T1861] 
                          but task is already holding lock:
[  354.969092] [   T1861] ffff88810d596bf8 (&q->elevator_lock){+.+.}-{4:4}, at: elevator_change+0x197/0x500
[  354.971880] [   T1861] 
                          which lock already depends on the new lock.

[  354.976664] [   T1861] 
                          the existing dependency chain (in reverse order) is:
[  354.980056] [   T1861] 
                          -> #5 (&q->elevator_lock){+.+.}-{4:4}:
[  354.982450] [   T1861]        __mutex_lock+0x1ae/0x2650
[  354.983578] [   T1861]        elevator_change+0x197/0x500
[  354.984623] [   T1861]        elv_iosched_store+0x38f/0x430
[  354.985737] [   T1861]        queue_attr_store+0x25f/0x3e0
[  354.986901] [   T1861]        kernfs_fop_write_iter+0x3d6/0x5e0
[  354.988242] [   T1861]        vfs_write+0x4b3/0xf70
[  354.989283] [   T1861]        ksys_write+0x112/0x250
[  354.990311] [   T1861]        do_syscall_64+0xdf/0x790
[  354.991481] [   T1861]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  354.992718] [   T1861] 
                          -> #4 (&q->q_usage_counter(io)){++++}-{0:0}:
[  354.994760] [   T1861]        blk_alloc_queue+0x605/0x7a0
[  354.995936] [   T1861]        blk_mq_alloc_queue+0x168/0x270
[  354.997058] [   T1861]        scsi_alloc_sdev+0x86c/0xcd0
[  354.998151] [   T1861]        scsi_probe_and_add_lun+0x601/0xc50
[  354.999296] [   T1861]        __scsi_add_device+0x233/0x280
[  355.000391] [   T1861]        ata_scsi_scan_host+0x137/0x3a0
[  355.001434] [   T1861]        async_run_entry_fn+0x93/0x550
[  355.002475] [   T1861]        process_one_work+0x8b6/0x1650
[  355.003571] [   T1861]        worker_thread+0x5fd/0xfe0
[  355.004559] [   T1861]        kthread+0x36a/0x460
[  355.005471] [   T1861]        ret_from_fork+0x655/0x9d0
[  355.006445] [   T1861]        ret_from_fork_asm+0x1a/0x30
[  355.007454] [   T1861] 
                          -> #3 (fs_reclaim){+.+.}-{0:0}:
[  355.009116] [   T1861]        fs_reclaim_acquire+0xd5/0x120
[  355.010151] [   T1861]        __kmalloc_cache_noprof+0x58/0x720
[  355.011270] [   T1861]        __request_module+0x253/0x610
[  355.012285] [   T1861]        tcp_set_ulp+0x395/0x5e0
[  355.013306] [   T1861]        do_tcp_setsockopt+0x4a9/0x26a0
[  355.014296] [   T1861]        do_sock_setsockopt+0x163/0x3b0
[  355.015198] [   T1861]        __sys_setsockopt+0xe0/0x150
[  355.016140] [   T1861]        __x64_sys_setsockopt+0xb9/0x180
[  355.017098] [   T1861]        do_syscall_64+0xdf/0x790
[  355.018038] [   T1861]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  355.019093] [   T1861] 
                          -> #2 (sk_lock-AF_INET-NVME){+.+.}-{0:0}:
[  355.020508] [   T1861]        lock_sock_nested+0x32/0xf0
[  355.021427] [   T1861]        tls_sw_sendmsg+0x1b4/0x23b0 [tls]
[  355.022442] [   T1861]        sock_sendmsg+0x305/0x3c0
[  355.023332] [   T1861]        nvme_tcp_init_connection+0x3d8/0x970 [nvme_tcp]
[  355.024658] [   T1861]        nvme_tcp_alloc_queue+0xf92/0x1ba0 [nvme_tcp]
[  355.025873] [   T1861]        nvme_tcp_alloc_admin_queue+0xff/0x440 [nvme_tcp]
[  355.027046] [   T1861]        nvme_tcp_setup_ctrl+0x188/0x8a0 [nvme_tcp]
[  355.028079] [   T1861]        nvme_tcp_create_ctrl+0x874/0xc20 [nvme_tcp]
[  355.029186] [   T1861]        nvmf_dev_write+0x40b/0x830 [nvme_fabrics]
[  355.030272] [   T1861]        vfs_write+0x1cc/0xf70
[  355.031137] [   T1861]        ksys_write+0x112/0x250
[  355.032031] [   T1861]        do_syscall_64+0xdf/0x790
[  355.032919] [   T1861]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  355.033977] [   T1861] 
                          -> #1 (&ctx->tx_lock){+.+.}-{4:4}:
[  355.035415] [   T1861]        __mutex_lock+0x1ae/0x2650
[  355.036296] [   T1861]        tls_sw_sendmsg+0x130/0x23b0 [tls]
[  355.037287] [   T1861]        sock_sendmsg+0x305/0x3c0
[  355.038171] [   T1861]        nvme_tcp_try_send_cmd_pdu+0x630/0xcf0 [nvme_tcp]
[  355.039293] [   T1861]        nvme_tcp_try_send+0x1ef/0xa60 [nvme_tcp]
[  355.040362] [   T1861]        nvme_tcp_queue_rq+0xfa3/0x19e0 [nvme_tcp]
[  355.041470] [   T1861]        blk_mq_dispatch_rq_list+0x3e0/0x2420
[  355.042456] [   T1861]        __blk_mq_sched_dispatch_requests+0x20a/0x15d0
[  355.043618] [   T1861]        blk_mq_sched_dispatch_requests+0xab/0x150
[  355.044725] [   T1861]        blk_mq_run_work_fn+0x135/0x2e0
[  355.045739] [   T1861]        process_one_work+0x8b6/0x1650
[  355.046753] [   T1861]        worker_thread+0x5fd/0xfe0
[  355.047663] [   T1861]        kthread+0x36a/0x460
[  355.048507] [   T1861]        ret_from_fork+0x655/0x9d0
[  355.049433] [   T1861]        ret_from_fork_asm+0x1a/0x30
[  355.050354] [   T1861] 
                          -> #0 (set->srcu){.+.+}-{0:0}:
[  355.051837] [   T1861]        __lock_acquire+0xe06/0x22e0
[  355.052584] [   T1861]        lock_sync+0xbf/0x120
[  355.053245] [   T1861]        __synchronize_srcu+0xe1/0x2f0
[  355.053967] [   T1861]        elevator_switch+0x2bd/0x670
[  355.054671] [   T1861]        elevator_change+0x2e7/0x500
[  355.055360] [   T1861]        elevator_set_none+0xaa/0xf0
[  355.056129] [   T1861]        blk_unregister_queue+0x15e/0x2e0
[  355.056911] [   T1861]        __del_gendisk+0x28f/0xaa0
[  355.057530] [   T1861]        del_gendisk+0x11a/0x1c0
[  355.058166] [   T1861]        nvme_ns_remove+0x331/0x940 [nvme_core]
[  355.058897] [   T1861]        nvme_remove_namespaces+0x289/0x3f0 [nvme_core]
[  355.059623] [   T1861]        nvme_do_delete_ctrl+0xf6/0x160 [nvme_core]
[  355.060683] [   T1861]        nvme_delete_ctrl_sync.cold+0x8/0xd [nvme_core]
[  355.061487] [   T1861]        nvme_sysfs_delete+0xba/0xe0 [nvme_core]
[  355.062274] [   T1861]        kernfs_fop_write_iter+0x3d6/0x5e0
[  355.063033] [   T1861]        vfs_write+0x4b3/0xf70
[  355.063694] [   T1861]        ksys_write+0x112/0x250
[  355.064372] [   T1861]        do_syscall_64+0xdf/0x790
[  355.065092] [   T1861]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  355.065912] [   T1861] 
                          other info that might help us debug this:

[  355.067898] [   T1861] Chain exists of:
                            set->srcu --> &q->q_usage_counter(io) --> &q->elevator_lock

[  355.070120] [   T1861]  Possible unsafe locking scenario:

[  355.071461] [   T1861]        CPU0                    CPU1
[  355.072232] [   T1861]        ----                    ----
[  355.073014] [   T1861]   lock(&q->elevator_lock);
[  355.073692] [   T1861]                                lock(&q->q_usage_counter(io));
[  355.074592] [   T1861]                                lock(&q->elevator_lock);
[  355.075498] [   T1861]   sync(set->srcu);
[  355.076133] [   T1861] 
                           *** DEADLOCK ***

[  355.077737] [   T1861] 5 locks held by nvme/1861:
[  355.078437] [   T1861]  #0: ffff88812a9a6410 (sb_writers#4){.+.+}-{0:0}, at: ksys_write+0x112/0x250
[  355.079384] [   T1861]  #1: ffff888135ef9480 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x257/0x5e0
[  355.080388] [   T1861]  #2: ffff88810a849008 (kn->active#144){++++}-{0:0}, at: sysfs_remove_file_self+0x61/0xb0
[  355.081392] [   T1861]  #3: ffff88810641c1c8 (&set->update_nr_hwq_lock){++++}-{4:4}, at: del_gendisk+0x112/0x1c0
[  355.082436] [   T1861]  #4: ffff88810d596bf8 (&q->elevator_lock){+.+.}-{4:4}, at: elevator_change+0x197/0x500
[  355.083442] [   T1861] 
                          stack backtrace:
[  355.084570] [   T1861] CPU: 3 UID: 0 PID: 1861 Comm: nvme Not tainted 7.1.0 #5 PREEMPT(full) 
[  355.084573] [   T1861] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-10.fc44 06/10/2025
[  355.084576] [   T1861] Call Trace:
[  355.084578] [   T1861]  <TASK>
[  355.084580] [   T1861]  dump_stack_lvl+0x6a/0x90
[  355.084586] [   T1861]  print_circular_bug.cold+0x189/0x1eb
[  355.084590] [   T1861]  check_noncircular+0x173/0x1a0
[  355.084595] [   T1861]  __lock_acquire+0xe06/0x22e0
[  355.084598] [   T1861]  lock_sync+0xbf/0x120
[  355.084600] [   T1861]  ? __synchronize_srcu+0xc1/0x2f0
[  355.084602] [   T1861]  ? __synchronize_srcu+0xc1/0x2f0
[  355.084604] [   T1861]  __synchronize_srcu+0xe1/0x2f0
[  355.084606] [   T1861]  ? __pfx___synchronize_srcu+0x10/0x10
[  355.084608] [   T1861]  ? lock_acquire+0x1a5/0x330
[  355.084611] [   T1861]  ? _raw_spin_unlock_irqrestore+0x35/0x60
[  355.084614] [   T1861]  ? synchronize_srcu+0xae/0x3f0
[  355.084616] [   T1861]  elevator_switch+0x2bd/0x670
[  355.084619] [   T1861]  elevator_change+0x2e7/0x500
[  355.084622] [   T1861]  elevator_set_none+0xaa/0xf0
[  355.084624] [   T1861]  ? __pfx_elevator_set_none+0x10/0x10
[  355.084626] [   T1861]  ? kobject_put+0x62/0x530
[  355.084631] [   T1861]  blk_unregister_queue+0x15e/0x2e0
[  355.084633] [   T1861]  __del_gendisk+0x28f/0xaa0
[  355.084635] [   T1861]  ? down_read+0xbd/0x4d0
[  355.084637] [   T1861]  ? down_read+0x148/0x4d0
[  355.084638] [   T1861]  ? __pfx___del_gendisk+0x10/0x10
[  355.084641] [   T1861]  ? __pfx_down_read+0x10/0x10
[  355.084642] [   T1861]  ? up_write+0x201/0x540
[  355.084645] [   T1861]  ? up_write+0x2ad/0x540
[  355.084647] [   T1861]  del_gendisk+0x11a/0x1c0
[  355.084649] [   T1861]  nvme_ns_remove+0x331/0x940 [nvme_core]
[  355.084666] [   T1861]  nvme_remove_namespaces+0x289/0x3f0 [nvme_core]
[  355.084681] [   T1861]  ? __pfx_nvme_remove_namespaces+0x10/0x10 [nvme_core]
[  355.084693] [   T1861]  nvme_do_delete_ctrl+0xf6/0x160 [nvme_core]
[  355.084705] [   T1861]  nvme_delete_ctrl_sync.cold+0x8/0xd [nvme_core]
[  355.084717] [   T1861]  nvme_sysfs_delete+0xba/0xe0 [nvme_core]
[  355.084729] [   T1861]  ? __pfx_sysfs_kf_write+0x10/0x10
[  355.084732] [   T1861]  kernfs_fop_write_iter+0x3d6/0x5e0
[  355.084735] [   T1861]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[  355.084736] [   T1861]  vfs_write+0x4b3/0xf70
[  355.084739] [   T1861]  ? __pfx_vfs_write+0x10/0x10
[  355.084741] [   T1861]  ? rcu_is_watching+0x11/0xb0
[  355.084745] [   T1861]  ? kmem_cache_free+0x163/0x6b0
[  355.084749] [   T1861]  ksys_write+0x112/0x250
[  355.084751] [   T1861]  ? __pfx_ksys_write+0x10/0x10
[  355.084753] [   T1861]  ? __x64_sys_close+0x87/0xf0
[  355.084756] [   T1861]  do_syscall_64+0xdf/0x790
[  355.084758] [   T1861]  ? __x64_sys_openat+0x10a/0x210
[  355.084760] [   T1861]  ? __pfx___x64_sys_openat+0x10/0x10
[  355.084762] [   T1861]  ? rcu_is_watching+0x11/0xb0
[  355.084764] [   T1861]  ? do_syscall_64+0x1ec/0x790
[  355.084766] [   T1861]  ? trace_hardirqs_on_prepare+0x14c/0x1a0
[  355.084769] [   T1861]  ? lockdep_hardirqs_on+0x8c/0x130
[  355.084772] [   T1861]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  355.084773] [   T1861]  ? do_syscall_64+0x20a/0x790
[  355.084776] [   T1861]  ? lock_is_held_type+0xf6/0x1b0
[  355.084778] [   T1861]  ? rcu_is_watching+0x11/0xb0
[  355.084780] [   T1861]  ? trace_hardirqs_on+0x14/0x1b0
[  355.084781] [   T1861]  ? lockdep_hardirqs_on+0x8c/0x130
[  355.084783] [   T1861]  ? __call_rcu_common.constprop.0+0x4af/0x11a0
[  355.084785] [   T1861]  ? __call_rcu_common.constprop.0+0x4af/0x11a0
[  355.084787] [   T1861]  ? __pfx___call_rcu_common.constprop.0+0x10/0x10
[  355.084791] [   T1861]  ? fput_close_sync+0xda/0x1b0
[  355.084792] [   T1861]  ? kmem_cache_free+0x47e/0x6b0
[  355.084795] [   T1861]  ? fput_close_sync+0xda/0x1b0
[  355.084796] [   T1861]  ? __pfx_fput_close_sync+0x10/0x10
[  355.084798] [   T1861]  ? do_raw_spin_unlock+0x55/0x230
[  355.084800] [   T1861]  ? rcu_is_watching+0x11/0xb0
[  355.084802] [   T1861]  ? do_syscall_64+0x1ec/0x790
[  355.084803] [   T1861]  ? trace_hardirqs_on_prepare+0x14c/0x1a0
[  355.084805] [   T1861]  ? lockdep_hardirqs_on+0x8c/0x130
[  355.084807] [   T1861]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  355.084808] [   T1861]  ? do_syscall_64+0x20a/0x790
[  355.084809] [   T1861]  ? do_syscall_64+0x1ec/0x790
[  355.084811] [   T1861]  ? trace_hardirqs_on_prepare+0x14c/0x1a0
[  355.084812] [   T1861]  ? lockdep_hardirqs_on+0x8c/0x130
[  355.084814] [   T1861]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  355.084815] [   T1861]  ? do_syscall_64+0x20a/0x790
[  355.084817] [   T1861]  ? trace_hardirqs_on_prepare+0x14c/0x1a0
[  355.084818] [   T1861]  ? rcu_is_watching+0x11/0xb0
[  355.084820] [   T1861]  ? trace_hardirqs_on+0x14/0x1b0
[  355.084822] [   T1861]  ? preempt_count_add+0x7f/0x190
[  355.084825] [   T1861]  ? do_syscall_64+0x5d/0x790
[  355.084826] [   T1861]  ? do_syscall_64+0x8d/0x790
[  355.084828] [   T1861]  ? irqentry_exit+0xfc/0x790
[  355.084830] [   T1861]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  355.084832] [   T1861] RIP: 0033:0x7fe310bc408e
[  355.084836] [   T1861] Code: 4d 89 d8 e8 94 bd 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 03 ff ff ff 0f 1f 00 f3 0f 1e fa
[  355.084838] [   T1861] RSP: 002b:00007ffe4bbbbdf0 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[  355.084841] [   T1861] RAX: ffffffffffffffda RBX: 00007fe310d8a566 RCX: 00007fe310bc408e
[  355.084842] [   T1861] RDX: 0000000000000001 RSI: 00007fe310d8a566 RDI: 0000000000000003
[  355.084843] [   T1861] RBP: 00007ffe4bbbbe00 R08: 0000000000000000 R09: 0000000000000000
[  355.084844] [   T1861] R10: 0000000000000000 R11: 0000000000000202 R12: 000000001ddfd910
[  355.084845] [   T1861] R13: 00007ffe4bbbe5e6 R14: 000000001ddfd720 R15: 000000001ddffb50
[  355.084848] [   T1861]  </TASK>
[  355.363487] [    T295] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349 with DH-HMAC-CHAP.
[  355.381067] [     T49] nvme nvme5: qid 0: authenticated with hash hmac(sha384) dhgroup ffdhe3072
[  355.385933] [   T1873] nvme nvme5: qid 0: authenticated
[  355.413432] [     T11] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349, TLS.
[  355.431349] [   T1873] nvme nvme5: creating 4 I/O queues.
[  355.473722] [   T1873] nvme nvme5: mapped 4/0/0 default/read/poll queues.
[  355.479399] [   T1873] nvme nvme5: new ctrl: NQN "blktests-subsystem-1", addr 127.0.0.1:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[  355.956596] [   T1931] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-1"

