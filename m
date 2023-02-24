Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002126A1C39
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Feb 2023 13:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjBXMfK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Feb 2023 07:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjBXMfJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Feb 2023 07:35:09 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33E364D41
        for <linux-rdma@vger.kernel.org>; Fri, 24 Feb 2023 04:35:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Th67fiVR+BYeXrau73qvMYnFTJOI0tmqNpYVnei5dbCKBm+NdNE9VndBKXFBlT191gLGIqHrW28+yPt1/kiQmelzdMWDWqrJNBZzssiKlbVlDBCUjX70oQvTIN5MrcQl8kmgmNsD65LfbJqjZOZmMfJ+oGYRaD5PGNppopNu3gDa0M+k+NhjSWJYliLmBaYONgvTgSn5q+n1E3pFJx4DOK7vUf9i5g9O71P3pIEvaHUH/acqeeDCc2OIdcO+dZbdQn5sBvvsBxqrQFc8ewFCLZATUFDhVBZ3cfW2xB12nDlzKkYKWI/vqFZNimxcOM0viZjvPaz67hr56yi7VCKwog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ceK2c0ISq649kaGwsLRGbO8lrLwDG4OmsHGb/QAUJwU=;
 b=IZScL3H7rgtQD5wqKTXQZDzX+BxKGJ1BufcNzogFNMDH0BJR/H4XwsMFmwuqn4EOqSAOkeIisZOaj081eSLOnpQQDXnL3L8Z6S3rddPXsXiPNFE0jwSyvbuc3koDCYA2JaHpSQByAI34RBQevkVr9gj0oCfb0/s6mGaLumYO4sH7lsOTXgLOmz+vUrQvwJgLvKIAyYOM1fDcTBYf+JwotNXk78oycLn5/CU1vG9QkepTiIEhgjKGaxWO43N1UII+n4+EVl+050Lt9VxKRs8HvDfyRHalOW7EgZAyXzvaABvYZb6f3HXqOJei/qQPXANdZoXClSYBHafqGXfQlenrFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ceK2c0ISq649kaGwsLRGbO8lrLwDG4OmsHGb/QAUJwU=;
 b=laFdmevsTE79tGevqq/rOIpsI7J/O01V5Lb729dJDIfTlxTBnhYeDDgY/NiHbTAyjgXDMdHulJAU3p2MXp76fkM1oHUCBzHKCMwU8RgpMJFpJEsuYzQvn3ccDqvqX4+ChOBSIqzeag8Rz+Wwm0t3TmLhWcLJ59bdsO1qvnntIObYITbxuN7xrHNbaCTBh5BXTacP3vnYyKjG+s/ELh2hoO3FXK+RAs+Nl7JXv9ybCDU5a94eDOk/8zuGFxhR0bUfGsWxDFcOSnWdIeI0GvUw4QNB6HQ2jsdk8blj2rjgaN+x66R0mZRckogWnGJIVaZvmNlp4DYP3HqbRA3oTKBG4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB6864.namprd12.prod.outlook.com (2603:10b6:806:263::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Fri, 24 Feb
 2023 12:35:05 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.021; Fri, 24 Feb 2023
 12:35:05 +0000
Date:   Fri, 24 Feb 2023 08:35:03 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2 1/4] RDMA/rxe: Replace exists by rxe in rxe.c
Message-ID: <Y/iu948rjXh9Kj0W@nvidia.com>
References: <20230224032916.151490-1-rpearsonhpe@gmail.com>
 <20230224032916.151490-2-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224032916.151490-2-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR22CA0008.namprd22.prod.outlook.com
 (2603:10b6:208:238::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e4c7fdc-aa4e-4711-201a-08db16638ea5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ne5qXeipG8I4qkORuWM7sMcdfInhtrVF33EbGBXUz1DoxjVkXxSr7U+SjZS4C8RCyC66VV7IFpv3TIIn2Bm6L7QbvL5Ci5aTxk4545d9EwhpE3WmCwidGvDcGx/UbJxwf+zH/0WBsQF2OEBvEYOJ2IXfEFBQ26pA739zTlXrLKewtqCpAkkgW/TVtS7TdCAj4Ual9JU9lBkKtvwhHK7RuUweG68e/Z6JGLLIbmJempiyV5WDvUIodUOngYVoz8kEryjRXq+SoV9RLMaervkbD4iBAAsLwbkDNhP2a6Qh3fQGBGkZrfHSiwV/7YVK/nTyZcOGPYq8gtQ83Ip31I1S6fPe5A3JfPYI2Fyz27k6bBYhd5NPQ6Wef3iIUaV7QKYAArb3wuIyVEg7trVO7QkiNa8e2GY5CDzhthx0jcgXG0E1BNZ2l6/SIvq24q4aZ0w4OwHm7MQG1pPdMc4mzVncDaiuF/Rq/PmPMiRt8SvmXnyY6lA0V338VLuCF/w099kApMWOHBtVhXtE90lTwAb14LLAw+lxEqvDpHCunTcTDbnta1xE8rpexv3chh3uPAictQ8tgYZChg+QORTz2d9T/TQkNEtrSYZjvD0F03N9Eui5TdHQWULpoT2RLiyAGYpVXmADfaU8ooZ0MkXu8bZgykGVkg8SvO8VGHJ5GfnvAJDYkWQNN1MupzEAy4qEF9Rl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199018)(186003)(5660300002)(38100700002)(83380400001)(8936002)(8676002)(41300700001)(6916009)(66556008)(66946007)(2906002)(4326008)(66476007)(4744005)(6512007)(6506007)(478600001)(26005)(6486002)(2616005)(316002)(36756003)(86362001)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IEPHsRsXRbP61kA7WhPAAjBOwCt7Uk7qt9Pzx6kyIUwY8d5Zwr1qWmuTAx7G?=
 =?us-ascii?Q?ZgtdK2WHeTB241Ey5QWw6TRB44+nwL13dEWtypxAF4k5X+ts8eAvJ3NuVGZg?=
 =?us-ascii?Q?KSRjLzGTvnuOHeYl8HjUzrIdH9OoYa4SxK3h3PHOE5c+j2jRZPRYBq44GJ/R?=
 =?us-ascii?Q?HYwLaz8badivNJV/0NLYkBgRcQPWkC0qHC2yK4lrXvHP9/eb0zgVadNP+0P8?=
 =?us-ascii?Q?Kv9N6lkq01n0tIcMIA/WWBNQJgJrjSyth3pbFLhCuWfKdTywtItTnwIWO2oI?=
 =?us-ascii?Q?5xRiwM4OctpDH3j4oQpCRz+GagTvV2ZapF1bWZ5a5MjiNQMYwuItZZweOdfc?=
 =?us-ascii?Q?Y47suuEsJRGTtXqBlMoUrTprIKt6577XYU0zeEcA7cZxxo+fo5YPHQ2sWU2C?=
 =?us-ascii?Q?4fy9pVn61LYvseNqy1ZEOahuW5BX3vQhbaSPmUw7WQq8QbG/nu9JMBQDg4KK?=
 =?us-ascii?Q?5flSTKU/VlUKw5B3VKff+6xmWYqv7GU6tHr1FHhc/pERcv4uOclGK1/VMBcS?=
 =?us-ascii?Q?gWE3ztrCXGd3B06eHlLBxaKch8TVpdUQvN31lQ1n3elWj1s5KIxgz+yfWNv3?=
 =?us-ascii?Q?gt9vcrCp+4D4CymFEWG/s1OM7I181X890W4uNl2KgnUqtArk3Iw2MoU8QLnk?=
 =?us-ascii?Q?sxXi3dBAI8p60hCX02nM8X1RMTNkelmmlUdpajRE7UCF796br13Zr00AGZEZ?=
 =?us-ascii?Q?duYCsOkrxdTpk7E0DQtXkNhRaHRMWcHA8tyb7WpjTUux1ew2RH0iPn0Ky81M?=
 =?us-ascii?Q?sm7h67TO5XxeH+P976eOw8VklM0DC5kfPAL/Ej2MNiT1NNqe3Z/rZRM6EWVU?=
 =?us-ascii?Q?qwLUUFuhOh/oHEN4rakdn1BsVLSk+XlHn89wnq826GBFw4tVpek2mIFIXmiZ?=
 =?us-ascii?Q?VCb2PviJOvFffYJrI031k7cvXQc0iMLxRz/LCVs4x9A3EE7QkAPVlPdo9rzg?=
 =?us-ascii?Q?F5rIAbkmKdee0XzUtJMZTjRhhlts8mVLCcO4wM1KMu1SDkp9+rWLvegIWNL+?=
 =?us-ascii?Q?vRlFyaTPhYqy5o/wilC5CGvh48sJuuIqU8scgQBa88hl3Jigxh6xU1aIzx+E?=
 =?us-ascii?Q?j756mP6u1qxrb9PKirY7lZc79NDeTwxaAMGNOcnf1IYA2LuCV99rmtGhm7vx?=
 =?us-ascii?Q?xN2xqNjNQPbAJqwSpRU/mZw/9FVOlpKADcziNqHLYUuHPUzTHIWNFNQXEGHL?=
 =?us-ascii?Q?GtwMzvRI8q1RptmMkck/6++dViNw6V1jIVuhBO0kKw40TTROQjN/Bgf5NUf0?=
 =?us-ascii?Q?GQtYEHYc/SYyRgIuakfkBmAtNM3m+3xDwiqVxvNjXNlGBsLNDbKZ7ttCWcZw?=
 =?us-ascii?Q?GN6F0kGj8sAnEH4YiNpdpzBwzJeSMBLVytPU+uQNzYl2JuUyokP3EjnyKcsk?=
 =?us-ascii?Q?ZdzReeAzd/Nr45u7T+VjKTr6bRGfPc0f13alGAHLisYkmIkjE939QCzUOWs7?=
 =?us-ascii?Q?u6C0FfZ1GFIobFnGUe/Yxpsm/emBQ+s+ulTRQSHsYDuzOnCJ45wymM8gLa7i?=
 =?us-ascii?Q?y4fOQRFYJbzePbf6GNnRFt6puW5lX0Y2pg5v4RsF+AwuLKPIOAxiHzm7Udzt?=
 =?us-ascii?Q?wzc30CmuQNVRk+f4oMbRzWHpe7JlTAizb9Ckcuke?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e4c7fdc-aa4e-4711-201a-08db16638ea5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 12:35:05.5861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3NcKRAoLizaib8DhKR0SQcy8M/kwAqtwrReGmolOAWyM20+U4TEeqfQbaH/wzBkt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6864
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 23, 2023 at 09:29:15PM -0600, Bob Pearson wrote:
> 'exists' looks like a boolean. This patch replaces it by the
> normal name used for the rxe device, 'rxe', which should be a
> little less confusing. The second rxe_dbg() message is
> incorrect since rxe is known to be NULL and this will cause a
> seg fault if this message were ever sent. Replace it by pr_debug
> for the moment.
> 
> Fixes: c6aba5ea0055 ("RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe.c")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

I don't mind this, but have you thought about instrumenting it
properly with tracepoints?

Jason
