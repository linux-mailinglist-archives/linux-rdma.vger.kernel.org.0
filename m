Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED27388F69
	for <lists+linux-rdma@lfdr.de>; Wed, 19 May 2021 15:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346563AbhESNpo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 May 2021 09:45:44 -0400
Received: from mail-bn7nam10on2064.outbound.protection.outlook.com ([40.107.92.64]:2753
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229531AbhESNpl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 May 2021 09:45:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmHlUxu5/Iai975x/1+6MNEoNeOmQIkVdjnaqiIIuqIK4pOiE+SQoYxFZ7olsEjF13LeEqAT9qOI0RjbwAnSgrRsDlD5d0GRdMJY/HkhUGHdhvdcIZm+Tyx4lphqASL5FUBS8d7Yp1JKMXl6+1/x6tJ7CBOm/eq+hkpopK/SjDEBMhDgT0XPrkPHroaS6811NfptV+cnH+X6UaQFFDZF/MPNgpkwVDuwFqFYUyIQ6d7HUx4hyN64y4RPYlEJJkjB7Yue2nC3G+WPMax+tm839FQaa4sz6nW07K+j/KX3JuvsxCn8kGtHeBaonieOSD0D7Ggs8bL6icridkIb0w38Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nE3JrB0boyQuOprc4q7o4IY7pMX2ZB3zXC6M9HG9/I=;
 b=nLuM85kz1cUHx2rMvreOXBSpjd4yuLXPIW6KgpWLySnVyRRwGQ9DBEplfiQBYOT/BC79GPJ7bEBJZ4kSMBcZht3MBT1TTqViNrvtA9jOhV4TqbfVJIKceXUtKPRmmzTUCtjUdm6NyBsGn/9mLZWrQ4jtP6OvqyxG0+Yi+eV1tCxh5d6R3hs0LCgHDyMVJC/Jpops2eK/m5Bl+xhIR3y1Xgz8SEwaZ8rzohk5DCf2SqfQ+dIdUelQsFkLPti1aKdyYGZHS3KTbu3gpUucRLHAxiozp305ze70X4j0X/gZ1nTBaOyg+A/t3fqSXXd1WgIhKFQf/2KGor5VuUSR5ErJ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nE3JrB0boyQuOprc4q7o4IY7pMX2ZB3zXC6M9HG9/I=;
 b=ijJwJ3J4N5DP+64yrN8B3g/zJeWSwDSDMKKtKTjFc4PuJjF/b7DAX7+cRI5+yeBf2ekr+ohaQnZL7FBwuefqnMmi+ES4cMd/G8eCmNUeMdGfrmpcQX1eZkee7rOFy7xMBcWgw/4PGuBf2TnHxumWpLyru3lt46aCCZ+0OvzRuoOS1wNHudDL7vf/yZFaWco4SLza8hhpSXJ9rTDdW3jtyUsS3kGOE1Yy/loyCXKmdfmJ6l3FbIEyf0s0gjzUwM3SpDgGGaBe6g37U9EkjqJjjSi3RTEWxdrCUEdZ0hJ9e15o7XCZyO3JIWJCg3zXD/5KsU52gpHS5wlsVU09tdLx3g==
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 19 May
 2021 13:44:20 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 13:44:20 +0000
Date:   Wed, 19 May 2021 10:44:18 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Potnuri Bharat Teja <bharat@chelsio.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 01/13] RDMA: Split the alloc_hw_stats() ops to port and
 device variants
Message-ID: <20210519134418.GL1002214@nvidia.com>
References: <1-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
 <2cdd5b33-1e54-779b-53b4-054d734b5eb2@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cdd5b33-1e54-779b-53b4-054d734b5eb2@amazon.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0288.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::23) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0288.namprd13.prod.outlook.com (2603:10b6:208:2bc::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.11 via Frontend Transport; Wed, 19 May 2021 13:44:20 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ljMUk-00AiQj-Vo; Wed, 19 May 2021 10:44:18 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd6af552-19a5-45a6-3b7a-08d91acc3431
X-MS-TrafficTypeDiagnostic: DM6PR12MB4388:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB43885C51F115F06B03F636C8C22B9@DM6PR12MB4388.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oPdEaiSxCH8Sq8uW7/YfitLGQyrUxDVA+MeIA9Hl+Q0g3xiysKI6wN27QopY+pRivuYSa0rO6WpIZokRKdY3EPaFGLjShqsXYOFPeVtTFeldDYOOBxhaTmoJVgsgRmDQkRZ6X3EosJGuNiUwby3yclDpjL7XagK67JzZ1b4+x5pLqYiA3jNlu+AnODcaQoXtQU8H0TEXIt7TmV4zFp4ql5XB7/s0ywXDei6JdubuYkUDIcLTF0bSRBovYuI6HMpTPK/cS4sjXqEnAyozWfqE1GcIw9yp9XtnqWJqecPTZvNsU8UNmreX5vqM75b/OhCIKVTDPMeBPWDYvvof46M+DixXaCAtjVioblBQoSzau5N3zScx87WRomMntqSnHdoqQJF/qdFdw4N8woxWYH7nnpxKx37voF4tpwgRil86GUKnLDrbQOYa5cq6JOVEc8TEUujNTGqkWjxi/snftcDLwN2PKRlHZ/LihyvcqXibAwjJxPH5fImk/KjMjIBSjo62LEgKuf7dhxM1aTqsegiuJAraGokBxxG5zRznejxWQMBumZFf3Z1C61EQos+ZyrOkFyzJ5SB6Ja2+3XBhfxT0BcZdS6m1MFpZb+hu5VbT5OI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(33656002)(8676002)(38100700002)(4326008)(83380400001)(36756003)(26005)(186003)(53546011)(8936002)(5660300002)(4744005)(426003)(9746002)(2906002)(316002)(478600001)(2616005)(1076003)(6916009)(54906003)(66556008)(66476007)(7416002)(66946007)(86362001)(9786002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?z/rsnYD+n/A2Wt/SEBqbggTFdhMDBMl+leuN3bKGBmsuUHWIxPdpGLK8WYPm?=
 =?us-ascii?Q?eKXYBx1vh0ZmUgUcqz/fv3P3vHISlCkjySXMIbqLITeepQMYesEpfOtrJdDm?=
 =?us-ascii?Q?tOJUYexJ346U8jAngSX7FlSXd+4fx9CJ4bYsVjsn32DZ/xVT+X6BRltL8aMx?=
 =?us-ascii?Q?QZiM9zm+EA0t/M+YV4+jN0k43CGbu7nYmSjTbVuuD9nWzkswwp4aEmcBFabV?=
 =?us-ascii?Q?phP9OI03twZPfDUJBqJp+C2Jer2GYtfWacFnHO86RfLmsLdUsCUxmL6+IE24?=
 =?us-ascii?Q?pDzgWHTTYNop1sQ9jXF55EMEvwUemtEL4MMt6e3y6HbvSMtk3uY2+FOOEN9k?=
 =?us-ascii?Q?Pv0wwllAzx7H2oy9I3KZwJYFHh7RmhIQiXSx4tRwNpkgvF0+tBQYALtEEA3a?=
 =?us-ascii?Q?mEsEjVoXLjtV9T5HiTkhjJGKa6Dc7DoVBsHAMeyRqaKgzvmw1ZJu0RQ4ibqT?=
 =?us-ascii?Q?s79ywHA9fkGkW4DArkqgNpuQGpM+iTjSxlobQlPR2AXbyLQA62iKSHEwM3Ht?=
 =?us-ascii?Q?LmE/cTIZ6rSMhe61wI5l27FAWptyVkEmbMmMXbxNzkJ7ElcLMI5HEQC4i6oj?=
 =?us-ascii?Q?C45XMY8dUl0xIWipbCrY8e6ovJShAznvWa5anXXjNjjmuQtn4qiuA1raYb/0?=
 =?us-ascii?Q?fLXN6gDJmZypukE7TEcuO9bA9f00Zo+KVkKw3Ev4LDkG+8bgoYPLGeGrKNt1?=
 =?us-ascii?Q?vGHYc6ek/in+KFWuxEuUbfD4q5adOPO2ZMcBstznBviTP1eDOL9pkiKHHPkH?=
 =?us-ascii?Q?1HE4dvALhu8sq6+pbSqyWZoQ8MSFkYWW3rjlNyzNTFONXQodIK6eYWodsNXf?=
 =?us-ascii?Q?C6A9bGGgeKMdBAvJyLMzEsLcdk1xRfCKYPM1xUGuCG2S03SdEMMIXpmToL/3?=
 =?us-ascii?Q?3ruFAqdXKnVJ3TtY3V71kaN4GQZEvNOqFRfvbPWcW/UdRHDFpC8XOOVUYQmJ?=
 =?us-ascii?Q?9q/erPiHtStF9N9ppI32Wayi4ohXaFkxipEh4OntnZZS+wB9tETsvaE9kSfd?=
 =?us-ascii?Q?V5YPpY+gn3SONGdVWvO1pL+LmgoLmX7cGZLvIy8W88YP5pfv98fDpFX+GLlA?=
 =?us-ascii?Q?b0LvkCj9caiNYB1vtfByPnDHAAyM2uCVLtL47AaByDcyRAN7ER+g6vkww4Oa?=
 =?us-ascii?Q?Ft+b7J8HOkoaYNHbFYjiJtXrj4bta4MYqw0MZkfTXshDWDTFyLHzJ1MToUyz?=
 =?us-ascii?Q?GsqEZw3jrE8jicHlYPwOBw0/JdbAEtAss4dibIc1Eap2uKJg14MIXu8zQp/s?=
 =?us-ascii?Q?g3wHIEL1AvtH2sLgJfOrrghWTi7yA0XuQzGTjkRVUauZSXfGKpamcVtJXFWz?=
 =?us-ascii?Q?2i22faH2JyFylvuh88OE4jAp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6af552-19a5-45a6-3b7a-08d91acc3431
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 13:44:20.3636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v8XTZPaVj6iIBQbJ9xgWnVLTDpbshnIX9IhG220swQp7jaGE7xmSdy+HEPK1tMqz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 19, 2021 at 02:29:57PM +0300, Gal Pressman wrote:
> On 17/05/2021 19:47, Jason Gunthorpe wrote:
> > +struct rdma_hw_stats *efa_alloc_hw_device_stats(struct ib_device *ibdev)
> > +{
> > +	/*
> > +	 * It is probably a bug that efa reports its port stats as device
> > +	 * stats
> > +	 */
> 
> Hmm, yea this needs some work.
> Most of these stats are in fact port stats, but others (admin commands,
> keep-alive, allocation/creation error) are device stats.
> 
> You can split them if you wish, or I can send a followup patch.

I'm not sure I'd guess right, you'd probably better take it

> Thanks,
> Tested-by: Gal Pressman <galpress@amazon.com>

Thanks,
Jason
