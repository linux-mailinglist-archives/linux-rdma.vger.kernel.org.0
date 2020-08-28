Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787A72560BB
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Aug 2020 20:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgH1SpD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Aug 2020 14:45:03 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18668 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgH1SpC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Aug 2020 14:45:02 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4950810001>; Fri, 28 Aug 2020 11:44:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 28 Aug 2020 11:45:01 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 28 Aug 2020 11:45:01 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 28 Aug
 2020 18:45:01 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 28 Aug 2020 18:45:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLg8sF7IdaEu98JjxnSyLmjfeDvct2glF3VtmkZEKefsV0vK1tdAjm0EGElq52SFsbxkrOzziqziLhZk9Or9I9rgY7CQl/O4aJAK4DEYaAN9hBypd8wapknNcbCWt76fkBnES74fXdYpQJBx4K2NP2Wl6AVtHdT3HRI1vE3kxIic+clL6FTtTL/ktqW6aSc2i+uZMP24Go9Jg6s6AOQV69z0mk5+Iu2Bv6enf+1aotaUxM3quYndTM2W1aH7jKM+ECfDTZIo1LuTtAF5/ljTgX0PlldpMSiS0EonGOyx32RaTxN14WElPFF62NHbmMM+KXTKpngsXCAwdQ3wYxSVsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cL9Mgc8C+eZ2pEaShYsBgs6XSXoSfP0nm/24kyUQVBQ=;
 b=U67m5F/0vJTzZwUUpG9Btx4mttkQ5569aVmccBIP7Z1gx/3eEwBagIWQ2319LpioBo7KGzyneUuvIkaiE+uX4cIuxthddYhIfURcFKSC1fRJjTZnISstRbfzyujHHfESZoUM6C2G9NxqlofSume+N9LOmFR59SticxX3nHIYOHaSvnqdvD9l5wTdmyqXOLkExxWyAJy9rMLW0HtGFnExlfG4GikV06y+b4M7xQpOiarwyGfi4ChSlluwrFycZjs+8yPeaiv+APNpQiltm6h6Y8HyniieOzwY9i51E5bUWZ4yZ1FwEvg/kNdAyEwWgdqJHRLq6Netmp2yoMFD3dKscA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4299.namprd12.prod.outlook.com (2603:10b6:5:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Fri, 28 Aug
 2020 18:45:00 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.032; Fri, 28 Aug 2020
 18:45:00 +0000
Date:   Fri, 28 Aug 2020 15:44:58 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Parav Pandit <parav@nvidia.com>
CC:     Leon Romanovsky <leon@kernel.org>, <linux-rdma@vger.kernel.org>
Subject: Re: pyverbs failures
Message-ID: <20200828184458.GS1152540@nvidia.com>
References: <0c4cef74-21bf-19b5-1523-6fffa450e764@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0c4cef74-21bf-19b5-1523-6fffa450e764@gmail.com>
X-ClientProxiedBy: MN2PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:208:160::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR13CA0020.namprd13.prod.outlook.com (2603:10b6:208:160::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.7 via Frontend Transport; Fri, 28 Aug 2020 18:44:59 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kBjMw-001Fvw-Bu; Fri, 28 Aug 2020 15:44:58 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 499d3c27-f9d4-4678-9e16-08d84b827790
X-MS-TrafficTypeDiagnostic: DM6PR12MB4299:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB429987F6BA8E70FF85156B07C2520@DM6PR12MB4299.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BXpDLzDWBysxuKp+M6EzD4WQ9D+DHs8Hsbo1Z5ac/LhFsuKoxm0fu7ga00cfJ8Ywr00F5k3pnoK73TaHnpz/hp7uP4FE7ocWufjiU1ZGpiiqQrutY/yWp+JjnmKqT1VQBX3nM6kRgJr8SBQXwtem0xm6jI0GdvvhUSt8ytzzCdNBYvlrOG1oLA5zLpl7gq1H2eb6WewuGPjLHHYivUs/cHnhgpKX2il7HSMmBM+K7cF0Y4a8BtiiKVhY67ufIY1qMswW2gpnlsWbTIShoKXht6qPpGIMRGRbYQEJMrqGfiQex/nqBSsQ2FQCS96gwVgVnYj7VuGgZkBTR61hgmZ0iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(36756003)(9746002)(426003)(4326008)(7116003)(5660300002)(316002)(6636002)(8676002)(8936002)(9786002)(83380400001)(2906002)(1076003)(33656002)(110136005)(66946007)(186003)(26005)(3480700007)(86362001)(66476007)(66556008)(478600001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 2/4qUHIDt4pQYCqoSvFV6oXnqgDfXnLAEWpfhPfZ8Y2rr7mEMQ2D2HpEMBDIdmy0rs1OTq1VSpgVHdb1EUmao8b4yXh5jrY1thq8Kggl56O+KzhKrChmgydTotTQCvX3HQg/HfHIxDDf90s0VZkTKR3iocc7pP2r0GGvPxvUzxOZV0lloHuBnheISlnuEsIAliHh4uG9ruAAVMJ8yufzghJuFg31JNa/r09rVUbkHjNT900F9UIOqogdWutFUdHlnFhHEOMEim+zw3MzeJp3MJzJ/fMsy/2D0BJnXXckiRoQjNbDHLp4BwZ+TO6EANS4BOS7nBYgaGT636U/x66UGNijgtAWzCk42LDVEd3RzUra1gkM64LXhas1AHY7OJmd0rXP9OziFZ302eES/mVnAn91hjTJw5/kYPV2qsv3hzClDx1THpNowAZcKVSyK0bdmhp5Zuppjly01AJrghJVi52RXZw40ehY17qjFw9pcttoFikWEWbwVhyo+642iCFEnen5xHCILgaEsaPQZ6epZvfBa9zYRzwaghghuek3G9rd8KQj1CORY41GsqS2pakA6/vHdN+x1GVsLFWzXwh3U6UW/esY5dnY6akdX1tey6tJspftUJGYruIL1rUYYBUlI/F5XgIkaDmuZ9RSbe96WA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 499d3c27-f9d4-4678-9e16-08d84b827790
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 18:45:00.3539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9G5JzyndN6q7PCL599AQ2xpVc39ljkhHDZkowVwvDCNXnMNcBqG6UR4N1/a+3CBv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4299
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598640258; bh=cL9Mgc8C+eZ2pEaShYsBgs6XSXoSfP0nm/24kyUQVBQ=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
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
        b=YbmiWa6mUqTS5TTH5fyFKdcE+6sOG7f7Qxrp4bZ6Z2yGoY/MHPJjRfpskUjT/AF5/
         eXvAtfS4o1FhMA5cyUUuHdyBFWTV4B72Ddbaj56xULAEfrdKUGJXHe7nmpNxP4srIH
         iJLDDctmQfDdOz1y1tM3fXEQfiIEWRlHrMk7wuaNfQ6UG/B6zsa/nnDY4VbYxsB5d1
         HzssBKsHyxHw/viGMDrkNvil5z6bE7T1U0sOh6WPDanWvdRxAnStcruAQlFU1Fbvmm
         NAB7BRzm3nOnacI9rLB7BrhY5P9yNGfdrhfs3UpQCBCfatO7nsLuFtXDhWp0Xkpa12
         4HshCna4W8C+g==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 28, 2020 at 11:51:07AM -0500, Bob Pearson wrote:

> I have been trying to reduce the number of test failures in the
> pyverbs tests for the rxe driver. There is one class of these errors
> that seems to be potentially a design failure in rdma core. By
> default each time a new RoCE device is registered the core sets up a
> gid table in cache.c and populates the first gid entry with the
> eui64 version of the IPV6 link local address. Later the other IP
> addresses configured on each port are added as well. It is expected
> that the default entry with sgid_index = 0 will function as a valid
> source address. Five years ago this probably always worked but more
> modern OSes have stopped using this address for privacy
> reasons. Ubuntu 20.04 which is the one I am working on uses a pseudo
> random address and not the MAC based one. Windows and IOS also
> apparently no longer use this address. The result is that the
> pyverbs test cases which use sgid_index = 0 in some cases, and use
> random sgid_indices including 0 in others, fail. The most common
> failure symptom is that when attempting to add a remote address to a
> QP (INIT -> RTR) it is unable to contact the invalid address and it
> times out.

The RoCEv1 GID is formed as you described above, is rxe triggering
some RoCEv1 support that it can't handle?

> A better choice for the default GID for RoCEv2 devices may be to
> just use the IPV6 address configured as the link local address for
> the ndev. If they use the eui64 address the result will be the
> same. At least some of these OSes claim that the link local address
> is temporary, changing periodically. This would require tracking
> IPV6.

Certainly RoCEv2 devices shouldn't have GIDs that are not matching
their IP addresses. Otherwise it would malform a UDP header.

Maybe Parav remebers if there is some tricky reason why this is still
being done?

Jason
