Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F345A4ADE9C
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Feb 2022 17:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238447AbiBHQsl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Feb 2022 11:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235286AbiBHQsl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Feb 2022 11:48:41 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601E6C061576
        for <linux-rdma@vger.kernel.org>; Tue,  8 Feb 2022 08:48:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFxIxRBHfU08PYwI8IBVwDcLH7ikm3VlJqysFFcc9IUu1lPfxQsluVVzbxz2IrhcXRzH8XkE3wM/0oPHXrOYnljRK+FAjWDJC1LKlk4jGFui2nw1ElffaxTGoTOouuvrsvtXjFZVomhp4P7NmQXS5sbwo7z5B/C/GsProoJ5Mnp0Lkl+fViEk7uKLKwzaBSVSi0Q2vDUtRntIUdqWmc9Rg1WVMOIlpW2aibfLuwGlZx1bpiaFWI+oMWgWtyhU3LHFkZjM0vKzwB64tScEWd5naGN8ASV3h7Y9RbgMqcv7ETxdCoogbG1xYzGJk8MCV+WpfaJU3CrIw/ClITjSIOA4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9B1dcyh1H/xhoFT0Ic7WkIFS6vkb8TrwJg6//2OXIWc=;
 b=AgQg/2bhZBDFwIje0Iueaoim2M0bMXNA0pJqeUcVDt2t6QWl1AJJ8e42/1AiXgoXyH7E1yhp9mtUUODankTm5hav2CmXuBbsZhebPnYyz8GvSVc9rS9yFIWkSmswzXKM6jpo5YMn2E9qp4Jx4hOeogD+DK9+VSRAslD4vkREr3gRa3Fajs7U/npCYZKFKVUP/3eMvZJDI/FPYH5+IF0GCTpu+obrRsz8YjH9uGNT3R6chCkiJSEXHgSkR8P1sbEGbnFJS1cVJRbpy+zQsfMZX3AZyWHYdlXs80Kn1F/EdUI63imC5QK82BhrNaMDNpc7m+2ScMROD3/lhYmFKoV88w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9B1dcyh1H/xhoFT0Ic7WkIFS6vkb8TrwJg6//2OXIWc=;
 b=p+01ZjFZ50Ml29WiqkS4BylOP6GNUI1uQ5CtSdGJEe0RvbOEGJB5gBLh68UcWZI3aDcbzZa16rRnDlM72/PyydksYsiKvsig5JTsaKfVCtpOx+tGuN4np2JlhcVIcF637B+oCYM62Yx4CDM6pkgadZd+CFsQexFWh2eJ2OtCOLq/sPveLIOf3HIAlZeBmYrJ4Bj6nKZ5gCFmjpdQymakPbcUuJUqhFdaqbG7A/0CidvJDRqSONuDAAGGelC6Wx1YdoYzDDOmia1Yn32daFtD3hxLWuYtT7XbmygG1QwKFefUhR3K6w+k41rfW9bIMFrIaptHFP8e/WHNHo0jc9AyRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SN6PR12MB2845.namprd12.prod.outlook.com (2603:10b6:805:75::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Tue, 8 Feb
 2022 16:48:37 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4975.011; Tue, 8 Feb 2022
 16:48:37 +0000
Date:   Tue, 8 Feb 2022 12:48:35 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Md Haris Iqbal <haris.iqbal@ionos.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        jinpu.wang@ionos.com
Subject: Re: [PATCH v3 1/2] RDMA/rtrs-clt: Fix possible double free in error
 case
Message-ID: <20220208164835.GA180654@nvidia.com>
References: <20220202150855.445973-1-haris.iqbal@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202150855.445973-1-haris.iqbal@ionos.com>
X-ClientProxiedBy: BL0PR0102CA0059.prod.exchangelabs.com
 (2603:10b6:208:25::36) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 103ee6aa-2fcb-4fe4-3377-08d9eb22da02
X-MS-TrafficTypeDiagnostic: SN6PR12MB2845:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB2845248DD483C882BE56BCFFC22D9@SN6PR12MB2845.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cVT+Tb1CL51cskdCJFqIYTtwPSuZ12Hhzr9vExAlg9Hx4Yh7vHFXceJ8a1L1SnMlzl77GoXg5VeH22M+yAi94XeN7IxQ1zwo1Tha6S0zk1RUKSNwtSFHinaXxw9hO5+UWA0lybw/KkDcw4Zi6fy6InkvYg69APePk2F6VCwLuq2qo+65jbls7Ay6dXvU/nqQJwQRmEFRIRjj8H2X7BH6HKX4yiMIF74ZvOKzp75LkLAIVn+pEkRIlYeYXq60l56ykYKhjCozTqqDIP05BO09iI/FMur3MAyDBvvxtKFTZUAr8vkffYrKl5H8txFA/ZY3/vtrack2NNt4U7kdYvk1NbuiGMIDL9FMcxpyPgWqjvlFFo3JTY94FWRZdPwOrfP1sPhUu7ZWQg41DVhPVPWPkayX9AE94OzHPHzgrZFcihruZErRIPyIZ4AUfugxjY47+74hY3MPzvT1/WghvrwowVudWz2mflP8HXPD+e30AuD5mRT/n0engVZh8Eh8W/BlqbG46hywnSSpYYMpgvNckFX9J0x1B74Ct34eWylcmc2Skkp8jM3vfKDKNGSfvqg2QD5RP2yND7OiMhPOiYmJ9TYSnVaZmECAwBYaCPqV0Q2Lp0aIokP0glJQNMtyXMXJ8LwQyMM+xDnLzKYlOe2zbQ24832Go2psJofUfL8fwOnbo3a1KT+lJ4sLkl68hY72Z68XqmEHVfemSbOhuAjlYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4744005)(6506007)(66946007)(6512007)(6486002)(86362001)(83380400001)(316002)(6916009)(5660300002)(508600001)(4326008)(8936002)(38100700002)(36756003)(2906002)(8676002)(33656002)(1076003)(2616005)(26005)(186003)(66556008)(66476007)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AX8oCTZAAQCr8cZ81rjTsAnhWhfJO654Mzsz4bd93iGU0Ka1oHK7Z3qpIl8l?=
 =?us-ascii?Q?+eLhKv2BVcS01McqUwK6u7Taikqkm7L65l9z+qQd/NNd/tU6b4bX0kChb7i2?=
 =?us-ascii?Q?l5zvl3c7Qzb0+4ScYpdh6i2ysRzrhNM+ig5aTZZem3tYtRFRRWm2MeMnIoGG?=
 =?us-ascii?Q?hP4NMT7MoS3Ez3fKBifV+ET2bXJH47HzfUVmxZZSOvJaNF7s/JPx9Ha3BJOF?=
 =?us-ascii?Q?/PQs6m9eNw3IyzknCngCLW7iFQA49NWXeksOdS60L0iSpRzaHQNwJdD5D9MT?=
 =?us-ascii?Q?Kh6RfuSCIeZtXSSZpywiKCXYJ2yZy9bwCaRkVAo+cxPooMuZqCWF846PNY5f?=
 =?us-ascii?Q?CjGW7+DOp9ArO/yOmr/W+A0MDRqcDaN0iwaIQ0rW03pHHNUeoc4TOJm+5/cn?=
 =?us-ascii?Q?ndFu41Z6VMoFNRpeBgiEKI1kkaY66Bs7c0sXSKurix28tC/GSmb9qFLRJdAs?=
 =?us-ascii?Q?C9hRIyR8IZ1asRFswiJ/a0JM2MhXG74faeA+62SOOMGd93J2JNwPN4Q/3t+2?=
 =?us-ascii?Q?nIwG8KZBIJW6Lo5BzLiLhLbLJA+HXLJdUa/+TmAF4Ol/LXJ+3Xoo+kPkCOV9?=
 =?us-ascii?Q?AagvCD7CZlytthmDyutrpome4wQetC3izYHQPYC8YUiNLOEurmiIYC0BdqMz?=
 =?us-ascii?Q?ur+RoQMS2YwmIBpyCmCDXcmJaZif8jW5jzrg+dxhbICCFY9p+8dGH/opb7yk?=
 =?us-ascii?Q?bZLl16UPHcs7DhUKfrSEhtkJ4QNcsGrnBcSH56NlvdNY2R1+gl0fVSrQK4SE?=
 =?us-ascii?Q?hoCAF9uevwQVH7HHRFCUrih1J7Juf9wKWXUA7SLPF2s3E8qEEIaVmLoW4gzE?=
 =?us-ascii?Q?t+UWgg4GJjx2Q2AYvUuwh1R67v+UCpNG65XYL90eFeZnmEPLw9FyR7r455X1?=
 =?us-ascii?Q?HGS69ulhdat1V0pImOARpi/Igr2SbHiXif0lvuGwu2oC2RsyzpDd3lXck/Yr?=
 =?us-ascii?Q?hC1RA9u0flHerEDvyd+Boj+7sE57OGxYRqnlvxyg94njGCAUc0DTH7sy4ebD?=
 =?us-ascii?Q?dio6M5CzK+sO+h8elWvmPwLXk2JIfxhqVDl/IXXn2yIGCcy4IoEdk/lkWMfM?=
 =?us-ascii?Q?WmuQc01rDAcQoIp2p5Y1F5tIkYjsHOKK3B+oBv7S2qQ1DwOfL10L+1rMdtKA?=
 =?us-ascii?Q?IgotknMHYJdAS2y/dvEbyuPDFCp5OtA9E+U/aIMQEWwEE+FKd6KKUzx2jCCf?=
 =?us-ascii?Q?FlLMymCuIbYfBooezlqFUohKN8kLIZVvVeKrZWnKH39v/Y+2SULb1uFSr5In?=
 =?us-ascii?Q?pVn88+d2rsnsowXFmqwE6SRwCcRanl2T6qCVqTgq04IdMv3IINIiA/ddJgES?=
 =?us-ascii?Q?SAgNh1lQuTf9lOEer1GXOwvQtnIM4YWbKTtgwbjkIfpuES+i3mW8dis4Kh1i?=
 =?us-ascii?Q?MhxGU/proKFNMrC+htL4HvtMWRE493rtHuhNhgz6x6xoBEpjGzvHCMVMrZ60?=
 =?us-ascii?Q?P4RYKro/Y5vdaFaO+pjhH2pSejuPCkVsfYTOwlsYjjs9Vn/Crb8MpMQ8sX03?=
 =?us-ascii?Q?wOU67qbD7murudW3eUL6jJMk9NV1H5iWg+3vXOI5FBuCkHWi8VzBnaRrLIBa?=
 =?us-ascii?Q?A17HOzmDwh/C2CljX/k=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 103ee6aa-2fcb-4fe4-3377-08d9eb22da02
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 16:48:37.1284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qftluZdnuyY/Rdwqd/50jYq8wyGoq+BHdmNRjBKO/l0u+yGLWBZd0HmeHvcpd5w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2845
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 02, 2022 at 04:08:54PM +0100, Md Haris Iqbal wrote:
> Callback function rtrs_clt_dev_release() for put_device() calls kfree(clt)
> to free memory. We shouldn't call kfree(clt) again, and we can't use the
> clt after kfree too.
> 
> Replace device_register with device_initialize and device_add so that
> dev_set_name can be used appropriately.
> 
> Move mutex_destroy to release function so it can be called in alloc_clt err
> path.
> 
> Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 37 ++++++++++++++------------
>  1 file changed, 20 insertions(+), 17 deletions(-)

These patches don't apply, please resend them

Jason
