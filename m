Return-Path: <linux-rdma+bounces-16806-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDZfIa/Zjmn9FQEAu9opvQ
	(envelope-from <linux-rdma+bounces-16806-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 08:58:39 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0F8133C36
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 08:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8E02303FAF6
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Feb 2026 07:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF88314D21;
	Fri, 13 Feb 2026 07:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Arqib1q3";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="sq+cEAgv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10908314D0E;
	Fri, 13 Feb 2026 07:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770969513; cv=fail; b=noy6CfTVzFLg90s8woY3XOtcPFTq1ypXAHGoW6N5BvBB90xHPRM5279NvLMvj2L3JUeEBrf3/14NOOeYSzoBsMaIMUblkdoonhzDjV9DTeGx2/ZheXGryz5YfoXvLs6eRkK8nOEEphqAtG1Y3Gqf2kuu8vVxkjTfHmi315KcWYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770969513; c=relaxed/simple;
	bh=FYVhUO5sA6I0cZvEN1uX4b9ug4K2PBsKGz7HWasbxKs=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eFuwN5pBlgbClfKWVPwML9NeHrRahyEuWMJtzlfP8iYu6ikl2qRM4msulD3V7nTMHkWQ+50obDPgbB64pqy8LjPJO/Nl38hHhEgEva/nU+wn+ClSwft+ksPirDDZ9Lc2YJFOFLx8lEfw/l4nrJD8v8/IQHhZUlH/o98oKLWO520=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Arqib1q3; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=sq+cEAgv; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1770969511; x=1802505511;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=FYVhUO5sA6I0cZvEN1uX4b9ug4K2PBsKGz7HWasbxKs=;
  b=Arqib1q3ZhEDVL+jcB8qM3lN1Rn5InUE2OPHySVEkB10cuVyKVKbbnof
   XW/hrzfPpYJdm2vs5yQnGI9fBPlF+xvk4kFQKMLXKU5dmjBMYllY2Ni3S
   asiLP0TY5Far7w5JZZJP4fXYiyNhPcYgdTUzNo/82KWjz6u1sMC7hxeDW
   NxhByHTpSHxQELExjsL0ijiFz/trI4lmtkfZOpSSfA3VdFK/nz9Fq5641
   uc853AY3piYfqqrfb1Zog6oQLE2JBOkNjYpCc3nW9NbSKR+kbvqDs4E2V
   IuWr3FIvKKBRCf30YqrZQgAlo9CHh1tlIHC1Q1CKvoOmswb9UILb7ho7e
   A==;
X-CSE-ConnectionGUID: 0Aw4HEUWSO63MLtF/pwhRw==
X-CSE-MsgGUID: e0PARDWlTFOuLQ+IAFMk/A==
X-IronPort-AV: E=Sophos;i="6.21,288,1763395200"; 
   d="scan'208";a="140673489"
Received: from mail-eastusazon11011038.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.38])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2026 15:58:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jY259LZ5VPNzchybYXk3Ovyon752fbX6rA0dKrTOFvB5jpZ3rpOyrC1LmZpBcupIIZCw0oDUKKFMn5z4evVKAI4V1Fv9+1YmxIWx45IslCqszh3n27gKfmtfTW4+ZGW7EXT6FmDwRrIGq0hZDzt2tMALlpxOIP5ORaDO5FKIY+rlpyvQQdRumh2kKccrIty/YMUIKxynsAn9o42w25SoqdrC+pAR+d5Wrs9478eFchxb5iw2yN6zbJ++jU1Erwpd/nzAuRgqG3UJ2TuZ+UjDXlYX2cdYPhjuCoxkNspKz1oKlyLVhJeqMJbWpv0kEpkaxem1d3FwJXBitAlClvFQZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNwkLtQLiUHieAUJK3VU98yJsW0jyV6pNrsQGh22q64=;
 b=a+Mb0gTImUbxmak3LOjivsRYG85PI1AYBkw5/hd/QXa09RF94B4wDdJ486+X0ntTqIdl0Zs9noRZoHkZM3LuWB3RMyV3Gd3Nus/l0EJ47jgEQZ6KeWcY5X9iPpfPDQj77Wtz3uJks3DlBXN77hVn+7j0u4R3ZNw/fw+uOR9Vs736pZrNaNzizLCGiJxxlUAwxlFb71VNdi+/E219QKoHsAYrp18A03Z3gKyPlhZjVMe6zC97kPy13rhCxq5ErdwgIkbnw+1ISVJOlLCvqfD75rzja1MPDB7QJAC4s81HCufsz9wS0PVu0iOhc6Kq6PIqy1SQ0ESiWaqfyRaddTB4+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNwkLtQLiUHieAUJK3VU98yJsW0jyV6pNrsQGh22q64=;
 b=sq+cEAgv/gMYpg79UwnvW8UuPYQ9+dOmQViAOyWKaHISHqXhZR7CigVsNtbRFP7LGT1v8cDmup5Fb9bC1A7UYOglcP9khKn3XErYMSe3+hh1hyIkfj9qrmikHij2yO2AeBFGR/cP80ysJgcS62YJ3NYEKxuUk/46eRDJ05AhE58=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SA3PR04MB8979.namprd04.prod.outlook.com (2603:10b6:806:394::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 07:57:59 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 07:57:59 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: blktests failures with v6.19 kernel
Thread-Topic: blktests failures with v6.19 kernel
Thread-Index: AQHcnL546UP/dHCUV0i3P4Kt4vejdA==
Date: Fri, 13 Feb 2026 07:57:58 +0000
Message-ID: <aY7ZBfMjVIhe_wh3@shinmob>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|SA3PR04MB8979:EE_
x-ms-office365-filtering-correlation-id: 21828b7d-6803-46d5-9b33-08de6ad59aea
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|7142099003|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?30OX0zpO47a1K4mtFeMgtQY8J+bbNpfiY/7bYKDvwSdMOCJ5ZbiyH+eLltCt?=
 =?us-ascii?Q?n468Qlmhjjo2NBJh5/LIHoYkgnCyUEHqSf9MPEPZrObhFVAAL9sJjb5n0Uz4?=
 =?us-ascii?Q?pEUjiS61jYAiwksteecnP5baCihSG5NjrHte4IUUnw1h986TmFRyIBb6XcgG?=
 =?us-ascii?Q?uG0za2rLfM5xyhFkYNJ67zPJ16Z2PJ9CoZuq+uFTvw9zWNFHXUCBckVVj97q?=
 =?us-ascii?Q?9dKheTzWDhRpeFZVVIHHGwvJvI+x4X8TPskK+gg7W6C37wbJWUINFCdpVPf5?=
 =?us-ascii?Q?djF9+0zW6EXKm+bowY7BsZ8pMBxiH0dB0YQva+QjwGvcPJwL5WM/9wWX1756?=
 =?us-ascii?Q?9d7RcZMM/QlMnbxXwyMyzSUoQZNEAUtvb9vnOOhHAS1iRAoT02C0vkPxqVqL?=
 =?us-ascii?Q?d3BYn2kLxC5nq6/Rj8L1U/DSJzsZaI2DhAwzdNuATuMz+/0vYu2khzOvnAjA?=
 =?us-ascii?Q?sEBYEMIc7O4pcFb41BDSjsql9shzY68xvSb8HncVsphB6/CNpbGWNp0Qi6wX?=
 =?us-ascii?Q?FGtyPd34GrdZ1Ya3Bm9Yq35aEYO3Efjcm/K0qF4qT/3nmaEOCkkmM8yoViFl?=
 =?us-ascii?Q?bltbJ8/0cpwmxD9hIyYxrKkKgUPGZTq9UCbC4Z8wuEIWLBf6fyVdu0KS9QRL?=
 =?us-ascii?Q?Y4ANhH4F2pLtxhUyZqfeSQUR61YCastJrFCPArZcHy36Tdmkzq0C3NB6tly/?=
 =?us-ascii?Q?2PEMiFHq0VY0oXwIwAyqk1KVLHbDOZBNg7eKVa+EhKs4hAaevtrDi27v4/UW?=
 =?us-ascii?Q?iq4qzelDBFnJXV4Rw9kgPBSLn96MMwzc/S250hnJI3xzohVtCXyMkcIQvl1t?=
 =?us-ascii?Q?bJuqITf8W8R7NiA61tJGjdN3r8c/ab5wB05V0ypVwcReztlnHcm/tbqhhtFD?=
 =?us-ascii?Q?TzPsCLcWDuJOw5QbOX9Xj0Y/oJOygmEiKMDAOCYjYqwjOnSPPHz+maofdfSD?=
 =?us-ascii?Q?mfT4Ba35NDpe8iXlI8Ple1O/u1ewLGBiAwc/x+/vO8HUGt2xm18/Ao+qp211?=
 =?us-ascii?Q?pSVvDLR228rKYyP/wVKcaz70gJQ1CAL4C+X150qmGw+Z2RzsAawTxlnt/kgL?=
 =?us-ascii?Q?u4NeiiWoGujwhYmM01TXJdzPRVjFQle1Zs8C280Bqj8LL4bE1sWCgHEjMNxP?=
 =?us-ascii?Q?tE3HedUVND5QktMpj6smkWXriUeHqVd5NiqOeBrTf3zJrZa5te/G6FBW7I+Q?=
 =?us-ascii?Q?dnCGsonIG2WRJtwUhWkaaWPVE00PV+THA41XSgsKfmyIkcpPdg076sP4gCFh?=
 =?us-ascii?Q?6QPhgv8cKgnrIJQHXL+fY2iZcqTg2xI3IcGcaj9+dCP+L4+MYD2jJT1ppyQM?=
 =?us-ascii?Q?S2511WFoEfLQEDnNVlY/qtGJS/p0adtNvD279rS2US9J2jrcd59F6Ho3C+YJ?=
 =?us-ascii?Q?9PQMhPfwJqapOh6LLfpKiXPNDh8bf41VicN2PfSmDxcjDOWTaY+CCUVd1MwC?=
 =?us-ascii?Q?oEBa8tXmOeENIyqzoiYRFiosjHQH3Eblc8evw/dzHB/i9htokEcxA2G/sZKH?=
 =?us-ascii?Q?6uxPvJtcWR8l46aI3JKJ3AvMBqkd74Y4CokyNVURSC0vS3bQVgwVWN9gSfQ7?=
 =?us-ascii?Q?ZM6jcrylmO1nFOeyndY71K0MBuBC3pKUX0ZQ68KMSKpvDHWwMmjKE9Nwrx75?=
 =?us-ascii?Q?2YMQRuECtFUFeWrYJ2fz5ZTl7yPpQN/pO2vdHBuGwr/0?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(7142099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EKdrSbLhLI1liYjJjZgXPCKBnoWbC6484HPueSE4J1cBgQaOTcJy6dgC/k3E?=
 =?us-ascii?Q?ITM+UGtipfejIuIYjIljTDjXy+VIZIt3O4OEe1Tc5vD0CkEHAcObXz+mwb45?=
 =?us-ascii?Q?nqSYDfKhPY7vy3Tj863oIwBxiMBBRUNnIuGHINdXT8VpdZWC60ZtU/KdVB4N?=
 =?us-ascii?Q?n7P92WlgT4wt8RcRhdrOyg42Jk+SrR8E68vvGHh0K/p1y4aiyIitC+CcW5DB?=
 =?us-ascii?Q?4s0EXsnfKtuS2D5r64u5pfgBzn+KwaGoq8G6S6dAPkBdw6yJMoOODzpaC/oB?=
 =?us-ascii?Q?3/Y9k4s1Dj8KuxXl4ahwSi924Piu1nknR/Jx8+gCWIpaqlkgqHAM1+1PGOqR?=
 =?us-ascii?Q?8OiR4vdix8Ryg5Ab8u2k0z5oq5DID+OBV33Oj/5Pl11RnE38ywjmfHGXMTon?=
 =?us-ascii?Q?/Lc9V1NxpEEfm7BaqyD3A1xYQlJdmtVrYiJd/KbL4/OAuTlUQQhvicWT6Wyz?=
 =?us-ascii?Q?81rHrLxCjSKaqv9+d9VtfcpC8GmBMfHMiC3KSs2WY1Umpb8LsqRHlmeNbCYz?=
 =?us-ascii?Q?2z/UOq+XexyF/zY2w2dvw/HqZoyy0JkBq+IsUYqXy2wmbDVDYnS0y/X9A2qd?=
 =?us-ascii?Q?9lHSN/4py5Q8h71nj3WhDnyzHpfdq525+65yi4mxuMDvTdySQy5hAcpLuDhd?=
 =?us-ascii?Q?2OyW56dgJogXDaz5c5OXdycvBcmZwrFF+69CSQO1V8koNoivIptMpKej7I3k?=
 =?us-ascii?Q?BYCkPzytF+rXTDV6THTucXaARuzWjcfp722T2ywVUYb5VkS5gqeIgUjyqI9U?=
 =?us-ascii?Q?BEk19c3HnkYsTPwPau5HMBuiPagCbOUvCwZT+v370mSRIipPuqLkalnlvoK/?=
 =?us-ascii?Q?riiZ0fBBOa1XjNtBv+JpIHP0ZzRokCk626fTPC6ogFXC6H0naetw8L+O6Wjg?=
 =?us-ascii?Q?+MjTTkTXvmK0vNhzyVhBo138iw8Q8WPgNZgEbSC8GpSv7QbM47Bb9iV1APg4?=
 =?us-ascii?Q?83K0WzOBHM94zrm3s+oEOmoiO0B8CsGQFYaXvusq2MJHGcS3HDeHSDIkltF4?=
 =?us-ascii?Q?R7qds/uAFWWiDYOMS1gbU9leLbQKsvdVn7iiZkJhbu3Myhy59AwTo2fQbt5x?=
 =?us-ascii?Q?ZMTOmmS6ezlIzKz6EVng5liuDuiwxoqgYP6UwbmiyXLGXpxGnfDNEcWB15ex?=
 =?us-ascii?Q?eroZsd/RvzQ6CD9DxXZc+Pb5+IOuspGAD/0idAaYS+/jxFUkBg6PysRBtxXp?=
 =?us-ascii?Q?2i+Lhg5vQ6QuMvEth0dPEbXqt0mObJIIXuX2uvy/6pNhaLYr8RJzzBaq5ZXC?=
 =?us-ascii?Q?r3T7/KmMa0vpYZ4P/wglXnWcuwn0ELnYby+8clldNrXhtHZwDl2fAuV4mjiJ?=
 =?us-ascii?Q?xqSi+TspvtCFLpCVrlyO0JIaF3PBVzSqPB3IVD+XFIkrI8R+3786qSYyCWL/?=
 =?us-ascii?Q?Y1i1AypRRwn35LJ5MqI9oVVHLGV6Y/yVHiKpcpOYKP04fKt0cU3b0vsHH17G?=
 =?us-ascii?Q?ncLvUVD+QArvoT77C44p14E0Tn08WDM5a8yga5BojHcvY8ozVa7PructFYjC?=
 =?us-ascii?Q?TogFZn5QxsbnMOIZx6DsxUQinEe9araQa1Kt45f9iYFquyhqpZkLisowtX99?=
 =?us-ascii?Q?obaYT+yao3GdTn/N6U+Z4mLZDzB9RXSjnIgCB0YxLSpr8fGLUrBmMIjsyWVx?=
 =?us-ascii?Q?auI9dLzLk8J1v615/JxXetPDSD2kdera/8swbZxIVr894R7jMsM5JUY2wQ9U?=
 =?us-ascii?Q?vxzgQS7cbHUN6kkJZDYI7pM2nJT1kTZ5BvXXfAWl+DbjPekdWJNEbqOVWpUF?=
 =?us-ascii?Q?OvuPbodJlH8gywk54KjuyGaWGx/ACY8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C8612DF51D201647B4CEEEA1A67A93B5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	S25EOHfGlZcp63ZPSUEM5hUO5y+rIGobVOoc2PbR9FqBoUw0o7acnV3Pqg0GZawZ2IC+/RQJQ1JzTvbNQZkEAKb4/z6gorhHYjSjzTef85bjDkbgEUkMaRrfhMgPdyxqhZOyjm/bg/lDG9byYQ5aU9LKyjH8t2gmvgRXxD5V3E7VrBGbK9TfrTM5MZaOtGmVnT40Je+l0ZUfw/nnVxcLnq1z0A3kL+GTYdBul0bd536C0+FFIuvpGM73X0iXyPciGH6U6o5XVxcOQNkkfuUuWCSGwuVoHeycKO0+p/lQvWSyPnnUinVEzuPDZXT65B0fIZ8qpm5YZU64aXfPlMu3Qxz9GLNNs0HYQqHlvwiP3DogGswZ3hODnmTtsC5MOg0a8+Hw2NpBD+puBZibQd6+iWTlxjyWZGUdTNrJ+JR5mTEPWwJZWuXEi5Wl8zBGwOnsv8brsrqMKxBvntArWeN81O0lrN8QXWSgyqZiwXMDvitrIliWlHrJwVALzeqshZTavODzRIO3ZtZHDyWjyNETCd7T8MnVak2VPBBwweE6rsG2+87gTvmE/eeWPTqagbqqN6DguNjc0re5sMOxF7pxcIEvDmRkwioq+7JHN9hSJi5o4VjPB8Oo/ZHIN6lsxBOD
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21828b7d-6803-46d5-9b33-08de6ad59aea
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2026 07:57:59.2815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9QaFGhdmf6WYYut3BPhez3lUNoTDxrQUS5i413XlhEZ1M/x+PImQGGf3fiDUpo2IhRV2EcRUneN36mbtTl96b36WEvxNkocHyiOm+MwfBM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8979
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16806-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shinichiro.kawasaki@wdc.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sharedspace.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DF0F8133C36
X-Rspamd-Action: no action

Hi all,

I ran the latest blktests (git hash: b5b699341102) with the v6.19 kernel. I
observed 6 failures listed below. Comparing with the previous report with t=
he
v6.19-rc1 kernel [1], two failures were resolved (nvme/033 and srp) and thr=
ee
failures are newly observed (nvme/061, zbd/009 and zbd/013). Recently, kmem=
leak
support was introduced to blktests. Two out of the three new failures were
detected by kmemleak. Your actions to fix the failures will be appreciated =
as
always.

[1] https://lore.kernel.org/linux-block/a078671f-10b3-47e7-acbb-4251c874452=
3@wdc.com/


List of failures
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#1: nvme/005,063 (tcp transport)
#2: nvme/058 (fc transport)
#3: nvme/061 (rdma transport, siw driver)(new)(kmemleak)
#4: nbd/002
#5: zbd/009 (new)(kmemleak)
#6: zbd/013 (new)


Failure description
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

#1: nvme/005,063 (tcp transport)

    The test case nvme/005 and 063 fail for tcp transport due to the lockde=
p
    WARN related to the three locks q->q_usage_counter, q->elevator_lock an=
d
    set->srcu. Refer to the nvme/063 failure report for v6.16-rc1 kernel [2=
].

    [2] https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7w=
j3ua4e5vpihoamwg3ui@fq42f5q5t5ic/

#2: nvme/058 (fc transport)

    When the test case nvme/058 is repeated for fc transport about 50 times=
, it
    fails. I observed a couple of different symptoms by chance. One symptom=
 is a
    lockdep WARN related to nvmet-wq [3]. And the other is a WARN at __add_=
disk
    [4]. This test case had failed with another different symptom with the
    kernel v6.19-rc1 (WARN at blk_mq_unquiesce_queue) [1], but this symptom=
 is
    no longer observed.

#3: nvme/061 (rdma transport, siw driver)

    When the test case nvme/061 is repeated twice for the rdma transport an=
d the
    siw driver on the kernel v6.19 with CONFIG_DEBUG_KMEMLEAK enabled, it f=
ails
    with a kmemleak message [5]. The failure is not observed with the rxe
    driver.

#4: nbd/002

    The test case nbd/002 fails due to the lockdep WARN related to
    mm->mmap_lock, sk_lock-AF_INET6 and fs_reclaim. Refer to the nbd/002 fa=
ilure
    report for v6.18-rc1 kernel [6].

    [6] https://lore.kernel.org/linux-block/ynmi72x5wt5ooljjafebhcarit3pvu6=
axkslqenikb2p5txe57@ldytqa2t4i2x/

#5: zbd/009

    When the test case zbd/009 is repeated twice on the kernel v6.19 with
    CONFIG_DEBUG_KMEMLEAK enabled,, it fails with a kmemleak message [7].

#6: zbd/013

    The test case zbd/013 fails with a KASAN [8]. The cause was in the task
    scheduler and the fix patch was already applied to the Linus master
    branch [9].

    [8] https://lore.kernel.org/lkml/aYrewLd7QNiPUJT1@shinmob/
    [9] https://lore.kernel.org/lkml/87tsvoa7to.ffs@tglx/


[3] lockdep WARN during nvme/058 with fc transport

[  409.028219] [     T95] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
[  409.029133] [     T95] WARNING: possible recursive locking detected
[  409.030058] [     T95] 6.19.0+ #575 Not tainted
[  409.030892] [     T95] --------------------------------------------
[  409.031801] [     T95] kworker/u16:9/95 is trying to acquire lock:
[  409.032691] [     T95] ffff88813ba54948 ((wq_completion)nvmet-wq){+.+.}-=
{0:0}, at: touch_wq_lockdep_map+0x7e/0x1a0
[  409.033869] [     T95]=20
                          but task is already holding lock:
[  409.035254] [     T95] ffff88813ba54948 ((wq_completion)nvmet-wq){+.+.}-=
{0:0}, at: process_one_work+0xeef/0x1480
[  409.036383] [     T95]=20
                          other info that might help us debug this:
[  409.037769] [     T95]  Possible unsafe locking scenario:

[  409.039113] [     T95]        CPU0
[  409.039781] [     T95]        ----
[  409.040406] [     T95]   lock((wq_completion)nvmet-wq);
[  409.041154] [     T95]   lock((wq_completion)nvmet-wq);
[  409.041898] [     T95]=20
                           *** DEADLOCK ***

[  409.043609] [     T95]  May be due to missing lock nesting notation

[  409.044960] [     T95] 3 locks held by kworker/u16:9/95:
[  409.045721] [     T95]  #0: ffff88813ba54948 ((wq_completion)nvmet-wq){+=
.+.}-{0:0}, at: process_one_work+0xeef/0x1480
[  409.046845] [     T95]  #1: ffff888109797ca8 ((work_completion)(&assoc->=
del_work)){+.+.}-{0:0}, at: process_one_work+0x7e4/0x1480
[  409.048063] [     T95]  #2: ffffffffac481480 (rcu_read_lock){....}-{1:3}=
, at: __flush_work+0xe3/0xc70
[  409.049128] [     T95]=20
                          stack backtrace:
[  409.050366] [     T95] CPU: 1 UID: 0 PID: 95 Comm: kworker/u16:9 Not tai=
nted 6.19.0+ #575 PREEMPT(voluntary)=20
[  409.050370] [     T95] Hardware name: QEMU Standard PC (i440FX + PIIX, 1=
996), BIOS 1.16.3-4.fc42 04/01/2014
[  409.050373] [     T95] Workqueue: nvmet-wq nvmet_fc_delete_assoc_work [n=
vmet_fc]
[  409.050384] [     T95] Call Trace:
[  409.050386] [     T95]  <TASK>
[  409.050388] [     T95]  dump_stack_lvl+0x6a/0x90
[  409.050393] [     T95]  print_deadlock_bug.cold+0xc0/0xcd
[  409.050401] [     T95]  __lock_acquire+0x1312/0x2230
[  409.050408] [     T95]  ? lockdep_unlock+0x5e/0xc0
[  409.050410] [     T95]  ? __lock_acquire+0xd03/0x2230
[  409.050413] [     T95]  lock_acquire+0x170/0x300
[  409.050415] [     T95]  ? touch_wq_lockdep_map+0x7e/0x1a0
[  409.050418] [     T95]  ? __flush_work+0x4e8/0xc70
[  409.050420] [     T95]  ? find_held_lock+0x2b/0x80
[  409.050423] [     T95]  ? touch_wq_lockdep_map+0x7e/0x1a0
[  409.050425] [     T95]  touch_wq_lockdep_map+0x97/0x1a0
[  409.050428] [     T95]  ? touch_wq_lockdep_map+0x7e/0x1a0
[  409.050430] [     T95]  ? __flush_work+0x4e8/0xc70
[  409.050432] [     T95]  __flush_work+0x5c1/0xc70
[  409.050434] [     T95]  ? __pfx___flush_work+0x10/0x10
[  409.050436] [     T95]  ? __pfx___flush_work+0x10/0x10
[  409.050439] [     T95]  ? __pfx_wq_barrier_func+0x10/0x10
[  409.050444] [     T95]  ? __pfx___might_resched+0x10/0x10
[  409.050454] [     T95]  nvmet_ctrl_free+0x2e9/0x810 [nvmet]
[  409.050474] [     T95]  ? __pfx___cancel_work+0x10/0x10
[  409.050479] [     T95]  ? __pfx_nvmet_ctrl_free+0x10/0x10 [nvmet]
[  409.050498] [     T95]  nvmet_cq_put+0x136/0x180 [nvmet]
[  409.050515] [     T95]  nvmet_fc_target_assoc_free+0x398/0x2040 [nvmet_f=
c]
[  409.050522] [     T95]  ? __pfx_nvmet_fc_target_assoc_free+0x10/0x10 [nv=
met_fc]
[  409.050528] [     T95]  nvmet_fc_delete_assoc_work.cold+0x82/0xff [nvmet=
_fc]
[  409.050533] [     T95]  process_one_work+0x868/0x1480
[  409.050538] [     T95]  ? __pfx_process_one_work+0x10/0x10
[  409.050541] [     T95]  ? lock_acquire+0x170/0x300
[  409.050545] [     T95]  ? assign_work+0x156/0x390
[  409.050548] [     T95]  worker_thread+0x5ee/0xfd0
[  409.050553] [     T95]  ? __pfx_worker_thread+0x10/0x10
[  409.050555] [     T95]  kthread+0x3af/0x770
[  409.050560] [     T95]  ? lock_acquire+0x180/0x300
[  409.050563] [     T95]  ? __pfx_kthread+0x10/0x10
[  409.050565] [     T95]  ? __pfx_kthread+0x10/0x10
[  409.050568] [     T95]  ? ret_from_fork+0x6e/0x810
[  409.050576] [     T95]  ? lock_release+0x1ab/0x2f0
[  409.050578] [     T95]  ? rcu_is_watching+0x11/0xb0
[  409.050582] [     T95]  ? __pfx_kthread+0x10/0x10
[  409.050585] [     T95]  ret_from_fork+0x55c/0x810
[  409.050588] [     T95]  ? __pfx_ret_from_fork+0x10/0x10
[  409.050590] [     T95]  ? __switch_to+0x10a/0xda0
[  409.050598] [     T95]  ? __switch_to_asm+0x33/0x70
[  409.050602] [     T95]  ? __pfx_kthread+0x10/0x10
[  409.050605] [     T95]  ret_from_fork_asm+0x1a/0x30
[  409.050610] [     T95]  </TASK>


[4] WARN during nvme/058 fc transport

[ 1410.913156] [   T1369] WARNING: block/genhd.c:463 at __add_disk+0x87b/0x=
d50, CPU#0: kworker/u16:12/1369
[ 1410.913411] [   T1146] nvme8c15n2: I/O Cmd(0x2) @ LBA 2096240, 8 blocks,=
 I/O Error (sct 0x3 / sc 0x0) MORE=20
[ 1410.913866] [   T1369] Modules linked in:
[ 1410.914386] [   T1146] I/O error, dev nvme8c15n2, sector 2096240 op 0x0:=
(READ) flags 0x2880700 phys_seg 1 prio class 2
[ 1410.914954] [   T1369]  nvme_fcloop nvmet_fc nvmet nvme_fc nvme_fabrics =
nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ip=
v4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_de=
frag_ipv6 nf_defrag_ipv4 nf_tables qrtr sunrpc 9pnet_virtio 9pnet pcspkr ne=
tfs i2c_piix4 i2c_smbus fuse loop dm_multipath nfnetlink vsock_loopback vmw=
_vsock_virtio_transport_common vsock zram bochs xfs drm_client_lib drm_shme=
m_helper nvme drm_kms_helper nvme_core sym53c8xx drm floppy e1000 nvme_keyr=
ing nvme_auth hkdf scsi_transport_spi serio_raw ata_generic pata_acpi i2c_d=
ev qemu_fw_cfg [last unloaded: nvmet]
[ 1410.918223] [   T1418] nvme nvme15: NVME-FC{10}: io failed due to bad NV=
Me_ERSP: iu len 8, xfr len 1024 vs 0, status code 0, cmdid 36976 vs 36976
[ 1410.918677] [   T1397] nvme nvme15: rescanning namespaces.
[ 1410.921001] [   T1369] CPU: 0 UID: 0 PID: 1369 Comm: kworker/u16:12 Not =
tainted 6.19.0 #12 PREEMPT(voluntary)=20
[ 1410.921914] [   T1383] nvme nvme15: NVME-FC{10}: transport association e=
vent: transport detected io error
[ 1410.922247] [   T1369] Hardware name: QEMU Standard PC (i440FX + PIIX, 1=
996), BIOS 1.17.0-8.fc42 06/10/2025
[ 1410.922847] [   T1383] nvme nvme15: NVME-FC{10}: resetting controller
[ 1410.923450] [   T1369] Workqueue: nvme-wq nvme_fc_connect_ctrl_work [nvm=
e_fc]
[ 1410.931697] [   T1369] RIP: 0010:__add_disk+0x87b/0xd50
[ 1410.932558] [   T1369] Code: 89 54 24 18 e8 d6 fa 75 ff 44 8b 54 24 18 e=
9 ca f9 ff ff 4c 89 f7 44 89 54 24 18 e8 bf fa 75 ff 44 8b 54 24 18 e9 7e f=
9 ff ff <0f> 0b e9 6f fe ff ff 0f 0b e9 68 fe ff ff 48 b8 00 00 00 00 00 fc
[ 1410.935252] [   T1369] RSP: 0018:ffff888124977770 EFLAGS: 00010246
[ 1410.936421] [   T1369] RAX: 0000000000000000 RBX: 0000000000000000 RCX: =
1ffff110249c1c01
[ 1410.937637] [   T1369] RDX: 0000000000000103 RSI: 0000000000000004 RDI: =
ffff8881537ca2b0
[ 1410.938806] [   T1369] RBP: ffff888124e0e008 R08: ffffffff8d81870b R09: =
ffffed102a6f9456
[ 1410.939826] [   T1369] R10: ffffed102a6f9457 R11: ffff8881151b8fb0 R12: =
ffff8881537ca280
[ 1410.940895] [   T1369] R13: 0000000000000000 R14: ffff888124e0e000 R15: =
ffff888112227008
[ 1410.942132] [   T1369] FS:  0000000000000000(0000) GS:ffff88841c312000(0=
000) knlGS:0000000000000000
[ 1410.943347] [   T1369] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1410.944482] [   T1369] CR2: 000055f53bf44f08 CR3: 0000000111996000 CR4: =
00000000000006f0
[ 1410.945619] [   T1369] Call Trace:
[ 1410.946429] [   T1369]  <TASK>
[ 1410.947350] [   T1369]  add_disk_fwnode+0x36e/0x590
[ 1410.948386] [   T1369]  ? lock_acquire+0x17a/0x2f0
[ 1410.949325] [   T1369]  nvme_mpath_set_live+0xe0/0x4c0 [nvme_core]
[ 1410.950456] [   T1369]  nvme_update_ana_state+0x342/0x4e0 [nvme_core]
[ 1410.951455] [   T1369]  nvme_parse_ana_log+0x1f5/0x4c0 [nvme_core]
[ 1410.952465] [   T1369]  ? __pfx_nvme_update_ana_state+0x10/0x10 [nvme_co=
re]
[ 1410.953534] [   T1369]  nvme_mpath_update+0xa1/0xf0 [nvme_core]
[ 1410.954617] [   T1369]  ? __pfx_nvme_mpath_update+0x10/0x10 [nvme_core]
[ 1410.955651] [   T1369]  ? lockdep_hardirqs_on_prepare+0xce/0x1b0
[ 1410.956615] [   T1369]  ? lockdep_hardirqs_on+0x88/0x130
[ 1410.957508] [   T1369]  ? queue_work_on+0x8c/0xc0
[ 1410.958321] [   T1369]  nvme_start_ctrl+0x3ee/0x620 [nvme_core]
[ 1410.959361] [   T1369]  ? __pfx_nvme_start_ctrl+0x10/0x10 [nvme_core]
[ 1410.960318] [   T1369]  ? mark_held_locks+0x40/0x70
[ 1410.961249] [   T1369]  ? nvme_kick_requeue_lists+0x1b5/0x260 [nvme_core=
]
[ 1410.962258] [   T1369]  ? lock_release+0x1ab/0x2f0
[ 1410.963110] [   T1369]  nvme_fc_connect_ctrl_work.cold+0x758/0x7f3 [nvme=
_fc]
[ 1410.964131] [   T1369]  ? __pfx_nvme_fc_connect_ctrl_work+0x10/0x10 [nvm=
e_fc]
[ 1410.965179] [   T1369]  ? lock_acquire+0x17a/0x2f0
[ 1410.966026] [   T1369]  ? process_one_work+0x722/0x1490
[ 1410.967510] [   T1369]  ? lock_release+0x1ab/0x2f0
[ 1410.968327] [   T1369]  process_one_work+0x868/0x1490
[ 1410.969235] [   T1369]  ? __pfx_process_one_work+0x10/0x10
[ 1410.970196] [   T1369]  ? lock_acquire+0x16a/0x2f0
[ 1410.971089] [   T1369]  ? assign_work+0x156/0x390
[ 1410.971925] [   T1369]  worker_thread+0x5ee/0xfd0
[ 1410.972725] [   T1369]  ? __pfx_worker_thread+0x10/0x10
[ 1410.973531] [   T1369]  ? __kthread_parkme+0xb3/0x200
[ 1410.974255] [   T1369]  ? __pfx_worker_thread+0x10/0x10
[ 1410.975093] [   T1369]  kthread+0x3af/0x770
[ 1410.975764] [   T1369]  ? lock_acquire+0x17a/0x2f0
[ 1410.976454] [   T1369]  ? __pfx_kthread+0x10/0x10
[ 1410.977209] [   T1369]  ? __pfx_kthread+0x10/0x10
[ 1410.977894] [   T1369]  ? ret_from_fork+0x6e/0x810
[ 1410.978624] [   T1369]  ? lock_release+0x1ab/0x2f0
[ 1410.979282] [   T1369]  ? rcu_is_watching+0x11/0xb0
[ 1410.979992] [   T1369]  ? __pfx_kthread+0x10/0x10
[ 1410.980650] [   T1369]  ret_from_fork+0x55c/0x810
[ 1410.981268] [   T1369]  ? __pfx_ret_from_fork+0x10/0x10
[ 1410.981950] [   T1369]  ? __switch_to+0x10a/0xda0
[ 1410.982640] [   T1369]  ? __switch_to_asm+0x33/0x70
[ 1410.983309] [   T1369]  ? __pfx_kthread+0x10/0x10
[ 1410.984006] [   T1369]  ret_from_fork_asm+0x1a/0x30
[ 1410.984664] [   T1369]  </TASK>
[ 1410.985198] [   T1369] irq event stamp: 2549333
[ 1410.985857] [   T1369] hardirqs last  enabled at (2549345): [<ffffffff8c=
6dd01e>] __up_console_sem+0x5e/0x70
[ 1410.986852] [   T1369] hardirqs last disabled at (2549356): [<ffffffff8c=
6dd003>] __up_console_sem+0x43/0x70
[ 1410.987853] [   T1369] softirqs last  enabled at (2549100): [<ffffffff8c=
51b246>] __irq_exit_rcu+0x126/0x240
[ 1410.988941] [   T1369] softirqs last disabled at (2549095): [<ffffffff8c=
51b246>] __irq_exit_rcu+0x126/0x240
[ 1410.989908] [   T1369] ---[ end trace 0000000000000000 ]---


[5] kmemleak at nvme/061 wiht rdma transport and siw driver

unreferenced object 0xffff888114792600 (size 32):
  comm "kworker/2:1H", pid 66, jiffies 4295489358
  hex dump (first 32 bytes):
    c2 f6 83 05 00 ea ff ff 00 00 00 00 00 10 00 00  ................
    00 b0 fd 60 81 88 ff ff 00 10 00 00 00 00 00 00  ...`............
  backtrace (crc 3dbac61d):
    __kmalloc_noprof+0x62f/0x8b0
    sgl_alloc_order+0x74/0x330
    0xffffffffc1b73433
    0xffffffffc1bc1f0d
    0xffffffffc1bc8064
    __ib_process_cq+0x14f/0x3e0 [ib_core]
    ib_cq_poll_work+0x49/0x160 [ib_core]
    process_one_work+0x868/0x1480
    worker_thread+0x5ee/0xfd0
    kthread+0x3af/0x770
    ret_from_fork+0x55c/0x810
    ret_from_fork_asm+0x1a/0x30
unreferenced object 0xffff888114792740 (size 32):
  comm "kworker/2:1H", pid 66, jiffies 4295489358
  hex dump (first 32 bytes):
    82 e8 50 04 00 ea ff ff 00 00 00 00 00 10 00 00  ..P.............
    00 20 3a 14 81 88 ff ff 00 10 00 00 00 00 00 00  . :.............
  backtrace (crc 5e69d517):
    __kmalloc_noprof+0x62f/0x8b0
    sgl_alloc_order+0x74/0x330
    0xffffffffc1b73433
    0xffffffffc1bc1f0d
    0xffffffffc1bc8064
    __ib_process_cq+0x14f/0x3e0 [ib_core]
    ib_cq_poll_work+0x49/0x160 [ib_core]
    process_one_work+0x868/0x1480
    worker_thread+0x5ee/0xfd0
    kthread+0x3af/0x770
    ret_from_fork+0x55c/0x810
    ret_from_fork_asm+0x1a/0x30
unreferenced object 0xffff88815e4a1d80 (size 32):
  comm "kworker/2:1H", pid 66, jiffies 4295490860
  hex dump (first 32 bytes):
    c2 5d 26 04 00 ea ff ff 00 00 00 00 00 10 00 00  .]&.............
    00 70 97 09 81 88 ff ff 00 10 00 00 00 00 00 00  .p..............
  backtrace (crc 6d5ef85b):
    __kmalloc_noprof+0x62f/0x8b0
    sgl_alloc_order+0x74/0x330
    0xffffffffc1b73433
    0xffffffffc1bc1f0d
    0xffffffffc1bc8064
    __ib_process_cq+0x14f/0x3e0 [ib_core]
    ib_cq_poll_work+0x49/0x160 [ib_core]
    process_one_work+0x868/0x1480
    worker_thread+0x5ee/0xfd0
    kthread+0x3af/0x770
    ret_from_fork+0x55c/0x810
    ret_from_fork_asm+0x1a/0x30
unreferenced object 0xffff88815e4a1780 (size 32):
  comm "kworker/2:1H", pid 66, jiffies 4295490860
  hex dump (first 32 bytes):
    02 ca cf 04 00 ea ff ff 00 00 00 00 00 10 00 00  ................
    00 80 f2 33 81 88 ff ff 00 10 00 00 00 00 00 00  ...3............
  backtrace (crc 9b068d98):
    __kmalloc_noprof+0x62f/0x8b0
    sgl_alloc_order+0x74/0x330
    0xffffffffc1b73433
    0xffffffffc1bc1f0d
    0xffffffffc1bc8064
    __ib_process_cq+0x14f/0x3e0 [ib_core]
    ib_cq_poll_work+0x49/0x160 [ib_core]
    process_one_work+0x868/0x1480
    worker_thread+0x5ee/0xfd0
    kthread+0x3af/0x770
    ret_from_fork+0x55c/0x810
    ret_from_fork_asm+0x1a/0x30
unreferenced object 0xffff88815e4a1f80 (size 32):
  comm "kworker/2:1H", pid 66, jiffies 4295490861
  hex dump (first 32 bytes):
    82 2b 84 05 00 ea ff ff 00 00 00 00 00 10 00 00  .+..............
    00 e0 0a 61 81 88 ff ff 00 10 00 00 00 00 00 00  ...a............
  backtrace (crc 1f32d61a):
    __kmalloc_noprof+0x62f/0x8b0
    sgl_alloc_order+0x74/0x330
    0xffffffffc1b73433
    0xffffffffc1bc1f0d
    0xffffffffc1bc8064
    __ib_process_cq+0x14f/0x3e0 [ib_core]
    ib_cq_poll_work+0x49/0x160 [ib_core]
    process_one_work+0x868/0x1480
    worker_thread+0x5ee/0xfd0
    kthread+0x3af/0x770
    ret_from_fork+0x55c/0x810
    ret_from_fork_asm+0x1a/0x30


[7] kmemleak at zbd/009

unreferenced object 0xffff88815f1f1280 (size 32):
  comm "mount", pid 1745, jiffies 4294866235
  hex dump (first 32 bytes):
    6d 65 74 61 64 61 74 61 2d 74 72 65 65 6c 6f 67  metadata-treelog
    00 93 9c fb af bb ae 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 2ee03cc2):
    __kmalloc_node_track_caller_noprof+0x66b/0x8c0
    kstrdup+0x42/0xc0
    kobject_set_name_vargs+0x44/0x110
    kobject_init_and_add+0xcf/0x140
    btrfs_sysfs_add_space_info_type+0xf2/0x200 [btrfs]
    create_space_info_sub_group.constprop.0+0xfb/0x1b0 [btrfs]
    create_space_info+0x247/0x320 [btrfs]
    btrfs_init_space_info+0x143/0x1b0 [btrfs]
    open_ctree+0x2eed/0x43fe [btrfs]
    btrfs_get_tree.cold+0x90/0x1da [btrfs]
    vfs_get_tree+0x87/0x2f0
    vfs_cmd_create+0xbd/0x280
    __do_sys_fsconfig+0x64f/0xa30
    do_syscall_64+0x95/0x540
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object 0xffff888128d80000 (size 16):
  comm "mount", pid 1745, jiffies 4294866237
  hex dump (first 16 bytes):
    64 61 74 61 2d 72 65 6c 6f 63 00 4b 96 f6 48 82  data-reloc.K..H.
  backtrace (crc 1598f702):
    __kmalloc_node_track_caller_noprof+0x66b/0x8c0
    kstrdup+0x42/0xc0
    kobject_set_name_vargs+0x44/0x110
    kobject_init_and_add+0xcf/0x140
    btrfs_sysfs_add_space_info_type+0xf2/0x200 [btrfs]
    create_space_info_sub_group.constprop.0+0xfb/0x1b0 [btrfs]
    create_space_info+0x211/0x320 [btrfs]
    open_ctree+0x2eed/0x43fe [btrfs]
    btrfs_get_tree.cold+0x90/0x1da [btrfs]
    vfs_get_tree+0x87/0x2f0
    vfs_cmd_create+0xbd/0x280
    __do_sys_fsconfig+0x64f/0xa30
    do_syscall_64+0x95/0x540
    entry_SYSCALL_64_after_hwframe+0x76/0x7e=

