Return-Path: <linux-rdma+bounces-3025-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EC7901BCA
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2024 09:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA7A01C20D64
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2024 07:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D251CA8A;
	Mon, 10 Jun 2024 07:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bahgPCZQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2113.outbound.protection.outlook.com [40.107.247.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F0022612;
	Mon, 10 Jun 2024 07:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718004066; cv=fail; b=ksPkjsqkkCLYCpTfIHDtbWq/FmDzGc2KAIGM8TI642nnkbbdAdJWq42EKpLegKebmqKVbdYTS5vp4YUQJRQ9qzZAmhNkXi91HFH39Fjw/SSK1MhQepYHurdDTqgiEVK8e9L5d6ZnEIN4gPSJs4zS08twhYcXpq2h66Q9hZeOzv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718004066; c=relaxed/simple;
	bh=SuXsMcackJSRmDzz1WjGNlm4nccKPW2VzLEe5+010SM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PYsD8q+ACaRDqt97tcE5jNXeMjJjEXMb+AeDI2iNeOG5LVAHS9+w2KFJlqrm04f/P3qAJ6OgVN9Dmh72TmZdoqZnB9FjDUxF30LgLqJPy2+91ryeozyf21R3ACckeGmHEBhat4+46LmQZadNJrjiXIhLh4oD3pXKIocwUtcvAYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=bahgPCZQ; arc=fail smtp.client-ip=40.107.247.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWjppCOSH8YdvabfzZ30DTsVrg4YibcZWFwvGAQPqBfXkmR4+Ocqoo3fBYRDbyyg4u9A4vZ1ValLrwYGOz71uWH27IWCfKSKoN+Pe3i5t6hA1smnwNviF614UqaKV8J/eaS8X4NxdYXht+v/PpWcDw4gy5zfq6ZMkaapwRXLrn5M8WkBn6m1zv67tUo0RMSGUomTLRUdOeRQVHbKu2OaCHiPwlkFWuZpvjquAn4DMTlb7Owhzkn48+X6moecrWnwyaguITXwNzxYytgJtNAWi2V+cXq05PWu+QzncAF4QWuDUQL0cJUmKdNEA6huPYGtLwN74e9vPTtj7ORZmqnP0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SuXsMcackJSRmDzz1WjGNlm4nccKPW2VzLEe5+010SM=;
 b=Jmpx842zx9MiURLfPtnI5zzfFLhjCoBrFrCsojYlvOP2G1bHJmK9UipLjO07VjTO0nSUP22lx8dz02NfuZZHj90ceeswNFcqDFQqzSuV9gG9nhQZZfVg8eGdaNcxWD220BN55X6SyDEB4BlrX0ZdpqHF7tsg0uecr35PI7CBhit9CQ4LPl9GkbWobHM4SXa8iMxdS5k0JT2U2eJemTyzpAcf1OnhTSXilDKhVKq//M6tiD9N7A4kInWi6tkuQW+c0MQmZ6QHkI8bq/MH9vF7yxq2qbtOmJCIMdFGv44tjpTFwjrkPpAse6sqnXz3ClXEQzUHeNilJLzBhoQ2bPTDmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuXsMcackJSRmDzz1WjGNlm4nccKPW2VzLEe5+010SM=;
 b=bahgPCZQX+VtgXYeadq3IhIqTvBM5nnuRb97gjf6xz03FkOqJwnl3+s83VG+YYSfWSm4Abjbr1LIZ5istU9SE6Y3gHgCq/2eEQFwUVussqaCYt/ry68BmoKozb6K6qxXn0jwJwKN1B9ohyg1Dwr/RKsEm+uiEjCLa3rnTBUyTdA=
Received: from DB9PR83MB0537.EURPRD83.prod.outlook.com (2603:10a6:10:300::16)
 by PA1PR83MB0774.EURPRD83.prod.outlook.com (2603:10a6:102:48d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17; Mon, 10 Jun
 2024 07:21:00 +0000
Received: from DB9PR83MB0537.EURPRD83.prod.outlook.com
 ([fe80::f1f1:b6f3:3fda:937b]) by DB9PR83MB0537.EURPRD83.prod.outlook.com
 ([fe80::f1f1:b6f3:3fda:937b%6]) with mapi id 15.20.7677.014; Mon, 10 Jun 2024
 07:21:00 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>
CC: Wei Hu <weh@microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, Long Li <longli@microsoft.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next v2 1/1] RDMA/mana_ib: process QP error events in
 mana_ib
Thread-Topic: [PATCH rdma-next v2 1/1] RDMA/mana_ib: process QP error events
 in mana_ib
Thread-Index: AQHauwa+WBinT+4qmk+08x+b+okzuw==
Date: Mon, 10 Jun 2024 07:21:00 +0000
Message-ID:
 <DB9PR83MB0537451CDAA082BA24BC5723B4C62@DB9PR83MB0537.EURPRD83.prod.outlook.com>
References: <1717754897-19858-1-git-send-email-kotaranov@linux.microsoft.com>
 <20240609104618.GC8976@unreal>
In-Reply-To: <20240609104618.GC8976@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2e8b61c5-bcea-4689-96ec-a2d422e5c14c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-06-10T07:18:01Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR83MB0537:EE_|PA1PR83MB0774:EE_
x-ms-office365-filtering-correlation-id: 651b904d-840b-43d2-5791-08dc891de13c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?cUt5VlBJM2xLdUtCT3NsVENxQ1ZpM0dyMlJPNEJUVkxXLy9VbSs4QU1yK2NR?=
 =?utf-8?B?Q2lVS0ZJdWczZXgyRC9ML1NPUkdrbm9BYVR4MWliLzVQSFhwV3RlRmc5U1Bi?=
 =?utf-8?B?ZTBGRExXbGJSamorNUduMjhaR2tqTWpFdlMvZndwYW5FZjJLdEdKMU5lSjlM?=
 =?utf-8?B?ekxjemxKTjEyV0JMWnd1YXczTlFZRGpDUHNqUElPai90Z0hnSmpMV2VlL0VL?=
 =?utf-8?B?L3R5WkJjWStHZU1CSzN6OFU2eXAxaDJMWHJINnFIam96RW1lWFBIVHpYcFJ2?=
 =?utf-8?B?a2RJNE1KNy9QZTR4M01JcUFPMkxNWDR1N3FBbFNaMEJRb0gzak1LaE1wV1RF?=
 =?utf-8?B?cHNESlNHWG52NTh6ekxTcWtEekJmVmlHSGQ5SXY1eUFET21jWi9nWHVSc3Bp?=
 =?utf-8?B?bkNIRHNyVk50SHlLbXVRVEFTZmZtNTJWT1dwWXplTFlKWEh5b0pUbThWclZC?=
 =?utf-8?B?QVJnWUM2eFZWQklLbjVkVTJ5aUhRZ0N6VGhhbWxRSFZ6MS9oN0R4QzVmdklT?=
 =?utf-8?B?R0tsMDViaCtxWSs5NHhFSlhxTEFFbVREeGtLNGRib0k1T092cytSV0o1c2ll?=
 =?utf-8?B?MmRJQVJmcjl4NmZoTmVwNWt5b0Q0VW1jQm1vZkRCRkkyazluMjY4QmpOYUQ2?=
 =?utf-8?B?YkwzTE0yZFA4Z2xEMmQ4TXFodWdmMjM2bWJCanZQcDhRRW5MMVV2N1k4MEtJ?=
 =?utf-8?B?WEh1bHpGdEJ0SnIzOWtZTVNBekJYdFdsNzhhLzk3N2thNzgyRjBwek9rdWhF?=
 =?utf-8?B?MkhrNW14UGpRVmZGVVhCeTBpN2hWMjIvaHFlSEswTU5FZ1p0U2Y0cEhkZFZD?=
 =?utf-8?B?ZExpdzhhemFUMHdTeW1nUnFhc2FiUW5NQytrR0RFTjVOL3pxOFJITm5MNHVi?=
 =?utf-8?B?Ykl6Z0pMVXBrQTJhQzcyNkFMcTBWbVJkbVR1VHBmbGw1ck0zTEs2cXlmbmsy?=
 =?utf-8?B?MXlmWmlCN1ZxTEI5MFlkNW45d2dFVkVvTkZudnduOUwvS0xzajRjbi9xNFAr?=
 =?utf-8?B?QmFMRXIrYytuRGFWbmJWREY4OG5hbXI1YnZ1U3N3MGFxbWxTSEJLTndwNlh1?=
 =?utf-8?B?eTB3T2Y0RWQzemNXVU5WUW1ISkM3OFNTZlJFWVNNV1paWVV3aDAzT05kaG1y?=
 =?utf-8?B?MmN4NVRhVkdNUWlGVG5ORWhqL1hTV1pvTlUwUEtJbTRNQUY4NXc5cFV4T0JV?=
 =?utf-8?B?cTJGbXk4THRsT2VLVkVTdjBoOXFTbGIxSTZnQ3hKaU14VU9VZ1IxRE96em9L?=
 =?utf-8?B?WEhDSG8yaXo3UDhWSU9LaTUwdHYxcnFtUEcvZDExSnArKzI1cVptbnlHRktK?=
 =?utf-8?B?VjlvM0xjM0gxZjZlOXl3NGN6N1V3YTF1aG1OVElMVnVWcXdDdG1sSG1odTVI?=
 =?utf-8?B?UWhIZnZsMHVZcEwvaURaaXZNd0hQNGZnSTlDZDMvdHFMUGhYcUdrMXRodGZy?=
 =?utf-8?B?ZzlXMFZjdFRSTGJXeThtYzdwMEkrSFZEQmxUSHMxanFldDJVcmk4YWtMM1E0?=
 =?utf-8?B?RUtlU1lDQW9ubWd4a1hoNFJIS1JRSFU2WTZtVnMrNFUwdDh4L2hVM0lEa1VZ?=
 =?utf-8?B?dDZBdUdFRVFSU05JT2RLclZ6T1EvRmdqbllzTjhwN0xwc052dlEvWjR2Vmln?=
 =?utf-8?B?cjJtZ3NNTWNOOGtOVzczUHBESld0WGRzMnFUWHBacnVBWFkzZnd5Sm9FdTN0?=
 =?utf-8?B?MmViRHIvYjlSOFg5QWQ5c3BYSlBTeWhQdmF4K1pqcHBJY0EvMW1ySWUwNXNI?=
 =?utf-8?B?UkRlMGhXczhqTFJPdWxMWEtUTnJrQnVzVEdwTk42QXJGTENrRXVMTGpLYk5l?=
 =?utf-8?Q?vyScFtStp8uhLBDRy4voQmxrq4VmzAwoVQlsw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR83MB0537.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Qm8wbHZRZnlVN1Rxb0lDZ1pCaTVTM0tLMlNaR2NRdmVkaDhWRG4yYmtuUE1W?=
 =?utf-8?B?SW94eGZHMGtENVpuTHZNMnJYTnZ3dG5xT2xmMmZ2aFNUYmJBekZQWkt6dytm?=
 =?utf-8?B?ZXhHMGZycFAyOU91UW9sRnhZdFlya0M2VWhKcTRTWDU4ZWlVeEJwdnViMmU5?=
 =?utf-8?B?N2RrKytxcnFoN3hiajRCcGxTd1pRdUIwekJJYUhEY1dVNUJlcHdObUZoSWlv?=
 =?utf-8?B?Y213bi9PUVZmNGRaM1o1NXRqM3lHdjZxTHZkcFFtNzZFdGV5bUZVY3ZZUVpM?=
 =?utf-8?B?OExQamQ2V25IM0VsK3hHK1I5NVlhMlRGUmVkMmhpVTd0SEFHUk9PL2hBQ0RH?=
 =?utf-8?B?ZnAyWDZqQ1lsQXBQVmw4emRUaktnM3l3TTJuTGxEbDdJM25RakpNSlRPMFNm?=
 =?utf-8?B?ZVZzVGJBRExMTm55clRYVUdsRXFZbVRNQkhkakRnRzhjL1paMXNTUlc5Vjlr?=
 =?utf-8?B?b1U1ZG1RYUszMk1KcThBTWE0ZGVQeDNRaFBadUE0NzFYVEN5cUpVMHJxRHow?=
 =?utf-8?B?ZjJPV3hNQmY1NHFRbFJ3MUdQNFhRN0FYdGRTRGFUY01KcG55WG1BU2I5QllT?=
 =?utf-8?B?OUxlY3l6NUtsbHBnQStiYnIxc1o2dHFFNjFzTzhWakUrTEQ1YjBRQ3l4eFIv?=
 =?utf-8?B?cjBPZ0IrNGpIQ2xaekdxWEZSYTVKV09HaVdhU3EzMHRadkdDMVVuUGI2c29n?=
 =?utf-8?B?Vlk3K3NQY29NM0hkMXFrWXF4WmVHZkZjaG1oc2dockhXM2lLdnZBbU92VHNq?=
 =?utf-8?B?VDdMSXBVMjZaMi9VWElTaGFpb21qKzFvcWlwdis0eW5YRXV4cE5oRWVJd003?=
 =?utf-8?B?Tk1relJMLzJjcTNMWk9iWXMyZ2h6K3ljRTZaYndXTFdvQ2ozODU2bUd3dFZO?=
 =?utf-8?B?VTlIMUh5UE82WGN6V0NnV0RaVEtnMGkvSkZTSHJmcEdLVVhwSFR4UjdyZWVr?=
 =?utf-8?B?bStyLzkzTE9VSHFYN3RhSUt0dExIWVZFVW8reWZWR01vTk1rY1haWHViUGJj?=
 =?utf-8?B?UUw5RldxZlNKdy80dTF3aVlJV3FMdlAxL1pvU2laTS9NVWRFS1JycjE5akdX?=
 =?utf-8?B?KytvbngyTE9sU0lFbEw3azV3WUtJc1JMbzNrSTErSDJwdnhoaDhaWW0zM0lT?=
 =?utf-8?B?KzRjcUEwbC9qTHc1RzAxQ3lNZXNlZFVqbXFUSU5zOGN1cWVRR3pUTlg0a1d3?=
 =?utf-8?B?Qm9EMUdiVldGM3Jva1NlckhrTlBCVzNJamovUmwvaTBOMGdjaHZkV0pqRmxY?=
 =?utf-8?B?ZjI4aVRWclVnd3ZCdVRNdmZmYkNnRmlGSHUzNEh4Qm9obnFxWU05S1dhUlM4?=
 =?utf-8?B?TXk5clJMMk1RU2hCT1FKT3dxWFJHRlA4bkNKb2xMWTBPQUpmVThYblZZdXR4?=
 =?utf-8?B?OUxwY2YwMnlNME4ySVVlMkh2MDBmYTF2bDFlZDRvKzdlYkFXUXlzWmlvOUJp?=
 =?utf-8?B?TUpsYXZpWEhOLzVCc3RHeWVvbkloOVV5OTE0VmlBTGpjdGFqOUtPZXVDTU5D?=
 =?utf-8?B?MG5rTllZckcyeGw5dXRuT2JiZ0x4YlhZRjBjeW41VFIxQkJZdTNZaWh4ZGdn?=
 =?utf-8?B?WVNUZGFWa1djUVdYbjRXVFdsMThMMy8wRXlkTDVnSSt1aFU1ODNEVGNlSmdL?=
 =?utf-8?B?UGVDWHJwN0lvdWxMN0NPUkpYOUZ1Tjd5WDc1dUYwMjRmeS9zbVFYSG1PN3B6?=
 =?utf-8?B?TlQyaWpMQnVONVlVTThueFpGMjgyQXoxdUh3U2VzUFhCZ2N4Tll2cDBTYWZH?=
 =?utf-8?B?cVZqeURFSDBBS05uWm1waUloYlJzM0NLY2pjMWxQSlhlS0VBdXJvSDZCK1dF?=
 =?utf-8?B?cnAyUDNmU3MzM0cwdUhURmlHN0xVRTRGV202SXRSTkppRml0Z1VRVmpWb2d6?=
 =?utf-8?B?eFhGdngwWndCZjBQTzNpOUUrQmlBSzQ3TXYrM0c1dFdyeVhqdmdzbGlKeGlQ?=
 =?utf-8?B?dWpsMDdRRWUxZnpOL0NqZ2JMbXdQVzY1ekl1aCtLVXRqVURZRngxYmgxRi82?=
 =?utf-8?B?NG13eCt4Vit6MXM0UUp2SmduRFY0VzBiblVFZ0dYVmllbkxiKzIwZmNYSHFB?=
 =?utf-8?Q?QLYPWj?=
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
X-MS-Exchange-CrossTenant-AuthSource: DB9PR83MB0537.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 651b904d-840b-43d2-5791-08dc891de13c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2024 07:21:00.5347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G7OFieQsl48F6CRGcR9EB9kpY0EvweOWYws3bWexIxN2euuirgrk3647VD3Xgjy44tCS9+gfgtYDWOUe9zhbpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR83MB0774

PiBQbGVhc2UgcnVuIGNoZWNrcGF0Y2gucGwgb24geW91ciBwYXRjaGVzIGJlZm9yZSBzZW5kaW5n
IHRoZW0uIEkgZml4ZWQgaXQgYW5kDQo+IGFwcGxpZWQuDQoNClRoYW5rcywgTGVvbiEgSSBjb21w
bGV0ZWx5IGZvcmdvdCB0byByZS1jaGVjay4gSXQgd2lsbCBub3QgaGFwcGVuIGFnYWluLg0KDQo+
IA0KPiDinpwgIGtlcm5lbCBnaXQ6KHdpcC9sZW9uLWZvci1uZXh0KSBta3QgY2kNCj4gODc4YThl
NzUyMDQxIChIRUFEIC0+IGJ1aWxkKSBSRE1BL21hbmFfaWI6IHByb2Nlc3MgUVAgZXJyb3IgZXZl
bnRzIGluDQo+IG1hbmFfaWINCj4gV0FSTklORzogbGluZSBsZW5ndGggb2YgODggZXhjZWVkcyA4
MCBjb2x1bW5zDQo+ICMxMzM6IEZJTEU6IGRyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL21hbmFf
aWIuaDozNDA6DQo+ICtzdGF0aWMgaW5saW5lIHN0cnVjdCBtYW5hX2liX3FwICptYW5hX2dldF9x
cF9yZWYoc3RydWN0IG1hbmFfaWJfZGV2DQo+ICsqbWRldiwgdWludDMyX3QgcWlkKQ0KPiANCj4g
V0FSTklORzogbGluZSBsZW5ndGggb2YgODIgZXhjZWVkcyA4MCBjb2x1bW5zDQo+ICMxNjc6IEZJ
TEU6IGRyaXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL3FwLmM6NDA1Og0KPiArICAgICAgIHJldHVy
biB4YV9pbnNlcnRfaXJxKCZtZGV2LT5xcF90YWJsZV93cSwgcXAtPmlicXAucXBfbnVtLCBxcCwN
Cj4gKyBHRlBfS0VSTkVMKTsNCj4gDQo+IFdBUk5JTkc6IGxpbmUgbGVuZ3RoIG9mIDgxIGV4Y2Vl
ZHMgODAgY29sdW1ucw0KPiAjMTcwOiBGSUxFOiBkcml2ZXJzL2luZmluaWJhbmQvaHcvbWFuYS9x
cC5jOjQwODoNCj4gK3N0YXRpYyB2b2lkIG1hbmFfdGFibGVfcmVtb3ZlX3FwKHN0cnVjdCBtYW5h
X2liX2RldiAqbWRldiwgc3RydWN0DQo+ICttYW5hX2liX3FwICpxcCkNCj4gDQo+IFRoYW5rcw0K

