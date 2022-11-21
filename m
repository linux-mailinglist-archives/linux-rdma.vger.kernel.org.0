Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259B2632C89
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Nov 2022 20:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiKUTB3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Nov 2022 14:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiKUTBM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Nov 2022 14:01:12 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2084.outbound.protection.outlook.com [40.107.101.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF69D29A1;
        Mon, 21 Nov 2022 11:01:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOlEcVLeQaunCq5vb3ByelXDoRx7C/nu2RsTONj5vgOEJ71nPl73qE/rXMEee7mSrJNIg2ayKPoihb8K4Jt0Pv1fmkrovcuy6ifVyRM2HiDY+YDQR/z/Q00UebFP3rSuHoTCg46Eknos/dAtSmobZ1gvsoDIvdaCH1m8acVMByXRcxVwkKBZVAd9FzGP6jqp7uTpIv40JLL4hFu0HhsMb+WEnSempgf43GoXUZNY0HIZoh1/DAMnVAZf6cOTRFo7fByZRFkQMhYjo6J+9uDNNAR7EsBuzhT/DjHqb12BJ2H6V3MsboZoRhTvetT3sACJfnhdwz1UhzcXCnmDCZa8LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3fB0v7mPVEVFrCKIUGgsth5Q9/HP3AwQeeNtIB38Bs=;
 b=RID36Hzq6mIufs61+LZgv38gxjI2bLxTW3Fi/8kSl1qmdzhibZw2ugpSxGqnZrTmWD/jcP1rx/+B2OjZ/5YNXAGHGpTpvursHgIpFHabnReiVjkO146yH5fEikBPpOB4q8iI+NtIoQBgKup5jLaefFIKP5MtaWakbzxmRkSPaNVlOhgE9sb1D2PC6pCKz634uXRIc67Ae8Q8aszkHqARfHySzCXv+vvXMghmiVGPwNro3GWwc7x4jVwYM2mVtE7FwqTt0/BnV+a3ky0Wq6Tfwf7O0wfZBDW/n2rELjzV1DK1XQWpEslxJAIBHorpeUuqHSQ7ZzcLNOqRX8mc6BG3dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3fB0v7mPVEVFrCKIUGgsth5Q9/HP3AwQeeNtIB38Bs=;
 b=Z1iRmCG8NheTVBKmJZAKPgBaLy6HFM4YMh+E6MYq3dHbdbGDHvHKlSrNMK76GlczSZX163xuDyieWSwCUB1H2LF+t8H+Q0XmhOaeFqVfrn/nI+8Oz9Ef5/2wtY4N/0LNPvoVx+dOpEre2u76z6chb7RsIq2sKTZ4SE52h/CZBsnprskB1wiROfIvurTSNLaXOUR2+097ktXzSoD6N2/Sjt/ZMnmKgzsrWHhjPF1n5Kb6s1lPo91OO8DkeFDiCBt9/Gr0/ogfoHd46R1vEz6DWNW4QAEw1u23oim/Me7RQ0aCHavTbN8HCWlDoWqCFU9/UTHVC+jA4MIVp4j1kEHL+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7756.namprd12.prod.outlook.com (2603:10b6:930:85::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 19:01:04 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5834.011; Mon, 21 Nov 2022
 19:01:04 +0000
Date:   Mon, 21 Nov 2022 15:01:03 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Maurizio Lombardi <mlombard@redhat.com>
Cc:     sagi@grimberg.me, linux-rdma@vger.kernel.org,
        target-devel@vger.kernel.org
Subject: Re: [PATCH] infiniband: use the ISCSI_LOGIN_CURRENT_STAGE macro
Message-ID: <Y3vK7xy7CVf2s3Sj@nvidia.com>
References: <20221116094535.138298-1-mlombard@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116094535.138298-1-mlombard@redhat.com>
X-ClientProxiedBy: BLAP220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7756:EE_
X-MS-Office365-Filtering-Correlation-Id: 5de6e420-abf7-4b29-7c47-08dacbf2bce6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RaMFz6mZfQGTOBf5A6PwchdDiAg29V2XCfGKcJdmFtO/z86c59N1T8pvaAfCt8YeJqROIl0kthOloDW0Q2JPUai2VzhdqpZPPme4nMa6biHpcILvA0YMouUANzjm7DP3nZ1cHaNRKOeckv7aZZJyJ+Vj9mG3GNAckGQYsHRmynQhs4SpIv41K+kKHFoGV82clvON84mzQM2JH4EAyX96/K2gOTGOnSEO1JhBaNaXDPKwPVXpDJP3cUFVYkjYLq2T9loaXOmpq11SDDqET5R0cAXfAPcLy0ymO7Z5teywb68wkh47x4LMnEuYf7MHo+/gNaBjdHCzLEjZCUDOhMXn9KT9C2i5iRW8VoMKz5O8RtvhMlULBiOCPVGb/MhUAlsqYOjmtTi03UwcNg02aANIzD7LWPt0IljgNqJrRf537BSncmihOWXNnYsD6zAh2Ufgn+cbUkT+ZEXrKEWz6Di7Fs3YRXXvZG2n0vpBySxhJviNIV9Gv1u3RGzqfcCmrl5dCFqpTWyUhlskg3It2vVkqpo7Bk4tPiapci5tnX3iMfzIhbK30wydpq5uxxizj3MpzjqP9xeT18jMVukk2MjYs5yU4jo5wITQc2QxUAXuhb68bt7r4rjjPkMSH/MwTI9ONZV+Fotxd+H3OvK2akyRfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(451199015)(478600001)(26005)(6506007)(6512007)(41300700001)(6486002)(8676002)(36756003)(2616005)(4326008)(66556008)(5660300002)(66476007)(83380400001)(66946007)(186003)(86362001)(8936002)(4744005)(2906002)(38100700002)(316002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FpdONi8vppgb0nBCR2jFdeJm4buoRkF5xA2nqDFJZRpue+kNBAnDdX8b/fPP?=
 =?us-ascii?Q?DMLLBrQ6vEZZYvAyrg28KUqmGyC4i5BYqCr9UY21XSd1zi9B/SNn+/0l0Iw8?=
 =?us-ascii?Q?CGH444xJsEXnKbGsmRjD46kK6n2AmnO0ssPNKN/EzcjcfwgDK1F2376Cwcsr?=
 =?us-ascii?Q?dXaO4PUys3P1zeGk6vkdMBQdY9wyzOAa+DNzuAvAyDGUY7WhBJ5dxA8Dc/RS?=
 =?us-ascii?Q?9YqXyzTo0psK2vcPMmdFq8vLTj5TvqLZWVaS/a+QLay1/J5dst0TjBtiGBYo?=
 =?us-ascii?Q?Uhtyug1HyZ+/mb2DB94PLeJTvhg2CIT12lJyAI2DoSkE4VxU1i+B5GpEj1oe?=
 =?us-ascii?Q?nNKPidjpaEDO2NbeLZIAGfXF7tI+0s3ojMabWZt3IpKebKmDLZauKBTj6lO+?=
 =?us-ascii?Q?7Azz7LUx46QUkhW6CIbsf1hIu903yXyjUXW7RecNqLwxN4x9mtCbB7fnC/RF?=
 =?us-ascii?Q?jEQqZAlULCS1eGyEytZE3s/RqiZjxGSC+b65VdHIekS06aqoOhhc9cokuYhB?=
 =?us-ascii?Q?SVIOkFcKWjb2jfIvpR/JPvQ03x7qQUbgBuBpJEYy7aP3Oe8dmqVMt8WdLbCq?=
 =?us-ascii?Q?w7bA6WgwRhAI+aNxgP/zJVprWl3SzPbN8SZ3rqknA3W+nyxze595aXw8RITo?=
 =?us-ascii?Q?yvkOMmwis3TjuSrd9u0v/GvHxAWtsV1+TCUKl6STNtAJbuNmCI7q0T06xZYI?=
 =?us-ascii?Q?WbhUyQiIhLep3o9kmo4eU9o+iah5L4FZQWPHchV27qSTMLhxJW6if8L+zdlt?=
 =?us-ascii?Q?cHLkyXSB9s+KzHiWampY22LsCnvil6bf+B6FPRwgZ16qEQNKg84hg2OdXd9F?=
 =?us-ascii?Q?CryUnaSH8nL2BsG3sTw1KKPyRoNU/nVgljfgLCsi02XlAcjUbL3gaYiS/cSK?=
 =?us-ascii?Q?+ZEf8O8nUiixC4j6gHBeJAl1ZxyijlKxUDoRNHAodHdb6hn7p0ZN1cvRw/O7?=
 =?us-ascii?Q?Rf4sh5PW4NrX1mmZ8zc/tZeOPUAw1dmd3z6HPM2maT9o6BuShKiajNNIDibB?=
 =?us-ascii?Q?QIMVbNNUjt949ek0rt7ZYsIGtb5bWg2/wstflPf4wpHTDhQjwMKU/tukfn7k?=
 =?us-ascii?Q?nAtKarO4IawO5k7St4plLFnL7ABpH+pa+IqqEotg4fGs+LqMGegccWrODi19?=
 =?us-ascii?Q?yiFii92ntdugkh7IY93wKYDWkbPHzvOx8UkE5OFHwxJbZvWEgFHigwOwheos?=
 =?us-ascii?Q?KWiazQtjpZs+7/2Me46fCXys0HoZ5/h0cuumBprLwOgIldi6RRkm7HM8blxk?=
 =?us-ascii?Q?i0yBCwK247J9UVNB9bBoUt/CdlBH7egXXjlya0Hb5J+LIlSymcGaARD6102j?=
 =?us-ascii?Q?WwrePQCFJlWupqd3Piel/bspHVAWp2u+Kri+miMDfUa6Ns2yLvxrYV1fC9Bj?=
 =?us-ascii?Q?cjEFkSYqz6JOXu5C17SQPWWgBIYPqBWvYK3teZZXkZ6CB6YOTnsJf7yyxTrl?=
 =?us-ascii?Q?o7d1aLK+xPXFO2nvApr1gKko27WU3THfv0A3cvHIWbqndQn7JpMJ6OpE73/C?=
 =?us-ascii?Q?QrykOheE1yteqfAEFXrg4sjRVueuNrKweTbyBTmyOKtSBDrxJe+tB8AMBNaK?=
 =?us-ascii?Q?+RSfzdpikJwDJs6ZGcQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de6e420-abf7-4b29-7c47-08dacbf2bce6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 19:01:04.1529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tn9yf3rO6ff20VSU5vb2uYv8/g6kETEqfwRjpSrk8I7/6h87bmDSHh7wuzZEk+mb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7756
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 16, 2022 at 10:45:35AM +0100, Maurizio Lombardi wrote:
> Use the proper macro to get the current_stage value.
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> Reviewed-by: Mike Christie <michael.christie@oracle.com>
> Acked-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/infiniband/ulp/isert/ib_isert.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Applied to for-next, thanks

Jason
