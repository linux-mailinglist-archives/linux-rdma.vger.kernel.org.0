Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2332A5FD9BF
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Oct 2022 15:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiJMNAT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Oct 2022 09:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiJMNAM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Oct 2022 09:00:12 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2128.outbound.protection.outlook.com [40.107.243.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3BF558C3
        for <linux-rdma@vger.kernel.org>; Thu, 13 Oct 2022 06:00:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joPGR7YVM/5CZqXEn7VP3DlhSBLjBe0SHMRBEbaGCKa4Bun76ONKVUejS4ZL2mlWPpMH+EKCd4o9usyR3LBEbfMIGrx5Lg4wY9xKubR01/d1uqJcWnBXZdkoD/4hjA5GMyaK9L6b1z1WkiA0ICzs90PAzWbBD7hNFZ4gzDuLIlvlLcIwRsNr5TifQlG5ezoe8MwiEzxlgZb1yU9w8ydPpC2dSzevRfPSIRPm3kk1w40cpdtoU1jKdp+PC0XMjbSL2oYMIp7JpJYWvOkjHWN3EYhAgkbm4BYytlCi/ZisX1eneJamiAE28ktXag2LBlJtRQZGORAErDcntz2qBDmNSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MsKxZKfKgwuU5q7ssXG/nWLtkwlzRBO+k7H1GNEYptM=;
 b=EnKcJArlg27H0sZeAj2UBg/jRc/DisztIeDXzfQ7Og79hfseP/XZHJiIF6+lGXLY4tXcqmsQRXnLZujoYiBVEZyQriu6/WdKbFqEY6X8NFlGletJFKTMbby8QHZDVwtO81Iuswrs7udvwLUmPhVi8TXXt0PgOc0/Ckv2ZJ9XLvW6JkLcADHT2nj+91wH+cZIWTbcDVEQ7xbwYoY9btnTAYY7cYSHg5tC7oNUpiVTiaY75tl8FDhxehkF1IsTDpjeYCyCR0pGMHTy7iJdxmuDPw4q1/d9hA37zAb1IzrkUEMpuFk6oJ+393nd/LZORMyfvAtYNKCy4XZGnIlPKB5NUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsKxZKfKgwuU5q7ssXG/nWLtkwlzRBO+k7H1GNEYptM=;
 b=JhsvJoHn5ZArcOaKl8MB7upZgKWjojuiaIX7drKx5Kh3pdC9d/UOyO8fAQl6S6VIB7vCX0HLnnGO1F9OUGN+CqZ93SIWvCXCbaCWtV9pRhvoxqXYJ/zduCuOkvm6e7jZ4ZKOOCqTAEw5PPi9J6jzz7Wq4CrrW7qVy9inbgW2duJhaTMsgBfZj/N/Fr9eo577RM+i59GY0HeUTavrSaYmEh+fI2CVR3f0bgHza4seJ4JFCNbzdbnuavSYIYX7qwDSJ6j4YDPJ03xxMBxVllm+rmLSzCcRNu2N53PmoQPOgRgPsi59lYo2D6OAdAiiyLBU2ck/84bOJlr+mvxIZcPs5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
Received: from BYAPR01MB4134.prod.exchangelabs.com (2603:10b6:a03:58::19) by
 CO6PR01MB7435.prod.exchangelabs.com (2603:10b6:303:136::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.15; Thu, 13 Oct 2022 13:00:04 +0000
Received: from BYAPR01MB4134.prod.exchangelabs.com
 ([fe80::409c:181:f6f1:24d5]) by BYAPR01MB4134.prod.exchangelabs.com
 ([fe80::409c:181:f6f1:24d5%4]) with mapi id 15.20.5676.031; Thu, 13 Oct 2022
 13:00:03 +0000
Message-ID: <c56dbce1-7d63-df20-fd2c-577ca103d8de@cornelisnetworks.com>
Date:   Thu, 13 Oct 2022 07:59:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
To:     Jason Gunthorpe <jgg@nvidia.com>
Content-Language: en-US
Cc:     linux-rdma@vger.kernel.org
From:   Dean Luick <dean.luick@cornelisnetworks.com>
Subject: FIXME in hfi1/user_exp_rcv.c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL0PR02CA0137.namprd02.prod.outlook.com
 (2603:10b6:208:35::42) To BYAPR01MB4134.prod.exchangelabs.com
 (2603:10b6:a03:58::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR01MB4134:EE_|CO6PR01MB7435:EE_
X-MS-Office365-Filtering-Correlation-Id: a41e3c8e-e9fe-4e7d-2ad9-08daad1ad84f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dp1pUx/o2zcufd5wk9uM5WvZzArLAo1gFbJvUnGRncL5XGcGJwV1XxWIPntXWhT6gAUc91VGTcmNKrKWGy+Au6vsOVSClN2cYuF/zuX6WUrSkvhWv7vsP0CinkyPJGBkXI7VT4Ynqip9khuuA3ADIZTcRkkJduFNZqXke3GYX1DAQwrzygYpJ8KcTVW8Q/9vGvcoGL2Oxto36ZgeX5yXi4ygq5I2sNokKu2sXjDrVfMnyJVNl+MPY3n/PDwnyA8xuuXQdwShk7FrECs/lpKXm9tGaHBGubmQQLc5U4MGgcQatRzzz7ecERiXSJQPJBo9DCTBq5gl/JZhhh+KKV4rzDV7w1m/Kb019jKlH74YOGbB1B8tHQn5zOC+40VVcaPAKeGaBUHcwsfy7D5bFc72nTgdAdOC+mWPWCUUCdUJhoo32i2gy34NhgixbXR+htChogFva2IOV2C3V6G8iNDguZsQdbhpdGr56/xq9Oz4Omg/WnOvrE5TziG/Z0+r5LWN1h6Vs3nkyiNW8x4YiwJq3Vavm2/CI0QZbnScpByhpmwRQn+STDfNlCT0xMzq2jvCMfbwHbLkuUkusHRKaZ46xYAHjXwpfUCisbBYa5PX5hcMsY5q3pW1+yyiMfjHXXW3Tf6eAudc5gVnNW/QYkFT24K8ZogRGtoFc9++nCAEVg4qDeUxtBe8+Ck50lTNUy+j1tigwbeipzFoPHk7BjeZPT8cOOe0yZChxQZ3d6kxwZQWZuVomasRZsetJXknuUuUbmGNb6ZRvaiQeIOSNgSW8FbfsGj9sFxRheOl03mmXUw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB4134.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39840400004)(396003)(346002)(376002)(136003)(451199015)(44832011)(966005)(6486002)(558084003)(478600001)(6666004)(316002)(4326008)(6916009)(36756003)(6506007)(66476007)(66946007)(8676002)(38100700002)(2616005)(186003)(6512007)(26005)(86362001)(31696002)(8936002)(31686004)(66556008)(5660300002)(2906002)(41300700001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWUycGNUV0MzTm8ycm9ndmwxczhBOUlZdVMvQUNpTW1XR0Y3bFpieDJYaFQv?=
 =?utf-8?B?ZnFWUTVqSFBraWc1SmpLR1VTYmNHK0FMRnkrMlMwb0hTMUVwa3NpWElDbCtV?=
 =?utf-8?B?L1pqSWhvUWVDcWJRa3RZbndGZ3ZRdFNjbUYzeUVWdmlYWHgzTVpVdkRWVzFj?=
 =?utf-8?B?dlVKbjdmclhzMG4yeWRwU3hqZGx0T1cyTEsycFdYUmhnM2pEaXpPazFYWnpw?=
 =?utf-8?B?SlhFV3dZejZMZ1UvSWxFYU9hUjI3RVhsSkxKWm9tUW1sMXZnZUJKaVVBcXhR?=
 =?utf-8?B?Unl6MnByTDdPSlVJY29ralR2alZPRGcrYjVUWGdEWk96N3UyTUhGSmJCa2ky?=
 =?utf-8?B?a1YwdkxWbmk0eGI1c3YrOUx4WVo4NXZiYSsxaU1NYTVhd1NmMm1sekdFNllD?=
 =?utf-8?B?ejI1YWJ5L2ZjU2ZpYlFJWlV4enhtVHNaclE3RU51bmg0azM0RDgyN0NBaGVU?=
 =?utf-8?B?ZUQyVEJkSEdyc2ZsNWdXM3pTMkpzY2UveGZwcmt6Y2UyUllGODZsQXlCazhO?=
 =?utf-8?B?Z1FVWkQzT2piU0pTemtaVHAwV0pMNG45Sm1ENmtYOGNQNzdsOC8rNi8vRTFG?=
 =?utf-8?B?VEVJaGY1UnV4QnZjOWJEQXpiT2hGeEhSNlFrVjNRSk9NeVFVN25WNVY4R2NS?=
 =?utf-8?B?V2JJYjRJak9ibFZNdjh3dHo2b2ljZEIwLzYyS09GOHQwTm5Kd2ZGRHhzaUp5?=
 =?utf-8?B?QjRmV1ZydDdSZWtnSjVkU0lNcUlXMk1vMFZOcjhIZUcrS1FvdWVCTTNKYnNJ?=
 =?utf-8?B?MUk4eU9zUEdKaDBmWlkzVi9sNi9PdWpuUkFmK054YkVLcG11WWZibGIwbnB6?=
 =?utf-8?B?NmdjSWkwSmsrL2dIaTRoWGllTXM5bkN4WWtxZEJ3MkdqaDJZa3Z0L0FsM1Y3?=
 =?utf-8?B?Rk0rMnh2ZzZSMmFHQ09UNS9rQkV0MVZFRHd6YmhCOUdDOWlDS3pFa0ZxVHB6?=
 =?utf-8?B?cVV4ZFNiVHhlbFJRTTd6V21Ecm52SUpHeDhZLzY2WUNkcHpYdFI0NG1JclVR?=
 =?utf-8?B?RnBHKysrWlVLdDZDaG1ldlV0SCtObjdxSHk2eU1pQ2xTZWNkWXpIenp0UnB0?=
 =?utf-8?B?WkhTVWpUdFFuV3ltRWNxdE0yZ0ZoVkdiUnA2Ym9abUlva1pnVDBFTXFCV2dy?=
 =?utf-8?B?Sm5UQkxST2ZxZHJsb083MG15d1RZZTdSaEFzRTVXRWlTZ1VyamZodlZzaXlU?=
 =?utf-8?B?NzVsNUhDUlRpVXVaaFZaWi9lTVk4K3RxYUVoVFVyZ1BqZ3Nxb0JzK3M2bEc0?=
 =?utf-8?B?eTM3ZEkzRGtzRDF0MmNZQWl1T2NjeXQyVmV3azQvSEVqYm5EYlZMeFB5T0tC?=
 =?utf-8?B?cmNlTWRCZWl1ZHFqaVNXOVFqU1prMmFNYis4eHd1dGVkbnBxTnBHdC9zV1l4?=
 =?utf-8?B?RDh2alRtYTgwZXF0TFhQQXFDaDFZV1FDbHNkZnRyOEhUdXZhSC9KV1RxV283?=
 =?utf-8?B?VHZZYkhvRDNSKzNDcjd6NU9uTEViQXlDbVFPMzlDSDE1dXVBKzhOTFQ3Y1ha?=
 =?utf-8?B?Nm42a2YwMmhHUEkxZGo3OWtyZkc5a21aNGxxbzhZMHg4MjNmL2N5UGd6dmZB?=
 =?utf-8?B?cnlQeDdzd2hVWmNWVjBIVjRBK2h2Lzg3REJHQWZoS0Ewd0prNHFTL0NKWXhW?=
 =?utf-8?B?VHpWZmdqMjA4SE1XeTRoNHN2L2V4Q2hjZ0sxK041QlJ0ZHFtTmJTajlTaG9k?=
 =?utf-8?B?T3N6TlpxSWtJdURzVHc4MklXOUMzTldPbjN3UUpsOXNGYW5NQVZaYWV1dmps?=
 =?utf-8?B?cjVUbUdwVjI0ZnVPb1BrMjFnOXR4ZU56cUdCQkdGbXBsQm9nTUUrUkhlQ0p1?=
 =?utf-8?B?aUQ4VHNTZGpzUWxISzJrbEx3ZFRvdmV5YWtIUXRWNFdCSm12Z1RDZ0M4MjN0?=
 =?utf-8?B?QzVVSG9uUTN0bnNxZVpKTGs5WkovaEJxWTMzakU3dXJUYkFBbTRpbWV4SENE?=
 =?utf-8?B?b3gvS096UjZZU3NwbTRlSFlCWlNxbUhSU2ordmlYSk9mQjhmaFIvdEtCRDYv?=
 =?utf-8?B?V0RNTklBUDJmOGYvZ2JYc1VJazVUWXltV2pMeFJwUSthVTM3RUVQczBxOWNC?=
 =?utf-8?B?dUw2b1M5b2VOMmIvREFRa0ZkK1pxN21IeDU1b3RHeE5GbzhvaHJTUGw0UDBv?=
 =?utf-8?B?c2RKa0dBWFBQYitHQkpZYnE0RnZCc21nei9BUFdGZlduQjVEdG9jM3dNaEtH?=
 =?utf-8?B?Y0E9PQ==?=
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a41e3c8e-e9fe-4e7d-2ad9-08daad1ad84f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB4134.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 13:00:03.9293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMhoAwlWuzgz7DRdCbIGQygTEvpXHGP+AfB/B6dsJYsJiRzg+dwprTGbtYFbYD4nypD1hMZLHkh4af28cvMDJGccLX7d2eAJM+yQZF4fa34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR01MB7435
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,

I am looking at the FIXME you left in hfi1/user_exp_rcv.c with git commit 3=
889551db212

Link: https://lore.kernel.org/r/20191112202231.3856-7-jgg@ziepe.ca

Can you please explain in more detail what made you add the FIXME and what =
may be "racy"?

-Dean
External recipient
