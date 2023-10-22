Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00B17D21A7
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Oct 2023 09:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjJVHmW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 22 Oct 2023 03:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVHmU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 22 Oct 2023 03:42:20 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1042D46;
        Sun, 22 Oct 2023 00:42:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XG/4Fq5FPZg3DkYTI9GEkQa2d5MbE2jDtvmm65QR65zfUgLVOo1qOJyan/QGxS0yjHltDH8yP5TjWsZma0tgUlSy+BubQO6eSNLZyg55H48bUQJmrDYt4ewU4RBG91VGpFkHeC330VdtLgnBVD2lXxo8JGhPDPSl+3SasZCQeeSeIcGTJcoL2nWWuT5xGv11hzf84Bu/i+Umsg66n7IBjaAxFucAAj9aTEO2sHpY4QRHLuopufd7gsz8sFf1ve9DoxxlozYaa9fXjxt9PhTRkBR3AR9x7o6L1HRfcs347BZLCvx+KHD+XI11olE6eZ/Pjc9ZyQor8No9t4mm9Q+fmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjwedUKLcn4UDPQBnphl7+OE1AMHJw1grSTKrC8vN6c=;
 b=Vro4O7DY58I4N+M8pRPoqdtdnTtWBMXzgcU1SrVu5u3AR2rWHjaSwJCwz8arxYxn4bwgSAsUOSRMtcyixiaf15SJxalI0xQ5rHRrx2GJMglVPlS9KfjoL5paV9NQ9LVtV8AaGCSk6WpnxjQ8GYQpAlZc05mF0yF60pficvFFpJyf/byjT9lKMngy6v1rBUVIExoGTBkhu0c/wocdWsmPfCpeO2ejvF6cCuLfoHtNe37jnGPB7cJEOEyBleAAxl5vhv2nFL+GI60nUSA1pecQkDYcoV0zI1arcT73S2SPJFYQuhKkDaTtPr86dEnLRnsDVxcCZjfMzFRN9ARz+nHQHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjwedUKLcn4UDPQBnphl7+OE1AMHJw1grSTKrC8vN6c=;
 b=J0xMNYlXc2gnTiPMRpQC5CSS78b+1AVeHKQJzfIuhoRMeoJwGk9brgdYfroOGMHlUirU1/iY8ZOsUYka83tiro0levLZO8psNCsRNYMHa467AbPebI+erSBKavm3vYJF5XzCUQv3Yr7IA02DmWbgwvma0pOqsjhCAK7Dlc/7VzZUtvddeGYMqxAIDL6DBMEMrkKh2whAehH0IZl5RFQ6LfJXxp1bNKnuvuChSE9KCa1P8QR7rHtOTWOkhh0jz4f/OP0gbT/77lTy6JE+0lokWVqKtrE9UR9CL755tDeWSNtSBgw/S2JNAH+TvDvMpyomH/Cf17QgKheCnQnDrx71YA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB6660.namprd12.prod.outlook.com (2603:10b6:510:212::10)
 by PH7PR12MB8825.namprd12.prod.outlook.com (2603:10b6:510:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Sun, 22 Oct
 2023 07:42:11 +0000
Received: from PH7PR12MB6660.namprd12.prod.outlook.com
 ([fe80::4ecd:16b8:fd21:7cf4]) by PH7PR12MB6660.namprd12.prod.outlook.com
 ([fe80::4ecd:16b8:fd21:7cf4%7]) with mapi id 15.20.6907.022; Sun, 22 Oct 2023
 07:42:11 +0000
Message-ID: <c7c9562a-5c6d-eec5-3255-70238a13e96c@nvidia.com>
Date:   Sun, 22 Oct 2023 10:41:56 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH iproute2-next 2/3] rdma: Add an option to set privileged
 QKEY parameter
Content-Language: en-US
To:     Petr Machata <petrm@nvidia.com>
Cc:     jgg@ziepe.ca, leon@kernel.org, dsahern@gmail.com,
        stephen@networkplumber.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org, huangjunxian6@hisilicon.com,
        michaelgur@nvidia.com
References: <20231019082138.18889-1-phaddad@nvidia.com>
 <20231019082138.18889-3-phaddad@nvidia.com> <87il72aiqm.fsf@nvidia.com>
From:   Patrisious Haddad <phaddad@nvidia.com>
In-Reply-To: <87il72aiqm.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DO2P289CA0009.QATP289.PROD.OUTLOOK.COM
 (2603:1096:790:6::14) To PH7PR12MB6660.namprd12.prod.outlook.com
 (2603:10b6:510:212::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6660:EE_|PH7PR12MB8825:EE_
X-MS-Office365-Filtering-Correlation-Id: fe406faf-77c8-4c1c-2fa7-08dbd2d266b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KOqUr/oUlPLUGyFyYp1tucHrd4huZJFpTMms6vAygyw3Ik7ADuDX8J61C1m5E44vwClkXHHeuPQrqOlAyS2pvlxZd5wWz3ZasIqINaCOPOqosH4pQg9aXnDdtwJmh3OrGF8kSR5cxDc3yFd+JvGRZom1Uml1l4yTtZIsdBxl0f3zMQA6aoKuEy9lVLfETj48vqaasqMCNnE+JaNrOgZVrdzvyJShuHprSm7U3mILU0V2NmT5SHlkt3a0oEHZiO8AnwWVYxgmCUUN3aLmhP8W/5op4lf7Z2uDIyXp1alGbUand6qHTG+/wc0xm4tLl76JOu/LFcJoGR0/kQjzAKgPRFjw61fNYxIMj3DZC1S+BbwA2P5HXdzhPBqv9OetbEOigCEckHvb6hbkOEevzdn8mi81Tal9pFgPJUlLkrenPV5d7XBXn5a0/BQGKonIQC09AJjZBIzJ7kFiYaFSy0HoB1gzdNY/k1RWqYLBbR1sgdSwR3b8d/qejXHycSZ0AbbQI9LTS0Mqj0W9TdfhB3lGMGQsZ9QFV5GQRU4qWaMDYNyTGlSRQibmXczJfNgffg7qmoi3r0yYpU8MlpjbJdsBcmmjHwnZq0H8mH//V8gliu/wCi7BppODUmP/nMDOsHY4q0UXzbUeMlUg+cmN6/wBeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6660.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(230922051799003)(451199024)(1800799009)(186009)(6636002)(66946007)(66556008)(508600001)(66476007)(37006003)(6486002)(86362001)(31696002)(36756003)(6666004)(5660300002)(8676002)(8936002)(4326008)(6862004)(38100700002)(53546011)(6512007)(6506007)(2906002)(107886003)(2616005)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zzk1TTc1NFRJS1d0emUxb1A5cWRMSERaWktwdUlYdmxoajdVL3ZXWHFnYmlH?=
 =?utf-8?B?MzZ0am1mbFlmdkREajl0VkJzdkhlVUJETitodC83aXVVTVFzdmtUNUp4Ympa?=
 =?utf-8?B?NDBLMnlvOE90Z2xnZlJmbHFJY0EvamZpcGFQU2ZqM2lpYWcvaUxKdFlzRjg1?=
 =?utf-8?B?WDkzbkxTZXNRczNRa0ZLS2ZwNURWOGRhZ0Q3b1Y0NDdBMkI4VzQvZDd1dld0?=
 =?utf-8?B?cFlXWlZkb2VFR2g1cmZ0MGVVcjB1a2VuZXRjZTVpa1hHRmxwVUkzS0lsSlRm?=
 =?utf-8?B?OVYzWlpsQ01NbHV4clp1LzVJM25ZcExVaHFxSFN6QjdpVXFscXdVeFpLeEpm?=
 =?utf-8?B?RlRVN1BEb2xMY25qdkRSKzlNbHhvcit6Q1gwcndLZUVUQUo3R3pVallCVkgr?=
 =?utf-8?B?SEVGdm10LytMcjlpamxrWStrdFRRYmhvdTlXaGZhaFhZUHdkL01jWTNsZ2Vj?=
 =?utf-8?B?MUdWdWR6aitBSE1tcHNXTGQxM0pwMUY1c1g3Ny8yYkh4NTVHODJKVXNiRTlZ?=
 =?utf-8?B?dlNYL1VWVXV2d3hOcTFPT096K3ZXWVRZTUxkZlZ3cEY4Vm5rQXhGOU5jUkI5?=
 =?utf-8?B?YW1ET1BQSmVKVDMyVzJIZkFrc25nWnVhclkxa0JFRHFaNGQ4TGd4OC9qYVRj?=
 =?utf-8?B?WGVFRi9ycjFqNWhpYUhYMDFXSUFmVy9zRVhTK1ovZ01XVFNmaXgycnh5TzZ0?=
 =?utf-8?B?VXc3OUoxK20rbVkxbkFQSmZKcFFNTXJnQzkrMkpZLzFTSHRxSWIwK0hib2g3?=
 =?utf-8?B?WU5ZbDFNdWI1aG96ZGphWFRpSSs4N2p6YUFOenhDaUpCVitHT0d0cnd4Q3pX?=
 =?utf-8?B?SHdEVnJUaCtxVkdYSmlSMzlodnk2NjFoRllOaEdRellIVFV5aDQrME5yd1ZY?=
 =?utf-8?B?SGkrNkYxNjByd1lGQXdaYWIzTkxRK3QwWXVGeG9NMFdjRlhDcFBUek1pRmlC?=
 =?utf-8?B?VlhabnE0VXhhVnBnNjN0MUlqTExjVHo3NGFBZjZRakJhcG9yNVBPYkxKYzBl?=
 =?utf-8?B?SVlZaWVjR0tMNDNqS3lPV3poMjhKRDhIa2MrY2ZYb2ptN0RJQVkzL3llOTRB?=
 =?utf-8?B?R1pLbjNGbktDaE11NWFWN2tDTloxYmhyQXNIQ2didzVuaFRyWW9DOHVzdEIr?=
 =?utf-8?B?OEs4Z0tqamdSYlZUTUY1Z0h3dzVzbUxXL05VUktXeWx5dUkveERGN3ZWVFoz?=
 =?utf-8?B?VUdhdmJsL05XM1lrK2RhK3h1eXd6VzlSSDl3RHRHSUJobW9DSEtJd3lpOU1n?=
 =?utf-8?B?MDdMZW9LZ0kybkFyd1FkeUNiN3R4clN3SzZuN3U4cUFVbFZTRGs3SGdEa0NJ?=
 =?utf-8?B?Q09PTFNxN1FnZk9qZVVwNyt6b3R5cDhVZitVOWJrZXp1UVR3Zkt3TzZ1Wlg3?=
 =?utf-8?B?RnUrcmFEUzFmSkYxOTdBV29KZW9OTEJYbGIxeVA0d3Z0V1NHTDlrdXp6K0dW?=
 =?utf-8?B?bHpHaWtVSEFiVjVUTUhHRFVoL0Rmd1ROOEY3NDhlSEdGT0NiRUlaQ1B6STY3?=
 =?utf-8?B?am4wUHp1eTVRNDhuYkJFYlYvOUJFV0FuOTBQeFprTEUzRUo3aUtZbVc0VzNG?=
 =?utf-8?B?T0pWQmdsT0RWOExqcUVQMTQzdCtoRW9RWHJKWUtUVHFYcUFIRURyZ0prbnBV?=
 =?utf-8?B?bWljZ1RTRVAzQno1Mi90ak5TQnF1bWtsUDhkMlFJTXl5L0RHWnZsczVlYzJm?=
 =?utf-8?B?eWtuQTBDQUsvQTlxZ2w3bC9zR2djb2o5N0xTaEVSY0FzUGpnTGxlVWo1R0VP?=
 =?utf-8?B?ZThpZ2JEQnRZbzBNdWsrcUJEdGxqMWdJT25oaTVTRUx5ZGJ6bjJ2OHRFcEpX?=
 =?utf-8?B?bnphL0l5OTh5TFVMNFBoY1Q4TlRXYUxXMUdxOGlWRTIvUVloOGt1bUs5K2gx?=
 =?utf-8?B?akhDSC9vMWdqV29pSjRhZXlOS1lWQzRwZGRramtCM1ZWMzRxY3lyUUk4cFBh?=
 =?utf-8?B?SlNxVis0WnFrR2pXMVllVkNuOWd0YitDTnJUWWwzREhUcmphUUEvQUxudGVW?=
 =?utf-8?B?RTQ5S0I1ckpYY2ViZjhKTkx4ZnlJSW9lT3JHemtDalB3ZXMvZE4ybjFFNzl5?=
 =?utf-8?B?K3RlRTdSRDNUakYzQWZTQ2J5UXFFRm5ZRnEvTlg5WmdVSmxVUUQ0RWFsUG5D?=
 =?utf-8?Q?uYicx1BmZAtdLzj5aszhmm+E1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe406faf-77c8-4c1c-2fa7-08dbd2d266b3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6660.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2023 07:42:11.5161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1SX5CFS4Nm9yQr9M8lWoYanBXbiZ9F/BEy7OCfUt1KdZTSv/32qkh+EKXxaM5IeU7oZAU4abnqg5t8oaLIzhqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8825
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 10/19/2023 1:38 PM, Petr Machata wrote:
> Patrisious Haddad <phaddad@nvidia.com> writes:
>
>> @@ -40,6 +45,22 @@ static int sys_show_parse_cb(const struct nlmsghdr *nlh, void *data)
>>   				   mode_str);
>>   	}
>>   
>> +	if (tb[RDMA_NLDEV_SYS_ATTR_PRIVILEGED_QKEY_MODE]) {
>> +		const char *pqkey_str;
>> +		uint8_t pqkey_mode;
>> +
>> +		pqkey_mode =
>> +			mnl_attr_get_u8(tb[RDMA_NLDEV_SYS_ATTR_PRIVILEGED_QKEY_MODE]);
>> +
>> +		if (pqkey_mode < ARRAY_SIZE(privileged_qkey_str))
>> +			pqkey_str = privileged_qkey_str[pqkey_mode];
>> +		else
>> +			pqkey_str = "unknown";
>> +
>> +		print_color_string(PRINT_ANY, COLOR_NONE, "privileged-qkey",
>> +				   "privileged-qkey %s ", pqkey_str);
>> +	}
>> +
> Elsewhere in the file, you just use print_color_on_off(), why not here?

The print_color_on_off was used for copy-on-fork which as you see has no 
set function,

I was simply trying to be consistent with this file convention & style, 
whereas print_color_string was used for the other configurable value 
("netns"), I can obviously change that if you all see it as necessary.

>
>>   	if (tb[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK])
>>   		cof = mnl_attr_get_u8(tb[RDMA_NLDEV_SYS_ATTR_COPY_ON_FORK]);
>>   
>> @@ -111,10 +155,25 @@ static int sys_set_netns_args(struct rd *rd)
>>   	return sys_set_netns_cmd(rd, cmd);
>>   }
>>   
>> +static int sys_set_privileged_qkey_args(struct rd *rd)
>> +{
>> +	bool cmd;
>> +
>> +	if (rd_no_arg(rd) || !sys_valid_privileged_qkey_cmd(rd_argv(rd))) {
>> +		pr_err("valid options are: { on | off }\n");
>> +		return -EINVAL;
>> +	}
> This could use parse_on_off().
You are absolutely correct, but just as well was trying to maintain same 
code style as the previous configurable value we have here, but I think 
using parse_on_off here can save us some code.
>
>> +
>> +	cmd = (strcmp(rd_argv(rd), "on") == 0) ? true : false;
>> +
>> +	return sys_set_privileged_qkey_cmd(rd, cmd);
>> +}
>> +
>>   static int sys_set_help(struct rd *rd)
>>   {
>>   	pr_out("Usage: %s system set [PARAM] value\n", rd->filename);
>>   	pr_out("            system set netns { shared | exclusive }\n");
>> +	pr_out("            system set privileged-qkey { on | off }\n");
>>   	return 0;
>>   }
>>   
>> @@ -124,6 +183,7 @@ static int sys_set(struct rd *rd)
>>   		{ NULL,			sys_set_help },
>>   		{ "help",		sys_set_help },
>>   		{ "netns",		sys_set_netns_args},
>> +		{ "privileged-qkey",	sys_set_privileged_qkey_args},
>>   		{ 0 }
>>   	};
> The rest of the code looks sane to me, but I'm not familiar with the
> feature.
If no one else has any comments soon, and these two comments are 
actually considered critical I can re-send my patches with those issues 
fixed.
