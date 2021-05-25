Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D875B3904C7
	for <lists+linux-rdma@lfdr.de>; Tue, 25 May 2021 17:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhEYPOK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 11:14:10 -0400
Received: from mail-sn1anam02on2068.outbound.protection.outlook.com ([40.107.96.68]:23557
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229894AbhEYPOJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 May 2021 11:14:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjXItuVVpAsq8kkk4wQPzNzVuKqfJclwZ9+M8pRobEl2QJkGsymfZFiEJany3pxVnUCTw/u/ul2RLwyf/QropxtDJrUqM3+EhwQWaaMyH6dlYhdH399v5sOBUOrw66z85g9r5U1LDG50jkIJmiz08mgRLGfrh9FUbvdacykdg+kSuty4RlzTvghFHbfYedL6QhXWmjuwAXxMm5iAk7627udhsP6XyGPZhMgi9L0ykLM8kGJhl9b4YptKVcxLCJe9QgEaCwtsM5ao1Bqj0ieVbljjCRQxbocm02dPUjK03doE8f49HeIonBLOdffcTohloQ09MyZOusu7F95M52dYUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZhyHNqNy3DdNblEwhwqcg2osHSYJ2Y8LRyq8bK1gx0=;
 b=W3lQLZiGzNfIYMX8PJ9sCpuyV67+y+hRJt0YziCJmcDmlikmCgNPZgrBjMnmFyD9H79Zji10MMIbDs88H4Sdi5YaE4kWva/3W5ATPTODiB/rm34oXvl3W3/KGY8sRxNt40wFWZBsdKaRc0AoPSKPFHSVTasuTJ5dfqVmxk6sw1FICa93RVFy2T5C0t+M4w5AFIptVDZ7rX9/h058fnb42D9NCvxq0SmV+Lc/SeBCXZcqmsTB7iejOb33PR9Ju7QY54vy9rwfC7YSVWd0+xfPzzlioRL98dFht4O4PtOHYFB6p9qbSpCRrcumYBMKZKlZHCLhWGGIp/dNoUWnbz3Ekg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZhyHNqNy3DdNblEwhwqcg2osHSYJ2Y8LRyq8bK1gx0=;
 b=JmSB+pUgd0YAwFJl3JTL8FuKqh3ME0KaDmC4WH4vXmKtR2p8Rx9MkLyRrRYa8AdhHMQOA51ZMPyAXzSSDzuKxO+4s/n+AJOxNkTIQA6Pw3fkyifsQmQ7flAJrsvGhDKN1DNSie2BgtERxe2In74iyydMIv2jP04lGxBihhUkER5MR8aKbztZSZnSyTV1K5kYF1Ouc+NRWuYkcQ9EmBSlcxBtEdjwRhoGylvqm4SV3JeIY6TOc+oUW/sgxv7A4sqydNjGr3NOB+etAbt4IxMKZqIH4wh0YnE3z6znsnCtFxkG4IRcdpibQeeB2FscNaJwfTkobuFpI2Rm1+yC5uUEZA==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5270.namprd12.prod.outlook.com (2603:10b6:208:31e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Tue, 25 May
 2021 15:12:38 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.020; Tue, 25 May 2021
 15:12:38 +0000
Date:   Tue, 25 May 2021 12:12:37 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next v2] IB/core: Only update PKEY and GID caches on
 respective events
Message-ID: <20210525151237.GA3433349@nvidia.com>
References: <1620289904-27687-1-git-send-email-haakon.bugge@oracle.com>
 <YJeTp0W1S81E5fcZ@unreal>
 <0E229A2D-178F-427C-9F66-221439B63395@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0E229A2D-178F-427C-9F66-221439B63395@oracle.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH0PR04CA0111.namprd04.prod.outlook.com
 (2603:10b6:610:75::26) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH0PR04CA0111.namprd04.prod.outlook.com (2603:10b6:610:75::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.24 via Frontend Transport; Tue, 25 May 2021 15:12:38 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1llYjV-00EPEh-6V; Tue, 25 May 2021 12:12:37 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e794487-d243-4f00-39b6-08d91f8f88cc
X-MS-TrafficTypeDiagnostic: BL1PR12MB5270:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5270701C6D4F253EBECC3D54C2259@BL1PR12MB5270.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6xn5v3GgwIm1PgrCi1VK6aQjK39PICA9BrFWgi3qRualEqUFNKNwXVuIKbRscEocaEkAKi1QTyPIcC6KRQ7/a8bHb36l7KgOpeGIOAHS6ocvPz7OICIglCI87e4br5Lql0hC6jfJHq/Ekfnra2OdC+5D8DJvqEUjz2NH6iFQbjW0AsrPALgUXZUa2AzQqjeZZpgKtAuVqZXe8l+U8GlRA+oRmp3PsB5JnqNS76GM3W5IPRcmRSjUlvqPq0LfdVsaQkfugOSHmxxpPTnhCEJhye5bcKrXljcP02zXvCBNDgqqnlG0N74YnLfzTTRlXC+2i2XPXLnyccIBTic38MwQjT3OQd2B26eyxHEiXE/5qBk5cwWPst6EOFyrW6QLFyQjLLPFtx9aUzr/2RWaXPmmQ1pfkX7YpjaHRx3UH1eOpU6LyVxFOs7upzc+P4yCeiVHpXdymrGu1Js3BCa3QPkNiFNn1VvVFDjNE1kj0JMl8rnb7LOLy+ibqGbk72MJn06vyl+EVDDgC2j0AJXToPf/6FqXpTRh/1rIUcqUsGmVdqQJt3wgkEmrpxjGuMDhZrGBrrgBhLPAPmb1V8VJhUwNyCYwaaPJMzSTT3QAGP//N8Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(6916009)(426003)(38100700002)(2906002)(9746002)(9786002)(1076003)(54906003)(478600001)(186003)(66556008)(53546011)(66946007)(8936002)(66476007)(36756003)(8676002)(83380400001)(26005)(5660300002)(86362001)(33656002)(2616005)(4326008)(316002)(66574015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OFg4U1NxdlhSNDdYVG93SVAzdmw0NWs3SmUwT3dnUktmYmhaQWVkSmVYbWty?=
 =?utf-8?B?U29ZSVE0bHR4a1ZTMUp6bVNJc3ZaZml5VU5kRDhZMWROUllCSldxaXFmTDhh?=
 =?utf-8?B?NHJqMERra1lPU1Y2aG1FTkhuWHkyVTR5bXlzTDk2REtBSXBHdW8yS2NsMUFO?=
 =?utf-8?B?cVZGWUNlWHJNMlRMYkgzaWExeE9HU2tiMGF0eHBldUNxbkVXZlp1VGxidS85?=
 =?utf-8?B?bnRQZjlHM2lySFdWeFNUT0FoNFdwOUlOMUhpTXNHQXFoK0xNMXpGQXY1Wis4?=
 =?utf-8?B?ZEtURkJISjZjY2xSRzBQUmFIUXdvNlZZODhEQmdGdkxMRmNoVElyeXpTZG1E?=
 =?utf-8?B?UkdlWnBPc3ZQN0paYUJ0aXFtRFBGUUc2OFJmSk5XUURIdm5LTjJsS0JsYmFl?=
 =?utf-8?B?NUtJNGY5TXZnWEZjVDJ6Zi9PWGcvWk9EcFlQMlZRMmNGZHR5ejJ3RGNEWTNz?=
 =?utf-8?B?NXNyWnpFTklEZE8rYi9VRGFzNkJSVEcyWmVOYW41cktSSk1ZMGlyUFFJVHFH?=
 =?utf-8?B?ODJLdG9HbzlUNk5RZDFDck9ZT2h3UUw1ajY1eDJ1QkhiSldLamFscjZaRU5Y?=
 =?utf-8?B?VjRKSVp2SzRNcGNvb25FZnNFekVTNWpKQjE4emp4MWxFTTRnb3BKeTBNOTVw?=
 =?utf-8?B?RnBiWVJiellhM0xWRThkWC81cExsZ2diTHRhb2tyZzFLcGNYcnVyMTBmc3Fi?=
 =?utf-8?B?aDkwK0hUdVhFazd6SDMrSFVXVXluZ3RUa2J5dmJKNXdGS2x4OXhRZ0svYVl0?=
 =?utf-8?B?aitsTXhtMFNUZ1prbkY4UVBYNFpyRHIrZHVBTTZMb2x6b0J6SlRMUXhucmlV?=
 =?utf-8?B?djBoZFN0WnUwamN5SXlXeklHQVE1eisyRDRrWWdYWFcyY1IwbDFFbmtlTmpM?=
 =?utf-8?B?T25PTUdEYmJQeVc0RWUzcGR3c3ZibFJxWUNobUVVN3V3Z2xWOUdZTlVKNzlH?=
 =?utf-8?B?WHAwb2phYlRkc0VlNFd4cGYvTklqZ0xTWjU2N3NpclpDaDBFSkQ5Q2VNNFg4?=
 =?utf-8?B?dEVmcWJ6ZmpjanRNdG53V01FZkVsa2lzc21IY1JZQy9vYlA2akxzdmRRbWlu?=
 =?utf-8?B?R2dsMmF3TFRzV0RId2Q3WjFiQkZaYlpkaE95SDdTRWlYSGQra0xtKzI3N09j?=
 =?utf-8?B?U0hXSitKTnF6bW5Kb09helBGdFBnM1FiSXBJMnVBbEdCQ0pvM3hscW4zNTlD?=
 =?utf-8?B?U2c5cjhUeXRiTmI5dTV3bnhFM3AzbjZnNTAxNjhRNCtZaDZiTHJqVGZnWUJV?=
 =?utf-8?B?T0g5UWtiU1JZdHg1WllFWElVdFJ5aWtLQnNVdWdJMWJrQWxlakdvaGEvdG1y?=
 =?utf-8?B?UmtVOXd5M3gvemFwOWlPdHF1QkR4VFgvQWF4SGk1ejc4eTBLcFZJTVlwNE1Y?=
 =?utf-8?B?L0NWZHZLUlpuRVh3KytlMUU2bHpQNXllV3FWNGNzNHVTbVM4WHp6WlUrYUY2?=
 =?utf-8?B?Zmh4T0pJeDN0NHJsaUFaZ1hCTEgwbTlUcCtMUDl1eDRPZUNmMmtiRjhNbG8r?=
 =?utf-8?B?VlFPcVo4NFNUcm52Wjd4RUE4b2lrcUM0RG5hcUdSaVRqN3FHUVdoTmZ2YkFw?=
 =?utf-8?B?VTF5aExNVHVIcWNQNFdnYkdKWjZWY2JlSExRZ241WTMrUE9rM25xVTR6VURv?=
 =?utf-8?B?K0R0ZUVBWkdGTE9xRUFvVmNSU2N3blpRNzhTTi9zTmF4WFpRMW1EcndaZjIr?=
 =?utf-8?B?bXErVkNUaEUyQXp1QVA2MjFZZXhySXBJemRpWCs3d0tqSnc2L2lONHBVNjJY?=
 =?utf-8?Q?bOFV3WgzmVwZIDDEpX2TkQI4xfDAaQ0gHGC4EHv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e794487-d243-4f00-39b6-08d91f8f88cc
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 15:12:38.7447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: okDAkeP8ffJbQKGMDrE2hWHc1Y8r1cB8gKW5ZUEIXeFsPCvcPhjxHgPWkq+kmCT4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5270
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 24, 2021 at 10:26:16AM +0000, Haakon Bugge wrote:
> 
> 
> > On 9 May 2021, at 09:47, Leon Romanovsky <leon@kernel.org> wrote:
> > 
> > On Thu, May 06, 2021 at 10:31:44AM +0200, Håkon Bugge wrote:
> >> Both the PKEY and GID tables in an HCA can hold in the order of
> >> hundreds entries. Reading them are expensive. Partly because the API
> >> for retrieving them only returns a single entry at a time. Further, on
> >> certain implementations, e.g., CX-3, the VFs are paravirtualized in
> >> this respect and have to rely on the PF driver to perform the
> >> read. This again demands VF to PF communication.
> >> 
> >> IB Core's cache is refreshed on all events. Hence, filter the refresh
> >> of the PKEY and GID caches based on the event received being
> >> IB_EVENT_PKEY_CHANGE and IB_EVENT_GID_CHANGE respectively.
> >> 
> >> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> >> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> >> 
> >> 
> >> v1 -> v2:
> >>   * Changed signature of ib_cache_update() as per Leon's suggestion
> >>   * Added Fixes tag as per Zhu Yanjun' suggestion
> >> drivers/infiniband/core/cache.c | 23 +++++++++++++++--------
> >> 1 file changed, 15 insertions(+), 8 deletions(-)
> >> 
> > 
> > Thanks,
> > Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> 
> I saw a handful commits being applied for-next. Anything needed from my side here?

It doesn't apply please resend it

Jason
