Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AFE532C43
	for <lists+linux-rdma@lfdr.de>; Tue, 24 May 2022 16:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238208AbiEXObf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 May 2022 10:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238221AbiEXOba (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 May 2022 10:31:30 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219FC2A735;
        Tue, 24 May 2022 07:31:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cG6E727FdymMoA4SKymfGP9B5EAvlFqwqYnKFOzhHJhhXjcHGJjLWJbxUxzvjr5XxMxiSu4hXffIKX61dhYcCRPwNCZYM32nF2cGhNUMvcSY8IJQ4TskvIhDWYcSzOUIUNSrNwu97vefUfa7Uw8KyeaZLIbY7yR5EhDmzD3eBFrO+e8FmGtDjTnCOJxg969MxoCjpwCvX5iDbK89qeNpU1dEh7LcPdUwZ7GN+maZyXmBlaATq3vIT7qF822jhXaOxjenosuMQovwv4QqQSZhZvzIjxR0i+9EQQ0ChCkxEfo6jYfjJaAncqcrJrmPCMlF/S0XFFof/9EbgN2qyNvBfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HyqxTrAaIygmR16kpSdTeV4IDRU0DsQCNQD0k0yWNao=;
 b=D53ziGRuJA8jwMGQtUpQgiXBfKwtKzZqSuFxy04K89jN5mP17qvEs5JoPjDB0e7yLhcdT1FsfiqSFuB07Qho5biJ8oKNmLZYbi4aY3mWpK4I6t3a7n58ydaM47NywIZsB0oxF16l2t7h8hfHOoPcBSI4EslLXQXwNysdrn8pPIlERyk+xoffN0cnJhjMnkZAbMfGlOx35W65juthMhM9uIZ5LnLXnxA2JQv77+rZgZ/rcmozZtXDgRcaLMJcjxMQ0Sdpib+WHVU/Pph4C9oU8RmMff4luXtzmlczpcN1bydmaEoBIMZ05ng2bWKw6/N9ugyVmJRU6iElwjTu95G42Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyqxTrAaIygmR16kpSdTeV4IDRU0DsQCNQD0k0yWNao=;
 b=J1fy7OKt37Y71JsIK8CJZUHlqO+sGIzroxv05gOTf0z6cT+/I4t/wShn2OYEaTHum7UJ1ZKyUQXiod1H4jGTHtacoXicERyi7WxLrAKWADj8ErteAecRJHZyUWlhl3eP+lwGP1CXEEkp3d8yIqs6NIRIFrrDdvi2ImEwgTGWs9G8boyQ8EGDmtVDY2tv4DpnY9SvW8srGPyysJe/geX6137pSjlLGRy/KaAFxguC3wV/O8MdTQgLBQmGWp+VP9RBifPeh2XN57bBtc32LluP6pP6pc+3+ikfgH67UTx/KYQPQRy/uoP/tX5CCyiqp3njiO90DGYJwCA4wVh05VvOxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB4830.namprd12.prod.outlook.com (2603:10b6:208:1bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 14:31:15 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%7]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 14:31:15 +0000
Date:   Tue, 24 May 2022 11:31:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        kernel-janitors@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/hf1: fix typo in comment
Message-ID: <20220524143114.GC2679903@nvidia.com>
References: <20220521111145.81697-83-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521111145.81697-83-Julia.Lawall@inria.fr>
X-ClientProxiedBy: MN2PR22CA0023.namprd22.prod.outlook.com
 (2603:10b6:208:238::28) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86c9ad66-9256-41b3-6bb0-08da3d920f00
X-MS-TrafficTypeDiagnostic: MN2PR12MB4830:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4830D6D7A72635C1F44D439AC2D79@MN2PR12MB4830.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LHcFovhTJNkGPDx6An2Xh+BdEiKAFZ+X3m4bKDay9hY8fQRNFGtDABXpfMlUYIvpv/y++NrA6sXnFQAPDPEHRCFne2EPLfQ+PmGLVL1evqc1e1Y0WgGKDtNVpligiZWLq3ZDmkKYuqIUDfQ0Vu4Lx+FvE9hiHKTBfc7HtChqCctDTYB7w6k8zbeIcEnnTjPFJvIeSoGZvUNb7QOdo7BrHs9mDFcFWbS3bvWUl7xuZaiod2EecwK1Q7+2rmdzYmnxnsWxxMUCFOOkKO37CEHEgWdRkPbHEOwePRMaxG/5hHYVakVDpXDs+nQg2zNXyPLoUg5vHwmAxb8UJ5yfI7EEsWJ+94Ecd2OIhjNRMU4vUJ4RFfTaJ7RghxX4CVsSR7Ukdq4iCfX0GXGVswt9Fc2izpVOIElMuNQVY3NR24HxuKne6GhGEWePsUythxWIKGGSqlZXs/8FaPUZRNB+ufAzOqylfNvLjjoVWs/Xt9lBIPQB/XVF5YM2GKohcrupk0G+5oVA+8yj606D3BbRpRVVDHA3Dhb362rMiR2/O8jG4FDoLTtoo8zIwzGzUMrcJ1sFTP8xPg9p9Lzd7M1t69BgZnd1AMnFFoZU5pRgDhw48qq6+p0HUUevCwcWOFKHn8X89ppm7ZpMY/hGCrvqkQJRwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(6916009)(36756003)(54906003)(6506007)(316002)(38100700002)(26005)(2906002)(33656002)(4744005)(508600001)(4326008)(86362001)(66556008)(83380400001)(66946007)(8676002)(66476007)(5660300002)(186003)(6486002)(2616005)(8936002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aR0a9ObahzX1rvVPa4JJKaPnM+TyQ1s1GtesJ3I4XUJI86+lTJ98wnt1mSDC?=
 =?us-ascii?Q?S8G4hQa5mLdaM8aQ5ntqn1yfr07Uoc5HlRIAeZG0mZ1+aMpQqjQ7MNt/Sfug?=
 =?us-ascii?Q?YR8uacai5q2MYFgQwJodB8Fujf13buBmtMATZBReWISSKRjPpuT2Zcvmsxsi?=
 =?us-ascii?Q?cUsu9t3xSQOvh9mIM3jjNRGIyFxeyJ4nkr0FzUQhD9fKefXXMKTokcV5EmNP?=
 =?us-ascii?Q?eUC9wig4LGVo/41yCi+Wm4ILS7nPgICTpUKpDD24tZYg9iRj1hRwLnHd6raX?=
 =?us-ascii?Q?JIblpLLEauABNobH56NDOUBs2iJQE+ECSvkUE8xWvFfMOFv9nDVJ5tq3WVx5?=
 =?us-ascii?Q?Pjd36sYQDA5spAApshJPdGQYmv0xkV+eKKGNudlrXlMA5g9OgSdZnJ8dclq+?=
 =?us-ascii?Q?U4U9AKlVxPJmKfDoM0xRP4fF7i/pDi2zu7zZTbu/dMb0UdazP2Ssk4UplJ7E?=
 =?us-ascii?Q?PaS8TDEThvbmtZaT5jIgNM5ImwMmr4rzJn/+03xqchgV2tTfmAd70hhL09z8?=
 =?us-ascii?Q?XONy+eGgl87RtGedTBLk9RnBIasFLC8T77aDLxI5Le0WKB8NdxtF1wTXTGEt?=
 =?us-ascii?Q?G32PMvhSDJGpBTM646Hjh0cy8YoNW5iZ7RLtRE7VC12C/YY+c1sggUZsDJxJ?=
 =?us-ascii?Q?E5qmfcyR9eHAwc6yiGA+tfUnakM/ipfShUc+hm0fbl2rJguOzOua5yPCvtxV?=
 =?us-ascii?Q?ezOZgsBFjnVTJx60hAgt6JyheLyMq99IUU2Vn59KHs+qfZhqnNeJuVu14qmm?=
 =?us-ascii?Q?hJUv4HRpMoB2nUudwRs3r5uaBaIJ5UEZ9AmtNXTx1sbrRN7RJFHVHPzsZaEr?=
 =?us-ascii?Q?NLo4W5aq4nrjlzAvvGK+JWy/tgnFu5kmZ7pIIUFakxwO2AI3fNXrR1TFHY2p?=
 =?us-ascii?Q?pw0U/IKA9WhJPpkExOouAeAShcXXXoIlkjtS/W4jWJuALdaYWX4wmTZvAn4z?=
 =?us-ascii?Q?JHkR9RIqBAeptuuh5l0ouOSebhKPKdAtmZRQb9aOelv0CTBYelLb05SiPYe0?=
 =?us-ascii?Q?zchiA3tVfX6AzGaE8OYFzcpzY5HlDzHO9hsEw7ICgsH2JBLcw2VPDkByquB7?=
 =?us-ascii?Q?S84tbGR+pu/VL83gJMG6rcsYY+b2ClXnEnoxOsZPvSLee4UK1B8VkPw9fQqH?=
 =?us-ascii?Q?+Q1wiENvuP/Tv+qPmZwlEMuCSJ6ItSU7e0r1mofyrK9XQTYjs3UbtJAhXYCg?=
 =?us-ascii?Q?55IX9tGoordMeHL64v2eoiI4nVFwUitnjAqHlH5YDLxngTiTFMuWDzt5EuSe?=
 =?us-ascii?Q?n67mJymYJfTITvcBKvDP7H4ysBIhrn/g3bVF59dIw24MsxmW48rGK7IdKqAp?=
 =?us-ascii?Q?D3hXErOEXXtqgEU9+6wPMaTQ0lFQU7J8jBgwTIXRQ+FscvgSyHmajyBjprff?=
 =?us-ascii?Q?ksvCef+XDh7bbUjPGAT6CTKC3iruBQXjvVH5CG9EO6k1DeoBxAM6B901fRBH?=
 =?us-ascii?Q?fOseDZSD24Y09Lso4vqu41nQ+VH2lm/+9B/11RRW/UQp9hH7Md4fpqtM85Rm?=
 =?us-ascii?Q?TGMhx7yvu5D/JBNqZOzUFsE205BnAEmw7XDGpAMGwQQvdnjjfqgI9PLBIr8u?=
 =?us-ascii?Q?PCUxuYeiVQcNx/QO3vOldK0cExLXnfmsXyPSRInFf06pg0PxsDW162JNYBdE?=
 =?us-ascii?Q?iDh1/GKbC6KAFEKk52k3jgSaH6nOpGX0uAtUCaTKd51fnrRlZCjcRtm99l1N?=
 =?us-ascii?Q?Akf8SP29+R9JOGkPLbhTfabJLrC70n4TUhwGVeJDc4EQ4jkld8EZHFuOct2x?=
 =?us-ascii?Q?PlCEm8CKcA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c9ad66-9256-41b3-6bb0-08da3d920f00
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 14:31:15.3970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s6cw1igYs6ydL+qQSy6eS+j3+UVOjFEH9Y9RXykIwlzzNXnX68F9pEx6cUVhiDlT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4830
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, May 21, 2022 at 01:11:33PM +0200, Julia Lawall wrote:
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> ---
>  drivers/infiniband/hw/hfi1/efivar.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
