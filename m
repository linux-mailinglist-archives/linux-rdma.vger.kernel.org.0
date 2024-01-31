Return-Path: <linux-rdma+bounces-842-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5060844711
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 19:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65AFA281014
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 18:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDB412FF95;
	Wed, 31 Jan 2024 18:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FIg/FsqX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B36612DD88
	for <linux-rdma@vger.kernel.org>; Wed, 31 Jan 2024 18:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706725568; cv=fail; b=bDWvJaDkDclNTy+h3NgwyR2ouKVMMQY5jL19+VofNpsSKD7unIvy0ajaAV1JG73qVYwP3W9u7Ju3mSdjU16QX5qEB34UORyHS9vh+ICDlNlrlUDY6AhYGxEHzP3STWicLGMoRl/U8+dfbu2NpjC1vUBFQ3p39hzkzc4Y443oN7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706725568; c=relaxed/simple;
	bh=tLFQqoTzBECvhVY/rpfDUBj416AmBK5YMp83qrmXRco=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vu2Kqz54zKdb7eZbPxA2NQnQLcBR+g4+Ko18Nb3Yb0TyOBq6IUPPZNC9a6fq/G3mVYT2abXeo1zGbzL24GXrHlf6U7ItIU1QLdTfPDBRVk/6fH7r2gu2B+a/qc+vDk4OAeKiwxv8W68DnsdYZn2FUWBa36l7X7xUpOIORzcUaAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FIg/FsqX; arc=fail smtp.client-ip=40.107.95.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4cNhQn9Dadz3TYg/ZOlG4f5fyO4gSm8QvidSepOyxygScOytrFj2WdwvOpM2+yTdCOl2DnpcMS6uNTr2b7I4dVbAGUSK+diGlIk/SQHSAMEyeIKrbyU0inpdBTN9Ztuq8vlgD4wljAZJ1VScNfbpcn3hPz2qwv0XASkxoHunoBdJ9SlsOtqXiNOhyVF/2u1bqARrajtaA1l1MCiZ2E9z/SYZE1As6U4MZEzMeRP+6i8mgWysdcuh9+15+XDkKyDW2+RYCiKiN4LodPKu2xz3plWf2GSgBbuN3H+IM7acquNabXhN97Vzo5jXom6ksKReG9sHIlWamDIn3hde1Mmlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLFQqoTzBECvhVY/rpfDUBj416AmBK5YMp83qrmXRco=;
 b=h0iPQiZkhcjZdjS4KMFb8zMS3kjrzVqCBUGrqV8Kxlj5eUdvr+OKioVlYoMt/nDDtqm/wxDcA7lqmWcOkETITrMxUIZLnDKg4zsG3L6OyOQuVdQr7ZlGQR5kJSOrPK1F0BYgOYHZ0wQcB5ZFpsjmHflI7yy2h0Axa0yHvXYKlSnnJjE38qWjM9Smf9zMd4LY6Iec+v2DO+ipgvDI/UikpPK1vK59/1+2u4QKn2/fqEljAVrQi4Zms/QD2CXSTdHA+lTjlLz9j0MoF6N9dbbgwi9XVUzLjuSaUJWGMA/DsXNevcW8Cqb9VluMd9UXwlUnXVLY3LOgPzqdVEqOZMJv9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLFQqoTzBECvhVY/rpfDUBj416AmBK5YMp83qrmXRco=;
 b=FIg/FsqXzWRyuap46vw6OCh89PoXyUbOHnyQq6DWHiWvu3nrnnFhAuiuOjkE1P8JDEoacQeQnDuLduGgmH649x885um7YqMPXDJKtdjxKzBHEkWsod9rKZkab5ExBc428cfoV4Rhqn+uy+pDj28BIRaXPdqMT2qqsRYyPAzGe2Wp/sbVcay7Q5sIk7L3XdtTRGqltk7gGldfgoBHFp42Py1ccu1UsEZtsrwa4V41ujQ669ZSbRABQ9OFZVRTgL3ZNb0k4wobkJFXEqBN3AhXoJUOeTrIxeNs9DEYY6zLWl/iwGswYMuYjcwfrGci3RSp3rz4ljaOlIQM6EyRXDJ2VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6084.namprd12.prod.outlook.com (2603:10b6:930:28::7)
 by SA1PR12MB8987.namprd12.prod.outlook.com (2603:10b6:806:386::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.8; Wed, 31 Jan
 2024 18:26:03 +0000
Received: from CY5PR12MB6084.namprd12.prod.outlook.com
 ([fe80::3e6e:c7c3:2618:2b68]) by CY5PR12MB6084.namprd12.prod.outlook.com
 ([fe80::3e6e:c7c3:2618:2b68%7]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 18:26:02 +0000
Message-ID: <d2b87494-bfab-9f97-870d-b3b0e4fe7d51@nvidia.com>
Date: Wed, 31 Jan 2024 20:25:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH rdma-next v1 5/6] RDMA/mlx5: Change check for cacheable
 user mkeys
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
 Edward Srouji <edwards@nvidia.com>, linux-rdma@vger.kernel.org,
 Maor Gottlieb <maorg@nvidia.com>, Mark Zhang <markzhang@nvidia.com>,
 Tamar Mashiah <tmashiah@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
 Or Har-Toov <ohartoov@nvidia.com>
References: <7429abbc-5400-b034-c26a-cdc587689904@nvidia.com>
 <5e04d7a1-5382-179b-968f-97820e376129@nvidia.com>
 <20240131141810.GH1455070@nvidia.com>
 <25276919-9544-5af0-51ed-7ce5e6b8edad@nvidia.com>
 <20240131152331.GL1455070@nvidia.com>
From: Michael Guralnik <michaelgur@nvidia.com>
In-Reply-To: <20240131152331.GL1455070@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0059.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::23) To CY5PR12MB6084.namprd12.prod.outlook.com
 (2603:10b6:930:28::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6084:EE_|SA1PR12MB8987:EE_
X-MS-Office365-Filtering-Correlation-Id: 14f1694d-fd68-47e8-bf14-08dc228a1497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2By44E8qs5ri6X65CChlGFow9b+T7LrzrYmZllteUvTQ4iC1DyWWrUG8IQNu+K/H+Bqle6C/54FHAXXXwCMWGYjzO314z8pX7gVxbFJL+cFmhy/nP0/Cb7PQc2xXPTefjBLTZtAkaQhQ2JmSyLPCn0mN9XGXHFvWHDeCT2PYDGUl1Q7YMmpvxI96L61qHOszfKnniOrbc1l1+yJ7MqEE4LaYQ4ADW2PuNbiOZvGGQWzhSNKF1tDGkeXPPhryr3jKt7Bwm/chdVopuWIMmmDQF4xDmrIS71xgj5V69jYNbj6phM9rGU9rpqlUVRpRHVX76GMEBBjELMRbEwHsxzI6rmXnoW+u+ORglXFr6diBro7U5RP9vhLOlOUb4dSw7CwT/oEUnIZZXNFsxCd+F1ccrZLltSlONgHVI6JkMYLvMn6o7mvvtb0hPlmUSY61mYiv7veys6KRjc2sg4dggb+pludK6GHJocinDUtwA4omgU+Zd7+DnBS227eQfm0zqJBRXks3SvxHtWG/RsUOxi4dAK4O3E7D5bfF3I3UysTgpj2qul+DO06AcVHRJStUD4b+nR3nPzGfwmv4C/ay35RG5bFQkZU/GMDc28EtFNqZTOzFNTwqg2giGlo6wwTWcZ9wE7VDmR6/y79pEPq1VmRPmg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6084.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(39860400002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(6862004)(4326008)(8676002)(2906002)(8936002)(5660300002)(31696002)(86362001)(66556008)(66476007)(37006003)(54906003)(316002)(36756003)(66946007)(6636002)(6512007)(38100700002)(6506007)(53546011)(478600001)(6486002)(6666004)(107886003)(2616005)(31686004)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1BweG14OW1mVDhnN2tOQTZYRmNzcWM4dXdvQ3ZLc25QeCtOY1ZZTElHN0lV?=
 =?utf-8?B?dncrWjZDcFp4c05rTHM0MFRoQWhPdFI4OVFTWXhvcEIxSnJmcWw2YTZweVNj?=
 =?utf-8?B?ektKVm1Sb25RKzVkaWJNVGhTaGZIN2NRM1VtMzVydUZucFA5eU5UMkxTNDZ2?=
 =?utf-8?B?MzZZSkd5VkI1bGx6MWQ1MVB4UHQxR2RvaElUekRoMGFLVzdSNk1DTVFpaWcz?=
 =?utf-8?B?dUhsOU9VZCtxYmdla3FuZjBSNTl5UmRUVUpQQzFSMnE3S0JmUjZrN00vSzlB?=
 =?utf-8?B?MVpFVEk2OE9oNnFlbFRwNld2ejFsWFBMUXY4T0RReGRMd200K0JOUHE0aVdF?=
 =?utf-8?B?dm1QbHFYV2tEeVBTSDRxTVNtODJiS210QVpacTRxellzN2NUVXhpVHNCMnBj?=
 =?utf-8?B?RUYxbThuMGRhQXpEMCtDWFlLVUhGb3pzZUxlWEpTVkVobU9lcFJPcTNyakVl?=
 =?utf-8?B?OGs4QWtta0dkNWpiVlkwV2ZVK1dSYkM0WCsrOHc2RUpmTUlRTHAva2pYSDgx?=
 =?utf-8?B?dU9nbFFJNzUvQ0RNZ1NtVjBVQjVHczZ2VmRxa05PQ1NTVmRkSjVab0lONXU4?=
 =?utf-8?B?aUJ2MXZKWkFieG1mVmlDWTBpaDRmWUlqeHRKcTRoVXNQbzhERkZ6dGdSQzJ6?=
 =?utf-8?B?YUNnaVlVVlMxc0JnaW9uN0ZWNWwzMWhkdyszSWl3Z2FXcUhHYWc4R0RiMFVl?=
 =?utf-8?B?OEM3T2xxZnREa1hhNXRkZitrdll0cCtvOXNQK09kTnZtOVRPYkdnNlhnWlVN?=
 =?utf-8?B?TEpZd3BEcUY0eWxSZ05kTE1SY0l5dDJCTXd4OU1LVFVGcWxJY3l2OXcyclVJ?=
 =?utf-8?B?eVRWbk4xK2ZUcWlacnFWOGhmUVFFbVZZa0VES2dZK0ZKT3pnWTVYM1hLTXM2?=
 =?utf-8?B?UnJtOUVyMUY0YVJPbnMwSm1ybHFvT1ZaeFloMThyUldCdjNNckVicnJzQXZN?=
 =?utf-8?B?T1czWTNvT0RLblBSd1BEbXUyOVFsOEhpYjV6aGk0OXNzRmF0bGJTU3hPVW9U?=
 =?utf-8?B?RVVGQURDYVEvRmwwdFJkZnFON09LZTZJYnNiaGpKOTh2cGttcUZNY1JRT2Qy?=
 =?utf-8?B?ckpheDVOdWFweU1YMWFMdkNrdytWS1BqRWU5YzZuUzg2R3g4dDBwa3RDVDU3?=
 =?utf-8?B?Zk1YMHduMllzK29kSXJUeHJ4T0hBOGxaZlpzbGNZQXZXK01udzZveEhwWWY0?=
 =?utf-8?B?Yk1YNm5oeU1wSFJUVm4wdHM1eXlyay9oTkpnUWs2Uys3akVnTVg5ZTExVy9j?=
 =?utf-8?B?M20ySUdWVFVlS25BSDdrWnA0SGo5WTBaOExQaFAyNTdQaHFOVmJvM09QQjRS?=
 =?utf-8?B?OHVHcjNuK2V2TVhSWHVGeWlpam10Nm96T0dDQkhMcEhEWVY5Y29nSlFhdXBN?=
 =?utf-8?B?L21NZlc3em5IamIvSThZU0Q1cDdiMmt1VWZDWWkrVmNGTXpNOW1WQkVFbzAx?=
 =?utf-8?B?Vm1Za3RPTHhkd0VsTExzUmJqVjRBZXRGaVdFb0VMbE1MWUlOTUkvTEtjL2pz?=
 =?utf-8?B?SEtjR1diQ0VwM25ubnF5aHd4NmpIMlVMTEFJT1hGd2VhUEt4ZmZFbmlmOVJ6?=
 =?utf-8?B?MnZmSlNWZGNzYXQzbmNnS2p5dW9qVWJJc2ZCZEQ2Y1g2NVZPdCtQWEhuZkZS?=
 =?utf-8?B?K0tUZlEvdGRTSUpkZ05YUnZSaG9Ub3IxQWJUelA4YW4zUitKR0twYUNGS1Vw?=
 =?utf-8?B?bWlGWnRqcml0TmZLYnB0OUF2SVFGMFdxcG1aZHVJZWlZWDM4ODdjaWVLYkI4?=
 =?utf-8?B?eElzclRrSldQcjFjVUtKNWNubEhqYU4yRFI3MHRYVEhMSjJEWHVYREVsQXJ6?=
 =?utf-8?B?ZkRxekRFbjJxeUJaSkJCN1pSQ1hqQkIrWllXMzZEdDA5YThSR2JoRCtTVVpS?=
 =?utf-8?B?d0x2Uk1ieGU1d21DSUJyTlo2NUR5RDFSek1ZS2FHb25ldzF2aGFpNjZBakcv?=
 =?utf-8?B?OWlqM2JjOUhzcVNwQmVzWS91SE5wMElCdWhiVE5zb1kzRUJmYjZNTnZYZGVS?=
 =?utf-8?B?TmF0R1B4RXU5ejBXd0JxOGdZeThJNmZyWDg4VE54S0VzZWNCanBPYWdUYlJ6?=
 =?utf-8?B?bFJpUWlqV2g2QlN2dEVCYS9SVG9vNjhITWdKbmRiZWNxVVgwVkdGWGFSRHd5?=
 =?utf-8?Q?yXYZ9N34U1Di4uIFpvYgCZKhg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f1694d-fd68-47e8-bf14-08dc228a1497
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6084.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 18:26:02.8850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5TGOZxkaJugZucPgedRBpUFuTsCFyqJDraxtGTfPib9OWRiNMaAAm2oGtTycoXWSizV7vPWPdLu/nU2zb2j7TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8987


On 31/01/2024 17:23, Jason Gunthorpe wrote:
> On Wed, Jan 31, 2024 at 04:35:17PM +0200, Michael Guralnik wrote:
>> On 31/01/2024 16:18, Jason Gunthorpe wrote:
>>> On Wed, Jan 31, 2024 at 02:50:03PM +0200, Michael Guralnik wrote:
>>>> On 29/01/2024 19:52, Jason Gunthorpe wrote:
>>>>> On Sun, Jan 28, 2024 at 11:29:15AM +0200, Leon Romanovsky wrote:
>>>>>> From: Or Har-Toov <ohartoov@nvidia.com>
>>>>>>
>>>>>> In the dereg flow, UMEM is not a good enough indication whether an MR
>>>>>> is from userspace since in mlx5_ib_rereg_user_mr there are some cases
>>>>>> when a new MR is created and the UMEM of the old MR is set to NULL.
>>>>> Why is this a problem though? The only thing the umem has to do is to
>>>>> trigger the UMR optimization. If UMR is not triggered then the mkey is
>>>>> destroyed and it shouldn't be part of the cache at all.
>>>> The problem is that it doesn't trigger the UMR on mkeys that are dereged
>>>> from the rereg flow.
>>>> Optimally, we'd want them to return to the cache, if possible.
>>> Right, so you suggest changing the umem and umr_can_load into
>>> is_cacheable_mkey() and carefully ensuring the rb_key.ndescs is
>>> zero for non-umrable?
>> Yes. The code is already written trying to ensure this and we've rephrased
>> a comment in the previous patch to describe this more accurately.
> But then I wonder why does cache_ent become NULL but the rb_key.ndesc
> is set? That seems pretty confusing.

I think we did it only in the flow where we destroy the mkey to mark mkeys
that were not returned to the cache.

Do you think it'll be better if we switch to marking this explicitly?
Add a flag to the mkey that marks it as a cachable mkey and we'll make this
decision per mkey creation.
Then we can stop relying on the value of other variables to decide what
goes back to cache.


Michael


