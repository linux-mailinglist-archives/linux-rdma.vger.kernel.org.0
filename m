Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF3D1CFCAB
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2020 19:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbgELRxx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 13:53:53 -0400
Received: from mail-eopbgr20076.outbound.protection.outlook.com ([40.107.2.76]:29447
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725554AbgELRxx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 May 2020 13:53:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRsW9d11u6t+qC5LVF/cJ1pbm3dbebtqq2B0az31B9orL2dBSm+wEbP8kxUxA14E9R89KC9cyYUSrx4UECmVC4xsvJsSIfiLubVIKWoHSyiww/wT5Pil18EUcvlZYyVMmuIis2hlpRlO2BbJ9xWD40FqABjwDq+btEYg00kjWSKtF//5hn3FY7KrWQgHI88Z8xhPT+6Own7RM+kIZs8noVTCrpqoYoIOwggirgp+8JtK+XKbXbalqCvQqNIY9b516V3/xdhnYKzE+juUkMh+Xio5QUuQk/DF+tZ4TM/1G4oNoONG0KyXe506BwzujWNgQktPVk0EuiapQQWUiu7ecA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkZQvSZWYGObGLfqoeITC2fyvnco5en2FEehc4BCm7I=;
 b=DfXyhCF5pDwFSVIrgfZzA1tufE/2Zajx96dkCKWVS5ByCA4+l3SSkyrhOAS2Tka5jMA7Eej/sUOBOaeBiOJF5i3oSQWGdYu8pqiV0t4IAaFZtRT3MF+en3mOIy+LSdyEdL2UDka7iFd++3URzDvAek1aRrM6RHSXpIxR9ijaKxH7kwDjLwsGJVRq2g/qVQyX0uQva/tR1LN1SnA1WmJjsOvKCNEZuysXNsJoG6noG83gLzGJsZbl5I4HJWkC+R5fvu131ZX2sIYSnG/n7K5rzamVeO/odC49qVd96cZTQqhDfTZj3w2z5HunRYxxSe9t07O9kBhmWWxf+E0LtzizDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkZQvSZWYGObGLfqoeITC2fyvnco5en2FEehc4BCm7I=;
 b=Sdgavk2uhagFOKpj/WgXJQyy10UXAOnsFgK35ZO+OkDT4EToe/WP2DiZQUHpNEhTeEpthYY8IXXizN0qtyRJd9v+3h4tPLAlCUWomLygfsEY/5gXqXISHOLdXlcQ+w3dJbm3wQNlR1Qpou9Zdz9jwry5RRkBDwb8O/LsYrEfMBo=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB4980.eurprd05.prod.outlook.com (2603:10a6:208:c3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Tue, 12 May
 2020 17:53:49 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 17:53:49 +0000
Subject: Re: [PATCH] IB/iser: Remove support for FMR memory registration
To:     Leon Romanovsky <leon@kernel.org>,
        Israel Rukshin <israelr@mellanox.com>
Cc:     sagi@grimberg.me, jgg@mellanox.com, linux-rdma@vger.kernel.org,
        dledford@redhat.com, sergeygo@mellanox.com
References: <1589299739-16570-1-git-send-email-israelr@mellanox.com>
 <20200512171633.GO4814@unreal>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <bb7b6671-7733-b443-11df-f17bac908eba@mellanox.com>
Date:   Tue, 12 May 2020 20:53:45 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200512171633.GO4814@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM3PR05CA0094.eurprd05.prod.outlook.com
 (2603:10a6:207:1::20) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (89.139.203.251) by AM3PR05CA0094.eurprd05.prod.outlook.com (2603:10a6:207:1::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend Transport; Tue, 12 May 2020 17:53:48 +0000
X-Originating-IP: [89.139.203.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 606a1f89-a681-4c71-c2f9-08d7f69d6caf
X-MS-TrafficTypeDiagnostic: AM0PR05MB4980:|AM0PR05MB4980:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB4980ACB3CBBCFECD0127628FB6BE0@AM0PR05MB4980.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PESFapY2Ne/boncQrB4I18C3Rw4Rs3h3oi5gMzfHE2pVSN7roYNSQn1N1PYcddfwwvwAgFGNml2Q1XxRmosvg7dyRD/fYqc3TtsghoYWzxkutMI0llBdj2k0Fn3yd8DJ4sIcgfxTatgYhJ8NYrcH54aDraXiWwE6T6abL6oyqmmIXxy4l9a8OEwEZW9W82PbxdOkvHQnA/S4PnY/BZF/zKsoX9n9ZelKbkDWmGUe428/7M99EUjnrNR/6LTvCD5WcnHwcoE+MEzsHES2xEA3bQDxJb70oIwvxNkadkn8PED8ktQI2yRTLoY522H/Xv+WNI17tQhO/cD6Jb9y/iwOdSEWlqNgMPXv1k8i26cHmhCvUDDz8D2mRaF9gFrKTxQ/Drzj6QVouLrVaay1kzV8RHhMqh5a9kSvdld9ljHnSOHdbMqXtPBvZXnuBmxBetzzvePO2lw6bXCHGsNjcfSy/rppEf++EFQYuBePoyxKDWfQP2SFsHZ9lXDaNOPHiQfsg5PPEX2qWeRaEAlCA33d+AIR8Q+F344KhEtvRWLWrYEhcx0txSwVi/veJ8//AeJC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB5810.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(39850400004)(376002)(346002)(396003)(33430700001)(2906002)(2616005)(33440700001)(53546011)(66946007)(8676002)(86362001)(31696002)(16526019)(66476007)(5660300002)(66556008)(107886003)(36756003)(8936002)(52116002)(6666004)(4744005)(16576012)(6486002)(31686004)(956004)(4326008)(478600001)(316002)(26005)(186003)(6636002)(110136005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: o82zQzIhwyDDaEk+wB6Ehk6fd4/l1N8YvOCLRMej1PqfD0TKrrOGtnhDle0O8/dfbHkdU4YIl047N1ltrf/mGfSLA5myM5ACmghFNMf7LQofdfGSO//kzuOXLNVywnR2GCY0NaQp8IU3hhB6RcL9fmbu3yf8nxRAdABv1jfjnTfsiaUeKWNbbA3LwHKB/KvZ6TpsRUDMAJZ+rseprLY7CQhgw9UurzqngypI8zLkAkVK6pNAcIDCGYkZAvFotDNzJfOsU6Zo57ApO5E2Yk7e5e61wCUkC8XBKYk3EZ1bXIhgpKTYDDxOUBRHG1CRJgH7ubocoj5p9zmHN/hkpS7hBqINNNsRRUoU2RSfn4/qbDhXgErjyO3naEGA5GurvxQy1/KlnHwHJdAnKUoOKfM8iLUicIsOtGFPoCaxw7djzTsbXxS0FtPn+00a/CtTet/PSAYJjXd19HTBlHo1bkvv2u5e5u8OTPee9BXeRLJZOL2Dq3fTz5hjoNzywE1lCSUZ
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 606a1f89-a681-4c71-c2f9-08d7f69d6caf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 17:53:49.1310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qp/+WouQh5H0wjp4A3hExYItHcOIx3JIyMzTqdF8q2nNfGVG+fYPjDeclkm16WsB3YAsQ/P9ADVBL9hTuEi16Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4980
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/12/2020 8:16 PM, Leon Romanovsky wrote:
> On Tue, May 12, 2020 at 07:08:59PM +0300, Israel Rukshin wrote:
>> FMR is not supported on most recent RDMA devices (that use fast memory
>> registration mechanism). Also, FMR was recently removed from NFS/RDMA
>> ULP.
>>
>> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
>> ---
>>   drivers/infiniband/ulp/iser/iscsi_iser.h     |  79 +----------
>>   drivers/infiniband/ulp/iser/iser_initiator.c |  19 ++-
>>   drivers/infiniband/ulp/iser/iser_memory.c    | 188 ++-------------------------
>>   drivers/infiniband/ulp/iser/iser_verbs.c     | 126 +++---------------
>>   4 files changed, 40 insertions(+), 372 deletions(-)
> Can we do an extra step and remove FMR from srp too?

Yes, I'll send it separately.

>
> Thanks
