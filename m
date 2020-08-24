Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DD7250347
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 18:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgHXQmc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 12:42:32 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:14725 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728529AbgHXQm2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Aug 2020 12:42:28 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f43edb60000>; Mon, 24 Aug 2020 09:41:26 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 24 Aug 2020 09:42:27 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 24 Aug 2020 09:42:27 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Aug
 2020 16:42:27 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 24 Aug 2020 16:42:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtGXZ08oUdzKecLG3FPmhbscWQP8pmS6UkCuU50qqXIxAWqe+d3jui0LhVHOAi1QwCgt9FEiBzWPc+yc9+Y50aNGXsjTTWEZVeybWBlqomngMYj6XHKW3aC6SWwoNvQyBY6OO1FVoP87tR3OaysBO+3MBKfjmF4Px3WLPcrqcO19dWRX+rr8IbcrCdWp0cfDUgJvgFxtjwdclQd0UQ9h/b7Unp2a38DcGip/UHtip3D14xMRxzZegY8Kg941B+3s9n5JdpEf/ScvMV/xHcKXMYH9Ow+XuZur9Po0n5RFnHdlg5s6YF1vg4HfX4MmoQX1krdCPvhZr+W9b1Y5QJNbJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHfrGGKyG5ax9nzo/OPklR0sC6C4nw9YAKL8qVYkR30=;
 b=WYosFNRXWyRyI32Rk0oCF8zr2odb3GJhh3fCVZBHw6RqePYTvnnDKG6DcKZo5xkR0T1+/xgMh/xP8gWMbq5mrC3xjcDzQ3H5hWEasZo6wHPycBh8/lqpNgH8e7CNzOUvtHXVzPpkw7Ji11WAwtwfyWId3q1gRHxEPBOaVpfoq2jdg8SW5Z5B09PUOGdwKc2D5py7LAcuJ4dkrmtQIISXN1RWYijM0nE1KKKIyXMzqSX2fMcFTg70T0vPDXY23vs5cjFZNUw7NARBVF4eFlQMKrQb8ZxiJY1tmnDwLRfXsxgesrKNt+MczesQy6SH3ujkcK5SSk3keqL2TC+GpDX27Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Mon, 24 Aug
 2020 16:42:26 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 16:42:26 +0000
Date:   Mon, 24 Aug 2020 13:42:24 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Suraj Upadhyay <usuraj35@gmail.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH 0/4] Infiniband Subsystem: Remove pci-dma-compat wrapper
 APIs.
Message-ID: <20200824164224.GA3180344@nvidia.com>
References: <cover.1596957073.git.usuraj35@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1596957073.git.usuraj35@gmail.com>
X-ClientProxiedBy: MN2PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:208:23a::25) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR03CA0020.namprd03.prod.outlook.com (2603:10b6:208:23a::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Mon, 24 Aug 2020 16:42:25 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kAFY8-00DLNV-EL; Mon, 24 Aug 2020 13:42:24 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d058fa5b-89a3-4ce5-112e-08d8484caec2
X-MS-TrafficTypeDiagnostic: DM6PR12MB4266:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4266FBA2A7A3B1F322030282C2560@DM6PR12MB4266.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VEOLvRUmrGWSQpsnoYRSV1+CD0i8wiMzf8G6yGjRoCSNbpaiJlLTgC1Of9dDsL4yPS1zmTJCdSRB8MMJzK7veM0cjlHAJlfAAYl2TGF49LIHL0Fw5DWODOWbpIdKPYCLolqa4DXEMBAsFCTgduW3vjXXY4ttQiqGHDkQEQ7uNxtk8onKlVQefmafbeNftaisDZQ7Cu3EILOKvPU+6YTND1Q34QY0XxbHG/v6A5FIe27XHPEpbu03BJRXMGXwg8uvTkrfwiaCM2DtGyzVK7Z2zIpuDNhu+ghRVK8hxmWIlUwTwC6QhHWuDICsca1Ezaih
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(86362001)(9746002)(478600001)(2906002)(316002)(66556008)(66476007)(2616005)(66946007)(9786002)(4326008)(83380400001)(6916009)(426003)(26005)(1076003)(5660300002)(36756003)(8936002)(8676002)(186003)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: mteEi6aVTD0Z6jEZ/ciM06y8HwN/2K21UVdE4owAV5r1GM6ajfadlro4KtSKqISz7blaaPAiByVlMa+qu7Xo6Qt1RsncIpD+IILHyyMlOKkb8Xi+T3segxl/K7mHc/elPldesAP9WJzMJyTMh9HWcGWMm1pMM39+lmxiHOVsKuCtzGaDTLqOeMhVWzv8GORTGcCSh/yOCKTSpbpQQPTs4XueMS0mIWdZY+dRtZ9Fqwms5M0fs7mafZDsP6dK9pI0yLmMEAXhAx1giH6CcvDhxuFtjIZlZL8In2008rOusBHBwPBDLddVAq8Hw4rp5RQ+x4mzhB3K98i7UY6lRlKCK7e5fTLro97NtRMZGjV3Z5k0fxWNrRVH6rOJWS1TILuaBD6XqL0F8KDiwjOAiLEcxTgUQwzOMrq2j0o2D3CCMXPgx1MGltfAgPsWmZXDdhptAKUfJdm7XdH9UIP+bQSkMoDx8ZPDnqIxGN/iYb45WtdY81tBBJL05/BjhqRhbFD1+tw9iFuleEciNL6slMpARTN1hS9c//sqmjSNhNSn57/obxOSpiz+eBGNyKI4/LAGcfatm/0wmIXFtBbG0TBG6lrv5L+fVz/6SqO4x0KkqAyVDV0szW0AhzslrJ9mhmwRbPo4We8VfsPjH7xz1v1dLg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d058fa5b-89a3-4ce5-112e-08d8484caec2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 16:42:26.1712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +K8F77UBhZm0eohceQIcBoMoDBbzGcrpvD/5/WOdl5ufkGCgzIZU7xO7ZgOPGjc6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4266
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598287286; bh=DHfrGGKyG5ax9nzo/OPklR0sC6C4nw9YAKL8qVYkR30=;
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
        b=lxFPqYpjIMtoEAUYcY6UqaeQMbjgSpMa2YiNiwFxquxRvXkMSTHv1HlQSh8c9ASK6
         hGPMKUfgLhB+qKx4X7zahrgfCFIVuWptv9U5876tV5tzhhZD89j8b3GnFd9BzyvI+3
         NxOAfZy32Q8C9eY5x8w2VwpHYlTteRGW7rESjpgrh3h52hRT4kjuFeihCSw3JNXTHb
         L/01PGmaKdXLIAYGaC86FKifuY//TQLkKxoy9AQX1TYLlby8Pvei0ZOFOZNvRfU+4o
         llg3UUvvwp2QAjI7u33XrJzPJJGHZcVMBdUqc04tY3zbsTlqj0xgOpsCBPX5nWp7c6
         nvLErkLbYHouA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 09, 2020 at 12:54:28PM +0530, Suraj Upadhyay wrote:
> Hii Developers,
> 
> 	This patch series will replace all the legacy pci-dma-compat wrappers
> with the dma-mapping APIs directly in the INFINIBAND Subsystem.
> 
> This task is done through a coccinelle script which is described in each commit
> message.
> 
> The changes are compile tested.
> 
> Thanks,
> 
> Suraj Upadhyay.
> 
> Suraj Upadhyay (4):
>   IB/hfi1: Remove pci-dma-compat wrapper APIs
>   IB/mthca: Remove pci-dma-compat wrapper APIs
>   RDMA/qib: Remove pci-dma-compat wrapper APIs
>   RDMA/pvrdma: Remove pci-dma-compat wrapper APIs

Aside from Joe's notes it doesn't apply either:

 Applying: RDMA/efa : Remove pci-dma-compat wrapper APIs
 Using index info to reconstruct a base tree...
 error: patch failed: drivers/infiniband/hw/efa/efa_main.c:405
 error: drivers/infiniband/hw/efa/efa_main.c: patch does not apply
 error: Did you hand edit your patch?
 It does not apply to blobs recorded in its index.

Try to avoid hand editing patches..

Please resend

Jason
