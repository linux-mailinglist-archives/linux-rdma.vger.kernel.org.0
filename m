Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2BB7D2212
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Oct 2023 11:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjJVJWm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 22 Oct 2023 05:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVJWl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 22 Oct 2023 05:22:41 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C450CC;
        Sun, 22 Oct 2023 02:22:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOEuY7zwuJbpZbI3PNXtKXmeDAL6UQaYvT0qUwu6XoCLAFCcvOcXyAqCAcdF5FHiSssDgHUl1TQZXGXmEYYrOtCeTOzJ6SbCJKBpIa4/xzm3X+4fPvXCG1v0K5McPyjvNFT81TpoWIxZlExWzMeGfpWMA/fUJfze8Kwx0maJap8rmnFm8mmEOijVxkCG50ACsq6xP2xf13eJwubZGE2W88nVmUR8Ei1UepkgiceeQYwynwzmMOHhj6ipepkE79zz1ld6yv9KWJSCq8q9OmgXVD15FuoC94eJdSUNjL6N0fPonEOzJMOgZMSlYyLVHQOXiKtt0LyJC4eVkbsFwr809w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VyTbXwAcag/aEhdvUmXmc7eeIDUeVhhpHrTmU7Nf5U=;
 b=W73doEQIVB2mIE7yy60PddQ33MK0ooVzXlFWU+Mlao6X3v4Wk38sdh6s7YWRfavq4fiHjvX7wrE5vdjKHxAPk3g18AMoq7DusBLxmZRIS9oVU4bQp3LJs9YKA98vCY7eCJB8KxXqwxpbdgYX1j8N8nq6SNFeKCEqFBgAPbUXNBgBMgdOeyKtfv1gXOlaTMCvKPr6LScK2TYaOqOW2OSpD/dgFo4qG8ueuyuSw5xR3Srz1Vnd+Qz139KG3a+v54LRkrQj+8ACmk5nxSRK2NOSVcBoVoOjyVUgxpCR2QKJtclJfH2A7oB7bkg5TCuVAu3JeMl71Sd+NNsRFJh96JE9sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VyTbXwAcag/aEhdvUmXmc7eeIDUeVhhpHrTmU7Nf5U=;
 b=iNKNCdlg8WmFMLqz9vNUHZ6DncrByAnLECw+YoQPHvPu2Jm4+4BzUM2EgsvFZLXAZFFPbSKkawRaFshfNPNulpZQ/bnXOr3yKrDLXDQcNRMxVbiqebHuLdcbQYoxSOIMb37DP5Qhjg5T68el/oRQpBlVFYPrdM4S6g9igbXyXGBKVAxIFOiwdoCbL0uJgK3RlSsRny0nDQpsFqrmcDx3fJE8YDjAvpFkfk1n0EGqx4CRSehnIeV6jc0hokc0mUcy7kgi8IjctM5u5rVx2qlWbsQvYT2xa6dLnfxd1TJZlhihv37NwI983imL+lc7u5Lz5+JLKL6l/aNhWCVLSgO7VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB6660.namprd12.prod.outlook.com (2603:10b6:510:212::10)
 by IA1PR12MB6458.namprd12.prod.outlook.com (2603:10b6:208:3aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Sun, 22 Oct
 2023 09:22:35 +0000
Received: from PH7PR12MB6660.namprd12.prod.outlook.com
 ([fe80::4ecd:16b8:fd21:7cf4]) by PH7PR12MB6660.namprd12.prod.outlook.com
 ([fe80::4ecd:16b8:fd21:7cf4%7]) with mapi id 15.20.6907.022; Sun, 22 Oct 2023
 09:22:35 +0000
Message-ID: <d1b8b5b4-d9ae-ca88-4372-e62988998634@nvidia.com>
Date:   Sun, 22 Oct 2023 12:22:03 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH iproute2-next 2/3] rdma: Add an option to set privileged
 QKEY parameter
To:     Petr Machata <petrm@nvidia.com>
Cc:     jgg@ziepe.ca, leon@kernel.org, dsahern@gmail.com,
        stephen@networkplumber.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org, huangjunxian6@hisilicon.com,
        michaelgur@nvidia.com
References: <20231019082138.18889-1-phaddad@nvidia.com>
 <20231019082138.18889-3-phaddad@nvidia.com> <87il72aiqm.fsf@nvidia.com>
Content-Language: en-US
From:   Patrisious Haddad <phaddad@nvidia.com>
In-Reply-To: <87il72aiqm.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DO0P289CA0003.QATP289.PROD.OUTLOOK.COM
 (2603:1096:790:20::6) To PH7PR12MB6660.namprd12.prod.outlook.com
 (2603:10b6:510:212::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6660:EE_|IA1PR12MB6458:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ad97df9-dd82-4f9c-fe46-08dbd2e061ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4OAgMRVeRrDU6aKnsWEC/py4O8mvAmLEfs6dRsE6liG6ToXPK3bWPl1XbM+k+lX+LtxEFk/RFPX+WJG+VFc93AtFMGSqx6dEJ4onH1uwBwxXeQPktbFN5ClkUAk9sv/Y20pfwoF+dD21sFkz+WBDYwjgcMnRMimET9A2jw7z8TYiVt4q2Uxu1SxhUKUGm7Bmzur0WLlnphhBHJlOwtkHfDWkDHnMaTJc9V5IOzFN3Wh9+0dDklvssOXsRuDpI4QMh68uudH5RfjJv/2IAhz31xETmpl+GXxNRxtj8trdfxUEyLavZ0afDH36sPIw05SliGoTgYfW+a8dKYhSFzf0gKqNGWWgEpwbKTIeP6OdKUtl0AuQdZ2EzH7CArS7YDGEG/4Pa4CTgSAtUDm6bXD7TTeYbmHIkXP+Eo9xSlrPQa1LTk6FjlQj5+Jee69g1DJl7XiyELV5vgaQKxOn6vsFF8tUveDW7o/w04/601ohoMqkJo5HyqrrpmdOSnZxt2piu9BsctFGHcY2TK9hfmZE4voSE6vc4O3/gVS8EC8enDBow0IN+0qJj+jBrEi6hFHyOC95qr5PfoZWWfwBXHkC4NTST1cAlXrIU0u25dDL79gHUIvIoPKEhJlL9DX+L/bkEtT8fKxwfDVmDndAX6bQZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6660.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(376002)(366004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(26005)(31686004)(38100700002)(83380400001)(5660300002)(37006003)(31696002)(4326008)(316002)(86362001)(8676002)(66946007)(8936002)(6862004)(6636002)(66556008)(66476007)(41300700001)(6486002)(53546011)(6666004)(478600001)(6506007)(2906002)(2616005)(107886003)(36756003)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0tSWXByaFkyTHd6N3czRU1KT2VxUzZmaHhpYXVOK1ZHZnRha1ZpZmhyOUhw?=
 =?utf-8?B?S3lkcERzaXkyRkhpKytvOUNocEdXeEdJQUVLTWFIL0xReDY4YjNFQ3VNMUhx?=
 =?utf-8?B?TWlrOGloSWc1eFJEVFdrSGVvM01lT2NiNVJZcjBFdGZOS1RuaHRQZisra1hQ?=
 =?utf-8?B?RHlLMzU3R3AyeENiNXRoMXZlZ0RHZng4bE5FV2pZa2FzNW9Mc09OZHBxUmg3?=
 =?utf-8?B?V25kQlZ5VXo5SEFzMW0zK0ZJT1ErOU9RYk5LQUxDejRONC9pZmQreTh0QXZx?=
 =?utf-8?B?NkFkaVV3V2czYTFrZW5rejNUQkJ5WW45SzdUS1JLQUJkeVhBckdMZC9NTjBB?=
 =?utf-8?B?U002QzBNOTE1ZDFYd1dndEg4WE5WUS9LWVdTYkIvWjZXMFQxQlpyWTVrckJx?=
 =?utf-8?B?RmtiMGhUbTN0U3dtOU4zczBBMWdVb21Dam9lUGRzVlJYMFZJaCtURHRnakVz?=
 =?utf-8?B?Q1dudEl5UmxCOG9OTkVtQkNOTkpBNUZrV1pCdDVXK1NkUTlCZHRhTmljZ3FI?=
 =?utf-8?B?T01pbnBGUWpiemV2N3U1S3A4ZlNUdjFyYitjZjRVU1BleENDODlGTlRzMHE0?=
 =?utf-8?B?NHlGckZXUmEwQkNTdjZRdnZTOHNaL0ZNOFhCU29uRG1FMkdyUlRrblBxd3Jo?=
 =?utf-8?B?dlN5NHNtUXpidjBFbGtnOHRLVjA3RGRmSWRRcWlaMy9aTkpkNlFJWHBjcnV5?=
 =?utf-8?B?SlBpbGVDSFZXaTFraFc3TnZ6SVlnN1IrU2RCc0R6OGxtKzhKM2x4akZDUFRC?=
 =?utf-8?B?SnpCMWNoZUdXTEt0V1N1RTVaM3orS2NReUNpN3QwMnExQTEzODhZOWYxZllZ?=
 =?utf-8?B?aDR6VnNkQWxmTVNKeWJNZkRTdFlsOTQrZUU5WWZVWFEyUWNWalU5alVsYkZw?=
 =?utf-8?B?K01ZdGR3ZjRVKzE4R1g3S0ZSRW4xdUIwcWdQcEVicElnQ2c3OFNJZW51cVRY?=
 =?utf-8?B?ZW9YU2ZjcFFtcUpvcjVFUnk3T2NvYkRaQU14MmJ3MGQwcVgvMytCTC9qZW4v?=
 =?utf-8?B?bzF0RkpUWVJscVBvRVYvOEZ6bHYzZ2hoWXoycDAxY0hQTXR3UXNyUnBKV3pt?=
 =?utf-8?B?SkdHTkRlcUFLQmRQTXYvTkVlRmpBY3lzZG8xZ292T09aK1o1RVVIcjNZRmd6?=
 =?utf-8?B?eVhxRFN1cC9pRU5kWVFiSFJobUdtQ3Rxd3pOb2dDUjNrTyt0aGZqNW9zU3VB?=
 =?utf-8?B?Zk4zVVB5aU5OSGx4QmNTMTF6NnB3b3NCSlI5WDhTWTA0VWM4b203eWpReW0y?=
 =?utf-8?B?ZHljc2Y5TjBJVmNQcTVXckNWMHkvL251emFPOXNTM2E1ZkZhaDVYenFCQnpW?=
 =?utf-8?B?MGFSSXYxVy9kSmVrTGNCRnhzRVZxL1JVTFJjL0Q0OCs5SHpGZjZsQlhwT0FI?=
 =?utf-8?B?dmxBYnZzdFB5SGNvdXdwNXYyTGs0VE0xaXJxV1JHM2tOeVZ5d1FEZk5EQ1Vt?=
 =?utf-8?B?TzBTZ1JwQ3RPUHZJZlEvM2I1UmdXZXRPdnh2ZUNaWXQ5WG1jTlZlMis1STYz?=
 =?utf-8?B?L3RjL3ZVakVaWk1PYnBlMDlOck1iK091b2s2SHFnVzlkUFV2RGRtOHJudFV2?=
 =?utf-8?B?UlBEeTN6MTBwNlVOWFEzWFhwZzlOS1dDMDVUSCtLVHplRXVxWWtXdFA5Mm1x?=
 =?utf-8?B?bTd3M3I5Z0dHTk41c0FaVlFhYVNUZ21pUXpNZmRCdzJ5dnFNM3VrTTI1MmFr?=
 =?utf-8?B?ZVNVb0ZuRHZ5aUlLYW5zbStzeTcraUpIbndXUUpGTlMrN1hITGxsWDlUQlZD?=
 =?utf-8?B?ZUliVmhOYXAzaXNaU0ZVMXN1RlQyVnh5MlljL21HNEFqdmJybDNvT2hlMlZh?=
 =?utf-8?B?UllFdmFZbVdvbmY0czd5VEdFSVFlZlJpb0xDN09rUGxLY2FLSzVSUUdSaE1Z?=
 =?utf-8?B?WlhWTVhrRndpNURMNU56VG9ERGVGamN5RUZ6S0JiTTF3ZzM2VjQ4SHNrM0F1?=
 =?utf-8?B?ZUlDUktBcVVuTTFvMUJwUVp4S3RwUlE2ZUQ4L0dFYnlia1AwMjhqZmdSNjll?=
 =?utf-8?B?eU5IcVpMTmI5QUJxUnJ3aUNVMlh4TElCRXZBU2JHZHFnMWJPSTd5MVRFWHNF?=
 =?utf-8?B?ZTRlSW9kOXR6RHNkSEJwcmEwTDNHSlJhZDNUaTA5Zm9yOHhzQUhxSXNoaFVU?=
 =?utf-8?Q?9Dfnykk5KWO+4gmeBjf5paf8q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad97df9-dd82-4f9c-fe46-08dbd2e061ba
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6660.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2023 09:22:16.3097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wU0pPh/uEKb1bKRjlWAd0nPB8nAxCx0eQ9sXVcmCPMPIIOJw3PfOZlZ/yNJ1nhFyIGb5jpNxr8ksOpIaEiZh5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6458
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

About this as I previously answered I don't really see a big difference 
between it and "print_color_string" but if the

maintainer thinks this is an essential change I can fix and re-send.

Thanks for the review.

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
More importantly I looked a bit more into it, and I prefer not to use 
it, it would also lead to additional error prints that are not 
consistent with what we previously had for this API, so I prefer to keep 
it as is , so that the error messages for all arguments of this command 
be identical.
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
