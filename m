Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D449B3B1AAD
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jun 2021 15:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhFWNGG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Jun 2021 09:06:06 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:49202 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230170AbhFWNGF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 23 Jun 2021 09:06:05 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15NCvjH2021469;
        Wed, 23 Jun 2021 13:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=IaQXJfkzW6WBuQiGqEsSZuU8f/rLMPRfde2SzgZEkDY=;
 b=dBoW7bS/lN+qkETmFNb4IFewxRwOBJ0JHseAFkMk64mYJZ1rW+kY3RfipdikoOLKV0i9
 f/vJS3+CmWSU2SUaLuZWDXdP5TnxfUAukJgmcEHCLZl0UerJ+Oe2Zsu96d42Z/vZL/dy
 EG02VvkLgYP5Cl0QXPbyJ9inxIWgEwazujdB+rPyOBHcrTd2DLZlMwOnsLarvMuPMjD8
 fkCb10UhXsNzl03zpTsaRUGmnuEY80jO8VS9cZ9xcSxVM8Rpow+m+ZxlmSrDOrV+dnrq
 2ZaWgmBqO/yWQ+A93IUR5BfWKSurCsUquivgPfRFx37diQAd8E3LNdFQHt+UaUTg3YGs Dw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39ap66nvm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jun 2021 13:03:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15NCthVh193825;
        Wed, 23 Jun 2021 13:03:43 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by aserp3030.oracle.com with ESMTP id 3996mf3jxy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jun 2021 13:03:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FoIeLIO7tnxULt8fDfbv2KOFD2g9FTmB1F1aO1MaJl1GqWmG4jrhjqE49sOCQ6lomowrvpAYY5ZkAHYv0weJ1pgpl8oO5eFHRC1YAA8MS0lXr4fz3YOytmSxsnqZMrynVjo+91Wqfths7+IyHCx96WklDg7i7Bgk2CyysyR20QbHTOOP8/iOWmtDWWZeVGWDbVjrlu4ZBv45LMScj/mlayInqlbDmt3BP1PBZEgdpX/982r99KxLAs5njfVmI0ay90/qE1mecl6tO46FSnZ6Kuy5k84Bpjk7eFQeHkamFPYtMEtwvv4PRpzwsBOntfLYc8XeR9H466/hspJJ4J0qLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaQXJfkzW6WBuQiGqEsSZuU8f/rLMPRfde2SzgZEkDY=;
 b=FKhDqA2qD2NgAnxxleiN/wSokUcT5KAfqHAcLY5SSRvLN8gHkgoPJNyv3PmR0VGF4pXK6yXYJ0lE/kvs5nqG2zyeUKoPpzDCGNzA7wjbPGZ6cgYHuk4PXsa5+bo7M2KsxOPeUI/5SCdwt/NSYXg5iTzcBQu3z7DtFp2yLMU1WSvfkAfMESAgFnn+M//+mkY5ilnGn+HRdgqQvdGdP23eHCMJdrhPziFW3SLwSUdavah2u7JSlmqQRmDfyFYdOba9wR5oF2mU2IVJ9lCvBlkit7+Q9sg+B8spd0+rrnc9Dom/rDF55z7c71FS4w421wtAr8uSy9Kyls0+iBl3cBGt3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaQXJfkzW6WBuQiGqEsSZuU8f/rLMPRfde2SzgZEkDY=;
 b=tk639vJ9L5S/LyY+yA4ekN19gFjiIi29z1uZ2f3uk6zLZnrBsAq/+Iq2kP25pmN1Lh812ki8hBn67jHqm7SOFtOLbjhOLRZimtCbwpFGfx8W3qInpWRVjJ+RiMMZdqYVCUJATY+wqfsBWczLtqslUuMphPUA0dDPbIrC+ejIi8s=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 (2603:10b6:910:49::39) by CY4PR10MB1608.namprd10.prod.outlook.com
 (2603:10b6:910:9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Wed, 23 Jun
 2021 13:03:41 +0000
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::f0bd:a675:51db:804a]) by CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::f0bd:a675:51db:804a%5]) with mapi id 15.20.4242.024; Wed, 23 Jun 2021
 13:03:41 +0000
Subject: Re: [PATCH v5 for-next 3/3] IB/core: Obtain subnet_prefix from cache
 in IB devices
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        dledford@redhat.com, haakon.bugge@oracle.com, leon@kernel.org
References: <20210616154509.1047-1-anand.a.khoje@oracle.com>
 <20210616154509.1047-4-anand.a.khoje@oracle.com>
 <20210621234913.GA2364052@nvidia.com>
From:   Anand Khoje <anand.a.khoje@oracle.com>
Organization: Oracle Corporation
Message-ID: <012d6cd2-5167-ed81-80db-444fd2741ea8@oracle.com>
Date:   Wed, 23 Jun 2021 18:33:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210621234913.GA2364052@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [122.169.19.215]
X-ClientProxiedBy: SG2PR04CA0164.apcprd04.prod.outlook.com (2603:1096:4::26)
 To CY4PR1001MB2086.namprd10.prod.outlook.com (2603:10b6:910:49::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.8] (122.169.19.215) by SG2PR04CA0164.apcprd04.prod.outlook.com (2603:1096:4::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Wed, 23 Jun 2021 13:03:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1988aa28-f59c-4a07-c7c9-08d936475329
X-MS-TrafficTypeDiagnostic: CY4PR10MB1608:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR10MB1608087C09D9F3829A4BD5AAC5089@CY4PR10MB1608.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n5pzc3DjBi4BZWMaxBfTua6HRT0Z7IaHIEyb/nq1P3PpBee3+vjpGWudCcbwZL2HBp3NCAh9eZJ7/WirtpiQr/w11/9jNHuvj6Dg9dJPslgWZeUyoD+qguUEFCW/MnrbKx/8Y8TzvtTvSgmXTyS6HV8LZja5mrRZrDJRvXqHZFSxSQ94HcWsTvzCZdJa89V8r2bDZpaW2+w2uSjQiY1qh6SFt1Fpxpp86hlCSKxIlaNrF82R0lFW3HSAMckACRYOxdpUOLjroFu4VJsFD0ZeDRv6b6IHn+uyVXYTXOxGrnnOc6WafmsA1y85Feq7/n+9+NFh9ucLiqRHMTOZQgUfdQ/umT9NzUCXdUu7QEqeUNPVgPv+57ySXrDSDWeJZLsBgbIYgMQRYE9/MAtPxFe902kSsD74Po7GBT/LMy8JIzhmjUwICHnwH2lGE4ohEXa4tEnDDZpEnnrAfLkeEVeINtj9Z7QsOtPnQJSY7lu7zjDO2Q8Wxet6emwzFFbEj24sXhYMH/p5YVHYGRXi3cNOieO+4DY6WE0vQTIaBDD0inus3p+r3/Xr5pFQuOTwVISn/yxMyQTCHHAFUtYSba7AOVN20Dw2l4NqjCWPNZSx9FDlDZokyCt8Fw86KRtIpm4HNXZ/LpRjy4iCArMIVnU5h4tpYrdHpd7LrmYVVQwbFLO6qRchFC+txJ7/PRLldj1o7trgUjUZLakROXY2v2O/rsmZ0WOGQU5CBjf4p9KOR1JpPV2Rc8CobrsrIxEvdidlNJ4WiQU0+F9TamBA2HAYa81D9Xxnw1krXJyd9LD4bYf8z+alG45nfi8uwxAiavia0DbOFqIx2lu+uV0u0eKiRoE2n8kXNU6fzt2m1TT05TQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2086.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(376002)(346002)(366004)(136003)(8676002)(26005)(38100700002)(8936002)(31686004)(16576012)(5660300002)(36916002)(6916009)(6666004)(36756003)(316002)(53546011)(2616005)(66556008)(66946007)(966005)(2906002)(31696002)(478600001)(6486002)(16526019)(186003)(4326008)(83380400001)(956004)(86362001)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjZpcU0xRGhqaHA0YlgvZ05EUHBxaWJlMXhmZ1lwMVIxaS9FMURpcjczSzI2?=
 =?utf-8?B?ZEVLcXFaK3Y2ZHhaY2F0SFpsc2hvN2p2R0pPcXl4Q2k1NHdpNWdnb0JmRlh0?=
 =?utf-8?B?b3JNU3N2N3dLblI2M3JDOU1GVnliYURDaUNJd1l0Z0dHWEZVUkpHaUxkRjgr?=
 =?utf-8?B?K3JoRmxlN0tYdC9adjN3ZG1pZUFCK3JCamZTdkZUZnJBWU84TzVNN0drMkpx?=
 =?utf-8?B?bGw2Q093dXdIVm9IV0lTYzh2Y2pBUkVEL1dKOU9VM1hFZHp3Q2tqSTRLdU5Z?=
 =?utf-8?B?UDVoNktIU09WaTJvZXF3VUZjT0ludlAwSWpKcGVRK1lHWVlFS3dwVGh3TlBO?=
 =?utf-8?B?SVBTeFNqWFZrMXVhdzZkYnpOWDZMaUR4c0ZDSUM5MFU2S2EyV1VjTmx4VGJF?=
 =?utf-8?B?OEFibVM2c2U0Qk1CbVhnTnIzQnBUZGNTNkZvKzZUeHRBdUF3V2Vxb3hPL3pk?=
 =?utf-8?B?ZGJmc1pQZ1JnVGRxQVBoZW5ibUNJZSt4WFZnbHFiMXBGdkRkTjBDcGQxL1FH?=
 =?utf-8?B?cktmUjdrWVBRUlZtblFwRW1JTFF4YWtPSmNHeGs0bWtUTDJmRmZ6ZlB4anJp?=
 =?utf-8?B?RnV5MFBwNSs4allIY0hIdVRqTk5PQnR6QnlYOHpXeFNrS25rSVVHR1VHQjVh?=
 =?utf-8?B?ak9qNFdEMVJFcE5rN1pNd3BMa3dEeHplTnA3WUVRaUUyQm5RbWxxZ0dXdCtB?=
 =?utf-8?B?OHNGcEV6eUEvdnlkWnNLakw3aVFES2ovNUlIVE90N3RGd1BJN0M2dFc4dWYx?=
 =?utf-8?B?eTEzNVpVa0pQUS9CTTNrb1o2K0xaczBRVXloOGFTRjBkdWE0M3hSYVNQak5z?=
 =?utf-8?B?V3RENEc1cWV0N2Q5TlFkRkN6QkJOS1ZhVUd0VHUyMGp4anc2Q29MVWJzTGxs?=
 =?utf-8?B?S3hTUmE1U1lmLzMveEJiSXEyM3dGa0JGYkhxT3ZVV2VXOHFwYWZVTEtRcDNQ?=
 =?utf-8?B?ZTgzZm0yTzArbmFOYTd3Vmt5VWRwSVVKZkl4SGZvallkSGk5eDQ0Y0RVMGZq?=
 =?utf-8?B?eVpiR1dWbmpybVplbU0rTjA0M0hRRDQyOHVjd1NvMWxVa2kvc0VzcUFlYXAx?=
 =?utf-8?B?RzBDVko1aUZPbVJQaDYzWTZvc1dFNTV2dW9vN3VURFdwYzYwU2FQYkZWMk1V?=
 =?utf-8?B?ZjkwR3JvdWUvOExzY2NvUERMZjNMN29POUkydGQ3UlFNN29WVFNzZXF4bnpS?=
 =?utf-8?B?am56ak15aDBGVnZQNitzSFhqQ2ZHbklYZ1c3Qk8zcXNZSXNlTytpdjhiaFpn?=
 =?utf-8?B?bWVKdHJZWVlPL0VuWjhVRWUydDlWazBxQnZwMFQ4OWFFTy9zaGtNbkVuZTJz?=
 =?utf-8?B?bVgvdTdWUmxYSnR2OEdJaXZBQlBmT3VFTlVXTkhQbzBmZFUvb01ZSnNYaFQy?=
 =?utf-8?B?b056VHZqT3p3Um1tRUtWaURpbGc4QXFnMkxjVGpseVVqaUhWMHVOakxYUi9h?=
 =?utf-8?B?U2FVLzdWTFQ3cHY4dDZoaE9Sc2U3RTdXVVkzN3dpUUp5NlByZUVNNHpPeVQ5?=
 =?utf-8?B?VmlCMXYvZFJaZXFsSTF0RWpmckdITWlqeWNkSldLTDBtaElaTnlkUE43MFZC?=
 =?utf-8?B?Snlqdks5ZGZUdmVLSUV3STl1R0l5L256WjlQVlF0WmVCbEVXTVhvMytpTTFE?=
 =?utf-8?B?R3V4dXhQaS9SNHRSQTZHQk1MbW4zS21uTWh4Z0p3RlZsMmV3WmQwSnQvWExz?=
 =?utf-8?B?REp2RWgwcEtBK1MwdTNhWXErcVR5ek5hbVhVT25lTHhuTGNXSnl5Z3pQczZK?=
 =?utf-8?Q?PB2g2xZgtm83a4/X6ViwurjTH0W5WRZZjc1XPWx?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1988aa28-f59c-4a07-c7c9-08d936475329
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2086.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 13:03:41.7259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U9V8KO35K70yUn6+n8wZo7u+jYOJy0lDt3Vh1lZnUqx06bwrsJtlmiHwpt+Y21JAppT1EL0ZN061uDyyIJoDA01wfn7DlGj6+wrHvbwL+wk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1608
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10023 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106230075
X-Proofpoint-ORIG-GUID: zRAQEiOTqvMe9dP200qkAilQmUO0oSiE
X-Proofpoint-GUID: zRAQEiOTqvMe9dP200qkAilQmUO0oSiE
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/22/2021 5:19 AM, Jason Gunthorpe wrote:
> On Wed, Jun 16, 2021 at 09:15:09PM +0530, Anand Khoje wrote:
>>   
>> @@ -1523,13 +1524,21 @@ static int config_non_roce_gid_cache(struct ib_device *device,
>>   	device->port_data[port].cache.lmc = tprops->lmc;
>>   	device->port_data[port].cache.port_state = tprops->state;
>>   
>> -	device->port_data[port].cache.subnet_prefix = tprops->subnet_prefix;
>> +	ret = rdma_query_gid(device, port, 0, &gid);
>> +	if (ret) {
> 
> This is quite a bit different than just calling ops.query_gid() - why
> are you changing it? I'm not sure all the additional tests will pass,
> the 0 gid entry is not required to be valid..
> 
Hi Jason,

We have opted for rdma_query_gid(), as during ib_cache_update() the code 
calls ops.query_gid() earlier in config_non_roce_gid_cache(), thereby 
updating the value of GID in cache. We utilize this updated value, 
instead of calling ops->query_gid() again.

  	I'm not sure all the additional tests will pass,
  	the 0 gid entry is not required to be valid..

To get subnet_prefix __ib_query_port() does indeed obtain zero index GID.

https://elixir.bootlin.com/linux/v5.13-rc5/source/drivers/infiniband/core/device.c#L2067

>> @@ -1629,6 +1638,7 @@ int ib_cache_setup_one(struct ib_device *device)
>>   		err = ib_cache_update(device, p, true, true, true);
>>   		if (err)
>>   			return err;
>> +		device->port_data[p].cache_is_initialized = 1;
>>   	}
> 
> And I would much prefer things be re-organized so the cache can be
> valid sooner to adding this variable. What is the earlier call that is
> motivating this?
> 
> Jason
> 

During device load and when cache is yet to be updated, ib_query_port() 
should have a mechanism to identify if the cache entry is valid or 
invalid (uninitialized), we have added this variable just to ensure the 
validity of cache.

Thanks,
Anand
