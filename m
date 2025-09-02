Return-Path: <linux-rdma+bounces-13027-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DBBB3F4EC
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Sep 2025 08:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC323ACE65
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Sep 2025 06:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8392E1751;
	Tue,  2 Sep 2025 06:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LamoJAEk";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="k+o5p63q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1B1224B1E;
	Tue,  2 Sep 2025 06:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756792823; cv=fail; b=pxAl28edAccX5yyleJM9fd/YB7lBN/V1mlylsE0e7lYugqv+gm99rfh0+WsLSGsTphLnnQOMUtp8gWH1tdkiHGy7VcAt6G8iShuJYPlz7hXtUcdUKKFPqu6HdQs2mDc9HpaM7nB0MDuWvb52CTygT3/LaPNuZFbnAJztDxXqLX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756792823; c=relaxed/simple;
	bh=PDF2odzCzwzb3b+n+139ir/QZ7Fg8jKs+4sdtWFKxV4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NW7bi5Ni06wSoQHmqNb8w7mWqgkHN+WOOWAURQ0WQ5J4EcBqS5MHGrJFxHDyDsQHaQC3Tvimhk7CCSwgWIqo1iWPw8i/yXJe5ZHtY79rjYNcV6qfI5DDJlB8SfVtjCEnpecIvknUhfatNzSVm6V6qpYkOQCWvIS/aHD+sWxwwIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=LamoJAEk; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=k+o5p63q; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1756792821; x=1788328821;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PDF2odzCzwzb3b+n+139ir/QZ7Fg8jKs+4sdtWFKxV4=;
  b=LamoJAEks1tDiCRu2KBgKCGBO+4IkVRcv0NC2Gs8Z28or5BS3HqqDT6c
   NYaqoFfaAZ+aIQISbONbbA6xOUdLh1Z1nacMm1RRIkgQ/10y17JR3kXn3
   vmy1jTQ3jCVGnBD9cSgnhZU53rf6UrUONu++1HNdMjYgwE2RHkLGHp0nN
   loZTyeVod7l+JyXf6Mvq1hxpkbm2kMzhawHyjldZzjRi6RrtsEK9fo/HO
   nUVYBMbAxRWrfYf8Ukv/fmtV8x7Ojx8jYsYjCNoGZeo32h2OhvdHkbSxU
   D29va6NxgKRER0V5xTw6r1Z9sfze4KmhhB5BHtiH31By4+cIJ31F+V/3u
   Q==;
X-CSE-ConnectionGUID: x15jVQnlTgqIub/+DYvHrw==
X-CSE-MsgGUID: 63AbDSmiRO26gPnyAqWUpA==
X-IronPort-AV: E=Sophos;i="6.18,230,1751212800"; 
   d="scan'208";a="106429781"
Received: from mail-co1nam11on2045.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([40.107.220.45])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2025 14:00:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfW9k+VsSPYN4NzRRjkUtK7+JaFIGK9ABMphX4BXCY4mVZKGQ0cC4Fb1/Fj1dacZP6b1Z+Sk4+0f+0xk9HdM0qLOtmD2vZl6Df1ipQgwpEmF9DzuV2PhkUmSm8K59fHdHhLz5bGFRJdn2Q9v+Uj3gA03HsjMpGw9xyM/gXACVlczZKhE8042njaPObhq3DefSnA2JmDqzUoYK/Q0+VVRab6kUm+UNNXvrQLFzNXFtHUihC+koKlzA178qcU2mciBKhE7T9Y21pEZjpfG/Q+3MGOvGU0eoMGwXG9jOLGlnfO66+MQgY7EDUgJamY2XM46Veeo/G926aB7ixlp8ar7aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+d4o1QD5/uuPajkH7RmnNVflJkIjRyTfKqEnHy4y6U=;
 b=D886KPWrtIZtFWJHqG1eXAh44RWBVVLMLFrQ8UvwTMdGYXszOpBOe4ZBPr1ML7zKpHC9OeGO02dAvJFjKBSopnGcvr4BhXS/kzpKXQEbf2jlFse0TCFlnSvlhmQfRwJ33eWmRPW8k/NpCGZL9FfdTMTYslhENtttXqPG4G88LkhPylVg761BVwnxirTbQnsF1XocyUQfecXwExn7vAp8Eqrkq5c/ARvylMSEhE2rOsIwUVCJukqsNg4xSV3klfNmrf+vvHHHGjN6IydDKw/Nxed7SgwoRFLo8Bfd0SH6cxaaQd0luGIqiLDOCgxQKbwwO8E9NEBYIHNMrV7vYI1mmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+d4o1QD5/uuPajkH7RmnNVflJkIjRyTfKqEnHy4y6U=;
 b=k+o5p63qfKkJsEsgxwiNXcUSs336JJCeycLifYzCoxwr+v36h3sJHGkWD+JMto1/IehY2G3qKmqi67kbAYyk4CAy05XnGIh8UL4tJULFtaTiI8cuvcveEJjOHQfqn59S1pPsX9me5SqegO5WSG5d9oE0Ehk/kMG1bQxuNccjC90=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by DM6PR04MB6970.namprd04.prod.outlook.com (2603:10b6:5:244::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 06:00:18 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 06:00:18 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: Re: blktests failures with v6.17-rc1 kernel
Thread-Topic: blktests failures with v6.17-rc1 kernel
Thread-Index:
 AQHcDEAYP1DNINhgd0uqNNYw6OHN7bR2XR0AgAFK/gCAAF5tAIADQV2AgALV/wCAAAfUgIABX30A
Date: Tue, 2 Sep 2025 06:00:17 +0000
Message-ID: <ldr3xa4muogowu2xeh3uq3xcifljfftssydgnhjdarfre4kg4p@midqloza2ayz>
References: <suhzith2uj75uiprq4m3cglvr7qwm3d7gi4tmjeohlxl6fcmv3@zu6zym6nmvun>
 <ff748a3f-9f07-4933-b4b3-b4f58aacac5b@flourine.local>
 <rsdinhafrtlguauhesmrrzkybpnvwantwmyfq2ih5aregghax5@mhr7v3eryci3>
 <6ef89cb5-1745-4b98-9203-51ba6de40799@flourine.local>
 <u4ttvhnn7lark5w3sgrbuy2rxupcvosp4qmvj46nwzgeo5ausc@uyrkdls2muwx>
 <629ddb72-c10d-4930-9d81-61d7322ed3b0@flourine.local>
 <7a773833-a193-4243-80f4-fc52243883a9@flourine.local>
In-Reply-To: <7a773833-a193-4243-80f4-fc52243883a9@flourine.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|DM6PR04MB6970:EE_
x-ms-office365-filtering-correlation-id: f66c90c7-9665-42fc-1b71-08dde9e5fe67
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Eq7s+SC2HRiqku5TD/EueY3KXE7GglPk9dHv0c2FdzEflz20JCUcczUtoAxQ?=
 =?us-ascii?Q?YADODjDhvJiTgVeAxHDhCzI77knSkH1t6wbP8sF//E53q+oEe19HOvbc7l8g?=
 =?us-ascii?Q?/i8eb9VbtDGBfzIzkYTqJONqUi2P1vzb9oqQtWYlpbUGcEfraQDz4shEyYdI?=
 =?us-ascii?Q?4obxeelAwiPtkuoV4NkDJf8Pu1b50l9Y5Jg1PAS7iIlxjlPuwTGlBq+j79/8?=
 =?us-ascii?Q?Fu1rKnisVOMEfYIY5+k5Ys2bdTRMp8ZagjD8DIYha9QDjwqNlw4r5PmwcDU4?=
 =?us-ascii?Q?up3PUMWSdvxxEnUZ61JX2nYoCDYPFUwWvrLA4l5feJOOdN5fJvRX8oy2YzRF?=
 =?us-ascii?Q?xjrES6797ixhjcbY+1nU8fE2nkM5c60TIwB/G41iY0ze/u41jAHLev50RmJT?=
 =?us-ascii?Q?c4NZ8gRztvHh9lc1HbbGGM+4fzoPMTy3xuRZ07bArSwoqq6jCBo76S7gLS06?=
 =?us-ascii?Q?qLt5Ush7/snDDp/SLp5hCWu7/C5ZXkGQaA7idfhguoeJpD28mMDna0Ls7x9M?=
 =?us-ascii?Q?EmqXGl4pC6FHSUr0EbPjJQUncH5Y8MsQG64cMJ12jgQ884Mfhv7GeG+KOknT?=
 =?us-ascii?Q?E5fjuPVhZ2SM0Ccd43PNc9R1KwfHvHKwTNsUKPeN57HAcIQSq/cPCvHLZgcJ?=
 =?us-ascii?Q?bP8YTgcm0hvOG5yFoIrPkrRY28MghJMQ6gxaSMHZQaxh2CzEm/4b17eceGeW?=
 =?us-ascii?Q?UH3IVjEZx/nickbHAwXKwGrAkBmqQI3ND4hbAcB3D3T4mSFLfPVnZEi3AIwX?=
 =?us-ascii?Q?cYtYXQaF0rTPMUgggJUM8y4qFkEA2iv5CUYYpIuF/SE8Ky5MXfAII1ixwgzY?=
 =?us-ascii?Q?5DLAVJ3JV9fBaYQwwrcqaJttMQ15CE+kjCKmwb5vk7umHxtVE3L/kXcKY1kN?=
 =?us-ascii?Q?QxB2Ymuv52i2TJih8IHXXn23/RqjQOEnaEtjssfa/+EM5MWGPdvBEK4MGlz8?=
 =?us-ascii?Q?acvIX2ZZitxoHGiUvRGpukgM/T6uZrPuKyvp23gtOo0Ffdj7Wh3Uhj0hgIlM?=
 =?us-ascii?Q?IuWUu29qc7KnjV+G3udRP4gNhjbfOsml4ROTV2j255Yjk5seqZ3wjDF/UYLr?=
 =?us-ascii?Q?qXcjc6nbAVfXak7kJNdzWwHphuStjX79ThYtnrA505nYIxzpY0uZS80FMj6e?=
 =?us-ascii?Q?S/Q75OcE1bWql8ubLU21gxOSYF/UWADi3n/BTPUvbNIHDhs7gAU/OtcCvL7L?=
 =?us-ascii?Q?C1EZQtF9OAcCiO/NqOoWhx47klctkmw1lWIlIuxG/Bigyu8VR7LNpZ+tfHlb?=
 =?us-ascii?Q?UmwzBd5o3xPWqGdZVloCVVqjCvaYGeipuFqlyxk5C85C5xWqAIB56MnJ4aPp?=
 =?us-ascii?Q?BqNCWwTzpAqE5UCIPYBLQLiTpjV5dKiXG6ETc65ryE7JynuKQS+HdCXdUTfJ?=
 =?us-ascii?Q?mYgI28/EvOpBvL94TfDofThYt1uSoHVbKqdNN9yctUdymvqF6hs0ePyUeJVx?=
 =?us-ascii?Q?2kRzeW7oZAzY0GlsiUKcF7pUfkamgdWDqtvdBF1HvbyKt+n4cICZlA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NCg/jjqQ+IQbLOznvBd8moiz6zpDwNY7fqEqxUSoGNEgnM2HSKRBfjBhSqZV?=
 =?us-ascii?Q?9FSvKod5IRAyNYNVmiVee5QXtX02uvMKFihmhYf5PcJX8mrcXDhw2QRF9UjD?=
 =?us-ascii?Q?0KgwWIFhyi9Ev9GK16HEOuzWmtWejzHpl7zKV3kV5M4t8Dzlv0FocCbhyPRy?=
 =?us-ascii?Q?krDLbukBJEzA7Q7DBVOywpZG6X+C67JufGLswZbEOAtvlDvcOMJMR9yjrbOX?=
 =?us-ascii?Q?0LrfvLxYztrjuiAZrQISms1MFRL4p8hY0N7Ws6561fWWttd7oe2DwAoBgdpT?=
 =?us-ascii?Q?zMd4S9I6G4Kr2zQvnvYURubfis9n/rSaJ/APZfoU8vWJCmo1axW/MiISjwK1?=
 =?us-ascii?Q?qcqMthtru4dOwP17iAC/6Act/TdIWauUsc937QpMYknKHUGTE0HDYqvDAVXC?=
 =?us-ascii?Q?cRQ8iCBF4XADZEpJZmhbHlHP9F85rzll5BvOcVj/1athL0GiO5EfoRoMEYRN?=
 =?us-ascii?Q?U+f6lG3AYOm9fJ23h+pGXtjH5EWDRw2uovfkTJ6xQi0YhkxlSIQrNOQC3AiO?=
 =?us-ascii?Q?AoxGf7COJN5EYFx6kDYivkXKzPkpPFGycIVwi7YDS9xIuRxvjLK190BUhHgu?=
 =?us-ascii?Q?oe36M6r84a8l4hS6TWk1pVtMpcUpOBT/hNarSewVT3zQD1es5JuBsBaqht7p?=
 =?us-ascii?Q?41RVr2YkB/1Ai9oLuuqFJE32iTulwLa1ZonwxnIGvTAwQ4y3ihO+xTCGexH0?=
 =?us-ascii?Q?uDPcc0U1j9iqdyL/Cm5u0dfI9NlZloapeuuW/HBxFtDP4+9cMwTprecCYONC?=
 =?us-ascii?Q?2EFDCDujQYPMr/MeDAKJGAUclaBNbLFFxXBSphZQ/FO+Omfo5YnLE5nZqEJ+?=
 =?us-ascii?Q?ym7NnpA+O71tcaSVgjHLIqgNkD8zCBtSHDp3Ia04ohtJREybwJzQdOT2oIkI?=
 =?us-ascii?Q?XDIi+pssa8zSbR/Kd078pq27KA/8c40dKRWfA4DFlL3RrssSoPaKZlCDOQh7?=
 =?us-ascii?Q?/bWznHklz4Ae3BrWYK4tHlbh0TRM1QaPJVl5zJnFSIh+mUPWqrSNxb/1qA3j?=
 =?us-ascii?Q?8bPl8z76fIHBc7Ah4mTGPBlzCkg9BLStZbvlG7DEzEB0f6/NgOMfcFDeVxn8?=
 =?us-ascii?Q?qLcu99/Gl5w/FGr/uS65XCvGZpJNLEDD8AY9HNggUJSJTLmCm71ftyl3ax6q?=
 =?us-ascii?Q?fPw6q05QGebFDrOkpS8vrvLbSYUSHWvy6wKQC7kqiSKP8Xcfd2qM1vi9X7Ri?=
 =?us-ascii?Q?sg1GCO2w5rJjoLW5EnL9K6sHXW17GY+bgMGszwuoi3MkOe/QILNWyf0oRPJW?=
 =?us-ascii?Q?i+ZcmpW8B29uS/+9vBRclyMmrN2TGgUDNZ6GmNsoO/PpigNpsVaOK8nry1F9?=
 =?us-ascii?Q?2pzzqcrc4WDNm/AW1k0ilCaL0lBnm3nP8uv9K/PSxoO0IAV87HgUQOf+omOc?=
 =?us-ascii?Q?Y8dmFCOjDXr7ZCkVaZ9ZwpZtCgfgDZ7X5S6fgRlEOjVUpAHETQ5UJ1dFJ39S?=
 =?us-ascii?Q?qrA3OVzhyGoaT2zACPpbEaAbBMrvHoXAvf3qYgWInRAWFr2BoRRIB63c7SGU?=
 =?us-ascii?Q?2vBSRA6N+qfGB2KTFcKjDD03zEctWCVHxoqa6eu4LlrKVvG3SBP7QmP13VwO?=
 =?us-ascii?Q?HY637Gu6uz3Zyq0W9Gixmge6q9jasUdnlktH2nviWuOxwcatQUhXwnC6wV2K?=
 =?us-ascii?Q?6g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D6F797AEB14206479B7F77726535AEC5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XXU7F909HwWrpJK082L8AcMzZa6PIJQFgFupggejSom86yOxI7DtgJTLe58KN7Zi/KWWE/6MpQa0n4wImXZE7G9/5FXUoVOxOTzQtiN2Qj+qKK6Aq2XgMjpgdhPsEayFWpJHsIU4wfH1mqsK2XnR+g3Yc+XbIvaCf2REpOtJBOtNPd2RbbJncjLQ0gIhcEeSIFEx/qVcZQuAhRQif8TSMl40BzDW4DyAWA/UkAoPChGFLtX/330NNTHtBqw+THBwv4FnG48O/HUIQwDYoZ867pgWBxFSQU9Gz5V8GMNHvr0y2YFIr+hykOQTE8kwhk698StC1QCFOxsnwlCMLc/g/+vv2VXZzSucwkZfFDEmIJgeMHFiKqPn/Zq9nm7c9ULvRmH2wpSX3rYWb0BtxoNkNcyFhhIGu+sXU4wAhC4oTskpYXPkxw4schUeG0qFUHzt1K8zlIr6PVT5UZRaYBFnNc/oMl2pz1FaY/FG4LlW0y7HvcFbqJcTjUWEzCbsOgKp1dxPEtbi4CLARujj678SvaZKsGt1/ZWLpJ5PkpfboGLsFJztfm8mjGbS/mJqMQHoyXj5G7pJyn70PSBZQ6mXiZDD+n4oD4UdG9l/+nvwQQGxtGTTcmM1VGFC2XElFQYn
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f66c90c7-9665-42fc-1b71-08dde9e5fe67
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 06:00:18.1194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CG37Ah+gLoIXxI+VdghdWc6Zm7o/5AYpc8kbkZ9HPBu1qNgr9DvMDW60X7BApUlPKMaL0+xKhbNtorrauE837xNfPjt5wS+aGnpIkp8j47Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6970

On Sep 01, 2025 / 11:02, Daniel Wagner wrote:
> On Mon, Sep 01, 2025 at 10:34:23AM +0200, Daniel Wagner wrote:
> > The test is removing the ports while the host driver is about to
> > reconnect and accesses a stale pointer.
> >=20
> > nvme_fc_create_association is calling nvme_fc_ctlr_inactive_on_rport in
> > the error path. The problem is that nvme_fc_create_association gets hal=
f
> > through the setup and then fails. In the cleanup path
> >=20
> > 	dev_warn(ctrl->ctrl.device,
> > 		"NVME-FC{%d}: create_assoc failed, assoc_id %llx ret %d\n",
> > 		ctrl->cnum, ctrl->association_id, ret);
> >=20
> > is issued and then nvme_fc_ctlr_inactive_on_rport is called. And there
> > is the log message above, so it's clear the error path is taken.
> >=20
> > But the thing is fcloop is not supposed to remove the ports when the
> > host driver is still using it. So there is a race window where it's
> > possible to enter nvme_fc_create_assocation and fcloop removing the
> > ports.
> >=20
> > So between nvme_fc_create_assocation and nvme_fc_ctlr_active_on_rport.
>=20
> I think the problem is that nvme_fc_create_association is not holding
> the rport locks when checking the port_state and marking the rport
> active. This races with nvme_fc_unregister_remoteport.
>=20
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 3e12d4683ac7..03987f497a5b 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -3032,11 +3032,17 @@ nvme_fc_create_association(struct nvme_fc_ctrl *c=
trl)
>=20
>  	++ctrl->ctrl.nr_reconnects;
>=20
> -	if (ctrl->rport->remoteport.port_state !=3D FC_OBJSTATE_ONLINE)
> +	spin_lock_irqsave(&ctrl->rport->lock, flags);
> +	if (ctrl->rport->remoteport.port_state !=3D FC_OBJSTATE_ONLINE) {
> +		spin_unlock_irqrestore(&ctrl->rport->lock, flags);
>  		return -ENODEV;
> +	}
>=20
> -	if (nvme_fc_ctlr_active_on_rport(ctrl))
> +	if (nvme_fc_ctlr_active_on_rport(ctrl)) {
> +		spin_unlock_irqrestore(&ctrl->rport->lock, flags);
>  		return -ENOTUNIQ;
> +	}
> +	spin_unlock_irqrestore(&ctrl->rport->lock, flags);
>=20
>  	dev_info(ctrl->ctrl.device,
>  		"NVME-FC{%d}: create association : host wwpn 0x%016llx "
>=20
> I'll to reproduce it and see if this patch does make a difference.

I applied the fix patch above together with the previous fix patch on top o=
f
v6.17-rc3, then I repeated nvme/061 with fc transport hundreds of times. I
did not observed the KASAN suaf. The fix patch looks working good. Thanks!

