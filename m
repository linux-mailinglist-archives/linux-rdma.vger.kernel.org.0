Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9044A3B3C70
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jun 2021 08:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhFYGGi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Jun 2021 02:06:38 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:46228 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230097AbhFYGGi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 25 Jun 2021 02:06:38 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15P62cmG006128;
        Fri, 25 Jun 2021 06:04:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=8949ZcJ49zPZf6KLzVxb2ZbEcvPU2Gp7n9Oo4pZwehU=;
 b=SdQcnmfFefyMiE3L+4AF4kpVfSkew4gSshUzCtE/FSew4IXAllC3maNT6myBNDeq0p/7
 FOy5mmGtjYw46bCqPy2MkdUO110UoQN6ekJGkQyiS34x/AGAJv8A3kOGgL9sP2pbC4BB
 HmavZ6/D5M3EU0IHFTAIR/4llqQRLrgvGp6RJqYIvFf5bcVW8loFIa4Yv7TpS5qitlRF
 zZI8qe5gaYTlwgCAUabeB8z/TdvZQ/USrAf3BaWdxoVoM1AVyZTcVd5kaw0yCv6s/VEI
 j0H7ce/oLRbIk2R87ZAvzmQ8Q19t3RsfH5S+8PH24lV7wUTQAcdsZZlKPwU++YLtqYhj IQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39d2ahrh21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 06:04:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15P61MgN022928;
        Fri, 25 Jun 2021 06:04:12 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2043.outbound.protection.outlook.com [104.47.51.43])
        by userp3030.oracle.com with ESMTP id 39d23xhg69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 06:04:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRi8CnDTRj1GuY0XE7ty8z5mqGZdkN1tjKRBmScJ1NE0TEIqBBXdqnncBV7HqQu3x26uMRv6vct0TJlRZDhigSUMmWtmWfafLL23PJovQcGn4yS8Y0zU1Rax6j33I9X8Zb/gndaIMF2srFfOqR6PQOM8wX47fYQXiUN8PFJY7WphL/X0txqHHl2qFkm2U6OMFnelVVWSYgJrwwqawSlq/ziB5tfBkgrxOsOZbn1lH810V4H6TqYCcNuvLBmrGwjYjX/0WoMeiqZo/rDHsnGyBWoog5YtPzfojdCEab3aHaicmAFzaJfr3Lv2uzaR2YDpGekpRMvgD+B8kM4ED7c5yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8949ZcJ49zPZf6KLzVxb2ZbEcvPU2Gp7n9Oo4pZwehU=;
 b=FGZhd3kvOMt5fuxh0V/kIo1WtFXx6IhfRqWBX82exlozUytjSfrv4h3zDlBk0yiGVgQ6O8eFX6LPN2WTtydhjzzVx+kdooGARFYrdlS8pidR623PABPfaCyD/kXE36K67mjRM+RGCL3Ze0e/yn05DS8rwTdAemf5osjTPTQaE3UEuWyGESiXhEO4dUR+U5k+OhhSlOu5W/9PMxSsDu/zocwBz4eglrEQU1YmnGPjI0ICXp9Q/X3UfSk/0qWK/UReuktYqIdUojX5rONIa1sfFlR7V1wB5IZemObzqGIm78m1jCRWgJywgS1rD7N5LM+deo/6Ujp6ixS/LZCkJ73yUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8949ZcJ49zPZf6KLzVxb2ZbEcvPU2Gp7n9Oo4pZwehU=;
 b=TA6miVowBfodlp57nnlFhOKwkCFY4qVpfkc3ifw5lCGi58TOJjuIlQlal3PpMXad+oE5FFMkuPgNloVxF2P15Odle2WlCmkG5lIs8+9OzrfzCkuzTdbmsP8FGfTDyS6VtqoIP7eCZCdakmI0UeM0U760Ewi+NLXtU/b06mGsYbc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 (2603:10b6:910:49::39) by CY4PR1001MB2166.namprd10.prod.outlook.com
 (2603:10b6:910:45::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Fri, 25 Jun
 2021 06:04:08 +0000
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::f0bd:a675:51db:804a]) by CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::f0bd:a675:51db:804a%5]) with mapi id 15.20.4242.024; Fri, 25 Jun 2021
 06:04:08 +0000
Subject: Re: [PATCH v5 for-next 3/3] IB/core: Obtain subnet_prefix from cache
 in IB devices
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        dledford@redhat.com, haakon.bugge@oracle.com, leon@kernel.org
References: <20210616154509.1047-1-anand.a.khoje@oracle.com>
 <20210616154509.1047-4-anand.a.khoje@oracle.com>
 <20210621234913.GA2364052@nvidia.com>
 <012d6cd2-5167-ed81-80db-444fd2741ea8@oracle.com>
 <20210624175458.GR2371267@nvidia.com>
From:   Anand Khoje <anand.a.khoje@oracle.com>
Organization: Oracle Corporation
Message-ID: <5fd99709-8a90-e875-1ed2-74f5bcce6eec@oracle.com>
Date:   Fri, 25 Jun 2021 11:33:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210624175458.GR2371267@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [103.155.226.254]
X-ClientProxiedBy: SG2PR06CA0123.apcprd06.prod.outlook.com
 (2603:1096:1:1d::25) To CY4PR1001MB2086.namprd10.prod.outlook.com
 (2603:10b6:910:49::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.101.7] (103.155.226.254) by SG2PR06CA0123.apcprd06.prod.outlook.com (2603:1096:1:1d::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Fri, 25 Jun 2021 06:04:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb1ddc94-502c-4c8d-1401-08d9379f0b4a
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2166:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1001MB2166942CA492A0E2310C0A42C5069@CY4PR1001MB2166.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VxB4udE3GKMh+TzUGNx+tp98yEvT9MimwXMLElPX0PwWOi36F+tc6b2+Je5CI9+AQEim6BvY5Aai8fAqIsLIxcS4Ck1C+pbMcHtZlrFk9xsibf7NdGlk7kOwxY1yTA1HRULrnk8DCHq4uiNMBlI6iNnw7upFqP1klxoWm0+Px7/lUftyqBPMAQGt5T8h5W7yEIH9IsOEHJbu9HdU6+CY6eqrx0hdfjG63Fcmukv9tGCYnSMgD8DYIIfZXkhuz11Rmdr4P3now1mG/5aAz8RqI/HVZ+lnCWaHYxdcaevFagPknevgOXL8egWio7+aHx7OJPpr+GBk7PMXypTMZfDgkKLi79e/wcWTWvPZWrviImc49CPdjNd7ggCZfpioVNQP50Ol7BV5cV7fEjmp/SMuuWX2TWNyeRBrhmMQsZit5SZSJvLL+fU1T6hUtn63jfeBhEYvQ1lGF13EXQHhP7RWpRxhOXVg6InP/UX1fNnH3fvtnM5yeAzsPnObxdE4a0C5Do5lOg+UdD/s+Fflx/I5+/Zu4JVZy2pQv1Es5KFaMvO5rEVO4aTmgGX9D0mTg7dp9wKyJDTMJxsbuA1vqdDsVzuiCLSVkPpIV11XYMy+5rXz9dwD3FidCoG8PCguAIeRzn7mN3pSVln8q3di4DFnkTewxXZrfLXWeIiZMS1tOYaB/dQ7b/iC4Vgr5Lj8R0cj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2086.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(366004)(396003)(136003)(478600001)(38100700002)(83380400001)(316002)(66946007)(31696002)(66476007)(2906002)(956004)(2616005)(66556008)(36916002)(16576012)(16526019)(26005)(36756003)(5660300002)(8676002)(6486002)(4326008)(6916009)(186003)(8936002)(31686004)(6666004)(53546011)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTBZaXc3azFuclNCWi9RUEdKRTg4L2JnZHlLM3g0TWczN29WQkZYb3MyUGJ1?=
 =?utf-8?B?bDZ6L0NlNGFmZWNLNXVYM3lzMlE1N1ZPSUhMcGpoaG5OdlpFZkJleU1RZmNQ?=
 =?utf-8?B?TFlxTjNzZ0FSeVZLSXlRNXdRSUw0Y01MVXNEcHhDMzlsTDlydVV5LzZMMEN6?=
 =?utf-8?B?L0lSZjV0Z1UvdDZ4dmNpMy9nK2FpdGVyN3BNc2dvNHRjWVMxamRnRDNOZWUr?=
 =?utf-8?B?ZXd2T2I0WU9URE1PcUZFZ00rb243aXBzbXhuL2lIUlJieXVkeWp3eEcrWW1r?=
 =?utf-8?B?MmNCNVBLTmozYlh0SEIyQkF1eHQ0ekFkWCszSkNLYnVRc2JhK0ZhM2FEWHZZ?=
 =?utf-8?B?VEhtL3UwV014SHFLTERHVGZOTEpuRk8yOVlKNlRBNGljMEtvZlhpTlVzMWR3?=
 =?utf-8?B?UXV0Y0Nza1lyTXJPWFZwd21IdXlFNnIwanE5T1BxcDBTUktxQnFrSmJjWUtn?=
 =?utf-8?B?aktUNEdFVCtOYWhXNnhGNmgvRTgwNHdpRmcxQ2RZZkpmOURoSlk4TEFnRXNZ?=
 =?utf-8?B?am9LemJ3NTlMYTNnc2RMcTVXa2ZLcUozLzlpU3BhV29XWm9SM2h5ZmtqWWxM?=
 =?utf-8?B?ZWNhUGRyMlJ4R09LNHBDbWR3VkNjT01EakRkWXRzTmQvVXZZaG5EdjQ5VUNp?=
 =?utf-8?B?TTBZNEswQklmNFBURjh3ZEpwR1U2RHhWVU9PeTZrdXQ2TnAxVTJ2aVROSjNL?=
 =?utf-8?B?bVhIeVYyelRPV2tYSXIxa3BwTndQeHowWklleVFOZ2xPUjhyalZLNmhZOTRW?=
 =?utf-8?B?Uy9kQmxiSDZIYjRvaG1UU3greTcrbUlORlcvdW9XL08rWE4vY2s0U0xmMlBm?=
 =?utf-8?B?WExWUTYyNGpsdzZZYWZaMXU3ODdPOGF0aU4xcHUzYmNtUTRhQjVyTDVxRzZ2?=
 =?utf-8?B?aEtwcnpkR0UxMmNUaWFKMm13ZGZDVzBueWNtRGt5L1BKbDViZHF3UnVQc1g3?=
 =?utf-8?B?S0VWTlhkNHV6b1JqQnpsOFVQeGU0bnFUSFBrVGdqRGNKWjQ5U0hrWjAxVk5K?=
 =?utf-8?B?blRqR1MwWm1nWThYamVTcDRaVnlmaFlPay9GRnF1bGJnamdrbzl5ekZwWWZw?=
 =?utf-8?B?MGpsZDdVNmJOTnk1azd1VEN5VkZqME5RYldlTWVMWkNrWlNrb3JCczVrYTRT?=
 =?utf-8?B?QmhFS3liWkd0MGo5cHJ2VW9LRTlkbHp2ZTFGcTkyNzdOZlpHQ0gwMWNhZXNM?=
 =?utf-8?B?aEo2M3ZYSHNVVEMyaDdEZFd6NCtwZFd4b0xHSk1nc3FxK2IzWHhqRVBsRnBE?=
 =?utf-8?B?eDQ4Um1HR0RTVUpYR1dvRytPNXVIM3lERU02STkrN2NUQjJySDFFRDMxVHVJ?=
 =?utf-8?B?YTRvSzZXMHIzck1mYWhoUDAvNVF3ZmxVMnlYTVY1d2ZNalk2bU8vR3lRZVA0?=
 =?utf-8?B?R1YyTTJPY21YUGE0K0J2VHlKWnVkZ2VjY3FvNi9Xa3ZYWWozRld3MWVibXhv?=
 =?utf-8?B?SjFaMDFRUkV4cWcvZC9XbWd1SW9hK25iTjEzYThTM0U0RVNJaW1GcXVFSnNO?=
 =?utf-8?B?L2tqdGhqOTU2Q1RVbTZEeWFqNWU1Um1qOEdnbjBmOGZBd3RVd1NJU2pTYXov?=
 =?utf-8?B?SUV6YWNzQ3F2UXVMbHU1aktvaXpnRDhpbUFqRjBOZVdQSFpLcWNiakVjbzhm?=
 =?utf-8?B?VTZULzNCQUF4Tmo0RGFXWkgwcmdvSElHQkVoNkgrTkNnTkJ1cTQxYUljOUNG?=
 =?utf-8?B?dHEvZWVVaHRuZk1pS0Zkc2tXakNNTU5CdXFoZHpPdVVERWFSMGFQL1lZZEJH?=
 =?utf-8?Q?spoJK16JPuQ0wws1wZtkp+cH0VPCE9gC+8WdrOH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb1ddc94-502c-4c8d-1401-08d9379f0b4a
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2086.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 06:04:08.0466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XjeJM734O0nZVOaZ9Mkf38HdA2arAnvTXlddGF73BqZjMDfgEueXuMv0s8YiHOEi1ehPGSrMlyauwhMO1u/Or7PSKN78j/LGlM8EUmZuYLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2166
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10025 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106250034
X-Proofpoint-ORIG-GUID: zuDSa9HpZEQFmqOql74c4Q8aAN8PCkNo
X-Proofpoint-GUID: zuDSa9HpZEQFmqOql74c4Q8aAN8PCkNo
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/24/2021 11:24 PM, Jason Gunthorpe wrote:
> On Wed, Jun 23, 2021 at 06:33:32PM +0530, Anand Khoje wrote:
>> On 6/22/2021 5:19 AM, Jason Gunthorpe wrote:
>>> On Wed, Jun 16, 2021 at 09:15:09PM +0530, Anand Khoje wrote:
>>>> @@ -1523,13 +1524,21 @@ static int config_non_roce_gid_cache(struct ib_device *device,
>>>>    	device->port_data[port].cache.lmc = tprops->lmc;
>>>>    	device->port_data[port].cache.port_state = tprops->state;
>>>> -	device->port_data[port].cache.subnet_prefix = tprops->subnet_prefix;
>>>> +	ret = rdma_query_gid(device, port, 0, &gid);
>>>> +	if (ret) {
>>>
>>> This is quite a bit different than just calling ops.query_gid() - why
>>> are you changing it? I'm not sure all the additional tests will pass,
>>> the 0 gid entry is not required to be valid..
>>>
>> Hi Jason,
>>
>> We have opted for rdma_query_gid(), as during ib_cache_update() the code
>> calls ops.query_gid() earlier in config_non_roce_gid_cache(), thereby
>> updating the value of GID in cache. We utilize this updated value, instead
>> of calling ops->query_gid() again.
> 
> Uhhhh, so just store the subnet prefix at that point then?
> 
> diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
> index c9e9fc81447e89..5c554ebd000e89 100644
> --- a/drivers/infiniband/core/cache.c
> +++ b/drivers/infiniband/core/cache.c
> @@ -1428,8 +1428,8 @@ int rdma_read_gid_l2_fields(const struct ib_gid_attr *attr,
>   }
>   EXPORT_SYMBOL(rdma_read_gid_l2_fields);
>   
> -static int config_non_roce_gid_cache(struct ib_device *device,
> -				     u32 port, int gid_tbl_len)
> +static int config_non_roce_gid_cache(struct ib_device *device, u32 port,
> +				     struct ib_port_attr *tprops)
>   {
>   	struct ib_gid_attr gid_attr = {};
>   	struct ib_gid_table *table;
> @@ -1441,7 +1441,7 @@ static int config_non_roce_gid_cache(struct ib_device *device,
>   	table = rdma_gid_table(device, port);
>   
>   	mutex_lock(&table->lock);
> -	for (i = 0; i < gid_tbl_len; ++i) {
> +	for (i = 0; i < tprops->gid_tbl_len; ++i) {
>   		if (!device->ops.query_gid)
>   			continue;
>   		ret = device->ops.query_gid(device, port, i, &gid_attr.gid);
> @@ -1452,6 +1452,8 @@ static int config_non_roce_gid_cache(struct ib_device *device,
>   			goto err;
>   		}
>   		gid_attr.index = i;
> +		tprops->subnet_prefix =
> +			be64_to_cpu(gid_attr.global.subnet_prefix);
>   		add_modify_gid(table, &gid_attr);
>   	}
>   err:
> @@ -1484,7 +1486,7 @@ ib_cache_update(struct ib_device *device, u32 port, bool update_gids,
>   
>   	if (!rdma_protocol_roce(device, port) && update_gids) {
>   		ret = config_non_roce_gid_cache(device, port,
> -						tprops->gid_tbl_len);
> +						tprops);
>   		if (ret)
>   			goto err;
>   	}
> 

Hi Jason,

Thanks for the response!

If the above change is to be made, there could arise a scenario in which:
  In case of a cache_update event, another application/module could try 
to call ib_query_port() and read subnet_prefix while the cache is still 
getting updated and the application/module could end up reading a stale 
value of subnet_prefix.

I have a few questions:
- How likely is it that an up and running Infiniband fabric would change 
the subnet_prefix?
- Is it possible that different GIDs in the gid_table will have 
different values of subnet_prefix?

>>> And I would much prefer things be re-organized so the cache can be
>>> valid sooner to adding this variable. What is the earlier call that is
>>> motivating this?
>>
>> During device load and when cache is yet to be updated, ib_query_port()
>> should have a mechanism to identify if the cache entry is valid or invalid
>> (uninitialized), we have added this variable just to ensure the validity of
>> cache.
> 
> Unless there is an actual user of ib_query_port() before
> config_non_roce_gid_cache() that I can't see, don't bother, returning
> 0 is fine.
> 
> Jason
> 

Hm! that makes sense, with the above change we wouldn't need to call 
device->ops.query_gid() from __ib_query_port() and can always read 
subnet_prefix using ib_get_cached_subnet_prefix(), if reading stale 
value during cache update event is not an issue.

Thanks,
Anand
