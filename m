Return-Path: <linux-rdma+bounces-21815-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4Uc4BvQnImr6TAEAu9opvQ
	(envelope-from <linux-rdma+bounces-21815-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 03:35:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5C964471C
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 03:35:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=microsoft.com header.s=selector2 header.b=RmeRU5xP;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21815-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21815-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=microsoft.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C0E79301A0A8
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 01:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499D03C2795;
	Fri,  5 Jun 2026 01:32:14 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022082.outbound.protection.outlook.com [40.107.209.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507641A08AF;
	Fri,  5 Jun 2026 01:32:07 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780623133; cv=fail; b=Ic9p6G2IV1VT3EuW0wwJvtmg1E4dmEbwQlZOIsajL2E5+UOQOCGnR7EYlaD6WiIrWkcuQCysALgLyfQuY5afVyVqNMkH1cb3/R9TIjaE8Tu/kK2xmEakVG9aSUqICyLfeEUbQowE4vw0B0GIcC3TCLr6ZXYgw6OaFxowOhVF5hA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780623133; c=relaxed/simple;
	bh=cosPb0dEnDmx2leNudTo7RRdQjOgt5qPdtZ3DQeC2bo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S9C4Pu93vdk1/MuSQBHWQ8bhXKkHRvDQcyPVQKhCiZjNCcH14w8JEb1F5q8KME64ws09CFszxqjOzbsC5jPJrrap4fJSt3PFFJAB2IXpNsGfTVc0C4lpwLM1vRy7SmFFlf4SBi7O/UA3xDddJyMJSCImW35haX9DRrvck7y7Eo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=RmeRU5xP; arc=fail smtp.client-ip=40.107.209.82
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8SUdLmZPfmc3zxVLyq6HX/8Tn9n3jb0f41Ty2nFzAU8OhH25zqTkMzR+K3dQPKgSCtomahafEB4EeszxJ/M8X0mTrRim7IW+h2TMRgLCIjBNc0g0Bb2CSQDUFDkfUjmmHwE7sPS4zQBbZ7ORO8aeCJvqk5un0KtjyE9fSe5F0hhK04zi8kmu3WsZbPmVL3b89yZ3L0E2vWLwPBCNql73cFommSPIW8zWNGOaFWPfOVz4/U7HTeLsYEgU7Ycb2rSr1ZBjFfJ+x2mHf2f5OebfDxnWPQkPfiz2IanJ0A+djxJpLKMnHKZcmf2lu1RS0niHqjxGcE7sW7fbazb923vDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OfzI2x2iE4symt5SyzFFVyXmFL32QwIykqBkVhsQQe8=;
 b=SM5r2NjOIGOsHuXPBktdMrgVmv+wnVAYntBEocg5JFTMebWS59titL55otatQkyNOTZp0Man6pbzqyrpttP53FoRMlPYSixlv3mOUWQ4WhOkdy7f/J3QtUqyB4KdlqlOd2sEczvre9mbqQPpwBgxH1e3ebFVkirpRVOf9CW/dOQoD1MkPzAZEDLdJmJiEsop8YEJvLGA/8Zx5wpkJcATFv7xgIoOja1a6oU33/m1kVXkuYvr+2H7Ljm95adyA+7NXN2uMfA2/SFVMgfE9O9EWQ8Jjt0SXE1bAHnD2RORX2ixRhoASd1Ftrsg3MOHaxO9NCgPGZoi8UDe8mlOntrRVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfzI2x2iE4symt5SyzFFVyXmFL32QwIykqBkVhsQQe8=;
 b=RmeRU5xPBhMZjTU0jWoDQBvcKOl4VWu81OyVJ8yZNRsHbtmykoLKs847WmHi+KHat7yBuLvbMkQkpuofXlnuVQHmjpGBim/5JjlNbBpX7Gm34RxeBrPlXjBHvJeo0XjhEXt6eQmM6nPu3qUUZx1pbTdhtGy/xYTcRhhWprRu7K8=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SA3PR21MB5720.namprd21.prod.outlook.com (2603:10b6:806:498::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.2; Fri, 5 Jun 2026
 01:32:05 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::8bad:6294:8a07:fe18%3]) with mapi id 15.21.0113.000; Fri, 5 Jun 2026
 01:32:05 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, "shirazsaleem@microsoft.com"
	<shirazsaleem@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next v3 1/1] RDMA/mana_ib: UC QP support for UAPI
Thread-Topic: [PATCH rdma-next v3 1/1] RDMA/mana_ib: UC QP support for UAPI
Thread-Index: AQHc6EBrqDIqOwotcEq8/4EhQ1Be27YvQ+BQ
Date: Fri, 5 Jun 2026 01:32:05 +0000
Message-ID:
 <SA1PR21MB66836572AF65E8A2D147F96DCE112@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260520100656.875006-1-kotaranov@linux.microsoft.com>
In-Reply-To: <20260520100656.875006-1-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6b2e4d92-126f-4e0a-b295-cf383dcaff25;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-06-05T01:25:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SA3PR21MB5720:EE_
x-ms-office365-filtering-correlation-id: 05d3a68d-363f-4f58-c8d5-08dec2a24044
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|22082099003|56012099006|11063799006|18002099003;
x-microsoft-antispam-message-info:
 CGmgG+Hnngf73QZl2zJrPX1NjaOzkXJHyBU6ndBM/uL+WObwM3EHf15bXYR8s0ac6/Cw9f7fGiIBoVlzGLHDF4XKWMYaKKO2uDCL0zvQ4os7CjHbj5XYOYOjNfFw97bxUunbwuB3nTfkBYh5oJD9KE4pHli38dwZMCG7wBkO+OofuZLmM7UinwpE8Yxnx9MJKBSgxTbEfBdGthF7l463uM6W6GrkmLe87QoR1NzOCpbEqWyHOt6eOxKGWLvgC0uw8bTfUhwgLNWnDqX7FC43ET3v2dm36fVlO67gBiDTjX4NuVdWZz2VnHX6cgp1A7twqfkOhn7HiX7U0C9/I1eY27Lv6MOB1QMNo7nDB2m4u1ZRVjTuifjHE2HuDUdBOgJRgRJTqCiWLqD+KHe1M8xmZ6fuzYELTU30Lh2jJw2HqI+FHi6fi1RBabuQHpUR4pegSF3yp9qXHyHcBltghoHJ++geq3q3iphcgTaNJCiaW4WWaxvyWoWBLZaI7n+dqc+HMtrFvpT13CAyn9OeuYPTboYwzXAeVTiTzBxBvRiPZXKIpkHHe5cFFsyK+aPODM7ntY/MGkNHqTixUEpg2G/9DA04bmXMe2qXNqF39yM2ox9m19YalhphaJy+b5+foLZV7IxqL3qD7iQf6YBbPKYx6NCGUrtjiDvdNB1p6rUyVNF91qy0XVblcwesK+UXv99fMeXTNCWO+gU+rpo6vTX55IrPdZXERMcpsqHT+1qCdLDnj5GMbky9jSomSOQeR+rV
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CHbNdtREhaL9qfki1xg7snmpmdpandf6wQZq9U/mihHTXuLcY2qqm79OyHF/?=
 =?us-ascii?Q?on1I3YE/VLSJQJc+e+FiX/qa15iGaHIEboJ6Kaz4Boz56n37nTfqxu5IIAgO?=
 =?us-ascii?Q?XaGFbpBQATrs33z8Vf9kCo1jXHYMS/yD3Myg4+vxD6aABB/s6kug9bjCsmnD?=
 =?us-ascii?Q?5tNciqtCvREZ5lbJtqy8ev1YnrFRvv7KSLWhQznO7aOEWz7j50Hm/3Xodm/E?=
 =?us-ascii?Q?jBqGFrywoDacZgCqoPEKBRB05xd8FD8YvM8/R0ZXF9cyne/nO2+p3E0h/anR?=
 =?us-ascii?Q?iY0vFTMdsEGAkBUWvYae+RFAYvGmtPEwGi8nqExo6Vu0Nyq3KH7omRtkPyxZ?=
 =?us-ascii?Q?CtlDB3cFiPShw2dzTGSSkIzPF92Bp9l/uTH6kP4XtAzHZo2/Kj5Isy3QTZbK?=
 =?us-ascii?Q?Xi+NjQMleWAc9+TNRxsSJ2yhUqfhV1UsvcdlPqFDOaEImEBW9zQEC9HmB5z6?=
 =?us-ascii?Q?RtLQkMUx+Ysfe3aFksArwtTVIUuxXOKzvczj+c+07vbeYz8yw8vaUW8gRykZ?=
 =?us-ascii?Q?OFRxelJajZtVy3UYHjLXFZ4tdLdtAAB3//RkjDX1vJYd4Ystu44y/JM7LDMJ?=
 =?us-ascii?Q?Xf0F8hNNpRH1XS5ljuLGc5JzxNiR3sWxTnZYEyj+xwO+MUX3x1AVp7+7tl3u?=
 =?us-ascii?Q?rGMxTUW4AuGYCtHtMHkOs8IiuRgRS7RLVwhokGf/lgToxKr9Uqeo/b/SJ77I?=
 =?us-ascii?Q?JueM5+4v9Cuzmbtd2DFBd8hWkFnvWoovqRDGf9ozRUXL12V9pWQEVJ/SNrC+?=
 =?us-ascii?Q?tF1YT3pC0o8OJZXRJf0rBcxPBEwCP2mla9YCI1eiSsVgRdWphMunRxVgbeVZ?=
 =?us-ascii?Q?NR3RaD2mmn3pUOyL78MccYwV+C79jlweuDchxgTPRvzbfx9EDT4vjy+kGRTI?=
 =?us-ascii?Q?qGVPlA+mjGqRW/EXnNIeYvlXSRCrWfwrOwSUy+awffsjbAiMApQLhsR7iza3?=
 =?us-ascii?Q?sP958Ke3RIRC3103nBbrP4AY5OHioVtmbWLXl4L7+7yh0y81QL64x7DrhgiP?=
 =?us-ascii?Q?6o3H3MYy7Az5VL3aJJC6t42xsNdNMSJ20DBEQa3HasQoc3OoL9nzwM9gi7sF?=
 =?us-ascii?Q?uTP9orc300BaCtN1opFaPmqXfDlp6+ac6hxY8Y3qA1Y2+Wx2HYasAk+jXY3R?=
 =?us-ascii?Q?hAvZhEsfAQ2GKMRzNM5L2wdIg704C86rC1umyoU/bSBc3Cq1XYLEqRTMfb97?=
 =?us-ascii?Q?0rrWRSUFfjntSjjpCQc+EZy2KXcI/XGSOe1yfH0Bu/ISoVrV0G4aYYslJmp7?=
 =?us-ascii?Q?uLzC1r5AlhVwbdzbdlidr1iJD7eBjtn60fAjOe3R5+C6or/9wqUSfjaBAc+4?=
 =?us-ascii?Q?ZmYVwWJY1EJxp1jI5/MiXZgg1cSUMbAUbwgdvMpuQKfum07KHobfgaI8Z73a?=
 =?us-ascii?Q?47E2pm+07pu7lZ0v4XPdbWTrdQ5fBp2QcaIEpUt/6Civr20Oysr2Fn0z9OG0?=
 =?us-ascii?Q?Y+X8L258sO8tZ5c76FdllOWH9/0RhBlUTd+NEDgpwhNyPO+rlnCHv8dyFURy?=
 =?us-ascii?Q?81adT0ygjgv6aYqR6mDcKC5SAffmNwOJJDw97UdX70QJJip58GkC9/LF76xY?=
 =?us-ascii?Q?BiI9OD52i2sM0mDk9sgYWHflqs10zX9v0mVZADX9yiQ2NK2vPTPAKs7j4thj?=
 =?us-ascii?Q?UV0GLSuxVYo/Ah7XR8JpPTTgBR509bVe9ZArr6aI1cyWS+fD+ytG9XddhGvY?=
 =?us-ascii?Q?em31qUmOvbfnGUI6HArAPrLcBnec8FsVgD7hKOodD+hD6SaE?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d3a68d-363f-4f58-c8d5-08dec2a24044
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 01:32:05.1543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8k2atTvslg9hCrOt6L0qQODb98W0ZKlh2AAJV4NBgVQ/6VSfAemvcSfcMtTIeLNbwftgYdflAo3rJEMCvN18AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB5720
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21815-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kotaranov@linux.microsoft.com,m:kotaranov@microsoft.com,m:shirazsaleem@microsoft.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[longli@microsoft.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA5C964471C

> +int mana_ib_gd_destroy_rnic_qp(struct mana_ib_dev *mdev, struct
> +mana_ib_qp *qp)

The function is renamed to _rnic_ to be shared between RC and UC, but
 the request/response structs are still named _rc_. Should these be
 renamed to _rnic_ as well for consistency? Or does the firmware use
 the same destroy command for both QP types?

>  {
>  	struct mana_rnic_destroy_rc_qp_resp resp =3D {0};
>  	struct mana_rnic_destroy_rc_qp_req req =3D {0}; diff --git

