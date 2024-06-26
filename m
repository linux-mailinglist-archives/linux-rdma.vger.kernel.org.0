Return-Path: <linux-rdma+bounces-3493-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39689917BAE
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 11:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A311F27DD6
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 09:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AAA168489;
	Wed, 26 Jun 2024 09:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YkS3W0MV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2116.outbound.protection.outlook.com [40.107.21.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A3216132F;
	Wed, 26 Jun 2024 09:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719392711; cv=fail; b=bdBwWOu2pxLcxvnM++ZQkDb3wUPs5W3KzcDPGpRlPeSG9Jq2gSbhzBiaVIKw4euA7NIx3DrUyZNBaRf7CZi3UDJBq65nkVcA/I8Br/hdFRJS9MZJTDwpi4wXc2Bouzj9R+rgUk1vLvgn7ESqAyuwDecXLn+IB5JELChsibCgehE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719392711; c=relaxed/simple;
	bh=vomIqxpnoCFHDtyoeJop4mKIyq91tdTgRtGFGhSaNfk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VYLoBbMiXoC7U/iDDN3Fkn0Dze9vFP4zN6854P07rHkpA7rbFpnznqPfdoKkrqsEJHEHAcgfj5rFTO1EaCcvbUm+dF9itRFB1lXYFMzVO7GnGuF9Gm0YqVwdCU0Bn99QUUwKenIF2lQ4BA1azMz4av7Xw9n8/1oSx07/ZMYjIIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=YkS3W0MV; arc=fail smtp.client-ip=40.107.21.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jY4gdjjAiuFQ5AmpPVAHCq756jUHWI9NTjQoX9YvAIFlvdpLeW724WXdpdDy/HlsgSHhb5DEjmxAE3vkv7DyjrDu4ZPGIhty3ogIXiN28d9aMsYWhjTbhTVMY4C37hzZ+NSzSExX60gZV8rApAhJfoGI7avYgyXaknmVkE/tWQbOEWXm2wBoocF6Zu2TO5Av0tgieIS1iXu2z5IZo/XeljkuI0FqqAuMlxjqxlmsNZws+4zpjeRKA8C0kpGJ9MaQ4IGY+6ZgFPQd6BV+NbE1sTQoyXsmXjiiqX0lqJ7KHuvgW2/MViSBQ94eIT2QaFqUDG/JfNJ6W766s5Az+9WGYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vomIqxpnoCFHDtyoeJop4mKIyq91tdTgRtGFGhSaNfk=;
 b=EZcXwjoRI06mGmUR18P5nK6U7g13AYN5rtTieE2kCbU+CuFSrVAJotmIQrWQxwoJuhyAZlXOWGKF9iaydpIMk5QtTvJPKTGKU1ItUBwvtHa+s15udrqOQ9UD5DZNTzZgC1/COOrKmE8QQCtSf2141VE3hfBkHvYOUJfTAojaUM9+WwV1zS+84eKLnH0vk0lMtqNiHfX/TMeugO0y0AKGYEK0LvwXh3BZ1I6oNNfau/pQf0cilXQg2t5IlleKMGwuKw+KynlbKECY+ke6u9xQFwA6x7m1ARrzQe/aka+YwTj20RBCuifmTe/9tzjJzKVYfnop9yyobHL0D1XpvHmtWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vomIqxpnoCFHDtyoeJop4mKIyq91tdTgRtGFGhSaNfk=;
 b=YkS3W0MVdJNx7vqO05kuL7B21sg7rbbCF4HEUgdMLDPDiHg/26dICVwONwiCH9FpaF2Dv3hg2EBJ6liom4i2Kfcm0kJxy8mYJ81U9HxmwWnqN76ABLIjyM8MN7soDoJ2WnvqLOJe1ROK9pwIDKq3Fq62wZhkYFazHWJta5lNfCM=
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com (2603:10a6:102:246::15)
 by DB9PR83MB0520.EURPRD83.prod.outlook.com (2603:10a6:10:303::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.6; Wed, 26 Jun
 2024 09:05:05 +0000
Received: from PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1]) by PAXPR83MB0559.EURPRD83.prod.outlook.com
 ([fe80::3706:393d:dc70:11b1%4]) with mapi id 15.20.7741.001; Wed, 26 Jun 2024
 09:05:05 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>
CC: Wei Hu <weh@microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, Long Li <longli@microsoft.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	linux-netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: Set correct device into ib
Thread-Topic: [PATCH rdma-next 1/1] RDMA/mana_ib: Set correct device into ib
Thread-Index: AQHax6fv3V3S2Mi9p0WIIZ6goUKFbQ==
Date: Wed, 26 Jun 2024 09:05:05 +0000
Message-ID:
 <PAXPR83MB0559F4678E73B0091A8ADFBBB4D62@PAXPR83MB0559.EURPRD83.prod.outlook.com>
References: <1719311307-7920-1-git-send-email-kotaranov@linux.microsoft.com>
 <20240626054748.GN29266@unreal>
In-Reply-To: <20240626054748.GN29266@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6bf95c0e-e922-4a12-ad10-7e97719256c2;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-06-26T08:53:24Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0559:EE_|DB9PR83MB0520:EE_
x-ms-office365-filtering-correlation-id: 12364a03-41b8-49ce-f2ac-08dc95bf1210
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|1800799022|366014|376012|38070700016;
x-microsoft-antispam-message-info:
 =?utf-8?B?N2tWZXhxK0hXZUlLa002aUovRCtISVg0MTh0cnpWSFpBTW9aaVlNcWc4OUhC?=
 =?utf-8?B?YkZPYkhiTkNpRmpVN3pldS9tVXdEYmRWU0dHUSsyeUlhMDk3Y1lkTU1zVWFy?=
 =?utf-8?B?TjVPaEkrK3p4YlZjQ1FqUkQvNis1MGhCc3ZaRnRNY0hzL0ZyYmlYRkM5TENo?=
 =?utf-8?B?QU9zc3REK3FmMEp1YjFoY25rWXFNQ3lCT1RPRUFmaUt0UG8zQlA1VnViQWEv?=
 =?utf-8?B?T2NEb252Y1U1a1VGVmNnTUlubHRZZGhnWkJmazVsMjNLOXZHVDYyZENOU0lp?=
 =?utf-8?B?V29KUUhpV0ZaeFZ0eENBSWpJTnAzd0h6OGJrWUo5aEtrM0hzRGJqZWgyaGto?=
 =?utf-8?B?L3VMRGl3endHS1hqZ1QzWXdoRWZCcDFQT2VJTlBISGxKNEJQc3dYenRUc0ZG?=
 =?utf-8?B?TUU3VTNOUjZVZEduSlRKSkc5aHo2azJEU3dOakE5Q3pNRVFvdy9GVjVvZTJm?=
 =?utf-8?B?cHFSN283bm91aGZWU2Z1UlNSQVp1V3pwYzhaV0wxdjI4ZHlDVityMElOZmwx?=
 =?utf-8?B?OUM0M0lpR2IzcGVPOWRUQVR5NUlsZnpwRU9zOUNoaFQ0cmZlMnNIb1NSeU8v?=
 =?utf-8?B?SDAzRmRicElGalFmcFZSdzVYSU1sZWtGdTY4cU5wMXpOd0t6dzFKSXR2MDNZ?=
 =?utf-8?B?VDZYa0daQ21uR2JsT2Fxc3RxYUJua3dwMGdKQTFVSnJDd1dXOGlXMHQ4WHU5?=
 =?utf-8?B?Qi9saVg3a0hEbXF0Q3ZCRWdXZXg4cS9VZFFGSkZ5U0F3VWFROFdidFp4T2po?=
 =?utf-8?B?emtLeHRYejVEZ0hXUE1aU0pzUTQvTlN6TWQ0alN0MGFzclNiYlB3TStDUGVl?=
 =?utf-8?B?NnN3WTlZd3FWRXpEaWtubTh1NmMxcnJKMkxoRlhiR0tsZUxaOC8xS2xzZXFX?=
 =?utf-8?B?bm5OZTRDVWRFeFpMdmh1ZUJjaFNIWXl0RCtEQVg0MFpYUjJLQ2JiQUIwVFo2?=
 =?utf-8?B?VU1SSnVkRy9xdVlpUkdmSG1UYTdTUHRBQlpwOHJHRlBCMyt5THdGUU1uUVEy?=
 =?utf-8?B?eWs1bC80OUI2bmhQa1I5eVkyaVd5ZURTRVlQRWx0OEIxQ3lPMWxoTGRGTnlo?=
 =?utf-8?B?U2YwaEE5SFgxQkRDRHpJcmo1M0FpamdKYS9BZld4U0k4bUczclBxc1hZcGNo?=
 =?utf-8?B?YVVxWWhzZjFYM2NCM2o4QWtJVTNPUTl5b0pJSFp0aEp4WUJ6ZEl2TE4rMVZ5?=
 =?utf-8?B?UVR1RTJEWExYWmJuOGxCa2dFa3dXYWc0OXZuUHVUbi9vUUVMSHVGZEpzSWdZ?=
 =?utf-8?B?Q2RUWXdsSmI2djlXaFI1eVlReHM4d2xLYkpGcmM4L2NyYzBPR3ZZTEI5SkFE?=
 =?utf-8?B?K0VTVHU5eXArRVZqTHFQenRHcmVFTGFnNjB3WG1WdW03VEYrR0pPOFl6ZkxL?=
 =?utf-8?B?dlBMZDJ1V1hlK1hnTy9FQmFVWk5USDV5eGhBZ211S3NOZ01Cdk5WRVovWEF2?=
 =?utf-8?B?M0JhKzJWeitFV0dseklxN2xFVWhXVU0vSjVWVFQ5NHNTRS8xSE1zSGxLR0FP?=
 =?utf-8?B?dlZxMlArL2RCNzJBdDdxZm9INm1XeHdoNkg1Q0RXeDVjUHpRZ2ZZdTlBajlM?=
 =?utf-8?B?U04zUTBDUy85T3VjelNpbUNscTRmT1V5SC8zSDNrSGE1WlNjN2NPSVBwS0dS?=
 =?utf-8?B?RVVPSFZqZ0FLU1lOOXJuMDAwODd1SmgyZ21pQzJlWUJXanJ0KzBXR0t3QjEr?=
 =?utf-8?B?aXVLRUxNWWpjQld4UjNweXkzNVhqRXpvbHlIZUVma3VVa2lFblJaRVpjTlA3?=
 =?utf-8?B?cHBTdHpaR1BObWZVN3VFUDNXcnBPdEFza0xWZk9pWHNic2JtTDlEUllEVmZu?=
 =?utf-8?B?cHFNei8wclZ3dTdBd0lKY3pNQzJpQ1Q3d0ZGZVFubkVqVWErZVRvcWN3Nk5Q?=
 =?utf-8?B?SzBZTTdValZSdFVsM3N1TnY3a1BpbEhEQ2F6akVLZnI0M3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0559.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(376012)(38070700016);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NUNkbis1VWxkZS9yL0laQXJCbEUxL3NzU3VHVkt2bHJsUkhYZUovbzg0c08r?=
 =?utf-8?B?aVNFRTFLQURabE9vTk5SbmJWNmNuT3NqT25RWmdya0lMdXpHbTJPZVpsb1pU?=
 =?utf-8?B?R1BPQ0d2YzJtNVJxNmlUSUw1NXhNQkJFZTc5TjNGRWFaL3oxTnJWU0JEODBq?=
 =?utf-8?B?aWw1a08zZ1dITGhWVWZuWTVhR1ZTODVyVXkwOGMrSkdqS2xmR3dwU0w5SWMx?=
 =?utf-8?B?eVRSazF2WC9aSXF1c0ZkVldyU25Fa1JDU2tmUnpmWEhEMEkvemNGcUpWL2FE?=
 =?utf-8?B?bGJaeEptcUhSdy95Qm01R2ozMk1acUhFMEt2TzdvN3B0RXlvS3A1MjdzNkZZ?=
 =?utf-8?B?YWVrY1krVjVTT25vWVk4Y2dnVDYwS0tjaWFwNWgwc0VncCtCT0JKUFhUbUpk?=
 =?utf-8?B?Z1N5WjIrbTVsK085SDZqd0NyUzdSaFNZbjRGZW1kWmI1Nk4zeG5lYnY1WEdh?=
 =?utf-8?B?d2VYSUVid0lDcTRybVFhWVVZZTFoaHlpa1plTm5zdXdMdjN1MzdxUEMxeVpI?=
 =?utf-8?B?ZjROREQwV29qOG9HQnFpV0JVb2ZMZ1g3RlI2eEd5TDNrQThJK0VoaGcrZDda?=
 =?utf-8?B?RTVPTG40d0xIaUNrMVBYRDYxTXM3eGp3QTl0QVJGN241N3huNEFRY1hCdy9q?=
 =?utf-8?B?TkhrVGoxT2pDT1Z1RHlEQ1MrUmY2M1A0ejFsQWUydjBZR29OdklYTVhOZ2dH?=
 =?utf-8?B?dzljSlJEOE1jLzRvVzVWR1lMbjJhemJwcDBPdStGekhnRWV4eUVxeVVnOUww?=
 =?utf-8?B?QkM0WnpyaGR1ZFY4eldYNi9vVGF4RnZ0NjNqRWYzZ0lReUhZbjFJQ1lQMUxs?=
 =?utf-8?B?UHhxVC9BWG5QNlFQNEE2ak1Zb1pDTHVJdXRqRkFwUUJlQ2E2NW9VaWhBZHIw?=
 =?utf-8?B?Wnh1b0dEcFpsdytTcDYrQ1Q3aVNlZ3QzQkRTbnNJdkZBbndyTG8zRGNXY1Rw?=
 =?utf-8?B?TTUvVGNmc1J5eHdiNXIzbU1Oa2hZbnlXWjdmOHFtemp3dmhHNTRNbk1OZW9H?=
 =?utf-8?B?L0JJVG4wNnlpelB2OEk4eVVGdUMveFRLYjhjUWdVK2J3THB6Z2kzOXJ2K1FG?=
 =?utf-8?B?SDBrazZXT0Q5aUkzYlB2eGZudFZBS2I5TnN6VU9XRzROYytGMXEzV1p6eElO?=
 =?utf-8?B?ZmlWd2FUUlhKUlFhcGo4dEIzMm05NHhhTUo2S0xyeHF0NnBXdE5tb3NIOWoy?=
 =?utf-8?B?eDFtM0Y1SnlYUFJQOVBQSStkajhIbkVMcm9aanRwOVNYSWhzZlJLWjcySkwz?=
 =?utf-8?B?Y2gwRFJ1OGFNNjFFY25SQWpMc0RmT0ZHbHdKZSsxcGtsNTAxbmUvblNWK0xt?=
 =?utf-8?B?SkpLaDlaa1FUVUhyaUpaS2xlSzkrc3hvMEN0Sm8vemk0UjVEVW1aSWF5TDJU?=
 =?utf-8?B?aWw3amFuQkpjc1BXQnVFeEVFQ01qcVBqL3RsaEFPKy9ieGxRdkFXSjA0d0kv?=
 =?utf-8?B?OFJNTmIyalBaOFlYdVh4Z1dJbDRqRXNSNTBkeGkvSjNoNnNOKzZyNjdLbmpy?=
 =?utf-8?B?QUN5S083NDhqOVVvQjFuSmt1ZnFsdzRpZ0ZoNTFwL0R4YXJFWFl6L1RvaXpr?=
 =?utf-8?B?dFZLKzRMbXNrbDg2MFJRd29mcnFSa256dmpSTzk4ZWhsbGxBV1U4L2NQSWFm?=
 =?utf-8?B?L0FNNWlIdkdqM2wzQTdJTHljdlNqWFFWU2xTMHNFcVIveDVEZ21ubkUzTEVw?=
 =?utf-8?B?QVJqQmZUTmJWanJjUlpETEgvUjFVNjVKZTRrcjg3SDJuWlVBVTJGQnQraFlX?=
 =?utf-8?B?bGxpU3hjQmVzUGVqWnltSTJ3K2xxWXU4UjhNNkltUG1ZN205RzlacElWVjRx?=
 =?utf-8?B?aWc5Y2dxTGF1eEJ1dk5ubW9PalN5eU4xOG9uVkVVcC9sU0Z3a1R6ZlluSlFJ?=
 =?utf-8?B?Z09OUHhMdTlLempreUhTTDBUa2c5T1RWT3FLSkhYUUt0ZGQwYjEyaHdibDdv?=
 =?utf-8?B?RTVjOTBxakxEREZKU1c4dVloRU9CS3lVUmtienN3YUNvbHh3cTRuenhBTUxw?=
 =?utf-8?B?MGswenMxemVleCtxVG04dS9nS1huQWRnMkgzMjdBQnhBK0JyVVZHU1ZMaHNE?=
 =?utf-8?Q?pKEoi0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR83MB0559.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12364a03-41b8-49ce-f2ac-08dc95bf1210
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 09:05:05.3945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5CZrdfr5TbWSU4/ct/RKRWXPfsUDjRdzgXObSKxN7zWTX6jVvVvSpbz1rE7MUDqINhDpWBA0HxBG5M7dSdKhPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR83MB0520

PiA+IFdoZW4gbWMtPnBvcnRzWzBdIGlzIG5vdCBzbGF2ZSwgdXNlIGl0IGluIHRoZSBzZXRfbmV0
ZGV2Lg0KPiA+IFdoZW4gbWFuYSBpcyB1c2VkIGluIG5ldHZzYywgdGhlIHN0b3JlZCBuZXQgZGV2
aWNlcyBpbiBtYW5hIGFyZSBzbGF2ZXMNCj4gPiBhbmQgR0lEcyBzaG91bGQgYmUgdGFrZW4gZnJv
bSB0aGVpciBtYXN0ZXIgZGV2aWNlcy4NCj4gPiBJbiB0aGUgYmFyZW1ldGFsIGNhc2UsIHRoZSBt
Yy0+cG9ydHMgZGV2aWNlcyB3aWxsIG5vdCBiZSBzbGF2ZXMuDQo+IA0KPiBJIHdvbmRlciwgd2h5
IGRvIHlvdSBoYXZlICIuLi4gfCBJRkZfU0xBVkUiIGluIF9fbmV0dnNjX3ZmX3NldHVwKCkgaW4g
YSBmaXJzdA0KPiBwbGFjZT8gSXNuJ3QgSUZGX1NMQVZFIGlzIHN1cHBvc2VkIHRvIGJlIHNldCBi
eSBib25kIGRyaXZlcj8NCj4gDQoNCkkgZ3Vlc3MgaXQgaXMganVzdCBhIHZhbGlkIHVzZSBvZiB0
aGUgSUZGX1NMQVZFIGJpdC4gSW4gdGhlIGJvbmQgY2FzZSBpdCBpcyBhbHNvIHNldA0KYXMgYSBC
T05EIG5ldGRldi4gVGhlIElGRl9TTEFWRSBoZWxwcyB0byBzaG93IHVzZXJzIHRoYXQgYW5vdGhl
ciBtYXN0ZXINCm5ldGRldiBzaG91bGQgYmUgdXNlZCBmb3IgbmV0d29ya2luZy4gQnV0IEkgYW0g
bm90IGFuIGV4cGVydCBpbiBuZXR2c2MuDQoNCkFjdHVhbGx5LCBhbm90aGVyIGFsdGVybmF0aXZl
IHNvbHV0aW9uIGZvciBtYW5hX2liIGlzIGFsd2F5cyBzZXQgdGhlIHNsYXZlIGRldmljZSwNCmJ1
dCBpbiB0aGUgR0lEIG1nbXQgY29kZSB3ZSBuZWVkIHRoZSBmb2xsb3dpbmcgcGF0Y2guIFRoZSBw
cm9ibGVtIGlzIHRoYXQgaXQgbWF5IHJlcXVpcmUgDQp0ZXN0aW5nL2NvbmZpcm1hdGlvbiBmcm9t
IG90aGVyIGliIHByb3ZpZGVycyBhcyBpbiB0aGUgd29yc3QgY2FzZSBzb21lIEdJRHMgd2lsbCBu
b3QgYmUgbGlzdGVkLg0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvcm9j
ZV9naWRfbWdtdC5jIGIvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvcm9jZV9naWRfbWdtdC5jDQpp
bmRleCBkNTEzMWIzYmE4YWIuLjBmMjBiNGUyZDFjMiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW5m
aW5pYmFuZC9jb3JlL3JvY2VfZ2lkX21nbXQuYw0KKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2Nv
cmUvcm9jZV9naWRfbWdtdC5jDQpAQCAtMTQxLDYgKzE0MSw4IEBAIHN0YXRpYyBlbnVtIGJvbmRp
bmdfc2xhdmVfc3RhdGUgaXNfZXRoX2FjdGl2ZV9zbGF2ZV9vZl9ib25kaW5nX3JjdShzdHJ1Y3Qg
bmV0X2RlDQogICAgICAgIHJldHVybiBCT05ESU5HX1NMQVZFX1NUQVRFX05BOw0KIH0NCg0KKyNk
ZWZpbmUgbmV0ZGV2X2lzX3NsYXZlKGRldikgICAoKChkZXYpLT5mbGFncyAmIElGRl9TTEFWRSkg
PT0gSUZGX1NMQVZFKQ0KKw0KICNkZWZpbmUgUkVRVUlSRURfQk9ORF9TVEFURVMgICAgICAgICAg
IChCT05ESU5HX1NMQVZFX1NUQVRFX0FDVElWRSB8ICAgXA0KICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBCT05ESU5HX1NMQVZFX1NUQVRFX05BKQ0KIHN0YXRpYyBib29s
DQpAQCAtMTU3LDExICsxNTksMTQgQEAgaXNfZXRoX3BvcnRfb2ZfbmV0ZGV2X2ZpbHRlcihzdHJ1
Y3QgaWJfZGV2aWNlICppYl9kZXYsIHUzMiBwb3J0LA0KICAgICAgICByZWFsX2RldiA9IHJkbWFf
dmxhbl9kZXZfcmVhbF9kZXYoY29va2llKTsNCiAgICAgICAgaWYgKCFyZWFsX2RldikNCiAgICAg
ICAgICAgICAgICByZWFsX2RldiA9IGNvb2tpZTsNCi0NCisgICAgICAgLyoNCisgICAgICAgICog
V2hlbiByZG1hIG5ldGRldmljZSBpcyB1c2VkIGluIG5ldHZzYywgdGhlIG1hc3RlciBuZXRkZXZp
Y2Ugc2hvdWxkDQorICAgICAgICAqIGJlIGNvbnNpZGVyZWQgZm9yIEdJRHMuIFRoZXJlZm9yZSwg
aWdub3JlIHNsYXZlIHJkbWEgbmV0ZGV2aWNlcy4NCisgICAgICAgICovDQogICAgICAgIHJlcyA9
ICgocmRtYV9pc191cHBlcl9kZXZfcmN1KHJkbWFfbmRldiwgY29va2llKSAmJg0KICAgICAgICAg
ICAgICAgKGlzX2V0aF9hY3RpdmVfc2xhdmVfb2ZfYm9uZGluZ19yY3UocmRtYV9uZGV2LCByZWFs
X2RldikgJg0KICAgICAgICAgICAgICAgIFJFUVVJUkVEX0JPTkRfU1RBVEVTKSkgfHwNCi0gICAg
ICAgICAgICAgIHJlYWxfZGV2ID09IHJkbWFfbmRldik7DQorICAgICAgICAgICAgICAocmVhbF9k
ZXYgPT0gcmRtYV9uZGV2ICYmICFuZXRkZXZfaXNfc2xhdmUocmVhbF9kZXYpKSk7DQoNCiAgICAg
ICAgcmN1X3JlYWRfdW5sb2NrKCk7DQogICAgICAgIHJldHVybiByZXM7DQpAQCAtMjExLDEyICsy
MTYsMTQgQEAgaXNfbmRldl9mb3JfZGVmYXVsdF9naWRfZmlsdGVyKHN0cnVjdCBpYl9kZXZpY2Ug
KmliX2RldiwgdTMyIHBvcnQsDQoNCiAgICAgICAgLyoNCiAgICAgICAgICogV2hlbiByZG1hIG5l
dGRldmljZSBpcyB1c2VkIGluIGJvbmRpbmcsIGJvbmRpbmcgbWFzdGVyIG5ldGRldmljZQ0KLSAg
ICAgICAgKiBzaG91bGQgYmUgY29uc2lkZXJlZCBmb3IgZGVmYXVsdCBHSURzLiBUaGVyZWZvcmUs
IGlnbm9yZSBzbGF2ZSByZG1hDQotICAgICAgICAqIG5ldGRldmljZXMgd2hlbiBib25kaW5nIGlz
IGNvbnNpZGVyZWQuDQorICAgICAgICAqIHNob3VsZCBiZSBjb25zaWRlcmVkIGZvciBkZWZhdWx0
IEdJRHMuDQorICAgICAgICAqIFdoZW4gcmRtYSBuZXRkZXZpY2UgaXMgdXNlZCBpbiBuZXR2c2Ms
IHRoZSBtYXN0ZXIgbmV0ZGV2aWNlIHNob3VsZA0KKyAgICAgICAgKiBiZSBjb25zaWRlcmVkIGZv
ciBkZWZhdWxkIEdJRHMuIFRoZXJlZm9yZSwgaWdub3JlIHNsYXZlIHJkbWENCisgICAgICAgICog
bmV0ZGV2aWNlcy4NCiAgICAgICAgICogQWRkaXRpb25hbGx5IHdoZW4gZXZlbnQoY29va2llKSBu
ZXRkZXZpY2UgaXMgYm9uZCBtYXN0ZXIgZGV2aWNlLA0KICAgICAgICAgKiBtYWtlIHN1cmUgdGhh
dCBpdCB0aGUgdXBwZXIgbmV0ZGV2aWNlIG9mIHJkbWEgbmV0ZGV2aWNlLg0KICAgICAgICAgKi8N
Ci0gICAgICAgcmVzID0gKChjb29raWVfbmRldiA9PSByZG1hX25kZXYgJiYgIW5ldGlmX2lzX2Jv
bmRfc2xhdmUocmRtYV9uZGV2KSkgfHwNCisgICAgICAgcmVzID0gKChjb29raWVfbmRldiA9PSBy
ZG1hX25kZXYgJiYgIW5ldGRldl9pc19zbGF2ZShyZG1hX25kZXYpKSB8fA0KICAgICAgICAgICAg
ICAgKG5ldGlmX2lzX2JvbmRfbWFzdGVyKGNvb2tpZV9uZGV2KSAmJg0KICAgICAgICAgICAgICAg
IHJkbWFfaXNfdXBwZXJfZGV2X3JjdShyZG1hX25kZXYsIGNvb2tpZV9uZGV2KSkpOw0KDQo+ID4g
KyNkZWZpbmUgbWFuYV9uZGV2X2lzX3NsYXZlKGRldikgICAoKChkZXYpLT5mbGFncyAmIElGRl9T
TEFWRSkgPT0NCj4gSUZGX1NMQVZFKQ0KPiANCj4gVGhlcmUgaXMgbm8gbmVlZCBpbiBtYWNybyBm
b3Igb25lIGxpbmUgb2YgY29kZSBhbmQgdGhlcmUgaXMgbm8gbmVlZCBpbiAiPT0iLA0KPiBhcyB0
aGUgcmVzdWx0IHdpbGwgYmUgYm9vbGVhbi4NCj4gDQoNClN1cmUsIGNhbiBhZGRyZXNzIGluIHYy
LiBJIGp1c3Qgc2F3IGEgc2ltaWxhciBtYWNybyBpbiBhbm90aGVyIGtlcm5lbCBmaWxlLg0KDQoN
Cg==

