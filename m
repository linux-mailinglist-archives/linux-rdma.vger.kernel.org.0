Return-Path: <linux-rdma+bounces-9762-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F23EA99ED4
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Apr 2025 04:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E36F05A33DC
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Apr 2025 02:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3726B481DD;
	Thu, 24 Apr 2025 02:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="O8RCMOJa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020103.outbound.protection.outlook.com [52.101.46.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1BF4C62;
	Thu, 24 Apr 2025 02:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745462009; cv=fail; b=tARV2btZAc+0evs76aoZezZ7nSjLB18z1MLqzvronCkkkVYKxMHjJcMCKnpO9J405zNBxm81ieik2725RJ/zmKslg8Z1VQhiv8FzKEiY0qNaYNXYI9Kgipq6h5Z09zpNhazzgLFMAiKhUn/y5Vs6r9sXNl1wNpzSrRZrY4J1nUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745462009; c=relaxed/simple;
	bh=qOaIa4nwG4kyvtZWoHpRhi+efaj1i5sDGuU87rWITnA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IzUx3WrMfb38wfPJGWSRLMKr+TbXa09h+PXhW1TaS8YdDJqirA/qe2Nu6hRfkYxXCwbXDD77sRdtFjrtXR5NArbaBYdbRRyxERRQ3YptluNFwyvOic1dzAboP2Spfn5GaMGwKeFFZrcGRms1+h+L7wuOYG7fAmJHRB62nfbSQLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=O8RCMOJa; arc=fail smtp.client-ip=52.101.46.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYvLgbugNn/qjM6n4iV0Qf0oVFCD37rH7xxxhd0RxcNII5+BpTfSAdePc5xmV8FNoc30eFzkkgRVWarWniQOyjqwQGMn7oeB2Q7ptxl8k2eJ34lWTM15eXCR0IwNMwbszSHEdDxtlDGC709gJDR4/ChuA/ImlWFSLKFVkk+A9byxWig39srVtvvnTovMwfatFwg7PdmisXNllhtRZcHm0Ku++qVTwRZ8iyNTMVxF7wCobLFgu/TEMKw/IcoLnlEyJHTfN/QVzNsmuO9lq6qZcVSq3NEvzuvS2er1o6cK3KDiHbZrUxAxnP08ejj4H1wndaiOab7KrX5QmXvIqMyoDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TrI84zhc0EVbSJiPh02Qc5qv6Ziawl4vg5I6LZJIYY=;
 b=ceekOtOEjep/8rjiJ+hv98Ocs2x9n3LG2oK8uyHsEntwjg1cB1xhx93S4hGs9+A1kDmt3PPHyJjCwhzf9UB9flzgz4eZlCnUSuFFND1A2L2UUWoftLT0yn1khUSdHW/BqAmFws2uUPM2Fybyn7J/YtG7gu5f63wJdsW8exe6OCsXb8pXjlDaUMqp78daEQ8TNNPtc/nITtd50VgWMOOT/gkjOdmMtwlKUBV8jG52RrJpsN90cnW/eli9DMLFccRC8srGrTxlK7yHo3PvV2AjU1Rs3DOvsasj25O6HlctfAZZSbKdtR/Osugcdp0eWiWFxmtQAHWYzP0hsvYwIGh3kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TrI84zhc0EVbSJiPh02Qc5qv6Ziawl4vg5I6LZJIYY=;
 b=O8RCMOJanSSyBOFn+IgYIxbBlr+cQovoglD9wGh+gjeqto7iOiOloSdRB7rdZLU3O6GneJhvZlFe12YWCfFgFACCSsuMTHmdQ7M7JWyUmmZAhah88mWt+PfA9HP16s5lTch0o1GUd/ERGbjwS9OQYVP7hj5uEaKYHdE6DOA15uA=
Received: from BL1PR21MB3089.namprd21.prod.outlook.com (2603:10b6:208:391::12)
 by BL4PR21MB4107.namprd21.prod.outlook.com (2603:10b6:208:4e5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.19; Thu, 24 Apr
 2025 02:33:24 +0000
Received: from BL1PR21MB3089.namprd21.prod.outlook.com
 ([fe80::f6b2:5f93:61a6:a868]) by BL1PR21MB3089.namprd21.prod.outlook.com
 ([fe80::f6b2:5f93:61a6:a868%4]) with mapi id 15.20.8678.012; Thu, 24 Apr 2025
 02:33:24 +0000
From: Shiraz Saleem <shirazsaleem@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>
CC: Konstantin Taranov <kotaranov@microsoft.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, Haiyang Zhang <haiyangz@microsoft.com>, KY Srinivasan
	<kys@microsoft.com>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, Dexuan Cui <decui@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, Long Li <longli@microsoft.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH rdma-next 4/4] net: mana: Add support for auxiliary device
 servicing events
Thread-Topic: [PATCH rdma-next 4/4] net: mana: Add support for auxiliary
 device servicing events
Thread-Index: AQHbtMFAQiaPHyciUUOE/xYtlfRnjA==
Date: Thu, 24 Apr 2025 02:33:24 +0000
Message-ID:
 <BL1PR21MB3089EF4639B5CC2AD5E70B96C9852@BL1PR21MB3089.namprd21.prod.outlook.com>
References: <1744655329-13601-1-git-send-email-kotaranov@linux.microsoft.com>
 <1744655329-13601-5-git-send-email-kotaranov@linux.microsoft.com>
 <20250420105309.GC10635@unreal>
In-Reply-To: <20250420105309.GC10635@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6c20e972-4ef2-4c33-9203-cd5340149c12;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-04-23T20:15:17Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR21MB3089:EE_|BL4PR21MB4107:EE_
x-ms-office365-filtering-correlation-id: bc637cbd-dff1-4520-b174-08dd82d86310
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?baSUtdHtFSC5PWSUnlBJs/Sgi3m9jaVEtoetYqnpWPB/pWAHTgnfQtMsQ0fW?=
 =?us-ascii?Q?8u9lLmvicMIdIrnKInVeBOHLFIrJESLIn52mV6CGuapXrc5UFdsWMUDS8BL1?=
 =?us-ascii?Q?sysZjV4LG2J3Tuz8sbwlPx4d1Z1iDMZtspAjCTs+7DKXYdDOj73qhDROymN4?=
 =?us-ascii?Q?VFF57GRKwOjUZ6Q639ZgqvfNZDwLzR3Kl+p6FalDkf+wNGUUR7zvgxu87PH6?=
 =?us-ascii?Q?/pXa+3ltNKtYNIgMY8DKPk+aKSRqvAZR1VbReMiXWeD1NcAL7NEdpqJX7Vhb?=
 =?us-ascii?Q?h4PWVCajj+Ej4diFFZsMKXsuDrroAaxgRcQb7p1Cfv4tkJkzJjCCyNpSlvVK?=
 =?us-ascii?Q?i3KM9gtghQ7XGb5lss0I8TQytjqPcn+ieqvYactZHRdd/6hBgeLI7+6mplbu?=
 =?us-ascii?Q?U/r3FQvb2Sc4epX02MdYmr3/1zgIoX2nqdRHgU3K4NLDxwpM11VYwyTgocYz?=
 =?us-ascii?Q?KcXvtFDIZDtJRe5TNkWt753kRIRrgdRf0iOkkv+wHUbaC/MTItDmnBGtif3Q?=
 =?us-ascii?Q?RhceVe5ft5rL9F1KASLJO8S4uGpzXI5ncYjVKQqHybIiG7tFZ2xcINw199wc?=
 =?us-ascii?Q?GW/dJZMTfILGGR5gJVlXMgCeKjAYOR4G93UYJD92galDglnP/ZwoqL9mGQcr?=
 =?us-ascii?Q?PczoxeLBmCtAZcV78foI4moJcWDZIZ5AHFGy085WDS9a7f+E9A3TQmi8Uazm?=
 =?us-ascii?Q?N8dadabtQgZDkJmXju1h690Hf2hJh6ISbUkwl00DVr32qzvqyCznz1wsHgj4?=
 =?us-ascii?Q?5v+wTrytDpLoTZxEG52mBghFV0jm2btA2hDsPgKKeQqme4nHpADSgARCwP6+?=
 =?us-ascii?Q?AtZnxeX1qFQSE0GCbY5aLIv6lYgCRk3pwbzvLch8AUmyuZweoXTf0K+lu53z?=
 =?us-ascii?Q?E9D7iamK7uGvTSWfxxwLYMHwLYqRUeAAqXoAGaOsw8n70xPrmP0GsroJhovn?=
 =?us-ascii?Q?WQMmKMaSi8ZNqSQX0a/b4yevFjZZj1ckyk17cHT/v/enpmb8BMdRP/K+ltv/?=
 =?us-ascii?Q?sFU+ekCAPJUZ1Pk17jIoaRfjH29lRhbd8eXzpmEaq17RSJSpluDf6lzDfAbq?=
 =?us-ascii?Q?vrLuX+94ud49a2YZ5KtJcNVbA3ch+yP5/A+BEM8JQl6PmgVl9RprErYH0m5+?=
 =?us-ascii?Q?aGxE+NW64Y1Locz8xKRYt/813J1BT3YfLqJFzSzCN4Vo5F631PpzbmdtRs44?=
 =?us-ascii?Q?8D8XrA6EforjcXuZjOxPHb8VEazEDqXgdFqE/FVqO02ZAj5XiP8kDdK/lZTw?=
 =?us-ascii?Q?5bNcDfMGlwudvqJJtYFJ/2rdqHalsEXTMl64SkwhIm96NrT2Ky53DeMbCx3I?=
 =?us-ascii?Q?M8gq3taus4cS4RJ5P4C7O3+Pg5imEllYJaFE/VBOPaLdzNcUWrqaToWVOuIo?=
 =?us-ascii?Q?I1G6Lb49gdMdC4SQxPu802DgQ9TsmpV8ENmngL/pvW4BLN5/nMtujywUvSHc?=
 =?us-ascii?Q?WeqUNXvtawVSvvKpgThYWoz5Y9hVm0035hdJGQ9Usy9hM9bYnpftueHlhqTS?=
 =?us-ascii?Q?I1ZWHvnuLVInp7A=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR21MB3089.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IEbGDHY2uo7Y2sgKc635oGOOJolfR/8W+TorIbgkXpAMMTjkSuCJtSAalVkU?=
 =?us-ascii?Q?/wIO/yJkSh+0a14GstdICuggRfwdzK6m6vEk/CnO0eGKSoD/LQEhgBqhMyHq?=
 =?us-ascii?Q?rCMl2CF0jktdlQzr8aniIw30mBdiEHMVzTYOFhiza/8PNjc8EmLhQvaQBBqL?=
 =?us-ascii?Q?3RabTggBjYGzi9bTvnOjA9JF+BqdFNPvo4Nm6/voNg4hTQA6mrOU4D8jB4nt?=
 =?us-ascii?Q?/sAIK3B2/8Xll59Bm6pBzFjHCNEqS9dEpfY6V9mVuX4JO7JPFilzeMEV7DRc?=
 =?us-ascii?Q?gPp6Y2JEplYaPhzZv9sQ+zqRE5Fpk94112b8TV2BNbamw3Cyw4CDvXZIjBul?=
 =?us-ascii?Q?nDwrDu/sIc55SXEqvn9OkVWd/Hv1kQMkK7sQIq/J/r5c8KeW1O6DbkWrXDxV?=
 =?us-ascii?Q?r12GaDR4YyrSQOdXr0rwxA9rU1xWMmccbPhqv9cE1Kmvw7bf5FQCXZFJHALc?=
 =?us-ascii?Q?J15T8KcVocxuW8pVZv7wzk+DPZezoFfdpHidE8trh/D5lz0XhX4Z4EEaQOAv?=
 =?us-ascii?Q?4SOfg292CBCuymrChhit3x1nzJbKidf+wh3aspVGwHSbAXIIo7TLZftQyy8S?=
 =?us-ascii?Q?QYeAei1Ezor9uoU8DaRXQsjxql0THZPnDSk7Epf7CEQ77bmsOo7JfS09PINH?=
 =?us-ascii?Q?00MUsMIesCE+uP3XC4Oiffb2pnILhhXo1Kqzy5S5qSA43PoV6YNEvE0qvrbB?=
 =?us-ascii?Q?70sI5ZkRzEGkLABOYZ8h4z5ZyjWiqgtkDrPiKT/X8KxCk2LIrUXE29WssCZe?=
 =?us-ascii?Q?8eyS6g2WrtkSrSrH2R3aE6D+kKwnkNRPWRmLbX4sMcMfY+uDBaODNYu2fWQj?=
 =?us-ascii?Q?De/axoLt6RQWZPOuYYzY3mUeFQQmH22MdHaGciWuvMwHLF8/XE4lgDvaTJsD?=
 =?us-ascii?Q?ryV5vzUTaAIWqV1MqxuNXP6j/tyutpH3mKYIlbpIMbvMByAUt5AtdEgGdzhd?=
 =?us-ascii?Q?fxmwgnp2aFPIV78D924rAjOo2aPRsrjvFYs2MJRfSjGa6eOs98kFbHr+YGtQ?=
 =?us-ascii?Q?Sql9vnc4v4f576PK2p+vzUx/7V21zGUXNRuZxh+RcGOwmqHnRAROQg0apQS9?=
 =?us-ascii?Q?bQJ+ivntaPrPT3A4Df0yJz/I0HkDUjBL94WlNFbadVI2Hr7CXkWddJmx3ANv?=
 =?us-ascii?Q?FwgltSzzMEvEkn8IHsgcsJIk/SDAGRZVvbm+WUiGHlzh5t1tomQ+ttitYY56?=
 =?us-ascii?Q?vk/S4M7ZVMn7zte6hYq2BVm14z4HXBldaR/SbiuP1jD1gFfEwddlzXLkGJTZ?=
 =?us-ascii?Q?T3y5WK3CyDLmno1u0jyoQrCrsUMl0oVhLb46jYcKjZjUgXtCVCp+CTxACOWp?=
 =?us-ascii?Q?9l6JsQF7yjiML0wE02XDv+QCAoZ7Ut+dWByB47hKRaqqHq3TQGML1KXUEuU9?=
 =?us-ascii?Q?k6bzt/lM9hoZuVoCvXCvak7qlOb+STWxMHThUj///vApfz8bL4xFpxxn/FM8?=
 =?us-ascii?Q?vWbYjY7bybqmP91Riz+kGKTQOukSSdfE27gVhrHxPaW4TKX63QGl0r4sZJoX?=
 =?us-ascii?Q?3t/hYEqLM+pvLcezpBv8axsHOIEqkcNfn4G8BW7wZM6LF0mJ3bdeO2lKY6cV?=
 =?us-ascii?Q?+FuOO6lsfQGZlogsJQ/Qs5F6SjKe00odet5dGka7?=
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
X-MS-Exchange-CrossTenant-AuthSource: BL1PR21MB3089.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc637cbd-dff1-4520-b174-08dd82d86310
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 02:33:24.2806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8bHMkOMeOJBvyOErJLsWqzjHX5tU+XHcDMA31a/vTUVrKvWcBkUY/rP5xS2MlQFoBoYMfTefAVPkLi/D/O/ppO+U9mjmI3hzSOt4goEeVb0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR21MB4107

> Subject: [EXTERNAL] Re: [PATCH rdma-next 4/4] net: mana: Add support for
> auxiliary device servicing events
>=20
> On Mon, Apr 14, 2025 at 11:28:49AM -0700, Konstantin Taranov wrote:
> > From: Shiraz Saleem <shirazsaleem@microsoft.com>
> >
> > Handle soc servcing events which require the rdma auxiliary device
> > resources to be cleaned up during a suspend, and re-initialized during =
a
> resume.
> >
> > Signed-off-by: Shiraz Saleem <shirazsaleem@microsoft.com>
> > Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> > ---
> >  .../net/ethernet/microsoft/mana/gdma_main.c   | 11 +++-
> >  .../net/ethernet/microsoft/mana/hw_channel.c  | 19 ++++++
> > drivers/net/ethernet/microsoft/mana/mana_en.c | 60
> +++++++++++++++++++
> >  include/net/mana/gdma.h                       | 18 ++++++
> >  include/net/mana/hw_channel.h                 |  9 +++
> >  5 files changed, 116 insertions(+), 1 deletion(-)
>=20
> <...>
>=20
> > @@ -1474,6 +1481,8 @@ static void mana_gd_cleanup(struct pci_dev
> *pdev)
> >  	mana_hwc_destroy_channel(gc);
> >
> >  	mana_gd_remove_irqs(pdev);
> > +
> > +	destroy_workqueue(gc->service_wq);
> >  }
>=20
> <...>
>=20
> > +static void mana_handle_rdma_servicing(struct work_struct *work) {
> > +	struct mana_service_work *serv_work =3D
> > +		container_of(work, struct mana_service_work, work);
> > +	struct gdma_dev *gd =3D serv_work->gdma_dev;
> > +	struct device *dev =3D gd->gdma_context->dev;
> > +	int ret;
> > +
> > +	switch (serv_work->event) {
> > +	case GDMA_SERVICE_TYPE_RDMA_SUSPEND:
> > +		if (!gd->adev || gd->is_suspended)
> > +			break;
> > +
> > +		remove_adev(gd);
> > +		gd->is_suspended =3D true;
> > +		break;
> > +
> > +	case GDMA_SERVICE_TYPE_RDMA_RESUME:
> > +		if (!gd->is_suspended)
> > +			break;
> > +
> > +		ret =3D add_adev(gd, "rdma");
> > +		if (ret)
> > +			dev_err(dev, "Failed to add adev on resume: %d\n",
> ret);
> > +		else
> > +			gd->is_suspended =3D false;
> > +		break;
> > +
> > +	default:
> > +		dev_warn(dev, "unknown adev service event %u\n",
> > +			 serv_work->event);
> > +		break;
> > +	}
> > +
> > +	kfree(serv_work);
>=20
> The series looks ok to me, except one question. Are you sure that it is s=
afe to
> have not-connected and not-locked general work while
> add_adev/remove_adev can be called in parallel from different thread? For
> example getting event GDMA_SERVICE_TYPE_RDMA_SUSPEND while
> mana_gd_probe() fails or some other intervention with PCI
> (GDMA_SERVICE_TYPE_RDMA_SUSPEND and PCI shutdown).
>=20
> What type of protection do you have here?
>=20
Hi Leon,

Thanks for spotting this.

There are two cases.

-Probe / Resume
add_adev() stores gd->adev only after auxiliary_device_add() succeeds.
While gd->adev is still NULL the worker drops any GDMA_SERVICE_TYPE_RDMA_SU=
SPEND event, so an early suspend that arrives during probe is harmless and =
cannot race with the later add_adev().

-Remove / Suspend / Shutdown
During teardown the worker may still be inside add_adev()/remove_adev() whi=
le the PCI thread starts its own remove_adev().=20

In v2 I ll serialize them with flag + flush pattern.

void mana_rdma_remove(struct gdma_dev *gd)
{
[....]
        WRITE_ONCE(gd->rdma_teardown, true);   /* block new events      */
        flush_workqueue(gc->service_wq);       /* wait running worker   */

        if (gd->adev)
                remove_adev(gd);

[....]
}
i.e. during teardown, we stop the producer and drain the queue

and,

static void mana_handle_rdma_servicing(struct work_struct *work)
{
[....]
	if (READ_ONCE(gd->rdma_teardown))
		goto out;
[.....]
}
The flag blocks any new work, and flush_workqueue() waits for anything alre=
ady running. This serialises the two paths and removes
the race you pointed out.

Shiraz


