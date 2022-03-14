Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC714D908C
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Mar 2022 00:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241248AbiCNXqF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Mar 2022 19:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238359AbiCNXqE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Mar 2022 19:46:04 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26F02C645;
        Mon, 14 Mar 2022 16:44:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfGhZekQ3Fmq/dnoza2c63GSXlX3kAUZQm70f+0vk1FI0maiqdWGav4/cucvS4ZYqpm6ZcSZtvQjsfOEzz2FBuSJEwdWQL7Zso2uSEyEpAAwddVdVSCH1ypAwBpBwLTYaKI80OlIfS+JZjbuaM1bUrfwTPF9NDT+so2jtnVhd43shICwJ4E7FeeQNzIfLM4zCYkP04W0cfHxWgxMcpcil7upoyPLVmtl9F+Oc4e9i7GiIoTbJBap/dO29biHkaME3e8muUY95OP4AjHwrNG19UH3x6eTWlCf1Za4iazJt7SR7m7vqDKxfS/FT5zUv47EMx9I9C92LLfW2qciG8FAIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7eJ/R82IQb2jAPePD173Fn6g5QA82bD3S4lt8mUvuI=;
 b=PqzoY1b6odlWKJYTNZCFSY2X65yRwB0CMyeRhGAtfuRgzwnDo5/CncuZ1jyP2zQ/O48hGIqUzxUsJPxTY3y8kUfAmLAP1giu8blG4d16IwRgWNiSniDpXvCT9F5KQI1ncsoxO3bRRcUE4iMlXc0AiivM3H/AcDN/Abd5JIBlMYC5AFXU4rtprfXP8rWwhACqeMzfURq/v3YvpDd2+D9rJOWXiRp3u0Zdgc1wNYq3VxjwXkXnum4bpkyxTUFOmqsg+wHG+LZrXKT3estAFJiNoqtvRJ4QpSWPa1bV4M5Ju7Qv0I2gqxdIxnyFE4tZCcL5yaoKG703tlj3SjFoH/bSsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7eJ/R82IQb2jAPePD173Fn6g5QA82bD3S4lt8mUvuI=;
 b=Lpc4keRU+PMDk4aClvxzMqK08wo0Pgbood74Ue05HG8ol0Vv8TTB4iy/897Zl4kqnijHwlimdN7pQvKS42vBJj5OyMZHd88eVAXuz94n0dwnDz4zXzVrMGUYdDrU1E4r8d6FMymPmEpaqzGil2RxlniAGbL2nQBxoSg9ale9L8o/gMtnt5j1pMrted/1dVun6oXALbectD9ttoeuHy6LETMAfSg7A0gJV9DGOXfIA7U4kqqKTbS0bRDeVfkVgXLSwTQrd/pUyug1cimM0x2dB8KNHky8ei0JZO7VaBpgj1sJzjSVTe85mBpOJPbHwdhV4z3D+Z6z455INekk+zZyrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by LV2PR12MB5989.namprd12.prod.outlook.com (2603:10b6:408:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28; Mon, 14 Mar
 2022 23:44:52 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::51a0:4aee:2b4c:ca28]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::51a0:4aee:2b4c:ca28%4]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 23:44:52 +0000
Date:   Mon, 14 Mar 2022 20:44:50 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: Re: [PATCH rdma-next] Revert "RDMA/core: Fix ib_qp_usecnt_dec()
 called when error"
Message-ID: <20220314234450.GC172564@nvidia.com>
References: <74c11029adaf449b3b9228a77cc82f39e9e892c8.1646851220.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74c11029adaf449b3b9228a77cc82f39e9e892c8.1646851220.git.leonro@nvidia.com>
X-ClientProxiedBy: BL0PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:208:91::14) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a4eda77-456d-408b-081d-08da0614a24b
X-MS-TrafficTypeDiagnostic: LV2PR12MB5989:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB598964E99707A9E7A4F4FC9EC20F9@LV2PR12MB5989.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RHeNW3gpa8MQWFyMKhZpxozAM3tFul4j2gDHkfXaHbibL0JiNEFun8L8/cnzyvCOLddxhPvvg5kCk5OqqDojqFLDyG+EPGUXoqogzTyGu/Yxhyq4jk8dOzHQs8309NJKGmGas/btoFBPqVqINJOGzkOVPoxZNYdorthIDo+1ur9JD+JzAmqjTt71f0Kd/Tqb1ZwqJj36TKC42eAfB79CtTL/XNP/Oq8KyqOcjOgBzPtygUjBAZvgvGHsK+zyHQ2PKo6wTQFUls/YVA/lMuDXejrx24x1lfEM86qnANaAvNq9+EWsTDnHFWUd9yT/RojhEcD+vFGcl4QMZzXabTjxEBOoWIrjbtHDlaDGyFxy93GDJ8P7fwErheQvqujrZbr9doyzdBZkEQKfMJAZ2KkZh1aTkChYvI5Xvli5KkTHlPHAFIfSljwLESaRTvJKHuhpw+g/zg/KuO93dc39EVuFgCiVRiSz5ZYOn1P1lyGz3ZCAFFnoGcxNjoxjXDhQtBJVrsFFs1UEqDIQbqVD4qNt1ulog318PMhyDp1Y1bFllfoWGZJQdcBpMO3qT48g5hwFiVgijXkNFOVkpKxGs9sRrRs7ql6KGsJrJoFESwAW4Gssn1zOqO5OTvReINNZe9W190UEEugEE+1qMJufQr1eVn49P7HfUSgeIF2nEhtDuOYC2nFbv9jfq0gQi7kZHi7z1quEus8xEQIJVT+8h6vKig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(66556008)(66476007)(508600001)(38100700002)(2906002)(6916009)(33656002)(2616005)(6486002)(54906003)(316002)(5660300002)(6512007)(558084003)(86362001)(1076003)(8936002)(4326008)(26005)(186003)(66946007)(8676002)(6506007)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3K5nPneAtdZZDKtz1n2gVYvzdVJvhCc1SEgE+lghGzBWSKoZ28mwMzZOZFsl?=
 =?us-ascii?Q?0WHIRcVb6tAsaGDNmC9CcV6ae6HIuW3W3GHPv6MKyI1jwTbEivRjpMxBedyC?=
 =?us-ascii?Q?MeKOaAn6yQ6Y0Ubm/m/tAvukBb/1yAnWWnk4uk5QocNh/B1rutZ1Chyvm1cw?=
 =?us-ascii?Q?LlXa+LPe5GWgjWkNG8Wap7xjP8QpHpc+RUh85QWnWDt7DxVfVHwhomn2m/Bf?=
 =?us-ascii?Q?9u/le8R3S75g2QPQ+V/VTjPJx19UprP3S1waBYAChpn2+LNejrLplZvU19ut?=
 =?us-ascii?Q?RfRwKBTRapRmSoUaj7VFUClxIhgyHZD466VD1qvp+KZPZidHN1Beh62oECUU?=
 =?us-ascii?Q?yXOW7IWV1Q9Nnmf65K96QHQWy186EIzjfRIQrjGXniLrAdJF5mzbU358BPme?=
 =?us-ascii?Q?KkhwsfZexX3JhrIp/vLCrKG5TwijYyW7eLyaXOzKWp8Wz5E2/lNP5Lot3tvj?=
 =?us-ascii?Q?p2GRTkEmi6qCspbTdWLnxnSSWlXGKJ5rgdof+dEYzzMjmOIEqLOkm4VHFDay?=
 =?us-ascii?Q?5q5F8DezELnpI85UOnbVi0oUw3x+c1Yx/6AroSoKZQqxlu0HUzvHnO5LVzq0?=
 =?us-ascii?Q?PM2oVGAciTGjHdm1w8cIO5Tqc9SNSKu4ruplut9Ow39INghVDwkCn9dXL6Wr?=
 =?us-ascii?Q?u74JeaxiBZF7wbqFqNc3BV/1QU6wtVyEeVjPBfaSl+nhkrmyfcl5dhUUMVTw?=
 =?us-ascii?Q?w0W0qeIOHaM4PETSjozwtVVL4lLG7+IZsUWXCKB+VpCr3D4Go3jR3f0A4Kls?=
 =?us-ascii?Q?wqPsgJ3Knp70UB+fJ0P1jfK6ATGKgBgOLTsqnOUS+wRdODmhTizDl00aPn20?=
 =?us-ascii?Q?tQ/+Cmtb9fVrCTkZRpdiEJMWuKFWojdZKb/KEF8/a2mNRLQ9OBv4L+MZ16TA?=
 =?us-ascii?Q?zxqH5rdLDiH7p4sImp/XgsKRtONG3rB97I8L4pc370Wp67RkfORksI+0lIXE?=
 =?us-ascii?Q?KxcJTWsRdojzaVWOn/3WyDxeNxeSf25785ykvq6vQFOum61zBQI4E9N/8EzO?=
 =?us-ascii?Q?SAhl/xp6TBUrdEXj05aQ2Ppjog+zZRXK93zQmkWz4ovBP5SNXWdPofIxvo+n?=
 =?us-ascii?Q?O5mn9uxNkropjIfuknEKTRsEx+82lm2GAcw7LWkDglaQr9nGDwm6RVRQB4ma?=
 =?us-ascii?Q?M1KYLkYYN9HupP387QDf534q2VvwSo34umYCzk/Pn8Smrw2A+W8pKioVzt3L?=
 =?us-ascii?Q?vD7ExACzJFcuS5gyvpKN/heB0P07xp98FilNleFNFkzFiMjlgPwBEcxJJTdR?=
 =?us-ascii?Q?+wKu7h8vAlFpyBZ872YQvrJ12rjUHDbc4m6WoshPYVgGyz4pDay8S7n+KUHy?=
 =?us-ascii?Q?RWm145Qix1ud1MIWllEMKlm1PlHCseQzujkP6J3TOIoYHFEB7+NpLTFOsjWT?=
 =?us-ascii?Q?MSJWLAi04hgru+z7dguDH70WX/TGrreN4Ybh4OD75pfc962J99nHp3EJtWGe?=
 =?us-ascii?Q?tMSZ7mYgqV5JWdSS0IqUsWILU9Qk8CQQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4eda77-456d-408b-081d-08da0614a24b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 23:44:51.9679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3zOw7zZzR74Lu+CedL4vVXjGZQfSmlxZ0wqj5O7w0RpHs03fUS57nsjgq0mSc3d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5989
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 09, 2022 at 08:42:13PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> This reverts commit 7c4a539ec38f4ce400a0f3fcb5ff6c940fcd67bb. which
> causes to the following error in mlx4.

Dare I ask why this happens?

Applied to for-next 

Thanks,
Jason
