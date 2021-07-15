Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CEE3CA4D2
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jul 2021 19:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhGOR7v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Jul 2021 13:59:51 -0400
Received: from mail-dm6nam12on2050.outbound.protection.outlook.com ([40.107.243.50]:32513
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236646AbhGOR7u (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 15 Jul 2021 13:59:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUwjNUWkHZvCqb5KKeF/LtrKI+q0LVobw5ZY017gL0Ula06lPwLkP44EOxWTf5h4bMTu9FXip+4rCkREdLNyrGu1H0STsVg49BBMPT3PqsSz9DyqsVq35rK0IVpFwFPEk/qmLbTnmMQqJk/0o1LOoBXmQkyva9PyWuRNU7aW8oYOuyBjbl2uHIdc5/hUbk7ku9tr+tIlIepIVNppZkDIgdk4ZM7aHcTWiGB3P+KaAT7c5q/nfouZ8YeflvKhemj599sjEgxAEiyxqLJ6jBZk2gO4NT1nLxWAlDWxqAxk155yd10LBwImjyRLO5B5TB6VJ8iTfeGBzXyp2+o3v38Abw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qcl54V8hwCd3KQl8H3e7dlSayWkQbs+gZLF0BEFJjo=;
 b=HJ/GG8eQM6/9KELkxfTgZbFeQdjF8G3iVHBZrpl+7cy1Cb/ZVWe+eQW11uHdnmlpxp2nVVgmpleDJuY9pmJLucW+K8YyXxASoySmCxQgmHUWiasSRIR/DhYNvAKWSJn2KPn3nPjUWtVmlDJCjB2i1jvZBmKZLX2rbfc7ANIaGZ4f/8EZhWKEiQUlXJpiOrWsyEi3iBMr8g6j/olqpiMf3DMalS61MrU/vrT0/k8HvZjxAANj7saqeMvJTvhefpbxRpMTbDSd6O2RXPBWh5p89KQU8VmMhmRHiZ5VNz3sjpvXzyDNvz0ikbpjBjN/pJG6Hg4BBq3AmdZoAVyMI9tekQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qcl54V8hwCd3KQl8H3e7dlSayWkQbs+gZLF0BEFJjo=;
 b=mY0yZTdR4Fcr27jqosiEGBvriJEivy//wnZcu1m4xHZ6Aez55bfUjxpVDWlWLGCpE3/vdY80B5u+rAj6ka84CQJa2K6qjooG2Xw8KKyd2kLOzgIP8k4NRjer7zeo24IdU2PQL+rujoms9CkR0wfW0j4TsnGjn7NXW0CxN+I4EOoBXtXBranQBwA5KQeRnkTujGzkJ01iO7MssNX+VmtOBXlq7MYNwlQoEipkfgAbkZWHCXHBtElGre9wKv8MYym5xBeB1GCSgWqIjf0NuVvtTpQ+ZoSlELzLbHUXyTf9WHgkAVcXJcNFs51IXp26BetqqKvlU9jD4JFe/2rdL9048Q==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5270.namprd12.prod.outlook.com (2603:10b6:208:31e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Thu, 15 Jul
 2021 17:56:55 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4331.024; Thu, 15 Jul 2021
 17:56:55 +0000
Date:   Thu, 15 Jul 2021 14:56:53 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        haakon.brugge@oracle.com, yang.jy@fujitsu.com
Subject: Re: [PATCH for-next v2] RDMA/rxe: Fix memory leak in error path code
Message-ID: <20210715175653.GA663177@nvidia.com>
References: <20210705164153.17652-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210705164153.17652-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: YTOPR0101CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::49) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTOPR0101CA0036.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 17:56:55 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m45bR-002mWu-IX; Thu, 15 Jul 2021 14:56:53 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12ecca56-fc7f-4bb4-42a2-08d947b9eec5
X-MS-TrafficTypeDiagnostic: BL1PR12MB5270:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5270A0D49DB8F299A4B23ECEC2129@BL1PR12MB5270.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C31Nz/eNugBgE1uJie5eGfbaxHlSm0UwLcNmZdoaNXgBcSJxtf9GksuZH1P4QumaDkY+RZetAM4/xqwNqAR0MNulsgZmVwvGSWGn8GViFJ21vSggSENft3sZpBi2vQvPS2pEnQvdnLNh9ihUpwCnqIdZj3tSrDUdq4s1f7xZBdt6JkJwhwUoYvK9TWRtg8rrcZKXy8+8wLd6clFDI1GgI0SwpeTPe/RP+3Zu3f6wydL8oQqhyx1uCiwgkBdUTQ1wXzewrrAwD0bSVDqEFgxAw+qabJVVEODfevlSC0ZaXRozu+gTzRir7znX6peyb+vMHNVAvUb1ptTzZDa9M7x2HGPcx8WYA0wB5MYaBH4iV5r1RPgFoHGokb+NRs065u30f1uW5KS6OD8WvEruquAu2LTHQNFtvZyzOpxRngzoOAB4sQoWxvbvokmO27x9pKglnBHwvjshunImTPrv8DKbwruTfl05tQXEGEwiTk0zVWB8NB5vfBCuvuXUTFNd35Lb2JAWcFyf/mXMLj1Oq1LKq0smjBWYIWZpf9bbZGOzAKknZgmwD1CPx6MFkv+ldF0qkfQsK04YYalZ9na3nO7IKRfTR93Bn3uteMFQ9nyXEAdgoSIZLXQgOfKSzlqQdsHrJCw8rr7sCWpHE7ZcOGnTF6545xXAjaC4xLEoGISstG97/2Mb4udnw0F0TdDHz22j8eVm/7aysa2PLCd4+oigyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(426003)(1076003)(2906002)(478600001)(5660300002)(6916009)(4744005)(316002)(2616005)(38100700002)(4326008)(36756003)(8676002)(26005)(8936002)(66556008)(66476007)(186003)(9746002)(33656002)(9786002)(66946007)(86362001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2M0K2tNWGFKZ1RQNUhjUUF3aStzQ3RzTXhES3o2bWFRU2FMbzdCUzdWVU0v?=
 =?utf-8?B?Y1duUm1UTmV1bTZ5bDBHTkhScU9ZVjRJbEFkOUlJUXI2NkZOc29hcEtSMTVq?=
 =?utf-8?B?OU9Yc2xVUVhuRmlwVlpnVkhScmsxY2RBMmdZb1J5ZG83U2ZhVWRscFFPV2Uw?=
 =?utf-8?B?UzhZbnV0aFNwaWR1bU1OU3FMVGhVREh4WGN5c01tTW4xNVNpRTJZb1lkUXNz?=
 =?utf-8?B?SkthWmRlbklMdDIwVm40b3l0RkZHRWF0ZmlPOU5RS2toQ3kyeExKcCtiK0Jp?=
 =?utf-8?B?OWNPZWVodUtuUkFsQVdLdjlPdnhqZnNzQkdqSVYzMW1MeXUwb3JZNXRVZHBB?=
 =?utf-8?B?QS9DcjBIcktkeC9pQUVuVzJ1YnQ5MDFnOE4vbnQ3M0NuSlVIaXFLK3Uzck1m?=
 =?utf-8?B?clF4Q2dWRDFJWGZtMkQwdUpWeExOK2ZjUGFxTHhoMUF1ZVVOTVR3UmJkenUx?=
 =?utf-8?B?bEZPMXozd0o5cDZBTEY3OWFFSjlZS01jMVFxS0JPRWJMUmNJS0RubjAyaGJo?=
 =?utf-8?B?NnJJU2NRZWJKRmthOWdGbE5lUDZGRzB6TmdRUmw1QWQ2K2lpOXJXYlVjR1Fy?=
 =?utf-8?B?TWU5VitxT3BLYWZ4MzUvVmNvY0R2NVZWUDRTUS9BVFZ3QTlONGx6MWs0YVcw?=
 =?utf-8?B?SEwwVG02VmVHMmd3cE4vSjZ2bTNQTmw0ZjhubXJoUVBIUUI4bmZBbVZqbXFS?=
 =?utf-8?B?MkFyd2F0RHpXRGpJUDVaOXFGb0c2N1ZPYjdTUy9XQU5XSWlrUHVyYTVkV25t?=
 =?utf-8?B?RDRuTFJqbTFaS1BXNkZpLzJ4YURMeDZqa3U3M2Vyb3dSUEorUGpLc3FReFhS?=
 =?utf-8?B?L3I3bkpHVWhPNjRPRW45Zy9PMmpEUzJuY20ybHRaS1lOK25mMS9SaHQ4RGhB?=
 =?utf-8?B?VzdsNWRVcmJaZzg1ZFBaMTQ1TTF4QVhvQUljVkVQTXA1Wlk3anU0RFpwUU9R?=
 =?utf-8?B?bEVWdVBTT1plak9icGd5UlY2Mm1nVnFRRzlXMkttcnFaU2k4Rmd1dEE3dHNk?=
 =?utf-8?B?RjNwWU1lZ2JGS3ZQZTJ5KzVwRU5Bc3NYaG5DTFJGdTg4ZFUzd3locHZuU1Ra?=
 =?utf-8?B?ODExL2MvQlAyeHJZM0lsVkpDWW1kQ3RoTkVtQlIvc1B6bVJJTEVHMXQzMVNp?=
 =?utf-8?B?bStWTFdzb1RSdkg1RVcwelh6OHl6aVJGdHY5aGthYVJiMGI2NUc0aWwra2tF?=
 =?utf-8?B?bFlrTEtBWW9nb3gyeDYxc3NlSk1xUENudnU2N3c5Z0RiNnV5a3Rhd1JmUWxv?=
 =?utf-8?B?K3ZQT3JJUkFJNnNEYXJhV3g4cWs5L005RE9BTEM0ZGJhOGpza2ZXMHZmdFJv?=
 =?utf-8?B?YURjd0ZsU0tvWVVuU2NMbThvYU8rTWVENjFkZEVYSW5EdFY3cnNnME1MRUsy?=
 =?utf-8?B?RWZBY0dybE4rMU1YTEdLd09EaVV5S3gzOHhTdlZJSWRWdkdncHZocjAyalpP?=
 =?utf-8?B?N2pOMExIT21va1hOK3RGTUMwYndtaG1qeUZucnpMQjlCdkNuelJBZ2piRkZW?=
 =?utf-8?B?L3hZK2ZUT0Z6ZkVma0hQMFdrQnBUbklDcS9mV20reGswVnRQOTJVRzI2RHdk?=
 =?utf-8?B?WkNQUmNWUGNzeTcxbG9wbTgwZXpFdXMrcHVYZDdiOTJOSnVlc0JtWm84NW50?=
 =?utf-8?B?aENrSEhpQ2laRENweldJRENXZTJjcS9hdENDQVFJT2VKVm9NNFZRWFVEdTFO?=
 =?utf-8?B?TXpwY3lPM2Fub3haR2FsU1dSbi9OQWxGZ29DWEFrL0hIaDErUThiVVF0WHBy?=
 =?utf-8?Q?G4WwE44kBJE39rVnEgzkko+RCTMaJWuNAtFIhnp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ecca56-fc7f-4bb4-42a2-08d947b9eec5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 17:56:55.1197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rrgtVw17BwyJtSezivgfmV1tEzfHDHrDME9t6HtxR9o74ceEHvdPt4RQtB3BdhiI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5270
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 05, 2021 at 11:41:54AM -0500, Bob Pearson wrote:
> In rxe_mr_init_user() in rxe_mr.c at the third error the driver fails to
> free the memory at mr->map. This patch adds code to do that.
> This error only occurs if page_address() fails to return a non zero address
> which should never happen for 64 bit architectures.
> 
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Reported by: Haakon Bugge <haakon.bugge@oracle.com>
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> Reviewed-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> Reviewed-by: Håkon Bugge <haakon.bugge@oracle.com>
> ---
> v2:
>   Left out white space changes.

Applied to for-rc, thanks

Jason
