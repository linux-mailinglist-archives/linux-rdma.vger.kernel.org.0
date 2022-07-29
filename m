Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA63D5854AA
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Jul 2022 19:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbiG2RoD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Jul 2022 13:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiG2RoC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 Jul 2022 13:44:02 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB6A5F9AE
        for <linux-rdma@vger.kernel.org>; Fri, 29 Jul 2022 10:44:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0wOowkG0IkJ+m0NbPhJeadeQoweKl2sNNxtRsbpY75ygrG53vy8JsGQDaLG9c7pDYadRVIVVHMPLPYOpyFqSRZgScmju84rWqZtxhqq+TYH5m+lFMI1f+PpInL2Uoimri1D4QrtvKXvgrL0t7HJ0bww5Du/LaeHVgupo0f/2wyzVjscAY+HCtR5No538FuO+PjqNHx3NsO6JdNayqC8Pkb8pzASLW97VKO13UxIZsXFFubGgJezyzFlWZmIs6i4oiRnbSYzuHiF27L7QkEWDUpDtJDb69/SOLXtNKCMtdGPqwPUgKY1lAc/CZ2euPk8o8yZfQlwfxzeFYrRiJ2Pzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0+EcKy9+knEGUA5cuKIGdXBn+L3vZcZL9b116be+b0=;
 b=jarC5SuUtBS0Iev1029qbEX7khx+DfGEhoProqpuc0J7EVNoQ1oeYNLB9d+m1+v4rshsYp8cNpa5JjTa0Sww6GV0pgikBe1Wa+F4DgpPFSyDZes7GzSqSSnVQvnMEe6+b/mztG0LEZMng0En0hkjDJQ0HSMOI4d/0+5VeyePegjqGMyS5q3DJ9S8YhBrT589aSN2+2aoQiCGaIpYXopV/OdxgmI21FMFUFhdunbBTJ1doEm+fOy8TlVRmIez8I00h1IRe/yBlr69rqxX83+BZNe6kNOmwZ8L1YRyNUhFnItj5+r8Q8qmO0AubllujRsxXU48gk9uY4SucmNb6jf+Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0+EcKy9+knEGUA5cuKIGdXBn+L3vZcZL9b116be+b0=;
 b=s+92lEKSrXQXbqTDFBK8Z0qm7PkOju9QGs2X0RWvA0kkr0MF/FGdBZVE2gcsmYeaOhPfAiUBDCFayqosM1ETZt0UCPo9uSe5k1dOP77NSldALw3O7yq539eTSDAWLgNs/k4qo32m8ewdF28hsMrlk+dfzbVb7QSCJ0WdjcuDmH5HPuRVNXmma0vi7/wPxMSX2742tJ1Y27KUIAz1Bz5x+vZA7SeqoOo+UaOlgDRqF5XAcqixh09BCDswTv4z+EnzyW7msypT9I88mrIwrBm9DZaouzxAN1LGFW0ZfzwbuKKWOrruxRZ9vV/m4aCneT5g4moWXcQJX8DcsZMRrRhTOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB4579.namprd12.prod.outlook.com (2603:10b6:5:2ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Fri, 29 Jul
 2022 17:44:00 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58%8]) with mapi id 15.20.5482.006; Fri, 29 Jul 2022
 17:44:00 +0000
Date:   Fri, 29 Jul 2022 14:43:59 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     lizhijian@fujitsu.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/rxe: Guard mr state with spin lock
Message-ID: <YuQcX9JF1l2ILT1M@nvidia.com>
References: <20220725200114.2666-1-rpearsonhpe@gmail.com>
 <YuK8jXgAncDlppm9@nvidia.com>
 <04e87d78-29a2-735a-b984-d2321a8edc9d@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04e87d78-29a2-735a-b984-d2321a8edc9d@gmail.com>
X-ClientProxiedBy: BL1PR13CA0315.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::20) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe23d316-fbbd-4468-b7d4-08da7189eb9c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4579:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fjZp5Y0v2Cfct2hZxIbimqxky0UNGOke0s9wvA+wpZ/1amrCN9frk9CpzOTbyrn18SFzpTeRXgwlKJaA1JDcNzxMFX14wmqvKb2NQD5saLEQcDHKMYfy5xebx+4qJ/NlPWGdYmWmfqxBxPz1B/GxeKo/pdBh5n0V3ltk3RfB4B3KExSRAu+kpt8LFYLZSvZhPZRGiQ4CU6GFAGUCByq3qj7i8w42au81O1gVeaFFZ2gUnyrb/Oft/rTw1TPQb+D5DA5yHhLcU/TX/YLZ4yMPICRc/dS9e7Foo4gCvijLLZ1XcmckWRV87FKYOYqJjIep7BvRA0y4oJPMTfn27jd3qqcK4YAzxI0PwjKS4d9YexEN8LIBrS2Wb67l7eK0Aphuw8Rcr+5e4ZiNby+DYpR6hq9Y2hiYwAS1EQn+IrBc0ZA0gFvhPWZ8RMHpVSdm5SnGUMylZg6YHS93PxYtInTWqskeMptmQYvhNttdVDNlO4VfLlNDW4FWhw0yH9m0VWyeaPZ3IxIj2Bdbntvps8yP0W9kcOUSmS7uP8muuz5CQlf4+krtx8bdMIkG4bBxuXOpL9HXThNV6C5O+ThiI1OHeQh34Fykqwb+miQCFn7OrArDcTaMfG4oqyUeR+RwPooQ9Ecb3imERKimwhL/y+vZn9IVf5THUXxqpVuCjtc1F+tcRRcpVAsAp38Qs0ewsiD8LM5Ty3PeMFVPIJ41U1KmxRWnXI68oPDoYY11buHSQMnAhr5HaDFA/oiN2mlrNxCJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(2906002)(316002)(83380400001)(5660300002)(6486002)(8936002)(186003)(2616005)(86362001)(38100700002)(6916009)(6506007)(4326008)(36756003)(41300700001)(66556008)(66476007)(66946007)(53546011)(6512007)(26005)(8676002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XF95fniOptnkdFtrbDRG0wyYrMsVgYJumeSp7pzD/nOblmsEkthdRk9KOqS+?=
 =?us-ascii?Q?aOogMmLC4xNtZ1SWPlP55bSVdwVlbGOv8wT3uU/xLPKyVPErFyj3J/7ZaR/T?=
 =?us-ascii?Q?j8xlAQ8NBLJLSj1y+ySCCWevZJ7VfgrMKtWooxYerHXw5jvFErVo/vsjOMre?=
 =?us-ascii?Q?u/Wt0UHdz3LEOcKmbReocTSb98WsA19DX7WHyxsRjDAox/vTX5r2OX6EtFy/?=
 =?us-ascii?Q?hPeNTfo1E86mfhmjI+ZcZIm1zTt87W6iHMY7f5ea8ZWtwWMZb2ODxdajnKq7?=
 =?us-ascii?Q?JtWggX0NStC74XRZ79zWipkgiyf0QR4rLvEj8egGC6JgH7/xh7jUF7Pwbp0I?=
 =?us-ascii?Q?rMqxYum7f7RJ2LxfGjDTT3hZUve4DQsmI+ZecpKeuMQbleKDQtDYo/HPUD8v?=
 =?us-ascii?Q?MGIiJaDQlFsJD+3/eXzh4LPfXsJN7bFt1QhmjNAxLF1qBKMzHCztpQ8Yxp8/?=
 =?us-ascii?Q?djinEB+Xl7QZgCunY2dq1p2heS/ls2pYzTVNPWxvl9hRbZ5GUZ1SraRsV4jI?=
 =?us-ascii?Q?YfYC8WUjgGCiP6uXzTl0gDHcMCkCPSK0n38HKQ6/Nzy9AxW3GooA6lIL77Fb?=
 =?us-ascii?Q?LHbotb61GCp3+iRtpzS7H10RNpVr+ZLLepWKZ8yGoJ73qaGLw01u0JG5jUO1?=
 =?us-ascii?Q?AyELKDTi/6yiRHcgY56LPcidQWow79uDom20wZHrl/D0WZYvWPTXlh9i865T?=
 =?us-ascii?Q?gfwRSy5qaU0KPqddKBIU0ZzjKvfrIJUMMzkBj5/H6hqMHYRyNpv7EemH4dbX?=
 =?us-ascii?Q?ndGqGR0nUyBcwQ/vNkpWhwRJo8dcbztmyabChxKpKK1pNW8GMBsNn2NLU1sx?=
 =?us-ascii?Q?/9gICjP/mKDgChbcE5+mZYNo7LfrwUh66wAq/HkrgsHu/drVVv528HWI2zVw?=
 =?us-ascii?Q?Of1dSLo4teduKN4nw2TNz5m4Tdl8YiRtJZ7VI8DoI7P2ubbDHcgXgJvsxlDo?=
 =?us-ascii?Q?8XFdCqbvcwkmIq9zTc0JFgOEja7M35RZii+3pYUhpDeatKk+Ur9Po8jK2Ryu?=
 =?us-ascii?Q?CfdWsViiX5KWByuXfIvrzFK4YFfK2ayR6ZiRjlaJcGdgd13hCpzZVzoC4W0+?=
 =?us-ascii?Q?NM4sS2cm/+r8Pgn/k6Sq8TbuPSn/EE4clOjpn+jRAre4ccurOY4VHcyr3/Rx?=
 =?us-ascii?Q?60JcFNOBRrdWI655SXpr8/4TN6JXuZCfjM0yueXkUa04qfr4sdLMCkDdibkh?=
 =?us-ascii?Q?ONqijFWqlGJ0V39BNHHMExQ7EEMv7L/uQXKisAqxP6hLo6QgagQecc5ZMQ89?=
 =?us-ascii?Q?Ld8mqGUqqn6y2ebZb4RgGH6BpwhI2uXGpgONU78zcgZqn5Y9HFOoyG69Q/Dc?=
 =?us-ascii?Q?Z5qVsmkfiADGh+IhqhQ5dJtUAiACAUtMH1bO4Q1VX4LV0VaDyHa2xnx/plys?=
 =?us-ascii?Q?A7FTwTp7AAeuekjhFeQ7eOUPg7SVMZy2dozh57QmckOTK+bc+MKy8mGGp1y0?=
 =?us-ascii?Q?vpx+LnNyP8musLWxGtgehTBTrAamovC7eHksjzefQWVr0OZOvWPkpAY3HtAi?=
 =?us-ascii?Q?NaLkZWq4YYYlf2QOJqJapiRrFeoevz5/hR48iJvxyYXzzsRmkYmCKV5IjvsP?=
 =?us-ascii?Q?/A7XfzfHzIHCV7VuVQo6nteHFZ8fzn1hCEg1n+Cj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe23d316-fbbd-4468-b7d4-08da7189eb9c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 17:44:00.4984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: swE85qqe4wc1CJifmBak2wMN5gGUd3EPZoE4vNoOZh9LDR/6FzE6b/GUkqKJMOfx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4579
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 28, 2022 at 12:54:34PM -0500, Bob Pearson wrote:
> On 7/28/22 11:42, Jason Gunthorpe wrote:
> > On Mon, Jul 25, 2022 at 03:01:15PM -0500, Bob Pearson wrote:
> >> Currently the rxe driver does not guard changes to the mr state
> >> against race conditions which can arise from races between
> >> local operations and remote invalidate operations. This patch
> >> adds a spinlock to the mr object and makes the state changes
> >> atomic.
> > 
> > This doesn't make it atomic..
> > 
> >> +	state = smp_load_acquire(&mr->state);
> >> +
> >>  	if (unlikely((type == RXE_LOOKUP_LOCAL && mr->lkey != key) ||
> >>  		     (type == RXE_LOOKUP_REMOTE && mr->rkey != key) ||
> >>  		     mr_pd(mr) != pd || (access && !(access & mr->access)) ||
> >> -		     mr->state != RXE_MR_STATE_VALID)) {
> >> +		     state != RXE_MR_STATE_VALID)) {
> >>  		rxe_put(mr);
> > 
> > This is still just differently racy
> > 
> > The whole point of invalidate is to say that when the invalidate
> > completion occurs there is absolutely no touching of the memory that
> > MR points to.
> > 
> > I don't see how this acheives this like this. You need a proper lock
> > spanning from the lookup here until all the "dma" is completed.
> > 
> > Jason
> 
> Interesting. Then things are in a bit of a mess. Before this patch of course there
> was nothing. And, rxe_resp.c currently looks up an mr from the rkey and saves it
> in the qp and then uses it for additional packets as required for e.g. rdma write
> operations. A local invalidate before a multipacket write finishes will have the wrong
> effect. It will continue to use the mr to perform the data copies. And the data copy
> routine does not validate the mr state. We would have to save the rkey instead and
> re-lookup the mr for each packet.
> 
> For a single packet we complete the dma in a single tasklet call. We would have a choice
> of holding a spinlock (for a fairly long time) or marking the mr as busy and deferring a
> local invalidate. A remote invalidate would fall between the packets of an rdma op.

Some kind of "lock" that delays the invalidate completion until the MR
is finished being used is also fairly sensible.

In this case you'd probably convert the 'valid' into some kind of
refcount and when refcount_put reaches 0 then you'd complete any
pending invalidation WR.

So on the tasklet side it becomes two atomics - which is about the
same overhead as a spinlock.

Jason
