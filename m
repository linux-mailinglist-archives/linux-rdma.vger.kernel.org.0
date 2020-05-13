Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC641D0B0A
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 10:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732280AbgEMInb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 May 2020 04:43:31 -0400
Received: from mail-eopbgr70050.outbound.protection.outlook.com ([40.107.7.50]:27694
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732340AbgEMInb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 May 2020 04:43:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQr80RsJVYrbqs7Y15fmuYEHOawtJHMDe/ZnWoY7UDHGHcTy9eEG7OryBQcNL5kbNz48QrjTJds/ZiQPC8ciiP7U2mQcQtWSm0BCeQ+EvOThMjo4tX0Tevty6gX+Bynh6tLhn/mHzzJfxyPA+RTtDIPWq4s6jKsH0TzwnWADwHEgmauQ634w0VOb8PUys2NFNY5aHIlDh82L+kM5FxsYTIL+iBiw9noWKiwXRir8KTa/W98FApibGa1gTN8aWBQCaffmDd75xRkK7EYUy9rd39ML03q3EINo62lD59rL+GHn2Un2TE2Bhsg+lfMpERTfg9MNTie482pU+lp+RFArSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCJ3ryMEt3ESkG9x79ExNSOfoTXQWDfs3N3Bf2cfttQ=;
 b=L3PEJSRO+RJyhr0qOaI6f2oX3HODclXKSb2IFNmTtbp31bzHLMKSmTBeEprgICxEvSiJGy2Q3t9cKOk3dlbQCwzpsdmgCIvfkynqrKdl0CZSHpGuBxsQjHSUqEP2+HXUSq4NJ1mhp9fzVpRTg7s1koBjUoYugX9blqPuMIaUNLo4EAEo5vlILFjjBjzggv/nIOeonO8CYJ8/GvR524NcmNzvHZ3d629n4XMVgWHRK4cuWgZKFkSC1A5AjO6kb67w3cHo8KgeF7EQvfl1sl0dwl/SQfn+zZ/9Lh4+7hlPHL4/8uyuM87D2mGUewcnHrom7mdTmuhOqV6bghe4FtUtdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCJ3ryMEt3ESkG9x79ExNSOfoTXQWDfs3N3Bf2cfttQ=;
 b=rhQ9admCk0wLNQf5zZWpXKd3FoBpOJQGeeOmnWy21kGdDNGvNwl6tU/Izs9J7JluYZSaKEjVcyuBIy9wts8HlpMdcTjK8+AtvveyH1DJGHJNYx9pRirPjc/Lk0aoIz7yjSdz6U+oW935MQDlz72DX9hPHPKlQC9r3Ns/FHircys=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB5873.eurprd05.prod.outlook.com (2603:10a6:208:125::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Wed, 13 May
 2020 08:43:25 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.2979.033; Wed, 13 May 2020
 08:43:25 +0000
Subject: Re: [PATCH] IB/iser: Remove support for FMR memory registration
To:     Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Israel Rukshin <israelr@mellanox.com>
Cc:     sagi@grimberg.me, jgg@mellanox.com, linux-rdma@vger.kernel.org,
        dledford@redhat.com, sergeygo@mellanox.com
References: <1589299739-16570-1-git-send-email-israelr@mellanox.com>
 <20200512171633.GO4814@unreal> <5b8b0b51-83e3-06c2-9b99-dec0862c0e5b@acm.org>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <49391e02-803b-f705-b00e-e48efd278759@mellanox.com>
Date:   Wed, 13 May 2020 11:43:20 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <5b8b0b51-83e3-06c2-9b99-dec0862c0e5b@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR0902CA0005.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::15) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (89.139.203.251) by AM4PR0902CA0005.eurprd09.prod.outlook.com (2603:10a6:200:9b::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Wed, 13 May 2020 08:43:24 +0000
X-Originating-IP: [89.139.203.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 59051eea-932b-4b58-09b7-08d7f719b367
X-MS-TrafficTypeDiagnostic: AM0PR05MB5873:|AM0PR05MB5873:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB587326F79C1D26712A2D04E7B6BF0@AM0PR05MB5873.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0402872DA1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r21qy60NLYvi9hfMrvoeWG6nZrvjrjEHRnpu0SSIAeV1zoxBlKz5e1DBeirv6FMBUm6xiuT/Vud3NFXRETkBoYaKKw0RCGeC68c9jbKjDaKrMt7rB371quZJZccRxVhFDS0Fvn4MqW+bMk5luopUDig3HtWwyMjgjTBCcYg+YMSXKyqAWdlRgNJQSa3xDs1nEN8jkh5fluQbIYqWBw3x9u7DXdTbYUcE7EiB1ZI9G3qHl20t3UA3k7NXffFcv2u14sjiCdV03lNhfw7zp+QwlmB8Xi8HVBJTWWTQq6DSbwQibwbwXwDjU8JyEIJEhi9clvRt0BVouWKBMdcUZ5kNpgOeSbz5cB1bQbJfk+qoqLMzwMkCZoLINWPIxlHxCPpn7vLqyBMmkmgpkW2ACVl+ThbsjZDZHIA7IzBBgagMFyaWi9PyiLQGEqdOKZpJn/+/hjP92x9JBxEWomdJw6Xb6TyCffqQoys3cE07P91nik9e3S3zjaYzTK7yW/c0SiDmxBlIenWwTnOAjLz0i77tKX4b0k8TwFyOfx0B68bJrOEm0iQpbQMcZfCXeb7K6+wB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB5810.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(33430700001)(31686004)(2906002)(5660300002)(6636002)(66556008)(33440700001)(53546011)(26005)(186003)(52116002)(6486002)(36756003)(86362001)(8676002)(16526019)(8936002)(16576012)(31696002)(107886003)(66476007)(956004)(4326008)(66946007)(478600001)(316002)(2616005)(6666004)(110136005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Z7jCyBO3f+O9uxPUIjXt1zGHqREgKHyS4e2dWqrbRa8kYVA88R+CW7rOCrZlBngd1rP8qMA2DDojfb+LThrieZB4fc1OIPyTloHu4F1B4XMDxd2aI0p0WNZV7QSTbMaQ42YD31pKuQZOQRW5dySqXqh07IhgHpOs/a6zqc15eX3WVSWssRKqXTv+ZjsVuODTY6qlxkJroS/IL4D4m9rgqDjDK8Q0BEBISGLFc+h+iuwqfGOp7r+s9VXEN7kOBslyjV0k+bLSgLbFO07/yZLZbmG1Q398PYr6ZNbwSlAVsaF3kO8SEOgiPj+cBvCuPoF2/QtMV+4QOGH/5GWejfw8hKYTKOyPeXveUxWIoTPljr7VMHUV9iFltZbhYQrncyAV24t0kn/K5d10+frJW0A1SYLox/O1jKN61X2KLbA8Kg3DtunqoDPkt02j5wr47a725aoycvYorvqQ3u2ua5jVGhuFlJY9Ibj62jXnXVnfLupIUudp2CO1ERU6z/NZhOnX
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59051eea-932b-4b58-09b7-08d7f719b367
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2020 08:43:25.6629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qNHbGWyfAOVCcw11G6aCm9ddXxNiUZn7tlisdjlCHZ5c7hUuJzUNbLXUJ/l0Xf80GaacwmjkeyE6ctZyTUfgyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5873
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/12/2020 11:09 PM, Bart Van Assche wrote:
> On 2020-05-12 10:16, Leon Romanovsky wrote:
>> On Tue, May 12, 2020 at 07:08:59PM +0300, Israel Rukshin wrote:
>>> FMR is not supported on most recent RDMA devices (that use fast memory
>>> registration mechanism). Also, FMR was recently removed from NFS/RDMA
>>> ULP.
>>>
>>> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
>>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
>>> ---
>>>   drivers/infiniband/ulp/iser/iscsi_iser.h     |  79 +----------
>>>   drivers/infiniband/ulp/iser/iser_initiator.c |  19 ++-
>>>   drivers/infiniband/ulp/iser/iser_memory.c    | 188 ++-------------------------
>>>   drivers/infiniband/ulp/iser/iser_verbs.c     | 126 +++---------------
>>>   4 files changed, 40 insertions(+), 372 deletions(-)
>> Can we do an extra step and remove FMR from srp too?
> Which HCA's will be affected by removing FMR support? Or in other words,
> when did (Mellanox) HCA's start supporting fast memory registration? I'm
> asking this because there is a tradition in the Linux kernel not to
> remove support for old hardware unless it is pretty sure that nobody is
> using that hardware anymore.

ConnectX-3 and above supports fast memory registrations.


>
> Thanks,
>
> Bart.
