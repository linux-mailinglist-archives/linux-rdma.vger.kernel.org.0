Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7D91A8442
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2020 18:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388768AbgDNQLz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Apr 2020 12:11:55 -0400
Received: from mail-am6eur05on2046.outbound.protection.outlook.com ([40.107.22.46]:3904
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388687AbgDNQLu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Apr 2020 12:11:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FE1dg7gcry+vQl+D3hNZuktyCKvmzyaOXxYDShHFQnXK32fITZa2+bAJ3/DHaP1znfFHQKtC8qy1irOIuNj4PGNzwUBkht/Vl5dO+J2MryyKhvaK5GepwMO9prGILvZw/c9I5qlBluNMxKUvgCm1pYLv8BXirPtENd51G+Pwe+Tw0g0xtejBVSYqsh0Zjd1EzXtqIIGjpEVIOz2oOaR9dVc8iuShjxgg7it/r7jFJd+6EGHCxXkGZRB6/rRndyWDEOLiP2G8izGvEVbIhc2J5QDwI/qiRmvz08bN+3mueoHeFRMIyuvTbAAPY0M3EEG3VYXUiCZZsxqsB7mUG5Tbmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SG5avyq6aYyHwzZ4yman1MA2R8lBPLgSjHRIKAo86zY=;
 b=nbiRbnb7lwmGCmptCGtoG3PuY/26q8IPmfGQ1LV/7uS3uTBp0nKcWHk0iC2Bd80FIsl3Ys9ncl+4do4Ng7XcThvPaM1ofDRcEFDTv+VcrIjaA83oTOTIgJlig9doC6RdU3+oaibJWdBKmRTX00DDqhf33TjGxdfKGUOmaTIvjOT48FSjfc4a308uJsBxSrMT9R/81F7PP2XZEbgLFQhOyf1w4c5Dixoyrpg7ZjEYbQonGhS1G86o151aKV92j3cG+3b1sPnmdyAtLOdvlc8uBX7ULTI0dr3UbOoci4hIdIzelu4j1rquD23DP/tJgi8R2bwTsY7W5uuGSzTjy5WMOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SG5avyq6aYyHwzZ4yman1MA2R8lBPLgSjHRIKAo86zY=;
 b=hfaI+75aJZF2RKsevex3q91XW4IjlS9zJ3SQsT6UHaBj2tolGYffOFe36Du/1+ccLfn3wsZ1byQsXeKcegOjdfF1rcMZIJJgoEfUNDIPasln+ZAMlhcPqO50QMyrSusNdhP/Xe8AYy2f3iWVVlHw4Nw7YNgCudQwjCqWlzKiTWg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB4270.eurprd05.prod.outlook.com (2603:10a6:803:40::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17; Tue, 14 Apr
 2020 16:11:46 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::a47b:e3cd:7d6d:5d4e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::a47b:e3cd:7d6d:5d4e%6]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 16:11:46 +0000
Date:   Tue, 14 Apr 2020 13:11:41 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        george kennedy <george.kennedy@oracle.com>
Subject: Re: [PATCH for-rc] RDMA/cma: fix race between addr_handler and
 resolve_route
Message-ID: <20200414161141.GL11945@mellanox.com>
References: <20200403185707.GE8514@mellanox.com>
 <1720C7BF-D6E4-4779-B05D-203703042B36@oracle.com>
 <20200403193656.GF8514@mellanox.com>
 <EDBCDCC1-E03F-428A-8352-734E3F01B316@oracle.com>
 <20200406173149.GH11616@mellanox.com>
 <09A6E613-AA59-4C5F-889A-EF45722B7F69@oracle.com>
 <20200406181032.GI11616@mellanox.com>
 <EAE5B24F-142B-478D-BBA5-BBF784AA9E39@oracle.com>
 <20200414125012.GK11945@mellanox.com>
 <BCFFD1E1-F013-4B09-9DC5-5A4EE205EA10@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BCFFD1E1-F013-4B09-9DC5-5A4EE205EA10@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:208:23a::12) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR03CA0007.namprd03.prod.outlook.com (2603:10b6:208:23a::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend Transport; Tue, 14 Apr 2020 16:11:45 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jOOA1-0005zB-QX; Tue, 14 Apr 2020 13:11:41 -0300
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0dda66cd-b141-4e2a-65f1-08d7e08e874e
X-MS-TrafficTypeDiagnostic: VI1PR05MB4270:
X-Microsoft-Antispam-PRVS: <VI1PR05MB42706BECBA01809AEA76F66DCFDA0@VI1PR05MB4270.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0373D94D15
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(4326008)(8676002)(2616005)(2906002)(66574012)(9746002)(9786002)(478600001)(8936002)(53546011)(52116002)(33656002)(1076003)(6916009)(54906003)(86362001)(316002)(81156014)(5660300002)(66476007)(66556008)(36756003)(66946007)(26005)(186003)(24400500001);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7OF3h1XZIJgMDctHXkrHzM/mTHyIA24hKu4IxnpU6DU7I/aTkPOoc7XMoTgXvJcF3uU4eE/GTf1AT2ps0xLlsPN/i+G0E5qBnhXtsevgceDofvbM67sgRVz2VccRtJeudhcYfwodMXou05SlLPJl5NQqE7FPL7NZ9HI1h2h+iEcxmQHAyyIjy4MeLRPyxT4H45lhem11b6i6EinvMXoJoe7/AMJsqDPC8jhlTFIpYr3gypDRPCkvsBZ+smntMsMHlEIcNAI4bibqYw+/91q5v6Svf8qHZQVi5ngIcz1OP6qmr6q8MbJPNrwenp7Ozdx77XQdQx3uWKiBcPrfJ5dNvYUjcr8k6KEsUEH3PYSpNIoO04zu+73VZDbQhacp/ozXd1S91chXVrfpDxLiiw3QiuviYItXYCvmTT+RQZFnk+O+ZkAtmuKPwuA+wvCELkHP5MUxkHisTRERfDKTBaKkQFTSCC6xO/7cA6v7muJv5lidJA9KrU++1f2kea9CtlzX
X-MS-Exchange-AntiSpam-MessageData: /Lcv/hLEP5PxWNys784Ra4Y/lDzyIPGUbd5tI+fDJV5LrtarXoh/UdL3w9PYnG4h9YC02SvmjGSOpnxdDiEZiRppBaN5tK6GyXEUknsnBOWZ+ftCA1vIE6+d8cGMw6Qq8ePlQcJgb0jju2geEJDN6A==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dda66cd-b141-4e2a-65f1-08d7e08e874e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2020 16:11:46.2990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sWNTlHxkMGR0S3pS6HMWyCWe8ixJsFZRNc9bICFLpyG2TfStcTqK749FRhhZekM/Y/BZ5DiOvdKPbWwtzMxmgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4270
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 14, 2020 at 03:57:20PM +0200, Håkon Bugge wrote:
> 
> 
> > On 14 Apr 2020, at 14:50, Jason Gunthorpe <jgg@mellanox.com> wrote:
> > 
> > On Tue, Apr 14, 2020 at 12:34:35PM +0200, Håkon Bugge wrote:
> > 
> >>>>>> Shall I make a v2 base on next based on this idea, or do you have
> >>>>>> something coming?
> >>>>> 
> >>>>> Sure, I have nothing :)
> >>>>> 
> >>>>> Also that rdma_destroy_id in addr_handler looks wrong.. ie we still
> >>>>> retain pointers to the rdma_cm_id it destroys inside the struct
> >>>>> ucma_context, don't we?
> >>>> 
> >>>> On entry from user-space, we use the u32 id and looks it up in the
> >>>> XArray. But if rdma_destoy_id() is called asynchronously called
> >>>> between ucma_get_ctx_dev() and the de-reference of ctx->cm_id, we
> >>>> are toast.
> >>> 
> >>> Is that what happens on the addr_handler path?
> >> 
> >> No, there, the main problem is the revert of the state
> >> transitions. The first transition enables rdma_resolve_route() to
> >> pass its gate (i.e. state == ADDR_RESOLVED). Then it thinks the
> >> address is resolved, but the addr_handler changes its mind
> >> afterwards.
> > 
> > That is a problem, but the call to rdma_destroy_id looks like another
> > problem
> 
> I am not sure. Almost all events/incoming packets, can, after the
> cm_id's event_handler is called from cma_ib_handler(), call
> rdma_destroy_id(). 

I think the trick is that ucma_event_handler never returns failure
unless RDMA_CM_EVENT_CONNECT_REQUEST, which means the cm_id isn't in
the xarray yet?

> I assume the refcounting takes care of this.

There is no refcounting for destroy, it must be called once.

Jason
