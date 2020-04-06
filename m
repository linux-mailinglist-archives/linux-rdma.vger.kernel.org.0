Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 181CF19FB9D
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Apr 2020 19:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgDFRb5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Apr 2020 13:31:57 -0400
Received: from mail-eopbgr150070.outbound.protection.outlook.com ([40.107.15.70]:15746
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726675AbgDFRb4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Apr 2020 13:31:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqxd2Hwzwyotdg5NhBsjhitbOafYtq5yRjniKLYcajr79AqebD+MDwP8MomAh9ALpA0BKy0K/aWfFJimSYAorZMMXEkQUWQ/HHFGNStx9awEtKguf63ZQ9PTDWn3Jnpei78s0+aagtAMclco+cawx1pIV2Nr1rItPykiDKjZL3/uMJHAIlvS4RBfU2Rj4c7722hXGlIuxfy/65j/J1PNBzt0FX+2gNa/GlGDOJWQbhzSZ8rCyRx66R3ap8Y8LPlqT0N8M3JNl0NypzK5EOlxVGFwnf0WbAA0sh+6L7j4BdRfABN7E8jGWwWh4NaEaNHn6tPnvMI9iD9sT+grmXa8ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7pmLFL2rWfGpjYzcmFuHA79GG7rgqXn/tvKh3RF0ME=;
 b=TWTBO3NAFZUEHJwMAq+2ZiBbO7PsFm4vr+cD7JrxIR7CFukXVODnv4exUoGs5OtxyL5aSGqhYS44CInavwDM+bLC8imfZeENzKPsPB9x6rfSuhNM3q7yHEzUHtMJZK4iaw1Wk295NrKXOW0e/LGeH8YtOqk+9UayG31ofzLvsnsvX4tVwhxMYjh/WfXHWCCXPW7Cs1oUwOYscBfyJxe8KWPcOiuY1DOpk3YLXO+LBAI8ltawWO6S07G4hypcPh8KHOAFznU4OS2BjRQQJB8qna6dFqr2lYjpdJw8Kf5zLw7eIRHRXzexrCn6UMNurNP8ZRQYnhbb/CszSCMyDLvX7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7pmLFL2rWfGpjYzcmFuHA79GG7rgqXn/tvKh3RF0ME=;
 b=C1avpZa9UrMvfWd137pJTWZpJFSHJB9zMr/hwQZv4h1V/m/ndyVui/B4eJbQzDPVdzFsRcl1lK8GT5FTROK5CElZkKoQYWv0aNFPuJhA4wE/R6W6xJdYdJOR5lcvTepu7c63sqmlnwzA+Jeps3uJBCSTxAZb2Mt14qm3x+YpiwE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:44::15)
 by VI1PR05MB5743.eurprd05.prod.outlook.com (2603:10a6:803:cf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Mon, 6 Apr
 2020 17:31:53 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::18d2:a9ea:519:add3%7]) with mapi id 15.20.2878.018; Mon, 6 Apr 2020
 17:31:53 +0000
Date:   Mon, 6 Apr 2020 14:31:49 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        george kennedy <george.kennedy@oracle.com>
Subject: Re: [PATCH for-rc] RDMA/cma: fix race between addr_handler and
 resolve_route
Message-ID: <20200406173149.GH11616@mellanox.com>
References: <20200403184328.1154929-1-haakon.bugge@oracle.com>
 <20200403185707.GE8514@mellanox.com>
 <1720C7BF-D6E4-4779-B05D-203703042B36@oracle.com>
 <20200403193656.GF8514@mellanox.com>
 <EDBCDCC1-E03F-428A-8352-734E3F01B316@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <EDBCDCC1-E03F-428A-8352-734E3F01B316@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR18CA0029.namprd18.prod.outlook.com
 (2603:10b6:208:23c::34) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR18CA0029.namprd18.prod.outlook.com (2603:10b6:208:23c::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend Transport; Mon, 6 Apr 2020 17:31:52 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jLVbB-0008Bd-6D; Mon, 06 Apr 2020 14:31:49 -0300
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 74e065e9-acd7-4594-cef0-08d7da506528
X-MS-TrafficTypeDiagnostic: VI1PR05MB5743:
X-Microsoft-Antispam-PRVS: <VI1PR05MB57437256CCA0B740A0B13B77CFC20@VI1PR05MB5743.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0365C0E14B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR05MB4141.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(33656002)(86362001)(6916009)(8676002)(5660300002)(81166006)(53546011)(8936002)(54906003)(316002)(52116002)(4326008)(2906002)(66574012)(66946007)(66556008)(2616005)(66476007)(36756003)(9746002)(9786002)(1076003)(81156014)(186003)(478600001)(26005)(24400500001);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tv+3BDNgMfS6RdjAleFsfReMCLd4FTcTE2ZonGhRcLdIUqj6eEZs7tVWzQXKOMw6A2q75sxAOIUevAab90tXBJo+BXUdrKCHeqO9lYNd3TYaT6cBW2hXnr8AJJ+n/kLl+UUf1BqdCsLG2aOefNSSZLb8bp1uMwOp4mZySBoaPt5vMa7LHxutE6dEqKZkiX5IT1OBn3vKshc/4LNGToud5M4h7CQn/VL/7ubB201RBPeiiDMpdpZn2sMMeVscUw3dcDI0xc4qJkQRG+llDR4huNHtOn2lyAXsWv7BMdoIwQcLa8QHWHl/S7nxwzWRPOJnEKIM6Od77Q1hzHMl6xIcgbOk6o+mqirX/6hjeuVb+6RpoWKV0ErpVkCtVXabZSJtfmZONBaR9CzBcRqHCHIB0C99kqvIACF3jKhTYo2iqCy2lR5AWZgE5g+3sFMEgz4WGE/+WD2C6hR3FN0+Dl6O82wTRJq4wz8oJPiOGebIxvOF8XTOIB4Kld83OO2LHYvg
X-MS-Exchange-AntiSpam-MessageData: 0JAemRDeB1DAYI9af8nAGgSRZfEYvFE+YJooTHC0mqRs/3vqRRiC6gZQK+Dmj/r6hlIXUDRjkTrfQfNWUf8PUIMT9Xbwb8MQYlZwDYwqk2qS8t8n7EUSz4rbfGjv+TRaHuKikfA8PD9KbAp009lSAw==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e065e9-acd7-4594-cef0-08d7da506528
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2020 17:31:52.8804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efIa0t0+YjInD3B9kcfqsZrkapz7uquzCKi3uaApuy4b2+rQVS9R+2itrbTVnF+72e++Bh2X42IzVDjHBM9Wtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5743
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 06, 2020 at 07:00:46PM +0200, Håkon Bugge wrote:
> 
> 
> > On 3 Apr 2020, at 21:36, Jason Gunthorpe <jgg@mellanox.com> wrote:
> > 
> > On Fri, Apr 03, 2020 at 09:07:10PM +0200, Håkon Bugge wrote:
> >> 
> >> 
> >>> On 3 Apr 2020, at 20:57, Jason Gunthorpe <jgg@mellanox.com> wrote:
> >>> 
> >>> On Fri, Apr 03, 2020 at 08:43:28PM +0200, Håkon Bugge wrote:
> >>>> A syzkaller test hits a NULL pointer dereference in
> >>>> rdma_resolve_route():
> >>> 
> >>> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
> >>> 
> >>> This commit in 5.7 probably fixes this:
> >> 
> >> I think it will not. The mutex in 7c11910783a1 ("RDMA/ucma: Put a
> >> lock around every call to the rdma_cm layer") will not prevent
> >> addr_handler() to run concurrently with rdma_resolve_route(), right?
> > 
> > Hmm. Perhaps so. But your patch isn't nearly enough if that is the
> > case, you've only considered resolve_route, but it could run
> > concurrently with *anything*, with the usual problems.
> 
> I was about to argue my case, but looking more into the code I tend
> to agree with you more and more. I thought, at least, that the
> rdma_foo_bar() functions had atomic checks on the state and bailed
> out if the state was inappropriate, but that is not the case all the
> time.
> 
> And the code that transitions the state from FOO to BAR, letting
> others observe BAR, and then conditionally setting it back to FOO
> isn't exactly great...

Ah, I did remember it right then :)

> > Probably the simplest answer is to have ucma fail operations that are
> > not permitted while an async_handler is pending. I'm guessing the only
> > operation that would be valid is rdma_destroy_id?
>
> Yes, that would take care of this class of errors, I agree. On a
> real systems (vs. the syzkaller setup), you may receive (almost any)
> CM packet ay any time, and that concurrency we must handle.

As I understand it, a correct application has to manage the RDMA CM
state machine, so if it has launched a background resolution then it
must complete/stop that before going on to do something else?

ie this is why the kernel ULPs theoretically don't need the extra
locking in ucm?

However, I'm not sure what the state machine is supposed to look
like..

> Shall I make a v2 base on next based on this idea, or do you have
> something coming?

Sure, I have nothing :)

Also that rdma_destroy_id in addr_handler looks wrong.. ie we still
retain pointers to the rdma_cm_id it destroys inside the struct
ucma_context, don't we?

> > Until that time we are taking a 'Big Lock' approach to all concurrancy
> > problems with rdma_cm as this code is *completely* broken for
> > concurrency.
> 
> Have you considered putting the hammer inside the cm_id instead of
> the context? Would that allow more concurrency and still avoid the
> 10ish syzkaller bugs?

It is, isn't it? Here the 'struct ucma_context *' is actually
per-cm_id, confusing right?

Jason
