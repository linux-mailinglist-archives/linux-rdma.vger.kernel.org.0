Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3AC4188E74
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2020 20:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgCQT6N (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Mar 2020 15:58:13 -0400
Received: from mail-eopbgr50069.outbound.protection.outlook.com ([40.107.5.69]:1445
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726564AbgCQT6N (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 17 Mar 2020 15:58:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivam8etSkT9+Xcdv7WWaWxtQhh9ebVgXE6Zdl/avFk2f6FFb7q4KboMpfZKeWWdwdfAFAY0UafH3Pm7SjRRV5bI7YhuP0/OjPTp4JZ2vNSkvwlATCg+1FutVwkWrBLpkdVkWVjwWT936thrreAiFEytwdINxf+B6yKJVhAoqLDo9bZIp0CxajBC3whyoKbtr2rrdxuFSPzwPGkfZPDTw7AxhP8KO1/rGYUKpoF+zFLH7zoG8iIWRn2PEGjqx3hBnqFokmnE6HYHwajIdpkXEwVVgG00Y19FD6+HDjfwH1BCXEIuEM6YgebhX+cUqSbcIpNAiwteS+0eSI+3NlBMpFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00/aM5ridAzKm+tKKSK7ilacwqGT+rKAUHRrOK8vl1s=;
 b=lnVBnH25hrpIwE2V8kacubgScRtAhNj79a4IddBW1A8jlbCq6pktEj5rDp73SQ/7GKfXqxmDLaj446KtglmdxASKPC1YTVcWraRZ1UpbB7kta6HJYG/ZlCPDOhxfl/pwxNRAQnXnhCdL8nmJO/zZjGvJwjifms6bF8Y417qqrOoHxBjS00JWfuCoZBJ79e/nBqGzfLoCNna1NGsGkl28TTOEcJFB/o/UHIZQKyoMQtJGSO3UoA2xHQ3CkTFycC7+lfDev0tcMCz7TTtiVMHcrOVkjhKD7Wmu0SK2lw28kmAQ8sCu1mhUNHNCncX3MxFyEGMK5SZediegD/yryyOMjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00/aM5ridAzKm+tKKSK7ilacwqGT+rKAUHRrOK8vl1s=;
 b=Xp26xBcB2q9ucecKpwVbgL0PlmnzZjgoMhRiZgwdJHIj/5bjwcjScap1SWmwCgB5jXlIL7vbsFxSRahR2AVS4sR21lYFdVQQGembkrPxe9akQyfafyiN/JN9xLYADX9YyaSnosOSbmubvo9mS2JdVnUhobgp6iAbE5+RLaPxHN8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (20.179.5.215) by
 AM6PR05MB6565.eurprd05.prod.outlook.com (20.179.4.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.19; Tue, 17 Mar 2020 19:58:10 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::c99f:9130:561f:dea0]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::c99f:9130:561f:dea0%3]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 19:58:10 +0000
Date:   Tue, 17 Mar 2020 21:58:08 +0200
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        loberman@redhat.com, bvanassche@acm.org,
        linux-rdma@vger.kernel.org, kbusch@kernel.org, jgg@mellanox.com,
        dledford@redhat.com, idanb@mellanox.com, shlomin@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com
Subject: Re: [PATCH 5/5] RDMA/srpt: use SRQ per completion vector
Message-ID: <20200317195808.GM3351@unreal>
References: <20200317134030.152833-1-maxg@mellanox.com>
 <20200317134030.152833-6-maxg@mellanox.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317134030.152833-6-maxg@mellanox.com>
X-ClientProxiedBy: AM4PR07CA0036.eurprd07.prod.outlook.com
 (2603:10a6:205:1::49) To AM6PR05MB6408.eurprd05.prod.outlook.com
 (2603:10a6:20b:b8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2a00:a040:183:2d::393) by AM4PR07CA0036.eurprd07.prod.outlook.com (2603:10a6:205:1::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.12 via Frontend Transport; Tue, 17 Mar 2020 19:58:09 +0000
X-Originating-IP: [2a00:a040:183:2d::393]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 91e5689e-799b-41e5-d0d8-08d7caad84b2
X-MS-TrafficTypeDiagnostic: AM6PR05MB6565:|AM6PR05MB6565:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR05MB6565B05A50B93999AF2F0E96B0F60@AM6PR05MB6565.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(136003)(376002)(366004)(346002)(396003)(39860400002)(199004)(52116002)(33656002)(1076003)(478600001)(316002)(4326008)(6862004)(107886003)(8676002)(81166006)(9686003)(6486002)(81156014)(6636002)(6496006)(8936002)(16526019)(33716001)(186003)(5660300002)(86362001)(66556008)(66946007)(66476007)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6565;H:AM6PR05MB6408.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T9iPFjU8FlUi0G4RtCEkb2CCrHYSrpvyxs0omnxcXMfDv/M+8CCml9Dw4i7xJLwdG2y+nXEUp85nGCBUDMv4xgRWGGp/Cb6ksexIs37sVZ8txIVVt6suOHdySCcfhAgzpN1DddwDRK/NPSMo275i0ENB3d3A8BIPOjRZfJaRUKMEPAHNXeYoaCET0Q4p+AEZ68fth7kJ4Zx58W/A3fP5NPbiNrMtvQmdTgy0wDhPefQyfNj+oEI5p+yOG0GNE4KIyevoqmm9VdNsbq253COHxGfSz4iOJUecZBMuWWZChfeDyiD9NtjdAlIN+p8HogUqn0c0OImgsoXtH06fY31gOIuf3+umR+bUGJa4CK0P3mVishrQP/uVoP8isilTH0DFOEEbs2bvW5HgBSIu/tPVYiidCxfFI2l7s/KAGCnfj6oIv2asMhgoXM42wfwqcQZ9
X-MS-Exchange-AntiSpam-MessageData: TN6rx+Y6HxhOwBFZN2q7BR9A7LxyFjuW99JHbbbqPZNBj9jtxH0lpeYwYhGLeiQJBLBOFn5T+o1ukyVW55ba83HfRIveYu+Nutoql+xA1WYzgGHnNAFGE0TFAVLjmB9TKYVMGuPsryzhzgK4IA5mN5GYFtl8wffIvf7iHzk97WA=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e5689e-799b-41e5-d0d8-08d7caad84b2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 19:58:10.3397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sf4PJfHZ0TS+ATfeTfh9rf4z+WvH8ARjkvTT47YNyqNwUMLIYX43QeVuTHMeWeoySIR5aQ4K9Sdvt0GqjXmsrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6565
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 17, 2020 at 03:40:30PM +0200, Max Gurtovoy wrote:
> In order to save resource allocation and utilize the completion
> locality in a better way (compared to SRQ per device that exist
> today), allocate Shared Receive Queues (SRQs) per completion vector.
> Associate each created channel with an appropriate SRQ according to the
> completion vector index. This association will reduce the lock
> contention in the fast path (compared to SRQ per device solution) and
> increase the locality in memory buffers.
>
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> ---
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 169 +++++++++++++++++++++++++---------
>  drivers/infiniband/ulp/srpt/ib_srpt.h |  26 +++++-
>  2 files changed, 148 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> index 9855274..34869b7 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -811,6 +811,31 @@ static bool srpt_test_and_set_cmd_state(struct srpt_send_ioctx *ioctx,
>  }
>
>  /**
> + * srpt_srq_post_recv - post an initial IB receive request for SRQ
> + * @srq: SRPT SRQ context.
> + * @ioctx: Receive I/O context pointer.
> + */
> +static int srpt_srq_post_recv(struct srpt_srq *srq, struct srpt_recv_ioctx *ioctx)
> +{
> +	struct srpt_device *sdev = srq->sdev;
> +	struct ib_sge list;
> +	struct ib_recv_wr wr;
> +
> +	BUG_ON(!srq);

And of course no BUG_ONs in the code.

Thanks
