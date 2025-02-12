Return-Path: <linux-rdma+bounces-7689-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A802BA330A6
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 21:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54B79167DE8
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 20:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3292010EF;
	Wed, 12 Feb 2025 20:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="D1YEW6WT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2132.outbound.protection.outlook.com [40.107.101.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA63E200B99;
	Wed, 12 Feb 2025 20:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739391645; cv=fail; b=QKEN4rSyCUKpGGsBmxMky6CpYs8BpTWC1HCPoYek7sI2+9xIEph5pK++5jgGTgZev4MGJD1OuRWIDPK5MvQ6zeuBMhod6hJwG6YmlW81qCw9vkaneCxUpRzdZ6oMN9pNNCWaUY+VmAspKvCro+ascOpEHSj2Wezv1GYm3Wy1Vlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739391645; c=relaxed/simple;
	bh=H0q1gqjpq5ftG9oNiVtNG8402zEULijBm5AoRSSMDZo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QqyIae4+nqfA90JmrqsB6lzPC9nbjf/x0p6MBkYVaBGY9WH4Evk1kIXU+CoTkKxUBnlH+vjucugcSlDPQOg5M8h4V/0i/yWEhFpshGcjXZe9ScF8qVulK3dA80CvrLY+a3dKjqfmt34ba2XPji/XZTIiC9Xt6rLcSMLoIA60zfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=D1YEW6WT; arc=fail smtp.client-ip=40.107.101.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=prHEvTBibJkcaFcoaXFYb0tsG7aIiFHT7lG+UkWZpGLO9W3h2JlG83wqUYxFjWYVlF21JqzjuEqCA3sREOFpLm+5+daLKicug9/i7J/oGCe5kFQg5iv2bumETW5BBJe1+NTGgahMPLoDO2s0qJ4s9q1z2D+C8fGC7ECrTxANxakYGhAmcoPO2lPYbbY/woZ0H5QMULNJ6KIvUahI80pf2zBzBKWojWt3c1aXeVFzLEQaCzZDNI9pSOWtGM1EsWwQWtYbRUOvMk1A5LAx9YS1jsPXEYPDa8SVJuQdbQi3gDuXfZS2uJ9v6IRCTaJ4z7pw2BS6iuCxb8C2nn3dyP1BNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8TrHz82mz9XjnKaKVYnOWoYP/vAanv9vKugefC9Fq4=;
 b=BTRQy2QAjDKxZxC9K2GnqVgVwLOJSxflJq0+Lv7EWZ1Qqe3EmBCKbGvbU6Xd33IVAKYjVi2UNqV/jNQZiiNylvP1ff7v/WN0qav4K5kD6ULiJQ0JL3rYVSnP92aC9tNtdpNxxn5X4luMI/2lP0GnMybLn5Xmtam9Ar7dS04TbP+qBOp6HfYOhp+EPg5O5SPe01du8aRhljRs6gbWIZt7GXtuL/2mizISsm9KHaOd8n8Zx1JZVGU2zYU60KjGF6u7pTV52VzgB+vhYsZhW5y9ug6IRzv3maQyJrCJB1e4574F0BlYVOd2HiZgpGXftCN3GRm2o05DuXyMHirBGmsUPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8TrHz82mz9XjnKaKVYnOWoYP/vAanv9vKugefC9Fq4=;
 b=D1YEW6WTmGy+SSpow5Mey6HErUNVbZ0Nsv/L6l7dUIAeCOazFdSkL581Jt2SOyPSjcN8Y1MyiEqYknFvyqPu12kYA66V7NDcneD8305i6Y7CU4qiSbpjNZF1qQlFbXMHs6y7L5qYHy2resvB6FHpHwalbTG2/qkokS9ZN2n1VkM=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by DM4PR21MB3780.namprd21.prod.outlook.com (2603:10b6:8:a9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.4; Wed, 12 Feb
 2025 20:20:41 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%4]) with mapi id 15.20.8466.004; Wed, 12 Feb 2025
 20:20:41 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, Shiraz Saleem <shirazsaleem@microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH next 1/1] RDMA/mana_ib: implement reg_user_mr_dmabuf
Thread-Topic: [PATCH next 1/1] RDMA/mana_ib: implement reg_user_mr_dmabuf
Thread-Index: AQHbe6D1geN4FyJSdEaAsKOCuYPG/rNEH9Jg
Date: Wed, 12 Feb 2025 20:20:40 +0000
Message-ID:
 <SA6PR21MB423131E4D0225E43AB27E01ACEFC2@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1739180908-2833-1-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1739180908-2833-1-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=07bbfdf3-ce4a-40c2-9c8c-e22d619a5064;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-02-12T20:20:20Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|DM4PR21MB3780:EE_
x-ms-office365-filtering-correlation-id: 7b850558-26eb-43be-661c-08dd4ba2b89a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?BydTY0JmMIvAn9mUhJx29BXzvISNUnU5Ec9+2Pvg50HmLhXSCFttc9M1yxRb?=
 =?us-ascii?Q?Z3ZNCUGuXIbgvfCyaQ5oKu/qW+7qZWwg1CUm7sV3+z9+VYlIBhWaPlQGZGNN?=
 =?us-ascii?Q?KKMCrehBQn1lOF1LTxriALjO+N5FWT98ANvICLpfKxu16DZFP2Rkp1Q/N39G?=
 =?us-ascii?Q?MHcIywppBwJZOFedVEDvjJBdX8EjqNFbttL7uwNVLhz11ScG/mGtsXoT7Nok?=
 =?us-ascii?Q?1UWU7DI2IhPC/5daRI8WeUm4qvybv4yLapYOFcnhiRWQ+WaysQ04CLj+D6n1?=
 =?us-ascii?Q?O/JIa2uEULGslegFpmzv86irrgpLgvAbrJFw0ZrXGLqXJ8vrodc830Husyyd?=
 =?us-ascii?Q?EgbSk0otnwGJg7nxyi9RsVEs3meywaAYjPg1SN/JpMDAzdFP7+cBGejI8aQ9?=
 =?us-ascii?Q?SGO3PpmG6K1BvCCM9ra6q7klPG5YweNyT6pk+db9TSyMSMCCUlqH6VXGX1li?=
 =?us-ascii?Q?nF2/73bVaHjrqbKPRVIGv3GRjmAb5N5Ez+88m6M4mr3+oPw/uv+RfmK4mCu5?=
 =?us-ascii?Q?SC86F2fuxNgYxHS7oXymZc+cB65az2lTFrzGInrm62JIXDza843SXdw6Ggqb?=
 =?us-ascii?Q?IDlHv3qanUtz9M3sfQqPlPkcdRD1qnNTirjIyTuV5wr7kB0iMag1/79o4vwx?=
 =?us-ascii?Q?i6htBZMenzCK2wUFKLe+QJPbC0lwuIRRPlgVJ10G2t4Dx492rahKrVeel3rV?=
 =?us-ascii?Q?a25nwrs+lS5SeFXKhYqfqhmViYDa+YHoSF9w116KZkGdBlx87FrvZcwZeOP0?=
 =?us-ascii?Q?p5stm73XHOqKABai0JLq3Vpbdp9T4m23ql6NcZEYPMRP+YhWDKBmBZPLF1Nu?=
 =?us-ascii?Q?Y+axYBNuqcNqvZQ4cdN6yQ6Oj83jhq8cmDb+6fGJMd53rg4B92QGjjtYEIdE?=
 =?us-ascii?Q?/wH5VYPR3dyb7995IXLAz/CIcHGaNXUSp8YCfE1uladm7NvcXR5VGt9MeInW?=
 =?us-ascii?Q?oZ6nlY7bSGKApL1p2zxEt7YQiumxkEHD5luaU3tBqvK0SjswDkC1gbokfSii?=
 =?us-ascii?Q?T8ugffJi6urt7ok96dWstXqcGU1LJucDgN+8fXiZK2R/xHCoDT/vaNVmrC/8?=
 =?us-ascii?Q?EFOu+fgImpmhHAQ8zKtBcftYBSIPmrEJpSkrMx+gPzswclrZ+cCZhjePJ6c/?=
 =?us-ascii?Q?SMajGw2xj6q3p1i8F+iK3HFWKxq4m2+uXjulmKabS+uD2GZH+uiCVpa3XvPc?=
 =?us-ascii?Q?ExKZY+q+DamtWj/1eDZyzz1tiWtkBi4glYw7XqG0vR4/i9CwuVpPSxwODgNw?=
 =?us-ascii?Q?hows/pnL6HYzBeKxOynm82FdQG/nTl1gdWNWkeWeVp6dD0VgptdAxUrL4qj/?=
 =?us-ascii?Q?T3SGNLOwUK7i0DfwboEwb4uZCu7UI0p/X2c8v/ZOWtg3q1WsUupYT/s2y9uD?=
 =?us-ascii?Q?WTILv/SiLj1OinM1aPY9kqgB5dg7s9i58fFE1udYGbn6M6f219B0gsS6nz98?=
 =?us-ascii?Q?iE1V/vwIYIfRe31kvHIZmSSTyrXlLhzp?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+2hkHOO8LTi13vnKTTVsAqlqxRwfX4ycLw6y6VEix8T+Qef0qRuCyuQd2RL8?=
 =?us-ascii?Q?zZ+0wNwpDlNenILrrCRaojF6QOohydpXknGQTwJAOmpewqBdufbphRLomSCT?=
 =?us-ascii?Q?5VhaR302tC8XAbg7KrAc0iUl5ayEz1mXtHGEBlNHepauF0vNF7pi1KClMSIJ?=
 =?us-ascii?Q?+CvVrgv6sj5+yd5pXjvZYdytsjnnDwx5PE3tvZ5kvPxqlWAVbF72WDymncb6?=
 =?us-ascii?Q?TIzkBrLsJpmMSGVkKoHl5VVxpZm9FvHYjRPlC+m5BO8vF1QjVJArtZJzBQKJ?=
 =?us-ascii?Q?TDEIyGsJDyXSDQe98tKeGwZsTuDYNNcgCC+/LgSF9eLT+7AF3YEd5+VnKzoY?=
 =?us-ascii?Q?H8yQgxWcEZQ/VjqHmICmPzch6ByyMXMu26cXc+XtPSR7XOafmkB5v+icPD03?=
 =?us-ascii?Q?8gxdupSFt1reA3aoWv1TaVslhqgtgIA0LfCz6bhmWBn1pdtAL7SAnD9pvyCL?=
 =?us-ascii?Q?8STyc7DQnzmt/kwOgpRA3PxiW56B98K6bokXotXcMSdhGCb5WWpzdfS/Ogfe?=
 =?us-ascii?Q?jNFQwWuJGGXZ9HHZt4O6BALk8QOvHjYOWMWW1EoHjvq/iD0PkQOxT1xNLz55?=
 =?us-ascii?Q?SVzfGhWxdQhGpMy+ED7PlhZxGWROmnnvZfVUGVYE+le9Z0v/Rjtm9TAUh1ck?=
 =?us-ascii?Q?oIxkfql1QxRBtpi+MH3Wi3yXbNUE4pe2NtV+RiuOOTmOtq/XvpL4KlecnauP?=
 =?us-ascii?Q?cbC+vneCFiKCodNmL1tHtnd8v/J/IJrCdotmxuhT9q0pcuXNiDxJvGng+Q+f?=
 =?us-ascii?Q?fic1hU7HL7Sx8vAxzAiM/EIvCmejPsu3JBSGKDyh2TRVyMQdqYzM6v5omPwu?=
 =?us-ascii?Q?ISCwmClR73Cj1HFd5cSlSxemopUYZiDvBHAoAwluBKITPLvrLAlr8gy5Sd1e?=
 =?us-ascii?Q?2kLYpY3OKoREWosD0NAaTXdAWrr7ciu/jgI6ahTLjrs4urNvX3l63lkHhFIG?=
 =?us-ascii?Q?rx6DhkctP2dnRym1k9jBpTfIRI+KIOkF7tMsEReFXiJw6xCqRougaM1nKSXH?=
 =?us-ascii?Q?OxUkT1csRhLVXldsQLGvsE21RAEmwf6HIeXEzTZBPBSZjcdcJkN0lLkN25DO?=
 =?us-ascii?Q?9EOHo4F+f9EDZibacBSScD5hMNCCb9dQZEfdrkUjRJ31DDWODdtTIiwW6kDV?=
 =?us-ascii?Q?zF7R9LTpZOHn1Mqkc69RY1HzJuGafRHIGd+fmgCV+UHE5TxPMCb3iyIKid7R?=
 =?us-ascii?Q?D+eeRUUTlHSkIarbKLreKhXiUaRRe3PliH9VGZRPES+dBOAXDeJ2D2/GKZCW?=
 =?us-ascii?Q?bIjOiBQ0efBEI27ggbVRpVWsE+k/X0ZrRJJe00ibWMvrbSfRmCTELpZ27v+p?=
 =?us-ascii?Q?eJ4GMgQ5QuGSVs390qK0NAXcYCw8Uztd5/iBHxP/gBEJWoGhkBTdlH9eRkQI?=
 =?us-ascii?Q?JLZidr7/G8w+U6wfuY0dhQ0Ie4hPLvIyQyz0f7J2IvllXTNZTUqkJFEJY3XB?=
 =?us-ascii?Q?h99P0HLreJMkx3josNMgZ1nvhhkDwiUrKEd26p/BWlSEqcKlQ9aE9gO6Aihm?=
 =?us-ascii?Q?3zrb30sEuePSKbo0jSDp76+ntVAKbBshctimMr+Eszqx0xwhEwzeZ63cg6F0?=
 =?us-ascii?Q?3qCE5h03j+wB9V9XwMUdsvqA3lyTpz6xjI/jI6czUCMrs3laVRk0vsS3FEyB?=
 =?us-ascii?Q?SAIljtuu/mopiknxXmX0ZhDBwWkcs259b/M9dSsub0Zl?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b850558-26eb-43be-661c-08dd4ba2b89a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 20:20:40.9990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dHgitmT5Yr7WqhK1wY85Bw1irPabBTJK54tdZQKWsMFFqQEnNwwWKI05sJJT4pvzCZdCbLxZgVfILkPVXLXGqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3780

> Subject: [PATCH next 1/1] RDMA/mana_ib: implement reg_user_mr_dmabuf
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Add support of dmabuf MRs to mana_ib.
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/infiniband/hw/mana/device.c  |  1 +
> drivers/infiniband/hw/mana/mana_ib.h |  4 ++
>  drivers/infiniband/hw/mana/mr.c      | 77 ++++++++++++++++++++++++++++
>  3 files changed, 82 insertions(+)
>=20
> diff --git a/drivers/infiniband/hw/mana/device.c
> b/drivers/infiniband/hw/mana/device.c
> index cb8941a..34973ca 100644
> --- a/drivers/infiniband/hw/mana/device.c
> +++ b/drivers/infiniband/hw/mana/device.c
> @@ -48,6 +48,7 @@ static const struct ib_device_ops mana_ib_dev_ops =3D {
>  	.query_pkey =3D mana_ib_query_pkey,
>  	.query_port =3D mana_ib_query_port,
>  	.reg_user_mr =3D mana_ib_reg_user_mr,
> +	.reg_user_mr_dmabuf =3D mana_ib_reg_user_mr_dmabuf,
>  	.req_notify_cq =3D mana_ib_arm_cq,
>=20
>  	INIT_RDMA_OBJ_SIZE(ib_ah, mana_ib_ah, ibah), diff --git
> a/drivers/infiniband/hw/mana/mana_ib.h
> b/drivers/infiniband/hw/mana/mana_ib.h
> index 9eaf983..bd47b7f 100644
> --- a/drivers/infiniband/hw/mana/mana_ib.h
> +++ b/drivers/infiniband/hw/mana/mana_ib.h
> @@ -699,4 +699,8 @@ int mana_ib_post_send(struct ib_qp *ibqp, const struc=
t
> ib_send_wr *wr,
>=20
>  int mana_ib_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *w=
c);  int
> mana_ib_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags);
> +
> +struct ib_mr *mana_ib_reg_user_mr_dmabuf(struct ib_pd *ibpd, u64 start, =
u64
> length,
> +					 u64 iova, int fd, int mr_access_flags,
> +					 struct uverbs_attr_bundle *attrs);
>  #endif
> diff --git a/drivers/infiniband/hw/mana/mr.c b/drivers/infiniband/hw/mana=
/mr.c
> index ac3041f..7a71607 100644
> --- a/drivers/infiniband/hw/mana/mr.c
> +++ b/drivers/infiniband/hw/mana/mr.c
> @@ -186,6 +186,83 @@ err_free:
>  	return ERR_PTR(err);
>  }
>=20
> +struct ib_mr *mana_ib_reg_user_mr_dmabuf(struct ib_pd *ibpd, u64 start, =
u64
> length,
> +					 u64 iova, int fd, int access_flags,
> +					 struct uverbs_attr_bundle *attrs) {
> +	struct mana_ib_pd *pd =3D container_of(ibpd, struct mana_ib_pd, ibpd);
> +	struct gdma_create_mr_params mr_params =3D {};
> +	struct ib_device *ibdev =3D ibpd->device;
> +	struct ib_umem_dmabuf *umem_dmabuf;
> +	struct mana_ib_dev *dev;
> +	struct mana_ib_mr *mr;
> +	u64 dma_region_handle;
> +	int err;
> +
> +	dev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> +
> +	ibdev_dbg(ibdev,
> +		  "dmabuf 0x%llx, iova 0x%llx length 0x%llx access_flags 0x%x",
> +		  start, iova, length, access_flags);
> +
> +	access_flags &=3D ~IB_ACCESS_OPTIONAL;
> +	if (access_flags & ~VALID_MR_FLAGS)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	mr =3D kzalloc(sizeof(*mr), GFP_KERNEL);
> +	if (!mr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	umem_dmabuf =3D ib_umem_dmabuf_get_pinned(ibdev, start, length, fd,
> access_flags);
> +	if (IS_ERR(umem_dmabuf)) {
> +		err =3D PTR_ERR(umem_dmabuf);
> +		ibdev_dbg(ibdev, "Failed to get dmabuf umem, %d\n", err);
> +		goto err_free;
> +	}
> +
> +	mr->umem =3D &umem_dmabuf->umem;
> +
> +	err =3D mana_ib_create_dma_region(dev, mr->umem,
> &dma_region_handle, iova);
> +	if (err) {
> +		ibdev_dbg(ibdev, "Failed create dma region for user-mr, %d\n",
> +			  err);
> +		goto err_umem;
> +	}
> +
> +	ibdev_dbg(ibdev,
> +		  "created dma region for user-mr 0x%llx\n",
> +		  dma_region_handle);
> +
> +	mr_params.pd_handle =3D pd->pd_handle;
> +	mr_params.mr_type =3D GDMA_MR_TYPE_GVA;
> +	mr_params.gva.dma_region_handle =3D dma_region_handle;
> +	mr_params.gva.virtual_address =3D iova;
> +	mr_params.gva.access_flags =3D
> +		mana_ib_verbs_to_gdma_access_flags(access_flags);
> +
> +	err =3D mana_ib_gd_create_mr(dev, mr, &mr_params);
> +	if (err)
> +		goto err_dma_region;
> +
> +	/*
> +	 * There is no need to keep track of dma_region_handle after MR is
> +	 * successfully created. The dma_region_handle is tracked in the PF
> +	 * as part of the lifecycle of this MR.
> +	 */
> +
> +	return &mr->ibmr;
> +
> +err_dma_region:
> +	mana_gd_destroy_dma_region(mdev_to_gc(dev), dma_region_handle);
> +
> +err_umem:
> +	ib_umem_release(mr->umem);
> +
> +err_free:
> +	kfree(mr);
> +	return ERR_PTR(err);
> +}
> +
>  struct ib_mr *mana_ib_get_dma_mr(struct ib_pd *ibpd, int access_flags)  =
{
>  	struct mana_ib_pd *pd =3D container_of(ibpd, struct mana_ib_pd, ibpd);
> --
> 2.43.0


