Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C13411E5228
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2020 02:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725294AbgE1AQi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 May 2020 20:16:38 -0400
Received: from mail-eopbgr80058.outbound.protection.outlook.com ([40.107.8.58]:54887
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725267AbgE1AQi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 27 May 2020 20:16:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Frd4klrSaczqXLoFilOfpRPkJeCvGYqiGKz0Nd/TV0rvz6Mw8J+BYie+A5jzMrxU/80UM/LN1hTifmK9WrBgHVzXXn5f3bb0fcKfKfXUjGdOWSNqtmd48bRa0cxS37yFRmMBL5bf8Dd6gGVekGoI1W4gSDZl7Qw5R14MueTxbvNKYKk2UbYycq8L9hMoY2q/rRgnmafJe0PCJJPN8Gcsn9JL35Eodqwk1vURqdIW61UvQOUo96HzX+U0HsOV1abR5S9IBsSHEBfA9eSrG9A4xmP3ZtsNxzcyCgj+CmSScrHxg3Uzzx440JogPki+/FLuNtleVSylAHDg+de22vgWVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPCaXdNBqCXzTqjPfIbkDDXL7EHfQW0reqRomh7bQeA=;
 b=J8oQEKSfJ29jTXiADfwhKmnGq5Yu7DpEpZt5Aj0Sc/6lBxqZyZrPp6fqY36C2FZI0GSw93lpDhOw1jpcOEl1fzFafMvYezEYPaensdoi9OyEX9C+0fTUAdYmJDSXCQdHp4fnUAXdaWyIDYghqeCKZZZ5qfc4hu0playcluWGxz0/oe+ocFhfoKgF/wf+OEhs1kwOkGlyLtSC/FpGasp7NuQls3e5Zm47Dzb1QokyPMR0HXQTStlbKQHHSpQWwdzFHNTB6ERxf4gB0E2AvmY3AuMzOS8imcpz6SYcC1jDet6W51RHv/0ZikrxDsocf6druUI6AeXCuhaCHweNUx9g8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPCaXdNBqCXzTqjPfIbkDDXL7EHfQW0reqRomh7bQeA=;
 b=TZpG0E3mA0qDgF2dsGvmfBQGORcuYTuMInNYVTlUOuMiDxkgSYW7u75Gd4nOOCaIEaGwI6dSbvczTBMWNmf2hCWjQD811nQGjFBOfISVM0Y7FLRONdh2PNz9+NUTSjO+JWNedjoZiWRXiyCYHkwRCoxtSISa6Uu4JN8hT3828AE=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=mellanox.com;
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB7054.eurprd05.prod.outlook.com (2603:10a6:800:181::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Thu, 28 May
 2020 00:16:34 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::848b:fcd0:efe3:189e%7]) with mapi id 15.20.3021.030; Thu, 28 May 2020
 00:16:34 +0000
Date:   Wed, 27 May 2020 21:16:23 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Valentine Fatiev <valentinef@mellanox.com>,
        Alaa Hleihel <alaa@mellanox.com>,
        Alex Vesker <valex@mellanox.com>,
        Erez Shitrit <erezsh@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1] IB/ipoib: Fix double free of skb in case of
 multicast traffic in CM mode
Message-ID: <20200528001623.GC24561@mellanox.com>
References: <20200527134705.480068-1-leon@kernel.org>
 <9cd656241bf31f454a72731de7509a7244353193.camel@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cd656241bf31f454a72731de7509a7244353193.camel@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend Transport; Thu, 28 May 2020 00:16:33 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1je6Df-0004RY-JX; Wed, 27 May 2020 21:16:23 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 96181072-991b-4c30-e589-08d8029c6111
X-MS-TrafficTypeDiagnostic: VI1PR05MB7054:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB70544AE287FB3371FED880BECF8E0@VI1PR05MB7054.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J9fRx6cZsRlzv+A0KaZkWAnnUlTvDVv21OmFcW2OY8kDiAz0thk2HtOoky8KkyYIs5CeDyM+NqxKOZpxyfFsO76Wo9oIgIEvQZCyiu9JS5MLmRJLGhoW4SZEzVtoBvPulS5rNYnNACFqx6z6q2nYlUkH0F/EsSg1qh7jDmv6GqX1FcIzhQSMng+7BfmB47M+8L3KN1hgUO15dO2MWV9olpWwNn5rfLDUaOxQwjhVEIEgsSwEsVFk8twGqbC05Z3Cdhr73s1URAHwBKp7pM8XcRq91ILdS/SSzLqa85qAYoMWIrAiGM7Q5/jNN8QDxT6YDI4Q8+qm2kuhWT+kA01E/PyTI0jQryM7WA+0vR7YMY13NcPhQbim6srLd5SSViQ/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(66476007)(478600001)(9746002)(86362001)(186003)(8676002)(26005)(2906002)(9786002)(2616005)(316002)(4326008)(54906003)(33656002)(36756003)(66556008)(1076003)(66946007)(83380400001)(8936002)(5660300002)(6916009)(24400500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: zkQdqPqTEUcTaW4nHTvGcs0F+LO7Yb1q4VNjjkVUdEbII5WMCq8qV9m0jkZB2GOJZOakYtYvBnrdAbcFni0B4hENp67BrjKUTrFH5vTDU65KM7Pz5qG+sdhnxrs3d4RkbtQWKUylqnG1Bbu1oyXeqZUzmezEeGPbWSTqMq2t6xI+x+Hanykvhv0B3+RaL9IN3qAYUFBPTsPwRRvyzQ5gRzyI+V7mUipbghI5joIOX7D+lESGsVG1YqLLt4c7n6OHoxKon6VXKYnHuoAh+NQ5/O8zvQoH3+Urfwr03wsVl8bfL4950gqTDEjKI6rP5CYDyB7EwnCe3PpBIirhieBZat+wUKto8SkDiXsYwWDzM/6stFzYsGCCNZZQLRBae3LhcVRpEaGqZXragO0Rf6Hsd3ilRzL26kivb9C9jeHz4DRsJE5tp8CfaMgWYq6o0CGRdNiaEAw7nsZR+2vM09cCvGxxVU8LdWG9rR17v2UDsZtDJGgUVO/6Q/Yr5A/Sq0PK
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96181072-991b-4c30-e589-08d8029c6111
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 00:16:34.3379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6b+YFcG4APzt5Pmwa+Xfwpa3HnPX3+guhEjgA46UylTP5+8lg4/WU5UCKJZUdTs0HvGjHCSAVdMwqHFA2rSsLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB7054
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 27, 2020 at 04:32:45PM -0400, Doug Ledford wrote:
> On Wed, 2020-05-27 at 16:47 +0300, Leon Romanovsky wrote:
> > From: Valentine Fatiev <valentinef@mellanox.com>
> > 
> > While connected mode set and we have connected and datagram traffic
> > in parallel it might end with double free of datagram skb.
> > 
> > Current mechanism assumes that the order in the completion queue is
> > the
> > same as the order of sent packets for all QPs. Order is kept only for
> > specific QP, in case of mixed UD and CM traffic we have few QPs(one UD
> > and few CM's) in parallel.
> > 
> > The problem:
> > 
> > Transmit queue:
> > UD skb pointer kept in queue itself, CM skb kept in spearate queue and
> > uses transmit queue as a placeholder to count the number of total
> > transmitted packets.
> > 
> > 0   1   2   3   4  5  6  7  8   9  10  11 12 13 .........127
> > NL ud1 UD2 CM1 ud3 cm2 cm3 ud4 cm4 ud5 NL NL NL ...........
> >     ^                                  ^
> >    tail                               head
> > 
> > Completion queue (problematic scenario) - the order not the same as in
> > the transmit queue:
> > 
> >   1  2  3  4  5  6  7  8  9
> >  ud1 CM1 UD2 ud3 cm2 cm3 ud4 cm4 ud5
> > 
> > 1. CM1 'wc' processing
> >    - skb freed in cm separate ring.
> >    - tx_tail of transmit queue increased although UD2 is not freed.
> >      Now driver assumes UD2 index is already freed and it could be
> > used for
> >      new transmitted skb.
> > 
> > 0   1   2   3   4  5  6  7  8   9  10  11 12 13 .........127
> > NL NL  UD2 CM1 ud3 cm2 cm3 ud4 cm4 ud5 NL NL NL ...........
> >         ^   ^                       ^
> >       (Bad)tail                    head
> > (Bad - Could be used for new SKB)
> > 
> > In this case (due to heavy load) UD2 skb pointer could be replaced by
> > new transmitted packet UD_NEW, as the driver assumes its free.
> > At this point we will have to process two 'wc' with same index but we
> > have only one pointer to free.
> > During second attempt to free the same skb we will have NULL pointer
> > exception.
> > 
> > 2. UD2 'wc' processing
> >    - skb freed according the index we got from 'wc', but it was
> > already
> >      overwritten by mistake. So actually the skb that was released is
> > the
> >      skb of the new transmitted packet and not the original one.
> > 
> > 3. UD_NEW 'wc' processing
> >    - attempt to free already freed skb. NUll pointer exception.
> > 
> > The fix:
> > -
> > The fix is to stop using the UD ring as a placeholder for CM packets,
> > the cyclic ring variables tx_head and tx_tail will manage the UD
> > tx_ring,
> > a new cyclic variables global_tx_head and global_tx_tail are
> > introduced
> > for managing and counting the overall outstanding sent packets, then
> > the
> > send queue will be stopped and waken based on these variables only.
> > 
> > Note that no locking is needed since global_tx_head is updated in the
> > xmit
> > flow and global_tx_tail is updated in the NAPI flow only.
> > A previous attempt tried to use one variable to count the outstanding
> > sent
> > packets, but it did not work since xmit and NAPI flows can run at the
> > same
> > time and the counter will be updated wrongly. Thus, we use the same
> > simple
> > cyclic head and tail scheme that we have today for the UD tx_ring.
> > 
> > Fixes: 2c104ea68350 ("IB/ipoib: Get rid of the tx_outstanding variable
> > in all modes")
> > Signed-off-by: Valentine Fatiev <valentinef@mellanox.com>
> > Signed-off-by: Alaa Hleihel <alaa@mellanox.com>
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> 
> This seems like a pretty important fix that should go to for-rc, not
> for-next.
> 
> Regardless, looks good to me.
> Acked-by: Doug Ledford <dledford@redhat.com>

Sure, it looks reasonable for -rc, but the crash is not so common

Applied to for-rc, thanks

Jason
