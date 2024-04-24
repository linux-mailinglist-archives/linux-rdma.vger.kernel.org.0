Return-Path: <linux-rdma+bounces-2048-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EA78B052A
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Apr 2024 10:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB0A9B213F9
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Apr 2024 08:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F193158A1B;
	Wed, 24 Apr 2024 08:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="C8EegcFy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2103.outbound.protection.outlook.com [40.107.20.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED5115886E;
	Wed, 24 Apr 2024 08:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713949097; cv=fail; b=H2y/YPFZMejS3QW70TtXyjNK9Dp4v2cTl5GQ3/voawfDI/GKXNv3jE6xRLnXP5txisb8HnNOJpR3u2gxwM+0l48wAIdA1sMiG6Mbe2eq06aIJDJXsMecITK/Qw0RtEiSo2rBPsvP9GG8ZUxgZZFLuTUamEJIjjHz6vXTT86S2s4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713949097; c=relaxed/simple;
	bh=u6RFXVrJvnSyDFACmMrf8DJTObtPr9GdwPfCzkEjGhw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P5cP5sixWfaBMOQUcIRzMAAW2BxC0CjE8bVXdTqpoF0Pdt11NuiMJ1Vd6XVQypVtEmkoiSlGZT1raqXYhL+SNNDMbw37SzNII/GpCbM4tjN2Gxa8CfaULlG5Qikdq3kGRrdA2Kdn/fzVv4a7Bj3qU48TKliZKGIhYD1BkWHiU2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=C8EegcFy; arc=fail smtp.client-ip=40.107.20.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tze31cYCLjVWZpDCHX1LYYYOBLPH5emiFLh8DpG2OM6iC9ENwbsKvYgr2JDxtAbmLM7fsVDY8iTA3nKR9/VYNJxOK1UF4rE3bdfy3MnHWOVsydiTmdvwF9fVtszCEc0dPBVK3/UpRvlVaXO803eYBeR5A7JQOpkKwxmWPddyUvV4HODYEP/V4f5WPC++BOVmXNWbzHZmGioK3kcKuJh83Efok2ICG+W/BLBGP/oSFhiUwNfTwzdnsX3bGT0+QzsQWFPurKvJ7EgOhVvxVk8ggOlCvxTx3ThRvmWNafJNxQbBqMYmZrD7Fu/4YBNHGptV+CGOn1KItWQz0ZHHnnYPGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6RFXVrJvnSyDFACmMrf8DJTObtPr9GdwPfCzkEjGhw=;
 b=aDBU9unHCyRnLADBQE8mTay1LYEUiFRmLIxd9pE6BUs5iyFHBm9ZKS3A9Eo8tGVE4A/vYcYRQhMGKKS9eB/4kgalVs1VxteaikwPOkZt9Zae5sRwoO1CFqSnj8hIULl58WBFXml1DNwaSIBcc79Qb4SWI+utDf9yvFqbpJlS1PAi75Rd6UUlkDw7yCtUVE8qhq7xD48ChZYoQGFLuUnIHiDla90gPL4uiqz7tZ4c0/vZmzM/7TVQj1FOtHfeObPYsNfbFCFeQTxwT4tHMkyXVO6j2nSHy0gzUnZa2ZZRt8S7MYEpYvd5l9BzYMTENAcO3kxEcWNGoMYVIC6+mTN90A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6RFXVrJvnSyDFACmMrf8DJTObtPr9GdwPfCzkEjGhw=;
 b=C8EegcFyTeCkq9r3qrlybFd7wnyEkb2on0GD94gkhwW1mAShVFL9+Oi0CzC/winQZAg4I2IpzfvbVA2KaPstQwc0ePTt8rw1vLGsgJzsFII3maWqPgM1856FBYquIc9/b7Jj3VPV2Rsgr5YkUTagYzZRNvXqWPcsyakb2UUwgvo=
Received: from PAXPR83MB0557.EURPRD83.prod.outlook.com (2603:10a6:102:244::16)
 by DB9PR83MB0538.EURPRD83.prod.outlook.com (2603:10a6:10:301::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.8; Wed, 24 Apr
 2024 08:58:12 +0000
Received: from PAXPR83MB0557.EURPRD83.prod.outlook.com
 ([fe80::7c93:6a01:4c9f:2572]) by PAXPR83MB0557.EURPRD83.prod.outlook.com
 ([fe80::7c93:6a01:4c9f:2572%6]) with mapi id 15.20.7544.008; Wed, 24 Apr 2024
 08:58:11 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Long Li <longli@microsoft.com>, Konstantin Taranov
	<kotaranov@linux.microsoft.com>, "sharmaajay@microsoft.com"
	<sharmaajay@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org"
	<leon@kernel.org>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rdma-next 5/6] RDMA/mana_ib: boundary check before
 installing cq callbacks
Thread-Topic: [PATCH rdma-next 5/6] RDMA/mana_ib: boundary check before
 installing cq callbacks
Thread-Index: AQHakbDGTTW8qgc8KE2B/N1PdH1HM7F2jTYAgACYTBA=
Date: Wed, 24 Apr 2024 08:58:11 +0000
Message-ID:
 <PAXPR83MB05574C4D167035E676A9FA58B4102@PAXPR83MB0557.EURPRD83.prod.outlook.com>
References: <1713459125-14914-1-git-send-email-kotaranov@linux.microsoft.com>
 <1713459125-14914-6-git-send-email-kotaranov@linux.microsoft.com>
 <SJ1PR21MB345784B523805F2D590ADA4FCE112@SJ1PR21MB3457.namprd21.prod.outlook.com>
In-Reply-To:
 <SJ1PR21MB345784B523805F2D590ADA4FCE112@SJ1PR21MB3457.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=de8358dc-ddbf-416f-bc64-6472291d49fa;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-04-23T23:44:23Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR83MB0557:EE_|DB9PR83MB0538:EE_
x-ms-office365-filtering-correlation-id: 77dd6d87-505b-4a1f-b349-08dc643cab8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?TjhQMVZ6L2xPaEpoeDE1Um9MUnl2ZjF3bnhsVmx5djdMT2VGVHppblBmNW5Z?=
 =?utf-8?B?bEVhYjA4Sy9ITG1zcFM4Rmk3blkveEVPVFlHYlBUbWxac1RrTWZ3UHM1amw1?=
 =?utf-8?B?aTgvczZhS2hZWm45SmhNc0wyaCsxTnpXRDg1Z3lDQ000bE8rQmIweXB5bXpZ?=
 =?utf-8?B?Y0Q0Q3p0WFM0NVQ0aGIyRklTdWJnT1dTbWovdzhTazR1djljdGh2eDJzK3hq?=
 =?utf-8?B?bzRINUo5dGxRR3J5Q2pTZzdXYlY2MkdqYllFMVBDbEhHU1o2T3ZzR0prOWY5?=
 =?utf-8?B?Vkh6OWpEcUpWZFllUzZKNDFaamtXeUwvQ0I0NUpvS1BQTk1ueXM3clJWQXpK?=
 =?utf-8?B?empXRVQwMVl5Z0kxVWs1RkVZMCtqbExTbUhyVjBJU1h0YmdxZU9YMk5yMjNw?=
 =?utf-8?B?QTVLVWtXTDZteUxMN3pLNXJXTDlYWXlBQUJUQUhBYzNudm1PWTM4SGY5V3lN?=
 =?utf-8?B?N2RTSzJBTWxkcWhzRDhQdkhydzhxNnAwVUo4MEF0N01SdmtOd2QzL1lHd1Zz?=
 =?utf-8?B?c1AwUk1nbWpSYmI2TjUrTEFMMUorQWd1V21RVEplTmVUNlI3Ykc4dThjeklh?=
 =?utf-8?B?OFpoMzlWMlQwNjdkZ0tNcm01c3NNcHUvSmRzUkpMUElNcnVrOTRCQUNnWFk5?=
 =?utf-8?B?UTJ4WGhWVlh2THFZUCtLRHpOL2JFQ2owVENuR3BUYXFha0RCY2lYTUtJR0ti?=
 =?utf-8?B?RVQyZ05vNFhFVXBPdUN5Y2l2YWtCVzZLZzAxSUJ2R1Z6YmExTkF6YiswMmtz?=
 =?utf-8?B?MXFqenQ5SHQxTENVRDV6SFdpKzEzM3o0NU15OVJDcGlzT3oycVJ2Q3Jadzhr?=
 =?utf-8?B?eXl5QW5oSTFjWit1THVmc1VXVzRXbUh0SVFPQ3ZiQUMvTUo4Y0hEZVFESjZ6?=
 =?utf-8?B?M3ZIU3lTNXJpZHcwR1BaK1E1Y012Wkx4NXdBVldrdUlnYkFwSS9LaUxRbHpm?=
 =?utf-8?B?ZkdzdHFHTFZWTkYzVERJc1hjQ3JGMnRoWXUyWEdxYS9OWmpNeWRqNmd2Y2VV?=
 =?utf-8?B?elZvY0x3SHUwUHJVdnc3SVJiTWVpWVhGemxZVWxlMG1DNllTdUNGNTlkTzdz?=
 =?utf-8?B?dkdHR215TEl1elFVSFU4NUJlSUJrMHMva3pqV05XMjBBYlRHVU9lTnZIY0h3?=
 =?utf-8?B?T3lpMjFxQ0lseWtKZWxpZFZqeFVLa2tXT0I1MytPLzVIMkZpSXRMRjNOQ1ZP?=
 =?utf-8?B?SXpGNHRCejlpbnpoeDBIcTVMTHF4c0h4NEFqZVhJNTVPR0EwQ3BTREQzeVlO?=
 =?utf-8?B?K0FhY2ZYY2d0WEN1SXVBMXI1L3JvMmhnTUZ3SE00bjEwTFJBRnI5aVEvNzhN?=
 =?utf-8?B?NmM3cmdIV0xjRXhrL2V6akpYcVVJV3Q3UzB2bjBOd1o5THExcHIySi81dWZx?=
 =?utf-8?B?allDRlRCTXdlNjltNDc4OVlFUk1rUjgxeFMrSWdVTDBXQzlDWklCMmZNVU5X?=
 =?utf-8?B?OGZYRHk3K204bm5CN2l6UnBmZ3Q0bzAvQlZoUFlibmxDZVVVVWNXa0VuSHpZ?=
 =?utf-8?B?N1M5ZVZsZVFzeTIxc0xDYis1M2doN251RjVKaVFJRDk0bHpoOFJuVkhiRjJG?=
 =?utf-8?B?c0Z6ekJNUGpMdHErZGxpRnpGQ255YUVBTnlZcHRCTmVhMklXYVdmZHkvU3Yv?=
 =?utf-8?B?MEJJeHZsK1l3YWs0S1puSjkxMThuRXdlMGl4ZFdIaGFyVDkzUFR1RzROYlBI?=
 =?utf-8?B?OUc3bmcraEhGTkV5VWZWOHpmZytOVjFFV01JTWM2UmVsREpQdGhDdE90aDdK?=
 =?utf-8?B?VjVQUU5rY0dRMzY2MWRqdHdKYUloU3FhQzZHWlJMKzc0OWE0UU5vUnkraVFR?=
 =?utf-8?B?dXhCUUJ4bEVFdDlxc2xaZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR83MB0557.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MkorTHgwb0ltWEJqREU4MkROMDJVbHV5Q2QrRnoyVmhnVFZ0bENhRk1kOWpx?=
 =?utf-8?B?NFJINkxtc1BvdUo3NjV4TkhENmZzZGpSK0t3aGZ4WUxDRTVsWWxJSzQ3V1U5?=
 =?utf-8?B?NmoxQWdHNko4ZjNvRzEvNVhIR2hOdWdNYk9hcUJveTRUOXRKWXRlU3dBTUVY?=
 =?utf-8?B?Rkhma3NBd1hDR3NaVWZ3blhaTkpOcUJ5RStVcC9UbmlPUk41MjAvSGw1aGt3?=
 =?utf-8?B?OUZrMStEeUw3WGVYeldpSkhUT2ZvVEpBcEZlczkydE9jOUlnbGl2ZXIvY3pF?=
 =?utf-8?B?SmY3QzRqSlNQanhnVkR2QjBtRDZRNjdNN3I2bjM3UisxL1RFNmNqZTZqMlFH?=
 =?utf-8?B?RkJnVlFDcU5hK1VzUU81U2wzOVFhRkFSNitTVEhmbGtXWUpTbmxGZUg3ejBr?=
 =?utf-8?B?c05uWUlrd3NadVI2RGhsQUdmMThEMVYvZTV6MTljVzR2QjBwUHF3TDNKTTNV?=
 =?utf-8?B?a1lSeHFjS0xkaS9EeVlrQUJiR3M1MjM0bTVpZk01cjhIQkZxRzdvN1lpUWtL?=
 =?utf-8?B?Vm1yNE00U2tBcjIrcjNEQUwxSC93Z2pDOG9mY2ZxRmdCY1ZIWUd4RWlHdFdy?=
 =?utf-8?B?Mjd0N2JaMDVCelc4b3FhQkErME9mOUR2VVpUZWlGeDRDUVBJV1hGTnlTWjdT?=
 =?utf-8?B?d2FlS0hjeG9yTElQQks3bFE0Rk1qTXFaSWNHZW9ncGdQbjZzekhzek9vQTNL?=
 =?utf-8?B?S0d6UTREdFRwTlRlai9FcmNKN0pKRFlUdWk4TUhBMGx5UTlIbDZuOEpYeWVM?=
 =?utf-8?B?bVVrRHV0OElMVTdYR2VCWWgyV1FSRmlSSW5qeSt0MnVTUzZNZEszMmtzU2RV?=
 =?utf-8?B?WHNUTm9jMGpJdG9UcERrb0daemhGQ21NZC9Ic1FuMkFqTkZoMk92MytMMlJU?=
 =?utf-8?B?Rk5RcEwzSGdUa3F1bVhyTVN6RUgzSTJSQ29VdEhjVTFQVFVUcWVZQlZXZ2dz?=
 =?utf-8?B?MDkyeGhpaEJ6Nnl6MmowUXlDaTl0WG5yUzJzUTg3VGxoaFVhU0FOTVZZZEdn?=
 =?utf-8?B?aFczSk5iaFdQNXJzSlZvUmNCWXpVZzZnNkJXUEFNajZONVRGT1ZWaXhzWm1I?=
 =?utf-8?B?dStaVUdFSTVuZEt5MHNaRGZOOVdkbHhrUm42S0NpL0tlcHdGOHYzemJjTGR6?=
 =?utf-8?B?eEFFSzYvZ1MzTmhEUExQWUV2cWFtOXN3bmxiQ0dDZzZkaDF5a0xrZkRBY05N?=
 =?utf-8?B?NnBiZFI5N1VTK2V4L2RiRWVoTDRjWndvNGVIcUkvVEtid01RQWxob3kyejl4?=
 =?utf-8?B?RW5nY09uOUhFcTQ4aWZYZXVwZTQ2RWtFUVB2K3gxaW9aMDRuRERpQzVoekdU?=
 =?utf-8?B?QkRTaU1pMCt4WWRmMnFHTk5hZkJ1Sjg2bmJSRWZJMzZ5TkcxUlhJS3kxSHFB?=
 =?utf-8?B?SGVxcFIwK254Q25sUzk5OVBNNDZqK3NqaDBHaW55a0NKRE8yY0tNZm54U01S?=
 =?utf-8?B?WmMrelptQXJrZGFnNkdZYlZwdlc4dm8ydzY5REtpREIxMUhpSU53WFU3T1M5?=
 =?utf-8?B?ajA0Ykh1RFZ2ZWxFOTQydis4OHdpSUd4ZXY4UVpQdVk5Sm9GUlFENmZmc2Zo?=
 =?utf-8?B?dkFYSmR2WnRwTmIvR3d6ODF4RkFtdmdnTDNYSUFTQkR6L2k0S2tQMm1uTG55?=
 =?utf-8?B?ZXpvUmU3N1NaQmF3bkh3WmUzN1dvb0c5Y1N6WUlEeVJXMW53Zkluc3JveVpq?=
 =?utf-8?B?VXFCSjc0Y2hPTGYzM3FFQXBBRG4zcTZINzdNL25raHJIT1A1WGhmbWVBSlRH?=
 =?utf-8?B?Uk5xRzR0cGxMZENTZmRKaWJkWjR0UGIrdWxCbkRaNHVLYnNJS3N6eml6Q0xJ?=
 =?utf-8?B?Tk1pOVg2UERMOUc4Q25nNHRadVVIMzRIL0hhWlN3dEdLK3A2OGJpNWxDcEtB?=
 =?utf-8?B?Z015eXo4eXBnZVVYUVNYSFFmVkp0WGJHdGJRMS9NYlFCSnFGakNsMmdxc1VJ?=
 =?utf-8?B?a1hBWHRacHY1eWlFbVpzb3M2QlpuWjhMR1k2M1NJSmMwUzBXcHBsWkpXbEV6?=
 =?utf-8?B?VWtCQ1hGaDVZSldMZzZKZi9SQ0diT0dVTUg4b05rNVp0VXVQZWJlYnpIQ21E?=
 =?utf-8?Q?vSIkio?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR83MB0557.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77dd6d87-505b-4a1f-b349-08dc643cab8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 08:58:11.8369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RvG61F/iXdypBQJKIBQN0fGgbcVumazIg40XHGMBa20dkM/p6ki1f5fHS9fV6KvIZD8LHnqoPFig9Wf6i/i/MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR83MB0538

PiA+IEFkZCBhIGJvdW5kYXJ5IGNoZWNrIGluc2lkZSBtYW5hX2liX2luc3RhbGxfY3FfY2IgdG8g
cHJldmVudCBpbmRleA0KPiA+IG92ZXJmbG93Lg0KPiANCj4gSG93IGlzIHRoaXMgY29uZGl0aW9u
IHBvc3NpYmxlIHRoYXQgd2UgYXJlIGdldHRpbmcgYW4gb3V0IG9mIGJvdW5kIHF1ZXVlIGlkDQo+
IGZyb20gU09DPw0KPiANCg0KWWVzLCBpdCBzaG91bGQgbm90IGhhcHBlbiBhcyB0aGUgSFcgc2F5
cyB0aGUgdXBwZXIgbGltaXQgb24gQ1FfSUQsDQpidXQgSSB0aGluayBpdCBpcyBzYWZlciB0byBo
YXZlIGl0IHRvIGRvZGdlIGJ1Z3MvZmF1bHR5IEhXLg0KQmV0dGVyIHNhZmUgdGhhbiBzb3JyeS4N
CllvdSBjYW4gc2VlIHRoZSBzYW1lIGNoZWNrIGFsbCBvdmVyIHRoZSBtYW5hLmtvIG1vZHVsZS4N
Cg0KDQo+ID4NCj4gPiBGaXhlczogMmEzMWM1YTdlMGQ4ICgiUkRNQS9tYW5hX2liOiBJbnRyb2R1
Y2UgbWFuYV9pYl9pbnN0YWxsX2NxX2NiDQo+ID4gaGVscGVyIGZ1bmN0aW9uIikNCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBLb25zdGFudGluIFRhcmFub3YgPGtvdGFyYW5vdkBtaWNyb3NvZnQuY29tPg0K
PiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2luZmluaWJhbmQvaHcvbWFuYS9jcS5jIHwgMiArKw0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9pbmZpbmliYW5kL2h3L21hbmEvY3EuYw0KPiA+IGIvZHJpdmVycy9pbmZpbmliYW5k
L2h3L21hbmEvY3EuYyBpbmRleCA2YzNiYjhjLi44MzIzMDg1IDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvaW5maW5pYmFuZC9ody9tYW5hL2NxLmMNCj4gPiArKysgYi9kcml2ZXJzL2luZmluaWJh
bmQvaHcvbWFuYS9jcS5jDQo+ID4gQEAgLTcwLDYgKzcwLDggQEAgaW50IG1hbmFfaWJfaW5zdGFs
bF9jcV9jYihzdHJ1Y3QgbWFuYV9pYl9kZXYNCj4gKm1kZXYsDQo+ID4gc3RydWN0IG1hbmFfaWJf
Y3EgKmNxKQ0KPiA+ICAJc3RydWN0IGdkbWFfY29udGV4dCAqZ2MgPSBtZGV2X3RvX2djKG1kZXYp
Ow0KPiA+ICAJc3RydWN0IGdkbWFfcXVldWUgKmdkbWFfY3E7DQo+ID4NCj4gPiArCWlmIChjcS0+
cXVldWUuaWQgPj0gZ2MtPm1heF9udW1fY3FzKQ0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+
ICAJLyogQ3JlYXRlIENRIHRhYmxlIGVudHJ5ICovDQo+ID4gIAlXQVJOX09OKGdjLT5jcV90YWJs
ZVtjcS0+cXVldWUuaWRdKTsNCj4gPiAgCWdkbWFfY3EgPSBremFsbG9jKHNpemVvZigqZ2RtYV9j
cSksIEdGUF9LRVJORUwpOw0KPiA+IC0tDQo+ID4gMi40My4wDQoNCg==

