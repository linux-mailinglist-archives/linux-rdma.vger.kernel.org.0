Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D859A3CCA82
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Jul 2021 21:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhGRTtX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Jul 2021 15:49:23 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:27172 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229585AbhGRTtW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 18 Jul 2021 15:49:22 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16IJgCGC022426;
        Sun, 18 Jul 2021 19:46:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=J3Gx3vD6iFSgVd92FjAqD1ClbOSuBT+Hqbt736gmWkI=;
 b=y0rAwweCvJ7VBuy6z3JtiV9VhwnlzVuD+I/wd6EI/WTA6xkQ0ZH1oa98diloGOkrG7UJ
 rU/kTiKaAG3p5X743lT4MLK70AqeTgeAihFuj+eKIOs2cMwlYrpjCDe0RpbWGqXJI5Z/
 NXBW1N8ceLcu6V7um8Du144fkvVVJR6n36ksWwyravGu3Ww5RUnO4OajwzSGSpdeqAbf
 lvBQwYwGwTD0KTQvK3Yh7kaZcD4Y16E5QNXtuYEPazURnYq17VAFvKTSNhE5Uu2Tjzk0
 +IgCJQDounxciYq/BfZ7024oP/QqtZlH+LZVkFjcKgkuB5Lw/2q+ZP4TkmSPkhIu8jWJ 0A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=J3Gx3vD6iFSgVd92FjAqD1ClbOSuBT+Hqbt736gmWkI=;
 b=h0mNkz6ONOyIsM/hiT4AEBaFKCn2gQeWEW3RdqjknUc1pQ7B6royPThIx5KhWe11Uzp/
 UqZabB1HmuZY9Po0p+huLfuLGrakdVKy7yHSxXs0swzC4QR3JGo/HyZxwcbI0GGtPfx9
 0SmML+L4vJ7fy9DjsPp91bmbhWyLpNUD5lKwDgZiI7PBqckXWjIeRmgfrZfI9D40iWy2
 SwtOzPmtr14czVgR0/jNbeZJHAoSuUJCamKe3iQ37tpccEyv++BujgNqpjsQPvN1yC3G
 rbM1fV/X/jwYoY7LRS81vCslVyoeDjjueBUk9Q5jDLG+zGYEmwitb38OE4m8o+WCt55d eg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39vqm983h6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 18 Jul 2021 19:46:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16IJf518080503;
        Sun, 18 Jul 2021 19:46:22 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2042.outbound.protection.outlook.com [104.47.51.42])
        by aserp3020.oracle.com with ESMTP id 39uq13f8uk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 18 Jul 2021 19:46:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zze7nI4+1YOeybTRkU6xBmBYd2o21aDZhgkRUZ3S8vpmXSv13bESL3aPKXoWPhQ1CEPrpGx4begBh8j0wrwuRmPZHL2xF1E2H+Xwpm6RNT35dP2mEJ8KYKL9470HT82zbZYA2RiZf9G6n9e8iwEsFrXBSE0VLfWYQcSPUNJfFEttPCteE2krIyA3R6xwkFU+xCTUzSlLiU/Inrw3CMDk4itVpjiujBDZACIgvFpFJGC9QmaOBbGrT78qlD7/OrHslnQoJIUE9x7go2smqLfYQlrQOvVeTvLPUPwFiy24ddamZ/V/hFTcjDtOyhupGifA5RpCeCAVvq9/h3E8ScHXpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3Gx3vD6iFSgVd92FjAqD1ClbOSuBT+Hqbt736gmWkI=;
 b=gEOVP/RG9niB4cBa81g1+7DbMq98ZkAo0MojxhihBw21q5oXFgMJQcfsLoUZhDdhB1hhllFKTH+q44AzjXl2CIjcAyTZz7BfK7m2/uoOqWAWooCD74W/2Cw9RZYxDcT4gqTiCx5IJ25tzzmRTr7z7wl5jCPttf0PN28D7r/7nW5hKlQFqtyqwziVRBNuJfHge2vVTk1nBsGauZhFwjeXvddisnYMmv0Raoqggagd+mBDWlN8cOoDoqOoPriCXNX32bOxJMb5Q4OvrQRJYxYxENKTSJ4hHhjrPF/RiB0H8vBF+PF24lDxjqbU+H44xnluEA65zK/qZSJ7DhRZBCwfTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3Gx3vD6iFSgVd92FjAqD1ClbOSuBT+Hqbt736gmWkI=;
 b=XhKxMyHA8sk2IQ8JlyuqvMRKsVmXT8/OlZP4dpnbzX++1PKEN87IEz2wKBNesywS7r9L+TiAGDAYLDuUtTE0rCPvMKnLnaPs3CNeWfP0kjj6OYiXU/38li1lDJyJdxtHz7MZZJG7YrnZ9G+UbQ/dY49IKVuNAdAPXps0Mce3FAE=
Authentication-Results: ziepe.ca; dkim=none (message not signed)
 header.d=none;ziepe.ca; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 by SJ0PR10MB4765.namprd10.prod.outlook.com (2603:10b6:a03:2af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Sun, 18 Jul
 2021 19:46:19 +0000
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::5de5:d174:9459:6d21]) by SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::5de5:d174:9459:6d21%6]) with mapi id 15.20.4331.026; Sun, 18 Jul 2021
 19:46:19 +0000
Subject: Re: [PATCH v2 1/1] RDMA/rxe: Bump up default maximum values used via
 uverbs
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20210714083516.456736-1-Rao.Shoaib@oracle.com>
 <20210714083516.456736-2-Rao.Shoaib@oracle.com>
 <CAD=hENdhJJghv2GNh3V7ndyoJ8eRej8g2TeoDFn6F4T+n2cTHA@mail.gmail.com>
 <1f764b55-77d4-8332-858e-fb9e8bd9abcd@oracle.com>
 <CAD=hENcEZ6MFrivYoBmbiBEcCjFbg-6yFQJ6TrLSNQVkDs+2_A@mail.gmail.com>
 <8eba2b02-36c5-e14c-3503-0e1cfeea4dd9@oracle.com>
 <CAD=hENf5an1Vz-vKUoCPwOazB4KfXMrjyZx1MgamVZo8j0HTtg@mail.gmail.com>
From:   Shoaib Rao <rao.shoaib@oracle.com>
Message-ID: <74c62daa-9f20-cb51-ff6a-fb7def78b444@oracle.com>
Date:   Sun, 18 Jul 2021 12:46:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <CAD=hENf5an1Vz-vKUoCPwOazB4KfXMrjyZx1MgamVZo8j0HTtg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BYAPR01CA0072.prod.exchangelabs.com (2603:10b6:a03:94::49)
 To SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2606:b400:400:7444:8000::b3] (2606:b400:8301:1010::16aa) by BYAPR01CA0072.prod.exchangelabs.com (2603:10b6:a03:94::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Sun, 18 Jul 2021 19:46:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2046b4cf-294b-40f7-213b-08d94a24b6c0
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4765:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB47651E6A6CF7CF4A4BA94EA5EFE09@SJ0PR10MB4765.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O056yjBQ6Ok3oijapXahbda/895ZoC7D127Sn7IOaCm0t5c7dNwmGkJALSftccvVkHlgAb+yKk96btxkKFq4Kp4gsSqmitx2jmSQq+yPyEnRk1B+Ue74zi37Gtiskn8zYTVG6V5TdTJbfPGzts0EqlmZUhz7FnkTcXvELwInC3yyeGpr5DQ6qbRn5SGKEFeoR80EdUsXSaw0d2/P0nUvmIsC4f6jInFa6Lejs2czS4xwSFdndsST048boXffVwF+bmAvhNzQB48sMntUtYE8ZyVWE2wN/fjOL/w19R45fDIMqQSZot0K7sL1zwkHbVRj6/oMb24jQDzE++LhtJnXiSuCSwyv5XvCC3kWfskVT+wfsG4IOxIjf7wv0cS5tFv3d2I38Hyx5t9FlaI/710ELTN7tOmROVneEKpLe1p7Du7BQmxhcKEH6fDu5caNB90qey5uTJknPGh/DC6PxqT6cUuGL4bllqL274CaWFdcU3vuYEenTFZQxht+l6uwaxZMQNIHXtnnQvnDT7Ix8niULHPhcxebX+8xb1s6Q/unhyhhUdNs3J9NHiHAFqg2etzCI4avxaMeK0Dv0VHNBr8FWDe93t8Bv7p6LZsGtbhvUAKAeeK++SCSie7zGxeV61XEcOHR+13FkswMTUujBeZzZyNuIVxr03pj76hHsc9E7rTPl2R4DVXH4lU3cM1vRLHvRR1N80IOaxsH0kJ7tTuA1w0YVF5RlQMc+uz0lXcq50TOo+mraikAeqlkof23RtCmpqYXxSv5mwEIdh2NUb7d5U6IcwNVoCQR940x9U5f+YxX7u0UFoAZqXYj0S98Ja84
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4494.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(186003)(2616005)(31696002)(8936002)(38100700002)(5660300002)(53546011)(83380400001)(6486002)(6916009)(36756003)(316002)(31686004)(966005)(8676002)(66476007)(66946007)(508600001)(66556008)(4326008)(86362001)(54906003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzhBSHhtWVZ3TlFkNXRuT0s5UFZyeFNhTWgxRTJ2d1d0ZmR2SVlKYURieUFw?=
 =?utf-8?B?TlNMRnJBcFhRUk8rK0hza0VPdUc0WHVhelFpeHd0bFlpYkxoREo2SDFvNklh?=
 =?utf-8?B?OVZEeFpIUmV6Zzd4SzhWZzZWdGFFT2NDak1LNjVhSG1WOFc2b3YvbjY4R1BV?=
 =?utf-8?B?MTdqb1dwUGJEcWdBWjJmaktGT0ZOMEpyU1B5eVhNeEMyQ21GU2hrd21BWGlW?=
 =?utf-8?B?QURQclVJbHlZZy9iSC9PRjdBcnVTNFk1ZVkvZEQ0enNoNkEvZUY5L0NRVFc4?=
 =?utf-8?B?RTkvWCtBRkVVSUU3dkE4UXVBL1dzU2RKMHVPc2tHamlPRWR2czA0UTZDUnEr?=
 =?utf-8?B?MjhNbitOcU5JN1ZHajJSODZnYXBjL1FOQ2pJdysvL2dudlcvY1V4dG80MGlv?=
 =?utf-8?B?YVJ0VkVDdDBVSTZrS2tEYktrNmVYd3RTdy8zTlJxTXNOOHdkSU5pRmFvSnJn?=
 =?utf-8?B?UHJBZmlTYUFLY3JESmNQZkN6Y1RJelNsVm5WT20vRE8yZkhaSXB1ZXlJMFVo?=
 =?utf-8?B?cGpTVHh0NDFoSEsvWG5Ib1VwQ1BmM0FySmt1MHRHenkxSVZiSUNpbU1XSDNC?=
 =?utf-8?B?S3FCNUdkRzQwMDd0eFFyd0NBVjJscFhhL1hNUGlnS2c4VGRhOVlqWER2YW5S?=
 =?utf-8?B?cEU1Y09rVVRPOWJQYzNJNVB4bXpvRC81KzNBenFQYmN6ajgybUFvSW5FNUVW?=
 =?utf-8?B?UmRibkRYVjlKVThNWmNPdFVaYy9McjVXeDN2TkpKV0k2TDV2YzhubXRHS1Nm?=
 =?utf-8?B?aE9rZEZESk9YMmFwWCsxK2VQdEJNV0VPdnlFeGVKZkNmdmdac2orMUZUWWR4?=
 =?utf-8?B?L0o5MGw1azRHbDRSQUFadllLYWRZVUsyNmU1SitNS3pVYUx3Y3pNZUpTUW03?=
 =?utf-8?B?YjRwQ1J2a2w2Nm43R3JES1E1dWo0VHhjak8wTkY1WGhQUTh2d1JyUHhBUXZk?=
 =?utf-8?B?TG1JU0VIQXQrcWsxUWFpQ3FKT0JjWVdZSmRoR2dKKyswRll5WkZ3MW9SOTRV?=
 =?utf-8?B?VlltcTZhNVpVUjh3QUpvU0REVVJmM3RWTExEQWdUaTFia3BSV1A1ejdyV1Zo?=
 =?utf-8?B?S25CUlZOQjlWbFh3eHEvTjRsaVlIOGdMeGM0MW5pLzhFaE9FMm9xRzVhY25j?=
 =?utf-8?B?Tm1nSVI5Q2o3bWlDQ3hBUCtONzd6ZXZYOUpEK0xTbzR4Y3diNDJjaTFkWHZW?=
 =?utf-8?B?UXBTSFp5QVRvaThUenlpN0dCM0l1ZTVMYmR5bVg1cThYd2szYkM2TXlvRHJU?=
 =?utf-8?B?dkNmV0xVSDBFVWJKZlBhSVkyWHhKQmFkT0JBMFNLaS9KZHRqM1FldjRWbUlu?=
 =?utf-8?B?Qld5WVFqQTZNSWhRcjVJL3VvZllUSHJvZGxIbmpFOFUxeS9pb2lPSVd3bGlC?=
 =?utf-8?B?TjIxa2NXVDBiM2NaSWRILzk5cDZ5Y3FFN25vcUNWVGc2eFhCTVVGakFEaGdP?=
 =?utf-8?B?Q2hQQVZHaHhWYzVScEVxNk1aZDhJYW1vQXZSYnlQRDNSSjI1YWo4OE5hWXhI?=
 =?utf-8?B?K1p5SEhHTXZNU0VhalBXMk9za01lZ01mWXdPaGhtbEhqeWZyTy9ZbW01Q2pO?=
 =?utf-8?B?ZHVzc0ZYSGl5bm42ak1xU3ZRVjJEOFFsNXdhN0dBWDNNYmVUY1h1SnJsOGd3?=
 =?utf-8?B?U1c2OFcyR0duK3F2aUwzTDQ5RUIyazBJY3kwQ1dhVFMxNy9hUGprVWxtTnJD?=
 =?utf-8?B?Z0c2NW8xbzhQU1c0R1Y0VzR6RHk3TEJHRVA2QzlaQXk3WVVmSmkyZmZDWGxk?=
 =?utf-8?B?MkY0bFE3c1JuQmN5ZC9vK3Q0K1FQZWdUQjlzNGc5eHBxQ0xQNkExbnlhZ3h5?=
 =?utf-8?B?Z1FYb3NWOXA4VEt4ZHZldz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2046b4cf-294b-40f7-213b-08d94a24b6c0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4494.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2021 19:46:19.6531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PtlGOSFj8JOnKZUZMQF71bhhw4myD56Hz13DjaYRQ+t84/YaKX+X5S53hFYTy7BD2vJovndAevhUt6ZVLyFw4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4765
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10049 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107180134
X-Proofpoint-GUID: 7u7CCyDs3dT9d5R09wi8X9xPawgTPQmt
X-Proofpoint-ORIG-GUID: 7u7CCyDs3dT9d5R09wi8X9xPawgTPQmt
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Your urls are garbled, so I can not make any sense out of them.

[root@ca-dev141 linux]# git remote --v
origin 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git (fetch)
origin 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git (push)

[root@ca-dev141 linux]# git show 8c1b4316c3fa
fatal: ambiguous argument '8c1b4316c3fa': unknown revision or path not 
in the working tree.

[root@ca-dev141 linux]# git log --grep='RDMA/efa: Split hardware'
[root@ca-dev141 linux]#

[root@ca-dev141 linux]# git describe
v5.14-rc1-17-gc06676b5953b

You need to do a little bit more work on your end and tell me which 
value rxe is complaining about. Also provide a kernel version that you 
are using as I have provided above.

Shoaib

On 7/18/21 12:59 AM, Zhu Yanjun wrote:
> On Sat, Jul 17, 2021 at 2:09 AM Shoaib Rao <rao.shoaib@oracle.com> wrote:
>>
>> On 7/15/21 9:07 PM, Zhu Yanjun wrote:
>>
>> On Fri, Jul 16, 2021 at 12:44 AM Shoaib Rao <rao.shoaib@oracle.com> wrote:
>>
>> Following is a link
>>
>> https://urldefense.com/v3/__https://marc.info/?l=linux-rdma&m=162395437604846&w=2__;!!ACWV5N9M2RV99hQ!f9TPWtgUxambtSeQ_L3h-IH7CW3SifyiumB3kjc2v_w6Ec_WYVtjWyusEtgQ60iw$
>>
>> Or just search for my name in the archive.
>>
>> Do you see any issues with this value?
>>
>> After this commit is applied, I confronted the following problem
>> "
>> [  639.943561] rdma_rxe: unloaded
>> [  679.717143] rdma_rxe: loaded
>> [  691.721055] rdma_rxe: not enough indices for max_elem
>> "
>> Not sure if this problem is introduced by this commit. Please help to
>> check this problem.
>> Thanks a lot.
>>
>> Zhu Yanjun
>>
>> I do not see the issue.
>>
>> [root@ca-dev66 rxe]# lsmod | grep rdma_rxe
>> rdma_rxe              126976  0
>> ip6_udp_tunnel         16384  1 rdma_rxe
>> udp_tunnel             20480  1 rdma_rxe
>> ib_uverbs             147456  3 rdma_rxe,rdma_ucm,mlx5_ib
>> ib_core               364544  10 rdma_cm,ib_ipoib,rdma_rxe,rds_rdma,iw_cm,ib_umad,rdma_ucm,ib_uverbs,mlx5_ib,ib_cm
>>
>> I am using gdb to dump the values
>>
>> (gdb) ptype RXE_MAX_INLINE_DATA
>> type = enum rxe_device_param {RXE_MAX_MR_SIZE = -1,
>>      RXE_PAGE_SIZE_CAP = 4294963200, RXE_MAX_QP_WR = 1048576,
>>      RXE_DEVICE_CAP_FLAGS = 137466362998, RXE_MAX_SGE = 32,
>>      RXE_MAX_WQE_SIZE = 720, RXE_MAX_INLINE_DATA = 512, RXE_MAX_SGE_RD = 32,
>>      RXE_MAX_CQ = 1048576, RXE_MAX_LOG_CQE = 15, RXE_MAX_PD = 1048576,
>>      RXE_MAX_QP_RD_ATOM = 128, RXE_MAX_RES_RD_ATOM = 258048,
>>      RXE_MAX_QP_INIT_RD_ATOM = 128, RXE_MAX_MCAST_GRP = 8192,
>>      RXE_MAX_MCAST_QP_ATTACH = 56, RXE_MAX_TOT_MCAST_QP_ATTACH = 458752,
>>      RXE_MAX_AH = 1048576, RXE_MAX_SRQ_WR = 1048576, RXE_MIN_SRQ_WR = 1,
>>      RXE_MAX_SRQ_SGE = 27, RXE_MIN_SRQ_SGE = 1,
>>      RXE_MAX_FMR_PAGE_LIST_LEN = 512, RXE_MAX_PKEYS = 64,
>>      RXE_LOCAL_CA_ACK_DELAY = 15, RXE_MAX_UCONTEXT = 1048576, RXE_NUM_PORT = 1,
>>      RXE_MAX_QP = 1048576, RXE_MIN_QP_INDEX = 16, RXE_MAX_QP_INDEX = 262144,
>>      RXE_MAX_SRQ = 1048576, RXE_MIN_SRQ_INDEX = 131073,
>>      RXE_MAX_SRQ_INDEX = 262144, RXE_MAX_MR = 1048576, RXE_MAX_MW = 4096,
>>      RXE_MIN_MR_INDEX = 1, RXE_MAX_MR_INDEX = 262144, RXE_MIN_MW_INDEX = 65537,
>>      RXE_MAX_MW_INDEX = 131072, RXE_MAX_PKT_PER_ACK = 64,
>>      RXE_MAX_UNACKED_PSNS = 128, RXE_INFLIGHT_SKBS_PER_QP_HIGH = 64,
>>      RXE_INFLIGHT_SKBS_PER_QP_LOW = 16, RXE_NSEC_ARB_TIMER_DELAY = 200,
>>      RXE_VENDOR_ID = 16777215}
>>
>> It is possible that you are changing some values.
>
> I git clone the source code from
> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git__;!!ACWV5N9M2RV99hQ!efPsL9fikzm6Ob1-zsmbsAzPkfqRpxYkp9oJXF9csPOJgoei9njj8RmA5IyuH447$  again.
> And the first 3 commits are as below. One is your commit.
> "
> 6163ad3208c8 (HEAD -> for-next) RDMA/rxe: Bump up default maximum
> values used via uverbs
> 8c1b4316c3fa (origin/for-next, origin/HEAD) RDMA/efa: Split hardware
> stats to device and port stats
> 916071185b17 MAINTAINERS: Update maintainers of HiSilicon RoCE
> "
>
> And when I tried to add a new rxe0,
> "
> error: Invalid argument
> "
> And the dmesg logs are as below:
>
> # dmesg
> "
> [   70.782302] e1000: enp0s8 NIC Link is Up 1000 Mbps Full Duplex,
> Flow Control: RX
> [   70.782744] IPv6: ADDRCONF(NETDEV_CHANGE): enp0s8: link becomes ready
> [   79.467652] rdma_rxe: loaded
> [   79.468348] rdma_rxe: not enough indices for max_elem
> [   79.468356] rdma_rxe: failed to add enp0s8
> "
>
> Please follow my steps to reproduce this problem again.
>
> Zhu Yanjun
>
>> Shoaib
>>
>> Shoaib
>>
>> On 7/14/21 10:02 PM, Zhu Yanjun wrote:
>>
>> On Wed, Jul 14, 2021 at 4:36 PM Rao Shoaib <Rao.Shoaib@oracle.com> wrote:
>>
>> From: Rao Shoaib <rshoaib@ca-dev141.us.oracle.com>
>>
>> In our internal testing we have found that the
>> current maximum are too smalls. Ideally there should
>> be no limits but currently maximum values are reported
>> via ibv_query_device, so we have to keep maximum values
>> but they have been made suffiently large.
>>
>> Resubmitting after fixing an issue reported by test robot.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> Signed-off-by: Rao Shoaib <rshoaib@ca-dev141.us.oracle.com>
>> ---
>>    drivers/infiniband/sw/rxe/rxe_param.h | 26 ++++++++++++++------------
>>    1 file changed, 14 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
>> index 742e6ec93686..092dbff890f2 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_param.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_param.h
>> @@ -9,6 +9,8 @@
>>
>>    #include <uapi/rdma/rdma_user_rxe.h>
>>
>> +#define DEFAULT_MAX_VALUE (1 << 20)
>>
>> Can you let me know the link in which the above value is discussed?
>>
>> Thanks,
>> Zhu Yanjun
>>
>> +
>>    static inline enum ib_mtu rxe_mtu_int_to_enum(int mtu)
>>    {
>>           if (mtu < 256)
>> @@ -37,7 +39,7 @@ static inline enum ib_mtu eth_mtu_int_to_enum(int mtu)
>>    enum rxe_device_param {
>>           RXE_MAX_MR_SIZE                 = -1ull,
>>           RXE_PAGE_SIZE_CAP               = 0xfffff000,
>> -       RXE_MAX_QP_WR                   = 0x4000,
>> +       RXE_MAX_QP_WR                   = DEFAULT_MAX_VALUE,
>>           RXE_DEVICE_CAP_FLAGS            = IB_DEVICE_BAD_PKEY_CNTR
>>                                           | IB_DEVICE_BAD_QKEY_CNTR
>>                                           | IB_DEVICE_AUTO_PATH_MIG
>> @@ -58,40 +60,40 @@ enum rxe_device_param {
>>           RXE_MAX_INLINE_DATA             = RXE_MAX_WQE_SIZE -
>>                                             sizeof(struct rxe_send_wqe),
>>           RXE_MAX_SGE_RD                  = 32,
>> -       RXE_MAX_CQ                      = 16384,
>> +       RXE_MAX_CQ                      = DEFAULT_MAX_VALUE,
>>           RXE_MAX_LOG_CQE                 = 15,
>> -       RXE_MAX_PD                      = 0x7ffc,
>> +       RXE_MAX_PD                      = DEFAULT_MAX_VALUE,
>>           RXE_MAX_QP_RD_ATOM              = 128,
>>           RXE_MAX_RES_RD_ATOM             = 0x3f000,
>>           RXE_MAX_QP_INIT_RD_ATOM         = 128,
>>           RXE_MAX_MCAST_GRP               = 8192,
>>           RXE_MAX_MCAST_QP_ATTACH         = 56,
>>           RXE_MAX_TOT_MCAST_QP_ATTACH     = 0x70000,
>> -       RXE_MAX_AH                      = 100,
>> -       RXE_MAX_SRQ_WR                  = 0x4000,
>> +       RXE_MAX_AH                      = DEFAULT_MAX_VALUE,
>> +       RXE_MAX_SRQ_WR                  = DEFAULT_MAX_VALUE,
>>           RXE_MIN_SRQ_WR                  = 1,
>>           RXE_MAX_SRQ_SGE                 = 27,
>>           RXE_MIN_SRQ_SGE                 = 1,
>>           RXE_MAX_FMR_PAGE_LIST_LEN       = 512,
>> -       RXE_MAX_PKEYS                   = 1,
>> +       RXE_MAX_PKEYS                   = 64,
>>           RXE_LOCAL_CA_ACK_DELAY          = 15,
>>
>> -       RXE_MAX_UCONTEXT                = 512,
>> +       RXE_MAX_UCONTEXT                = DEFAULT_MAX_VALUE,
>>
>>           RXE_NUM_PORT                    = 1,
>>
>> -       RXE_MAX_QP                      = 0x10000,
>> +       RXE_MAX_QP                      = DEFAULT_MAX_VALUE,
>>           RXE_MIN_QP_INDEX                = 16,
>> -       RXE_MAX_QP_INDEX                = 0x00020000,
>> +       RXE_MAX_QP_INDEX                = 0x00040000,
>>
>> -       RXE_MAX_SRQ                     = 0x00001000,
>> +       RXE_MAX_SRQ                     = DEFAULT_MAX_VALUE,
>>           RXE_MIN_SRQ_INDEX               = 0x00020001,
>>           RXE_MAX_SRQ_INDEX               = 0x00040000,
>>
>> -       RXE_MAX_MR                      = 0x00001000,
>> +       RXE_MAX_MR                      = DEFAULT_MAX_VALUE,
>>           RXE_MAX_MW                      = 0x00001000,
>>           RXE_MIN_MR_INDEX                = 0x00000001,
>> -       RXE_MAX_MR_INDEX                = 0x00010000,
>> +       RXE_MAX_MR_INDEX                = 0x00040000,
>>           RXE_MIN_MW_INDEX                = 0x00010001,
>>           RXE_MAX_MW_INDEX                = 0x00020000,
>>
>> --
>> 2.27.0
>>
