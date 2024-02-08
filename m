Return-Path: <linux-rdma+bounces-981-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A9484E7D4
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Feb 2024 19:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 577111F2AA61
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Feb 2024 18:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E3D1F951;
	Thu,  8 Feb 2024 18:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hHecztms"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2113.outbound.protection.outlook.com [40.107.220.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB6B20300;
	Thu,  8 Feb 2024 18:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707417777; cv=fail; b=T4VLsE8SCkt8hGmggsbEHsgZsigP1CTpjS7M2RZoApA6soy8GNFU2w59Jpc+3yiaiLylWIib8kosKYnk1dVQeEuL09wpaNcWS738qgeRnJz8WyWMuBwXfNABpohgJ2unnq5236H39RUBKm8dmb0Gjs43Lv5Qdyt7+DOEZPcDtbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707417777; c=relaxed/simple;
	bh=oYwmn6/+fRCdfJNjN5ga5DehitKURWNRh+9Mq+n5PbU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sqDujkP4VyvyoxFs+e7fZROszOvcM84ZHyoDKMF6E66J9ZyyWvlbWOQjaAuTLyJrLj/lSJUnDVjmfrl1ITp6nkbFWkZNcAH/eXmNWaiGG2JxcDUNzF1PxfmXhM2GMSrGYk5n47vHL6vnh8zQ7BYuW4Z13fyqAHiY7Zpdd/512V4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=hHecztms; arc=fail smtp.client-ip=40.107.220.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFy3PNqUzLYscMIc4b5ahRsvkHr9BCdTJX4p5SHogiz248q1Jp9+am88EqUHGr6YX54DDb2tppVSzzjBNaaB/WSd9qGzkKaRJbhzf9jhBGc8FWqxRm3aIX0QWI+8E5YCpTLJ/r0TP/b+aSCKjIbQECSCqio8F6aLAjE1BRGB3pTmQXjxChTRfa0VH6K4R+q5SuJ9TNVdnkRHB6VMpRvxtlCTEkHG+Ep0Fi3IetccE/nCBVw1jKS/l46tk0eN/YywH+BcH4BbQFoHFGqMWT6LraMvpfECbQiLC3rrSuTvjIUcyiyaW8vnLX/m4BTn2ddulVlEF1dItIPnOTS/hn9xhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zj2VrxtOogWcAB0yawO1xLzE598q65Rh2YXo+a0CRNc=;
 b=mlrG4pbkzHCAKOkh7n3lO2EJMKNFWuT9I+c+q7JhlURT4diZwJmg6+Pw5W5qe3cOH1JCRWdDMc22HwLygi2nlQX3vBlN36v4UAOUv0ykL0WMpbYypFQvUbNLAz7eY308VGCrVgLCQ8VlKox1PTGTrpd2tMGMnbeIpuw56hC1jbv7ByP9gTS3iMFpivwNDBXHD0YDeoyVpF50RhXWNk4f31eoCHnNKUYxsx/xXzBiag8ETSQo4YDlvUrpWZS0SXvkBjNpGMw1YUQaY3hkbzRJkprK8FxGzxUQZgNWqHwygXTvrSi0CiBUjlef4gKfWyVyxSvU9TTEWCY4G/fzgt7oUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zj2VrxtOogWcAB0yawO1xLzE598q65Rh2YXo+a0CRNc=;
 b=hHecztmsDxm2/DuaNyiN75LrzzSlZcPVgLd2xH5YpqBeJBKg32vvRUjbGJOBqcNh1P0M1hufcMNkikCDQC/vtiTvMtWDZmxudCXuf1tkrpupkQg9LVsv5C8WSxTqDhC5KRCEZTBKmW3u9HOB2Yhjpd6z3vwB1WVGcLwhBAD5vJ4=
Received: from PH7PR21MB3263.namprd21.prod.outlook.com (2603:10b6:510:1db::16)
 by CY5PR21MB3687.namprd21.prod.outlook.com (2603:10b6:930:2b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.7; Thu, 8 Feb
 2024 18:42:51 +0000
Received: from PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::38ce:7072:976c:bb15]) by PH7PR21MB3263.namprd21.prod.outlook.com
 ([fe80::38ce:7072:976c:bb15%3]) with mapi id 15.20.7292.001; Thu, 8 Feb 2024
 18:42:51 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next v1 1/1] RDMA/mana_ib: Fix bug in creation of dma
 regions
Thread-Topic: [PATCH rdma-next v1 1/1] RDMA/mana_ib: Fix bug in creation of
 dma regions
Thread-Index: AQHaWdeqNtbLWJ8n+0aIBnpvWAnAXLEAyQjw
Date: Thu, 8 Feb 2024 18:42:51 +0000
Message-ID:
 <PH7PR21MB326394A06EF49FF286D57B63CE442@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <1707318566-3141-1-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1707318566-3141-1-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=289b4371-128b-4703-b0ba-3eec5406477d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-02-08T18:40:59Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3263:EE_|CY5PR21MB3687:EE_
x-ms-office365-filtering-correlation-id: e6f7fc88-317d-4c45-f247-08dc28d5c120
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 38A+9hiKTHMfqX7ZPXOAWu6M5qoopULZW6TgYSzSuiAeap0HkANET76rjzI7WMPruKZXSKG2pJdZN61qBtnD6bausGYqHwgy2tvD909BwX5bj2DC6fEfhb9RHnEfjcWu/k8IkZZQ0IvKHR//mYVP0ZAbOhTmqxa/wG6XgSayGUAysS2IItdAnUyBpwc2O1gQt37ybqhoxTPs+Ucky5A4azCjOU2dk/Pupy6d3mGILGhaEv38AflnB0oXcK2usxbxE7CF7dOXXcgUfVK6ijEl1ytt1fjnBWYtoW/NHkoMEf/ghLz/S1BRkvX2424zup3VBLrWC3Jy9sbuEL3c0g6fzzDGr86p2SzMXXuZ4+4LqIZCVzX8Iqf1zQFYG7mboeAf2FFdIoTega49N58JOGt5KCAhan7iwzF0TEvtDq4CQqXooTji1c8hFovqeogRg7e8cu5vwTGB8SoEl6e7Bhg2ReE3DwUAbfW0Kg46cYOXWljxh2zm04f0iq4ZY6lhfHLRXK9SI1j4gkRujYs/KEApIAZONDaF0NSvtG4JQ28p1Utn478BA6Ph41Ss5NBxCt2qEQyRNVPw5dgtpESGR2W31wDhaK3Ei7vWMvQFxW+T+3Gj7ozDDAoBpMPu0ogc6Yth
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3263.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(136003)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(2906002)(55016003)(4744005)(5660300002)(86362001)(41300700001)(122000001)(38100700002)(9686003)(8990500004)(7696005)(33656002)(54906003)(6506007)(110136005)(71200400001)(10290500003)(66946007)(478600001)(66476007)(316002)(26005)(82960400001)(66446008)(52536014)(66556008)(82950400001)(4326008)(8936002)(64756008)(8676002)(76116006)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Dg8s1/Nmt2r4/0WnZKB/aOL1mCx4cMqaOinFzqyB2VlQ9N0l6KtiRj/Go55W?=
 =?us-ascii?Q?6n8bUISP2zoD1nu16FZGwo+XYMtazgAaAKqeFwE5IBD3bxpkSKa5OUygTJXW?=
 =?us-ascii?Q?A9pdhuqLntUq0Y/9+VCq1su/AOJkzxJ+ZYiQZgIfKbvTZoJ+eXh/76gd8/xX?=
 =?us-ascii?Q?kzUojhh/stIHZQ2+Ccpw8/xILOsPfMQkq07TS1hQ5JYGnMioacG5JSUJEQ3K?=
 =?us-ascii?Q?7qnAdVgZwAV7+n+Jfd/37JOutAbpEZZF4TSqpTQ4Mg56570tSWoup+mR7DHs?=
 =?us-ascii?Q?i/paQp52PT7OGhoW7qEr/HCZKyLNs+uEg6SdhQ0qaG8UJ8fA1zordUQ5A9O6?=
 =?us-ascii?Q?Bti4dZAACvF8an7Od9UC1CxkdQMAVp3zj9Z+aghEROi59MKyYPVtRmDBqIQP?=
 =?us-ascii?Q?CxNTJAoAs3pffsXTIN4YLODH6CvlR7wBAxorsLndGWq94qoldQFXSm6wnDN+?=
 =?us-ascii?Q?qVdWOm4YUBApWAJLyhqFQdSIqLVEZ90U9RhMEAycl/e8393kOk/X+Y0t5+c2?=
 =?us-ascii?Q?EV0ysRp4f2CP49gvS8hQByp2vulboDjNxNsNGGeZO9IOYfglfkh1Ltug1jvx?=
 =?us-ascii?Q?wF+IHS6RqoHSoLTIU/UrNrFveRzlA9x97UvNdPdb54Gw2G7FMRyGAZ9NHynL?=
 =?us-ascii?Q?tWAA8qaYgw8oDFKXIGnQQZz1/RNt2l3bd3KG19EVciOs3GNaNSM6YhU4DlCA?=
 =?us-ascii?Q?NMZBrZWGCnWTAy8qhP2YLl4e3lLdMhX1eZ6Tgf1LIdYiio9W98UGEk3YXDmS?=
 =?us-ascii?Q?414duLo1Qmf2WzEnkjfIsSTTV5eLLnueTP9LFi0qLU1fOnRi159NHiXWNw93?=
 =?us-ascii?Q?1Ub+BDyylIhCHy5dMnBjK08UNaUB/mK45qokDXcWz4t6KxcrQevz7sxqKZrB?=
 =?us-ascii?Q?nPdbFcFU5DtXUKu1mm1qnFJvZpvCQpiW0OhN6odj/RRIUhciwzDn4mlhIMxT?=
 =?us-ascii?Q?a4Q4XnX3szbKhHfrb4Pd6LdPV/VUfE499HLNe+m5CQjivvsCwUDB83uzUMYO?=
 =?us-ascii?Q?NXIGkg3Ek/OlcyPkgNfgS7Za2URXmWUdYAy5SE7dsTcbj9xyBxxKXdtEXs/r?=
 =?us-ascii?Q?Da/Qpo7WzmWXF2S2jbd7Qv1f/qY8OoFehSmvQXVycC+ARePvGxC2j77qIG1s?=
 =?us-ascii?Q?zR7ogpTFBpav6l066xtvo3hyMkwu05+NbrNXz08eyvV4IdfLmbRjl09JpNtg?=
 =?us-ascii?Q?I6b6lZQNVB1FFhSYGP/Dq2CgwAAgPjq/ehz9cyucekTXZC2FA1H4S/eaNizN?=
 =?us-ascii?Q?dvTkVpBGruzO/oumTgGa/m5HXdaa5s0XykG2E1kzO6sgawfienKYmS3Nbw81?=
 =?us-ascii?Q?20l1IYn4V+p8Mf65yNapKkVVvdoI1pjiU96eM5cPFk78c4cKho66lqJK+M15?=
 =?us-ascii?Q?NzFog68mA9p/r9Ecl2gl+qlTbB8y0hgGuGwJskgOZgX/krwKObT+vexjHxqh?=
 =?us-ascii?Q?qk3YFfxpeKutlaaOYEMTLtLu3sb2LyuUzjGMf8QERxTaLz8NvNMU21BDxjFI?=
 =?us-ascii?Q?xaMFKH5DSTTqM848DpoACVCfTKfqPvJRZ2yAIbMniBStqXblRogaU2EMtlih?=
 =?us-ascii?Q?H1lddWDDpOjdG7kGpNVe1EqbNKO1ZzWW6iVgnaYF?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3263.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f7fc88-317d-4c45-f247-08dc28d5c120
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 18:42:51.2523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DBsMKUzIWNwScn9kz3SntSXtFBR8lGWVCYTjVwT3VFIeVfERWhV/9rO6/kTV9aZwbWjvxOy1JY3WLvKvPvMYEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3687

>=20
>  	/* Hardware requires dma region to align to chosen page size */
> -	page_sz =3D ib_umem_find_best_pgsz(umem, PAGE_SZ_BM, 0);
> +	page_sz =3D ib_umem_find_best_pgsz(umem, PAGE_SZ_BM, virt);
>  	if (!page_sz) {
>  		ibdev_dbg(&dev->ib_dev, "failed to find page size.\n");
>  		return -ENOMEM;
>  	}

How about doing:
page_sz =3D ib_umem_find_best_pgsz(umem, PAGE_SZ_BM, force_zero_offset  ? 0=
 : virt);

Will this work? This can get rid of the following while loop.

> +
> +	if (force_zero_offset) {
> +		while (ib_umem_dma_offset(umem, page_sz) && page_sz >
> PAGE_SIZE)
> +			page_sz /=3D 2;
> +		if (ib_umem_dma_offset(umem, page_sz) !=3D 0) {
> +			ibdev_dbg(&dev->ib_dev, "failed to find page size to
> force zero offset.\n");
> +			return -ENOMEM;
> +		}
> +	}
> +

