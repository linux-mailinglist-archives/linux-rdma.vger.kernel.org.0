Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927F31CCBEE
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2020 17:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgEJPR6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 May 2020 11:17:58 -0400
Received: from mail-am6eur05on2086.outbound.protection.outlook.com ([40.107.22.86]:24981
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726104AbgEJPR5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 10 May 2020 11:17:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GdQLqtpaOds1m3ELXlDwdek25Nd0fT1bN1hEweRegUa5eqzJ9xXy8WWfxdALNXXDUEyX0s8FEWDMB82ZxH4wo/pNciUKFT31SfQnbp3dvLFbrRwhOlfiyMwE4ULiSXAc09kEVJc0t4poet/c/K/OsR/d/18s5BXO4yPXs5UNPfIPh5gdsdYRSYO2mN5rBSY8yfmReOXfbfsO2l/lf8srtDtsaj2xgrE2klyeO0+C23z75pHZIWNMhvGpp9uF7JsRLg21XY++jRITFv4povdoLf5baB3NWVqgME7d5byieRA+Y+LtJLod4h4G5lpjQs9Abivj6z+4s1xQLRGSIEqjqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIOetHMHgJJTIdjH4zDm6xq6iQ0StdRvaYIewxn8l0Y=;
 b=GtxZbtcfV9iapEiVJT64PygBw8bsj01ZyuH/c6mL6NRPnu/+3A1Y4t427qjBO0tLeAyfTzauIakW66NFYXHeKCdy2w3vdg+UM947jO90aE+z+OBjNdxfJryDQsU+1uBvAzECyRDqawAConrd/XP6NaUiEHoN4lkCOJgLklkuAybNDw2DdtKTMpqFsrI9GY+f7Uy5FA0RFUpwpbkSIOCD9C83tKITlyKL1ReSAmdI0CjgfVjtEI23VwV2Nff7p+awa+3CwC4kmuXoPwCgIK0xV55460GL1fLtrLribWrGmPlbOtrYZiz+YYfnpkYytrud6U+LVn7h6nzHwfyyaz1Weg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIOetHMHgJJTIdjH4zDm6xq6iQ0StdRvaYIewxn8l0Y=;
 b=a3vaCCn/YPZtMn8C+uHAMNrA1w8rRU97d4a7EGol+4BrUC3BpNZ7ldRBnHnphdNrlXAZIR0wek3R15mGcyyej5q9VJQuOoiQoML+/nBrP1WCVT/rlbxs0zqkhVM7+dxxSVjCdrj6Hjg8JHYlKoMPMf1e0shpqVawq+BYc7td/Sc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from DB3PR0502MB4011.eurprd05.prod.outlook.com (2603:10a6:8:9::11)
 by DB3PR0502MB3994.eurprd05.prod.outlook.com (2603:10a6:8:7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Sun, 10 May
 2020 15:17:54 +0000
Received: from DB3PR0502MB4011.eurprd05.prod.outlook.com
 ([fe80::cce6:f0a5:7258:82e1]) by DB3PR0502MB4011.eurprd05.prod.outlook.com
 ([fe80::cce6:f0a5:7258:82e1%6]) with mapi id 15.20.2958.035; Sun, 10 May 2020
 15:17:54 +0000
Subject: Re: [PATCH 0/4] Introducing RDMA shared CQ pool
To:     Gal Pressman <galpress@amazon.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>, linux-rdma@vger.kernel.org
References: <1589122557-88996-1-git-send-email-yaminf@mellanox.com>
 <8062fcff-dd42-f3a7-f40c-8b6d51d4e1a8@amazon.com>
From:   Yamin Friedman <yaminf@mellanox.com>
Message-ID: <bd6474e2-b07a-a5b8-cd01-ae75c84f4dba@mellanox.com>
Date:   Sun, 10 May 2020 18:17:50 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <8062fcff-dd42-f3a7-f40c-8b6d51d4e1a8@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM4P190CA0004.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::14) To DB3PR0502MB4011.eurprd05.prod.outlook.com
 (2603:10a6:8:9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.100.102.13] (93.172.45.15) by AM4P190CA0004.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26 via Frontend Transport; Sun, 10 May 2020 15:17:52 +0000
X-Originating-IP: [93.172.45.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 92d5d084-454a-4d6a-9473-08d7f4f54fae
X-MS-TrafficTypeDiagnostic: DB3PR0502MB3994:|DB3PR0502MB3994:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB3PR0502MB399454500F80AC0B7B717AF0B1A00@DB3PR0502MB3994.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 039975700A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VI59Qt8vEizfmsH2Ggn+8j9vxOpTpWOn9f7icM3cAPMR1bEfFIrIoxHz5PrgB2i4vQNt4Sw+94RvS+s7k8ewae4fOFu8FDk8NoCgpBAR6cDHHqMmqJgzv/vNunPHQPsUsasPt4C380dU8fAjjqv/vweUMNj5rvfDadEI3TmC0gw4wbAJ2BMSJD/V/ZO7zwK0wP7RmNoYn83cTagpv2DRToD0/kkhBIVSTESzeT/OAjdiopPuCqQ7Akz99BCNSgWcDSeQ2f7NHVXIFBV9aSz8VyovtM2pCQlF6Q1IKyZtzZh64pk1x83idmAeJrFD8MWuxPIp6TuEMKOJSc20CDbBxzbJwjUceTlC/ZDGJ8sUWLZf84ko54khstpTh7obq7Gngs5NA7mx7RUT0mA4qA1QXc/ODvCTzflFOBlSzuF0dFl/E/QJqOaSmxIKfZbaUj6vGHSeV+TQJpWQlPGvwkQZjDDEoBNUnfN1gWqbXVd4iEJ67MZA4znDuA7tQWI4Nuxe5zQJ7J3B6S1GGe5F4+VsGy4xVJzSwnjxhf+bnsQoYd09GegTSdgeY+19/92YeIPi9rExiT4+t+cqz0PU24aH0DWCyc/4y0NUZWkH/5TZgT5rkUXU57paL1hNzHN8emCBU8xCJJ8gt57/R0uSfrPSp24j4CwtRXEMLruMS2aiKXs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0502MB4011.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(33430700001)(8936002)(4326008)(54906003)(31696002)(66476007)(66946007)(66556008)(26005)(966005)(186003)(16526019)(478600001)(5660300002)(36756003)(2616005)(52116002)(53546011)(31686004)(8676002)(4744005)(6486002)(956004)(2906002)(16576012)(33440700001)(6916009)(86362001)(316002)(43740500002)(6606295002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 4LIJkmvrY6pHZ5YGNvMcVSc3ESjGBIbk7ptPmX+v5UtEAiY2FKgf3oe1Fz3c5wMk+BFnis0FD6WjtfQHPSGB8fxaxKYztWdnUEUlYinAnEIkaHj/yfjPoQuEFbJRko857d4n82PRsqugfcpt5UvRGZGnoOyXzL/oCBNMycD80H97ZKZkkyVivFPYne8AKqvTnSyB9275rc4yA9jgnxFH/wx9gifxdPsB0aSITJxS5lV44zBHlXIn06QSWTuQwqneeSi3VlDdTlV1C1qYh8Om/rD09FvrwTh6R+uoaB6ddR9Sce4tZGSymun1rfmO8jZuk3DNeETO+/OM2I4c+2O+Kn9K14pem5u8MWGXVUjl6JUz6zIBsayn865sT+Si9jdVVz2ifAHn1xHbSzWiYWEYWf9gqO1J+sgy0Os+FiCHofv8VaUzkdvQQW4C1lEdZqtmFgiwyAwbI+8eZX2BXMKPYEC1Ov6+wN547n+JuINQzxk=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d5d084-454a-4d6a-9473-08d7f4f54fae
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2020 15:17:53.8969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rfvuQb9TDavZLp3N5sly7xfj9Op6pRW8Ym5WmzFODYDBUrH9vi6hEFQ0Wa/i6BN2exvHjlOOMHWlGQJeLTcM9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0502MB3994
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Sure, here is the last version:

https://marc.info/?l=linux-rdma&m=151013509002219&w=2

On 5/10/2020 6:04 PM, Gal Pressman wrote:
> On 10/05/2020 17:55, Yamin Friedman wrote:
>> This is the fourth re-incarnation of the CQ pool patches proposed
>> by Sagi and Christoph. I have started with the patches that Sagi last
>> submitted and built the CQ pool as a new API for acquiring shared CQs.
> Can you please share a link to the previous revisions?
