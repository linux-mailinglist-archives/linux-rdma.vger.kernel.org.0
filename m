Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16B240C68F
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Sep 2021 15:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbhIONoZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Sep 2021 09:44:25 -0400
Received: from mail-bn8nam12on2044.outbound.protection.outlook.com ([40.107.237.44]:45793
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233440AbhIONoY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Sep 2021 09:44:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5kGleY2ZJzt6+jyoRtlTjsDnRZG7JgiU6IEJ44sh0aKCWpSmXZjVpRf9X1Tcfw8mgWfJyshCYbn7OnFRmpmh0eAW5d3woLHLpNoQ9EPkeWyg8BhebPTPBz4vH+3H4boa3x/nchDX5fVRVA2f8JEHgSHqZbkIUkIP76Kbis4gWUzolkaOQE2SGEyfGXNP1z5FPialj0ZLt8n93sgFWbJWnwNQWxIsWtjGIoeX6iIJZMmbVm8toXmoEs+Pxa//i5WXPEH3LFemvFDitWa1yvE8z+LTHhxsqyn2CAaImi9irH9mbBvk5Px/1MLG4kK1Ly+UAzvaD1JopAAN9bkkCz/Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=t9wHgYjtuDDqoOkNPzm4awLbzbYZc+IpFmGsHWhMBsk=;
 b=IT0Ob9w02giMrD9W6I/RwlO1zTIe0icVjvkCMB1q1SEHLfBear20iFxgLFYj605txjMACDPZ9KQ96imlDYDUfRzUf24qiuryN+ruUyTuNren0uc+ME2w8HHHHopdthJ/5ZSRvb8VLBFd1FS/O03Us6qZ8ZMe4murnxnPbL1jen5ov7BRc9SnnyZe1gwnh9Ay5CJ5S9gQWTFREYAOz7RQ6L9qB5ahYGTOa4lIm726DSCBJ3Mvtr1NJqFs+GgFB8l5Lbp1npNX6P8Or/kMqaBzR3ZRyqgoL0FTGzt7c/HGjODL5lyGbUWnbcI5b/zIXkjTONbERCLRNNSLbrS9lYxHuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9wHgYjtuDDqoOkNPzm4awLbzbYZc+IpFmGsHWhMBsk=;
 b=fEdJgEKe56whh2NTje/0nLHsUZgm+RKg0Wqjn6p0vKwmUDb6KxnGlmo24zOfuJA+UOI2ijndYOve/+5z5Vy8JO3vdQMO44UeUP9IoGoS6Ij3kweLeM6hPRghC/vxYeVoatWvciJAVphuQbCkRU0ONdN24Ic7LmHpFff8i9A0xGQcvmonBNyqrL5bXt4r2xJs4EaaTJyeRvlJX23Mcq7t7PTKhmC3b/zNm4Jt7OPfToJnIf+U4mcOc5ZKgiuDMW9D1TGJX6vMjd/k2alNUFldI0YvdQ6AJmdhWE7f1yeISRUQnTtQJzK+SADozkaIaNmlIX+4P4aGpSfwrJam+yk6mw==
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5507.namprd12.prod.outlook.com (2603:10b6:208:1c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 13:43:03 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4523.014; Wed, 15 Sep 2021
 13:43:03 +0000
Date:   Wed, 15 Sep 2021 10:43:01 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Junji Wei <weijunji@bytedance.com>
Cc:     dledford@redhat.com, mst@redhat.com, jasowang@redhat.com,
        yuval.shaia.ml@gmail.com, marcel.apfelbaum@gmail.com,
        cohuck@redhat.com, hare@suse.de, xieyongji@bytedance.com,
        chaiwen.cc@bytedance.com, linux-rdma@vger.kernel.org,
        virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
Subject: Re: [RFC 0/5] VirtIO RDMA
Message-ID: <20210915134301.GA211485@nvidia.com>
References: <20210902130625.25277-1-weijunji@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902130625.25277-1-weijunji@bytedance.com>
X-ClientProxiedBy: YTOPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::46) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by YTOPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 13:43:02 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mQVBl-000t8l-2z; Wed, 15 Sep 2021 10:43:01 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c6a6c94-6a8a-47b2-f68d-08d9784ebd42
X-MS-TrafficTypeDiagnostic: BL0PR12MB5507:
X-Microsoft-Antispam-PRVS: <BL0PR12MB550706EFB3B9CDC968E79537C2DB9@BL0PR12MB5507.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Au0Pm0Actw2Mf/QBWkKQ9IHWce/hRAp27aND6PiLFoX/zWsfN61PF82eQeUx4/lwHZyjBuGCvUyrE1F7nFJ4WJILfQ1rYM/seUQkcH1mtwczAlYxLWJ3HELSl6nPHsckIwL/p0w92KpOtQcd6fXfwgitQbr19AKcCnc16xcp7JVnVumLFH7x+v9cAGfzCN8P77a+AG02gJSSybpP/9kGaA0ZpTe4/O3h/Z0gsIONIPGJkEv4pjGx6aPO3XMaqr7+mCcjBhiytvgEs+x3uIFJ5Af534hs932plA1612v+Pf0akdh0keBzCFvHczWCaO7cJDKpip3+uGxJuXdZ7TXW1dfNs2WIpWJwPcuy+445u/5CZt8/cnI8iLuXbdwLdE4ksoltDuPl8g+fWYZ0mm0ZrqguS0UGy1e6fCcwMLhE3/XaX09e0n+ZZ61tOvGjpRLDD2iB2zrXi/ZdzF65bi/A6WXJ1M/cyPLCdW2SH84reYwRWVJknfZb7HFWwaqPcGS1al8TZefTL5C/JP7L49L1AW/3m+0LoXSttMPvMvQ/WrK9dV3Ba5sEuY1rhxpjOuOuhQhaopPdjt65wvtCEvg1Y3yIJ8yD+AG2LFUro+Dz7OWBO0Jv1Lv+EFZzC5UWE+Gl8xNgWBTmp2eaWpzGaC5VxWXgeNKZopsBKBuQ2SemE3Dl+zClkw8GNPxusZtxfb0u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(66476007)(66556008)(2616005)(66946007)(426003)(1076003)(86362001)(83380400001)(33656002)(36756003)(38100700002)(8936002)(7416002)(8676002)(2906002)(6916009)(9786002)(9746002)(4326008)(5660300002)(186003)(26005)(316002)(478600001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y2awUyrQM9PmdZYlKCq/F8qosIgdHV1gURonfnhQx3s3u70pYRrid0jmhPjr?=
 =?us-ascii?Q?GVhb46gvfFTrWi2yVd7M8mHBMXEFakegDduJvvjSqjcjpMunGXjYhYDSVPpK?=
 =?us-ascii?Q?h7rtj5QYdji/TSPf5WHercrMdGel7hioz0nYydmx3k99a+p0nYBkMLV9Bdl0?=
 =?us-ascii?Q?yusFlmlvCDrPl2zTtLYuGPK2Dg6G76Ue+oQE8xR/ZGNnmhGiWPdInYd/IFoR?=
 =?us-ascii?Q?PVGnPJWcZq5H8T9vEz+vlbbHVuI/9S54lHQbjOUE7F/j1TL4f6lKT4+XRCxE?=
 =?us-ascii?Q?i6wxzP+4mugh2wR2coPvgCGRjnfrwRFbbRgIXFqZt0Ov5QlHkDrhHIufOXPZ?=
 =?us-ascii?Q?gAix9g8rcVLjy26IZEhfaoBAPk/TdGIdBDQJAT3NILh7vnzCBbQjTWxNIrIX?=
 =?us-ascii?Q?+gCYKNMPLhYCNUMAcndmMxaB42qW+3F2YJrUSBiEZqG3XhbvVvmRhmmVWfhu?=
 =?us-ascii?Q?rYdNxOy5cYluw/mpNIZBZ7v9wlJo5osj2+tnpxr8tLgnlxqTis/t5nfi8xlL?=
 =?us-ascii?Q?xO+ZuomIEte2VV9L7N3ejpVMswIpofYR7KwGR7zjBX5Wg13s5nvUR/ljTqoO?=
 =?us-ascii?Q?rvVJe6JAFv0C1ZiCbMcxp5TpV+ZlggcTsaxDGDYjbJES27TmM1GLk5fbhTf8?=
 =?us-ascii?Q?hnP5dd/+iIXMTKxSPGx8bp2RfXEJMZk34JmI2giyhFb+u99Qe1QkY0DUrtJ/?=
 =?us-ascii?Q?VwKeKz+Gh70hUoPp2W9+Ol3xmqvOO4xBp8jCX2vdkLrUSp2BL6KSpwpUy1tn?=
 =?us-ascii?Q?FT7cxGkZwuKoE0hTYSpASEMwiPlXlAhhLjaT2MxRkZpJ682RgZz4PY8MWUEL?=
 =?us-ascii?Q?F6KD8bFW7QTRWgxWJHxnMM6itHXMJrIBy6eyD0ZrTIzPEFmWTr7QyY3klOEo?=
 =?us-ascii?Q?xkTVJJjiX5Jh0seueSNRH+rd6weuGsb7SefX7CNneNm9wkM1TZks76HORO39?=
 =?us-ascii?Q?Oyni0D3oH4+2Fx0c7d2uCCpI0EDpIWSkseji2cGTyezVnjR0qo1YSwpadWW1?=
 =?us-ascii?Q?cANhoZ54i1wcyEwUtJCRpB1+UDhZMNgs6AuqEEboxeFf797u2Yo9DvfHYyAi?=
 =?us-ascii?Q?ZOSDNZAoEYs1eyMpso3lTvq6Gi6DO+ppO0+BU/hqw+iJ4bCeuZGpZFtbPH/D?=
 =?us-ascii?Q?h62KHMyDEyofS5hjSEEVc6rxlfCmzkTTeKu7RIJDHuFED103p1ivlZo0lCoy?=
 =?us-ascii?Q?g9Vno0dvFFBc5Rp5K2WzAcBzbm5OtMiG9KtR5Jvjf93+G6cnDkQQHDpk+NQA?=
 =?us-ascii?Q?ygjUix2J6elFx7csY2BaPCtDzXGmF4bqJRt/a9QXa2Nam4MjRo5E8AIExwiL?=
 =?us-ascii?Q?+XKZQXesbjDYCVFE3zsfL/iA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6a6c94-6a8a-47b2-f68d-08d9784ebd42
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 13:43:03.4241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FU00cPnQOOxGllKF7piVV8z5USC60g+vPYChbOmtONEpSUmbUpiR7KrLDsqJGSkZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5507
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 02, 2021 at 09:06:20PM +0800, Junji Wei wrote:
> Hi all,
> 
> This RFC aims to reopen the discussion of Virtio RDMA.
> Now this is based on Yuval Shaia's RFC "VirtIO RDMA"
> which implemented a frame for Virtio RDMA and a simple
> control path (Not sure if Yuval Shaia has any further
> plan for it).
> 
> We try to extend this work and implement a simple
> data-path and a completed control path. Now this can
> work with SEND, RECV and REG_MR in kernel. There is a
> simple test module in this patch that can communicate
> with ibv_rc_pingpong in rdma-core.
> 
> During doing this work, we have found some problems and
> would like to ask for some suggestions from community:

These seem like serious problems! Shouldn't these be solved before
sending patches?

> 1. Each qp need two VQ, but qemu default only support 1024 VQ.
>    I think it is possible to multiplex the VQ, since the
>    cmd_post_send carry the qpn in request.

QPs and CQs need to have predictable fixed WQE sizes, I don't know how
you can reasonably expect to map them to a shared queue.

> 2. The virtio-rdma device's gid should equal to host rdma
>    device's gid. This means that we cannot use gid cache in
>    rdma subsystem. And theoretically the gid should also equal
>    to the device's netdev's ip address, how can we deal with
>    this conflict.

You have to follow the correct semantics, the GID flows from the guest
into the host and updates the hosts GID table, not the other way
around.
 
> 3. How to support DMA mr? The verbs in host cannot support it.
>    And it seems hard to ping whole guest physical memory in qemu.

Either you have to trap the FRWR in the hypervisor and pin the memory,
remap the MR, etc or you have to pin the entire guest and rely on
something like memory windows to emulate FRWR.
 
> 4. The FRMR api need to set key of MR through IB_WR_REG_MR.
>    But it is impossible to change a key of mr using uverbs.

FRMR is more like memory windows in user space, you can't support it
using just regular MRs.

>    In our implementation, we change the key of WR while post_send,
>    but this means the MR can only work with SEND and RECV since we
>    cannot change the key in the remote.

Yes, this is not a realistic solution

> 5. The GSI is not supported now. And we think it's a problem that
>    when the host receive a GSI package, it doesn't know which
>    device it belongs to.

Of course, GSI packets are not virtualized. You need to somehow
capture GSI messages for the entire GID that the guest is using. We
don't have any API to do this in userspace.

Jason
