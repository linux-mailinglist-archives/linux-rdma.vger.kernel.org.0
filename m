Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771D73BC71B
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jul 2021 09:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhGFH2m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Jul 2021 03:28:42 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:53696 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230262AbhGFH2l (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Jul 2021 03:28:41 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1667CBgC015871;
        Tue, 6 Jul 2021 07:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Qfbc6X2e+ubVLsUz1joyB62/5wNgEdJ6+Q0jXuURUwM=;
 b=DYM990wQo1ilFV8PWcgw3yAO0DtindX8DwM2XIdJB267pTjFR75LX3VDXsCCQLvVdAde
 gyr9DWdzR5UhEn0GteQdnpDT0stBObpKss5Ciq6bJel1cB2JXq2BCbrjfiUB55J5h3nB
 jMnoQqGuw/G2wFMpyktzrqixMPyLMlVEePM37zggz3JBjfeT3KxdSFjPBumvO2X5EpRA
 +PRcdWz/JGPT+HrITcbgzNo6QGyp5Zg16JR4uIjxYvlRokv6OOfwdZnjVQ+0+3O66+KZ
 S/Pw9pwqZCxzAl6kZAynI+W5gyA6PBTfc9apGRBcTUGzGEQji106IRBTpEBb4Cb2Qx2U UQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39m2aa94x7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jul 2021 07:26:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1667G5tX194187;
        Tue, 6 Jul 2021 07:25:59 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by userp3030.oracle.com with ESMTP id 39jd10ue29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jul 2021 07:25:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dylYubE0Nsi//OSps0sJKQuaKmndoVrU34lUHYAZp+aNLojpFg2bl9NBwAyd8YJlCCP3SXLpaRiF6KomLhhi13Y5tR41ssO0x1GF4H73ptx7/ap7plZ7O1+le9R6zISL2xcZlLy4j/x88vixpfP74AOW12QaKhm5SJsdsschpyt93BFGTMyz9XUAhmyd1IECI+nxPpIrfsu6E9RYTBUYGE2csOjQSK0Zr80d9TQ8+YLYTf+t1NaAngH0Qu6BiApIUXglHD4HkUQvWr8Pxvr53c5W+4hy1+YIeHeFF/wAdqhL0KIQ8m7kHCPfv3WJQH+7Q36GazaruaPAfCOrOLtTow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qfbc6X2e+ubVLsUz1joyB62/5wNgEdJ6+Q0jXuURUwM=;
 b=A3z49U4Zt12BxeQXwC4LlpMt6UkfiwR7eKsxKCSjNrMZIwpqH55UagcoSyB380xv1jUcj64ghpwfjCSBVke/sx4H4HnD+7z8S3kTk0iaFsFe/5CuHXyDvVZZKNDXmh3dedCKsTm92qJn7dc6Uefv2TnkeEkiBlvX14yBxV3zhcWuKpOUxGkOyEyycD4kupEXeEeUeB7WHYF7pKLzd2z4InwZbFn2womf2JzcXwR8XDe8vqdbhLvPNTGM4+8gUIbMOT4sfjQgTppmc2DIBLjIsWmCn6NgvJtomAquGHkos1HrnzDqglnWSFslA/QcxzOUUIaG0H2NcjX8ExBEOoCYXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qfbc6X2e+ubVLsUz1joyB62/5wNgEdJ6+Q0jXuURUwM=;
 b=xPD6+b1EYiYftJoyloNMakFc8Sjkx0pcDz5rrGSRNUsJPc+ejx0c1Q42H2D0SyT1Ok/PRdRRdRLsxrhDAc+fdaOzmdiEQ+RTwHLhuPqFuI2nzOWkcpIwBu1WgQu24FbBuWXpvhgfMEKtkk8scQZJGVLg6q+Vjc+twZr07Ow4ZLQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 (2603:10b6:910:49::39) by CY4PR10MB1397.namprd10.prod.outlook.com
 (2603:10b6:903:27::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.27; Tue, 6 Jul
 2021 07:25:57 +0000
Received: from CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::9dcb:26d6:7408:b4d5]) by CY4PR1001MB2086.namprd10.prod.outlook.com
 ([fe80::9dcb:26d6:7408:b4d5%6]) with mapi id 15.20.4287.033; Tue, 6 Jul 2021
 07:25:57 +0000
Subject: Re: [PATCH v7 for-next 0/3] IB/core: Obtaining subnet_prefix from
 cache in
From:   Anand Khoje <anand.a.khoje@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dledford@redhat.com, jgg@ziepe.ca, haakon.bugge@oracle.com,
        leon@kernel.org
References: <20210630094615.808-1-anand.a.khoje@oracle.com>
Organization: Oracle Corporation
Message-ID: <309d7800-73a3-41c6-542f-cdcb5a72e969@oracle.com>
Date:   Tue, 6 Jul 2021 12:55:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210630094615.808-1-anand.a.khoje@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [103.155.226.255]
X-ClientProxiedBy: SG2PR06CA0144.apcprd06.prod.outlook.com
 (2603:1096:1:1f::22) To CY4PR1001MB2086.namprd10.prod.outlook.com
 (2603:10b6:910:49::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.101.8] (103.155.226.255) by SG2PR06CA0144.apcprd06.prod.outlook.com (2603:1096:1:1f::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Tue, 6 Jul 2021 07:25:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0680e14f-c833-4e94-d573-08d9404f4c30
X-MS-TrafficTypeDiagnostic: CY4PR10MB1397:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR10MB1397E396A43303C7ABB838D3C51B9@CY4PR10MB1397.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +te/nWnINo96t+cu9FE76kVgt/8TuyJP/WMIm3iHnKyLK3sDA/ooq2wEzjgGaSZltuvLmyGZp7mYLIQhROp7n37CgBip5cE1qG5Y0GRiXBu+U8cFRCtxU2U9mYStXRYOTN7MgD8tM8yQa4BfJz+Q0uCSIsUtBAr6rdc3r31MSjuYLH+cKgLhsPj7SUxQBiX9iNT61SSufnVtqHrURU01Cw5IpVqrUdIhK9siYwAhQOhVIQhPhRN4rVimKSovaLGlcEBAeCi/FIRtgLn8nuhZsS7lndTU43ICZMBPujvr3YSWTudLR4hmbhx0r2xEzQ5R9RKmJJY/48PjjjWq6bco8N6seJqwqyWgnxJOXXOTAKmSY2Ywq+ABffJx16stXJyrE3eEZtPgUcmuu1MLNK0Q+7mQNpHQgqdcYA4uAIg5sXId4HwWUiqcpRoJzj2NxNWzdC2Co0sxMGU48jjdUfnWL5kCE6YqCBQqZPsMqCIHcroIHjT2S5kkda65xK9VzplMYaQsvFanYqEoa8/OV1jP8QF7Pw/4Tv1bzxvQmw5C/+ylCqXFMHDaWMnOzQrHd96q6Qp2UtpvEIiNzmj7naNYQIVJwkZ1BFtJGaV7eOKJSyWAP89N1GSLvq4IvKJyWOf8vImsn2c154m8NljMCS3y+Kw1sEfeaqsJXoAw7jUR8Uu9Sjgv7ilE537QkD0Cd5fqv7B7dWefDPbyYM3kXA+3PE2aCTa8tMpOHyW9fPMyW6A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2086.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(396003)(39860400002)(376002)(16576012)(86362001)(38100700002)(8676002)(6486002)(4326008)(5660300002)(36916002)(6666004)(316002)(83380400001)(66556008)(478600001)(66476007)(31686004)(2906002)(26005)(31696002)(8936002)(53546011)(2616005)(956004)(36756003)(186003)(16526019)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHppRWQxT29kQ21IZnZ6bHVYa3dZNmVrVWdiYjZHRVZpNmxNVnluajN5WmJF?=
 =?utf-8?B?bnJHY1RlNHp1WmNQMHRCMEpzcEhMVVF5SlN6QnFCbTBCaE5rbkpJUjBJbEhC?=
 =?utf-8?B?ZzZyVFlFTFB6N0QwbEthTnVnOU9CdWhIK2FUa0JBYU9LYWFreUtSY0FsMGh0?=
 =?utf-8?B?UmZmcVVpdXN1UjA1RXZMVXFKczBTMVJUVUxOWjJ3bnJldEQ4UHQwcFZUM1pp?=
 =?utf-8?B?aDYyZHVRNHE1cnlHek5melhRczVqS3VYcFlFVEpXb2psMSs3TXVzWHdvU1Av?=
 =?utf-8?B?Z1hNNnY4b25oaWVWWXZsTkVtUFlQeXhFT3NTVlhvYXVhcm9ERW9UeVFMcVJy?=
 =?utf-8?B?cW1CTlpKakY5c2F6WmxGVEdGcFZrMmcyNmw2WlpYTGNVU1h3UGJpL1ZhYzdF?=
 =?utf-8?B?Z0xEYkhVQkNLTnk1SFF6OGZIVUkrMXFTb2NiM2lXeTNXRHIvenJHbWRQMWJx?=
 =?utf-8?B?MHBnak1jRTZTVlcxRm1JS3cwN2JJRjlLL1A4ejJWS3l2MTN1cnQ1M0pqVito?=
 =?utf-8?B?K3JTVi9FbFBlVDNwVUMxZ211enNQLy9wbDJ5T3d3WVByUncrMmNQV0xmMWtp?=
 =?utf-8?B?cWtxOE83eE9ZN1BVN0pkbnpyblVkcm1Gd3NPR01lV1BIdnE1czFvanlzc3Bh?=
 =?utf-8?B?K29SRHJqcXllbkkxdmIrZkpDMmM4RlJ2ZW5vdVVBNGpERm90M0hoaVpJZ1pS?=
 =?utf-8?B?SlFZYndHT0ZHdXVjbEJ3QmU0WVNzMVZEMVo5QWkyWjVvVUdkZ1p4cStFZnpE?=
 =?utf-8?B?d3ExZWFKckV0TmNaNnJFY21SbzNOSmlRWGgrR3Rndk9zMVdSSHhGbnRKODFV?=
 =?utf-8?B?SXRhUUtpRHptVTl6eENXZllZZ0w3V2ptdmo4bGwyZXZXdzhnRTBKTFdQZ0Z5?=
 =?utf-8?B?RjNlUktDcUh1MU9iLzdIbzdRRnlJc1paLzNINmVNd0hDdUFJeTRVcGk2L1VL?=
 =?utf-8?B?WG1ubFdNZEhkN3FuOW5WWjZCT3h0ZWpkTGtDYXRHN0hmdjdONW1Dbi8xd0pS?=
 =?utf-8?B?M3VDYmxGaDQyZ1hRckl4WWpSQzhQSDI3b3c5clhSbUhLWFlIMCtQQUoySjdB?=
 =?utf-8?B?YjE1WlNOREg0RDM1K3VKVWtwbnMwMHl2Z0hJQ05LM1Z3d1c3T09xSUlqVUJS?=
 =?utf-8?B?ZUcwRDNoMzg0RDN4ajByV2MzWUdTQ1VTV3BDa1IwcTdWM3UrREtYNWZjL2NW?=
 =?utf-8?B?bFhwQ1QvaWFGNHNmdXlyeVhEYmZiODNzeE81eWtGU2lYbGl3bHBndTlYaFZa?=
 =?utf-8?B?TG5WbVQxeW40RlkvYkhkTTdCd29QaU02RWx0anZyc3VHY0NTTkw5NngyMWs4?=
 =?utf-8?B?NnI0R1RUOHVWSng2L2d0cmRScWFNTEN0K2lkUlBMTkxtRlpQWTNKUEJXQkE2?=
 =?utf-8?B?UTFDNjR6eFduWXdyc0E0SXhVVldqakhzMXJrK2FsZGtONFpLbXhzVzBKcEE3?=
 =?utf-8?B?VWJvQU90ckpJRGtsOGhVOC9SK0RlZmtnR0x1T2J0ZEpESGxLTVJFdXd1NDEv?=
 =?utf-8?B?MnVrSTVQajYwLzR0ZW9NdVNUMG1NQ2Z6UDlERDRPVzRla3VqWUpKNmdNVGQ5?=
 =?utf-8?B?VVYyMUtObHB5RkUyTnlWdHROOGlBY1hFTU90Tld0VjB1SVM1RmpNYWM5NjZP?=
 =?utf-8?B?elpvSHpMTitPZG5FUnYyRWgrb1g2eXdiRFNhTVBESDZzZ2IwV0FjZVI5TXdC?=
 =?utf-8?B?YlJHdTZiamFPYTB3N1FabEdiOVJPUTNVQWFMdHFPNmZwclZURnhDSVdZNVJn?=
 =?utf-8?Q?Y9rGyuuybRva4o4fYiHHE4CmtAAujKklTo7JFau?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0680e14f-c833-4e94-d573-08d9404f4c30
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2086.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2021 07:25:57.5957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ry/nrD9C/SiSALuk4NFyBp4UHX5kxdCVF2L7os0QE9LsrpTvlZd70tgPzqlZK7FEw/ornKZ6i57+2viXu95jKz8Ky9gB28fFFpYDJvcfHY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1397
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10036 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107060036
X-Proofpoint-ORIG-GUID: qTRBhSPmQG08czdfeoMk3Zr6XnpIc9p6
X-Proofpoint-GUID: qTRBhSPmQG08czdfeoMk3Zr6XnpIc9p6
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/30/2021 3:16 PM, Anand Khoje wrote:
> This v7 of patch series is used to read the port_attribute subnet_prefix
> from a valid cache entry instead of having to call
> device->ops.query_gid() for Infiniband link-layer devices in
> __ib_query_port().
> 
> In the event of a cache update, the value for subnet_prefix gets read
> using device->ops.query_gid() in config_non_roce_gid_cache().
> 
> Anand Khoje (3):
>    IB/core: Updating cache for subnet_prefix in
>      config_non_roce_gid_cache()
>    IB/core: Shifting initialization of device->cache_lock.
>    IB/core: Read subnet_prefix in ib_query_port via cache.
> ---
> v1 -> v2:
>      -   Split the v1 patch in 3 patches as per Leon's suggestion.
> 
> v2 -> v3:
>      -   Added changes as per Mark Zhang's suggestion of clearing
>          flags in git_table_cleanup_one().
> v3 -> v4:
>      -   Removed the enum ib_port_data_flags and 8 byte flags from
>          struct ib_port_data, and the set_bit()/clear_bit() API
>          used to update this flag as that was not necessary.
>          Done to keep the code simple.
>      -   Added code to read subnet_prefix from updated GID cache in the
>          event of cache update. Prior to this change, ib_cache_update
>          was reading the value for subnet_prefix via ib_query_port(),
>          due to this patch, we ended up reading a stale cached value of
>          subnet_prefix.
> v4 -> v5:
>      -   Removed the code to reset cache_is_initialised bit from cleanup
>          as per Leon's suggestion.
>      -   Removed ib_cache_is_initialised() function.
> 
> v5 -> v6:
>      -   Added changes as per Jason's suggestion of updating subnet_prefix
>          in config_non_roce_gid_cache() and removing the flag
>          cache_is_initialized in __ib_query_port().
> 
> v6 -> v7:
>      -	Reordering the initialization of cache_lock, as the previous
> 	version caused an access to uninitialized cache_lock.
> ---
> 
>   drivers/infiniband/core/cache.c  | 10 +++++-----
>   drivers/infiniband/core/device.c | 10 ++++------
>   2 files changed, 9 insertions(+), 11 deletions(-)
> 

Hi,

This is just a reminder note requesting review for this patch-set.

Thanks,
Anand
