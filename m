Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50FE941BEE1
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Sep 2021 07:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244301AbhI2Fzd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Sep 2021 01:55:33 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:9616 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243585AbhI2Fzc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 29 Sep 2021 01:55:32 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18T5FtxB017406;
        Wed, 29 Sep 2021 05:53:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=4dPPPFL+KcnlOf+G93dTCZbrTxK60lx3TUiQ251f0wc=;
 b=nopJcjvmbirAkRZM76NuHYTpXRlkwStaNlOfEaCHctOEownA0BT3cn0tgqLsNH+tFm4A
 7+AEjRtvxAv8tY5OK8XN90i59einFi/lCqNAkBFn0CL8O+mpzpvEvjKiSjnHVmV7p9+e
 5jPx0LhfBuJlqUGjkCq2Ovqm3t8WNB48Ho+jaFPrDOTiNKjJ2ipAC75FlRqOA/d3ld6J
 QBrEfx8v6CE1ZciMsQjZuKam7ymP6gvM+Wm+neU3BiUPt6bl94DipAinFprmwRhVHm/t
 1jteSwIp5khCh9fxnVahrCr3nSMMbcQRhPxM6rsPVuW2f0y4WYMWqGVAjbTFxap9kkGR Xg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bcg3hgm8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Sep 2021 05:53:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18T5o71J018331;
        Wed, 29 Sep 2021 05:53:48 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by userp3020.oracle.com with ESMTP id 3bc3cdpbjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Sep 2021 05:53:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1zwVXq4+JFo5urbvFsVS4O3TckBcSAJc6goYAUiI/iehY5IY6Ab/9Y+MN+NqQOZQL4LuUqEQBiGTv5+xWU1tzPR88CxSphUSrd0DkHGYg9TTUEv6d6hLmuOCJETSggtRZNMdyAiDyObIxYF+E0Mhxe2CQpI2qwBs3UJviiEIJlp7Tbw2o6M5B6IPAT/+PJAtIUg6EoN7PHj+9nQRfnSaIJBrFdUM8SreDawxTzq3pKhnRRnrJmZB9mpqLPLqO537VNjgOO+oVL46yT4Neecf+hKwZ8KqhM72bhZ6a3grO8fnSIy+00tJPnbZ2oNPhqzp1yhR+TSHBVhpSJc6Dkzgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=4dPPPFL+KcnlOf+G93dTCZbrTxK60lx3TUiQ251f0wc=;
 b=SzTO/NR7coKvkjj7zNHpkSEOB0HiBKoEAWxKB6rR+Visa65y4srPQpcOhZcgF3rRn+yE2WumbeimYZP7cPnY0bsViXPnP1X23aYAUnjbMFI7nEYAREsMqf0nJVpj0YrX7lm79+FIudYjVbOhOmhg3sG0KnvAnTx6rEMNwLFhwtWcbNlwaDnv1WXDXkCJah8w/KzkfY+T1MwGT5SW8pwviOMHRc2Anh+KSWaG4FsEKiMOoxLtG9qbq5ObNNMXRxabiwzcABsqzv9DNj8ok9Fe656WOiqzm5xUDmahWhPDVDCMspUYQ0WnptU4WrAB7OdmIYCBspwgE0UlXX3cMCA2jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dPPPFL+KcnlOf+G93dTCZbrTxK60lx3TUiQ251f0wc=;
 b=Gk1nciWXoSXUQrxADP+p1Jj47GnisYN0JP7OrmmGY9oC18MkRvbTqaPEePdMfSGD98yUJXFFfNwMsLOuJdmxPTG39XAwouR8r5yxI6bYpColLpBED/aytvGY8nc0B6xHssJnhkOJSvOGqakZtYX4lK9cMrSwFXIR7ntIzZdf+CU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 by BY5PR10MB4036.namprd10.prod.outlook.com (2603:10b6:a03:1b0::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Wed, 29 Sep
 2021 05:53:46 +0000
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::d41c:d8ff:89d6:8457]) by SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::d41c:d8ff:89d6:8457%9]) with mapi id 15.20.4544.021; Wed, 29 Sep 2021
 05:53:46 +0000
Subject: Re: [PATCH v1] RDMA/rxe: Bump up default maximum values used via
 uverbs
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20210915011220.307585-1-Rao.Shoaib@oracle.com>
 <20210927191907.GA1582097@nvidia.com>
 <CAD=hENd0BDMS6BL_M2rDT7N8sZySQHLbzDEfWZ0AvSd6nmFmoQ@mail.gmail.com>
 <6a6cede4-32c3-45aa-86f9-4cd35d90ab4f@oracle.com>
 <CAD=hENeQrNPxjgxbPN0KuKF1XHT+GbEADKX1D3pP0qv=gNXN2Q@mail.gmail.com>
 <24e4ea29-557d-b2f6-8bef-30af19613b16@oracle.com>
 <CAD=hENcn6vZMx4YM3n4Kdo_kBCM_aHK8NOa+QgaAPnNk9jK60w@mail.gmail.com>
 <cd243ca0-859f-42b5-6851-6b0be7385a7e@oracle.com>
 <CAD=hENdN=rzZ0D-9Kk+yjRY8aLbYUWpiz_SuiWSDd2j1YPFkAw@mail.gmail.com>
From:   Shoaib Rao <rao.shoaib@oracle.com>
Message-ID: <92e037ed-bbee-b38d-30ce-fadcf17ecfa2@oracle.com>
Date:   Tue, 28 Sep 2021 22:53:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <CAD=hENdN=rzZ0D-9Kk+yjRY8aLbYUWpiz_SuiWSDd2j1YPFkAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SA9P221CA0028.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::33) To SJ0PR10MB4494.namprd10.prod.outlook.com
 (2603:10b6:a03:2d4::12)
MIME-Version: 1.0
Received: from [IPv6:2606:b400:400:7444:8000::7e0] (2606:b400:8301:1010::16aa) by SA9P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Wed, 29 Sep 2021 05:53:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce5e3227-80ad-4404-de78-08d9830d8041
X-MS-TrafficTypeDiagnostic: BY5PR10MB4036:
X-Microsoft-Antispam-PRVS: <BY5PR10MB40362FA8ABB2CA9492B9FA2AEFA99@BY5PR10MB4036.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b4ECjb++RWFjwgXo049nlGgCHTtG1GKmjmA+YTd+zyxr8QO6NpzmHFyCbiLAMdG6K+6SosZhc+BsY4Wpa70ubbh3lPntff7zh4P2d24e9w1NLl/cE+K5LquY4aR+WbWJHao2sqxQv2p0oNdRWAToqHOLp/7A2DnVyLNKRDP8dODPyd3JFQ5hMvtNQNxwCdgiSAmQvbo5MUs5XRtIpR+z6jX+sSynckDquPEnaqx7HDaTeJRPYVwi3ePL1GdnYUv8e4MDnBCL/h9l8HkERlxGO36JJ6IQ8MYgl7BFieZVqJ1W0umRESzeXp5JU0pOAj8T4eYPj2UcGkeD0PZPB05oWAuKmIMV1lya3RieqwYRgQPNlhqQqv7lwmBTYK3R8202NLhp07hZeQAZD47zRjp9QDp1MoBAXK+DcidnfPNrFiDtxnvUljrYazHgyRhjgOgGh9w/U51ibrCsDhb6Jv6oUoHyVN9lgVqnlPYywD/WAHLtiJtvkZwZY7prlq72YS8mmg4GJHTocARRaDXXps4fw74oIJmNZfW49JLLpNXIH/3gHRA0pVkQ/cljbiwwn/m9PXsdkkm8T8aSnMgZIpoUF1Zv92cEm4oJFxtdBnAjqJ2f9iwBxHPdbNVMs0PEAmOKCTkU7/y1869CGS6kqTUk3u3OefIs80hjHCfCwDFOs1xQUwGwkpTNb6+KWxIhhCJyICsUEQnVioYV1qaTPS0CCXv4ch6ccsqRASqBfHvLZzlidqGD/K71YCR/GBiKD4DDTdLt+L/sYMmPmHX5g3EIOm02oXbWb8xTem6f80RfPWsTfmIRHgvBS79wDiDihLbc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4494.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(186003)(31696002)(6486002)(66476007)(66556008)(86362001)(54906003)(4326008)(2616005)(6916009)(31686004)(36756003)(2906002)(66946007)(5660300002)(38100700002)(8676002)(966005)(8936002)(83380400001)(53546011)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEllKzFjaGE3S09rUWxBc0Nrbk5nT0VibmNzaEpKMkVNSVFXVllPQ1dIcy9G?=
 =?utf-8?B?Yytjd1M5dzFDSVZjVklKSmZaZXpIWVpaOUVzQnYyeUtLOWZueFZDYmR0ZTFP?=
 =?utf-8?B?QXVNVzZIcWU5azNaOXJWbVVPSTZMWmNGb3FxK083b0JOeEFuYXE1UnBrVkV6?=
 =?utf-8?B?Mm9YQXFQblViR0NSU2JyMnRocy9WR1puL2dyTXpSaTdZRDhMbnRBdmVNMytz?=
 =?utf-8?B?Q3BtWk5kQi9sTThWN0QzK0V3M3lGQzNRdS9talJZMXNRV0RiT3RxNnk3bzBj?=
 =?utf-8?B?cDRseVJORE9DaUhkSmxLOUxweEhqWU5EU0pRenFMck5yMm1McHk3T1M0ZDZI?=
 =?utf-8?B?ZmViSS9uajBGTVBNTVhVdk05V2pnM21aYVhRTzdPd01JVVd4YnViMFk5S2tG?=
 =?utf-8?B?aC9sTDYrNHdJUzBOeUNtL2M3VzRNN2UzSjlpK2tkUTgyYTVCL1c5LzFmQm40?=
 =?utf-8?B?RkVOSHNoQThSQm5sb3R3Q1g1QWdFNjlLSTBGSTJVVXJoSlRETDVudlEyaVhX?=
 =?utf-8?B?bzFEVUJ3VGhSSlpjc0QwWGU4UGs0NnJRR3BJeWVnV2RVRWU2VWp5Ynl5RFI1?=
 =?utf-8?B?blpPaU9FWUVBcGdCTHB0dzlMUmlOQ2ZNUTkvSk1iZHJOMGJUWll1WWVaS1lL?=
 =?utf-8?B?ZjF0bWJ4NU4vcHdmb2paTzU5dUl1cm95cUFKRk1jdEp4dEpCM1ZpWis2eFcz?=
 =?utf-8?B?dnhvSDA1SVdPaXVCSVB0ZW5qcmc2Y05qaVVpK1RCOFFJbVdxOXFDR2ZSamJG?=
 =?utf-8?B?OFYwYWo2UEcxS015SmZZWm5BQ2FkNGE1STN2YWpEUkQyZWNDVnNUaFdLMEZP?=
 =?utf-8?B?a1U3UE1XRkdXVGlUOXprL2xuekdxTEdRSW1uWEpEbmQwL1BMU2VzdExGU01R?=
 =?utf-8?B?M2pUMXBxdk5qcXdZUkJabE5Fd0pIcU96Yng1UHlyVXdhMU9NWklFejhYUExK?=
 =?utf-8?B?MWQ3c2trV2txdUpFRXY1eTVIekFvaFBGUmxOZW9iVjdtT29hMkRKaXRzS0Fi?=
 =?utf-8?B?ZmlaNVpUcTFXd2VKTklBZC9NZVVaMUhMMC9HNEVMZXRiRXdrdGtZQjZaeTd1?=
 =?utf-8?B?cWFBUTNITmdZdEtwdFBRU2ZOajJYWlhSZ2I4QmhZZFp5TXgzWVVrMnNwaFNk?=
 =?utf-8?B?T3VVRzJZR2YyN1hpeVpPMDZJNkJxUE5UaG90VHBXZjg4ZzBSN3JZYXBsNm84?=
 =?utf-8?B?Sm84ZlVWS0piNG05Q25wV0EvUDNTeGtVYkNtS2V2QS9yUW5rVkNLRGxVSUcx?=
 =?utf-8?B?TmJya3RMUHBvWHVZUzF3aUpPaXdvQXJhWFJYcmRGR1RNeStrTGlaUHhESUFC?=
 =?utf-8?B?SVZ6bWNWWjBDSTgxVE1tdHhTV0d1R2svaDJDVk1vUFFRRU1SRnpjTnpCSVEr?=
 =?utf-8?B?VmJiOVhhbkRHL2cxV2JoVndYYUlTMFQxSXlzRmdObTRFR2tyV1FlQzRuVFdW?=
 =?utf-8?B?WWJmcVU3UnJET3RCVWxhODhrcUlJUTk5Q2lXU0RlMldRMk9wbFprd2hqWHhD?=
 =?utf-8?B?T2x4QURYNzJuTTdXMmNhbFdFZlZuQTF1MXRLWFRrS2xPTE5iVVNxQUgwVFdN?=
 =?utf-8?B?QWFIWEI1WE1WNFFqbVFpZGV5OXBJOVd2ckFhWTVuV2NaUjhRV3B5ZzN3NmtT?=
 =?utf-8?B?VkpuWnZiZ1I3VjB0ZVlwSXJndEs3c0ZnQVY5L1R5YUtjR0I1L0o4YmtPNG9S?=
 =?utf-8?B?R3EvR2FHQnFPZllnYlFJb2t1LzJkTTRzZTE1dzV2Zlo4U0xZU01YanExNS9x?=
 =?utf-8?B?KzZoaEUzb3ZZRmFxYlRpT2VJNDlQdzZpbzZrRndZVFZQc1EvZXlPOVRnQzlq?=
 =?utf-8?Q?mGKV1No++CwPSkRkZHtIEyXMYxWm+zdg9eXTI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5e3227-80ad-4404-de78-08d9830d8041
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4494.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 05:53:46.0106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z21XJWTuO9+SbEYXiX7Kgl02AI427jw2ADANqvjo2SY8tKzjKVcdy+qpVzvQu/eqNvHxBh/JdYOoUI56ViFd/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4036
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10121 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109290034
X-Proofpoint-GUID: 06k2sAngoRb_SucCBYJEqsAkK_tfgtvA
X-Proofpoint-ORIG-GUID: 06k2sAngoRb_SucCBYJEqsAkK_tfgtvA
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 9/28/21 10:23 PM, Zhu Yanjun wrote:
> On Wed, Sep 29, 2021 at 12:02 PM Shoaib Rao <rao.shoaib@oracle.com> wrote:
>>
>> On 9/28/21 2:58 AM, Zhu Yanjun wrote:
>>> On Tue, Sep 28, 2021 at 5:41 PM Shoaib Rao <rao.shoaib@oracle.com> wrote:
>>>> On 9/27/21 11:55 PM, Zhu Yanjun wrote:
>>>>> On Tue, Sep 28, 2021 at 12:38 PM Shoaib Rao <rao.shoaib@oracle.com> wrote:
>>>>>> On 9/27/21 6:46 PM, Zhu Yanjun wrote:
>>>>>>> On Tue, Sep 28, 2021 at 3:19 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>>>>>>>> On Tue, Sep 14, 2021 at 06:12:20PM -0700, Rao Shoaib wrote:
>>>>>>>>> In our internal testing we have found that
>>>>>>>>> default maximum values are too small.
>>>>>>>>> Ideally there should be no limits, but since
>>>>>>>>> maximum values are reported via ibv_query_device,
>>>>>>>>> we have to return some value. So, the default
>>>>>>>>> maximums have been changed to large values.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Rao Shoaib <Rao.Shoaib@oracle.com>
>>>>>>>>> ---
>>>>>>>>>
>>>>>>>>> Resubmitting the patch after applying Bob's latest patches and testing
>>>>>>>>> using via rping.
>>>>>>>>>
>>>>>>>>>      drivers/infiniband/sw/rxe/rxe_param.h | 30 ++++++++++++++-------------
>>>>>>>>>      1 file changed, 16 insertions(+), 14 deletions(-)
>>>>>>>> So are we good with this? Bob? Zhu?
>>>>>>> I have already checked this commit. And I have found 2 problems with
>>>>>>> this commit.
>>>>>>> This commit changes many MAXs.
>>>>>>> And now rxe is not stable enough. Not sure this commit will cause the
>>>>>>> new problems.
>>>>>>>
>>>>>>> Zhu Yanjun
>>>>>> Hi Zhu,
>>>>>>
>>>>>> A generic statement without any technical data does not help. As far as
>>>>>> I am aware, currently there are no outstanding issues. If there are,
>>>>>> please provide data that clearly shows that the issue is caused by this
>>>>>> patch.
>>>>> Hi, Shoaib
>>>>>
>>>>> With this commit, I found 2 problems.
>>>>> This is why I suspect that this commit will introduce risks.
>>>> Hi Zhu,
>>>>
>>>> I did full testing before I sent the patch, that is how I found that
>>>> rping did not work. What are the issues that you found? How to I
>>>> reproduce those issues?
>>> Sorry. What tests do you make?
>>>
>>> Do you make tests with the followings:
>>>
>>> 1. your commit + latest kernel  <------rping------- > 5.10 stable kernel
>>> 2. your commit + latest kernel < ------rping------- > 5.11 stable kernel
>>> 3. your commit + latest kernel < ------rping------- > 5.12 stable kernel
>>> 4. your commit + latest kernel < ------rping------- > 5.13 stable kernel
>>> 5. your commit + latest kernel < ------rping------- > 5.14 stable kernel
>>> 6. rdma-core tests with your commit + latest kernel
>>>
>>> Zhu Yanjun
>> Hi Zhu,
>>
>> With all due respect, I am a little surprised by the special treatment
>> being given to this rather simple patch. Normally comments to a patch
>> are submitted with technical data to back them up. In this case none
>> have been provided. If we are going by gut feelings, then there are more
>> involved patches that are being accepted without any tests as listed above.
> All the commits that I reviewed will pass the mentioned tests. But your commit
> failed to pass the tests at least 2 times. So I suggest that you make the above
> tests in your local hosts. This will save us time.
> I do not treat your commit specially.
>
>> My initial patch increased the value of 3 variables but the community
>> suggested that values of other variables should be increased as well.
>> The discussion happened on this mailing list and no objections were raised.
>>
>> The two issues that you mention were mechanical issues, (one reported by
>> you and one by the kernel bot) that have been fixed. They had nothing to
>> do with the values being increased. As I have said I have tested the
>> patch several times, most recently about a week or so ago with Bob's
>> latest change.
> I do not know how you tested your patch in your host. If your tests include
> backward compatibility and rdma-core tests that I mentioned in the above mail,
> I am fine with this commit.
>
> Zhu Yanjun

Thanks. I did test backward compatibility. If any issues are found in 
the future I will fix them.

Regards,

Shoaib

>
>> I am not keen on changing the values of any other parameters, but the 3
>> that were contained in my original patch. The link to those patches is
>>
>> https://urldefense.com/v3/__https://www.spinics.net/lists/linux-rdma/msg103570.html__;!!ACWV5N9M2RV99hQ!c_05bC74v_nDObwKFnI2y3b5EuwvlSIq8hKf_4iXStmPVUk6qxw1_Jii_AC7oiui$
>>
>> Please let me know if those are acceptable. They have been tested
>> *extensively* running several different kinds of Oracle DB workloads.
>>
>> Regards,
>>
>> Shoaib
>>
>>>> Shoaib
>>>>
>>>>> Before a commit is sent to the upstream, please make full tests with it.
>>>>>
>>>>> Zhu Yanjun
>>>>>
>>>>>> Thanks you.
>>>>>>
>>>>>> Shoaib
>>>>>>
>>>>>>>>> -     RXE_MAX_MR_INDEX                = 0x00010000,
>>>>>>>>> +     RXE_MAX_MR_INDEX                = DEFAULT_MAX_VALUE,
>>>>>>>>> +     RXE_MAX_MR                      = DEFAULT_MAX_VALUE - RXE_MIN_MR_INDEX,
>>>>>>>> Bob, were you saying this was what needed to be bigger to pass
>>>>>>>> blktests??
>>>>>>>>
>>>>>>>> Jason
