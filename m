Return-Path: <linux-rdma+bounces-833-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 305B2843FA6
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 13:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC31E28EFBD
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 12:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0EB79DDF;
	Wed, 31 Jan 2024 12:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rU9UBTio"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBEF7B3E5
	for <linux-rdma@vger.kernel.org>; Wed, 31 Jan 2024 12:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706705418; cv=fail; b=C6N1QMdcefVJlr1KD85uV1SIUqb2hU2vl1LV50iKIC+LxL9Iq9OQCThCTbkKRP8duMqU2wiF1jpYODkcEtb5tgjijCf55uqdHrCf/9wrH2FUFAAqTvDdxfmO+fNyRB40SjlaxsOMuUoWBOK8k6pJjiFNmCZwvPlZ/3iqcrfd2N4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706705418; c=relaxed/simple;
	bh=ifQEsNZM6+ksLx4ZFNU/e84uZWkYjJmd5n2Oa6AoDlw=;
	h=Message-ID:Date:Subject:References:From:To:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=HjpyjJUL0rtN6gL3FmgLPFOy0B6Z/7aLqElzP0h7wwbtguR8/siQ7ITrlP55slQutgxB/+/7bYDG3H9JB0LIGh1jn/IegTcBmSq8ZdFwd3s4KydrwNbkfP4Sz1mkQwmuvWPWeCQePD3TNZHxeZ7Icz6SwVPn9tY0nnAcMbDY/Ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rU9UBTio; arc=fail smtp.client-ip=40.107.220.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LnbIykYMYtyjMKN8riooG0Ow1KwIJ1egRCJBvfoyoKptezHqcyJ5q0nwDJWv+HvkWZGSPosexDfzrAzrsv2whFEqwagH6FjZv8oHCHTtmzQ5IzimdNLnaLWb7n3qYcyrlfckaeCT2RuWlQFpNTcWm+7lrTkdNWVnAMhzucVgRwL0YAb2FjaGuW8SiDJ2C5tfAveNyskRPHo1fLfnb6YDCjlKN+f5hKnF+kAmEcvBKAgw5uTz/Ul3YFhJaJnbTMGlcOMEjEuVB3A0U82YDZnk6ThpUqENjq1gBdyXqFbJ+0ai09GqKP73/ray952IELvbBtQC2JUWyXyLzCoB4FqmRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qT9RuqCjfEE1yqyJtUJ3+pYpyWsI4tY7v/sQZRykj90=;
 b=Uz7XtpSCAd3gVF25l5LsC7VyMHedTbRbbTc4zaNm4qUCKDirQ5BiYFjaQ83adU46nVQCZhLL/NmixV05spl+UA8ufma0g2u7y/QSmSaoEWuPBGKi3PXR49G1wMiXOwVDYJh8QhInboT3jU5RUOoosmrq8BMOIga2EvDlc0A6Z8P5EZ+XwLIm/RjviPkw64hCvHklCXg6rjbL9VsQ+AlPm7VATGZdl3ogPnq/9k+q0gCOUXvdVNRjjoY5gGH2emk5UwBCCVKe6ETwCW1DleqPEcIm/PNiElHjns3B2Zpbi6QH+BQVCZwF1WhAje3mMc75o4iDg9+UYqQmLvtY599DlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qT9RuqCjfEE1yqyJtUJ3+pYpyWsI4tY7v/sQZRykj90=;
 b=rU9UBTiowP74GhP9CH4RETw0dDXJQ6dSaCCXR854UZ/uNqM33FfK1yffRQMqlJ4yfyxcYlozCiNLoeZF9I1QQ/Yb+VnZIYsJyhNUkzKmkOeQNMvs3VO4oHpWbbkP3Xr7WWws5eLsspZ2c8LbQOvcLV+F5M2FvKuH50P5/53U95IQz1kVbwVtubLJI2KJVrTaDVp7YWc+F9M8gmkwm6mJ39EaguIG926cBCfk52J9TG1azTGSauZjLhN6MQEwF6wYdE2M9eQ7Ta6ozmuwr9554i39c5rd5CJj4sBzvnBo8otocAN//J9oogu6qcEjjDVV0V7ceIMG+WP9YxrhTrB3Sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6084.namprd12.prod.outlook.com (2603:10b6:930:28::7)
 by SJ2PR12MB8010.namprd12.prod.outlook.com (2603:10b6:a03:4c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 12:50:11 +0000
Received: from CY5PR12MB6084.namprd12.prod.outlook.com
 ([fe80::3e6e:c7c3:2618:2b68]) by CY5PR12MB6084.namprd12.prod.outlook.com
 ([fe80::3e6e:c7c3:2618:2b68%7]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 12:50:11 +0000
Message-ID: <5e04d7a1-5382-179b-968f-97820e376129@nvidia.com>
Date: Wed, 31 Jan 2024 14:50:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: RE: [PATCH rdma-next v1 5/6] RDMA/mlx5: Change check for cacheable
 user mkeys
Content-Language: en-US
References: <7429abbc-5400-b034-c26a-cdc587689904@nvidia.com>
From: Michael Guralnik <michaelgur@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>, Edward Srouji <edwards@nvidia.com>,
 linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>,
 Mark Zhang <markzhang@nvidia.com>, Tamar Mashiah <tmashiah@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>
In-Reply-To: <7429abbc-5400-b034-c26a-cdc587689904@nvidia.com>
X-Forwarded-Message-Id: <7429abbc-5400-b034-c26a-cdc587689904@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0083.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::23) To CY5PR12MB6084.namprd12.prod.outlook.com
 (2603:10b6:930:28::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6084:EE_|SJ2PR12MB8010:EE_
X-MS-Office365-Filtering-Correlation-Id: fb496733-fc04-46bb-5803-08dc225b2958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BLexFIfQ2pW1urDF99LsSV3qGxGUQ+7EC+K/L/AFzuTHG70mY6kxS/WQbunfM2MwBnQiLqvR41AJy8hCHzLLAJDEdStVKeEAg0EOCCV8kGYJtHAfma7m5xpVF6yUGqzzyotWmW8bV9cRwa2ZnGypcIa6bxJ0RnnQfip/TiGagZRclVnppKK9A2wqkl3ejzGSHKT4bIEtL9T4QKn6EQslmlLG0+FXQzZVMyA+Bdl/ByuIdE56j2hFR9gXyUVt8fzsKPiHb/Uc9TZ7gOmlzEmtdmI2KDvukHFQsNtPkNvclpOwF9tqJeuZ0cVLvqNfk81meZuqUO3wctpj5P+RIXJIsVvPv75smP4KtvjlVKhRZ4qjRkoEYN5dM/JkcNxsI9/L7k56orQ6voGdhcBykZLDihKn2FfEFmfirmbbbReOlhqye2bRkuKT6SIAFZhjydZL+mVdBqnNfq/hYHdQgiGdmoH373ee9SckxvJ1s0hsnTX1IWyPoT6iPwGohgr52xKHrY9A+7xHyjs8JQ3++k/s12ZZ0/SU6wfqEtUMEC06m98HwpqNJ/df7m6HgE5tQlca32gaLyy+DSbMsRLOLv3IejZWYilrbg+An8U8aXCDtcNzsJBX638fAhEU1vXUuW/nebRi+RpKVtB95w0sf49FVQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6084.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(366004)(346002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(66899024)(31696002)(86362001)(41300700001)(83380400001)(36756003)(38100700002)(478600001)(8676002)(8936002)(2616005)(4326008)(110136005)(66946007)(66556008)(54906003)(66476007)(316002)(6486002)(26005)(2906002)(107886003)(53546011)(6666004)(6512007)(5660300002)(6506007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTROQUdaL3FvdHg5VWV6dTQ0MzNMRXg0aHA3bW9NNUZLYTNWdk8weHVGU1JV?=
 =?utf-8?B?RjdjbnpJY1B4ZXc2eG52WGFvSTYwckNvMjdmZThTR3VjOWM0eittbFphNHY4?=
 =?utf-8?B?SkFIbGFUbkxlNTViNkNIaHRXZlp0dDI4N1VZYTFVbnowWXhvWHhTREg4Si81?=
 =?utf-8?B?a1FhWHkyS0UwTlpFOHdPRkw2eDhicEJOVHhiSlFzZXB1dE40SXpYbzhhckJ0?=
 =?utf-8?B?eUUxUkE3V3o1VzdOcmRQR0g3cUxYNHcra2pBODA5dlZ1U28vaDJSNmF4cjVJ?=
 =?utf-8?B?NUJJeTdsNTdPa0hhM0k3dkt4OXJVVTE3Y05vWk5wVTZITmJVd1RnZVFoTUc1?=
 =?utf-8?B?TVhxemd5ZTdvZXBiVXNwaU5PTi9CeXZodms2SnFRMk9hZHpnVHc5MUdreUdj?=
 =?utf-8?B?WitDQ3VzQXdraWEwMGRCaXZsQ09IakFoS1Z5MHNkcElYbEJhRWd6eUo4a1lu?=
 =?utf-8?B?VUdKV0VKUldKZ1ora29tSXBPN0h2R0FhNnh3TkRCc3cxS2FUdHYzOE8zRThS?=
 =?utf-8?B?bFNvV0trbG5rb3BOcDZJVU8zd0hZN2x5MTVvR3hnNUYvMnBiWjlXcllXRUxV?=
 =?utf-8?B?ZVloZWFLcEJxTzBKcU1ndmM3YU1URGpzb0tRTmx6WDdCWGIxRDd1OXByNHZM?=
 =?utf-8?B?aGFSTk5oU1pVanBEb1hpOS9lQVQ4TFFjQkZxYk43dHdVR1pBbDhnWjJTdkhi?=
 =?utf-8?B?aGZFN3VFV0dnUXlET0JnRjU1Z01ER1d2QXlYM29HWEtvZnAvZ2VISkRybytr?=
 =?utf-8?B?NVFZZkdHRUY3Nmo4TEw0Q3B5Y3hWUHBlSDV5aDA0d1NCWS81YlNtL1lWaEp6?=
 =?utf-8?B?NjZnbTVrM2VqSUFVcjduSmQ4RkFXQkVFeXJLclczVS9DQ2hrd08yOGNuRnFE?=
 =?utf-8?B?OC9WZVJkclRpL0t0emdzZ3hNWnhzRmVrakFHMlltVWtMbnJ3UC9reG1mN0xu?=
 =?utf-8?B?c0tuYlY2TWNsMDJYajFIN3lMSnJQNElkWk9aSW13bmhHUEkvU0tzTFhCOEE2?=
 =?utf-8?B?TW1TQ0kyWmRQK2d1NWtLVGN3NFdLVVl0ckgwNG1XdU9qcVhaaG4valZvQStN?=
 =?utf-8?B?YjNOR2dMUDNhaFAySFdLOUpZOHh3emlQc21ZR0htSyt3WGZ3QTBKR0UxNG9l?=
 =?utf-8?B?SjZneldlT2dmRHZHaU1SLzFpTHcxUm44SzRlclZlZGZwRlBoNXd1ZmQrRWI3?=
 =?utf-8?B?YmUxSHc2MW5NdmR5Y25mSk8vRHJlM3BXMnY1OTBha1BzcGZ0N0RRQjE4Y3V3?=
 =?utf-8?B?aHJlNXMvemtLOEJCdEVHcVZTeGxoZ2ZjdysxM3Y3dXUvczRMaGtRT2t1OUY4?=
 =?utf-8?B?UHBjQWtpSHU1ZTkyNXNOd3Vjbkh0OVpyb2NnQnFTRStLSzNseHJDTk1xZStY?=
 =?utf-8?B?dTQ3WWtqT2hEUkFQRGVvczdnOWI0NVYwb3hFTzdXWDdoQWtKRzdNaFBwdW1B?=
 =?utf-8?B?bE5iUmtWb1B4UkYwYUhxT1I3VkVsQWdtRVI3Nk1aT2J4UW4ya1BMUkk3M0ky?=
 =?utf-8?B?VGlkTG94MW5Nemhsc1kzQWhsdEpSS2pKbVZMTFZiRmsvdXdpNTZ6TTFjUkh1?=
 =?utf-8?B?WGI3RytRVUFjNThJZFVJV3RzUG9vUVR4dFpBU0R3eVdyZFAzMERabzN5bG5T?=
 =?utf-8?B?RmU5VlhadWluOVdORlZlZHQ3d1pQUklaQ2UyVk5TM2RWUEIyc0RzaGlzWjFM?=
 =?utf-8?B?d1pDdTFKYzBuZStta3BwdTZWSkk5L3drU0hVaU4yRWtraUE0VlJrcUo1Njlm?=
 =?utf-8?B?V1hHdlhvSFEyaGVHRzBCY3JuNnlnb1lrWGNTd1IzOEJnVmxDaHozYlFLYmlt?=
 =?utf-8?B?djRBdzFKSTRvRnNnL2ZtU05XZTYxMFUxNVZrN20wd29IYWxDZHdRS3l3RWMz?=
 =?utf-8?B?cmlEWXVYbW5TVEJ4S2ZQZTVGLzUrbFlncVpBcUlSSUc1QzU2SG5JSk9wZHFv?=
 =?utf-8?B?MHlrUmFmQXdVTGgzaklGWEhldDA0bG1PclYwUk5Xa2JOOGM4ak1oQ215d1NC?=
 =?utf-8?B?WmdGTVNUSURvaHUrS0ZWM284a0h0ZE8zRmZCRlkzbHFJbGhaOHhBRVVVNkFa?=
 =?utf-8?B?clM2WnRHVXVaUHNnZk5rcUJBU2pkcS93amx5emNlNWJiZ3ZpRTBiWGY1YnFw?=
 =?utf-8?B?SmtVMHQ2SU1hcWI5UEVEZW41ZlRCR3lkSk5yQWlDZEV6anRsQWNJZVczRVYr?=
 =?utf-8?B?NVE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb496733-fc04-46bb-5803-08dc225b2958
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6084.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 12:50:11.2859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dG+Hurg6YIMRoZrhRBINGp/a1ECxHcjcACX53qqvGllG56vIf2f73QyPYYxUcJJ/Noz19KEVpRe5I7iKiNMPLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8010

On 29/01/2024 19:52, Jason Gunthorpe wrote:
> On Sun, Jan 28, 2024 at 11:29:15AM +0200, Leon Romanovsky wrote:
>> From: Or Har-Toov <ohartoov@nvidia.com>
>>
>> In the dereg flow, UMEM is not a good enough indication whether an MR
>> is from userspace since in mlx5_ib_rereg_user_mr there are some cases
>> when a new MR is created and the UMEM of the old MR is set to NULL.
> Why is this a problem though? The only thing the umem has to do is to
> trigger the UMR optimization. If UMR is not triggered then the mkey is
> destroyed and it shouldn't be part of the cache at all.

The problem is that it doesn't trigger the UMR on mkeys that are dereged
from the rereg flow.
Optimally, we'd want them to return to the cache, if possible.

We can keep relying on the UMEM to decide whether we want to try to return
them to cache, as you suggested in the revoke_mr() below, but that way those
mkeys will not return to the cache and we have to deal with the in_use in
the revoke flow.

>> @@ -1914,7 +1913,9 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct 
>> ib_udata *udata)
>> ib_umem_stop_invalidation_notifier(mr->umem);
>> }
>> - if (!mr->mmkey.cache_ent) {
>> + /* Stop DMA */
>> + if (!is_cacheable_mkey(&mr->mmkey) || mlx5r_umr_revoke_mr(mr) ||
>> + cache_ent_find_and_store(dev, mr)) {
> And now the mlx5r_umr_can_load_pas() can been lost, that isn't good. A
> non-umr-able object should never be placed in the cache. If the mkey's
> size is too big it has to be freed normally.

mlx5r_can_load_pas() will not get lost since mkeys that are not-umr-able 
will
not have rb_key or cache_ent set so is_cacheable_mkey is always false 
for them.

>> rc = destroy_mkey(to_mdev(mr->ibmr.device), mr);
>> if (rc)
>> return rc;
> I'm not sure it is right to re-order this? The revokation of a mkey
> should be a single operation, which ever path we choose to take..
>
> Regardless the upstream code doesn't have this ordering so it should
> all be one sequence of revoking the mkey and synchronizing the cache.
>
> I suggest to put the revoke sequence into one function:
>
> static int mlx5_revoke_mr(struct mlx5_ib_mr *mr)
> {
> struct mlx5_ib_dev *dev = to_mdev(mr->ibmr.device);
>
> if (mr->umem && mlx5r_umr_can_load_pas(dev, mr->umem->length)) {
> if (mlx5r_umr_revoke_mr(mr))
> goto destroy;
>
> if (cache_ent_find_and_store(dev, mr))
> goto destroy;
> return 0;
> }
>
> destroy:
> if (mr->mmkey.cache_ent) {
> spin_lock_irq(&mr->mmkey.cache_ent->mkeys_queue.lock);
> mr->mmkey.cache_ent->in_use--;
> mr->mmkey.cache_ent = NULL;
> spin_unlock_irq(&mr->mmkey.cache_ent->mkeys_queue.lock);
> }
> return destroy_mkey(dev, mr);
> }
>
> (notice we probably shouldn't set cache_ent to null without adjusting 
> in_use)
> Jason

