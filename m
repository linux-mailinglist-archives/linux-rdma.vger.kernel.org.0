Return-Path: <linux-rdma+bounces-10149-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF49EAAF43D
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 09:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 625987ACB31
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 07:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5328F21C185;
	Thu,  8 May 2025 07:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OstEXokX";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FNNnWHWl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412AA33FD
	for <linux-rdma@vger.kernel.org>; Thu,  8 May 2025 07:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746687793; cv=fail; b=KHhxBbEa3GOJTB36amV3DEpoh9uYmxIfMDIT8Fzzs4iSRAGvFaLveDNwCQIGxKZfAsKJ2ftL7vOBK9QOoKIWDaoY3OpqpgF8NHgDZoTS7MmMrpkT350xkiZWNV0fT3zmrdaQcSJc71m6sqNKaupH5p87cuRIyUbNWRg1tC7pJt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746687793; c=relaxed/simple;
	bh=irLP3/0hFzgBHnsLsrdKwzqOlpXY6jOXLX78CIfS1Jk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PZLsyAVAGam4t9tZscF/3qDcdSGIlcFCOP72P/t6NNtJe8ZVkkppM8ORlI46mlLn+h7Aah0tuSdARJXsDqKRjYNSgCsbmcRKL+YuEXz1VdNh9WpdNiiRzI7rj64M/14ebzpHO8SHfw2qw90ahkBQCsURWD7sVVp2qy7ajPI/ayw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=OstEXokX; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=FNNnWHWl; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1746687791; x=1778223791;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=irLP3/0hFzgBHnsLsrdKwzqOlpXY6jOXLX78CIfS1Jk=;
  b=OstEXokX6I8Ps6jZZk3tAa6VjrIMLUoDWAeVyiEvBrooFAtHmmzNyy0J
   eRY1mNXCvx8knAhEUCXLe/bynq/+3sH+zJtrZiqwOqoc6slJ8L7ajopaL
   sEBQwhq/z13rmZYXCgEXAAnWCj6boplmjePnAJ6r91wU0KQjWVwSyGe7r
   Wj2YcEpfTwvDRrXZYT5uIY5N5Th6W+ITmVw4LNzVw4/tnI8N0O3it69yJ
   IznL7ID1VLPZwD+Ase+rYAqu10CpwoEa2GyUVmUiMk+xRboffqx/0KZ5B
   4MUB4lJqZiTMwj8X5/qxubJgl7ubyIwXzzTaYa22/1f01Vh21MMV6xxRS
   A==;
X-CSE-ConnectionGUID: iLJFQN4GQkC8MPDkoeooNg==
X-CSE-MsgGUID: 8J1StAwvTUaNvzXmTgi6Hg==
X-IronPort-AV: E=Sophos;i="6.15,271,1739808000"; 
   d="scan'208";a="85565960"
Received: from mail-bn7nam10lp2043.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.43])
  by ob1.hgst.iphmx.com with ESMTP; 08 May 2025 15:03:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VtC734Bkzcng3cvzxXcaDOItEktbPm6zosqBYJc4nJMaIw1a96hteULsCj4dTJfoNSEgCw0Ewp1ZmqMKsprOrc5Fop8UwV39MlUGBhQZj3b1D+ZKRARxbdAMkYo3htlzO5Lj5VvLWTiQy131oMcaXDRiss+6jqWVJoRZBYorXNuETfhw8k0D5qhuY+fmrNdmP62TMEHPqU71X45Rbeq/rxa73HIQnX6m+HlpMWVsXCMQv7cpbY++kpa+IxU9adNOQBgXnR/dQ7MLIsAE55g9o+ZPu4+J91fFcE1qsRoLoO8kZRqu38Cvsj5P9iymonYMtyrbbiF6IJsPQHUcdoa4IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDe1C7TPBH1WDhfW11R6MWWpYHWXuW93qFb8xs5j6v4=;
 b=EPYVJlVWeWvxJij1UdsxjlcZKmH9zHdWK5cf+8IAc+sr8FcK1C5WWVYCoD7sNxiU2P8BCpYN9kXHUysCaY+C9ssOySAc0Um7i7i50FueiEDp6N6mt5MfxHgRxlAB5o9pgcPBf2+3As7Rk5b6cWOsswZu6iRAdKy8LmvPRWQZ+XXeDpE8fRwyA+ptKHSBNf6fY+ntsYSr7dLROKKmKQ5/0AzSYn3MsRxEjs81ZRkUoofVpN7+dgimm44irC4WlJMQQY1rlqAYq6wP+KXZZ2rS5Va8fabVQCzSaDfr7zwbIbM0s/yCLMdxktabg4mYq0SthmaggI9txmqnxm2nzLazaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDe1C7TPBH1WDhfW11R6MWWpYHWXuW93qFb8xs5j6v4=;
 b=FNNnWHWlM1gv4B3XTdbg91cngurqcdZr1AnKSEZ4RJOnYedDq/PkJe3pjNAUwRNbXvqROg+K9FQRGb0GS+jP0vf5fESxP7EkDsZfDjWVHzlCOgC64SoWtNKuhIr70gSMt1GAlleXlH24pm7oElNdnuHq8wKnG3Xlo4jjUlFSPSg=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB6732.namprd04.prod.outlook.com (2603:10b6:5:1::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20; Thu, 8 May 2025 07:03:03 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8699.026; Thu, 8 May 2025
 07:03:03 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bernard Metzler <BMT@zurich.ibm.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Daniel Wagner
	<wagi@kernel.org>
Subject: Re: [bug report] blktests nvme/061 hang with rdma transport and siw
 driver
Thread-Topic: [bug report] blktests nvme/061 hang with rdma transport and siw
 driver
Thread-Index: AQHbrfdhJhGSraouF0ezotWmIGdrJbOkzJXwgADapACAIstSAA==
Date: Thu, 8 May 2025 07:03:03 +0000
Message-ID: <d4xfwos54mccrwgw76t6q5nhwe2n3bxbt46cmyuhjcpcsub2hy@7d3zsewjkycv>
References: <r5676e754sv35aq7cdsqrlnvyhiq5zktteaurl7vmfih35efko@z6lay7uypy3c>
 <BN8PR15MB251354A3F4F39E0360B9B41399B22@BN8PR15MB2513.namprd15.prod.outlook.com>
 <lembalemdaoaqocvyd6n3rtdocv45734d22kmaleliwjoqpnpi@hrkfn3bl6hsv>
In-Reply-To: <lembalemdaoaqocvyd6n3rtdocv45734d22kmaleliwjoqpnpi@hrkfn3bl6hsv>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB6732:EE_
x-ms-office365-filtering-correlation-id: 89e1bf42-2a59-4169-ea1b-08dd8dfe6044
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FEqPqLJkh6tZ+nSxqx3M/Eus6zwdWng06Yn9KPoxqrwHNr++107QmK35K81g?=
 =?us-ascii?Q?NfnNz2N0zbi6B+H+v6u4hNMcBSuXf3otPlbKn4cD61h8E6i51R+kp33jxuLI?=
 =?us-ascii?Q?pEWZtI3IKKy2LcdeHJ/EMGQyz5WerUc6H+nrzymSbkxlnHz7M/96a/qzGIgT?=
 =?us-ascii?Q?lWe9oyyxy8IQK0GLhqr2RhM1lxOyqHQMvUsm/71fk7YhWecXkwgM2WMSyS4k?=
 =?us-ascii?Q?EkC6hGORv6jid9J8MAKUpEVxM3a/GIFWj/bJYl/xFEnua8d5Ijfv+ziWtj0I?=
 =?us-ascii?Q?V81fEIOoL/WlXqROEd+eIzP13B5sA7ntyUDysDsFHiDeeYicIMcKqfSdJUno?=
 =?us-ascii?Q?osqiDJaGsX+xgHu1uF9LrunsHaD4qNJAw1vWJDOQOMKctDp4hkxAkeIHlahn?=
 =?us-ascii?Q?tQkwSCbe8f6vQ18iBfM0dwA3gPGUqBfeQaD2GaL4rx/fk/+Lls/XdQAGq1qI?=
 =?us-ascii?Q?sm/623X3tNJWeg+2MJLs/xomm8n4AlCTq5dZLppi56MI3clZb4yNIWE2V2uV?=
 =?us-ascii?Q?LS0r6bCPOUNwvoFyk1uDMbjCYfIkwgBbwdEHZpbTkeHVHb4fgfnYVnuEP4gB?=
 =?us-ascii?Q?I9mcmoHj2hbDkK89lgkO+kTf8HyDhifS2wRLr0yBh66bcUJgx8Z15B96s4ML?=
 =?us-ascii?Q?IRyAwmY0kbCfjekbOuG0OS3+GRmStXt4I7wvxyYiFE+dBYnUzz8MwpEwcCcO?=
 =?us-ascii?Q?yakDzYs1EEVt/8oO3o6FZgkQuIaJX6KwH8tuzsr0GFFANYD+bDLeUyKn297a?=
 =?us-ascii?Q?rQ4T/XlwV3WT7uDfVEGmpfFYszgOxtk3EoXyJqFTo9DSsMGFLZiZEl30YoMN?=
 =?us-ascii?Q?bY+C2qkdHum/H/aS+XS4j5MISyfLP78QoCU3WpCw0vIpWzjK8H/9P6dVdxsA?=
 =?us-ascii?Q?jvflQ/qhXxKDNRNBaxwdJ36sZwXDVWqOEy1eJaDF/uonjo+zzk7s4Onpi2j+?=
 =?us-ascii?Q?PGCNcOlKydkVQKulwpbLtHSbRUXHnuL+Ds/p3xD7aymB+t3L6T2f1HUT8Wtn?=
 =?us-ascii?Q?Zc/CpJXXwEusduPNZ1sIY3u/qZ/j37VUIfcwQM/ASNHk5c7N2MyaiGGzL7AG?=
 =?us-ascii?Q?5IkuWcer4L2XRABR+g+C7EO8LlyufvzeRXLXrfjuzY1R6W4D3FR8dUH+/hAb?=
 =?us-ascii?Q?O90Sbwr3uOGqnNs4RQ6fo0CyI6ukOD+JO/L1A0sgdWz1qDl0TlFt2bj1jRQE?=
 =?us-ascii?Q?HZuYdvD3jPc/fqZXqbeX0gMzd4CtawNRmYTD4zDjX0ryS0YXEqGJ2hzOmhLt?=
 =?us-ascii?Q?dcLS0L7if4LiH0VVf7tOMoZGFP2efOd8IH9DZXFGEctTzTAw5jt8UTvJcmxy?=
 =?us-ascii?Q?T8q4oqWo4AX/vIl1smukCeef/9V7XrqypVedVQm3Lx/otpBm0kqm5wVTswTl?=
 =?us-ascii?Q?wmc1UwyjNUNoZgeccncVHHI9lsGkWyvHwQOQZFKx2OfIJH/IrVZ2sI52CUq+?=
 =?us-ascii?Q?7KGjd38S/7vAvVYtaMhUt30qD7sdB/EsKh6cOn9zbA2BNwtFvdq8ZQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qrnJ1bhO1R3pO+NsPxFvzOnm4eSRx5n+AQdy3RnSH3TwfobUX155yr9rIeQi?=
 =?us-ascii?Q?3jT2H+EyjgMZmVGGZxlO/j8FAEf7bFsNaP0/eG7P0kXoTYMwhEVU1RuAhn3T?=
 =?us-ascii?Q?OqD2lHEdOYS1l+V2rdad0ORlq2//5Lb8fhhfuYgMLoO4ELa6B9qu+yM67mmn?=
 =?us-ascii?Q?RCvdYBvycnH7Umcr7TUVSs76MH+rfg+PMCy42sFU7Vb36PK6L0stGEMSic9x?=
 =?us-ascii?Q?wI/AU037t4BznHZ/kDJIpslHoV9OODjG/Mo9ultzojmRYe21NMGFD/mtjWv5?=
 =?us-ascii?Q?wBU4iv9BdWOvSR3wH7ACx2X+20XAVWfbpyRyS42MdREFMmgsXLu1/7Z7RG/W?=
 =?us-ascii?Q?Ap2u/Mqd5CoFt125B24qSiEy2pQm59fj3ts3ZtotIcgP+9QYO+C9Dk7bWPgl?=
 =?us-ascii?Q?LBF21ieMmmvj7cbUFIRVlAvI+HZsduxyQqC8SXgQQtnxojLhNfgSRHNplDvE?=
 =?us-ascii?Q?vEPrkWaNQXhwr1zTRKWJOLW0m+RColM9b1wOxVTYQNEiVgYpek9RHmH3mIA6?=
 =?us-ascii?Q?PZv898nT4W6r9+qMWPQfvQei45gXz4avieYq3tTZbuFmov7R0u2NZbvg/8zc?=
 =?us-ascii?Q?UOH7plu0NW5Vj6pgz6dHe2Em889S5hbXAHTCaJgM5NjCmKgDO8x+fuJreqBx?=
 =?us-ascii?Q?6XTRZtNztNKq4RCgf+cFBdn2hhWMgFn6aaBB7EOZnXck48Xnv9Po6nGm3tbD?=
 =?us-ascii?Q?LSGzawSmp9gx/X+23WVUPPayPOOmjC9uzCF+XAIFk7hhs+z4Ij0H2Uk8hy/v?=
 =?us-ascii?Q?C2KAgKuReh7751XAcN0R31mZOD7f9th+500kpWKNK+LbNK+ACYuVPGOMeHvq?=
 =?us-ascii?Q?Y6/31ekYzl+u/jJFgK+SbDVZ1gwrFFM9IOjeHwXqS3PsMmWhfX/W1PbvoGzG?=
 =?us-ascii?Q?KwDeHBKTz/rrIceJHHcS+nOsB/9TXwtxuf7i5fsYnshJXndh4R/lHFEhyRX6?=
 =?us-ascii?Q?jssURKLsGEV0WvMJUAo7QSSurk+xPmtsRNyw0TGw2nXx8Cs9vkYG7fCVEFZN?=
 =?us-ascii?Q?FPcTddgcstJnLafm+sQAp8l9dNa13zFx75HUHere3kJv3dbczz15HlNBbfi8?=
 =?us-ascii?Q?GJvz/JYADv8h3oOO8YBKez5QFWS1Nwp5H9AteR8g33foG97WJkt1CIs7u4Ui?=
 =?us-ascii?Q?f2eSiLZQ7zE1bUE65tecgZ/nZwbZWhc08IJnTywrYG25P705guH36u0Qdbxz?=
 =?us-ascii?Q?k3jMb69P4SX5sZCXDB0EKEaVu+KojWPhAnhcn0LPynYnMY5ZwNiE9HFvGncg?=
 =?us-ascii?Q?HrFZcOSLGcZTbQJTbSxps5snNMX39AX3Aw2nR3WUqfYfMB8UbAs6ATRtmYnZ?=
 =?us-ascii?Q?Sc+GXFY5AlkO9mtgw+avhoOEdvg+agiaSAaTeqJwf167FNxfE77ResawQARf?=
 =?us-ascii?Q?m3bkbH/idNi3b/z3XiWxwxTWdSPwSghYDX4Z+b6rCmf9c1ZYOpfi2yVhEVKK?=
 =?us-ascii?Q?1OI3XqA94RuLk2cCgxDasIl0POLDaSU6T05cY7XxyuSaI9VdNPKlkEb1XK+4?=
 =?us-ascii?Q?huUw0n6anvtLqMastV0mTsf+A3D7r+4H/ALYUl6DEOq/juEKKAT6OypL68kE?=
 =?us-ascii?Q?2Z5ypDOB1m9EdHvT9HHu2J+kFGSrONuFxOjDkj0IDUwFhp6E2qXnO/J9INdh?=
 =?us-ascii?Q?Cg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <23714901BBF1C349A7B9744B858FFE4A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Mry1jmhuoaLNqgHveVAFs1BCC9Ty8aZ3wZFC77UataF9Lpg6paXnHzNECUBD9MSa8RyyouhlLABdItNVN4924epRtoFoGRMA+Z7r/Ag2t/OfZV0vq4wLU09bOvigqEbzFe4z8qTtU7/OxAzezjMAgP7ROqwrFNiGDOZ+mkDDSZLPSq593Sp+dujQvDRlVSEHL+qh3w3L02ERqm6nZ+R+uK9SyHytUcVJbeG3zwPtA38SJ1vKFZt8XO8PTEL7iK+rfvCE/f4ho3+HwsSnQKRLIbpRR8ZU0FJ3khMu6G9Y9JiqclRfrgY8TlAy9Br/+VqZwIGFkOA4xUXfwjPhoH37sAaoOCPOflK5Mqle/0NjjK23nmKI3BsgZjPABLodXT4TNZov56kKvqN7L6smLdUM6xTuTunV8WvBQrRVT3YK+zNFoYkS3qH6+6kJbor52Al0Vm2+MuT+DJ839w5JgDaZW8hps7HLL5OuFfXmqyZzeODoLtVaFQ/dgkzOWsCfODek5oW8GpncXu088KhFviBGfTRsOUkuYrnBiIldPN2/X2oinoSwpni7Ei9RgpUFPyTQK1IUvTIJFw6HkXT3kfA2rf18MMyVf/zrjTE3UPuP4e2r26/fpIiWVo0QfN/lmq2N
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e1bf42-2a59-4169-ea1b-08dd8dfe6044
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 07:03:03.2528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CqMDUH2s1aU/uEWaKCKsFN04W6J+scqIeKz6ztEd8IjCCa9ow9TCSckfqwxHmrASXaXUU/j/IW7Nql5tvr3YY7tODpwvEb5tCIzWsqm1w/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6732

On Apr 16, 2025 / 12:42, Shin'ichiro Kawasaki wrote:
> On Apr 15, 2025 / 15:18, Bernard Metzler wrote:
[...]
> > At first glance, to me it looks like a problem in the iwcm code,
> > where a cmid's work queue handling might be broken.

I agree. The BUG slab-use-after-free happened for a work object. The call
trace indicates that happened for the work handled by iw_cm_wq, not
siw_cm_wq.

I took a close looks, and I think the work objects allocated for each cm_id
is freed too early. The work objects are freed in dealloc_work_entries() wh=
en
all references to the cm_id are removed. IIUC, when the last reference to t=
he
cm_id is removed in the work, the work object for the work itself gets remo=
ved.
Hence the use-after-free.

Based on this guess, I created a fix trial patch below. It delays the refer=
ence
removal in the cm_id destroy context, to ensure that the reference count be=
comes
zeor not in the work contexts but in the cm_id destroy context. It moves
iwcm_deref_id() call from destroy_cm_id() to its callers. Also call
iwcm_deref_id() after flushing the pending works. With this patch, I observ=
ed
use-after-free goes away. Comments on the fix trial patch will be welcomed.

One left question is why the failure was not observed with rxe driver, but =
with
siw driver. My mere guess is that is because siw driver calls id->add_ref()=
 and
cm_id->rem_ref().


diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.=
c
index f4486cbd8f45..600cf8ea6a39 100644
--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -368,12 +368,9 @@ EXPORT_SYMBOL(iw_cm_disconnect);
 /*
  * CM_ID <-- DESTROYING
  *
- * Clean up all resources associated with the connection and release
- * the initial reference taken by iw_create_cm_id.
- *
- * Returns true if and only if the last cm_id_priv reference has been drop=
ped.
+ * Clean up all resources associated with the connection.
  */
-static bool destroy_cm_id(struct iw_cm_id *cm_id)
+static void destroy_cm_id(struct iw_cm_id *cm_id)
 {
 	struct iwcm_id_private *cm_id_priv;
 	struct ib_qp *qp;
@@ -442,20 +439,22 @@ static bool destroy_cm_id(struct iw_cm_id *cm_id)
 		iwpm_remove_mapinfo(&cm_id->local_addr, &cm_id->m_local_addr);
 		iwpm_remove_mapping(&cm_id->local_addr, RDMA_NL_IWCM);
 	}
-
-	return iwcm_deref_id(cm_id_priv);
 }
=20
 /*
  * This function is only called by the application thread and cannot
  * be called by the event thread. The function will wait for all
- * references to be released on the cm_id and then kfree the cm_id
- * object.
+ * references to be released on the cm_id and then release the initial
+ * reference taken by iw_create_cm_id.
  */
 void iw_destroy_cm_id(struct iw_cm_id *cm_id)
 {
-	if (!destroy_cm_id(cm_id))
-		flush_workqueue(iwcm_wq);
+	struct iwcm_id_private *cm_id_priv;
+
+	cm_id_priv =3D container_of(cm_id, struct iwcm_id_private, id);
+	destroy_cm_id(cm_id);
+	flush_workqueue(iwcm_wq);
+	iwcm_deref_id(cm_id_priv);
 }
 EXPORT_SYMBOL(iw_destroy_cm_id);
=20
@@ -1035,8 +1034,10 @@ static void cm_work_handler(struct work_struct *_wor=
k)
=20
 		if (!test_bit(IWCM_F_DROP_EVENTS, &cm_id_priv->flags)) {
 			ret =3D process_event(cm_id_priv, &levent);
-			if (ret)
-				WARN_ON_ONCE(destroy_cm_id(&cm_id_priv->id));
+			if (ret) {
+				destroy_cm_id(&cm_id_priv->id);
+				WARN_ON_ONCE(iwcm_deref_id(cm_id_priv));
+			}
 		} else
 			pr_debug("dropping event %d\n", levent.event);
 		if (iwcm_deref_id(cm_id_priv))

