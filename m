Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3628A3DF47B
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Aug 2021 20:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238797AbhHCSNz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Aug 2021 14:13:55 -0400
Received: from mail-bn7nam10on2064.outbound.protection.outlook.com ([40.107.92.64]:63840
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238787AbhHCSNy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 3 Aug 2021 14:13:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSIoFU1jK9lhNVxToxhri0LxRXIr83q9O9E0UXF0qwneJK16edmRdmARwTqGRgz1z1+cL9TlNtzkpPN4XiTVVOdTJjAvIOIWuYJl2stv2UDaWKTptX0bMKqreND2+Fyv8JI7H6MDEGR/7QVZM+HUQfcweKJjC6cFModRDJsWBs0hV4Cz0PcOcMmnRAWy11W0hQO0rT97HPhDgtlMp8ejy4ZZuL3z5HnAmgw4WejeFlvWffuoz1jKTBtNfNEb3Rk2Qq6QNPT4dwnYXzh2jaQjbXgfsF73AtL+ipqO7EZkuzhKbIBlXz0bNg3tECRSOcLVYAiEUdstColXKcLweAI7Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKny+IJc0urQ04QD6pYJbiucgYpeQC+jHjSIYwlaLjI=;
 b=a8zDEb8OPMVo/4e7Blv+yHdwq61WI5ZMKvO41JqkzoUReSxC6O9qW02Bsf00DjgvJnaStwpcAfVktKf8kAiNOVQBqxfwgmDoSKvvrOxy1OEaOMXr11Rz7GdvKJQus0LNyTdbQd2X/suBuu+eZAVSSFYhB0pNLfXOZGvhS/4KL47fi5kryNh+xlX/ZuJt3G/AlxYPAm+2JddLHP4rKvtymnAgYQ5ODfzZ4D2s8/RVJVrHO+E0a3TkTr7oRA4NYcbsFNEqjUn2mref3shDEFx6dAq+GK3p5N3XaAfPyNGL7K9yib3xfDEGgnDb1LqHEYhl4QBixr+uqH0QHRtmivJUiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKny+IJc0urQ04QD6pYJbiucgYpeQC+jHjSIYwlaLjI=;
 b=exMPhEYqgV3CeCK010AQlghkslr9n6TEuXFdrdyp5GT9WCO5XrZVlfsG68sNvmh2zAJ+mxx5H/KpZTjS8P7+fyuzuofTPOFvS+HThyOXvw8qozRHbo1T+dM/Z1JSC+kLYGIBDtFaKpIcHbEgrM4apW6F4kdxy7H6gcD7dzpwbmQwu/p4xJvMLaS5C/KEW2cLKeZ65VvaLS/edIg7S+uIqDGelstQbpg1RLvtiFtxPzwS859WZuRPW0N7v7+nJEd7OPnPJwMR4NvoNJ4ZP/JppLL3igmtjqDZ076Np/lT3yTseRzDGsHjpGhK0sQDYb+3D51uXYbaWZ96u4p2Fa3YiQ==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5208.namprd12.prod.outlook.com (2603:10b6:208:311::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Tue, 3 Aug
 2021 18:13:42 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 18:13:42 +0000
Date:   Tue, 3 Aug 2021 15:13:41 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Li Zhijian <lizhijian@cn.fujitsu.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx5: return the EFAULT per ibv_advise_mr(3)
Message-ID: <20210803181341.GE1721383@nvidia.com>
References: <20210801092050.6322-1-lizhijian@cn.fujitsu.com>
 <20210803162507.GA2892108@nvidia.com>
 <YQmDZpbCy3uTS5jv@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQmDZpbCy3uTS5jv@unreal>
X-ClientProxiedBy: BL1PR13CA0146.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::31) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0146.namprd13.prod.outlook.com (2603:10b6:208:2bb::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.8 via Frontend Transport; Tue, 3 Aug 2021 18:13:42 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mAyv7-00CEbi-FS; Tue, 03 Aug 2021 15:13:41 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9a6c09f-ad7d-44d9-90b1-08d956aa6d10
X-MS-TrafficTypeDiagnostic: BL1PR12MB5208:
X-Microsoft-Antispam-PRVS: <BL1PR12MB52082B42F0CB0FDEB51B32F5C2F09@BL1PR12MB5208.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VT/dHxMvnXSmvMz+AwV+UDTX63zkvOOlOv6wW+PHP2zMfO/gnm3d0uwK/QxWku5w4+gqtdyydVu3Ax3VWvQ0yidqZJPYeh2tZFzgvep/YH6j2p3Mowh1lHFy8PEhXKWO+eiDLwkIeYERQHT/WCE4ddadBXk8EjmqxGkrF4otcl7SVIp1qThQwLuO80EX6bRrTkUL9jxhPK8hJGkQ/UGZ/IGN9EMDx6Kj5emfugn1If7aPhdZfEi9Qj0vzQPQ9cTjkQnK+K6SpVtl1vJlLwdi7uF/s2Xf3gp+omaPA6uLwNip0HxoqmfIkRTj2kxiTxg2G3p5zyZH4ztp/qcZReSjCh7s9p650XufmmvE+uI1sYLMkGIyc2Zq9Yq+7orVFKlI7QYe4W799nMD5XBrYxWtHtA9VzDSpCgIO/mYoulOwq5PZ0jMhRMohYNqcuVUiTtrKeWY2tyseCH6mDQW+ffP7SMdvCnT83wRfHTiSxV6bLNDsXOEnF53c2BMYHPUiQVF13DhNeC5Ru89D/NvSWMEwFzusJAedToR//4Fenota4ojOn2Q3dLv1f/xmx1DpxJ9gPPn/iHt7bGNtE8CduJH+czX6omo0x93NjnyKLnq6taydOlBp+wTt1cZ61Se6Xu2ln1Ykkf0aW4Dk/MRI4XF8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(86362001)(186003)(66946007)(8936002)(1076003)(8676002)(66556008)(66476007)(26005)(36756003)(83380400001)(6916009)(2906002)(426003)(2616005)(316002)(38100700002)(9746002)(9786002)(5660300002)(33656002)(478600001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hNAfkGkNm9QunrTzcwLdE1b02lwvB60ObL//9gLPAu6embRj/ScxB/n5ZdBS?=
 =?us-ascii?Q?WD7nMksX3tCCxRyFdoLLGRk3IuT6fSMgMZq6rkucRtuWOcEaJ5IpWJNrtsDw?=
 =?us-ascii?Q?VQfWp+z27/fPF1S3ozc+oNK8c00NGRRnNf1j5cbQPxqESYOetatNmBmUx+Dr?=
 =?us-ascii?Q?LoZ2zJrZZrgEDxa1zdMunqMPm5FsJV0FBRemqz1UQx49bDHcvJH8T380KE8U?=
 =?us-ascii?Q?a7mdH4RjZ6NjMqgu8S3s69ZuZ7qhWzEmAFc6UqrwQTFzhPpf5D/Do514Ojgd?=
 =?us-ascii?Q?lezUUFRQP8kUpg5FipA7hVICrRa+1aXoXuxulhlAz4Lg9vseOeOC4q131sDA?=
 =?us-ascii?Q?ggPEL9fChZajQ/3xrJFl978D1ps0j/v00JrVpEPFRIHMPTsCC0O2SnuTmeaS?=
 =?us-ascii?Q?sEjt0Xv1WuiffXTvm4axwE1/AFURMNELKSIUcryJPYJbSMj5ceHeN3U09Gtm?=
 =?us-ascii?Q?fqkzRr1/Z0R8xpgLrsd4JqFBCn2j2g0DKrqJg3NbP/oA2DhymakKEG1/q0Q1?=
 =?us-ascii?Q?dUeOG61EO/CipemZC+8AytHAcbvMkc/Vep2FlGF8QtK1cIPJfuepAupoHVsE?=
 =?us-ascii?Q?BK5IVyq2WFEH02ieyr0/aOPl10wifG12/c3ZypThNVlgRDGhlXgjrrx2BZ1+?=
 =?us-ascii?Q?+rqISsRznntjDkUmFYmKaZawQiJqQghCFs/7rInGMUbIp+EGp5OZKr31ar76?=
 =?us-ascii?Q?C7kb/bntsno6fVgijsDAfpdM+uO6lrmPvPhHBd7q1kPybQGIF/waLZFJuSxM?=
 =?us-ascii?Q?hT7wHfmMjAAU7idHC39C49IejgIej8o/sGr8mAp/Y8RO9XcuFC2E8TNoRAEp?=
 =?us-ascii?Q?+hpL92hKxdTYMIAyjooGH4MpxcFot8NQGX+ApJE4kW6evEqqq3mtOTJpLnhF?=
 =?us-ascii?Q?vQGRb4q2RnlvCdsrkMmpxa21nR4kLeFUzKTgglOm/ZR/+7UOAF7l/9DAFhR5?=
 =?us-ascii?Q?ePMDT+d5d+cwLATY+dg3HIQIHVT6RvUxElejSKz3F2GGSOAs1wiRu2G10615?=
 =?us-ascii?Q?phLcWp0D9yHv65TJDXlFEkHlr75Y9KrWq/NMzPN+vTSq0yX1JNo3cerK0dgv?=
 =?us-ascii?Q?PAhkMMLk8e+aXFVlfGRyZvgtXT0kLH4TfnCeJ9rslNAR/swFyAcSemAy2pkT?=
 =?us-ascii?Q?6Eb6wZBPUQoEss7cPbSN/OrNyoIwFcIVuzDWR7eGxZJ3YfSSoU0grFWgZA1M?=
 =?us-ascii?Q?amnm4HoKPZgfYkL1qtMQdDE4SmwWkBzzQW0MGzleCfAImVPYhXP0gvbH16VE?=
 =?us-ascii?Q?oITTlrWyHxWkmHoGv9X+f8M0RUQfj/wqVr8iFV5Fn/Xoq9NY250vrFoNeQrf?=
 =?us-ascii?Q?bJEyMdOKVt07MO/zRy77bpQG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a6c09f-ad7d-44d9-90b1-08d956aa6d10
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 18:13:42.5340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ry9YDjjJrMZBjbobikDEw1RKpxTkzWeRsxXZhrGmYhpRdvZZh6eI05dS+XfO+QhU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5208
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 03, 2021 at 08:56:54PM +0300, Leon Romanovsky wrote:
> On Tue, Aug 03, 2021 at 01:25:07PM -0300, Jason Gunthorpe wrote:
> > On Sun, Aug 01, 2021 at 05:20:50PM +0800, Li Zhijian wrote:
> > > ibv_advise_mr(3) says:
> > > EFAULT In one of the following: o When the range requested is out of the  MR  bounds,
> > >        or  when  parts of it are not part of the process address space. o One of the
> > >        lkeys provided in the scatter gather list is invalid or with wrong write access
> > > 
> > > Actually get_prefetchable_mr() will return NULL if it see above conditions
> > 
> > No, get_prefetchable_mr() returns NULL if the mkey is invalid
> 
> And what is this?
>   1701 static struct mlx5_ib_mr *                         
>   1702 get_prefetchable_mr(struct ib_pd *pd, enum ib_uverbs_advise_mr_advice advice,
>   1703                     u32 lkey)
> 
> ...
> 
>   1721         /* prefetch with write-access must be supported by the MR */
>   1722         if (advice == IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_WRITE &&
>   1723             !mr->umem->writable) {
>   1724                 mr = NULL;
>   1725                 goto end;
>   1726         }

I would say that is an invalid mkey

Jason
