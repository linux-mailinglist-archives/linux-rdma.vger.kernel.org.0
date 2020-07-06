Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C4D216254
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 01:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgGFXcs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jul 2020 19:32:48 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:29340 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbgGFXcq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Jul 2020 19:32:46 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f03b49a0000>; Tue, 07 Jul 2020 07:32:43 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Mon, 06 Jul 2020 16:32:43 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Mon, 06 Jul 2020 16:32:43 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Jul
 2020 23:32:27 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 6 Jul 2020 23:32:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjXg9orIOAk/mXpNuwnlEMxChnof1CB4JGWVeLf3W7Lgp1E1X2gAnu9csDGoKz3bwlvywKfDbWMn+jSux3Pntuok2/wXFG7oi3cTxeuFnKW11umcH+n3IB4xSAbNOKX9wf+EvoG75i1qB4vyX0dOUBQU5L9Xc6JmOzZrorSYazrzeg4i8QG0Z+1rkWf8mAYE8jBaupy9q7MHRLlggnaw/oWlghIWX/0/gyTacRMGJ2/09MEk7i99GzXp+aRZp2i4y559fA4+jITe8V0dhYlsjlT76iZXPdj4JXTRNfTfbITgRgvY8tQQZXwz1opvmx95HtO4vGBEJSMyMi8flR7amQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlK/xaRrNWsTrAJOvZjacaisuorHJUrmZLMkw3BWGyc=;
 b=CbwDlLYv/A0QXhwCkuTrstdQnPL2JFogiRBaW1ZOibpX6xzqqseoVW/WaYXgA8I1YSmThrJIbnOyCnCX3CwaXQx22hrCUJIYduXY8HCpFymIk7QCpChv5UIkm9wIVkyF7kSRzHsakSGxXzW7aic4PNlHvRkQOE3+yRCm3LD0zwN8VnSqtu7zG6EDDpP0+m6ssFLIQkmFF+faz7g+WhTOWf3+/jNSVS/Hd2US74s+ZiE5Rz4hJYGhF/JSa3tQ31zm0m7fNo4izdSXiEp2km132hMdDnIutBD6mKhbTqeKAktInADEldlubR3B7k3VEZifzHBYmxAHupea0waogmPjxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3116.namprd12.prod.outlook.com (2603:10b6:5:38::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.29; Mon, 6 Jul
 2020 23:32:25 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 23:32:25 +0000
Date:   Mon, 6 Jul 2020 20:13:50 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Lijun Ou <oulijun@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-next v1 0/4] ib_core allocation patches
Message-ID: <20200706231350.GA1307144@nvidia.com>
References: <20200630101855.368895-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200630101855.368895-1-leon@kernel.org>
X-ClientProxiedBy: YT1PR01CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0055.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21 via Frontend Transport; Mon, 6 Jul 2020 23:32:25 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jsaJ4-005U3e-Jt; Mon, 06 Jul 2020 20:13:50 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9016543-e3e7-42e8-c59a-08d82204d6e5
X-MS-TrafficTypeDiagnostic: DM6PR12MB3116:
X-Microsoft-Antispam-PRVS: <DM6PR12MB311641084A917DA6F1C6C10AC2690@DM6PR12MB3116.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DHC8C6PN/HEdReYLLIpXQUUCCr5Io3o6S54S8ln62Ftid8scPmASDd/Tu8wc7NqAzwp+1sbtP9agBi8aT1124++xlnwlh2+RqTQzc8ctqGP4JrMGgnwRIuxpMckRwNd7QZBavVLRN+VGuXaJvoFVjaXPjilLBgIZNDzJ0MCVNuhUuiCYfSwAL/d1Gq19psRz5oddPOuZRkDi2vvUmAXtdy4rDG4n9LKCAgllS1eWZ6J4+g8CqquxPugTKFQAgU+6Z3lWS8a4tRRWpF9HOhNusxUC0xMRXWSECzZKWdtbudbXIUgPe3DjoTUn0KaZ6o9HY9fkg39bruFld6IORNsf14k8SFxc/QSoafJrjdJ3I+YrttcX0SAeTD4WBJwvujQHBT3BxgCQQjxlkzt6Suy7sA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(54906003)(316002)(2616005)(9746002)(9786002)(426003)(966005)(2906002)(6916009)(8676002)(7416002)(83380400001)(4326008)(26005)(33656002)(1076003)(8936002)(4744005)(186003)(36756003)(478600001)(66946007)(86362001)(66556008)(66476007)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: jBNCDreWe2dqUHscvOGtNgrJMLaijveO9uPUs84eyTZueq1dMeol3uPqDuVSaPHXmpF7VS/JNxRgMn3mtxOEG702xGDpL2noAZUHJc2pwE7p85TUzI2puCzU4pBVJHW/MaatJ78TWhVvFz6H7sIKO83y+W54/bR1mW9iw84gc4G7IqujHAZld6OojXJKfaOH0uAXdNBRYB6L1u8LSW5gEPdm9kSOQ555Fhcm6QlT7OaIlHuSuEuRlcp4dkrSKYTDr5dbP0t6aEKH1/Denh5JraW7gdaVnwNPum7SCBzNq9Af4wHGzg79sshu7I4BOK8/CaeCVe5GZrRAZgFaZ3dshyDZlpa7K+wOQCEK2XyQi1PEFM61OL7uiMY1GEqGNUcA6v+OAoBxAnoJIcvHBKQNX+banpAluOoGjIqwLjHuKbcUO5BCUCvkZ9r/dJ1+nCXv+/plaNYi/RJB5AGh8bT2Jkx7dG09OP65Y6IajPLmIEGIScMVLzWyKdJS+afpO69d
X-MS-Exchange-CrossTenant-Network-Message-Id: d9016543-e3e7-42e8-c59a-08d82204d6e5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 23:32:25.5090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ncewO0txKrnce0tqVcfPt7LR6jr9Js0AA/qJ/8bIb+SSDmr55Pi9KbFXWR6jj9Ey
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3116
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594078363; bh=VlK/xaRrNWsTrAJOvZjacaisuorHJUrmZLMkw3BWGyc=;
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
        b=EW5/UN7wavCxTDjBuQLiecMNBYErv/DSYIJSDSfNAorho6LfsEt1vmnN8RF6JGa0R
         B5bvaec/26uDM+1RCAtH2iVS7er5/DBGGs19wwLZpYSaAG0YbYZ4x4r1wevj6JPcNH
         oyv79luHmM5l4f64ZaW5dPDMZTKUVYbMVZjCLdrBeKBnO2947VL/I8bMS/CMrG5biD
         Ayc9ziJk+T3W9xsE/heSW/BQzG9IwnTZRMtKV+YclCi4s1kcjgPiXKfdqiWpkSG3yj
         DRFCcPpe2wh6txe99FvIQflhxjkjAHxfF68C5vHzcG0Wgew3ULdwRaxMdzXuuLnfZm
         EFCrObKcK+EDg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 30, 2020 at 01:18:51PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
> 
> Changelog
> v1:
>  * Removed empty "//" comment
>  * Deleted destroy_rwq_ind_table from object tree
>  * One patch was accepted, so rebased on latest for-upstream
> v0:
> https://lore.kernel.org/lkml/20200624105422.1452290-1-leon@kernel.org
> 
> 
> Let's continue my allocation work.
> 
> Leon Romanovsky (4):
>   RDMA/core: Create and destroy counters in the ib_core
>   RDMA: Move XRCD to be under ib_core responsibility

These two applied to for-next

Thanks,
Jason
