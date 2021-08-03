Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82123DF1EA
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Aug 2021 17:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237138AbhHCP62 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Aug 2021 11:58:28 -0400
Received: from mail-dm6nam08on2048.outbound.protection.outlook.com ([40.107.102.48]:61792
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237133AbhHCP62 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 3 Aug 2021 11:58:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAPhGDO2qqnVx3YqaQcPEEXRijuAKSIe/rAtqrEdm6M9qdnQRd5ibMus6cf8OCW8EtwOn+5kjn3kdXqpwgnXUiIvy0WArF3DJHs55kUrmP16HELt2rooK7CtOU93IMYbYG3SMom3sqZaqTOBpkDzdwyOZx18JpEdFmSY3uWA27BujAXzKoFa4CN7vwfRsD0wgDxtesvBM7x24kW56TaEJlt2Qd0jafBVKtmucl23qN5Hu0+nQuRkDTuBYdVYXxuOEZi4/cLraXddRVdFCZbVSHdSzMZJsL1DmO6B5MwcWSZGSSQM8zkiTqCrNtmRqOlhlXWxKjVzgBDD/kngw5qabQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWFYaIDaovEXA8ly4z3n9ufxsF3LllY/iI5qnvh8qw0=;
 b=E0HTVQzy+PClCi+zAfjysxMaySSKNAnBGnWBWFX4VzhZmtRl+b/yDo6xOZGOR8HShEYkIRb5Dz8SYzIRLUWG1CAklnDTJl5HFo2ghgydYKT6r0J05JxDVh5FzVORdUretYYcZ8Pw31OijWHzHhl6YWn6HoqTBEV1F87UBQC1Eq8kk2yAc5NHS1H/S5Y5fLJ/ec6HZbClK0CaELo1yNplXEyZQGhcKqPobGqF9LC1Qr1y1kAKeWaKJUOjhkFGgmnRVoojpsGE/0mF1yeWlo+wOsCY9IUS4hpA6SqHSHYLEwVgZY6Z8FjPsa3Y6p22ePhjIqp6Nu5H/blmsejVMbpQBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWFYaIDaovEXA8ly4z3n9ufxsF3LllY/iI5qnvh8qw0=;
 b=IJV4AkCaP6EvTlNGn+9BBw/ZY0gb3JftXBEpfJtefcQnB5RG3h9TreQ/OET8MRJLX8UOfOJNlGO1ZWFb257bhiBsNgxB6g3PU0bPvyzIKaBTVnYzDikgVN8Y/a8OfFDqMepZLgWoiGk+9d9JOek2D7UzbDMB+Hxm5NE+nKm8crs0s4BcM3x7yGI3cSUhU2Cliv/wpOU1fOlbgablw4OxUSTQyrp90o0zDDyWU1QoAug640OOen0tReIwInVjkYCj8mCzEDGzFC5gNvwJDtPLX/J8YqLfGI+R6o0UDxelAeQFi7axVgVoIwtXVSXRHszqx5CjSNtnHKxaOrvda0mkew==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5078.namprd12.prod.outlook.com (2603:10b6:208:313::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 3 Aug
 2021 15:58:16 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 15:58:16 +0000
Date:   Tue, 3 Aug 2021 12:58:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2 0/3] Three rxe bug fixes
Message-ID: <20210803155814.GC2886223@nvidia.com>
References: <20210729220039.18549-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729220039.18549-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR16CA0038.namprd16.prod.outlook.com
 (2603:10b6:208:234::7) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR16CA0038.namprd16.prod.outlook.com (2603:10b6:208:234::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Tue, 3 Aug 2021 15:58:15 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mAwo2-00C6si-S7; Tue, 03 Aug 2021 12:58:14 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55b84300-9439-4bfb-8c85-08d956978148
X-MS-TrafficTypeDiagnostic: BL1PR12MB5078:
X-Microsoft-Antispam-PRVS: <BL1PR12MB50781C83EC1AE1BBD0DA01F5C2F09@BL1PR12MB5078.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VcHotxHVGRsgJImFhP/hODnEW77hgr00/of+H0jcpzXEWcjUG4U6G76bNYKFKiHKH99cLPZb4FdYUXq67eiFrSnRFzdHLK+LQwQBN8IzSp8q4bn2+TLzK8fAA/kylGvGNnSFOCXeXJ5uhbEtE87AJRnSrglcdNSrTZ6iL/FnrtwxRu8+URDuxYM+6xoej8h1bS/WiZIbT2OU3UJG2QNnZGaJMcQIp8EvlZuk8UC3BgnE30W7WOd67bHcAgfD/2EB3cf6a46JpyiPtWw6rzD6IkuIIhSploVrzIYFXeqnB2W+7xlAHmmQeCQqzYzIzpdRDrKaVTwZVoXR0sTgzDr6Q3vW1NWRcJaUxtkrQYG/UKjoJteG1UnGBDWabu5nMzH6oxyYwQeTfKAtxFWM5ARBqTWQNCuRX0PR4rW7Ahan2jAiT9wcDsVwhip3uQuGB+mZWKlSP5bUi2juHmjVLn+LS6l+8ke+g6dZam6LNxWNPziz0FHdpcQOcMzGP+rzwqu1QTZu8xaV34v6Slz6ACGA0gXZgtivI68jMbSu45OpWilIdlvg+kpMKQysIpt0ICQB4Ms9LcCOjtEnSpUCeL1E/YxzJGmkhigcYtZ3O5vtLeLeTEUCWlqcPkOwtEAAPZoCKxnykAns4tZi8w+YUQu4vA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(36756003)(186003)(26005)(426003)(9786002)(9746002)(2616005)(316002)(38100700002)(86362001)(33656002)(4744005)(1076003)(2906002)(478600001)(66946007)(4326008)(6916009)(66476007)(5660300002)(8936002)(66556008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tPeDwbxYkaaKPBvgWn5wP9x7GX0iI+heCUgGMc5Bx+13o0fBjxEKwZLO6j0F?=
 =?us-ascii?Q?juBdyJ7QF0I3jF4epRhSp/Fr5J2JoKhNMG3ZGmD+Hb4umVdyM2YqQTowP7cb?=
 =?us-ascii?Q?ql/+UFVG5lxY28sPB5WJ/TPFx5j3TcC8bIkjPDWbFdbEanwbJaCqqSMDG3+6?=
 =?us-ascii?Q?wYLGh2P7itBJzS+VW9w5Q6sZghkI65+0nclr3cqbRkcJ7zldD98sJyXMHGZY?=
 =?us-ascii?Q?CaBQvP5z6SY8/uUmaTkSwSk9TlPZZacQW2Ax9sJmhWQBNvLAk+fAz1M2EAqS?=
 =?us-ascii?Q?UXHHw9yU0dd3ZmLBw5dhK87ByZ4Hzt1SBCqip2H8QwzuRdSgQC/5MG4pUwyY?=
 =?us-ascii?Q?7GDeRKMi0Aq2mpCtOGrkgs3RS5HNMIZRQZFHhhs13Ol7sPaWHSAxYAULWXhH?=
 =?us-ascii?Q?x2PEerEZly7+ckbdYxmCmJEjxpxQ9jP48u631Zm319Wl47KivxN9DhrR6UG7?=
 =?us-ascii?Q?QlFp97dWfUGgxCtZvxCjeMgYRGG061vWg/5MZ27YfcenftKE3nHET4KkjAHx?=
 =?us-ascii?Q?ovjEAJXO5/7oiYK0NO9J/AcWZeZjmEoLFKoN2FHV9kmwBDTCc1Zlhac0hM4g?=
 =?us-ascii?Q?2Sr5aFtCehTd3kYRmEt+x51QyKDCh/e18OvN4d1vQ60zDMu7BNX8PyGTwbgc?=
 =?us-ascii?Q?1jsfF65g+nEzai8QqG+Kb72HgchTU/yYJ1hFB8vBdgy75Owc1TXSe8A82t7V?=
 =?us-ascii?Q?SrMXz4ik9OFaUyEWPJ+9z5L+p/8/k1HXFSRibXHUH9O+KeaEmw5dCNBRz5tM?=
 =?us-ascii?Q?SD+c7ZVfKu0AcAXepAmEa9ZgQPDXOPG0T7yItOKeosseZq2OqAtYyZNSOhWM?=
 =?us-ascii?Q?ljqJYSrq59/jm5AIRTcKU/mg2ZVe1Aeq8RHGZYGFZVo1JhiHkrfN+BaRjVAe?=
 =?us-ascii?Q?5EgLZJ+d8wZxGPAQKoC3/k439h1i38aNuM1LDvYspHSU/G+sOtQMguxSC+za?=
 =?us-ascii?Q?OLhQY4KeNRnvs/MSvXwSRYuvdO8PzpzR8P3cH6PvCiSUZqN+8rtTuFuA+KdS?=
 =?us-ascii?Q?Cit1CGJ63UwV1PYoXNuMQy4PQaZb68xNvbLQ2VIy6455Ei/eGSWGJODthB6N?=
 =?us-ascii?Q?SxL0S1H1X28Qp4zSP57/Q7rYGHWHTOt7z/CsBK2UY7BeymcoDyQNsESO1Mrn?=
 =?us-ascii?Q?2LGX9XiOcIW0Y5fjo86Wz6aBGhCw1FTavG74m4zFuw5sxWh2geEd1KBCrqP5?=
 =?us-ascii?Q?5fr4HKFGpjdWB7sYh6KwBQCZepOxCT29ANvv/NrjQH8OdP7mVwwCPe3Wc/rD?=
 =?us-ascii?Q?LmKo8SV0iBntjoJ56yJ5o4Ex/3JhkppRDE6PQAk20Dzyc3dbry6TAsID1Z5y?=
 =?us-ascii?Q?LhgGRPAPaJLeUlWJ+k9zwRfI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b84300-9439-4bfb-8c85-08d956978148
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 15:58:16.1071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DiARgCzh2vh7EU4sVDMLnE3JOo83e36DY26rH7y5du2/XuzFwsu9qzJ61T5q+U26
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5078
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 29, 2021 at 05:00:37PM -0500, Bob Pearson wrote:
> These patches fix three bugs currently in the rxe driver.
> One of these was released earlier. In this v2 version two other bug
> fixes are added.
> 
> Bob Pearson (3):
>   RDMA/rxe: Fix bug in get_srq_wqe() in rxe_resp.c
>   RDMA/rxe: Fix bug in rxe_net.c

I fixed these up and applied them to for-rc

Please be careful that the fixes lines are correct and subjects should
be self descriptive not 'fix a bug in x'

>   RDMA/rxe: Add memory barriers to kernel queues

This one can go to for-next

Jason
