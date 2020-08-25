Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55452251A25
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 15:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgHYNvA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Aug 2020 09:51:00 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:55033 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbgHYNu6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 Aug 2020 09:50:58 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f45173d0000>; Tue, 25 Aug 2020 21:50:53 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Tue, 25 Aug 2020 06:50:53 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Tue, 25 Aug 2020 06:50:53 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 25 Aug
 2020 13:50:33 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 25 Aug 2020 13:50:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YeEW2u996qBV96wKIW/t8b/mTs/O6ZHDkA+/1bi5l0Is/D0gwz6PeA3Pp0OXTMkQ3GG3yVFqnYU3lezYEW1y/xhKj7qFQOomR2eB7eBi8OeAYi0lKCZ8cNVJOdQG8v8U34R1f/B6aNxHH+iQjVO9vNsHqXbzkkgOdAwsp02dh3pxT2vrIMuj154Pm3NO6A01HALbn4ma3rSZlpomB6l1OFsjBTeqsbmvz3Bmorsq52ag4ofXfCoRBGojjQryLIEo7KWsWBwFzEroUNF18JzHTHX8EX5hU7MFvhgi5kt6uuqMNA96J7mdasEWrdtDwtcqo+QS/3ro/KHj9kB7nf9R3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOvQXLcpCVNviz5WAMcpuvFSPbqAFmtyBEfQgJv4Bfw=;
 b=inuCQMZ0oV/r67pnVvtFcUfImnCTKSdw9f5csi6nmZpqgGm4aG4ycLhdfx5GuTpJt03jIfol4acJy1Thjf1j4yoai+m/4eZZaWJrQN5PxQJTlhqrBmh1hT/HaGrgb5whoRw4ZiAYyN/0MhEHmOd9B7xd8Fivx5hVvU3WblG6ifht+ZyOU5ejSlyUGEXpy5A3UH0jbrXSdKGEQssS/UAFhdAg41IJb0HIy1fozWFyeZQVDb+QbYN2hyupeWfPFgVjpZOq8e4yT2gVZeuYUelJZ9Noz5L3f8tlg741OXu06kQzX8mJyM0KXP0t0dAW3rjdxobLhhjTUu0Giu9qTLgiCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3737.namprd12.prod.outlook.com (2603:10b6:5:1c5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Tue, 25 Aug
 2020 13:50:29 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 13:50:29 +0000
Date:   Tue, 25 Aug 2020 10:50:28 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Lijun Ou <oulijun@huawei.com>, <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        "Mike Marciniszyn" <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        "Parvi Kaustubhi" <pkaustub@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: Re: [PATCH rdma-next 01/10] RDMA: Restore ability to fail on PD
 deallocate
Message-ID: <20200825135028.GS1152540@nvidia.com>
References: <20200824103247.1088464-1-leon@kernel.org>
 <20200824103247.1088464-2-leon@kernel.org>
 <10111f1b-ea06-dce5-a8be-d18e70962547@amazon.com>
 <20200825115246.GP1152540@nvidia.com>
 <110cc351-f8f1-8f88-3912-c4dae711b393@amazon.com>
 <20200825130736.GQ1152540@nvidia.com>
 <74f893e8-694a-17f0-dc49-05061a214558@amazon.com>
 <20200825134428.GR1152540@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200825134428.GR1152540@nvidia.com>
X-ClientProxiedBy: CH2PR19CA0024.namprd19.prod.outlook.com
 (2603:10b6:610:4d::34) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by CH2PR19CA0024.namprd19.prod.outlook.com (2603:10b6:610:4d::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Tue, 25 Aug 2020 13:50:29 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kAZLI-00EYtc-1a; Tue, 25 Aug 2020 10:50:28 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e283fbcb-6d89-4858-118f-08d848fdd3e0
X-MS-TrafficTypeDiagnostic: DM6PR12MB3737:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB37375A1B7025EF9C7C432FA8C2570@DM6PR12MB3737.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zV8b0t8mCfCAPdugYbQUzEVmUSlSFOxCIrW3mh/8HFhiwi9ajmaumcdQK2nYPfhChT+dc8jDUy8oqwQRuBsT8FDn/VPed41xvE+6uL2CC6x+PN30VCAnYdhk6rY7MLWWOIxSYp9bMwxZcpO88kkHyxhUC7bTGzk73M+n0ZfoiTGM/Zxn/qnR5Ex5IufjV/LMo0vp5N4Tyz1xgqsi6D3ZoGl59MlPIpED9R72G5B/5r5NmDWwJ2djfqRnu/OnoJwhXWNxR3SVTKwqsvNcjn1gF4yZf4qltJy7U3lDR8tFevyEGdy0EVaqRVoZ3xowDatyGZr/Z8fTSP99OVHzUQRoXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(33656002)(36756003)(7416002)(2906002)(8936002)(6916009)(316002)(4744005)(426003)(54906003)(2616005)(9786002)(9746002)(86362001)(1076003)(4326008)(186003)(478600001)(107886003)(66946007)(8676002)(66476007)(66556008)(26005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 5Vnu+WwYFs/St8Mt5guaM0Zrt5v3arxY3kEEIoBHHAP4aOffS7diJCmU/aBW4xbi6lLPdwnXfp0MdBTOeqRAj3nL75jgH9i4y5dv0Q6xIjFiZDHC65iWnMUt417ETz7eRhGaktY9bL+vgTowQPSyMyrxKTL3LeKNzIPtIbxpB/AiwcFQYlFKIJ65mANSZrvyQmbwJ3jFKeNBzhdtw9jai9Rznh6JQhYAxaJPpEsgbftyG50RvzUUWZ25noLTgbwuLNVSeSxRNw/twbu9EX79J12tfSZesgE695JuQJPa5hkqKFeSh3dd4A+kGvlZVEOjlqazmqL4fdzQJLfuEjK7+/3XSAggLhufqgc+rgMbTYE+CU12Jr10+Tawqhm6LDPpQm48Ceu3raT8GS2ZUvYvffYtcx1G1ErEICobG/a5zo0ra49KxDBIS3iqQrdQPeIHQeTSG/VXmxUJz89bN+4vH4+ZEXPm3HMYlB924TFig5TpZy0fJ0ZyReLtYQWev005L+DocUaKuiqtVQN7JrqtsQBYbPwlSUTlLHqt+JOgydp4WFpUrDQ+wsnKzGOTIbg2x53afxuI41jPTUTYkmjR+0w3cT/pM6FDOv0msCk4u9D83sQikSOKWZvbk4gOjSdfDxOjXSNmoBq/+s3SyE7Jmw==
X-MS-Exchange-CrossTenant-Network-Message-Id: e283fbcb-6d89-4858-118f-08d848fdd3e0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 13:50:29.4386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cM4f7GP2GIk1F2JYH49VWCkWS8BBI6X9z79JMRGNJTSGkNMk5ga3KZWchL/MDP7b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3737
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598363453; bh=SOvQXLcpCVNviz5WAMcpuvFSPbqAFmtyBEfQgJv4Bfw=;
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
        b=qKpaqP9YcqlKhs10YzD+3JzwR/eBqcJK6GeKiwMe+uzyUkVWKsBs1JtcX8PVJZmf0
         v2Lx7RPhXtQ+IyWIoJ3YixMoEQgt8u3crJk5zM2O74buS5OcYNUbfXkZFcV/AwMZH3
         C6zxszSEnKeH92jznC3CrQmRqeC8mFIWqFQVct0yzjsP971XnSVnqxqQ6MJPiIh1Xb
         TxVmQNapWM6B/c0X77Fx6KkqwBNb7HcxpRXzGCMd0EUn94y4Rz75Sr7hLtFlyu53N8
         1JMtTgs60XSbIAP/EYZcIDtLj4WJyqx3LIJcukIYX8LqiMaD/pqNc15wnuANLqT+ym
         5lu9WifBzEjFw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 25, 2020 at 10:44:28AM -0300, Jason Gunthorpe wrote:

> > There is no way to propagate them on process cleanup, but the destroy verbs have
> > a return code all the way back to libibverbs, which we can use for error
> > propagation.
> 
> It is sort of OK for a driver to fail during RDMA_REMOVE_DESTROY.
> 
> All other reason codes must eventually succeed.

Actually 'eventually succeed' is not even quite right

There are situations where a driver object will be created and then
destroyed during error unwind of the syscall eg via
RDMA_REMOVE_ABORT_HWOBJ

In which case, again, destroy must succeed or memory gets leaked and a
WARN_ON trigger. This might be a problem still in the devx stuff :\

Jason
