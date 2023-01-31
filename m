Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCFC682F35
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Jan 2023 15:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjAaO02 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Jan 2023 09:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjAaO0L (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 31 Jan 2023 09:26:11 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D1939299
        for <linux-rdma@vger.kernel.org>; Tue, 31 Jan 2023 06:25:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f62IqKtO1NrcPzjDEZtru+RK32V0KfjHV8DTfVmrJHIC6ieAggxIEMmTlCOeQ9tM/z/oXt6bfighyWg0pMIEXAsdalExSdvfqkDjYJyWb92aiuepNNsh337+zyP2iEZlFKaAV9r8rkwMfjdP3btA5zI0yyLsH2+JXcRp/9uqtFNYMbs8S+YvW+LULpq0nUkinqHKQj/HwmuwlWxdLIkypuI08gSuhwbqmXVgGt4pxL8qSWh6XWEvG978AndTim8UPdGuesMFiyevB+4KjNd3cDdobomxR2HtY8A3fjrMfr5YYiU7CNntbgpiOuPe93GImy13n/BHoTb+2Xd3efbXMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHSxGPXvF6IDX11bikuWm7Z6gCzyMqiS2C7jJpRc4yw=;
 b=eqnuAMOhCE7P0940Ft1bNYOWbnF+H4SnXKJM1FYCYuCjbT9TL3Td55eKOsRe5uXeOtMhuQ3teG011xZojs6guUOBoN8dJ3MGzC0nau/l0xP5OPxkJXy149W0nPAllLqddGUFqKL9stWO5z106rUpN028yug4gLEzmWNRPGCGCpu8B2DAraxxL0zz4J308KAE2KSxml+1Y162BzN0NDiMg/PDxQbBuEfvkLJyDkjFVwbck+CGjD5iq2CSslX5jASLgaSCej0LAPZ5vKFpewe31VmGm6xPqzAY5Ha1nB99FKdLbsFr4ZjsJtTHxEkivr+AvTY+Mkp/p9CAGqRqvVTtAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHSxGPXvF6IDX11bikuWm7Z6gCzyMqiS2C7jJpRc4yw=;
 b=jiatMhV9YHtio9MGqI6K6M0BsLqc+tnhK3cygg0j+4SaYDVHaeJsa7J710P8JDIU8A7FnC3aIQ9BRuojHuCrbntqJotXOTz2zH+S0aHKnaJpNFvpqaJQfVoZ/0CipQB497/VyHP4hYvXiumzsRUbUATMOZWBv+SoxAD6QB7SnPiv3vIuZ0vP+CiAxsCyHNIiSYFJgdhG3RcTQt8Hb+zfNWsVzLZzNGQjGLTL1KOqtRbozWPL1KfceSRETBW5atB1YZA2FeCqrvFkTDoHjv4fYdDbTVGJzVriwqwIgiqahggxTRWxubobr/HTphctTElxjDSYQJa+v4GJtqNd+x0khg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB5057.namprd12.prod.outlook.com (2603:10b6:610:e0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 14:25:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 14:25:48 +0000
Date:   Tue, 31 Jan 2023 10:25:46 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Maor Gottlieb <maorg@nvidia.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc] RDMA/umem: Use dma-buf locked API to solve
 deadlock
Message-ID: <Y9kk6ncIYpoaEaYf@nvidia.com>
References: <311c2cb791f8af75486df446819071357353db1b.1675088709.git.leon@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <311c2cb791f8af75486df446819071357353db1b.1675088709.git.leon@kernel.org>
X-ClientProxiedBy: BYAPR07CA0084.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB5057:EE_
X-MS-Office365-Filtering-Correlation-Id: 46863304-d6b3-4d64-cf9c-08db03970c5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yCtzA+8/43hJPucskODM79gCL4bavLK9UpHOcCrLc6DZxE7owXMvsZvHVuJNmd8rdLhqKcA/TY29U6FgmldnTpG30snBiatLx8KiV/+TKvtaQtwunJQnDSihIhW7dv+jxHRHsjpSfUoOxU11+LarBhSGYurPfTig9VazVgr3RD9D/kf9/oPLaIvL5AOjLfalcKd1ml6EXfJWEMt+BiO1DWtN9ghGaWoQyKTvCpGx/X2ho+I4rr2znB4TvNR+HZMGM/6Trf5z59hduc1UJKHDAI+79oJH/oaunAjaeilEHf9Y9LyO6XFUINwvf1EsTHL4qp7MT7/UOZy9faUhwK1MG2ArWecQKFImsYpUlpMNy/7/dWYyyyP0jlQQmIsL+8o8qW6cDGkVp13jygP9M/5voVMQi8EOqhHl3+GicEZiHn4+YxrpB5EMJLpG1N3liplnVmm/r4qVXAAbcd4BqwVoHWxuYHJQyFiWgdmc/6wiYaqF0ECSTFGY+K54TBmAuawMFxlWe+jkZEsUw9IdgPBdkYA2IKluc5fB67vawr1hwil7i7IP+ZZefc6U4bCvibTGakSviw/UmPOv72XEWgkhSUC4CkmfF9PurEteaYeodRNZso4pCyB/nGlJCdB36WLDfY+e0oPRvmcwHuWKbRQV7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199018)(2906002)(4744005)(5660300002)(8936002)(86362001)(83380400001)(41300700001)(66946007)(6506007)(4326008)(66556008)(8676002)(6916009)(36756003)(54906003)(6512007)(186003)(26005)(478600001)(6486002)(66476007)(38100700002)(66574015)(2616005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFNuN2puS3J0VmhSTEVLRytmMS9EcVlkUFBZR2RaUml5dlpTU05pYThjL0tP?=
 =?utf-8?B?RDZJVnBIRUpkaUNHTkNmTDltUVlUc1p5K0tSUElINnlsaW9OTDdPTjZEMUVz?=
 =?utf-8?B?Wnp2SHFhbjc4YXNIa2FxYTYrQ3M1YzlqcjdMU1ptZmxmVHhCcDZpcGwzMTk5?=
 =?utf-8?B?S3ZhUEViTGxCOUFpWkQrby83bVZ1QzcyREo4eHE0OUxSYXJ4M3ZuelFzUWJ2?=
 =?utf-8?B?bVdFajM3WW1PbGs5M0d4dXd3eGNSQ0IrQWNhTE1WeHdBbGppR0FIS01ZcVR4?=
 =?utf-8?B?ZVJPSVNVdzhKZVZWSzBRajNueG1DMndQME5WQ0tRbzd3ZExQRlhVbU9Cd2FI?=
 =?utf-8?B?NG45WWVYMGEydm1IR2dlazRDR1RWODh5SFNCUjhmRTBvczgrQ2lVRnFEVEd2?=
 =?utf-8?B?ek9JTkY4eUtkK1U2KzBvWWRvd1pkQ1Q0UnVJeC9xN0R6RWx0ZG8rUXFyMStB?=
 =?utf-8?B?VXpVaE53WWxVQW9ja0ZLbVU5VXlTSTQ3NzZNbzNvMTZpd3dWTm5wR3VHNVZU?=
 =?utf-8?B?by9Xcm1tTjBqK2pkM05DTmZRc094dVJHbXFkeGJ2VlRld25KYjlRK1RNd3Zr?=
 =?utf-8?B?V0g0R0wrSmRsQ3JubllBMHRrU0d0Zm5JcHVpbk5Kd0pJWnFHakdISVRLZDFF?=
 =?utf-8?B?bjdPdUoxWjhGQmcrZm9DNUdlbW1NSWU4ak43Y1hCaENuclVLcVN1eGZxZGhL?=
 =?utf-8?B?dzBNTmxYSmkrNk5QRXFra3dPNmtZc1VhZHR3cFdURHJEUUNoSHQ2N05KTXk5?=
 =?utf-8?B?bGlhQ0pCaEh4UFZnbnFzZGorS2tjTEoxQ1VWOXI1Nmh6S0l0a3hmNnVmOWt2?=
 =?utf-8?B?ZGZicG4yZDBWRFh3d05jZituSkZ5bUFLVkNXUHNVOGVRbGlrc3M2SVFVRm1K?=
 =?utf-8?B?S2wwc1QyYXhUbFJ1ZWRVSWt5RXJBVDhQVzVoLzVFQ3lvR0h0cnpQbDFYYlZi?=
 =?utf-8?B?STVxb2QraWEvMzdyV1gwZzk4SVZ1MUdhdzNZWWFSR2cvV0VrK0xmR2xYcTk2?=
 =?utf-8?B?eXdNdmVaUUo4VWdwcmw1K3p1Snp4OXFaeUI0SEJ6aktVQ0dYb0NQdlhLQ2k3?=
 =?utf-8?B?MkN0ZEs1bUVhc0N0OGJRbVV4aXRSS3pRakRzV3lQVDJtWkE1MUd3djZSTXZq?=
 =?utf-8?B?c2RvaUhpd05kSCtJaUtoMlFqOHUzQ2p4SjA1Sk42TC8vL0RlVitpRWJaaWhJ?=
 =?utf-8?B?bmZTMjNtczFIaDBYUkMxRVZBV1EwREVnWDFxV0x0aUZSaERTQ3dWelZJS2hp?=
 =?utf-8?B?SHNYWHlyTXVodmIwaXFsaDVsWE9RUENiamxXY3BCci9FZ1pYSFlEUUFRUk9R?=
 =?utf-8?B?VFVERkpzeG1FajR0SEdITlRubEFVL3lSMkdYa3RhK2p0RG1MSDI1VlhkM1hH?=
 =?utf-8?B?SWxKbTh1aHJsQnF3YndmRklZaGN0M2toUTN3dk9VL3VkQUdZQjJsTW1HVExs?=
 =?utf-8?B?RFpoTWpYQkQ0SUJsYXk5WEYwRE05M25vR1gvcVBuWHIxTWNWOURPUXBGSXMr?=
 =?utf-8?B?cTFCOVdiSThUTXZTM1hneUhTeUJXY2w0OTBPOXhQQ3FkWVMyYVRqOWRieDlx?=
 =?utf-8?B?MG1KeEp2SDNQakVFcmdpRjNpamxKWE9TR0xoTGx2VGtRdlFhbW94WHFLanNF?=
 =?utf-8?B?VHZ3eHdmNHFEeDNHYnNXVEtUV1R4b0Fma1Izc0Z4NExWWVRXK1VOdnc5a2RN?=
 =?utf-8?B?VFEwZ2hWYWlUUnpHUndYem5lM1RYVjM3ZXVESytLLzBBRG9jK0pteHorYXRU?=
 =?utf-8?B?VjV6VGlMMUEzMkFlRjNQbVR1bzByRW9aaEdWYU9LaTg5WDZENDZWQWVXSytW?=
 =?utf-8?B?RVpRNnN4NEZzQ0pibFVRZGxROVVDZ21DaDJqeXJQZ0xhT0F2cnl6WGFSZG1Y?=
 =?utf-8?B?WWp5eHF6QmxFckNEK25xdTBGamZldGJPZUd5dkZOby9OZHZGM1duTFFicXFZ?=
 =?utf-8?B?Z0dzbU1mSm1QZVlRN3I4NnUyV1JhaGlmYkI4RG9QZnU0Q0JCZEJWU29PU3pN?=
 =?utf-8?B?NmZXMSs0bG5oWVJobHZWUHBIVTZQbXV0Ym9jYTZjcmNkdjV4M0JKOEQ3NWtZ?=
 =?utf-8?B?cFlOWjdYdEFnV2xZcGVjZWFDU3hITFUvRHRZcG5aZjNkNkl2T0hUbE1INTBE?=
 =?utf-8?Q?O9TqJLipBhWJuKVG5bXoCOfRZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46863304-d6b3-4d64-cf9c-08db03970c5d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 14:25:48.8601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JWq+fSuPbP88JLCC/QUCPMTEaIQs8P2nFjEy1oU2SVYsIupkIdxLvAlmqF4l+4um
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5057
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 30, 2023 at 04:25:50PM +0200, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@nvidia.com>
> 
> The cited commit moves umem to call the unlocked versions of dmabuf
> unmap/map attachment, but the lock is held while calling to these
> functions, hence move back to the locked versions of these APIs.
> 
> Fixes: 21c9c5c0784f ("RDMA/umem: Prepare to dynamic dma-buf locking specification")
> Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/infiniband/core/umem_dmabuf.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied to for-next, thanks

Jason
