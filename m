Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30263B387E
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Jun 2021 23:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbhFXVVB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Jun 2021 17:21:01 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:18756 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232163AbhFXVVA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Jun 2021 17:21:00 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15OLH6wn010954;
        Thu, 24 Jun 2021 21:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=PQ/lNj9mg2gRM52abI2hQCzKGb6/ej7i4PiLpv6v+rE=;
 b=EJLJUXqrIK//CaELvTdZuk/twlx8pjxs4mg5+Dcnpfh1ZPbOjp1PxFWbuNs+Ql+zpE+q
 0bhCGV2FyVgodr9D9b7SjwwXMh7tYJixCsZ2xh2UqSEB0tb4bP4xbTTcrb9f/LzrNL4r
 CZ0rsIbN8C5B6XkYQwHYaVbTrBWuYFtKz3LZI5J2rJKa3MjhfUwJRhcgm/ENht+vDZ2E
 Ae1fxOZs3y+7RaJJc7uzD9v4/qYyHL19rrjlCGrVUBzUn27JIcODHZ5Wlis5sSIdOR/X
 pZMU9t5EQV3sM1i1/ROtzP2bCao0VgAZ/oZywB0cP0AysXmlQ2S41gkLJrWy4i7yqS48 4w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39cmpxhxds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Jun 2021 21:18:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15OLFOmJ177666;
        Thu, 24 Jun 2021 21:18:38 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by userp3030.oracle.com with ESMTP id 3995q1cg8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Jun 2021 21:18:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVovVYBgrgCgCvGBWjSMe9HYyegY+R2VwukIPnTw2jQ1+Ft9b8Brci9fed9IyUTY1HhXb8OpbM1tvVtF5pnYNmBVL1aMYQEY0c9VVFFYSYPMOatuqK5T+n+8OHklntF9HURPOEt4qZJyMDglWSbMpSGBSDdymvHOuM0XiA52daNv1tSaxvMAChAnYVfIkMn51LMST3TqITIHt05pnMUYP6/kNVi/lYP2MTLbvyNSWqzN4RrOWq5R3yFTMbLhi7QP4HIDhjRj+M2+/I9jo2Ak1YgLK0uU6JHQKQ0L82S5/4KLqcC25hl8pruCp214SoGpuSsOy/PfRbIpGsqc0yHSIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQ/lNj9mg2gRM52abI2hQCzKGb6/ej7i4PiLpv6v+rE=;
 b=i2yifIapI14S0X/VVofsH9eisXxtZQ/DpYcEZt/i+AI/igpyRBrZT9XQIPcCJRChFx9OkarRZEO7s2LBA0mnytmq57z/nnBoB0q6zW37f6X4eBvr6Cxsr1CAu9pPxNfcrjwqaBhPzjW1//pLPtaKPoLX8JqBCNz1qiojSQC5KEoHW/gOzE8yFXVH0/9q2RoUrV5YhIV2iLgnxJlGJa5lUhP1VE8Y0D2PaTqAM30lBAgSeLgnxf5y1xBezRjTgVOzURBJR5H97ySQ1JJnZr/moSOSIBbYtzG89CkptVPhtU7QzE1XjdOBGrGmy5X5gGjPDdMk5rWnxUBl6SIEw695+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQ/lNj9mg2gRM52abI2hQCzKGb6/ej7i4PiLpv6v+rE=;
 b=vR86VtLal3vH1W5YTocTNLJxRn+/gtX9qbt5vl+HDMwnPHcePMLzALnjs/XSC6c/nphXOa7ox4F6B6F78JOyCmUQz6ciFnBlFSbrbGMQWtmJ5zy6ywqU+tXZnP57eHJalJ9/UEo1Px82rNzbX3GbgbuhcM87hP7vlJBYA9bt1Xw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 by BYAPR10MB2694.namprd10.prod.outlook.com (2603:10b6:a02:b2::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Thu, 24 Jun
 2021 21:18:33 +0000
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::cde8:567e:da77:abdd]) by SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::cde8:567e:da77:abdd%3]) with mapi id 15.20.4242.023; Thu, 24 Jun 2021
 21:18:33 +0000
Subject: Re: [PATCH v1 2/3] RDMA/rxe: Increase value of RXE_MAX_SRQ
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
References: <20210617182511.1257629-1-Rao.Shoaib@oracle.com>
 <20210617182511.1257629-2-Rao.Shoaib@oracle.com>
 <20210622183502.GA2591169@nvidia.com>
From:   Shoaib Rao <rao.shoaib@oracle.com>
Message-ID: <03abb741-8183-4b8e-72ee-3a56564704a4@oracle.com>
Date:   Thu, 24 Jun 2021 14:18:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210622183502.GA2591169@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2606:b400:8301:1010::16aa]
X-ClientProxiedBy: SN7PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:806:f2::14) To SJ0PR10MB4494.namprd10.prod.outlook.com
 (2603:10b6:a03:2d4::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2606:b400:400:744d:8000::233] (2606:b400:8301:1010::16aa) by SN7PR04CA0009.namprd04.prod.outlook.com (2603:10b6:806:f2::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20 via Frontend Transport; Thu, 24 Jun 2021 21:18:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7243593b-a40e-4792-881c-08d937559f44
X-MS-TrafficTypeDiagnostic: BYAPR10MB2694:
X-Microsoft-Antispam-PRVS: <BYAPR10MB26943B426B6C491503F004E1EF079@BYAPR10MB2694.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZQNephvAR4xdIj/U1xpdC48lHAtovUf+vXfk6RkxA0GDQaKoxRtnz4C1voy3kqAvl/ToO9Whjcr+RpTHQqDr45Y+T0PtGOuiyddiIiXFpUOlwcMijHNubP3EtKZDI1XZm/ll3FeuWPdGNlWXXiJTukKnIJxgz6VoDQejsJnzv7MUFs8+c1+XNlgFzGQsDdRIgZ6NjHtkd/E2mNz3arej/p/EBlTDB6lsnzEQsmAYCY4LBRK6fCrlF9YE9rk+lsJbdg/emQzfsfPAsw/f8Om5vVVdlSp3Iy979ZHwgDBP9Rbvx6gsuCiyBvEaTEizijfPJKGHuK2Ll4Kgy0hNOBrlFAleGKfhlq6wHQJUjYvaUr546v3t9rZrnvYudtjfNQ0bbWD8QBqKkVWrxaGNlMvwivo6h1sUA48ylca49G5/tm3hEKiJ1LRrCIuqkNcBKBDgxOU36NSnpUMFKXh5oIbnY3sJzTKDewM3CNCVM0IGPumaRUSPvFf8cdATy7KNAt62r+x6wWpl+enWNpCJ9sM4HGuFzwArHpjkie5dGs0HKlas0gSU0YlWV/Brlpvd80pilv8jX1xOv9qYr1Mn2C/yCJL6QGMSaUXafSjoMcCgFb8+zHngi3OnYHTmcN3Y0AsHlJF6YH31KfJ27al7Q4UPVM3xyuk85RHAXv/aaxOjcPWFkWdDsCYaHlm/0/XwADQF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4494.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(396003)(136003)(346002)(39860400002)(31696002)(8676002)(86362001)(66946007)(2616005)(31686004)(66556008)(6666004)(66476007)(8936002)(5660300002)(6916009)(6486002)(36756003)(38100700002)(478600001)(316002)(4326008)(83380400001)(16526019)(186003)(2906002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEE3c2wvMUYxR29LVVUyV0toY3pGaU91bTQrcDBmd0hWUm14dnFEU0VUUVE0?=
 =?utf-8?B?SjJtYzJwdyt2aXdwWG56dEpha1l6U1BVZ3g4STl0ckdzYWJOZllzWU5XZ0NP?=
 =?utf-8?B?VS9JK0dpUEJpUzkvbmpwUEZVNGhUb2pNbThQVmE4bWxZVi81dThRWFBwbFRE?=
 =?utf-8?B?SjF2WTBvMHBCVGpCYnhDWHJCcjkvTjFkZFBRV1hFWWw4UDh2d2JjbjVyZ29V?=
 =?utf-8?B?dnB1WkUvM0RvbVJSOEpWY1VRWE4rbEJabDYxbE9tRkZwalk4V2srTkk5Y05K?=
 =?utf-8?B?UHZVYzhibVJLck40bkxpWmNxNUNnbm5DUW5aUUNyWFlpVmJwVFh4Y212Q1RO?=
 =?utf-8?B?bXZtNmIxdnpZR29mZUNQNFhhR0hNVWI1eXdOQzg5UTRhTGN6S2l2c2k4WEVJ?=
 =?utf-8?B?eklXZmN4RW5NK2V1dGsvUHIzSDBWU2Z4RHNtZXpLRURiWkhmd3RCTXpzYzJo?=
 =?utf-8?B?VnBpQzZxTlVJb3pFT01CblgyZVZwUUkwa0VIdFZqTWtwak1Yclo5UGtjMmdy?=
 =?utf-8?B?bDJ0Vm45d3hnM2VPbU1jTXdCbTZmV1JNQlhFREZ4cDVkRnR6ekIvaVFkRzFu?=
 =?utf-8?B?TE8xdlU3dHJmd2NsZGRLNXA5bVp2cGR0UTYvMDRlTTVET3pLNGN2Ri9LdmZ3?=
 =?utf-8?B?QlNSdHhVNGtaZEFxNWZuWi8xMGZXRU9WVjdiRDdVT0VEUGQwTk5JYWRFNitS?=
 =?utf-8?B?Wm9jWUVkL1ZiTi9qb3F5V3BxeUhWM0JVMU44ZTBOb2xZRWQ3QkR2ZXBhdk5M?=
 =?utf-8?B?TFlRQXBSR3Izc1JGdmFrNzZLektwMFB4dTNIN2oyc3hiRDJMNzNFaFNGMi9Y?=
 =?utf-8?B?TzBMbmpGN3RnaFRzYmRGNnhnS1h2MGJ5VTA4eCswWUx1N3Vpc2ZyRFkybEp5?=
 =?utf-8?B?dmtLQzJldXNzNzdhTWpJM0lGZjNKM1FDaXNEQ1RpNDNZZzNYUVgrMjl5dlZW?=
 =?utf-8?B?dW9ZSGtaclBYNDY1RXdqYmdWdHgyT0MyZjRjd0NlT0xEVTVGYVpWUll3OW5K?=
 =?utf-8?B?QWQyVHhDSmlwVmFibGFicHdEVkE5WUlvUDdiUzRnRVQ0L0RUcHNUeFY2WVY4?=
 =?utf-8?B?MEEweVM3L2E2RFhhcTEweDk3V2kzbUwvaGdtc0NIMVU0Vi9BS2NSTStLaUdJ?=
 =?utf-8?B?ZXZyZjVTSmJLanhIb3BUdjlpNUZ2N0RhamlCeUFiUVhmT2JqcXdwYUVONTl0?=
 =?utf-8?B?SDRORTV2VHVHYk9kRTZtb3E0SGpRaC90Q0svc0JXTE05UU4wcVJpeG51Smo2?=
 =?utf-8?B?QzJkYlpxa29WRWQrVlloYm52aDlpK2t0Z085VkJ2NTZSeHB0L0Zod0FqU09L?=
 =?utf-8?B?N1I5RlMwYUUveXBIMUxjQzZIa2I1bGdIY05sQmdUTG9BVEJzb0dRNWZtTFVO?=
 =?utf-8?B?WFF2blVrbGMvR1cxdzVrcnVqZ2tvZzc4bE5kS3RqeVRmVFlrc1g3RTJXa2Rs?=
 =?utf-8?B?bDRWQ2JQZUVzZ005WlR1S1IyY3hpbTZXVWxBVzhPbVdPekg5RjVNUkdUWkdU?=
 =?utf-8?B?bWYrRVpvTEVFTmhBenVrM3JpY0ZpK0pwUjZIeVZuK1VwdkdNZHVkUnJZK3F2?=
 =?utf-8?B?NEhRTTBvc01kK2srankrZFZsZ0l1blZkZU9Ba1RHQUM1VVorcEJ6RTlTY1JE?=
 =?utf-8?B?Wk1pMVRGYk51WG9qTGpOa1JJTXF5VmdMNmFmSnh6Mk9zMXpPMlV5Q3MzL0hx?=
 =?utf-8?B?K2t0dlBaUUJ5SkIrSm1rQTdVM0pPTXZPTThMaklva0FHZDVVUmJVc09SZkV1?=
 =?utf-8?B?U1lwRGtiL2dmTFFKMlhYT09LaC9rNTVUelRjYXFvVE1BVFdRalNDVWIvdzgz?=
 =?utf-8?B?d3kyQWwvTTZUanRUbnVKQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7243593b-a40e-4792-881c-08d937559f44
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4494.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 21:18:33.5025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w8n3P8KqYvWAnfVdo9tQMooORquJCBgiBv0GszT98mKD5jD8MMRQ/iRGjUUYmKMsNZCnpBTd4SHc8vz0TReQgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2694
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10025 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106240118
X-Proofpoint-ORIG-GUID: DzaXj5v_rwm7NblDRYnj-oL3_sYemcrE
X-Proofpoint-GUID: DzaXj5v_rwm7NblDRYnj-oL3_sYemcrE
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/22/21 11:35 AM, Jason Gunthorpe wrote:
> On Thu, Jun 17, 2021 at 11:25:10AM -0700, Rao Shoaib wrote:
>> From: Rao Shoaib <rao.shoaib@oracle.com>
>>
>> In our internal testing we have found that the
>> current limit is too small, this patch bumps it
>> up to a higher value required for our tests, which
>> are indicative of our customer usage.
>>
>> Signed-off-by: Rao Shoaib <rao.shoaib@oracle.com>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_param.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> Well, this doesn't apply anymore so please resend the series. I'd
> prefer you try to get rid of any hard limits that are not exposed in
> uverbs someplace - like ucontext.
>
> Jason

Jason,

Most of the limits are exposed via uverbs. For example, following limits 
are most likely to be hit by a user application.

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

However, they are reported in ib_device_attr/ib_uverbs_query_device and 
these are the limits that I am interested in. So unless I misunderstand 
you the current patch still applies? Kindly elaborate.

Regards,

Shoaib

