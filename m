Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523D17D61A4
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Oct 2023 08:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjJYG0n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Oct 2023 02:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjJYG0m (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Oct 2023 02:26:42 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8D3E5;
        Tue, 24 Oct 2023 23:26:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJeh4+HU+l2br4E71D+gE2An0FGDUgb8k38kOd+T4odMSSto3bVte5L8PIbZzXxCzWRprn/NrFmn4nxsFNOrwr1ufksugJk9UjxQWS6CSrLAlO2KeH890ZPlR+/hD9pNH9D8V3vmYu08fg3FAIjvPfyS8f9QJ/lH7vTVkG9bh7w5mUjj6BxzeYK5f1dc0zFMcIA+bBQAc8I0Dbx+OIr8dDe51ssMEtHE275qEYfDG9JWiQ19Vt3y63aNzjbMpdrEUm5/Ix89W0eo0GhjWInD3kcH6I1XTmf9c7Ezz+k75RvxQTmQkJdtXG+qN/zAwddzzv8SgZLLxz1s1wENP/XVcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LCSkyvPK/SBZGSSDFbHKUvuoaWQhhIDW2XKKjsINPY=;
 b=TCykrV60xO4PMOaJXNB6Kz/sFRcZjrhck14tih1nNfITGidWljhTtpj2VGQtLj21UQi4cPsnPgF1fCSWc40GUZueXTDKkwXlYPLQtrTYVWJHEGz+mBuSYyYmF8byX6jHE81NquwDxj5eIlQs900xkYF+6xKM6JKf6leXBfdv/t0O8VWtSHaUSucPV4LOlX6gf88UTSBllwg3txuYv4PiM7nRNK0ycCLQ8Vpb2s14Zhbi0OYGXFjoTdHMK5lHkvGw/pK1WsYuX6x8x3hPN2+sHMUtSdtgseDoPFq0z3lPXNJksZHXNw7+NkIXl7hHhb3g6l4jgEmDoan9WfC5utmKCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LCSkyvPK/SBZGSSDFbHKUvuoaWQhhIDW2XKKjsINPY=;
 b=qwNtLxV0hRIyYfoHbBjF2FZtmMFw6nVJyjFe7a1CfgiF2/EpeXSYnbkzMMuJyDM6PJCBGrryArWvGhu3c6+Bai7hd3+34hufYrzne9SlUU+oYHEhQHjSe/2q5loW3NV6LQc87lAdg0fo+RkwMvlFfgNOzOSfFcz6Je0NBLxB6lEpCCSHVyLMGMhEaUlq3fml+TKtCTXlbrjnVgWV1GtIZGBv/K4vw9OcEvSFa85ImBEbAyP4/3GMxJDMQA6xmiapOmYwKrWmRRb25q+BiHr2eXS3ZlAfBwl46hKFdEz+nVcEAf2N+ICsjXIWodt2amShZ41cIpMIam/yBJXwO+sqTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB6660.namprd12.prod.outlook.com (2603:10b6:510:212::10)
 by BY5PR12MB4050.namprd12.prod.outlook.com (2603:10b6:a03:207::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 06:26:36 +0000
Received: from PH7PR12MB6660.namprd12.prod.outlook.com
 ([fe80::1f1d:ef30:13b2:ca9d]) by PH7PR12MB6660.namprd12.prod.outlook.com
 ([fe80::1f1d:ef30:13b2:ca9d%4]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 06:26:36 +0000
Message-ID: <d97b7d9c-e5e4-8352-d805-e7ebcbad80e3@nvidia.com>
Date:   Wed, 25 Oct 2023 09:26:29 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 iproute2-next 2/3] rdma: Add an option to set
 privileged QKEY parameter
Content-Language: en-US
To:     David Ahern <dsahern@gmail.com>, jgg@ziepe.ca, leon@kernel.org,
        stephen@networkplumber.org
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        huangjunxian6@hisilicon.com, michaelgur@nvidia.com
References: <20231023112217.3439-1-phaddad@nvidia.com>
 <20231023112217.3439-3-phaddad@nvidia.com>
 <6a1632a4-28fd-4fdd-b9ff-34dd2f0bba88@gmail.com>
From:   Patrisious Haddad <phaddad@nvidia.com>
In-Reply-To: <6a1632a4-28fd-4fdd-b9ff-34dd2f0bba88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0279.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::18) To PH7PR12MB6660.namprd12.prod.outlook.com
 (2603:10b6:510:212::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6660:EE_|BY5PR12MB4050:EE_
X-MS-Office365-Filtering-Correlation-Id: d271c0a1-efcf-489b-f1e1-08dbd523569f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W/SdR3xJy5AxAdYve5tpf7aA20WRKd4qQk+7ctyuwae4QXTTYEGEaJePbmwWgdKZjKedPdjphfSV0WPmoXLL5cixuPLIYCyzhdfo5cmgMMp4x+UJuvYwJoQcXVojmqcMw5U32PALcJjP9s3lIVrL5Di+uoQCPpGpGosQ/T3jtumOD7FU6yLKiMJ1320zrRMQn7YBGoqlFhxvhzu4HK1SOqTP/U9dXX1RsODj+aDjhI4Ic3VErhlcJm9sj1ujEJjs16b2BhQY4H7TpuvjDhR+3R6AKU0GlkinCLO+ZXTBF2Eh5mwWDis7UDPof+os3p9oYURnJPr9Ta0WRaodTcO8emX6+ui7ofOFqYveR2wynHYMPt8eEuV92lh8DUkjWbcl/7mVXQhae25T+9HUWen2uWMhczK2ZApVeiOlxJrcEQXTPvj+Gzs/llUzGkrXwVSn+gYwwPOszags4XeRNoMHruKU8u/bACco4wuOdj0SwrwENN6geZODJEhTF11ANaRYP6HkIq5S7b6ewOuZXGOIWNDWrmAHQhhRYrgaPUq47qlXhHAAoOGdolWUC6RA5fZxBF8EshQ3Qdtf3Runc5SVQiYu6Nl0pjz0eC30C3nbCWxgwR95EnLSFq90f1jKQB5b4wIUEmi6Ru9NlrwpxwznYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6660.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(376002)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(2906002)(86362001)(38100700002)(41300700001)(316002)(66476007)(66946007)(66556008)(6666004)(6506007)(478600001)(107886003)(6486002)(6512007)(53546011)(31696002)(36756003)(5660300002)(2616005)(8676002)(4326008)(8936002)(26005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkJDaWdYRDkwRmZQRXdxT205eGs1Zjh6TEpHOXl2Qm94V0xvNXd3cnp5bnFu?=
 =?utf-8?B?aTEvUERTWWgvU1lFd2lGaHl0eG40NE8xNHdrRnJkSlRza29SY3B3eVl3aW9U?=
 =?utf-8?B?ck10YVZjNGN0UUtOcHlCS0swY1o0dm8wdW1kdVlvY3JYMHpJS3I1Smhud2FY?=
 =?utf-8?B?SVN0VEVYOS9mTFhPUlM3VUNDZ05UY2FTNno0QTdnNVZ2MlhDWTVHc29JVC9F?=
 =?utf-8?B?aDdFcHBndGgyUytZRmRBQTJBQnBoQ0d2K25kMDF0Y1ZnWnoyYnQwaDh2VlVs?=
 =?utf-8?B?WXVHUGhaZ25wcWViOE1KUVBzL3N6Zk9CWDZGUEUySlh1d0NWTXZBTXYvanB1?=
 =?utf-8?B?Uy8rSzVGbG9KUWhpemc2QlJFUVc2Tm5ZN0I4SllyeXE3cEo4TnNxY0JqQXhH?=
 =?utf-8?B?ZVdCZVcrVUFZbWtneFE1alpCVFZmM2I0eUloeEZNeWJCNnFUaEJOakdPanZm?=
 =?utf-8?B?TDdZV0c2RUloWTJIMUpSLzlaaU5WVmpFK2VTOExON0E2RHhmeEp5eVlXOGFD?=
 =?utf-8?B?czh3OU11L2MxYUF4aGFnYU1TYzRvOGtuaGcyWU1SdGpLMjM0c0lsSWJaVnhR?=
 =?utf-8?B?UTdwaURzaGQrc1BNNHlxRHhRUmZSQUpYcE5BVW5rS05HbzZFVUVKY0VOSGEv?=
 =?utf-8?B?WlFURGE3eDc5Q0dEd0tWQkxBOE0rdjUvRzRqbEprYlNNK1cyNS85QU5qRndK?=
 =?utf-8?B?VEpJQ2laSTZISTNaajhabGY2UjFwSk1MNk5GK01OYlZ1UnBLTXEwUFR2dlNu?=
 =?utf-8?B?cWVRQW5jTUVRd0x5a0VwOElIVURBc01TYmd4RHdmQWE2cXlkU2Z5OTI1SW5V?=
 =?utf-8?B?QkZNS2U3NURCZktoZzhiV0tBcmhBbDFseUkwTEl6ZnlFWklVSmpBT3pnc09T?=
 =?utf-8?B?RnNvMmRTZ2ZyUVF0R2hFWlE5UmZwWkNORXJVdmdRMTFYM2QwQzRWODR2OG5j?=
 =?utf-8?B?cU5XcGR1UVJUdi9WTUdGV05lTWxkTjVlRFRNWWhNdFFNSFV4SitVRm9FRExI?=
 =?utf-8?B?alRLVFJwSEkwKzk4RnRZbTh6cWd5aWRxc0JXTW5Ic2docDQ2TnZVMGNYQWZT?=
 =?utf-8?B?QVVSaGpQaVJVTWdrc3h1SyttOWZ5ZVpDbWxGclVSZzlxTUpCWi9mYTRPQUJQ?=
 =?utf-8?B?V2ZXQnpqS1hCL2ZmeXV0RkV3c0FXSDNvMXAwSUdsZ1Q4WjdXL2NPZThSalBz?=
 =?utf-8?B?QWYwZWh3UFpuMXVkWmRiNFRyWEs4b0YxU0JtcU5vd3UyZktSOUJoWXBBZm1F?=
 =?utf-8?B?dlRtR2xOTHVwK3gwUXJhY1JQb09aZ2dzY0QzSGZTaEhndFhxeHNQcklOOWU0?=
 =?utf-8?B?eTg2REFkK2hCVTEySnZHSjBFSTNLOXRBNUlRNzhEcm9PeDF3RmtWY1hRRkFT?=
 =?utf-8?B?NGh2U1R0S3Q2QXFEbWpBYW0wTUpoRlZSYkpMOWRwS29JME9vRk40NGtNWEg4?=
 =?utf-8?B?NHYyd01HbFNjZ1EyeXJBaDZ6VjJmWkV4a3ZOSU1laDBHQjhRVVRnZElpRFpO?=
 =?utf-8?B?aVZLaEIzTDFhMlFhUFRCVWFyM1pGU00vNlB1eHlEak8xNlB2Wk1oeEVxN25r?=
 =?utf-8?B?K3E3Z01Ua3c5L29tenMzVkVDbnYvY2FkbmxSNlJPUE1YeFJHSFBGaWxVVEtv?=
 =?utf-8?B?RFo4R09FYjhZUDB2U05vck1KcUIycFdYQ2hXZVY5c0Y2SnNXVHRydGxkU21Z?=
 =?utf-8?B?d2s3T2R5S1Q0am1KYWtMNCt4bEx5eU5KZ1JUSFc0ZldtVUtlckc0bFFUbFhX?=
 =?utf-8?B?N0JYbFFkR2VWNENCSk80aVJGZ3dHU21NTkZ0d3UwYVZjZ3Zrd0hMY3hPdHY5?=
 =?utf-8?B?bUttbDBPcDBJOEhuYmtVK0lFMlVUeGxwMlhPRzAwRGU1UHJNVGlUMnRUZjR6?=
 =?utf-8?B?ZUhwQ2tSZ3cyQkFPdlFuMFpkc1ljMFVEY2ZnaFRzV3N2Y0ZLL2dVNlYvcUVB?=
 =?utf-8?B?Nm5SYXc2VWtJMVZRS3dmdCtGMU9lZGh5YlN5U1h2bmR2dmhRSHdtamVKSkFp?=
 =?utf-8?B?MWZvTkw4NWVRQ3NkQmpJNFE5dkJTQWxmRk5TMUlHUGplcUYvYlhtRzhZTlNa?=
 =?utf-8?B?YmRSN2JubWhmWnloeFhHSUdOZUxaNXZPcmxrTXlGbXMzVFZ1WTRXQWxkZGk4?=
 =?utf-8?Q?t0+cz3GnGRAdqHsQbqfXtXAGJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d271c0a1-efcf-489b-f1e1-08dbd523569f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6660.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 06:26:36.0012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AupmIhkDPcnvimQe+EVnqrYM5mgoNWD8OwaBwUW5JFJ75bDh7zRu48VhtiHwrMsTQh3r89MUGXbNUDMReRngQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4050
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 10/24/2023 8:02 PM, David Ahern wrote:
> External email: Use caution opening links or attachments
>
>
> On 10/23/23 5:22 AM, Patrisious Haddad wrote:
>> diff --git a/rdma/sys.c b/rdma/sys.c
>> index fd785b25..db34cb41 100644
>> --- a/rdma/sys.c
>> +++ b/rdma/sys.c
>> @@ -40,6 +40,17 @@ static int sys_show_parse_cb(const struct nlmsghdr *nlh, void *data)
>>                                   mode_str);
>>        }
>>
>> +     if (tb[RDMA_NLDEV_SYS_ATTR_PRIVILEGED_QKEY_MODE]) {
>> +             uint8_t pqkey_mode;
>> +
>> +             pqkey_mode =
>> +                     mnl_attr_get_u8(tb[RDMA_NLDEV_SYS_ATTR_PRIVILEGED_QKEY_MODE]);
> just make it mode so it fits on one line.
will do.
>
> 40 characters for an attribute name .... I will never understand this
> fascination with writing a sentence for an attribute name.
me neither, just following the naming convention in 
rdma/include/uapi/rdma/rdma_netlink.h sadly ...
>
>> +
>> +             print_color_on_off(PRINT_ANY, COLOR_NONE, "privileged-qkey",
>> +                                "privileged-qkey %s ", pqkey_mode);
>> +
>> +     }
>> +
>>        if (tb[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK])
>>                cof = mnl_attr_get_u8(tb[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK]);
>>
> keep Petr's reviewed-by tag on the respin.
will do, just making sure I understand "the respin" , you mean when I 
re-send it ?
