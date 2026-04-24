Return-Path: <linux-rdma+bounces-19526-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIKEJAwF62m2HQAAu9opvQ
	(envelope-from <linux-rdma+bounces-19526-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2026 07:52:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C04045A13C
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2026 07:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A713930068DD
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2026 05:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D86234752A;
	Fri, 24 Apr 2026 05:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="t2zUYMZQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010072.outbound.protection.outlook.com [52.103.72.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B842346E6D;
	Fri, 24 Apr 2026 05:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777009918; cv=fail; b=jei5vp7ushoRVyu74IfGo4YoMtBjiTvtqn2gexTkwqzP8zOju/0wY9LxhJfg6B3lMH58fwlh7SbMaYIko9ag38jP8dyYIUgbV4s+Bl9ZkE2SeDt1OWWna0XEW1HmibXmIKaKAM3mi01H08coPwkkb7beqLgG21GpnF/cwzo2sZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777009918; c=relaxed/simple;
	bh=bKQ3GR9sagycZ09I7Yf73eJ1pr9W84xgPJyFjaJn+m4=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:MIME-Version; b=IBzVhRbG3Yw58o+taoUnpWxqYHyaKDK1fhpY4jc+sVvGVD9zNpwBtUNH5xS3ElJvB+m37pp8mMvZvSSqU1QhZrUMBvWNBDNZZ/VV9tpbpOWrCND9wMNqv1iW0AjejMEwQO2ANCUeu0FlNWQ7/pI0g/U1d8TvOVuYHnZ2Ijr4djM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=t2zUYMZQ; arc=fail smtp.client-ip=52.103.72.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/mOiCLBsbhcu5b3IpIE0DGgWUQKmEBVdyc1VmQIAwTuMaoIwLYWQ9BpH7z78PDVxzI9/jQewCLR6tIe7/Q5FVFzyWkjXPhXIYAF5zlKmuyxp3B4+8AMnp7DzXI6RHIKTXSFVGOmbi2/5QP0FqwW/IC24cnNvA25EXHyqRJzDX4HZaPz3CaSKXgJtV3LiNRypFw/KKmYADqolTH0ytdZW9avamU8T0/Yu5annbq8KA8Jl77bOrhr8DYgJvj+CEWCeutuULytSMRhQWOJXnVWI+aOa8Wa4VL5VnSPo1/luBBnxjJrOvP59z1PcXRTr1vt1xb2p/O3tOpnPCnCLfKf6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Z8XxvsK5aH+Jqgu/o7zF2/eVpuayHiShNppAzM6Q2c=;
 b=FUs3sLjHbkJNVvKMq3QHiv/SakAzHtZQU4Mp53cgBDSBUr7eQVjGsMxu+zjCEUurfUDm33wvkfcdZo2DIST0lieoJKUv44pq/OPbLfBy3wMwxByWjAqwq3+W04pEUsW1zvhTSLHKzEz+5uQGZfVt3hue4DTNcy4YBmGbqlS7N1dUqeOHZS0HnweRvD8wmLzQZcbJet4B6uXiJGnHjNGZePZgdPQBidBFodYkBTlQw8BSlicbC/bpvitpy7unsPweS5VbqBGWqtm4gxBWwexJ46EfsDF2/BxRygDTinHdpgjL7Ejhf8qoxDH9xmd59bwPii7A6i08kWXCXmjIBQAmbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Z8XxvsK5aH+Jqgu/o7zF2/eVpuayHiShNppAzM6Q2c=;
 b=t2zUYMZQ9+k80nc8FUqemCicFQDzyMx2SyNsZmrtNlovz9/P1Ate7YcfRljMvKoEh3T90hpcL9XTIjjBNo8KtapHXxLLnOU9C9hZzSyZ2fesIAWDb6F1m7xEVvJL1zv+APzDhJu4VYDeyWmlNoPVW5z07jTtJqmvlmlXojLAs5D+rM+i1BMzudJRZx7LlnZmINYGw8HQbDuPBtPPgrgXg4XzD+vrhZ/+RpEX5AKlkc6dpUJ6/LxCKBwL2FReJTyl/C+3tmz6giCAqpokM9CFxCL5whjysmoo9cw8hvpPefXRtDuD8UUatz1bqD7GCjz5BInQKBPtbmyh8Igbdy8uvQ==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by SY6PR01MB7450.ausprd01.prod.outlook.com (2603:10c6:10:162::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 05:51:53 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 05:51:52 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Fri, 24 Apr 2026 13:51:02 +0800
Subject: [PATCH] RDMA/mlx5: Fix error path fall-through in
 mlx5_ib_dev_res_srq_init()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SYBPR01MB7881E1E0970268BD69C0BA75AF2B2@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIAMUE62kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEyMT3bTMitRiXYukpLTUVFMzCzNDcyWg2oKiVLAEUGl0bG0tAMAc/8Z
 XAAAA
X-Change-ID: 20260424-fixes-8bbfee568617
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Jianbo Liu <jianbol@nvidia.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1517;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=bKQ3GR9sagycZ09I7Yf73eJ1pr9W84xgPJyFjaJn+m4=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGzNcsRx8cDl3cvPoOn4pPhf13w2VfjxuujhL+paPw5
 3DZ67zzP151lLIwiHExyIopshwvuPTNwneL7hafLckwc1iZQIYwcHEKwERKmRn+qVk2dK/eXpb1
 8UrZ/as3dj+Qdd/jUx7J7zrvVJ2mB5PEfob/DqbfRa4Y2qX6PGoRuPTk2uaJ6bubpYSel1+eLWk
 S98+fDQBOR062
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: TY4P286CA0055.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36e::14) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20260424-fixes-v1-1-59d71f7a8224@outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|SY6PR01MB7450:EE_
X-MS-Office365-Filtering-Correlation-Id: fadb0b64-ac23-4dd2-c32e-08dea1c59379
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|55001999006|8022599003|24021099003|5072599009|6090799003|461199028|5062599005|22091999003|23021999003|19110799012|15080799012|24121999003|8060799015|41001999006|440099028|3412199025|12091999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUVsRFpMYXZPZ3ErbTR2QjZsd1ZDV3M1U1pTdTlXSHFETVEyK0R3RGRpb29w?=
 =?utf-8?B?QmNqL1dpTHRhTXp2OXo3b0FmN0VURURDVnVBM0hiUEhBQVpnK2dOTnlrbmZn?=
 =?utf-8?B?S3FqSTBsSzhublk4WS9FeENvVjk5dXNvSUU5MDRhNGtvcG40VEd0MW9Tbncy?=
 =?utf-8?B?NmZ0cmhNd2pBZHVJbHZ5aW91RWd2cDk4WGpGUW9kdmZHWmcvSHJERis2Sm9r?=
 =?utf-8?B?UVJkUTZFS0FzVHlSODZsSjBWWUZIeVFqcjc2aGR4RGw0c25zZUlSTmpFMlVE?=
 =?utf-8?B?WFFOdm9NUERpeUc0alhNQzFaNENNdUxBZEgvNHNWOHBPcVFwbWJLa0VIaVd5?=
 =?utf-8?B?b0tZRWtOZVplYWo0NGdGRFl6YTA5M2pzU2dsczdyRnVza2FTZnhXSE90dWMr?=
 =?utf-8?B?N2FuUEpqTm5Dc0VLcUdhRzBvcG1vQi8wN1prcVBXM0xMbjdGa0dERFRNcFZ0?=
 =?utf-8?B?bjNKQzNpckdacW8xY1B1ZWRxUGd6NHZBdmdIUS9HMHp0c0Ruc3lrK00ycmpM?=
 =?utf-8?B?QmlEblFmZ0g5MloyTmZDdXlBZzk2eEI5V0trbG9sWlp0L1lCVHdhQWFORWoy?=
 =?utf-8?B?NVZCZHlSellJMmsyWmNSNUtoKy9MRnJlL1RhaHV4UWdTR0c1T2taMHFMZ2d4?=
 =?utf-8?B?anZ4MkJPLzJnK0pEUkZPWmIxaVM3YjFQWlFhVytkWE1oK2lLeDJDRWk5OHJq?=
 =?utf-8?B?MXZaMnM3RU1mRWhYVVZSWFBzVXgzUEFma01vN3FUcXdiTG5qTTVTWDhoNE5j?=
 =?utf-8?B?eGY4eVNYak5RZXJIck45Sk9YVklRcnJsZEpwVVB6alg5QnhMYmFLUktyNXJE?=
 =?utf-8?B?K0NlYVFJQm13S2dKb01aNnl0ZmhyaW0zaWdjUHlkUVhqMlRHM0o1WEROWFRF?=
 =?utf-8?B?SDE5d0piM3FFRy9xWFJYczRvcmNMMmZoSDY1bTBnVnFFeE9FdmswRDJqcFJE?=
 =?utf-8?B?aGdmZzI4TUVSUGdrWE9Hc0hob0k3UWhRM2Y0K29TanZZQ2lYZk1vWURScFdn?=
 =?utf-8?B?a1h1N0M0L3VldG1GZitZNW1GOG42WFBJYkR1dkZTdW5nRnk0anBSWlllR2c3?=
 =?utf-8?B?T2JLYW9DQnRNREpHYllTVzNxUWFzaG9CWWpkNHRUMFFST0NhbkhsVHFqblF6?=
 =?utf-8?B?YU4zU3I2RHRWeWJab0g2QTdIYjZ1eVBRU1lJZ1RJTG5lRGNnbEtYcll5Qm8w?=
 =?utf-8?B?YjQ4eWxram0zZGx2SzQ0Vm5DY3dLY2tYMEdMRFNmdTlrSURFbzBtWnlmMnh3?=
 =?utf-8?B?a1NvMUV1ZUswWTBuOTIwWE9lZCt4SXFHekJ5VmpaSGhrcndoZ081bWZHd3Zi?=
 =?utf-8?B?Rm1iaTFDYThJZXJFSlVQalVWSHB3VGFoeVJiVTFSTWMyK1FZYVJyRVdXbEU3?=
 =?utf-8?B?NFM1ZlNKVjBFTk1FeVVKUDJ0ZTA3Vjdad0dXQW56T1NhTFhQSWNjVjJZcW1D?=
 =?utf-8?B?bTc3UWVicTNsLzRmYjladXlVNE1SWHUrdU5XdUJVREtZYjRFL3dvcXRRMmJ1?=
 =?utf-8?B?a2tnZXI0RE5XQWwwWnB4V1NPZFBtYzFjelBFdlRRQjZYUDY0NEE0R05KenVt?=
 =?utf-8?B?dVNsZz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGtZd29hMHh1MU1HeWt2TWdNUEsvdml1N2p6alFXb3ViNGgrTGl0Z2djRlAx?=
 =?utf-8?B?QnZ1Nm9WcmpkdUhnZkZyYkhMa3BnblBURHdZdXhTSjYzU0xZWDgyWGJoNDd2?=
 =?utf-8?B?WjlWMzVFbFJkbjlmbGxDUUdJdHNDWXp4VTV2SGZicEdrdC9ETjlqOHJZdVBp?=
 =?utf-8?B?UE12ZndKOSszREZ1YWM2WktyZXZlWmFQM3g3NDI5UzY2QitsVncyaXdJeUZI?=
 =?utf-8?B?UkJZQVRvUVJUdHhZMlV4WS95V3FoUUt2UlRiRWFjdlVwQm1EQWFlb1lwL0NM?=
 =?utf-8?B?RUZkcE5NTXFzMVdQNEdmL0tJQkpZcHJKZ2Y4cEE2YkZCYkREaFloc1M3ajVM?=
 =?utf-8?B?TkY2Y2pYVDJaMGZHSnVKdXlMS1FyZStmUjhpT2JERHdhazFHK2JTU2hheHdJ?=
 =?utf-8?B?eDV4c1JONlB4YWdQQkNDYXA0bFFzd2o5SUtpMHJub0d5YWVhYWpRLzZ4Qnps?=
 =?utf-8?B?d2I5bXRBcklpNW80U2tVak0rRm1QM3kxdk9QdXR3dVM3cGN3Mk9ad21XRDZT?=
 =?utf-8?B?TVh5ZXR6VFZsU0wxMGdWRGNjaVlRMVJFOGRNanpVU2lqbmdsSnNvT2hmQVFJ?=
 =?utf-8?B?RzRsNDkrbUxLVXVKL1Q1RkJXNE9lM0hDL1lid3Raa0kvWmhxOUpzeEU4L3VU?=
 =?utf-8?B?VzkveFh6RlJFLzFta0Z2bnJYTUJFRVk0ZDhNNG1MdzQ1L0xyYXZlaUM2c1d0?=
 =?utf-8?B?UlVCQlNxMmdLQVRqMlY5Y2pBZTg5K2d1UHJBaUNpQTNveGJDQlBWQmJlT1Uv?=
 =?utf-8?B?SHJaZVJ5VlFDNGdjU3hDQi9ySEovakZlWGpkOTgrVWRkT09pWkFBTVFlRWx1?=
 =?utf-8?B?UmloNXY2eVU1TlFlRS91UjFBejNhcW51Q095SlYwRENDNHpLYURIZGtRMzNh?=
 =?utf-8?B?d3JOSDk4VmdISDg5cGQ2L0VWanBvVnNSRUtqcXMwSVdiK045TnNBajZRVFRv?=
 =?utf-8?B?TFU1Q3VlMlpFTVMvS0JrdHN6QkJuNWlsS25YclJPR1kvWk1zSlIwUVJBVVox?=
 =?utf-8?B?VkY4dzdrR2o3UEdzTjUvQjNUcXo2Ulhva3U0ZjBVWFRYR1phS2pJTzlhSmFn?=
 =?utf-8?B?bVcreXdEZ0IrNm1kM0M3WVpHUjdnRzhvNHl0MmpjMW5tT3lhelYyRXFsN2Q3?=
 =?utf-8?B?T0pGamQ2akxCQjJ6V2lkcFdGWUhxN3lZU2dwd3ROZ1ZFSnQwVjlDRUZ3WWZC?=
 =?utf-8?B?T1lHeU1QUDZMaERlMTlxdEJEQWhWcTRSR0lIWGtKQmxRTnhHcUtMSWxkaTFG?=
 =?utf-8?B?QWhBbUswbzV4TEN4aGJCV1FITksreml3VkNiUUUvRE1VZGZxK2pGSlhldERT?=
 =?utf-8?B?S3JSbUxTRVdBSGo5RFc3QSsyRjE5NVhxYlBmM0lvRHhoNUVmYng3MnBkbGFx?=
 =?utf-8?B?NkNBd2lmNzlvdExlcE1vbm5sazEwZVIvckVEbXFpVkx5WnNWRXltKyszQzZq?=
 =?utf-8?B?NW14YVZJdGp1ZERWOHRWdlg1WWRRQXpZWk1mcFhNcE9zTE9McHBWY0dlOWVC?=
 =?utf-8?B?OFpTNWw1Nmxyelc1UThURlV0R1gyRXVKVWNQUVdmRFVleUVrcDdObDVVNHhN?=
 =?utf-8?B?UGg1NTB3NEY4UFpyK1VUekpLQUUzUDFFcElGMWRla1F0TlprM0QwRktkdGRC?=
 =?utf-8?B?b1NteE9saFJMRHhQUWlsRVdtMGxFSitnc1pyMVNvNmZaZ0ZsRmxEZWZ0MC9K?=
 =?utf-8?B?bVpCaVhuaWNIQ0NlWTlWYXdOMUR0TjVyZitycjdQRDBtemlmMm10djM2aDBz?=
 =?utf-8?B?bnNiVFkzV3psYnYxOEZlTjZQRXdxVDlTdCsyekZRVEVrTDNTR2poSVZ6MTIr?=
 =?utf-8?B?dUw0VWVJMWkrZTZZREFEdjZscVFpVHpSd1FuSTNEMlpsYmtMaGdENGNXbFNr?=
 =?utf-8?B?MnNDRW1hak16RFVoK1NweUpIS1FUNmZ6MUhpNUFlaXBmNVE9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fadb0b64-ac23-4dd2-c32e-08dea1c59379
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 05:51:52.4090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY6PR01MB7450
X-Rspamd-Queue-Id: 0C04045A13C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,outlook.com];
	TAGGED_FROM(0.00)[bounces-19526-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[outlook.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,outlook.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,SYBPR01MB7881.ausprd01.prod.outlook.com:mid]

mlx5_ib_dev_res_srq_init() allocates two SRQs, s0 and s1. When
ib_create_srq() fails for s1, the error branch destroys s0 but falls
through and unconditionally assigns the freed s0 and the ERR_PTR s1
to devr->s0 and devr->s1.

This leads to several problems: the lock-free fast path checks
"if (devr->s1) return 0;" and treats the ERR_PTR as already
initialised; users in mlx5_ib_create_qp() dereference the freed SRQ or
ERR_PTR via to_msrq(devr->s0)->msrq.srqn; and mlx5_ib_dev_res_cleanup()
dereferences the ERR_PTR and double-frees s0 on teardown.

Fix by adding the same `goto unlock` in the s1 failure path.

Fixes: 5895e70f2e6e ("IB/mlx5: Allocate resources just before first QP/SRQ is created")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/infiniband/hw/mlx5/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 635002e684a5..356a7c7856e7 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -3380,6 +3380,7 @@ int mlx5_ib_dev_res_srq_init(struct mlx5_ib_dev *dev)
 			    "Couldn't create SRQ 1 for res init, err=%pe\n",
 			    s1);
 		ib_destroy_srq(s0);
+		goto unlock;
 	}
 
 	devr->s0 = s0;

---
base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
change-id: 20260424-fixes-8bbfee568617

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


