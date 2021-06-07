Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D7839DC05
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jun 2021 14:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhFGMQK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 08:16:10 -0400
Received: from mail-bn8nam11on2088.outbound.protection.outlook.com ([40.107.236.88]:49889
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230209AbhFGMQH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Jun 2021 08:16:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVIVNJdM2DUfIZ+ykQsx+qzxdvDlDvwxTQ/AMRkrLI7WqxkdNTGFYRHLMFXq4QK3t3epobedYpYdfl/x8iHNP647KqCYRDtMIeYvgmzx6Ps0cLkXpWc/aANcqNIOh1zHeEy0Q258gWNYf84tolsplVu4lVctpTFWj0U44w69FD6G79TUmASm/3Y73AfhO2HD4ZMaXrJhcrx8Mv6NjSFCypMnoF2H6j8FGkyZUTEB4+WQ4q8AiYyHWRkdbDpV8RX48/Zarjs19B9s+nH7vibmnxbDseSDK0M/p5hgQ7qgBskMrk9Fp9/9e7Q8X8RszIp1wJSkmcy0mGFX/ecfst38Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GlhoFvrBgvEEpTTJB56ttHNxbEle3s9e54BpEp6W+k=;
 b=Q5rrbBM00SeTrCnmpB1g3qQIXe12EwnaJZVXHSY3Xi6oX7DLVCalX00cxJ05dAfb/hbESuxWu3asyyxlAd0yHMgfp7OGPctCyME+grPoXNELBZ3Hqsrj2cmdcY7F3QH7v7cRXIi4AsYqNRECpRegE3eiY4qmBAFfvfLioDQPjMPSHOBkhGmpjCDfjNHGV7jEXkQ1ceYcHls6y/5IPo1wKfGNzhgrLWnjBChLfZkgUOb5sdvszgS02Sic94qA+80rd5WIcE+U0EIRmLGXV61hZpTqh1Q0mXz1Dcgx7ZSvCdR8LB/XVSCRHLZHuZeIvvk9kdtLVQThkil4yE4sFg0urw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GlhoFvrBgvEEpTTJB56ttHNxbEle3s9e54BpEp6W+k=;
 b=E2k+UnQV2W1zaGFPQnXnVBEKnPhw6yQF67JlhgvXm7HlGz3Dbmcg05lDeH73mo2YfnOq//RUHw/U6ynO8LNt2HfSWYObov6DKvf5Yb5uU35XVCD2+7JUtyTmqqRy+kKP+MuyDzl6Mn2OZLpLYloBIJcZHam+9RsSP7uXA7UyWCGtw6eBC7iQoMzL2w9QLvtCNBWhTRYFh+ghz9hmYEBtS3ugTL7YAjNJJYj0JZf9RtlCR+zDJz732AIGGcKlGguJsBjqw4cSAWnpu2Yvczgp9tmlHCn4b5HYPzxwXA4M3qCQpwtVHfl5Y/3xlnzLh8W06JIXahZG+RDfFW+LsqYVWg==
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5047.namprd12.prod.outlook.com (2603:10b6:208:31a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Mon, 7 Jun
 2021 12:14:15 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 12:14:13 +0000
Date:   Mon, 7 Jun 2021 09:14:11 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        clang-built-linux@googlegroups.com,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Gal Pressman <galpress@amazon.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next v1 10/15] RDMA/cm: Use an attribute_group on
 the ib_port_attribute intead of kobj's
Message-ID: <20210607121411.GC1002214@nvidia.com>
References: <cover.1623053078.git.leonro@nvidia.com>
 <00e578937f557954d240bc0856f45b3f752d6cba.1623053078.git.leonro@nvidia.com>
 <YL3z/xpm5EYHFuZs@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL3z/xpm5EYHFuZs@kroah.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BLAPR03CA0139.namprd03.prod.outlook.com
 (2603:10b6:208:32e::24) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BLAPR03CA0139.namprd03.prod.outlook.com (2603:10b6:208:32e::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 12:14:12 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lqE8x-003GId-TF; Mon, 07 Jun 2021 09:14:11 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a48c6dc1-5813-4368-1ac5-08d929adc318
X-MS-TrafficTypeDiagnostic: BL1PR12MB5047:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5047DAA0C4C12CA108776FB1C2389@BL1PR12MB5047.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6O7NDsNbqlKiyWmp36wHnBrocCbTvDBpuRcAoKOya/S2R+/8icgLWs6us+tMnkJNqZJ7puxPccSwUrwr1ozs6mg3ALSijGVmG3PK7hk2qc1faDnckmFlGEUDDs16u9+c06siLrfMAstHqd/4BUEPh8UogMVbI+v6PBHib3Hi0RTcPNHgxs6g3IQ42BHUtJkPoaqKhr3ARv4XaVjdUO2bkmtRInopNXfHz0U5t91f/+s/1YyfSDIDXG+FQgovLGcm2csMMAjcXsDx4K8tJiKyNxHlnoh28EugH6WjJskpaJQD7TS3haXM6erkKX0hyXa1eyVe/08AzwPsfc3tU76u5sd99HAn91QJ2iZAM7sk7BUGDTZHekCMxq5JGxx1ZZVuFPBjwHosP6UAErzHSoDXFJES/ypfHeG7FicCHSobHyJceYdydwr+te8+kUQWSobDcgI8hBJhDvkVFS9NaTU8mEkVlRvFJeFpWYJZphIbSuDKwwXPSDTRDA7Ufag9a5nN2tWO5YVoCzTxV6sfpBdVS/vaXW9BrmVgrJc3g8+gisP1ivL7UzQ/Cy7HTm7TfCTS3rGY4XFEgvHdzCrbiuK5eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(8936002)(8676002)(4744005)(6916009)(478600001)(83380400001)(5660300002)(426003)(38100700002)(2616005)(1076003)(7416002)(26005)(316002)(186003)(66476007)(86362001)(36756003)(33656002)(54906003)(66946007)(66556008)(4326008)(9746002)(9786002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?u6zhcPsbzJF60/EsNTYg1Ek+HDGsrnolvkHsfxTAu81LvoD0JYsw6r5J5xjq?=
 =?us-ascii?Q?8M6Rd+6vtLGUrVo5d4/flbASLWPjGxL8P50MT2Da8/kB38WQAWAv9xXuOhZN?=
 =?us-ascii?Q?aBW9lplRxtYLCv1ufmAb+Cj7FcJqCIQKaJOrt31/uxvF59QyKLodrpVi57p+?=
 =?us-ascii?Q?Iulf4fUCyB78LNxCoki4AwNy6BVtuPQEGp1nsvds6vwzTcH7W6MCokf8QL8G?=
 =?us-ascii?Q?4JZKOuMhFd9o39D7qmOvSBZOO3pAnkIEwTMts/+Sazkirqck06VsI+EnSCBa?=
 =?us-ascii?Q?u2+4ePnmg4JrvypACPCbAgkzSsCD/uXrDxrRj5uQCwFdKX0TpZdFU63Z3M0N?=
 =?us-ascii?Q?3NQu/8wlpGEyhyCH7fDXPzn0Ma5XtsSZmn7LWhZVNCTQFpJesObQ58hkl+kT?=
 =?us-ascii?Q?Zbef39RwSPqAYUg5Q4hiel2YmkDA1GZFJ1vU2c61uQjlIdX79bEFzXKHI6oX?=
 =?us-ascii?Q?WwZKxqXlTaZGtUPvFxWOna7O2u8759YEiYvSzBMTV3EELgBm2ffSqoV1sy5M?=
 =?us-ascii?Q?MhLziThFuxgw7iQpwhcPgilWHHEHGgUMha1WXXJ+XlgyJPys88qcGqeS30q1?=
 =?us-ascii?Q?CkTtQ6YJEeaN0fRucHwpZotiI4Kj0zrz2gs3DLKBBFkpDho2nYkF61qtKFDN?=
 =?us-ascii?Q?sDBt2UHsyIaZlHWnLiVmhTPshF+PUfLwKu491yYQA+q871hvCuaPU//veG7s?=
 =?us-ascii?Q?dlm6pOS4ZtsM74MmoDOL9/6yBq4vfMQNr1YuvrAKvVbDla3mUUrcZPZMQJwk?=
 =?us-ascii?Q?e211/xDAK1FX3t3ZKxnPz5/dxdWtzi1dOBd6jPfPytFVMNVAD+D/IkNUEVoy?=
 =?us-ascii?Q?XMxppbxuAZhIaUcCQsbE3VDpzNpq569O/NA0jzanb0S20aoC31L0TUQZhxP3?=
 =?us-ascii?Q?8+jaenlopwKUJ9FVeZXQ8OBvENRg5m2Opc4DuFktfAUJG3geUdSr/0cOYjHs?=
 =?us-ascii?Q?YpIYn1bN/ELezvkHz9/ecr9Eb03GUaKE0wuaGB0ly1D1ftgHLQhko1MiwUCy?=
 =?us-ascii?Q?LJ70HPW6bzJ7rDeCLwOeaPQJ/M4JU4T7OP8SGS1TZ90fhD7dz/kSYRQy7joV?=
 =?us-ascii?Q?h5//wcZh/ZjD1LrvkjEZAeKgQKVrItBxl6m9rfobg9URMDgIhqsDwAAtvd9T?=
 =?us-ascii?Q?uq2Ro+KBlLH3MkRTvKft5dAO2j6rw7Ad0vqCG0AiN6kXi/yQtq2MaP8+ACpB?=
 =?us-ascii?Q?+X5DW8vcaxn2Eg9kNnGSC8VD3cFPXYMHnW2jGIUn9Qr4G5zPiacchh8pBLzc?=
 =?us-ascii?Q?IaK3dDwR3iAfX4XD7GiNHreRYF+o4Jfa9OLhj4IegPEZzuwvQ0CLCdUfsEXU?=
 =?us-ascii?Q?oEeSWnOTE0b36iZTXFP/a4Qr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a48c6dc1-5813-4368-1ac5-08d929adc318
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 12:14:13.1014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85v1dMoRgRsG4fTYChQWHxsnjY0VHN1N5zuFX2Kj5VqX5XalML9F05BWE0mKD8t1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5047
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 07, 2021 at 12:25:03PM +0200, Greg KH wrote:
> On Mon, Jun 07, 2021 at 11:17:35AM +0300, Leon Romanovsky wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > This code is trying to attach a list of counters grouped into 4 groups to
> > the ib_port sysfs. Instead of creating a bunch of kobjects simply express
> > everything naturally as an ib_port_attribute and add a single
> > attribute_groups list.
> > 
> > Remove all the naked kobject manipulations.
> 
> Much nicer.
> 
> But why do you need your counters to be atomic in the first place?  What
> are they counting that requires this?  

The write side of the counter is being updated from concurrent kernel
threads without locking, so this is an atomic because the write side
needs atomic_add().

Making them a naked u64 will cause significant corruption on the write
side, and packet counters that are not accurate after quiescence are
not very useful things.

Jason
