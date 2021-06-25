Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0283F3B4920
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jun 2021 21:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhFYTM7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Jun 2021 15:12:59 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:33806 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229531AbhFYTM6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 25 Jun 2021 15:12:58 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15PJAZkI003397;
        Fri, 25 Jun 2021 19:10:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=9MVkZy/SA6lm8SIbRxf9MR4VdPXtqrwW/ltdp7pgfQ4=;
 b=G1Ia5y1zT+zzJPbqlmogExXYqcEqlpbcZYvnPgjG3mfzKHUOzL0cXXqov6M65H5AbFQL
 8ZFcuLHFUseZFAXXT3lMXquynlNDPCtrpVdYRFhv9zksbCqva1NamIeLpTBKyIQ49i54
 3+nHvB1M4N0Xj/ZeutZgdlrwFh8e2uZeWA5zZBrJX3nu4K5h/W4mFwjeYuhvBo9SI9eJ
 8FCXnDhGIdMn/v4Fultsmrj9ZB/KWi64nil1qMVGe+44AjRkcLlWTVw2lPqi7AZSzKUu
 cZPEYk4LR6p+VINztheK5ZJJwjdwc0UAPBhJn+Y7+pJMAfMKyDPbTj3QkVbgxCmQcUzz Mg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39d24aa3td-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 19:10:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15PJ5SL6186749;
        Fri, 25 Jun 2021 19:10:29 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by userp3020.oracle.com with ESMTP id 39dbb1vfjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 19:10:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1c3FZd/NE/v8XgSRx+aTR1lCLsTghm/sXQmobwbP9LtEZxeBO9HEZ6AE8g8fnM9wfpbZHD1mY1f2JZZl7YijeU6Mfr6alEMh00JUaAVPsyxXfAI5RgJkLQP/Ekp4ypc8t/yLFxo6XuVA+mN01l0xmG4+GdDL7ik2iwwPgBMAJdrxR261ebLsV5qzPnXXcd1RJUSGNHztshyNzc8urJ54YR43hZUvJ/pOawcKQkMHkA/zzrg6nZL4l0Lvidi89aVL+NdYiYeV0L8kf2QjL21Q0N8iVCvjGyUz+wrFn2y3VlADYHN9xGNsmU9QHrJLBGr6ZP1QYfPrucNhcfoCyju2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MVkZy/SA6lm8SIbRxf9MR4VdPXtqrwW/ltdp7pgfQ4=;
 b=SXZmZQzyAvIPMVvkK+29xFOGvOl6heFjP7YaFIXRa8CDGdBXWKCwylfeRxgvXNpBrZyY9MG6F/xoZNlZFX24i9Kb/G8Kl6AZCvGA8Ae9foJxLaU2aRhLuszR+jVyrwgJmvkfDXp5Rk/p8vAXL87CGRZYZu+rcdYm4AKeohUDypi7DzDY+ytnJ2IfsZcSlyJMlwk3Rz7xCaZ6hBk7ikao4H+4XxS4gRFRn+fcVpLhouuhaSHMwjB8yNyAbTb7VunDW0GQ79+JKfX1OA8GN56o3x/k/aXH8NI8ci1tFo++hgZpvT0OWvOLxEUK2roYXl1cFkh6Wq93qDCrDmejgTwMxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MVkZy/SA6lm8SIbRxf9MR4VdPXtqrwW/ltdp7pgfQ4=;
 b=G9TN8JpfZ9WzXn6iUPUJ2ssUOUyZqMcPBhLx6vPna2H6uEDP8ClF14F2YMW+pwPRZ1allGUjZwqxBLFSdcbDIUbyKonClC7OpuPH1gb+2fwhsJe94/TKeRRbHJwmsT8MVFKj5orbi/G2DLBr7BrQup8bKpC9Wvrz7EHEOQDzJNM=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 by BYAPR10MB2647.namprd10.prod.outlook.com (2603:10b6:a02:b2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Fri, 25 Jun
 2021 19:10:27 +0000
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::cde8:567e:da77:abdd]) by SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::cde8:567e:da77:abdd%3]) with mapi id 15.20.4242.023; Fri, 25 Jun 2021
 19:10:27 +0000
Subject: Re: [PATCH v1 3/3] RDMA/rxe: Increase value of RXE_MAX_AH
To:     Jason Gunthorpe <jgg@ziepe.ca>, Bob Pearson <rpearsonhpe@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Zhu Yanjun <zyjzyj2000@gmail.com>
References: <20210617182511.1257629-1-Rao.Shoaib@oracle.com>
 <20210617182511.1257629-3-Rao.Shoaib@oracle.com>
 <3aa5a673-3fd7-744b-b664-510005215bd2@gmail.com>
 <10d9763c-4d10-3820-93a0-b79f55acfa8e@oracle.com>
 <edcf0cc0-4da8-5af3-3366-220b4eeba5e4@gmail.com>
 <20210618163359.GA1096940@ziepe.ca>
 <14e2c2a4-6067-c657-6ea4-91cd3c19d032@gmail.com>
 <20210618232535.GB1096940@ziepe.ca>
 <9b651595-94b1-4ecd-1e37-16459530f297@oracle.com>
 <5979c6c7-7ffe-d08c-f970-f97a1727988a@gmail.com>
 <20210625124953.GC1096940@ziepe.ca>
From:   Shoaib Rao <rao.shoaib@oracle.com>
Message-ID: <f9d241aa-d1be-9692-32c8-512d14f8c3d3@oracle.com>
Date:   Fri, 25 Jun 2021 12:10:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210625124953.GC1096940@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2606:b400:8301:1010::16aa]
X-ClientProxiedBy: BYAPR04CA0035.namprd04.prod.outlook.com
 (2603:10b6:a03:40::48) To SJ0PR10MB4494.namprd10.prod.outlook.com
 (2603:10b6:a03:2d4::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2606:b400:400:7446:8000::720] (2606:b400:8301:1010::16aa) by BYAPR04CA0035.namprd04.prod.outlook.com (2603:10b6:a03:40::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.21 via Frontend Transport; Fri, 25 Jun 2021 19:10:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 063977a8-6b61-4c50-2137-08d9380ce49e
X-MS-TrafficTypeDiagnostic: BYAPR10MB2647:
X-Microsoft-Antispam-PRVS: <BYAPR10MB26477F4EC21C758A99EBA20FEF069@BYAPR10MB2647.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d5T2f1TX9UenwflN5uEOs20a4z05znygekoQXtOsZNmQfpkQmqvRA/uX26hRnyrbCKCYp5l7ylKR5VEUzNokXuXGsVOMHS0nKKtLX//gX+IoDCBTx/9JKx8U7GaSitfGLEUEYd9h/LUW3ncH+iD+B1YU6K85bAOiCGcOleG90+m5rmFgG2nONTmruRgr1Sm0w3W6EPQ3NDHGwRGIEmgWPRdFesMVss7vTYZ0QjUWneQmKvBWPgFGqClbqwNspSVAiXYWSdHtcpkpvfBBh53fUfDE7hRjiK+VMxrmgnWhJAmjBStXhHLJF+Tfd1WqDMYVF4NBBg9w0mYoEhN4nGFTP+uPvTJJdtP40wVOBlIW0NNOz2d41pwjswZ1Sb2dX09Gscy6lPXkRKkqW5CS1J9m/kR5puWQ70iY+j3j1n84KFvqMJjrJFLeMpgqrWEVzrrTZkx1hoADBlUDJtCGy5wTrZgFNWd8d+BuE/ZLiWLrGLYZQkHj2JAbuy8IOI8LvRu/UoChGTywzK+0YudVXTTbZFz2Beidccj9XW887w8G2R0s6Bd1BoDsXU38WhhU5j3SAM+1qvQGBtCf2zve/c6QipvrLdCX6qFqt1fz9UD5D/F2BIK35H20KYLpnPL07Vk3mNYetLNLzeey3nwvEWzhWGnVcfqNbXo7LuxC33IzND7yjG7Ot7j9Rvwzj+3giEqAqqLd5cSi2wL9gTHePfDgmildQMQO/mzDvk6+TF14Imw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4494.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(376002)(39860400002)(366004)(38100700002)(2906002)(36756003)(110136005)(316002)(31686004)(4326008)(8676002)(16526019)(83380400001)(186003)(66556008)(53546011)(66946007)(86362001)(5660300002)(6486002)(31696002)(66476007)(8936002)(478600001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zkk2SXR2MDZiZ2JkUFB4YW10VWRGWEJ6UlNLaUJqQzdNK1B0b0NZaEoyRkJX?=
 =?utf-8?B?NDc5WG5WZVRTaHNXYytrZFVIZUYzMkUrclBCQ1hGS3MxZzhWNmgzVHAvT2Y5?=
 =?utf-8?B?d2hBU21BVGRNVG53YkU2N0kra0d2cUFJdmRsbEFMaW5pR0dvQWJvR1FrWmJT?=
 =?utf-8?B?ZDZmQkl2bm9zUytVa0RndGNKd3BrQk9iOHhVbXpOQTNITXFtMGZsVlAvOVdu?=
 =?utf-8?B?eXdWTDF6MFA2VzJSZTkzK1RFRDFDa0FZUjhZMXFuY3ppd012V3lWdmtiYXlw?=
 =?utf-8?B?SnVDbldjekN5SVNzalVEeU5aSURrVEIwZEVwU1daeWZsM0tRZ3k3THl6dkJF?=
 =?utf-8?B?VklIMHVSZE56aDhaS3psdG1oV1NMZHlGdW1tRG05WTRCaVA0ZXZFNi9GTUpt?=
 =?utf-8?B?U3R0cFptcUxCSWw1WnVtRm9YSzMrNHB5YUJ0VDdrVU52eVhFbDhQTkFTMExl?=
 =?utf-8?B?eVNYb0F0WFJlY0lobktWVWZqQi9WU1dTYTNrSnA5emtCamVhZVF2RVJjRUdW?=
 =?utf-8?B?eGxmS3oya0R1ZWZ1TDlZUnB2bng5UVpiZC9rTFdxZnZTL1lYSlNBYkdiVjJI?=
 =?utf-8?B?QTB4cUh0ZG52bUN1TXBrK3JMUGtRL09BVm0reEY0SG5LZmNqQ1UvQWlSTCs0?=
 =?utf-8?B?SldrelRhVGxpU056Sm1RcXRJVVg5UkZhdHZaeVdSdXZxQXhPNFlwTllXczFk?=
 =?utf-8?B?YnU0eWhFRjNQOWw5OTQzTUtubWpMb1YxMk1xMU5GOGJ0S1BSYVNVYW4yZWc2?=
 =?utf-8?B?SGhCWkwvY0hrMkQ4TjdFSGZhdWZ5enlCK3BZK09zOEdNL1RUYytsU1lyenE4?=
 =?utf-8?B?VXdIOFhpNEs4Rys2M2R4YVhOWTU3MkgybHh2WkkxYm1EcGdsT293RWlYR3Ja?=
 =?utf-8?B?QkRCZTI5TDM2aVZqZUFSaU9SVVVrMjBGcmlHUjBpRVd0WXQzbjgwMmx2amtz?=
 =?utf-8?B?ZW91RXdyZTM3bjNNNEkrQVlPZUE3aWVDS0VEYjRkanl2MUhRUVJBYllybFVM?=
 =?utf-8?B?TkZPbnh0S2lRb3U1b1QwR2JLSzRwOHZPakdlYW11TGk4U3g2ZUhRd25NMTg5?=
 =?utf-8?B?YXB6ZnZXYyt1YzBKbFZ5cVZEZFVYeDVWTlY3RTNVWjhUSzhxRmhtS2pCN3Rx?=
 =?utf-8?B?cGtJYms0bk9DbUs2dUYwWU5uQlc4TDBISVlnYmNFTUdqK05qWlkrbHVrRnVi?=
 =?utf-8?B?YXRyREhiUGZEY0FmMVBUaEx0L1M1TVdVWVBSTEVXeTl5amVDRzdoZDNjU2gv?=
 =?utf-8?B?b1ZpbkZsQVp5WEY4M0QrYjR1UjUwTDFCaTR0SWNYUkRQem8rZlZxaDZ0U2FF?=
 =?utf-8?B?dXVHMGtJenQ3d2NsRUVyTGloRktvRGJ2VXM1S3BkTndiNkh2Rk5TRElDVjFP?=
 =?utf-8?B?VFg2dUdSakhzZmxQK0MvWTNadWRNQ0ltTDQ5K29nN2ZndEl1a3Z4TTMwcDZt?=
 =?utf-8?B?Z09UWUtpVCtkQy9UM1RvVFo3TzJRT2taRk9Ja25mengvWjRlclVFTXFOdUNR?=
 =?utf-8?B?eUlYd0xQbWJrSXpJWG9nbWt3M1NTTnlGZHppZDhkb0FGUnBXMmVWdGs3VVdn?=
 =?utf-8?B?MCtUOW0wL2gzY1VtRUwrQ3I3MThILzhQOVBvMUZLZ1RkL1U0UHdsc09ObHFy?=
 =?utf-8?B?eTc4MThrOG9Xa0ZXZktPWmtibXdLdU9wQmVjTGFxQktzTTc4NWs4VkxmcElt?=
 =?utf-8?B?Y3FPc2g5SitWcWFqS1JxN09GTVVRVHEwSEdmemorTEpndXdCWC9QeGh4Y0Nq?=
 =?utf-8?B?RHVoMGR1MmVvOTJlME1ocmE0UCtSMmRuaUNudllrMGt1bjdIa0ErMkdMR0xs?=
 =?utf-8?B?OXNKMmI1Slc4Q09LK0tRQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 063977a8-6b61-4c50-2137-08d9380ce49e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4494.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 19:10:27.7580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GYAYdIKtDqv5JfObiHfmhuoPYELsdu246Hjdun+hDMnhMFG97Jih8LyjQKjC3IUWqSC4t5cfE0bCfam+exVa2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2647
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10026 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106250115
X-Proofpoint-GUID: FPuivOo8_q82Ae2S0rLMcy-iecKTB6tM
X-Proofpoint-ORIG-GUID: FPuivOo8_q82Ae2S0rLMcy-iecKTB6tM
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/25/21 5:49 AM, Jason Gunthorpe wrote:
> On Fri, Jun 25, 2021 at 12:13:57AM -0500, Bob Pearson wrote:
>> On 6/24/21 4:21 PM, Shoaib Rao wrote:
>>> On 6/18/21 4:25 PM, Jason Gunthorpe wrote:
>>>> On Fri, Jun 18, 2021 at 01:58:48PM -0500, Bob Pearson wrote:
>>>>> On 6/18/21 11:33 AM, Jason Gunthorpe wrote:
>>>>>> On Thu, Jun 17, 2021 at 10:56:58PM -0500, Bob Pearson wrote:
>>>>>>   
>>>>>>> It isn't my call. But I am in favor of tunable parameters. -- Bob Pearson
>>>>>> Can we just delete the concept completely?
>>>>>>
>>>>>> Jason
>>>>>>
>>>>> Not sure where you are headed here. Do you mean just lift the limits
>>>>> all together?
>>>> Yes.. The spec doesn't have like a UCONTEXT limit for instance, and
>>>> real HW like mlx5 has huge reported limits anyhow.
>>> These limits are reported via uverbs, so what do we report without current applications. Creating pool also requires limits but I guess we can use something like -1 to indicate there is no limit. I would have to look at all the values to see if we can implement this.
>>>
>>> Shoaib
>>>
>>>
>>>> Jason
>> The object create in pools (rxe_alloc_locked) just calls kzalloc for
>> objects allocated by rxe and checks the limits. For objects
>> allocated by rdma-core (__rxe_add_to_pool) it just checks the
>> limits. The only place where the limit really matters is when a pool
>> is indexed (RXE_POOL_INDEXED). Then there is a bitmask used to
>> allocate the indices for the objects which consumes one byte for
>> each 8 objects.
> Use an ida or xarray instead?
>
> Jason

We do not have to change any data structures, just decide on the max limit.

RXE_POOL_INDEX flag as shown below is used to indicate what type of 
index to use and is not an issue

         if (rxe_type_info[type].flags & RXE_POOL_INDEX) {
                 err = rxe_pool_init_index(pool,
rxe_type_info[type].max_index,
rxe_type_info[type].min_index);
                 if (err)
                         goto out;
         }

And

static int rxe_pool_init_index(struct rxe_pool *pool, u32 max, u32 min)
{

So the maximum index can be U32_MAX or for now we can limit is to (1 << 
20) i.e 1048576

I am assuming that changing the limits for the objects I listed earlier 
(list below) is fine.

Shoaib

RXE_MAX_QP
RXE_MAX_QP_WR
RXE_MAX_CQ
RXE_MAX_MR
RXE_MAX_PD
RXE_MAX_AH
RXE_MAX_FMR
RXE_MAX_SRQ
RXE_MAX_SRQ_WR
RXE_MAX_PKEYS
RXE_MAX_UCONTEXT

