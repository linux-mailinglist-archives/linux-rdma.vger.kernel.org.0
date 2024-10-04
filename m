Return-Path: <linux-rdma+bounces-5207-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F07398FC6A
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 04:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5AAE283F9E
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 02:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1F5282E1;
	Fri,  4 Oct 2024 02:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="O1BWD7kV";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="O36W0iSJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B1F3FBAD;
	Fri,  4 Oct 2024 02:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728009875; cv=fail; b=eZxMvWnw4PyGE4Jjv8bElgOSxbUk8CtV3NVqdPqrwZX+ANbfwijaTUEwclnoXZGLcdu2F3IF0HzGVU81oK18FmACR2VvEbrwupHUK4+ALG+SDz/OKvCXLbxWk1bu9AVYrqrE0VDNFLR6+IUQrQs4dmpi4kOdTt03aDw81hlfpkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728009875; c=relaxed/simple;
	bh=KI7s1/83emn3Jmt1I6p7OvtUuKvfb1xewCUT9g0Mi04=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=goGaBDQj0rJBKUzSR/tCIq5mBqBEPPZSh9vC7fcrVIr+BBixF5iS9okzTPpNeJfMAlBZJBXqMaaqFDYJq74ue6iK1AmFmUjqaGhmno+MtLjWPF9/gongKeHh8NTn4KeShOPHEeBWllIzsr2+C17npE3v9MwLiFKypryjlayFE/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=O1BWD7kV; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=O36W0iSJ; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1728009873; x=1759545873;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KI7s1/83emn3Jmt1I6p7OvtUuKvfb1xewCUT9g0Mi04=;
  b=O1BWD7kVKAHcqeWBwY+/c9TEY+b5UTCHCEUh4BJOL+8cnvYrdnrSU3Yy
   hjIdHshPndZX0GEjtme79YK6tWjwur75Zmc3i2x+zffV8TSXTYmCxQdEi
   LDuYZ1nBj9kMPjTyec2ukGgC+21rP55mj3wATu6tDwJ4d5V09ttFpIWSg
   eTKFdfF3RqyjedwOWrLDzjS72Z+VXYyizGLrokWk3AsGwFUXBpJF1CmKX
   E2o81oNvuod6Oi3k+jtPNORbJq74AG8ZlNuXBcrjPFLBVEgrITRqhCfyZ
   r3eiK/DlqDKDmCfMx7/rvr/FOUAJyCDr8hgIXR+ClB6jDc/4AUCNROMkP
   w==;
X-CSE-ConnectionGUID: ZieaVswtQ8mo/D3qc2TZrQ==
X-CSE-MsgGUID: hYqifC9xSEOS8jV74uv6jg==
X-IronPort-AV: E=Sophos;i="6.11,176,1725292800"; 
   d="scan'208";a="28219089"
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2024 10:40:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x5Cu3yjXJYP04yqQlZ3FBu2eWtxhNxaD1WCjyC7gMLumx1NxuNQrVo/dio/VmX5tBDrUEp+OPIlwaDiRL/AEcrGUNY8/0NbSVppuPXXQWEZzD6rhUv5QdyeGi/lcxlEnJAwS4UiDj4ZT4RtAPJkAE7CZ0v5Fc7giWbh6Mqs9ORJyYci7bso+RxO8wy+xA/rEXHKWaGUod2DmkTqEMQpX/taULp3SEkIHXdvnyUSBCdXCNYSBkbUTq59U7VRIK/uwhVhB/WD/5yCQg6UDbkges5rk2DfWapdu7yPibN0URUha645eI3jowwuZljHcH2YXt3L7RvSNHD7uG1LqWAIoNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQ4xRFlZ0Bf1xLRZlMDHLBdk9vfwtXY9NoO9Wl7uM8I=;
 b=zDKRf8VsYCn94Yx1fF6D/iwMMDQBcv7bcCks/vxHi8g49UvEDLVq8h+MFMrHGNR8LVitgbkUqMx7j7sKCwzx7hc1GkmBVbtAKAjBJR8Ah4jUyWABY6D/ucVwCEvsHRlE48nTe8DzuM+Z5VoWsbHbdRRlxlr/WhOX6N/fUy9znTLgFB+AOvAWpfhLIyKOnsa2cKdieSsX7N9R+5+APCiiQ+9b+88KTQ/Yra9KGouIOGh/5+omqt994vkyuLWb/2UQ1eGkMDyMIcWVapZNHnvY/HMYuUZOBlzVmbwVxkd1CyZNkydeSf1iI20ZGz1Xj0GXsq+o3H2grZkM+Z0tB5da7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQ4xRFlZ0Bf1xLRZlMDHLBdk9vfwtXY9NoO9Wl7uM8I=;
 b=O36W0iSJdgTjYgF1YKB4Kz50g/8HAzqYsjVkAYdchfDKHkyhf1xrzUS2L5x4/kidOgUAiEiGQSA8Mr2rivSxChETAv8jWQJLLsZELXT/qv6TPS/6uXHOBMLHtDJL55PTr5jOBZLFRro5kuYy85Lb69v7Uh2XrzUa3M5BRG3/blc=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA3PR04MB8748.namprd04.prod.outlook.com (2603:10b6:806:2f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Fri, 4 Oct
 2024 02:40:20 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 02:40:20 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: Re: blktests failures with v6.12-rc1 kernel
Thread-Topic: blktests failures with v6.12-rc1 kernel
Thread-Index: AQHbFWqoL18cnzPV1UyCfE8NLAbwZbJ1gpyAgABgDgA=
Date: Fri, 4 Oct 2024 02:40:20 +0000
Message-ID: <dvpmtffxeydtpid3gigfmmc2jtp2dws6tx4bc27hqo4dp2adhv@x4oqoa2qzl2l>
References: <xpe6bea7rakpyoyfvspvin2dsozjmjtjktpph7rep3h25tv7fb@ooz4cu5z6bq6>
 <e6e6f77b-f5c6-4b1e-8ab2-b492755857f0@acm.org>
In-Reply-To: <e6e6f77b-f5c6-4b1e-8ab2-b492755857f0@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA3PR04MB8748:EE_
x-ms-office365-filtering-correlation-id: d7afcac4-22ac-45eb-3b6a-08dce41de3d6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?LZpUzi7MCVr9xYzTvYEtJdYwnDgf6MzzYoBUCD3XLsqM/lBimRTzcwOp+Exg?=
 =?us-ascii?Q?WInDlP1TodfgC/oJynwv5yi4RNDDNI9MD9WgC2lIAh58T0U9zBt6uzSNDGce?=
 =?us-ascii?Q?nGcwQ8+8DodyJ9/b+jSwSsHElZpPLNfsP/Xso6JkGtUM0os+M5bBuFE0laA8?=
 =?us-ascii?Q?0H7pnHufQoDu9+QkkG/OXDPciRTtSorSyHZveJSV7NUk+Jt4cjKmO/vzc9lp?=
 =?us-ascii?Q?ER6GNTY+xydL7nUwVqwFaochtvaZa7SLJskDHa7t47EUniCZA1me5sOmO4jZ?=
 =?us-ascii?Q?DVI7w+XYVHWooy+Mf63kqEFU//ysjjxHQ3f9Sjve6eBbE51DNW3F0MMW+uif?=
 =?us-ascii?Q?LN5hlHYsH6FE7fzFqE8vju4dSDtxXGvWsA5PJL7M2no8nwXJ9ayB0Kk2X5nP?=
 =?us-ascii?Q?e7ZjYf7rnjhYcwSmHD5a4o+HKOwSb+jUhbLNQ21/u9nUQprgFZkwrLBAlvGP?=
 =?us-ascii?Q?VPSQltbBPiIRVNGOth8HvBIdPtQN5ekJKd2bi1SE4aCBbHFMMh8Lzsesknup?=
 =?us-ascii?Q?orA23WBl3VYn3+TelGkRAcJ+pWHr2vf3viw/PSFc1ELKdxFrs0+D34M4IvG7?=
 =?us-ascii?Q?VsIevdVkKBU5cR5GPKq9YGzSN8L8dBhNB79nrE86WkiGNhdHLx0MhkoWAUa6?=
 =?us-ascii?Q?DUjKtejoPW3WMBuiYLZDGCPSrqBeCAHz/2q+WbjjPqt6XsVZJKSHWBwZtZIU?=
 =?us-ascii?Q?aaznKVSzkPOiDvM1kn+lsDBvxx/dEdh4eEiv5Cr988KqKex0jwwsEIsvzIPP?=
 =?us-ascii?Q?nBDWmLivjiSadL7BUxZvaEC0jx+AcaSpo7M0iwP1kktj+Ak+GVS/D7irjNd2?=
 =?us-ascii?Q?Oflzp8/Phl+H0bI1UUrJwi3KrOv1IXNdF3CmE9Ol8jwGOFq6I9ajRt5QnbZz?=
 =?us-ascii?Q?dHLRt+sCtfabNkFkaAVDekdLSkaXFUrLJiGL2Cc7CCgMPBax0CJnYkXcvAL/?=
 =?us-ascii?Q?fqLfBCMr99P/QDQYMhzLzxLvXLpNqDU4V78j9aOG2EiTnmZNza7erOCJUu+Q?=
 =?us-ascii?Q?tFzATUMvaZvzJTfQYlBqptpqLIxA0+P7H7V4TeWPay70qFE3c6FYKn3iNnQ6?=
 =?us-ascii?Q?hNA+DqV9S8Y4Y1A1+b14Fi4+o4pxB5OcWNWur4QLnOltcEo/SMcV1axD71s4?=
 =?us-ascii?Q?QuLX4FlpdcfQQ/IP/3Vj6qRsGDFY5e6l6CiVVmJ+n516AKE7ty0mxb50VKqS?=
 =?us-ascii?Q?GfpYiqyuVtX0qO16Km3O3OMldqpFBhCj/8lkWqRENShTj2muMkSJX5sR94bx?=
 =?us-ascii?Q?4GJDacqF+pVTX5Y2ncaUiF4L9wkpirr3iRnbnR+/EDGAoGkQVfFn9DlS6jh0?=
 =?us-ascii?Q?c72UrFyv3bnOhAO2V40jwRdniXVkXHsGdoFWf36VdXdeiQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YQqNp15rZazyJ4zic6U+uCt10hQ71NvZJ94sF+D6Ke/pqXskJcEjRLtbNr+u?=
 =?us-ascii?Q?nCDh0fbcNU5WN8NCvIrlj1KOXhnIKV9L1+HPxyZnlFE1rna7N3TIBzz4icCb?=
 =?us-ascii?Q?8nkb5raz32Hp2NyAmcIMs5u1KIrLVDuknoJHVww/uCi09BznVInYzrhK6iPf?=
 =?us-ascii?Q?L0yQyFGu5AhCJenfVbzPFKKwVW+KxCi4wbvLUB4t9Bp2XZBQcjA6nYWyDRaD?=
 =?us-ascii?Q?vWLoOJ+gb/9Hnm3R14feZzFEG1zngIUM83GQA4FFVuUlll1ngHSGN1CAbJ61?=
 =?us-ascii?Q?KxO9HGjrjWJseRepQocxntsHQijHSDyTmht7gi2/Ohyzca2wX0Ln26NoCooM?=
 =?us-ascii?Q?hWqZvZ+LL5Ed4a0Iv1JH9hbyX3DC61WcqquwyM85Srcbncm62obQjVORf2pe?=
 =?us-ascii?Q?8oIvgsoli/ZVT+k3YI0NqvfjIK8ohvkNKHIeT51gxeOCeuv9Enbc4tSSkpYW?=
 =?us-ascii?Q?g4VU4TRhAIt+jKUbXyIfW03OPl+BIoxPHhMs9wRmXdgVSTcVWwn1AEKHHVR0?=
 =?us-ascii?Q?IwW2UoQeJJlxc+82Bmj0hwibwtvINOteL48mzvaUppgd4kwRTrR7vVNWS1so?=
 =?us-ascii?Q?K8jFe26jhSivgbwICELGfFyAGiOMQGSK7EJtQAUPAzRLz+A8oH7mp6nNNhHM?=
 =?us-ascii?Q?WRcgO4M9mfiWaKMCkZJI3sZEWKEtoTHMwbVe4mxoCuCL2dWWv+M35T6khx8Z?=
 =?us-ascii?Q?f/wCwBYfPCxw+M7slabmWxJ8RnOmFHqnnx59vM344CEh/KWt9GwBhq/1jJ6n?=
 =?us-ascii?Q?iUXdPJ3DwR2/pfdJ9ZCTFiX2yuMTpjyfeoWolNE+Nlhqy9S200esviZ4g5Qy?=
 =?us-ascii?Q?Edpl+16eUR+Cw8q6Z/HEgWyAA3L/TZSbXRdALqiCy5G/23uskUPFlKVKG6sa?=
 =?us-ascii?Q?bQSnVc19zomlMQK2RUsGW558qFhlrzFARM27uxbE8x2B6u9HmZkaO7793xLJ?=
 =?us-ascii?Q?kj65WBEvle7zYsbbz5PC6yLNaCOcAhJ/U4iHks9wKoXgNucdxyW95KzT7Rtx?=
 =?us-ascii?Q?kx7u6spMrhI5wytp8NUpD16YX0wqEy7TZtL/XxyTVbIm5+9t3BFtJiQXYtwe?=
 =?us-ascii?Q?MYxC6xiklwmoGSKZ7oUbB1a2lUYEV+vawPuGzZeQ9/rfAE/U0hpH7LlkzPQR?=
 =?us-ascii?Q?COCI06zbz8jsILHtsRwHOCmMIZGj0FiadKuuU+TXfTaSGWz0AhB4EmxiS0Q5?=
 =?us-ascii?Q?+Y1i4RvjtipfsKVISgroEFFeX1n9MIAJAK07T0uEa2PN2RndE7ZDSvmmNUHR?=
 =?us-ascii?Q?Ygz5/8xQZqRvrTu1jogkEr69/JpjOlURLxzpZIZCqiiSIhCHjZ/zfzywGV0Z?=
 =?us-ascii?Q?iwyPfKCC0Vq0G3W9SMkWcQSf4xRW4/gImJdM9fWzRjMD53spRUO/Do4pMX0Z?=
 =?us-ascii?Q?v7Ia1ELGkTuUcM5fzaDdvs2/WxehBgjrNXSu5lPWuss/NOxrml5P5o1dxhLA?=
 =?us-ascii?Q?CpJWM1mGHXS2OPJNNH8gYyE5Yp464x2sX68yR0u6ggx4blyjkPMcRlDVzQKM?=
 =?us-ascii?Q?natHNhKYmu2WK4CWKVWpnmjbEBBWD/CbTTZkcMxLx2i11U0rqQcweCUxb/8P?=
 =?us-ascii?Q?6LoN8Kni3O1MMIBuXUDk68Jd+InuHe6kQIG6s8MYB0Kz6WbLeWRXPq10bJGO?=
 =?us-ascii?Q?Z1HVbYWxvQbITDNjb0iE0co=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AA47B0E3BD4E374B9DF22FF23543379B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dWUYifWbqkQ4zQ3OPJ2AhH2vJTgvEIJed/kbhfywd5tutCqIgPY7B64bXfpVoLipqc3s94UhDgajru7h10N2rGo1hrCOlX5h8Xsbi9VsfJjzK2XmBYboCQNOYPTs8bV0I+wZh9T0QaNfuyc2IIa1UGpsD08RPkp7AXC9zdWzgGi0if8TjXXIMrfCLF7gDNeAFp4DwJL3lcxGnir1Q8yTQZ8dwwhmZ0ZuHFD3JSuzyM/skVwIZfNV8n451cYApJu1mG/xTv+34PlxeKq0n7Hv2MGZCncPORH/ifeon7TDqmzNeT6XkpRZ7zFPKNsYk4w8Js9s579WMwrf58t7wCUZOdR16LUwd7WXqC/NsTuNPNFSwzkidc27szD2frlMaBBzqaOOviRrFQHef4FIhuieEuyPAOxBa4QrBSEbEv+lU8qUMxBml8XO09hwfQLLECEc7J3sAbVkczrtIT/sZwWNN+tP6l9T2UhtI9pgNebxo/qnjLJXuZEIEscWiDNdxTfKA6/jc/DWm8FsKvfmrIYLtirdFxZMXFYlN8F/d8A4XwtYeCdbtxm9GIVO2TfRfoBagrSEvfpdd9GChKLMC2d8KJcbKRJ6JJlrvEYkvhA4AA/crM32n1QTEXI5voqBD2ZT
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7afcac4-22ac-45eb-3b6a-08dce41de3d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 02:40:20.6835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qgkSQLJ2ydvq9haTBRwMwkKvD+NjVkEAB9JddUTWRrebpJxzgqPCbtIiqcFj0wbvD/2q5tcRDq+K6nZgY7HCl02hJfJQkWHB8YfhSV7jueE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8748

On Oct 03, 2024 / 13:56, Bart Van Assche wrote:
> On 10/3/24 1:02 AM, Shinichiro Kawasaki wrote:
> > #3: srp/001,002,011,012,013,014,016
> >=20
> >     The seven test cases in srp test group failed due to the WARN
> >     "kmem_cache of name 'srpt-rsp-buf' already exists" [4]. The failure=
s are
> >     recreated in stable manner. They need further debug effort.
>=20
> Does the patch below help?

Thanks Bart, but unfortunately, still the test cases fail with the message
below. I also noticed that similar WARN for 'srpt-req-buf' is observed. Thi=
s
problem apply to both 'srpt-rsp-buf' and 'srpt-req-buf', probably.

------------[ cut here ]------------
kmem_cache of name 'srpt-rsp-buf-fec0:0000:0000:0000:5054:00ff:fe12:3456-en=
s3_siw-1' already exists
WARNING: CPU: 0 PID: 47 at mm/slab_common.c:107 __kmem_cache_create_args+0x=
a3/0x300
Modules linked in: ib_srp scsi_transport_srp target_core_user target_core_p=
scsi target_core_file ib_srpt target_core_iblock target_core_mod rdma_cm iw=
_cm ib_cm ib_umad scsi_debug dm_service_time siw ib_uverbs null_blk ib_core=
 nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_i=
pv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_d=
efrag_ipv6 nf_defrag_ipv4 ip_set nf_tables qrtr sunrpc 9pnet_virtio ppdev 9=
pnet netfs e1000 i2c_piix4 parport_pc pcspkr parport i2c_smbus fuse loop nf=
netlink zram bochs drm_vram_helper drm_ttm_helper ttm drm_kms_helper xfs nv=
me drm floppy nvme_core sym53c8xx scsi_transport_spi nvme_auth serio_raw at=
a_generic pata_acpi dm_multipath qemu_fw_cfg
CPU: 0 UID: 0 PID: 47 Comm: kworker/u16:2 Not tainted 6.12.0-rc1+ #335
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40 0=
4/01/2014
Workqueue: iw_cm_wq cm_work_handler [iw_cm]
RIP: 0010:__kmem_cache_create_args+0xa3/0x300
Code: 8d 58 98 48 3d d0 a7 25 b2 74 21 48 8b 7b 60 48 89 ee e8 30 cd 06 02 =
85 c0 75 e0 48 89 ee 48 c7 c7 d0 db b0 b1 e8 dd 92 82 ff <0f> 0b be 20 00 0=
0 00 48 89 ef e8 8e cd 06 02 48 85 c0 0f 85 02 02
RSP: 0018:ffff88810135f508 EFLAGS: 00010292
RAX: 0000000000000000 RBX: ffff888100289400 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffffb11bea60 RDI: 0000000000000001
RBP: ffff8881144bbb00 R08: 0000000000000001 R09: ffffed102026be4b
R10: ffff88810135f25f R11: 0000000000000001 R12: 0000000000000100
R13: ffff88810135f6c8 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8883ae000000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4f8d878c58 CR3: 00000001376da000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ? __warn.cold+0x5f/0x1f8
 ? __kmem_cache_create_args+0xa3/0x300
 ? report_bug+0x1ec/0x390
 ? handle_bug+0x58/0x90
 ? exc_invalid_op+0x13/0x40
 ? asm_exc_invalid_op+0x16/0x20
 ? __kmem_cache_create_args+0xa3/0x300
 ? __kmem_cache_create_args+0xa3/0x300
 srpt_cm_req_recv.cold+0x12e0/0x46a4 [ib_srpt]
 ? vsnprintf+0x38b/0x18f0
 ? __pfx_vsnprintf+0x10/0x10
 ? __pfx_srpt_cm_req_recv+0x10/0x10 [ib_srpt]
 ? snprintf+0xa5/0xe0
 ? __pfx_snprintf+0x10/0x10
 ? lock_release+0x460/0x7a0
 srpt_rdma_cm_req_recv+0x35d/0x460 [ib_srpt]
 ? __pfx_srpt_rdma_cm_req_recv+0x10/0x10 [ib_srpt]
 ? rcu_is_watching+0x11/0xb0
 ? trace_cm_event_handler+0xf5/0x140 [rdma_cm]
 cma_cm_event_handler+0x88/0x210 [rdma_cm]
 iw_conn_req_handler+0x7a8/0xf10 [rdma_cm]
 ? __pfx_iw_conn_req_handler+0x10/0x10 [rdma_cm]
 ? alloc_work_entries+0x12f/0x260 [iw_cm]
 cm_work_handler+0x143f/0x1ba0 [iw_cm]
 ? __pfx_cm_work_handler+0x10/0x10 [iw_cm]
 ? process_one_work+0x7de/0x1460
 ? lock_acquire+0x2d/0xc0
 ? process_one_work+0x7de/0x1460
 process_one_work+0x85a/0x1460
 ? __pfx_lock_acquire.part.0+0x10/0x10
 ? __pfx_process_one_work+0x10/0x10
 ? assign_work+0x16c/0x240
 ? lock_is_held_type+0xd5/0x130
 worker_thread+0x5e2/0xfc0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x2d1/0x3a0
 ? _raw_spin_unlock_irq+0x24/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x30/0x70
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
irq event stamp: 53809
hardirqs last  enabled at (53823): [<ffffffffae3d59ce>] __up_console_sem+0x=
5e/0x70
hardirqs last disabled at (53834): [<ffffffffae3d59b3>] __up_console_sem+0x=
43/0x70
softirqs last  enabled at (53864): [<ffffffffae2277ab>] __irq_exit_rcu+0xbb=
/0x1c0
softirqs last disabled at (53843): [<ffffffffae2277ab>] __irq_exit_rcu+0xbb=
/0x1c0
---[ end trace 0000000000000000 ]---
ib_srpt:srpt_cm_req_recv: ib_srpt imm_data_offset =3D 68
------------[ cut here ]------------

