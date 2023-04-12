Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CD06E0241
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Apr 2023 01:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjDLXGx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Apr 2023 19:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDLXGw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Apr 2023 19:06:52 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C800A4EF2;
        Wed, 12 Apr 2023 16:06:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZuXx3tdXzGzRtkBEJ2NyPU8qMczuGLYgY71FN7Jb+jMnNjtJ3CBO1J+T+lVhCy4wT++e1aBR2pDeay7/sIW4960Ot7Hw2tpCbGu9vhk26KoLk/kzfXW0UVWQO9SwDW9D40msj+hqLghzrdXhwbpxJGAEbKU/w84/eL0fUtHd3xT70Nxl+gKk89/tEkk0LZ6npsVvILPirFTAgTQF5Srql+JzthmSbvKSKzsUTj/8BpBXBJJdP7LaX6GOUCKQc1TBhfgYIw9Yidyn/CGGsxZB+n2a7uX5X60yAqVphPHK6SMdPBMEHxagv1YYhrOW+02woDh7xHkpr3r+t5JYt41UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wuEaC6LnOpcNT1UELvK9vO6rnFedWbbnRh5r0ti8X5s=;
 b=kgM1aEdV4IkufRYJ5WvTULxUxXnP+XBdxBYF483dAbzagZPoyKU953ivyRxceAgqYFcml/ClgJTzOnYDCaYE4hnTgHwszwBFobu/qtGXGwjOgaAh3luTeESVoLof6SLmEAt2lqSmJYfG5q2Bdw+Vf5w4MLA4K/+EX7fKqoB62sGkIh5DsVbaK7BYK7aYEzQqWbJLHxoYNbE0Qye9ntdTDyTzcvtVdSDTHKMCVC8d/qvSUeRY7YELLCXGUbK0MReCEuPr1HureJO/U3aeYz0ytY5fnCbfhgVKmUcoYo+lohcu9wowYaSQZh5INZzQCIXzHrB2zvW21r+kEHzAbG/4zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuEaC6LnOpcNT1UELvK9vO6rnFedWbbnRh5r0ti8X5s=;
 b=DMN25uTWa5GIOOEijYSNyry8GMkU+GQpBkSAIQNZLnPCbLZuyUwtORrdVE4/9FdYr+6VCz5xyXA1ADCoPie3nKONVB8F4Ig5D3JyQYl5SqrZGTE8a+8C2U89E8lwA99iq0CHsNSVVrtR74EDfh/GBoY24Z3vaIV+4/r8r6NkwJkxbc4M46gVXNooJnALHJ3olZxkrBaastXKjS6IK2xbVdbdE76AZuGntfqIrDxnu0dulLghqigLqgNtkPSQlHylJlW681a5bGaqGmzPSlgEz2YENyrYlZJ9zdDUdLoC1zslnoLdFd78+aDUU9N7WAR9GtxIjH/V6hl5N+5QFT13mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4236.namprd12.prod.outlook.com (2603:10b6:5:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.28; Wed, 12 Apr
 2023 23:06:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 23:06:42 +0000
Date:   Wed, 12 Apr 2023 20:06:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/irdma: Slightly optimize irdma_form_ah_cm_frame()
Message-ID: <ZDc5f7SFUhli8T3h@nvidia.com>
References: <098e3c397be0436f1867899245ecfe656c472110.1675369386.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <098e3c397be0436f1867899245ecfe656c472110.1675369386.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: SJ0PR03CA0116.namprd03.prod.outlook.com
 (2603:10b6:a03:333::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4236:EE_
X-MS-Office365-Filtering-Correlation-Id: 64840a70-37e5-4049-32d7-08db3baa9445
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jvMA1Hhh/Ie7HCrNxWiLtjIeJGRhqr1H5nisnCx5D4QFViKE3amQ9J9wS9W4AB1zvnr9rZElPHWexMy8AnfNUTJT1/C62P+9xZeZ4SEoZAMWBo3SZ5fMm0CTCp27ryDDbT14axdXwzTYYHExWqZlNjhtT8iIozmmwCsp/vnNK+xWeScEH1UgSCaezkPNzGagwHB13+wjdjmtsV0HKLQIYWJ0jmZDZEY8FHSDKyXf4gyptrenWQfejEEmZHydIpb0LUEMfCHDUfsrXyIGPlLCdMKn36i6vO9ebPSuJegmpYfl5RUp/6hoaGfyQ+0zOVo2yKelKz6go7aziMn2h/QxyFcQRUsCKVZ0EzIoui2Ruh1035QlE1b4WZqtqceVx84Lx7XY4oCksLzjH3rtVtk+mq8JXhpAU81AGtIcOhHfnMyplVkkb0ET/DtnPttBOx/quV/z3rxlMENy3V9+lmEmNvwzmUPGVtBJzMe0+LPxWhVILKZFbgPlUnhIVddCBLiJPAGoyXmKEh3Mj9xt5q7hsP0PHmUh92iCMgapuqP1dExn1XzIaIyF9iVgT+H9sCsW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199021)(6512007)(6506007)(26005)(38100700002)(83380400001)(2616005)(186003)(316002)(8936002)(36756003)(41300700001)(4326008)(6486002)(6916009)(8676002)(86362001)(5660300002)(6666004)(2906002)(66476007)(478600001)(54906003)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NRP/2M5Uk42koIKoLb1mRT5Ujljd4NFq0zkdxj/T3d4B84nSwODS1shbyvR+?=
 =?us-ascii?Q?uFIsop6XS+wWsK7Bx2bJKPsaEiGSbMUSjPb4ltPzaL0qFiRddqbOL3iUxoXS?=
 =?us-ascii?Q?jgYcLLAYpthvEQe3Kd+5zl12TWj6ck31v0QjDZKYJq403CiWZ2W3H4FLEk4o?=
 =?us-ascii?Q?9+suVypkfTd0g3hfPCm8ONqI64oyYm7nUgOaLPxWNzpVZ/dlL70NQpc6A+t6?=
 =?us-ascii?Q?CurllIRdGInlP7ouW2pMMCypzLxou9l0aK5OtgU5YJWcgOCuJAOF28+iZn6z?=
 =?us-ascii?Q?ljroIL4LW0O1rl6HM/aAA3h9AYpgKAUByd2WS6vTeSpezUG4Cxt7sMSe15c0?=
 =?us-ascii?Q?sXHYgl7pZ4fm0aNhLJY0/3yuecBSIuQWNBZQDRczoM+muzfoTDhOgFWMamvY?=
 =?us-ascii?Q?X+EBE06vnKfvuQaKJp9iPp8Vf+jQRk7ZJHCvsheZrfhy+mfOpkHbPE1ZD2sG?=
 =?us-ascii?Q?284brur1/k5AZ5QVw7dePrVPW+fKDKNoPFXsVrjFeilh3kKrxP8uSD3JK1LF?=
 =?us-ascii?Q?VyHdfYd7kyaCkBCRn8Se73TAQ5xGqNo6UrLiR52omoqmNTI/Ug61VBGLcMpw?=
 =?us-ascii?Q?OobRPf9EW+v0q+Fp2anW/oJr0MYdKzZTZXTO9k+ZbiN7OyyEbujGHnQamhVT?=
 =?us-ascii?Q?LJVMwdWrumPlMjIh3y6o/KZJ+ftlfQrzz2VdI+HQr5BpeNtaJIEGcHQ/qnV/?=
 =?us-ascii?Q?k70lYThKMLEU2hfLUHi5QP3sAnW0xzWpE2nDjHAxeAIBgeGIuIKUfLE2xrob?=
 =?us-ascii?Q?90udLxUZR8TzMckq6ARNeKS03jWc67izINDPcmLRRvXODGr9oBMhfzPbN+JA?=
 =?us-ascii?Q?8Ej0Qw7U4POHvjKct/Zkbq9TaCWXNJiRyIrz4zF8ryC1KULXSQm4kChcVbRp?=
 =?us-ascii?Q?VvFBJlerOHgfDve2pI1a6V0cpI2DdmyergdcNsnHwjx2PFhjbS9ZOsOslqgn?=
 =?us-ascii?Q?TTbkDJiB23goQy9e4a6YRcByrwsKK6DHBhc+AoUEy/ymrhafrs2X1tOXaNHL?=
 =?us-ascii?Q?hMQ2Hr+bvr/Gr1SNHNlHbrNIZ5zhij1h5OvUtXIN+dUJl1zIWx1WiwgwU7vl?=
 =?us-ascii?Q?/1fUu10047INHe0vumEQMNtmhjqMkMeS0SjDyUXTIFxbYeWEM/a3OJGpBtAu?=
 =?us-ascii?Q?j/MFDQQCLns6hGnXaMcg+xQWp4PCfKMLLAJs8olOqfxLs05cWvyKEtP+7u0n?=
 =?us-ascii?Q?lansN0VtZGHX6avI6grX0dvraKysCIR2njLEexQF2P0f+KYt9mLAlpOycIsZ?=
 =?us-ascii?Q?Ey532G4m3di04j9/zlKtmoTzdXfkiYiQFvYdauE4p9TQz0aok5YgwqXQHmiU?=
 =?us-ascii?Q?1t/r1CpOoDnupiSu5DQ1jQm+Om7sp16NYrkkSWyoLVq3ODUaqYAiy641SZpT?=
 =?us-ascii?Q?nsaStxJxubC5lUtTyWAB4yPFShWk6vYKkNaQVCeWagtdUbHbs0f+DFXLjcgP?=
 =?us-ascii?Q?Zz/RhoLMVZcLxp8IzWgXqqMdllhkMhIuDDdIPqMrrbtLE5AYSt72pVN8WpQ0?=
 =?us-ascii?Q?74WZ9EOrK55f5E2SYVwXUXyaHwhDQecXuxx6dV2u5MlG5GyGykB2AnSmAqag?=
 =?us-ascii?Q?K5nDbaJ2nK37kLd8h6bnYUCzPXSdJ4iQYM+2nFsr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64840a70-37e5-4049-32d7-08db3baa9445
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 23:06:42.3982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v8zrATfqnvyPV20/aGZNsg8RJSnBYHEQlpdAUO0kr3ISgDKfwle6uo2JrEGT25MK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4236
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 02, 2023 at 09:23:24PM +0100, Christophe JAILLET wrote:
> There is no need to zero 'pktsize' bytes of 'buf', only the header needs
> to be cleared, to be safe.
> All the other bytes are already written with some memcpy() at the end of
> the function.
> 
> Doing so also gives the opportunity to the compiler to avoid the memset()
> call. It can be inlined now that the length is known as compile time.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
> Just in case, here is the diff of what is generated by gcc 11.3.0 before
> and after the patch.
> 
>  .L736:
> -# drivers/infiniband/hw/irdma/cm.c:340: 	memset(buf, 0, pktsize);
> +# drivers/infiniband/hw/irdma/cm.c:340: 	memset(buf, 0, sizeof(*tcph));
>  	call	__sanitizer_cov_trace_pc	#
> -	xorl	%esi, %esi	#
> -	movzwl	%r13w, %edx	# _194, __fortify_size
> -	movq	%rbp, %rdi	# buf,
> -	call	memset	#
> -	leaq	104(%r12), %rax	#, _259
> +	movl	$0, 16(%rbp)	#, MEM <char[1:20]> [(void *)buf_114]
> +	leaq	104(%r12), %rax	#, _295
> +# drivers/infiniband/hw/irdma/cm.c:342: 	sqbuf->totallen = pktsize;
> +	movzwl	%r13w, %r13d	# _192, _192
> +# drivers/infiniband/hw/irdma/cm.c:340: 	memset(buf, 0, sizeof(*tcph));
> +	movq	$0, 0(%rbp)	#, MEM <char[1:20]> [(void *)buf_114]
> +# drivers/infiniband/hw/irdma/cm.c:342: 	sqbuf->totallen = pktsize;
> +	movq	%rax, %rdi	# _295,
> +# drivers/infiniband/hw/irdma/cm.c:340: 	memset(buf, 0, sizeof(*tcph));
> +	movq	$0, 8(%rbp)	#, MEM <char[1:20]> [(void *)buf_114]
> +	movq	%rax, 64(%rsp)	# _295, %sfp
>  # drivers/infiniband/hw/irdma/cm.c:342: 	sqbuf->totallen = pktsize;
> ---
>  drivers/infiniband/hw/irdma/cm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next

Thanks,
Jason
