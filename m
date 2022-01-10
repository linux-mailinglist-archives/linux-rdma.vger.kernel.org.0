Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD42489C6B
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jan 2022 16:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbiAJPmJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jan 2022 10:42:09 -0500
Received: from mail-dm3nam07on2061.outbound.protection.outlook.com ([40.107.95.61]:30305
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231477AbiAJPmI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Jan 2022 10:42:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUf3KbBL+CufMTiTGbqSOb898D1Y9qNxKsLa6EpLYuVyLcgzlxhumj/Iy+cEpH+m1F+xZ9iZ5UFmjZkgm7iMJCxMzIOHx0DHzBaPr0qtdoSXSSSLuZhKo1/3VUTy8nW/+RkTuZ4ARr4c9DwHSgT7DYMmVWh/d3fOCDsnlKwFSbYZ59AxQqnNCFQdVTidU/HJeWBLmyVQMhAjWa7xoIgLiRC6nTN9B9TqHH2K9PfjQ/pC0WLvGqc8Ao5f424w3GNoR/fVtd+LrHymqdWOVW+JPRi5vyB8RaMvVt5cZPKJxfDsfocB4hPyWR4HPhvNuYI4+oEA6lri5pzK7AFxLqXogQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APw801HdXyE8US1t2vu6z894XdIqX45kVocPDm1FfT0=;
 b=eCZ1jUMFpKwINQV19nLhbVO0xuTWppbo4hg98wm6HlSKgV7WC7DYRh2AW5lb/eaYESDZD5TCimCxir6hrPhAYFSpR0jLWDeKnBsxsqn2oVOJxuVf9IXDHhkBvB+mSGfl/NIYmIQNd2Rh/q4doMSHlf/mD40U697omTpwGD6s0XvxQu9fGKrMTOl9rC0DCwEdyeGNihnzrO2IFbmhYwNgj3T844UPdB7Erp/dSoN5ctEJUuf4pPjSGmn2DErN96Olz2XxsjhzfQexFkc6qrucOOj4DgjpylU+FcvoLzdjKQO6cqaJBe4xr+UzA2cSxoZ07gyvLpSMZlsM4Y45B5IQHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APw801HdXyE8US1t2vu6z894XdIqX45kVocPDm1FfT0=;
 b=Cj4dgSuXs3LApeq1d1D72atlvAB2tPf5Mvexs7HT8d0Y1InZMrWwi2fk9Xtz/7scr2DiturCIecsnYBej/m7HAB+8jaFLd+qzIG7nSeJ46fGj0a9IzBYh6pex5btBK9p/w3aXbUJol+XBTPt8R/PIVsQboyssSuq/Fw0WV6A861TCFm19NKehWqMk0C8t/cZPKrtPeqrbxbN3Uab4lq3/X6DVQ15PBEy3RMmSO9h0aRp5INdGndgqeMsCM0vHoO2r9J5SbOe1Sr1I28u1THERiWs/vn3PEKlg+mCPncyKlDKpjxNog08kR36aH24PC2+DHUCtnmSadMJuPLnElks6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5127.namprd12.prod.outlook.com (2603:10b6:208:31b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 15:42:07 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%5]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 15:42:07 +0000
Date:   Mon, 10 Jan 2022 11:42:05 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     Tom Talpey <tom@talpey.com>,
        "Gromadzki, Tomasz" <tomasz.gromadzki@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Subject: Re: [RFC PATCH 0/2] RDMA/rxe: Add RDMA Atomic Write operation
Message-ID: <20220110154205.GD2328285@nvidia.com>
References: <20211230121423.1919550-1-yangx.jy@fujitsu.com>
 <BN6PR11MB0017C42F7DE2A193E547AC2695459@BN6PR11MB0017.namprd11.prod.outlook.com>
 <28b36be8-e618-9f4c-93f7-e35b915d17a6@talpey.com>
 <61CEA398.7090703@fujitsu.com>
 <61D4131D.5070700@fujitsu.com>
 <8c772721-2023-c9e4-ff28-151411253a7c@talpey.com>
 <61D4EDB6.7040504@fujitsu.com>
 <20220106000153.GW2328285@nvidia.com>
 <61D64BD5.9020401@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61D64BD5.9020401@fujitsu.com>
X-ClientProxiedBy: MN2PR20CA0021.namprd20.prod.outlook.com
 (2603:10b6:208:e8::34) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77c38c93-86eb-486c-43ac-08d9d44fc1e7
X-MS-TrafficTypeDiagnostic: BL1PR12MB5127:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB512787986937E10123789B7EC2509@BL1PR12MB5127.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n01GiltWaXJCJFDgFRhvM3f9mKSEjRYNM/WJOkl9pCSoqiFOQyxehQc7N+V7eaAe1F0Qzm9NZ3OUbSyjSRZg0a36dyn1Z3rVo+k2ftlBYTtVRQFgGZK59CdhSlLMl/T8TursPwGRLOgpSTEum6aiovqNHvVyzhV87Il2ofvOoZTa1Zg8SxFK3K5AyPSRvJ4p6fKjJGGmkPWCI1OY++sOgUk1C+8LEmtuEFrBPHSNyEmrC3gHPBdbZatLGWBpbLE7l8Ntmi/fXZkHH+i+j4mnex3vjKv6Mxwwtl7L0yOCewrSPGUfB4uYjPhYFGc+vRhAGXb5nd86+H3tnBlSHVmN2cp6OuNQXqukv9MYS7Xas80PRc8V40ECqWoZVFHPoFybJ9ShI6JMy0xdHUnFzOTOi3TRQ/BBdLhf16g2Y2clNAID3B3ZXbgim9X1Lt+nlSOxL7AOusg9VFZPrAGOGe5+FVoLezTeN+iTpZW8NsIEZfxVtBC8JCzV8oIQcCAb+JCIrBQegLEOUCj6mPQTAxhMVtJB1mMR/FAhmqLeu4sxSPjx7EhZU3lL3dylp+AI5SMFzcfXrlICygYApKkYzXqqBDQgkhxpap8iEiyIhNr+CNg2XYeo4SwY0ORMQVlOLvqxGXp+1Ax0PQf+ZrKC9AFhSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(53546011)(6486002)(6916009)(6512007)(8676002)(6506007)(508600001)(2616005)(83380400001)(1076003)(33656002)(36756003)(5660300002)(186003)(4326008)(54906003)(316002)(38100700002)(66476007)(66556008)(66946007)(86362001)(26005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/g6CNZ/J2N6Nfj7QJiwg2W32NY2331TfWqp7hs+2Y0ky03pTA8r4uydQpxBY?=
 =?us-ascii?Q?7bkGXWWFxQCjomt/4qLVwUQcfWqXZsoMSEckB+oDXeHHCgaGHS+f7GQ8mgkI?=
 =?us-ascii?Q?zvAAwQu6tw4FZNVAIi8TP5/ynTQh3XCPrZ7JDR8nSmD0460HUB+VJfgOn3nm?=
 =?us-ascii?Q?6EwLsXwGn8tf+R0dLyHyoWjhLQ/I558uKQLoPZGhEslSe+acuhrIVqboRS8+?=
 =?us-ascii?Q?FvdcaLTL0nUOX5iMIlfiJGsPOLFhdd0tnCy6ADjhmi4wicNIu/uuahsoTYTw?=
 =?us-ascii?Q?jewoRsXkw8/ufiO9cSrpwe1SivVPcCXMJYsiD5+Ja5wKbY/SO8O3AnyUfC/U?=
 =?us-ascii?Q?N3IkNANIkJA/KOmSIrd6gyZ01J4IU7VS5X1Xv7MtgjDw/nTnniSpV2YOGwU0?=
 =?us-ascii?Q?oUiPo0a0l/h7Wa7NuKIvoUe4BDSCKou1KH9KwoZDpfIOv0d1b2aYXLjfu2tJ?=
 =?us-ascii?Q?QMmCmKHURAh4hqjsPecl8t7wjwKuMGOSjPRUTMzoSiae3I4zOxSfCbLplNWd?=
 =?us-ascii?Q?JH8gR1i8hxppFCbKMtd4QlTfZFe/3ckyuUxKOZ02QKskY8BdsZwZbEYw8FOU?=
 =?us-ascii?Q?hg4AbIG6wqMoutJhDmp7Btq3X06MGkcCcFmxcxiaXjTFiUiNMhml/Tg3eog+?=
 =?us-ascii?Q?pT8JW21aneOs8x161Ewl7Qurt50HS7oKKP+iHsGw4wDMBbZMi43yik3c72Zc?=
 =?us-ascii?Q?c1+SH+NYGcrKqPpy/0p3GXY5c9dEmk0wzY5Ftk++njlbbFFyXCwwTDpsFkMN?=
 =?us-ascii?Q?0gNFeaVCDHxVzLS71cD96LOPid+KDWEIcAmHiNoXdTjCfvy7qw2Y3M8kfBPV?=
 =?us-ascii?Q?sFs5pVNcGjoa+n7gm28JJH5J7yWfUiC9EYLUjUZKhGjmVP42B+DIBmxnpoux?=
 =?us-ascii?Q?gzrIavxYzN+lTZOf7AJJA7faFRmSnS1i0ZhaxA5fAt/PJhIV3rVq8s2Zf1Kx?=
 =?us-ascii?Q?/A1Y6x/NBiAv3/yIw+Jc1DlhY3nz4joxUho5dP6L5YalWBWToV8Q22ONtgD4?=
 =?us-ascii?Q?N8pH6FIQZxjzsaPPAJljtNsd35OKSY3siKL1vhz/CdTtiXUT389AjOdbhiAB?=
 =?us-ascii?Q?V/HPhLHdTqQErZpWgrc2laTjib29Zd2Vy+WNCjZ9Pp1ug7IWccw17kDv/j+c?=
 =?us-ascii?Q?Evt9DsbiiRrf0+zwTTIPSVCNr0h5f3z0Nd/pthOFRjeG7xmL9MfIZIZ/Z/sm?=
 =?us-ascii?Q?EKs2IEtKq6D6Oz2Hsw+npFqHco01Au4QUqifjzRPUtnC/5I4XlusQa+i4JgL?=
 =?us-ascii?Q?QFLoyZdGE0Qj2NxCfZXbYRiWmUmAK36JcOr7DF4Eeb8WAuHfbJVwf2EfU+0o?=
 =?us-ascii?Q?T/ZzZEbCdTmG+k+F/K+Lb1dSVp0Jz7yJgkgrSiGG97Z01AqqpM44zkrW8+QE?=
 =?us-ascii?Q?38CNDDpWv8FfBV5NVeqT5MGHXZacYjq+QVvh0NW2z6oEY8oUzo+/cJZWC2pY?=
 =?us-ascii?Q?uCnA3Rc2VEu9lZ1fcp+P2Y21rHRkQgljfawvlHQgbbXP3RLI0DlsFitaiVXY?=
 =?us-ascii?Q?fMMm+VtAVdymw5xThVzKTTgM5ZkkszsN7DWRk8+bx3UkDj6KVnxHGqRk+vJo?=
 =?us-ascii?Q?uSpPSGoPdEVa9QJYeLI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c38c93-86eb-486c-43ac-08d9d44fc1e7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 15:42:07.2486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AOFnXPN9Vm15OYEMy7Cu1wnN8jczZLOwKrddUPbntsoEOPAJIZKipQMOBhLGJ2ZJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5127
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 06, 2022 at 01:54:30AM +0000, yangx.jy@fujitsu.com wrote:
> On 2022/1/6 8:01, Jason Gunthorpe wrote:
> > On Wed, Jan 05, 2022 at 01:00:42AM +0000, yangx.jy@fujitsu.com wrote:
> >
> >> 1) In kernel, current SoftRoCE copies the content of struct rdma to RETH
> >> and copies the content of struct atomic to AtomicETH.
> >> 2) IBTA defines that RDMA Atomic Write uses RETH + payload.
> >> According to these two reasons, I perfer to tweak the existing struct rdma.
> > No this is basically meaningless
> >
> > The wr struct is designed as a 'tagged union' where the op specified
> > which union is in effect.
> >
> > It turns out that the op generally specifies the network headers as
> > well, but that is just a side effect.
> >
> >>>> How about adding a member in struct rdma? for example:
> >>>> struct {
> >>>>        uint64_t    remote_addr;
> >>>>        uint32_t    rkey;
> >>>>        uint64_t    wr_value:
> >>>> } rdma;
> >>> Yes, that's what Tomasz and I were suggesting - a new template for the
> >>> ATOMIC_WRITE request payload. The three fields are to be supplied by
> >>> the verb consumer when posting the work request.
> >> OK, I will update the patch in this way.
> > We are not extending the ib_send_wr anymore anyhow.
> >
> > You should implement new ops inside struct ibv_qp_ex as function
> > calls.
> 
> Hi Jason,
> 
> For SoftRoCE, do you mean that I only need to extend struct rxe_send_wr 
> and add  ibv_wr_rdma_atomic_write() ?
> struct rxe_send_wr {
>      ...
>          struct {
>              __aligned_u64 remote_addr;
> +           __aligned_u64 atomic_wr;
>              __u32   rkey;
>              __u32   reserved;
>          } rdma;

You can't make a change like this to anything in
include/uapi/rdma/rdma_user_rxe.h, it has to remain compatiable.

 
> static inline void ibv_wr_rdma_atomic_write(struct ibv_qp_ex *qp, 
> uint32_t rkey,
>                                       uint64_t remote_addr)
> {
>          qp->wr_rdma_atomic_write(qp, rkey, remote_addr);
> }

Yes, something like that
 
> Besides, could you tell me why we cannot extend struct ibv_send_wr for 
> ibv_post_send()?

The ABI is not allowed to change so what is doable with it is very
limited.

Jason
