Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9141D4CE17F
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Mar 2022 01:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiCEA0U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Mar 2022 19:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiCEA0T (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Mar 2022 19:26:19 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01061F1AC0;
        Fri,  4 Mar 2022 16:25:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnQMmvQA+Cv4+uqYaURQ1e2wm8Pj4Kjp31a8nhsUmSgidRT4pGHPpzULKffUDbqSd8eFS072Ph7vUW9HToJaJUY/OKJAAsz865xJ2gtAm3WWDQzv8TUM4SYqVjjMgSUGiVpAq3oMIGqiAQw19R2fEYAg9jpmK2v5is1q3RHqqiWr5ern1EZzXKh85GKt8zd4LMduE9HiG9dnn5Q1z3pVmnsQXZvlGShbmini274mqDO9IORaL7ycmlJ6WSCIglzOS8bBhlGJiQxzxHm4O38nAcEIbPcQaHQz05dOUxPZhQrixT1ywVwhVF74SgnP0YSvcBhVh+vM86kRCoZsPunUtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zz08l+Nk3+8ZSsAQAKwofVhYjmrOZw3doi4u9S4PrEs=;
 b=mnHlyII86HcSsedp9ET1hMkpX/a8HblqNy5l1wiaEcdrel4tzO0peDxVLmJmox3sh3Tdx6J8B0Ne3Fu2oZ68e+6784Z0cpDE9jgD3ggM2+P9bXVb113+FMkAfFNDyMm0flCI0G9mD3H9jsO0iF53LSxO4TfgMovDBpoBxsRq0yfC/iv2eYDpvm+LVKtJ1dhfCFlIlY3ouzLad+OKg+Y7C2nFCmgFtU6qQhOMIniM5wmSvADhIUr49kyEQD0lyiqcUh/8p++Yoaq6S7zggwOFwc9K7Tt/6Rbu33bO3JUgcSs18CMkUUL9k2KqC0GZvLXyvBaO1CDnZX3dQF47hqDy3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zz08l+Nk3+8ZSsAQAKwofVhYjmrOZw3doi4u9S4PrEs=;
 b=cWzBwWpNUgnLKjqBdk5k0zv6f1eTZJX9fGadj1xUjIt4GgU6JNmCJmUpwljqw9Ing7aFVDLpRbBwiHOXPTKQNAn5w4BTqGPEie6cucsWeGon0RfbpePFpfpjehf/zkmdxRgMjg6R5hnGrphmiK7b9xPjumES2LyEoJd8RdsNCElr6hyGai4XUxcQOQ1svfWozNyELwy2LxW9OHqhXYDbWkP5XwtS5YRPIkpHnRn3/utGgZ894O9WkHA7LhCSmoRIIwUnwNQpXomKuIWFD4STvflD9927ieNhbnERHfaUbXRq0bULa8aXy//G/UjDOFyneQyzmT8I3kb8fk8BA0nS7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH2PR12MB3925.namprd12.prod.outlook.com (2603:10b6:610:21::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Sat, 5 Mar
 2022 00:25:29 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::51a0:4aee:2b4c:ca28]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::51a0:4aee:2b4c:ca28%4]) with mapi id 15.20.5038.017; Sat, 5 Mar 2022
 00:25:29 +0000
Date:   Fri, 4 Mar 2022 20:25:27 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     leonro@nvidia.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/core: Fix ib_qp_usecnt_dec() called when
 error
Message-ID: <20220305002527.GC1248225@nvidia.com>
References: <20220303024232.2847388-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303024232.2847388-1-yajun.deng@linux.dev>
X-ClientProxiedBy: BL0PR1501CA0035.namprd15.prod.outlook.com
 (2603:10b6:207:17::48) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff314c6f-e116-4a3a-f152-08d9fe3ea6ad
X-MS-TrafficTypeDiagnostic: CH2PR12MB3925:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB392531E4BC071666965D4E13C2069@CH2PR12MB3925.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zR0eX6RHuwyG7fHZMhLiQe79EUDhWzaPov3cYWUsVPOUj4rJly7x4MydxaqC1OsXp92FgwEP+irYNC4xY2/mDjPD6rT5PU1pvacNmPGWsrsPYlZqYEWGxGW5vJFV0a8OTr0BB03+PXmNwwTFmoAJs4W70ZSOfIq14Mjvb2IfZRixjY9lwwAr/c9e0olCwozExKiGWirKF/c9AS+o1HeHX0rMUxH63PTCLffJ87XhUhw7DuRiOg8jnWT2ei1KTSfkmE+zRyKK2cTJNSI6f1epLMb8AIRsHMPZXHZ/9Iu00uIBTR5TxCOP04+G7Dowy2kpayLxAipi+b5fe8qUFnZlf3Ipkk7zWRPlcI5Q7uQhUAqATwsRsCE/knw/hXN4HHOaEHW9rAsF8z6g8wR9Yija6sWZFoSsDmwaLW76gJUktupg4hSLXw4zI/rCfvIS09YFMU1Wzh0F0ZHKrKDxhlNCmZaElm9b/jS+iFCUCqzrPsxtGT4131XrPE1oN69ims876zv1JxCsqB9AnWEZyYi1FX9jMpoiVj1uLPRO9veoe8OkF9j/RIm0xhDZAJ3+OMCaNf9oovTsUIuSfVUqiTloh6mC+fZ9GqP9zdM5Ty/GjRAMTd50kyvJhMT6PGcCFtERA2vWN6eC9xjZlnR9JDPKcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(66946007)(8676002)(33656002)(38100700002)(4326008)(66556008)(2906002)(6512007)(6506007)(36756003)(6486002)(8936002)(2616005)(83380400001)(508600001)(4744005)(86362001)(6916009)(5660300002)(186003)(26005)(1076003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?psOsAOjy5gp/pQZ/0KXCJ+wd2wMPQkpu5ZD/4CqHjU4pY3dxhzcgmZPmRB5e?=
 =?us-ascii?Q?NHp9KBg0ZFGeuXWHGSkITneXRkM6UucfNH83vmjq17lt3wMXjY2Je33IKWbb?=
 =?us-ascii?Q?0y5+qmp8RcOIjobHBkdVNLVpHp9UUU8dXvUfnc5dI2HN3XgYNDNokG5klpRa?=
 =?us-ascii?Q?2TfV2fJF2QR2A7pXL0kbmKhQLCuKSFH06Cl308qIjrmX/isfzy9VxoWJjFRc?=
 =?us-ascii?Q?SszDFMhFgfZtXfG8Ym71XQf27BhfuQMUKtAI77usgTXxFMjDoJjT1WnoeEwB?=
 =?us-ascii?Q?dmH5RL8yyFpAMpcGSRCzbzJc1wMaf30jq8w3dZnukmnzsQA2ivAqFj09iQt+?=
 =?us-ascii?Q?cLVK9djdHDGhNavyJeZHuRA/DuyL9W1uJPX1PjuFn4qYF4wyJ2EY017t/dG7?=
 =?us-ascii?Q?EIIm4vWJD71rqcVW4kszDUf8vAk6XtPGWC2SRlQLoKUpQ1UPcHoHlu1e1G/W?=
 =?us-ascii?Q?2eK3qtvF0Wj9Krciptn5Xnft6PwyNaVhz6DHlZEj1dzyDEPDh4Z283Lfqq9f?=
 =?us-ascii?Q?o6MKIlXANeCttBv2ftCvMEZ1i54tZ2O4KFC0Gu2iZllWHpDqfV2tS/6Z2urQ?=
 =?us-ascii?Q?Ks1rqRzim5KErC5SqkUzYpa5BgzSCxGU1AXqKvhleUMRrL6LbUwjN74l4G+6?=
 =?us-ascii?Q?S/PsXzLlTQS+egNbSEwJscbVVOSeZKmtGoSEv0dTxvkM9r9CGsvPjcDbDtHb?=
 =?us-ascii?Q?XOV0BirxUtTQ5IR7AB4g8H4WxQbVHKREfM/lderRotVNcvBsZ2skcsrHhbpq?=
 =?us-ascii?Q?jCZ0F587DPLigoU0ksI7wm6mavy0RGcki2a/IWPoRxEkkSGzYQw6aFy5Whqp?=
 =?us-ascii?Q?BCDQHY+7HYemy1eFgfLzdOwP+5iVm+4jeJLjqKk26EIRFv/LRk9Py0+E3rrB?=
 =?us-ascii?Q?Hrtwvx2YQVajcn+Wh7W8812siNqsRWNp4wUyrkF0DI3UyA5mDLwPx1Si5Bv0?=
 =?us-ascii?Q?zIDQjZsGMznPb6F0c3LkJ2rOEhpULKpvv9sWvHnxeU3JhZ+HqhkG5LImbmTW?=
 =?us-ascii?Q?jR1Ub8wOiaUqfVEiO9bLaesiYcaPvpNJP0+Cdhb7D9JWJ3HvdkLcw0nzxGZx?=
 =?us-ascii?Q?WeTrTnZ21CYLbK7d483rzQnHqkWvvDYmEoRUm/Ojc9pxjjM8FdwlRNs50HP7?=
 =?us-ascii?Q?Um6RZsNwEpQ+hBd+cOg2P1boH6QrTuxSXisJiSDV/kq5zRAUSHAN1ai1QI6M?=
 =?us-ascii?Q?ucIV7ZWA+ftCmHaEqM8aUioWCUiunuJrj0J8gWEDfmBKr3DXqGL4u9HaIbtc?=
 =?us-ascii?Q?+qCE19+UdDugD4FQgz0XHpLGJrEFw39DWR8DsrQrwwK2ZQq5E1L3Ua/40lts?=
 =?us-ascii?Q?rCxho9s+jw5lKDoS9oKgvzDDowjarZxBxVH2tKnrxih+cq48b4OtI/9ZF9oM?=
 =?us-ascii?Q?kMAi3miABg8Ja0w0hDZnXHq0DlE96lISJQbdTUJ6Ctk81rScUdhnsaQvq4No?=
 =?us-ascii?Q?8unU/pfR9/bT0ovrktE9utQzeBlqOPNAegR7akWjMNgan86nsYxDLcIRF7Vi?=
 =?us-ascii?Q?qZjD3R1Tq1d18MiMAVCMhA7ViPCMLzD162DF8NeoJoorRMqf/K3izkZWN4kW?=
 =?us-ascii?Q?AVeNzXLnxEuCcbM1E4c=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff314c6f-e116-4a3a-f152-08d9fe3ea6ad
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2022 00:25:28.9681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2wxqNQIK6M3HipAJp8PGJvqrqmi/H+2bF0lDv9yBZteJePKhNV838cSsEYIQ02yp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3925
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 03, 2022 at 10:42:32AM +0800, Yajun Deng wrote:
> ib_destroy_qp() would called by ib_create_qp_user() if error, the former
> contains ib_qp_usecnt_dec(), but ib_qp_usecnt_inc() was not called before.
> 
> So move ib_qp_usecnt_inc() into create_qp().
> 
> Fixes: d2b10794fc13 ("RDMA/core: Create clean QP creations interface for uverbs")
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/uverbs_cmd.c          | 1 -
>  drivers/infiniband/core/uverbs_std_types_qp.c | 1 -
>  drivers/infiniband/core/verbs.c               | 3 +--
>  3 files changed, 1 insertion(+), 4 deletions(-)

Applied to for-next, thanks

Jason
