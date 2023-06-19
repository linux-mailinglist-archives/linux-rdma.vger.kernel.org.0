Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0782735712
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jun 2023 14:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjFSMmV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Jun 2023 08:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjFSMmP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Jun 2023 08:42:15 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D5DD7
        for <linux-rdma@vger.kernel.org>; Mon, 19 Jun 2023 05:42:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGqKxrciZXiV07gcU3XalOan+/lD3O5Gb55I5cdukSzsGmz6pMr6Zebm6SBoaXVJ7Ut424SXGkPknCcvA7SYzh5ThqERn3ewj3eDAfFsbYX8W1qRDhsyyxJNV8szClnIVftBGV24u4ulTqGzsdA/BlpRwl6YOICc9rn3bMKiqU912mRR0Hn3upOuzMevRUuAvXBLVLvqFkX9TlPuK16y3WQ1fbshgUL/SBnfEQ/FdtQDun7RW8XOfrEl0+KAGB9IlnMZO2i0wWVbSmQoRGo5T4p2r5VbU9LeflDYbUg/Radz7BgJA5pUp3Q5+LYdTl/EY5aB+bcasU/54blRjTlUXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmuS/q+guRYJDIm+gPDgENZejBCGDJ3sXJ/gEptzx28=;
 b=EX541HYMPHzEP6uJ0h2sOveLIDpILK0gRvXrix2+pEXmIGjPXfS19CCMboxN0r7fIqAsW5QszKnUMsUFD4q8q8Yt0RvFXDxQAj7Zk/0VJkaM+E5aVLUqtqs1FWxb8mYqFO6T/Ec3d9fVWwWEl5mW6azocDA1ozlyAdcQwiA9w4VphaWXPB2huL+2UWNLjbHNLC1QsAyswFideeV5EMqk5gwvXvwnAttr7bsGJWh4XQpJQSiw9uzQ1/KYkUwqoKYRtpzX9FWc+TqjbVmLNdwCUGIjY/ufoxBfWDxV6h2y7NRDObi3zkJIkUOxE07FpJsVdWZOn/Kv/tmi6g+0ZdxZXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmuS/q+guRYJDIm+gPDgENZejBCGDJ3sXJ/gEptzx28=;
 b=ZVMGJliEIKTS19ND3zXSdU8dcyLJpET8GJ0deGa8VqJeOmg2Gb6gVA7suRjMVF4NrqJtRk9LHHk4/sfun6vmP4dOQLsfcWCTbssAqUMTxqRqG9CRKUcz4+ZuCbs3JQywwTtGK64xXsiOO43hH5dTazosH/8x6rqPqo6uDtSWIxrynBZTEDhSez4lqLejbbtZdhcC2g2oPVSSNCFz0ydQEfGWzfkORRLjtzHARtS/X4uEPwJKRBaSZTyRJ677+VacCUhsnAstaq7k89ct+z5FUDr2G/jf6NtSnKdwuzUoIRaKKbx49QLn9wEW4NcNG929HWHaWac4ulbhRV2GIl5SGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA3PR12MB8000.namprd12.prod.outlook.com (2603:10b6:806:31f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 12:42:12 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6500.031; Mon, 19 Jun 2023
 12:42:12 +0000
Date:   Mon, 19 Jun 2023 09:42:10 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Hack, Jenny (Ft. Collins)" <jhack@hpe.com>
Subject: Re: shared variables between requester and completer threads - a
 concern
Message-ID: <ZJBNIltDent3sOqx@nvidia.com>
References: <8bbd8118-ef8f-f156-6b13-f317bc90de58@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bbd8118-ef8f-f156-6b13-f317bc90de58@gmail.com>
X-ClientProxiedBy: YT2PR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA3PR12MB8000:EE_
X-MS-Office365-Filtering-Correlation-Id: af77717d-0f25-42cf-d944-08db70c29aad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QDib8Qnpypjg4I1b8xnZBmrqL0xk9sJluBbNrbhjVf+79Kemho32WBfHJ2+ohtwwyiehLfTmAbuVRsGhuZ9QwiNjGaKaPVkODOyMFwpxv1sJ/hx+kGU51e+QKYMB7lkavtG7x6x/3A+jR2GtQsARp2545EnK4nhlZbdryliq5ZJY1VB4/G5wPI83MO0xiQmnbmWf+Wr8UFMIvLIvmzEaBTkaSf48VjzduyOoiGfHv3gvXokakM2G+fFAIpothZ0Nsxc9mlj2QvfAOO6Z/KNkK38bpey/ncTtNftdL5zs53m3z12G3cgaDxTnp433pnC7qIhZ2lFDnQtszy5dWYGAMye/zxLtrAKGZ4Aee3zA7zMUFa3IcrqNU2giCGLJEDtE22SQbIM8RzabqtCx4mX4WI/VFo/vqNlx02YZlU0hEj1rxgkng0LMoTlb9Ci1GfrEVRsJlES9grbmP2YDZ0PhRNI6RG08fuW5C3tZmPZS6eb2WgEOapoJlinzsd0ozhDC2qiGAZPJQGCspWK3QH0v2nhPc7x4l0ORiJfZyCB2qvNlvHanXCbz7I7AAHGwt038
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199021)(4326008)(54906003)(478600001)(6506007)(6512007)(26005)(6486002)(186003)(36756003)(2906002)(8676002)(41300700001)(8936002)(66946007)(6916009)(66556008)(66476007)(316002)(5660300002)(83380400001)(38100700002)(86362001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V/kh7voy2DWco+4mWEuZcv82YkfdTuzNCc2t4lgh07jk48YTtj2nzd3CK/sz?=
 =?us-ascii?Q?NNZJsXw92y7mym7RdeTo6ZtkRs19kgSGaOR+KvRkpRs8shG0FQZukILyqsn7?=
 =?us-ascii?Q?/gOqMwSNjk/XCzA7ZqHcjWd/7s1hW4vtbIh/TFaCPhyC2XXVTPZI2JtQuXTM?=
 =?us-ascii?Q?n+j0eURKuh0Bdf4GJ19GuLnRGgFbc1kCvjquVPac496p1K6+z+QS4IaMuUJR?=
 =?us-ascii?Q?ztkwQAQhhlasH9sOkUwPVD+xqozlmCxoU2xGdjGVsM4G4xzSt/bA3WCB8DXp?=
 =?us-ascii?Q?HaBpkTcJIcgyU5t2eisJ9f7m/2hdHsABy4LdgSFvyDXOU+SaOT4eNbG4ULjm?=
 =?us-ascii?Q?zqo6+zeoQ9ndpu5BqjBrUMR862O9H2gGcr5XXFp6JoIVL6sOvbFu1YuaUEL8?=
 =?us-ascii?Q?ZWV/8oGcbrCG2rLmcxi9/+EOC3+9Si6BJtSAQJYM2XggXnUVtBE/tRUjJP0T?=
 =?us-ascii?Q?0AAQMQSEemWEmZ9cP205fUHVgpjBazroChxfc/ixGcAg8KUYfHXYIhKz/lrB?=
 =?us-ascii?Q?XepjRQuhqpQuAxN9AbK78EouZdI6v4e8UQOhGgqNHyjQVL20JCa5FUZldBlG?=
 =?us-ascii?Q?g4BKBvJZUZlpRmLKyXQ8uuV8NwlM2K7aD8XnszzI+zr4y97Ou44r6Xwbsm2s?=
 =?us-ascii?Q?NOECKwy25i5gf0B8gZwryiFgAw5L3uUQ0sU4e+1Bhd4/mg7/K/eoBwm/dL9T?=
 =?us-ascii?Q?xCNoNiuuztSzVHyqlx9wEbNbzIbtt3FnJ6Q1IJBhjSjbpT8p+fAJucLUq/u7?=
 =?us-ascii?Q?JGEWJKnJpDa6vR+6O9OVgCAW+KRAhCi36ELUxvx1V8JlrR3n6PLmwVdnFFhs?=
 =?us-ascii?Q?YUDAT1ikQWvkezUJLlkL48LxNxQsVKVW9ehzF1ADfy5d6mwj1ikI3K1k5Vq/?=
 =?us-ascii?Q?ybTSKtBoe789D00j0BikqktmqzqsA28DH38R9Zxf0Hd4Nfp3oBz+y9Ob6b7Y?=
 =?us-ascii?Q?X0/0K4lYdKR6ObrxUD+SejCvcD6IUPgNQOYc7dn9qsmGe+aMd2M2j2jH4R0l?=
 =?us-ascii?Q?y9TNMDd33pbreVz/20YBFnK9q7gSEamPpNbgw5ew1WA6Noz2Kn8rIzJKdTuz?=
 =?us-ascii?Q?yq1DGplVvuh2/TEIWlV5JxX7OxG1txiQpqB0QQKs2wi2yx9RxqBP5XsJhfCK?=
 =?us-ascii?Q?lUIFBHEEnkl3yvMkOmhsgYWlbK09B1vizLjis+D7NGmreThMNBPuynNNm3C7?=
 =?us-ascii?Q?1/ISgCq9lA/VVwsAsnVhgmFqjS/nIxNriFJFXgo5PJ18Td2J5R09+gJN0rLd?=
 =?us-ascii?Q?toYyNXZVeYBue4ytmTWvlcUd18BXozf4klces3s5drjX/mw8IjwenGMJ5MZw?=
 =?us-ascii?Q?LFnVL1kXJNd80jd2GbYkTdpc8eFmJ0drJb5NO2DiQfT53TwM3W6J/rZc+5vu?=
 =?us-ascii?Q?wYUh8PwI9ENSBPap9TDbOGPAd6d431rL5Xa1eLdc3vhiAIdRBf9dFAB9q4MJ?=
 =?us-ascii?Q?HZsK+XJX0PCRUTopPUzy2oT3Zjd0ESnkiwE6qJiyhNBJVLMqh3m8T7t/Do7f?=
 =?us-ascii?Q?ok6aLb7b5/dQtCSqcTMCHwsdWQrCKpzBgjF8dxmgG3X5ese4ozXjEeEvIOqt?=
 =?us-ascii?Q?tBaObgiA7wBgPwtns5pDcpLxXkCKBjCVmzQ+f5O4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af77717d-0f25-42cf-d944-08db70c29aad
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 12:42:12.5051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NOTAhe+ulaAte+vaQeph+xCT0QGcAL4RVS0NKPH3OpdlQg3eQiIG8/SMGkOxUM8W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8000
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 15, 2023 at 11:01:38AM -0500, Bob Pearson wrote:
> I am still on a campaign to tighten the screws in the rxe driver. There are a lot of variables that are shared
> between the requester task and the completer task (now on work queues) that control resources and error recovery.
> There is almost no effort to make sure changes in one thread are visible in the other. The following is a summary:
> 
> 				In requester task		In completer task
> 	qp->req.psn			RW				R
> 	qp->req.rd_atomic (A)		RW				W
> 	qp->req.wait_fence		W				RW
> 	qp->req.need_rd_atomic		W				RW
> 	qp->req.wait_psn		W				RW
> 	qp->req.need_retry		RW				RW
> 	qp->req.wait_for_rnr_timer	RW				W
> 
> These are all int's except for rd_atomic which is an atomic_t and all properly aligned.
> Several of these are similar to wait_fence:
> 
> 				if (rxe_wqe_is_fenced(qp, wqe) {
> 					qp->req.wait_fence = 1;
> 					goto exit; (the task thread)
> 				}
> 						...
> 								// completed something
> 								if (qp->req.wait_fence) {
> 									qp->req.wait_fence = 0;
> 									rxe_sched_task(&qp->req.task);
> 									// requester will run at least once
> 									// after this
> 								}
> 
> As long as the write and read actually get executed this will work eventually because the caches are
> coherent. But what if they don't? The sched_task implies a memory barrier before the requester task
> runs again but it doesn't read wait_fence so it doesn't seem to matter.
> 
> There also may be a race between a second execution of the requester re-setting the flag and the completer
> clearing it since someone else (e.g. verbs API could also schedule the requester.) I think the worst
> that can happen here is an extra rescheduling which is safe.
> 
> Could add an explicit memory barrier in the requester or matched smp_store_release/smp_load_acquire,
> or a spinlock, or WRITE_ONCE/READ_ONCE. I am not sure what, if anything, should be done in this case.
> It currently works fine AFAIK on x86/x64 but there are others.

It looks really sketchy.

This is the requestor hitting a fence opcode and needing to pause
processing until the completor reaches the matching barrier? How is
this just not completely racy? Forget about caches and barriers.

Jason
