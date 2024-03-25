Return-Path: <linux-rdma+bounces-1547-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6481988B029
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 20:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 202B0303BCD
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Mar 2024 19:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B236718EA1;
	Mon, 25 Mar 2024 19:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Gr2SJQ88"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11021006.outbound.protection.outlook.com [52.101.85.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E683DAC18;
	Mon, 25 Mar 2024 19:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711395461; cv=fail; b=PiA2/XIXqHXWqp3STB0QBQUYw/y7yYsmzWaXBGDM/dyj+ipqbwkkEnignd/Ziad6jAjS3q5cefoJuphyKyznZsNbd0WCASxRA6fOMUWZPxesLnPHwRCUY+VqF1FGiAiQmdU3brGxbH02LnRketQabVDBGHPj2J183xLipbMXolE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711395461; c=relaxed/simple;
	bh=lAMxxgF+u4TJZNHH02UAXAIQ0Hts2AmZqLnvyAbC0Wg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V05kc03RqA+QDNZ+/jmd2hvQiWpIId95ctgUg6aDF3vuTr1k4tCeb12sU8tD5y8fXxzyA6HxJrM2pDm5IzrpMFbfJSHYq3VWom6DaqUs1rDRmvgRpE07jBNXWvcAqLzlqmauqtvUI2AdQBvjhG/E2KVX77RYzM3JvtDx16avRWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Gr2SJQ88; arc=fail smtp.client-ip=52.101.85.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkWZspZjzZ7JS7Jqn5w83zqqjgj0Yns1glnaMi2DlXyasWCkj0YQIqk13oKoVK2COwX+TU3vggt+OkI6nsnZLjnibbgitiIvXFxNVxdjqzvEyS6duN347aWfjMq8hYMP4tUNdWKZ4u7ZK4zLFlgFqjJpcNhATLcxZseKxVLffEeZRCuYh++CGtsgyo7BmuS+8a29v+55HvOYr5DDGduTz8XwNywfuqlkEAmwNQvNn2sxY50hMOCWAhbJfSlxrDnN3xc/i+j9fqtycDVZ7iWWa6N0+RnbKrnwdjcRXd9CS2eq6T8j3n38+PxeZTHc4t7P3GofXrdY9GeLQSnxbG2lmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAMxxgF+u4TJZNHH02UAXAIQ0Hts2AmZqLnvyAbC0Wg=;
 b=ONq/vVi1Dxm1a1VTII0XQb6dJYIdNwQ+3Zjf67wtVKkktRZMGG4LOH4RVgQbpf8AtTDOnhsUqlsVBZfxGX+/ojiiJ0G8/VuR8yrqQ1eQUHDh5rfNeWHpn9O0QH7dg2KeRKfbvQP6AXvDavU2WNP7quBl6w61J7+IZ17+zA9guT9rQeCLrZJl+BDKqAxY7tZP16CqQ0UwqNXfzFiokG/b4m0+9cWYxoE7zc/TRW8NiT21BRkobSJC2Xo3YrSviE6ojE+7u16YHpRb0GuhhJ2AfEIkA6HxAHvgTzqpVgKgzans8Vg3xNzo0zzkXhASR9RyOVpXU/FhCk3gyXZQiTSJAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAMxxgF+u4TJZNHH02UAXAIQ0Hts2AmZqLnvyAbC0Wg=;
 b=Gr2SJQ88v/kkAX27Zvu75ACNS2CCjPgc77a90Zj5YxjFT1Y5/+meOyofIhHVJFh6aLr+jCoOYcdsFx+R/rqb3YS9diPSeD44x+Vn1MseSLp4hMQRZHddt9Lxtq2SRs57GY/8geOBKKwRLjGkfMR7jtXPom1nu0zjeCBXbYFq5WM=
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com (2603:10b6:a03:453::5)
 by BYAPR21MB1319.namprd21.prod.outlook.com (2603:10b6:a03:115::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.20; Mon, 25 Mar
 2024 19:37:37 +0000
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7]) by SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7%4]) with mapi id 15.20.7430.017; Mon, 25 Mar 2024
 19:37:37 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next v2 3/4] RDMA/mana_ib: Use struct mana_ib_queue
 for WQs
Thread-Topic: [PATCH rdma-next v2 3/4] RDMA/mana_ib: Use struct mana_ib_queue
 for WQs
Thread-Index: AQHaeh7zqLhHzozrgkqlV+gPDddvD7FI428g
Date: Mon, 25 Mar 2024 19:37:37 +0000
Message-ID:
 <SJ1PR21MB345799416085338BEACCD452CE362@SJ1PR21MB3457.namprd21.prod.outlook.com>
References: <1710867613-4798-1-git-send-email-kotaranov@linux.microsoft.com>
 <1710867613-4798-4-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1710867613-4798-4-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=38259e53-b95f-43ce-b6be-809e3db5a8f2;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-03-25T19:37:14Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR21MB3457:EE_|BYAPR21MB1319:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 czpdeLucfnulSewI2PUCv1qPnpONwFIYqr+oG8xCPo4jLmNGpaqmSj2ioY0VutBKyvgySlYkDa3m2hhXz1Jy/JzdKPeu1ph2944+KhEYG5Bu27Bn7xgzU82SbNYxPG/StAGC9QmN/3QxEGsyn1Dgygl5TQj9EmeYi0No9+Fa+MwB4VhT9Z0K+5v/ef3vYSNEOAjLUGU4tzBD7AIgRE/xaXAdn4tsW9GBjjO3HjA5lK/6du2u8Jqp8jzznsddflmNRwcMwUoOxZUwb5V9r7kY8+feh7qyJ29yhoA9bJoinplNVe4n79Scbk+3m5UDw2wslcecQ41Blx/Hdj6v80yg/DDh2I83xVGn+5Gr7aI+uIzTEgFXm59Tr8xqSBb6BSMa6nxhoFRxvYZWV21T1QreXXcXb/DfybCy1sZRgnePIwCWsmiwCAJ8KkVKg5W9rZZrwZO+pbZmERbrsCg0JQ1bxIjnPj+yeHzdgByQqBbo0iiuIONbTLSvCqL4PxSLQgjg2Cn/yfMy7NmVyQvngbsFkEzcYANC4qrg3iuFHKbsIFxqNI2AVhLxvBJgutAXTSiNJO3zcyKu4Psfqyjco9SRTZ2bX2raaAOGMTAB9Y1J8oe6SFgwVU+vYVohexIHPqmqqZP4NhN2yRocUJZ4msrCukFrRi1OiCtHpfDM3dS7E5Y=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR21MB3457.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NnqeLR94l31vhUNeoBanhEojitZLoT+/XUlI4FLe5JyXqWRbbguNKrX1g0oF?=
 =?us-ascii?Q?O2VkZBiebvY6AgVJZ1hKwCM5lb07JblmGVzZlLNsfjN5MBwyRpEQBmvkhth9?=
 =?us-ascii?Q?JrW6rzaecZFs28a/z0YavZj7AxMNJRCZWC2XAYZVnm9FhzdPl9b+B5LFAIYQ?=
 =?us-ascii?Q?bk1K5Vlp1896begB+fNstQYbZF5UnFzxeSRtoVbp2dFNblYxnwn95L18KSYK?=
 =?us-ascii?Q?HKkIPLIUB7diz2zUsPLLJYZWGPsML4amWvjQTc+bJwBAoqXguofxNm+5qKOr?=
 =?us-ascii?Q?IIL5ejVjfcjiskL+/bQzCxuRJ4hd7IVKP61Em7P7el4eEAgttMdviNtkqtYW?=
 =?us-ascii?Q?2f9unTabWROJZl+yTF+mJhXX3OT1yLK7DjtrQAwU+b6a1s1gg/5h9qHl8KY9?=
 =?us-ascii?Q?/dOmceGyhoUEndgI+d9cyqtKWpkjSWx59paHZF+QYY2VJ8jcCmqJNU0fMAiZ?=
 =?us-ascii?Q?ZdEJoZjh5AR4peiGIQPSC85R9RXiBz9/1z/CEQ5xLtvmD4ZF8HS0rk6fLPed?=
 =?us-ascii?Q?kvPBdGxjZjzRihmgFuRJCIOfBI51nh1qTk9ViHfSLVMUu84DzZyCmMWl732C?=
 =?us-ascii?Q?3S9Y0tgD992evEMNDJ2nxPYh2wttuhrOpKgJeDrjBCw8Qg6lSCC1HGVzX3SC?=
 =?us-ascii?Q?CZ08aruxfeIsEXc09jjLEn+42a7ZcPNhF74X0m1unUgRbJRVcj0P/IIVyWak?=
 =?us-ascii?Q?iQ0DPuC9cgsR84kZ32UhytEppSiQSGMDeni4cATSVbmeUW72PCyGo41N+eV3?=
 =?us-ascii?Q?mAOELUMob32t7MrUKiZYxBjrNVgfJLdqbjxQp+S6wdlks/E/r6NFFrVcEm9O?=
 =?us-ascii?Q?QpsmmKYLb4LerRbn5Xu3aKfGXE9+7uxKiL0D7KM3cmdHhBM92WLk6ZFefcU3?=
 =?us-ascii?Q?fjId0skvJhmMyLqIOb/OyIdT1aqTyub9iPKINfAmWbfJDlTuoQYkuohFp8VF?=
 =?us-ascii?Q?lvul/h34WuCDXbEMpr9XMVmLC9J6CAM2upvHpH4W6+3ImFXzqBVNOHfwoquj?=
 =?us-ascii?Q?Twi3Y06gqyoUHDsckcDScMPQBA+ojsBzqMqDXFYgqSqwcoZaSYuo5GQCjqHH?=
 =?us-ascii?Q?mhOF/lc6/JR60MraSxvJgZeneqg9yUihwSinhEGKzMFvJBrGBijMHK5JV2vh?=
 =?us-ascii?Q?lcz5Ip390p9lX1iFVGknawA6GHnM5XaKGmXyeCfSJGizH2zgbdDFK9k49w6r?=
 =?us-ascii?Q?zkSbY4MB2yavt0BF7YTZofowc4Ftuud2AdS1IejOycwGBH9/LKj9R6ys/Ohe?=
 =?us-ascii?Q?6xXi6urzlrgUo5jaH6WulkyOy9dKHwsoO86rz1fOla0OWR97Xsy4zGZnVpa4?=
 =?us-ascii?Q?UwZczQtfYv4PVn+a+6HYy3wYLLFvl3JT0NCJDkfeMqLxPcnz/1n9Qjpi1JPD?=
 =?us-ascii?Q?1dxHq43KJC72OizqcEnv+u2+TGk4RtxFQvLQkirsDF4qcqDY+Nk3cUxRIyLH?=
 =?us-ascii?Q?BDEEK7LyZsY0j3JXzpmwjGzdkF6WrI0jr/knXVj/B6BLn9ap/nN5n6hq238i?=
 =?us-ascii?Q?uTKGXwiFtGvSQYuSRJ2M+LQVISHR3od7geutThpP0feWSEK4z8VuvNmIHN9O?=
 =?us-ascii?Q?/NRFfEpDCTOYYJlo9rMbLP3AYKsKj/0+wkYP7iyP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f172bd43-5c64-47b7-942a-08dc4d0306b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 19:37:37.2297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bfzm7IQizeZ48N+66XYUf9V8vSV8UEaKwmn6yH9PlSvFKkzo0EyG+tzvou/TRBmkTL1KsPCzrpDUfeuybmFVRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1319

> Subject: [PATCH rdma-next v2 3/4] RDMA/mana_ib: Use struct mana_ib_queue
> for WQs
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Use struct mana_ib_queue and its helpers for WQs
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>


