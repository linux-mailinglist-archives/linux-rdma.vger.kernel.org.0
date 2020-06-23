Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E553205B21
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2020 20:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733138AbgFWStw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jun 2020 14:49:52 -0400
Received: from mail-vi1eur05on2084.outbound.protection.outlook.com ([40.107.21.84]:6260
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733075AbgFWStv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jun 2020 14:49:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDSteh4MJrNJkI4Z7JKNnh7L5ObwViGOoNEo81R7c81kxolyoVzlDlDxJUE2CZUbpcLCT2YBe5O7bvlRTEFmecZsXeqUmq8A7Hptw7G5q9G+f0IqnPoV9TnlxMKXA64vD1goN27dFMIki43RlY+t/iRSqFb7VyYURWovWpqQnCtazdC7vUQzWXpou8VbWOWYe+oa107a3zfhst46cbtLVdqaQ4Um065RvqHhD+Cy6yFmU3YqplxHCqKDQFsNjCQinSUhXeNkSwrXaQQ+5f6g4rQ2/u+M2wl/qVCiQAvYmwsP6IjmpDKlvPDCMQCEUqAWHzKiGzjS9vSi4pxsurO5wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxuGISHKswOhjilP5M4o30ffV2/Safu6DesiWiP6YjU=;
 b=G1wN7kqHz13KhkrZAjDUVXtlZq8L84tgIEaOOQ34Z9nPuq8uhEzdEyOjfqHa/POR+8W0K6ay1UFiQZFqcn0MMnL1eSr9poYPSdODncw4dlMQuy5vYds/RT3DptkdefLXcuVInVAkRHh0F2eO6im5TtUMh4wcJ4FQ5zIUXZ6NQWiAk3sFXpwruxv4rb9MVGVYxV+U4+fUaQsFDnjAZ9579qWrgiBGdal5Ic159gIV1FFtXD6WYtgIDcYHFfUDVeeK7px8xkUi7nvQOZgqacfAUeM9BQZZ8ROVAu86D5FgW8S1Y21CRqqi9uWnL4Cs8UzRBsewgmvqDHMkneP+SX489g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxuGISHKswOhjilP5M4o30ffV2/Safu6DesiWiP6YjU=;
 b=FoDaLLnFaWfraAWKzwCmRzV+tJeM/bzw2Qf5EUX6hss2Slerz6DEA6udmYorBlwMG67gjhuZ+OvCqi9KicYN3iybnWQnKSHQ7yqoArt9hbh6jiDtWgguSfpxI43gv0piMqs/hGHW6qOSUj5kHmiSf1C3AwM3bYMW+6cypC+rSRc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB6925.eurprd05.prod.outlook.com (2603:10a6:800:188::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Tue, 23 Jun
 2020 18:49:48 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e%7]) with mapi id 15.20.3131.020; Tue, 23 Jun 2020
 18:49:48 +0000
Date:   Tue, 23 Jun 2020 15:49:40 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 2/2] RDMA/core: Optimize XRC target lookup
Message-ID: <20200623184940.GN2874652@mellanox.com>
References: <20200623111531.1227013-1-leon@kernel.org>
 <20200623111531.1227013-3-leon@kernel.org>
 <20200623175200.GA3096958@mellanox.com>
 <20200623181506.GC184720@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623181506.GC184720@unreal>
X-ClientProxiedBy: BL0PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:208:2d::29) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (193.47.165.251) by BL0PR03CA0016.namprd03.prod.outlook.com (2603:10b6:208:2d::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Tue, 23 Jun 2020 18:49:47 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@mellanox.com>)      id 1jnnzI-00D0rv-Cv; Tue, 23 Jun 2020 15:49:40 -0300
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7bc978a6-741a-42a7-eaed-08d817a63416
X-MS-TrafficTypeDiagnostic: VI1PR05MB6925:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB692500B027BE3DE95DA7C0BBCF940@VI1PR05MB6925.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 04433051BF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xGOd4jx0XlWfBINn+uHZYsyU6SK0NkRbVlMdbQLh3wcwBtEfD3ecldgchMdGjfcEnXMBRHSOKZ4G6btz13ObH7aCQEbJLYSi/N9eelS+j6b1UP7rWDt/SOAyFoTjDU5xrwl8GYhSaoVMwkv42X9Fvam20nZKEAR9fi2EZxnVNbRxScG4GwhV9UxzZIwmGpM8mtNMsYK1ITTzCJCi+tQeMPFP73RoSudOi0TOBLY9qnWiM/1VVAhuWXW51jqNZZbdXIeJJU9vwG5YxD6T7sHSJ2me7R9ow+ca04TqVbGEBmDKJyQ+irm1VNfw5Ci8UCDEsDBy3R5dwyMKerIBWe3vUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39850400004)(346002)(366004)(136003)(376002)(54906003)(36756003)(9746002)(2906002)(83380400001)(186003)(9786002)(8936002)(2616005)(26005)(6916009)(33656002)(8676002)(426003)(4326008)(5660300002)(66556008)(1076003)(478600001)(316002)(66476007)(86362001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 3OSNacqpksoQvBXLo0B0gUaVYV+eCGPkcl8AbJI6QreyCm3Mk9BgYM1VC+SX5TRbvfMxeW3lrhOmpoqe5AKfuLw4xof1BfYhPnrKarsvLYyhsvA3Q10qWeXo3kHrOvRIhs7WAixJtp3hFxNB2pZgQ8x38pjT8A9Nc1/ZnyamMOZnZaPJ0JioIzKkfhn1KvyCUryEED05dzPYrf1e1leOkGPhp9KVwPl9wkynDNq6854Ypy0oUxL2IMhuQGw5kS0iICzJ9hkCFIYbUS1Oa5OTRdiJV02YTob9yy/Ty/rmhBL3Wn4C0VqtErPrIkIJpGNVp+yP8rQE7JjyCg/nx36iulrScckDG3bZSuNNoQNvGASj0rEk8L+8JQLpa5U8fT6pNsioEs2dtw8vfjCGwIE8rTIzrnqOekdZOi5KcM4vC2phpeQp+Jms9tnoQyau+FHadsurFia44M55wf/r6Pan/xyoUWZpnvUYXF4hTOYTgElsknCa7oqs5EhZk2macJPh
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc978a6-741a-42a7-eaed-08d817a63416
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2020 18:49:48.5428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tKdkBvjWuXEFsCaBIdjZp2tVpIprv94tILr6xtFhrGIlKuxqFLzNcVRrY/An+DqIkSua8VBNXbQ/1bWMVZin8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6925
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 23, 2020 at 09:15:06PM +0300, Leon Romanovsky wrote:
> On Tue, Jun 23, 2020 at 02:52:00PM -0300, Jason Gunthorpe wrote:
> > On Tue, Jun 23, 2020 at 02:15:31PM +0300, Leon Romanovsky wrote:
> > > From: Maor Gottlieb <maorg@mellanox.com>
> > >
> > > Replace the mutex with read write semaphore and use xarray instead
> > > of linked list for XRC target QPs. This will give faster XRC target
> > > lookup. In addition, when QP is closed, don't insert it back to the
> > > xarray if the destroy command failed.
> > >
> > > Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > >  drivers/infiniband/core/verbs.c | 57 ++++++++++++---------------------
> > >  include/rdma/ib_verbs.h         |  5 ++-
> > >  2 files changed, 23 insertions(+), 39 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> > > index d66a0ad62077..1ccbe43e33cd 100644
> > > +++ b/drivers/infiniband/core/verbs.c
> > > @@ -1090,13 +1090,6 @@ static void __ib_shared_qp_event_handler(struct ib_event *event, void *context)
> > >  	spin_unlock_irqrestore(&qp->device->qp_open_list_lock, flags);
> > >  }
> > >
> > > -static void __ib_insert_xrcd_qp(struct ib_xrcd *xrcd, struct ib_qp *qp)
> > > -{
> > > -	mutex_lock(&xrcd->tgt_qp_mutex);
> > > -	list_add(&qp->xrcd_list, &xrcd->tgt_qp_list);
> > > -	mutex_unlock(&xrcd->tgt_qp_mutex);
> > > -}
> > > -
> > >  static struct ib_qp *__ib_open_qp(struct ib_qp *real_qp,
> > >  				  void (*event_handler)(struct ib_event *, void *),
> > >  				  void *qp_context)
> > > @@ -1139,16 +1132,15 @@ struct ib_qp *ib_open_qp(struct ib_xrcd *xrcd,
> > >  	if (qp_open_attr->qp_type != IB_QPT_XRC_TGT)
> > >  		return ERR_PTR(-EINVAL);
> > >
> > > -	qp = ERR_PTR(-EINVAL);
> > > -	mutex_lock(&xrcd->tgt_qp_mutex);
> > > -	list_for_each_entry(real_qp, &xrcd->tgt_qp_list, xrcd_list) {
> > > -		if (real_qp->qp_num == qp_open_attr->qp_num) {
> > > -			qp = __ib_open_qp(real_qp, qp_open_attr->event_handler,
> > > -					  qp_open_attr->qp_context);
> > > -			break;
> > > -		}
> > > +	down_read(&xrcd->tgt_qps_rwsem);
> > > +	real_qp = xa_load(&xrcd->tgt_qps, qp_open_attr->qp_num);
> > > +	if (!real_qp) {
> >
> > Don't we already have a xarray indexed against qp_num in res_track?
> > Can we use it somehow?
> 
> We don't have restrack for XRC, we will need somehow manage QP-to-XRC
> connection there.

It is not xrc, this is just looking up a qp and checking if it is part
of the xrcd

Jason
