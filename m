Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948E2474EE0
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Dec 2021 01:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238381AbhLOAHb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Dec 2021 19:07:31 -0500
Received: from mail-dm6nam11on2059.outbound.protection.outlook.com ([40.107.223.59]:29953
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234512AbhLOAHa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Dec 2021 19:07:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NukhenqpNZLPAq4EULT8yzWfiHbYacOhQZD9qN9o/1HiMrDsn6aVclMpTYfQCMpnZE2BorbVEBLMAyS5453SNQ1GwD6v/6rDu8U+z5+1H5c+hoZIDc42KSH8QSw85UluMYiJo9xVQAIxEYk58Lk0kM/8BjfMvlgV9xp9+n4rHzNEODhivAA5S8FMmBrgGPtsoGnS4oLkZg54xz93CEp7GrXm/VL7nIrr13omWNOoj56ipUTIUa9ql58xDIvtd/j4jqzZD+4FIgrDwi2d4EDytcH7kjUcTrBe2NpnMws7hmqNhtZZSbD6L60bJW8zpNNq5liMeOXAxfkVEKZm97hGEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiQjmrTOD2HQ6mjeQJ8CfvHtetAbUl/XEXkiMsmIcOU=;
 b=GA8bZVMVBIXtYTZ0IwJ1yBA4AV6nhPxDa0rM82r2ihnH04La67ROKQT5NrQHyL23f5EutnONjqwGeMhCQK54dAAKj2g/na3eCKpD/4eETzKzBLSOHhpVQL+vSWOm3GQvFAIWyvHd8myAvSNqZgw9dP+Ji4ZPwfBrCQQKuBZs/nEbamoqgf8u4/Ct/Z5eFXBny7YWD5NIXaiM6/927P9IMIoUivNsL80xsEIeF5F/K0QZVXM89UzjnfTlIJdzOlRoSQEEIG6ddqKrDnz9SrdFlzc4cKZJJtXrEdeyFod4MAX93aCwdVt/4DHAxJxJ1d9zNyQtsAwz7jGMkFSnQ/IcWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiQjmrTOD2HQ6mjeQJ8CfvHtetAbUl/XEXkiMsmIcOU=;
 b=GFYCTc3BjsVTpXXi/u58brTnJlOqzpYqz0BMmPlM4Vw1JIWJnGbRVNX0L03HGsnv2ovC5PNts5keKKKvsn/cBtrsKarVVvUj1QudFsgwWO0ExKFfv1QdYjsF4jR9iyLz0Z5krvfNdDX3KZPLT3+cMY/Qj1I5xvGL6ZadGEdF0wboOTEMo/95YD1/lA3OPQ76+8EWqw3nQwpJWYAL6U7bVCp58u4ac7AS/Mm+XrSDDlaxv3qMYRQ7EbFd2NlfOW4vWMvpDoia7ReUXrywLfTd7mybaB28USK6V5MLQ1pivLsV08Jb0a1moCqy31Zn1ZMhtzRlHYVgqRuxfNoBNvC3mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) by
 DM4PR12MB5168.namprd12.prod.outlook.com (2603:10b6:5:397::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.14; Wed, 15 Dec 2021 00:07:26 +0000
Received: from DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::218e:ede8:15a4:f00d]) by DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::218e:ede8:15a4:f00d%4]) with mapi id 15.20.4801.014; Wed, 15 Dec 2021
 00:07:26 +0000
Date:   Tue, 14 Dec 2021 20:07:24 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     =?utf-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     dennis.dalessandro@cornelisnetworks.com,
        mike.marciniszyn@cornelisnetworks.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/qib: Fix memory leak in qib_user_sdma_queue_pkts
Message-ID: <20211215000724.GA979369@nvidia.com>
References: <20211208175238.29983-1-jose.exposito89@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211208175238.29983-1-jose.exposito89@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0375.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::20) To DM6PR12MB5520.namprd12.prod.outlook.com
 (2603:10b6:5:208::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a786b45-5794-4a78-9247-08d9bf5ee0a0
X-MS-TrafficTypeDiagnostic: DM4PR12MB5168:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB516844779312D9B9BEDDC91FC2769@DM4PR12MB5168.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AIhEOENlM2NxCjbk9GTkSvT0xlFZN8MF/8DSwZyrD0H1tmUb6iK3rwjApXrDfoJovniCPM2QuGD1qioMKIgQdS8oC1ZOw7d0eFmq3+VWO2hHuuDP3KlxNP7GfnQpnwUTFNubzVeHrtjSlSPoPtDYvtZl0teI7nurUVlj6bNlJzuw72549Y/gkGH1tcTTv+4t4t8UgByUX84wgxHB0ShFo10m7dx2Gin+Qu64+ggxRL9URe2WHCT5+ZLSm/xNg8T620HY/iurukaepKHTFZURSefiwqtUfkoA8hPk4+n15Zspb4Jc8YfjyGobeksZiZwt1gHYIUP649cWR/ECZkvMVqgPrHwrM2f2hCWZkP64R4QJJMdUj1QzjjMrealD80bHQzCpLKPOW2doPvHW6AicpMfGoBIcV5wTVvKg9uTeKjfPhAZkgKuHJ/NYst/VgpTJlsN1huMSefb7Ix5Z/ioprLPZrCds5DXVqOvg+z9l3RUlNlx6vpeYgHIR3/NV4FKcd/k8ziif4xB6VIe33G9kkUbV9kSXk1Oe94iLH3tJGn4grYNVIlmWbrHmSMKnDX4rSTjvQrR8iSZH29W5fYYejgnARVdxskPrOlX7nzCmgs6BvyOgDkJRLUhVTo8ECBamAjbFtRl8qtQwHMGBHcTB+4/C6HXOIPLFsIUB8uL1Yz+3kNnf0dmDEk3Z7GASDOvDiKIaMl80+sb99M2Se2ELqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5520.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(6506007)(66946007)(508600001)(5660300002)(36756003)(1076003)(83380400001)(66574015)(8936002)(33656002)(2616005)(2906002)(8676002)(66476007)(26005)(186003)(4326008)(6512007)(6916009)(66556008)(86362001)(316002)(38100700002)(4744005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVdSSjBnVVJSdFZRU2NPdmtlM3E3aEN3V0NVaWl4cHJHOFNxZFFpdDVLWDNy?=
 =?utf-8?B?SzFvbnpFMFpMeXh6aXJJYTZzZGYwVVNKZ3FmVjgyQTIvRDFJcEFmbmFIWVQw?=
 =?utf-8?B?dldJcGhxamRJaU00ZmFsVGQ1SFZFR2crbjg5YTJSV2d1ZER3QUpONWcyZXc5?=
 =?utf-8?B?QlhXNVMwNGxxL211RnJjVzZ5QlU3bFJmbUkvNVd3L214QUwwYWxMd051WE9V?=
 =?utf-8?B?YXByeXE5ajRmWGJSVUd5d09aNjVnRWptWVNyNXpwOVFxaExZSkdNcXhBeGkz?=
 =?utf-8?B?UE95M2VyYTdTN3pQUkNTS292VGRtVFZyTVY4cHkxQ1A0RGphMEU3TmV2dWtY?=
 =?utf-8?B?VlRFZjEwak81TE5DanNMQ2NFSjFkYnBIeGdKV21jbDZ5ZjZTMWZDZTdmc1RW?=
 =?utf-8?B?SmdVM0hrR2tyWTZPY3FiaGtITlR3RkcvMllHSkxlWllvazdpWTE5eXYzQnJL?=
 =?utf-8?B?alBQaU8yVXNGWG82bHVsTFpwd3RQeXhPR3Fza0lCc3hxM3JRaDVMc2hzYU44?=
 =?utf-8?B?c3dyMlZHcEVVZTA3ZE9Zd2t3Y00rcVY5WUJoTHFjek03NSthM3VvZWJNSU0z?=
 =?utf-8?B?SmJmYWtkUW8xQ2xCcDNFbzcvVUxha1ZsNk1IWDRBS1NKdlpUVjZNOEFQYkpo?=
 =?utf-8?B?Wkl6azBNaXFndXFJWHNZZ1c2MkpnblI1dGJJN1lvK1hwbXFiQUNZcmpMTnl6?=
 =?utf-8?B?OERmRU5vOW5BRXhCelJoS1RqZGpsbjRJNnZLTEU2OHdmNFh6djlFVStNRUVx?=
 =?utf-8?B?TmhOMzBTZm5wWEIwcVU3Vkw2VUxZc1FXaFg4eUtkeTRMNDZSaXFIdERwU1pa?=
 =?utf-8?B?YmY1VHl1M3N6RklOM042eHRSMnIva3FJdGRTakJMODJkaHYwNG0xODE0dG03?=
 =?utf-8?B?TG9zSGw3SnhoRXlLUXRqdktDSTUxNEVmd25oRXBEQ0pPekM0TjRocXFJNGtP?=
 =?utf-8?B?NkVJOEJkNFVnNjRrSHoxK2svK1ZyclY4NEdhRm54YnIrWVl3aFpMdDh0RHhs?=
 =?utf-8?B?WHJMcmNJdWhmaWd5M0xRLzFJaFhUcy9SaFRScTRRQUdLc2tNbmhPT3B6cTds?=
 =?utf-8?B?NjN0aldybUVhVS9GNkZaYm5BVzgvd0srUFUyUUxCbmdFL2VOM0U1bkJVcEE0?=
 =?utf-8?B?R3BpSnRrc3VLbk5oU0lob3hBU0VNdTBpLzFJbHVCNGl3VlRGQ2VZejZqbDEw?=
 =?utf-8?B?L0pQVGtGWUFOQnVTWjRtZG93T0pYcXF6RS9jcmF5TWdlRjd6Vml6Y3Z2K01h?=
 =?utf-8?B?UlVaa1NRME1tODZpS0UwRmhTOEx6anF5Y3liNVE3TGd0MHpoSUs2N2FIZS84?=
 =?utf-8?B?VXgrbUFXQnFMaEJibXBFdDAvaVVHVTBEem5QbHpMaGMwaEEzVFluMlliYmRx?=
 =?utf-8?B?M3VDMXRhcW5TWnlFZEkxTGw4S0JCQjhVTVFqWEFQRFcvbXdRSDBzQ1FOZ3pk?=
 =?utf-8?B?R2xYVHA4TDBFczFlVTg5NnVKbFBSVzdTcWtWUWhwK3RqNHlEekRmcCtiSkJo?=
 =?utf-8?B?cG9YQ2NDakNCVWdnNFY1bzdYUmZwS0dKUkRVQTY2Y2xqOXVrbG5kZ2lnZWgr?=
 =?utf-8?B?VkgvakRuREZNL2VqZXVteU44MmNHN2Z1TGNtbDVjcjc5WXdWYW1BOVpCMndJ?=
 =?utf-8?B?UklCN3ZGV1hjMVhvaW05d003MEtsZHJmWjZhMlY0bUMwLzVwbTMrTXNRUkdv?=
 =?utf-8?B?aVZ6Z01maXM4YVloZnF0dUtrTUVESGxPelJPTUw5cUxPU1gxQTFYYjREaUY5?=
 =?utf-8?B?QjdpZHJubWZJRzJ0QnF5LzRucjdNR3VqVFdFVmRINFB3RDlzT1k2aEdCV2tr?=
 =?utf-8?B?K1VGdUIyT2RMMm5JU3piZ3RoYzFGaWZJNytnSnNBOTZwYWRMbVBJQVRpR2w3?=
 =?utf-8?B?Vllpcm96NlBKQ1dnbDRRb0UvUkJjMTZqTldhZTJJWUFFd05Zbmd2RXdjam1x?=
 =?utf-8?B?VXllbkp4dE1HNGJtc0hoMUozcVBWWkVpOHhmbHVIaU1UM3RuU1BENGhoTkl2?=
 =?utf-8?B?YXRZUGovS2s3ZHM5ZTJPTHN6TXppbWFDWDV2VERlazdjRnBJZGJaYVlNdDJo?=
 =?utf-8?B?ZmhGZE5nMDVzODlLQ3JpaWV3L1NTVUJXZk9KVTllZHdHUjg5Rk93Z3hxZCs5?=
 =?utf-8?Q?N01U=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a786b45-5794-4a78-9247-08d9bf5ee0a0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5520.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 00:07:26.7941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fz5uI1wjCOivD3B29Qq+yKM8/p6/O3SaF3A81j02Q7TINGoS+rHeBO+h62A07GiK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5168
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 08, 2021 at 06:52:38PM +0100, José Expósito wrote:
> Addresses-Coverity-ID: 1493352 ("Resource leak")
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> Acked-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> ---
>  drivers/infiniband/hw/qib/qib_user_sdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc.

I wrote a commit message and added the missing fixes line, please take
care in future.

Jason
