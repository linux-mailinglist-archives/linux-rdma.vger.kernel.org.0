Return-Path: <linux-rdma+bounces-15761-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKAgH2QpcGmyWwAAu9opvQ
	(envelope-from <linux-rdma+bounces-15761-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 02:18:28 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC74C4EF61
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 02:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76AD58296FE
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 11:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D01425CEF;
	Tue, 20 Jan 2026 11:43:52 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010021.outbound.protection.outlook.com [40.93.198.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4B3425CEC;
	Tue, 20 Jan 2026 11:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768909432; cv=fail; b=TWiL5Jqbi/PvFJfjmB0x4pxilgZkdj8lRYLAmJMicoMJqjMsrpdQrUn4LrVlS0kkwrZ0vEPblGFlGxXR1/2HRw4ID697mGrTEmosK4OYtlJQyoVbRXYuDJ2x0Ht3hA+J9Muh4buyZ2jrl89R9/NFnFIwTsp1pkgYC8dZ4R08WXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768909432; c=relaxed/simple;
	bh=OSrXc7shjCdn4plgmmGN+QJHQ3cXSIEpDxP7IhHOy7k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kwbt2YiX9PbldFW/wtmdBgVva+rs72ORXgNuRnGrsFt8VFwEQK22tmmtZ1/dckvqGLsoFy/Meu6GykR5ph/XvkAu5Y8dwigY9mWLDe4UPk1+47hIHkuKeN6L/TrlC14Gzfypsql2ishFRhYhdZiX034H3P4djniSUMa/RG915js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mellanox.com; spf=pass smtp.mailfrom=mellanox.com; arc=fail smtp.client-ip=40.93.198.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mellanox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mellanox.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbyblUcu38QJhp+LHmA7o02m32G2oAgV+7iwQ8jJipkUjmbg/5KbVszRVng6ztpsF99UxBsZhiVMUYYQ5TD5Y4HHK1LRWA9wJZL9eZiyX0//+FilL6dXkEd5cpOqN03D/cIMahqURm0iRGqNKcDlBVu9cufqoRBWOm0en18QEqifTdwTCMRPTt4iYHmU/rlacdq1Jy0BD55iav5KqeYfOS6Uhp2fZ6nq3YcUNLERPawn6SAwgFtACBBbEQBM5wRLJzdpbRyY/2VzjJihOsNUcXXBW7RXs87JLA1CUks9VMyjypmoeKcoXxE8z6saRLQeqfFMp2v1iTNSEEW0/k4J4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSrXc7shjCdn4plgmmGN+QJHQ3cXSIEpDxP7IhHOy7k=;
 b=hFLUWGz0CAmtePxKkEypbSwD+gXT8ahZ9hON257nk7/00aTZ2eUqdmBgkO0paEsHm6brWEU1s7w9Riud/g3pC/DZi8E1cERC156mbZnsxpZ8xDm5GxWt5rT4U2H+IkZJIVjiy+xK0UKX2eqvDyw1yo2S7cVWee8SkneK2OyDhImXECBfVcyG3wP4ttFk+Bgh8UJfdjI2QMihcHy8JfkJg+MtCh/e/IvJU28pNsU6xUf7nXA8UKEwEeo0sFadq21/0b9dL37QebEwVJu8cwhhztDXWT/n9EX4zmXY7JEIi47fTeGYn3Ix4mbsdigMFPSg+8K3pG3v2tE4peBsMElgJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
Received: from SJ0PR12MB6806.namprd12.prod.outlook.com (2603:10b6:a03:478::7)
 by PH7PR12MB9076.namprd12.prod.outlook.com (2603:10b6:510:2f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Tue, 20 Jan
 2026 11:43:47 +0000
Received: from SJ0PR12MB6806.namprd12.prod.outlook.com
 ([fe80::99df:c2ad:bede:3eec]) by SJ0PR12MB6806.namprd12.prod.outlook.com
 ([fe80::99df:c2ad:bede:3eec%4]) with mapi id 15.20.9520.005; Tue, 20 Jan 2026
 11:43:46 +0000
From: Parav Pandit <parav@mellanox.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Huy Nguyen
	<huyn@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
	<leon@kernel.org>, Maher Sanalla <msanalla@nvidia.com>, Maor Gottlieb
	<maorg@nvidia.com>
CC: OFED mailing list <linux-rdma@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>
Subject: RE: [rdma bug] del_default_gids() is not called upon
 NETDEV_UNREGISTER event
Thread-Topic: [rdma bug] del_default_gids() is not called upon
 NETDEV_UNREGISTER event
Thread-Index: AQHcifNuMxMqBHcCIk+l0/P0B4ODo7Va7fYA
Date: Tue, 20 Jan 2026 11:43:46 +0000
Message-ID:
 <SJ0PR12MB6806E77B849859B7BAC8CC1CDC89A@SJ0PR12MB6806.namprd12.prod.outlook.com>
References: <c1f9511c-7ad0-444d-aa0c-516674702b4e@I-love.SAKURA.ne.jp>
In-Reply-To: <c1f9511c-7ad0-444d-aa0c-516674702b4e@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mellanox.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB6806:EE_|PH7PR12MB9076:EE_
x-ms-office365-filtering-correlation-id: 432012b3-d156-4300-0e28-08de58192bfc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y1Rkelpsanl4WlBNT0w3dGw0ZzFlUEtSZHZ3NlA4Y2hNU2hmVHRiTUltdE1K?=
 =?utf-8?B?d0s5VDVoWWQvYTBNdTBGcjZPSU1jTFNJMVB2MHMzMEJRQWNLV3RZaWJRMVVB?=
 =?utf-8?B?R0JIczdQa3NJSWFXSlZ1bnNqZkp5YTQ5a1F2WGxiZGRRK0hiQU12Wk9EUXc2?=
 =?utf-8?B?QjVpMW83TWVYcXV3UU1lV1l6ZFFMdHlyVzBBTGtPVWp6WDFnY3hsWDl1UkdU?=
 =?utf-8?B?ZXdpWGpTRUlqWEFMS1QvckFEQ3FaSS9xRnFPMytsZ3RaelpZckdrZks2Wk9J?=
 =?utf-8?B?ZzMwQUQ4QnBsaG9HV0RFZXNnOWpZU3ZyNVBqcWNmc3A2dHlMMVlKUjh0bFg5?=
 =?utf-8?B?T0JIQTRKTW5taEFnZitMRGtDT1J6UjhTcDRHaXl6V0FSNit3WnJwRkRHY29o?=
 =?utf-8?B?NjdqT3lRbk9BOU5LTFRWYU90OGN3emlLdW9wSjlXWDVWOGp1aitJek9tSGlZ?=
 =?utf-8?B?ZU9CZXFaVHNQbDBYZlFKeWkvc1RZaUhNMWNSZmxkb1F6cGE5eUpVYzFycitJ?=
 =?utf-8?B?ZkhycHdtWTFZdTc1R0hXLy9xZmFCR044MGtCYjFpQnUrNEVtN2xYWVhEQnNL?=
 =?utf-8?B?YXZTS1duM29TZnRHMHdWQ2J2VnhNRjNBeER4amZFZmNJWHVRL0NlRXlyWEJS?=
 =?utf-8?B?ckRnTk92ZkIzb3ErTCtYbG45TjNOUElrRWN1RVpvOTBRRmFScVRiRmF2RDZ5?=
 =?utf-8?B?ODhMV0pDK0g4UGExd0hrTUJQaXVJdzMxRjN0em5hR1laSGI2ZC80eGljU0J0?=
 =?utf-8?B?QnViOE8yQTdCYysxTmo4Q3ViMUdYcVE2MkdKQktnd01YRXZ5ei9WbkRTR1ND?=
 =?utf-8?B?NERYQk5zbndrZitmTTVyQzZYMVl0Nzdtb25Fc3g3L0hNTEdZS0pvWVluVWpG?=
 =?utf-8?B?OXhDbHhLNmJHTkNGNEJWNnVCSDc0b3BxTThPZUdwVk8yTHBkaDhpb0xhRldy?=
 =?utf-8?B?ck9iT1cvSWhnYmFzOHlGOWFDVlFZQ2g3bngzTGpTQVUvUDBnaXM1eWdRN3pK?=
 =?utf-8?B?VXJqU3FvamtQTlhUK25mUThvNi90dzdNUXhpSXcvbTBub1cyaURveGk5OW84?=
 =?utf-8?B?S08rZmVGaEhBVDdGTkFVbzFWL0t5SGExWWt3QWlHbVBaWDEwbzB5L0hMbzRB?=
 =?utf-8?B?ZnRabVl6N1FTcFBHdEdIRk41UVN0ZGhvcGlWdVVWQzl3Rk1pRlNaQWFibXpO?=
 =?utf-8?B?TURJalY1RFhLcG41aVdOYXdtR2VwV1cxUzlTSjVETFdiZDJXMGZncFJ1VDlw?=
 =?utf-8?B?ZTFmTCtIYWV4VUw3VE10K1FJOGtlSVNhMkJxaFhISDZNcy9aeEFSa1QrNjI3?=
 =?utf-8?B?M2NaMzFPUGVhUFZacFQvN0ROdzcxa1BwT2YyM1F4Nmo0bEp6VDZKWGlpQkhY?=
 =?utf-8?B?eVE3TVlTNHRxNFk1QzROSXBHNTlQcVRkVUprd2NUWHh6YnVmb2xIRGt3cmkz?=
 =?utf-8?B?bk92Z2xpaCt5K1Zrd0lkdlgrL2lESitwRzdOd2tPZXF3VEk1d3FmVkkwRVlp?=
 =?utf-8?B?ak50TU5EdmQvVmF6Z2liMVFDM2hMdEVncCt5K2lLVHVMMFYyczlpc2VTSTFh?=
 =?utf-8?B?ZUJGdm5NY1JaUGEyM0ZVanA2Q2ZaeXZCN3M5bTV2cVVaeng4UUd5ZzlxamY4?=
 =?utf-8?B?dVJmcU8zSTgxTTF4Z3o2bHZPZWJXcDFXb1l1NUJCVkd0ejhRTlRRMjhuMWdK?=
 =?utf-8?B?UjdEbU4wSStxQ3VsdHlPSTM0STZ3THhCdUhVY3NlRmdwZjFMc3JZYnN6Y0Rt?=
 =?utf-8?B?T1dENHRzU1IrVytVeG1CRkEyYkNLRi9KNUkyR2FIRE1jL0RUVzhaSDhZWm02?=
 =?utf-8?B?VDFxY2xyNHNJZnNoOFJBV0lrNTNNdENMaStGUVErWEFCSG9vblJOcmNmQjhR?=
 =?utf-8?B?MHNieG5uSkhNaWQ2ZXRJOGNQZFVwOXR4OW84TDY2emlUclVwbzJmYm1pOS8z?=
 =?utf-8?B?WGROUVNIU1NpdnJmeEx3SGNlamFVRExiMXJycmVKK3N0bXEzdXZHNlU1cUp3?=
 =?utf-8?B?V2V5VWlDd1dCbmJzNEpoL3FoYy9pR2tzWmdXamV2YzA5T0dqZFZYYkJEd2E5?=
 =?utf-8?B?WDljRFM5dlJhZVgyb2Z1MjNXZlFaYjlzdGhlRHJiaXE0L2tkWEVUeEMzWGpY?=
 =?utf-8?B?V1FQV0g3Z2xqalY3VzU0N3Q4Tjd5aitFVS9GU0lGeWtCVFdEWThKU3pTUUF2?=
 =?utf-8?Q?cPYfQedkevbVUmauQx8RLaA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB6806.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bk9PR05PaWJlRG1zVjJuVUhxTXJEYVFXL0ExdXVmVUdyTDdtajVFYXIzTjZh?=
 =?utf-8?B?SHNYVjh4RHM5MGhRNm5uQ3A0Y3llQmZUalF6WWtYbHN0M0ppVU9ZNmhONmRY?=
 =?utf-8?B?SDZCSEhFWFRXOE92R0dKaHJ4OFBhdUlkT3NEYjByS0pvb3p0YmNGTDlZNm1C?=
 =?utf-8?B?cDdpT0FoWk9EakRSaGExaTdRUmt1ZmJIc0Q2RTVucGRJK3ZrSVlCYkpoUXRh?=
 =?utf-8?B?NFpvbEEzaXVhSlhUd0c0Y3NjaThhaWVFZFB3VFBMQXZNTEV2NUhlZmVOY1o3?=
 =?utf-8?B?RThSbzhZYXdodUJ1enZhWnNLSGFoWk1iRmJSZHk5dzFnR1kvQytQUDVQb1l1?=
 =?utf-8?B?cXBqNnkzZmY1ME5ZbzdScUE3OGpCRG5yMElMVjM5dW9OdGlZb1hFUVVIVElM?=
 =?utf-8?B?MlE0Vi9GTmJ1RnFmZzFLRzdaNG43VkN0SDRnWUF3Si8vRWdrNGpza0lBK3Vp?=
 =?utf-8?B?c3BZOW05cVhaU1dFeVZZWnZLaTF6ZUlKUVMyaHNhaDBUcmRGSXhHYlVFSmVx?=
 =?utf-8?B?aDdvdVIyYnBIdWJmTlovRnZOeUxMWDJwbWNycElGSG9VcXpwYTZnV3FmRHRJ?=
 =?utf-8?B?VGIvT3V6UGNyYzQveC9FTWpNNTdXdEduVElZY1pVVkdiSjZFWk9KakFna0lj?=
 =?utf-8?B?ZGo2bkxSQ015SGFvZTVCTENrSS9WRGtVcFY3bWdQaTg2Q1BUY2c3UldsaUl6?=
 =?utf-8?B?ZmdMZExCbHdTRXBTOXNMenRyVnlsNjkwd25uais3UjM4RVUyaUFVVlVpcXhR?=
 =?utf-8?B?V1g1cE83OThlRjhsdlhma3VTR05KdzNQc0dWM0tuZ3ZidlIzVWJCNlk2NzBP?=
 =?utf-8?B?Qzkzd0tuZStmSGxkWGh4R3cvQWh3Q2tCU0doOXR1YWhpMkR3VHhuVkZ6SXRp?=
 =?utf-8?B?aTl2blJoaEdXc0lJNDE4ZkVLU053VnZ5ay9sZzlwL3RGT3dMampMeFMwTGZJ?=
 =?utf-8?B?LzdOVmVSR0tzMkpzM0d0dERhZjBSNVNnczdzM2p3WW9hamN6dkRiZkhia0Jt?=
 =?utf-8?B?NGtCNEF2M1E2aTBHcFpKQnlaYUhPSU9jVlZRZVh0VEFxT2d1aWhUZ3k5K2Zx?=
 =?utf-8?B?TmI1ZGRaU3J6SEt6WkV6Z0w3dFlwallub2dmb2dueTJhVDhOb2FFMkRuV3JQ?=
 =?utf-8?B?VkxYMzZQVlNldmFWek0wRitGTnVlMjBhVmVCb0Z6WkEzVEtoRFhpRDJOeVUy?=
 =?utf-8?B?cjRtdVNobGxIUjVWUnZ1dSsrb0cyRk16bkozZUM2NEFBdlNoNnl3ZGM3ZFBx?=
 =?utf-8?B?ZWEyV3cvQ1paTkhRVWlvMlFUNFJjbnpoRHFTcnVCZTZ1U1VzYmF6emNFbk9x?=
 =?utf-8?B?NVIxQzl5V3RZN3F4WXQvTTh2RHY1cEJ0NVpZTy9ubHlWSlZabitBWklXcnFP?=
 =?utf-8?B?eHU1NTh1YnhWZURiT1RESTYwT3RQdXpkVkF0SlJNNC9JaDZTL3ZyZFdPR05I?=
 =?utf-8?B?Q3dNMXBva3VhaVBlMlRiNldvNUlDS09LbWNpanByWlhnL0o5ZXV5VjRROE9r?=
 =?utf-8?B?UVZ2TEMwS3N2TStQei9Ob1BUbDBoRFZZdHlacXNuWm5uQUhvQnlLMWNnRU9t?=
 =?utf-8?B?dVZwSmhYVlk5cnFWMlZtQWhNWUxhYk5ZWFlIbTRXdDd5d3Y2OWluMEc5Q3dn?=
 =?utf-8?B?eE5EU3Vsd1Fac3dUR2tvV2gyVUd3cVpOL0pWSHVOdzhOWDRUYmRNVXBZa1Fj?=
 =?utf-8?B?L2twZXhQTUNUaUc4RkhnUzdlTlFZWEJHeXhrTG9VZ2RVcjM2R3o0ZnBNWStW?=
 =?utf-8?B?Szh0ckVKSGR4NkdySFpnRU41dW9JeHNoczBvY0JXUXZzbGlBeVBIWWVnMG5V?=
 =?utf-8?B?dzg0MkVyK2pIU1lwNnVGbm9HZ1pCU256MElycm1odkV3Z2JtN0ZBZFlyR0Nq?=
 =?utf-8?B?c1BIWnlRWlZKSXQzUWdScUdIeHJ1R3JhbENNRWdyc3gwVm5jdUNEd3lHbXFB?=
 =?utf-8?B?OU9HaFpwNjg5VGx6dCtxM2tFTWxTbjJjdGZpVFZIUlZhNlFtWXJ2Q1ErbjVP?=
 =?utf-8?B?YnJOd2VQRURPUUZySU85dUZ3NWxYVzd0Vmx1Rm40VzFMdUZNRG42bXJzcUNC?=
 =?utf-8?B?cmNzVjljVDZXbHlEeGx3Sit1Y2tHSzJJK04yN0NPMmc5cXVsRlhqODhMK0VQ?=
 =?utf-8?B?bGtNaE1xUDFHSGJLTXAvZ1ExU0dtMW1VZTVYYUZ5eTJXK3phZE9OcnNrSHo2?=
 =?utf-8?B?dHg5K1lHY2FCUzBhNDNtb09Md3M5OW1XTmc3UHRVU3lEQjhKeDdBQU9xWTh0?=
 =?utf-8?B?WEhodTYzQzEvQ0ltT2FPa2hKQmpNMk16aTNYWmVMUFN6czJ4K2s3bWJ2RUhx?=
 =?utf-8?Q?rcrRhra+JYDDL195ED?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: mellanox.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6806.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 432012b3-d156-4300-0e28-08de58192bfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 11:43:46.8519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +JO4HtAt19bY+wJvJCNqINrrPkmZKGQ4kckl7P4DT9h00pDO3MkiheQdJWBBibW74aX8whKZtpi+sAlKZ7OpfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9076
X-Spamd-Result: default: False [2.84 / 15.00];
	DMARC_POLICY_REJECT(2.00)[mellanox.com : No valid SPF, No valid DKIM,reject];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[parav@mellanox.com,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-15761-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,ffff888043434a00:email,ib_gid_table_entry:email,SJ0PR12MB6806.namprd12.prod.outlook.com:mid,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: DC74C4EF61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQo+IEZyb206IFRldHN1byBIYW5kYSA8cGVuZ3Vpbi1rZXJuZWxASS1sb3ZlLlNBS1VSQS5uZS5q
cD4NCj4gU2VudDogMjAgSmFudWFyeSAyMDI2IDAzOjI5IFBNDQo+IA0KPiBIZWxsby4NCj4gDQo+
IHN5emJvdCBmb3VuZCBpbiBsaW51eC1uZXh0LTIwMjYwMTE2IHRoYXQgb25lIG9mIGNhdXNlcyB0
aGF0IGFwcGVhciBhcw0KPiANCj4gICB1bnJlZ2lzdGVyX25ldGRldmljZTogd2FpdGluZyBmb3Ig
Ym9uZDEgdG8gYmVjb21lIGZyZWUuIFVzYWdlIGNvdW50ID0gMg0KPiANCj4gcHJvYmxlbSAoIGh0
dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL2J1Zz9leHRpZD04ODFkNjUyMjljYTRmOWFlOGM4
NCApIGlzIHRoYXQNCj4gYSByZWZjb3VudCBmb3IgInN0cnVjdCBpYl9naWRfdGFibGVfZW50cnki
IGlzIGxlYWtpbmcgYmVjYXVzZSBkZWxfZGVmYXVsdF9naWRzKCkNCj4gaXMgbm90IGNhbGxlZCB1
cG9uIE5FVERFVl9VTlJFR0lTVEVSIGV2ZW50OyBhIGRlYnVnIHByaW50aygpIHBhdGNoIHJldmVh
bGVkIHRoYXQNCj4gb25seSBhZGRfZGVmYXVsdF9naWRzKCkgd2FzIGNhbGxlZC4NCj4gDQo+IFNp
bmNlICJzdHJ1Y3QgaWJfZ2lkX3RhYmxlX2VudHJ5IiB0YWtlcyBhIHJlZmVyZW5jZSB0byAic3Ry
dWN0IG5ldF9kZXZpY2UiIHZpYQ0KPiAic3RydWN0IHJvY2VfZ2lkX25kZXZfc3RvcmFnZSIsIHRo
ZSBjb3JyZXNwb25kaW5nIE5FVERFVl9VTlJFR0lTVEVSIGhhbmRsZXINCj4gbXVzdCByZWxlYXNl
IHRoYXQgcmVmZXJlbmNlLiBTb21ldGhpbmcgd2FzIG92ZXJsb29rZWQgd2hlbiB3cml0aW5nIGNv
bW1pdA0KPiA5NDNiZDk4NGIxMDggKCJSRE1BL2NvcmU6IEFsbG93IGRldGFjaGluZyBnaWQgYXR0
cmlidXRlIG5ldGRldmljZSBmb3IgUm9DRSIpID8NCj4gDQpJdCBpcyB1bmxpa2VseSB0aGlzIGNv
bW1pdC4NCk15IHN1c3BlY3QgaXMgdGhlIGJ1ZyB0aGF0IHlvdSByZXBvcnRlZCBpbiBbMV0gaXMg
dGhlIGNhdXNlLCBpLmUuIHRoZSBpYiBkZXZpY2UgUkVHSVNURVJFRCBhbmQgbmV0ZGV2IGV2ZW50
IHJhY2luZy4NCkhvd2V2ZXIsIGZsdXNoaW5nIHRoZSB3cSBkb2VzIG5vdCBzZWVtIHRoZSByb2J1
c3Qgc29sdXRpb24gZWl0aGVyIGJlY2F1c2UgcmlnaHQgYWZ0ZXIgZmx1c2hpbmcgdGhlIG5ldGRl
diB1bnJlZ2lzdGVyIGV2ZW50IG1heSBhcnJpdmUuDQoNCkkgaGF2ZW7igJl0IHRob3VnaHQgdGhy
b3VnaCBmdWxseSBvciBhbmFseXNlIHRoZSBjb2RlIHJlY2VudGx5LCANCmdpZF90YWJsZV9jbGVh
bnVwX29uZSgpIHNob3VsZCBjbGVhbnVwIGFuZCByZWxlYXNlIHRoZSByZWZlcmVuY2UgYW55d2F5
Lg0KSWYgdGhhdCBpcyBkb25lIGNvcnJlY3RseSwgdGhlIHJlZmVyZW5jZSBpcyBoZWxkIHNvbWV3
aGVyZSBlbHNlLg0KSXNu4oCZdCBpdD8NCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2Fs
bC8xMGNhZWE1Yi05YWQxLTQ0Y2UtOWVhZi1hMGY0MDIzZjIwMTdASS1sb3ZlLlNBS1VSQS5uZS5q
cC9ULyNtOGZhNTI2MTBiMTAyYzhhZTUzZTY1YTFhZjkyZDQxMDI3NGMwZDU4Mw0KDQo+IA0KPiB1
bnJlZ2lzdGVyX25ldGRldmljZTogd2FpdGluZyBmb3IgYm9uZDEgdG8gYmVjb21lIGZyZWUuIFVz
YWdlIGNvdW50ID0gMg0KPiBDYWxsIHRyYWNlIGZvciBib25kMUBmZmZmODg4MDQzNDM0YTAwICsx
IGF0DQo+ICAgICAgYWxsb2NfZ2lkX2VudHJ5IGRyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NhY2hl
LmM6NDE3IFtpbmxpbmVdDQo+ICAgICAgYWRkX21vZGlmeV9naWQrMHgzMTcvMHhjYzAgZHJpdmVy
cy9pbmZpbmliYW5kL2NvcmUvY2FjaGUuYzo1NTcNCj4gICAgICBfX2liX2NhY2hlX2dpZF9hZGQr
MHgyMzAvMHgzNzAgZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY2FjaGUuYzo2ODgNCj4gICAgICBp
Yl9jYWNoZV9naWRfc2V0X2RlZmF1bHRfZ2lkKzB4NWY5LzB4NzEwIGRyaXZlcnMvaW5maW5pYmFu
ZC9jb3JlL2NhY2hlLmM6OTY3DQo+ICAgICAgYWRkX2RlZmF1bHRfZ2lkcyBkcml2ZXJzL2luZmlu
aWJhbmQvY29yZS9yb2NlX2dpZF9tZ210LmM6NDkyIFtpbmxpbmVdDQo+ICAgICAgZW51bV9hbGxf
Z2lkc19vZl9kZXZfY2IrMHgxN2QvMHgyNzAgZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvcm9jZV9n
aWRfbWdtdC5jOjUxOA0KPiAgICAgIGliX2VudW1fcm9jZV9uZXRkZXYrMHgxYWIvMHgyZTAgZHJp
dmVycy9pbmZpbmliYW5kL2NvcmUvZGV2aWNlLmM6MjQzNA0KPiAgICAgIGdpZF90YWJsZV9zZXR1
cF9vbmUgZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY2FjaGUuYzoxMDQwIFtpbmxpbmVdDQo+ICAg
ICAgaWJfY2FjaGVfc2V0dXBfb25lKzB4NDI4LzB4NWUwIGRyaXZlcnMvaW5maW5pYmFuZC9jb3Jl
L2NhY2hlLmM6MTcxOQ0KPiAgICAgIGliX3JlZ2lzdGVyX2RldmljZSsweGZiZS8weDE0MjAgZHJp
dmVycy9pbmZpbmliYW5kL2NvcmUvZGV2aWNlLmM6MTQ1MA0KPiAgICAgIHJ4ZV9yZWdpc3Rlcl9k
ZXZpY2UrMHgxZTMvMHgzNTAgZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfdmVyYnMuYzox
NTU2DQo+ICAgICAgcnhlX25ldF9hZGQrMHg4MS8weDExMCBkcml2ZXJzL2luZmluaWJhbmQvc3cv
cnhlL3J4ZV9uZXQuYzo2MTgNCj4gICAgICByeGVfbmV3bGluaysweGRkLzB4MTkwIGRyaXZlcnMv
aW5maW5pYmFuZC9zdy9yeGUvcnhlLmM6MjM0DQo+ICAgICAgbmxkZXZfbmV3bGluaysweDRhNS8w
eDVhMCBkcml2ZXJzL2luZmluaWJhbmQvY29yZS9ubGRldi5jOjE3OTcNCj4gICAgICByZG1hX25s
X3Jjdl9tc2cgZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvbmV0bGluay5jOi0xIFtpbmxpbmVdDQo+
ICAgICAgcmRtYV9ubF9yY3Zfc2tiIGRyaXZlcnMvaW5maW5pYmFuZC9jb3JlL25ldGxpbmsuYzoy
MzkgW2lubGluZV0NCj4gICAgICByZG1hX25sX3JjdisweDZhZS8weDk4MCBkcml2ZXJzL2luZmlu
aWJhbmQvY29yZS9uZXRsaW5rLmM6MjU5DQo+ICAgICAgbmV0bGlua191bmljYXN0X2tlcm5lbCBu
ZXQvbmV0bGluay9hZl9uZXRsaW5rLmM6MTMxOCBbaW5saW5lXQ0KPiAgICAgIG5ldGxpbmtfdW5p
Y2FzdCsweDgyZi8weDllMCBuZXQvbmV0bGluay9hZl9uZXRsaW5rLmM6MTM0NA0KPiAgICAgIG5l
dGxpbmtfc2VuZG1zZysweDgwNS8weGIzMCBuZXQvbmV0bGluay9hZl9uZXRsaW5rLmM6MTg5NA0K
PiAgICAgIHNvY2tfc2VuZG1zZ19ub3NlYysweDE4Zi8weDFkMCBuZXQvc29ja2V0LmM6NzM3DQo+
IENhbGwgdHJhY2UgZm9yIGJvbmQxQGZmZmY4ODgwNDM0MzRhMDAgKzEgYXQNCj4gICAgICBnZXRf
Z2lkX2VudHJ5IGRyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2NhY2hlLmM6NDQyIFtpbmxpbmVdDQo+
ICAgICAgcmRtYV9nZXRfZ2lkX2F0dHIrMHgyZWUvMHgzZjAgZHJpdmVycy9pbmZpbmliYW5kL2Nv
cmUvY2FjaGUuYzoxMzA3DQo+ICAgICAgc21jX2liX2ZpbGxfbWFjIG5ldC9zbWMvc21jX2liLmM6
MTYwIFtpbmxpbmVdDQo+ICAgICAgc21jX2liX3JlbWVtYmVyX3BvcnRfYXR0ciBuZXQvc21jL3Nt
Y19pYi5jOjM2OSBbaW5saW5lXQ0KPiAgICAgIHNtY19pYl9wb3J0X2V2ZW50X3dvcmsrMHgxOTYv
MHg5NDAgbmV0L3NtYy9zbWNfaWIuYzozODgNCj4gICAgICBwcm9jZXNzX29uZV93b3JrKzB4OTNh
LzB4MTVhMCBrZXJuZWwvd29ya3F1ZXVlLmM6MzI3OQ0KPiBDYWxsIHRyYWNlIGZvciBib25kMUBm
ZmZmODg4MDQzNDM0YTAwIC0xIGF0DQo+ICAgICAgcHV0X2dpZF9lbnRyeSBkcml2ZXJzL2luZmlu
aWJhbmQvY29yZS9jYWNoZS5jOjQ0OCBbaW5saW5lXQ0KPiAgICAgIHJkbWFfcHV0X2dpZF9hdHRy
KzB4N2MvMHgxMzAgZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY2FjaGUuYzoxMzg4DQo+ICAgICAg
c21jX2liX2ZpbGxfbWFjIG5ldC9zbWMvc21jX2liLmM6MTY1IFtpbmxpbmVdDQo+ICAgICAgc21j
X2liX3JlbWVtYmVyX3BvcnRfYXR0ciBuZXQvc21jL3NtY19pYi5jOjM2OSBbaW5saW5lXQ0KPiAg
ICAgIHNtY19pYl9wb3J0X2V2ZW50X3dvcmsrMHgxZDQvMHg5NDAgbmV0L3NtYy9zbWNfaWIuYzoz
ODgNCj4gICAgICBwcm9jZXNzX29uZV93b3JrKzB4OTNhLzB4MTVhMCBrZXJuZWwvd29ya3F1ZXVl
LmM6MzI3OQ0KPiBDYWxsIHRyYWNlIGZvciBib25kMUBmZmZmODg4MDQzNDM0YTAwICsxICFORVRS
RUdfUkVHSVNURVJFRCBhdA0KPiAgICAgIGdldF9naWRfZW50cnkgZHJpdmVycy9pbmZpbmliYW5k
L2NvcmUvY2FjaGUuYzo0NDIgW2lubGluZV0NCj4gICAgICByZG1hX2dldF9naWRfYXR0cisweDJl
ZS8weDNmMCBkcml2ZXJzL2luZmluaWJhbmQvY29yZS9jYWNoZS5jOjEzMDcNCj4gICAgICBzbWNf
aWJfZmlsbF9tYWMgbmV0L3NtYy9zbWNfaWIuYzoxNjAgW2lubGluZV0NCj4gICAgICBzbWNfaWJf
cmVtZW1iZXJfcG9ydF9hdHRyIG5ldC9zbWMvc21jX2liLmM6MzY5IFtpbmxpbmVdDQo+ICAgICAg
c21jX2liX3BvcnRfZXZlbnRfd29yaysweDE5Ni8weDk0MCBuZXQvc21jL3NtY19pYi5jOjM4OA0K
PiAgICAgIHByb2Nlc3Nfb25lX3dvcmsrMHg5M2EvMHgxNWEwIGtlcm5lbC93b3JrcXVldWUuYzoz
Mjc5DQo+IENhbGwgdHJhY2UgZm9yIGJvbmQxQGZmZmY4ODgwNDM0MzRhMDAgLTEgIU5FVFJFR19S
RUdJU1RFUkVEIGF0DQo+ICAgICAgcHV0X2dpZF9lbnRyeSBkcml2ZXJzL2luZmluaWJhbmQvY29y
ZS9jYWNoZS5jOjQ0OCBbaW5saW5lXQ0KPiAgICAgIHJkbWFfcHV0X2dpZF9hdHRyKzB4N2MvMHgx
MzAgZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvY2FjaGUuYzoxMzg4DQo+ICAgICAgc21jX2liX2Zp
bGxfbWFjIG5ldC9zbWMvc21jX2liLmM6MTY1IFtpbmxpbmVdDQo+ICAgICAgc21jX2liX3JlbWVt
YmVyX3BvcnRfYXR0ciBuZXQvc21jL3NtY19pYi5jOjM2OSBbaW5saW5lXQ0KPiAgICAgIHNtY19p
Yl9wb3J0X2V2ZW50X3dvcmsrMHgxZDQvMHg5NDAgbmV0L3NtYy9zbWNfaWIuYzozODgNCj4gICAg
ICBwcm9jZXNzX29uZV93b3JrKzB4OTNhLzB4MTVhMCBrZXJuZWwvd29ya3F1ZXVlLmM6MzI3OQ0K
PiBpbmZpbmliYW5kOiBiYWxhbmNlIGZvciBib25kMUBpYl9naWRfdGFibGVfZW50cnkgaXMgMQ0K

