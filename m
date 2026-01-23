Return-Path: <linux-rdma+bounces-15915-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EK5zMiYrc2kAswAAu9opvQ
	(envelope-from <linux-rdma+bounces-15915-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 09:02:46 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3154E72235
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 09:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BADF305A6E3
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 07:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66247346E70;
	Fri, 23 Jan 2026 07:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B37T2zwj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012022.outbound.protection.outlook.com [40.107.209.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BE82E7F3E;
	Fri, 23 Jan 2026 07:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769155183; cv=fail; b=CM2Ib5F3KMwOWOC6nbp6lVRXUXrz+royjZugzP4t5jyCsFfI/hOmIfi54Jg/Z8J3sAvrlxBrWAfZ1IKk69N22rjWsEgBgGndmDYIxgrnGvOVtoPrqW9+Qep46pgbZU7KAQeKDdrxrKsS7uo+HJuDaWCQDIX0vrRn0vZB+I1ouUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769155183; c=relaxed/simple;
	bh=WN01GRg6ARzlyQ6POq42eQZ9i3b9fYYditmzeQI2gRQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WfxAXP0qg+h9hxaLD5iy1jviKvVP5Z+yGzHCKi/PLJiKq0Zd1os91cDlfUT0GIAV0UgsPsYbke5syTnutxmmPjPCGhVwPy6uXPrI2vvtXtE5QZlrfTK/o0ri6+LcnHN6/SM8XGV/1v6hz+jfl+jT6YM9JgvDG9iqm5Dim2yWnx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B37T2zwj; arc=fail smtp.client-ip=40.107.209.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUxhG2aw0Gq/4TOYpb/gqlGzOtwFAYfPlTLo4hJCOkiUCCzveTpvgAgAyCjaKDrBQUBpFuMWfQ0BPP+h+Dd9evFf8x4qSS3EfcWnkFRyc1j8dEJLY/j+YluobyDP6HqHdKIFBCsD1tP692GcxbfOaar+rbEBI1tpLI06GmBzDRuNQ4F7tR7ax5A1my5pRgFan4a5vHALFbh114lB2now7MqcVd287TAoNwnp7T6Mkl4fdGERBs2K8sNROb+UU+AguLrBxlT7qQAKFcf96WzQDG0ZNNuFdBNvYAp6M6Xm6KnAcaWLtzVcYFbxca+Ybmm692CjWOglZra5JcSV2VyDCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5v/XZQnB9caZU2S6staWi/rviO2O4MakhQh40oHdlM=;
 b=ZoR31YRQFeEze+Qa4n4TV3QlO3w+3gZWFPDz87bOzhV90ofntE7TdSUBHaxQ1oQL8zFoDCx1cn8JAgFOn2DcRW456z6W3OTbWCjFQckcZXFy5+lK1QU7OU1VnSj7Qil1juay8Uv+KceodGxTFvhdnNfnSU1ZJjc4kXenIeINpfONI2HyMtPHiTi+iwmbXoBG6cNTBcw+S7BHZrTVFtGQmLZumdeRepPSEVFSof3M/o8Tvv+xTdiUw6j8uDXy9BQElCl9gyXsSuwkfxm4c5L93SU1/eXrdmfVBuYmeNHk1F1nxZhXgH8QwjJ1SQmomEGSgrWlN3sQ1VUSEekYNd6oew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5v/XZQnB9caZU2S6staWi/rviO2O4MakhQh40oHdlM=;
 b=B37T2zwjY2OczqDg56XduoAccck9dlvGypf+pVBdBg3riWdlSYFMjsH1CTNQSPyhVzQmwkVKxmJsjB+Q8NCya6twZJgBsC4q2eAl/vmHbLafj2ZhyRI3iOLln/cYE/efnUj2q0bL/lScjYf56/dnnBbRmE0iGo+QA6hpZCoibzUOR5QefV7o5HJT0g3PlmDbHiSns4LEbSJRLOB9MF93KX9+MacOOQ1Q4EZBIUXeqpY9pEZm601iNaxO6ybv6M/W8L+5jcIe8AGkekt7YQNF9s1ICiPaXnIqQJLXDCYSLfMHrTPz+phXnLkV/jhH2g5eU0Zhjbu6/IBVC2JRwq7trQ==
Received: from PH8PR12MB6794.namprd12.prod.outlook.com (2603:10b6:510:1c5::17)
 by DM4PR12MB7552.namprd12.prod.outlook.com (2603:10b6:8:10c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 07:59:31 +0000
Received: from PH8PR12MB6794.namprd12.prod.outlook.com
 ([fe80::352:dc8:9323:52cc]) by PH8PR12MB6794.namprd12.prod.outlook.com
 ([fe80::352:dc8:9323:52cc%4]) with mapi id 15.20.9542.009; Fri, 23 Jan 2026
 07:59:30 +0000
From: Parav Pandit <parav@nvidia.com>
To: Zeng Chi <zeng_chi911@163.com>, Saeed Mahameed <saeedm@nvidia.com>,
	"leon@kernel.org" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark
 Bloch <mbloch@nvidia.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Adithya Jayachandran
	<ajayachandra@nvidia.com>, Feng Liu <feliu@nvidia.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Zeng Chi
	<zengchi@kylinos.cn>
Subject: RE: [PATCH v2 net] net/mlx5: Fix return type mismatch in
 mlx5_esw_vport_vhca_id()
Thread-Topic: [PATCH v2 net] net/mlx5: Fix return type mismatch in
 mlx5_esw_vport_vhca_id()
Thread-Index: AQHcjDqk0wz5Gzwt+Ey/ldjrZFMyRbVfYZ3g
Date: Fri, 23 Jan 2026 07:59:30 +0000
Message-ID:
 <PH8PR12MB67943547985BE91058175ACDDC94A@PH8PR12MB6794.namprd12.prod.outlook.com>
References: <20260123073313.3786415-1-zeng_chi911@163.com>
In-Reply-To: <20260123073313.3786415-1-zeng_chi911@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB6794:EE_|DM4PR12MB7552:EE_
x-ms-office365-filtering-correlation-id: 0e634b8a-7735-4947-e878-08de5a5556d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GiDAxZbZP2GQeOG+xHP61oHRN396wB1HQ2FnpWn9PCJrK0t/UK6sevUjajBv?=
 =?us-ascii?Q?gqTA/D/H9mjzZ4JUzxImqx9b2iQc3UhaOgapUuJ4DJytmWk2va6JNcXJsX1Z?=
 =?us-ascii?Q?b6zQsWiO1Acu/ioAIur7m5j4jTLuJMHb2OfjhGE5aT5joZEOrLyzGIhOF/+d?=
 =?us-ascii?Q?s8Z53lTv6fteX+4usWwgdpB7C1tC09pO6kTnaxKM6Muyd3+Ix2u8WOAdURIV?=
 =?us-ascii?Q?lxfThfk+ZKusSuXKgWl9QuwS2lS8P6NpV+NhI8JUlan5SsJ+NA483vUlpqrX?=
 =?us-ascii?Q?rVWPbsBa/jbdGumXcAgGr+7EbYhKq7CdReOsnI51mhAWKFb7vHvIMX8gYhku?=
 =?us-ascii?Q?zuDaYWl2dcxJ5wKusZI57zI18eq2xCkX2uXN1XKojMAR6ct2+JT+p7NOLQB6?=
 =?us-ascii?Q?c9Fn/NrVdnuyQ3MjQaiwfe0rdWUSF4DMxnnqcL0HoRgxALm0CskoGiKy9Zwl?=
 =?us-ascii?Q?s2hp2L2KHgBjnA4kTRxkVf0cCOCuPaDZHae3itS6ldUGo3xV1PF10AN5JGzS?=
 =?us-ascii?Q?foh2gTD4kkZ1fneN68mNlxSgb6n6wgHMOsTFfTIW7RkbZ2GoLJpzLv4hQToB?=
 =?us-ascii?Q?+UPCY66Y7Guo98gPCQRxhpaYDZc+suAILhABfjgfQSXduu0+Nz4sxgq+3qP1?=
 =?us-ascii?Q?GtmbD0azHekiAJKXszVg7GI90AM+7YLeeNPegWrZ5TSHwlugmWw6KKpwtvhr?=
 =?us-ascii?Q?o5pPRm2QDhxu+adEZ5aNJIhJccDjA/77X9Tt8CipltPUMK0IhiU1uHQNxand?=
 =?us-ascii?Q?tfCk6JgjHVDtoEzdiWjXH4dLjp5U/vV5u1peE1mtgwAw0omWQlYuu6HPuOUQ?=
 =?us-ascii?Q?pHFyJeSKn1zAEJsY/r69NF4XNSmqvqbesr9E2bpfpW/4HYZxML//tYgXSzcj?=
 =?us-ascii?Q?L6DQOEPzjfMgTii8Q8Pg9GyZcWY9VJ0ew+d+qkDjKxzNnf2D/jS5/GJwJBc3?=
 =?us-ascii?Q?IT4L/ov6b31EXU4eU8om5Qh+W/I9paZxSdXkOswcy/f5p7CielFq67fDlJ9N?=
 =?us-ascii?Q?P9whokiOlCGSm+kS9ilzPdUYFpsuKJ4oQpO/brOq4rV0HmpaSPlA8l6iiYaz?=
 =?us-ascii?Q?OEKXtdPDuDZEkSQ6uOvvgin6uNg4f+7XQSl2G+LREHffQEvw15EshGpE1I+R?=
 =?us-ascii?Q?6Ubx27Oe9ZqrdbVYbPkdOeWjMTY7VGgnc0m7HVLwWewIQ2Cz31Y9jR2B/EWe?=
 =?us-ascii?Q?30sOwaXNLwim4onUdheDxHAR49aYbNNe6M5yR3OE1owfntEZDWt6ISuBJGSW?=
 =?us-ascii?Q?6n4sYDPuAqDw55HO1nf6eXRwDADgZk3c6ZZqKI83sGDWH4S9pdO3iTC1IcEG?=
 =?us-ascii?Q?zRD0jbEKCNT//qPe5QeC8B7WX6E3sb7rbh9Nl1laNFD7WWJm1jULvT/LWgP3?=
 =?us-ascii?Q?p90NfBDid93K+qNzu+fHyKDPIE40ljoFu5+TXgAYuVFlzJu0orhx+G5xJW/Y?=
 =?us-ascii?Q?H82JcR+CLRI10dr9PfBkCRINIxpLmKs5q/Etr4YM5pQxyNSLdFE8FtrGoNzo?=
 =?us-ascii?Q?+29s4KK1pWCJPS8IIG5ms4Yd6Wzuy+I3A6RqwxmD86GVHa46ZAEgHz45XKpH?=
 =?us-ascii?Q?8ExnE0H7+hlfAxjrBatzp0ck/3/sAFePHQjreTwJqwpiY8PzQnsHq3byiyDA?=
 =?us-ascii?Q?dqvjb3zayS+sAVOnYKoUTbjxJxBqLWmTSmUW+hGfjLlp?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6794.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?U/WZXrAJSlodc35lRCaaVMxqDrey+LtqLkSIuJd5BYAtmkyBSAgRFWRYCjeP?=
 =?us-ascii?Q?ScHVu6f4Kt85HzekaT0vgmhlfiIUeP8NgQAyv4150bu7MaZTk14Ou1LkDkja?=
 =?us-ascii?Q?Ar0jes9hE4KvYIJ0OfHneVd21mYwFYGSm6xWw9LBMxaF3XPPtEtPqIeWaN/s?=
 =?us-ascii?Q?jiNzTHYc9U60YJJeC74YZE4Pf00IYuT/MnLX0Jt3gNGQd25DmSs4eN6qLnCt?=
 =?us-ascii?Q?ktDL7LMSspLHyMFmPQM/58rN00DidhQL6lDd3XEDtC7rd1YpfOWMgM2oRUpe?=
 =?us-ascii?Q?gBTRVUg8eOylfHjXcKm1olXwZ5qgAa22cS5rWmKP6oG+7w280icSS6/K4ui0?=
 =?us-ascii?Q?06rsp66J/SVXiYtqCmfZcjhYS5nxFNIsm45J5nrqEAsfB3LsNwU9GT6xRUMr?=
 =?us-ascii?Q?YDTZmdoD2tdxR0uUG0BCA2uiq4wxhbp4V999FePtDbwn6hLaupyQotku7pA6?=
 =?us-ascii?Q?QQTNNmRXYWB9Jz72cS7F5ZMA3YNBHFaW8WJW8JV+ryL+zvZYcr4TlDnYfanG?=
 =?us-ascii?Q?XD8YnYtOi+Q+bXWXevKUH0yf1DrqWwNfv9cKatCeKCB3t5p/JNs3EbYeFkeR?=
 =?us-ascii?Q?Ar0DoVor0ZboZ6yNqmUZwGtqKOTra13jNgLafiW28AGNne/uLuzdplcxOFlV?=
 =?us-ascii?Q?wWKRluf0VXJ8Z9w1/GuGVVLD9bWEQlccpfvmfv7rbgAJ6nHqfeDdQSEx7QI5?=
 =?us-ascii?Q?Jnur7uiuPUTIQ3bgxkLZdNWQ3chkPQnnuL6AAFBkPZ3zSCVpZVBXXVSTaRJr?=
 =?us-ascii?Q?z4SCCOx2P/EDqFhTefmyYbFEo2TY7O1JJhXDD0Jls07siSVXN+nhuwhVFCoJ?=
 =?us-ascii?Q?Wai9Kg6u/WxGQei6EhY7ovH+dkFApKvyp5xbMH483IwrCZqGHZHmFX3XUDWO?=
 =?us-ascii?Q?QF7b9QGi2ukodPiJACRVf45whznuwpN7wg900h4PnTa0tWyGnQ+tzqdJWWEI?=
 =?us-ascii?Q?GeuauQTBrCCEKCIWhmKBj7AK08BYjKtNLpqd54bD8vF4BOgH80E5rBDWgNFm?=
 =?us-ascii?Q?8ufSsl2DnxTDRBS0imzlx8KQdZY76Xdaarq9g1g1RhGKntBf9N4wH/Mc9ie8?=
 =?us-ascii?Q?NQ8LypaPx/GX03n6r22SHBbQg/4D4zbcybjURdnd+7nO+PO8wi94UaPPoHyu?=
 =?us-ascii?Q?WomNrJGStixjoCuW0/zQo94Mb1wth59oJ21YJxb8WXeXA5zaSRNwM/daP22F?=
 =?us-ascii?Q?4reBjR/3uH2mKJPX6G38SL2e6ymrVlQZblv2+PnNM5vAtjgaD9kA3ksiheDk?=
 =?us-ascii?Q?3yOo18aTa+IlY4DFucFaVh/U8cJ3Z6lcjNJ21P4J4RNKkMIIEXjR0ZgGX1Fb?=
 =?us-ascii?Q?1Xt03xvOy1aVwXDW74SNgxy59wDyzz9fDEy0InRdd4Patisy/qqL+ebPw8OM?=
 =?us-ascii?Q?Arl/qlMhoSfvXLZDAFpr59EG6DTUVWyYBiq3g9Fw05ayKKvM0gRTtQsw0NTY?=
 =?us-ascii?Q?ddWkvef55p/5DbN/c/4SAK87N1p/7GtUaA0hG5Cbo27N9bSaizH1RTCFzJZg?=
 =?us-ascii?Q?s1tfOMh/BnLxiSe5hWserm1p3jg0mxWH2HwkYXyjoeAiX5J4hC/ROU85CuOi?=
 =?us-ascii?Q?vb580eXKEOO+afR38qXYOHntUjiDT1lqVkp/yoL6iQHtraEdvoRQ1hXgo14R?=
 =?us-ascii?Q?gAWoyTYY4yuOXE6Xxzj2rAbJVnGDDdh/Lrn482xICpuSZ6cHIrUZrHiJ/nPW?=
 =?us-ascii?Q?9dnsXVHzQsSmQBDUcUbMjasrNxK8lzoQ7eSFJ2Nti3h63Sec?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e634b8a-7735-4947-e878-08de5a5556d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 07:59:30.8834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dphpw43/XWSSqJjqiZsFTIQbKjuxr9KBvR3Ku8yvWnZnGhaeELTOTS6Z8abASTWVjrvklus0S2eocj+/IQgjiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7552
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15915-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[163.com,nvidia.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[parav@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[PH8PR12MB6794.namprd12.prod.outlook.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 3154E72235
X-Rspamd-Action: no action


> From: Zeng Chi <zeng_chi911@163.com>
> Sent: 23 January 2026 01:03 PM
>=20
> From: Zeng Chi <zengchi@kylinos.cn>
>=20
> The function mlx5_esw_vport_vhca_id() is declared to return bool,
> but returns -EOPNOTSUPP (-45), which is an int error code. This
> causes a signedness bug as reported by smatch.
>=20
> This patch fixes this smatch report:
> drivers/net/ethernet/mellanox/mlx5/core/eswitch.h:981 mlx5_esw_vport_vhca=
_id()
> warn: signedness bug returning '(-45)'
>=20
> Fixes: 1baf30426553e ("net/mlx5: E-Switch, Set/Query hca cap via vhca id"=
)
Even though kernel documentation [1] allows more than 12 letters in the tag=
, the common practice is to have 12 letters of the commit id.
Better to have 12 letters.

[1] https://docs.kernel.org/process/submitting-patches.html#describe-your-c=
hanges

> Signed-off-by: Zeng Chi <zengchi@kylinos.cn>
> ---
> v2:Added the required Fixes tag and specified target branch net in subjec=
t prefix
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/eswitch.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/=
net/ethernet/mellanox/mlx5/core/eswitch.h
> index ad1073f7b79f..e7fe43799b23 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> @@ -1009,7 +1009,7 @@ mlx5_esw_host_functions_enabled(const struct mlx5_c=
ore_dev *dev)
>  static inline bool
>  mlx5_esw_vport_vhca_id(struct mlx5_eswitch *esw, u16 vportn, u16 *vhca_i=
d)
>  {
> -	return -EOPNOTSUPP;
> +	return false;
>  }
>=20
>  #endif /* CONFIG_MLX5_ESWITCH */
> --
> 2.25.1

Reviewed-by: Parav Pandit <parav@nvidia.com>


