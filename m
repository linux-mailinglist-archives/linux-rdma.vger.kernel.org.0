Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0C265CA25
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jan 2023 00:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbjACXEe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Jan 2023 18:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbjACXEb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Jan 2023 18:04:31 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C76B1573B
        for <linux-rdma@vger.kernel.org>; Tue,  3 Jan 2023 15:04:27 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303JnEJ2020013
        for <linux-rdma@vger.kernel.org>; Tue, 3 Jan 2023 23:04:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : from : subject : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=0qc73i0znAJHhmyMHx/OE5ZH6DggY2EWtQOrn1Llhus=;
 b=xqtI7Ah8VB2jO5ct1XydQ96khOywbk9y0lBUi6WRYzvljCHnFeMmPka7gsT3iTtDbPrv
 qqyGsNlTeHl19nDX3JIEQAEx461jNiqUo2fJjpRZvOwL4B/mx/2RpsCmvtzMkmmj/BL1
 M1CTfyCUsPJmGjJGq1lHwweuPWRPSDK+R9J39AOWok5bhRHc98yug2bQ9PPPHbC9C617
 +5MbFhqR5nCCtKNIytqiYG1ChA7TrXpgdwGRXj77a6CXNIeknHodIBQstU2+SEcKuS4A
 40bm74Te+sMR9NjDx/SQ6EaHyzvzOjoACNoHPquxb+lQB2sds8Hu8P2otHm4ymBt8k+H xA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbp0wbjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Tue, 03 Jan 2023 23:04:26 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 303MSusL003949
        for <linux-rdma@vger.kernel.org>; Tue, 3 Jan 2023 23:04:26 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mvunc4x9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-rdma@vger.kernel.org>; Tue, 03 Jan 2023 23:04:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqdkV6KzfLLoFPwfnEX4eJih7f+oVH8ZZ3QRt0PPdLDN4i0td5HYgPrsvMpONHNerv6XZ5GVvr5G+lhfB6pgBcPQramgF1ntVNNWw0ylOxv6/vpSxzje4KdCrbp+2NbMr1KPBb0Zhifu84xzsL1pboD+U0M+ImPNmH0iv4H5T9i8ltde3ix+n9KK+aBm+XWlmP+EDdY89DcBdD1MxxV5/C6O3eM6JPtxM9KHS8wyIvkwZd4RX5NHgzi5WToGi8hlgB7ByTKO8Tt2tbSiU5zqIu7TBj6MwUTSbjjcIV5+6DTNQF9gw+T91GBDM0FLkdyhUGtqwLjcCLznFhOPN/5Ejg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qc73i0znAJHhmyMHx/OE5ZH6DggY2EWtQOrn1Llhus=;
 b=L9IzMSUbRU1B8iArSHHpnn5YRFuhVgp6fDVlC0t8Ck9O72fZ/nrj+ajp/PLl9MsdeBwgoReW+IGc8Sm6ZO5NR3De9kucw01/6UdtUw+t6Y/MNO9ylMXYrNlWjbXaEunjqheXRSaSTHjXaW4B6xRutB5Eh+S+0JLLxx9g1a1h3fJDrtDem9JIRPYG+LsXUxAg/OrzoS5ljmNxD+pSnTm+1X7Pnw+Yfq1SnJR1ivrmAcVpWLkP2Ip9OnOUO3HatGcAaKGQPT52vpaNAnKk/ZvLplNOdsRAAldIxMd7F2jrG803IJmYdJACMI4N97ynipvO/dyxJiy+3/kouczHsl3ATQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qc73i0znAJHhmyMHx/OE5ZH6DggY2EWtQOrn1Llhus=;
 b=paiKt9rvc4qA7YSkW65556AnV6K+nmMk00uV90BuI7CNWniSk2oNeRKcfoVSrEL1KrnbabJmGueB2ifBh9+gEfWCsknUzZWPCbe2WdgCxLt3iv8wLq/SK7yPnlJhey1NOVAZgAHEuxLrKUTRkpN6StKdU/ezqW1qLWqn1QkZTBQ=
Received: from CO6PR10MB5634.namprd10.prod.outlook.com (2603:10b6:303:149::17)
 by DS7PR10MB4925.namprd10.prod.outlook.com (2603:10b6:5:297::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 23:04:24 +0000
Received: from CO6PR10MB5634.namprd10.prod.outlook.com
 ([fe80::af6d:aa0c:3086:ad13]) by CO6PR10MB5634.namprd10.prod.outlook.com
 ([fe80::af6d:aa0c:3086:ad13%9]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 23:04:24 +0000
Message-ID: <4c29b8d8-c4c8-a7ae-e1f9-ddce3b55d961@oracle.com>
Date:   Tue, 3 Jan 2023 18:04:21 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Content-Language: en-US
To:     linux-rdma@vger.kernel.org
From:   Mark Haywood <mark.haywood@oracle.com>
Subject: buildlib/pandoc-prebuilt
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:a03:254::34) To CO6PR10MB5634.namprd10.prod.outlook.com
 (2603:10b6:303:149::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5634:EE_|DS7PR10MB4925:EE_
X-MS-Office365-Filtering-Correlation-Id: 10a3cca6-2840-43e8-d120-08daeddedb14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KhJeGkSinEWQH+p4H2+oFTwjaQDyfS+dd/qvNdnB4fK76TrItQokOtKeikgDjyOwRnMfDOflUKgfUwkvHdbTQaPSZY5wxOPWQ4cLEm2HjxZt3bY2Itsi6sdH0vJ7Hs42ATr1rtZ2f6vHw1CRCKnz0U554G+wuMm1e9b/6roJfw0Bbo4RTp94zGyhrBeo1NoRiekrszt2zt/+2wjtNT3k3r54we4Cl7Gyx7cH9k9EgnXKr/Z6UzmZRESNbAzms6nZklj7wGCZb9iwB+12dPhbHue6s+cnx3bXUxS9YhhNa6+Jr6qLANdhIbxzI/U9zi67XrzeEtBixomMbTBB6rCrm0c0pCManb5/1S6k6AljjVOTdTyz1veE+bi//qS0rtF+7+3rQ307Vcr2fj7ZwzRjhx7LPjC3giI/uA10SGkVSJxMA8m4WJZ44nfBrQhsT8ReGYmLrxfz6BTTlq/SVF9ygzKcCuhwrreLr6S0p36ehvrDW/APY5OfOD4Iy84MzOlHDtXGdJNn1WTadz+FaOVgBN5aqfxjsk8YmGKxtMPdiyO3MUxaqIXeDVmOMIWwKux6fjm3naB/azM9o11r51IrAjjNxCZ86MDdMXj9AFP/pIOa/ZFXqokGvhV1Z2tJY88iYon3KSS2/gzqzQJ0h+lIAmvGRYYfSgXoUI/3NvELNh1hOaH44/EY+f7Qnn23GnWAG9n5qnseebEi4fCmpNtvRecHKu3BO10/P5M435FmAoBSMp+UBsHPBSdR0cXv8I9Nl4LKrKz6jPt4YgwAyCYeUO4rw9/NdLtGHxIxkRoPYNw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5634.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(39860400002)(136003)(366004)(376002)(451199015)(8676002)(5660300002)(66476007)(6666004)(66556008)(8936002)(558084003)(66946007)(316002)(41300700001)(6916009)(6486002)(2906002)(478600001)(966005)(6506007)(38100700002)(6512007)(2616005)(186003)(31686004)(36756003)(3480700007)(44832011)(31696002)(83380400001)(86362001)(22166009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTlIemtGK3krQmJFS1RDemExSnBuc0p2d3BRQlFKT1BXVmFUV0FnNFdxTDV1?=
 =?utf-8?B?RzJ1c0RiVkNES0hrN0pFZ2N4T1F4Rm9iS01GbnVTYXRtYzR4Rnd2WG95eURW?=
 =?utf-8?B?MjZZNFlQVjVFTURaL0I3NmQ3VHRqQ05qTlBMVjRZcEQzaXFiblk1a29GbHBi?=
 =?utf-8?B?cm9UNEErbEtQWEQyY1lORThsM3VUODg5SGI2SzhzaDN3UHJDbTVXQVQybTYz?=
 =?utf-8?B?NWF0WUhsaTA0TmJsM0xWamZjTWhPUzVTaTNCcm52MlBpUkdaK0tDekk0MVBC?=
 =?utf-8?B?OFNCbkdjdGYwZGNEdVcrU3NlVENWY2k5ZzFLOXgwVTBZQ1VwNHJ3THk5bUZw?=
 =?utf-8?B?SVNlSHdVWjBuL1VXS2hRS212NmpFVVBSL0pVaThhZ0FoM3JDd0pvVCtucUR5?=
 =?utf-8?B?VG8xamZJd0RQeDZZVk1oek1FekhlQWFhNTNScEdyOWcrVlJZYkVPNzc5YTVQ?=
 =?utf-8?B?Ny9MaEdqRDVVZXk2aHVYSTJBRE9YNFphMDltZ3dyYWFJZlhqSFIrZnpmajQr?=
 =?utf-8?B?cFBlbC84djI0eDYxRHZMQzBwNjNRaGMvcWFKbTdsdHMwbDdRc2dkNmo5Qmxk?=
 =?utf-8?B?WlFrWVRndkQxLzNiZWx4WnltWnhYZlJja3E0T3o1d2lqVElVMVhaUko1dDhU?=
 =?utf-8?B?Qk1VTXpGSktkcm9JaUxQelJFOGQwcWJQZkxtZG9tN3U3VWhBeUhFQ01JTVp4?=
 =?utf-8?B?VlJnV0hpZnlxa0RUSTdoNktETXd0ZElCU0oyVWlEUlowdkNickNLeUV0TVhP?=
 =?utf-8?B?TC9KUWxwaGhWMi8vdlN0WlQ0VmpCRmVudUJmTWhUdm9YNGVxVXVNT3BNTDlG?=
 =?utf-8?B?dlNmU3ZVK2R0TG83OC9PbGhTU21IVmZqbmZodDNUUHZyMTNLU0lFS3JOcWZB?=
 =?utf-8?B?RmpjN0Q0UUhxdnd0eVFMWGl4S0xRbGxTSWhFc0l1Y2ExRm1hYTh1MmtGSnc3?=
 =?utf-8?B?Rk5KZWtzbHpyelgrKzBGZTdEZHpqS2w3TkJNWnVWRHFzVXhzdCtwRTBiNzQy?=
 =?utf-8?B?bjkvVm9CQWFFZ3IvQ3lpckxjUUFFbkxBOTRvSU82TzBOMUttdzNueHhrU3U3?=
 =?utf-8?B?eTIrdUZKQXoxZ1R6a0RWQi95TXlrMDAzZGZyYTR1NDdZYk5YMnhzaVBUQ3NI?=
 =?utf-8?B?M0MwVC95SWhjNWJ0MURWdFhGM055ZXhXVjh3dmQ5QytWdWYxT0orbGdlSWZB?=
 =?utf-8?B?NmZsci8zeGppZU9heXJLdCtSbGlNV2RjUktVUjByM2l3dHB5Z3pWbjhRRzYz?=
 =?utf-8?B?VGxaMHVaK2JjSnpyYmxpKzk0UjIrc2xienZmamI1ZmJDUTdJck9LaDBESGlO?=
 =?utf-8?B?VjQ0TWFORmorWXdXbE9RbEw2OFMzcU5NK1FILzR4UHI2Q0dnMmpSeFRDWEdz?=
 =?utf-8?B?TkhHRG84NFNsbEgwNjBlZXRadTNhZElMWEliWnFybnk3MDhqWGVUUEVQNEhm?=
 =?utf-8?B?dnZnM2lxbGZPQlBpL1FzeTlHYjlsT3lYMWo5T002b2dseU1veWRNZlRSVnNJ?=
 =?utf-8?B?TkhjbjVDeHo4dlVGbVlsbHRCcVB6NUFlb0VPL0Z1V1BYYVo3RmVSck1tSUkr?=
 =?utf-8?B?ZDIyeFlEb1BWbnZGc2U2WWl4eWZQWk5iZ0NvYStRVWh3Z0dwWm40VWowcHZ1?=
 =?utf-8?B?Uyt2YVdIM1VWazdJOGRCWGFRSnREcVdyOFJoWDloVys3SzBuYjRDY0VDWG9t?=
 =?utf-8?B?R1oxTjRnQ09EcjN4Ny9MNnlpRTM2d0k4UzhZcHVwejhhUlh3UU0vS0EwcWpx?=
 =?utf-8?B?QVJiN0hSZTYrU20zRXBQNEJDR1pYd2FEWFB3eXFESmt4T0x0NTBJV3loaDFu?=
 =?utf-8?B?QXBKMDl5cVZyNnVyUmUyMlpMMmoxODVnZkdKWXdmcVBnYVlPOFByeWxYcURo?=
 =?utf-8?B?dHVIRVdyVGxWVW82MENoTDlxdE5CTGZtRlNsUmNEaFRKM29laXdoNmd0cnFM?=
 =?utf-8?B?RWtpcVNZR3ZOTGVyUytsM2ZPV1ZkNTd3QWNDL1FSSUJDZWlxNjJoL0Z4WG1M?=
 =?utf-8?B?ZGdkbmYrTFhLT2x2RmF3TEdteEpXb3RldHJUUzR0UFFYaTd4dy9WaWRYN3hx?=
 =?utf-8?B?eUFZZ2R4WUg2OXdlU1VjQ2NNZjZDTURvVGhVUndVMW9LNFkxamg0aVJvRS9J?=
 =?utf-8?B?L09DYzhheFlHTEFScUNzaFl0NVZEZElENHZuR0JPNkVVbHlLclIwTEhRUjZY?=
 =?utf-8?Q?97wAqRmoMxW5P0GYNQ3CJRQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ugC4S144YOfptMa5HLs4ic+ZfzloXstlZ78eMrQyfrbggfmQFoQcPY3GoSGjVlCBwRdnvMr7xpZh8j1jEyupksEYguCJg3Jnb1Zfe3fKSRlbRr/vCy6efZZ1//TwX+SL5zMMwfQ3uqVGQBiJa3NyZUd7AqhqCQWzwGkx3Kp+KbbJyGg4qKgW6kEmkdB8WyWxNRMtR9Qe5ogDdRC2rILLDizoYBLooqwzfbuICQnRPmfv5ypN9WyvZdwc6MZRnae8iFykLZ89WutExxZ3sXJQhCOXDi371aQXNAO9MgZi9Fo+DYUca3qJYuzodmtNogKbtXaiBu7dBwnRY9WRXsk7KbfMqt5AQpJwvUvRQu6D86fFRVu+uH+Sun14iKgz7PpRhVxRlG1Yhrcxgn4ebr03UZcU9LX4VOPmskAsMr7F5duxQliSoWzgYcDb58kOJ/kcXulMzCKD9ikPDMSXxUhoSuJATsMvKpfIsnkBWIN0hPLqITDmgC5QhlwzsUK+dcX+4FRqnJqfyih2IASZ215COfKFjzAW+ok4rVI/EZLxyigRVA64rj2zCRBQCiWnlCjwwKXEYAoCzdPh52Ry8SKJsu0NN3GzlUC9tKBdF2t5nHGI3fVYzohVhH5w4xw1ZBFGSvrzxvzHLRRa4R9n+YJ+qkI2TQGQKInUndXilzxNEuOmn0lnNMXOkoIvNz8eSHZYH38iyMdVLCiwre9QkUOA2sf3j39fsAKjsQGqQWBeRQG+/PweY5POSpl4XR9DFpavJZofWPLUZhKY8koVL0OguQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a3cca6-2840-43e8-d120-08daeddedb14
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5634.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 23:04:24.2787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rn8dXCdxjebcEDzDElVQkQb1zNU4h2vwvDS2KRIO8Z+OoeuRj8VCCY3SwtoD1P+e3L/E5BI7Xvf4kxLoMEKGXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4925
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_07,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=759 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301030194
X-Proofpoint-GUID: Tyg-DftBjCSqEViz_NZnOUUsU6OF6z7s
X-Proofpoint-ORIG-GUID: Tyg-DftBjCSqEViz_NZnOUUsU6OF6z7s
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,TVD_SPACE_RATIO autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I just extracted 
https://github.com/linux-rdma/rdma-core/releases/download/v44.0/rdma-core-44.0.tar.gz 
and noticed that buildlib/pandoc-prebuilt does not exist in v44.0. Is 
that intentional?

Thanks.
Mark

