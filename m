Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0BB13C750F
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jul 2021 18:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbhGMQlx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Jul 2021 12:41:53 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:63970 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229445AbhGMQlw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Jul 2021 12:41:52 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16DGaeLi001976;
        Tue, 13 Jul 2021 16:39:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=nISnsYJ6C72uOP5u2xNFLyAKGOszvU/JddhnBXIvyE4=;
 b=J/i3mGrQrClJ778+r1LxP8zCj2GJvu9ilwKc26vvFl0KKgZQjGzGPEFWrxo0GUyin6bf
 dMYajyl57/TjFGFCrUbO3ewB9vfKlasWOLwAuCS0JKfkaCBI3DMsaab6cjcApIrlkanh
 ow3WA6Uwg9QEBG8DIvONCiJBbkURBp2QEPD4HkogXslfogAid2LuG+KIClA4a7/kd2M0
 5m6tSbkkkBMaSqWvakCf4W3J5t1vQQ9B8xej0AFMJv+skBSZDKczuvbFm7KcHMgtD4D3
 2oJLtc0tmsJlCA6+X5sQTGYgmhbgD47qwgOPYKlpLPyijUtsRtiPZ4kdkTbaDKJyRDgA Bw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39rpd8u1xt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jul 2021 16:39:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16DGYqP8045412;
        Tue, 13 Jul 2021 16:39:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by aserp3030.oracle.com with ESMTP id 39qycw9740-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jul 2021 16:39:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMLDpY/p9fTHu/Zec+18H5bkpgzAqOy+C52yDg6Cp4PHc6Gxd4h0Cut5sWSrWr3NmPK15Icd2qLNiLSrg5je7WGu4qdk/XZnpvL/JHS43KwpLQKIGKS/Qf5H9Waa0K1NTgJb7Q5x/ZnBYUp5AzhVROQ0FL5tuuszbzzRJkcNcV/lokdONnLfjRNtaTFQ0ZrIt6eSiLvFdhBhe8pVuFOvidC6pZ0xO2ec3cbTrvkiUND/Wzb/cyurdRGF8vlKLb9UvUVoQ1Bok8xlhgUfu3r3FNVWM948JiwVk07TqdqmyrD0pJHGbVSxD1ZPDZ052NGE5wvF4Xz89HZtsezO6OrPZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nISnsYJ6C72uOP5u2xNFLyAKGOszvU/JddhnBXIvyE4=;
 b=eMjRtIwyj2fBmwJ+syjC7SHyQR2NndAkMGbfHsGzKeS+3wnEWTX6SHEqMlwq3LdaqTKdnuCiILYvd1y9X2+KYeHYfBU3/pjB3hlFOFXbetkfcCTZY6rjAEdo7IkrEEogjBCDFhvJrvdF8l1O02GU8QnMjvtmAFQLgp74uJS9XW5vm795jjCwAZmfuyTkTM1Fs5rrZ/yCWfJJ6Tuzu5K/48AhIWSAG08SWynEthTl5bI2nPYWFQSH14XIQTtGw5w83hIu06gQTlWfBslKNm0F3eBJok+Huz4IQAChqxhhDJoVKdjc5RMPIjDRejx6SJUgy3LSAu/7LbSdefSab5Wchg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nISnsYJ6C72uOP5u2xNFLyAKGOszvU/JddhnBXIvyE4=;
 b=dk7TXZzV/9KrYoPuec6tiNZJJOSDnF//lWSUvCJtpMgdtpfx4Y0ts3J6o/aCHKO74C3yXKR4QaSPAzgeqGQq1TPsR57l6/JtODIoM4SYWacoaCqlpyHCSbO7+qzGMF642xwCcuJziuEG3JF9vKk/Kn0CLE0xdVxhMuBsmAjC4nY=
Authentication-Results: ziepe.ca; dkim=none (message not signed)
 header.d=none;ziepe.ca; dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
 by BYAPR10MB3032.namprd10.prod.outlook.com (2603:10b6:a03:82::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Tue, 13 Jul
 2021 16:38:58 +0000
Received: from SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::5de5:d174:9459:6d21]) by SJ0PR10MB4494.namprd10.prod.outlook.com
 ([fe80::5de5:d174:9459:6d21%7]) with mapi id 15.20.4308.020; Tue, 13 Jul 2021
 16:38:58 +0000
Subject: Re: [PATCH] RDMA/rxe: Bump up default maximum values used via uverbs
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20210713083647.393983-1-Rao.Shoaib@oracle.com>
 <CAD=hENeMRNFjJQa4TmRVsxNf4tuLCEDhYYUE7LZ2Pq1+vE=b6A@mail.gmail.com>
From:   Shoaib Rao <rao.shoaib@oracle.com>
Message-ID: <5ad1eb2a-5acf-6817-e420-2635544d64e8@oracle.com>
Date:   Tue, 13 Jul 2021 09:38:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CAD=hENeMRNFjJQa4TmRVsxNf4tuLCEDhYYUE7LZ2Pq1+vE=b6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SN2PR01CA0040.prod.exchangelabs.com (2603:10b6:804:2::50)
 To SJ0PR10MB4494.namprd10.prod.outlook.com (2603:10b6:a03:2d4::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2606:b400:400:7446:8000::30] (2606:b400:8301:1010::16aa) by SN2PR01CA0040.prod.exchangelabs.com (2603:10b6:804:2::50) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 16:38:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a67889ff-b829-4837-483d-08d9461cb699
X-MS-TrafficTypeDiagnostic: BYAPR10MB3032:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3032D35871704A58129EE6D3EF149@BYAPR10MB3032.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jo9zFBjVFSwp6rWCaLEN/7d4lB48Jz00m+cYRB1RQvJypqaSVxTnqXQzEIfsO6Pd9Kk7/wIqyp2HS6MNdlihD3a9dfofe50/cLojgnTg5hLyjt0di+uyJYwVIHSb5klCrUW6uYS5V8wy/KLtYzIwEi32CXhebRJ2EKpDG3dIkxXZvaIMGPRPM2u2pVXsQ8Jp6TtppTN643U+9rTwUHiqjWHy/xjuKtB6Va5tMqBPpbJbcXUXGdKIDhS5Xq+lMSIoTQLFA68MjiYkoHGVlzJ0QJmEcTmRIXgJFQ6crQ7vinY24Wsv4ERjIotvjlWrcFVlJ48vpPckE4v4QfA5o+h8z0P9FVJsyM8QSbpmBkJ/CkiUtAZe58339VfyXIGDK36Pw303f4iC9qOwaM/f7TZUtJ5amSyvN0zvRbYc+3qgGvM+m9+Xyj7A3GurQ8SBnoUvcoOjG9HVp3LUk540IvOyVKawH/NGA3DVn4dE6TUtQOajUI/4Ho1fQU30Wp0CEIPNyz+gVX+Ni0I5p2FSbvmBxMG+HwmLmqX5GTX7JD7x6Jz0MSylH3HgNi4aUUAzo1mQAyoqIc6z0hFCZAgB658IjEryiihsgXDu1LQmIORlMZsd0z0u+xnDOsk7pVCFSUBtNp9P/LR3GUpAeXHVzO6HypsDET/ZxcJwWHwmfMesu+PKwYmMZy5nF1Rzo7h5QqDqikOOjc1s7OWKeHDCsFgv+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4494.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39860400002)(396003)(376002)(136003)(36756003)(2616005)(31686004)(4326008)(38100700002)(2906002)(54906003)(316002)(186003)(53546011)(86362001)(66476007)(66946007)(66556008)(5660300002)(6916009)(8936002)(478600001)(83380400001)(31696002)(6486002)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1pkMndydXNpMndoMVN2R2Y3WjVoaTJGWXlqTnZtVGtWeE9vZ1dwL1BLQWFF?=
 =?utf-8?B?SkJUUGR5bkNLUXhZZUUyVnZnUktjT2Z6M1RRRFhMOG5PaTNRbERYQ3E3QUJY?=
 =?utf-8?B?YXR3T3RJZWw3NTB4bmRmQWs2Rmg1M25yNW1FYitOK3kxODlQVjZuK29mS0Ir?=
 =?utf-8?B?RGExemEvQzFtS0JFWUVpY0gySkRlcTdPcUpGcHF3WG5QUENkK0JCZUlNc3NI?=
 =?utf-8?B?S1BMZUxVcUVER0RXOFZmODBvNGxoVEt1UHdnbjZORjNyNnpIalNTWEl6RlJv?=
 =?utf-8?B?ZldRd0dqcktiNVdhQUxwTnA3RGhpNlk4N0Exbm1oOUxCdThwdzYvRzB6cGZq?=
 =?utf-8?B?b2dzdWhVeENlV3hNSjRYQ05pTkZaci9malRvekY2bnBRWElsQi9idVhuOWl0?=
 =?utf-8?B?TjNHMXdic1JkVVBDQTJvTjd0cGVaS0RtTTY0a2RwTGV2YjF0S25LSU9jMG4x?=
 =?utf-8?B?UlpaYitoU3UzWFpkVUY4ZU5GdUNUdUJtS1k2Tk1vdUczV1h3alcwRTZGajl1?=
 =?utf-8?B?RUdWL3Z2UllNVDFIYnZMTFJxeWlKWE9rVGJUQ0VUY3VMei9YcWVIT01TaC8z?=
 =?utf-8?B?ZUtwaVRPZnR0TU9MR1N2S2NJTG5kSzIzNi9mcDNRblpBdXZMREdDQ1YwQUZ0?=
 =?utf-8?B?S1RBM1hrTTBzVGJRYWdUdGZjZURGWE94VWNTY1BhNHlxQlovUHU3MzZwQ20w?=
 =?utf-8?B?ZGpvUzV4UjIxTEtxb2hvZjBYT2djYlZxdXczMTNlMFMxMkp3WG9yQlE2eUNM?=
 =?utf-8?B?NEc0OXJ6TzVhRmV6K05ZcmJYdkVLWndQdndzTVIrRTVjcVcvckkrVGpHdytk?=
 =?utf-8?B?V1VGeWIzcnJ4WUQxQVIrZEJyWjRsdm5OWk9vcll5OGtiR29rQjliSDQwS1px?=
 =?utf-8?B?VWIyVjdTOEl2dUJQNVpZNVJISXVra05KS0swd0VuSlpyMDdCcFRnY01uQ3Zh?=
 =?utf-8?B?TnNwNU04V1JMdGxtZWdGc0Jnd256K1JqWW1YRDd3aENEZjBiYmVlNm1OWFYr?=
 =?utf-8?B?U3pIMW1oY0Y3U0lOSHZRcmF0K3dXM1FmTlRrRjFacFcvd0gxTUJkK0FJck02?=
 =?utf-8?B?SlFRYXlkYVFJemlwR2tNb09WUXJwb2phSHJjd3I2cFVJVVN3eDhqNW5Bd0NL?=
 =?utf-8?B?eTBybjMwYjFHb0d0M0RzTTUwaGo5STdHV3NrNDlVYVFXQTE5Wk5LWnlhMC8r?=
 =?utf-8?B?aGZvK2tITW1HRkVpMWxqajhtMFBKL2VpTERmdXFPWlBIcGZBVEpQM0hSWnBa?=
 =?utf-8?B?dDJmSjh0dmt6RTZHeWwydEs3K1grYWVpRERsd2VUMmtjcnhFZFJyZFRWNnlR?=
 =?utf-8?B?bndTa2cxU1p5Rk5ZbG5WZ2RGWXV5blptSm1OWXVlWjlUM3B2UlQ5Z1Z0MjNR?=
 =?utf-8?B?eWlvbnp3SXV4WXdPTXI0TGVwQ0ZhSWdVbFpUeGtLcThTTFUyelVhQ0dRVHZn?=
 =?utf-8?B?UHhBVWNZMWgvRmk5ZVNUbkR2dERQd3dleTU3VVQyZndlclREdm9iWmR4cS90?=
 =?utf-8?B?ZlVjd3diSHp1dTNIQnRWd0IwQjQ1Ukcxd2FueGNaOVJDVjdJWVpCTnQ2U3pT?=
 =?utf-8?B?WWtDZ3I3T0tLbkYxMlI3L3Uwd0xSUUpFbERCRUJBdTVNMHdoaHhUSUIzQXhF?=
 =?utf-8?B?SUtSdGVob0ZDcUdyQXVRMFN5d0JjL0tHTjFGK1g5ZGZYcER0c3lORmZ5UmlP?=
 =?utf-8?B?VmpCbFNuOExoNEVNMVdoeDVmTzhLSXBSNC83QTlsdVltNGtYUHBjandrRm5j?=
 =?utf-8?B?d2R4TWN0aHRza0VZckt4TU1jV1UyMElLT1owYTVmZjBNWmVKNlBSRFY3R29m?=
 =?utf-8?B?UUR2RXdsRWJjTG95bldOdz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a67889ff-b829-4837-483d-08d9461cb699
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4494.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 16:38:58.7786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vuMFMIl1nrm+pMaRXzKuKJL8XHjXYg7fKxFoHkAINxAUzlP/u1pKYqQkV9cRLQr4rpyS8LbmACjLbPNyagUrIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3032
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10044 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107130106
X-Proofpoint-GUID: 05Dkl-2vRtSL9ydVFYH7XTC6smmb8c8i
X-Proofpoint-ORIG-GUID: 05Dkl-2vRtSL9ydVFYH7XTC6smmb8c8i
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 7/13/21 1:40 AM, Zhu Yanjun wrote:
> On Tue, Jul 13, 2021 at 4:37 PM Rao Shoaib <Rao.Shoaib@oracle.com> wrote:
>> From: Rao Shoaib <rao.shoaib@oracle.com>
>>
>> In our internal testing we have found that the
>> current maximum are too smalls. Ideally there should
>> be no limits but currently maximum values are reported
>> via ibv_query_device, so we have to keep maximum values
>> but they have been made suffiently large.
>>
>> Signed-off-by: Rao Shoaib <rao.shoaib@oracle.com>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_param.h | 26 ++++++++++++++------------
>>   1 file changed, 14 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
>> index 742e6ec93686..66a948adb1e1 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_param.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_param.h
>> @@ -9,6 +9,8 @@
>>
>>   #include <uapi/rdma/rdma_user_rxe.h>
>>
>> +#define DEFAULT_MAX_VALUE (1 << 20)
> How do you get this DEFAULT_MAX_VALUE? From spec? or others?
>
> Zhu Yanjun

The spec does not specify any limits. The value was proposed as part of 
discussion on my previous patch.

Shoaib


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
>> +       RXE_MAX_PKEYS                   = DEFAULT_MAX_VALUE,
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
