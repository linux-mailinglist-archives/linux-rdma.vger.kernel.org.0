Return-Path: <linux-rdma+bounces-1453-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F00F87D161
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Mar 2024 17:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F4C21F25C1D
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Mar 2024 16:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F403D579;
	Fri, 15 Mar 2024 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PdCF6M5N"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11023019.outbound.protection.outlook.com [52.101.56.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C503C063;
	Fri, 15 Mar 2024 16:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521126; cv=fail; b=jp4WK2verYogUCs6hG9VI9/NzmnI7m/6GX8BYb7rYL/S2tkd+Tczp4ZRQ+Hff8/5WaE1Cj2WeKLTdBDQ1pjZbQHksGS3d/pW4nyGPvaVaN0OxHYDSayZYZmiBNoEvY+PzYo1QivtMnwXX6pxWFMvRuggUuV/rIE4p6s41OAyJDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521126; c=relaxed/simple;
	bh=FSqbijsZqIoyYVUHVpp26KFX8RqVe9uy0J63ADaMEjk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lj9xt232VLG/aFUKeKqDuuBxZYQe7Cq6yLqqT/sBriHG8JVXCWyakEAwD69GUZntHYo0yInFws977eceHDr/LR3kwQQJpy1sut5GSu9vbO64vPTRX1aIpv/WLv4oi6QPK77/V8sjwN96iNiFv+wfwpJ5iTM+hOg1WufFQDfu3Qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=PdCF6M5N; arc=fail smtp.client-ip=52.101.56.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GklSA83hPF7qGVzRoe4rUgk1LZEe2a2tv7NWx2LXxyeVf1BdXdy7gpoxFswXSMoJ1in4OnQac55hfFtS3Rh61e75QOcIcG5kGpvYTB5ZkL5DAdB0qc1BRFbF7NgqKZnEONqbXGdvtlMjnka5xNaYh9QZWLSs49QPefTR7ybxG7sVPoSgiEdkU3CIpDh5MHSFMyypg18Gq9p2IdkspdaMJOQ02HnQOZGANIWzF3aTdL6DOx1XZdl0GUBURHy32SeqRjf6blmxb3PAK80paD1aMawt3yR3dtquftwnUF0nRYVWbmZ5kaIKh/pvvCgXgviEFkROgX6AXrv+Sn1rsn8zPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSqbijsZqIoyYVUHVpp26KFX8RqVe9uy0J63ADaMEjk=;
 b=VP0XFSy8HqI1YvGAeHQ1vw6GKkVBJPO8yNpRz5xzc4OR2qdLg5TH01qHDWh+UJPbxqO4tH6P0Z62OO58zdJCG0GT5vYpkNMS3d2R0kBmepvdEkMKuKCezg6r09Xy0mz8HcbzS62yPAV8gbJ+g9hDIlRxDDr8keQn4DRY3gnhbOxOFjMtqEeo7Cp7Pcb2UxccOSFzBT9W4JVm/GjST1JT6spCP81DH/ttCd77gsWbPbZ65BTVWYUgf7t3H4rQZ+SgT7CMyssjVfFNinKRm7vwFH/u4I0RGUVf2PKDdGvF5956LSdLidIiophprbZFP7mFFOhkQWSkf9a+Kq3W9JCvEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSqbijsZqIoyYVUHVpp26KFX8RqVe9uy0J63ADaMEjk=;
 b=PdCF6M5NaoAkIjuixDFEM2D+iNioX8eHtP0FzW7PX+BtutqgKaEN/eqyei36JlpqGfevP0L5F9W1c7B5rF/ACWDtQe9c9NM79qGIhS8QyRxARBpjUq+ONE0KL8UwRfmPE3HdpLBmokCCQoIK3XzxXJMzP5EAp59u2o6W10Rb1yU=
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com (2603:10b6:a03:453::5)
 by SN7PR21MB3939.namprd21.prod.outlook.com (2603:10b6:806:2ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.9; Fri, 15 Mar
 2024 16:45:22 +0000
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7]) by SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7%4]) with mapi id 15.20.7409.007; Fri, 15 Mar 2024
 16:45:22 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next 1/4] RDMA/mana_ib: Introduce helpers to create
 and destroy mana queues
Thread-Topic: [PATCH rdma-next 1/4] RDMA/mana_ib: Introduce helpers to create
 and destroy mana queues
Thread-Index: AQHadUnfMbqzGdBwO06vJ6WZdP9hJbE5Baog
Date: Fri, 15 Mar 2024 16:45:21 +0000
Message-ID:
 <SJ1PR21MB3457AA909D63D2CDB68A7BF6CE282@SJ1PR21MB3457.namprd21.prod.outlook.com>
References: <1710336299-27344-1-git-send-email-kotaranov@linux.microsoft.com>
 <1710336299-27344-2-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1710336299-27344-2-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c0a922d6-69d9-44d1-8e36-7b9b9d3e651e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-03-15T16:45:00Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR21MB3457:EE_|SN7PR21MB3939:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 K9Bsy4im8Bn67RjlMY9MylSNvWRAjR4HnZHVnYgbm/cub1xkaUR5rkxatApmcexJqDkP2Vj4S4VjC1PNuEJZQQ3dXMcSve68BecFwS/96FV25Y2Vrj+RpwKaLQGYoSsrHm7O+KJC65LYO+r4bTPcemzfZpvmM14nQ1NRGnpWFAJq4nd/WbFCQvNYquB8b1Tb0sDFMICOEjvwB6IezHcsBPIjB6d5dePuYtb17i/OO26kCscKQA9FKCrFUmZ1zkk3Iq0k5V9JquTCakR8diUkC2H8yaerO98V2QKuKL3e+wnyNIM+d54EHF2+f0ZuT12118GnZRsvbJhpGHAtmjZlW/VFQoj5kaFcRW3OFxyHX2CBf/gpQq8sKbic1DEVVX3NWJmp5io6RfmKjS3trSIycvSB8aj8880KF70dxzhIo4Jf6vIe661kV8ZMGonWtewM81rNt6GgDlyjJZ8oafXzalBKp1joVP8RWXGqt1ztwTcHGecVQHJqWWia3VdwzMFLmOkd20j4p2I9f1VEchk3cmGuQlq7WpPVQkH+HLa1H+f0XkfN3xBrhklbBKFFceADRHWVppyTAZaN7pE9o8CmGsTrDek0UzRf5SUE3CxX4TzOtct5o3ptaxN1VxG83R4GpynYGpS4zOsoH5ZxCI9WOXYBK/hApRh2f7bZWDLP/qM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR21MB3457.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pN/B5yvM1swg/hkHab7Hj1ou1ZmQgVl6/HFoEqVgCoR+g4kauZk6rISmMdI/?=
 =?us-ascii?Q?WPwKnnyqo7v9uIK+nMreP6BaIgHk7kLvvVZFml7xoSDzhfXlkREkjUeNvnR+?=
 =?us-ascii?Q?47oT1ACz+sxd32u1M+VjQJyZI8cCgILO/qbpEy9dxsNn2puIsaa4MH+ZZa76?=
 =?us-ascii?Q?DBhQ0jzAhzwNHvkzkroZ/nSOU/Q5nN5jKxJ8WAyFPSgo1t4nE2IFOdGlBOrs?=
 =?us-ascii?Q?8DnhF9l1U/WsORLxe0t7Pd+hTDIKCP6kEU86qg7xByfIhhqMmzb6Vw4zuwxh?=
 =?us-ascii?Q?MJKOLD6fTrzwp0afOQVf5VWbhvSI17GeyN9llEBXRdDVAiZjAIAbPFBrqHcO?=
 =?us-ascii?Q?WMlswNzpLLQBtHBbmgdFifY2ueUu8mv7HyDHl68yrt3rNfNxMdXkvc74+V9d?=
 =?us-ascii?Q?fP0bl1Ir7c733kjlIwvNwoyW+XwlMVaAuoRhE7FsjXnjUKWKGm2ack3qo1T+?=
 =?us-ascii?Q?1xzzoPjdIaq2ejBpuEDdSzbEB1vJzimlhjsMwSxT0zYNzl7FZapN7HsHt0dG?=
 =?us-ascii?Q?xXpy2b7e0Fk4IM0H0G7hIhc81LkfdnJ443fP/KxhRtEU/8Ur/CnGT/hAt8I1?=
 =?us-ascii?Q?wgUKRpy2bCmElV7Th/sfi6NovEBIFjD9xjEijtO0rHi9TidPXC+sHjG2PWq5?=
 =?us-ascii?Q?PQ+AZkeGSrbgjY0jdU8jHPPSAJNtyUWgcVinhwkkVUvCSK9088JTZh85aX2I?=
 =?us-ascii?Q?HIuJQFsTIpt4hflNzEJz6Zyo8m+kIBs18HbtZCkmHwnwY8J1myHfDyJm2Mj/?=
 =?us-ascii?Q?UU1Y3iWS1eJrSL84xuJJSOSAkU/1TjDnzmaK6i3OtdX6qYtk7QEGXedf7BkY?=
 =?us-ascii?Q?d4WqrnDOrBVAB9Le3Ze0PHidhOiPRpGDh7ZI+kgpeT7UQM5Uwwh1epT/jdXY?=
 =?us-ascii?Q?13sxNiTjvvKiygLrGIZ9OKKiqOVUrP3KoP9THTXEyZUD7ndBCcEp8NHh2Wu2?=
 =?us-ascii?Q?1lMHz1Sk6bIBPnXSGqHszEPcU8rh6h/PcfTzu2tOKYBaJ7TY11zIA8mPRjgW?=
 =?us-ascii?Q?E6eUa7AL7rQa1mXnZ0ZZ/IChGqPpJTpWZBlDxytuoNORF8LZPhReRk26ZrzT?=
 =?us-ascii?Q?P27+U0y1k6IS+J4+Z64z0GyXtsa3HI3s4U5VUsMYt65NdxrXx/kaf1y7lXSB?=
 =?us-ascii?Q?doUSttg+YZUhqp9w7tqAatDN30E65qXvBlFlBnLWqq2PS2Cv/4/dr4zJnTov?=
 =?us-ascii?Q?O12SjCDvEROo+53LNzLCaf8VtsWSH4pb1k8Y/5OR1jJuhJHa3pXcCtEI49GH?=
 =?us-ascii?Q?rVOSUGlboGBPKYvVI2bdYGbTWjZV/s+AxAalGItmT+6WNaTuQGul66CGR5py?=
 =?us-ascii?Q?oan72CbgStprgOgXVkGi+9PdpmlcMTMG3iFjP1ZvH34/f25bUlDiBq0OGH6E?=
 =?us-ascii?Q?V4GYru1bBXLVr0GSB9oAKGxrJT6y6d/kQH6rMM9y11oInkiHGn0gMK+PPVLk?=
 =?us-ascii?Q?Qn9SfRZLdw7fMGdc8DSgsIcTn0xiMJT384QXhF45Jn3/n+KeHm0PgaYGV24b?=
 =?us-ascii?Q?P1l8Fl2i7DefxG88Z4F34M2KYPlfEAHuQM1VFoN7Ajf5UWlp9OBjzLAJeQME?=
 =?us-ascii?Q?oUCEwZD38+Hx8KJmm4Wdh5hJDp8GJ/B4Uvh+nA1A?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR21MB3457.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf501ec-93ad-4c9b-cc95-08dc450f4e46
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 16:45:21.9264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uBSyfa0tfvcuvIWKEtjkr9pS/c36X9YqcYQ2A+xLWWKvO4k8ZFVSNhm2x0ffi5r2DhFce2Gi1gjeZvVyMXrYTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR21MB3939



> -----Original Message-----
> From: Konstantin Taranov <kotaranov@linux.microsoft.com>
> Sent: Wednesday, March 13, 2024 6:25 AM
> To: Konstantin Taranov <kotaranov@microsoft.com>;
> sharmaajay@microsoft.com; Long Li <longli@microsoft.com>; jgg@ziepe.ca;
> leon@kernel.org
> Cc: linux-rdma@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH rdma-next 1/4] RDMA/mana_ib: Introduce helpers to create =
and
> destroy mana queues
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Intoduce helpers to work with mana ib queues (struct mana_ib_queue).
> A queue always consists of umem, gdma_region, and id.
> A queue can be used for a WQ or a CQ.
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>


