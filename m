Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B613CE7B0
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jul 2021 19:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349647AbhGSQaz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Jul 2021 12:30:55 -0400
Received: from mail-mw2nam10on2089.outbound.protection.outlook.com ([40.107.94.89]:59552
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239768AbhGSQ2g (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Jul 2021 12:28:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XiE0AYWSaVeVqER1OBy7I/qLmzH6JTXsaek2VwO5zxeYqDEWoXfdCPabi4uTxZ+Hnbe8P/Py8aGK6ATkPpjdiJl1q+DO9ckuC5ljYrckBS2zNXjhjfdPL+6bdRhIkgHt7nUeZ/NpnnZ++46HZucD3gCM/XpSuyw33QtoEBzJhOjVu+pGGN2M0CkmEZi6omX0ishl6VnCGU20977GhwSzKbD7cz30zOi05cJTw5KCF2Y8IZWAYGVP5XHHjvt6iclwb8kTfOC+qbvIscxqfmxxCQ3TSsdLp75XCRi5wrgIDNo+CIs1VlWKqHUFDZgIpyhGWju8Xl6bPp3Sn+9JNUVgJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Srcy8XRcspICWkHmmWWu4jronpV1KJjj7kels43h0CM=;
 b=NKtH8b2Wf5JxoWizdDJpjsAdtnydwRyIK6JRZuL6hLphuhVVU7qJoSaAuxGrUkaVecsYvGNX/SsKuxuX3N/Hl3ZqN9h12XfIwNldAokogcmdllAgEi7JMWdhriaiYCWnEiJAjmW8Gf+Mp6k18XF0BFKdXMtoTT9gtPXtmYJFyXpD8ucSsDAbGClAhPRhQBMCvPjxCfu7Sf6SAKpqHGNxQyH8rNSIc9ScAdc5QDqXufUKWELaqKMnhZjP8Xwv0HP2N/o5tREA++jCdRJmJCrMakpVXmWFWTwaA2NLafBBBHvEaOf6abAf/EHsGrk/bOfTP0NeU5W/IYhU4ky4Hlgknw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Srcy8XRcspICWkHmmWWu4jronpV1KJjj7kels43h0CM=;
 b=k1Zi1HC6ulTyn5PdGCae1A54WnMxSwBv9lDyciHPe3lGi7Y97/Pmotkx/iwHwuEJRU2Hg8AywiwTjFWb/46Dm2BOaefnF6cV8cRsNoNQfQgFC6Oir+a8ZmAdO+jgHZFNK0Ivs9i+YwmMogaD8+KSAIgJbIpAvQxXYKp90ld3Wy9qlIM5ogNdfHBhJwuxQt1da4ZulbImypOG5hLvs51X/wCq6otVwDobxKyt1L9MTSxA0g2WKYNLJm6G7fnjllsXK7bYsYhVHSOdfgz0qya6569o2WVxjGEOEngnEF9xnd9KHh4dABh1d/MTkSqtdrzoi9/CbZdQ9JnLwtryDJ2ywA==
Authentication-Results: raidix.com; dkim=none (message not signed)
 header.d=none;raidix.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Mon, 19 Jul
 2021 17:09:12 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4331.033; Mon, 19 Jul 2021
 17:09:12 +0000
Date:   Mon, 19 Jul 2021 14:09:11 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Chesnokov Gleb <Chesnokov.G@raidix.com>
Cc:     "lanevdenoche@gmail.com" <lanevdenoche@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "dledford@redhat.com" <dledford@redhat.com>
Subject: Re: [PATCH 1/1] iser-target: Fix handling of
 RDMA_CV_EVENT_ADDR_CHANGE
Message-ID: <20210719170911.GS543781@nvidia.com>
References: <20210714182646.112181-1-Chesnokov.G@raidix.com>
 <20210719121302.GA1048368@nvidia.com>
 <2ea098b2bbfc4f5c9e9b590804e0dcb5@raidix.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ea098b2bbfc4f5c9e9b590804e0dcb5@raidix.com>
X-ClientProxiedBy: BLAPR03CA0123.namprd03.prod.outlook.com
 (2603:10b6:208:32e::8) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by BLAPR03CA0123.namprd03.prod.outlook.com (2603:10b6:208:32e::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 17:09:12 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m5WlT-004Z2q-AI; Mon, 19 Jul 2021 14:09:11 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 288831d1-39c2-457c-3f14-08d94ad7ee0b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5174FC403DDDCBF926FFAF13C2E19@BL1PR12MB5174.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P4rs1e3357gngVKjq+Dlez/FiR6vT4rWI1I9LVVtQ8Ia8Ok0gPBtOdQfjKboImn6wUnFZOoTD3DyKDvePpwOVU/f8pqmBZ7AlmU5kWpA7SjQcDZq960C38LYN2BDXjQMDRT+4kS8yn2qgiYaEvtWNb+c8KQTRIWYgC97RUc0EVMrZGF5I1J3wCzAC9mj9XJ0wCxKd0TKxprz4mfeINGLY0mhJGcHGwMJOdjrLc9qLK2FDksn4+U8XgwM5I3h964D6mBFbY9Vfbyjoa92ui5eNQ1LIQa0tdbMSJ2TwbwzXHYPhCnmgZkcl60BDTnrl1WFECn2/5xcc53Wk1Vg1xchklbHnlJpddxs0ZXEnsXdpRJd2uLaaVgEH/7ICD7VLNggkIHQi5BKcTGiw9F0fKB6KyUhfkep/q643bZeUG22vJlnNkl6l7ObQ5wE9KgGFXEfjxgx0WlM9HZDGTTqXnJtkYRqyqmFxnQ6KqTqZsECWWuua6jLzWuqPiosGCF9qjJy5HT1Cl1cDdLU9A/5E8k7RHQz6zeADedVuL2IUhVsKUDd98oee0uNo6822u0itCA7azZ8z38RSuKZc6GJp17bhH2YKMBW1QKQuLm2ie2+u706cKGiIRNX6tWpxCcUfyaFA7Ox5pUMDqiWjfqg7TWM2K79XFO4MGMpR2pRIdIK7PKsHBHVHMdNrpx7EiuGNXJY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(9746002)(2906002)(9786002)(186003)(2616005)(83380400001)(5660300002)(38100700002)(8936002)(26005)(4326008)(36756003)(316002)(33656002)(426003)(8676002)(66476007)(66946007)(66556008)(478600001)(4744005)(86362001)(54906003)(6916009)(1076003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0rxBB3NtPwsgQEn04bR8vAiBYkZb9dkbpCpwbpUU+ikLMiUCg/WGbLj5JY2i?=
 =?us-ascii?Q?Dl4Ul5WP1ziv5RvLVJidgYSoPXueBHqt++rIv0LwUNeZCl1EP5BJ3RDe7hk1?=
 =?us-ascii?Q?C7IAAv8SGSISoUU9qDenpxw6ZJezbm6Va6Qyna1iDAjEkH1XS3NsEM1yrfT4?=
 =?us-ascii?Q?1LwR6G9eTgTFxMum+VvEVwFSWWmfNyG4m4UIxvgbGA6LCy0ENwvNvSy3iRvD?=
 =?us-ascii?Q?VqmI5lyi8VwShlo8cyRUYH5r7LxR3fE1DJTMXgTB8Zu78hr3mTV+dKsEezoX?=
 =?us-ascii?Q?6keBJ0RwBrWsKARQZXX/dpoGAWIAPWnlvbBHL5LTTJXTr3v2X59CUrz1MvUD?=
 =?us-ascii?Q?ixf2Rt/F6I7LFwWowMr41A9bdSLl1KqziZ0WT/rf1fkL7K9JkvKHIg7sIVNM?=
 =?us-ascii?Q?vSZUtA+ISkass+sXjkCGozRvceI6rq0YXSBme/A916GqO2c3zrS/VfQ6eYTz?=
 =?us-ascii?Q?XeiFP99vMg8Un45Z4HGHsx/kJK6Bb6uPEDUHksm70xJGLb3UsZsKwu5U5cqW?=
 =?us-ascii?Q?5R5X58XYM3sSO8s1kgZi1i9YDM00MKDr/te8li5yQ5qBj0OHDCZ4Prihbepa?=
 =?us-ascii?Q?Mt4uCLg7bX6JIAhoTDesuIkMp2TS2P36nxDwfeS9gYYPEcyR5SSbtTPucoBi?=
 =?us-ascii?Q?FxE/V8oUc5aW2fFfKf9vc/NywOxuNOzkl/htHyjbUYyOO8We5WUXevrGW4K3?=
 =?us-ascii?Q?0ShAJtBY9pGv9MOGlft7ErFGHc6E8z6Qwupb+BAYgNpk2n5uL9XoPVPrmULa?=
 =?us-ascii?Q?aChk2mxD/h8x6EDQY0ODfqTgMyHsJywsu6/VY9JZ2v1llmo2eSO/Pkvess41?=
 =?us-ascii?Q?21VeaDfjNx5UYqw0Li3j0pVNvRreY5ltuEBsogeE4A7oY0cfkRs2d4I3+7dw?=
 =?us-ascii?Q?I3fP3czzPTukw3MEjuGg5BF8/RgA+EBIXuZ9c0+tF7QAf5TuJCAF65zPXmwP?=
 =?us-ascii?Q?dVlhfWJ3wyDiZrS9j2rBXEl05i/zbFy6K+zT9tqu6M4mI2Qkqn3y8ScaThyx?=
 =?us-ascii?Q?wWkgBVfW4vBp8EuQsN2IMhkk5L3aDzBpeVULRW/c4R7o8Rvr7AGyIeiODWsK?=
 =?us-ascii?Q?gMVB1kRMv3F1WKxnj6IkGRmJ69I8W2z1fH+14Ce60BXzuuKl+iXDuhxB1f+J?=
 =?us-ascii?Q?9UCEQI2TDStZd+UX4Wk1xuKKytnhfmnsK0YPgS5sABjqLF7dPwECtUAx9C8C?=
 =?us-ascii?Q?ddq8/mlBkWm/OOUrg7IIqxkvtrKUOHhepj97CgS3HT+yi+mfAyavrmtX85HZ?=
 =?us-ascii?Q?EPLuxJscax6zc2dGlsJXpd8EgJtWATo7ugSd64Yr/peKUDlvsUqHvuHx1NTI?=
 =?us-ascii?Q?kmwV194rbJKiyo69+X89Ycw2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 288831d1-39c2-457c-3f14-08d94ad7ee0b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 17:09:12.3227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MRNvSCe0GCV6A7gSGOncQRDxXdhXAqnMuw0c6QoFv7zvVF2Oig7udOuRKpAVzdIQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5174
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 19, 2021 at 04:07:44PM +0000, Chesnokov Gleb wrote:

> The iSCSI socket address does not change.  But the cma_id at the IB
> layer, which is bound to the iSCSI socket, will change.  The problem
> is that the new cma_id is trying to bind to a socket address that is
> still bound to the old cma_id.  That is, before you bind a new
> cma_id to a socket, you must first delete the old one.

So why is iser trying to rebind a listening socket to the same
address? Isn't that the bug here? Just don't do that.

Jason
