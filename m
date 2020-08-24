Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E892506BE
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 19:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgHXRmh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 13:42:37 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15025 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgHXRmR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Aug 2020 13:42:17 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f43fbea0000>; Mon, 24 Aug 2020 10:42:02 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 24 Aug 2020 10:42:16 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 24 Aug 2020 10:42:16 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Aug
 2020 17:42:16 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 24 Aug 2020 17:42:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMLren/pjtOE1M4UpjMlxEW0hNK8j3sfLKwxpGtddNeERzXgXoANO9YEVuQBrBtQgk14jYhUNbtKY5cC+VgubqiUhKS/oiF0caGUUr3QsMQw12ujYg37Xe91tAuu1RJ+hCkZFuBu9RN58/idY9snawsE7gknA6dcCdX6Rjb7gX/MCIfbBZJ4A76F7gjwUAECCFRzAGsH8m106hoGbdpd4U0G6oweYiA6q91wpLrxhlWVwPytryjWeeobMd3lgK6+V7G2vgSdA7arhuW9CRSdLKeZDrkevtdOzS1Iw48rtbbjXYXCk0RotwVdQEhW2I4tVEUud6WfDfWTgmxPMiL0vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdCejBpDUkwx8vGzP7mpYTdP69+cwrGehKfLvaV4tTo=;
 b=jdzcuStIPm0kb+LmRPcgtT3F7X2J4TJMkw5BVYWT+XZBw+wLXHkMsNFj/aSCAvovqA8doljxbMFW88u7QK+Bo5QrDky2PtT3Kid+MqcNHMRsKRq5rB1IyvdOy4sVbrwpywc+vMy+S+ZTnP9ZmjUGW7ieOaMF5Kd4aJbriWv3Y29J+6i+CsbwsRqCtI0XezxPay7pnNJB7bglU1ee4pnokR33OVWkpYaHXI/M3olTwQITzdlrylv9wJ13t5GoPHOI+ADPIEqhnxKODfDV1n40nZIx9newjf0UEBOoSFq8bT8xAUrsbuFKf/c1aCNjtwL7nu6we29wWwNJRApkwNeCFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4057.namprd12.prod.outlook.com (2603:10b6:5:213::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Mon, 24 Aug
 2020 17:42:15 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 17:42:15 +0000
Date:   Mon, 24 Aug 2020 14:42:13 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Chuck Lever <chuck.lever@oracle.com>
CC:     <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] IB CM tracepoints
Message-ID: <20200824174213.GA3256703@nvidia.com>
References: <159767229823.2968.6482101365744305238.stgit@klimt.1015granger.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <159767229823.2968.6482101365744305238.stgit@klimt.1015granger.net>
X-ClientProxiedBy: MN2PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:23a::32) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:23a::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Mon, 24 Aug 2020 17:42:14 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kAGU1-00DfEJ-AB; Mon, 24 Aug 2020 14:42:13 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e11c2d0f-933e-490e-44c6-08d8485509bd
X-MS-TrafficTypeDiagnostic: DM6PR12MB4057:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4057176382583C214C927142C2560@DM6PR12MB4057.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XyHOffj+mJ5F9shg88bklq/6pldcDeD8XDTAFvFOQzSDVsWwB/mu1wAtPavjEYRxti0xPCiE2WD23vnQY4VXCL/UsURtTIe0Ebl0sYXDdsf9WIYAMx3xm2FJs2k3D0nv7azqBfG4PXuVQ0I7S4roVb3pmwYdi4wFdvRTncOafjx0ficen9lXZu4YyVh/oXsfYL5Q1cUTZ/qALu7qC9GhtK3gUPXASRHUYahMc8JCvxTEmGt0qZXoJPUxZ67EdPXP3EYtH5FFVwJmBfzVwV4YUv7QaafHjxhtoI7cP+XdOi6IUC3LzuZT7cC3esu6ONVd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(36756003)(186003)(9746002)(316002)(4744005)(478600001)(1076003)(9786002)(86362001)(26005)(83380400001)(4326008)(33656002)(66946007)(66476007)(2906002)(66556008)(5660300002)(8676002)(8936002)(2616005)(6916009)(426003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: IDCOba8eYYGwp7kd0Xj1X1PRN/lJuR7mN2urJn7q5znyoLAOWubvTzONLfMSN9Ok/iByi2Oi04AWis7NfdOGBGPGXEJDOw4Xv+Z4gGvd8iUxLI7Kz70Np5hNtWAhuxXulALbeYmMoG5NZTORe3N6rfFpmZQvqoPb1pi3SvCFzto6WlsmzHE0wQTCtas/PJRh5Rrk4iTpKyEgaGIiSWToe9HOSeIcuuqPyImZGtpl98l6fhQh/jLMhFwOdETsT21JKehjWpHpvo/E53PljisGCipVS7d1gf2IyKo4OjtuyL4A/pPb2YUZqTLDYHtZqoMVHbyAXzJu/2qMztw6hdMxA0wIY3R3iCM0T/hPA1sGo8Y2RyYoBQUjL8vDc9P6aeLDwkgKp7plVwMM1WKb12J28aCFArz8E5SZH5uMa27w8b6auARs207VoCwDdksKsGyXwrOhInMIkgtw39EzRRcad72UD5I/NIgWu/6InsXQFwFatr1li0lnNCqj21skddV47UwIcYuOIR8KpC8G7gusO+qRGXAUg76hc9le5wQo6DzSDtW48V5Nwb7CRUY+2gc1PQMpUOIOxIEnrIpYLrERDCerjFm48d7gBwZjyD8p9xI1uhF0u1SlIq6HTMXryrQAmkS2IlZHSdkccOcCU0qOVw==
X-MS-Exchange-CrossTenant-Network-Message-Id: e11c2d0f-933e-490e-44c6-08d8485509bd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 17:42:15.4818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V7BgmmyKZS6lZdKoNoYgG2I5Q9uprLL1ACnSj7F19hCgYIwtMhUkbAXi8qBkE0m8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4057
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598290922; bh=VdCejBpDUkwx8vGzP7mpYTdP69+cwrGehKfLvaV4tTo=;
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
        b=gov2YSe27rK2n53woy+U2Em2ZAKZiHJpqEQ4Liq/1hDCWGMdPE33ooG9LLPBnl2Tv
         QXsEqQN2Hn2GaZnH4eMDil2Fo1MQhBiGI7JsrPYgz5UHduM8Kg22kpCwRPStq5ie7/
         KGI2KJqbUfppbZN4KXOT0760RiixSYmtbydFXaOcNpV7JR1OhPvC/A7yFTphfA1+KV
         jfWMF7IBdAJWKTIiYyh5NHWBXKQ42ZFsaF7il0mo1dxmNqaTxCFCZ0XtFizNeMC+E5
         k/ENzIuR1vGIZx2xnS/AnXgCFyChkTyLmb7eKJLrUgw2McphRaLQeHl+HZavk0+dyR
         vf8Ynl1mpUokw==
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

Doesn't compile:

In file included from drivers/infiniband/core/cm_trace.h:414,
                 from drivers/infiniband/core/cm_trace.c:15:
./include/trace/define_trace.h:95:42: fatal error: ./cm_trace.h: No such file or directory
   95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
      |                                          ^
compilation terminated.

Jason
