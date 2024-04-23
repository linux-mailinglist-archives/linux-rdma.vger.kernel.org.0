Return-Path: <linux-rdma+bounces-2038-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDB48AFCCC
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Apr 2024 01:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1C16283047
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Apr 2024 23:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F5F405FB;
	Tue, 23 Apr 2024 23:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="S1DrA+Re"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2097.outbound.protection.outlook.com [40.107.94.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852DB367;
	Tue, 23 Apr 2024 23:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713915938; cv=fail; b=U0UKBPV7u6LWXTghrE7KCr6IVQn/3B4z5q0YN7sIXgCBxkHx/QMWikUY37gkSQa84BOdWAo11c3YSvcHU+pRaaIJk4aPivqLEPyYWzWu48+7gk/jq03noy9XHX3krRqfqL0TZe+B6ToBdDEGYu6Zc0X8wZ4QYs90u7hKA5Urhw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713915938; c=relaxed/simple;
	bh=Fz2unADDAzAeggQ0AvZAShF8XZ7HD3CtKz7TzMBJ8Kk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LMg4I65Cls/FGHpgTjMlISeBV/dfGfqwu8cd9v7+cCfq2O827fE5Z6sHjRrYhxp2k6R8KVuDgMHcZochO3zgJ4EWXsbhUFbjARU72HpTaKFWE5zvq/xXE7SDVInnt42txfUrnY+/pKMfJTT+E+ELsMeZMoZ55hOdaJZ78LAZ178=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=S1DrA+Re; arc=fail smtp.client-ip=40.107.94.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONcgdab6H/eOv87JrL/TeAJmDE3lPbIKCNTBWLUIK4hp8XU3X8UidmkwqYvcm5njW2yOVWhkiOwFbH747sXUCgy9NZu6fgCTq8f2tFDO5D9jDrX8Kmi+F58jmGw07qGl90NxCCpBTbAztQzvILkZsnYkz47Zy3otfsJfVjhveRnshDXW/S4aumiEyoVJbXsy5t9pCyI4sbLCvgPcIfNmXBryqkryKF2XwwRoiyTgU47aMbczUoBloB7Pb1EcpL7sAC6yKEZpVPqaUMOyaHAOO9PHqYkmtRWYfIwZa8hu/cj+odW5PwqWb4iRcUhBAh4xnNDZIvrRTonOVQ0DeLoeCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ow7aQDIl86nS899jTeRDwlKSIcKC5dIRtCWSu0EYon0=;
 b=ZUJfB4tJ8kP9puHHlCp1g8FU08oTTmucuU8oQaDojVvInPZF8Jv7+g4jnWeC/NTf5Q4lA1FA80AGIcKeYoN7+jMMr98znTIAgHIamw8VW8zrJAC2D7foC/M1yqFUtIrDuo1VVpG7XcZp/oZ+X8ibrkdghZUUkf13AHgINn3lGpEfFPXVctdVZOPfrNfMjCJz8h9b9g+NY+rb+526RTraVFZHdmoHuycCi+KqW4xTQ+DglbL2X6tg6Mdor+hQ91XfqS7hX8AHFpof1+nsOfea7lyXKO2vjZxPiBkx4tfDLmnihFeiYb71ssC80pWjd9Sw9D6PmJ8W9rei5ZtvzvEAFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ow7aQDIl86nS899jTeRDwlKSIcKC5dIRtCWSu0EYon0=;
 b=S1DrA+ReZ4UJRJwPPOJ26C7DpPhRXPF8QxWqTE5EwxrofxssMALR/qJLaYKKc1RfxS2AzXX6HDQsC6FebiQxWAqVzm731nmOLpemzCrZ7RfWCCWD0kOtdAK9o0721iC7U/RVqMIew2VAZzXuYUcMCKbAQd1SdPG6u/Qmtr2z4l4=
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com (2603:10b6:a03:453::5)
 by BY3PR21MB3033.namprd21.prod.outlook.com (2603:10b6:a03:3b3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.7; Tue, 23 Apr
 2024 23:45:18 +0000
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::94ec:979:8364:85eb]) by SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::94ec:979:8364:85eb%4]) with mapi id 15.20.7544.006; Tue, 23 Apr 2024
 23:45:18 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next 5/6] RDMA/mana_ib: boundary check before
 installing cq callbacks
Thread-Topic: [PATCH rdma-next 5/6] RDMA/mana_ib: boundary check before
 installing cq callbacks
Thread-Index: AQHakbDErNzGLcyhkEy3fR/U9s4mD7F2jPSg
Date: Tue, 23 Apr 2024 23:45:18 +0000
Message-ID:
 <SJ1PR21MB345784B523805F2D590ADA4FCE112@SJ1PR21MB3457.namprd21.prod.outlook.com>
References: <1713459125-14914-1-git-send-email-kotaranov@linux.microsoft.com>
 <1713459125-14914-6-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1713459125-14914-6-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=de8358dc-ddbf-416f-bc64-6472291d49fa;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-04-23T23:44:23Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR21MB3457:EE_|BY3PR21MB3033:EE_
x-ms-office365-filtering-correlation-id: 635a0e27-f6c7-4f48-760a-08dc63ef6e85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?zjox4Zkwhp4m0NHf47neaoZQUQTExrIuwW5GYrv96KMzE6cjQt713zaA2wPH?=
 =?us-ascii?Q?EKe7JQw3Pb9XYxADxVKkL7YZ10R+2zzQWMrfJ1Nni8I7I4qsO7hqFBhlnU4v?=
 =?us-ascii?Q?bMji2ygchArkj0GsEiPgaq3xMY8mpaGm0xFVcGcnix79/HGpPhlCTSIxj0UL?=
 =?us-ascii?Q?aC8d8EMkP1p0c2dwMpjrvV8u4MCPW6HDnlvE8lb3YE5WHtA268vL9e8abEuY?=
 =?us-ascii?Q?QaOAA9rm9IVjNsjYc6I8nZ49znZnKp0WVIn+glx8I13lVYbcPeSDB2PJjS2m?=
 =?us-ascii?Q?MTT1kjXA+ZEuAwv2QZhlRK1++6iscqXukBmk+4I73/B/4F55vgxBjx1LDmz8?=
 =?us-ascii?Q?uHKJ6Yr6tM6eKYpmj6elb2ED0GhxNKLbBTe8Qn03WUczWpa2hzoH8FUIO/jo?=
 =?us-ascii?Q?bm2lfbGuEjN2YtcZIApzuWRMyeCpnaUCz8UUuu1EmU5J1HEEd+f3/sAyrle+?=
 =?us-ascii?Q?+fCY+l3rqMy2Q4fQKuYdUWJNwRVbAqSD3RSYdoqfFzhczr8jruC7QdI2uSIO?=
 =?us-ascii?Q?4G5emln0OUENp9kX5cf/qgybrzj1+/HkatJR76liNnLHXIphKUZpfsHmykly?=
 =?us-ascii?Q?muyfU7jAn5aRd3KOcXGH3GxpNc/ooi5K9Aq++unEBzcnN1WwH/fkl38G/FIp?=
 =?us-ascii?Q?qYw7zdRxPdBv8XMkNysThWkICQwAW2KwUjK+hfSRZ+f7Hp+D2HsP0QNNMihO?=
 =?us-ascii?Q?atr6DQYdXyyMFo0r02RIv0TbO2vGhLrWFiGtLC3aTmLR8W5GkOOr8/DLrQKe?=
 =?us-ascii?Q?18I4KhNaZ79ZKU1LOxxFWlQT77CO5JJH9iNTifCvAbeuu8U4u8Ld7AHXzjg/?=
 =?us-ascii?Q?qbAhWUP1HPoOOzYrHuvZpIDkyzKnh1GH7KhfHIX399rJlRtGs3lS9IOJVogd?=
 =?us-ascii?Q?W1Qw3lkpXAFcfpTdeLPAFGfZQeHCps53MSYzArTwAyyPWzTcKrnK0WJv33S2?=
 =?us-ascii?Q?xj3xY5eKGc1Wn7EedSM27tEudiTn9kfag+m3Un1vHBZaj2d1T0nzAawukxFo?=
 =?us-ascii?Q?MQ0urz6dlSqyx/tydE5szDw7g0mmGybePby8qZHnpveAxAmEN5axAoedJeVR?=
 =?us-ascii?Q?hDuu8Ia9Ye+43qOMu0t6ZviXj79VhTzEtMMo7DdUbfjkfqEqYD7Y5hNxZzz2?=
 =?us-ascii?Q?sNQJxfOieXEdojrcM/IMf/eeGaKO0s2pasatCW6ykqvM8yF49Eg+DMbY3vh2?=
 =?us-ascii?Q?aDbays/isuEtLFYGWTBzg89SJjs5cg1ph+iWAWdCQfI1EXkj5D3TZohITLlZ?=
 =?us-ascii?Q?B3seAd2q2Knq1tuOtBoKmkS1T9X7w2QGi0iQoceqdqqS1iRq1MH/w3MvI7Kg?=
 =?us-ascii?Q?39nvEs/eXCLiP1qSKbn7i/ts0Nug9eupnpNbfvv8V2MfDw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR21MB3457.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9f6CNbpAaeK/J+g3Z2JnwajpHy+a0YCREgcacb/ocWPBrtrYMQdtBLMA/HCi?=
 =?us-ascii?Q?aaXMv81AD3kicJ02LgKfj4tKy0wdoyrGoe4XjUKeDK7lYfWPZC20SdpW1IZe?=
 =?us-ascii?Q?kmfLyOSOLa5vX/Pxj5bjGZl1XBSV0/cCRv4liDt2iDZb022ZZLq2lk4nZAmP?=
 =?us-ascii?Q?kK/91FVVDOXhK+aEg76o2+olj6qIVvxRszxuVO/uLmacKDSRgHAWMmna6IfQ?=
 =?us-ascii?Q?Aai1yqf/BZxulQ84vlA1P3o9ZbXeqK4UPuqxnYf2nv4SO0OlQBuq7pmsSuRI?=
 =?us-ascii?Q?OY9YFG3uoxO+bZeVNlSRH3+5rjhtHuKG56SEQuBjlV0SIWy4vLa5JXlgws72?=
 =?us-ascii?Q?BEsBDY0noyE8z+O9J93goLyVLmQcZjTZ4LAPXtGT+jFBDI0f4pI0hCih8N8F?=
 =?us-ascii?Q?QtQJ95OqrJ8fStpYae15MHUdpt+n5FcVRZHpC8Xm0ZpgElMYpnF9b7fKijuu?=
 =?us-ascii?Q?ZMuGmK0Yi8jwt3BZoT5gtJBGszE6eyjep47vxqgNzA+A2qqHHIFhkMUufo3q?=
 =?us-ascii?Q?NLPkKgoo6c5BOAY30EYvAflrB3DqPKcaxkg5X/F8jTGWKG7sPPEScvhtxCJ0?=
 =?us-ascii?Q?V6eUO2nv/EdDsypjVmsYvAQYUSg8iGa4A0VmWVR/z5dshfuG+N6VpmnUX08p?=
 =?us-ascii?Q?55wZTRXOtNIM9nbbCtgKIqwC7MFyw44+mNhPP+PBjgHwhuSDwWjMcuFf5gF2?=
 =?us-ascii?Q?qT//hGPu5Lb9Jk4ER8wDnEkTRjoo89vhOoXRxR3ZgiT0pEks3RrQaNkbtLp4?=
 =?us-ascii?Q?0AcON2rQrAhw4H3CL0bi6Tyx0oDQZ20L0wbu4ehGGviafYVnGmnxZHxwTGZN?=
 =?us-ascii?Q?/7b8nMi6AXf//hkgM2CyUGoQC4u6G20cdZVQOznbT7Kv3YQrodbiBsEh54CE?=
 =?us-ascii?Q?oN88K3F/+4KXV2xk05z53b/DxVrxw3rBmZJF3WTcGyaiJ3+AYYsRK8nsMTpX?=
 =?us-ascii?Q?d/FoqquYuvDbocNDN0/gGddYrPjz0DvpFuym7h47nCyOUyIQorj4krsLP/Eh?=
 =?us-ascii?Q?vhDDo0hKMsSGt9k8YjPxdFQLFWZG61FrLZTqHDH+8jgZmWP62Xt385WEOZWJ?=
 =?us-ascii?Q?FX9+VpqEEPLzW2LTCnFHsQQWfd7T5rpDkU7sy6HJIXB/ySG8tHCGkp/A9PWI?=
 =?us-ascii?Q?83KWBzq79cFsfPoOZ/vr46LhogfiTswowvfI2ttUwa8l23a/yOeqltqTYR0j?=
 =?us-ascii?Q?kdvcTDdnqirJcby4KuEI/w7rwmWS4r8Vfn6uE3Gulbr4DRZ7RflW8UOZeZHj?=
 =?us-ascii?Q?oJ9s5BGRFMULKT9iwmTb8ga+cyJiVeD+T8RDU+2R92ofdn1CXk/6QaUEF4Bm?=
 =?us-ascii?Q?O+C9/zlQTaKhYOopqvzRPKknXU1U3uCJqRo9Lto+IOC2KpLrtL22NDkDmLdu?=
 =?us-ascii?Q?E9Xdc2EMeOXh7zIQZRpkQGn4dKUrpN4KoOPkeCpmHMy2loMWT5QAzMjT34/B?=
 =?us-ascii?Q?GV+t1e7UeYf7u6vk0qDyOIw83Xh/GKbafZ+G+Qm7BDuGUgJeNdYUjeuIDo3o?=
 =?us-ascii?Q?MFQBICIdOpKdS0RuWcQpkmBTWhVYBwiUqiU33ZDcCddJyyFB515waMTa2+/V?=
 =?us-ascii?Q?04WWY0g2H9owhpDCgPg4DLeMi1NZdWhde1QzlQlYTugckqFDLDmH14+zsOb6?=
 =?us-ascii?Q?/xQZUmP3ZhLuO9zS1jwM7AZLVn8aXA7BLgsrHsoit2eM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 635a0e27-f6c7-4f48-760a-08dc63ef6e85
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 23:45:18.2043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uKf3tisrrVhKtOr1noYejbw9175OSDCzrpgtlmDCAGxzNsSeIVMa/86bkPdCXLQU4U7ibbjCunbHcLP8xdw4Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR21MB3033

> Subject: [PATCH rdma-next 5/6] RDMA/mana_ib: boundary check before
> installing cq callbacks
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Add a boundary check inside mana_ib_install_cq_cb to prevent index
> overflow.

How is this condition possible that we are getting an out of bound queue id=
 from SOC?

>=20
> Fixes: 2a31c5a7e0d8 ("RDMA/mana_ib: Introduce mana_ib_install_cq_cb
> helper function")
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/cq.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/infiniband/hw/mana/cq.c
> b/drivers/infiniband/hw/mana/cq.c index 6c3bb8c..8323085 100644
> --- a/drivers/infiniband/hw/mana/cq.c
> +++ b/drivers/infiniband/hw/mana/cq.c
> @@ -70,6 +70,8 @@ int mana_ib_install_cq_cb(struct mana_ib_dev *mdev,
> struct mana_ib_cq *cq)
>  	struct gdma_context *gc =3D mdev_to_gc(mdev);
>  	struct gdma_queue *gdma_cq;
>=20
> +	if (cq->queue.id >=3D gc->max_num_cqs)
> +		return -EINVAL;
>  	/* Create CQ table entry */
>  	WARN_ON(gc->cq_table[cq->queue.id]);
>  	gdma_cq =3D kzalloc(sizeof(*gdma_cq), GFP_KERNEL);
> --
> 2.43.0


