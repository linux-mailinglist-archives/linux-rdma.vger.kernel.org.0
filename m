Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5DBD3A944E
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jun 2021 09:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbhFPHqN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Jun 2021 03:46:13 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:63254 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231256AbhFPHqM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Jun 2021 03:46:12 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15G7QVw8007455;
        Wed, 16 Jun 2021 07:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Xu8gnhiJAR4zcK/Cf7c8jxHoeaxDa6gNi3GKZezNvxE=;
 b=eHaFNHUEyrruZWLvuE6OIyvMCqCFqEugGBK+9t0iwe9KuJ2JWHrByX5KgejI1YEBJF8J
 WJGpjtglYbeJ02WTc7qSPMRf0VXEdfuSCsDzniZPFirkx/oCf+Ob3Eag4OYuo65BfGtY
 Hdr39B0PQp9P6u1pIOcKshEaAaf40TpAEdA1abAs7cwq4AbX323vukLrFjBi8hfUv6Mw
 2N74Bda7VR1i9R3uccO8diGIkpcaA1D2v13/CTDU4wcxZ2Rv20KiZ3jPKDOqfllLb299
 +bSGjOXHTyfDO2dK/9nOxFcuaFxbAACFo6EaWMfAt6h8OwsspEEyjR87l6spqPpvmSTt uw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39770h8emh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 07:44:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15G7PV3o148028;
        Wed, 16 Jun 2021 07:44:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by userp3020.oracle.com with ESMTP id 396wavyswa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 07:44:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYfPvyhIqB19PMEv9FVnX4WX+Njr1X5htnXwKu3zflBvrzksfkY4U9arVKIaFSowY7uj9kPbx9NfIq0gdVY5CfPX3M12inQCogBwqhA9OqBNgfpMPET1oY3rs+pKWUwuSVlPZo4ZsHvJivwtvN3C5qm0nqL8gQFpr6Aa6hNOK7Z2GDrB+aCoOqkTaXniZmWPSVVJtHCeh+hdHNvgU1cg6sciajg3AYg1rPFULAABujYyLQhQdVkloDiB8HwBpMiNeMpbuteTCozjYP2GI5qVhePbmFBxd8jIL41WfQGSwK/9uPHduyWroUIzAGwRolWhHxqdMFDoWaRxHwDDY8vdew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xu8gnhiJAR4zcK/Cf7c8jxHoeaxDa6gNi3GKZezNvxE=;
 b=T16s5yY+oIhNcyCWpcZf7uqrLNGM0nB4oL2NM1A+cw6stjTNAH8jFN4WBUyGvdJE/gFXspnDIMecs+x7BH4BAooR5P6yL4HDvQe8zryXx/XkUgCmPWUABDezE0kmdLDtjj1gMX5/1o4fpucZVqvTuXIJtntIJIWEUrPZE27v3YXxFfrc8IYftIdWvKLIw/bDxTWP6N2qQHgM609Meqam2NtXCuTjmpM1zajwOP53YZOTLbOWnblBzZPKWN9XkaseNZmrLu93pTm/Ekqdtstet4zztYPgl5dsSVSo6ra9jLGXkzhQfjryDLFYJb+KXArwcJtVBcjZ3wVMB3qJyUJ6XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xu8gnhiJAR4zcK/Cf7c8jxHoeaxDa6gNi3GKZezNvxE=;
 b=oUQoWLj4ldEdlPOkiFKyVfQICCzGcSH9taRoVtIUBaTEVZH4o7EEt4T+ekXWS5YIjDPLv94RpvgTwzY6ZP27ZGFbSdxu9ONIbEGI9vYKuJqy/MvP99XjJ1DId4j5oiHBfYOJBt2nubbPwTg7IxYW9fGle4mLuv6DoXdmEw+zyKE=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=oracle.com;
Received: from DM5PR1001MB2091.namprd10.prod.outlook.com (2603:10b6:4:2c::21)
 by DM5PR10MB1818.namprd10.prod.outlook.com (2603:10b6:3:110::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Wed, 16 Jun
 2021 07:44:01 +0000
Received: from DM5PR1001MB2091.namprd10.prod.outlook.com
 ([fe80::211c:a5c4:2259:e508]) by DM5PR1001MB2091.namprd10.prod.outlook.com
 ([fe80::211c:a5c4:2259:e508%3]) with mapi id 15.20.4219.026; Wed, 16 Jun 2021
 07:44:01 +0000
Subject: Re: [PATCH v4 for-next 3/3] IB/core: Obtain subnet_prefix from cache
 in IB devices
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com
References: <20210616065213.987-1-anand.a.khoje@oracle.com>
 <20210616065213.987-4-anand.a.khoje@oracle.com> <YMmoiD5mXm4/OWj3@unreal>
From:   Anand Khoje <anand.a.khoje@oracle.com>
Organization: Oracle Corporation
Message-ID: <76874d23-6948-d01f-b151-46bddde92636@oracle.com>
Date:   Wed, 16 Jun 2021 13:13:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YMmoiD5mXm4/OWj3@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [182.70.80.33]
X-ClientProxiedBy: TYAPR01CA0006.jpnprd01.prod.outlook.com (2603:1096:404::18)
 To DM5PR1001MB2091.namprd10.prod.outlook.com (2603:10b6:4:2c::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.8] (182.70.80.33) by TYAPR01CA0006.jpnprd01.prod.outlook.com (2603:1096:404::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Wed, 16 Jun 2021 07:43:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae0497fd-3439-49a0-d95d-08d9309a81ae
X-MS-TrafficTypeDiagnostic: DM5PR10MB1818:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR10MB1818CE54EDCECCADF65AC466C50F9@DM5PR10MB1818.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CyXQbeW1LJAq0k5jNvYgBCkrPbhvPkOEq5aHtKzKRt+YDvYhHEUhJbjujybaRkXfouFsqGu7veG9s1Rf5I9yD6MninEYQP6t4f/rawB+oGWEdXhqTGw0lyYSJ6j7FsnKDLwhBw/EDEBhJYDDBCqSqZW+nsENP+0HdGRiJzJL3sVYuatz/+tLwM8ZK7BEkCzTqirN/HWkkum5YntAhJwcbwEb1feAURjcLlm3Ae80j/sr/mIFGo7sM6oAcVFAXdJcqMoKSqb16g6JegUhpxRDTK9UT4JE8ZkEfjomrGzEngBGB10kxrS3qnlxXbfcYjWk1uKR/oJbjv/6Az07+1OOzABicPUe0j1iKa8zc2yaHmhH8o2f8JpHd8Kb7IzKvWAWhdZKSms5a+tT3gMXS+bjhRCzGdKQFu3wTu6/+dzn5vmaDk67VwgpoEYiNG+MxuRQ9PyMrlISGanO1LvY6Mocl5LHK9L9VXsPO1DW0xPpIkD9/JZQvhvF+3HDe1KdPiXaUrLnllMAKthPQA5TOTVkm5n4Gt52mu20FyKsMMc/7Le1Sg7U9CFEfsWpAmc4p5+1gUhcdmH38bzWiuKf5qfI36JtIAGEAqWDQaJPox6xlC/UOIEIUPjUMqHAnevpE1OULP0T2+9yuajnmu1x2qnGL0kibALHHJ0EmKhHNzcCADcbcoZTHpVvWhThr1V24jY5rcON8J7FsndqlLsTagnZzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1001MB2091.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(39860400002)(136003)(346002)(6916009)(6666004)(107886003)(36916002)(53546011)(66476007)(6486002)(31686004)(66556008)(4326008)(5660300002)(956004)(2616005)(66946007)(478600001)(2906002)(316002)(16576012)(8936002)(8676002)(31696002)(26005)(38100700002)(16526019)(186003)(86362001)(83380400001)(36756003)(120606002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0ZSQ0NJMUpLQWxaK056ZHdhN0tScTVJQXFZVWgwUkZzNmZXSHFFWTNXM2tr?=
 =?utf-8?B?bWhTZkltRzBGZWFHVWpTYUdPbzJ2M0hkWHBadERWZlBZVithRVlzSjI4S0xj?=
 =?utf-8?B?NGtkZ3J3OUZ4L1poa3Bya2tQa2hBb21ydmpObkhYUGN4eVZFNVErdmxRZ2JM?=
 =?utf-8?B?RG03UjFsYjFGa01VdWhEUERNWHlMUHA0czE5ckRWUFpSYk5MTWRIZUFHU1V6?=
 =?utf-8?B?WllqNWNieEZ4dHRaVVZOOW1zK1dleU96eGxVeVRXejBmTnVvUEpvWTBtNDUy?=
 =?utf-8?B?MVpwbVFoenF4THpnVVdEV2JXSEVMaGJJOGMwMUhXSjE2UDVQaXVtTUY3ZS9r?=
 =?utf-8?B?VEN0WlFWcFh1OS9DWWJmT1EvcTZUeE96SkFBZ09Gd0FGQW1mVis4RGZmTlFm?=
 =?utf-8?B?eWJlUm83VThZSXhwa2xwaFprbGNGM3FpczhkMjNqeUhUZTczZ2ROcXVibzI4?=
 =?utf-8?B?WE5EL2dQenZPY1NURzROM1Q1L24xMWcwQmFMVjViRS9Ib1lLSy81K2ZMaVg3?=
 =?utf-8?B?OVIwNTBuQ0liUC84S1hjZUVUNktkVmlCSlhkZTZNNE8wb2dPa3RNYnRpWUlq?=
 =?utf-8?B?VnBrcHBnalhmK1lOQ3Jxam1wQmhLWkJsOTdCNEVoWG5kRUFtdk9zQ3k3Zzkx?=
 =?utf-8?B?UXBsMVd4VUdrbkdFQjFLL2M3V0lESmRod0N1clg0ckxVd0RoYXJnUHMxWXhG?=
 =?utf-8?B?OG56NGdtcmo4Q0srTHRqMUJ3WGVpWkllK2tJTVhuZis2T3FRM0dtL1I5dGNy?=
 =?utf-8?B?cmVWUDZuZUl2b0Q2M096MVUzM2prYm1xZ1k3enF4clEyQWVxNldxeXM1bGll?=
 =?utf-8?B?eEozUHNWMFRGSjRER2JDTzdkTkFEYkdJK3RLazRLeDhyenVoczRyaVpkV1c3?=
 =?utf-8?B?RHY5TG82Ujh3WEREbTNjdmJBY1FvcFVjV0YrZXFtTWg5cTBUSTJpR1BDQ2tH?=
 =?utf-8?B?bncrOVFFRWpETC9ocDk5cVRjVFZxTXlOcDk0VVNnUlpnbHY3aXJsamZaNUVK?=
 =?utf-8?B?Wkdyb0hJN0NrUUliczlMUjEwNzJFTmF0S3ZtTm4yMUJrYjlnNmtoSFV6SStF?=
 =?utf-8?B?Z2MrU2l4ZjVENDNtVXUrYjdWb3gra2xsSHBESnAxTC9YMUJSS0RJUWwrK3RR?=
 =?utf-8?B?VTVMbGlhVktsMkZUb1VwQlZjYjFjVTVWZUlJeG5uYmtveDBSRHE4ai8zd09m?=
 =?utf-8?B?TW1GcHdHMUhVbjF4U2drL0JUWkxuUGNFV09RTEZaT0pBMXBYU1B6RmllRGF3?=
 =?utf-8?B?WWNpOHNIK3N0TWQ5Vm5DTGlpcEdQUExmT28wUUt4cVo4QUNtb3U0SndzSWNq?=
 =?utf-8?B?b3RqUFpqcDBxdERNTkc2VEJRdXdyYnFnWlZYbFozRjJIOUdETFhzSUE3ZWtn?=
 =?utf-8?B?Vno5SVQ0TTFxTWFCMWZ4U01DdVdVRSttNE5SRlprT0I0aU5BZ2FENzloUldT?=
 =?utf-8?B?Q1VabmdoUitObm9TZnMxd3VINXFpcE1OZ0kzdU5XZ2l6RnZtUWY3a3hDcnY5?=
 =?utf-8?B?V0FTMXVGeFppU2UrRTQ1Rk5vbDdGM2hQbCsxN0l1QUV6Mml2Umd3VjhyQkJQ?=
 =?utf-8?B?SWZNM1p2RHVudEJxOUp4QU9yVkZKdDk5aWdtRVlpa0plbVFqOE5NRzN1RkI5?=
 =?utf-8?B?UVFNZHNlazlFaUQ1Y3R2MjRTaXJzaVNnUVNJYW1nUnduc0xraWZ0NExHSTMy?=
 =?utf-8?B?NGhVaE9ocjZBdE11akZubExVMHErQlNPNmltYVlIKy9xUTZZMzZycmoxWW5C?=
 =?utf-8?Q?fK/cYu2IqIqnXgCqBLYonPtgOt8R636ABPuJEDs?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0497fd-3439-49a0-d95d-08d9309a81ae
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1001MB2091.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 07:44:00.9871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: la1VFrZShcd+LBLBjzWKEcKi5Ipy8axa4kLiqSAMHlO5E3I9s5kCMCQVD8qaXpsLVl8yvKvpsScdlb2tb0g8p5txMMbq7HXs3ojTlG5qB5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1818
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10016 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106160044
X-Proofpoint-GUID: Ht8NgHsK1hC_AoPQEtpaFC6-NDvTMxTH
X-Proofpoint-ORIG-GUID: Ht8NgHsK1hC_AoPQEtpaFC6-NDvTMxTH
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/16/2021 1:00 PM, Leon Romanovsky wrote:
> On Wed, Jun 16, 2021 at 12:22:13PM +0530, Anand Khoje wrote:
>> ib_query_port() calls device->ops.query_port() to get the port
>> attributes. The method of querying is device driver specific.
>> The same function calls device->ops.query_gid() to get the GID and
>> extract the subnet_prefix (gid_prefix).
>>
>> The GID and subnet_prefix are stored in a cache. But they do not get
>> read from the cache if the device is an Infiniband device. The
>> following change takes advantage of the cached subnet_prefix.
>> Testing with RDBMS has shown a significant improvement in performance
>> with this change.
>>
>> The function ib_cache_is_initialised() is introduced because
>> ib_query_port() gets called early in the stage when the cache is not
>> built while reading port immutable property.
>>
>> In that case, the default GID still gets read from HCA for IB link-
>> layer devices.
>>
>> In the situation of an event causing cache update, the subnet_prefix
>> will get retrieved from newly updated GID cache in ib_cache_update(),
>> so that we do not end up reading a stale value from cache via
>> ib_query_port().
>>
>> Fixes: fad61ad ("IB/core: Add subnet prefix to port info")
>> Suggested-by: Leon Romanovsky <leonro@nvidia.com>
>> Suggested-by: Aru Kolappan <aru.kolappan@oracle.com>
>> Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
>> Signed-off-by: Haakon Bugge <haakon.bugge@oracle.com>
>> ---
> 
> <...>
> 
>> @@ -1523,13 +1526,21 @@ static int config_non_roce_gid_cache(struct ib_device *device,
>>   	device->port_data[port].cache.lmc = tprops->lmc;
>>   	device->port_data[port].cache.port_state = tprops->state;
>>   
>> -	device->port_data[port].cache.subnet_prefix = tprops->subnet_prefix;
>> +	ret = rdma_query_gid(device, port, 0, &gid);
>> +	if (ret) {
>> +		write_unlock_irq(&device->cache.lock);
> 
> And this patch can't compile. It should be cache_lock and not cache.lock.
> 
> Thanks
> 
Unfortunate typo from my end. Thanks for pointing this out. I will share 
the updated patch.
