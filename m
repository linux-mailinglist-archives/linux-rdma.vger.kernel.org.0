Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041D156207D
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jun 2022 18:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbiF3Qkn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jun 2022 12:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbiF3Qkm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Jun 2022 12:40:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0103C2FFE3;
        Thu, 30 Jun 2022 09:40:41 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UEtbrl011610;
        Thu, 30 Jun 2022 16:40:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=xnK9udZ3qYkBYEiFYmkRvhovYDRpBVKIf3Qsog8ro8s=;
 b=jecwGQ74dZiUNgf62gjR+vq5lFZPzaDfS92T36chLjoySzwjTHuCy9qi7kgfkgXuM3n5
 FVVds/eML6zB6MeM0TLFfI7YlwKFzton8Y2sUUg5qfN+qGL2zfJyuaC2RWNbGcAZLEnk
 30yZdJ5eBqp9CEZ9TecVqdc1W9wbyK1aHy1wQwjmbkooCkmRbV+tinRiY12cNBbjwxIn
 URZlvFNdY4m1sa6IIrX/kt/SaCb3eatiOA1Af1JkJZ2ymJAUqtrOtF1sZAjv+DiDlkiM
 EovOpfJw44y08+zJMEl7PWggp87wNeK5NNn9m1e+uqQKM9j8ONYlFg5htxlh7Oi5nJpX 4Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwrscmp6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 16:40:35 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25UGV1PH036801;
        Thu, 30 Jun 2022 16:40:34 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt4mjr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 16:40:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhKsHS+vyWFs66Ceuybbfhffmi5ze0mgmSeOcjgv41NQNYJcqJf+IqV15xK7E/pIQ7Atfd/CdM5El8fFGjGhNimgx07sA8z9jaQyfkTHOHuTpnHzYnck7Iip7EBXLd8hKBv7tX+znfHrtn4sx4JWNJ1ScGAVPKd1ZbP2oANdQPyHH3XJZBZsi7dOxcBV7GVCBXqExPY1mcQSIymfjs89mko1VOGRrSaA4H9KU84FNT0tmRYfsBdA90gNUbUWDsjb3W1QVlSlpMG8Fnrb5uatQBo9EwNHxumqaTpO5V0F5BEBI9nK+L4BTLZo+hZ6DgeDgB21A0Gbj65hRnaTbFflFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnK9udZ3qYkBYEiFYmkRvhovYDRpBVKIf3Qsog8ro8s=;
 b=d4UOjter0PyDOGktSB5lPlWrhMpfxBuAoodTZ3+sgHsNfas2Sfb3YuC9Son/Bsww9QbjG1cEnf8OXHpJa2b1whC+CO9B20BmRTLhVXKT9x1fJUn0127BrTpPNbir1u0Xu7lI3EsDi2ZiH78kTyzGdol+b7TfprHlfdbB0m2NvbfVMHprlCdvHrdluwmjJ4ncAV8jTfa1GTJSVpQ6/CC70kQIjDptrNNDJ94bT1sUTNUZzywffF+w74jk7KuCHmSNIpwHE7bMVvm22RAqcTNiPVu4fUCSjBNsdAqbqTwPFZdL22t+Qv7nkopTWQpEub9hrQx/bO6DMZi0WFD98zCw9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnK9udZ3qYkBYEiFYmkRvhovYDRpBVKIf3Qsog8ro8s=;
 b=jXJ7ryoa2Gr9Ea2yL4YA0t5bgVRYhk5mvGAdoS2FQJ2vcpWaDMLl7EHUrRoTL2G0Bbrh6diMVd8GSlNsEU5fPlDApctq2mzGJSKC62/e/I92uYQ8dkE1ws4Ix7Dchsg+mYRqH3PYua1LRg265d55kWIMUSp/MrTp47WRTRE4Q8Q=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 BYAPR10MB3704.namprd10.prod.outlook.com (2603:10b6:a03:123::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 16:40:32 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::f81d:b8ef:c5a4:9c9b%3]) with mapi id 15.20.5373.018; Thu, 30 Jun 2022
 16:40:32 +0000
Message-ID: <fbaca135-891c-7ff3-d7ac-bd79609849f5@oracle.com>
Date:   Thu, 30 Jun 2022 11:40:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: use-after-free in srpt_enable_tpg()
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <17649b9c-7e42-1625-8bc9-8ad333ab771c@fujitsu.com>
 <ed7e268e-94c5-38b1-286d-e2cb10412334@acm.org>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <ed7e268e-94c5-38b1-286d-e2cb10412334@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0154.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::9) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 782f2e6b-a3de-4c6b-b1a7-08da5ab73fd5
X-MS-TrafficTypeDiagnostic: BYAPR10MB3704:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C/1E/4ypnuVDKq4at/nLO3XGXHcQUvrj93WIxOh9BT14ECKkZQlpvR7/U0FVXPH7I/AzfbP2FK54fOBZm/Tyh9yF4xoxxibUgzz1Om2QVICTMYdoAdpcD/BwAOSXogEEirOygEI/4YEJ4u1WtFaFuUvYTMU6dzBp44p6X9Fh26X1SCQihzvCpdSGvits7C7TvP/cIwzvWwn3wRtuD1/jjsdfLW09AVXrTLYg2g8qejQZVtgTUUPT4x08grLTNgU954G/nN9jDyW53XaFwxnWQ9I/jhfm+CVtojO0UQho91+R05FI2ugZ+FzUI6TVDbCtNLsR0hjQJLiz3ptNyDZu5UyRA3/mqt2SCOX7SS37y2QQj4kacvGkVF0rLlGnNPjwmaw+vofOX3mFvEwY5NOBrgzSAS7VaPYM+WOvvX5O8lsLujxfvd/eoV25NRVDeuBNZnBco+kh/tr+j3N4k9iSdM8p1GfzXZHvr6LtUWe8aA9UqH7UWKF3NaKaTAic1Z3AFpwusJsAt/4/WQzvQhRiUUl5bYtLaTboixZWNW/H+0ooMZDcT/9RyPzMLDZ6IL5KXMmAiBLREy4EkigTl1eKfw3kFyy/Lje0rkuCujTiiqLWL8yY1x4q/1UIdJxOlRKKN9F2L7gZQWdsR2xdU/yZk+nM1IH579qn5lPqkWUsbS7BP1efRg1Yy5kt/9w6qJu+9wILdxN94z2+J1oyBi3HLLWV7wtuPMgtRNqTjPvOZz8TI+cCR3Xye9W3ExQcy4dqUxeWVKMYY0zOE6a20xVXrJ1QmN6HfRJyJN1dykC9PWrGSxXFLel81Sxd41yxYLBI2Ra58v8oxdZMqV3sewWTLJV9a67X4COaXPqX4rdaEy0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(396003)(39860400002)(376002)(136003)(86362001)(5660300002)(53546011)(6486002)(478600001)(316002)(31696002)(36756003)(38100700002)(41300700001)(66476007)(8676002)(66946007)(4326008)(6512007)(4744005)(2906002)(31686004)(6916009)(186003)(26005)(8936002)(54906003)(2616005)(6506007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U253dFJGRkJXMmFVcmxINHhJSHl5am9rNVkzbHpmSVdBUk4waUxxZXF0Ylhw?=
 =?utf-8?B?RWhRMlJpNTBTOWFLOERYdWR3ak5aRXpRM3FxQ2dtenk4dTlDRW9PM0xuQ0dK?=
 =?utf-8?B?S0pOLzExSGFzcWZ0amgxN25LampzUVFSbytGdEVqa1RXM0dHZWpaMkVzcUdl?=
 =?utf-8?B?M05IZDlDN09DVmMxZzJEVWRjR2ZNYmkyd2RuOHB2MnFuUGxzdk14bDU4MHhI?=
 =?utf-8?B?SVVxLzZkd0pqTVU2MFhYWTZwVlpuNlZhOHpjVlVSNmRSQUVEWEtTblRhcldZ?=
 =?utf-8?B?RVNxb0pFWXpQL2NwYlBWTW1DbGdGQ0xLczZzVDhqWXlGSXdFRm1IaXdqM0dN?=
 =?utf-8?B?LzJ5dWhoMS82S0I5eXRmNjUrS2lNYm5mbWsyamFURjJITTNZcEVHaDIwUFpF?=
 =?utf-8?B?SGdtVFVVNi9hNG5DN0QzMDBseVEvRnRIM3pGb1MxQTZiL3h6OGhwa2hWaEhq?=
 =?utf-8?B?YWVpbXJFWHRoV2RFd1JWSlJFY3d0YW13ZDZKNWprK3A3dGRhV0VFYitLYWV4?=
 =?utf-8?B?NW1Ob0YyYXhoOXFmdkUrcHBhaktPV1U0c010Vmk4MksyemFHZFRMSmhpVGFn?=
 =?utf-8?B?NDNKSGlIWEJhVjhnVHJLRHlEMGVzQUNkSUVHamdYMHBUeGpGcFFwQXFtWVpk?=
 =?utf-8?B?VDE2WkZvOVE2Z1dIU29ORnp1MjNIRXVYOG5WN3FqQkl5dkliTWhpVUROcjRC?=
 =?utf-8?B?R3FENm1GZlBPRlRpUWZPWkp5MXp4NHRLVEN2VXl1RlZnY3Q3YW1ZTFdMR3Nu?=
 =?utf-8?B?SU9DSE1wdnYrWU1WTHFRNlo2dExuWE5RTWMyblZ3dUdMU05vSGJPVEY1YXdE?=
 =?utf-8?B?anRSYkdzOWFEUGlSRk8ycjFkNmEyUDJWckVnblV2aGRrZzhNSGUybUwvTjly?=
 =?utf-8?B?OXRsOUxpOTE3LzJnVVRrQmN4MklJYjFWUXlNVkE0a2V2SnEvTFZ3ZTRabHMx?=
 =?utf-8?B?K2dKY3pqd3l3d0ZoZWpDc3g0NDRCUThzOEdURzJWdmFQcUQzZUh3L3QrL2hp?=
 =?utf-8?B?RDFzczdHQjBpWEF0cUFNZVZMM3hoU2tqdXVFUFVYdkxPZnN1Tk8xR1cwUUNU?=
 =?utf-8?B?TTNTV3IzeVRJeG1kVmVDR2R5QjFkcFhiREt3eTh3dUNnS1djVVF4NXFCSWdE?=
 =?utf-8?B?cHYyR3VQbUlFanRlUERHUUJQS1NhU1lneUlNTVNUaFRuZkNsajExcXJJVVA4?=
 =?utf-8?B?NmRRcnpwUG00SHNUNW9tWTFpQlZjSnlBNjY4WU1QU1NjMVloM2s3VDJ3TnNl?=
 =?utf-8?B?dzJVVmh0U2pyeGdTRExYeW1TTU5ybS81bzBQTkpMTlZVa0kxS3dDTVBRN3pT?=
 =?utf-8?B?Z1NTNUZLT05GRktiaFhkanpWL1M2NVZ3TEQraVJqd05naWJVV3p1OUJxZXZr?=
 =?utf-8?B?WDZXNVllTlhTTXpsUG9oS0djdkZPZ1E2ODBPbE1FZU5WMWlSK2Y3cE5aNDM3?=
 =?utf-8?B?b1BYQ2ZnWGE1eVB2WDE4eEVILzdZS1ZXb21iY3EzS0VRcFdKWE1nWjc0VWpn?=
 =?utf-8?B?c1FBMzVlWWdnS3VweFlRK3NiQ1RDeXloaWJwUEhpUCtraWJMRGNnM0ZIUFJt?=
 =?utf-8?B?djFWUEFHU1FzQlpVemJ2aVNzSG5Md1l3Nksyd09qMnVxbVRyV2NrM2RmZkNv?=
 =?utf-8?B?bGRra3NNU3V0V29sNWtkaWJVQ2R3K0N2VzdwME56a1B6VkRDUFhwTFZieVh0?=
 =?utf-8?B?bFZDZk5aUk9ZN3lTYUhldGM3ajRmYTUzZlVkOVRBcXZiTWZSWWhUd2lLK3hu?=
 =?utf-8?B?YWttRU8wMnBlMWJSSDNsNnVVSXNyODcrcVAwUEU3WWlyQlVpYUttcVBIQkMz?=
 =?utf-8?B?NW1DLy9PRktmTktwbUhjcm9pdnBWVitKa2lyMmpuNHRMMHVPOWFCV1NSSzhs?=
 =?utf-8?B?MDVyblhpMURROTUyb0ExRE1WL1VTazI0bEMvZEhNU1N4a2Zxdk9KcEZiQmMv?=
 =?utf-8?B?aVhlZVRaZkpkcG5kSjBUV3ZmSEI2Q0J5N1loZlNzSytnejBBQXMwSjU0OU9P?=
 =?utf-8?B?blE1TVFUQVVIRFdhWk94bnNSRC9yOGdkRXRBc296dEp1bTArQ2lmSFVLeit0?=
 =?utf-8?B?TFB1YlpXaDJMWGw5bFNiY3Z4MU9rM05wSVFyUGkzZTBUajNqNktHTEpjck5s?=
 =?utf-8?B?ajVpNmk0enFZZnlBOUh6ekNLNWFKNU5uK1Q5OW5rSGdrVXVBZWxJYVR3eUsy?=
 =?utf-8?B?Ymc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 782f2e6b-a3de-4c6b-b1a7-08da5ab73fd5
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 16:40:32.3924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E1PlBrrtaO0GQSCMtG4R5uvtLsQZZmP75yol1dJjHQECJ76a+HjEoUAecyfRhxjhHjiK9sfsnjkLgjg2vvD/AYlFqixIlKMI2yEJVS1Sp7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3704
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-30_12:2022-06-28,2022-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=425 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206300066
X-Proofpoint-ORIG-GUID: Q6X25LXANvqn4PXYcr0WiDSG92F8xcgc
X-Proofpoint-GUID: Q6X25LXANvqn4PXYcr0WiDSG92F8xcgc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/27/22 11:37 AM, Bart Van Assche wrote:
> On 6/27/22 00:09, lizhijian@fujitsu.com wrote:
>> So far, I doubt if the previous defect of configfs mentioned in
>> 9b64f7d0b: "(RDMA/srpt: Postpone HCA removal until after configfs
>> directory removal)" has got a better solution. if not, i have no a
>> clear mechanism to avoid it yet.
>>
>> feedbacks are very welcome.
> Mike, are you perhaps aware of any plans to add functions to the LIO core for removing tpg and wwn objects?
> 

I don't know any work being done in this area. I was only working
on the refcounting/configfs parts for sessions in those configfs/sysfs
patchsets. However, I think I hit similar issues with the session.
I went around the world with solutions but didn't really like them
so I never pushed the patches for inclusion.

What was the hang caused by 9b64f7d0bb0a?
