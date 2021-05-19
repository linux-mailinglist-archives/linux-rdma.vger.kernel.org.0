Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56075389563
	for <lists+linux-rdma@lfdr.de>; Wed, 19 May 2021 20:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhESSbF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 May 2021 14:31:05 -0400
Received: from mail-mw2nam10on2089.outbound.protection.outlook.com ([40.107.94.89]:42560
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229652AbhESSbE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 May 2021 14:31:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HyphtgB/t/TofjTj9HhSC8ZWsMSS6Mem1g/jxKvJvU5r51XthTToe0K/uQLgaNdJPmFXVBfnr2Dss4JcONa6lDAaa7zVOo5bu0i61rwXJd9JNc0tZyvIuMPJuG8Wc/DSterYXbCqZf5XhPZxooz3T92LOXEr9JqS84CX7xOnjJy+Tk+P7VKUkke6XryTp11PN9TMtWhxn6atcugwPxUwT3mwRsXk4othgc9mcxXG5GXz/vO0Ng8vxjL67aP364FLsb/shRTTpGp7174jvDGKq6rbPKcH/sSBanFwtyQyP9bDLl9w3liJ3TglU5EoUwnL+d4jGffIHEx1ImrJjbUQuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmR49h5wY/2juYKtR7n0X0VYncDEZRXu8cvutmz7GQg=;
 b=KgwD2ZH8s5May4jofit9w5gsfynkJ30PN3zuVsjft+5rG4alGuz9K/hEpwqzTEsRGiKHRI7PO/KfLnRuI2B8ingaZPDvRIIoYaXfnVczwILBtqPZDPCEtwkBKrVdVADAjmSHCJ/D29YFoy4ima8JJZeQA3YPZqXu9Kk7xFdGrvwSXJXADmMocV1nUB3xEmCJ/frRy75uLK46LuzuAEPJc2SfvlBXu8kQgtr/5GeHzilAbMQ+Rvlh3jfmj5H8U4ExorpK+U/+CWD8Q1NijECdQ4dJRXRlO8LMQiHoYKitoI9TbpQNhKnnSE1iidYFsxMG2RtC6+GKZ7tGYv/ouSPfHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmR49h5wY/2juYKtR7n0X0VYncDEZRXu8cvutmz7GQg=;
 b=fHP0fE1W2SH+2cdcNXIBk+Lr9EsLBpt/ZJMjVfqXD7LHlBB7aDN/Vm0cU00u4f3R0ofDSIwYCz2YOjF80JGdr6tfs9tEKKsfGhUMMAdEVLMzwARov8ERjh5G/FPdE9MR0k6DIPLIGwfBcLnV0Hc3LM2RBG1N1+YcoS6XtWwsfZ7ZejszeuTbLRwyJcACy66KWDZDjxk8NtxLBlr5dB0ayqJGvvPOckEn4hj1wQvLrEhKY7ocF9BewRPAnK38ivYmi1KsBhh/bidsVDGL+9MhJEoJMDH8eh0bpEDIE6YVm+ZwTcZdnn6Ljf6MFWEuVDT1frO9hbW27f61gzdC01+mfg==
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4778.namprd12.prod.outlook.com (2603:10b6:5:167::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Wed, 19 May
 2021 18:29:42 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 18:29:42 +0000
Date:   Wed, 19 May 2021 15:29:41 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
Message-ID: <20210519182941.GQ1002214@nvidia.com>
References: <7e7c411b-572b-6080-e991-deb324e3d0e2@cornelisnetworks.com>
 <20210513191551.GT1002214@nvidia.com>
 <4237ab8a-a851-ecdf-ec41-4e798a2da156@cornelisnetworks.com>
 <20210514130247.GA1002214@nvidia.com>
 <47acc7ec-a37f-fa20-ea67-b546c6050279@cornelisnetworks.com>
 <20210514143516.GG1002214@nvidia.com>
 <CH0PR01MB71533DE9DBEEAEC7C250F8F8F2509@CH0PR01MB7153.prod.exchangelabs.com>
 <20210514150237.GJ1002214@nvidia.com>
 <YKTDPm6j29jziSxT@unreal>
 <0b3cc247-b67b-6151-2a32-e4682ff9af22@cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b3cc247-b67b-6151-2a32-e4682ff9af22@cornelisnetworks.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR08CA0019.namprd08.prod.outlook.com
 (2603:10b6:208:239::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR08CA0019.namprd08.prod.outlook.com (2603:10b6:208:239::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.33 via Frontend Transport; Wed, 19 May 2021 18:29:42 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ljQwv-00Aoda-Cu; Wed, 19 May 2021 15:29:41 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd56f2b9-c18b-4271-b52c-08d91af411eb
X-MS-TrafficTypeDiagnostic: DM6PR12MB4778:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4778C0BB19E4DCC2986EF1B6C22B9@DM6PR12MB4778.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FtZzeHhyQoU50oZLNuSlaNmPhsOyra8XYVYYWTmvGA6HbBjLmjhjv74Yt5hfxRwoHa0g1HZ3SEXAuZV5edoPQtfoYvw1kF9AhrbzJvZ5JfG0QnoXG9EmMrjdjU8ol5b1F1l1ild3B630vaMkvDdbLIN/7eionklOLQjXr6hoyglKjJor3LK5Y7lXAg41CIxeQBxhDi6jM+Rvzw0TdmbLtXERaZFddfeU1eXhPigHyh/mkm8fOwkd3XDoYDt+MXiRnATdkqPU95NfNngdofjHBe4ZLxb4kz2tabvcko20qhwTlbF5zoKGs/OhNrKPWvz2R1fyWsh/2TqBtXURri7t+nN0sXKL3c+5Rc43IReMHgAaD90+S0O9K4K1HLJfA5oxZhF6LE0i1raZtii6cVR04s5rCIVOvum8QqFxWkyw8AvubiTDRBObMMQCTeOmGKrF/Eu1SNywUvWsD2RH5psNwZ25ZuEzrB7ZXhVjJomADwXAixcRxE5HY9KPTb0e99neLTNyKvaDgtrb3nXJ1CEA8BoOGUa0lTfeQ3ZmZcg8g2asibnhy5E9CbOSHUAFdPUY/pGiRntB1CRXWgM6johDUQCrDyMentxgweprREbPU5Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(39850400004)(376002)(136003)(86362001)(2616005)(478600001)(26005)(36756003)(316002)(5660300002)(54906003)(426003)(66476007)(66946007)(6916009)(66556008)(4744005)(33656002)(1076003)(186003)(8676002)(8936002)(2906002)(38100700002)(4326008)(9786002)(9746002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jhXkGX/XjDTVVAmiph7S283ktx1YYnvZTl1WVEwpWbwH6aJl3lbcIU3GzLlp?=
 =?us-ascii?Q?twk1/3LGhfjLPKupwi6QGqnsQoazvD+Y0i6As3tCphrtwHDYLoh+b4Fdpzoi?=
 =?us-ascii?Q?Duh4lzJwvRJOAwSuYskMZYKuiGKgoQ5JqGwnHO0C73P1Azq6ztJ63KOVtZjX?=
 =?us-ascii?Q?ZeeTgWNOlV0gHCjGlMKJwmUkcQ7dTehyjez4mxqzK4EdkaoaV9nfcOR1B83p?=
 =?us-ascii?Q?VXWLpEootjdQWG18UswMNrgSBJvjLgUq0rFb9qBtNIixq/zSWbaCCRrsI+fi?=
 =?us-ascii?Q?OwUnKLOnkvFi3EcqSYPXHDbbfAq3+PR5mj0W6tvcRAX5BdT8250jx/+9WIrC?=
 =?us-ascii?Q?4YWc+IYOHeDIxIx8r8io94W2NZgD7WBedaJhp2APL2WQSN+utr+WMl+AJ3Y+?=
 =?us-ascii?Q?rUXN3Z67hc8T3Gkcw1Fz0dc3Z1Yj64mkqYn3Mym/fTrEMevaX0PU73aLSA1H?=
 =?us-ascii?Q?sOxgbaHF2wvtSElSNRsKtBVLVbWcEoTWvIDRCN1Uu9b/X53wpNx5iWc/BwKW?=
 =?us-ascii?Q?FIWGTVZ6WMcKfDuIu4Ectpj8xqTQWzU/HpJIjHM7QLSPY08WERvefX+VeAzt?=
 =?us-ascii?Q?IKBUr4HVG5NG7XJjfh300MfKM4DB5AoXZ4MnZjLfm9ZDLiAF075bNWM6hzmT?=
 =?us-ascii?Q?UGapuozF1CM7Wia0aAZHUmdhezepTDYhP7DEqdnhUs76BC4IiGSGbdfY0THR?=
 =?us-ascii?Q?LQURM3RhuOaq5P7x05HxYTDtJGqwiuqVUn7tt9tDWXq3nQBCYiXHnV9VZnRj?=
 =?us-ascii?Q?8ZTo9L1oKPHYXtnDyidVjT+Iw4GOAWG2+CHFeGxHIM3sYsQKzj4FsUpfwZj1?=
 =?us-ascii?Q?jOdZn9x4Crq/mY8iPpWM+BgPPQHSqfL/J0OJPgN/WuNFyBxvhL63wE7bz8zV?=
 =?us-ascii?Q?4tddlGWj5dHu5nTKSQMjXDZ4iSJHSYJ8MZaypoZLtSC1cwV2UBkQ2WuuhlvQ?=
 =?us-ascii?Q?v23br5k/2AKd08opkslPIAFZGm7Jj41FY7uZXUItsAV6/bHmr/A7nsj9jw2y?=
 =?us-ascii?Q?A2AlqJChwPj7U16oV8eLr43vTqDcRQvHVLjGMJv24ZeNHzAB1QqMCbm6CJnT?=
 =?us-ascii?Q?u7yXJZzcqQo/NbZ4MDqyV8Ve/KorErDNopIxTLCR/WFkdYy6Rtk/ZvZLHOu8?=
 =?us-ascii?Q?4GYrrz/8XOt4GeKi/8z1TYVzc7lk86+yIydZ4dC10lIeAPfb4ogw2S2JlEty?=
 =?us-ascii?Q?+W+uXEQoUv7wpcX7wrP2kC9hckm1oDgs2jUBQZJWObHEpxUVq+GiFBM3edHk?=
 =?us-ascii?Q?L9n/DvgLQQkIxQd2qpjU8jCJnAo6m7V5zI7qO6y+ijLSVX/sMggHOPQEnayO?=
 =?us-ascii?Q?GgS98Fesvij4rN+jhT3Jmq9x?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd56f2b9-c18b-4271-b52c-08d91af411eb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 18:29:42.5947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uixV3k5cqq9bdTAmwNXaH1vvyDSy2gMXBoVOEyk++f17nG5z3vzjKaEg18kwRDKe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4778
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 19, 2021 at 07:56:32AM -0400, Dennis Dalessandro wrote:

> Perhaps the code can be enhanced to move more stuff into the driver's own
> structs as Jason points out, but that should happen first. For now I still
> don't understand why the core can't optionally make the allocation per node.

Because I think it is wrong in the general case to assign all
allocations to a single node?

Jason
