Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9A16144FB
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Nov 2022 08:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiKAHYJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Nov 2022 03:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKAHYI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Nov 2022 03:24:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB9613F9D;
        Tue,  1 Nov 2022 00:24:07 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A14pxMu014630;
        Tue, 1 Nov 2022 07:24:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=FcEz1DJkQoX/MX8bnOK58Yi/tuoi5rXvLzxbxqBptkQ=;
 b=qRHSZIcCyrrdk/ChRcTGxP/MQz071Kah70x0NKBmLaVaC9DDyCmErnVExsmXHoXdrqzR
 E4LMkx2RRCm0Y7kP7Qn7ropPESS3KjBz2hvQaOCSPUZaT0Ny8ZlQU8WSakmtFCwSO9SA
 O+Iys6r8DVaKh3l+E0J5qAde5O281V9AoDhJOUEullZtWI38UHmpi6SGl4ermFrsljUz
 EVL610H6ex5V08viCywvfZWYGy+XfAGDOep3KV7iPcuBp3TBa3umZJnjJ6dkLmXzdGEW
 3raNVa6/cedW+NUFXiKeA5KtOObWu3YMISolezTc0D6x5DcdZRhfx0qJbV5JnZwKSO9M sA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgty2ww07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 07:24:02 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A15sdcf033136;
        Tue, 1 Nov 2022 07:24:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm43vby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 07:24:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3P7IpyYXxRigE3c3ZjiYl3h42M6AJYDjkln+7GBlm8ZOXa9Hyi4uUQOBdEgwFAyv+JMuP5zPcUo3WErkawdwsG0gh54Y37it3OzlKHc1I5Xt4Dm0tBlePswcisWQqvuuCfje3gXq2dtONgZ9/InwyhKYg86vgvYPoaFnvC/56NJTMJ2qyZTmmi9tvl9nqGen3+E8k9gnCSzPeb051jqmkFJjqhZsjoF7u6rLUt+s7TqeNbh/KBrd/xUkGh7+vYdY9kWdUQ/S7WcwyTRST+c8NlvM/3hdMXbMwQmIefxgJx9k8WN2KHi9i2L/DBhsSLxGuXJGWLolTCD35QMkLWpEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcEz1DJkQoX/MX8bnOK58Yi/tuoi5rXvLzxbxqBptkQ=;
 b=U3cG4FRnQP4AAr3CriyiInARZcSQFUh6oUNYrC/M5lHXYiQVd/Uynt6Ud39CjBZqWMFaQtThYMJkM/XL/Bl4LG8avNmazxiy0mX0siHe+Sp66eHZ6A4LtsRmo5Pv1lcsH4gVq+Fj5PrRpWIVV90AdUdhHiBu0SmSz4KP0ncQ85CUJbaJBq7VIK10Jr2546Vtj5qAj/1uMC6ENJMCUV5uHZJ03zLmbtNO55NybeCZ/bYXlJbv6PDF2Dh4Vv9JZUn8Ig009YMnD61vYk6kUGFlzp0B1pqDAnbTKkZXcvVUB0FXQohwzsCcTXQIiv8acWnI2YPyT6a0U8w58zmSRaUECw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcEz1DJkQoX/MX8bnOK58Yi/tuoi5rXvLzxbxqBptkQ=;
 b=vUUAkU/ErCOZbUJS2HtZHyLTHRFwqal2bgYfKc3q4hPxtCMfPwtwyW9sJdlncebAC4UUEIpCpEdc+d/c+/ws3ARd7yl4hctE4/fuvIEFY6Hd5l4cGYloLgM5yEzru9cA/hVdrNTnbJ/GWfNdieRf8MuHuSFzT8owReo4wY2sNQk=
Received: from BYAPR10MB3575.namprd10.prod.outlook.com (2603:10b6:a03:11f::10)
 by SJ0PR10MB4749.namprd10.prod.outlook.com (2603:10b6:a03:2da::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Tue, 1 Nov
 2022 07:23:58 +0000
Received: from BYAPR10MB3575.namprd10.prod.outlook.com
 ([fe80::34c3:574c:1f2e:3854]) by BYAPR10MB3575.namprd10.prod.outlook.com
 ([fe80::34c3:574c:1f2e:3854%4]) with mapi id 15.20.5769.019; Tue, 1 Nov 2022
 07:23:58 +0000
Message-ID: <3ba046cf-7cb1-bb0b-7310-360ff7cfcde6@oracle.com>
Date:   Tue, 1 Nov 2022 00:23:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/1] net/mlx5: update debug log level for remote access
 error syndromes
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, manjunath.b.patil@oracle.com,
        rama.nichanamatlu@oracle.com
References: <1666689721-30424-1-git-send-email-aru.kolappan@oracle.com>
 <Y1jKHcBdcUnluIdU@unreal>
From:   Aru <aru.kolappan@oracle.com>
In-Reply-To: <Y1jKHcBdcUnluIdU@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0030.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::43) To BYAPR10MB3575.namprd10.prod.outlook.com
 (2603:10b6:a03:11f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3575:EE_|SJ0PR10MB4749:EE_
X-MS-Office365-Filtering-Correlation-Id: f76ee9eb-398c-4042-1f31-08dabbda0ad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fS9vrt6C79A35euntU/O9oWqCmJsTltjbj854frnQc/WD5sEvXxOnW4c0Gm6mU0XQIgpXIAPIFCgB3S4cfO91fDo36+Pvz1/kEJBbokV1sFw2f2OyqubwWN1vXP0gyk+0UamsVuD4FUbM+j1EMk6w7jga0zjnjHPK9Ger4EtAKR9KyMPP4BWSObCo8J4vD3LC0yyT3Oxsy+yJ267jAPl/Wl9g0HR8cAonRhN/XbcKCgbhrG2Yb0dJg/ONOuuxumUetrP5uiuyqRohZJsSyeswnZJdaMiuHBoVXQkH7r/l5BbVW+ndYTMkx/B4Y0ra4OOAn29d6zZrIWVfRDX/mCL0fQl6nzczl/EPIqcGLDQN4ECtSGcUB/M6zFtNjPZ5nsO0RkiBfR6rUzUEbD7QUGJ1YD3uRxMaBfhA36F0QX8Zdz+W+llsHZqWjCfpCHckJPx1g7hy0J7i4T9uuKwg8XSURkuDMh0Dl7g0nNOlexhMrAAgbZ3p/YVN7Zvfph/xTHpsrjyQ29yaXrOFCRjykIDS1nD4zTkPINnbAMd4JElKGki5flMaD4aPbRLH4iwGMyFr6Etppcja4JPxW8uLp6NXJCNKfVTv0sbd2BMfQmvwgsncBkraEzUVz6BT6TOXpRrg4yflPgRCr20QJZ3l6KNuy8Z7GHUBVVR72u/8Kpe1KalyRDEGQd5+Y6qAxxmfXEnPjR47yx5VNr7WKU1vh3Bv6D/PfhKlC/owKa01wy3si8SOePZmoRa5/uI6j5uAJyqnCfyo0j6w8mNoD4TYLAja4wabwnaMquXMmTEMLqXXWw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3575.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(346002)(136003)(376002)(39860400002)(451199015)(83380400001)(31686004)(107886003)(15650500001)(2906002)(6486002)(86362001)(36756003)(31696002)(38100700002)(4326008)(26005)(53546011)(6512007)(186003)(66946007)(2616005)(8676002)(66556008)(8936002)(478600001)(316002)(41300700001)(6506007)(66476007)(5660300002)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjBuTDNuUmhBeTdsNlJpMWI3VkxiQ2E5eEk2eHYvTHlmbmloUjJSOU5kK1dX?=
 =?utf-8?B?MytoenIrODdYUkMwaXlUeFBCUzJldnpCRWpvQnppV3VJK2xlZFNVcDlMaWl0?=
 =?utf-8?B?Q2gvUWg5ZHdkVG1xaXd5VWo2R3k3Z1FRVXYyTWxCa3QrakZNaUtYOGRQSFdj?=
 =?utf-8?B?c0l4cmNxYnQwL2ZMWTB3V1IwOFVabzFBYVRxRWJRcmNNY25WYk96ZGs4d2lU?=
 =?utf-8?B?MmdLZWVWSWM0RnpqdzhKM0JOa1FobW1oUEpRb0RHZDZMT1NEQ0gyM00xeVE5?=
 =?utf-8?B?M25HdDZmRWdiTjhyRXUwTit1eXEyY29ZUWJCQVk3clgrSC85Q0RqWERPeHFY?=
 =?utf-8?B?b3dRV05wRFU3dG4xd3RXdEhObnJpYlZNb1pCWFpKdSs3ck5jRnFBdGVLTTFi?=
 =?utf-8?B?UklkVDFHSlFsc3V3Lyt6OElhUTlkSWUyQThKcURRZWM5eVJpQ0ZINHR0ZEZ4?=
 =?utf-8?B?aHB5RERmRVk5cDhvSWppNFd6UG1LbVpnMzh5OW1vcldsNi9pRVRnaVEzYXJi?=
 =?utf-8?B?aTVnUWxIV3NaR09YeDAwVlNyMFNJRU94bWl2R2FaNDdtdkJHVHVKTXFtMnAz?=
 =?utf-8?B?bXpIbGVZWWR1UEZ1VlByQ1VZVEloeEtoZ295Y2lVemhjZXVxM25RbXN2SzZZ?=
 =?utf-8?B?STV1cFhNSGdWQitEZWVxVFVYQzZzTk9hOUtCaWNubGMrc3Z0aWpZamI5a1pP?=
 =?utf-8?B?MUJ3Mno2aFdJbVhSZjExemhucGtJbStCQjJXRnpkUTNZUDRwZlErZjZRZzlS?=
 =?utf-8?B?cnIwZWJGdk90YWQ3RmYxZ2FabG1WZmk4ZzBlVDNVaHlYZHVBTXBMNDF0dzJj?=
 =?utf-8?B?TjlZMmFoWXFkWitTM1JQeXF1TEs1dS85LzBsNWdUa2E3dG03Yk9mS3VkMWln?=
 =?utf-8?B?Nzc2OThFdnM5MzNHNjZaYVlCR1UySmROM3RyNC9EWTkvVmVreEttclhud2Nt?=
 =?utf-8?B?UTFJZzlNOHA1OUdnNVJBN29jbnkzN2M5SDhqNnA3L1NPZVlqSXBhSHhVaFI0?=
 =?utf-8?B?aFNVUFNacFlYdU9ZTWRBVll2T1hDVjNjZFl6T1RiMU5Qbjd0NTRjNXp5Vy9l?=
 =?utf-8?B?d0dJZk1mV0UvV29HSGRneVBPdUVrNVVGaVppaFYrVDFKdlVFbExua29sMVdF?=
 =?utf-8?B?MVRHQ0tpUC9EcG8rQ09Sa2I3bjZUNnNrc2dMY2FkSEpDUER6WHRYYkl2WStp?=
 =?utf-8?B?a0w1aWlSVXpRSXVLMk96b05vWTNoNEJlSmdtZXQ1SHl3NGRFdXpwYm11YVRk?=
 =?utf-8?B?cUJWQWxkQmlaaVJ3TytZK1RKUzFyc1V0V3FLUCsrYmx1aVRPNTV5dlFmKzdi?=
 =?utf-8?B?cGU0blRsTFpxZTVFMlFnM3hsUWpZNmdlc0s4Y3pXOWhsdDZtTkJjN3kweHhF?=
 =?utf-8?B?MTZjaTZ3ZmlucUxDNW1RQ2hzWFlTSStpNzVGbEM3aStzYVJyU29CYXlvVjlN?=
 =?utf-8?B?TElYZitEWEgzbWtaa2taMkhiK1dZdEI5U0RaTWF6Y3ZiOEhMaWd1ekZyNit1?=
 =?utf-8?B?QUlodTRiU3ordEIyUi9rSkE0N1dBTVRZOU5RNE8yUW5qNlg1enBvN21RNHMz?=
 =?utf-8?B?bWROaXF2MW5MZjdMajNDcHFXMExzblJXeHNtY1FMNUFZekJQOXV4S0RkaEJY?=
 =?utf-8?B?dFp5RFJYSFBXUllQODZ6eEdnSnFjY2NtOFFsZFhYOFNyTE5IVnZSUFdVS2Va?=
 =?utf-8?B?RXpLZklkSzVIZjdHUGd0RnhDdDBQckxSZmx2Z3BUVWNNbDhYYkFtQ1RndWhr?=
 =?utf-8?B?R0xRemFjSG9wQXJxbElQTUlQMlptREtjT0ZzSmx2Q1ZweHN1bklxcERBK1Vx?=
 =?utf-8?B?cVFPUnkwTEw4aGsrVTNMTnkyRk4xWmZaRUxVcXRpOSsvZXFrSXFXNHdET3Nu?=
 =?utf-8?B?YjRaYzBYRGNDTmdhd2p2U2VHNk1vU0h2SE44SitOQjk1R01EV2RxU2NOR3Ft?=
 =?utf-8?B?MUxrZXlOTEJTYWpsVXEyN21VSFhOcngwZ2dqMVA0bVJTazJ5aTlGM0dYY1Y2?=
 =?utf-8?B?bnp0UUQ5N3VnSG1uZjBHMkVxQy9XZXJWeVoxditETDVkcGdTTUZ5V081VUJC?=
 =?utf-8?B?QnZISHgxM01TQXlxeE10NWVKS2owZENjSG14ZFFHUFZOVENnWlVRN2VyTk9l?=
 =?utf-8?Q?svoipeZ3V1kbi5i7fqVXg0j9h?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f76ee9eb-398c-4042-1f31-08dabbda0ad4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3575.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 07:23:58.6378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wD/S2+KkfKUpCtvx7XEL0f0YSr6710N7Ty8x+deKi7NurGx1pQoED96P+Rc/T70B2d1Xu0EwQ+uqgsCnXifXeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4749
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_03,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211010056
X-Proofpoint-ORIG-GUID: dJbzzjgU5CGVyldJdWBVR_9Ftzh6mbkK
X-Proofpoint-GUID: dJbzzjgU5CGVyldJdWBVR_9Ftzh6mbkK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Leon,

On 10/25/22 10:48 PM, Leon Romanovsky wrote:
> On Tue, Oct 25, 2022 at 02:22:01AM -0700, Arumugam Kolappan wrote:
>> The mlx5 driver dumps the entire CQE buffer by default for few syndromes.
>> Some syndromes are expected due to the application behavior [ex:
>> MLX5_CQE_SYNDROME_REMOTE_ACCESS_ERR, MLX5_CQE_SYNDROME_REMOTE_OP_ERR and
>> MLX5_CQE_SYNDROME_LOCAL_PROT_ERR]. Hence, for these syndromes, the patch
>> converts the log level from KERN_WARNING to KERN_DEBUG. This enables the
>> application to get the CQE buffer dump by changing to KERN_DEBUG level
>> as and when needed.
>>
>> Suggested-by: Leon Romanovsky <leon@kernel.org>
>> Signed-off-by: Arumugam Kolappan <aru.kolappan@oracle.com>
>> ---
>>   drivers/infiniband/hw/mlx5/cq.c | 30 ++++++++++++++++++++++--------
>>   1 file changed, 22 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
>> index be189e0..d665129 100644
>> --- a/drivers/infiniband/hw/mlx5/cq.c
>> +++ b/drivers/infiniband/hw/mlx5/cq.c
>> @@ -267,10 +267,25 @@ static void handle_responder(struct ib_wc *wc, struct mlx5_cqe64 *cqe,
>>   	wc->wc_flags |= IB_WC_WITH_NETWORK_HDR_TYPE;
>>   }
>>   
>> -static void dump_cqe(struct mlx5_ib_dev *dev, struct mlx5_err_cqe *cqe)
>> +static void dump_cqe(struct mlx5_ib_dev *dev, struct mlx5_err_cqe *cqe,
>> +		     struct ib_wc *wc, int dump)
>>   {
>> -	mlx5_ib_warn(dev, "dump error cqe\n");
>> -	mlx5_dump_err_cqe(dev->mdev, cqe);
>> +	const char *level;
>> +
>> +	if (!dump)
>> +		return;
>> +
>> +	mlx5_ib_warn(dev, "WC error: %d, Message: %s\n", wc->status,
>> +		     ib_wc_status_msg(wc->status));
> Aren't you interested "to hide" this print too? Right now, it will
> be printed without relation to your "dump" variable value.

Thanks for pointing out this. Yes. This line also needs to be covered by 
debug log level.

Current existing functions ("mlx5_ib_warn(), mlx5_ib_err() ...) do not 
accept log-level as argument.

So I've added a new fn: mlx5_ib_log(..) which takes log-level as the 
first argument and print it accordingly.


The updated patch will be posted in the next email for your review.

>> +
>> +	if (dump == 1)
>> +		level = KERN_WARNING;
>> +
>> +	if (dump == 2)
>> +		level = KERN_DEBUG;
> Please change dump_cqe() arguments to receive level directly, so you
> will set "dump = KERN_DEBUG" and not not "dump = 2" in
> mlx5_handle_error_cqe().

Yes. This is also taken care in the updated patch.
Also I've updated the subject line as you mentioned in the other email.


Thanks

Aru

>
> Thanks
