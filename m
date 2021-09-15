Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33C740BC76
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Sep 2021 02:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbhIOAJF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Sep 2021 20:09:05 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:14800 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229520AbhIOAJD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Sep 2021 20:09:03 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18EL03KL011618;
        Wed, 15 Sep 2021 00:07:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=OoqKzNd5inOMAKCVNRvyThp6fCBF11sBHbSy0Xl9dLY=;
 b=FSntudB2RDT+m7FagaeXBdK2ZJBOl8u0+7NN1BSWUwCmYSXANX0DSSPZNOoPMMaOS4UI
 4kNmMhJ9xK9YZgXQ5RKg58cUuTbtRkinjnH8HlRthYYljtWS5qnuvsxXTYWfBZrdIDeS
 gVKlTNK62eqTrhLXnOMp87ZQ2roQwvbMwt8vqLUYDMaE42mTG44ay4UhF/02fvxryuo8
 QDRYxItm4AUCr24y/cFOT3e5C9xQnsMJL2EOroaXG1oFJX2PMfcrGJkpVeywYwT4tFJ7
 jFzxJsOulpbzmVefC3JI6BZDJlElzsn1ql4Tj2nsCo6csYgqwIdbP0SfUu2gOzB8uEkW vA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=OoqKzNd5inOMAKCVNRvyThp6fCBF11sBHbSy0Xl9dLY=;
 b=VqO3NDPAxgoK/bhq2qGjxIpVrWnvQZcsGmVcEOPDtRiF03iK5W7GR2Zy75SsF2dNQwgy
 zu1LgUA9rJeIysLZKVa76OP9oWurWF2GOE3HKLPuPAXAtwyrg4ImpldltTKdTpx+iSLD
 22xkj/M9OdrP5JN+O3VDdLTR11DeG2dkm9yqNO8tGpkJedLhMbbdyeu1vnJr/M7/Fe6j
 RH+r+Y3Sz/gdkuUTMWjjRYcveyB0ZYJ96K92mpLqkLyzGONU9vV8mrhrvI+rqfb/s66N
 F9Ze6zg3M2wPV205CV4V3eBdyQgqkLG0ulQzfXJoZbpFpklJwtWQuss7TTizeBaNGeA0 9w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2pygawvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Sep 2021 00:07:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18F01V9o050082;
        Wed, 15 Sep 2021 00:07:33 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by userp3020.oracle.com with ESMTP id 3b167stty7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Sep 2021 00:07:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEg59tVelcJ0B9VKyq7SqOHbU7RUN7krfGAFd7FSW9m3zGv63sn5qByQPlpk/X3qeDWtyUzUkBckBz3I3sYdTF3ja2IGw6zcOeFCWtM52wcIwyp/d287GIFTsgB09Wprw+URuXJ3ODDpYpLfwFqfTgBJiDwEY3DZaQYLthsSfND+Qj2UzDdbB0JbRHk2zzrfhV5fBz6y70ZT6ataZyMqyFZ4Qi0NYVeW5Wg8XWEufKenFzQ8kkkM0C+s9FyICePiAkSfOdTRpIHvEy7w1Lk4sDl1La6DPETSqi0yB4CD8op+KBObreXoOvVVywm08vNNfAJ4rAjBcW0VDZjckxeLKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=OoqKzNd5inOMAKCVNRvyThp6fCBF11sBHbSy0Xl9dLY=;
 b=ZAVhfszo0opzeNdgfNbswtP4WC4ZDqeO02GsF15W7JUKXsprEpuFJ/gHMfoWyBwI1mxzO/aBIolQRS/oLA0Qtfez3ExmE8eOV3/0X/3A2HBZG0cjf/Jc4bWgFYH3CGMf/Wxp1D+WZRn4ESFKWdKCHWXDku5uSbljDwuDtW76wQFnlgkC8lD5iCO1COLXfQYNANw2RNmyPhcXCOL8Y16lrf7xJOg32GMdOMbEiXCxp0SbK2zYUsZFkBr0wLF5FqnjKWz1PrThGFshFubVFO9nkE7VOaw5WgZKtjuc6RO1SxwgvhRJ59k4yvrp1YVBe/aJMRBIj8/RKU57JR0AculUlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OoqKzNd5inOMAKCVNRvyThp6fCBF11sBHbSy0Xl9dLY=;
 b=RnMYCTcZ0hsdarqip0UhuBoI57lZeQ/Mwp475wvsTnPKx7ooRab9phjGObi0CDBCRJcahl8KB5hac6yXOHZSc1dr1JlsIVSkN9+Ytx88avpVFV+fw4Jp2hxFHWecNJCSnSvD+bsrdmH08wDYQFnHanwHoT9786Y03LmRMEaqmCw=
Authentication-Results: igel.co.jp; dkim=none (message not signed)
 header.d=none;igel.co.jp; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 by SJ0PR10MB5536.namprd10.prod.outlook.com (2603:10b6:a03:3fa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Wed, 15 Sep
 2021 00:07:31 +0000
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::d41c:d8ff:89d6:8457]) by SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::d41c:d8ff:89d6:8457%7]) with mapi id 15.20.4500.019; Wed, 15 Sep 2021
 00:07:31 +0000
Subject: Re: [PATCH for-rc v4 0/5] RDMA/rxe: Various bug fixes.
To:     Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com,
        zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        bvanassche@acm.org, mie@igel.co.jp
References: <20210914164206.19768-1-rpearsonhpe@gmail.com>
From:   Shoaib Rao <rao.shoaib@oracle.com>
Message-ID: <032c0bd7-568e-e98f-d1c6-4fd4b3b25efb@oracle.com>
Date:   Tue, 14 Sep 2021 17:07:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20210914164206.19768-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SN4PR0401CA0015.namprd04.prod.outlook.com
 (2603:10b6:803:21::25) To SJ0PR10MB4494.namprd10.prod.outlook.com
 (2603:10b6:a03:2d4::12)
MIME-Version: 1.0
Received: from [IPv6:2606:b400:400:7446:8000::929] (2606:b400:8301:1010::16aa) by SN4PR0401CA0015.namprd04.prod.outlook.com (2603:10b6:803:21::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16 via Frontend Transport; Wed, 15 Sep 2021 00:07:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fb024af-dbbb-4275-a385-08d977dccfd0
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5536:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5536BE7E36947DF5862A20EAEFDB9@SJ0PR10MB5536.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:224;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qnW3LlpeW50awbSW/0rKJg4WJyHwfSiFIMI23OwR/t/99MtAb40cfr0G7lNm3p7t9i/+8+l7HJHjezYdkE7KkbSbhQcq683MnMQ/B54ORpS9E8LwEMzVyu/91vVTpn0fpS7zcv1Kh8/2lLMqM+fQjrEA6Mw7nzIcAPf71MSzX87o5kYrzzmJIMy9Bp1ycWEJ3EAtntACN8wAue9RnYkHZ0HUtgMjC1JZ2l296u78zbyU9Ucfatv9xmeCejioHjVdEfx/DyCt76/TIj2lWFgbAfdwqdQYV4TrF0cHpYF+cEIH85cfljE8jgVJBTY1VNDPd2HdxZMdkaUoTYROhfmmm0knw+MIQjvwoZA/g89MAUzz3dNVp6zpmriwTXdDD/sCmXdAUP56vUkUgYQHwrQlBvJdCUC4BE0qOpf9GYAqmp1Tk4J5GWu5OZFGyNfAymGTxj8QEqoATC/lu9faP2821sQ6vaw18KW92SJUV2QU26XkQqxJ3FXJjQXkNbUmdrWNzPZ7SimKbmtu/xga8rQQMPE/Uu3t1q78ffsRzkNRJnAAat9qhxuBhdgOEw1YOoZ8oyG9RgU2fMBwmfzY9lfdtVpYR2IWGEHNdJ3oaO3hIi4rcr9V+Zq/sLho79NwPLxaiBl78NW7IxaodCm6HSx2d28+knDTvEMAzSB1JU3+CqDtsF/akQB6XZsP+UBQe0KNNHQ9UeBZRlOVQrcFhnsrFLKwaDbw+sjEZxwnnkoeXI8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4494.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31686004)(8936002)(53546011)(8676002)(2906002)(66476007)(186003)(5660300002)(66556008)(316002)(31696002)(83380400001)(6486002)(38100700002)(86362001)(36756003)(66946007)(2616005)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWNOaFpNQlNpT20yaC9IdDRVSE1SZWFMZjlDOEt0dDEvenNiVS81L21zOXlK?=
 =?utf-8?B?UUpDRjZ0T2Y5ejQ4c2ZwZGp6RjBUZ0JWNFhRZ1JkNElBRG9aY3VyMHQxY21C?=
 =?utf-8?B?RGlUWlV4R0k1ckVLTkMzc3pRVkQ3ZHQ3Y2hPK3lBeE1yeENXVUh3UXRyWTVk?=
 =?utf-8?B?SEhqelBjcTFremtLcnFwc2JITTJ1RTNvZ3J0dncyYU1qSWtPTWM2OFlBaUlG?=
 =?utf-8?B?NVBzdGRaS0FlM1RiOTdwdllRL0FtZ1V1d3g3RExvbmZidUc0eDQ2UnNSbkd1?=
 =?utf-8?B?Si9GMEY5dUpDMmFyclh6Z1hvdWxLZGZGcUlCMDQ3eWMya2w1UmIvSFdtL04y?=
 =?utf-8?B?U0ZDc21QVU5XMHBPY1pxeEVaK043T2Y1TVFtZDR2eCs2VUs0bnUwQ0ExSzBR?=
 =?utf-8?B?d0N6Y05PVmVYY3V6cWFiVENnNXFmc3BRMms1MGhYcVQwVytETkpJbTFHSXpq?=
 =?utf-8?B?REIyc3c0RkNBajNJNy9EaVZxTGhjZ2N2ZzkxNGxkeCtwME5YWXJDTk5QWGh4?=
 =?utf-8?B?MEdKYVFqaFZjNlVlRFlnTjFmZ2cvYVVIRE15MVBaMjFFVVR3bExnRGdkQ3M0?=
 =?utf-8?B?NVBQU0FFNzhXaU5Ddy9SZWNKNGNoQWJ4Nm9JaG9zRUIxWkIySk04MGMvMWV0?=
 =?utf-8?B?dnNNQ3FpaVRldzU4blp6MXZOZFcxcDRGS0ozNDJiRm9MV0pFWjBkYThMQ3Yv?=
 =?utf-8?B?THVScGx6RllVb1NmUmUrN090enlJUnh2U2hnWEluQ3hPZlY1ZHFBZkkzVWtJ?=
 =?utf-8?B?VFhabS9FM3pPS2MxR0xuenFDYlB4VHlMb095WFFjRXZCUFc1eGFPZ2J0TkFW?=
 =?utf-8?B?RG5aSktLM201YzhJU1ZLNEJBMGphbGtmaktaUFNWN2Vmc3Jza3NuKzA5anJK?=
 =?utf-8?B?OEdLZGcvV1g3THpzSS9sK2tQQkl3S3NLQ0Z5aElodDYzd3BKNGJVODEzVXMy?=
 =?utf-8?B?TXBuQ29KVmxFblIrbHgxdnZpS1RJNlJ0YVlqRXRkMDZHdTY3STM3T2NnYkx5?=
 =?utf-8?B?cGRKMzhwdXp4K3JRRXphajVWVHZNeGVUb0k3K1VjZUdtenFZeXVUa3pob0RK?=
 =?utf-8?B?dmhOREltZk5NWUtjMWlIWW1iTThMZkszQ1NIUG9meHJBc2lLY3BZbmJzSjFm?=
 =?utf-8?B?MGY0Rk1uUE1HQTRQazllUUFodDNnbHRRZEE0YnBPeEt2UTlhbVRFeVJ5Z0RV?=
 =?utf-8?B?cXh3M0ZvcDRjajNqb2hVN1M4UmdmUXdmTi9rVTJmNmRPS1UrZ3JKbHNRRThM?=
 =?utf-8?B?SmNVUFFzWkIrTmdHZEZzeEFVN1RocHZIYUlHMmw3anRBM1FYSHpOMXBYbTM1?=
 =?utf-8?B?ZFV2aDZuYUFxaWhCUmYzYkVoTGZhdDJTajR0c3QwVlY5K2NhTzM0U3pmcFJM?=
 =?utf-8?B?dlRMaXoxN0xXdm41U1dPVXdPZzhVVnVBUTI0QjYrZ2RyKzd3bzRvdUVtTEhp?=
 =?utf-8?B?cE4yOExqekRQZVBBNjJ0L0pvTHJVVjI0dFNxTTVtZWpST1dkMnZFc0N6NXpF?=
 =?utf-8?B?aTJuZTdLaXpnd09zOU5Gc3R2RUIxMkhIZTVCdmJ2QVBOU3JJdWRlczFYZzQ4?=
 =?utf-8?B?cGlROHZlZCt3cllCNXhmZXFoVjIzM00wbEhNejVIR3VZUFordEhMQkExTTNP?=
 =?utf-8?B?ZG9Fam9xY2xaL2FtMzBIc2t5d253bVlSRkExdnRvcEMxdjRxaXMrTFFIQmdQ?=
 =?utf-8?B?MHhsbElaK3R0ZE5xNzU1bDBNUVk0akk2WVNjcnI1MG1JL0RabWV2NVBKRGdT?=
 =?utf-8?B?ejVydGR0NU02MW1jaVZpSENBbjNGYW5aZXQrREpYMVhiWDhBT0lIQVZqa1NI?=
 =?utf-8?B?Q3BBOEhrYkhnS0l4Q0FOZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb024af-dbbb-4275-a385-08d977dccfd0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4494.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 00:07:31.4903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LCqz4MGx8p6RBM8pUrADfrI4iLvvfo9aV7cfECZv6wjnR2fJpAAvTLZsefXyAzuqEXc8ZtefWbWEJyb0C2HOyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5536
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10107 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109140135
X-Proofpoint-GUID: 7wSorKoGob3VXqSJrdYSVF-Xq4PJjOoq
X-Proofpoint-ORIG-GUID: 7wSorKoGob3VXqSJrdYSVF-Xq4PJjOoq
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Bob, I can verify that rping works after applying this patch series.

Thanks.

Shoaib


On 9/14/21 9:42 AM, Bob Pearson wrote:
> This series of patches implements several bug fixes and minor
> cleanups of the rxe driver. Specifically these fix a bug exposed
> by blktest.
>
> They apply cleanly to both
> commit 1b789bd4dbd48a92f5427d9c37a72a8f6ca17754 (origin/for-rc)
> commit 6a217437f9f5482a3f6f2dc5fcd27cf0f62409ac (origin/for-next)
>
> The first patch is a rewrite of an earlier patch.
> It adds memory barriers to kernel to kernel queues. The logic for this
> is the same as an earlier patch that only treated user to kernel queues.
> Without this patch kernel to kernel queues are expected to intermittently
> fail at low frequency as was seen for the other queues.
>
> The second patch cleans up the state and type enums used by MRs.
>
> The third patch separates the keys in rxe_mr and ib_mr. This allows
> the following sequence seen in the srp driver to work correctly.
>
> 	do {
> 		ib_post_send( IB_WR_LOCAL_INV )
> 		ib_update_fast_reg_key()
> 		ib_map_mr_sg()
> 		ib_post_send( IB_WR_REG_MR )
> 	} while ( !done )
>
> The fourth patch creates duplicate mapping tables for fast MRs. This
> prevents rkeys referencing fast MRs from accessing data from an updated
> map after the call to ib_map_mr_sg() call by keeping the new and old
> mappings separate and atomically swapping them when a reg mr WR is
> executed.
>
> The fifth patch checks the type of MRs which receive local or remote
> invalidate operations to prevent invalidating user MRs.
>
> v3->v4:
> Two of the patches in v3 were accepted in v5.15 so have been dropped
> here.
>
> The first patch was rewritten to correctly deal with queue operations
> in rxe_verbs.c where the code is the client and not the server.
>
> v2->v3:
> The v2 version had a typo which broke clean application to for-next.
> Additionally in v3 the order of the patches was changed to make
> it a little cleaner.
>
> Bob Pearson (5):
>    RDMA/rxe: Add memory barriers to kernel queues
>    RDMA/rxe: Cleanup MR status and type enums
>    RDMA/rxe: Separate HW and SW l/rkeys
>    RDMA/rxe: Create duplicate mapping tables for FMRs
>    RDMA/rxe: Only allow invalidate for appropriate MRs
>
>   drivers/infiniband/sw/rxe/rxe_comp.c  |  12 +-
>   drivers/infiniband/sw/rxe/rxe_cq.c    |  25 +--
>   drivers/infiniband/sw/rxe/rxe_loc.h   |   2 +
>   drivers/infiniband/sw/rxe/rxe_mr.c    | 267 ++++++++++++++++-------
>   drivers/infiniband/sw/rxe/rxe_mw.c    |  36 ++--
>   drivers/infiniband/sw/rxe/rxe_qp.c    |  12 +-
>   drivers/infiniband/sw/rxe/rxe_queue.c |  30 ++-
>   drivers/infiniband/sw/rxe/rxe_queue.h | 292 +++++++++++---------------
>   drivers/infiniband/sw/rxe/rxe_req.c   |  51 ++---
>   drivers/infiniband/sw/rxe/rxe_resp.c  |  40 +---
>   drivers/infiniband/sw/rxe/rxe_srq.c   |   2 +-
>   drivers/infiniband/sw/rxe/rxe_verbs.c |  92 ++------
>   drivers/infiniband/sw/rxe/rxe_verbs.h |  48 ++---
>   13 files changed, 438 insertions(+), 471 deletions(-)
>
