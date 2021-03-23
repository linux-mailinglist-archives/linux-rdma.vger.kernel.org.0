Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90490346340
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Mar 2021 16:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbhCWPqi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Mar 2021 11:46:38 -0400
Received: from mail-dm6nam11on2054.outbound.protection.outlook.com ([40.107.223.54]:34561
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233072AbhCWPq3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Mar 2021 11:46:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2oR9kUZeQCqSVsjF//kF2Y0ejMYLpJteQ9I5olFfCwjheuqEVnkcpMvuERuKw4GRI4uTjlkxSXhatQ2GHsQSTpmZUT4kLLRPZ6zT7k6mHJj/E2XbV1aFVFrp4bZnnNYMFAOpUd/2VvRKQkXh1K8BPXQ4p6I/56saCnslFNKCzMgXmKs/dhBjBmm8A01YWQsrrQmFZ0sHCsOgf1jkMhLZv8jq8fxk78wPTJfs/zHjKudSSE5bPwtTdj0U40JUnfzvLBBFUoxTFQCuMUmv+s6LDhwtXdvFDqU/vjbiWgMj29ONQyUVGgcA+GAW2zNCQwcjANSGABky1c2V3f0kU5QVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7ecmpldNq8RL8QWS+1RxQE9Ed5iuLKO4CNEk27BWrs=;
 b=Q/MvmdrC0q1Fie4mJojTxwbkDvODHry2/imF/wcjOhh5Jnya8zerGrUUZla+Ng6XXxGODpiKJA2CR8k4mO89MWXQgEZYHpWf9THqztDRZDUdfocIHye7lKxup8ud8q1D2diyEIOJ6vVOYbuxBC2A4enMmxgQCVaJXc5ILoBGWSPv0OyftwCkBi/Mv26Y+GPZqOhOkeZklo/hFvx1QjRoSDtiMHBaM7loe5VPRKIsZLGwgNI8PTo4eH1v9IsOoS5GjZHOvM8WfqtHCotLNauWteE3WeCUtHjfXMa2kkOAlA+o+Ox2pCVk2eBjDzxjU7vQaLqSEDRAG6IV/IKbc+CGOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7ecmpldNq8RL8QWS+1RxQE9Ed5iuLKO4CNEk27BWrs=;
 b=d7oeBEjgxt7QwvGCKDpAzO+rmzcSy1fGocs6sQK74vv7HRBgFU+QRoh2bC/mGflPcCsWuLBrTsvUKy+mT0VLrmfWZEOFBecDyvqfH6Vv767Sf4Ce6zoL9EoTzBONkvqt7TBz/PAoiRvlUHDsdC7Bdzts3K8K1YBoyarch4Z46TaTDNKuiFqB0KBwiCwLLzxoAnYe1b/li2afAeGWUxDOw4T4bV+hGBBz59nvJtrX4e6Vtk3FXhcFnjl9TcWOK4XPOf+jBK3i90UCkF4cquvMxjEseYQtwEaSThq77QnFwL9nUyq5bwQIXIY8PLVWYdnxwsW49zXfpBgwTX79WOXCzA==
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2860.namprd12.prod.outlook.com (2603:10b6:5:186::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.25; Tue, 23 Mar
 2021 15:46:27 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 15:46:27 +0000
Date:   Tue, 23 Mar 2021 12:46:26 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Rimmer, Todd" <todd.rimmer@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        "Wan, Kaike" <kaike.wan@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH RFC 0/9] A rendezvous module
Message-ID: <20210323154626.GH2356281@nvidia.com>
References: <29061edb-b40c-67a9-c329-3c9446f0f434@cornelisnetworks.com>
 <20210319194446.GA2356281@nvidia.com>
 <BL0PR11MB3299928351B241FAAC76E760F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210319202627.GC2356281@nvidia.com>
 <BL0PR11MB3299C202FCFF25646BFEE9B6F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210319205432.GE2356281@nvidia.com>
 <SN6PR11MB3311F22207FDCA37B3A3C07AF4689@SN6PR11MB3311.namprd11.prod.outlook.com>
 <29607fd4-906d-7d0d-2940-62ff5c8c9ec6@cornelisnetworks.com>
 <BL0PR11MB329976F1C41951957E2DBE79F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210323153041.GA2434215@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323153041.GA2434215@infradead.org>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH2PR16CA0002.namprd16.prod.outlook.com
 (2603:10b6:610:50::12) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR16CA0002.namprd16.prod.outlook.com (2603:10b6:610:50::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Tue, 23 Mar 2021 15:46:27 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lOjEg-001ZGg-Cr; Tue, 23 Mar 2021 12:46:26 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e817e61-747e-4e00-fc2a-08d8ee12d22f
X-MS-TrafficTypeDiagnostic: DM6PR12MB2860:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2860388873253EB4B6C72A9FC2649@DM6PR12MB2860.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:398;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vfwhh5mJVMZGVh3g+251J5prEpV2ITxw05dr+oDksJNNyf8BYtS/wAoY3mnOsdEmlV8qAclv9k+mqbNGn1erxIyrZjRTMm6DS6CkMwG+2yoSXkUlA9S2SX7Wk/1bSHRwvCmZG8HFi3HMe6dxjqnntkXDRdpNCnN+VBGBrwvtHYhsaHmB4pdydff8EvNVKfay0I1YNjaTr1W+84rugaKrdVLxe3HYvIcmGmpZrjU5Dfa7dtZYnwwmmmr4OAVf2phoInv/DJfOdXpa/mDS2QCbsWADl9MC07qqwwOGb3LYpC9neN74tXpiUm3PjnpeoUNCdh7Gblz8Sg4RtuVtRGxZYX56s6boPS1Ck09s4Tci27Ap/CO3H8JizASm/xzqLubd2BC6xx2GhKCxu5XquucpA7jr6mxbvycaeo1mmawgBb9nqRUKKdlhb6pAtuK/vyCdWDpC6tz0p9W3uiXh2Bk1XklB6tUWSRSM22omLWxnyOb2k2QB962Vq6Jo2I4Kn8KZHY12z54LOr3knC3LsRpIKDLtRZY/+S0wkbDNHcczKr96nsB08jiLu1MaZ3FryaHXVpsLYyv6V2S6Aq5vUYtK/sveNl/QORC/GXL46BqjwU3kYGcnQxxLbvzUPg2vFA3lcG1ky9R26XHkIm8oW0DcI+ueus7Y5iPUhX5QuxO4KeQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(36756003)(38100700001)(66556008)(66946007)(4326008)(66476007)(1076003)(9746002)(8676002)(26005)(8936002)(2906002)(83380400001)(2616005)(33656002)(5660300002)(478600001)(426003)(6916009)(316002)(9786002)(86362001)(54906003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FaCMBNb2TteSM/fQidqOrm9bRW2Mw7ORmfoeKDy+z7tEgBgGxxbaTpC8EW1Z?=
 =?us-ascii?Q?KVJ3JVpHkZww2sHB85rIqHg7nlfAEw1pK5hmeQSRkGTUYT3EzuvDfIiOHdxp?=
 =?us-ascii?Q?84Qh2J+kD+vgu2sRz7hEsUsKqOsV9g10DTIkGa/v/pVFOKKSO5KTTZa6J9bU?=
 =?us-ascii?Q?VNw6HcjEab8YI1lKIVf3hDGS/u6rKh8qI1ug4gTiYbfjzA53H5PeEMBhxwiC?=
 =?us-ascii?Q?0m9o1nsipu8hJG0R6VV6ufbaGjSei2/mok2MLIn7f26rxFN2QU+Ua3oH5lpF?=
 =?us-ascii?Q?xiB7pJMHsYiyK2Q5Xqh9VT4Eh/Zr95/VsaTyGTqBuQdL6wz/E2LMkC96f4zs?=
 =?us-ascii?Q?t1emQYP9dkS2S5dke7CJd/+MVz8e57Rc+tdHixMYl23KEW/NzsgdeDhQjTcf?=
 =?us-ascii?Q?lVFP0bkIWjQwHegTcs4HOZVQ0xmxHMyVS/5kloQXHvSZaErpOhTPCJZwOffZ?=
 =?us-ascii?Q?GrPe3mFtlncTY6RoVV10/FWZoX5MmmZAW0wt1+JewTEqhJ+eObMJKsnmfP2k?=
 =?us-ascii?Q?AsFT368qOFgZKiVszmjiDbPthn6qTytu/9Xmpr8ppxGRTY2Ozajiad1wxIvC?=
 =?us-ascii?Q?y8TFWX4yEL6LAx5HBeKHCEAaRbDOa3v3Wvz2e+ZOO5OprYSOboq9l0EOXo7S?=
 =?us-ascii?Q?WvPVYTjFXpLBD+nbKYBYOmHZKzCxggU+wW0NnXLhnNUtnsRw5F24kozRC9gd?=
 =?us-ascii?Q?ie3RHtOXI5S4DXSKcOuZMJFdrs/SuKSHmKtnUTjRL/FJ5k17mqbrT3USMER0?=
 =?us-ascii?Q?hVW9mtC/HBa5zCAXuYeIJiioqsHCAgczq1hp1/lxjCF+3osz5HIwxAgTaKYh?=
 =?us-ascii?Q?RDeRocIs/f8IWeMyEXoeaiFOvhCs0FrTxzO2XsuTGWhaX8hGmpMiGADiOcV8?=
 =?us-ascii?Q?0B2lKB2tplYwnU21xAZkus6x8r2Yyc2h11HbbvFmm8913Kb2IoQFAaW2DNKU?=
 =?us-ascii?Q?lgD3dOd0TThMWzYX8bJhoejeS6evbw8bNBnGxoZ5sBTbF0j2olxYfcsxGyQM?=
 =?us-ascii?Q?+F3uaWajkJ+sWi+U4TUrGIm7fzxD04c9RtENfsJEMZQVOc4mm0sOch5oQTjR?=
 =?us-ascii?Q?PZgrj/8athk/5KzxNjZ/SyQfHyMzqYPkjhSHy0D85U3PW+/eSWnkCoH3yivq?=
 =?us-ascii?Q?w/rWS1P4+msjWfycP61MVlW6ADCMwrjKxKcSBtlSCWVmGo1u335ovo/3MarC?=
 =?us-ascii?Q?bTbR4eqDCgKt/92iLOXK4nUM1zqp8R/eEvb8qstADhRoUXaRPeVx4lDDt9Jc?=
 =?us-ascii?Q?1DFUJVhFoad2JP6GWNzgiEEe59wxqfSL5Tc6VN2F3v513fB65GnztfSjbu9E?=
 =?us-ascii?Q?Co9J+IqIYtF7WGGZsbQTXV92?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e817e61-747e-4e00-fc2a-08d8ee12d22f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 15:46:27.7456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: POCXG+swULdsqWwwgFluudqLAGQCHUNKgUyjf8NwrTuKapi+UjZ4Cd8CAiv+xFqs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2860
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 23, 2021 at 03:30:41PM +0000, Christoph Hellwig wrote:

> On Fri, Mar 19, 2021 at 10:57:20PM +0000, Rimmer, Todd wrote:

> > We'd like advise on a challenging situation.  Some customers
> > desire NICs to support nVidia GPUs in some environments.
> > Unfortunately the nVidia GPU drivers are not upstream, and have
> > not been for years.  So we are forced to have both out of tree and
> > upstream versions of the code.  We need the same applications to
> > be able to work over both, so we would like the GPU enabled
> > versions of the code to have the same ABI as the upstream code as
> > this greatly simplifies things.  We have removed all GPU specific
> > code from the upstream submission, but used both the "alignment
> > holes" and the "reserved" mechanisms to hold places for GPU
> > specific fields which can't be upstreamed.
> 
> NVIDIA GPUs are supported by drivers/gpu/drm/nouveau/, and your are
> encourage to support them just like all the other in-tree GPU
> drivers.  Not sure what support a network protocol would need for a
> specific GPU.  You're probably trying to do something amazingly
> stupid here instead of relying on proper kernel subsystem use.

The kernel building block for what they are trying to do with the GPU
is the recently merged DMABUF MR support in the RDMA subsystem.

I'd like to think that since Daniel's team at Intel got the DMABUF
stuff merged to support the applications Todd's Intel team is building
that this RV stuff is already fully ready for dmabuf... (hint hint)

What Todd is alluding to here is the hacky DMABUF alternative that is
in the NVIDIA GPU driver - which HPC networking companies must support
if they want to interwork with the NVIDIA GPU.

Every RDMA vendor playing in the HPC space has some out-of-tree driver
to enable this. :(

Jason
