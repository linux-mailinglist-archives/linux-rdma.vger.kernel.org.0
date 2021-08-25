Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D083F7EB9
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Aug 2021 00:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhHYWkx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Aug 2021 18:40:53 -0400
Received: from mail-mw2nam08on2077.outbound.protection.outlook.com ([40.107.101.77]:8800
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229786AbhHYWks (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 25 Aug 2021 18:40:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3noIL7U8k68IEPq/Y/aTkyzgyjAK50k9UxholntIrW3oi/SC2feUPXOBvW+rfS9nqym02uV7dfSvrnvQamtFrDRiqInXj80YgTHkDsWV2uZbRGhm+mTrCxsKbo5K0umGb4qlWJAzqRskp+Le0fAovG9fQBcjkAlOzui/OXmJItn/fNES5PX9z+aMdixw9RGyTWJAPGh+19dbLNP5J1bd6guCB0QMd925HAkA5jmtng6jPqEXBOempmCUnfAiAn6LXId2mC9NEqMtKVpaEwXXyidlt7CsEYBsgGT8oKdWsHrAXjtrfRPpJXSWOuUUEYGqZ+USHwR7bzDwuOePyExDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fn1coDbVOAOQMASqjFmF0Rng9CYGh8lUdRhQqqhGSzI=;
 b=B4FvxDHKXAnaH7tXh37R19TCNPM6Mr24HLKaTB5Fc72iordjx+EYECuyTwM5F4I7JUZDnza3gx1hlYAHHX39Jq/sgwBurb1poaRdsRo8jIQryDsxqICbLo8w12LdmYZnCJk7Rbet74cLyAiIPBqmUgTBJgbmWr+Rns/N6AjeeeRDJCgO3xipCtI1AgbRaHoqK1ckOz24CSsr8q5zphrtZK6uNqypbIyi+TAsFTNsXJF9woLo4fU3tzXzeQRu+w9ZHYAD1ksVI6ObQZ3VjF5g89GwaMht8UtgPCM7plMN+gaZX0oVSwaoVQM58rE22l3MBdlNEuhlRezy2Xa1fXTUEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fn1coDbVOAOQMASqjFmF0Rng9CYGh8lUdRhQqqhGSzI=;
 b=LsobIUoPSEZhAbD61j0yvP/jtYxPxDjyjEGpZzRfOKYFuAAxWQUEZ3B9llBxQICQIGZfGrWNr5rgWy03kuxOM99qRwoOxNMQkKOHCLMIjokui1IeVoPJKvvLuTGggf/iKBSCxnnjs8Ahklww/hzoOnBrzsA0hUkWpnwYeEV+kzCitMfyEv02UV7bB8k71Z1wPat0CCQI+fKvVR305Kt3D0grFkxYK1fJZbrbxpmp2gkcFnKFcKPjRVPrai6m+BzKka57r9muggc3Pa+7DUmOhTG7hx+i2FNTGPAHGlwg0Tpgxi58vAcb52KBj4655pYSaBU2x3bpVVh/e7+RsUs+GQ==
Authentication-Results: baidu.com; dkim=none (message not signed)
 header.d=none;baidu.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5222.namprd12.prod.outlook.com (2603:10b6:208:31e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Wed, 25 Aug
 2021 22:39:59 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.024; Wed, 25 Aug 2021
 22:39:59 +0000
Date:   Wed, 25 Aug 2021 19:39:58 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     dennis.dalessandro@cornelisnetworks.com,
        mike.marciniszyn@cornelisnetworks.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] IB/rdmavt: Convert to SPDX identifier
Message-ID: <20210825223958.GA1220397@nvidia.com>
References: <20210823023530.48-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823023530.48-1-caihuoqing@baidu.com>
X-ClientProxiedBy: MN2PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:208:d4::17) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR04CA0004.namprd04.prod.outlook.com (2603:10b6:208:d4::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19 via Frontend Transport; Wed, 25 Aug 2021 22:39:59 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mJ1Ys-0057YP-3H; Wed, 25 Aug 2021 19:39:58 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9b35d46-109e-4285-185a-08d96819452e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5222:
X-Microsoft-Antispam-PRVS: <BL1PR12MB522242DFCD9B77A915474782C2C69@BL1PR12MB5222.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 561VyxNlWqgAFZs+kN8BeekaG/zYuNMk34W/L7WEnbEBN1vu6axFloJkQJzmBUxTzGB5qyh16O+WMicRU+3fM4hK+nVpqc34mT3K7AfRJvlCQS+PfL9eU2MetAxpp32sLYlKOsYrihfMitk2Ahmct2+LU8i+pHKB/E6X11lTlsa+DiIFZsOaC6Yz8zn8EikPN3tYPRA7/oRVix/FS7N3SWfz1WryaiqkdcxND7yLRtR2bRT8BjTmBcWfM+GXl7h7FGfvpIhMjJh0EWsQRfiV9hp9zx3tpFybqA/SPV+qrleRQJcHMCD0zZvyWKyTP+oa1qwCZGnBaEvyMfPuCucSX/IYuH+hUvB8/XwAPomLmBILJBosKcG1nJ1C4pa9hL3Pc92KZvSWB7GAhqdvnxyJxOQ7wjcjOczFkj/xOV4ok0XqgfJXISlvXbKunhBCWD0IrSAzzmzh+B5mzAhbRlLDPh8EsscwSVUGRn6EvRT/jLHbSFrGMnXYrAKq6Q79IbBu3RRzCcPso1xyG882vtG+K/xbC43O/wGX5ob5hukbEOVHK2ss0j29tqb9J+l3ikiiNL/PqsmBhWeO9CxUptZQ/0bDVQ+bByGjYMMc6nG/n3Ok9l1L1iBPxfftpwG9vAuajCwb5XswSgB2OWIXGOlYiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(6916009)(36756003)(33656002)(426003)(9746002)(83380400001)(316002)(4326008)(5660300002)(9786002)(1076003)(186003)(8676002)(38100700002)(86362001)(66946007)(66556008)(66476007)(8936002)(478600001)(2906002)(26005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?518oIVJjxhNnQTo8G0ZPd3uMDuOQTOeIVRp+8aVjvUHUL5Cjqf++qC8tlShB?=
 =?us-ascii?Q?mdXZj5MKdMOiEH/PL6FkDR8N5zM8Sx9Ei5KNx4pEi6nSn+dK2gB6cyXTCwIm?=
 =?us-ascii?Q?A1QwSAsVMv0Fco9iut3LInXA+jAZszSUIn36yiicI5St+mT0bUvvKwQfM69U?=
 =?us-ascii?Q?+tewJscOPg5eo0qoMCAX2OPVxk2XVB7gUXPfThzfig360IVkjW96AHuzc4iz?=
 =?us-ascii?Q?MZ3M78SRp0Jexi9MGbEk21b5riJhvp+qKuCmlH4j1s/sdrvrKcQQPB/68UhV?=
 =?us-ascii?Q?COWqaIpQNVXm6wW/ERft6TCrC83YY75B2V7+GUqIShtBOdVGtqypO8dr31Mp?=
 =?us-ascii?Q?dcArBat3cOfVU59X86l7/0CTbnMTz853cREMTMIJtAXxEN7a2AMHdxRzixAB?=
 =?us-ascii?Q?/BzQly5sZsrxiwFHvF6Y7QJkmdd/BhVE5tBbEsb0irgFLxND/m+VrwfiMUCF?=
 =?us-ascii?Q?6UK47RPh+IJYeQqpPmqwrwCODtoV9M08j7lRfDuMshfIhlHdeZt9CyZrsqta?=
 =?us-ascii?Q?MH20LqstH6jm9QBUj82zM9uxBpan07D/GD9+0hHWoGzEvvikKpWhmhG1aATl?=
 =?us-ascii?Q?yXd8QwMVSB7NV2+VNgLobX5Xz368Njrw2Q8TcUYWuDPUdVUuHZqJqedugAJo?=
 =?us-ascii?Q?8DafT5eBANZ8O5bHklhmDFUbCRiMITiV8qclE3/SEYT7WZnr6vkDUoKnLRYP?=
 =?us-ascii?Q?kRGC02i3ZIGn08fCp3npp11K6RcgwAVDl182/t+TLNERtLMLj3OEjAyGTrGh?=
 =?us-ascii?Q?qhnv+C4bDyFfFhgveFJV1+XBdzuuGeXwUEcDX5CkiUwZRCSFiaKXcj+B2197?=
 =?us-ascii?Q?QNXPAqos3xdBwlZ4UAzfMo5oDIv94z+sf97jGk2aB6s6+eyPD8GwqRieamxM?=
 =?us-ascii?Q?Hwkb1HIJsxaX9NPE+i2aijIVWJkwMQx5mzgWMlco7LlCCBOtf+NhJeApkjAu?=
 =?us-ascii?Q?lD/i+O2kbl+yiJINCu6iI0vdhB0yHtwlbEbKrXlmSLrXizleK3I+AegiXEWW?=
 =?us-ascii?Q?fMAe5dFAgeqi2hSIz8tmmAS7JU2K8ROQgmfVpKOdRA1DwYWl/wRQBT6BU2J6?=
 =?us-ascii?Q?WhL4HSQLKMBM1owSoq+GK7x8BiN2Ftq5yQfguyahPnEDTj6RIlGZL9NeFmcL?=
 =?us-ascii?Q?SB7NuvrvAWHJgFUrnjLwVLGD6HqKvTxAW90v0HncJ4ZMrp0Cz4NFgVNEchdm?=
 =?us-ascii?Q?2Pk/zVFYr8eOgWJCgHoZ0USUf1HIDEYe8T9qA2KGpgd9JKdWo+FxXRKCm2Fs?=
 =?us-ascii?Q?5uDOY7Mboyj/YCbpYID6NXVlp9Ndr1XYxSZIL2f8gMErB3+2AAgErkM2b01j?=
 =?us-ascii?Q?K4NgVjCw/NtZP6reKxUUTCd8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b35d46-109e-4285-185a-08d96819452e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 22:39:59.5567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ZmvK5j/ns40y74RNTlsqrlTcYjQq+GMUDD7T84smoDaDz+jBjerUCFcXKF3OBmO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5222
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 23, 2021 at 10:35:30AM +0800, Cai Huoqing wrote:
> use SPDX-License-Identifier instead of a verbose license text
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
>  drivers/infiniband/sw/rdmavt/ah.c        | 44 +--------------------
>  drivers/infiniband/sw/rdmavt/ah.h        | 50 ++----------------------
>  drivers/infiniband/sw/rdmavt/cq.c        | 44 +--------------------
>  drivers/infiniband/sw/rdmavt/cq.h        | 50 ++----------------------
>  drivers/infiniband/sw/rdmavt/mad.c       | 44 +--------------------
>  drivers/infiniband/sw/rdmavt/mad.h       | 50 ++----------------------
>  drivers/infiniband/sw/rdmavt/mcast.c     | 44 +--------------------
>  drivers/infiniband/sw/rdmavt/mcast.h     | 50 ++----------------------
>  drivers/infiniband/sw/rdmavt/mmap.c      | 44 +--------------------
>  drivers/infiniband/sw/rdmavt/mmap.h      | 50 ++----------------------
>  drivers/infiniband/sw/rdmavt/mr.c        | 44 +--------------------
>  drivers/infiniband/sw/rdmavt/mr.h        | 50 ++----------------------
>  drivers/infiniband/sw/rdmavt/pd.c        | 44 +--------------------
>  drivers/infiniband/sw/rdmavt/pd.h        | 50 ++----------------------
>  drivers/infiniband/sw/rdmavt/qp.c        | 44 +--------------------
>  drivers/infiniband/sw/rdmavt/qp.h        | 50 ++----------------------
>  drivers/infiniband/sw/rdmavt/rc.c        | 44 +--------------------
>  drivers/infiniband/sw/rdmavt/srq.c       | 44 +--------------------
>  drivers/infiniband/sw/rdmavt/srq.h       | 50 ++----------------------
>  drivers/infiniband/sw/rdmavt/trace.c     | 44 +--------------------
>  drivers/infiniband/sw/rdmavt/trace.h     | 44 +--------------------
>  drivers/infiniband/sw/rdmavt/trace_cq.h  | 44 +--------------------
>  drivers/infiniband/sw/rdmavt/trace_mr.h  | 44 +--------------------
>  drivers/infiniband/sw/rdmavt/trace_qp.h  | 44 +--------------------
>  drivers/infiniband/sw/rdmavt/trace_rc.h  | 44 +--------------------
>  drivers/infiniband/sw/rdmavt/trace_rvt.h | 44 +--------------------
>  drivers/infiniband/sw/rdmavt/trace_tx.h  | 44 +--------------------
>  drivers/infiniband/sw/rdmavt/vt.c        | 44 +--------------------
>  drivers/infiniband/sw/rdmavt/vt.h        | 50 ++----------------------
>  29 files changed, 59 insertions(+), 1277 deletions(-)

Applied to for-next, thanks

Jason
