Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E1A4F1653
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Apr 2022 15:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239809AbiDDNqM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Apr 2022 09:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356461AbiDDNqL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Apr 2022 09:46:11 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0882ADB
        for <linux-rdma@vger.kernel.org>; Mon,  4 Apr 2022 06:44:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctQ6SA3GiG0e5CrA2KqPqHoeH+tYnjN4C9n2AhN82siQ1PYBX0kRMtTkr5jE0wk/BqUiGtvDAxaNDkVtHxYUC95F8svneBiNYAd68DyV/Nt4kLV23cqB3XaJL4WbB6BRpJhVt7sL0swk7MWctAip004zPqsnGQ8iP+Sh+99DQY4JVUrmO+wfpj+mlBV6QPzqg5qW3JPrAqLyFn05fMc6nrbn6OL2M1PEO+BJM7bwfJhFBbvMUlE2vyQ/YMnf7sEfNCAbUAjoCJlW5Eqzr4II25qqlOzfmEjZx5EqR3pQ1+TtXvTY6uEELiX70RvFpA3Ifxfjf/8zLpTh2liWM0jklw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IF7Bm1RNDTzyHxx5vKMrMbjcTnLEMFWX4W33ZEOzNZQ=;
 b=GLH2e4eDrK0htpBWN9H92tdofQ9y5f3IcbOPv9+iy7FoBl6rjYfux1a+JQMgydZR6Gp0dT0WHkgDF4YDmwdWxYHofm9JOq34oIpJnLBdmrxqysx7En7u1XoQrb9GJ02VPKk7e22KOg/vvEvLnQE0ciypq7vhrkWBXKf1lKJKJEz4sUsP8PvGhhJe/Pfb6OMApjUTQM07rXt4YANVrGJud7s0RAxR8C8FYwQ5RUyr8bx2nbIN0fz5sX9WDf8LtFWV/5yQIOFZxPLLYBwGz2nM84gSQT72x4RlzfgeAP//GNT1z6/LQo1VbKT3qmOTLjysX0uPME71EcQGCLUkHbwOjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IF7Bm1RNDTzyHxx5vKMrMbjcTnLEMFWX4W33ZEOzNZQ=;
 b=aEpXVU8AiQs6j8fXG019n2SN9RPzYGX8XOqvEvt5WUZ3d4+ka4GhRaLMmOgpsN7pdNGGoiIqvPcwPJ9I6ZbKL4eYRiQRg+fyN9slH1Kw4y1mMqxaEnkeSmKDuj5TyOX2VOiyRnN8QFtK62+Rcc80ax5xgn3QaY9udZqumXdzZkHG+YtLre8yNa80DaMOGEgIoIpTfmowRAnijTdVUx/KglqHwjzaqp75BarTkUQdOlTirLamHfCZHJCtQHRG977dmNdqg7mkUiSC7MGFr1NSBSb/7XtK/Rb9I1JDhhkMGYtQcW9POKBDEmRRvtaJe8MAlOLd+ViXMIX+ZPc3uXGE7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SJ0PR12MB5487.namprd12.prod.outlook.com (2603:10b6:a03:301::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 13:44:13 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%5]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 13:44:13 +0000
Date:   Mon, 4 Apr 2022 10:39:11 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     leonro@nvidia.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] MAINTAINERS: Update qib and hfi1 related drivers
Message-ID: <20220404133911.GB2905023@nvidia.com>
References: <20220329184221.182061.69846.stgit@awfm-01.cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329184221.182061.69846.stgit@awfm-01.cornelisnetworks.com>
X-ClientProxiedBy: YT3PR01CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::29) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edbf22e0-96ca-4049-cdee-08da16413428
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5487:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB5487440F50A0484D880FA3F2C2E59@SJ0PR12MB5487.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aVhRlNIRfXMMD5xM27VfvuhfLmjXE7A0yEWW4uxu+m2l0NG5A0FFRU8pOGcDbNE36vrw8rVt2kroUvEZ8zA+uvFIf4HgYdHQ3fYeEouW8hQIdBN+xfMtAnMZckWbmwYUSHLPHxR0MQKsu/QBsQPK6jolUVF7BBYchbTPuKdbGcmLS9iR1bd7CPMhjqpzHJNvT9e9cScBBdfetv/OlfD7BEYS1ZwoRM2cBRLiegT78TaVnhw51i9oem1L5eJQdyTaOOsQjE9v/vKzM9bcHBBRIhuJCxn3+Halb6kHVOyCgyyR3Dq5XXGAycrFmHvTPY0w+lL6aPL4UOe0Sp8wOKZjcNNe2DBY8zNvqMvZjvPHXIvWf6x5r+utIeqcy7YjomnTyMqR37uk8v7yNyQrYWILRcPOQC3k5p75YRMF177dbfk/j/G8IFQgULau6boOOkKXXXevSJz0pIiUTZ7MEloiLq+W6RpN8LyqKCoOQrSob2+A5vBGzWcyX37BeiUOOFdWIF/G7IOPIAzOVxEEOSCSJHNEjx5vpiOLe8mM7cyMrrUOwAr3OWCn9KLRLGxmPkOwZ4a0sPRsm50kx2TlQAFwPAJGEFpBLQu4UEEvDSLc2hvqieEumOsPDJWLwCQ0ZZvq1nKQ6aBMYZIYzSlu8zOcyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(33656002)(36756003)(558084003)(2906002)(86362001)(6506007)(8936002)(6916009)(4326008)(66476007)(8676002)(26005)(66946007)(66556008)(316002)(6512007)(83380400001)(186003)(2616005)(1076003)(5660300002)(38100700002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6jTd6nrICK40Pw8ZzoEUQ43lOf9dn/jqMw5UN1SIGmk78DLswm9kirRBJ6P6?=
 =?us-ascii?Q?vywxck2IItfa0aBsP7izb/GsxE0KmgON1Yc5VygzKOirWVck2kcJjQ2D1tjL?=
 =?us-ascii?Q?UsQri0zf4burverxUcXbe6kjdlKjf+Oq3fG8/GfJK+kdB8ONCFXtNgjog6Vu?=
 =?us-ascii?Q?MShyeUYLHKPmAN1ZgcomoQcKSfM1FdZ1gOpZoMp87HrZOXTRX0dL7krWzK8Y?=
 =?us-ascii?Q?Xe0mxO6VvKvZicYNiSRNp0V6UVt1S4HtUbCIGebmTk4b8o0IKSigf5QL9izK?=
 =?us-ascii?Q?omVfFBjfd4Skx07ZWEpaNWwEsvcMFOnWiaB3Bf6NNQHnSks1kUY7z0sbIujt?=
 =?us-ascii?Q?WK3V9UCFPI5ifTjgpTQZZle9ql3yXe/zd+DJOLSqvU1rKu+QP3wBNcA3+i8S?=
 =?us-ascii?Q?w+YLrCswD02DPpAeearEWthmNcPgnS5uSvKrDykR1pWdNtOhqEtXhQtXIgCz?=
 =?us-ascii?Q?uYMeEk+GlYNd/GIEvUE+nFBn8UskkHMAyHkNDdWZTXQdc2zwdcXCPALRFuH9?=
 =?us-ascii?Q?iA3ksmORTJ2ueK9hbRk1Mjz2L6S476H3fhIVYWfHNOrBXXWG2dSFcWNW4zVs?=
 =?us-ascii?Q?74xOtMf7CBEXumwg4iqEyoYlw4BmmUz6Qu3ys254JwsuBlclfhzDxBjFXvDB?=
 =?us-ascii?Q?5gPND242Wd631zELiW6bLrfjkK/xW2mmPi0qmIh0PYxVkwqigVEEVNnGZbjC?=
 =?us-ascii?Q?JGObXSD3kxt3LpireUCtUMa0x9RYVAtLBHCiut6FXWTpa/Wx56rarMZK1SNn?=
 =?us-ascii?Q?NUk/Ogq2if/w9WcQ3bXe2pCRYormg74+a1yXW64HyJ87+cSPHbN8waiPOxlL?=
 =?us-ascii?Q?JWfAb9ffFhFQHgnz8FGxgZRL/cz3njxi+41XMYhZ7zfGwB5mZxGM9xgrdDF7?=
 =?us-ascii?Q?ax1QbMMhBvFaIueAWo2PN4DXQJx/L8CTm/Yx4M5rOk5Tr1cbbqPD5i+MpEtR?=
 =?us-ascii?Q?Di1yWZ13TLAAeA31tHEZUjiPl0E4XTAxfvb5WUlzLGGiJSNFsukpplmNbCq7?=
 =?us-ascii?Q?OU99bN9Mc9WwgqgfORu/cet6qH0eMdv6+b4df50UugC90vuc5x5kzBXD+Inc?=
 =?us-ascii?Q?hMHBoCV4gf9JMc58LFdoFwqC1HPykp+OWMG4BzcSAetxlmWQ2RZsw5Z3DUiC?=
 =?us-ascii?Q?PTH0Kkc2gLA0FQqOjCBiVHR/YXgBEmHtsyE4qPO0Wk2VBBTc53YdPYzowKCj?=
 =?us-ascii?Q?X+Yzh9+VZc/lD+aVdIvDUNUPZPFFYssrbBEqRaMTIrhGnJUx+h+/sSh8NyUT?=
 =?us-ascii?Q?qfOBjFlCTAMg25Tgd6380vux5MaY897kSeLAdPodR3a8nZiFlifwlQozF+Fe?=
 =?us-ascii?Q?o+lXuZVe9dNY8+11gmAGvigJF3dZvJWfeZGKZjLHlOzbYw+qeAMr2uX6MsEu?=
 =?us-ascii?Q?WQOv3RfiuENjVoMPxNMJsmZYPq9crUdiZVvq5I/jlUmWa7i97WdOI6PS6SEd?=
 =?us-ascii?Q?y+ZGFv+4wsgXTGU5DgUE23Tw2aU+bvTP1eqONaD6Yk1catuF3jR6wUy8B95P?=
 =?us-ascii?Q?mebhBlJHnMZnkRqB+acaCTfTV5N03jhmRHCED22sdZBabiSoJPSCEPkPRokP?=
 =?us-ascii?Q?2cPxAzvlIyVJEeF6Et1paFofNxVQ627hJ1he0fchle2/e8AzmesBY/TIoBoh?=
 =?us-ascii?Q?zfafxsokguRVg8Mjxg4Sbq3Uo/Q0m5KDmrIqWeQTpwR0qseCsFX7Sjyc2JQe?=
 =?us-ascii?Q?P+iJ03zlAmVL6z25yqUxmt3oibhmVtnZ1ITa1rmQOlAC5fW1Mpj+jrrTsTFr?=
 =?us-ascii?Q?xA8xGlr3yA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edbf22e0-96ca-4049-cdee-08da16413428
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 13:44:13.2151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6xa9QWcTyXPugTwwNEqEJDbmDxRZKLyI0GqNE6khnANIlyAMAh0fMAvNYxDqn4PQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5487
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 29, 2022 at 02:42:21PM -0400, Dennis Dalessandro wrote:
> Remove Mike's contact from maintainers file.
> 
> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> ---
>  MAINTAINERS |    4 ----
>  1 file changed, 4 deletions(-)

Applied to for-rc, thanks

Jason
