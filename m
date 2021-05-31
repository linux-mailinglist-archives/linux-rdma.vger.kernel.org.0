Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A29A3969BF
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jun 2021 00:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbhEaWqF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 May 2021 18:46:05 -0400
Received: from mail-dm6nam12on2064.outbound.protection.outlook.com ([40.107.243.64]:27105
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232035AbhEaWqE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 31 May 2021 18:46:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7aTPd6KniWwkEqkSL9aNlwt0Y5XjhR5nsN0ssxfgvZY4r3usaYrVSVxiy82sxeFfXBRNu+XL2RBipnj9DcPKuaDm5m3bccCROdCcpOPzNSRPh2UYNvdtVetA35TXYEHbIiPjoOALeRWarR6jO5p1c1XLjscmiwopvsThAsKlO79LX/auXfH4dWCenVV+f/JTcaQwYBZ0DGSxiW7VXZh5Btg9Bwtkp+VyJpR37mjJxy/rM5mAK9tpGZn3+ltlrFzAyzd9nbVDNzVrGbC+9vxWAaszOcD6EiuCNs+zlYX6YNMaliMv1NCqsyTdtbdoFtXmhCGNKI2a5M614j7oR8EGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1Ef80jNsVtsxic15hz8tfiK02Jd/rDcnU32YdYHdqI=;
 b=nG+m3AXlSBQ5U7JHhAl5K//M6wU6OBHtgSB+nJ8HD23b5+g26qPupLCJX6zqG5IRnrM9b0nvvEe2nTqyxx3yUsPPcdAK3GjUZO01oAXZnNkGewbiZ4yv0gYlyyaiIAiTnu9xFlsNuzY1AkhvzcutqgPRbV2LInUR/EH6wDoICs5VgQphjpAa0rk6XsHsrONlgJgFu+GiaCuuafWUddXW5pAz7I0alZXV3YUk51/IKTx8r5iR/OnIjRqYKbnuGE7rr0kYD5fvTO2Sis7bn8A/Lxwrhk2AAVmIqWrLKSYLrS2ebdXj3iMA0m+PNGcj9jnVW5paMMWhO43K90Lu+aDYIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1Ef80jNsVtsxic15hz8tfiK02Jd/rDcnU32YdYHdqI=;
 b=I4iBvUD7xz+KmUMr6nI5akTguOWxzO2v53MRw1IMkFW61KJVxwGppOsKry5f0KyJEhJe3oCYIgKqrYZ19kaJ1B2enlJKtfQzQPl/oVFk+XlZhwoTcBNdwTAqI5Vi3Yz5LEMUesyXNhFErLQV0xmsJnjjheJmS87CB8+4WItZAgmn3mUZKwiah68AgDskdXg2VAZdzWUcv3S6Rc9TtE89aFVzx3vuY/xlNqJ9CIu1BhyWF0bAw2LFZrncwowtp4m0w1pp7zggNSX+p3HV3gtCKkLnOrwYeIaqVfPOr5wPwCxLjKqfEQLnPSq61RT/Zn09BqKlC++TgSozCQ3yjnsJfw==
Authentication-Results: ACULAB.COM; dkim=none (message not signed)
 header.d=none;ACULAB.COM; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5240.namprd12.prod.outlook.com (2603:10b6:208:319::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Mon, 31 May
 2021 22:44:22 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 22:44:22 +0000
Date:   Mon, 31 May 2021 19:44:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Avihai Horon <avihaih@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Tom Talpey <tom@talpey.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Keith Busch <kbusch@kernel.org>,
        Honggang LI <honli@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH rdma-next v1 0/2] Enable relaxed ordering for ULPs
Message-ID: <20210531224420.GG1002214@nvidia.com>
References: <cover.1621505111.git.leonro@nvidia.com>
 <20210526193021.GA3644646@nvidia.com>
 <5ae77009a18a4ea2b309f3ca4e4095f9@AcuMS.aculab.com>
 <20210531181352.GZ1002214@nvidia.com>
 <2fe802bdebbd44619447c83ed7e30a74@AcuMS.aculab.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fe802bdebbd44619447c83ed7e30a74@AcuMS.aculab.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR19CA0025.namprd19.prod.outlook.com
 (2603:10b6:208:178::38) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR19CA0025.namprd19.prod.outlook.com (2603:10b6:208:178::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Mon, 31 May 2021 22:44:21 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lnqdw-00HHMG-T9; Mon, 31 May 2021 19:44:20 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eaa1f08c-567b-42ac-d038-08d92485a230
X-MS-TrafficTypeDiagnostic: BL1PR12MB5240:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB524000A8E4DB86277C3625BEC23F9@BL1PR12MB5240.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LG7Epzabqr3Q/AI3bIpTtBGOJzg9URXr/xIlrp08j/Mci223m/pHluAbP6PkVrvO8wlkeVKCp58bt7JooONRZu05eYkCUfUxW/YPgBsC49mooy4hlvg4KEm6wD7urb7LoW16qCZBtqIcmKopqMiIECdDi3tcmPmp51D3Gj0KTMxi9h/7frEjalT3bkp6ARsnqVMdgh3hb4ebwxoHBev27L6dxn9N2vY0WoW65TdCNERIJ1pu7MlM31SD8+I6gV0DSo4mDZ1Y4wTacxr0jTtes7NHL3VRhBw3T5R6ciUzrsSVvh2Aet8YmVglXJy9IwB1P0wQCaiqmgYnApOB8E5fj96fHC1rReI14m3aag8kb1FEDo9db6sSPFeBSLOiu0QelxLMYq34E46NsYXBK3RTQy6uzwdgyabVNFRsiDlIVeVFWVA6cagCfICQN16t3TmQC7jSZ9iuxhScBCIad5vX/gEHsx7PTNBZavc6jn0L2VQkQD6xDVbQIoAcXyqZ020cM131JeNBqyxWbzw4QQPjJr7n5Rs+es9Yo0Vwf44xylGu82cDDh1AdwVk8prur2LOraHdagUYOW4HzyLdnw1oMhfPdKWCM7sTNlJgmSXE9DQMmeWvwLRUfvDvZ6Bvfn6Dz6Yhid18EZ+HEvh4T/5OVg50vw4Nc9dWksjcflZPdDLuqY6LtLSbnpS33ikulWVpil62ICFYDex+VMvnrpRXMEbTdI3hEkwZO/BMrFwcRiA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(966005)(478600001)(8936002)(86362001)(8676002)(5660300002)(186003)(426003)(66476007)(9786002)(83380400001)(9746002)(2906002)(1076003)(107886003)(33656002)(66946007)(6916009)(316002)(38100700002)(54906003)(26005)(2616005)(4326008)(7416002)(66556008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?CNuw+8iUJkQntcnk3gMNa0YGb5Z9plxKd/4GsamutwPcSlGQ2ArKPp50jAcE?=
 =?us-ascii?Q?qEG5oNFSRbi8e0peDOZPn72hOdUtCXCFdksWWN+rMO65FX9KhLi9DTUEGCTr?=
 =?us-ascii?Q?nVMi54N10Y1NfbwScs/HcynlBs4DGp2Nl3ZoSihVF3rlt/tr1RxMehvAxhw8?=
 =?us-ascii?Q?fjxma/kimiRFN1wGJ0sfYlQgCta6Ty/p3sKC5+Xr5k7kRLeudc0/1mFDVgxx?=
 =?us-ascii?Q?3UFFq6UROnwCGHTqMBKXzWXtrmj3vU35UpWEBa8fdgGELmWXif2Fek36e7QV?=
 =?us-ascii?Q?XeNMvJs07QzqdrfSOqBVmfx0E6kVfXnX+1lDBQQ0LkIwVo/cj1WNegC0hD3p?=
 =?us-ascii?Q?H+ETsnVFzZhzGxWjdPJIvW5wE8f9PyAqlLsf2IwQD8fhsQ0mJMJAw3jGMSft?=
 =?us-ascii?Q?fFvgtpCslLOCYsYaJSNCAzO1zjdIJBYma6i6MQJS2/UWyND05IZed+mYDqs9?=
 =?us-ascii?Q?L0F2kvt/ZnjfOA+K3owRuAMTwCQSGbD+ENlEnhdlS8UlldUzTNBvsWWZyrFF?=
 =?us-ascii?Q?ketxPCOIt4ua/LOkHeLNTetBq5MEHXB+Mj3sYdV92N7+01Lyh0x+Lheu8uoa?=
 =?us-ascii?Q?4LfFEjNDSnLdYFpkioIpGsf/7J5F5lTQbTwehLqwrry0gbP4dNRY7IjSDan7?=
 =?us-ascii?Q?CKFvilfq//pPyqAKKCyOi5wB/G0wzG504qkfHmdrFF2IJTy+H0GWeO9MZbwX?=
 =?us-ascii?Q?icSkBCfwKybSltgSUxEOlU9MRi++DiJA8kprmGpjuWTAAt3UVAJL5HHpF5HZ?=
 =?us-ascii?Q?yIaQJrqRAnq4+pIinXUf8dFc97jVtBDKaUqdVkyH6jcWLHBnfTKenD1JKyQw?=
 =?us-ascii?Q?4lWWtnVqfZgEsIg1gXbk53+IKnnsoMbsq+yCzS+cd4L6mTULvzQ3lbWu5CcJ?=
 =?us-ascii?Q?0oKaO2QfowIGa4rZa7epqjR+jE3OgRn2KXusHsYz4tm9N0ZOoZ0ViJX1Al06?=
 =?us-ascii?Q?eATe6G04pl1QBqnhkS50bQHMrAM1wAsbHjg4ghvmJJGhyF35fwvH1itoJiCo?=
 =?us-ascii?Q?nRgOgSzCgxx95HXkp/bcLXqCdzmZK56pBuO4T0ucmuaj+wUl8n0BX+vz97hw?=
 =?us-ascii?Q?x7ncFHq0WLhS/7kHLJQbzgLyVKxntoGmQEibVrjtQ9ENwkK0CH3ieLz9883t?=
 =?us-ascii?Q?MX1fQfZhTKHQWsxljTBRR7IwT3hkq2JE95mXLz29Bi3/f4aI6W3SA09Y44Ha?=
 =?us-ascii?Q?h6OFILM3jluiaYA37Wj2RXPFTQMNUYcGqO8brjxpRkjPMSh4EYsjAo+51ezC?=
 =?us-ascii?Q?zpjnZ3ZmSSuY6Ls3iNBBXPY5JapoL2f+hH1XGYDJu0TsbHXf7cClJ3dbwpYn?=
 =?us-ascii?Q?Gm7yGgw8fLHglXb4mOeTapUA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa1f08c-567b-42ac-d038-08d92485a230
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2021 22:44:22.0989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lm6bRtj78l/MIst8D9h3gsNdFrWgL6l1u0Vsjm+NBQwtdlwDR/5TR09cp28X2tPD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5240
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 31, 2021 at 09:45:47PM +0000, David Laight wrote:
> From: Jason Gunthorpe
> > Sent: 31 May 2021 19:14
> > 
> > On Thu, May 27, 2021 at 08:11:14AM +0000, David Laight wrote:
> > > > There was such a big discussion on the last version I wondered why
> > > > this was so quiet. I guess because the cc list isn't very big..
> > > >
> > > > Adding the people from the original thread, here is the patches:
> > > >
> > > > https://lore.kernel.org/linux-rdma/cover.1621505111.git.leonro@nvidia.com/
> > > >
> > > > I think this is the general approach that was asked for, to special case
> > > > uverbs and turn it on in kernel universally
> > >
> > > I'm still not sure which PCIe transactions you are enabling relaxed
> > > ordering for.  Nothing has ever said that in layman's terms.
> > >
> > > IIRC PCIe targets (like ethernet chips) can use relaxed ordered
> > > writes for frame contents but must use strongly ordered writes
> > > for the corresponding ring (control structure) updates.
> > 
> > Right, it is exactly like this, just not expressed in ethernet
> > specific terms.
> > 
> > Data transfer TLPs are relaxed ordered and control structure TLPs are
> > normal ordered.
> 
> So exactly what is this patch doing?

It allows RDMA devices to set the relaxed ordering bit in their PCI
TLPs following the rules outlined above, but specified in detail, in
the InfiniBand Architecture spec.

Today the Linux model prevents devices from using the PCI relaxed
ordering bit in their TLPs at all.

Jason
