Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F091E12E9
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 18:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388570AbgEYQrV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 12:47:21 -0400
Received: from mail-eopbgr70080.outbound.protection.outlook.com ([40.107.7.80]:22784
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387766AbgEYQrV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 May 2020 12:47:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgwzSOsZfc7zMU5S61jV++9hDnKcji+pUB4nlgRFhbh1IwYfzD3y6vUzZOoCOCWsK8lMTQlr78AvtVCpbkaleynZxGdTF9Xq3wMUGuNwdQRvAkWP7OemAc07oB3jYy/rdyPqk2yzL4d16jl9DIJT0ZNZbjdShLB9yfGx2qvsLFPaiyvjaAhFJ1ygc1fzts56oHuREbRa6QdmrDNpa2n5ST6PMI8Qse4k9fJDPU2btkFArXRlQR2RXNx/SbFJ/RtgtbI+J5Xy0Yss9rRR66SLj/Z16k9CpyRXo/an+L5gisTgy1BR7SMwi0ATdLEY5V6xB8AdgfEd24zuSMhPrEnbfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VA2HPWUtusUcznuFOBFxcYQ0wfYvewlDMmHKKjpYE5c=;
 b=mD/sTSaaUDNwPzafDoJqMRR/L54u5p7KxT9Fln2OcZ+zR6N7b72IMeauoCIYodc/BxxbzajKzxjsWYIs9gLzLKH4RL/iWc2iASAo3X6LcbXrv/HWghwwxSUlhOQ9CrZ0UJeFdDTumm6wuQKJBgcLqznT7A27606hYfem6hKXT6bEKHr/yCtuaGxOe9ZuAarfv/eFRiescqlMRDgyCYE2K4JuhLFP9t55smsXBuykYvh0B4/SNw59WVB+kqkCJ0j5/GCUMnCekWZGprxTN/n4A9Q8gTC/R9DXscZldkatjEyGPbWc3rCTVilTK0EcSA0H+gOkJ+zyqwOmq+ybGchY0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VA2HPWUtusUcznuFOBFxcYQ0wfYvewlDMmHKKjpYE5c=;
 b=fHnTZy4L2t6hS/XiwElyFAzinXQg3IUAYdGvnkY4MoozCr/PYer2RkAlP9XCtH98WzQ1O8UZ/jpWiFLcf69u+j8lexEzuolTSM9yDoVwrmsoY6xSjsGi0x10tUJdk/9GxLusEdj/bKEwfN6NLRtZuuHu2VBosnoYldbtvZTRqJE=
Authentication-Results: ziepe.ca; dkim=none (message not signed)
 header.d=none;ziepe.ca; dmarc=none action=none header.from=mellanox.com;
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (2603:10a6:20b:b8::23)
 by AM6PR05MB5176.eurprd05.prod.outlook.com (2603:10a6:20b:63::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Mon, 25 May
 2020 16:47:17 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::1466:c39b:c016:3301]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::1466:c39b:c016:3301%4]) with mapi id 15.20.3021.029; Mon, 25 May 2020
 16:47:17 +0000
Date:   Mon, 25 May 2020 19:47:13 +0300
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Yamin Friedman <yaminf@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Or Gerlitz <ogerlitz@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH V3 2/4] RDMA/core: Introduce shared CQ pool API
Message-ID: <20200525164713.GF10591@unreal>
References: <1589892216-39283-1-git-send-email-yaminf@mellanox.com>
 <1589892216-39283-3-git-send-email-yaminf@mellanox.com>
 <20200525164215.GA3226@ziepe.ca>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525164215.GA3226@ziepe.ca>
X-ClientProxiedBy: AM0P190CA0021.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::31) To AM6PR05MB6408.eurprd05.prod.outlook.com
 (2603:10a6:20b:b8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2a00:a040:183:2d::a43) by AM0P190CA0021.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24 via Frontend Transport; Mon, 25 May 2020 16:47:16 +0000
X-Originating-IP: [2a00:a040:183:2d::a43]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 346679e4-dcad-441e-a5f7-08d800cb487a
X-MS-TrafficTypeDiagnostic: AM6PR05MB5176:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR05MB5176EDF3E5ECB460FB4F3D23B0B30@AM6PR05MB5176.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 0414DF926F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mp7vDieGCMxUB2trOyL5t4OhJey4oi0y5ege0FGJHN8MDhf8TvyxvDikDVDRNF+3hVBpQmdcF/MreWoIaaLBYfznxChHeBUKjCirIoQD5EFL6NCZ5O/4io448OKECJCZXL7QWSm3G+SDS3BFpCijcUsbk3+vRMmyZIUxPCaFZX7Vc/9UR0PjX8kE9Tz8DRuHfiDkKUn/jeCd0u1+j957GGuZeUomr00IC0UU+ylsxXRY2GKuq3IRnb9YmXByExCoph2Ty7F4RDN1aSXBfGJ2rrPM5vwWk0ZtBCIJMtnaOu+ypGzVOpjVg9cMPC3RytgxPOUyY4q4ugLfRadqC9l6Eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6408.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(7916004)(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(6916009)(2906002)(9686003)(316002)(33716001)(4326008)(6666004)(16526019)(186003)(66946007)(66556008)(66476007)(33656002)(5660300002)(478600001)(54906003)(86362001)(1076003)(52116002)(8936002)(6496006)(8676002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: hTUTNEDq2CRrOqdpwvIJYTOJiOchOkZFagas5+Au9NCp241qk6YHuQrGjAaF0D0yyloENaR9dHlcCuywCXYykBeM8xbRwHnHtSuEqTBqs0rTJVMQfFzKrWoGePxRBC8+K2nAjrHz9pk4do+l2wAOmocYakVsJOEVh6CtV7rB6KJH2T0h934OnL3EkqfEXcJhqb0gIWJK8XsBNv55LH2d5zwIZBOOsHJJHP1+DTacEa8ENyR3unN6HdbralujxDZSHLHO/Kf+m2pY75d7cQ+jGN9ASPmSc0C1y8VSND31YjYY3jiv7nbvGkeZn8+YSQPlzXkI9Sd1oTTJSiVTLxukEUsamD7g6xXLwn7pMxv/xG4xkhmMUxyxXzKl75rkqpucYG/fnrh+lpYfs3tJg1dtpJiIXGT17SUQaszeMhlAcYx7XXjm3zdt6aM8KSaq19fXzDLAUo9yofrUH/2LsNBK6r9nr2yL4cABI/KNMZOBkS3lXkTRnBcForYnc6CUMvyDHinBLTaZP4DWDQMOIEyjrw==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 346679e4-dcad-441e-a5f7-08d800cb487a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2020 16:47:16.9582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tU0DjV+MdMHWtnR6ma8Fq3crZLUIpqbfgloBTxlUgp84IX/1YwFGDjWesKDHks+hLT7a8+CeAf97keFWtSRGbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5176
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 25, 2020 at 01:42:15PM -0300, Jason Gunthorpe wrote:
> On Tue, May 19, 2020 at 03:43:34PM +0300, Yamin Friedman wrote:
>
> > +void ib_cq_pool_init(struct ib_device *dev)
> > +{
> > +	int i;
>
> I generally rather see unsigned types used for unsigned values
>
> > +
> > +	spin_lock_init(&dev->cq_pools_lock);
> > +	for (i = 0; i < ARRAY_SIZE(dev->cq_pools); i++)
> > +		INIT_LIST_HEAD(&dev->cq_pools[i]);
> > +}
> > +
> > +void ib_cq_pool_destroy(struct ib_device *dev)
> > +{
> > +	struct ib_cq *cq, *n;
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(dev->cq_pools); i++) {
> > +		list_for_each_entry_safe(cq, n, &dev->cq_pools[i],
> > +					 pool_entry) {
> > +			cq->shared = false;
> > +			ib_free_cq_user(cq, NULL);
>
> WARN_ON cqe_used == 0?

An opposite is better - WARN_ON(cqe_used).

<...>

> > @@ -1418,6 +1418,7 @@ int ib_register_device(struct ib_device *device, const char *name)
> >  		device->ops.dealloc_driver = dealloc_fn;
> >  		return ret;
> >  	}
> > +	ib_cq_pool_init(device);
> >  	ib_device_put(device);
>
> This look like wrong placement, it should be done before enable_device
> as enable_device triggers ULPs t start using the device and they might
> start allocating using this API.
>
> >  	return 0;
> > @@ -1446,6 +1447,7 @@ static void __ib_unregister_device(struct ib_device *ib_dev)
> >  	if (!refcount_read(&ib_dev->refcount))
> >  		goto out;
> >
> > +	ib_cq_pool_destroy(ib_dev);
> >  	disable_device(ib_dev);
>
> similar issue, should be after disable_device as ULPs are still
> running here

Sorry, this were my mistakes. I suggested to Yamin to put it here.

Thanks
