Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDDC3BC1A2
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Jul 2021 18:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhGEQ3I (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Jul 2021 12:29:08 -0400
Received: from mail-dm6nam11on2068.outbound.protection.outlook.com ([40.107.223.68]:56577
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229495AbhGEQ3H (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 5 Jul 2021 12:29:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpJocp9EY7x2PXwWiSHCw0rUy0CjzijYhYckEtERHKOXt+w1v0PRZP7hVx34/WsrZ8A0SLej4TIWyiqi1SmzHIFUf3KH9aD7a6wS2SqlX4vzY4lW45CWMhMhET6piQ8rLl1fgGW2XKqcmxM2fldZUshYhDOO0OJY0+jQxU16/D92MKikHarcD5QOgxRiHrFYAAAXk0xig+sC8oUkKvQ0KKGf+v/sLC20iviV6RFyPCJSHWdWhrE4QSyVpIqSF/A5e1l+2LpuWB985k45J+MfEx2Ly75Yv5NUXcSRcbfuwnQkrGvBJNPYvJQ96QP/w0gBn7aIuPCCpaVbqJ+Hv//dhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LFTaIaVFW9FxzX4OV4he9rL6NBUvz4GRKiTMtqijx0=;
 b=DmqPoKCha9hu6uSvQ1w5/HzkqKJ3hyPtJZQsRUkqTgzCumBmlBN/Jp/kxjpF7jtm3/1DAkLd6oAziszGlswZEZshE4C1xfmTK3yTPUcunr/oe15FXxPttDTdyIxPtGGj8VRwU+b1KFWMddcFltlcQHfQuQPyod9I4wHkO/Oe00E20Or8Rquh2RjBKJ5q4JUjUnrzS3udSeyrFt2Dh64Dlb+tLqVL0k4RC1JzOyfrf0rt9h4jOyrb4uH60KI/I3OukbcMGgTsxIutN29a7sG0auKJgw2/1JgGbh3xvFttpG+snZpQqPbbNRbpDRQJRW5B4TGuqT6K2rLR/jYpHOgUdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LFTaIaVFW9FxzX4OV4he9rL6NBUvz4GRKiTMtqijx0=;
 b=PJ2Gb6vo/z7mfq4hfq9mbSBhqx2uZIWsrQScMAvqtlugPvdqXYCc/kphSDBXQaEJfZhUuYFZRxDk0s+XwEpCoMifnmYIAcTmeAuSRPJz01TBo/f0KSNSXR7PQz3V5UEmAtzMd4zEV9CXiQ7VgZpxJ2Witm+iQKD4QdDxBaPwRLMNIwxNoRmbkHdXdac3Q+63EbdjVqrdwnTr6KVCw+F4op3LIYEtunYSwxMouAQGdFvykgJ2V2U9/qYnkS5SNvElK3TNFWNGsTR+aqtrmtqpHe5iaBfWqSEcK/YMxB+hOSfEfJFraIVnlD7KldBIJXQu3lsklz5ziSpssgoJ7u6ikw==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5029.namprd12.prod.outlook.com (2603:10b6:208:310::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21; Mon, 5 Jul
 2021 16:26:29 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%4]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 16:26:29 +0000
Date:   Mon, 5 Jul 2021 13:26:28 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-rc] IB/cma: Fix false P_Key mismatch messages
Message-ID: <20210705162628.GT4459@nvidia.com>
References: <1620219241-24979-1-git-send-email-haakon.bugge@oracle.com>
 <20210510170433.GA1104569@nvidia.com>
 <C0356652-53D1-4B24-8A8D-4D1D8BE09F6F@oracle.com>
 <20210510191249.GF1002214@nvidia.com>
 <01577491-B089-4127-9E34-0C13AAE2E026@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01577491-B089-4127-9E34-0C13AAE2E026@oracle.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR02CA0097.namprd02.prod.outlook.com
 (2603:10b6:208:51::38) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR02CA0097.namprd02.prod.outlook.com (2603:10b6:208:51::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.31 via Frontend Transport; Mon, 5 Jul 2021 16:26:29 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m0RQS-003rb7-9F; Mon, 05 Jul 2021 13:26:28 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9482611c-fe32-4662-df4c-08d93fd1a493
X-MS-TrafficTypeDiagnostic: BL1PR12MB5029:
X-Microsoft-Antispam-PRVS: <BL1PR12MB50291B2197EF1E4A19CA8A73C21C9@BL1PR12MB5029.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Buwevb/oBWaWqOfFNQOa7bX3tB7EyKneF86pmCtkEKzchc8FhWf853pX/5TaDGBs2yklsWl7RXWq5v608Ew+Wv4rtbJ+5P5AS7Uxj2XajWk/Y2ECe7BmUfdl9F6lepkFj9p6QepzaJf2UbTPpzN8Y9/3REhD7x3x7tm2sJswk5tKAlU3cHKgPmfloiqLlFvKKNcFopFD3WgFTKXgvT8vxjFQMcO0vNKeNTyqntfNN3zKKN30+0s+9TIPV+oL7k8TNaqYKiuMuLkGPftyEmX4zYuKuyUn/ybmTmHembrvn4M9cw77vssYslYNqIyGd9jev0uwy30oF4zTNSSrNwPJRR5aO3EVQIj+EDDKVAGKOjjRGkrLPT18wm6NRArswc+yNrI8HgV5tLLZVhHdoF9elTWlFRwLOyDYNzTaCK3pUf3wiPscYkRXJ60C5z8Xvfr2NTwN7rQWi60jwqKVo+Fpikr56OYASu+tG+n/CYm3C3p1qf37SepwmNfO1ivYtCTyQIHnDPsCQr+x64/mKvpMM5aFOWHnB6IxoSGJWIOjth7fZAbRLyxfNmmM8GL6SqAsCLTPdxSe++d5PbZscCbbZvAB63HDXtcROz+Mcsm7xnRSsUMXy59b+bL8++XGuR/ByVf51Bf8mFLql4R/Ifk8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(8936002)(83380400001)(33656002)(36756003)(5660300002)(8676002)(86362001)(15650500001)(66946007)(26005)(2616005)(38100700002)(186003)(6916009)(478600001)(66556008)(66476007)(1076003)(2906002)(9746002)(316002)(4326008)(9786002)(54906003)(426003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HvHPYGtjISsKP2Ts1rxafgWBz3wHW3UhWlBssuPLve+I3TbCckXNfAc7EaH6?=
 =?us-ascii?Q?kkPS0PcFAygvPqXkOpxF2L6Cpo5V756K9eKs6Eyzp/C00w8HAjI1YcpYd6kE?=
 =?us-ascii?Q?1T1mtfmVKyEfA6OGwDqBh4VFPDqTwvqHdwLXgCg1HhLIBx0XmoPVCpJgJvcu?=
 =?us-ascii?Q?lRvToJ+vPiLpdNkTA2rTRqAsq8QOcVEOcooLogYU5SXRNRy41Z80ovenyNcs?=
 =?us-ascii?Q?2NMByo3eX5QRHiab353qEtp7zqbBRe8REkWUo50VzqDVL2X1OMU5lscZi3pD?=
 =?us-ascii?Q?7OHS19ZVW58ASjYMKY+85AVb427Ux7SsUNR5D+xR+INFlDVBN9HR1XFjX8kf?=
 =?us-ascii?Q?ewxO2qVjN+Da5e9Ccnnh30O/C2KXDmAASDs7ZCIqWupr7/VhJC4pD4wxH3Es?=
 =?us-ascii?Q?BpBSovfmrPS1g2V2QKkjhMrJRijjC3Tku6+rByRH/lExDTCRNdgSIHi5B7m2?=
 =?us-ascii?Q?rtAg+UV12Nat0JW3G/a3YBEdAKcfA35BYRWZqCZEWzzWAYQYnGlT079tRV70?=
 =?us-ascii?Q?WL9S/Z57GC/2VKhpjNtHHEtTjW8Znw5CuTXzEFk2UQ3Z/mnjjlQjf8+edudW?=
 =?us-ascii?Q?9TD9WTx4gFj56hIBNcIDHurxleTMFV9s/E6DYWjCFzcNx/X3xmUafABHm3F2?=
 =?us-ascii?Q?QI4i8sEqOvXil0fx/fLE3mBObXfcRpEHqEc8BI0h/md9GP8SzkhBV2zu8Cd6?=
 =?us-ascii?Q?fHavXiuTkSlbDiadBy9AlNSzMkzOfRUcorm1zf6n/Ix/ehlON22F57quA8HZ?=
 =?us-ascii?Q?WXQYBBPwVQomf4LWP5vqYyB1thW4VzIdyFu0y/OUtuGB3DrdubcbDVLYFqrn?=
 =?us-ascii?Q?MAzOaq/ReYXIz1e1WrO+z0veM+YUKdB1ad8yH26240zYgiTQ9onu7Ntzm4Rv?=
 =?us-ascii?Q?3V9Fz458RZAIl2GkYLT7nClGX+m15MO9Bo5liQy5tcHm5r2hgrCAwoF+zWjU?=
 =?us-ascii?Q?MCYNHxRYvzQ8YR4okjtzbiaWoUzdrhxpHe/OUdluTyATTp2C1dOZ4MWnuhU4?=
 =?us-ascii?Q?1EkoH8/UlCzvmCO3Z88/PzxgnKqHyd6BxAqxnXlIqCO87tzZ221s4w76l9G1?=
 =?us-ascii?Q?SiTFegeVLFS0m6aWZVqDMFlkcQu77GRtR4LJBTaB2fUHzEm524PTxgNyyK49?=
 =?us-ascii?Q?WQVsKiBl4dwliplPE4qC/8xGCOSRyT6/5XOfLtRj+w6G6PTxoz7ih6NgGJJb?=
 =?us-ascii?Q?aCzt6y0FwX2sPIvB8gpW7PbqMAA+RIT+U67EbnDcqRgOZBQBhxVKwKbRZrZD?=
 =?us-ascii?Q?vl3ABWPsBXc0O23jL8YK5w7GaP3gQ/cccjZ7EPtuxFkjzH+cF1e1rVdFcRl0?=
 =?us-ascii?Q?fNqWgI+2nQSCmVJLXTEz7SM3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9482611c-fe32-4662-df4c-08d93fd1a493
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2021 16:26:29.3317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KUE8ENgkESQZB7VwAgasVZKJJjviqYqqwFMqnQ7OxRt35oYYEDKKikFg0TbLMlqd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5029
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 29, 2021 at 01:45:35PM +0000, Haakon Bugge wrote:

> >>> IMHO it is a bug on the sender side to send GMPs to use a pkey that
> >>> doesn't exactly match the data path pkey.
> >> 
> >> The active connector calls ib_addr_get_pkey(). This function
> >> extracts the pkey from byte 8/9 in the device's bcast
> >> address. However, RFC 4391 explicitly states:
> > 
> > pkeys in CM come only from path records that the SM returns, the above
> > should only be used to feed into a path record query which could then
> > return back a limited pkey.
> > 
> > Everything thereafter should use the SM's version of the pkey.
>
> Revisiting this. I think I mis-interpreted the scenario that led to
> the P_Key mismatch messages.
> 
> The CM retrieves the pkey_index that matched the P_Key in the BTH
> (cm_get_bth_pkey()) and thereafter calls ib_get_cached_pkey() to get
> the P_Key value of the particular pkey_index.
> 
> Assume a full-member sends a REQ. In that case, both P_Keys (BTH and
> primary path_rec) are full. Further, assume the recipient is only a
> limited member. Since full and limited members of the same partition
> are eligible to communicate, the P_Key retrieved by
> cm_get_bth_pkey() will be the limited one.

It is incorrect for the issuer of the REQ to put a full pkey in the
REQ message when the target is a limited member.

The CM model in IB has the target fully under the control of the
initiator, and it is up to the initiator to ask the SM how the target
should generate its return traffic. The SM is reponsible to say that
limited->full communication is done using the limited pkey.

The initiator is reponsible to place that limited pkey in the REQ
message.

Somewhere in your system this isn't happening properly, and it is a
bug that the CM is correctly identifying.

Jason
