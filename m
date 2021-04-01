Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8820351F72
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Apr 2021 21:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbhDATSp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Apr 2021 15:18:45 -0400
Received: from mail-dm3nam07on2048.outbound.protection.outlook.com ([40.107.95.48]:18209
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234062AbhDATRw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Apr 2021 15:17:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GI3OOGEhDvr8z0W7oFQ1grxcM6I0wIUYr9BY3TRvIhguASckfK4drWggll8fs6taLm5ATLoLRro2xGCJR0oSxr2+LzKawAoOICuiQAaeEdO2SZcoI8hqIAeTMQLTu6NkdmJw8rgAUvWzN9N+A8L6aTqJS11GRUNdtDuSMOCy2M4p3dk6PQqZ95qgW/IvBiPhaDisWVrrU+by6VeDPesOCdPPbiG5PSNtPrA1OiE7e7aSNLRr2JXdHs+1jmT7YxR59JTwns+kh4N+o0I6/x0or7ecHodDiJr1z9bwkIQo8+obyTVQfXcb4uQFFaFtoCgFdCZ5Ek/QlrnZHropPRpx4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLEEuh+HVWoAgzB0CHa0uNkH0XpR4vQklNMQ2r4VV+4=;
 b=JcdD1jCHdHKTHijlltACLsA5e2Xd+ZDayUn7W3YxuznG+Vc7PaVhRfdEPiTIPZnl9kUEaNcaQ/6bI53OFtxROsdpMg6h9dGSH5XORoazI1ZmO2DBi/Q7OI9BncjgrAT9jO+MAMl+2pz/UhcBsNWtJwzNZb4AzXCHATEaWDs+5vtNm3cQ319qCK0lq6IAdzeOt1hFRMYwmI5XhykHj3IS4mLpqMLufcdGt35ifiqtSwuDaVfCCPAS2liRs7W4uHXJD42tFoTwHNV3Su4XeNiktLqqRspgj0mYTIcrr89cVHy5Hl7H3gAG2j7TOm15AKoIC3ul7kiDIguc6zIBQazO5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLEEuh+HVWoAgzB0CHa0uNkH0XpR4vQklNMQ2r4VV+4=;
 b=INAZtIUXZenlcSuXOUFgr5v+sEsKaWIfEUT9zNid2nGW/auRwb9CuI6miJL++fyQWz7GqULhVOk8rzKB2RptMGUgJ9nXGZx8K3JxBDqEC7xVGnxsdyMYZnQLFtZQuqop73LkKRL5ovTa9iMefL5uIZ+ykTKdpTDtpqJd/nox2U343Q3AR19g4ebUzZeCp7rY0wMk2H526tEP1BVb0ASbxiRKwckPTt0PdgdLbeMpqOF+NumYGBV7Cn06WkFl3o+b1S5eQpiR2qSZr6iWqNSd9+/wOzIVJj/bIyC6o6/y9DdnzGVc9yC1db/i+IEGAjbOhrzH6paKjG2LCGOvnUl9PA==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1148.namprd12.prod.outlook.com (2603:10b6:3:74::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 1 Apr
 2021 19:17:51 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 19:17:50 +0000
Date:   Thu, 1 Apr 2021 16:17:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 0/2] RDMA/hns: Updates about doorbell
Message-ID: <20210401191749.GA1676497@nvidia.com>
References: <1616840738-7866-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616840738-7866-1-git-send-email-liweihang@huawei.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL0PR1501CA0025.namprd15.prod.outlook.com
 (2603:10b6:207:17::38) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR1501CA0025.namprd15.prod.outlook.com (2603:10b6:207:17::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28 via Frontend Transport; Thu, 1 Apr 2021 19:17:50 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lS2pB-007290-1Z; Thu, 01 Apr 2021 16:17:49 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd969cf8-c7b4-447d-6f5c-08d8f542d794
X-MS-TrafficTypeDiagnostic: DM5PR12MB1148:
X-Microsoft-Antispam-PRVS: <DM5PR12MB11481865299BB9BBFB9A8162C27B9@DM5PR12MB1148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mpFR2eqok8Smc9PadT3pV0xOdEx7XPTfKZR6jZtcBxB8G1sSPsseJzHIjGQAX34vyMQ2YbjV6tZChACSBZ8b/r5vSuO2VJ0GPRBUrHL2um3ziqcp9n5/WAMNIih/OnH6ReDLcjqNNFX7oPnGe20Fdb5dieKzPurBEblDF0uzW1+unIvhYXbLvncXZPXc6dvFF9mqJCSr668lLe/8Ee29FDr56Bdd2BsO7sEdpMAtbvh9BVlQo6xFZJbCn5AklfUxQlGt3IzsmJ8DDAc1TWQEyfkiLC9mCqhkl0xyO7DU0RlNu3HucpFhzeN9IMajNLVee4VPm3faOxuWDC6mL2sqABfgI3p+9MXCJJkDwMy6iRD3JH4gv7vm/nsO/kxsDrY+L6bMlUUvXm6ykmcSI8i3UwaQ1UB7sPJR9/zoGlEg2/H8iPNzYMOLYOBxGpcSEWlAYsabQhS5AOpGiDhQNPNrYaQYZFRANPJIGmzcimoug8Am0hDFB93qTtdQzdKePgNyDoFb3EplIAg6Yy38XyHqxznNxhamU6D9oZslZOAOlgMEZfSo1EX/XAKjh3fgjQKn30GChFNIIIvU7t+/rpmi7CxW7Rsq526inCVN5ECWwpJlVxt90KqTOvAG0DOq4XqxLFAIPatlKPUYjidynu4ec6yrTRbZZKPadxoFwu4Rn1w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(36756003)(4326008)(316002)(15650500001)(478600001)(66946007)(66476007)(5660300002)(1076003)(2906002)(33656002)(66556008)(38100700001)(83380400001)(9786002)(6916009)(8936002)(8676002)(86362001)(426003)(9746002)(186003)(26005)(4744005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?rjLT+PgHAGdatibDlwjTKWtR8/BJJsjsCCoFvrWVbTxYBBEJxG4b7RkgbJMJ?=
 =?us-ascii?Q?aTepTtvUm24lk/ewre5KFkMktbghw7k+Mwiz8GqDVd/xb7Garyy3WScJi2Gm?=
 =?us-ascii?Q?0w2rYAQ897Q0FnKZjOwMr/fODj8nk9J44+UoSofZ2iheXLnsnN8ciIjbEUvN?=
 =?us-ascii?Q?MP5A+Y9586+klD1Z/QWpC+Agi6qWJrEMczd8bHjI/hf/GE1TSoXCnlezWLvW?=
 =?us-ascii?Q?PyzUy3fATiNxeFYXD+506wGHXB1cBxtdU0IEw3P1QOgfSqxO/5hLHfEUk/t5?=
 =?us-ascii?Q?/yaFj4FdlJM6tLsjiAMKgPNABKqgKSxcY8p6340exwKg3tPRwlFOHJuBB/9P?=
 =?us-ascii?Q?UpxCX4oqPim3EnXSizHkJjfemr6puxHZsZLZ+9ylXo4p+fD55AFP0se5gJ7P?=
 =?us-ascii?Q?xuVibB6Jtm+zrcRx+Uj2lkzh+5oY4N8n6w6FZBvFb7DtXN6hQQpZiWU8FBpp?=
 =?us-ascii?Q?7rF1hqjgjSFYSR/7v/CFVPtPUGXmaQApGnbjt6JdIiqtyQilm8TUpPuE3s3R?=
 =?us-ascii?Q?WONgSxNg3rBFkM5mH5OqPhpGIn0IK51WRW1i/SAUqd19LE2ZG+x+QPggFoPw?=
 =?us-ascii?Q?xk5dSTVRH385iuS0+BPI3TSzqUbmbVSe0jaRESRUMyGc5oPGgrEd3bFcFReW?=
 =?us-ascii?Q?OGCtAWHJmaOJUxZRRkav3BO+Ft6SxaAa3BdW2h2LFYDV6WVCuNiE7uW0WZcc?=
 =?us-ascii?Q?i5hpZAXpZAHQTUa+s+6BgUUM6BbfV+KQCoHP4z8EMXgYuhhKr0OyxAXWfcyR?=
 =?us-ascii?Q?vEHpEQSgXiU+CIjgre4fFpbciDmKxSllInNtJ1FEzgI0eU/iyFKOXmjYcSEq?=
 =?us-ascii?Q?5qJauOARYH/9lm5ZYtLOMT+hjQK7C1Mpsrb/pmFFPnSooN/W+wR93wIqhOe7?=
 =?us-ascii?Q?AYSeRyWdbdj7io55l1mJh8+2rbFy+IO6w8IBMoQ2Z7QSJxFDBHV7dCHmph+y?=
 =?us-ascii?Q?J3drQvhMpnVapviUSbQ/vGj9dbvH7O5iQnbcEhx0PrG62Mv3lXa8X0vfE7Q+?=
 =?us-ascii?Q?kaaIjOgxBzoFDtljQSLaLov89Ai/Y0MXx0rnCCjTIDMWcQ8W5MQWzm0aiUbZ?=
 =?us-ascii?Q?56uI4ephMczUcGIObSdjB8qgzUG+4eDiFVnstFkNaM+vHmQm/HvAj5A7OzvF?=
 =?us-ascii?Q?kn/xbndtr7xKjScGppHeCxFPwz/KveASRn3I0LARZr6cG4QIl3uOrHb6xHYr?=
 =?us-ascii?Q?9NZdB2Ht566+33ItzrWReoYyfrF2TvvFM9hRS41IE6Uq3Qh5jKTMK9ZYvNnk?=
 =?us-ascii?Q?aMZpQccLD/sAe/zfv0UCAna8KRbdm6NlviNGVAkHl7MvSAZAPErcIB/Ortyt?=
 =?us-ascii?Q?DVLlND3h6SMZCSaEA5KHndU5WKZtZa9k8VafkGb/EMCGHA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd969cf8-c7b4-447d-6f5c-08d8f542d794
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 19:17:50.8929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CXyUco+3vE5oUci+0aTQowLQavh/I+GV7qdQ+2sxkCsNP7MV825ItBdzZv6Wliz8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1148
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Mar 27, 2021 at 06:25:36PM +0800, Weihang Li wrote:
> This series contains few changes about doorbell of HIP08/09, the first
> patch adds support for normal doorbell, the second one just reorganizes
> code about doorbell.
> 
> Yixian Liu (2):
>   RDMA/hns: Support configuring doorbell mode of RQ and CQ
>   RDMA/hns: Reorganize doorbell update interfaces for all queues

Applied to for-next, thanks

Jason
