Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C242318D38C
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2020 17:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbgCTQFz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Mar 2020 12:05:55 -0400
Received: from mail-eopbgr80054.outbound.protection.outlook.com ([40.107.8.54]:38883
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727377AbgCTQFz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 20 Mar 2020 12:05:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6VmXdCyP9KnwsVEOVhAyE6fz8A26b6F7pSlungPHKUe9SJi2CjxCU7jGSsYNzkxg8WzWv+I3f5raY3JNEFgdJwTqq6N2o6UNKxN3I6rYEy2sbJrE6xEvNIEOrnJ12UDS8RTYe/By6Cioo/QNf1+7Nop23ghBUkT34sBq1+GyQkXUo6097Cr4SNqNUQPYIkcv8WLa42gxjE/8XApjQI4pkejqUIAtJzhO863XtpnYALttYOgQWJz/MWH/urLP6z9Wcb6P0cTrdxRlWp7tq1l8dm0XK04/fF0FsjYhDpwRzO6DfmQb45ux1i0qCUk+CP30LWKmfLGJYNkXw4l8z7C7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sItVpgYryw3csx0Iw0AJqDuIKtA8gRT9wzsGfwybFoM=;
 b=aQZb4ghiWOubIZp2vmgL8uiq3IQ7z2Ch7DigzzxZqAiIEmvGp28zE2SixsFp7OgLg8HPb/LsQkPSM4Lswylyj1ruFbLqDeqJAMfyrCP2+IXAJvwmVgxrSaC62Z4JjpfYygNScUXEdZn1D6imINbm7x/O5MgLcNtEZkEhtIz65/hzmGCYjOso09PaQ8w5mO5jDXzcSAIMYJ6eqrixt3vtxNa8x9X0WaD0xe9uiBiG6Ov3gKG7hqQLn4gDwEM3WTzQSR4KtoR8gN2iXgkU1uTulfKyeEgN1A0HfwM7KIL7rG8LzB5AsJjldaJG9QPe5nM7BhDJurGX9TphmJgGWgvuGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sItVpgYryw3csx0Iw0AJqDuIKtA8gRT9wzsGfwybFoM=;
 b=A5Aihm+XnIBMarD9JF0rm556f4NWFbJbFG2J2qXsPPhGtTZ9vx1kI1h2uM98kHSg/hZztjmhJV3p+HWQX12OzK3QJbRACQBVtiQ+jSkjKTMujWkoVtjuV431AUytGUJoF7GbLKhkt1kxhpMXRZj81Erz/LLHJMERGcr6DQgtqSY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=markb@mellanox.com; 
Received: from VI1PR05MB3342.eurprd05.prod.outlook.com (10.170.238.143) by
 VI1PR05MB3264.eurprd05.prod.outlook.com (10.170.236.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Fri, 20 Mar 2020 16:05:51 +0000
Received: from VI1PR05MB3342.eurprd05.prod.outlook.com
 ([fe80::4566:b84d:efdb:cb1a]) by VI1PR05MB3342.eurprd05.prod.outlook.com
 ([fe80::4566:b84d:efdb:cb1a%6]) with mapi id 15.20.2835.017; Fri, 20 Mar 2020
 16:05:51 +0000
Subject: Re: Should I expect lower bandwidth when using IBV_QPT_RAW_PACKET and
 steering rule?
To:     Dimitris Dimitropoulos <d.dimitropoulos@imatrex.com>
Cc:     Terry Toole <toole@photodiagnostic.com>, linux-rdma@vger.kernel.org
References: <CADw-U9C9vh5rU1o4uSmw=EzMqOvXFqSm-ff-7UbLCKd2CUxT4A@mail.gmail.com>
 <e73505bf-d556-ae4a-adfb-6c7e3efb2c32@mellanox.com>
 <CAOc41xGXtcviBp4sWd5X_0_5H627tL2Ji857NtJ9P9UZxJL+uA@mail.gmail.com>
From:   Mark Bloch <markb@mellanox.com>
Message-ID: <8c2c8049-af47-e8b0-3b63-c179f16908ed@mellanox.com>
Date:   Fri, 20 Mar 2020 09:05:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <CAOc41xGXtcviBp4sWd5X_0_5H627tL2Ji857NtJ9P9UZxJL+uA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR17CA0081.namprd17.prod.outlook.com
 (2603:10b6:300:c2::19) To VI1PR05MB3342.eurprd05.prod.outlook.com
 (2603:10a6:802:1d::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.33] (104.156.100.52) by MWHPR17CA0081.namprd17.prod.outlook.com (2603:10b6:300:c2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend Transport; Fri, 20 Mar 2020 16:05:50 +0000
X-Originating-IP: [104.156.100.52]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ba82d412-25b6-43e1-6070-08d7cce88fc2
X-MS-TrafficTypeDiagnostic: VI1PR05MB3264:
X-Microsoft-Antispam-PRVS: <VI1PR05MB32645FC7853EEAF34EF2D4D6D2F50@VI1PR05MB3264.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03484C0ABF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(199004)(4326008)(36756003)(2616005)(186003)(966005)(2906002)(6666004)(26005)(478600001)(5660300002)(16526019)(81156014)(31686004)(6916009)(6486002)(956004)(53546011)(52116002)(66556008)(66946007)(316002)(66476007)(31696002)(86362001)(8936002)(16576012)(81166006)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3264;H:VI1PR05MB3342.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nGeguuNjnHNg1L1Y2RnxSplPeICiu3WSU8auj6HQGctvQWUe346owcW7WWfQbEMfjEifdxu3vJQ6Dw5+VOgCNsXQWk6l+x3R8Go+Yw9HaNiq0Z0w/LrDLV+queTqGgKXBouc3vF58e4svE6hSAzkVXvLmMVrjWhCFPgoELbjP2FodswsJ/E18N36B+TI8rxR/WmX1K8C+Y7VkyYAl1cbI8ODWN16eQE8/HZP2PWPDISj97wEXY++UkugzQpbH7quConf04ffaLPw6ItxVnAFOVxgHMhtdJM90Id2uPmT2YGPMwzoqAvBCAlHexqraBx4jHPAd6dxCH+FX1pUvPhJJrBZa4llLjXh8rxOTeB8tpD4H16GhUhgC4stt1RRuoH/fS9ywK26Iyom6moXuELm2B9CdYkH67V+cCC7Ha3qMOuSJBo/lyF9k1zP7aeMMMVFw2vpWiuvQy+5FxmEbOAeHlclMsFNxBijBF7hXNotEz5QS7SqW0a7weg0+6/O+WlGjwnEJRObobXKgB0/8F9rkg==
X-MS-Exchange-AntiSpam-MessageData: t03b2zDgdpaSTTHKIfYwiAjV3gDKNeGiBBqfz2eoQUOF7FoLQ+iNY086GCH4ftfWodHm/UtIgfyjznW9Ppo5jKmTONoC7RMFu5ANsaQtGH9QrT/yExlR6Ihy1+u14gv28aKsfYbgAZjtiJcfhOHHFw==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba82d412-25b6-43e1-6070-08d7cce88fc2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2020 16:05:51.5412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2c7rXOv/1IliKRT/HsBV3SF8qiuNMp2vKz9Um5vjc+Z+07ToTFFpT/KHw4uax7WNbJeIRl77nbrKL6iqBoXUcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3264
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hey Dimitris,

On 3/20/2020 08:40, Dimitris Dimitropoulos wrote:
> Hi Mark,
> 
> Just a clarification: when you say reach line rates speeds, you mean
> with no packet drops ?

Yep* you can have a look at the following PDF for some numbers:
https://fast.dpdk.org/doc/perf/DPDK_19_08_Mellanox_NIC_performance_report.pdf

*I just want to point out that in the real world (as opposed to the tests/applications used during the measurements
inside the PDF) usually there is a lot more processing inside the application itself which can
make it harder to handle large number of packets and still saturate the wire.
Once you take into account packet sizes, MTU, servers configuration/hardware etc it can get a bit tricky
but not impossible.

Just to add that currently we have support and ability to insert millions for flow steering rules with very
high update rate, but you have to use the DV APIs to achieve that:
https://github.com/linux-rdma/rdma-core/blob/master/providers/mlx5/man/mlx5dv_dr_flow.3.md

Mark

> 
> Thanks
> Dimitris
> 
> On Tue, Mar 17, 2020 at 4:40 PM Mark Bloch <markb@mellanox.com> wrote:
>> If you would like to have a look at a highly optimized datapath from userspace:
>> https://github.com/DPDK/dpdk/blob/master/drivers/net/mlx5/mlx5_rxtx.c
>>
>> With the right code you should have no issue reaching line rate speeds with raw_ethernet QPs
>>
>> Mark
