Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF193C6749
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jul 2021 02:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbhGMADY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jul 2021 20:03:24 -0400
Received: from mail-dm6nam11on2075.outbound.protection.outlook.com ([40.107.223.75]:11744
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230099AbhGMADX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Jul 2021 20:03:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hL8tT6e2wPF1kVjTdamTrC5C2d1a0JdiyCJuuSa/AbZiMJ9HH6UImHO1Hrpyjuy9MHKT0fmwu2vtmwvf27Y5sRGhYEoMs/RR2r7lFQ+eDMd9CZsdnrqkp9i+5abW5ON3yKGkJkKroFMvSJYX986Cqsbq0sGxJyq+5Rg2UJN4LJ/tQBpVrMrfvPzxD9jnh+VUnPkOP7n7QlNe/mkhEnRg/4UXjY1zmHW9S9NEdT/1zbG0JMVSXVc8+3OEw1IfexrqkBTDMN1xxjuLALWre46fTZYpaKuKBytP4f6/sA0xTWM/8ZmC/Ba81QaiZt+vTM3awaoaKiKq+8UzIVe4U8J75Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdI0oEBRBiDKZTvD9If6Wa7hLg815OsqDP0vNAFwsfQ=;
 b=cAsKyyYoW6DmKaNOeAG2mGtvKUPfLMPe1fov7rjoE5Uqh6KFmk9MrhiwCkCkXNpHz/f2e90VkAI9/i31f5wN4p/FJDfWtc2gnC0RcV3Hgjx/64adzItqd+5G++25D/vxdMj3hUoec4f9BiWhP2FxSU4Fm8oyiS6U+oR7yUfORKeSCMeCWok38R3C8Osk6SGAYeHni9DMCz6GNJ4E/rXeQ08xCc3GhK24+m4AWQlfZnTZdP+9Yok/eA4zaQnnu7DI8RSC0dtbjxclYIWUSgh8oISZIHUAuJl0FUAEsV10oioMEFTbTMepnOOdSm+SmbCJW6igN9m1whA4dM75DFVVKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdI0oEBRBiDKZTvD9If6Wa7hLg815OsqDP0vNAFwsfQ=;
 b=gt9rHbBuWGlIG7unGudrfgFl4aHYRrJZMY6PxleTHbLUTiq4VyaXn7PQ8SOLR19cHNVAEug4b65yqUogyZAfCMnpHLFxGJ0WWfTJVZkpdIzet/LRWdaANBY2wRGecEf+8Xe/pN51FL6oMSqdfgaq4auhVvsngYG2YKPpggKPghpVJ60ac5KnkizRjQS/Qoobtq0nEwma9g8NMxcpb5YlxPeh7UmG09dcYXKZazWYQGh9AjFLWqKBK9viuxbIhcgtxhPXZYOyaFxEAfUkSlj864i+JhBsqKGst2om6+rkGFShutgYGkZXP8PdZc6KHa2+i0qC6lQjbRdLjcsqpErvUA==
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5318.namprd12.prod.outlook.com (2603:10b6:208:31d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19; Tue, 13 Jul
 2021 00:00:33 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%4]) with mapi id 15.20.4308.026; Tue, 13 Jul 2021
 00:00:33 +0000
Date:   Mon, 12 Jul 2021 21:00:30 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Subject: Re: [PATCH for-rc or next 1/2] IB/hfi1: Indicate DMA wait when txq
 is queued for wakeup
Message-ID: <20210713000030.GA136586@nvidia.com>
References: <20210706171942.49902.72880.stgit@awfm-01.cornelisnetworks.com>
 <20210706172345.49902.10221.stgit@awfm-01.cornelisnetworks.com>
 <20210712174214.GA259846@nvidia.com>
 <ddae0dc9-383b-00eb-b6f1-c5d3ba92694a@cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddae0dc9-383b-00eb-b6f1-c5d3ba92694a@cornelisnetworks.com>
X-ClientProxiedBy: YT2PR01CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::8) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT2PR01CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Tue, 13 Jul 2021 00:00:33 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m35qg-001BdG-Q1; Mon, 12 Jul 2021 21:00:30 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2e19db9-ec23-4758-9197-08d945913c41
X-MS-TrafficTypeDiagnostic: BL1PR12MB5318:
X-Microsoft-Antispam-PRVS: <BL1PR12MB531832B7B9A946A3ABEE8988C2149@BL1PR12MB5318.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v2f1sB0hEM7LozWRF2L575HV8f+XIoDYwqB6VNcCqkUD8ToyXl+t8grLMM/bfozBCRK26gAY84dYLYfzH12icOClNWGIf/HsHzXjBp03kClVF8qGG/nn+W/VUvFJuml/LMavmqOVfqUriCkDLmVn3VoDsUry1QQrelRKixC+NZjWwRubPWk/3ND5jt5c30BoDfZS7XsOHr7oK8KRqPRIr9+M0+/5bt0RktN7qZIAG3v4gcrJkiF8WjExOY4nZUE1HitcIUzBSSeTtpyLV+pEqOrlcbmKNLKgs7JJNdgA5KCmK10Z2BGi9QJAy7tT1UxhMhl2wbi/gSkbvsCI0DV5phu+UM6BTU4dXcNJyF1TshS8TZreOucmB07WWwKvWUg3wOJG6V+ELLqAoP4r2SsEXAojzL7UPu57isi6NKsCZj7k9E/y6QJ3OYJFPFohzFlnFKYCxwqmM1/qkjOIVDPljeWrAyVo3LrZCjsgPFI6RM438YmHMehYyOUwf9ze8u3M5oJ4G4TW+534yeh3bkWpofGPL6BPcXcncR15033ngc/+K6KFEDXioPtTMfDHVu2UHsJe+UpS3owd55upLK1sInNVnvHHxZ6RHEL0lxqxKVF42SCvmGO+l8mJ4DWBfgcwmHccA8X+yUvr8wnvv5XbYR8hQlEQWtDM5NNby30MoiiWl3/N4uDMvSnkKiqGntoQQloDCSTVbi+t1EKONMAOow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39850400004)(346002)(136003)(366004)(396003)(6916009)(5660300002)(4744005)(1076003)(66476007)(86362001)(66556008)(66946007)(2906002)(478600001)(38100700002)(316002)(9746002)(9786002)(4326008)(8676002)(2616005)(33656002)(426003)(8936002)(26005)(53546011)(186003)(36756003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n22zg8OjvgIVa5oCv/zOZimjM26upJORNor+0CKM7l1z0sta0pw67fC1sAMC?=
 =?us-ascii?Q?mF8LCoHkNi4lb4zyV9rYbC0PUf9MvY2UaqSUOas3Q86w6Si0ZxKiax3yXs1x?=
 =?us-ascii?Q?BjusS8FlkvWz6WgoMQUFYNA4QNaA6cmBN0kTFInmtVjohhd0VGs2GVTJz3ZK?=
 =?us-ascii?Q?Mk1xUaB9LQ6afg3cwKAXX+3hQM8fgYpegHWWkh4c2QSWuDPqlxy6/qBTnC31?=
 =?us-ascii?Q?hAmaGISu7cFZCzCHDbVaJ59CnnvAp8TzWTYF9SSJIkrCATcAFqXz97IcAnn8?=
 =?us-ascii?Q?BvISfuWKlNRSBc0tOBqZXHLNGDPbNdZ01uxUAqLJQeWyhgvaR1PGSHP/EgOE?=
 =?us-ascii?Q?+Lh5rUgPPa1tthsB2DaHrVVANP4fph0d6Rg++MJUApLTiQYsPHEoA3DhmqTU?=
 =?us-ascii?Q?KvQeJ5XkSCsn5mQhHzeXNvHZq/M1hxhuJoZ+G4EpbASutJns5MZgTNRk4LKX?=
 =?us-ascii?Q?aIfJ/Jc0X/9K4q3ESR4eKrLGlj4SybTYqW5ig9kJQnmHyE4adZj8s/JUHsta?=
 =?us-ascii?Q?kd9qToETp/NEatuaaaYjg0eyog6y8rAav3Ftrkyro+OuwPvuL111qdjcUnnN?=
 =?us-ascii?Q?l6FYkSZo8dtdkx79Q0RvOP3uDYsNN9H1Ro4FoY65G03cKg5qmFJ8vicFAL0r?=
 =?us-ascii?Q?e2fc4NaV+wSP0QqUdVR7FDBFs88+rRizlBPDcchWvkIBKVl/NUELmwOEt4ck?=
 =?us-ascii?Q?Nng+yVaSiD+Dw4QRVNqtt5eJbiBWaIWZveFIFTwRz62FlDSOFxWLlwaMRjmU?=
 =?us-ascii?Q?JOsKpv0u3U+cH0DVp0br57aJRRyWkbTLVd2QDkmpwer8C9FOx1iqYWkh95dO?=
 =?us-ascii?Q?Rgx6sfEwSsgZbblaGUF9df2HQ8yPU/XXqzT7tOWv6nnX5c5MSDRFAXqyCFH+?=
 =?us-ascii?Q?QP1181y6vKey7yLfZG7dZRoXoUiPmZ733oo0NNvzr5wumS38f/OBDXoLHtt5?=
 =?us-ascii?Q?oBOTBlCC5JLETVQx97GUzkEv6v+DjdjTEl8giVEQqjXdVWIFJbUMJrlzViQo?=
 =?us-ascii?Q?Vnx8C8vf+q2VYPyCjmJh+uP4BrZFQsnC8LIKIoMldUlSTcJxlija59CsFZ81?=
 =?us-ascii?Q?+egrRph5DDlQs7TryKbowO7Gpcno9l3M/eQhB44nsRUhbVn7/uHus5x6N3xL?=
 =?us-ascii?Q?MXTBwl8bTDql2uJx7FfpLO/4S30V4Yxn7kWBmRJOaliNaAWG8LlC/FB/Gyyd?=
 =?us-ascii?Q?oaTRMRfNk9/q6LL8tNsQDt/BNVssWcd+rv7Hxzqc+0LMWrjKWHtIFYmfRQfV?=
 =?us-ascii?Q?z+tGWbs4Hx545PrKI8pKBNCVkf+ci5LrILZld/5g0A+ggLo+ZnvZry12nejo?=
 =?us-ascii?Q?x95gPx5CFRJz55GFVunL1H0g?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e19db9-ec23-4758-9197-08d945913c41
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 00:00:33.5101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uv9Xi4bBCK3UsAFka4ggHeixSYJd2Z2A0Wbe8nrLG/cMdXQuzkt9q5HGnIQEe1aE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5318
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 12, 2021 at 03:33:37PM -0400, Dennis Dalessandro wrote:
> On 7/12/21 1:42 PM, Jason Gunthorpe wrote:
> > On Tue, Jul 06, 2021 at 01:23:45PM -0400, Dennis Dalessandro wrote:
> >> From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> >>
> >> There is no counter for dmawait in AIP, which hampers debugging
> >> performance issues.
> >>
> >> Add the counter increment when the txq is queued.
> >>
> >> Fixes: d99dc602e2a5 ("IB/hfi1: Add functions to transmit datagram ipoib packets")
> >> Fixes: c4cf5688ea69 ("IB/hfi1: Indicate DMA wait when txq is queued for wakeup")
> > 
> > Neither of these fixes lines are correct, please resend it with
> > correct fixes lines.
> 
> I believe the thinking is these are fixes that should have had the counter in
> the first place.

$ git describe --contains c4cf5688ea69
Could not get sha1 for c4cf5688ea69. Skipping.

Jason
