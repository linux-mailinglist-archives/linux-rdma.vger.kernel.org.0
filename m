Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1FA53684A5
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Apr 2021 18:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236333AbhDVQSr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Apr 2021 12:18:47 -0400
Received: from mail-co1nam11on2043.outbound.protection.outlook.com ([40.107.220.43]:34144
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232670AbhDVQSq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Apr 2021 12:18:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyDwbPQnk6wgRNPC7wBWx0LAOWHXEqQnSaG2jDS8a71GQZ5eGPKtO5pe/xrBjplqQdERIbmVjhOnmtLDzbCTyWYAApZeOdzAqcqAAMHmMZ7CqszUjTuZWJUsdyg/t36OWNsLeUXt2gL1D6aJh/ngVKiqLNsjNisNIJqeVUXVcs1n8M+kb6VxZdg8KRH/heo4l86Zjhw66q1+2PBLmPZ3nPGTPRn7M5FJ+9+lMSiLFRL3QtFdzWshlw5UN+8ZQj2OcHpxEoT5RIDP3ZAJPbTUu/znHs9YEpQ7D9V7OqzjgBL3QINwCZKxyOles8pvE4S+/zho40ajf/f3ZZy/dF94Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UXan5hvPqSigyZBvPlDvl5I3yP2OCqfWbkE9AgNyWY=;
 b=FoU19PV9h+EXv9LUnQtu8/J4sIAU41R3r7Xghz1QkFoHQf5S1mKLh8I6yL+rQSWwto22Vk470k7+1lLt6dTQaSW8a+8WtRZK54t/Eo/T7VAgrfgaXiAsR6btOhvXZIs/3lCsIKcUSPjNULFD4f0zVztpMw9g4rBiQxrPNZ8bBijgt/wsXHO6a/cWJi41lXhZkUiD/SEOqpzIbibE/azG3S7NQuEhYbkenf0yfeP5cjlD4qc6hk6LzZm1pvKzewoM9SHMj4t/+++7SCwYb1UjAylhGVpRi0gR9XA6U8086ZootU31nzhFbS+8H5T7W0KQgU0y8zur+WlktqF7QtEZGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UXan5hvPqSigyZBvPlDvl5I3yP2OCqfWbkE9AgNyWY=;
 b=TzS8S8pNBUQFJXnbdu2aPHlHeRm2XZBPkc4l7azpAVNtllsnU+NPn9kaD5ko5vhsGGKWOXfn7X3DuP9evrnY1wvPTxcVy80lIzC0q1SiBz4/H9NrToWSBys84eQJVsDiStXz6HoTjd+kjCnVYXDhQchUEhBxLlLpfr3j57TzPynXN+qvnnSrHU5iQf8LULsGAI88eUVnZU1TthYHoCyqAwM5wvNKwDonT/dF2Km4CwUw23ccqcv8Fr1b5Xv5HTp8HSCoZ0w4oAFWncVg359VaDId4x7PKMEupz2yu0s/SQs7bY3rPoyalGyjShx2hMHIQ2ib5rHymOZbeQYFxk7Cvw==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0107.namprd12.prod.outlook.com (2603:10b6:4:55::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Thu, 22 Apr
 2021 16:18:10 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.023; Thu, 22 Apr 2021
 16:18:10 +0000
Date:   Thu, 22 Apr 2021 13:18:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Shay Drory <shayd@nvidia.com>, Doug Ledford <dledford@redhat.com>,
        Krishna Kumar <krkumar2@in.ibm.com>,
        linux-rdma@vger.kernel.org, Sean Hefty <sean.hefty@intel.com>
Subject: Re: [PATCH rdma-next 2/3] RDMA/core: Fix check of device in
 rdma_listen()
Message-ID: <20210422161809.GZ1370958@nvidia.com>
References: <cover.1618753862.git.leonro@nvidia.com>
 <b925e11d639726afbaaeea5aeaa58572b3aacf8e.1618753862.git.leonro@nvidia.com>
 <20210422112802.GA2320845@nvidia.com>
 <1fca1133-8cdd-8b21-42cf-69d610b4f8f4@nvidia.com>
 <20210422125135.GV1370958@nvidia.com>
 <YIFzoJOVvZPPJwwy@unreal>
 <20210422130218.GW1370958@nvidia.com>
 <YIGPCjiXAR2aFO9S@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIGPCjiXAR2aFO9S@unreal>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR15CA0023.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::36) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR15CA0023.namprd15.prod.outlook.com (2603:10b6:208:1b4::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend Transport; Thu, 22 Apr 2021 16:18:10 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lZc1p-00AB5Z-Aj; Thu, 22 Apr 2021 13:18:09 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50def9ba-9683-4d43-5d27-08d905aa38ba
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0107:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0107695016CB8E049BCA07E0C2469@DM5PR1201MB0107.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RO5I95HjI8rXJBWiE3mJVzK/Byzj3Iv9gLaGdcI1xyQJ/tyHftXwqccukSieUOXapuUbvdTSJhECnfUT9fFgP1hAUUGOkRjvLzj3XLSMGTqQ5RzY4YxwOzmcPpBNz/MIavYEUfJzKQCWBZdZqGP0lYZSlpfLyr2NCsBlrjhgSFN7FywNcFILa/McFoNltLVH8zGmLfUvX+ZEpFOwQLryvRTQ+d9aNG789I14fR+FLPcR2uSGpZzM9UDw8jIUi7wEuuu00eMaDkBgJws/P9xxQWwjg0bi1Dx45mF1Ar6Zu2eoXBsTwzKSdJPeyvmLDeA2B6qeTkVScpiWGTmu8m4eNiQ4bV3OTtCSFBYqLhMppWMecK3HucqayJWzoQNYZlA2jgKh4apSlqzfvfxoDud21tatw9CPHLeVAPpMAHgqau/mHXoGvtQT4rvemRlkhhZ/Xy4+dA0b2DhwEzQfWuXVwnRzbvGnaIP7TwybYa90T7HfQaTBq0Xar6ooqYSIHR+HwL7EflOd+BxfLlCKFMAmEqPBmo54BsmxHQz22eLse64Qu9RFJ8W97uT8BxXhvA2v7sHTbmfQItIJTY4QH+yzJb3+3JVMSDbj8iFUfizDWdc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(26005)(186003)(8676002)(9746002)(1076003)(9786002)(36756003)(66946007)(6916009)(5660300002)(33656002)(66556008)(66476007)(2906002)(316002)(83380400001)(8936002)(54906003)(4326008)(86362001)(2616005)(478600001)(426003)(38100700002)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?x5hEGCcGGOYTmnffP3/+lG/bipOo6JJ3Q/7uMcF8AlTX38mpNt3SdVlvUG+m?=
 =?us-ascii?Q?DI/Vtfmy2sFf2QbIL7mulaoU4EKK98aVosjWJ9763JWD1shTA/RUjyNdfXHx?=
 =?us-ascii?Q?etDuspgMXVgCjPIggRl5P7uEOWT17J6H0S0xSX48vwBJb45pvn8YelOVzcR5?=
 =?us-ascii?Q?BlBVRbe3oCr8dYjb7TEsuZCxFQ+jFUe1wiKy+Xk4SJ88D1J4SsM92p5S5NzC?=
 =?us-ascii?Q?L6n0Zg/MTDQcbAmn8tYPq9o00bsmLecf60BD4m9tiN5R62/kKamlXjZXluqB?=
 =?us-ascii?Q?rWTaJ/zYh/pQNvJBz4Dw8HYjrBe0cs+PoVttK7A5a5wgZFj4XkDzwY24Nybf?=
 =?us-ascii?Q?vqKnxYTQBS7EyuxxrXWDj1caEP7F6pmRDSr9vPUkHPkoLEH/n4M8SpYVNUn/?=
 =?us-ascii?Q?XVm+TsAiyDbHWgZemtWBy5kaN3iVtCzvfz2I18MJmVmQv8kkINwwHW7bkeJd?=
 =?us-ascii?Q?9B/vn/bkFR8P+G9zoGintB7IsbK7FuLdcx0TUQI30zgHaiIBlr5MhcEaBTX8?=
 =?us-ascii?Q?x/vf8X96/QkUnIf3juO7TPXaw5waVyk18veNFsfzABDrNkVFreL0T8bSPSxa?=
 =?us-ascii?Q?aYccYni0K4rFObgjhw34oeeOgy7NQy6O8NcyC+5TgHtTay2ksa8TEpKOKcZf?=
 =?us-ascii?Q?uIjSwlkZApcL0X1vjZqNemPBR6HKF9m3Ymeek3SQrUQBUcKCYQ/GgEfBBcIe?=
 =?us-ascii?Q?O8YagMJEXSqL984FQRkiJEoNCT1bQrTHUiVeFosbUN1UEHcyIteVdziQStQ+?=
 =?us-ascii?Q?BAeQba5B47bFlwSZ2g+/XZbU4bOFU2y+yaHuoVHmKTJKY/7KZ77O+Qq9p0sT?=
 =?us-ascii?Q?QWcKH9stxJYb4yEkou7+z7/Gqxs3B+LHfEdLon3RvxEZOomTSIXA3RLL+CCw?=
 =?us-ascii?Q?zARU5aHapJDqqMMtH5IQzNIweAgpf9we08bUo0JzCVt0W9HJn3QKf/K/zBfe?=
 =?us-ascii?Q?teMH6kCDNuyzxjYOmhPSPXWLWYpYRpKlIQD8SQ3kTArOnsBJjIGwdLiPUKOw?=
 =?us-ascii?Q?9umgu5Toh+bWoVx0Xh1yyUTW9rOdgTtpyIwCp/DDwR2ZwqEbiUZUkqMtTSeD?=
 =?us-ascii?Q?NgyES9d1mIVJo8pLwvwLQvmMHydfuhMAHXxereyerl3Sfxe/74nzEct1MCMn?=
 =?us-ascii?Q?7YeZchraqiQB3PzEpgFZxAULvyeVp+lMGsLn8j5YfMZml9jeq0VDuEL0Kk3S?=
 =?us-ascii?Q?CnUUnuOB1T9YcTfA5tt1qQTu9ToNJpebk/jyCxSCSLKDbt0WtjKGZV/I388w?=
 =?us-ascii?Q?5E72NZ0i5nJjHuLJcw5uvu583DLfeK/pSaeUVMLYrqekd4bppyVvSaLHjrC5?=
 =?us-ascii?Q?oibpzhlHKiOlQjVdJLjPBHbJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50def9ba-9683-4d43-5d27-08d905aa38ba
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 16:18:10.5421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ofO64xFhpVydIUU5BoYBltySGoeQGMUXlgi1ZmB56XW6eifduDoQsYsSVWDfG/81
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0107
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 22, 2021 at 05:58:18PM +0300, Leon Romanovsky wrote:
> On Thu, Apr 22, 2021 at 10:02:18AM -0300, Jason Gunthorpe wrote:
> > On Thu, Apr 22, 2021 at 04:01:20PM +0300, Leon Romanovsky wrote:
> > > On Thu, Apr 22, 2021 at 09:51:35AM -0300, Jason Gunthorpe wrote:
> > > > On Thu, Apr 22, 2021 at 03:44:55PM +0300, Shay Drory wrote:
> > > > > On 4/22/2021 14:28, Jason Gunthorpe wrote:
> > > > > 
> > > > > > On Sun, Apr 18, 2021 at 04:55:53PM +0300, Leon Romanovsky wrote:
> > > > > > > From: Shay Drory <shayd@nvidia.com>
> > > > > > > 
> > > > > > > rdma_listen() checks if device already attached to rdma_id_priv,
> > > > > > > based on the response the its decide to what to listen, however
> > > > > > > this is different when the listeners are canceled.
> > > > > > > 
> > > > > > > This leads to a mismatch between rdma_listen() and cma_cancel_operation(),
> > > > > > > and causes to bellow wild-memory-access. Fix it by aligning rdma_listen()
> > > > > > > according to the cma_cancel_operation().
> > > > > > So this is happening because the error unwind in rdma_bind_addr() is
> > > > > > taking the exit path and calling cma_release_dev()?
> > > > > > 
> > > > > > This allows rdma_listen() to be called with a bogus device pointer
> > > > > > which precipitates this UAF during destroy.
> > > > > > 
> > > > > > However, I think rdma_bind_addr() should not allow the bogus device
> > > > > > pointer to leak out at all, since the ULP could see it. It really is
> > > > > > invalid to have it present no matter what.
> > > > > > 
> > > > > > This would make cma_release_dev() and _cma_attach_to_dev()
> > > > > > symmetrical - what do you think?
> > > > > > 
> > > > > > diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> > > > > > index 2dc302a83014ae..91f6d968b46f65 100644
> > > > > > +++ b/drivers/infiniband/core/cma.c
> > > > > > @@ -474,6 +474,7 @@ static void cma_release_dev(struct rdma_id_private *id_priv)
> > > > > >   	list_del(&id_priv->list);
> > > > > >   	cma_dev_put(id_priv->cma_dev);
> > > > > >   	id_priv->cma_dev = NULL;
> > > > > > +	id_priv->id.device = NULL;
> > > > > >   	if (id_priv->id.route.addr.dev_addr.sgid_attr) {
> > > > > >   		rdma_put_gid_attr(id_priv->id.route.addr.dev_addr.sgid_attr);
> > > > > >   		id_priv->id.route.addr.dev_addr.sgid_attr = NULL;
> > > > > 
> > > > > I try that. this will break restrack_del() since restrack_del() is
> > > > > using id_priv->id.device and is being called before restrack_del():
> > > > 
> > > > Oh that is another bug, once cma_release_dev() is called there is no
> > > > refcount protecting the id.device and any access to it is invalid.
> > > > 
> > > > The order of rdma_restrack_del should be moved to be ahead of the
> > > > cma_release_dev, and we also can't have a restrack without a cma_dev
> > > > in the first place
> > > 
> > > We have restrack per-cmd_id and not per-cma_dev.
> > 
> > No, restrack has this:
> > 
> > 	dev = res_to_dev(res);
> > 	if (WARN_ON(!dev))
> > 
> > And here dev will be NULL if cma_dev isn't set
> 
>   127 static struct ib_device *res_to_dev(struct rdma_restrack_entry *res)
>   128 {
> 
> <...>
> 
>   136         case RDMA_RESTRACK_CM_ID:
>   137                 return container_of(res, struct rdma_id_private,
>   138                                     res)->id.device;
>                                                 ^^^^^ it is not cma_dev

The invariant is that 

   priv.id.device == priv.cma_dev->device

(this de-normalization of data exists only to allow priv to be in a
private header)

If cma_dev == NULL then id.device == NULL as cma_Dev was the thing
preventing the pointer from being free'd.

Jason
