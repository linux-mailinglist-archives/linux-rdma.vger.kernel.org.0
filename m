Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1289337F35
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Mar 2021 21:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhCKUnn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Mar 2021 15:43:43 -0500
Received: from mail-dm6nam11on2073.outbound.protection.outlook.com ([40.107.223.73]:45153
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229674AbhCKUnR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 11 Mar 2021 15:43:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQqMCauGaNDspt+3Yen2I1PoGiHvYsXgd+iDLhXmPx10UALD+J/kEs/ofg8XrTAlwtzObPSghbu11qIkX+EPPubUxbzGhn6BYzqj+M4ssySqQhIpyVd9tnkPevLzedn52DpUqDRXj96DxJ//Qdr1zkjgLhYE108BSRNddI9Iwhw+nqXDbiV3nzxqt3wJhtXz3Ze89yUAycIznUx9RC3zbZMv3WwPOSqpxZd+kVZl6KvbyqigvrWeJ5EZrO1YFUzjgM3bZGRdo50WVVipU4i36ig1iHNl3riyakyB7RqP+iwmmC4kHia6SZ2/vsOR6ioA35PcWFrJuKrVimPug2eW5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAMJuGT0guLoQm0y63r5jgyYyHq3mvGVKZnbUIGg9fA=;
 b=JRE7L7yE1KjuxkMaeIBZuDaqMNKh/yXFOs4nmTxj4/ZoGzpnWaEkR0AGzpapLCAzV46BMDoKUVCxn976AYNsTHnWATrYVadmnxrYLrfxL3fBGEOgaKHqFr7n3r8lS4BsrGTtlX5W6JzUq1K7sbXjiAP3gkfUzU0Sy9EMIS8QOnbWBWzoZfXyVYnvmnutSDrgFt9pCql7lZiKq6vDK1++0IwHkSMLHg/0iD6VnyGI34PXcfthBxQUPpe2BjAC8rrn3eO4k2/j7Ua6qY8cRFcpJ25tC8QldgDh+zQ75VxFU2wwryjjfhyU3hitdjZC5lURNYHDK281VTYKqUSm7PHMSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAMJuGT0guLoQm0y63r5jgyYyHq3mvGVKZnbUIGg9fA=;
 b=K2mpM4NcdgwMV7Qp5SlkimEjfj0AgcqXZRQ1M9JzHfoji6cwUG5q4DMy7e6zkDSjkj3LNqFVRAyKQOBu/joQys0mALYrzh4nrh/YWjqrwFxawSgwMwR6oTY22StNjoTmVClAFxlFqsjpsbxQIhdA99WJz+JYI8+dtdQYDbPNJS6WJVmgbZRIrsik5gekiFJshIfjPhAj0dWVLqSlQRaSXir50aO2c/O4TawZqvQOGDzaMZ1h7aH2m0SBNHCn/T1Lad0AtNBVH4YTKavqSiXHbHkhgheNk0eYRmc1iuFuWdzbtAQxAUXGoy+h0LtCDSpsAQQntTLfxiPaGaWXQpOoqg==
Authentication-Results: cloud.ionos.com; dkim=none (message not signed)
 header.d=none;cloud.ionos.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB2488.namprd12.prod.outlook.com (2603:10b6:3:e1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.28; Thu, 11 Mar
 2021 20:43:16 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3933.031; Thu, 11 Mar 2021
 20:43:16 +0000
Date:   Thu, 11 Mar 2021 16:43:14 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jack Wang <jinpu.wang@cloud.ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        dledford@redhat.com, danil.kipnis@cloud.ionos.com,
        Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCHv2 for-next 2/2] RDMA/rtrs-clt: Use rdma_event_msg in log
Message-ID: <20210311204314.GB2749140@nvidia.com>
References: <20210222141551.54345-1-jinpu.wang@cloud.ionos.com>
 <20210222141551.54345-2-jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222141551.54345-2-jinpu.wang@cloud.ionos.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0386.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::31) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0386.namprd13.prod.outlook.com (2603:10b6:208:2c0::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.11 via Frontend Transport; Thu, 11 Mar 2021 20:43:15 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lKS9K-00BXCB-Ft; Thu, 11 Mar 2021 16:43:14 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d607a42b-9583-4e46-6a31-08d8e4ce4bd1
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2488:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB248894C0D32C720E7DEF0CA4C2909@DM5PR1201MB2488.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KcN7QUVlmIML3q1GAQnz0hV7ZVXldW0E07OODN04L7MbmbASuyVzjGHlaW2zt5M8egrK8PTZ5T9slxaXLEOGaSgEzkmFjy2yNpswtCmmcF+4z/Cn0X5IJaZbiRwWIONZWhsy6Y4aLfUicXvmrVRCX1uM4Gjr74iSh3MTlzr3YVdDUSHcZgVCUPGiBNyUrGEuv3iEZ/6TsEL5kOecKgrLVQX9t8N8TBSqJJmgcJkfCOZqosA0lENzJIyqd5LPyFflDgJvSkpXi4UVGKDLn8qKDt6Fa/0sDjSWW0CnAu/v63c4rW6IpWgN7pS8ZTd/9Da/obawEzC48QPRWLm10O+zhmC08LXBdfFYIXCeXNnysoEjSbZeFeU4Zx7b3PGvOq0freAVkxwAfnd/IHB9WymdCVhbcna7xrK6YvTynMffwkZwFzGlFbB7yu0VV0+3DTyERGlhF548uOSnf0RmY+WEYjybdLvsdGOx/BwDek1GncGCPWP4a/4CJea+RgdZw9zsYmxLIEIFOpqdERAvOcIMqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(107886003)(26005)(9746002)(66946007)(6916009)(8676002)(33656002)(478600001)(8936002)(9786002)(86362001)(2906002)(186003)(1076003)(4326008)(5660300002)(66556008)(4744005)(66476007)(36756003)(83380400001)(316002)(2616005)(426003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?gPlfeuqRJm8pPIfMcJXeSENV463u3uxNeF6PCG4w0CrHL4C5D+bJSRjxjv1M?=
 =?us-ascii?Q?QQ7a/qOMYqh4a2qvSf3VonWAt6i8oW1RjYS1i5Vx49XAnUrts+Lw6nmVN0h3?=
 =?us-ascii?Q?25Li6odEpDsXtRagqX7Ts0kSik3QK2nR78I7R35ut523FBiSZWfoYKZYnE0P?=
 =?us-ascii?Q?FJ6D7/XiXu1KCE4cTrOO7Q4p5bo/iHPXZCCSIi4RjgACvkMJ7JchO2dmTW9Z?=
 =?us-ascii?Q?g75R5Wo7gn7/mYTGPTVtH0foCYotmEHfQ3ftpYYRdl0kjjEKHWGMe7vXdNtF?=
 =?us-ascii?Q?pJSqtApgcUrKxL8FTJWLnXPUFShL/O5lriL5sS+aLW8XbOUHwMww7fT/gFVY?=
 =?us-ascii?Q?dczD+97Jq3BY8jjUaoegA/knYVzV8Ol8eERNCfBtQoEcugTx7cyzdnm0eS7s?=
 =?us-ascii?Q?3MyBwJiW9FW03+P5Y6BPvVljh2pvNnCLvJHi8OT3L/oUX8qFiI13L/NHcqSH?=
 =?us-ascii?Q?1KYQwyfGqQvpVnnQ5WgT5o2C73IJHupGdAy+iSlnF4S6OB2toIcDchF+jFho?=
 =?us-ascii?Q?3vQ7CD/u5MUru17VGKAs2J0VJr+ofby7O/ZViYnh9KnmVV3vNaD7OuIUP9E/?=
 =?us-ascii?Q?pjx3U9ezJ1dhJkig3NJDnKNTpp9EafkntTAiZQflB6BGNv4nJ9MAdwYuv+hD?=
 =?us-ascii?Q?SOVi3xeadkiBcbvNbb/h5REFWNRoGJy+sHrsLlPPubJadZtbpiGvWAggZK8g?=
 =?us-ascii?Q?7ua9qVx/tcpxgrORSTcARG97HB/TVQZopUCEy71vE+PZLJwdhIPG0Dzenr4E?=
 =?us-ascii?Q?f9+z5udL0eSS6ie2JbMpZWS9BlkJO//HQVSXHDwM1ELNmLSwFPNQCzcVnGyU?=
 =?us-ascii?Q?v8AA/yfPVTjjHjtYZlgZ80VMBY3sfTh5cCnrJBiOsIpZDHebngUp83Lbg11H?=
 =?us-ascii?Q?XgGreYMSaz5LMTOL9HMGGexVDH0LfG5SVxC+/DmIRNXcZzMZUYzgzDINPoU1?=
 =?us-ascii?Q?QiV1V4lRBn/BIp4KfsfPrjlCYZm9YCRAfgtJDWJVTrb7qbocoqwtvzq/J4zW?=
 =?us-ascii?Q?ef/SQ5yj3gtomyiS5c3CW3bdAu9Je4yMmgKE0AqZhw9JfXNaM7UXcQ/jknsH?=
 =?us-ascii?Q?rz+Ohb7wkjz0PzkKiBCiRvWa+fee+aHNeI7ZVY6LyV/LOXULGT59vyvppVPR?=
 =?us-ascii?Q?P5gIanJwlIgQ3r61cJr83v8Z+6KbeUpBaoWBsJSLn0d8F0/dXe0XWJXEKBgs?=
 =?us-ascii?Q?PwXocaIoQnlNSTCOJBy1vmeQQwS2u0B/49nVjqS1wiqHwJfcZHB3v/rABu2q?=
 =?us-ascii?Q?pJf8b9lPyLdjivD8WtWRuy49s1FnDL9AIxoSjucQpB0kfYm5ejM7PYB+eoHl?=
 =?us-ascii?Q?Ivf0b3aZQeSSyP7bR5GMDnhFrCjE7OIqCTLzi7+YHrIaKw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d607a42b-9583-4e46-6a31-08d8e4ce4bd1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 20:43:16.1205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aHIIOLtg2AxCvYaTNg7muptNRUwuIcBFy6LWFbT0x9/Jl9gNxNi4dNWXRw25rHbV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2488
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 22, 2021 at 03:15:51PM +0100, Jack Wang wrote:
> It's easier to understand string instead of enum.
> 
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Applied to for-next, thanks

Jason
