Return-Path: <linux-rdma+bounces-2545-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 103408CA2DD
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2024 21:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 933F51F21D51
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2024 19:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B504138496;
	Mon, 20 May 2024 19:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="APUp2CIs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11024022.outbound.protection.outlook.com [52.101.61.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4AF8C06;
	Mon, 20 May 2024 19:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716234546; cv=fail; b=db6AYDShj8AJYVYHXGN59X+bWqV3EwbLXzf+GU01HepRprPX33A3ivrGtvEhitGZ4d2YlFG/CzM6cD3T8rP+CHTejbWzXUaovPrdvp1tHEnGihtTjhozNdXYeWw0YHbyNAsKAlJtiWqUVT5pbk5fU4xXOQJsAscUeevS3vRK3QM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716234546; c=relaxed/simple;
	bh=V5L8sTgLWcCU5k7y+R2sjR1DJjUbtz03JOZ6lkl/Kx0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ud302aEOyF2/lf7mAGETh6kBjnI5KAURUdnNQpwpAsc22mDmeGnSw43XiJ7F9HQal6i3SSwCDkvZ2mFQvuR8Fbs/+h4O1rA/p6RC3X0L2mUsTkVgzp6TCaPia8+bp76VBuIRNQod25XOymrAJnSewzDJMYbwJy7HMzmN3b4q4ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=APUp2CIs; arc=fail smtp.client-ip=52.101.61.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DH65Gu9JH8c5PbiF9+0cDav564X9nT+0PiHRuIfSg0hv1v9KZgAFwRQ12k20+Tw5o2ssSIabnUtuyChIYk5Fe2e7epwu1xkpGoZ86XFiXT0DWBc1Lu+LFYuTloNaWJoITPoxuS3/uaz1KIPHkHrA3vZDu0GW3oZH41LMFfx2A690Xy5k+Z+l2N6fjiTFqksUwMExEyHyLSMBrQr2/KP/TjN3N2ZVxpni4VQTALIRXFVFxH+6wxKhPiAgCDEWSdAvo2EHNXVdyxmlMGDkkbzICoBVX8UUe2LPzVPnLLnxiDcZ49hcTu9sLkZGiSZjgJlb6oo86NXcOtwzsFFL6kSu4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5L8sTgLWcCU5k7y+R2sjR1DJjUbtz03JOZ6lkl/Kx0=;
 b=YS7qTCIO8Fxj3cDNG0gMk+wnJ4hVpjaUW2ruERKRGCxzezvuX5ATbTbloX/9MVg7U2snh/UBtNwcnkfo+oUsx5AqHRAEVYMzEHckd5jZuW/7Z1DsVEjobjcQeqUpt/qlguXMyH8rFu5gsbIBTV3ylDueT90lOChIjrvFyrK9WVAfTCmkL1iYAauXwUDYKHBvyt0v4f+oIgfW2w7aFjXRrVQvI99bKOtkGwcOb1236805vCNeZhbrAidSozG5HdBB8qMIL+rwq29hN2lL/09TrUdWQ3nfkEEWqGMMXUbBNaSQdPvO8D+85YmCPwihqKGJHCV6zRvcEl7cSMT0DAOz2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5L8sTgLWcCU5k7y+R2sjR1DJjUbtz03JOZ6lkl/Kx0=;
 b=APUp2CIskRF5IjnachqB1eXZViMS/ZpNdNxJ7WTKYOs8XTZgKmOt+kBUOH4+lzHwV5IiIRmtwR8WoWlE8V7h/JjLqkTOGtcqcUO/W3uukrNnsQuYFkRALOsGcs1+bTQfJY1uHaymOib1R4iR4CqZpO2PruRyKAQ3dAaC8cOu4Wg=
Received: from PH7PR21MB3071.namprd21.prod.outlook.com (2603:10b6:510:1d0::12)
 by DS7PR21MB3366.namprd21.prod.outlook.com (2603:10b6:8:82::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.2; Mon, 20 May 2024 19:49:01 +0000
Received: from PH7PR21MB3071.namprd21.prod.outlook.com
 ([fe80::204c:c88b:65d2:7d3a]) by PH7PR21MB3071.namprd21.prod.outlook.com
 ([fe80::204c:c88b:65d2:7d3a%6]) with mapi id 15.20.7633.000; Mon, 20 May 2024
 19:49:01 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next 3/3] RDMA/mana_ib: Modify QP state
Thread-Topic: [PATCH rdma-next 3/3] RDMA/mana_ib: Modify QP state
Thread-Index: AQHaoGRmrTY+qMVYqUaTAQ7xEqQbEbGgnJTw
Date: Mon, 20 May 2024 19:49:01 +0000
Message-ID:
 <PH7PR21MB3071DAA2FA116BE3262672DDCEE92@PH7PR21MB3071.namprd21.prod.outlook.com>
References: <1715075595-24470-1-git-send-email-kotaranov@linux.microsoft.com>
 <1715075595-24470-4-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1715075595-24470-4-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0a63d88b-68d4-4b0e-bef0-a01bdd2784f4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-05-20T19:48:27Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3071:EE_|DS7PR21MB3366:EE_
x-ms-office365-filtering-correlation-id: dd85766e-5168-47a7-0bdb-08dc7905e571
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2peG6qp6eANHoknVska9LztuS+0ZcBup/KQZDHPz8/o7hQ7RMFbY1Qui509w?=
 =?us-ascii?Q?4r0Eh7YEnGDYZzzCFXzmhvZSD53AWuO1O/CVMjNlkYuORqkwFGpx5thP0Ioq?=
 =?us-ascii?Q?OrEEjZJ7fCASpqiR73XiwigzbA9IJRDKHMbXN/fkICaN06zt27I3QZQqdkVb?=
 =?us-ascii?Q?eicZRnPSSH2Gui5QNeJ0XOP/IBUF6mV3qRV0O7tfxfo44hKbtVg8VGD7GGSA?=
 =?us-ascii?Q?YyAX7XOC5dz7k6Gc8gBljg0oVk/WA1UVJcJMqxuQUXusb6i/NiXX+cvV4IbQ?=
 =?us-ascii?Q?7aOgIOEKPV+MFWarA1xwHglyNvEg/rajrKP3TOOirYEnkxRaxDR76KXJnn8z?=
 =?us-ascii?Q?7eN/zFMft5mjiyPcENafzr/k/FA50YALjPXxUh1oFXff1oLpgGIdt7V0soeN?=
 =?us-ascii?Q?AEEmJjyrcuHk7i6RklnL/QyG8h1/6PBGPnh8OQV1Oe5p8aMxItadQX69qvnc?=
 =?us-ascii?Q?YXLzit+0KXpBlDs0aRIKjzfE+4u2owboL0zbV7VHa8o8fS5bQzPG1ATtay6j?=
 =?us-ascii?Q?d+6GI3yCgUrNDEA8COHRbWhHuoHbPGFzMQ30q3L3YIU+QPPqcPEXr6DNKQja?=
 =?us-ascii?Q?9B1Y+t0elN0Ipl+d8VNrLChbcPosFp/NH3Up7yTlmvFloI/8NGlt8Ousrkk8?=
 =?us-ascii?Q?NCHa0CWtSlEPxMUD6FQy1iOrftdCZJiB3JgaEuUMv4Oj8sEP2M+oHBS0qCGY?=
 =?us-ascii?Q?9QecVE04IuaGbjlJiMh0Qedl6VsPcZ7cxm953ZZ43S3H4OxksW2mz2+Usd7e?=
 =?us-ascii?Q?LNJkZojVupste33vNwxoMCPVutjYLZr9dE6ZsBGNclOrHbxXfLFd7SxKprbF?=
 =?us-ascii?Q?QHklO66F6EKMQMzRabzmHgzMXK0vZbhCQnc93netjjetBn0F86BwxdQ6/rrJ?=
 =?us-ascii?Q?sQG7IeW9GHQuh/mjuR9lBfB3/l+LMBwt9sBtISyFxjIrUYfydkQ9wBa6I71n?=
 =?us-ascii?Q?TXUppyASXWHyN9+tcjiCvqLdk3bIu/gAtcMxfQ39XshsFSmNeIGYi34oBQ1T?=
 =?us-ascii?Q?KDJSjRfKXTwwQAipmgmbpTUy7qwsQEWQfHDZSuhWxBkhyEA/SNgOmmjUnIYd?=
 =?us-ascii?Q?icKR9hXLsQPAnoyANGmCZTqveTVo2BEpQBA7bKB9H77yIOsGWZFFfLkOZf+f?=
 =?us-ascii?Q?6jtv6ip4/u613dwYF+d3I+dPPzMy59jMen1RvQ1el08JUhz/2QBKUCEutgt4?=
 =?us-ascii?Q?tnNBQHBR3SYNp2f1iV4I16OmXxXQtTJwHVZxnvdOL1hq1tKk72Tbq5VSK2yZ?=
 =?us-ascii?Q?csLiiA/fTsnUT2fQuj0iDbvLywwGCDeHktK85hvmado1Piphyy2q2bFDvs/P?=
 =?us-ascii?Q?6kWcbnq29mATiwi2ufUcZ6a+/QYAnE4tQTdbzzNPRkNaiQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3071.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PQGFG8jWSzGcZoWQUGmPRGWnZiTU0eCALy8AeQSttNK0Gsi/ErhMMWawjh1F?=
 =?us-ascii?Q?fE1Sxs8fjEreqoqIaG1JFMDsYU8TOh3n4vBRnrvpowrsp6vreD2ewJzdeEdP?=
 =?us-ascii?Q?55KuLFbZHzMX3pwn1cvAuFpTxaSerdqNDisNbQntZkuFb3BP5OGJ9NW5SHbP?=
 =?us-ascii?Q?+YmYb66HoL7heQwzBRyJfVY+mRGV938lZfrLC6zBpba5lGtX/TMuD/PMMDyA?=
 =?us-ascii?Q?TSsc055D15MNt1G1LwVYnnuBv09eXy8wYRbei4g2XwXpB1z3bsWIkH4Z+7JB?=
 =?us-ascii?Q?KPrhwjcev1nLGAq+xOOtVc/Db+fBDPpVG/X7w1YFz4G0DxK7tGn77msvCp08?=
 =?us-ascii?Q?PLmulJbrNtHE5i+XlI8taFbrAx0fDg7qzfdYR0S8kB+FgR4rcC1qatQmPnNt?=
 =?us-ascii?Q?IT10glnP48sD/2yDU1do5xC5zTb7CLKFzqOl3TBWPTDgGpGxXn6VU2DYZ0D+?=
 =?us-ascii?Q?r32ny5atC2JLskQuQ7yBz4oKRZw2YaRXPRo2WHwUB8sj3YCw3j/KiBH6sPqT?=
 =?us-ascii?Q?HyAWoU6eutxJUJK5POG88ZMtl4z0uYKXCo94b13+tJEpUc8ESMCMjId+6BYk?=
 =?us-ascii?Q?6/mtMJf/sINFRan8a7zR2PnA3hvuHZk2ZaSOw2K4YTHQvw1CqUGrqocXKBQV?=
 =?us-ascii?Q?ADexR5bnojZqG8Yn5j/Y+Kq8/t5PKYArdf6vJ3M+9MePn4Y0cM5CrIZX3i/p?=
 =?us-ascii?Q?F2J1iStdvVRfO5ZzDXs4fG9z/7RUafJWrp+obIKoR1sxN68CAueQ6sgMS+pG?=
 =?us-ascii?Q?Wp1OscXmJqpo0R87wm6XrIMTHHOb9LMvTPD34dz1tDjIsjnntX3zfTk2bjHx?=
 =?us-ascii?Q?MSES4MZ804OsMej7zBo1N2Sf+r8lADSDqwD9ksFPZlGsHkHxppU6FJQKHi5J?=
 =?us-ascii?Q?UgNE5mNQCkCtSauRrrtfzJOsMoRXO7oZo2yIuFHeaX+Azd/dKVQXFOetNHQv?=
 =?us-ascii?Q?q19Cjho6IxlqEv//vH2AA+YhDdP5MbEeCTSjeDNpi+YJiqcmPBE9EZLYoYkA?=
 =?us-ascii?Q?knztqIqIfPjsBQkJeO4h2lMXy2OrwXDoIRQhrDT36qk8vd1s9H5BnWIxgFcX?=
 =?us-ascii?Q?cZmhbz3exPVXxvJ9TMytoG+zzv8peEILHoKvvizk2UL1jdIRqc/aSlppsTWT?=
 =?us-ascii?Q?3bZl1TO11NYoYCSQP2WeG2OW/3HUs7UPqKcCSi5SCjAsUAeV+h48R7NZLger?=
 =?us-ascii?Q?iNRE21WrcVp1P6nD8FxXu0as4PqVFoqKCUGoZ74RWM/mcVu88te3qFqJFoCe?=
 =?us-ascii?Q?2ZQeAIRfR/zlOcpop2LX2nkWMNKoCF10GdZXEZHZln6uam8nBCpSS+h4qT20?=
 =?us-ascii?Q?+WfTj18CiVA43C/8Go9Hult+BYvFcvePbXcf3IJnE0mR12zjkwDbozajnRUA?=
 =?us-ascii?Q?yhDLcZ9X77mvI2WuFy+YRTfkTd0QWxU8vgNXi+RTFIAVwZrSM/jGu+6PMcui?=
 =?us-ascii?Q?PeXYgtm0LhG6blnk8f38q8Rdl6F9dGKDurK9sdjQQTAYc57BCH+IZ/E+e2ud?=
 =?us-ascii?Q?teBlUifDJd6IOd5JVjMvIuXAuS4hbE5j929zMAGgXrTEbgxm6F8p0r+sVJh8?=
 =?us-ascii?Q?0FPcacLOvZpIboWcUxV/bkxxHC3oLiO/ykOsWPSW?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3071.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd85766e-5168-47a7-0bdb-08dc7905e571
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2024 19:49:01.0730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WOQGCxEHFVpDeLD5JtpynvAFXKyXl2OlNhJ1p3Sa72caFYoFo/qZemve47CNv64RzYkx5QTVS1AEgp8FUf97Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3366

> Subject: [PATCH rdma-next 3/3] RDMA/mana_ib: Modify QP state
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Implement modify QP state for RC QPs.
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>


Reviewed-by: Long Li <longli@microsoft.com>

