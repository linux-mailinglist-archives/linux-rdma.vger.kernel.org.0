Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CFC76A030
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jul 2023 20:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjGaSRx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jul 2023 14:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjGaSRs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jul 2023 14:17:48 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0B6AD
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jul 2023 11:17:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k138fSpvKzT2ShHsKByOqd1scJT6+8ACEQ+Uqkq0XlA2qeV0Z8oxaxoGGDXluf+du5T6IPFA02kqPofOU0pIeisaGS+oW/KaISUXsrh127/s0XlIaa7G1jpesIoK00b04EC7wAs19N7OUJCGyhbymTiTSRg+SHHvpZKsPgsByxC8PTb8ZB/0PmveLSTNjuxQqMcNIQcBlMJD2roAsOBmB9Ooke2Hlgx4lrSKTtanQPuk7gL0noTc4+QtT9bOoktcw8dvZ8/KFVQWlaifWWtGqsxxp5hqhLkDbn2SRQo7lmxkn3TkFmLzfuuJGTb6tO0Zz98WwGcMy9Cc02G1zPGCVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qo+j0UZoF6PowQKv7Zysis+b0l9BTrBfFDYrwUkVIuA=;
 b=QcmF2QHEbnYAYnyS9nxM4NCIcm4Zt+6dGN2sThzl8GsMMlzg+oUehhOfM0rMtAJfF7V/7aL1ijLRDfbaBYAnK/8JAJFNDEAwaWIc6sLS/o5c+PUxLk7G/GbOklEcZJsC+Hhz+WqqydC/hFHYe7Igtk8lbeYyMhkgICdun2pZa22ahg8N8RWfJNetkklRMIchZ+PQxYEcBhuEQxTHBGg6Wa5A1PPwvYSxwHURO+5NFTNzk85TicjrJZpWsWXaZeYGsJrSVMUbuwf4mkwPxbbnpnxQ9v4DkInq9F7eIrWMSsYos4IDQYfD4d2wjlRx+9sk4Gf9UUZQoy7yTSvWolPnZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qo+j0UZoF6PowQKv7Zysis+b0l9BTrBfFDYrwUkVIuA=;
 b=N7GSlqXeqIX14TWuARboMf00BUQIbAI73Vj+OP+ykAAF8Dglljt4k9SvD76acqdFrelojN5+T1LTD/B1elVvBdoAEybL0AKiJ0rQZ0TXbLbyw/PKkYTvxJ8nuBCtdFdY5byagstwJPhLiVFOq3MikVEvrjvd2EhFot3RXxH4vCtanVYRLBOhJyHfwReMs+5C0tXv/LWbpXsYe5831YNAr9oYs+ioXQ5xh4bXXx8JD6H2zzK4IYfppZ60xuT45qgoqlwF6kMq7th0iJzVicxLhwn/hMXBfP/JN24h6ipMIHhHUeY/BqNohJ4RtH6r6Pk2pBLiNm4PO0wfOrSwJHHXNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 18:17:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 18:17:45 +0000
Date:   Mon, 31 Jul 2023 15:17:42 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, jhack@hpe.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 9/9] RDMA/rxe: Protect pending send packets
Message-ID: <ZMf6xkpicBpXr/B9@nvidia.com>
References: <20230721205021.5394-1-rpearsonhpe@gmail.com>
 <20230721205021.5394-10-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721205021.5394-10-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BY5PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL3PR12MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: f2956ab3-d6af-422f-cf80-08db91f27044
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: phrc+O3UQzsALHN/92VCKUSTNTJJti00loIEtomsee7EWzDTyViwDLnkCyxSo34nk34m/St2l8V9q3CG0LoIsUkjZov45grR9wownsdatdU8qoPDjRVGofSWe39W4v+m87ZZUjNW4VNAQ211iuwrLkEZxg1fFVTG+1MrCF8HXk8ieItziDy4hqF7yqb62t8mEX8vl9yAmHxdHYQCxJaGYdSR5bs6wHN+LQnsCx57YW6IAYHi73hZfIF+lXOiQ0k42zsYCaI1Fa1uUFSsgfCEcdskRWGpSycmEs7+NPRZ67YjaIyP2T/FjrVidzok0i2Rvotl77NJo8a+NtUXjKH8403DfJQycySapSdSbXHNi8CaFpQ3Wqv40uZRpE92KBypRycj71d9LVUPS58CLLS7Ju4wUkvhjER5gMm7wEZprqB9cR33UK7XN5tu+nkYvPh4Om/w/ntHphN8FdOIBKc8LWmS+dNF1UDdQXPBNMDXbipehkioY0hCPBmu1Nt1Z1FBnUB7zLJlPfiIBHFyMd0dFB+pxM9GPfja9Z4jBvM1XEpRJEHucDi6odOw49pEYPKt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199021)(5660300002)(66556008)(2906002)(6916009)(66476007)(66946007)(4326008)(316002)(4744005)(41300700001)(6486002)(2616005)(478600001)(6666004)(8676002)(8936002)(6506007)(26005)(186003)(86362001)(36756003)(38100700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xMQDYmdzmTuFz/TPmXE0W3rUIZSdY85J0Hg1Sf7+GAkNEyquJ7vVgsJ8NIIk?=
 =?us-ascii?Q?84CrIXGXbrgfuo/Q47bpa+5dUxzrXaWbiHbe+7jpisKXXSNcTEoZkA2/w1bk?=
 =?us-ascii?Q?RKzfiuRt+sufagx+xFWc/kIMfcbO+C0YBY67scdrrLxOyw2luCSMsfvTbysI?=
 =?us-ascii?Q?8VpP1mt/9NBjxsZ0sVwWjthR5NEbZYWISaZYxRmuFJvPY8U/euG3C/Bn7aVy?=
 =?us-ascii?Q?dWw9EmHvh0hriHaoJPzkTN6S0uU1XNPKmu8dGZfP1i7GYrF5aenBgP3N+LyG?=
 =?us-ascii?Q?BLIHevHJhS63a+AnCIxTjsQggo3JSR+h137LjSzToIG+mgk19D82nMJ5kYee?=
 =?us-ascii?Q?72qhGSBczbrkFCGbbAeympGcnW8A5fcR+jrbpKLg1bp5uHil0eGoI8uI3hpk?=
 =?us-ascii?Q?KDZRzZqPNGzV7XPb5qyWi6+YpIK/9QKfZ9b93EaZQNSlJVLD4AgPq6umqzPR?=
 =?us-ascii?Q?GZvJDwv4+7m3/eNu718mo3S89V2mxvqlcwCz8r8eTo29GtfQxfMgnm0C7FtX?=
 =?us-ascii?Q?/X9H6FExhtBBFF6QD4+hWZnIQZnUhRY0J2kdT20RfOOH9wdYdLsZ2xk1Eet3?=
 =?us-ascii?Q?RAhwOy7yur5N5c8Mizz8e7kMRDB16+sj4Pi1Xui2/qJyFjY6YgDYDlG4DbyX?=
 =?us-ascii?Q?gElaGYrlsPYw/9Fc0QAjaVcUyYMj9s6FOsig6Sdkr5o5DLd0f/RdX6+p6wOM?=
 =?us-ascii?Q?9mtD4kEWX1Hr9BnTcfFV5eCxvxOFvDz4KNFIX6Dzk2dgRuRythOyXlzjekR4?=
 =?us-ascii?Q?kMv/LH/CEekvj5o/rUOJW2z7WwA96u3PW+hhWtgYifJUs3vrIhNMzidBG/3t?=
 =?us-ascii?Q?Qi+2OSEzzVANPAb3FkSfHdY1iqhxwxSkVDKmKsfkwPuluLszoprBGxTq9L/w?=
 =?us-ascii?Q?vFFZBzRSJ6TraGguQDDBWcLtg0Q732dbyQTKiL0A3FItMbjS0mfwp0Mzx+VU?=
 =?us-ascii?Q?XUIG2R6kqgAYgQ+hYCVjMxlbouEuG1jWqLJ5n1x9hUXyDcZoOfubYvtbttm7?=
 =?us-ascii?Q?G4viQhIf3eJGExfH/bIBoEZzAMrqyLvcmLIziqs12soVY/41ojmR3XN0J2WF?=
 =?us-ascii?Q?eLV0JQkSQmlY6iotoXSmDpK4zcn6ff4M+rcUDW6DHn6bLe64jHMSAaQVw/IT?=
 =?us-ascii?Q?8+4eY5kcZ9HklqqFz2dLB1z1VF9/ZU6embMR+0ODzDCAU3lQsYy+ARhW/bRP?=
 =?us-ascii?Q?BzaJXc4y0dIx3ln6t4vFZbzpMSVViopzp0dG2z9Eo97+FQT013IjQiZ78ZQi?=
 =?us-ascii?Q?Cb8PSS9vJmJYHr6QEj731SakVN97yajBDea/0F2T2OOtSAMGD8ewWzOEl2eC?=
 =?us-ascii?Q?yMrnMH1ORUxXDGyICRuDbHbV2F97mRtgPhqEOvuivmJ0jkmyZzjR7u11at7Y?=
 =?us-ascii?Q?7okIoa17fbxt7FccjCWOhg1I2GIW7b0MFN+aIn8njQz5JhrpeZmOri62Rf+E?=
 =?us-ascii?Q?6ZBBP0p0+CN6VRF8c5/0PYS+8XPj295ujQ47CtBI/0CbECrZUFLryhJ6Aq2s?=
 =?us-ascii?Q?5EWyxQFEoOXo98pLsafHLfliuxhubv79xl566aB5r4POCWr3V6+hN/Jol/aq?=
 =?us-ascii?Q?Vbgn8yNdyawTo4aenEG4nNQQg1J8Q1tyBpSj6x4m?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2956ab3-d6af-422f-cf80-08db91f27044
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 18:17:45.6208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CuD5Tj/wFNjPYOf488MTP/+hSObZxq9ReuGiAJCvJ8BjHWnMyovB6nAJ1epguIwR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6450
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 21, 2023 at 03:50:22PM -0500, Bob Pearson wrote:
> Network interruptions may cause long delays in the processing of
> send packets during which time the rxe driver may be unloaded.
> This will cause seg faults when the packet is ultimately freed as
> it calls the destructor function in the rxe driver. This has been
> observed in cable pull fail over fail back testing.

No, module reference counts are only for code that is touching
function pointers.

If your driver is becoming removed and that messes it up then you need
to prevent the driver from unloading by adding something to the remove
function (dellink, I guess in this case)

Jason
