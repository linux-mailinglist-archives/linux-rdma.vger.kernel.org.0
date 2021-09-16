Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C7B40DB1A
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Sep 2021 15:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240104AbhIPNYJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Sep 2021 09:24:09 -0400
Received: from mail-co1nam11on2054.outbound.protection.outlook.com ([40.107.220.54]:24800
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240099AbhIPNYH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Sep 2021 09:24:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guMbvSV9xiEfWzi4fY8NwHoR+HDXJuVWd/5buTVvge35zNGa8QQZ3bM3U/SF74g1FEehnJcbD3iP3Ockfw65ZTory70sQKYrxJ9JBuaP/e0YvwaZuwlsRqJNqvRZ+PJs8mIDFZiR6MGpKHjE/VKqi2wxFl0KpTkclVG23T5FABdpyMhaxYLsdgJ+OWkDcW4aN3xnvf5652TrCD7fIaMqpfkDdxncnyFAg1zCf4J34jRf6gmckRetea7L+CCIIpGHrqPIXuwpv+rUSg0GmwtbTqkJwC1av9QeMPRG3m0qXNlMrdVaNGr+H3skXo3bmPV5ZBzunA8b3jJsFDjqjib46Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=JI2954sdhvACRLsPrfJtP7Y57pl08Nl6kw0vIW1YwkI=;
 b=mvHggpaSmZvW66NHU4i2a4wSoDm9NW2cRnOdJ2pNUR5o8/hAD9PDlkmc+YGUm7/0M7ggiVsJHj1FFyc2HNe3Ny2981bnYxG3+AqjkezsXPwUsgchL67WYcIKpxLNXVfqRUtYNWqf5jvedjrrZqZriFfgO5l6AFjHq8mHe2yfqxe1UvTc4GVlE13tNI32z/H+KxWyXSXGeR4cJZ/wtxggPExNjv9D18kenxz75QibU1Glg+Z/BJyCpYOIkezfGUxi5DPJBE/W33mpv/nZkgPRyMS85LDkx2rsBb+mAa3jilchrClHBXN4wttzUdrmPG5I9loFRcOLHOkbS76dt0Wq4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JI2954sdhvACRLsPrfJtP7Y57pl08Nl6kw0vIW1YwkI=;
 b=IWcCry20agYybEJ1VxvzPSdlEI2FjhYsQYRl2a3VVjF7kj+Xyy+65Xi1bNemi/a/cLXrEmxGtNdt5nXN3ZTsC+uKoJFAxTAV4CQR2X55v4O0rAf4sGTZve9+MzNZcjYO4V/GJL/a7yUG1SwchEnuoeafPhsrKIu+z6imAlc4CwndJGstCqPZSCVVwb3Ub6N9YBrTyd6kD4Al94SF4hbWWz6mz4tRdPiDGsT5bOzQ6oCDpMhshiBKPmgWySRds1NKWorhctOnm42WIjMLfd1K3FB8/LOJIHowiJTboOHAGJEAUm7C8A0+6sUY5kHFUCg0h6u9qhm0DH/IrLJ8T3EDig==
Authentication-Results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5523.namprd12.prod.outlook.com (2603:10b6:208:1ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 13:22:45 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 13:22:45 +0000
Date:   Thu, 16 Sep 2021 10:22:43 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>
Subject: Re: [PATCH v2 1/5] RDMA/rxe: Remove unnecessary check for
 qp->is_user/cq->is_user
Message-ID: <20210916132243.GO4065468@nvidia.com>
References: <20210902084640.679744-1-yangx.jy@fujitsu.com>
 <20210902084640.679744-2-yangx.jy@fujitsu.com>
 <20210914183240.GA136302@nvidia.com>
 <61430B67.5000301@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61430B67.5000301@fujitsu.com>
X-ClientProxiedBy: YT2PR01CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::28) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by YT2PR01CA0023.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 13:22:45 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mQrLf-001MzI-I9; Thu, 16 Sep 2021 10:22:43 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c8f8441-bdf0-44a8-099f-08d9791511e8
X-MS-TrafficTypeDiagnostic: BL0PR12MB5523:
X-Microsoft-Antispam-PRVS: <BL0PR12MB5523391F90782C294B372724C2DC9@BL0PR12MB5523.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iYvABDsvqyoq+APwXOImmEAmRUd+hl8dnqoQuvq7JcpC/cY4lXBHFkBGDhQNeDx5QT64F2imNWYdZwCBHre+Su/8wfAUeB15groXdm/o/8HHt5POIuZ/r4F+Oi75EEweDKOUnjNfM3hOBuLevzfl5/MnIlec1re06iae1Cfp04HbT1yNbtI4L2dVIJVM0nscPtESo4cVexxE7u3FlIT0RInW2tLXjUkJLfGNO4gK0Ezp+T0488mgRAzoTcHiAiCRSYxVO7sOx1dKKqBGAfC1EiJ5+F2BqwJq61woLqMWUtIvCJnoIhH+dSLUk/wu/xM+DxPFmeRr6fYryTICYjYYJnzrHIKANh13H2ZcXV9wuaRzAmRuOcanHl/mOiKkCr9PCWgc7fj5Ma+jmcOiEXO26jOQftsIkDQ7z44FI63fdTTxpHyaQ0CkX4TX+x2PznC1voQ3iW+blBVfOb5+opZ5vnxypGnAOXn7YtM+E+U/DfffKIND8DtwnOg/o7YCnMWaBNy2doeEaclgSNi/gaoSCe7fi/mbgV8NE1YmDdteJmQtaZyAdYN0zZF/tIKgIIjDZzbb+YolsKq/nyIzQlcYb2gU5E+eOob0eDm8Ch44LNZx1d4me9WXiiPbF3EvEPItLgkfDcQZ1feUBU4AyWeT1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(186003)(53546011)(5660300002)(9746002)(9786002)(83380400001)(26005)(6916009)(4326008)(86362001)(8936002)(316002)(66946007)(66556008)(2906002)(33656002)(8676002)(426003)(2616005)(38100700002)(54906003)(66476007)(508600001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8nO9skvOLucMGNUfE4V9npMn7GAzpwD/oPySn9DCRsRhPyMFxKDUc+DEYqIP?=
 =?us-ascii?Q?b3bWvmpiSjF84mwFhrLmLyxS05bNsNFy6BWpQ3z8oOC3diiV+ZGfj5+zcmJU?=
 =?us-ascii?Q?Hse4g/ridTezkTsmTUQfQR9TWq1sq+zzx5JpZqHYt300JQVo7bkqI/5CkWHX?=
 =?us-ascii?Q?Fv32CMqqYyd0wWxJdFmKsd+QaJISVwhH1CCyVefdwcC4dAioQ4la15J1omEn?=
 =?us-ascii?Q?gnBQgIfigwBN0KWBTzMK2iJEKipf8mh00Nmmsilm+l/qsbvfVJNUSyJl16WF?=
 =?us-ascii?Q?eYQtT7vamfa0zAKv365+RS9KaldmRr4S0eZrx6CFMfuPM9L/d2d0TXstioNy?=
 =?us-ascii?Q?3JRy275PFv2qJIDoQN9lNQdyiGh5jBzApH3zmYovbUlsTGXyFYtHchYXjixU?=
 =?us-ascii?Q?BwfUWwIg1QK8qElySKSVPZjEYBmGDxpi/gp+BOcZDjT7aFJwtEqQ2eSw2m7K?=
 =?us-ascii?Q?jMve4g1J7lT27Gn13b9MpGx9lkpo55PWkClorh1tTEvswUcIaHv1QxUkmGRA?=
 =?us-ascii?Q?bddzuCZhgLE6Vpntx2SKuVVRPFhN9BJKRwOMFt1Yh3hyka0c4GXdoxsDEnaM?=
 =?us-ascii?Q?v1pYebCBD2zWiYNsTIeiKUTUj8RfnQYYmLmnnihV0R7kDS2AkAkkfJSVMHQc?=
 =?us-ascii?Q?E7seaI2Auc8P2birzcNHljNxQ3OP8RXPrmLLCpVY5WLS6r3WWB2EtVkMmwTl?=
 =?us-ascii?Q?nvn+UaYtQ19YeIv/7lZFsPOV61epCbhZHy/wxGMBocHfIdzzRYIkHc6STWOc?=
 =?us-ascii?Q?iZEX/NXkSr6vCQNvGvV52V+t8ZTezZ5ev0MGmh5goWQ/GVmH7jWHYnVx39v0?=
 =?us-ascii?Q?VWIzOFs4DwU+XXs4OQ6fH1PFsjUZ3ANpVbpel4yPnbLJHKTxqF6dCftgBDRd?=
 =?us-ascii?Q?ulri+ZeAzWTeyB2+UiFiMRAuiki/zTgYzq6PeE6ot/uxX+lMMl4pY5f2i2Dw?=
 =?us-ascii?Q?TRolbXUuWhk6bP5aL8lEpHdXbrmTLMvK90psM836tUP7p/+AL9N5fmkBJ0u3?=
 =?us-ascii?Q?w9TjfStlZWq5xWbyYHYVUTfpi4DRIQs92w+i9tLhwYEI14+lZ6goG0nZG907?=
 =?us-ascii?Q?SCm+C5e8zNB6fP/UZduZS9mod2OTSVniZGOS8DHRAjHDPMy2IlpEqI8dSrxz?=
 =?us-ascii?Q?cQlxt2vN5Q4PU/p6ygDyACq0jucXZQlfw6tflwQwsOIt6CXTLtP6zd5zeSJW?=
 =?us-ascii?Q?BP4rz4wezpGjgQL+DghCWJafZFoY97uzHwBbhwVnNODk3tqlo9+WebPU20CE?=
 =?us-ascii?Q?ns5tmgiHXk9j/+qW+GN8dIilQKiLemuKVsxCkHzEot6dsv1oDjWnf8v1PTKV?=
 =?us-ascii?Q?Clp4Khgcv0hSlRHibJf4XIoP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8f8441-bdf0-44a8-099f-08d9791511e8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 13:22:45.4485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qPp4P9fI0ELh1gutuw5yUT3y280UmobHWge9qHyecjSU/HM3aVb59zkKUnCDVEX6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5523
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 16, 2021 at 09:16:35AM +0000, yangx.jy@fujitsu.com wrote:
> On 2021/9/15 2:32, Jason Gunthorpe wrote:
> > On Thu, Sep 02, 2021 at 04:46:36PM +0800, Xiao Yang wrote:
> >> 1) post_one_send() always processes kernel's send queue.
> >> 2) rxe_poll_cq() always processes kernel's completion queue.
> >>
> >> Fixes: 5bcf5a59c41e ("RDMA/rxe: Protext kernel index from user space")
> >> Signed-off-by: Xiao Yang<yangx.jy@fujitsu.com>
> >>   drivers/infiniband/sw/rxe/rxe_verbs.c | 29 ++++++---------------------
> >>   1 file changed, 6 insertions(+), 23 deletions(-)
> >>
> >> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> >> index c223959ac174..cdded9f64910 100644
> >> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> >> @@ -632,7 +632,6 @@ static int post_one_send(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
> >>   	struct rxe_sq *sq =&qp->sq;
> >>   	struct rxe_send_wqe *send_wqe;
> >>   	unsigned long flags;
> >> -	int full;
> >>
> >>   	err = validate_send_wr(qp, ibwr, mask, length);
> >>   	if (err)
> >> @@ -640,27 +639,16 @@ static int post_one_send(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
> >>
> >>   	spin_lock_irqsave(&qp->sq.sq_lock, flags);
> >>
> >> -	if (qp->is_user)
> >> -		full = queue_full(sq->queue, QUEUE_TYPE_FROM_USER);
> >> -	else
> >> -		full = queue_full(sq->queue, QUEUE_TYPE_KERNEL);
> >> -
> >> -	if (unlikely(full)) {
> >> +	if (unlikely(queue_full(sq->queue, QUEUE_TYPE_KERNEL))) {
> >>   		spin_unlock_irqrestore(&qp->sq.sq_lock, flags);
> >>   		return -ENOMEM;
> >>   	}
> >>
> >> -	if (qp->is_user)
> >> -		send_wqe = producer_addr(sq->queue, QUEUE_TYPE_FROM_USER);
> >> -	else
> >> -		send_wqe = producer_addr(sq->queue, QUEUE_TYPE_KERNEL);
> >> +	send_wqe = producer_addr(sq->queue, QUEUE_TYPE_KERNEL);
> >>
> >>   	init_send_wqe(qp, ibwr, mask, length, send_wqe);
> >>
> >> -	if (qp->is_user)
> >> -		advance_producer(sq->queue, QUEUE_TYPE_FROM_USER);
> >> -	else
> >> -		advance_producer(sq->queue, QUEUE_TYPE_KERNEL);
> >> +	advance_producer(sq->queue, QUEUE_TYPE_KERNEL);
> >>
> >>   	spin_unlock_irqrestore(&qp->sq.sq_lock, flags);
> > This bit looks OK
> >
> >> @@ -852,18 +840,13 @@ static int rxe_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc)
> >>
> >>   	spin_lock_irqsave(&cq->cq_lock, flags);
> >>   	for (i = 0; i<  num_entries; i++) {
> >> -		if (cq->is_user)
> >> -			cqe = queue_head(cq->queue, QUEUE_TYPE_TO_USER);
> >> -		else
> >> -			cqe = queue_head(cq->queue, QUEUE_TYPE_KERNEL);
> >> +		cqe = queue_head(cq->queue, QUEUE_TYPE_KERNEL);
> >>   		if (!cqe)
> >>   			break;
> >>
> >>   		memcpy(wc++,&cqe->ibwc, sizeof(*wc));
> >> -		if (cq->is_user)
> >> -			advance_consumer(cq->queue, QUEUE_TYPE_TO_USER);
> >> -		else
> >> -			advance_consumer(cq->queue, QUEUE_TYPE_KERNEL);
> >> +
> >> +		advance_consumer(cq->queue, QUEUE_TYPE_KERNEL);
> >>   	}
> > But why is this OK?
> >
> > It is used here:
> >
> > 	.poll_cq = rxe_poll_cq,
> >
> > Which is part of:
> >
> > static int ib_uverbs_poll_cq(struct uverbs_attr_bundle *attrs)
> > [..]
> >
> > 		ret = ib_poll_cq(cq, 1,&wc);
> >
> > That is used called?
> Hi Jason,
> 
> ib_uverbs_poll_cq() is called by ibv_cmd_poll_cq() in userspace but rxe 
> uses its own rxe_poll_cq() instead.
> See the following code in rdma-core:

Yes, but rdma-core doesn't matter.

The question is why is this safe and the reason is rxe doesn't set
IB_USER_VERBS_CMD_POLL_CQ in uverbs_cmd_mask.

I'd be a bit happier seeing this fixed so we have a poll_kernel_cq
poll_user_cq op and this isn't so tricky.

Jason
