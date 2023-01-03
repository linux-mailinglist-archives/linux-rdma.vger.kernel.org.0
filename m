Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94ACB65C1DE
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Jan 2023 15:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbjACOW4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Jan 2023 09:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbjACOPO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Jan 2023 09:15:14 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C213A11830
        for <linux-rdma@vger.kernel.org>; Tue,  3 Jan 2023 06:15:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HM1MlZQlmEwJnLWKz0JmjIFyM13Ntongb/oSst95LMZsGsApEX7CTYbJggNW5zUDu9ORVilSzO7/OqQUGJkEtVhdNOSQnf9XFNq94LHy92s0xSKMMTNzGesOIalYzGZySUfRUO/dJlqQjVSjfhvC1iQZI6+dPnoSJoDshuy/H8iPx3dqgWF8RF2kXkLPIgckWgoUla5lgIsTJxYw6Tc10pq95b8C4j0gR/lzqvFgsAFcz4NUqqv4Fsyul8YZ2866Yk9DVGL4EeHzK8zcMYzhaLlyogEZOMY5RrEpmatH6MpLe3vTYIcWWzMoB9QQ2EKylno4iD/n3UKmwPWHaZumCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+qrD7pVp4N4nDsuY7q0UP5WZQl5DSKK980MnTGbbTw=;
 b=gsMQs/Q/ycnMEa4NqXzJNSoN7N0AK6DMWgc5huauSHNdRhjBtSWA5IonQsNfs4as2/MN1nMUL88e+VSM3BbtQAjii9rT8+/pByqaJHCEqcbRnSMg9IXB6fMMkfq593e+ING8KdPgph5FfNTbn5RLn0WM3J3Drto1mVvUT1mt8URbbZ3d4vf50ciP2/IVmLS0IBDHSmbmnjn0EwyJv/XLes8HK34QMeTDtpiq8jKvLPJOk5SFt/FDAXyHiOMjuKz9gFDajbEDNW6agzlxewacxwViHBT1Lw0PfT0V15N6impqlk0exqTjTJNEgJmmUz6ibbOCRnfoojRA4ebKJ3/Q3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+qrD7pVp4N4nDsuY7q0UP5WZQl5DSKK980MnTGbbTw=;
 b=IgzojGn66cjLfYTJe4SCbll0IuvWU2ItSU7UtiG+I+5h0GSxTLe0HA+fffgbeb2TLIx9mlkQZd8rRoELdbqb5M/ZONvSwYk5T0+k2vatPCgCoCok7MvhpUz7Cc82lhsTxwkAZe0gDn+kBcMqKdO3rU3mPEaEvqKp2PARnY+ljpbX4LrSaFzJJHCGeksYo/B3MBlAa0BZhjzcdJKCWQOGr9eCbT4sJmHYBXf06CA7/US8PxE5dBoU03zZ6VMUl66xNJUKEUj0Rh1vRbHgRRWFAImf/fQQNTpcgmskGQx3Hk5nFSm80HDdTEfTO+O6uMh3nCwNDCklrZvdwz2rxB685g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB8015.namprd12.prod.outlook.com (2603:10b6:510:26a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 14:15:11 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 14:15:11 +0000
Date:   Tue, 3 Jan 2023 10:15:09 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "leonro@nvidia.com" <leonro@nvidia.com>,
        "David.Laight@aculab.com" <David.Laight@aculab.com>
Subject: Re: Re: [PATCH] RDMA/siw: Fix missing permission check in user
 buffer registration
Message-ID: <Y7Q4bZqvDWeDNE/m@nvidia.com>
References: <20221216183209.21183-1-bmt@zurich.ibm.com>
 <Y5y6OaG4+6kPt9O5@nvidia.com>
 <SA0PR15MB3919045403A59EF36370173599E69@SA0PR15MB3919.namprd15.prod.outlook.com>
 <Y5zRR4KbAFOFIvpU@nvidia.com>
 <SA0PR15MB3919266C672961F49B28C7A499EA9@SA0PR15MB3919.namprd15.prod.outlook.com>
 <Y7QopYj1p4eeLo5N@nvidia.com>
 <SA0PR15MB39196C05636860B60263FF3599F49@SA0PR15MB3919.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA0PR15MB39196C05636860B60263FF3599F49@SA0PR15MB3919.namprd15.prod.outlook.com>
X-ClientProxiedBy: BL0PR02CA0031.namprd02.prod.outlook.com
 (2603:10b6:207:3c::44) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB8015:EE_
X-MS-Office365-Filtering-Correlation-Id: 7787f1d5-2442-43ec-45a8-08daed94ecf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mZikQsbosfCevwjiJiMScazPNMExVRE2yU4DKsBe+DqXrvaex14rDpk9dRq+tYLLG7gWRQ9B58M729jz2PJUq4CIk2fPl9B12obW4wkAjo993Xm0Bh66vorlFu3MtOhiliIZNtYf+laWJIucY0iYDlRkdbd9ToIuMYFdS3ZBV4HsKkcuX5IVEtpbQSfjPxm7GUxKIQLVh4CC8uPkNhm1K6le4jPHb0u+C+TOn5CopDLnXfTcQIMQSKCA1xBq/YKQjrSwPiLWL5L+q2L85jtiftGoM8RHUHQz62w/HK/MaIcnOZBw1vDYYDz+Zk1XOJdf9MhErDRD0Gy/xhvGw2BolPn644QGc0G9FRLnPFWiPM8+YBzooLVXsXPnyF9MFH6GmwlAJCV+pMDjdJ9KZBOQM8P3k2jor62AX3v/dlmmFtNWSdLVfukoKV7YY5HzMAT+oZAkMobiCU1PDJc6guAHApOFD06dLIbVllrS/f2sFLucF4N4hvnAmJoHhYgTAK7moLwB6Iud2LupYftZvLmb2t7roglTGKwWbEb+NBk/ZchZ3lJ+CKxi4cuIcQ7jubzobIzgLW5jyVRFw8Em3PzKH0bht8PyZzb4mt8qcfF5T6NOteUSeeHgOiVYmWbXFW6xfAzNnHc+lSQY8zRi49B8MnKFMPnwpbpclwGKAY//OIyDS1BHV1Ty7nF+6zGO6R9mtPxDNSEe/OLX3Yx6+GyBRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199015)(54906003)(6486002)(478600001)(316002)(26005)(2616005)(186003)(6512007)(6506007)(83380400001)(4326008)(5660300002)(41300700001)(66946007)(66476007)(66556008)(8676002)(4744005)(8936002)(6916009)(2906002)(38100700002)(86362001)(36756003)(22166006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zFWWe4AZEaz8OwJrU1VEgRFRcDUrYe759wmdB/b1+QPkBznryUIq28YekhrY?=
 =?us-ascii?Q?4TtFUf7PdG6nT2gfhdItS2EoTwvP7ehBqLXSUZROk22it7hMsTUrRT4RuQ35?=
 =?us-ascii?Q?hy0eVcCGT5F2+P82gs7AJxuXkxDJQ6GT+iHJB1pDR54S4aKCOEClsvruqgQe?=
 =?us-ascii?Q?sVbTLM4qFBFluDjLVgZzvTw0FmGga2eX+N9hlE2MN864Gw1RQrjrYCFY9m9w?=
 =?us-ascii?Q?E3c6XM2IUmCxhNBld//c07n6nih52fM5WQi4zcM7h/QFERDStlyBVqVU15F/?=
 =?us-ascii?Q?OCj4JX8pG70WNExb80K9A2lMkE6JxPo+rJx9B8MBvUh9VTDr9cGmXqc8xRfm?=
 =?us-ascii?Q?QNJPVGS12I+i/yHLjl8p8h/idKtz2QJXlYz+1+n+8ycH9XQN63LYUKWuWT3q?=
 =?us-ascii?Q?b2+oidsme0VWlkjLYgVqsQHRnysDIbgvMoo7Vfewlp+goWoznNwlP7HBhkpZ?=
 =?us-ascii?Q?vuACpvhRQWbsuxpc+Lvf2svOQNs3JxFEKO8pysVx3AEMeDWkjRZ1ZrYu8Eu9?=
 =?us-ascii?Q?jC/zM5KUKJSQryiEZH6EKz08FA+6sqEszdsFghAFUNIANazsSOejlyLAQRJF?=
 =?us-ascii?Q?SHxaUkUs+6IMbG1+k3IkomaEUbtSHd3taocTLqbymZLjmqXGPQ5mWbD5DwJG?=
 =?us-ascii?Q?toOFULv+TeBElM8xKpWPE1AMhzmtqA8UMwqpUjKHuo3QqHWE9ANVpjO1UlVv?=
 =?us-ascii?Q?E16J1+fCDPkqpw5Pye/axZrcNyAv+L+qEPqldIm4xATz1mkVkK1cvs04St2l?=
 =?us-ascii?Q?RYDs7GgaYFqEzWGPMjN7gsntDXNy3gl3yDiGNZHJ1ls7c+rNRcEETyYnVCDv?=
 =?us-ascii?Q?J9D3RSfTgzAAOApQGy6iS1Rvoa0qFCziEJn9brF3KIpXGqw+yQwb/j2FD51o?=
 =?us-ascii?Q?aHBAmhIsxSjEiN7LR3EcmzhCGQTGpjNNPlG5D6Ydc/k9T7WrLGT2zC6czQep?=
 =?us-ascii?Q?ozhhcm0N1GY/cwrorQD0mTHOW1ahBEmzVTVJaz+pmffy7nQv0LZQmbTo30V7?=
 =?us-ascii?Q?5h34Ya3riMYB+UIA8CojJHE2knDci0JhWhT3HTa0ywd44z0RujvYFA2fdRXZ?=
 =?us-ascii?Q?cKd7K1w4gg2Ue5jXt0z5cMQ5wPQ7KMm7Td04I4+qa78d1NnKGv9EKRvXre5D?=
 =?us-ascii?Q?3ZQThgxGzTlEX/FBryKvVkBgr3L9KEtWSUwYlHzOO8xz/MTSsdgcKdj3Q5zW?=
 =?us-ascii?Q?ps5UJNDjtUP7GUJIaGJPKuWI4NIDKKZ4BMljZOFqzAr3/QKikElMXrG41iVo?=
 =?us-ascii?Q?/9Wb3OxcIshS1JCcOxCAcjBdpo1e5rMIyS53sn2DgXYCGwRJDtsMxOdkU/uh?=
 =?us-ascii?Q?xQQ//rOZm51YvIA7kx8vPweVWn9WXieXVSyXjmveeSro4Y9NVW7WzO4N0kd0?=
 =?us-ascii?Q?F0nAUlVKAKiMbMj5VFL1KU6myFJ03oqqDeBVRgfXxNBmvG6+Qg/Xj1jmK+Q7?=
 =?us-ascii?Q?xZqeGn6E8SIF2h4QkFGwfdev9anq8dNMlc+6KsJtTyJJ/tyw4GajPESOCLMT?=
 =?us-ascii?Q?wKNI8sBACnYGA7ghjfPCTx/m3iysSnsWrml3NsdH46FC78vpA0+IU4/3HU7T?=
 =?us-ascii?Q?S1s9QvrzgxqMPMR5hVi/4D/SoRVMvT8xpEGA9fpX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7787f1d5-2442-43ec-45a8-08daed94ecf5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 14:15:11.3567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w0DtBmU858v1JS+Hw4Mi3PNA1Ebkq6vQllt8lm27yQg75IqC+uCqVmL4roSYxIG7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8015
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 03, 2023 at 02:11:19PM +0000, Bernard Metzler wrote:
> Oh ok, thanks. It is probably find_vma() further down the call
> which makes sure the address is valid for the user context. I
> tried reserving bogus user memory with siw and indeed get the
> right failure from trying to pin it.

Why isn't this using a normal umem which does all this for you?

Jason
