Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B64251DCF
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 19:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgHYRFU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Aug 2020 13:05:20 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18132 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgHYRFT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Aug 2020 13:05:19 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4544c10000>; Tue, 25 Aug 2020 10:05:05 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 25 Aug 2020 10:05:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 25 Aug 2020 10:05:18 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 25 Aug
 2020 17:05:18 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 25 Aug 2020 17:05:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a++H3G6erfWltQuwyb9sSRYGBRmDWQ7u+lnWxNw3uiaa4M3xZ3SuciS43KXVum6x5MTZ4EXk22IlVtPTG1PVGmt5YPQRGejI4+sh0VII7rJd2QCqvgydNoViSw1SiOL4RpC55x1NUaRdxjRHT9nPly8dE7bzrSNJJtoP0FOacaBO3gk44ih38Qjjyl0jnhbXMXi4ej7w2Y8bSjsYrVNaR0f3/n43Fj3IsbaKycnlZbRHuVj1SSleqwDctRgPmQnUeE2OTzE9lDJRv+qGX3CzYmsEGbJfXK7kMe6lvtO3ykAxlmWubGdUg5VLKT2o4dVAv4SfKfrrcgrASIzbGkD3qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOTQbpCSMLKdQZT0yQmqLDjcfdbh3HprVbACXGdYe1c=;
 b=FAweCdrQly7PfB11gGNmsruvu3hd39mYpVB8T1v2LAS2DHcgDj5a5WCxDn8anzm8oVtHufwyDwCdxsJeE2BMXwfUSub/Ttoi3DX4ETX0zr9wjacTfkwzy7gzkH2AyzOZWVlSKrLJFI/s2/avr0knbC/DaoxNqlug0hxVCcWs6hNMZkVUJlzAOyNYFl34H8b4oOcvBpYuDoJOnQJ09KMJ/qUDi8G7Wiyppx2zNnKYcB4YjpGPEjJfS7iM02gMN852P3+xl5nnRgNXaXz52bkSS/D9pqKfSwLm4IoWp7l/MVWae8xqDHJvlh0Gxx/I1qIaet1CgDgxBdn1ReoHPG1hjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4057.namprd12.prod.outlook.com (2603:10b6:5:213::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Tue, 25 Aug
 2020 17:05:16 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 17:05:16 +0000
Date:   Tue, 25 Aug 2020 14:05:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Chuck Lever <chuck.lever@oracle.com>
CC:     <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] IB CM tracepoints
Message-ID: <20200825170514.GA3507370@nvidia.com>
References: <159767229823.2968.6482101365744305238.stgit@klimt.1015granger.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <159767229823.2968.6482101365744305238.stgit@klimt.1015granger.net>
X-ClientProxiedBy: YTOPR0101CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by YTOPR0101CA0013.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Tue, 25 Aug 2020 17:05:16 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kAcNm-00Eil4-Rb; Tue, 25 Aug 2020 14:05:14 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9f3d1eb-c710-4708-440d-08d8491909f7
X-MS-TrafficTypeDiagnostic: DM6PR12MB4057:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4057A81740675B9A54629FEBC2570@DM6PR12MB4057.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yfcRVUb9t7ENdSRtUmJjlb0O5x/fUtBWvXIbMZ8cOc8pBxN3fBI/UXGiCXfNEmv25QnlJYjwiAkk2P/8P8AeqWR3/tBEBACqs+2LSiw1nEVv+ksM41Uz5y62I59J1Ia9Sc0hh5BWXdr2rejflBSz0fYBHzBlQAY9TeIaSVBzqaBR4H5ppG40IetAyfAMtFqOxytVspytLB0iO0Tena+UQZ250UI/WTFSyheCNTIfGri895myUFX2FhLsbGaxWVbemyOmKVDeYhSh4wbhqQlN1UROwDofWA1FBlj3J7z+7Njn9ZkoM4ABJdRCxGBRjfhUGOj3dvH7K+fKSWlzPE/A+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(36756003)(426003)(2616005)(316002)(186003)(26005)(9746002)(33656002)(66476007)(66556008)(86362001)(1076003)(4326008)(66946007)(9786002)(83380400001)(2906002)(8936002)(8676002)(4744005)(6916009)(478600001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: SLLAtL+eDzJxVPi/eNYxTucKggmMjuCR0259CN/6TI0LmSKLRXugLvchkjj+kMqyBCW6tPGWcEa4AuRXSZEpmzk4Xeo8Wt/XaDQcwDQfO+nketdaHXR7PcSsm+u7hRaTNvriBMJNjusPDHyoSHbo7Nchji4mjz54oNbdmvNf3iWgTjFa/yQL/DT98rKzO3XCUx14uFDr+yAjKRcw+y9VgmNg00tlC7DqnIhaU2YoF9pRAMKOBCfXC9f2cnOtTfdddG4Tt+F6WXkMFOCuIpEJStjRgVRIMmho46th+iCnc1rOShf7wkLACeuWsia8hYMJQrN2RxC7nywK4AVWwgS2YLnfubf3wynRv78CUZaqX4BdX99CwsOei2w585NlpY/qk15z44SSBKUlFnM9S1zmwFzvzDF0nUnd6qv+0gcx5E3Ny5Qq6j7g44agPb25sPulH1c8KXdJ3rHm6ogv72WaWLWEye6+jjBk969SEulMv3JqRQVdaUMKZ3VRQaoPgj2HhDdiRU0h5pC8uleqcOX4azR/pFzSuii34JTyFj+JfnZ8kmZ4/Ce2MG1uvqTMN4v4FzBpv/G1x5umykaQlF2jTmcQGLrfJ3LqK2N8bG7jSue7dMq89pNIgAftSwfkrwz7IWc5/SrVRGkUcXeTcWu6+g==
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f3d1eb-c710-4708-440d-08d8491909f7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 17:05:16.8561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zM4ulgI1GrD/P2odiqNx9rOsjtq+BLLXxUy7MxkbdtLvbP1kQohZ6MgCi4OCixyi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4057
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598375105; bh=VOTQbpCSMLKdQZT0yQmqLDjcfdbh3HprVbACXGdYe1c=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=e6Jiby8dNP/1QW+mpwKC9ecTSqcFBQ09ARM+Y4Xmm1hYYLkZWinzuzpvhsYdr3ZYF
         sgRI7avUBvMOwmhNELMiV5g7CT6IZsyVkkygK7y0GZFOC2kVbmtSASCitNkp4w4pBK
         kJaVDVydkRKzI2KUlu8V9D2nBvJglMB2ao5ft4O7eRXexTsH/Cfb0aqRBppfjrGC23
         d6mVAinYEwKjbZd048ojdgxEf5MM6zQoJncDiJcRdQUclj33lmLdVz14RzF3zgPb4l
         2Wmpv+J8+MvF1T5c7Xv5luabMvX4qRTVNkqfyDKzJMNpi7gWyvL9PJX1dDQD73Bzat
         LOs49udW+PsBw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 17, 2020 at 09:53:05AM -0400, Chuck Lever wrote:
> Oracle has an interest in a common observability infrastructure in
> the RDMA core and ULPs. Introduce static tracepoints that can also
> be used as hooks for eBPF scripts, replacing infrastructure that
> is based on printk. This takes the same approach as tracepoints
> added recently in the RDMA CM.
> 
> Change since v2:
> * Rebase on v5.9-rc1
> 
> Changes since RFC:
> * Correct spelling of example tracepoint in patch description
> * Newer tool chains don't care for tracepoints with the same name
>  in different subsystems
> * Display ib_cm_events, not ib_events
> 
> 
> Chuck Lever (3):
>       RDMA/core: Move the rdma_show_ib_cm_event() macro
>       RDMA/cm: Replace pr_debug() call sites with tracepoints
>       RDMA/cm: Add tracepoints to track MAD send operations

Applied to for-next, thanks

Jason
