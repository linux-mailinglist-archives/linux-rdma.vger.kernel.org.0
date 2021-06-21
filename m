Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5483AEC76
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 17:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFUPfN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 11:35:13 -0400
Received: from mail-mw2nam10on2078.outbound.protection.outlook.com ([40.107.94.78]:33810
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229890AbhFUPfM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Jun 2021 11:35:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQkJg33lEy/vNpO9fwxs/dJV9RMbxVeZA4Ny6L4aGG3w6vXc2rBf6ChISYi3IV6mzVBhPOOqKO9Dyo9kOM7G6xkkQtqXcq5RPV0eCYX/XeqtPH1kr1j8oV7/+a8JFVcchqgZbc/IPo3S2c5MfBr2Jjoxyr85g7NhA63/ZszN3MME3ZH9+ogK8Zslz5FHcG+4aaz2nQa/z3hYmjbWOGe8NzrEKNUr4itDjBl6nEZLieCk1X0vF33djzVRvQWrvE0+gDJEnEfqQVL12PBlaUHR9mLQao/1lUm6IJMrinVjRaYNEJgxrKTwhv+nftS5whK0QBipMBUyKvIQpWNT+53PVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwzMIi7uv82JbgvaMz+jd8TgesUlkyNa2OK6zgkpuUE=;
 b=SUb/1r1l7U1lJ+2TviMDe10FWV8dND+BaCydZHiDy0ugGzFECn8bMO7PDHxnINEsEVdyQawGHD+P7G42et/b40rOyMvhdy3xBKYfFbXZVd7kyT6fLyak47RRrKUTCgggBhFhhvPMoVY2gN79ozkReUrvlpDpkvb9toJZLzrfMQPnG5LG+D6yeK8Cln+4RviP7Lo3sfpgzztIi1u/eVhCcSv59x3DdGdsfI77jZsJ/tPHnuS3yMmIfJ4SlBYKZXTBopB321F1Au+8J7YbcOYBG/h4r1WfDg2aI/VTGP4Rbcg/qGMUX9y9ADSXgP4Q62+XLC/g3qvIA2kp4vX8z/r7JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwzMIi7uv82JbgvaMz+jd8TgesUlkyNa2OK6zgkpuUE=;
 b=awy2cJmgH08o8Hu9gREo6VgYuBHG/+L7jGlDYY8VH/LHwahuZHpbYMdNGNOyu5dL8vjgImDp6jzgAaNd94Poy6qGZmLu2G/qbskdQHU0z+b9CdZzS1xILJMY9OPoFOJjjGf6vMZaLvimD/GN+VRzZtdj7wQAamODLjFTFIec+lPIEbWJIsQDpD6GtYqKHqSJODMbcecJzF6vZAsUvpGPqjSWrI3ltfw11cGfIxm3gMLR58jW5cOqFXP1wtsJ9deqpAoX4KF6KqHTtkvYyJ7DJwmv8cy/XJ+mv3BgS00sYMPktKdngEcRInoFwplYhQS88S8MyeLe2d8da0Qj/9rOjg==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5380.namprd12.prod.outlook.com (2603:10b6:208:314::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.23; Mon, 21 Jun
 2021 15:32:56 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 15:32:56 +0000
Date:   Mon, 21 Jun 2021 12:32:55 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/cma: Replace RMW with atomic bit-ops
Message-ID: <20210621153255.GR1002214@nvidia.com>
References: <1623854153-19147-1-git-send-email-haakon.bugge@oracle.com>
 <20210621143516.GO1002214@nvidia.com>
 <B57F3E25-B24A-41E8-9CA3-6BA83E378746@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B57F3E25-B24A-41E8-9CA3-6BA83E378746@oracle.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR02CA0142.namprd02.prod.outlook.com
 (2603:10b6:208:35::47) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR02CA0142.namprd02.prod.outlook.com (2603:10b6:208:35::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21 via Frontend Transport; Mon, 21 Jun 2021 15:32:56 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lvLux-009iXX-75; Mon, 21 Jun 2021 12:32:55 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 547cc141-b7df-4958-0a1e-08d934c9d7f5
X-MS-TrafficTypeDiagnostic: BL1PR12MB5380:
X-Microsoft-Antispam-PRVS: <BL1PR12MB53806BA092EC92014350CB6FC20A9@BL1PR12MB5380.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xdkKaSi6r3a1W75/88rizpPsFMyVep5tPknqz+YS2KKn0Zx/8rByEw2M4IuIJ0BvyIXRWwyAlpgSVEz8MKZikLyPe+QHuTqFgUQM089BH8TdHF17vyg4R6ZuNaAKvyN4MX4Cgqk3Tpjs5XIvnmzmgKFaCUlvrtOaYEAXGw5WNNuGuNy/A4+g1eWlyWxZRmjtDqZWTUvbHJiD2JOn/TMCEK77fmTEhHlKI7w+Lgd6st4RglR9qAbQNpXmons1QOZ5nzpldYAxKQm1rmW362jsbGGpymjF3OE7b2vayGWtInx1f13EY0LUktFnzK50ow3to+GCk7YTw5fxYWLdtAzGICs4CxF6OaVqNSapLhvpyz8HuzEouL9cHp0TyneG3WrUAEr9PGjIoJzOT7XR+Yy3G3wnIiXlW800ags0MgTuEA7OwHqXdOFN1WiLukEJ/QU04xuQnwIDpuaWC7FXMQdJKdOvvqCDzge8M3PKip0kNjrcXDYp9ia8f0JEPOJgFnPKdgQukqKxh7+xG4CPU0SkyKi5lR6oWRVWBim+wFiLxV1i2E86/3mbolKhLPo93CPE0LOiKG8v8KP4bckIwv/H+j3AXajY/oRoRTUm6ORYRRM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(5660300002)(26005)(36756003)(478600001)(4326008)(426003)(2906002)(9786002)(83380400001)(86362001)(9746002)(2616005)(54906003)(66476007)(8676002)(38100700002)(1076003)(316002)(66556008)(66946007)(33656002)(6916009)(53546011)(66574015)(186003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEszUGppRzZnMmZodjNoUStYT05SNlJIK2JyYytvMmJVRnBmRTNqcWRiNzY5?=
 =?utf-8?B?bVZuR2ZzMWZJNWRrVlpoMmlqQWxPT04xYmhHNzM4b085TjY0Wk9YTUdacUdM?=
 =?utf-8?B?RUZJbU96RmhVbEhreVFoRm1pK3BNeFBYelR4RGJIS0hMM2s3R1l5dnM0a1hz?=
 =?utf-8?B?RlNLR1dnYWdmbTBDTkUrNWo0ZXZ3eXFPdVlFNDl2N2cxZVVRUFg0VFdaTTl6?=
 =?utf-8?B?N3lRQ01Dd2dLMmwzT0lRRkVnVU9KdThZTERJdUFvL1ZFWGJQcFYyUGVjS3Rh?=
 =?utf-8?B?Sm5JRjJLYjFKSWZ6b1krUnNQeTJvSkI1NHhXVUpwYW1nL25JckxZbVp5Mnor?=
 =?utf-8?B?RjloMkRMTWJLcFZzZkFFOHdXbUQxSnRjRlJVd1NIcGVON3RIb0xwb0w4dTRy?=
 =?utf-8?B?N0RCempIWTIwNEk5alBLcytzZkdISitXM2Y3VVRzS1pBdlJLbmZKUENSMENx?=
 =?utf-8?B?aHI2RXpXWVlCd1hvUVZOYzh2WGJ4dU5uZTBCdG9RVHBmUFJiRUFlVXpZajZD?=
 =?utf-8?B?Y1RUUjVmVjBEOVNlM1dqYXFKSW1VNVl4YXFVL0RtY3Z2c3dsZGdnblJWZjVT?=
 =?utf-8?B?YmNpYWZXNGliUy9ZU2t2cGFVcmp2Z1gyRnFGUVl3b2JJK2EwMCt2am10SGtP?=
 =?utf-8?B?Q01TTURNeVhERStLY1Uvc3k4WXgrREJhc3RjWFJ4RVdyV1ZneFA2emNZQjMw?=
 =?utf-8?B?SEJzT2trdzdJcCtpMysyZGFuZTFMdWs1VU1YRzErVyt3ZmRsUHNNbGhLQlph?=
 =?utf-8?B?WlNCeWlBTjc5SFRZZkYvdDIvd2JXcTZkd2J5aW5OV3pDUUxoUWQxdU0wT1hT?=
 =?utf-8?B?SHp4WHdUMDJFVENMZXVCNGQ3Vm5vWkFGb0srYm5VM2ZpVi9qWk0wVjhHa3JL?=
 =?utf-8?B?MGwrVEpEdjM5LzRGb01FcVhiL096VWVYbjRCd1ZsZFpwa2xrQU1NWDhyQXJ6?=
 =?utf-8?B?bTBlU1VPaVFmOEIwWFl6TGtadERTMCtwZ1I3SmJCWm00QnQ3M2pOckpWWk5J?=
 =?utf-8?B?Z1RhM0o4S3dId0FhUklNcmlyQnMyV3JDODhGeXptblpiQWdGa0c3WUZjYllw?=
 =?utf-8?B?d2J2Y0t0c2VyWG5uUEw3TTkxS1ZndE1MWTZtdEs5U3N5VW1mUXpXd3dPcVlN?=
 =?utf-8?B?akkrY2ZCdzZuU1FkU1ZqdFJvMVREMUtkQjk2WHRTckpWYXhaUTZlZ2F3WjRw?=
 =?utf-8?B?SjBwNEJEc2RzVzhleERObEdCM3pYekFmQVAwd0x0bjJtaGR4UTlraEZhZjc2?=
 =?utf-8?B?d3R0VWs1MU1teXNQY2J4bjJrQTNnaWxKaXNVVjltUGZaejZPT0V6eHFCMHVH?=
 =?utf-8?B?T09CVnljOGpSbGZUbkhzb2cvbS9rYVhybDlYVFdwSG5HMlRzUVdsazBpZ1Zu?=
 =?utf-8?B?WUVRc1V4dEc0akZLNW9CV0ZWU0FHOHgyN0k5V09TeWpBZHNWWkNYTFA0V01C?=
 =?utf-8?B?MGdUOVNhV2RnZkNieG9vUW1MSU1KbTdWY2xXS0pkVWhuZ3MzS2pUWDNHRWN4?=
 =?utf-8?B?K3I0K0hHVTdYRkM3UkJqbHllT2dzRm5wajYwQlJFMEVhbWNCaWMwa2Q2bXds?=
 =?utf-8?B?MEp1dCtJbkwvN29FS0pDTGcyTTFvaHlBbDU1NnVPZXhSWUpyc2hsSGY3Q1VW?=
 =?utf-8?B?NTczdUNCdWxnK1lzSTdENkY4SmJVNFh0cTF1RmZCYmdtMEE0b1UzZ0pROFNX?=
 =?utf-8?B?QTdJNXJoc3NuWkQ1YnV6S1c4MGFSK1BBdUpOckZjTGxsUVUrY01waThPM3Av?=
 =?utf-8?Q?4746ygJIXUeWSi9qORv7kHLmAkzKUsZD2q4gI1F?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 547cc141-b7df-4958-0a1e-08d934c9d7f5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 15:32:56.6832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdSKwTSKf+4IQscT0xGnFrI+RehXsjcJqClXV+SluJZsLJL+6EMj66IV73iH8wT9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5380
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 21, 2021 at 03:30:14PM +0000, Haakon Bugge wrote:
> 
> 
> > On 21 Jun 2021, at 16:35, Jason Gunthorpe <jgg@nvidia.com> wrote:
> > 
> > On Wed, Jun 16, 2021 at 04:35:53PM +0200, Håkon Bugge wrote:
> >> +#define BIT_ACCESS_FUNCTIONS(b)							\
> >> +	static inline void set_##b(unsigned long flags)				\
> >> +	{									\
> >> +		/* set_bit() does not imply a memory barrier */			\
> >> +		smp_mb__before_atomic();					\
> >> +		set_bit(b, &flags);						\
> >> +		/* set_bit() does not imply a memory barrier */			\
> >> +		smp_mb__after_atomic();						\
> >> +	}
> > 
> > This isn't needed, set_bit/test_bit are already atomic with
> > themselves, we should not need to introduce release semantics.
> 
> They are atomic, yes. But set_bit() does not provide a memory barrier (on x86_64, yes, but not as per the Linux definition of set_bit()).
> 
> We have (paraphrased):
> 
> 	id_priv->min_rnr_timer = min_rnr_timer;
> 	set_bit(MIN_RNR_TIMER_SET, &id_priv->flags);
> 
> Since set_bit() does not provide a memory barrier, another thread
> may observe the MIN_RNR_TIMER_SET bit in id_priv->flags, but the
> id_priv->min_rnr_timer value is not yet globally visible. Hence,
> IMHO, we need the memory barriers.

No, you need proper locks.

Jason
