Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C437D32ED
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Oct 2023 13:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbjJWLZF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Oct 2023 07:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbjJWLZC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Oct 2023 07:25:02 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFACFD;
        Mon, 23 Oct 2023 04:24:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfDBCNoJSKEdBdp4P/bhiVXtYMriLrM8HP5o8qoQD6U10NiJTTOp2GVIDCj4TufpoOTp5qOv8ecbf7XAmnBzj012zRzXladS1HwTIZ+iTTrmXeziwblKR9oJlEYZrQbuABGCdhZvoQJSvgd9SChw/+wLY1jeEdN8WBrSmXofJQGlbvYS3C6IJXY2m/kANPxrLCyO28aBdiNU0T04zdfNGcT3uUQvvLVpU+/z3pK2DU5mimL8lt47cndoeNW9luMKS6BkXF+3K50Aj4fiVYD+/HysqoxRCuRWVoAyPd2Ve5FkI71sd+frkMcTUurSpTd4IYrBXHJ7TqSeV5OwdyZmVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0UkUfOi1Jsz+x8fFtUBasbLgAP6ZOEBYnUptzLGy4E=;
 b=B/lXaNZPyY2kJo6yszMrNlad5VHbohnTDsGy6JtrAOBplbnPa5bkZb/QX+oSza01gUTepKaroEdZye/LrH7f+eaWU0Zn8b/eDqIqEgjFO481e56NGHz1x72mC/lUgPAC7IwbQT6B90L8IBxoLAfE32lQpTAWN6I1nGcfFVQOQ3uB6Q/vR+WUUcI596IOEYGqyOGVw44YqFxacKHP2xCN7vYfPbPMsh7Xx3Ecvuvn53ikZu6jMDSJJCrd71CXst9BPYN1tasGJqw728z+2ix//sbzweABMnGlRtJiSSVe5ZYwGyY+Ky2vrokN+yFR8QuAHboB6tgdg0kpiQZJ79v8ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0UkUfOi1Jsz+x8fFtUBasbLgAP6ZOEBYnUptzLGy4E=;
 b=cUsY+BrQbA8uHuQVgRBMMsdemWl4ORd+ovo/3i61M6qS59yFIfNDHm8oNU8CI8X6UrzDUGDTdYqB5zG6l0Tavro9ZVJNoqzWz6MTuehumyYtl2piEP03vzuimPXjO6234RQOnD2qNvNgV2lk0DE6bpp9p9hhWgupoG0vCjYLpc/DuE0YRq/I2CZcmRLa8gMKjZUbQXCXoFUAt0jSpp2SndVpL76czzElv6YYPtndgcbPiglAVc7lcpaVLTXRG17OnlAAH8T9aeigFKMwCJGBek0Z+rzXCzO8Z5wzsZxtohQuYNQqXedByUSudnjNLwcpt0sbcRI+ZFZHUVmgAWNG/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB6660.namprd12.prod.outlook.com (2603:10b6:510:212::10)
 by DM4PR12MB6469.namprd12.prod.outlook.com (2603:10b6:8:b6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.23; Mon, 23 Oct 2023 11:24:52 +0000
Received: from PH7PR12MB6660.namprd12.prod.outlook.com
 ([fe80::1f1d:ef30:13b2:ca9d]) by PH7PR12MB6660.namprd12.prod.outlook.com
 ([fe80::1f1d:ef30:13b2:ca9d%4]) with mapi id 15.20.6907.032; Mon, 23 Oct 2023
 11:24:52 +0000
Message-ID: <a01b914d-1ee6-4e48-a4d5-d36ad9435951@nvidia.com>
Date:   Mon, 23 Oct 2023 14:24:46 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH iproute2-next 2/3] rdma: Add an option to set privileged
 QKEY parameter
To:     David Ahern <dsahern@gmail.com>, Petr Machata <petrm@nvidia.com>
Cc:     jgg@ziepe.ca, leon@kernel.org, stephen@networkplumber.org,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        huangjunxian6@hisilicon.com, michaelgur@nvidia.com
References: <20231019082138.18889-1-phaddad@nvidia.com>
 <20231019082138.18889-3-phaddad@nvidia.com> <87il72aiqm.fsf@nvidia.com>
 <c7c9562a-5c6d-eec5-3255-70238a13e96c@nvidia.com>
 <bc9f53d2-2d40-4c7e-85fa-cb9835df9159@gmail.com>
Content-Language: en-US
From:   Patrisious Haddad <phaddad@nvidia.com>
In-Reply-To: <bc9f53d2-2d40-4c7e-85fa-cb9835df9159@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::10) To PH7PR12MB6660.namprd12.prod.outlook.com
 (2603:10b6:510:212::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6660:EE_|DM4PR12MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c2dfe58-0694-4f31-8237-08dbd3baace8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BiUEEHWKmI6GHuVL8syB8w5RIvd7Ro0n0DIyrysc+AKPMH9PpdMFeXuhd5pZe9DfUG5/BKKhSPfkLLUbZp/V53EhTJBihuISDhA6ZwfY3r8lNNJjQwasF3Nx0DXp76m6a+ZfgcPuE0jQV4IJxJWqVFVTSn2MfdnR7zQZksPX+XeyorqVdTdVZDV8K7IqGJbTU3i5Sh0ezL2nwg5lpz623guep0FCok9dmvMCcWa6BL22efp6xMb+5RD47zcy+vw0EvraybJOCpLCN4pEY9s8Bz+WGKq0+bE7X0sF1EhLlWSvRqGc58j8m5lZ1RFs1qDvvWiG0/mAqS2hrvo1HdRlLbhzDPmIOl1Q6MOo4tTqVsxKMzE0IyaJVuqKNWZlH3prAHdhgDO9qHC6/tDnZrz+al1qb1YaMJPycxL0RVjSpsS4W/EFSxr+KFTYbcYP6FffYiL4xExhtPYvjm4jHsK4B7isV3XWod9vcbPcGX360GRpQMlqQDwRbrnp8ZC8Gh9eaxY1yVCJh84a+NO+2sJzgGlaTXl1Rd75RiZAddWMyVaO89kFs0R/+Vqjy206dsoFJZs8O1092EYYPGsdgmMJc5QCkf+r6tcVtu1HteZoVjUbhzQxJ63WgB6aal9ntbthiEneeGQaJQdQertivB0izw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6660.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(39860400002)(346002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(53546011)(6512007)(478600001)(36756003)(6506007)(6486002)(6666004)(86362001)(41300700001)(26005)(66946007)(107886003)(66556008)(2906002)(316002)(110136005)(6636002)(8936002)(66476007)(5660300002)(8676002)(4326008)(38100700002)(2616005)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUlhSzBHV1RQaEp4NC9JWUR5bi8vRGJ0K2tHUk5abVVpSUczMHlIdmhBWVFR?=
 =?utf-8?B?SHVEeGlNcjlyekJ2NktmNllSVUZ0ZndWanEwRjNmNnhwL0JjTGliRWFKemtF?=
 =?utf-8?B?VFF0bEp2UFYrZXEvczZCVFVtMGFIYWR6MzNTNEJTSzdnMG9pVWFDam9zUm9x?=
 =?utf-8?B?bUxLeGdBVHVmYVc0NVA0S2oyS0hobVdNUWJLODRVK1BvNzhHMWYwczNXTlZl?=
 =?utf-8?B?WmFqSlVndWhvdDBiZVJnc0EwdnVXeVBMN2MvczN0RjdaTmVUc2xaUjA5Q0Ru?=
 =?utf-8?B?SEJGNndaQ0JLVGsyU0hnTDlPU1FMNm5jMmlPcmc0UGEvYjd5bEhRMjQ0OExX?=
 =?utf-8?B?cGxCbWpsd1RweFJqZkNCYTNvbUx4Q3k3bXJidFAxWTc1RjZwUHB6SU9nTWFj?=
 =?utf-8?B?Njd0ZXcxaFg0dFFkRDdrOEE2M0tDWEwvRk1JT0NnVEFUMlgrN3VwQkcxRmZD?=
 =?utf-8?B?dEE0d21PLzg5aHU5bEQybjR5K2VPVitTV3gwQkJiamptNk44Z1BNckFwcXgy?=
 =?utf-8?B?ckdDaHZxY2dvSTljZlYyaUVYRFUyUHMzT1dIRDZBK1JvaUZic0JpbkRmdm05?=
 =?utf-8?B?YkZ5eWFRL0JvUGxnWDRhb3huSGlyVVJvSi9JNTd6czY2Q2RyMmxXZXRhcFJ1?=
 =?utf-8?B?eTFrWE13Y2IrMzJNL20yQVZNeUlBZW1nWk4xaG00RlhjclFLSE1VZkYrUDlO?=
 =?utf-8?B?RmZQSS8rZlgycDhFamJOR0Jvd0x2enJQdmFKaXpmTXBMYkxvMTVMNTNzMGZM?=
 =?utf-8?B?aGZ6NnRlcTZrTFlqVFRNTUpyOExhVzBxY3hBS1NZb1lPRmxtaTIzUWtIcCs5?=
 =?utf-8?B?cjBOOTl3L1J0TDdVMmkvV3c3OUpkUUNFc0Q2NGtOZC9JMEhHZ2s2QURBaVJ6?=
 =?utf-8?B?NCtVQU41OTQ4TEM3V3RuZWxJV3lKOEdhNnlROGVIS1RKQzBwVVhUaE12WTZM?=
 =?utf-8?B?MDdYWU85aHIzYWU0MnNUbjdoMXFKYWtXYnFQNGEvZGJyelZ4eFdzajJmR1pu?=
 =?utf-8?B?MkpkSFNrdVBZbzVsR3NCa2RLa1YrOWk2WHJBbStENWc0SEVIM2I1Q3crY3hV?=
 =?utf-8?B?ZDNMY3J0anRvOVdIRTZFL2s0UTVnRG5nd1NmNnIwUWxhL09OMzZUNm9iczY0?=
 =?utf-8?B?Wm9ESTV3OXREUjF2VVBJUWdwL1dIdW55djZaTVhLamZPY3pNTTZHZ1Q2Z3Az?=
 =?utf-8?B?blNPMHNKNm9OOWNiL3hTdDF6Y0JuRUcrTmYvdjRqcm1TeE9aczhRNnRuRlA4?=
 =?utf-8?B?Vzl0bXYra1dvQ2dWUVUveUNkd1JYWUU3Rm5OWFRYenJRUHNyVGRCWHhOMlBh?=
 =?utf-8?B?M1VsY2RyYjlUbzI5UmtUSkJ1QmhPSWZjNVpRNGxhRW1uTEZESndWWjBjS0lr?=
 =?utf-8?B?OFNueVZob0J4UFNOM21QSWRpTHFoaDcvd3JvMDA1VTI1d2ZPT1N5bytpMEVN?=
 =?utf-8?B?NnF5am5RNG9OeFdnZ1JqaXU0YlV3dU5DNzRsRUNsbitjcCtPY1loWnMzU3Qw?=
 =?utf-8?B?QWJuVEFjemF3Mjd2aTJSaGtqclhkbDZ4eDRyUXJFeFBpV045OXVBM0ZGSEFM?=
 =?utf-8?B?Ui8yM0lWa3pncDJqcFVKUlZMejhNd3NMT2RvQ3AwN3c4eGV4VTJTWGtLdHM5?=
 =?utf-8?B?WkU5ZEN0cDhrMXA5RHN4UXRUTjhvMUszOTVLUG0wQmMvRGEwV3RmbGRzREhr?=
 =?utf-8?B?UWRCaDlvWFg5dTl5bStSb2lGU2xtakN2MEhPQUNvekk5aGZzd3FLdnBXS1VE?=
 =?utf-8?B?N2Jwbnh2LzdLMWV2QVJmVXQwcTRoUFpCNS9tNk50d3hiNEIvaGloSEUyNHNL?=
 =?utf-8?B?UEFzVW5Fb2ZFTHlsVFdjMDZtNFAxcmMxVS9ZVXgralB2UXUrL2V2RU5ZVjJG?=
 =?utf-8?B?ekdDakg0bkZ5b2FQcWhYQkNJMzBxaHIxMFBNSHhSUFVaR1o3REJjT29SWnRF?=
 =?utf-8?B?UzJscGw3b0Y4MG4vRjE4Z0kzWVc5dkJWZ3E0RFA0NHRZRytEMCtuOXdYT2Fu?=
 =?utf-8?B?WkFrQTJnUC9JS1pHSWNPMm9qZmM4OFBYU1o2NHN3TXZINWJkSXBZaStmMVE0?=
 =?utf-8?B?Zk4rVCtSQmI1T0lmQm5NVzZIME4zUjVwVG1xWlVEMkdiR3laYjlPMEk0UEwv?=
 =?utf-8?Q?DCextT8kDZgRGTxpFNeqaUgEO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c2dfe58-0694-4f31-8237-08dbd3baace8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6660.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 11:24:52.4391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dv46sKz++YfJE+gLoU+6vGvdtolzhTeavURABy61Uv4UhNepb5twV/X4bCHlKR29qGwEC0ImUg0UxDdbJ9Lkew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6469
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 10/22/2023 7:48 PM, David Ahern wrote:
> External email: Use caution opening links or attachments
>
>
> On 10/22/23 1:41 AM, Patrisious Haddad wrote:
>> On 10/19/2023 1:38 PM, Petr Machata wrote:
>>> Patrisious Haddad <phaddad@nvidia.com> writes:
>>>
>>>> @@ -40,6 +45,22 @@ static int sys_show_parse_cb(const struct nlmsghdr
>>>> *nlh, void *data)
>>>>                       mode_str);
>>>>        }
>>>>    +    if (tb[RDMA_NLDEV_SYS_ATTR_PRIVILEGED_QKEY_MODE]) {
>>>> +        const char *pqkey_str;
>>>> +        uint8_t pqkey_mode;
>>>> +
>>>> +        pqkey_mode =
>>>> +
>>>> mnl_attr_get_u8(tb[RDMA_NLDEV_SYS_ATTR_PRIVILEGED_QKEY_MODE]);
>>>> +
>>>> +        if (pqkey_mode < ARRAY_SIZE(privileged_qkey_str))
>>>> +            pqkey_str = privileged_qkey_str[pqkey_mode];
>>>> +        else
>>>> +            pqkey_str = "unknown";
>>>> +
>>>> +        print_color_string(PRINT_ANY, COLOR_NONE, "privileged-qkey",
>>>> +                   "privileged-qkey %s ", pqkey_str);
>>>> +    }
>>>> +
>>> Elsewhere in the file, you just use print_color_on_off(), why not here?
>> The print_color_on_off was used for copy-on-fork which as you see has no
>> set function,
>>
>> I was simply trying to be consistent with this file convention & style,
>> whereas print_color_string was used for the other configurable value
>> ("netns"), I can obviously change that if you all see it as necessary.
>>
>>>>        if (tb[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK])
>>>>            cof = mnl_attr_get_u8(tb[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK]);
>>>>    @@ -111,10 +155,25 @@ static int sys_set_netns_args(struct rd *rd)
>>>>        return sys_set_netns_cmd(rd, cmd);
>>>>    }
>>>>    +static int sys_set_privileged_qkey_args(struct rd *rd)
>>>> +{
>>>> +    bool cmd;
>>>> +
>>>> +    if (rd_no_arg(rd) || !sys_valid_privileged_qkey_cmd(rd_argv(rd))) {
>>>> +        pr_err("valid options are: { on | off }\n");
>>>> +        return -EINVAL;
>>>> +    }
>>> This could use parse_on_off().
>> You are absolutely correct, but just as well was trying to maintain same
>> code style as the previous configurable value we have here, but I think
>> using parse_on_off here can save us some code.
>>>> +
>>>> +    cmd = (strcmp(rd_argv(rd), "on") == 0) ? true : false;
>>>> +
>>>> +    return sys_set_privileged_qkey_cmd(rd, cmd);
>>>> +}
>>>> +
>>>>    static int sys_set_help(struct rd *rd)
>>>>    {
>>>>        pr_out("Usage: %s system set [PARAM] value\n", rd->filename);
>>>>        pr_out("            system set netns { shared | exclusive }\n");
>>>> +    pr_out("            system set privileged-qkey { on | off }\n");
>>>>        return 0;
>>>>    }
>>>>    @@ -124,6 +183,7 @@ static int sys_set(struct rd *rd)
>>>>            { NULL,            sys_set_help },
>>>>            { "help",        sys_set_help },
>>>>            { "netns",        sys_set_netns_args},
>>>> +        { "privileged-qkey",    sys_set_privileged_qkey_args},
>>>>            { 0 }
>>>>        };
>>> The rest of the code looks sane to me, but I'm not familiar with the
>>> feature.
>> If no one else has any comments soon, and these two comments are
>> actually considered critical I can re-send my patches with those issues
>> fixed.
> tools packaged with iproute2 should use common code where possible.

Okay, good point, fixed both comments and sent a V2 , it actually 
resulted in a much cleaner code.

- Thanks.

