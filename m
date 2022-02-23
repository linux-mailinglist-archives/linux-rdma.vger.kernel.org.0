Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186704C1C4E
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Feb 2022 20:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237108AbiBWTeM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Feb 2022 14:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbiBWTeL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Feb 2022 14:34:11 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1FA12AB1
        for <linux-rdma@vger.kernel.org>; Wed, 23 Feb 2022 11:33:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4mrNAtlxw8RIpg80t4VYGZI6moif/ikRKY+4HfXko5ZJuyCewgYAnL+JOAhTDVaDb3nJN1Ij1O9teHF26x1+lsuRD+w0cmZmNOnGAezf43hszDK8Io4a/drcNz7H6WCNv2N/PnwI5yKNZpJp9vodaWYoy/H1n2MSZHgs6YkgJxDT1L9iOVElgOuUhiy1OTv/iScZvaiA0r6LfHNZr/b0xHuw/oUOSKFrXtnnMkrOCKzHZULN2ML2FhACj0Yf4t9aOR3vHVkusFS33sR3LuUOL0HMY9idFV8+ZbiiH6+6xqVCOZEFQOugrQRSRG8WmX36n3gSUj8zRGXhsaO/XPmcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RYESaW4zIoho3f6WpQaZy3wNu9xe9tHLVLYB4t7h4U=;
 b=CddW+cs5F3KVI0tvRJ+cIZ89vh+1VnBKT3l2zoFlnSU/vuB0TaYVfFzm62Y2nrTx2qgFiEeYsvPwbpcurKu0XkMk/ucbvk7aFcPkOwLPMVaMoxHlfr+Xjv1emeKY76XnV8imNP6D6e9MH/TZhYN2ngk9P1PERj8CwYUZPdHUH0hYebMdDSWYyqhWj678MByj7kEh9eIpaj+2rZlLZuE/SlvhiPVDGdJz6uhlWMppqoY2RWPHR0junpEIQLa7/ov1WG6jYjTCLbfgTenc4PmUuYVb3GMSxbcPnyy7AxKXtksEDAcZpyIabEskyVQL00VxQLNxNe2odgagcXtStZXzJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RYESaW4zIoho3f6WpQaZy3wNu9xe9tHLVLYB4t7h4U=;
 b=mI1nH0fjArJApOCuvADIRIUo0UKuFRe9uckSnqACz4LvAPRluJK1e+AA6yty84NYdv/tcc2F3245Ock+3hRloIZlR6zh8/qvIc+fwn5Xxu5c7b8j1IMiFPlKJ1fjfgp0qwQie2z1exyiZatGa9W5+Zn8Tms9dlGabz+Qr7Kj8PZzDVZYqNISj+qSzL/55HcTYr6PVPH2NCpoEJumda38E0jeRVSTdCgxDPn9mD3SKNjt7MArA/r/8R5rBx+DHIGwHjM00pDApF5c3AFAJSAURYr4s0MhSY6CKpadc6WPb/AanLK9Aziv6NIObEOQJnLSnDHfj+UDhonOC4060aUoZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN6PR12MB1138.namprd12.prod.outlook.com (2603:10b6:404:20::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Wed, 23 Feb
 2022 19:33:42 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.5017.022; Wed, 23 Feb 2022
 19:33:42 +0000
Date:   Wed, 23 Feb 2022 15:33:40 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v12 1/6] RDMA/rxe: Add code to cleanup mcast
 memory
Message-ID: <20220223193340.GA419451@nvidia.com>
References: <20220218003543.205799-1-rpearsonhpe@gmail.com>
 <20220218003543.205799-2-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218003543.205799-2-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL1PR13CA0408.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::23) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70cf91ef-37ea-400b-a83d-08d9f7036615
X-MS-TrafficTypeDiagnostic: BN6PR12MB1138:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1138FED1AB1D535A2A3DEF77C23C9@BN6PR12MB1138.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: doyh+BEYyaot1AbDu0ZkqBtjRRSE52ujoGmg5GoLFk0jvmOl0492RI+uNgWZUP0o0NaQg+Jn9x6g5hUOz/dgp3bZ6nPbnaZp7SWKc9ilEir4dEAtj9mRE5KlMOwp//PBvUnQtvzaOocduKApF/3fCj0+cdR47ZblUmQumSAllT51YcfITTarFbEbs1w3OuK32Ujhf/imPik3fFevHo5m4vdeXtMBavwrRg49NQyPh+V18csYGLcekshGeTfErypV9Gqz+7/mCXSEwRvxXT7TSveL3xKzW4RA/Ng8+YUNT5pNElLe3ZtNQ+6q8HNknAKq2k3FthPpn1qBw2hYqtnjoSgs6Nmm4vMOqtrFHY00SSuP3VB1MhgC2jxrpze7OTjXaaS3EDAxWkircsH4JytlJNZecrv2/p5fP70X6AjNaXka0Tzbxp31LoOPSJv9lnMZ9wJLk9z0fZlZ7ahXE8Na1zYmAinTQWoJ4dK44O1ZHyEm6kUu6LGMD/4ZBsFQRUO0aE4SibpAsGxHo4cREHD+fL3ZCy4iiEk4tjInZx9ulepQFDH9BZszAdcnOJNNOq+xVYiD4ZJSOX+eCQpgyCR/pOuuYpRCbqkBekAdKVq93mfvVWmNgXEJjV4qsyLReoUwd4NebDUYeOoSpPKyf1w/48VE7kid10VpaIuYd+R3Pod9x85lDAqQDv4rYlaUa6/3fnMCi2nsIOoZm0C5UnIKwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(36756003)(6916009)(2906002)(83380400001)(6506007)(8936002)(6486002)(2616005)(4326008)(66476007)(1076003)(66556008)(33656002)(38100700002)(6512007)(86362001)(26005)(8676002)(186003)(66946007)(508600001)(316002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?arQMNjjpFJJ5XZvStW415XyMvmCDakDXOJKtsl4Zw9Y+3XaCZMI/UOIWQnYd?=
 =?us-ascii?Q?FKrZqDbRDNV3EwEkB8Lr1ULNZuzFkiO2nJuNmnZ/XBHkd6IqnxbgRwe7gaun?=
 =?us-ascii?Q?Xgx4XJsc1tVbViFMAjb1YjpLaToSvFf8IPN+g1Fs5gIQAf+TSZpOXshcYx6x?=
 =?us-ascii?Q?fV2pelbi+C0hwGbJPis6idaF1m0KK8jpPvq+Yf4jSpowCHeQaG7G6Fe7JagR?=
 =?us-ascii?Q?9QjAbbGElVKzaYSj8h2NYXosBWt8Lm8uLAHF4XuPvedN3bLuifYRFCbiMc88?=
 =?us-ascii?Q?rBokAmNFbxHWAZ2pok8rqg+xfS3p6fHVLBzGoCwKG1DffQHkVmti1mHei3QR?=
 =?us-ascii?Q?JXl6Fwfxy0XtUcOGImfC9/u4fo+gZez+JJNac9gARhJowFhOyNVLcrLsWuCK?=
 =?us-ascii?Q?i6ZzLc6boIThNjSchmS+aFMSNbW/yLX+IeQSNFjx05+uqeqqayf9Appn2+xr?=
 =?us-ascii?Q?smi06gCT0O63pih3dtWnYUZ73ORrxTwatslaUDh4enkc2qND39bYZmheA//y?=
 =?us-ascii?Q?IxdYHIk57C/vO+o5U70DGIcbPBMquVOBPTyVDQ5KiuFCN2HvJ+IlNprmBlok?=
 =?us-ascii?Q?swV0JTpxh3ngjzaiJO0PhfZCxe7FGe9jP1VgRBmaGLJhqDXREENkyp0E2Dfe?=
 =?us-ascii?Q?neVMrviwc8bye1HybIG3R1hW6VNNo1SM5LMj2PRcIq5jZ2yDN0ClfWwCb0Ys?=
 =?us-ascii?Q?sKEVvYA39ZE+CtevgZzGfb44jM+TzeHn0zKlqp++TniXZlAPiM1+5ZKznpqq?=
 =?us-ascii?Q?FCI1/N5HLysqHNuOqZ1mNTs1lC4t3xgDkBJwTEq9fWBgyelhsLOTCPxTy4az?=
 =?us-ascii?Q?5xO/CKNPs92A/MeFmUgHIer4g+WBls7LJW8gVPHXufPDNbTIM1phWS/eFvmA?=
 =?us-ascii?Q?cjt1UUQMdTLtt1SLc/OsIIhVl3EGhKyvUWk4+b3C1ozOTHKu8G96LHilkmhP?=
 =?us-ascii?Q?mdkESyyB9YyFt69RTAP8w+oY8s6qWkhp89ACDeAYDjI+X8LF1U6664jrh4lb?=
 =?us-ascii?Q?cSlbayN5LcbtHEjRTjfzkldE5oGDL1nxmcTFWG7ek3I9WslqNnhF3TUgMPcO?=
 =?us-ascii?Q?yeqQx98nsaATyKOvAmfjCkw/oTwRvHtOTMEoTLIcAIZLgdg6ezNXSVkhOhPa?=
 =?us-ascii?Q?tEdA40xXd47wkYSq0inz5esy/YpbTaicPQZyLV6hsSK4Wj6b5Z6sPAuoxprD?=
 =?us-ascii?Q?JilbzwNb+qhOHWExYlmkb1K3iH/sSm+5t2bjxG+rqmE1FCh4ZHaWD9Pks3j5?=
 =?us-ascii?Q?Gt4Zsv0jEGF9iuEqVMd1V5cwuiP9v2g5xUDNPVvxzHztiEZbKZCwoCDwtLS6?=
 =?us-ascii?Q?Hq2ONnAj0vUO5YQdlcvfE5lRLqjRRSb4+fKX3l279O33+x5ffOIbx1WMAFYs?=
 =?us-ascii?Q?fwia5PCaACNMuRTU7LIJb078wphW3FY/fzoBHQhVz4CEXSJBtt9RA0iI8+EK?=
 =?us-ascii?Q?luW0qB/SUd/hUFSBmpDqNiL33+13XqihcY4BMgS2aGrTndouE2Rjut3h17zq?=
 =?us-ascii?Q?LvSo9ETN8zoAXsL763CMvOA1QtQ6SKnyk2vJ2ecmuBen90gp5dsNteugXuMz?=
 =?us-ascii?Q?G+yYcB0AlRuLasdsO1A=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70cf91ef-37ea-400b-a83d-08d9f7036615
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 19:33:42.0543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RUIGQeXNZTfyeo7Wqf9km30PDk70R9lx71ocJN9ZFhEKgQw6K7QW2rmWTZQ2k/Ns
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1138
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 17, 2022 at 06:35:39PM -0600, Bob Pearson wrote:
> Well behaved applications will free all memory allocated by multicast.
> If this fails rdma-core will detach all qp's from multicast groups when
> an application terminates. This patch prints a warning and cleans out
> memory allocated by multicast if both of these fail to occur.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>  drivers/infiniband/sw/rxe/rxe.c       |  2 ++
>  drivers/infiniband/sw/rxe/rxe_loc.h   |  1 +
>  drivers/infiniband/sw/rxe/rxe_mcast.c | 38 +++++++++++++++++++++++++++
>  3 files changed, 41 insertions(+)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
> index 3520eb2db685..603b0156f889 100644
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -29,6 +29,8 @@ void rxe_dealloc(struct ib_device *ib_dev)
>  	rxe_pool_cleanup(&rxe->mr_pool);
>  	rxe_pool_cleanup(&rxe->mw_pool);
>  
> +	rxe_cleanup_mcast(rxe);

Lets just put

WARN_ON(!RB_EMPTY_ROOT(&rxe->mcg_tree));

Righ here and forget about there rest. Leaking memory if the kernel is
buggy is OK.

Jason
