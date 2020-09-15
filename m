Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006BA26AD22
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Sep 2020 21:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgIOTJz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Sep 2020 15:09:55 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:26866 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727977AbgIOTGV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 15 Sep 2020 15:06:21 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f6110aa0000>; Wed, 16 Sep 2020 03:06:19 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Tue, 15 Sep 2020 12:06:19 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Tue, 15 Sep 2020 12:06:19 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 15 Sep
 2020 19:06:18 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 15 Sep 2020 19:06:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXF25usOiliBVXD8oUyR7edIWOeZRFTY97gy3/iVrXLnr3ALFJIk9MttiaA2lBPJcB5d4PgjuMQwo08I9qViFiqtp3szzzpOD/a6ew0HNvnd07Hkmkyvrb+PJ5mIo2SK2CAh/f08IbN73TOLkWDuDcmEYo52ur2u6oEzhHPBwaSoa32eRYV6lui7wY5ln4rpPhAxUULnGjgNDpnVLDnguWrzGlPp8PL2C1gnjnddZQnxc+VB7UpTFr+zihcdhKsMfD8sSq0bAnC0noKEkbw1XfscMGgNDSzJaPS8tPrv2neGi9y0FmaLC8zTS7DnDWMAOLRP92ZfSfDn0tlRgJCxrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25aPV0IOJyfKL0ksmW2VusOT+XKcGPFHElqfnOiMbH0=;
 b=l8Fr0GSQKlHBEpz40jS+qa55ukC9fmB9dhl0jmnB/OdIfRc4uNbopmzIZRARpDOKvidUnVXovpAnWuudYnN3xmWQ3ZrZIrOXP54NdbFhqITWRYBsrBkGdTGt+nW7SvbfugFP7lkMp/oPhSHS9GrROO4BAopbSEleeRuuzwRDYDNADMRcjStJNF0RJYIL/f7eoYiV3c9pHF/owwIAKbsf3c8A52dGyh9LbSWg9yMyGEwu3Ql35JdgSV7tOOI8ejm7sE6fVl0tNrQfnWqlT2NNyybcnNjqPJ/DrowmlHit7BardIkh2n+z9wKvSV1qnJu+eOJvePFQ9uDJSbMh5GD08A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4268.namprd12.prod.outlook.com (2603:10b6:5:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 15 Sep
 2020 19:06:16 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Tue, 15 Sep 2020
 19:06:16 +0000
Date:   Tue, 15 Sep 2020 16:06:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next 4/4] RDMA/uverbs: Expose the new GID query API
 to user space
Message-ID: <20200915190614.GE1573713@nvidia.com>
References: <20200910142204.1309061-1-leon@kernel.org>
 <20200910142204.1309061-5-leon@kernel.org>
 <20200911195918.GT904879@nvidia.com> <20200913091302.GF35718@unreal>
 <20200914155550.GF904879@nvidia.com> <20200915114704.GB486552@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200915114704.GB486552@unreal>
X-ClientProxiedBy: YQBPR0101CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::49) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YQBPR0101CA0036.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Tue, 15 Sep 2020 19:06:16 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kIGHO-006fBC-C5; Tue, 15 Sep 2020 16:06:14 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba916fc9-88eb-4bc4-63b7-08d859aa6bdc
X-MS-TrafficTypeDiagnostic: DM6PR12MB4268:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB42688F89F0438163EC5C9F82C2200@DM6PR12MB4268.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i/9oy/9nt1ubFP1lOnjDzWD8L6FtwHUETRwVoUnmA3/en9hmnQvudWoi7gjO4B+BxpKSRTcWVG57Re9ptKWsvJZI1vHd+Kl+IxKtXHOR4fdspqB0idMpUXQfsAPueTgZevnlMfqURi7NYAIzj7tiHIKJ/W43ckfmdy2z/2XGhFcbdRpbPPWpvY4VTS/s5t4dWMz6rtFfch43aSthCaCPvUZzwR1X5YAtitaNpwNCtjCecFpK854qhysA7YjPCBk05bRmUTq8UES3dTe84fMgcIjYFb/OAcqI4Wp37YfJggizAMfdWcRPOTh41Ez7S+vk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(1076003)(8676002)(33656002)(186003)(426003)(8936002)(9746002)(5660300002)(86362001)(83380400001)(66946007)(4326008)(478600001)(6916009)(66556008)(2616005)(36756003)(9786002)(2906002)(66476007)(26005)(54906003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: NNQjBpTsDqNgXOJRl2mS6+YeIV91iuzG5iwTEYQMZ6EoNaQOgMQL4FexFiNBltQwH5qNK+Wd4C0Qlq0HWUJ8/MRwbt+dwLotDEudYHBASnSnKrq+Q9tOX3EeYsTxA6Yi83VnBzGGSGmO/51s+NAD7xcyialoygCJw4eDEKwGQCGeM5N0gVu0pGFYfxss4T0gKPfEH0O2QuzF8a7/5d7XfIJTaw7CGr2jKEAT+jLwBW0wgemvJ31ZtITJx/il2oyepwSrByhy9WNIhR6KUs5HUK4GVXbONiSYom4h08GNyXLt0ki1XJ8AXIEfaHmKVUGBoyZ7xqojl3XGotSFjFhsuh4HyCiREuPXiXxGcbfR/9PoW2wi3vOmS1TcPQrkur78MSHFD6W8AYJQCuYLzzTACr9bLruumObQLK4NHJp7u6Fh9/xY2h1jXtDtw/waMw3Tdj8mouCtMsWdvzNMYg+wdfZGcDEfC4Fb3jsbfY99FKHfv/glOuhGyI46ZXPVYjgv6hwoJASkp7vNDnxkFFzMQEZWWL42Eu+m/o3esliWDJiibHIzchbe3R4MGyvqk+4IrtOxB2gUSuEcpzogaScz4fzljgslNLrSd1QugAfCiXjMe7xiRxB9IoIcFZELl6UH211K+Pk+x/tVwT7jNChr+g==
X-MS-Exchange-CrossTenant-Network-Message-Id: ba916fc9-88eb-4bc4-63b7-08d859aa6bdc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 19:06:16.5041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lfQZmD7kjCX56lVJXwtKntyJiw7mskqKrTPAVMA/41poi8KS9dux4+7zudJEaDi9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4268
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600196779; bh=25aPV0IOJyfKL0ksmW2VusOT+XKcGPFHElqfnOiMbH0=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
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
        b=qzKHI0WfXWL4N9eyzswOgwJOA4VzhPOU/+1CTGjjZf84ZBUKoQGYiDONigsVSaLfB
         AaGUhxiKEP8JYOw5qfiPy2Xm7m0UTFdrJqkS2tUbSILGa+4MOYBlUlV5ke7vZa1Vnc
         gUwzLKleeS6SHtZcc7MabHFM29jlGIkyhppL3k1OdwSZyHYhYxNuffRLPhz8ZsjqoW
         QnzQ+PPN39+nfxFPfk7DUxNyMkxlbFUsqfALsNDFm34NyzefLIhk+b86h9TWAk9tFV
         1pgHC1pbu9RVanlhaKat4Co0p94zyJuDEaBEojAV19gqNDaRAFP92jTWsFj6hmzaPu
         zG8dSqV9nya2w==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 15, 2020 at 02:47:04PM +0300, Leon Romanovsky wrote:
> On Mon, Sep 14, 2020 at 12:55:50PM -0300, Jason Gunthorpe wrote:
> > On Sun, Sep 13, 2020 at 12:13:02PM +0300, Leon Romanovsky wrote:
> > > > > +static int UVERBS_HANDLER(UVERBS_METHOD_QUERY_GID_ENTRY)(
> > > > > +	struct uverbs_attr_bundle *attrs)
> > > > > +{
> > > > > +	const struct ib_gid_attr *gid_attr;
> > > > > +	struct ib_uverbs_gid_entry entry;
> > > > > +	struct ib_ucontext *ucontext;
> > > > > +	struct ib_device *ib_dev;
> > > > > +	u32 gid_index;
> > > > > +	u32 port_num;
> > > > > +	u32 flags;
> > > > > +	int ret;
> > > > > +
> > > > > +	ret = uverbs_get_flags32(&flags, attrs,
> > > > > +				 UVERBS_ATTR_QUERY_GID_ENTRY_FLAGS, 0);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	ret = uverbs_get_const(&port_num, attrs,
> > > > > +			       UVERBS_ATTR_QUERY_GID_ENTRY_PORT);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	ret = uverbs_get_const(&gid_index, attrs,
> > > > > +			       UVERBS_ATTR_QUERY_GID_ENTRY_GID_INDEX);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	ucontext = ib_uverbs_get_ucontext(attrs);
> > > > > +	if (IS_ERR(ucontext))
> > > > > +		return PTR_ERR(ucontext);
> > > > > +	ib_dev = ucontext->device;
> > > >
> > > > > +	if (!rdma_is_port_valid(ib_dev, port_num))
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	if (!rdma_ib_or_roce(ib_dev, port_num))
> > > > > +		return -EINVAL;
> > > >
> > > > Why these two tests? I would expect rdma_get_gid_attr() to do them
> > >
> > > First check is not needed, but the second check doesn't exist in
> > > rdma_get_gid_attr(). We don't check that table returned from
> > > rdma_gid_table() call exists.
> >
> > Oh that is a bit exciting, maybe it should be checked...
> >
> > Ideally we should also block this uapi entirely if the device doesn't
> > have a gid table, so this should be -EOPNOTSUP and moved up to the
> > top so it can be moved once we figure it out.
> 
> It is already in earliest possible stage, right after we get ib_device.

I usually put it before the uverbs_get_XX.. but doesn't matter

> @@ -408,9 +409,17 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QUERY_GID_ENTRY)(
>  	entry.gid_index = gid_attr->index;
>  	entry.port_num = gid_attr->port_num;
>  	entry.gid_type = gid_attr->gid_type;
> -	ret = rdma_get_ndev_ifindex(gid_attr, &entry.netdev_ifindex);
> -	if (ret)
> -		goto out;
> +
> +	if (rdma_protocol_roce(ib_dev, port_num)) {

Not sure this is needed? non-roce still has gid table entries, and the
attr->ndev should be null so it will do the ENODEV naturally.

> +		rcu_read_lock();
> +		ndev = rdma_read_gid_attr_ndev_rcu(gid_attr);
> +		if (IS_ERR(ndev)) {
> +		       rcu_read_unlock();
> +		       goto out;
> +		}
> +		entry.netdev_ifindex = ndev->ifindex;
> +		rcu_read_unlock();
> +	}

This is better than what is in rdma_get_ndev_ifindex()

Jason
