Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A522416B65
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Sep 2021 08:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbhIXGEc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Sep 2021 02:04:32 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:60061 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244163AbhIXGEa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Sep 2021 02:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1632463376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gb/7nOXnAIj7NbgygdjjJHafcNNHekQV7ZkrVGYe32Q=;
        b=jKEEKAi7+LSGjcPKRc/FAL8nkQLPEK4UbrVJOHJSMpl0fyT/TW8kf/TLuQB6k014Afnthj
        YJk76QzdUFz0x3i4BHypDgL2yB8Jgv8KIdPlHwSTGLVMGAKZNoHB2Tkub1FOKut5mzm51w
        RJ2043tyBoj4EqieqZ5STLaKTVnIotY=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2059.outbound.protection.outlook.com [104.47.5.59]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-17-ydT4WwDbPm-zdEG6SSJnjA-1; Fri, 24 Sep 2021 08:02:55 +0200
X-MC-Unique: ydT4WwDbPm-zdEG6SSJnjA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhxzjbU8G+24GwFAtvrM+5PYuWeR94YeIvg7FcYJhYm2NYy1ZYXM/JUZZdlkkrQCvctAgTs9/NnTGMXp3v0XR7DoR8o01sPJl8bWHDujHYnBD5uXhnTHJaFrjh2Q5Li2qPb1kvSThsYLw8GsIUF/9kEtXIDjPo1WVU0wJpHnKmoG//pvsc3RtGHOTD1J9/hRIMWDu/kjMwOFhUsnFnB7DYXcxyJtyEAMuuPB+PkgHNsa/luoZlJ6+bdm22KgrTVt490lxSwPZFXfWfdUvx4ll86vbqYb3RznsY+hqCsgjLBH9j/kE9g2zAKksu26ZyKbAWjkyfFLEW8vBpn3s0fYTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=7JKV2pVgZB9lgXXBaMhpresutp5sC0EtXpKq1Omd9nI=;
 b=e6HRKbehzjh5Jia77ik3cYywl/yNmhI5eIE46W5M9xgkrdcLxH7TwCWpFy6REcc8nbMb11AB+NArS5ImVxs1x9tCRCyxWjl/0deKuQJW5NM6pwIZkoZyFEn0YGFw5rOt87LPRvKsUYUZCIQQaYe0cuQDZrvPzdol3kyK+6ys2khTKsUUa7eKOM3L+FbrXgO9S8FENGBjbJfbNHprxEmXGktSL3ZXgxML9L8Vc0AgDNDVIpzlMTNUMm9YtTRkoCcQUj/MJvBvPudOOpfId/1KEcGa36PkU+N6giOnyn04Eo6ud0+eTwN/PsQSdvudmZPkN9SRYF5SBoI3/WZcTjd2mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7193.eurprd04.prod.outlook.com (2603:10a6:10:121::16)
 by DB6PR0401MB2423.eurprd04.prod.outlook.com (2603:10a6:4:4a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Fri, 24 Sep
 2021 06:02:53 +0000
Received: from DB8PR04MB7193.eurprd04.prod.outlook.com
 ([fe80::cdcf:9094:49c2:8a2f]) by DB8PR04MB7193.eurprd04.prod.outlook.com
 ([fe80::cdcf:9094:49c2:8a2f%8]) with mapi id 15.20.4523.018; Fri, 24 Sep 2021
 06:02:53 +0000
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org
References: <20210923215746.GS964074@nvidia.com>
From:   Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Subject: Re: rdma-core and travis CI
Message-ID: <cab3a248-717c-9b6c-28b7-c767d7fe5f15@suse.com>
Date:   Fri, 24 Sep 2021 08:02:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210923215746.GS964074@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MR2P264CA0051.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:31::15) To DB8PR04MB7193.eurprd04.prod.outlook.com
 (2603:10a6:10:121::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.2.127] (86.200.117.157) by MR2P264CA0051.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:31::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 06:02:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5855fc0-7761-4973-24e8-08d97f20f292
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2423:
X-Microsoft-Antispam-PRVS: <DB6PR0401MB24235D28892F24D47B3C0445BFA49@DB6PR0401MB2423.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hbv3TOrPPR+465FfroZV1zQlgEWJYtOjLZpO1DK2Ez50dduXy+mIAMxskXWFz94K+lG4dZ9665ZNuKujHJ6/Exvul1zi4KvrYlSh0kIphwo9tg+wif1vOQFfOJNF9WYoDPcdO0YnWwIBDXECgEsN6a8t8GiII31RGl4jcJB5WO9OUjkdAwuQf1rbgtXY6yW6F/ebLhMVbhLmXJNXOEhgD5PPzRv6ao9IUeROvqF4ssAihgXsJ++OkmyHrp+PXgbpoUS8bkCcgHw7KxjHf245OOEY4pw1iB6OdtpkrUn3Y5c7GnYy++RuAPGKWOYzdTGan+JZp0qVFUJDb/vRG4mUgX+3lPJ8lEmOGaXIWMkQucV7x9x53JwvCZ/nUyY+7AEmi53FGdomp2zu23JczGHQiq9qUQFCGLp0HEK4kua0PgDT7vYfOW96QOpZP+C5wTCeQCpWwnXvgrnk/U5AKeVFpr3RtnFF2QP4a2WYO9eO1QQmlsnn1/if6D0ysicsJSNgJzf3Qs5kB3kBjnDkGClDaDxCwnaP8853qEbGwo/uByRiZQioaytnCZDiJkndZevDWLafXSjSo9J3MUFcOCBka++2SsAsBtGXpkQdfJf5Xy++pTFi+X9/HAQ7MwXbPxyPhlVsTXbllRQb0kAfFcbUfZWyielSAtH7jOi4MgcMZwP+mhJ+Yds7oZJtMGkpK5z+tYAYDly3MZAG9L4ynrT4ByGiXVeOUxErBSStNp94MOBJl2TxRDEtVzLXOgraXgoklojRr7Znmhtqs1ZfbLwodnygtO45KpzCy2+tzaVg/hmEbgxbsgFIgbge2Dnt5HgR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7193.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31686004)(6486002)(5660300002)(66476007)(38100700002)(66946007)(66556008)(16576012)(36756003)(110136005)(316002)(2906002)(26005)(4744005)(186003)(8676002)(966005)(8936002)(86362001)(956004)(3480700007)(508600001)(2616005)(83380400001)(53546011)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kFZhrNNOEu+U5I5owaAMWTE3UCy6713E8yl+YaUMzMNaJvpk8To8Y5yxyazW?=
 =?us-ascii?Q?Gjh5yW90Z2fpJHnNfcucd9+99LzsmFwXJhB43dy56ZRZzdaH4QMaARlZ2dT9?=
 =?us-ascii?Q?QC9Wgk/A3sh4VRELhKuNoYNDZ2z0saihBNuvKQtmi1ursCX8FGD+KsaAyRbh?=
 =?us-ascii?Q?GrVYtLvkFkexDwLBbm6S5MwR1u+qPTWBisFTH/gn1H6bi//o5u8+9qy4fmEM?=
 =?us-ascii?Q?Crh/A8T5n2ebI1osRXnQlAIHPwq+FUPnQ9Ya7yDl3VLJxlgIgnpih9wVJx6y?=
 =?us-ascii?Q?cJYoqELLgF8GMSd0FZY5wjSdfutsbNOEaXWCfLaE1akHTEsnFGRuAFbPj3nd?=
 =?us-ascii?Q?/3yEaN6m3NyturYtFr0pR32/FSS1GP43b/1C5/g+46VkxiK8cajbMoJHhgrb?=
 =?us-ascii?Q?woezAPLU/LBxWhVNv/TsuNFZzaXZEj1oY4JT48moG7Vt1QHI2B3V1YF17msZ?=
 =?us-ascii?Q?CJgHiCCKziQcSQTV1mvDtjCsQase0JL/QsbAICpt/dUiINi6GBste0oyC4nI?=
 =?us-ascii?Q?UXjOi0JE8m4Hv0NaZf0KZKanSxoLcidTU2XPf7PS/RP93VqJ+Z5xq6wnelWM?=
 =?us-ascii?Q?Fhw86keFQPBU+4eyszeklskwFjd0P8ixV91kdy9D9Rnd46tg6wcQMPTwqTHL?=
 =?us-ascii?Q?+3YVl5bNziUiVm8X2beHnrXFGDWWzu2Wq6lf1id+gUk4kQqF5ex8A6Tm+PAi?=
 =?us-ascii?Q?+KTM7h8SSaPrzEoewjyPXDWem8CywxsKmCpBukxPLjRUOtid2jQ9z6n6qWsj?=
 =?us-ascii?Q?zI+5cuYKCFGjYYdynw9/B09BGfjWYiJ5y2Y7WbNS14w1fnqvGz34/MuWgUBq?=
 =?us-ascii?Q?UwakQsLcveZtjD48EOG3U9PnJBRUC1Ba/ItJJ5lAk8pMOZCt81XHov9QZOLl?=
 =?us-ascii?Q?2jdqUrQtvmWPoGITJ9IasnXYb6L4a9jMWCVfq7X3ZHqj5v37ch47bVy5ejGk?=
 =?us-ascii?Q?Ju7jO7IldYMkYeq47WX+rIwPIJ2GdtYvf2vtFO48I/pxsa2n7hyrH6NwoWpY?=
 =?us-ascii?Q?TzDMPvziWxl8HG0pMXnHG4tqx1prAvxKJ9FLSQJeA/flO3bLCbmAASquU02Y?=
 =?us-ascii?Q?zjYVLfLb5sxe5ZJ/0TqoGydmGnOHtKsRsvP5tE3hGW4m9GhPUdi3L3Tpwzkq?=
 =?us-ascii?Q?Tk+O1wWpOZpuoeTfWzITcaj0csHjpQ0shTF51sd/ugubo6mBRaBZjum4rGdm?=
 =?us-ascii?Q?upVI2Oqthjo52JFhIvzzCq8q1B8Bd6CBsQ2il/O8awngNVKv1O0XCGfF2mgj?=
 =?us-ascii?Q?8o3OMuY0fquzB3TBqgoC8uh5I1yPacPpqJNxJ+ochimbU1/xEFWiukuJX7LS?=
 =?us-ascii?Q?fDrVG8LC6vw0rbfaFGLgp5W/?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5855fc0-7761-4973-24e8-08d97f20f292
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7193.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 06:02:53.5727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kdf6P2JJjxEBMpnrwGlAeHBmOoudZQR6fRefa5Bi/3K0u0xe610LOVVrfY5nmlNMHT4NQk6bfwPnU5N/TbZaBDQyrdh9AvJFWsuUSFjr3uM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2423
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 9/23/21 11:57 PM, Jason Gunthorpe wrote:
> Due to the security issue with travis, and the general fact I no
> longer have any idea what we had/have configured there, I would like
> to permanently switch travis off and revoke all its tokens for
> github/etc
>=20
> The only thing still using it is the CI for stable branches
> v17,v16,v15 this all all 2018 vintange stuff and I think it is
> probably OK to let them go at this point.
>=20

All these branches were retired at their last releases:
https://lore.kernel.org/linux-rdma/046b9cdc-881c-c02f-57ad-f929a5b8803f@sus=
e.com/

So yes everything is on Azure nowadays. Feel free to drop travis completely=
.

Nicolas

