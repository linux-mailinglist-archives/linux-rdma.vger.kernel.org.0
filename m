Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F3572511C
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jun 2023 02:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbjFGAVr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Jun 2023 20:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbjFGAVp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Jun 2023 20:21:45 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FECC11A
        for <linux-rdma@vger.kernel.org>; Tue,  6 Jun 2023 17:21:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOt9nZ+B2DNyiilRM1usEqZiWq6i8Hq2WdUgWCGxNLk9NbVUqBI5bz1nrirKGte2aD0hBrmPWN8Y9BE16CGbkgeqzQ8PHmjXvK5z5Oz2UpMmxXA4gqK3+6t9/GhUJVrwmtMqpCFxtsZyXNMieVpX9JVvg5xLFrzdTTQ3OhTnPe2tDJYqJbdzg2qcVzroytshWfIjZ24JwOxj3+z9QL9JV/g/2jbhzaRYZ2KnzVrOPm57xqXpto1WAl2sjfMI8onyCuAq6813UJIrndFTCGAcYqENtoZ2uvAlj0G3DrWBdV80F8NBPABxd77h7G9J/QHbO6M/xBetRU+1M7N5gpwpfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5/pqcHW6uI6HW5nwoWMtS0pPWW+uQcQtJhbyULuTLM=;
 b=nVEqr4cAvQnKeQlRRvxF+p/6MN5e0FJu+14A77qRqybsgVduAXjFcDrjwCdKPjjrykZOFg5QIRKFPZiWn364yafF8SM9upNMlovqw4pP5hLOfGlQklsTS/TA2KlW0f7ZcWCvcHRqk5Tt2CBiTOu80IfIsInG0oQHzNyv7mXibsIp/ypNsn3wMVvejj274FOwP0YUAkwzasdgsai8cCscYZ4vs9uejiD2tT9iv3i2lxZYojYdEb8sB5DR1zFky8KepDKn7BJwWBIHMJVFHt0+dQ2aPwKDzKfJjlQLK4RoLVdiCx/7wjvvcmBrIxQ3lETvmFtMP6QxLGo6qd/RIfCucg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5/pqcHW6uI6HW5nwoWMtS0pPWW+uQcQtJhbyULuTLM=;
 b=Oeweta3ueck9UiWB4RKzeE5DdWPB9PPv4+KyxujsVHWFvAAGk2Zp9rYCduP0HvR8+UFv6ygm2s5l1o2o5SWNm1+Eokpi0B0SZPrWTxp5Qy/b/Ndl1OBZ2rWDMW5M02qtrTsaymjZL/uAqZaUhvzwRbxrnvJvYsTacSsp2J2yMkdFyLByuAk4COZr8Sa/AXVZgzxpHninVfEghRlUb3aHVdxapCiS8RMPUe1NK/hoU3UqrT0TMdfecutRzERH5BZOxuLEJdjSabrPRrqsZZJWPMgMzM3FBGtYP2aDiQIeuLzG37DKNcZi+/vuPhU4RIdEm/Ay+0srFIcm20LqkeIccQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5859.namprd12.prod.outlook.com (2603:10b6:208:37a::17)
 by CH0PR12MB5371.namprd12.prod.outlook.com (2603:10b6:610:d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 00:21:39 +0000
Received: from MN0PR12MB5859.namprd12.prod.outlook.com
 ([fe80::a03a:9b2b:92f2:ff69]) by MN0PR12MB5859.namprd12.prod.outlook.com
 ([fe80::a03a:9b2b:92f2:ff69%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 00:21:39 +0000
Date:   Tue, 6 Jun 2023 21:21:36 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: IB_POLL_DIRECT
Message-ID: <ZH/NkL//qx/oz6kZ@nvidia.com>
References: <ed01bad5-b63b-855c-b2da-d98718fa2b4d@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed01bad5-b63b-855c-b2da-d98718fa2b4d@gmail.com>
X-ClientProxiedBy: SJ0P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::24) To MN0PR12MB5859.namprd12.prod.outlook.com
 (2603:10b6:208:37a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5859:EE_|CH0PR12MB5371:EE_
X-MS-Office365-Filtering-Correlation-Id: ab3bb11f-274e-4bf3-9656-08db66ed299d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VdHDaHQqf3egIV0nuOKEVFhM2mOXxlqhHjliR390b2ktvBnKmlOw0rlA/yEhfFbDXq1gRnxGaXkow2ruICe35c0YNkdd7u79m54KTWZEIzAyoMxt/e37Xlk+fErhwN4lUrVep1T+lU8spWNeyzneji47lzl9shiYHEW0zIKwvc8MwUaQKJepglKELd4PzhERUYq0x2VigzF2TkkAPxUrOv/yhGFrGGqvnzhkDeVkyzYsxcGCedgtTD7s3NIV9usEKCHXWl802eX2wBdQjoVU+qEJ7WD5CezEKA3Kd3BsVUHhYsCbXG+2qud8FzODCCgIr0wBS/0HIFh0hJAWpbqGGZkcndHaCV9ufgmtBDZn/LAZW5PyodNSDtfF+Iqw4gVtImHnCKpzGXDdrT1E/h4Og17dIfnmXWsP58xchqYztzm4XKwLBJOpTpBpRnmWGkJHrerHxs0WbcOSIt7odsM9tx437JHCEx3JTqVCRLVCHkoLDjX2ZGYHBbvDRRqusSS/ioK2XLsbhn+w3y67oLvQZGF+hmdZLYLp/VkZQfz5D5cVWXQb1EkKeVaCRt68f5SZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5859.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199021)(6512007)(6506007)(38100700002)(2616005)(41300700001)(6486002)(6666004)(26005)(83380400001)(186003)(478600001)(54906003)(66476007)(4326008)(316002)(66946007)(8676002)(66556008)(6916009)(8936002)(7116003)(86362001)(5660300002)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jp/bGtrpG+exzenAl/LB2QByl34cNa224dV82PmK8PzZUyDwzo6CRGHzu76w?=
 =?us-ascii?Q?KMw/LFetQeoh/HHRb5l9scqUCsBeGcp4c9GcpEFy0jxiwvKjbh/sKr8OSna3?=
 =?us-ascii?Q?FU3nxnPwhIqQFc3AnSm7sMqEPbXwqKBgO1u2vV67/DjtcXpnjIMI7wIohnso?=
 =?us-ascii?Q?UoKhAvZhpTbB1k29DHS2Xkzt5d9UwCeXYFJwiUZ+OkHWXqH4ZqDomLnuw13O?=
 =?us-ascii?Q?OngExfTtB98653Z3Mp+I0YOw5UY6NpiOU4emfFuGzCcmTdBEtALCV/YMd+M8?=
 =?us-ascii?Q?wwxl6Fw3N6r6sWweAVisJDU0TWR+9dvNDlgzhOUVIVHDXJvZNtvEZkMQP5jv?=
 =?us-ascii?Q?6d5cJPJdscis1OmOtRYngVpRJJLg4ifF3WE0jiEn0URwRShdLuT+eQgutaXZ?=
 =?us-ascii?Q?q3naxeKApWsPZshWQ8rf2n44QFnzE8zeHAHAINS+HrfGF1HY5TDdCNqL84H8?=
 =?us-ascii?Q?rFWy/Ef6nGZ7WC293n1xq/iBQ1SfjGJKBJ6iXoFr3oQyL0Uv3KW0BB98cHRW?=
 =?us-ascii?Q?uVZeBG8JGXH7encm7ehhKGCjJQf1gkjMxSNxaZofP4EPwlB8+b7NSyrnVBHq?=
 =?us-ascii?Q?5XCfVY8fJVGc9zBNiawntB4bUmodGhsyI+sdStqlViY/B8HyGsBRa6cLeyDH?=
 =?us-ascii?Q?xIXoXuLm9/FUxJw6z/51XRrxxB68jn7gX/r8q0WjcqVPc1K0/CbXAhFfaT62?=
 =?us-ascii?Q?ERKe9VSUIFc0y4jDjGax9Ev5ghKWSmu4BIYisxY/2KRvVrbiWAMU7/56CWRF?=
 =?us-ascii?Q?IGu/dztis3qcLLUIQ/r62Vv1djnDP47xX0N314LxJZ/W4F2aoKBzgtnm7QRW?=
 =?us-ascii?Q?nWPtxUKVYAxxfBH34yH17SLel2BVwVVLUx6Hfiw2OnJUiGDHR4UzTwp/BfBA?=
 =?us-ascii?Q?TVoQdXfeZUmErz/pq4WszPRGNRUyrqRHYF4tld41EIyjaVPny5Au1DZS6pkA?=
 =?us-ascii?Q?JkyywpjkXRUG59QpchADC2D+aliHZ5rvZbBjIwNGaNaJj6JrSx88qALpXAaR?=
 =?us-ascii?Q?cZ5OzvpNkAoBxwCv7tqgqhREuqAZGL/2eu/GCqQBt48jwyTeSPxoz8nVGrOd?=
 =?us-ascii?Q?Fg4XK2yY+AxscIyUEP303pnHdTUqGgbO/bAKqWnrU4SXFzcnX32WqScXSVyM?=
 =?us-ascii?Q?tBvKZTFEJ1NzNlFZF1O0ftd/wDYeY5pOgukY64ytXgwR/V/G1GEybHh7+NM2?=
 =?us-ascii?Q?SEz1CGUGe/GotUktt5mf3i4L+F3nhGgvMuCVeUrcBg9wY8fxMRiqC3rDR5q/?=
 =?us-ascii?Q?RraJmV3L0Qn30DJVMcetDalMVfMRD0IiPOOo2ylqVG1D6nAPbiU/QtkI5wRQ?=
 =?us-ascii?Q?pVnBOMHJLNGuYSzDqvI8TpcFizpLU9U71oO0ODN7jS26YzyEpnMFklrQgAdM?=
 =?us-ascii?Q?tA2VjcshjjERqUqyqT1dj/2gde2Q+hesDQXsHglmBA2dyH5iS0GAgL8+K5Bi?=
 =?us-ascii?Q?XAeN9xIoCsPbepViBfDSvsR9lln45pJejsomLSCy2K3NNWsGjkF7LMB63ggS?=
 =?us-ascii?Q?nEKZmpAdLvrMY9kw98tuQHWOtgE3wEI3Z88gpZ4oL/Q/PNwk2F1c+7M1Pyu0?=
 =?us-ascii?Q?pQBq4IQW4hAgMUlSkA8jhi2TTAJTPhXtWipRZhMS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3bb11f-274e-4bf3-9656-08db66ed299d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5859.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 00:21:39.5942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QPaTuH+NcXJ64SM1PZoetyNfUbAa6oxFzgs8caGQMkwCrfWGbIiyNA+qqYBBEsQc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5371
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 06, 2023 at 03:54:25PM -0500, Bob Pearson wrote:
> AFAIK the poll workqueue and poll softirq cqs are working correctly but the poll direct cq sometimes
> loses the thread and just stops processing those cqs. The test cases sometimes recover after about
> a 2 second delay and start processing again and eventually fail after about a 10 second delay and
> cleanup and go home.

This sort of sounds like a race with re-arming?
 
> The failures feel like a race or at least are timing sensitive. If you run the test suite several times
> various test cases will sometimes succeed and sometimes fail. But they always fail in the same way.
> 
> Looking at the mlxn drivers for inspiration, I don't see anything specific about IB_POLL_DIRECT except
> that they have a private version of send_queue_drain which also calls a cqe drain function which calls
> ib_process_cq_direct() in a loop until the cq is drained. But this is only during qp tear down. (No other
> verbs driver does this but as far as I know no other driver is passing blktests.) This is only done for
> IB_POLL_DIRECT, so I wonder, is this required to use that correctly?
> 
> I am still figuring out how IB_POLL_DIRECT works. It doesn't allow the driver to call cq->comp_handler so
> I don't know how it figures out when there are new wcs to process.

IIRC POLL_DIRECT means you don't get completion interrutps and instead
the ULP has to occasionally call ib_process_cq_direct() which will
pull out the CQEs.

So you should look at how ib_process_cq_direct() is being called in
srp and presumably something about that logic is not calling it..

It kind of looks like SRP is using it to reap send completions when
the send queue progresses, so maybe your issue is that the sendq is
getting stuck?

Jason
