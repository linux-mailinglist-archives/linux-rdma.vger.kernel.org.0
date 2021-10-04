Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750A7420A45
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Oct 2021 13:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbhJDLqF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Oct 2021 07:46:05 -0400
Received: from mail-bn1nam07on2068.outbound.protection.outlook.com ([40.107.212.68]:28742
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229778AbhJDLqF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 4 Oct 2021 07:46:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oEDycMLUu0Qvjz79/RzgkX7sGWZDfcXipLWnOouxmAnTdL2W7fixM33RjTniwjDax1YRO+dz7h7Dp1AN1gttXWmtEtlnll/MEm6Zac95KtJisFxWFUJ0K0vbAO9sujCDBC1vFMuYJB1Wfsv1ugQv8pThyvpH1YTl6Gv7bwfXYPQA1CQEIix4KPBiTbphRAF+UE2dkAtbdhZ/dyHJ2w7EjMZN3G7qf2Iw8ZqmkqRKItADnMvH6w2KA5/RpZQ/WoHz7f/E2EE211siJMsEWxM2Gbbhhik9k1CN9dBCHIHXamyD7shirRh5CnCLD7Tyr4uC1BAl4vSYjlbQVi4lzoFAzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPFW/Y1DAq8UNOW3jCjoPV3B1xwXIPlnqCXPLWvwTVM=;
 b=GbNnFV27v5vNPn2FUnES9kJDWt9xF/T1GLITF8+lfcIm512kJlvDdLipe61MYXIHFlNeC5lWktXi6xxrp4BPUC7Z/qrqsgXjxH5lNphu2ARjBinje9DGAMQluiOXucy4IvqO4I9YvU3/nEc6QztY5Q8RTsVWm7H404u8q2d1/Lbv3InS+RJFhWANn30T+AfDh0SI/LYgF4eFaiewD1wDd1JFV9CVhnKvigoVVT49jVtKU7ev/XjOuKBkdv4S+qN7r1Lb1VARR6xc2dPOUodXJwC1sENF/JEJ67DRPecU1pmDKpvF+z2U17Shft09Y43cguYuWP2XtwKQ+4Eln3QhZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPFW/Y1DAq8UNOW3jCjoPV3B1xwXIPlnqCXPLWvwTVM=;
 b=qvFS1WSKiWi+Oc3oftAtNrrrOnfZBbC9Ul57QZfCTEtE36JGW1kJNLWIKqv8ljGFYegSZRYNNvQDCsfz68gr+Hqk1+03Y8rcNVUTCfsUdgz0eOsf3BZ4AN9FFVzt+nODLhpRXn5jUwRCpzpwnYd89DBx1wh3EdUspIt+Jzr4Zse+ivlPcWJ09s+H0jwSr8vITxtJh7nRxSenNH2pjp1Nxo7FZrzG7zCzXi7q+rgUeWf5TIErmF4sfODMcQR3u/RlwCFWStCzisatDc59Vm0DBxkV/jmpJREEpOk2xDM+n91P/g5DXM+/xGr1hW+hItTfhwwZofo18Sefg8UHYC78Lg==
Authentication-Results: sina.com; dkim=none (message not signed)
 header.d=none;sina.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5080.namprd12.prod.outlook.com (2603:10b6:208:30a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Mon, 4 Oct
 2021 11:44:14 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 11:44:14 +0000
Date:   Mon, 4 Oct 2021 08:44:13 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+ae4de2b6e34e89637fc2@syzkaller.appspotmail.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Read in addr_handler (5)
Message-ID: <20211004114413.GE964074@nvidia.com>
References: <00000000000073132c05cd496b83@google.com>
 <20211004085829.1015-1-hdanton@sina.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004085829.1015-1-hdanton@sina.com>
X-ClientProxiedBy: BL0PR1501CA0026.namprd15.prod.outlook.com
 (2603:10b6:207:17::39) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR1501CA0026.namprd15.prod.outlook.com (2603:10b6:207:17::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Mon, 4 Oct 2021 11:44:14 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mXMOD-00AIzR-83; Mon, 04 Oct 2021 08:44:13 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41fd826a-b4a0-4717-cb8c-08d9872c4a1a
X-MS-TrafficTypeDiagnostic: BL1PR12MB5080:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB508053D74DB78EBF337E7028C2AE9@BL1PR12MB5080.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n2UmCn/Y8VzRMGgblvHV48rmZUlwrjlgePzqnHe/d4pIENP1fAe4S+VDmCrzcTohxXAMMSUSYLz1RddCsfDgG7qH/Xfo/XLY0hMh5SsgUUQdlWrf9DUYMcwLMvRLXdazTbki/G0PFayoSFjgZcIrDL9zlapJSrYs8H/wvbJSKlvdNiOvLxjukjqoI5SVoI9o3YIjTYq8/75wW951pRmuzYS8/n9mqT+RZ1FO555A59KmOoCRsHWbfCBbOrQA3DSgz3Sl5uFV2Tf0NdJt5RMjIlS3557X5alcu4CoO6FmUvx3HT7dv9VIyjlvw9g3N9R6GWDwBXXxn/3SSfgMwZnLY35OMUOW/s4ewlgJUrxoIrcUwWegwOOjACBPyvtDPXZ4m6Qw6eR6Q6QkTz3xJ7eIsOdj419dM4IDaDZLEKfr8yS+4nhfTkCMofz1xx0GJYZ65K69PXafSZzWLfVznzEKYkHKaF0yT61AITI5LTSy+D2owZy7dCn5hQxVOUnzbVamgW5Ucz5BMWL+4X5iWGmc5G5IgENe6PhOX4C8ABsOnjTyOeNpSqNYz3U8ZZ2KEZLfBld0Xrkd1B7Su9dandOtQtcHIiaE22BLsgJ6BrpH2Vq28PaqpEHFlP5mpmcbz2ns3yXFybO/PVK6hVYDGlewt1TdlUThozx5OI8Oh7XP0j3/3vrj5as19mYBVutLGhWtHEZysuww8jWtBhvimO6LLcXKrHg9eu69vn6RXbpV57rN5NHpNsIzKogX3k6Va76ZPKFrLW0sAMvNC4rI1r16a8ED6Pfzahc0Re3rUSou780=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9746002)(6916009)(1076003)(508600001)(186003)(33656002)(9786002)(316002)(66556008)(38100700002)(86362001)(66476007)(8936002)(426003)(2906002)(36756003)(2616005)(966005)(66946007)(5660300002)(54906003)(8676002)(4326008)(83380400001)(26005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CVpjDFJXYn8wYfuy1yosFUwXdqUFyicQ+dYVH4PC8SQe4N5gXE3hwD/1vc4j?=
 =?us-ascii?Q?PwM7C7MzfqpNF2gu/e+1l9PtE5BULJPtCsZyWkzx/SmRLkNmvF1gRQ9C0Tae?=
 =?us-ascii?Q?X3jLlFvR4Jh6hG13LKm/EJKHNe0CFKCLZnhqvhKmhTD9/gEs7d3eWEcuNDkE?=
 =?us-ascii?Q?g9TMrMbGJggsAWWz7OE+qp5Im6ZFz66fgK9cqSmN7bdcUSvlQe2X+f3046KS?=
 =?us-ascii?Q?hdE6Ql+/q453eq6mKp0Y5zWsTkmjUASznstnqNmStOt4L6yZm8ripSW/v74r?=
 =?us-ascii?Q?CYUtVUR9BKgDTgGGnhj7RAnCO4a0lqOhfpM2dmnqgksqyXWOLVukY4xgIz1h?=
 =?us-ascii?Q?gO7ZFDgFkzsuAMja7R7SHT6+q12cT2CMRc2zY+LKumQmrSxkIC0q08KpkpAv?=
 =?us-ascii?Q?WLDZOv+r8evRXQ4y8GUDPYZPUWLpEfiBe8n3La1HCl0sfsZ3rEWrls1FbwUv?=
 =?us-ascii?Q?pFmwr6bBE2Dh4CVxyeC2T0uzLPi1gOSlklJwb5IDpyKJm6VggogPW//KzTT7?=
 =?us-ascii?Q?0/vnU61c+Eds3M8E0wr7XrOi1vPpkzxYLWrKcDcNUbvA2x81aMInNaaYpPzI?=
 =?us-ascii?Q?gvzbmQmVAdDEP3/XArWFGRCG//7WMzUNfU940opsxDbkeEG5YrCs7waqHuLY?=
 =?us-ascii?Q?zZPiDmj73RpgpluOHYGBtwIDP0ST1Kx50ZckgExPBxwwNsISsQtFEwrWH7Ab?=
 =?us-ascii?Q?3EHEsKx4FJcOMOAxSaI1qNVefalu5YU5C+R4x1gJY/qjavGXxL5zTQLagpS6?=
 =?us-ascii?Q?vM38GktWTg1rwIbWhMRu/SXs/+4Zg+zIABq62OyjU9f4pm49JHNnynCJbKWb?=
 =?us-ascii?Q?UZaOFRHBqc+VDrTPmDWrD5MwNsVqwJTmZpqzi2gWhSnrmuoFh/UBLw5jm4wO?=
 =?us-ascii?Q?eVC83l40Zw9B/Hl6zLm7rBJGxGYqZxPLntS+zxKOXxBZxM5Pk4oKE2k+EupX?=
 =?us-ascii?Q?zOtEMXLxMQ/YB5SvbxZdtHkAz+bk8OqXSvvr1VGDx407j69XX5a4Yg+yoqu5?=
 =?us-ascii?Q?lmpLNKsD+oarahr2b/X4KAKefTmM2KQVQ6Xs5GHHLyF1kyfO4wY9b0yz08cb?=
 =?us-ascii?Q?2pOU/A5xSG2zxgI3WS2h89YVkFJJNM4icaVrBTsol4S+dSzK++F/y3cq90cr?=
 =?us-ascii?Q?wviFEpwE+lil7yvZzXxSc3FGp+0BkQu8Kq/lyB5P1NVR6Z6Tc9vFQNoolNC1?=
 =?us-ascii?Q?0oBylBOELZzavJP3aRPr0n3A53SUCm+bt3j0+veRwZ7dZ1YZ94HLJbszQ1mP?=
 =?us-ascii?Q?MEslDjshm1qLsvKBc01xzT7PHifkOLTDrOEgBlUd0lqvd5DYuTTjhwi02Dos?=
 =?us-ascii?Q?qLAsIpQWcGqbKo0GgDVCtDu6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41fd826a-b4a0-4717-cb8c-08d9872c4a1a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 11:44:14.4432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZpfKQuVnx5IwaH8gPV2bgcR/687feItRs3sbWPA+HoSNI6u6Sj2zZrYcFbUlBAVs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5080
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 04, 2021 at 04:58:29PM +0800, Hillf Danton wrote:

> >Fix 2ee9bf346fbf
> >("RDMA/addr: Fix race with netevent_callback()/rdma_addr_cancel()") by
> 
> Sorry for my noise, given addr_wq is an ordered workqueue.
> I missed it.

It is probably fixed by this:


commit 305d568b72f17f674155a2a8275f865f207b3808
Author: Jason Gunthorpe <jgg@ziepe.ca>
Date:   Thu Sep 16 15:34:46 2021 -0300

    RDMA/cma: Ensure rdma_addr_cancel() happens before issuing more requests
    
    The FSM can run in a circle allowing rdma_resolve_ip() to be called twice
    on the same id_priv. While this cannot happen without going through the
    work, it violates the invariant that the same address resolution
    background request cannot be active twice.
    
           CPU 1                                  CPU 2
    
    rdma_resolve_addr():
      RDMA_CM_IDLE -> RDMA_CM_ADDR_QUERY
      rdma_resolve_ip(addr_handler)  #1
    
                             process_one_req(): for #1
                              addr_handler():
                                RDMA_CM_ADDR_QUERY -> RDMA_CM_ADDR_BOUND
                                mutex_unlock(&id_priv->handler_mutex);
                                [.. handler still running ..]
    
    rdma_resolve_addr():
      RDMA_CM_ADDR_BOUND -> RDMA_CM_ADDR_QUERY
      rdma_resolve_ip(addr_handler)
        !! two requests are now on the req_list
    
    rdma_destroy_id():
     destroy_id_handler_unlock():
      _destroy_id():
       cma_cancel_operation():
        rdma_addr_cancel()
    
                              // process_one_req() self removes it
                              spin_lock_bh(&lock);
                               cancel_delayed_work(&req->work);
                               if (!list_empty(&req->list)) == true
    
          ! rdma_addr_cancel() returns after process_on_req #1 is done
    
       kfree(id_priv)
    
                             process_one_req(): for #2
                              addr_handler():
                                mutex_lock(&id_priv->handler_mutex);
                                !! Use after free on id_priv
    
    rdma_addr_cancel() expects there to be one req on the list and only
    cancels the first one. The self-removal behavior of the work only happens
    after the handler has returned. This yields a situations where the
    req_list can have two reqs for the same "handle" but rdma_addr_cancel()
    only cancels the first one.
    
    The second req remains active beyond rdma_destroy_id() and will
    use-after-free id_priv once it inevitably triggers.
    
    Fix this by remembering if the id_priv has called rdma_resolve_ip() and
    always cancel before calling it again. This ensures the req_list never
    gets more than one item in it and doesn't cost anything in the normal flow
    that never uses this strange error path.
    
    Link: https://lore.kernel.org/r/0-v1-3bc675b8006d+22-syz_cancel_uaf_jgg@nvidia.com
    Cc: stable@vger.kernel.org
    Fixes: e51060f08a61 ("IB: IP address based RDMA connection manager")
    Reported-by: syzbot+dc3dfba010d7671e05f5@syzkaller.appspotmail.com
    Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
