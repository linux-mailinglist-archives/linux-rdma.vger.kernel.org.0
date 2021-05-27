Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76EEA392F34
	for <lists+linux-rdma@lfdr.de>; Thu, 27 May 2021 15:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbhE0NRf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 May 2021 09:17:35 -0400
Received: from mail-bn1nam07on2071.outbound.protection.outlook.com ([40.107.212.71]:11393
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235996AbhE0NRe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 May 2021 09:17:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFumIlXFXB6fD7ZvZ9q0RNEQe2kXEFu7/TuiB72jCD6Z1LQVQpX0B2/CnX1N6GW6IIjqYcxqUdvWtULGznSRFhterwlE7tGK4ygufMGHx5tTQmDN0exvo/7Fe8iNo+s2mdRZC2GZpvZu0lQu2fn30RyNrq6iV2qvvspnYF/W5hZWRVih1Lr+xPGROyj0gxS1tQbt+f/L3s2ZYBDfhekXO1AD1uD4bKHdf7tfszFrosAZHmWD4Gu0CuUbDen5A6VBhtAjhssezjsFWE3BfiT4yn5QcsvG6F+DGcmL6QUMkTNONhzd2tN20wnbX9rrObwECjwmYZuVCuFlywX2tVO1uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0bZVO1QZ+wV3OrJHpehKeZz26Ww3Kp4Rv5vKXOfl/4=;
 b=RdYuMMGZx3p62aTK8VzHXf7NWcOoSohTLWydx3085O4m+U9d8/y/SShhS1e7aNrSH8tJoj+6j1hJMdxa+pHPoac7WMhWWGvWDT4K55QIb2LkSQvdbWNwsfCd0K8K0DuUGTyiFgWOxypy8Vyuqxck6Y2V0el212uf35/8sv00Ojn7mOxIiB818YMUII+v1VHwvn1Wym5mb2/+9Fs9qs8CxOYofhG3Joimwr3/nBs0inQf9gCbV0jpkTFtokXrJBD9C5eJBo9fyK32/WFo6yoPav43fJNvd77fF4o72th6lsvxyVYrKHfj0M7ABVC/u0JJbnfb8UnVT0g1/wuHTQGp+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0bZVO1QZ+wV3OrJHpehKeZz26Ww3Kp4Rv5vKXOfl/4=;
 b=MCmlyboYnjw9K/ah69waXq68p8iM3HMW91WEq1OZ15MljvPzoin9cKidXgGybl8S/ouEZwqzUdSG/sQc6bYzrqPaq5QBfeI7UPlBTqutI9QhefdkUHAkqOQB0g0JVeV8wQ1RLPGYhK6r8/eBit4Pel5lfrx96X/c9yDm+ly5p0mkELBboP224Yi8gO9XbBL/nvrIm3OetX44tQzWhnGh4BjZiWqhsjmamM/edEHCsl+WsxlZo9cu+ur2NqjVHlXhUcSzPX2xg8JFD6/e4L0VGI8wfwXQkjm4NN/MLMpdL51lNocbX7Nq+dsLy9PLlWErXtwQCTl89gqgq/5Kh8xsdg==
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5061.namprd12.prod.outlook.com (2603:10b6:208:310::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Thu, 27 May
 2021 13:16:00 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.023; Thu, 27 May 2021
 13:16:00 +0000
Date:   Thu, 27 May 2021 10:15:58 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
Cc:     Weihang Li <liweihang@huawei.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>
Subject: Re: [PATCH v3 for-next 13/13] RDMA/rdmavt: Use refcount_t instead of
 atomic_t on refcount of rvt_mcast
Message-ID: <20210527131558.GB1002214@nvidia.com>
References: <1621925504-33019-1-git-send-email-liweihang@huawei.com>
 <1621925504-33019-14-git-send-email-liweihang@huawei.com>
 <CH0PR01MB715336ACBA211A001E362E6BF2239@CH0PR01MB7153.prod.exchangelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH0PR01MB715336ACBA211A001E362E6BF2239@CH0PR01MB7153.prod.exchangelabs.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH2PR05CA0026.namprd05.prod.outlook.com (2603:10b6:610::39)
 To BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR05CA0026.namprd05.prod.outlook.com (2603:10b6:610::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.10 via Frontend Transport; Thu, 27 May 2021 13:16:00 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lmFrj-00FZ8v-0W; Thu, 27 May 2021 10:15:59 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa9f3475-4522-4354-813c-08d92111925d
X-MS-TrafficTypeDiagnostic: BL1PR12MB5061:
X-Microsoft-Antispam-PRVS: <BL1PR12MB50611387E5D8526359BD8679C2239@BL1PR12MB5061.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ngszv93FIRFajZjiaKhFtmxWO/IFs+m/4ldEzkHOYOGESkq0Gu86+zf7VKRAUWcfcpONbkuD5cJMHAvUpK/DTXKz3aO5R6ksAMmaH6gJJ/HZjiZOdacwgLYcFOrUQ9x9rVUpKaABByiXA1Uu5W+wkq8pDhSSFCey62BzzNtHKC71WsPRiokvxY6zN/FibEWpiv6mbpL3ptC5394rf8JUvNXSgtIpGpWWHfeRHd4JrdgZB5tyrl2ZNECLpLU1jzbUjVTXY6nvp+EY4XJAaQQ1WmANklPxA1fZXdYwRp8vduTDnU/FSQ68m9uOkZX9LtbfEWjvwvaMUwf4TLpULahsU5A1pwFjriC//r1dheDsKMLkDWEeky1mfWuww4kDJUHsn6box9q0qruLLO5NHCPDjHLgGXn5lahdcOatxg0LNS0np3vX9iXuCqECETiYLAd2Jy68aHYBcYYOiJwPC4yFLAvbYdW5ne/TWLitNoDvWqZN7YupMSWH0PBf6y/UcXpgM+jPj+XNay2nbBJPJ98IKMSOEQRO7iLYcpkuAFPxUVu66ELJDFgKdEyN8TKe2o4kqQhVJZPp8NsYp8cfI1XmGtcgSO9Ob9CczO4L8boECc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(186003)(26005)(426003)(9786002)(9746002)(2906002)(2616005)(36756003)(1076003)(5660300002)(33656002)(4744005)(66946007)(66476007)(66556008)(86362001)(38100700002)(54906003)(8676002)(316002)(4326008)(8936002)(478600001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?62hi28lvl3W8hlgTcFcmi3NXc0OH3aeD02sEXsvQssyKgXk0b/eCjPItQGvb?=
 =?us-ascii?Q?dZtL1ufwWWBoR0sBt/Q0OX9ITly1/0XZl/lxEiF0AAopqlmp8ZMkcn4iRfwO?=
 =?us-ascii?Q?gS3+LhrxSwFSTVxvWoHjINIdJrkDx6Ga01QRjMel7Upf3xp7yR8FiIrO18Zf?=
 =?us-ascii?Q?QouyxBKYIEdZ7ZDbrAyLgJQVkCj8sPVRSKyszi+N1UusRVOgjRSkXwH2Bq6k?=
 =?us-ascii?Q?8AZS3L2BL21YETZeh8HWOHPb6dWfsP9x8KkY3xZ7QRGkyo8QpJYuLdN0KDiG?=
 =?us-ascii?Q?DxrO0Qo9bcnGiAomXyLuKN6DgsF5k/AVNeoSEoLYL/+YCcsDBo3/FyZKq1+N?=
 =?us-ascii?Q?sRo4wYvrEEQ6FTpHgpda5OwM0+s1Z7n6/yOUY9/4M0U9YxNMWFZrekV0Nzdq?=
 =?us-ascii?Q?vh456bwn1ukFY4fTjCwkvIeFkZ5AVsuBEDkphf3+CdfnNWo2VpSfCuQljGnZ?=
 =?us-ascii?Q?VNTdnOxxNBvdincOfQjxNXZxaz6R2cAq0gfKRnrz5q2fo8W4YV2sDFC4ZPx7?=
 =?us-ascii?Q?BtXHEkNM4sWf8IrYCXr7UCqGXwZyMU+1bgbTgHHmR2uZyquwKgdEuewo7K/7?=
 =?us-ascii?Q?xbUNGbkdBD1LaqljqdwqM1VYagJk9sArQ2uuJR+pGUFFyb8NtCw+m5GfGAGu?=
 =?us-ascii?Q?3Cn8z3hdHHRB/rCr1qZb403KxBBp/c+6ac/j350jcK6WW5sIAB50lpwZ+O5a?=
 =?us-ascii?Q?wRs56nrrRI0VSoi19CRoAmbxtTlBuXLCtHD2DkEUPz2OW6fADkAyMW6bgIv6?=
 =?us-ascii?Q?mSLQ+fXMps+Ogo+/6uYMidi2ZTTQH5OofPqBBpKXtovaNsALC6hA02DIj26x?=
 =?us-ascii?Q?5unehdRskMoqZU8ec5SZmTf4lqXVz5xy9Y59MNv1m7jZRO8daxpPf5be9WAU?=
 =?us-ascii?Q?Je8lqj1MWiTSAFRCQ9Ggivo2qxxrcjGvA39AuDxyZ+RpTwjfWyRSd6CLMW+/?=
 =?us-ascii?Q?psNYS80jx5Z/m2BC9ODadeBxYjaUgsDs2LfpkVHsg+aMRn+4jxOccp4zcwIH?=
 =?us-ascii?Q?AuaTMD/Gm7DAGXn/hHJR7pYzZGamfOgYQETXjl5OkanIyTJva9/Ecz9Y423O?=
 =?us-ascii?Q?gcEkgLo2MP3V9wx5EAdJBJMmkATudGw7sdfMqyyygUvWmPFJIORq8S8D/t2L?=
 =?us-ascii?Q?VA+ETng5dgFnD/tQl22PMcgBqGYdbWayh1yL3qciJrwU7VslASs/qbDA8hJK?=
 =?us-ascii?Q?DWEX0AibnAqq95WCU/j2xhq4kTWBjMvseq/FfssrnwQgC6i1oiazoJ1gPi4m?=
 =?us-ascii?Q?9XySWht6GytpfkVXhKbinU3tSn7gIIYOc6TBpgPTxPQeEoEDk6Np36zwvc84?=
 =?us-ascii?Q?yE12PIvYylqlp3tOvKDZ/C6e?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9f3475-4522-4354-813c-08d92111925d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 13:16:00.4403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7l38kGdNdam5kIYeqxM8b33N/Xkhj2bZrFssBNmwCCQYZ5T4dH9gRN4s5TcE19MC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5061
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 27, 2021 at 01:08:37PM +0000, Marciniszyn, Mike wrote:
> > +++ b/drivers/infiniband/hw/hfi1/verbs.c
> > @@ -534,7 +534,8 @@ static inline void hfi1_handle_packet(struct
> > hfi1_packet *packet,
> >  		 * Notify rvt_multicast_detach() if it is waiting for us
> >  		 * to finish.
> >  		 */
> > -		if (atomic_dec_return(&mcast->refcount) <= 1)
> > +		refcount_dec(&mcast->refcount);
> > +		if (refcount_read(&mcast->refcount) <= 1)
> >  			wake_up(&mcast->wait);
> 
> Is there refcount_ that preserves the atomic characteristics of the single call?

You are supposed to us refcount_dec_and_test() for patterns like this,
this hunk looks wrong to me

Jason
