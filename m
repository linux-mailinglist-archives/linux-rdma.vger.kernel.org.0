Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA15E482099
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Dec 2021 23:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbhL3WZF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Dec 2021 17:25:05 -0500
Received: from mail-mw2nam10on2077.outbound.protection.outlook.com ([40.107.94.77]:49728
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229528AbhL3WZE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Dec 2021 17:25:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HnuuewuL8jlefOef+VBg8vD87/wy9xFBDwd4+XSoAd+T7ZUdjbFq9gbWc1V1nhoBv3YvgDGDOtQBEfqqFKLF2k61Sf5DoeSBCvH01eVEmUIpIwujrW62FZWWdnvDU+oRqGqA4+ANLEG7JbMoVkO+3tOt5CIU1hdoORaBsRh0BYqkAEvY92c6Ps78/8eJk65yzpcBzioHhXzNCZW5veqnJZmhD8rws0kTcSFgl+WQRmIup2Hw1VrRm/zdMs4eB0bFfn6VIQ9QhDhgHobkrfk96VjJl6EQqqiR5Tr5MJCNoSKYFZ4tZ5uY9fvS2KUwZUJYOb9rxJpopyliHGOEzFWJfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vb1UzBC21B9A1vqfqgezzQdakpJORK6wPGTYISP9I3U=;
 b=d0nB0/oSSCb3vY7uHWAn94aVEuGIuYhB4xLDrn7nBAKBKG7xNmsAGZReXyjOrAaTccJEM5dfbBE7u+/sgsmJSrcbQauYB+6ORXWXOO4BZERDTx5LXL6SGGYWlHZn45G4XbNsuA8U/EpEHZMmAFz4UHZooKFHYYy7lbVQ4ZxVR3vpIBSIm/mXcLPvmN0OvZ9JTjh/E30EHtYZyr8XwQXCy3Y5l5NW5A9X9OpxZdHc8nS6rUDZSnudtRBBJnSQrjhoR8YCtcF2C/VR9w1sM3RUO0P1jFNDbvS/ylGq/kFiLTpsMWR/0q1neJ0G9BOI66dSa0YCKesA9WSJdhoKIP/LIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from BL0PR0102MB3313.prod.exchangelabs.com (2603:10b6:207:19::10) by
 BL0PR0102MB3314.prod.exchangelabs.com (2603:10b6:207:1c::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4823.22; Thu, 30 Dec 2021 22:25:02 +0000
Received: from BL0PR0102MB3313.prod.exchangelabs.com
 ([fe80::10e9:e695:9aaa:1eb6]) by BL0PR0102MB3313.prod.exchangelabs.com
 ([fe80::10e9:e695:9aaa:1eb6%6]) with mapi id 15.20.4823.024; Thu, 30 Dec 2021
 22:25:01 +0000
Message-ID: <45bfd837-a784-5ea2-7ae0-46e7e557b030@talpey.com>
Date:   Thu, 30 Dec 2021 17:25:01 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [RFC PATCH rdma-next 05/10] RDMA/rxe: Allow registering
 persistent flag for pmem MR only
Content-Language: en-US
To:     Li Zhijian <lizhijian@cn.fujitsu.com>, linux-rdma@vger.kernel.org,
        zyjzyj2000@gmail.com, jgg@ziepe.ca, aharonl@nvidia.com,
        leon@kernel.org
Cc:     linux-kernel@vger.kernel.org, mbloch@nvidia.com,
        liweihang@huawei.com, liangwenpeng@huawei.com,
        yangx.jy@cn.fujitsu.com, rpearsonhpe@gmail.com, y-goto@fujitsu.com
References: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
 <20211228080717.10666-6-lizhijian@cn.fujitsu.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <20211228080717.10666-6-lizhijian@cn.fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0393.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::8) To BL0PR0102MB3313.prod.exchangelabs.com
 (2603:10b6:207:19::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50431b45-272b-4011-2183-08d9cbe3389c
X-MS-TrafficTypeDiagnostic: BL0PR0102MB3314:EE_
X-Microsoft-Antispam-PRVS: <BL0PR0102MB3314B6185D153925F2F3D37CD6459@BL0PR0102MB3314.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3bQwQAX2Q2QwOtUT0XoFh2fMu0q77ltwqbexPdsza8+ZHv/Vo2uZBiYXt3mxWUMp53fvztsFs8F8CT+lXnmLXDQfS8aAyduf4Bz1iePbbtSwSH1GEsyZ1PcRp5QDbE2lGwkEul9DE9pPPlrAnTLsGF7JAuP+FBL/WiTr2jGJ8pLyVIqwCCAz/vaVA8Y7kXLCVTVzGkQdKb3Ub7ZPo0p68HQpTZKvOBoTt87CitsKHn5vXmV2CFEoplbFBYAENNEzAMCiuCgCxcl+/M++T806xfg/WmK/P5UZK93blfnQnWsioCe/bAXC/fjFfM7+tu3H4jj0vVx5cMMhG4bHjyc9SXl+azdtH40j3tG1gEjgasxRQGQ6xxV8L+1aLeTKR47CpmYObigVYikJMpyeFN+LJSQDGCiS6oT7+9r27qwx912c3j+AoiO8f3H6/gYVNNQB0lTL8P0tfmFMQFmqls30VPjk4Wy81kRgyDbVV6em9D66kT408qZ+q0KUsYt+M3JBWnEhKDreJIaVyf+0oPMKxyQWbrBJcdOo9pthHliN8AXtFK7tyuLuhrt5pCN6efD7cOrgbIXBBWISaKzSx4q8gbjgnvufnUAW3CNWpEVUtcOeJpD8XItPuP5QANs8/qvCvmIza8TnQr+KOhLK34lbhI/aXr1q4gCXwC/tImwrBCOabPHLwpVLBJOHyk/4CvzONjvXgjDL+PxU0+SL/K7Bt0WjUTA33dBM7Ysu7A1hZgY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR0102MB3313.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(346002)(39830400003)(396003)(4326008)(52116002)(2616005)(508600001)(7416002)(8936002)(66556008)(53546011)(6486002)(186003)(2906002)(31686004)(26005)(316002)(5660300002)(6506007)(6512007)(86362001)(66476007)(66946007)(36756003)(31696002)(8676002)(83380400001)(38100700002)(38350700002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFlTejNWVkxMK25MeHdCTzQ1ZjZxL3lCVVNkaWhGV3laMHo1QTluMjM3bzg4?=
 =?utf-8?B?YWVmd3ArcjlMYkUzM3E5bExyWFI1azBhQjk2QzRjbVI1OVJ6ZW1mYnNybW1l?=
 =?utf-8?B?YXV0aEVaSElTa3UzNHJXaWM2aTlUMUxlZ1Q3cmtUZmJEL3p0M1ArQlNHSENC?=
 =?utf-8?B?amRVMGc5bmhSd0d5a0xrMWRWM2dpVHZoOStVZGVlUUh1K3NWTVJaMURRaVUx?=
 =?utf-8?B?b2ZlR3RnZytqU1FqSFVIZlhVYzNRZ3BKTUxRT2VpWHVRRWc0OEcySVFjQXlP?=
 =?utf-8?B?WlBuQVpPdmhYcmN0dGZMdjRXZ3Rqa2preFdZTEFCWnE2MnBtbXY3czdpWXhu?=
 =?utf-8?B?MkNKeTF0T3BHL1RmL0dYUlR2WnByQXNEbHJINlhvRnRhMkdtRkVBMHJnY0U1?=
 =?utf-8?B?QlN1WnVPM0NybWE1T2pwN2laVzdXTUlmaDRUdDlySUlIRUpJc1lFUUxWRnpV?=
 =?utf-8?B?cGNsdi9nc3J0VUlkdVJVeTZUNURKZEJHb1pUZko5TENqYWx2Yk1VRDROUlVF?=
 =?utf-8?B?a3ZCUFllNHB6cTF3bXQ2aWNESHlWdWhVdUs5Y3ZYWURZdCswWC95WU9sTlR2?=
 =?utf-8?B?eHBmUHFUSGhQdlFDTG5uUEpvMW0wSEF2SjRlSC9VWHpITjZXbW9DRVNXaEFX?=
 =?utf-8?B?K3hUTEttVmVaS1FLNVdkb0kyMDNoVXdTR25OWk9rT2tuVFZTMlliVW1VdE0w?=
 =?utf-8?B?enlyWGdwN2ZRUERrcXp6NTlRN1o5elhqeWVJT3ZBTEZtNlA3Q2ZBTzUzS2Jy?=
 =?utf-8?B?cTNHb1VWRU9KNUhXaCtTUnB6MDJuTEdnaG93c0N6UXpNRE5qQ2dLUkRENXls?=
 =?utf-8?B?ai9MVTNjSjNEdEExMk1UZDh4WVpzTVVlSTNmQU9SaGZsUnVOZW1QUXp0ZDk5?=
 =?utf-8?B?aG04UXVtdXA3M0ZTdk5XOGJrMVRrSUZjM3RVQVJvczV1TnZSZzVPTERFQkZX?=
 =?utf-8?B?TmZ0ZXlhczhVNVFrT1VwQ2Z5bUZaRUE1MlhINGZBU3I5MmwxcDFQdnFjek92?=
 =?utf-8?B?NlorZkpKSVo0bENXcXFEN0ttYnByU0NKOVNpQ05JNGJBbElFaFFOOUJPc3Bn?=
 =?utf-8?B?MCtja2hDSkpTaGFFNzV2MmFWZGxONzFpR0llRHM4NVpkN25uRWdjSGFEZkxM?=
 =?utf-8?B?Y2RobDJZcnpBWDFjZDBKQkgycGlyWGRtZlZhWFdad3BFWmFiQmtaN3FpL01y?=
 =?utf-8?B?bnRlM3dKSUFNMWNTSDRXOHpDNmpLYmdpQ2ZMb3psb0hFR2VsRjQ1RnNnc1NP?=
 =?utf-8?B?cUtlL2wyVDBSMjF0RllBV2xESHh1VS9LWVoxM1lVUTdOeld5a2JnN3Z4bmNE?=
 =?utf-8?B?VHpCTXcrQUZLckRuNlF4RDY0UDFBV3hpRTNuTlVGczNLWVVPSElRQUp2a25D?=
 =?utf-8?B?elZMdm84VnJYWVdpNzhiakpLYklVSHhGcno0Vnd0WVYxaDBNNHZkeDBvM2Zv?=
 =?utf-8?B?R2N1TnR6eVdpWEFncmsyTTFaWFdHd1VOWjByMkgvenNKVk1PaVZ5andFZEt0?=
 =?utf-8?B?WDY5RHF2b3RvNzNrVEpvS3FnZEZXbkt5T0pPSmdUS3FiZkdTSzBFRkk1dlh6?=
 =?utf-8?B?TVBiaDB2VXQzTmY1Y2xtWEN0Y0szckU1SEdiWVdnWTlEQWJ3MjI4L01OcEFa?=
 =?utf-8?B?NXMwSW9NSEJLN2NMdllLZjJMSGdRVFQwM28zVEhpdU5tRFdLbnRBdzhWa3py?=
 =?utf-8?B?N1pFemxtc0hsd1czY0hqUEN6Uk1NekUvZSt2OW9Sci9XOXFZbGxvd2Y3WUVK?=
 =?utf-8?B?WS9lR3AxeWh2VEFyWnUwUGJRTkdrSFRra0w1NXB2bnF1eWg0REpnS1BqK1Zj?=
 =?utf-8?B?ZDJwMit2QWZNcDhibDNESnZZWmwvbFpxYXBuNFpoR3VYUnVPb1dycUFMUHhF?=
 =?utf-8?B?MEJPeDZaU2Q3VllmN2NTSmdnSTFUeUZHYXdsQmZORWc4TzlPZTZrNTdGUUZ2?=
 =?utf-8?B?REYzYTBrU3MybWVDMFN4QVdUbkpyeE9aYmhmaVZaTGZCUWJ2ZTgwTEdVQnJi?=
 =?utf-8?B?dytmMWVEd05mMU1XMi9tdTlwTWozdUFPVCt6NmI0Wms5M1FmZTFMdUpQempa?=
 =?utf-8?B?eXFuMFA5QmJlNDZ4NlUyekFja0wxQlkxV1B1aUdFb0ZLSHF5ckJzM05qRE1v?=
 =?utf-8?Q?FNdI=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50431b45-272b-4011-2183-08d9cbe3389c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR0102MB3313.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2021 22:25:01.8813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9H8jccSheDy9lTLzY283N/QePRKaDAUlKy+UZ9QO5PWgfSH03qLE/tMeqs5+BU98
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR0102MB3314
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/28/2021 3:07 AM, Li Zhijian wrote:
> Memory region should support 2 placement types: IB_ACCESS_FLUSH_PERSISTENT
> and IB_ACCESS_FLUSH_GLOBAL_VISIBILITY, and only pmem/nvdimm has ability to
> persist data(IB_ACCESS_FLUSH_PERSISTENT).
> 
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_mr.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index bcd5e7afa475..21616d058f29 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -206,6 +206,11 @@ static bool iova_in_pmem(struct rxe_mr *mr, u64 iova, int length)
>   	return page_in_dev_pagemap(page);
>   }
>   
> +static bool ib_check_flush_access_flags(struct ib_mr *mr, u32 flags)
> +{
> +	return mr->is_pmem || !(flags & IB_ACCESS_FLUSH_PERSISTENT);
> +}

It is perfectly allowed to flush ordinary memory, persistence is
another matter entirely. Is this subroutine checking for flush,
or persistence? Its name is confusing and needs to be clarified.

> +
>   int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
>   		     int access, struct rxe_mr *mr)
>   {
> @@ -282,6 +287,13 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
>   
>   	// iova_in_pmem must be called after set is updated
>   	mr->ibmr.is_pmem = iova_in_pmem(mr, iova, length);
> +	if (!ib_check_flush_access_flags(&mr->ibmr, access)) {
> +		pr_err("Cannot set IB_ACCESS_FLUSH_PERSISTENT for non-pmem memory\n");
> +		mr->state = RXE_MR_STATE_INVALID;
> +		mr->umem = NULL;
> +		err = -EINVAL;
> +		goto err_release_umem;
> +	}

Setting is_pmem is reasonable, but again, this is confusing with respect
to the region being flushable. In general, all memory is flushable,
provided the platform supports any kind of cache flush (i.e. all of them).

Tom.
