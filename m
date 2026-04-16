Return-Path: <linux-rdma+bounces-19396-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNdjCNM/4WmaqgAAu9opvQ
	(envelope-from <linux-rdma+bounces-19396-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 22:00:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 725C241466C
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 22:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D46D5300EF88
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2026 19:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D189C3ED5DC;
	Thu, 16 Apr 2026 19:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="UkqL6Kp2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022106.outbound.protection.outlook.com [52.101.43.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F863ED135;
	Thu, 16 Apr 2026 19:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776369134; cv=fail; b=UzSH8xNwuIY8oIEOpJYkAe2Ca43s4yIIvWqFIZUW837IAFqj21UiJFI18LPDJIBssFCXiZVBri6BQFL0T7O/EIEtv55BNRf24BQ5uJMsEgwG1LgT21H9C7T603bhWdh2+WdiGRJqZh3pQAAXCnArRDn2i1iE3DxUcMTbMLFLLjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776369134; c=relaxed/simple;
	bh=zvYHqjqbHnc54bXbnIOi+1iTkFwTj9zXYa6L0Ypdyuc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uiKLZnB2vZZQzw0Mw5u7Vthzat+kQv/zd3cEoc/n/6f4tQb9KSPF2VRTG74y8+F+RNocwTfYhSMKde+xlNASkXZUxx1KWON5Q6FFlnMPqyHklDPE3dlkBXxWMp4YdMQ2PMXIlaa5/wUrznNmN2AclViEAoT0OIVs45ujbfwRBoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=UkqL6Kp2; arc=fail smtp.client-ip=52.101.43.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHnN2yWHZmoQE9oZrbNJqTBBIiQ/LHIbIqcG6mmrhigGxfaKmiKFssZeYhkLwfAW7xQ7QtNEwaXSJpr6vHsGF2hJXQRFWeWJxWHaD+Zf1mXD/IJRPsY1lzyH1uElLw2XdSGvTarVIYCcDuWyeyyQHTCrYE+otfIp7W5BxXJsHUlqVupqRxr0XJ2RydFsVdicwSp4xYA4AxGGN2/lcFSz/XCgvWUtdDUrQ5vU+8CPP0Rvnd7wIrzV1SV9bpqNWoKlAr5o2wy5g5AYne+n4cymb4//z4TtPjjj2RHcL7dDfbxr8hOHmRgSk9l1TL5BKZ3Peo5vz3aGSVzEiFreJCnU6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xwwm1HyeyjEY2d/4FEIdO99Aq13WjuwZiMVXs1w2WU=;
 b=YSHbErYAWBAS6ANHgBhYvrBTuaPRHtiI1lfD1GuLLN2kTe/Q+8cfuKTgzufpphnPwMONec/z5ZA2eYUKNEG3NyZNpCbKTpJkfoQ71ZDZtsTbSzJ46DA++2a20A8zujSzW6PMNVmv6bKqoTqMJwIbS7KA+fuaIQ9K0vSOB8XzIKG5reJG33Qi6/+Al9quOSwdNwHq/EcZkkXrmQXVO3jq0V/C7ORHtnKzuuAvQVZvgN6lG/muyViEuo07+6X5UUcGQjd8O3d3V0lpzMI3WEtjKL70POnZUKkwiUx9voaBPplKZBEiFso+aDtDq7urngyug91wCMcHW4SMdkbwK2/MpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xwwm1HyeyjEY2d/4FEIdO99Aq13WjuwZiMVXs1w2WU=;
 b=UkqL6Kp28s0Ck1OLmisPmbVfR7T/YKj2TEs9weE1rfptt3QyLnqwnX7VBMlW36rFzDaNgANnnR6M208F6LAVC/hw8oI9Z9byMX36upWlAY7TlewYZFiGIsCqZynvhLJ7qUsbcG6N52WPv8wJhUJbXbfvSAURTTCLR4EEpMfLrJE=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by LV5PR21MB4994.namprd21.prod.outlook.com (2603:10b6:408:2f9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 19:52:03 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%3]) with mapi id 15.20.9846.007; Thu, 16 Apr 2026
 19:52:03 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next v3 1/1] RDMA/mana_ib: UC QP support for UAPI
Thread-Topic: [PATCH rdma-next v3 1/1] RDMA/mana_ib: UC QP support for UAPI
Thread-Index: AQHczamujgIgxtxJs02DZ0EwAz/aSLXiGZSg
Date: Thu, 16 Apr 2026 19:52:03 +0000
Message-ID:
 <SA1PR21MB6683463B3F98DB94B9A572DACE232@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260416140231.825205-1-kotaranov@linux.microsoft.com>
In-Reply-To: <20260416140231.825205-1-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7190d333-0883-40c3-ac80-e9a0038bca03;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-04-16T19:51:44Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|LV5PR21MB4994:EE_
x-ms-office365-filtering-correlation-id: a977ec41-adb7-4047-209f-08de9bf1a1a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 FT2RuafUZ5GMSZyS0k2RNhG4kht1OANZPuFQ6fJLuS1ngabUEmGBEP9g3PzoYsVYXryyiUL6y1vQBiJCafJHUC8qdcbP6oLdthkXzqi+nYVbiKpDf3BLs+nmPAsSYF12tgpbpvtXTU/y9YanzS5t4rqcPuTC5UodvhwNxNBzss+I+66QuQNaDbq63RIRPC8jb62Le+6SByj7mZgkVwWo+WUohboj7bf4Vq6gc6fJftvTFp9G7oQbLGufEEf9oCU1hOmMgUeQsSauB8e83zZ9ZIJxZ2yIayEYOhx4yaJ+XoNPG2N1q/l+NUlgeyE7sDPxaCTTfquViZiXoCCQ8X73diTBtwN8O9MSou8CL0uGXPuhtI0vu092DOwwKB7H7fWNb7iHGt7xTfG3fvPK1FvNvBP+Awhf9g3V6du8BzhTXgvIHMM1EMqkMUTiUrB20sk26fudZX1nlpEYo0rDNQYIy2zLvpkq5dbn4Ttf0dk+39O41D6q4REK3ZsWeIUg/xASLZxUZoFxsxdsMlbPGSSid4jfflIVLyPqenxmpKWkg4wYbIvDi6joJN5ERbD73IldVM0GEM9Uq+3s0/StG+Zqvxne8tWcHJy8yfkHfaF/AmLbqIKynUO0pAWaI6P8SgJFg4fbXrzmdoA50bbgNuYKW55AW6OYEbODwVd92OM/TX93wLDDKD5kp196rGtJNSBKIxnwF8ym6lt71lNJJm6QazR/am0w/dbrtWzR7PZAniKqbYqvrs26uhYTGKs2aI0aYvEpRmaxJaYAJq3XtUwXvcWj7Il4b6WZwwD8OQ7yHJw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YBfsCuPQ72fWETXrHFLgaM4Dt9g4Oe4gZTtKMF6GYUVM4qMBp+DHcjzT438e?=
 =?us-ascii?Q?Kc2Nn0v93u6aFjdAeifR2ZDaSFsqadUULkDZAL1tzTYpyNBkSRzVDKAJq2M2?=
 =?us-ascii?Q?jQ6aPLWxOSt8NEUbFLLdsEd7i4IvvAMSpuOw4G+exDroDNssX+pZgTEY/91O?=
 =?us-ascii?Q?PsXc7Z86EatEjY2wK9/COqNLFhOQwDxxOihW5drHnR4+x76ziU7GO2qQAskn?=
 =?us-ascii?Q?9CjkJkC6zWXQ0rho+wMYxBjgx1uT9dLePwtNmsNcIq+v4nsjTqGL+9tq29Gi?=
 =?us-ascii?Q?ZpxbhLWu1jyEpG8mbka81T7C8z1sZvzYxN0vdgBnJOKmhhQcQYpHk0XBN9wt?=
 =?us-ascii?Q?3krsiaV4I0ybnIzUY+eL5+16srpQe9v4oRQHA+TxXKn/FdiLaQJydU42k0Vu?=
 =?us-ascii?Q?l+UmDZlLi8G4pZwzMSiZtbSVcPLUoop6lQeC8M58QnD2w5fGlmbVNYhrY1+j?=
 =?us-ascii?Q?Ze+aqxlXTTUtOzjYAhpZKfgPlCOswizZHtTEl36XFDd/RjDGodZber+O95mc?=
 =?us-ascii?Q?K33n2gVVvk9kGku9O6LCS5UgbPddXRyEd1tI0Xef4ouTDUDDLKaYKJcoBis+?=
 =?us-ascii?Q?b78uk3qZmJcz3WJ52L0KGe4mYy+k99Ts5n1OJRSAJ4P/hb+i3y47zRy8xnDn?=
 =?us-ascii?Q?hOo/FKsT8xE/2O1dKZLWEiJToBsbePzezGXkMYXvVpTMOQpeBu63HEg3t/Cd?=
 =?us-ascii?Q?ybF0MSDcs3V7VSai7pz9C3lMaY70SrTGGZg2ez817NZkdddL5587INS4JcPE?=
 =?us-ascii?Q?kzJEI5P7JL3k18ZhYDmSRx+HqgqtO39/NZPpLtKLd0IoTy4PMoafjH5/ecQy?=
 =?us-ascii?Q?B7mMiWXDW0hbBsofjh9bUw5L+7V7BsFczvmkwOXXtA89xedUL3RbS9HwbnbL?=
 =?us-ascii?Q?5cNowSUk0LzxFy7hTUORqx0xS41hCqEcgrvgoTjaJwwitTOGwIRWiChuAnwd?=
 =?us-ascii?Q?ui3YCwLNRgYTbe+HDxv7lm5BsFzthzwqcyf+5AuUqarXcJNBvEJz18luaprD?=
 =?us-ascii?Q?eVkK5nmJKw1cq+ilMOXNRSxmBtUA2NWNA3Rtu/3q7XEwOBjGxOfxTJgPt8fU?=
 =?us-ascii?Q?bcfpFlMsDJt4Q1hF5KwGYz5XEQP/56HbVC+FbwCeZ6TOxdE9CDrgdismxdWR?=
 =?us-ascii?Q?HqEAz8uEashQAv9a9xgcxYdGEXfdrrjYnkj5vGv7i258qB45AdXwhs0EMoGA?=
 =?us-ascii?Q?ZILdraSQAvX+wmLGIFyrVPkhZgoxkcYJRgA/ONKid7bt6oFsXsaNeoGJ5WUB?=
 =?us-ascii?Q?WjjscOYrMxOBn6eDl4AWwDRC6kQ+A3/RcIS5L9l0fDX3YE1mmIOMnaxhB9GQ?=
 =?us-ascii?Q?y6s0JMkw9qPAjvpVqpeBR8CfZXop393EjcYS0+83U+ZdjVwLkbFtTxbi6Sjc?=
 =?us-ascii?Q?hoyqFQa1uGzFiUr2mKKDPAA7x3mqB3tdv4WNyga4I5O5ljOAkQmZ8KHB0HFt?=
 =?us-ascii?Q?dHP7BR6tPLAcIiJ+eaN5YjDUOuxtOVrWQnBUaLRmlr1jvG7vetQqKNNeiH7e?=
 =?us-ascii?Q?J87SaEu2xh0g3J6NAG+lAnNl9hPhXEtYPDlO09u+gMPgatWaRtLzODAA3ydu?=
 =?us-ascii?Q?3IQaUWK+2btLyP5ISAqL4qEH8RjERljETrfawEUaxdbfn0INtbvZc+xyS7x9?=
 =?us-ascii?Q?BYD0wJ6u4lzBNBcgavQ9GgjYAlsyAOV1EUtUM/Y9r0pusx/icd8sIgrm7luS?=
 =?us-ascii?Q?TkRLcQDJTVPv0FTHMulzna2JgtzwGinTSYE9oanVs0shFclj?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a977ec41-adb7-4047-209f-08de9bf1a1a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 19:52:03.3701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FSYbtxTQkX+ISRtBp1Vwf96QFSV2qoq16+eEvdi4fmtEcOo7fzAVXwO3MeiRpn8EjNEkQmoEcsdXQY7iKKHeKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR21MB4994
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19396-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 725C241466C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Implement UC QP creation in the RNIC HW for user API. An UC QP is exposed=
 as
> three work queues: send, receive, and memory management. The latter is us=
ed
> for bind and invalidate WQEs to support memory windows.
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>


> ---
> v3: use new udata helpers
> v2: removed udata check and removed enum from mana-abi.h
>  drivers/infiniband/hw/mana/main.c    | 41 ++++++++++++-
>  drivers/infiniband/hw/mana/mana_ib.h | 41 ++++++++++++-
>  drivers/infiniband/hw/mana/qp.c      | 89 ++++++++++++++++++++++++++--
>  include/uapi/rdma/mana-abi.h         | 11 ++++
>  4 files changed, 173 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/main.c
> b/drivers/infiniband/hw/mana/main.c
> index ac5e75dd3..42567c30e 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -978,7 +978,46 @@ int mana_ib_gd_create_rc_qp(struct mana_ib_dev
> *mdev, struct mana_ib_qp *qp,
>  	return 0;
>  }
>=20
> -int mana_ib_gd_destroy_rc_qp(struct mana_ib_dev *mdev, struct mana_ib_qp
> *qp)
> +int mana_ib_gd_create_uc_qp(struct mana_ib_dev *mdev, struct mana_ib_qp
> *qp,
> +			    struct ib_qp_init_attr *attr, u32 doorbell, u64 flags) {
> +	struct mana_ib_cq *send_cq =3D container_of(qp->ibqp.send_cq, struct
> mana_ib_cq, ibcq);
> +	struct mana_ib_cq *recv_cq =3D container_of(qp->ibqp.recv_cq, struct
> mana_ib_cq, ibcq);
> +	struct mana_ib_pd *pd =3D container_of(qp->ibqp.pd, struct mana_ib_pd,
> ibpd);
> +	struct gdma_context *gc =3D mdev_to_gc(mdev);
> +	struct mana_rnic_create_uc_qp_resp resp =3D {};
> +	struct mana_rnic_create_uc_qp_req req =3D {};
> +	int err, i;
> +
> +	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CREATE_UC_QP, sizeof(req),
> sizeof(resp));
> +	req.hdr.dev_id =3D mdev->gdma_dev->dev_id;
> +	req.adapter =3D mdev->adapter_handle;
> +	req.pd_handle =3D pd->pd_handle;
> +	req.send_cq_handle =3D send_cq->cq_handle;
> +	req.recv_cq_handle =3D recv_cq->cq_handle;
> +	for (i =3D 0; i < MANA_UC_QUEUE_TYPE_MAX; i++)
> +		req.dma_region[i] =3D qp->uc_qp.queues[i].gdma_region;
> +	req.doorbell_page =3D doorbell;
> +	req.max_send_wr =3D attr->cap.max_send_wr;
> +	req.max_recv_wr =3D attr->cap.max_recv_wr;
> +	req.max_send_sge =3D attr->cap.max_send_sge;
> +	req.max_recv_sge =3D attr->cap.max_recv_sge;
> +	req.flags =3D flags;
> +
> +	err =3D mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp=
);
> +	if (err)
> +		return err;
> +
> +	qp->qp_handle =3D resp.qp_handle;
> +	for (i =3D 0; i < MANA_UC_QUEUE_TYPE_MAX; i++) {
> +		qp->uc_qp.queues[i].id =3D resp.queue_ids[i];
> +		/* The GDMA regions are now owned by the RNIC QP handle */
> +		qp->uc_qp.queues[i].gdma_region =3D
> GDMA_INVALID_DMA_REGION;
> +	}
> +	return 0;
> +}
> +
> +int mana_ib_gd_destroy_rnic_qp(struct mana_ib_dev *mdev, struct
> +mana_ib_qp *qp)
>  {
>  	struct mana_rnic_destroy_rc_qp_resp resp =3D {0};
>  	struct mana_rnic_destroy_rc_qp_req req =3D {0}; diff --git
> a/drivers/infiniband/hw/mana/mana_ib.h
> b/drivers/infiniband/hw/mana/mana_ib.h
> index c9c94e86a..0f21a4b25 100644
> --- a/drivers/infiniband/hw/mana/mana_ib.h
> +++ b/drivers/infiniband/hw/mana/mana_ib.h
> @@ -166,6 +166,17 @@ struct mana_ib_rc_qp {
>  	struct mana_ib_queue queues[MANA_RC_QUEUE_TYPE_MAX];  };
>=20
> +enum mana_uc_queue_type {
> +	MANA_UC_SEND_QUEUE_REQUESTER =3D 0,
> +	MANA_UC_RECV_QUEUE_RESPONDER,
> +	MANA_UC_SEND_QUEUE_MMQ,
> +	MANA_UC_QUEUE_TYPE_MAX,
> +};
> +
> +struct mana_ib_uc_qp {
> +	struct mana_ib_queue queues[MANA_UC_QUEUE_TYPE_MAX]; };
> +
>  enum mana_ud_queue_type {
>  	MANA_UD_SEND_QUEUE =3D 0,
>  	MANA_UD_RECV_QUEUE,
> @@ -184,6 +195,7 @@ struct mana_ib_qp {
>  	union {
>  		struct mana_ib_queue raw_sq;
>  		struct mana_ib_rc_qp rc_qp;
> +		struct mana_ib_uc_qp uc_qp;
>  		struct mana_ib_ud_qp ud_qp;
>  	};
>=20
> @@ -221,6 +233,7 @@ enum mana_ib_command_code {
>  	MANA_IB_CREATE_RC_QP    =3D 0x3000a,
>  	MANA_IB_DESTROY_RC_QP   =3D 0x3000b,
>  	MANA_IB_SET_QP_STATE	=3D 0x3000d,
> +	MANA_IB_CREATE_UC_QP    =3D 0x30020,
>  	MANA_IB_QUERY_VF_COUNTERS =3D 0x30022,
>  	MANA_IB_QUERY_DEVICE_COUNTERS =3D 0x30023,  }; @@ -380,6
> +393,29 @@ struct mana_rnic_destroy_rc_qp_resp {
>  	struct gdma_resp_hdr hdr;
>  }; /* HW Data */
>=20
> +struct mana_rnic_create_uc_qp_req {
> +	struct gdma_req_hdr hdr;
> +	mana_handle_t adapter;
> +	mana_handle_t pd_handle;
> +	mana_handle_t send_cq_handle;
> +	mana_handle_t recv_cq_handle;
> +	u64 dma_region[MANA_UC_QUEUE_TYPE_MAX];
> +	u64 flags;
> +	u32 doorbell_page;
> +	u32 max_send_wr;
> +	u32 max_recv_wr;
> +	u32 max_send_sge;
> +	u32 max_recv_sge;
> +	u32 reserved;
> +}; /* HW Data */
> +
> +struct mana_rnic_create_uc_qp_resp {
> +	struct gdma_resp_hdr hdr;
> +	mana_handle_t qp_handle;
> +	u32 queue_ids[MANA_UC_QUEUE_TYPE_MAX];
> +	u32 reserved;
> +}; /* HW Data*/
> +
>  struct mana_rnic_create_udqp_req {
>  	struct gdma_req_hdr hdr;
>  	mana_handle_t adapter;
> @@ -722,8 +758,9 @@ int mana_ib_gd_destroy_cq(struct mana_ib_dev *mdev,
> struct mana_ib_cq *cq);
>=20
>  int mana_ib_gd_create_rc_qp(struct mana_ib_dev *mdev, struct mana_ib_qp
> *qp,
>  			    struct ib_qp_init_attr *attr, u32 doorbell, u64 flags); -
> int mana_ib_gd_destroy_rc_qp(struct mana_ib_dev *mdev, struct mana_ib_qp
> *qp);
> -
> +int mana_ib_gd_destroy_rnic_qp(struct mana_ib_dev *mdev, struct
> +mana_ib_qp *qp); int mana_ib_gd_create_uc_qp(struct mana_ib_dev *mdev,
> struct mana_ib_qp *qp,
> +			    struct ib_qp_init_attr *attr, u32 doorbell, u64 flags);
>  int mana_ib_gd_create_ud_qp(struct mana_ib_dev *mdev, struct mana_ib_qp
> *qp,
>  			    struct ib_qp_init_attr *attr, u32 doorbell, u32 type);
> int mana_ib_gd_destroy_ud_qp(struct mana_ib_dev *mdev, struct mana_ib_qp
> *qp); diff --git a/drivers/infiniband/hw/mana/qp.c
> b/drivers/infiniband/hw/mana/qp.c index 645581359..b13449b48 100644
> --- a/drivers/infiniband/hw/mana/qp.c
> +++ b/drivers/infiniband/hw/mana/qp.c
> @@ -420,13 +420,13 @@ static enum gdma_queue_type
> mana_ib_queue_type(struct ib_qp_init_attr *attr, u32
>  	return type;
>  }
>=20
> -static int mana_table_store_rc_qp(struct mana_ib_dev *mdev, struct
> mana_ib_qp *qp)
> +static int mana_table_store_rnic_qp(struct mana_ib_dev *mdev, struct
> +mana_ib_qp *qp)
>  {
>  	return xa_insert_irq(&mdev->qp_table_wq, qp->ibqp.qp_num, qp,
>  			     GFP_KERNEL);
>  }
>=20
> -static void mana_table_remove_rc_qp(struct mana_ib_dev *mdev, struct
> mana_ib_qp *qp)
> +static void mana_table_remove_rnic_qp(struct mana_ib_dev *mdev, struct
> +mana_ib_qp *qp)
>  {
>  	xa_erase_irq(&mdev->qp_table_wq, qp->ibqp.qp_num);  } @@ -468,7
> +468,8 @@ static int mana_table_store_qp(struct mana_ib_dev *mdev, struct
> mana_ib_qp *qp)
>=20
>  	switch (qp->ibqp.qp_type) {
>  	case IB_QPT_RC:
> -		return mana_table_store_rc_qp(mdev, qp);
> +	case IB_QPT_UC:
> +		return mana_table_store_rnic_qp(mdev, qp);
>  	case IB_QPT_UD:
>  	case IB_QPT_GSI:
>  		return mana_table_store_ud_qp(mdev, qp); @@ -485,7 +486,8
> @@ static void mana_table_remove_qp(struct mana_ib_dev *mdev,  {
>  	switch (qp->ibqp.qp_type) {
>  	case IB_QPT_RC:
> -		mana_table_remove_rc_qp(mdev, qp);
> +	case IB_QPT_UC:
> +		mana_table_remove_rnic_qp(mdev, qp);
>  		break;
>  	case IB_QPT_UD:
>  	case IB_QPT_GSI:
> @@ -567,13 +569,67 @@ static int mana_ib_create_rc_qp(struct ib_qp *ibqp,
> struct ib_pd *ibpd,
>  	return 0;
>=20
>  destroy_qp:
> -	mana_ib_gd_destroy_rc_qp(mdev, qp);
> +	mana_ib_gd_destroy_rnic_qp(mdev, qp);
>  destroy_queues:
>  	while (i-- > 0)
>  		mana_ib_destroy_queue(mdev, &qp->rc_qp.queues[i]);
>  	return err;
>  }
>=20
> +static int mana_ib_create_uc_qp(struct ib_qp *ibqp, struct ib_pd *ibpd,
> +				struct ib_qp_init_attr *attr, struct ib_udata
> *udata) {
> +	struct mana_ib_dev *mdev =3D container_of(ibpd->device, struct
> mana_ib_dev, ib_dev);
> +	struct mana_ib_qp *qp =3D container_of(ibqp, struct mana_ib_qp, ibqp);
> +	struct mana_ib_create_uc_qp_resp resp =3D {};
> +	struct mana_ib_ucontext *mana_ucontext;
> +	struct mana_ib_create_uc_qp ucmd;
> +	u64 flags =3D 0;
> +	u32 doorbell;
> +	int err, i;
> +
> +	if (!udata)
> +		return -EINVAL;
> +
> +	mana_ucontext =3D rdma_udata_to_drv_context(udata, struct
> mana_ib_ucontext, ibucontext);
> +	doorbell =3D mana_ucontext->doorbell;
> +	err =3D ib_copy_validate_udata_in(udata, ucmd, reserved);
> +	if (err)
> +		return err;
> +
> +	for (i =3D 0; i < MANA_UC_QUEUE_TYPE_MAX; ++i) {
> +		err =3D mana_ib_create_queue(mdev, ucmd.queue_buf[i],
> ucmd.queue_size[i],
> +					   &qp->uc_qp.queues[i]);
> +		if (err)
> +			goto destroy_queues;
> +	}
> +
> +	err =3D mana_ib_gd_create_uc_qp(mdev, qp, attr, doorbell, flags);
> +	if (err)
> +		goto destroy_queues;
> +
> +	qp->ibqp.qp_num =3D qp-
> >uc_qp.queues[MANA_UC_RECV_QUEUE_RESPONDER].id;
> +	qp->port =3D attr->port_num;
> +
> +	for (i =3D 0; i < MANA_UC_QUEUE_TYPE_MAX; ++i)
> +		resp.queue_id[i] =3D qp->uc_qp.queues[i].id;
> +
> +	err =3D ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen)=
);
> +	if (err)
> +		goto destroy_qp;
> +
> +	err =3D mana_table_store_qp(mdev, qp);
> +	if (err)
> +		goto destroy_qp;
> +	return 0;
> +destroy_qp:
> +	mana_ib_gd_destroy_rnic_qp(mdev, qp);
> +destroy_queues:
> +	while (i-- > 0)
> +		mana_ib_destroy_queue(mdev, &qp->uc_qp.queues[i]);
> +	return err;
> +}
> +
>  static void mana_add_qp_to_cqs(struct mana_ib_qp *qp)  {
>  	struct mana_ib_cq *send_cq =3D container_of(qp->ibqp.send_cq, struct
> mana_ib_cq, ibcq); @@ -685,6 +741,8 @@ int mana_ib_create_qp(struct ib_qp
> *ibqp, struct ib_qp_init_attr *attr,
>  		return mana_ib_create_qp_raw(ibqp, ibqp->pd, attr, udata);
>  	case IB_QPT_RC:
>  		return mana_ib_create_rc_qp(ibqp, ibqp->pd, attr, udata);
> +	case IB_QPT_UC:
> +		return mana_ib_create_uc_qp(ibqp, ibqp->pd, attr, udata);
>  	case IB_QPT_UD:
>  	case IB_QPT_GSI:
>  		return mana_ib_create_ud_qp(ibqp, ibqp->pd, attr, udata); @@ -
> 766,6 +824,7 @@ int mana_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_at=
tr
> *attr,  {
>  	switch (ibqp->qp_type) {
>  	case IB_QPT_RC:
> +	case IB_QPT_UC:
>  	case IB_QPT_UD:
>  	case IB_QPT_GSI:
>  		return mana_ib_gd_modify_qp(ibqp, attr, attr_mask, udata); @@
> -849,13 +908,29 @@ static int mana_ib_destroy_rc_qp(struct mana_ib_qp *qp=
,
> struct ib_udata *udata)
>  	/* Ignore return code as there is not much we can do about it.
>  	 * The error message is printed inside.
>  	 */
> -	mana_ib_gd_destroy_rc_qp(mdev, qp);
> +	mana_ib_gd_destroy_rnic_qp(mdev, qp);
>  	for (i =3D 0; i < MANA_RC_QUEUE_TYPE_MAX; ++i)
>  		mana_ib_destroy_queue(mdev, &qp->rc_qp.queues[i]);
>=20
>  	return 0;
>  }
>=20
> +static int mana_ib_destroy_uc_qp(struct mana_ib_qp *qp, struct ib_udata
> +*udata) {
> +	struct mana_ib_dev *mdev =3D
> +		container_of(qp->ibqp.device, struct mana_ib_dev, ib_dev);
> +	int i;
> +
> +	mana_table_remove_qp(mdev, qp);
> +	/* Ignore return code as there is not much we can do about it.
> +	 * The error message is printed inside.
> +	 */
> +	mana_ib_gd_destroy_rnic_qp(mdev, qp);
> +	for (i =3D 0; i < MANA_UC_QUEUE_TYPE_MAX; ++i)
> +		mana_ib_destroy_queue(mdev, &qp->uc_qp.queues[i]);
> +	return 0;
> +}
> +
>  static int mana_ib_destroy_ud_qp(struct mana_ib_qp *qp, struct ib_udata
> *udata)  {
>  	struct mana_ib_dev *mdev =3D
> @@ -891,6 +966,8 @@ int mana_ib_destroy_qp(struct ib_qp *ibqp, struct
> ib_udata *udata)
>  		return mana_ib_destroy_qp_raw(qp, udata);
>  	case IB_QPT_RC:
>  		return mana_ib_destroy_rc_qp(qp, udata);
> +	case IB_QPT_UC:
> +		return mana_ib_destroy_uc_qp(qp, udata);
>  	case IB_QPT_UD:
>  	case IB_QPT_GSI:
>  		return mana_ib_destroy_ud_qp(qp, udata); diff --git
> a/include/uapi/rdma/mana-abi.h b/include/uapi/rdma/mana-abi.h index
> a75bf32b8..f844afb6b 100644
> --- a/include/uapi/rdma/mana-abi.h
> +++ b/include/uapi/rdma/mana-abi.h
> @@ -57,6 +57,17 @@ struct mana_ib_create_rc_qp_resp {
>  	__u32 queue_id[4];
>  };
>=20
> +struct mana_ib_create_uc_qp {
> +	__aligned_u64 queue_buf[3];
> +	__u32 queue_size[3];
> +	__u32 reserved;
> +};
> +
> +struct mana_ib_create_uc_qp_resp {
> +	__u32 queue_id[3];
> +	__u32 reserved;
> +};
> +
>  struct mana_ib_create_wq {
>  	__aligned_u64 wq_buf_addr;
>  	__u32 wq_buf_size;
> --
> 2.43.0


