Return-Path: <linux-rdma+bounces-2034-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6A48AFC84
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Apr 2024 01:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6084C1C21D8E
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Apr 2024 23:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444E643AC1;
	Tue, 23 Apr 2024 23:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="UtWImu0J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11020002.outbound.protection.outlook.com [40.93.193.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5963E479;
	Tue, 23 Apr 2024 23:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.193.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713914693; cv=fail; b=odRmq/MHMbELGdAyEpBHO9nmK5OvB4dl3kYHBXYIdM4El1/n/yzoxx7Ju3mhrTVTKz61SIS2E4+46LvaPz0OjDcIS/mSA1u41zvWonfmExOCRNrAuTyUA3yAf7Q9nhH2DMVEz1RfjqyveiOmZsxdiXXAfy+o5nrNNZHGEbKWQ4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713914693; c=relaxed/simple;
	bh=dGHZFEmeQAmTixYMjJnbSg/K0fcuJY5D6edXV4tg4ck=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aF+7QKL/XANoyQ8SgQXUJWd3UilO8UkXT6iFAfkUrSIreB+SFIfnd+rQtnLnqQlBHdOnXDMtxG4Qr8xn7UlCJHzxYVdvInrqV51cujFHTLEgdU8GbWh1Cs3KASr/nkKFVJdVtxLbB4ZxCc1jj9l+lnl/OUFrOYK0jhTV4A1bB3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=UtWImu0J; arc=fail smtp.client-ip=40.93.193.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXjqR+UC2MlzkmjgxaKsEECdUuqdC20rTTokYACbKm2aGQLzbyrygSWhm0oSQlAG6R73+UOoIrSV0qRtScjiwTbQXuB5j54mpha/VsvSqn6T+NcXVTzx3GeH/3lxBPGGC4BXAqcte0EYyFgUYOh1qtncPcrgdkHgYf5rWjFUWnNhc3sGMcoIAfdhjOAUlVqTSWunhGq45wK1yQrgm/VLF7MyknUkmBokUZ66iIiuKmSIRkuMDN/SebELAc1YjOE4RIwd2xYsXyGMIrq9kpRRLn1UeF82Pi3a8RD1kshOY//QSscjQkOYGuy00+5vLMgZ7wavLs+iHlkzmtjifcWg+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGHZFEmeQAmTixYMjJnbSg/K0fcuJY5D6edXV4tg4ck=;
 b=UNX1IHQCPH6vOmAnr0ahL4y7UTfWQuQ2iHOCgjjSuz7g/jUL7Z7vEJC1g8KOW/XZyAbbQssKboletAn8APSb/TBAsdEzdlh+m94eGt9p7jFeFK4ZWQ29ljwFtZH4iuShxzMropaPEL+D/bFDfm9alh1rJLViCvtKKjhyby93ZPWEgiPK+CefTZ0WZFBohXYGxGhVeUBU4VDVq3YXtt6UGAEtTV7u8j5AHWVa1RSa7rIDfOozf7Sivjj8bl8rgYwg5azd4NmKadotLpyE64DOLBinP/UrIpM8GlEoSDduLuY5CwA22qmjm7UMXkGcmZEQWq9dZNtjffG7w7VC4QgYVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGHZFEmeQAmTixYMjJnbSg/K0fcuJY5D6edXV4tg4ck=;
 b=UtWImu0JL4KvS0EdVzZpuYCmsb5MuQ32r9e3gUB0eC64HGALEhyW6+PhljcxyXEcVmvjhicngsaXlJtdPmt/z9YQUv1l4R9bMBLRxdwGyYw7zQQYci/B4JvhcJePO2iZ/ovtEIeIXQxlFIIZdzGcA51vQLZMXt9sR56D9si/OU0=
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com (2603:10b6:a03:453::5)
 by MN0PR21MB3508.namprd21.prod.outlook.com (2603:10b6:208:3ce::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.16; Tue, 23 Apr
 2024 23:24:48 +0000
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::94ec:979:8364:85eb]) by SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::94ec:979:8364:85eb%4]) with mapi id 15.20.7544.006; Tue, 23 Apr 2024
 23:24:47 +0000
From: Long Li <longli@microsoft.com>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next 1/6] RDMA/mana_ib: create EQs for RNIC CQs
Thread-Topic: [PATCH rdma-next 1/6] RDMA/mana_ib: create EQs for RNIC CQs
Thread-Index: AQHakbDDE2a45bB/yUadOwYaGDjYxrF2h1OQ
Date: Tue, 23 Apr 2024 23:24:47 +0000
Message-ID:
 <SJ1PR21MB3457E547374AA093A52DE8D6CE112@SJ1PR21MB3457.namprd21.prod.outlook.com>
References: <1713459125-14914-1-git-send-email-kotaranov@linux.microsoft.com>
 <1713459125-14914-2-git-send-email-kotaranov@linux.microsoft.com>
In-Reply-To: <1713459125-14914-2-git-send-email-kotaranov@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=352ccbcf-579a-4aa3-88f1-c10e98ff5be2;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-04-23T23:24:14Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR21MB3457:EE_|MN0PR21MB3508:EE_
x-ms-office365-filtering-correlation-id: 53c8b9f2-de9c-4522-afd6-08dc63ec90f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?h2zm0o+vrkEYsch8VjiVa8lPzm61pvX1L2TEIPEduOxg0nJ8zAYWp/L3AhnZ?=
 =?us-ascii?Q?HC6t+QjtEEHWcthZeNyoVG2SsswT9BYr/2KvEBjLyU3LAZUH8FW76eo8knUA?=
 =?us-ascii?Q?yPAFYrectRzOFRuITQyDwUFf5+r+1f+BUTH83Qw/+WENIko9amij72KAaN1J?=
 =?us-ascii?Q?dUVmap/ALrw+L/nDq/IPjJC9E58SMmc1trFRUyeM3+6l6cf6qMOy3AI3r6FO?=
 =?us-ascii?Q?7DvkDXP4JcIjWWESLCOsGm4BczIpMaPWOEflhw3Q5V2T/dn+cPpMzd3xZfC7?=
 =?us-ascii?Q?a3Dzbc0MgDUaAz6vsplRXM4sKnr+h9osLWe5XUpZLiMX0FrkOmHj988AKhuS?=
 =?us-ascii?Q?xsYQUMUsKrbS/dAQriHPSQOb4hcu4iNPtjpXD9Q80sHRYcstyAsMk/l3JeWI?=
 =?us-ascii?Q?HpFDm4y4ulYgGeIBVLrPSgv4Sll+8oCCY8UG/xooSFcOwJg+x8jWySWdrFWN?=
 =?us-ascii?Q?yE+aeMSajMM0yarLISzz9AwT32qOGE9TkBh0ypsN6LxHp7f215Z3Hr/MP7pH?=
 =?us-ascii?Q?ySwYc/Y4RcwR2P1CcQMemPQNbzLL152QFlXcNF6nzWBMBbwWF1LjW1sCuT2t?=
 =?us-ascii?Q?wESSkfmdI2Pb6JaaokKnkj3S03QHdI9hxz7K8d47Upgjsd2tb77VRNZ0xG8Z?=
 =?us-ascii?Q?mvKbVmXzio/3S2UR679NJDnQ43io27ydYummAatFCv6IH9sXzSdDzirGZ5r1?=
 =?us-ascii?Q?gEctY8vmaUMVJANunQ9US1RZMQKTRpkr7TBvJ0eg58bMtIUOU9aSaKjKDRhd?=
 =?us-ascii?Q?6oNvkZbc/g786DRUAl1tnW1T8mtS4qSoqKGivZpdEyT2g8fWJ1X9pHUzSd8x?=
 =?us-ascii?Q?K/zfd1fwIKDwn95aYKYXpnHwH6X0uHPqicZadSSWwaHgtLgLVqIyZFL5mlL9?=
 =?us-ascii?Q?m7+YST3+5/hfShE6WLvbJUqEHUP8lpBD9snhKFADCgdqYqd7xp+Em5G79Pcz?=
 =?us-ascii?Q?vJQ+QiT5bdvHCZkhzqOXpR+lWKw9uHXUXENEHStOJO8eVrLXxIEJpB21++mM?=
 =?us-ascii?Q?cRkZT+gcwaHWuVqM7IsxbI+GLIiAZ2wIjVYK4FuyQojVGRohRZ6zj/3pAblf?=
 =?us-ascii?Q?9bplIjPEjxTHrhzFgTuYcNO0o2I5B/7IAJLYJLwamh4PMlTLdVNIQZuqnfeF?=
 =?us-ascii?Q?ozZPSqLMBmeHkEF2FYJSp4uyhM5x4CwYqQhHQjuqAGANFwtfGXMNwMZ1pdtG?=
 =?us-ascii?Q?0zcAQtwXaVuU8a0v4GwfqF7rAKeQeB6TTjPJYeejurdiWD3EI14TdzCO0p/A?=
 =?us-ascii?Q?toya5wMBB75SqO4gsGTTFEoM0AHHwJv4eI4+JoEyqfecgFUv6efYZeoy1V0C?=
 =?us-ascii?Q?fOI0aBE3WV2ucjn8q/ekR1GC+LoUAVD7J0AZuhZwkn8Hig=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR21MB3457.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?W4o93qzLM5wctR8QPuJJ9UveP41HEF8isWgzWJ40Gh98Wlc4Xx3Wwn/Av669?=
 =?us-ascii?Q?ye+2xa+08XlbpeoledGtEH4joXnUP12T+XPlsaxHt/vK6PHzqNOGqDbkR+QP?=
 =?us-ascii?Q?QUCtvm7WNk9C/zCEEn0jGUNxfs2W07TLUTKJPiMfWeeRBSr1a/+RdphV4L8r?=
 =?us-ascii?Q?v3zAek1jf4vDp9IHN1fqLwXiifyO5pfP32EoQbHWyx+69xBvF9Z9vKoQdP2v?=
 =?us-ascii?Q?jF0LjlONiGBmRL3q1T/s0ObW8Fa3sctomLOKRuZUQr4MT+2WdoNbMveSv+Bh?=
 =?us-ascii?Q?sepnzLS5vwgegnK+Mr021Ax8RlP4qIxahkm/QwBS1rfSq444MKoJiF7SkD7V?=
 =?us-ascii?Q?Ov+FRC463P84J3NInhP8iGVvE/OEltaWcB7dW5YGf1gzr0hhbMJFRm0c0SWf?=
 =?us-ascii?Q?eqKjpLQ/wRavQ9pnCgYf3J+YjjSXEkHnmf0uOh8rE8bBvyyGaNSeNEP+tdSW?=
 =?us-ascii?Q?8yee/yST3B8Fn98KrL7beKHOmkqIr/jrzGiddL3HKsB1df233v6X1Crn2T6M?=
 =?us-ascii?Q?EGMMo6Dg21s1jDhErwe88i6Uj7/ywahoiACnHp0MQdnGS/q9Wj0NS4YQZia4?=
 =?us-ascii?Q?1U7Rkk/0lYHsDC5OZ6Ncn1hE8bdjiRvSeApYfVc5Om3ACJEBiju4x7yMNB3A?=
 =?us-ascii?Q?6pV+dPqC4hwB2rz3Lw8KNB+g2niF0P2jBZnC9B2UAmm4O5X7qBj5Al3XnRAq?=
 =?us-ascii?Q?2i6tpfGP2uprR5ZRcP0DaaR2djlS7Dq0qhlyMTWadD6Z+4LdSgKsM7tesX1G?=
 =?us-ascii?Q?Da9OQOVvBnbdy5/dnHw93XBbv5M8I4dOZaHLMvVDh4jdcnN7rLtvyg5Fnnfp?=
 =?us-ascii?Q?OljEfj13rltHBgoNPQv4TjHqAMXAd/ZZYcRIrvOUB0qjKXiDFAml7/BTPc1Z?=
 =?us-ascii?Q?p9QXyTPgGO7snxPWQ3y1lKI//1bDddrPpmCrPD7FQAs1l5skcBWPUhofO/dm?=
 =?us-ascii?Q?gQ9Wtiog+7gOr3VHu70Rb0+wJSXRK6HO3IFDDUgnL0BlpeoSXrg8FKDBC235?=
 =?us-ascii?Q?Y/TTjZlzh2SPbWktKVz+bt8Tlm45AurCCjh/PrqZmaq67sfHQV3LtFu98kbf?=
 =?us-ascii?Q?Wvb3JJSODF5YnwcPfxTHt9lfkTQWIPcSYQCMj3ENjf+ZSyJEg75YnoP9E+x5?=
 =?us-ascii?Q?rwGmg/MXj5n2ySXsSRDhxn9u35rWg6wx2ae9FiJ+PI9GB+W6l4A6f+TXKdSh?=
 =?us-ascii?Q?ynr3AUIRLuTcw0hEjrn+OhDvGEF9Iw6LDwi30XAOc+05s3XGPPf2NjGWVtxi?=
 =?us-ascii?Q?R1aPtnpOKKyp106nIsT78IU/kK0wOmH/UfME8B/q9Hs4aCiurpEdkDqNaTRz?=
 =?us-ascii?Q?XPn0klw0RYouu8pJZfIYxsSYeIiYj3Oeq4JEjK2q+Ahx0jpmd/nF8yX55cUT?=
 =?us-ascii?Q?afr40UhKOfe4OwWJ6GQD4qc0hp+fKvl4btZDeiupassdEcWVF8TXGfoyQ0CB?=
 =?us-ascii?Q?Azo4zIippToZBeFJJ6uEL5HDYPHhBBD+nH8C+bXBvnRFLu1BPJcNiSxnvQdB?=
 =?us-ascii?Q?Xz48hzSPhGQR7fLz+3e2M3tFAGb7oPbtel5UceJDk4oAh1k7rTq23/7fV3yS?=
 =?us-ascii?Q?lG/4V2yKunX1luPyYDQvYuqC3lWcYOCRT4bACY7wI0o9AZQhGTrFu3+oYH1l?=
 =?us-ascii?Q?r/AoywQXoMU8jEFREsA/4nBG76fZImTzj7rebkjco10n?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c8b9f2-de9c-4522-afd6-08dc63ec90f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 23:24:47.4709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kf3cIQg7E1NzAm6s8s0298Wpq6A1ZXWYdYxkpvGCWjIVdvtYeO9KtWavx1IpkG7qexfad9k2ohNUhkyk9fU6Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3508

> Subject: [PATCH rdma-next 1/6] RDMA/mana_ib: create EQs for RNIC CQs
>=20
> From: Konstantin Taranov <kotaranov@microsoft.com>
>=20
> Create EQs within mana_ib device. Such EQs are required for creation of R=
NIC
> CQs.
>=20
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>



