Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94C5426012
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Oct 2021 00:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbhJGWzz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Oct 2021 18:55:55 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:41782 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231825AbhJGWzz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Oct 2021 18:55:55 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 197LpSMo021644;
        Thu, 7 Oct 2021 22:53:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=E9U8q9A8VPhJk9xM44l6UXy7gQwlWzUQOAvBASSWOic=;
 b=wiEJOiwu1jJl+yz2UA5RawGIMtKmBSogHPer76pEkH6Hc0y1ieKNHqooRMlME48/qp+j
 8GGdEwZcBf5GHcFUZBZsB7JISNpWj7lb45gowlHOQ+O4umIU2c8ntPzfXi84HTk9004H
 03i/0lsZSBoF0AnPvryC7AVEV06TLJMrP+5cOnsx2Jn49ExAJOTucWoOW9aWALPSYhqU
 R6W1ru5ivhA3CNzhc6q7nBhvkJA0LiQ8vpyt0wfnob6a7PNc8QEfc4Znfla+RCHoOn4y
 UG2fGI9fyAVFpw2XSWHnIThj0t81BViq/ERYHd6fLbGlgH3qQkMaK7n9BYIOa0cnA5PU Yw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bhxbs5ed4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Oct 2021 22:53:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 197MenZa096929;
        Thu, 7 Oct 2021 22:53:56 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2046.outbound.protection.outlook.com [104.47.74.46])
        by userp3030.oracle.com with ESMTP id 3bf0sb076k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Oct 2021 22:53:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIX3X7XhHfNwCljXgUnrp7AzeBPOTa/GFTWJEx6y3lVNo42Tp6LXYoTFDwNop8M0SNLjMiPRF0Fz4aQNrvRd0jGbauP4DbKRkjYKfatqxBR/Bn6NB679jqpYGZaK1ie7B5aRYpSfz3yT1EyPLZ5OKm0HB/YnQfIrrowRCRBvy4RQVjPB/3BtKJk33YVCRYA0XzrIM6FRf69FiZhsVP49xsbM8RqyeUJZdoiAbEfZX0Du9LKuYE8kL9xI49Qax+zfUBafByam8OQqWyLEILvM8vwnXswtllykavHis7Nj8iE3YefhkJDWWrEUs5Q4v9BiXBV0ZbMi3hNE+bxv6BsjdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9U8q9A8VPhJk9xM44l6UXy7gQwlWzUQOAvBASSWOic=;
 b=BE0u/FQKTX94jU94dg0uFpVXCSj/e+Ci+2+6FhKxRIdcr5OugAqozK5AqsyEYWw5PGpuwM8uOTCLbJikjA7DUzjcJOaY9ZmwH//97x1u0zoQM6NxBmJqquxsCPT7rk5KDeITNA99xXePZCbcnIDOLRvEISzvkDNupi3L9m2ZWwHvoSgQmnOmKz13QJp0hwa0FK0DFTaG4RBAc5Yuq5uK/11Na/AjqZnvJIVqgRwYEyqJGWFkQZ3eGEVnp1a2uaF/YnHeDmu+rdgfjcI1DvWmJf0XJe9YU7YQgPif3OqBlspTJMTPFckejk1LYqgKgBaH0NFQTPjkIffr4I5V4yD5Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9U8q9A8VPhJk9xM44l6UXy7gQwlWzUQOAvBASSWOic=;
 b=YoCS6CRNlXRtFr0wq5FNiVS6ad3tWwYCNqx9TmUjocbIB7rmQO4jH+pPGwei4sBXdQlP7ZLc9h5kHSs4i20tIXQ/UbpUVc3Bl/vrKG18qpmR8rkaViT+dlhtdzpJsqlKgX4QyyMHuUqkKCLkXuwSYrHB4bRF23hQPo2oGCLDxrA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 by BY5PR10MB4209.namprd10.prod.outlook.com (2603:10b6:a03:207::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Thu, 7 Oct
 2021 22:53:54 +0000
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::d41c:d8ff:89d6:8457]) by SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::d41c:d8ff:89d6:8457%7]) with mapi id 15.20.4566.023; Thu, 7 Oct 2021
 22:53:54 +0000
Subject: Re: [PATCH for-next v5 0/6] Replace AV by AH in UD sends
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20211006015815.28350-1-rpearsonhpe@gmail.com>
 <20211006193714.GA2760599@nvidia.com>
 <8fb347bb-81b2-2ba6-a97c-16a5db86541d@gmail.com>
 <20211006224906.GE2744544@nvidia.com>
 <086698cc-9e50-49be-aea8-7a4426f2e502@gmail.com>
 <20211007190543.GM2744544@nvidia.com>
 <5e8ff897-ca98-4dcc-a731-2bf150011fe9@gmail.com>
 <20211007195731.GO2744544@nvidia.com>
 <0d4b7d5f-c9fe-1515-170c-314d49feb974@oracle.com>
 <d5ff112b-9607-fbb3-bc8a-902c89eb3eac@gmail.com>
From:   Shoaib Rao <rao.shoaib@oracle.com>
Message-ID: <d9ad0d1f-154a-0430-3d7f-996be2204c09@oracle.com>
Date:   Thu, 7 Oct 2021 15:53:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <d5ff112b-9607-fbb3-bc8a-902c89eb3eac@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SJ0PR13CA0204.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::29) To SJ0PR10MB4494.namprd10.prod.outlook.com
 (2603:10b6:a03:2d4::12)
MIME-Version: 1.0
Received: from [IPv6:2606:b400:2001:92:8000::45] (2606:b400:8024:1010::17c6) by SJ0PR13CA0204.namprd13.prod.outlook.com (2603:10b6:a03:2c3::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.4 via Frontend Transport; Thu, 7 Oct 2021 22:53:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84f29351-e6c1-49f5-9081-08d989e55665
X-MS-TrafficTypeDiagnostic: BY5PR10MB4209:
X-Microsoft-Antispam-PRVS: <BY5PR10MB420968ED9F24CE16984FC2C0EFB19@BY5PR10MB4209.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T5jRi8ehd40rNXAiqJd8wcZ1zHmGppX0yWocJCVG7+FQ6zZOCW3X1A4zmadMQPiqUzeQl9RGYx3jil3sAO8og6XuWjWXkF2JL1hofHlcnN86k9LR7/aEmHxmlZN/DRvW75PNQWOkp7Rh6pXBjp4vveRgjVvZk17CGOaU6+dJjWD8XL/Gg+LHjuCCtm+2pEFD4gb3e9u47Mp3URIvGETiQab4lr2i5A3wcpDUq6bAL4P9Gu1QyK+3lXnmckOoor6HxWn39D85QLcVS+yeZxMx7+9j4bt/b1wcX8odziQXP8rjeY3ieGkN5Ny60qu7Y4bY/2rv7CjCl+p3/i3TwM2PA0WhbzfKDyxg0R3XjzeVSiVGQWy8iKhjmCDUh5Xtvh+PHn02iydoyAPEAfbY8/WicEW5OAadQ2BPR0yTFfUyqn1RSpMvE90KIM/RAF0/T7j2TjVMs94LCokTaEkPZFhuDcRIap3d4QVZcj7CkHr9b+2NYKvdqVKTdF4WoDsXpQSj5d6yv7IdWI9Y3dEtPH1wU20bXzRzd/FWWGsO6P9L9W3wz/QvMV/lcFGE0G41HcFckcI4sSV2IcB366KRIygm0bN/KTZkj8n4/2+uqlw6RgIS/QVZaZWDMVx5ulOYHHaTwq71Mm/Hgfd6Y3CcAZHfqLsvJoT3u5w5Kz01DTgsIEURDcIGoSXQT2x8ssGB/bm9f4Yq6wmv1JqXDQF0awvIjS4h69yZX3Uwwr6rg8LoRc6NTK/YiPNSdUYE2r526DuE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4494.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(508600001)(8676002)(6666004)(2616005)(31696002)(4326008)(53546011)(110136005)(54906003)(31686004)(5660300002)(38100700002)(66946007)(6486002)(66556008)(8936002)(36756003)(66476007)(2906002)(186003)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGVTdUVNdWdBc0lVRHYweHhlTlVPMGczNnhIaXowZFl3MkdXSy81ZmNGVHov?=
 =?utf-8?B?NXo0SjB3eFVNRkNPMzU5TzNISVlVYXovMG5HQ1pEOGJFQitoY2JxN2JiTms2?=
 =?utf-8?B?c2JobVN5Y0Q1UmFlUnloNlozUHR0NGZDajNwWCt0Zk80NURyYWlLR2xROURt?=
 =?utf-8?B?ZmVTWWNDSkF1eVlabU14RnFlc3FwWWU3UEs1QWpUWk44cGFZRVJzSVJ3U08x?=
 =?utf-8?B?aVE2MTkyUlc1UHhGOWxOcGo3QXlGdnpwQ0xlV1o0UVE4TG1MbEg3MzRWQjlY?=
 =?utf-8?B?SDl5dDJVMVgrdXdzdktxdGt5bFg3c0Z6UGdFT2h5L1dLMVhBOGVkUVUxRGYx?=
 =?utf-8?B?TytTcFlna0w0SHFTN050bHFqNzZGWHU5azlVWit2ajUyRlB3aUc1eVJVTFpa?=
 =?utf-8?B?VHNVTmorLzRCd2NRWk5rR3U5d2ZkdXR5N2FTTzRPYjI3SWU1Mk5PYUt2YmlH?=
 =?utf-8?B?N0ppcG84ZkdNYlJMY0JOV0VGMERkYlVpQ1lpSnRDd3hybmQzNzlFWTNHbFI0?=
 =?utf-8?B?MlpheU1uMG52TkFUbVJhRTVvTm9SWEt4Zmd3emsxUmN0TGdsZDFYWjRzSWEr?=
 =?utf-8?B?WmoybzZxM0hwT0dydk0vYUkvQXFzOG9yQWJsdGZubkJGcDBUSUQ1UVllbXYv?=
 =?utf-8?B?OFNnbGVxMytGZVVxem43dW9hbkMrYlc4S2pRcjlCQlJGQXZDSGZiVTlraFdm?=
 =?utf-8?B?QVJnU1JGT3h2Z3dzVkY3NHlGMmwzaWhhVTVuZGdleklVUkZzbzFnUTJpaDJz?=
 =?utf-8?B?aXl1V0Vzc0xENXFRNWY5Qjl0OTY3U3NTY1RkVXc5Q2g2d2lKZ0czZzZDWVhW?=
 =?utf-8?B?ZzlQZ1M2NFpKN0I0T0VHMnVXVUtqSlZJUDJRTnljZnZUK0h5VElON1FKejd5?=
 =?utf-8?B?b1pOcVd3dXM2ajZ4a0kvN0RhQ3JRd2VaVmYxczI1SXhjKzR2QUg1R0NRUGdl?=
 =?utf-8?B?MlZDMW1oLzNPelBkK05qcThkMXFNZXBDYjM0L1NtZy9BME5mZ0FqWHRaekR2?=
 =?utf-8?B?T3YwYkd1cFYyZk5kQmp1SUVMRlhiZkdTY1RoZ1pseGpqUlMrc2cra1cxakh0?=
 =?utf-8?B?aXRIblZZTlRkdjZBS3M2bHp1bndjZVFPakx6eVZ0N2g0RFlRaEtabUVvMnVy?=
 =?utf-8?B?RkF0ci9zaE4xalpYYTU5VFhDbDVGWmdrSk9vSm4xQlNrK2MwUDM5M1M3dVV5?=
 =?utf-8?B?Sml5cUdEaFh1cXptWXVSMVdWZHgxa2ZVWTVTUWxURFZoMmtta0M3UkNidjdw?=
 =?utf-8?B?L0Zualp0THNiVm1PWjI5UjhBZ2I1Z1ZrbVRDUVZhRDkvM3NPS0hxQXNXZGNP?=
 =?utf-8?B?cW41TlQ2Vkp3aXhXWE5IQ2orODM4R1JwQ3pobW9pcG1oR251RHBGT3NPanI5?=
 =?utf-8?B?VitlMUVHMlNVekJtbUdFd1VieGJMVXNXRW9VcFgwNHJvYm5sQ1I5UVZldDJU?=
 =?utf-8?B?czhXNVBUQnZ5TG5WTmMrWE9qNTNCQTNSNHBNOXFVQ3NBR1dBcmFiOEVLRDdU?=
 =?utf-8?B?SldmbnoxeUorWlV4N3pnVlpSc3c5QXBrdVROTjdTSHlPOWQvaUhGcTBGTDlE?=
 =?utf-8?B?YmhYYlpQRzFDZlhoRStFVjNQaVNweS9nOFRyalhueUVDY254K1Y1VGFWNnY4?=
 =?utf-8?B?Mm9FQkZnZmVOSjZnNjZjTkFYanFYU0JsUGE5T1ovSkVPSTFBZ05iQ2FKTndK?=
 =?utf-8?B?MDNWa1I4VEtVWmpIalRYVlM4bGhLQjU3cTBDcjV2VmkyekxHeXN0YTlKTnJ3?=
 =?utf-8?B?NE4yM3YyK1E2aktSOGJobFNYREhMYVB3eUFUaTlPZk9JZ1dBYWlPRVFDV2xV?=
 =?utf-8?Q?Z7TI/6qHseljYEgKCDNXQ+4m7buQHMoGRU6S0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f29351-e6c1-49f5-9081-08d989e55665
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4494.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 22:53:54.1191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zn4eaPrJ4E9O/X9ni71zayETrHY+xrmX1IMQTLzCa7JiGZFhtVZ7Ql1DxSezEyubZLh4Luw95L1ntbXojC+7nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4209
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10130 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110070143
X-Proofpoint-GUID: IGG1--UxkixvrERypiIF42njKDtTL0e_
X-Proofpoint-ORIG-GUID: IGG1--UxkixvrERypiIF42njKDtTL0e_
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 10/7/21 3:00 PM, Bob Pearson wrote:
> On 10/7/21 3:40 PM, Shoaib Rao wrote:
>> On 10/7/21 12:57 PM, Jason Gunthorpe wrote:
>>> On Thu, Oct 07, 2021 at 02:51:11PM -0500, Bob Pearson wrote:
>>>> On 10/7/21 2:05 PM, Jason Gunthorpe wrote:
>>>>> On Thu, Oct 07, 2021 at 01:53:27PM -0500, Bob Pearson wrote:
>>>>>
>>>>>> On looking, Rao's patch is not in for-next. Last one was
>>>>>> January. Which branch are you looking at?
>>>>> Oh, it is still in the wip branch, try now
>>>>>
>>>>> Jason
>>>>>
>>>> I see the issue. Rao is asking for 2^20 objects max by default which will
>>>> require 128KiB of memory in the index reservation bit mask for each of them.
>>>> There are 4 indexed objects QP by qpn, SRQ by srqn, MR by rkey and MW by rkey.
>>>> That's 512KiB of memory which seems excessive to me for many use cases where the
>>>> number of objects is fairly small.
>>>>
>>>> The bit mask is used to allocate and free the indices and there is also a red black
>>>> tree that is used to look up objects by their index (or key if they use keys instead.)
>>>>
>>>> If there is a usual way to address these kinds of issues in Linux maybe we should
>>>> consider that.
>>> Use an allocating xarray
>>>
>>> But for these AV patches just fix the merge conflict to something sane
>>> and go ahead
>>>
>>> Jason
>> I did not want to increase the values too high but we discussed it so I did. Let me know if I need to modify the patch and reduce the values.
>>
>> Shoaib
>>
> If we convert the rxe_pools to use xarrays as Jason suggests it looks like this issue
> goes away. I'm looking at that.
>
> Bob

Thanks Bob. Let me know if there is anything that I can help out with.

Shoaib

