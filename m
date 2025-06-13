Return-Path: <linux-rdma+bounces-11289-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 250F7AD8229
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Jun 2025 06:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0B183A191B
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Jun 2025 04:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9D72046AD;
	Fri, 13 Jun 2025 04:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="L03RN2pM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bDzTy5E5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6D42F433F;
	Fri, 13 Jun 2025 04:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749789148; cv=fail; b=aB6Yqw8IUCWT/fOK1KnA2j4mhMGQARITew93qf2KN/sxMaLb7icqikPU9KsSuIOozms1eyXT/1SHXrrWgcuTlbRRAb+UE1ECvZzqssiCrRruIAOGgn6P3NSP0kTEQOGE6F3KEmTOjHcLYNm1Qm5YgPRaQMGGis92zKITgs6rJJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749789148; c=relaxed/simple;
	bh=qO5nbkLSj5DLHkTTtbt1Md7IPfWyTNYiiL4xruG9RWQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rGnCLi9LwiSM+aUMeGg5XE1TlTiueqRa2guacu2C+2OS6tvCBECEVsPaTs44XUtgzW79+/SffqD3ah58rh/gHgRoLovRGi1kNLqgjoFQK4CXS8M51+HXSHccBtDU0CeMACM2DIumdHygBrMgXCSTLXmiRtbvdqZpu0aMNse4Kwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=L03RN2pM; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=bDzTy5E5; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1749789145; x=1781325145;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=qO5nbkLSj5DLHkTTtbt1Md7IPfWyTNYiiL4xruG9RWQ=;
  b=L03RN2pMDjsGNJfh60C8jb8sbmAzgPWCtRiP9ziuNiQAapTBOThCyUq+
   RDJVM8Ex4pmDqpSfou2ZJu0hst8uWu86V46++mJt8RcvRoxa92h+E3UP8
   QDmeIiVmVYOQeKjmRL/y48eFXuVwZsis8I25pJEUeCcWnvduzPjTTfbub
   A4mzYNvFMXapje0F8Dsrbb9X66QfZUPhcH+sQuWJ5ANZuEqjeSTSa0po4
   ziLN/ibxaN0D1gMV4bgAzzIXtWcPbxDS6Yr4FZY6qlrrtyuw3wHaQ+xnf
   uTButjZrAE6B9Y+P1frcnAny23He+OKBLj++PKONj4/igQCt7674/fEvC
   Q==;
X-CSE-ConnectionGUID: h1IIDudpQxm79c1xU6bw0Q==
X-CSE-MsgGUID: jkgIf4X2T5eBCd6pmp+qBQ==
X-IronPort-AV: E=Sophos;i="6.16,232,1744041600"; 
   d="scan'208";a="84493946"
Received: from mail-westusazon11013004.outbound.protection.outlook.com (HELO SJ2PR03CU002.outbound.protection.outlook.com) ([52.101.44.4])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2025 12:32:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llTBMwxsGO/lAGRJNzWfspYWYYbNSOMcTgpJ+gaKGPod2Rc5NlFjVuki6cXtPcyXoMZe+cwTfOo15WxIpcP+Yf8bxG90bIMMUeSB6zRaTb8TfrOp6GqqECdJ3+IPx386JDOPLymccc0iLHpG8DWCyzcIPNcw/gGlcPs/+yAGRvOKxUaWHX7zUDcWPYfGTVUU7M4bUQw+a1M2UU0BqqWnJLOpAWARvUWF51IkSw7iiJXncu7Po912/bJqLizyK79Gxr4AqFg3azPus3IG0l1TGwdgKLsVFSjtr9meKOr/Am96JnvhbXrz+aztwJW+jtOVTKbxAB3CAmgTgO3UaC5l6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GvOeCf8YAdzeqf/RItDUkelEvgS74bnPj8/ZDCDI18=;
 b=TNFMzlmmpgfsaO5ctUE9D/E/hvv+94gdl6OdJmlqUqNmmFyzBDjbXJCv92/fM+IaiZNkqoL+qsGi9ZIHMRQBLuhOdDvEiPiNl0GF4OfM6UJoKcb1PDI6jZYFOcXcrWa8lJjRHrR6qbE2w9mjRnRAeF/TttP10X0dDjfpDJ3VnvnBE+DkdXrsJjcNs8nb+Ldh6kNJzTVhrb+6P572Q/LN8E7R5Qunwo5oIoYa01Gexpt2zELNTfbQpZNJop9Kj9TVbm7hLhS0ufXbCzcJs0c0O5Vb/Dl7LiBrzEHswTBb++eqcI5qLlL62GKPGvRAlCFD6TnKNbpuoRAM2rk3NcTZhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GvOeCf8YAdzeqf/RItDUkelEvgS74bnPj8/ZDCDI18=;
 b=bDzTy5E5Gf6IJ1NZ4Nh6rGyYiTN75lSnRD6+QcZUGD2B+2a0MBPcvKFfv3hBIKi8WPaalYwkcVVa5oC1lcvhA6wJ0FSHzK3SAQpABFWJttDOgh2oZ2qGjsDaR6KfdwGkzCajA/caISr5Xu6mV/0KH2jbTYeEKAv9WdqOVOVkCPw=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by CO1PR04MB8268.namprd04.prod.outlook.com (2603:10b6:303:153::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Fri, 13 Jun
 2025 04:32:17 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 04:32:17 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: blktests failures with v6.16-rc1 kernel
Thread-Topic: blktests failures with v6.16-rc1 kernel
Thread-Index: AQHb3Bwk2IWgsuPR4UGUNkoH6XCpfg==
Date: Fri, 13 Jun 2025 04:32:16 +0000
Message-ID: <4fdm37so3o4xricdgfosgmohn63aa7wj3ua4e5vpihoamwg3ui@fq42f5q5t5ic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|CO1PR04MB8268:EE_
x-ms-office365-filtering-correlation-id: c1aba3b2-64a2-4770-4c1c-08ddaa33472b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?jlzP8iADDIdrxxPIfZ4M6LRcQ6kekhn8bjp7MtQyGpYHIaYqnNp8tq7RYk++?=
 =?us-ascii?Q?8WuWEGn3F5AU+C/C6R7MtQfcBUUp+REtLQtbZONAgurC6GrQe4AfKswgoViJ?=
 =?us-ascii?Q?ef4+JqFqcbNSAFEAIKveFPfmfooTUl3p8CUgXw519Gy6RN5ydz1hvtBTJBBm?=
 =?us-ascii?Q?ZObS6LeXetPlSu6Whf3PvQAIFu5l8QED6n1Bnuy213EQQ5x+yUnfQoaA+B8B?=
 =?us-ascii?Q?OqSquTjd2aAGPPYhaRhbsFdqW3tkthMQTbE/Y/DA0gCvTUc3ya+3hEDB579t?=
 =?us-ascii?Q?li5Pfufs/R6wAGdVn8E/jUKLO3EoLwmmlKtmt54xToJSmUx/mYfnCP2mtnxA?=
 =?us-ascii?Q?qqGRNAkTY6JhykCs0fAcB+7Wp5PirIIE6STNZRrkG9C2IEHohK90tEy4Nuzj?=
 =?us-ascii?Q?1cLT2sber+NpY6sJfFWIEW1qFkJO9VzoRGq7mg2RpjeZ4pnBBiEdZ15PmLhe?=
 =?us-ascii?Q?Fh3BWzAhu42VUIVweS0pRHg3y6quPNcP8V7VGZyCi+6kj0yQ9IQeBf8Nrlr0?=
 =?us-ascii?Q?CXsZrD1iav9EfeLRxN++LMe7hWjZDtgWxROQNpGgTwwVA1LqIlWC599kXmlx?=
 =?us-ascii?Q?qzugcuqjEHCCyQef46GwijUH558ZZd3pA5d/y1b3Mlf0lyXVK5vrxZVwFMP1?=
 =?us-ascii?Q?8J7aziQ8bkElpfRACe992vxg9fzeXiBPJHqUuq4O3l/D28KzfMw5i6i2cR5T?=
 =?us-ascii?Q?Nj/CsrX0uFuCzuIQGvXv80dl2bHlUZQqe/yrXPzr7cJr0tZ2iRpRbdz/4NZ1?=
 =?us-ascii?Q?rpf4Uvg6Axwaonc4wXHjoZab3RsSq227bWCD0GvIuZccewzz4u8E3F4WWTFk?=
 =?us-ascii?Q?AvbOJcTag6H/5jpBIO36AOTFWC4bvfCP2DLFO68EFhiz28NnjkgCnwPxm77q?=
 =?us-ascii?Q?pocuAvO+ZDtHMLfmb+XUWK3w3OMxiRnQkj26TvJ901X2X0R5llYVCQM7ZuC0?=
 =?us-ascii?Q?68BlVj4iteyZIie/ArFWt70dO0CPJtnft6nXKgKQjoTCE73ST5t2hspWNR7g?=
 =?us-ascii?Q?1gmpbuZjaEg153UFv9oInypqmb09bYjCgnd8WMTAxqyVsCOYpM7reMqZjI+K?=
 =?us-ascii?Q?+McvWZU68b9FRosUKnNV95bCR0rrDQx3lhqpt21VSE1KS+oLpojNMOIZMdX7?=
 =?us-ascii?Q?ZEknLkwZ+LfZIQxvJ3oChpvtenkX8Hnbh7hDh9dnup8xDWG09PdXJMVlMH1+?=
 =?us-ascii?Q?ym+64/w6kQGA97LOhbWMaYOYyOc2P6b827eswtE0U0FEP7XJom0CgaK/Rxv/?=
 =?us-ascii?Q?N2haK5NF/zl/qHe6Zb8ErYCbDrpJ+T57LY45WJ+6LtTI+xNNF1JcJi4GeG/C?=
 =?us-ascii?Q?8OqjXaQn3sHZCi656hhsVDRqRhc+xmhzRAekwkSTolxPRG5e5CgsMrtM2red?=
 =?us-ascii?Q?L5ovVUa/uBRd+tNb5+0Jdh8VwdBlQcuK4ou0r2w6lTv4ByDMzf5gghedFpcI?=
 =?us-ascii?Q?/ocPb3TKTHUhlg7Zo8jcrX7iy5DEM2LYQzBl88dmiDRfXyoLO2+9dr6YvP71?=
 =?us-ascii?Q?AukRnna7Qdql6cw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ggs26m6qSAicQpMd4OSKbyJ3Jn67ejD2hy6KLL1kt2FT0QwMzSIaXzpHmWVJ?=
 =?us-ascii?Q?ou5QLJSia0tWKMKJgSKcSeBoCCot5Ch18VENizDM+wb0qyAnQwbrKKfaPz2b?=
 =?us-ascii?Q?CP5C+I4S9jopP/xqHQgjGP3kRwywCF3I+eiW5iU4CiYVdmInO90QZJwM40s4?=
 =?us-ascii?Q?vD47+0lKywk/l0+RLqTGb75FFyDCHZc2kR7j2GpwZo6ymMB57hF7nermdK2U?=
 =?us-ascii?Q?62N6Gd6mxrIH2nBeJeB4xlixTUZMHSq1UIDm704UoMQfWt2DGiRZ3A/R++9+?=
 =?us-ascii?Q?S7G6QRYPS3ZhnvsQyORa6np1tpjMcsRjbRC9HKeezQjuUhRQW31QdFihSZEK?=
 =?us-ascii?Q?6GIZZU/oKwNQlfwuRpxMdazrPmNzNPdkvMj1je47CJgAPFeZAS53YoJ5px32?=
 =?us-ascii?Q?7VuGb4pPfAqTaeqJhP1T4BV1JMVBymTWFZTeV+y+HjGql07BuFYHoVDkOYOC?=
 =?us-ascii?Q?ClhRvWO321Rn47h8j6sWPWJVbgt3ujKEAuee2x9qUuMXBRMiqPTF9hNljLDw?=
 =?us-ascii?Q?43GdvBvECthADEoaO8GEy6Nsh/hK2zXEqVxx2RgGl7mHGF5tTRbNMD++auok?=
 =?us-ascii?Q?2ERm+MbRrk3aThjNS/x5nqKu2etyPEiwIe8CMPOnt9kAQExwlQrYB5Hxf8TH?=
 =?us-ascii?Q?6kpuDOBYNyghSqtKfB9QYhJ/w/+S+GUSLsmvDrhbfhvxq9G4geUTBp7+f4z0?=
 =?us-ascii?Q?GAqPW7UNTO43sajTzsQINzIRKazSI4xp5B6rr6WAKu6F8bTrYqJtn41yOfT1?=
 =?us-ascii?Q?WcToKlIpavpBrEgHefpIncnwzM5yHkO6eSRtJIwA9LL/OlZbtlzIkDuw0iPX?=
 =?us-ascii?Q?kvq7VOCsJTyrHTM/UshRy2OHjf4xXK9VLQmAAoO6LfDXY/6iEaKE8c/fpvVH?=
 =?us-ascii?Q?P9ArP0C5CqfNQYxbDGkb7HU6dVc8VqtyhPfq8mEgyCsrcW6Z90/NWNCPyqHY?=
 =?us-ascii?Q?AGjfuvBC/gx/R6/w8YFI3mNaIvYngmJsRjDDUDqTp0qEBMDXS1S9Yy6a1XQj?=
 =?us-ascii?Q?sTnsouAqzcJQqVN3XRK35C+jehtUi1Mn9yBa2OgzFgVjOgQd8nFk3byXNNCg?=
 =?us-ascii?Q?ynD8YhRR8Fbn53s+l1OBdtKEbuH0fpkMoSTg+bVSBdaz1ckU8IPAFVVUwKf9?=
 =?us-ascii?Q?0sBeGm7RWeSraY5xVvOWETfdBtu+TUbHHJNTjAM4F3s8vqP9jxfhBMv8W2Nw?=
 =?us-ascii?Q?QrREC7VV28VLIrLTJND+IVKKy5VHA0HA8mNjEM+1Bwcq2jXnYtaBV+KtKFLE?=
 =?us-ascii?Q?awQN4ZDHduJ2L2b1i+oJoVtU8TOgxNTdMFUjbJVcE4JREb6buzJKD+VsnPtr?=
 =?us-ascii?Q?DKPguIR5RQvRcbvgYOsAG5BO3OQu6lyvASKFigmzoJovxhIuQV7dq62EZUS8?=
 =?us-ascii?Q?ontw+GM8lyr31gnLrGMfOSWDJtcInHRjs/N4s6113JU3Z8C3iXXoDx4IRKmk?=
 =?us-ascii?Q?gGvA7mz0yShN8+gkeAZlNS5ffcyBPy8PWIGIipogK9IGIMK5opxofX1tX0je?=
 =?us-ascii?Q?OlCYYAtMHSjDWFlWj4HRHCo2I23sJQrtFbBbIEd6+FE6WUjoMS55rT/bFZjV?=
 =?us-ascii?Q?/TfMmfoWhjKDReXMzktxzCdpoxz8Xmso7imZ16EyQ0BpuVNw2rgeZUfn3fpC?=
 =?us-ascii?Q?H6Obkf+dGVhFlf667Ph3v3U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AB2FE82206AD8244945D378867F5FB3F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mcVhxPRIhJrGrSKy39+Px0/01y4iN7uOXBNbK+Br50d3O+HuoH/pT7bQuIMNYW9c7EgzWTVBvhsz9Ve6uhYopg5ugsHrC2I4mEu1PsiCVBIj32v785Suda7x4Z2pjr5KnN+KUIpjfKOethdt4rfd2xikTsmePlmOsAuY4EFzRQFhcdpTdKyq+Ax1KUrUW3z3rF1TkSJ9HCpEDK3TMgI0aicbDMJG/3kgXbrVXnWpMDvbQGQT7zoBMTfR1+XQ4KLSJcN4tgIf5zdi8QAc8ivLMZUxWFJ6h73gaLx4ii6g9hZDL0yR84P1rZ6k4Cgzyq2j20iQfvX7fxmUOv7IsGYzkZQeZuHc/6h51YR2sssN2Ilrjq9oDJsoU00XjbV1ypv9xP1IDxXzcUrsp10oNwz4t6ImEoTx72cPzgNrQGn2JXEk9bhla6qPeuomRtm5EiTya+YMeyXhgE/6njnIrbr2D5EhNbD3swraFIg3bbo4AZqoHN35nfimhYhPXculzHWgcW9jtd+2Kv5Y/s5U4XW5UT+qJBWeCAz1JCGMLaTSyZnJj1flZB5q8I4c3EwkXJ9hh9FapAk+IjuIZg0anqeZQ85bHmRxrVrk7zej4gRaKjjOVtR6amUbO1MgHDZoX37N
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1aba3b2-64a2-4770-4c1c-08ddaa33472b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 04:32:17.0438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mMhB7v9j7wWnkgDEf13YJrHMRLpigmJP7U8VKAlVSZUMK9C9nnAosgzxAqaBnU8kLSSLBuAwH3BShvLZQ4zpOaq0MTu0jaQRNnwW+0Dqk/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR04MB8268

Hi all,

I ran the latest blktests (git hash: 401420a6261a) with the v6.16-rc1 kerne=
l. I
observed 4 failures listed below. Comparing with the previous report with t=
he
v6.15 kernel [1], 3 failures are no longer observed (nvme/023, nvme/061 han=
g and
q_usage_counter WARN during system boot). 1 new failure is observed (block/=
005),
and the test case nvme/063 shows a new failure symptom.

[1] https://lore.kernel.org/linux-block/2xsfqvnntjx5iiir7wghhebmnugmpfluv6e=
f22mghojgk6gilr@mvjscqxroqqk/

List of failures
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#1: block/005 (new)
#2: nvme/041 (fc transport)
#3: nvme/061 failure (fc transport)
#4: nvme/063 failure (tcp transport)(new failure symptom)


Failure description
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

#1: block/005

    When the test case is run for a NVME device as TEST_DEV, kernel reports=
 a
    lockdep WARN related to the 3 locks q->q_usage_counter, fs_reclaim and
    cpu_hotplug_lock [2].

    I found a fix patch is posted for similar lockdep WARN [3], but it does=
 not
    avoid the WARN at block/005.

    [3] https://lore.kernel.org/linux-block/20250528123638.1029700-1-nilay@=
linux.ibm.com/

#2: nvme/041 (fc transport)

    The test case nvme/041 fails for fc transport. Refer to the report for =
v6.12
    kernel [4].

    [4] https://lore.kernel.org/linux-nvme/6crydkodszx5vq4ieox3jjpwkxtu7mhb=
ohypy24awlo5w7f4k6@to3dcng24rd4/

#3: nvme/061 failure (fc transport)

    The test case nvme/061 sometimes fails due to a WARN and refcount messa=
ge
    "refcount_t: underflow; use-after-free."  Refer to the report for v6.15
    kernel [1].

#4: nvme/063 failure (tcp transport)

    With the kernel v6.15, the test case nvme/063 triggered the WARN
    in blk_mq_unquiesce_queue() and KASAN slab-use-after-free in
    blk_mq_queue_tag_busy_iter() [1]. These failure symptoms are no longer
    observed with v6.16-rc1 kernel. The WARN looks disappearing due to timi=
ng
    changes, probably. The KASAN was addressed by the fix in v6.16-rc1.

    However, the test case triggers a new failure symptom with v6.16-rc1
    kernel: a lockdep WARN related to the three locks q->q_usage_counter,
    q->elevator_lock and set->srcu [5].

    The fix patch recently posted for the similar lockdep WARN [3] did not =
avoid
    this WARN at nvme/063.


[2] dmesg during block/005 run

[ 4816.483647] [   T1313] run blktests block/005 at 2025-06-13 12:41:11

[ 4816.854611] [   T1313] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 4816.855325] [   T1313] WARNING: possible circular locking dependency det=
ected
[ 4816.856076] [   T1313] 6.16.0-rc1 #47 Not tainted
[ 4816.856559] [   T1313] -------------------------------------------------=
-----
[ 4816.857401] [   T1313] check/1313 is trying to acquire lock:
[ 4816.858021] [   T1313] ffffffffb2128210 (cpu_hotplug_lock){++++}-{0:0}, =
at: static_key_slow_inc+0xe/0x30
[ 4816.859004] [   T1313]=20
                          but task is already holding lock:
[ 4816.859781] [   T1313] ffff888101f6d8b0 (&q->q_usage_counter(io)#11){+++=
+}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0xe/0x20
[ 4816.860927] [   T1313]=20
                          which lock already depends on the new lock.

[ 4816.861826] [   T1313]=20
                          the existing dependency chain (in reverse order) =
is:
[ 4816.862592] [   T1313]=20
                          -> #2 (&q->q_usage_counter(io)#11){++++}-{0:0}:
[ 4816.863344] [   T1313]        blk_alloc_queue+0x5bc/0x700
[ 4816.863753] [   T1313]        blk_mq_alloc_queue+0x149/0x230
[ 4816.864149] [   T1313]        __blk_mq_alloc_disk+0x14/0xd0
[ 4816.864556] [   T1313]        nvme_alloc_ns+0x212/0x27c0 [nvme_core]
[ 4816.865032] [   T1313]        nvme_scan_ns+0x5d2/0x6d0 [nvme_core]
[ 4816.865483] [   T1313]        async_run_entry_fn+0x96/0x4f0
[ 4816.865905] [   T1313]        process_one_work+0x84f/0x1460
[ 4816.866296] [   T1313]        worker_thread+0x5ef/0xfd0
[ 4816.866618] [   T1313]        kthread+0x3b0/0x770
[ 4816.866925] [   T1313]        ret_from_fork+0x3af/0x4d0
[ 4816.867213] [   T1313]        ret_from_fork_asm+0x1a/0x30
[ 4816.867510] [   T1313]=20
                          -> #1 (fs_reclaim){+.+.}-{0:0}:
[ 4816.867939] [   T1313]        fs_reclaim_acquire+0xc5/0x100
[ 4816.868252] [   T1313]        __kmalloc_cache_node_noprof+0x58/0x450
[ 4816.868605] [   T1313]        create_worker+0xfe/0x6f0
[ 4816.868901] [   T1313]        workqueue_prepare_cpu+0x84/0xe0
[ 4816.869226] [   T1313]        cpuhp_invoke_callback+0x2c0/0x1030
[ 4816.869568] [   T1313]        __cpuhp_invoke_callback_range+0xbf/0x1f0
[ 4816.869869] [   T1313]        _cpu_up+0x2e7/0x690
[ 4816.870079] [   T1313]        cpu_up+0x117/0x170
[ 4816.870275] [   T1313]        cpuhp_bringup_mask+0xd5/0x120
[ 4816.870511] [   T1313]        bringup_nonboot_cpus+0x139/0x170
[ 4816.870769] [   T1313]        smp_init+0x27/0xe0
[ 4816.871415] [   T1313]        kernel_init_freeable+0x441/0x6d0
[ 4816.872099] [   T1313]        kernel_init+0x18/0x150
[ 4816.872703] [   T1313]        ret_from_fork+0x3af/0x4d0
[ 4816.873350] [   T1313]        ret_from_fork_asm+0x1a/0x30
[ 4816.873949] [   T1313]=20
                          -> #0 (cpu_hotplug_lock){++++}-{0:0}:
[ 4816.875021] [   T1313]        __lock_acquire+0x143c/0x2220
[ 4816.875621] [   T1313]        lock_acquire+0x170/0x310
[ 4816.876254] [   T1313]        cpus_read_lock+0x3c/0xe0
[ 4816.876813] [   T1313]        static_key_slow_inc+0xe/0x30
[ 4816.877419] [   T1313]        rq_qos_add+0x266/0x430
[ 4816.877981] [   T1313]        wbt_init+0x359/0x490
[ 4816.878528] [   T1313]        elevator_change_done+0x3a8/0x4c0
[ 4816.879168] [   T1313]        elv_iosched_store+0x24f/0x2c0
[ 4816.879732] [   T1313]        queue_attr_store+0x23f/0x300
[ 4816.880304] [   T1313]        kernfs_fop_write_iter+0x39f/0x5a0
[ 4816.880891] [   T1313]        vfs_write+0x521/0xea0
[ 4816.881433] [   T1313]        ksys_write+0xf5/0x1c0
[ 4816.881965] [   T1313]        do_syscall_64+0x95/0x3d0
[ 4816.882562] [   T1313]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 4816.883152] [   T1313]=20
                          other info that might help us debug this:

[ 4816.884537] [   T1313] Chain exists of:
                            cpu_hotplug_lock --> fs_reclaim --> &q->q_usage=
_counter(io)#11

[ 4816.886077] [   T1313]  Possible unsafe locking scenario:

[ 4816.887020] [   T1313]        CPU0                    CPU1
[ 4816.887584] [   T1313]        ----                    ----
[ 4816.888130] [   T1313]   lock(&q->q_usage_counter(io)#11);
[ 4816.888682] [   T1313]                                lock(fs_reclaim);
[ 4816.889259] [   T1313]                                lock(&q->q_usage_c=
ounter(io)#11);
[ 4816.889885] [   T1313]   rlock(cpu_hotplug_lock);
[ 4816.890406] [   T1313]=20
                           *** DEADLOCK ***

[ 4816.891773] [   T1313] 7 locks held by check/1313:
[ 4816.892292] [   T1313]  #0: ffff8881206f8428 (sb_writers#4){.+.+}-{0:0},=
 at: ksys_write+0xf5/0x1c0
[ 4816.893109] [   T1313]  #1: ffff888103373488 (&of->mutex#2){+.+.}-{4:4},=
 at: kernfs_fop_write_iter+0x25c/0x5a0
[ 4816.893834] [   T1313]  #2: ffff888104d83698 (kn->active#72){.+.+}-{0:0}=
, at: kernfs_fop_write_iter+0x27f/0x5a0
[ 4816.894575] [   T1313]  #3: ffff888100d74190 (&set->update_nr_hwq_lock){=
.+.+}-{4:4}, at: elv_iosched_store+0x1b8/0x2c0
[ 4816.895394] [   T1313]  #4: ffff888101f6dab0 (&q->rq_qos_mutex){+.+.}-{4=
:4}, at: wbt_init+0x343/0x490
[ 4816.896119] [   T1313]  #5: ffff888101f6d8b0 (&q->q_usage_counter(io)#11=
){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0xe/0x20
[ 4816.896953] [   T1313]  #6: ffff888101f6d8e8 (&q->q_usage_counter(queue)=
#5){+.+.}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0xe/0x20
[ 4816.897778] [   T1313]=20
                          stack backtrace:
[ 4816.898820] [   T1313] CPU: 2 UID: 0 PID: 1313 Comm: check Not tainted 6=
.16.0-rc1 #47 PREEMPT(voluntary)=20
[ 4816.898823] [   T1313] Hardware name: QEMU Standard PC (i440FX + PIIX, 1=
996), BIOS 1.16.3-3.fc41 04/01/2014
[ 4816.898825] [   T1313] Call Trace:
[ 4816.898827] [   T1313]  <TASK>
[ 4816.898829] [   T1313]  dump_stack_lvl+0x6a/0x90
[ 4816.898832] [   T1313]  print_circular_bug.cold+0x178/0x1be
[ 4816.898836] [   T1313]  check_noncircular+0x146/0x160
[ 4816.898840] [   T1313]  __lock_acquire+0x143c/0x2220
[ 4816.898843] [   T1313]  lock_acquire+0x170/0x310
[ 4816.898844] [   T1313]  ? static_key_slow_inc+0xe/0x30
[ 4816.898847] [   T1313]  ? __pfx___might_resched+0x10/0x10
[ 4816.898850] [   T1313]  cpus_read_lock+0x3c/0xe0
[ 4816.898852] [   T1313]  ? static_key_slow_inc+0xe/0x30
[ 4816.898854] [   T1313]  static_key_slow_inc+0xe/0x30
[ 4816.898856] [   T1313]  rq_qos_add+0x266/0x430
[ 4816.898859] [   T1313]  wbt_init+0x359/0x490
[ 4816.898862] [   T1313]  elevator_change_done+0x3a8/0x4c0
[ 4816.898866] [   T1313]  elv_iosched_store+0x24f/0x2c0
[ 4816.898868] [   T1313]  ? __pfx_elv_iosched_store+0x10/0x10
[ 4816.898870] [   T1313]  ? lock_acquire+0x180/0x310
[ 4816.898872] [   T1313]  ? __pfx___might_resched+0x10/0x10
[ 4816.898875] [   T1313]  ? __pfx_sysfs_kf_write+0x10/0x10
[ 4816.898877] [   T1313]  queue_attr_store+0x23f/0x300
[ 4816.898880] [   T1313]  ? __pfx_queue_attr_store+0x10/0x10
[ 4816.898884] [   T1313]  ? find_held_lock+0x2b/0x80
[ 4816.898885] [   T1313]  ? sysfs_file_kobj+0xb3/0x1c0
[ 4816.898887] [   T1313]  ? sysfs_file_kobj+0xb3/0x1c0
[ 4816.898888] [   T1313]  ? lock_release+0x17d/0x2c0
[ 4816.898890] [   T1313]  ? lock_is_held_type+0xd5/0x130
[ 4816.898892] [   T1313]  ? __pfx_sysfs_kf_write+0x10/0x10
[ 4816.898893] [   T1313]  ? sysfs_file_kobj+0xbd/0x1c0
[ 4816.898896] [   T1313]  ? __pfx_sysfs_kf_write+0x10/0x10
[ 4816.898897] [   T1313]  kernfs_fop_write_iter+0x39f/0x5a0
[ 4816.898899] [   T1313]  vfs_write+0x521/0xea0
[ 4816.898901] [   T1313]  ? get_close_on_exec+0xfc/0x230
[ 4816.898903] [   T1313]  ? lock_release+0x17d/0x2c0
[ 4816.898905] [   T1313]  ? __pfx_vfs_write+0x10/0x10
[ 4816.898907] [   T1313]  ? do_fcntl+0x552/0x10b0
[ 4816.898910] [   T1313]  ? find_held_lock+0x2b/0x80
[ 4816.898912] [   T1313]  ksys_write+0xf5/0x1c0
[ 4816.898914] [   T1313]  ? __pfx_ksys_write+0x10/0x10
[ 4816.898915] [   T1313]  ? lock_release+0x17d/0x2c0
[ 4816.898918] [   T1313]  do_syscall_64+0x95/0x3d0
[ 4816.898920] [   T1313]  ? do_wp_page+0x15ec/0x3440
[ 4816.898923] [   T1313]  ? __pfx_do_wp_page+0x10/0x10
[ 4816.898925] [   T1313]  ? do_raw_spin_lock+0x129/0x260
[ 4816.898927] [   T1313]  ? __pfx_do_raw_spin_lock+0x10/0x10
[ 4816.898929] [   T1313]  ? __pfx_pte_write+0x10/0x10
[ 4816.898933] [   T1313]  ? __handle_mm_fault+0x1447/0x1da0
[ 4816.898937] [   T1313]  ? __lock_acquire+0x45d/0x2220
[ 4816.898940] [   T1313]  ? find_held_lock+0x2b/0x80
[ 4816.898942] [   T1313]  ? rcu_read_unlock+0x17/0x60
[ 4816.898943] [   T1313]  ? rcu_read_unlock+0x17/0x60
[ 4816.898945] [   T1313]  ? lock_release+0x17d/0x2c0
[ 4816.898947] [   T1313]  ? find_held_lock+0x2b/0x80
[ 4816.898949] [   T1313]  ? exc_page_fault+0x71/0xf0
[ 4816.898950] [   T1313]  ? exc_page_fault+0x71/0xf0
[ 4816.898951] [   T1313]  ? lock_release+0x17d/0x2c0
[ 4816.898954] [   T1313]  ? do_user_addr_fault+0x4c7/0xa30
[ 4816.898960] [   T1313]  ? irqentry_exit_to_user_mode+0x84/0x270
[ 4816.898962] [   T1313]  ? rcu_is_watching+0x11/0xb0
[ 4816.898966] [   T1313]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 4816.898968] [   T1313] RIP: 0033:0x7fb125128f44
[ 4816.898970] [   T1313] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0=
f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d 85 91 10 00 00 74 13 b8 01 00 00 0=
0 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
[ 4816.898971] [   T1313] RSP: 002b:00007ffcfa589198 EFLAGS: 00000202 ORIG_=
RAX: 0000000000000001
[ 4816.898974] [   T1313] RAX: ffffffffffffffda RBX: 000000000000000c RCX: =
00007fb125128f44
[ 4816.898975] [   T1313] RDX: 000000000000000c RSI: 000055cc19651430 RDI: =
0000000000000001
[ 4816.898976] [   T1313] RBP: 00007ffcfa5891c0 R08: 0000000000000073 R09: =
00000000ffffffff
[ 4816.898977] [   T1313] R10: 0000000000000000 R11: 0000000000000202 R12: =
000000000000000c
[ 4816.898978] [   T1313] R13: 000055cc19651430 R14: 00007fb12522b5c0 R15: =
00007fb125228e80
[ 4816.898981] [   T1313]  </TASK>


[5] dmesg during nvme/063 run

[   63.546255] [    T922] run blktests nvme/063 at 2025-06-13 13:13:57
[   63.812566] [   T1031] nvmet: adding nsid 1 to subsystem blktests-subsys=
tem-1
[   63.848864] [   T1032] nvmet: Allow non-TLS connections while TLS1.3 is =
enabled
[   63.866702] [   T1035] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[   64.025921] [    T145] nvmet: Created nvm controller 1 for subsystem blk=
tests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-485=
6-b0b3-51e60b8de349 with DH-HMAC-CHAP.
[   64.039255] [     T57] nvme nvme1: qid 0: authenticated with hash hmac(s=
ha256) dhgroup ffdhe2048
[   64.040785] [   T1045] nvme nvme1: qid 0: authenticated
[   64.043977] [   T1045] nvme nvme1: Please enable CONFIG_NVME_MULTIPATH f=
or full support of multi-port devices.
[   64.156903] [    T104] nvmet: Created nvm controller 1 for subsystem blk=
tests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-485=
6-b0b3-51e60b8de349, TLS.
[   64.161798] [   T1045] nvme nvme1: Please enable CONFIG_NVME_MULTIPATH f=
or full support of multi-port devices.
[   64.163010] [   T1045] nvme nvme1: creating 4 I/O queues.
[   64.198714] [   T1045] nvme nvme1: mapped 4/0/0 default/read/poll queues=
.
[   64.203808] [   T1045] nvme nvme1: new ctrl: NQN "blktests-subsystem-1",=
 addr 127.0.0.1:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7=
f-4856-b0b3-51e60b8de349
[   64.359043] [   T1090] nvme nvme1: resetting controller
[   64.373721] [    T104] nvmet: Created nvm controller 2 for subsystem blk=
tests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-485=
6-b0b3-51e60b8de349 with DH-HMAC-CHAP.
[   64.390279] [     T13] nvme nvme1: qid 0: authenticated with hash hmac(s=
ha256) dhgroup ffdhe2048
[   64.391724] [     T85] nvme nvme1: qid 0: authenticated
[   64.395083] [     T85] nvme nvme1: Please enable CONFIG_NVME_MULTIPATH f=
or full support of multi-port devices.
[   64.416798] [     T65] nvmet: Created nvm controller 1 for subsystem blk=
tests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-485=
6-b0b3-51e60b8de349, TLS.
[   64.422572] [     T85] nvme nvme1: Please enable CONFIG_NVME_MULTIPATH f=
or full support of multi-port devices.
[   64.424606] [     T85] nvme nvme1: creating 4 I/O queues.
[   64.485008] [     T85] nvme nvme1: mapped 4/0/0 default/read/poll queues=
.
[   64.529870] [   T1104] nvme nvme1: Removing ctrl: NQN "blktests-subsyste=
m-1"

[   64.563449] [   T1104] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   64.564278] [   T1104] WARNING: possible circular locking dependency det=
ected
[   64.565048] [   T1104] 6.16.0-rc1 #47 Not tainted
[   64.565539] [   T1104] -------------------------------------------------=
-----
[   64.566333] [   T1104] nvme/1104 is trying to acquire lock:
[   64.566919] [   T1104] ffff88810de69390 (set->srcu){.+.+}-{0:0}, at: __s=
ynchronize_srcu+0x21/0x240
[   64.567914] [   T1104]=20
                          but task is already holding lock:
[   64.568754] [   T1104] ffff888146d1a338 (&q->elevator_lock){+.+.}-{4:4},=
 at: elevator_change+0xbb/0x370
[   64.569780] [   T1104]=20
                          which lock already depends on the new lock.

[   64.570918] [   T1104]=20
                          the existing dependency chain (in reverse order) =
is:
[   64.571904] [   T1104]=20
                          -> #5 (&q->elevator_lock){+.+.}-{4:4}:
[   64.576069] [   T1104]        __mutex_lock+0x1a9/0x1a40
[   64.577769] [   T1104]        elevator_change+0xbb/0x370
[   64.579213] [   T1104]        elv_iosched_store+0x24f/0x2c0
[   64.580532] [   T1104]        queue_attr_store+0x23f/0x300
[   64.581717] [   T1104]        kernfs_fop_write_iter+0x39f/0x5a0
[   64.582845] [   T1104]        vfs_write+0x521/0xea0
[   64.583727] [   T1104]        ksys_write+0xf5/0x1c0
[   64.584589] [   T1104]        do_syscall_64+0x95/0x3d0
[   64.585406] [   T1104]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   64.586199] [   T1104]=20
                          -> #4 (&q->q_usage_counter(io)){++++}-{0:0}:
[   64.587578] [   T1104]        blk_alloc_queue+0x5bc/0x700
[   64.588367] [   T1104]        blk_mq_alloc_queue+0x149/0x230
[   64.589131] [   T1104]        scsi_alloc_sdev+0x848/0xc70
[   64.589896] [   T1104]        scsi_probe_and_add_lun+0x475/0xb50
[   64.590673] [   T1104]        __scsi_add_device+0x1c0/0x1f0
[   64.591431] [   T1104]        ata_scsi_scan_host+0x139/0x390
[   64.592164] [   T1104]        async_run_entry_fn+0x96/0x4f0
[   64.592917] [   T1104]        process_one_work+0x84f/0x1460
[   64.593660] [   T1104]        worker_thread+0x5ef/0xfd0
[   64.594385] [   T1104]        kthread+0x3b0/0x770
[   64.595040] [   T1104]        ret_from_fork+0x3af/0x4d0
[   64.595724] [   T1104]        ret_from_fork_asm+0x1a/0x30
[   64.596383] [   T1104]=20
                          -> #3 (fs_reclaim){+.+.}-{0:0}:
[   64.597572] [   T1104]        fs_reclaim_acquire+0xc5/0x100
[   64.598251] [   T1104]        __kmalloc_cache_noprof+0x55/0x450
[   64.598901] [   T1104]        __request_module+0x213/0x500
[   64.599585] [   T1104]        tcp_set_ulp+0x381/0x5d0
[   64.600178] [   T1104]        do_tcp_setsockopt+0x3ef/0x2260
[   64.600756] [   T1104]        do_sock_setsockopt+0x1b2/0x3b0
[   64.601358] [   T1104]        __sys_setsockopt+0xe7/0x180
[   64.601924] [   T1104]        __x64_sys_setsockopt+0xb9/0x150
[   64.602539] [   T1104]        do_syscall_64+0x95/0x3d0
[   64.603101] [   T1104]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   64.603699] [   T1104]=20
                          -> #2 (sk_lock-AF_INET-NVME){+.+.}-{0:0}:
[   64.604765] [   T1104]        lock_sock_nested+0x37/0xd0
[   64.605367] [   T1104]        tls_sw_sendmsg+0x18f/0x2670 [tls]
[   64.606007] [   T1104]        sock_sendmsg+0x2f7/0x410
[   64.606563] [   T1104]        nvme_tcp_init_connection+0x3a4/0x940 [nvme=
_tcp]
[   64.607174] [   T1104]        nvme_tcp_alloc_queue+0x14d8/0x1b70 [nvme_t=
cp]
[   64.607802] [   T1104]        nvme_tcp_alloc_admin_queue+0xd5/0x340 [nvm=
e_tcp]
[   64.608502] [   T1104]        nvme_tcp_setup_ctrl+0x15c/0x7f0 [nvme_tcp]
[   64.609107] [   T1104]        nvme_tcp_create_ctrl+0x835/0xb90 [nvme_tcp=
]
[   64.609710] [   T1104]        nvmf_dev_write+0x3db/0x7e0 [nvme_fabrics]
[   64.610357] [   T1104]        vfs_write+0x1cc/0xea0
[   64.610915] [   T1104]        ksys_write+0xf5/0x1c0
[   64.611488] [   T1104]        do_syscall_64+0x95/0x3d0
[   64.612065] [   T1104]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   64.612657] [   T1104]=20
                          -> #1 (&ctx->tx_lock){+.+.}-{4:4}:
[   64.613674] [   T1104]        __mutex_lock+0x1a9/0x1a40
[   64.614239] [   T1104]        tls_sw_sendmsg+0x11e/0x2670 [tls]
[   64.614860] [   T1104]        sock_sendmsg+0x2f7/0x410
[   64.615425] [   T1104]        nvme_tcp_try_send_cmd_pdu+0x5a0/0xc10 [nvm=
e_tcp]
[   64.616052] [   T1104]        nvme_tcp_try_send+0x1b6/0x9b0 [nvme_tcp]
[   64.616609] [   T1104]        nvme_tcp_queue_rq+0xfb8/0x19e0 [nvme_tcp]
[   64.617204] [   T1104]        blk_mq_dispatch_rq_list+0x3a9/0x2350
[   64.617766] [   T1104]        __blk_mq_sched_dispatch_requests+0x1da/0x1=
4b0
[   64.618447] [   T1104]        blk_mq_sched_dispatch_requests+0xa8/0x150
[   64.619049] [   T1104]        blk_mq_run_work_fn+0x121/0x2a0
[   64.619600] [   T1104]        process_one_work+0x84f/0x1460
[   64.620176] [   T1104]        worker_thread+0x5ef/0xfd0
[   64.620706] [   T1104]        kthread+0x3b0/0x770
[   64.621226] [   T1104]        ret_from_fork+0x3af/0x4d0
[   64.621761] [   T1104]        ret_from_fork_asm+0x1a/0x30
[   64.622381] [   T1104]=20
                          -> #0 (set->srcu){.+.+}-{0:0}:
[   64.623368] [   T1104]        __lock_acquire+0x143c/0x2220
[   64.623959] [   T1104]        lock_sync+0xa4/0x100
[   64.624500] [   T1104]        __synchronize_srcu+0xa7/0x240
[   64.625084] [   T1104]        elevator_switch+0x2a4/0x620
[   64.625654] [   T1104]        elevator_change+0x208/0x370
[   64.626225] [   T1104]        elevator_set_none+0x82/0xd0
[   64.626828] [   T1104]        blk_unregister_queue+0x140/0x2b0
[   64.627442] [   T1104]        __del_gendisk+0x265/0x9e0
[   64.628006] [   T1104]        del_gendisk+0x101/0x190
[   64.628568] [   T1104]        nvme_ns_remove+0x2d7/0x740 [nvme_core]
[   64.629207] [   T1104]        nvme_remove_namespaces+0x25d/0x3a0 [nvme_c=
ore]
[   64.629853] [   T1104]        nvme_do_delete_ctrl+0xf5/0x160 [nvme_core]
[   64.630516] [   T1104]        nvme_delete_ctrl_sync.cold+0x8/0xd [nvme_c=
ore]
[   64.631168] [   T1104]        nvme_sysfs_delete+0x92/0xb0 [nvme_core]
[   64.631780] [   T1104]        kernfs_fop_write_iter+0x39f/0x5a0
[   64.632464] [   T1104]        vfs_write+0x521/0xea0
[   64.633019] [   T1104]        ksys_write+0xf5/0x1c0
[   64.633576] [   T1104]        do_syscall_64+0x95/0x3d0
[   64.634106] [   T1104]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   64.634707] [   T1104]=20
                          other info that might help us debug this:

[   64.636243] [   T1104] Chain exists of:
                            set->srcu --> &q->q_usage_counter(io) --> &q->e=
levator_lock

[   64.637859] [   T1104]  Possible unsafe locking scenario:

[   64.638976] [   T1104]        CPU0                    CPU1
[   64.639578] [   T1104]        ----                    ----
[   64.640195] [   T1104]   lock(&q->elevator_lock);
[   64.640741] [   T1104]                                lock(&q->q_usage_c=
ounter(io));
[   64.641447] [   T1104]                                lock(&q->elevator_=
lock);
[   64.642086] [   T1104]   sync(set->srcu);
[   64.642615] [   T1104]=20
                           *** DEADLOCK ***

[   64.643970] [   T1104] 5 locks held by nvme/1104:
[   64.644519] [   T1104]  #0: ffff888130b0c428 (sb_writers#4){.+.+}-{0:0},=
 at: ksys_write+0xf5/0x1c0
[   64.645245] [   T1104]  #1: ffff888135bed088 (&of->mutex#2){+.+.}-{4:4},=
 at: kernfs_fop_write_iter+0x25c/0x5a0
[   64.645999] [   T1104]  #2: ffff8881547d1e18 (kn->active#134){++++}-{0:0=
}, at: sysfs_remove_file_self+0x61/0xb0
[   64.646789] [   T1104]  #3: ffff8881321b4190 (&set->update_nr_hwq_lock){=
++++}-{4:4}, at: del_gendisk+0xf9/0x190
[   64.647530] [   T1104]  #4: ffff888146d1a338 (&q->elevator_lock){+.+.}-{=
4:4}, at: elevator_change+0xbb/0x370
[   64.648281] [   T1104]=20
                          stack backtrace:
[   64.649220] [   T1104] CPU: 0 UID: 0 PID: 1104 Comm: nvme Not tainted 6.=
16.0-rc1 #47 PREEMPT(voluntary)=20
[   64.649224] [   T1104] Hardware name: QEMU Standard PC (i440FX + PIIX, 1=
996), BIOS 1.16.3-3.fc41 04/01/2014
[   64.649226] [   T1104] Call Trace:
[   64.649228] [   T1104]  <TASK>
[   64.649231] [   T1104]  dump_stack_lvl+0x6a/0x90
[   64.649234] [   T1104]  print_circular_bug.cold+0x178/0x1be
[   64.649238] [   T1104]  check_noncircular+0x146/0x160
[   64.649242] [   T1104]  __lock_acquire+0x143c/0x2220
[   64.649245] [   T1104]  ? __synchronize_srcu+0x21/0x240
[   64.649247] [   T1104]  lock_sync+0xa4/0x100
[   64.649248] [   T1104]  ? __synchronize_srcu+0x21/0x240
[   64.649251] [   T1104]  __synchronize_srcu+0xa7/0x240
[   64.649253] [   T1104]  ? __pfx___synchronize_srcu+0x10/0x10
[   64.649257] [   T1104]  ? ktime_get_mono_fast_ns+0x81/0x360
[   64.649260] [   T1104]  ? _raw_spin_unlock_irqrestore+0x4c/0x60
[   64.649263] [   T1104]  elevator_switch+0x2a4/0x620
[   64.649265] [   T1104]  elevator_change+0x208/0x370
[   64.649267] [   T1104]  elevator_set_none+0x82/0xd0
[   64.649269] [   T1104]  ? __pfx_elevator_set_none+0x10/0x10
[   64.649271] [   T1104]  ? kobject_put+0x5d/0x4a0
[   64.649274] [   T1104]  blk_unregister_queue+0x140/0x2b0
[   64.649276] [   T1104]  __del_gendisk+0x265/0x9e0
[   64.649278] [   T1104]  ? down_read+0x13c/0x470
[   64.649280] [   T1104]  ? del_gendisk+0xb0/0x190
[   64.649282] [   T1104]  ? __pfx___del_gendisk+0x10/0x10
[   64.649284] [   T1104]  ? up_write+0x1c6/0x500
[   64.649287] [   T1104]  del_gendisk+0x101/0x190
[   64.649289] [   T1104]  nvme_ns_remove+0x2d7/0x740 [nvme_core]
[   64.649300] [   T1104]  nvme_remove_namespaces+0x25d/0x3a0 [nvme_core]
[   64.649312] [   T1104]  ? __pfx_nvme_remove_namespaces+0x10/0x10 [nvme_c=
ore]
[   64.649320] [   T1104]  ? __pfx___might_resched+0x10/0x10
[   64.649323] [   T1104]  ? __pfx_sysfs_kf_write+0x10/0x10
[   64.649325] [   T1104]  nvme_do_delete_ctrl+0xf5/0x160 [nvme_core]
[   64.649334] [   T1104]  nvme_delete_ctrl_sync.cold+0x8/0xd [nvme_core]
[   64.649343] [   T1104]  nvme_sysfs_delete+0x92/0xb0 [nvme_core]
[   64.649352] [   T1104]  kernfs_fop_write_iter+0x39f/0x5a0
[   64.649354] [   T1104]  vfs_write+0x521/0xea0
[   64.649357] [   T1104]  ? __pfx_vfs_write+0x10/0x10
[   64.649361] [   T1104]  ksys_write+0xf5/0x1c0
[   64.649362] [   T1104]  ? __pfx_ksys_write+0x10/0x10
[   64.649365] [   T1104]  do_syscall_64+0x95/0x3d0
[   64.649367] [   T1104]  ? do_sys_openat2+0x108/0x180
[   64.649370] [   T1104]  ? do_sys_openat2+0x108/0x180
[   64.649372] [   T1104]  ? __pfx_do_sys_openat2+0x10/0x10
[   64.649374] [   T1104]  ? fput_close_sync+0xe1/0x1b0
[   64.649376] [   T1104]  ? __pfx_fput_close_sync+0x10/0x10
[   64.649378] [   T1104]  ? __x64_sys_openat+0x104/0x1d0
[   64.649380] [   T1104]  ? __pfx___x64_sys_openat+0x10/0x10
[   64.649383] [   T1104]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   64.649384] [   T1104]  ? lockdep_hardirqs_on+0x78/0x100
[   64.649386] [   T1104]  ? do_syscall_64+0x16c/0x3d0
[   64.649388] [   T1104]  ? fput_close_sync+0xe1/0x1b0
[   64.649390] [   T1104]  ? __pfx_fput_close_sync+0x10/0x10
[   64.649392] [   T1104]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   64.649393] [   T1104]  ? lockdep_hardirqs_on+0x78/0x100
[   64.649395] [   T1104]  ? do_syscall_64+0x16c/0x3d0
[   64.649396] [   T1104]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   64.649397] [   T1104]  ? lockdep_hardirqs_on+0x78/0x100
[   64.649399] [   T1104]  ? do_syscall_64+0x16c/0x3d0
[   64.649400] [   T1104]  ? lockdep_hardirqs_on+0x78/0x100
[   64.649401] [   T1104]  ? do_syscall_64+0x16c/0x3d0
[   64.649403] [   T1104]  ? do_syscall_64+0x16c/0x3d0
[   64.649404] [   T1104]  ? do_syscall_64+0x16c/0x3d0
[   64.649406] [   T1104]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   64.649408] [   T1104] RIP: 0033:0x7f9168f4ff44
[   64.649411] [   T1104] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0=
f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d 85 91 10 00 00 74 13 b8 01 00 00 0=
0 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
[   64.649413] [   T1104] RSP: 002b:00007ffd29f8c718 EFLAGS: 00000202 ORIG_=
RAX: 0000000000000001
[   64.649415] [   T1104] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: =
00007f9168f4ff44
[   64.649416] [   T1104] RDX: 0000000000000001 RSI: 00007f91690a0786 RDI: =
0000000000000003
[   64.649417] [   T1104] RBP: 00007f91690a0786 R08: 0000000000004000 R09: =
00000000ffffffff
[   64.649418] [   T1104] R10: 0000000000000000 R11: 0000000000000202 R12: =
00000000213de610
[   64.649419] [   T1104] R13: 00007ffd29f8d662 R14: 00000000213de610 R15: =
00000000213def60
[   64.649422] [   T1104]  </TASK>
[   64.876891] [     T81] nvmet: Created nvm controller 1 for subsystem blk=
tests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-485=
6-b0b3-51e60b8de349 with DH-HMAC-CHAP.
[   64.911134] [     T85] nvme nvme1: qid 0: authenticated with hash hmac(s=
ha384) dhgroup ffdhe3072
[   64.914478] [   T1119] nvme nvme1: qid 0: authenticated
[   64.918322] [   T1119] nvme nvme1: Please enable CONFIG_NVME_MULTIPATH f=
or full support of multi-port devices.
[   64.975626] [     T65] nvmet: Created nvm controller 1 for subsystem blk=
tests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-485=
6-b0b3-51e60b8de349, TLS.
[   64.982354] [   T1119] nvme nvme1: Please enable CONFIG_NVME_MULTIPATH f=
or full support of multi-port devices.
[   64.984272] [   T1119] nvme nvme1: creating 4 I/O queues.
[   65.017021] [   T1119] nvme nvme1: mapped 4/0/0 default/read/poll queues=
.
[   65.023046] [   T1119] nvme nvme1: new ctrl: NQN "blktests-subsystem-1",=
 addr 127.0.0.1:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7=
f-4856-b0b3-51e60b8de349
[   65.109724] [   T1155] nvme nvme1: Removing ctrl: NQN "blktests-subsyste=
m-1"=

