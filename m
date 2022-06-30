Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2027561D70
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jun 2022 16:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbiF3ONt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jun 2022 10:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237494AbiF3ONV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Jun 2022 10:13:21 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A4336160
        for <linux-rdma@vger.kernel.org>; Thu, 30 Jun 2022 06:58:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ty+58RfbKVAP4xJb6Z1SW5xjNnD8EqlUNAhdmYPvbKdxkfXFNyB/6Uw+SkQyrG7u0dgcUUtAAKOQG3792U0YOWGntXtexfOe1dDCer+YycwB7t/5FULOIj8bQ93HsmgRL7w65xjQieG0m7mE5YeO1UhgjiGk0Aj3mPtwDxVehZhyAJx9BdhJqzEGjWfBfY2oq0uO+qL7eq78OFGxiNvj6winwz3XPQQH3W2zycsZy+IjYSbD4Dxr82098YFbMYcy0jmA/dtjqU2u53el3prPLEy7ciKCF4lf9gaYm3iHsi4ofkE8Jd+GNqWhqAvdYbtAoRgu3DwKxh2RWPcu/yMl3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9coN6lHK4fnGkgl7ZEFGhkTP2Mtsw7gSZAcWxO6C/iA=;
 b=in8HxLO/CEXbePi3LwwPHjdTQbJbAVSBOgRhivO48pWJeHi0yBwusghC8XAC5vkpZFyMhW8hyt5ad6M81DIBjsTezYPYRFfCZzW+J3QVVkESt1MfhSAJ4ejfivRB8k+rl5PnzzvfqE8oAbxg9CI99yD6E3QzLmisRGft2d7kba/EisISbEDmHr+kEnQTcEbtLvneH1Iisw1Py5ap90Euqj5vvjFVBwQZsDSUEtjELgLolKTV4ZiNVN8hRyg2bfspiHQGdyFKfGkUOEZAFbYmPthjvFm2m1gYLXS2M5uBTggeQZhlC00GQM66Z2RWhnw2PDEWnOZJxTWr0/K71OlwAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9coN6lHK4fnGkgl7ZEFGhkTP2Mtsw7gSZAcWxO6C/iA=;
 b=ji79k2m1AcQySTaoKn4jWpjJtoxTxB0brMu3LzHUczhVn72usR8snSuO9WcUo8DEnvKHh8QJ4ZdzbN8yyZ+rRKRjhJFZ5X4M7vjGtDZAC30Nx8as8mt7JdpLrFSwQk6ZvI3wazZa2w+gCpdem/GR3ZnTPuDnIOa26N9Xnx5EwVSvrEQO+zN7AKSzxNS0eFchIJrK3X2+UQ8U/jv2nLQlzlIhkuUwURJV1hVr9TUouiRcR6PqBmX2TPv9J0FbzMYUK58w9SZIlT/ZZzPlA4d8waFCooyeI+NUfrvH1QTZPjBA1tN6f2jMxNNuC3+RAfo/nO6amcWsV1TWGwv5MHaEWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BYAPR12MB3061.namprd12.prod.outlook.com (2603:10b6:a03:a8::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 13:58:18 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5395.015; Thu, 30 Jun 2022
 13:58:18 +0000
Date:   Thu, 30 Jun 2022 10:58:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, frank.zago@hpe.com, ian.ziemba@hpe.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v16 0/2] Fix race conditions in rxe_pool
Message-ID: <20220630135817.GA982692@nvidia.com>
References: <20220612223434.31462-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220612223434.31462-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL1PR13CA0367.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::12) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e8fe10e-9735-4183-590a-08da5aa09624
X-MS-TrafficTypeDiagnostic: BYAPR12MB3061:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CCPG4SugWOTAHH/4FyF0qRi2IpUM4jQC3OWn1UJ1wQPuNdmA64tMUCigKtLilftI+n2vEhy461nQqWwxToGS3cWat3fbu+ge2p3upN0yHxVh0qyTUZei59+vPbadgHcfSTloEmGEHqtra7lf4wsGX7s7ThjdRNI5nGlYHfRTjq7WJg+Qj5hEv5oIVNK5sOMQjpVZ7dS1lYSP1zegcaYf1TBRAYqLQes/trMb8sqLtLBntZ+NlROQtnZqJMdryTqQxIOq5phIKl8RCz7DTwTTroFQWLA/XwOuW6c2Gsj6sSDa/bgXczKW1LOEX0E33k2+nAJY9z8Pl2MhFzQW+qKIFX+gTLgMPVENE/fOzsHWvyQqRM4toz+sChpL3H/KOVHbjKv9dmpe9NYjIMoE06C5SApcLwnUZJPo4D2zogwY8HdFnfnnJEVpFPslovyJ15ppmhcyd5FIhiCNA3o32yoY7L4CfL3v6PJ7T5whXkO3iIDmAU/AaYSQL/nitetZSFZJsXogjkJeqE845SMKTn5Rqfxy4EFEkVIbbOsbBJzNUy8cg68Vo3JLxB5IWa5rP5hd8Z3ARSNKUfR7b0qXADGxdFNGf0O03rwECAqsOL628NUwDOGJQsWOrBk+SvTkst0d6kJLTRkQcwuHAfULsFBoLzDmRDcFm+yVG+qpJ1WcdNaED0+eaTDxSG/Y8Isv4xbH610iegSUKPTgtP/det6F8iA7z+53yjeJ68Jzfa0UFkJmu6Ov3KNdfnCcRXQxmHOVSsbXtIkmOfSUuUWMpVtAJxSGlWWDa8/mm7yUz8xRojSqCCusGiSWI/1Bta7/NEvl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(36756003)(5660300002)(8936002)(6512007)(66476007)(478600001)(6916009)(66556008)(38100700002)(66946007)(316002)(4326008)(33656002)(2906002)(86362001)(4744005)(6506007)(6486002)(1076003)(2616005)(26005)(41300700001)(186003)(8676002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HPWqd519lvOnNstV3MszbAfiKFNITuOT1EjiFGGHzJ+YKP0dqergp3l8iNBy?=
 =?us-ascii?Q?Skl4LBfIiZ/K0ASR0KRli6iDo9ubY+nAEKb5qKuF9yLyyQmK9+MKopQSm2I0?=
 =?us-ascii?Q?wNgTE/3cZCz0Dkm1lpD5iuF4x7NGLdgjadam70zqbYKejc00rilaETBsJaKo?=
 =?us-ascii?Q?FfrN4BVmhNUtiFojAxEDKt642BBsDVGTWVqGbHTcutBCGn5UMGc1d/Z2ebD3?=
 =?us-ascii?Q?wh37JtBaN514uTwG1Rede5ExVRdtHYnVDaAIdQx6N0Y5IsI6HmQnewE8CO+r?=
 =?us-ascii?Q?7P2bHUP+Yf4zCDu505f7YQ7+KmfLC4Ia6rUKMe7iuCA/Lqa00fuJLyvko7RD?=
 =?us-ascii?Q?q9/feB3APwfijvEg5rvv19cO/TEh1YUsdYKHkmvS29hxkgX7JXHxhsVlwQMR?=
 =?us-ascii?Q?+HBg8Vbgi2LfL00r7gBEKvZ+8N41qdUVjb9TYU3CLnrhpKCVj1ldmjEztYU+?=
 =?us-ascii?Q?V6UAzB7DH/t9gmLeK2o5RaD4KVzKIuc1wxcqIUyUmjZTRX3ENXxFquXTHQLm?=
 =?us-ascii?Q?m4MPU35KgXhKuABVOumncwFapMOf7wYWDxOZbS+e4eVKEVAikTuAdDdukeX7?=
 =?us-ascii?Q?5cpgfHPGp2cQMjsVH5xSb46jZonoScHMouWN7CFlB+MtsX2nXijLYYO8x6JL?=
 =?us-ascii?Q?bL8xqQZhXHNO1Vc+LStb7inxjH8sO0NGulyelpusF/jO8fJxouV4Y0XZjIBh?=
 =?us-ascii?Q?jQB69zM3T1x08huXDmWyHyhDlZ9bf+QvIbkLVHvmbwU+UNDiJq6Y4/yFmKuW?=
 =?us-ascii?Q?5azaqjGJnqJXNf/P25VeeeMENNqf578DR1nm3EeeRrKwPxTc26qymNOEt4dE?=
 =?us-ascii?Q?+hvW0kcopExXX1hJey4CtbNikEhS4N83QZFPkZqjiQGvMw03C4waJpyA2q8Q?=
 =?us-ascii?Q?FGdCmhpoz7LdLaVpZtre0mR9cEyM/+I88HpSR05m6oUY72w2Lnf6ISULmbTk?=
 =?us-ascii?Q?fTXbKDCTb+FYY8g4AJm3pvUjaFi8uUVfnzkL+M7jdntnted3hrhT1zrAmiNn?=
 =?us-ascii?Q?H+rtCpqKhs5pq+C8Ew1tkBkXSlrWZAF+D1/0uFZED6Dfi3/ZhE8+43Kob5Wr?=
 =?us-ascii?Q?nLdtJK5eSBJ1O4fkazM+D9TICJXLD0VimIoeb0gm3Jt1MC84zIxR8OaxuTsb?=
 =?us-ascii?Q?N40PW9nRCi5bRi6LEtZoUyfRR+PkgXRoyasAcBuK90tpqt8H6EsHFjOj1ra8?=
 =?us-ascii?Q?P2LfPt6x2ZJLph0Sdxn4YeCQ6hunm416t0HRkzRl6ybQH8ZGpxIX8WoStLsC?=
 =?us-ascii?Q?84+WlKI59rY6h0pyV63StuJJUm+jZg5LiOInPWGxFOve2NhLDWTg3rnYH2lF?=
 =?us-ascii?Q?YIHO2VM3k9PJH/GFWLCUpl+ZSrGg7tlHtaT8LAGmJ6W9/uolZ8a0e4NV2p83?=
 =?us-ascii?Q?G97rCGlUbsTlv2soalAm3HLT/bhqOF8/KyPXA5XYqcoxYxATZCYVsnacvZVD?=
 =?us-ascii?Q?4OtZRdKbVwGFkEyx/D+EU9lti0EBA2nnWCk5JvhiZcLOlUZe2WzdgbmIS3fc?=
 =?us-ascii?Q?RoNKPASOhTuEKE9JMkhlcuv3ED40trXGncb2Ne1dfI+RjwxVxcmPewNfWg8R?=
 =?us-ascii?Q?kQDJm66Yh/MwSX3XFVFk+rq2iWwjttm4CKljxKTv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e8fe10e-9735-4183-590a-08da5aa09624
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 13:58:18.7984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KIH+RTEymUUCvo3nv/6WC+NswicW5se9rMUtIAiW45XV+gOW397t0OonfT6ygxDH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3061
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jun 12, 2022 at 05:34:33PM -0500, Bob Pearson wrote:
> There are several race conditions discovered in the current rdma_rxe
> driver.  They mostly relate to races between normal operations and
> destroying objects.  This patch series includes the remaining two
> patches of the original series.
> 
> Applies cleanly to current for-next after the two oneline patches
> submitted by Dongliang Mu that fixed an error in the error checking
> code from xa_alloc_cyclic().

Applied to for-next, thanks

I moved the might_sleep hunk from the last patch to the first though

Jason
