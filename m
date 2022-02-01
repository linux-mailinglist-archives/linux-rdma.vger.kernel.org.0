Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B084A5E18
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Feb 2022 15:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239149AbiBAOTK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Feb 2022 09:19:10 -0500
Received: from mail-mw2nam08on2082.outbound.protection.outlook.com ([40.107.101.82]:2752
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239002AbiBAOTK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 1 Feb 2022 09:19:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2BuF3wqcpETyP7+w+Ysyz8DpfKIL+PSyel+/j27wx0kZ3jSdPI2C36kwgPfuLSjKCL+I4oS9xyQhlFmoD+mQcHn7zbA9fF33knhTrXLe7DopPRUuUhjcZT1wqWadbeN0c3elbIPSX686ZQyma4UQFnIc/nG/Z8zk91TXX/8EkkGGjyyAvhLtsNjgTnrNbargsxVfW8SLt4g+1yCfaSBYAVMoZXx5OH3DQiQ42352iYCUHoakOqZxLPXRNFBp7BIwkxYD4zmWqJj6/Vx4CKEpWVKdrE/x7jeOvZ0RV6zyIIu4B7NdhpPe/+B21mz6eFpCvdl0n8xM1zESaePAhLgMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3w3OxKMiWIHHdf42RylF/YlxDxSa7stgnpzQHdniWHI=;
 b=AMwZliLdc3pCJduZL/XQMgGGxVoo8fF4rPZ/Z0YVdXt8EqKKxawktU47gZYdhFXjGn1chIut2DUCkVmTgeuIuvuwRtzXfZ42bn1TWUNrvvy6bj7Qdri1ajpaMxVH5dRkWVVBttBQDn1cXXTXEh/B5bAvdmnwpDwmZ1XQsVfSKOFsF+2wtAPWGENpiB0Cbdoit+3MfAigMYs0z+ZQjrp9a9zHLvlF8XNDDCOoC8OixLFDtGiC89TSXlLCDLolTS4aJ9E86Oj0NyMJCxPcrXaRLE1PsEmfBqepn+URgt4fu6fenuYpk+o8Hw62q+1AbagZFshwUFbbRt66c5E4kgpAkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3w3OxKMiWIHHdf42RylF/YlxDxSa7stgnpzQHdniWHI=;
 b=NsQgWfEBliII79AeoXVSt9w5v+GL/avP+rZPXAo+OTWF/R72Som1E/C4welptoXYqGWmIQ/Bl3o3F5cri0dH6/WcI/Bw7BPFTvg953C1gCzXJHcK79+1gDl8WMbv3mHY3WnGpRsMTg3pnCnR+geVJR/97obhbosufDg08D2dlwMt9IC2iT2g8W+a1GnwphdqvDwxPu9x+FNF++Wy6JFa2SYeUnoCGx9oIKq79Hm2p6Wq3DEdBPYCTzL8J9urdL/P+SKJFLEk3Tzo+z9/Q6YugD4SNCEkPbkAsS1fjxIFm1y1KJ3K3qQghdhjBuf/axQ3uH0MXLvz3dtKtQshU/jyuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BY5PR12MB4919.namprd12.prod.outlook.com (2603:10b6:a03:1d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Tue, 1 Feb
 2022 14:19:09 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 14:19:09 +0000
Date:   Tue, 1 Feb 2022 10:19:07 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        linux-rdma@vger.kernel.org, Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx4: Don't continue event handler after
 memory allocation failure
Message-ID: <20220201141907.GB2426447@nvidia.com>
References: <12a0e83f18cfad4b5f62654f141e240d04915e10.1643622264.git.leonro@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12a0e83f18cfad4b5f62654f141e240d04915e10.1643622264.git.leonro@nvidia.com>
X-ClientProxiedBy: MN2PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:208:160::28) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db035964-c301-480b-2ecc-08d9e58dcfca
X-MS-TrafficTypeDiagnostic: BY5PR12MB4919:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4919D4336E7A7F74E505C099C2269@BY5PR12MB4919.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 780cATMHjJC6XjHdQt/24b4FNd9EhW5rSCcnm84mmIRacXYFSEBtxYgKy1OX2+EUTjM8Iv93BYSsaYa6QWCvXrknBZSuXO3auvPYADTXrvnVk1mNMdINO+lEWxntteGedOihtBgDBg7dJlbAkyZNLI2F3JxKVzBE7AQ3vfnXfvhRFBSPpAIbqMSWX4ck/8osxqXP0br+53ifRbJ6wBz17zpBFGhnI1+TyACtk7wID4ZctI4AEUtuc31UGoX+jupiK5V5R56qJgTJaIgaFz7ekdjYgGLZTQTORgcsIXC86m3wrTKSSvjfBurmKk2zfK0hJqB8HvLiQpOlDJ1W5f+q26ZFCuDz12I1Cc1OHAVg08RtIZQLTOjq+76EVBEscTNSPebnfxusAcvwgGzfMknDveM3K+5VoT3xMy8L+3JOBxfGY6uFidgl8dQQ8nq59V35l0K1Yjo3G2DBDemkDA9rnTVKHUmdxZlCTtj1PrdGpe31Hl27Y9UZPlu7jvykzw32/MVhpeQFE1kPE3PWiE6nPyXx5LKriMNgImOzr7j+QGEpBuxHDzIinuDxL6TjTQ90O9hCLKsp/litUMpyZ+07FNMgzFAD+wyU/XfkVrE8PwNyFYvfQ8TVLBQONWiaAg4TfQnTrBmNVT7NCHuLj5EiMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(6512007)(6916009)(66946007)(316002)(86362001)(54906003)(83380400001)(508600001)(8936002)(4326008)(38100700002)(8676002)(66476007)(66556008)(6506007)(66574015)(2616005)(2906002)(5660300002)(4744005)(1076003)(186003)(26005)(6486002)(36756003)(107886003)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmEvZE1mQ0cxdXhLM002aTB1WXBXaUo4WGlySHoycjc3TG9MdWthcS9MYnY4?=
 =?utf-8?B?Q3ZRWExrQUpRWnlWQnBGcUNJSFNqZkdwK1MzRHQvdTlHcEdlc3dhcVEvWFRQ?=
 =?utf-8?B?Wm9XbC9uK0ZxMXBYSWgrY2FxNFg4MFI2OFdvOGVFUjJBSWR4QWM2Qzg1OTZv?=
 =?utf-8?B?QWdoSEEzazFTNUdzYUlNYkhkRVlMMDNRU0lZYkZTTzVCcWJKOEdDVkhnbWRB?=
 =?utf-8?B?Qm5pUkpVMzd1cjYybWRTTUFvcCtOeWZrU0V4eWNvMnJyRE1yVzdMN1QwTGtL?=
 =?utf-8?B?Nmk4ejgxck5xNkJYc3ZJTzZ1aXpGdVpSa0tSVGJuUXEzWlZycFdCc3h5bHpu?=
 =?utf-8?B?cnIvVjY1SWpaTFRUMEdQb3ZwcmhXQTdQekRNZlJVMTI1MWN4VXJWcWZ5UTZw?=
 =?utf-8?B?UHRNREViVUloWXVrbE5PZGRKR0lOMWV2a0hyb3JGWFEzRTJOMkJEZEFiSGJx?=
 =?utf-8?B?ZzUxcXRaVWhpbHUzdGpYSGdEK3NxZWVYRFN1YU1XSFRTT1IwQ0czN2RXZ0xF?=
 =?utf-8?B?dXlEQWdsRmF6QjdUYi9HNjBMOS82VmY2L3R5UkxTMkxzVktqSXRwUnlkYlRa?=
 =?utf-8?B?RlBJZDVyVjZnQUF2TDlRQUFOa1M1Q292SDAzTUtMdFQrMlVjeitKVmloTDVu?=
 =?utf-8?B?OUlFREQ3TGJiTlJsanFDS3RjOVAwdGx2L3ZZUG5JWnVqSTlKN04wRVFoZUM0?=
 =?utf-8?B?Qk9mbnJNOXh2dXZNY2Y3VXZrTlJabEhuc1RpV0Z3UTR1WHNCYkdmcUFUUmsy?=
 =?utf-8?B?TXB1QUVlRElaSFh6N0JLcW1Qd0g3Q1FrUUU5TmlnYStONkY5bGRSSjJPKzY4?=
 =?utf-8?B?K0lqcDZLdFVpczNoZDYrUVlTNytBamUwL2FhVGxSZEJoWXYwbm9uNUkrM3Fz?=
 =?utf-8?B?VXFFSmxGSnFIWnBQM3N0dnVpaFZucFphaFI2cmIrL1pGK216ZG1iSkhndmZJ?=
 =?utf-8?B?cXhucEJxWk8zWVB0ZERvUW9pYTk2eVBkc3ppRUtoRVpxMlR3MFB1SHVHcHdz?=
 =?utf-8?B?RXFuMHlScVhFVjVPZEJkOUgrQ1p4NVlEUHMrS2xnb1QrMWtwclBOUXFEMUVj?=
 =?utf-8?B?RE1LcDkwRnF0WVBwcnkzZGxSbmlOWndSQUFtNzZ4VFBGTVo4cEtkT0lrZzJY?=
 =?utf-8?B?OW10QmNQSHp6cmZIMGNJdHJsQXU3YmNNNUpWYnZrU0F2cW16dnV5YzgrU09z?=
 =?utf-8?B?NGVBU2pIS3RrTk5lOFFxb0xmTzZpMDNqYlNYZ0JVU2xwUWtTYWJPWHY2VmdT?=
 =?utf-8?B?RVg2ZEcrbzBGS0dRSjB4N2lLaWYxVVZwK2xpZ2VQRmRvK2tiSmhKS24zMDA2?=
 =?utf-8?B?M0FrN2M5eThTdjBEMWtBemkreGNHUGZFY1c1RldxUUtVc0NwNSsvNWE3V1Mz?=
 =?utf-8?B?R3BLSGN0NnZ5WHJCMzFCZFJTVkMyRGljeXY4aU5zeDlpZUFxbkwyb011MXhr?=
 =?utf-8?B?WjZ3eXoyK2VBSzZ5c1drUlJSYTJlOHhPeEFvaE53bEhjRkU2TERhajlqa3RH?=
 =?utf-8?B?STJGMlJCUS95MTJReS9VZnp0NVBQVHRQVXI3M1BFaG5CR2hvSTlsSE00WGhD?=
 =?utf-8?B?OElrYWhycGdzdkc0ZUZ0bkZxUXd5Zzg3SXRJaURMczdlbDREaE5NaUsrT0ZR?=
 =?utf-8?B?ZkNsdTZDaE8yYUNZYjZZRkk3dHVFVjNwVk9SOFpEMDByUUdxQ0FMS2ZYYW00?=
 =?utf-8?B?RXFaTEdHbWgvZlNaRzQxd2ZIMWVqZGtRN0dVaktZVzZUeEkrTElUZkJ4SC9y?=
 =?utf-8?B?dTBONVdQWjB5czdJRHJKREdTQmNiV2dCMkt3S2FheFhvUTZjVHRVZGVOM3lR?=
 =?utf-8?B?aUJROThhNFlyYmd2VlZQT0g1QjkyVTZvanhzeXdoT21aSkFNK1E0enVPWG1J?=
 =?utf-8?B?Y3RlNUV0K29sVmE4dklKZnFmWnZmc3ZJV2wwK3lXTjByL1FtcC9hMjFaZDEz?=
 =?utf-8?B?eEo1Yk93L1JLNjRMVkkxVm5CTFdnR0pTdmNjNFdNNmJ1UEpXaENJdy93T01X?=
 =?utf-8?B?VHFwOXZmQkFRSFU4eFlyRGQzYmRZQmE1dXQ4YVJUQ0toY2hwSUJ5Ynl1Sk03?=
 =?utf-8?B?RGZEN1h5RmtUSit3NElRMk1Sc2RMMGZVbnlpcnczNU9rZ0dQbzNCLy9QSFFa?=
 =?utf-8?Q?j1Dw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db035964-c301-480b-2ecc-08d9e58dcfca
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 14:19:08.9856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7tBXmGuA11kNKu/UF/B9HXl8rh4NcSmwa/8AyBwWOZSVAWHnFnlUa/NiGW1cXE4j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4919
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 31, 2022 at 11:45:26AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The failure to allocate memory during MLX4_DEV_EVENT_PORT_MGMT_CHANGE
> event handler will cause skip the assignment logic, but ib_dispatch_event()
> will be called anyway.
> 
> Fix it by calling to return instead of break after memory allocation
> failure.
> 
> Fixes: 00f5ce99dc6e ("mlx4: Use port management change event instead of smp_snoop")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Reviewed-by: Håkon Bugge <haakon.bugge@oracle.com>
> ---
>  drivers/infiniband/hw/mlx4/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
