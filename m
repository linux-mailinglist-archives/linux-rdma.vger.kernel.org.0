Return-Path: <linux-rdma+bounces-18991-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Ps15Bowa0mm6TQcAu9opvQ
	(envelope-from <linux-rdma+bounces-18991-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Apr 2026 10:17:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A15B639DD38
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Apr 2026 10:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 74FD23003987
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Apr 2026 08:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B5B35F5E9;
	Sun,  5 Apr 2026 08:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="owMv12WF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010012.outbound.protection.outlook.com [52.103.73.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E51740DFAD;
	Sun,  5 Apr 2026 08:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775377032; cv=fail; b=ldJFQ0kGk1gQ5ohZgqxbfjsUrXGc0HKRvhT+5uPcWTIY8mT3DSPsmhUQp7DjrfTevYk4OS5cy6uiydd6PaG45Qwp4nfXbcp26VzpvUmm9VTF05ucjpbe3vvRRbq/BD955XmnLjZ/IW4BmJtdC1YU8tYzAXPHjkhAe40Y39/UKZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775377032; c=relaxed/simple;
	bh=PGm0V62uk99G+7vr67GFay7TOGsI++xGs3q0KGWQRXI=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:MIME-Version; b=XsJzATQOnJ9EXm4F33Mvjwd3LFQwUXnySdnqgOZKTEsCXmy/EL4mbE+6kEKmbXuWDPnh9BRW8KfTQBrluko+nx9SMuIStc0SaJfQOhH1NAMjtmIgekWRIFMs8TXr90h9rCLY6fMUjUBW07c6k/qA+IzLp+uMOw36pMz8NZoTtsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=owMv12WF; arc=fail smtp.client-ip=52.103.73.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LuylwX+JtxhvM+DhVX2N9gJY4YY3XPw8pp3eG+fZbVtbMH1A6izTOfmBQ2IsTGwFDkFA2iQ/pyiL+ZVoiIT/IfVkcY6+Yhjd3UZh0EYzT4AFZhyhzXdsuZCq7vhOrZzRfKlxuldWOemgiSWNJaRKfTB3jo0e7esGbFGlE/cmA5vhOHgCAAHrVFM6jvL2MQTazp9NCFcKpUnavsbaC3EczlAI740H7ZOurftwgrf2EL0s5b2OO/ObMPPFE/1biAl83pgdEg7eNQOmq4fUo7eWGuSkx9RcdshVE8IwiNlOP4tF29ttigrTeZRpK1EB9gvZOXDtl6aGidGBn931ZbWXHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkaIwY4P8IUnVj/bqwWm9qzat5RX2c5nqAO9hRF+Sb0=;
 b=aPt2qej0hD7Ne1sMw8CVwzjiNljuAGIOOl6+0rWbI0RAFHiupl3UwE8F2FLByQU/kMc8BK9mq7IyR5fjBpH0ZZ8GaWdW7htm0IbVtvpoEkd49evNqe6bK0AkcK7G6LHOoYUiqET8aeS9tb4QBTl6I9H42u0Upu1g1nUoWTnhllV7PGEs9okGzBJLHi0RvY0zkvqjrBBOZTub90kp98pumaiJhADS5MptHeL9tSkT7I3O6uzg5AdNdBFtV/uz7mrXpofHSxDmj4XRDC3hm/5GzSUacqoAZ5GG9aJTU02N8yCnrbYHHhd4CDh95d+GO6OPLLnHk9utqwqXVWMS0ZERVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkaIwY4P8IUnVj/bqwWm9qzat5RX2c5nqAO9hRF+Sb0=;
 b=owMv12WFicNomi7XtOnrzeSXonJIa8mPdP3T2ji2m+IdYKI9Qy/Z22ccjEFFy+EZtwWynRCG8UVqn0OxUcL4h7/WoWEN+HYiUADwxCkBx2OR3a48yoFBrD9fPk/AS6+lvOp6G2gUwF5fQOkn/0j1Uz0HwjUzh0wYvzq/m21TujuqJhuQznJ1lLlzSdchnEPdoEJjCoY9AlN8VH8xiYaDyAxSZHhZsTL51gmCeLOeV6h4RkvstjBSFq/iJl2u9ApJM2VfvRZGHgLqrHhGDIb3n2ma/pAzjZ9oPT92vIZavunlPYDRzPCrcmv6USMNVz6hGcLguoWX1CRiglStd7EOIg==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by ME5PR01MB10492.ausprd01.prod.outlook.com (2603:10c6:220:255::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Sun, 5 Apr
 2026 08:17:06 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9769.017; Sun, 5 Apr 2026
 08:17:06 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Sun, 05 Apr 2026 16:15:44 +0800
Subject: [PATCH] RDMA/hns: fix out-of-bounds write in IRQ array during
 configuration
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SYBPR01MB7881512F49EA80F0146EEEA1AF5CA@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIAC8a0mkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEwNT3bTMitRi3WRzw7Q0C2OLRNM0MyWg2oKiVLAEUGl0bG0tALr1mCF
 XAAAA
X-Change-ID: 20260405-fixes-c71ff838a5f6
To: Chengchang Tang <tangchengchang@huawei.com>, 
 Junxian Huang <huangjunxian6@hisilicon.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Leon Romanovsky <leon@kernel.org>, Xi Wang <wangxi11@huawei.com>, 
 Weihang Li <liweihang@huawei.com>, Wei Xu <xuwei5@hisilicon.com>, 
 Shengming Shu <shushengming1@huawei.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1772;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=PGm0V62uk99G+7vr67GFay7TOGsI++xGs3q0KGWQRXI=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGzEtS+h57P+yUvfXD6d+9xAnzQqSmbiwIiNg++dj+6
 svFB78sXXe9o5SFQYyLQVZMkeV4waVvFr5bdLf4bEmGmcPKBDKEgYtTACYy4RfD/4BndZsm7Tq0
 /uOWxgLfFWG16c8uzmLdPlVK5/WS+a3SWX8Z/mdc27Kv8VR8uMUsZcUwwdMv0iassZ91P9U8OV8
 ysCiPgQsAMStQyQ==
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: TYWP286CA0011.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::18) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20260405-fixes-v1-1-781de46c1406@outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|ME5PR01MB10492:EE_
X-MS-Office365-Filtering-Correlation-Id: 83f6dd22-128c-44c0-f6b1-08de92ebb95e
X-MS-Exchange-SLBlob-MailProps:
	dx7TrgQSB6d5vbofsfC/jnGJ+j4hG4ECPY3OdA+ZAG41lDO889knL7K8ADY9sFVoyS2bdRslYpmx/C7grtk+94P36r8nvwEhkPu4IOL5YWI8d0pZNc/1fkHWGLlx6Dz7k7+4pVg7jTF9tJ95rIB+tbwoVnXGEea/8LQJm+JWRxyBzgGEsyxSJuKSR6Rf4r3//JEORC+KrsWPkQ7S9LaZb5mx8JKTKKZxPO5ovtdbVncLF0VsaOST3+Q88L3L0BtC7t0glojf9LLBhj3y29A+QILGP7bWGPfeuIAnPE+TMKtp2N3JRC5F2SOm7r/gkvBcOBPPLqwbX64NjIIpElsfEUlasDnOFvpWnuw1uPJA4BFZqERkryIwM0V2N0Kw5v2oRPi9vxiE8Esq+WJSEQ/k5Wkg0eAi5geKcSHY6eLFVJLfQKo8yZntOgEGzwJV4Ts1603tqWGTRrc47UuYLoX/Kav7IzYDwf/v3ecThQmVFy4aCNzGMxzWIYaKLAYwfycLgVu3Zun3krpi0BLwu+I5lu8V3Nl3D3gPbVAN3Q3oBWEM9W7AvWgxNc1hkQWwfhEukhO61bloEZItvyVxzIUqYkMVjvpN+cUwH6p91b9+NqUG/SAReFTXqFa5PxsBumnPfvuua5RSnxvfmGtD0Mb6SdF24oYC0ABEXy2Y9K0aimc4BTy7LuCkGOVXWzj2LSbU/hhTOc+q5znD8RCM4PhBP21GrpdFwmJUG03wCHEzzCtIK4IqSdzlCkiwwoqTnQCpfRFni0v9yHE=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|8060799015|5072599009|15080799012|461199028|6090799003|5062599005|23021999003|22091999003|24121999003|440099028|3412199025|26121999003|53005399003|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUowK25ZTEZIVWZ5bDRVUkFCYlhURW03bTZVTStPRkxuNGFYeEU3cTMxSlZF?=
 =?utf-8?B?Z2hQSTBhRW0yR29XOVVURVJOUHhWSG1sNkpoS2ttV3FTODhjdGx0elRHSU9t?=
 =?utf-8?B?R3RqUDJMb3M0NkZmaGpRZCswbDBCMjhvSm9rbENFZjhtMlh6OUZoNndmVlEy?=
 =?utf-8?B?Z05BSzBFOEtCYU8yenAxNmFRMFFMWVYxR29VaG5vNk5UMWFDYXdNRTJYS0RS?=
 =?utf-8?B?clpMb3N0Q0R2MGd0MVFwVzJJanBnOU9vS0ZrQkdHT1RGV3RKNDRzUkNqNmRS?=
 =?utf-8?B?MjE5ckE4cDhiNWhTNE9sUVBJdVlhRENBYmxnWU8yTjB6MmcyQ0RRbkJXTFc2?=
 =?utf-8?B?Z2VJcGp4Z041Mlk3R2QyMnp6ZktoNXVnVlFmY0pxVlVyVDU4eDBtS1c4eWZG?=
 =?utf-8?B?dktHKzJoc0hnVElseGlTbk1sMzJrN3kvbG93V1lWdmZDaXlRb0RRS0JIYnh4?=
 =?utf-8?B?MDROSTVsTUJrcFlpQ2hOWXYvekJuUGlwTm4veWU2dkZ5b2lBL3RqRGNSRExD?=
 =?utf-8?B?OG10QmNmbG40ME5zWVFUMTB5UmZWalJRLzBZTjhUWkVjckFSdVpseEF3bXlW?=
 =?utf-8?B?ZEsyekluMlR2UHdGRUMyN3hBdXRTRG9EaTVsNnRnK0VTVGJUWkZ6K3dJTWxW?=
 =?utf-8?B?YTN1VkZTY3h6M0NuZjRKZ1gzakJ4dEdKRGowcUU5c2JjbW5OSkxaNDYwdDRr?=
 =?utf-8?B?ZThkL1IwMkN3UWdqamRKeXo1TnBlMVFQQVZibVFnbzRqZklwOUVGZ3orci9r?=
 =?utf-8?B?VTk4RDFDVEVNMFZEb3lIVmZWZW55bU8ybmVIVnFYb0paWnFrNEtkNnZWTHpt?=
 =?utf-8?B?cjk1QWxFMXpmK3VERkxUVlVxN2I4ZW5jQ2RqY1piSHAwbjZWQy9aaXluNCt3?=
 =?utf-8?B?ZVE2bHFyV3IvMXp6ZmM3YUNIT0JVSml2V1lHdG1oVCsvS29WMnRHU1dHS29Y?=
 =?utf-8?B?eUFHclAzSzFuNGhobis0Mk1aVDZ1dWh4RytNYWdGaENBZW80dWFFOEhKYjdu?=
 =?utf-8?B?YUZOSU5RcVBoQUZYa21sWTdIeWU3Z0NCT2FDaStkc09GSkI2L2RmMUo4d1g0?=
 =?utf-8?B?WnVZaW9pb2JqK1lWYjNwWXVXVUNuSVlzaVUrQWpkMWdxaXoxeEdqT1AzVVg3?=
 =?utf-8?B?dWNXd2xLUVJST2dMc0lCRHh6WHhaSGN0TG0wZVRDTy9aZVFNZWRNTExtRlor?=
 =?utf-8?B?cFJkSG9JS1BVa1BxNVZiNVJsQ3lNZ3BaWlV1b1pKVXdKVFk0dWppTWRKMm5x?=
 =?utf-8?B?UmZ6akpqZHVqUThrbHprR3BtTTZhOUNaK2N3NzZrYzd2MklVLzVvdXJPc3VK?=
 =?utf-8?B?akZSby9xR0FqRVoxbk9BMnRPUWxpdVFJR0ExeGxjM0owOHNTWjZFRjkrWVRp?=
 =?utf-8?B?TWQ1cnR2amhZcExhb2Z4NXNETkI2VGgraDk1cDlDOHpGTUZudnN1OWdWdTh4?=
 =?utf-8?B?S0VmSkpyR0tIOFpGTGRtYmw3MGlSYTFoQWZPQWlnPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnBNbmlscDZTZlcwb2JOMVpybVFEekdoRW44K0ZONThVTkhHL3pkWEtYbHR0?=
 =?utf-8?B?K0tHRFRCWjd0SVQvTis4b1NNTmdLSWpXb0lZSnc1NGlPNUhBMzdBQzVxM3hm?=
 =?utf-8?B?TFZoREVKOWhCUExqMzFwV011cWdHUkVuUHU2M1A0MytEN1h4L0pTbnNGNTdG?=
 =?utf-8?B?eUV5NURPaDJwR0ZIU2VyMHpzMGVjNlVRbVREcnNaWnhzV0ljQVJuWEtNVXBQ?=
 =?utf-8?B?eG1MUjFaU0ROdWZRY2FkL0J1NVRldlRaWmxRZjhFSUh5Sks3bjFWTVdDUitT?=
 =?utf-8?B?cjN1U1BnQXptRUtzamZWOERxemI2ZzA5aS9pSFJ0bkZablZpZGNMTkdxK3FH?=
 =?utf-8?B?aE8rY2c5RXB0YURnS3pCdlI2K1BjQW81VEZBM3NCUWJ4WXFJMmhDalI3MWFB?=
 =?utf-8?B?amZ1LzhmSG5XR1RHRzFBMjVhQXp2R0twa0xpbm96TFovb0ljL3NXa3BQUC9S?=
 =?utf-8?B?dzdOZndJdzRyL215ajhjeCtQZFRzLzBpa05wWHR4MEdDOS9LRC9BOVZyUlJI?=
 =?utf-8?B?V1JiR3MxeVJGUzJVSUZxRmloUWZ3c1ltV0haU0tlOVdPck9mSXBsQnd2czkx?=
 =?utf-8?B?aFZyVnlCdS9xNndpdkJhS21jTGIwRVowVHFkNTE4M1B5Y2REaElrZkIwWjUz?=
 =?utf-8?B?NDBqQi9vcnFmS0ZXaTJXWFZLajNuRk9QOGd3bVlsd2pKRW5KdGh5UGxVY0tu?=
 =?utf-8?B?c0pqSm81TXpPUmFFbkFrV3o4U2phNTB2UUx1QlY4OE5aU0hiOHg5Z2I2UEkw?=
 =?utf-8?B?djZkdjRIZ2VqWUptdkpzd2tsakY5b0dBb2JlTG9UUDNiZStWeUQwZHlJN2Jq?=
 =?utf-8?B?Y3ZYYzdqRGRaYmpuakhwbXBrNXdYRU42c2xhV1MxN3kyeVZrVFdFZEFpdFpm?=
 =?utf-8?B?L0hMOGVsK0xkRVVNeUF5c3QrRTJVZmRJRkl5b0R4RmxzckplYjhGNDhlNXNM?=
 =?utf-8?B?R0NZUGdLV2owbFlQZzNxUTA0VDZXK0U0a3JDL1E1S1lGTnhha01mM3VCd2pw?=
 =?utf-8?B?TVZHOUxBS1doNklxY243bnpOeWlGTHZhUlBSd2JrV1dlU1VUdVcyY2FvcHc2?=
 =?utf-8?B?YVBiT2VBMURYRGViTHovR2NZQTVIUlNBd2Q3c21hZmRlNkJiVmg0Qzl6dGg3?=
 =?utf-8?B?SVo5aUZ0TWRvZ2Z1Vzgvcy9iVE5nNzh0ZkY5d3kvZlpnZHVaT3FhNHhNbFY0?=
 =?utf-8?B?dW5ZVWlKdk5tc0hkdHFUeE5ITUFDYkZWc2hnL1lRRUwxZlpRbmZFKzBTdzVZ?=
 =?utf-8?B?VlBvMDBrZGllTTZDSzFNSCtNdm1tMXFaYWVRN1B4NW1zS0FlM3AwT1Z6eFph?=
 =?utf-8?B?Q1RMVXhZeWdOeGFISW93YjhHa3NpZml0Qnp4SFB2NngwdXpLbVI1YzJ3Tmg5?=
 =?utf-8?B?N2FOYVNsb2VhdG5IdWU2dnlRMHFqSzRDbHJGdzB2Z3hERk1hRHc0VFBhcXJS?=
 =?utf-8?B?eUs4T3NtTkNhMVdtTGdReURFY1AwNnJtZ1FNcms4cTBpSWpJWXZQcTJqd2J1?=
 =?utf-8?B?VWI0MElrSEx6bWhkb2FYSWNJSzh3Z2NBYnhZK0w4dm95TTdoQmFVbjk4N1ZU?=
 =?utf-8?B?bzdPUlM2YXhpVW0waUFtejF4VE9DbzBmMzJBSENvTXRmZmVxbklKTEhHVFhD?=
 =?utf-8?B?b0JoNEZrTW1yVUdmSVJsOTJEbUNEQURLeWlIalI1c1hva3lYU2VmUDhtK01a?=
 =?utf-8?B?OTluZGJFZTQxTHJQazVCaUV4NWNXSWZWTUJKdytnSldEMDZzazhVSDJweVRt?=
 =?utf-8?B?Uy9mY0Qzc2QyN0hxTFFqSjN0ZTNHUDZSajdaNEI1aXJleFNTNTJlYWNhMTlN?=
 =?utf-8?B?dlNrZWVBSGRDQ3F0WVR0RTE1bGNISFU2bDBlZ3Zqems5K01Ddk81aVhIZ2FZ?=
 =?utf-8?B?ZU9ucXpEcWR4VFByL0dWUlRrdVltVngydTRseUpHMGV6VHc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f6dd22-128c-44c0-f6b1-08de92ebb95e
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2026 08:17:06.2973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME5PR01MB10492
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18991-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,outlook.com];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,outlook.com:dkim,outlook.com:email]
X-Rspamd-Queue-Id: A15B639DD38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

hns_roce_hw_v2_get_cfg() writes IRQ vector numbers into hr_dev->irq[]
using handle->rinfo.num_vectors as the loop bound. num_vectors originates
from firmware via hclge_query_pf_resource() without validation against
the array size.

If firmware reports more than 128 MSI-X vectors for RoCE, the loop
overflows hr_dev->irq[], corrupting adjacent struct members in the
heap-allocated hns_roce_dev structure.

Fix by clamping num_vectors to HNS_ROCE_MAX_IRQ_NUM before the loop.

Fixes: 0b567cde9d7a ("RDMA/hns: Enable RoCE on virtual functions")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index fa36700d0db2..6983f39d7333 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -7288,6 +7288,12 @@ static void hns_roce_hw_v2_get_cfg(struct hns_roce_dev *hr_dev,
 	addrconf_addr_eui48((u8 *)&hr_dev->ib_dev.node_guid,
 			    hr_dev->iboe.netdevs[0]->dev_addr);
 
+	if (handle->rinfo.num_vectors > HNS_ROCE_MAX_IRQ_NUM) {
+		dev_warn(hr_dev->dev, "num_vectors %d exceeds max %d, clamping\n",
+			 handle->rinfo.num_vectors, HNS_ROCE_MAX_IRQ_NUM);
+		handle->rinfo.num_vectors = HNS_ROCE_MAX_IRQ_NUM;
+	}
+
 	for (i = 0; i < handle->rinfo.num_vectors; i++)
 		hr_dev->irq[i] = pci_irq_vector(handle->pdev,
 						i + handle->rinfo.base_vector);

---
base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
change-id: 20260405-fixes-c71ff838a5f6

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


