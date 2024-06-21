Return-Path: <linux-rdma+bounces-3396-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C60912452
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 13:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CC3B1C24028
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 11:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7641D17A92C;
	Fri, 21 Jun 2024 11:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="OC48s/QQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E4D175554;
	Fri, 21 Jun 2024 11:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718970378; cv=fail; b=qhneWj9KLrUgxliiK4VDrYQputnr88co0A1Guruzc+qLPEKEk3TG8VQhCVqFfk/GnYnPYpdaqvBY+ZaKUC3DzD0mno3SI1n6qND09AJoIaom0fpVjpKNOTqqeioYQ9Hji0hoBfTwu1J31HrmnzC4tyHqlEMA9oF6vuRL34Pm+4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718970378; c=relaxed/simple;
	bh=BoASb7XpOyInGNF9sLYWtFGpAMp63KM0OHRH0bIOidk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MFFulsRjVzsM/Fx8X6dL/0b9KvPOdoUnFjbL4vHGWmy37ylpYAH7Q1txCu7U3Y4LmuelYmZrl9iiKJkG54Qtg7ULkNUC8EBFWPml1Qt9uje6MtlBOmp156UgQoI2RXugl+lWTy9uYk/efwF13YxuzSz+6Ie97rdE/EZ2Gj+dJDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=OC48s/QQ; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L9Le4Q008837;
	Fri, 21 Jun 2024 04:45:32 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yw6t80c1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 04:45:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5FZfeFwyNRoSN+heMaYsU8iJZrrXD51QL7RDldAOR+r7/ehJcwsifdTQdraUbI/0Kxpear7Ku0z/FLyzij0eUgCyh79CMy79DjmbkJi2tWar1yf4UcANiPPlJZDPCx+WeUnCttXudU9wN3zaWEaJtl8jVnhy7kXbPJ4NuXHIn5UN7hkNuNqpW+6ZkrsWRb+DhqEQh5ipz6BNEUzwWe8o9P95D8WJ0eyiJoQrm5luyyMIXQdwfbcH+S7o2OIaoeXmYXe4T/tF+e2N4V0m06gyceWz3W22FrTYDnskNx8A7QI98UQwrVNmraqOhRsuTaOwzauP3SfMGvOj4DXcj0adg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZyzYS3ppXa3qzU1Uq8p8IpypH29zvHCAk8erq8Zp6o=;
 b=jqKjfrn9dhOEgzz1JhkkM+6gvLyC+Ee8Bf004FsSQp+iR79p3tHaJBCPEetLYDO3TuUwUtomiKyIXXKyktjWtTd572iB4tzTYI6EJGHxBRkbNPxLPWzCT4PJ7UTGuNVc4P8jC1Knd2TDgJz0iadAumbtrb+qFgC2+abwmNyQwTkjKM19GG72jcv/GZEk2GfLfaXwl38L0RngMnhOMLOaTcp0ih2IZvkfLPcWknHqinKZJo5VkUcTpxjtpY4q55aeOYk2GKqSa4KuMjGyW0+g8lHiiYPmXV+LwKptcY+BxtcFGTk9YA2VcLF9mdI+5t3idjmrxOvyOHZy+qV0gCc5rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZyzYS3ppXa3qzU1Uq8p8IpypH29zvHCAk8erq8Zp6o=;
 b=OC48s/QQ7A/0hmYoXCNrAZUxdAKqTtpWRJ415FgPRxbHZ7OvQP5Dht2/x7k1XPLSf+qKKhxuX1VmyECq5wbgI9jZ5WsVR0H6HBAwFqOgyf7EIA9s0yiAONkrAJoVVusuIRtEnxSItV/rTB7bkxuIYsqLPnHRp5UvMSnxSCZsK80=
Received: from BY3PR18MB4737.namprd18.prod.outlook.com (2603:10b6:a03:3c8::7)
 by DM8PR18MB4502.namprd18.prod.outlook.com (2603:10b6:8:3b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.21; Fri, 21 Jun 2024 11:45:29 +0000
Received: from BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::1598:abb8:3973:da4e]) by BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::1598:abb8:3973:da4e%5]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 11:45:28 +0000
From: Sunil Kovvuri Goutham <sgoutham@marvell.com>
To: Allen Pais <allen.lkml@gmail.com>, "kuba@kernel.org" <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
CC: "jes@trained-monkey.org" <jes@trained-monkey.org>,
        "kda@linux-powerpc.org"
	<kda@linux-powerpc.org>,
        "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
        "dougmill@linux.ibm.com" <dougmill@linux.ibm.com>,
        "npiggin@gmail.com"
	<npiggin@gmail.com>,
        "christophe.leroy@csgroup.eu"
	<christophe.leroy@csgroup.eu>,
        "aneesh.kumar@kernel.org"
	<aneesh.kumar@kernel.org>,
        "naveen.n.rao@linux.ibm.com"
	<naveen.n.rao@linux.ibm.com>,
        "nnac123@linux.ibm.com"
	<nnac123@linux.ibm.com>,
        "tlfalcon@linux.ibm.com" <tlfalcon@linux.ibm.com>,
        "cooldavid@cooldavid.org" <cooldavid@cooldavid.org>,
        "marcin.s.wojtas@gmail.com" <marcin.s.wojtas@gmail.com>,
        Mirko Lindner
	<mlindner@marvell.com>,
        "stephen@networkplumber.org"
	<stephen@networkplumber.org>,
        "nbd@nbd.name" <nbd@nbd.name>,
        "sean.wang@mediatek.com" <sean.wang@mediatek.com>,
        "Mark-MC.Lee@mediatek.com"
	<Mark-MC.Lee@mediatek.com>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>,
        "borisp@nvidia.com"
	<borisp@nvidia.com>,
        "bryan.whitehead@microchip.com"
	<bryan.whitehead@microchip.com>,
        "UNGLinuxDriver@microchip.com"
	<UNGLinuxDriver@microchip.com>,
        "louis.peens@corigine.com"
	<louis.peens@corigine.com>,
        "richardcochran@gmail.com"
	<richardcochran@gmail.com>,
        "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-acenic@sunsite.dk"
	<linux-acenic@sunsite.dk>,
        "linux-net-drivers@amd.com"
	<linux-net-drivers@amd.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE:  [PATCH 05/15] net: cavium/liquidio: Convert tasklet API to new
 bottom half workqueue mechanism
Thread-Topic: [PATCH 05/15] net: cavium/liquidio: Convert tasklet API to new
 bottom half workqueue mechanism
Thread-Index: AQHaw9CD4nPzgxz4+U6quzdtzgriow==
Date: Fri, 21 Jun 2024 11:45:28 +0000
Message-ID: 
 <BY3PR18MB473714180BFCD502E76112FCC6C92@BY3PR18MB4737.namprd18.prod.outlook.com>
References: <20240621050525.3720069-1-allen.lkml@gmail.com>
 <20240621050525.3720069-6-allen.lkml@gmail.com>
In-Reply-To: <20240621050525.3720069-6-allen.lkml@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4737:EE_|DM8PR18MB4502:EE_
x-ms-office365-filtering-correlation-id: 491cdb6c-071e-4ee7-43e6-08dc91e7a5c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230037|376011|1800799021|7416011|366013|38070700015;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?KGYwRcOdqNp5EM40w2MyYWWcPNRj0apMKpBE8cuSyszjImBuLZ12iSylZUSA?=
 =?us-ascii?Q?9fw6LoHZkA8yboacf2dxcKDIhH14nTHZFoH8lxBtchdKqL9R8khthAsk0jLZ?=
 =?us-ascii?Q?TQWKq/Ddx44PAGrLLnOVPA+UWQMw40KZEfWV0dl92zIJkUdFOKzW/uJ5RBTa?=
 =?us-ascii?Q?3TIdvOX8wJkAsZi5saMsGKynYoS/69+HBdPgJYjO/6hvLWL2rP+ihJ3Qniwd?=
 =?us-ascii?Q?6VIRogcPK5cU0HKkmk5CcyOp7dePu8j5KqiasO2glkgACHGoTqAa7gbWQVeO?=
 =?us-ascii?Q?/sdr8PTRQaDP/kBxF3/WiQknqyoo5jiQwYwBh4u87dZDJ9ca0PvTnhMldv/I?=
 =?us-ascii?Q?jRr5rmKHtE7KBSfEsUllbjNzOCysevkIy8ruOZIbWyVbdi5FWt/hwdl9P2Bt?=
 =?us-ascii?Q?+TPLkpFMvtdGhIBlJqQgqiVa0TBQQIfru8w4quPiMyN7+UmHjzedQ/4wtq1f?=
 =?us-ascii?Q?OqeOT80Q/jcX96yXf4H+BkzAHTM+GQoTRMo8gTFq1cGqUUxW0BsrvNO5dXpe?=
 =?us-ascii?Q?W1FUGcGhUOSdC+NmRXwr+mwhGNnMsWuDEdENrFfAV0o7v0s9K77D1oinckdI?=
 =?us-ascii?Q?XUhvsxLelgGzTZP/oY72SuNueQRI/fawIw/HgiK5Xvb/NhM5Sx5GJZFS28iq?=
 =?us-ascii?Q?od1tNo+lxMVKO+pA5Mt0Oa6HIoEqNu2mqvKyjB+VwkrjgONk9fs+HnYQor03?=
 =?us-ascii?Q?u1EPBGPa5Z6c3jDnqhd3ZWX0j32vmHuW9bBy6gofytZ215DgBD2hjG0p34UA?=
 =?us-ascii?Q?1c9+bRYCB/OWTf/3rj5NxI6+wfjuftOcwCkSU+KpeVsE4mxLEsrNrnzokB1X?=
 =?us-ascii?Q?7JiG1MjA2cFSzvnnXDMf/2OPuufa7uZ5VTdxJQI1BONHMN41PvLlYzkugUCK?=
 =?us-ascii?Q?FdrSmETEXefDniWrgq9mzhR8ZBGBRRvEELecM7LPgfW+je06K5AzH9xpvhYT?=
 =?us-ascii?Q?UYuQjDpYQidUKcsYNh3clRHb+VCwNKMePcvKTiGUzZusMW0Hl865lWePbDjw?=
 =?us-ascii?Q?rrwBcD/jOFqkk4nGrl4f0m8GqIXOCxyHK2kl1UPszwU2lDVywlVz987p+O/0?=
 =?us-ascii?Q?Spcq2Eq51AE+S6sHLcC3nCi6cJ0I4GtN/QQHDaLZEEEMf6MfaOZRI6UrGyF3?=
 =?us-ascii?Q?YoA1oJS+z/FciCqSrTfxLPRY4G0k29ctJmOCqLMydbQoE262p9UyNb6ceviJ?=
 =?us-ascii?Q?81EjGj1Qx8ZgtCtzSWijzc3mkqBACBK8tBA8ynsDmpuHrH2ViQQWlNos0iIp?=
 =?us-ascii?Q?V2X2phxcSwk9EnW8dSgLDouTa0t3jOzu8Ebw7Vb9BjJIxhv9g/GeuoAT7RVr?=
 =?us-ascii?Q?HhZAQQ3+QPKmiPG3nL+y+jtz0Llzhzazr8SPnfMAB9oHEBEvq7AFscFxgiux?=
 =?us-ascii?Q?mk40ZBg=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4737.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(7416011)(366013)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?inz/IkSBZ6Zevrcg3OaS93LrpYxVDJda3/YdN8FdcdXYXQFPOwRHrO1l23Kf?=
 =?us-ascii?Q?iOEjFceaHmeMLqDTowFHuTPZKz0+3S+sDe2GBFA2U38pgBdaCev5JnGJ2Dy8?=
 =?us-ascii?Q?XO1fz+9SJAUka85x3DiBRro4lAtswpoFSltmhMKbP2/4coUiZq0MTxLNEQft?=
 =?us-ascii?Q?ECOE7zDgni0m8PFHCLKh/luyu6JsiCAo794JAFU7PGuZH3+xWvWztZhWx5XH?=
 =?us-ascii?Q?uuyNHrXE3gY3O3VTg+rohGax/bRTKyh7h/7gqHm4kY7Gtpsds7ijJ/ztWcV/?=
 =?us-ascii?Q?3d6MCSX7jaCPuGEVEmYd1lhp2OkhBydFnQk0UUKVSw4KxaAkAMQryRz3922N?=
 =?us-ascii?Q?EBdu2TcA1ayK650PhIbFh622zP6IW+20EGfK/dub5YPgpiYFfOMN78qQ/L7l?=
 =?us-ascii?Q?JssHePKTH1VBJY6/JK4z2c6mfRM/uqdNOCLeoTJITPSemmi5rKhPDBgDh+N8?=
 =?us-ascii?Q?bmz46mXOWCqwBYt/LiX2Eu8kL7apdl5NthNaPPRZc82Hja57tKebmOT2z7m3?=
 =?us-ascii?Q?DqQ7mJHZZ9uf/uxGQLiEpX0KHrQ0TZ1cYUs9fCNWObs72WbI7Ea7WWaVXLaV?=
 =?us-ascii?Q?8JDIyiTG8CU86xF0BlqEuH8rnjSyQ7YROwln3H9FjyEN1mfzWhyWrX4+IoYP?=
 =?us-ascii?Q?s8iX6xyNIQZ1ko4pKz6hCzYGf5tVAeB0bWsu9a3HJmnlOXCVUIY6YEFR9fjR?=
 =?us-ascii?Q?6NBJ7+LPPQyPNcjB5SKkEPQ58Lgcd3dd/31mxU9FqdJZdyvbdIM7G7LM8FNc?=
 =?us-ascii?Q?nV8MBim5gILMXIqS45ThQ+A6JSOU8BvwvodOzrfH+eM6vOBGypvzXvV2hA8j?=
 =?us-ascii?Q?h4u+/BeSCpL+CJKNHyM/1/VN/tiryoPIzbxSATJud75PpIuIZhNJX5/Hgj7t?=
 =?us-ascii?Q?9H7DOBCFQjtmz3Kr+j+zZj0nv38fAXWrDEi3/bMguDd44/21lq06/5NyAP88?=
 =?us-ascii?Q?NfP8koO9hSGRuFwigdO96/lv2X3YeRV1m3qA7w0fAoiHUmb9P6ufCbaaWZDp?=
 =?us-ascii?Q?urMthqssmeYnGX/aSOkY+2PWZoYrykcS+aC+wm2nXy0EaWXQxu0TuEIm0FFd?=
 =?us-ascii?Q?Fza0cFqcIILGCWAdQqxhXkRphla2+nSQ7YIuAz0SFquP7awoMksqhHd0IGmq?=
 =?us-ascii?Q?13R7f4euwXHcPZA3lYc2dzRQ7PnwzCUfD3K58Rs2D4kEJC9u/c/zBFH7cwwD?=
 =?us-ascii?Q?vxxhkhkIQRclFHjlvsZcrfksOK2wPcifkNidcZffb8GiD2mOoMw2zFPz3XYI?=
 =?us-ascii?Q?JNxIouSW+6RI+EII7IP2BGa6NLvERTJ4msSc+xPbshRefInQCOY8IIJdWswr?=
 =?us-ascii?Q?V+pLG9A2CQieYYbrjzDB1bEYa0+CsAKqfMrrX6NmVo8qzVmcc3zMuGuumG+K?=
 =?us-ascii?Q?sRlZGVigLocH+yihL18QDLv1bfmdpnTkLqT7xo1uAxugzhRIa4MpdDIhW0fx?=
 =?us-ascii?Q?+ySgYmwAYbIMGjmjSVXccICWIqtf57Fn9oBKkBFOaMPpcOtN1GpaND2Ahge6?=
 =?us-ascii?Q?2ybWD0qnfyXQkr5sBYvndx/Wvtal83BtbpnJD3tO5LSCqa13Ge8KpJimKOnf?=
 =?us-ascii?Q?yQH+RXxaoGGe8iPzp6H+kuu5ZeNA8phfaJ9pqLJS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4737.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 491cdb6c-071e-4ee7-43e6-08dc91e7a5c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 11:45:28.4000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X37oq65ZjM7zfTzFVVNw064ZrKeS7m9050P31R3awLRWI94PFwzfBP5r+tTtv1Mdhrp0Ol3Bg2b5qDyyvCUg5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR18MB4502
X-Proofpoint-GUID: 5kzzFU-x69O1OMf-uYFgKQIjOtYIyWmB
X-Proofpoint-ORIG-GUID: 5kzzFU-x69O1OMf-uYFgKQIjOtYIyWmB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_04,2024-06-21_01,2024-05-17_01


>Migrate tasklet APIs to the new bottom half workqueue mechanism. It replac=
es all
>occurrences of tasklet usage with the appropriate workqueue APIs throughou=
t the
>cavium/liquidio driver. This transition ensures compatibility with the lat=
est design
>and enhances performance.
>
>Signed-off-by: Allen Pais <allen.lkml@gmail.com>
>---
> .../net/ethernet/cavium/liquidio/lio_core.c   |  4 ++--
> .../net/ethernet/cavium/liquidio/lio_main.c   | 24 +++++++++----------
> .../ethernet/cavium/liquidio/lio_vf_main.c    | 10 ++++----
> .../ethernet/cavium/liquidio/octeon_droq.c    |  4 ++--
> .../ethernet/cavium/liquidio/octeon_main.h    |  4 ++--
> 5 files changed, 23 insertions(+), 23 deletions(-)
>

LGTM
Reviewed-by: Sunil Goutham <sgoutham@marvell.com>

