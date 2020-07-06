Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8EA2161A2
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 00:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgGFWdZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jul 2020 18:33:25 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:5364 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgGFWdY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jul 2020 18:33:24 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f03a6a70000>; Mon, 06 Jul 2020 15:33:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 06 Jul 2020 15:33:23 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 06 Jul 2020 15:33:23 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Jul
 2020 22:33:14 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 6 Jul 2020 22:33:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBiNpySy2ZnS39LrNCUJbTboCN7xGKdlyljScqUpZ9iAxHTUGsxvdwPrBsaV0NvCqm5Aywh+OGIEs/Eq09Ash27BLPMrCOJ3lwKo6FvhTTBf6yv+0FXPUvRtE/Bl9S5uPoAEFSQjo3povLzousZuc+rIMYhLOk0tDwJkjk33hEja9uPowk0K5MC2T7txIBTHWez6dR3Q/IUx17zB6ysfwafwe4Rvj3+fPoi01QwooxqiBL9lWQruL2exGgNCIhHRRqLUB0qXzw4n6iLn3RmaQCJV2m6kj2a598jQOwNe/2fMSKAP1LaeW1nKtof5mjsxjbObk/rOWbgnqGcJDO9VWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XSYFsynAKK0JcqTFFaqTRZxUdut5rm9tEY0ltHWXEA=;
 b=TrDwptAM/qk9hO8IuFZgvgJ/Czsk9LLtTe7VlthEhQohmv7qMt8oXla6H5YN3dFxSSAxqTxxXtNIDk6fYMO0D4SPRlLY7ERnDI5o2HBAOv9uta/M/+0yvalsbYa50j17y+gZ4Uo5Nf4DwQEV+WIrwbGia8kIthkOTGAjkSydGaJgONaEPHUyjzANuSL7kWD/50hAnZaTVQzFDTKASZbCZ0o0KY0fikoVuSpRPkdEhRElftTAB4T83RVc5/x3amd49Xhqs89WMKE079OuosfPaRftcPnASEMF4elXTvuEgO2nXXmqok9PTvpkCKBZPusqKQnl71UT5nlhEyi4Ou9pjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1337.namprd12.prod.outlook.com (2603:10b6:3:6e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Mon, 6 Jul
 2020 22:33:13 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 22:33:13 +0000
Date:   Mon, 6 Jul 2020 19:33:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>
Subject: Re: [PATCH rdma-next v2 0/3] Convert XRC to use xarray
Message-ID: <20200706223312.GA1257718@nvidia.com>
References: <20200706122716.647338-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200706122716.647338-1-leon@kernel.org>
X-ClientProxiedBy: YTXPR0101CA0046.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::23) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTXPR0101CA0046.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21 via Frontend Transport; Mon, 6 Jul 2020 22:33:13 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jsZfk-005HCK-D8; Mon, 06 Jul 2020 19:33:12 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18055a57-5491-451c-c9f2-08d821fc91de
X-MS-TrafficTypeDiagnostic: DM5PR12MB1337:
X-Microsoft-Antispam-PRVS: <DM5PR12MB13372CACBC1E6D18C50A1D57C2690@DM5PR12MB1337.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UM+K0F2xL0arNJVYNkk3NhPWUfB0nWt86JQ8TOODyZIXJv4j2H4qf7hmOwPgVx0jeHUURXIKvwnN//1i5sEVIEmp6G1T6LUC2Oen9sBRW5fNssdT/juFNccvigm9ipHbhxsSm6EoQdweXwvKwm/HEI31TJXyvwATSUozzg38jcu98ON1qcBsuXOf+JBwG235ZAAHzR2dofNmploow2Fu4DNp//KMjT9XbTOgEsfaPhOFeXG01mSu9bNQQWYQH1QprOkuTFCWyEcryoYR4FGBRnAJyNlnykDyOrSOvFIuvohZQfSVvVBSd1cE+ifFr0f3N29qf8gkIanXURoob02QWB5toAtbAIrFT2kpgUt57O8xlkkePUztxNaSZEAKPzboEBhgq5u8TrjvV+RgOuj3AQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(478600001)(316002)(966005)(54906003)(86362001)(8676002)(33656002)(426003)(9786002)(6916009)(26005)(2616005)(5660300002)(9746002)(66476007)(4744005)(2906002)(66556008)(36756003)(66946007)(4326008)(186003)(8936002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ahs5rJ6GyQYKjMTWNHZyP3cuCEn0ye2u3IG9dx6KTxkrV0FOxkneU8BAP3CUkEcE0jmwtTNyFkkURrtKWZ3wZMCRZSi0LD925/sMHsaLmdUFIqpMw2750lMX3ZhPbUqhlsituhUcTVvGcH1wUiYU1n/6iPpD8oaEwbQ4lk9J68eDW4ng/7YP1/MB4QFhn0wSjDfPqm2brSFpTPG3PlXI1EN9fNWAcvwgcAsposvuRZZTT+QlOIe8K/gS1tw+8/i+CbMKSCrX1BQnhQJqlDQ7g0r+23whaBQHW64X4gkDgVcek7JKpkPJzEdRmvqjpipK62ANsKewTelMxAQ6gf/uYrZ6pqMtKGFQ13shWFvItdPXCRpYRzfe18USwwEzcrS1cu6YNoXEUS0G7u5JxOFLLFmfZ5mNAwmQwhF27jMv92on5zgcQIWWXTNrzqvxvCyhnRUMHjxQgN6cfkqG5pHqZnOlwVfF9w95/1WRkv+b8YjTXS2cBWu1at+syfBdwCy+
X-MS-Exchange-CrossTenant-Network-Message-Id: 18055a57-5491-451c-c9f2-08d821fc91de
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 22:33:13.7616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 75GN9LuYkB6LoG6S6x/EPGss5QbaJ3cTcsB67xaVodXv0FkDI/HuCBNEb82w2aT4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1337
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594074791; bh=4XSYFsynAKK0JcqTFFaqTRZxUdut5rm9tEY0ltHWXEA=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-Forefront-PRVS:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=NbM6fBWmQWmRo0eJHAyIgRPqZ/KWROoO9vWyDxtgdNhvKknMaByiF+32PEeEiSqdi
         UHt6N3UtaPcEmMrFVK7hubztmHoiqJSaD95XdXaGj8DORAiw3pUJXWA+unymhqqH5f
         O/J5AJM7t6dYhkXzh+0rDDrDs/qBPKoCZab8PNMt+IS1JE0aKp1S9xrSbJTrWEmFvR
         54F2o6rFWxKqQ1Tsj1ocqIG3fD7odHa5C0fEdw6nSTs9EbY+L4w3CfbcyLXhPo2nOh
         He5WxZIx3ZMq2oxV/EwpZDVuDdJMbHcefbKGTWdwGRJ7FFtVLJ6V7To0g6zYSo1EVW
         KcKh26zIOqi6g==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 06, 2020 at 03:27:13PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Changelog:
> v2: Rewrote mlx5 part to avoid ib_xrcd allocation.
> v1: https://lore.kernel.org/lkml/20200623111531.1227013-1-leon@kernel.org
> Changed ib_dealloc_xrcd_user() do not iterate over tgt list, because
> it is expected to be empty.
> v0: https://lore.kernel.org/lkml/20200621104110.53509-1-leon@kernel.org
> Two small patches to simplify and improve XRC logic.
> 
> Thanks
> 
> Leon Romanovsky (1):
>   RDMA/mlx5: Get XRCD number directly for the internal use
> 
> Maor Gottlieb (2):
>   RDMA/core: Clean ib_alloc_xrcd() and reuse it to allocate XRC domain
>   RDMA/core: Optimize XRC target lookup

Applied to for-next, thanks

Jason
