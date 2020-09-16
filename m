Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770F826C4B9
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Sep 2020 17:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgIPP6j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Sep 2020 11:58:39 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:25038 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgIPP6Y (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Sep 2020 11:58:24 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f6222ee0000>; Wed, 16 Sep 2020 22:36:30 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Wed, 16 Sep 2020 07:36:30 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Wed, 16 Sep 2020 07:36:30 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 16 Sep
 2020 14:36:29 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 16 Sep 2020 14:36:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwWWdsMurmZoYQgcWP+dgOTdSCd1GG0sHPstRqw8Wqw8AZSX9jOe6LN/Y48WsRK50NsvZYTRsFo91ZmRdVtyutIC4MEkzht63+qsOzx3TCcYeXc6WCUGp6Mtr8bGW5gAZUU9oUg9petHUhZEHTmPhmnoD6NTZ/BuqVNYvWvubpHpIeNs+9RDOZnfEcg1UnbSGQ7/x1315oVXD611tHhJ3yEtOa/SCwMe0C0hSHW9rBHK6z1yeKYot366Gc3U7B1aMLPWhv7LnOPyeg35zaJUF+L6cCHPHHokSibT6/jzgPjt6cd9D3Q/0hq/8Oiha0EoSPL6K+f9i3+yqPmqrgo6Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfJidXkrrPuD+7Rz6/dULLFu0dcbX4qs4ijp7cJ5oMQ=;
 b=lcRNcnfrBHWVbn2xXIQYgvjJRXH+4Y37hbPt6jlB62dpsI0WRvkUxjWcU2fwUjN6Wqkbfzu5VayVNotBIjbiwBna5mOB1gaHsfAg3Y41xs5YejeIc4skMzB3zZBA9ISCiWsPngvSnrknShrqsdgxFzz/BoDWWG5dYC6/elSLxKYZI9Tc96tfypnoE9C89sTKRcrwg8hZSmnMz+h621gXS3Gq0e8qYcXKvIwM5KLH+1jULUtOYtsRNXPlonsG6IWqMDv4+8Hzg0LlMSqX7N9ebtXSYpguHIorSrpOAQe3OBOTd6cSOJm0KG7hT5a14vly04WiOY7hpSDDOm5Nf06TKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2440.namprd12.prod.outlook.com (2603:10b6:4:b6::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 16 Sep
 2020 14:36:27 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Wed, 16 Sep 2020
 14:36:27 +0000
Date:   Wed, 16 Sep 2020 11:36:25 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next 4/4] RDMA/uverbs: Expose the new GID query API
 to user space
Message-ID: <20200916143625.GB6199@nvidia.com>
References: <20200911195918.GT904879@nvidia.com>
 <20200913091302.GF35718@unreal> <20200914155550.GF904879@nvidia.com>
 <20200915114704.GB486552@unreal> <20200915190614.GE1573713@nvidia.com>
 <20200916103710.GH486552@unreal> <20200916120440.GL1573713@nvidia.com>
 <20200916124429.GI486552@unreal> <20200916141202.GA3699@nvidia.com>
 <20200916143425.GK486552@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200916143425.GK486552@unreal>
X-ClientProxiedBy: BL0PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:208:91::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR05CA0005.namprd05.prod.outlook.com (2603:10b6:208:91::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.4 via Frontend Transport; Wed, 16 Sep 2020 14:36:27 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kIYXp-00038A-Pq; Wed, 16 Sep 2020 11:36:25 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18ad1f96-7c7f-4b99-ff86-08d85a4de514
X-MS-TrafficTypeDiagnostic: DM5PR12MB2440:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB24406B3EAD4F1621CD2C8EBEC2210@DM5PR12MB2440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DULixSemNj+IstZ7TB/Jawavftl8qWLyNFoXSeMRtl0hQEI9WWPkD9h9SjLgH8mKw/LRFd9rN2f5m2TI05KpA8dVVWGbySNjl/TRXU2OZwFySsYJTlrHwkz3OZIFxN5YOgl9eYaKAIRqwHgA9f7HYbAzL5o9/apb/xQp3UC2mS2eyeIlVgc3M9XHWJqSkoh/3UHZHo6iHtmV9rBxnAt3a/2nJ3xGiJni6NxiMmFCuyBATT+hURen6iMtMjQ+OWZ3a1MtDVBvD+U22+UnG7mH6HRFNpM11zutMWM4UMVxPHgl5F01zhRsQCZI4xeTKARf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(396003)(39850400004)(136003)(54906003)(316002)(33656002)(36756003)(8936002)(86362001)(426003)(5660300002)(2906002)(66556008)(2616005)(26005)(66946007)(66476007)(8676002)(9746002)(6916009)(186003)(4326008)(9786002)(478600001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: /sDi0yty8eP7VZ49ddioidtaxoMkPhOjoWmWDaUO9PnMLE5i23RM4agAzl2PF3O5lARj/kLBWLJH5D8Cmr+RZNNsm3kv5XPxdvXUGAKXbWOn1vM1vOWaWHvVeW/bxzz3bKrX+AGuU1dbEThW1PlrO7SDGQcfuMjDtsS27t+hkrtAYkALfk1r1PFQKswzJGhEIx28dntpQTwbG3+aRG4RNF8z3LFX6AqJj2uJ19EMLVRBHYdh1moMH6usxYALzv3lZYSwe1jbVBZuHXHhgCi4WhTXdAlvzirXQg8f06Rd+u5UahcpFqUFDEdZWmJ1CuKktuyimHr9xEYN8Z6s1EcE0BeawDpjq1h9n4oarOka5tQ0WhnzNiNLzDm+VVJGN6ibPCrBVLpuNV1zAwNtw3kHsCUaCe9XW0XNK1ucja8fmnfQnZI+rJFTDvqsiTych5ShEyhEFdyxR39Da5Fq5vncdgZ4yaUzu22BjCgjgd6/X8FLbO563U6CODtCQIpeo2SvO25ZPBlq6A2LiKUZSx6QPqlK10BbkdvQoPFe9VQGQYwNACuNE4GTTuEh9yVerFGhKGmuRAj9ztYEnU8hmcwXZiKuGq05PLaMRmv3JxTVfASAdN4D1+2pKdH3mn3y9UVrLk+vYHQ+Nc9MUuC+toCm/Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ad1f96-7c7f-4b99-ff86-08d85a4de514
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 14:36:27.6884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vy5a0uZuU5f0yqK0P1ma/IjupWdl+xPjowg6ugybhEXxGhX0BceEopRI/Z3Zuthr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2440
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600266990; bh=xfJidXkrrPuD+7Rz6/dULLFu0dcbX4qs4ijp7cJ5oMQ=;
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
        b=f1vONkbva/rJfghuZLA6VtdL5nl9fH+oGiRlpLmcpcSxoGG01VepnqU9lew8OC+qH
         Y1Q2hJcMcsPpAoedGCMbr9k+q/WPB9WjEmhkp00Nl5WjWIxD97nLRDs1psgEGI/ws6
         jD1eNaEAsePgTmowjCto7HiSwFz7E03yoS3Dkyp0J48+UgLLCUhDrp+DWiDnL6b6Nk
         4pzwajGrw+SYT1dZv9pN42z9dGdMb308TTnzISQA4cdOGvn0zZrL7RZZKoVisa7lBF
         /XrkOh4H29roO7cIZFqaXU5mkF6msrqY/KRjddMqodxKkOrZQUaUR2MA2Bx1qCQtoo
         xepu/3IcVwEbg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 16, 2020 at 05:34:25PM +0300, Leon Romanovsky wrote:
> On Wed, Sep 16, 2020 at 11:12:02AM -0300, Jason Gunthorpe wrote:
> > On Wed, Sep 16, 2020 at 03:44:29PM +0300, Leon Romanovsky wrote:
> > > On Wed, Sep 16, 2020 at 09:04:40AM -0300, Jason Gunthorpe wrote:
> > > > On Wed, Sep 16, 2020 at 01:37:10PM +0300, Leon Romanovsky wrote:
> > > > > It depends on how you want to treat errors from rdma_read_gid_attr_ndev_rcu().
> > > > > Current check allows us to ensure that any error returned by this call is
> > > > > handled.
> > > > >
> > > > > Otherwise we will find ourselves with something like this:
> > > > > ndev = rdma_read_gid_attr_ndev_rcu(gid_attr);
> > > > > if (IS_ERR(ndev)) {
> > > > > 	if (rdma_protocol_roce())
> > > > > 		goto error;
> > > > > 	if (ERR_PTR(ndev) != -ENODEV)
> > > > > 	        goto error;
> > > > > }
> > > >
> > > > Isn't it just
> > > >
> > > > if (IS_ERR(ndev)) {
> > > >    if (ERR_PTR(ndev) != -ENODEV)
> > > >         goto error;
> > > >    index = -1;
> > > > }
> > > >
> > > > Which seems fine and clear enough
> > >
> > > It is a problem if roce device returned -ENODEV.
> >
> > Can it happen? RCU I suppose, but I think this is an issue in
> > rdma_read_gid_attr_ndev_rcu() - it should not return ENODEV if the RCU
> > shows the gid_attr is being concurrently destroyed
> 
> From RoCE point of view, it is a problem if device is destroyed or gid
> not valid, the different returned values won't change much. For the IB,
> we don't care.

I'm saying I prefer things layered properly. Having random
rdma_protocol's all over the place has proven to be hard to maintain

One inside rdma_read_gid_attr_ndev_rcu() to make a NULL netdev an
error return for roce is much more understandable

Jason
