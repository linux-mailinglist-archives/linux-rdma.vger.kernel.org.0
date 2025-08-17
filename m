Return-Path: <linux-rdma+bounces-12793-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1389B2924C
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Aug 2025 10:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B5D93AA999
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Aug 2025 08:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274D221CA16;
	Sun, 17 Aug 2025 08:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qD/9cUnF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D60F1E3DF2;
	Sun, 17 Aug 2025 08:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755419819; cv=fail; b=HHBFjGyNnsm1bg3mnas8FQhqlDTK/ynl/1DW8XSoHk2sI/7yuffYLYZ/DXTheFHBYfotDOXAsaBiyi4jrXW5QBAfMwoYqb+jpfMyNO+Dv6RwxQ5XWBkd/OgKpC1T3yiMJBk3HcJZetPMFYjLBmHdbNDgRTsauZPb+DcCwtqZ9J8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755419819; c=relaxed/simple;
	bh=rM+lrep5tiEr7mh9sKAJXp5FlV2vA/Atine4x8lSK8M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nqvFtTur2vKM9hFlInkPRkg30AB3ODfLH5LyEwjBiaXtFzoBPT0aAH82+GK5PisDXJsVIZh4sbawmnfCobveJQxbUWILj+UZWObYzcN+VJ29siE5BTruMlXfa3XhJ2mUxT6TdZZwqG8ofKjsmuIgwXXojbqw0KmMj2eOSBD6O7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qD/9cUnF; arc=fail smtp.client-ip=40.107.243.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sH2zA20j+W07kfTvVdfF4fdcArxdIC/uUI6oROnAL6Jo4yO3hucEaXAf3bWRxB0x1epY36djJ2EebGtf6Ibh4P2UEvFglEyEGiDLZwIbb0polJyDZI8SnNJ6MTKl7muFTosGzTBHg0J6TXUhw9nz/BuOTd2KaMuAoZP1YHfyBz86wRIvSdFFTXwPjYx783BwQUK2/xXvA1BeDeJra5Au328d3axoL3v2ziYkV0croc0gddXHGy+N6+xfr37VV+sk9sy5Eh8HEZLqfmgIlOA9aIvoB39CgyfAuzZ4uO72uLkl+KknxdthC0oLzr1rHiDMP7Y+oVXwuaOENWPKT6z4JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLUimgvzdyX/02jnV62JDqkj9pv3h320Fd1Dg9wOMf8=;
 b=Q2E1mwKyKosYr8rFtriMeKnayozSwIGUA5W7DtCxNDN0fll/LcLzEWwYhN5z4UZhUHqm/g4GFQF5GtcGrwt6vkgRzA7bgSZjlnRkyMzv0sMy1X2sbasusXjaGleIJEbx8pRiI2n+Y4WgMTOnNUeFbSySBOJQ4jYRe/FdgP64alAZ/k55gYLTLrv32aAmRPPRWHJuJ1chdHGreyZXOx579iSjcHIOD+Zinlx4Qip/kBXr70myioG7kGdujE2OWi3VZK2et5B4CTb8/ZbtUk41DMSIB49uaPlowTRmFRV9ThKn94bZOYnnw/mYpQw62bfSdBsxp+lh5Ykaum7YT/ShCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLUimgvzdyX/02jnV62JDqkj9pv3h320Fd1Dg9wOMf8=;
 b=qD/9cUnFSjWtSwjxoppsOtVzuJwcPm6zZxzTltV0qpJj1F/57RddRyNYk0Z4ca44XtDNvUCP05mDN7LVT2igElbNSqdF/iEGBceRy/Fewi2dEO0Zhf1ZCt4p6G+NrJamCkhxIOn1l9ikfAc03X9+vREKyB527a+Fa0kPOCX7bpSRhOMRAbqIlZJ2VCpHYMmQMtSWvX9TMIdxzPoLZCzM+xaSVsj5fhV7jO/5Jl6h3bsk639GHWnw3P7x6N9/f9sIioRGt7NUhINhxMcivoPpZb3N+DoTtpjvXDDwwpil8Ey0lTNQdANEKF1DkvygLvDCRkLmm4cYxalgZV9R8zI7eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 by CH3PR12MB8234.namprd12.prod.outlook.com (2603:10b6:610:125::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Sun, 17 Aug
 2025 08:36:54 +0000
Received: from MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2]) by MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2%5]) with mapi id 15.20.9031.014; Sun, 17 Aug 2025
 08:36:54 +0000
Message-ID: <3a5673b7-47d2-4a59-a515-95b396364994@nvidia.com>
Date: Sun, 17 Aug 2025 11:36:43 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/6] net/mlx5: Destroy vport QoS element when no
 configuration remains
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Tariq Toukan <tariqt@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>
References: <1755095476-414026-1-git-send-email-tariqt@nvidia.com>
 <1755095476-414026-5-git-send-email-tariqt@nvidia.com>
 <51908ab2-6184-405a-b723-8b030267e7c1@intel.com>
Content-Language: en-US
From: Carolina Jubran <cjubran@nvidia.com>
In-Reply-To: <51908ab2-6184-405a-b723-8b030267e7c1@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0025.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::20) To MW4PR12MB7141.namprd12.prod.outlook.com
 (2603:10b6:303:213::20)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7141:EE_|CH3PR12MB8234:EE_
X-MS-Office365-Filtering-Correlation-Id: d606bcb2-e001-4b82-429d-08dddd693827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vy9hYmpVSUk4bnMyVVV4cWNYS1NSVGVlalVobnFoWFhlV1NvMjA2SzM1bmlO?=
 =?utf-8?B?OWRtbHVTelZuTmlzMXFsbGJCRXd2MkEyWlBYQWdiNjNqM01XR1RWQ0g0OWR3?=
 =?utf-8?B?cVJaTVQyVVBhK3JPSi9GL01sdHlIQVlMZGhXOXdiTU5saWNZYUROejlTdlIv?=
 =?utf-8?B?czdmQ05IZEMxblBBeGYwZ3RUUkZLa2VpbHVORlJ2Q3ZsQjk5MDdjM1gxQ2RE?=
 =?utf-8?B?SXdlL0p0a0tyOGYvbm5XZEU5TXdWdkM5TU9RRHN2U2U3SnZCSGxxMldoay93?=
 =?utf-8?B?KzIxS3J4WlB1S1BLMzZjV1JBZ0drQjFBSVVmR0MyN0I5S0JGcVBWanpBcE1z?=
 =?utf-8?B?b3dxbnYzUU1NSnFZQlNMZzNaYS95RFZCOVZEWVFvNGwwUFBhMXM0TkFjdTJn?=
 =?utf-8?B?UXJZWjZlem9aZkZpZlpTZ24zMXhYUks5MWtFNFVnMkxSKy9kZ0ovRWlTZ3I1?=
 =?utf-8?B?SkFtWSt5aG5hWVEraTdmQnJvZlVoRmwwSTRCM0RCN09zTlovUDIxQzJaRXlG?=
 =?utf-8?B?SW5OY0NlaXk4V1FIZVFhNExsTXArOWxTS3NhQlBlKzRzNFpJRzNmUlBTWFhD?=
 =?utf-8?B?MEIzbVVLbW9KNEFzQWx4MExZblUwWHo0UmY0Uk54SS9aS1YvV1Q1UXlMdVY5?=
 =?utf-8?B?eFg4VHBQV1VESWZoMEdoSzVrT1VmenFoSGJCWldkRlVSc0xYL0FONHBwV1li?=
 =?utf-8?B?YkZEd21WVThNVXZnM0NZY2I1MThsNzB3WTdaT3BINWk2c2VMWnJpcGJEZG56?=
 =?utf-8?B?UW12RitFSjl0ZzE4b0c1TTRZbVc0cXlhS3Q5ZTkwVWFWQk5wSWFibXYwMVp1?=
 =?utf-8?B?d1IrbFVJZmVHeDZiLzVxcFlJLythQ2ZIMG9HVitNT2xGaUlZdk5iLzk1ZVQr?=
 =?utf-8?B?bVhqKzBuQ0RsNndwVk9QVWZRSUxYTE1RTVZaSU5mMjRaQTd3djlZdXdpRnNN?=
 =?utf-8?B?QVR5SU5Jb1RDb3MrL2NCdkRUNDNCNktxMEpSbjByWEZlcXl5NG9EdkliMlRK?=
 =?utf-8?B?NFZUSHBwR2RWNVNXQnhoNTZwT1h4eDVJMEp6K2t2Umk5Ri8xTXJqQ0pOQ1FP?=
 =?utf-8?B?NklZUjFobzhHYWRNOVBpaS9pQlJYaFZuTlZaWkEyTXlEMGMxL3YxRytTbnBr?=
 =?utf-8?B?b0ZVdzBIeSs3WkdScWI2ZEIxOWxsT1E1YnR4OWJ3dnBhb3F4UEZQV1BJMDVB?=
 =?utf-8?B?VXF1QW56MU5NVjVmaTJITnl6ajBLNGtKenJjbHlDWGVJMjlmUEtRSFpkTVM4?=
 =?utf-8?B?MW1iVTNRdnkyR3lHNDFxVWtFVnEwSFNQcTRSL1RKSkc5RUhJMFBiL2hDUXVJ?=
 =?utf-8?B?VVNraGZtNEs2TmJRaWRwdzVoa2gzRWU3SjMwM254UXFGVnlScXVBOVRmZHM3?=
 =?utf-8?B?d2F4UHUzMjh3dWRBbUl1anBwN1Z2alhhZWlmRHp3YklQVHd4aEd4QlUvNkg5?=
 =?utf-8?B?RnpKcmQ4WFY1N1A2VXRaUHc0aTFjV1FzUlNOVlRMNkZwZk5pN0VEUkFuT0t0?=
 =?utf-8?B?WGZVYkFQaTN0TDh4QXBjNmxMK1RobU4rOGRzN3FuT2RTNnFHR1ZOTmYyM3ph?=
 =?utf-8?B?b3ZVZUw1UVFIS2Z4STNjbTlUQzQ5RDlUY3o3QzNnQ2krVnZLOW4wSy93V25k?=
 =?utf-8?B?QjJHTU1FanJVM3VqUU1kejBZWnc2T09XRnpuZDB2ZHFvMVZsV0VZSW1MZ3V2?=
 =?utf-8?B?R2xCYW5zVjdHanBTUXFxclZCNG1ZNGJkWGVrb0lYV001dzRtV3dlZmoxYkRa?=
 =?utf-8?B?eStOMU92VXZsMXZ2S3hCNjhRVVFYL1o2VVU4WlpIQ0xIYmo4d0VUd29FYkpL?=
 =?utf-8?B?dGREbm0yTHcyaGpiMURDL1p6SlFXWHkvS2tPUXdjeUhNNWtpRkRxaVVHemlj?=
 =?utf-8?B?ZGdRWkxGVm1xWmwxS3NNNTU5dzQ5UTFCcmlTWGx5NnZvbnl3OHptNVMvRXJ0?=
 =?utf-8?Q?31Nb1Dnaiog=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7141.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkpiSHBDL0RzbnR5Q2gwbTR2N2puYi9vQlA0Q3paejBzNXlWc1hJMkxCd0NM?=
 =?utf-8?B?R0h2WUlxY05QODhHTGZic1dDR3A2bndITG13aXVGQU1IeFliejJsSnNrYnIz?=
 =?utf-8?B?Y2UvWlIrV2VXNTBFMGFNdUNucHpVVENFQ0ZvYlJiZStTWGt1Rm9iejZtWXB4?=
 =?utf-8?B?Q1FMUEpERUlrTzVicXB3YVRBUml3Mk9Ucnp0Tzh5YXJiekdwK0lKZzFJN2FX?=
 =?utf-8?B?RXNvY2hGTmNqWDhGRnpHdUZERExHQzNvcWIvbFRnaFRjTTZSM00wanFpdGRs?=
 =?utf-8?B?eGJKaENqSkJxUERYWEt6WFA0Ky9XejVRdnpsWnEvOVRQeUR5TlNCRzUvYUY2?=
 =?utf-8?B?SDR3Z0w0RkticEpHSkJiaDRHLzljSEhrNkVlZG1aSjkrVE5RcndxaGlxMjNQ?=
 =?utf-8?B?UjBpZFZ5N3RGdXhDcE9iZ2VnL1p4Q1ZUb1lkbEdsdEczMytKQXdxRU94bUJt?=
 =?utf-8?B?Ly9oYmpRMjVtQStjR0FMN0Y3VFdab283UkVqUXhNaDRUT0hPN0RJc2gxbVEz?=
 =?utf-8?B?UGtqcjcvMFJ2b3R6VU1KMWc1Zlp4RHhuc2VuQ1RRNG5WNWhKTEkrdnhRMjAr?=
 =?utf-8?B?VUQ0K2FSeklMLzhLUUJYdFhaamgyQUFQRVB2VzdjZnpMVGNtZm1oLzcwZ3JR?=
 =?utf-8?B?OFlwSStmVytFMGlueC9tV0thN2FUNzJKbHByT09XSkVPTnJ6OW0yMVZXdFdl?=
 =?utf-8?B?N0xsUng4dXNMSENwY2FZNlVoYWVBYkN3cklSdjErWjFsRXFLQkQ2YUMzNGpR?=
 =?utf-8?B?RmU4SVArM0xtQWhwaWMvMk15eXQveThNUFI5end1YTFiNE1IT2dGQ2dEZlgr?=
 =?utf-8?B?WGs5ZTZvaE43UXRiN1gwUTFiSFFUdHZoSVlMQWM0cjZYMTFwZEtnRlRlY2tt?=
 =?utf-8?B?ditmaS9INWpnSE5yOXBYZmlaeVVTRWRmN0MrSU5hMDNlZnFsMjRIdHo1ZFEz?=
 =?utf-8?B?YkdSK21tQTcyNUsybnBKNWllYSs2QlU1d0Yvc1g2WE9kczI2Y0tObDhmVlJt?=
 =?utf-8?B?K0xNaGZEZm0yYUtpTEtzbVUzdVZPM1oxcUwzL2tHTUo4R2ticklveDEyNGxT?=
 =?utf-8?B?d2tGZ21xUDNBRVRTWFhhWVpXUWRJRU5uQTM5QUxHb0E0OWFXbXo4Q2s0c1Rv?=
 =?utf-8?B?aDhQVGEwL3VPNVNwdkdFblVBVXcrUURsV0twanViMkRxL2hKNzVYbXhwUzA2?=
 =?utf-8?B?Q2JlMDRWNWh1VWJpMG90YzFMUTRxYXZqN2RwMndoQlRtUXFyemRCbEdZcTh0?=
 =?utf-8?B?WkI1MnlrTXc3WVUxVDZXbkdqOTdWbnR5ZjRYTCtxWWE0Qml2SHFzZ0tNUXBC?=
 =?utf-8?B?ZU1FWDlDWExvWng5a3pFWXNLa05yS1lvSGJKRGxqYjI1RWNGVGFzVjV1R3Rr?=
 =?utf-8?B?eDlLOCtBdDNMa25CRmtmVTN2Q1haRUROSTlmcjZreEd6R1dpbmwzeHJVSXll?=
 =?utf-8?B?K3d3dk12S0tvVk83dmFhYTBGVktIS2Q0OGJCTjF6ZCtGakU1TEQ2NGxQcGll?=
 =?utf-8?B?anJmRWw4MFAzODFSTm0vOFN5alNNQXFPY2I1K3BTQ3BvakhJTWMyc0JsRGY0?=
 =?utf-8?B?QjE3TEFIRUE1Yi9GYk9hWEt6bjlMQ0J4WlRHaWdmOVNzb1doWWV0VzU5Z3dl?=
 =?utf-8?B?NUs5YUZsL0lNRFdwK3Z2NC81b0UwdEJheVN5Y3dKdytFUU9LK1UzOVBXM3oz?=
 =?utf-8?B?NjkwdUp0UktIc1lhSDVrQUpXTjUzeS81Q2RiZkpnRG5QMjkrb2JvWE9pd25Q?=
 =?utf-8?B?eWZrM2NSa1Foc0k4a2lRWTg0dXVFMVlLaGFlM0JYaEpNcmVVVWY2Nk9HSXFZ?=
 =?utf-8?B?dzRxMW5WbUNoY2lPVmZXNU84ZlRPVnhHQjAyM0RGVUVpdTR5WlhQRmdZWFMz?=
 =?utf-8?B?TGNHMlhrZnQ5ZEpTeDRCZkRwdnk0UzBMd2FGRlg1WUszQysvbW1WZDA1UUlJ?=
 =?utf-8?B?alpwQnRDMTNydUxESWE1bGlpWjkxNHdtL0Y3Q2R2TGxxVWE5aW9EMHNVSnhH?=
 =?utf-8?B?UWhndi9HdW04RnFmNmJYSGZlbHNhdmdsMFRIRVBKcHdoR2FHQWQ1ZTZwTkM1?=
 =?utf-8?B?WFloWTA4OXhaeXAybWM4VEpsMUhMOGdZSUZBUDJTeC9TNnkwdm5nYW14SVRm?=
 =?utf-8?Q?P5BFi6Ij8Ow4kt5sPE/3EWTV7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d606bcb2-e001-4b82-429d-08dddd693827
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7141.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2025 08:36:54.3486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZPqjVEd1Xp4cRA4zMSxnJVIq7zbmBStu1OuWn4SZsnCrDu0IYa5gY8zmiQDofu/MAXoRd93yGEpeb0VZgVh1JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8234



On 14/08/2025 12:55, Przemek Kitszel wrote:
> On 8/13/25 16:31, Tariq Toukan wrote:
>> From: Carolina Jubran <cjubran@nvidia.com>
>>
>> If a VF has been configured and the user later clears all QoS settings,
>> the vport element remains in the firmware QoS tree. This leads to
>> inconsistent behavior compared to VFs that were never configured, since
>> the FW assumes that unconfigured VFs are outside the QoS hierarchy.
>> As a result, the bandwidth share across VFs may differ, even though
>> none of them appear to have any configuration.
>>
>> Align the driver behavior with the FW expectation by destroying the
>> vport QoS element when all configurations are removed.
>>
>> Fixes: c9497c98901c ("net/mlx5: Add support for setting VF min rate")
>> Fixes: cf7e73770d1b ("net/mlx5: Manage TC arbiter nodes and implement 
>> full support for tc-bw")
>> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
>> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>> ---
>>   .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 54 +++++++++++++++++--
>>   1 file changed, 51 insertions(+), 3 deletions(-)
> 
> 
>> +static bool esw_vport_qos_check_and_disable(struct mlx5_vport *vport,
>> +                        struct devlink_rate *parent,
>> +                        u64 tx_max, u64 tx_share,
>> +                        u32 *tc_bw)
>> +{
>> +    struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
>> +
>> +    if (parent || tx_max || tx_share || !esw_qos_tc_bw_disabled(tc_bw))
>> +        return false;
>> +
>> +    esw_qos_lock(esw);
>> +    mlx5_esw_qos_vport_disable_locked(vport);
>> +    esw_qos_unlock(esw);
>> +
>> +    return true;
>> +}
>> +
>>   int mlx5_esw_qos_init(struct mlx5_eswitch *esw)
>>   {
>>       if (esw->qos.domain)
>> @@ -1703,6 +1731,11 @@ int 
>> mlx5_esw_devlink_rate_leaf_tx_share_set(struct devlink_rate 
>> *rate_leaf, void
>>       if (!mlx5_esw_allowed(esw))
>>           return -EPERM;
>> +    if (esw_vport_qos_check_and_disable(vport, rate_leaf->parent,
>> +                        rate_leaf->tx_max, tx_share,
>> +                        rate_leaf->tc_bw))
>> +        return 0;
>> +
> 
> I would rather keep executing the code that "sets tx_share to 0 and
> propagates the info", and only then prune all-0 nodes.
> Same for other params (tx_max, ...)
> 
> That would be less risky and more future-proof, and also would let your
> check&disable function to take less params.
> 
> Finally, the name is poor, what about:?
>      esw_vport_qos_prune_empty(vport, rate_leaf);
> (after applying my prev suggestion the above line will be at the
> bottom of function).
> 
> Also a note, that if you apply the above, it would be also good to
> keep the "esw_qos_lock() just once" (as it is now)
> 

Thanks for the review!
My initial thought was to reduce the amount of FW commands, but I agree 
with your points.
Also, thanks for the name suggestion.
I’ll fix and send v2.

Carolina

>>       err = esw_qos_devlink_rate_to_mbps(vport->dev, "tx_share", 
>> &tx_share, extack);
>>       if (err)
>>           return err;
>> @@ -1724,6 +1757,11 @@ int 
>> mlx5_esw_devlink_rate_leaf_tx_max_set(struct devlink_rate *rate_leaf, 
>> void *
>>       if (!mlx5_esw_allowed(esw))
>>           return -EPERM;
>> +    if (esw_vport_qos_check_and_disable(vport, rate_leaf->parent, 
>> tx_max,
>> +                        rate_leaf->tx_share,
>> +                        rate_leaf->tc_bw))
>> +        return 0;
>> +
>>       err = esw_qos_devlink_rate_to_mbps(vport->dev, "tx_max", 
>> &tx_max, extack);
>>       if (err)
>>           return err;
>> @@ -1749,6 +1787,11 @@ int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct 
>> devlink_rate *rate_leaf,
>>       if (!mlx5_esw_allowed(esw))
>>           return -EPERM;
>> +    if (esw_vport_qos_check_and_disable(vport, rate_leaf->parent,
>> +                        rate_leaf->tx_max,
>> +                        rate_leaf->tx_share, tc_bw))
>> +        return 0;
>> +
>>       disable = esw_qos_tc_bw_disabled(tc_bw);
>>       esw_qos_lock(esw);
>> @@ -1930,6 +1973,11 @@ int 
>> mlx5_esw_devlink_rate_leaf_parent_set(struct devlink_rate *devlink_rate,
>>       struct mlx5_esw_sched_node *node;
>>       struct mlx5_vport *vport = priv;
>> +    if (esw_vport_qos_check_and_disable(vport, parent, devlink_rate- 
>> >tx_max,
>> +                        devlink_rate->tx_share,
>> +                        devlink_rate->tc_bw))
>> +        return 0;
>> +
>>       if (!parent)
>>           return mlx5_esw_qos_vport_update_parent(vport, NULL, extack);
> 


