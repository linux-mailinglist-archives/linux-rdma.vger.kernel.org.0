Return-Path: <linux-rdma+bounces-6923-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C56A073A0
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jan 2025 11:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B94811888C25
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jan 2025 10:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E6E2163AC;
	Thu,  9 Jan 2025 10:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nwXQbSGB";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qm7vkD6C"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB07A215176;
	Thu,  9 Jan 2025 10:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736419507; cv=fail; b=JkkdVuKvo0uG7f2Co0Rq/itPQQxD1+n+/bpLQPRVf/xfExS30wN+sTWKZLbLx6d4t/ae2+XANzUqGXhObkEmQyAg8ahbQqVjtLzQqDRzjIDZqyv/3XzKG7dnzZ20u/kflbiz86qI3E6FWs1zFocy3K7ZF0GHxX0oeld2IywvyjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736419507; c=relaxed/simple;
	bh=TplwOKR+cVVw6U+4KjUsRRPONKkmAElFYf3TEwQstu8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TV2Ae7dCMnNeiAGDnv0Rl1S+caabXN4AgllwfcwSh/dn1AkAbbpf4vLO4Mm8GvSxZzgR9EQe+UGiGdzCCUzXQUtw54Nj5rr3u4sFccvAKWbJX9cKKEt/5c4itXXP+Uzn5Uv5g0C+DSgIrZ08t1xWH2/cPXyvJvfLllcu0rJX8rY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=nwXQbSGB; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=qm7vkD6C; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1736419505; x=1767955505;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TplwOKR+cVVw6U+4KjUsRRPONKkmAElFYf3TEwQstu8=;
  b=nwXQbSGBYGH9bdx4ndHZOenTTg02zzdTFknpvdpxJ/5eQSjrOVUkPkFw
   BVwgETOkzbYKOhn9KiUokx9U5lzz8Bs9Ikr3ldShk90GTSkeGuxnOIo0y
   dEcQdkIV6MOuU4b5VfQ1TZ/IJymchXvSkSXAvlhFDN7FyNy+Uy0oP5jB6
   /mGVl0JQOnMHvvNnx8lRyxYfvi0O0H6lLxmEb2Vu9kWHdscm/fCy1/qrT
   0G/i8H/h8/oziYF6cVSVkQNVgHupqLDrw9L0CGyj5ONPVuqhYFFhnTvUN
   rSeBZXXTq+EmiD/ac3zgfl2gO8tmmjiYdOXHq10vNGgfHPs/3ZYqyZcps
   Q==;
X-CSE-ConnectionGUID: jSPijTnGShS8d1HL27xeBg==
X-CSE-MsgGUID: jmzo0LbIQS2KUxrNnQW6cw==
X-IronPort-AV: E=Sophos;i="6.12,301,1728921600"; 
   d="scan'208";a="35344247"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2025 18:44:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WR0L0htFBpxzWAkx2c5PeneKAZKEm3rybLLDAaLAzSDLIpNc07NYQX+m0QSlaXDYp0NLRtAneuS1khiqQv+YDrrxIxBtHDmT1mHnMBInJV7SOBwx/o+rt5ybAg/V3/nDiCDQYZMTGzQ8PA28JIP22v2mUchOAaRs5xvbiU7CEDlbo0T9NENUcnGt4xPTl555Y5fSsuRBQPUcH+JttICjC7k2R8BFJM7qW8nyzL8NlolGSQI5mgPsob5gpxYxwZ6tRQbcu1kNK8mREdt7/UB3K6FzXnLt0nX1brLgZJ49p+ZtY1rrQ7LjINJ3pBmpH07SyPMnNBIL7xL6G9eXb3TOzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDp8MpbbBRJOXSuRearBp3DmZ5vYr4jFRlfks4p5tbQ=;
 b=xZUjyUG7xQ3AYJfGLEf2iX+E858eZDC2qcYHx3zCIVpm3xFA0/eClrqGSZqpUhNqJ8nYm89yM/KT9vHn5xnoCshFlYP1XhyTBIo97L6DsyFgPdC5Rid17pnc3oAElKmPYJzbAgcHC7aXIEfHBeCaJ+8fwimXMOuWgubx4niVY6J4ulIhrGe4UhtNv3ErQNpusfW1WWMao+WhFRShkOQFd8LqTyO+MhKNdq2F1byE2oLRSk4iT0aG0ZiJ0blbBjgwr61HtqoXEuF6p8X6nJWISPz6TVSuqinhDsJ7LW03BBqh5JyTXFJ/gnuEdx1IvS7AZ/HbmjYPcRKNmdFVVypTAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDp8MpbbBRJOXSuRearBp3DmZ5vYr4jFRlfks4p5tbQ=;
 b=qm7vkD6C6Hr30KwYfkCYJU0ci9KoBnC2Crx0AMZbR6VBpl+DPEyOp3txTMmXetT8aLU0YjXJE/b90CGchH9F4ZtYrQ7Ajtq1H+4odrNORYiEPDYL9YyMv3rwak4mK/sGBFt+bsSMxuwGSiWbf31956vuq21swUkEQsc+NycMMWI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB6802.namprd04.prod.outlook.com (2603:10b6:a03:22d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 10:44:56 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%5]) with mapi id 15.20.8335.010; Thu, 9 Jan 2025
 10:44:55 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Li Zhijian <lizhijian@fujitsu.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Jack Wang
	<jinpu.wang@ionos.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
	<leon@kernel.org>, "Md. Haris Iqbal" <haris.iqbal@ionos.com>
Subject: Re: [PATCH blktests v4 1/2] tests/rnbd: Add a basic RNBD test
Thread-Topic: [PATCH blktests v4 1/2] tests/rnbd: Add a basic RNBD test
Thread-Index: AQHbYMqcvOvT24ZncE+qP39hGUUFA7MORXMA
Date: Thu, 9 Jan 2025 10:44:55 +0000
Message-ID: <pdx26apbo6fzl4mrlxsakhpdrswsdizg7yvmqgptzgfbxdmteb@qs7ygbney5zd>
References: <20250107060810.91111-1-lizhijian@fujitsu.com>
In-Reply-To: <20250107060810.91111-1-lizhijian@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY5PR04MB6802:EE_
x-ms-office365-filtering-correlation-id: e0e5f2a1-120f-490c-1498-08dd309aa7de
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?60+EO21RxuUSXHkjIrdRv6tQ1iJQDWXrfPQON9pDk5kmDeqEmiHR1nI5AfZB?=
 =?us-ascii?Q?9lvjHcFYDFdj1aDMXF07HBpVEMImdG/g1Cvw00yj98dSH6VWQDcFZOb8R6tt?=
 =?us-ascii?Q?RyNjk0NXPh0OvDOW5EKnkhfTEy2SJMKbeOiqk60PoKpcFChFnuCsIcSfQouI?=
 =?us-ascii?Q?jfvQuHSCjv7mRuH3sbud2nlec/sbXv8UCo2/mSbL63jI/tgXTm7WuxAEhflX?=
 =?us-ascii?Q?5XjtQbXGNCNaxCIXDZMetavxCNs/LvIscmS2lftY1OWvAY/6Vjgs5YTkzc9b?=
 =?us-ascii?Q?O8QTINPiWuRaGpKuxwg5L4z1+js7XVLef1gun3B74tdxNhu9DwTVnhzcz8Pu?=
 =?us-ascii?Q?HYR2EbR8mpEF/dN2aQhUoBboaKq+zQQHfdQt1h9j0dPXu4rdO5D18SoD5hIb?=
 =?us-ascii?Q?bNh6Tq97NijOYPRIDjvXglB+qKOvYTnCuKkh8/iQ5kTIHdIxgcH+x5QXvHhO?=
 =?us-ascii?Q?zsfGIi94yhkVgniK3A/LcVnQz5GcjoWsadQncC7YhCSX+w6Ilndlw9IplDqg?=
 =?us-ascii?Q?ev4Z/TG9IhYoQYV5S2W80DmduyN7ezwjglMyPnejZG9oAP8dOfCr9MXawdMX?=
 =?us-ascii?Q?LGaGu07hORQViWfaq2kR06rg4dss03ed5Qhkf/M+06M1ibMyz/d+tx/r6ZT1?=
 =?us-ascii?Q?DGPlmQM/p6TGUaL1u4kk+SLNUBuOv9Ktshmj9B/5uXfUsGcZSSteXM7pv5ch?=
 =?us-ascii?Q?pInu9LhmEuGqJwGEUvoSya3FTqKDNTkF49aP/TFSgNMS0qaWqORN+VDStrJN?=
 =?us-ascii?Q?T+dwfA01hujze5W3PneBsHEuBNexfaIMidh8uc1liLQkNqCbfxXZZEFXWjwF?=
 =?us-ascii?Q?zr+rE3iPLQ7AccxUyAJ4WzRl+K/Dm2ik/qrJx036TA7qJyehuufScChPFXun?=
 =?us-ascii?Q?LtNymF5X6OMjGz8/0VMusRrfqjkmMovbaYILmWBOmyV4WqfqvnxgaZakj68L?=
 =?us-ascii?Q?wEnnU7Rley5Uh0C+xBug322qZ0RZ/qGY9hCUVYA1hy7X8/XFuNsncXF9SF7X?=
 =?us-ascii?Q?iN4na8EKvepvhVhLyPGZdB6uTl85lGy+1dPobKRzCV4nv9Z0qgB+FX3V6beq?=
 =?us-ascii?Q?olJ5P+kFkRU/37l9NDKkXC1L6T1wW6fxDx4iweUZhXOnM6Sno8yCotxbL7eV?=
 =?us-ascii?Q?K5fMJZHtpbS48zltevyo9xT+yZSq5A0zo2HVM9gonE+jzkmmWB8WT0aseRWJ?=
 =?us-ascii?Q?9TbCy+ZyJqYyKgadmOAiu3d3jZMot4QuV9Tu5qzaU/UMh615T+1EdCR62/pz?=
 =?us-ascii?Q?ciRvrsw3trp1Oc+Xoen6NCRtKhRm8awzgR8lE95god4WjSdVSXK2I36znDqR?=
 =?us-ascii?Q?+Avcj6mnvMzFVJq59wRKKcb4syUHqJypDcedRl6YW6WGZ7KKbqGNBS6kvVpJ?=
 =?us-ascii?Q?RQXeSlLZdwzAIi/3j1k1I9s0Bwa0kPjLhZ5AXi6qhcOkOSv7n+o77+1n0m2s?=
 =?us-ascii?Q?Xb/623QB6cuXsYUpeY6jI7LgFV7nlCR1?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5i04y1mTzLV4cdwKyNZnwE6JrMiRveX8qLssYQLd2nT8cliCACoXwiIrZTy+?=
 =?us-ascii?Q?hV47ft06iTnHXRCx0nTDBkinFKeW61tlE+ZRjeZKdhNAHVnUy5nY1MV77fSY?=
 =?us-ascii?Q?8G0doUaVlMPw7pm5vd2MT9p1wHNPYs0ZPMK8o8dORKiA8ut3f9TDUBP3iP1/?=
 =?us-ascii?Q?h7zB5ABgpOhWcfidzcZk64nQLFX/k7H0xsvhzUc46QguD/rNXoMUgpc65z1a?=
 =?us-ascii?Q?BWjn8FOWAAXHiIRFvwUxHd108UOFypX43V8iacnk/lfQwMnoqTJM+qxT37hP?=
 =?us-ascii?Q?EX9JK6U09LGgjEis+JAHh6z3LO0ynfw2u2/MV32DEwOfrxAznonxx8mMlfVQ?=
 =?us-ascii?Q?LPbmwM1EyzGtngWQ9TVkd9IEmVAryn8lrlO4z1/oshfkemHPJDejh8Eha1CT?=
 =?us-ascii?Q?81LenEGK+hxVqgoVFtmRHov3h28rdSqzxyblU2QNv4HWZ+kU/ZxMkOLWQn+W?=
 =?us-ascii?Q?9OFIJS/ARFcMfVbQznQNF7mIo+svrR82TsnEgWXb1f1MI9SUc3v5p39yMf7T?=
 =?us-ascii?Q?UPcpVjXeusDCamwkT602urpj82eo98F920o3pit1vtYjhuZwe2jK06xmNJc/?=
 =?us-ascii?Q?kQkuf981SC0JFl65GQwfzRACCNJf4TpBZ6rZQ+1UxQtlKZzrGtsUPKBujPzu?=
 =?us-ascii?Q?9z2P4G8y/5v1qhilVaxKI7v1AfKshb83Wctz9moeCabwMWiURWjLj3PtiHiU?=
 =?us-ascii?Q?9eELGlMHaEG0XavQsSZYc5as1X4lODK2BAifQ+jhInvA0eOv+aejS2hjC494?=
 =?us-ascii?Q?aGi+ruAYmbIg9LKhvLWAnPC288l8+ztdeapo4lkgG7CpyZRIixcp2vJosvYO?=
 =?us-ascii?Q?SHjB9oM0+gs2POLrOFuI0LUwdrJ9k3YWpJRSgdCRepQI1qHPUOQ0LaATT03y?=
 =?us-ascii?Q?UoA8zwfTxUbzb8UnR7g5OPCgMdLRouOl5neqz5hVTcEL5/PX9PzqgjpHoA4+?=
 =?us-ascii?Q?4iKmm0m65K2hMVjTTAR3L6d9oc/M2W4Go5JNatOjZl4uaK6eXnGrhtGCySUa?=
 =?us-ascii?Q?FElotw2UJed4/oyVC8FHSwGwRsjydsIxTg38ykmy4ULpBIFIBRiI+vlSkHrU?=
 =?us-ascii?Q?RQflhjH3dGwLBl9LXAkXa40vONS3BdRqWE17g8niq2U/zs2VhRL7S3BEYWMh?=
 =?us-ascii?Q?5mqHl5csktriCBQBpwHHUCKXzJTK9xc4ohQTjfUcnxfEb8SKBBFIHZMj9Uok?=
 =?us-ascii?Q?icaGbrANLHxQgfCbvdbBfHDWBpIenvtvCu4sUohbNvc/dkCt86My2E5Uz5Ts?=
 =?us-ascii?Q?O0ZMUOC1cxEqtj4YK5U9IrYreLXd5iD13Dd2g95oLt6155soHP3dtGV1KPZV?=
 =?us-ascii?Q?xnkeOKxToVtT3VSOEJSRLBYzQa3GdYxIxxv8xYCVhzRpCOc6ZJ/d79Znf7R+?=
 =?us-ascii?Q?rwLq70ORM8mN440WHDnnYvMwg99xGmKdlmf3z+5yAT9IOuUFnHFtqRKywzlg?=
 =?us-ascii?Q?WX3OBcm/6EGqfWej6CT22a9XX6zBlqq2eW8B8snfJA7DoCuysBkETGlGtrbI?=
 =?us-ascii?Q?Q2S8ula/CE33efiYQTtf87ePl0y0kHTxYpWVSP2RIrUN4aUVCNX54NZufwuN?=
 =?us-ascii?Q?YwdCpl7P8bpnuzbgu/c1qt0PVmFYeR+SYU6y848rpDoD5hXNFa0XdGJJVCvj?=
 =?us-ascii?Q?EbjeJ8H3HIBrK6QV1p3cuDw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F05CCA794CBE8A48BB8D035874C16EE1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9bKVy2ltQ2m1olGm8gZcQkne7Qb1Jsrw7gBpd7rrkS9yMYbRKnBX/Imej5rlAoaBb2RjDr7F8cWaxzRtRlbwQoKxMoz6dg1JQvrKl4zvZ/hIBp6fRhJKhRTuIIuKfGMZpSJ3UaHxEG93u7uE2d2BF4TiYQJvo7mhl2EfgDDzklv4K4S4qi6FYzaN1K3meBzT/LEsS8aH9kLeC0D9E/sCWoBXgBzjYE5w/6yGGJ9RspLn/SZLHvyshNxyiHykU2LmWGLZxkDR3V36d3RkPoB8he4jAFbhwJNddOVUoYLypbMplrixnykqGvHMG9gFcP3XsiuUPIKB8xQp235qjIiBEutSG5j+bvBGQZQmHGjZo+9rCkn3ROzAIOVXLTvZokmJ6KBgQX1k88kbQuWBFN86k1nVJfo/OuqDXM3QyfUNjvnHeAuv+isXYtyGuuzOgr5ruWRevaU7PY6pdbdmSPtbeMGKWkEMXIXkhJqzspAy3VJfTaBPyQ2Dh2sv77+0kfbSH2IRwFM+/XRV83k/7SM3V6OnJeNWRgsMfteAXt7YzngEJ3AU8L+2kcDAobT1OzSJcaCfQd6rh/P/iuo1qMAH0SkR5IgWq3ovpKMgh2lldl9PdMmg5A+g+hZe13EcmYO5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e5f2a1-120f-490c-1498-08dd309aa7de
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 10:44:55.5378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qpb+wavKUKAMZXdm5vwMFR7NXiOZwfPdGAYfs9n7M99yNwhudThrEaI1fcz3h0Gzi3o7+LQUUoB/LQxGl6yzngBJXgKDycyR+Om27dED6go=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6802

On Jan 07, 2025 / 14:08, Li Zhijian wrote:
> It attempts to connect and disconnect the rnbd service on localhost.
> Actually, It also reveals a real kernel issue[0].
>=20
> rnbd/001 (Start Stop RNBD)                                   [passed]
>     runtime  1.425s  ...  1.157s
>=20
> Please note that currently, only RTRS over RXE is supported.
>=20
> [0] https://lore.kernel.org/linux-rdma/20241231013416.1290920-1-lizhijian=
@fujitsu.com/
>=20
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> V4:
>   test start_soft_rdma # Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com=
>

I applied the two patches. Thanks!.=

