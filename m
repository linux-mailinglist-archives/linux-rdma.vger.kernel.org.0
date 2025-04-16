Return-Path: <linux-rdma+bounces-9490-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCC0A90AB8
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 20:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C8E0447894
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 18:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170BC217723;
	Wed, 16 Apr 2025 18:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="UqwfOgw6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020091.outbound.protection.outlook.com [52.101.46.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EC7207E05;
	Wed, 16 Apr 2025 18:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744826553; cv=fail; b=MfymGAFwVm1LEnkYNUZ8leQeY4u1ZtOFGzMqq8p0xgfVaI0MgGxG7eiqvMFvVlOgiyYkl1cXQl7AXFOvDdfB+LHX9xgBGKbopm3yqClMfU867nOAZ9B3Js/WHBuNnEuK104E+rhatXnQyPn810LueE5mRbi4HR80zwWW9FBWazA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744826553; c=relaxed/simple;
	bh=phSrrm33mFgR/AdxRaH3+toHGmmdJV8q7qDB8TylZno=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lIrONYXHTP0zepTse2JgoQxF8lN7F5i407LHkbLhL6C+vNO6FvPiycfLHshe5TgGzXnRr1AFbmIb4AUJIPFNGNEdwM+CPSaQO8jo9CedS5PKKYvPqA+8qhaSJkWZoGj6QajcA0iYbXNtnYpFqimwPI27cCdEjwyDidlIFQ736JU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=UqwfOgw6; arc=fail smtp.client-ip=52.101.46.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7rGVp9sJ0knug4e9gS6o2Ol/njpkobdEcMKu8VFD7BNYPRf+dz/RMXPBJPkiUswonDl6OEVZYqtHlNOImVEtYZ1AV7qdeXLo+c93XhRvGQUydR5f5FeuA/JvnANWVnsG0j09qYBPI0WAaUsJn29eRs9u8VGgzPiuWgUYyJjxfg3SjkcyKGc3gUYCFgfhKt7+d/pnaSH6xQG+q8QT4qLoViuH+22QHzqUMzlT/JIRTTX9nYihH1jIgdQiCH75c1rBo+TRzC73jmHWdbrm57qiQqn6sWfcifIRZQk9qrjSPe+ceBOuNwuQNBmSc2WTsSnSS3kdm9huW+LU2bmH4uMwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEmnaOaukf6PR4tuWJdjJ9B8vBdwQXx+TaVGnTtWSZk=;
 b=K86xBs0D74MV7aKOrKE+rOTRNRGBT1OmrtASVuzcCDspvEkBjvxXTRDpVUrXkWgykI4nYrFS2CjaOED6fdJfPCeviRO/Ox8s/QDL5m+YXCO5QZ2BNDf207QSZBnta06kW9Yr7WEVi/AHPGVpLgDpkojCpOMqRb1St+YJd/IT/v1gl3Dk+7pmPkoRdxqzklKDOSUi+wv8YaDNdUfXv1ftSoIJWT/Rph1bCE0Fs5gcvppagfoqneGp4+89ZxJ3L75nGYIj6sZUQ3qjpYBE+QTuJVnxivToOfTxCYpZpxbVKmSeSq6ZrWBE0JxT9Qbi1JfuZBNfM6Bkzm3P/ogAtjH42g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEmnaOaukf6PR4tuWJdjJ9B8vBdwQXx+TaVGnTtWSZk=;
 b=UqwfOgw6xYHVSn+bkspxgKCSY7sMV163cMVJFiLHAHGJltGAkjWWSnYEWYikmQHEAH/09GsnGuhm7UztS9Bms3hZiVZLsKq1C8GBzH1ufISl2AVWzo8MBzo/sKzFSAtqF/Ki+hQ8iyWFjUlxEMQb548knbDAAqoBc+vWaX6EYsw=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA6PR21MB4461.namprd21.prod.outlook.com (2603:10b6:806:429::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.8; Wed, 16 Apr
 2025 18:02:28 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%6]) with mapi id 15.20.8655.012; Wed, 16 Apr 2025
 18:02:28 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, "pabeni@redhat.com" <pabeni@redhat.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, Dexuan Cui
	<decui@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH rdma-next v2 1/3] RDMA/mana_ib: Access remote atomic for
 MRs
Thread-Topic: [PATCH rdma-next v2 1/3] RDMA/mana_ib: Access remote atomic for
 MRs
Thread-Index: AQHbrRuzDDNwd+F7X0qAM7xd6dupAbOmmSAA
Date: Wed, 16 Apr 2025 18:02:28 +0000
Message-ID:
 <SA6PR21MB4231BC133C6EBAAADB6CFC59CEBD2@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1744621234-26114-1-git-send-email-kotaranov@linux.microsoft.com>
 <1744621234-26114-2-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1744621234-26114-2-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1a8db992-639c-4918-8d49-7fced70c553e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-04-16T18:02:09Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA6PR21MB4461:EE_
x-ms-office365-filtering-correlation-id: ed99ed7f-42b6-4849-a9b0-08dd7d10da0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?QpPUeVTgj2iTgh+qm1lLy6NZMqi1kxoBZw/I/zCu6jluOkPoI9kJiOoBbxbz?=
 =?us-ascii?Q?dCHrItuUJARb7+Iw0MMmDSv4h3LgbbVOvkKLrDS/YBpj+/6BFlBBZ7Ony6qz?=
 =?us-ascii?Q?spIEAzBRVViWB7Tm4cKHCLGcj2jNgyrilIBHm/+c4CPbALOOIZA9gL5EeOv3?=
 =?us-ascii?Q?/JKAe/MTl7fFYAaS5YlrGx/CEgKaUJhSKLToYx5d+tmgoR+f/9B0joi4ISJV?=
 =?us-ascii?Q?Uj/WeqpePDFdSyPC7LH/BnUgP1L6Yi0xNPZ5JXSeXD7C/u2I54uvRruWP42O?=
 =?us-ascii?Q?qJolblnOZY1fRKiN49DUgMsFoH0NUcMhzLlAsnVT33Bnh7ArIiNSf0lXi1Qr?=
 =?us-ascii?Q?p/gQHXy52gRDMwOhachVYRtgmfwXqrz4CVOl0Z0uIHeHunSJofwX3Bi4iU4+?=
 =?us-ascii?Q?OUKgQ1/Fj4rS9MX5xdHZEvmjbDseyiJJskM+PY3LWg35o+sK1oppRxzyyw5z?=
 =?us-ascii?Q?t9wWL834y4haUckpnsZt28kVE0jeF5tM+D2mK9iJlYTnmwnQ5nZyZ1TkWdOQ?=
 =?us-ascii?Q?FFSDyYLM4YcKApB7aMkFPrJOH0lFIweiSjFe7r5nmgD3qJULCj84x6tpOKdv?=
 =?us-ascii?Q?+12hP62XXYDkjudO4pT64JK2JvwBqBXikIsbwLkHH7zyX9bzbfF/2SdYbJdm?=
 =?us-ascii?Q?KSHUVu9K9dOAKDrOD/ShYt6BxnS06/lom6DPV1N9T0SmLlk1fJFj9m4mX63L?=
 =?us-ascii?Q?DXtd5dZk5PdnFD8o1PV37MoN0oz6wfG0UFsxFc9s8I1kWodJ1JVNhyUoj7aI?=
 =?us-ascii?Q?A89VQx5GSXOJrrtPdB8CjqE761JwV4/zxGGBklKGSSZ14isQ5co5utxCIfP6?=
 =?us-ascii?Q?OEYnqPqhoVaHCBYNQF40zm83+eiJXJv2kDJM9hm6Sezbh5zUZpKfWZBlXd52?=
 =?us-ascii?Q?jg/mjndVXjiQfsouUI2SWbXrzz3qD2D5XL177qRsggclCgzkqn9PvUyYLziw?=
 =?us-ascii?Q?FMc4RuEVGEUIYLrIAk5NUic8MJiM0H7LIofuss7BK6QALcpTyEGx9X3Mwa5q?=
 =?us-ascii?Q?FaABrVqiswRem+H3trjnFKEdOb+E1pJmKxB1KvL0kk4jxEMvKbqhre+2M0iJ?=
 =?us-ascii?Q?7j9t7T+mL1Je1yPua8Cu8kf1S+IslpeJVqkttD/AafZD1AKGTk8/ZMWj2jxp?=
 =?us-ascii?Q?vqtWKFlsvOTXx2Sk1M8/YM/sTyoTzMY1ty0Haiswt7I/WUgaZtqwSYzFMWe0?=
 =?us-ascii?Q?qoXmoPSj8e8hjs35dZncj3ICoCwGxY2LV7RI8M2+swcprACWXWGUiAsQQlgl?=
 =?us-ascii?Q?jfrCFWnul6jQ9ehWGG+sgqhpreTOVy6iCbMvOg3nPYF0sNq9lgNE8Y71rg2S?=
 =?us-ascii?Q?8L6cI0vY/EwAlfX9jP6exj1L8xMQhZRQj8TUIUI+2yCwWAb5L0WoudnnQbaG?=
 =?us-ascii?Q?O45hc3h9Ll08/kj2zclrMENO+8GNEzCY7QghgaOb7e9jZ5EsqRTPsbMNDedD?=
 =?us-ascii?Q?4Yw/twlqZEWsOJLuFtnkcIb+HzaS/ChpwrvM8HFxsdu0tvdprvzmYMHF+pUj?=
 =?us-ascii?Q?FR7ViOBoNN1pnbg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wwpr4MfCK3Qn5GO8f6rCaNSUeeHgLQ3D59oXdPDmZxy2SgyILN7kvEfKJWvN?=
 =?us-ascii?Q?kuKyI8d9xw98LKExfDy0mIyeNINK+kg4HRkLWy/+qEz8xeIuSUJa5+dwiWVD?=
 =?us-ascii?Q?nz+UGKjI6Mu49nBOVdTMCUlIszNXhuskzTULrS8JLqzulEwRuoeLNZOPn2v2?=
 =?us-ascii?Q?z6jJARDJkIcRd9U26m4eU0QgIXrQeHlLSzuHmVjja7LEBUISOjZ6CO5fvO7H?=
 =?us-ascii?Q?pHmwusuLYzB6m0LUunrd0sSqkSfF7Eqml4RAg3PssDtHCay+wUSe7CV4HV0c?=
 =?us-ascii?Q?JFMhgAVLgqVb9wHlaa2f6vKFYFfHZK3h9Hoj4KYrRxola9gohoGK0UcqIcIw?=
 =?us-ascii?Q?W9N+htaBrR5r1txlAZjzE+a26zbfyBnv0yzezvljCKi4L7a5he923iEWcLSR?=
 =?us-ascii?Q?gKJ/1DQy2OWbZ9/2YIHpSIfA6cqLUabHlqBzAa3NSWccNZGGOaLy+JvpeNvm?=
 =?us-ascii?Q?/a/WIwRs3rCO0bdAmg6uo/mUysChj9C6otknDhMyZ99VgbjodgZ47Trfjh9s?=
 =?us-ascii?Q?edyQRjBgXZl2vGG+dkDAuLXm84ZXjFxlS90CIkKrolzC7xK+BRJkv2D1dha4?=
 =?us-ascii?Q?U0vekcPub+x7Ajy/girRHu4vZBhprZ39WZYmJREg3t0xXXUzQl1mbewb8b12?=
 =?us-ascii?Q?+SsdKRa5bZhXiA0PGDP9am3VL+WdV7mZmyqAg0+yQx5RkUN6I3LFioUrXg83?=
 =?us-ascii?Q?y4pRozIXPRL6Pc48K2i70N8AQ2UJkA6z439mvQg1toeHQ5zUVSRcq1r/Qmcl?=
 =?us-ascii?Q?/7kU3qqFmYxmHMfW5dl1CVYflrI+cHZ84/UgNHTEs+stWqXP2nl1J9FpOjWU?=
 =?us-ascii?Q?vsqkuTJCvjhf+yK5g+LZ5SketWprABuQIgS5OhyWuVzdUWVUQmC1gUYIrA8n?=
 =?us-ascii?Q?HlWvZJCqES149vj0xMrKviEZu+NJ8xaQbx5DjcVAOX7L2DovfCD2+7wd0Mzk?=
 =?us-ascii?Q?MSpuRslxxnEMPlbgn6P+3KYE71ExbNJvdqft51ollSx6AFPO8S17TMXQKeSw?=
 =?us-ascii?Q?q1wl0DSf8SuIUg8nOydKD1eKMV+Oy1N8ATELFJ3VjWIO0VUJ0eMsKjDPp9YD?=
 =?us-ascii?Q?S/PWEbOL7X8NyzzrTSpw0sbFpF8+yIIh3JfNWgb/klQ2gyFNelo62ksouR/Q?=
 =?us-ascii?Q?cpw6EMaYQurGbarePODGYn+Ti6kp2WZJ+Q9kub6r1KCSCwKGcS3ZtNrpMaV0?=
 =?us-ascii?Q?8bTR9cr0hUg0UeGoqOjxsBEES9chKz4BJSII0RTlAJN6nu9wwkytaauHkYUe?=
 =?us-ascii?Q?oe1/520/ed4cnDGJFTfDnoAGeqKrH/tav/4awTsPCsyvz0OsHhCynj8scoOH?=
 =?us-ascii?Q?xYhBFmmslQ6EVyenm2iP6ZQL2UyRgsxK0zDWsmNnQ+t57kC4dWinJcojCAuz?=
 =?us-ascii?Q?n704yaqqZpVkMUX9xjy4toYUo/Wn/iiukYhU1I7+DkZU7q1kTwl1wfrOLxlN?=
 =?us-ascii?Q?x8WwtmzDxM5NRRmE5G44uE6ymkzOunG92iOxlmGp+hYMzLR8E+aJZGuQ1wKT?=
 =?us-ascii?Q?gZG8uylyLZWQmdwTJQgz5aoThnKMwmX1oTo200S3NLf8249NDZHowg+ftZmb?=
 =?us-ascii?Q?s6z7STKd0dmtvSVxbnKhm0RUX0NoQ5MLZ9yLKe0L?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ed99ed7f-42b6-4849-a9b0-08dd7d10da0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 18:02:28.7702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /IQ1O4VxcxF5ZCOAq6ALIvIiHdjy4JfWDqDahte/RKw0EmjnTKY5e22o38w6yU5sZ3+m/A28XEpFhCAuivj/lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR21MB4461

> Subject: [PATCH rdma-next v2 1/3] RDMA/mana_ib: Access remote atomic for
> MRs
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Add IB_ACCESS_REMOTE_ATOMIC to the valid flags for MRs and use the
> corresponding flag bit during MR creation in the HW.
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/infiniband/hw/mana/mr.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/mr.c b/drivers/infiniband/hw/mana=
/mr.c
> index f99557e..e4a9f53 100644
> --- a/drivers/infiniband/hw/mana/mr.c
> +++ b/drivers/infiniband/hw/mana/mr.c
> @@ -5,8 +5,8 @@
>=20
>  #include "mana_ib.h"
>=20
> -#define VALID_MR_FLAGS                                                  =
       \
> -	(IB_ACCESS_LOCAL_WRITE | IB_ACCESS_REMOTE_WRITE |
> IB_ACCESS_REMOTE_READ)
> +#define VALID_MR_FLAGS (IB_ACCESS_LOCAL_WRITE |
> IB_ACCESS_REMOTE_WRITE | IB_ACCESS_REMOTE_READ |\
> +			IB_ACCESS_REMOTE_ATOMIC)
>=20
>  #define VALID_DMA_MR_FLAGS (IB_ACCESS_LOCAL_WRITE)
>=20
> @@ -24,6 +24,9 @@ mana_ib_verbs_to_gdma_access_flags(int access_flags)
>  	if (access_flags & IB_ACCESS_REMOTE_READ)
>  		flags |=3D GDMA_ACCESS_FLAG_REMOTE_READ;
>=20
> +	if (access_flags & IB_ACCESS_REMOTE_ATOMIC)
> +		flags |=3D GDMA_ACCESS_FLAG_REMOTE_ATOMIC;
> +
>  	return flags;
>  }
>=20
> --
> 2.43.0


