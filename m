Return-Path: <linux-rdma+bounces-944-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FA184C54F
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Feb 2024 07:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5BA41C25929
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Feb 2024 06:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AEC1CF8A;
	Wed,  7 Feb 2024 06:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YO/Xr7MB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ECD1CF83;
	Wed,  7 Feb 2024 06:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707289169; cv=fail; b=Tre7gxvqTHFaUaRjskCsLoBuyKwbkYGBmS5FLdetZprAXqx8RtRhGR+5gXHjFhlJz8vSjkiAKTMVXaFYkKAgjI/yiAao+wl5dSGgTXJfEBbsODB+lMNXh9Xbr8SnVvAsNCM7JDF3vLvCpj4R1B05MD3pHHclvCr9/YkONl3JGZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707289169; c=relaxed/simple;
	bh=QMDI5FabLCLRNj/B0PtjQttCQrktV0Bs7d1jTQ/U6WM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RYCvXGjHtwFlw9fXjwovXytncpbfwtEzUTaShI4DGZnlOzqkAtF2JpbUy6GjxkSq4APX8lebRfk1n5aJ5zLkw7Wg34XzZ3sE3G0HBzu7Fk76xnJrlfiMPiL+EICMHliBZ4u41pK8ND7fR0jdItN/HplHI9F4/xNswF1VWKoC3lY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YO/Xr7MB; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWTVWb2aJf9bx1gY9IVu7i2vhFrqc98cLanGPTFywUT8kUKlKxQCqGyOTc5G/XvqIxdQBxqPrWJOgmgI5vJnnO/XRJtXE3Cjo0/ToarttewjOF3FsuH/2bt3FdMLPsmZMEzWYIrBmiJkVZOjDQWNZzBm6AMbJmueC705spGpe1FOPQdD5eIyC6cEJFWqaoSrWObNYe1qb4eutG8pYoXgSuxPgxFc3L7ReSwMUb6ROoPyVznemIIqoTOTy0Uw9PG+coquGywy7wVeftnojz9+DGs6NI4okZkPKi6WRDhxcYcF8H9yo7eR6EBzYrBjTnZotgmroR/esC8R6koAAVSQug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cz78NVS5D47nogtUdgUrqoOMWnCAMfRraEHzqarZ5U8=;
 b=QgGEuH0VprBAqALthx+SrRvWaTOnxJhumYKOUdM+Wg3S42Eby20scCq8KJzx0U94Vnpn7WU5trYhVzdMw1Vxz1RtFtbgmw78LLcRM7pc5u3vuVBxq7LfvpD1usUCXHziDFG/RJSnC5xlQtaaCD9xVwsMMsuuSpb2poilHYbt47p7HiKDlY/EnujSuIb1CJJctwPtkJ+MWSWAYgJ3K83KLhosLlGazs9SRZXrtejZcrmGttcqyCAHGA32TjbKn1cn4Q4FNEZolquygtSKFklzug6NHxnOJxED7DlKRH7K2lLmzgg36QPijgyQNgZdmChhjXqBIL9IUwkWrOeoxES2Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cz78NVS5D47nogtUdgUrqoOMWnCAMfRraEHzqarZ5U8=;
 b=YO/Xr7MBiegsyOUlklI6bPeK3IZwCklS+ZwZVusXVpuXC59U50xv3tkNU7qYpWUmp4SnE0FmQBPHyJDZ0mJB5YWBrSPguwXueqhzrwyUrikwrc7N+NfYtNKphh/6atCIp17fUJC2A9WSrImAqy54XWmJiGT5iAudCQimRptjYoX62rQGv5xf9iM+CQ/GqNy3koTA+RLEp8UqZTob/7YVLAfsUQXWrw28zId7rTR+S0yDG0GLyHm0tGcQ8/cjOYaNdwtG0LR6K/RrJ6MIhb+k46ye8NaH2uP6CjmAANetnlJWLtxBczhPgY70r+RA0VojfO02gwrIuuQtxQ2pCfJk0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) by
 SJ1PR12MB6292.namprd12.prod.outlook.com (2603:10b6:a03:455::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Wed, 7 Feb
 2024 06:59:25 +0000
Received: from DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::bddb:8ace:1d63:205b]) by DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::bddb:8ace:1d63:205b%5]) with mapi id 15.20.7270.016; Wed, 7 Feb 2024
 06:59:25 +0000
Message-ID: <b3c595d8-b30a-41ac-bb82-c1264678b3c4@nvidia.com>
Date: Wed, 7 Feb 2024 08:59:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] eth: mlx5: link NAPI instances to queues and
 IRQs
To: Joe Damato <jdamato@fastly.com>, Tariq Toukan <tariqt@nvidia.com>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, rrameshbabu@nvidia.com,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>
References: <20240206010311.149103-1-jdamato@fastly.com>
 <7e338c2a-6091-4093-8ca2-bb3b2af3e79d@gmail.com>
 <20240206171159.GA11565@fastly.com>
 <44d321bf-88a0-4d6f-8572-dfbda088dd8f@nvidia.com>
 <20240206192314.GA11982@fastly.com>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20240206192314.GA11982@fastly.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::15) To DS7PR12MB6288.namprd12.prod.outlook.com
 (2603:10b6:8:93::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6288:EE_|SJ1PR12MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ae26252-30f3-40f1-fafc-08dc27aa520f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9LfWv37KLUycPxRieXkhibw/dwe1vNYVKrDQH1WJcvYA2rUWz02hhh4V9lHKuVIeumfYUv/h3upOjL1A3fSmSEBKDF46c7PnkR67g6lxo+xyhO7/0ECjkTIGat3maswIBdnC6JXNU1B10f21vyIobHyUW/eWb92AnxIWDK2Z7jKFbkV5HGpgLUfv/GKxsYZryz6ZryyC4+BBLXAbBoJ1158929iGMs5I2Ua27Bs03ecp4/mk0rb0vqJ1Sx9uaVufd3N50KQ0eOQ6S/CedoMwrSuawiuAuvOdPinLtBC738UxiyEDNnSq8y/To/aS2FNxBy5DRJ97hgWIcMaSXWhJDBRP/MfNFnzgmVcaDkBryYh99KVIuUsqhpg5wYSHv5rR/v+03hPKgjgIVQ93//BeJP70VVECGqSbeqIofveP87s5/jRqDVQb1sdWnWG4TL9t2ZhAXJifgnlRzgxhrKDaOyC1VOtABagr9xQV1xh4L4GRDCfzGJqb84nqlIpUetBBsJCur7TujTR5tIDvuIvwRo4YcEkbCTW9uheiQB8fdzTOiXPyf+9IcT3J4ykkwr2oqFWu498m2S8aLrrx7t2/KVFeZ2qO9Oge2R666yKw0neVjEwnaCDlWwNqewgFBI2PUMHRpwp0864suncKPvLqRQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6288.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(316002)(478600001)(7416002)(5660300002)(66476007)(6636002)(110136005)(4326008)(8676002)(8936002)(66946007)(66556008)(6666004)(2616005)(38100700002)(4744005)(6506007)(54906003)(2906002)(53546011)(26005)(31696002)(6512007)(6486002)(36756003)(86362001)(31686004)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWltNzVjdGt5c2Q4V2xJRHVkYThSa0psZVFYSy9JMEFGWnFkTkZiM0s5dEJk?=
 =?utf-8?B?Q29TbkExZUJEQWswa1hEZzc2bzIreVNoOFg3R1dhK0FJM3ZWV1RNTG03SFky?=
 =?utf-8?B?STF0MVUvY0U5eWJBTkkzc0NuSGg5ZU9ycVp2bVA1ekxqWHVlMTRyeXF0YWNj?=
 =?utf-8?B?ZTBmbFZENG9FNDRrMUdJYnhUTmptVUJScGtaYU9OY2ViMXdIUmlzdWF1Ritz?=
 =?utf-8?B?UjA1TkVPVnBscGtQMTI1OWhoQXpFc2tXaHpLNU45SE9wdVdnRHY1ZjY1ODNo?=
 =?utf-8?B?QzFVUFBJdGs3WStCZlJick9OREhDRlV2OEFDbEhGM3VITGt6clJTajlEMmhq?=
 =?utf-8?B?M3FyUVEyd3oyTmRjM3k2MmdteTNZK3h4bnJFRnZGSFFXc3dTZFB6aTErcHZF?=
 =?utf-8?B?MmJZOWJ2S0JTY1hEUVpMbzMzR0o1enUwNTA3Q0VVWVd6dVkrWFBNMGZIbEx1?=
 =?utf-8?B?djgraTlvM2h1RktPbXdkN0VzWEU3cWN0UnlNcnlRaXFaaXhjZEZSVTJoN2tB?=
 =?utf-8?B?UlF6RDl3QTdhbmppRmtuY21CbDI2em1tZXNUMDFnWGNuZ0QxaDQ5cmc4bkxt?=
 =?utf-8?B?dVMzUkRLdU8zNFN0RUFhRFRDS1p4a0JFWFRBZEZtdXBoY2paa1h6MzBUc21K?=
 =?utf-8?B?ZlZpc0N2RHNMaTNORExBZ205QUFVVEVkNXBmd1RDKytpZ3lGc1hnSWlQVjVI?=
 =?utf-8?B?MVB6bDdnQUl1M1VVZCtiNHhHREl4WDRTdityWVpuREVjN3JPYjdFZS9xL2Nq?=
 =?utf-8?B?UTJCY1BWSVdXeGlyMEVFajlFZGpYekI5VGRpbWRmUXVlc3gvSm5UV2hiRkJN?=
 =?utf-8?B?bnZvOU0rakRsZnZSQ3AySVF0L0s1QXczNmYzMm9XK0VHR0VCREZVZnlyVVBl?=
 =?utf-8?B?YnhPL2FBOEQrcFRpaUthMHVUVlRlSm5zaS8vOTFqdHhIMmNCbmpGRWVuR1Ir?=
 =?utf-8?B?SWFrSzhmMmFZQWhycFhhazYxRHBkWnlaVXRiaGppeSsyYmk3aDlOQWYySE1U?=
 =?utf-8?B?OFo4aDVIZWR3c3dPZ2w0MFUwSTNzUURMbmUxL0srWHFxazFDSm9pdWdtQ0ND?=
 =?utf-8?B?WjJybG9ETFZoSG5oVExKQzAzRUxSdDdMTXorYnpkaXpEd3N3Qjd0M0M2c1hz?=
 =?utf-8?B?ZlpNNmowRnMveU40Y290WHg0ZEVGRFduM1Y0N2R4MWpIY3NIcitLaGRGUjFO?=
 =?utf-8?B?enoycDNHUkRpOG16K0lvQ1J5dm04djBWUU9tM0M3MjdWQUhjcTZGOHlCdEov?=
 =?utf-8?B?STh4emVIcUNtemlaSldyaFd3bVlvSXEyU0Q1bEhNNnAyTzZPaUV4V0J3bG1v?=
 =?utf-8?B?bkpBK25xM1Vya21zK1lXSEUrOEtmRVJzRlRFaGZ3a0xtWFJKMUJJMjE4SXFK?=
 =?utf-8?B?MjZyUzN5Mm0xUGJWOUJZckJ5bHArSU1aNWdobnBFZVhNNHptQy9qaFRNQWMx?=
 =?utf-8?B?ZUpZT1R0VElrT2ZuNXpsUFhwZjlDb01vdU10bitvLzlKMVVnM1FhTlZyaVVT?=
 =?utf-8?B?TUNPd1o5RURmT1Y5SVFZc3RuVkdkRm9PUXhzWXViUEhYRkhmQkZ5VjI5ZlpT?=
 =?utf-8?B?YTN6dThMNjRkN1hYMU84SW94MFg2aWVBZVNiWERVdW9uZ295VUJwSmhKUExD?=
 =?utf-8?B?NHFCZUlpYkVHSEU4VEYxT0I3MXVWdjFTZ0tZVnJZaVcwbWlveWlQQzNnMUZT?=
 =?utf-8?B?Vngya1dyUmlrYkQwVk50N0R4S2tSM2VXNGJTVm9yS0RsbS82S2FhZGN3bXN0?=
 =?utf-8?B?RzlEMCtjR2JLbVBCcVRGMTRDUDlsQ3ZQTk9JamRxQ3hENUM3WUtmeWYwcmJn?=
 =?utf-8?B?bmdvd04wVkt0Q2xFbGd2TjEwS2RlRXgyQzdzQmc1UmdIcU14UzVZSnFacHVq?=
 =?utf-8?B?QUZPTkNvbGg0Tkp0ZklneEdMbWpiVkd1UmFrallZcVJqNStqRmVPTnZlTEFE?=
 =?utf-8?B?WHBxekhHR1pZKzJYMDMwSTBsTzN5aHRwRE5pRzFjNTdrOFBRdXBOM0JpS0Vk?=
 =?utf-8?B?dGI3Wm5IaTZtZ0lFZWh6ak41SkNnYWt3S25BVjFlM2ZQZTBpa3dHR3NlSWl3?=
 =?utf-8?B?M2I1R3NmbWx3amNrZVpGKzRSamp1SnpCU2tmRGZWeVB6VWRVWkZwL1A2QzVR?=
 =?utf-8?Q?KB7M/KNlnQ4zlgws0UbFqiep7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae26252-30f3-40f1-fafc-08dc27aa520f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6288.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 06:59:25.6792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wkCy26JsbkZwr1Mb4e95InldL3ntZXbb5egeeLJm1capz0HkU6UVpaKamsw6ukPT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6292

On 06/02/2024 21:23, Joe Damato wrote:
>> The per queue coalesce series is going through internal code review, and is
>> expected to also be ready in a matter of a few weeks.
> 
> OK, great. Thanks for letting me know; we are definitely interested in
> using this feature.

Hi Joe,
Can you please share some details about your usecase for this feature?

