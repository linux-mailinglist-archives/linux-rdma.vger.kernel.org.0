Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC912690BB
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Sep 2020 17:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgINP4i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Sep 2020 11:56:38 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:57184 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgINP4R (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 14 Sep 2020 11:56:17 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5f928b0000>; Mon, 14 Sep 2020 23:55:55 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Mon, 14 Sep 2020 08:55:55 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Mon, 14 Sep 2020 08:55:55 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 14 Sep
 2020 15:55:55 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 14 Sep 2020 15:55:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMxbtmrA8vPxahaTyQ2NOG/e79zXgh9g6Lht3qhLv4cSSo+93qrw4QGI9/y3OT5Sbkhui/bMzAa9ukjIsgHO1DzfJ/6rKKIvYvVfCDRP7AVHstqRcjyTHo2wNdqMb4dGRNcxJOSIQkPOhXm5f7GJnttEBmroPH7Lyh/qTdukoUBr5/8LvC+k6dZAu6Elb4KX2NvI/24tF50Uz5UWVJCcF5vxWdFWanv2ge9XcpSrJn72RWZE6PfoidX0s00pFXg7HXJjaegPdTVfxWOmw7D+UOBqP1OYr6jdX3Zj+07O53+jC1gCKjuudgoHBucVKhOJGqT6xVowRwUZ0LQrgj+geA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElTvoPOofgeGrbWksr+bBc5wJjficDAugwJyAIaOwI4=;
 b=i/vbKwk8A/DmlOfwJr2R7iIbRfi/pw/COyKIkxLwRp1dviGFn3FfqxOQ2lDeGkyayCmLQwJTpd5t4Q7S+eyNuAKp1Xp4lF2WmZDYlUEaqhPfrGdCy8QcA7VRP520VavvUZ5V/Inm9Ww4uwS6M9cSfQSwEX9WBVgUwm4UDCP2klBTIKnIoj0+eTZnXcQKX8Kh+1medDffoZM2lZX3DgT4u8O0e1Uj0BzETfazwURPd4tdz30yLkBv6dstCRYWlKOD2A+gA9f0VkR3ozsHxZ9ZnTjV/IfGi4WDl1sir4nK0p5zOL731P0R7Ag4viPiL3Wb6+gCQn3fy+Teal55b7/u9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 15:55:52 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 15:55:52 +0000
Date:   Mon, 14 Sep 2020 12:55:50 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next 4/4] RDMA/uverbs: Expose the new GID query API
 to user space
Message-ID: <20200914155550.GF904879@nvidia.com>
References: <20200910142204.1309061-1-leon@kernel.org>
 <20200910142204.1309061-5-leon@kernel.org>
 <20200911195918.GT904879@nvidia.com> <20200913091302.GF35718@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200913091302.GF35718@unreal>
X-ClientProxiedBy: YQXPR0101CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::21) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YQXPR0101CA0044.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:14::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Mon, 14 Sep 2020 15:55:52 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kHqpa-0069mD-AF; Mon, 14 Sep 2020 12:55:50 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5204eee3-6199-40a5-2fad-08d858c6a837
X-MS-TrafficTypeDiagnostic: DM6PR12MB2601:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB26010EF6407D0CD478797009C2230@DM6PR12MB2601.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PAXbNpqbOHFiBAJtmlAIqZpEoq8JRHJf+PTTT2km/oCKbbdFYiLN0kVDWblGgetSIXMPmyJDDHiqkVgaI5tTCKnB1AFQS7mbq2iBIY04+dr00V0FbEe4ew2TOj2LCdnDDRId79qRpOvls9KYxA9RYWaRoDoDbpZM/GLSLLWBwRJJSSE4aVvDnsmYfix7E0tAaimRvknAlmX1KTpt2k+QyVmTBg0fVZsciIm94KDAQqk/isFY/ZNH6DQOuoijBKvPE42R43bfYUykcJnUoBU/4lvYDHvInEVhEO9hrX1ZKTuUCEkZJ0ORJpMZLpSyyhIJnCp+HSSDILyg3xTr9SdufDM0ET3j9jJREEX7CSywtj27fGHhrfnwhVTswX3NKroH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(26005)(6916009)(54906003)(1076003)(316002)(186003)(83380400001)(33656002)(4326008)(8676002)(86362001)(2616005)(9786002)(478600001)(9746002)(5660300002)(426003)(2906002)(66556008)(66476007)(66946007)(36756003)(8936002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: WSoPyfXW3bWOH3wynjoXduwM6H882fj9vt2ujzud/0DxhAIawwcPNReUo6x6wY1Wcipve4M0LMtysQiGQw0oYssJMjlAX2/m1+Ec2xpdjFOSdojEGBXBuyvmRUzdogM3TC35ym6GURkghUkl6RqBxn1nouVt+iOIUAqVNj3A8OZnmzRQ3UL6NQ9hVYziOp+twKyB2cmmBHEnGZQ89vMbaZr4GyznVGDWXcRJq1vHiZEIW8xafzNTkwqTIc4Mz8qeh2lkA27ZsFWa71KAh3vxRcudZ7D6jjrP/6noUc6OL/Vwz5rPEc7ylR0UbBkbOHAor/kk15JVYsEkXC0M1XEycpOLH/2CSa3L6jgPzpwT3zSNW8BMym1BYhHyE6CAJRCpSS2BEOTuHWRy8+/tdXq6SRdGMl+QBS+DVBWtAfHZz5zQXIMN4+nV7AgpGktRhla3YQObcrl79PZ4X8EnPbLjtXojLCpoJDyMQpjp35jdMbvamJ7uIRtTyefR1Ah+Kwzgew4RMwJHaDEda6iJVirGean13uK9wh7KbgtCH+Urh4ZH0OHkliLSQJrOjkr7BAu1dFlGw3ft/6tvSJAXIKJcQ32OArfLdDQgDyBFIenXnOV2d7OAWHTkjVeMt+9mZSi2ArNtTQovc78Sl35zJFVSJw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5204eee3-6199-40a5-2fad-08d858c6a837
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 15:55:52.4241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pheykpUPTa4NtFl/JIcgebwvGHthFP1/DSk8azHTWrtYM1q1vfbWgyYkX59Icoam
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2601
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600098955; bh=ElTvoPOofgeGrbWksr+bBc5wJjficDAugwJyAIaOwI4=;
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
        b=AX+HoNHG6EX2tqWuM0EJ56Wmu9vO2K40SgeOk3hjq+/9449+RPMireBN3/dgV33V4
         gsuXD2rOkLNayNt8K4IqDppsokCy1jbvyBHMjgAt6nv/JFuGeHEz81GKYFUOexo7Iu
         u2Mxx6DmJq9Wj58INZ9BMxVMIEViifjJRLkJBZnTjASPocKT1fDpCLdJgyg3Yaj1A2
         MY5Vyk6OrRvbO4V123WTlEjtOowgwESPQU2T9m4d5Wh+5Mz36D2CEJeoolrUl0R+v0
         DQc76ZdBvuVyad4MKnLcUUc9KIUtZoqtTrkSGoJQW58wDTp6vOmnUs4NvZb1mEBBe8
         gUmfHWfvJticA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Sep 13, 2020 at 12:13:02PM +0300, Leon Romanovsky wrote:
> > > +static int UVERBS_HANDLER(UVERBS_METHOD_QUERY_GID_ENTRY)(
> > > +	struct uverbs_attr_bundle *attrs)
> > > +{
> > > +	const struct ib_gid_attr *gid_attr;
> > > +	struct ib_uverbs_gid_entry entry;
> > > +	struct ib_ucontext *ucontext;
> > > +	struct ib_device *ib_dev;
> > > +	u32 gid_index;
> > > +	u32 port_num;
> > > +	u32 flags;
> > > +	int ret;
> > > +
> > > +	ret = uverbs_get_flags32(&flags, attrs,
> > > +				 UVERBS_ATTR_QUERY_GID_ENTRY_FLAGS, 0);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = uverbs_get_const(&port_num, attrs,
> > > +			       UVERBS_ATTR_QUERY_GID_ENTRY_PORT);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = uverbs_get_const(&gid_index, attrs,
> > > +			       UVERBS_ATTR_QUERY_GID_ENTRY_GID_INDEX);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ucontext = ib_uverbs_get_ucontext(attrs);
> > > +	if (IS_ERR(ucontext))
> > > +		return PTR_ERR(ucontext);
> > > +	ib_dev = ucontext->device;
> >
> > > +	if (!rdma_is_port_valid(ib_dev, port_num))
> > > +		return -EINVAL;
> > > +
> > > +	if (!rdma_ib_or_roce(ib_dev, port_num))
> > > +		return -EINVAL;
> >
> > Why these two tests? I would expect rdma_get_gid_attr() to do them
> 
> First check is not needed, but the second check doesn't exist in
> rdma_get_gid_attr(). We don't check that table returned from
> rdma_gid_table() call exists.

Oh that is a bit exciting, maybe it should be checked...

Ideally we should also block this uapi entirely if the device doesn't
have a gid table, so this should be -EOPNOTSUP and moved up to the
top so it can be moved once we figure it out.

> > > +	gid_attr = rdma_get_gid_attr(ib_dev, port_num, gid_index);
> > > +	if (IS_ERR(gid_attr))
> > > +		return PTR_ERR(gid_attr);
> > > +
> > > +	memcpy(&entry.gid, &gid_attr->gid, sizeof(gid_attr->gid));
> > > +	entry.gid_index = gid_attr->index;
> > > +	entry.port_num = gid_attr->port_num;
> > > +	entry.gid_type = gid_attr->gid_type;
> > > +	ret = rdma_get_ndev_ifindex(gid_attr, &entry.netdev_ifindex);
> >
> > Use rdma_read_gid_attr_ndev_rcu()
> 
> I don't want to bring below logic to uverbs* file.
> 
>   1263         if (rdma_protocol_ib(gid_attr->device, gid_attr->port_num)) {
>   1264                 *ndev_ifindex = 0;
>   1265                 return 0;
>   1266         }

Shouldn't be needed, rdma_read_gid_attr_ndev_rcu() already returns -1
for IB

Jason
