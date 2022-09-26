Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBEB5EAEAB
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Sep 2022 19:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiIZRxB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Sep 2022 13:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiIZRwd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Sep 2022 13:52:33 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2049.outbound.protection.outlook.com [40.107.212.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D38476ED
        for <linux-rdma@vger.kernel.org>; Mon, 26 Sep 2022 10:27:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X89XPZduz96+M6zlll9t9WM6vKsTRYNrkMrOOZe4avb+KJdRmyCDhnVcuL4zv4XYiSYnAJvEBxsN3zjtpnd5lGLjPVaj3Ts757vBqOOfmcQEJT10r6xwCmu1Rsn+5nQA3VslHBcN5JwwXMkoeFr7SC2CeFb+NfYx5tl4w12YSyKSRW37empVhJkAJzL45UaAF1g9o4fb7AZS7K7chRqwcgDlbEYlgLyPhCYP77bVB1N5vKXcelNiiKm7EmTi+YonmUAFBhRUQwANAn7FS/M9RH1Cz4kGek3w2PA5UoXIiwksSKzXcNvyQYxAF7DvBCgk5BS+4P83BpzgdymOMHTo7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXyNHw9qTKrO6ZDsol6hsCXD4tBaG31kTFAXXKO9/Ag=;
 b=LMSEzqKtibcyDvv+aQHKgVNzujHZke7iySXmkSxYUDtEx+lzSqXM6cbJz1VyshEZ2GamdSO6mA3K/mrMYkLIxVfB9p8ZwIo87xTJVXSH5edfof0qyqII7FEJWXSxvLTsPMoCd3r6f149C0W9/6x6dUP/FCcQELG8tOEOSmo81EvjKXXr3Cg/hiyxun5fRTWRjPGi0pTGH1zcE4u4dS3b+why8I3ldOwEEWgMvssuU0jCDdg5B96LJIgsN7cSCVP507mrQXFgF15AFUVSyMvcfp8H0YcPVEezlJ+T2H74qmUIE6bc3U3pSLjnoQOcXN8l4Keg4awuH7S9r2/F6Lybvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXyNHw9qTKrO6ZDsol6hsCXD4tBaG31kTFAXXKO9/Ag=;
 b=nrp5EzTdU8RVwPh6c1nBvv6jh1RjGdEEzpN0HPTodJqFvbGmGLcDs59LST0VHJzQ6prcDFZRJ+qLFHEV6wfwAtO+vVz55pJQzEd4HVMGWve8Ji2yPvD1hKCs53FXBqAGrQpifgOl2Pa3tbmjvHCsa4YQJVyLRDpjCPEsRjj8L7fFXlJAXFj4TIsJ08Oh/R4tdJWkW3i5nifFp9qCxXZETFKqoKO2LllqvNS19N0lnATqpWC/JO5BE4rYJyRI9al1PdqMeQV8hvgdEKRYhIaqamJ+ICrpAee8yKljQzVRlNRR5qlFzX+zK8AXPvwjb+hU++FISdiT/qePuhfMTg0Gpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SA0PR12MB7075.namprd12.prod.outlook.com (2603:10b6:806:2d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 17:27:10 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 17:27:10 +0000
Date:   Mon, 26 Sep 2022 14:27:08 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, lizhijian@fujitsu.com, jhack@hpe.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v5 1/2] RDMA/rxe: Set pd early in mr alloc routines
Message-ID: <YzHg7PFyMaJo9gcx@nvidia.com>
References: <20220805183153.32007-1-rpearsonhpe@gmail.com>
 <20220805183153.32007-2-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805183153.32007-2-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR12CA0031.namprd12.prod.outlook.com
 (2603:10b6:208:a8::44) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|SA0PR12MB7075:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aa378b2-63c9-41fb-f274-08da9fe4575e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IqtKcFw1tCGP1CuUn+AtJlOdSdvkwc+vI07KRQKZjs9+n2k6nz5BxCP1IKHzlm3okFC/oxJJpN+9aqIcGMDiDfyOWU84l9+3NbYTxFNt6WJHLVQwOCtPFguuwtDGtq5zferI07ZARcoLDgNGmpBmvYQrGLRNIzKsLt1lXZGRlBb4IzKxgsn9m3IhOSQuMMMPzIwGlr3Bg5snkb0KPCNwJUTeMVqBxjUv5Ks/HmdrIVq+Tb+sht7GCVCK8XcvN2NbiRzVxvMGYCuFzhU3LoVwh+cSi1/eRsw3p3iWn4GmIwF4R33Tv8RQveB/BgbmfNOx9KHxkQPbrCWmUYRTXAA2XSoFnAbxf3vCKtQPIDgLn9J7dsWLO0HnfD/AfqOzORAWWo6aX/Ll2Xud4nEWC/Zs/p/TcZezOC/NAJpPVRNKFdB5CVVdMBQ34ArL22s3NREMCXFLRKi1GP0s6VqFwzKlnE7WpAD9PLvTivd1TPH0u1IWvVGuX6rt1OMp7TEy0h2CTW6vFWydm2dX0jIrw/pTf47zc/qxfaYzxYO1xAAl2og0Mpeia+ZcmfbenK+j+p7SeRXvRL2U9jDfeO4x7N9ZgqXaLdalm/fPb/QviYbkw4fcXnUH4nDXWW8Hy0Uapd9X7rTj3P1dO1vCQow8tMC3bYmD+6UM0PLlvmGOFFNRPJDoFCvXaDOHs8butDKrlRlLmMD1YiC2wmdlInQ7HLRwwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(451199015)(26005)(4744005)(6512007)(36756003)(5660300002)(2616005)(8936002)(2906002)(66476007)(66556008)(66946007)(8676002)(4326008)(6506007)(41300700001)(38100700002)(86362001)(186003)(6916009)(316002)(83380400001)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F4kEI16nZsjt2TyEpQKONHkcxAVLSgf6R7XtNMMQuqhxcNzLeUEfWY0wsqth?=
 =?us-ascii?Q?R63mV1/Pm2ZGmlbrxxz2+rlp/pXgIxWtHsEzMCm/NzDk5k/8b/6pfUZD9cj1?=
 =?us-ascii?Q?r4e56IzEUixAfpT5DPf1vEDgTEF+u1TfK0EpVCUeUJqwoZco2k9JKIM1WeLw?=
 =?us-ascii?Q?VdAlt6Z9SBL7/EcVFySh3homuxs6bYSaucaCqfmanqCn8mE6+uMctYNuFi/3?=
 =?us-ascii?Q?wbaVtIm60axZuzn/U+nvrXdzIWxELjkZgqYoiXrS/5Oae+8I/tU++CNiGy3r?=
 =?us-ascii?Q?14/68SbxyV2EXPzUC6NviCZc789r11fA3XcVtMCn1pUenmANnwOmYKUi/PGg?=
 =?us-ascii?Q?hmVmOZuTSgcaKQ24gWn5srwVgMwUXIos/rKbweFE2glMrmHTSahjySnU8xbG?=
 =?us-ascii?Q?keBhozFkQxhauziOfFO3zPbCSEH52rvzrIcSBNx2BZmBsta0CcFIJbQCqkOO?=
 =?us-ascii?Q?2SjiaN67J/VV+tmS0dyjEXdwnAeiDNtbSuMkzJbaYbfb1EspnSe1sVshl16D?=
 =?us-ascii?Q?jAUztpJd+C0d41GHoqqUaoUW3rj8rlSu+/p0/PpbbRkILjyQvyBO2CCEIvBM?=
 =?us-ascii?Q?ST/qRQ3kMmvgx3GAq30yGEoXmlgshXEPQC5tL+YNoF3iHA+Z9fe0Z6D++rrf?=
 =?us-ascii?Q?wyH1AM/etBtzgGwf3UeAjUxGe/xBpgl7gQnyF3CyIvxRTVbklhsm6WD1U+D0?=
 =?us-ascii?Q?/76XwwSR086IF9ND/eJNGVtPM8N6WtD0b0E1i2rVgKwK+nf2ZVojGyZD7pAy?=
 =?us-ascii?Q?iIq0rZUyAv/WvoXil0v/RFIqfzFIanXOf+p9hO0P6uPCYQJJR2ZnXrouSt+O?=
 =?us-ascii?Q?JPyu3Mu5flGMczZPRDSUMZ8nSmtNEdh/7GsLgT9JFXSLZvyJYokbrbmA4DxV?=
 =?us-ascii?Q?gkRlgH4V481cz6wcYp7cN93gfHGRd1E0fDd5XYtefaadcQwNou65bUBLVC/I?=
 =?us-ascii?Q?KsCIycm4rGXiyNY6Hs54lnCkpE+FhR7eHrZr2BWLkeeMAjEwOPumbB6MIWEj?=
 =?us-ascii?Q?+2Vr/eyJKXvFKNB6+B/yoo32Yq0D3GmArnP6KWxwzf0lpjLquaR+uihkspDv?=
 =?us-ascii?Q?OqD5z5eaH+eELKBOGgXBizrqwaUgLeXOpO3zBI3Ik3Sk5Ow3xtco4NUN/QlD?=
 =?us-ascii?Q?UGnosmrDbNTqNkMGNhLngQZMPwhinbYCOH/4ed9gvXOaTkF3gEFVlyxZNqFH?=
 =?us-ascii?Q?gQOBB05iHmS0/eVQ635YZbgdkrdwgYOc1N4QZov8cHbCMK0/LFNbGw7AzEDv?=
 =?us-ascii?Q?n0K1xHyIJ4kmq6vTezR9vhmzluQQO91vRyGKqKHoC5uW2/zcxkT0qbr/4mjP?=
 =?us-ascii?Q?X6gg4e8QyWk/gNhYnxB7CwRN58WhqJ1Ewdi6whAJDLO44F1elGA2F0lGcaK+?=
 =?us-ascii?Q?GBfcuTceHGToJSR/6iGZkR1+GD7SRLHokZ8buzKJ3jV+GrITsQRSGi7WOuQR?=
 =?us-ascii?Q?IQvpXFg+zy59+iA7cbjWXKNbzfvnUPBeOJN/fdhaBK16U1c5M3WR0EaVfYbs?=
 =?us-ascii?Q?N0LADfYIALyN8byysHwQX8Ajw0fiXxXgbZvVVcjHlrLRaAGMtBqgZQpRUUxx?=
 =?us-ascii?Q?n45RxQTQaeFGh8+9maw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa378b2-63c9-41fb-f274-08da9fe4575e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 17:27:10.3733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XPljFM8ee2EikiQMBjwD7rCrMC9IpeGzEIIZxEFwLtkAlclT71bunyD97BZm2DNE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7075
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 05, 2022 at 01:31:54PM -0500, Bob Pearson wrote:
> Move setting of pd in mr objects ahead of any possible errors
> so that it will always be set in rxe_mr_complete() to avoid

This means to say rxe_mr_cleanup()

> seg faults when rxe_put(mr_pd(mr)) is called.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_loc.h   |  6 +++---
>  drivers/infiniband/sw/rxe/rxe_mr.c    | 11 ++++-------
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 10 +++++++---
>  3 files changed, 14 insertions(+), 13 deletions(-)

Applied to for-next

I dropped the next patch since it is a NOP due to the protection in
ib_umem_release()

Thanks,
Jason
