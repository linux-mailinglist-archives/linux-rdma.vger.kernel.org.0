Return-Path: <linux-rdma+bounces-2643-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A99858D2579
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 22:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC511B2C0FC
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2024 20:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1342B178392;
	Tue, 28 May 2024 20:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cn2VncY1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11020002.outbound.protection.outlook.com [40.93.198.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330C210A3E;
	Tue, 28 May 2024 20:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716926854; cv=fail; b=dhWpW3MaYhshr0S6vJhiIRMuKQSp8+/cs/FxcGNE0osEKPiv+UY+RNqmtzJ3ejCFwGdGAnN1socpdVKLW15FgaE1Xrs39LmXp2RE9Bfs36AfHgpxUp6+FCxzKtywm8BLalYXM21JKJtH6v+KeWVmMsN5zZkTm64IyXu/zsOB7aQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716926854; c=relaxed/simple;
	bh=T4eo/SMqQyG/7GxFHZ3jZUoYT3UeWEcbNr1U9nURLL4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RpzJTYjU7YB/5g5qB14zj/erfv7a3T0xdt/97wuM4SjaS1QAvg0uVl7OwwERskgn1T/M5l/uVYi+yAUc+rpvj5C0BbFu76b04Cs/BEGargI1znr6eeQpynnD7LNUcmo+PtMiPVoy7IB5ecR/9QJIn2N7PpDIBV831iZQQtuHapg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=cn2VncY1; arc=fail smtp.client-ip=40.93.198.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+fGmnbFNAGgZjo/ZykiLay9IjsgTMi1l4H3jiZZ2JSeU65XQ8+x/k+YX7/boBvsEPYnG8A8bXPeCf8MvZZf+ygUo8O+xld9LUl0xu6hpa/thyxV4UaIevnFvpkm2umdtxwA0IAEHFW+Cd19dIxCMp747X3RDyCJkkeOOdYM0CAb5x7+vGDdyNy+riIilNkHldfAbrS00RepunDNXXA2e+qrbtSzRmVedKiHGDTOS6MWh8IS0caI4yyQyRCNd7qA3j55O2ygs4IuRoIOcUDH0VF/0jXlGlnF5b9i9AoIz53dg8IL61ZK/PT/Dut8Qqm6N7MbRT/YeAkijnsp1yJeUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4eo/SMqQyG/7GxFHZ3jZUoYT3UeWEcbNr1U9nURLL4=;
 b=eyBq2EKwOmTDixCGlpMheIYYdEXlirU3gxC0iQq19b0kAkOyx7v8sSrS1a+FF13quNpbOyEqvMHmZd8n2WNTycfL8cRPp7B+gsbAovF1kQ8z6b8l2B8Hz7Y/8eBtaBsroRNmKAwsFJiM7AIsxK3JPI3+L0WeEvyTFypic2OIsGho15NMJg3vmcGG9GDMXqxoO/s1GIHfHbi32qs2I99bPPIVibNxF176t7O628GUc+lTkJIRUZ9h3+Ahkpqcitryzh70+JSIdMTfq0cvVJlo8zHm0TUel7XQB8N3Qd9r2v664Fa4dkNvkuZMsbUoefi0KmPeLUPBtEqyFm3dXAoqFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4eo/SMqQyG/7GxFHZ3jZUoYT3UeWEcbNr1U9nURLL4=;
 b=cn2VncY1T1Oxr6cvCToJ1qHGb621PVoQGEWztojoBVaYKROhq73rRezQ9mIXwSaqiQbRpyHPwF1QEDmAsazIC5FRDlIyu1BCuqAalu3B83NYARVjkrBgGMNO48k5j6s0hLD2CJjjeE2SgBDZNU2qW9+ZZ7HTRu6bIh58tWTKCDQ=
Received: from PH7PR21MB3071.namprd21.prod.outlook.com (2603:10b6:510:1d0::12)
 by DS7PR21MB3526.namprd21.prod.outlook.com (2603:10b6:8:91::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.9; Tue, 28 May
 2024 20:07:30 +0000
Received: from PH7PR21MB3071.namprd21.prod.outlook.com
 ([fe80::204c:c88b:65d2:7d3a]) by PH7PR21MB3071.namprd21.prod.outlook.com
 ([fe80::204c:c88b:65d2:7d3a%3]) with mapi id 15.20.7656.000; Tue, 28 May 2024
 20:07:29 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next 1/2] RDMA/mana_ib: set node_guid
Thread-Topic: [PATCH rdma-next 1/2] RDMA/mana_ib: set node_guid
Thread-Index: AQHarRD+TC0XqwYr1EWReVZYHGT8orGtGzRA
Date: Tue, 28 May 2024 20:07:29 +0000
Message-ID:
 <PH7PR21MB30718770DC642C5D31BA23C1CEF12@PH7PR21MB3071.namprd21.prod.outlook.com>
References: <1716469137-16844-1-git-send-email-kotaranov@linux.microsoft.com>
 <1716469137-16844-2-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1716469137-16844-2-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=db71ea8e-2902-4162-b49b-4983efa35739;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-05-28T20:07:30Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3071:EE_|DS7PR21MB3526:EE_
x-ms-office365-filtering-correlation-id: 5354f113-26a8-47bb-d85b-08dc7f51cd97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?LC2zpcERfs+GiNix8yxPxcWNvI+kfkKJbxNqIofjn0PYg18oQo+xwfpF3HHP?=
 =?us-ascii?Q?hvEj6mZ22IJVjDwnaMYLLC+Di3rfS2ZSS5QYwM/jTRgaCuTo4uJzEa71gfrS?=
 =?us-ascii?Q?9D+GOtMkaxH2nSZtXQEaCeI2IdRLDfYlB59KwGxO+Tc5pfIuul8mIXhORhmQ?=
 =?us-ascii?Q?TwQvegJHoG8WqRlinDGIZGnrr0EV8KHofOah2ownH0dPBkfN/tZwISABuNm9?=
 =?us-ascii?Q?OpboFV6NasZPbPqF+Hd+5Fs/hIQZFOtXpDmtpgWj1+xE9ThzY06FnVDN6Bpd?=
 =?us-ascii?Q?wERMwEj0kYylYZH1D24NPuwTtUv03iw1n9GqIgMPQZNO8uGOIhdlp3vQWs/V?=
 =?us-ascii?Q?kS/HVFMQg77LxuZTCcirm/wpugzWsfFYwiFjwsJH4QI5wo3Z5a7NQBqWS/3V?=
 =?us-ascii?Q?9rl4CM72Gh7bZYCU7suDaPbl7Thd4set961GGcFid0diyuSqR05XQ+SWBF/y?=
 =?us-ascii?Q?yrYwziWka/RiD52MZ4gCygJCHU2oCPJECs1UhxQAjTJEu0PeU3cO7smaCGTv?=
 =?us-ascii?Q?iRrNXD8aR8P2QHCYbMu8eJjUABm1ZEStD/2NuMTmFx0cf3AsRXckH1C6yahQ?=
 =?us-ascii?Q?Gfc0GHk9NO+jo87uKXADCZTtIo1b81OK5dE/ADOh0dQwu+dxNo/KsmwiEqkO?=
 =?us-ascii?Q?5WXVbHKLvWCn1PWirdooOxZ/EvbPJO2UK1EVQqBwQCFyISh/co8G7xZ+Rh9A?=
 =?us-ascii?Q?wdHVhjwZLjg5t0r2Q095RpW7mPoAIrWCrHZILkYH5iU1vEH8TPZXSbEnbIyS?=
 =?us-ascii?Q?ZIFOLmQpTurhqv5ncmpGoNK4Zg6faUCHv6sNvYhY3pg4m0xG7p68nWvOKwo+?=
 =?us-ascii?Q?ZV167LbQIJIL8geN2nDeM+vdhVLdFvB7uHgo2XV+qx4hennWA0TokigiehC/?=
 =?us-ascii?Q?fy7sQPDd+xXiK5Za/dtta3aGCPLZkbWh20VQwojMw4MWLBrcj7RA4S82Ksk9?=
 =?us-ascii?Q?n8CuJ6FtVTyBmnDsspXNClj+WLxx8E4Xrdlrn2GbgW9FDunoNgGCxv7LWTWI?=
 =?us-ascii?Q?SByeMhN355WnWuhbwchxtGzI9cfETEPsu8aisgCTCdEVxKz1NSFMEiP+XhPZ?=
 =?us-ascii?Q?YQTJD5f3Nvn3zvmikiNxqm+CwIxrVE7KgXSTig3zuzigfZU0OhJWDHU7HCxf?=
 =?us-ascii?Q?p7HqJYyqOchjt/6rbZyhbuRMZLo4XX4chy5VcbzFIoO7XVHb/ePeIfQV4Kjz?=
 =?us-ascii?Q?ctVqqLi+yjxyh4SZSfyqrDLHF+FMiwSGYEK+4d0W5vjMKX8L7klrUey1rW29?=
 =?us-ascii?Q?pDgybaCXPNtqtR9eV7ledtJKzqMRPzv6W2YTIh9DnZk++3Y6QCsx+Bqgf8TL?=
 =?us-ascii?Q?hPf8jSVfDJhwwu68opwAkicG2m0vKXp9JV3em/D9Ejoujw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3071.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kss0Crzh1UYYD53IhQQKl/JOf2b77FoTPjsoiBy9yay2temsTSQlHyv+3i6I?=
 =?us-ascii?Q?jmkNkaedOnHp8r88+p67OH9ZU7XZDZasgeJmgw8/EWWbvw5oDlz2rgIh5T3G?=
 =?us-ascii?Q?jeUrIBQ9o7pY1ipJITZ53DBInyszWDYGqMWybWL0y/aIhrgq0GYWXRbJ0YOY?=
 =?us-ascii?Q?Z8EvKBaJc5s1lGC+rGbgO04+LyuPEoU/yt3ZY5EooMCXb71mAhRfRDauOqmv?=
 =?us-ascii?Q?XuiHtUsWQzsOZ7jcQzRnVKxZEEiCcMTv5up1qMD9Nt6IxmG6lMQyijpviQOx?=
 =?us-ascii?Q?qAPBRb/DZBoUcNJIkkcUZnFGF6lm2OdJdk+Auz3YICowjXq7hOmDXFt92PG1?=
 =?us-ascii?Q?R2oaUACwo9lnG6Tv/BEY5HQPDLJREUnnt3RbbHTWmRtFocJLKDbphiVc0fmq?=
 =?us-ascii?Q?FygKFcXP8GrccC+zFupowuf89raH2vQUDnX6Y40kYI5RkvFYM/BqmP1OREo1?=
 =?us-ascii?Q?aQX6qMWqHHX1beUdtPi2gSVJ3tMYNCueDZmlQzi1WI/PwlV9TWspSi51yz87?=
 =?us-ascii?Q?VCTahCkZpqDsISygjY59P5Mr02kAX0ANl/D4noG7/j1lCQfp82JPihS6BO9H?=
 =?us-ascii?Q?v7ikAYT9oale7HV9tUEPJaz5c01Mymy34bYnR/Sbh4jZ/ZenZeObfbZWCyWf?=
 =?us-ascii?Q?3Lzk5e2Qkp1/ORKWP2Id9ncFix/dBkr3RO5mjn+Tf+Cz2iEAZMUUaZeg/n9u?=
 =?us-ascii?Q?jk04pXjb+oOGsDd3tcmywesM/1rAYqzFCWH9TJhGmwFb+tftYjMtXGNHctUd?=
 =?us-ascii?Q?5rWqNsJb/LOF4haVFgIFcP7sQ78Pkv7UUCeZch/XtQ88GeCr6vioNVTjbP92?=
 =?us-ascii?Q?OPxcO1cxKbJ7crWq2EU4Du6fNGCOf0Qugng5RlAm4VM8EzaalNf1IdgtzJTg?=
 =?us-ascii?Q?8eu4LPnxGWCeJOCW1EmmfyyG+r8GaCUg7w4HSPKKHN2tPd1oGm+gNe4fFelj?=
 =?us-ascii?Q?M3Tl4N4WW5gmEan144h+UnZd9Nu2VPOJFtt6HDV/7Ml90uYWQHzvmK66soop?=
 =?us-ascii?Q?WXymMt3YVqtmXyjr7mPydeg7ylUfhfLIhpbaWBndsRw8j4N2Onwe3jJpwG4T?=
 =?us-ascii?Q?iY2KE4z2JDU0Af5Nv95+1xRZontSw04NYQorGAQsl3UgTI37ZxZyzx+uQ1TX?=
 =?us-ascii?Q?2gYl+nt/6//lrfXlQ0SGVNh8jpIV3fknbRxBZ4xAojxrfg8go9hyAjFZzJsG?=
 =?us-ascii?Q?EkqtUCoVSU2khQ6xfsNketq2orxUmjRNZz6xcQGzxjIo3cWTAApAi/MU8Lg9?=
 =?us-ascii?Q?xyoEx/DuMiZEz7wsPyQJvhNkCIe7weB0G2La2iOt3R4KhCQfaELWpPio4sYN?=
 =?us-ascii?Q?HcRQ8OH8XEIdCD3Np6AIAVDmBnC/7B2ERtZr3+N9+O2cSQ5XL62Ywn6bFVvR?=
 =?us-ascii?Q?sUZjow27fzk2n6U1+k0jrrmcUs9SoXugKcKSOObs0ZmYWVpW+lFEdAi1EX+F?=
 =?us-ascii?Q?XQ/xQQ27QWZlbqHozyzFMbN5/N5JgbSOl7XEijIihnV3aQyh/RrJsnMtg79f?=
 =?us-ascii?Q?UuksiO7EPR+yT7xcAmUIlKMjqLcv6LIS6E5R9PhBsNkquj2wg9pZFY/myztn?=
 =?us-ascii?Q?FDQs7ObdIJkR/DmKy2RT0t7gZxyu9gCW6zwnR1Xb?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3071.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5354f113-26a8-47bb-d85b-08dc7f51cd97
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 20:07:29.7671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4DNgWKvc90tvUVKXfZCz/ZZWb/dj7yBAuJlRppvw0Fq6IYggAT1LvhrSmAZshxPBrJk+pk3tv1gIwe1HRJ3+lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3526

> Subject: [PATCH rdma-next 1/2] RDMA/mana_ib: set node_guid
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Use the mac address for the node_guid of the IB device.
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>


