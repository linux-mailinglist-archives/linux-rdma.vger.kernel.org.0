Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F8B7CFD8C
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Oct 2023 17:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346174AbjJSPFN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Oct 2023 11:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346215AbjJSPFK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Oct 2023 11:05:10 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16CF12A;
        Thu, 19 Oct 2023 08:05:08 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-357a354e616so2267715ab.1;
        Thu, 19 Oct 2023 08:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697727908; x=1698332708; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9v0UnUfMjecgKqfEffISepiTr1uFTVrtWXV8o/iqOKA=;
        b=FUWhfg5WwE0T6gYovj9FqQrtPky4GInnc+jP9nQQLXUINv6+0LFH1GVEyLs2YN3kEK
         DcDtRlEKcHufFeSU6VJl3f/2CIdTUCxvn6VVipqlKl3hyngDpjOoR7DXAJuAamb6nVKJ
         JfW6RsqmJ3oKrSnfn1iOYe2o+QFGg6J0/m4fLMYrKIHWXWfSYxjGNIsyevFyEc/0j77z
         tZnLJN0He93brcL+dHwpTSLJlFUzM/pPFUqnqjX47gpnT2Ng1PWSr5aZ97EeNiEVQnxS
         Ka1DoginE/Lh0nJ//7f29GwD6DfqbNXPKgPKn/15rXKcpOnNBLtQF6zVLdExrveRUAS0
         46fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697727908; x=1698332708;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9v0UnUfMjecgKqfEffISepiTr1uFTVrtWXV8o/iqOKA=;
        b=YGw4MdoyvAdoWFGz3p+gyQV+18Zo33VcEpZ1yPyb2v6cqAMxDimZyW5MxXF09JUT+o
         AQFVCA0r7ZovYmVbs9PJPZY6JQfgbjIizjjLi91PpI0G5YKDzuUtyvNyWku5oRLI1F3b
         oPScsDIdPPka4cEyIuBewCR2dcPlHTzeiYdnt45pcxwzbHqlJ4mVGmmYofHmDZ6KUMfh
         6FWVHBB66fUCqION+DB+uusA+PUKf7eIg+Uw19tYFqFQwMDZkoJhHpNXzfp57+tV+Ur0
         nVd+Z60bUHgmm90fipwCQMmwEM/2I7WLaStQ9Hja2cBmSl8/sEIUcVzZpeDF6o8G57t2
         6Ryg==
X-Gm-Message-State: AOJu0YxzAo3djm53uMUIJnG3VeErcNnZvYgEZxSc+SDGuRM1K5WlRhI2
        c9OXcf466ph1n2P2r9mSG4g=
X-Google-Smtp-Source: AGHT+IG3xGfvhbKEdThW5GsyWAR8d/qwaop96v+tDuccJSH94C54v63pLlcdcK+sqKq9nW4dxJgGbQ==
X-Received: by 2002:a92:db01:0:b0:351:134d:ce3d with SMTP id b1-20020a92db01000000b00351134dce3dmr1469272iln.7.1697727908139;
        Thu, 19 Oct 2023 08:05:08 -0700 (PDT)
Received: from ?IPV6:2601:282:1e82:2350:80d6:b9fd:f23f:cfa9? ([2601:282:1e82:2350:80d6:b9fd:f23f:cfa9])
        by smtp.googlemail.com with ESMTPSA id h9-20020a92d849000000b003574844cd71sm1851713ilq.25.2023.10.19.08.05.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 08:05:07 -0700 (PDT)
Message-ID: <2c0e946d-eaaf-59f8-2c5a-c47890920c5a@gmail.com>
Date:   Thu, 19 Oct 2023 09:05:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH iproute2-next 2/3] rdma: Add an option to set privileged
 QKEY parameter
Content-Language: en-US
To:     Petr Machata <petrm@nvidia.com>,
        Patrisious Haddad <phaddad@nvidia.com>
Cc:     jgg@ziepe.ca, leon@kernel.org, stephen@networkplumber.org,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        huangjunxian6@hisilicon.com, michaelgur@nvidia.com
References: <20231019082138.18889-1-phaddad@nvidia.com>
 <20231019082138.18889-3-phaddad@nvidia.com> <87il72aiqm.fsf@nvidia.com>
From:   David Ahern <dsahern@gmail.com>
In-Reply-To: <87il72aiqm.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/19/23 4:38 AM, Petr Machata wrote:
> 
> Patrisious Haddad <phaddad@nvidia.com> writes:
> 
>> @@ -40,6 +45,22 @@ static int sys_show_parse_cb(const struct nlmsghdr *nlh, void *data)
>>  				   mode_str);
>>  	}
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
> 
> Elsewhere in the file, you just use print_color_on_off(), why not here?

+1

