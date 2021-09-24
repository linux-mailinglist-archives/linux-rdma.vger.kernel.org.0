Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441094177FE
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Sep 2021 17:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347105AbhIXPpz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Sep 2021 11:45:55 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:1302 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346508AbhIXPpy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Sep 2021 11:45:54 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18OEe0GD004875;
        Fri, 24 Sep 2021 15:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=O9EnHGahOUKmQK95Vf/uGJ9GToQx4RGS8JwN+BcJiFU=;
 b=nIHJRsYWTucf7iAlI5rYJjGaMcAdegPT3wGM2XbxwFl+72fCjMcOQSjvKWjvvQ8BTLga
 EnMqeRignGCZ5Vb0xJavwzPEGC8t+E/PO48c+z8wXevsrRtYCfPw9CcBFFkDsJ6ngxrb
 Im4RwoaBfJfTYA8whZgqjAg9/NrCCkEz6SZ7ygrdDO2ulQ8XjvGTlCwJoX/FZj843262
 glPDpeTnkNaA2uhx82EPVDmM3HwBz1cslT8Hh9u88pRa2VpFpwX3nEMjDnFXSLT9/H/4
 uLS40gqEnZzr4oHnd5joeqLozOkcr/xrQ9DgOyh3SNkgK/kyN381q2j9W0kAK6LgHhS6 MQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b93enmc27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Sep 2021 15:44:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18OFQvII070040;
        Fri, 24 Sep 2021 15:44:08 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by aserp3020.oracle.com with ESMTP id 3b93fqw60y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Sep 2021 15:44:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfukdopWTqWSHPBmf02QyT7DDJ9QP5Mxt2R2+4j/5//FxUPZrtiea5PzR4kRZzltiQQQWjtCz4m0lXkXSY9gFIdGn5131LItciDXnvXm4YEcKRpYD+CX1U/7IGCBkEZbofmKiZQnBEbUnL7Q8RymT4TXCDdJVn2K84HQeng6o/M0GaVTB2h0/W4+/I++BL/NzAXWNNXAfVijZLHDwz6a8j0gkQcCSs91uyig6ioSxf4ukYkQp16MXpC5rim5y68TZdh5sZbnBclapuvrPEnOUFscXa3mAnUDAg/rDTWwq0H3iTTSxs+TldVEkDbnLlWcxx2w6eax/L6BwKF+xLNF5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=O9EnHGahOUKmQK95Vf/uGJ9GToQx4RGS8JwN+BcJiFU=;
 b=QDKYyoTnqNfddDfZeTW/ociCsnICZZ15FFrujSlRJa2rnPQuX78jN28TAjz/Q+n45cvdTIO5w7SDNMkCWJRAioN75/rOGwOi+R7eeOHrk47S9ubdHMvh6DcZj0pZSWt5IToN+S5v7un2wkVOrivsprHH8P9eStwKLary543TWa//pyudaNxi3i8ggGAAMhMH+vov6vazgscckfr/ZUgYThPHpfDM7B4WMYCzRk29d9HJ9dk9ThlXA0h9DbIq0AiodjjUkNVeqKlqSdrFlATFZhMfohSx9Y1Uw9LvUjOJJbTB9D1jlVhiG9MybOMK9EOMshRcvNvMJGbJF9k7qVBjpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9EnHGahOUKmQK95Vf/uGJ9GToQx4RGS8JwN+BcJiFU=;
 b=jU4PeHXkUV2SXjsq4c9mC89pO4JPv01cE6qfu13zA9bi8Kb9OtkAMgXNufF5Www9+Uj0IXFVyOHscYaVLKxzEplQ4TopBnXn7T5BmGykOv3l58fPCKvarFItKx1IGK+XF0ZoYHMN5mjptxChVyVEZ/w/fqRW/uHE0h1scNqr8po=
Authentication-Results: igel.co.jp; dkim=none (message not signed)
 header.d=none;igel.co.jp; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 by BY5PR10MB4259.namprd10.prod.outlook.com (2603:10b6:a03:212::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Fri, 24 Sep
 2021 15:44:07 +0000
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::d41c:d8ff:89d6:8457]) by SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::d41c:d8ff:89d6:8457%9]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 15:44:07 +0000
Subject: Re: [PATCH for-rc v4 0/5] RDMA/rxe: Various bug fixes.
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        bvanassche@acm.org, mie@igel.co.jp
References: <20210914164206.19768-1-rpearsonhpe@gmail.com>
 <20210924135435.GA1235759@nvidia.com>
From:   Shoaib Rao <rao.shoaib@oracle.com>
Message-ID: <f2d867f7-132c-84a6-c8ec-c3729b536c47@oracle.com>
Date:   Fri, 24 Sep 2021 08:44:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20210924135435.GA1235759@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SJ0PR03CA0172.namprd03.prod.outlook.com
 (2603:10b6:a03:338::27) To SJ0PR10MB4494.namprd10.prod.outlook.com
 (2603:10b6:a03:2d4::12)
MIME-Version: 1.0
Received: from [IPv6:2606:b400:2001:92:8000::fca] (2606:b400:8024:1010::17c6) by SJ0PR03CA0172.namprd03.prod.outlook.com (2603:10b6:a03:338::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 15:44:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: feb7ae85-9092-4465-ddfb-08d97f7224b4
X-MS-TrafficTypeDiagnostic: BY5PR10MB4259:
X-Microsoft-Antispam-PRVS: <BY5PR10MB42599DF831E48F7C03FC6AA7EFA49@BY5PR10MB4259.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:113;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ANX88N3qHpAeaPoRPkBTFPwjavrR/zIXZ4SUWSWAiYkeiTfQHpTDzZqFRi4o7XcYdHZx28SRsr0kRbd5s1wlWMShso463zH7J5Vc1V0j4jKOuMFkByvQAchxDNCVVkOdfQizj53PkLHbEa8AucCVyE1MXd5vSJxVcrakERrLunMlcYtNfXpAyWaDOjZAwGb1oqUnxpsiuxIj6f0f7YGg07ocDVvBRYwNFjdRBNsF0KFQY8OmGnVz6IpDJujDT3AaPsvhe2aRfPrQ8ZXmYwwUG3eHPNbP/5TXjKquXnJUeS3/xJ1HI4xcxRaTpYmmUK5NddXhDs/y8QRuz0jHbmRe/5EXAdu+Jp6/A4o1zIb/1bKktrp9raxnM7qsGImPu0Hc0ePBQkY6YJ9IR6dU6hGcagBP6qhOFw9wyaczBUVvjYfBvrT2wvSCt7opZAspcrwrzwP9D0GZTj+5GNeiJ3pBL6VzPn4+qtcvCwd+zq9HkR3JAW7b+O6uIXmZmP466uEhxMPJB55BSikPPCCSZeXznfQW/fiIfFrwkK2qbxTy24kBxKl+ap0UhGYHTu1Y1GyR7bqknJIzs07j/LaXdjrPXFMUwXVaumCpL0daL9hVu77Rg7ZAa5ZEO7Xp+arQZ+mw7k+5dS4ZeRMHh3v06qlb6AugQAlyKuvQnCkNebqWefktKpLeHVcvyNvB5WjgwUh/2O0gc4waWHFEA/6aIaPCXrv7olikJpbzueBmkQTiap0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4494.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31686004)(5660300002)(110136005)(86362001)(8676002)(31696002)(4326008)(8936002)(83380400001)(6666004)(508600001)(316002)(36756003)(53546011)(66476007)(66556008)(66946007)(2906002)(186003)(2616005)(38100700002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aCtyQjVsc0lKTmN0eXJPWUF2ekF2ZGl3bmUrejhvWnNUdWJqODVYNDNxWEZZ?=
 =?utf-8?B?N3BjeWJhUDlPa1d0cnArSmpGUWNHS1JCbU12OWU4Wm9yakZqd29kbkNBYW4w?=
 =?utf-8?B?Tit2ckhSbmdzV1U5UHFrTmxxQ1hKK3ZDYmJmTnhsa1dmSGp6R2RWT2ZQTVM0?=
 =?utf-8?B?NDB5Z0kzZnZGTExNQm1WdGVMQUpoWUNTRkNBK0RPSndhUHNoczNCQVBGMlZY?=
 =?utf-8?B?SnREVXJSK3VJY3F0ZENyOG1oTWpwRCtHSnZBZU5CY0VBUU8vVHRTbXQwNGlL?=
 =?utf-8?B?UmRHYWJwWXdzbW1DWWxKYkZyb1ZiampJMTN2UkJrR0ZJSW5tZUtYcVpDQTQ5?=
 =?utf-8?B?VEg0VTZESDRrTldJQ0NDOUVOL2JjMnNlbWhpNHRtWnFnSHVDcXBIaHJZL3Fs?=
 =?utf-8?B?b3R1Z09nYVlDMGpPUVdtalNJbnFiTjlIUldyZlhxRHBMVGNKNHlxMkxEVDJI?=
 =?utf-8?B?UHNMWEhtMWNBaW5kTWNFYW1wc1JvVVRtSXZiaDd3c0owNkxUaklpSHVUVlo5?=
 =?utf-8?B?N0R3b2pzT2wxTU1xdGFxSDJBN0FEbEFLNlZaOFRFczViZERzNmxHM0hoV2R5?=
 =?utf-8?B?Qk4xWUpZT014bzlWZ0FLOXFRS2tETnZ3TnZCMVRhMzVlWU1UQWtPVTU1U0xp?=
 =?utf-8?B?UUZDOVZZeERuS3NVVTU4bWlqUG1ScFByRnVRTXd2QXdhT3k0cXFZRnZleVlD?=
 =?utf-8?B?cWVXanc3YmR6aWJROW5iQ3ZqSzhHYWszdTlEMTFrVHBGS3FTUkNFZ1I3VFZT?=
 =?utf-8?B?WGRjMXd6T20xTTk4TU5vdWdCYzUvSDd6V0JHdGhpREhkUXp1Y3RjMXgzRzIw?=
 =?utf-8?B?OFRHaHN0b0o4dUpQQWNubG1GV09NMnliYTcvVVRaWlN4OHhpVStaMkFNV0tp?=
 =?utf-8?B?RHltTit0UElpLzFvbUN3T3BHK2JZR1FYaytmQXFodWk2aGJSTUlFYUpHTFp1?=
 =?utf-8?B?N2VDb052S1NRcTNWVDNpZDVDVDFUR29VUFFDMHEwVC9iRnhsbFMwVVAreDg2?=
 =?utf-8?B?WUMybVU0UmZ2TzdxMjliNzRlODRNc2tISVk5aGxVREFHcTFESE45S0J4cG50?=
 =?utf-8?B?SWVjdWdhTFpRTXNCQlNCQWV5MjhWSEN4VzhoamFUb2VWeTlRK25pREZkMDBI?=
 =?utf-8?B?Skw0allZTUFmaGM5TnBlb0c2OXViL3p6LzB0Ui9YeFhkVlV2SG5IbUZHQ2hs?=
 =?utf-8?B?djVRYXlsMTlTUHNCbUJObUtaWVBWRXVDUk54K0w0VTBucDVoVFV1US85U0pP?=
 =?utf-8?B?ZHdibU16RkcrZzh2SmRaSTBzakl4Z0xOVWMyWDk1ZUxzRGdOTEdnb0UyV2pr?=
 =?utf-8?B?dnprQWF6OGJQRFlndGoyU25iOWZQWTZzb2I5eUhPOW5OU2JTTzc5Q2xLdW11?=
 =?utf-8?B?V29MVEJPRkJHQUpVRlFxZG9FdmdFWkhpYTlGTXZFK2xlRC9PbHFub0dlK1A3?=
 =?utf-8?B?MENEVE1iVVpUSXNmR1RoT2VsYzlGUmhsWXEwb01sLzVtNFpubnBTbFUrOEd3?=
 =?utf-8?B?MVhERHRhTWxSSEd1UStreWg1MGVucS9ZR2Jvem1KdVZHcTMyRTJQc05HaDM3?=
 =?utf-8?B?V01GY1llNzJRTW9LZVF4Ri9MWEk4ZStNUi9CNm9RNXhEMk5DWDFLOXJWaU5p?=
 =?utf-8?B?ZEpYOTdCbkMyUHJKNmllZjlGTkxodEVMbDVVaWZiUDZXZFdXWERpc3B6NXdr?=
 =?utf-8?B?dTlqNjYxdmhsRVZBbDY1MXVVRmZNd1UzZ1V1bFlrdzhOK0RENUhkMk0xZXNI?=
 =?utf-8?B?K0ZjZjR1ZEx5MzFlaTU4dzlqa1ZGV0FsTjYrdkpGRUJIam5PZnFHQWpnNGlq?=
 =?utf-8?Q?TagWiLLT6Cq4bRcAHKIzsZcLAvinHRT0NTK5M=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feb7ae85-9092-4465-ddfb-08d97f7224b4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4494.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 15:44:06.9762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nWshBXNSv1vx4MkeV+7dRr3DqR3H1XPviS+UidWFeYQx1lA5VeXE81FiUZQK5E9W1CdpgGmcjdCyhD0ZTrBwGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4259
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10116 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109240100
X-Proofpoint-ORIG-GUID: 1a38pqPmcFmcE1dNZ3sAL06Um-9xzPLX
X-Proofpoint-GUID: 1a38pqPmcFmcE1dNZ3sAL06Um-9xzPLX
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 9/24/21 6:54 AM, Jason Gunthorpe wrote:
> On Tue, Sep 14, 2021 at 11:42:02AM -0500, Bob Pearson wrote:
>> This series of patches implements several bug fixes and minor
>> cleanups of the rxe driver. Specifically these fix a bug exposed
>> by blktest.
>>
>> They apply cleanly to both
>> commit 1b789bd4dbd48a92f5427d9c37a72a8f6ca17754 (origin/for-rc)
>> commit 6a217437f9f5482a3f6f2dc5fcd27cf0f62409ac (origin/for-next)
>>
>> The first patch is a rewrite of an earlier patch.
>> It adds memory barriers to kernel to kernel queues. The logic for this
>> is the same as an earlier patch that only treated user to kernel queues.
>> Without this patch kernel to kernel queues are expected to intermittently
>> fail at low frequency as was seen for the other queues.
>>
>> The second patch cleans up the state and type enums used by MRs.
>>
>> The third patch separates the keys in rxe_mr and ib_mr. This allows
>> the following sequence seen in the srp driver to work correctly.
>>
>> 	do {
>> 		ib_post_send( IB_WR_LOCAL_INV )
>> 		ib_update_fast_reg_key()
>> 		ib_map_mr_sg()
>> 		ib_post_send( IB_WR_REG_MR )
>> 	} while ( !done )
>>
>> The fourth patch creates duplicate mapping tables for fast MRs. This
>> prevents rkeys referencing fast MRs from accessing data from an updated
>> map after the call to ib_map_mr_sg() call by keeping the new and old
>> mappings separate and atomically swapping them when a reg mr WR is
>> executed.
>>
>> The fifth patch checks the type of MRs which receive local or remote
>> invalidate operations to prevent invalidating user MRs.
>>
>> v3->v4:
>> Two of the patches in v3 were accepted in v5.15 so have been dropped
>> here.
>>
>> The first patch was rewritten to correctly deal with queue operations
>> in rxe_verbs.c where the code is the client and not the server.
>>
>> v2->v3:
>> The v2 version had a typo which broke clean application to for-next.
>> Additionally in v3 the order of the patches was changed to make
>> it a little cleaner.
>>
>> Bob Pearson (5):
>>    RDMA/rxe: Add memory barriers to kernel queues
>>    RDMA/rxe: Cleanup MR status and type enums
>>    RDMA/rxe: Separate HW and SW l/rkeys
>>    RDMA/rxe: Create duplicate mapping tables for FMRs
>>    RDMA/rxe: Only allow invalidate for appropriate MRs
> applied to for-next, this is a little too complicated for for-rc, and
> no fixes lines
>
> Thanks,
> Jason

Jason can you pull in my patch also.

Thanks,

Shoaib

