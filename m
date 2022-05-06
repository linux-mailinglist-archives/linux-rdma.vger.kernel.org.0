Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682D551DD66
	for <lists+linux-rdma@lfdr.de>; Fri,  6 May 2022 18:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443610AbiEFQTH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 May 2022 12:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443727AbiEFQSz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 May 2022 12:18:55 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2059.outbound.protection.outlook.com [40.107.100.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3723E0AC
        for <linux-rdma@vger.kernel.org>; Fri,  6 May 2022 09:15:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDK7uwCULtUgBaOZidz2jhk+oAYWFhpTygqFMbUteg0cVpJhw8RkPisgK4m2lUYK6hpjF8lhVw1fLXyajtKf9xJvB0pxPI85F1jZ1065QIyK6wNTlfO6o/TVfOywhd/qw+3mOI6IYoKD4j9J1wkhz79JbZ6T3aANouU3xgQVNOUpGGkczK6Rc+IJhKegrYVgGd9jFGzfmTlHs4KhII6O/DF3EaZTVVU/uWji9W+SBC/02x5bNfUHKhhhaknlD41vg17GEggiVJVOb4oLq1PmeDMM2izHxSOo9NbcC8EZrUG5yShV4qhuiIEjLhBzHOliIGBjrTB0eqfnyFMpjnsH6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfN10gQKntFSaoaCjCJ//+/hgtEJO5/xthVR+fs/PmU=;
 b=MWwl6SxVJ5lbrnLvptfZSaT0sMXUXtKfKXbnlUBIXfWNQ+VtUJ1XYobOy43XMZSXXcC64OhtN/KiMJ4R2g4uc0N4LYbopOxkWxbEvOufLKdwPWMAocmS1F1plppe9PBVaSAyuTAMAkWey6ZZs8BpjvTyFtsrAo5lfH/9Ct8fVZiZSTRnZuaFXRjtpvkMxPHWwsUObebuP1BAWILorn5hjXHuedTbhr+D+4HqJZ3aEZFZPVAqkqqbC83sTaPF4SGPYi4Cx2XWvg4XnMm4D6xdP45JONlnTJ7sTU2cZ5DI3p5KK4EBpzhZ/E5xEGkNsaeUVd26Gv1cpcJsB4eBx8hWtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfN10gQKntFSaoaCjCJ//+/hgtEJO5/xthVR+fs/PmU=;
 b=SrDGG6Lv4PiB8iwEI78jPcS3Fm+ynuhGQdml3nS/ftykDyWdLBK7nKMDRWZCPu8poChIcJ68uwH4dq+bG38K2hsWpa2ZXjqNRziLdz7YxaNuDuJN5dEakrUq2w9aDhdZgu1PKXNfWba8h1xqxKshxvW2KrDylOKeybOwyBjJFOwnADthGqllBtiZzLchnchIb2dozW3B3HKH8sxFoku0maQGAkmBl4ZXkLtZ2q+hxwOy22/WIX+1kU8lssN4pDdxPkDkgkNgh0Fb8U/hm/antsz89Q0vLik35yp/7igqR91WyANSHGjGftczzOpKHAK4QSXJ70BL+ZGhW2QlEEcsDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN6PR12MB1891.namprd12.prod.outlook.com (2603:10b6:404:107::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 6 May
 2022 16:15:10 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5206.028; Fri, 6 May 2022
 16:15:10 +0000
Date:   Fri, 6 May 2022 13:15:08 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [RFC PATCH] RDMA/rxe: skip adjusting remote addr for write in
 retry operation
Message-ID: <20220506161508.GA602194@nvidia.com>
References: <20220502053907.6388-1-cgxu519@mykernel.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502053907.6388-1-cgxu519@mykernel.net>
X-ClientProxiedBy: MN2PR16CA0013.namprd16.prod.outlook.com
 (2603:10b6:208:134::26) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b83b09e1-408b-42eb-b4a1-08da2f7b9763
X-MS-TrafficTypeDiagnostic: BN6PR12MB1891:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB189181B00BFBCBCA8D74023BC2C59@BN6PR12MB1891.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vp98ztOWAC81WbfnGpL0leQ6dJJVnptZqWYbDlGz2bo4ecRKI+zZKmSGIm/qy8CcflzysElTetxqqbNI3jGorW88ivPu/6MDsDT8VRi7ix7B5vo/8ufqPu3TQXM8Eqwugci2SvoUmeKAoOipTD4rgc+J7sSQZpSBBat5oEp5JKmClsilHkIKTykU5Lr26fRjBgxVlkrYw2XE5BG+gqFwV7XihCSjs7p3PmzCzNTDZNbDMwGo+iuQlvbxLv/0OFYfEvLENDihffYOqtx9Fap/l20LfpK7bPyjfaFETmV9x8PoNUos9WOGytu+kTXufYKicCw2W0Q+KvkDtm8PS9M7qJclbf88rbV4n1/lReqRD3fSjfXl0by7moSPK5b0q5vpzvteu51AKgC6X3GaLvAPm64LEZv97tMPe1iN8oGBvtDKUWlZEc5C54Tmi3Rz5r9cnLRoxetfUtfy8zitNjSjg+71IkOLZtC9c3mWhyjlA7GhRhC2tpHI2GOeIC0czUyaZ2o0WeMZ5cBEUP1wIFA8+xoY5Phw4QQtFnqy5eYDRW7DoYzAonq+oqNRlMafoddAP8U7v3SGJHcKFo43Ud6ypAqI5125cT5+lbAYVH3zbxdzpbgD9LjnJ1nAOJ77UbbrgHyxnF19IxTuCPFxMSn7T7lBLriv05ISu8PfZlkvAVksS/ntAWWuN5ZjP2NFWJv1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(508600001)(2616005)(86362001)(6506007)(6512007)(26005)(38100700002)(1076003)(186003)(33656002)(4744005)(66476007)(316002)(66556008)(36756003)(5660300002)(66946007)(2906002)(8936002)(4326008)(83380400001)(6916009)(8676002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pgrP8VmTM7Ilg4J9ID3JlT7UcjIvJ04ZXqbf43nop2ZOyJ/sNEbKpEJHXSdH?=
 =?us-ascii?Q?ORrKxq6kqNi96c7lFVKaFRTFAR1Da3B7C7SO8QC168bkH7aATWZPKFB+0f9x?=
 =?us-ascii?Q?ycU+jsTzWay8wituIhsKHXRqKXKrJsNXwWZUlYJGGplyKBcicNnNMhuU6bqE?=
 =?us-ascii?Q?Gw9RdZ7JbR52T4fMf652Od+jw8QjbozWlv9vL2efQsFIJEtK0jve1BydHqNw?=
 =?us-ascii?Q?aIwGJtzKAeRzrfUMKnwpt5ujCVqkhbttfuny9LOPKKcA9JkDrMH0X3AgBuAj?=
 =?us-ascii?Q?bu1+UDdPMYZMN3ukhKCbJ1rA5Q1fmawCLV1wh2nY3UXNZaJ82oGuJSg2Zs+Q?=
 =?us-ascii?Q?cI9l7JKQPEkkndJR2Q8iQMg1hUK+g7bENUhtiYPOR7U0pVBXT2LIzuO2DBUj?=
 =?us-ascii?Q?uTop9uSvsb4k/+VMNU4I8WuUZpByBiDH8O4bVEYs9+XhnoXXGh/+P8LTKbY1?=
 =?us-ascii?Q?YD7BNQK5P6fC9KgCQ+r/2hR6OrPeKKpOYA+hr49CAw/G6vGWFurG5JsY6Xtw?=
 =?us-ascii?Q?IMLFBNi31wLWFKaeL+SZO0Tj+8nLsBe5JhcYh9PnFCziKApFhXaP1chQeQwj?=
 =?us-ascii?Q?icWJf/B8tyOqpfudKj82CKNr20wljmqWODaHdj9UgeiOv7kr4fpM/RaX4J4a?=
 =?us-ascii?Q?US4WR9e56+w9lFP4jrTANxXURKgEJqr5cGlxW2eUXkvHyfShayCzI2C9rUoP?=
 =?us-ascii?Q?ABgevtmp6B1TnhmOIAGBdYAO2jcAp4et2QVcH1yAtfLcT6mRiet5odUWe/ZO?=
 =?us-ascii?Q?MlRDevBQLJMi2JMdlzNnrsTSi8iN5LUGxcgf40jnv4+OGkPGS2tp4b3GAxtG?=
 =?us-ascii?Q?Abuszp2dMs/uiISMCCw1FZnbq2lEClxLeDgIlvkuryGP5hIVEjkK+0AlCoCc?=
 =?us-ascii?Q?2iSilz7GF0dvnXu0j93OLPo1zbT+xz1nJ6+ij2AHtyDsfoaH7ErGqaCTzDFp?=
 =?us-ascii?Q?b1rReYSLbuyn440sNQiM7d7LBGAduqW2kWUBSYRlea2kSpiRJp6XEBzCqr0L?=
 =?us-ascii?Q?FiY7HB/qPJ6MicUFPVypJJHZNmnWXw1YyCBVf3KVROTqTFmFtcHowCoNqqbo?=
 =?us-ascii?Q?XDWM+ebKGjYYpZbFuRfmeqQpiLGdPICxwLx6jGHsnJqxebwhe113gQ5ZSp10?=
 =?us-ascii?Q?S2q6/IBAbEaPTT6zVxllzTPIOCeLtZLMUvrR6LjR8BlVkoH6v6qy98j3iGdn?=
 =?us-ascii?Q?SP+r5+Sm0fS36R7+5F88W+T6PjttzlMbEM8P+TOH9zmWaV34TZa2VBygr2aY?=
 =?us-ascii?Q?zD0i2WSOTWQAvBQgtE25x/vdEfDixYOP77DbrRUOpRI/2umlEGdKFs1XNkJB?=
 =?us-ascii?Q?oUkBUbLbOnpgrVoiyuTQJuKS4KAU0cUHIGqSaNEFRehfnRBcjyChpOrz9ABt?=
 =?us-ascii?Q?5i74lNhYadKdcNjcMSoCC0syQFsA5EWp9fob7OUEsFAzBtYOGV7jsbOjXLGE?=
 =?us-ascii?Q?6VwOUummcsXo2Ww4ViWlwpzykQ9je6WGR4bS91n2hcmV5WhRMiUkObMl03h+?=
 =?us-ascii?Q?09eWfVQo55uvmw5gQSTmtRscTjb2Icd8gOGkgC/TLme8xBZpWxxUXiawrU8D?=
 =?us-ascii?Q?nOXx9UHDLMH0XvoH1jCuri5/kXCy0zRdtgL1P9evJ70irYrdVrnFfm7LFEMB?=
 =?us-ascii?Q?FkRO4TlEop5FfmsQCADtd+QsQMh+ftz3RP+B2venPTsIlot+I00n+Hk5txy/?=
 =?us-ascii?Q?mHKxzO0bw0ALyXGpkgFpXc2WTvg676gyloENP5qmPCuVaT5YYhPjSf9gTXXe?=
 =?us-ascii?Q?NS28kcyhrQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b83b09e1-408b-42eb-b4a1-08da2f7b9763
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 16:15:10.3579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xyV4MEsBqaEI3FuuAKq4WY6BtSHm0GzOBt8bBEn+XmKXwMeegZoHld+psyb4qyla
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1891
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 02, 2022 at 01:39:07AM -0400, Chengguang Xu wrote:
> For write request the remote addr will be sent only with first packet
> so we don't have to adjust wqe->iova in retry operation.
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
> ---
>  drivers/infiniband/sw/rxe/rxe_req.c | 2 --
>  1 file changed, 2 deletions(-)

Applied to for-next, thanks

Jason
