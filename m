Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924774400A0
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Oct 2021 18:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbhJ2QyF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Oct 2021 12:54:05 -0400
Received: from mail-bn8nam12on2058.outbound.protection.outlook.com ([40.107.237.58]:11373
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229826AbhJ2QyF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 29 Oct 2021 12:54:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4iOmqfJbMjJtqpoGdcFnGGATEkXMjKjwwlUnvFEVSpSpjblSh4j+yLfWKdqfgCeDddtDn+w/7Yrz5wv78UsDPHSdDZeRDZmcOjbWsOl1z5FjVWGc2yYNUYC1Hkmpkqe7KeHvqaS1yg/xCS3e4whB1o1v3nRNp5W+uGQQAHoOLU1jDoYesbdbuLVdMUsgTanlDMfQA5/2hNki2KEB4xvuXvDzkV2/MiZnfiK7eA0dwuWWTs/q4NhWjIkbagsW37sqRLO5Ow4e2ugI+zaw4Slp+YwNHrtHB7pJ41nntI93fNT09fJfm5UdlNFnjmDxqTfdXWSMGny4Vs2SvgD1qoAHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qAibrRASYPi0pQU+g3u9ZJqdzvKAAuXpO73EFr3t/J4=;
 b=CKdu1nUjGRqX15orYQWX7u4urCr1p63Z5jNZWgJZ0bJ7rr+c5Jqm8sHA7S+QooSr/Uxxvxwm3ZbYK6jZQxCWdhRT6XcuOD9aJ8Q8ZK+uDpnB5owe7/AvkbBFy7xeQIvDrM3p2n0n7PdzBtCksSJuXxLAkuCI1kYx6dKipg8tQr0PicVN68E8oqKNknYiuWeW/lT4Y7DOkt+zC1AQ1ulzg/z0uYjhiv+UjKIKkbDrDHCFDj4IFO9UUy+chEZOC8kaY4c2aAwQf63SHKG0woenNyWbWjcos12dhShgImx8K8jOUWhpKAeKoQnpXLHWM4h9+C5kHA+ix2EGSXXDcJFR4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAibrRASYPi0pQU+g3u9ZJqdzvKAAuXpO73EFr3t/J4=;
 b=EtXtrIt7RldMBCPSXl4MYy0CLu82s03n1/Qt5MFW9Q9BlSLr42Ar1axhztqdFZtYjZG2uPuddq2B/E7aXo/fHJO1I7ITC26JVYRW7iRYxB55CFsfVWn4MoEQZtKC1cnDzaCzg+mLgL1UG9dSHGvfdMfLJN0IfVbl3CYcIKDjWyp5prtB/JBhM5CQY8ijgo5EX0rAU0pVZA0tZYlFRU/KTTm9xIvbYDIrTsfAKYU+CAKwZ6SBbMvwxMsXjxjWb/r4yWQjhkEXzbbmL7baSEhrDEEwky7nU3Az+4BvYdQUHxsOLBn8BPKniWdpHXpU7IQ8CBXRVPDfqh9yboAwQxM4fw==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Fri, 29 Oct
 2021 16:51:35 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 16:51:35 +0000
Date:   Fri, 29 Oct 2021 13:51:33 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Aharon Landau <aharonl@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/core: Rely on vendors to set right IOVA
Message-ID: <20211029165133.GA853005@nvidia.com>
References: <4b0a31bbc372842613286a10d7a8cbb0ee6069c7.1635400472.git.leonro@nvidia.com>
 <20211029162702.GA846504@nvidia.com>
 <YXwmXef41U32Z6nO@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXwmXef41U32Z6nO@unreal>
X-ClientProxiedBy: MN2PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:208:160::36) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR13CA0023.namprd13.prod.outlook.com (2603:10b6:208:160::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.5 via Frontend Transport; Fri, 29 Oct 2021 16:51:35 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mgV6L-003Zv9-Na; Fri, 29 Oct 2021 13:51:33 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 083a53a4-3fa5-4c1e-db04-08d99afc5e13
X-MS-TrafficTypeDiagnostic: BL0PR12MB5506:
X-Microsoft-Antispam-PRVS: <BL0PR12MB55063635373FC596660B4708C2879@BL0PR12MB5506.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:126;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 72rT0pryAFCeE/d+F2RpXwzODyng9HQU7nk7VkJ/NKw3WERCE6Wh3BzygPyqEaoC2J123mEdPyU9kTAIrvBuWsSJ4A4rb5X4MTCoftZUGh4Mf48+cDnKDAJ1cyL4yjxoMNHq8PAV/olygXOKkm0dp9C5rhtD69ttG9QS1BeG2XSgtFC1HpMFGm/siwylgSUzCqtSmIcqxbZW/FsZddNvzC/IbK+jeI/iddAnP9/iaRErGAZLQ/KBFzn5zYlhV+G0XmP2rJfr7pfdTYZHszUjaGxoWlz4medVuS7ktQmo7aZsK8Cxe11cTQ/OTWj3hmGyjg8QGQfj4dtUGN6QKIXxWPLxldjOWDNGDI243qUugUJJke47+h302YQyWD1sw24WHPBGq8kytHEPj/NgZed2BA9C1qOgqW/HYFVpj4Z6QziNnfY9SnTbUvOLvwpLQeKyZcK0o6EMpT2hNWuiHH6f2KfV/6ZvHr18+MPOv/KEhc/E+Z5ABZ6Cnb+E1ksN13t/L1X6tUK+mNG/mkXRR4y1DxpBsMs1UQYl6YKT4xifbFEmUWNj1oTmMy0HrPWX6Ds9FRHUoEgS/jMvplGz0Dfu1lQzJgq3cfAvCKGSU9mQGn1BfmJYjpvuFTe7WeH1mOZbW+4gdg2ELKN9LU2oSW2OQ5Yg2BJs31sYa1Vr+EfCIS6gSQFKh8aCKoIolFPlFgAMRKNV6me/DFyvqIzViynb0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(2906002)(66476007)(426003)(33656002)(8936002)(6916009)(508600001)(8676002)(186003)(86362001)(66946007)(5660300002)(66556008)(26005)(9746002)(4326008)(1076003)(36756003)(83380400001)(316002)(2616005)(9786002)(4744005)(38100700002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WlUZN88v1TTiRAalW1xnzGz6yKdUvQoHxmfS0hQgRUBLzmzjluUAkiR3c9pk?=
 =?us-ascii?Q?6jDeDunBldh6MSuIP5zOxJdEBDXHwEDRxp0/1iwjCNPYT04cgVE6P+/TYjhe?=
 =?us-ascii?Q?g5e4MX/a1H56lfAcBaLgRNr947DVmyDZeAH20U58mX8eb4S19HSF8KJRqIjl?=
 =?us-ascii?Q?hi4YHkJob7Qr/HBOlFReAFfq6nSL2kA1ARbgPjEabHSPZP9uCI+HDSmZdTeB?=
 =?us-ascii?Q?p9953b0P+EWS2pj0IvRGZUX0JSPHwmoJkLzUKISOAzWSg6EfdCc4QJTckwDZ?=
 =?us-ascii?Q?vDTqqhoUv+YcpcOMKMzxj52W940V5Exb07KOz4XnocCTeEQ+99/C5+dt/s2t?=
 =?us-ascii?Q?Ukxc1D3wI5LL8P47RUyBYO4QoKAo6qw7k1w01ULzeubbvCCTahMST/lKreZ9?=
 =?us-ascii?Q?JIne+WEQpPdZtMh9M8syYdC887Je7d1xQUK436M2T0wVsTrFzdgkhg1RMpFJ?=
 =?us-ascii?Q?xfUmbtB1csIW3xtjzVr2FAMq8qXaJddcO2pqgr1rl9IG3MtmcZjf/wkf02u0?=
 =?us-ascii?Q?70Rtrgne8ZQVtootid4z4cDAiUm360ZmW20VfH9duEltDzw4hS2i/X2F7NIh?=
 =?us-ascii?Q?rmNKOSakmbuWXyimOQFzPxzj9Xp6konSpHTSbiA0AOHGCD3ZrrNa+yB1NCGu?=
 =?us-ascii?Q?xNS2E+o2slDoIepRgRe0XoSd9tIry5wxZAfMXMXi5ZVv0PVCpuOhZBhuVoAQ?=
 =?us-ascii?Q?9o3BN/+B+rOMjyKKv5t7sHZ1NT24yP2xZKoIj4nyhHMfhWVbxA5SOwk0Qix+?=
 =?us-ascii?Q?4qtHG87cibqOn/oAe9kVWC+UTYbZRFGIhaTSqEON2VifS7TUr1xuA3Wguycg?=
 =?us-ascii?Q?cfr6j1Iyn95H53zyM8b12dbMpNcXUtRWwzAeDb7uamBjt8kRv1FVCyR5bdTw?=
 =?us-ascii?Q?8bjpfk7JOYxp1onbXlmOnillbyWDDxfzQPEJVLlmQejLBgZ0Y1Dg2xB9WeDQ?=
 =?us-ascii?Q?Hr8KuOVImXqRjHjbsUU6byj/kRmKdrwYXLUBaSvw7/kpLbA6CLzQrzH91t3l?=
 =?us-ascii?Q?cEhHM4TwBNRlK9rqsPU48Z46EUIr7EnjHyyA8vLrFBkYiCP6uVV+ftmOxKbb?=
 =?us-ascii?Q?QlKVTuWzYhjcRFvsUQJKQnvsWm/Wepq1eEqg4/gMUyPeQjxk7lFJFBbBGauq?=
 =?us-ascii?Q?OlNZ7DFfiBM8fpc4PpKyUKsUamHIFicAblBdAZr/P/cX+qKUWAL9xO8+ia2o?=
 =?us-ascii?Q?Y+zFnC4XJRK/QK+qK5UYN0oahJ5P/Sx3k3anVM4hKFuI/qKLsvUMT3UqPA3C?=
 =?us-ascii?Q?VrI6PAtLtDO4tpZcxGzzA1MggbQqine6AlL3egNg+yM5b+t4QXbrgNIUMYB+?=
 =?us-ascii?Q?E/+L+239Z91VdjUQH+FfpzPXXhC35zlGeq/zwbgt8ziCuLyO9B+pRmnf4z5A?=
 =?us-ascii?Q?d8+9Qy87XxSJ4zOqSXCWWGtOYgE8b6ReFmvrTFVpAXlmDvHKVD+IyAto8N0F?=
 =?us-ascii?Q?9PU2ld4YnOdibHcP+YoH1cfAVtrP/g211q0JbnWGRTBnmONIsjNAvwX+ta45?=
 =?us-ascii?Q?x9rIX6KzeEwOTbzun3K+S0DLLRvQn6Ffm5hFJgnXZkUy0he+IyNuzqr4P8sP?=
 =?us-ascii?Q?UR2GfNdL59QXj1DKM+E=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 083a53a4-3fa5-4c1e-db04-08d99afc5e13
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 16:51:35.1616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+zmfHBt6JMhrG0l3+mnN90CxwjciiVqGO/Alvwq4quy94ITvbFm1SxRVprDChIr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5506
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 29, 2021 at 07:50:37PM +0300, Leon Romanovsky wrote:
> On Fri, Oct 29, 2021 at 01:27:02PM -0300, Jason Gunthorpe wrote:
> > On Thu, Oct 28, 2021 at 08:55:22AM +0300, Leon Romanovsky wrote:
> > > From: Aharon Landau <aharonl@nvidia.com>
> > > 
> > > The vendors set the IOVA of newly created MRs in rereg_user_mr, so don't
> > > overwrite it. That ensures that this field is set only if IB_MR_REREG_TRANS
> > > flag is provided.
> > > 
> > > Fixes: 6e0954b11c05 ("RDMA/uverbs: Allow drivers to create a new HW object during rereg_mr")
> > 
> > This isn't really a fixes type patch..
> 
> Why? We see that without this patch MR IOVA is not as expected.

How so? Aharon should explain that in the commit message

Jason
