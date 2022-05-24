Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DA7532C49
	for <lists+linux-rdma@lfdr.de>; Tue, 24 May 2022 16:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbiEXObH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 May 2022 10:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238195AbiEXObG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 May 2022 10:31:06 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05832664;
        Tue, 24 May 2022 07:31:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJK0BOp+wJ4Sjpf9cNCKPy4Kh3eIUpo1AxgE14QD33axENpOnm3TYdHalYXMqi3M4AnqvAjyaL1nR7xGE0hfXglHOSCCe2s2YYVGtSzUycJo3AvevFAFc3KnLVEUmcbcXMwRmwI7Tw2nI2PVWrBuGJajkcGUVkLmxK6/MJtenUmGiPN56aN+IbQ975UrPI+f+FpQHlMIw91dsOl/CTtIZ2OgAey/u6D0PhbdFmR3uqwR9wIjCuKQDFcmv6ED88wWEPaCbSBhf/+ueRip2sptJThoRIMdHbBFfQsPAcOy6cJz5EdirpYQTllPqKPUaxpRT9jyimDwryPS+gVr5ZdMAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YF+2DO5NDlqhVKJaM0tagfI4lHA602OGBWRVDazV4T4=;
 b=V7GvJbz3ingpCqu7Zfj4/MBNzcgfYQ9O84nQMUeQiabiL2rktrmrQw28YyFRwF8fn8SSxhMGVerdeVEAfJs42i7IgJzDJtpDbVTn6qoo+wCcVaIA+7Vz0WJyqdpWcM79TjfQoTwCeXmASDVRtme+b1Np7kUPOY6/2D3uKaiT/0K8tVCkMWOXxHB9Hi5NnckOdKdw5hROLsN3LCOAYznKgy1O59zs1tYRJb3uKTKgMlkncAgpEi5MYmVqXODkVxDt1A5G8VlocsbsWxTb/21Y3YXlrHF1LnJ4AKbgNkKpnZOIOELQMYuwkd+DrBMOlUs3EOwFKaL7fbIHXhj4lwKCpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YF+2DO5NDlqhVKJaM0tagfI4lHA602OGBWRVDazV4T4=;
 b=r3bTdE2WlroNReu15GcwSsMJItsq0Nvhx0kBVX8GuD+N+SDJht3oW6I1ku8ttwnQ1ftib4Nbqf/qtCDWEe+qVU1oz2C6/N/IYEY4a9NQSwpyiCmm8rjiUCRO0KnvuvS9D84mnhoBfADsD3+fLqJfsHp8dESiFJxP2U7BO451pDcvdatpdyXSfTGAWY2etGclc949mxV3VLzFlev+7Qdi/k7y1ws0WFw8zRx9jO4VmX1Dc2lhiJqWIzyzL2juYx+cJK7JsRUIsLEdU1Jo2rxHor8NmuwDCcis0i9HKN4SkpMX3qDLbHG29cZ8+tkv59cBTMr3nbOBh7jrpNcN0d0I3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN6PR1201MB0228.namprd12.prod.outlook.com (2603:10b6:405:57::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 14:31:02 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%7]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 14:31:02 +0000
Date:   Tue, 24 May 2022 11:31:01 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        kernel-janitors@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/qib: fix typo in comment
Message-ID: <20220524143101.GB2679903@nvidia.com>
References: <20220521111145.81697-56-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521111145.81697-56-Julia.Lawall@inria.fr>
X-ClientProxiedBy: BL1PR13CA0133.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::18) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0e8f904-2ef0-40b8-c016-08da3d92076a
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0228:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB02286B88497E0AE6A575E1F9C2D79@BN6PR1201MB0228.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IcF65M2Z1Jt+G+ok5Fs+8WtdQEoQzIzXpxM4nJSUQ0Ft0geAKiKK1iXHLY31V9vUUqO2qSPW9RFpJgxoPnCZNeROPYGbVkeAlhxRXEIJ720vyg05igL8FTibTRgULJIP951+SuNP5wCzOyDhJyywh35zlag0o3OHsK1aM5Lf8y4+aa9oeD8q0lUSaibHSnvpHw++mh93ikhU8XV9A/Cyq8fj3Vp+iQgt3AWTXmu6WrWHIjl1twdDx4wb9dDZbXY/+WZIVxMaS0J+gSXJLhOhl3xBr9J7EoEY+hqphpU6KFc87FdtwXEH/OOgMH1WuLyTXE6t+EkKay3oK53bmCYJo3ids4jNT0dawwU4Vdn5Q3ZYOXFk8wh1eLy/hK/N4/SM3NMLUoJVgSksB0ZioLgvVR0DV3BWta6UQ4qjdoPOLPY6eggRwqVQxSiO9bojzyvzLWcqRlTYnw63cjfVYUz253i/+L2Wjk61yWvrwNj8LJ5qRZoskTfSQ3RZw+QL/Z4oaz3ajV0KFM4JDJUt/u1oXy6z5WhStJ/gktb5xWfH+itGPhRGSEmdyp23F9kPzZFjGRGLurZku3x5J3mS7UwfjWVNfP4j16hoszzMKhTJlh2MGdmzNhPWMa2SjYoikQjcYfOvha/6shtyI2qadLq9Jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(2616005)(1076003)(186003)(26005)(6916009)(38100700002)(83380400001)(36756003)(4744005)(54906003)(4326008)(316002)(2906002)(5660300002)(8676002)(66476007)(8936002)(66946007)(66556008)(508600001)(6506007)(6512007)(33656002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5l/nsv9yHayLaDisWbs4RNDbmKtJgGa0uiON+dRXAr+VHBL9Ahk1xqhTsBhl?=
 =?us-ascii?Q?RWQhEdWEBH7Qx5OmpwxY/mb5mCFa1zOrGtlkc7YKx11dAoOyJb/mGFzP81M9?=
 =?us-ascii?Q?QdCvRaQyOsgIpbGYK0dGq/Zw2P95f06b7mtOrzRUQT8gR4NU00OWttBEyknk?=
 =?us-ascii?Q?OWrKFXXO2NQzTXF+Fn+S2LFm9qkSlfUueT1qsW/PlFQFRQM0hc9Eht8Rvt/m?=
 =?us-ascii?Q?8ymHwMbkMv6nGv5jaXqCAKa6+gzH06o8Fq/8e5yTivCZGUlQHJmrowvXNdfy?=
 =?us-ascii?Q?rFFm4FmS34GXn/K8Kfgv1UJ1WtxDsJU22Shhahczy13sND6Tme9gtK8Q0/sA?=
 =?us-ascii?Q?bXQ55W/cGA1iMQ3Jcg9eTqyIVY1/qTzWY53v5YjvtYcin+WyHyM8VYhlWqE6?=
 =?us-ascii?Q?nUMvy0GhO1fAoZOG/rflzx31CLPYx/2srCOru9Wp4el4MREdWKc1NBlOzhuK?=
 =?us-ascii?Q?ED1PENxAMHeaOeRj/ByCTmzIz4dw9X1v8kYtlF551S6hwQD77gurC4bIW5ms?=
 =?us-ascii?Q?FeyrTF5q2QNuMy6Nnof50hKt2yAGTvHXPNnOjqVj/8qhJknGeZtz89LAx/sl?=
 =?us-ascii?Q?w71/XqU33Fnovp/enfo+F+FicmwAaBdU+jlbfSfpDKcWQQRL3FEaNpYRLvY7?=
 =?us-ascii?Q?HnduPfLLWK2mGjTOW7H4JbMsIxfhI7z3gCdJ5Lzwgjtg1nKh6f3/6uP+Cu2I?=
 =?us-ascii?Q?oM7005xr25xwJzX5kqDcMDVy2PJoFE3/DiBHvi97oI/eKzBwTa7p/18XnJUD?=
 =?us-ascii?Q?lWxXuiS5BU9HW/lVEb3LVoFxZWKghQX3ssxLq8R+Uw9+PWjSA4RrhQE6tHAG?=
 =?us-ascii?Q?h4M5RqnkIFVmrl5wDihUFbu8rsgATRa0TlXELN2uSRrVyalbEqNyeieOfXXf?=
 =?us-ascii?Q?7YptKQt6LwgibCRp+d2vWelTJTEYDhhXvTJf6xDkRpMCZwaNws2bIvmlh6gP?=
 =?us-ascii?Q?80EtJxG8QMVQr1gdef5Dk6m+Bo2lylbY2lENdD3+ZU6e2FpzUXKa8HdtgkDI?=
 =?us-ascii?Q?Nz/l80yt4DuXc+uji2kDUpwyY3RHFH+eLFHpqfjkJr4LCBD+YTc9iF/v8W7j?=
 =?us-ascii?Q?8KhxSKugkgefsupytnCd227oIK/48PzB9qDyLoOlMM71hQyr1STfERgUatj7?=
 =?us-ascii?Q?oFNmmI++1ndbkQ3bF2FQGUZURoKa6hr1QPYeDQsCtf29mq6nd4w6TALEuJ3b?=
 =?us-ascii?Q?C2GZYg+F9YKzWAL8X+C5jkvIwFt2FnWfT8M0F3Ff/esBXS+RX+i2r1UNMEax?=
 =?us-ascii?Q?w/WXo4PaJCtwt4pv1s0Srh1idPhx7Ey2NdWFhZCCMVLl7GzffLBLKhZH24Wj?=
 =?us-ascii?Q?zY3Y8/20bAqnSLfryXhwPtvSngojdkZauewRxC45pvHgLeWUJPDksGPKQwK2?=
 =?us-ascii?Q?60IAn1OlEWFvAbx2Hro50jpQNOIuGJgV8rY2EPNX7vHecMZUxTFcJfAytVqi?=
 =?us-ascii?Q?k2Kt4J669dB04K4XijgmeaLxjJJLfN8rUv10b82INknpPthnDCFf52o+lAtO?=
 =?us-ascii?Q?hwP+1m46pOs1L5l9/YFDybvsacEp3CQa02gbLIa+3UPBR+1zFRxpcHvrP7bs?=
 =?us-ascii?Q?0JCb9hxqKrKCVAItA2d80W1Wj/1JxCypv21GKpYkkxmiMCGTsyKTSxxKVHGf?=
 =?us-ascii?Q?i32KVnxxpRZjw0nz2A7UxFYipXYf+JbCM1y+0QvaLbiskcwfwQ2aQI7/ChfU?=
 =?us-ascii?Q?VibVa79Yk4+DOlGWcHe0amcWldS1BTph2OwznfHF3EpckUqN675Nub8wnu9s?=
 =?us-ascii?Q?lwMAhNRvRw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e8f904-2ef0-40b8-c016-08da3d92076a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 14:31:02.6552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DwGKki0NiDmSQPRuKB0Qp1wIDdLgon/CoyfMvcypI2kRbclvd0wxUAMcskKvFUDD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0228
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, May 21, 2022 at 01:11:06PM +0200, Julia Lawall wrote:
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> ---
>  drivers/infiniband/hw/qib/qib.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
