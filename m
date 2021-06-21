Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A873AF941
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 01:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhFUX1R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 19:27:17 -0400
Received: from mail-bn7nam10on2044.outbound.protection.outlook.com ([40.107.92.44]:31329
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230130AbhFUX1Q (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Jun 2021 19:27:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4p3aiekTjneRfcO+NfecAK7TzYKQj34asaF3ts1RdGoRomA3b6aYdHJyAULWlngE9jmkTIEmVkSehWapmQLN2fppBNJJOI5JKPd6Kr4wf0iz3y5q9BoIlqZgndcsoVYlJAWhwEEaNACLwnQYjE8UU7ToxvlzJi1xq4zx2CTt9xnYZHwkDIsNxEqY5HbfGtSbss+H3xDSQRkNE8xBPXMalswN3Y+GSxsKA/8PqxWt926y+Rz1FqqPLepQmFlrGBm3pBxCMHvGfFaOFkf9chrqwXwQiqLWGs7Wm9I2wcV/LWVDNEqp6yr74gsubB7CP6kFK6645rR8lV1e6fK6oOg1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6RXk2IdWCPVkOnJ4pR2lJ3bwRIOGrDD7nqlA5iCD+U=;
 b=G/2JhlGxZKrtHGGl9E6KjeqCNkIQfQwO2/oEZDrrNGrqihFev3UiVEBcaId2Atd7L7QNr3cqBVOdOInJ20eEY1GpxTx0O9pL+ZXunFVLtmLNn+9tVPkiO1WH2dv+2WZOtPpz0MRdhEepynSI6fIzJ/ruFgMw2f5UJQGepXzkVGe/t0RXE3Yw8W15bnGgg3hIUSiak2lnll6SZCvk7u+LryjmlHEXAhjCG3oOJJjJ8SArtY7cv5Voefw7RObumtD2qDm7tNDWoPGvSx5wOv//Qu4KCFNawnNS7Kfv20J288NRN25jGF7UoHJSVp4avhl2UUYv2tq74CrRtkxDphXLTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6RXk2IdWCPVkOnJ4pR2lJ3bwRIOGrDD7nqlA5iCD+U=;
 b=CdBhJNTUZ3ypKHMfmN+me1tzh09os9RaMcQI9JKZVQr+7Bvw+WuWREEDp9/r8PQRAF5/Pg6bvhrk8mxhZUbW9zMsleBwWe37oix0VpfJuazuym9PYHe1a8mw93AZpWeg07pLWQ7kpnDOjnndatbECqG5G5QsDkB8Lu9AIWNx3bkUY5mU0bOe9EOFo9EMoVZGJJzOvOFySHYhSjMMD0vRbFhhqZ0TVTa2QnfVkRaYec+uYtNn4VHFCwKo+/ky7drEs7eK0uzaeogFrEffSe8WwNV8p92IMrBWshNxhGuqinPzKYq8ba5zyqjBVKcb5gt4CJ4p8n1wc9zJvPvSmc8W7Q==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5380.namprd12.prod.outlook.com (2603:10b6:208:314::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.23; Mon, 21 Jun
 2021 23:25:00 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 23:25:00 +0000
Date:   Mon, 21 Jun 2021 20:24:59 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, Jiaran Zhang <zhangjiaran@huawei.com>,
        Lang Cheng <chenglang@huawei.com>
Subject: Re: [PATCH RESEND for-next] RDMA/hns: Solve the problem that
 dma_pool is used during the reset
Message-ID: <20210621232459.GA2356494@nvidia.com>
References: <1623404156-50317-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623404156-50317-1-git-send-email-liweihang@huawei.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:208:256::8) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0003.namprd13.prod.outlook.com (2603:10b6:208:256::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.7 via Frontend Transport; Mon, 21 Jun 2021 23:25:00 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lvTHn-009tpn-AM; Mon, 21 Jun 2021 20:24:59 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 051a8e84-71f8-498c-db16-08d9350bca31
X-MS-TrafficTypeDiagnostic: BL1PR12MB5380:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5380B2F84212432E946D9DC0C20A9@BL1PR12MB5380.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fwwlsGQ/G/pVnD72zCQuZIr4wf4p6QwpvKJzj/j1Me2od9FGGe8zZhkAICtF9n1aJ0xlMGsON3ZwWS5eQWsW+XGEMfeWa/i9EBDjkwPRKdtNoUDszzFVtrAxiLwKd8ftglGv4NEf8gEBzN8LocB/9Gq01DYVShjowufS9owvVWMwNfBE87Hy32ezbD0AEb7VAOlGh/cXqiVYEs6bjvfC2m556VI8pq2hTDiSofN3hxfCVujWzQRuwFmN3uiEHPBWfWytuQU7vzYD86Tr0/Z1PNREYffGFAFgh7L6bRPjS0YYPnt74QOyu8lbGhDqt+DUWLMVJlK1WeHlVcovXFd4qgxBJ2GPjB8Aq2jjvSWtow1yEbkljUgm1Pl9Ddix2CA6vL79M3YCdfmi0BOr/468ZVrX0ZHf/W7eU19hjtTmeyExjqZqoqjum6+zmg2rikWi9A1lhx5OjtRLUJNsyu6T8elXAHhxJb6JtgHvtR2VESDZ2VwABqgAL5iN0fAKRVIfj2susTCIjrbxPKIEv/319HSrdtkcC0afYaNoAarWSrlo03Emr4HjCSY/I5qUWa6b4bRnpyk1DNDNxYx7hK5EwsKk0/umjoGWuUwIk1XBSvY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(396003)(39860400002)(376002)(316002)(38100700002)(1076003)(66946007)(2616005)(66556008)(8676002)(54906003)(66476007)(186003)(8936002)(33656002)(6916009)(4326008)(36756003)(4744005)(426003)(5660300002)(478600001)(26005)(9786002)(9746002)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6jZVDMjf30ynMHeHM1EaKYhZehuKuoRYHfhFzDy8G0zimIssqSOSD+55IJUl?=
 =?us-ascii?Q?FhPpvlGXCYXvoje2lf4fjwFv9y/a6+iDcNkV8Z1qpAL89c4AjAMadBGDUzdc?=
 =?us-ascii?Q?y/hAPpacNCdP3sILMfeWx3wX4krMyP/Hq9R5OzozFtPpQ8dNT8gYB0sSzs+H?=
 =?us-ascii?Q?BWcDyrtggBVtnxIZZc8ossJOf7Hn5bslS4jyp305WqSQW3PzqpQTx/XNeOwS?=
 =?us-ascii?Q?u7kVuoq3mUdPgL3Uv9jUllj7HLPVcC8iKY+Z6s6FKm8AFvpIU79sQnX7J4SG?=
 =?us-ascii?Q?SFC1SPQKUm5QZ99c1JVbCEkJz/ULuL3y5We/YNVuiYB6/94QUw9xfXAH9mOv?=
 =?us-ascii?Q?ybnEQxny1PWlHgPQU0UUecjB6qAcZ5F/57wFUttyMJAE4o0jWQBvk4afIs+M?=
 =?us-ascii?Q?LTJgIbt8jf3rjyXWCWLZubN14MncRfPZ85CbRovV6zX+DFsZMrDp2pzZpYbC?=
 =?us-ascii?Q?r7dPUDvursCf8ZeeMp6UkJRacNqaX8ekqLWUKPgwpGNjg0UudJf1ru4SYjd0?=
 =?us-ascii?Q?U2WxqrBvSqgUU5nwQXdqgV2bBkGnEQEzRvB7a8YaKOPtGg9XHcDlV+eoLKH4?=
 =?us-ascii?Q?LD6wV0L2yC6iAHO4AWA6l4/TTJwNaFYEa3H141My9ukt7UisaSTx0DhUqj/a?=
 =?us-ascii?Q?mdWPy9Vvi/egNWhxW8TXbl4BUtechk2KEWtrpUgkuq/b4mNcSecE5TLMCIMO?=
 =?us-ascii?Q?et++c8H+GaSgiKi6CrE7MXIXn/nCNCCKdhL2jYhleowHDL+42JHgejwVaRL5?=
 =?us-ascii?Q?KxpLT18mJ+/aifvCSmkJ1dR9Qdq0/KZH2GVEEAguFT2hORT39fYb1zShoAZb?=
 =?us-ascii?Q?HX4WwkMMy736pIemiVYJydgsO612JlULClPaTtcWSFD6KCNWwM3Vc9snhYey?=
 =?us-ascii?Q?D8NOR9gF+emXYEWCQPMmaKNkkS+zMcKoyZuz5qZHjJGSGL1qOvtFr5h50EvM?=
 =?us-ascii?Q?/zSYQ0ZTdVE3dah7tJdcGf70QoLmKwmcJgeq2A1tFMLbGlCm+bVIj6beW41X?=
 =?us-ascii?Q?2CNZsGiCVDbP+wlwuBn59MAT0VVSbav9o2rYmzxPK0NyuD3KhGbNUmeIZ2WX?=
 =?us-ascii?Q?MGbrKUMmYLdjRSchoIw/z53IL7Z/kvPtFljTxeCEI0Iq+n9ieC65dBFfUvW/?=
 =?us-ascii?Q?/rTVmN7SPZhJr00WQz8KKTL7udZzbIhy7XWmoPyYHgkBvrtprnQqT1rAYCdy?=
 =?us-ascii?Q?HopS50hB68yM1EEiCJf1k70RMZomDOYeoMFUaPqEzvTr5ToWUOzKevjYiAF+?=
 =?us-ascii?Q?cE7SlEDzmUZyIwJiS9T6Cv/n92bpiKPkAuNkseRNcqGbw6GPJ7OJDLTkzpDO?=
 =?us-ascii?Q?CJjNeUII0MKoDIKF2epV/vw5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 051a8e84-71f8-498c-db16-08d9350bca31
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 23:25:00.4047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 16KkHj/6E9XbRThQx1Fy4F/jwiW2vnLSbWiKFQsmTqCBVol9XACQJx6VJ2dT4MzP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5380
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 11, 2021 at 05:35:56PM +0800, Weihang Li wrote:
> From: Jiaran Zhang <zhangjiaran@huawei.com>
> 
> During the reset, the driver calls dma_pool_destroy() to release the
> dma_pool resources. If the dma_pool_free interface is called during the
> modify_qp operation, an exception will occur. The completion
> synchronization mechanism is used to ensure that dma_pool_destroy() is
> executed after the dma_pool_free operation is complete.

This should probably be a simple rwsem instead of faking one up with a
refcount and completion.

The only time you need this pattern is if the code is returning to
userspace, which didn't look like was happening here.

Jason
