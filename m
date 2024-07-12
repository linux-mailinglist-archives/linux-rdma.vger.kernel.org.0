Return-Path: <linux-rdma+bounces-3852-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A806930257
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Jul 2024 01:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DD2B1F22564
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2024 23:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180C513048F;
	Fri, 12 Jul 2024 23:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="A93COlDW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022121.outbound.protection.outlook.com [40.93.195.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF93376F1;
	Fri, 12 Jul 2024 23:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720826315; cv=fail; b=iUCMJ7+tzKZwv9gzIfIQZzzQmMsnwYAalBNuuykyTRG0QnCVrZDZne0IL4g5Vv1y8ep4+/smEX3Mo8/JNvkcgP4fvLAtEQxekU3Gqr4yo///8HNQDe/UWuh/C5OU9fv0njB6kizXLbEsMxJ1ytclBawuVN784e29uUCU1RummXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720826315; c=relaxed/simple;
	bh=Va/zjM2jQhd8eNDkk2Rsx5yxD5NSrYLjiwby9jaDprc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IijNdQFXJzxlHbjjGWg/XLvl95NCRixozGf0G6TR1mJU7DD/3VzvPNPbY3yVXxuXjuu1ENRo6qsUNG7nI+Ls+Xc4qzb9685QQ99RKnXZdydAr9fOWZNBul58baGsAjakTJ+2e/C3IXWbqS3fsMah63Y9bP+iUNrsM5dSRxV16Xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=A93COlDW; arc=fail smtp.client-ip=40.93.195.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EwUG7QpjFLsZcOc1TbaeDQ7qqaFsF5oNXV6KkBeQqZtl13gpv1UW8tpswhuLvlgn2wr5wVVIfefwTdBusLI1nQKfs6j881n+80El/Wls1EBfXCMpcaK24XCBRMwFB8mS8uq1k4EAQ0EuTlBIOXnEk4wSC0Wfa3+4v97CyWbvkwyFs+Kt9bbUnO3+G+jv15cnlrBN9QEtXOyp0RfTuSlM0f5sOATjYSIfcxNU9gMyJjYy16tWsXnHvb+A+64ihCegCyDpWGR2PNUii+pSl3l3k2A0cG7dnh72m6KcS1U3m169adRvNsbKAA6uWDXYDctDIuEAqYe3GIRH3vts2GQUEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJ4C3xscJIoKGKUZkbQw7BVgibz3ewgIZV6Mdmug8II=;
 b=YEUp5KnDsGi2AkIW7gKtFisGHqrHMN6ynLuVnrSxx/9M2HEhdSMjhoxufNiSwPZkGqrmvEAlrMon1N/nun1SMLn2ZFXVZUiv1phjQHeej5oHqz0BvHT97tAajFt1LR9eW5hG1HlaU60o48EdhIoGaSWsZKuK1JClnKpp341L7KIgmddo8DBsXGNeQdxQ0sESDrFQF2mlnW5TwzRn4reA1OvcnkBo9XlBjhQU6zrh4lZLyaqdgWS6fvgwnFN8SbH9tbSnyaD0YcntppDe0q/SKry0k7xOkoak89qYdZq4Uj36fFlMmhnQSAcsTTSkBDyw3xR4XaB5eqpI+8Rai1pseQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJ4C3xscJIoKGKUZkbQw7BVgibz3ewgIZV6Mdmug8II=;
 b=A93COlDWDE83Z4kKokbpk/uGTXyG4a6ejQZI0AjcKheC4W/ebG4NUL9erlypTI5Tuj6RfXUpbrgmluh3xVFjpWnRCaINazhVCbHPesIN1PMmukh7vc6jWdVf/yiQqFxtQ0GC6I6hI7HY+S5mJN3eYbmgNO5fXftD2h+IM0m59ec=
Received: from PH7PR21MB3071.namprd21.prod.outlook.com (2603:10b6:510:1d0::12)
 by CH2PR21MB1415.namprd21.prod.outlook.com (2603:10b6:610:5c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.8; Fri, 12 Jul
 2024 23:18:24 +0000
Received: from PH7PR21MB3071.namprd21.prod.outlook.com
 ([fe80::204c:c88b:65d2:7d3a]) by PH7PR21MB3071.namprd21.prod.outlook.com
 ([fe80::204c:c88b:65d2:7d3a%6]) with mapi id 15.20.7807.000; Fri, 12 Jul 2024
 23:18:24 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, "pabeni@redhat.com" <pabeni@redhat.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, Dexuan Cui
	<decui@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH rdma-next v3 1/1] RDMA/mana_ib: Set correct device into ib
Thread-Topic: [PATCH rdma-next v3 1/1] RDMA/mana_ib: Set correct device into
 ib
Thread-Index: AQHa05eOdW6CvUv0ek+7NG60Z4l1bbHzvCrw
Date: Fri, 12 Jul 2024 23:18:24 +0000
Message-ID:
 <PH7PR21MB30712CE71F250AC5946A4BB6CEA62@PH7PR21MB3071.namprd21.prod.outlook.com>
References: <1720705077-322-1-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1720705077-322-1-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ce8dd68e-9209-4d22-b638-315ca87df7a8;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-07-12T23:17:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3071:EE_|CH2PR21MB1415:EE_
x-ms-office365-filtering-correlation-id: 44954a86-45a6-4a97-1286-08dca2c8edcb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nhJFZFC351PCkLFOFYeoVrcan+I/KEoBiquTTyWuf1mjIiZ5yq9LZg5XEK8N?=
 =?us-ascii?Q?eGKPWZbDH2DiykNDdxERsRvfNUgGzAZzg4y67cQeVPV48l7ozZr/InHU0Pcg?=
 =?us-ascii?Q?Njp+AlYJF9830xmDUoiJ4g3n1uvt92qvO0GVWXVZJ34+XaVIBOsQ9rrKE5W0?=
 =?us-ascii?Q?9dohNYk5PjWCsKMV/0a4Q8W4NeExO4TcScFREm70B4bi24IldqcHizmvzDbS?=
 =?us-ascii?Q?wkRS39N5gsaGcXsvcg/Ptq9nlypVC07UMn9Tm4MTbVgzSCdKlCOwyLqsFhqY?=
 =?us-ascii?Q?HKDvnF5PEhoJQm46hZ9EVr+xuwEK1TFRcSMCD0W9IrnUZlixaTdrhcODV217?=
 =?us-ascii?Q?tEXN53Xu0Mx9t8h1PtCvIq/AYwX0GiL4ZSq7ydZx79U/uJtAa2AXNmCY4L6U?=
 =?us-ascii?Q?bbTFzvw9GPRVTaw33S+G/Vjo3JAv/cd1+62sCLvxKY40KXLsEogwzg/zmdIm?=
 =?us-ascii?Q?dHVlZJ692DU7r6MzrtIrltlslqzKzg7dEYrmSnlIiyhNnd8eaBi/xvbh03jj?=
 =?us-ascii?Q?Gomy9NHtssBKV894F0aqEP7LHfP7clSsSsTXVyvnOKShKuiwBvNdHYcYAKNI?=
 =?us-ascii?Q?y68U3okQSTlly0eOw1Wwtl56yxBjQgWY7sOlKBXcr0GdXVFDwZmkQ6TTGxxN?=
 =?us-ascii?Q?9FuJD4Smany70bXjTsjk3BfyLpIPCrwGQjJH60Fyhdhz4SAUoGRlt8IU9TRi?=
 =?us-ascii?Q?RJC7dV5mAPobrA9IeZjDZnTACgJWMzP4tn19BC3mZly7+hQT40rsfK0iZKpa?=
 =?us-ascii?Q?MgdbFFsXVE5OT3eaNfTatK3fWZBmoBYhugEkZwBdOrpD7mmUQXGH+Y3KCyIG?=
 =?us-ascii?Q?iiKi/4xDtX5B+B43+aV9xZmeGEUhseEMiCaKxaTu+O+oVw6RHLJYgPpEf/Az?=
 =?us-ascii?Q?7jzXlEoSGqukNSNmAD9F7SThpvNyZ3xZu36Qa1qDKqtcfHKttuESOzX94C0C?=
 =?us-ascii?Q?/S2kxiIbFpgy04j8yrIEN1q08QBonFY+et1v8rGBpnkk5sHhRizaXqadiVUL?=
 =?us-ascii?Q?tudLx0EK0gfh1suyIo+9oO1CirXSXuSdu3A8v0AqGLf0Wjgd5rZt9RAzxeBE?=
 =?us-ascii?Q?gE1zjyWG6cJBMTS+BFKq6nT42+kXt1bPiTQq/3mHHfiZAbpol+ftR4CRcQ92?=
 =?us-ascii?Q?gb1BAhWwqh7NzAbjIRzFoDMCKu/MUcr3SxTaZoARlNy8ZBLn2wGcch6qHdbB?=
 =?us-ascii?Q?Qb1Eolj+0EAhOz7O8X+C9d9wHzSVmDQGv01fE8dVYk/Smm2qzbD3nYmEaWaK?=
 =?us-ascii?Q?71aoW8rVyUcdErgbzlcxfcODZcrw3QVawQYJuKKZVGa1YzVmuCU8snxW3NA/?=
 =?us-ascii?Q?Voq8zzOdBm5WCMGEH9+Rb0Ieu2P2TQA1zKZiwc25xX7tK9qCZa3DPqw9Qzqn?=
 =?us-ascii?Q?43s7UWvFJyPhaJL5orY8zo34xxTKNY56x4pmwPFWRYsGrZ33ReoUV7bVFugl?=
 =?us-ascii?Q?EpDiRp6s+zM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3071.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2xbJK3SQ6tc63vVyMvR7K3Ry05TQ/nDdAVuNa/eEiGKR9gGH/XGDk8slByrc?=
 =?us-ascii?Q?EsB0c3mO5oC0eqO1GNpaarG11YCMfUq05WbQLqzgEH04j54+6aMzSijqIJ7N?=
 =?us-ascii?Q?TDk2XCDT62IDLyEwZUT2I6w5qUiHTwxb1v6xt7MEw6ykeZn7IWReZN8xiDUX?=
 =?us-ascii?Q?as9qtNWAoJOlnE2kaXb968DdeDRQRLpJfJEackDKDzG+n3dKhRvTOD8eA7aH?=
 =?us-ascii?Q?vRsEy0Jmr+ursPwkLdB14n2rVt6G1Jo0YN6JerJpsLBoh4yvR2o1YXh29E58?=
 =?us-ascii?Q?qNvcKvS9/0xrYhgEcFmqgFCddrt1LdAnccciqLWXxHQ5FpbuWjJjrSG2SvWU?=
 =?us-ascii?Q?8EwNmZMkcJc4zDUlxNlD626L0yLCZ3MfiouObd3xTZ4+7vpX2+xPX9mNpBSY?=
 =?us-ascii?Q?/sh2b99h1iwCCXODZu3XpN/j3BD48gdOpDK21S9S2f+mWQrBvOKM4rsaqqa+?=
 =?us-ascii?Q?BKHDoywn87dUkfEhpBG0iXDQPuf7kGigEEuGWl9ZmuUD3qBmT18OCNPJo2MA?=
 =?us-ascii?Q?oOwmOQRaxPWyaR42l/Q+ZtaaIknxHtN9UXkKPRvoNSi57fKHTuA4YQ0df6Hd?=
 =?us-ascii?Q?giWwcnk5ULfN9tun9JPSL5nPJxoSur3W3XFNZFP4IaUGSbAVzG9Nv5smAMZR?=
 =?us-ascii?Q?NeXNCtbYaD9u+LDa4uwGqXSa7TSK4OmUMGQYiJfXoEGaiECQ8yLeQAu0Wmbm?=
 =?us-ascii?Q?4AgajuAmUtqrYLObsNAqxnXt0W/mubXUq6ODgW4Fa+BamY8CQNOBxtPYObgy?=
 =?us-ascii?Q?xZM+cF1iAkneRgCFQ4F8LA/Vv5UKwkOwkWeXVpM7dfJr6W3SrfaStxKTI3JN?=
 =?us-ascii?Q?R7tmEBPpK7/EuMfAsEhCBHW+0GeHaUdglubpaZrNMxFoo+jTdSs9U4AaPfIB?=
 =?us-ascii?Q?CODb4WJClw/+TXLlXzNIpWOl1VT73p7XEPCtVFlksSnUFxPr1r7V705Pd3V2?=
 =?us-ascii?Q?OydjnqRD2apPzUjOn4tVwaHRGytmlroZa45VYmEW440ncCaWmF8OZiyhZV3V?=
 =?us-ascii?Q?3ESYMiAdacOMR2lFnYS/BAntiU5o4RBh0eV3yZz1ykYzp+BLXLTD0P6K5t9W?=
 =?us-ascii?Q?9aLGqJGv+g8OjcVawNXBHqVvjFDM6O/Dhj28WyDJ6b/kcFpviXxj9hNNTpG8?=
 =?us-ascii?Q?WsWX8JLUmnqe0VKRMQNSlRk4E7Ljl3B14+hwCJ+NFIoIsCDeBJrVtO1Y4FMQ?=
 =?us-ascii?Q?MN6raAWkk/Fe66t2EXTwfbHIfb6MxLBUu6tS/3AfpZolcBN/iXzjfxZe2bsT?=
 =?us-ascii?Q?sChDIcWsTVUCJQbedmNkUwMDra4hto4XcSyaI+pzBhvebDHXTpOyL2grbWkj?=
 =?us-ascii?Q?Su47W8PMKgCCwMWCN5SODSZSDNATEhu8LB5TK111gqUmdmgj1cdmZA1gQNX+?=
 =?us-ascii?Q?EmyznJDx85mMLFvHm4KgViye7vbaaR6r8SylvK6bFYGYj7E4wX8h4I7Jceey?=
 =?us-ascii?Q?M/sNaO+LdA5E4OMpK7edd65xsqSXbeDPPKAJ9D13ubiz5kVNFSmzDtvzylzP?=
 =?us-ascii?Q?1fOI2M14gcpItQWMXEQ0vCpZPFAQo2os9AsmqnVqPFAcEirF96BfMLbIb2XW?=
 =?us-ascii?Q?RA1XP9yM2cP4YhMw4XJGG4dIrvoQmVGD+tGHZgoV?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 44954a86-45a6-4a97-1286-08dca2c8edcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2024 23:18:24.6236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z5cAefjX3/H0pJ9OtpzY+KByuk4VpyNibO4r3elK4d+NsQlA2yRDAo34ChPcsLEB7szEwPZEaLaId3PwnIn1vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR21MB1415

> Subject: [PATCH rdma-next v3 1/1] RDMA/mana_ib: Set correct device into i=
b
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Add mana_get_primary_netdev_rcu helper to get a primary netdevice for a g=
iven
> port. When mana is used with netvsc, the VF netdev is controlled by an up=
per
> netvsc device. In a baremetal case, the VF netdev is the primary device.
>=20
> Use the mana_get_primary_netdev_rcu() helper in the mana_ib to get the
> correct device for querying network states.
>=20
> Fixes: 8b184e4f1c32 ("RDMA/mana_ib: Enable RoCE on port 1")
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
> I would appreciate if I could get Acks on it from:
> * netvsc maintainers (e.g., Haiyang)
> * net maintainers (e.g., Jakub, David, Eric, Paolo)
>=20
> v1->v2:
> Leon Romanovsky asked to make a helper in the net/mana and get acks from =
net
> maintainers.
> v2->v3:
> Added warn on rcu lock not held.
> Use the word "primary" instead of "master"
> Merged two commits into one and submitted to rdma-next
>=20
>  drivers/infiniband/hw/mana/device.c           | 16 ++++++++--------
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 19 +++++++++++++++++++
>  include/net/mana/mana.h                       |  2 ++
>  3 files changed, 29 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/device.c
> b/drivers/infiniband/hw/mana/device.c
> index b07a8e2e838f..7ac01918ef7c 100644
> --- a/drivers/infiniband/hw/mana/device.c
> +++ b/drivers/infiniband/hw/mana/device.c
> @@ -56,7 +56,7 @@ static int mana_ib_probe(struct auxiliary_device *adev,=
  {
>  	struct mana_adev *madev =3D container_of(adev, struct mana_adev,
> adev);
>  	struct gdma_dev *mdev =3D madev->mdev;
> -	struct net_device *upper_ndev;
> +	struct net_device *ndev;
>  	struct mana_context *mc;
>  	struct mana_ib_dev *dev;
>  	u8 mac_addr[ETH_ALEN];
> @@ -84,17 +84,17 @@ static int mana_ib_probe(struct auxiliary_device *ade=
v,
>  	dev->ib_dev.num_comp_vectors =3D mdev->gdma_context-
> >max_num_queues;
>  	dev->ib_dev.dev.parent =3D mdev->gdma_context->dev;
>=20
> -	rcu_read_lock(); /* required to get upper dev */
> -	upper_ndev =3D netdev_master_upper_dev_get_rcu(mc->ports[0]);
> -	if (!upper_ndev) {
> +	rcu_read_lock(); /* required to get primary netdev */
> +	ndev =3D mana_get_primary_netdev_rcu(mc, 0);
> +	if (!ndev) {
>  		rcu_read_unlock();
>  		ret =3D -ENODEV;
> -		ibdev_err(&dev->ib_dev, "Failed to get master netdev");
> +		ibdev_err(&dev->ib_dev, "Failed to get netdev for IB port 1");
>  		goto free_ib_device;
>  	}
> -	ether_addr_copy(mac_addr, upper_ndev->dev_addr);
> -	addrconf_addr_eui48((u8 *)&dev->ib_dev.node_guid, upper_ndev-
> >dev_addr);
> -	ret =3D ib_device_set_netdev(&dev->ib_dev, upper_ndev, 1);
> +	ether_addr_copy(mac_addr, ndev->dev_addr);
> +	addrconf_addr_eui48((u8 *)&dev->ib_dev.node_guid, ndev->dev_addr);
> +	ret =3D ib_device_set_netdev(&dev->ib_dev, ndev, 1);
>  	rcu_read_unlock();
>  	if (ret) {
>  		ibdev_err(&dev->ib_dev, "Failed to set ib netdev, ret %d", ret);
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index b89ad4afd66e..68c2bea2c022 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -3007,3 +3007,22 @@ void mana_remove(struct gdma_dev *gd, bool
> suspending)
>  	gd->gdma_context =3D NULL;
>  	kfree(ac);
>  }
> +
> +struct net_device *mana_get_primary_netdev_rcu(struct mana_context *ac,
> +u32 port_index) {
> +	struct net_device *ndev;
> +
> +	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
> +			 "Taking primary netdev without holding the RCU read
> lock");
> +	if (port_index >=3D ac->num_ports)
> +		return NULL;
> +
> +	/* When mana is used in netvsc, the upper netdevice should be returned.
> */
> +	if (ac->ports[port_index]->flags & IFF_SLAVE)
> +		ndev =3D netdev_master_upper_dev_get_rcu(ac-
> >ports[port_index]);
> +	else
> +		ndev =3D ac->ports[port_index];
> +
> +	return ndev;
> +}
> +EXPORT_SYMBOL_NS(mana_get_primary_netdev_rcu, NET_MANA);
> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h index
> 59823901b74f..f9b4b0dcb69f 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -797,4 +797,6 @@ void mana_destroy_wq_obj(struct mana_port_context
> *apc, u32 wq_type,  int mana_cfg_vport(struct mana_port_context *apc, u32
> protection_dom_id,
>  		   u32 doorbell_pg_id);
>  void mana_uncfg_vport(struct mana_port_context *apc);
> +
> +struct net_device *mana_get_primary_netdev_rcu(struct mana_context *ac,
> +u32 port_index);
>  #endif /* _MANA_H */
> --
> 2.43.0


