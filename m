Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25FAA3D7AC1
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 18:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhG0QPv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Jul 2021 12:15:51 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:28306 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229506AbhG0QPv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Jul 2021 12:15:51 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16RGBM7s001378;
        Tue, 27 Jul 2021 16:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=/DNgwnDCnPY95FMd7fOM5hPVUlRIyhp6sb/CybynVaQ=;
 b=JlIRg/5DDfKZzROzWLEEAHwYwhB7sWiTpT4H5lCppK9m5iDvDr0hRXHJzfiScaljVViN
 87oak84nQUIlxEkXd2F0T+D8bdYaSBaJy0bMWuqmAe6xc/B7ikBK1UfIsiy3tltEXHrl
 tRL0AAOjnnzXruc1BUnVJ2mL+eRtpxkPgU0aVFgWAXDfDgctsMeAlJFgdi4EnuSXOleW
 22D59LG5LHXXzux6oViHt6svWvkn+q3HuX+BYMxUogLsseNdeCkk57vR8m/XgG10A3Ny
 RzPAtYNOv2Fc4iCzoDRMVAqqoSqhhnVjdlNyE0GpIERZI4yzylO2Op3yBu5JFvqOSJSp 1Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=/DNgwnDCnPY95FMd7fOM5hPVUlRIyhp6sb/CybynVaQ=;
 b=DcebSgYWxaieslnyhfW8B+fCdPkgznijSQoHnPDGiDa+6KytdGmpPrZQrXmTVNA015SV
 l0ltp7O/+uEDRg2mQkYIOQITlwAX/mGsTKrKN+Px/aaiTLBbcNmj1KcVo4hRmM7Wpel4
 FvgynrotMJ5FsY/4tx4S8Pk10q9biH3TQGkdlrZZlWDPtXVMbrZgz8rtz/NwQkToig7d
 +LHh1TmCJnrx+ZesnFGKF/yAE+Yf+p4HXfWZQGI4hj4AsZY79SaCRCtMXmE6McgcCrcV
 yLxuKuD6ntAccw27AUiTyNCN2dunkQWHsZ1mqQ/Hdfq8nWGnUUxas6cfbu7VQlaZOmub Xg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a234w2a9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jul 2021 16:15:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16RGAp42009820;
        Tue, 27 Jul 2021 16:15:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by userp3030.oracle.com with ESMTP id 3a235399d8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jul 2021 16:15:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVte+zAeFgX3tiz1d3fD97mS8PRJKuiNAoMnXKncp76A0+VRGn6+Vz5kEIFtdOnG5rDT9HhriXTeKy0eYhiBtrkOIZRsit49yixxI5k4SVqlcJZSsj+OA7neEmjGkB9QxLqL+ku8/cTSd2HhOO0BtaGWaTo3lDKB1ZpOn4D0Tdku6Od7MCn/lUoCKErZ4+2Mf1lk0bvL3rdvW5NQxc8ZyWoCdghQvGd5j3eHUdchNugrxmeZAq3X0H20GVjfLdOjg1vIzdrfzbE7kuF2dDVNDV6wgjLvZdhUY9Bs4eYLZ0IjW2oaFgey/0Jkci5Yl7BFTQrwQ0/F136PUzywyKFvDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DNgwnDCnPY95FMd7fOM5hPVUlRIyhp6sb/CybynVaQ=;
 b=GOSop9EjON832CsYGhLPBsPpt6ZnK03T841ej80rSpdrrREqP/LmNTnGgOFE8/RDclOiUg6wGWP0EhWLMnbxb4TnwDLOqQnBCC9qznmWcQZuZ90IJMsoWNSC5ng6APkWfDfql3r5yxmjrkkVhyTu2quhYEaEoA95p8XmtCTmgD15mrdRt0YEJgPHcqWDLpsVAOXfT8mDCFMfqsuh9a0r2Ro293lKPWpnkMHw2f/qpoT0FtXVs36y7w/EmZVwCQ2AzJnZgPrLH2Tcu6eDEvEs22NMLf2KhRJ2jv3OBjFEI908OwgFyWdoVkoRaSzTYla/mne+MYvvsIZlN829kqX/Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DNgwnDCnPY95FMd7fOM5hPVUlRIyhp6sb/CybynVaQ=;
 b=UDeYzaMWcxRqcPyPVfqyY7IaGGim532ENDO555hi+xyDW5X6eJWIo/GqzQ5TJAK+brJe9Nqbb1a218a908TFxY6hDoOSNp/mXCTH7xAGVkHM7rAFH/VmEvEHljx6V42q2KF0abYDnKEHcTC/Zuf3VNd2M921uTX3Qb5Nutxe5SE=
Authentication-Results: ziepe.ca; dkim=none (message not signed)
 header.d=none;ziepe.ca; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 by BYAPR10MB3717.namprd10.prod.outlook.com (2603:10b6:a03:11a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Tue, 27 Jul
 2021 16:15:47 +0000
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::5de5:d174:9459:6d21]) by SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::5de5:d174:9459:6d21%6]) with mapi id 15.20.4373.018; Tue, 27 Jul 2021
 16:15:47 +0000
Subject: Re: [PATCH v3 0/1] RDMA/rxe: Bump up default maximum values used via
 uverbs
To:     linux-rdma@vger.kernel.org, jgg@ziepe.ca
References: <20210718225905.58728-1-Rao.Shoaib@oracle.com>
From:   Shoaib Rao <rao.shoaib@oracle.com>
Message-ID: <54817f70-e7e5-d145-badf-268ba7533110@oracle.com>
Date:   Tue, 27 Jul 2021 09:15:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210718225905.58728-1-Rao.Shoaib@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SJ0PR03CA0328.namprd03.prod.outlook.com
 (2603:10b6:a03:39d::33) To SJ0PR10MB4494.namprd10.prod.outlook.com
 (2603:10b6:a03:2d4::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2606:b400:400:7446:8000::133] (2606:b400:8301:1010::16aa) by SJ0PR03CA0328.namprd03.prod.outlook.com (2603:10b6:a03:39d::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17 via Frontend Transport; Tue, 27 Jul 2021 16:15:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b62a80a-a624-40d9-b346-08d95119caf2
X-MS-TrafficTypeDiagnostic: BYAPR10MB3717:
X-Microsoft-Antispam-PRVS: <BYAPR10MB371703F85D51F3FB07C9707FEFE99@BYAPR10MB3717.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +0iCyfZyevNYtNAeod1q7qpy7bkmbBs5oksDWafef/yBd32VTXYJbN5g5cb7MxzbsQ/haKsqih3AxtnsZ5XZmsV8cPZyJC0+S1l13m7boQSxXs/B4BUSHPnZeGRJuNn9SSePMffRG0xIRTbfAD0LhT7VT1JpTLnm452c3nF3uJ4Am296ddA5E8yPm6+yUW2EPK/3QyMo8igpkaFXXw834tbiG/C6yZGUMK31SdBZ1J8sBk9V/HAVstvRpQsNWDc1kc4JrX2gg34jGLRTvcpFgLZFUJn5y1K9GXv9mWcga/g1yxcRdyyrhMpJ9D+NsrsT6o6uHcsUsInQ+42AwqaISKC+ZUCyeKhKj0MXVxgF710/Yucy5uBeIcRJSr6j6H+I1bAQ2wIxggRdwXfRA1e4+NfCC7/RkGBCNftPEuhc2Qn9NidCV9JPOLSMS66athQR49j9oSFiMAAjV8aQLo8G09yY1nqQ1OFzA3JUH7nEIOVCmJWFa6n+d1O/xLdh1h74GnuIQa/N7PrucsplMclwjbjytX4CNU74dnlCtW8wPoEZZjeB+EPpBwlbud3N3+oBlkrBwSvqYiSMUozeZm0FELg+Qe+wrQGd9T/PpKzPyEaAIiSY+o9zCJ1RItH0POvxG5GQCZqdcllQiRvIk+xDQIaAX92Xg1z7qfimHVw4UEdHzlhK99Xz9Ob4OWB5KEjasdBFO4Ij0YuFBmIfi8hKoUnpfELrEXacHHmg1DTq9rA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4494.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(39860400002)(376002)(136003)(8676002)(186003)(2906002)(86362001)(6486002)(83380400001)(4744005)(31696002)(8936002)(2616005)(478600001)(36756003)(31686004)(5660300002)(38100700002)(66476007)(53546011)(316002)(66946007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm01TFlKazVxSDFENHZ6TjNiNmFXZzkvZjZ0TGpCUjFCclVZcU94RmVNOUhC?=
 =?utf-8?B?U3ZSd3kwTjAxamYvZ29nNGI5c3V0Y0pZd0xrRjNkTnJxWnd5LzJ0NEloN20w?=
 =?utf-8?B?MEp1K01heTVYVE9hTDZXNlFuUHVib0hzUk4rWE5NUkdDZE8weEZOMGtZa2o4?=
 =?utf-8?B?UFl5Q284Sk1KeSsxTW9WYlF3dENsRTJOTldDbjNGSVUrMzM4OS9WcTY3L1RD?=
 =?utf-8?B?M1JXanJXYnF5UlQ5eldNdW9Qcyt1VFh0KzhPd1JlSXJuTzd0SW1BbTVNcWpw?=
 =?utf-8?B?SlJmR29NOEMwbWJlRWFsS1o0U1JMYTM1R0drVWVVd2tkM2NpTytTdnNNQllB?=
 =?utf-8?B?S3RORUIxY3hwWVUvSzI4eGswL3Z3T2hCellIdW5CazUyZzZ6ZVhHa0Z6QVlC?=
 =?utf-8?B?WkZFOUdVR3pkWm93bG9zL2tncVlTRUlZNitVdTdnTkdTTzRjNHd6VmQxK3FB?=
 =?utf-8?B?MVpTWEdFVHExQ2trS0x6eWhDRTRaby9UNVdpamFaRXR4c0ZvdkUwRnVTVFVw?=
 =?utf-8?B?QjJmWHdJdVk5dFY3VGVkVTNVMDRJaXVRRFp0Slg3b1A3L0doMUZxTDBvUkgx?=
 =?utf-8?B?SmtzdGE3YStialR0bUJINjExR2NnZG5kdEpzV0JKcHdhcWorU25maU1LdW4r?=
 =?utf-8?B?VTcxMUwwLyt3UitVbkt2ZjNVZVg1aDI3cERsQkZ5QXd6ank0Ym5NYlloL05o?=
 =?utf-8?B?TUxQd2Ezc3BhYzFkZUlleHMwSWNSeVMwQW9Vc0tuUWM4TlA3WWY3N3VIRkZY?=
 =?utf-8?B?U0lOdWVYZ3hPSlNOY3hrS3NIMll4dnUvOVhBU01kVWxCTE04MWlTNnFtY1pn?=
 =?utf-8?B?NU9ZUWcwOE9zVWM2azV0M3NNckRPWUNETHNiU0EvUjF5aFVZbVJVMlFvWUx6?=
 =?utf-8?B?VW9tdTVid0dWY2xuNGhla3NTMDJhYkdnSTlFbGxBa0UyZDNwRTBTUzVCc0Ft?=
 =?utf-8?B?SWJycFAySVdmYmxyNUh0NDZTREUvMG9WWGE0RHF2OS9rRktRL1IyR25VWkVT?=
 =?utf-8?B?OFViSUI4UVpBZ1NnTlhYYzdqRWFNME9lanBYOXU1UENKYVRCdjFjUFZla1FK?=
 =?utf-8?B?bGdUQkI0UWtkTDZFSVBneHdjcXpzSnoxZUZ2ZndKdlBWQzdjSCtpRGhHOTBQ?=
 =?utf-8?B?dTFmMjFwcFR4Vnk3NEZtcVE0bk0wQStPckFTYk1IaTgwTXlhWVh2UmhXYm93?=
 =?utf-8?B?OC9mSm44aGVGQ09nV2ZzMmo5MzJmVm1DNlBtMnJWelp0UEZ5MnFwYmhacUx1?=
 =?utf-8?B?cTRRTGVXNGt5K2VPamhPU0pwQ1Z6emZmOXBsTjdTK1B6VHM4KzBGaXE3QXQr?=
 =?utf-8?B?dkV1TTZSOTZ6YWQvVk1ObWZlNUQrY2tQdFlZd05JRVM4cEtFRzJLd0NtekN3?=
 =?utf-8?B?Q1Rxa3FrL1dkZ3ZNYm9qd3pQV1ZJTkdkNVZ1Nk5rRlEzMVFlL3lCbVJtQytp?=
 =?utf-8?B?bit6OVFkQ3FyUmN3MDA2ZFBvRjdoK2VDNUJlb2RzZ3ZSZFN2SGlCK0QyLy9V?=
 =?utf-8?B?NXcraThmZ0dDcGZFNXhJWnJya3Bkb1BXSXRrcnlScG00ZDhnYVp3dDRqZGFH?=
 =?utf-8?B?VEdyamVBRUlJa2pZeU5EV3A2Y2NaSm1pejY0RjQ2SFhaamtkelhlU2M3Z3N4?=
 =?utf-8?B?NnpsV1Y3OFZyTHB0WjFHM2NSaFRmR0hCK2FyS1p3MlpaUHRjZDZscmE1UzYx?=
 =?utf-8?B?WHBBd1dWL3p0Uy9WalJiN3Q2MmdCazFFdXpUSW1mNkZHR3FBK1ByYzNmR0Vs?=
 =?utf-8?B?U2F6TlhSUXFEbFJNeFd1YmpRRDhXeUZVQWhIMUYwQ2RRWkdqcFBacmZ6S2Uv?=
 =?utf-8?B?WDFEZXBXUGlEZHJOS2NWZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b62a80a-a624-40d9-b346-08d95119caf2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4494.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 16:15:47.1985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpoQJ8JJ5zLqJElmTEk/UyYR5F5yuWumv8XuE3tMW6fOn1UZ+gK24kYEu0ABEn8SXA7hNEoMF/UMShmF2tAxeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3717
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10057 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107270098
X-Proofpoint-ORIG-GUID: 2yhND725d_r0VkGP5wOTaY6bynitTyJK
X-Proofpoint-GUID: 2yhND725d_r0VkGP5wOTaY6bynitTyJK
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason et al,

Can I please get an up or down comment on my patch?

Shoaib

On 7/18/21 3:59 PM, Rao Shoaib wrote:
> Changes since 1st rev:
> 	Fixed an issue reported by kernel robot build
> 	Fixed index not being calculated properly by zyjzyj2000@gmail.com
>
> Rao Shoaib (1):
>    RDMA/rxe: Bump up default maximum values used via uverbs
>
>   drivers/infiniband/sw/rxe/rxe_param.h | 30 ++++++++++++++-------------
>   1 file changed, 16 insertions(+), 14 deletions(-)
>
