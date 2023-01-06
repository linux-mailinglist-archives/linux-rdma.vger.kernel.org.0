Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D22660676
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Jan 2023 19:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjAFSjL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Jan 2023 13:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjAFSjK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Jan 2023 13:39:10 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82167D9F5
        for <linux-rdma@vger.kernel.org>; Fri,  6 Jan 2023 10:39:09 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 306H1jm3024530;
        Fri, 6 Jan 2023 18:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=asobnc3M3bu8CqLDI7GBwFDxhKEpUHvb+YZdYrXfM9A=;
 b=CXxDfOO8FSBJDikdoWVmxVinr8Mr72VIP/sgMuYU1GXpuTxN9jD3koIlkKvSUQePJg5Z
 i42B0Wi2XSOkwLjDrRACKsAN1pf5Kp/Qj7U5m5HnH4hba90D5jIDkYAsy7vnnM2m5Waw
 OiJRulNBlfZYagtpLwF7NmaUz1j2xYeHJfhG/t+vje6Hz7guoyHwhb49wmZTsMj44DKU
 vV14/twhzjqXgb9jKRpAtraKz04pqW2PI3rsjqkgFAGdbS+P0v98tJ3Cqqe68IiCLuNF
 uGk52Ilx+vWGyB+Wef4BF9PnJkW6ci7SZbsdfQ3p6RbvmxZrmgAiblWV6CG+osxGakKj /A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbv33ruk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Jan 2023 18:39:06 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 306IcwPD021198;
        Fri, 6 Jan 2023 18:39:05 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwevm73x2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Jan 2023 18:39:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IkRqhVKeoXvwurUVbWPJBjFhLA0lyAk7JDTQmzFjx6fXN0mk2j6T1mg0yalz/SM//cnVp1+2AsGAKCWOxw2BEhNnzAgtjzhPjndJ4+vXhMQz8R681bCRSBAu/k/cYkz5YGnayA41q4aVjB2p5mCvRjGy+T6wS89fC4FpNZJEJtst4APyxEyVnTVkExJcBAIfXReT+IObVc62mD9Ullw8cweSojsKOOLWfcUgBF4GJWoUP0rnMZGPJ9PYDLn0xAzcweEhWKYD101wkb2wLKh+pDYcM5rNU8NsBlEjUB5KR+9ZdqU3GRvNKaeBvrbJ0KuLJcjtdqkXc5gn6qIESF4JXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asobnc3M3bu8CqLDI7GBwFDxhKEpUHvb+YZdYrXfM9A=;
 b=h6qF7oBON9c04lVMjX5oQFS/9lEkWeLdouSshUVHZGGxm2F8gK1NY6aM+m8XtA/IL6wltJBGbzxGlGRZtz0KsOYTJb55KOKEFcaS8BTOMyRyh+sOAYPsAEOlowUQy+zvSzxaEV+6SAgbdwrdEmfqrnvaVgKVyBwdYaB55dYwKpGfieHsY2mY96M3908W5meD/sgzPhP5pGV2ZTJ5PCBHNLnE91724VyEuwvFLqI2Z0S874Ehc0d1suBQNkiUcxbfDY2lcRCFTJI4gWCpHAbKrstRJ5zQkLEB8qRxFH7ejlE1ky0Hdipz5EjB4NHazKeWu0qG4AvJli1vfoUAv6kYUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asobnc3M3bu8CqLDI7GBwFDxhKEpUHvb+YZdYrXfM9A=;
 b=lKks15ax4x0+kmiPvKCfL8VHIak56HOevDESzSKNnmDory3xiBBllBhwp7yVwSIAaOYfS6fn/1WlJ/TwN7V1p7a7zXhBW3iBTPPmuJ+A/2eWERRAZY6m9X/ijbrtYcD6VK2Xc7hKCrYoUTt+PRA+5Uwqjjd4NfXOFHD3eHXwwiQ=
Received: from CO6PR10MB5634.namprd10.prod.outlook.com (2603:10b6:303:149::17)
 by CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 18:39:03 +0000
Received: from CO6PR10MB5634.namprd10.prod.outlook.com
 ([fe80::af6d:aa0c:3086:ad13]) by CO6PR10MB5634.namprd10.prod.outlook.com
 ([fe80::af6d:aa0c:3086:ad13%9]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 18:39:03 +0000
Message-ID: <0757d1ae-334b-38ed-883d-f95b72dd04db@oracle.com>
Date:   Fri, 6 Jan 2023 13:38:59 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: buildlib/pandoc-prebuilt
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
References: <4c29b8d8-c4c8-a7ae-e1f9-ddce3b55d961@oracle.com>
 <Y7TF8EK/PXiwKRwU@ziepe.ca> <612e156e-d8c7-ee17-430d-9d6d85427a3f@oracle.com>
 <Y7W3dASpXM7/br4i@ziepe.ca> <Y7XIrX1E78KyfWud@unreal>
 <3c924ffa-5f6c-4a88-85f3-7995e399fe86@oracle.com> <Y7Zl8k7F1gDNKE9q@unreal>
From:   Mark Haywood <mark.haywood@oracle.com>
In-Reply-To: <Y7Zl8k7F1gDNKE9q@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR10CA0011.namprd10.prod.outlook.com
 (2603:10b6:806:a7::16) To CO6PR10MB5634.namprd10.prod.outlook.com
 (2603:10b6:303:149::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5634:EE_|CO1PR10MB4561:EE_
X-MS-Office365-Filtering-Correlation-Id: 9688253a-a557-4af2-f903-08daf01548b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kv+1jzMz7IvVJ5/IKx/whfinqjpuUCKsON/NJNqHJ/SvbacXTlWQw8FGlu3TA6GavgTpZI0xavaJvNGBYAB32m1IGMBtqDLEwmEnj9XGkErdR5RsEvKOhGD+8H45UGZIh1z8gSvdBLIf/Dc0vCmY0xwZ+laVJ4yI5vvOM3vO31byx/gjDJna+X7mL8/d6ooCg/+1ZLT2QM+rSNbHfiCEDrfRS3X7P/froHZAHJrdn8jDIS4jRpnPuwUeHjG2HaMMKl7HJrPmjYkdBxjSxVoLAN8nbNtVBNtBPNAudyTaLtf3HW9opdjqY3Cd3t8U938ars1khrErHkQFoGfzK+nR4FN+//0z9vOLkVho1nj7I2Y/qIebsaHNDn//ZoWbN9ckEBQmxS3b2AxgsJsPp4WX5gPXchjem7oXVilsNxyJJ3HmCnfPohq0mh3ubITnrfTkDLtlHZKpb1duDblPRGxRqFo/ibsvqpwSeScoCYrJ/RgbfD6Y4rf3zZNfq3aRIFkV+X3d99aACOkfwXlVMf5tG+OJUIohkuNl1vJH7PmFSMBDktiQPIp2C6TSGnE/D+hntpdkFq72gKkKleLEYIxHdLc3nx2EpvRtWcG2DdMWM7GcAIhpBfHhl5NjqH2lJlEtVEpwEj1oxxx3NqIaO2raB65EMSmk0Pu/5esu4vxc/uVyjicTQR+KrxwBTWitXwx5ZPU7imVQGGP89pwN8xU9Ec/BxOe4F91YPyhTu9rs44p6E4/nCpgG0SIn+h8TG2APoapaloY4CcejqrhebwFIPwps/5r9SBMBd3u6kt1DeWU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5634.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(366004)(396003)(346002)(451199015)(5660300002)(2906002)(44832011)(8936002)(41300700001)(478600001)(4326008)(316002)(8676002)(66556008)(66476007)(6916009)(66946007)(6486002)(966005)(31686004)(6512007)(26005)(6506007)(6666004)(83380400001)(186003)(53546011)(38100700002)(2616005)(3480700007)(31696002)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFhzTTNKWWVBN0hkQ1hUR2dYUWV1b05Va3Y0TENYM210RjQ1Z2NaQ2dITEpG?=
 =?utf-8?B?YXgvc0w4UC9DZVUwSE1YT2V5VGN2SWpyY28rRTVzSGttUW8zK0pVYmJGaHlm?=
 =?utf-8?B?dGhvSVpuZXJxT0xPTmZlTjY5NW5uNXRkeitnZGJMajR0UTF4cmoxYzZDSWN1?=
 =?utf-8?B?WStBOHhsR2ZqNUpuWlMzS05WM1FDaER5YTZVdnpUWGNJRi9rUzRveDlPaEh2?=
 =?utf-8?B?U0c1Z3lEMEcvbEsrMW9EbzZ1L085bXVtSTR1ZGxqRUtyYVhpTUMwakhmbjQ3?=
 =?utf-8?B?VTVlY2s2RC80Wk1QMU9oWGJCZlhLd2hVZUpRVWRFeis4ckJ1V0ZscVRGWUUz?=
 =?utf-8?B?aDdpYUorUFpKRFV2SzdabDVDMEFySERObEZpbDZKYTZmai9TUGd2bTlGWE5H?=
 =?utf-8?B?dERFZ1FuM1E1ekIwZEpmRjUya2hwclFhMk4vV1libHpSZG5KZEhTZkpxNlBW?=
 =?utf-8?B?Q3k1cVRKcnJ4V0JlOEhBMzhncUlpaEh6NzJhR1hZSk04RFd6RlFKZkRlbzB0?=
 =?utf-8?B?a2RoQ3d3cXpva29xREZEM0w4SkV1blRObXFiMTIyenRtcmRNbUE5RE1JRm40?=
 =?utf-8?B?SStCMjc1ZlBtdmVQVis0WSt6MDFVZFd0UnJ5QSttS1E4N01zL3kwSmwrMklq?=
 =?utf-8?B?L2tyVUREMUNCeGozWHFuaklPWjVldndlbEpML2ZzRERCWW9YZmdiREhQbk85?=
 =?utf-8?B?a0hYZ2JxdlM4NDdFaGpPSjNGaFB2QVcrWHZIR2RrMC8yTHdZNGlFS3pMUTk3?=
 =?utf-8?B?Zis0NkVTKzhMU29pYmxwV1V6cnFndWNJTTNsa1pxWHlHVFFLMXhkQnpqOENn?=
 =?utf-8?B?Mjl4bnQvaXhjbkt0U09DL3p6ajJ0MndzeG1NQ2pEK0ttRlkwbDZOMjYxMzh3?=
 =?utf-8?B?ZHNJdmI3Q0FJODVYTlVGUnpkUWY2K05wMFpQQklTb3ZaZG5QR214b2FIVWx3?=
 =?utf-8?B?UG9LdVJYZE5hUHhTYXd4ZFJMUkNNNEpwVkZVTmlSbU41WU9vZGRIeWtNUFBl?=
 =?utf-8?B?cDJPalhjT3RtbDBOazMwek10cCtiWnUwWVVlU1g4bzNpNU4wd2drd0Y3L2Q4?=
 =?utf-8?B?elo3KzkvSWcxUHdUTjRWL2c3QndaTFhpVEc4TzU0SFBaV2tBUGdUd1p0NHlF?=
 =?utf-8?B?Y2loTGJRWmFHd3RBTVpIdUx0U21LWEhMdjI5TDFKb09ub1RwUTd5djh5dUVH?=
 =?utf-8?B?Z1YwQUczWGVDNEJuRGN4R29WNWNNUkdBeURPYkhCc2JBbEVscWR4M1JlODdH?=
 =?utf-8?B?TEhyQVA1M2dibWptOEg5dEkyNzFJQjZvSkk0aFMxQ0VFeGMvNXp6aUFDUHBy?=
 =?utf-8?B?Sm1rSVNZVTlIV3ZaVlRjUFQ1cm4rdHRoQzZCcmxVUnpONnRwdWNORHpHM2Nh?=
 =?utf-8?B?WVhQcW5mUCtmbklKMm4wMzA0eEJsTzYyb2hrSENiV2FkSkxCenhXR0pUZGZz?=
 =?utf-8?B?Zm9PUTlUdEp2V1M2Ry9PQi8xYm51Y2tGcnMxSCtpUnlJVHFiaHhMa0F3bEEw?=
 =?utf-8?B?T3RXK1lodm1VWkd4aWw1dEtRRHl3UmorTE5jZ0tLYzBRckE2NDZCdHR5V1Ju?=
 =?utf-8?B?TmZMQ0tHVnFJR1JheGZEK1ZkV1hHRVRpVldyWk5Sd0FyK0hVMmNHeGlLUlZJ?=
 =?utf-8?B?bG13K2NGS04xMHRCT1Ywd245bEJUdzEwQzVSOXJ3VW05dG1OWU5OL2l5R29I?=
 =?utf-8?B?ZnFFNmUzN0Fmc2thNXZMVld2VEloSmtRbTR3anZWaVdqYzU1bTRJc3ZtdGJ0?=
 =?utf-8?B?VU95WnJQcDBDVUIvNlFVWXY0Z3llMjVpYWFqSGNOWkNaVXYxczluM0JsY0ll?=
 =?utf-8?B?OXlheWVONWVWYmhtaG5tcDAwOFhZbWhoZjFualFvbGJFZ0JwR01hck90K2JU?=
 =?utf-8?B?VTRsQ2txUDlkdDlxTWdJYnZPRlNWNmN6QWRzbkZjNlNOY3hlUDgrWTV5b05t?=
 =?utf-8?B?bWpDK2VhQlUvN3BwYmwyd2t1TFI1NkxjclRLQzVYSCtpeFY0c2x4ZnpVVG5Y?=
 =?utf-8?B?YnZVL1ExQzVuYmVQRWZ4Y0RQNFkvcDF4OXMrMXpPMjdLS01neTJYVE1EVzZS?=
 =?utf-8?B?dWFVNWtMTHNLU2FraGx4UUtCTmRJK1JIdnhEbXNOb1BXU0JVdkNtb0tDa1VG?=
 =?utf-8?Q?wsloT3eErV0PZZoAnBYs0fTW1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IijwtnNhVP1y4GZMEw6rjJ0WimQmffnR1duoVwqlhm2hWqiT/YCyQwWOYD1BBAp+2Oe3GK0yWcxY9W3eQzzdv/35XjiPAan/dTTUCA4enOPS8oZOu8/JEpqQhG79tJWZ7S0p5ViAsDo9KURyGR+YBke0bBSrvVk8CANc+7fNv5UgLUvKMwgmwLTAlAQTZPGmdNlv0+A2UOWagZ7M1lzcnaT3JqdhPDAwirMlzB3viRNdfex/RdJmVIzbh15XW32rvzcyAHWSFR7DjVSdI0qCitvFCEa4nXTjvdWvbcT2XOKcscAnMHms3frGZPD03XEGtpQfWf/oIUtT+Q6oxB5tFTsTKED1fzbRUSMeozz3EzWc2UhgoIBzz0JUYDIfNV0IbO+HdcWXR1tRlPZgerna2B/UdvdicXGmRdYy6g7fm6/WcUBEFA1+Pqm4+8b+H6anWedrTpAvqhd+eX5VwWOjRmvBjPMmdCugJQYKYZziw7Y45kv3n2aZ+OhwX8bFzLjvK3LKDb9KcClgwdLFGWS+0RwwHAHRvmMRw1spRnrpG9RUnscrjGaR0i3Po9ka28FXlx36J0/Pg14cP66QAqyRc07w16zKPilPl4PUenyBH2B6AS2EjHNV1U4aauTpTdNVuo7rSN7i68Q9pCKZpNx4t6gcNCgKOzn74InxBVQNwkVP8/9RSf9S95Gzi/wQ9l2FDTrTYHfF4bnfuL3NYYI7odXGXMFJnfihiaavKp38X37lD0LHzc9ReZG/i3wy3TU0FplFHtlwBVu6Mw6lDOjNJCe1ZpQPtBVByJ5YCOp8M138JZ/7QXAqPT8pqNLuDfJ1
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9688253a-a557-4af2-f903-08daf01548b9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5634.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 18:39:03.4129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HmtfLoSosijATHEjcQ662ynRZBZIEpIOOTNZ1frW4eM89tXrB+D1HDaVR84m2M2UvHrtS53XHbtjMX+3J0HDGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4561
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-06_12,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301060143
X-Proofpoint-GUID: 8zMvqd6uBopl5DmDEikWBXTU8rN9camo
X-Proofpoint-ORIG-GUID: 8zMvqd6uBopl5DmDEikWBXTU8rN9camo
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 1/5/23 12:53 AM, Leon Romanovsky wrote:
> On Wed, Jan 04, 2023 at 02:18:42PM -0500, Mark Haywood wrote:
>>
>> On 1/4/23 1:42 PM, Leon Romanovsky wrote:
>>> On Wed, Jan 04, 2023 at 01:29:24PM -0400, Jason Gunthorpe wrote:
>>>> On Wed, Jan 04, 2023 at 11:05:53AM -0500, Mark Haywood wrote:
>>>>> On 1/3/23 7:18 PM, Jason Gunthorpe wrote:
>>>>>> On Tue, Jan 03, 2023 at 06:04:21PM -0500, Mark Haywood wrote:
>>>>>>> I just extracted https://github.com/linux-rdma/rdma-core/releases/download/v44.0/rdma-core-44.0.tar.gz
>>>>>>> and noticed that buildlib/pandoc-prebuilt does not exist in v44.0. Is that
>>>>>>> intentional?
>>>>>> ?
>>>>>>
>>>>>> It looks OK:
>>>>>>
>>>>>> $ wget https://github.com/linux-rdma/rdma-core/releases/download/v44.0/rdma-core-44.0.tar.gz
>>>>>> $ tar -tzf rdma-core-44.0.tar.gz  | grep -i /pandoc-prebuilt/
>>>>>> rdma-core-44.0/buildlib/pandoc-prebuilt/
>>>>>> rdma-core-44.0/buildlib/pandoc-prebuilt/caaca7667f40fff2095c23c0f40c925f1ff3edea
>>>>>> rdma-core-44.0/buildlib/pandoc-prebuilt/e2cfc53feeefa2927ad8741ae5964165b27d6aee
>>>>>> rdma-core-44.0/buildlib/pandoc-prebuilt/971674ea9c99ebc02210ea2412f59a09a2432784
>>>>>> rdma-core-44.0/buildlib/pandoc-prebuilt/241312b7f23c00b7c2e6311643a22e00e6eedaac
>>>>>> [..]
>>>>> I can't explain it. The one I pulled yesterday doesn't have them:
>>>>>
>>>>> $ tar -tzf rdma-core-44.0.tar.gz.orig  | grep -i /pandoc-prebuilt
>>>>> rdma-core-44.0/buildlib/pandoc-prebuilt.py
>>>>>
>>>>> The one today does:
>>>>>
>>>>> $ tar -tzf rdma-core-44.0.tar.gz  | grep -i /pandoc-prebuilt | less
>>>>> rdma-core-44.0/buildlib/pandoc-prebuilt.py
>>>>> rdma-core-44.0/buildlib/pandoc-prebuilt/
>>>>> rdma-core-44.0/buildlib/pandoc-prebuilt/caaca7667f40fff2095c23c0f40c925f1ff3edea
>>>>> rdma-core-44.0/buildlib/pandoc-prebuilt/e2cfc53feeefa2927ad8741ae5964165b27d6aee
>>>>> [..]
>>>>>
>>>>> I am sure it was user error on may part, though I don't see how. Regardless,
>>>>> it's fine now, thanks.
>>>> There is a second link:
>>>>
>>>> https://github.com/linux-rdma/rdma-core/archive/refs/tags/v44.0.tar.gz
>>>>
>>>> That does not include the pandoc, perhaps you downloaded it by
>>>> mistake?
>>>>
>>>> I don't think the releae tar file changed at least, it is generated by
>>>> a script
>>> Right, I didn't change and/or force push anything after initial release.
>>
>> No problem. As I said, I'm sure it was user error on may part. I think Jason
>> is probably right and I just downloaded from the v44.0.tar.gz link.
>>
>> I just noticed that clicking on the v44.0 tar.gz link from
>> https://github.com/linux-rdma/rdma-core/tags downloads rdma-core-44.0.tar.gz
>> on my system and it looks like it is different than https://github.com/linux-rdma/rdma-core/releases/download/v44.0/rdma-core-44.0.tar.gz.
> I tried it now and got same file which includes pandoc.


Note that I am talking about the links provided under 
https://github.com/linux-rdma/rdma-core/tags page, not the 
https://github.com/linux-rdma/rdma-core/releases/tag/v44.0 page.

When I click on the v44.0 tar.gz link, it downloads a file, 
rdma-core-44.0.tar.gz. If I just copy the link, it has a value of 
https://github.com/linux-rdma/rdma-core/archive/refs/tags/v44.0.tar.gz. 
I am not sure why the file downloaded when I click on the link is named 
rdma-core-44.0.tar.gz. But I can wget 
https://github.com/linux-rdma/rdma-core/archive/refs/tags/v44.0.tar.gz 
and the v44.0.tar.gz and rdma-core-44.0.tar.gz files are identical and 
do not include the prebuilt pandocs.

That said, this is probably moot since I should be downloading 
https://github.com/linux-rdma/rdma-core/releases/download/v44.0/rdma-core-44.0.tar.gz 
and extracting it to get access to the prebuilt pandocs.

Thanks.
Mark


>
> Thanks

