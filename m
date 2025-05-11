Return-Path: <linux-rdma+bounces-10270-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A9EAB2A46
	for <lists+linux-rdma@lfdr.de>; Sun, 11 May 2025 20:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BA7F18975DD
	for <lists+linux-rdma@lfdr.de>; Sun, 11 May 2025 18:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA9919B5A7;
	Sun, 11 May 2025 18:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WpjlkX8h"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022094.outbound.protection.outlook.com [40.107.200.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE152522F;
	Sun, 11 May 2025 18:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746988257; cv=fail; b=ag/D8E7shKECz7Bj2d/0nX49Z+RjIXTdlYsQINOLXLZp5pfO5cRfWlF0z8zICKqCvLHlB2utoZA6aOjrFKgkKLqMJqt+n9l75vgQgXFnMB3n5WyWYY5g1tCSXZTT4u2lpWrSyefk1dkwAbWBfP7Luz2Gz+pS938rAd9NfImW18Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746988257; c=relaxed/simple;
	bh=ST/ostuMO3005f/J5pnqoEd+VKsVU4n/Z7dDHvcyIvA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kKEXf62atFZTs1KOC95KYw2LRg/G8ilVA6poo4fJHL6r1++iQ+TZNRlPc2K3gB2vrsD/Hw2We5xlQed9NTIb4l4ffKz05n8slj41JRsoBOXsUbMab0DUhS5+xmRG52XkHQm2xtMJkKtreQ4rYEsLxxggkc7pQuSIzaRNxyJ5OVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=WpjlkX8h; arc=fail smtp.client-ip=40.107.200.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZtxCg58o/sGZo5Mv7zbOI9oPkd1U9v5p6FpajIr+syUpva5aTOzXO1pt3Mjq8xGhq1G81OsNCY/7aTOuKubFX4QdW6WQLWVQ8B7Y3DdHnLmJiWjD46TbyJsSwQtVeG7FrL+7GxoWttZy7DpZX/aU5gFyjCvYGFtrR1r6oy+bogj+Mxl8g5fnJWBhGcMsM6Jtu+J69g4WxkFuGBu8bBU4FApcx+KAgYVYQ4cgI0h5Xf9kYQg0e9bdDDsQjFNf3YKu6+AqQUMi6gJUoGfUtnxgqD3g+Hbblm+/TkX4PB6OSs7UcQxhl4LuQH6w9sHQPHCQcYJvManbPWkn2otRT0AhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VezkDhUV0StLyDWIQyr4tV6mA6taPQNgLMLy3YIKSTE=;
 b=HGCS5ChI40zDvpFlX9g/Qhf+ToSnfvfpIb0AxXITglqn5TV45DqXz32pVfIoxJC4GtTbY92hN+tpRZMc7wQpFDu8Lhj/2ksmoRpFMMNaN9UXGIHJxhGGxJwT8georIlwo38y0mjIszFiZxZxVs+uHDGxqYfvrl2o0aTr7sDOSzMTFJlWPne8kAm4jOnCewte5N2nPrssaDsmPXJakUuaDTh/GQymcrCx0lMJSdg+X+pE3709V5QAspU3UhPITJqwLQsPXUOj/2YaSEUI/0NbhjqJJ9BLt7Lsm3nJRkPBL9fequi9dX3dykwjeOwDZDgEclgKjbv0uYSD4LpH8szt3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VezkDhUV0StLyDWIQyr4tV6mA6taPQNgLMLy3YIKSTE=;
 b=WpjlkX8hoLMS7/0pSiQQBGBTq0kZoJ8/ebnb0MHBmcTL/KyuFAoLqhd3o+0I3GOTB4MiDV+/cCoNLRX/YfYPa7ZOQMz69qs67k0EiHXIMvuFdY9IET00fUX8EfGQGfQdwSE0ssoeDNvDdpU1rrAa+Q6hVOqVg9e7eAf32MdmSmU=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA6PR21MB4534.namprd21.prod.outlook.com (2603:10b6:806:424::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.3; Sun, 11 May
 2025 18:30:52 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%6]) with mapi id 15.20.8769.001; Sun, 11 May 2025
 18:30:52 +0000
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
Subject: RE: [PATCH rdma-next v4 3/4] RDMA/mana_ib: unify mana_ib functions to
 support any gdma device
Thread-Topic: [PATCH rdma-next v4 3/4] RDMA/mana_ib: unify mana_ib functions
 to support any gdma device
Thread-Index: AQHbv2j4dgFT3+xitEi4BlzGlPZJ9LPNxscg
Date: Sun, 11 May 2025 18:30:52 +0000
Message-ID:
 <SA6PR21MB42311EDDB1757E82740BC041CE94A@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1746633545-17653-1-git-send-email-kotaranov@linux.microsoft.com>
 <1746633545-17653-4-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1746633545-17653-4-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=49cb003e-b4a2-4e6b-a736-4d383ae9c534;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-05-11T18:30:41Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA6PR21MB4534:EE_
x-ms-office365-filtering-correlation-id: 7aa5c092-36ef-4271-e98c-08dd90b9f5a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1B6uX2ZDpJsZwOk98JFoS9WMdBXyYInL54p8/NIdHKY+5KDtw/ORqQuXZZqV?=
 =?us-ascii?Q?e3xTx1cPbk/mkEtnPZlOI0RKuQDQHvcBplsnASN9G/Map6f9z5c2g6hmtYi4?=
 =?us-ascii?Q?cwEN8qAuYUGHDRGjnsX73VRGQtFoJGuzMWfM8ePySqO3rsnhJteY8WzRtPNI?=
 =?us-ascii?Q?nqLO4AjFCeUbRU2c7NIRXoVmBzP15bVc107CmIhDys/Q1Mv0vcCjbDsEHVe8?=
 =?us-ascii?Q?ckTR8XmR9qk4vQZVntnoF+FsNdAbnrNJMg8dMkFVui7oRA/ZOD5h1Sq/3WKR?=
 =?us-ascii?Q?RHkas30LvEbQSkK9g2cbmf50ziWFPbxFbHJ4eXrM3qzOYHlJvadoDG7RXJrw?=
 =?us-ascii?Q?C9snigfZuNTG0/H8mGyq38EZuIKTiKBA5dO+Ph5vMiXtj/2sDjxnFHXFb53T?=
 =?us-ascii?Q?nytT0YJzKR0xCxYi4AsBsE8DbEpSNh61DaCYBm12uMxZ3nPLe3Hbev2lfKic?=
 =?us-ascii?Q?4nEeXgjth4XAbt8LvdmZncimqFM1hy28jZwWBZCGxjrpBXthEpF0gfSiTJMh?=
 =?us-ascii?Q?4CipTkVE8/lqIM+jwtzMmLvGsDQSg9p/uhJwl7j7FQCxfqOd9Xf/BOFUjbw5?=
 =?us-ascii?Q?WSuedV6OlCk1cXTvn6qzqiKCQExZgXx1MEcklBNCjIEFCuvEX0xdFFV9TkX+?=
 =?us-ascii?Q?EwhXXHAj8gpMdr+EDHMXo0E1jPc5C2dFnpYGsoyt+rndFXTip9jynr0/nCKL?=
 =?us-ascii?Q?lo30KRpKqizAUCLQI/EVNx+bWlwiuUbdf3OsUJ/FUBQUKDdXsKSeKHFGxnB2?=
 =?us-ascii?Q?EFK/tKI7N+SctS68OabAoATzGs0C5bTtQ67gXKmNCB3DG3Bl2OiODhKDzDqm?=
 =?us-ascii?Q?8+YCcIhbCelKw9t6CzAqE0hkT+jRaFT9nMD3ALnv5SXiC2uV6pr2CU3wAZFo?=
 =?us-ascii?Q?LuOzFeyLQGj746164J4eNmteS2S68wqgfLLtWo+Cm20TG3ziOecNl/TOsEoG?=
 =?us-ascii?Q?St06iXbN6gKtAaTMz1SZc3O9/kszf3XtmK03FPZHERdudC1be1g+GH4+tTa+?=
 =?us-ascii?Q?BDmtw1bP4WSU7Mk8SVUgQNkYQTl4D7HszpWMLP48LtEQYulypjvw3ub6Rsru?=
 =?us-ascii?Q?QT0Wkd3tT7h83Ol9yzKsD23n2f8siB+0WJPCVHF9Prg4nl/cQispsWASygUa?=
 =?us-ascii?Q?1YhF7Cx1WwO6SNSikAYLbKEk2aymoW/+kCSY9sy8PC8rWweI+qKzLkHVaUst?=
 =?us-ascii?Q?MdAkKbEjvhBVb7sGexJkKvdSBpoVTdR0az+8ffGiGPf2oyC1M3TLmG8eqCdo?=
 =?us-ascii?Q?E7VIpgoYfGBKTquLe37KyuB+42dmoArlur6HGUf8mw9OJFSQnozD0MolC/+v?=
 =?us-ascii?Q?OFRxh38jqv+Vh5hjvos1MLhaBqJryOCQDefKf88zXF9/mzQ3ZL/y0hSpSasA?=
 =?us-ascii?Q?OpcLvFCGmAxZaY/jO6uqd3oqcqcGIggwZ91CE+QHNy8+u/9ZzujBDXSHA4YJ?=
 =?us-ascii?Q?7nSwK64iO3dZaAH1yCKC4T//culyBfl1CWgoIUgTUhq6lCdwGfyjNFi8cv2S?=
 =?us-ascii?Q?tbRWJQyNEfb6wac=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Hr7Rwd5nWAsy1mMfxmvcf6rm1QkIslhiPXKuG2Y1Lk8Mp+nPuMLuqjI5a0vn?=
 =?us-ascii?Q?KNoT/EcL1OIUMzgEa3QnZTUkvIDkgCUnl+XKIGZosb64xdL6TVCOEA3YXR/e?=
 =?us-ascii?Q?vbXG2QrNMrsRB26XWZforoS7RbI3vZSD43ufN4HTOJhUQ/Z6UgHBC5gj/2tS?=
 =?us-ascii?Q?ySOC7hjVBdYlDuMw7H4qeh+r3LE6csqwbx4tGCdiBoDXkuAP/G8VnAjSaDR4?=
 =?us-ascii?Q?yjJ8aNOFdsqE4OaxCKJzmnRGGSAtl21fwEcbCkaCtkGdIO2d+HofXtZC+zKA?=
 =?us-ascii?Q?zyJc0gUfzBr8LRVm6nQxdl9fxfCAYDNdWNnI+x5dXakAS0Uto+xeTUTZARRI?=
 =?us-ascii?Q?uiotZF/1MRqL9zUevd+L9tsOqxFKgpFdHSARMswYbm/bGssmANlfPjZlIyly?=
 =?us-ascii?Q?bKqVzm2MAv6dPjaKp/8JGa1+dttPQlgdE0J8iwoBd3/KnbHW1RBkE4pEZRM6?=
 =?us-ascii?Q?i+UMHX73TqHuSTZ0i1PwIIV8xunhy08pM1owNKLxt43uwfnsZjQPLvBQFaI7?=
 =?us-ascii?Q?4ZmW49Tpsj2ZQWlcRyHNn7QV/vGx5aJLfCJzB+8Jj911rSf2Cupc4c6l02g7?=
 =?us-ascii?Q?HhrnHyfpcp4lysdxGaHx4C7aroUK3T/Oah5qtWhUrqD68CNM7V6/QAaTND4/?=
 =?us-ascii?Q?vpvQyWda5zhBgUWdFbMRZGa0adooudrLr9t5oZrgU3c570SLZnXNeEu/7bmT?=
 =?us-ascii?Q?8bpsLyQzw24LAreqcGVBnnbUyi4ZXa5uOlEbTh4iqSMkoKWPNjtWc4TVZu2j?=
 =?us-ascii?Q?QLvQfGx+EIC9NnFck/HJMabiVopubRT3b0abXfkg2OKP6dlW2OaDqIkTwNwk?=
 =?us-ascii?Q?L+7PSYFFddASi/0Pd1jMPnt17ex0wOzXHrKtT69rbX4Xfu+X9pQNksDjMpKE?=
 =?us-ascii?Q?7t1JY2ioDr7V6RPx+9N3FiBAkY1U2Yj2Of/2ETJLaMeG6QGR0/KysA5dI+ng?=
 =?us-ascii?Q?MMiyk7tibMsaajB2aQEvznx/j6naHPM6LADRMIbSn5PMgUaum51gUkueY0hR?=
 =?us-ascii?Q?7yPGGJuMvcePGKJLMflozkOufPv7wmmjOVbaqsZRh8hJqpMy/FmtEgNwLyaH?=
 =?us-ascii?Q?rX+JLK4OKsNa2y2Pj4PkLdhwrXdYOSMTpuriz+ULw1qAS7pAw+crecaGRHMp?=
 =?us-ascii?Q?Z4FGoOB80aDMqfENEuHCmEel0TYQiRZVsgv0xYbGdy7ZKo9heAHjMM5g+6fl?=
 =?us-ascii?Q?q58DIbBIlVL72V8NojpGeLIgyJYouFIDK8l93pcK+4+TyaPKbNweKNNM7EUc?=
 =?us-ascii?Q?p5GAXvGvhlE0L4bnfnkUgO3VrKbrbDB1AhTB8HU9HV6LTrmm+Cm9faOjlkcL?=
 =?us-ascii?Q?9OQrgWydqomTwQcdwYsoUaHDndr17r4iux85RrDYZVlQqE4JVRIXgZIcRfN1?=
 =?us-ascii?Q?74hh05YqPBS3ORC5C0KP+bRosv0MdzxZ6YCpVMM5I80dLNh1j4SqpEkog0Q0?=
 =?us-ascii?Q?jk6L9dkLAe5IgOoHMDXAJ6fr4vB5QxLc7dS/MNX369AAvMoCkttR5fZw3AEw?=
 =?us-ascii?Q?87XnHvUH2XLxSMQskNLofRzMDtRjiJZb/surk/fskLSppHaQcI9UpXgJrIZ3?=
 =?us-ascii?Q?lmdsuPapJa/Jb3FP/nRcWorQt2uOzQPpZzlO/P2l?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa5c092-36ef-4271-e98c-08dd90b9f5a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2025 18:30:52.0445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CGkXhydiQhnM9cx4kGZrj0+rYcI87jQbKpkQ0Mx2snNygZjgtvDXz2Ia5TBHnc23Gsl7zuT2XoGpU6tcduyjYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR21MB4534



> -----Original Message-----
> From: Konstantin Taranov <kotaranov@linux.microsoft.com>
> Sent: Wednesday, May 7, 2025 8:59 AM
> To: Konstantin Taranov <kotaranov@microsoft.com>; pabeni@redhat.com;
> Haiyang Zhang <haiyangz@microsoft.com>; KY Srinivasan <kys@microsoft.com>=
;
> edumazet@google.com; kuba@kernel.org; davem@davemloft.net; Dexuan Cui
> <decui@microsoft.com>; wei.liu@kernel.org; Long Li <longli@microsoft.com>=
;
> jgg@ziepe.ca; leon@kernel.org
> Cc: linux-rdma@vger.kernel.org; linux-kernel@vger.kernel.org;
> netdev@vger.kernel.org
> Subject: [PATCH rdma-next v4 3/4] RDMA/mana_ib: unify mana_ib functions t=
o
> support any gdma device
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Use the installed gdma_device instead of hard-coded device in requests to=
 the
> HW.
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/infiniband/hw/mana/cq.c   |  4 +---
>  drivers/infiniband/hw/mana/main.c | 27 +++++++++++++--------------
>  drivers/infiniband/hw/mana/qp.c   |  5 ++---
>  3 files changed, 16 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana=
/cq.c
> index 0fc4e26..28e154b 100644
> --- a/drivers/infiniband/hw/mana/cq.c
> +++ b/drivers/infiniband/hw/mana/cq.c
> @@ -15,14 +15,12 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struc=
t
> ib_cq_init_attr *attr,
>  	struct ib_device *ibdev =3D ibcq->device;
>  	struct mana_ib_create_cq ucmd =3D {};
>  	struct mana_ib_dev *mdev;
> -	struct gdma_context *gc;
>  	bool is_rnic_cq;
>  	u32 doorbell;
>  	u32 buf_size;
>  	int err;
>=20
>  	mdev =3D container_of(ibdev, struct mana_ib_dev, ib_dev);
> -	gc =3D mdev_to_gc(mdev);
>=20
>  	cq->comp_vector =3D attr->comp_vector % ibdev->num_comp_vectors;
>  	cq->cq_handle =3D INVALID_MANA_HANDLE;
> @@ -65,7 +63,7 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct
> ib_cq_init_attr *attr,
>  			ibdev_dbg(ibdev, "Failed to create kernel queue for
> create cq, %d\n", err);
>  			return err;
>  		}
> -		doorbell =3D gc->mana_ib.doorbell;
> +		doorbell =3D mdev->gdma_dev->doorbell;
>  	}
>=20
>  	if (is_rnic_cq) {
> diff --git a/drivers/infiniband/hw/mana/main.c
> b/drivers/infiniband/hw/mana/main.c
> index 3837e30..41a24a1 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -244,7 +244,6 @@ void mana_ib_dealloc_ucontext(struct ib_ucontext
> *ibcontext)  int mana_ib_create_kernel_queue(struct mana_ib_dev *mdev, u3=
2
> size, enum gdma_queue_type type,
>  				struct mana_ib_queue *queue)
>  {
> -	struct gdma_context *gc =3D mdev_to_gc(mdev);
>  	struct gdma_queue_spec spec =3D {};
>  	int err;
>=20
> @@ -253,7 +252,7 @@ int mana_ib_create_kernel_queue(struct mana_ib_dev
> *mdev, u32 size, enum gdma_qu
>  	spec.type =3D type;
>  	spec.monitor_avl_buf =3D false;
>  	spec.queue_size =3D size;
> -	err =3D mana_gd_create_mana_wq_cq(&gc->mana_ib, &spec, &queue-
> >kmem);
> +	err =3D mana_gd_create_mana_wq_cq(mdev->gdma_dev, &spec, &queue-
> >kmem);
>  	if (err)
>  		return err;
>  	/* take ownership into mana_ib from mana */ @@ -784,7 +783,7 @@
> int mana_ib_create_eqs(struct mana_ib_dev *mdev)
>  	spec.eq.log2_throttle_limit =3D LOG2_EQ_THROTTLE;
>  	spec.eq.msix_index =3D 0;
>=20
> -	err =3D mana_gd_create_mana_eq(&gc->mana_ib, &spec, &mdev-
> >fatal_err_eq);
> +	err =3D mana_gd_create_mana_eq(mdev->gdma_dev, &spec,
> +&mdev->fatal_err_eq);
>  	if (err)
>  		return err;
>=20
> @@ -835,7 +834,7 @@ int mana_ib_gd_create_rnic_adapter(struct
> mana_ib_dev *mdev)
>=20
>  	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CREATE_ADAPTER,
> sizeof(req), sizeof(resp));
>  	req.hdr.req.msg_version =3D GDMA_MESSAGE_V2;
> -	req.hdr.dev_id =3D gc->mana_ib.dev_id;
> +	req.hdr.dev_id =3D mdev->gdma_dev->dev_id;
>  	req.notify_eq_id =3D mdev->fatal_err_eq->id;
>=20
>  	if (mdev->adapter_caps.feature_flags &
> MANA_IB_FEATURE_CLIENT_ERROR_CQE_SUPPORT)
> @@ -860,7 +859,7 @@ int mana_ib_gd_destroy_rnic_adapter(struct
> mana_ib_dev *mdev)
>=20
>  	gc =3D mdev_to_gc(mdev);
>  	mana_gd_init_req_hdr(&req.hdr, MANA_IB_DESTROY_ADAPTER,
> sizeof(req), sizeof(resp));
> -	req.hdr.dev_id =3D gc->mana_ib.dev_id;
> +	req.hdr.dev_id =3D mdev->gdma_dev->dev_id;
>  	req.adapter =3D mdev->adapter_handle;
>=20
>  	err =3D mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp=
);
> @@ -887,7 +886,7 @@ int mana_ib_gd_add_gid(const struct ib_gid_attr *attr=
,
> void **context)
>  	}
>=20
>  	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CONFIG_IP_ADDR,
> sizeof(req), sizeof(resp));
> -	req.hdr.dev_id =3D gc->mana_ib.dev_id;
> +	req.hdr.dev_id =3D mdev->gdma_dev->dev_id;
>  	req.adapter =3D mdev->adapter_handle;
>  	req.op =3D ADDR_OP_ADD;
>  	req.sgid_type =3D (ntype =3D=3D RDMA_NETWORK_IPV6) ? SGID_TYPE_IPV6 :
> SGID_TYPE_IPV4; @@ -917,7 +916,7 @@ int mana_ib_gd_del_gid(const struct
> ib_gid_attr *attr, void **context)
>  	}
>=20
>  	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CONFIG_IP_ADDR,
> sizeof(req), sizeof(resp));
> -	req.hdr.dev_id =3D gc->mana_ib.dev_id;
> +	req.hdr.dev_id =3D mdev->gdma_dev->dev_id;
>  	req.adapter =3D mdev->adapter_handle;
>  	req.op =3D ADDR_OP_REMOVE;
>  	req.sgid_type =3D (ntype =3D=3D RDMA_NETWORK_IPV6) ? SGID_TYPE_IPV6 :
> SGID_TYPE_IPV4; @@ -940,7 +939,7 @@ int mana_ib_gd_config_mac(struct
> mana_ib_dev *mdev, enum mana_ib_addr_op op, u8
>  	int err;
>=20
>  	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CONFIG_MAC_ADDR,
> sizeof(req), sizeof(resp));
> -	req.hdr.dev_id =3D gc->mana_ib.dev_id;
> +	req.hdr.dev_id =3D mdev->gdma_dev->dev_id;
>  	req.adapter =3D mdev->adapter_handle;
>  	req.op =3D op;
>  	copy_in_reverse(req.mac_addr, mac, ETH_ALEN); @@ -965,7 +964,7
> @@ int mana_ib_gd_create_cq(struct mana_ib_dev *mdev, struct mana_ib_cq
> *cq, u32 do
>  		return -EINVAL;
>=20
>  	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CREATE_CQ, sizeof(req),
> sizeof(resp));
> -	req.hdr.dev_id =3D gc->mana_ib.dev_id;
> +	req.hdr.dev_id =3D mdev->gdma_dev->dev_id;
>  	req.adapter =3D mdev->adapter_handle;
>  	req.gdma_region =3D cq->queue.gdma_region;
>  	req.eq_id =3D mdev->eqs[cq->comp_vector]->id; @@ -997,7 +996,7 @@
> int mana_ib_gd_destroy_cq(struct mana_ib_dev *mdev, struct mana_ib_cq *cq=
)
>  		return 0;
>=20
>  	mana_gd_init_req_hdr(&req.hdr, MANA_IB_DESTROY_CQ, sizeof(req),
> sizeof(resp));
> -	req.hdr.dev_id =3D gc->mana_ib.dev_id;
> +	req.hdr.dev_id =3D mdev->gdma_dev->dev_id;
>  	req.adapter =3D mdev->adapter_handle;
>  	req.cq_handle =3D cq->cq_handle;
>=20
> @@ -1023,7 +1022,7 @@ int mana_ib_gd_create_rc_qp(struct mana_ib_dev
> *mdev, struct mana_ib_qp *qp,
>  	int err, i;
>=20
>  	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CREATE_RC_QP, sizeof(req),
> sizeof(resp));
> -	req.hdr.dev_id =3D gc->mana_ib.dev_id;
> +	req.hdr.dev_id =3D mdev->gdma_dev->dev_id;
>  	req.adapter =3D mdev->adapter_handle;
>  	req.pd_handle =3D pd->pd_handle;
>  	req.send_cq_handle =3D send_cq->cq_handle; @@ -1059,7 +1058,7 @@
> int mana_ib_gd_destroy_rc_qp(struct mana_ib_dev *mdev, struct mana_ib_qp
> *qp)
>  	int err;
>=20
>  	mana_gd_init_req_hdr(&req.hdr, MANA_IB_DESTROY_RC_QP,
> sizeof(req), sizeof(resp));
> -	req.hdr.dev_id =3D gc->mana_ib.dev_id;
> +	req.hdr.dev_id =3D mdev->gdma_dev->dev_id;
>  	req.adapter =3D mdev->adapter_handle;
>  	req.rc_qp_handle =3D qp->qp_handle;
>  	err =3D mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp=
);
> @@ -1082,7 +1081,7 @@ int mana_ib_gd_create_ud_qp(struct mana_ib_dev
> *mdev, struct mana_ib_qp *qp,
>  	int err, i;
>=20
>  	mana_gd_init_req_hdr(&req.hdr, MANA_IB_CREATE_UD_QP, sizeof(req),
> sizeof(resp));
> -	req.hdr.dev_id =3D gc->mana_ib.dev_id;
> +	req.hdr.dev_id =3D mdev->gdma_dev->dev_id;
>  	req.adapter =3D mdev->adapter_handle;
>  	req.pd_handle =3D pd->pd_handle;
>  	req.send_cq_handle =3D send_cq->cq_handle; @@ -1117,7 +1116,7 @@
> int mana_ib_gd_destroy_ud_qp(struct mana_ib_dev *mdev, struct mana_ib_qp
> *qp)
>  	int err;
>=20
>  	mana_gd_init_req_hdr(&req.hdr, MANA_IB_DESTROY_UD_QP,
> sizeof(req), sizeof(resp));
> -	req.hdr.dev_id =3D gc->mana_ib.dev_id;
> +	req.hdr.dev_id =3D mdev->gdma_dev->dev_id;
>  	req.adapter =3D mdev->adapter_handle;
>  	req.qp_handle =3D qp->qp_handle;
>  	err =3D mana_gd_send_request(gc, sizeof(req), &req, sizeof(resp), &resp=
);
> diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana=
/qp.c
> index c928af5..14fd7d6 100644
> --- a/drivers/infiniband/hw/mana/qp.c
> +++ b/drivers/infiniband/hw/mana/qp.c
> @@ -635,7 +635,6 @@ static int mana_ib_create_ud_qp(struct ib_qp *ibqp,
> struct ib_pd *ibpd,  {
>  	struct mana_ib_dev *mdev =3D container_of(ibpd->device, struct
> mana_ib_dev, ib_dev);
>  	struct mana_ib_qp *qp =3D container_of(ibqp, struct mana_ib_qp, ibqp);
> -	struct gdma_context *gc =3D mdev_to_gc(mdev);
>  	u32 doorbell, queue_size;
>  	int i, err;
>=20
> @@ -654,7 +653,7 @@ static int mana_ib_create_ud_qp(struct ib_qp *ibqp,
> struct ib_pd *ibpd,
>  			goto destroy_queues;
>  		}
>  	}
> -	doorbell =3D gc->mana_ib.doorbell;
> +	doorbell =3D mdev->gdma_dev->doorbell;
>=20
>  	err =3D create_shadow_queue(&qp->shadow_rq, attr->cap.max_recv_wr,
>  				  sizeof(struct ud_rq_shadow_wqe)); @@ -736,7
> +735,7 @@ static int mana_ib_gd_modify_qp(struct ib_qp *ibqp, struct
> ib_qp_attr *attr,
>  	int err;
>=20
>  	mana_gd_init_req_hdr(&req.hdr, MANA_IB_SET_QP_STATE, sizeof(req),
> sizeof(resp));
> -	req.hdr.dev_id =3D gc->mana_ib.dev_id;
> +	req.hdr.dev_id =3D mdev->gdma_dev->dev_id;
>  	req.adapter =3D mdev->adapter_handle;
>  	req.qp_handle =3D qp->qp_handle;
>  	req.qp_state =3D attr->qp_state;
> --
> 2.43.0


