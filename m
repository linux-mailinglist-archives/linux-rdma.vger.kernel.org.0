Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D712C48F9C2
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jan 2022 00:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbiAOXCv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Jan 2022 18:02:51 -0500
Received: from mail-sn1anam02on2137.outbound.protection.outlook.com ([40.107.96.137]:6232
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231462AbiAOXCu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 15 Jan 2022 18:02:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJfvT2JKHn81IutZ0ULE24pYxgSJ4Qr8go0iRLLZBkCTCPO1z7DuqttEKb7yDM4TOPZPFVIiSkSEwtC969hizEKKK72GqVhSNZcRE4/eq+DBCJPrOOGmJ8kIPZ2dEqNjRmpjhJlgyN5UhqkUah+puucKbqkfOQwboOjOLGaDIboEC2e7Zfi2UgVPchoPYoiirQrt6vLEN1JzKtF0HAcXQrUEhTXlxfsH3kDK3HenmextDHP5pMV3GgH4CS09YpbqtnP9EzkgyujfYEUDTveSo0aXPDdbq00ndO9CPXY81ujqFPqIWXN3jwr8qGfjR55qPUBFMSfxv5ps1bus0QsqBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPpkchdLaG/KXP/PYyLwJBT7bPuyV7jhKo0nLa1806U=;
 b=bYg8BdxQgUURJvE8AYogJoFJgI6CPRy0Ntns4SBGTHIPEk0RUGEMVOucio51uZo9WD4jy+S7AoQP2XSW3pCsIhfIv/bNEKxeRofwjbrgkgwaIaYDHlSyvnqDQGIR+LBfTykHsKGC9PKCs7JGEBpP3wzC22O28Xq/uEs5a+aCJgRs2LVV7s+rNbGh2WOgpOirO/iTusTS3cII4fDy4ohU43llDKN3dDLscmIQrN/F/y7t5TJSMnF3iNavoVZ0WMUfoEtu/9VlW3ZAqWu9Dd8D8ckQlls8mosEnVygv4C+XJJCelgXvobtcYka+1KaA4Hl2b4lwz2mPbNClGje5rcojg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPpkchdLaG/KXP/PYyLwJBT7bPuyV7jhKo0nLa1806U=;
 b=OfNp+I4RGfnadq2N3LK7q6+lgOsYCxpyr87pu0DKLbjWekZfinnmLb+POYk5z/0JHlFUvN6lcvVgE/Zi5vaUGMtTT3FirZH7BXbz8Vbkpj20nrG0sDmPvQ9jhvpNKixiOtJPsUlMS7By/QepLHCvrtjmCGvA17WH91hIreMsgDZwamQFaZ3Qd99XEAl5omv2jb5WsUJVi/TNyTa+lkXu6uVN0huvHmSIyrClZUPhucOzOVaiDVuFDGaO7XITJ/70ZqA+lPxDvcxhggGFQJ2twp6Wxx6D7rG+5cmsxjkygH9OkJdIbC+WYXal5IDgql6TpNefQHxKX5tIO0DYTNQ1mA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from CH0PR01MB7153.prod.exchangelabs.com (2603:10b6:610:ea::7) by
 SA0PR01MB6140.prod.exchangelabs.com (2603:10b6:806:e4::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.11; Sat, 15 Jan 2022 23:02:47 +0000
Received: from CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::110:392e:efd1:88d0]) by CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::110:392e:efd1:88d0%8]) with mapi id 15.20.4888.012; Sat, 15 Jan 2022
 23:02:47 +0000
From:   mike.marciniszyn@cornelisnetworks.com
To:     jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Subject: [PATCH for-rc 0/4] AIP panic and hardening fixes
Date:   Sat, 15 Jan 2022 18:02:32 -0500
Message-Id: <1642287756-182313-1-git-send-email-mike.marciniszyn@cornelisnetworks.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0106.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::21) To CH0PR01MB7153.prod.exchangelabs.com
 (2603:10b6:610:ea::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc176c4b-698a-4966-91e4-08d9d87b2533
X-MS-TrafficTypeDiagnostic: SA0PR01MB6140:EE_
X-Microsoft-Antispam-PRVS: <SA0PR01MB6140BA22C8D6635B8EA33307F2559@SA0PR01MB6140.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TdcO6V1qse0aefMrnkUwgnKyZ/SlMZc38URWq/Tru3S9amNiakUF7CV+hnakz55hpER9EF0Pw/DkG0H7Z3AmfvBexriDSL+yJPr88+NpM7B1YetthroF4KfHysoidvCE49vTOgJSzj5I1zDdU14i+XQPeQMx6lxlv1M7Z+ZfrnhrZoBjRON7lXDRnBC3yb5jRso13A7D9/Xp0HRZd5Y1L5D6q3lXAOuOApz8SfQCIQXf4kXOmiHH6qoSy9DCwt00EAq1EU9UFtm3zmIm5DD9Zb1haC/CoERAQAAjBZnTe+P6kRndS4GkIwOr/9M2SGp889g+uSZ2Q2425ESQUwn4dGyEHV+eb/jfkcfRAzM5Zm93KuZmmq0PzODTcyrJIuB2xC7Pf4Z8yGH+a/fWemi/XcwJeZG8UdlcSNX0Xg/hKsIsfjyUUtq7vpB60i4/cO+DP0Zve37IWFWseUmS4UjQTlir3H2Aa1Mf05LeJ5D5CmTdEEDf8/RY4Tot0IdOa7sj7wGnLeAI2wRSd50eIQq5iEVm5bx15mXnbB133pRDqn8N/5b/MJ4OSnGPcq6ZEOTLI4RqElfEsL1ngkjds2637+Fjgmh9UIc1TEvFG9ErYjrAkHxijPP44igZFwzU6fre+NpP4ySwL37ssMIlqtaQ3JGtpsMqbvxADVwlmwYdpVTZZ3SgwETNOcg/laKVeWGkn5yR0Ny/LUvjYA8RCBmLmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7153.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(396003)(376002)(136003)(346002)(366004)(36756003)(86362001)(4744005)(508600001)(4326008)(26005)(52116002)(8936002)(6666004)(38350700002)(38100700002)(6916009)(8676002)(6486002)(107886003)(66946007)(5660300002)(83380400001)(66556008)(66476007)(186003)(2906002)(316002)(2616005)(9686003)(6512007)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aYKnrC2rlP8GxsGUwgzBZ3Tz0FCZcZhcqrWO98pKxhCSGyeEpZlDIiiwxeHy?=
 =?us-ascii?Q?Q2l4oyEIKKHRt98O4RpY7M0pJZnxKksf63/AW2xYj+Wn8QHZxoQ/36kA8A5r?=
 =?us-ascii?Q?WZg6FEQDFdS0ycMDwK33oJItItiXJ3mMnxRaY5+PCaeYhzvXVklFVo3To8I4?=
 =?us-ascii?Q?ilVFVyF3Ea9JIibmylFinInJU8d26TAyXewuTcMyJB1lpwicw/6rc2Zsm4wx?=
 =?us-ascii?Q?T5Tdmj5AFefkvYEufEcemVyujOLxRJMsC5n0QkVoAlS3OxB4ZNY5zUMfomWj?=
 =?us-ascii?Q?dDi3FtJzpi1O6mWGD62lb6nGHgw+hwE6Uv3nnMhodyr7PfLNBCv73AnhmyHg?=
 =?us-ascii?Q?EyApZuEYbzN2EEw1EKOx5tY5nAun3mNCdpSqNfuVfretZ0nAnKrFoGTN6JVF?=
 =?us-ascii?Q?TIBt8UW5jICzWAeQmYTgWDQBImtEuGZ5++Q7BNvfRGjyQrsIfJRBkvEurbz6?=
 =?us-ascii?Q?d7j0vBKtOKlZyn2sVknQ2qisyIf/IcfAMi8GN7woDvG/aX9Gzo+p7sia0jz2?=
 =?us-ascii?Q?kKyOkYSOuXFVZNt0fygJhLjfNSeG0OcLLf7B93kY1TeP3G2fvvRwQ8BAG+1V?=
 =?us-ascii?Q?LwVki7ZzbvRFInetHpfZAt80MpbJD8HJl4Lk2H/cTpzNLoeD0gVlhq/U8T/Y?=
 =?us-ascii?Q?ntJNvvuotGKrYl/E6aiiNFhg7GHMHBtDF4/oXX3o+9lJpDvu34hq+/5VgEZ6?=
 =?us-ascii?Q?UHHKAn80Ab7JPODnd1c6XMrLZsI3mZJRUde+/TCKCv8yVF+Ce9hrKgG85n6n?=
 =?us-ascii?Q?0mU9lDHBWU5qOHjdEqE8TPv4KvJm9NPInpNZqf49tqguy+vh7iSrqSjY6ouE?=
 =?us-ascii?Q?yyM2wBAqFrynbZKEv2wGFjpT7TS2+M3eInqC9bf5pJgQrTTp9Sv4J578yC2K?=
 =?us-ascii?Q?zF2NQxnxChpwZHqN7UyqvqPUC90xbB4YRIDKxmCqoMwNaBkohrQveoUi6Cjw?=
 =?us-ascii?Q?FKjopviRLFVO3k5Jng/OPNMJ6HMHqcaJH91naOCewRqKOlGzBqyaXoWsTmAW?=
 =?us-ascii?Q?VW2Mm0D7eOxwUJa8iA0Ko58wqcJnwnNpxGXhACIqYuin9IAYsmAMb8Iwp/6R?=
 =?us-ascii?Q?0A7D7ySSbZRLc0alojUZIwqwCaZgP0KBLMk2GowLyWd7kHdD1xvc/DJwnsss?=
 =?us-ascii?Q?rRgVGQmli83ZO6rihRnRL7ZdL2JeBqAoNaZiA+g4Fni1S+CZggo284pBE0Ba?=
 =?us-ascii?Q?FN61h3pRfFLM9GVjB9WK3JEQpxpLhSns4EHZd4gbM5JHM998BcQk+h+I84Zx?=
 =?us-ascii?Q?O80Ol6dLzVHZ7kI40wEPXgYOHTNBt8CxTw8G7UGx348fWRwWdo9N7ITWu0mN?=
 =?us-ascii?Q?bcZoTt85YISvXQe8sZ1FZ+yu56dC9TBY2nI93JCQjLI2HbR0wzTCR/2IS1EX?=
 =?us-ascii?Q?WeXplpz04nR2tJC8VC9Q6qw10nwskvoqn61JnKAXx8y1Lo8f5RkOxwzh+aRa?=
 =?us-ascii?Q?NKoQ/FPhbMIUMqZI6WXASJMQ1KlzEE+YQfWTMgY281i7dllG0OG+yUps8yQh?=
 =?us-ascii?Q?sgtuVBVGF+KiygnXGxc4rQmeAMJgW2csHQDuwxK3Y9xFFTJBZXOjkYzB97Fn?=
 =?us-ascii?Q?U1GbPQzhie96hXWpEhMzxdwd0TwWzCGsAfZ2FPYAUEVLIxPrEPWJN1lfk5De?=
 =?us-ascii?Q?X2vsrTMzYhSVT0x+hV/XnrdWb52PQ0/mbq8Eo5zJPqxU2vE/PcL8vWe3pee/?=
 =?us-ascii?Q?hvOTAfXA+KR861aaYY5GwV3ACgYoocxgFHsVDBDgobGzT/C33V4OmLCvlyYN?=
 =?us-ascii?Q?DwM1P9ZZVw=3D=3D?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc176c4b-698a-4966-91e4-08d9d87b2533
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7153.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2022 23:02:47.1348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Tr91UKC2+QnLF0wvhR6OaoGjKfRPJWLfmw9Es28tjTgwQXd/pGwXC4Lb1QoVns+JU0KKLQre2lM+p/9APU279qNRHSY9ji7NviF8lGTpZ40AZupt72sXyxdn1ApYuJz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6140
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>

The first three patches fix serious stablity issues associated
with increasing the send_queue_size as relayed by ipoib.

The last fixes adds a missing alloc failure test in allocating
the per cpu stats structure.

Mike Marciniszyn (4):
  IB/hfi1: Fix panic with larger ipoib send_queue_size
  IB/hfi1: Fix alloc failure with larger txqueuelen
  IB/hfi1: Fix AIP early init panic
  IB/hfi1: Fix tstats alloc and dealloc

 drivers/infiniband/hw/hfi1/ipoib.h      |  2 +-
 drivers/infiniband/hw/hfi1/ipoib_main.c | 27 ++++++++++++-----------
 drivers/infiniband/hw/hfi1/ipoib_tx.c   | 38 ++++++++++++++++++++++-----------
 3 files changed, 42 insertions(+), 25 deletions(-)

-- 
1.8.3.1

