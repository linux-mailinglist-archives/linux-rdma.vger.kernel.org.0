Return-Path: <linux-rdma+bounces-1455-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A7287D24D
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Mar 2024 18:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAC5328465F
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Mar 2024 17:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44E451026;
	Fri, 15 Mar 2024 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="InBD0rju"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11022010.outbound.protection.outlook.com [52.101.56.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED7851005;
	Fri, 15 Mar 2024 16:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521816; cv=fail; b=FJ7eKyEd9rxT0laYuULIcSzxpta9yiZ61GwvsmbBsXp774q3zLHq8/FkdDJnKn+F86U8wrG1JC4CxZb0ywiOO0jbeMmkIMS9Wi9Zxxc6cNEnHiuT6GmSc6/8Q1J2qNFdBFqAEfQKwbkhiAb6taknnSo6PR59GOYvtBs3SpRttX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521816; c=relaxed/simple;
	bh=wxksMGPD6YgE5E/H4yEJmNkSLrgpazIY/d6KMm4ziNo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F8oRo9ciJHAw2wcZu2NjCqdLQ3VlfgtNNCo4gMGZ74X0PgWanEilfPtjRl0EvKedefOTHsmT3xFXNCSY+wCm+E5B1tmqUj0EPLfgHJR7uaYrmJdHuGzaCSn0GszvSOWVaeTCTyAbpkIGz11Gk+1MI+rkZW2fShR2ySXVPaNwK6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=InBD0rju; arc=fail smtp.client-ip=52.101.56.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibTj1er7UySuYs12FD3fDhTqhdR2QxZhu+a842Rgb5mTjVAyMZcekGyBC2X2LFZn1MEsc1XT2VfvDYYmqAGpX3bplB/a38tp0Qe2prvzsE0zxw8qzAWBzwfWH4wEmL0h/67JIUglGCkkcYZz/LyEbcYA7ZciY3iapZMAdbCSPkpldhpmeus6sx6rOo+++gwAAQYc4vdufmW39zNfKfiyS3pLh8TCQOjqplb+AU1FcabGVYq+rHNbao1tiOzHLxg1EDtxoQc8DYr4uIDEEf8+hSDFRihJQE6Q4saRAX0hJCfx2Whusl74lLyZFSegkuw+6QHiYHHFOaIb8lTfjiJEcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxksMGPD6YgE5E/H4yEJmNkSLrgpazIY/d6KMm4ziNo=;
 b=J6ac6qkqneKKxizX/HIbtumZstF2mMDyzLpd0Z+vK+g4zI5olr/WfZymcCsN8VqMXY8U9KNXMWXLzSbIc5OxhGwjgm2vJHpW8bmtdorn0+v8Qs3zW0vr7T5uovCWpIMeHmbkYItxTknp2q6WGvYDnpiE2p3zEdIYewv1OxwJrbDN+K11yqJjCy9+S9vYW7gXgUDPUMRo1YL5Dne3wCibhbbS41MoUTJhzenhQpN0m3Escr/09LgboRU5+tC5GXwZbo5C03+BMWVmtUZDsfChelKiuKqPg/MTJ5E9HuMLsQbx/afc36UuD+si2W7QLMp+W9T0cuc+3y0yJiPIlu3lDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxksMGPD6YgE5E/H4yEJmNkSLrgpazIY/d6KMm4ziNo=;
 b=InBD0rjudo7BNcVg0XqajQrFMxnUgRgzy79DcZF7l+boP/yG7ipeC0T/vyfEC2SjllmqBfp5QgkDYkoiwZj8x1AnniiIS2hW/cksKpIzdqtKrnaEUuNKRHeHu36AIZ8/jZbKaJ3KpoKzxU3LZhbEOJ4hyU2PEGoIMZcC7C/6aRk=
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com (2603:10b6:a03:453::5)
 by DM4PR21MB3178.namprd21.prod.outlook.com (2603:10b6:8:66::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.9; Fri, 15 Mar 2024 16:56:51 +0000
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7]) by SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7%4]) with mapi id 15.20.7409.007; Fri, 15 Mar 2024
 16:56:51 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next 3/4] RDMA/mana_ib: Use struct mana_ib_queue for
 WQs
Thread-Topic: [PATCH rdma-next 3/4] RDMA/mana_ib: Use struct mana_ib_queue for
 WQs
Thread-Index: AQHadUneIulBBsFK3Ee3SDT3496+3rE5COLQ
Date: Fri, 15 Mar 2024 16:56:51 +0000
Message-ID:
 <SJ1PR21MB345739B9A82958585EF9C0CACE282@SJ1PR21MB3457.namprd21.prod.outlook.com>
References: <1710336299-27344-1-git-send-email-kotaranov@linux.microsoft.com>
 <1710336299-27344-4-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1710336299-27344-4-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=46f606cb-63bf-43ec-a864-df9e5bbc8368;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-03-15T16:56:32Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR21MB3457:EE_|DM4PR21MB3178:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 EtblcWxGOc98AcxTo9qdl1kuNXiOXAtW9/YcA5DqS/qoGXhZl/ZaK0ZLhtjpBD5dVfjDjqi4OWq78JqUtD0305SnlSrW4MOdFGo9rTrjQcx7Twj/bup6KSeYBkLlfN7YIaEzW9deQYx8sc7ojmbq75iGZMYBlbTGo78GzK97jIj5bkwRqe2sZ3i+mqAl5uxCqB92i+VLn/+UpPUIWs7TNiOauylZahbTfTfbrGtZgjv6/6luYVlxjtipIhDKikDycwm+qL1cIZnKNlH+KY0l3TDd5gNI+jFFyZFB7bttsNnpWj9NfFBaqdMwwClzTce3zQTuTlHpcvGaMnuxX5vMo6qgiCy6H578qpbUGqJVhD8EMjy3xBOk8fsqTAdVlzNzmkefgMdT+aqCeqtyIr5i3pTS+upq0PDwuv3fWsUATJaINvP1XAFUl+pvlRN08PyTHQPYpyXa1baROHppqAwQeU1QnApjaS+LKU9hVQ/YaK7IfNCWEJC3h9becBpjc4V9F3BigW7mMJTp3qtg1M77/FLJQs5Yfx3ujQATaYfmAjiDoDA4HKzR3w1xMP3pgOadankAwgEOE15RhaCD/Ze1YyE/S0D1+mXb1FbPjHN+4V7Acjb2NXEgGAsrifaQZE3gfKZZeL6INUjWQeX+QDBtvlJGGp0TrsTm1DNR9FQK64s=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR21MB3457.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?o1SJ2UGYY1qrZGy6OwIRmT792BsNwx0LUyDdmvEHk7jecXIxXOH4jTtM7H+Q?=
 =?us-ascii?Q?fo6MEcmHkboADpTWqNVxoVZg/UV270jinnwqTWRlra79g6IHAM2eqsjpTNbx?=
 =?us-ascii?Q?3LfeRK6sM4AWGoNAyQygUw0bg3+uP8TTYLXo7qnZRRr8J2SBDYGP+QLYzLZS?=
 =?us-ascii?Q?l+KggmMw6m4twcS4R5uSvERu2k61s4LBlAn8/Q/8EyClPpMUBMDFcdzAsuHO?=
 =?us-ascii?Q?K6rSmCmkNuY9gHwB0IOFs4cII+FW5GYg4ewOIFHfzkLA8il12POzn44R8+b8?=
 =?us-ascii?Q?7+7xdn4X6CMRfUXqiXRv9FBCCJSnJfV04XljRZK2RUJdEcaplNatN+4J8c8L?=
 =?us-ascii?Q?+2i6kS49GvKltoVes10/SRwa7V0VdDNlMZ2pJlHDNI3zGqxbKF1cnKUsdTlq?=
 =?us-ascii?Q?3cEZhVrVMZ/4hOo3n/x6bSSUNLTihnSYSzQeXQ8nCUoV6Hc0Q/U13shCzPuG?=
 =?us-ascii?Q?H8Kn1iNFr6hum87Z1861JsP0X//+VuVXk2o5Nds4dQmPwt3KcfJePxKi5QPu?=
 =?us-ascii?Q?EDIa8vWT9ucsC8arX8QCSi3lZWKMZ5zspubASW++OZa9qNxH7TQYtUJKjYKy?=
 =?us-ascii?Q?OhI7oQ3uILq8CKs5FBllV+dasmEB0C0VnRVmnsR9QWX9KLayvqftKEE+Lwuo?=
 =?us-ascii?Q?NqQXRMUMXhTvLxZ8Cymcfdwhl7zcnK/Vc7yyMJa4NUvo9jP1OYskujy62afJ?=
 =?us-ascii?Q?7om22CBZGq1zsi2KZXDh+9liNQLcNzHIdRbqCoBZmGjzc4aydHFyOM6Cd/0c?=
 =?us-ascii?Q?lpBOp0zqb+ba5PM0tBdPE9g3H1IUX48gX8UxDsSpAR/qzBrRBA6Ih2MV0mHC?=
 =?us-ascii?Q?qKb/dAnC7QPegm9pJwwFUf01nieMFSEXl0zAwjIKvuMaoARY5ul4f13i+h5e?=
 =?us-ascii?Q?l/YwgeqoGSXg3v50aqqm4eh//tCdMlPfjqgguVFrPtahmPI5/eB3th/um2pA?=
 =?us-ascii?Q?su//adCkK8sb0HTPJUhYMy50xYy4xuJ4Ii6/tvb2VdiEUpVMxFHfHfzal6PS?=
 =?us-ascii?Q?LQCwD0B5AJSXK2KIpSl5CIq6NX9Q6HNsjEaYPRQ/U1+BRiqSfzb3wxTAU8sq?=
 =?us-ascii?Q?AdHYeF0Wg+fBsYpWIjCNdx8rn3ASr7zEeC+m9Lf9Px3M+3PtYGVqvsOzgfBp?=
 =?us-ascii?Q?Uhm2r7IyErj03oAjk3YrEz/SdTi2e4mxgwbCOBDWIwpBLLNb1gLKxIA4jfgQ?=
 =?us-ascii?Q?wlq54DdWglMsApmkZ2kVQkN/k+PVP50HY2RzsaEmreSX1YfABQzTtYIDTc61?=
 =?us-ascii?Q?JkKJZiWomIYI4gcwzorJg6KHfpdb4nRsjKrdaNA6nemghZzilCi0sm/YL6co?=
 =?us-ascii?Q?jZXoMapf/La2Ifa3RI/J2ChNQFkls/UvM2Pd1RRbWEdRNTqc0JTa7ujhqn6j?=
 =?us-ascii?Q?s7udi2jg1bqbkTD7MwE/yTX3MA2MQx6oQrJ24FD04pbNV8LykjNHNK4Vg2nD?=
 =?us-ascii?Q?62xF0tajecVjqBHKPBP6JFROpNjibk9qd2iqqaowkjpXaqSqpEGN0cOA/mWp?=
 =?us-ascii?Q?L2saSxM2izFjkSpet3NErLLQYCuc41flKZNIcm8af+DcQlWoqtjdDWWPITPK?=
 =?us-ascii?Q?YqzFhk3fHjTA+FgxiGmkd5C6m7QVZQzwYSN/t+SA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 84184324-7d2e-4626-d0c9-08dc4510e96b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 16:56:51.7221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8mjrskqeCpM+c0zqa2fKVSLEs5aUzyV6LgJaafPLqUctzll2DPpsXv1aT9KyQzlbBBqdtoD5G+0bV6bYzmgc+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3178



> -----Original Message-----
> From: Konstantin Taranov <kotaranov@linux.microsoft.com>
> Sent: Wednesday, March 13, 2024 6:25 AM
> To: Konstantin Taranov <kotaranov@microsoft.com>;
> sharmaajay@microsoft.com; Long Li <longli@microsoft.com>; jgg@ziepe.ca;
> leon@kernel.org
> Cc: linux-rdma@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH rdma-next 3/4] RDMA/mana_ib: Use struct mana_ib_queue for
> WQs
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Use struct mana_ib_queue and its helpers for WQs
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>


