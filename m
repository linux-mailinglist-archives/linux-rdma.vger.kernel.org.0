Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00567B217A
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Sep 2023 17:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjI1PjQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Sep 2023 11:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjI1PjP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Sep 2023 11:39:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1B0B7
        for <linux-rdma@vger.kernel.org>; Thu, 28 Sep 2023 08:39:11 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SDgT9S016440;
        Thu, 28 Sep 2023 15:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=bwBJklaohhxWLK0mHikTuBRxOsGqlc2GTOaI5+BBTA8=;
 b=JV9MT4Pff3PN3GOjPoEzbO2g0LTuJZVOW5BO+ITaoG0rs0mzPBUMPd/SCjEtnjznp7Bh
 YwgOEQB7gJAsOyozLiP5CWwBd9P9R+CBmD7Ui3BFPaNWiTbGkUPMR/1tiRhQOh1sJIFm
 kJ660dB8XyEpnZgQWoQswJwQDvB3CVvDB3yndCpBmWOVemzJz/YVfBL6EspbPCTUImxC
 uk5USEH0SBGvkSYM60El0DwPvzjPRN7tmlegt5yhV026ronWMvr2uleqJVZBa29wApLQ
 aOc7WIyYzQLk8KR3oUsBB0x2fV4o2LYv+xG6pIvrGPR6T/AuEN1YtjXTTZGxTreSb/EC zQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pm2cw14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 15:39:08 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38SFSh6i016337;
        Thu, 28 Sep 2023 15:39:07 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pffu4ak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 15:39:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/kdfHEwdtWy/YrjgDdIPNTNCxI8bMOQR3cAPYJjBYLoN8EraWzFnZL8EB0zVKASuHoUPfEkeYJ7G1RHoVI6mKTOn5kpUrppRqepvTTdCw1NAb+JX5ttjztynjeWmnLqrLTU1N1Z5d50XKibveK5OOh8lGJQ1QLEj9/k2upcJ2jpE8YyeJOTvntOpDKsz0eqEySRgfgaGFkNDFEORQx7ZBT/y1duW4yy/qMgkaTc46Kuo0y2EhFqmDpStWEDKZDIEfvZBYEhcYZja5zPRUeY83MzzAwyiolZPQAxWVgPAx2zWhTPOeaeOw2Tab6fjBe96HaNXoRDsNaXW9HT2l+cHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwBJklaohhxWLK0mHikTuBRxOsGqlc2GTOaI5+BBTA8=;
 b=g4MRh5Aan6LP7dT58hzNnEwSNUFtgWkLl04oLhuTNrdEIlgwVGvZyQpT5nj/jl+bb2As3+pXk9iIBI743SaT7/SyodAjpFfyEpYHRhWUC87osVPp1h4npt2rTlVZFg22h+IYNRq1+m2B0ff24c9xIBWbflu5wLgqYLjKGTPcEu1EA8E4vSJBp6IPjRx2jvSdhZZxx5u/0ISW0J2o+Eqx164/kN1hY2YMUnF5d3YDZPoCXDrXxY5L6/v3UPmtFhlMM3oc8xEkq4BhvcuJfSX7/tv24l6KpUbbkzV/R2ISPx4d9QA+RWex80hNbMwQH6Qs0suJgfE93/zla44AKAmFDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwBJklaohhxWLK0mHikTuBRxOsGqlc2GTOaI5+BBTA8=;
 b=Xo7hlKhfcOWgAA3VcUqAUKOHdJ3NTxQHQUl58qCLwzkz7e8JSTy51mHCXVTRL3OblpNBKxnAUrTvkX12O1i0whKN8Wbb+KBX9JUtUY9KcYQwP49ndD5agm+r+tNI/vMbR5OEzomLPyxLRZL7+KYeLhHapNSRYU7IYn6E3QTNs3w=
Received: from CO6PR10MB5634.namprd10.prod.outlook.com (2603:10b6:303:149::17)
 by CH3PR10MB7210.namprd10.prod.outlook.com (2603:10b6:610:129::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Thu, 28 Sep
 2023 15:39:05 +0000
Received: from CO6PR10MB5634.namprd10.prod.outlook.com
 ([fe80::4e91:7c56:779:4dd]) by CO6PR10MB5634.namprd10.prod.outlook.com
 ([fe80::4e91:7c56:779:4dd%3]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 15:39:05 +0000
Message-ID: <7659c824-ad3e-eb6c-1928-fd438fa68e70@oracle.com>
Date:   Thu, 28 Sep 2023 11:39:03 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [ANNOUNCE] rdma-core: new stable releases
Content-Language: en-US
To:     Nicolas Morey <nmorey@suse.com>, linux-rdma@vger.kernel.org
References: <4410ebe0-c4cb-98ce-e493-0c6cd9a57b74@suse.com>
From:   Mark Haywood <mark.haywood@oracle.com>
In-Reply-To: <4410ebe0-c4cb-98ce-e493-0c6cd9a57b74@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0202.namprd05.prod.outlook.com
 (2603:10b6:a03:330::27) To CO6PR10MB5634.namprd10.prod.outlook.com
 (2603:10b6:303:149::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5634:EE_|CH3PR10MB7210:EE_
X-MS-Office365-Filtering-Correlation-Id: 03c7fcaf-b8ef-4650-40b5-08dbc0390c12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iqIlm1abjfS3gXjYS69l+sHdulyBxHs8OnTCnN7zjvGvICCvAiltwS32jCLnjuHi2zHiDpiKXaHHPsr0/iyKqKiw63K72h4xmobaFFHdT3x8trHSP9P5s7oeaIsBFOLcWk3nVKfIQIaSGrygYYdssQ+f2Htyx3UZHyiFhB412tOzjbiaU5eN7vZHakCwSXVOCVyhhBgXhw+dHYkUYABca6G9KpA18yyVThmd/li21QfcKtSnx2ML5TKTABwSZCy3nzst+FE9ZQJV+oJC7OHjVhlTiCss3vpE0i91XsTLxdxLQtIriOR2umUjgb4h8q2YW6PrKxcvkHektVhYHUQVwYWgze+o8zO4knAtcS0/Atr2YVjGMWdRtxaq5zTTHOm4yskaNj3mmPlULtjS3JIrqCf1HU6A4pEg2vYZreT5W++zB9cxIOWE2opcib6R8JgUyRkFIo1ml5MJD52j3fSAAuh+sPD2ELsujjQdJLhXPKP5wBH3/YnSKJjqp7eNRHxCAczpEkusNNMysu6ajuDHlQUZBr1X6d9vqWyswx1VKoOFy6JZraFbpOt93KVRRMTKznVGSraL45v1lEjE0A4xKgqH05Do8GEg1rzc5SVVkM4JEYFK4woYsKlJ3zMidMg/rsBLflnYCEvaM/saaUppBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5634.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(376002)(39860400002)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(8676002)(41300700001)(316002)(30864003)(83380400001)(966005)(8936002)(53546011)(478600001)(66476007)(6512007)(6486002)(2616005)(66946007)(66556008)(36756003)(2906002)(5660300002)(86362001)(6506007)(44832011)(31696002)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3U2TlYvLzRKUzU5K2Eyc0praExzT3NnSnU5RmFKbWdHcDB2dURrMjdrU3F1?=
 =?utf-8?B?emZ0QmRUd2EzR3NXTWZHQ1V2bll0dlVrZytnQ2V6cW9TS1EvcjVJVG9ZL3Zz?=
 =?utf-8?B?U0lEVjA4NE5tSUNleWx3NW85R2s5UkxwQWhEdll0YTlhK2M4Y01zcXJXb0Fq?=
 =?utf-8?B?a3JDQTZVTmJPZGw3KzdkcExOay9WMWt4dElwbUxkSlV2MmpDUXJlNHZpaU1Q?=
 =?utf-8?B?ZUNJVlNERFRPYmtCeTQ2NWJxRDZNVXduYi9UVXRYQTZKSUVoQ1FkN05tWU5K?=
 =?utf-8?B?SzRBNnAzNG9Bdnp3Y2hiZkpHMjc4M2NyVkRmRjEwZlZ3ak10QndmUUdmK2Mz?=
 =?utf-8?B?VFRqZmNYdWw3WUJUZHpyeEtMTENPMkR3dlRja09Mekl2WHUySmNKOEREVFpE?=
 =?utf-8?B?QncydDVpZ1lCQnFtanljazVjMFNSQ1JMN2xSalhwN1hmNGlrNXBYbVFBVjhr?=
 =?utf-8?B?RWZPZzFTZm13WGc4M1ZxYnpsK0QrZVdTWmpOS0d5MU1OZmJSajF6enFsVDZ5?=
 =?utf-8?B?TG8rMWszaGZVYUorOW1lU0pWZDZhNWtVNEttbWg0eUdvb25NNHM5c1J3bG1I?=
 =?utf-8?B?MWhTUmRoWnNHbzJCQnNPOHlRR0dDRnBUdzFQYjB3RUYwN0wvazdMZ0hBZjYz?=
 =?utf-8?B?QUtOU1NUL1JtK000dW1lWVptTHgvZlhxOGtGZmZHb1YreUduRFNjeXRNamFh?=
 =?utf-8?B?bEt1VnJDWHFGUGlTdWRRZkZRQ1hLUXJXMXUrWExIc0QrdGNVdHRDc3Q0SEZV?=
 =?utf-8?B?MGljMVY0MmxNT3NBRERLUGZFazFJeWgzWCs1SDBxREhXU05hL01JQVBmZHRr?=
 =?utf-8?B?VGJsWTk0Mk9VblNoV28rdjZzUCtXUjhEZFBGY2E5UGFDWDV2dFdRc0RlVTRL?=
 =?utf-8?B?bWRUdGNJUHN5VTMwQ25IQStyZ1F3eFZNNHowVGtSbXZZODZPT051eEZxbjdO?=
 =?utf-8?B?VWlKaTEzdGZjR0lBRHYrVVNyejhHRE1JNnZrYXltQmswYlBZSUl1L2pVcWNL?=
 =?utf-8?B?WU9kRmZQdXRnRkc1TTRBcjJGbmxzZW5lV3ZSU2doL1ZHR0JjTlJ1TXlBNjB4?=
 =?utf-8?B?UHdHOTVCTUUwYk1HNVloV05MN3FWeVMxcEZ2VlIvRjdFSDc2dzhKdExyQ0NC?=
 =?utf-8?B?QnJGV3UvcU1FVDMybXozaXVrOTNwWTVMaXdlQU1QdWdCZjlpRDlwZmJZZFFF?=
 =?utf-8?B?WDhnYzkza08xQngxWG9tbDdBczJnbFRVN2hNVGVENXZXeHBrcE9mMjZNVmJk?=
 =?utf-8?B?SVR5aC8yNUtmajZkZFkrTlA0YXdSRFJFaDB2RXVYWkEwWHpvTXlGQmNyQjdy?=
 =?utf-8?B?Zm9pT3QyMFlYNFJJZGdEZzNBTDFvSlhMeEdwWHZQT2RXajBwdXRiWnBSVlg0?=
 =?utf-8?B?eE5wZ25nRVBCbDU5WGI2SG43ODR0K3A3QldpOCtPTXdZclRNTlZsSkZ6Zm14?=
 =?utf-8?B?M0tyVW9OMDNzeGRvaDZaWTU3SkRYaW5pVDJCNVJLMy9jTHU2bitRUGtIZmJq?=
 =?utf-8?B?dlZsZWo0SGozaVNQUzA2ajdpYmpUZjF3RXZkWWZpR1hxR3czeERmdFZxL1px?=
 =?utf-8?B?WmdzaThlYnYrT1JKRWpNcngvSlNSWEJwY2FzTTVzSVM0VFNHTTFzWHY0aDBa?=
 =?utf-8?B?a0xHVXhXWVFaYzQ0dktZTE5KWk16RHY5dVczb2dlMzlTY2IxRUdFWEdTUkwz?=
 =?utf-8?B?YTVZd0RDTXBvZVcxSDUyVDRmYVNTekdTcDdqamtIc3dVbzcrTTJVQmkxTmph?=
 =?utf-8?B?VHRBY3RyRExEYld2Zm9nWEI4L0lKUkxyb2cwMTBpV29Ha2w1b3NwV0g3UzIx?=
 =?utf-8?B?WEtUb0JsUkI3WWNoaDMvUUdQU1JLTmFhb1Bnb2w0Y01ZRW1NaHRxYnpCYUgr?=
 =?utf-8?B?WENlanlsYitIeXVjQ1ZLMGV0K2RyMVNwWDFCd1JsVEVpOE9zRGVMMHhwOWlw?=
 =?utf-8?B?QUUzUy9mV2VjK2ZxVzNnenR3Y1JPQUdubE9ONHdIbGxubnNteVhFWENrcVdM?=
 =?utf-8?B?cDhvV2srZ0NLRUFNWTZ5ZmpVZzd4anF5S09KNk5PSVprSGpxcWg4SXR2Q0xi?=
 =?utf-8?B?YXBpd3BtaGNUWDB2M3k2dW1iSEFDbzAzWkVqSExMU3loeU9od2xiZGVWa1l3?=
 =?utf-8?B?TTVlcXVmSjZMR3JBTUdCOWdFcE9wMTNMVFVGaXYwekM5c09DeUNuRTdmY2s5?=
 =?utf-8?Q?4F2KBPQYJwxlajxvO0kB2Us=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: s5aRYBi6JEwK2WR1oPmcdoY48Zm8Mr3M/wXb/AZ/Dn0OOfldj4MBR1pnGlFCEhovXDF11VCfzvsw7Rv2mht2OwDw5TkW25hH6lNcH+SkCJ3Uxjgq2sNUEpZKTP902YC6tKVJ2PL7hpw9fuZj+9Mxf/4vUkpYRbIl/gphXKa1mzexoz55syAJbQiwvm/CekyveudcFu+dY27DQvxt1OUhQnoNbN1xXnQocrN1z4vK9csYNWDwbD8Kt+cGeuBwZ9K8Y2twqSCjtK7FzZkTwWxCMJLCUs0N003U3n2yZtjutNouw7qFe6WkCmfQkxbIeb4fFD/cHqiRLghHoL7TkDVvblMOk6IRZmlCqUQEJCOzMH8ft7rILL3W0QegfaEq8Mkr6tSZldrXZw7Iq83iO2F5bBD2VSzw111q0ksEcHMfpTJWtgr8Y6W7uRdANsyEKT20ZqW4UGBrj1NMsSpmp7yA8tHnXVek68VAA2tlv+pcrNsoTX/T2ktZMd7ntHiF/wWnY6kpnQQRO4pRLzCqcmE08GFAlH57vFSJUHBv7TEf9VGDPusIY2mDM20XCy/M0w8zRLhdHIoFOLJtEt3eaL2E0nJDCRZw22MMN35Srr+Q935kPdiRml1Gd24nV2EAiqUXx3DGV+lvkV99OyD531qmpwsADZwvKWeTQsZbUdG/+Ac6JVFHbQTuEYlqF1dvrvU+t5lVOk4khSFQAgN6Hr5H5v7Rcc5qcd1enwtd0FZcVQurs4XrQqKWskih9aVgI8aUOP1zFUE7HQIOtt6rj+j52Ek2oWXUxo+FIwvhrr3Dil8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c7fcaf-b8ef-4650-40b5-08dbc0390c12
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5634.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 15:39:05.2631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7QE+RmgTQuUCFmDiUx+H0+LYj0qajImf7v/L+4SwNK11g7n9HWR6w+JnFAakUwDc1HmDXnoqwET87jxnfKSvSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7210
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_15,2023-09-28_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309280136
X-Proofpoint-ORIG-GUID: 68P7hcso6gFWG4DAedOpSfKnz7VnJHbB
X-Proofpoint-GUID: 68P7hcso6gFWG4DAedOpSfKnz7VnJHbB
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I see v48.0 was tagged. Is it not a stable release?

Thanks.
Mark

On 9/21/23 9:55 AM, Nicolas Morey wrote:
> *** IMPORTANT: Due to its age, branch v28 has been retired. ***
>
> These version were tagged/released:
>   * v28.12
>   * v29.11
>   * v30.11
>   * v31.12
>   * v32.11
>   * v33.11
>   * v34.10
>   * v35.9
>   * v36.9
>   * v37.8
>   * v38.7
>   * v39.6
>   * v40.5
>   * v41.5
>   * v42.5
>   * v43.4
>   * v44.4
>   * v45.3
>   * v46.2
>   * v47.1
>
> It's available at the normal places:
>
> git://github.com/linux-rdma/rdma-core
> https://github.com/linux-rdma/rdma-core/releases
>
> ---
>
> Here's the information from the tags:
> tag v28.12
> Tagger: Nicolas Morey <nmorey@suse.com>
> Date:   Thu Sep 21 09:43:38 2023 +0200
>
> rdma-core-28.12:
>
> Updates from version 28.11
>   * Backport fixes:
>     * build: unbreak configure stage when RELWITHDEBINFO is blank/has space
>     * librmdacm: Remove not exported symbols from linker map
>     * libibverbs: Remove nonexistent symbols from the linker map
>     * pyverbs: Fix randrange deprecation warning
> -----BEGIN PGP SIGNATURE-----
>
> iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmUL9CofHG5pY29sYXNA
> bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZB07B/9sWQEtMtOYqV0+
> P0Rd5sAXjuA5M3JxSbfuxjObZHyH9E+jCMHGPA9UCphMWSrdueBmPu7hsqdUaghu
> /Ece74FsYIUH3M81X1HSBklrryAwM0IbLBkG0gYusGQdvQe2kGMXu2fgOmXJxfH1
> I/BY+UKl1Jm1puI+6I70GLGNZgSyUqKO6zjqikdp159vgPoBCD+eSluhJVtgxtZt
> UXjhCLfFArzWSLsMZdzCahvPJ5OBSvgH/TwQHD+5mZUQ5ZDD0J7kzTkQkmeQeP5f
> m15auIGwjPSJaPTaUx4gt4szLuiDa3SMMWC7nB+GYz7hfrOcZWmLZGJhqWz90ugn
> l24c4mgT
> =IHcu
> -----END PGP SIGNATURE-----
>
> tag v29.11
> Tagger: Nicolas Morey <nmorey@suse.com>
> Date:   Thu Sep 21 09:44:01 2023 +0200
>
> rdma-core-29.11:
>
> Updates from version 29.10
>   * Backport fixes:
>     * build: unbreak configure stage when RELWITHDEBINFO is blank/has space
>     * librmdacm: Remove not exported symbols from linker map
>     * libibverbs: Remove nonexistent symbols from the linker map
>     * pyverbs: Fix randrange deprecation warning
> -----BEGIN PGP SIGNATURE-----
>
> iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmUL9EEfHG5pY29sYXNA
> bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZP2CB/96pqHxDbSnRyzl
> hgjFnAeYBe8PJdroVMEK3i+4Ro4X04MRG3nIb+pTCS0j0NnbCE/UDxSAjoIoAEAR
> Uu4D2QptEI+3q9yU6OVFrLjfusX2HCa3f2WxSnZEhgWWoMjg7fif4E/WGMjHBjT1
> l5QmWcvOmciFPzEoooSpWgexCGgaNFR/QkyYSAiolbmdSYAHyCREN30KBJBDlwOX
> iobyfQu4SvfSeFJe71RE6yBQRe/1VKkQpSMVO/eJ/z/dp2vu7vbdsXyjsAku8LKb
> kLTuhdPWYWLl+VsAHN7RonT4HaDe7CeAEz2apaeuoQABPiuq8x8XFax3VzlYwEk4
> QQADJDrd
> =XNz1
> -----END PGP SIGNATURE-----
>
> tag v30.11
> Tagger: Nicolas Morey <nmorey@suse.com>
> Date:   Thu Sep 21 09:44:02 2023 +0200
>
> rdma-core-30.11:
>
> Updates from version 30.10
>   * Backport fixes:
>     * build: unbreak configure stage when RELWITHDEBINFO is blank/has space
>     * tests: Fix rdmacm async udp
>     * tests: Move RDMACM tests to be in one direction
>     * librmdacm: Remove not exported symbols from linker map
>     * libibverbs: Remove nonexistent symbols from the linker map
>     * pyverbs: Fix randrange deprecation warning
> -----BEGIN PGP SIGNATURE-----
>
> iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmUL9EIfHG5pY29sYXNA
> bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZEnHB/0UQLUq/GBjXlSI
> pWYo22v2kgO4cctXMNgMY74MqJ6L7rJhYYs7OBu07azlI69elEVZ6HoCwiG5OgGh
> 46tOdy6oZI8QOjR01w3aIavbok9HLmxujamipAm8aiK6Lh9SElslNrLSxxQM/xTW
> 0d8i0rXXQaRQKooJOkYqmG8sU2LrMvN8fJmrKlj6QTp3nJXeNXAmbJZIxFq4AKfV
> IJN3qwPRBo1c8Zj8xWKDwmLacjyg3nheZ2vaKELRjGc6PsAFOt1kDorPNjqv2EPI
> 5jt1EbW5upEh/R+jAawlai1r8ePkuUld5FhAL/hc8j4rJZZoCf8a3NZkxrroT0v3
> 0IjTCpK+
> =W8VB
> -----END PGP SIGNATURE-----
>
> tag v31.12
> Tagger: Nicolas Morey <nmorey@suse.com>
> Date:   Thu Sep 21 09:44:03 2023 +0200
>
> rdma-core-31.12:
>
> Updates from version 31.11
>   * Backport fixes:
>     * build: unbreak configure stage when RELWITHDEBINFO is blank/has space
>     * tests: Fix rdmacm async udp
>     * tests: Move RDMACM tests to be in one direction
>     * librmdacm: Remove not exported symbols from linker map
>     * libibverbs: Remove nonexistent symbols from the linker map
>     * pyverbs: Fix randrange deprecation warning
> -----BEGIN PGP SIGNATURE-----
>
> iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmUL9EMfHG5pY29sYXNA
> bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZOJ+B/9lx9ZFWMpBliDp
> Pa6Mswz6onhYnjWxknaEwfNO6YZjAQ0L8QXJlhY5w6G7P6KeU20UDjcqD0uKdZ5N
> LPdtkDAb68ZbBo6bSrgiJq6YOiacE5+NoEoT9JB23VYmKmbEup9qjEALWvE3eqVJ
> iRIMnyMIwPslMYA1uTwBSWtlS1Bq1WSs8IfwJ1cTcceu4LZe/Alfe9ZCDW7iwO9U
> UfPmVtqftZ208xjv4OHdWCRIyyFeKzYX3iiZyQExWGvwtGBrWP2zCBxpFuoh/96F
> DiVD9pGhSRbfSggDLmbzL2YQ5QA7M7unDjLaNCkXJjvwxLoaoH87AmMeAPDtxZLG
> SRfqS/17
> =aOpI
> -----END PGP SIGNATURE-----
>
> tag v32.11
> Tagger: Nicolas Morey <nmorey@suse.com>
> Date:   Thu Sep 21 09:44:03 2023 +0200
>
> rdma-core-32.11:
>
> Updates from version 32.10
>   * Backport fixes:
>     * build: unbreak configure stage when RELWITHDEBINFO is blank/has space
>     * mlx5: DR, Fix dest-root-table action for NIC TX
>     * tests: Fix rdmacm async udp
>     * tests: Move RDMACM tests to be in one direction
>     * librmdacm: Remove not exported symbols from linker map
>     * libibverbs: Remove nonexistent symbols from the linker map
>     * pyverbs: Fix randrange deprecation warning
> -----BEGIN PGP SIGNATURE-----
>
> iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmUL9EMfHG5pY29sYXNA
> bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZJfTB/42ZFvcFYxYfm/K
> Zf//p+U975u2bSSGdSJHewdUzKAadb17lpChf4qh4+eFElrnDQZz5f5T+QywkPts
> jbhzKRh2WfHhn7LUIh2FNbiP+ESxfrK4t+d+k2V/DpIwFVYCclRGYVLoMzcOMb8D
> UvPrIKCUcuBQ6oGdK/RjxxSIEv5huP4AO3LCP8QxU99ShskxbzCZbK+enPvyS0uq
> OBURW/kTnlgNWgMWrCtbRbMuCnN7A547Le5ytAkb8UBvi9q7PorEi1hEIkuYvq/b
> 4lgfD8FZZHpzM/3zswq/KSOsBME4qlY1abwillQbzRtN3mfZzKAiEOuKoDwr/7P3
> ewq/mKtV
> =tSXE
> -----END PGP SIGNATURE-----
>
> tag v33.11
> Tagger: Nicolas Morey <nmorey@suse.com>
> Date:   Thu Sep 21 09:44:04 2023 +0200
>
> rdma-core-33.11:
>
> Updates from version 33.10
>   * Backport fixes:
>     * build: unbreak configure stage when RELWITHDEBINFO is blank/has space
>     * mlx5: DR, Fix dest-root-table action for NIC TX
>     * tests: Fix rdmacm async udp
>     * tests: Move RDMACM tests to be in one direction
>     * librmdacm: Remove not exported symbols from linker map
>     * libibverbs: Remove nonexistent symbols from the linker map
>     * pyverbs: Fix randrange deprecation warning
> -----BEGIN PGP SIGNATURE-----
>
> iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmUL9EQfHG5pY29sYXNA
> bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZKHLCACJIOmV6VWsqxhB
> n6IO0ZFEz5HftMSxGYZgGr96DmwTz9cZrSYmlBsRhHst+o0YB3ArWYJiltiYaRS+
> 2mbKk1wu1eL1ESxR+6LYXLq9UfXBLYRI8IoutN869ySmPPWV8/La/ZSIWEj9v69c
> 458HYeB+sb/X8pjQt7xPuvVfEdR5ZXWZX0v0LJXHWlYa1VZK8/LF51APDGC5Xk9+
> jEk1CJiEnYG4YHRmzBgCvlZ+R3+EWkufByf/iCjLInVx1qkc4buvED9VAFXGGOvB
> ZYc10JymL9T0q5Cuj/q9JD8pThMdjmHguZk1uIPt+4r7xsRz50wOK2ExOCYVlBjE
> ZCmmPQaf
> =/Y0E
> -----END PGP SIGNATURE-----
>
> tag v34.10
> Tagger: Nicolas Morey <nmorey@suse.com>
> Date:   Thu Sep 21 09:44:04 2023 +0200
>
> rdma-core-34.10:
>
> Updates from version 34.9
>   * Backport fixes:
>     * build: unbreak configure stage when RELWITHDEBINFO is blank/has space
>     * mlx5: DR, Fix dest-root-table action for NIC TX
>     * tests: Fix rdmacm async udp
>     * tests: Move RDMACM tests to be in one direction
>     * librmdacm: Remove not exported symbols from linker map
>     * libibverbs: Remove nonexistent symbols from the linker map
>     * pyverbs: Fix randrange deprecation warning
> -----BEGIN PGP SIGNATURE-----
>
> iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmUL9EQfHG5pY29sYXNA
> bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZHvHB/0SWTr/4bSBnwvv
> 4cN9Dm3cwEz6o5tXrNLT+O6n7edqcueOLzP+rLFy3s6eX4yHoiryspi5+XnOkuy2
> LCkq57zG6935lAB7Uc4is+6iGpDLU8Dy/+IfKKk0JPlPpHGEe4KMl9xFa+HRQTgX
> dytACzy4rzaytFKjFy7E554EvxRQ8lNtXfwnWqZNnXdksRJQdth/YXmLgSku10KQ
> rc868BIafbpwR+7Cp9Dk3lHkfY1Us5w8HiElogF32SVU35A5KvN5D9TaU7F5u8D9
> LN8HYUSSt+SR8pGKJvheHKCFLhZigktXMkpD9sRJHL2TVrkObymfBUgiDmF0H2ZY
> lVTTN9S9
> =y7W+
> -----END PGP SIGNATURE-----
>
> tag v35.9
> Tagger: Nicolas Morey <nmorey@suse.com>
> Date:   Thu Sep 21 09:44:05 2023 +0200
>
> rdma-core-35.9:
>
> Updates from version 35.8
>   * Backport fixes:
>     * build: unbreak configure stage when RELWITHDEBINFO is blank/has space
>     * mlx5: DR, Fix dest-root-table action for NIC TX
>     * tests: Fix rdmacm async udp
>     * tests: Move RDMACM tests to be in one direction
>     * librmdacm: Remove not exported symbols from linker map
>     * libibverbs: Remove nonexistent symbols from the linker map
>     * pyverbs: Fix randrange deprecation warning
> -----BEGIN PGP SIGNATURE-----
>
> iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmUL9EUfHG5pY29sYXNA
> bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZEWRB/48/7d1QLloL6yv
> DurhLfZcMTieKT1HMrAu7SthwphmYPZLlrWBEOQR8ng26hInYis2yfLaV3pdsYC6
> uIjPpHz0xkU/qrWYakOikZ2sjKqxX8YVU/qA0d3VU3XutRBIDtRJrCsxdkVqRIKQ
> gDaHuEaz4/I2P09nDb/CEhFN7ZHcNRiDAIj4b0+ALamC1MUhTJv3be+0adD53YtM
> O6ENivmeIR6ybtvht6wbiDsQ3SkNXr3OxHKHskBDzUkXHNX5GHg63eZ7HOKizShz
> fXjHq65F2sR8iNYuQPmOUHyi56qTz5nMlD0gA7NNV5yI1MJDvbEyk0VFayjTvIlX
> IC3SSNXp
> =Kwt+
> -----END PGP SIGNATURE-----
>
> tag v36.9
> Tagger: Nicolas Morey <nmorey@suse.com>
> Date:   Thu Sep 21 09:44:06 2023 +0200
>
> rdma-core-36.9:
>
> Updates from version 36.8
>   * Backport fixes:
>     * build: unbreak configure stage when RELWITHDEBINFO is blank/has space
>     * mlx5: DR, Fix dest-root-table action for NIC TX
>     * tests: Fix rdmacm async udp
>     * tests: Move RDMACM tests to be in one direction
>     * librmdacm: Remove not exported symbols from linker map
>     * libibverbs: Remove nonexistent symbols from the linker map
>     * pyverbs: Fix randrange deprecation warning
> -----BEGIN PGP SIGNATURE-----
>
> iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmUL9EYfHG5pY29sYXNA
> bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZJhJCAC0tyJ+1smjVGGq
> 0ECGPWazWpxcZgJX+GvpXAvf1ZE2/+sVvZfftALMDNZuNA/cA8lXpv3FAWXNGBFz
> GhSOJDtbc4Pq5HujvLdYNNcMOaRKxJIxBZiu4dlGtOpb9X5Ct1O91pbgn9w8JLhf
> qYn2tbHDByT7j1RrS0Tnp2LlrQGvZgAJr0kEG+ujJ+WhAf6kbAN7WqtAa6RkxB78
> tCINisrm8cUUVGpjVhB04i1kIHMm1Kgcv4FIunJX1NAbCGx4fKsXFnWBIcqSKGJx
> ySgVjqjQtsYCHX+n8P2Hqxg3mX7Uj//FsIuD5vHLtyglZXa1Gh9zUq1jfks2FUw6
> X+yOJi0S
> =Z/bV
> -----END PGP SIGNATURE-----
>
> tag v37.8
> Tagger: Nicolas Morey <nmorey@suse.com>
> Date:   Thu Sep 21 09:44:06 2023 +0200
>
> rdma-core-37.8:
>
> Updates from version 37.7
>   * Backport fixes:
>     * build: unbreak configure stage when RELWITHDEBINFO is blank/has space
>     * providers/irdma: Verify max_send_wr and max_recv_wr
>     * mlx5: DR, Fix dest-root-table action for NIC TX
>     * tests: Fix rdmacm async udp
>     * tests: Move RDMACM tests to be in one direction
>     * librmdacm: Remove not exported symbols from linker map
>     * libibverbs: Remove nonexistent symbols from the linker map
>     * pyverbs: Fix randrange deprecation warning
> -----BEGIN PGP SIGNATURE-----
>
> iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmUL9EYfHG5pY29sYXNA
> bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZKW4B/9SQo2IWTINALR+
> nY6/TdcuslBai7kvDlKG4YyiNKvS5SPWTJxnaijTRNV+DX3jbCFEDc0q2frGfmoN
> BVw1iTUEcBax+Bnh9VmyZPoLt3XMUbMaEpoy7oowqL9lMvDUhZ8xruCEWHyR+rYt
> hlJR4imK/cqsrSN8enzajdPoOvcpxI2gb5tD5UNQRKAdBHgRoXXrG/G7qpgXugff
> ep/YTJN7TXQmDxxUW7+FoSj+qS1keQSLYqmSamwe7Hsf9p8jKUHr5CY5qOQ6tVZJ
> JRan+W8/BvJ7gFGBtvNL+cVgCvMkbPo3YM6/3KMJx60a/zKbMJes86ikxURtZ8be
> DNq3Fm0v
> =y4Aw
> -----END PGP SIGNATURE-----
>
> tag v38.7
> Tagger: Nicolas Morey <nmorey@suse.com>
> Date:   Thu Sep 21 09:44:07 2023 +0200
>
> rdma-core-38.7:
>
> Updates from version 38.6
>   * Backport fixes:
>     * build: unbreak configure stage when RELWITHDEBINFO is blank/has space
>     * providers/irdma: Verify max_send_wr and max_recv_wr
>     * mlx5: DR, Fix dest-root-table action for NIC TX
>     * tests: Fix rdmacm async udp
>     * tests: Move RDMACM tests to be in one direction
>     * librmdacm: Remove not exported symbols from linker map
>     * libibverbs: Remove nonexistent symbols from the linker map
>     * pyverbs: Fix randrange deprecation warning
> -----BEGIN PGP SIGNATURE-----
>
> iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmUL9EcfHG5pY29sYXNA
> bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZOcnB/9BHnPbIbs48MFK
> 4ixb5rkyr+RD8ZtGeNz9mg9pCBjZC2ghaLE9y/u7pCSuWSpIxXJJk/aMXNW13MyU
> vOsgPbnQOj+F/zak56/npkj7k2JjMJL/rCxOsoqiKo6IX1t6eZeRz6UNAC2wqKwe
> Wqqw9hVQ0mExYpXhrcU2S2Ez/v/OeYv0mhTJzd7dF+AZq6zl/THFXOq9gXt7tmLm
> u9CSOFpc6lv32qIvgF9fIsf+p7sRwZUGgDOvLKNG7IayaB/7Fy5A2OkCuqKUqEWc
> dzVPeKwQWxMBqOfaYQwFLpysvPIaBpMXnXeD+3byZFfV37sQjbCsVsUrGNnXe8gJ
> Y8ypz+jv
> =5TLH
> -----END PGP SIGNATURE-----
>
> tag v39.6
> Tagger: Nicolas Morey <nmorey@suse.com>
> Date:   Thu Sep 21 09:44:08 2023 +0200
>
> rdma-core-39.6:
>
> Updates from version 39.5
>   * Backport fixes:
>     * build: unbreak configure stage when RELWITHDEBINFO is blank/has space
>     * providers/irdma: Verify max_send_wr and max_recv_wr
>     * mlx5: DR, Fix dest-root-table action for NIC TX
>     * tests: Fix rdmacm async udp
>     * tests: Move RDMACM tests to be in one direction
>     * librmdacm: Remove not exported symbols from linker map
>     * libibverbs: Remove nonexistent symbols from the linker map
>     * pyverbs: Fix randrange deprecation warning
> -----BEGIN PGP SIGNATURE-----
>
> iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmUL9EgfHG5pY29sYXNA
> bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZECLB/99QY2nRDHCHkQ1
> UAO7LsnYQ40jX+RL1PcAkyQ82Xd9y2A7JYkm4qBUl6N3LrLva5OQqdL4MSt523qW
> OmRnq/92gViOiQcdL8l+aVYS3vpMZGI1em3148SuSBr10EFG7icWm+I9wILBGKmN
> dMCy7su/pkMJdacIa2NnR0B8tCg03n5XlmbtYwcoQSA3aDtyMB4QTuXfIPQPEpHT
> MAroGDvkQL9Kdibzap0AALVkQfCpCSggvm2TQu1zO+nPonjr/MST57DbEWng5gOD
> sDmGPJ9pvs/1+yz9y1RP6HdXW8kKNumtScHG8Br+q0TW32iNBLOfkHgBQR2/jJ1p
> Gf/8htGD
> =LUZW
> -----END PGP SIGNATURE-----
>
> tag v40.5
> Tagger: Nicolas Morey <nmorey@suse.com>
> Date:   Thu Sep 21 09:44:09 2023 +0200
>
> rdma-core-40.5:
>
> Updates from version 40.4
>   * Backport fixes:
>     * build: unbreak configure stage when RELWITHDEBINFO is blank/has space
>     * providers/irdma: Verify max_send_wr and max_recv_wr
>     * mlx5: DR, Fix dest-root-table action for NIC TX
>     * tests: Fix rdmacm async udp
>     * tests: Move RDMACM tests to be in one direction
>     * librmdacm: Remove not exported symbols from linker map
>     * libibverbs: Remove nonexistent symbols from the linker map
>     * pyverbs: Fix randrange deprecation warning
> -----BEGIN PGP SIGNATURE-----
>
> iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmUL9EkfHG5pY29sYXNA
> bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZNILB/9t9fUBpw024K+Q
> S7AaRI8/XtiAySDukvh+C6ToKEyNvr+b8srEDbHM9JGJ6tUmGP0yTD7pxyKyIdmx
> HQHMUSTG9ySH6MutY4Rzh4XwPgTtj44QU1Bbfyzcq2eKOdRLeHQPiWdIKLSP7y7N
> g2eTh+FDwh0ymvljgArr5xZyJmss5WHedTbvpOXQKqok9fssl1N3d/nnZs30O2Lv
> kQ83sPBAJUWLcN91dlsBhSQI8bli4eopg3cvNQ10LXKmOBM2HgOOdLqtBUITNLde
> aujtD7O9Zd/ywhqi7ekWHJRf2HIHuPmt/WDvTRtzO4/is2dsUv1b4yJFan8PLJqb
> VTukIAdP
> =tMz1
> -----END PGP SIGNATURE-----
>
> tag v41.5
> Tagger: Nicolas Morey <nmorey@suse.com>
> Date:   Thu Sep 21 09:44:11 2023 +0200
>
> rdma-core-41.5:
>
> Updates from version 41.4
>   * Backport fixes:
>     * build: unbreak configure stage when RELWITHDEBINFO is blank/has space
>     * providers/irdma: Verify max_send_wr and max_recv_wr
>     * mlx5: DR, Fix dest-root-table action for NIC TX
>     * tests: Fix rdmacm async udp
>     * tests: Move RDMACM tests to be in one direction
>     * librmdacm: Remove not exported symbols from linker map
>     * libibverbs: Remove nonexistent symbols from the linker map
>     * pyverbs: Fix randrange deprecation warning
> -----BEGIN PGP SIGNATURE-----
>
> iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmUL9EsfHG5pY29sYXNA
> bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZMG1CACG4akfZJe/C0lI
> krZtrarF+qpZZY+9S4mZDzomElbgnvqOCgW9klRlmagUvXFbBBjRdDhXYafQrUuJ
> xejw9Zp7//lH3pPAbYHCdbrRm3mW7i5b0MIH3gf31B3Zhi1I9WOfO66iV68R5BLC
> O3IgmJ9Vz10F1RuJeeNF6+PKx/QNMHf80cB+5EC7QoZv3Nu6FaytBjzJzf9p9utG
> UX6qgeaxLu8dYVoiTh0mMcEXMUJnnQ0fRInJrQNX+WFfsuZu4s97v8N5g05IDqqL
> nCXyvHcKJE8CbJs0gGZZOE4JOBmtAlNbtGSjrOkcH/jShZpBoARvI9gRVenzA+34
> w+LPGAg3
> =3TTp
> -----END PGP SIGNATURE-----
>
> tag v42.5
> Tagger: Nicolas Morey <nmorey@suse.com>
> Date:   Thu Sep 21 09:44:12 2023 +0200
>
> rdma-core-42.5:
>
> Updates from version 42.4
>   * Backport fixes:
>     * build: unbreak configure stage when RELWITHDEBINFO is blank/has space
>     * providers/irdma: Verify max_send_wr and max_recv_wr
>     * mlx5: DR, Fix dest-root-table action for NIC TX
>     * tests: Fix rdmacm async udp
>     * tests: Move RDMACM tests to be in one direction
>     * librmdacm: Remove not exported symbols from linker map
>     * libibverbs: Remove nonexistent symbols from the linker map
>     * pyverbs: Fix randrange deprecation warning
> -----BEGIN PGP SIGNATURE-----
>
> iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmUL9EwfHG5pY29sYXNA
> bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZKk1B/443pkpbGvg5Z5d
> g4oXGhO/jephluYTCu4WK6UUn32w23H2NzqTqiB1yunRc4EziPLbN1KxErRPZABv
> Y7N3RjKnwYER/8u0XD2XKutMJpojmWj2YSPZ/YQBlwa3a6Tu11CCo9R+G1kLF23y
> mONMR4CCyEqmgPrIIgp2+ovZqpVyf216MNyAu4R3YtljeMg44gvA7JhxYf10+8oF
> eS3PFXmpHH2S+A/C12/9H7sOdmILUQQm6wLu8UBH6gjwdudet+eh5ci90+/Tf6uj
> ziSC3zziMi6jAk/ElRsIVPg+cmHD9hULVjHu7lDueNYapfkPtQLmuSloOy/eAfHs
> EeCENAAp
> =y+J5
> -----END PGP SIGNATURE-----
>
> tag v43.4
> Tagger: Nicolas Morey <nmorey@suse.com>
> Date:   Thu Sep 21 09:44:12 2023 +0200
>
> rdma-core-43.4:
>
> Updates from version 43.3
>   * Backport fixes:
>     * build: unbreak configure stage when RELWITHDEBINFO is blank/has space
>     * providers/irdma: Verify max_send_wr and max_recv_wr
>     * mlx5: DR, Fix dest-root-table action for NIC TX
>     * tests: Fix rdmacm async udp
>     * tests: Move RDMACM tests to be in one direction
>     * librmdacm: Remove not exported symbols from linker map
>     * libibverbs: Remove nonexistent symbols from the linker map
>     * pyverbs: Fix randrange deprecation warning
> -----BEGIN PGP SIGNATURE-----
>
> iQFSBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmUL9EwfHG5pY29sYXNA
> bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZNCHB/doOhCAA1wKMD1s
> kZnMaz1VupWF9xeyMMGnmRCVvvdPx7zvlFWlqkd8iFvy20Au6OGu2AOzoCxe7lcg
> RhjRXZHx+VdGU+6Yunkwnb4f1VYYePHI1/sIq+wKjByJbDZKW7HSWJ8knwXTQ3XG
> lFiJ2kJaFWEZ+gsLRQTOytDXZ8xnfN5qXOehOoT5ZZXGSmBV8UeO1EonfNY1gseD
> VcUKeUdTf6XAdYgCmYHiIkl1oQuyl9monDWRaZofgCOW9afhtajOFBQ8Hpif2jJG
> OF7YhLPH1zMLBrHny9p+bQHXiRqLY9d0G1TBthwtP93CA151ZHhzy/LZvIRJu1bX
> llCU0Ps=
> =/bOh
> -----END PGP SIGNATURE-----
>
> tag v44.4
> Tagger: Nicolas Morey <nmorey@suse.com>
> Date:   Thu Sep 21 09:44:13 2023 +0200
>
> rdma-core-44.4:
>
> Updates from version 44.3
>   * Backport fixes:
>     * pyverbs: Fix typo in DrActionFlowSample creation
>     * suse: remove obsolete defattr macros
>     * build: unbreak configure stage when RELWITHDEBINFO is blank/has space
>     * providers/irdma: Verify max_send_wr and max_recv_wr
>     * mlx5: DR, Fix dest-root-table action for NIC TX
>     * tests: Fix rdmacm async udp
>     * librmdacm: Remove not exported symbols from linker map
>     * libibverbs: Remove nonexistent symbols from the linker map
>     * tests: Require being root to run test_obj_on_huge
>     * pyverbs: Fix randrange deprecation warning
> -----BEGIN PGP SIGNATURE-----
>
> iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmUL9E0fHG5pY29sYXNA
> bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZDv3B/wJzl2G4jMJc6yd
> EU3jc3xKPmK2sKY8ZEhAo8XF+g3LnOlexHWoXSK5P4aGDxYtrNaJpc3Ojf04rfbs
> hhaLbbJRZ+5cFNcWlin47jkl+5RP+KVSzWzrzXQv9qY46IC6+ITVUh6q9LR082G8
> uYlVPPqqEiHWf7/vUahosYXDL2inQgxw5Dtv/j4vQWOwQBhXbGhCVlPEDfFMaYIK
> LNo0WH3x4lGmmprnLg8SW0y1JDXXAGFAjNsZKu4CIkg/x3+BTsrtL8ldgAJBd4Sj
> nFkEl0RRJu/Vc3nWToEUX4tV1ku0xBJ5Lq4mUdtK7jtpvAyamdh7Z0SN9Qt3GtpS
> TRxhQ8Cv
> =RPcH
> -----END PGP SIGNATURE-----
>
> tag v45.3
> Tagger: Nicolas Morey <nmorey@suse.com>
> Date:   Thu Sep 21 09:44:13 2023 +0200
>
> rdma-core-45.3:
>
> Updates from version 45.2
>   * Backport fixes:
>     * pyverbs: Fix typo in DrActionFlowSample creation
>     * suse: remove obsolete defattr macros
>     * build: unbreak configure stage when RELWITHDEBINFO is blank/has space
>     * providers/irdma: Verify max_send_wr and max_recv_wr
>     * mlx5: DR, Fix dest-root-table action for NIC TX
>     * tests: Fix rdmacm async udp
>     * librmdacm: Remove not exported symbols from linker map
>     * libibverbs: Remove nonexistent symbols from the linker map
>     * tests: Require being root to run test_obj_on_huge
>     * pyverbs: Fix randrange deprecation warning
> -----BEGIN PGP SIGNATURE-----
>
> iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmUL9E4fHG5pY29sYXNA
> bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZDVLB/4gyJkouc7zqwlk
> 7RYUiGLyCGxTHlzF3xyUt9NrjDgTM6+5e10/qOjlSCVj2uZwB3hDkTC6OeMtE69y
> 7N1hyDCROdJjp9Ls9geQGVpQ+XG1vG8ASJ0x3DAF8UYRxqR72lfbhUw8G93FNSV2
> OlNLmjrgw8/2LmOr1gFJzjj6XEJ74fH1sBbNdozuLZkC2XI7fquGnBsXoJ2j1oAf
> TFVJznEcNdhRwYSOX5VgGR9WcVij5QGtwJZp0ajkZEwAIxGsEtAbDlpVIuluuXry
> +Da7ySGXQAenw5zfdkLM3zsN/6zOTirV6VhN2mZ3V/dQUj7AyiqSpQ6g7gBHe96P
> SA+bnJUT
> =QH39
> -----END PGP SIGNATURE-----
>
> tag v46.2
> Tagger: Nicolas Morey <nmorey@suse.com>
> Date:   Thu Sep 21 09:44:14 2023 +0200
>
> rdma-core-46.2:
>
> Updates from version 46.1
>   * Backport fixes:
>     * pyverbs: Fix typo in DrActionFlowSample creation
>     * suse: remove obsolete defattr macros
>     * build: unbreak configure stage when RELWITHDEBINFO is blank/has space
>     * providers/irdma: Verify max_send_wr and max_recv_wr
>     * mlx5: DR, Fix dest-root-table action for NIC TX
>     * tests: Fix rdmacm async udp
>     * librmdacm: Remove not exported symbols from linker map
>     * libibverbs: Remove nonexistent symbols from the linker map
>     * tests: Require being root to run test_obj_on_huge
>     * pyverbs: Fix randrange deprecation warning
> -----BEGIN PGP SIGNATURE-----
>
> iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmUL9E4fHG5pY29sYXNA
> bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZEfyCACynJCh9sFrOqdV
> ksE7TX6Aiu0BzxZc3dji7ehGzqINnHCLd+FvzJk+v6mdGl3SK82IVrmvlZiTgWBT
> CG22FYBeFerl5xg3gjuFwcySypPZSsig7xJXQSiELf57iatN9dncFarBykInv6TN
> mbun6TmNg5LqyYuGJ0vivuyxnD8KGH1RuRKRDddXYO8VqfJNN7s9sEm3eigaS7kQ
> tGRNiwhU4w/1gqMbwe+IugdS5eFV+6X3lvD95fiNW7CcksabBWBFgl4QUbO1WgjA
> Vp22YjwiDXjQOoGRnLp6BzM/KH19LaXhGDkP7f5C59Ucx+4OCXuI3zq8Sf6/CL5K
> ZHxp6soX
> =bhqz
> -----END PGP SIGNATURE-----
>
> tag v47.1
> Tagger: Nicolas Morey <nmorey@suse.com>
> Date:   Thu Sep 21 09:44:15 2023 +0200
>
> rdma-core-47.1:
>
> Updates from version 47.0
>   * Backport fixes:
>     * pyverbs: Fix typo in DrActionFlowSample creation
>     * suse: remove obsolete defattr macros
>     * build: unbreak configure stage when RELWITHDEBINFO is blank/has space
>     * providers/irdma: Verify max_send_wr and max_recv_wr
>     * mlx5: DR, Fix dest-root-table action for NIC TX
>     * tests: Fix rdmacm async udp
>     * librmdacm: Remove not exported symbols from linker map
>     * libibverbs: Remove nonexistent symbols from the linker map
>     * tests: Require being root to run test_obj_on_huge
>     * pyverbs: Fix randrange deprecation warning
>     * stable branch creation
> -----BEGIN PGP SIGNATURE-----
>
> iQFTBAABCAA9FiEEQtJThcGhwCuLGxxvgBvduCWYj2QFAmUL9E8fHG5pY29sYXNA
> bW9yZXktY2hhaXNlbWFydGluLmNvbQAKCRCAG924JZiPZKIQB/wJbRXqhJSzbrdy
> sTpipPQlYbRk+o44kppzihEp/wsB7wTbzauQBnw2I8tuVImApkGNHG1o6OPchVLK
> IHcxSGbbJX9U/cn7fBxCzHlVCWGW+WZQ+esBA/1HY4GyD772Ncgg86AN0R4dz585
> BrEAYxdxDcNVB4ZdIWejgZQWodtK0YdRXFX15KhQT3IiVVUmwgEecY4gSp2jC8df
> j/6ptAWbeJrd/bTyHzBWFRV/P3y2GaNRiUqkp7wGbOjHmt9qVmQTUG/pUYJK/8QB
> Wip2a/Sb+f/fI/M/CX+42wBwR4TgqSCHH8vhNeMhthoF3lXhuj4YEbDkrnHfCBXb
> 5kBCCJ8d
> =uLHZ
> -----END PGP SIGNATURE-----
>

