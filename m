Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC2B212B0E
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2020 19:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgGBRTP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jul 2020 13:19:15 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6748 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgGBRTN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Jul 2020 13:19:13 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efe16de0000>; Thu, 02 Jul 2020 10:18:22 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 02 Jul 2020 10:19:13 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 02 Jul 2020 10:19:13 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 2 Jul
 2020 17:19:08 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 2 Jul 2020 17:19:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nR7BMNLo5JC4OqGKefbqEzicXGcaLa6K0VWmyadmZv6P41DtXkwihpXXQ4wNNdbB/cnG7eSJXFk68pHQKwkvIQjHkJYIFtwh8+r3qZffB5Bv568qMUba/AuQWS2ZMxhHwg8dts0/db0b3gK1NMWCYyeoSd/5zMASTVj+XiuuVRd412rqoj/HIWyUE5Dm6crkiWHJUmOp6TERurGuRf5/ncppm7iPeK08PbhKOIr4yFlWeFcyMTrLgxciN4hGjIioRMDStIEwuKsE8UX0Qe+KAP4fT59GqbCa4MHnimCz0GlUtJJeJfSBtbhay1sEKCcsfW/8BifS9T8CNENPaVypHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOvGuul2fMFZkNSBL4hQE0nGlqQA/TO5uh7h59zrO4M=;
 b=kp7j3Hrpuo+RU/rC8zXHImwaKeQX7h/8PkTPC4W7W4SA6IeBnDj6vSzA+bsnAk+d8rnLkOiui31Kc8PwukGa+0jtn6tBYDSZr+eJC/GpTAEr7KstrseUO9SHTMTUe6QhzinXH0AvvX1G3ovloJXVETWbjvi6eIN56/yHR6QxcNtDhGluEOJHL490wc2KdVXJlTy4saamwy328Zwjpwau1/kfIF/NzTEkjQiEYyOs8ASL7s1SdHMAHV7IdJh2O8pJlzopuEN3ODZqvXFdL6OJCMv4lDf9ODu4tg//p6oeqZaFBJh5+wH7mYoKWuelrvEJ9GOhnYaaSh+o9OkTrbtMoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Thu, 2 Jul
 2020 17:19:07 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3153.027; Thu, 2 Jul 2020
 17:19:07 +0000
Date:   Thu, 2 Jul 2020 14:19:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-rc v2 0/2] minor hfi1 fixes
Message-ID: <20200702171902.GA711842@nvidia.com>
References: <20200623203524.107638.62465.stgit@awfm-01.aw.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200623203524.107638.62465.stgit@awfm-01.aw.intel.com>
X-ClientProxiedBy: MN2PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:208:23a::30) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (193.47.165.251) by MN2PR03CA0025.namprd03.prod.outlook.com (2603:10b6:208:23a::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend Transport; Thu, 2 Jul 2020 17:19:07 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jr2rW-002zBx-7i; Thu, 02 Jul 2020 14:19:02 -0300
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39e6c335-9ebc-4c84-152e-08d81eac06d6
X-MS-TrafficTypeDiagnostic: DM6PR12MB4041:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4041002F45ACB0F190D0F78FC26D0@DM6PR12MB4041.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kNVBu7WqbRtq8LcV3fRyDHf46rRBlQNYBoUXPArZIakgr/DKasvqBFI+ZLKqFnl+nxMzZgKHgMTDVfFFHueL7472onQEqrP+StgzJzdHezlvWKBmgCqwhA2GOUzBsw3WUdA4k3LNQUdq2UhzPuWZ3t19GmgzLFQ3T5mNNVz5gKRPWQ361ZYgu6+S53rswCQwT25Wxn0uwoWjXo9Wd1RDkgJbGtJwp6sVUEH2kQ5QUgM5pqrnVI0X6+LlSUCwA/da70GX6V7iUYKVdTMkHNKzmLio/EeDf2z66h6gSfWC092G969cu/Bl7q1hO3Dvxe+55eURPKg3YRAMphPKQu9tAj39US20m4nU9wJCcdCgvm9OYrJ99EcKiI+0b0slfL6fvtbVtPIKZDIqQpWsM6nahxXzVGbisPm5j00qCXHUG4b8fGyb8MPzj5tArnL/c+Hb9MRPCruirncEa/4WVIYNpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(376002)(39850400004)(366004)(136003)(8936002)(8676002)(36756003)(5660300002)(66556008)(66476007)(4744005)(66946007)(186003)(6916009)(86362001)(9786002)(966005)(9746002)(4326008)(2906002)(26005)(426003)(33656002)(478600001)(316002)(2616005)(1076003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 348EGsIbNaEyhMAulYfqSWmj9o40+Yoxn7bwJ0lQICvPgmJRCZWS60DCnBpWYx7Fvj62/jr3pMUMuZ4zApFegSU+Xrt++tHWOfiLQATwfqbInC8iZ+trTSJV2w3svVGxCfMzh7FNa8sV1ooMFnuj7CyyHbOEECHK1QJeoCYFdrCKFlDbkICzqtMCC2NCjhGY6lrk9b3o/b3TYb1Sz1YvXXC8FurhzzQKwGBxlxs2m0nKZVAaPnD7GAl3Dt6wj0d335Rb9Jipnp4bG+NZl26EyAxg0pVQd5WEI0QnExTORWceqFRdU/ty++cZj+n5qCkD4zPs+pAZk2diU3E4GauDXvjzuTiIcgdJPAwCz+Tol4PyslvX9Pdbr5qHKPpCE1I2SGesTPax8ykBwFPUCekZSYVmrcvqj25OgZVMu9VJ5doyMS1UYso1ohMrIwu4JoIppsVYAM2t6aIT8tLm50Nj/5OTOMYxKJAjo91sOCvnv1t24naIFp9SIDo3N52zJ6m7
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e6c335-9ebc-4c84-152e-08d81eac06d6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 17:19:07.5454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kYkQJ2+JDiCGou2FcsWNComVWPdeINH9iOe6hcZ/tlbWYC/VgBHa5b4doXqApu3D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593710302; bh=oOvGuul2fMFZkNSBL4hQE0nGlqQA/TO5uh7h59zrO4M=;
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
        b=QT6wGs3cjdYmjGxmH4Xvy7+bQ3xOPgXrq+EEuINytNPBK92jYQnfRPXKzRm+eLPVB
         /XYNED3yGYLRMktazMTt84CRLH9sM20yOKRGDm5ri56F9p1eop+WM0zJV9K/6h15j0
         VKBdxMantdfF4CxDuwbXapg4zXHWeE0uOrUk5DtdY7HA8CPbfgyTSoP9zffcBK951r
         68rekx/kwe+5scmLAP7PBkz2yvLh2WC7JF+IO02RZZYzQDK1uh84uXr6a9cn9vf3rR
         7BhVqzA3MV1mZL2CwA8j9g1jJ8WBqnbyGkwn1xsLU+BozUHOT+bdhJNIJaVVCl+m9g
         BjBq402YzmiPw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 23, 2020 at 04:40:41PM -0400, Dennis Dalessandro wrote:
> This is a follow up from [1] and contains the re-work Kaike did to address
> feedback.
> 
> [1]
> https://lore.kernel.org/linux-rdma/20200512030622.189865.65024.stgit@awfm-01.aw.intel.com/T/#t
> 
> 
> Kaike Wan (2):
>       IB/hfi1: Do not destroy hfi1_wq when the device is shut down
>       IB/hfi1: Do not destroy link_wq when the device is shut down

Applied to for-rc, thanks

Jason
