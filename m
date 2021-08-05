Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B503E0DF5
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Aug 2021 08:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbhHEGLg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Aug 2021 02:11:36 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:37332 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234461AbhHEGLf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Aug 2021 02:11:35 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17566B9r019679;
        Thu, 5 Aug 2021 06:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=kHiG7mZJlcY79RqKXxXgElBt+WS688NCtF7PRWgY+x8=;
 b=A2y7CTzHnjV7zYxVE8SztDbLplzZ3gQ5sjOfS4Pjg2SYbzwzp374D88nb3VnUTbm1NQW
 wpWJW8Sfr8uyKlDQwmTFGppbZ0gLIZY0KIgyLl5OgFjJWnP7GaWm5aA3o/knchZgsPpf
 O+R6IH+WGX9n/dq2/WkaL0xknryiMOcnWhp9Yo+uWQp25iR6jvktTP8YSfXk2DzP9huZ
 ZMO18kYljIJkxWIwtjzQcSDq4mQM78LlTh6gzsp8lX8drr8Ncfum2U54QuOAbU80NKrE
 1cjIvJcZAaIl1ybcVrILTqLE9vrd2yIKmj08TZLIBiu6SO5qNOSDfu6peDqNzFNE35P7 4Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=kHiG7mZJlcY79RqKXxXgElBt+WS688NCtF7PRWgY+x8=;
 b=cfQW68lyeNkkp3f67I1wgufVEsVqp9jGbMO6wWUrkxiZxDXEn7bHThsc6JzevntDJWgC
 fGn36U199kH6BI1bsvzqaS8QShps5kXvZT5TdoGrZGnE/5CLINbLqgvvlF/PVBj8DL5n
 2quGhSK7yy2PBR8MgJ0WeLjcrZ/28qOBP+KuwFY0wUPH+Uqpt+HuWCTjOFmxQuZ+Ndpl
 PfuveHt89LgKzt6tzXwWKax84fqZIeCWJGabfqz7IKg5ypNKeBOWu6POiM+dU+bpdToQ
 y7KqbJsQi4TjKutFttdZRpr8M64YlbX0b2zM9yUZLmV7jLHVZ4fEbXf6yzhEsWQdfqvY Ag== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a843p8fpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Aug 2021 06:11:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17565XdI140639;
        Thu, 5 Aug 2021 06:11:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by userp3030.oracle.com with ESMTP id 3a4un342ej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Aug 2021 06:11:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ao4E91Q4KmayvzBKKCpqNqke0Feyrnl1H12oZVY5K2yiD+OQbBp5JnsxZH77oO+ob9XAmCr/twe5GYS6C6f0I8uFjyw8i0X4dfHjkhIUTRJVLoZs862SiBvfGEE/o/6tW6qP5HdC9KNLWwr2gXMzCOShOaMvt3TVIknZYpOHJ+p1MPZU+DEjnWIobxVT1u7/pU/ebqN+WmFvx1X0N6SgfoL70T8w5RJytyfhFv7e/KhWObWhAdw1MOE0FPhdzge8ZEawmX7h/ULZ5Wv/1VCBLSZdAo/7ypf/TqWWGHqd/Zv1eeQAO5oOzLwmmURiCd90ha7y0Z3zUOtXst8QsIjeEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHiG7mZJlcY79RqKXxXgElBt+WS688NCtF7PRWgY+x8=;
 b=YtYOedgggp1AspgD1BOsV1Av3J36RdW/XBT9WlG2L/hg+czp53LDllQxFMc8hoxwbevKbQ/7Qq36muXZ1mD1edUk6di+kKJ/hmeOK7vuP9PtScXUTA7kuzjecanmcujIlOCwIcSx8sRzNkdvcRHrRebhNT2bzE4mbHiYUk8/t9o8DxL1640PLuzYplVCjn+nDO8cNhDHjwrLDGFzAZ28QDA3qCSk0hMnYYt7WZBPtxPX2HSaTBBN9ffP2shTbOzIlrPTABhtgNMD921JnCT4wTwMHFV3gUqi6Ngl2qToALPXt0ngLX6+HmV+Lj3VJ4eD3SK3uNclk/BZP9+Ct2uaeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHiG7mZJlcY79RqKXxXgElBt+WS688NCtF7PRWgY+x8=;
 b=O5Z+20fYMgL1FT7jyWQCjXr4hVHqivSreC9s+HOHzS07qHig1A4SnpIY7qv+/Exyes1J0hCe1eyQEzEH2s/E3wgpmE0oI6tQQqbxxpSVgEAhrLoE1VKiD4Rtfpaj8hcDVE1xykzJ46yj58L+6omYYIAsRFAD6bL/HMUGIISM9uM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 by BYAPR10MB3559.namprd10.prod.outlook.com (2603:10b6:a03:11e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.24; Thu, 5 Aug
 2021 06:11:17 +0000
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::588f:a774:17de:1d1b]) by SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::588f:a774:17de:1d1b%3]) with mapi id 15.20.4394.017; Thu, 5 Aug 2021
 06:11:17 +0000
Subject: Re: [PATCH v3 0/1] RDMA/rxe: Bump up default maximum values used via
 uverbs
To:     "Pearson, Robert B" <robert.pearson2@hpe.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20210718225905.58728-1-Rao.Shoaib@oracle.com>
 <54817f70-e7e5-d145-badf-268ba7533110@oracle.com>
 <20210727174144.GE543798@ziepe.ca>
 <CAD=hENdOrfyq2buP269LQVhq+QkZ=hpA3jpbZH+CAFt=CGLV-w@mail.gmail.com>
 <6687ea04-c402-1b4e-dce0-386d29948ecc@oracle.com>
 <CAD=hENcTYfV1LT1=_e=eCNxdjr1Nmi+R3hH_CQn70MGRTKG7LA@mail.gmail.com>
 <eb24b781-396f-5bb9-89c7-3ca0f8b83849@oracle.com>
 <20210729195034.GF543798@ziepe.ca>
 <DF4PR8401MB1081385A8812159BA8E96A03BCEB9@DF4PR8401MB1081.NAMPRD84.PROD.OUTLOOK.COM>
From:   Shoaib Rao <rao.shoaib@oracle.com>
Message-ID: <d89b2a2d-e72b-4942-28d6-c2a528053416@oracle.com>
Date:   Wed, 4 Aug 2021 23:11:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <DF4PR8401MB1081385A8812159BA8E96A03BCEB9@DF4PR8401MB1081.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SA9PR13CA0102.namprd13.prod.outlook.com
 (2603:10b6:806:24::17) To SJ0PR10MB4494.namprd10.prod.outlook.com
 (2603:10b6:a03:2d4::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2606:b400:400:7446:8000::8b5] (2606:b400:8301:1010::16aa) by SA9PR13CA0102.namprd13.prod.outlook.com (2603:10b6:806:24::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.4 via Frontend Transport; Thu, 5 Aug 2021 06:11:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37f6ac8b-18a9-4a67-48c0-08d957d7d5f1
X-MS-TrafficTypeDiagnostic: BYAPR10MB3559:
X-Microsoft-Antispam-PRVS: <BYAPR10MB355926154997B7D58586EAEAEFF29@BYAPR10MB3559.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: taef6pTetzOKh45kR3FeegLoOqFT0MdrErthzTeu+tdJ6iQ6DjvM8rXziD2pOqAjlNRhvuMp4/ut0/n+cnsi62cwBj+e2fy2uuVbIF/JUTLjtvlar8xZuNzl2400X4xraHj+aCzJPQ7Ro0BBw+KmseGcXt5kHRhE2quZi6ei1TS3SgNmmCPb8lXcN22xaIQJxVMhcBxLllLx1+/1Qs77//PN9ULALVP/mSYrgSN9l4sALVeJGRiWmcBOBZxywWCD6LBA/CAYF5Ubl9YwtL7yMJdGdFRHXkj7BnZO1/fqCnlck2DVy7i1d/yccG4OZNJeThky/c8/14IY7AJDHiOcHy0Ku2sUPGUApk+v97tJt2RwAxuFz71rmtSIW7WjW/dzvWfp/TyA7+r2NY4ZwhZBcXSmC+Y4mvNI7W4gvMcu0Zi01GBs6kjHky8ZnWjVuPDXnOt4RP8yovbLXAyYr170Fc6X+iIwr6e8xzEVaHfvgXMjPyBw0nr3F9s1LVY20miRF6pBC7FMRza4gIsEc5d76mJhsYU9Nqo5bWI0w+P0rcwowRqiC2SQBEJqeW9X/xZTreTCuX9hEtFW786O36a+N1cBuEao+e3U0Lgyd1h3H4uRC3Zc7Mf5vjtECmkZZBdigBa1XdioNpTvPLmi+BMyxkZRduB+ElS+tet1F2T+3aXFKWRuS0C5tFBDELV9N8zfXyV/FEx9Ju/ckJ8VAWYvp48OOJCO61tidldJIrvewwH6NfH/J3uB49yrDnYC3TR+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4494.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(376002)(346002)(366004)(136003)(66946007)(186003)(8676002)(2616005)(31696002)(316002)(5660300002)(6486002)(4326008)(478600001)(66476007)(2906002)(83380400001)(54906003)(110136005)(66556008)(8936002)(86362001)(53546011)(31686004)(36756003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTNWbnhVY3pBMzQvb1VmeXFYT1pycWFqOHV3ajNLc01KV2ZqRWFLL0Zya2pP?=
 =?utf-8?B?eHhsWUNXSUg0eDNQaCtoTmRoMmJDUlZLZzBjTkw3bTJkbU9WZjlUYU9kcDky?=
 =?utf-8?B?RnkwTEkwcjBTcDJoZk5mTVg0NjdhNkNYZzBWNHd4NVpIRmFIaWcrbXdMTUFq?=
 =?utf-8?B?MUtjcmgybVhjQnU3dXp0NGxmWTJvTE96UnNaWG9sajFXNXFlQkcxZ0JsdW1F?=
 =?utf-8?B?WE9wWEVkb052WVVkek15dG82WGpGMDZkSFlaS3A4d1lHRThQc2ppWXZLMFVk?=
 =?utf-8?B?R0NtZG9SQVYyeVdRL1pzOEU0UWZxZGdhUEpHSGpFVHZZU3RNZkZtaW8rbWdi?=
 =?utf-8?B?WldPdUUwSkJTR0lVODFZZVBUQUtrSUJtMlo0VlJGRWdEUjI4cEZqRkphUTY2?=
 =?utf-8?B?MDMwdkhBamNMWVRHMDAwSlc0WUJ4Zno3SFM3YzNLRkhZUlV5ZEFMS05qM3VS?=
 =?utf-8?B?VzNuS1k2bklTc1ZRS2wrblVFeGFna3lJVzk4WWpjTHVNaXErenM3RUhiN3F1?=
 =?utf-8?B?ZHF5UkNvRHM5b0xqczNPOGlVSFlRSC9vS1hNNW9pbk5UME51THovcXdSUmZD?=
 =?utf-8?B?UDFHcXJzaTVKbnpreWRYVDMzcXk5UjRjSGM5aVRmVkU0bEU5MndGYjMvQ1gw?=
 =?utf-8?B?U3hES2hoZFFsbnhYaklDc1hyUHYvVFZBYzJ6clR4cmpBdGM1VjE1L0VNcElp?=
 =?utf-8?B?OG1JSXhKeS82dy90ZnoyTFZyMWdIS3JNUlRZd3JQODltY3NFWXpHb29XVjA0?=
 =?utf-8?B?TGp3MHg5cWxLbGdsZ0ZuT0NER29JS0EzekliUVcxQVJXNlUwbmxyckM1Zmcx?=
 =?utf-8?B?SUZFMU1EZ0FlN0RIRW0rbjdCcGVrVU9ZOTIrZjdUaWppdiszM0RIbE4yZmZl?=
 =?utf-8?B?bS9SVGgrMUdmZmpLSitMRytpR3VySkFtNG9palBXcy9wbms5anZEdEFZUXpq?=
 =?utf-8?B?VmZ0U0E3ejlOVzdOL3hJTHZDMWtqZ2gxV1hxMXZZZTc2NTFPUnNLZGpyVkFK?=
 =?utf-8?B?K1JTc1pyQVAzcmhkOUJXbEFvdDE2R1FlUE1FM1pjajIyL2FzNU9YNWFWeUlr?=
 =?utf-8?B?MzVjcjdNWExvQlFJb0E4SWczVlJrL0w1c2hSU1FQVG50QmQ3S2FJSGIrRFF3?=
 =?utf-8?B?S01GUlQ5VlAvc05qd1pkbyt0Nzl6ZHFPbXFpbk1lMkNZM25YOGZ2dHdzMm9q?=
 =?utf-8?B?YTRXUWROb2tBWUpCWlNEVndvQmZHV1VLTXk1U2lmNTdqcStZaEx2enRxUTVz?=
 =?utf-8?B?TkR5V0ZhNExubE03Sk5hcE0vOWd1L21qaTVKMW5VbFJiZkZlc1pwYjJHak5W?=
 =?utf-8?B?ZzNVMTRzNUdHQVpZWlViakk2RE5JaUVKNGYxeGZjMHQrNG8yNjBWM1lHU2p4?=
 =?utf-8?B?YWJTcHFQYm1jQUxFZk5mQUQza1RSSEdPUzhDdFk1Y1AzOHIzY0htTzdGSWx1?=
 =?utf-8?B?ajAvT1AxOXV3MS9jcWQwdWRCUi9HV3VKbDdJdW51RS90c1lEZWN1M3ZlaHNq?=
 =?utf-8?B?WjU4MlhvcUVTUzdTQkpoa0YvSzRCcnBwalBWOXd1NkhLZUhNeTRYVkZraVM1?=
 =?utf-8?B?MHFlbVlVczZtK0sxL2xtR002c0NBTllWbGhsVVFMZUZuVXh3enNNd2tsbXR0?=
 =?utf-8?B?YnBBWjUxREFHK0N0YVU0RTFZSjUxbEREcVdXeHN3UnR2bHBLS2pzV2ZFOW9W?=
 =?utf-8?B?MWtVQUc0WnE3M2pEU3BDUWx6UVd1Y0U1MGMzRS9Lam9NUERGT1o5MFAvZGxj?=
 =?utf-8?B?TFhETmZyMGRZZmFrM0YzT3dPNmVGY3hUMThBRDFMelAyMzRWQ1ZRMFNZN002?=
 =?utf-8?Q?iZajaoXb7dHQx/GKVXOkvxhiKN9FB4BjlZ+Oc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f6ac8b-18a9-4a67-48c0-08d957d7d5f1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4494.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 06:11:17.0452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 19X4xoWnatNrWaV9aSq1W5YCKbThUHS8HacQIgulm47Lf/stbfemHyRvPBO9uLUDV8zxQjZqb3UPqoJSqaPONQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3559
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10066 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108050035
X-Proofpoint-ORIG-GUID: COYZTwi2OK91Z3XZlPQOqOZ8cZWgM_e7
X-Proofpoint-GUID: COYZTwi2OK91Z3XZlPQOqOZ8cZWgM_e7
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Bob,

Your third patch has an issue.

In rxe_cq_post()


addr = producer_addr(cq->queue, QUEUE_TYPE_TO_CLIENT);

It should be

addr = producer_addr(cq->queue, QUEUE_TYPE_FROM_CLIENT);

After making this change, I have tested my patch and rping works.

Bob can you please point me to the discussion which lead to the current 
changes, particularly the need for user barrier.

Zhu can you apply Bob's 3 patches + the change above + my patch and 
report back. In my testing it works.

Regards,

Shoaib

On 7/29/21 4:08 PM, Pearson, Robert B wrote:
> I found another rxe bug (for SRQ) and sent three bug fixes in a set including the one you mention. They should all be applied.
>
> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Thursday, July 29, 2021 2:51 PM
> To: Shoaib Rao <rao.shoaib@oracle.com>
> Cc: Zhu Yanjun <zyjzyj2000@gmail.com>; RDMA mailing list <linux-rdma@vger.kernel.org>
> Subject: Re: [PATCH v3 0/1] RDMA/rxe: Bump up default maximum values used via uverbs
>
> On Thu, Jul 29, 2021 at 12:33:14PM -0700, Shoaib Rao wrote:
>
>> Can we please accept my initial patch where I bumped up the values of
>> a few parameters. We have extensively tested with those values. I will
>> try to resolve CRC errors and panic and make changes to other tuneables later?
> I think Bob posted something for the icrc issues already
>
> Please try to work in a sane fashion, rxe shouldn't be left broken with so many people apparently interested in it??
>
> Jason
