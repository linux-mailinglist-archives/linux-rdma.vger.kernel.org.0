Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A3953309E
	for <lists+linux-rdma@lfdr.de>; Tue, 24 May 2022 20:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236298AbiEXSn2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 May 2022 14:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiEXSn0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 May 2022 14:43:26 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F273633B3
        for <linux-rdma@vger.kernel.org>; Tue, 24 May 2022 11:43:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HlDadLMT5Cm3dHypT5Q6JoB07vXGTohGEzsWc3QPpbCHCAQx+UlKRN/Y75uhhzIhZcz2TwdBDS7rRjqxTGpp6GTHo6RGNbvGvEc3QGnS5agIpwZUd9wGHhsPFNw+q+rexsJ8X3n2aXLzvWaJV15JGe3GW2paC+JP8bIqIzKMKK8cutS7Sbp8RqU/V223GcDFnAGVca6y3EfmCveHOS1+0kFmjQN2wycD/fNufweFdpf0Dl34+sU4/Wc6ev+shSaOEbJXqIOlB85iAVl0CZevD2hAIumSJmOarRaBqekrXqIjbWu32U7J3LorIzz8rg39KuQsoP9w8aumDjPTIrM/kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rw6MLNhlRFFWmWuPCx8ZS77WV0mCvqE706xNFXCUiD4=;
 b=FHjtymweMs/XIFiou8FXr5QzuSbEzxaXscAFf943gCTbTWXogj2yVBAnR2KQSJElSxV7D6klLl+Ou/2LmMhGA9YYtvW/w1baCHtGZtuGP2GqjniEB3yMZX5GEGn/0Yi9ZgODIuJTlyeUAaHroUZExEDWMqCa6rtZzYObRTsmAPMZBqZj7+2D4iDY78hZrQQYPn9rmlrWQpC0T2oRnBR6w+HL87FBBEb32FuQKqu2oNkJDJbc27EkD6ztm4q2dibHXpuC0hzxxdkb8Izuwz5JUHjkFiS/rHd9kiQXeQcxrBWP3gayN2mOia2sPd/lUJF3nuZaWmQ6B3mn40oF6d/cJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rw6MLNhlRFFWmWuPCx8ZS77WV0mCvqE706xNFXCUiD4=;
 b=DoesIk6UjvdBBSRoD2THE/kWjWCww3bi82C5RNkrZysIe1kJC47qGJbpGyw3GLZ7A+eo7Bm6T/lYMVfYrXPY0xuIzmjuNwCy59f7Mxt6r5ftTHeJ9HBpcYI4NyghDqKTbVD5B0Fu4LTvzGNxYYb4iXyVuKf2ncX2vG6WgGMqE0rfFa9j1q5Dew6bXZoMl7Cfw2ZNy+EoOLGw0jgaWBdYu+WwThvR7tWw2AqVMDezQNjDbrqkpR+FAy33w1rlqbfV1jRTAIqu2C8DNWW5JLY09X8mb+mqC765eJUAq/pav9P3gecWaUMPYepCGpQCJdbMANAtnxAFVunJ3IK6RkoT5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Tue, 24 May
 2022 18:43:24 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%7]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 18:43:24 +0000
Date:   Tue, 24 May 2022 15:43:22 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     leonro@nvidia.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 0/6] Updates for 5.19
Message-ID: <20220524184322.GA2744260@nvidia.com>
References: <20220520183516.48973.565.stgit@awfm-01.cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520183516.48973.565.stgit@awfm-01.cornelisnetworks.com>
X-ClientProxiedBy: MN2PR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:208:fc::29) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8dc1fecc-1b8e-46fb-1a22-08da3db5488a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4488:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB448892FD8500B1D76807651CC2D79@MN2PR12MB4488.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TLVFIwYhe07ktQtDL62anbubsaOzynujPwEAIILdUtI/g48S6Dyej+DRPU2YDbqzXttmy+Hh1f3TQsXX/uZ9rH0+YJQJAFWsAzDFA7fJiVsFlYIUVyk+9ha38qKHq3/Dhqy52b2LqIrjvupxcrX+BAgH3rf/0cjTR110wGMd4+UhJSoTQr5gO/WxJOW1guvXqVF8BekTnuYfZ37dKLh3CDqtWeQQOPbTcE5wyVOqXw4kEgnycBco9NX12kQGcjC+gwjTdqd8UKKC/8/fuOyt4F/I5j7Z/ERydlL3vY4zaxCL9oPMQHwpADYO8rHCeDT9bSArtDsW1JSDOdbF610bG877TbltvD67Q0ws6J8hMFExQkTo3AuHBZWf3u30gb+qSgBI4d1P93aYXXdgAy+iBkieRf6mHm5M4ahKY6s+awKag7TUJCaarOvP36ho4A0OPxT2WZ7z5PjyE4szSPQuW5MLOsq96f/3lws2F9rxScbowb5PyQJThMG4xhdGJtyVMZ9Iht7DX3mJNdRYOJmTk7HNWDZYO67hSANSpYQwq2hLky+R8ct19D7XdU/kPTzf1xhfs+Q2zuXWaSlEqSZKjMjripaX2/G3hsoBODQiUV/sWAUVoShPmmE9p3M/jU1k4db6w9g25mTKvvBvrhP8AA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4744005)(8936002)(66556008)(66476007)(4326008)(66946007)(36756003)(186003)(5660300002)(1076003)(83380400001)(38100700002)(33656002)(2616005)(508600001)(6486002)(316002)(6916009)(2906002)(86362001)(6506007)(26005)(6512007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1u/QPMaLEBX/VhA4Zk5nWtkrjOhW5hoAaNxhSAMIk8efGTJ0tXsRvVkeYUKU?=
 =?us-ascii?Q?2ps7haEGp3o+E7FeS4PBd3AaXqd1Gw/0cWEjcZAyzHsNeP/LA/7XsMSLt/l/?=
 =?us-ascii?Q?lIGZXfNmmWbu3OLTTztTidiXNTOBieS5DUqUR96zmQ168Sq6ZgwgMDMruuxq?=
 =?us-ascii?Q?S66d4e6aUAkEsDKVqERMF5az6PvJq2QWwJk/Nmnvdp/mQF1EgiaYXl0qwMb0?=
 =?us-ascii?Q?/v6fH+jiuqErcRPNNGRySRPrLy05zMblP8vfyeqnYNVsUL5FNKSWUSV7HE6S?=
 =?us-ascii?Q?0ppp6Mh1RUhYzKHnko7tF5Tw4Oiz+iOs1os6UzJbD7t/28LbP3XCWeKoy62w?=
 =?us-ascii?Q?+zIkxQ6ECh+zejralYtQoRcR2keI2mfnCMmhIfYYOskWnSaUvlqTpgumLGfc?=
 =?us-ascii?Q?iWNQzXIEj92SV1U3JowTkPNK9E/YIyRY22dKcLLlUJ2AH+9z4ZfBWMAlYOQW?=
 =?us-ascii?Q?AxwknswhqU+XZDGK3k+FUCvujqIvyeCd4D5TFDnSO9380cltiQO2JA9o3/cz?=
 =?us-ascii?Q?6cVUakH17tpGhq7LkYUl05HRF4lGiW7MPatAG29GCRUg+KBIOhooJJXfe1Hz?=
 =?us-ascii?Q?CWdR078GckQHoR3QsrwmaWBu5vDKZBu3i9IRnJRDlD1pJTVNH8ngSbeHIYsS?=
 =?us-ascii?Q?E7RoWCqJRtwVuMgwnlyK7KFeErf6YP7OWrs4Tl1B2UhFUnXqQ6MToMhBxjcg?=
 =?us-ascii?Q?6rcs7SLXEbXrbkckn0CPBQdss9zQ6uT8zPUMP9/ku8dEREhr1KlyKuI+w3qi?=
 =?us-ascii?Q?W9XMgwWKsnwGW4/nIk/HjgYH0zUNmq7DTn7iPcpqf2Ajqbm358p1Tb7hPWyx?=
 =?us-ascii?Q?kflPLjRcwRtNHEOC8Sm2Sz9i2DNNcaddSxMieAlYCq9+fWkSIsJ3MSrg2Ri3?=
 =?us-ascii?Q?k4f37Mk1v48o63WDqziTz3s5fi7RTuaWDB+dM11qNKoawy9Hs/ZYP7AZF9FI?=
 =?us-ascii?Q?IzvqsieVFXfJ4XsUNY/7EVjlozhAd10THEl1VBXuTYazjyTgv3ezPlZUJQ6+?=
 =?us-ascii?Q?/mgjxmjndCcToMBAu9oiVCMZIHPfMYMHvnZqmBhzf7UhaHV690na+1CHvxNL?=
 =?us-ascii?Q?N9tVLrU5kwvv9EvGYf+0PuqK7SM5vj+jCcIA7Iw/ExG2TvADpaChgaI49vAO?=
 =?us-ascii?Q?Z876nuWs0CKkn91LE13pwJitlrvqtdNA3/uqbC+RJ9HxDvd7QqMimk8uhqjc?=
 =?us-ascii?Q?yMDdkHNLkTezHc82ZSqBiSoY+P7xaGAozNXrp7gy3QVnuMEIJRKeI50hrRN2?=
 =?us-ascii?Q?PdiSRW1S468pFuC+UG9MCNV+fyZWhXIsxHhIZA8Rky4G89u5hN37ouyDTK4y?=
 =?us-ascii?Q?w4jEVEpQaRtQcYEBkZyeQ0rJIo6aoJ/p+dx08NZAbUmN2Fl18LN9rChp+b7+?=
 =?us-ascii?Q?Gyzfz4UeygZKO7fzC0egYWTlMLluAfiUTADTCj1cRAvKn4owwYWAAr+98v1U?=
 =?us-ascii?Q?0xr27N+mwXG5czmLjjPOY8WxwYfxMH/jWPd+iqwyTKJa2+SmpM+rOnZyZEEE?=
 =?us-ascii?Q?t4r6W9rlU6Bteicf+p9iZvj1N9UceD3oswzzgPugnZA7CcWdA7m57DOcCYei?=
 =?us-ascii?Q?8AWzKuIewMwdG7GFnfUMO6Ffi8Qvfi3cLcFbHIL3250a6sPGMCCuoPEsoAYd?=
 =?us-ascii?Q?5SKIezF97pRKSxnNIXf+Zv20HG8odlGWNtzlEUwI9k7Vc18p2UrRjXctNRNj?=
 =?us-ascii?Q?AldCsi45wztE1t0yS3rHxcjDJBy3AgbgrplID2Q3TwnLD8Y451BkzGOsjS+N?=
 =?us-ascii?Q?gHPmO6zNGA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc1fecc-1b8e-46fb-1a22-08da3db5488a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 18:43:24.2669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /zgGnfTjdCvKZ1VigkBUz2thms8IW6Z4ah1HJmjw43jm5pOaM6dQdFWB+jmx+vMY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4488
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 20, 2022 at 02:36:56PM -0400, Dennis Dalessandro wrote:
> Here are some clean up patches, for the driver mersion that got missed and
> diagpkt removal. Doug has two fixes as well.
> 
> 
> Dennis Dalessandro (4):
>       RDMA/hfi1: Fix potential integer multiplication overflow errors
>       RDMA/hfi1: Remove pointless driver version
>       RDMA/hfi1: Consolidate software versions
>       RDMA/hfi1: Remove all traces of diagpkt support
> 
> Douglas Miller (2):
>       RDMA/hfi1: Prevent use of lock before it is initialized
>       RDMA/hfi1: Prevent panic when SDMA is disabled

Applied to for-next
 
Lets not send patches during the merge window again please

Jason
