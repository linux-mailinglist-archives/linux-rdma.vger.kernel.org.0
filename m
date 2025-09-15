Return-Path: <linux-rdma+bounces-13363-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41995B5740C
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 11:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 153D11A21D29
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 09:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D6D2F3600;
	Mon, 15 Sep 2025 09:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z6WMJZ+N"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C0B279324;
	Mon, 15 Sep 2025 09:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926919; cv=fail; b=hZcqNK4NEhORNw162rSQkEUmAaCDS002LoBV2JsP3WZ3cCGjHkDE7QaKz8fzD9oTa3bwQSkMSxq+Bvmf0MoKY+OAHdYJlAG3VMIGMoMaoWMIyEvp0R18Ok0miiWZOSDxIkjhZ8yy5slC4kInRJhznNiTpwugaS/bwu8r0rnlCrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926919; c=relaxed/simple;
	bh=nKvpqkVkcfGFo36XnUQs9TQRX9pDauwsrNQTqEVKBDk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aupOcbQyN9+6ZW+q2nd7G+jf/+mQEs0w2rhKj1RQ4i7U3mpOMl0d++xYFgOaf6pAFK0NXUurt4USDqpeXsaCv2FNfdUd40KgPoRfK/+AVfvV7sep/9MQFmtC1G3JTbScmqq9lIEPaJ3f0u7DwAPDhgVb84vZStmDbAG3OI6dbBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z6WMJZ+N; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MCECjYNbvhp0fIiyVn7NBKcAnE+ouihp9YFzsFf4wqa0WVTOSWMK72pcytxpwCLRSwv3X03uiUWUjEqsspDa7gKAtsQP5ZT9KxbKhEaqCvHU0s/YK9zy8fQNGFlyNHWVj3MES5YXD9utTbPFRIrUKdZz06gdFSKvPp4TXpw7/3AmZp6ljsf2tmiw1rLlVxtJfLOLzVc0weoamDIe1aMlFM3cCQBSGQEwgj4Cr8KMo/5J0CBTdgpxUah/+AZarASZyD0p+1WkhaQ8lesqT7hqbvJGZX19Srf1QOX8B4QWlOZq5wTglsUGHKXsDpICsr6alYL8zAqApq5H0WJMqpsjYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDub70ys3u1U0+3kpB4xyFatjKV1C2LaNK5PD0Kk6/c=;
 b=nYZDkVVSw77GbFD/XsahAeq7jh5GtDM2BClDvYNbOEODAu6EphNR3TIZoepU1r7yKhIVadBf+0K6hzgTtoZex3tFdCRthBIf/gNZFSbFFkt0pkawozDtou0b37Bmo8UcxnkgJM9VJY4cDdnDLNQEgs5yu63d/6yS904Cg5vQ3J5glTNcCcYleIru8MLxzD50UeaZf/PefyFXLkIEbM5RLPcrND/r8OvLQe/zY8sx3ErpzIUDhS4fEyWK8IQkTcIC7GUib/ZjgkGbv5UbFyJhKLY95VDc7BNznqJaxEVoLKiQw9edBEiuDNtyMHLDDtq1l/UR+Jq+oVMPW6v/HcDsjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=broadcom.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDub70ys3u1U0+3kpB4xyFatjKV1C2LaNK5PD0Kk6/c=;
 b=Z6WMJZ+NhuTt9+4Ibfs0J30595uOimm/5lBvAwr1yvUjlEU+16nWdsrf2LM+R56FjQfl+IPE5YJp+pl17qWSg0xhx6oFGz/JHl7UhdSJ7c+vz8ebHelcSy15MbsVgUIgtSu54tMDeKM/Vc6Y2tXXTfCsReUhYdIAWoco43ybEPH0hqeNGp7LxK/KKI24xXBZO4n7BFGV4iKZol7seb+kUAml0e5hl2IsQEErD8AWs74Yp/0A1dzOelsDcCxp7D3+yxvazS2rQhXYizsSk9yPnoTeVlZHV02whQTj2QNyk0pQ3vCEFwSgWwTTHPR3mJamkUdOAdcyxcPsFVRnhbgx7A==
Received: from BYAPR07CA0008.namprd07.prod.outlook.com (2603:10b6:a02:bc::21)
 by IA0PR12MB7752.namprd12.prod.outlook.com (2603:10b6:208:442::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 09:01:52 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a02:bc:cafe::c1) by BYAPR07CA0008.outlook.office365.com
 (2603:10b6:a02:bc::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.20 via Frontend Transport; Mon,
 15 Sep 2025 09:01:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 15 Sep 2025 09:01:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 15 Sep
 2025 02:01:39 -0700
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 15 Sep
 2025 02:01:37 -0700
Date: Mon, 15 Sep 2025 12:00:30 +0300
From: Leon Romanovsky <leonro@nvidia.com>
To: Siva Reddy Kallam <siva.kallam@broadcom.com>
CC: Simon Horman <horms@kernel.org>, <jgg@nvidia.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<vikas.gupta@broadcom.com>, <selvin.xavier@broadcom.com>,
	<anand.subramanian@broadcom.com>, Usman Ansari <usman.ansari@broadcom.com>
Subject: Re: [PATCH 5/8] RDMA/bng_re: Add infrastructure for enabling
 Firmware channel
Message-ID: <20250915090030.GB9353@unreal>
References: <20250829123042.44459-1-siva.kallam@broadcom.com>
 <20250829123042.44459-6-siva.kallam@broadcom.com>
 <20250912083928.GS30363@horms.kernel.org>
 <CAMet4B7SJXk1yMsJ61a026U3wNKr-7oNX9_-V+_W1PA0VRaaTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMet4B7SJXk1yMsJ61a026U3wNKr-7oNX9_-V+_W1PA0VRaaTQ@mail.gmail.com>
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|IA0PR12MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cd6e19c-6252-44a5-a1cd-08ddf4368306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnJhQ242bEoyUkxZUWwwK0hqNVh6V3lON0Vsa25oYVBRSzJjWWxHeFBnUm8z?=
 =?utf-8?B?bXVYaW5MUnZnc0FHNE4zREM3blNXNVdTM3dNOE44Y1dpZ29FL2p5L1FLaUJ2?=
 =?utf-8?B?THcwOFZJbXM3ZklCYjRIQ0lYNC9UU3dVTFVIQkRVU1pCSzFhVy85cWEvaU85?=
 =?utf-8?B?MDZxamhoQTRHdW9DTUxzSTdRblRwVmFMb2FKQ24zU0hjemxRVmp5MUpYT0li?=
 =?utf-8?B?SDYzazRsNGRuSlFXbUhFUGlaQk5BbjBxZm1SOVByTVhIOFBrWUU0S01oeldB?=
 =?utf-8?B?NTlpUHY5VWE3MFRndno5K3RsUFp1eENrYkRpcmpKZTFtVlBIY21jMmVxMGsr?=
 =?utf-8?B?M0p6TFpubHNmRlhVaGtja1hxMzhwam9YOGFSb25zemdWMXhVY3pUazQrVmlj?=
 =?utf-8?B?bHphdWVRdWtKNkhPUG96RTRFc1gvQjd4TXVzRE10ZkJnWG4vZGZ3bzFZa1VS?=
 =?utf-8?B?SkNPNW5PVmd3a0NOR1UyWVlWa3V1T0FtRDNhbWxvR0ZTdkpvUGxRN1EvdWFP?=
 =?utf-8?B?WWo5ejN1dlNmM2pGeXlDeFltTDVjQU1lTUJHMlhUczZhQXg3MHg2Zy9rUG8y?=
 =?utf-8?B?Um44NlVGMFJwN1g4bzJSTzQwMS8vMTF0b3VnK25LS3ZXcHNpWEJqT2h6bXRj?=
 =?utf-8?B?SFZJUURwMThKaThqZjU3dE1hMUYzZmcxbzRVWkVpV3B3emwydXhrbGlFeEUv?=
 =?utf-8?B?b3E3aWlDNUhhNGVCbGd6bi9nMkFEVnJ1YzYvbFNsU1JEZ2wrakVFZEZpMVJP?=
 =?utf-8?B?Sm9FQUFjbmJYMmo1bEZ1eW9xQXBNRUppL09HY0x4ZUVhRHZXdmIwZFRucHVq?=
 =?utf-8?B?ajg4L2V5cXgrZzBHTzRxTGZHMWtFMDRyb0MxU3JSZWlXNDJRakJKc2VXOEpN?=
 =?utf-8?B?MUFtc3lZRnp1Q1RXd3dKbXpYeC9MbHIvSjhCbEpQcnNrNE95ZGxqNmdnUGdN?=
 =?utf-8?B?cjRwNEd0YVRIRGNvY3pwYnZPYTZ0WFV4NWE3cjZRNHRmRmt5YWFuc2dNRkdq?=
 =?utf-8?B?VEg4N3h3VVFBbXBPamd1djJEVGtuNThZUklQYURNN04wN1dZcGhLNDc4QllV?=
 =?utf-8?B?WXEyMWJ1RXpKSHlGYVIvUGtEbklYajVaa1l5eXlsbUZENUVxbUZJNUtDV1dk?=
 =?utf-8?B?U08wdCtmSTZlSGdZeWJXWlhmVVBnVjdZbjVFWXRaSFF4eElKcHdVMSt0MjJS?=
 =?utf-8?B?Y0pqYkZNV0JTNmI5a21Xd1JoS2pOQ2M4ZVFGNXo0eXk4eVVHd2F6c2dVRnh0?=
 =?utf-8?B?blo0NTIvRk9sQ3REVlZ6NDRZcUZueUU4SWNtcmp4Qk5FYmxGcU9tK0dodC9C?=
 =?utf-8?B?ckppWWpTYVhWWnRjWWNwcU9rMlBwZW1IRVJ4U0NLUnFTVmE3STk1T0JtTkxx?=
 =?utf-8?B?SXFFanlZbTlRNnZGaXo3UnMwYTRsRkhyekxjbXBzZkt6R1hwZm52QlRXRWJn?=
 =?utf-8?B?QzZGbHRWT3N2TE01T0haa1MvVWFiYmZuNVBRT09jblUrMmR0a2tGSW9OZnRP?=
 =?utf-8?B?QjBXM3o1VEtJbWJkTi9nY1NKYkpRZ2N6THJyUjNGSFVDdlp4NnRtcTRTazJx?=
 =?utf-8?B?SFFvdXBCR2dHWExuSU5PWVBHYmFYRHY3Y3Z1UXlsZ3FNWXUzUjVlQVViTlBM?=
 =?utf-8?B?aDRyVlJnUU5PVEI1V0ZGcGtJL2R6YnlCdXd5U2ZITlJiTjkrTm9yK2lHa3hS?=
 =?utf-8?B?b1NiTFlYNkVWVjU1c3I1ZDlwYlJPcHZkVGlGclRCTi9PdzZIUFdhMkRtZS9M?=
 =?utf-8?B?WTF0SG1XWnE4aUFsQmtsaG1yTGlvL09QcWxmbkl6QVYyNmhDZ0djMVo3cHJ1?=
 =?utf-8?B?RDVFT3A3bzZjcy9CUzVEWXI3dDBaVUwwOGVhWW1XNExDWDZnMEl3L0Z0cERB?=
 =?utf-8?B?ZjI3Q3U5VVJGNnRwSkY0SFIzc1dRdWtVbWpJUlBMeTgvZ2RmMnd6RjJuM094?=
 =?utf-8?B?VG1xMkpobVN5UWRKMmVqZlp0MzhuOWlKQ0xFcHU0RWRBemFuTmVIWUh4UE5I?=
 =?utf-8?B?VGUxTUJ5QytSeER6YlRHQld3Y1owOG8xa2x3dUFvN0N6SXpXczFwalpjOU43?=
 =?utf-8?Q?DaYmTP?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 09:01:51.9783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd6e19c-6252-44a5-a1cd-08ddf4368306
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7752

On Mon, Sep 15, 2025 at 02:14:19PM +0530, Siva Reddy Kallam wrote:
> On Fri, Sep 12, 2025 at 2:09 PM Simon Horman <horms@kernel.org> wrote:
> >
> > On Fri, Aug 29, 2025 at 12:30:39PM +0000, Siva Reddy Kallam wrote:
> > > Add infrastructure for enabling Firmware channel.
> > >
> > > Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
> > > Reviewed-by: Usman Ansari <usman.ansari@broadcom.com>
> >
> > ...
> >
> > > diff --git a/drivers/infiniband/hw/bng_re/bng_fw.c b/drivers/infiniband/hw/bng_re/bng_fw.c
> >
> > ...
> >
> > > +/* function events */
> > > +static int bng_re_process_func_event(struct bng_re_rcfw *rcfw,
> > > +                                  struct creq_func_event *func_event)
> > > +{
> > > +     int rc;
> > > +
> > > +     switch (func_event->event) {
> > > +     case CREQ_FUNC_EVENT_EVENT_TX_WQE_ERROR:
> > > +             break;
> > > +     case CREQ_FUNC_EVENT_EVENT_TX_DATA_ERROR:
> > > +             break;
> > > +     case CREQ_FUNC_EVENT_EVENT_RX_WQE_ERROR:
> > > +             break;
> > > +     case CREQ_FUNC_EVENT_EVENT_RX_DATA_ERROR:
> > > +             break;
> > > +     case CREQ_FUNC_EVENT_EVENT_CQ_ERROR:
> > > +             break;
> > > +     case CREQ_FUNC_EVENT_EVENT_TQM_ERROR:
> > > +             break;
> > > +     case CREQ_FUNC_EVENT_EVENT_CFCQ_ERROR:
> > > +             break;
> > > +     case CREQ_FUNC_EVENT_EVENT_CFCS_ERROR:
> > > +             /* SRQ ctx error, call srq_handler??
> > > +              * But there's no SRQ handle!
> > > +              */
> > > +             break;
> > > +     case CREQ_FUNC_EVENT_EVENT_CFCC_ERROR:
> > > +             break;
> > > +     case CREQ_FUNC_EVENT_EVENT_CFCM_ERROR:
> > > +             break;
> > > +     case CREQ_FUNC_EVENT_EVENT_TIM_ERROR:
> > > +             break;
> > > +     case CREQ_FUNC_EVENT_EVENT_VF_COMM_REQUEST:
> > > +             break;
> > > +     case CREQ_FUNC_EVENT_EVENT_RESOURCE_EXHAUSTED:
> > > +             break;
> > > +     default:
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     return rc;
> >
> > rc does not appear to be initialised in this function.
> >
> > Flagged by Clang 20.1.8 with -Wuninitialized
> 
> Thank you for the review. We will fix it in the next version of the patchset.

Once you are fixing it, please squeeze you switch-case to be something
like that:

switch (func_event->event) {
     case CREQ_FUNC_EVENT_EVENT_TX_WQE_ERROR:
     case CREQ_FUNC_EVENT_EVENT_TX_DATA_ERROR:
     case CREQ_FUNC_EVENT_EVENT_RX_WQE_ERROR:
     ....
     	break;
     default:
     	return -EINVAL;
    }

Thanks

> 
> >
> > > +}
> >
> > ...
> >
> > > +int bng_re_enable_fw_channel(struct bng_re_rcfw *rcfw,
> > > +                          int msix_vector,
> > > +                          int cp_bar_reg_off)
> > > +{
> > > +     struct bng_re_cmdq_ctx *cmdq;
> > > +     struct bng_re_creq_ctx *creq;
> > > +     int rc;
> > > +
> > > +     cmdq = &rcfw->cmdq;
> > > +     creq = &rcfw->creq;
> >
> > Conversely, creq is initialised here but otherwise unused in this function.
> >
> > Flagged by GCC 15.1.0 and Clang 20.1.8 with -Wunused-but-set-variable
> 
> Thank you for the review. We will fix it in the next version of the patchset.
> 
> >
> > > +
> > > +     /* Assign defaults */
> > > +     cmdq->seq_num = 0;
> > > +     set_bit(FIRMWARE_FIRST_FLAG, &cmdq->flags);
> > > +     init_waitqueue_head(&cmdq->waitq);
> > > +
> > > +     rc = bng_re_map_cmdq_mbox(rcfw);
> > > +     if (rc)
> > > +             return rc;
> > > +
> > > +     rc = bng_re_map_creq_db(rcfw, cp_bar_reg_off);
> > > +     if (rc)
> > > +             return rc;
> > > +
> > > +     rc = bng_re_rcfw_start_irq(rcfw, msix_vector, true);
> > > +     if (rc) {
> > > +             dev_err(&rcfw->pdev->dev,
> > > +                     "Failed to request IRQ for CREQ rc = 0x%x\n", rc);
> > > +             bng_re_disable_rcfw_channel(rcfw);
> > > +             return rc;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> >
> > ...
> 

