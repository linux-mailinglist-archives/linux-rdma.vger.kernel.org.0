Return-Path: <linux-rdma+bounces-19951-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBh6J/79+Gko4AIAu9opvQ
	(envelope-from <linux-rdma+bounces-19951-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 22:13:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F06264C36E3
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 22:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D54DB301FFB3
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 20:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B600A2F746D;
	Mon,  4 May 2026 20:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LWfjdmA1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022072.outbound.protection.outlook.com [40.93.195.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0F92F549F;
	Mon,  4 May 2026 20:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777925624; cv=fail; b=kDO9MJAsubMieVbjaqd/qEpzQ9WTFLXr0Lpv/9mhppLef1UE3wlFUPiUrMQNm7ybBjg/bSjze+pPJ6QBC0pcw/i42RurZ3LRL5Jp0dbhuTQY8Uk3qfyi0aozlRNzov5NUpPgdI9cqd+49e+QYXraRguNYis4JVvDEb+1eZqfpQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777925624; c=relaxed/simple;
	bh=FKiajdgdFjGjsoFDXb/+QU0nVtAT9I0N/RvSlG+LSrk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DUReMF+C3Iy6Y3j6KMxeSMGdM73FTDRdqxKSvCZ/iCiigVtc5p5h5Ce4rYGpcIxyQBwKyVaZV5eKq/s2sUmgIodcIsw4oya9VrxEYtKYCaMLJudq8ipOvTA+VVFBHPnkvb6BOSmsibuT1n/tBq3gfJl0kRb3NId48bvQVys8kOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=LWfjdmA1; arc=fail smtp.client-ip=40.93.195.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kqqcycrPm+nF2tpCZmyvcXD40qXHXEzVAimd8fPimjrglFF8E6Zt94K87yvUf7a/SE5ep/Icoj/2Ed8ruwiZtpaDaBlK7HH9SaguUIbmMDgrPB+uu523qmIYGjacXqKLK4UJLnDuU+tzauo3ex6SuYqjsGkYPgpOPh7wgXrLiAMeFQnKiTd2CdU3V3dlsT1lhi6KYpZK4JwpC5rkTTM8jwmReoIinALL3QhFtr3+46Tdaojs6uPC8qYw6ia1qxX7LJ23ZB+9kM9qZF09Bfe8B4KqOGnrD5ti3sbjLobMP5BigoHXGyPni+5U3UrVXP1v3b3LM5tyGzZbsaOIxWUGtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfd5OyXTUL2Ry6iOwT2azWbY63C211ZoUoxHNawLqS0=;
 b=JIhnGSzRDngni0X3onl/G2YT4sXYRNrIxJSo1NsP/df707yp7vlQaA8AqOYR/e+/1HTbrq/UvH+bamLG1WYEOd6hE3Jcac8K6e+msfpts7c64xNZ5ry99W6x7tIpMzKLT3iAl0pvHyej2IHht5b3RlfY02RivNoLlvn0Ddm7U9SBJqf2/bVBSVqmqYsxLjJ6pXoOe/0Z+cvYlqGX7AKt3huRFWrU8qL4GM+vioEkoZNjIE+jl9+Vtv90PT+X26TdFoSfHg1Zdy1Vu9DcXKYwUNE3lKi0GJK6/XUHOGNkCQtjS+oROpukwFv1iPWkrwdjpsCmOrKL3Y/3+TPSUHQS6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfd5OyXTUL2Ry6iOwT2azWbY63C211ZoUoxHNawLqS0=;
 b=LWfjdmA1zZG0SpUfM1OmjYjRRPqGk0LtFmeE0TErzNFqtqt+NV8Dz8SsSRGMvgd9JUZz55T6mrw6TsZUc6s4v3lu7iQJR/hs6bk1HpiwPDDDdiSevVY5QINQPAiCQRWNkxDr/A2SiFZ4pVHboPkMVoar2tTVsiawvx+FO2Utfug=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by DS7PR21MB3151.namprd21.prod.outlook.com (2603:10b6:8:7b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.3; Mon, 4 May 2026 20:13:36 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%6]) with mapi id 15.20.9891.008; Mon, 4 May 2026
 20:13:36 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Shiraz Saleem
	<shirazsaleem@microsoft.com>, Konstantin Taranov <kotaranov@microsoft.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, Dexuan Cui
	<DECUI@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net v3] net/mana: Fix auxiliary device double-delete race
Thread-Topic: [PATCH net v3] net/mana: Fix auxiliary device double-delete race
Thread-Index: AQHc29IXFnJZ/Ejtv0O6XtnCZPECCLX+TT7Q
Date: Mon, 4 May 2026 20:13:36 +0000
Message-ID:
 <SA1PR21MB6683110BFD4A3282C8BA48D2CE312@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260504142704.159035-1-kotaranov@linux.microsoft.com>
In-Reply-To: <20260504142704.159035-1-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=53bfb6b2-2dca-4aa1-9902-12cad7cfe966;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-05-04T20:13:16Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|DS7PR21MB3151:EE_
x-ms-office365-filtering-correlation-id: 6df0eca4-97d6-44c0-9806-08deaa199f97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|921020|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 auRiiCjM4Mj6qnQD3WprufU82qa1AgCb001mnbi3rv4I/kdwNpXEhTaITzOBvbNsFZujcTAOITaF6jTVCvxeybESTe90eBGITLN5HR0ZXNnag1lwLleqffd0CRArHy0eK9wf8tKxB1PeQ5A3R+cpgEKDyrewN99zIRv+Wf+Nq5ks2Ad2AcIb+BIHAbiRYXMoPPW/V1HiX23oAvho2CsS8kuOFqQVDsUlQfOgx3geL3KrvMWyXx2DV6WPp+ZZUKVTWiTYSuM5L5Xz5dPUdsXigWHpYjMK8xM9BbtNF1Qd2BU491C7MlxXMJO9Zs80gtNuMcPS2BsBoy6iI3kJV9HXhRU8S63EqQyToK0JyZt0QU5SOhgruWRl6+61sYyv/9M1NUtlP9fwQ5JODkl8mZiJK409Zs4rmxuIFF0bhPvjysoIHbwJN31mTeWyhtUTUP/VBJ7cLEJBS0lXz5d0Oou1OcKKq1b970kPQYc+PuiA6A6gPHVS6WA96J/aFZ2GVsP4QsbH/8Jjvcg8lZx4x3LYcmyySCPxKbdq1ABA/HEi9EvwYC1F3AfV5l1D6PVcKCNhOooHyx20m88Ejx/EV1c4zgDhp1hzSATzN1BLmC03bWrUQl+SqZnB4CEp8/szIQsI4bsi+7IDZqQ5s58U+eLR5UHzB6xRyTJ5xND7zJEUbkpm2GoCMGTc2dGlvV24ARsjuaolDOSDsmTmjOjid+HakM8pKBWK6l5CVm1kqRZVT31BxPmSh5h2RBbYGW6gA+YjN/iXhPhDyYoVsWHNw8MwSg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gTCU8RDu+CGkVVMQbf479Fh/G5d1Thyy7glHZ/K9j9GaIX5lzqYy8bpe6B5S?=
 =?us-ascii?Q?R6KMilKX49V3rwhA2OFYw7svxl2c/ypjK2Ip2+Ypz2T8uRAzuwTlkWOMQ1hs?=
 =?us-ascii?Q?COQVsjGvmPLt/Uj2tHfh24HSNYe6cKzxL3AW0V1LBgXk/Qv8SJ4lzB9uZ3Y2?=
 =?us-ascii?Q?kDSLjxM1hMfD3gWHxqOPf9GZbcDG9MFXfOLsckSll/XVxVXPLTp9Xg0k4WDZ?=
 =?us-ascii?Q?OW5T3iieRYcuH+d5Rtrt7J+GkeGMbqJ2tgMAQaLBjcggHR/QaLVU8yea5lDy?=
 =?us-ascii?Q?/tvK7KW3K3skD1C8+e8LbFzvpVx7BD/BZOfG+zn5eb9twDLwdieoR3mqx/5e?=
 =?us-ascii?Q?a1EngOU57MRkVguY8K6YsgXSKOmf20wA3eg5CoUqUOkHUNYU3+lrPrgoqxdc?=
 =?us-ascii?Q?X85wTC64z6hvZ9Bn2byaDX8bEv320P7wbOG97TjVAVDXsKXOfS6IwqUTjddN?=
 =?us-ascii?Q?gjvAi7Bn6rteqoGpIi+cPBmf+Qjxv3xxK82ynSK++/3KefAFWsx00EFle2gr?=
 =?us-ascii?Q?sqczK9PeoiFBi1Bg4vVyy8gF705pv/WDx+2f/l5+d+hHDLsKo2DL3rhdEO1g?=
 =?us-ascii?Q?EfkLZ6a2xlS6V0ZFyQ0mhNFBcOlR1GMXY9PYAgZDWmA8rI5Fl418y7QQnGFh?=
 =?us-ascii?Q?gEEn84zKib8XNCdZZofLeLxcOMDk+QR8AmICCsOd0ux7RlLUoYnGl+3FHxbW?=
 =?us-ascii?Q?sE4K+c07awWGDVOgIjT02VMeRGblbBoWk4vA/WSSyc90bnkiChz20LLYl0PQ?=
 =?us-ascii?Q?i4JhOyGhFiG5dFOXgIFalaw+48O6oJlz0HPLlAnc/Cnsi/ra67tncdfok4Rd?=
 =?us-ascii?Q?bBocWUoMqRxDQuBHRV9Qr+4Bz8Gmezwd84CPGsVgAxxTREbqimBdjyZ848HY?=
 =?us-ascii?Q?edJCdx4ZjMokZ6BJuG8tFChcy9CyHDYWZd2Zm3BTtIt7/1n4rHAjgZHjInWW?=
 =?us-ascii?Q?WrQ47vDRTmmrTxOy2bLscMDuxf9w/gVCON7t7sp0LMZtX+rr+EgyP3EdY5TK?=
 =?us-ascii?Q?LDFk2ndjCxjcweRQF1Z/toTQfg8eAx0Mnmzhk7/uw5T7xpzDj3J569Syx9a0?=
 =?us-ascii?Q?XUzyIRNoPsWzNBW0CfBw1ZVWfwCdqE3VPmJd/LDRsA1v237Vpz7lIu1DBxT7?=
 =?us-ascii?Q?8Rnwf218UwtgTZbS5Z3er+f2cLsrwEtNTo4aF1lJ/AjaYI5leixKWPOyACEW?=
 =?us-ascii?Q?x5+KiG/EcaS3lB3xiTBM4gnM+x1QJ5Fc3BxEfD4n3zm8G7UCzh6rMc4cNj9S?=
 =?us-ascii?Q?KOMzeMj26ej+jrYocJyBKK68VsQ1OXxonOkWkphqjVf6hsm3WkFa8eimd6/o?=
 =?us-ascii?Q?WaDiROVULiMVn/86QE8RhjIz0BcvmWRtoFF+xvlnNIvHYNLQf/Mf0EVcIpIb?=
 =?us-ascii?Q?dkP8lEQfIvg2MCg7O0qboxf8Dc6S1YhlTjxEijXWLCIEH2sNB885uPORP+uz?=
 =?us-ascii?Q?Zc0aKUOIcrTBUbddreoj0ZQhDrKi5nUM/OdauBAH0ZeKpekE813IDJ2Pv7eS?=
 =?us-ascii?Q?RFTA/T8S+qa6rj/6BPQane9Db2BzIRVbHMTwdFOZSDlvp+Pb7eVgKay7oAjp?=
 =?us-ascii?Q?lVg4lQQlh6co/P+6JQmOQ/l3VF7BYt6zbsEYt2R7XqZfon95uAIN0NRwXc4r?=
 =?us-ascii?Q?ccgN0DcxQsdQwYTTrcivUMieB9/fNFNDbn/MbZ99ZMEsMrI131ltnldommaf?=
 =?us-ascii?Q?TQ7QPyjZoNxu2JyMC7zvL90zmHFyrRE7laAiFWflFl/NkGpQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df0eca4-97d6-44c0-9806-08deaa199f97
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 20:13:36.1365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5hEGLWB3UVAo2uNIWu13M69YP156TMFVLH0/R91Y6nnq65IP6SdxkrJkBZw03ABzr1WS2UKXA1nOoZ+BGdr7wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3151
X-Rspamd-Queue-Id: F06264C36E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19951-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

> From: Shiraz Saleem <shirazsaleem@microsoft.com>
>=20
> Make remove_adev() safe to call concurrently from the service reset and P=
CI
> eject paths by using xchg() to atomically claim the adev pointer. This pr=
events
> double auxiliary_device_delete/uninit when hv_eject_device_work races wit=
h
> the service reset workqueue.
>=20
> Fixes: 505cc26bcae0 ("net: mana: Add support for auxiliary device servici=
ng
> events")
> Signed-off-by: Shiraz Saleem <shirazsaleem@microsoft.com>
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>


> ---
> v3: Separate the xchg() call from the variable declaration in remove_adev=
() to
> avoid calling functions with side effects as variable initializers
> v2: rebased on the latest net
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index a654b3699..dd4f4215a 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -3465,14 +3465,19 @@ static void adev_release(struct device *dev)
>=20
>  static void remove_adev(struct gdma_dev *gd)  {
> -	struct auxiliary_device *adev =3D gd->adev;
> -	int id =3D adev->id;
> +	struct auxiliary_device *adev;
> +	int id;
> +
> +	adev =3D xchg(&gd->adev, NULL);
> +	if (!adev)
> +		return;
> +
> +	id =3D adev->id;
>=20
>  	auxiliary_device_delete(adev);
>  	auxiliary_device_uninit(adev);
>=20
>  	mana_adev_idx_free(id);
> -	gd->adev =3D NULL;
>  }
>=20
>  static int add_adev(struct gdma_dev *gd, const char *name) @@ -3538,7
> +3543,7 @@ static void mana_rdma_service_handle(struct work_struct *work)
>=20
>  	switch (serv_work->event) {
>  	case GDMA_SERVICE_TYPE_RDMA_SUSPEND:
> -		if (!gd->adev || gd->is_suspended)
> +		if (gd->is_suspended)
>  			break;
>=20
>  		remove_adev(gd);
> @@ -3753,8 +3758,7 @@ void mana_remove(struct gdma_dev *gd, bool
> suspending)
>  	cancel_delayed_work_sync(&ac->gf_stats_work);
>=20
>  	/* adev currently doesn't support suspending, always remove it */
> -	if (gd->adev)
> -		remove_adev(gd);
> +	remove_adev(gd);
>=20
>  	for (i =3D 0; i < ac->num_ports; i++) {
>  		ndev =3D ac->ports[i];
> @@ -3843,8 +3847,7 @@ void mana_rdma_remove(struct gdma_dev *gd)
>  	if (gc->service_wq)
>  		flush_workqueue(gc->service_wq);
>=20
> -	if (gd->adev)
> -		remove_adev(gd);
> +	remove_adev(gd);
>=20
>  	mana_gd_deregister_device(gd);
>  }
> --
> 2.43.0


