Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEEFE1DFD6A
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2020 08:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbgEXGVD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 24 May 2020 02:21:03 -0400
Received: from mail-am6eur05on2058.outbound.protection.outlook.com ([40.107.22.58]:25661
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725805AbgEXGVD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 24 May 2020 02:21:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AR1h7lYtISZl+ESy82dBdiV6WLu3C9HwQPJWmRSvgmYvoHTxH8BRQ1Szln5Rh/8JaMien8rlzsTz+6jkRR7//xviTWAFFgeFTw/9BNJfYFavpfPd3XfjKsisZWBK7IC6dNm4v7NCVTdUA7JfyziZTxlKminv1fc4sdhlX4Le5D2sL8PxqZ7vO2Ot14sTeySIIYXmrM74pcsfxc3Hp6Mpxehummb9fjqS8gMzWbB8rDqlHKFtNqFlVRPj+CVGgcispKoZbjyeDZB88bLR2gHXbpKxt3FQbFbroGp3RkwNyDu/g9kWxZUmPfpZlhh71DI7wdHORaAhptMLhkDOu8y/1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+tjBidunxC/Op54gANal65Gte/VDr50EOEY0XMOv2k=;
 b=mYqnXrFyLqzQMu11OmT3s7YOHo07OIsL9nb8fHEUV9rCYqmtb2vQuox+x1K7bZ9qXclPOaJ6RB9hsnT58gEVC17bOdA9MyldXUXI86kYjeIzclGB1sQJ9OFp1rV0/nVdGKw3gykPvOizX/SGIYuDDaKjXrGISFW5BrUHySQuf9sKmb3yh//RFZphHZBlxUvsNco+osX9rK4upjVldqCE+rpAQCWoJT7nl/QP0LG44250cMTu/lRnQNytTEA9yI5i/kYEohXSd4xITBNxalyThIoulAI4HdSfeirkeRzKPaf6SeHbXpko5c6pq2zOvf08qkopvSMshdM7Do6CMu+zFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+tjBidunxC/Op54gANal65Gte/VDr50EOEY0XMOv2k=;
 b=FLTQXhQkrczlQhd5MQf5cJ6cQWuSHJZEj+eUFJ4LGxF0IIRNnJ+MVFWQFGT1Jr0nDC3wFjmgaeeLKFKOqYj1GraY0YQrs2wvejPzpJH7BP8v8TOQdkC5KS8YC2LtIZVJ1l8H2DARMmwL54YF1e+zveSqf2T3YX42dsH5dmmgoIs=
Authentication-Results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=mellanox.com;
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (2603:10a6:20b:b8::23)
 by AM6PR05MB4406.eurprd05.prod.outlook.com (2603:10a6:209:4e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Sun, 24 May
 2020 06:20:59 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::1466:c39b:c016:3301]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::1466:c39b:c016:3301%4]) with mapi id 15.20.3021.027; Sun, 24 May 2020
 06:20:59 +0000
Date:   Sun, 24 May 2020 09:20:57 +0300
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org, Laurence Oberman <loberman@redhat.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: Re: [PATCH 1/4] RDMA/srp: Make the channel count configurable per
 target
Message-ID: <20200524062057.GC569407@unreal>
References: <20200522213341.16341-1-bvanassche@acm.org>
 <20200522213341.16341-2-bvanassche@acm.org>
 <20200523135523.GA569407@unreal>
 <3fc10293-d65b-fee3-ad5c-833323516e96@acm.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fc10293-d65b-fee3-ad5c-833323516e96@acm.org>
X-ClientProxiedBy: AM0PR10CA0088.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::41) To AM6PR05MB6408.eurprd05.prod.outlook.com
 (2603:10a6:20b:b8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2a00:a040:183:2d::a43) by AM0PR10CA0088.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Sun, 24 May 2020 06:20:59 +0000
X-Originating-IP: [2a00:a040:183:2d::a43]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1a775746-8059-4b73-90ed-08d7ffaaa050
X-MS-TrafficTypeDiagnostic: AM6PR05MB4406:
X-Microsoft-Antispam-PRVS: <AM6PR05MB440605B1F705C1DB8264EA0EB0B20@AM6PR05MB4406.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:205;
X-Forefront-PRVS: 0413C9F1ED
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C4cUtdZFv0HifPWGxxZZY466hYtbg5Bn+EDb0s/RC2YWow3bKnIgTzS+IbhIiV/UI7hACUcPR7jIIkRjo9cdXGbZACBB+2ycpqX3BMTkWneuMjRw2qUzaHc3M6g0s/2tTsnJm5Uq0kTXUW6m4GcysO6ukG+b4BO/K2J5637EKU7fNvZVL9xAO+58j6279/hOD9vxB2EuasjmtBN+t4mzkW0Ium4HBGoTKjtjGqHLbF/Q/zxWUGyeE5DaaCBBb9uu+fdPDUMjQuiNYrQsRRwmNrLU/Vg4lbWltju3FXwGikWOBtWJzx/3gGHyJJM8xj/8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6408.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(7916004)(136003)(376002)(366004)(346002)(39860400002)(396003)(53546011)(316002)(4326008)(9686003)(16526019)(186003)(8936002)(86362001)(66476007)(66556008)(66946007)(8676002)(6496006)(1076003)(5660300002)(52116002)(6486002)(54906003)(6916009)(33656002)(2906002)(33716001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: PfoAPbf/zqibLhG7ZnPmvr5yPi1n9cpby4g90symoJ5/9X1A29O2iPbeDl4keTnKGIH1QdDIfzjliufFggpiRQxzEkKQFYsXbaDMWshJ9nlWHbx8pFGuFTARvp6InpEHqlTNHnN0SRn7wvdKefdWrHSr1KLb5zflIk1hlpPrjyHu9KDCx5IRZ+HUJXViHrJyysrQXlGpbm7rBZaR2qQMjNfHo7u4O28kseY0fjcJnPFNz7Ogj0uj1fzgDErWb2IUOaJDKHDCMVxLK/nGbVJZkEb3A/9lEZuAMJ77ZAx2Cjq5b1Wd2YNyn9WRJ+kFMKzNB5MDdcxn0rdco/rfJuM5PaQjN8GUg3+11I+eFGu1BVZ9iPe6D2GTEDuJ6QSajw37bJatOhQq7M/cQLJcHuQwOqIYtRO/x6QGwasDKVyqSQkAtqQR6m54nnbMD4p64qkhEXqQdkjQp/x7GI6rlS9iz9jKUwgJxOaujplOqh0Mxl0orCFujgR6ptVjScz9nkmk
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a775746-8059-4b73-90ed-08d7ffaaa050
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2020 06:20:59.6991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HItt6GrKzMS7TDLp6J7D+PPBw5JIlI4NWcakGb/PVRxIiaJjbMzEmGOLeaRMrVWgQaz5xDJHAVQ5w0/pcgRjFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4406
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, May 23, 2020 at 08:22:19AM -0700, Bart Van Assche wrote:
> On 2020-05-23 06:55, Leon Romanovsky wrote:
> > On Fri, May 22, 2020 at 02:33:38PM -0700, Bart Van Assche wrote:
> >> Increase the flexibility of the SRP initiator driver by making the channel
> >> count configurable per target instead of only providing a kernel module
> >> parameter for configuring the channel count.
> >>
> >> Cc: Laurence Oberman <loberman@redhat.com>
> >> Cc: Kamal Heib <kamalheib1@gmail.com>
> >> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> >> ---
> >>  drivers/infiniband/ulp/srp/ib_srp.c | 21 ++++++++++++++++-----
> >>  1 file changed, 16 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
> >> index 00b4f88b113e..d686c39710c0 100644
> >> --- a/drivers/infiniband/ulp/srp/ib_srp.c
> >> +++ b/drivers/infiniband/ulp/srp/ib_srp.c
> >> @@ -3424,6 +3424,7 @@ enum {
> >>  	SRP_OPT_IP_DEST		= 1 << 16,
> >>  	SRP_OPT_TARGET_CAN_QUEUE= 1 << 17,
> >>  	SRP_OPT_MAX_IT_IU_SIZE  = 1 << 18,
> >> +	SRP_OPT_CH_COUNT	= 1 << 19,
> >>  };
> >>
> >>  static unsigned int srp_opt_mandatory[] = {
> >> @@ -3457,6 +3458,7 @@ static const match_table_t srp_opt_tokens = {
> >>  	{ SRP_OPT_IP_SRC,		"src=%s"		},
> >>  	{ SRP_OPT_IP_DEST,		"dest=%s"		},
> >>  	{ SRP_OPT_MAX_IT_IU_SIZE,	"max_it_iu_size=%d"	},
> >> +	{ SRP_OPT_CH_COUNT,		"ch_count=%d",		},
> >
> > Why did you use %d and not %u?
>
> Hi Leon,
>
> There is more kernel code that uses %d for unsigned integers. Anyway, if
> someone cares enough I can change %d into %u.

I don't have strong opinion about that.

Thanks

>
> Bart.
