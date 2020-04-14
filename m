Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9CAE1A7B48
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2020 14:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbgDNMuU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Apr 2020 08:50:20 -0400
Received: from mail-eopbgr40069.outbound.protection.outlook.com ([40.107.4.69]:6467
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730138AbgDNMuT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Apr 2020 08:50:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTN73CdjRoRB2i5o3DMPQmoG7Wze56oXq98yrsMuGQJqOJzYD32aObfm1KhwnW0FYKugIwuH70uiNkPd0n4tVw9Vj0wODzai1ZRxseXVWsd6w+I6qCgcAES7dkIB5/LvL0Afv5zHHJYSfcSTjcm7Pq8eAFpTsFDMAkmsralb/xMOMlO6xk+5NldpPnqvcpBgo7m4Jcz4/ZkwWImHZuRl3hqJChQ+Fv2RiyFUMXYNXWdGEKuUsm6dzRouRyMs3CIY2hL3duAAyAVMRPrKRx8VBpsuR5RpSVDV9FRLDmzBVIoL6Hm2eZvRPr+yrdO9LM0zaeEXDYAIhf2ZRKn4yGT3SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KaUWkPaI5Xrm8LTmMCdtmZarnK+/ojbjOUSWjPWMG4o=;
 b=Uo1za7DcORnl2VJXY2vooTExLVMc4B+akqNSg1VhenAbAMVaGf55x4kuc5Iw7JB5h4AtzkfJ5q2MGjACdG/Xa+5XOuaPRLrtaH7er2Ld1Fiiz5yR+s4ab3cSV2wNK1rBb2tCJgJzwrEi7juXt9JWnxmr6lHVr9i5RY6+sLsasqDfhYJD3oRqluvrusjc/KtUarfqS2jrajiaXRP/9TpIl97NLXJTZChk3twG8NinAEsJ+VahnZU7obihvxC2YqPDc6GQPNGPYl2UeTh/bAcmmV2d4FCGQSvnxT5KwfYwMreWL22YaktFDrSzc5kIcoLc1wDPfub8Hbil38Ql6vyOuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KaUWkPaI5Xrm8LTmMCdtmZarnK+/ojbjOUSWjPWMG4o=;
 b=e/afB3JEj0MemcrJMVkIXwsDnN9Xs9B0YQJoP76PKLYAeJnM6+VQHGg3/Zq9O7UA3W+n6aCMMOi8fR8sYhSViCkoXE7sMT/2jXes2Wm7Jy0v1SkanoLEuN4P6JWSWGwKSlXNCRQur61Rgvl4OcK8ZNytTOryomBjfdkSGSx/zGE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB5359.eurprd05.prod.outlook.com (2603:10a6:803:b1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17; Tue, 14 Apr
 2020 12:50:15 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::a47b:e3cd:7d6d:5d4e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::a47b:e3cd:7d6d:5d4e%6]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 12:50:15 +0000
Date:   Tue, 14 Apr 2020 09:50:12 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        george kennedy <george.kennedy@oracle.com>
Subject: Re: [PATCH for-rc] RDMA/cma: fix race between addr_handler and
 resolve_route
Message-ID: <20200414125012.GK11945@mellanox.com>
References: <20200403184328.1154929-1-haakon.bugge@oracle.com>
 <20200403185707.GE8514@mellanox.com>
 <1720C7BF-D6E4-4779-B05D-203703042B36@oracle.com>
 <20200403193656.GF8514@mellanox.com>
 <EDBCDCC1-E03F-428A-8352-734E3F01B316@oracle.com>
 <20200406173149.GH11616@mellanox.com>
 <09A6E613-AA59-4C5F-889A-EF45722B7F69@oracle.com>
 <20200406181032.GI11616@mellanox.com>
 <EAE5B24F-142B-478D-BBA5-BBF784AA9E39@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <EAE5B24F-142B-478D-BBA5-BBF784AA9E39@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: BL0PR0102CA0030.prod.exchangelabs.com
 (2603:10b6:207:18::43) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by BL0PR0102CA0030.prod.exchangelabs.com (2603:10b6:207:18::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17 via Frontend Transport; Tue, 14 Apr 2020 12:50:15 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jOL12-00045O-5f; Tue, 14 Apr 2020 09:50:12 -0300
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 500b2187-d924-4360-f311-08d7e072610f
X-MS-TrafficTypeDiagnostic: VI1PR05MB5359:
X-Microsoft-Antispam-PRVS: <VI1PR05MB53592734521086E47F0634D7CFDA0@VI1PR05MB5359.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0373D94D15
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(396003)(39850400004)(376002)(366004)(136003)(316002)(66556008)(86362001)(66476007)(33656002)(2906002)(5660300002)(66946007)(52116002)(186003)(54906003)(1076003)(26005)(478600001)(81156014)(6916009)(2616005)(9786002)(9746002)(36756003)(8676002)(8936002)(4326008)(24400500001);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C470WdGcwLzhcmzvG2SSYfY5HVPGuy8+cMxfpMHBDzANx9JBKpvAVEcXojvhH3CpY+NGibLgs+rDlwLxQug8GjkPlGgzz+M6BErubkw/N6ZxF+PlBIVhuz873gwDrV/KpeTzXm4UQPxcI0gx6y8Qtt8X/PQXWWNKHludRUHqRGrl4kFocrVkTEvjvaTX/0VYa69zKWahG5BVG6ajhT1TTPuffehn9AhFzWcgTzNhZukq4upsAeUODJEoT9OHLzTjvax8n1VJDZIe7r3jaiTCWKFUWwW78UrsFkt3cHPl+N7Kcnz0KtWNm9GjHUfAGdOcLiqaLAfDKVYDp5yjDWpEnwyZEHwONkPby4NJNABGQNOKAhELw1/Gb8X+QoA6v+Lb2mCbNdu6EWwxiG0MLor9G7jjD+CMJ8SmVl4B0paqOgvsGSn4KLOWrBr81eY789C56+RsaPhU89vy5lSh26uEWTCE0PhaSgKHZRZVKHzFidfMbAE60zMqWAhAtJrUGIl/
X-MS-Exchange-AntiSpam-MessageData: QH9s/LBc5Nra4IzSrdJsaMkt5dMeB+yiyZlUV2bVS6voo0HOq2bVuS5hqvtShtUxZIxp+VJ/pf47677ahTrFuS3ynuUr9Gekqk463UH0ygbTfPDYbwkUGx0jitlFq+WFkm/191pVjPIO/NSv0z5MYg==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 500b2187-d924-4360-f311-08d7e072610f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2020 12:50:15.6992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BB/tvSxAsfhvWITnRBJPCc8hvB8NBDkv525wju8MXVzaoIT5GgUUFc142JTM8KiBdpn4shh+b9TKYuwsp+NEbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5359
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 14, 2020 at 12:34:35PM +0200, Håkon Bugge wrote:

> >>>> Shall I make a v2 base on next based on this idea, or do you have
> >>>> something coming?
> >>> 
> >>> Sure, I have nothing :)
> >>> 
> >>> Also that rdma_destroy_id in addr_handler looks wrong.. ie we still
> >>> retain pointers to the rdma_cm_id it destroys inside the struct
> >>> ucma_context, don't we?
> >> 
> >> On entry from user-space, we use the u32 id and looks it up in the
> >> XArray. But if rdma_destoy_id() is called asynchronously called
> >> between ucma_get_ctx_dev() and the de-reference of ctx->cm_id, we
> >> are toast.
> > 
> > Is that what happens on the addr_handler path?
> 
> No, there, the main problem is the revert of the state
> transitions. The first transition enables rdma_resolve_route() to
> pass its gate (i.e. state == ADDR_RESOLVED). Then it thinks the
> address is resolved, but the addr_handler changes its mind
> afterwards.

That is a problem, but the call to rdma_destroy_id looks like another
problem

Jason
