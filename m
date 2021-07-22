Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51BD3D25A2
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jul 2021 16:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhGVNnP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Jul 2021 09:43:15 -0400
Received: from mail-bn7nam10on2068.outbound.protection.outlook.com ([40.107.92.68]:10752
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232105AbhGVNnO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Jul 2021 09:43:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ME7pCrYVyth6h4uTwmmS8ZYMwTFOzsf67MzJ96hhI71ll46En93RgEOUL6IhPggPfhtyovdYHRWO9+Q8d+GTs7AzhK7DuiWiU1mKh/ry76XOHHrM3jTvILut0X6MipZ6BDuu64SuXyeymDMAiXvu1jpnHuNo05J635bnIceR0qOeGj+BF63I3EtaGyd0sh8rJvMLH2s+sH/x78p9X0OBZewlWc12hIySsME/mUv/qHTJFaCzlr1zdx5Zh0JwocVnTr3L17bIRs+jddEne9VeVR4kv2/BKzv+OUH0ONkR2hr4HI0pSsKK0GVXPRHqBCZ4hdZPdpeFEAXjj1BDA/sjoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kecF4T6UW2pSk0k4UH+z8zcuWfiVBxn8MBvp/e8Wqug=;
 b=KKYYDkbdZYa6SbzoOMGa8e8Vj9hpk8iu9Mt2XB3SKnL8oqUmRnzM1fz+OSXwzWner8+HbW6zb7X31GOBspviUVr810H5bv8/MYBnrD3eMfL3C9nijcEuxYgefKavlhnKuKcWt1GPXYglFpZxlzs1e3VtznpPm65cfOFlTfO+csR2aCY1NATM8713d3/+1ZIJ9tx4tOnkywnlAHIMn+AaHQ7/I1+wW1x0ccE47FOvxJSZyn0V3IKPoXGtzZ/ZT4EazBx/E1nX+omQuOiG7HolmlO9Be3IYO2hCfIhdBU09dv1saPuXMylGshk12OC6GhJqh+EZGf5MVO5QIQDSeCQFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kecF4T6UW2pSk0k4UH+z8zcuWfiVBxn8MBvp/e8Wqug=;
 b=pjZ1gO1j7UP9sfaymJNHHo0QenGSNi0N/g148nxbY/fIQcBCLRcXYoI0hYvo9oDALO6bPC5Q+XuFIpadbCO0GV/ai5wE8s3gS6jkG2i5CtT5wsRKaywaPium32FOELpAffVZGoxxnEVQA6NRCFRRW3Y7EvsLDSsE/vjiEg+CJ6Nik2NtBmfn9EmNXmVBPRI/TNW+xXIC748v8BXW4bI4HHtSqVAH5Wf4EzBnwvuOY00vfSKPaTCjMk9dVUYWmI0I/Rd3dNFHFymlCBRfwrDQZQy3xUV5wleF5kzmTtf5/2px79SaV5bdlN5aQB/1Oh2ZX41tsIvjp95nilGLtTGpPw==
Authentication-Results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 22 Jul
 2021 14:23:48 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%4]) with mapi id 15.20.4352.026; Thu, 22 Jul 2021
 14:23:48 +0000
Date:   Thu, 22 Jul 2021 11:23:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Chesnokov Gleb <Chesnokov.G@raidix.com>,
        "lanevdenoche@gmail.com" <lanevdenoche@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>
Subject: Re: [PATCH 1/1] iser-target: Fix handling of
 RDMA_CV_EVENT_ADDR_CHANGE
Message-ID: <20210722142346.GL1117491@nvidia.com>
References: <20210714182646.112181-1-Chesnokov.G@raidix.com>
 <20210719121302.GA1048368@nvidia.com>
 <2ea098b2bbfc4f5c9e9b590804e0dcb5@raidix.com>
 <0e6e8da9-5d14-92ef-39d9-99d7a0792f62@grimberg.me>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e6e8da9-5d14-92ef-39d9-99d7a0792f62@grimberg.me>
X-ClientProxiedBy: MN2PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:208:160::14) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR13CA0001.namprd13.prod.outlook.com (2603:10b6:208:160::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.7 via Frontend Transport; Thu, 22 Jul 2021 14:23:48 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m6Zc2-006JPS-QB; Thu, 22 Jul 2021 11:23:46 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b88d7b9-e61c-4e94-7971-08d94d1c5211
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5174F2B33D80F4654F6502FCC2E49@BL1PR12MB5174.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qMwTlLzn9f8fYotyvHnn5JrYvfwiT1lMqCHCvQEb//yaMZiIThOSFr/Ts77bmiAUNYnVzakT+lZDaPrlkGtNS0c/lbaX81Ejq3U2/Iohe5WG+kYOgVX0OVeSDydF8pOg2XsTBIw2smLzT5637GFoGjcAXmWmUn81cNn7fEPDHSmrq/NqFrgbACECZXqgcgyZ/RJd2VrwzlefszjwD263f0lK5Gjc6+BfAxr96GTUFfwEdnRYc3NtB1mfmJficemI8yLpgLeSGyWi23FuPZjrliISvZyZjLWkYmbG0C2l0J2kiyJvY1nyDqhZ9f/3jLRjrqDwX+h2qOW9bN7hHmZO0Fw5bqjElIFnMKhz2QQKSnBEIHcn06TkFXHZ73M+Ad0kmZRkHfYOmp3KuadvZ44hIJHL1MSvIEzUN1pbySltv7MDbzWYMsXgaFq+Fxj87RYLSY6tOfviOwNigCTt6yHyFQK8Pny2jZqAzy7Jgr1n14hXAbTcctpKb22cEVn59QyyeQRXcZ1K7UKbsP2lQAIGPAFZOHFjEeoYLgPnH+4h9UmYxbXVnpgW1+X/QUtlzqBi6h/+KbBPESrk7uKcgQfR9Q5QdZVgjFOfZASKMIYMHdulmdiZWplOddfS6d2pN5LJw5IoUgEjIZM93xZItSWVdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39850400004)(376002)(346002)(136003)(4744005)(66476007)(66946007)(36756003)(8936002)(2616005)(186003)(478600001)(33656002)(54906003)(26005)(426003)(8676002)(9746002)(6916009)(316002)(38100700002)(83380400001)(2906002)(1076003)(66556008)(86362001)(9786002)(5660300002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aV+QAIx9rsix0+RjKV/YxKiJO+IaoGS9dMT2/2WDVqwwLiF3K7VNEvvt2/j2?=
 =?us-ascii?Q?9O1YGPXjjpq+zY8uJPfUBBS4Ms3luggigpjZ0RJvf2bfWhKkMMD8e1TFTkHX?=
 =?us-ascii?Q?JHXU8XJSZe/7frWyjYRWl1EItBS1JK5cQ52IjcOOR8J/q1bccVmvYngalQ6d?=
 =?us-ascii?Q?9Ez8f5GL07FvC0g6Eem7IOO6iLwNyJ98Nu8o1fsscrUO7iMY/4eUTxVFQcvu?=
 =?us-ascii?Q?O8760i+uluICvsyBdQsMTnVE0wcx/GaZw56MA8vwzMi8lVsVA+QfN5xLe2AQ?=
 =?us-ascii?Q?P/0AB6A7bynYm70jXB2GRp95/zkiAqALzIZ77tdogLE71tFNFVHU7x+0v9Un?=
 =?us-ascii?Q?yA+GFc+P2tUmMvDacWplT5yHyUUVuod0/8/b5YojBS8YvuOtbhdRdHh2v8NV?=
 =?us-ascii?Q?D1dYiruSse6fdzlhPe5F0QAcVFlZojoWk6waeSaPzroItfdDnb8vkKKWKspj?=
 =?us-ascii?Q?y/gePHdBWDJjrT8zZ/r4Q/p5aa61Ihp+9c7acEIw1SQ3mTselM4JpC66O8zb?=
 =?us-ascii?Q?SExlVE3F5XniTA3qD07mHxHImRiQRhrWr9C+pp2YSPmWuF6/Xndt6IpaRhYQ?=
 =?us-ascii?Q?ZY1LOF8A2j3nTpd5pc+q1kzUmwmC0mZfOjG/X+2GbQNWUTK48ggVVf8URkIg?=
 =?us-ascii?Q?RqCVIukyZpn2SyZotLuZKNZ40Ir4lIh6oz1zc0jPjZQ/hHBYtmqBe7AwWiLd?=
 =?us-ascii?Q?KuxyHRvYUpiITFwGTvdz8JAVdFTthefA6mcxMsWgHQ/4GO7L3zOwgIjBctDq?=
 =?us-ascii?Q?wZMYMdhI5+FwVTsI7NiNg+DrM5R0BCuK/psyQbaOcHeM2CrgVhsts+e7zqvs?=
 =?us-ascii?Q?9mOjx3IE9w2gEDCjZuMNx4YS+ZiRKfeFG6xiS3Ikcb/Rl8QcJ1CmBnq6S2AV?=
 =?us-ascii?Q?eTOoPhPFnZGI0geZftH0pmStonKBO9vEpp50GgSF+r1XyslTYvLRl8RsQ+wd?=
 =?us-ascii?Q?8lIDD+DV9nuQd78OzrnknzfqGFgl+7m29sORWpHD0uIa/JvPQ8qAafbOQjWk?=
 =?us-ascii?Q?MscjW1ua0MH2aCuHImkm+KMNcbYMFejmAHHrNklVvJPiHhVpIsHE2okIKnqo?=
 =?us-ascii?Q?Cm7tBkmWdxgMzV1rNJaiMfwJXHsdidSU9WNpN93JSvlMbs2piwMlD6Y6Ebvi?=
 =?us-ascii?Q?jRoHsVlWe+BjLQ1Fsqoyy3Ua4elhAzKjx1FiM6eX/+sMEZqsOJHdqVnrPJTF?=
 =?us-ascii?Q?j8w7r9URbSeDFrAMRYISICB/kjGXV/RQc4FgYSK0FMsF00fkTuMTHTy8dVPr?=
 =?us-ascii?Q?n8+iAA+AqBM+t865RFQCQGJU/bvx0kIgvCtspcqwZcT6uJMaQ4VpwQYE0ohS?=
 =?us-ascii?Q?d0Qx6jASm7diO8Tlv2BLQ6up?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b88d7b9-e61c-4e94-7971-08d94d1c5211
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 14:23:48.2469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KfHV/NqaRPbI5ngyERVUJUdYIabEJwWqYXQU2tg0RN3dnNBA/0f93lmA4opa1Mie
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5174
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 19, 2021 at 11:29:40AM -0700, Sagi Grimberg wrote:
> 
> > > What is this trying to do anyhow? If the addr has truely changed why
> > > does the bind fail?
> > 
> > When the active physical link member of bonding interface in active-standby
> > mode gets faulty, the standby link will represent the assigned addresses on
> > behalf of the active link.
> > Therefore, RDMA communication manager will notify iSER target with
> > RDMA_CM_EVENT_ADDR_CHANGE.
> 
> Ah, here is my recollection...
> 
> However I think that if we move that into a work, we should do it
> periodically until we succeed or until the endpoint is torn down so
> we can handle address removed and restore use-cases.

That soudns better, but still I would say this shouldn't even happen
in the first place, check the address and don't initiate rebinding if
it hasn't changed.

Jason
