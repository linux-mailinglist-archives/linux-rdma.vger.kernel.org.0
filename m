Return-Path: <linux-rdma+bounces-15513-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4470D19906
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 15:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58C5230402C0
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 14:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A054829E117;
	Tue, 13 Jan 2026 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BXLZVFT0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021126.outbound.protection.outlook.com [40.107.130.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BE126F2A0;
	Tue, 13 Jan 2026 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768315252; cv=fail; b=mmaXToQMN50GgMU4eGbgHZTqk25sqq5x1KnaVYNTGkrpaccZNDXUDVeWVgdLGWrAVtPm9+GfG2AkmT9s0P4fjyGOu7aIAgo7hDwBFLk5u9nd32fEybIjJD85drVYX1zJVg+b1kKFodXCI9M4MKRVrpTHJrQNE89mBWT1kwMs9B0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768315252; c=relaxed/simple;
	bh=tvnwdPh3cNI68uGooL0Q5ZqFUejavhFtvm8ro089J8U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dFZsEdTdPRPNZlu9ute5nqK+2P5FP8xPq0NplGyPE3C9h7jMJLQLsGDY6VJ9PDqFHdRe9BlgTIPkGg6TdnCNb4hWKxZz0avtaN1AZ8bOSFXEGZOy3AwvgtnN5au/q4AMwsEVx5IqOXyHVVO5tXzYZS8uPWQ+AO4/goJcxQVhEk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=BXLZVFT0; arc=fail smtp.client-ip=40.107.130.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vf6zh2qsD7V+IYwMbP2rLjEoxXCQzlX/CGRUv7stlaHcZj1+tHZOhx5hG2WCwK5HmftuPY16v2IuVdV0X8pfjPwABHrFrxEG/YGhC+ieuXgE1muA1fWH7S2mYmu7ZKwUmO6J+eDKj7CbMbriNrvuZh/mfs17bb3rWX6TvsQH4fr3Om/WrfT7RiNUVEKLrxM0Ji/Lr9YDNRoCr3oLfOlpIzqDG7aUev91N5N6ggpO5Yf8O68Qj40+8R1c5hFNb0tdA9seOQlOXy2CqdizhY3h5pUTVrHnGjD6Vdhw9ZJl8LcQQbHCdMv2kmAtND8EDzMf3b825pnLKifk4Yx2QFri7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvnwdPh3cNI68uGooL0Q5ZqFUejavhFtvm8ro089J8U=;
 b=OTvvMgEKF0gDMr+h0PkCkAz/HZUMth3PJdPFlvNWIUtbT5tW+BAV+sosqlYJSasFNWWRodRfE8eUpD4c+a97LfMetdEEDKZqliy0x3ANnTOKOlMOq2FshLjNrTL3qjkqy00Oyl1Jot5/Dq4S5fFpE5PZM1yQgIj07VOgulx0HDM56j8+XY9BH1Z8DJi7ObeczmQM2hbsoRBZupLd+XTg2nacnV0zdvTnpR3ypjSM/TyQAKZAlXXeYwDy1omCHjucJxnFf/msLjkyrAnh3TK9io1TrxUFmUG+kXhiNVXkb4FGDiPrzhDVyg5dz7RDiBNFtoZX+HyKHDk/UsxB7NPT1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvnwdPh3cNI68uGooL0Q5ZqFUejavhFtvm8ro089J8U=;
 b=BXLZVFT0JxY8cAbbHYkeDjJLALqyy+9o1lhl2pVVAolAnB02iCCW9Lv39/Ii5toIOcUQWVxLkmOwz8qB6BjyhtnvHE3SjXSQ/MkPFm4L7Vgb1kS53vPQB/SSrUx4/PgLuuVdmjlNYEmo8EpDBlPTLw+DQ+2q7HkKLU/DSXLUxvE=
Received: from DU8PR83MB0975.EURPRD83.prod.outlook.com (2603:10a6:10:5cb::5)
 by AS1PR83MB0514.EURPRD83.prod.outlook.com (2603:10a6:20b:481::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.1; Tue, 13 Jan
 2026 14:40:47 +0000
Received: from DU8PR83MB0975.EURPRD83.prod.outlook.com
 ([fe80::b11f:dc15:ff12:53e]) by DU8PR83MB0975.EURPRD83.prod.outlook.com
 ([fe80::b11f:dc15:ff12:53e%5]) with mapi id 15.20.9542.000; Tue, 13 Jan 2026
 14:40:47 +0000
From: Konstantin Taranov <kotaranov@microsoft.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Konstantin Taranov <kotaranov@linux.microsoft.com>, Shiraz Saleem
	<shirazsaleem@microsoft.com>, Long Li <longli@microsoft.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH rdma-next 1/1] RDMA/mana_ib: take CQ type
 from the device type
Thread-Topic: [EXTERNAL] Re: [PATCH rdma-next 1/1] RDMA/mana_ib: take CQ type
 from the device type
Thread-Index: AQHcgWS7Z+twYZwOwUu7i3llOPQeMrVOLgiAgAHZZ/CAACHEgIAACNRA
Date: Tue, 13 Jan 2026 14:40:47 +0000
Message-ID:
 <DU8PR83MB0975D8FD2468CFFD7E0AE55CB48EA@DU8PR83MB0975.EURPRD83.prod.outlook.com>
References: <1767962250-2118-1-git-send-email-kotaranov@linux.microsoft.com>
 <20260112075233.GB14378@unreal>
 <DU8PR83MB0975AC89F5149C284751B0A4B48EA@DU8PR83MB0975.EURPRD83.prod.outlook.com>
 <20260113140747.GB179508@unreal>
In-Reply-To: <20260113140747.GB179508@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=eccdb22b-b2ca-486f-a3fd-591bee9aa805;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-01-13T14:39:22Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU8PR83MB0975:EE_|AS1PR83MB0514:EE_
x-ms-office365-filtering-correlation-id: 1f2bb83a-9a4e-4df1-29d3-08de52b1bd38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZDRoTHZpZXExYVdoczgzSDlIaHNCeWJOSFNPUG10eUoyTW1iVnBITkZabmVu?=
 =?utf-8?B?a2htWjJzVGFncUh1S3lna3JQOWU0Q2FGelZ1VVZUdVQySCtuTHdIMUtnbyta?=
 =?utf-8?B?M0hUSy9FcnlVTWwzMGJ6V2NXQVo0TkFSWFJ5T0hZM0tSaXdFdUlBYmk4UTJN?=
 =?utf-8?B?SmxCQkEyUGR4N2xPV2MxN0UzS2dGS2psRy9kMndGTGZBYmVkUUk1VTBVdXlq?=
 =?utf-8?B?WGNXdDZlN0lvYVJhWi9nOWpmbXBPWW1lVnlEVlJ0bXZjY0dKRTg2c3FYQy9l?=
 =?utf-8?B?OHU4bWZJcCsyVWtyNm9TYlc0RVFNcHdSUHUvemxuZXVMMThKb3dENENNUXNU?=
 =?utf-8?B?YXVQd08wWnFvWHNzRzhaajdHaFl3bExUY0hqU2k3bDBPQ2JHWUpGNDRzZk9K?=
 =?utf-8?B?WEZkZi9WY0l2bkZxbXdueGZ6bnFKV24zU0gvOWFtRjRmMGdrUmlJOHFYWU5N?=
 =?utf-8?B?cG9UZWtqdG1HSS9CbW56cGhLeVBndHJURUxtVDY2VGFBQml1eGlSa0lidnpq?=
 =?utf-8?B?R29QbEFENktZVkpXc0xGbTFUdVV0Mk9uWFNSemw0ZFZpZnlFL0trTmpLbXc1?=
 =?utf-8?B?SmdveTd4c1krVzBvWnJoZldSMWJxaUg2ZEpYaGhET0o4dnlLQWVmVDh6SGRq?=
 =?utf-8?B?emozVUJVczRsNXl0SmYyd3hlZWtjK0RKSVNMUWdJN1lIVzNYL3F0T2RmWU5L?=
 =?utf-8?B?bjU4QTBMNlNBS2l3WkZNdTBMUEh1TlBYZERtWG5YT25ZUytYUzE4bGhLN2hu?=
 =?utf-8?B?QnVvZ1Z5Zml0eUZMdkRWVkx0WnpicXgvbTlqT3Ara2ppRXppRCt5b1dPWVJt?=
 =?utf-8?B?dENoZWVoMk4veXdCY01KZ2JTRlJUNUFOQU5IM1dNanZ0QUw4TVNoWlFmYXVv?=
 =?utf-8?B?NHZGZkRXRHI0cTZZMG02Sk1JWXFxdmZXVTN5SlE0RkJPR1BhWHE2M3drdWh4?=
 =?utf-8?B?dkdUOUdqV1lYRDU5T20xNlIrak5sc0NWaUgrQ2xQMEJ0cVdJQzNhSzZzRmts?=
 =?utf-8?B?bVdhTmt1bHFKeUNabytsMkQ2UFd1alNMV3pYUlBxbEZoaFErc3ZNNUpRdWty?=
 =?utf-8?B?cjlVYTZkK1hDQ1cyR25EYjJnRnBldTJqc2JXYi8wVDJTUXIxdTNwNEFJdHhH?=
 =?utf-8?B?TzgrS3FPNGpsazRJRjlUSks1TkRtYVh1TVErZFE5UkZYUGVUaVJqN2luZUZT?=
 =?utf-8?B?T1kvSEpaeEgyZWJsSHlhUGk3RWFGU3hIQkxGNEZOSGlWLzdldHRpMHgwZVdp?=
 =?utf-8?B?TDJ0b1BJWVI0aVN6VFpFNHJod09vRzRPOU1XWUF2Wm9CTWk1M2NFWXd6eGV3?=
 =?utf-8?B?LzF4MExBY1hlY1R4YktsZEswWlNVNXRRM3E0cE9FZFFiY1A4Q0dKa1pUWHNI?=
 =?utf-8?B?ZWhzN0k3MkNLNHJDZGFaZ0F0UmZzRjdvalBuNW9kbFJ4R25Xanc3REJ3OGVF?=
 =?utf-8?B?NmdSZlAwclNIazJQeGFOTkFPOFhpeVdiZG1pczZLaTMzaENMTnYxbzFKYkt6?=
 =?utf-8?B?NnJsd0Y4cVpyQVFUSDZ1SVk0d2FXcHIvaFVzbVVyQVdoQTlhenN1RFF4Q2RV?=
 =?utf-8?B?VEdNdjNEVGZwekNOQVgvYW04R3dBZmZxS08yUGE0dFcrRzhlNm9wdnNvRUJP?=
 =?utf-8?B?eUp2SkxHMUZiMTUxL3QzMStCbnBUR0tUaWlxbjNRT28ybit0RFRtVUpBNWFE?=
 =?utf-8?B?UXFJY2VHR2FCaTdvT2tpeXNQM1VsZWwxQXFKdmpzeWJVMCs5a2pzemJZQ1N4?=
 =?utf-8?B?dTluQXR3eUlSaER3SFJmaWdqNWN2enNCeDViMmJxNk5JQlZZa2dWTTkvUzZH?=
 =?utf-8?B?ci90NWNnbDVsMVVmVVRnaFV5YlVZK3l2Rk5XTENZaVlnQnR3dW51d2lqSG5r?=
 =?utf-8?B?d0JVTTBkbUcrVTczUEx5S3J6RWJBdFBvTGVvSjF4Z0dYUkg4ZzZ5TElhYVow?=
 =?utf-8?B?N3VnMXJHSUdnSmxMaHprKzgwN2JnVDFCc1h1V1FYczRTTVZsVGNJV3VuSHhN?=
 =?utf-8?B?VGtLMHkwemJoUzJreXpEcEU5cU1waTcrbkN3WDUxREozTXNKMHhXVkIxaDdx?=
 =?utf-8?Q?Ww+a4Y?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU8PR83MB0975.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ME4yQ0NVbmdBbHpGVWt2R012OFE5amRsZGRwS1RJa3FpcnRPai9HZjJOY05h?=
 =?utf-8?B?emdJbE1DM2dNb3lNZTNpTGJ2V2NuWnRwalcvanluQXFwTi9adm1wdXgvbFRo?=
 =?utf-8?B?Qy9Qa3lnb2lxTDJXRkE5TEJVRS96QjdMcHRMQVBCQjFrQnY1R1BJQzl4WmU0?=
 =?utf-8?B?ZCtpbXFWZnYwMlRyOTV1bkFUZ2Q4Y2pySDUyWUVNcFMxVW8vRlZvV3RXSnNK?=
 =?utf-8?B?ZEN1UDZ2UXV2UnZkUWowS0xDbmxDdXJvRkxuK3Q3M0MrdHhleHhwa0xrVjNn?=
 =?utf-8?B?aVZZMnhjcTRNTnI1cXkzTkNlVHJZNUU4anRXaElXcVF4Kzk0NW5VbmFuTFN4?=
 =?utf-8?B?U1dDRWJmcXFwczNjZHFFclhQOFBQRUhveS9DWVpoL0RLckliRVFIanhNZ0Fh?=
 =?utf-8?B?RDJnZ0dURlJMWHh0M2FNa1RMeHVKbWtDWE9tUmhUbUh1SjN3a1doQzYrMlRL?=
 =?utf-8?B?RDFuc2RiT0RueVF1blZhVjA5VU9EdEMvNjUxODJGMTd3VGhOaUdCVitWWk1O?=
 =?utf-8?B?bFg3ODdnNU9tZEphNER0QjBibUQ3T1F3MXRlNjZEdmFIenNhc0lKVGhSbGN2?=
 =?utf-8?B?V2hZamkxUkZoWTlCTXJNY212K1N5Y1grSWp0VHYzYkI0TC9adXlGajBTZzFB?=
 =?utf-8?B?S2h1NytQNDlzTnI2Z3BWdUJyVDd3RmZKNVdzQlpocVZQWERQVG5yaTFjT3Fq?=
 =?utf-8?B?eXZXRitmVy9zZXUrclM5TWFnM0ZOUzJPa1BXNW9qVngxTnZWbHdDRzFmZlZs?=
 =?utf-8?B?UnRnSFMybVFxSnFnVzFCaWpyRFNYMFFLeHZlNWMwdnJGMCtXU21tUGJnWnF3?=
 =?utf-8?B?L25OQWdMbHFpL3lKTVNRcGV3aG5PcUZQSkp5elVSblBwcUN3Q2xBS0E1eXBm?=
 =?utf-8?B?STNlT1AwT084OEhhUjlzVnYwU3NrTGlEWThyaGtnbVRZZFF0ckZYSnRxcnZ4?=
 =?utf-8?B?ekVnb1k1Y0pGY2FBTU4rWkl4U0s2MVovQVJ5RHBaM2xLWHBQS0J1OVFLV1pY?=
 =?utf-8?B?SklQSS9sLzVZRERCNjZGVDhPWDdwSXhId0swMThhbGpDWFI0OXQ5RlJRRFFW?=
 =?utf-8?B?MStNZUVoUjZWRlk0NEc1bHVSOEtSZC9ocTg3S3JFOXI5MnNsanR3SkJIRzNr?=
 =?utf-8?B?N2ROcWVsTmc3YzE1L1ZOWEJDVytEVEIyTXZlTVVHMHhaVm5tTzlrdkZxb0JM?=
 =?utf-8?B?K2VJcVdIZ1g5UDIwRjhTcS9PYzc1YXpwNFdvdUlxZ1pMbFd3Z2ozL1lBVyt0?=
 =?utf-8?B?RDVIaDBnUE5BRUFwSWJVQ2JkYU51ejNmVHRtUXU2c3EzY09zWDdzZG0xTnRv?=
 =?utf-8?B?TEx3NEhJc3R3QWVRQ29HTndCZjVMUTc3N1Nob1dVZkpTdUwrZ092dS9KQ3lS?=
 =?utf-8?B?UGtZRHdHZFBNQnRxYUgxSHJtQTdZMktnRFY2citaOWRlUjQ4TjEwNkJkcERk?=
 =?utf-8?B?aU5RSU94TGd0SEZwYmI2bE8yNnNMNW4wcUtvd1dHL2gxWXFFZVlBeDQwcTlP?=
 =?utf-8?B?S3JJMHpheFRvNG51TkRESDd1NTNvL3RkOVFxakxzYUJIdFMvTUVmUXBOV0xH?=
 =?utf-8?B?UTJZcEFsZFovUWVPVkc5ZEdkS21KSmQ3U0hQMlFrd1BjZEF2R3RkRERnMlZa?=
 =?utf-8?B?blNiTWlDZzN6WVpCRm5vOW0zbFJvaldOcW9tS3dNQS9BQnk3ZVFJbEVSdVVB?=
 =?utf-8?B?bk9TTEZld09RWkFGWW52V25sellYSnJuM0FWakJoMmVUbkVIN0swVExNTUQy?=
 =?utf-8?B?U01qQVY5aExKMVRFVHhPekdYMmxSb01ib1J1L3duQ050V2p1Y2dxa0FUWUkw?=
 =?utf-8?B?NnViRFVWRG1DL040VjBOeVQxLzQ5blJRSEpYd2J1d2kyMzUyRWZxTnZVcnZn?=
 =?utf-8?B?T0dzVkErRmg2T0pzVElSQVBNRjBxUFpXQkRTTVhBQnpuYVowQWN3MUJjMkdL?=
 =?utf-8?B?ejdCYUhySHZrelhYWkRnVy9jdHc2V0VnZ3ZXR0xHUnJyRTE3ZXZhYjhNYWt5?=
 =?utf-8?B?alVPUllJMFpwNy9YdzlUeWwrNmpyem94QmswSUg0dVljOUtkUDVxcDIyRUhu?=
 =?utf-8?B?TFc5djMrbUtKelAyWDBVQXgxby83N1NoNGZIWXNvNUN3NUpBeElyQTFoZGVW?=
 =?utf-8?B?NzAwWGxNdmFUaGo1U0loMTNrWDRGL3FudTZqelNDOUlqbUd6VDRwMDM2U1Fu?=
 =?utf-8?B?bE4yR2s3WjJmaFlnaUpqSVVhdk9reXhUelRhQWpTT2l1K3F2ckhvdUhXM2FZ?=
 =?utf-8?B?VEhWM3VzY2hmNjZseEd0TkVPOHZBPT0=?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU8PR83MB0975.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f2bb83a-9a4e-4df1-29d3-08de52b1bd38
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2026 14:40:47.0380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rN0dLfm2fR6bYmKXIs3pgMCM9rHSUU/FzSR/YV2gk1HwXNfwZzqDK9ikTvqO8eYHwvNURm5KlF91yR04tjDppw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR83MB0514

PiBPbiBUdWUsIEphbiAxMywgMjAyNiBhdCAxMjoyNzo1N1BNICswMDAwLCBLb25zdGFudGluIFRh
cmFub3Ygd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+IC0JCWlzX3JuaWNfY3EgPSAhISh1Y21kLmZs
YWdzICYgTUFOQV9JQl9DUkVBVEVfUk5JQ19DUSk7DQo+ID4gPg0KPiA+ID4gWW91IG5lZWQgdG8g
YWRkIGNvZGUgd2hpY2ggcHJvaGliaXRzIGZ1dHVyZSB1c2Ugb2YgdGhpcyBCSVQoMCkgaW4NCj4g
PiA+IHVjbWQuZmxhZ3MgZm9yIGJhY2t3YXJkIGNvbXBhdGliaWxpdHkgYW5kIG1heWJlIGRlbGV0
ZQ0KPiA+ID4gTUFOQV9JQl9DUkVBVEVfUk5JQ19DUSBmcm9tIFVBUEkgdG9vLg0KPiA+ID4NCj4g
PiA+IFRoYW5rcw0KPiA+ID4NCj4gPg0KPiA+IEhpIExlb24uIEkgdGhvdWdodCB0aGF0IG15IHBy
b3Bvc2VkIGNoYW5nZSBpcyBiYWNrd2FyZCBhbmQgZm9yd2FyZA0KPiBjb21wYXRpYmxlLg0KPiA+
IElmIEkgYWRkIGNvZGUgdGhhdCBwcm9oaWJpdHMgdGhpcyBmbGFnLCB0aGVuIHRoZSBvbGRlciBy
ZG1hLWNvcmUgd2lsbA0KPiA+IGZhaWwgdG8gY3JlYXRlIENRLCBhcyBpdCBzZXRzIHRoaXMgZmxh
Zy4gQWRkIHJkbWEtY29yZSBzaG91bGQgc2V0IHRoZSBmbGFnIHRvDQo+IHN1cHBvcnQgb2xkZXIg
a2VybmVscy4NCj4gPg0KPiA+IFNvLCB0aGUgY3VycmVudCBzb2x1dGlvbiBpcyBhcyBmb2xsb3dz
Og0KPiA+IHJkbWEtY29yZSBhbHdheXMgc2VuZHMgdGhlIGZsYWcuIFRoZSBrZXJuZWxzIHdpdGhv
dXQgdGhpcyBwYXRjaCBzdGlsbCB1c2UNCj4gdGhpcyBmbGFnLg0KPiA+IE5ld2VyIGtlcm5lbHMg
anVzdCBpZ25vcmUgdGhlIGZsYWcgYW5kIGNyZWF0ZSB0aGUgQ1EgYWNjb3JkaW5nIHRvIHRoZSBj
bGllbnQuDQo+ID4gSXQgaXMgbm90IGZ1bGx5IHBvc3NpYmxlIHRvIHJldGlyZSB0aGlzIGZsYWcg
bm93LCBhcyB3ZSB3YW50IHRvIGJlDQo+ID4gYmFja3dhcmRzIGNvbXBhdGlibGUgYW5kIHN1cHBv
cnQgb2xkZXIga2VybmVscyBhbmQgb2xkZXIgcmRtYS1jb3JlLg0KPiA+IE9yIGRpZCB5b3UgbWVh
biBzb21ldGhpbmcgZWxzZT8gT3IgZG8gSSBtaXNzIHNvbWV0aGluZz8NCj4gDQo+IFRoZXJlIG5l
ZWRzIHRvIGJlIGEgd2F5IHRvIGRvY3VtZW50IGluIHRoZSBjb2RlIHRoYXQgdGhpcyBiaXQgaXMg
cmVzZXJ2ZWQNCj4gYW5kIG11c3Qgbm90IGJlIHVzZWQuDQoNCkdvdCBpdCEgSSB3aWxsIGFkZCBj
b21tZW50cyB0byB0aGUgY29kZSB0aGF0IHRoZSBiaXQgaXMgcmVzZXJ2ZWQgYW5kIHNob3VsZA0K
bm90IGJlIHJldXNlZC4NCg0KVGhhbmtzDQoNCj4gDQo+IFRoYW5rcw0KPiANCj4gPg0KPiA+IFRo
YW5rcw0K

