Return-Path: <linux-rdma+bounces-20055-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDI7C4Tp+mlIUAMAu9opvQ
	(envelope-from <linux-rdma+bounces-20055-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 09:11:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 908724D70A0
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 09:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79464302AF14
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 07:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF34936E498;
	Wed,  6 May 2026 07:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ntu.edu.sg header.i=@ntu.edu.sg header.b="D/ANbBkp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013036.outbound.protection.outlook.com [52.101.127.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897B936DA0D;
	Wed,  6 May 2026 07:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778051452; cv=fail; b=KMlp8aFjZIEECsEapgUS9mvILKhfXMa/MEB3TJNZSMW8ldij5zW4Shi3JsHEVxHo+2IRUkLUVkgVYLsv0LSbLmNk9zBojwc3+3IbppJsuuEovAEZJt/NkGIGoYOC2CwUP8y7AbDgRIKC8tYj43hmjdHNUZ6Bpey1uibF0X96PYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778051452; c=relaxed/simple;
	bh=mxQC6m9q5YTbH1rJhlVRLgPr3gc8AL27RxoRQtlMdi0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Htc8TVwYsK5VCMjjK23GiC1EMWW4KmemriSy4AteBDwMJJ2WYjt4ksmnIeD7fo/B36lCV7OoDPSY9rYUJMdXOPy1qRGNcAX4fTu7OGXdc2zbVGFBrXgbKo+H+J0yO9r9jaRhNaBnON+H8ivImnBLT8anerNIWu/LFJOpz9Hng4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ntu.edu.sg; spf=pass smtp.mailfrom=ntu.edu.sg; dkim=pass (2048-bit key) header.d=ntu.edu.sg header.i=@ntu.edu.sg header.b=D/ANbBkp; arc=fail smtp.client-ip=52.101.127.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ntu.edu.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ntu.edu.sg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b50z987M7w6Ypggx/GyFV2ajuJoJyUxUwhcirPb6P0+pOB5wKd751QV1N62av9GEFxUsLYKiat+kGMvv5RzFzOauU3fAJ3p1xI/Sju9bzQsj+2vlWVOrnAhxfbDsgEp+wqruC7n9PkpAkpWEDiEq03iyZPXnGoyeAfEeyqmm2ECFrPNjsCyxrp9I7cfJHs3pyemuUxucDPhpzqWupV24Tv4kY5pkhk2wWDdx02+5o21rcSwL6ACh0b20zJdG5sbv4AUnatLfE6czBEdR7b1MMX577KXgsqLV41HnlOHjXN0kpzuLeyD01HON+XxdvKf0CBXDaFcTQjzRnWlKhXNFng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIs9gerk/MjduIN/eh/+DBbnWpzlY00tLB7L8d27yGk=;
 b=EEjn9XeLTIyCbMnTc/FPWJiaLmZCFNWx1Pugn7fDWSvZzKjEZjcSD+uuXhEhLEK/P47JVgaZbsokWylryh2OcbsuxIVPQoFv3vfwp7ZO95vcNNumgqn1PAemmPMrP00FHqVxswTFBnyjO9PPMewpY6Pny785cUR0QTFIWVpvMMm0cEOj6lsRsemsQosxbz69Zp+vocQJyXpkeeYS/E2zqRw3/cH3mhFXUG6N7JRxfxrfAwsTZuV4BggkHtof92ioQLxrN5PcDxIzB/0J92/dFSOptE+vnsj6Aro+Kw9xJIHvkxfmJ19qBQ1KLv6SR63XrsvYnzeRlVbP96Yx+I0pMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ntu.edu.sg; dmarc=pass action=none header.from=ntu.edu.sg;
 dkim=pass header.d=ntu.edu.sg; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ntu.edu.sg;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIs9gerk/MjduIN/eh/+DBbnWpzlY00tLB7L8d27yGk=;
 b=D/ANbBkp3rTnr6jKSWmYUckGUEop5CfJ6RuUw0AEFy0XO4Xrea/lzizs+8Hsa1+I3FNF1A1WZt0ypMLxOeqayLz6paSRl5EcdkEiIjrXEE1QgNX6wFKiDvtigCZD6SpHMIwpCRc0UQdKhYUmOm38FZE4UQ2XDNzmU5xKKDzmL38xzLoqbjSo4SOAIvumshywu/oCugaGWrAhcIGogGreJulvMUoBh/Blsw0eUByK1b5e48ncmWFbcmbZ0KPXEMDR7ZC/xxeQsKHN3ERk3YbY6IuHJpvmSJCzqHfTuWiTYYrpZDRXxM5/FPy6IbIceEYfHLNdxW0kohwLaH0xb9dOVw==
Received: from TYZPR01MB6758.apcprd01.prod.exchangelabs.com
 (2603:1096:405:a2::6) by SEZPR01MB6107.apcprd01.prod.exchangelabs.com
 (2603:1096:101:21f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 07:10:43 +0000
Received: from TYZPR01MB6758.apcprd01.prod.exchangelabs.com
 ([fe80::bbb1:1ecd:fe69:9743]) by TYZPR01MB6758.apcprd01.prod.exchangelabs.com
 ([fe80::bbb1:1ecd:fe69:9743%4]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 07:10:43 +0000
From: Xie Maoyi <maoyi.xie@ntu.edu.sg>
To: Allison Henderson <achender@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>
Subject: Re: rds: possible cross netns leak via RDS_INFO_* getsockopt
Thread-Topic: rds: possible cross netns leak via RDS_INFO_* getsockopt
Thread-Index: AQHc3GmNFjglT8RFCkaEpGWQP2W0QbX//mWAgACXNTc=
Date: Wed, 6 May 2026 07:10:43 +0000
Message-ID:
 <TYZPR01MB6758F66A06980DCE70C7F75CDC3F2@TYZPR01MB6758.apcprd01.prod.exchangelabs.com>
References:
 <TYZPR01MB6758F43459242F22946A8192DC3E2@TYZPR01MB6758.apcprd01.prod.exchangelabs.com>
 <2962d0cbd5313ab482ece5543bafa0d2f0c32cc3.camel@kernel.org>
In-Reply-To: <2962d0cbd5313ab482ece5543bafa0d2f0c32cc3.camel@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ntu.edu.sg;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR01MB6758:EE_|SEZPR01MB6107:EE_
x-ms-office365-filtering-correlation-id: e8b568c7-9964-4ea6-a48d-08deab3e969d
x-o365: NTU-OFF365
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|786006|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 tm2him3B0GNzkzk4JJt8SECgnEsF8PUALMY7KYFHBbQMdG95Jqrh4819x+RI+e1aAsicbyzgrB9nN/54kFVfONa1x5LDyejOUhQiuL4GNA6KPUwcb6k+r9e8LDA29tIrtmx32EjK0B8Aq79l8U/Uj2QA60Jqm04FADZeAqYWLoou3OEmGxa+fLMLE1ctgdYcF0gvmFTXImNUiD8DPpinOHOE0wsRO6+mXjPFxr4bA+PypnRo4S3mF92SekabvX71bZZzrzYYzHl7D5DEAn/TJzpDZNRoDwVr5JmgkhozU9wkMZZKn0CU1Ejz/lObnv+ylbJpeRgOKt3ZWPstBVhqpC+ZkeJGvjSaBiNBktth57YYUtIgdtk31iAHh62ecLvOk2BYhV687PmnD/R8UoC1k4hcJnMsx5rI3LlPoOnKJvuTi1BXPLYop7+fugvdceSCQTFx70OaZDgrKE7Zppfx/Ja7+QE0WZcUL5k/uoMek9FmfrU5Jom7ou7LzUcA9g3ucMF3+TeS8Chkh3zmO7EJm/EPaKFfB72I9MYnWLRctav1ALvYl0PLge/efQ3+7vDYxb8BS9ODbpAw6URdBfxKaf3K3Wt+jwxm98aabSCqna+KJ9QBJhJhdNAatByZ+2HB23BaDK+bYwJ0rtdpB9WKdg4dl4YTg765ccQTPCkg8X/o2saZ7NRAGOEJPx+W/vax
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR01MB6758.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(786006)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?WcGVIE/gIypcu0Sd+hjRug32y4+IQELY4m8YI0AJm8sCN1Jv7eVDr7fJOY?=
 =?iso-8859-1?Q?niCfCL6wul7RvPBZYgUbNQOh0qSpD5SZvzIc66lV3KSTkVHDsbuEscB7K7?=
 =?iso-8859-1?Q?cAlXxtj1FCpsDorlLVyw+AvWZr1mkn/tyK0Cij40twV2BOc6MlBLOV2/oE?=
 =?iso-8859-1?Q?Mw3QMThk7/Db+Ummr8we7Zq11B58uk5tIOi2K1HutaXIinj+TcQ7/YcYFD?=
 =?iso-8859-1?Q?Sc9HRDj4eW8QYlreaNVVaj/N1vDlcHpvsTLciruPwGmjHnozZ+2EDjE65c?=
 =?iso-8859-1?Q?+LqavSC9JcqD3oWtdGCNt5WQ9Bl9WP7kRDpm1RQ5zf4tlVPp0VnjaRB2HR?=
 =?iso-8859-1?Q?2GwwAfs5LoyIxzFn5+edRzwjwhFqBXvoIrmzNYukSnBN5k7ydK0HOo07z+?=
 =?iso-8859-1?Q?TYnH5J5auLpwP+vHuEsvB2G1dnaBWhJ7ee+uetRUjRi7ppZex/mtxI8Mk7?=
 =?iso-8859-1?Q?r5Fr7vfGER8F0ES+WKI2erF4a6nC+0DbdpNlzywWHGQe4lfMvGM5bmY+sq?=
 =?iso-8859-1?Q?nXyd4msicOenaWmylbLcL8UDAmUn9TkrSyMh2VJwMy6Ey/G3YB/EygxP97?=
 =?iso-8859-1?Q?bTeTCq/edficejixmNGCsXy+YY2xWUeYsrP0nyhlPLCFKf8/L8Ns5291JP?=
 =?iso-8859-1?Q?v/UYlTCYdUYXMIZi0v+dwspPgmcqLxq9SozL3ufQHhWLSm/SQc8l1B4VS1?=
 =?iso-8859-1?Q?92rRS9ZpDSbD1LpE04AcUaluReaFqriZl85q9jMEpTLoYRsVqulDJpv5ye?=
 =?iso-8859-1?Q?JtrUQLsOYu/wcHwZsX4dFwLdLVAlb6ZLi+zDHd+Nan9GJuJSJ3dNZrr/iI?=
 =?iso-8859-1?Q?OTGkX5lEyEDtkX3dNZ6qX/u2+s/t4O+4n73qwUCa4WhlYfa7Kuw2SY/oBc?=
 =?iso-8859-1?Q?HhT5mk8B8iFyajISY2dz4AHY8Vw7nxZx/DGNG8Zro5r9W69CFcETvPzYjb?=
 =?iso-8859-1?Q?47UnE3fSyWbDmp9auAfGs//4pPJtD4JTyjfTOJFoC+wE5iRlZiDQUDRiVX?=
 =?iso-8859-1?Q?LmFMRRGYSMq8xP8BBXOBNb+vc5WJ5JST16gh/cDU29uplpgvdZIqGf04ac?=
 =?iso-8859-1?Q?maZ2RNpPx5RP0C54cBQ9Es4ewcxj6unPgC8QqTjgOqI+38yv6G46PNpkpz?=
 =?iso-8859-1?Q?Fxqxy7MMHNM9zDrBfJr9w4p3QYfzZVnl2KCd1sj9OHy1kGFGRWEZuKEyY1?=
 =?iso-8859-1?Q?8/jmBbPJtX4O1E0EUEJBdYg6AzKxnEAQ72fEEOv6/8LVGXguQWYZzOCgHC?=
 =?iso-8859-1?Q?i6FdKDlTt0J7L6kgP/38m8o8wfOP2dqQb1hQE92W8IFsol93HwDF6mb6bC?=
 =?iso-8859-1?Q?LpIEf1pqZI36eoGpCJEyhgkS4ydUq6LG/Y+QOPQKz4SA5QS3LC4BrJf5sj?=
 =?iso-8859-1?Q?dPjcO98KwCmqP8u+89ARzZgxbclaBhPujiy4q3ALcPGdUL3CLGtx1A2ozU?=
 =?iso-8859-1?Q?5U9mfd7De19h0w7VXYnZfCx3u8Jn/sAhwUNrnjoexNyfrDuE9WDtmx+oUB?=
 =?iso-8859-1?Q?weyXcW5+vyWaww+M+0Z/BSEpMEAxYAa1MMxBqn5UFQiZrrVDo7McmpIaEr?=
 =?iso-8859-1?Q?v5/Ffc1d5T/LnLXiK0LoScz8DgnMd1Ar50zE/9hCj+WrBwV2vYwzj4DVWo?=
 =?iso-8859-1?Q?L5biCe2pWLhNQ3/myWv3bSxKxNuvNOh8pqfelNtntU1I9B0foevQ9AHudF?=
 =?iso-8859-1?Q?j48vEd/x5zt94quMA1D+cRQqRymGaCyfYWGVHq3qLpxY4zkUoSuhw8y5Tm?=
 =?iso-8859-1?Q?ipE6idF6xFQll5PZXj9GlvFSYoowIDHDbK/MHKKlhL2Ue0GDJBuC1PwMbg?=
 =?iso-8859-1?Q?KEu15dZzwuqfQzmKR+oc5UUQ3YgMb3U=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ntu.edu.sg
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB6758.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b568c7-9964-4ea6-a48d-08deab3e969d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 07:10:43.5951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 15ce9348-be2a-462b-8fc0-e1765a9b204a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZEVnSAR433LCqFNSDTMcyEzHUvodEzeW+q/sO1wINDICeYd/2xoIEB11YgbQeWopy3Kh0vn+r3hE9brEIOpsAxOkwgGU93BOCZwICgfNetY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB6107
X-Rspamd-Queue-Id: 908724D70A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ntu.edu.sg,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ntu.edu.sg:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20055-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ntu.edu.sg:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyi.xie@ntu.edu.sg,linux-rdma@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ntu.edu.sg:dkim,maoyixie.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hi Allison,

Thanks for confirming the direction.

We will rewrite the patch as a per entry netns filter in each
of the affected handlers, instead of the init_net gate in
rds_info_getsockopt() that we mentioned. Concretely:

  rds_sock_info / rds6_sock_info: skip rds_sock_list entries
    whose socket netns does not match the caller's netns.
  rds_tcp_tc_info / rds6_tcp_tc_info: skip rds_tcp_tc_list
    entries the same way.
  rds_conn_info / rds6_conn_info and the *_message_info_*
    variants: skip rds_conn_hash[] entries whose c_net does
    not match the caller's netns.

This preserves the rds-tcp behaviour where a caller outside
init_net with legitimate connections in their own netns can
still see them.

We will send the patch as a separate reply once it is ready
and verified against the same PoC.

Thanks,

Maoyi Xie and Praveen Kakkolangara

Maoyi Xie
Nanyang Technological University
https://maoyixie.com/
________________________________

CONFIDENTIALITY: This email is intended solely for the person(s) named and =
may be confidential and/or privileged. If you are not the intended recipien=
t, please delete it, notify us and do not copy, use, or disclose its conten=
ts.
Towards a sustainable earth: Print only when necessary. Thank you.

