Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCF765D7D9
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jan 2023 17:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjADQGW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Jan 2023 11:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239732AbjADQGB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Jan 2023 11:06:01 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEB95FF9
        for <linux-rdma@vger.kernel.org>; Wed,  4 Jan 2023 08:06:00 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 304FOXYi008700;
        Wed, 4 Jan 2023 16:06:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=FVUMKnP1KnVumJes5PonL4Awca9t2SOEjfGfb6qEAxI=;
 b=zuQG05jSID0e1DW0fpzI+nXcUEvr61ZGYKKgwJhFYZTTBW2nY7fL0DafgRgwvPZlo3Hc
 YYsiTlMZDQrwqwV8RPiqvAie8aylcQi/SCyZ7f+8bTNm6VX3g7XOp6SLsz9yQc6Zfi6Y
 2xKdNkS2rk19lYrXracFynkkadXWwC2d+b3W7Lji6wyXn/t+xre8U2aA3ZZEokg4GCJ5
 Fvt945IcVHzWgEVcxbwx5cBpA3R4HCMpU6TVWIj7vMu/+5TolN7SUpfvKdqhMIhNgAfy
 +NDyjkdas4IYvXMEkOinNPm9PDpJDsdGuGVh2J27cEBByE7K3CD1LYNzg4n2d57zIZqr HA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbp0xu9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Jan 2023 16:05:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 304FXVXi023046;
        Wed, 4 Jan 2023 16:05:58 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mwc719gav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Jan 2023 16:05:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2gLK4pvejyclw7P0OTmoBA7fklN8JrYaZ4zmGhD6zRPJaB3CAWLl7s/BjezdmDC6O3rmR2uyn6YQp2baYnx8GqAGgWuocDA95DR3lfzE8xajEFM1asFuNfXXbjgdWyC0jCgK5E2Z/rklFkDBbgb/NRgQla0ap2elXFedW5kngQD6OePw0KXcDFG2+AutXO4ixjYWuqwCPwiMO3p2qB/IUtUnas6vX5pPpRHll3eUP5oQQO5Npa16HaFnHjTyDoQZnE76ISOtIuV7empK0274bv2w403Ik/Q+0lGau/AEf8sMMmvaNUe5jOYsyRTKtOfYFcYRi6th1jCOFeK8rfXoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVUMKnP1KnVumJes5PonL4Awca9t2SOEjfGfb6qEAxI=;
 b=I8uAmtH76Ik7yUFCE6yvdyRuQJjBopySp9BjXP4D1UjF4u1gIB5dR0BW4P3PO9sA33LkYbbEUolOfmcx5F5XMBw228FEGc8dAZeUT7BtSzsVBx6+j2nwF8L/2qy9MY+XTooHYG/vcyhCGEoB8QlNCsOMYN+2rcgUaveqYS+hvDjLYAyj2jzej6SaAD4dtFuXKVNylendn+2leE0BHrviV001/yh9Aox167uVCT2WZR1mK2EFiPudjUMLCkXVTrOLOxlmboVwWCpp34Q7uugiNOwpNy36CV+wsxJstQeI+l9tVVZfCbktXQRIs1Uz64r9fA9qcNtQ9G0SF7ueMmnAPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVUMKnP1KnVumJes5PonL4Awca9t2SOEjfGfb6qEAxI=;
 b=gJ32wBerbdve1DH0iWEaCiQ5e9G6GYObtS9asKlF4DUePA1Cq/ee5376Do9JBPlOAT4yR0EMB9NFMKayZJOANMw06k7FDppPbBtcR4Q2W68tlDdgf+5w0clknTio+WTlmcucRFkIjj51IXzdXITaB1tsrts0qHgo4eRLBOiMve0=
Received: from CO6PR10MB5634.namprd10.prod.outlook.com (2603:10b6:303:149::17)
 by CH3PR10MB7118.namprd10.prod.outlook.com (2603:10b6:610:12b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 16:05:57 +0000
Received: from CO6PR10MB5634.namprd10.prod.outlook.com
 ([fe80::af6d:aa0c:3086:ad13]) by CO6PR10MB5634.namprd10.prod.outlook.com
 ([fe80::af6d:aa0c:3086:ad13%9]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 16:05:56 +0000
Message-ID: <612e156e-d8c7-ee17-430d-9d6d85427a3f@oracle.com>
Date:   Wed, 4 Jan 2023 11:05:53 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: buildlib/pandoc-prebuilt
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org
References: <4c29b8d8-c4c8-a7ae-e1f9-ddce3b55d961@oracle.com>
 <Y7TF8EK/PXiwKRwU@ziepe.ca>
From:   Mark Haywood <mark.haywood@oracle.com>
In-Reply-To: <Y7TF8EK/PXiwKRwU@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0088.namprd13.prod.outlook.com
 (2603:10b6:806:23::33) To CO6PR10MB5634.namprd10.prod.outlook.com
 (2603:10b6:303:149::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5634:EE_|CH3PR10MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: 04cc4be5-5a8f-4943-24ed-08daee6d9043
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CLn04g7xlecmIC5RHj0U9IFc0X/j8Ea6Epm7HGwjMswH7v1fj3QcrCrbreDTNgjynuKpFCZRiHz0lFJQazGPyUfTf42k9EoHC0fUgD/hoi55EBgP8x7U2TkWN/NLyBsz4T8FIgvKxAkEt0SYd0uyYz0bFHYpA+y4lPLwnF20g9khb7/jstDBDLP1X6p3NNO0/b5y4qWhFHH2IFw1l8IRZfwISrQYCSFL4LTUFxj5WVOwxzt3H/oXC9U8qbQfz+nWafs4bQ3d6MPKe1/XDQUG24a+JHs/4tmK9K3WjpLHoXcL01qAhur2fKVobCE/NFqpCUg3Jh8nsp0Y3Meug0L/P5aUbAaYtu1zI7hb8xNKO9XeazO45HqCSRInx/XhGUXbSYI1ohli2kFK9XI1IbI7Nb1p3qioSAfxRyw3cOBQ34/0JuGUkrzJlW1sZlwPFfELLFaOH9Yo41QGUSB4dVw20iWqI/cb8vTkSqDTLRO4Ft9M5XN9nblhTJJUTnAiMJL16GYCFxhDIgDtUnFP4mmXXm3BacKblZ8opL4Fb5jMpBN/uv6OmpMQPCS3T1MuDYiqvQJM6tz56vDM85BAPr3vD18aXzB5N5p8uCMk11Yn4o9/6eW1Qb2AAJo1onc6nQbrio6dHw3KdNwNrZ1xNx8IjDYmiPmjMerf4eCbEtL6IUDTpRv2gYQI5BJ/nkySidPhsZAm33jpmtf4sI//QqXatPLCkib25ANc0CkcjV2FD6zTWuF38B1I8Pmzpa1kGY1E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5634.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199015)(41300700001)(316002)(6916009)(8676002)(66476007)(66556008)(2616005)(4326008)(66946007)(86362001)(31696002)(38100700002)(5660300002)(83380400001)(44832011)(36756003)(8936002)(3480700007)(478600001)(966005)(6486002)(2906002)(53546011)(6666004)(6512007)(31686004)(186003)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yk9CTVRGakVpVlhUSGVPNndlSUlJYUd2NTlvZDkyYWtZMGlaREpldmtGZ1ht?=
 =?utf-8?B?NlU2emdUaU5MdGdEVjhaZmpodHVYeFNZS1pPL20waTFCQkRubVk5YWI2bVUy?=
 =?utf-8?B?Mjh3UE1yMjQrS1RpR29zaFQ4OWNyZHdnTU1kU25pZkpJRW1pc2MxVHRGZG5s?=
 =?utf-8?B?VzVKRXUxaExlQklzKy9xLzBYVk1MQXJPKzhUUzVlZ3YwZk5ONGNOSUdTVmlM?=
 =?utf-8?B?ZUNPamI4cjczMnJ4OXAxbVJ2STFBVmxCNldSSERreU52MlpjRDVmd2l4MEQz?=
 =?utf-8?B?dHBqbkFBL01Gbk1tOXU4eXltSTYrcG85bWY5NlFqZ3FVMzRsVElTei9Ndng2?=
 =?utf-8?B?WThOWE9nUDFCdEluOWJhSkQ3cjFlUVViQ0MzQXp0eVZ1MWhMb2JlQUpURkZL?=
 =?utf-8?B?TlBYY3lmS2g0ZnVpZ2VTQ1NCSno3OHRPb0RudUo3K01VQStVTSsyYU9zL3dU?=
 =?utf-8?B?clVBSEZWVW5nMFIyZHM1UmRzVy9QRkxWdjhpRk43L1RjNmQwNnZmekk2WWh0?=
 =?utf-8?B?cXMwWmFJTWxCNE1VVWdZM1V5K3BDNUtTK1k1blcva3pOR2wxWi95RnluOVNo?=
 =?utf-8?B?MmM0SDlhWTBKNUZyNSsrZEFYMG55RW90amk1TEUxcE5KdE5OcUtBdzI2M1NQ?=
 =?utf-8?B?RHM2eXhRK2JoR3RvWXlrREtHbW14WEI0ekVJTDBYTWU2QUd2VEh5WUxJTVRm?=
 =?utf-8?B?SUZpU1dYb0xBUXNuTkx1TzRFcDRNczNEQXdqb2RxSmxnUXhyWHdiRk5LRkQ0?=
 =?utf-8?B?WC84RjlMRjd0WEl3Nzdxbi9SM3NyVEM5eWxiTDBCUjFYd3lnNm12clN0TTlj?=
 =?utf-8?B?clEyNCszaTZKc0cvREloRWIyKzJEUXljOVRwQWc5RXVmdHMyZWFUaWt6cjFp?=
 =?utf-8?B?dWw5dlZZSTJhTklnRE02NU9MNUVHcTVRYzlmcVE5QkxHakx4eXJBc1B0TmFT?=
 =?utf-8?B?MEtYbG5IdkdFN3NFd0RMRTV6SkcxMVozTUQvSEV2cGlxc1N6UFo3NlV2VzlF?=
 =?utf-8?B?djMzcjBJMVI2anU4ODd6QzB6N0gzVkk4RURSZzZaRjlJZlRRczEyN0lRWERL?=
 =?utf-8?B?UjVhNGV6Um5VSGl3OTlRZU8raGlKR1VPdjRoenZJWWhwQ0lwY05KcnVPQUhM?=
 =?utf-8?B?WE9MMWlmdzZ3QjVDSm5Bc0Y0S2Nxck1kSjNEKy8vbUd0bG5CTndpRmF6YlJ3?=
 =?utf-8?B?QzlwVmtMRnpjTXZ2UjJmRUtjalo3M2psT2x6VEpjdWZybE1LN21RcTNaZDN2?=
 =?utf-8?B?Skd0QXN0RW45ZHloTk4rd01VcGJVdnlFcmRyeStDMDdQTlZnbXlDYmZBUVk2?=
 =?utf-8?B?bzBLOUlrb21Nc0NMWHpnOWtVaDBLUUFrbFdTdTh5bjRYRitnZytFaGtBbjB3?=
 =?utf-8?B?NUtwTmRQSFVtbTNIK0Jia0hLcWlnYi9PZmd3TjJMRC9zRWZOblBpRnFkb2xE?=
 =?utf-8?B?RnJWWmFGbll4TCtETkFXbjlrRnVUeGlaRG5kWHA0L3AxV1VTaHgvRkUvY2gy?=
 =?utf-8?B?azdreFVXVE1JbTVFVTJZMkZxOER6anlpemZMd0YxM2I3V2ozZmthcW5FaUEv?=
 =?utf-8?B?b3h2WkR6WFd1bk53bm00Y2VTekdDS3BUS2xEeU9VZXBlKzNDR2xMWkZzS1hl?=
 =?utf-8?B?c2JncFZ5K1M2MU5lclBCbDVIY0ZTa2pzMVE1alNLbHNnbjdnd1dZZlFCWEI0?=
 =?utf-8?B?TGxCK2pNNStkTUdyZ2g0VzkrajdlODZ2OUVKVnlUN3NaWTVDalZFSTZBOFVL?=
 =?utf-8?B?ODVHb1hIWFd1OFkrMW9YSk9tRmpXbHVQQ0FNYTJMT2x4RUMxZk9SWXRtZG1v?=
 =?utf-8?B?c3dyOGltM3ZUOFhDTlJVSCtVK3czZ2FZWlEvQjhoSkJSbzVpc3Fwd2dObjVz?=
 =?utf-8?B?YzgyTy82Wkw2SjZ5K1grdFhpZEJrdjNGd2JVcy85TWJIWnBsLysrMG93Wjd1?=
 =?utf-8?B?UWVBTWFkbWRRUERWVXpOY09qQVJsd21qNmRTbGxYREtsZGRvOXFGd0VGUHJH?=
 =?utf-8?B?aHhiallSQVhVU1hsNnF6ZlUyZmIxY0l6QnN1bUlaSHdzdFhMSTBncVlDd1ZZ?=
 =?utf-8?B?WmVvb0FKR1JqWlljSVMvdE5pUWg4YzJwbUR3b1IxYlRmRXYvYmFxVndFLzk0?=
 =?utf-8?B?VHk1bUVOUVZ3R1ZtenVOcVpjRWhueitlaWNBcVBlNko2cEROV0E0Vm5nNkp0?=
 =?utf-8?Q?mN2G3oEsO5DRBTcko25peTc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: S48u6DL/e+grD17kLcVCHTw0vTbvBcT6CFWy2xAluk1drM2bRzNRgOQGO+ssuVS+hkRe+BbuU57Xf6HrlHWL4JJ6tW8S0HIaCKFZLvmHbmOKwIdbxhPd2meZz95aBRb3DFjcaHeidXt5y0amzi0Jvfh2+/REW7A+A1yxDBg7CJoUEr0fTD/fpRpv2zu4YNO+gc3EvHuRKKf5EnNo8gV0YOWe6vkFo7gCO5SmjxYhm4u+Wso7Y7hX021FmSGPiV/jlGEPLpqmCnkTD6+zmWdrOBlL8uaYU8rb+GVDf0MTR+JYac96UPLL+s/uodAsRIkNUnoff1m4Ke8bKgFDe0z4pTiVmW9sQ2NlYTGyTp4igxH28h/asyLyj70mg2tvQRtlCv/4M3ZzkOHwMi7bMQY7ao61cuGOb7CBnn32oWLX6KxC57oEhWj55daq3lfyaEJwTACdk+PefoDw7cDRLMcrITs8e04JdkTCFMApWb8qSOhl+ihnGhmCS5EWg9NwuBcP6zbifp8CtjHak0Y9f/LZacTU0/npPEMY4Je7/djahc5B0EcGCjxRjtdPwUuUAZOAsq5fr//4tOFhsa8Gn/WaasA3vQDe3YTv8me1EGT3bk9WJRtWYRhv6X/bOzJd5WI/65zZCpSVVlUbwDlr/UrhnfxiA67GNzysJfMB319X3O++lUQlVlLLRZ0EG11t7WKcuOSomoFpuDqhvgOSV/1FqU3KPCo/3dkx6NNpoXu4moaDwzqI4DXCHYrohEYo55uDDKCP/8GLspCjcXThACSp45m3v9tZ7pGtp95+C1BB3x8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04cc4be5-5a8f-4943-24ed-08daee6d9043
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5634.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 16:05:56.7699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 25BSo6/5wLraIWqXBxmI8es1pZa65SwU2ilmqhRUIZtFOz8yw87fRVO5YZlFy7l4lvE5AI9D3G+GtYyoI8LG9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7118
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_07,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301040134
X-Proofpoint-GUID: EYgDaOpWXKLkwXvQykX4TxOk8cFaWNcu
X-Proofpoint-ORIG-GUID: EYgDaOpWXKLkwXvQykX4TxOk8cFaWNcu
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 1/3/23 7:18 PM, Jason Gunthorpe wrote:
> On Tue, Jan 03, 2023 at 06:04:21PM -0500, Mark Haywood wrote:
>> I just extracted https://github.com/linux-rdma/rdma-core/releases/download/v44.0/rdma-core-44.0.tar.gz
>> and noticed that buildlib/pandoc-prebuilt does not exist in v44.0. Is that
>> intentional?
> ?
>
> It looks OK:
>
> $ wget https://github.com/linux-rdma/rdma-core/releases/download/v44.0/rdma-core-44.0.tar.gz
> $ tar -tzf rdma-core-44.0.tar.gz  | grep -i /pandoc-prebuilt/
> rdma-core-44.0/buildlib/pandoc-prebuilt/
> rdma-core-44.0/buildlib/pandoc-prebuilt/caaca7667f40fff2095c23c0f40c925f1ff3edea
> rdma-core-44.0/buildlib/pandoc-prebuilt/e2cfc53feeefa2927ad8741ae5964165b27d6aee
> rdma-core-44.0/buildlib/pandoc-prebuilt/971674ea9c99ebc02210ea2412f59a09a2432784
> rdma-core-44.0/buildlib/pandoc-prebuilt/241312b7f23c00b7c2e6311643a22e00e6eedaac
> [..]

I can't explain it. The one I pulled yesterday doesn't have them:

$ tar -tzf rdma-core-44.0.tar.gz.orig  | grep -i /pandoc-prebuilt
rdma-core-44.0/buildlib/pandoc-prebuilt.py

The one today does:

$ tar -tzf rdma-core-44.0.tar.gz  | grep -i /pandoc-prebuilt | less
rdma-core-44.0/buildlib/pandoc-prebuilt.py
rdma-core-44.0/buildlib/pandoc-prebuilt/
rdma-core-44.0/buildlib/pandoc-prebuilt/caaca7667f40fff2095c23c0f40c925f1ff3edea
rdma-core-44.0/buildlib/pandoc-prebuilt/e2cfc53feeefa2927ad8741ae5964165b27d6aee
[..]

I am sure it was user error on may part, though I don't see how. 
Regardless, it's fine now, thanks.

Mark



> Jason

