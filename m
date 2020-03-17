Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5DC1890B0
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2020 22:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgCQVjN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Mar 2020 17:39:13 -0400
Received: from mail-vi1eur05on2052.outbound.protection.outlook.com ([40.107.21.52]:32993
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726549AbgCQVjN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 17 Mar 2020 17:39:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kj+5WoXZZcp61Tm+jK4+B1MFN28VywPwlZ/rulvPuqJZb3jYzkYc4MrPmE6NZGTrIHhyHtyWLe9MPwrcPAM51TOkbpjvUtcqhmefaRdfkQFEEP2VW2ErorSIMlc+dzii5aESXAgYPoEP39qmJawdndEyyYa6YczqBjJGfySL017E5xDnRrHzDzTmGvFwXBipYIyespzHFL+k5dMK+Oc0hWCL2JlUKNNhegspFHm2j2ZVNgU9FJRo7jDCzWF5dSUmsLmN4GPilFSHnc0K9YhxAD9eNdrQEVAwZvKownwizkdGDU/XijsrlxxYoVOtEaTFQKZ6ZMMHrWT2FA1WBzfmVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZ/u/YY9XqNNWT62EV6PLs2pC70XHf0EUx79wbPjgoA=;
 b=Dg8zwZrNXyCoXzxm3xSyEGvWSszwVTS789UkXt/andMMbQHFYsD+zroAQydYveKWiv5aK9paDck5mj+uVaiFRsPenDVApM43nUHYXmZcU7ajsEBT51YC2KnJ/dtk/pxoiESb0N1MjhzF97LkHLBpaX/yH+ypT/uAAApBTnM2Qtl5gJWRmrwCTLjn+QAhE8Qw4VVwkBAVTFj9SNCsGCeEuPsj2BHrnSorQzwOC7JYauz9WKiC/z5CiXDvfAUfq5rxNx22ncVQT7GHX0LjjhGWsky4xt8el8epbZV7Wz+mtVilqH4JoxsmCMqDETSgYVcSOrL0IGUxGIN/qiuDFdlxSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZ/u/YY9XqNNWT62EV6PLs2pC70XHf0EUx79wbPjgoA=;
 b=swUQDy5qzwkvtBZnSFqCZyOmed4oPGeqzA4bUbDTqXXWNSZwgMLq7remTGKkkQ5QnI6STtA3YaXdP081yX2WkLDyW7+F7ftklVcpRwusgJHLCclo7HOiuRYuBL02NlNFk6UrPBLAc+gwCilxn15kkf1MLGqsBWF2NXczLRfgdGo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=markb@mellanox.com; 
Received: from VI1PR05MB3342.eurprd05.prod.outlook.com (10.170.238.143) by
 VI1PR05MB6654.eurprd05.prod.outlook.com (10.141.128.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.16; Tue, 17 Mar 2020 21:38:33 +0000
Received: from VI1PR05MB3342.eurprd05.prod.outlook.com
 ([fe80::4566:b84d:efdb:cb1a]) by VI1PR05MB3342.eurprd05.prod.outlook.com
 ([fe80::4566:b84d:efdb:cb1a%6]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 21:38:33 +0000
Subject: Re: [EXTERNAL] Re: Find rdma-core version
To:     Ju-Hyoung Lee <juhlee@microsoft.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <BYAPR21MB1223A416AA7FE380D8DDFFC9DAF60@BYAPR21MB1223.namprd21.prod.outlook.com>
 <20200317194539.GW20941@ziepe.ca>
 <BYAPR21MB1223AC2B4C82BC7287D3665FDAF60@BYAPR21MB1223.namprd21.prod.outlook.com>
From:   Mark Bloch <markb@mellanox.com>
Message-ID: <f6b69016-c578-2720-6976-89d588cff768@mellanox.com>
Date:   Tue, 17 Mar 2020 14:38:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <BYAPR21MB1223AC2B4C82BC7287D3665FDAF60@BYAPR21MB1223.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0009.namprd16.prod.outlook.com (2603:10b6:907::22)
 To VI1PR05MB3342.eurprd05.prod.outlook.com (2603:10a6:802:1d::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.9.98.14] (208.186.24.68) by MW2PR16CA0009.namprd16.prod.outlook.com (2603:10b6:907::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18 via Frontend Transport; Tue, 17 Mar 2020 21:38:31 +0000
X-Originating-IP: [208.186.24.68]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 24e57c6f-5a10-4901-a204-08d7cabb8a7f
X-MS-TrafficTypeDiagnostic: VI1PR05MB6654:
X-Microsoft-Antispam-PRVS: <VI1PR05MB66543CFBDF8C0FB1CA2BA46ED2F60@VI1PR05MB6654.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(199004)(66556008)(66476007)(45080400002)(2906002)(478600001)(36756003)(31686004)(5660300002)(6666004)(4326008)(2616005)(8936002)(956004)(16526019)(186003)(26005)(31696002)(6486002)(55236004)(81166006)(81156014)(8676002)(53546011)(16576012)(316002)(66946007)(86362001)(110136005)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6654;H:VI1PR05MB3342.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KVAROUmxl11FXbQsFeBochJc6/N9i261B2gR0dMfoxdXcpAZ5Qjeh5svSnr4LvNJirfHY4Az6MCY0iU1GSc/9g/VnnuJfQq4D9C+94w3iDqWLkqANXADBgd1VQrCOQtTC43d16c8tYrlxpLH5JcpeOa2HXthQHFUYF1DSzbSCmRplMNThknXfPvsqNJiJnnrTh9j0GT69eGfp9SZEUpmw5wHOs/lHLb/0VYhKWFwGD+vMov5E/I6z3oddUgRMzsfGC5bCgFYKiQc/78d4PsA45uDlLWYZiJMvKqiQIJoP64GQcgqDwbDGVogR01iE5rIGCispM5nzwW41BOsvqHwdOqh8MtzJgan8305x3viaEOsKsCR+tUD5xJShvW8zf/YR16JrQD6NzjyN8swqwObFYAgokfbgUeEvp+kf3Y6IsLrHF6j3kpx0gdelXf3Wz+8
X-MS-Exchange-AntiSpam-MessageData: MZKFd9Y91w5LRDweIpT/QieSsWf9LbG3Q/gOgl9jMHS3V45JWpYXc+IHwTgjoTzLLcG2lSmgGFBayFMlJ46VpeoUQXI5OdhRKzWH4+VONccVdVGn6jtDN1lv0qjjczk0/pvQAdjWwp1eXQeOjHfHbA==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e57c6f-5a10-4901-a204-08d7cabb8a7f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 21:38:33.0578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bqVGhDDEKacwCu9CW6rpCxLreEwCIk92eJSc6zdporl/F0Rbw/AXxFhWe4XqsHgLxWUroiEQNAxfP+xxakmjrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6654
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hey Ju,

On 3/17/20 2:32 PM, Ju-Hyoung Lee wrote:
> My original  rdma-core version was 22 then but it still shows after installed rdma-core-28.
> 
> This is my log of the original state.
> dependency-vm:~ # ldd `which ibv_devices`
>         linux-vdso.so.1 (0x00007ffdeb7ec000)
>         libibverbs.so.1 => /usr/lib64/libibverbs.so.1 (0x00007f68c7ecd000)
>         libc.so.6 => /lib64/libc.so.6 (0x00007f68c7b12000)
>         libnl-route-3.so.200 => /usr/lib64/libnl-route-3.so.200 (0x00007f68c789c000)
>         libnl-3.so.200 => /usr/lib64/libnl-3.so.200 (0x00007f68c767a000)
>         libpthread.so.0 => /lib64/libpthread.so.0 (0x00007f68c745b000)
>         libdl.so.2 => /lib64/libdl.so.2 (0x00007f68c7257000)
>         /lib64/ld-linux-x86-64.so.2 (0x00007f68c82e9000)
> dependency-vm:~ # ls -al /usr/lib64/libibverbs.so.1
> lrwxrwxrwx 1 root root 22 Dec  9 12:31 /usr/lib64/libibverbs.so.1 -> libibverbs.so.1.5.22.5
> dependency-vm:~ #
> 
> After build.sh in rdma-core-28.0, 

build.sh builds rdma-core locally and doesn't install it in the system.

you can do: ls -al build/lib/libibverbs.so.1
note you can also run the binaries this way,
for example from the root rdma-core dir:
./build/bin/ibv_devinfo

Mark

> 
> dependency-vm:~/rdma-core-28.0 # ls -al /usr/lib64/libibverbs.so.1
> lrwxrwxrwx 1 root root 22 Dec  9 12:31 /usr/lib64/libibverbs.so.1 -> libibverbs.so.1.5.22.5
> 
> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca> 
> Sent: Tuesday, March 17, 2020 12:46 PM
> To: Ju-Hyoung Lee <juhlee@microsoft.com>
> Cc: linux-rdma@vger.kernel.org
> Subject: [EXTERNAL] Re: Find rdma-core version
> 
> On Tue, Mar 17, 2020 at 05:23:28AM +0000, Ju-Hyoung Lee wrote:
>> Hi,
>>
>> Can anyone help me find what rdma-core version I installed in the 
>> system? It's a set of lib and utilities, but there might be a way I 
>> can verify the version after the official release installation.  Any 
>> help?
> 
> $ ldd `which ibv_devinfo`
> 	linux-vdso.so.1 (0x00007ffc63bd6000)
> 	libibverbs.so.1 => /lib64/libibverbs.so.1 (0x00007f3de67c4000) [..]
> 
> $ ls -l /lib64/libibverbs.so.1
> lrwxrwxrwx 1 root root 22 Mar  6 19:43 /lib64/libibverbs.so.1 -> libibverbs.so.1.7.27.0*
>                                                                                   ^^^^
> 
> rdma-core version is 27
> 
> Jason
> 
