Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 066601711AD
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2020 08:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbgB0Hsx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Feb 2020 02:48:53 -0500
Received: from mail-eopbgr60044.outbound.protection.outlook.com ([40.107.6.44]:37698
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727661AbgB0Hsx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Feb 2020 02:48:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WIqC5VTMg1FUUBDgzJ2GZs11spmtb8JkpgtkhtXntEd84U+eR1LOBJBYv8U4EFAbY5Tl1rCNAEbkHzGJeVxOylBnkr+pAQ41OV0WGuXsdl7SF2BnxNzyMyeM4rHcxNiW9cX8OXrHRbnemAXoWYgH0u439fE+d+LGEPGWN6bqtl/XpR1SoGQx5cqaNc89yDte7AxyInMU4Hzh1vAgE8rmGHxCTd0Yi9hyrOQtMKXJfFj0ehB1dSX7QHTmQvHWJxDOgScxt8p3BuVxn8xcQfQz8YdxQz/PohvgETZ7+Nw5Z3t0Ep6+7FsBowHIW2NW9M00JHRW7h+9wfcchNaOlycf0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISe6tr4X30rjZJuIDk85W/1XejkAenMcqRX6wj8NmtQ=;
 b=H5df4K3WPXQddEz7LttuzMlu67w6OknB6g0EYY14wj5PuSOS4LSVEa5TKwuJpjaXMC+Iu6T9Jb2bPpZIMT9EzZ71PojRUwhhIIoUc95mAs3/6OS5kHdtlD0XVYTqCrJy1v6oD0EP2yxmoHBodqH7byol9G/5PvGG0AV/QatkK/XeYSiJkmF7AHxbCVNtl6OsyzCcfb91nUBCNqBHjn1i7Degl3DFD/DnWS1SUBQ/FJE5QqzTcS27GSgySNjdJkw6Wbniik0UAQjcOx21V4lNnPA0amkP+gvCs676cwtcCgoHXbj3jJ7O+e+lZJaNjN2k/RvglRjNQEHsRjEqIs/1LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISe6tr4X30rjZJuIDk85W/1XejkAenMcqRX6wj8NmtQ=;
 b=jbs0++iU2QQbOiTmNkFeUeT2wLzxyx19EyrM6NKfp9pL00wfY6bqSTwufUQHe2/EFrcR6GWG1LwoF8TYuTwHABA58BZzkm4stT/6N0YZQFGXdwoLH8P/Rmmza30Y92K4jopE1y+HsPTHCROtjTlwE9GpdP2jnMjrrG4fz5kzCog=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=haimbo@mellanox.com; 
Received: from HE1PR05MB3259.eurprd05.prod.outlook.com (10.170.246.152) by
 HE1PR05MB4715.eurprd05.prod.outlook.com (20.176.164.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Thu, 27 Feb 2020 07:48:49 +0000
Received: from HE1PR05MB3259.eurprd05.prod.outlook.com
 ([fe80::fd80:38da:1f6e:cc9f]) by HE1PR05MB3259.eurprd05.prod.outlook.com
 ([fe80::fd80:38da:1f6e:cc9f%6]) with mapi id 15.20.2750.024; Thu, 27 Feb 2020
 07:48:49 +0000
Subject: Re: "ibstat -l" displays CA device list in an unsorted order
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org
References: <2b43584f-f56a-6466-a2da-43d02fad6b64@mellanox.com>
 <20200224194131.GV31668@ziepe.ca>
 <d3b6297e-3251-ec14-ebef-541eb3a98eae@mellanox.com>
 <20200226134310.GX31668@ziepe.ca> <20200226135749.GE12414@unreal>
 <20200226170946.GA31668@ziepe.ca>
From:   Haim Boozaglo <haimbo@mellanox.com>
Message-ID: <1da164dc-9aff-038f-914a-c14d353c9e08@mellanox.com>
Date:   Thu, 27 Feb 2020 09:48:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
In-Reply-To: <20200226170946.GA31668@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::18) To HE1PR05MB3259.eurprd05.prod.outlook.com
 (2603:10a6:7:2e::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.223.0.75] (193.47.165.251) by FR2P281CA0008.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend Transport; Thu, 27 Feb 2020 07:48:48 +0000
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a9c43043-2834-4e11-97ef-08d7bb597b11
X-MS-TrafficTypeDiagnostic: HE1PR05MB4715:
X-Microsoft-Antispam-PRVS: <HE1PR05MB471563B5314120D4BB5B2BEDA5EB0@HE1PR05MB4715.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(189003)(199004)(31686004)(31696002)(66946007)(66476007)(66556008)(16576012)(110136005)(5660300002)(2906002)(478600001)(2616005)(6666004)(36756003)(956004)(316002)(26005)(86362001)(186003)(52116002)(8676002)(81166006)(53546011)(16526019)(8936002)(4326008)(81156014)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB4715;H:HE1PR05MB3259.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KsvSUIlsspAJT3z5VouxCB8+NAIMfYgXp6+10tcZb3canxvGSn0/hK/uIfmROCa7+NIacfDR4KQhyZ91W/iOrpzzKx9tzghVmrK39MQRxLMdcnUd9nsW/A1xzV5RVsaJy3xppFup6Hqs5C0tEyeUSmcDOcg3MSnjfATrbN7uj1KG6oBFpSIOoCKq9X7h7U24MdYQ8az0NjNXMgJrANM+E1JOjj5/erHTbcjEC9c82ohOw8vlph2Ylq7IVvGayEAdEQ9OopA72PBArSTEI7YnB2/3P2s1/nySdHzzaLvet5We10no0V62eO68/83hofIlWHEUB1Ge1e0LkmIXtYtIus7e+IzAQki9+lQ+WcoAFwfOpsEEUiB5JVIe4AzarskU/B7dBbWmirOVRGSbtiC+CH3fsEgKReJdHNQSiC9LcVymWSxepk0t1rC78ROXCufn
X-MS-Exchange-AntiSpam-MessageData: R10pKAPsD8YtgzfqWaTDZWvVWReP6rCIC/shB2xtirDIb0Xwew2jhgb8bGilL87nzvJlaPuphJuTSt2rrc8tTvAY7kri36JNs/Zz/dNttf8GiCXqg1BmeEzZu0Vhp7Y5XQEaA9FTAqU8hLazbK/sEA==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c43043-2834-4e11-97ef-08d7bb597b11
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 07:48:48.9597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +aP797zzscIlkB/UV72c//xvoeJG/RbOyLUW+agMGVT2cx2rTIp2WZB9p/l2bkWrWoiCbHadSO1LxG5SGVUrwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB4715
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2/26/2020 7:09 PM, Jason Gunthorpe wrote:
> On Wed, Feb 26, 2020 at 03:57:49PM +0200, Leon Romanovsky wrote:
>> On Wed, Feb 26, 2020 at 09:43:10AM -0400, Jason Gunthorpe wrote:
>>> On Tue, Feb 25, 2020 at 10:25:49AM +0200, Haim Boozaglo wrote:
>>>>
>>>>
>>>> On 2/24/2020 9:41 PM, Jason Gunthorpe wrote:
>>>>> On Mon, Feb 24, 2020 at 08:06:56PM +0200, Haim Boozaglo wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> When running "ibstat" or "ibstat -l", the output of CA device list
>>>>>> is displayed in an unsorted order.
>>>>>>
>>>>>> Before pull request #561, ibstat displayed the CA device list sorted in
>>>>>> alphabetical order.
>>>>>>
>>>>>> The problem is that users expect to have the output sorted in alphabetical
>>>>>> order and now they get it not as expected (in an unsorted order).
>>>>>
>>>>> Really? Why? That doesn't look like it should happen, the list is
>>>>> constructed out of readdir() which should be sorted?
>>>>>
>>>>> Do you know where this comes from?
>>>>>
>>>>> Jason
>>>>>
>>>>
>>>> readdir() gives us struct by struct and doesn't keep on alphabetical order.
>>>> Before pull request #561 ibstat have used this API of libibumad:
>>>> int umad_get_cas_names(char cas[][UMAD_CA_NAME_LEN], int max)
>>>>
>>>> This API used this function:
>>>> n = scandir(SYS_INFINIBAND, &namelist, NULL, alphasort);
>>>>
>>>> scandir() can return a sorted CA device list in alphabetical order.
>>>
>>> Oh what a weird unintended side effect.
>>>
>>> Resolving it would require adding a sorting pass on a linked
>>> list.. Will you try?
>>
>> Please be aware that once ibstat will be converted to netlink, the order
>> will change again.
> 
> This is why I suggest a function to sort the linked list that tools
> needing sorted order can call. Then it doesn't matter how we got the list
> 
> Jason
> 

I can just sort the list at the time of insertion of each node.

Haim.
