Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132B21D3DC6
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2020 21:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgENTmq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 May 2020 15:42:46 -0400
Received: from mail-am6eur05on2049.outbound.protection.outlook.com ([40.107.22.49]:6102
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727118AbgENTmq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 14 May 2020 15:42:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRAUHdctp7aE8kZvGNInqAYVqiooWXyMjov44Q4RyN1EvjwBeIRdChSOOnC6mJ3CxqX9rI6hzVSmZ41wen+6FSuNPyBb7z+O7rNQrYJ4tKYOXNGEfwb0HHz9VM/GErrUBKbC3IGnr2nvZEbgtu+7Uq1R8arqf1xSR6wHO3gVa/1axJ4zMfgg9yHkbGsgBLpE5iderhtEIvhi+hDe0XTEgYJ/QvtvjyQEbCL5KWD5SKPp1LIEznGGEcQgiNy3K3tWbuArxoiTZkRqaV0wge94pFoBzStjKsrqU2wTTqXi1p13XkU0XZ3jCzEvBnb5FVfj4SxzvavKiYWNlCI/cJoQXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/rYqQXPkidSxSOekvO4OmYDU/lWn22J+CVnczWpfvE=;
 b=ABINEiWA+LdDOqpVuMqHb3aSc8giFsL+H85PNtzNeByd7Bor8kANA9WdNXBE/1yHRjCJ6BDXCrN0dc3X8Da+utA16LzwRKYiT56hcDtmF2dLxScGDciS9zHAPNxpzwrWiA/Q1iE5CPfK2NbjFCdgUZ7AvDMmxeXdXOOPZ4ZtBJcAN1JUj/TLyJXd78RaPD/uzb03MZTqYp/N6WeHYaw+4QMQeg4vUuari8bQqPXETOe8C4icqc5rQBgbCJUzfWv4zMJsRPO9YSqoRDTrd4fPUuZaoVcsTtwMfg/Hv0Ttgy69EGK69Toe08UE5TDV3o/lEMAmqLkjDcraopd5w9rIvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/rYqQXPkidSxSOekvO4OmYDU/lWn22J+CVnczWpfvE=;
 b=LYwAaO4s0dRo/0ei17gd2J6kb76OkphK43DYnt89Ni29aByGLV0g1CgUQU1Q9Wyzk0kJNw6vDnyEV1QJ60qfSsPzma13pRUz3DYS4iMIOuCEDs4vkVBIFGIkexC+H3n64vhi4/7btxdYAvC0ZBGQnIoTlNzMwP/E0dx92fmqtNA=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from DB7PR05MB5820.eurprd05.prod.outlook.com (2603:10a6:10:8e::25)
 by DB7PR05MB4889.eurprd05.prod.outlook.com (2603:10a6:10:1d::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Thu, 14 May
 2020 19:42:42 +0000
Received: from DB7PR05MB5820.eurprd05.prod.outlook.com
 ([fe80::fdcd:6ec:7334:e25e]) by DB7PR05MB5820.eurprd05.prod.outlook.com
 ([fe80::fdcd:6ec:7334:e25e%7]) with mapi id 15.20.2979.033; Thu, 14 May 2020
 19:42:42 +0000
Subject: Re: [PATCH 0/8 v1] Remove FMR support from RDMA drivers
To:     santosh.shilimkar@oracle.com,
        Aron Silverton <aron.silverton@oracle.com>
Cc:     bvanassche@acm.org, Jason Gunthorpe <jgg@mellanox.com>,
        linux-rdma@vger.kernel.org, dledford@redhat.com, leon@kernel.org,
        sagi@grimberg.me, israelr@mellanox.com, shlomin@mellanox.com
References: <20200514120305.189738-1-maxg@mellanox.com>
 <905E7E0C-1F87-4552-A7E3-5C49EDBED138@oracle.com>
 <5c48f60b-23b7-da64-6f37-f52de7bb625d@oracle.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <22c5d65d-1d8d-76c2-5e8a-281cac7f3091@mellanox.com>
Date:   Thu, 14 May 2020 22:42:38 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <5c48f60b-23b7-da64-6f37-f52de7bb625d@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR0101CA0054.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::22) To DB7PR05MB5820.eurprd05.prod.outlook.com
 (2603:10a6:10:8e::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (89.139.203.251) by AM4PR0101CA0054.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26 via Frontend Transport; Thu, 14 May 2020 19:42:40 +0000
X-Originating-IP: [89.139.203.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6f888a7d-7e8e-4ba1-532d-08d7f83ef787
X-MS-TrafficTypeDiagnostic: DB7PR05MB4889:|DB7PR05MB4889:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR05MB4889924E0F97DBB6C26EC938B6BC0@DB7PR05MB4889.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E7KI3iYA9L9KHtpWlbUeWcML212JD0Z0V6wapmg9VKg2vhJcZBGbGx1je2vC8YmJJkoGfn0ODsnLBGqB9lplb4Wnk3EyDa+LDw6F9cfBQ1iplTpU1K8QjC4oWqEY3UDvgqqKJDpXTWH5e8jqsRzY7KT0WucYe0BsvkvW5/oOJaAbByjMkCriRlilIisvOXEe/6bR0mgLqT6EvxrT3Y114FRWJB/I+wSWCvRIyjtZER6VnlW+EaVeQE2WjnxViQ5t+LyKBgWDTZ734VeEIZrzqNemzKtvncvWVOWf31DqAIJr8wLav8/WFCetOhDRyiO34duj23YKQ4bjmryOA2IUnYC75pMZfyWAgrCxhMi0P9DvyqoLapcSh8BZGcsqJdgjZ+iNgpETglIqhMGPC+jRZUGjYlDJE5YtK1ebWcYM2BI+7wMnmhjzrS49xm/OtK2FCNzgVNURcAc646p3N3rO9q3bNim+l4SADfD0y9FYQhuUVwaTyKXToPcbhRXtvrFf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR05MB5820.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(31696002)(66556008)(26005)(107886003)(53546011)(6916009)(6486002)(31686004)(186003)(16526019)(52116002)(36756003)(8936002)(8676002)(5660300002)(2906002)(66476007)(956004)(2616005)(86362001)(4326008)(316002)(16576012)(478600001)(66946007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 5ug6DWF4z5EcFQ/Jv7LwdCXp09C5MK/LE/pBDfxHtfbwqk96sPZHqUNbvCEa47PWDEiQIwWDlgXeKirlTRGGFfGLj//Gs3atBoCHw4us1q9VHkMObiRqRzAwj5RafwzNeXWfrhyLdxTT+XJ+Q8oV7QL5a3GnMpJnqqcECqEXihOAGqJkqB2Yop4pf5ZYVRtKExJBDwHSJn4AA1rBgWjCJFCciGf8u2Ho7l4mEAsm2s96JrlyqZjH7E64hPLtmlZgkT5rD4WpRiVUrzY54JAttvDBjPZZkSbk1qTiOtpY7GpeL3aGzYmvpzl1p4I7GTi5RflO1VaY3GHlJ/1OMyneaMS5mg0Vgo4QtRAVwBHz8f2VVNQOuGfzCs042rO7dFgyM4aGngTHKN6BySguWNd54PmrckWNypiz0yCl9fubOipSuNajthcxYPCrv21rWRt81/km+TxlBDXyv+QsqXPxuz7g1MkZ7sJLH/kOoo+/zigDVxhg45dVhZZueABdQQ6N
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f888a7d-7e8e-4ba1-532d-08d7f83ef787
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 19:42:42.2575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +WU4pIGJs3cgRn8Qx1/mug8OFCnhXX3GXNPrBj9UVU+5IfSbB4Oy4CMApa2BM/VUbX0PMV6MzucUrZ7y5HvE1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB4889
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/14/2020 9:18 PM, santosh.shilimkar@oracle.com wrote:
>
>
> On 5/14/20 8:13 AM, Aron Silverton wrote:
>> +Santosh
>>
>> You probably meant to copy the RDS maintainer? Not sure if this 
>> should have
>> also been sent to netdev@vger.kernel.org.
>>
> Thanks Aron.
>
>>
>>> On May 14, 2020, at 7:02 AM, Max Gurtovoy <maxg@mellanox.com> wrote:
>>>
>>> This series removes the support for FMR mode to register memory. 
>>> This ancient
>>> mode is unsafe and not maintained/tested in the last few years. It 
>>> also doesn't
>>> have any reasonable advantage over other memory registration methods 
>>> such as
>>> FRWR (that is implemented in all the recent RDMA adapters). This 
>>> series should
>>> be reviewed and approved by the maintainer of the effected drivers 
>>> and I
>>> suggest to test it as well.
>>>
> I know the security issue has been brought up before and this plan of 
> removal of FMR support was on the cards but on RDS at least on CX3 we
> got more throughput with FMR vs FRWR. And the reasons are well
> understood as well why its the case.

Please share the benchmark for both and the reasons that you understood 
for the difference.

We'll try to analyze how to improve ConnectX-3 FRWR


>
> Is it possible to keep core support still around so that HCA's which
> supports FMR, ULPs can still can leverage it if they want.
> From RDS perspective, if the HCA like CX3 doesn't support both modes,
> code prefers FMR vs FRWR and hence the question.

Well this series delete around 2400-2500 LOC that are probably almost 
not used and tested.

Lets try to understand the perf degradation.


>
> Also while re-posting the series, please copy me on the patches.

Sure.


>
> Regards,
> Santosh
>
