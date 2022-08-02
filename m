Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C363588087
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Aug 2022 18:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbiHBQyw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Aug 2022 12:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbiHBQyu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Aug 2022 12:54:50 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCFF13EBB
        for <linux-rdma@vger.kernel.org>; Tue,  2 Aug 2022 09:54:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiHVjEXdMgCaQ7edOPRQgE+933YsjurAAPFJbaq47CFfBSVgy8JFP5WLhPBzSFMIc49VK+QZCkPQuFAfuymXe8UBxIflzryUIvUsWLlvi6l3v7yUgbOnhz6516tMjtI45zTB2G+EOQgAyQ89cp5UU79YVFA66oi7dJ/QMRsK9zeAzVYvDTo9iMHSkAjbviTAWPeWfzn4qP9ItOaFGnBRtZkCQe/L+/gnb8G39h4ZIGSnDJiw1/RWY27QPTRuxLCzoIehAkjMPYbhZ38s1asOBC55kPvsCDGOUqrGbkNfqSftTsTaQQe+KkFa2U/KnFyTcwYiJ9KKCferalPnWIfA2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFeGVhh69rMGTnqI/5c5EyQicFC74lscIasMxgBPt3M=;
 b=Yh/luK/sWN1cFKasSQihV2dAVXw79c5BjbDr6OWLM+xZkkVHGQEIdBRn6NrHTL87kTg7mq2wXYvUMpqOwnuWkC8LfknT3Csdp4qn9K+fbbIz5YIzbjMpAQsRRA2Fk12bNFqq7MeKU5o6iVfBBSBqkPDVoIuVnzU+gOq7gti5IGCa3E+WwPQ7m0vukOeb5pzzLHMu5QsMH6VMw97Rx//gn5xsUQOkh2mVAOkS2CM6mGupx4zL+C+Cq4PFbxa0b6BjFe8R/DlojpoEi4CCYICK4pTjn4PPo0iJtNF2qWRqADQZEAtUT8yaLC5x8SYND7iBwC3Jgy/YKJ6/koVbmezgeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFeGVhh69rMGTnqI/5c5EyQicFC74lscIasMxgBPt3M=;
 b=b8j8BDuL5mCvDm9pWkZqB4qm7StjYnxjalq7SiFPBvnqpkd0p+ZMuNxmbO2rqmu5WRSPVSs9k4EZpIustYWD0vJNyGuBQKTdapvzmeYuzWjyIBNCyuq7NKQDiDUWW037R03zbtBnCPxNYLWi8+NPW6hIaYC1XBZylEkoFl6wQOx5kv4WtasMGDkqO054tYxtcyKFPqUGo/wiAZGXgdIJayL6FKgxueRY8Kr8ZDqtkrv0zDSaXq5vHw3TMyrgWSLPl+6ilcGsob33nSdxFERbktV5x1pLLR4p2yNT0F0DL3SErjF71rfo/d3dZeYZIL+3HWXok7saMo5fwxhi+HS+RQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM5PR1201MB0042.namprd12.prod.outlook.com (2603:10b6:4:50::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Tue, 2 Aug
 2022 16:54:48 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::4cce:310f:93:5d58%8]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 16:54:48 +0000
Date:   Tue, 2 Aug 2022 13:54:47 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Li Zhijian <lizhijian@fujitsu.com>
Cc:     Yanjun Zhu <yanjun.zhu@linux.dev>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        linux-rdma@vger.kernel.org, Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Cheng Xu <chengyou@linux.alibaba.com>
Subject: Re: [PATCH RESEND for-next v6 0/4] RDMA/rxe: Fix no completion event
 issue
Message-ID: <YulW1zDe+mc6ZUi/@nvidia.com>
References: <1658307368-1851-1-git-send-email-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658307368-1851-1-git-send-email-lizhijian@fujitsu.com>
X-ClientProxiedBy: BLAPR03CA0137.namprd03.prod.outlook.com
 (2603:10b6:208:32e::22) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37cf49be-de3e-46f7-532a-08da74a7b55c
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0042:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mRik+i+dkvTZwUDrEN2U3IBaocrdTT+l3iHBmz3gjLJfZOWfn6SBxVeewjVq/ce7l9fC4w+mtRhOWAnWeDLnaa9A4oAXE3tuI6QAJKA/CyywGOnvuCgTFj30Rtbn12/YcRl4j5EK3NctZY8vAJmq2dZYWqPzbtot74NTza3a8Y+JvRLIHh91l2fgcfwpgtGnuvR/5sDs4gBikOscCX71QsRksUgjNNZy67VXtxXYSPs2KtBJws4qt1XBqFwma4F0bJs2jTyRUec41wQ9psrHN/AjKOxA4gAZjubhVeZY7RA75lFSVydA4PAO1WI5VB7RQiFGlRrYt0EwMBFlU4X9BlVolguJfY1xAN6Hi+3S5RTo/x3v9nslu6yWebT0qaizcgFkPCAgC3gBvZ9WkoV7cTFxbOK0ZtGnExOHZYbwF5jtXG7rXXRU6w9rp60W75MirTcX8YthbvzA4InoaO7J5jRHLBy1Wz7A5c3Wez2ZABNWGV6e4UaUVnpramV5hpmlXpbeTp6BivAyJQg6eeVqUJg66PmjnNmBSCt94cWaU0ItQN3aY6+nxuFJ3YmO14rgaJQJ2w0zzU/f+WTNAM1Tw/8spPTpt0Y/MW/fEnGUw/9k4qGNrHbX/cNh8O7PznS/lcjN8ozN05IpuY1Y9YnoDnaxQOxwBz5eBw1iyfDtMCaGutig3qv24MQeVf628+pZ9TCcifM/qvYJM14DY58fsile7iF3Ifxe2G8VyCg+xxk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(8936002)(6916009)(54906003)(2616005)(4744005)(316002)(4326008)(66556008)(66476007)(8676002)(5660300002)(86362001)(66946007)(6506007)(83380400001)(186003)(38100700002)(41300700001)(26005)(6486002)(478600001)(36756003)(45080400002)(2906002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wXwnNffvxaDvW8hqOVe+QyZC2IAkkBFF+PcYYGIENdDPKNbAjdbvEblKuS73?=
 =?us-ascii?Q?4XyEeFORYV4yjtmeIsv2GvLwEgsowc2003qagTlDdp9ZMcAJ6smk05pH99+m?=
 =?us-ascii?Q?39Xc8Vp8VI2cW8URybeezfSPARF4fBGVfFefLy9qvBChb/q06+yRJa26ttlP?=
 =?us-ascii?Q?U3PiU0jdMu1OIXVtbdjSiZZLvv59vjO0JTKozOWDSQ2qTX2aBKkikqx8CZka?=
 =?us-ascii?Q?IeAQWIYJmt7dEsaHSWquaJwu844W+PpT9pd+enbD5alz40RMpCzZsqFQQg8p?=
 =?us-ascii?Q?4wxHU3yeJB7Xwqt6qoMEMOT9IkhNhVirLDMsiRaV+DyS/PU5cXu3d2hy/LUn?=
 =?us-ascii?Q?L3RWroz0mtdRpQ0oblgfFx5wHUrY9cY4C5psxYIZukod37c++OwJuEfwzBPB?=
 =?us-ascii?Q?c1I9GTQR3TEzAoRGzMUxJkTcO4xsAXctFQhgOH6eBV0EWNsng7hkw7tTRcta?=
 =?us-ascii?Q?XFO78TFk6ZFbbr8kb0fddhN5kFP1C6qhRypeDCNhaefEAg70s3RvOUegYpD7?=
 =?us-ascii?Q?NF2BaeJY6FGc/ntB9bzv95dnd40rSrozq7GxQGmhLZMj3M7Slh0Ffj08DcT+?=
 =?us-ascii?Q?pJaS2u14MsA6+RdJa72ghp2zHuvcqfm/M2vyduEvL0rh0RhrVdziPsyElY3+?=
 =?us-ascii?Q?66A8xU8WU0vW2ZJT62JAse30QO1ycK1xUvdXdBvfIEmDz/K+rsKWN+NrSmmk?=
 =?us-ascii?Q?8QN4Kh4IRAbH5ZWUG3dK45WunLDenhM8aXaKN4HF5nW35VuHPHknmP6Pydkc?=
 =?us-ascii?Q?KCbLRk9WKRqt7AeMHsB3MdDAsGk50hpjwJJkY0ZfSbogrAz307M7C9bKVTNO?=
 =?us-ascii?Q?wBrBxQR5NSKHC/CHODSzTMGrHjSaiUXNO0aGlj78FUzc5hNsSxW5Tu8RLYxe?=
 =?us-ascii?Q?M8tHU7qhFwaZrGEuYJPkVbcFujYc4TozrpCSIhMqhTFJs+CifZOa79AWd+Fk?=
 =?us-ascii?Q?6TV2WEiEUiHglR4WYcGs+rWgMJpn5q0TkuowvROz6GKHQsW9t2Zt/Q/v+Y/L?=
 =?us-ascii?Q?umBExOVSRST1yJbN/FTdaiHuIBGqkvYkBbHIvNkDyZlJkNMz9ON/AzRRl0Bx?=
 =?us-ascii?Q?1FFkqb1nb3sPUgrz4OulouG2SgQV+ET0DoKH2PoEsjIx+SR1O9Hgj8DNWb8v?=
 =?us-ascii?Q?3XTkuTZMinIuEczbdaHTDy8uoG51NuSfD3Xd8pJIkTj5nr88oMNKWSFGV5pD?=
 =?us-ascii?Q?0/DomG9j5L1+BnXchWl7h5L77wv/8+B5JCLslv3ws9MdCM7TwmuePtc42u6A?=
 =?us-ascii?Q?ahJSGWXujlYkDQxFeEERn81eO4fHrHe3LIfoH86BDzjVVnh2wjM0C+pC97+D?=
 =?us-ascii?Q?6bi6g7aP9xEcjqPC0NPJlfJ1nTWi3+RksN/qKTfoCBZ+o6kRN6Hm7CXsXRAo?=
 =?us-ascii?Q?S9zP09uojPXj1c2vyQocEN++UDcqZRRu4KvZz+LozrRTlTPCFem1pzLXmjui?=
 =?us-ascii?Q?IwiR7/tlLsD+OCs8RMiz/8n3ksTUe5OVjkqgeKcOedEpthUQUabaWee9E78J?=
 =?us-ascii?Q?WJ2OWs/qNIbd2sYk2RBM2q8CIUULPsbqV/3LDNikCpxTPMoleR3In0ZBAh8h?=
 =?us-ascii?Q?krJu5w3KlWi/IsGe/cu+5tSF8M2gl8aMhszk6rhm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37cf49be-de3e-46f7-532a-08da74a7b55c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 16:54:48.0089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/SBG5805vLBb9i9c6yqtubvRlXXdYR/GJHOjHchrHnswjl98j5mTM3R1qZitCBr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0042
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 20, 2022 at 04:56:04AM -0400, Li Zhijian wrote:
> No change since v5, just resend it via another smtp instead of
> Microsoft Exchange which made patches messed up.
> 
> It's observed that no more completion occurs after a few incorrect posts.
> Actually, it will block the polling. we can easily reproduce it by the below
> pattern.
> 
> a. post correct RDMA_WRITE
> b. poll completion event
> while true {
>   c. post incorrect RDMA_WRITE(wrong rkey for example)
>   d. poll completion event <<<< block after 2 incorrect RDMA_WRITE posts
> }
> 
> V4 add new patch from Bob where it make requester stop executing qp
> operation as soon as possible.
> 
> Both blktests and pyverbs tests are passed fine.
> 
> Bob Pearson (1):
>   RDMA/rxe: Split qp state for requester and completer
> 
> Li Zhijian (3):
>   RDMA/rxe: Update wqe_index for each wqe error completion
>   RDMA/rxe: Generate error completion for error requester QP state
>   RDMA/rxe: Fix typo in comment

Applied to for-next, thanks

Jason
