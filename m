Return-Path: <linux-rdma+bounces-10189-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 606D9AB0E28
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 11:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27C5E3A3FDD
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 09:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD20274FCA;
	Fri,  9 May 2025 09:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RJx4RMOB";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ddc+fHMX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AE92749EA
	for <linux-rdma@vger.kernel.org>; Fri,  9 May 2025 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746781491; cv=fail; b=KByrmZoEkvqxkMm+d+dUTKN/GzDWglSxILpYm4JORtMphe1EwrNd+IlyMa5xqKpdifX4Q6C3XeP6z0/3PbLdheQ5aMx2gMhn1brrAa2qt0r1Mn+TGtQxPT8CCtueHt6Uo5JkqFVebODaaBK/xKTlUUld/mNGlt2ESLOFxfk7kTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746781491; c=relaxed/simple;
	bh=upz9ZcI1qbpHs646PYcrrKWd86PJDA6nZabs1XbnWWY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GXXUsy7yvN5scdw5yS/aEK2W4cDnsmex18SWcKtvsBaPYbzyYPleIJ5snZjtdrwaf6o/j7ffAbw954sNdvJD4vHeZtW70sZAlLEyNXlk2TeYbX0WpXQEg2dnEth0G4nvUjoJcddWxwVr3S5qg5Hrssv49YB5DksM3SHGrHm8UDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=RJx4RMOB; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ddc+fHMX; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1746781489; x=1778317489;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=upz9ZcI1qbpHs646PYcrrKWd86PJDA6nZabs1XbnWWY=;
  b=RJx4RMOBy2NNhjNaC2Jc66OFi0m2FL9dwtilC8IgWcckAb9ngravvDGS
   USDlYPBltFjg5y4yQ7uNhXhzosa37nOyClJt7Gihd2lel0nu6Eq5C5L83
   3A7m/PglvA5FfkoRBaoYMz+2v8QTUg87DA81QGJEegHp3tat/t7dfdMND
   HGUL7HAiIdLZdGqnoW3tss7yhUGSS0R4gtmlsW5qwN4lBPKez88Atx2n+
   wauWo1g/rEljJysMKJh4EftJkf8w8CVVUoU2n/eyiIxvFyT0yObOmivqV
   +HPkbpq2W9ERImNEkuYh69qYnsBAEnOqmAZYWJ5ME+RxpFU3eJji3uikc
   w==;
X-CSE-ConnectionGUID: Dpd1LuywQg2d+qkDqUjv0A==
X-CSE-MsgGUID: Y3lpU9MoRd6v261rajuQ4Q==
X-IronPort-AV: E=Sophos;i="6.15,274,1739808000"; 
   d="scan'208";a="84738798"
Received: from mail-westusazlp17013075.outbound.protection.outlook.com (HELO SJ2PR03CU002.outbound.protection.outlook.com) ([40.93.1.75])
  by ob1.hgst.iphmx.com with ESMTP; 09 May 2025 17:03:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqed+/DLKXkA2vx3uX/iqhTFmZHqsbyli+u6M76eCSKu+U6t/hA7+usH0j1FmvKBRnqIeCK7QW7BRZtcDhAknQbb4fHV1l4Ckjz0+r8QM53WieGzI26mGOdLtm6z5MHN5VRCJ+IqdKAwFTs7Ga8mHTfxd/CAw8oFrO9HVdjhUW68hm0a53Vbd84WWtyg0Jq3cEVZY5ciIcEurD1pZWCDKQXndNfOhWSKcFHhyepSA7ILE7DETSyhXZIfhl1UxL3CouXINO0ltYSaBQ1b2RFu9EP7KYS0TupxDI90u+i4R3prEWOXELCut20Wrjstg97mMPsxatqyIjY7gEw9ErbsqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62eFtuUd8KvnqUxFSsMJG86gaQQ6f6Xi+24KBsUBQIM=;
 b=zFXZDRwnjoshqeUfsd3sqDUkSG1KG0zcZjGEHMrqSfNdsndzhZEJ44flgDnGUdR6iqIKZKQEJMA9pU2KB0aWcDQY4ekshR5uSlxGgpcwIRff2P6crQm5DjcEkY1Y1lkDY4WQ6BDJr+rii4lSCF9vNmdFNblB3EBvSjOZWzY6IhXZks5yWi+dVUjjB0C09i0gRQ079qxvxowUAaw4ZXImRqfCQ0dnobncrO9lHlNIsjM6UDbOfe+KtoVnCSvuZ5ODNETeuvbQ4GNbEeRhXsrEbAdiz4DLMpIK+jAV1cjFVvdXuj5c709Syw6tnA/dVNbNBvITHFrg07fxog3wptb+LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62eFtuUd8KvnqUxFSsMJG86gaQQ6f6Xi+24KBsUBQIM=;
 b=ddc+fHMXbjuz/DKnhcoFuBKalQgjP2OZCldHENOJqpJCc62S2rU9ZPn6SFgEqfsTjCTejf90cXb02m/MPjcU6xMFAlhNOHnRj6gpDRXnruNqppaSWIMWltKSJcekig9WJDh6Kf1ZAhXnxgKdzi7rOg8uCr++ghUYd2Uo9kuQ7RU=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH0PR04MB8164.namprd04.prod.outlook.com (2603:10b6:610:f0::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.23; Fri, 9 May 2025 09:03:42 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%5]) with mapi id 15.20.8722.021; Fri, 9 May 2025
 09:03:42 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bernard Metzler <BMT@zurich.ibm.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Daniel Wagner <wagi@kernel.org>
Subject: Re: [bug report] blktests nvme/061 hang with rdma transport and siw
 driver
Thread-Topic: [bug report] blktests nvme/061 hang with rdma transport and siw
 driver
Thread-Index:
 AQHbrfdhJhGSraouF0ezotWmIGdrJbOkzJXwgADapACAIstSAIAAWiOAgAAg4GCAATkHgA==
Date: Fri, 9 May 2025 09:03:41 +0000
Message-ID: <7iuwwbne4hs3rtnglkfhsqamrey6vgx3r2mgzy2o5jt4pqe52r@jpwzb4pjtbsg>
References: <r5676e754sv35aq7cdsqrlnvyhiq5zktteaurl7vmfih35efko@z6lay7uypy3c>
 <BN8PR15MB251354A3F4F39E0360B9B41399B22@BN8PR15MB2513.namprd15.prod.outlook.com>
 <lembalemdaoaqocvyd6n3rtdocv45734d22kmaleliwjoqpnpi@hrkfn3bl6hsv>
 <d4xfwos54mccrwgw76t6q5nhwe2n3bxbt46cmyuhjcpcsub2hy@7d3zsewjkycv>
 <20250508122539.GA6371@ziepe.ca>
 <SA0SPRMB000501945CA2663576E32B85998BA@SA0SPRMB0005.namprd15.prod.outlook.com>
In-Reply-To:
 <SA0SPRMB000501945CA2663576E32B85998BA@SA0SPRMB0005.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH0PR04MB8164:EE_
x-ms-office365-filtering-correlation-id: 2afdeb2f-761b-4989-47fd-08dd8ed86545
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6+wiNnW6VBAcpdu1vq5TpNP9bMxUdKqG3T++Yra/JDSUew/tvjRwOLP0QSwO?=
 =?us-ascii?Q?yIRWyIWQRMQTeVgb1gZT/2i56Oal7oXSONUUYqhJCrVIn+5KHCpsKRi9hDE+?=
 =?us-ascii?Q?Rm2NUaJ4bQsqdJ1m39/a5/eMCY+gCi5R+b9Z+Dfe/ldN0AHNty83tN5WO7Yf?=
 =?us-ascii?Q?TrnT7tNg8CbOR/e0xxf+AubelpyDUuTF8r1pYFm7s0phcXHYQE9f6e0ZvKqI?=
 =?us-ascii?Q?RuwjmaoCaA+PcD4toBJ8bwrQQsPuf8Vn7B6YqjrUbrraEHJb9xGUsETK9jMP?=
 =?us-ascii?Q?GmrjHlV7c7lKL6IOPTCZISupRSb04bhfv46i8OcNTIpIv3a/jmfBhxA5hqcq?=
 =?us-ascii?Q?2wj6+NdoQK605eld6WVknfkbObUKkOtFbHBBAQg3WO9hrs8w8MymgP9iF8ld?=
 =?us-ascii?Q?3JXeGSlaxti2CXKbn5Y463pGiSaAIigprMOY9ODVmbL9P5W3oZ5hJx4RICVp?=
 =?us-ascii?Q?Ze0y9yrKqCXgNwEWhvMuVsrPthDrMnzRUgv74b/6LwG0jX6FGfoYzQ2Au09y?=
 =?us-ascii?Q?nR2QTzcaXWfzTbF0kOJll4ro+F8w/zwZwzAQ40fauFcuUev1HyoB7QwQrBqH?=
 =?us-ascii?Q?gDb1aw6zAIFNiVGXBolmYH925gAbKpAQIRidAihqEJ0RpFq7tAq0CnztXKm/?=
 =?us-ascii?Q?L5yITdiIYsMqTUkzHfl9/nkp/2+4h76iWE3JVo73/Sz/IqfTg5ry+aSe5YbF?=
 =?us-ascii?Q?H6uIzoRImLZ5eMljj473g3gbHKxYDxGw5tt7PvbuA3COQcrZrHXJRfX0tgWq?=
 =?us-ascii?Q?uN0ND7UeG44TMjs9QKNR1ag+5an3vMGfjtP2nA+OHf7a2SsTkWGK3I/6RXGi?=
 =?us-ascii?Q?F53BpU36fZm6UYzC/qq1Q0gM4P4A0FheVrTn68hl3iCGuGjk8xY7HsQrRW+k?=
 =?us-ascii?Q?I8V7xlKMFckufy2Ftv5FK0IAsd+OCfKrI39kobkYT1oBrunsW9N+lrfTB466?=
 =?us-ascii?Q?qCq82nhusiCIOmirBOdW6DRIcWu7HhMnxHExvB+WlkzZ+cUstDXPUJu9PjsF?=
 =?us-ascii?Q?QJi9LEwfpn8Zc9HxkHXQl9/vNyF3JJ8auS57DxhGiNIedHQFt6YfzdkGFhVn?=
 =?us-ascii?Q?RvQ+2seCoMSmR1Y8SaJ7KrnLcILqjyoG+IqPP3HxiH9f2V/yHJ0GBN8zowm6?=
 =?us-ascii?Q?MQ0gxh6SehnPLAYsfVLx4/jYrCxG6CSRg7jVm5vNjL14tQpNAgPsSXSXGZ+J?=
 =?us-ascii?Q?3Rs86WgtNVVl8n1+SG5uRrf5naWCKFIXfNKqtYlJLqhRxqf2MFTGczyPgJC0?=
 =?us-ascii?Q?RWHE+2nHslZqpolNpAaEKLIlHx4XYxGKKL3h7LlS4+GJNlVSCQyQZ5fhl2ku?=
 =?us-ascii?Q?JryigHh7Pe/1G1pvff/PG+H1SPkjgp7ZHDrLsTZLhS3YmuWxvqzlAFsHyR9y?=
 =?us-ascii?Q?yqZ1ihdoSNu4+/xPdrzQ80OkoMj9veCZcSJll4duZVgMN1zFnplwaM1yiHjL?=
 =?us-ascii?Q?bLq8TM4t3cOrnRp8FJMwqWtvG2QA6CYjVreQbS9Yau39my2qP5X/ZqW/ng7F?=
 =?us-ascii?Q?9yGq57+ZCxK52BU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PcGO16199kDL4gpcCVsN0+SXU2CeWrBxARQ2yf4XAlGPjUQ0eGvcV0EnMjtr?=
 =?us-ascii?Q?lVpw6OurKXrafQXN1+NBNYWT3ddAORVWJyQbW1XIwh9KCzHOQ6LZa2i0TuS/?=
 =?us-ascii?Q?JgNezjW4bq8aoZuq+t78LmLUXS/kzjZymg6hwCW4F83/D1rD4yQ8yDSAj43T?=
 =?us-ascii?Q?6HaGw/9FYKzfqp15bQEh+Zi1J/dYZXLf58EIeGU9aEnb+VTpTneomRaDZWF4?=
 =?us-ascii?Q?Bpv7GfovbENiPMeQKhmjHTrrIGh5Jzx1FXVIbT1dgYrp5T3j2Q+OF0lh/z0s?=
 =?us-ascii?Q?ZJ35mZC5cE5RoVs0lPuQiGo5JhADBVx+twdpg+JZLYrXecliNjejkq4oj/2J?=
 =?us-ascii?Q?RD0xD+2MR2TGNqX2sR+q+jyxk1QEsjRiwUdreSxtMfDA4rmXXEezv4MQXwlf?=
 =?us-ascii?Q?H7Ml5CVOKkPfcSncfOEoYD7LAZTgL6QCmysI6s3kFF/KFwhUi1aK0SeO9GAK?=
 =?us-ascii?Q?OxQn+A3XPWJ1EZFTf5DgYYEjbEIl2j4vxPQFmM/VHyZ6qbnVDCcXzdcQlw5x?=
 =?us-ascii?Q?eHuH+5tktYKplUZp3JLRUGo6u9+PFRAwjk36NRRy6sOUINIKY/ATmV4zFqoE?=
 =?us-ascii?Q?N1UJMdHkxYVzGfLACr2eENwgSxz+XynS7afpQDO400FADObvMBMZulUWDcct?=
 =?us-ascii?Q?4+pTZmB1493J6dP3XI8oOamdSNmaPxcepGfJDFyen+r4x7xlQoj8zHofoTMf?=
 =?us-ascii?Q?bKGpJ/oxxUw8Yjyph9AH9Y7V7Z6hSiqQ6fw9pUT6OZYhpAAKrebObRPvaDE8?=
 =?us-ascii?Q?8azae+K4mf0Vd5GN55UU3VEbVEbLitDusHS/jfv+Mp4qEvIvdFS+q3Zoi5/O?=
 =?us-ascii?Q?L/vYVMebywVnXi3WmtHw4xmGixYVjpeN7Dz8Y+4laVL9QvN2VJvQKOvuhcyc?=
 =?us-ascii?Q?1xi+gyLI3EvEDGK+4vyHbtsAzSSCaHq6dGHXe//rj+wv3jFL58k3YiADQ+J8?=
 =?us-ascii?Q?Y6WkzCJ7qHRiA/9ortLZDKDbrb8aVVY3qq1i8qFoNlGrSe0H5uNRtaq8g4t6?=
 =?us-ascii?Q?TXyfrDpeYdFqd4zMo+1KqnnFuY4z8z7gL+55Lj2dxZRXwu2JYoe23YxQRj5e?=
 =?us-ascii?Q?e1W0odF35LmYQvmhJ9sYwlmax+qCZtarRBpA52U3+B8fI/aJNvOdQoV/240l?=
 =?us-ascii?Q?SbUGorVtB/Azjj0S3r+MJ/AgDihzIOZnVyyOmooGYKNMtBYZkB5iftNVgSaf?=
 =?us-ascii?Q?eB9I8cXVVKnVLTInPxR7fLiW83w89ULnSeGUh8xFa0ZPEjiSJB+69+ItX19Z?=
 =?us-ascii?Q?DcF1LEPzAxrTsj+18kya1NWE/ifpKAFCJtszXIenCrDQpD4aEGyraVAoHYd/?=
 =?us-ascii?Q?rpxZHxv8zwGM1yJQp2q5D8l8dRyhd9NbY6QgLSQQ3H1RTs42CiDq7sspaPYn?=
 =?us-ascii?Q?2Fo/Rhl9xCZX8wBFzvayQwBOxUQTqSjmOP650WRdKxA7ECVvNvXzlcJpVyfv?=
 =?us-ascii?Q?aAtnWXs2+8HpIffN5IOb5WYLDrSzQuFTJobI3as+ys7muPDdtKLFddphg2ud?=
 =?us-ascii?Q?jH+MXRAGsIvfiABssWYx1MQci03KMaTSRd7PaUn1xEwIfgzmABsmmvEhRyED?=
 =?us-ascii?Q?nl/CZWEBz/AtdObTrarRIzOZNcygHoNr2ZvspO8wGeLCwjFE6JeN7YmxeHse?=
 =?us-ascii?Q?Vw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A400CE69C6A3E844A23E5D9BC0534523@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wfqOLOz6BCdF4N+5lPL8wO/S2xEBfF1ssI4ADcR8Qfqqvss7+BjNZQJHQEm03QYALl365CZBK6hmkjZjyH07fR/nfFuIWz2t+tQXgJq/cZ8dVQ2/E2L6AiL8disj/sXHYGBs7KGbqHTwKGoGnZg0XaLFw6RBkb9GgvWtClTa3pbqwBAgzq0iCVSQHq9LOInp5cmZ9uf3C827wwxZ3RApY6R5LViiPTsQj+4qts7A3t4H+SjkqQ4oC/17LUkVzPiHsRu7zuXacs95n5hZ9In/FlTcsfZ3YtrOSKZ/OWLspZIl6dDFckYNGBnlBZMwdKvBMTu3vQxh8Y6WgVwqApObB/tpSC8plBEBL3uO6TmHKcBO8jp/KAdRi9RaakwI+DfXuH0Tdgjgcq4V/VG0gkY3jL7uDSFJ0a1FUoeqlOgbHICz+NSEHZiwTpbq3KFlYnKtEJKZeixZODbUTAGFvHv9qdZdfyffeXDyvmQzrcjwQkhjyW1PPowemXOT+JcMECM1gylgOcLzf8joz6bIjl8t2PfJl3St3GV7nnyFk4kmooY0thNPaM0jT5m9PJ2mdxZTS6/6CGnGC5ZQvvlSCUlQa18PLKnwlJvz8z1aN/Vi9cOUcuiOkF69dyglBbUi5Vw3
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2afdeb2f-761b-4989-47fd-08dd8ed86545
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2025 09:03:41.9428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q+hce8+27SXrDKUyL9qnuJj2gEzctRjtM/9xr10E+IgQ1PSLPzugsw5ZcKC2dy86JeUOMPpRkZJ7qPxKbLcY6TL3LZxoyEBOvPc4Vz3HaAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8164

On May 08, 2025 / 14:23, Bernard Metzler wrote:
>=20
>=20
> > -----Original Message-----
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Thursday, May 8, 2025 2:26 PM
> > To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > Cc: Bernard Metzler <BMT@zurich.ibm.com>; linux-nvme@lists.infradead.or=
g;
> > linux-rdma@vger.kernel.org; Daniel Wagner <wagi@kernel.org>
> > Subject: [EXTERNAL] Re: [bug report] blktests nvme/061 hang with rdma
> > transport and siw driver
> >=20
> > On Thu, May 08, 2025 at 07:03:03AM +0000, Shinichiro Kawasaki wrote:
> > > One left question is why the failure was not observed with rxe driver=
,
> > but with
> > > siw driver. My mere guess is that is because siw driver calls id-
> > >add_ref() and
> > > cm_id->rem_ref().
> >=20
> > Only siw uses the code in iwcm.c, rxe does not.
> >=20
> > Bernard? What do you think about this analysis? I've never really
> > looked inside iwcm.c..
> >=20
>=20
> lgtm!

Thanks for the positive comments :)  Later on, I will post the fix as a
formal patch to get it reviewed.=

