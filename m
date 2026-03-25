Return-Path: <linux-rdma+bounces-18618-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDOxEr78w2lXvQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18618-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:18:22 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B107E327BA7
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D63263263A06
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 15:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19863F0750;
	Wed, 25 Mar 2026 14:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YeA/Llzy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020073.outbound.protection.outlook.com [52.101.61.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A33D3E92A6;
	Wed, 25 Mar 2026 14:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450613; cv=fail; b=iz2tVWquMbTePMqPbW2G1a2rGOgUN4Xa/MSXykuVIqiU5Nd6I/hBVubSZep6ZjQw9Qv5s5w8BBZtPdechjOf4MnOTOrMiQXOKtMCsJBvvZ4ZkckNNmj88B5NEIFdOPqcR6JrDAHIcyqU9q1lfpBMBQbuZviVDSJT57OzA/ZT1po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450613; c=relaxed/simple;
	bh=IAgie2g4SVprCrKtW9eTxSeFeFR7jnUhq0kyBJU7kjc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OdSH+shfXl6j4cZFLayGN37gz9NVlWFYwGOah/RsecdNkCFaJqTrUottYde+IiN/4MLEA5n3Wg2fT9gq55Qf38KbsCCxOlW1wrcRwSblO/Ui8QR38Z7318cMhH8dJSfZrVLiPdlpIqt7mVhyA6/PdhMb7+E72nn014cdV9kWB9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=YeA/Llzy; arc=fail smtp.client-ip=52.101.61.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HV+rOCVfyeFF5VDekpoXRG4VdYjNb3vk82xO9DXlY3j10E88Gw/Xa7FjmuC7PPfoUeQ0asOs1YLLahEkW8dOQt5hVlAXQj4SfiyDDxNoczLh6s730hSMztvIesRkt0GOEMAQAOijUHoJ8waidUaIvZ2rYTUFKuoeVh27b8v+PEvJdhztyz6s+A7qmX3cLYCo1aEyEOEPBmuE3xeIXMRSQ7zyWGAdMCkyre4fyhZQm/hGo8DMqwPL/yaZrICvT1O5IN+ph90ZwZt2khHWfXv3fjIPzRkO515gckh/z5QLOITpC7rlFZ/+ka7w/lghorv5xAj8sbizrlZTq/FasyxGoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/weiCl7tlvRk+vzNTQcDrt1cbmSGscuSDcHo3hn8/Y=;
 b=CtNiqIpC68aI88In/YLhgmO0zahS2TpI2LaZZyBGYxpgBCzJXNaaPHNMTnujMvGLL2tbRhYqNePyw8C5DrKNkgeaoZw4Odn5Goonk40ptCb4GH2BziGSCoptCcDracpavzfJu8F6d98Dj1lPXhM0+d6orWea7BkEYjudok+Q/PLKL9l43s9NEhsQWPi/pH4Qkda1OM/WDpv5XgL1XYIZ80ei7kMEnC47GK3X4HywtcNtTmSBOE96rdCCrecEq1Rm1ysFdAg8Q/MFLHMhUq+ADq32S++g9EOhVs8oEU9IQC923H3wVTaVVebMyuPIXppMjt8yUbkBz9J+E0S85nE7qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/weiCl7tlvRk+vzNTQcDrt1cbmSGscuSDcHo3hn8/Y=;
 b=YeA/LlzynJt67Z9zQ26bb6a8Fd/4Dd8dOet5dRm3Bz5/jNgLJiJKgL6YQ7Ng8PBw+kpN/gk8jo117DghsxUXWJyB2PYIirP4jMajbLal29XDKHRldXU2xqMP3uU9RPYEhj3ZAUAsamZgfdofHPK4BC5XoZTFV2RMeMmjEqmvm+k=
Received: from LV0PR21MB6596.namprd21.prod.outlook.com (2603:10b6:408:336::24)
 by LV2PR21MB3396.namprd21.prod.outlook.com (2603:10b6:408:14e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Wed, 25 Mar
 2026 14:56:49 +0000
Received: from LV0PR21MB6596.namprd21.prod.outlook.com
 ([fe80::c93f:22eb:ff2a:202]) by LV0PR21MB6596.namprd21.prod.outlook.com
 ([fe80::c93f:22eb:ff2a:202%4]) with mapi id 15.20.9745.012; Wed, 25 Mar 2026
 14:56:49 +0000
From: Shiraz Saleem <shirazsaleem@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>
CC: Konstantin Taranov <kotaranov@microsoft.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, Haiyang Zhang <haiyangz@microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, "edumazet@google.com" <edumazet@google.com>,
	"davem@davemloft.net" <davem@davemloft.net>, Dexuan Cui
	<DECUI@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Long Li
	<longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH net v2] net/mana: Fix auxiliary device
 double-delete race
Thread-Topic: [EXTERNAL] Re: [PATCH net v2] net/mana: Fix auxiliary device
 double-delete race
Thread-Index: AQHcthvn6AW0lOy2I0OccbeOqa4gpbW1CXQAgApTAhA=
Date: Wed, 25 Mar 2026 14:56:48 +0000
Message-ID:
 <LV0PR21MB65961074C13EC8D590FBDEFFC949A@LV0PR21MB6596.namprd21.prod.outlook.com>
References: <20260317143943.1329271-1-kotaranov@linux.microsoft.com>
 <20260318175344.7ed206d7@kernel.org>
In-Reply-To: <20260318175344.7ed206d7@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=cd70563a-cb93-41ab-b53c-c23190af3c88;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-25T14:33:25Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR21MB6596:EE_|LV2PR21MB3396:EE_
x-ms-office365-filtering-correlation-id: 6dd30f16-eb65-4f25-6962-08de8a7ebded
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 HRUOtDR5Do6U1GFEPdZjM3SShPv+RelCJf621do4IR3iZUPXExDmU/eu0+SN+mCmK1Nt8femaT+O62/tQJdkrgKdqEek2+JPo7hdIVDuifkHJ+g79g7hJGzs8MukRrd+l1w/dwB/j9VIIMH/ZgMTzHBeqpINpBQPtYqqDnasoWz8qQYEf6xzmmUwuXRHnfRFuh1IwdHQo/2nnWRPKK/chQw9iLKGn5vJHYnhiLvxSpD2a3H9+dauLCodyNkzH79i5ZyOFiTu132UZMrOTzUobdeHvPD8kATiX/zweHUQ4Nmrv4xJZ/0prcywoGEJsxtAfu5OW8mugRmUShrFwPvFQ7hNZFgpdOoTlnQxcp/lu5CbGqEcHlnQkpOAQBM9006Rg4h6p3OVIp1sxP1zRD11kLCb6ecUv/ohQliGgx1uU/IsBVeP5mumC90z3lIPK5TwCA8ZjebBbKSi46s1ASv9Hi8vZ3FTfyyqyk7wCDVKM86uzYKt7LcEF5UEuDWzCuYKGq4zXKBbOmheicszfzyvRqOMN7rWCzMnNWy0fgAM4OnFKZVaLLl3ugrSVXdmORSIaiVyOlS1RuTKI9AUgrJCVrcpwcsGr5yUb7WUUzGTO1GOwmUcYgHs44N+VQUb7MwwbohKbvHYm5GQWtlmPcUb2iiEwkTE8061IKvCmLOq1l//TlDfqxZusk0lnvWBcbxKXdJyAGrGcZCSHPY/A5nrBPiADqSPWRjOFYd9qjVz69assBjvXFRDH3UGT0TSR01xo8TchyokX2yr4OZbhAs0n7VfnnDhfWvkQu7ZcMDZ2Lw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR21MB6596.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BAcFORNntr/VB3eMfTrYiju18EQt/AjfKEb78YirPnRqv+zrY59YbANySuYE?=
 =?us-ascii?Q?95T5FOh2xR3taS7pVZBOWqWtGm6bk4UszhJAzihVI76mtWh03w0lhxm0UYbi?=
 =?us-ascii?Q?JAobEcJbarYZoECeYNEIkDUxdgWrzJT2juqOa19Bo35CNaNggIPMDS+VG5oh?=
 =?us-ascii?Q?k672n8HZ4Xy1hLqbxZi7Gl1Kyj2eKgc6v3ekZRJbEBM2FY1JL5XqkoiDjANM?=
 =?us-ascii?Q?qqPk033kkeXUGW3aVgmNI4p1hf4F9S5TJsUwf63wnw/1uF3QeOOPE4rR9bTh?=
 =?us-ascii?Q?FaO69DWGGGhq4V12BqfJTU9Gbj5F3w1qC1JVn/K5xhq9tOfxrVrK3CeINKu7?=
 =?us-ascii?Q?2cQP5zccuTrtYAR53AF0PtFmrtlwi5jLWmecjFkqIDMuI5DwWJutavysR/W9?=
 =?us-ascii?Q?BI2JUXiIZbIogBPPI0M5ISLOvbfL9SCxp7EkhhpO3U7/rpsHC7Jo3c5bhu7G?=
 =?us-ascii?Q?nHeA2Lml0oNjiFCSu7gmLpnUftFa1znrxHAMGx7rsgUZVawpd2is5bAet/Tn?=
 =?us-ascii?Q?ow9oTWCZkfevFw6dkHsXHSuColx8Br1gNy7V7Y0SkDDTOi4E9BdCjI5ts+1J?=
 =?us-ascii?Q?gk3tkkmlSIRHg66hsOAUPLkij++2XwmvNpiGVfbiN7+E39CbQQ8ybXLIp7RC?=
 =?us-ascii?Q?4G/wmSWB7U1qQeSIAHzB8KR2AktPZ1Vj0+JdVjlbFFloxgaNlnjHAXaSOv//?=
 =?us-ascii?Q?Mv2m6wS+l8rRGpx8l81xcLA9cxwmSB8MmyQQFgwDRQ4oKEynQpY4fTVYHS04?=
 =?us-ascii?Q?TL1BfTNNMD/CWaRfyJCpcpm6Ujm3I9HIFoOSvHPaeubq05zrnQkPgiRI7x1V?=
 =?us-ascii?Q?2fPzYjhiWz7wUPqHtkadlJrR/mQei3c6g9alqBfrPpqxkDKFdMF366Ei3w1e?=
 =?us-ascii?Q?2UlWMnmnnmCvhGNnHsZ/8kaRWUTmJi6zkg0bWxrWnxHnTl/VEc7yLRXAme30?=
 =?us-ascii?Q?/whSoCpf687OG7/hqBsl/NUwiR6EsvrebO8mbcho3/6u7HpU9btIweOjmCtc?=
 =?us-ascii?Q?vjsxwZ3SG6PXcooLD46PBwzgc5bMolUWF+TZvfyikqerqJiAaOKkVBhrpkO0?=
 =?us-ascii?Q?fUibe1H8EIKxAaC19UhEGMbsOAzHc1bUq2vj3LdDhd4UbvuHXq/Kxq1BTzn+?=
 =?us-ascii?Q?hrQYfdYb9zU8gjvJnZV7mX8KCYxdSCbcNGNrdTpxBjRoVnYzKkcOphuSw52d?=
 =?us-ascii?Q?E2r03AIGI+HqhDiwn+/wSzROIS8BbsfNQ7Vwn0htFpoog9ROOI6ktkXt2IbC?=
 =?us-ascii?Q?l0qcLoyzTzXqgNkvycGCVzwA/PtXuTuCajJlBgpLv7DDQ4uu8zLiCwRWyy+Y?=
 =?us-ascii?Q?tNKF5BKeXplX/GbVAQxNoiEx+iASyUFCKoDISTT+i0NcEJw5RL/WLB6IJM1N?=
 =?us-ascii?Q?ZyTKjxCqOYksk3eHtaJzHb6bJZYRm0l8bAyBqaL5sqxcBrDYBm/ifJidakSL?=
 =?us-ascii?Q?PuZtRt7rbktvHAjmWTcJ6E3wASWUik7XBO72a/KN0ws8lNL902RskbiDyS5a?=
 =?us-ascii?Q?3NSM9RExE7NGosaIOv9T5jkofVPZZHybyTp/TO6Lko2yvKD66aPkWtExic0u?=
 =?us-ascii?Q?UTBfSZEEiQgUE5clBrc6r5vpz4JLxfBVNKIcuec8paLPw2xWEENV1GnEYneo?=
 =?us-ascii?Q?BdWNhsLffP3dAkXHewWholnHLOjY6rCku46WVwELaHhUsNIwnoM9PxUMt9cM?=
 =?us-ascii?Q?dsuA7/j9Pa1Zs0tZZs7Cph72WbsfOJwg/pHtgChylxEB7c1bzXdnl1RNsMaY?=
 =?us-ascii?Q?ytG7lgjt4Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV0PR21MB6596.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd30f16-eb65-4f25-6962-08de8a7ebded
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 14:56:49.0025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T8z2uabDLhQhuqLFTY9xs3VDN1WO84/7JA0jQGYI/35e4d2HHr4bg5C6LXalmU6EwgVyZAgIZ8Tcx+C5hcndUmRqlA1WE5OPTgzxJutVtQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB3396
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18618-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shirazsaleem@microsoft.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B107E327BA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Subject: [EXTERNAL] Re: [PATCH net v2] net/mana: Fix auxiliary device dou=
ble-
> delete race
>=20
> On Tue, 17 Mar 2026 07:39:43 -0700 Konstantin Taranov wrote:
> > Make remove_adev() safe to call concurrently from the service reset
> > and PCI eject paths by using xchg() to atomically claim the adev
> > pointer. This prevents double auxiliary_device_delete/uninit when
> > hv_eject_device_work races with the service reset workqueue.
>=20
> Really seems like you should add proper locking to these paths instead. A=
re the
> accesses to is_suspended, rdma_teardown etc really safe as is?

is_suspended is only accessed from mana_rdma_service_handle on the ordered =
service_wq - single-threaded by definition.

rdma_teardown is a one-way stop flag set in mana_rdma_remove() via WRITE_ON=
CE, with flush_workqueue providing ordering against the
READ_ONCE in the service handler. Concurrent writers are idempotent (both s=
et true).

The field that actually races is gd->adev. Two remove_adev() callers on dif=
ferent workqueues can race - mana_serv_func on the events workqueue
vs hv_eject_device_work on PCI hot-remove - and this patch fixes it via xch=
g(). If we think mutex makes intent clearer, can switch.

>=20
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > index 9017e806e..9ae5f01d8 100644
> > --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> > +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> > @@ -3410,14 +3410,18 @@ static void adev_release(struct device *dev)
> >
> >  static void remove_adev(struct gdma_dev *gd)  {
> > -	struct auxiliary_device *adev =3D gd->adev;
> > -	int id =3D adev->id;
> > +	struct auxiliary_device *adev =3D xchg(&gd->adev, NULL);
>=20
> nit: avoid falling functions with side effects as variable init

Sure. Can fix.
>=20
> > +	int id;
> > +
> > +	if (!adev)
> > +		return;

