Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A1C3CA2A1
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jul 2021 18:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbhGOQqy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Jul 2021 12:46:54 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:29294 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232171AbhGOQqy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 15 Jul 2021 12:46:54 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16FGecgD007791;
        Thu, 15 Jul 2021 16:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=K1fWsubcpNqSfWwdOMHrGLMT8VkMI1iopxABZqXPIfA=;
 b=IuhGPUVZ4eKCjL+JuPbUgrqWWlNVtHZi6sHAM3ES75Yd6xGDqz3bmiEeAIhZ+WOTjAfx
 H++4nhzr6M617gSgFPHC6ZakSvfFd0uDVGDe1iNgIvpzb1BXtC2QWN2H8YHN1YVPXdes
 rygbRL+eUFW9tFOL4NFXKynm9RDo/qvIO2aWedljoZA9LOHzE+ZApW9KbhjPJ1Joc/+l
 Wdzhx7RDjZ+pEWG0Ja9DQh4i+idy738w70JDtFKJeu4YkY/XPUMyEWkmACvXSdNNKIvJ
 IZRqXfFDYKIjELs/ftR8Y7iCTGKjzmKSoyjZOp5GyFKfXEKicft4XfS7ZfIEMVsmMoo2 RA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=K1fWsubcpNqSfWwdOMHrGLMT8VkMI1iopxABZqXPIfA=;
 b=gIIr1UP5c5/dzQ6rae6isQ/gknglLHe714yNchIK2DxzJZ0w8owffIpZFmNk8X+um4QX
 ssZpwCilvpioanaojHQWVqrKoSZjnrmEPB8xlAb9JVliHMKVZVU29y6FFCRjhtwRtTPG
 mEOw/1xkzPuG6/wvoXa9cqVbEKaKvK3XJZ752L6BiY+A1hnPf9JGjkequY8cXdvLObCj
 GglnQYDgvrJSeqxW3PQBWJ+LL7COqL3xwH/0nDAHHC/bH8IcDhXPPRnEiDbsV98JQiZj
 /LIaQXPeSz5v0CfWw9e3L+8rU7QRc9GqoDMkBQzEraDnhRoKBpNy4E+5CCwUAU8bo29x lA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39t2tj2j8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jul 2021 16:43:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16FGeoZ1119144;
        Thu, 15 Jul 2021 16:43:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by aserp3020.oracle.com with ESMTP id 39q3cj367y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jul 2021 16:43:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nV4SjJVbwioKKSN/dRJSoA0vCybLJlPwv59mG2dtu4wUJFDlP6ulxkcuv4R2WPfCukA0gXtHlMjY/1pxpJBmtB623sIhostczgFjsZUIjbPVLCQC2jpONQP1y9sOcEn7dPYTLcIlwQsZkd6w2UEnj/KXWZNybwCGA7HPOHy2PHtY96qd4Go8GdnYrBm2dQXlyshwTpeCqbPGlGCH2cDt8cyMBx/OFMvuERstw/0IPEsXERPbAYjXBbmFTBInvfwLanJR1ph2J383K05IZdRsSmQxayozu3QNG4qaw3ptrnShMn52zQ+wytHQ5efpZdaveO4Wag1FvpcdQXkXuodp/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1fWsubcpNqSfWwdOMHrGLMT8VkMI1iopxABZqXPIfA=;
 b=gFYkaYXU4A7Cs9h0R5t1kZPcgI2OX5V5Dz454YZn0ExsuzkqOdWlhcqI+VMSjHBDtfdLhZKUOfcNK+X1l2QC3qzPjJjd2gLQHOFUpXOpY+4yUrEFuHnS7OHPBP+4AeWV2kczl9evJ8YR8oUOa51RO4H2qVwwoN+nWNqLTZbtZqgYFmLSwJl/xePMeh/6wvoPS7aX1zMnUla5DYlcSqUD5rgb9HgUWQr3IE0bsm35AxwIdJhXK8KGLzq4sMhfTr5dofqd9qDkp33zvxYlgDsWkDk0VKkcFViZKj1MB8czkEY2VjimVd+1NZvWj44vUtfK84qxkHv9LDrsDP1rRb///g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1fWsubcpNqSfWwdOMHrGLMT8VkMI1iopxABZqXPIfA=;
 b=UjmPTVow8TcbuTnsnKQfuRs8/AZaFxP5PFAufTIzoluFesEnkYdS8uqFOpL3BtkKlOyTnWEWPDf30IPWqQsY2tcDsghSU0J+YzmRl843MDXXV8edFNBt/f+IDwvNG6ET1y6hY+yH608JkcFaCKr5Bs43k8xnJRUoLIW0aayOwik=
Authentication-Results: ziepe.ca; dkim=none (message not signed)
 header.d=none;ziepe.ca; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 by SJ0PR10MB5408.namprd10.prod.outlook.com (2603:10b6:a03:3ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Thu, 15 Jul
 2021 16:43:54 +0000
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::5de5:d174:9459:6d21]) by SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::5de5:d174:9459:6d21%6]) with mapi id 15.20.4331.021; Thu, 15 Jul 2021
 16:43:54 +0000
Subject: Re: [PATCH v2 1/1] RDMA/rxe: Bump up default maximum values used via
 uverbs
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20210714083516.456736-1-Rao.Shoaib@oracle.com>
 <20210714083516.456736-2-Rao.Shoaib@oracle.com>
 <CAD=hENdhJJghv2GNh3V7ndyoJ8eRej8g2TeoDFn6F4T+n2cTHA@mail.gmail.com>
From:   Shoaib Rao <rao.shoaib@oracle.com>
Message-ID: <1f764b55-77d4-8332-858e-fb9e8bd9abcd@oracle.com>
Date:   Thu, 15 Jul 2021 09:43:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CAD=hENdhJJghv2GNh3V7ndyoJ8eRej8g2TeoDFn6F4T+n2cTHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SN4PR0401CA0034.namprd04.prod.outlook.com
 (2603:10b6:803:2a::20) To SJ0PR10MB4494.namprd10.prod.outlook.com
 (2603:10b6:a03:2d4::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2606:b400:400:7444:8000::10] (2606:b400:8301:1010::16aa) by SN4PR0401CA0034.namprd04.prod.outlook.com (2603:10b6:803:2a::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Thu, 15 Jul 2021 16:43:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5bf7c2b-0eb6-4213-b097-08d947afbb91
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5408:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB54087052127CD05E5BC811D0EF129@SJ0PR10MB5408.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lb5qT92UzPWlPHHs5byJZbzGqeslXStME95SzPrX40F6vF1aXIEy+oHXMC6v0ttMMVq37GHWIbLcR4UCzmnHMCSAVqbKNgGSwPjWOVQ534wMJbQvCw2S2MdDQ6EXsTcF+um2ClhzMPUS6MYmDuvcIIhTx9XX+Vv/HAMMT5AWEvv0GiezN5h5RbqGPwh+k6R3Bkwy6BZs3Un3md4ETyuAg7ffkSf4EqyaiJByVPASZn8wVE2AU2klMA6p4Q8mTbMM+PGsXqUbk+iNP6vHIg4LDhb/PNdk6bhDN6iGNqLwpp/SV8TyXPG+cLqPaMgNA9OTY/6iTwsyvYbTVCI3ewwyygKk3mKVs7oB5aqwv7psTFTj5JrCJ/G1jqRNs+GoIE9hMKpPUeEZS+TOQlAQMBOVqgdOZt01BcM2o4sUYJEtccvpfg2SGS83GbHNNQD5kcw5DLPxXLm4P8ZAsh+ze/WqUzpbfYjIN7IiygVQkxj94g5chXYhDQl2giPUz7IDv8Xi9sNxKjXoeOv8+yGu3apxWJ0Su3TXlFjOU24kG+QL87bKrB7f2UaZKTLBajpgrdoDtJSLm35BcS+60mQifFqr+KnjqRYj9SPPq5PmPlHyAbwupJBWd7uPpnU/qWBDD4PXP1kp4uQKAeaX3emLY63bbB8Wmbc4lOzSThm0exbB95S//tMxBE1N9fwkZyBgNpcsB2+c2r6n3Z4RLNhIgB1y/amaYNCnHXVR0FGqSXGNIUNzieddijss+dLFBtel8aCg53bOO0mYH1Oy/Vwqo0HzInUMhnbZkapXdrvh9JZxfcozjxTp8O/yKtmSGL+/EM42
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4494.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(366004)(396003)(39860400002)(4326008)(2616005)(86362001)(53546011)(83380400001)(2906002)(31686004)(36756003)(31696002)(316002)(186003)(6916009)(38100700002)(66946007)(966005)(5660300002)(8676002)(66556008)(8936002)(66476007)(6486002)(54906003)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDB6emsySTNYalV1WEVXVEFGNUxrMmp0RmdOR0hSNUJNU3I5Q3VlWW5ycytt?=
 =?utf-8?B?MHhNb2pGM1ZkUFdBWDA5QzE1WWNmNU9UWkxLMVhjYlE2aUpVdG5FeEJYRTh4?=
 =?utf-8?B?RTRiYjJPZGJna1BKWXhGQlRveU1sUlYvTzQ1ditPQjZYKzNyZHFxR2loZ2lK?=
 =?utf-8?B?akxwN3Y1Nm01WDhXTm1Fd3BjWWU0UnIvTEVGekpZYXdhQ0V2UHJMOVRiNERy?=
 =?utf-8?B?Tk4remNzV1BQaVljaGl3cW1CNWJocWV6MDRuNHk3NUFJTTROU1BNOEswVmF6?=
 =?utf-8?B?VmRZQzZJQmwxaUMrbm9jOXhjdGhmSy9KZ1dMSmlnZlovK1FKYnlpbFBPdjVQ?=
 =?utf-8?B?SFJJU3JHbnVFM2haYnJRR1dOK0hRNm5XY245TUxPcndGQ1VjODZqbFptMGxO?=
 =?utf-8?B?OGNLUWlpSnlKZzBpaUdTL2pFZ3FSV1RPdkFYbWs1SHZkbUp0SFVZZjZoY21i?=
 =?utf-8?B?bUFqNm9IR3VRakNwaXZJaExGWHJWRXNnYklMUnJFemNkTnZCMGFyUUtqc3FX?=
 =?utf-8?B?cUVFR1h4eW5oaGs1TWdEK01rQ3VlQkJjQTYrc2JFanB5Nk9FeHlGZXZrUVJX?=
 =?utf-8?B?UG1FeG16c0lLMGdyZGZLRUd1VTRtOGtlMFk4TDZNODZXTlNrT2diRmhPYUcz?=
 =?utf-8?B?RXN0N2RUcTVHWlB6bVk5NmpMYm5GN3hHUDZJSUhyWU56UFd2bnFvNjdqUWFR?=
 =?utf-8?B?RURSWXQ3dTMwWENaeDlkWWRTVmpZN0pYTE9BT3RwVzhtSTNLY0ZLTXQrWkpR?=
 =?utf-8?B?K0lJUzBlMEtpOE83V3Ira2dTWGVjUFluZy9xMHhjcnVFaitxSjQyUGx3TjF5?=
 =?utf-8?B?dzdLL3B5K3dxNHZ0MlVJTUxqMC9DU2xZZkhXSkhWNzBMRzBOYXppN0Voamkx?=
 =?utf-8?B?N0xrcXpLb0tGMTkxN0dybFEyS2VDR1VGQ3NKaFhsMlFOTU0zSmhnb29CWkp4?=
 =?utf-8?B?Sy9uYW56eGpRVGEyMGRhVk8rQkNxMnRQM2VYMWN0ZHBpVVVLSUpwVWg4UnNB?=
 =?utf-8?B?OSttL2lBWGRNdVc4RlV5WC9MOXdOQXR1NXdwNVlJMGVFa2pOVjB0ZE1mMWFp?=
 =?utf-8?B?U1AwaDNKUVk3MFBJaFZyZHUzckFaTWtGWmNSUXViRlM5cDR4MU9IZnJqTWY4?=
 =?utf-8?B?bWJoTWh5ZVVDOXh2cTREQTBTNVA0bFl1c2lVWHhyMk95aUppU2NrdXB2TjhL?=
 =?utf-8?B?TitidUxOZkY4YUJGanB0OVlDa2VsaHBPZFFHcHRUWkFYVlpMRU4yYzBnR29F?=
 =?utf-8?B?OHpjTHJVVFZnSzM1Kyt2L2U0Y2ZtTU1OaGE2eEV0ODFNWUhrVEJxWnNLZmo2?=
 =?utf-8?B?UVh5SnE1TVAvSE5iZTdDci9mRXVXYm5uMU9wOHNKb3BBR0tKY2t6V3AvdXhj?=
 =?utf-8?B?eVBhTE5sOUJ1bHFScyt3M0pXZXdVb3lvSGsycU8rczdobHhRMTYzNE9rY0ZE?=
 =?utf-8?B?QTB4eUdrd2hGdzJmMVcwTy8vWTU3WXltYjZzcmJuZ1R2TEdMV3dyL1hJTU5m?=
 =?utf-8?B?SXZLenhIRzFDWDBxeEh5akpqV29OaXVsYXRpNDMyOWR4bnk0dmNsZXhqeTY3?=
 =?utf-8?B?WENBSS9ueElTL1ozaU1sUUxCdVFBZW9JRUlwajdYaW5KSkwzZ3g2UkJZZTFn?=
 =?utf-8?B?UlVHZGpnUWN0YUV5aHBYaExBUGhYRTF5MHZuRkNCTlZxMkN4MUJXU3diZHRD?=
 =?utf-8?B?eVhkZ0ZQdXp4QlJsNjByRkNlWGZpdHdIZm5uV3E0QmFCaGEwTDcwWmd0enR1?=
 =?utf-8?B?MEJRYmhJTU0ybUkxY0VOR01JZ1JnOXRVUm1iWUcxMkIrYnN0eXV3TFVsK0xQ?=
 =?utf-8?Q?+GKdgsvbKGC6nCuubcHbyNPpxLSrKFyUUkb58=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5bf7c2b-0eb6-4213-b097-08d947afbb91
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4494.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 16:43:54.3064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dseo/NzsjgLNqJlK5tLAQGKnLxjWCDiMHaInlybR5MRxTdrFu9I1zrF2cu9sIg0le4+1Lz0aMsv9GfJQaort2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5408
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10046 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107150114
X-Proofpoint-GUID: LErbk6myfGwkOwIMW8rcwWxiQsmHwVKj
X-Proofpoint-ORIG-GUID: LErbk6myfGwkOwIMW8rcwWxiQsmHwVKj
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Following is a link

https://marc.info/?l=linux-rdma&m=162395437604846&w=2

Or just search for my name in the archive.

Do you see any issues with this value?

Shoaib

On 7/14/21 10:02 PM, Zhu Yanjun wrote:
> On Wed, Jul 14, 2021 at 4:36 PM Rao Shoaib <Rao.Shoaib@oracle.com> wrote:
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
>>   drivers/infiniband/sw/rxe/rxe_param.h | 26 ++++++++++++++------------
>>   1 file changed, 14 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
>> index 742e6ec93686..092dbff890f2 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_param.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_param.h
>> @@ -9,6 +9,8 @@
>>
>>   #include <uapi/rdma/rdma_user_rxe.h>
>>
>> +#define DEFAULT_MAX_VALUE (1 << 20)
> Can you let me know the link in which the above value is discussed?
>
> Thanks,
> Zhu Yanjun
>
>> +
>>   static inline enum ib_mtu rxe_mtu_int_to_enum(int mtu)
>>   {
>>          if (mtu < 256)
>> @@ -37,7 +39,7 @@ static inline enum ib_mtu eth_mtu_int_to_enum(int mtu)
>>   enum rxe_device_param {
>>          RXE_MAX_MR_SIZE                 = -1ull,
>>          RXE_PAGE_SIZE_CAP               = 0xfffff000,
>> -       RXE_MAX_QP_WR                   = 0x4000,
>> +       RXE_MAX_QP_WR                   = DEFAULT_MAX_VALUE,
>>          RXE_DEVICE_CAP_FLAGS            = IB_DEVICE_BAD_PKEY_CNTR
>>                                          | IB_DEVICE_BAD_QKEY_CNTR
>>                                          | IB_DEVICE_AUTO_PATH_MIG
>> @@ -58,40 +60,40 @@ enum rxe_device_param {
>>          RXE_MAX_INLINE_DATA             = RXE_MAX_WQE_SIZE -
>>                                            sizeof(struct rxe_send_wqe),
>>          RXE_MAX_SGE_RD                  = 32,
>> -       RXE_MAX_CQ                      = 16384,
>> +       RXE_MAX_CQ                      = DEFAULT_MAX_VALUE,
>>          RXE_MAX_LOG_CQE                 = 15,
>> -       RXE_MAX_PD                      = 0x7ffc,
>> +       RXE_MAX_PD                      = DEFAULT_MAX_VALUE,
>>          RXE_MAX_QP_RD_ATOM              = 128,
>>          RXE_MAX_RES_RD_ATOM             = 0x3f000,
>>          RXE_MAX_QP_INIT_RD_ATOM         = 128,
>>          RXE_MAX_MCAST_GRP               = 8192,
>>          RXE_MAX_MCAST_QP_ATTACH         = 56,
>>          RXE_MAX_TOT_MCAST_QP_ATTACH     = 0x70000,
>> -       RXE_MAX_AH                      = 100,
>> -       RXE_MAX_SRQ_WR                  = 0x4000,
>> +       RXE_MAX_AH                      = DEFAULT_MAX_VALUE,
>> +       RXE_MAX_SRQ_WR                  = DEFAULT_MAX_VALUE,
>>          RXE_MIN_SRQ_WR                  = 1,
>>          RXE_MAX_SRQ_SGE                 = 27,
>>          RXE_MIN_SRQ_SGE                 = 1,
>>          RXE_MAX_FMR_PAGE_LIST_LEN       = 512,
>> -       RXE_MAX_PKEYS                   = 1,
>> +       RXE_MAX_PKEYS                   = 64,
>>          RXE_LOCAL_CA_ACK_DELAY          = 15,
>>
>> -       RXE_MAX_UCONTEXT                = 512,
>> +       RXE_MAX_UCONTEXT                = DEFAULT_MAX_VALUE,
>>
>>          RXE_NUM_PORT                    = 1,
>>
>> -       RXE_MAX_QP                      = 0x10000,
>> +       RXE_MAX_QP                      = DEFAULT_MAX_VALUE,
>>          RXE_MIN_QP_INDEX                = 16,
>> -       RXE_MAX_QP_INDEX                = 0x00020000,
>> +       RXE_MAX_QP_INDEX                = 0x00040000,
>>
>> -       RXE_MAX_SRQ                     = 0x00001000,
>> +       RXE_MAX_SRQ                     = DEFAULT_MAX_VALUE,
>>          RXE_MIN_SRQ_INDEX               = 0x00020001,
>>          RXE_MAX_SRQ_INDEX               = 0x00040000,
>>
>> -       RXE_MAX_MR                      = 0x00001000,
>> +       RXE_MAX_MR                      = DEFAULT_MAX_VALUE,
>>          RXE_MAX_MW                      = 0x00001000,
>>          RXE_MIN_MR_INDEX                = 0x00000001,
>> -       RXE_MAX_MR_INDEX                = 0x00010000,
>> +       RXE_MAX_MR_INDEX                = 0x00040000,
>>          RXE_MIN_MW_INDEX                = 0x00010001,
>>          RXE_MAX_MW_INDEX                = 0x00020000,
>>
>> --
>> 2.27.0
>>
