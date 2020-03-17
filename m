Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6AB18923E
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 00:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgCQXkP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Mar 2020 19:40:15 -0400
Received: from mail-eopbgr70050.outbound.protection.outlook.com ([40.107.7.50]:14535
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726564AbgCQXkP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 17 Mar 2020 19:40:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fxh+3hulAjFY/T3DMQnZZKxZlYo77sN14b973BT/YE1fNTxeMZa4LLlIZzwEzTOj749ZYqnYF+sdE3cHQkn+pj9/DSOIPn+9BGKkejb+Zk2UvOLr1/Y1gOpO5Zp0Pz0hxYNTbZwSGvMjV4JD1x56UGt11oT3bW46kyLQeWwYiWyehySVAbDlc8QJf3dtam5I2YEd4DvjZXBAPtpPDmdEEMis+rBBczKvypxkoWxcTm1E6kgg57yi1Jr9zKytvgTeb98tdHr4fx3fWiO8czss9/KIm5cCXCZigXzrXDsv3NYm7rgcsAwgXq3cPNLCykG6wJSxbodnpKVfJmBwZM2wTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPi9cKOHFTTxD5hL3E4LCGjQm6vHGV5Ite2WdNSvYsc=;
 b=oBFzPEZjYGruk8DIVCd3qJ7OruM4FmPstXCZ9ShQPYG0ktVhZUsRXJXJsArZaFIgWUHP3ya2Dw0JNonyurhxNYThNfjtDwnGyE0LaEVa98icHRdf95dfGy6pPO2lF3iLCN4I1YulU/iNupm249g7DJDui6S48bllGIQaE0hLws/j2tZ2+8ej2RWg+eHxMYjGs3yEuNKUDYWFO0iOBuHhm/mVgX6zA5o7AW0629YywZEBZSeCH3D6p3z0xFnliF/Htp8M1TuUw3EYGL8Wyr5FLsATzebptBfNptWUiaeDap+PSeNSWFP9NpUgjPhJ6rQMn3pFEN7qVl1kaEVosm/r+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPi9cKOHFTTxD5hL3E4LCGjQm6vHGV5Ite2WdNSvYsc=;
 b=PI5fpTs3g8EA7bq6L8SVBS82TIBlrh9ddo05P9DSu5d7SNMzwGDo9NtwluGRfXFNoDmqBYCMLMHtdssTzxjmJ3iKl+FlOcHC2PB9fbREP3UvHobZWN4B/Y9XmNhL/W0i1cZ/vnikGNljpY0TK3ecl1CAHpYgqd1EONcTxE2Hofs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=markb@mellanox.com; 
Received: from VI1PR05MB3342.eurprd05.prod.outlook.com (10.170.238.143) by
 VI1PR05MB5791.eurprd05.prod.outlook.com (20.178.122.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.22; Tue, 17 Mar 2020 23:40:10 +0000
Received: from VI1PR05MB3342.eurprd05.prod.outlook.com
 ([fe80::4566:b84d:efdb:cb1a]) by VI1PR05MB3342.eurprd05.prod.outlook.com
 ([fe80::4566:b84d:efdb:cb1a%6]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 23:40:10 +0000
Subject: Re: Should I expect lower bandwidth when using IBV_QPT_RAW_PACKET and
 steering rule?
To:     Terry Toole <toole@photodiagnostic.com>, linux-rdma@vger.kernel.org
References: <CADw-U9C9vh5rU1o4uSmw=EzMqOvXFqSm-ff-7UbLCKd2CUxT4A@mail.gmail.com>
From:   Mark Bloch <markb@mellanox.com>
Message-ID: <e73505bf-d556-ae4a-adfb-6c7e3efb2c32@mellanox.com>
Date:   Tue, 17 Mar 2020 16:40:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <CADw-U9C9vh5rU1o4uSmw=EzMqOvXFqSm-ff-7UbLCKd2CUxT4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:300:95::15) To VI1PR05MB3342.eurprd05.prod.outlook.com
 (2603:10a6:802:1d::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.9.98.14] (208.186.24.68) by MWHPR13CA0029.namprd13.prod.outlook.com (2603:10b6:300:95::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.11 via Frontend Transport; Tue, 17 Mar 2020 23:40:09 +0000
X-Originating-IP: [208.186.24.68]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 39bf7a69-8a62-47ae-5be1-08d7cacc8843
X-MS-TrafficTypeDiagnostic: VI1PR05MB5791:
X-Microsoft-Antispam-PRVS: <VI1PR05MB57911CAC7B2CC0FD6F80E9F6D2F60@VI1PR05MB5791.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(199004)(31696002)(6666004)(186003)(956004)(2616005)(55236004)(16526019)(26005)(53546011)(86362001)(31686004)(6486002)(66574012)(52116002)(316002)(66946007)(66556008)(8936002)(66476007)(2906002)(36756003)(966005)(478600001)(8676002)(5660300002)(16576012)(81156014)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5791;H:VI1PR05MB3342.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E+qroR/RGOiG4O0HiyfKCEoxNTdDszsT2grTpyUa5LKwvVaS7iZnY1WGkVxaXY7Uvs8B72v6N2WtY/tlAwEsv11fIPKJ2sGdAPsLnaIBUDb9c3p6+q3aCWw3J4XNSp/hZky+F1Uiv6wqhguYB3npRx3O3WYY3PGyJZDom6Z8TXDAKZRSDHVoRo4kTQqBgVeWjxflaRNX0jVxxXbuK6xmtu9wJB6gwOTtQwTWnzln6nEdBZCSBKvE9akriRnL1S2glGyKbKuyZ2CFCyMRnjVC91yllCxjjfGZAjrWQGiAyZB9dSf9PoQgoSMxgby+FcMhQhYQOKPmTez9MzRRsxB6m2awa12c6lc9oaIcaF4lfSaR6ciHWxefnHUrOyX87bsw+LdBKf64hctBFvF6iuB7ULLAOF1ZaiveG8Gc5fpTSCxs1kbE19YMIqjA+ZZVP3jxnZqbD+E6xHPxzQNZPxzYGoumB/zu8GjZiFWHXw+kw2VRAKOVsc+94Q1wY9G/xAKNq17jV1jhHHREqg4YLlwO8Q==
X-MS-Exchange-AntiSpam-MessageData: JAawOIFJL5rXVF0yUDv6CtcXJB9RqNsJ2IiEciOK+uPpYMTIwrHbVsoVTUq7/LN0KTnt5XqjVSR5+my5H9gTY4F7m51CGtfrduVXtXgJMqzhcaofpO4VeSKlJ0HOKU8kovkJ0Lli7e9uoFc2vUYfvw==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39bf7a69-8a62-47ae-5be1-08d7cacc8843
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 23:40:10.6568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w8+j/rVHRq6jjH1TwH6PGZRnMsq05FRmPIdMh56UYxtH5BSWwp4+L18QQduQ1uWv/eCW1AjOZrrm46kuFaEc0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5791
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hey Terry,

On 3/17/20 2:07 PM, Terry Toole wrote:
> Hi,
> I am trying to understand if I should expect lower bandwidth from a
> setup when using IBV_QPT_RAW_PACKET and a steering rule which looks at
> the MAC addresses of
> the source and destination NICs. I am trying out an example program
> from the Mellanox community website which uses these features. For the
> code example, please see
> 
> https://community.mellanox.com/s/article/raw-ethernet-programming--basic-introduction---code-example
> 
> In my test setup, I am using two Mellanox MCX515A-CCAT NICs, which have a
> maximum bandwidth of 100 Gbps. They are installed in two linux computers which
> are connected by a single cable (no switch or router). Previously,
> when I was running
> tests like ib_send_bw or ib_write_bw and using UD, UC, or RC transport
> mode, I was seeing bandwidths ~90Gbps or higher. With the example in
> Raw Ethernet Programming: Basic introduction, after adding some code
> to count packets and measure time, I am seeing bandwidths around 10
> Gbps. I have been playing with different parameters such as MTU,
> packet size, or IBV_SEND_INLINE. I am wondering if the reduction in
> bandwidth is due to the packet filtering being done by the steering

While steering requires more work from the HW (if a packet hits too many
steering rules before being directed to a TIR/RQ it might affect the BW)
A single steering rule shouldn't.

> rule? Or should I expect to see similar bandwidths (~90 Gbps) as in my
> earlier tests and the problem is one of lack of optimization of my
> setup?

More like lack of optimizations in the test program you've used.
When talking about sending traffic using RAW_ETHERNET QP there are lot of optimizations
that can/should be done.

If you would like to have a look at a highly optimized datapath from userspace:
https://github.com/DPDK/dpdk/blob/master/drivers/net/mlx5/mlx5_rxtx.c

With the right code you should have no issue reaching line rate speeds with raw_ethernet QPs

Mark
 
> 
> Thanks for any help you can provide.
> 
