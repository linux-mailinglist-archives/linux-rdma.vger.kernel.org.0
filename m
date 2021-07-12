Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D893C6207
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jul 2021 19:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235694AbhGLRi1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Jul 2021 13:38:27 -0400
Received: from mail-dm6nam12on2087.outbound.protection.outlook.com ([40.107.243.87]:64904
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235375AbhGLRi1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Jul 2021 13:38:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQ88wC90Xra9kiIMZDbrwF9EiUw6atzqGW3aQvXHNu+u/6EeOoGQ2DJaI4XpHdTaaXJdASgxaVQ/K53p6DqtcCypDEN0lUmFYAACKUc5CYWqpVoxFO4dUjQehGiMVR/7CRD5eNOs3hVBLmUgwG1/PBU9hz1kb09CJBelmTj26nTkzI5S614b6wAESskj/om4JTWA1EAMr3uYrp9UONDQ1UUX8QPhsVL2XFKcdWUVAL5LtyeOupzBnRq/1ebHejIQn+QTZd/d786VyaTa38nvUsKQRNBxc8IgTTEEP4+beCwnsY0LvvgKmM1UEEiEwV6tQfAPj9pqCAFLdtzxKY+gTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RALaUzdRhegQJSqNbifyDshN+OWycfnfAS+XCY5/3lo=;
 b=KL/AgF9U/exKNgJUOokcjfUySDwCEeMrdc8RKnAl7HqAuUbx4aXD+FRz/cJBpesjFNg13gPpfcGC8ulUo46Y4gqoCApmS2j1/wYBke4xLGIz3VAzI7qfLs+2pJZgqNQXLZDrg5J79yHoT7S6al7DuirZwNvQRESS+7I468iH8k4dp5sNGZ4oSETWH2wzqdPPUU1UGZJXwpWINocThBRxZ1TxfeyDEivdKb26AUQsrvYi4hFVXzIF06XthRi2C+4VK8TmsADxQ9ctrIsmBklLD/BDLtMRe0Tp04eaCAp5wMp9uB2iVbMw/DZ+/QUmFw3JV/okA8fhgip/gURvYrKCyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RALaUzdRhegQJSqNbifyDshN+OWycfnfAS+XCY5/3lo=;
 b=NY0DwEJ0s0MhMP1KEaM6XfrCtevnMmC/amLvXYnwmQ5X2Mj+hxBnO487+OrcQINyzdiX5plTutZqjx2EaVLWWEgN8mHW1G+CwKHKy68mby5UCpYwePl6y9I/uI8pPOP82rpY9OMgRTq2o+xHEHhmsNkDMwVAZupllk0N5s9E2FUiEvlNpChcE1A2XDVeP8FSWVEAF4UMkkBDumRjD0r5Qkix12x1Q8lCDCru+HOU0U2/RTTj3YrJAAV9FgBbiywMBRhohjTU49fvKOrcFKrZsPG1/gSm7XdXyINz2e0HAW0ep5LoVbxI6nBE4/u5zUfFBmGnYdvNiN3gan0ArV64sg==
Authentication-Results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5255.namprd12.prod.outlook.com (2603:10b6:208:315::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Mon, 12 Jul
 2021 17:35:37 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%4]) with mapi id 15.20.4308.026; Mon, 12 Jul 2021
 17:35:37 +0000
Date:   Mon, 12 Jul 2021 14:35:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        dledford@redhat.com, haris.iqbal@ionos.com
Subject: Re: [PATCHv2 for-rc 0/6] Bugfixes for send queue overflow by
 heartbeat
Message-ID: <20210712173535.GA258722@nvidia.com>
References: <20210712060750.16494-1-jinpu.wang@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712060750.16494-1-jinpu.wang@ionos.com>
X-ClientProxiedBy: YTOPR0101CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::31) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTOPR0101CA0054.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Mon, 12 Jul 2021 17:35:37 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m2zqB-0015Rb-OJ; Mon, 12 Jul 2021 14:35:35 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b54f8da-11b5-4e96-2972-08d9455b75d1
X-MS-TrafficTypeDiagnostic: BL1PR12MB5255:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5255AD56B262E8A893EDA563C2159@BL1PR12MB5255.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TCGLCo9AVy/xFWZUZOdn0aj7Fxce//ZCRNNt5zVkGmAj5rYuDLl6apYl9XZIMKI7/s8Bq2nFmL+K77CUiueoo5aS3KuI50ZgbrNpHMHK4eTXg48NSYG+5sD5xMge0k7S7h/0fVXUvlvcYZQbsh0/vpmAA1PHBJ8mNHpbeOq1DDE8R8GhVgTfaJrcBB/NhRGwQsshPelVYvELgMgVL8hq4pg3RgDpwn04c/LuQaBkC5EkehBnoZeprv3OjmSa/vNewRdemosVNf7t+eiLbg26NRGoNzwtFqTDLSKQ3Lg8OEt+lXTcTAo3ub9+q48wnTd5qCSNSuRiNjhnU2U66MjG/eHFBlaLyFpN6iYaipjFAlbqiEii7zJAOAr0KoADG3LXngVjnq//tyckstFUnOc4OwJFBUBcx0nUz+5P7DNz2bYdHVdw4mTfiK7LMwOKZLoX6Bzor8Aozl/PHn3aVvYur0VISg13aGY7EYerDlRPscKZGHeGI3hlr05e0eguR1aApaAgC/iP1UB2IdfIZCkb2e/IxD8Jd8pFJtq2SgveaqL3yIHNFTlhcoJ93GCaSHNst0Rf4mciDgYpKcAjqoBn/b6Gr7AoywCgm8YE+KzIinQaPVsOlTbIZouUNFdFM9WqmBvHO2ANb2Xs9mDdmxGBhw4yDmA4no73g0nu9XN9z8dMVyazQ2cGRoTx0MXFN5l+iZwS5vEEG42HVzkr9HMtgCBcUE4OYYCjJITadRy4zI03cMJpKFhFQpF0mKaPt+qwdEhK7JbURooaplpg+9OXQ91a2rJyqPGpz5AbFEfRrGs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(38100700002)(186003)(9746002)(5660300002)(83380400001)(9786002)(26005)(66556008)(36756003)(966005)(86362001)(33656002)(478600001)(4326008)(1076003)(66476007)(6916009)(2616005)(316002)(8936002)(426003)(66946007)(8676002)(2906002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?21DTSiDwmD14Trt3g/mb+tYmUqgaqF2I9lzAW8GQP3H2Z8TsdNua+FUd9te9?=
 =?us-ascii?Q?E2RivqeCC2YbKE8LsctADc8NgV2Xa9780JyefNC+BQHHUnNRTBn8JO+sd98c?=
 =?us-ascii?Q?8eEC6ddLagwN/5A80rpJx+79wn4g7MptJ1eq2zwC03QgvU5EYXO+13tzJtSU?=
 =?us-ascii?Q?/VOv57v2Acyu5G1YvUQmgmehsO0NjI1Mw6LpVDDvtCaMg+a0ZTSclX7I/idT?=
 =?us-ascii?Q?nKW6fOkgtFKbDOIGkn0YKutur2tY6kLRs/SQHOkPcp1XYk7CEYygrBPz2vYj?=
 =?us-ascii?Q?P6pq2eWiyGLJWbP92w2im9AvUT1VJlJ8U9iGOnZS+K3VhYQ7HZms1lLswwYj?=
 =?us-ascii?Q?HynFl+7u9RVXppXwHQMsWPA/suZ8rYPeirTdFZJzqQo6drbeIWqgHCFuOcHh?=
 =?us-ascii?Q?1x6xzQAfh91WyBWc1GUPfKhE5y/ywxk9kX5TTzQUT7sb94j9ecVndScUN2QX?=
 =?us-ascii?Q?T+MshimKl5IxMjMnQ36iGK6uvcBsJ6vgIwLRjA1o6s3OZFQ7qCpet6xmjcSg?=
 =?us-ascii?Q?hFvQVT1FL0blGYFYPPWED0YlFZhF5unf0LUaLG8QoqIBVDMaOsoI9brE9yVY?=
 =?us-ascii?Q?zSOBknwQfHUhDw6gkEtszjtNv9+b+JfXzdRblo7L/JlpznaAf7UDKv1DZMUo?=
 =?us-ascii?Q?YtHWyCk3nSMj/s2ZsO7omCnlq46TajcSHfvrC802tEegssN8Tl54ctf67Src?=
 =?us-ascii?Q?2ibLA46l5oKK47A6/+fncc9NY4kuV51C1uZTXl5VxNkcOTIpyzwgBhdbny+r?=
 =?us-ascii?Q?iV247btzMe0Y1kMKIcDv/IawPlkRQypD9JtpqYNBmYTC1I8Eni+CnFWafFk/?=
 =?us-ascii?Q?8D19v2Uf/bKqd1oxs56cvkD+ZtfWZ5yqKQ+kiWwrUciUFATwqc6LfFn1ez3F?=
 =?us-ascii?Q?CHm0KHbgebyTFjZODPFdX9R2NsC2lsJIollxNkXXtVTGl1p3mUexazFYNiZl?=
 =?us-ascii?Q?OQ9aa1q3vYWNL06Z3Q3RtlHqlKzTAqQXdBg9bnf63ZcgL3YFayFCFM7cVgZW?=
 =?us-ascii?Q?Ir5MAs8vS21hOFk6dBkCRm8NMDssBdiKEdAmeE3dlsav7XxdUFQNp6i/xtRh?=
 =?us-ascii?Q?6+hyuXGcrD6EgORS9WT+a1fGZrdXRAzKGQurkCZ7K5oXyP65CcTVPvgsQ2Zs?=
 =?us-ascii?Q?Y+2h2dpyhOAojbemHphMdE8en7sNw8P4H7JGmh5xuOcNiFGuaxxQo2xK4hue?=
 =?us-ascii?Q?+pH+9anYNYb49bZYF9OzwV7D5L8A4UPrn27hg5BgVfP5DjGYPHJvjKlraEEb?=
 =?us-ascii?Q?HXRGoDvrsamR+lO06uWdiIkq931s/y2iRUI6FG7KCdh6gSYACZ1UTvLABi/n?=
 =?us-ascii?Q?ufnT2LCmMxLmuu9lC/DiSTnF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b54f8da-11b5-4e96-2972-08d9455b75d1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2021 17:35:37.2430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ncfGEGDE/4hJ322letD93By/jyzN8k6j8ErxHNT/G89+PppVmmgvHggk9ikuTlxZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5255
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 12, 2021 at 08:07:44AM +0200, Jack Wang wrote:
> Hi Jason, hi Doug,
> 
> Please consider to include following changes to upstream.
> 
> This patchset fix a regression since b38041d50add ("RDMA/rtrs: Do not signal for heatbeat").
> 
> In commit b38041d50add, the signal flag is droped to fix the send queue full
> logic, but introduced a worse bug the send queue overflow on both clt and srv
> by heartbeat, sorry.
> 
> The patchset is orgnized as:
> - patch1 debug patch.
> - patch2 preparation.
> - patch3 signal both IO and heartbeat.
> - patch4 cleanup.
> - patch5 cleanup
> - patch6 move sq_wr_avail to account send queue full correctly.
> 
> The patches are created base v5.14-rc1.
> 
> Since v1:
> * rebased to latest v5.14-rc1, target rc instread of for-next.
> 
> v1: https://lore.kernel.org/linux-rdma/20210629065321.12600-1-jinpu.wang@ionos.com/T/#t
> 
> Jack Wang (6):
>   RDMA/rtrs: Add error messages for failed operations.
>   RDMA/rtrs: move wr_cnt from rtrs_srv_con to rtrs_con
>   RDMA/rtrs: Enable the same selective signal for heartbeat and IO
>   RDMA/rtrs: Make rtrs_post_rdma_write_imm_empty static
>   RDMA/rtrs: Remove unused flags parameter
>   RDMA/rtrs: Move sq_wr_avail to rtrs_con

This is not really structured well enough for a -rc patch. There
should be no unncessary changes and each patch should try to be self
contained. Avoid "cleanup". Carefully describe what user visible
defect each patch is fixing.

If you really want it to be in -rc then it needs reorganizing,
otherwise I can put it in -next

Jason
