Return-Path: <linux-rdma+bounces-2040-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 505C18AFCFC
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Apr 2024 01:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73E511C20CCB
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Apr 2024 23:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAE04653A;
	Tue, 23 Apr 2024 23:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GX2ZiYj0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2102.outbound.protection.outlook.com [40.107.94.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E687644C89;
	Tue, 23 Apr 2024 23:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713916742; cv=fail; b=AM+KZzjovJZg7a+sdhBbeX8rZTpnCXlnFdtpFYWiAleRjkgilXURiecmXCpdMrOzTTkn2JZin10jbZwrTD8r2gA7wtG78dF3kKb8axG4waB5KnHEHOgfH3RbwxgaaDZuAhMbQlYQo+RfUcDUmke6KcSkvjouTnc1hcRm07BIwVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713916742; c=relaxed/simple;
	bh=jhCQKmVM4i5AopTSrJCI6JVn1so1LCpJ27FALoUFoe0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mAcwDoLDNgkoh+/uNyX9vKvW3zjEnLTh3XOaYIwyhOddj4Sgjva+ZAW2hbs1PwzP83RSBwm9iy4E1rCmSYAMGrXgex8H2h8xx/9shRjkpp/89Z87bDYuEJcSMRfZvLGsOiymTI3dUGdB/jODDQOHjMOiOkntAeQv9pnLb+Yo4xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=GX2ZiYj0; arc=fail smtp.client-ip=40.107.94.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZnPWDbnGFP0MmVgDlpy1qvPNFlCobd4cjaErojbpsCEcUhj+W/0kIkaXKtJkEWcVhURv5nxq+fwRlGhEiT8hP5cFmnIj6k8USekWNljTB8XeUtc9saWVQBC+NYfjEZoimb+7RAwlWl3OiCFf5xULWXlVm4U4S0C9NLQXi6jOHAsGI8xMUkML7ZfD3KPDRvojF4j2Ye7dyaSeWqnhjhyONqbGllUcNV9PSwWGf/QFqX4jlOixH2hJd6ACABXPXeCf04YiK5xbinXggdRliMMZyph4K0fc7V6/DZAjE4uV/gKDBLLENc5q9RDJEIq5G6ybgvGEzX33HjmagGIfJhJE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzhKcb5jxe39ANGp9HzZ1i7n73EswTJNiyyM81TtXpI=;
 b=h2NfnDbpk54jJIE+i41HCbVV/pYVuEY2tAlfm4JwQexjj9YqMoNBTKEloGzOAjjK54kR66efGu06RKztbRy1kuno7Z+GGE3aavmI7DekRsYs38naI8VuMi759QUchLBpuQylEvhFSdAN52x4m5rmgyuGRiGSHsOGAmKhzzl/hKVQvf6Gku/Ij0JUjclQ9E+qYz40or5lpmDMve4k1J4oiZR6sOH9+SYLNfvnZGpHEfkBOkmAmXd8vXwyLNST64EVkRI+DvphHf7HQLTH8OTOg2+A3LCrXnUBkqiCMrEuwWKSyAarO2Gw1uJRF66Q5+kvvMfNEhTTMPYjLkQtrY8uCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzhKcb5jxe39ANGp9HzZ1i7n73EswTJNiyyM81TtXpI=;
 b=GX2ZiYj0tBybdPtIliAuQJ5XGkjSkIZ/rRT9fxHYkdzMtIcBmDqTL4COZdGzbKceoPW6fT6iS2uGJHRI+qaFNSZctNUtFqnPyMR7KS4FCtSr14M7BQEkb+co46anFcdI8EvZnWXfp0iLez2DyMUS/RWkFKUScpA59nnd8ppVAjQ=
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com (2603:10b6:a03:453::5)
 by MN0PR21MB3147.namprd21.prod.outlook.com (2603:10b6:208:37b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.8; Tue, 23 Apr
 2024 23:58:58 +0000
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::94ec:979:8364:85eb]) by SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::94ec:979:8364:85eb%4]) with mapi id 15.20.7544.006; Tue, 23 Apr 2024
 23:58:58 +0000
From: Long Li <longli@microsoft.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Leon Romanovsky
	<leon@kernel.org>, Konstantin Taranov <kotaranov@microsoft.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Ajay Sharma <sharmaajay@microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: RE: [PATCH v1 1/1] RDMA/mana_ib: Fix compilation error
Thread-Topic: [PATCH v1 1/1] RDMA/mana_ib: Fix compilation error
Thread-Index: AQHalb7bJqFYiS+FGUui+qW65pxE/rF2iM7g
Date: Tue, 23 Apr 2024 23:58:58 +0000
Message-ID:
 <SJ1PR21MB3457820A1412800CFABC6001CE112@SJ1PR21MB3457.namprd21.prod.outlook.com>
References: <20240423204258.3669706-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240423204258.3669706-1-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=80c61438-e0f6-4e5a-9fdf-41d4d15e813e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-04-23T23:58:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR21MB3457:EE_|MN0PR21MB3147:EE_
x-ms-office365-filtering-correlation-id: 08436992-9118-4f5a-0f05-08dc63f15738
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?l+duMJF1HeA9cXrKb0RnkxHMvj/A33Xx4ZH6BsQ2Q52y/KndD7Fxm/5czZkL?=
 =?us-ascii?Q?pH+W4fWc57eRsRHQGutjksmfWOyj0qmcfEsUgqxlTY8FIYwE+G1BJ8pDsqlv?=
 =?us-ascii?Q?TVqSQZjlw9cCkT5xaWgjF8+xfWs17Pg5QpEkO2dJRgkgSY6kMdL7/L0IOY9I?=
 =?us-ascii?Q?OxcuIwCKZ9Vrd8gZOCRZ2UAG6kscKf7uvtUT0AWFdbUqRFCUShxGKg1/0EKu?=
 =?us-ascii?Q?0StbcGeMi9glyinXygT+cxYHn3zOyBiej2C+OlHBwxwwLlkIJNkOZtwvfTLz?=
 =?us-ascii?Q?heCniHIPZF8lnDojc+6INyZ3bKrJ4UIKjGcq+k/WH8iHHmD6/CD8Ykxt9V1h?=
 =?us-ascii?Q?BR3oBC8ag+tgv14QtV/NgqeZoiJVEf0irqFKu1JRA4UUrrZC2S4HgBS98wFq?=
 =?us-ascii?Q?tU9deZdKenmvKSfOLorfyjohwskrt72sKPLbzOlEgjZNL0b8IuLUA2BUiRPz?=
 =?us-ascii?Q?yJ+0iC2Es+2fUtEPRk2BKcq+xOSrQ3BNqp777PmVbmGMAIoCcddi4bONRtWR?=
 =?us-ascii?Q?U49wKn4nQOXoWaY3FUICy01fQASYQ629rsdGqQSSwvABLI68ocsDQdh6NbNm?=
 =?us-ascii?Q?5EYXEP75Hw3FhUBP6httbf1kNNp675vSW1V/lAAVK4Wjj6X3t5HcPD/+/088?=
 =?us-ascii?Q?+8XuTTIi2xLWJC0T5FFw5DJJgAFbdrnLFe2/Nf4Glq9jxAQAbLv1POPsA35P?=
 =?us-ascii?Q?7xlQJgkielWAVpd5wZbwQA0XQ60Foj41reF1hTniG96CC+gEvPLUPXBXcZX9?=
 =?us-ascii?Q?+DBXz/uWbtLg3SwrLnxCYeop9Rg+Mhk2kTpvkfcPRAs/UkoRMcVLjm1YnYAC?=
 =?us-ascii?Q?AQ1nOWA4voyewGM3qquDKGUwSybG1ub+aAo1dbmrJ3NB9zKDoKCE/3urftTD?=
 =?us-ascii?Q?pQVjsnnljZnin+GfSqhsDOmVFvczSCXDALDxH37OGVr7RvhwjElGG8s4YRSb?=
 =?us-ascii?Q?3/53iYa6R9Lr1eCY1l3Mplz/Hgmd3dA93yGVxK2JIucM0Ljm0KhLrJ+kDNqi?=
 =?us-ascii?Q?tQ2CjmKtNHlYWVfetSwwOVb7M40R8rivZGmKc2E2k8Pg16MGtjUTl2CV9Haq?=
 =?us-ascii?Q?UaXC2GJLstC3+ZhnvsnZcZAq3aLWUChl7p94Xno1E+ftKaxR56gXr/Np7znf?=
 =?us-ascii?Q?3ptYCJ7uXCtmS0g2+K7Tndfvtgrovf9k4gg6wqGHc9OOJkifAhro6siZ3ib9?=
 =?us-ascii?Q?Kco9GFkYXu4rmrMETQSSrDIWDAfY9U6u9D291mZ5MSZXhAJcILKOcQtptw9D?=
 =?us-ascii?Q?UqUNWKcVug80hc+31/iM2Mpw/+HUmirpbnKgI6GytjVBnJHMKwZmyigXKVED?=
 =?us-ascii?Q?7Jr4BUDFkPWn0Uo8cHa1PR5L+6l7bchv7EUyEo03CRHJpA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR21MB3457.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YJhq4Zr3gmTAC/LYT4bbbwXXOU/pZfeK0t56PW1wl47OvGjdHsJUXoTE7BrT?=
 =?us-ascii?Q?BYahGtANoPPH0+L+2sfepxqZdz/sKVTmbr+PyA5VwuFbsx+VI92lThwy/Eaq?=
 =?us-ascii?Q?/jnqUDZmnvaF9c98bskOm3x+0m9NtY8YicV7iX0YFAvN0TQBbhzlNgPeb2dZ?=
 =?us-ascii?Q?Haz4aCHdhHzQ+1oygmvx3EzsEXkZfxLIs0subz+5ZtkG5fL6Nj28f6ETx6s0?=
 =?us-ascii?Q?gekso6nA4aihBx9KGs1kFIDtotaYH6uigJSMGtcYERq/uep+4VgJLqEpdv76?=
 =?us-ascii?Q?wJyzzQ1g23INf2Wq7jpCRTHYaaisOcVQQ6yrg+T7YIUjM18/H6yo9suXKx/b?=
 =?us-ascii?Q?s/dDMKY/P9PoFMa0RKqCpmQ19SUSF+BtP+FZOWlvdnzNldVn1xIiXV5GE15Q?=
 =?us-ascii?Q?G59VdgfvZE0EJC3l2U1QMzFmH9gndwpHfTs6LGaYhQMWM5CwOjpl41tJz3+Q?=
 =?us-ascii?Q?DliAjGfwq81fz8owInkRe1Llx2aVT2yUKBNxlYGMrjgTknJJkRPDy4jNMXs3?=
 =?us-ascii?Q?AwZeORwj1/8ulDfkAQZ3olpuXSc8qoI3SZO8IHKu6HBInjsOsOgKb3gAa9Dw?=
 =?us-ascii?Q?+AuGpAEcVHNPXZTNRq/cVN9eW5v/eM+eiOrnjslPXiXJ8TRFRHBOuhtjzxjj?=
 =?us-ascii?Q?xc7gIabi4FuVKPd4Oq2NplotM3MdKr1CJ2T1qrZHK2t9pSClrlXgSypmXwNj?=
 =?us-ascii?Q?1E9J/5qBSPkqjplPORW09AToYImaVoSkfFGvixejflbXWfkPuRpGVSLMFOMz?=
 =?us-ascii?Q?Gw7zjIgjZf0x7Ojfua8JrK6zO1dqQV6IwzYqnQM9hxwhLPF1q/S/1WOOsh4V?=
 =?us-ascii?Q?YyQt8WAvETXOGUzSEk33D1DQr64N73Uqzit7WA4SxGfFCj35g49OZB76aK4n?=
 =?us-ascii?Q?Doft2/eWGDepryt2sXNt02iAaemCoxSQhbLcK4G6pU0bRRNVJ2rCD0ZiVUcZ?=
 =?us-ascii?Q?v+F5tRfxMEdBYrQvxV2BNXIj2mbdra45ImfOgtqM1CMl4lrA5a2n2o4g5HWN?=
 =?us-ascii?Q?cxEzsXVvclGbQdekHGeOOGa+4LI1APmApAsI1I+VxqS9MlqHQfgcNBQ7e6Gt?=
 =?us-ascii?Q?QByiVk+5NzyXzg1gh5sENixrJkI3hxoqCJ7vfl8rJ0ulGHDs/kxNgr82oNLk?=
 =?us-ascii?Q?TGmUjrn8O6AfAXD0EW+SZtKpcWJgloil080IDzl/67SITYPuquqU7QqL78+k?=
 =?us-ascii?Q?1HjBwA+SQcLr6Xr8pKKBAS05kao1hxDgymq0032yp0S2w7AoCZZSe2Nki3Ja?=
 =?us-ascii?Q?FwlkYaL+foCgUeDZEhYXxUZ3A16J2Tnp5cI+xGg5+5ZVvGWpuLbxClaBIQ2a?=
 =?us-ascii?Q?Ui+qmqs0g5D2xEYvYEnnZXam+2aPT5gemIBC/ZINKCfWCPJxBzc1WBWroPDR?=
 =?us-ascii?Q?x4mv65s+CUfzwUVB6rQNl90gu4miU0m3V82P5fhMAYUn2xrmDy/LvSvYPRdv?=
 =?us-ascii?Q?99sw+ui1+X4lwf1qOqmwarCI7IojcYH3jQWUG+5AM5UFB0E5MWgmCPxtK44S?=
 =?us-ascii?Q?B95Mq1TcU60kVK2f5MUUU0D+d8El64G+yS89E6nOp5Nh0sseU+dQYVEKXDsL?=
 =?us-ascii?Q?gvTcicYfcADxPd3gsb6GqlrtvE9P+tSJxHjMdObNLPKQ9YTr30a557pP7M+y?=
 =?us-ascii?Q?T5NK88DBhlYhtlfCaxJnpoLxBb9nnkQKekqjp4Ql1cgI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 08436992-9118-4f5a-0f05-08dc63f15738
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 23:58:58.1078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NPAWVklHqwYZxwTzdNJjQ8IIPAwIp+dZCSEbeYk+Ulj4KnToFrOKAAbsXRxLtKBZG/D6NYaBtJxA0tdGgsfigA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3147

> Subject: [PATCH v1 1/1] RDMA/mana_ib: Fix compilation error
>=20
> The compilation with CONFIG_WERROR=3Dy is broken:
>=20
> .../hw/mana/device.c:88:6: error: variable 'ret' is used uninitialized wh=
enever
> 'if' condition is true [-Werror,-Wsometimes-uninitialized]
> 	if (!upper_ndev) {
> 	    ^~~~~~~~~~~
>=20
> Fix this by assigning the ret to -ENODEV in respective condition.
>=20
> Fixes: 8b184e4f1c32 ("RDMA/mana_ib: Enable RoCE on port 1")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/infiniband/hw/mana/device.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/infiniband/hw/mana/device.c
> b/drivers/infiniband/hw/mana/device.c
> index fca4d0d85c64..4c45f8681e7f 100644
> --- a/drivers/infiniband/hw/mana/device.c
> +++ b/drivers/infiniband/hw/mana/device.c
> @@ -88,6 +88,7 @@ static int mana_ib_probe(struct auxiliary_device *adev,
>  	if (!upper_ndev) {
>  		rcu_read_unlock();
>  		ibdev_err(&dev->ib_dev, "Failed to get master netdev");
> +		ret =3D -ENODEV;
>  		goto free_ib_device;
>  	}
>  	ether_addr_copy(mac_addr, upper_ndev->dev_addr);
> --
> 2.43.0.rc1.1336.g36b5255a03ac


