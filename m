Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6C920F3A8
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2020 13:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731509AbgF3Lhk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jun 2020 07:37:40 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5354 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731382AbgF3Lhk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Jun 2020 07:37:40 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efb23a00000>; Tue, 30 Jun 2020 04:36:00 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 30 Jun 2020 04:37:39 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 30 Jun 2020 04:37:39 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jun
 2020 11:37:33 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 30 Jun 2020 11:37:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MreBWZFXiN9aGx+et0BsbKgFb0H6RZRpcxfuFwukYgo06L0B4/G/wwxoiyBqBJmu05EedypYAhYEpOJ6uwpBxfuBf9lowh1DkZJFUVBh/bycmXWsv1IlhnO5yEGsOy47Rdya4tpNQrZvUfQ7lRjV6XT3EiyekvEptZPtlC3dU9XENyICZO+5hcS91jtWymNIpVfGlKjpMPBxTGH8rPwTlLlelQblW2/r37jVhQirl6lM27GmindJ5EXHtETAM0StKOfEjOlVle86iCz0/5nb7eDtPoRUUL8aDvqcQQLGrWsPVPrhekXNl+/30Pw70hycH5iQzlsHAKVD3ilc8G7ppw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxKWhu/ymOqwlV5XSvPLLSPcCAxfXM8PYKmc+H2wlc0=;
 b=URh6zxKRl6N9ekONTFShZVh/8AYPzii2c+9WKwnyF8AkYB31qrml1UteJul1UyNPCYs41nKBSv6yxtWgi3eTkT6Rv904dzMOq84pW7tRSRojUuoJaS9wiUJIl9cMFKSyDEcvKPZ+Oe8nQHhPGhZlO363cJ6ETbJmkquUwZXOswggrnvMYo8CYPBlTfH62GGzE3CZMrTxBWpGjLq6T17SV2FOOnNShiCW5vMj5vyrlCzX4BPpD+1S50nPdtF9S0jHu7FKsqoYTSPtyTwMrnEkoCrVnCEGcO79LD+HvrYsaz6molyMTcN9KQ/09QT78ozcKpL1lb6n6c4wu7tUa4muXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3403.namprd12.prod.outlook.com (2603:10b6:5:11d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Tue, 30 Jun
 2020 11:37:32 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 11:37:32 +0000
Date:   Tue, 30 Jun 2020 08:37:29 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        "Yishai Hadas" <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-next 5/5] RDMA/core: Convert RWQ table logic to
 ib_core allocation scheme
Message-ID: <20200630113729.GC23676@nvidia.com>
References: <20200624105422.1452290-1-leon@kernel.org>
 <20200624105422.1452290-6-leon@kernel.org>
 <20200629153907.GA269101@nvidia.com> <20200630072137.GC17857@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200630072137.GC17857@unreal>
X-ClientProxiedBy: YT1PR01CA0097.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::6) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0097.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend Transport; Tue, 30 Jun 2020 11:37:31 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jqEZt-001XXV-Ac; Tue, 30 Jun 2020 08:37:29 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d39ae8aa-1645-47ee-df4d-08d81ce9f98a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3403:
X-Microsoft-Antispam-PRVS: <DM6PR12MB34031343024C79F520BEA8CEC26F0@DM6PR12MB3403.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 0450A714CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xZHX0alHAg9vz6OLTJWOeVRTQshEgqFmENwGR/Wz/BDMyA6BvZGFvvMAZJHiN5nEHdR3y+q9j9Q8nCzDse/VlteQGKSNRBaUhKifkoxuNpTl+wwXcvb/v4PtawF/P3g+qpwyQ4GeYO2RqEtfQ0tgW1TuslybsdsR9VkbCZqT+Ht934NtlbT2hTIN5Y64RpYID9HUVhBPP6HpawKMiwiyWeyznRfgHXIxiFduK7OnbuG+wm/JLjv4kZjfYKOXFcWL+99LZJLF5WMUPyBsGGm1puHycUzDCAPqyjHgSspTfvIk8vMNe6c/XzvG49Nv9pxbuWnaiWHIa8rVQozkmwCpvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(66556008)(66946007)(66476007)(33656002)(9786002)(9746002)(1076003)(6916009)(316002)(86362001)(426003)(5660300002)(8676002)(186003)(54906003)(2906002)(4326008)(478600001)(26005)(2616005)(36756003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: LLxH0yHHKVLfvolQqVnMLkeLbpqjcyXA7TU/T97g7ONnZ9MyLhwUU87TE7JoPDoIk82eerLgAKne/xZCjKvr4IjdXoZmB1sqpSukiR16qzD8LMKlf1ezi845BpIla5MpANmkZbVRSW+Muuq6GLNiAygolWZ/s9cs7qAlL6wOu3EQmEcgU0tl6lKFzyEwacSxKMHu1B/62kD1fXgKOx4G4100hREL4c1uiMANrPC6CtK11pkRT9pKzxFdT2UcX4OyqmzYrl2rWieE8THHc45SipONfGC8wYpH0pOqS6K4z532R5EMJMhq9VkoZQ9vpuUENIZYkGF+cQP01RCgZVArKjxuJE8bVAYJgzlDm+eWU3WzDHpxQXK3iNZzQdCxI5OkryZEreSEV2ZLqiHgibrwDKycIuU5Xsn+0Bsuo8ZCvjXYaCECHBvQ5M/FTQnTEazqLzAe9E+TmMLqQqzL23MNmB1RBcm589x4llruHIYTIOWY8qHdqPW+Q9LrcwF9kqXN
X-MS-Exchange-CrossTenant-Network-Message-Id: d39ae8aa-1645-47ee-df4d-08d81ce9f98a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2020 11:37:32.0786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zFVWh2cdKaAxrwvMcfm+qGcj79f4dB3O1e+3w/vnjR6r7sCoYFU5MJdQHCeLFLBG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3403
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593516960; bh=oxKWhu/ymOqwlV5XSvPLLSPcCAxfXM8PYKmc+H2wlc0=;
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
        b=Ycu/pPiiwhB6AyqNaqzrOD4m8++DBQlGrZI8gz7AU2aTon74ZRqHsV6u2d+ywm2pk
         zLxlu3Rz0VQxOFwlPaxVM7HvqVrPJuo/H6z70PLXzwH5wLnalQt9g2choS7SR8fCaS
         J+is5uQEZ3L6A5R1PHIYzuNfCRss40u9sD1YpNM3ScxGUAzxSDbLl+wn6UcNdHhTuY
         9QvScXeZTjS39s52j4Y2LFbl0gyqM7VXycIKhVoFXcyLy5whGLoOzwBQ/I8dnp7gg9
         kL8v5sjR4Xrf27Zx0ZsDo8mRuFmMPF2Q1SAsqmbmauNxggqEqM0AjnleamebDLWSow
         trdMAPwfUfqtg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 30, 2020 at 10:21:37AM +0300, Leon Romanovsky wrote:
> On Mon, Jun 29, 2020 at 12:39:07PM -0300, Jason Gunthorpe wrote:
> > On Wed, Jun 24, 2020 at 01:54:22PM +0300, Leon Romanovsky wrote:
> > > @@ -4018,8 +4028,7 @@ const struct uapi_definition uverbs_def_write_intf[] = {
> > >  			IB_USER_VERBS_EX_CMD_DESTROY_RWQ_IND_TBL,
> > >  			ib_uverbs_ex_destroy_rwq_ind_table,
> > >  			UAPI_DEF_WRITE_I(
> > > -				struct ib_uverbs_ex_destroy_rwq_ind_table),
> > > -			UAPI_DEF_METHOD_NEEDS_FN(destroy_rwq_ind_table))),
> > > +				struct ib_uverbs_ex_destroy_rwq_ind_table))),
> >
> > Removing these is kind of troublesome.. This misses the one for ioctl:
> >
> >         UAPI_DEF_CHAIN_OBJ_TREE_NAMED(
> >                 UVERBS_OBJECT_RWQ_IND_TBL,
> >                 UAPI_DEF_OBJ_NEEDS_FN(destroy_rwq_ind_table)),
> 
> I will remove, but it seems that we have some gap here, I would expect
> any sort of compilation error for mlx4.

Why would there be a compilation error?

And it should not be removed, it needs to be reworked to point to some
other function I suppose.

Jason
